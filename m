Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A52474B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbhLNSoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhLNSox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:44:53 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B338C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 10:44:53 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id l10so7055909pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 10:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tg6B3V6EfBGD2ein4NA8ZanEKLYEDEVy+m41hpigQo4=;
        b=n52ZCv5U1fRJEipt/zwogzJ23TuWZRUjEJOv3Pw4Z69y49J8nszA5toWGewimpVxy+
         VVOAKuVCRjzwmR0CpO4z2Jrm4iSqDwcmQOTSKKXMoBH+K9rpnOqC6TEYTWTn4dYSVYGC
         hJxMmINaz0DWSiu/imJMqRR+u3u1cAFwgWx4c/gJJvHIWOuvGKg/gZSZwJ45yUFW/RVO
         R3k0Mf1ddzSrM1UqzWDc4rYF+c8fQDZS6WiOh+/mo3TJ0tQI8+VGdi0i+ra1A3+jJPre
         ATshyhumybwdn8o2IfBnNp6vjwdfWjirKi0vhsJj0xecdakUspeyOUFeCopEG25QR4bU
         kk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tg6B3V6EfBGD2ein4NA8ZanEKLYEDEVy+m41hpigQo4=;
        b=S0IE0enbVWQxKYJLUdT+S12S1MGhop1TUIBTsYCIsTzfhvrKjnhi0yyP/02Zy4xwJV
         k5+IYSyqv643udHRqmLvaurIsKcVQY4EGVgMP9Jelu6k/XhX9w+pmYhjyDWTkgzvHAns
         odK+IiQBqrK5Gss9XQCt5d8X+GPLiCY80PsFKSOQxv+zmEFRDwD8+9TCXc38OYW+alQ2
         k6WsEXpSPRfENYWZf49Aza8Vf/CBhN159fTUkrydvyW4WsIbN1L7rAoll2o5KZJ3hRHR
         2fIXw+uYHUzCZU4OTDRJ/Dw8KPdrxipvZKP9oRtHCL9v5hCKnQf+qGJ4nzFduiaEgFlm
         JvDw==
X-Gm-Message-State: AOAM532WoTtbM033VggJD58eaKOh4hkZwxN2oxxWvca/IF9ijh2fXd8v
        CU6jXJwUw2nrhW4HcJ9mwVLxdg==
X-Google-Smtp-Source: ABdhPJwfq26V5AcDfjXyayU13Zc2wSvS2IoboSQgeoFDIlJbnR5T8qDMmrSat9I2U3AYnPeNMQvubQ==
X-Received: by 2002:a05:6a00:1308:b0:4a2:75cd:883a with SMTP id j8-20020a056a00130800b004a275cd883amr5730443pfu.84.1639507492715;
        Tue, 14 Dec 2021 10:44:52 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id oc8sm331123pjb.45.2021.12.14.10.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 10:44:52 -0800 (PST)
Date:   Tue, 14 Dec 2021 18:44:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [PATCH v2 16/23] x86,vmx: Provide asm-goto-output vmread
Message-ID: <YbjmIPWtd6ke66CU@google.com>
References: <20211110100102.250793167@infradead.org>
 <20211110101325.840433319@infradead.org>
 <YbcbbGW2GcMx6KpD@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbcbbGW2GcMx6KpD@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021, Peter Zijlstra wrote:
