Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E35658D610
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiHIJPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiHIJO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:14:59 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AFCF21E1D;
        Tue,  9 Aug 2022 02:14:58 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id CDA5F1E80CD2;
        Tue,  9 Aug 2022 17:13:12 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hf1it-2oo_4A; Tue,  9 Aug 2022 17:13:10 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: chuanjian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 2B1501E80CC5;
        Tue,  9 Aug 2022 17:13:10 +0800 (CST)
From:   Dong Chuanjian <chuanjian@nfschina.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com, Dong Chuanjian <chuanjian@nfschina.com>
Subject: [PATCH] crypto/drbg.c:remove unnecessary (void*) conversions
Date:   Tue,  9 Aug 2022 17:14:52 +0800
Message-Id: <20220809091452.5264-1-chuanjian@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type casting

Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 177983b6ae38..f41ec3088ecc 100644
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
@@ -1819,7 +1819,7 @@ static void drbg_kcapi_symsetkey(struct drbg_state *drbg,
 				 const unsigned char *key)
 {
 	struct crypto_cipher *tfm =
-		(struct crypto_cipher *)drbg->priv_data;
+		drbg->priv_data;
 
 	crypto_cipher_setkey(tfm, key, (drbg_keylen(drbg)));
 }
@@ -1828,7 +1828,7 @@ static int drbg_kcapi_sym(struct drbg_state *drbg, unsigned char *outval,
 			  const struct drbg_string *in)
 {
 	struct crypto_cipher *tfm =
-		(struct crypto_cipher *)drbg->priv_data;
+		drbg->priv_data;
 
 	/* there is only component in *in */
 	BUG_ON(in->len < drbg_blocklen(drbg));
-- 
2.18.2

