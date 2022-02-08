Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD8E4AE48F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388282AbiBHWgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386861AbiBHVRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:17:17 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0B2C0612BC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:17:16 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id i16-20020aa78d90000000b004be3e88d746so234301pfr.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uTDmTBSOOY683ot1kd61hkpiMB3wxXOtomvwYLlA3dQ=;
        b=Cx0XtYRxcH4rbHL4wV+lB2OzYKeQ/4cXIVomva3Oh0zh4c5JfPYsIlzFVACwveQyJY
         vI0yMSxMGyz6VtTOn4aXbOggGYqx85kdcYNpF3yHRMj84a6h0g957qJmiQ2AWwnvsEAU
         0BdOFvtVw/3D37X452H0sGUmrvwq+4tdBTQMLRT56m7bGwv0729XSrC/a1iFte65RyoO
         rchhAp36fxKyVq/5GeEbdrQs7T2d3qsL588Wtjy857HKW7S7xyJzOJ8GxDVocVS6gpG4
         OejHORJog5iou4Kh4Py7BllaOp3s8PzlH96jjma35fffvFCXhFWgUzLg2UJs5lN2PxVF
         XpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uTDmTBSOOY683ot1kd61hkpiMB3wxXOtomvwYLlA3dQ=;
        b=NswopKFDxVC0oNSSRD+vOQElvEVPtuB9JYgDA3+X16vDc5L25XE+aIUmXdRgK9Oal2
         G0hRc3ywT0jV+w84u1Y471NsxdKuOdVpzM/jbUo+lkuF2ll38C7XzxSXr+J8/fKxRqmB
         qB6SFwKz0zwARGXxnS7HqZ7Zt3AQwO5wD1XoiXhxXyyrRcskW8fZOYqvGtYx51UfO5T8
         f3+9yfXXN8WwVA89nFgSTHEqNynqDzrtY6EghLnJsYn9DQ/msvoTXUjVoAby/ZedVSVp
         66qCtgjKxDvMpsIygktZTqWSKwbMDwfsZskIY0Fa5oqQGwWtigqToiF6PDgKQ+phVvP/
         xYVQ==
X-Gm-Message-State: AOAM533f2rTOuU7J9AYr6ZgoB3iiRXfgkbgaQEesKCjfjeDovfRGMgwz
        IruQIPfYcQ8GNKYaPDKxDSJkF23nxrl43Ixo6JpZi2Ndp3mdHdIbvSyg3GyLwc40g6Y8Nde59h+
        8gW77dEdng6YFt+24kPrj1/KYan5AmFAflwnTjBE4sOiZfDsJLNiu5XV+Y7um9xhxR00SZBm6
X-Google-Smtp-Source: ABdhPJzECl4nloGcEaC4D2VkDIalK0xVDOgyyn6E5UEquw+JIDhh+rcA6l20CApUgd4KLd3Tb2FKjwEx4FJa
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:6875:3c51:69be:6e2c])
 (user=eranian job=sendgmr) by 2002:a17:902:b684:: with SMTP id
 c4mr6195450pls.100.1644355035935; Tue, 08 Feb 2022 13:17:15 -0800 (PST)
Date:   Tue,  8 Feb 2022 13:16:34 -0800
In-Reply-To: <20220208211637.2221872-1-eranian@google.com>
Message-Id: <20220208211637.2221872-10-eranian@google.com>
Mime-Version: 1.0
References: <20220208211637.2221872-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 09/12] perf/x86/amd: add idle hooks for branch sampling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
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

On AMD Fam19h Zen3, the branch sampling (BRS) feature must be disabled before
entering low power and re-enabled (if was active) when returning from low
power. Otherwise, the NMI interrupt may be held up for too long and cause
problems. Stopping BRS will cause the NMI to be delivered if it was held up.

