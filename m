Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F30A47BEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbhLUL1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:27:21 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15956 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbhLUL1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:27:16 -0500
Received: from kwepemi500004.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JJDcP6SPgzZdTs;
        Tue, 21 Dec 2021 19:24:05 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500004.china.huawei.com (7.221.188.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 19:27:13 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 21 Dec
 2021 19:27:12 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <gregkh@linuxfoundation.org>,
        <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH linux-4.19.y 3/5] block, bfq: fix decrement of num_active_groups
Date:   Tue, 21 Dec 2021 19:38:47 +0800
Message-ID: <20211221113849.2219126-4-yukuai3@huawei.com>
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

From: Paolo Valente <paolo.valente@linaro.org>

commit ba7aeae5539c7a7cccc4cf07a2bc61281a93c50e upstream.

Since commit '2d29c9f89fcd ("block, bfq: improve asymmetric scenarios
detection")', if there are process groups with I/O requests waiting for
completion, then BFQ tags the scenario as 'asymmetric'. This detection
is needed for preserving service guarantees (for details, see comments
on the computation * of the variable asymmetric_scenario in the
function bfq_better_to_idle).

Unfortunately, commit '2d29c9f89fcd ("block, bfq: improve asymmetric
scenarios detection")' contains an error exactly in the updating of
the number of groups with I/O requests waiting for completion: if a
group has more than one descendant process, then the above number of
groups, which is renamed from num_active_groups to a more appropriate
num_groups_with_pending_reqs by this commit, may happen to be wrongly
decremented multiple times, namely every time one of the descendant
processes gets all its pending I/O requests completed.

A correct, complete solution should work as follows. Consider a group
that is inactive, i.e., that has no descendant process with pending
I/O inside BFQ queues. Then suppose that num_groups_with_pending_reqs
is still accounting for this group, because the group still has some
descendant process with some I/O request still in
flight. num_groups_with_pending_reqs should be decremented when the
in-flight request of the last descendant process is finally completed
(assuming that nothing else has changed for the group in the meantime,
in terms of composition of the group and active/inactive state of
child groups and processes). To accomplish this, an additional
pending-request counter must be added to entities, and must be
updated correctly.

To avoid this additional field and operations, this commit resorts to
the following tradeoff between simplicity and accuracy: for an
inactive group that is still counted in num_groups_with_pending_reqs,
this commit decrements num_groups_with_pending_reqs when the first
descendant process of the group remains with no request waiting for
completion.

This simplified scheme provides a fix to the unbalanced decrements
introduced by 2d29c9f89fcd. Since this error was also caused by lack
of comments on this non-trivial issue, this commit also adds related
comments.

Fixes: 2d29c9f89fcd ("block, bfq: improve asymmetric scenarios detection")
Reported-by: Steven Barrett <steven@liquorix.net>
Tested-by: Steven Barrett <steven@liquorix.net>
Tested-by: Lucjan Lucjanov <lucjan.lucjanov@gmail.com>
Reviewed-by: Federico Motta <federico@willer.it>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 76 ++++++++++++++++++++++++++++++++-------------
 block/bfq-iosched.h | 51 ++++++++++++++++++++++++++++--
 block/bfq-wf2q.c    |  5 ++-
 3 files changed, 107 insertions(+), 25 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a21151c1e245..d5daf6e05771 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -639,7 +639,7 @@ static bool bfq_varied_queue_weights_or_active_groups(struct bfq_data *bfqd)
 		 bfqd->queue_weights_tree.rb_node->rb_right)
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	       ) ||
-		(bfqd->num_active_groups > 0
+		(bfqd->num_groups_with_pending_reqs > 0
 #endif
 	       );
 }
@@ -803,7 +803,21 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 			 */
 			break;
 		}
-		bfqd->num_active_groups--;
+
+		/*
+		 * The decrement of num_groups_with_pending_reqs is
+		 * not performed immediately upon the deactivation of
+		 * entity, but it is delayed to when it also happens
+		 * that the first leaf descendant bfqq of entity gets
+		 * all its pending requests completed. The following
+		 * instructions perform this delayed decrement, if
+		 * needed. See the comments on
+		 * num_groups_with_pending_reqs for details.
+		 */
+		if (entity->in_groups_with_pending_reqs) {
+			entity->in_groups_with_pending_reqs = false;
+			bfqd->num_groups_with_pending_reqs--;
+		}
 	}
 }
 
