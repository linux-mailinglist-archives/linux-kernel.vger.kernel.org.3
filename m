Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898395572E6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiFWGPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiFWGPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:15:15 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50612CE06
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:15:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so1589569pjz.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oTdRX4nzzh5XnScdkMS8ZCJNByGLkKSHjz8cEvYbU9o=;
        b=D497u8ltIwHyH0cjmk5+9ujb4d8BsmOVJEVh1DplnRz36O6jiHh+AfEKpvRNDxEU5h
         NbbDB6IvDv6xUYX2qwu2RtqSToEMUKVMCundGguJ/kmyUh+eu/WIQBROeEObcGn72wbm
         lS+eFwFqWNqHRpvApI8kqW4o9m9coViBB/YB2xsPbBUHvHUpgE1MmWxaFRcuRM3ROmZj
         yN/kZtDhrm7cQ2F1dHtsuIIrvf3JPmlnYo7xbE95IItIV+wLo2w86DXBMXxAWsge3jg4
         6YAyzMdDwQcNNB+EF4UKJIfvgJ0nemxIXdIjAjWrIFxcKkb0VFrQHbWGg+of4kRp0vTu
         QE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oTdRX4nzzh5XnScdkMS8ZCJNByGLkKSHjz8cEvYbU9o=;
        b=fvxKsnhNi5sa9urS/gdyGrgue4ijDZh4SBf8jsmKzxdogB/TfGCIPl7hVog6Lq6t0E
         CX0insC3nSwPPjUgWYh38ctfRo2nciHpTnET3yn9reoJnY5d+Bf51f0sZDgM+cMRuKY/
         U75P3cogiPwBQ/mRWPV7yIefk3u5beLhaM5aFe1cGAl8QnqwTtru7aFQsJjEtIyNYhUu
         f1cM69UjySN+w0nVt4xwz2CvpogfGMZEaBLpaXEl3Uzt6ZqV4vfdThaSOK5QNt058Jqt
         qABtHdqFxRsA7n015KbQDQiSRi3cpKugtQKjAkAtSUOlLILkTK83+qW/Y8QPbgOfCUv+
         G7jA==
X-Gm-Message-State: AJIora9me5vjWPCikk1CPYezRCTa3bAW1xCvDr9O7pfjbZqpprjK6rfh
        X2a8GsUDYFbCIEkF+QtpvE1h4w==
X-Google-Smtp-Source: AGRyM1u+kUriTQ+YpHfPIMLDHaJOtv19+9y3fQAqtSvu0h+Q6l2ikp3Z8qM1TdZ39IiBnYldQlDIkg==
X-Received: by 2002:a17:902:d5c3:b0:168:f037:98d7 with SMTP id g3-20020a170902d5c300b00168f03798d7mr37421289plh.117.1655964914258;
        Wed, 22 Jun 2022 23:15:14 -0700 (PDT)
Received: from FVFDK26JP3YV.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090264d600b0015e8d4eb1b6sm350992pli.0.2022.06.22.23.15.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jun 2022 23:15:13 -0700 (PDT)
From:   Lei He <helei.sig11@bytedance.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com
Cc:     mst@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, berrange@redhat.com,
        pizhenwei@bytedance.com, lei he <helei.sig11@bytedance.com>
Subject: [PATCH v2 1/4] crypto: fix the calculation of max_size for ECDSA
Date:   Thu, 23 Jun 2022 14:14:57 +0800
Message-Id: <20220623061500.78331-1-helei.sig11@bytedance.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lei he <helei.sig11@bytedance.com>

The signature of ECDSA is consists of two big integers up to the
size of keylen, and is DER encoded into one SEQUENCE.
Calculate max_size of ECDSA signature more accurately according to
the DER encoding rules.

Signed-off-by: lei he <helei.sig11@bytedance.com>
---
 crypto/Kconfig                  |  1 +
 crypto/Makefile                 |  2 ++
 crypto/ecdsa.c                  |  3 ++-
 crypto/ecdsa_helper.c           | 45 +++++++++++++++++++++++++++++++++
 include/crypto/internal/ecdsa.h | 15 +++++++++++
 include/linux/asn1_encoder.h    |  2 ++
 lib/asn1_encoder.c              |  3 ++-
 7 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100644 crypto/ecdsa_helper.c
 create mode 100644 include/crypto/internal/ecdsa.h

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 19197469cfab..3e82c7bc8424 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -254,6 +254,7 @@ config CRYPTO_ECDSA
 	select CRYPTO_ECC
 	select CRYPTO_AKCIPHER
 	select ASN1
+	select ASN1_ENCODER
 	help
 	  Elliptic Curve Digital Signature Algorithm (NIST P192, P256 etc.)
 	  is A NIST cryptographic standard algorithm. Only signature verification
diff --git a/crypto/Makefile b/crypto/Makefile
index 43bc33e247d1..226bc2cfb9b7 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -52,8 +52,10 @@ obj-$(CONFIG_CRYPTO_SM2) += sm2_generic.o
 
 $(obj)/ecdsasignature.asn1.o: $(obj)/ecdsasignature.asn1.c $(obj)/ecdsasignature.asn1.h
 $(obj)/ecdsa.o: $(obj)/ecdsasignature.asn1.h
