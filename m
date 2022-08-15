Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6937593E53
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345646AbiHOUkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344432AbiHOUfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:35:18 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3182A73A;
        Mon, 15 Aug 2022 12:06:26 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FIoMh9018977;
        Mon, 15 Aug 2022 19:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=Iuxo2ne31HiW7Rg0v8Ej/FidItYg8f+vFmxa8hRVvfE=;
 b=WfSLjPkI/Avdc59M4Ab1Wybh25WfuivLT3w/Kd/AiavmKbhISJIsSONAAImEQpJZqcAZ
 iGf1IUJuHDApT3t+AqaUePWvgfs30Il2gWRBMKpKrBP+IvXWMkU5F+Rk5GujuaCx/RL4
 hLb62A1PoO44jdRzssfCNWWJv3zI3PjFrhEpuQ8hdMj5V3YXq+OOG2KGCSBBEozp85qU
 eDtUeotthI6cIS/IxneLM3DaXScAMQeb7HbBpj7paJQGcw5gyN93oBydrcJ716RlEwcJ
 YhLzcyzxtKetxvGZqROgJeoi9wK3rwMFi61ZQRGXvln0tUE+WFUQEzSc3BX7KWijiSr+ bQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hyus1842s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 19:06:22 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 75477804CB9;
        Mon, 15 Aug 2022 19:06:21 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 313DD803299;
        Mon, 15 Aug 2022 19:06:21 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     toshi.kani@hpe.com, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 4/8] crypto: Kconfig - simplify AEAD and block mode entries
Date:   Mon, 15 Aug 2022 14:06:04 -0500
Message-Id: <20220815190608.47182-5-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815190608.47182-1-elliott@hpe.com>
References: <20220815190608.47182-1-elliott@hpe.com>
X-Proofpoint-ORIG-GUID: iC-CXEQD6YDHaaxkV9PF2TRMe8NyW-Lu
X-Proofpoint-GUID: iC-CXEQD6YDHaaxkV9PF2TRMe8NyW-Lu
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=493
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shorten menu titles and help text and make them consistent:
* acronym
* name
* architecture and architecture features in parenthesis
* no suffixes like "<something> algorithm", "support", or
"hardware acceleration", or "optimized"

