Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398DA493633
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352318AbiASIYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:24:53 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40938 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348529AbiASIYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:24:52 -0500
X-UUID: 97f9c6ab74ca4abdbe273660cd85ffeb-20220119
X-UUID: 97f9c6ab74ca4abdbe273660cd85ffeb-20220119
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 645517797; Wed, 19 Jan 2022 16:24:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Jan 2022 16:24:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 16:24:47 +0800
From:   <miles.chen@mediatek.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     Miles Chen <miles.chen@mediatek.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] lib/crypto: blake2s: fix a CFI failure
Date:   Wed, 19 Jan 2022 16:24:46 +0800
Message-ID: <20220119082447.1675-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miles Chen <miles.chen@mediatek.com>

With CONFIG_CFI_CLANG=y, we observe a CFI failure of
blake2s_compress_generic.

Reverting commit 6048fdcc5f26 ("lib/crypto: blake2s: include as built-in")
is a solution for this problem. So I looked into the patch
and I think it is caused by the weak symbols use by blake2s_compress().

To fix it, remove the weak symbol and use CRYPTO_ARCH_HAVE_LIB_BLAKE2S
to select blake2s_compress_arch/blake2s_compress_generic.

log:
[    0.000000][    T0] Kernel panic - not syncing: CFI failure (target: blake2s_compress_generic+0x0/0x1444)
[    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.16.0-mainline-06981-g076c855b846e #1
[    0.000000][    T0] Hardware name: MT6873 (DT)
[    0.000000][    T0] Call trace:
[    0.000000][    T0]  dump_backtrace+0xfc/0x1dc
[    0.000000][    T0]  dump_stack_lvl+0xa8/0x11c
[    0.000000][    T0]  panic+0x194/0x464
[    0.000000][    T0]  __cfi_check_fail+0x54/0x58
[    0.000000][    T0]  __cfi_slowpath_diag+0x354/0x4b0
[    0.000000][    T0]  blake2s_update+0x14c/0x178
[    0.000000][    T0]  _extract_entropy+0xf4/0x29c
[    0.000000][    T0]  crng_initialize_primary+0x24/0x94
[    0.000000][    T0]  rand_initialize+0x2c/0x6c
[    0.000000][    T0]  start_kernel+0x2f8/0x65c
[    0.000000][    T0]  __primary_switched+0xc4/0x7be4
[    0.000000][    T0] Rebooting in 5 seconds..

Fixes: 6048fdcc5f26 ("lib/crypto: blake2s: include as built-in")
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 lib/crypto/blake2s-generic.c | 3 +--
 lib/crypto/blake2s.c         | 6 ++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/crypto/blake2s-generic.c b/lib/crypto/blake2s-generic.c
index 75ccb3e633e6..22fa3ea1689e 100644
--- a/lib/crypto/blake2s-generic.c
+++ b/lib/crypto/blake2s-generic.c
@@ -38,8 +38,7 @@ static inline void blake2s_increment_counter(struct blake2s_state *state,
 }
 
 void blake2s_compress(struct blake2s_state *state, const u8 *block,
-		      size_t nblocks, const u32 inc)
-		      __weak __alias(blake2s_compress_generic);
+		      size_t nblocks, const u32 inc);
 
 void blake2s_compress_generic(struct blake2s_state *state, const u8 *block,
 			      size_t nblocks, const u32 inc)
diff --git a/lib/crypto/blake2s.c b/lib/crypto/blake2s.c
index 93f2ae051370..4055aa593ec4 100644
--- a/lib/crypto/blake2s.c
+++ b/lib/crypto/blake2s.c
@@ -16,6 +16,12 @@
 #include <linux/init.h>
 #include <linux/bug.h>
 
+#if IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S)
+#  define blake2s_compress blake2s_compress_arch
+#else
+#  define blake2s_compress blake2s_compress_generic
+#endif
+
 void blake2s_update(struct blake2s_state *state, const u8 *in, size_t inlen)
 {
 	__blake2s_update(state, in, inlen, blake2s_compress);
-- 
2.18.0

