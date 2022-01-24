Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37F9498025
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbiAXM6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242865AbiAXM6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:58:46 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2292FC061757
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 04:58:45 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so15790516pju.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 04:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jKkNxr+1cB+XB6YIAl08DtywpPMNPFY1xvETiNerBv4=;
        b=ZTfY83ziPZR4GDz3xQZpQlufTJscwAsvrvRRKBUGWxqDkdA1va0RwigvqsJh8vqQS2
         Cr1CSfGsdyFEDox/gdOe5UN+gfJl/M1PhQGqJzwQ7WkKUKAP0LFzEedI6vKoyqCpdEF9
         3gSBuybAkNcdAU6be2n77jFlYV6Dl9/KVa8pK++wGo/ARHH4NuZJ22KzHFwt8CBWqGT4
         oeOm3pKjlWSLNYHeBK0FjBJXueBfTunP+wd2pFCeti1eTpXzXT2rppGwLhnnHXUkLTBL
         RY3CsxJneexPIuOsYHKLRG4PaJwytL1K04wvJIgNj4fjM2IKDQ1GN6+0dopPvh4yxYVt
         o8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jKkNxr+1cB+XB6YIAl08DtywpPMNPFY1xvETiNerBv4=;
        b=cCcjG8B+xJaKyyUxF7Z356xTKWxQgPHPj5Osa0/aPmEb36lP3uL7+Wwo7HbvqPCotd
         iV/sO3cMrhXipwUlB/S5DmwnjxjSrsL4IjlcVCSUQiNnAnS8WSdhOQYlNhX03G6MyxQv
         q8t1hcxkc2mcI4znT7Hb5L0w8ePZpf/ycob63vQ9H2F/iQbSn+Z7sahplxWR8BPSAYsm
         1QK8QUqmwjmV4UG4CFM/CSbf5hCiGtBnKPk+YjrsLbqIDjEXYpVeQQ/GMRThzMV8oaCt
         WHZ5vZ+QVnu+KLoaUMLdlsl5XSjfATpypTtFCW1sXFBHDzY2DMYSnYpwkL/acY0RgA03
         pZmg==
X-Gm-Message-State: AOAM531EWVkWFOUF4xK59PiKQRrmvJoU4YgR+HDJNb+0T8BVAZpqOcfu
        SJ2Qepo5AljNs4DfnQ+bTRY=
X-Google-Smtp-Source: ABdhPJyYbcsc9C2l2KCNpEBfLe8n7n6WB0ovH6E/D5v67OB9y4UJCJuIP9SuFmcGrvjnGCSW3/k40Q==
X-Received: by 2002:a17:902:ab82:b0:14a:188a:cd1f with SMTP id f2-20020a170902ab8200b0014a188acd1fmr14279622plr.44.1643029124671;
        Mon, 24 Jan 2022 04:58:44 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id s23sm17794805pfg.144.2022.01.24.04.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 04:58:44 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     matthew.brost@intel.com
Cc:     airlied@linux.ie, andi.shyti@intel.com, chris@chris-wilson.co.uk,
        daniel@ffwll.ch, daniele.ceraolospurio@intel.com,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, jason@jlekstrand.net,
        joonas.lahtinen@linux.intel.com, linmq006@gmail.com,
        linux-kernel@vger.kernel.org, lucas.demarchi@intel.com,
        maarten.lankhorst@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2] drm/i915/selftests: Fix NULL vs IS_ERR checking for kernel_context
Date:   Mon, 24 Jan 2022 12:58:37 +0000
Message-Id: <20220124125837.10467-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112175338.GA12463@jons-linux-dev-box>
References: <20220112175338.GA12463@jons-linux-dev-box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since i915_gem_create_context() function return error pointers,
the kernel_context() function does not return null, It returns error
pointers too. Using IS_ERR() to check the return value to fix this.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2:
- clean up unneeded initialization of err.
---
 drivers/gpu/drm/i915/gt/selftest_execlists.c | 43 ++++++++++++++------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index b367ecfa42de..0d453ddcede4 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -1531,7 +1531,7 @@ static int live_busywait_preempt(void *arg)
 	struct drm_i915_gem_object *obj;
 	struct i915_vma *vma;
 	enum intel_engine_id id;
-	int err = -ENOMEM;
+	int err;
 	u32 *map;
 
 	/*
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

