Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5B757D505
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiGUUrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUUrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:47:15 -0400
Received: from luna (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12198F510
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 13:47:13 -0700 (PDT)
Received: from ben by luna with local (Exim 4.96)
        (envelope-from <ben@luna.fluff.org>)
        id 1oEd4h-001rp7-00;
        Thu, 21 Jul 2022 21:47:11 +0100
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] crypto: fix warnings from missing .note.GNU-stack
Date:   Thu, 21 Jul 2022 21:47:09 +0100
Message-Id: <20220721204709.445216-1-ben-linux@fluff.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of the assembly code in arch/arm/crypto is missing
a .note.GNU-stack section which is making a numbe of warnings
about implicit executable stack. This code does not look like
it does not need an executable stack, so silence the warnings
by adding a .section .note.GNU-stack to all these.

Since this is an empty section, it should be backwards compatible
with older linkers.

Fixes the following warnings:

arm-linux-gnueabihf-ld: warning: arch/arm/crypto/aes-cipher-core.o: missing .note.GNU-stack section implies executable stack
arm-linux-gnueabihf-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
arm-linux-gnueabihf-ld: warning: arch/arm/crypto/aes-neonbs-core.o: missing .note.GNU-stack section implies executable stack
arm-linux-gnueabihf-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
arm-linux-gnueabihf-ld: warning: arch/arm/crypto/sha1-armv4-large.o: missing .note.GNU-stack section implies executable stack
arm-linux-gnueabihf-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
arm-linux-gnueabihf-ld: warning: arch/arm/crypto/sha1-armv7-neon.o: missing .note.GNU-stack section implies executable stack
arm-linux-gnueabihf-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
arm-linux-gnueabihf-ld: warning: arch/arm/crypto/sha256-core.o: missing .note.GNU-stack section implies executable stack
arm-linux-gnueabihf-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
arm-linux-gnueabihf-ld: warning: arch/arm/crypto/sha512-core.o: missing .note.GNU-stack section implies executable stack
arm-linux-gnueabihf-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
arm-linux-gnueabihf-ld: warning: arch/arm/crypto/chacha-neon-core.o: missing .note.GNU-stack section implies executable stack
arm-linux-gnueabihf-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
arm-linux-gnueabihf-ld: warning: arch/arm/crypto/aes-ce-core.o: missing .note.GNU-stack section implies executable stack
arm-linux-gnueabihf-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
arm-linux-gnueabihf-ld: warning: arch/arm/crypto/sha1-ce-core.o: missing .note.GNU-stack section implies executable stack
arm-linux-gnueabihf-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
arm-linux-gnueabihf-ld: warning: arch/arm/crypto/sha2-ce-core.o: missing .note.GNU-stack section implies executable stack
arm-linux-gnueabihf-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
arm-linux-gnueabihf-ld: warning: arch/arm/crypto/ghash-ce-core.o: missing .note.GNU-stack section implies executable stack
arm-linux-gnueabihf-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
arm-linux-gnueabihf-ld: warning: arch/arm/crypto/crc32-ce-core.o: missing .note.GNU-stack section implies executable stack
arm-linux-gnueabihf-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/crypto/aes-ce-core.S        | 2 ++
 arch/arm/crypto/aes-cipher-core.S    | 2 ++
 arch/arm/crypto/aes-neonbs-core.S    | 3 +++
 arch/arm/crypto/chacha-neon-core.S   | 2 ++
 arch/arm/crypto/chacha-scalar-core.S | 2 ++
 arch/arm/crypto/crc32-ce-core.S      | 2 ++
 arch/arm/crypto/ghash-ce-core.S      | 2 ++
 arch/arm/crypto/sha1-armv4-large.S   | 1 +
 arch/arm/crypto/sha1-armv7-neon.S    | 2 ++
 arch/arm/crypto/sha1-ce-core.S       | 2 ++
 arch/arm/crypto/sha2-ce-core.S       | 2 ++
 arch/arm/crypto/sha256-armv4.pl      | 1 +
 arch/arm/crypto/sha512-armv4.pl      | 1 +
 13 files changed, 24 insertions(+)

