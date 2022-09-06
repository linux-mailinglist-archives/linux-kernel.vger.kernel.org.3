Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E4C5AE52E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbiIFKUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiIFKUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:20:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5438227DE6;
        Tue,  6 Sep 2022 03:20:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MMLxH0vSMz4x1T;
        Tue,  6 Sep 2022 20:20:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662459619;
        bh=/J/NM8ikZ0Ag2umYZEst+e7YWPH741XAEdklkdsU2QY=;
        h=Date:From:To:Cc:Subject:From;
        b=R7M2wOloPEsnXvM2tICXixEuXj8JlJlAuR7aRbaxGkoBucy2HahEdtuV2uze1uxqd
         qHwWWeoZbccZ5baGTsFyuaqpHR7G4v+s3NV9O66thDAgEmndMk1A+Ejtj38cy1R5Fd
         dspYI98jzmETlB3bvbThCN3Eec2vEMxbAMsQAK389okIM9b30tdNG+4PJts1rhiX3n
         EuQIWiM9eFG6EPxpnp6g3hxn4aLP/2nIiq6JzWtqAoS7RBR9VAkr0Y9qDMAoGfQo2r
         SKInCmkp3Cs8CX54E4/DNrvZq8VBT7Yg2uHYRIzxhDDFcp/LESIMWHNt6UkANxzjAz
         Kgn/EL1wSBZ/A==
Date:   Tue, 6 Sep 2022 20:20:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Elliott <elliott@hpe.com>
Subject: linux-next: manual merge of the mm tree with the crypto tree
Message-ID: <20220906202017.5093fd23@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PXkk=Gq_rY/t2_9SnDt1CWV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PXkk=Gq_rY/t2_9SnDt1CWV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  crypto/Kconfig

between commit:

  28a936ef44e1 ("crypto: Kconfig - move x86 entries to a submenu")
