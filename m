Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB79958F837
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbiHKHRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiHKHRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:17:46 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42F3891D1D;
        Thu, 11 Aug 2022 00:17:45 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id E64251E80D77;
        Thu, 11 Aug 2022 15:15:42 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id stz8ltOgymNM; Thu, 11 Aug 2022 15:15:40 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: chuanjian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id C05001E80D32;
        Thu, 11 Aug 2022 15:15:39 +0800 (CST)
From:   Dong Chuanjian <chuanjian@nfschina.com>
To:     ebiggers@kernel.org
Cc:     chuanjian@nfschina.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, kernel@nfschina.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto/drbg: remove unnecessary (void*) conversions
Date:   Thu, 11 Aug 2022 15:17:33 +0800
Message-Id: <20220811071733.5145-2-chuanjian@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20220811071733.5145-1-chuanjian@nfschina.com>
References: <YvKiRWzWyATdEwGP@gmail.com>
 <20220811071733.5145-1-chuanjian@nfschina.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type casting

v2:
Turn assignments less than 75 characters into one line.

Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 177983b6ae38..982d4ca4526d 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1703,7 +1703,7 @@ static int drbg_init_hash_kernel(struct drbg_state *drbg)
 
 static int drbg_fini_hash_kernel(struct drbg_state *drbg)
 {
-	struct sdesc *sdesc = (struct sdesc *)drbg->priv_data;
+	struct sdesc *sdesc = drbg->priv_data;
 	if (sdesc) {
 		crypto_free_shash(sdesc->shash.tfm);
 		kfree_sensitive(sdesc);
@@ -1715,7 +1715,7 @@ static int drbg_fini_hash_kernel(struct drbg_state *drbg)
 static void drbg_kcapi_hmacsetkey(struct drbg_state *drbg,
 				  const unsigned char *key)
 {
-	struct sdesc *sdesc = (struct sdesc *)drbg->priv_data;
+	struct sdesc *sdesc = drbg->priv_data;
 
 	crypto_shash_setkey(sdesc->shash.tfm, key, drbg_statelen(drbg));
 }
@@ -1723,7 +1723,7 @@ static void drbg_kcapi_hmacsetkey(struct drbg_state *drbg,
 static int drbg_kcapi_hash(struct drbg_state *drbg, unsigned char *outval,
 			   const struct list_head *in)
 {
-	struct sdesc *sdesc = (struct sdesc *)drbg->priv_data;
+	struct sdesc *sdesc = drbg->priv_data;
 	struct drbg_string *input = NULL;
 
 	crypto_shash_init(&sdesc->shash);
@@ -1818,8 +1818,7 @@ static int drbg_init_sym_kernel(struct drbg_state *drbg)
 static void drbg_kcapi_symsetkey(struct drbg_state *drbg,
 				 const unsigned char *key)
 {
-	struct crypto_cipher *tfm =
-		(struct crypto_cipher *)drbg->priv_data;
+	struct crypto_cipher *tfm = drbg->priv_data;
 
 	crypto_cipher_setkey(tfm, key, (drbg_keylen(drbg)));
 }
@@ -1827,8 +1826,7 @@ static void drbg_kcapi_symsetkey(struct drbg_state *drbg,
 static int drbg_kcapi_sym(struct drbg_state *drbg, unsigned char *outval,
 			  const struct drbg_string *in)
 {
-	struct crypto_cipher *tfm =
-		(struct crypto_cipher *)drbg->priv_data;
+	struct crypto_cipher *tfm = drbg->priv_data;
 
 	/* there is only component in *in */
 	BUG_ON(in->len < drbg_blocklen(drbg));
-- 
2.18.2

