Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2FC515066
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378876AbiD2QKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378838AbiD2QJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:09:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3E5B0D2A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B1CC622BB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F372AC385A4;
        Fri, 29 Apr 2022 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651248381;
        bh=pERtiBDbvFtqilzCGI/nn4ljoMv39JzOAcDfxJCU3w8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNgdfdoFP/uoQGtI3Dp0VeJmSHjob35uUkEmHqbCcIk1kF/MzRn/EGg4zR3pjDUd6
         kp2NiMyEJbLeXZyi3vLfNJ7vXnRMAhYmlsDtJLv3sxJL22vjgTEFixaeuYyFy3xp0u
         zIUzjSi+HewyS2GIkY/Djyn55PHiqhR00W4XuJpWakrqnnvDOhaknWs2qrKAe+SbX2
         jLnjtt2mv59dcW5oRPXgYlx6o9lGIeuYMnG6tcZouaBPu0dvpcU6g5+QpWviOSHjSB
         M9J49ZzhFSzrVSZKNl2wlAnpCyO0DelojKpqhz7Hcsn7Q/McwwfO7ggPfu4mx/J1rY
         sIFBps8xLgpLA==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 10/14] mm/damon/sysfs: update schemes stat in the kdamond context
Date:   Fri, 29 Apr 2022 16:06:02 +0000
Message-Id: <20220429160606.127307-11-sj@kernel.org>
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

Only '->kdamond' and '->kdamond_stop' are protected by 'kdamond_lock' of
'struct damon_ctx'.  All other DAMON context internal data items are
recommended to be accessed in DAMON callbacks, or under some additional
synchronizations.  But, DAMON sysfs is accessing the schemes stat under
'kdamond_lock'.

It makes no big issue as the read values are not used anywhere inside
kernel, but would better to be fixed.  This commit moves the reads to
DAMON callback context, as supposed to be used for the purpose.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 161 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 135 insertions(+), 26 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 460af481189a..864a215ff809 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2079,6 +2079,25 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"update_schemes_stats",
 };
 
+/*
+ * struct damon_sysfs_cmd_request - A request to the DAMON callback.
+ * @cmd:	The command that needs to be handled by the callback.
+ * @kdamond:	The kobject wrapper that associated to the kdamond thread.
+ *
+ * This structure represents a sysfs command request that need to access some
+ * DAMON context-internal data.  Because DAMON context-internal data can be
+ * safely accessed from DAMON callbacks without additional synchronization, the
+ * request will be handled by the DAMON callback.  None-``NULL`` @kdamond means
+ * the request is valid.
+ */
+struct damon_sysfs_cmd_request {
+	enum damon_sysfs_cmd cmd;
+	struct damon_sysfs_kdamond *kdamond;
+};
+
+/* Current DAMON callback request.  Protected by damon_sysfs_lock. */
+static struct damon_sysfs_cmd_request damon_sysfs_cmd_request;
+
 static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
@@ -2257,6 +2276,70 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 	mutex_unlock(&ctx->kdamond_lock);
 }
 
+/*
+ * damon_sysfs_upd_schemes_stats() - Update schemes stats sysfs files.
+ * @kdamond:	The kobject wrapper that associated to the kdamond thread.
+ *
+ * This function reads the schemes stats of specific kdamond and update the
+ * related values for sysfs files.  This function should be called from DAMON
+ * callbacks while holding ``damon_syfs_lock``, to safely access the DAMON
+ * contexts-internal data and DAMON sysfs variables.
+ */
+static int damon_sysfs_upd_schemes_stats(struct damon_sysfs_kdamond *kdamond)
+{
+	struct damon_ctx *ctx = kdamond->damon_ctx;
+	struct damon_sysfs_schemes *sysfs_schemes;
+	struct damos *scheme;
+	int schemes_idx = 0;
+
+	if (!ctx)
+		return -EINVAL;
+	sysfs_schemes = kdamond->contexts->contexts_arr[0]->schemes;
+	damon_for_each_scheme(scheme, ctx) {
+		struct damon_sysfs_stats *sysfs_stats;
+
+		sysfs_stats = sysfs_schemes->schemes_arr[schemes_idx++]->stats;
+		sysfs_stats->nr_tried = scheme->stat.nr_tried;
+		sysfs_stats->sz_tried = scheme->stat.sz_tried;
+		sysfs_stats->nr_applied = scheme->stat.nr_applied;
+		sysfs_stats->sz_applied = scheme->stat.sz_applied;
+		sysfs_stats->qt_exceeds = scheme->stat.qt_exceeds;
+	}
+	return 0;
+}
+
+/*
+ * damon_sysfs_cmd_request_callback() - DAMON callback for handling requests.
+ * @c:	The DAMON context of the callback.
+ *
+ * This function is periodically called back from the kdamond thread for @c.
+ * Then, it checks if there is a waiting DAMON sysfs request and handles it.
+ */
+static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
+{
+	struct damon_sysfs_kdamond *kdamond;
+	int err = 0;
+
+	/* avoid deadlock due to concurrent state_store('off') */
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return 0;
+	kdamond = damon_sysfs_cmd_request.kdamond;
+	if (!kdamond || kdamond->damon_ctx != c)
+		goto out;
+	switch (damon_sysfs_cmd_request.cmd) {
+	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS:
+		err = damon_sysfs_upd_schemes_stats(kdamond);
+		break;
+	default:
+		break;
+	}
+	/* Mark the request as invalid now. */
+	damon_sysfs_cmd_request.kdamond = NULL;
+out:
+	mutex_unlock(&damon_sysfs_lock);
+	return err;
+}
+
 static struct damon_ctx *damon_sysfs_build_ctx(
 		struct damon_sysfs_context *sys_ctx)
 {
@@ -2279,6 +2362,8 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 	if (err)
 		goto out;
 
+	ctx->callback.after_wmarks_check = damon_sysfs_cmd_request_callback;
+	ctx->callback.after_aggregation = damon_sysfs_cmd_request_callback;
 	ctx->callback.before_terminate = damon_sysfs_before_terminate;
 	return ctx;
 
@@ -2295,6 +2380,8 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 	if (kdamond->damon_ctx &&
 			damon_sysfs_ctx_running(kdamond->damon_ctx))
 		return -EBUSY;
+	if (damon_sysfs_cmd_request.kdamond == kdamond)
+		return -EBUSY;
 	/* TODO: support multiple contexts per kdamond */
 	if (kdamond->contexts->nr != 1)
 		return -EINVAL;
@@ -2327,29 +2414,11 @@ static int damon_sysfs_turn_damon_off(struct damon_sysfs_kdamond *kdamond)
 	 */
 }
 
