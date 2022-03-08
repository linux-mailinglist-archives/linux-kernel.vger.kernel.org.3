Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C5E4D1726
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343703AbiCHMV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiCHMV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:21:26 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7964506E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 04:20:30 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id hq34-20020a1709073f2200b006d677c94909so8629825ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 04:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kl2sXhR1ZPN1zpyjxLJOZF6G4P4aj2NkEcWtAzkOw34=;
        b=e8o5OZ/PjBLUrn4XXwdWmsvAptgAay2fZ8FGw0JI2jB/j4+ttCbC9bXWl62EQm2oyP
         9yCMJ4m5v3HeKN1Fo2CZY8vRNiH4fXUB1Go3eiGEWu5jigu1DRlDDhFbn135L4oF0AR8
         v4mrb7nZ5rA/cZAJP1NhYaLVva3DJ5hIt2MC7CjnpV0GVhcYkjRq8fa5xhKekix+DVcI
         TfbogjWkfWGm5At5NnaXkm7JweN+BjlL47iGT8+MowaKQuEdMKh9G87pAFcFkabYlhPN
         ksyVUEz+rWPBxg2bty70dnJOxXuo57PdCaYSZgzKt63SxCeVDcFY82+zM3UMmtSjy2/t
         jsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kl2sXhR1ZPN1zpyjxLJOZF6G4P4aj2NkEcWtAzkOw34=;
        b=QdBoYHrJqp+maIHL7xYrfQT1sDKebMrc/+p5a1zFZjxM4kLtMPWbU7MFPyBHU+kic+
         uv+9qeZVAZbBLNEFg1Oe2zfTp4v0fwwSqx51xYeR9nIeMNs92iiE2Wiu3GtBDu6He5k8
         tQJnD5iOBDmGqVa9jRefvMBPOTeRydmdrLN/Q0Tf9TewTh19BJ7QSGd6y+ygfR/mX5CO
         cAkZ/GwcowixXvrRiKZ1OJmEnOCcc+FapdyfptKY0E/nt3ieq7NUSRgAXuiIToUUJqdd
         tY9WmU07uYNafzkQUoO3vcvCyRe07eAFkBAb8JH2/vY2Q/tQ6gP2bKcKx31J94DZu2ZE
         AbeA==
X-Gm-Message-State: AOAM5313xt3pMw/+GKahWbowsMSpDdGzU/893t3GAEVb7KeT5SfHUTPe
        bTU4f9UFi1bYk6Kb2TetX8WuDv/sSA==
X-Google-Smtp-Source: ABdhPJxfkP2/aCUWzQbI6nd5lClz2NRqyNjoTupTqovem5C6WFkLWF7MoURPx1fFC6GsUpAmk1n+lQpAEw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:edd7:29ac:9b6f:1abd])
 (user=elver job=sendgmr) by 2002:a05:6402:50c8:b0:416:2ae0:4bb3 with SMTP id
 h8-20020a05640250c800b004162ae04bb3mr14109102edb.132.1646742028577; Tue, 08
 Mar 2022 04:20:28 -0800 (PST)
Date:   Tue,  8 Mar 2022 13:20:23 +0100
Message-Id: <20220308122023.3068150-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH] kfence: allow use of a deferrable timer
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the use of a deferrable timer, which does not force CPU wake-ups
when the system is idle. A consequence is that the sample interval
becomes very unpredictable, to the point that it is not guaranteed that
the KFENCE KUnit test still passes.

Nevertheless, on power-constrained systems this may be preferable, so
let's give the user the option should they accept the above trade-off.

Signed-off-by: Marco Elver <elver@google.com>
---
 lib/Kconfig.kfence | 12 ++++++++++++
 mm/kfence/core.c   | 15 +++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
index 912f252a41fc..1cf2ea2a1ac7 100644
--- a/lib/Kconfig.kfence
+++ b/lib/Kconfig.kfence
@@ -45,6 +45,18 @@ config KFENCE_NUM_OBJECTS
 	  pages are required; with one containing the object and two adjacent
 	  ones used as guard pages.
 
+config KFENCE_DEFERRABLE
+	bool "Use a deferrable timer to trigger allocations" if EXPERT
+	help
+	  Use a deferrable timer to trigger allocations. This avoids forcing
+	  CPU wake-ups if the system is idle, at the risk of a less predictable
+	  sample interval.
+
+	  Warning: The KUnit test suite fails with this option enabled - due to
+	  the unpredictability of the sample interval!
+
+	  Say N if you are unsure.
+
 config KFENCE_STATIC_KEYS
 	bool "Use static keys to set up allocations" if EXPERT
 	depends on JUMP_LABEL
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index f126b53b9b85..451277b41bfb 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -95,6 +95,10 @@ module_param_cb(sample_interval, &sample_interval_param_ops, &kfence_sample_inte
 static unsigned long kfence_skip_covered_thresh __read_mostly = 75;
 module_param_named(skip_covered_thresh, kfence_skip_covered_thresh, ulong, 0644);
 
+/* If true, use a deferrable timer at the risk of unpredictable sample intervals. */
+static bool kfence_deferrable __read_mostly = IS_ENABLED(CONFIG_KFENCE_DEFERRABLE);
+module_param_named(deferrable, kfence_deferrable, bool, 0444);
+
 /* The pool of pages used for guard pages and objects. */
 char *__kfence_pool __read_mostly;
 EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
@@ -740,6 +744,8 @@ late_initcall(kfence_debugfs_init);
 
 /* === Allocation Gate Timer ================================================ */
 
+static struct delayed_work kfence_timer;
+
 #ifdef CONFIG_KFENCE_STATIC_KEYS
 /* Wait queue to wake up allocation-gate timer task. */
 static DECLARE_WAIT_QUEUE_HEAD(allocation_wait);
@@ -762,7 +768,6 @@ static DEFINE_IRQ_WORK(wake_up_kfence_timer_work, wake_up_kfence_timer);
  * avoids IPIs, at the cost of not immediately capturing allocations if the
  * instructions remain cached.
  */
-static struct delayed_work kfence_timer;
 static void toggle_allocation_gate(struct work_struct *work)
 {
 	if (!READ_ONCE(kfence_enabled))
@@ -790,7 +795,6 @@ static void toggle_allocation_gate(struct work_struct *work)
 	queue_delayed_work(system_unbound_wq, &kfence_timer,
 			   msecs_to_jiffies(kfence_sample_interval));
 }
-static DECLARE_DELAYED_WORK(kfence_timer, toggle_allocation_gate);
 
 /* === Public interface ===================================================== */
 
@@ -809,8 +813,15 @@ static void kfence_init_enable(void)
 {
 	if (!IS_ENABLED(CONFIG_KFENCE_STATIC_KEYS))
 		static_branch_enable(&kfence_allocation_key);
+
+	if (kfence_deferrable)
+		INIT_DEFERRABLE_WORK(&kfence_timer, toggle_allocation_gate);
+	else
+		INIT_DELAYED_WORK(&kfence_timer, toggle_allocation_gate);
+
 	WRITE_ONCE(kfence_enabled, true);
 	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
+
 	pr_info("initialized - using %lu bytes for %d objects at 0x%p-0x%p\n", KFENCE_POOL_SIZE,
 		CONFIG_KFENCE_NUM_OBJECTS, (void *)__kfence_pool,
 		(void *)(__kfence_pool + KFENCE_POOL_SIZE));
-- 
2.35.1.616.g0bdcbb4464-goog

