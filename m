Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47945A1377
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbiHYOYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241596AbiHYOX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:23:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA3AB69D9;
        Thu, 25 Aug 2022 07:23:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso5138549pjk.0;
        Thu, 25 Aug 2022 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=usst7kyrK1cFd/C6ZxpE7JwpfKQPx/JElE5BaVa3e/U=;
        b=fvbGPbaX6w7mccf0nprjMQzAQlOTqf5dy+PKCnoFfE5plxz2kTMxNzWtbp0CYKZJU3
         C6xIKuBvefvtOM/E63hBDexliSjHTwr2mMofBqE0h+fEHt1u/T9rjeSQwDH3O/YeyIMJ
         LGU50fUpKbTSwdIwaBxT/fo2Cqh0FswlA0/ZXn3ZvSBUQLmZgI2/xbZv1ZednTJHczUM
         Ziu1IuZxBtXbUG+oge2XBDQGZQSP3nj624Y/57w3zINwkm/CcoShZIMppyx/MBoFunhy
         YnW+TTHVEPwO165fX1NmeARt7dGEEaTz9EB/n5QqfW1+iDS76hdHKuV/PWisF6YpRMma
         N/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=usst7kyrK1cFd/C6ZxpE7JwpfKQPx/JElE5BaVa3e/U=;
        b=TAIhD3F4UAp0d88lBXMfrIzWlb0Ulj/iYPqrV6c5VD8nmZ/pkJxbo9h53A4fqafqGj
         sofX/OYPvA5oKnvJOtbHUcxipUtl4MT5zRpcIEStHXtAFoS/drpeAeKRlEv+CnPvCtmQ
         3GqaFyJsSlabEN9AGw8eSQqD6qp+c4Rup5DI4IRSfPCO0g929IWZ3qPR8MvxdlMdPCmS
         5lMTp2mDPKEnCE9P3FY62Tv9X9QzO8YD7oarR/7oCX8QFY0ZqLYx57Dl+Xs3Y/kt5uEl
         07dThZlVuPMB/iGw2I6o4x4ECUG0LKk/SQ9KyaV6q6GPx/I1mjULePN++8XlyI9tXeiI
         Jefw==
X-Gm-Message-State: ACgBeo30gRJCo1QKk2E1vb0xi7f3bSwRpUcheOFYoaQH1tW62VighuTA
        VLDCkjzVoAMBjJ1zsgJdXLo=
X-Google-Smtp-Source: AA6agR7WR5QytOkUhjTd2gVhSld9wIXOLucV9txUzlBC9Bff/gmw2xLfEznG+Tb3nzVambT+FlwXCg==
X-Received: by 2002:a17:902:c945:b0:16d:c318:4480 with SMTP id i5-20020a170902c94500b0016dc3184480mr4222480pla.147.1661437404922;
        Thu, 25 Aug 2022 07:23:24 -0700 (PDT)
Received: from linux-l9pv.suse (123-194-152-128.dynamic.kbronet.com.tw. [123.194.152.128])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903120f00b0016bb24f5d19sm14962803plh.209.2022.08.25.07.23.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Aug 2022 07:23:24 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Ben Boeckel <me@benboeckel.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Malte Gell <malte.gell@gmx.de>,
        Varad Gautam <varad.gautam@suse.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH v9,2/4] PKCS#7: Check codeSigning EKU for kernel module and kexec pe verification
Date:   Thu, 25 Aug 2022 22:23:12 +0800
Message-Id: <20220825142314.8406-3-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20220825142314.8406-1-jlee@suse.com>
References: <20220825142314.8406-1-jlee@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the logic for checking the CodeSigning extended
key usage when verifying signature of kernel module or
kexec PE binary in PKCS#7.

Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 certs/blacklist.c                    |  5 ++--
 certs/system_keyring.c               |  4 +--
 crypto/asymmetric_keys/Kconfig       |  9 ++++++
 crypto/asymmetric_keys/pkcs7_trust.c | 43 ++++++++++++++++++++++++++--
 crypto/asymmetric_keys/selftest.c    |  2 +-
 include/crypto/pkcs7.h               |  4 ++-
 include/keys/system_keyring.h        |  7 +++--
 7 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 41f10601cc72..fa41454055be 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -282,11 +282,12 @@ int add_key_to_revocation_list(const char *data, size_t size)
  * is_key_on_revocation_list - Determine if the key for a PKCS#7 message is revoked
  * @pkcs7: The PKCS#7 message to check
  */
