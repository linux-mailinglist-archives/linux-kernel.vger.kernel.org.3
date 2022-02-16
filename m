Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F345E4B8DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiBPQXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:23:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbiBPQW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:22:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 129B31FE52C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:22:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D45071477;
        Wed, 16 Feb 2022 08:22:43 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D8D493F70D;
        Wed, 16 Feb 2022 08:22:41 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        joey.gouly@arm.com, jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org
Subject: [PATCH v4 2/4] arm64: clean up symbol aliasing
Date:   Wed, 16 Feb 2022 16:22:27 +0000
Message-Id: <20220216162229.1076788-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220216162229.1076788-1-mark.rutland@arm.com>
References: <20220216162229.1076788-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have SYM_FUNC_ALIAS() and SYM_FUNC_ALIAS_WEAK(), use those
to simplify and more consistently define function aliases across
arch/arm64.

Aliases are now defined in terms of a canonical function name. For
position-independent functions I've made the __pi_<func> name the
canonical name, and defined other alises in terms of this.

The SYM_FUNC_{START,END}_PI(func) macros obscure the __pi_<func> name,
and make this hard to seatch for. The SYM_FUNC_START_WEAK_PI() macro
also obscures the fact that the __pi_<func> fymbol is global and the
<func> symbol is weak. For clarity, I have removed these macros and used
SYM_FUNC_{START,END}() directly with the __pi_<func> name.

For example:

	SYM_FUNC_START_WEAK_PI(func)
	... asm insns ...
	SYM_FUNC_END_PI(func)
	EXPORT_SYMBOL(func)

... becomes:

	SYM_FUNC_START(__pi_func)
	... asm insns ...
	SYM_FUNC_END(__pi_func)

	SYM_FUNC_ALIAS_WEAK(func, __pi_func)
	EXPORT_SYMBOL(func)

For clarity, where there are multiple annotations such as
EXPORT_SYMBOL(), I've tried to keep annotations grouped by symbol. For
example, where a function has a name and an alias which are both
exported, this is organised as:

	SYM_FUNC_START(func)
	... asm insns ...
	SYM_FUNC_END(func)
	EXPORT_SYMBOL(func)

	SYM_FUNC_ALIAS(alias, func)
	EXPORT_SYMBOL(alias)

For consistency with the other string functions, I've defined strrchr as
a position-independent function, as it can safely be used as such even
though we have no users today.

As we no longer use SYM_FUNC_{START,END}_ALIAS(), our local copies are
removed. The common versions will be removed by a subsequent patch.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Mark Brown <broonie@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/linkage.h | 24 ----------------------
 arch/arm64/kvm/hyp/nvhe/cache.S  |  5 +++--
 arch/arm64/lib/clear_page.S      |  5 +++--
 arch/arm64/lib/copy_page.S       |  5 +++--
 arch/arm64/lib/memchr.S          |  5 +++--
 arch/arm64/lib/memcmp.S          |  6 +++---
 arch/arm64/lib/memcpy.S          | 21 ++++++++++---------
 arch/arm64/lib/memset.S          | 12 ++++++-----
 arch/arm64/lib/strchr.S          |  6 ++++--
 arch/arm64/lib/strcmp.S          |  6 +++---
 arch/arm64/lib/strlen.S          |  6 +++---
 arch/arm64/lib/strncmp.S         |  6 +++---
 arch/arm64/lib/strnlen.S         |  6 ++++--
 arch/arm64/lib/strrchr.S         |  5 +++--
 arch/arm64/mm/cache.S            | 35 +++++++++++++++++++-------------
 15 files changed, 74 insertions(+), 79 deletions(-)

diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
index b77e9b3f5371..43f8c25b3fda 100644
--- a/arch/arm64/include/asm/linkage.h
+++ b/arch/arm64/include/asm/linkage.h
@@ -39,28 +39,4 @@
 	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
 	bti c ;
 
