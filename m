Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADF35A2A44
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbiHZPC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237834AbiHZPCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:02:19 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C2CD86CB;
        Fri, 26 Aug 2022 08:02:17 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id z22-20020a056830129600b0063711f456ceso1174518otp.7;
        Fri, 26 Aug 2022 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=SlWypEhuzKh6o8JnTAr50IRQsWnoVrK87srIp4fAsvQ=;
        b=nOUu1td7NBo1uww0Jn+6NSAs/i0wIeXIOkzhAPow7DPsLGwrJVmdu9OPb3y412ujfu
         rZVmVnzKNLyHv+75TWvkPnckxKa+UQYNnH4V3dcRiFYWmjuM9SeC03aDsIahS1epeevC
         hurI0oTsMXe/Emi4YoPCCWMD8rCzR5za0WzEMpvCyCo8sYHYOWCdsN4kapaaZul4ElVw
         3e+7lBGatFdWH1cWC95B8A1IoJBH8IpAuSWEDHNJebakDF0WXAbOw6amlDF+r++Go6Q7
         +uOYHA+McaR5yg8E5pHECHgLB6QsusJrknfejd/YFL9uXibxylyA4nSk1nrAsxGp4s5Y
         N3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SlWypEhuzKh6o8JnTAr50IRQsWnoVrK87srIp4fAsvQ=;
        b=0DjKUBhdm+3Twm+NYjgBhfC1c/Kd8gtTC0u4fNZYdxsIyU5WKsfaL34j/M9hLZ6Of5
         IU2gkWvohEXM0zVq2cPTAYdimPtPiE+i/nU93PyXvAPOhwjUpuh9C4aPV/+PT44D0x32
         09fIF2Z+YrIW6L8sTOHPr7jUJFA8qsA9Ca1v7QH5QBF9Gv+OfrvDNgsh0g2noI26Blm4
         SymRaIXq9tJEScWzb+uZmscHoJsy6+qYN1vmtWmtlETVZQp0XDGHRWhICSg70ILNKJzU
         QH2a5YN0zTeddbuIeF97fS7SUhg/Bz9cIbWU/OqcmlvIBn1EhUKF7XLtaTnP7ynCBIEc
         7odQ==
X-Gm-Message-State: ACgBeo2LxnVdgh7S9etntRmcdCCKUBLyAFHtmPVPVIZw6J9RKY48elZh
        Y5g4pmz2yu7JtnI4pu+zjeM=
X-Google-Smtp-Source: AA6agR7H+LosV0wJVvvgdazIKiERc6cOY1dmpJHDOv+F/DCJ2wRGO3kK06cjOsP1yQPGvkBNmVUz1Q==
X-Received: by 2002:a05:6830:3150:b0:638:afc3:8639 with SMTP id c16-20020a056830315000b00638afc38639mr1541966ots.53.1661526136536;
        Fri, 26 Aug 2022 08:02:16 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j26-20020a4adf5a000000b00441b98453d8sm1190015oou.8.2022.08.26.08.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 08:02:16 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     Denis Kenzior <denkenz@gmail.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] KEYS: asymmetric: Fix ECDSA use via keyctl uapi
Date:   Fri, 26 Aug 2022 09:51:19 -0500
Message-Id: <20220826145119.9375-1-denkenz@gmail.com>
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
keyctl API from userspace.

Update constraint on max_data_size to 64 bytes in order to support
SHA512-based signatures. Also update the signature length constraints
per ECDSA signature encoding described in RFC 5480.

Fixes: 299f561a6693 ("x509: Add support for parsing x509 certs with ECDSA keys")
Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---

Version History:

  v2: Update patch description according to Jarkko's comments.  No
  functional code changes.

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

