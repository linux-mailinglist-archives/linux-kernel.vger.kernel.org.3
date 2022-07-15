Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CAF5766BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiGOS26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiGOS2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:28:53 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B631C900;
        Fri, 15 Jul 2022 11:28:49 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so7787789fac.13;
        Fri, 15 Jul 2022 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IBiQsl90pDHRBwqe3+axgNXRFkm79+olwXba0W7edLk=;
        b=ln6F21CEzRQRC4/yNCdKCsE/IgiygaTe9s8M/B/rwx/17EIvs1h/vfWtlUUW0NxtGo
         s7sGSsEEQG7ESRfCuEEueRMb7yMCqQI3GWZDSUkXzBfp6rp655XrVLmgRi7vA6Ntd3J2
         RjIxN7e8KAkAEMjafhIcMBWLwn/q7WSyjhJipVJ6lrLI+cfI2DBx151YAQgWWJClQBr2
         5Df62r1WHbQm+yk95SRfzgMSse4aIpYURV42R6V3RT8eaTRSEKmi87UZYrFEZjbiB4MC
         VveiCbujXXJffTEQB5Dn4yd0YB/LvAa9YVei7qceGFQeGPDLqd/wsiiwaPpaJVL+pZNc
         I52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IBiQsl90pDHRBwqe3+axgNXRFkm79+olwXba0W7edLk=;
        b=KPe2moUjfXdW/JLtE1fO+IXO4QqEPDuczBMvS99SZWEGUr+Z9HTr9E0O4LPFCTFg8H
         Nmd+3SxCpCdr+k2zkTQHjiLZQ1WYhDDIkiuQM+G9q240pupWGNA722gWKbI4/Rb4X9Yt
         jiktDj2gAvz3ycQ6IuLKWXwUd33K1w5FVy40JQK4bq93rEob76AKU8nYsRHUc0pErJW8
         yHMAdrJiTh0DmMvs72jyPRkY5HX16UHb5ROU1jLlz0x41tUDLBwEuiSG0Xal9I7szYM9
         khEBK+IEYDUUFhL02u/tqryWbj+w4+v08ZRgbHcdjudnMwyxGP2a20HrKyxzfR0GxWYu
         ZCJw==
X-Gm-Message-State: AJIora8aBbnb2wlmqsoUXg9ssWjS+VqDIbzTZlJ0walEs+1nXS9VmUfn
        sGNZmRpZfu6LZuN2ueWUcAHWfbWveQQ=
X-Google-Smtp-Source: AGRyM1uttaECVea/7z0DjyiHt/vB4GkoRuQHpetrNEysPxT64/MWCbZTwvzCUI2E9WiipHQjrbNvDw==
X-Received: by 2002:a05:6808:17a3:b0:33a:16ef:a2dc with SMTP id bg35-20020a05680817a300b0033a16efa2dcmr7831566oib.261.1657909728567;
        Fri, 15 Jul 2022 11:28:48 -0700 (PDT)
Received: from localhost.localdomain (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.gmail.com with ESMTPSA id a5-20020a056808120500b00339ff117f38sm1995478oil.53.2022.07.15.11.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 11:28:48 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     Denis Kenzior <denkenz@gmail.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: asymmetric: Fix ECDSA use via keyctl uapi
Date:   Fri, 15 Jul 2022 13:28:10 -0500
Message-Id: <20220715182810.30505-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

