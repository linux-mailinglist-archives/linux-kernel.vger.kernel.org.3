Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC86752984A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiEQDgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239647AbiEQDgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:36:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA1A40A33;
        Mon, 16 May 2022 20:36:35 -0700 (PDT)
Received: from kwepemi100013.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L2MFY5QQSz1JCSt;
        Tue, 17 May 2022 11:35:13 +0800 (CST)
Received: from kwepemm600018.china.huawei.com (7.193.23.140) by
 kwepemi100013.china.huawei.com (7.221.188.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 11:36:33 +0800
Received: from huawei.com (10.174.176.88) by kwepemm600018.china.huawei.com
 (7.193.23.140) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 11:36:32 +0800
From:   gaochao <gaochao49@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC:     <hpa@zytor.com>, <ebiggers@google.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] crypto: Fix build error when CRYPTO_BLAKE2S_X86=m && CRYPTO_ALGAPI2=m && CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
Date:   Tue, 17 May 2022 11:36:30 +0800
Message-ID: <20220517033630.1182-1-gaochao49@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600018.china.huawei.com (7.193.23.140)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CRYPTO=m, CRYPTO_ALGAPI=m, CRYPTO_ALGAPI2=m, CRYPTO_BLAKE2S_X86=m,
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
bulding fails:

arch/x86/crypto/blake2s-glue.o: In function `blake2s_compress':
(.text+0x5a): undefined reference to `crypto_simd_disabled_for_test'
make: *** [vmlinux] Error 1

When CRYPTO_MANAGER_EXTRA_TESTS=y, blake2s_compress will call
crypto_simd_disabled_for_test.
When CRYPTO_ALGAPI2=m, crypto_algapi build as a module,
but if CONFIG_CRYPTO_BLAKE2S_X86=m at the same time,
libblake2s-x86_64.o build with obj-y, this will accuse the above error.

To fix this error:
1 Choose CRYPTO_ALGAPI2 for CRYPTO_BLAKE2S_X86
when CRYPTO_MANAGER_EXTRA_TESTS=y.
2 build libblake2s-x86_64.o as a module when CONFIG_CRYPTO_BLAKE2S_X86=y

Fixes: 8fc5f2ad896b ("crypto: testmgr - Move crypto_simd_disabled_for_test out")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: gaochao <gaochao49@huawei.com>
---
 arch/x86/crypto/Makefile | 2 +-
 crypto/Kconfig           | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 2831685adf6f..54b2469fa49a 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -63,7 +63,7 @@ sha512-ssse3-y := sha512-ssse3-asm.o sha512-avx-asm.o sha512-avx2-asm.o sha512_s

 obj-$(CONFIG_CRYPTO_BLAKE2S_X86) += blake2s-x86_64.o
 blake2s-x86_64-y := blake2s-shash.o
-obj-$(if $(CONFIG_CRYPTO_BLAKE2S_X86),y) += libblake2s-x86_64.o
+obj-$(CONFIG_CRYPTO_BLAKE2S_X86) += libblake2s-x86_64.o
 libblake2s-x86_64-y := blake2s-core.o blake2s-glue.o

 obj-$(CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL) += ghash-clmulni-intel.o
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 19197469cfab..e61598f8f8c5 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -714,6 +714,7 @@ config CRYPTO_BLAKE2S_X86
 	depends on X86 && 64BIT
 	select CRYPTO_LIB_BLAKE2S_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
+	select CRYPTO_ALGAPI2 if CRYPTO_MANAGER_EXTRA_TESTS

 config CRYPTO_CRCT10DIF
 	tristate "CRCT10DIF algorithm"
--
2.17.1

