Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532715A1376
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241582AbiHYOXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240437AbiHYOXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:23:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B946EB6D03;
        Thu, 25 Aug 2022 07:23:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso5098888pjh.5;
        Thu, 25 Aug 2022 07:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=qJZNpZs822e167cNj4VwoEt4GRcumhG3qGUAL/pW/hc=;
        b=j9mSZG5WB5yPZtTLB05OTiqTaxaonHkBD+PtcWdNLR+7y+28wxHmTCdnenT6BjSKwp
         F8oW6NgsECZK86jEDdXI6/OBmVdoV9OwVJF4DM4JJ4/2UjWjRLEpF/RCYZDWgR7zPR9n
         TOiUAB+orox1UWS7fRLvtAl9B/yzYan+4PMPCNpvEgk3CEqPSWY1O0tula/Oq5YM5BUp
         OtkClldOQ/Vehkc2f06pGRhKXeK9o5bas5K97WrlVS0YTPgPggrgB4rXXVFJXv1x2EwL
         deT9ALBTHqfz6KmJ0hQkm5aGPjGkGYamLXn/ZTU8nE/ZR61njCXcoemvRLoQ7kPwQaMW
         m/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=qJZNpZs822e167cNj4VwoEt4GRcumhG3qGUAL/pW/hc=;
        b=ld+tZNkHh3PN5wjd7a/AtpCNMSOaSvSTmVdkk6ZiRZMzC4C5tBBDwZLDywxShvK4B0
         2yNQVWP0XvjTv2nXKgEKRYuT1sro4B32y4+YSbxFOj3yL5KWbjLf6NElG3uQj7rT+Xgh
         iJrI8z6o1wnXKThw9kv0ue/ig6R76YHeIdSbb5BmIuuaD1JY/LBnJlglyhXX0gyg0soF
         CIGyy77DumW/pIHVatFw2ZPwZi1gSUoBJoswzxDqIA/ZSuVTFZE/w3eRpAeYdIZZWTRX
         x2rGFkkgBt4p7tHfQL3ClZHIvFlaA5kbBnM7nnb2wZSG7dcix72leVl1koe/8jhgtFj3
         oLwg==
X-Gm-Message-State: ACgBeo0Wj/a46TUbRLsgU0Wu6vnKQSn7gFL+hnRViyxKxNGxDJHw+ecz
        TDJa7enGuJWBFFi3NqEBkiU=
X-Google-Smtp-Source: AA6agR53fUwkcGWVqEeNmHHmmegg+cjYjN2LQNiNus8alPJTZA1cG0slSJbx+QhfIp1VuyME9VS4Qw==
X-Received: by 2002:a17:902:b685:b0:172:d097:fb54 with SMTP id c5-20020a170902b68500b00172d097fb54mr3947341pls.161.1661437402325;
        Thu, 25 Aug 2022 07:23:22 -0700 (PDT)
Received: from linux-l9pv.suse (123-194-152-128.dynamic.kbronet.com.tw. [123.194.152.128])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903120f00b0016bb24f5d19sm14962803plh.209.2022.08.25.07.23.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Aug 2022 07:23:22 -0700 (PDT)
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
Date:   Thu, 25 Aug 2022 22:23:11 +0800
Message-Id: <20220825142314.8406-2-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20220825142314.8406-1-jlee@suse.com>
References: <20220825142314.8406-1-jlee@suse.com>
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

