Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079124F91E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiDHJRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiDHJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:12:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CB521FC5B;
        Fri,  8 Apr 2022 02:09:16 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:09:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NAKOvswt5/YP2PgSwCRQwYJCoGtTqqIiOYM8EXjDC/A=;
        b=qIDGJFKQWwqPdnjpNrGDN+F0qYWtYDhZZuONG+fsr6YEL9uH1HwNrnrQXU10tRd58sftRt
        3kd3my7kl7w7wPj40Ek/rwCPtFeDHNmpRB1f7bTThgd0n2jsyxeJRkN5HFvJOdE/huHQQS
        QVEN3m2mokgLAM8FtbmCr+e4tsxNHmzwm2SqDZjEGx1KZPIan4L2QvDYJcno8MtaTupa8C
        rj6MxTF4v12yoLMIWZPKTuBtSRKRDaanC5DOCEKHyXLiH1fkzeco6HF/dUxKpZyAHdrH46
        Q+3GTJhUaGOJgm93KwnWCEzFVrreGA4X1EXZRoDIPkecp81dFD1ALUXwX2uehg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NAKOvswt5/YP2PgSwCRQwYJCoGtTqqIiOYM8EXjDC/A=;
        b=2KviZAm6/cRHDpSDwFbi659OXhE4wY1KsPBmXOhNR/grzckmwEIScBRRfltP4fP0PadvHU
        zzvAwRBWxqVoIuBA==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/boot: Use MSR read/write helpers instead of inline
 assembly
Cc:     Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-7-brijesh.singh@amd.com>
References: <20220307213356.2797205-7-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940895430.389.3424845222460776043.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     950d00558a920227b5703d1fcc4751cfe03853cd
Gitweb:        https://git.kernel.org/tip/950d00558a920227b5703d1fcc4751cfe03853cd
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Wed, 09 Feb 2022 12:10:00 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 13:02:13 +02:00

x86/boot: Use MSR read/write helpers instead of inline assembly

Update all C code to use the new boot_rdmsr()/boot_wrmsr() helpers
instead of relying on inline assembly.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-7-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/sev.c | 17 +++++++----------
 arch/x86/boot/cpucheck.c       | 30 +++++++++++++++---------------
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 28bcf04..4e82101 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -22,6 +22,7 @@
 #include <asm/svm.h>
 
 #include "error.h"
+#include "../msr.h"
 
 struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
 struct ghcb *boot_ghcb;
@@ -56,23 +57,19 @@ static unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
 
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
-	unsigned long low, high;
+	struct msr m;
 
-	asm volatile("rdmsr" : "=a" (low), "=d" (high) :
-			"c" (MSR_AMD64_SEV_ES_GHCB));
+	boot_rdmsr(MSR_AMD64_SEV_ES_GHCB, &m);
 
-	return ((high << 32) | low);
+	return m.q;
 }
 
 static inline void sev_es_wr_ghcb_msr(u64 val)
 {
-	u32 low, high;
+	struct msr m;
 
-	low  = val & 0xffffffffUL;
-	high = val >> 32;
-
-	asm volatile("wrmsr" : : "c" (MSR_AMD64_SEV_ES_GHCB),
-			"a"(low), "d" (high) : "memory");
+	m.q = val;
+	boot_wrmsr(MSR_AMD64_SEV_ES_GHCB, &m);
 }
 
 static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
diff --git a/arch/x86/boot/cpucheck.c b/arch/x86/boot/cpucheck.c
index e1478d3..fed8d13 100644
--- a/arch/x86/boot/cpucheck.c
+++ b/arch/x86/boot/cpucheck.c
@@ -27,6 +27,7 @@
 #include <asm/required-features.h>
 #include <asm/msr-index.h>
 #include "string.h"
+#include "msr.h"
 
 static u32 err_flags[NCAPINTS];
 
@@ -130,12 +131,11 @@ int check_cpu(int *cpu_level_ptr, int *req_level_ptr, u32 **err_flags_ptr)
 		/* If this is an AMD and we're only missing SSE+SSE2, try to
 		   turn them on */
 
-		u32 ecx = MSR_K7_HWCR;
-		u32 eax, edx;
+		struct msr m;
 
-		asm("rdmsr" : "=a" (eax), "=d" (edx) : "c" (ecx));
-		eax &= ~(1 << 15);
-		asm("wrmsr" : : "a" (eax), "d" (edx), "c" (ecx));
+		boot_rdmsr(MSR_K7_HWCR, &m);
+		m.l &= ~(1 << 15);
+		boot_wrmsr(MSR_K7_HWCR, &m);
 
 		get_cpuflags();	/* Make sure it really did something */
 		err = check_cpuflags();
@@ -145,28 +145,28 @@ int check_cpu(int *cpu_level_ptr, int *req_level_ptr, u32 **err_flags_ptr)
 		/* If this is a VIA C3, we might have to enable CX8
 		   explicitly */
 
-		u32 ecx = MSR_VIA_FCR;
-		u32 eax, edx;
+		struct msr m;
 
-		asm("rdmsr" : "=a" (eax), "=d" (edx) : "c" (ecx));
-		eax |= (1<<1)|(1<<7);
-		asm("wrmsr" : : "a" (eax), "d" (edx), "c" (ecx));
+		boot_rdmsr(MSR_VIA_FCR, &m);
+		m.l |= (1 << 1) | (1 << 7);
+		boot_wrmsr(MSR_VIA_FCR, &m);
 
 		set_bit(X86_FEATURE_CX8, cpu.flags);
 		err = check_cpuflags();
 	} else if (err == 0x01 && is_transmeta()) {
 		/* Transmeta might have masked feature bits in word 0 */
 
-		u32 ecx = 0x80860004;
-		u32 eax, edx;
+		struct msr m, m_tmp;
 		u32 level = 1;
 
-		asm("rdmsr" : "=a" (eax), "=d" (edx) : "c" (ecx));
-		asm("wrmsr" : : "a" (~0), "d" (edx), "c" (ecx));
+		boot_rdmsr(0x80860004, &m);
+		m_tmp = m;
+		m_tmp.l = ~0;
+		boot_wrmsr(0x80860004, &m_tmp);
 		asm("cpuid"
 		    : "+a" (level), "=d" (cpu.flags[0])
 		    : : "ecx", "ebx");
-		asm("wrmsr" : : "a" (eax), "d" (edx), "c" (ecx));
+		boot_wrmsr(0x80860004, &m);
 
 		err = check_cpuflags();
 	} else if (err == 0x01 &&
