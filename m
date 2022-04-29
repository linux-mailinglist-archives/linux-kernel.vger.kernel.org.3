Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0E251505C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378895AbiD2QKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378837AbiD2QJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:09:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC494B42CE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48967622BD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53B2C385B5;
        Fri, 29 Apr 2022 16:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651248382;
        bh=Cv+X7Zdka2XOX7Mgz9T3y/uOxQEoK1knJUHHmSETKsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OeUWgT8Bebj61lLMzYOybudEYAPP416ZFwi2by3/sqdXehXM8B3PR+EgS0ElzydKm
         ltvsnJ+sVutojuyVzT2lT3qRrSdu6Pt61+ittcHfkCIMc5hzw7H5r4ncXI6r6QSZ8b
         d7Zi9aRrAQVXX6VMPvLejfhjtRGtYNt9zU/wDOOtHmiK9EDzFf/rBPSWOZMKQJnpA3
         SBvNrVDZ3aXHO4G/dxIRuR2k1VNpkSgd5PQ33DenBsUpt4K+eRk2kgvEExNzArueRt
         LE3TK3L5g39O2wCMnmxZfagNnaCWA57qO24mahionexdjEIiIfZlcCuUKEnqfPh9g7
         R9s6LEdO6JOTA==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 11/14] mm/damon/sysfs: support online inputs update
Date:   Fri, 29 Apr 2022 16:06:03 +0000
Message-Id: <20220429160606.127307-12-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429160606.127307-1-sj@kernel.org>
References: <20220429160606.127307-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

Currently, DAMON sysfs interface doesn't provide a way for adjusting
DAMON input parameters while it is turned on.  Therefore, users who want
to reconfigure DAMON need to stop DAMON and restart.  This means all the
monitoring results that accumulated so far, which could be useful,
should be flushed.  This would be inefficient for many cases.

For an example, let's suppose a sysadmin was running a DAMON-based
Operation Scheme to find memory regions not accessed for more than 5
mins and page out the regions.  If it turns out the 5 mins threshold was
too long and therefore the sysadmin wants to reduce it to 4 mins, the
sysadmin should turn off DAMON, restart it, and wait for at least 4 more
minutes so that DAMON can find the cold memory regions, even though
DAMON was knowing there are regions that not accessed for 4 mins at the
time of shutdown.

This commit makes DAMON sysfs interface to support online DAMON input
parameters updates by adding a new input keyword for the 'state' DAMON
sysfs file, 'commit'.  Writing the keyword to the 'state' file while the
corresponding kdamond is running makes the kdamond to read the sysfs
file values again and update the DAMON context.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 99 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 9 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 864a215ff809..23030611ae7d 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2061,6 +2061,8 @@ enum damon_sysfs_cmd {
 	DAMON_SYSFS_CMD_ON,
 	/* @DAMON_SYSFS_CMD_OFF: Turn the kdamond off. */
 	DAMON_SYSFS_CMD_OFF,
+	/* @DAMON_SYSFS_CMD_COMMIT: Update kdamond inputs. */
+	DAMON_SYSFS_CMD_COMMIT,
 	/*
 	 * @DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS: Update scheme stats sysfs
 	 * files.
@@ -2076,6 +2078,7 @@ enum damon_sysfs_cmd {
 static const char * const damon_sysfs_cmd_strs[] = {
 	"on",
 	"off",
+	"commit",
 	"update_schemes_stats",
 };
 
@@ -2194,6 +2197,39 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 	return err;
 }
 
+/*
+ * Search a target in a context that corresponds to the sysfs target input.
+ *
+ * Return: pointer to the target if found, NULL if not found, or negative
+ * error code if the search failed.
+ */
+static struct damon_target *damon_sysfs_existing_target(
+		struct damon_sysfs_target *sys_target, struct damon_ctx *ctx)
+{
+	struct pid *pid;
+	struct damon_target *t;
+
+	if (ctx->ops.id == DAMON_OPS_PADDR) {
+		/* Up to only one target for paddr could exist */
+		damon_for_each_target(t, ctx)
+			return t;
+		return NULL;
+	}
+
+	/* ops.id should be DAMON_OPS_VADDR or DAMON_OPS_FVADDR */
+	pid = find_get_pid(sys_target->pid);
+	if (!pid)
+		return ERR_PTR(-EINVAL);
+	damon_for_each_target(t, ctx) {
+		if (t->pid == pid) {
+			put_pid(pid);
+			return t;
+		}
+	}
+	put_pid(pid);
+	return NULL;
+}
+
 static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 		struct damon_sysfs_targets *sysfs_targets)
 {
@@ -2204,8 +2240,15 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 		return -EINVAL;
 
 	for (i = 0; i < sysfs_targets->nr; i++) {
-		err = damon_sysfs_add_target(
-				sysfs_targets->targets_arr[i], ctx);
+		struct damon_sysfs_target *st = sysfs_targets->targets_arr[i];
+		struct damon_target *t = damon_sysfs_existing_target(st, ctx);
+
+		if (IS_ERR(t))
+			return PTR_ERR(t);
+		if (!t)
+			err = damon_sysfs_add_target(st, ctx);
+		else
+			err = damon_sysfs_set_regions(t, st->regions);
 		if (err)
 			return err;
 	}
@@ -2308,6 +2351,48 @@ static int damon_sysfs_upd_schemes_stats(struct damon_sysfs_kdamond *kdamond)
 	return 0;
 }
 
+static inline bool damon_sysfs_kdamond_running(
+		struct damon_sysfs_kdamond *kdamond)
+{
+	return kdamond->damon_ctx &&
+		damon_sysfs_ctx_running(kdamond->damon_ctx);
+}
+
+/*
+ * damon_sysfs_commit_input() - Commit user inputs to a running kdamond.
+ * @kdamond:	The kobject wrapper for the associated kdamond.
+ *
+ * If the sysfs input is wrong, the kdamond will be terminated.
+ */
+static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
+{
+	struct damon_ctx *ctx = kdamond->damon_ctx;
+	struct damon_sysfs_context *sys_ctx;
+	int err = 0;
+
+	if (!damon_sysfs_kdamond_running(kdamond))
+		return -EINVAL;
+	/* TODO: Support multiple contexts per kdamond */
+	if (kdamond->contexts->nr != 1)
+		return -EINVAL;
+
+	sys_ctx = kdamond->contexts->contexts_arr[0];
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
+	err = damon_sysfs_set_schemes(ctx, sys_ctx->schemes);
+	if (err)
+		return err;
+	return err;
+}
+
 /*
  * damon_sysfs_cmd_request_callback() - DAMON callback for handling requests.
  * @c:	The DAMON context of the callback.
@@ -2330,6 +2415,9 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS:
 		err = damon_sysfs_upd_schemes_stats(kdamond);
 		break;
+	case DAMON_SYSFS_CMD_COMMIT:
+		err = damon_sysfs_commit_input(kdamond);
+		break;
 	default:
 		break;
 	}
@@ -2414,13 +2502,6 @@ static int damon_sysfs_turn_damon_off(struct damon_sysfs_kdamond *kdamond)
 	 */
 }
 
-static inline bool damon_sysfs_kdamond_running(
-		struct damon_sysfs_kdamond *kdamond)
-{
-	return kdamond->damon_ctx &&
-		damon_sysfs_ctx_running(kdamond->damon_ctx);
-}
-
 /*
  * damon_sysfs_handle_cmd() - Handle a command for a specific kdamond.
  * @cmd:	The command to handle.
-- 
2.25.1

