Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC9446DCBE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbhLHUPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:15:02 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:34641 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbhLHUPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:15:01 -0500
Received: by mail-oi1-f175.google.com with SMTP id t19so5660915oij.1;
        Wed, 08 Dec 2021 12:11:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Bt69g7JEtyL8nxUPLM3lwudhNzUVs8G1dLLiIbYufw=;
        b=veFj3+60ioTHH/3ER0jQSbpFUtrJSR/dxJWcw9wQ46hH3EemNizG+4Z6TgaCfc5TtI
         h9HOn+EPCowHLFORHETCsbZ7GjYpcypYLHagAGTSlb7MFc357zGAX4m/Hd3aJgXw5AGr
         udLRzXxmCITjgPpnXyRCT//gqNb7Ww3gFsuoOtKFKq9yh4eTfMFu9RPuMPi9H/S4qcnN
         x0Vspg+H8RLtKhG8rjGpVpoOlSzpTuoRIg7p7W8BmZdga9aCub9K5d7WibYFLKty4wz2
         eB+cTRSHS5C5GimuOo+uYiqKGqv71DHh8YnfN/pXU2jZTFzvmvlLnqUoN/Q3KZEIOwgE
         zZ4Q==
X-Gm-Message-State: AOAM532Zs3bbxQXxyRHms6MJI7ks+4ucsdUMmbGfzLIu10ITcKgS9yRQ
        Oglg9LCDaqxTa90xu6xGMQ==
X-Google-Smtp-Source: ABdhPJwvH530RaHWucWdv+YbueZwsPjC+RghKvfLL3DNUKGtJxPg6W+0ClqvWEu+W1O9Dj+B6ZPHzQ==
X-Received: by 2002:a05:6808:118a:: with SMTP id j10mr1695273oil.101.1638994288574;
        Wed, 08 Dec 2021 12:11:28 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id o2sm927926oik.11.2021.12.08.12.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:11:27 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH v13 1/5] x86: perf: Move RDPMC event flag to a common definition
Date:   Wed,  8 Dec 2021 14:11:20 -0600
Message-Id: <20211208201124.310740-2-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208201124.310740-1-robh@kernel.org>
References: <20211208201124.310740-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable user counter access on arm64 and to move some
of the user access handling to perf core, create a common event flag for
user counter access and convert x86 to use it.

Since the architecture specific flags start at the LSB, starting at the
MSB for common flags.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-perf-users@vger.kernel.org
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v11:
 - Move PERF_EVENT_FLAG_USER_READ_CNT definition above struct
---
 arch/x86/events/core.c       | 10 +++++-----
 arch/x86/events/perf_event.h |  2 +-
 include/linux/perf_event.h   |  9 +++++++++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 38b2c779146f..68dea7ce6a22 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2476,7 +2476,7 @@ static int x86_pmu_event_init(struct perf_event *event)
 
 	if (READ_ONCE(x86_pmu.attr_rdpmc) &&
 	    !(event->hw.flags & PERF_X86_EVENT_LARGE_PEBS))
-		event->hw.flags |= PERF_X86_EVENT_RDPMC_ALLOWED;
+		event->hw.flags |= PERF_EVENT_FLAG_USER_READ_CNT;
 
 	return err;
 }
@@ -2510,7 +2510,7 @@ void perf_clear_dirty_counters(void)
 
 static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 {
-	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
+	if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
 		return;
 
 	/*
@@ -2531,7 +2531,7 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 
 static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
 {
-	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
+	if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
 		return;
 
 	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
@@ -2542,7 +2542,7 @@ static int x86_pmu_event_idx(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (!(hwc->flags & PERF_X86_EVENT_RDPMC_ALLOWED))
+	if (!(hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
 		return 0;
 
 	if (is_metric_idx(hwc->idx))
@@ -2725,7 +2725,7 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time = 0;
 	userpg->cap_user_time_zero = 0;
 	userpg->cap_user_rdpmc =
-		!!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED);
+		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
 	userpg->pmc_width = x86_pmu.cntval_bits;
 
 	if (!using_native_sched_clock() || !sched_clock_stable())
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5480db242083..9d376e528dfc 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -74,7 +74,7 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 #define PERF_X86_EVENT_PEBS_NA_HSW	0x0010 /* haswell style datala, unknown */
 #define PERF_X86_EVENT_EXCL		0x0020 /* HT exclusivity on counter */
 #define PERF_X86_EVENT_DYNAMIC		0x0040 /* dynamic alloc'd constraint */
-#define PERF_X86_EVENT_RDPMC_ALLOWED	0x0080 /* grant rdpmc permission */
+
 #define PERF_X86_EVENT_EXCL_ACCT	0x0100 /* accounted EXCL event */
 #define PERF_X86_EVENT_AUTO_RELOAD	0x0200 /* use PEBS auto-reload */
 #define PERF_X86_EVENT_LARGE_PEBS	0x0400 /* use large PEBS */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0dcfd265beed..ba9467972c09 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -129,6 +129,15 @@ struct hw_perf_event_extra {
 	int		idx;	/* index in shared_regs->regs[] */
 };
 
+/**
+ * hw_perf_event::flag values
+ *
+ * PERF_EVENT_FLAG_ARCH bits are reserved for architecture-specific
+ * usage.
+ */
+#define PERF_EVENT_FLAG_ARCH			0x0000ffff
+#define PERF_EVENT_FLAG_USER_READ_CNT		0x80000000
+
 /**
  * struct hw_perf_event - performance event hardware details:
  */
-- 
2.32.0

