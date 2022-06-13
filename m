Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946AA548266
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbiFMI3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbiFMI3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:29:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C9F19FBC;
        Mon, 13 Jun 2022 01:29:05 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:29:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655108943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSD8Eqjr+TZZRkZWNzZmMM4WgY0VJDZoWv7skRzV8RY=;
        b=cRSIpQabmSPmWA739gpycVuPKo14FmPEeagUwtNJDrO9hFdx+sy10ENtptFwoZkFzhm/13
        Zfux9XEi8vHQX897KfKIvAsCAXgwXXMJwvD1WmY51BZ3DCSIvao6th5EnIVy8fwMUoILlr
        KHgGdQ2dYCRFgPnvMTyfj90wQHBksAeKzTAujH7hxFqE8f2fkrznp7Gdjzxy6HB2URhgoa
        cJP6aDlRTAKO6FpQWsXPR7DkFPGLIcpbwIg25wWY883OEw0amu74XatHXdGctdw7MenAA+
        wSlwAW7ONDH7R0qUIqedhden8T4VqaFVXMA+X4RjPgxYbJqkPD3kLoFLQHv56g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655108943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSD8Eqjr+TZZRkZWNzZmMM4WgY0VJDZoWv7skRzV8RY=;
        b=X6UMnU9n2iWdkRVt7t5CXJuqyOnjJTaDTaFdv9ZzPa2ts7hbQva3Yoep7e3m6IMeDmZJrf
        kaDzUlHc3t6jBODA==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/uncore: Add PerfMonV2 DF event format
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cffc24d5a3375b1d6e457d88e83241114de5c1942=2E16529?=
 =?utf-8?q?54372=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cffc24d5a3375b1d6e457d88e83241114de5c1942=2E165295?=
 =?utf-8?q?4372=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165510894274.4207.3868534133693973490.tip-bot2@tip-bot2>
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

Commit-ID:     c390241a93260b377c84ad9e7cd5242adf667aac
Gitweb:        https://git.kernel.org/tip/c390241a93260b377c84ad9e7cd5242adf667aac
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 19 May 2022 15:33:33 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:15:14 +02:00

perf/x86/amd/uncore: Add PerfMonV2 DF event format

