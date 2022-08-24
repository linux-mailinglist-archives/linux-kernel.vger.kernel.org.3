Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DB45A01CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiHXTLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbiHXTLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:11:34 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650846171E;
        Wed, 24 Aug 2022 12:11:32 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id r10so14685727oie.1;
        Wed, 24 Aug 2022 12:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=IBiQsl90pDHRBwqe3+axgNXRFkm79+olwXba0W7edLk=;
        b=LwVjVKEmD+5b78/bhquOFWgs5s6bgTgvTlxBNV7+f/UFG+zUl6YKTZtAPGIX1NQHtI
         PqATEHDZjE+xeDBPRGHzuS9cfhC732dq3zHXVmBtlQgdZrU2K0+ylp8vqguwYTmeRJLO
         3EcQTqsUP50v7BO9sV1P8OmqJXCA/q61fm5uXgWAWYZiu6v5yMvtEXwIqStQrTL5417Z
         vvaUHtVUoO1xYfWJObeAD3E8CImrroBSqvxDKIef8HIHWsAW9JJosGdIlyPtCqzASDTA
         neOUqwb9trliwKvKUwya+J5aC7517Kcw2B1TWKBIedWROue9Kx7DJUpx/A0ImoAIGu69
         Pt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=IBiQsl90pDHRBwqe3+axgNXRFkm79+olwXba0W7edLk=;
        b=grxGRGAYo5E02Lez/dMSO3kg8s1Ih53TDpiOM5+OpHQbjFjCsChgYIGBywARu3i4Lz
         /gTP8vDQ1PFG4PV30s26AOhd4JjdBbgMx3rT9hp/qCUQiS2Px2tBSuulQWg9jsyar/9f
         fchHpgN2qYhYKZMOWcN2gZxsx7fZBaec0Z4WJBm7t2ytDB0cDn5wX5b5B3jvUcw3OGW4
         zQHDtpUuCsYtf4hCBw7lJ/JKcT7DdpKP7PluREJeYOeI1DO/DL2G8x2y9fUgxnruIGir
         8UXrhrbfiV7+Xr+gGLQl7CR2cT2Q6MTVxJ1mnng9NcamrdQyhP46osu4HPrhClnAMEev
         gZNw==
X-Gm-Message-State: ACgBeo3NoUyxyEwelGUd0XAQRJoqA5FoW1rN463SRmSKqgEWNx7b19/C
        7spACsV0YooZZGFEscfMAkriK0b0Bic=
X-Google-Smtp-Source: AA6agR4XoWfrSzx3hPN24v77RjyPRhd6uA4mVtiyDrrjcGFdzGVyGhRxmedlNYqTdvfO/FhJ4fdSBw==
X-Received: by 2002:a05:6808:10d4:b0:344:f380:cf8c with SMTP id s20-20020a05680810d400b00344f380cf8cmr264079ois.27.1661368291712;
        Wed, 24 Aug 2022 12:11:31 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id q44-20020a05687082ac00b0011ded9c762fsm405342oae.38.2022.08.24.12.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 12:11:31 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     Denis Kenzior <denkenz@gmail.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] KEYS: asymmetric: Fix ECDSA use via keyctl uapi
Date:   Wed, 24 Aug 2022 14:04:09 -0500
Message-Id: <20220824190409.4286-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When support for ECDSA keys was added, constraints for data & signature
sizes were never updated.  This makes it impossible to use such keys via
keyctl API from userspace; fix that.

Fixes: 299f561a6693 ("x509: Add support for parsing x509 certs with ECDSA keys")
Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 crypto/asymmetric_keys/public_key.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 2f8352e88860..eca5671ad3f2 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -186,8 +186,28 @@ static int software_key_query(const struct kernel_pkey_params *params,
 
 	len = crypto_akcipher_maxsize(tfm);
 	info->key_size = len * 8;
-	info->max_data_size = len;
-	info->max_sig_size = len;
+
+	if (strncmp(pkey->pkey_algo, "ecdsa", 5) == 0) {
+		/*
+		 * ECDSA key sizes are much smaller than RSA, and thus could
+		 * operate on (hashed) inputs that are larger than key size.
+		 * For example SHA384-hashed input used with secp256r1
+		 * based keys.  Set max_data_size to be at least as large as
+		 * the largest supported hash size (SHA512)
+		 */
+		info->max_data_size = 64;
+
+		/*
+		 * Verify takes ECDSA-Sig (described in RFC 5480) as input,
+		 * which is actually 2 'key_size'-bit integers encoded in
+		 * ASN.1.  Account for the ASN.1 encoding overhead here.
+		 */
+		info->max_sig_size = 2 * (len + 3) + 2;
+	} else {
+		info->max_data_size = len;
+		info->max_sig_size = len;
+	}
+
 	info->max_enc_size = len;
 	info->max_dec_size = len;
 	info->supported_ops = (KEYCTL_SUPPORTS_ENCRYPT |
-- 
2.35.1