Define a perf_amd_brs_lopwr_cb() callback to stop/restart BRS.  The callback
is protected by a jump label which is enabled only when AMD BRS is detected.
In all other cases, the callback is never called.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/amd/brs.c         | 32 +++++++++++++++++++++++++++++++
 arch/x86/events/amd/core.c        |  4 ++++
 arch/x86/events/perf_event.h      |  1 +
 arch/x86/include/asm/perf_event.h | 21 ++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 40461c3ce714..185a58cea917 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -7,6 +7,7 @@
  * Contributed by Stephane Eranian <eranian@google.com>
  */
 #include <linux/kernel.h>
+#include <linux/jump_label.h>
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
 
@@ -329,3 +330,34 @@ void amd_pmu_brs_sched_task(struct perf_event_context *ctx, bool sched_in)
 	if (sched_in)
 		amd_brs_poison_buffer();
 }
+
+DEFINE_STATIC_KEY_FALSE(perf_lopwr_needed);
+
+/*
+ * called from ACPI processor_idle.c or acpi_pad.c
+ * with interrupts disabled
+ */
+void perf_amd_brs_lopwr_cb(bool lopwr_in)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	union amd_debug_extn_cfg cfg;
+
+	/*
+	 * on mwait in, we may end up in non C0 state.
+	 * we must disable branch sampling to avoid holding the NMI
+	 * for too long. We disable it in hardware but we
+	 * keep the state in cpuc, so we can re-enable.
+	 *
+	 * The hardware will deliver the NMI if needed when brsmen cleared
+	 */
+	if (cpuc->brs_active) {
+		cfg.val = get_debug_extn_cfg();
+		cfg.brsmen = !lopwr_in;
+		set_debug_extn_cfg(cfg.val);
+	}
+}
+
+void __init amd_brs_lopwr_init(void)
+{
+	static_branch_enable(&perf_lopwr_needed);
+}
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 597defee1e02..ea71ee52b758 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/perf_event.h>
+#include <linux/jump_label.h>
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/init.h>
@@ -1189,6 +1190,9 @@ static int __init amd_core_pmu_init(void)
 			 * The put_event_constraints callback is shared with
 			 * Fam17h, set above
 			 */
+
+			/* branch sampling must be stopped when entering low power */
+			amd_brs_lopwr_init();
 		}
 	}
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 4d050579dcbd..2ed7bf5b51b1 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1226,6 +1226,7 @@ void amd_brs_enable(void);
 void amd_brs_enable_all(void);
 void amd_brs_disable_all(void);
 void amd_brs_drain(void);
+void amd_brs_lopwr_init(void);
 void amd_brs_disable_all(void);
 int amd_brs_setup_filter(struct perf_event *event);
 void amd_brs_reset(void);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 58d9e4b1fa0a..42753a9dc3ed 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -513,6 +513,27 @@ static inline void intel_pt_handle_vmx(int on)
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_AMD)
  extern void amd_pmu_enable_virt(void);
  extern void amd_pmu_disable_virt(void);
+
+#if defined(CONFIG_PERF_EVENTS_AMD_BRS)
+
+#define PERF_NEEDS_LOPWR_CB 1
+
+/*
+ * architectural low power callback impacts
+ * drivers/acpi/processor_idle.c
+ * drivers/acpi/acpi_pad.c
+ */
+extern void perf_amd_brs_lopwr_cb(bool lopwr_in);
+DECLARE_STATIC_KEY_FALSE(perf_lopwr_needed);
+
+static inline void perf_lopwr_cb(bool mode)
+{
+	/* key enabled only when BRS is available */
+	if (static_branch_unlikely(&perf_lopwr_needed))
+		perf_amd_brs_lopwr_cb(mode);
+}
+#endif /* PERF_NEEDS_LOPWR_CB */
+
 #else
  static inline void amd_pmu_enable_virt(void) { }
  static inline void amd_pmu_disable_virt(void) { }
-- 
2.35.0.263.gb82422642f-goog

