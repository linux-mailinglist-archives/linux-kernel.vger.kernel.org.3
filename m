Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45AE5155A0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380823AbiD2Ucg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380719AbiD2UcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:32:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66002D64F6;
        Fri, 29 Apr 2022 13:28:56 -0700 (PDT)
Date:   Fri, 29 Apr 2022 20:28:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651264135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0qLDs1FQoOtf1kaF1PC6f++Kg3XUjLbOB+QtW77NRw=;
        b=m230L+qsh3CFHzsuvenObUUrdgvJMfmtz+mf81/yyQnlGsEa7TH7FHJ9l1yf+x6Cp7RjQ6
        Cqq1B4NneDui953iSwgBxm31tjYZArYmdtB7JOZW9ipwXkMPCz8xiO38T2GlUb9Kwiv/i+
        kGg3VOcPJFY0B1Oyk9bDrIouMd1rQw9l5pn5lHbhZpJjSbCMkAupeLP9CO1QB6J7lkMpdg
        uxOHXK5o6erKwq8+4WRYE/S5nVGc4aucyUvbrhm9bUs59HymgJ1dPfCsOjrvbX6cNfGSCh
        GbdeYpBwfZVSH0luMAFS0JXp6C4UfjuHgknNMEdlwfeg6cPL1Jx33vhnWgFx1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651264135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0qLDs1FQoOtf1kaF1PC6f++Kg3XUjLbOB+QtW77NRw=;
        b=Qepn0uSIrMNysuw27yh2UlL11HEun5128y1K1xecXWs6apdmNwzmzwYtxvHNM1OomBlNf8
        1M+r9vMAF+7NpSCQ==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/cpufeatures: Add PerfMonV2 feature bit
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc70e497e22f18e7f05b025bb64ca21cc12b17792=2E16505?=
 =?utf-8?q?15382=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cc70e497e22f18e7f05b025bb64ca21cc12b17792=2E165051?=
 =?utf-8?q?5382=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165126413393.4207.11706652390498011066.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2ae6fea3facb4d704d449e562a4971b1a7465fde
Gitweb:        https://git.kernel.org/tip/2ae6fea3facb4d704d449e562a4971b1a7465fde
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 21 Apr 2022 11:16:53 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 29 Apr 2022 11:06:26 +02:00

x86/cpufeatures: Add PerfMonV2 feature bit

CPUID leaf 0x80000022 i.e. ExtPerfMonAndDbg advertises some
new performance monitoring features for AMD processors.

Bit 0 of EAX indicates support for Performance Monitoring
Version 2 (PerfMonV2) features. If found to be set during
PMU initialization, the EBX bits of the same CPUID function
can be used to determine the number of available PMCs for
different PMU types. Additionally, Core PMCs can be managed
using new global control and status registers.

For better utilization of feature words, PerfMonV2 is added
as a scattered feature bit.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/c70e497e22f18e7f05b025bb64ca21cc12b17792.1650515382.git.sandipan.das@amd.com
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 0d62afd..1ded261 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -201,7 +201,7 @@
 #define X86_FEATURE_INVPCID_SINGLE	( 7*32+ 7) /* Effectively INVPCID && CR4.PCIDE=1 */
 #define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
-/* FREE!                                ( 7*32+10) */
+#define X86_FEATURE_PERFMON_V2		( 7*32+10) /* AMD Performance Monitoring Version 2 */
 #define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
 #define X86_FEATURE_RETPOLINE		( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_LFENCE	( 7*32+13) /* "" Use LFENCE for Spectre variant 2 */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 4143b1e..dbaa832 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -43,6 +43,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
+	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
