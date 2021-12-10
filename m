Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE53470C31
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344449AbhLJVG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344339AbhLJVGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:06:45 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471E6C0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:03:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d9-20020a251d09000000b005c208092922so18399097ybd.20
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=puuivgvc1/Z2xpv7jriZEwGGFjvt4lFOrdm6sw/k8Ro=;
        b=XgZcHnbhN3FGqzXzDFRZcz0BmI6VMJUEX6hldNR2IlTCbSdXownM1WYh9TniGQVDi3
         uW4V47l8nThnwsdD7gRJ9nQ4F4JsJay/mIZGfMIJnfHhDOlA0UcziAlVT7up6GYscYXY
         WOZ9fOHDKIatpgf51o7w/D85u3PJJhdOERaSJYjH4R+zum646zoBAIl+4oHfJELBZSBU
         NAw7Gr+w8rPTFYJYJCOhSXJ10qTIx9cXNKrQuHPDGEQFbMywmrLjXsYI0khc61wh71HS
         6RKZCBvQo7jivmhFJwWRIcQiNeUjBborw7nL+psL1TbvwNQol7sj4MmNai2lCukYsJOT
         sssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=puuivgvc1/Z2xpv7jriZEwGGFjvt4lFOrdm6sw/k8Ro=;
        b=z+RmzsODAkrxTjMNULsSBgpdFnSaVpmZUkkMvZZVTcu7XvMO9TS9BV/qp+kgZg9fbF
         srbim/flYyxOtnm2yXr6lzOTxBVrYWg+IWBF/2HdlCPzhVO++6fRvOdeDvme/g4b3j8J
         7zcvGkzLQC4qsGDiRuRAYn3kv1QvW7WIHy3uhdTMkh0dMoJittj8Lbp71KSIgvx7DhEH
         NJbgdggjXRgSUCwPyu9lJsmZP3xIk9PllVBo1h380rBmREmtEHRzkqle92C6p39DZH8D
         YzH+DWxTrBmGdkh2dnLIT+yh2J1coJDOJnI/McLMPqbYLJrC0wAeTcdeCcfaope3+RaW
         8mgQ==
X-Gm-Message-State: AOAM531/z3+p33F5+TyHlESZ514kB6MbEYnbtGxksmqPBkFAd19nbxAT
        t60J7j2JCowpRS/wKHH99RKtXBUcVYgIPCZQmRHVqIDa+YK3Rqt2AZhTY5g8q02VF1KpuLGCvDS
        lxTwXnI7E84iB4d+OyDz8kVrE77ltMzPBzYcW5EWupMM1J3VdeVBR/X1LHl6vhZfq2fOGz8vy
X-Google-Smtp-Source: ABdhPJz9ZpSDNGh9qBlaOdOHAV0AtMgWzqWZ2JufsxOqCG9/9MRJnmLB7IMJ6pAMg//YGM5Uxa+BpsVarAzU
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:7416:17a6:6678:d4d5])
 (user=eranian job=sendgmr) by 2002:a25:3b54:: with SMTP id
 i81mr16360389yba.541.1639170188504; Fri, 10 Dec 2021 13:03:08 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:02:24 -0800
In-Reply-To: <20211210210229.2991238-1-eranian@google.com>
Message-Id: <20211210210229.2991238-10-eranian@google.com>
Mime-Version: 1.0
References: <20211210210229.2991238-1-eranian@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 09/14] perf/x86/amd: add idle hooks for branch sampling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AMD Fam19h Zen3, the branch sampling (BRS) feature must be disabled before
entering low power and re-enabled (if was active) when returning from low
power. Otherwise, the NMI interrupt may be held up for too long and cause
problems. Stopping BRS will cause the NMI to be delivered if it was held up.

The patch defines a perf_amd_brs_lopwr_cb() callback to stop/restart BRS.
The callback is protected by a jump label which is enabled only when AMD BRS
is detected. In all other cases, the callback is never called.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/amd/brs.c         | 32 +++++++++++++++++++++++++++++++
 arch/x86/events/amd/core.c        |  4 ++++
 arch/x86/events/perf_event.h      |  1 +
 arch/x86/include/asm/perf_event.h | 21 ++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 1e5524494631..bedff27c4b03 100644
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
index a4715bfcb801..5167755619df 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1220,6 +1220,7 @@ void amd_brs_enable(void);
 void amd_brs_enable_all(void);
 void amd_brs_disable_all(void);
 void amd_brs_drain(void);
+void amd_brs_lopwr_init(void);
 void amd_brs_disable_all(void);
 int amd_brs_setup_filter(struct perf_event *event);
 void amd_brs_reset(void);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8fc1b5003713..e405847ccb56 100644
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
2.34.1.173.g76aa8bc2d0-goog

