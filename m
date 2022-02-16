Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3CA4B8BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiBPO6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:58:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiBPO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:58:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FF96004F;
        Wed, 16 Feb 2022 06:58:02 -0800 (PST)
Date:   Wed, 16 Feb 2022 14:57:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645023479;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKs0Hzo9s/Ylg3jYir/Ngp+UMB3ioXvWouE0YNl2mtw=;
        b=H0JXCL5CKMdTxtgvqVGXDPbaIOza7gqedMzvW8PIzxdV8jyP3PlwVkngDxLg1p3yRcEpt5
        Fd7AtJhBLTrxfwzRBllmJkmcSY9rxm649ETmZD/RqWvAigRADIud8HI667CveUkxYNLHWI
        iZ3bGlFtJmpwQqaVd9dqF8JwoqpWGD7bWNtgB/evCwjuyF6G8ykeG/HJcl1GcBNMLLIQ/P
        fgn+tWEmg+VfaEdp8zXtYZd4VRKtbPJq3OulB+mtz+0979mKehzkSX7uSmE0nVVgKmNT1D
        ATnCz1wwJJ0PdJpkunLs/+TKuditoMiu0o4yAhLQ4HmXcJ6gmYHTMpZwbu+KXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645023479;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKs0Hzo9s/Ylg3jYir/Ngp+UMB3ioXvWouE0YNl2mtw=;
        b=KhpW36DMpD9ZSF5T/ikpawAFOlI7cGDfBmni34y7FupHJI13rF1DbmYkUGHoj/27J1bt8G
        8vAnOtt0ZmOQuVAA==
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Add a capability and config bit
 for disabling TNTs
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220126104815.2807416-3-adrian.hunter@intel.com>
References: <20220126104815.2807416-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <164502347832.16921.5715898038732914778.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     161a9a33702a2e65a4118dacb449505ac8ce3122
Gitweb:        https://git.kernel.org/tip/161a9a33702a2e65a4118dacb449505ac8ce3122
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Wed, 26 Jan 2022 12:48:15 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Feb 2022 17:47:11 +01:00

perf/x86/intel/pt: Add a capability and config bit for disabling TNTs

As of Intel SDM (https://www.intel.com/sdm) version 076, there is a new
Intel PT feature called TNT-Disable which is enabled config bit 55.

TNT-Disable disables Taken-Not-Taken packets to reduce the tracing
overhead, but with the result that exact control flow information is
lost.

Add a capability and config bit for TNT-Disable.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20220126104815.2807416-3-adrian.hunter@intel.com
---
 arch/x86/events/intel/pt.c       | 8 ++++++++
 arch/x86/include/asm/intel_pt.h  | 1 +
 arch/x86/include/asm/msr-index.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index f339c88..aa66c0c 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -60,6 +60,7 @@ static struct pt_cap_desc {
 	PT_CAP(ptwrite,			0, CPUID_EBX, BIT(4)),
 	PT_CAP(power_event_trace,	0, CPUID_EBX, BIT(5)),
 	PT_CAP(event_trace,		0, CPUID_EBX, BIT(7)),
+	PT_CAP(tnt_disable,		0, CPUID_EBX, BIT(8)),
 	PT_CAP(topa_output,		0, CPUID_ECX, BIT(0)),
 	PT_CAP(topa_multiple_entries,	0, CPUID_ECX, BIT(1)),
 	PT_CAP(single_range_output,	0, CPUID_ECX, BIT(2)),
@@ -112,6 +113,7 @@ PMU_FORMAT_ATTR(noretcomp,	"config:11"	);
 PMU_FORMAT_ATTR(ptw,		"config:12"	);
 PMU_FORMAT_ATTR(branch,		"config:13"	);
 PMU_FORMAT_ATTR(event,		"config:31"	);
+PMU_FORMAT_ATTR(notnt,		"config:55"	);
 PMU_FORMAT_ATTR(mtc_period,	"config:14-17"	);
 PMU_FORMAT_ATTR(cyc_thresh,	"config:19-22"	);
 PMU_FORMAT_ATTR(psb_period,	"config:24-27"	);
@@ -121,6 +123,7 @@ static struct attribute *pt_formats_attr[] = {
 	&format_attr_cyc.attr,
 	&format_attr_pwr_evt.attr,
 	&format_attr_event.attr,
+	&format_attr_notnt.attr,
 	&format_attr_fup_on_ptw.attr,
 	&format_attr_mtc.attr,
 	&format_attr_tsc.attr,
@@ -302,6 +305,7 @@ fail:
 			RTIT_CTL_MTC		| \
 			RTIT_CTL_PWR_EVT_EN	| \
 			RTIT_CTL_EVENT_EN	| \
+			RTIT_CTL_NOTNT		| \
 			RTIT_CTL_FUP_ON_PTW	| \
 			RTIT_CTL_PTW_EN)
 
@@ -360,6 +364,10 @@ static bool pt_event_valid(struct perf_event *event)
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
index d1ef9cb..c796e9b 100644
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
index 79b392d..efd34cf 100644
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
