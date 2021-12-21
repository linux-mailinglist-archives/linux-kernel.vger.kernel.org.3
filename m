Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65F747BEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbhLUL1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:27:18 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30085 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbhLUL1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:27:15 -0500
Received: from kwepemi500005.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JJDcP2l3cz1DK73;
        Tue, 21 Dec 2021 19:24:05 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500005.china.huawei.com (7.221.188.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 19:27:12 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 21 Dec
 2021 19:27:12 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <gregkh@linuxfoundation.org>,
        <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH linux-4.19.y 2/5] block, bfq: fix asymmetric scenarios detection
Date:   Tue, 21 Dec 2021 19:38:46 +0800
Message-ID: <20211221113849.2219126-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211221113849.2219126-1-yukuai3@huawei.com>
References: <20211221113849.2219126-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Federico Motta <federico@willer.it>

commit 98fa7a3e001b21fb47c08af4304f40a3b0535cbd upstream.

Since commit 2d29c9f89fcd ("block, bfq: improve asymmetric scenarios
detection"), a scenario is defined asymmetric when one of the
following conditions holds:
- active bfq_queues have different weights
- one or more group of entities (bfq_queue or other groups of entities)
  are active
bfq grants fairness and low latency also in such asymmetric scenarios,
by plugging the dispatching of I/O if the bfq_queue in service happens
to be temporarily idle. This plugging may lower throughput, so it is
important to do it only when strictly needed.

By mistake, in commit '2d29c9f89fcd' ("block, bfq: improve asymmetric
scenarios detection") the num_active_groups counter was firstly
incremented and subsequently decremented at any entity (group or
bfq_queue) weight change.

This is useless, because only transitions from active to inactive and
vice versa matter for that counter. Unfortunately this is also
incorrect in the following case: the entity at issue is a bfq_queue
and it is under weight raising. In fact in this case there is a
spurious increment of the num_active_groups counter.

This spurious increment may cause scenarios to be wrongly detected as
asymmetric, thus causing useless plugging and loss of throughput.

This commit fixes this issue by simply removing the above useless and
wrong increments and decrements.

Fixes: 2d29c9f89fcd ("block, bfq: improve asymmetric scenarios detection")
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Federico Motta <federico@willer.it>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-wf2q.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 476b5a90a5a4..4b0d5fb69160 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -792,24 +792,18 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		 * queue, remove the entity from its old weight counter (if
 		 * there is a counter associated with the entity).
 		 */
-		if (prev_weight != new_weight) {
-			if (bfqq) {
-				root = &bfqd->queue_weights_tree;
-				__bfq_weights_tree_remove(bfqd, bfqq, root);
-			} else
-				bfqd->num_active_groups--;
+		if (prev_weight != new_weight && bfqq) {
+			root = &bfqd->queue_weights_tree;
+			__bfq_weights_tree_remove(bfqd, bfqq, root);
 		}
 		entity->weight = new_weight;
 		/*
 		 * Add the entity, if it is not a weight-raised queue,
 		 * to the counter associated with its new weight.
 		 */
-		if (prev_weight != new_weight) {
-			if (bfqq && bfqq->wr_coeff == 1) {
-				/* If we get here, root has been initialized. */
-				bfq_weights_tree_add(bfqd, bfqq, root);
-			} else
-				bfqd->num_active_groups++;
+		if (prev_weight != new_weight && bfqq && bfqq->wr_coeff == 1) {
+			/* If we get here, root has been initialized. */
+			bfq_weights_tree_add(bfqd, bfqq, root);
 		}
 
 		new_st->wsum += entity->weight;
-- 
2.31.1

