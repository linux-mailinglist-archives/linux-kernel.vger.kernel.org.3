Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA5147CDC1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 08:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243137AbhLVH7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 02:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhLVH7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 02:59:37 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1607C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 23:59:36 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r138so1408810pgr.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 23:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Ep/zKHGWSlzXqkTceOgtZaVXJ4nuNbPBUMHXh8/O+vQ=;
        b=JGP/UeithGjLSStBwiVZ0fRumVJF13RQK7WvN++JsItsaqoQ8mWgq9UK1dQZf6VjCg
         Y6jH8X3RMvc2gy+QXzt1kkOTDIjTeXLwAPHgTDCI9f2eLBNxUVUQABWj046dvLX54w8B
         vyyU+rP0ory9wBtHq+iTsLpsDUh7ndgSIKDlGRp7YY6AIG/Nm4foT+WeerH6sQraXKty
         RWqnYaXzFcfMvlsYzWY3GSz8cmy4j4+oXO/wa/BUVNkj3nJhzDDocuvx7e3zyRwoN9v8
         cth8CGFSqe2LHXjv1ICvXvvMct+yHGrU63JB8nKYszw3wKK2NgqqIa49nYJ2FM3Osbl5
         XjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ep/zKHGWSlzXqkTceOgtZaVXJ4nuNbPBUMHXh8/O+vQ=;
        b=i5Bpa2HkdLiymsPbfWEgvwN85kykokbCM5xzugs5t94C3r8Qqvf+y9bXbbKRUsHEDm
         caoxqPGR+eGI4Kaor4OudMYK18RmJplJ7GwXZiQppXVz1NaK2oc/7HSsZj+a+qQ+VRc7
         K5LClpXIynaUEShpf4vDMVWHdLgKfjEJ6GMSIPo7l6BnPlLM9qUKKRXXxrZ0xnSFk87o
         t7cnlQY2gotcVwLy+IhvwPilIFa4D7FvrvLJcurZP3X8t77moFYwx60lhSE4G9eMR0hD
         5NAfsqOfji7Bupnzen/fbjZgOfJGRoQvJ60hcI2ekZn9mByz/0DDHczkLd0H0mpY2mqN
         98/A==
X-Gm-Message-State: AOAM531sJTfS8CuenjWHm9QPDyx7AE+AzOUu938hMI6ce7rXqX4Dfof/
        8WY2fN40ChQom/vTLalBlC0=
X-Google-Smtp-Source: ABdhPJzpZFfq6pTnM8d0LAXCEwKKK1z/2Q7hS648SfgIyEPqOmaz6VbHogAP/uLgw50nhX2nZF+jMg==
X-Received: by 2002:aa7:8891:0:b0:4ba:ee8a:8cdd with SMTP id z17-20020aa78891000000b004baee8a8cddmr2073012pfe.79.1640159976549;
        Tue, 21 Dec 2021 23:59:36 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id j8sm1265395pgf.21.2021.12.21.23.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 23:59:36 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Brost <matthew.brost@intel.com>,
        Andi Shyti <andi.shyti@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/selftests: Fix NULL vs IS_ERR checking for kernel_context
Date:   Wed, 22 Dec 2021 07:58:29 +0000
Message-Id: <20211222075832.1732-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since i915_gem_create_context() function return error pointers,
the kernel_context() function does not return null, It returns error
pointers too. Using IS_ERR() to check the return value to fix this.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/i915/gt/selftest_execlists.c | 41 ++++++++++++++------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index b367ecfa42de..eacfe920afed 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -1540,13 +1540,16 @@ static int live_busywait_preempt(void *arg)
 	 */
 
 	ctx_hi = kernel_context(gt->i915, NULL);
-	if (!ctx_hi)
-		return -ENOMEM;
+	if (IS_ERR(ctx_hi))
+		return IS_ERR(ctx_hi);
+
 	ctx_hi->sched.priority = I915_CONTEXT_MAX_USER_PRIORITY;
 
 	ctx_lo = kernel_context(gt->i915, NULL);
