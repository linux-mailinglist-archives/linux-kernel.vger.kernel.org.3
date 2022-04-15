Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237BE5027B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352046AbiDOJ7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351950AbiDOJ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:59:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A609BA330;
        Fri, 15 Apr 2022 02:56:32 -0700 (PDT)
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KfsCX31jBz1HBp9;
        Fri, 15 Apr 2022 17:55:52 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 17:56:30 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 15 Apr
 2022 17:56:29 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>, <qiulaibin@huawei.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next RFC v3 8/8] sbitmap: wake up the number of threads based on required tags
Date:   Fri, 15 Apr 2022 18:10:53 +0800
Message-ID: <20220415101053.554495-9-yukuai3@huawei.com>
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

Now that split bios are forced to preemt tag, however, they are unlikely
to get tags continuously because 'wake_batch' threads are woke up each
time while there are only 'wake_batch' tags available.

Since it can be known in advance how many tags are required for huge io,
it's safe to wake up based on required tags, because it can be sure that
wakers will use up 'wake_batch' tags.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/sbitmap.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 315e5619b384..5ac5ad1b4b1e 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -633,6 +633,32 @@ static inline void sbq_update_preemption(struct sbitmap_queue *sbq,
 		true : false;
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
+		if (nr_tags <= wait->nr_tags) {
+			nr_tags = 0;
+			break;
+		}
+
+		nr++;
+		nr_tags -= wait->nr_tags;
+	}
+	spin_unlock_irq(&ws->wait.lock);
+
+	/*
+	 * If nr_tags is not 0, additional wakeup is triggered to fix the race
+	 * that new threads are waited before wake_up_nr() is called.
+	 */
+	return nr + nr_tags;
+}
+
 static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 {
 	struct sbq_wait_state *ws;
@@ -672,7 +698,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 	smp_mb__before_atomic();
 	atomic_set(&ws->wait_cnt, wake_batch);
 	sbq_update_preemption(sbq, wake_batch);
-	wake_up_nr(&ws->wait, wake_batch);
+	wake_up_nr(&ws->wait, get_wake_nr(ws, wake_batch));
 
 	return false;
 }
-- 
2.31.1

