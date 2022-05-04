Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D6F519B9C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347220AbiEDJ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347142AbiEDJ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:27:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C551225591;
        Wed,  4 May 2022 02:23:27 -0700 (PDT)
Date:   Wed, 04 May 2022 09:23:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651656206;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=czf1PH9SLYt1VPEfdw9FoF7XoNbsCwWkjnytSHbkiGM=;
        b=HhY+HbAusHA9dhgrcbXFOoBS8F7ei3aG1o9PtdjT8yXdXiMGyUS02956E4bzec88HC3CMg
        kDF/0a+BwVdQxtqT5yUFsEepcK4s1eHE6l9C0Jx/bKlR3ci5vlCuMJTBNFvVGGDgRV+YiQ
        heeUZjLE6dK2+H8tyWdQbOwCuTLeQw1EkTFEHNoKbZSdcUBmE/I5ANyWgiiasakKMCVuHe
        YP3E90kkA581kKSMB3Nouo8vitI8kS3DZUrUCVFSuMHZ1u8LfUpsDS6DELn01W4UA2cahF
        h/6ndt5BW4hJ4JHWRHGrPWr62rx3SWZ3doIxnxXaBqcryFEZe10d4T8euNMNtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651656206;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=czf1PH9SLYt1VPEfdw9FoF7XoNbsCwWkjnytSHbkiGM=;
        b=CBkuSDTyHTanADtRWM67HyJnG8zqzxsVjDvcesuqSvD89Bsi5pisI4yubI9Q/6Zb3ERT1k
        ksXr+HZ1kLm8PwBA==
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
Message-ID: <165165620541.4207.4265515268631344843.tip-bot2@tip-bot2>
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

Commit-ID:     d6d0c7f681fda1d07e005c8f653e578b77a0eb40
Gitweb:        https://git.kernel.org/tip/d6d0c7f681fda1d07e005c8f653e578b77a0eb40
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 21 Apr 2022 11:16:53 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 May 2022 11:17:15 +02:00

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
index 0d62afd..b50e087 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -211,7 +211,7 @@
 #define X86_FEATURE_SSBD		( 7*32+17) /* Speculative Store Bypass Disable */
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
-/* FREE!                                ( 7*32+20) */
+#define X86_FEATURE_PERFMON_V2		( 7*32+20) /* AMD Performance Monitoring Version 2 */
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
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
 
