Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EC554F174
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380534AbiFQHJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380451AbiFQHIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:08:55 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4315664D0B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:08:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so3428912pjz.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mNxvf0dysPqGeqaXEmlJUiXGB4Uji2CdxJcngPXkQ8g=;
        b=OSwg7HQaj3nGg0ObBHiJbHdqS5ow7StJ8oxQbnKT402V9tgP76EDje+JunCqG+ghGv
         5GNVVor2vJBnD8/v5SVKEGGqcvfmY0w+uwWqTfTOuBSmL5yOylBNr79Ltm9st1pAG2MN
         VIxp9Gx31mJRpoQv2YREMg3C+ulxbfDQid90WcFM08adz5PROqj3py3UBmOsIj8ihPWx
         ZnQ+FewcVR+WBPpRD3koDcAM5qEcSEFxbX3Q1gPe3mta5Kl3BVfBNsANsKDZ6aAcIAt5
         Uw2Gh9hGncUho3wV9YCqgwAgr3wyF9BZbZIPRZ0BKWpeus1d3mBxcrjQ9AQ/kkDg3zfT
         GhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNxvf0dysPqGeqaXEmlJUiXGB4Uji2CdxJcngPXkQ8g=;
        b=5JAXicfFqarTo+vzezh2yCrBT8qvWek+puvWwKiGzvRwLA348B7UXxC0tH/1qBgpEA
         0KA7Aca7gmXrV7555Q+XkMcfBaquzWQ1ZurPLiKRxZYX0yQ12mhR5xKcuWGb7BKK3j/d
         Aw8f4aXnDky4CKBQNfsEPX1szi2u8MkS1uqLXiGCQh8gveOV0SPd7dc4a3oakhoxzidC
         0UDqg4GVTTRj4uhm/YQ7p7qtFnFMfa2rHWDoiCdxC35Ef/h4dsoy7t3Fv/p16AE0Ojmt
         JYzK5Z21+w2Obu8xaDO5BeWWbZLIi9FQt1HarECxuWpmEY6LIEXqroIaw4rHgI0/1EIo
         tUtw==
X-Gm-Message-State: AJIora8jxvgl0ytNaecwZJfALy7d+AFsMzA/3NTT99RdP/t9rGcuyr1c
        2EBWQIuhFUCrX87XfMAyRr1Png==
X-Google-Smtp-Source: AGRyM1srWUOA5NLFVRQzpBMWPbgbVx9Yo54Z00OIZfUTL6Mhhh3sQlp36Zx1ZLmPZp5x8TPEhSH0ww==
X-Received: by 2002:a17:903:234a:b0:167:997f:bc4c with SMTP id c10-20020a170903234a00b00167997fbc4cmr8039374plh.120.1655449727144;
        Fri, 17 Jun 2022 00:08:47 -0700 (PDT)
Received: from FVFDK26JP3YV.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id j1-20020a170903028100b00163d4c3ffabsm2757868plr.304.2022.06.17.00.08.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jun 2022 00:08:46 -0700 (PDT)
From:   Lei He <helei.sig11@bytedance.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dhowells@redhat.com, mst@redhat.com
Cc:     arei.gonglei@huawei.com, jasowang@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com, helei.sig11@bytedance.com,
        f4bug@amsat.org, berrange@redhat.com
Subject: [PATCH 4/4] virtio-crypto: support ECDSA algorithm
Date:   Fri, 17 Jun 2022 15:07:54 +0800
Message-Id: <20220617070754.73667-6-helei.sig11@bytedance.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220617070754.73667-1-helei.sig11@bytedance.com>
References: <20220617070754.73667-1-helei.sig11@bytedance.com>
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

Support ECDSA algorithm for driver virtio-crypto

Signed-off-by: lei he <helei.sig11@bytedance.com>
---
 .../virtio/virtio_crypto_akcipher_algs.c      | 259 ++++++++++++++++--
 1 file changed, 238 insertions(+), 21 deletions(-)

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

