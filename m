Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EFA48F5EF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 09:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiAOINY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 03:13:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36848 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229509AbiAOINX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 03:13:23 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E80001EC0532;
        Sat, 15 Jan 2022 09:13:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642234398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rv6zD8oYOxpw0HDgwGJIhbDBWypsLSfWsSYdgii+Xoo=;
        b=cicGWt4WPbN0crFLtUwX/r5R4DtCR6d8Cz7emXW+hiaco2hf8lw6DXcF39EQtmZHel6e/6
        M110+6e9PM9QxjdATGC5Ax+PqwKJQQ9Gsy229bl7mAUHXi67vIWu34+ml5niRDC4khnKLo
        OcbUPh+wodeLZKBR2ynfw5kT/ybAZMI=
Date:   Sat, 15 Jan 2022 09:13:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        kernel test robot <oliver.sang@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [PATCH] x86/entry_32: Fix segment exceptions
Message-ID: <YeKCJHju0owRVFoT@zn.tnic>
References: <20220106083523.GB32167@xsang-OptiPlex-9020>
 <Yd1l0gInc4zRcnt/@hirez.programming.kicks-ass.net>
 <Yd4u2rVVSdpEpwwM@google.com>
 <Yd6zrbFBzSn3ducx@hirez.programming.kicks-ass.net>
 <Yd724f1Uv1GTZ+46@zn.tnic>
 <73020277-d49f-7aae-22db-945e040a31a2@kernel.org>
 <YeCDudla868Ipf++@hirez.programming.kicks-ass.net>
 <YeFdeZsTWDt9WU8f@zn.tnic>
 <760ea801-8394-4e0c-9ec3-23e36e436551@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <760ea801-8394-4e0c-9ec3-23e36e436551@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 03:48:31PM -0800, Andy Lutomirski wrote:
> Acked-by: Andy Lutomirski <luto@kernel.org>

I actually did this new version:

---
From: Borislav Petkov <bp@suse.de>
Subject: [PATCH] x86/entry_32: Remove GS from the pt_regs offsets and fixup regs

Document how GS (and its stack slot) on 32-bit are used.

Fixes: 9cdbeec40968 ("x86/entry_32: Fix segment exceptions")
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/entry/entry_32.S                  | 4 +++-
 arch/x86/include/asm/extable_fixup_types.h | 5 +++--
 arch/x86/lib/insn-eval.c                   | 5 ++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index a7ec22b1d06c..addc3966ee20 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -20,7 +20,9 @@
  *	1C(%esp) - %ds
  *	20(%esp) - %es
  *	24(%esp) - %fs
- *	28(%esp) - unused -- was %gs on old stackprotector kernels
+ *	28(%esp) - unused -- was %gs on old stackprotector kernels. %gs is unused in
+ *	kernel mode in 32-bit and holds the user value. When handling exceptions, the
+ *	C-exception handler address is pushed into the GS-slot on the stack.
  *	2C(%esp) - orig_eax
  *	30(%esp) - %eip
  *	34(%esp) - %cs
diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 503622627400..0aa5f4d3234f 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -20,11 +20,12 @@
 #define EX_DATA_FLAG(flag)		((flag) << EX_DATA_FLAG_SHIFT)
 #define EX_DATA_IMM(imm)		((imm) << EX_DATA_IMM_SHIFT)
 
-/* segment regs */
+#ifdef CONFIG_X86_32
+/* segment regs, valid only for 32-bit code, see pt_regoff */
 #define EX_REG_DS			EX_DATA_REG(8)
 #define EX_REG_ES			EX_DATA_REG(9)
 #define EX_REG_FS			EX_DATA_REG(10)
-#define EX_REG_GS			EX_DATA_REG(11)
+#endif
 
 /* flags */
 #define EX_FLAG_CLEAR_AX		EX_DATA_FLAG(1)
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index b781d324211b..cfc4d13b7d5b 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -432,7 +432,10 @@ static const int pt_regoff[] = {
 	offsetof(struct pt_regs, ds),
 	offsetof(struct pt_regs, es),
 	offsetof(struct pt_regs, fs),
-	offsetof(struct pt_regs, gs),
+	/*
+	 * Can't use that one, see top of entry_32.S
+	 * offsetof(struct pt_regs, gs),
+	 */
 #endif
 };
 
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
