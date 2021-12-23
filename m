Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556EA47DE44
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 05:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346349AbhLWEfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 23:35:53 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:60608 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346323AbhLWEfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 23:35:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0V.TzZkA_1640234147;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V.TzZkA_1640234147)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Dec 2021 12:35:48 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v3 0/6] Introduce x86 assembly accelerated implementation for SM3 algorithm
Date:   Thu, 23 Dec 2021 12:35:41 +0800
Message-Id: <20211223043547.32297-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches creates an stand-alone library for SM3 hash
algorithm in the lib/crypto directory, and makes the implementations
that originally depended on sm3-generic depend on the stand-alone SM3
library, which also includes sm3-generic itself.

On this basis, the AVX assembly acceleration implementation of SM3
algorithm is introduced, the main algorithm implementation based on
SM3 AES/BMI2 accelerated work by libgcrypt at:
https://gnupg.org/software/libgcrypt/index.html

From the performance benchmark data, the performance improvement of
SM3 algorithm after AVX optimization can reach up to 38%.

---
v3 changes:
 - update git commit message for patch 01

v2 changes:
 - x86/sm3: Change K macros to signed decimal and use LEA and 32-bit offset

Tianjia Zhang (6):
  crypto: sm3 - create SM3 stand-alone library
  crypto: arm64/sm3-ce - make dependent on sm3 library
  crypto: sm2 - make dependent on sm3 library
  crypto: sm3 - make dependent on sm3 library
  crypto: x86/sm3 - add AVX assembly implementation
  crypto: tcrypt - add asynchronous speed test for SM3

 arch/arm64/crypto/Kconfig        |   2 +-
 arch/arm64/crypto/sm3-ce-glue.c  |  20 +-
 arch/x86/crypto/Makefile         |   3 +
 arch/x86/crypto/sm3-avx-asm_64.S | 517 +++++++++++++++++++++++++++++++
 arch/x86/crypto/sm3_avx_glue.c   | 134 ++++++++
 crypto/Kconfig                   |  16 +-
 crypto/sm2.c                     |  38 +--
 crypto/sm3_generic.c             | 142 +--------
 crypto/tcrypt.c                  |  14 +-
 include/crypto/sm3.h             |  34 +-
 lib/crypto/Kconfig               |   3 +
 lib/crypto/Makefile              |   3 +
 lib/crypto/sm3.c                 | 246 +++++++++++++++
 13 files changed, 1007 insertions(+), 165 deletions(-)
 create mode 100644 arch/x86/crypto/sm3-avx-asm_64.S
 create mode 100644 arch/x86/crypto/sm3_avx_glue.c
 create mode 100644 lib/crypto/sm3.c

-- 
2.32.0

