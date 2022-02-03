Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7A94A8673
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351431AbiBCOd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351288AbiBCOdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F16AC061757;
        Thu,  3 Feb 2022 06:33:29 -0800 (PST)
Date:   Thu, 03 Feb 2022 14:33:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898807;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrSyBIfkD1u8lUNBt/qjhgv5QiFixwQMP35MGmCUe+4=;
        b=pH+1iryBuQNsoxo735oRB2rYGboGPaxEnVSNg0YuklQ2Q5HWXU8UUh3VWFsXpEiRbr0Jro
        VEuWFxVPaheylD9cDYXd56EWa7ayAdVaVkew1s7WKgz+c7hArbeeVdQ0xv+1SDuP67F3Ec
        aRhjSaQlsHaOKk1Ll63w8hVZb0o6TgJYZk8BzLJ5fzEB3rsXPtvGYh4KsP5cMq7jM78poC
        Ye8Xrzk6wI5OX/Mefdo0KK8WrFTntdAJEA6jDs+z94uMnMqTUmrLY6FkEAGh/eDaTHcNUg
        skeZ3Z2XJMws+O1+r/byHrkCslEmg11BnRSc4KDFAuZc/XsTu5/8Jba78V5fkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898807;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrSyBIfkD1u8lUNBt/qjhgv5QiFixwQMP35MGmCUe+4=;
        b=BY1inOG+hWSbu4v0OgcLo071sEKR3gMff7nr2r11WSYVA/JmQhm/ZSi/hpKkmaRvEac7XM
        AfhRSvDG8yuijxDQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Enable PEBS format 5
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1643750603-100733-1-git-send-email-kan.liang@linux.intel.com>
References: <1643750603-100733-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164389880691.16921.406819605673953965.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2145e77fecfb3965b1dc299bac203b167238bd0b
Gitweb:        https://git.kernel.org/tip/2145e77fecfb3965b1dc299bac203b167238bd0b
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 01 Feb 2022 13:23:21 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:43 +01:00

perf/x86/intel: Enable PEBS format 5

The new PEBS Record Format 5 is similar to the PEBS Record Format 4. The
only difference is the layout of the Counter Reset fields of the PEBS
Config Buffer in the DS area. For the PEBS format 4, the Counter Reset
fields allocation is for 8 general-purpose counters followed by 4
fixed-function counters. For the PEBS format 5, the Counter Reset fields
allocation is for 32 general-purpose counters followed by 16
fixed-function counters.

Extend the MAX_PEBS_EVENTS to 32. Add MAX_PEBS_EVENTS_FMT4 for the
previous platform. Except for the DS auto-reload code, other places
already assume 32 counters. Only check the PEBS_FMT in the DS
auto-reload code.

Extend the MAX_FIXED_PEBS_EVENTS to 16, which only impacts the size of
struct debug_store and some local temporary variables. The size of
struct debug_store increases 288B, which is small and should be
acceptable.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1643750603-100733-1-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/ds.c      | 14 +++++++++++---
 arch/x86/include/asm/intel_ds.h |  5 +++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 2e21536..376cc3d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1203,7 +1203,10 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
 	if (hwc->idx >= INTEL_PMC_IDX_FIXED) {
 		base = MSR_RELOAD_FIXED_CTR0;
 		idx = hwc->idx - INTEL_PMC_IDX_FIXED;
-		value = ds->pebs_event_reset[MAX_PEBS_EVENTS + idx];
+		if (x86_pmu.intel_cap.pebs_format < 5)
+			value = ds->pebs_event_reset[MAX_PEBS_EVENTS_FMT4 + idx];
+		else
+			value = ds->pebs_event_reset[MAX_PEBS_EVENTS + idx];
 	}
 	wrmsrl(base + idx, value);
 }
@@ -1232,8 +1235,12 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 		}
 	}
 
-	if (idx >= INTEL_PMC_IDX_FIXED)
-		idx = MAX_PEBS_EVENTS + (idx - INTEL_PMC_IDX_FIXED);
+	if (idx >= INTEL_PMC_IDX_FIXED) {
+		if (x86_pmu.intel_cap.pebs_format < 5)
+			idx = MAX_PEBS_EVENTS_FMT4 + (idx - INTEL_PMC_IDX_FIXED);
+		else
+			idx = MAX_PEBS_EVENTS + (idx - INTEL_PMC_IDX_FIXED);
+	}
 
 	/*
 	 * Use auto-reload if possible to save a MSR write in the PMI.
@@ -2204,6 +2211,7 @@ void __init intel_ds_init(void)
 			break;
 
 		case 4:
+		case 5:
 			x86_pmu.drain_pebs = intel_pmu_drain_pebs_icl;
 			x86_pmu.pebs_record_size = sizeof(struct pebs_basic);
 			if (x86_pmu.intel_cap.pebs_baseline) {
diff --git a/arch/x86/include/asm/intel_ds.h b/arch/x86/include/asm/intel_ds.h
index 8380c3d..2f9eeb5 100644
--- a/arch/x86/include/asm/intel_ds.h
+++ b/arch/x86/include/asm/intel_ds.h
@@ -7,8 +7,9 @@
 #define PEBS_BUFFER_SIZE	(PAGE_SIZE << 4)
 
 /* The maximal number of PEBS events: */
-#define MAX_PEBS_EVENTS		8
-#define MAX_FIXED_PEBS_EVENTS	4
+#define MAX_PEBS_EVENTS_FMT4	8
+#define MAX_PEBS_EVENTS		32
+#define MAX_FIXED_PEBS_EVENTS	16
 
 /*
  * A debug store configuration.
