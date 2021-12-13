Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C2A472836
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhLMKJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbhLMKEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1FCC09CE68;
        Mon, 13 Dec 2021 01:50:20 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:50:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QkMplfbfjz84phlW22cj01LqUEljC0Z4yThY8+Vj2kQ=;
        b=PjX1rQagX95yDQQovOEaKg5sCJIMkeIL0y3qlJlv9xA0L7c5pfdwgTgNyQvRF6GXh5s8bm
        gTrFAh1wsd8uTh4+fKMvoo5vI9D5t5W1uzs2R9FDL0nwTcwF1j53VVP33LtkYBjuutWJYN
        vK5wedg7hiKakdwZGhwPap4DjHz/Qo+gT4LhN4p7DxkdGxZ3kow0PRoVC3cWn6SN9sRsf3
        JuKrIAq6hheUlssbqzB2IGt+7RkWWTQQmF2Onp9ou+rBys+8vUdc9be8oBVbyF5OxAbEEL
        5q2DpbTDW32GiHjU3rl40bTRbvMY1vGgNmXamxfWRHz4BsW8Bctt78gfYILHXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QkMplfbfjz84phlW22cj01LqUEljC0Z4yThY8+Vj2kQ=;
        b=g/GNm3SjENrPo3qRKNG+vibl5GvzdXKOIz01QkXLOnOGTHQFqFZz7Erw3fwRY0aEr7dTjw
        SjvzPkhmGupjJoAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/uaccess: Remove .fixup usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101325.485154848@infradead.org>
References: <20211110101325.485154848@infradead.org>
MIME-Version: 1.0
Message-ID: <163938901816.23020.10705032850093391722.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     99641e094d6ccf547b3eba833aea9a34fdf5681e
Gitweb:        https://git.kernel.org/tip/99641e094d6ccf547b3eba833aea9a34fdf5681e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:47 +01:00

x86/uaccess: Remove .fixup usage

For the !CC_AS_ASM_GOTO_OUTPUT (aka. the legacy codepath), remove the
.fixup usage by employing both EX_TYPE_EFAULT_REG and EX_FLAG_CLEAR.
Like was already done for X86_32's version of __get_user_asm_u64() use
the "a" register for output, specifically so we can use CLEAR_AX.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101325.485154848@infradead.org
---
 arch/x86/include/asm/uaccess.h | 39 ++++++++++++++-------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 33a6840..ac6233a 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -351,24 +351,22 @@ do {									\
 		     "1:	movl %[lowbits],%%eax\n"		\
 		     "2:	movl %[highbits],%%edx\n"		\
 		     "3:\n"						\
-		     ".section .fixup,\"ax\"\n"				\
-		     "4:	mov %[efault],%[errout]\n"		\
-		     "	xorl %%eax,%%eax\n"				\
-		     "	xorl %%edx,%%edx\n"				\
-		     "	jmp 3b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE_UA(1b, 4b)				\
-		     _ASM_EXTABLE_UA(2b, 4b)				\
+		     _ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_EFAULT_REG |	\
+					   EX_FLAG_CLEAR_AX_DX,		\
+					   %[errout])			\
+		     _ASM_EXTABLE_TYPE_REG(2b, 3b, EX_TYPE_EFAULT_REG |	\
+					   EX_FLAG_CLEAR_AX_DX,		\
+					   %[errout])			\
 		     : [errout] "=r" (retval),				\
 		       [output] "=&A"(x)				\
 		     : [lowbits] "m" (__m(__ptr)),			\
 		       [highbits] "m" __m(((u32 __user *)(__ptr)) + 1),	\
-		       [efault] "i" (-EFAULT), "0" (retval));		\
+		       "0" (retval));					\
 })
 
 #else
 #define __get_user_asm_u64(x, ptr, retval) \
-	 __get_user_asm(x, ptr, retval, "q", "=r")
+	 __get_user_asm(x, ptr, retval, "q")
 #endif
 
 #define __get_user_size(x, ptr, size, retval)				\
@@ -379,14 +377,14 @@ do {									\
 	__chk_user_ptr(ptr);						\
 	switch (size) {							\
 	case 1:								\
-		__get_user_asm(x_u8__, ptr, retval, "b", "=q");		\
+		__get_user_asm(x_u8__, ptr, retval, "b");		\
 		(x) = x_u8__;						\
 		break;							\
 	case 2:								\
-		__get_user_asm(x, ptr, retval, "w", "=r");		\
+		__get_user_asm(x, ptr, retval, "w");			\
 		break;							\
 	case 4:								\
-		__get_user_asm(x, ptr, retval, "l", "=r");		\
+		__get_user_asm(x, ptr, retval, "l");			\
 		break;							\
 	case 8:								\
 		__get_user_asm_u64(x, ptr, retval);			\
@@ -396,20 +394,17 @@ do {									\
 	}								\
 } while (0)
 
-#define __get_user_asm(x, addr, err, itype, ltype)			\
+#define __get_user_asm(x, addr, err, itype)				\
 	asm volatile("\n"						\
 		     "1:	mov"itype" %[umem],%[output]\n"		\
 		     "2:\n"						\
-		     ".section .fixup,\"ax\"\n"				\
-		     "3:	mov %[efault],%[errout]\n"		\
-		     "	xorl %k[output],%k[output]\n"			\
-		     "	jmp 2b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE_UA(1b, 3b)				\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG | \
+					   EX_FLAG_CLEAR_AX,		\
+					   %[errout])			\
 		     : [errout] "=r" (err),				\
-		       [output] ltype(x)				\
+		       [output] "=a" (x)				\
 		     : [umem] "m" (__m(addr)),				\
-		       [efault] "i" (-EFAULT), "0" (err))
+		       "0" (err))
 
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
