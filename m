Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC814F8F8F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiDHH1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiDHH0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:26:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24C036A468;
        Fri,  8 Apr 2022 00:24:44 -0700 (PDT)
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZV8K4MVNzgYYr;
        Fri,  8 Apr 2022 15:22:57 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 15:24:42 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 8 Apr
 2022 15:24:42 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <yukuai3@huawei.com>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next RFC v2 8/8] sbitmap: wake up the number of threads based on required tags
Date:   Fri, 8 Apr 2022 15:39:16 +0800
Message-ID: <20220408073916.1428590-9-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220408073916.1428590-1-yukuai3@huawei.com>
References: <20220408073916.1428590-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always wake up 'wake_batch' threads will intensify competition and
split io won't be issued continuously. Now that how many tags is required
is recorded for huge io, it's safe to wake up baed on required tags.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/sbitmap.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 8d01e02ea4b1..eac9fa5c2b4d 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -614,6 +614,26 @@ static inline void sbq_update_preemption(struct sbitmap_queue *sbq,
 	WRITE_ONCE(sbq->force_tag_preemption, force);
 }
 
+static unsigned int get_wake_nr(struct sbq_wait_state *ws, unsigned int nr_tags)
+{
+	struct sbq_wait *wait;
+	struct wait_queue_entry *entry;
+	unsigned int nr = 1;
+
+	spin_lock_irq(&ws->wait.lock);
+	list_for_each_entry(entry, &ws->wait.head, entry) {
+		wait = container_of(entry, struct sbq_wait, wait);
+		if (nr_tags <= wait->nr_tags)
+			break;
+
+		nr++;
+		nr_tags -= wait->nr_tags;
+	}
+	spin_unlock_irq(&ws->wait.lock);
+
+	return nr;
+}
+
 static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 {
 	struct sbq_wait_state *ws;
@@ -648,7 +668,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 	smp_mb__before_atomic();
 	atomic_set(&ws->wait_cnt, wake_batch);
 	sbq_update_preemption(sbq, wake_batch);
-	wake_up_nr(&ws->wait, wake_batch);
+	wake_up_nr(&ws->wait, get_wake_nr(ws, wake_batch));
 
 	return true;
 }
-- 
2.31.1

