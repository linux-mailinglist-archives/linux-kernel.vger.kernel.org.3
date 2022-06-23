Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A31855738B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiFWHGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiFWHGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:06:18 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D358745538
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:06:17 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id bo5so18252468pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sw1AsX4+YjrzQ9dHdhmu4386jZ8eu/IQm0FavLE5MGw=;
        b=hyYl8JFfe/q9J9rmw0YuR8LwAohNVQbOKSPc003Wc4Du/qOZ3wJhwsY9uHAHzws42b
         xALz9+ynoefQPKtUNZ90x9nS0cCzOiFDwAJdt3XukhwIQsHEeW5ONQgDcomWj2t3FOoS
         +PmqUnJT5VLVVu4f9relTaRysf13I319ngZ5cErOsycgs8zuKuHZ5Iu6UEA547Cp7mZR
         HaJGwuSWTIty0eO3vlws+yZ8oFDVOSXE7dTm/uj6zi0fc6t1Q/BiLvZZVLVyAf2xAuyD
         ATO/Xfka2w0h9iaFBHtDr1Mmd47Zns86waY9IllSsz0GKpaEDNe6MiW6lDytTTmFJqkD
         ICwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sw1AsX4+YjrzQ9dHdhmu4386jZ8eu/IQm0FavLE5MGw=;
        b=5A+3CAjOAqgYZcwIqoDV23pmrZmvEe5fH43fcJqIms+NLiq3OFpgt8Eb+D0WytlDNU
         UcqYKbOxX4/8YhXfujuRpf4AVF/bcDRJkn264TByPodwvmVa1sWa+5+W96qIG42Jj9ly
         CYQiNU31TdHSIXtmeFnqkOnBcmmPkM9lnmWo+deD+Qn3qKcMlJJAbs+s0yjrjCS5gF2R
         U8lacmCvcFTLIE5oRjSjVCjrfZ/xtfDH/FjqgeT0LVHeGdKxznPSUu5i4n2hv4sPp2dc
         3PsmCuiUcqi9efunlr6c6tLetTiHj6B7Z6wHHPJi1hnUWnVxmoc3u6P20ILzXneaOswL
         SUAg==
X-Gm-Message-State: AJIora8N6m6FuNYqFMl+DdtFDyuLZpKfzXJB+xCXyHDtr9e23Yhv905G
        W1Nwcbzl9Rt9GUE9FrKssZh/BA==
X-Google-Smtp-Source: AGRyM1vffzub1Fbz63D9i7IlI1H1IxyGcdcJsI67Z+Od3peIYCItJCc5tzWEAp+zPl7HGVqLcP2pyg==
X-Received: by 2002:a63:1559:0:b0:3f5:fdf7:12e2 with SMTP id 25-20020a631559000000b003f5fdf712e2mr6357491pgv.13.1655967977270;
        Thu, 23 Jun 2022 00:06:17 -0700 (PDT)
Received: from FVFDK26JP3YV.bytedance.net ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b0016a15842cf5sm9125184plb.121.2022.06.23.00.06.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 00:06:16 -0700 (PDT)
From:   Lei He <helei.sig11@bytedance.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com
Cc:     mst@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, berrange@redhat.com,
        pizhenwei@bytedance.com, lei he <helei.sig11@bytedance.com>
Subject: [PATCH v2 4/4] virtio-crypto: support ECDSA algorithm
Date:   Thu, 23 Jun 2022 15:05:50 +0800
Message-Id: <20220623070550.82053-5-helei.sig11@bytedance.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220623070550.82053-1-helei.sig11@bytedance.com>
References: <20220623070550.82053-1-helei.sig11@bytedance.com>
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

Support ECDSA algorithm for driver virtio-crypto

Signed-off-by: lei he <helei.sig11@bytedance.com>
---
 drivers/crypto/virtio/Kconfig                 |   1 +
 .../virtio/virtio_crypto_akcipher_algs.c      | 259 ++++++++++++++++--
 2 files changed, 239 insertions(+), 21 deletions(-)

