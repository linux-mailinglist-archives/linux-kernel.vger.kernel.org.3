Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10E8515065
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378859AbiD2QJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378826AbiD2QJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:09:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8180CA6E24
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:06:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A26A620D8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB0DC385AE;
        Fri, 29 Apr 2022 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651248379;
        bh=rAJFo4AjkW8JUKTUipbjPgtkusxOnV1JhWTxgwk0hVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZWCcY7gjW5kSeyS4THWs03LOnctZNxnQvXDMTxoSnrcazYhHkcu0sOxrCp8xCnmYy
         OOAzLhZ2bqE1tW7NeiM1KqxENbWGfSOM+wut3ERMm03w9ev51THCCvMQUbkPKyQhR9
         vlPML/uWh/HfM6vrl4+FuiLEQ1P440n4qD1nuf8Ww+C/PToaAVk0w0YAiIwmOYINcS
         a1xZGmcXg1lY7LdPFUZl/mwcmXrWUXS9PEatHqLsd2WwNwtZ/7ovRdnSQ82dhWZTdY
         PSl0IYmksN/WSH46PE8qoQDCMZVyEFpJ128uRtjsWmM1FvPdDMNU6/DvCGr/XyhGLJ
         T7usRn80m+WoA==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 07/14] mm/damon/sysfs: move targets setup code to a separated function
Date:   Fri, 29 Apr 2022 16:05:59 +0000
Message-Id: <20220429160606.127307-8-sj@kernel.org>
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

This commit separates DAMON sysfs interface's monitoring context targets
setup code to a new function for better readability.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 49 +++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 988247d35862..331647ab6396 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2119,6 +2119,31 @@ static int damon_sysfs_set_regions(struct damon_target *t,
 	return 0;
 }
 
+static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
+		struct damon_ctx *ctx)
+{
+	struct damon_target *t = damon_new_target();
+	int err = -EINVAL;
+
+	if (!t)
+		return -ENOMEM;
+	if (ctx->ops.id == DAMON_OPS_VADDR ||
+			ctx->ops.id == DAMON_OPS_FVADDR) {
+		t->pid = find_get_pid(sys_target->pid);
+		if (!t->pid)
+			goto destroy_targets_out;
+	}
+	damon_add_target(ctx, t);
+	err = damon_sysfs_set_regions(t, sys_target->regions);
+	if (err)
+		goto destroy_targets_out;
+	return 0;
+
+destroy_targets_out:
+	damon_sysfs_destroy_targets(ctx);
+	return err;
+}
+
 static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 		struct damon_sysfs_targets *sysfs_targets)
 {
@@ -2129,28 +2154,10 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 		return -EINVAL;
 
 	for (i = 0; i < sysfs_targets->nr; i++) {
-		struct damon_sysfs_target *sys_target =
-			sysfs_targets->targets_arr[i];
-		struct damon_target *t = damon_new_target();
-
-		if (!t) {
-			damon_sysfs_destroy_targets(ctx);
-			return -ENOMEM;
-		}
-		if (ctx->ops.id == DAMON_OPS_VADDR ||
-				ctx->ops.id == DAMON_OPS_FVADDR) {
-			t->pid = find_get_pid(sys_target->pid);
-			if (!t->pid) {
-				damon_sysfs_destroy_targets(ctx);
-				return -EINVAL;
-			}
-		}
-		damon_add_target(ctx, t);
-		err = damon_sysfs_set_regions(t, sys_target->regions);
-		if (err) {
-			damon_sysfs_destroy_targets(ctx);
+		err = damon_sysfs_add_target(
+				sysfs_targets->targets_arr[i], ctx);
+		if (err)
 			return err;
-		}
 	}
 	return 0;
 }
-- 
2.25.1

