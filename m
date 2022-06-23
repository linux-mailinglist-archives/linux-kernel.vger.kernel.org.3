Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAE55572E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiFWGPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiFWGPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:15:22 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9953013CF0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:15:21 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id d129so18194514pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rr6W1HmkOzqLYvFXcgRYRczNT4ybnvSLXNzzsMN6g3Q=;
        b=TumBSXa1A7/fh9+YVChoVb5zwgYdtT1Ure/4zv0RKBmw9qzxU7YkfM33UNSLdJoBkl
         a3A+zTdHJzTCeM2m0hNmwk5erykvVxCbmGX57AnAU+G5e7MXy8JzzGE4SzwuaII3iZIr
         +G2p2xOeYrnkv6NzGSohlRaaVIq7lRscrLUDxR3lRZy7bq35PmMghko1bQRN74cdVe98
         wrH5ZE0o0k61aigR+MnJNJr9nGOmzfbvvzAmBVB14zTrGgsaGGMBS7/pX6CdL/2voTVQ
         dSbTfG2ss+QJ2eXoIfHjD6OP6dprU0BtpnCQYwXG/xSMyAgGmiGDGyG0w4x5PLKVsnvs
         4Hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rr6W1HmkOzqLYvFXcgRYRczNT4ybnvSLXNzzsMN6g3Q=;
        b=QTnDSvvRt0hRt5JmCn5B0DVyeOYQHNCg4+g8mDF9FtxoVC+J+gWNR2z0jxjiVFa1v7
         +mWgNsrsRw9zQveAyB+72gTzEo3slCZUTUfy44hMK3qevMxD07JUs6s2go1sHzdUdaBc
         HO+NEQaaNQaUydBolkCdIKyD9VuR6xPNEsB4yY5biFP9uqPNI2QDlZaY7W9ZKTqaYzyd
         PBK2PoJ1Vm9v2CAdltrjkBrtCjpV1rGyzaRctDTj7m/h+iFmz8ESqaCwRx/8nUxBOprt
         +OJfmHQzWGXol+Da2Gnu3icduVcT1fOZJzeIEQWvPdGsQDeGRKE+skOwjM6EKpqwqv89
         v0tg==
X-Gm-Message-State: AJIora8LHOK+zkTMKOnnsXPuO1Xzo9a5uiJHiqKp7HxUR/8Zq9tciAp7
        8ugswnYmb9dmWTaYvt5lX2OoRg==
X-Google-Smtp-Source: AGRyM1t6atpZKWGMHi35zlVe8kAyorMGoZjfYw5oQD1l53FU3qCnDkNxU1k3LtZvtiPn+v4yNFz63Q==
X-Received: by 2002:aa7:838c:0:b0:525:3816:2340 with SMTP id u12-20020aa7838c000000b0052538162340mr11811178pfm.35.1655964921134;
        Wed, 22 Jun 2022 23:15:21 -0700 (PDT)
Received: from FVFDK26JP3YV.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090264d600b0015e8d4eb1b6sm350992pli.0.2022.06.22.23.15.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jun 2022 23:15:20 -0700 (PDT)
From:   Lei He <helei.sig11@bytedance.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com
Cc:     mst@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, berrange@redhat.com,
        pizhenwei@bytedance.com, lei he <helei.sig11@bytedance.com>
Subject: [PATCH v2 2/4] crypto: pkcs8 parser support ECDSA private keys
Date:   Thu, 23 Jun 2022 14:14:58 +0800
Message-Id: <20220623061500.78331-2-helei.sig11@bytedance.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220623061500.78331-1-helei.sig11@bytedance.com>
References: <20220623061500.78331-1-helei.sig11@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lei he <helei.sig11@bytedance.com>

Make pkcs8_private_key_parser can identify ECDSA private keys.

