Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABBF5A31EA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbiHZWSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345307AbiHZWR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:17:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B29DD74A;
        Fri, 26 Aug 2022 15:16:15 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:16:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661552173;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/onY6OjdcfAY5UJJfzhSdFk5JT9cDLoqHG324W1o3U=;
        b=xdT7ei+Rtihwi78VjHSbtkryA3G0Np3HT8XbT913U+Qnytes65Q3xcdku2mefO+QrcXvDu
        0t0SCooFlqvdgNC0wcgp7m47PH0Na+mxaJhJ0DopnF8ljmp4bropr7jtZlDg/kKvYxoOJh
        UEba5B23DavIsoQnjyTjjkrpELei+W6SWEaVB0lXaZ0xYv9smK5oFBAzwZK8Sjjh8r/HU8
        bMe8VxjPLVZiL8mCCHhC3QxbZ0r1TYdfDksugMgBpfpVrdsld9judJ42f66LouICEvHDCR
        Hb5dZeKyzxv3HJIgkzfxS2Ijcazz6E+480XvwLrYbjoN8rx7ds0foady/Fxatw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661552173;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/onY6OjdcfAY5UJJfzhSdFk5JT9cDLoqHG324W1o3U=;
        b=l8G5EnzH7ZJb9OjxIonDgfX+MS1HSs6NXFhfeVVUzj+aywhMr/o8WXKjbXO6ccdcI6+vKR
        Mi3jqhplNQ3TfGAw==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/brs: Move feature-specific functions
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb60283b57179475d18ee242d117c335c16733693=2E16602?=
 =?utf-8?q?11399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cb60283b57179475d18ee242d117c335c16733693=2E166021?=
 =?utf-8?q?1399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <166155217143.401.9259454199824421303.tip-bot2@tip-bot2>
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

Commit-ID:     b40d0156f560932d14e3957579b6508f8d065260
Gitweb:        https://git.kernel.org/tip/b40d0156f560932d14e3957579b6508f8d065260
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 11 Aug 2022 17:59:49 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 27 Aug 2022 00:05:41 +02:00

perf/x86/amd/brs: Move feature-specific functions

Move some of the Branch Sampling (BRS) specific functions out of the Core
events sources and into the BRS sources in preparation for adding other
mechanisms to record branches.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/b60283b57179475d18ee242d117c335c16733693.1660211399.git.sandipan.das@amd.com
---
 arch/x86/events/amd/brs.c    | 69 ++++++++++++++++++++++++++++++++++-
 arch/x86/events/amd/core.c   | 70 +----------------------------------
 arch/x86/events/perf_event.h |  7 ++--
 3 files changed, 76 insertions(+), 70 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index bee8765..f1bff15 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -81,7 +81,7 @@ static bool __init amd_brs_detect(void)
  * a br_sel_map. Software filtering is not supported because it would not correlate well
  * with a sampling period.
  */
-int amd_brs_setup_filter(struct perf_event *event)
+static int amd_brs_setup_filter(struct perf_event *event)
 {
 	u64 type = event->attr.branch_sample_type;
 
@@ -96,6 +96,73 @@ int amd_brs_setup_filter(struct perf_event *event)
 	return 0;
 }
 
+static inline int amd_is_brs_event(struct perf_event *e)
+{
+	return (e->hw.config & AMD64_RAW_EVENT_MASK) == AMD_FAM19H_BRS_EVENT;
+}
+
+int amd_brs_hw_config(struct perf_event *event)
+{
+	int ret = 0;
+
+	/*
+	 * Due to interrupt holding, BRS is not recommended in
+	 * counting mode.
+	 */
+	if (!is_sampling_event(event))
+		return -EINVAL;
+
+	/*
+	 * Due to the way BRS operates by holding the interrupt until
+	 * lbr_nr entries have been captured, it does not make sense
+	 * to allow sampling on BRS with an event that does not match
+	 * what BRS is capturing, i.e., retired taken branches.
+	 * Otherwise the correlation with the event's period is even
+	 * more loose:
+	 *
+	 * With retired taken branch:
+	 *   Effective P = P + 16 + X
+	 * With any other event:
+	 *   Effective P = P + Y + X
+	 *
+	 * Where X is the number of taken branches due to interrupt
+	 * skid. Skid is large.
+	 *
+	 * Where Y is the occurences of the event while BRS is
+	 * capturing the lbr_nr entries.
+	 *
+	 * By using retired taken branches, we limit the impact on the
+	 * Y variable. We know it cannot be more than the depth of
+	 * BRS.
+	 */
+	if (!amd_is_brs_event(event))
+		return -EINVAL;
+
+	/*
+	 * BRS implementation does not work with frequency mode
+	 * reprogramming of the period.
+	 */
+	if (event->attr.freq)
+		return -EINVAL;
+	/*
+	 * The kernel subtracts BRS depth from period, so it must
+	 * be big enough.
+	 */
+	if (event->attr.sample_period <= x86_pmu.lbr_nr)
+		return -EINVAL;
+
+	/*
+	 * Check if we can allow PERF_SAMPLE_BRANCH_STACK
+	 */
+	ret = amd_brs_setup_filter(event);
+
+	/* only set in case of success */
+	if (!ret)
+		event->hw.flags |= PERF_X86_EVENT_AMD_BRS;
+
+	return ret;
+}
+
 /* tos = top of stack, i.e., last valid entry written */
 static inline int amd_brs_get_tos(union amd_debug_extn_cfg *cfg)
 {
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 9ac3718..e32a278 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -330,16 +330,8 @@ static inline bool amd_is_pair_event_code(struct hw_perf_event *hwc)
 	}
 }
 