diff --git a/drivers/crypto/virtio/Kconfig b/drivers/crypto/virtio/Kconfig
index 5f8915f4a9ff..c4b66cf17d7c 100644
--- a/drivers/crypto/virtio/Kconfig
+++ b/drivers/crypto/virtio/Kconfig
@@ -6,6 +6,7 @@ config CRYPTO_DEV_VIRTIO
 	select CRYPTO_AKCIPHER2
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ENGINE
+	select CRYPTO_ECDSA
 	select CRYPTO_RSA
 	select MPILIB
 	help
diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index 2a60d0525cde..da628a6de696 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -10,7 +10,9 @@
 #include <linux/mpi.h>
 #include <linux/scatterlist.h>
 #include <crypto/algapi.h>
+#include <crypto/ecdh.h>
 #include <crypto/internal/akcipher.h>
+#include <crypto/internal/ecdsa.h>
 #include <crypto/internal/rsa.h>
 #include <linux/err.h>
 #include <crypto/scatterwalk.h>
@@ -23,6 +25,10 @@ struct virtio_crypto_rsa_ctx {
 	MPI n;
 };
 
+struct virtio_crypto_ecdsa_ctx {
+	const struct ecc_curve *curve;
+};
+
 struct virtio_crypto_akcipher_ctx {
 	struct crypto_engine_ctx enginectx;
 	struct virtio_crypto *vcrypto;
@@ -31,6 +37,7 @@ struct virtio_crypto_akcipher_ctx {
 	__u64 session_id;
 	union {
 		struct virtio_crypto_rsa_ctx rsa_ctx;
+		struct virtio_crypto_ecdsa_ctx ecdsa_ctx;
 	};
 };
 
@@ -279,7 +286,7 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
 	return -ENOMEM;
 }
 
-static int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
+static int virtio_crypto_akcipher_do_req(struct crypto_engine *engine, void *vreq, int algo)
 {
 	struct akcipher_request *req = container_of(vreq, struct akcipher_request, base);
 	struct virtio_crypto_akcipher_request *vc_akcipher_req = akcipher_request_ctx(req);
@@ -300,7 +307,7 @@ static int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
 	/* build request header */
 	header = &vc_req->req_data->header;
 	header->opcode = cpu_to_le32(vc_akcipher_req->opcode);
-	header->algo = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_RSA);
+	header->algo = cpu_to_le32(algo);
 	header->session_id = cpu_to_le64(ctx->session_id);
 
 	/* build request akcipher data */
@@ -318,7 +325,12 @@ static int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
 	return 0;
 }
 
-static int virtio_crypto_rsa_req(struct akcipher_request *req, uint32_t opcode)
+static int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
+{
+	return virtio_crypto_akcipher_do_req(engine, vreq, VIRTIO_CRYPTO_AKCIPHER_RSA);
+}
+
+static int virtio_crypto_akcipher_req(struct akcipher_request *req, uint32_t opcode)
 {
 	struct crypto_akcipher *atfm = crypto_akcipher_reqtfm(req);
 	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(atfm);
@@ -337,24 +349,24 @@ static int virtio_crypto_rsa_req(struct akcipher_request *req, uint32_t opcode)
 	return crypto_transfer_akcipher_request_to_engine(data_vq->engine, req);
 }
 
-static int virtio_crypto_rsa_encrypt(struct akcipher_request *req)
+static int virtio_crypto_akcipher_encrypt(struct akcipher_request *req)
 {
-	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_ENCRYPT);
+	return virtio_crypto_akcipher_req(req, VIRTIO_CRYPTO_AKCIPHER_ENCRYPT);
 }
 
-static int virtio_crypto_rsa_decrypt(struct akcipher_request *req)
+static int virtio_crypto_akcipher_decrypt(struct akcipher_request *req)
 {
-	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_DECRYPT);
+	return virtio_crypto_akcipher_req(req, VIRTIO_CRYPTO_AKCIPHER_DECRYPT);
 }
 
-static int virtio_crypto_rsa_sign(struct akcipher_request *req)
+static int virtio_crypto_akcipher_sign(struct akcipher_request *req)
 {
-	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_SIGN);
+	return virtio_crypto_akcipher_req(req, VIRTIO_CRYPTO_AKCIPHER_SIGN);
 }
 
