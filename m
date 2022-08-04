Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAF058A0E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbiHDSw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiHDSwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:52:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FA017A9C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 11:52:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso631004pjl.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 11:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=R8r8TMhgTxWlQtMf2zR7eE1G5lFAMwszO7l0MwcjJvg=;
        b=Cx/rwLFMn2qjQqTJoNb8PrDeC0lPKN2fPwnfYPkf5n9WtJhKMHvPHnoKP3+kOda9jR
         us6cCCHpFq4HbGj6m8OgJKx/KrgKmmYI2G7ai94zbeZl+bsnmnRtN1W91gjtLCHwsh4X
         M/74bMwB+yMvPpTtnUz4cxkIUCO55G5colrzQLaQp+PP5jTEYqOLDqS2OfdUi5rXk+HG
         t/seNwUKpin53kjQxBNLH2wukOgF2dLTXQ2CnPD6f+OJwMe4l2ZUuJIw+eUlRBC5z+md
         fPHUdO9MsMTM6bDP2PoWOvXz/WkGVNyvpjlOJSk4rTdskCyT5n2n5jmFEAUIMGLUmR5/
         Y5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=R8r8TMhgTxWlQtMf2zR7eE1G5lFAMwszO7l0MwcjJvg=;
        b=CjreO9luPu7szJWbOzuN57Btped3P7TZe5vJLzpCg2G4Q5NElo/ItO8OUiYVjMG4AC
         ZnkIz+yTfU6EUBIRvjRKSX71ensxLmw6i8ei5eLvkNM9nKuOK+XRhNGB7rjLvUx7q2oA
         OnrvZf98ZH/y312ngT90ns55RJ2yPyptcbMumNpyv8hQGOohY2zuQecgco/MGg3Hh1AI
         C1SiUBmW4JbxHt71JwKpjQXnudkO2yE0l4svtziBSXaGbmIJc9sv3scWebANyRvBwF6L
         2s7Le0kqQ9Os44xWHeTy46283VpykmBUjqE/HZd7sI7LfJcwKhy0T6tjEK2EmwwbHV82
         yGpA==
X-Gm-Message-State: ACgBeo0DNlZWs50JzKT783NISqErk26Epe/bZKSifH15bmXhDyhmFqE+
        EtqmmY6SjHNPnlUZXg3SvrgL4A==
X-Google-Smtp-Source: AA6agR5QAXH1I1HWoCno+q21o1XdqjDguCgg+98eFSthw/vO1BBt5jnEXGk7G8aQIqmPeADNT2eSpg==
X-Received: by 2002:a17:902:e5c9:b0:16e:f3b6:ddc4 with SMTP id u9-20020a170902e5c900b0016ef3b6ddc4mr3067614plf.30.1659639143754;
        Thu, 04 Aug 2022 11:52:23 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b3-20020aa79503000000b0052d3899f8c2sm1379665pfp.4.2022.08.04.11.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:52:23 -0700 (PDT)
Date:   Thu, 4 Aug 2022 18:52:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/acrn: Improve ACRN hypercalls
Message-ID: <YuwVY8iGkifExuli@google.com>
References: <20220804180358.32944-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804180358.32944-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022, Uros Bizjak wrote:
> As explained in section 6.47.5.2, "Specifying Registers for Local Variables"
> of the GCC info documentation, the correct way to specify register for
> input operands when calling Extended 'asm' is to define a local register
> variable and associate it with a specified register:
> 
> 	register unsigned long r8 asm ("r8") = hcall_id;

Using "register" for input operands is subtly dangerous.  The compiler (at least
some versions of GCC) isn't smart enough to realize that it must not clobber the
register between setting the register and passing it into asm().  Or maybe that's
the designed/intended behavior, but if so, IMO it's a terrible design.

And since kernel style is to put declarations at the beginning of functions, it's
quite easy for a developer/debugger to mess this up (speaking from multiple
experiences).

E.g. adding a pr_warn_ratelimited() after the register declaration generates code
that doesn't even load r8.

Dump of assembler code for function fake_acrn_example:
Address range 0xffffffff8105a1e0 to 0xffffffff8105a216:
   0xffffffff8105a1e0 <+0>:	call   0xffffffff8104a8c0 <__fentry__>
   0xffffffff8105a1e5 <+5>:	push   %rbp
   0xffffffff8105a1e6 <+6>:	mov    $0xffffffff81e08b40,%rsi
   0xffffffff8105a1ed <+13>:	mov    %rsp,%rbp
   0xffffffff8105a1f0 <+16>:	push   %r12
   0xffffffff8105a1f2 <+18>:	movslq %edi,%r12
   0xffffffff8105a1f5 <+21>:	mov    $0xffffffff822229e0,%rdi
   0xffffffff8105a1fc <+28>:	call   0xffffffff81545e30 <___ratelimit>
   0xffffffff8105a201 <+33>:	test   %eax,%eax
   0xffffffff8105a203 <+35>:	jne    0xffffffff81843bf0 <fake_acrn_example.cold>
   0xffffffff8105a209 <+41>:	vmcall
   0xffffffff8105a20c <+44>:	mov    -0x8(%rbp),%r12
   0xffffffff8105a210 <+48>:	leave
   0xffffffff8105a211 <+49>:	jmp    0xffffffff81c01a40 <__x86_return_thunk>


diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index 601867085b95..adc867a4a3d6 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -35,6 +35,9 @@ static inline long acrn_hypercall0(unsigned long hcall_id)
        long result;

        register unsigned long r8 asm ("r8") = hcall_id;
+
+       pr_warn_ratelimited("acrn: issuing hypercall = %ld\n", hcall_id);
+
        asm volatile("vmcall"
                     : "=a" (result)
                     : "r" (r8)
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fad8faa29d04..1b6e13a8bb9d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -33,6 +33,7 @@
 #include <asm/kvm_para.h>              /* kvm_handle_async_pf          */
 #include <asm/vdso.h>                  /* fixup_vdso_exception()       */
 #include <asm/irq_stack.h>
+#include <asm/acrn.h>

 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -1542,3 +1543,9 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)

        irqentry_exit(regs, state);
 }
+
+
+long fake_acrn_example(int hcall)
+{
+       return acrn_hypercall0(hcall);
+}

Compile tested, but the below appears to generate sane code, e.g. reloads r8 when
given:

long fake_acrn_example(long hcall)
{
	pr_warn_ratelimited("acrn: attempting hcall2 for %ld\n", hcall);
	if (acrn_hypercall2(hcall, 0, 0))
		return -EINVAL;

	pr_warn_ratelimited("acrn: attempting hcall1 for %ld\n", hcall);
	if (acrn_hypercall1(hcall, 0))
		return -EINVAL;

	pr_warn_ratelimited("acrn: attempting hcall0 for %ld\n", hcall);
	return acrn_hypercall0(hcall);
}

---
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 4 Aug 2022 20:03:58 +0200
Subject: [PATCH] x86/acrn: Use "register" input constraint to set r8 for ACRN
 hypercalls

As explained in section 6.47.5.2, "Specifying Registers for Local Variables"
of the GCC info documentation, the correct way to specify register for
input operands when calling Extended 'asm' is to define a local register
variable and associate it with a specified register:

	register unsigned long r8 asm ("r8") = hcall_id;

Use the above approach instead of explicit MOV to R8 at the beginning
of the asm. The relaxed assignment allows compiler to optimize and
shrink drivers/virt/acrn.o for 181 bytes:

   text    data     bss     dec     hex filename
   4284     208       0    4492    118c hsm-new.o
   4465     208       0    4673    1241 hsm-old.o

Wrap the register approach in a macro as using "register" for inputs is
subtly dangerous.  If the compiler detects that the register (r8) would
be clobbered between setting it (declaration) and consuming it (asm), the
compiler is apparently allowed to ignore the input.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/acrn.h | 50 +++++++++++++++----------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index e003a01b7c67..0817415f6d74 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -21,6 +21,23 @@ static inline u32 acrn_cpuid_base(void)
 	return 0;
 }

+/*
+  * Do not put code between the r8 register declaration and its usage in asm(),
+  * the compiler is allowed to ignore the register input if r8 would be
+  * clobbered before the asm() blob, e.g. by a function call.
+  */
+#define ACRN_HYPERCALL(id, params...)			\
+({							\
+	long result;					\
+	register unsigned long r8 asm ("r8") = id;	\
+							\
+	asm volatile("vmcall"				\
+		     : "=a" (result)			\
+		     : "r" (r8), ##params		\
+		     : "memory");			\
+	result;						\
+})
+
 /*
  * Hypercalls for ACRN
  *
@@ -29,50 +46,23 @@ static inline u32 acrn_cpuid_base(void)
  *   - Hypercall number is passed in R8 register.
  *   - Up to 2 arguments are passed in RDI, RSI.
  *   - Return value will be placed in RAX.
- *
- * Because GCC doesn't support R8 register as direct register constraints, use
- * supported constraint as input with a explicit MOV to R8 in beginning of asm.
  */
 static inline long acrn_hypercall0(unsigned long hcall_id)
 {
-	long result;
-
-	asm volatile("movl %1, %%r8d\n\t"
-		     "vmcall\n\t"
-		     : "=a" (result)
-		     : "g" (hcall_id)
-		     : "r8", "memory");
-
-	return result;
+	return ACRN_HYPERCALL(hcall_id);
 }

 static inline long acrn_hypercall1(unsigned long hcall_id,
 				   unsigned long param1)
 {
-	long result;
-
-	asm volatile("movl %1, %%r8d\n\t"
-		     "vmcall\n\t"
-		     : "=a" (result)
-		     : "g" (hcall_id), "D" (param1)
-		     : "r8", "memory");
-
-	return result;
+	return ACRN_HYPERCALL(hcall_id, "D" (param1));
 }

 static inline long acrn_hypercall2(unsigned long hcall_id,
 				   unsigned long param1,
 				   unsigned long param2)
 {
-	long result;
-
-	asm volatile("movl %1, %%r8d\n\t"
-		     "vmcall\n\t"
-		     : "=a" (result)
-		     : "g" (hcall_id), "D" (param1), "S" (param2)
-		     : "r8", "memory");
-
-	return result;
+	return ACRN_HYPERCALL(hcall_id, "D" (param1), "S" (param2));
 }

 #endif /* _ASM_X86_ACRN_H */

base-commit: 91dd4df51571bbea4d31e265cfbd59a85e0876be
--

