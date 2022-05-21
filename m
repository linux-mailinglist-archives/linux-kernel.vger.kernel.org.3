Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F59A52F98C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 09:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354709AbiEUHV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 03:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240747AbiEUHVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 03:21:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF3E4D278;
        Sat, 21 May 2022 00:21:48 -0700 (PDT)
Received: from kwepemi100020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L4w1j1LrqzQk7F;
        Sat, 21 May 2022 15:18:49 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100020.china.huawei.com (7.221.188.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 15:21:46 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 21 May
 2022 15:21:45 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v2 3/6] block, bfq: factor out code to update 'active_entities'
Date:   Sat, 21 May 2022 15:35:20 +0800
Message-ID: <20220521073523.3118246-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521073523.3118246-1-yukuai3@huawei.com>
References: <20220521073523.3118246-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code is a bit ugly and hard to read.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-wf2q.c | 61 +++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 2f3fb45a32c3..c58568a4b009 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -230,6 +230,26 @@ static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
 		bfqq->bfqd->num_groups_with_busy_queues--;
 }
 
+static void bfq_inc_active_entities(struct bfq_entity *entity)
+{
+	struct bfq_sched_data *sd = entity->sched_data;
+	struct bfq_group *bfqg = container_of(sd, struct bfq_group, sched_data);
+	struct bfq_data *bfqd = (struct bfq_data *)bfqg->bfqd;
+
+	if (bfqg != bfqd->root_group)
+		bfqg->active_entities++;
+}
+
+static void bfq_dec_active_entities(struct bfq_entity *entity)
+{
+	struct bfq_sched_data *sd = entity->sched_data;
+	struct bfq_group *bfqg = container_of(sd, struct bfq_group, sched_data);
+	struct bfq_data *bfqd = (struct bfq_data *)bfqg->bfqd;
+
+	if (bfqg != bfqd->root_group)
+		bfqg->active_entities--;
+}
+
 #else /* CONFIG_BFQ_GROUP_IOSCHED */
 
 static bool bfq_update_parent_budget(struct bfq_entity *next_in_service)
@@ -250,6 +270,14 @@ static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
 {
 }
 
+static void bfq_inc_active_entities(struct bfq_entity *entity)
+{
+}
+
+static void bfq_dec_active_entities(struct bfq_entity *entity)
+{
+}
+
 #endif /* CONFIG_BFQ_GROUP_IOSCHED */
 
 /*
@@ -476,11 +504,6 @@ static void bfq_active_insert(struct bfq_service_tree *st,
 {
 	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 	struct rb_node *node = &entity->rb_node;
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	struct bfq_sched_data *sd = NULL;
-	struct bfq_group *bfqg = NULL;
-	struct bfq_data *bfqd = NULL;
-#endif
 
 	bfq_insert(&st->active, entity);
 
@@ -491,17 +514,10 @@ static void bfq_active_insert(struct bfq_service_tree *st,
 
 	bfq_update_active_tree(node);
 
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	sd = entity->sched_data;
-	bfqg = container_of(sd, struct bfq_group, sched_data);
-	bfqd = (struct bfq_data *)bfqg->bfqd;
-#endif
 	if (bfqq)
 		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	if (bfqg != bfqd->root_group)
-		bfqg->active_entities++;
-#endif
+
+	bfq_inc_active_entities(entity);
 }
 
 /**
@@ -578,29 +594,16 @@ static void bfq_active_extract(struct bfq_service_tree *st,
 {
 	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 	struct rb_node *node;
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	struct bfq_sched_data *sd = NULL;
-	struct bfq_group *bfqg = NULL;
-	struct bfq_data *bfqd = NULL;
-#endif
 
 	node = bfq_find_deepest(&entity->rb_node);
 	bfq_extract(&st->active, entity);
 
 	if (node)
 		bfq_update_active_tree(node);
-
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	sd = entity->sched_data;
-	bfqg = container_of(sd, struct bfq_group, sched_data);
-	bfqd = (struct bfq_data *)bfqg->bfqd;
-#endif
 	if (bfqq)
 		list_del(&bfqq->bfqq_list);
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	if (bfqg != bfqd->root_group)
-		bfqg->active_entities--;
-#endif
+
+	bfq_dec_active_entities(entity);
 }
 
 /**
-- 
2.31.1

