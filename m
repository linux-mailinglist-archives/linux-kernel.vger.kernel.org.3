Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E619552B28
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346022AbiFUGk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345877AbiFUGkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:40:43 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130171900A;
        Mon, 20 Jun 2022 23:40:39 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 25L6MMpp031704;
        Tue, 21 Jun 2022 14:22:23 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 21 Jun
 2022 14:37:58 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        "Andrew Jeffery" <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        "Johnny Huang" <johnny_huang@aspeedtech.com>
CC:     <linux-aspeed@lists.ozlabs.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>
Subject: [PATCH v3 5/5] crypto: aspeed: add HACE crypto driver
Date:   Tue, 21 Jun 2022 14:37:52 +0800
Message-ID: <20220621063752.1005781-6-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621063752.1005781-1-neal_liu@aspeedtech.com>
References: <20220621063752.1005781-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 25L6MMpp031704
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HACE crypto driver to support symmetric-key
encryption and decryption with multiple modes of
operation.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
---
 drivers/crypto/aspeed/Kconfig              |   17 +
 drivers/crypto/aspeed/Makefile             |    2 +
 drivers/crypto/aspeed/aspeed-hace-crypto.c | 1041 ++++++++++++++++++++
 drivers/crypto/aspeed/aspeed-hace.c        |  108 ++
 drivers/crypto/aspeed/aspeed-hace.h        |  108 ++
 5 files changed, 1276 insertions(+)
 create mode 100644 drivers/crypto/aspeed/aspeed-hace-crypto.c

diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
index 05cba5171c51..bf51bfa6f6ea 100644
--- a/drivers/crypto/aspeed/Kconfig
+++ b/drivers/crypto/aspeed/Kconfig
@@ -21,3 +21,20 @@ config CRYPTO_DEV_ASPEED_HACE_HASH
 	  hash driver.
 	  Supports multiple message digest standards, including
 	  SHA-1, SHA-224, SHA-256, SHA-384, SHA-512, and so on.
+
+config CRYPTO_DEV_ASPEED_HACE_CRYPTO
+	bool "Enable ASPEED Hash & Crypto Engine (HACE) crypto"
+	depends on CRYPTO_DEV_ASPEED
+	select CRYPTO_ENGINE
+	select CRYPTO_AES
+	select CRYPTO_DES
+	select CRYPTO_ECB
+	select CRYPTO_CBC
+	select CRYPTO_CFB
+	select CRYPTO_OFB
+	select CRYPTO_CTR
+	help
+	  Select here to enable ASPEED Hash & Crypto Engine (HACE)
+	  crypto driver.
+	  Supports AES/DES symmetric-key encryption and decryption
+	  with ECB/CBC/CFB/OFB/CTR options.
diff --git a/drivers/crypto/aspeed/Makefile b/drivers/crypto/aspeed/Makefile
index 8bc8d4fed5a9..4b29bdae9965 100644
--- a/drivers/crypto/aspeed/Makefile
+++ b/drivers/crypto/aspeed/Makefile
@@ -4,3 +4,5 @@ aspeed_crypto-objs := aspeed-hace.o \
 
 obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) += aspeed-hace-hash.o
 hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) := aspeed-hace-hash.o
+obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) += aspeed-hace-crypto.o
+hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) := aspeed-hace-crypto.o
diff --git a/drivers/crypto/aspeed/aspeed-hace-crypto.c b/drivers/crypto/aspeed/aspeed-hace-crypto.c
new file mode 100644
index 000000000000..1dd80fc1671f
--- /dev/null
+++ b/drivers/crypto/aspeed/aspeed-hace-crypto.c
@@ -0,0 +1,1041 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2021 Aspeed Technology Inc.
+ */
+
+#include "aspeed-hace.h"
+
+#ifdef ASPEED_CIPHER_DEBUG
+#define CIPHER_DBG(h, fmt, ...)	\
+	dev_dbg((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
+#else
+#define CIPHER_DBG(h, fmt, ...)	\
+	((void)(h))
+#endif
+
+static int aspeed_hace_crypto_handle_queue(struct aspeed_hace_dev *hace_dev,
+					   struct skcipher_request *req)
+{
+	return crypto_transfer_skcipher_request_to_engine(
+			hace_dev->crypt_engine_crypto, req);
+}
+
+static int aspeed_crypto_do_request(struct crypto_engine *engine, void *areq)
+{
+	struct skcipher_request *req = skcipher_request_cast(areq);
+	struct crypto_skcipher *cipher = crypto_skcipher_reqtfm(req);
+	struct aspeed_cipher_ctx *ctx = crypto_skcipher_ctx(cipher);
+	struct aspeed_hace_dev *hace_dev = ctx->hace_dev;
+	struct aspeed_engine_crypto *crypto_engine;
+	int rc;
+
+	crypto_engine = &hace_dev->crypto_engine;
+	crypto_engine->req = req;
+	crypto_engine->flags |= CRYPTO_FLAGS_BUSY;
+
+	rc = ctx->start(hace_dev);
+
+	if (rc != -EINPROGRESS)
+		return -EIO;
+
+	return 0;
+}
+
+static int aspeed_sk_complete(struct aspeed_hace_dev *hace_dev, int err)
+{
+	struct aspeed_engine_crypto *crypto_engine = &hace_dev->crypto_engine;
+	struct aspeed_cipher_reqctx *rctx;
+	struct skcipher_request *req;
+
+	CIPHER_DBG(hace_dev, "\n");
+
+	req = crypto_engine->req;
+	rctx = skcipher_request_ctx(req);
+
+	if (rctx->enc_cmd & HACE_CMD_IV_REQUIRE) {
+		if (rctx->enc_cmd & HACE_CMD_DES_SELECT)
+			memcpy(req->iv, crypto_engine->cipher_ctx +
+			       DES_KEY_SIZE, DES_KEY_SIZE);
+		else
+			memcpy(req->iv, crypto_engine->cipher_ctx,
+			       AES_BLOCK_SIZE);
+	}
+
+	crypto_engine->flags &= ~CRYPTO_FLAGS_BUSY;
+
+	crypto_finalize_skcipher_request(hace_dev->crypt_engine_crypto, req,
+					 err);
+
+	return err;
+}
+
+static int aspeed_sk_transfer_sg(struct aspeed_hace_dev *hace_dev)
+{
+	struct aspeed_engine_crypto *crypto_engine = &hace_dev->crypto_engine;
+	struct device *dev = hace_dev->dev;
+	struct aspeed_cipher_reqctx *rctx;
+	struct skcipher_request *req;
+
+	CIPHER_DBG(hace_dev, "\n");
+
+	req = crypto_engine->req;
+	rctx = skcipher_request_ctx(req);
+
+	if (req->src == req->dst) {
+		dma_unmap_sg(dev, req->src, rctx->src_nents, DMA_BIDIRECTIONAL);
+	} else {
+		dma_unmap_sg(dev, req->src, rctx->src_nents, DMA_TO_DEVICE);
+		dma_unmap_sg(dev, req->dst, rctx->dst_nents, DMA_FROM_DEVICE);
+	}
+
+	return aspeed_sk_complete(hace_dev, 0);
+}
+
+static int aspeed_sk_transfer(struct aspeed_hace_dev *hace_dev)
+{
+	struct aspeed_engine_crypto *crypto_engine = &hace_dev->crypto_engine;
+	struct device *dev = hace_dev->dev;
+	struct aspeed_cipher_reqctx *rctx;
+	struct skcipher_request *req;
+	struct scatterlist *out_sg;
+	int nbytes = 0;
+	int rc = 0;
+
+	CIPHER_DBG(hace_dev, "\n");
+
+	req = crypto_engine->req;
+	rctx = skcipher_request_ctx(req);
+	out_sg = req->dst;
+
+	/* Copy output buffer to dst scatter-gather lists */
+	nbytes = sg_copy_from_buffer(out_sg, rctx->dst_nents,
+				     crypto_engine->cipher_addr, req->cryptlen);
+	if (!nbytes) {
+		dev_warn(dev, "nbytes:%d, req->cryptlen:%d\n",
+			 nbytes, req->cryptlen);
+		rc = -EINVAL;
+	}
+
+	return aspeed_sk_complete(hace_dev, rc);
+}
+
+static int aspeed_sk_start(struct aspeed_hace_dev *hace_dev)
+{
+	struct aspeed_engine_crypto *crypto_engine = &hace_dev->crypto_engine;
+	struct aspeed_cipher_reqctx *rctx;
+	struct skcipher_request *req;
+	struct scatterlist *in_sg;
+	int nbytes;
+
+	CIPHER_DBG(hace_dev, "\n");
+
+	req = crypto_engine->req;
+	rctx = skcipher_request_ctx(req);
+	in_sg = req->src;
+
+	nbytes = sg_copy_to_buffer(in_sg, rctx->src_nents,
+				   crypto_engine->cipher_addr, req->cryptlen);
+
+	CIPHER_DBG(hace_dev, "%s:%d, %s:%d, %s:%d, %s:%d\n",
+		   "nbytes", nbytes, "req->cryptlen", req->cryptlen,
+		   "nb_in_sg", rctx->src_nents, "nb_out_sg", rctx->dst_nents);
+	if (!nbytes) {
+		dev_warn(hace_dev->dev, "invalid nbytes\n");
+		return -EINVAL;
+	}
+
+	crypto_engine->resume = aspeed_sk_transfer;
+
+	/* Trigger engines */
+	ast_hace_write(hace_dev, crypto_engine->cipher_dma_addr,
+		       ASPEED_HACE_SRC);
+	ast_hace_write(hace_dev, crypto_engine->cipher_dma_addr,
+		       ASPEED_HACE_DEST);
+	ast_hace_write(hace_dev, req->cryptlen, ASPEED_HACE_DATA_LEN);
+	ast_hace_write(hace_dev, rctx->enc_cmd, ASPEED_HACE_CMD);
+
+	return -EINPROGRESS;
+}
+
+static int aspeed_sk_start_sg(struct aspeed_hace_dev *hace_dev)
+{
+	struct aspeed_engine_crypto *crypto_engine = &hace_dev->crypto_engine;
+	struct aspeed_sg_list *src_list, *dst_list;
+	dma_addr_t src_dma_addr, dst_dma_addr;
+	struct aspeed_cipher_reqctx *rctx;
+	struct skcipher_request *req;
+	struct scatterlist *s;
+	int src_sg_len;
+	int dst_sg_len;
+	int total, i;
+	int rc;
+
+	CIPHER_DBG(hace_dev, "\n");
+
+	req = crypto_engine->req;
+	rctx = skcipher_request_ctx(req);
+
+	rctx->enc_cmd |= HACE_CMD_DES_SG_CTRL | HACE_CMD_SRC_SG_CTRL |
+			 HACE_CMD_AES_KEY_HW_EXP | HACE_CMD_MBUS_REQ_SYNC_EN;
+
+	/* BIDIRECTIONAL */
+	if (req->dst == req->src) {
+		src_sg_len = dma_map_sg(hace_dev->dev, req->src,
+					rctx->src_nents, DMA_BIDIRECTIONAL);
+		dst_sg_len = src_sg_len;
+		if (!src_sg_len) {
+			dev_warn(hace_dev->dev, "dma_map_sg() src error\n");
+			return -EINVAL;
+		}
+
+	} else {
+		src_sg_len = dma_map_sg(hace_dev->dev, req->src,
+					rctx->src_nents, DMA_TO_DEVICE);
+		if (!src_sg_len) {
+			dev_warn(hace_dev->dev, "dma_map_sg() src error\n");
+			return -EINVAL;
+		}
+
+		dst_sg_len = dma_map_sg(hace_dev->dev, req->dst,
+					rctx->dst_nents, DMA_FROM_DEVICE);
+		if (!dst_sg_len) {
+			dev_warn(hace_dev->dev, "dma_map_sg() dst error\n");
+			rc = -EINVAL;
+			goto free_req_src;
+		}
+	}
+
+	src_list = (struct aspeed_sg_list *)crypto_engine->cipher_addr;
+	src_dma_addr = crypto_engine->cipher_dma_addr;
+	total = req->cryptlen;
+
+	for_each_sg(req->src, s, src_sg_len, i) {
+		src_list[i].phy_addr = sg_dma_address(s);
+
+		if (total > sg_dma_len(s)) {
+			src_list[i].len = sg_dma_len(s);
+			total -= src_list[i].len;
+
+		} else {
+			/* last sg list */
+			src_list[i].len = total;
+			src_list[i].len |= BIT(31);
+			total = 0;
+		}
+
+		src_list[i].phy_addr = cpu_to_le32(src_list[i].phy_addr);
+		src_list[i].len = cpu_to_le32(src_list[i].len);
+	}
+
+	if (total != 0) {
+		rc = -EINVAL;
+		goto free_req;
+	}
+
+	if (req->dst == req->src) {
+		dst_list = src_list;
+		dst_dma_addr = src_dma_addr;
+
+	} else {
+		dst_list = (struct aspeed_sg_list *)crypto_engine->dst_sg_addr;
+		dst_dma_addr = crypto_engine->dst_sg_dma_addr;
+		total = req->cryptlen;
+
+		for_each_sg(req->dst, s, dst_sg_len, i) {
+			dst_list[i].phy_addr = sg_dma_address(s);
+
+			if (total > sg_dma_len(s)) {
+				dst_list[i].len = sg_dma_len(s);
+				total -= dst_list[i].len;
+
+			} else {
+				/* last sg list */
+				dst_list[i].len = total;
+				dst_list[i].len |= BIT(31);
+				total = 0;
+			}
+
+			dst_list[i].phy_addr = cpu_to_le32(dst_list[i].phy_addr);
+			dst_list[i].len = cpu_to_le32(dst_list[i].len);
+
+		}
+
+		dst_list[dst_sg_len].phy_addr = 0;
+		dst_list[dst_sg_len].len = 0;
+	}
+
+	if (total != 0) {
+		rc = -EINVAL;
+		goto free_req;
+	}
+
+	crypto_engine->resume = aspeed_sk_transfer_sg;
+
+	/* Memory barrier to ensure all data setup before engine starts */
+	mb();
+
+	/* Trigger engines */
+	ast_hace_write(hace_dev, src_dma_addr, ASPEED_HACE_SRC);
+	ast_hace_write(hace_dev, dst_dma_addr, ASPEED_HACE_DEST);
+	ast_hace_write(hace_dev, req->cryptlen, ASPEED_HACE_DATA_LEN);
+	ast_hace_write(hace_dev, rctx->enc_cmd, ASPEED_HACE_CMD);
+
+	return -EINPROGRESS;
+
+free_req:
+	if (req->dst == req->src) {
+		dma_unmap_sg(hace_dev->dev, req->src, rctx->src_nents,
+			     DMA_BIDIRECTIONAL);
+
+	} else {
+		dma_unmap_sg(hace_dev->dev, req->dst, rctx->dst_nents,
+			     DMA_TO_DEVICE);
+		dma_unmap_sg(hace_dev->dev, req->src, rctx->src_nents,
+			     DMA_TO_DEVICE);
+	}
+
+	return rc;
+
+free_req_src:
+	dma_unmap_sg(hace_dev->dev, req->src, rctx->src_nents, DMA_TO_DEVICE);
+
+	return rc;
+}
+
+static int aspeed_hace_skcipher_trigger(struct aspeed_hace_dev *hace_dev)
+{
+	struct aspeed_engine_crypto *crypto_engine = &hace_dev->crypto_engine;
+	struct aspeed_cipher_reqctx *rctx;
+	struct crypto_skcipher *cipher;
+	struct aspeed_cipher_ctx *ctx;
+	struct skcipher_request *req;
+
+	CIPHER_DBG(hace_dev, "\n");
+
+	req = crypto_engine->req;
+	rctx = skcipher_request_ctx(req);
+	cipher = crypto_skcipher_reqtfm(req);
+	ctx = crypto_skcipher_ctx(cipher);
+
+	/* enable interrupt */
+	rctx->enc_cmd |= HACE_CMD_ISR_EN;
+
+	rctx->dst_nents = sg_nents(req->dst);
+	rctx->src_nents = sg_nents(req->src);
+
+	ast_hace_write(hace_dev, crypto_engine->cipher_ctx_dma,
+		       ASPEED_HACE_CONTEXT);
+
+	if (rctx->enc_cmd & HACE_CMD_IV_REQUIRE) {
+		if (rctx->enc_cmd & HACE_CMD_DES_SELECT)
+			memcpy(crypto_engine->cipher_ctx + DES_BLOCK_SIZE,
+			       req->iv, DES_BLOCK_SIZE);
+		else
+			memcpy(crypto_engine->cipher_ctx, req->iv,
+			       AES_BLOCK_SIZE);
+	}
+
+	if (hace_dev->version == AST2600_VERSION) {
+		memcpy(crypto_engine->cipher_ctx + 16, ctx->key, ctx->key_len);
+
+		return aspeed_sk_start_sg(hace_dev);
+	}
+
+	memcpy(crypto_engine->cipher_ctx + 16, ctx->key, ctx->key_len);
+
+	return aspeed_sk_start(hace_dev);
+}
+
+static int aspeed_des_crypt(struct skcipher_request *req, u32 cmd)
+{
+	struct aspeed_cipher_reqctx *rctx = skcipher_request_ctx(req);
+	struct crypto_skcipher *cipher = crypto_skcipher_reqtfm(req);
+	struct aspeed_cipher_ctx *ctx = crypto_skcipher_ctx(cipher);
+	struct aspeed_hace_dev *hace_dev = ctx->hace_dev;
+	u32 crypto_alg = cmd & HACE_CMD_OP_MODE_MASK;
+
+	CIPHER_DBG(hace_dev, "\n");
+
+	if (crypto_alg == HACE_CMD_CBC || crypto_alg == HACE_CMD_ECB) {
+		if (!IS_ALIGNED(req->cryptlen, DES_BLOCK_SIZE))
+			return -EINVAL;
+	}
+
+	rctx->enc_cmd = cmd | HACE_CMD_DES_SELECT | HACE_CMD_RI_WO_DATA_ENABLE |
+			HACE_CMD_DES | HACE_CMD_CONTEXT_LOAD_ENABLE |
+			HACE_CMD_CONTEXT_SAVE_ENABLE;
+
+	return aspeed_hace_crypto_handle_queue(hace_dev, req);
+}
+
+static int aspeed_des_setkey(struct crypto_skcipher *cipher, const u8 *key,
+			     unsigned int keylen)
+{
+	struct aspeed_cipher_ctx *ctx = crypto_skcipher_ctx(cipher);
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(cipher);
+	struct aspeed_hace_dev *hace_dev = ctx->hace_dev;
+	int rc;
+
+	CIPHER_DBG(hace_dev, "keylen: %d bits\n", keylen);
+
+	if (keylen != DES_KEY_SIZE && keylen != DES3_EDE_KEY_SIZE) {
+		dev_warn(hace_dev->dev, "invalid keylen: %d bits\n", keylen);
+		return -EINVAL;
+	}
+
+	if (keylen == DES_KEY_SIZE) {
+		rc = crypto_des_verify_key(tfm, key);
+		if (rc)
+			return rc;
+
+	} else if (keylen == DES3_EDE_KEY_SIZE) {
+		rc = crypto_des3_ede_verify_key(tfm, key);
+		if (rc)
+			return rc;
+	}
+
+	memcpy(ctx->key, key, keylen);
+	ctx->key_len = keylen;
+
+	return 0;
+}
+
+static int aspeed_tdes_ctr_decrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_DECRYPT | HACE_CMD_CTR |
+				HACE_CMD_TRIPLE_DES);
+}
+
+static int aspeed_tdes_ctr_encrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_ENCRYPT | HACE_CMD_CTR |
+				HACE_CMD_TRIPLE_DES);
+}
+
+static int aspeed_tdes_ofb_decrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_DECRYPT | HACE_CMD_OFB |
+				HACE_CMD_TRIPLE_DES);
+}
+
+static int aspeed_tdes_ofb_encrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_ENCRYPT | HACE_CMD_OFB |
+				HACE_CMD_TRIPLE_DES);
+}
+
+static int aspeed_tdes_cfb_decrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_DECRYPT | HACE_CMD_CFB |
+				HACE_CMD_TRIPLE_DES);
+}
+
+static int aspeed_tdes_cfb_encrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_ENCRYPT | HACE_CMD_CFB |
+				HACE_CMD_TRIPLE_DES);
+}
+
+static int aspeed_tdes_cbc_decrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_DECRYPT | HACE_CMD_CBC |
+				HACE_CMD_TRIPLE_DES);
+}
+
+static int aspeed_tdes_cbc_encrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_ENCRYPT | HACE_CMD_CBC |
+				HACE_CMD_TRIPLE_DES);
+}
+
+static int aspeed_tdes_ecb_decrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_DECRYPT | HACE_CMD_ECB |
+				HACE_CMD_TRIPLE_DES);
+}
+
+static int aspeed_tdes_ecb_encrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_ENCRYPT | HACE_CMD_ECB |
+				HACE_CMD_TRIPLE_DES);
+}
+
+static int aspeed_des_ctr_decrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_DECRYPT | HACE_CMD_CTR |
+				HACE_CMD_SINGLE_DES);
+}
+
+static int aspeed_des_ctr_encrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_ENCRYPT | HACE_CMD_CTR |
+				HACE_CMD_SINGLE_DES);
+}
+
+static int aspeed_des_ofb_decrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_DECRYPT | HACE_CMD_OFB |
+				HACE_CMD_SINGLE_DES);
+}
+
+static int aspeed_des_ofb_encrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_ENCRYPT | HACE_CMD_OFB |
+				HACE_CMD_SINGLE_DES);
+}
+
+static int aspeed_des_cfb_decrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_DECRYPT | HACE_CMD_CFB |
+				HACE_CMD_SINGLE_DES);
+}
+
+static int aspeed_des_cfb_encrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_ENCRYPT | HACE_CMD_CFB |
+				HACE_CMD_SINGLE_DES);
+}
+
+static int aspeed_des_cbc_decrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_DECRYPT | HACE_CMD_CBC |
+				HACE_CMD_SINGLE_DES);
+}
+
+static int aspeed_des_cbc_encrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_ENCRYPT | HACE_CMD_CBC |
+				HACE_CMD_SINGLE_DES);
+}
+
+static int aspeed_des_ecb_decrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_DECRYPT | HACE_CMD_ECB |
+				HACE_CMD_SINGLE_DES);
+}
+
+static int aspeed_des_ecb_encrypt(struct skcipher_request *req)
+{
+	return aspeed_des_crypt(req, HACE_CMD_ENCRYPT | HACE_CMD_ECB |
+				HACE_CMD_SINGLE_DES);
+}
+
+static int aspeed_aes_crypt(struct skcipher_request *req, u32 cmd)
+{
+	struct aspeed_cipher_reqctx *rctx = skcipher_request_ctx(req);
+	struct crypto_skcipher *cipher = crypto_skcipher_reqtfm(req);
+	struct aspeed_cipher_ctx *ctx = crypto_skcipher_ctx(cipher);
+	struct aspeed_hace_dev *hace_dev = ctx->hace_dev;
+	u32 crypto_alg = cmd & HACE_CMD_OP_MODE_MASK;
+
+	CIPHER_DBG(hace_dev, "\n");
+
+	if (crypto_alg == HACE_CMD_CBC || crypto_alg == HACE_CMD_ECB) {
+		if (!IS_ALIGNED(req->cryptlen, AES_BLOCK_SIZE))
+			return -EINVAL;
+	}
+
+	cmd |= HACE_CMD_AES_SELECT | HACE_CMD_RI_WO_DATA_ENABLE |
+	       HACE_CMD_CONTEXT_LOAD_ENABLE | HACE_CMD_CONTEXT_SAVE_ENABLE;
+
+	switch (ctx->key_len) {
+	case AES_KEYSIZE_128:
+		cmd |= HACE_CMD_AES128;
+		break;
+	case AES_KEYSIZE_192:
+		cmd |= HACE_CMD_AES192;
+		break;
+	case AES_KEYSIZE_256:
+		cmd |= HACE_CMD_AES256;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	rctx->enc_cmd = cmd;
+
+	return aspeed_hace_crypto_handle_queue(hace_dev, req);
+}
+
+static int aspeed_aes_setkey(struct crypto_skcipher *cipher, const u8 *key,
+			     unsigned int keylen)
+{
+	struct aspeed_cipher_ctx *ctx = crypto_skcipher_ctx(cipher);
+	struct aspeed_hace_dev *hace_dev = ctx->hace_dev;
+	struct crypto_aes_ctx gen_aes_key;
+
+	CIPHER_DBG(hace_dev, "keylen: %d bits\n", (keylen * 8));
+
+	if (keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_192 &&
+	    keylen != AES_KEYSIZE_256)
+		return -EINVAL;
+
+	if (ctx->hace_dev->version == AST2500_VERSION) {
+		aes_expandkey(&gen_aes_key, key, keylen);
+		memcpy(ctx->key, gen_aes_key.key_enc, AES_MAX_KEYLENGTH);
+
+	} else {
+		memcpy(ctx->key, key, keylen);
+	}
+
+	ctx->key_len = keylen;
+
+	return 0;
+}
+
+static int aspeed_aes_ctr_decrypt(struct skcipher_request *req)
+{
+	return aspeed_aes_crypt(req, HACE_CMD_DECRYPT | HACE_CMD_CTR);
+}
+
+static int aspeed_aes_ctr_encrypt(struct skcipher_request *req)
+{
+	return aspeed_aes_crypt(req, HACE_CMD_ENCRYPT | HACE_CMD_CTR);
+}
+
+static int aspeed_aes_ofb_decrypt(struct skcipher_request *req)
+{
+	return aspeed_aes_crypt(req, HACE_CMD_DECRYPT | HACE_CMD_OFB);
+}
+
+static int aspeed_aes_ofb_encrypt(struct skcipher_request *req)
+{
+	return aspeed_aes_crypt(req, HACE_CMD_ENCRYPT | HACE_CMD_OFB);
+}
+
+static int aspeed_aes_cfb_decrypt(struct skcipher_request *req)
+{
+	return aspeed_aes_crypt(req, HACE_CMD_DECRYPT | HACE_CMD_CFB);
+}
+
+static int aspeed_aes_cfb_encrypt(struct skcipher_request *req)
+{
+	return aspeed_aes_crypt(req, HACE_CMD_ENCRYPT | HACE_CMD_CFB);
+}
+
+static int aspeed_aes_cbc_decrypt(struct skcipher_request *req)
+{
+	return aspeed_aes_crypt(req, HACE_CMD_DECRYPT | HACE_CMD_CBC);
+}
+
+static int aspeed_aes_cbc_encrypt(struct skcipher_request *req)
+{
+	return aspeed_aes_crypt(req, HACE_CMD_ENCRYPT | HACE_CMD_CBC);
+}
+
+static int aspeed_aes_ecb_decrypt(struct skcipher_request *req)
+{
+	return aspeed_aes_crypt(req, HACE_CMD_DECRYPT | HACE_CMD_ECB);
+}
+
+static int aspeed_aes_ecb_encrypt(struct skcipher_request *req)
+{
+	return aspeed_aes_crypt(req, HACE_CMD_ENCRYPT | HACE_CMD_ECB);
+}
+
+static int aspeed_crypto_cra_init(struct crypto_skcipher *tfm)
+{
+	struct aspeed_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct aspeed_hace_alg *crypto_alg;
+
+
+	crypto_alg = container_of(alg, struct aspeed_hace_alg, alg.skcipher);
+	ctx->hace_dev = crypto_alg->hace_dev;
+	ctx->start = aspeed_hace_skcipher_trigger;
+
+	CIPHER_DBG(ctx->hace_dev, "\n");
+
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct aspeed_cipher_reqctx));
+
+	ctx->enginectx.op.do_one_request = aspeed_crypto_do_request;
+	ctx->enginectx.op.prepare_request = NULL;
+	ctx->enginectx.op.unprepare_request = NULL;
+
+	return 0;
+}
+
+static void aspeed_crypto_cra_exit(struct crypto_skcipher *tfm)
+{
+	struct aspeed_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct aspeed_hace_dev *hace_dev = ctx->hace_dev;
+
+	CIPHER_DBG(hace_dev, "%s\n", tfm->base.__crt_alg->cra_name);
+}
+
+struct aspeed_hace_alg aspeed_crypto_algs[] = {
+	{
+		.alg.skcipher = {
+			.min_keysize	= AES_MIN_KEY_SIZE,
+			.max_keysize	= AES_MAX_KEY_SIZE,
+			.setkey		= aspeed_aes_setkey,
+			.encrypt	= aspeed_aes_ecb_encrypt,
+			.decrypt	= aspeed_aes_ecb_decrypt,
+			.init		= aspeed_crypto_cra_init,
+			.exit		= aspeed_crypto_cra_exit,
+			.base = {
+				.cra_name		= "ecb(aes)",
+				.cra_driver_name	= "aspeed-ecb-aes",
+				.cra_priority		= 300,
+				.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+							  CRYPTO_ALG_ASYNC,
+				.cra_blocksize		= AES_BLOCK_SIZE,
+				.cra_ctxsize		= sizeof(struct aspeed_cipher_ctx),
+				.cra_alignmask		= 0x0f,
+				.cra_module		= THIS_MODULE,
+			}
+		}
+	},
+	{
+		.alg.skcipher = {
+			.ivsize		= AES_BLOCK_SIZE,
+			.min_keysize	= AES_MIN_KEY_SIZE,
+			.max_keysize	= AES_MAX_KEY_SIZE,
+			.setkey		= aspeed_aes_setkey,
+			.encrypt	= aspeed_aes_cbc_encrypt,
+			.decrypt	= aspeed_aes_cbc_decrypt,
+			.init		= aspeed_crypto_cra_init,
+			.exit		= aspeed_crypto_cra_exit,
+			.base = {
+				.cra_name		= "cbc(aes)",
+				.cra_driver_name	= "aspeed-cbc-aes",
+				.cra_priority		= 300,
+				.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+							  CRYPTO_ALG_ASYNC,
+				.cra_blocksize		= AES_BLOCK_SIZE,
+				.cra_ctxsize		= sizeof(struct aspeed_cipher_ctx),
+				.cra_alignmask		= 0x0f,
+				.cra_module		= THIS_MODULE,
+			}
+		}
+	},
+	{
+		.alg.skcipher = {
+			.ivsize		= AES_BLOCK_SIZE,
+			.min_keysize	= AES_MIN_KEY_SIZE,
+			.max_keysize	= AES_MAX_KEY_SIZE,
+			.setkey		= aspeed_aes_setkey,
+			.encrypt	= aspeed_aes_cfb_encrypt,
+			.decrypt	= aspeed_aes_cfb_decrypt,
+			.init		= aspeed_crypto_cra_init,
+			.exit		= aspeed_crypto_cra_exit,
+			.base = {
+				.cra_name		= "cfb(aes)",
+				.cra_driver_name	= "aspeed-cfb-aes",
+				.cra_priority		= 300,
+				.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+							  CRYPTO_ALG_ASYNC,
+				.cra_blocksize		= 1,
+				.cra_ctxsize		= sizeof(struct aspeed_cipher_ctx),
+				.cra_alignmask		= 0x0f,
+				.cra_module		= THIS_MODULE,
+			}
+		}
+	},
+	{
+		.alg.skcipher = {
+			.ivsize		= AES_BLOCK_SIZE,
+			.min_keysize	= AES_MIN_KEY_SIZE,
+			.max_keysize	= AES_MAX_KEY_SIZE,
+			.setkey		= aspeed_aes_setkey,
+			.encrypt	= aspeed_aes_ofb_encrypt,
+			.decrypt	= aspeed_aes_ofb_decrypt,
+			.init		= aspeed_crypto_cra_init,
+			.exit		= aspeed_crypto_cra_exit,
+			.base = {
+				.cra_name		= "ofb(aes)",
+				.cra_driver_name	= "aspeed-ofb-aes",
+				.cra_priority		= 300,
+				.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+							  CRYPTO_ALG_ASYNC,
+				.cra_blocksize		= 1,
+				.cra_ctxsize		= sizeof(struct aspeed_cipher_ctx),
+				.cra_alignmask		= 0x0f,
+				.cra_module		= THIS_MODULE,
+			}
+		}
+	},
+	{
+		.alg.skcipher = {
+			.min_keysize	= DES_KEY_SIZE,
+			.max_keysize	= DES_KEY_SIZE,
+			.setkey		= aspeed_des_setkey,
+			.encrypt	= aspeed_des_ecb_encrypt,
+			.decrypt	= aspeed_des_ecb_decrypt,
+			.init		= aspeed_crypto_cra_init,
+			.exit		= aspeed_crypto_cra_exit,
+			.base = {
+				.cra_name		= "ecb(des)",
+				.cra_driver_name	= "aspeed-ecb-des",
+				.cra_priority		= 300,
+				.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+							  CRYPTO_ALG_ASYNC,
+				.cra_blocksize		= DES_BLOCK_SIZE,
+				.cra_ctxsize		= sizeof(struct aspeed_cipher_ctx),
+				.cra_alignmask		= 0x0f,
+				.cra_module		= THIS_MODULE,
+			}
+		}
+	},
+	{
+		.alg.skcipher = {
+			.ivsize		= DES_BLOCK_SIZE,
+			.min_keysize	= DES_KEY_SIZE,
+			.max_keysize	= DES_KEY_SIZE,
+			.setkey		= aspeed_des_setkey,
+			.encrypt	= aspeed_des_cbc_encrypt,
+			.decrypt	= aspeed_des_cbc_decrypt,
+			.init		= aspeed_crypto_cra_init,
+			.exit		= aspeed_crypto_cra_exit,
+			.base = {
+				.cra_name		= "cbc(des)",
+				.cra_driver_name	= "aspeed-cbc-des",
+				.cra_priority		= 300,
+				.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+							  CRYPTO_ALG_ASYNC,
+				.cra_blocksize		= DES_BLOCK_SIZE,
+				.cra_ctxsize		= sizeof(struct aspeed_cipher_ctx),
+				.cra_alignmask		= 0x0f,
+				.cra_module		= THIS_MODULE,
+			}
+		}
+	},
+	{
+		.alg.skcipher = {
+			.ivsize		= DES_BLOCK_SIZE,
+			.min_keysize	= DES_KEY_SIZE,
+			.max_keysize	= DES_KEY_SIZE,
+			.setkey		= aspeed_des_setkey,
+			.encrypt	= aspeed_des_cfb_encrypt,
+			.decrypt	= aspeed_des_cfb_decrypt,
+			.init		= aspeed_crypto_cra_init,
+			.exit		= aspeed_crypto_cra_exit,
+			.base = {
+				.cra_name		= "cfb(des)",
+				.cra_driver_name	= "aspeed-cfb-des",
+				.cra_priority		= 300,
+				.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+							  CRYPTO_ALG_ASYNC,
+				.cra_blocksize		= DES_BLOCK_SIZE,
+				.cra_ctxsize		= sizeof(struct aspeed_cipher_ctx),
+				.cra_alignmask		= 0x0f,
+				.cra_module		= THIS_MODULE,
+			}
+		}
+	},
+	{
+		.alg.skcipher = {
+			.ivsize		= DES_BLOCK_SIZE,
+			.min_keysize	= DES_KEY_SIZE,
+			.max_keysize	= DES_KEY_SIZE,
+			.setkey		= aspeed_des_setkey,
+			.encrypt	= aspeed_des_ofb_encrypt,
+			.decrypt	= aspeed_des_ofb_decrypt,
+			.init		= aspeed_crypto_cra_init,
+			.exit		= aspeed_crypto_cra_exit,
+			.base = {
+				.cra_name		= "ofb(des)",
+				.cra_driver_name	= "aspeed-ofb-des",
+				.cra_priority		= 300,
+				.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+							  CRYPTO_ALG_ASYNC,
+				.cra_blocksize		= DES_BLOCK_SIZE,
+				.cra_ctxsize		= sizeof(struct aspeed_cipher_ctx),
+				.cra_alignmask		= 0x0f,
+				.cra_module		= THIS_MODULE,
+			}
+		}
+	},
+	{
+		.alg.skcipher = {
+			.min_keysize	= DES3_EDE_KEY_SIZE,
+			.max_keysize	= DES3_EDE_KEY_SIZE,
+			.setkey		= aspeed_des_setkey,
+			.encrypt	= aspeed_tdes_ecb_encrypt,
+			.decrypt	= aspeed_tdes_ecb_decrypt,
+			.init		= aspeed_crypto_cra_init,
+			.exit		= aspeed_crypto_cra_exit,
+			.base = {
+				.cra_name		= "ecb(des3_ede)",
+				.cra_driver_name	= "aspeed-ecb-tdes",
+				.cra_priority		= 300,
+				.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+							  CRYPTO_ALG_ASYNC,
+				.cra_blocksize		= DES_BLOCK_SIZE,
+				.cra_ctxsize		= sizeof(struct aspeed_cipher_ctx),
+				.cra_alignmask		= 0x0f,
+				.cra_module		= THIS_MODULE,
+			}
+		}
+	},
+	{
+		.alg.skcipher = {
+			.ivsize		= DES_BLOCK_SIZE,
+			.min_keysize	= DES3_EDE_KEY_SIZE,
+			.max_keysize	= DES3_EDE_KEY_SIZE,
+			.setkey		= aspeed_des_setkey,
+			.encrypt	= aspeed_tdes_cbc_encrypt,
+			.decrypt	= aspeed_tdes_cbc_decrypt,
+			.init		= aspeed_crypto_cra_init,
+			.exit		= aspeed_crypto_cra_exit,
+			.base = {
+				.cra_name		= "cbc(des3_ede)",
+				.cra_driver_name	= "aspeed-cbc-tdes",
+				.cra_priority		= 300,
+				.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+							  CRYPTO_ALG_ASYNC,
+				.cra_blocksize		= DES_BLOCK_SIZE,
+				.cra_ctxsize		= sizeof(struct aspeed_cipher_ctx),
+				.cra_alignmask		= 0x0f,
+				.cra_module		= THIS_MODULE,
+			}
+		}
+	},
+	{
+		.alg.skcipher = {
+			.ivsize		= DES_BLOCK_SIZE,
+			.min_keysize	= DES3_EDE_KEY_SIZE,
+			.max_keysize	= DES3_EDE_KEY_SIZE,
+			.setkey		= aspeed_des_setkey,
+			.encrypt	= aspeed_tdes_cfb_encrypt,
+			.decrypt	= aspeed_tdes_cfb_decrypt,
+			.init		= aspeed_crypto_cra_init,
+			.exit		= aspeed_crypto_cra_exit,
+			.base = {
+				.cra_name		= "cfb(des3_ede)",
+				.cra_driver_name	= "aspeed-cfb-tdes",
+				.cra_priority		= 300,
+				.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+							  CRYPTO_ALG_ASYNC,
+				.cra_blocksize		= DES_BLOCK_SIZE,
+				.cra_ctxsize		= sizeof(struct aspeed_cipher_ctx),
+				.cra_alignmask		= 0x0f,
+				.cra_module		= THIS_MODULE,
+			}
+		}
+	},
+	{
+		.alg.skcipher = {
+			.ivsize		= DES_BLOCK_SIZE,
+			.min_keysize	= DES3_EDE_KEY_SIZE,
+			.max_keysize	= DES3_EDE_KEY_SIZE,
+			.setkey		= aspeed_des_setkey,
+			.encrypt	= aspeed_tdes_ofb_encrypt,
+			.decrypt	= aspeed_tdes_ofb_decrypt,
+			.init		= aspeed_crypto_cra_init,
+			.exit		= aspeed_crypto_cra_exit,
+			.base = {
+				.cra_name		= "ofb(des3_ede)",
+				.cra_driver_name	= "aspeed-ofb-tdes",
+				.cra_priority		= 300,
+				.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+							  CRYPTO_ALG_ASYNC,
+				.cra_blocksize		= DES_BLOCK_SIZE,
+				.cra_ctxsize		= sizeof(struct aspeed_cipher_ctx),
+				.cra_alignmask		= 0x0f,
+				.cra_module		= THIS_MODULE,
+			}
+		}
+	},
+};
+
+struct aspeed_hace_alg aspeed_crypto_algs_g6[] = {
+	{
+		.alg.skcipher = {
+			.ivsize		= AES_BLOCK_SIZE,
+			.min_keysize	= AES_MIN_KEY_SIZE,
+			.max_keysize	= AES_MAX_KEY_SIZE,
+			.setkey		= aspeed_aes_setkey,
+			.encrypt	= aspeed_aes_ctr_encrypt,
+			.decrypt	= aspeed_aes_ctr_decrypt,
+			.init		= aspeed_crypto_cra_init,
+			.exit		= aspeed_crypto_cra_exit,
+			.base = {
+				.cra_name		= "ctr(aes)",
+				.cra_driver_name	= "aspeed-ctr-aes",
+				.cra_priority		= 300,
+				.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+							  CRYPTO_ALG_ASYNC,
+				.cra_blocksize		= 1,
+				.cra_ctxsize		= sizeof(struct aspeed_cipher_ctx),
+				.cra_alignmask		= 0x0f,
+				.cra_module		= THIS_MODULE,
+			}
+		}
+	},
+	{
+		.alg.skcipher = {
+			.ivsize		= DES_BLOCK_SIZE,
+			.min_keysize	= DES_KEY_SIZE,
+			.max_keysize	= DES_KEY_SIZE,
+			.setkey		= aspeed_des_setkey,
+			.encrypt	= aspeed_des_ctr_encrypt,
+			.decrypt	= aspeed_des_ctr_decrypt,
+			.init		= aspeed_crypto_cra_init,
+			.exit		= aspeed_crypto_cra_exit,
+			.base = {
+				.cra_name		= "ctr(des)",
+				.cra_driver_name	= "aspeed-ctr-des",
+				.cra_priority		= 300,
+				.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+							  CRYPTO_ALG_ASYNC,
+				.cra_blocksize		= 1,
+				.cra_ctxsize		= sizeof(struct aspeed_cipher_ctx),
+				.cra_alignmask		= 0x0f,
+				.cra_module		= THIS_MODULE,
+			}
+		}
+	},
+	{
+		.alg.skcipher = {
+			.ivsize		= DES_BLOCK_SIZE,
+			.min_keysize	= DES3_EDE_KEY_SIZE,
+			.max_keysize	= DES3_EDE_KEY_SIZE,
+			.setkey		= aspeed_des_setkey,
+			.encrypt	= aspeed_tdes_ctr_encrypt,
+			.decrypt	= aspeed_tdes_ctr_decrypt,
+			.init		= aspeed_crypto_cra_init,
+			.exit		= aspeed_crypto_cra_exit,
+			.base = {
+				.cra_name		= "ctr(des3_ede)",
+				.cra_driver_name	= "aspeed-ctr-tdes",
+				.cra_priority		= 300,
+				.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+							  CRYPTO_ALG_ASYNC,
+				.cra_blocksize		= 1,
+				.cra_ctxsize		= sizeof(struct aspeed_cipher_ctx),
+				.cra_alignmask		= 0x0f,
+				.cra_module		= THIS_MODULE,
+			}
+		}
+	},
+
+};
+
+void aspeed_register_hace_crypto_algs(struct aspeed_hace_dev *hace_dev)
+{
+	int rc, i;
+
+	CIPHER_DBG(hace_dev, "\n");
+
+	for (i = 0; i < ARRAY_SIZE(aspeed_crypto_algs); i++) {
+		aspeed_crypto_algs[i].hace_dev = hace_dev;
+		rc = crypto_register_skcipher(&aspeed_crypto_algs[i].alg.skcipher);
+		if (rc) {
+			CIPHER_DBG(hace_dev, "Failed to register %s\n",
+				   aspeed_crypto_algs[i].alg.skcipher.base.cra_name);
+		}
+	}
+
+	if (hace_dev->version != AST2600_VERSION)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(aspeed_crypto_algs_g6); i++) {
+		aspeed_crypto_algs_g6[i].hace_dev = hace_dev;
+		rc = crypto_register_skcipher(&aspeed_crypto_algs_g6[i].alg.skcipher);
+		if (rc) {
+			CIPHER_DBG(hace_dev, "Failed to register %s\n",
+				   aspeed_crypto_algs_g6[i].alg.skcipher.base.cra_name);
+		}
+	}
+}
diff --git a/drivers/crypto/aspeed/aspeed-hace.c b/drivers/crypto/aspeed/aspeed-hace.c
index 35b6017b3032..4c3b8dcec9d8 100644
--- a/drivers/crypto/aspeed/aspeed-hace.c
+++ b/drivers/crypto/aspeed/aspeed-hace.c
@@ -31,10 +31,22 @@ void __weak aspeed_unregister_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
 	pr_warn("%s: Not supported yet\n", __func__);
 }
 
