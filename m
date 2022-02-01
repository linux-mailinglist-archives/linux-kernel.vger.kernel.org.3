Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24F04A547E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 02:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiBABJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 20:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiBABI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:08:59 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2048BC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 17:08:59 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p16-20020a170902a41000b0014992c5d56bso6108719plq.19
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 17:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=o19M2/2rEEC9XlqyRHCtm92cgxOv/iqljRv4RIXkdoQ=;
        b=Thb1uNHwmhRE1IUrtC3LxdwFZMcqizXJg2fsLS1x19IBdPVMlthwhCef0wccwNj8RT
         PNoHxvbb16l/5xcIUSN7yGlmUmdALNHYWuNGqkIcaFK+HthmCxHEiuYnGxjhqz6D5c6/
         flIeR+UcZydZuaTx4+cL76NU6enAqzQaOyCe09RiRefHF0ULIM3xhk4vuj24pbWJZhc7
         jzBFX2Kqdq1t52wYob2iPGxcb7lBdF8wKst0SsSwKZ2Ffy5XcVZV9PoO63qaTz4Ppuvb
         XsLtYR54PRtVZtaswjvWz9EpHUEw4c1aK+n3bbe56twI0/LLbBssLOBvRUwJkuLYnnCr
         UbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=o19M2/2rEEC9XlqyRHCtm92cgxOv/iqljRv4RIXkdoQ=;
        b=LNGlpCn3RxvnD8E6J9KApsLlrSJV5KHjZuxlJ9SO50sZnTa3pGJ0v8N7r1Vhdpih5r
         usCYL/4TTcaUO6BnpGsn4FG5lwrdZItdO29RaYcY+FJhkKQuv3HXd+eE9hjMGt+M3ooe
         0YO8VaN3Lzg4BYf56fLWXjXfd+lf1cKpUF1Mbi93v+jv/G7SdvknJH4uMIA6pFg7BR25
         JZowC9SsarGsqRr3PyAbs7Ha2BWmAAJtjZrXFohLQK/wIBCoGiRMMWDKWvy8kB6YJ5bL
         a2+6Z68cq3doH5y/npMtveuSxe6wjvXpn4qqo9OqYbH5eoPi6h8iyTfo8A5aUSLvrUT/
         gd5Q==
X-Gm-Message-State: AOAM533mVJ2DomZlJJDTxFViTKUl+goR5F8f3/RXBOgFtq1Jtvvz/PfN
        GqsxQ53Qa3E3hO/QQTBwoCEU1lDReGI=
X-Google-Smtp-Source: ABdhPJypx2tPaOAnNKGjQcJspqm3ZE/EERH60WoXE1+w/w/BrbrsLS6tT4VIx/uoDkZeVXXDHO8aA4fDgyI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a65:6182:: with SMTP id c2mr19079339pgv.95.1643677738626;
 Mon, 31 Jan 2022 17:08:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  1 Feb 2022 01:08:35 +0000
In-Reply-To: <20220201010838.1494405-1-seanjc@google.com>
Message-Id: <20220201010838.1494405-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220201010838.1494405-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH 2/5] x86/uaccess: Implement macros for CMPXCHG on user addresses
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+6cde2282daa792c49ab8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Add support for CMPXCHG loops on userspace addresses.  Provide both an
"unsafe" version for tight loops that do their own uaccess begin/end, as
well as a "safe" version for use cases where the CMPXCHG is not buried in
a loop, e.g. KVM will resume the guest instead of looping when emulation
of a guest atomic accesses fails the CMPXCHG.

Provide 8-byte versions for 32-bit kernels so that KVM can do CMPXCHG on
guest PAE PTEs, which are accessed via userspace addresses.

Guard the asm_volatile_goto() variation with CC_HAS_ASM_GOTO_TIED_OUTPUT,
the "+m" constraint fails on some compilers that otherwise support
CC_HAS_ASM_GOTO_OUTPUT.

