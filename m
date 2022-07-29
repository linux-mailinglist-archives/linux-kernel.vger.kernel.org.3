Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609BB58540E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbiG2RAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbiG2RAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:00:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B166F12D3A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:00:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z16so6646118wrh.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ain078t749gdNu9nYbJSAWNxQTVHVUSBU8lepBm9yIY=;
        b=XnYO4rmU1sCUc5ayVxa36eaejR8cAIu7AuvegZfcqkJH/5MwRBqw55iw5ExAjA1Xh9
         KVQdAJzGnL+ns9p+tNofB35IyIqThrB3eOg8IqTIn3IN+0r1XgHAXSWG7gcaGmeMxJzI
         KiOGxCrNg9kFj+By/WZ+1178otk6HvDKV2Ihw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ain078t749gdNu9nYbJSAWNxQTVHVUSBU8lepBm9yIY=;
        b=ZDRut8xvvSLi837ObbA2qxkegjgot7igLm9/hwzxwlGv77uWGZDiS/7LPTmSjbJsFL
         e7eT4oQEybWa4gPwqZDpX/Gk270Dcdoa7USh+neA/UvFap2pcKiUya2fKRygS5yqgxWl
         7lE74EP7Zvy+M2gVlSxA3NCZn2VncQ3d0xgp8eh8ZZ9mpzAd+u/DvaUeC4cSgnQDHYQy
         hDbwK1OdVWCF+rUV/lMf2iV2u1vFXuvciNE/LC8H3yBIwnS041rZtocqgDFlD1p3+lRt
         bm9hm7rogk0rbk0rxa6hHXNAibJX6UyIGWEFhEoDQISohnlqqwyBevoTVLkgT+w4rFU6
         s3ug==
X-Gm-Message-State: ACgBeo376B1+rhW27oCNJOoe4dCMI1RyDuJJxLPAN4J7qKMGIoC/5HZa
        Z5nIUu5A/JUhW+8NvPTldtpTOQ==
X-Google-Smtp-Source: AA6agR7Dzbt0v6ECxJsZk1ERO0U/YUA7fGBQLdfjjUFmrFpHyzP0yiYRQraEkft+yP8MDX46/m5rag==
X-Received: by 2002:adf:dfca:0:b0:21f:c93:5c36 with SMTP id q10-20020adfdfca000000b0021f0c935c36mr2935680wrn.41.1659114016070;
        Fri, 29 Jul 2022 10:00:16 -0700 (PDT)
Received: from localhost.localdomain (05464304.skybroadband.com. [5.70.67.4])
        by smtp.gmail.com with ESMTPSA id s1-20020adfea81000000b0021e74ef5ae8sm4120601wrm.21.2022.07.29.10.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 10:00:15 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com, Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH] crypto: akcipher - default implementations for setting private/public keys
Date:   Fri, 29 Jul 2022 17:59:54 +0100
Message-Id: <20220729165954.991-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many akcipher implementations (like ECDSA) support only signature
verifications only, so they don't have all callbacks defined.

Commit 78a0324f4a53 ("crypto: akcipher - default implementations for
request callbacks") introduced default callbacks for sign/verify
operations, which just return an error code.

However, these are not enough, because before calling sign/verify the
caller would likely call set_priv_key/set_pub_key first on the
instantiated transform (as the in-kernel testmgr does). These functions do
not have default stubs, so the kernel crashes, when trying to set a
private key on an akcipher, which doesn't support signature generation.

I've noticed this, when trying to add a KAT vector for ECDSA signature to
the testmgr.

With this patch the testmgr returns an error in dmesg (as it should)
instead of crashing the kernel NULL ptr dereference.

Fixes: 78a0324f4a53 ("crypto: akcipher - default implementations for request callbacks")
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 crypto/akcipher.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/crypto/akcipher.c b/crypto/akcipher.c
index f866085c8a4a..fc4db0c6ca33 100644
--- a/crypto/akcipher.c
+++ b/crypto/akcipher.c
@@ -120,6 +120,12 @@ static int akcipher_default_op(struct akcipher_request *req)
 	return -ENOSYS;
 }

+static int akcipher_default_set_key(struct crypto_akcipher *tfm,
+				     const void *key, unsigned int keylen)
+{
+	return -ENOSYS;
+}
+
 int crypto_register_akcipher(struct akcipher_alg *alg)
 {
 	struct crypto_alg *base = &alg->base;
@@ -132,6 +138,10 @@ int crypto_register_akcipher(struct akcipher_alg *alg)
 		alg->encrypt = akcipher_default_op;
 	if (!alg->decrypt)
 		alg->decrypt = akcipher_default_op;
+	if (!alg->set_priv_key)
+		alg->set_priv_key = akcipher_default_set_key;
+	if (!alg->set_pub_key)
+		alg->set_pub_key = akcipher_default_set_key;

 	akcipher_prepare_alg(alg);
 	return crypto_register_alg(base);
--
2.36.1

