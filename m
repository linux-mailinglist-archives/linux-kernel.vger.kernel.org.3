Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11EA474345
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhLNNPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:15:51 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28316 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbhLNNPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:15:50 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JCzQB0p1QzbjN4;
        Tue, 14 Dec 2021 21:15:30 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 21:15:47 +0800
Received: from huawei.com (10.175.124.27) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 14 Dec
 2021 21:15:47 +0800
From:   Laibin Qiu <qiulaibin@huawei.com>
To:     <ming.lei@redhat.com>, <hch@infradead.org>, <axboe@kernel.dk>
CC:     <yi.zhang@huawei.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 -next] block/wbt: fix negative inflight counter when remove scsi device
Date:   Tue, 14 Dec 2021 21:31:03 +0800
Message-ID: <20211214133103.551813-1-qiulaibin@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we disable wbt by set WBT_STATE_OFF_DEFAULT in
wbt_disable_default() when switch elevator to bfq. And when
we remove scsi device, wbt will be enabled by wbt_enable_default.
If it become false positive between wbt_wait() and wbt_track()
when submit write request.

The following is the scenario that triggered the problem.

T1                          T2                           T3
                            elevator_switch_mq
                            bfq_init_queue
                            wbt_disable_default <= Set
                            rwb->enable_state (OFF)
Submit_bio
blk_mq_make_request
rq_qos_throttle
<= rwb->enable_state (OFF)
                                                         scsi_remove_device
                                                         sd_remove
                                                         del_gendisk
                                                         blk_unregister_queue
                                                         elv_unregister_queue
                                                         wbt_enable_default
                                                         <= Set rwb->enable_state (ON)
q_qos_track
<= rwb->enable_state (ON)
^^^^^^ this request will mark WBT_TRACKED without inflight add and will
lead to drop rqw->inflight to -1 in wbt_done() which will trigger IO hung.

Fix this by move wbt_enable_default() from elv_unregister to
bfq_exit_queue(). Only re-enable wbt when bfq exit.
Fixes: 76a8040817b4b ("blk-wbt: make sure throttle is enabled properly")
Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
---
 block/bfq-iosched.c | 4 ++++
 block/elevator.c    | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0c612a911696..8b7524450835 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6996,6 +6996,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 {
 	struct bfq_data *bfqd = e->elevator_data;
 	struct bfq_queue *bfqq, *n;
+	struct request_queue *q = bfqd->queue;
 
 	hrtimer_cancel(&bfqd->idle_slice_timer);
 
@@ -7019,6 +7020,9 @@ static void bfq_exit_queue(struct elevator_queue *e)
 #endif
 
 	kfree(bfqd);
+
+	/* Re-enable throttling in case elevator disabled it */
+	wbt_enable_default(q);
 }
 
 static void bfq_init_root_group(struct bfq_group *root_group,
diff --git a/block/elevator.c b/block/elevator.c
index ec98aed39c4f..482df2a350fc 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -525,8 +525,6 @@ void elv_unregister_queue(struct request_queue *q)
 		kobject_del(&e->kobj);
 
 		e->registered = 0;
-		/* Re-enable throttling in case elevator disabled it */
-		wbt_enable_default(q);
 	}
 }
 
-- 
2.22.0

