Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735545A85E4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiHaSkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiHaSjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:39:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25235C2757
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:37:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h1so7812562wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Gu6lQeKRAmTnscQpGQRRWcZPQVAuazBQGzE1OcpBRZM=;
        b=QGBW33llSjJF8ooJpWUjOHhRi3BuKrE1Iv15WhrM9uKzU1uoCRPJJG08GVSd6FUnVH
         q+SbLLzsGLpr9JwDBImTM7lUZjoRsXN1DdLGdfVeKA+WmG5Qzbzs5cWDko9XYXuG38kJ
         9T94rFRdOlyZwQ3Bxd5O7CNo6ugZBhwdIxPcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Gu6lQeKRAmTnscQpGQRRWcZPQVAuazBQGzE1OcpBRZM=;
        b=OFDHUqdZKDYfkJvV+nr65VA/7uf/3S5cjVVSLBusfWsKYqSMu9q2hehb8vyga4rHPr
         LIQ53NKW15CafiGm/J+1Oay5OjFC1EiXENCa5BeWhkOa1aCHl09mpb5YOaRoftwFBbZU
         lIJ9OLCV+pZeQGXNn8vVdp6foyTqo500yzqd7iNSILZy9Fy0zuAZXGyA3Rh1NIFzCMF2
         XpOY5mA53C1/5qHwIZ9gi6y9SI767hd2Jl4yuHbuMWzatwdhGKQyLhR2T8UuYkOAl0Qe
         AqFO0UFx5pQmAvleUGATlSsMZ0TPfoBDOULsHcdiZVXM8s4isCim5nnWS/Syms4KX5wx
         zT3Q==
X-Gm-Message-State: ACgBeo3hYDAbEklh3cOZPr03S7kGe5bWZ1yNQvZykc4tiYeTBHvt2CnT
        yPNM8fq2pCtUfCRBnhygOCR9aW8q80LLcu8U
X-Google-Smtp-Source: AA6agR6Eh4OvFNAhBbA/UM8ALcaEKdHMqVAihlobnQhJ2iKaWIlMBNa7jC6NkLPiGd3AijvS6K8clA==
X-Received: by 2002:a05:600c:1c23:b0:3a5:d936:e5bb with SMTP id j35-20020a05600c1c2300b003a5d936e5bbmr2658685wms.59.1661971040435;
        Wed, 31 Aug 2022 11:37:20 -0700 (PDT)
Received: from localhost.localdomain ([2.216.100.221])
        by smtp.gmail.com with ESMTPSA id h21-20020a05600c351500b003a502c23f2asm3322991wmq.16.2022.08.31.11.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:37:20 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com, Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH v2] crypto: akcipher - default implementation for setting a private key
Date:   Wed, 31 Aug 2022 19:37:06 +0100
Message-Id: <20220831183706.1600-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:
  * removed the default implementation from set_pub_key: it is assumed that
    an implementation must always have this callback defined as there are
    no use case for an algorithm, which doesn't need a public key

Many akcipher implementations (like ECDSA) support only signature
verifications, so they don't have all callbacks defined.

Commit 78a0324f4a53 ("crypto: akcipher - default implementations for
request callbacks") introduced default callbacks for sign/verify
operations, which just return an error code.

However, these are not enough, because before calling sign the caller would
likely call set_priv_key first on the instantiated transform (as the
in-kernel testmgr does). This function does not have a default stub, so the
kernel crashes, when trying to set a private key on an akcipher, which
doesn't support signature generation.

I've noticed this, when trying to add a KAT vector for ECDSA signature to
the testmgr.

With this patch the testmgr returns an error in dmesg (as it should)
instead of crashing the kernel NULL ptr dereference.

Fixes: 78a0324f4a53 ("crypto: akcipher - default implementations for request callbacks")
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 crypto/akcipher.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/crypto/akcipher.c b/crypto/akcipher.c
index f866085c8a4a..ab975a420e1e 100644
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
@@ -132,6 +138,8 @@ int crypto_register_akcipher(struct akcipher_alg *alg)
 		alg->encrypt = akcipher_default_op;
 	if (!alg->decrypt)
 		alg->decrypt = akcipher_default_op;
+	if (!alg->set_priv_key)
+		alg->set_priv_key = akcipher_default_set_key;

 	akcipher_prepare_alg(alg);
 	return crypto_register_alg(base);
--
2.36.1

