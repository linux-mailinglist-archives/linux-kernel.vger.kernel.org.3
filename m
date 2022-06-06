Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A315953EDD0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiFFSX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiFFSXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:23:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22551059EB;
        Mon,  6 Jun 2022 11:23:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AD8961336;
        Mon,  6 Jun 2022 18:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C168C3411F;
        Mon,  6 Jun 2022 18:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654539798;
        bh=FkFezzlzmy/eW3w7W+oLzp/buOO/S8XlonrJ1RecW3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVEWXita9mYJJ2bVaGpCS8bj2zYum/t5ksZrhBCbTdiUFJwA05V3as07feHg4NS7a
         +9lMHIBhu6jn/lIXBvmo6s5o9TdcSq9Erw55hjV256YgPLgvsgLTYvfIHadZoUNBY0
         CEYo69rXCNH1PkU/bxjVibK/UHzKX+3iRzOe9OPq0oGPKa3fgyon7meXQog2YAXw8l
         gLcap2cfCMDnOo7WZRUZtOup/OL4O+N+hFK7T2bhKal26nIHrVhejWyRtSMgFRySDR
         /ksMIXtCK5b04ErkqJ+Ge3iJAZaybikV8w1qMU4V8GhL7oWfzeaXaBjfaSszjJvr3I
         XocTbLGXOBiCg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/6] mm/damon/{dbgfs,sysfs}: move target_has_pid() from dbgfs to damon.h
Date:   Mon,  6 Jun 2022 18:23:06 +0000
Message-Id: <20220606182310.48781-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606182310.48781-1-sj@kernel.org>
References: <20220606182310.48781-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function for knowing if given monitoring context's targets will have
pid or not is defined and used in dbgfs only.  However, the logic is
also needed for sysfs.  This commit moves the code to damon.h and makes
both dbgfs and sysfs to use it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  6 ++++++
 mm/damon/dbgfs.c      | 15 +++++----------
 mm/damon/sysfs.c      |  8 +++-----
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 2765c7d99beb..b9aae19fab3e 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -525,6 +525,12 @@ bool damon_is_registered_ops(enum damon_ops_id id);
 int damon_register_ops(struct damon_operations *ops);
 int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id);
 
+static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
+{
+	return ctx->ops.id == DAMON_OPS_VADDR || ctx->ops.id == DAMON_OPS_FVADDR;
+}
+
+
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index a0dab8b5e45f..5ae810927309 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -275,11 +275,6 @@ static ssize_t dbgfs_schemes_write(struct file *file, const char __user *buf,
 	return ret;
 }
 
-static inline bool target_has_pid(const struct damon_ctx *ctx)
-{
-	return ctx->ops.id == DAMON_OPS_VADDR;
-}
-
 static ssize_t sprint_target_ids(struct damon_ctx *ctx, char *buf, ssize_t len)
 {
 	struct damon_target *t;
@@ -288,7 +283,7 @@ static ssize_t sprint_target_ids(struct damon_ctx *ctx, char *buf, ssize_t len)
 	int rc;
 
 	damon_for_each_target(t, ctx) {
-		if (target_has_pid(ctx))
+		if (damon_target_has_pid(ctx))
 			/* Show pid numbers to debugfs users */
 			id = pid_vnr(t->pid);
 		else
@@ -415,7 +410,7 @@ static int dbgfs_set_targets(struct damon_ctx *ctx, ssize_t nr_targets,
 	struct damon_target *t, *next;
 
 	damon_for_each_target_safe(t, next, ctx) {
-		if (target_has_pid(ctx))
+		if (damon_target_has_pid(ctx))
 			put_pid(t->pid);
 		damon_destroy_target(t);
 	}
@@ -425,11 +420,11 @@ static int dbgfs_set_targets(struct damon_ctx *ctx, ssize_t nr_targets,
 		if (!t) {
 			damon_for_each_target_safe(t, next, ctx)
 				damon_destroy_target(t);
-			if (target_has_pid(ctx))
+			if (damon_target_has_pid(ctx))
 				dbgfs_put_pids(pids, nr_targets);
 			return -ENOMEM;
 		}
-		if (target_has_pid(ctx))
+		if (damon_target_has_pid(ctx))
 			t->pid = pids[i];
 		damon_add_target(ctx, t);
 	}
@@ -722,7 +717,7 @@ static void dbgfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
 
-	if (!target_has_pid(ctx))
+	if (!damon_target_has_pid(ctx))
 		return;
 
 	mutex_lock(&ctx->kdamond_lock);
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 09f9e8ca3d1f..8810e6abdb06 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2136,8 +2136,7 @@ static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
 	struct damon_target *t, *next;
 
 	damon_for_each_target_safe(t, next, ctx) {
-		if (ctx->ops.id == DAMON_OPS_VADDR ||
-				ctx->ops.id == DAMON_OPS_FVADDR)
+		if (damon_target_has_pid(ctx))
 			put_pid(t->pid);
 		damon_destroy_target(t);
 	}
@@ -2181,8 +2180,7 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 
 	if (!t)
 		return -ENOMEM;
-	if (ctx->ops.id == DAMON_OPS_VADDR ||
-			ctx->ops.id == DAMON_OPS_FVADDR) {
+	if (damon_target_has_pid(ctx)) {
 		t->pid = find_get_pid(sys_target->pid);
 		if (!t->pid)
 			goto destroy_targets_out;
@@ -2210,7 +2208,7 @@ static struct damon_target *damon_sysfs_existing_target(
 	struct pid *pid;
 	struct damon_target *t;
 
-	if (ctx->ops.id == DAMON_OPS_PADDR) {
+	if (!damon_target_has_pid(ctx)) {
 		/* Up to only one target for paddr could exist */
 		damon_for_each_target(t, ctx)
 			return t;
-- 
2.25.1