-/*
- * Annotate a function as position independent, i.e., safe to be called before
- * the kernel virtual mapping is activated.
- */
-#define SYM_FUNC_START_PI(x)			\
-		SYM_FUNC_START_ALIAS(__pi_##x);	\
-		SYM_FUNC_START(x)
-
-#define SYM_FUNC_START_WEAK_PI(x)		\
-		SYM_FUNC_START_ALIAS(__pi_##x);	\
-		SYM_FUNC_START_WEAK(x)
-
-#define SYM_FUNC_START_WEAK_ALIAS_PI(x)		\
-		SYM_FUNC_START_ALIAS(__pi_##x);	\
-		SYM_START(x, SYM_L_WEAK, SYM_A_ALIGN)
-
-#define SYM_FUNC_END_PI(x)			\
-		SYM_FUNC_END(x);		\
-		SYM_FUNC_END_ALIAS(__pi_##x)
-
-#define SYM_FUNC_END_ALIAS_PI(x)		\
-		SYM_FUNC_END_ALIAS(x);		\
-		SYM_FUNC_END_ALIAS(__pi_##x)
-
 #endif
diff --git a/arch/arm64/kvm/hyp/nvhe/cache.S b/arch/arm64/kvm/hyp/nvhe/cache.S
index 958734f4d6b0..0c367eb5f4e2 100644
--- a/arch/arm64/kvm/hyp/nvhe/cache.S
+++ b/arch/arm64/kvm/hyp/nvhe/cache.S
@@ -7,7 +7,8 @@
 #include <asm/assembler.h>
 #include <asm/alternative.h>
 
-SYM_FUNC_START_PI(dcache_clean_inval_poc)
+SYM_FUNC_START(__pi_dcache_clean_inval_poc)
 	dcache_by_line_op civac, sy, x0, x1, x2, x3
 	ret
-SYM_FUNC_END_PI(dcache_clean_inval_poc)
+SYM_FUNC_END(__pi_dcache_clean_inval_poc)
+SYM_FUNC_ALIAS(dcache_clean_inval_poc, __pi_dcache_clean_inval_poc)
diff --git a/arch/arm64/lib/clear_page.S b/arch/arm64/lib/clear_page.S
index 1fd5d790ab80..ebde40e7fa2b 100644
--- a/arch/arm64/lib/clear_page.S
+++ b/arch/arm64/lib/clear_page.S
@@ -14,7 +14,7 @@
  * Parameters:
  *	x0 - dest
  */
-SYM_FUNC_START_PI(clear_page)
+SYM_FUNC_START(__pi_clear_page)
 	mrs	x1, dczid_el0
 	tbnz	x1, #4, 2f	/* Branch if DC ZVA is prohibited */
 	and	w1, w1, #0xf
@@ -35,5 +35,6 @@ SYM_FUNC_START_PI(clear_page)
 	tst	x0, #(PAGE_SIZE - 1)
 	b.ne	2b
 	ret
-SYM_FUNC_END_PI(clear_page)
+SYM_FUNC_END(__pi_clear_page)
+SYM_FUNC_ALIAS(clear_page, __pi_clear_page)
 EXPORT_SYMBOL(clear_page)
diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
index 29144f4cd449..c336d2ffdec5 100644
--- a/arch/arm64/lib/copy_page.S
+++ b/arch/arm64/lib/copy_page.S
@@ -17,7 +17,7 @@
  *	x0 - dest
  *	x1 - src
  */
-SYM_FUNC_START_PI(copy_page)
+SYM_FUNC_START(__pi_copy_page)
 alternative_if ARM64_HAS_NO_HW_PREFETCH
 	// Prefetch three cache lines ahead.
 	prfm	pldl1strm, [x1, #128]
@@ -75,5 +75,6 @@ alternative_else_nop_endif
 	stnp	x16, x17, [x0, #112 - 256]
 
 	ret
-SYM_FUNC_END_PI(copy_page)
+SYM_FUNC_END(__pi_copy_page)
+SYM_FUNC_ALIAS(copy_page, __pi_copy_page)
 EXPORT_SYMBOL(copy_page)
diff --git a/arch/arm64/lib/memchr.S b/arch/arm64/lib/memchr.S
index 7c2276fdab54..37a9f2a4f7f4 100644
--- a/arch/arm64/lib/memchr.S
+++ b/arch/arm64/lib/memchr.S
@@ -38,7 +38,7 @@
 
 	.p2align 4
 	nop
-SYM_FUNC_START_WEAK_PI(memchr)
+SYM_FUNC_START(__pi_memchr)
 	and	chrin, chrin, #0xff
 	lsr	wordcnt, cntin, #3
 	cbz	wordcnt, L(byte_loop)
@@ -71,5 +71,6 @@ CPU_LE(	rev	tmp, tmp)
 L(not_found):
 	mov	result, #0
 	ret
-SYM_FUNC_END_PI(memchr)
+SYM_FUNC_END(__pi_memchr)
+SYM_FUNC_ALIAS_WEAK(memchr, __pi_memchr)
 EXPORT_SYMBOL_NOKASAN(memchr)
diff --git a/arch/arm64/lib/memcmp.S b/arch/arm64/lib/memcmp.S
index 7d956384222f..a5ccf2c55f91 100644
--- a/arch/arm64/lib/memcmp.S
+++ b/arch/arm64/lib/memcmp.S
@@ -32,7 +32,7 @@
 #define tmp1		x7
 #define tmp2		x8
 
-SYM_FUNC_START_WEAK_PI(memcmp)
+SYM_FUNC_START(__pi_memcmp)
 	subs	limit, limit, 8
 	b.lo	L(less8)
 
@@ -134,6 +134,6 @@ L(byte_loop):
 	b.eq	L(byte_loop)
 	sub	result, data1w, data2w
 	ret
-
-SYM_FUNC_END_PI(memcmp)
+SYM_FUNC_END(__pi_memcmp)
+SYM_FUNC_ALIAS_WEAK(memcmp, __pi_memcmp)
 EXPORT_SYMBOL_NOKASAN(memcmp)
diff --git a/arch/arm64/lib/memcpy.S b/arch/arm64/lib/memcpy.S
index b82fd64ee1e1..4ab48d49c451 100644
--- a/arch/arm64/lib/memcpy.S
+++ b/arch/arm64/lib/memcpy.S
@@ -57,10 +57,7 @@
    The loop tail is handled by always copying 64 bytes from the end.
 */
 
-SYM_FUNC_START_ALIAS(__memmove)
-SYM_FUNC_START_WEAK_ALIAS_PI(memmove)
-SYM_FUNC_START_ALIAS(__memcpy)
-SYM_FUNC_START_WEAK_PI(memcpy)
+SYM_FUNC_START(__pi_memcpy)
 	add	srcend, src, count
 	add	dstend, dstin, count
 	cmp	count, 128
@@ -241,12 +238,16 @@ L(copy64_from_start):
 	stp	B_l, B_h, [dstin, 16]
 	stp	C_l, C_h, [dstin]
 	ret
+SYM_FUNC_END(__pi_memcpy)
 
-SYM_FUNC_END_PI(memcpy)
-EXPORT_SYMBOL(memcpy)
-SYM_FUNC_END_ALIAS(__memcpy)
+SYM_FUNC_ALIAS(__memcpy, __pi_memcpy)
 EXPORT_SYMBOL(__memcpy)
-SYM_FUNC_END_ALIAS_PI(memmove)
-EXPORT_SYMBOL(memmove)
-SYM_FUNC_END_ALIAS(__memmove)
+SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
+EXPORT_SYMBOL(memcpy)
+
+SYM_FUNC_ALIAS(__pi_memmove, __pi_memcpy)
+
+SYM_FUNC_ALIAS(__memmove, __pi_memmove)
 EXPORT_SYMBOL(__memmove)
+SYM_FUNC_ALIAS_WEAK(memmove, __memmove)
+EXPORT_SYMBOL(memmove)
diff --git a/arch/arm64/lib/memset.S b/arch/arm64/lib/memset.S
index a9c1c9a01ea9..a5aebe82ad73 100644
--- a/arch/arm64/lib/memset.S
+++ b/arch/arm64/lib/memset.S
@@ -42,8 +42,7 @@ dst		.req	x8
 tmp3w		.req	w9
 tmp3		.req	x9
 
-SYM_FUNC_START_ALIAS(__memset)
-SYM_FUNC_START_WEAK_PI(memset)
+SYM_FUNC_START(__pi_memset)
 	mov	dst, dstin	/* Preserve return value.  */
 	and	A_lw, val, #255
 	orr	A_lw, A_lw, A_lw, lsl #8
@@ -202,7 +201,10 @@ SYM_FUNC_START_WEAK_PI(memset)
 	ands	count, count, zva_bits_x
 	b.ne	.Ltail_maybe_long
 	ret
-SYM_FUNC_END_PI(memset)
-EXPORT_SYMBOL(memset)
-SYM_FUNC_END_ALIAS(__memset)
+SYM_FUNC_END(__pi_memset)
+
+SYM_FUNC_ALIAS(__memset, __pi_memset)
 EXPORT_SYMBOL(__memset)
+
+SYM_FUNC_ALIAS_WEAK(memset, __pi_memset)
+EXPORT_SYMBOL(memset)
diff --git a/arch/arm64/lib/strchr.S b/arch/arm64/lib/strchr.S
index 1f47eae3b0d6..94ee67a6b212 100644
--- a/arch/arm64/lib/strchr.S
+++ b/arch/arm64/lib/strchr.S
@@ -18,7 +18,7 @@
  * Returns:
  *	x0 - address of first occurrence of 'c' or 0
  */
-SYM_FUNC_START_WEAK(strchr)
+SYM_FUNC_START(__pi_strchr)
 	and	w1, w1, #0xff
 1:	ldrb	w2, [x0], #1
 	cmp	w2, w1
@@ -28,5 +28,7 @@ SYM_FUNC_START_WEAK(strchr)
 	cmp	w2, w1
 	csel	x0, x0, xzr, eq
 	ret
-SYM_FUNC_END(strchr)
+SYM_FUNC_END(__pi_strchr)
+
+SYM_FUNC_ALIAS_WEAK(strchr, __pi_strchr)
 EXPORT_SYMBOL_NOKASAN(strchr)
diff --git a/arch/arm64/lib/strcmp.S b/arch/arm64/lib/strcmp.S
index 83bcad72ec97..cda7de747efc 100644
--- a/arch/arm64/lib/strcmp.S
+++ b/arch/arm64/lib/strcmp.S
@@ -41,7 +41,7 @@
 
 	/* Start of performance-critical section  -- one 64B cache line.  */
 	.align 6
-SYM_FUNC_START_WEAK_PI(strcmp)
+SYM_FUNC_START(__pi_strcmp)
 	eor	tmp1, src1, src2
 	mov	zeroones, #REP8_01
 	tst	tmp1, #7
@@ -171,6 +171,6 @@ L(loop_misaligned):
 L(done):
 	sub	result, data1, data2
 	ret
-
-SYM_FUNC_END_PI(strcmp)
+SYM_FUNC_END(__pi_strcmp)
+SYM_FUNC_ALIAS_WEAK(strcmp, __pi_strcmp)
 EXPORT_SYMBOL_NOHWKASAN(strcmp)
diff --git a/arch/arm64/lib/strlen.S b/arch/arm64/lib/strlen.S
index 1648790e91b3..4919fe81ae54 100644
--- a/arch/arm64/lib/strlen.S
+++ b/arch/arm64/lib/strlen.S
@@ -79,7 +79,7 @@
 	   whether the first fetch, which may be misaligned, crosses a page
 	   boundary.  */
 
-SYM_FUNC_START_WEAK_PI(strlen)
+SYM_FUNC_START(__pi_strlen)
 	and	tmp1, srcin, MIN_PAGE_SIZE - 1
 	mov	zeroones, REP8_01
 	cmp	tmp1, MIN_PAGE_SIZE - 16
@@ -208,6 +208,6 @@ L(page_cross):
 	csel	data1, data1, tmp4, eq
 	csel	data2, data2, tmp2, eq
 	b	L(page_cross_entry)
-
-SYM_FUNC_END_PI(strlen)
+SYM_FUNC_END(__pi_strlen)
+SYM_FUNC_ALIAS_WEAK(strlen, __pi_strlen)
 EXPORT_SYMBOL_NOKASAN(strlen)
diff --git a/arch/arm64/lib/strncmp.S b/arch/arm64/lib/strncmp.S
index e42bcfcd37e6..a848abcec975 100644
--- a/arch/arm64/lib/strncmp.S
+++ b/arch/arm64/lib/strncmp.S
@@ -44,7 +44,7 @@
 #define endloop		x15
 #define count		mask
 
-SYM_FUNC_START_WEAK_PI(strncmp)
+SYM_FUNC_START(__pi_strncmp)
 	cbz	limit, L(ret0)
 	eor	tmp1, src1, src2
 	mov	zeroones, #REP8_01
@@ -256,6 +256,6 @@ L(done_loop):
 L(ret0):
 	mov	result, #0
 	ret
-
-SYM_FUNC_END_PI(strncmp)
+SYM_FUNC_END(__pi_strncmp)
+SYM_FUNC_ALIAS_WEAK(strncmp, __pi_strncmp)
 EXPORT_SYMBOL_NOHWKASAN(strncmp)
diff --git a/arch/arm64/lib/strnlen.S b/arch/arm64/lib/strnlen.S
index b72913a99038..d5ac0e10a01d 100644
--- a/arch/arm64/lib/strnlen.S
+++ b/arch/arm64/lib/strnlen.S
@@ -47,7 +47,7 @@ limit_wd	.req	x14
 #define REP8_7f 0x7f7f7f7f7f7f7f7f
 #define REP8_80 0x8080808080808080
 
-SYM_FUNC_START_WEAK_PI(strnlen)
+SYM_FUNC_START(__pi_strnlen)
 	cbz	limit, .Lhit_limit
 	mov	zeroones, #REP8_01
 	bic	src, srcin, #15
@@ -156,5 +156,7 @@ CPU_LE( lsr	tmp2, tmp2, tmp4 )	/* Shift (tmp1 & 63).  */
 .Lhit_limit:
 	mov	len, limit
 	ret
-SYM_FUNC_END_PI(strnlen)
+SYM_FUNC_END(__pi_strnlen)
+
+SYM_FUNC_ALIAS_WEAK(strnlen, __pi_strnlen)
 EXPORT_SYMBOL_NOKASAN(strnlen)
diff --git a/arch/arm64/lib/strrchr.S b/arch/arm64/lib/strrchr.S
index 13132d1ed6d1..a5123cf0ce12 100644
--- a/arch/arm64/lib/strrchr.S
+++ b/arch/arm64/lib/strrchr.S
@@ -18,7 +18,7 @@
  * Returns:
  *	x0 - address of last occurrence of 'c' or 0
  */
-SYM_FUNC_START_WEAK_PI(strrchr)
+SYM_FUNC_START(__pi_strrchr)
 	mov	x3, #0
 	and	w1, w1, #0xff
 1:	ldrb	w2, [x0], #1
@@ -29,5 +29,6 @@ SYM_FUNC_START_WEAK_PI(strrchr)
 	b	1b
 2:	mov	x0, x3
 	ret
-SYM_FUNC_END_PI(strrchr)
+SYM_FUNC_END(__pi_strrchr)
+SYM_FUNC_ALIAS_WEAK(strrchr, __pi_strrchr)
 EXPORT_SYMBOL_NOKASAN(strrchr)
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 7d0563db4201..0ea6cc25dc66 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -107,10 +107,11 @@ SYM_FUNC_END(icache_inval_pou)
  *	- start   - virtual start address of region
  *	- end     - virtual end address of region
  */
-SYM_FUNC_START_PI(dcache_clean_inval_poc)
+SYM_FUNC_START(__pi_dcache_clean_inval_poc)
 	dcache_by_line_op civac, sy, x0, x1, x2, x3
 	ret
-SYM_FUNC_END_PI(dcache_clean_inval_poc)
+SYM_FUNC_END(__pi_dcache_clean_inval_poc)
+SYM_FUNC_ALIAS(dcache_clean_inval_poc, __pi_dcache_clean_inval_poc)
 
 /*
  *	dcache_clean_pou(start, end)
@@ -140,7 +141,7 @@ SYM_FUNC_END(dcache_clean_pou)
  *	- start   - kernel start address of region
  *	- end     - kernel end address of region
  */
-SYM_FUNC_START_PI(dcache_inval_poc)
+SYM_FUNC_START(__pi_dcache_inval_poc)
 	dcache_line_size x2, x3
 	sub	x3, x2, #1
 	tst	x1, x3				// end cache line aligned?
@@ -158,7 +159,8 @@ SYM_FUNC_START_PI(dcache_inval_poc)
 	b.lo	2b
 	dsb	sy
 	ret
-SYM_FUNC_END_PI(dcache_inval_poc)
+SYM_FUNC_END(__pi_dcache_inval_poc)
+SYM_FUNC_ALIAS(dcache_inval_poc, __pi_dcache_inval_poc)
 
 /*
  *	dcache_clean_poc(start, end)
@@ -169,10 +171,11 @@ SYM_FUNC_END_PI(dcache_inval_poc)
  *	- start   - virtual start address of region
  *	- end     - virtual end address of region
  */
-SYM_FUNC_START_PI(dcache_clean_poc)
+SYM_FUNC_START(__pi_dcache_clean_poc)
 	dcache_by_line_op cvac, sy, x0, x1, x2, x3
 	ret
-SYM_FUNC_END_PI(dcache_clean_poc)
+SYM_FUNC_END(__pi_dcache_clean_poc)
+SYM_FUNC_ALIAS(dcache_clean_poc, __pi_dcache_clean_poc)
 
 /*
  *	dcache_clean_pop(start, end)
@@ -183,13 +186,14 @@ SYM_FUNC_END_PI(dcache_clean_poc)
  *	- start   - virtual start address of region
  *	- end     - virtual end address of region
  */
-SYM_FUNC_START_PI(dcache_clean_pop)
+SYM_FUNC_START(__pi_dcache_clean_pop)
 	alternative_if_not ARM64_HAS_DCPOP
 	b	dcache_clean_poc
 	alternative_else_nop_endif
 	dcache_by_line_op cvap, sy, x0, x1, x2, x3
 	ret
-SYM_FUNC_END_PI(dcache_clean_pop)
+SYM_FUNC_END(__pi_dcache_clean_pop)
+SYM_FUNC_ALIAS(dcache_clean_pop, __pi_dcache_clean_pop)
 
 /*
  *	__dma_flush_area(start, size)
@@ -199,11 +203,12 @@ SYM_FUNC_END_PI(dcache_clean_pop)
  *	- start   - virtual start address of region
  *	- size    - size in question
  */
-SYM_FUNC_START_PI(__dma_flush_area)
+SYM_FUNC_START(__pi___dma_flush_area)
 	add	x1, x0, x1
 	dcache_by_line_op civac, sy, x0, x1, x2, x3
 	ret
-SYM_FUNC_END_PI(__dma_flush_area)
+SYM_FUNC_END(__pi___dma_flush_area)
+SYM_FUNC_ALIAS(__dma_flush_area, __pi___dma_flush_area)
 
 /*
  *	__dma_map_area(start, size, dir)
@@ -211,12 +216,13 @@ SYM_FUNC_END_PI(__dma_flush_area)
  *	- size	- size of region
  *	- dir	- DMA direction
  */
-SYM_FUNC_START_PI(__dma_map_area)
+SYM_FUNC_START(__pi___dma_map_area)
 	add	x1, x0, x1
 	cmp	w2, #DMA_FROM_DEVICE
 	b.eq	__pi_dcache_inval_poc
 	b	__pi_dcache_clean_poc
-SYM_FUNC_END_PI(__dma_map_area)
+SYM_FUNC_END(__pi___dma_map_area)
+SYM_FUNC_ALIAS(__dma_map_area, __pi___dma_map_area)
 
 /*
  *	__dma_unmap_area(start, size, dir)
@@ -224,9 +230,10 @@ SYM_FUNC_END_PI(__dma_map_area)
  *	- size	- size of region
  *	- dir	- DMA direction
  */
-SYM_FUNC_START_PI(__dma_unmap_area)
+SYM_FUNC_START(__pi___dma_unmap_area)
 	add	x1, x0, x1
 	cmp	w2, #DMA_TO_DEVICE
 	b.ne	__pi_dcache_inval_poc
 	ret
-SYM_FUNC_END_PI(__dma_unmap_area)
+SYM_FUNC_END(__pi___dma_unmap_area)
+SYM_FUNC_ALIAS(__dma_unmap_area, __pi___dma_unmap_area)
-- 
2.30.2