-int is_key_on_revocation_list(struct pkcs7_message *pkcs7)
+int is_key_on_revocation_list(struct pkcs7_message *pkcs7,
+			      enum key_being_used_for usage)
 {
 	int ret;
 
-	ret = pkcs7_validate_trust(pkcs7, blacklist_keyring);
+	ret = pkcs7_validate_trust(pkcs7, blacklist_keyring, usage, false);
 
 	if (ret == 0)
 		return -EKEYREJECTED;
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 5042cc54fa5e..66737bfb26de 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -263,13 +263,13 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
 			goto error;
 		}
 
-		ret = is_key_on_revocation_list(pkcs7);
+		ret = is_key_on_revocation_list(pkcs7, usage);
 		if (ret != -ENOKEY) {
 			pr_devel("PKCS#7 platform key is on revocation list\n");
 			goto error;
 		}
 	}
-	ret = pkcs7_validate_trust(pkcs7, trusted_keys);
+	ret = pkcs7_validate_trust(pkcs7, trusted_keys, usage, true);
 	if (ret < 0) {
 		if (ret == -ENOKEY)
 			pr_devel("PKCS#7 signature not signed with a trusted key\n");
diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 3df3fe4ed95f..189536bd0f9a 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -85,4 +85,13 @@ config FIPS_SIGNATURE_SELFTEST
 	depends on ASYMMETRIC_KEY_TYPE
 	depends on PKCS7_MESSAGE_PARSER
 
+config CHECK_CODESIGN_EKU
+	bool "Check codeSigning extended key usage"
+	depends on PKCS7_MESSAGE_PARSER=y
+	depends on SYSTEM_DATA_VERIFICATION
+	help
+	  This option provides support for checking the codeSigning extended
+	  key usage when verifying the signature in PKCS#7. It affects kernel
+	  module verification and kexec PE binary verification.
+
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_keys/pkcs7_trust.c
index 9a87c34ed173..087d3761d9a8 100644
--- a/crypto/asymmetric_keys/pkcs7_trust.c
+++ b/crypto/asymmetric_keys/pkcs7_trust.c
@@ -16,12 +16,40 @@
 #include <crypto/public_key.h>
 #include "pkcs7_parser.h"
 
+#ifdef CONFIG_CHECK_CODESIGN_EKU
+static bool check_eku_by_usage(struct key *key, enum key_being_used_for usage)
+{
+	struct public_key *public_key = key->payload.data[asym_crypto];
+	bool ret = true;
+
+	switch (usage) {
+	case VERIFYING_MODULE_SIGNATURE:
+	case VERIFYING_KEXEC_PE_SIGNATURE:
+		ret = !!(public_key->ext_key_usage & EKU_codeSigning);
+		if (!ret)
+			pr_warn("The signer '%s' key is not CodeSigning\n",
+				key->description);
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+#else
+static bool check_eku_by_usage(struct key *key, enum key_being_used_for usage)
+{
+	return true;
+}
+#endif
+
 /*
  * Check the trust on one PKCS#7 SignedInfo block.
  */
 static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
 				    struct pkcs7_signed_info *sinfo,
-				    struct key *trust_keyring)
+				    struct key *trust_keyring,
+				    enum key_being_used_for usage,
+				    bool check_eku)
 {
 	struct public_key_signature *sig = sinfo->sig;
 	struct x509_certificate *x509, *last = NULL, *p;
@@ -112,6 +140,10 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
 	return -ENOKEY;
 
 matched:
+	if (check_eku && !check_eku_by_usage(key, usage)) {
+		key_put(key);
+		return -ENOKEY;
+	}
 	ret = verify_signature(key, sig);
 	key_put(key);
 	if (ret < 0) {
@@ -135,6 +167,8 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
  * pkcs7_validate_trust - Validate PKCS#7 trust chain
  * @pkcs7: The PKCS#7 certificate to validate
  * @trust_keyring: Signing certificates to use as starting points
+ * @usage: The use to which the key is being put.
+ * @check_eku: Check EKU (Extended Key Usage)
  *
  * Validate that the certificate chain inside the PKCS#7 message intersects
  * keys we already know and trust.
@@ -156,7 +190,9 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
  * May also return -ENOMEM.
  */
 int pkcs7_validate_trust(struct pkcs7_message *pkcs7,
-			 struct key *trust_keyring)
+			 struct key *trust_keyring,
+			 enum key_being_used_for usage,
+			 bool check_eku)
 {
 	struct pkcs7_signed_info *sinfo;
 	struct x509_certificate *p;
@@ -167,7 +203,8 @@ int pkcs7_validate_trust(struct pkcs7_message *pkcs7,
 		p->seen = false;
 
 	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next) {
-		ret = pkcs7_validate_trust_one(pkcs7, sinfo, trust_keyring);
+		ret = pkcs7_validate_trust_one(pkcs7, sinfo, trust_keyring,
+					       usage, check_eku);
 		switch (ret) {
 		case -ENOKEY:
 			continue;
diff --git a/crypto/asymmetric_keys/selftest.c b/crypto/asymmetric_keys/selftest.c
index fa0bf7f24284..756e9f224d8a 100644
--- a/crypto/asymmetric_keys/selftest.c
+++ b/crypto/asymmetric_keys/selftest.c
@@ -212,7 +212,7 @@ int __init fips_signature_selftest(void)
 		if (ret < 0)
 			panic("Certs selftest %d: pkcs7_verify() = %d\n", i, ret);
 
-		ret = pkcs7_validate_trust(pkcs7, keyring);
+		ret = pkcs7_validate_trust(pkcs7, keyring, VERIFYING_MODULE_SIGNATURE, false);
 		if (ret < 0)
 			panic("Certs selftest %d: pkcs7_validate_trust() = %d\n", i, ret);
 
diff --git a/include/crypto/pkcs7.h b/include/crypto/pkcs7.h
index 38ec7f5f9041..5d87b8a02f79 100644
--- a/include/crypto/pkcs7.h
+++ b/include/crypto/pkcs7.h
@@ -30,7 +30,9 @@ extern int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
  * pkcs7_trust.c
  */
 extern int pkcs7_validate_trust(struct pkcs7_message *pkcs7,
-				struct key *trust_keyring);
+				struct key *trust_keyring,
+				enum key_being_used_for usage,
+				bool check_eku);
 
 /*
  * pkcs7_verify.c
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 91e080efb918..bb33b527240e 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -9,6 +9,7 @@
 #define _KEYS_SYSTEM_KEYRING_H
 
 #include <linux/key.h>
+#include <keys/asymmetric-type.h>
 
 enum blacklist_hash_type {
 	/* TBSCertificate hash */
@@ -81,13 +82,15 @@ static inline int is_binary_blacklisted(const u8 *hash, size_t hash_len)
 
 #ifdef CONFIG_SYSTEM_REVOCATION_LIST
 extern int add_key_to_revocation_list(const char *data, size_t size);
-extern int is_key_on_revocation_list(struct pkcs7_message *pkcs7);
+extern int is_key_on_revocation_list(struct pkcs7_message *pkcs7,
+				     enum key_being_used_for usage);
 #else
 static inline int add_key_to_revocation_list(const char *data, size_t size)
 {
 	return 0;
 }
-static inline int is_key_on_revocation_list(struct pkcs7_message *pkcs7)
+static inline int is_key_on_revocation_list(struct pkcs7_message *pkcs7,
+					    enum key_being_used_for usage)
 {
 	return -ENOKEY;
 }
-- 
2.26.2

