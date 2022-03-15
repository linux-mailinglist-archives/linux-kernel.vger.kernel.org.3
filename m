Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3F34D97FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346800AbiCOJqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346781AbiCOJqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:46:23 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD23F4F441;
        Tue, 15 Mar 2022 02:45:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0V7H-CxG_1647337504;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V7H-CxG_1647337504)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Mar 2022 17:45:05 +0800
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
Subject: [PATCH 4/4] crypto: arm64/sm4 - add ARMv8 Crypto Extensions implementation
Date:   Tue, 15 Mar 2022 17:44:54 +0800
Message-Id: <20220315094454.45269-5-tianjia.zhang@linux.alibaba.com>
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

This adds ARMv8 implementations of SM4 in ECB, CBC, CFB and CTR
modes using Crypto Extensions, also includes key expansion operations
because the Crypto Extensions instruction is much faster than software
implementations.

The Crypto Extensions for SM4 can only run on ARMv8 implementations
that have support for these optional extensions.

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
sm4-ce-cipher
    ECB enc | 336.79   587.13   682.70   747.37   803.75   811.52   818.06
    ECB dec | 339.18   584.52   679.72   743.68   798.82   803.83   811.54
    CBC enc | 316.63   521.47   597.00   647.14   690.82   695.21   700.55
    CBC dec | 291.80   503.79   585.66   640.82   689.86   695.16   701.72
    CFB enc | 294.79   482.31   552.13   594.71   631.60   628.91   638.92
    CFB dec | 293.09   466.44   526.56   563.17   594.41   592.26   601.97
    CTR enc | 309.61   506.13   576.86   620.47   656.38   654.51   665.10
    CTR dec | 306.69   505.57   576.84   620.18   657.09   654.52   665.32
sm4-ce
    ECB enc | 366.96  1329.81  2024.29  2755.50  3790.07  3861.91  4051.40
    ECB dec | 367.30  1323.93  2018.72  2747.43  3787.39  3862.55  4052.62
    CBC enc | 358.09   682.68   807.24   885.35   958.29   963.60   973.73
    CBC dec | 366.51  1303.63  1978.64  2667.93  3624.53  3683.41  3856.08
    CFB enc | 351.51   681.26   807.81   893.10   968.54   969.17   985.83
    CFB dec | 354.98  1266.61  1929.63  2634.81  3614.23  3611.59  3841.68
    CTR enc | 324.23  1121.25  1689.44  2256.70  2981.90  3007.79  3060.74
    CTR dec | 324.18  1120.44  1694.31  2258.32  2982.01  3010.09  3060.99

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/arm64/crypto/Kconfig       |   6 +
 arch/arm64/crypto/Makefile      |   3 +
 arch/arm64/crypto/sm4-ce-core.S | 660 ++++++++++++++++++++++++++++++++
 arch/arm64/crypto/sm4-ce-glue.c | 372 ++++++++++++++++++
 4 files changed, 1041 insertions(+)
 create mode 100644 arch/arm64/crypto/sm4-ce-core.S
 create mode 100644 arch/arm64/crypto/sm4-ce-glue.c

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 4cffab846936..03367bd5cdfe 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -53,6 +53,12 @@ config CRYPTO_SM4_ARM64_CE
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_SM4
 
+config CRYPTO_SM4_ARM64_CE_BLK
+	tristate "SM4 in ECB/CBC/CFB/CTR modes using ARMv8 Crypto Extensions"
+	depends on KERNEL_MODE_NEON
+	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_SM4
+
 config CRYPTO_SM4_ARM64_NEON_BLK
 	tristate "SM4 in ECB/CBC/CFB/CTR modes using NEON instructions"
 	depends on KERNEL_MODE_NEON
diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index 41aee6103e78..bea8995133b1 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -23,6 +23,9 @@ sm3-ce-y := sm3-ce-glue.o sm3-ce-core.o
 obj-$(CONFIG_CRYPTO_SM4_ARM64_CE) += sm4-ce-cipher.o
 sm4-ce-cipher-y := sm4-ce-cipher-glue.o sm4-ce-cipher-core.o
 
