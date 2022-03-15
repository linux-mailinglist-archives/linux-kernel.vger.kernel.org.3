Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5184D97F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346794AbiCOJqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346774AbiCOJqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:46:23 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B814EF7F;
        Tue, 15 Mar 2022 02:45:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0V7H-Cwp_1647337502;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V7H-Cwp_1647337502)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Mar 2022 17:45:03 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Markku-Juhani O . Saarinen" <mjos@iki.fi>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>, zhuolong.lq@antfin.com
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH 3/4] crypto: arm64/sm4 - add ARMv8 NEON implementation
Date:   Tue, 15 Mar 2022 17:44:53 +0800
Message-Id: <20220315094454.45269-4-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220315094454.45269-1-tianjia.zhang@linux.alibaba.com>
References: <20220315094454.45269-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds ARMv8 NEON implementations of SM4 in ECB, CBC, CFB and CTR
modes. This implementation uses the plain NEON instruction set, All
S-BOX substitutions uses the tbl/tbx instructions of ARMv8, combined
with the out-of-order execution in CPU, this optimization supports
encryption of up to 8 blocks at the same time.

The performance of encrypting one block is not as good as software
implementation, so the encryption operations of CBC and CFB still
use pure software algorithms.

Benchmark on T-Head Yitian-710 2.75 GHz, the data comes from the 218
mode of tcrypt. The abscissas are blocks of different lengths. The
data is tabulated and the unit is Mb/s:

sm4-generic |     16       64      128      256     1024     1420     4096
    ECB enc |  80.05    91.42    93.66    94.77    95.69    95.77    95.86
    ECB dec |  79.98    91.41    93.64    94.76    95.66    95.77    95.85
    CBC enc |  78.55    86.50    88.02    88.77    89.36    89.42    89.48
    CBC dec |  76.82    89.06    91.52    92.77    93.75    93.83    93.96
    CFB enc |  77.64    86.13    87.62    88.42    89.08    88.83    89.18
    CFB dec |  77.57    88.34    90.36    91.45    92.34    92.00    92.44
    CTR enc |  77.80    88.28    90.23    91.22    92.11    91.81    92.25
    CTR dec |  77.83    88.22    90.22    91.22    92.04    91.82    92.28
sm4-neon
    ECB enc |  28.31   112.77   203.03   209.89   215.49   202.11   210.59
    ECB dec |  28.36   113.45   203.23   210.00   215.52   202.13   210.65
    CBC enc |  79.32    87.02    88.51    89.28    89.85    89.89    89.97
    CBC dec |  28.29   112.20   203.30   209.82   214.99   201.51   209.95
    CFB enc |  79.59    87.16    88.54    89.30    89.83    89.62    89.92
    CFB dec |  28.12   111.05   202.47   209.02   214.21   210.90   209.12
    CTR enc |  28.04   108.81   200.62   206.65   211.78   208.78   206.74
    CTR dec |  28.02   108.82   200.45   206.62   211.78   208.74   206.70

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/arm64/crypto/Kconfig         |   6 +
 arch/arm64/crypto/Makefile        |   3 +
 arch/arm64/crypto/sm4-neon-core.S | 487 ++++++++++++++++++++++++++++++
 arch/arm64/crypto/sm4-neon-glue.c | 442 +++++++++++++++++++++++++++
 4 files changed, 938 insertions(+)
 create mode 100644 arch/arm64/crypto/sm4-neon-core.S
 create mode 100644 arch/arm64/crypto/sm4-neon-glue.c

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 2a965aa0188d..4cffab846936 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -53,6 +53,12 @@ config CRYPTO_SM4_ARM64_CE
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_SM4
 
+config CRYPTO_SM4_ARM64_NEON_BLK
+	tristate "SM4 in ECB/CBC/CFB/CTR modes using NEON instructions"
+	depends on KERNEL_MODE_NEON
+	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_SM4
+
 config CRYPTO_GHASH_ARM64_CE
 	tristate "GHASH/AES-GCM using ARMv8 Crypto Extensions"
 	depends on KERNEL_MODE_NEON
diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index 85863e610a2e..41aee6103e78 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -23,6 +23,9 @@ sm3-ce-y := sm3-ce-glue.o sm3-ce-core.o
 obj-$(CONFIG_CRYPTO_SM4_ARM64_CE) += sm4-ce-cipher.o
 sm4-ce-cipher-y := sm4-ce-cipher-glue.o sm4-ce-cipher-core.o
 
+obj-$(CONFIG_CRYPTO_SM4_ARM64_NEON_BLK) += sm4-neon.o
+sm4-neon-y := sm4-neon-glue.o sm4-neon-core.o
+
 obj-$(CONFIG_CRYPTO_GHASH_ARM64_CE) += ghash-ce.o
 ghash-ce-y := ghash-ce-glue.o ghash-ce-core.o
 
