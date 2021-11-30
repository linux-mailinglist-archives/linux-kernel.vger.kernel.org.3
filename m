Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430904640D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbhK3WCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:02:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36018 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhK3WCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:02:06 -0500
Date:   Tue, 30 Nov 2021 21:58:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638309525;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qAcp8vXdkUxiH3H0T5wgr2PbRb/i/AUf2q6sPEFbbGw=;
        b=NbR1DXWNogxo7G6RUKbLYPHW0Z1noxHiHbZc6Ac8BKlgRgKs7cpwxghzfIslAhnn15uns0
        J5w080HajfFf05bmRPFcCkhNRfNRcNDYsS9MJP5vIte4xJ1oWoaHHA0kFCJa9UbDy2PryZ
        HtkXGv7txu9t4bl3G323hEKVplFn4hQTBoKOksrLHAHSF6nCwfSj03NvPkpplNuvcfWj2c
        h9E3wIQwK/RkM1dwQ9xmLxq2njam02VGC6QGnSTibjsoBybDXrltTt/jhbfc7oZk7pE0mc
        T/1+eSr6HG/zCl9h9ZB7MNTgWIYdKVHKKi1HDKMNk8DXLxk3ceg2X6aQfsQSpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638309525;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qAcp8vXdkUxiH3H0T5wgr2PbRb/i/AUf2q6sPEFbbGw=;
        b=Rv7HIQIUe7OlRe6P8zjfmIT/xYzJ0dHfW2VmOK9KzTZQBk8q77vMZzlJosB2grEi/BRmnf
        MOseum6+Y0jeIWCg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211130185533.32658-1-kirill.shutemov@linux.intel.com>
References: <20211130185533.32658-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163830952382.11128.12287490852114558960.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     6da5175dbe1c2f02f1301b6d987e3ce24742bfd4
Gitweb:        https://git.kernel.org/tip/6da5175dbe1c2f02f1301b6d987e3ce24742bfd4
Author:        Kirill A. Shutemov <kirill@shutemov.name>
AuthorDate:    Tue, 30 Nov 2021 21:55:32 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 30 Nov 2021 13:50:26 -08:00

x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV

Kernel fails to compile with PARAVIRT_XXL=y if XEN_PV is not enabled:

	ld.lld: error: undefined symbol: xen_iret

It happens because INTERRUPT_RETURN defined to use xen_iret if
CONFIG_PARAVIRT_XXL enabled regardless of CONFIG_XEN_PV.

The issue is not visible in the current kernel because CONFIG_XEN_PV is
the only user of CONFIG_PARAVIRT_XXL and there's no way to enable them
separately.

Rework code to define INTERRUPT_RETURN based on CONFIG_XEN_PV, not
CONFIG_PARAVIRT_XXL.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lkml.kernel.org/r/20211130185533.32658-1-kirill.shutemov@linux.intel.com
---
 arch/x86/include/asm/irqflags.h | 7 +++++--
 arch/x86/include/asm/paravirt.h | 5 -----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index c5ce984..8776139 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -114,8 +114,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 #define SAVE_FLAGS		pushfq; popq %rax
 #endif
 
-#define INTERRUPT_RETURN	jmp native_iret
-
 #endif
 
 #endif /* __ASSEMBLY__ */
@@ -143,8 +141,13 @@ static __always_inline void arch_local_irq_restore(unsigned long flags)
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_XEN_PV
 #define SWAPGS	ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
+#define INTERRUPT_RETURN						\
+	ANNOTATE_RETPOLINE_SAFE;					\
+	ALTERNATIVE_TERNARY("jmp *paravirt_iret(%rip);",		\
+		X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;")
 #else
 #define SWAPGS	swapgs
+#define INTERRUPT_RETURN	jmp native_iret
 #endif
 #endif
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 21c4a69..27d2762 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -752,11 +752,6 @@ extern void default_banner(void);
 #define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
 #define PARA_INDIRECT(addr)	*addr(%rip)
 
-#define INTERRUPT_RETURN						\
-	ANNOTATE_RETPOLINE_SAFE;					\
-	ALTERNATIVE_TERNARY("jmp *paravirt_iret(%rip);",		\
-		X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;")
-
 #ifdef CONFIG_DEBUG_ENTRY
 .macro PARA_IRQ_save_fl
 	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),