+/* Weak function for HACE crypto */
+void __weak aspeed_register_hace_crypto_algs(struct aspeed_hace_dev *hace_dev)
+{
+	pr_warn("%s: Not supported yet\n", __func__);
+}
+
+void __weak aspeed_unregister_hace_crypto_algs(struct aspeed_hace_dev *hace_dev)
+{
+	pr_warn("%s: Not supported yet\n", __func__);
+}
+
 /* HACE interrupt service routine */
 static irqreturn_t aspeed_hace_irq(int irq, void *dev)
 {
 	struct aspeed_hace_dev *hace_dev = (struct aspeed_hace_dev *)dev;
+	struct aspeed_engine_crypto *crypto_engine = &hace_dev->crypto_engine;
 	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
 	u32 sts;
 
@@ -50,9 +62,24 @@ static irqreturn_t aspeed_hace_irq(int irq, void *dev)
 			dev_warn(hace_dev->dev, "HASH no active requests.\n");
 	}
 
+	if (sts & HACE_CRYPTO_ISR) {
+		if (crypto_engine->flags & CRYPTO_FLAGS_BUSY)
+			tasklet_schedule(&crypto_engine->done_task);
+		else
+			dev_warn(hace_dev->dev, "CRYPTO no active requests.\n");
+	}
+
 	return IRQ_HANDLED;
 }
 
