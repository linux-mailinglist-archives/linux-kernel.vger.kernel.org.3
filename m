Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF54B52133E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240792AbiEJLLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbiEJLLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:11:34 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9373106365;
        Tue, 10 May 2022 04:07:37 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1noNi3-00BzVt-Kv; Tue, 10 May 2022 21:07:21 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 10 May 2022 19:07:19 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Tue, 10 May 2022 19:07:19 +0800
Subject: [RFC PATCH 6/7] crypto: api - Increase MAX_ALGAPI_ALIGNMASK to 127
References: <YnpGnsr4k7yVUR54@gondor.apana.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1noNi3-00BzVt-Kv@fornost.hmeau.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously we limited the maximum alignment mask to 63.  This
is mostly due to stack usage for shash.  This patch introduces
a separate limit for shash algorithms and increases the general
limit to 127 which is the value that we need for DMA allocations
on arm64.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 crypto/shash.c          |    9 +++++++--
 include/crypto/algapi.h |    2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/crypto/shash.c b/crypto/shash.c
index 0a0a50cb694f0..0a10477eac060 100644
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -18,6 +18,8 @@
 
 #include "internal.h"
 
+#define MAX_SHASH_ALIGNMASK 63
+
 static const struct crypto_type crypto_shash_type;
 
 static int shash_no_setkey(struct crypto_shash *tfm, const u8 *key,
@@ -100,7 +102,7 @@ static int shash_update_unaligned(struct shash_desc *desc, const u8 *data,
 	 * We cannot count on __aligned() working for large values:
 	 * https://patchwork.kernel.org/patch/9507697/
 	 */
-	u8 ubuf[MAX_ALGAPI_ALIGNMASK * 2];
+	u8 ubuf[MAX_SHASH_ALIGNMASK * 2];
 	u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
 	int err;
 
@@ -142,7 +144,7 @@ static int shash_final_unaligned(struct shash_desc *desc, u8 *out)
 	 * We cannot count on __aligned() working for large values:
 	 * https://patchwork.kernel.org/patch/9507697/
 	 */
-	u8 ubuf[MAX_ALGAPI_ALIGNMASK + HASH_MAX_DIGESTSIZE];
+	u8 ubuf[MAX_SHASH_ALIGNMASK + HASH_MAX_DIGESTSIZE];
 	u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
 	int err;
 
@@ -530,6 +532,9 @@ static int shash_prepare_alg(struct shash_alg *alg)
 	    alg->statesize > HASH_MAX_STATESIZE)
 		return -EINVAL;
 
+	if (base->cra_alignmask > MAX_SHASH_ALIGNMASK)
+		return -EINVAL;
+
 	if ((alg->export && !alg->import) || (alg->import && !alg->export))
 		return -EINVAL;
 
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index cdf12e51c53a0..16cfd823ee911 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -21,7 +21,7 @@
  * algs and architectures. Ciphers have a lower maximum size.
  */
 #define MAX_ALGAPI_BLOCKSIZE		160
-#define MAX_ALGAPI_ALIGNMASK		63
+#define MAX_ALGAPI_ALIGNMASK		127
 #define MAX_CIPHER_BLOCKSIZE		16
 #define MAX_CIPHER_ALIGNMASK		15
 
