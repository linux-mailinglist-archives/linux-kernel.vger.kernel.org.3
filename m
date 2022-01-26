Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84D949D638
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiAZXfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiAZXfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:35:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC30C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:37 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o131-20020a25d789000000b00614957c60dfso2410002ybg.15
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=77Xb7IozJK2EuLs4apu7mCZR9lH0WIP1AhAUAxjVORY=;
        b=Zr81Adlg5rVu8pQ4gQeC2lP9fYcf5x9Q4dY4b5kTNRDGfWyzfLl3ooDJTdYfWyCqS0
         bx73laUny1ZNyoYSW/oSrSgil6d5jT0PtfT7qEEinLBPE/jtFDwCXhRhQKEycy7waBPM
         0Wc2x0P+2P60Z+txvJCMZ8BGbpXwey+sZzg4NWbmQsxy/pNYEbYYusTVi74E8jYH8XgD
         KZV4Vs1tsuxUudrlfOo9rowJLgJgVEgqsVpsRBUQKai6vtGngcy6m/jPPrZu5RRSFU1S
         poOcRm+cbmgdH+rfo3CCLUx6tOv+/u3YQSyGvLFjXIC9bfZby6IidL4xepSlcMsKn6aR
         NnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=77Xb7IozJK2EuLs4apu7mCZR9lH0WIP1AhAUAxjVORY=;
        b=f/T1d3AfumyHpICroKFCHS3q2PgAYDWTM66q17R/LpH0H5eJAbUgYfjnIHHVfZfe5J
         JSm5qYZ5h6/iq+61RybGqD6BHPUyfkXzYZwa2/QmAdoHsQatXlCmPGs8Atn4X/i0HwCj
         WZ5b35E34K6OMOO/4OWybzBFhP8IhkOQhYUwpzwN0T7Rlxv7sgszIeDEEwze4hU8oEId
         mwVvHyut25Q4b9eVJQGvvEQNiCDvIVPbC845S1cuvHAjhnZosR87pZYc3YPKnx1nMhqk
         Ts2LyVeVZYQ/A76HKD+1lFXNX6sDB/4DKqwREizt8cZ3wGIGdNDnOESEtAAPB/SZXZyA
         ubPw==
X-Gm-Message-State: AOAM5308Z1xJ1sujFXxdb4aXgP3ZIMK49944KRCboioL7HUvOvOEkhX1
        su5aP8X56ZeNjKy54JvXqH8no9IUbq5iYtJPwfIUZm1GwZfSAMzCnATp7zOFVHtUD5K0ETlm4iE
        SUW8+e8QIgzWhJ5054v0quZVgV+5Xy+3Q9A0UfQE0b0cvI1RtJcvmsglCyfMzT+BtS7JRIA94
X-Google-Smtp-Source: ABdhPJxzg2OHb7YkLygqBN1Zg+gVA9qPg2YQ0RJyWB7Ji+JpwA2d7E5L8pXlGOYTZARZz4lGTPvFFnmOke/k
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:9ce0:6f20:c145:eac])
 (user=eranian job=sendgmr) by 2002:a25:552:: with SMTP id 79mr2119869ybf.392.1643240136439;
 Wed, 26 Jan 2022 15:35:36 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:34:50 -0800
In-Reply-To: <20220126233454.3362047-1-eranian@google.com>
Message-Id: <20220126233454.3362047-10-eranian@google.com>
Mime-Version: 1.0
References: <20220126233454.3362047-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v5 09/13] perf/x86/amd: add idle hooks for branch sampling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
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
2.35.0.rc0.227.g00780c9af4-goog