> 
> Here's a version that doesn't make clang ICE..
> 
> Paolo, since this doesn't really depend on the .fixup removal series,
> feel free to collect it in the kvm tree or somesuch.
> 
> ---
> Subject: x86/vmx: Provide asm-goto-output vmread
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed, 10 Nov 2021 11:01:18 +0100
> 
> Use asm-goto-output for smaller fast path code.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx_ops.h |   27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> --- a/arch/x86/kvm/vmx/vmx_ops.h
> +++ b/arch/x86/kvm/vmx/vmx_ops.h
> @@ -71,6 +71,31 @@ static __always_inline unsigned long __v
>  {
>  	unsigned long value;
>  
> +#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
> +
> +	asm_volatile_goto("1: vmread %[field], %[output]\n\t"
> +			  "jna %l[do_fail]\n\t"
> +
> +			  _ASM_EXTABLE(1b, %l[do_exception])
> +
> +			  : [output] "=r" (value)
> +			  : [field] "r" (field)
> +			  : "cc"
> +			  : do_fail, do_exception);
> +
> +	return value;
> +
> +do_fail:
> +	WARN_ONCE(1, "kvm: vmread failed: field=%lx\n", field);
> +	pr_warn_ratelimited("kvm: vmread failed: field=%lx\n", field);

This needs to route through a noinline vmread_error(), the intent is that KVM only
does WARN once for all VMREAD failures, whereas having this inline will WARN once
on each unique vmcs_read*().  And at that point, we might as well hide the asm
trampoline too.  The amount of ifdeffery gets a bit gross, but in for a penny in
for a pound?

And like the other VMX instruction, I assume it's safe to annotate the failure
path as instrumentation safe.

So this?

---
 arch/x86/kvm/vmx/vmenter.S |  2 ++
 arch/x86/kvm/vmx/vmx.c     |  7 +++++++
 arch/x86/kvm/vmx/vmx_ops.h | 31 +++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 3a6461694fc2..d8a7a0a69ec1 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -238,6 +238,7 @@ SYM_FUNC_END(__vmx_vcpu_run)

 .section .text, "ax"

+#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 /**
  * vmread_error_trampoline - Trampoline from inline asm to vmread_error()
  * @field:	VMCS field encoding that failed
@@ -295,6 +296,7 @@ SYM_FUNC_START(vmread_error_trampoline)

 	ret
 SYM_FUNC_END(vmread_error_trampoline)
+#endif

 SYM_FUNC_START(vmx_do_interrupt_nmi_irqoff)
 	/*
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 640f4719612c..746c0952ddac 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -373,6 +373,12 @@ do {					\
 	pr_warn_ratelimited(fmt);	\
 } while (0)

+#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
+noinline void vmread_error(unsigned long field)
+{
+	vmx_insn_failed("kvm: vmread failed: field=%lx\n", field);
+}
+#else
 asmlinkage void vmread_error(unsigned long field, bool fault)
 {
 	if (fault)
@@ -380,6 +386,7 @@ asmlinkage void vmread_error(unsigned long field, bool fault)
 	else
 		vmx_insn_failed("kvm: vmread failed: field=%lx\n", field);
 }
+#endif

 noinline void vmwrite_error(unsigned long field, unsigned long value)
 {
diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 9e9ef47e988c..6cdc4ff4335f 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -10,9 +10,13 @@
 #include "vmcs.h"
 #include "x86.h"

+#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
+noinline void vmread_error(unsigned long field);
+#else
 asmlinkage void vmread_error(unsigned long field, bool fault);
 __attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
 							 bool fault);
+#endif
 void vmwrite_error(unsigned long field, unsigned long value);
 void vmclear_error(struct vmcs *vmcs, u64 phys_addr);
 void vmptrld_error(struct vmcs *vmcs, u64 phys_addr);
@@ -71,6 +75,31 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 {
 	unsigned long value;

+#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
+	asm_volatile_goto("1: vmread %[field], %[output]\n\t"
+			  "jna %l[do_fail]\n\t"
+
+			  _ASM_EXTABLE(1b, %l[do_exception])
+
+			  : [output] "=r" (value)
+			  : [field] "r" (field)
+			  : "cc"
+			  : do_fail, do_exception);
+
+	return value;
+
+do_fail:
+	instrumentation_begin();
+	vmread_error(field);
+	instrumentation_end();
+	return 0;
+
+do_exception:
+	kvm_spurious_fault();
+	return 0;
+
+#else /* !CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
+
 	asm volatile("1: vmread %2, %1\n\t"
 		     ".byte 0x3e\n\t" /* branch taken hint */
 		     "ja 3f\n\t"
@@ -101,6 +130,8 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 		     _ASM_EXTABLE(1b, 4b)
 		     : ASM_CALL_CONSTRAINT, "=r"(value) : "r"(field) : "cc");
 	return value;
+
+#endif /* CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
 }

 static __always_inline u16 vmcs_read16(unsigned long field)
--