@@ -3544,27 +3558,44 @@ static bool bfq_better_to_idle(struct bfq_queue *bfqq)
 	 * fact, if there are active groups, then, for condition (i)
 	 * to become false, it is enough that an active group contains
 	 * more active processes or sub-groups than some other active
-	 * group. We address this issue with the following bi-modal
-	 * behavior, implemented in the function
+	 * group. More precisely, for condition (i) to hold because of
+	 * such a group, it is not even necessary that the group is
+	 * (still) active: it is sufficient that, even if the group
+	 * has become inactive, some of its descendant processes still
+	 * have some request already dispatched but still waiting for
+	 * completion. In fact, requests have still to be guaranteed
+	 * their share of the throughput even after being
+	 * dispatched. In this respect, it is easy to show that, if a
+	 * group frequently becomes inactive while still having
+	 * in-flight requests, and if, when this happens, the group is
+	 * not considered in the calculation of whether the scenario
+	 * is asymmetric, then the group may fail to be guaranteed its
+	 * fair share of the throughput (basically because idling may
+	 * not be performed for the descendant processes of the group,
+	 * but it had to be).  We address this issue with the
+	 * following bi-modal behavior, implemented in the function
 	 * bfq_symmetric_scenario().
 	 *
-	 * If there are active groups, then the scenario is tagged as
+	 * If there are groups with requests waiting for completion
+	 * (as commented above, some of these groups may even be
+	 * already inactive), then the scenario is tagged as
 	 * asymmetric, conservatively, without checking any of the
 	 * conditions (i) and (ii). So the device is idled for bfqq.
 	 * This behavior matches also the fact that groups are created
-	 * exactly if controlling I/O (to preserve bandwidth and
-	 * latency guarantees) is a primary concern.
+	 * exactly if controlling I/O is a primary concern (to
+	 * preserve bandwidth and latency guarantees).
 	 *
-	 * On the opposite end, if there are no active groups, then
-	 * only condition (i) is actually controlled, i.e., provided
-	 * that condition (i) holds, idling is not performed,
-	 * regardless of whether condition (ii) holds. In other words,
-	 * only if condition (i) does not hold, then idling is
-	 * allowed, and the device tends to be prevented from queueing
-	 * many requests, possibly of several processes. Since there
-	 * are no active groups, then, to control condition (i) it is
-	 * enough to check whether all active queues have the same
-	 * weight.
+	 * On the opposite end, if there are no groups with requests
+	 * waiting for completion, then only condition (i) is actually
+	 * controlled, i.e., provided that condition (i) holds, idling
+	 * is not performed, regardless of whether condition (ii)
+	 * holds. In other words, only if condition (i) does not hold,
+	 * then idling is allowed, and the device tends to be
+	 * prevented from queueing many requests, possibly of several
+	 * processes. Since there are no groups with requests waiting
+	 * for completion, then, to control condition (i) it is enough
+	 * to check just whether all the queues with requests waiting
+	 * for completion also have the same weight.
 	 *
 	 * Not checking condition (ii) evidently exposes bfqq to the
 	 * risk of getting less throughput than its fair share.
@@ -3622,10 +3653,11 @@ static bool bfq_better_to_idle(struct bfq_queue *bfqq)
 	 * bfqq is weight-raised is checked explicitly here. More
 	 * precisely, the compound condition below takes into account
 	 * also the fact that, even if bfqq is being weight-raised,
-	 * the scenario is still symmetric if all active queues happen
-	 * to be weight-raised. Actually, we should be even more
-	 * precise here, and differentiate between interactive weight
-	 * raising and soft real-time weight raising.
+	 * the scenario is still symmetric if all queues with requests
+	 * waiting for completion happen to be
+	 * weight-raised. Actually, we should be even more precise
+	 * here, and differentiate between interactive weight raising
+	 * and soft real-time weight raising.
 	 *
 	 * As a side note, it is worth considering that the above
 	 * device-idling countermeasures may however fail in the
