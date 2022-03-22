Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73C04E4902
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbiCVWRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbiCVWRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:17:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742C654BD9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e5db04460cso107023327b3.17
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZQAAS74opi8sj3DsdS3WYbPGk9CAmygqU3vFxd41V8g=;
        b=V+8Arq7RPuNgR78gOc2Lgu0jG8uK8Q5I/dG5j+tMJq3wK7We+b3Pyxb9WBoD/mkyN4
         Z51hmsYgbQdw+CV2cnJlEf/wqKaTBl2AqdDtTalFXign7/AgYpV+OLaBJ2D7ek2k4Jtk
         u7iDVBCPIkGmRRwdkFNWlhFZD7YSCN9q5+PhfHilKW3kOBAamvpMhgmHu8FzVDMI3KQz
         elvSfFzlWdlJjf6rkjUd0l8JSfjx6Tx9ibn3ymuMP1nLxF0Hku2suY/5BDG3UXLRYBJ0
         Mts2OfT7o/+61dR16OIs9/nitAXIzS2s48QOYl1IkL11eD3VGiOqywl+JHmRxIS84Z5g
         X4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZQAAS74opi8sj3DsdS3WYbPGk9CAmygqU3vFxd41V8g=;
        b=GAwNQXP2hKR6sH99hmmGF7s5kZJsx0SNjA2XkJHLJG8FPOkhmejcjfvCLSw0X5KXau
         rspvYwCO8+jcEbrgicNRAlHkswuOVAnmcTGB/7qsgcHPeP1dx3JusskAYxrXX5NQyYCi
         6eRUhhDdZtdDG69N4miKbQnWKyi6mE0hdDbVyhsul4OImfJuVzzD2QXUL70x6GIXP50s
         8lE4g0ht+tQG9huEJAE0E6k0EjRXU49vBW51z1eTogguxhDoNrbSsan0UJfhmxx5sn1/
         +MjF1iRPEufpnmF/RLu+601PO9M/xWjxN8hxYncI5GjwZNnppAteU/VxlotOt4mMhzQ2
         fqPw==
X-Gm-Message-State: AOAM5306RwhSDfNBRx9ttTl6weX71Q2sowFXiAUI/SohqfcXjr1NOhY5
        YlIWA5iezannKqWWPvf9qlAOBNyLanZ/tNNI/llyLki6MAWroFCvpTIoHsvYjLcYeowpNjKmHSJ
        zPVRbte/yWDK1bhIZFqbmqnViv1DCi7fUXSIW0dk0akRxVDyR0ys9twwh6WlFVK7TlMR1HWuY
X-Google-Smtp-Source: ABdhPJxRkohH32T3Vy8NMLmcvAC4ShJI4tOMfhoCBl6l0+MyCv0wQ6aE9Jo8WwCiF3YSAzK41a9gIkgEROkv
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:1817:acc9:c45f:d133])
 (user=eranian job=sendgmr) by 2002:a25:86cf:0:b0:633:8702:1bb3 with SMTP id
 y15-20020a2586cf000000b0063387021bb3mr29936265ybm.515.1647987347460; Tue, 22
 Mar 2022 15:15:47 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:15:13 -0700
In-Reply-To: <20220322221517.2510440-1-eranian@google.com>
Message-Id: <20220322221517.2510440-10-eranian@google.com>
Mime-Version: 1.0
References: <20220322221517.2510440-1-eranian@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v7 09/13] perf/x86/amd: add idle hooks for branch sampling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, rafael@kernel.org,
        ravi.bangoria@amd.com, sandipan.das@amd.com
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
index f7bce8364fe4..8e1e818f8195 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/perf_event.h>
+#include <linux/jump_label.h>
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/init.h>
@@ -1225,6 +1226,9 @@ static int __init amd_core_pmu_init(void)
 		/*
 		 * put_event_constraints callback same as Fam17h, set above
 		 */
+
+		/* branch sampling must be stopped when entering low power */
+		amd_brs_lopwr_init();
 	}
 
 	x86_pmu.attr_update = amd_attr_update;
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
2.35.1.894.gb6a874cedc-goog

