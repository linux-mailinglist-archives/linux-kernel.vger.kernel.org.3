Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060184F8F84
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiDHH0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiDHH0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:26:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D54E3693B5;
        Fri,  8 Apr 2022 00:24:40 -0700 (PDT)
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KZV9j1XTQz1HBfb;
        Fri,  8 Apr 2022 15:24:09 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 15:24:38 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 8 Apr
 2022 15:24:37 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <yukuai3@huawei.com>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next RFC v2 1/8] sbitmap: record the number of waiters for each waitqueue
Date:   Fri, 8 Apr 2022 15:39:09 +0800
Message-ID: <20220408073916.1428590-2-yukuai3@huawei.com>
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

Add a counter in struct sbq_wait_stat to recored how many threads are
waiting on the waitqueue, this will be used in later patches to make
sure 8 waitqueues are balanced. Such counter will also be shown in
debugfs so that user can see if waitqueues are balanced.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 include/linux/sbitmap.h | 5 +++++
 lib/sbitmap.c           | 7 +++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 8f5a86e210b9..8a64271d0696 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -91,6 +91,11 @@ struct sbq_wait_state {
 	 */
 	atomic_t wait_cnt;
 
+	/**
+	 * @waiters_cnt: Number of active waiters
+	 */
+	atomic_t waiters_cnt;
+
 	/**
 	 * @wait: Wait queue.
 	 */
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index ae4fd4de9ebe..393f2b71647a 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -444,6 +444,7 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		init_waitqueue_head(&sbq->ws[i].wait);
 		atomic_set(&sbq->ws[i].wait_cnt, sbq->wake_batch);
+		atomic_set(&sbq->ws[i].waiters_cnt, 0);
 	}
 
 	return 0;
@@ -759,9 +760,9 @@ void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m)
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[i];
 
-		seq_printf(m, "\t{.wait_cnt=%d, .wait=%s},\n",
+		seq_printf(m, "\t{.wait_cnt=%d, .waiters_cnt=%d},\n",
 			   atomic_read(&ws->wait_cnt),
-			   waitqueue_active(&ws->wait) ? "active" : "inactive");
+			   atomic_read(&ws->waiters_cnt));
 	}
 	seq_puts(m, "}\n");
 
@@ -798,6 +799,7 @@ void sbitmap_prepare_to_wait(struct sbitmap_queue *sbq,
 {
 	if (!sbq_wait->sbq) {
 		atomic_inc(&sbq->ws_active);
+		atomic_inc(&ws->waiters_cnt);
 		sbq_wait->sbq = sbq;
 	}
 	prepare_to_wait_exclusive(&ws->wait, &sbq_wait->wait, state);
@@ -810,6 +812,7 @@ void sbitmap_finish_wait(struct sbitmap_queue *sbq, struct sbq_wait_state *ws,
 	finish_wait(&ws->wait, &sbq_wait->wait);
 	if (sbq_wait->sbq) {
 		atomic_dec(&sbq->ws_active);
+		atomic_dec(&ws->waiters_cnt);
 		sbq_wait->sbq = NULL;
 	}
 }
-- 
2.31.1

