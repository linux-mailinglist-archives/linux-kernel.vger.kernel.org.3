Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B864BA595
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243026AbiBQQUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:20:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243000AbiBQQUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:20:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E200327374B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:19:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94C09B8235C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 16:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20C3C340F3;
        Thu, 17 Feb 2022 16:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645114788;
        bh=86/d0xi9LNikqugSFOyNSfFep2UlHDk2g/2oy5k4oEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eEk1KP0P1Ru7nw3eTQhYjXWvpF2DTvf7W1pMSZs/zqUJGjp0e/VnEskIvolzcBV4T
         tNqpoWqrdv97UM7fZR5E4nbWaBA/Dums9OYKbqHzsjsRUIm0u7+plWVOFSK/8kyjm2
         xikQexBGTgbH1868dxj3O5B958yvTEW1YhBlPyeqNLSPP+02SvrteDRL9Nxf2fFVDl
         q1v+mWARrsMnqJxqWHsVydvX5RvPIJ6/ChqQmRhjMFXSd5La+y9aQk5O/ApcTH0ufG
         CN+cMWTM0aWjP+mDh0CohnqWCO9HxlsYK/QJ2NXIU4p49FBuNtHYq3mmGZ4HrS90nt
         CvdTI/uiVFp5Q==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     rientjes@google.com, xhao@linux.alibaba.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH 3/4] mm/damon/sysfs: Link DAMON to 'state' file read/write functions
Date:   Thu, 17 Feb 2022 16:19:37 +0000
Message-Id: <20220217161938.8874-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220217161938.8874-1-sj@kernel.org>
References: <20220217161938.8874-1-sj@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements 'state' DAMON sysfs interface file read/write
functions.  In detail, writing 'on' or 'off' to the 'state' file turns
DAMON for the context on or off, accordingly.  Reading the file shows
the state.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 166 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 162 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 59bdc7268dc6..721ee086265f 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -793,18 +793,176 @@ static void damon_sysfs_kdamond_rm_dirs(struct damon_sysfs_kdamond *kdamond)
 	kobject_put(&kdamond->contexts->kobj);
 }
 
+static bool damon_sysfs_ctx_running(struct damon_ctx *ctx)
+{
+	bool running;
+
+	mutex_lock(&ctx->kdamond_lock);
+	running = ctx->kdamond != NULL;
+	mutex_unlock(&ctx->kdamond_lock);
+	return running;
+}
+
 static ssize_t damon_sysfs_kdamond_state_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	/* TODO: Link with DAMON */
-	return sysfs_emit(buf, "off\n");
+	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+			struct damon_sysfs_kdamond, kobj);
+	struct damon_ctx *ctx = kdamond->damon_ctx;
+	bool running;
+
+	if (!ctx)
+		running = false;
+	else
+		running = damon_sysfs_ctx_running(ctx);
+
+	return sysfs_emit(buf, "%s\n", running ? "on" : "off");
+}
+
+static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
+{
+	struct damon_target *t, *next;
+
+	damon_for_each_target_safe(t, next, ctx) {
+		if (ctx->ops.id == DAMON_OPS_VADDR)
+			put_pid(t->pid);
+		damon_destroy_target(t);
+	}
+}
+
+static int damon_sysfs_set_targets(struct damon_ctx *ctx,
+		struct damon_sysfs_context *sysfs_ctx)
+{
+	struct damon_sysfs_targets *targets = sysfs_ctx->targets;
+	int i;
+
+	for (i = 0; i < targets->nr_targets; i++) {
+		struct damon_target *t;
+
+		t = damon_new_target();
+		if (!t) {
+			damon_sysfs_destroy_targets(ctx);
+			return -ENOMEM;
+		}
+		if (ctx->ops.id == DAMON_OPS_VADDR) {
+			t->pid = find_get_pid(targets->targets_arr[i]->pid);
+			if (!t->pid) {
+				damon_sysfs_destroy_targets(ctx);
+				return -EINVAL;
+			}
+		}
+		damon_add_target(ctx, t);
+	}
+	return 0;
+}
+
+static inline bool target_has_pid(const struct damon_ctx *ctx)
+{
+	return ctx->ops.id == DAMON_OPS_VADDR;
+}
+
+static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
+{
+	struct damon_target *t, *next;
+
+	if (!target_has_pid(ctx))
+		return;
+
+	mutex_lock(&ctx->kdamond_lock);
+	damon_for_each_target_safe(t, next, ctx) {
+		put_pid(t->pid);
+		damon_destroy_target(t);
+	}
+	mutex_unlock(&ctx->kdamond_lock);
+}
+
+static struct damon_ctx *damon_sysfs_build_ctx(
+		struct damon_sysfs_context *sys_ctx)
+{
+	struct damon_ctx *ctx = damon_new_ctx();
+	struct damon_sysfs_attrs *sys_attrs = sys_ctx->attrs;
+	struct damon_sysfs_ul_range *sys_nr_regions = sys_attrs->nr_regions;
+	struct damon_sysfs_intervals *sys_intervals = sys_attrs->intervals;
+	int err;
+
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	err = damon_select_ops(ctx, sys_ctx->ops_id);
+	if (err)
+		goto out;
+
+	err = damon_set_attrs(ctx, sys_intervals->sample_us,
+			sys_intervals->aggr_us, sys_intervals->update_us,
+			sys_nr_regions->min, sys_nr_regions->max);
+	if (err)
+		goto out;
+	err = damon_sysfs_set_targets(ctx, sys_ctx);
+	if (err)
+		goto out;
+	ctx->callback.before_terminate = damon_sysfs_before_terminate;
+	return ctx;
+
+out:
+	damon_destroy_ctx(ctx);
+	return ERR_PTR(err);
 }
 
 static ssize_t damon_sysfs_kdamond_state_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	/* TODO: Link with DAMON */
-	return count;
+	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+			struct damon_sysfs_kdamond, kobj);
+	struct damon_ctx *ctx;
+	ssize_t ret;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	if (!strncmp(buf, "on\n", count)) {
+		if (kdamond->damon_ctx &&
+				damon_sysfs_ctx_running(kdamond->damon_ctx)) {
+			ret = -EBUSY;
+			goto out;
+		}
+		if (kdamond->contexts->nr != 1) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (kdamond->damon_ctx)
+			damon_destroy_ctx(kdamond->damon_ctx);
+		kdamond->damon_ctx = NULL;
+
+		ctx = damon_sysfs_build_ctx(
+				kdamond->contexts->contexts_arr[0]);
+		if (IS_ERR(ctx)) {
+			ret = PTR_ERR(ctx);
+			goto out;
+		}
+		ret = damon_start(&ctx, 1, false);
+		if (ret) {
+			damon_destroy_ctx(ctx);
+			goto out;
+		}
+		kdamond->damon_ctx = ctx;
+	} else if (!strncmp(buf, "off\n", count)) {
+		if (!kdamond->damon_ctx) {
+			ret = -EINVAL;
+			goto out;
+		}
+		ret = damon_stop(&kdamond->damon_ctx, 1);
+		/*
+		 * kdamond->damon_ctx will be freed in next on, or
+		 * kdamonds_nr_store()
+		 */
+	} else {
+		ret = -EINVAL;
+	}
+out:
+	mutex_unlock(&damon_sysfs_lock);
+	if (!ret)
+		ret = count;
+	return ret;
 }
 
 static ssize_t damon_sysfs_kdamond_pid_show(struct kobject *kobj,
-- 
2.17.1

