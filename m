Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6D94D3CFB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbiCIWfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbiCIWfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:35:38 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ED212168A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:34:37 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 9so3220985pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U6O5sm7q1F6xFSlPrH17/2jiVY2VUS9QtitvGJZRQyk=;
        b=KnvZ8YiLrEK4Afru/3Tu2SukfgKgYEj7Mscax/ctTPtDn3sgCDBvnrJ70J+xa24cBa
         E731vxG0Tx9xpg8m9XXBa6BmBHY8a0xvS3QDbt3Yz65V+ryUquGW0jIdLDoXcB8YBWjj
         i+guqHsauDBQ2/t3YTa/V1oAxigBON9I6ahgHNu1NUzYYfr/AyEOSjyumHkQzVWqvJ5J
         tCuIsAjNyyNV5ccPwGCg7loHtofGHn0qlaOyUWe9hIHACsJ/sNyOXAaM9OEm4fB0i0GX
         tX48vNBVJAtot1W3o1r7bpSlu92V/cVK0EScVABDSvYNlg5BToDHUxD/mVRDgPvg+SJ4
         vZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U6O5sm7q1F6xFSlPrH17/2jiVY2VUS9QtitvGJZRQyk=;
        b=KbEEo+e1efTDJxfUgh4JyhkDATcCLBVezjXKyH/jYA/YzscP0GToZNx8HlQMLqsjUv
         psMOOxmvz58bFXi73UwomU4WXvrFn4jyrKBICsNfwHRnWScnQ2/p1rL1la6PQGEGgSMe
         4I9F6kr5Cviwi1XvY1azwJK2ZORrR4S4z1NLmGW+BAB+j/lQ609aNZlV9hOfsChcwI3j
         EfxmDbBSG5FoLEnA97dE6CeHilQrbY6WQgd7yacx9Q7kTKKzM6paeZKuOhYs+saWXTTJ
         Jv4zWxXps+CUPC0S4hzSsQcQAkobtLofny1vOs4UvHjhPBEimn4EiZZm3C7hE9UOJj9k
         1HoA==
X-Gm-Message-State: AOAM533e0Jzo1YUCf+SxA2NJ05ia3mFCgaLhNlBl4UQB2CpBdBeZE5vi
        X5v3XTHNISw7C80yAVprQk744OepBTclyg==
X-Google-Smtp-Source: ABdhPJzGl1Z1Rc5KiPXNcDUYVz/ayHeqedpwp76qEbtb2lt066z6xSeqFPyFPtT63u/ONkgLZz80Eg==
X-Received: by 2002:a17:902:ec82:b0:151:cd00:99d with SMTP id x2-20020a170902ec8200b00151cd00099dmr1887580plg.96.1646865277093;
        Wed, 09 Mar 2022 14:34:37 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:6f34:be93:349a:f478])
        by smtp.gmail.com with ESMTPSA id e14-20020a056a001a8e00b004f75cf1ab6csm3476477pfv.206.2022.03.09.14.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:34:36 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/2] xtensa: add helpers for division, remainder and shifts
Date:   Wed,  9 Mar 2022 14:34:17 -0800
Message-Id: <20220309223418.1253242-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220309223418.1253242-1-jcmvbkbc@gmail.com>
References: <20220309223418.1253242-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't rely on libgcc presence, build own versions of the helpers with
correct ABI.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/asmmacro.h |  34 ++++++++
 arch/xtensa/lib/Makefile           |   2 +
 arch/xtensa/lib/ashldi3.S          |  28 ++++++
 arch/xtensa/lib/ashrdi3.S          |  28 ++++++
 arch/xtensa/lib/divsi3.S           |  74 ++++++++++++++++
 arch/xtensa/lib/lshrdi3.S          |  28 ++++++
 arch/xtensa/lib/modsi3.S           |  87 +++++++++++++++++++
 arch/xtensa/lib/mulsi3.S           | 133 +++++++++++++++++++++++++++++
 arch/xtensa/lib/udivsi3.S          |  68 +++++++++++++++
 arch/xtensa/lib/umodsi3.S          |  57 +++++++++++++
 10 files changed, 539 insertions(+)
 create mode 100644 arch/xtensa/lib/ashldi3.S
 create mode 100644 arch/xtensa/lib/ashrdi3.S
 create mode 100644 arch/xtensa/lib/divsi3.S
 create mode 100644 arch/xtensa/lib/lshrdi3.S
 create mode 100644 arch/xtensa/lib/modsi3.S
 create mode 100644 arch/xtensa/lib/mulsi3.S
 create mode 100644 arch/xtensa/lib/udivsi3.S
 create mode 100644 arch/xtensa/lib/umodsi3.S

