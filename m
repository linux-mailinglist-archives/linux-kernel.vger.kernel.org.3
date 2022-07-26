Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874785816AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbiGZPoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGZPoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:44:12 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D16C2CDDD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:44:10 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id j11so10883165qvt.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BexC9/AbcP3o6Ymn2Ewp4h96F58LBV0iCsv1+O+Xgow=;
        b=U0lbfOUC9m2barn1E18hRc+8hedwwhAsqBjx+mMnkrx9FyA0Z4MVn3nnG8/5QGKcBT
         EjvrPB3CbDZsS3BZLWxXVzHg1972G/j67E7SMZ+Xkr8lFSiYopvbXwLrFTzKus1hY6bG
         KZB+xAw7juawSmsQW2hrT41amILq5uEYTXrM80QNSQtiFkT8yAaQQApYSIgUZ7+De3s0
         3ws/gaD85sLboongTpBUcTG+aQb8LOKp16LdDkIV8TCljAXPoVhps4wsYu3iMoO1ZMbI
         Ku+bzeACs3cna3SWd3C8O/13muHtQLIaD1l2tkpr4+5VUd0cseHV31AahPbdQGmQKsXA
         1u2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BexC9/AbcP3o6Ymn2Ewp4h96F58LBV0iCsv1+O+Xgow=;
        b=dTMVEsu28CSosy9JGXdfoGuty7PH0b07ACKkf/PAVA93tQ5Ft27Zs9ittZx2P0mq9u
         cxSkz9PoDAs0p3BnEqW/gQYaj+GpDAISqPze9lhQheqvI3jbZn1992JYf0yhp2tfbz9j
         NdM8aTNx8gMvqoUOzDrKQFUCUSJJrBFxo+fi0v9c0Ju130YT1lZWuPJF1f45x+GIW7rT
         wtig/FbXDMGj99jkh5UcLJT9Ozw7bYz1oQsugEe313qfBjWndB8S6yjpdGbwPagEVxLe
         Zpsbr/5ojoNRUoysDFUOsSbvl6uaRM2BQebabltn3LPJvFTBbZ8ris1qCMvbthv3R+Fj
         JjoQ==
X-Gm-Message-State: AJIora/7S7k1Mufb2SwCMbspoAqjqLdUytSrSVRVmCDbv4ixChz4uerD
        EDLqO1dd1cZZ27fDtR+ISAE0tTK72xE=
X-Google-Smtp-Source: AGRyM1thh9Gw+loukSHoxH3TzUo0DXR1Sx7xP1j9+jZiKzPT7hvUmO35dSBTwlTZOrL1XtvWOXcc3w==
X-Received: by 2002:a05:6214:20a9:b0:473:6e47:956 with SMTP id 9-20020a05621420a900b004736e470956mr15372560qvd.31.1658850249319;
        Tue, 26 Jul 2022 08:44:09 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.fl.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id q30-20020a37f71e000000b006a79d8c8198sm10861396qkj.135.2022.07.26.08.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:44:08 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm: drop arch implementation for find_bit() functions
Date:   Tue, 26 Jul 2022 08:44:07 -0700
Message-Id: <20220726154407.3464776-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_next_bit(bitmap, nbits, off) shouldn't touch memory if
nbits == 0 or off >= nbits to avoid out-of-boundary access.

Generic implementation has explicit check for this, but arm doesn't,
which is spotted by KFENCE when running test_bitmap.

Instead of fixing arm implementation, this patch switches arm to use
generic code. It's better optimized for small bitmaps with
small_const_nbits(), and for long bitmaps too because generic code
fetches words with LDR, while arch code fetches bytes with LDRB.

The KFENCE report:

BUG: KFENCE: out-of-bounds read in _find_next_bit_le (arch/arm/lib/findbit.S:88)

