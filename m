Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF6D49C7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbiAZKso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:48:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:10961 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240261AbiAZKs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643194107; x=1674730107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ez0YUMtx2ZHOiFwPFlbG7kc5e2sQtZWa/Hu1XkFZ+c=;
  b=jA0+udMQf2/Qb+bgWOJlerUFfzNMK01FLOL1Z9jluP7BM6mGKdVwj6ED
   FI/yXVoMxyjkdNrLUeG5yicmvXffgZ3BExgNWneoORdoOoa9IQWgmUpa/
   sDSV2WLzC8KoexeFKs6iHDYuggTVXM7R2OphIx9wmJ5J5BY2Tyh9D8pZP
   u6dMpe6HWFaG4ftKaidYa/v4fgqkCmDLlWuODBxmVP4cZmLNVXIWSNgKm
   zfyjWecxx7xzs56rrlP7aH/dgHa1u6pV7mBcqj0iaBXp/BENUE8Y4ZWyr
   EDUoA7dJ7gW0vWfJC8GnFKMZIgv55x+4hNTXTwssfHtegkRNLB+uv/CNc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="332878467"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="332878467"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 02:48:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="674323271"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jan 2022 02:48:23 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>
Subject: [PATCH V2 2/2] perf/x86/intel/pt: Add a capability and config bit for disabling TNTs
Date:   Wed, 26 Jan 2022 12:48:15 +0200
Message-Id: <20220126104815.2807416-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126104815.2807416-1-adrian.hunter@intel.com>
References: <20220126104815.2807416-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

As of Intel SDM (https://www.intel.com/sdm) version 076, there is a new
Intel PT feature called TNT-Disable which is enabled config bit 55.

TNT-Disable disables TNT packets to reduce the tracing overhead, but with
the result that exact control flow information is lost.

Add a capability and config bit for TNT-Disable.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/pt.c       | 8 ++++++++
 arch/x86/include/asm/intel_pt.h  | 1 +
 arch/x86/include/asm/msr-index.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 02727b9b3c8a..ae396fdfabab 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -58,6 +58,7 @@ static struct pt_cap_desc {
 	PT_CAP(ptwrite,			0, CPUID_EBX, BIT(4)),
 	PT_CAP(power_event_trace,	0, CPUID_EBX, BIT(5)),
 	PT_CAP(event_trace,		0, CPUID_EBX, BIT(7)),
+	PT_CAP(tnt_disable,		0, CPUID_EBX, BIT(8)),
 	PT_CAP(topa_output,		0, CPUID_ECX, BIT(0)),
 	PT_CAP(topa_multiple_entries,	0, CPUID_ECX, BIT(1)),
 	PT_CAP(single_range_output,	0, CPUID_ECX, BIT(2)),
@@ -110,6 +111,7 @@ PMU_FORMAT_ATTR(noretcomp,	"config:11"	);
 PMU_FORMAT_ATTR(ptw,		"config:12"	);
 PMU_FORMAT_ATTR(branch,		"config:13"	);
 PMU_FORMAT_ATTR(event,		"config:31"	);
+PMU_FORMAT_ATTR(notnt,		"config:55"	);
 PMU_FORMAT_ATTR(mtc_period,	"config:14-17"	);
 PMU_FORMAT_ATTR(cyc_thresh,	"config:19-22"	);
 PMU_FORMAT_ATTR(psb_period,	"config:24-27"	);
@@ -119,6 +121,7 @@ static struct attribute *pt_formats_attr[] = {
 	&format_attr_cyc.attr,
 	&format_attr_pwr_evt.attr,
 	&format_attr_event.attr,
+	&format_attr_notnt.attr,
 	&format_attr_fup_on_ptw.attr,
 	&format_attr_mtc.attr,
 	&format_attr_tsc.attr,
@@ -300,6 +303,7 @@ static int __init pt_pmu_hw_init(void)
 			RTIT_CTL_MTC		| \
 			RTIT_CTL_PWR_EVT_EN	| \
 			RTIT_CTL_EVENT_EN	| \
+			RTIT_CTL_NOTNT		| \
 			RTIT_CTL_FUP_ON_PTW	| \
 			RTIT_CTL_PTW_EN)
 
@@ -358,6 +362,10 @@ static bool pt_event_valid(struct perf_event *event)
 	    !intel_pt_validate_hw_cap(PT_CAP_event_trace))
 		return false;
 
+	if (config & RTIT_CTL_NOTNT &&
+	    !intel_pt_validate_hw_cap(PT_CAP_tnt_disable))
+		return false;
+
 	if (config & RTIT_CTL_PTW) {
 		if (!intel_pt_validate_hw_cap(PT_CAP_ptwrite))
 			return false;
diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index d1ef9cb58847..c796e9bc98b6 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -14,6 +14,7 @@ enum pt_capabilities {
 	PT_CAP_ptwrite,
 	PT_CAP_power_event_trace,
 	PT_CAP_event_trace,
+	PT_CAP_tnt_disable,
 	PT_CAP_topa_output,
 	PT_CAP_topa_multiple_entries,
 	PT_CAP_single_range_output,
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 79b392d893e3..efd34cfa1720 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -206,6 +206,7 @@
 #define RTIT_CTL_PTW_EN			BIT(12)
 #define RTIT_CTL_BRANCH_EN		BIT(13)
 #define RTIT_CTL_EVENT_EN		BIT(31)
+#define RTIT_CTL_NOTNT			BIT_ULL(55)
 #define RTIT_CTL_MTC_RANGE_OFFSET	14
 #define RTIT_CTL_MTC_RANGE		(0x0full << RTIT_CTL_MTC_RANGE_OFFSET)
 #define RTIT_CTL_CYC_THRESH_OFFSET	19
-- 
2.25.1

