Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5CA4B8BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbiBPO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:58:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiBPO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:58:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2859C66204;
        Wed, 16 Feb 2022 06:58:02 -0800 (PST)
Date:   Wed, 16 Feb 2022 14:57:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645023480;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gKvTWrHCwjvcyRC9bhZTpUpXLRREYqwtipbQCdJ0zIc=;
        b=1DvSjw+Y9j/rdwHOK9fzDcqgkisYeGJ+1mp48L4W5hJonTYbVUiYv0mjfbnm+7W94uWeUG
        XNvzlT9jxbLJuLkIdPbHoydHtEapPC3NDQrM+gGujGQKRXdF4/Zp2nmkBHepF2i+AdTSaK
        6Cr0Dkon3DvhYRI6YUjogS5OPAANrkfJffqSUEsfcUfQW6mnBtZDDDeDnCDd8xOliGwuk1
        RGUiyU+ujE0q0k9eUQn/WonU2xiMJuChBg6T4Bvy4t1x6hIt4fda9ghuT2fbvWueN+Tp1j
        prkrZNaWVkzjXyEeUcbwgcidTU/TY5kw1+2qaOtZTpl/OzerABMRU8rsBhyyfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645023480;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gKvTWrHCwjvcyRC9bhZTpUpXLRREYqwtipbQCdJ0zIc=;
        b=N27luKwUGcBzff58fJEoyLESqV8m/76uoCdGy5ALd/TTu2Al9WKK5P8lwtQjnRCwyjYxK9
        6vTRW2ir+U3PR/Bw==
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Add a capability and config bit
 for event tracing
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220126104815.2807416-2-adrian.hunter@intel.com>
References: <20220126104815.2807416-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <164502347917.16921.10455569552528508195.tip-bot2@tip-bot2>
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

Commit-ID:     28c24ded649cf068ca518f2a3d78f5e7e06d41d8
Gitweb:        https://git.kernel.org/tip/28c24ded649cf068ca518f2a3d78f5e7e06d41d8
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Wed, 26 Jan 2022 12:48:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Feb 2022 17:47:11 +01:00

perf/x86/intel/pt: Add a capability and config bit for event tracing

As of Intel SDM (https://www.intel.com/sdm) version 076, there is a new
Intel PT feature called Event Trace which is enabled config bit 31.

Event Trace exposes details about asynchronous events such as interrupts
and VM-Entry/Exit.

Add a capability and config bit for Event Trace.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20220126104815.2807416-2-adrian.hunter@intel.com
---
 arch/x86/events/intel/pt.c       | 8 ++++++++
 arch/x86/include/asm/intel_pt.h  | 1 +
 arch/x86/include/asm/msr-index.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index f061dc2..f339c88 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -59,6 +59,7 @@ static struct pt_cap_desc {
 	PT_CAP(mtc,			0, CPUID_EBX, BIT(3)),
 	PT_CAP(ptwrite,			0, CPUID_EBX, BIT(4)),
 	PT_CAP(power_event_trace,	0, CPUID_EBX, BIT(5)),
+	PT_CAP(event_trace,		0, CPUID_EBX, BIT(7)),
 	PT_CAP(topa_output,		0, CPUID_ECX, BIT(0)),
 	PT_CAP(topa_multiple_entries,	0, CPUID_ECX, BIT(1)),
 	PT_CAP(single_range_output,	0, CPUID_ECX, BIT(2)),
@@ -110,6 +111,7 @@ PMU_FORMAT_ATTR(tsc,		"config:10"	);
 PMU_FORMAT_ATTR(noretcomp,	"config:11"	);
 PMU_FORMAT_ATTR(ptw,		"config:12"	);
 PMU_FORMAT_ATTR(branch,		"config:13"	);
+PMU_FORMAT_ATTR(event,		"config:31"	);
 PMU_FORMAT_ATTR(mtc_period,	"config:14-17"	);
 PMU_FORMAT_ATTR(cyc_thresh,	"config:19-22"	);
 PMU_FORMAT_ATTR(psb_period,	"config:24-27"	);
@@ -118,6 +120,7 @@ static struct attribute *pt_formats_attr[] = {
 	&format_attr_pt.attr,
 	&format_attr_cyc.attr,
 	&format_attr_pwr_evt.attr,
+	&format_attr_event.attr,
 	&format_attr_fup_on_ptw.attr,
 	&format_attr_mtc.attr,
 	&format_attr_tsc.attr,
@@ -298,6 +301,7 @@ fail:
 			RTIT_CTL_CYC_PSB	| \
 			RTIT_CTL_MTC		| \
 			RTIT_CTL_PWR_EVT_EN	| \
+			RTIT_CTL_EVENT_EN	| \
 			RTIT_CTL_FUP_ON_PTW	| \
 			RTIT_CTL_PTW_EN)
 
@@ -352,6 +356,10 @@ static bool pt_event_valid(struct perf_event *event)
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
index ebe8d2e..d1ef9cb 100644
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
index 3faf0f9..79b392d 100644
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
