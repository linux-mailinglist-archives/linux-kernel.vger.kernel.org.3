Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB58567DE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 07:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiGFFg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 01:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiGFFgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 01:36:23 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60EB221832;
        Tue,  5 Jul 2022 22:36:22 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id CF4A51E80D40;
        Wed,  6 Jul 2022 13:34:09 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id azf0dByZUBnt; Wed,  6 Jul 2022 13:34:07 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id A40581E80CDE;
        Wed,  6 Jul 2022 13:34:06 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] block: remove unnecessary type castings
Date:   Wed,  6 Jul 2022 13:35:29 +0800
Message-Id: <20220706053529.15952-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type castings.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 block/bfq-wf2q.c   | 6 +++---
 block/blk-iocost.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index f8eb340381cf..2a666b100bcb 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -474,7 +474,7 @@ static void bfq_active_insert(struct bfq_service_tree *st,
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	sd = entity->sched_data;
 	bfqg = container_of(sd, struct bfq_group, sched_data);
-	bfqd = (struct bfq_data *)bfqg->bfqd;
+	bfqd = bfqg->bfqd;
 #endif
 	if (bfqq)
 		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
@@ -573,7 +573,7 @@ static void bfq_active_extract(struct bfq_service_tree *st,
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	sd = entity->sched_data;
 	bfqg = container_of(sd, struct bfq_group, sched_data);
-	bfqd = (struct bfq_data *)bfqg->bfqd;
+	bfqd = bfqg->bfqd;
 #endif
 	if (bfqq)
 		list_del(&bfqq->bfqq_list);
@@ -719,7 +719,7 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		else {
 			sd = entity->my_sched_data;
 			bfqg = container_of(sd, struct bfq_group, sched_data);
-			bfqd = (struct bfq_data *)bfqg->bfqd;
+			bfqd = bfqg->bfqd;
 		}
 #endif
 
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 33a11ba971ea..117181a69b7a 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1430,7 +1430,7 @@ static int iocg_wake_fn(struct wait_queue_entry *wq_entry, unsigned mode,
 			int flags, void *key)
 {
 	struct iocg_wait *wait = container_of(wq_entry, struct iocg_wait, wait);
-	struct iocg_wake_ctx *ctx = (struct iocg_wake_ctx *)key;
+	struct iocg_wake_ctx *ctx = key;
 	u64 cost = abs_cost_to_cost(wait->abs_cost, ctx->hw_inuse);
 
 	ctx->vbudget -= cost;
-- 
2.11.0