If AMD Performance Monitoring Version 2 (PerfMonV2) is
supported, use bits 0-7, 32-37 as EventSelect and bits
8-15, 24-27 as UnitMask for Data Fabric (DF) events.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/ffc24d5a3375b1d6e457d88e83241114de5c1942.1652954372.git.sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c      | 24 +++++++++++++++++-------
 arch/x86/include/asm/perf_event.h | 13 +++++++++++++
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 233dd40..ff4238e 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -209,10 +209,14 @@ static int amd_uncore_event_init(struct perf_event *event)
 {
 	struct amd_uncore *uncore;
 	struct hw_perf_event *hwc = &event->hw;
+	u64 event_mask = AMD64_RAW_EVENT_MASK_NB;
 
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
+	if (pmu_version >= 2 && is_nb_event(event))
+		event_mask = AMD64_PERFMON_V2_RAW_EVENT_MASK_NB;
+
 	/*
 	 * NB and Last level cache counters (MSRs) are shared across all cores
 	 * that share the same NB / Last level cache.  On family 16h and below,
@@ -221,7 +225,7 @@ static int amd_uncore_event_init(struct perf_event *event)
 	 * out. So we do not support sampling and per-thread events via
 	 * CAP_NO_INTERRUPT, and we do not enable counter overflow interrupts:
 	 */
-	hwc->config = event->attr.config & AMD64_RAW_EVENT_MASK_NB;
+	hwc->config = event->attr.config & event_mask;
 	hwc->idx = -1;
 
 	if (event->cpu < 0)
@@ -300,8 +304,10 @@ static struct device_attribute format_attr_##_var =			\
 
 DEFINE_UNCORE_FORMAT_ATTR(event12,	event,		"config:0-7,32-35");
 DEFINE_UNCORE_FORMAT_ATTR(event14,	event,		"config:0-7,32-35,59-60"); /* F17h+ DF */
+DEFINE_UNCORE_FORMAT_ATTR(event14v2,	event,		"config:0-7,32-37");	   /* PerfMonV2 DF */
 DEFINE_UNCORE_FORMAT_ATTR(event8,	event,		"config:0-7");		   /* F17h+ L3 */
-DEFINE_UNCORE_FORMAT_ATTR(umask,	umask,		"config:8-15");
+DEFINE_UNCORE_FORMAT_ATTR(umask8,	umask,		"config:8-15");
+DEFINE_UNCORE_FORMAT_ATTR(umask12,	umask,		"config:8-15,24-27");	   /* PerfMonV2 DF */
 DEFINE_UNCORE_FORMAT_ATTR(coreid,	coreid,		"config:42-44");	   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(slicemask,	slicemask,	"config:48-51");	   /* F17h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(threadmask8,	threadmask,	"config:56-63");	   /* F17h L3 */
@@ -313,14 +319,14 @@ DEFINE_UNCORE_FORMAT_ATTR(sliceid,	sliceid,	"config:48-50");	   /* F19h L3 */
 /* Common DF and NB attributes */
 static struct attribute *amd_uncore_df_format_attr[] = {
 	&format_attr_event12.attr,	/* event */
-	&format_attr_umask.attr,	/* umask */
+	&format_attr_umask8.attr,	/* umask */
 	NULL,
 };
 
 /* Common L2 and L3 attributes */
 static struct attribute *amd_uncore_l3_format_attr[] = {
 	&format_attr_event12.attr,	/* event */
-	&format_attr_umask.attr,	/* umask */
+	&format_attr_umask8.attr,	/* umask */
 	NULL,				/* threadmask */
 	NULL,
 };
@@ -659,8 +665,12 @@ static int __init amd_uncore_init(void)
 	}
 
 	if (boot_cpu_has(X86_FEATURE_PERFCTR_NB)) {
-		if (boot_cpu_data.x86 >= 0x17)
+		if (pmu_version >= 2) {
+			*df_attr++ = &format_attr_event14v2.attr;
+			*df_attr++ = &format_attr_umask12.attr;
+		} else if (boot_cpu_data.x86 >= 0x17) {
 			*df_attr = &format_attr_event14.attr;
+		}
 
 		amd_uncore_nb = alloc_percpu(struct amd_uncore *);
 		if (!amd_uncore_nb) {
@@ -686,11 +696,11 @@ static int __init amd_uncore_init(void)
 	if (boot_cpu_has(X86_FEATURE_PERFCTR_LLC)) {
 		if (boot_cpu_data.x86 >= 0x19) {
 			*l3_attr++ = &format_attr_event8.attr;
-			*l3_attr++ = &format_attr_umask.attr;
+			*l3_attr++ = &format_attr_umask8.attr;
 			*l3_attr++ = &format_attr_threadmask2.attr;
 		} else if (boot_cpu_data.x86 >= 0x17) {
 			*l3_attr++ = &format_attr_event8.attr;
-			*l3_attr++ = &format_attr_umask.attr;
+			*l3_attr++ = &format_attr_umask8.attr;
 			*l3_attr++ = &format_attr_threadmask8.attr;
 		}
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index af157aa..34348ae 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -89,6 +89,19 @@
 #define AMD64_RAW_EVENT_MASK_NB		\
 	(AMD64_EVENTSEL_EVENT        |  \
 	 ARCH_PERFMON_EVENTSEL_UMASK)
+
+#define AMD64_PERFMON_V2_EVENTSEL_EVENT_NB	\
+	(AMD64_EVENTSEL_EVENT	|		\
+	 GENMASK_ULL(37, 36))
+
+#define AMD64_PERFMON_V2_EVENTSEL_UMASK_NB	\
+	(ARCH_PERFMON_EVENTSEL_UMASK	|	\
+	 GENMASK_ULL(27, 24))
+
+#define AMD64_PERFMON_V2_RAW_EVENT_MASK_NB		\
+	(AMD64_PERFMON_V2_EVENTSEL_EVENT_NB	|	\
+	 AMD64_PERFMON_V2_EVENTSEL_UMASK_NB)
+
 #define AMD64_NUM_COUNTERS				4
 #define AMD64_NUM_COUNTERS_CORE				6
 #define AMD64_NUM_COUNTERS_NB				4