Clarify architecture restrictions (e.g., include x86 in the names of
all the x86-optimized modules.

Simplify descriptions, update references, and ensure that https
references are still valid.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/Kconfig | 133 +++++++++++++++++++++++++++----------------------
 1 file changed, 74 insertions(+), 59 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 045ef2a92449..703c91e8e7a0 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -198,7 +198,8 @@ menu "Crypto core or helper"
 	select CRYPTO_NULL
 	help
 	  Authenc: Combined mode wrapper for IPsec.
-	  This is required for IPSec.
+
+	  This is required for IPSec ESP (XFRM_ESP).
 
 config CRYPTO_TEST
 	tristate "Testing module"
@@ -319,57 +320,65 @@ menu "Public-key cryptography"
 menu "AEAD (Authenticated Encryption with Associated Data) ciphers"
 
 config CRYPTO_CCM
-	tristate "CCM support"
+	tristate "CCM (Counter with Cipher Block Chaining-Message Authentication Code)"
 	select CRYPTO_CTR
 	select CRYPTO_HASH
 	select CRYPTO_AEAD
 	select CRYPTO_MANAGER
 	help
-	  Support for Counter with CBC MAC. Required for IPsec.
+	  CCM (Counter with Cipher Block Chaining-Message Authentication Code)
+	  authenticated encryption mode (NIST SP800-38C)
 
 config CRYPTO_GCM
-	tristate "GCM/GMAC support"
+	tristate "GCM (Galois/Counter Mode) and GMAC (GCM Message Authentication Code)"
 	select CRYPTO_CTR
 	select CRYPTO_AEAD
 	select CRYPTO_GHASH
 	select CRYPTO_NULL
 	select CRYPTO_MANAGER
 	help
-	  Support for Galois/Counter Mode (GCM) and Galois Message
-	  Authentication Code (GMAC). Required for IPSec.
+	  GCM (Galois/Counter Mode) authenticated encryption mode and GMAC
+	  (GCM Message Authentication Code) (NIST SP800-38D)
+
+	  This is required for IPSec ESP (XFRM_ESP).
 
 config CRYPTO_CHACHA20POLY1305
-	tristate "ChaCha20-Poly1305 AEAD support"
+	tristate "ChaCha20-Poly1305"
 	select CRYPTO_CHACHA20
 	select CRYPTO_POLY1305
 	select CRYPTO_AEAD
 	select CRYPTO_MANAGER
 	help
-	  ChaCha20-Poly1305 AEAD support, RFC7539.
-
-	  Support for the AEAD wrapper using the ChaCha20 stream cipher combined
-	  with the Poly1305 authenticator. It is defined in RFC7539 for use in
-	  IETF protocols.
+	  ChaCha20 stream cipher and Poly1305 authenticator combined
+	  mode (RFC8439)
 
 config CRYPTO_AEGIS128
-	tristate "AEGIS-128 AEAD algorithm"
+	tristate "AEGIS-128"
 	select CRYPTO_AEAD
 	select CRYPTO_AES  # for AES S-box tables
 	help
-	 Support for the AEGIS-128 dedicated AEAD algorithm.
+	  AEGIS-128 AEAD algorithm
 
 config CRYPTO_AEGIS128_SIMD
-	bool "Support SIMD acceleration for AEGIS-128"
+	bool "AEGIS-128 (arm SIMD acceleration)"
 	depends on CRYPTO_AEGIS128 && ((ARM || ARM64) && KERNEL_MODE_NEON)
 	default y
+	help
+	  AEGIS-128 AEAD algorithm
+
+	  Architecture: arm using the Neon SIMD architecture extension
 
 config CRYPTO_AEGIS128_AESNI_SSE2
-	tristate "AEGIS-128 AEAD algorithm (x86_64 AESNI+SSE2 implementation)"
+	tristate "AEGIS-128 (x86_64 with AES-NI/SSE2)"
 	depends on X86 && 64BIT
 	select CRYPTO_AEAD
 	select CRYPTO_SIMD
 	help
-	 AESNI+SSE2 implementation of the AEGIS-128 dedicated AEAD algorithm.
+	  AEGIS-128 AEAD algorithm
+
+	  Architecture: x86_64 using:
+	  * AES-NI (AES New Instructions)
+	  * SSE2 (Streaming SIMD Extensions 2)
 
 config CRYPTO_SEQIV
 	tristate "Sequence Number IV Generator"
@@ -380,7 +389,9 @@ menu "AEAD (Authenticated Encryption with Associated Data) ciphers"
 	select CRYPTO_MANAGER
 	help
 	  This IV generator generates an IV based on a sequence number by
-	  xoring it with a salt.  This algorithm is mainly useful for CTR
+	  xoring it with a salt.  This algorithm is mainly useful for CTR.
+
+	  This is required for IPsec ESP (XFRM_ESP).
 
 config CRYPTO_ECHAINIV
 	tristate "Encrypted Chain IV Generator"
@@ -400,72 +411,69 @@ menu "AEAD (Authenticated Encryption with Associated Data) ciphers"
 menu "Block modes"
 
 config CRYPTO_CBC
-	tristate "CBC support"
+	tristate "CBC (Cipher Block Chaining)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  CBC: Cipher Block Chaining mode
-	  This block cipher algorithm is required for IPSec.
+	  CBC (Cipher Block Chaining) mode (NIST SP800-38A)
+
+	  This block cipher mode is required for IPSec ESP (XFRM_ESP).
 
 config CRYPTO_CFB
-	tristate "CFB support"
+	tristate "CFB (Cipher Feedback)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  CFB: Cipher FeedBack mode
-	  This block cipher algorithm is required for TPM2 Cryptography.
+	  CFB (Cipher Feedback) mode (NIST SP800-38A)
+
+	  This block cipher mode is required for TPM2 Cryptography.
 
 config CRYPTO_CTR
-	tristate "CTR support"
+	tristate "CTR (Counter)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  CTR: Counter mode
-	  This block cipher algorithm is required for IPSec.
+	  CTR (Counter) mode (NIST SP800-38A)
 
 config CRYPTO_CTS
-	tristate "CTS support"
+	tristate "CTS (Cipher Text Stealing)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  CTS: Cipher Text Stealing
-	  This is the Cipher Text Stealing mode as described by
-	  Section 8 of rfc2040 and referenced by rfc3962
-	  (rfc3962 includes errata information in its Appendix A) or
-	  CBC-CS3 as defined by NIST in Sp800-38A addendum from Oct 2010.
+	  CBC-CS3 variant of CTS (Cipher Text Stealing) (NIST
+	  Addendum to SP800-38A (October 2010))
+
 	  This mode is required for Kerberos gss mechanism support
 	  for AES encryption.
 
-	  See: https://csrc.nist.gov/publications/detail/sp/800-38a/addendum/final
-
 config CRYPTO_ECB
-	tristate "ECB support"
+	tristate "ECB (Electronic Codebook)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  ECB: Electronic CodeBook mode
-	  This is the simplest block cipher algorithm.  It simply encrypts
-	  the input block by block.
+	  ECB (Electronic Codebook) mode (NIST SP800-38A)
 
 config CRYPTO_LRW
-	tristate "LRW support"
+	tristate "LRW (Liskov Rivest Wagner)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	select CRYPTO_GF128MUL
 	select CRYPTO_ECB
 	help
-	  LRW: Liskov Rivest Wagner, a tweakable, non malleable, non movable
+	  LRW (Liskov Rivest Wagner) mode, a tweakable, non malleable, non movable
 	  narrow block cipher mode for dm-crypt.  Use it with cipher
 	  specification string aes-lrw-benbi, the key must be 256, 320 or 384.
 	  The first 128, 192 or 256 bits in the key are used for AES and the
 	  rest is used to tie each cipher block to its logical position.
 
 config CRYPTO_OFB
-	tristate "OFB support"
+	tristate "OFB (Output Feedback)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  OFB: the Output Feedback mode makes a block cipher into a synchronous
+	  OFB (Output Feedback) mode (NIST SP800-38A)
+
+	  This mode makes a block cipher into a synchronous
 	  stream cipher. It generates keystream blocks, which are then XORed
 	  with the plaintext blocks to get the ciphertext. Flipping a bit in the
 	  ciphertext produces a flipped bit in the plaintext at the same
@@ -473,30 +481,33 @@ menu "Block modes"
 	  normally even when applied before encryption.
 
 config CRYPTO_PCBC
-	tristate "PCBC support"
+	tristate "PCBC (Propagating Cipher Block Chaining)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  PCBC: Propagating Cipher Block Chaining mode
+	  PCBC (Propagating Cipher Block Chaining) mode
 	  This block cipher algorithm is required for RxRPC.
 
 config CRYPTO_XTS
-	tristate "XTS support"
+	tristate "XTS (XOR Encrypt XOR with ciphertext stealing)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	select CRYPTO_ECB
 	help
-	  XTS: IEEE1619/D16 narrow block cipher use with aes-xts-plain,
-	  key size 256, 384 or 512 bits. This implementation currently
-	  can't handle a sectorsize which is not a multiple of 16 bytes.
+	  XTS (XOR Encrypt XOR with ciphertext stealing) mode (NIST SP800-38E
+	  and IEEE 1619)
+
+	  Use with aes-xts-plain, key size 256, 384 or 512 bits. This
+	  implementation currently can't handle a sectorsize which is not a
+	  multiple of 16 bytes.
 
 config CRYPTO_KEYWRAP
-	tristate "Key wrapping support"
+	tristate "KW (AES Key Wrap)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  Support for key wrapping (NIST SP800-38F / RFC3394) without
-	  padding.
+	  KW (AES Key Wrap) authenticated encryption mode (NIST SP800-38F
+	  and RFC3394) without padding.
 
 config CRYPTO_NHPOLY1305
 	tristate
@@ -504,23 +515,27 @@ menu "Block modes"
 	select CRYPTO_LIB_POLY1305_GENERIC
 
 config CRYPTO_NHPOLY1305_SSE2
-	tristate "NHPoly1305 hash function (x86_64 SSE2 implementation)"
+	tristate "NHPoly1305 (x86_64 with SSE2)"
 	depends on X86 && 64BIT
 	select CRYPTO_NHPOLY1305
 	help
-	  SSE2 optimized implementation of the hash function used by the
-	  Adiantum encryption mode.
+	  NHPoly1305 hash function (Adiantum)
+
+	  Architecture: x86_64 using:
+	  * SSE2 (Streaming SIMD Extensions 2)
 
 config CRYPTO_NHPOLY1305_AVX2
-	tristate "NHPoly1305 hash function (x86_64 AVX2 implementation)"
+	tristate "NHPoly1305 (x86_64 with AVX2)"
 	depends on X86 && 64BIT
 	select CRYPTO_NHPOLY1305
 	help
-	  AVX2 optimized implementation of the hash function used by the
-	  Adiantum encryption mode.
+	  NHPoly1305 hash function (Adiantum)
+
+	  Architecture: x86_64 using:
+	  * AVX2 (Advanced Vector Extensions 2)
 
 config CRYPTO_ADIANTUM
-	tristate "Adiantum support"
+	tristate "Adiantum"
 	select CRYPTO_CHACHA20
 	select CRYPTO_LIB_POLY1305_GENERIC
 	select CRYPTO_NHPOLY1305
-- 
2.37.1