-	if (!ctx_lo)
+	if (IS_ERR(ctx_lo)) {
+		err = PTR_ERR(ctx_lo);
 		goto err_ctx_hi;
+	}
 	ctx_lo->sched.priority = I915_CONTEXT_MIN_USER_PRIORITY;
 
 	obj = i915_gem_object_create_internal(gt->i915, PAGE_SIZE);
@@ -1742,13 +1745,17 @@ static int live_preempt(void *arg)
 		goto err_spin_hi;
 
 	ctx_hi = kernel_context(gt->i915, NULL);
-	if (!ctx_hi)
+	if (IS_ERR(ctx_hi)) {
+		err = PTR_ERR(ctx_hi);
 		goto err_spin_lo;
+	}
 	ctx_hi->sched.priority = I915_CONTEXT_MAX_USER_PRIORITY;
 
 	ctx_lo = kernel_context(gt->i915, NULL);
-	if (!ctx_lo)
+	if (IS_ERR(ctx_lo)) {
+		err = PTR_ERR(ctx_lo);
 		goto err_ctx_hi;
+	}
 	ctx_lo->sched.priority = I915_CONTEXT_MIN_USER_PRIORITY;
 
 	for_each_engine(engine, gt, id) {
@@ -1834,12 +1841,16 @@ static int live_late_preempt(void *arg)
 		goto err_spin_hi;
 
 	ctx_hi = kernel_context(gt->i915, NULL);
-	if (!ctx_hi)
+	if (IS_ERR(ctx_hi)) {
+		err = PTR_ERR(ctx_hi);
 		goto err_spin_lo;
+	}
 
 	ctx_lo = kernel_context(gt->i915, NULL);
-	if (!ctx_lo)
+	if (IS_ERR(ctx_lo)) {
+		err = PTR_ERR(ctx_lo);
 		goto err_ctx_hi;
+	}
 
 	/* Make sure ctx_lo stays before ctx_hi until we trigger preemption. */
 	ctx_lo->sched.priority = 1;
@@ -1928,8 +1939,8 @@ struct preempt_client {
 static int preempt_client_init(struct intel_gt *gt, struct preempt_client *c)
 {
 	c->ctx = kernel_context(gt->i915, NULL);
-	if (!c->ctx)
-		return -ENOMEM;
+	if (IS_ERR(c->ctx))
+		return PTR_ERR(c->ctx);
 
 	if (igt_spinner_init(&c->spin, gt))
 		goto err_ctx;
@@ -3385,13 +3396,17 @@ static int live_preempt_timeout(void *arg)
 		return -ENOMEM;
 
 	ctx_hi = kernel_context(gt->i915, NULL);
-	if (!ctx_hi)
+	if (IS_ERR(ctx_hi)) {
+		err = PTR_ERR(ctx_hi);
 		goto err_spin_lo;
+	}
 	ctx_hi->sched.priority = I915_CONTEXT_MAX_USER_PRIORITY;
 
 	ctx_lo = kernel_context(gt->i915, NULL);
-	if (!ctx_lo)
+	if (IS_ERR(ctx_lo)) {
+		err = PTR_ERR(ctx_lo);
 		goto err_ctx_hi;
+	}
 	ctx_lo->sched.priority = I915_CONTEXT_MIN_USER_PRIORITY;
 
 	for_each_engine(engine, gt, id) {
@@ -3683,8 +3698,10 @@ static int live_preempt_smoke(void *arg)
 
 	for (n = 0; n < smoke.ncontext; n++) {
 		smoke.contexts[n] = kernel_context(smoke.gt->i915, NULL);
-		if (!smoke.contexts[n])
+		if (IS_ERR(smoke.contexts[n])) {
+			err = PTR_ERR(smoke.contexts[n]);
 			goto err_ctx;
+		}
 	}
 
 	for (n = 0; n < ARRAY_SIZE(phase); n++) {
-- 
2.17.1

