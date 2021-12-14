Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30724473BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhLNE1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:27:46 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15729 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhLNE1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:27:45 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JCldn35J4zZcFJ;
        Tue, 14 Dec 2021 12:24:45 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 12:27:43 +0800
Received: from huawei.com (10.175.124.27) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 14 Dec
 2021 12:27:42 +0800
From:   Laibin Qiu <qiulaibin@huawei.com>
To:     <hch@infradead.org>, <axboe@kernel.dk>
CC:     <yi.zhang@huawei.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next] block/wbt: fix negative inflight counter when remove scsi device
Date:   Tue, 14 Dec 2021 12:42:59 +0800
Message-ID: <20211214044259.2656456-1-qiulaibin@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
elevator_switch_mq. Only re-enable wbt when scheduler switch.
Fixes: 76a8040817b4b ("blk-wbt: make sure throttle is enabled properly")
Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
---
 block/elevator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index ec98aed39c4f..de3cf1fa52fa 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -525,8 +525,6 @@ void elv_unregister_queue(struct request_queue *q)
 		kobject_del(&e->kobj);
 
 		e->registered = 0;
-		/* Re-enable throttling in case elevator disabled it */
-		wbt_enable_default(q);
 	}
 }
 
@@ -593,8 +591,11 @@ int elevator_switch_mq(struct request_queue *q,
 	lockdep_assert_held(&q->sysfs_lock);
 
 	if (q->elevator) {
-		if (q->elevator->registered)
+		if (q->elevator->registered) {
 			elv_unregister_queue(q);
+			/* Re-enable throttling in case elevator disabled it */
+			wbt_enable_default(q);
+		}
 
 		ioc_clear_queue(q);
 		blk_mq_sched_free_rqs(q);
-- 
2.22.0