-#define AMD_FAM19H_BRS_EVENT 0xc4 /* RETIRED_TAKEN_BRANCH_INSTRUCTIONS */
-static inline int amd_is_brs_event(struct perf_event *e)
-{
-	return (e->hw.config & AMD64_RAW_EVENT_MASK) == AMD_FAM19H_BRS_EVENT;
-}
-
 static int amd_core_hw_config(struct perf_event *event)
 {
-	int ret = 0;
-
 	if (event->attr.exclude_host && event->attr.exclude_guest)
 		/*
 		 * When HO == GO == 1 the hardware treats that as GO == HO == 0
@@ -356,66 +348,10 @@ static int amd_core_hw_config(struct perf_event *event)
 	if ((x86_pmu.flags & PMU_FL_PAIR) && amd_is_pair_event_code(&event->hw))
 		event->hw.flags |= PERF_X86_EVENT_PAIR;
 
-	/*
-	 * if branch stack is requested
-	 */
-	if (has_branch_stack(event)) {
-		/*
-		 * Due to interrupt holding, BRS is not recommended in
-		 * counting mode.
-		 */
-		if (!is_sampling_event(event))
-			return -EINVAL;
-
-		/*
-		 * Due to the way BRS operates by holding the interrupt until
-		 * lbr_nr entries have been captured, it does not make sense
-		 * to allow sampling on BRS with an event that does not match
-		 * what BRS is capturing, i.e., retired taken branches.
-		 * Otherwise the correlation with the event's period is even
-		 * more loose:
-		 *
-		 * With retired taken branch:
-		 *   Effective P = P + 16 + X
-		 * With any other event:
-		 *   Effective P = P + Y + X
-		 *
-		 * Where X is the number of taken branches due to interrupt
-		 * skid. Skid is large.
-		 *
-		 * Where Y is the occurences of the event while BRS is
-		 * capturing the lbr_nr entries.
-		 *
-		 * By using retired taken branches, we limit the impact on the
-		 * Y variable. We know it cannot be more than the depth of
-		 * BRS.
-		 */
-		if (!amd_is_brs_event(event))
-			return -EINVAL;
+	if (has_branch_stack(event))
+		return amd_brs_hw_config(event);
 
-		/*
-		 * BRS implementation does not work with frequency mode
-		 * reprogramming of the period.
-		 */
-		if (event->attr.freq)
-			return -EINVAL;
-		/*
-		 * The kernel subtracts BRS depth from period, so it must
-		 * be big enough.
-		 */
-		if (event->attr.sample_period <= x86_pmu.lbr_nr)
-			return -EINVAL;
-
-		/*
-		 * Check if we can allow PERF_SAMPLE_BRANCH_STACK
-		 */
-		ret = amd_brs_setup_filter(event);
-
-		/* only set in case of success */
-		if (!ret)
-			event->hw.flags |= PERF_X86_EVENT_AMD_BRS;
-	}
-	return ret;
+	return 0;
 }
 
 static inline int amd_is_nb_event(struct hw_perf_event *hwc)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ba3d24a..5deb34e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1233,6 +1233,9 @@ static inline bool fixed_counter_disabled(int i, struct pmu *pmu)
 int amd_pmu_init(void);
 
 #ifdef CONFIG_PERF_EVENTS_AMD_BRS
+
+#define AMD_FAM19H_BRS_EVENT 0xc4 /* RETIRED_TAKEN_BRANCH_INSTRUCTIONS */
+
 int amd_brs_init(void);
 void amd_brs_disable(void);
 void amd_brs_enable(void);
@@ -1241,7 +1244,7 @@ void amd_brs_disable_all(void);
 void amd_brs_drain(void);
 void amd_brs_lopwr_init(void);
 void amd_brs_disable_all(void);
-int amd_brs_setup_filter(struct perf_event *event);
+int amd_brs_hw_config(struct perf_event *event);
 void amd_brs_reset(void);
 
 static inline void amd_pmu_brs_add(struct perf_event *event)
@@ -1277,7 +1280,7 @@ static inline void amd_brs_enable(void) {}
 static inline void amd_brs_drain(void) {}
 static inline void amd_brs_lopwr_init(void) {}
 static inline void amd_brs_disable_all(void) {}
-static inline int amd_brs_setup_filter(struct perf_event *event)
+static inline int amd_brs_hw_config(struct perf_event *event)
 {
 	return 0;
 }