diff --git a/arch/arm/crypto/aes-ce-core.S b/arch/arm/crypto/aes-ce-core.S
index 312428d83eed..4e570c6df9bb 100644
--- a/arch/arm/crypto/aes-ce-core.S
+++ b/arch/arm/crypto/aes-ce-core.S
@@ -711,3 +711,5 @@ ENDPROC(ce_aes_invert)
 	.byte		 0x8,  0x9,  0xa,  0xb,  0xc,  0xd,  0xe,  0xf
 	.byte		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
 	.byte		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+
+.section .note.GNU-stack,"",%progbits
diff --git a/arch/arm/crypto/aes-cipher-core.S b/arch/arm/crypto/aes-cipher-core.S
index 1da3f41359aa..11f10ee35487 100644
--- a/arch/arm/crypto/aes-cipher-core.S
+++ b/arch/arm/crypto/aes-cipher-core.S
@@ -199,3 +199,5 @@ ENDPROC(__aes_arm_encrypt)
 ENTRY(__aes_arm_decrypt)
 	do_crypt	iround, crypto_it_tab, crypto_aes_inv_sbox, 0
 ENDPROC(__aes_arm_decrypt)
+
+.section .note.GNU-stack,"",%progbits
diff --git a/arch/arm/crypto/aes-neonbs-core.S b/arch/arm/crypto/aes-neonbs-core.S
index 7b61032f29fa..19197c0d635c 100644
--- a/arch/arm/crypto/aes-neonbs-core.S
+++ b/arch/arm/crypto/aes-neonbs-core.S
@@ -1041,3 +1041,6 @@ ENTRY(aesbs_xts_decrypt)
 	ldr		ip, [sp, #8]		// reorder final tweak?
 	__xts_crypt	aesbs_decrypt8, q0, q1, q6, q4, q2, q7, q3, q5
 ENDPROC(aesbs_xts_decrypt)
+
+.section .note.GNU-stack,"",%progbits
+
diff --git a/arch/arm/crypto/chacha-neon-core.S b/arch/arm/crypto/chacha-neon-core.S
index 13d12f672656..a90690d32ad8 100644
--- a/arch/arm/crypto/chacha-neon-core.S
+++ b/arch/arm/crypto/chacha-neon-core.S
@@ -641,3 +641,5 @@ ENDPROC(chacha_4block_xor_neon)
 	.byte		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
 	.byte		0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17
 	.byte		0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f
+
+.section .note.GNU-stack,"",%progbits
diff --git a/arch/arm/crypto/chacha-scalar-core.S b/arch/arm/crypto/chacha-scalar-core.S
index 083fe1ab96d0..81f94876f418 100644
--- a/arch/arm/crypto/chacha-scalar-core.S
+++ b/arch/arm/crypto/chacha-scalar-core.S
@@ -441,3 +441,5 @@ ENTRY(hchacha_block_arm)
 1:	_chacha_permute	12
 	b		0b
 ENDPROC(hchacha_block_arm)
+
+.section .note.GNU-stack,"",%progbits
diff --git a/arch/arm/crypto/crc32-ce-core.S b/arch/arm/crypto/crc32-ce-core.S
index 3f13a76b9066..990c756c7487 100644
--- a/arch/arm/crypto/crc32-ce-core.S
+++ b/arch/arm/crypto/crc32-ce-core.S
@@ -304,3 +304,5 @@ ENDPROC(crc32_armv8_le)
 ENTRY(crc32c_armv8_le)
 	__crc32		c
 ENDPROC(crc32c_armv8_le)
+
+.section .note.GNU-stack,"",%progbits
diff --git a/arch/arm/crypto/ghash-ce-core.S b/arch/arm/crypto/ghash-ce-core.S
index 9f51e3fa4526..2f712b9d8b2b 100644
--- a/arch/arm/crypto/ghash-ce-core.S
+++ b/arch/arm/crypto/ghash-ce-core.S
@@ -337,3 +337,5 @@ ENTRY(pmull_ghash_update_p8)
 
 	ghash_update	p8
 ENDPROC(pmull_ghash_update_p8)
+
+.section .note.GNU-stack,"",%progbits
diff --git a/arch/arm/crypto/sha1-armv4-large.S b/arch/arm/crypto/sha1-armv4-large.S
index 1c8b685149f2..4e40132382b5 100644
--- a/arch/arm/crypto/sha1-armv4-large.S
+++ b/arch/arm/crypto/sha1-armv4-large.S
@@ -505,3 +505,4 @@ ENTRY(sha1_block_data_order)
 ENDPROC(sha1_block_data_order)
 .asciz	"SHA1 block transform for ARMv4, CRYPTOGAMS by <appro@openssl.org>"
 .align	2
+.section .note.GNU-stack,"",%progbits
diff --git a/arch/arm/crypto/sha1-armv7-neon.S b/arch/arm/crypto/sha1-armv7-neon.S
index 28d816a6a530..a554b1bb4ceb 100644
--- a/arch/arm/crypto/sha1-armv7-neon.S
+++ b/arch/arm/crypto/sha1-armv7-neon.S
@@ -632,3 +632,5 @@ ENTRY(sha1_transform_neon)
 .Ldo_nothing:
   bx lr
 ENDPROC(sha1_transform_neon)
+
+.section .note.GNU-stack,"",%progbits
diff --git a/arch/arm/crypto/sha1-ce-core.S b/arch/arm/crypto/sha1-ce-core.S
index 8a702e051738..73353804c33f 100644
--- a/arch/arm/crypto/sha1-ce-core.S
+++ b/arch/arm/crypto/sha1-ce-core.S
@@ -121,3 +121,5 @@ ENTRY(sha1_ce_transform)
 	vstr		dgbs, [r0, #16]
 	bx		lr
 ENDPROC(sha1_ce_transform)
+
+.section .note.GNU-stack,"",%progbits
diff --git a/arch/arm/crypto/sha2-ce-core.S b/arch/arm/crypto/sha2-ce-core.S
index b6369d2440a1..b5f20ab96690 100644
--- a/arch/arm/crypto/sha2-ce-core.S
+++ b/arch/arm/crypto/sha2-ce-core.S
@@ -121,3 +121,5 @@ ENTRY(sha2_ce_transform)
 	vst1.32		{dga-dgb}, [r0]
 	bx		lr
 ENDPROC(sha2_ce_transform)
+
+.section .note.GNU-stack,"",%progbits
diff --git a/arch/arm/crypto/sha256-armv4.pl b/arch/arm/crypto/sha256-armv4.pl
index f3a2b54efd4e..c12edbd99531 100644
--- a/arch/arm/crypto/sha256-armv4.pl
+++ b/arch/arm/crypto/sha256-armv4.pl
@@ -677,6 +677,7 @@ $code.=<<___;
 #if __ARM_MAX_ARCH__>=7 && !defined(__KERNEL__)
 .comm   OPENSSL_armcap_P,4,4
 #endif
+.section .note.GNU-stack,"",%progbits
 ___
 
 open SELF,$0;
diff --git a/arch/arm/crypto/sha512-armv4.pl b/arch/arm/crypto/sha512-armv4.pl
index 2fc3516912fa..6411799b4d1d 100644
--- a/arch/arm/crypto/sha512-armv4.pl
+++ b/arch/arm/crypto/sha512-armv4.pl
@@ -639,6 +639,7 @@ $code.=<<___;
 #if __ARM_MAX_ARCH__>=7 && !defined(__KERNEL__)
 .comm	OPENSSL_armcap_P,4,4
 #endif
+.section .note.GNU-stack,"",%progbits
 ___
 
 $code =~ s/\`([^\`]*)\`/eval $1/gem;
-- 
2.35.1

