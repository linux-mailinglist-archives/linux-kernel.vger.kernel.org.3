Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B8B5A4370
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiH2Gzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiH2Gzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:55:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 957261F63D;
        Sun, 28 Aug 2022 23:55:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C259823A;
        Sun, 28 Aug 2022 23:55:40 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCB0F3F766;
        Sun, 28 Aug 2022 23:55:58 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: [PATCH 3/3] x86/perf: Assert all platform event flags are within PERF_EVENT_FLAG_ARCH
Date:   Mon, 29 Aug 2022 12:25:07 +0530
Message-Id: <20220829065507.177781-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829065507.177781-1-anshuman.khandual@arm.com>
References: <20220829065507.177781-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure all platform specific event flags are within PERF_EVENT_FLAG_ARCH.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/x86/events/amd/core.c |  2 ++
 arch/x86/events/core.c     | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 9ac3718410ce..7aee514285ba 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1469,6 +1469,8 @@ __init int amd_pmu_init(void)
 	else
 		memcpy(hw_cache_event_ids, amd_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PAIR);
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_AMD_BRS);
 	return 0;
 }
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f969410d0c90..98fe13f50632 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2083,6 +2083,22 @@ static int __init init_hw_perf_events(void)
 
 	pr_info("Performance Events: ");
 
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_LDLAT);
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_ST);
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_ST_HSW);
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_LD_HSW);
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_NA_HSW);
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_EXCL);
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_DYNAMIC);
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_EXCL_ACCT);
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_AUTO_RELOAD);
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_LARGE_PEBS);
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_VIA_PT);
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_LBR_SELECT);
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_TOPDOWN);
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_STLAT);
+	BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_LAT_HYBRID);
+
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_INTEL:
 		err = intel_pmu_init();
-- 
2.25.1

