Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DD24D97EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346762AbiCOJqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbiCOJqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:46:13 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94074ECD6;
        Tue, 15 Mar 2022 02:45:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0V7H-Cvw_1647337496;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V7H-Cvw_1647337496)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Mar 2022 17:44:57 +0800
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
Subject: [PATCH 0/4] Add ARMv8 NEON and Crypto Extensions implementation of SM4-ECB/CBC/CFB/CTR
Date:   Tue, 15 Mar 2022 17:44:50 +0800
Message-Id: <20220315094454.45269-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

This series of patches adds ARMv8 implementations of SM4 in ECB, CBC,
CFB and CTR modes, both for ARMv8 with Crypto Extensions and for plain
ARMv8 NEON.

NEON is a general-purpose SIMD instruction set under ARMv8, and SM4
acceleration instructions are optional supported by Crypto Extensions.

Patch 1 exports the constant array in the SM4 software implementation,
sm4_sbox are used for the tbl/tbx instruction lookup table in the NEON
implementation, sm4_fk and sm4_ck are used for the key expansion in the
CE implementation.

Patch 2 renamed the existing sm4-ce to sm4-ce-cipher, which is a
single-block CE algorithm implementation that does not support the mode.
This naming rule follows the AES algorithm in the same directory.

Patch 3 introduces an SM4 accelerated implementation of plain NEON.

Patch 4 introduced the SM4 CE instruction set implementation.

In order to be more intuitive, the following compares the performance of
the four algorithms sm4-generic, sm4-neon, sm4-ce-cipher, and sm4-ce,
their performance is from low to high.

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


Tianjia Zhang (4):
  crypto: lib/sm4 - export sm4 constant arrays
  crypto: arm64/sm4-ce - rename to sm4-ce-cipher
  crypto: arm64/sm4 - add ARMv8 NEON implementation
  crypto: arm64/sm4 - add ARMv8 Crypto Extensions implementation

 arch/arm64/crypto/Kconfig              |  12 +
 arch/arm64/crypto/Makefile             |   8 +-
 arch/arm64/crypto/sm4-ce-cipher-core.S |  36 ++
 arch/arm64/crypto/sm4-ce-cipher-glue.c |  82 +++
 arch/arm64/crypto/sm4-ce-core.S        | 688 +++++++++++++++++++++++--
 arch/arm64/crypto/sm4-ce-glue.c        | 386 ++++++++++++--
 arch/arm64/crypto/sm4-neon-core.S      | 487 +++++++++++++++++
 arch/arm64/crypto/sm4-neon-glue.c      | 442 ++++++++++++++++
 include/crypto/sm4.h                   |   4 +
 lib/crypto/sm4.c                       |  10 +-
 10 files changed, 2073 insertions(+), 82 deletions(-)
 create mode 100644 arch/arm64/crypto/sm4-ce-cipher-core.S
 create mode 100644 arch/arm64/crypto/sm4-ce-cipher-glue.c
 create mode 100644 arch/arm64/crypto/sm4-neon-core.S
 create mode 100644 arch/arm64/crypto/sm4-neon-glue.c

-- 
2.24.3 (Apple Git-128)

