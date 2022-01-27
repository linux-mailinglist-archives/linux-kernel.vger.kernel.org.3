Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E3A49DAD7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbiA0Ggc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbiA0GgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:36:24 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7645C061747
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 22:36:23 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so6599642pju.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 22:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rg2131bVbw63F3aHI1E1Qyk0ByMnG8ZrMzsox8Y41/U=;
        b=FtsdRwfbC8IG7UPbRSp92RJQy4S+lbtsgBaxGyWy0KcBrs7R1vIu4S1EyNjIgki690
         riSp+B+orfVQkv/Ewe1JWSJ7lUs4+vCtKDpzNnjPII3v1idTFBCKI1zSwDIBL1as/46F
         QZ7romkbQiJCNBwwb4dRX7fU05VzcdQr0hcTN0eZc6h7Zxq1pbBjeMUFDcNiJ7JMasLC
         raKF3ISTGddsxXwKkpVLRP0w+V9iYB0QKAdnPSLPWqpa/9eGLM851RprsZ+XKf0+60Q1
         a0QX94pZKvpD6i2BjteNU7gQ1DlHEgrCheJJYZfItpo9sKZlhLAfsjJIgIuR3jweXmzg
         vaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rg2131bVbw63F3aHI1E1Qyk0ByMnG8ZrMzsox8Y41/U=;
        b=I6FTEX4fixSSp7KJ8TM9EOyuykgWyEPt9tOFVHfeKtN9F2eNFIj7pM5RVeYc+chWoX
         RRSW9tKCyePMxvV9q1yyDyok282K7SR3qY3UPctaqyvPwvYP4mlYlhYZzUF5rJ5+7Obd
         589jNONnaVg4CwrIq0iY9DYaJrrVdH05xhKA6TrBgZpDAK1mVuD3s605+3sL1AK8feZ+
         q+ztbx95DysUFRi4IgEWyr2xskk1vsl2AW/NGAXnoGj3LvvCjLagSR2kiu02OkJhfHMh
         ZuYVp8Q5uMWy781tHTmISmk+qlk08WQzstacPGekwHeu6XQQYtaSdUI7TDgWxMkLCjq+
         J0Xg==
X-Gm-Message-State: AOAM532o1tiYdG5LrMv77JSRfc1b7T8GpBNb8DwYwYd4cWmAAi/6T0ZJ
        ya8d8WzKYSlELmXZaaWFQTHUdg==
X-Google-Smtp-Source: ABdhPJyXOCYs9elTHCEIzax7TCHWJKTPOUu2c96OdSMJgwoaVb98VEWiBKlf/l6a9Ualt74KyFpeTA==
X-Received: by 2002:a17:90b:1806:: with SMTP id lw6mr12492473pjb.82.1643265383168;
        Wed, 26 Jan 2022 22:36:23 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u18sm4889334pjn.49.2022.01.26.22.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 22:36:22 -0800 (PST)
Date:   Thu, 27 Jan 2022 06:36:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io
Subject: Re: [RFC][PATCH v2 4/5] x86/uaccess: Implement
 unsafe_try_cmpxchg_user()
Message-ID: <YfI9Y5l0fQAKuJav@google.com>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.852009966@infradead.org>
 <YfIAsHQv5Q84fOqO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfIAsHQv5Q84fOqO@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022, Sean Christopherson wrote:
> Doh, I should have specified that KVM needs 8-byte CMPXCHG on 32-bit kernels due
> to using it to atomically update guest PAE PTEs and LTR descriptors (yay).
> 
> Also, KVM's use case isn't a tight loop, how gross would it be to add a slightly
> less unsafe version that does __uaccess_begin_nospec()?  KVM pre-checks the address
> way ahead of time, so the access_ok() check can be omitted.  Alternatively, KVM
> could add its own macro, but that seems a little silly.  E.g. somethign like this,
> though I don't think this is correct

*sigh*

Finally realized I forgot to add back the page offset after converting from guest
page frame to host virtual address.  Anyways, this is what I ended up with, will
test more tomorrow.

From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 20 Jan 2022 16:55:21 +0100
Subject: [PATCH] x86/uaccess: Implement unsafe_try_cmpxchg_user()

Do try_cmpxchg() loops on userspace addresses.  Provide 8-byte versions
for 32-bit kernels so that KVM can do cmpxchg on guest PAE PTEs, which
are accessed via userspace addresses.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/uaccess.h | 129 +++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ac96f9b2d64b..b706008aed28 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -342,6 +342,45 @@ do {									\
 		     : [umem] "m" (__m(addr))				\
 		     : : label)

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
+#define __try_cmpxchg64_user_asm(_ptr, _pold, _new, label)	({ \
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
+
 #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT

 #ifdef CONFIG_X86_32
@@ -407,6 +446,57 @@ do {									\
 		     : [umem] "m" (__m(addr)),				\
 		       "0" (err))

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
+
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT

 /* FIXME: this hack is definitely wrong -AK */
@@ -501,6 +591,45 @@ do {										\
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


