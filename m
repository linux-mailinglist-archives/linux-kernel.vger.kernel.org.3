Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF1353EDD4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiFFSXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiFFSXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:23:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A95106550;
        Mon,  6 Jun 2022 11:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC8F9B81AE6;
        Mon,  6 Jun 2022 18:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012F8C3411E;
        Mon,  6 Jun 2022 18:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654539799;
        bh=CCWdGSU3kQs8AT6sJOhE8/l+ZEj/ZV94RBpO8N3YyrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fx5nRHOpwJ+Yxn+7uRfYUixY+ueMJQJi4ydUr0eSNroY/jQ+D+CGEYzSyLqRqqChH
         3vR4sIj7qlwkRCxzIYPaRH4hizlOcqX7S1vV5vLJkg4C5kUd+0Bb7xvgGrPQbRecZ3
         zCgWcyMCLfZuDuIQf1i28A1DadRoCq4iSNymr5NHppJxy2dXix/DD4RaHyWUoTQJSc
         0dppuhiERnt4QdaZBgw+g2i3gLGFiTAxY4DBp5c51G3iTAgLsBcZFLYiXgOU0fGil5
         nRHzuR/zoa1WM748q6lvlYSeoCIYq86AhYYMbHoTfoYlPXT0YtjS6TnoA2rFLh4be2
         hbDAUzZA/IPUQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 4/6] mm/damon/sysfs: deduplicate inputs applying
Date:   Mon,  6 Jun 2022 18:23:08 +0000
Message-Id: <20220606182310.48781-5-sj@kernel.org>
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

DAMON sysfs interface's DAMON context building and its online parameter
update have duplicated code.  This commit removes the duplicate.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 59 ++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 35 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 8810e6abdb06..c35809c6087c 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2357,6 +2357,23 @@ static inline bool damon_sysfs_kdamond_running(
 		damon_sysfs_ctx_running(kdamond->damon_ctx);
 }
 
+static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
+		struct damon_sysfs_context *sys_ctx)
+{
+	int err;
+
+	err = damon_select_ops(ctx, sys_ctx->ops_id);
+	if (err)
+		return err;
+	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
+	if (err)
+		return err;
+	err = damon_sysfs_set_targets(ctx, sys_ctx->targets);
+	if (err)
+		return err;
+	return damon_sysfs_set_schemes(ctx, sys_ctx->schemes);
+}
+
 /*
  * damon_sysfs_commit_input() - Commit user inputs to a running kdamond.
  * @kdamond:	The kobject wrapper for the associated kdamond.
@@ -2365,31 +2382,14 @@ static inline bool damon_sysfs_kdamond_running(
  */
 static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 {
-	struct damon_ctx *ctx = kdamond->damon_ctx;
-	struct damon_sysfs_context *sys_ctx;
-	int err = 0;
-
 	if (!damon_sysfs_kdamond_running(kdamond))
 		return -EINVAL;
 	/* TODO: Support multiple contexts per kdamond */
 	if (kdamond->contexts->nr != 1)
 		return -EINVAL;
 
-	sys_ctx = kdamond->contexts->contexts_arr[0];
-
-	err = damon_select_ops(ctx, sys_ctx->ops_id);
-	if (err)
-		return err;
-	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
-	if (err)
-		return err;
-	err = damon_sysfs_set_targets(ctx, sys_ctx->targets);
-	if (err)
-		return err;
-	err = damon_sysfs_set_schemes(ctx, sys_ctx->schemes);
-	if (err)
-		return err;
-	return err;
+	return damon_sysfs_apply_inputs(kdamond->damon_ctx,
+			kdamond->contexts->contexts_arr[0]);
 }
 
 /*
@@ -2436,27 +2436,16 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
-	err = damon_select_ops(ctx, sys_ctx->ops_id);
-	if (err)
-		goto out;
-	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
-	if (err)
-		goto out;
-	err = damon_sysfs_set_targets(ctx, sys_ctx->targets);
-	if (err)
-		goto out;
-	err = damon_sysfs_set_schemes(ctx, sys_ctx->schemes);
-	if (err)
-		goto out;
+	err = damon_sysfs_apply_inputs(ctx, sys_ctx);
+	if (err) {
+		damon_destroy_ctx(ctx);
+		return ERR_PTR(err);
+	}
 
 	ctx->callback.after_wmarks_check = damon_sysfs_cmd_request_callback;
 	ctx->callback.after_aggregation = damon_sysfs_cmd_request_callback;
 	ctx->callback.before_terminate = damon_sysfs_before_terminate;
 	return ctx;
-
-out:
-	damon_destroy_ctx(ctx);
-	return ERR_PTR(err);
 }
 
 static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
-- 
2.25.1

