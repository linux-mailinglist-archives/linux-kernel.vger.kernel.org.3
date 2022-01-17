Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51292490FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbiAQRvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:51:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41448 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233337AbiAQRve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:51:34 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C7111EC0531;
        Mon, 17 Jan 2022 18:51:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642441888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4/aNSkVjR8Um6vaRHzGuvONVebu5pqsF8zgeYGHQsgE=;
        b=J515P1x2M/5Yg8o+APdqCN+4wDGB5V21OHHP15zx4VeV0gsfac9kPyLR+lnsnIDTqfxO3X
        NoV3lnyBe+hn/pmM1g9YGrePx9sIRDtfT+DRRPAeAFRBhUlyQiNVWi7ccsgaZH5BCzaLNi
        taOLVZhQxGbPT2l71cT5+IuZUQHWBHA=
Date:   Mon, 17 Jan 2022 18:51:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mce: Fix two more noinstr issues
Message-ID: <YeWsopFagTZ4W8WA@zn.tnic>
References: <61cba815.Her0ebRPVzS617KT%lkp@intel.com>
 <YcwrofZrHadGAMlD@zn.tnic>
 <5925b071-0b4b-b8da-5cf2-5c66ec2ac08f@intel.com>
 <Yc7t934f+f/mO8lj@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yc7t934f+f/mO8lj@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOW, something like this ontop of:

https://lore.kernel.org/r/20220113155357.4706-1-bp@alien8.de

That did pass overnight build-tests so 

---
From: Borislav Petkov <bp@suse.de>
Date: Sun, 16 Jan 2022 19:23:26 +0100
Subject: [PATCH] x86/mce: Fix two more noinstr issues

Always inline mca_msr_reg():

   text    data     bss     dec     hex filename
16065240        128031326       36405368        180501934       ac23dae vmlinux.before
16065240        128031294       36405368        180501902       ac23d8e vmlinux.after

and mce_no_way_out() as the latter one is used only once, to fix:

  vmlinux.o: warning: objtool: mce_read_aux()+0x53: call to mca_msr_reg() leaves .noinstr.text section
  vmlinux.o: warning: objtool: do_machine_check()+0xc9: call to mce_no_way_out() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c     | 25 ++-----------------------
 arch/x86/kernel/cpu/mce/internal.h | 23 +++++++++++++++++++++--
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5818b837fd4d..0db5a232986a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -173,27 +173,6 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
 
-u32 mca_msr_reg(int bank, enum mca_msr reg)
-{
-	if (mce_flags.smca) {
-		switch (reg) {
-		case MCA_CTL:	 return MSR_AMD64_SMCA_MCx_CTL(bank);
-		case MCA_ADDR:	 return MSR_AMD64_SMCA_MCx_ADDR(bank);
-		case MCA_MISC:	 return MSR_AMD64_SMCA_MCx_MISC(bank);
-		case MCA_STATUS: return MSR_AMD64_SMCA_MCx_STATUS(bank);
-		}
-	}
-
-	switch (reg) {
-	case MCA_CTL:	 return MSR_IA32_MCx_CTL(bank);
-	case MCA_ADDR:	 return MSR_IA32_MCx_ADDR(bank);
-	case MCA_MISC:	 return MSR_IA32_MCx_MISC(bank);
-	case MCA_STATUS: return MSR_IA32_MCx_STATUS(bank);
-	}
-
-	return 0;
-}
-
 static void __print_mce(struct mce *m)
 {
 	pr_emerg(HW_ERR "CPU %d: Machine Check%s: %Lx Bank %d: %016Lx\n",
@@ -838,8 +817,8 @@ static void quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
  * Do a quick check if any of the events requires a panic.
  * This decides if we keep the events around or clear them.
  */
-static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
-			  struct pt_regs *regs)
+static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
+					  struct pt_regs *regs)
 {
 	char *tmp = *msg;
 	int i;
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 52c633950b38..a04b61e27827 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -182,8 +182,6 @@ enum mca_msr {
 	MCA_MISC,
 };
 
-u32 mca_msr_reg(int bank, enum mca_msr reg);
-
 /* Decide whether to add MCE record to MCE event pool or filter it out. */
 extern bool filter_mce(struct mce *m);
 
@@ -209,4 +207,25 @@ static inline void winchip_machine_check(struct pt_regs *regs) {}
 
 noinstr u64 mce_rdmsrl(u32 msr);
 
+static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
+{
+	if (mce_flags.smca) {
+		switch (reg) {
+		case MCA_CTL:	 return MSR_AMD64_SMCA_MCx_CTL(bank);
+		case MCA_ADDR:	 return MSR_AMD64_SMCA_MCx_ADDR(bank);
+		case MCA_MISC:	 return MSR_AMD64_SMCA_MCx_MISC(bank);
+		case MCA_STATUS: return MSR_AMD64_SMCA_MCx_STATUS(bank);
+		}
+	}
+
+	switch (reg) {
+	case MCA_CTL:	 return MSR_IA32_MCx_CTL(bank);
+	case MCA_ADDR:	 return MSR_IA32_MCx_ADDR(bank);
+	case MCA_MISC:	 return MSR_IA32_MCx_MISC(bank);
+	case MCA_STATUS: return MSR_IA32_MCx_STATUS(bank);
+	}
+
+	return 0;
+}
+
 #endif /* __X86_MCE_INTERNAL_H__ */
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