Cc: stable@vger.kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/uaccess.h | 131 +++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ac96f9b2d64b..423bfcc1ec4b 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -409,6 +409,98 @@ do {									\
 
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
+#ifdef CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
+#define __try_cmpxchg_user_asm(itype, ltype, _ptr, _pold, _new, label)	({ \
+	bool success;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm_volatile_goto("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
+		     _ASM_EXTABLE_UA(1b, %l[label])			\
+		     : CC_OUT(z) (success),				\
+		       [ptr] "+m" (*_ptr),				\
+		       [old] "+a" (__old)				\
+		     : [new] ltype (__new)				\
+		     : "memory"						\
+		     : label);						\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);					})
+
+#ifdef CONFIG_X86_32
+#define __try_cmpxchg64_user_asm(_ptr, _pold, _new, label)	({	\
+	bool success;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm_volatile_goto("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg8b %[ptr]\n"		\
+		     _ASM_EXTABLE_UA(1b, %l[label])			\
+		     : CC_OUT(z) (success),				\
+		       "+A" (__old),					\
+		       [ptr] "+m" (*_ptr)				\
+		     : "b" ((u32)__new),				\
+		       "c" ((u32)((u64)__new >> 32))			\
+		     : "memory"						\
+		     : label);						\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);					})
+#endif // CONFIG_X86_32
+#else  // !CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
+#define __try_cmpxchg_user_asm(itype, ltype, _ptr, _pold, _new, label)	({ \
+	int __err = 0;							\
+	bool success;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
+		     CC_SET(z)						\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
+					   %[errout])			\
+		     : CC_OUT(z) (success),				\
+		       [errout] "+r" (__err),				\
+		       [ptr] "+m" (*_ptr),				\
+		       [old] "+a" (__old)				\
+		     : [new] ltype (__new)				\
+		     : "memory", "cc");					\
+	if (unlikely(__err))						\
+		goto label;						\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);					})
+
+#ifdef CONFIG_X86_32
+#define __try_cmpxchg64_user_asm(_ptr, _pold, _new, label)	({	\
+	int __err = 0;							\
+	bool success;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg8b %[ptr]\n"		\
+		     CC_SET(z)						\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
+					   %[errout])			\
+		     : CC_OUT(z) (success),				\
+		       [errout] "+r" (__err),				\
+		       "+A" (__old),					\
+		       [ptr] "+m" (*_ptr)				\
+		     : "b" ((u32)__new),				\
+		       "c" ((u32)((u64)__new >> 32))			\
+		     : "memory", "cc");					\
+	if (unlikely(__err))						\
+		goto label;						\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);					})
+#endif // CONFIG_X86_32
+#endif // CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
+
 /* FIXME: this hack is definitely wrong -AK */
 struct __large_struct { unsigned long buf[100]; };
 #define __m(x) (*(struct __large_struct __user *)(x))
@@ -501,6 +593,45 @@ do {										\
 } while (0)
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
+extern void __try_cmpxchg_user_wrong_size(void);
+
+#ifndef CONFIG_X86_32
+#define __try_cmpxchg64_user_asm(_ptr, _oldp, _nval, _label)		\
+	__try_cmpxchg_user_asm("q", "r", (_ptr), (_oldp), (_nval), _label)
+#endif
+
+#define unsafe_try_cmpxchg_user(_ptr, _oldp, _nval, _label) ({		\
+	bool __ret;							\
+	switch (sizeof(*(_ptr))) {					\
+	case 1:	__ret = __try_cmpxchg_user_asm("b", "q",		\
+					       (_ptr), (_oldp),		\
+					       (_nval), _label);	\
+		break;							\
+	case 2:	__ret = __try_cmpxchg_user_asm("w", "r",		\
+					       (_ptr), (_oldp),		\
+					       (_nval), _label);	\
+		break;							\
+	case 4:	__ret = __try_cmpxchg_user_asm("l", "r",		\
+					       (_ptr), (_oldp),		\
+					       (_nval), _label);	\
+		break;							\
+	case 8:	__ret = __try_cmpxchg64_user_asm((_ptr), (_oldp),	\
+						 (_nval), _label);	\
+		break;							\
+	default: __try_cmpxchg_user_wrong_size();			\
+	}								\
+	__ret;						})
+
+/* "Returns" 0 on success, 1 on failure, -EFAULT if the access faults. */
+#define __try_cmpxchg_user(_ptr, _oldp, _nval, _label)	({		\
+	int __ret = -EFAULT;						\
+	__uaccess_begin_nospec();					\
+	__ret = !unsafe_try_cmpxchg_user(_ptr, _oldp, _nval, _label);	\
+_label:									\
+	__uaccess_end();						\
+	__ret;								\
+							})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
-- 
2.35.0.rc2.247.g8bbb082509-goog

