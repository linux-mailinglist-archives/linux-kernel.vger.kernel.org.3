Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD564D1A22
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347292AbiCHOPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbiCHOPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:15:22 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E706449FBB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:14:25 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id e10-20020a056402190a00b00410f20467abso10655692edz.14
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 06:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gyMGBvpuWMfS9cnvL/h1tsboqRL4o8fwiR0D5Pa1mrE=;
        b=q2POkYW1YeKnITLGDcWKnutHfsCisYKRva4yrqAUA+rihvnBLs8fN9iUwLD++uU+WG
         uR7+nswf5DGs8L5xUPfntSbabDhdn+SQuGMOXv/0kQw7/a42EwJj8jBZBax0jzPLPMZp
         cbaVbRm8FDJoysaKSeoeyykLy56NTg+e1e30m579EiYOzRNJ+FmBPv330zenq/cMbyJj
         01CePPnVvJxO9Zh4O/uhs3Tb71UBgWfnq7DBBnpGl12E6EWbz1+0XUSy3Ae2YHmoGG0p
         Xt29qvMTCAOb5IgFKSlK/pOhtDF67QEaNUxxuIW4GOXVeNVygX+r7sd196TjMXEfWvGR
         sTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gyMGBvpuWMfS9cnvL/h1tsboqRL4o8fwiR0D5Pa1mrE=;
        b=Ng73hxf/DOlmkrxgCx8ChI5213io4NOm/NS4oi1btOpJtdwX2ZYkrOO1aJnsYqz5ET
         +mzs7ae8tU0NjZMv5kFAXAcXGfwbW5ctmFDbCmWJ94bcEOUQL2oHXAzRsMLoNprFD0+6
         JlLq5N/YtsCDjtxrawm06NOE88PLHvMMOCE/AYmJH3Ma85HlHk+F3yJUSif2PgBoqaCP
         aN2nCFZTWUfNqvx3cjrazVLfQg+XUpyomuqHjKIwNbWhUn+2sBeChRQY8OgG8oU77Z+r
         wcA+gczG3Dc+q7/8GaYNfG9YHuaCha49n1RrOlQY2VC1l8J3tLVffUrq/DvxsfDKhpo0
         p2Kg==
X-Gm-Message-State: AOAM533gUupElTOJWKtdv1Izx32ASxH7tJrQAKDa1owqXnnwIiEhD1Rp
        2RZwdSwxx5YQXv0UmkKeQ219rR78JA==
X-Google-Smtp-Source: ABdhPJyjGKAOe5D5WM5m7t1nu4yQN2fo/haxq+9mLVG9lQsaIlWMlvX9X9himb4U5X+Cj5kjj0kAu1iKuQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:edd7:29ac:9b6f:1abd])
 (user=elver job=sendgmr) by 2002:a17:907:7244:b0:6d9:c722:577a with SMTP id
 ds4-20020a170907724400b006d9c722577amr13651190ejc.0.1646748864121; Tue, 08
 Mar 2022 06:14:24 -0800 (PST)
Date:   Tue,  8 Mar 2022 15:14:15 +0100
Message-Id: <20220308141415.3168078-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v2] kfence: allow use of a deferrable timer
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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
v2:
* Add more documentation.
* Remove 'if EXPERT' from Kconfig option since it's configurable via
  kernel boot param anyway.
---
 Documentation/dev-tools/kfence.rst | 12 ++++++++++++
 lib/Kconfig.kfence                 | 12 ++++++++++++
 mm/kfence/core.c                   | 15 +++++++++++++--
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kfence.rst b/Documentation/dev-tools/kfence.rst
index ac6b89d1a8c3..936f6aaa75c8 100644
--- a/Documentation/dev-tools/kfence.rst
+++ b/Documentation/dev-tools/kfence.rst
@@ -41,6 +41,18 @@ guarded by KFENCE. The default is configurable via the Kconfig option
 ``CONFIG_KFENCE_SAMPLE_INTERVAL``. Setting ``kfence.sample_interval=0``
 disables KFENCE.
 
+The sample interval controls a timer that sets up KFENCE allocations. By
+default, to keep the real sample interval predictable, the normal timer also
+causes CPU wake-ups when the system is completely idle. This may be undesirable
+on power-constrained systems. The boot parameter ``kfence.deferrable=1``
+instead switches to a "deferrable" timer which does not force CPU wake-ups on
+idle systems, at the risk of unpredictable sample intervals. The default is
+configurable via the Kconfig option ``CONFIG_KFENCE_DEFERRABLE``.
+
+.. warning::
+   The KUnit test suite is very likely to fail when using a deferrable timer
+   since it currently causes very unpredictable sample intervals.
+
 The KFENCE memory pool is of fixed size, and if the pool is exhausted, no
 further KFENCE allocations occur. With ``CONFIG_KFENCE_NUM_OBJECTS`` (default
 255), the number of available guarded objects can be controlled. Each object
diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
index 912f252a41fc..459dda9ef619 100644
--- a/lib/Kconfig.kfence
+++ b/lib/Kconfig.kfence
@@ -45,6 +45,18 @@ config KFENCE_NUM_OBJECTS
 	  pages are required; with one containing the object and two adjacent
 	  ones used as guard pages.
 
+config KFENCE_DEFERRABLE
+	bool "Use a deferrable timer to trigger allocations"
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
index f126b53b9b85..2f9fdfde1941 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -95,6 +95,10 @@ module_param_cb(sample_interval, &sample_interval_param_ops, &kfence_sample_inte
 static unsigned long kfence_skip_covered_thresh __read_mostly = 75;
 module_param_named(skip_covered_thresh, kfence_skip_covered_thresh, ulong, 0644);
 
+/* If true, use a deferrable timer. */
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

