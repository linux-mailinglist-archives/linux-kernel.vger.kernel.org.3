Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD884EAA89
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiC2J3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbiC2J1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:27:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12112986EA;
        Tue, 29 Mar 2022 02:26:01 -0700 (PDT)
Received: from kwepemi500001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KSPK1431gzfYyL;
        Tue, 29 Mar 2022 17:24:21 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500001.china.huawei.com (7.221.188.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 17:25:59 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 29 Mar
 2022 17:25:58 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <andriy.shevchenko@linux.intel.com>,
        <john.garry@huawei.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next RFC 4/6] sbitmap: wake up the number of threads based on required tags
Date:   Tue, 29 Mar 2022 17:40:46 +0800
Message-ID: <20220329094048.2107094-5-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220329094048.2107094-1-yukuai3@huawei.com>
References: <20220329094048.2107094-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Currently, __sbq_wake_up() will wake up 'wake_batch' threads
unconditionally, for split io this will intensify competition and split
io won't be issued sequentially.

This modification can optimize the ratio of sequentially for split
big io, however, in order to gain optimal result, tag preemption still
need to be disabled, which will be done in later patches.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/sbitmap.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index ae4fd4de9ebe..9d04c0ecc8f7 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -597,6 +597,26 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 	return NULL;
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
@@ -628,7 +648,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 		ret = atomic_cmpxchg(&ws->wait_cnt, wait_cnt, wake_batch);
 		if (ret == wait_cnt) {
 			sbq_index_atomic_inc(&sbq->wake_index);
-			wake_up_nr(&ws->wait, wake_batch);
+			wake_up_nr(&ws->wait, get_wake_nr(ws, wake_batch));
 			return false;
 		}
 
-- 
2.31.1

