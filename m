Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CDC48E10A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 00:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbiAMXkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 18:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiAMXkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 18:40:08 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD147C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:40:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g6-20020a25db06000000b00611ca09ecd0so4587567ybf.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wwJdGAN5osUC9HM7kKzj2Htmsov37Cc7r1NsvxZMlRg=;
        b=EqRlBPehovANSdBzY2evi/EKQYY+q7HLOecxR/MagzYR2LxVFJ2uK4VkjufpfGFEzx
         KIeCSUfIoiL1qoE5OPQTr4qRMnceLv7+32QM4Hl7gPahtlj2cTemKA31nN2Df8LfZhZa
         El2EqLCJCO1yQ/3YpQ/0XwnC8W2XEBXUm3dbCBExBLp/IGMMCLUgBq+B94A1I13rRSAN
         ukHIOytgnjWR7LSixoc/8BtU4PvqqLx30PpXNj3fgwOdLAk53TWQvhTQkjw3G0wKpYC8
         PUt8wipSgOqEFQ+Y2EWyJvcrby1YZ8yF2OF7TvyETom5WyTQmwBDMAfStsNe41S0zUdC
         0UTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wwJdGAN5osUC9HM7kKzj2Htmsov37Cc7r1NsvxZMlRg=;
        b=naL5EcjpEKT00Dyd9w5IbYjV0+DzxucynhT9hlWye7UqmWRm8ci9VXOjn/r+O/SYZd
         0x53EzBfK1phnxxeZ+xTfo0g3OngJRNy8IPpKpEcuTkk3SuhGpnxiU3vRjd+oAPZGfGs
         kvjJWoVIX4x5EbaVBk/LW9OKw6ZxPAh96KgT4z37f/PTBomh5VckfXgVG/0qyiip8vCF
         T/yA6FWKPYp57t6gMDVBoqd35g27zE62m5IYb1sskIyyt/YDQCrHnnxwunGPRHEgxZ8P
         1ecMVlhISJjDGw7t59HKF9HPlrp+O1enoFDSlihVwDqb9fjlGKQuV3FhmIVEqwG+K57c
         M5Dg==
X-Gm-Message-State: AOAM5315b0osAhPfSMeFfirNL+aSrDjyNXWoBT6uqmclJt/+pQirgXGH
        yaSvgU5mra5rpWX1rw6a/857MtgG
X-Google-Smtp-Source: ABdhPJzzGWHCGjZGF5k35EtO1RjDkQh8pxMnUpvwv8nSbHJHv8giYUEy9UlBMk+wUGWLFmwcfXW/lLPr
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:c548:e79f:8954:121f])
 (user=posk job=sendgmr) by 2002:a25:6d09:: with SMTP id i9mr4958623ybc.703.1642117206900;
 Thu, 13 Jan 2022 15:40:06 -0800 (PST)
Date:   Thu, 13 Jan 2022 15:39:37 -0800
In-Reply-To: <20220113233940.3608440-1-posk@google.com>
Message-Id: <20220113233940.3608440-3-posk@google.com>
Mime-Version: 1.0
References: <20220113233940.3608440-1-posk@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [RFC PATCH v2 2/5] x86/uaccess: Implement unsafe_try_cmpxchg_user()
From:   Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, pjt@google.com,
        posk@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, posk@posk.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Do try_cmpxchg() loops on userspace addresses.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/uaccess.h | 57 ++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ac96f9b2d64b..8277ec05be02 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -342,6 +342,24 @@ do {									\
 		     : [umem] "m" (__m(addr))				\
 		     : : label)
 
+#define __try_cmpxchg_user_asm(itype, _ptr, _pold, _new, label)	({	\
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
+		     : [new] "r" (__new)				\
+		     : "memory", "cc"					\
+		     : label);						\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);					})
+
 #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
 #ifdef CONFIG_X86_32
@@ -407,6 +425,30 @@ do {									\
 		     : [umem] "m" (__m(addr)),				\
 		       "0" (err))
 
+#define __try_cmpxchg_user_asm(itype, _ptr, _pold, _new, label)	({	\
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
+		     : [new] "r" (__new)				\
+		     : "memory", "cc");					\
+	if (unlikely(__err))						\
+		goto label;						\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);					})
+
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
 /* FIXME: this hack is definitely wrong -AK */
@@ -501,6 +543,21 @@ do {										\
 } while (0)
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
+extern void __try_cmpxchg_user_wrong_size(void);
+
+#define unsafe_try_cmpxchg_user(_ptr, _oldp, _nval, _label) ({		\
+	__typeof__(*(_ptr)) __ret;					\
+	switch (sizeof(__ret)) {					\
+	case 4:	__ret = __try_cmpxchg_user_asm("l", (_ptr), (_oldp),	\
+					       (_nval), _label);	\
+		break;							\
+	case 8:	__ret = __try_cmpxchg_user_asm("q", (_ptr), (_oldp),	\
+					       (_nval), _label);	\
+		break;							\
+	default: __try_cmpxchg_user_wrong_size();			\
+	}								\
+	__ret;						})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
-- 
2.34.1.703.g22d0c6ccf7-goog

