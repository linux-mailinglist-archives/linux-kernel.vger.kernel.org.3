Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CF147331E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241559AbhLMRf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:35:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36206 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241465AbhLMRfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:35:10 -0500
Date:   Mon, 13 Dec 2021 17:35:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639416909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4cwUKfLx9YF3WS9UaB5qwelWoV/HVYlrstgBCXFNMQs=;
        b=H6sUsVsJPv2I7yPUZHLj529fmM47UIW8KA8dMpq6WYvQp2vl4u8mAU5u7J8yyecWK2I3JO
        55GDgD6+qdcqcZRJRz/gcs0412K6VU7EemCk8iDRGmrXI8SZhocttW4JZcsHQbhzuFHuhB
        c8Q/1f4KEWN/CMOcGqdWgSqGFuKu6rIbBvAvUqg9yIQtfVSxLlm9k50glk81Q2ETn+L1/m
        /oHdG6Og/6guZYyHKA15QdvCY6B/JzsShcIwnGpM4IebkgIwGBy9MqBVxIA9YXaE99r4Gw
        L88H1KWP/BPncwDlaozYjFurN2Hw1RyzvJgy1uhB5bq/hosMMKd695tLrOTh3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639416909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4cwUKfLx9YF3WS9UaB5qwelWoV/HVYlrstgBCXFNMQs=;
        b=oQcRotg0ckHqGSMhMDTjx8VXEarjVTUEYcydC3uAV4fuU0i9559cRufiZXaI1wvkPndQep
        Jr/SfChZm1om6HBQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Use mce_rdmsrl() in severity checking code
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211208111343.8130-4-bp@alien8.de>
References: <20211208111343.8130-4-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163941690804.23020.6521153337668550829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     88f66a42353717e7fac31caf04f0acd2d7fbbf54
Gitweb:        https://git.kernel.org/tip/88f66a42353717e7fac31caf04f0acd2d7fbbf54
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 06 Oct 2021 00:55:38 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Dec 2021 14:12:08 +01:00

x86/mce: Use mce_rdmsrl() in severity checking code

MCA has its own special MSR accessors. Use them.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211208111343.8130-4-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/core.c     | 2 +-
 arch/x86/kernel/cpu/mce/internal.h | 2 ++
 arch/x86/kernel/cpu/mce/severity.c | 8 +++-----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f15efa2..87a277f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -362,7 +362,7 @@ void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr)
 }
 
 /* MSR access wrappers used for error injection */
-static noinstr u64 mce_rdmsrl(u32 msr)
+noinstr u64 mce_rdmsrl(u32 msr)
 {
 	DECLARE_ARGS(val, low, high);
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index acd61c4..52c6339 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -207,4 +207,6 @@ static inline void pentium_machine_check(struct pt_regs *regs) {}
 static inline void winchip_machine_check(struct pt_regs *regs) {}
 #endif
 
+noinstr u64 mce_rdmsrl(u32 msr);
+
 #endif /* __X86_MCE_INTERNAL_H__ */
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index bb019a5..00e97eb 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -288,8 +288,7 @@ static int error_context(struct mce *m, struct pt_regs *regs)
 
 static int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
 {
-	u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
-	u32 low, high;
+	u64 mcx_cfg;
 
 	/*
 	 * We need to look at the following bits:
@@ -300,11 +299,10 @@ static int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
 	if (!mce_flags.succor)
 		return MCE_PANIC_SEVERITY;
 
-	if (rdmsr_safe(addr, &low, &high))
-		return MCE_PANIC_SEVERITY;
+	mcx_cfg = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(m->bank));
 
 	/* TCC (Task context corrupt). If set and if IN_KERNEL, panic. */
-	if ((low & MCI_CONFIG_MCAX) &&
+	if ((mcx_cfg & MCI_CONFIG_MCAX) &&
 	    (m->status & MCI_STATUS_TCC) &&
 	    (err_ctx == IN_KERNEL))
 		return MCE_PANIC_SEVERITY;
