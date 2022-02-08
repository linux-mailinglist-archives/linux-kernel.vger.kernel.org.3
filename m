Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944174AD64E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbiBHLXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbiBHJyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:54:24 -0500
X-Greylist: delayed 72149 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 01:54:23 PST
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EF1C03FEC0;
        Tue,  8 Feb 2022 01:54:23 -0800 (PST)
Date:   Tue, 08 Feb 2022 09:54:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644314060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q/IayFDBAyr/LKIzMEy3/M8i4irY95BKw7ZqHhR11ow=;
        b=xuboOmy97j14wcvq9eS80iq6pJBoZULoTopvOYqJSY03DPsDSsCvYfNlPGhZpkYQZGKoxB
        ibE/tsgwSNHMZeJ31l/9Cb0ST1CDDCvFY0hcb2zHjEdtOAYOiMWH8C1T4TUbT8EJ667H6t
        vPA+M9iv0/cJqrwCVDVfqnE5ZDJlKAOhou9Y1h0RPGGA4xpCxwVoI00/6+TCiSINnjIE0o
        7c1AmKo9CN3pql86cytKIodyrAwJi8Ji7IVNNJgfK14GdPwebZ6BUZyOv2xz35Nrv48ejf
        phu7x8vq/GCX/tzzIy9wp3cYC/kcnUp+IlFLO3tarc7gHtYG4RQ8IApzZUq95Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644314060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q/IayFDBAyr/LKIzMEy3/M8i4irY95BKw7ZqHhR11ow=;
        b=eWJF+bhAIK01aYIt+lNyZQElZZRX7nvgenZxiVT65ukw/CCl8rOCSEWdli5Viqb+eGth0a
        kvKeeNQGlpq//GDQ==
From:   "tip-bot2 for Jim Mattson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeatures: Put the AMX macros in the word 18 block
Cc:     Jim Mattson <jmattson@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220203194308.2469117-1-jmattson@google.com>
References: <20220203194308.2469117-1-jmattson@google.com>
MIME-Version: 1.0
Message-ID: <164431405962.16921.15997082266702791882.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     fa31a4d669bd471e9510db1abf9b91e1a6be6ff7
Gitweb:        https://git.kernel.org/tip/fa31a4d669bd471e9510db1abf9b91e1a6be6ff7
Author:        Jim Mattson <jmattson@google.com>
AuthorDate:    Thu, 03 Feb 2022 11:43:07 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 08 Feb 2022 10:23:35 +01:00

x86/cpufeatures: Put the AMX macros in the word 18 block

These macros are for bits in CPUID.(EAX=7,ECX=0):EDX, not for bits in
CPUID(EAX=7,ECX=1):EAX. Put them with their brethren.

  [ bp: Sort word 18 bits properly, as caught by Like Xu
    <like.xu.linux@gmail.com> ]

Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20220203194308.2469117-1-jmattson@google.com
---
 arch/x86/include/asm/cpufeatures.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6db4e29..5cd2209 100644
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
@@ -390,7 +387,10 @@
 #define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
+#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
 #define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
+#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
+#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX int8 Support */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
