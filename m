Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3267D5027B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351983AbiDOJ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351936AbiDOJ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:58:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A096FB91B5;
        Fri, 15 Apr 2022 02:56:27 -0700 (PDT)
Received: from kwepemi100009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KfsB22gv0zgYtr;
        Fri, 15 Apr 2022 17:54:34 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100009.china.huawei.com (7.221.188.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 17:56:25 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 15 Apr
 2022 17:56:24 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>, <qiulaibin@huawei.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next RFC v3 1/8] sbitmap: record the number of waiters for each waitqueue
Date:   Fri, 15 Apr 2022 18:10:46 +0800
Message-ID: <20220415101053.554495-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220415101053.554495-1-yukuai3@huawei.com>
References: <20220415101053.554495-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
index ae4fd4de9ebe..a5105ce6d424 100644
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
 
@@ -797,6 +798,7 @@ void sbitmap_prepare_to_wait(struct sbitmap_queue *sbq,
 			     struct sbq_wait *sbq_wait, int state)
 {
 	if (!sbq_wait->sbq) {
+		atomic_inc(&ws->waiters_cnt);
 		atomic_inc(&sbq->ws_active);
 		sbq_wait->sbq = sbq;
 	}
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