@@ -5447,7 +5479,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->idle_slice_timer.function = bfq_idle_slice_timer;
 
 	bfqd->queue_weights_tree = RB_ROOT;
-	bfqd->num_active_groups = 0;
+	bfqd->num_groups_with_pending_reqs = 0;
 
 	INIT_LIST_HEAD(&bfqd->active_list);
 	INIT_LIST_HEAD(&bfqd->idle_list);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index e9960727cb56..746bd570b85a 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -196,6 +196,9 @@ struct bfq_entity {
 
 	/* flag, set to request a weight, ioprio or ioprio_class change  */
 	int prio_changed;
+
+	/* flag, set if the entity is counted in groups_with_pending_reqs */
+	bool in_groups_with_pending_reqs;
 };
 
 struct bfq_group;
@@ -448,10 +451,54 @@ struct bfq_data {
 	 * bfq_weights_tree_[add|remove] for further details).
 	 */
 	struct rb_root queue_weights_tree;
+
 	/*
-	 * number of groups with requests still waiting for completion
+	 * Number of groups with at least one descendant process that
+	 * has at least one request waiting for completion. Note that
+	 * this accounts for also requests already dispatched, but not
+	 * yet completed. Therefore this number of groups may differ
+	 * (be larger) than the number of active groups, as a group is
+	 * considered active only if its corresponding entity has
+	 * descendant queues with at least one request queued. This
+	 * number is used to decide whether a scenario is symmetric.
+	 * For a detailed explanation see comments on the computation
+	 * of the variable asymmetric_scenario in the function
+	 * bfq_better_to_idle().
+	 *
+	 * However, it is hard to compute this number exactly, for
+	 * groups with multiple descendant processes. Consider a group
+	 * that is inactive, i.e., that has no descendant process with
+	 * pending I/O inside BFQ queues. Then suppose that
+	 * num_groups_with_pending_reqs is still accounting for this
+	 * group, because the group has descendant processes with some
+	 * I/O request still in flight. num_groups_with_pending_reqs
+	 * should be decremented when the in-flight request of the
+	 * last descendant process is finally completed (assuming that
+	 * nothing else has changed for the group in the meantime, in
+	 * terms of composition of the group and active/inactive state of child
+	 * groups and processes). To accomplish this, an additional
+	 * pending-request counter must be added to entities, and must
+	 * be updated correctly. To avoid this additional field and operations,
+	 * we resort to the following tradeoff between simplicity and
+	 * accuracy: for an inactive group that is still counted in
+	 * num_groups_with_pending_reqs, we decrement
+	 * num_groups_with_pending_reqs when the first descendant
+	 * process of the group remains with no request waiting for
+	 * completion.
+	 *
+	 * Even this simpler decrement strategy requires a little
+	 * carefulness: to avoid multiple decrements, we flag a group,
+	 * more precisely an entity representing a group, as still
+	 * counted in num_groups_with_pending_reqs when it becomes
+	 * inactive. Then, when the first descendant queue of the
+	 * entity remains with no request waiting for completion,
+	 * num_groups_with_pending_reqs is decremented, and this flag
+	 * is reset. After this flag is reset for the entity,
+	 * num_groups_with_pending_reqs won't be decremented any
+	 * longer in case a new descendant queue of the entity remains
+	 * with no request waiting for completion.
 	 */
-	unsigned int num_active_groups;
+	unsigned int num_groups_with_pending_reqs;
 
 	/*
 	 * Number of bfq_queues containing requests (including the
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 4b0d5fb69160..63e0f12be7c9 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1012,7 +1012,10 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 			container_of(entity, struct bfq_group, entity);
 		struct bfq_data *bfqd = bfqg->bfqd;
 
-		bfqd->num_active_groups++;
+		if (!entity->in_groups_with_pending_reqs) {
+			entity->in_groups_with_pending_reqs = true;
+			bfqd->num_groups_with_pending_reqs++;
+		}
 	}
 #endif
 
-- 
2.31.1

