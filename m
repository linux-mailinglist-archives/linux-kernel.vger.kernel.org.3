Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725F6464463
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346045AbhLABGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241191AbhLABGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:06:01 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF6CC061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:41 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id e12-20020aa7980c000000b0049fa3fc29d0so13913709pfl.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Vhf4ugNSvvWVJmcqyupP8lUtG7/fxQTLl+s4pV28NoI=;
        b=etEbKzEbZL0JZJMOKSpz9V+ZSJ5QrnCnze/vhZYRNyZCNIujov8dhNavUmzyhOOvdu
         N5qImILq5qQRe9OcR4KlojJLQRXD+iYRgE412bKKZg2cIXc4oa584vHz9BQM23MaNSPy
         IxOgo6KbtldpGpNB9MN+IFUwlCMjm/obbXea3EsRME+JkkAdtprdcbvZZc7ZDkYEQdaf
         0wsH/HMME/CC6mX3+a2NYGzRhzraAip+c8vlCm475ZbNChRDygXxra2ElWPJWEsP8Gp5
         Rk9WpvDYHXITmWJm11y61f287gujdz2uF+bxipaErlHjlpUErlZDcZ/QzrSENMf6vrKx
         x5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Vhf4ugNSvvWVJmcqyupP8lUtG7/fxQTLl+s4pV28NoI=;
        b=4KFt258Jn13KMLl2GVLd59PWlhTaqOHgPct0rCdcmgVmOUKThVKvyvMC6xBHeRpEl1
         /yTpnqNJEzAnuI665VUrJfaEQ7E99EuQofuSKEGCrS8R/ADHtUmtIpBKqYbO5dOqFjbN
         HehhF/dK/aZhhaPpksDbmdvZcZV9l1Vy3fWEdlBm/ETUsDQXjxSrPzdvK2KYgQhvXchg
         llnB49LyXpjnzurXVP64iqqC1sY3CrVgk5XemIcX9xo3O88IVTNoUwMjVDW5gZZkoGpr
         ySlYfbvixBMtYx4HsI7sDIjthLUWf1ktZM1S+4iDpk5DB9y5Q1BQzuqI5T0kpOMy2hj9
         JAng==
X-Gm-Message-State: AOAM530T0EoKG7/RoPhdqQM+vBYXSshrHcYhtHaCw81u160LfOHeSAGF
        vJ679bnHJQtZdlNhCSjmUfpAI1eBCWYG5qQ/BQrOcMahF5cdjPGfdCjHdOfcLdUeueGduST4RIg
        ou6x101bXnSuRE6cPQROJxpv5f1hu2lXO0wSZTpyEIP0q+yrk27zKtIFl6IHf/HqCyCZYegKl
X-Google-Smtp-Source: ABdhPJzp4GGy3qeSDg8CT8dSNetrMMFh88tUs9ReTHM5YS1R9iXmPmrfAQGe99saNikRuaIRNX/h/P1e40NN
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:8776:d8e0:bb50:a95a])
 (user=eranian job=sendgmr) by 2002:a17:90b:4d92:: with SMTP id
 oj18mr3263865pjb.188.1638320560802; Tue, 30 Nov 2021 17:02:40 -0800 (PST)
Date:   Tue, 30 Nov 2021 17:02:13 -0800
In-Reply-To: <20211201010217.886919-1-eranian@google.com>
Message-Id: <20211201010217.886919-10-eranian@google.com>
Mime-Version: 1.0
References: <20211201010217.886919-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 09/13] perf/x86/amd: add idle hooks for branch sampling
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
2.34.0.rc2.393.gf8c9666880-goog