diff --git a/arch/xtensa/include/asm/asmmacro.h b/arch/xtensa/include/asm/asmmacro.h
index 809c507d1825..3190157950fa 100644
--- a/arch/xtensa/include/asm/asmmacro.h
+++ b/arch/xtensa/include/asm/asmmacro.h
@@ -191,6 +191,40 @@
 #endif
 	.endm
 
+	.macro	do_nsau cnt, val, tmp, a
+#if XCHAL_HAVE_NSA
+	nsau	\cnt, \val
+#else
+	mov	\a, \val
+	movi	\cnt, 0
+	extui	\tmp, \a, 16, 16
+	bnez	\tmp, 0f
+	movi	\cnt, 16
+	slli	\a, \a, 16
+0:
+	extui	\tmp, \a, 24, 8
+	bnez	\tmp, 1f
+	addi	\cnt, \cnt, 8
+	slli	\a, \a, 8
+1:
+	movi	\tmp, __nsau_data
+	extui	\a, \a, 24, 8
+	add	\tmp, \tmp, \a
+	l8ui	\tmp, \tmp, 0
+	add	\cnt, \cnt, \tmp
+#endif /* !XCHAL_HAVE_NSA */
+	.endm
+
+	.macro	do_abs dst, src, tmp
+#if XCHAL_HAVE_ABS
+	abs	\dst, \src
+#else
+	neg	\tmp, \src
+	movgez	\tmp, \src, \src
+	mov	\dst, \tmp
+#endif
+	.endm
+
 #define XTENSA_STACK_ALIGNMENT		16
 
 #if defined(__XTENSA_WINDOWED_ABI__)
diff --git a/arch/xtensa/lib/Makefile b/arch/xtensa/lib/Makefile
index 9437ca51f18a..5848c133f7ea 100644
--- a/arch/xtensa/lib/Makefile
+++ b/arch/xtensa/lib/Makefile
@@ -4,5 +4,7 @@
 #
 
 lib-y	+= memcopy.o memset.o checksum.o \
+	   ashldi3.o ashrdi3.o lshrdi3.o \
+	   divsi3.o udivsi3.o modsi3.o umodsi3.o mulsi3.o \
 	   usercopy.o strncpy_user.o strnlen_user.o
 lib-$(CONFIG_PCI) += pci-auto.o