Signed-off-by: lei he <helei.sig11@bytedance.com>
---
 crypto/akcipher.c                     | 10 ++++++
 crypto/asymmetric_keys/pkcs8.asn1     |  2 +-
 crypto/asymmetric_keys/pkcs8_parser.c | 45 +++++++++++++++++++++++++--
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/crypto/akcipher.c b/crypto/akcipher.c
index f866085c8a4a..3adcdc6d48c2 100644
--- a/crypto/akcipher.c
+++ b/crypto/akcipher.c
@@ -120,6 +120,12 @@ static int akcipher_default_op(struct akcipher_request *req)
 	return -ENOSYS;
 }
 
+static int akcipher_default_set_key(struct crypto_akcipher *tfm,
+				    const void *key, unsigned int keylen)
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
+	if (!alg->set_pub_key)
+		alg->set_pub_key = akcipher_default_set_key;
+	if (!alg->set_priv_key)
+		alg->set_priv_key = akcipher_default_set_key;
 
 	akcipher_prepare_alg(alg);
 	return crypto_register_alg(base);
diff --git a/crypto/asymmetric_keys/pkcs8.asn1 b/crypto/asymmetric_keys/pkcs8.asn1
index 702c41a3c713..1791ddf4168a 100644
--- a/crypto/asymmetric_keys/pkcs8.asn1
+++ b/crypto/asymmetric_keys/pkcs8.asn1
@@ -20,5 +20,5 @@ Attribute ::= ANY
 
 AlgorithmIdentifier ::= SEQUENCE {
 	algorithm   OBJECT IDENTIFIER ({ pkcs8_note_OID }),
-	parameters  ANY OPTIONAL
+	parameters  ANY OPTIONAL ({ pkcs8_note_algo_parameter })
 }
diff --git a/crypto/asymmetric_keys/pkcs8_parser.c b/crypto/asymmetric_keys/pkcs8_parser.c
index 105dcce27f71..e507c635ead5 100644
--- a/crypto/asymmetric_keys/pkcs8_parser.c
+++ b/crypto/asymmetric_keys/pkcs8_parser.c
@@ -24,6 +24,8 @@ struct pkcs8_parse_context {
 	enum OID	algo_oid;		/* Algorithm OID */
 	u32		key_size;
 	const void	*key;
+	const void	*algo_param;
+	u32		algo_param_len;
 };
 
 /*
@@ -47,6 +49,17 @@ int pkcs8_note_OID(void *context, size_t hdrlen,
 	return 0;
 }
 
+int pkcs8_note_algo_parameter(void *context, size_t hdrlen,
+			      unsigned char tag,
+			      const void *value, size_t vlen)
+{
+	struct pkcs8_parse_context *ctx = context;
+
+	ctx->algo_param = value;
+	ctx->algo_param_len = vlen;
+	return 0;
+}
+
 /*
  * Note the version number of the ASN.1 blob.
  */
@@ -69,11 +82,37 @@ int pkcs8_note_algo(void *context, size_t hdrlen,
 		    const void *value, size_t vlen)
 {
 	struct pkcs8_parse_context *ctx = context;
-
-	if (ctx->last_oid != OID_rsaEncryption)
+	enum OID curve_id;
+
+	switch (ctx->last_oid) {
+	case OID_id_ecPublicKey:
+		if (!ctx->algo_param || ctx->algo_param_len == 0)
+			return -EBADMSG;
+		curve_id = look_up_OID(ctx->algo_param, ctx->algo_param_len);
+
+		switch (curve_id) {
+		case OID_id_prime192v1:
+			ctx->pub->pkey_algo = "ecdsa-nist-p192";
+			break;
+		case OID_id_prime256v1:
+			ctx->pub->pkey_algo = "ecdsa-nist-p256";
+			break;
+		case OID_id_ansip384r1:
+			ctx->pub->pkey_algo = "ecdsa-nist-p384";
+			break;
+		default:
+			return -ENOPKG;
+		}
+		break;
+
+	case OID_rsaEncryption:
+		ctx->pub->pkey_algo = "rsa";
+		break;
+
+	default:
 		return -ENOPKG;
+	}
 
-	ctx->pub->pkey_algo = "rsa";
 	return 0;
 }
 
-- 
2.20.1