+
 ecdsa_generic-y += ecdsa.o
 ecdsa_generic-y += ecdsasignature.asn1.o
+ecdsa_generic-y += ecdsa_helper.o
 obj-$(CONFIG_CRYPTO_ECDSA) += ecdsa_generic.o
 
 crypto_acompress-y := acompress.o
diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index b3a8a6b572ba..2ba44c92d271 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <crypto/internal/akcipher.h>
 #include <crypto/internal/ecc.h>
+#include <crypto/internal/ecdsa.h>
 #include <crypto/akcipher.h>
 #include <crypto/ecdh.h>
 #include <linux/asn1_decoder.h>
@@ -262,7 +263,7 @@ static unsigned int ecdsa_max_size(struct crypto_akcipher *tfm)
 {
 	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
 
-	return ctx->pub_key.ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
+	return ecdsa_max_signature_size(ctx->curve);
 }
 
 static int ecdsa_nist_p384_init_tfm(struct crypto_akcipher *tfm)
diff --git a/crypto/ecdsa_helper.c b/crypto/ecdsa_helper.c
new file mode 100644
index 000000000000..487c4e9c0f67
--- /dev/null
+++ b/crypto/ecdsa_helper.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RSA key extract helper
+ *
+ * Copyright 2022 Bytedance CO., LTD.
+ *
+ * Authors: lei he <helei.sig11@bytedance.com>
+ */
+#include <crypto/internal/ecdsa.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/oid_registry.h>
+#include <linux/asn1_encoder.h>
+#include <crypto/ecdh.h>
+
+unsigned int ecdsa_max_signature_size(const struct ecc_curve *curve)
+{
+	unsigned int keylen = curve->g.ndigits * sizeof(u64);
+	/* Up to one extra byte to indicate the format */
+	unsigned char buffer[sizeof(size_t) + 1], *data = buffer;
+	int buffer_len = sizeof(buffer);
+	unsigned int coordinate_length, sequence_length;
+
+	asn1_encode_length(&data, &buffer_len, keylen);
+	/**
+	 * The extra cost for encoding keylen bytes as INTEGER in ASN.1:
+	 * 1. one byte for tag
+	 * 2. sizeof(buffer) - buffer_len bytes for length
+	 * 3. one leading zero byte for integers whose leftmost bit is 1
+	 */
+	coordinate_length = 1 + sizeof(buffer) - buffer_len + 1 + keylen;
+
+	/**
+	 * The extra cost for encoding coordinate_length * 2 bytes as SEQUENCE in ASN.1:
+	 * 1. one byte for tag
+	 * 2. sizeof(buffer) - buffer_len bytes for length
+	 */
+	buffer_len = sizeof(buffer);
+	data = buffer;
+	asn1_encode_length(&data, &buffer_len, coordinate_length * 2);
+	sequence_length = 1 + sizeof(buffer) - buffer_len + coordinate_length * 2;
+
+	return sequence_length;
+}
+EXPORT_SYMBOL_GPL(ecdsa_max_signature_size);
diff --git a/include/crypto/internal/ecdsa.h b/include/crypto/internal/ecdsa.h
new file mode 100644
index 000000000000..e35638a35dc2
--- /dev/null
+++ b/include/crypto/internal/ecdsa.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * ECDSA internal helpers
+ *
+ * Copyright (c) 2022 lei he <helei.sig11@bytedance.com>
+ */
+
+ #ifndef _CRYPTO_ECDSA_H
+ #define _CRYPTO_ECDSA_H
+
+#include <crypto/ecc_curve.h>
+
+unsigned int ecdsa_max_signature_size(const struct ecc_curve *curve);
+
+#endif
diff --git a/include/linux/asn1_encoder.h b/include/linux/asn1_encoder.h
index 08cd0c2ad34f..fe439c9a73e3 100644
--- a/include/linux/asn1_encoder.h
+++ b/include/linux/asn1_encoder.h
@@ -29,4 +29,6 @@ unsigned char *
 asn1_encode_boolean(unsigned char *data, const unsigned char *end_data,
 		    bool val);
 
+int asn1_encode_length(unsigned char **data, int *data_len, int len);
+
 #endif
diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
index 0fd3c454a468..644af3055ebb 100644
--- a/lib/asn1_encoder.c
+++ b/lib/asn1_encoder.c
@@ -188,7 +188,7 @@ EXPORT_SYMBOL_GPL(asn1_encode_oid);
  * encoder primitives to accept negative lengths as singalling the
  * sequence will be re-encoded when the length is known.
  */
-static int asn1_encode_length(unsigned char **data, int *data_len, int len)
+int asn1_encode_length(unsigned char **data, int *data_len, int len)
 {
 	if (*data_len < 1)
 		return -EINVAL;
@@ -239,6 +239,7 @@ static int asn1_encode_length(unsigned char **data, int *data_len, int len)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(asn1_encode_length);
 
 /**
  * asn1_encode_tag() - add a tag for optional or explicit value
-- 
2.20.1