diff --git a/arch/xtensa/lib/ashldi3.S b/arch/xtensa/lib/ashldi3.S
new file mode 100644
index 000000000000..67fb0da9e432
--- /dev/null
+++ b/arch/xtensa/lib/ashldi3.S
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0 */
+#include <linux/linkage.h>
+#include <asm/asmmacro.h>
+#include <asm/core.h>
+
+#ifdef __XTENSA_EB__
+#define uh a2
+#define ul a3
+#else
+#define uh a3
+#define ul a2
+#endif /* __XTENSA_EB__ */
+
+ENTRY(__ashldi3)
+
+	abi_entry_default
+	ssl	a4
+	bgei	a4, 32, .Llow_only
+	src	uh, uh, ul
+	sll	ul, ul
+	abi_ret_default
+
+.Llow_only:
+	sll	uh, ul
+	movi	ul, 0
+	abi_ret_default
+
+ENDPROC(__ashldi3)
diff --git a/arch/xtensa/lib/ashrdi3.S b/arch/xtensa/lib/ashrdi3.S
new file mode 100644
index 000000000000..cbf052c512cc
--- /dev/null
+++ b/arch/xtensa/lib/ashrdi3.S
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0 */
+#include <linux/linkage.h>
+#include <asm/asmmacro.h>
+#include <asm/core.h>
+
+#ifdef __XTENSA_EB__
+#define uh a2
+#define ul a3
+#else
+#define uh a3
+#define ul a2
+#endif /* __XTENSA_EB__ */
+
+ENTRY(__ashrdi3)
+
+	abi_entry_default
+	ssr	a4
+	bgei	a4, 32, .Lhigh_only
+	src	ul, uh, ul
+	sra	uh, uh
+	abi_ret_default
+
+.Lhigh_only:
+	sra	ul, uh
+	srai	uh, uh, 31
+	abi_ret_default
+
+ENDPROC(__ashrdi3)
diff --git a/arch/xtensa/lib/divsi3.S b/arch/xtensa/lib/divsi3.S
new file mode 100644
index 000000000000..b044b4744a8b
--- /dev/null
+++ b/arch/xtensa/lib/divsi3.S
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0 */
+#include <linux/linkage.h>
+#include <asm/asmmacro.h>
+#include <asm/core.h>
+
+ENTRY(__divsi3)
+
+	abi_entry_default
+#if XCHAL_HAVE_DIV32
+	quos	a2, a2, a3
+#else
+	xor	a7, a2, a3	/* sign = dividend ^ divisor */
+	do_abs	a6, a2, a4	/* udividend = abs (dividend) */
+	do_abs	a3, a3, a4	/* udivisor = abs (divisor) */
+	bltui	a3, 2, .Lle_one	/* check if udivisor <= 1 */
+	do_nsau	a5, a6, a2, a8	/* udividend_shift = nsau (udividend) */
+	do_nsau	a4, a3, a2, a8	/* udivisor_shift = nsau (udivisor) */
+	bgeu	a5, a4, .Lspecial
+
+	sub	a4, a4, a5	/* count = udivisor_shift - udividend_shift */
+	ssl	a4
+	sll	a3, a3		/* udivisor <<= count */
+	movi	a2, 0		/* quotient = 0 */
+
+	/* test-subtract-and-shift loop; one quotient bit on each iteration */
+#if XCHAL_HAVE_LOOPS
+	loopnez	a4, .Lloopend
+#endif /* XCHAL_HAVE_LOOPS */
+.Lloop:
+	bltu	a6, a3, .Lzerobit
+	sub	a6, a6, a3
+	addi	a2, a2, 1
+.Lzerobit:
+	slli	a2, a2, 1
+	srli	a3, a3, 1
+#if !XCHAL_HAVE_LOOPS
+	addi	a4, a4, -1
+	bnez	a4, .Lloop
+#endif /* !XCHAL_HAVE_LOOPS */
+.Lloopend:
+
+	bltu	a6, a3, .Lreturn
+	addi	a2, a2, 1	/* increment if udividend >= udivisor */
+.Lreturn:
+	neg	a5, a2
+	movltz	a2, a5, a7	/* return (sign < 0) ? -quotient : quotient */
+	abi_ret_default
+
+.Lle_one:
+	beqz	a3, .Lerror
+	neg	a2, a6		/* if udivisor == 1, then return... */
+	movgez	a2, a6, a7	/* (sign < 0) ? -udividend : udividend */
+	abi_ret_default
+
+.Lspecial:
+	bltu	a6, a3, .Lreturn0 /* if dividend < divisor, return 0 */
+	movi	a2, 1
+	movi	a4, -1
+	movltz	a2, a4, a7	/* else return (sign < 0) ? -1 : 1 */
+	abi_ret_default
+
+.Lerror:
+	/* Divide by zero: Use an illegal instruction to force an exception.
+	   The subsequent "DIV0" string can be recognized by the exception
+	   handler to identify the real cause of the exception.  */
+	ill
+	.ascii	"DIV0"
+
+.Lreturn0:
+	movi	a2, 0
+#endif /* XCHAL_HAVE_DIV32 */
+	abi_ret_default
+
+ENDPROC(__divsi3)
diff --git a/arch/xtensa/lib/lshrdi3.S b/arch/xtensa/lib/lshrdi3.S
new file mode 100644
index 000000000000..129ef8d1725b
--- /dev/null
+++ b/arch/xtensa/lib/lshrdi3.S
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0 */
+#include <linux/linkage.h>
+#include <asm/asmmacro.h>
+#include <asm/core.h>
+
+#ifdef __XTENSA_EB__
+#define uh a2
+#define ul a3
+#else
+#define uh a3
+#define ul a2
+#endif /* __XTENSA_EB__ */
+
+ENTRY(__lshrdi3)
+
+	abi_entry_default
+	ssr	a4
+	bgei	a4, 32, .Lhigh_only
+	src	ul, uh, ul
+	srl	uh, uh
+	abi_ret_default
+
+.Lhigh_only:
+	srl	ul, uh
+	movi	uh, 0
+	abi_ret_default
+
+ENDPROC(__lshrdi3)
diff --git a/arch/xtensa/lib/modsi3.S b/arch/xtensa/lib/modsi3.S
new file mode 100644
index 000000000000..d00e77181e20
--- /dev/null
+++ b/arch/xtensa/lib/modsi3.S
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0 */
+#include <linux/linkage.h>
+#include <asm/asmmacro.h>
+#include <asm/core.h>
+
+ENTRY(__modsi3)
+
+	abi_entry_default
+#if XCHAL_HAVE_DIV32
+	rems	a2, a2, a3
+#else
+	mov	a7, a2		/* save original (signed) dividend */
+	do_abs	a2, a2, a4	/* udividend = abs (dividend) */
+	do_abs	a3, a3, a4	/* udivisor = abs (divisor) */
+	bltui	a3, 2, .Lle_one	/* check if udivisor <= 1 */
+	do_nsau	a5, a2, a6, a8	/* udividend_shift = nsau (udividend) */
+	do_nsau	a4, a3, a6, a8	/* udivisor_shift = nsau (udivisor) */
+	bgeu	a5, a4, .Lspecial
+
+	sub	a4, a4, a5	/* count = udivisor_shift - udividend_shift */
+	ssl	a4
+	sll	a3, a3		/* udivisor <<= count */
+
+	/* test-subtract-and-shift loop */
+#if XCHAL_HAVE_LOOPS
+	loopnez	a4, .Lloopend
+#endif /* XCHAL_HAVE_LOOPS */
+.Lloop:
+	bltu	a2, a3, .Lzerobit
+	sub	a2, a2, a3
+.Lzerobit:
+	srli	a3, a3, 1
+#if !XCHAL_HAVE_LOOPS
+	addi	a4, a4, -1
+	bnez	a4, .Lloop
+#endif /* !XCHAL_HAVE_LOOPS */
+.Lloopend:
+
+.Lspecial:
+	bltu	a2, a3, .Lreturn
+	sub	a2, a2, a3	/* subtract again if udividend >= udivisor */
+.Lreturn:
+	bgez	a7, .Lpositive
+	neg	a2, a2		/* if (dividend < 0), return -udividend */
+.Lpositive:
+	abi_ret_default
+
+.Lle_one:
+	bnez	a3, .Lreturn0
+
+	/* Divide by zero: Use an illegal instruction to force an exception.
+	   The subsequent "DIV0" string can be recognized by the exception
+	   handler to identify the real cause of the exception.  */
+	ill
+	.ascii	"DIV0"
+
+.Lreturn0:
+	movi	a2, 0
+#endif /* XCHAL_HAVE_DIV32 */
+	abi_ret_default
+
+ENDPROC(__modsi3)
+
+#if !XCHAL_HAVE_NSA
+	.section .rodata
+	.align	4
+	.global	__nsau_data
+	.type	__nsau_data, @object
+__nsau_data:
+	.byte	8, 7, 6, 6, 5, 5, 5, 5, 4, 4, 4, 4, 4, 4, 4, 4
+	.byte	3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
+	.byte	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
+	.byte	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
+	.byte	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
+	.byte	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
+	.byte	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
+	.byte	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
+	.byte	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+	.byte	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+	.byte	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+	.byte	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+	.byte	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+	.byte	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+	.byte	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+	.byte	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+	.size	__nsau_data, . - __nsau_data
+#endif /* !XCHAL_HAVE_NSA */
diff --git a/arch/xtensa/lib/mulsi3.S b/arch/xtensa/lib/mulsi3.S
new file mode 100644
index 000000000000..91a9d7c62f96
--- /dev/null
+++ b/arch/xtensa/lib/mulsi3.S
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0 */
+#include <linux/linkage.h>
+#include <asm/asmmacro.h>
+#include <asm/core.h>
+
+	.macro	do_addx2 dst, as, at, tmp
+#if XCHAL_HAVE_ADDX
+	addx2	\dst, \as, \at
+#else
+	slli	\tmp, \as, 1
+	add	\dst, \tmp, \at
+#endif
+	.endm
+
+	.macro	do_addx4 dst, as, at, tmp
+#if XCHAL_HAVE_ADDX
+	addx4	\dst, \as, \at
+#else
+	slli	\tmp, \as, 2
+	add	\dst, \tmp, \at
+#endif
+	.endm
+
+	.macro	do_addx8 dst, as, at, tmp
+#if XCHAL_HAVE_ADDX
+	addx8	\dst, \as, \at
+#else
+	slli	\tmp, \as, 3
+	add	\dst, \tmp, \at
+#endif
+	.endm
+
+ENTRY(__mulsi3)
+
+	abi_entry_default
+
+#if XCHAL_HAVE_MUL32
+	mull	a2, a2, a3
+
+#elif XCHAL_HAVE_MUL16
+	or	a4, a2, a3
+	srai	a4, a4, 16
+	bnez	a4, .LMUL16
+	mul16u	a2, a2, a3
+	abi_ret_default
+.LMUL16:
+	srai	a4, a2, 16
+	srai	a5, a3, 16
+	mul16u	a7, a4, a3
+	mul16u	a6, a5, a2
+	mul16u	a4, a2, a3
+	add	a7, a7, a6
+	slli	a7, a7, 16
+	add	a2, a7, a4
+
+#elif XCHAL_HAVE_MAC16
+	mul.aa.hl a2, a3
+	mula.aa.lh a2, a3
+	rsr	a5, ACCLO
+	umul.aa.ll a2, a3
+	rsr	a4, ACCLO
+	slli	a5, a5, 16
+	add	a2, a4, a5
+
+#else /* !MUL32 && !MUL16 && !MAC16 */
+
+	/* Multiply one bit at a time, but unroll the loop 4x to better
+	   exploit the addx instructions and avoid overhead.
+	   Peel the first iteration to save a cycle on init.  */
+
+	/* Avoid negative numbers.  */
+	xor	a5, a2, a3	/* Top bit is 1 if one input is negative.  */
+	do_abs	a3, a3, a6
+	do_abs	a2, a2, a6
+
+	/* Swap so the second argument is smaller.  */
+	sub	a7, a2, a3
+	mov	a4, a3
+	movgez	a4, a2, a7	/* a4 = max (a2, a3) */
+	movltz	a3, a2, a7	/* a3 = min (a2, a3) */
+
+	movi	a2, 0
+	extui	a6, a3, 0, 1
+	movnez	a2, a4, a6
+
+	do_addx2 a7, a4, a2, a7
+	extui	a6, a3, 1, 1
+	movnez	a2, a7, a6
+
+	do_addx4 a7, a4, a2, a7
+	extui	a6, a3, 2, 1
+	movnez	a2, a7, a6
+
+	do_addx8 a7, a4, a2, a7
+	extui	a6, a3, 3, 1
+	movnez	a2, a7, a6
+
+	bgeui	a3, 16, .Lmult_main_loop
+	neg	a3, a2
+	movltz	a2, a3, a5
+	abi_ret_default
+
+	.align	4
+.Lmult_main_loop:
+	srli	a3, a3, 4
+	slli	a4, a4, 4
+
+	add	a7, a4, a2
+	extui	a6, a3, 0, 1
+	movnez	a2, a7, a6
+
+	do_addx2 a7, a4, a2, a7
+	extui	a6, a3, 1, 1
+	movnez	a2, a7, a6
+
+	do_addx4 a7, a4, a2, a7
+	extui	a6, a3, 2, 1
+	movnez	a2, a7, a6
+
+	do_addx8 a7, a4, a2, a7
+	extui	a6, a3, 3, 1
+	movnez	a2, a7, a6
+
+	bgeui	a3, 16, .Lmult_main_loop
+
+	neg	a3, a2
+	movltz	a2, a3, a5
+
+#endif /* !MUL32 && !MUL16 && !MAC16 */
+
+	abi_ret_default
+
+ENDPROC(__mulsi3)
diff --git a/arch/xtensa/lib/udivsi3.S b/arch/xtensa/lib/udivsi3.S
new file mode 100644
index 000000000000..d2477e0786cf
--- /dev/null
+++ b/arch/xtensa/lib/udivsi3.S
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0 */
+#include <linux/linkage.h>
+#include <asm/asmmacro.h>
+#include <asm/core.h>
+
+ENTRY(__udivsi3)
+
+	abi_entry_default
+#if XCHAL_HAVE_DIV32
+	quou	a2, a2, a3
+#else
+	bltui	a3, 2, .Lle_one	/* check if the divisor <= 1 */
+
+	mov	a6, a2		/* keep dividend in a6 */
+	do_nsau	a5, a6, a2, a7	/* dividend_shift = nsau (dividend) */
+	do_nsau	a4, a3, a2, a7	/* divisor_shift = nsau (divisor) */
+	bgeu	a5, a4, .Lspecial
+
+	sub	a4, a4, a5	/* count = divisor_shift - dividend_shift */
+	ssl	a4
+	sll	a3, a3		/* divisor <<= count */
+	movi	a2, 0		/* quotient = 0 */
+
+	/* test-subtract-and-shift loop; one quotient bit on each iteration */
+#if XCHAL_HAVE_LOOPS
+	loopnez	a4, .Lloopend
+#endif /* XCHAL_HAVE_LOOPS */
+.Lloop:
+	bltu	a6, a3, .Lzerobit
+	sub	a6, a6, a3
+	addi	a2, a2, 1
+.Lzerobit:
+	slli	a2, a2, 1
+	srli	a3, a3, 1
+#if !XCHAL_HAVE_LOOPS
+	addi	a4, a4, -1
+	bnez	a4, .Lloop
+#endif /* !XCHAL_HAVE_LOOPS */
+.Lloopend:
+
+	bltu	a6, a3, .Lreturn
+	addi	a2, a2, 1	/* increment quotient if dividend >= divisor */
+.Lreturn:
+	abi_ret_default
+
+.Lle_one:
+	beqz	a3, .Lerror	/* if divisor == 1, return the dividend */
+	abi_ret_default
+
+.Lspecial:
+	/* return dividend >= divisor */
+	bltu	a6, a3, .Lreturn0
+	movi	a2, 1
+	abi_ret_default
+
+.Lerror:
+	/* Divide by zero: Use an illegal instruction to force an exception.
+	   The subsequent "DIV0" string can be recognized by the exception
+	   handler to identify the real cause of the exception.  */
+	ill
+	.ascii	"DIV0"
+
+.Lreturn0:
+	movi	a2, 0
+#endif /* XCHAL_HAVE_DIV32 */
+	abi_ret_default
+
+ENDPROC(__udivsi3)
diff --git a/arch/xtensa/lib/umodsi3.S b/arch/xtensa/lib/umodsi3.S
new file mode 100644
index 000000000000..5f031bfa0354
--- /dev/null
+++ b/arch/xtensa/lib/umodsi3.S
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0 */
+#include <linux/linkage.h>
+#include <asm/asmmacro.h>
+#include <asm/core.h>
+
+ENTRY(__umodsi3)
+
+	abi_entry_default
+#if XCHAL_HAVE_DIV32
+	remu	a2, a2, a3
+#else
+	bltui	a3, 2, .Lle_one	/* check if the divisor is <= 1 */
+
+	do_nsau	a5, a2, a6, a7	/* dividend_shift = nsau (dividend) */
+	do_nsau	a4, a3, a6, a7	/* divisor_shift = nsau (divisor) */
+	bgeu	a5, a4, .Lspecial
+
+	sub	a4, a4, a5	/* count = divisor_shift - dividend_shift */
+	ssl	a4
+	sll	a3, a3		/* divisor <<= count */
+
+	/* test-subtract-and-shift loop */
+#if XCHAL_HAVE_LOOPS
+	loopnez	a4, .Lloopend
+#endif /* XCHAL_HAVE_LOOPS */
+.Lloop:
+	bltu	a2, a3, .Lzerobit
+	sub	a2, a2, a3
+.Lzerobit:
+	srli	a3, a3, 1
+#if !XCHAL_HAVE_LOOPS
+	addi	a4, a4, -1
+	bnez	a4, .Lloop
+#endif /* !XCHAL_HAVE_LOOPS */
+.Lloopend:
+
+.Lspecial:
+	bltu	a2, a3, .Lreturn
+	sub	a2, a2, a3	/* subtract once more if dividend >= divisor */
+.Lreturn:
+	abi_ret_default
+
+.Lle_one:
+	bnez	a3, .Lreturn0
+
+	/* Divide by zero: Use an illegal instruction to force an exception.
+	   The subsequent "DIV0" string can be recognized by the exception
+	   handler to identify the real cause of the exception.  */
+	ill
+	.ascii	"DIV0"
+
+.Lreturn0:
+	movi	a2, 0
+#endif /* XCHAL_HAVE_DIV32 */
+	abi_ret_default
+
+ENDPROC(__umodsi3)
-- 
2.30.2