+static void aspeed_hace_cryptro_done_task(unsigned long data)
+{
+	struct aspeed_hace_dev *hace_dev = (struct aspeed_hace_dev *)data;
+	struct aspeed_engine_crypto *crypto_engine = &hace_dev->crypto_engine;
+
+	crypto_engine->resume(hace_dev);
+}
+
 static void aspeed_hace_hash_done_task(unsigned long data)
 {
 	struct aspeed_hace_dev *hace_dev = (struct aspeed_hace_dev *)data;
@@ -64,11 +91,13 @@ static void aspeed_hace_hash_done_task(unsigned long data)
 static void aspeed_hace_register(struct aspeed_hace_dev *hace_dev)
 {
 	aspeed_register_hace_hash_algs(hace_dev);
+	aspeed_register_hace_crypto_algs(hace_dev);
 }
 
 static void aspeed_hace_unregister(struct aspeed_hace_dev *hace_dev)
 {
 	aspeed_unregister_hace_hash_algs(hace_dev);
+	aspeed_unregister_hace_crypto_algs(hace_dev);
 }
 
 static const struct of_device_id aspeed_hace_of_matches[] = {
@@ -79,6 +108,7 @@ static const struct of_device_id aspeed_hace_of_matches[] = {
 
 static int aspeed_hace_probe(struct platform_device *pdev)
 {
+	struct aspeed_engine_crypto *crypto_engine;
 	const struct of_device_id *hace_dev_id;
 	struct aspeed_engine_hash *hash_engine;
 	struct aspeed_hace_dev *hace_dev;
@@ -99,6 +129,7 @@ static int aspeed_hace_probe(struct platform_device *pdev)
 	hace_dev->dev = &pdev->dev;
 	hace_dev->version = (unsigned long)hace_dev_id->data;
 	hash_engine = &hace_dev->hash_engine;
+	crypto_engine = &hace_dev->crypto_engine;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
@@ -115,6 +146,17 @@ static int aspeed_hace_probe(struct platform_device *pdev)
 	tasklet_init(&hash_engine->done_task, aspeed_hace_hash_done_task,
 		     (unsigned long)hace_dev);
 
+	/* Initialize crypto hardware engine structure for crypto */
+	hace_dev->crypt_engine_crypto = crypto_engine_alloc_init(hace_dev->dev,
+								 true);
+
+	rc = crypto_engine_start(hace_dev->crypt_engine_crypto);
+	if (rc)
+		goto err_engine_crypto_start;
+
+	tasklet_init(&crypto_engine->done_task, aspeed_hace_cryptro_done_task,
+		     (unsigned long)hace_dev);
+
 	hace_dev->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (!hace_dev->regs) {
 		dev_err(&pdev->dev, "Failed to map resources\n");
@@ -160,14 +202,66 @@ static int aspeed_hace_probe(struct platform_device *pdev)
 		goto clk_exit;
 	}
 
+	/* Allocate DMA buffer for crypto engine context used */
+	crypto_engine->cipher_ctx =
+		dma_alloc_coherent(&pdev->dev,
+				   PAGE_SIZE,
+				   &crypto_engine->cipher_ctx_dma,
+				   GFP_KERNEL);
+	if (!crypto_engine->cipher_ctx) {
+		dev_err(&pdev->dev, "Failed to allocate cipher ctx dma\n");
+		rc = -ENOMEM;
+		goto free_hash_src;
+	}
+
+	/* Allocate DMA buffer for crypto engine input used */
+	crypto_engine->cipher_addr =
+		dma_alloc_coherent(&pdev->dev,
+				   ASPEED_CRYPTO_SRC_DMA_BUF_LEN,
+				   &crypto_engine->cipher_dma_addr,
+				   GFP_KERNEL);
+	if (!crypto_engine->cipher_addr) {
+		dev_err(&pdev->dev, "Failed to allocate cipher addr dma\n");
+		rc = -ENOMEM;
+		goto free_cipher_ctx;
+	}
+
+	/* Allocate DMA buffer for crypto engine output used */
+	if (hace_dev->version == AST2600_VERSION) {
+		crypto_engine->dst_sg_addr =
+			dma_alloc_coherent(&pdev->dev,
+					   ASPEED_CRYPTO_DST_DMA_BUF_LEN,
+					   &crypto_engine->dst_sg_dma_addr,
+					   GFP_KERNEL);
+		if (!crypto_engine->dst_sg_addr) {
+			dev_err(&pdev->dev, "Failed to allocate dst_sg dma\n");
+			rc = -ENOMEM;
+			goto free_cipher_addr;
+		}
+	}
+
 	aspeed_hace_register(hace_dev);
 
 	dev_info(&pdev->dev, "ASPEED Crypto Accelerator successfully registered\n");
 
 	return rc;
 
+free_cipher_addr:
+	dma_free_coherent(&pdev->dev, ASPEED_CRYPTO_SRC_DMA_BUF_LEN,
+			  crypto_engine->cipher_addr,
+			  crypto_engine->cipher_dma_addr);
+free_cipher_ctx:
+	dma_free_coherent(&pdev->dev, PAGE_SIZE,
+			  crypto_engine->cipher_ctx,
+			  crypto_engine->cipher_ctx_dma);
+free_hash_src:
+	dma_free_coherent(&pdev->dev, ASPEED_HASH_SRC_DMA_BUF_LEN,
+			  hash_engine->ahash_src_addr,
+			  hash_engine->ahash_src_dma_addr);
 clk_exit:
 	clk_disable_unprepare(hace_dev->clk);
+err_engine_crypto_start:
+	crypto_engine_exit(hace_dev->crypt_engine_crypto);
 err_engine_hash_start:
 	crypto_engine_exit(hace_dev->crypt_engine_hash);
 
@@ -177,17 +271,31 @@ static int aspeed_hace_probe(struct platform_device *pdev)
 static int aspeed_hace_remove(struct platform_device *pdev)
 {
 	struct aspeed_hace_dev *hace_dev = platform_get_drvdata(pdev);
+	struct aspeed_engine_crypto *crypto_engine = &hace_dev->crypto_engine;
 	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
 
 	aspeed_hace_unregister(hace_dev);
 
 	crypto_engine_exit(hace_dev->crypt_engine_hash);
+	crypto_engine_exit(hace_dev->crypt_engine_crypto);
 
 	tasklet_kill(&hash_engine->done_task);
+	tasklet_kill(&crypto_engine->done_task);
 
 	dma_free_coherent(&pdev->dev, ASPEED_HASH_SRC_DMA_BUF_LEN,
 			  hash_engine->ahash_src_addr,
 			  hash_engine->ahash_src_dma_addr);
+	dma_free_coherent(&pdev->dev, PAGE_SIZE,
+			  crypto_engine->cipher_ctx,
+			  crypto_engine->cipher_ctx_dma);
+	dma_free_coherent(&pdev->dev, ASPEED_CRYPTO_SRC_DMA_BUF_LEN,
+			  crypto_engine->cipher_addr,
+			  crypto_engine->cipher_dma_addr);
+
+	if (hace_dev->version == AST2600_VERSION)
+		dma_alloc_coherent(&pdev->dev, ASPEED_CRYPTO_DST_DMA_BUF_LEN,
+				   crypto_engine->dst_sg_addr,
+				   crypto_engine->dst_sg_dma_addr);
 
 	clk_disable_unprepare(hace_dev->clk);
 
diff --git a/drivers/crypto/aspeed/aspeed-hace.h b/drivers/crypto/aspeed/aspeed-hace.h
index a9aa1e1d90fe..813e441d19d7 100644
--- a/drivers/crypto/aspeed/aspeed-hace.h
+++ b/drivers/crypto/aspeed/aspeed-hace.h
@@ -7,9 +7,12 @@
 #include <linux/err.h>
 #include <linux/fips.h>
 #include <linux/dma-mapping.h>
+#include <crypto/aes.h>
+#include <crypto/des.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/internal/aead.h>
 #include <crypto/internal/akcipher.h>
+#include <crypto/internal/des.h>
 #include <crypto/internal/hash.h>
 #include <crypto/internal/kpp.h>
 #include <crypto/internal/skcipher.h>
@@ -24,15 +27,75 @@
  * HACE register definitions *
  *                           *
  * ***************************/
+#define ASPEED_HACE_SRC			0x00	/* Crypto Data Source Base Address Register */
+#define ASPEED_HACE_DEST		0x04	/* Crypto Data Destination Base Address Register */
+#define ASPEED_HACE_CONTEXT		0x08	/* Crypto Context Buffer Base Address Register */
+#define ASPEED_HACE_DATA_LEN		0x0C	/* Crypto Data Length Register */
+#define ASPEED_HACE_CMD			0x10	/* Crypto Engine Command Register */
+
+/* G5 */
+#define ASPEED_HACE_TAG			0x18	/* HACE Tag Register */
+/* G6 */
+#define ASPEED_HACE_GCM_ADD_LEN		0x14	/* Crypto AES-GCM Additional Data Length Register */
+#define ASPEED_HACE_GCM_TAG_BASE_ADDR	0x18	/* Crypto AES-GCM Tag Write Buff Base Address Reg */
 
 #define ASPEED_HACE_STS			0x1C	/* HACE Status Register */
+
 #define ASPEED_HACE_HASH_SRC		0x20	/* Hash Data Source Base Address Register */
 #define ASPEED_HACE_HASH_DIGEST_BUFF	0x24	/* Hash Digest Write Buffer Base Address Register */
 #define ASPEED_HACE_HASH_KEY_BUFF	0x28	/* Hash HMAC Key Buffer Base Address Register */
 #define ASPEED_HACE_HASH_DATA_LEN	0x2C	/* Hash Data Length Register */
 #define ASPEED_HACE_HASH_CMD		0x30	/* Hash Engine Command Register */
 
+/* crypto cmd */
+#define  HACE_CMD_SINGLE_DES		0
+#define  HACE_CMD_TRIPLE_DES		BIT(17)
+#define  HACE_CMD_AES_SELECT		0
+#define  HACE_CMD_DES_SELECT		BIT(16)
+#define  HACE_CMD_ISR_EN		BIT(12)
+#define  HACE_CMD_CONTEXT_SAVE_ENABLE	(0)
+#define  HACE_CMD_CONTEXT_SAVE_DISABLE	BIT(9)
+#define  HACE_CMD_AES			(0)
+#define  HACE_CMD_DES			(0)
+#define  HACE_CMD_RC4			BIT(8)
+#define  HACE_CMD_DECRYPT		(0)
+#define  HACE_CMD_ENCRYPT		BIT(7)
+
+#define  HACE_CMD_ECB			(0x0 << 4)
+#define  HACE_CMD_CBC			(0x1 << 4)
+#define  HACE_CMD_CFB			(0x2 << 4)
+#define  HACE_CMD_OFB			(0x3 << 4)
+#define  HACE_CMD_CTR			(0x4 << 4)
+#define  HACE_CMD_OP_MODE_MASK		(0x7 << 4)
+
+#define  HACE_CMD_AES128		(0x0 << 2)
+#define  HACE_CMD_AES192		(0x1 << 2)
+#define  HACE_CMD_AES256		(0x2 << 2)
+#define  HACE_CMD_OP_CASCADE		(0x3)
+#define  HACE_CMD_OP_INDEPENDENT	(0x1)
+
+/* G5 */
+#define  HACE_CMD_RI_WO_DATA_ENABLE	(0)
+#define  HACE_CMD_RI_WO_DATA_DISABLE	BIT(11)
+#define  HACE_CMD_CONTEXT_LOAD_ENABLE	(0)
+#define  HACE_CMD_CONTEXT_LOAD_DISABLE	BIT(10)
+/* G6 */
+#define  HACE_CMD_AES_KEY_FROM_OTP	BIT(24)
+#define  HACE_CMD_GHASH_TAG_XOR_EN	BIT(23)
+#define  HACE_CMD_GHASH_PAD_LEN_INV	BIT(22)
+#define  HACE_CMD_GCM_TAG_ADDR_SEL	BIT(21)
+#define  HACE_CMD_MBUS_REQ_SYNC_EN	BIT(20)
+#define  HACE_CMD_DES_SG_CTRL		BIT(19)
+#define  HACE_CMD_SRC_SG_CTRL		BIT(18)
+#define  HACE_CMD_CTR_IV_AES_96		(0x1 << 14)
+#define  HACE_CMD_CTR_IV_DES_32		(0x1 << 14)
+#define  HACE_CMD_CTR_IV_AES_64		(0x2 << 14)
+#define  HACE_CMD_CTR_IV_AES_32		(0x3 << 14)
+#define  HACE_CMD_AES_KEY_HW_EXP	BIT(13)
+#define  HACE_CMD_GCM			(0x5 << 4)
+
 /* interrupt status reg */
+#define  HACE_CRYPTO_ISR		BIT(12)
 #define  HACE_HASH_ISR			BIT(9)
 #define  HACE_HASH_BUSY			BIT(0)
 
@@ -77,6 +140,9 @@
 #define ASPEED_HASH_SRC_DMA_BUF_LEN	0xa000
 #define ASPEED_HASH_QUEUE_LENGTH	50
 
+#define HACE_CMD_IV_REQUIRE		(HACE_CMD_CBC | HACE_CMD_CFB | \
+					 HACE_CMD_OFB | HACE_CMD_CTR)
+
 struct aspeed_hace_dev;
 
 typedef int (*aspeed_hace_fn_t)(struct aspeed_hace_dev *);
@@ -145,6 +211,44 @@ struct aspeed_sham_reqctx {
 	u64			digcnt[2];
 };
 
+struct aspeed_engine_crypto {
+	struct tasklet_struct		done_task;
+	unsigned long			flags;
+	struct skcipher_request		*req;
+
+	/* context buffer */
+	void				*cipher_ctx;
+	dma_addr_t			cipher_ctx_dma;
+
+	/* input buffer, could be single/scatter-gather lists */
+	void				*cipher_addr;
+	dma_addr_t			cipher_dma_addr;
+
+	/* output buffer, only used in scatter-gather lists */
+	void				*dst_sg_addr;
+	dma_addr_t			dst_sg_dma_addr;
+
+	/* callback func */
+	aspeed_hace_fn_t		resume;
+};
+
+struct aspeed_cipher_ctx {
+	struct crypto_engine_ctx	enginectx;
+
+	struct aspeed_hace_dev		*hace_dev;
+	int				key_len;
+	u8				key[AES_MAX_KEYLENGTH];
+
+	/* callback func */
+	aspeed_hace_fn_t		start;
+};
+
+struct aspeed_cipher_reqctx {
+	int enc_cmd;
+	int src_nents;
+	int dst_nents;
+};
+
 struct aspeed_hace_dev {
 	void __iomem			*regs;
 	struct device			*dev;
@@ -153,8 +257,10 @@ struct aspeed_hace_dev {
 	unsigned long			version;
 
 	struct crypto_engine		*crypt_engine_hash;
+	struct crypto_engine		*crypt_engine_crypto;
 
 	struct aspeed_engine_hash	hash_engine;
+	struct aspeed_engine_crypto	crypto_engine;
 };
 
 struct aspeed_hace_alg {
@@ -177,5 +283,7 @@ enum aspeed_version {
 
 void aspeed_register_hace_hash_algs(struct aspeed_hace_dev *hace_dev);
 void aspeed_unregister_hace_hash_algs(struct aspeed_hace_dev *hace_dev);
+void aspeed_register_hace_crypto_algs(struct aspeed_hace_dev *hace_dev);
+void aspeed_unregister_hace_crypto_algs(struct aspeed_hace_dev *hace_dev);
 
 #endif
-- 
2.25.1