-static int damon_sysfs_update_schemes_stats(struct damon_sysfs_kdamond *kdamond)
+static inline bool damon_sysfs_kdamond_running(
+		struct damon_sysfs_kdamond *kdamond)
 {
-	struct damon_ctx *ctx = kdamond->damon_ctx;
-	struct damos *scheme;
-	int schemes_idx = 0;
-
-	if (!ctx)
-		return -EINVAL;
-	mutex_lock(&ctx->kdamond_lock);
-	damon_for_each_scheme(scheme, ctx) {
-		struct damon_sysfs_schemes *sysfs_schemes;
-		struct damon_sysfs_stats *sysfs_stats;
-
-		sysfs_schemes = kdamond->contexts->contexts_arr[0]->schemes;
-		sysfs_stats = sysfs_schemes->schemes_arr[schemes_idx++]->stats;
-		sysfs_stats->nr_tried = scheme->stat.nr_tried;
-		sysfs_stats->sz_tried = scheme->stat.sz_tried;
-		sysfs_stats->nr_applied = scheme->stat.nr_applied;
-		sysfs_stats->sz_applied = scheme->stat.sz_applied;
-		sysfs_stats->qt_exceeds = scheme->stat.qt_exceeds;
-	}
-	mutex_unlock(&ctx->kdamond_lock);
-	return 0;
+	return kdamond->damon_ctx &&
+		damon_sysfs_ctx_running(kdamond->damon_ctx);
 }
 
 /*
@@ -2357,24 +2426,58 @@ static int damon_sysfs_update_schemes_stats(struct damon_sysfs_kdamond *kdamond)
  * @cmd:	The command to handle.
  * @kdamond:	The kobject wrapper for the associated kdamond.
  *
- * This function handles a DAMON sysfs command for a kdamond.
+ * This function handles a DAMON sysfs command for a kdamond.  For commands
+ * that need to access running DAMON context-internal data, it requests
+ * handling of the command to the DAMON callback
+ * (@damon_sysfs_cmd_request_callback()) and wait until it is properly handled,
+ * or the context is completed.
  *
  * Return: 0 on success, negative error code otherwise.
  */
 static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 		struct damon_sysfs_kdamond *kdamond)
 {
+	bool need_wait = true;
+
+	/* Handle commands that doesn't access DAMON context-internal data */
 	switch (cmd) {
 	case DAMON_SYSFS_CMD_ON:
 		return damon_sysfs_turn_damon_on(kdamond);
 	case DAMON_SYSFS_CMD_OFF:
 		return damon_sysfs_turn_damon_off(kdamond);
-	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS:
-		return damon_sysfs_update_schemes_stats(kdamond);
 	default:
 		break;
 	}
-	return -EINVAL;
+
+	/* Pass the command to DAMON callback for safe DAMON context access */
+	if (damon_sysfs_cmd_request.kdamond)
+		return -EBUSY;
+	if (!damon_sysfs_kdamond_running(kdamond))
+		return -EINVAL;
+	damon_sysfs_cmd_request.cmd = cmd;
+	damon_sysfs_cmd_request.kdamond = kdamond;
+
+	/*
+	 * wait until damon_sysfs_cmd_request_callback() handles the request
+	 * from kdamond context
+	 */
+	mutex_unlock(&damon_sysfs_lock);
+	while (need_wait) {
+		schedule_timeout_idle(msecs_to_jiffies(100));
+		if (!mutex_trylock(&damon_sysfs_lock))
+			continue;
+		if (!damon_sysfs_cmd_request.kdamond) {
+			/* damon_sysfs_cmd_request_callback() handled */
+			need_wait = false;
+		} else if (!damon_sysfs_kdamond_running(kdamond)) {
+			/* kdamond has already finished */
+			need_wait = false;
+			damon_sysfs_cmd_request.kdamond = NULL;
+		}
+		mutex_unlock(&damon_sysfs_lock);
+	}
+	mutex_lock(&damon_sysfs_lock);
+	return 0;
 }
 
 static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -2511,6 +2614,12 @@ static int damon_sysfs_kdamonds_add_dirs(struct damon_sysfs_kdamonds *kdamonds,
 	if (damon_sysfs_nr_running_ctxs(kdamonds->kdamonds_arr, kdamonds->nr))
 		return -EBUSY;
 
+	for (i = 0; i < kdamonds->nr; i++) {
+		if (damon_sysfs_cmd_request.kdamond ==
+				kdamonds->kdamonds_arr[i])
+			return -EBUSY;
+	}
+
 	damon_sysfs_kdamonds_rm_dirs(kdamonds);
 	if (!nr_kdamonds)
 		return 0;
-- 
2.25.1

