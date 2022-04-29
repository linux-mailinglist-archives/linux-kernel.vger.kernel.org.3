Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3B1515061
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378844AbiD2QJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245321AbiD2QJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6E9A7743
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 407E4622B2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE22C385AF;
        Fri, 29 Apr 2022 16:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651248375;
        bh=9dkrDs1lmfWKgDNH59hI5csjK0CcBiTmC6kvCAvLDMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NCspm9dZ2M+ek44LP0LupjNE7TVEZk4ijJkrNvgqpINcHPf95daej1QVmP7hIg5YT
         jnHP5xhvhMgogEqwDjz+oLlh2sTXMh7tL4IOm8sWFgafYLvirR4pPaff4rCXPAOapr
         N8MyNAtjHtGFGMb1bl38C8mspKPFV7azs9wzDfF4E2OKldFomUdkvgOYvKqWXD2Ob+
         Bnghf4C3sEvDjNYGTXYj0IgdZgb46xeOSOVYtC1p0Lb9X42Mf+Ueb7Xf4IDGvGgLcl
         VxF/2bUkJBjFPzMcm1AHJULeqBiu8Fiajb2v6Yk7gsR2SsTmFEhu+hNmoMbY0ftY7q
         j++0Lcm+3pY6w==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 01/14] mm/damon/core: add a new callback for watermarks checks
Date:   Fri, 29 Apr 2022 16:05:53 +0000
Message-Id: <20220429160606.127307-2-sj@kernel.org>
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

For updating input parameters for running DAMON contexts, DAMON kernel
API users can use the contexts' callbacks, as it is the safe place for
context internal data accesses.  When the context has DAMON-based
operation schemes and all schemes are deactivated due to their
watermarks, however, DAMON does nothing but only watermarks checks.  As
a result, no callbacks will be called back, and therefore the kernel API
users cannot update the input parameters including monitoring
attributes, DAMON-based operation schemes, and watermarks.

To let users easily update such DAMON input parameters in such a case,
this commit adds a new callback, 'after_wmarks_check()'.  It will be
called after each watermarks check.  Users can do the online input
parameters update in the callback even under the schemes deactivated
case.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 7 +++++++
 mm/damon/core.c       | 8 +++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 09a5d0d02c00..6cb5ab5d8e9d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -343,6 +343,7 @@ struct damon_operations {
  * struct damon_callback - Monitoring events notification callbacks.
  *
  * @before_start:	Called before starting the monitoring.
+ * @after_wmarks_check:	Called after each schemes' watermarks check.
  * @after_sampling:	Called after each sampling.
  * @after_aggregation:	Called after each aggregation.
  * @before_terminate:	Called before terminating the monitoring.
@@ -353,6 +354,11 @@ struct damon_operations {
  * respectively.  Therefore, those are good places for installing and cleaning
  * @private.
  *
+ * The monitoring thread calls @after_wmarks_check after each DAMON-based
+ * operation schemes' watermarks check.  If users need to make changes to the
+ * attributes of the monitoring context while it's deactivated due to the
+ * watermarks, this is the good place to do.
+ *
  * The monitoring thread calls @after_sampling and @after_aggregation for each
  * of the sampling intervals and aggregation intervals, respectively.
  * Therefore, users can safely access the monitoring results without additional
@@ -365,6 +371,7 @@ struct damon_callback {
 	void *private;
 
 	int (*before_start)(struct damon_ctx *context);
+	int (*after_wmarks_check)(struct damon_ctx *context);
 	int (*after_sampling)(struct damon_ctx *context);
 	int (*after_aggregation)(struct damon_ctx *context);
 	void (*before_terminate)(struct damon_ctx *context);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5c1331f93c2e..e28fbc3a1969 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1103,6 +1103,10 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 			return 0;
 
 		kdamond_usleep(min_wait_time);
+
+		if (ctx->callback.after_wmarks_check &&
+				ctx->callback.after_wmarks_check(ctx))
+			break;
 	}
 	return -EBUSY;
 }
@@ -1129,8 +1133,10 @@ static int kdamond_fn(void *data)
 	sz_limit = damon_region_sz_limit(ctx);
 
 	while (!kdamond_need_stop(ctx) && !done) {
-		if (kdamond_wait_activation(ctx))
+		if (kdamond_wait_activation(ctx)) {
+			done = true;
 			continue;
+		}
 
 		if (ctx->ops.prepare_access_checks)
 			ctx->ops.prepare_access_checks(ctx);
-- 
2.25.1