diff --git a/arch/arm64/crypto/sm4-neon-core.S b/arch/arm64/crypto/sm4-neon-core.S
new file mode 100644
index 000000000000..3d5256b354d2
--- /dev/null
+++ b/arch/arm64/crypto/sm4-neon-core.S
@@ -0,0 +1,487 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SM4 Cipher Algorithm for ARMv8 NEON
+ * as specified in
+ * https://tools.ietf.org/id/draft-ribose-cfrg-sm4-10.html
+ *
+ * Copyright (C) 2022, Alibaba Group.
+ * Copyright (C) 2022 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+/* Register macros */
+
+#define RTMP0	v8
+#define RTMP1	v9
+#define RTMP2	v10
+#define RTMP3	v11
+
+#define RX0	v12
+#define RX1	v13
+#define RKEY	v14
+#define RIV	v15
+
+/* Helper macros. */
+
+#define PREPARE                                                 \
+	adr_l		x5, crypto_sm4_sbox;                    \
+	ld1		{v16.16b-v19.16b}, [x5], #64;           \
+	ld1		{v20.16b-v23.16b}, [x5], #64;           \
+	ld1		{v24.16b-v27.16b}, [x5], #64;           \
+	ld1		{v28.16b-v31.16b}, [x5];
+
+#define transpose_4x4(s0, s1, s2, s3)                           \
+	zip1		RTMP0.4s, s0.4s, s1.4s;                 \
+	zip1		RTMP1.4s, s2.4s, s3.4s;                 \
+	zip2		RTMP2.4s, s0.4s, s1.4s;                 \
+	zip2		RTMP3.4s, s2.4s, s3.4s;                 \
+	zip1		s0.2d, RTMP0.2d, RTMP1.2d;              \
+	zip2		s1.2d, RTMP0.2d, RTMP1.2d;              \
+	zip1		s2.2d, RTMP2.2d, RTMP3.2d;              \
+	zip2		s3.2d, RTMP2.2d, RTMP3.2d;
+
+#define rotate_clockwise_90(s0, s1, s2, s3)                     \
+	zip1		RTMP0.4s, s1.4s, s0.4s;                 \
+	zip2		RTMP1.4s, s1.4s, s0.4s;                 \
+	zip1		RTMP2.4s, s3.4s, s2.4s;                 \
+	zip2		RTMP3.4s, s3.4s, s2.4s;                 \
+	zip1		s0.2d, RTMP2.2d, RTMP0.2d;              \
+	zip2		s1.2d, RTMP2.2d, RTMP0.2d;              \
+	zip1		s2.2d, RTMP3.2d, RTMP1.2d;              \
+	zip2		s3.2d, RTMP3.2d, RTMP1.2d;
+
+#define ROUND4(round, s0, s1, s2, s3)                           \
+	dup		RX0.4s, RKEY.s[round];                  \
+	/* rk ^ s1 ^ s2 ^ s3 */                                 \
+	eor		RTMP1.16b, s2.16b, s3.16b;              \
+	eor		RX0.16b, RX0.16b, s1.16b;               \
+	eor		RX0.16b, RX0.16b, RTMP1.16b;            \
+                                                                \
+	/* sbox, non-linear part */                             \
+	movi		RTMP3.16b, #64;  /* sizeof(sbox) / 4 */ \
+	tbl		RTMP0.16b, {v16.16b-v19.16b}, RX0.16b;  \
+	sub		RX0.16b, RX0.16b, RTMP3.16b;            \
+	tbx		RTMP0.16b, {v20.16b-v23.16b}, RX0.16b;  \
+	sub		RX0.16b, RX0.16b, RTMP3.16b;            \
+	tbx		RTMP0.16b, {v24.16b-v27.16b}, RX0.16b;  \
+	sub		RX0.16b, RX0.16b, RTMP3.16b;            \
+	tbx		RTMP0.16b, {v28.16b-v31.16b}, RX0.16b;  \
+                                                                \
+	/* linear part */                                       \
+	shl		RTMP1.4s, RTMP0.4s, #8;                 \
+	shl		RTMP2.4s, RTMP0.4s, #16;                \
+	shl		RTMP3.4s, RTMP0.4s, #24;                \
+	sri		RTMP1.4s, RTMP0.4s, #(32-8);            \
+	sri		RTMP2.4s, RTMP0.4s, #(32-16);           \
+	sri		RTMP3.4s, RTMP0.4s, #(32-24);           \
+	/* RTMP1 = x ^ rol32(x, 8) ^ rol32(x, 16) */            \
+	eor		RTMP1.16b, RTMP1.16b, RTMP0.16b;        \
+	eor		RTMP1.16b, RTMP1.16b, RTMP2.16b;        \
+	/* RTMP3 = x ^ rol32(x, 24) ^ rol32(RTMP1, 2) */        \
+	eor		RTMP3.16b, RTMP3.16b, RTMP0.16b;        \
+	shl		RTMP2.4s, RTMP1.4s, 2;                  \
+	sri		RTMP2.4s, RTMP1.4s, #(32-2);            \
+	eor		RTMP3.16b, RTMP3.16b, RTMP2.16b;        \
+	/* s0 ^= RTMP3 */                                       \
+	eor		s0.16b, s0.16b, RTMP3.16b;
+
+#define SM4_CRYPT_BLK4(b0, b1, b2, b3)                          \
+	rev32		b0.16b, b0.16b;                         \
+	rev32		b1.16b, b1.16b;                         \
+	rev32		b2.16b, b2.16b;                         \
+	rev32		b3.16b, b3.16b;                         \
+                                                                \
+	transpose_4x4(b0, b1, b2, b3);                          \
+                                                                \
+	mov		x6, 8;                                  \
+4:                                                              \
+	ld1		{RKEY.4s}, [x0], #16;                   \
+	subs		x6, x6, #1;                             \
+                                                                \
+	ROUND4(0, b0, b1, b2, b3);                              \
+	ROUND4(1, b1, b2, b3, b0);                              \
+	ROUND4(2, b2, b3, b0, b1);                              \
+	ROUND4(3, b3, b0, b1, b2);                              \
+                                                                \
+	bne		4b;                                     \
+                                                                \
+	rotate_clockwise_90(b0, b1, b2, b3);                    \
+	rev32		b0.16b, b0.16b;                         \
+	rev32		b1.16b, b1.16b;                         \
+	rev32		b2.16b, b2.16b;                         \
+	rev32		b3.16b, b3.16b;                         \
+                                                                \
+	/* repoint to rkey */                                   \
+	sub		x0, x0, #128;
+
+#define ROUND8(round, s0, s1, s2, s3, t0, t1, t2, t3)           \
+	/* rk ^ s1 ^ s2 ^ s3 */                                 \
+	dup		RX0.4s, RKEY.s[round];                  \
+	eor		RTMP0.16b, s2.16b, s3.16b;              \
+	mov		RX1.16b, RX0.16b;                       \
+	eor		RTMP1.16b, t2.16b, t3.16b;              \
+	eor		RX0.16b, RX0.16b, s1.16b;               \
+	eor		RX1.16b, RX1.16b, t1.16b;               \
+	eor		RX0.16b, RX0.16b, RTMP0.16b;            \
+	eor		RX1.16b, RX1.16b, RTMP1.16b;            \
+                                                                \
+	/* sbox, non-linear part */                             \
+	movi		RTMP3.16b, #64;  /* sizeof(sbox) / 4 */ \
+	tbl		RTMP0.16b, {v16.16b-v19.16b}, RX0.16b;  \
+	tbl		RTMP1.16b, {v16.16b-v19.16b}, RX1.16b;  \
+	sub		RX0.16b, RX0.16b, RTMP3.16b;            \
+	sub		RX1.16b, RX1.16b, RTMP3.16b;            \
+	tbx		RTMP0.16b, {v20.16b-v23.16b}, RX0.16b;  \
+	tbx		RTMP1.16b, {v20.16b-v23.16b}, RX1.16b;  \
+	sub		RX0.16b, RX0.16b, RTMP3.16b;            \
+	sub		RX1.16b, RX1.16b, RTMP3.16b;            \
+	tbx		RTMP0.16b, {v24.16b-v27.16b}, RX0.16b;  \
+	tbx		RTMP1.16b, {v24.16b-v27.16b}, RX1.16b;  \
+	sub		RX0.16b, RX0.16b, RTMP3.16b;            \
+	sub		RX1.16b, RX1.16b, RTMP3.16b;            \
+	tbx		RTMP0.16b, {v28.16b-v31.16b}, RX0.16b;  \
+	tbx		RTMP1.16b, {v28.16b-v31.16b}, RX1.16b;  \
+                                                                \
+	/* linear part */                                       \
+	shl		RX0.4s, RTMP0.4s, #8;                   \
+	shl		RX1.4s, RTMP1.4s, #8;                   \
+	shl		RTMP2.4s, RTMP0.4s, #16;                \
+	shl		RTMP3.4s, RTMP1.4s, #16;                \
+	sri		RX0.4s, RTMP0.4s, #(32 - 8);            \
+	sri		RX1.4s, RTMP1.4s, #(32 - 8);            \
+	sri		RTMP2.4s, RTMP0.4s, #(32 - 16);         \
+	sri		RTMP3.4s, RTMP1.4s, #(32 - 16);         \
+	/* RX = x ^ rol32(x, 8) ^ rol32(x, 16) */               \
+	eor		RX0.16b, RX0.16b, RTMP0.16b;            \
+	eor		RX1.16b, RX1.16b, RTMP1.16b;            \
+	eor		RX0.16b, RX0.16b, RTMP2.16b;            \
+	eor		RX1.16b, RX1.16b, RTMP3.16b;            \
+	/* RTMP0/1 ^= x ^ rol32(x, 24) ^ rol32(RX, 2) */        \
+	shl		RTMP2.4s, RTMP0.4s, #24;                \
+	shl		RTMP3.4s, RTMP1.4s, #24;                \
+	sri		RTMP2.4s, RTMP0.4s, #(32 - 24);         \
+	sri		RTMP3.4s, RTMP1.4s, #(32 - 24);         \
+	eor		RTMP0.16b, RTMP0.16b, RTMP2.16b;        \
+	eor		RTMP1.16b, RTMP1.16b, RTMP3.16b;        \
+	shl		RTMP2.4s, RX0.4s, #2;                   \
+	shl		RTMP3.4s, RX1.4s, #2;                   \
+	sri		RTMP2.4s, RX0.4s, #(32 - 2);            \
+	sri		RTMP3.4s, RX1.4s, #(32 - 2);            \
+	eor		RTMP0.16b, RTMP0.16b, RTMP2.16b;        \
+	eor		RTMP1.16b, RTMP1.16b, RTMP3.16b;        \
+	/* s0/t0 ^= RTMP0/1 */                                  \
+	eor		s0.16b, s0.16b, RTMP0.16b;              \
+	eor		t0.16b, t0.16b, RTMP1.16b;
+
+#define SM4_CRYPT_BLK8(b0, b1, b2, b3, b4, b5, b6, b7)          \
+	rev32		b0.16b, b0.16b;                         \
+	rev32		b1.16b, b1.16b;                         \
+	rev32		b2.16b, b2.16b;                         \
+	rev32		b3.16b, b3.16b;                         \
+	rev32		b4.16b, b4.16b;                         \
+	rev32		b5.16b, b5.16b;                         \
+	rev32		b6.16b, b6.16b;                         \
+	rev32		b7.16b, b7.16b;                         \
+                                                                \
+	transpose_4x4(b0, b1, b2, b3);                          \
+	transpose_4x4(b4, b5, b6, b7);                          \
+                                                                \
+	mov		x6, 8;                                  \
+8:                                                              \
+	ld1		{RKEY.4s}, [x0], #16;                   \
+	subs		x6, x6, #1;                             \
+                                                                \
+	ROUND8(0, b0, b1, b2, b3, b4, b5, b6, b7);              \
+	ROUND8(1, b1, b2, b3, b0, b5, b6, b7, b4);              \
+	ROUND8(2, b2, b3, b0, b1, b6, b7, b4, b5);              \
+	ROUND8(3, b3, b0, b1, b2, b7, b4, b5, b6);              \
+                                                                \
+	bne		8b;                                     \
+                                                                \
+	rotate_clockwise_90(b0, b1, b2, b3);                    \
+	rotate_clockwise_90(b4, b5, b6, b7);                    \
+	rev32		b0.16b, b0.16b;                         \
+	rev32		b1.16b, b1.16b;                         \
+	rev32		b2.16b, b2.16b;                         \
+	rev32		b3.16b, b3.16b;                         \
+	rev32		b4.16b, b4.16b;                         \
+	rev32		b5.16b, b5.16b;                         \
+	rev32		b6.16b, b6.16b;                         \
+	rev32		b7.16b, b7.16b;                         \
+                                                                \
+	/* repoint to rkey */                                   \
+	sub		x0, x0, #128;
+
+
+.align 3
+SYM_FUNC_START_LOCAL(__sm4_neon_crypt_blk1_4)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   w3: num blocks (1..4)
+	 */
+	PREPARE;
+
+	ld1		{v0.16b}, [x2], #16;
+	mov		v1.16b, v0.16b;
+	mov		v2.16b, v0.16b;
+	mov		v3.16b, v0.16b;
+	cmp		w3, #2;
+	blt		.Lblk4_load_input_done;
+	ld1		{v1.16b}, [x2], #16;
+	beq		.Lblk4_load_input_done;
+	ld1		{v2.16b}, [x2], #16;
+	cmp		w3, #3;
+	beq		.Lblk4_load_input_done;
+	ld1		{v3.16b}, [x2];
+
+.Lblk4_load_input_done:
+	SM4_CRYPT_BLK4(v0, v1, v2, v3);
+
+	st1		{v0.16b}, [x1], #16;
+	cmp		w3, #2;
+	blt		.Lblk4_store_output_done;
+	st1		{v1.16b}, [x1], #16;
+	beq		.Lblk4_store_output_done;
+	st1		{v2.16b}, [x1], #16;
+	cmp		w3, #3;
+	beq		.Lblk4_store_output_done;
+	st1		{v3.16b}, [x1];
+
+.Lblk4_store_output_done:
+	ret;
+SYM_FUNC_END(__sm4_neon_crypt_blk1_4)
+
+.align 3
+SYM_FUNC_START(sm4_neon_crypt_blk1_8)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   w3: num blocks (1..8)
+	 */
+	cmp		w3, #5;
+	blt		__sm4_neon_crypt_blk1_4;
+
+	PREPARE;
+
+	ld1		{v0.16b-v3.16b}, [x2], #64;
+	ld1		{v4.16b}, [x2], #16;
+	mov		v5.16b, v4.16b;
+	mov		v6.16b, v4.16b;
+	mov		v7.16b, v4.16b;
+	beq		.Lblk8_load_input_done;
+	ld1		{v5.16b}, [x2], #16;
+	cmp		w3, #7;
+	blt		.Lblk8_load_input_done;
+	ld1		{v6.16b}, [x2], #16;
+	beq		.Lblk8_load_input_done;
+	ld1		{v7.16b}, [x2];
+
+.Lblk8_load_input_done:
+	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7);
+
+	cmp		w3, #6;
+	st1		{v0.16b-v3.16b}, [x1], #64;
+	st1		{v4.16b}, [x1], #16;
+	blt		.Lblk8_store_output_done;
+	st1		{v5.16b}, [x1], #16;
+	beq		.Lblk8_store_output_done;
+	st1		{v6.16b}, [x1], #16;
+	cmp		w3, #7;
+	beq		.Lblk8_store_output_done;
+	st1		{v7.16b}, [x1];
+
+.Lblk8_store_output_done:
+	ret;
+SYM_FUNC_END(sm4_neon_crypt_blk1_8)
+
+.align 3
+SYM_FUNC_START(sm4_neon_crypt_blk8)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   w3: nblocks (multiples of 8)
+	 */
+	PREPARE;
+
+.Lcrypt_loop_blk:
+	subs		w3, w3, #8;
+	bmi		.Lcrypt_end;
+
+	ld1		{v0.16b-v3.16b}, [x2], #64;
+	ld1		{v4.16b-v7.16b}, [x2], #64;
+
+	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7);
+
+	st1		{v0.16b-v3.16b}, [x1], #64;
+	st1		{v4.16b-v7.16b}, [x1], #64;
+
+	b		.Lcrypt_loop_blk;
+
+.Lcrypt_end:
+	ret;
+SYM_FUNC_END(sm4_neon_crypt_blk8)
+
+.align 3
+SYM_FUNC_START(sm4_neon_cbc_dec_blk8)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   x3: iv (big endian, 128 bit)
+	 *   w4: nblocks (multiples of 8)
+	 */
+	PREPARE;
+
+	ld1		{RIV.16b}, [x3];
+
+.Lcbc_loop_blk:
+	subs		w4, w4, #8;
+	bmi		.Lcbc_end;
+
+	ld1		{v0.16b-v3.16b}, [x2], #64;
+	ld1		{v4.16b-v7.16b}, [x2];
+
+	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7);
+
+	sub		x2, x2, #64;
+	eor		v0.16b, v0.16b, RIV.16b;
+	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
+	eor		v1.16b, v1.16b, RTMP0.16b;
+	eor		v2.16b, v2.16b, RTMP1.16b;
+	eor		v3.16b, v3.16b, RTMP2.16b;
+	st1		{v0.16b-v3.16b}, [x1], #64;
+
+	eor		v4.16b, v4.16b, RTMP3.16b;
+	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
+	eor		v5.16b, v5.16b, RTMP0.16b;
+	eor		v6.16b, v6.16b, RTMP1.16b;
+	eor		v7.16b, v7.16b, RTMP2.16b;
+
+	mov		RIV.16b, RTMP3.16b;
+	st1		{v4.16b-v7.16b}, [x1], #64;
+
+	b		.Lcbc_loop_blk;
+
+.Lcbc_end:
+	/* store new IV */
+	st1		{RIV.16b}, [x3];
+
+	ret;
+SYM_FUNC_END(sm4_neon_cbc_dec_blk8)
+
+.align 3
+SYM_FUNC_START(sm4_neon_cfb_dec_blk8)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   x3: iv (big endian, 128 bit)
+	 *   w4: nblocks (multiples of 8)
+	 */
+	PREPARE;
+
+	ld1		{v0.16b}, [x3];
+
+.Lcfb_loop_blk:
+	subs		w4, w4, #8;
+	bmi		.Lcfb_end;
+
+	ld1		{v1.16b, v2.16b, v3.16b}, [x2], #48;
+	ld1		{v4.16b-v7.16b}, [x2];
+
+	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7);
+
+	sub		x2, x2, #48;
+	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
+	eor		v0.16b, v0.16b, RTMP0.16b;
+	eor		v1.16b, v1.16b, RTMP1.16b;
+	eor		v2.16b, v2.16b, RTMP2.16b;
+	eor		v3.16b, v3.16b, RTMP3.16b;
+	st1		{v0.16b-v3.16b}, [x1], #64;
+
+	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
+	eor		v4.16b, v4.16b, RTMP0.16b;
+	eor		v5.16b, v5.16b, RTMP1.16b;
+	eor		v6.16b, v6.16b, RTMP2.16b;
+	eor		v7.16b, v7.16b, RTMP3.16b;
+	st1		{v4.16b-v7.16b}, [x1], #64;
+
+	mov		v0.16b, RTMP3.16b;
+
+	b		.Lcfb_loop_blk;
+
+.Lcfb_end:
+	/* store new IV */
+	st1		{v0.16b}, [x3];
+
+	ret;
+SYM_FUNC_END(sm4_neon_cfb_dec_blk8)
+
+.align 3
+SYM_FUNC_START(sm4_neon_ctr_enc_blk8)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   x3: ctr (big endian, 128 bit)
+	 *   w4: nblocks (multiples of 8)
+	 */
+	PREPARE;
+
+	ldp		x7, x8, [x3];
+	rev		x7, x7;
+	rev		x8, x8;
+
+.Lctr_loop_blk:
+	subs		w4, w4, #8;
+	bmi		.Lctr_end;
+
+#define inc_le128(vctr)                     \
+	mov		vctr.d[1], x8;      \
+	mov		vctr.d[0], x7;      \
+	adds		x8, x8, #1;         \
+	adc		x7, x7, xzr;        \
+	rev64		vctr.16b, vctr.16b;
+
+	/* construct CTRs */
+	inc_le128(v0);			/* +0 */
+	inc_le128(v1);			/* +1 */
+	inc_le128(v2);			/* +2 */
+	inc_le128(v3);			/* +3 */
+	inc_le128(v4);			/* +4 */
+	inc_le128(v5);			/* +5 */
+	inc_le128(v6);			/* +6 */
+	inc_le128(v7);			/* +7 */
+
+	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7);
+
+	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
+	eor		v0.16b, v0.16b, RTMP0.16b;
+	eor		v1.16b, v1.16b, RTMP1.16b;
+	eor		v2.16b, v2.16b, RTMP2.16b;
+	eor		v3.16b, v3.16b, RTMP3.16b;
+	st1		{v0.16b-v3.16b}, [x1], #64;
+
+	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
+	eor		v4.16b, v4.16b, RTMP0.16b;
+	eor		v5.16b, v5.16b, RTMP1.16b;
+	eor		v6.16b, v6.16b, RTMP2.16b;
+	eor		v7.16b, v7.16b, RTMP3.16b;
+	st1		{v4.16b-v7.16b}, [x1], #64;
+
+	b		.Lctr_loop_blk;
+
+.Lctr_end:
+	/* store new CTR */
+	rev		x7, x7;
+	rev		x8, x8;
+	stp		x7, x8, [x3];
+
+	ret;
+SYM_FUNC_END(sm4_neon_ctr_enc_blk8)
diff --git a/arch/arm64/crypto/sm4-neon-glue.c b/arch/arm64/crypto/sm4-neon-glue.c
new file mode 100644
index 000000000000..03a6a6866a31
--- /dev/null
+++ b/arch/arm64/crypto/sm4-neon-glue.c
@@ -0,0 +1,442 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SM4 Cipher Algorithm, using ARMv8 NEON
+ * as specified in
+ * https://tools.ietf.org/id/draft-ribose-cfrg-sm4-10.html
+ *
+ * Copyright (C) 2022, Alibaba Group.
+ * Copyright (C) 2022 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+ */
+
+#include <linux/module.h>
+#include <linux/crypto.h>
+#include <linux/kernel.h>
+#include <linux/cpufeature.h>
+#include <asm/neon.h>
+#include <asm/simd.h>
+#include <crypto/internal/simd.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/sm4.h>
+
+#define BYTES2BLKS(nbytes)	((nbytes) >> 4)
+#define BYTES2BLK8(nbytes)	(((nbytes) >> 4) & ~(8 - 1))
+
+asmlinkage void sm4_neon_crypt_blk1_8(const u32 *rkey, u8 *dst, const u8 *src,
+				      unsigned int nblks);
+asmlinkage void sm4_neon_crypt_blk8(const u32 *rkey, u8 *dst, const u8 *src,
+				    unsigned int nblks);
+asmlinkage void sm4_neon_cbc_dec_blk8(const u32 *rkey, u8 *dst, const u8 *src,
+				      u8 *iv, unsigned int nblks);
+asmlinkage void sm4_neon_cfb_dec_blk8(const u32 *rkey, u8 *dst, const u8 *src,
+				      u8 *iv, unsigned int nblks);
+asmlinkage void sm4_neon_ctr_enc_blk8(const u32 *rkey, u8 *dst, const u8 *src,
+				      u8 *iv, unsigned int nblks);
+
+static int sm4_setkey(struct crypto_skcipher *tfm, const u8 *key,
+		      unsigned int key_len)
+{
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	return sm4_expandkey(ctx, key, key_len);
+}
+
+static int sm4_ecb_do_crypt(struct skcipher_request *req, const u32 *rkey)
+{
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	while ((nbytes = walk.nbytes) > 0) {
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+		unsigned int nblks;
+
+		kernel_neon_begin();
+
+		nblks = BYTES2BLK8(nbytes);
+		if (nblks) {
+			sm4_neon_crypt_blk8(rkey, dst, src, nblks);
+			dst += nblks * SM4_BLOCK_SIZE;
+			src += nblks * SM4_BLOCK_SIZE;
+			nbytes -= nblks * SM4_BLOCK_SIZE;
+		}
+
+		nblks = BYTES2BLKS(nbytes);
+		if (nblks) {
+			sm4_neon_crypt_blk1_8(rkey, dst, src, nblks);
+			nbytes -= nblks * SM4_BLOCK_SIZE;
+		}
+
+		kernel_neon_end();
+
+		err = skcipher_walk_done(&walk, nbytes);
+	}
+
+	return err;
+}
+
+static int sm4_ecb_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	return sm4_ecb_do_crypt(req, ctx->rkey_enc);
+}
+
+static int sm4_ecb_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	return sm4_ecb_do_crypt(req, ctx->rkey_dec);
+}
+
+static int sm4_cbc_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	while ((nbytes = walk.nbytes) > 0) {
+		const u8 *iv = walk.iv;
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+
+		while (nbytes >= SM4_BLOCK_SIZE) {
+			crypto_xor_cpy(dst, src, iv, SM4_BLOCK_SIZE);
+			sm4_crypt_block(ctx->rkey_enc, dst, dst);
+			iv = dst;
+			src += SM4_BLOCK_SIZE;
+			dst += SM4_BLOCK_SIZE;
+			nbytes -= SM4_BLOCK_SIZE;
+		}
+		if (iv != walk.iv)
+			memcpy(walk.iv, iv, SM4_BLOCK_SIZE);
+
+		err = skcipher_walk_done(&walk, nbytes);
+	}
+
+	return err;
+}
+
+static int sm4_cbc_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	while ((nbytes = walk.nbytes) > 0) {
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+		unsigned int nblks;
+
+		kernel_neon_begin();
+
+		nblks = BYTES2BLK8(nbytes);
+		if (nblks) {
+			sm4_neon_cbc_dec_blk8(ctx->rkey_dec, dst, src,
+					walk.iv, nblks);
+			dst += nblks * SM4_BLOCK_SIZE;
+			src += nblks * SM4_BLOCK_SIZE;
+			nbytes -= nblks * SM4_BLOCK_SIZE;
+		}
+
+		nblks = BYTES2BLKS(nbytes);
+		if (nblks) {
+			u8 keystream[SM4_BLOCK_SIZE * 8];
+			u8 iv[SM4_BLOCK_SIZE];
+			int i;
+
+			sm4_neon_crypt_blk1_8(ctx->rkey_dec, keystream,
+					src, nblks);
+
+			src += ((int)nblks - 2) * SM4_BLOCK_SIZE;
+			dst += (nblks - 1) * SM4_BLOCK_SIZE;
+			memcpy(iv, src + SM4_BLOCK_SIZE, SM4_BLOCK_SIZE);
+
+			for (i = nblks - 1; i > 0; i--) {
+				crypto_xor_cpy(dst, src,
+					&keystream[i * SM4_BLOCK_SIZE],
+					SM4_BLOCK_SIZE);
+				src -= SM4_BLOCK_SIZE;
+				dst -= SM4_BLOCK_SIZE;
+			}
+			crypto_xor_cpy(dst, walk.iv,
+					keystream, SM4_BLOCK_SIZE);
+			memcpy(walk.iv, iv, SM4_BLOCK_SIZE);
+			nbytes -= nblks * SM4_BLOCK_SIZE;
+		}
+
+		kernel_neon_end();
+
+		err = skcipher_walk_done(&walk, nbytes);
+	}
+
+	return err;
+}
+
+static int sm4_cfb_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	while ((nbytes = walk.nbytes) > 0) {
+		u8 keystream[SM4_BLOCK_SIZE];
+		const u8 *iv = walk.iv;
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+
+		while (nbytes >= SM4_BLOCK_SIZE) {
+			sm4_crypt_block(ctx->rkey_enc, keystream, iv);
+			crypto_xor_cpy(dst, src, keystream, SM4_BLOCK_SIZE);
+			iv = dst;
+			src += SM4_BLOCK_SIZE;
+			dst += SM4_BLOCK_SIZE;
+			nbytes -= SM4_BLOCK_SIZE;
+		}
+		if (iv != walk.iv)
+			memcpy(walk.iv, iv, SM4_BLOCK_SIZE);
+
+		/* tail */
+		if (walk.nbytes == walk.total && nbytes > 0) {
+			sm4_crypt_block(ctx->rkey_enc, keystream, walk.iv);
+			crypto_xor_cpy(dst, src, keystream, nbytes);
+			nbytes = 0;
+		}
+
+		err = skcipher_walk_done(&walk, nbytes);
+	}
+
+	return err;
+}
+
+static int sm4_cfb_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	while ((nbytes = walk.nbytes) > 0) {
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+		unsigned int nblks;
+
+		kernel_neon_begin();
+
+		nblks = BYTES2BLK8(nbytes);
+		if (nblks) {
+			sm4_neon_cfb_dec_blk8(ctx->rkey_enc, dst, src,
+					walk.iv, nblks);
+			dst += nblks * SM4_BLOCK_SIZE;
+			src += nblks * SM4_BLOCK_SIZE;
+			nbytes -= nblks * SM4_BLOCK_SIZE;
+		}
+
+		nblks = BYTES2BLKS(nbytes);
+		if (nblks) {
+			u8 keystream[SM4_BLOCK_SIZE * 8];
+
+			memcpy(keystream, walk.iv, SM4_BLOCK_SIZE);
+			if (nblks > 1)
+				memcpy(&keystream[SM4_BLOCK_SIZE], src,
+					(nblks - 1) * SM4_BLOCK_SIZE);
+			memcpy(walk.iv, src + (nblks - 1) * SM4_BLOCK_SIZE,
+				SM4_BLOCK_SIZE);
+
+			sm4_neon_crypt_blk1_8(ctx->rkey_enc, keystream,
+					keystream, nblks);
+
+			crypto_xor_cpy(dst, src, keystream,
+					nblks * SM4_BLOCK_SIZE);
+			dst += nblks * SM4_BLOCK_SIZE;
+			src += nblks * SM4_BLOCK_SIZE;
+			nbytes -= nblks * SM4_BLOCK_SIZE;
+		}
+
+		kernel_neon_end();
+
+		/* tail */
+		if (walk.nbytes == walk.total && nbytes > 0) {
+			u8 keystream[SM4_BLOCK_SIZE];
+
+			sm4_crypt_block(ctx->rkey_enc, keystream, walk.iv);
+			crypto_xor_cpy(dst, src, keystream, nbytes);
+			nbytes = 0;
+		}
+
+		err = skcipher_walk_done(&walk, nbytes);
+	}
+
+	return err;
+}
+
+static int sm4_ctr_crypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	while ((nbytes = walk.nbytes) > 0) {
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+		unsigned int nblks;
+
+		kernel_neon_begin();
+
+		nblks = BYTES2BLK8(nbytes);
+		if (nblks) {
+			sm4_neon_ctr_enc_blk8(ctx->rkey_enc, dst, src,
+					walk.iv, nblks);
+			dst += nblks * SM4_BLOCK_SIZE;
+			src += nblks * SM4_BLOCK_SIZE;
+			nbytes -= nblks * SM4_BLOCK_SIZE;
+		}
+
+		nblks = BYTES2BLKS(nbytes);
+		if (nblks) {
+			u8 keystream[SM4_BLOCK_SIZE * 8];
+			int i;
+
+			for (i = 0; i < nblks; i++) {
+				memcpy(&keystream[i * SM4_BLOCK_SIZE],
+					walk.iv, SM4_BLOCK_SIZE);
+				crypto_inc(walk.iv, SM4_BLOCK_SIZE);
+			}
+			sm4_neon_crypt_blk1_8(ctx->rkey_enc, keystream,
+					keystream, nblks);
+
+			crypto_xor_cpy(dst, src, keystream,
+					nblks * SM4_BLOCK_SIZE);
+			dst += nblks * SM4_BLOCK_SIZE;
+			src += nblks * SM4_BLOCK_SIZE;
+			nbytes -= nblks * SM4_BLOCK_SIZE;
+		}
+
+		kernel_neon_end();
+
+		/* tail */
+		if (walk.nbytes == walk.total && nbytes > 0) {
+			u8 keystream[SM4_BLOCK_SIZE];
+
+			sm4_crypt_block(ctx->rkey_enc, keystream, walk.iv);
+			crypto_inc(walk.iv, SM4_BLOCK_SIZE);
+			crypto_xor_cpy(dst, src, keystream, nbytes);
+			nbytes = 0;
+		}
+
+		err = skcipher_walk_done(&walk, nbytes);
+	}
+
+	return err;
+}
+
+static struct skcipher_alg sm4_algs[] = {
+	{
+		.base = {
+			.cra_name		= "ecb(sm4)",
+			.cra_driver_name	= "ecb-sm4-neon",
+			.cra_priority		= 200,
+			.cra_blocksize		= SM4_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct sm4_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= SM4_KEY_SIZE,
+		.max_keysize	= SM4_KEY_SIZE,
+		.setkey		= sm4_setkey,
+		.encrypt	= sm4_ecb_encrypt,
+		.decrypt	= sm4_ecb_decrypt,
+	}, {
+		.base = {
+			.cra_name		= "cbc(sm4)",
+			.cra_driver_name	= "cbc-sm4-neon",
+			.cra_priority		= 200,
+			.cra_blocksize		= SM4_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct sm4_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= SM4_KEY_SIZE,
+		.max_keysize	= SM4_KEY_SIZE,
+		.ivsize		= SM4_BLOCK_SIZE,
+		.setkey		= sm4_setkey,
+		.encrypt	= sm4_cbc_encrypt,
+		.decrypt	= sm4_cbc_decrypt,
+	}, {
+		.base = {
+			.cra_name		= "cfb(sm4)",
+			.cra_driver_name	= "cfb-sm4-neon",
+			.cra_priority		= 200,
+			.cra_blocksize		= 1,
+			.cra_ctxsize		= sizeof(struct sm4_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= SM4_KEY_SIZE,
+		.max_keysize	= SM4_KEY_SIZE,
+		.ivsize		= SM4_BLOCK_SIZE,
+		.chunksize	= SM4_BLOCK_SIZE,
+		.setkey		= sm4_setkey,
+		.encrypt	= sm4_cfb_encrypt,
+		.decrypt	= sm4_cfb_decrypt,
+	}, {
+		.base = {
+			.cra_name		= "ctr(sm4)",
+			.cra_driver_name	= "ctr-sm4-neon",
+			.cra_priority		= 200,
+			.cra_blocksize		= 1,
+			.cra_ctxsize		= sizeof(struct sm4_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= SM4_KEY_SIZE,
+		.max_keysize	= SM4_KEY_SIZE,
+		.ivsize		= SM4_BLOCK_SIZE,
+		.chunksize	= SM4_BLOCK_SIZE,
+		.setkey		= sm4_setkey,
+		.encrypt	= sm4_ctr_crypt,
+		.decrypt	= sm4_ctr_crypt,
+	}
+};
+
+static int __init sm4_init(void)
+{
+	return crypto_register_skciphers(sm4_algs, ARRAY_SIZE(sm4_algs));
+}
+
+static void __exit sm4_exit(void)
+{
+	crypto_unregister_skciphers(sm4_algs, ARRAY_SIZE(sm4_algs));
+}
+
+module_init(sm4_init);
+module_exit(sm4_exit);
+
+MODULE_DESCRIPTION("SM4 ECB/CBC/CFB/CTR using ARMv8 NEON");
+MODULE_ALIAS_CRYPTO("sm4-neon");
+MODULE_ALIAS_CRYPTO("sm4");
+MODULE_ALIAS_CRYPTO("ecb(sm4)");
+MODULE_ALIAS_CRYPTO("cbc(sm4)");
+MODULE_ALIAS_CRYPTO("cfb(sm4)");
+MODULE_ALIAS_CRYPTO("ctr(sm4)");
+MODULE_AUTHOR("Tianjia Zhang <tianjia.zhang@linux.alibaba.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.24.3 (Apple Git-128)