-static int virtio_crypto_rsa_verify(struct akcipher_request *req)
+static int virtio_crypto_akcipher_verify(struct akcipher_request *req)
 {
-	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_VERIFY);
+	return virtio_crypto_akcipher_req(req, VIRTIO_CRYPTO_AKCIPHER_VERIFY);
 }
 
 static int virtio_crypto_rsa_set_key(struct crypto_akcipher *tfm,
@@ -484,18 +496,161 @@ static void virtio_crypto_rsa_exit_tfm(struct crypto_akcipher *tfm)
 	struct virtio_crypto_rsa_ctx *rsa_ctx = &ctx->rsa_ctx;
 
 	virtio_crypto_alg_akcipher_close_session(ctx);
-	virtcrypto_dev_put(ctx->vcrypto);
+	if (ctx->vcrypto)
+		virtcrypto_dev_put(ctx->vcrypto);
 	mpi_free(rsa_ctx->n);
 	rsa_ctx->n = NULL;
 }
 
+static int virtio_crypto_ecdsa_do_req(struct crypto_engine *engine, void *vreq)
+{
+	return virtio_crypto_akcipher_do_req(engine, vreq, VIRTIO_CRYPTO_AKCIPHER_ECDSA);
+}
+
+static int virtio_crypto_ecdsa_set_key(struct crypto_akcipher *tfm,
+				       const void *key,
+				       unsigned int keylen,
+				       bool private,
+				       int curve_id)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct virtio_crypto *vcrypto;
+	struct virtio_crypto_ctrl_header header;
+	struct virtio_crypto_akcipher_session_para para;
+	int node = virtio_crypto_get_current_node();
+	uint32_t keytype;
+
+	if (private)
+		keytype = VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE;
+	else
+		keytype = VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC;
+
+	if (!ctx->vcrypto) {
+		vcrypto = virtcrypto_get_dev_node(node, VIRTIO_CRYPTO_SERVICE_AKCIPHER,
+						VIRTIO_CRYPTO_AKCIPHER_RSA);
+		if (!vcrypto) {
+			pr_err("virtio_crypto: Could not find a virtio device in the system or unsupported algo\n");
+			return -ENODEV;
+		}
+
+		ctx->vcrypto = vcrypto;
+	} else {
+		virtio_crypto_alg_akcipher_close_session(ctx);
+	}
+
+	/* set ctrl header */
+	header.opcode =	cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION);
+	header.algo = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_ECDSA);
+	header.queue_id = 0;
+
+	/* set ECDSA para */
+	para.algo = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_ECDSA);
+	para.keytype = cpu_to_le32(keytype);
+	para.keylen = cpu_to_le32(keylen);
+	para.u.ecdsa.curve_id = cpu_to_le32(curve_id);
+
+	return virtio_crypto_alg_akcipher_init_session(ctx, &header, &para, key, keylen);
+}
+
+static int virtio_crypto_ecdsa_nist_p192_set_pub_key(struct crypto_akcipher *tfm,
+						     const void *key,
+						     unsigned int keylen)
+{
+	return virtio_crypto_ecdsa_set_key(tfm, key, keylen, 0, VIRTIO_CRYPTO_CURVE_NIST_P192);
+}
+
+static int virtio_crypto_ecdsa_nist_p192_set_priv_key(struct crypto_akcipher *tfm,
+						      const void *key,
+						      unsigned int keylen)
+{
+	return virtio_crypto_ecdsa_set_key(tfm, key, keylen, 1, VIRTIO_CRYPTO_CURVE_NIST_P192);
+}
+
+static int virtio_crypto_ecdsa_nist_p256_set_pub_key(struct crypto_akcipher *tfm,
+						     const void *key,
+						     unsigned int keylen)
+{
+	return virtio_crypto_ecdsa_set_key(tfm, key, keylen, 0, VIRTIO_CRYPTO_CURVE_NIST_P256);
+}
+
+static int virtio_crypto_ecdsa_nist_p256_set_priv_key(struct crypto_akcipher *tfm,
+						      const void *key,
+						      unsigned int keylen)
+{
+	return virtio_crypto_ecdsa_set_key(tfm, key, keylen, 1, VIRTIO_CRYPTO_CURVE_NIST_P256);
+}
+
+static int virtio_crypto_ecdsa_nist_p384_set_pub_key(struct crypto_akcipher *tfm,
+						     const void *key,
+						     unsigned int keylen)
+{
+	return virtio_crypto_ecdsa_set_key(tfm, key, keylen, 0, VIRTIO_CRYPTO_CURVE_NIST_P384);
+}
+
+static int virtio_crypto_ecdsa_nist_p384_set_priv_key(struct crypto_akcipher *tfm,
+						      const void *key,
+						      unsigned int keylen)
+{
+	return virtio_crypto_ecdsa_set_key(tfm, key, keylen, 1, VIRTIO_CRYPTO_CURVE_NIST_P384);
+}
+
+static unsigned int virtio_crypto_ecdsa_max_size(struct crypto_akcipher *tfm)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct virtio_crypto_ecdsa_ctx *ecdsa_ctx = &ctx->ecdsa_ctx;
+
+	return ecdsa_max_signature_size(ecdsa_ctx->curve);
+}
+
+static int virtio_crypto_ecdsa_init_tfm(struct crypto_akcipher *tfm, unsigned int curve_id)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	ctx->tfm = tfm;
+	ctx->enginectx.op.do_one_request = virtio_crypto_ecdsa_do_req;
+	ctx->enginectx.op.prepare_request = NULL;
+	ctx->enginectx.op.unprepare_request = NULL;
+	ctx->ecdsa_ctx.curve = ecc_get_curve(curve_id);
+
+	if (!ctx->ecdsa_ctx.curve)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int virtio_crypto_ecdsa_nist_p192_init_tfm(struct crypto_akcipher *tfm)
+{
+	return virtio_crypto_ecdsa_init_tfm(tfm, ECC_CURVE_NIST_P192);
+}
+
+static int virtio_crypto_ecdsa_nist_p256_init_tfm(struct crypto_akcipher *tfm)
+{
+	return virtio_crypto_ecdsa_init_tfm(tfm, ECC_CURVE_NIST_P256);
+}
+
+static int virtio_crypto_ecdsa_nist_p384_init_tfm(struct crypto_akcipher *tfm)
+{
+	return virtio_crypto_ecdsa_init_tfm(tfm, ECC_CURVE_NIST_P384);
+}
+
+static void virtio_crypto_ecdsa_exit_tfm(struct crypto_akcipher *tfm)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct virtio_crypto_ecdsa_ctx *ecdsa_ctx = &ctx->ecdsa_ctx;
+
+	virtio_crypto_alg_akcipher_close_session(ctx);
+	ecdsa_ctx->curve = NULL;
+	if (ctx->vcrypto)
+		virtcrypto_dev_put(ctx->vcrypto);
+}
+
 static struct virtio_crypto_akcipher_algo virtio_crypto_akcipher_algs[] = {
 	{
 		.algonum = VIRTIO_CRYPTO_AKCIPHER_RSA,
 		.service = VIRTIO_CRYPTO_SERVICE_AKCIPHER,
 		.algo = {
-			.encrypt = virtio_crypto_rsa_encrypt,
-			.decrypt = virtio_crypto_rsa_decrypt,
+			.encrypt = virtio_crypto_akcipher_encrypt,
+			.decrypt = virtio_crypto_akcipher_decrypt,
 			.set_pub_key = virtio_crypto_rsa_raw_set_pub_key,
 			.set_priv_key = virtio_crypto_rsa_raw_set_priv_key,
 			.max_size = virtio_crypto_rsa_max_size,
@@ -515,10 +670,10 @@ static struct virtio_crypto_akcipher_algo virtio_crypto_akcipher_algs[] = {
 		.algonum = VIRTIO_CRYPTO_AKCIPHER_RSA,
 		.service = VIRTIO_CRYPTO_SERVICE_AKCIPHER,
 		.algo = {
-			.encrypt = virtio_crypto_rsa_encrypt,
-			.decrypt = virtio_crypto_rsa_decrypt,
-			.sign = virtio_crypto_rsa_sign,
-			.verify = virtio_crypto_rsa_verify,
+			.encrypt = virtio_crypto_akcipher_encrypt,
+			.decrypt = virtio_crypto_akcipher_decrypt,
+			.sign = virtio_crypto_akcipher_sign,
+			.verify = virtio_crypto_akcipher_verify,
 			.set_pub_key = virtio_crypto_p1pad_rsa_sha1_set_pub_key,
 			.set_priv_key = virtio_crypto_p1pad_rsa_sha1_set_priv_key,
 			.max_size = virtio_crypto_rsa_max_size,
@@ -534,6 +689,70 @@ static struct virtio_crypto_akcipher_algo virtio_crypto_akcipher_algs[] = {
 			},
 		},
 	},
+	{
+		.algonum = VIRTIO_CRYPTO_AKCIPHER_ECDSA,
+		.service = VIRTIO_CRYPTO_SERVICE_AKCIPHER,
+		.algo = {
+			.sign = virtio_crypto_akcipher_sign,
+			.verify = virtio_crypto_akcipher_verify,
+			.set_pub_key = virtio_crypto_ecdsa_nist_p192_set_pub_key,
+			.set_priv_key = virtio_crypto_ecdsa_nist_p192_set_priv_key,
+			.max_size = virtio_crypto_ecdsa_max_size,
+			.init = virtio_crypto_ecdsa_nist_p192_init_tfm,
+			.exit = virtio_crypto_ecdsa_exit_tfm,
+			.reqsize = sizeof(struct virtio_crypto_akcipher_request),
+			.base = {
+				.cra_name = "ecdsa-nist-p192",
+				.cra_driver_name = "virtio-ecdsa-nist-p192",
+				.cra_priority = 150,
+				.cra_module = THIS_MODULE,
+				.cra_ctxsize = sizeof(struct virtio_crypto_akcipher_ctx),
+			},
+		},
+	},
+	{
+		.algonum = VIRTIO_CRYPTO_AKCIPHER_ECDSA,
+		.service = VIRTIO_CRYPTO_SERVICE_AKCIPHER,
+		.algo = {
+			.sign = virtio_crypto_akcipher_sign,
+			.verify = virtio_crypto_akcipher_verify,
+			.set_pub_key = virtio_crypto_ecdsa_nist_p256_set_pub_key,
+			.set_priv_key = virtio_crypto_ecdsa_nist_p256_set_priv_key,
+			.max_size = virtio_crypto_ecdsa_max_size,
+			.init = virtio_crypto_ecdsa_nist_p256_init_tfm,
+			.exit = virtio_crypto_ecdsa_exit_tfm,
+			.reqsize = sizeof(struct virtio_crypto_akcipher_request),
+			.base = {
+				.cra_name = "ecdsa-nist-p256",
+				.cra_driver_name = "virtio-ecdsa-nist-p256",
+				.cra_priority = 150,
+				.cra_module = THIS_MODULE,
+				.cra_ctxsize = sizeof(struct virtio_crypto_akcipher_ctx),
+			},
+		},
+	},
+	{
+		.algonum = VIRTIO_CRYPTO_AKCIPHER_ECDSA,
+		.service = VIRTIO_CRYPTO_SERVICE_AKCIPHER,
+		.algo = {
+			.sign = virtio_crypto_akcipher_sign,
+			.verify = virtio_crypto_akcipher_verify,
+			.set_pub_key = virtio_crypto_ecdsa_nist_p384_set_pub_key,
+			.set_priv_key = virtio_crypto_ecdsa_nist_p384_set_priv_key,
+			.max_size = virtio_crypto_ecdsa_max_size,
+			.init = virtio_crypto_ecdsa_nist_p384_init_tfm,
+			.exit = virtio_crypto_ecdsa_exit_tfm,
+			.reqsize = sizeof(struct virtio_crypto_akcipher_request),
+			.base = {
+				.cra_name = "ecdsa-nist-p384",
+				.cra_driver_name = "virtio-ecdsa-nist-p384",
+				.cra_priority = 150,
+				.cra_module = THIS_MODULE,
+				.cra_ctxsize = sizeof(struct virtio_crypto_akcipher_ctx),
+			},
+		},
+
+	},
 };
 
 int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto)
@@ -552,8 +771,7 @@ int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto)
 
 		if (virtio_crypto_akcipher_algs[i].active_devs == 0) {
 			ret = crypto_register_akcipher(&virtio_crypto_akcipher_algs[i].algo);
-			if (ret)
-				goto unlock;
+			continue;
 		}
 
 		virtio_crypto_akcipher_algs[i].active_devs++;
@@ -561,7 +779,6 @@ int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto)
 			 virtio_crypto_akcipher_algs[i].algo.base.cra_name);
 	}
 
-unlock:
 	mutex_unlock(&algs_lock);
 	return ret;
 }
-- 
2.20.1

