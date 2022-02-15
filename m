Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6CA4B77D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243217AbiBOSrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:47:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbiBOSqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:46:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9392B1B6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:46:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12B316170B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038BBC340F0;
        Tue, 15 Feb 2022 18:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644950799;
        bh=J+/bpGm3lTH1Ktih/oN6HbFk1NsW/aVwU2dOCH+/7hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rTpTlusUV59/WKzrzSfzptjo4wxPLJu3K0qDipJ9Ri/WlR/V9lPG6nQDb+3bMImIw
         G0J4C7wX1De6/t9gV1gBdDPB3+q2NBFjwi0TjTvgiOs50bMWgS2rlFiAcUMunddFqo
         zjyI6ReiaCTcbY3SfDk7p0hTrtWbJ3KcXakcSqriroW7PtAJcaw9FWg3Wgmj/dBKGH
         xIiWEzYI32c+WBRiBw3TyxPQeKd84Cp9JhPPpZvc690MWNQGr18BzFAQWSTIBbLw+n
         hLz1Ce6uInO/iGru+i23tHlN4v8Pz1K0xCBvwQn4H6kPJGB20fmOkOxRanIkHmrGAH
         SpwLXtjHusapQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     xhao@linux.alibaba.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/8] mm/damon: Let monitoring operations can be registered and selected
Date:   Tue, 15 Feb 2022 18:45:57 +0000
Message-Id: <20220215184603.1479-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215184603.1479-1-sj@kernel.org>
References: <20220215184603.1479-1-sj@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In-kernel DAMON user code like DAMON debugfs interface should set
'struct damon_operations' of its 'struct damon_ctx' on its own.
Therefore, the client code should depend on all supporting monitoring
operations implementations that it could use.  For example, DAMON
debugfs interface depends on both vaddr and paddr, while some of the
users are not always interested in both.

To minimize such unnecessary dependencies, this commit makes the
monitoring operations can be registered by implementing code and
then dynamically selected by the user code without build-time
dependency.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 18 ++++++++++++
 mm/damon/core.c       | 66 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 00baeb42c18e..076da277b249 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -253,11 +253,24 @@ struct damos {
 	struct list_head list;
 };
 
+/**
+ * enum damon_ops_id - Identifier for each monitoring operations implementation
+ *
+ * @DAMON_OPS_VADDR:	Monitoring operations for virtual address spaces
+ * @DAMON_OPS_PADDR:	Monitoring operations for the physical address space
+ */
+enum damon_ops_id {
+	DAMON_OPS_VADDR,
+	DAMON_OPS_PADDR,
+	NR_DAMON_OPS,
+};
+
 struct damon_ctx;
 
 /**
  * struct damon_operations - Monitoring operations for given use cases.
  *
+ * @id:				Identifier of this operations set.
  * @init:			Initialize operations-related data structures.
  * @update:			Update operations-related data structures.
  * @prepare_access_checks:	Prepare next access check of target regions.
@@ -277,6 +290,8 @@ struct damon_ctx;
  * &damon_ctx.sample_interval.  Finally, @reset_aggregated is called after each
  * &damon_ctx.aggr_interval.
  *
+ * Each &struct damon_operations instance having valid @id can be registered
+ * via damon_register_ops() and selected by damon_select_ops() later.
  * @init should initialize operations-related data structures.  For example,
  * this could be used to construct proper monitoring target regions and link
  * those to @damon_ctx.adaptive_targets.
@@ -301,6 +316,7 @@ struct damon_ctx;
  * @cleanup is called from @kdamond just before its termination.
  */
 struct damon_operations {
+	enum damon_ops_id id;
 	void (*init)(struct damon_ctx *context);
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
@@ -489,6 +505,8 @@ int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 int damon_set_schemes(struct damon_ctx *ctx,
 			struct damos **schemes, ssize_t nr_schemes);
 int damon_nr_running_ctxs(void);
+int damon_register_ops(struct damon_operations *ops);
+int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id);
 
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index be93fb1c3473..82e0a4620c4f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -25,6 +25,72 @@
 static DEFINE_MUTEX(damon_lock);
 static int nr_running_ctxs;
 
+static DEFINE_MUTEX(damon_ops_lock);
+static struct damon_operations damon_registered_ops[NR_DAMON_OPS];
+
+/* Should be called under damon_ops_lock with id smaller than NR_DAMON_OPS */
+static bool damon_registered_ops_id(enum damon_ops_id id)
+{
+	struct damon_operations empty_ops = {};
+
+	if (!memcmp(&empty_ops, &damon_registered_ops[id], sizeof(empty_ops)))
+		return false;
+	return true;
+}
+
+/**
+ * damon_register_ops() - Register a monitoring operations set to DAMON.
+ * @ops:	monitoring operations set to register.
+ *
+ * This function registers a monitoring operations set of valid &struct
+ * damon_operations->id so that others can find and use them later.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_register_ops(struct damon_operations *ops)
+{
+	int err = 0;
+
+	if (ops->id >= NR_DAMON_OPS)
+		return -EINVAL;
+	mutex_lock(&damon_ops_lock);
+	/* Fail for already registered ops */
+	if (damon_registered_ops_id(ops->id)) {
+		err = -EINVAL;
+		goto out;
+	}
+	damon_registered_ops[ops->id] = *ops;
+out:
+	mutex_unlock(&damon_ops_lock);
+	return err;
+}
+
+/**
+ * damon_select_ops() - Select a monitoring operations to use with the context.
+ * @ctx:	monitoring context to use the operations.
+ * @id:		id of the registered monitoring operations to select.
+ *
+ * This function finds registered monitoring operations set of @id and make
+ * @ctx to use it.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
+{
+	int err = 0;
+
+	if (id >= NR_DAMON_OPS)
+		return -EINVAL;
+
+	mutex_lock(&damon_ops_lock);
+	if (!damon_registered_ops_id(id))
+		err = -EINVAL;
+	else
+		ctx->ops = damon_registered_ops[id];
+	mutex_unlock(&damon_ops_lock);
+	return err;
+}
+
 /*
  * Construct a damon_region struct
  *
-- 
2.17.1

