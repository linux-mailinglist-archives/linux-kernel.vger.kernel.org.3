Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0BA4A8CA7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353831AbiBCToP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiBCToM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:44:12 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FDEC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 11:44:12 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id h11-20020a170902eecb00b0014cc91d4bc4so1753750plb.16
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 11:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to;
        bh=uIZzaMpM3HaDO6cWITwTjwY2xcC3K/nMvFelzMai3xA=;
        b=Ttqw71MHgVKBj7jy1G2Cj+63M6I140I9QXq68KD+Kwmblnvhsp8wOlp4SO36CiaGLG
         tthhK9NFZY5xi2cAMwwu/Jvol5881pe1lKcEy/jMn63qXhBQlCGlwIGeEIU42FB64B2Z
         NP6ADMBXiQR6Sgj+KnEwgCmEu5eE0hzweeDYkuXRvaZVRAXflhbu9Ko9rP98C3qkiH4G
         qgGOmIIJpQbs6WGt+XWp2mJvNjm7as9hsz9ajFzMKwREQtZ9I+UHyqtZE/E+82TF3Mpr
         S6u0PtBZNQFNRBstpXQNDqUKmcvXjrhud3HYXe82vY7G2/jxuKOuXFY/Z/E8u4Pl6l1H
         VKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=uIZzaMpM3HaDO6cWITwTjwY2xcC3K/nMvFelzMai3xA=;
        b=UQW3yjaFjGT4MrwHlnQasRT61Qkm2W028X5LeFEeEFPIdZSUWUWFPhA1bTfk1rAWIi
         iKSqLUGrvmICJdsgQq2SMR4JmAZXufr9dHCJ66AfCJP0D9M8rO7XIEQnxpGLSYixCUca
         X7HnEpwhAN6QAU+Yl/L3+uW6NfidVGzl9hb5Kxinx4BC1k3FVPxDb2cIWvb4r5T18+6J
         nFHCSPhyZ6G00IDiPPf+vX/l1ttlkc2rYt4ek08QMqBEGsQ7HQdwdGPBpoSO241B7y2F
         YvM4u+rRQA2SInQUJDpTgni8D6uE3cB2c/c9y6a0rsb5ASORgUoH1cA8qjWEpsJ6t4Wm
         TLfQ==
X-Gm-Message-State: AOAM530ttOrbU2wnxf7mKw/dIGJxLE03++n2nlmkvejUBo5fUXstWIHI
        A6qSiX9zmhD0WYSx3t01ocPKG0teBNEuoA==
X-Google-Smtp-Source: ABdhPJyhIykDGjitD7LHrige2sCD5gYPRuCHIMF/kbnhDe/kHDnRP/dUFMGoJ/W7uFDqUvvRChF8UH3gnzB2/A==
X-Received: from tortoise.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1a0d])
 (user=jmattson job=sendgmr) by 2002:a17:90b:4c0c:: with SMTP id
 na12mr14616417pjb.140.1643917451702; Thu, 03 Feb 2022 11:44:11 -0800 (PST)
Date:   Thu,  3 Feb 2022 11:43:07 -0800
Message-Id: <20220203194308.2469117-1-jmattson@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 1/2] x86/cpufeatures: Put the AMX macros in the word 18 block
From:   Jim Mattson <jmattson@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Juergen Gross <jgross@suse.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Babu Moger <babu.moger@amd.com>,
        Jing Liu <jing2.liu@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros are for bits in CPUID.(EAX=7,ECX=0):EDX, not for bits in
CPUID(EAX=7,ECX=1):EAX. Put them with their brethren.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/cpufeatures.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index da872b6f8d8b..d7b51ddc8db3 100644
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
@@ -391,6 +388,9 @@
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
 #define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
+#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
+#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
+#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX int8 Support */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
-- 
2.35.0.263.gb82422642f-goog