Out-of-bounds read at 0xef59e000 (4096B right of kfence-#93):
_find_next_bit_le (arch/arm/lib/findbit.S:88)
kfence-#93: 0xef59d000-0xef59dfff, size=4096, cache=kmalloc-4k
allocated by task 1 on cpu 1 at 18.432911s:
test_bitmap_printlist (./include/linux/slab.h:600 lib/test_bitmap.c:452)
test_bitmap_init (lib/test_bitmap.c:883 lib/test_bitmap.c:889)
do_one_initcall (./include/linux/jump_label.h:261 ./include/linux/jump_label.h:271 ./include/trace/events/initcall.h:48 init/main.c:1296)
kernel_init_freeable (init/main.c:1367 init/main.c:1384 init/main.c:1403 init/main.c:1610)
kernel_init (init/main.c:1501)
ret_from_fork (arch/arm/kernel/entry-common.S:149)
 0x0
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc8 #1
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at _find_next_bit_le (arch/arm/lib/findbit.S:88)
LR is at bitmap_list_string.constprop.0 (lib/vsprintf.c:1246)
pc : lr : psr: 20000113
sp : f082dc70  ip : 00000001  fp : 00000001
r10: 00000000  r9 : 0000002d  r8 : ef59d000
r7 : c0e55514  r6 : c2215000  r5 : 00008000  r4 : 00008000
r3 : 845cac12  r2 : 00008001  r1 : 00008000  r0 : ef59d000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4000406a  DAC: 00000051
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc8 #1
Hardware name: Samsung Exynos (Flattened Device Tree)
unwind_backtrace from show_stack (arch/arm/kernel/traps.c:255)
show_stack from dump_stack_lvl (lib/dump_stack.c:107)
dump_stack_lvl from kfence_report_error (mm/kfence/report.c:262)
kfence_report_error from kfence_handle_page_fault (mm/kfence/core.c:1151)
kfence_handle_page_fault from __do_kernel_fault.part.0 (arch/arm/mm/fault.c:143)
__do_kernel_fault.part.0 from do_page_fault (arch/arm/mm/fault.c:380)
do_page_fault from do_DataAbort (arch/arm/mm/fault.c:539)
do_DataAbort from __dabt_svc (arch/arm/kernel/entry-armv.S:214)
Exception stack(0xf082dc20 to 0xf082dc68)
dc20: ef59d000 00008000 00008001 845cac12 00008000 00008000 c2215000 c0e55514
dc40: ef59d000 0000002d 00000000 00000001 00000001 f082dc70 c0715930 c06ff18c
dc60: 20000113 ffffffff
__dabt_svc from _find_next_bit_le (arch/arm/lib/findbit.S:88)

CC: Guenter Roeck <linux@roeck-us.net>
CC: Dennis Zhou <dennis@kernel.org>
CC: Russell King <linux@armlinux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: linux-arm-kernel@lists.infradead.org
Reported-by: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/arm/include/asm/bitops.h |  61 -----------
 arch/arm/kernel/armksyms.c    |  11 --
 arch/arm/lib/Makefile         |   2 +-
 arch/arm/lib/findbit.S        | 193 ----------------------------------
 4 files changed, 1 insertion(+), 266 deletions(-)
 delete mode 100644 arch/arm/lib/findbit.S

diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index 8e94fe7ab5eb..23a7cde3422e 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -157,22 +157,6 @@ extern int _test_and_set_bit(int nr, volatile unsigned long * p);
 extern int _test_and_clear_bit(int nr, volatile unsigned long * p);
 extern int _test_and_change_bit(int nr, volatile unsigned long * p);
 
-/*
- * Little endian assembly bitops.  nr = 0 -> byte 0 bit 0.
- */
-extern int _find_first_zero_bit_le(const unsigned long *p, unsigned size);
-extern int _find_next_zero_bit_le(const unsigned long *p, int size, int offset);
-extern int _find_first_bit_le(const unsigned long *p, unsigned size);
-extern int _find_next_bit_le(const unsigned long *p, int size, int offset);
-
-/*
- * Big endian assembly bitops.  nr = 0 -> byte 3 bit 0.
- */
-extern int _find_first_zero_bit_be(const unsigned long *p, unsigned size);
-extern int _find_next_zero_bit_be(const unsigned long *p, int size, int offset);
-extern int _find_first_bit_be(const unsigned long *p, unsigned size);
-extern int _find_next_bit_be(const unsigned long *p, int size, int offset);
-
 #ifndef CONFIG_SMP
 /*
  * The __* form of bitops are non-atomic and may be reordered.
@@ -193,26 +177,6 @@ extern int _find_next_bit_be(const unsigned long *p, int size, int offset);
 #define test_and_clear_bit(nr,p)	ATOMIC_BITOP(test_and_clear_bit,nr,p)
 #define test_and_change_bit(nr,p)	ATOMIC_BITOP(test_and_change_bit,nr,p)
 
-#ifndef __ARMEB__
-/*
- * These are the little endian, atomic definitions.
- */
-#define find_first_zero_bit(p,sz)	_find_first_zero_bit_le(p,sz)
-#define find_next_zero_bit(p,sz,off)	_find_next_zero_bit_le(p,sz,off)
-#define find_first_bit(p,sz)		_find_first_bit_le(p,sz)
-#define find_next_bit(p,sz,off)		_find_next_bit_le(p,sz,off)
-
-#else
-/*
- * These are the big endian, atomic definitions.
- */
-#define find_first_zero_bit(p,sz)	_find_first_zero_bit_be(p,sz)
-#define find_next_zero_bit(p,sz,off)	_find_next_zero_bit_be(p,sz,off)
-#define find_first_bit(p,sz)		_find_first_bit_be(p,sz)
-#define find_next_bit(p,sz,off)		_find_next_bit_be(p,sz,off)
-
-#endif
-
 #if __LINUX_ARM_ARCH__ < 5
 
 #include <asm-generic/bitops/__fls.h>
@@ -235,35 +199,10 @@ extern int _find_next_bit_be(const unsigned long *p, int size, int offset);
 #endif
 
 #include <asm-generic/bitops/ffz.h>
-
 #include <asm-generic/bitops/fls64.h>
-
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
-
-#ifdef __ARMEB__
-
-static inline int find_first_zero_bit_le(const void *p, unsigned size)
-{
-	return _find_first_zero_bit_le(p, size);
-}
-#define find_first_zero_bit_le find_first_zero_bit_le
-
-static inline int find_next_zero_bit_le(const void *p, int size, int offset)
-{
-	return _find_next_zero_bit_le(p, size, offset);
-}
-#define find_next_zero_bit_le find_next_zero_bit_le
-
-static inline int find_next_bit_le(const void *p, int size, int offset)
-{
-	return _find_next_bit_le(p, size, offset);
-}
-#define find_next_bit_le find_next_bit_le
-
-#endif
-
 #include <asm-generic/bitops/le.h>
 
 /*
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 82e96ac83684..10130987d388 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -150,17 +150,6 @@ EXPORT_SYMBOL(_clear_bit);
 EXPORT_SYMBOL(_test_and_clear_bit);
 EXPORT_SYMBOL(_change_bit);
 EXPORT_SYMBOL(_test_and_change_bit);
-EXPORT_SYMBOL(_find_first_zero_bit_le);
-EXPORT_SYMBOL(_find_next_zero_bit_le);
-EXPORT_SYMBOL(_find_first_bit_le);
-EXPORT_SYMBOL(_find_next_bit_le);
-
-#ifdef __ARMEB__
-EXPORT_SYMBOL(_find_first_zero_bit_be);
-EXPORT_SYMBOL(_find_next_zero_bit_be);
-EXPORT_SYMBOL(_find_first_bit_be);
-EXPORT_SYMBOL(_find_next_bit_be);
-#endif
 
 #ifdef CONFIG_FUNCTION_TRACER
 EXPORT_SYMBOL(__gnu_mcount_nc);
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 6d2ba454f25b..8b152b1a3014 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -7,7 +7,7 @@
 
 lib-y		:= changebit.o csumipv6.o csumpartial.o               \
 		   csumpartialcopy.o csumpartialcopyuser.o clearbit.o \
-		   delay.o delay-loop.o findbit.o memchr.o memcpy.o   \
+		   delay.o delay-loop.o memchr.o memcpy.o             \
 		   memmove.o memset.o setbit.o                        \
 		   strchr.o strrchr.o                                 \
 		   testchangebit.o testclearbit.o testsetbit.o        \
diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
deleted file mode 100644
index b5e8b9ae4c7d..000000000000
--- a/arch/arm/lib/findbit.S
+++ /dev/null
@@ -1,193 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  linux/arch/arm/lib/findbit.S
- *
- *  Copyright (C) 1995-2000 Russell King
- *
- * 16th March 2001 - John Ripley <jripley@sonicblue.com>
- *   Fixed so that "size" is an exclusive not an inclusive quantity.
- *   All users of these functions expect exclusive sizes, and may
- *   also call with zero size.
- * Reworked by rmk.
- */
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-                .text
-
-/*
- * Purpose  : Find a 'zero' bit
- * Prototype: int find_first_zero_bit(void *addr, unsigned int maxbit);
- */
-ENTRY(_find_first_zero_bit_le)
-		teq	r1, #0	
-		beq	3f
-		mov	r2, #0
-1:
- ARM(		ldrb	r3, [r0, r2, lsr #3]	)
- THUMB(		lsr	r3, r2, #3		)
- THUMB(		ldrb	r3, [r0, r3]		)
-		eors	r3, r3, #0xff		@ invert bits
-		bne	.L_found		@ any now set - found zero bit
-		add	r2, r2, #8		@ next bit pointer
-2:		cmp	r2, r1			@ any more?
-		blo	1b
-3:		mov	r0, r1			@ no free bits
-		ret	lr
-ENDPROC(_find_first_zero_bit_le)
-
-/*
- * Purpose  : Find next 'zero' bit
- * Prototype: int find_next_zero_bit(void *addr, unsigned int maxbit, int offset)
- */
-ENTRY(_find_next_zero_bit_le)
-		teq	r1, #0
-		beq	3b
-		ands	ip, r2, #7
-		beq	1b			@ If new byte, goto old routine
- ARM(		ldrb	r3, [r0, r2, lsr #3]	)
- THUMB(		lsr	r3, r2, #3		)
- THUMB(		ldrb	r3, [r0, r3]		)
-		eor	r3, r3, #0xff		@ now looking for a 1 bit
-		movs	r3, r3, lsr ip		@ shift off unused bits
-		bne	.L_found
-		orr	r2, r2, #7		@ if zero, then no bits here
-		add	r2, r2, #1		@ align bit pointer
-		b	2b			@ loop for next bit
-ENDPROC(_find_next_zero_bit_le)
-
-/*
- * Purpose  : Find a 'one' bit
- * Prototype: int find_first_bit(const unsigned long *addr, unsigned int maxbit);
- */
-ENTRY(_find_first_bit_le)
-		teq	r1, #0	
-		beq	3f
-		mov	r2, #0
-1:
- ARM(		ldrb	r3, [r0, r2, lsr #3]	)
- THUMB(		lsr	r3, r2, #3		)
- THUMB(		ldrb	r3, [r0, r3]		)
-		movs	r3, r3
-		bne	.L_found		@ any now set - found zero bit
-		add	r2, r2, #8		@ next bit pointer
-2:		cmp	r2, r1			@ any more?
-		blo	1b
-3:		mov	r0, r1			@ no free bits
-		ret	lr
-ENDPROC(_find_first_bit_le)
-
-/*
- * Purpose  : Find next 'one' bit
- * Prototype: int find_next_zero_bit(void *addr, unsigned int maxbit, int offset)
- */
-ENTRY(_find_next_bit_le)
-		teq	r1, #0
-		beq	3b
-		ands	ip, r2, #7
-		beq	1b			@ If new byte, goto old routine
- ARM(		ldrb	r3, [r0, r2, lsr #3]	)
- THUMB(		lsr	r3, r2, #3		)
- THUMB(		ldrb	r3, [r0, r3]		)
-		movs	r3, r3, lsr ip		@ shift off unused bits
-		bne	.L_found
-		orr	r2, r2, #7		@ if zero, then no bits here
-		add	r2, r2, #1		@ align bit pointer
-		b	2b			@ loop for next bit
-ENDPROC(_find_next_bit_le)
-
-#ifdef __ARMEB__
-
-ENTRY(_find_first_zero_bit_be)
-		teq	r1, #0
-		beq	3f
-		mov	r2, #0
-1:		eor	r3, r2, #0x18		@ big endian byte ordering
- ARM(		ldrb	r3, [r0, r3, lsr #3]	)
- THUMB(		lsr	r3, #3			)
- THUMB(		ldrb	r3, [r0, r3]		)
-		eors	r3, r3, #0xff		@ invert bits
-		bne	.L_found		@ any now set - found zero bit
-		add	r2, r2, #8		@ next bit pointer
-2:		cmp	r2, r1			@ any more?
-		blo	1b
-3:		mov	r0, r1			@ no free bits
-		ret	lr
-ENDPROC(_find_first_zero_bit_be)
-
-ENTRY(_find_next_zero_bit_be)
-		teq	r1, #0
-		beq	3b
-		ands	ip, r2, #7
-		beq	1b			@ If new byte, goto old routine
-		eor	r3, r2, #0x18		@ big endian byte ordering
- ARM(		ldrb	r3, [r0, r3, lsr #3]	)
- THUMB(		lsr	r3, #3			)
- THUMB(		ldrb	r3, [r0, r3]		)
-		eor	r3, r3, #0xff		@ now looking for a 1 bit
-		movs	r3, r3, lsr ip		@ shift off unused bits
-		bne	.L_found
-		orr	r2, r2, #7		@ if zero, then no bits here
-		add	r2, r2, #1		@ align bit pointer
-		b	2b			@ loop for next bit
-ENDPROC(_find_next_zero_bit_be)
-
-ENTRY(_find_first_bit_be)
-		teq	r1, #0
-		beq	3f
-		mov	r2, #0
-1:		eor	r3, r2, #0x18		@ big endian byte ordering
- ARM(		ldrb	r3, [r0, r3, lsr #3]	)
- THUMB(		lsr	r3, #3			)
- THUMB(		ldrb	r3, [r0, r3]		)
-		movs	r3, r3
-		bne	.L_found		@ any now set - found zero bit
-		add	r2, r2, #8		@ next bit pointer
-2:		cmp	r2, r1			@ any more?
-		blo	1b
-3:		mov	r0, r1			@ no free bits
-		ret	lr
-ENDPROC(_find_first_bit_be)
-
-ENTRY(_find_next_bit_be)
-		teq	r1, #0
-		beq	3b
-		ands	ip, r2, #7
-		beq	1b			@ If new byte, goto old routine
-		eor	r3, r2, #0x18		@ big endian byte ordering
- ARM(		ldrb	r3, [r0, r3, lsr #3]	)
- THUMB(		lsr	r3, #3			)
- THUMB(		ldrb	r3, [r0, r3]		)
-		movs	r3, r3, lsr ip		@ shift off unused bits
-		bne	.L_found
-		orr	r2, r2, #7		@ if zero, then no bits here
-		add	r2, r2, #1		@ align bit pointer
-		b	2b			@ loop for next bit
-ENDPROC(_find_next_bit_be)
-
-#endif
-
-/*
- * One or more bits in the LSB of r3 are assumed to be set.
- */
-.L_found:
-#if __LINUX_ARM_ARCH__ >= 5
-		rsb	r0, r3, #0
-		and	r3, r3, r0
-		clz	r3, r3
-		rsb	r3, r3, #31
-		add	r0, r2, r3
-#else
-		tst	r3, #0x0f
-		addeq	r2, r2, #4
-		movne	r3, r3, lsl #4
-		tst	r3, #0x30
-		addeq	r2, r2, #2
-		movne	r3, r3, lsl #2
-		tst	r3, #0x40
-		addeq	r2, r2, #1
-		mov	r0, r2
-#endif
-		cmp	r1, r0			@ Clamp to maxbit
-		movlo	r0, r1
-		ret	lr
-
-- 
2.34.1