+obj-$(CONFIG_CRYPTO_SM4_ARM64_CE_BLK) += sm4-ce.o
+sm4-ce-y := sm4-ce-glue.o sm4-ce-core.o
+
 obj-$(CONFIG_CRYPTO_SM4_ARM64_NEON_BLK) += sm4-neon.o
 sm4-neon-y := sm4-neon-glue.o sm4-neon-core.o
 
diff --git a/arch/arm64/crypto/sm4-ce-core.S b/arch/arm64/crypto/sm4-ce-core.S
new file mode 100644
index 000000000000..934e0f093279
--- /dev/null
+++ b/arch/arm64/crypto/sm4-ce-core.S
@@ -0,0 +1,660 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SM4 Cipher Algorithm for ARMv8 with Crypto Extensions
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
+.arch	armv8-a+crypto
+
+.irp b, 0, 1, 2, 3, 4, 5, 6, 7, 16, 20, 24, 25, 26, 27, 28, 29, 30, 31
+	.set .Lv\b\().4s, \b
+.endr
+
+.macro sm4e, vd, vn
+	.inst 0xcec08400 | (.L\vn << 5) | .L\vd
+.endm
+
+.macro sm4ekey, vd, vn, vm
+	.inst 0xce60c800 | (.L\vm << 16) | (.L\vn << 5) | .L\vd
+.endm
+
+/* Register macros */
+
+#define RTMP0	v16
+#define RTMP1	v17
+#define RTMP2	v18
+#define RTMP3	v19
+
+#define RIV	v20
+
+/* Helper macros. */
+
+#define PREPARE                                       \
+	ld1		{v24.16b-v27.16b}, [x0], #64; \
+	ld1		{v28.16b-v31.16b}, [x0];
+
+#define SM4_CRYPT_BLK(b0)                           \
+	rev32		b0.16b, b0.16b;             \
+	sm4e		b0.4s, v24.4s;              \
+	sm4e		b0.4s, v25.4s;              \
+	sm4e		b0.4s, v26.4s;              \
+	sm4e		b0.4s, v27.4s;              \
+	sm4e		b0.4s, v28.4s;              \
+	sm4e		b0.4s, v29.4s;              \
+	sm4e		b0.4s, v30.4s;              \
+	sm4e		b0.4s, v31.4s;              \
+	rev64		b0.4s, b0.4s;               \
+	ext		b0.16b, b0.16b, b0.16b, #8; \
+	rev32		b0.16b, b0.16b;
+
+#define SM4_CRYPT_BLK4(b0, b1, b2, b3)              \
+	rev32		b0.16b, b0.16b;             \
+	rev32		b1.16b, b1.16b;             \
+	rev32		b2.16b, b2.16b;             \
+	rev32		b3.16b, b3.16b;             \
+	sm4e		b0.4s, v24.4s;              \
+	sm4e		b1.4s, v24.4s;              \
+	sm4e		b2.4s, v24.4s;              \
+	sm4e		b3.4s, v24.4s;              \
+	sm4e		b0.4s, v25.4s;              \
+	sm4e		b1.4s, v25.4s;              \
+	sm4e		b2.4s, v25.4s;              \
+	sm4e		b3.4s, v25.4s;              \
+	sm4e		b0.4s, v26.4s;              \
+	sm4e		b1.4s, v26.4s;              \
+	sm4e		b2.4s, v26.4s;              \
+	sm4e		b3.4s, v26.4s;              \
+	sm4e		b0.4s, v27.4s;              \
+	sm4e		b1.4s, v27.4s;              \
+	sm4e		b2.4s, v27.4s;              \
+	sm4e		b3.4s, v27.4s;              \
+	sm4e		b0.4s, v28.4s;              \
+	sm4e		b1.4s, v28.4s;              \
+	sm4e		b2.4s, v28.4s;              \
+	sm4e		b3.4s, v28.4s;              \
+	sm4e		b0.4s, v29.4s;              \
+	sm4e		b1.4s, v29.4s;              \
+	sm4e		b2.4s, v29.4s;              \
+	sm4e		b3.4s, v29.4s;              \
+	sm4e		b0.4s, v30.4s;              \
+	sm4e		b1.4s, v30.4s;              \
+	sm4e		b2.4s, v30.4s;              \
+	sm4e		b3.4s, v30.4s;              \
+	sm4e		b0.4s, v31.4s;              \
+	sm4e		b1.4s, v31.4s;              \
+	sm4e		b2.4s, v31.4s;              \
+	sm4e		b3.4s, v31.4s;              \
+	rev64		b0.4s, b0.4s;               \
+	rev64		b1.4s, b1.4s;               \
+	rev64		b2.4s, b2.4s;               \
+	rev64		b3.4s, b3.4s;               \
+	ext		b0.16b, b0.16b, b0.16b, #8; \
+	ext		b1.16b, b1.16b, b1.16b, #8; \
+	ext		b2.16b, b2.16b, b2.16b, #8; \
+	ext		b3.16b, b3.16b, b3.16b, #8; \
+	rev32		b0.16b, b0.16b;             \
+	rev32		b1.16b, b1.16b;             \
+	rev32		b2.16b, b2.16b;             \
+	rev32		b3.16b, b3.16b;
+
+#define SM4_CRYPT_BLK8(b0, b1, b2, b3, b4, b5, b6, b7) \
+	rev32		b0.16b, b0.16b;             \
+	rev32		b1.16b, b1.16b;             \
+	rev32		b2.16b, b2.16b;             \
+	rev32		b3.16b, b3.16b;             \
+	rev32		b4.16b, b4.16b;             \
+	rev32		b5.16b, b5.16b;             \
+	rev32		b6.16b, b6.16b;             \
+	rev32		b7.16b, b7.16b;             \
+	sm4e		b0.4s, v24.4s;              \
+	sm4e		b1.4s, v24.4s;              \
+	sm4e		b2.4s, v24.4s;              \
+	sm4e		b3.4s, v24.4s;              \
+	sm4e		b4.4s, v24.4s;              \
+	sm4e		b5.4s, v24.4s;              \
+	sm4e		b6.4s, v24.4s;              \
+	sm4e		b7.4s, v24.4s;              \
+	sm4e		b0.4s, v25.4s;              \
+	sm4e		b1.4s, v25.4s;              \
+	sm4e		b2.4s, v25.4s;              \
+	sm4e		b3.4s, v25.4s;              \
+	sm4e		b4.4s, v25.4s;              \
+	sm4e		b5.4s, v25.4s;              \
+	sm4e		b6.4s, v25.4s;              \
+	sm4e		b7.4s, v25.4s;              \
+	sm4e		b0.4s, v26.4s;              \
+	sm4e		b1.4s, v26.4s;              \
+	sm4e		b2.4s, v26.4s;              \
+	sm4e		b3.4s, v26.4s;              \
+	sm4e		b4.4s, v26.4s;              \
+	sm4e		b5.4s, v26.4s;              \
+	sm4e		b6.4s, v26.4s;              \
+	sm4e		b7.4s, v26.4s;              \
+	sm4e		b0.4s, v27.4s;              \
+	sm4e		b1.4s, v27.4s;              \
+	sm4e		b2.4s, v27.4s;              \
+	sm4e		b3.4s, v27.4s;              \
+	sm4e		b4.4s, v27.4s;              \
+	sm4e		b5.4s, v27.4s;              \
+	sm4e		b6.4s, v27.4s;              \
+	sm4e		b7.4s, v27.4s;              \
+	sm4e		b0.4s, v28.4s;              \
+	sm4e		b1.4s, v28.4s;              \
+	sm4e		b2.4s, v28.4s;              \
+	sm4e		b3.4s, v28.4s;              \
+	sm4e		b4.4s, v28.4s;              \
+	sm4e		b5.4s, v28.4s;              \
+	sm4e		b6.4s, v28.4s;              \
+	sm4e		b7.4s, v28.4s;              \
+	sm4e		b0.4s, v29.4s;              \
+	sm4e		b1.4s, v29.4s;              \
+	sm4e		b2.4s, v29.4s;              \
+	sm4e		b3.4s, v29.4s;              \
+	sm4e		b4.4s, v29.4s;              \
+	sm4e		b5.4s, v29.4s;              \
+	sm4e		b6.4s, v29.4s;              \
+	sm4e		b7.4s, v29.4s;              \
+	sm4e		b0.4s, v30.4s;              \
+	sm4e		b1.4s, v30.4s;              \
+	sm4e		b2.4s, v30.4s;              \
+	sm4e		b3.4s, v30.4s;              \
+	sm4e		b4.4s, v30.4s;              \
+	sm4e		b5.4s, v30.4s;              \
+	sm4e		b6.4s, v30.4s;              \
+	sm4e		b7.4s, v30.4s;              \
+	sm4e		b0.4s, v31.4s;              \
+	sm4e		b1.4s, v31.4s;              \
+	sm4e		b2.4s, v31.4s;              \
+	sm4e		b3.4s, v31.4s;              \
+	sm4e		b4.4s, v31.4s;              \
+	sm4e		b5.4s, v31.4s;              \
+	sm4e		b6.4s, v31.4s;              \
+	sm4e		b7.4s, v31.4s;              \
+	rev64		b0.4s, b0.4s;               \
+	rev64		b1.4s, b1.4s;               \
+	rev64		b2.4s, b2.4s;               \
+	rev64		b3.4s, b3.4s;               \
+	rev64		b4.4s, b4.4s;               \
+	rev64		b5.4s, b5.4s;               \
+	rev64		b6.4s, b6.4s;               \
+	rev64		b7.4s, b7.4s;               \
+	ext		b0.16b, b0.16b, b0.16b, #8; \
+	ext		b1.16b, b1.16b, b1.16b, #8; \
+	ext		b2.16b, b2.16b, b2.16b, #8; \
+	ext		b3.16b, b3.16b, b3.16b, #8; \
+	ext		b4.16b, b4.16b, b4.16b, #8; \
+	ext		b5.16b, b5.16b, b5.16b, #8; \
+	ext		b6.16b, b6.16b, b6.16b, #8; \
+	ext		b7.16b, b7.16b, b7.16b, #8; \
+	rev32		b0.16b, b0.16b;             \
+	rev32		b1.16b, b1.16b;             \
+	rev32		b2.16b, b2.16b;             \
+	rev32		b3.16b, b3.16b;             \
+	rev32		b4.16b, b4.16b;             \
+	rev32		b5.16b, b5.16b;             \
+	rev32		b6.16b, b6.16b;             \
+	rev32		b7.16b, b7.16b;
+
+
+.align 3
+SYM_FUNC_START(sm4_ce_expand_key)
+	/* input:
+	 *   x0: 128-bit key
+	 *   x1: rkey_enc
+	 *   x2: rkey_dec
+	 *   x3: fk array
+	 *   x4: ck array
+	 */
+	ld1		{v0.16b}, [x0];
+	rev32		v0.16b, v0.16b;
+	ld1		{v1.16b}, [x3];
+	/* load ck */
+	ld1		{v24.16b-v27.16b}, [x4], #64;
+	ld1		{v28.16b-v31.16b}, [x4];
+
+	/* input ^ fk */
+	eor		v0.16b, v0.16b, v1.16b;
+
+	sm4ekey		v0.4s, v0.4s, v24.4s;
+	sm4ekey		v1.4s, v0.4s, v25.4s;
+	sm4ekey		v2.4s, v1.4s, v26.4s;
+	sm4ekey		v3.4s, v2.4s, v27.4s;
+	sm4ekey		v4.4s, v3.4s, v28.4s;
+	sm4ekey		v5.4s, v4.4s, v29.4s;
+	sm4ekey		v6.4s, v5.4s, v30.4s;
+	sm4ekey		v7.4s, v6.4s, v31.4s;
+
+	st1		{v0.16b-v3.16b}, [x1], #64;
+	st1		{v4.16b-v7.16b}, [x1];
+	rev64		v7.4s, v7.4s;
+	rev64		v6.4s, v6.4s;
+	rev64		v5.4s, v5.4s;
+	rev64		v4.4s, v4.4s;
+	rev64		v3.4s, v3.4s;
+	rev64		v2.4s, v2.4s;
+	rev64		v1.4s, v1.4s;
+	rev64		v0.4s, v0.4s;
+	ext		v7.16b, v7.16b, v7.16b, #8;
+	ext		v6.16b, v6.16b, v6.16b, #8;
+	ext		v5.16b, v5.16b, v5.16b, #8;
+	ext		v4.16b, v4.16b, v4.16b, #8;
+	ext		v3.16b, v3.16b, v3.16b, #8;
+	ext		v2.16b, v2.16b, v2.16b, #8;
+	ext		v1.16b, v1.16b, v1.16b, #8;
+	ext		v0.16b, v0.16b, v0.16b, #8;
+	st1		{v7.16b}, [x2], #16;
+	st1		{v6.16b}, [x2], #16;
+	st1		{v5.16b}, [x2], #16;
+	st1		{v4.16b}, [x2], #16;
+	st1		{v3.16b}, [x2], #16;
+	st1		{v2.16b}, [x2], #16;
+	st1		{v1.16b}, [x2], #16;
+	st1		{v0.16b}, [x2];
+
+	ret;
+SYM_FUNC_END(sm4_ce_expand_key)
+
+.align 3
+SYM_FUNC_START(sm4_ce_crypt_block)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 */
+	PREPARE;
+
+	ld1		{v0.16b}, [x2];
+	SM4_CRYPT_BLK(v0);
+	st1		{v0.16b}, [x1];
+
+	ret;
+SYM_FUNC_END(sm4_ce_crypt_block)
+
+.align 3
+SYM_FUNC_START(sm4_ce_crypt)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   w3: nblocks
+	 */
+	PREPARE;
+
+.Lcrypt_loop_blk:
+	sub		w3, w3, #8;
+	tbnz		w3, #31, .Lcrypt_tail8;
+
+	ld1		{v0.16b-v3.16b}, [x2], #64;
+	ld1		{v4.16b-v7.16b}, [x2], #64;
+
+	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7);
+
+	st1		{v0.16b-v3.16b}, [x1], #64;
+	st1		{v4.16b-v7.16b}, [x1], #64;
+
+	cbz		w3, .Lcrypt_end;
+	b		.Lcrypt_loop_blk;
+
+.Lcrypt_tail8:
+	add		w3, w3, #8;
+	cmp		w3, #4;
+	blt		.Lcrypt_tail4;
+
+	sub		w3, w3, #4;
+
+	ld1		{v0.16b-v3.16b}, [x2], #64;
+	SM4_CRYPT_BLK4(v0, v1, v2, v3);
+	st1		{v0.16b-v3.16b}, [x1], #64;
+
+	cbz		w3, .Lcrypt_end;
+
+.Lcrypt_tail4:
+	sub		w3, w3, #1;
+
+	ld1		{v0.16b}, [x2], #16;
+	SM4_CRYPT_BLK(v0);
+	st1		{v0.16b}, [x1], #16;
+
+	cbnz		w3, .Lcrypt_tail4;
+
+.Lcrypt_end:
+	ret;
+SYM_FUNC_END(sm4_ce_crypt)
+
+.align 3
+SYM_FUNC_START(sm4_ce_cbc_enc)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   x3: iv (big endian, 128 bit)
+	 *   w4: nblocks
+	 */
+	PREPARE;
+
+	ld1		{RIV.16b}, [x3];
+
+.Lcbc_enc_loop:
+	sub		w4, w4, #1;
+
+	ld1		{RTMP0.16b}, [x2], #16;
+	eor		RIV.16b, RIV.16b, RTMP0.16b;
+
+	SM4_CRYPT_BLK(RIV);
+
+	st1		{RIV.16b}, [x1], #16;
+
+	cbnz		w4, .Lcbc_enc_loop;
+
+	/* store new IV */
+	st1		{RIV.16b}, [x3];
+
+	ret;
+SYM_FUNC_END(sm4_ce_cbc_enc)
+
+.align 3
+SYM_FUNC_START(sm4_ce_cbc_dec)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   x3: iv (big endian, 128 bit)
+	 *   w4: nblocks
+	 */
+	PREPARE;
+
+	ld1		{RIV.16b}, [x3];
+
+.Lcbc_loop_blk:
+	sub		w4, w4, #8;
+	tbnz		w4, #31, .Lcbc_tail8;
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
+	cbz		w4, .Lcbc_end;
+	b		.Lcbc_loop_blk;
+
+.Lcbc_tail8:
+	add		w4, w4, #8;
+	cmp		w4, #4;
+	blt		.Lcbc_tail4;
+
+	sub		w4, w4, #4;
+
+	ld1		{v0.16b-v3.16b}, [x2];
+
+	SM4_CRYPT_BLK4(v0, v1, v2, v3);
+
+	eor		v0.16b, v0.16b, RIV.16b;
+	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
+	eor		v1.16b, v1.16b, RTMP0.16b;
+	eor		v2.16b, v2.16b, RTMP1.16b;
+	eor		v3.16b, v3.16b, RTMP2.16b;
+
+	mov		RIV.16b, RTMP3.16b;
+	st1		{v0.16b-v3.16b}, [x1], #64;
+
+	cbz		w4, .Lcbc_end;
+
+.Lcbc_tail4:
+	sub		w4, w4, #1;
+
+	ld1		{v0.16b}, [x2];
+
+	SM4_CRYPT_BLK(v0);
+
+	eor		v0.16b, v0.16b, RIV.16b;
+	ld1		{RIV.16b}, [x2], #16;
+	st1		{v0.16b}, [x1], #16;
+
+	cbnz		w4, .Lcbc_tail4;
+
+.Lcbc_end:
+	/* store new IV */
+	st1		{RIV.16b}, [x3];
+
+	ret;
+SYM_FUNC_END(sm4_ce_cbc_dec)
+
+.align 3
+SYM_FUNC_START(sm4_ce_cfb_enc)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   x3: iv (big endian, 128 bit)
+	 *   w4: nblocks
+	 */
+	PREPARE;
+
+	ld1		{RIV.16b}, [x3];
+
+.Lcfb_enc_loop:
+	sub		w4, w4, #1;
+
+	SM4_CRYPT_BLK(RIV);
+
+	ld1		{RTMP0.16b}, [x2], #16;
+	eor		RIV.16b, RIV.16b, RTMP0.16b;
+	st1		{RIV.16b}, [x1], #16;
+
+	cbnz		w4, .Lcfb_enc_loop;
+
+	/* store new IV */
+	st1		{RIV.16b}, [x3];
+
+	ret;
+SYM_FUNC_END(sm4_ce_cfb_enc)
+
+.align 3
+SYM_FUNC_START(sm4_ce_cfb_dec)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   x3: iv (big endian, 128 bit)
+	 *   w4: nblocks
+	 */
+	PREPARE;
+
+	ld1		{v0.16b}, [x3];
+
+.Lcfb_loop_blk:
+	sub		w4, w4, #8;
+	tbnz		w4, #31, .Lcfb_tail8;
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
+	cbz		w4, .Lcfb_end;
+	b		.Lcfb_loop_blk;
+
+.Lcfb_tail8:
+	add		w4, w4, #8;
+	cmp		w4, #4;
+	blt		.Lcfb_tail4;
+
+	sub		w4, w4, #4;
+
+	ld1		{v1.16b, v2.16b, v3.16b}, [x2];
+
+	SM4_CRYPT_BLK4(v0, v1, v2, v3);
+
+	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
+	eor		v0.16b, v0.16b, RTMP0.16b;
+	eor		v1.16b, v1.16b, RTMP1.16b;
+	eor		v2.16b, v2.16b, RTMP2.16b;
+	eor		v3.16b, v3.16b, RTMP3.16b;
+	st1		{v0.16b-v3.16b}, [x1], #64;
+
+	mov		v0.16b, RTMP3.16b;
+
+	cbz		w4, .Lcfb_end;
+
+.Lcfb_tail4:
+	sub		w4, w4, #1;
+
+	SM4_CRYPT_BLK(v0);
+
+	ld1		{RTMP0.16b}, [x2], #16;
+	eor		v0.16b, v0.16b, RTMP0.16b;
+	st1		{v0.16b}, [x1], #16;
+
+	mov		v0.16b, RTMP0.16b;
+
+	cbnz		w4, .Lcfb_tail4;
+
+.Lcfb_end:
+	/* store new IV */
+	st1		{v0.16b}, [x3];
+
+	ret;
+SYM_FUNC_END(sm4_ce_cfb_dec)
+
+.align 3
+SYM_FUNC_START(sm4_ce_ctr_enc)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   x3: ctr (big endian, 128 bit)
+	 *   w4: nblocks
+	 */
+	PREPARE;
+
+	ldp		x7, x8, [x3];
+	rev		x7, x7;
+	rev		x8, x8;
+
+.Lctr_loop_blk:
+	sub		w4, w4, #8;
+	tbnz		w4, #31, .Lctr_tail8;
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
+	cbz		w4, .Lctr_end;
+	b		.Lctr_loop_blk;
+
+.Lctr_tail8:
+	add		w4, w4, #8;
+	cmp		w4, #4;
+	blt		.Lctr_tail4;
+
+	sub		w4, w4, #4;
+
+	/* construct CTRs */
+	inc_le128(v0);			/* +0 */
+	inc_le128(v1);			/* +1 */
+	inc_le128(v2);			/* +2 */
+	inc_le128(v3);			/* +3 */
+
+	SM4_CRYPT_BLK4(v0, v1, v2, v3);
+
+	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
+	eor		v0.16b, v0.16b, RTMP0.16b;
+	eor		v1.16b, v1.16b, RTMP1.16b;
+	eor		v2.16b, v2.16b, RTMP2.16b;
+	eor		v3.16b, v3.16b, RTMP3.16b;
+	st1		{v0.16b-v3.16b}, [x1], #64;
+
+	cbz		w4, .Lctr_end;
+
+.Lctr_tail4:
+	sub		w4, w4, #1;
+
+	/* construct CTRs */
+	inc_le128(v0);
+
+	SM4_CRYPT_BLK(v0);
+
+	ld1		{RTMP0.16b}, [x2], #16;
+	eor		v0.16b, v0.16b, RTMP0.16b;
+	st1		{v0.16b}, [x1], #16;
+
+	cbnz		w4, .Lctr_tail4;
+
+.Lctr_end:
+	/* store new CTR */
+	rev		x7, x7;
+	rev		x8, x8;
+	stp		x7, x8, [x3];
+
+	ret;
+SYM_FUNC_END(sm4_ce_ctr_enc)
diff --git a/arch/arm64/crypto/sm4-ce-glue.c b/arch/arm64/crypto/sm4-ce-glue.c
new file mode 100644
index 000000000000..496d55c0d01a
--- /dev/null
+++ b/arch/arm64/crypto/sm4-ce-glue.c
@@ -0,0 +1,372 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SM4 Cipher Algorithm, using ARMv8 Crypto Extensions
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
+
+asmlinkage void sm4_ce_expand_key(const u8 *key, u32 *rkey_enc, u32 *rkey_dec,
+				  const u32 *fk, const u32 *ck);
+asmlinkage void sm4_ce_crypt_block(const u32 *rkey, u8 *dst, const u8 *src);
+asmlinkage void sm4_ce_crypt(const u32 *rkey, u8 *dst, const u8 *src,
+			     unsigned int nblks);
+asmlinkage void sm4_ce_cbc_enc(const u32 *rkey, u8 *dst, const u8 *src,
+			       u8 *iv, unsigned int nblks);
+asmlinkage void sm4_ce_cbc_dec(const u32 *rkey, u8 *dst, const u8 *src,
+			       u8 *iv, unsigned int nblks);
+asmlinkage void sm4_ce_cfb_enc(const u32 *rkey, u8 *dst, const u8 *src,
+			       u8 *iv, unsigned int nblks);
+asmlinkage void sm4_ce_cfb_dec(const u32 *rkey, u8 *dst, const u8 *src,
+			       u8 *iv, unsigned int nblks);
+asmlinkage void sm4_ce_ctr_enc(const u32 *rkey, u8 *dst, const u8 *src,
+			       u8 *iv, unsigned int nblks);
+
+static int sm4_setkey(struct crypto_skcipher *tfm, const u8 *key,
+		      unsigned int key_len)
+{
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	if (key_len != SM4_KEY_SIZE)
+		return -EINVAL;
+
+	sm4_ce_expand_key(key, ctx->rkey_enc, ctx->rkey_dec,
+			  crypto_sm4_fk, crypto_sm4_ck);
+	return 0;
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
+		nblks = BYTES2BLKS(nbytes);
+		if (nblks) {
+			sm4_ce_crypt(rkey, dst, src, nblks);
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
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+		unsigned int nblks;
+
+		kernel_neon_begin();
+
+		nblks = BYTES2BLKS(nbytes);
+		if (nblks) {
+			sm4_ce_cbc_enc(ctx->rkey_enc, dst, src, walk.iv, nblks);
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
+		nblks = BYTES2BLKS(nbytes);
+		if (nblks) {
+			sm4_ce_cbc_dec(ctx->rkey_dec, dst, src, walk.iv, nblks);
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
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+		unsigned int nblks;
+
+		kernel_neon_begin();
+
+		nblks = BYTES2BLKS(nbytes);
+		if (nblks) {
+			sm4_ce_cfb_enc(ctx->rkey_enc, dst, src, walk.iv, nblks);
+			dst += nblks * SM4_BLOCK_SIZE;
+			src += nblks * SM4_BLOCK_SIZE;
+			nbytes -= nblks * SM4_BLOCK_SIZE;
+		}
+
+		/* tail */
+		if (walk.nbytes == walk.total && nbytes > 0) {
+			u8 keystream[SM4_BLOCK_SIZE];
+
+			sm4_ce_crypt_block(ctx->rkey_enc, keystream, walk.iv);
+			crypto_xor_cpy(dst, src, keystream, nbytes);
+			nbytes = 0;
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
+		nblks = BYTES2BLKS(nbytes);
+		if (nblks) {
+			sm4_ce_cfb_dec(ctx->rkey_enc, dst, src, walk.iv, nblks);
+			dst += nblks * SM4_BLOCK_SIZE;
+			src += nblks * SM4_BLOCK_SIZE;
+			nbytes -= nblks * SM4_BLOCK_SIZE;
+		}
+
+		/* tail */
+		if (walk.nbytes == walk.total && nbytes > 0) {
+			u8 keystream[SM4_BLOCK_SIZE];
+
+			sm4_ce_crypt_block(ctx->rkey_enc, keystream, walk.iv);
+			crypto_xor_cpy(dst, src, keystream, nbytes);
+			nbytes = 0;
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
+		nblks = BYTES2BLKS(nbytes);
+		if (nblks) {
+			sm4_ce_ctr_enc(ctx->rkey_enc, dst, src, walk.iv, nblks);
+			dst += nblks * SM4_BLOCK_SIZE;
+			src += nblks * SM4_BLOCK_SIZE;
+			nbytes -= nblks * SM4_BLOCK_SIZE;
+		}
+
+		/* tail */
+		if (walk.nbytes == walk.total && nbytes > 0) {
+			u8 keystream[SM4_BLOCK_SIZE];
+
+			sm4_ce_crypt_block(ctx->rkey_enc, keystream, walk.iv);
+			crypto_inc(walk.iv, SM4_BLOCK_SIZE);
+			crypto_xor_cpy(dst, src, keystream, nbytes);
+			nbytes = 0;
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
+static struct skcipher_alg sm4_algs[] = {
+	{
+		.base = {
+			.cra_name		= "ecb(sm4)",
+			.cra_driver_name	= "ecb-sm4-ce",
+			.cra_priority		= 400,
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
+			.cra_driver_name	= "cbc-sm4-ce",
+			.cra_priority		= 400,
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
+			.cra_driver_name	= "cfb-sm4-ce",
+			.cra_priority		= 400,
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
+			.cra_driver_name	= "ctr-sm4-ce",
+			.cra_priority		= 400,
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
+module_cpu_feature_match(SM4, sm4_init);
+module_exit(sm4_exit);
+
+MODULE_DESCRIPTION("SM4 ECB/CBC/CFB/CTR using ARMv8 Crypto Extensions");
+MODULE_ALIAS_CRYPTO("sm4-ce");
+MODULE_ALIAS_CRYPTO("sm4");
+MODULE_ALIAS_CRYPTO("ecb(sm4)");
+MODULE_ALIAS_CRYPTO("cbc(sm4)");
+MODULE_ALIAS_CRYPTO("cfb(sm4)");
+MODULE_ALIAS_CRYPTO("ctr(sm4)");
+MODULE_AUTHOR("Tianjia Zhang <tianjia.zhang@linux.alibaba.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.24.3 (Apple Git-128)

