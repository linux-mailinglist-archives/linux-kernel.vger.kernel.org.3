Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493F24F3847
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376514AbiDELWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241698AbiDEIsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:48:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484B32B26E;
        Tue,  5 Apr 2022 01:36:54 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:36:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j0UT6sv/S6idd018aiItGKYe6/1J8gKguGSUv0gFuOM=;
        b=ErpivOO9llnRjAWzniTwC6Ney8Wso/mIxlO/DUxo8XNzjGOGjMRte/orAryozXl7HyM1PN
        6cMqatRckfpidxv7WvCkDOWOs5l+4gQMQJ5AZShjf2n9iCtQIPXrtqVPCaQB7oWtbWfDdW
        j+6pVgI/AGvlA1pAmt3Lm4QMWpUIj725MDH1okPTVaf6zpuq4L6WWADF4UJ7Q+WF2mS4gV
        OPvWtil+062XYD00KYvJ51ERoT+SMMpw/zmjcyiqxYFOWyE1yJ6XCxLeQ1dKyu6DkanUPf
        +vXwyjCRGTMatcztldo4gDSSYlnZ0Yp0VER92ayyAlr4C/ZsLKs4JXaDdf6V4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j0UT6sv/S6idd018aiItGKYe6/1J8gKguGSUv0gFuOM=;
        b=eW9w7COCQK0YV7dwstCo41nUOqy/siJTzMp1ah3vfmtgDB7cvip0nNJpyaFmWc2CNwTwxL
        R9uWjpeVkgaE0vBQ==
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Add AMD branch sampling period adjustment
Cc:     Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220322221517.2510440-7-eranian@google.com>
References: <20220322221517.2510440-7-eranian@google.com>
MIME-Version: 1.0
Message-ID: <164914780001.389.11201417616556364150.tip-bot2@tip-bot2>
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

Commit-ID:     ba2fe7500845a30fc845a72081999cf632051862
Gitweb:        https://git.kernel.org/tip/ba2fe7500845a30fc845a72081999cf632051862
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Tue, 22 Mar 2022 15:15:10 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:37 +02:00

perf/x86/amd: Add AMD branch sampling period adjustment

Add code to adjust the sampling event period when used with the Branch
Sampling feature (BRS). Given the depth of the BRS (16), the period is
reduced by that depth such that in the best case scenario, BRS saturates at
the desired sampling period. In practice, though, the processor may execute
more branches. Given a desired period P and a depth D, the kernel programs
the actual period at P - D. After P occurrences of the sampling event, the
counter overflows. It then may take X branches (skid) before the NMI is
caught and held by the hardware and BRS activates. Then, after D branches,
BRS saturates and the NMI is delivered.  With no skid, the effective period
would be (P - D) + D = P. In practice, however, it will likely be (P - D) +
X + D. There is no way to eliminate X or predict X.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220322221517.2510440-7-eranian@google.com
---
 arch/x86/events/core.c       |  7 +++++++
 arch/x86/events/perf_event.h | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7ada917..54f992e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1375,6 +1375,13 @@ int x86_perf_event_set_period(struct perf_event *event)
 		return x86_pmu.set_topdown_event_period(event);
 
 	/*
+	 * decrease period by the depth of the BRS feature to get
+	 * the last N taken branches and approximate the desired period
+	 */
+	if (has_branch_stack(event))
+		period = amd_brs_adjust_period(period);
+
+	/*
 	 * If we are way outside a reasonable range then just skip forward:
 	 */
 	if (unlikely(left <= -period)) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 6f12651..d91ff2c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1263,6 +1263,14 @@ static inline bool amd_brs_active(void)
 	return cpuc->brs_active;
 }
 
+static inline s64 amd_brs_adjust_period(s64 period)
+{
+	if (period > x86_pmu.lbr_nr)
+		return period - x86_pmu.lbr_nr;
+
+	return period;
+}
+
 #else /* CONFIG_CPU_SUP_AMD */
 
 static inline int amd_pmu_init(void)
@@ -1287,6 +1295,10 @@ static inline void amd_brs_disable_all(void)
 {
 }
 
+static inline s64 amd_brs_adjust_period(s64 period)
+{
+	return period;
+}
 #endif /* CONFIG_CPU_SUP_AMD */
 
 static inline int is_pebs_pt(struct perf_event *event)
