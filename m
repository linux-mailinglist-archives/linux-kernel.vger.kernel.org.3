Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E7C4979FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242029AbiAXIHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:07:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:57796 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242015AbiAXIG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643011618; x=1674547618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vyg45HjCXh/zy37PuGlh0RdebatcRs7T2Pt6LIULRa8=;
  b=MLnZwTdzp4Yy4xIOxP8mkgm66fIKh5p0rD+uhu5moVv1zwBfnG/HApwg
   tb4tRFBJUfSnBIPt4DUDVl+RlyxERdgNGHhrI7iHdU2pnfS7iAaeB7Usc
   Wsns8vPG23Cxqv+C/xa8OfMLCBNGKENQv77DlsrpEzKF1wh1BIN3sUkKk
   1Ae/+sl26jKR8XXtjYF0g9uo+d5TIpM7oyU4KQqcmqvae6HMBAl4DNsgm
   i8GnKDUpvmSaxhHTx6Zs1miGDrznzom/EXbGPM6vcdyNa/yc/Kc5y3pIa
   JsHrZ30N14NCAdQlJaajAT8UkehPBxiH9xbVa4uhiRzSzf8DFxJ8NZZwX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306707278"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306707278"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:06:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="478981212"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga006.jf.intel.com with ESMTP; 24 Jan 2022 00:06:55 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>
Subject: [PATCH 1/2] perf/x86/intel/pt: Add a capability and config bit for event tracing
Date:   Mon, 24 Jan 2022 10:06:50 +0200
Message-Id: <20220124080651.2699107-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124080651.2699107-1-adrian.hunter@intel.com>
References: <20220124080651.2699107-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

As of Intel SDM (https://www.intel.com/sdm) version 076, there is a new
Intel PT feature called Event Trace which is enabled config bit 31.

Event Trace exposes details about asynchronous events such as interrupts
and VM-Entry/Exit.

Add a capability and config bit for Event Trace.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/pt.c       | 8 ++++++++
 arch/x86/include/asm/intel_pt.h  | 1 +
 arch/x86/include/asm/msr-index.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 7f406c14715f..02727b9b3c8a 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -57,6 +57,7 @@ static struct pt_cap_desc {
 	PT_CAP(mtc,			0, CPUID_EBX, BIT(3)),
 	PT_CAP(ptwrite,			0, CPUID_EBX, BIT(4)),
 	PT_CAP(power_event_trace,	0, CPUID_EBX, BIT(5)),
+	PT_CAP(event_trace,		0, CPUID_EBX, BIT(7)),
 	PT_CAP(topa_output,		0, CPUID_ECX, BIT(0)),
 	PT_CAP(topa_multiple_entries,	0, CPUID_ECX, BIT(1)),
 	PT_CAP(single_range_output,	0, CPUID_ECX, BIT(2)),
@@ -108,6 +109,7 @@ PMU_FORMAT_ATTR(tsc,		"config:10"	);
 PMU_FORMAT_ATTR(noretcomp,	"config:11"	);
 PMU_FORMAT_ATTR(ptw,		"config:12"	);
 PMU_FORMAT_ATTR(branch,		"config:13"	);
+PMU_FORMAT_ATTR(event,		"config:31"	);
 PMU_FORMAT_ATTR(mtc_period,	"config:14-17"	);
 PMU_FORMAT_ATTR(cyc_thresh,	"config:19-22"	);
 PMU_FORMAT_ATTR(psb_period,	"config:24-27"	);
@@ -116,6 +118,7 @@ static struct attribute *pt_formats_attr[] = {
 	&format_attr_pt.attr,
 	&format_attr_cyc.attr,
 	&format_attr_pwr_evt.attr,
+	&format_attr_event.attr,
 	&format_attr_fup_on_ptw.attr,
 	&format_attr_mtc.attr,
 	&format_attr_tsc.attr,
@@ -296,6 +299,7 @@ static int __init pt_pmu_hw_init(void)
 			RTIT_CTL_CYC_PSB	| \
 			RTIT_CTL_MTC		| \
 			RTIT_CTL_PWR_EVT_EN	| \
+			RTIT_CTL_EVENT_EN	| \
 			RTIT_CTL_FUP_ON_PTW	| \
 			RTIT_CTL_PTW_EN)
 
@@ -350,6 +354,10 @@ static bool pt_event_valid(struct perf_event *event)
 	    !intel_pt_validate_hw_cap(PT_CAP_power_event_trace))
 		return false;
 
+	if (config & RTIT_CTL_EVENT_EN &&
+	    !intel_pt_validate_hw_cap(PT_CAP_event_trace))
+		return false;
+
 	if (config & RTIT_CTL_PTW) {
 		if (!intel_pt_validate_hw_cap(PT_CAP_ptwrite))
 			return false;
diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index ebe8d2ea44fe..d1ef9cb58847 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -13,6 +13,7 @@ enum pt_capabilities {
 	PT_CAP_mtc,
 	PT_CAP_ptwrite,
 	PT_CAP_power_event_trace,
+	PT_CAP_event_trace,
 	PT_CAP_topa_output,
 	PT_CAP_topa_multiple_entries,
 	PT_CAP_single_range_output,
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3faf0f97edb1..79b392d893e3 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -205,6 +205,7 @@
 #define RTIT_CTL_DISRETC		BIT(11)
 #define RTIT_CTL_PTW_EN			BIT(12)
 #define RTIT_CTL_BRANCH_EN		BIT(13)
+#define RTIT_CTL_EVENT_EN		BIT(31)
 #define RTIT_CTL_MTC_RANGE_OFFSET	14
 #define RTIT_CTL_MTC_RANGE		(0x0full << RTIT_CTL_MTC_RANGE_OFFSET)
 #define RTIT_CTL_CYC_THRESH_OFFSET	19
-- 
2.25.1

