Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7689B572C80
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiGME0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiGME00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:26:26 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A486A5C9F4;
        Tue, 12 Jul 2022 21:26:25 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y141so9213855pfb.7;
        Tue, 12 Jul 2022 21:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qJZNpZs822e167cNj4VwoEt4GRcumhG3qGUAL/pW/hc=;
        b=dUDCJgkL0uWsNKRVjbCBjWa0Stxu9SLwsZ2r+5c5RuXoubCA+zkKjTVIjQflZV1Fjd
         tuTvDTGERk4udgG2auLHnUy9gC5/OXAw2t66Pta19/wJJp8hAC7us5o2+GhxJdeltzWp
         sAvZpBVirQ6ptTMufctA+rJRLaoCTihyoPY4UnQBDq5TYJWfcz2sGhfCoRHeIsbiAI13
         erDH17TCD6xongh1YnEblyWmbykMda7+h7tz9qbNRU8C33Kq6+ija54hMXYAe8QxPMu1
         9/vt0btc5RvH6dz6VwVv7wdF/nBzP9ZyXdUdRgYTlckCNnLu5xlGcu+Bcd3Bd3ZCJjM/
         R2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qJZNpZs822e167cNj4VwoEt4GRcumhG3qGUAL/pW/hc=;
        b=jR18Thi3gMhca5bHOxkUQi5UqTODo3BF9ln1DMRoGjlB5BIhzFH0NKceMKK/8ulw6f
         F55nSMdrMhSZKuxHPtZYElHC/Q0dheYsP35nplUDYnSTN7cbdep2k/+nG2TC3FlYPNXt
         gBSxYvxM0RCfMOrb8HXQb89s5by/mO2jpy1a84onsQ/+7LnRtUmo0s9VAuPaFLb/eM5f
         WrwSu78O/O1sJx/OLMZpTYHCdHAXYs8PSiWxYPZ1mcAOJCWLh0ZA1JlqRU8ygZiB5MKn
         4/Sx+YyDEfCe/eYQ+y7Bt86xlhKARc0jUWK0+NXuFtYe1trq9kBTgFLlSBO2y4q/TlOn
         P0/Q==
X-Gm-Message-State: AJIora8HEQjdN16zniTt51iKID13Md0MVjoIRT3GOoAhWissimo46mXE
        8yDfkQqN1XEyR9Vdenf4n1M=
X-Google-Smtp-Source: AGRyM1uYJbiA208PeDqsYlR4lC2wXaCMhLJqd2VE2fOhX2D0nsMiNXQFi4ccp5FIEUI/6q/gn21p8g==
X-Received: by 2002:a05:6a00:1a8b:b0:525:9c4f:ade5 with SMTP id e11-20020a056a001a8b00b005259c4fade5mr1518154pfv.74.1657686385227;
        Tue, 12 Jul 2022 21:26:25 -0700 (PDT)
Received: from linux-l9pv.suse (123-194-153-158.dynamic.kbronet.com.tw. [123.194.153.158])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090301c700b0016c4f006603sm4732513plh.54.2022.07.12.21.26.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2022 21:26:24 -0700 (PDT)
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
Subject: [PATCH v9,1/4] X.509: Add CodeSigning extended key usage parsing
Date:   Wed, 13 Jul 2022 12:24:18 +0800
Message-Id: <20220713042421.21680-2-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20220713042421.21680-1-jlee@suse.com>
References: <20220713042421.21680-1-jlee@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the logic for parsing the CodeSign extended key usage
extension in X.509. The parsing result will be set to the ext_key_usage
flag which is carried by public key. It can be used in the PKCS#7
verification.

Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 25 +++++++++++++++++++++++
 include/crypto/public_key.h               |  1 +
 include/linux/oid_registry.h              |  5 +++++
 3 files changed, 31 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 2899ed80bb18..1f67e0adef65 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -554,6 +554,8 @@ int x509_process_extension(void *context, size_t hdrlen,
 	struct x509_parse_context *ctx = context;
 	struct asymmetric_key_id *kid;
 	const unsigned char *v = value;
+	int i = 0;
+	enum OID oid;
 
 	pr_debug("Extension: %u\n", ctx->last_oid);
 
@@ -583,6 +585,29 @@ int x509_process_extension(void *context, size_t hdrlen,
 		return 0;
 	}
 
+	if (ctx->last_oid == OID_extKeyUsage) {
+		if (vlen < 2 ||
+		    v[0] != ((ASN1_UNIV << 6) | ASN1_CONS_BIT | ASN1_SEQ) ||
+		    v[1] != vlen - 2)
+			return -EBADMSG;
+		i += 2;
+
+		while (i < vlen) {
+			/* A 10 bytes EKU OID Octet blob =
+			 * ASN1_OID + size byte + 8 bytes OID */
+			if ((i + 10) > vlen || v[i] != ASN1_OID || v[i + 1] != 8)
+				return -EBADMSG;
+
+			oid = look_up_OID(v + i + 2, v[i + 1]);
+			if (oid == OID_codeSigning) {
+				ctx->cert->pub->ext_key_usage |= EKU_codeSigning;
+			}
+			i += 10;
+		}
+		pr_debug("extKeyUsage: %d\n", ctx->cert->pub->ext_key_usage);
+		return 0;
+	}
+
 	return 0;
 }
 
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 68f7aa2a7e55..72c0fcc39d0f 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -28,6 +28,7 @@ struct public_key {
 	bool key_is_private;
 	const char *id_type;
 	const char *pkey_algo;
+	unsigned int ext_key_usage : 9;      /* Extended Key Usage (9-bit) */
 };
 
 extern void public_key_free(struct public_key *key);
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 0f4a8903922a..460135c2d918 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -140,9 +140,14 @@ enum OID {
 	OID_TPMImportableKey,		/* 2.23.133.10.1.4 */
 	OID_TPMSealedData,		/* 2.23.133.10.1.5 */
 
+	/* Extended key purpose OIDs [RFC 5280] */
+	OID_codeSigning,		/* 1.3.6.1.5.5.7.3.3 */
+
 	OID__NR
 };
 
+#define EKU_codeSigning	(1 << 2)
+
 extern enum OID look_up_OID(const void *data, size_t datasize);
 extern int parse_OID(const void *data, size_t datasize, enum OID *oid);
 extern int sprint_oid(const void *, size_t, char *, size_t);
-- 
2.26.2

