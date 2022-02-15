Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1496A4B787E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243247AbiBOSrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:47:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243203AbiBOSqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:46:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017182B275
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:46:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 940B0616C7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39A6C340F0;
        Tue, 15 Feb 2022 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644950803;
        bh=ZZVHYN24fbtWtWWxo9X93JAX+d6Sbd/BNMAjo9TCEWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NP7XJ7FkCwxUTWQFFr763Xtt20093Awuy17twpkb6nJw41/4NqPIacyVL3hmU9ByF
         HLplaSE6hcS3hvIeCzj8RXP1ZZzMAH0w6RBU1YjjVYtrlA/tQvIXXC2OYEgsqrUYBD
         luJAySzM/57YBSdNpiJxftfZK+sHD1iojcD+aLviUHRiqEtiw4sFUj9AlWw4/rnjTM
         bL0jMZBAX/6fa48/U9i50bIRB/FHXStFnWvsyWomDlByrr/7LbyLV/iyWPMftAJM7w
         4FhnO1a6V5DrOKWxdqVFsGDy2sfU40wMTnn5EBkS36vsjFFfzIhPOYQ+MzBUok5IjX
         mXRhL+P7mArqA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     xhao@linux.alibaba.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 8/8] mm/damon/paddr,vaddr: Remove damon_{p,v}a_{target_valid,set_operations}()
Date:   Tue, 15 Feb 2022 18:46:03 +0000
Message-Id: <20220215184603.1479-9-sj@kernel.org>
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

Because DAMON debugfs interface and DAMON-based proactive reclaim are
now using monitoring operations via registration mechanism,
damon_{p,v}a_{target_valid,set_operations}() functions have no user.
This commit clean them up.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 10 ----------
 mm/damon/paddr.c      | 20 +-------------------
 mm/damon/vaddr.c      | 15 +--------------
 3 files changed, 2 insertions(+), 43 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 076da277b249..49c4a11ecf20 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -513,14 +513,4 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 
 #endif	/* CONFIG_DAMON */
 
-#ifdef CONFIG_DAMON_VADDR
-bool damon_va_target_valid(void *t);
-void damon_va_set_operations(struct damon_ctx *ctx);
-#endif	/* CONFIG_DAMON_VADDR */
-
-#ifdef CONFIG_DAMON_PADDR
-bool damon_pa_target_valid(void *t);
-void damon_pa_set_operations(struct damon_ctx *ctx);
-#endif	/* CONFIG_DAMON_PADDR */
-
 #endif	/* _DAMON_H */
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index d968bb38bd5d..7c263797a9a9 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -208,11 +208,6 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
-bool damon_pa_target_valid(void *t)
-{
-	return true;
-}
-
 static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme)
@@ -261,19 +256,6 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 	return DAMOS_MAX_SCORE;
 }
 
-void damon_pa_set_operations(struct damon_ctx *ctx)
-{
-	ctx->ops.init = NULL;
-	ctx->ops.update = NULL;
-	ctx->ops.prepare_access_checks = damon_pa_prepare_access_checks;
-	ctx->ops.check_accesses = damon_pa_check_accesses;
-	ctx->ops.reset_aggregated = NULL;
-	ctx->ops.target_valid = damon_pa_target_valid;
-	ctx->ops.cleanup = NULL;
-	ctx->ops.apply_scheme = damon_pa_apply_scheme;
-	ctx->ops.get_scheme_score = damon_pa_scheme_score;
-}
-
 static int __init damon_pa_initcall(void)
 {
 	struct damon_operations ops = {
@@ -283,7 +265,7 @@ static int __init damon_pa_initcall(void)
 		.prepare_access_checks = damon_pa_prepare_access_checks,
 		.check_accesses = damon_pa_check_accesses,
 		.reset_aggregated = NULL,
-		.target_valid = damon_pa_target_valid,
+		.target_valid = NULL,
 		.cleanup = NULL,
 		.apply_scheme = damon_pa_apply_scheme,
 		.get_scheme_score = damon_pa_scheme_score,
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 87475ba37bec..b2ec0aa1ff45 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -653,7 +653,7 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
  * Functions for the target validity check and cleanup
  */
 
-bool damon_va_target_valid(void *target)
+static bool damon_va_target_valid(void *target)
 {
 	struct damon_target *t = target;
 	struct task_struct *task;
@@ -739,19 +739,6 @@ static int damon_va_scheme_score(struct damon_ctx *context,
 	return DAMOS_MAX_SCORE;
 }
 
-void damon_va_set_operations(struct damon_ctx *ctx)
-{
-	ctx->ops.init = damon_va_init;
-	ctx->ops.update = damon_va_update;
-	ctx->ops.prepare_access_checks = damon_va_prepare_access_checks;
-	ctx->ops.check_accesses = damon_va_check_accesses;
-	ctx->ops.reset_aggregated = NULL;
-	ctx->ops.target_valid = damon_va_target_valid;
-	ctx->ops.cleanup = NULL;
-	ctx->ops.apply_scheme = damon_va_apply_scheme;
-	ctx->ops.get_scheme_score = damon_va_scheme_score;
-}
-
 static int __init damon_va_initcall(void)
 {
 	struct damon_operations ops = {
-- 
2.17.1

