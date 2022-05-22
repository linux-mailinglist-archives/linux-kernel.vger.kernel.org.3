Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368B75305F1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 22:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351223AbiEVUsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 16:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343506AbiEVUsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 16:48:19 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E63F22A268;
        Sun, 22 May 2022 13:48:17 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id ACFBB92009C; Sun, 22 May 2022 22:48:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id A5EEE92009B;
        Sun, 22 May 2022 21:48:14 +0100 (BST)
Date:   Sun, 22 May 2022 21:48:14 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Paul Cercueil <paul@crapouillou.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Rewrite `csum_tcpudp_nofold' in plain C
Message-ID: <alpine.DEB.2.21.2205222035380.52080@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent commit 198688edbf77 ("MIPS: Fix inline asm input/output type 
mismatch in checksum.h used with Clang") introduced a code size and 
performance regression with 64-bit code emitted for `csum_tcpudp_nofold' 
by GCC, caused by a redundant truncation operation produced due to a 
data type change made to the variable associated with the inline 
assembly's output operand.

The intent previously expressed here with operands and constraints for 
optimal code was to have the output operand share a register with one 
inputs, both of a different integer type each.  This is perfectly valid 
with the MIPS psABI where a register can hold integer data of different 
types and the assembly code used here makes data stored in the output 
register match the data type used with the output operand, however it 
has turned out impossible to express this arrangement in source code 
such as to satisfy LLVM, apparently due to the compiler's internal 
limitations.

There is nothing peculiar about the inline assembly `csum_tcpudp_nofold' 
includes however, though it does choose assembly instructions carefully.

Rewrite this piece of assembly in plain C then, using corresponding C 
language operations, making GCC produce the same assembly instructions, 
possibly shuffled, in the general case and sometimes actually fewer of 
them where an input is constant, because the compiler does not have to 
reload it to a register (operand constraints could be adjusted for that, 
but the plain C approach is cleaner anyway).

Example code size changes are as follows, for a 32-bit configuration:

      text       data        bss      total filename
   5920480    1347236     126592    7394308 vmlinux-old
   5920480    1347236     126592    7394308 vmlinux-now
   5919728    1347236     126592    7393556 vmlinux-c

and for a 64-bit configuration:

      text       data        bss      total filename
   6024112    1790828     225728    8040668 vmlinux-old
   6024128    1790828     225728    8040684 vmlinux-now
   6023760    1790828     225728    8040316 vmlinux-c

respectively, where "old" is with the commit referred reverted, "now" is 
with no change, and "c" is with this change applied.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
Hi,

 I have visually inspected code produced and verified this change to boot 
with TCP networking performing just fine, both with a 32-bit and a 64-bit 
configuration.  Sadly with the little endianness only, because in the 
course of this verification I have discovered the core card of my Malta 
board bit the dust a few days ago, apparently in a permanent manner, and I 
have no other big-endian MIPS system available here to try.

 The only difference between the two endiannesses is the left-shift 
operation on (proto + len) however, which doesn't happen for big-endian 
configurations, so the little endianness should in principle provide 
enough coverage.

 Also I'm leaving it to LLVM folks to verify, however this is plain C, so 
it is expected to just work.

 Please apply.

  Maciej
---
 arch/mips/include/asm/checksum.h |   71 ++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 37 deletions(-)

linux-mips-csum-tcpudp-nofold-proper-fix.diff
Index: linux-macro/arch/mips/include/asm/checksum.h
===================================================================
--- linux-macro.orig/arch/mips/include/asm/checksum.h
+++ linux-macro/arch/mips/include/asm/checksum.h
@@ -128,48 +128,45 @@ static inline __sum16 ip_fast_csum(const
 
 static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 					__u32 len, __u8 proto,
-					__wsum sum)
+					__wsum isum)
 {
-	unsigned long tmp = (__force unsigned long)sum;
+	const unsigned int sh32 = IS_ENABLED(CONFIG_64BIT) ? 32 : 0;
+	unsigned long sum = (__force unsigned long)daddr;
+	unsigned long tmp;
+	__u32 osum;
 
-	__asm__(
-	"	.set	push		# csum_tcpudp_nofold\n"
-	"	.set	noat		\n"
-#ifdef CONFIG_32BIT
-	"	addu	%0, %2		\n"
-	"	sltu	$1, %0, %2	\n"
-	"	addu	%0, $1		\n"
+	tmp = (__force unsigned long)saddr;
+	sum += tmp;
 
-	"	addu	%0, %3		\n"
-	"	sltu	$1, %0, %3	\n"
-	"	addu	%0, $1		\n"
+	if (IS_ENABLED(CONFIG_32BIT))
+		sum += sum < tmp;
 
-	"	addu	%0, %4		\n"
-	"	sltu	$1, %0, %4	\n"
-	"	addu	%0, $1		\n"
-#endif
-#ifdef CONFIG_64BIT
-	"	daddu	%0, %2		\n"
-	"	daddu	%0, %3		\n"
-	"	daddu	%0, %4		\n"
-	"	dsll32	$1, %0, 0	\n"
-	"	daddu	%0, $1		\n"
-	"	sltu	$1, %0, $1	\n"
-	"	dsra32	%0, %0, 0	\n"
-	"	addu	%0, $1		\n"
-#endif
-	"	.set	pop"
-	: "=r" (tmp)
-	: "0" ((__force unsigned long)daddr),
-	  "r" ((__force unsigned long)saddr),
-#ifdef __MIPSEL__
-	  "r" ((proto + len) << 8),
-#else
-	  "r" (proto + len),
-#endif
-	  "r" ((__force unsigned long)sum));
+	/*
+	 * We know PROTO + LEN has the sign bit clear, so cast to a signed
+	 * type to avoid an extraneous zero-extension where TMP is 64-bit.
+	 */
+	tmp = (__s32)(proto + len);
+	tmp <<= IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? 8 : 0;
+	sum += tmp;
+	if (IS_ENABLED(CONFIG_32BIT))
+		sum += sum < tmp;
 
-	return (__force __wsum)tmp;
+	tmp = (__force unsigned long)isum;
+	sum += tmp;
+
+	if (IS_ENABLED(CONFIG_32BIT)) {
+		sum += sum < tmp;
+		osum = sum;
+	} else if (IS_ENABLED(CONFIG_64BIT)) {
+		tmp = sum << sh32;
+		sum += tmp;
+		osum = sum < tmp;
+		osum += sum >> sh32;
+	} else {
+		BUILD_BUG();
+	}
+
+	return (__force __wsum)osum;
 }
 #define csum_tcpudp_nofold csum_tcpudp_nofold
 