and several others :-(

from the crypto tree and commit:

  4a86344bcbc9 ("crypto: kmsan: disable accelerated configs under KMSAN")

from the mm tree.

I fixed it up (I used the former version and then added the following
merge fix patch) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 6 Sep 2022 20:11:34 +1000
Subject: [PATCH] crypto: Kconfig: fix up for "crypto: kmsan: disable accele=
rated configs under KMSAN"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/x86/crypto/Kconfig | 29 +++++++++++++++++++++++++++++
 crypto/Kconfig          |  1 +
 2 files changed, 30 insertions(+)

diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 9bb0f7939c6b..856f5d8ca65f 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -5,6 +5,7 @@ menu "Accelerated Cryptographic Algorithms for CPU (x86)"
 config CRYPTO_CURVE25519_X86
 	tristate "Public key crypto: Curve25519 (ADX)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
 	help
@@ -16,6 +17,7 @@ config CRYPTO_CURVE25519_X86
 config CRYPTO_AES_NI_INTEL
 	tristate "Ciphers: AES, modes: ECB, CBC, CTS, CTR, XTR, XTS, GCM (AES-NI)"
 	depends on X86
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_AEAD
 	select CRYPTO_LIB_AES
 	select CRYPTO_ALGAPI
@@ -32,6 +34,7 @@ config CRYPTO_AES_NI_INTEL
 config CRYPTO_BLOWFISH_X86_64
 	tristate "Ciphers: Blowfish, modes: ECB, CBC"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_BLOWFISH_COMMON
 	imply CRYPTO_CTR
@@ -44,6 +47,7 @@ config CRYPTO_BLOWFISH_X86_64
 config CRYPTO_CAMELLIA_X86_64
 	tristate "Ciphers: Camellia with modes: ECB, CBC"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	imply CRYPTO_CTR
 	help
@@ -55,6 +59,7 @@ config CRYPTO_CAMELLIA_X86_64
 config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	tristate "Ciphers: Camellia with modes: ECB, CBC (AES-NI/AVX)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAMELLIA_X86_64
 	select CRYPTO_SIMD
@@ -69,6 +74,7 @@ config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 config CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
 	tristate "Ciphers: Camellia with modes: ECB, CBC (AES-NI/AVX2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	help
 	  Length-preserving ciphers: Camellia with ECB and CBC modes
@@ -80,6 +86,7 @@ config CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
 config CRYPTO_CAST5_AVX_X86_64
 	tristate "Ciphers: CAST5 with modes: ECB, CBC (AVX)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAST5
 	select CRYPTO_CAST_COMMON
@@ -97,6 +104,7 @@ config CRYPTO_CAST5_AVX_X86_64
 config CRYPTO_CAST6_AVX_X86_64
 	tristate "Ciphers: CAST6 with modes: ECB, CBC (AVX)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAST6
 	select CRYPTO_CAST_COMMON
@@ -115,6 +123,7 @@ config CRYPTO_CAST6_AVX_X86_64
 config CRYPTO_DES3_EDE_X86_64
 	tristate "Ciphers: Triple DES EDE with modes: ECB, CBC"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_DES
 	imply CRYPTO_CTR
@@ -129,6 +138,7 @@ config CRYPTO_DES3_EDE_X86_64
 config CRYPTO_SERPENT_SSE2_X86_64
 	tristate "Ciphers: Serpent with modes: ECB, CBC (SSE2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
@@ -145,6 +155,7 @@ config CRYPTO_SERPENT_SSE2_X86_64
 config CRYPTO_SERPENT_SSE2_586
 	tristate "Ciphers: Serpent with modes: ECB, CBC (32-bit with SSE2)"
 	depends on X86 && !64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
@@ -161,6 +172,7 @@ config CRYPTO_SERPENT_SSE2_586
 config CRYPTO_SERPENT_AVX_X86_64
 	tristate "Ciphers: Serpent with modes: ECB, CBC (AVX)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
@@ -178,6 +190,7 @@ config CRYPTO_SERPENT_AVX_X86_64
 config CRYPTO_SERPENT_AVX2_X86_64
 	tristate "Ciphers: Serpent with modes: ECB, CBC (AVX2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SERPENT_AVX_X86_64
 	help
 	  Length-preserving ciphers: Serpent cipher algorithm
@@ -245,6 +258,7 @@ config CRYPTO_TWOFISH_586
 config CRYPTO_TWOFISH_X86_64
 	tristate "Ciphers: Twofish"
 	depends on (X86 || UML_X86) && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_ALGAPI
 	select CRYPTO_TWOFISH_COMMON
 	imply CRYPTO_CTR
@@ -256,6 +270,7 @@ config CRYPTO_TWOFISH_X86_64
 config CRYPTO_TWOFISH_X86_64_3WAY
 	tristate "Ciphers: Twofish with modes: ECB, CBC (3-way parallel)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_TWOFISH_COMMON
 	select CRYPTO_TWOFISH_X86_64
@@ -271,6 +286,7 @@ config CRYPTO_TWOFISH_X86_64_3WAY
 config CRYPTO_TWOFISH_AVX_X86_64
 	tristate "Ciphers: Twofish with modes: ECB, CBC (AVX)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SIMD
 	select CRYPTO_TWOFISH_COMMON
@@ -289,6 +305,7 @@ config CRYPTO_TWOFISH_AVX_X86_64
 config CRYPTO_CHACHA20_X86_64
 	tristate "Ciphers: ChaCha20, XChaCha20, XChaCha12 (SSSE3/AVX2/AVX-512VL)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
@@ -304,6 +321,7 @@ config CRYPTO_CHACHA20_X86_64
 config CRYPTO_AEGIS128_AESNI_SSE2
 	tristate "AEAD ciphers: AEGIS-128 (AES-NI/SSE2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_AEAD
 	select CRYPTO_SIMD
 	help
@@ -316,6 +334,7 @@ config CRYPTO_AEGIS128_AESNI_SSE2
 config CRYPTO_NHPOLY1305_SSE2
 	tristate "Hash functions: NHPoly1305 (SSE2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_NHPOLY1305
 	help
 	  NHPoly1305 hash function for Adiantum
@@ -326,6 +345,7 @@ config CRYPTO_NHPOLY1305_SSE2
 config CRYPTO_NHPOLY1305_AVX2
 	tristate "Hash functions: NHPoly1305 (AVX2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_NHPOLY1305
 	help
 	  NHPoly1305 hash function for Adiantum
@@ -336,6 +356,7 @@ config CRYPTO_NHPOLY1305_AVX2
 config CRYPTO_BLAKE2S_X86
 	bool "Hash functions: BLAKE2s (SSSE3/AVX-512)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_LIB_BLAKE2S_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
 	help
@@ -358,6 +379,7 @@ config CRYPTO_POLYVAL_CLMUL_NI
 config CRYPTO_POLY1305_X86_64
 	tristate "Hash functions: Poly1305 (SSE2/AVX2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_LIB_POLY1305_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 	help
@@ -370,6 +392,7 @@ config CRYPTO_POLY1305_X86_64
 config CRYPTO_SHA1_SSSE3
 	tristate "Hash functions: SHA-1 (SSSE3/AVX/AVX2/SHA-NI)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
@@ -384,6 +407,7 @@ config CRYPTO_SHA1_SSSE3
 config CRYPTO_SHA256_SSSE3
 	tristate "Hash functions: SHA-224 and SHA-256 (SSSE3/AVX/AVX2/SHA-NI)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
@@ -398,6 +422,7 @@ config CRYPTO_SHA256_SSSE3
 config CRYPTO_SHA512_SSSE3
 	tristate "Hash functions: SHA-384 and SHA-512 (SSSE3/AVX/AVX2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SHA512
 	select CRYPTO_HASH
 	help
@@ -424,6 +449,7 @@ config CRYPTO_SM3_AVX_X86_64
 config CRYPTO_GHASH_CLMUL_NI_INTEL
 	tristate "Hash functions: GHASH (CLMUL-NI)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_CRYPTD
 	help
 	  GCM GHASH hash function (NIST SP800-38D)
@@ -434,6 +460,7 @@ config CRYPTO_GHASH_CLMUL_NI_INTEL
 config CRYPTO_CRC32C_INTEL
 	tristate "CRC32c (SSE4.2/PCLMULQDQ)"
 	depends on X86
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_HASH
 	help
 	  CRC32c CRC algorithm with the iSCSI polynomial (RFC 3385 and RFC 3720)
@@ -445,6 +472,7 @@ config CRYPTO_CRC32C_INTEL
 config CRYPTO_CRC32_PCLMUL
 	tristate "CRC32 (PCLMULQDQ)"
 	depends on X86
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_HASH
 	select CRC32
 	help
@@ -456,6 +484,7 @@ config CRYPTO_CRC32_PCLMUL
 config CRYPTO_CRCT10DIF_PCLMUL
 	tristate "CRCT10DIF (PCLMULQDQ)"
 	depends on X86 && 64BIT && CRC_T10DIF
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_HASH
 	help
 	  CRC16 CRC algorithm used for the T10 (SCSI) Data Integrity Field (DIF)
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 40423a14f86f..1dfe0583f302 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -796,6 +796,7 @@ config CRYPTO_AEGIS128
 config CRYPTO_AEGIS128_SIMD
 	bool "AEGIS-128 (arm NEON, arm64 NEON)"
 	depends on CRYPTO_AEGIS128 && ((ARM || ARM64) && KERNEL_MODE_NEON)
+	depends on !KMSAN # avoid false positives from assembly
 	default y
 	help
 	  AEGIS-128 AEAD algorithm
--=20
2.35.1



--=20
Cheers,
Stephen Rothwell

--Sig_/PXkk=Gq_rY/t2_9SnDt1CWV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMXHuEACgkQAVBC80lX
0Gz/pQf8D+8mtf5GghAEIVMadyZxRXAj+7KnQxnRO00NvAsG+yifRd5II0vwojVV
Oy6nBlpq+JhLsTnmhMzkZJM8HiXeUOM23/YCm3ih7qeY0I/HZF4JBZ0FLqivLa5K
SUHTDMvR3wNMgXP+tMI9jlUKrb8NSUoKlYsx0iJODfD/Kk/A9Ynw02/W+WmfjqEC
vMK6nQ8Xx+LTgN8a8l2+H+rfHzwpQTHxOkPiHP8AaIEFiIy+wDozPkj2VHA8Q9U8
6jC5iH+RaFz8HH1lBGyGC+y4ITbnRdnlYKYheQqzXENB8VvZAVFmkHi1fLSNZQGV
Tdfbf+dQZ31C3Mk9mJs6AYjEm6rxUg==
=r2cg
-----END PGP SIGNATURE-----

--Sig_/PXkk=Gq_rY/t2_9SnDt1CWV--
