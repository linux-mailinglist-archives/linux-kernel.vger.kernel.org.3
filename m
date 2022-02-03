Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F2E4A8D31
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354040AbiBCU1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbiBCU1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:27:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B218C061714;
        Thu,  3 Feb 2022 12:27:36 -0800 (PST)
Date:   Thu, 03 Feb 2022 20:27:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643920053;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5VjKzhwn0zNRzX5kh/ilzafIOp9ufeGT+DH3BSRAQY=;
        b=4NhybIwh0zLj686mxIwMtBf1fwN3ApTnDdda1iLANTK0LwCEkv1+x/McYrG6sGeO2Q9bRg
        Jajcx2ttIG943zdkwiis4LMlie7zxwUJvlbfhgW7ocbU0KiRiLpUY+yr1F4MelpbAk+scJ
        3vBfFCvFRJi+i1HIRiu6dXb4q6fHIkClSj+ccT1O3ze0dCaacJgvpNwlbHyFTfnWSJqdM3
        ybF8aplaCnJb4eU7C4ey6lRbyEWUOwV6H8wzKxg9fD6A4/90AgY/ChJ01EmhX5cn6ik7Oh
        YzHIhDeIY7bIt6zE/OJjK+Z2LcIfhATbOwXN7jlY20EhkCX9OBFGftvveERfww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643920053;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5VjKzhwn0zNRzX5kh/ilzafIOp9ufeGT+DH3BSRAQY=;
        b=G2kFfTDo30AW8f9SuANeYPNUVmxGvsu4jejTQ0sA8Hx9CqB3OIJvp+E9U/ADe4ReUANmLM
        guFN5uNNh7KSymAw==
From:   "tip-bot2 for Jim Mattson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeatures: Put the AMX macros in the word 18 block
Cc:     Jim Mattson <jmattson@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220203194308.2469117-1-jmattson@google.com>
References: <20220203194308.2469117-1-jmattson@google.com>
MIME-Version: 1.0
Message-ID: <164392005238.16921.14502952787568849778.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     ae75fa54228162ecd65341f9780886f21f557cc4
Gitweb:        https://git.kernel.org/tip/ae75fa54228162ecd65341f9780886f21f557cc4
Author:        Jim Mattson <jmattson@google.com>
AuthorDate:    Thu, 03 Feb 2022 11:43:07 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 03 Feb 2022 12:19:39 -08:00

x86/cpufeatures: Put the AMX macros in the word 18 block

These macros are for bits in CPUID.(EAX=7,ECX=0):EDX, not for bits in
CPUID(EAX=7,ECX=1):EAX. Put them with their brethren.

Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220203194308.2469117-1-jmattson@google.com
---
 arch/x86/include/asm/cpufeatures.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6db4e29..4cc0ef9 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -299,9 +299,6 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
-#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
-#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
-#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX int8 Support */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
@@ -392,6 +389,9 @@
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
 #define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
+#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
+#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
+#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX int8 Support */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
