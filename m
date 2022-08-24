Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAFF59F6DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbiHXJvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiHXJuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:50:32 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9D83E746;
        Wed, 24 Aug 2022 02:50:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VN6xHAc_1661334626;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VN6xHAc_1661334626)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 17:50:27 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     herbert@gondor.apana.org.au
Cc:     zelin.deng@linux.alibaba.com, guanjun@linux.alibaba.com,
        xuchun.shang@linux.alibaba.com, artie.ding@linux.alibaba.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/9] crypto/ycc: Add aead algorithm support
Date:   Wed, 24 Aug 2022 17:50:18 +0800
Message-Id: <1661334621-44413-7-git-send-email-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
References: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guanjun <guanjun@linux.alibaba.com>

Support aead algorithm.

Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
---
 drivers/crypto/ycc/Kconfig    |   1 +
 drivers/crypto/ycc/Makefile   |   2 +-
 drivers/crypto/ycc/ycc_aead.c | 646 ++++++++++++++++++++++++++++++++++++++++++
 drivers/crypto/ycc/ycc_algs.h |  20 +-
 drivers/crypto/ycc/ycc_drv.c  |   7 +
 drivers/crypto/ycc/ycc_ring.h |  14 +
 6 files changed, 687 insertions(+), 3 deletions(-)
 create mode 100644 drivers/crypto/ycc/ycc_aead.c

diff --git a/drivers/crypto/ycc/Kconfig b/drivers/crypto/ycc/Kconfig
index 8dae75e..d2808c3 100644
--- a/drivers/crypto/ycc/Kconfig
+++ b/drivers/crypto/ycc/Kconfig
@@ -5,6 +5,7 @@ config CRYPTO_DEV_YCC
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_DES
 	select CRYPTO_SM3_GENERIC
+	select CRYPTO_AEAD
 	select CRYPTO_AES
 	select CRYPTO_CBC
 	select CRYPTO_ECB
diff --git a/drivers/crypto/ycc/Makefile b/drivers/crypto/ycc/Makefile
index 921034d..78fdeed 100644
--- a/drivers/crypto/ycc/Makefile
+++ b/drivers/crypto/ycc/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-(CONFIG_CRYPTO_DEV_YCC) += ycc.o
-ycc-objs := ycc_drv.o ycc_isr.o ycc_cdev.o ycc_ring.o ycc_ske.o
+ycc-objs := ycc_drv.o ycc_isr.o ycc_cdev.o ycc_ring.o ycc_ske.o ycc_aead.o
diff --git a/drivers/crypto/ycc/ycc_aead.c b/drivers/crypto/ycc/ycc_aead.c
new file mode 100644
index 00000000..8e9489e
--- /dev/null
+++ b/drivers/crypto/ycc/ycc_aead.c
@@ -0,0 +1,646 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "YCC: Crypto: " fmt
+
+#include <crypto/internal/aead.h>
+#include <crypto/internal/des.h>
+#include <crypto/scatterwalk.h>
+#include <linux/dma-mapping.h>
+#include <linux/crypto.h>
+#include <crypto/aes.h>
+#include <crypto/gcm.h>
+#include <crypto/sm4.h>
+#include "ycc_algs.h"
+
+static int ycc_aead_init(struct crypto_aead *tfm)
+{
+	struct ycc_crypto_ctx *ctx = crypto_aead_ctx(tfm);
+	struct ycc_ring *ring;
+
+	ctx->soft_tfm = crypto_alloc_aead(crypto_tfm_alg_name(crypto_aead_tfm(tfm)),
+					  0,
+					  CRYPTO_ALG_NEED_FALLBACK | CRYPTO_ALG_ASYNC);
+	if (IS_ERR(ctx->soft_tfm)) {
+		pr_warn("Failed to allocate soft tfm for:%s, software fallback is limited\n",
+			crypto_tfm_alg_name(crypto_aead_tfm(tfm)));
+		ctx->soft_tfm = NULL;
+		crypto_aead_set_reqsize(tfm, sizeof(struct ycc_crypto_req));
+	} else {
+		/*
+		 * If it's software fallback, store meta data of soft request.
+		 */
+		crypto_aead_set_reqsize(tfm, sizeof(struct ycc_crypto_req) +
+					crypto_aead_reqsize(ctx->soft_tfm));
+	}
+
+	ring = ycc_crypto_get_ring();
+	if (!ring)
+		return -ENOMEM;
+
+	ctx->ring = ring;
+	return 0;
+}
+
+static void ycc_aead_exit(struct crypto_aead *tfm)
+{
+	struct ycc_crypto_ctx *ctx = crypto_aead_ctx(tfm);
+
+	if (ctx->ring)
+		ycc_crypto_free_ring(ctx->ring);
+
+	kfree(ctx->cipher_key);
+
+	if (ctx->soft_tfm)
+		crypto_free_aead((struct crypto_aead *)ctx->soft_tfm);
+}
+
+static int ycc_aead_setkey(struct crypto_aead *tfm, const u8 *key,
+			   unsigned int key_size)
+{
+	struct ycc_crypto_ctx *ctx = crypto_aead_ctx(tfm);
+	const char *alg_name = crypto_tfm_alg_name(&tfm->base);
+
+	if (!strncmp("gcm(sm4)", alg_name, strlen("gcm(sm4)"))) {
+		if (key_size != SM4_KEY_SIZE)
+			return -EINVAL;
+		ctx->mode = YCC_SM4_GCM;
+	} else if (!strncmp("ccm(sm4)", alg_name, strlen("ccm(sm4)"))) {
+		ctx->mode = YCC_SM4_CCM;
+	} else if (!strncmp("gcm(aes)", alg_name, strlen("gcm(aes)"))) {
+		switch (key_size) {
+		case AES_KEYSIZE_128:
+			ctx->mode = YCC_AES_128_GCM;
+			break;
+		case AES_KEYSIZE_192:
+			ctx->mode = YCC_AES_192_GCM;
+			break;
+		case AES_KEYSIZE_256:
+			ctx->mode = YCC_AES_256_GCM;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else if (!strncmp("ccm(aes)", alg_name, strlen("ccm(aes)"))) {
+		switch (key_size) {
+		case AES_KEYSIZE_128:
+			ctx->mode = YCC_AES_128_CCM;
+			break;
+		case AES_KEYSIZE_192:
+			ctx->mode = YCC_AES_192_CCM;
+			break;
+		case AES_KEYSIZE_256:
+			ctx->mode = YCC_AES_256_CCM;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (ctx->cipher_key) {
+		memset(ctx->cipher_key, 0, ctx->keysize);
+	} else {
+		ctx->cipher_key = kzalloc(key_size, GFP_KERNEL);
+		if (!ctx->cipher_key)
+			return -ENOMEM;
+	}
+
+	memcpy(ctx->cipher_key, key, key_size);
+	ctx->keysize = key_size;
+	if (ctx->soft_tfm)
+		if (crypto_aead_setkey(ctx->soft_tfm, key, key_size))
+			pr_warn("Failed to setkey for soft aead tfm\n");
+
+	return 0;
+}
+
+static int ycc_aead_fill_key(struct ycc_crypto_req *req)
+{
+	struct ycc_crypto_ctx *ctx = req->ctx;
+	struct device *dev = YCC_DEV(ctx);
+	struct aead_request *aead_req = req->aead_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
+	const char *alg_name = crypto_tfm_alg_name(&tfm->base);
+	int iv_len = 12;
+
+	if (!strncmp("ccm", alg_name, strlen("ccm")))
+		iv_len = 16;
+
+	if (!req->key_vaddr) {
+		req->key_vaddr = dma_alloc_coherent(dev, 64, &req->key_paddr,
+						    GFP_ATOMIC);
+		if (!req->key_vaddr)
+			return -ENOMEM;
+	}
+
+	memset(req->key_vaddr, 0, 64);
+	memcpy(req->key_vaddr + (32 - ctx->keysize), ctx->cipher_key, ctx->keysize);
+	memcpy(req->key_vaddr + 32, req->aead_req->iv, iv_len);
+	ctx->key_dma_size = 64;
+	return 0;
+}
+
+static int ycc_aead_sg_map(struct ycc_crypto_req *req)
+{
+	struct device *dev = YCC_DEV(req->ctx);
+	int ret = -ENOMEM;
+
+	req->src_paddr = dma_map_single(dev, req->src_vaddr,
+					ALIGN(req->in_len, 64), DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, req->src_paddr)) {
+		pr_err("Failed to map src dma memory\n");
+		goto out;
+	}
+
+	req->dst_vaddr = dma_alloc_coherent(dev, ALIGN(req->out_len, 64),
+					    &req->dst_paddr, GFP_ATOMIC);
+	if (!req->dst_vaddr)
+		goto unmap_src;
+
+	return 0;
+unmap_src:
+	dma_unmap_single(dev, req->src_paddr, ALIGN(req->in_len, 64), DMA_TO_DEVICE);
+out:
+	return ret;
+}
+
+static void ycc_aead_sg_unmap(struct ycc_crypto_req *req)
+{
+	struct device *dev = YCC_DEV(req->ctx);
+
+	dma_unmap_single(dev, req->src_paddr, ALIGN(req->in_len, 64), DMA_TO_DEVICE);
+	dma_free_coherent(dev, ALIGN(req->in_len, 64), req->dst_vaddr, req->dst_paddr);
+}
+
+static inline void ycc_aead_unformat_data(struct ycc_crypto_req *req)
+{
+	kfree(req->src_vaddr);
+}
+
+static int ycc_aead_callback(void *ptr, u16 state)
+{
+	struct ycc_crypto_req *req = (struct ycc_crypto_req *)ptr;
+	struct aead_request *aead_req = req->aead_req;
+	struct ycc_crypto_ctx *ctx = req->ctx;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
+	int taglen = crypto_aead_authsize(tfm);
+	struct device *dev = YCC_DEV(ctx);
+
+	/* TODO: workaround for GCM/CCM with junk bytes between ctext and tag */
+	if ((req->desc.cmd.aead_cmd.cmd_id == YCC_CMD_GCM_ENC ||
+	     req->desc.cmd.aead_cmd.cmd_id == YCC_CMD_CCM_ENC) &&
+	     aead_req->cryptlen % 16 != 0)
+		memcpy(req->dst_vaddr + aead_req->cryptlen,
+		       req->dst_vaddr + ALIGN(aead_req->cryptlen, 16), taglen);
+	scatterwalk_map_and_copy(req->src_vaddr + req->aad_offset, aead_req->dst, 0,
+				 aead_req->assoclen, 1);
+	if (req->desc.cmd.aead_cmd.cmd_id == YCC_CMD_GCM_ENC ||
+	    req->desc.cmd.aead_cmd.cmd_id == YCC_CMD_CCM_ENC) {
+		scatterwalk_map_and_copy(req->dst_vaddr, aead_req->dst,
+					 aead_req->assoclen,
+					 aead_req->cryptlen + taglen, 1);
+	} else {
+		scatterwalk_map_and_copy(req->dst_vaddr, aead_req->dst,
+					 aead_req->assoclen,
+					 aead_req->cryptlen - taglen, 1);
+	}
+
+	ycc_aead_sg_unmap(req);
+	ycc_aead_unformat_data(req);
+	if (req->key_vaddr) {
+		memset(req->key_vaddr, 0, 64);
+		dma_free_coherent(dev, 64, req->key_vaddr, req->key_paddr);
+		req->key_vaddr = NULL;
+	}
+
+	if (aead_req->base.complete)
+		aead_req->base.complete(&aead_req->base, state == CMD_SUCCESS ? 0 : -EBADMSG);
+
+	return 0;
+}
+
+#define aead_blob_len(x, y, z)	ALIGN(((x) + (y) + (z)), 16)
+
+static void *__ycc_aead_format_data(struct ycc_crypto_req *req, u8 *b0, u8 *b1,
+				    int alen, u8 cmd)
+{
+	struct aead_request *aead_req = req->aead_req;
+	int aad_len = aead_req->assoclen;
+	int cryptlen = aead_req->cryptlen;
+	int taglen = crypto_aead_authsize(crypto_aead_reqtfm(aead_req));
+	int src_len = cryptlen;
+	int b0_len = 0;
+	void *vaddr;
+	int size;
+
+	/* b0 != NULL means ccm, b0 len is 16 bytes */
+	if (b0)
+		b0_len = 16;
+
+	size = aead_blob_len(b0_len, alen, aad_len);
+	if (cmd == YCC_CMD_GCM_DEC || cmd == YCC_CMD_CCM_DEC) {
+		/*
+		 * LKCF format is not aligned |cipher_text|tag_text|
+		 * while ycc request |16-align cipher_text|16-align tag_text|
+		 */
+		src_len = cryptlen - taglen;
+		size += ALIGN(src_len, 16) + ALIGN(taglen, 16);
+	} else {
+		size += ALIGN(cryptlen, 16);
+	}
+
+	vaddr = kzalloc(ALIGN(size, 64), GFP_ATOMIC);
+	if (!vaddr)
+		return NULL;
+
+	if (b0)
+		memcpy(vaddr, b0, b0_len);
+	if (b1)
+		memcpy(vaddr + b0_len, b1, alen);
+	scatterwalk_map_and_copy(vaddr + b0_len + alen, aead_req->src, 0,
+				 aad_len, 0);
+	scatterwalk_map_and_copy(vaddr + aead_blob_len(b0_len, alen, aad_len),
+				 aead_req->src, aad_len,
+				 src_len, 0);
+	if (cmd == YCC_CMD_GCM_DEC || cmd == YCC_CMD_CCM_DEC)
+		scatterwalk_map_and_copy(vaddr +
+					 aead_blob_len(b0_len, alen, aad_len) +
+					 ALIGN(src_len, 16),
+					 aead_req->src, aad_len + cryptlen - taglen,
+					 taglen, 0);
+
+	req->in_len = size;
+	req->aad_offset = b0_len + alen;
+	return vaddr;
+}
+
+static void *ycc_aead_format_ccm_data(struct ycc_crypto_req *req,
+				      u16 *new_aad_len, u8 cmd)
+{
+	struct aead_request *aead_req = req->aead_req;
+	unsigned int taglen = crypto_aead_authsize(crypto_aead_reqtfm(aead_req));
+	unsigned int aad_len = aead_req->assoclen;
+	unsigned int cryptlen = aead_req->cryptlen;
+	u8 b0[16] = {0};
+	u8 b1[10] = {0}; /* Store encoded aad length */
+	u8 alen = 0;
+	int l;
+	__be32 msglen;
+
+	/* 1. check iv value aead_req->iv[0] = L - 1 */
+	if (aead_req->iv[0] < 1 || aead_req->iv[0] > 7) {
+		pr_err("L value is not valid for CCM\n");
+		return NULL;
+	}
+
+	l = aead_req->iv[0] + 1;
+
+	/* 2. format control infomration and nonce */
+	memcpy(b0, aead_req->iv, 16); /* iv max size is 15 - L */
+	b0[0] |= (((taglen - 2) / 2) << 3);
+	if (aad_len) {
+		b0[0] |= (1 << 6);
+		if (aad_len < 65280) {
+			/* 2 bytes encode aad length */
+			*(__be16 *)b1 = cpu_to_be16(aad_len);
+			alen = 2;
+		} else {
+			*(__be16 *)b1 = cpu_to_be16(0xfffe);
+			*(__be32 *)&b1[2] = cpu_to_be32(aad_len);
+			alen = 6;
+		}
+		*new_aad_len = ALIGN((16 + alen + aad_len), 16);
+	} else {
+		*new_aad_len = 16;
+	}
+	b0[0] |= aead_req->iv[0];
+
+	/* 3. set msg length. L - 1 Bytes store msg length */
+	if (l >= 4)
+		l = 4;
+	else if (cryptlen > (1 << (8 * l)))
+		return NULL;
+	if (cmd == YCC_CMD_CCM_DEC)
+		msglen = cpu_to_be32(cryptlen - taglen);
+	else
+		msglen = cpu_to_be32(cryptlen);
+	memcpy(&b0[16 - l], (u8 *)&msglen + 4 - l, l);
+
+	return __ycc_aead_format_data(req, b0, b1, alen, cmd);
+}
+
+static void *ycc_aead_format_data(struct ycc_crypto_req *req, u16 *new_aad_len,
+				  u32 *new_cryptlen, u8 cmd)
+{
+	struct aead_request *aead_req = req->aead_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
+	int taglen = crypto_aead_authsize(tfm);
+
+	if (cmd == YCC_CMD_GCM_ENC || cmd == YCC_CMD_GCM_DEC) {
+		/* CCM */
+		*new_aad_len = aead_req->assoclen;
+		*new_cryptlen = aead_req->cryptlen;
+		req->out_len = *new_cryptlen + taglen;
+		return __ycc_aead_format_data(req, NULL, NULL, 0, cmd);
+	}
+
+	/* GCM */
+	*new_cryptlen = ALIGN(aead_req->cryptlen, 16);
+	req->out_len = *new_cryptlen + taglen;
+	return ycc_aead_format_ccm_data(req, new_aad_len, cmd);
+}
+
+/*
+ * This is a workaround. If ycc output len is outlen % 64 == 16, it
+ * might hang. taglen is 16 or 0
+ */
+static inline bool ycc_aead_do_soft(struct aead_request *aead_req, int taglen)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
+	struct ycc_crypto_ctx *ctx = crypto_aead_ctx(tfm);
+	struct ycc_dev *ydev = ctx->ring->ydev;
+
+	if ((ALIGN(aead_req->cryptlen, 64) + taglen) % 64 == 16 ||
+	    !test_bit(YDEV_STATUS_READY, &ydev->status))
+		return true;
+
+	return false;
+}
+
+static int ycc_aead_submit_desc(struct aead_request *aead_req, u8 cmd)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
+	struct ycc_crypto_ctx *ctx = crypto_aead_ctx(tfm);
+	struct ycc_crypto_req *req = aead_request_ctx(aead_req);
+	struct ycc_flags *aflags;
+	int taglen = crypto_aead_authsize(tfm);
+	u16 new_aad_len;
+	u32 new_cryptlen;
+	struct crypto_aes_ctx aes_ctx;
+	u8 tag[16];
+	u8 ziv[16] = {0};
+	__be32 counter = cpu_to_be32(1);
+	int ret = 0;
+
+	/*
+	 * YCC hw does not support gcm zero length plaintext. According to spec
+	 * if cryptlen is 0, just do aes_encrypt against IV
+	 */
+	if (aead_req->cryptlen == 0 && cmd == YCC_CMD_GCM_ENC) {
+		ret = aes_expandkey(&aes_ctx, ctx->cipher_key, ctx->keysize);
+		if (ret)
+			return ret;
+		memcpy(ziv, aead_req->iv, 12);
+		memcpy(ziv + 12, &counter, 4);
+		aes_encrypt(&aes_ctx, tag, ziv);
+		sg_copy_from_buffer(aead_req->dst,
+				    sg_nents_for_len(aead_req->dst, taglen),
+				    tag, taglen);
+		return 0;
+	}
+
+	if (aead_req->cryptlen == taglen && cmd == YCC_CMD_GCM_DEC) {
+		ret = aes_expandkey(&aes_ctx, ctx->cipher_key, ctx->keysize);
+		if (ret)
+			return ret;
+		/* Skip aad */
+		sg_copy_buffer(aead_req->src,
+			       sg_nents_for_len(aead_req->src, taglen),
+			       tag, taglen, aead_req->assoclen, 1);
+		aes_decrypt(&aes_ctx, ziv, tag);
+		sg_copy_from_buffer(aead_req->dst,
+				    sg_nents_for_len(aead_req->dst, taglen),
+				    ziv, taglen);
+		return 0;
+	}
+
+	memset(req, 0, sizeof(*req));
+	req->ctx = ctx;
+	req->aead_req = aead_req;
+
+	ret = ycc_aead_fill_key(req);
+	if (ret)
+		return ret;
+
+	req->src_vaddr = ycc_aead_format_data(req, &new_aad_len, &new_cryptlen, cmd);
+	if (!req->src_vaddr)
+		goto free_key;
+
+	ret = ycc_aead_sg_map(req);
+	if (ret)
+		goto unformat;
+
+	ret = -ENOMEM;
+	aflags = kzalloc(sizeof(struct ycc_flags), GFP_ATOMIC);
+	if (!aflags)
+		goto sg_unmap;
+
+	memset(&req->desc.cmd, 0, sizeof(union ycc_real_cmd));
+	aflags->ptr = (void *)req;
+	aflags->ycc_done_callback = ycc_aead_callback;
+	req->desc.private_ptr = (u64)aflags;
+	req->desc.cmd.aead_cmd.cmd_id = cmd;
+	req->desc.cmd.aead_cmd.mode = ctx->mode;
+	req->desc.cmd.aead_cmd.sptr = req->src_paddr;
+	req->desc.cmd.aead_cmd.dptr = req->dst_paddr;
+	if (cmd == YCC_CMD_GCM_DEC || cmd == YCC_CMD_CCM_DEC)
+		new_cryptlen = aead_req->cryptlen - taglen;
+	req->desc.cmd.aead_cmd.dlen = new_cryptlen;
+	req->desc.cmd.aead_cmd.keyptr = req->key_paddr;
+	req->desc.cmd.aead_cmd.aadlen = new_aad_len;
+	req->desc.cmd.aead_cmd.taglen = taglen;
+
+	/* 4. submit desc to cmd queue */
+	ret = ycc_enqueue(ctx->ring, &req->desc);
+	if (!ret)
+		return -EINPROGRESS;
+
+	pr_err("Failed to submit desc to ring\n");
+	kfree(aflags);
+
+sg_unmap:
+	ycc_aead_sg_unmap(req);
+unformat:
+	ycc_aead_unformat_data(req);
+free_key:
+	memset(req->key_vaddr, 0, 64);
+	dma_free_coherent(YCC_DEV(ctx), 64, req->key_vaddr, req->key_paddr);
+	req->key_vaddr = NULL;
+	return ret;
+}
+
+static int ycc_aead_ccm_encrypt(struct aead_request *aead_req)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
+	struct ycc_crypto_ctx *ctx = crypto_aead_ctx(tfm);
+	struct aead_request *subreq =
+		&((struct ycc_crypto_req *)aead_request_ctx(aead_req))->aead_subreq;
+
+	if (ycc_aead_do_soft(aead_req, 16)) {
+		if (!ctx->soft_tfm)
+			return -ENOENT;
+		aead_request_set_tfm(subreq, ctx->soft_tfm);
+		aead_request_set_callback(subreq, aead_req->base.flags,
+					  aead_req->base.complete, aead_req->base.data);
+		aead_request_set_crypt(subreq, aead_req->src, aead_req->dst,
+				       aead_req->cryptlen, aead_req->iv);
+		aead_request_set_ad(subreq, aead_req->assoclen);
+		crypto_aead_setauthsize(ctx->soft_tfm, crypto_aead_authsize(tfm));
+		return crypto_aead_encrypt(subreq);
+	}
+
+	return ycc_aead_submit_desc(aead_req, YCC_CMD_CCM_ENC);
+}
+
+static int ycc_aead_gcm_encrypt(struct aead_request *aead_req)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
+	struct ycc_crypto_ctx *ctx = crypto_aead_ctx(tfm);
+	struct aead_request *subreq =
+			&((struct ycc_crypto_req *)aead_request_ctx(aead_req))->aead_subreq;
+
+	if (ycc_aead_do_soft(aead_req, 16)) {
+		if (!ctx->soft_tfm)
+			return -ENOENT;
+		aead_request_set_tfm(subreq, ctx->soft_tfm);
+		aead_request_set_callback(subreq, aead_req->base.flags,
+					  aead_req->base.complete, aead_req->base.data);
+		aead_request_set_crypt(subreq, aead_req->src, aead_req->dst,
+				       aead_req->cryptlen, aead_req->iv);
+		aead_request_set_ad(subreq, aead_req->assoclen);
+		crypto_aead_setauthsize(ctx->soft_tfm, crypto_aead_authsize(tfm));
+		return crypto_aead_encrypt(subreq);
+	}
+
+	return ycc_aead_submit_desc(aead_req, YCC_CMD_GCM_ENC);
+}
+
+static int ycc_aead_gcm_decrypt(struct aead_request *aead_req)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
+	struct ycc_crypto_ctx *ctx = crypto_aead_ctx(tfm);
+	struct aead_request *subreq =
+		&((struct ycc_crypto_req *)aead_request_ctx(aead_req))->aead_subreq;
+
+	if (ycc_aead_do_soft(aead_req, 0)) {
+		if (!ctx->soft_tfm)
+			return -ENOENT;
+		aead_request_set_tfm(subreq, ctx->soft_tfm);
+		aead_request_set_callback(subreq, aead_req->base.flags,
+					  aead_req->base.complete, aead_req->base.data);
+		aead_request_set_crypt(subreq, aead_req->src, aead_req->dst,
+				       aead_req->cryptlen, aead_req->iv);
+		aead_request_set_ad(subreq, aead_req->assoclen);
+		crypto_aead_setauthsize(ctx->soft_tfm, crypto_aead_authsize(tfm));
+		return crypto_aead_decrypt(subreq);
+	}
+
+	return ycc_aead_submit_desc(aead_req, YCC_CMD_GCM_DEC);
+}
+
+static int ycc_aead_ccm_decrypt(struct aead_request *aead_req)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
+	struct ycc_crypto_ctx *ctx = crypto_aead_ctx(tfm);
+	struct aead_request *subreq =
+		&((struct ycc_crypto_req *)aead_request_ctx(aead_req))->aead_subreq;
+
+	if (ycc_aead_do_soft(aead_req, 0)) {
+		if (!ctx->soft_tfm)
+			return -ENOENT;
+		aead_request_set_tfm(subreq, ctx->soft_tfm);
+		aead_request_set_callback(subreq, aead_req->base.flags,
+					  aead_req->base.complete, aead_req->base.data);
+		aead_request_set_crypt(subreq, aead_req->src, aead_req->dst,
+				       aead_req->cryptlen, aead_req->iv);
+		aead_request_set_ad(subreq, aead_req->assoclen);
+		crypto_aead_setauthsize(ctx->soft_tfm, crypto_aead_authsize(tfm));
+		return crypto_aead_decrypt(subreq);
+	}
+
+	return ycc_aead_submit_desc(aead_req, YCC_CMD_CCM_DEC);
+}
+
+static struct aead_alg ycc_aeads[] = {
+	{
+		.base = {
+			.cra_name = "gcm(aes)",
+			.cra_driver_name = "gcm-aes-ycc",
+			.cra_priority = 350,
+			.cra_flags = CRYPTO_ALG_ASYNC,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct ycc_crypto_ctx),
+			.cra_module = THIS_MODULE,
+		},
+		.init = ycc_aead_init,
+		.exit = ycc_aead_exit,
+		.setkey = ycc_aead_setkey,
+		.decrypt = ycc_aead_gcm_decrypt,
+		.encrypt = ycc_aead_gcm_encrypt,
+		.ivsize = AES_BLOCK_SIZE,
+		.maxauthsize = AES_BLOCK_SIZE,
+	},
+	{
+		.base = {
+			.cra_name = "gcm(sm4)",
+			.cra_driver_name = "gcm-sm4-ycc",
+			.cra_priority = 350,
+			.cra_flags = CRYPTO_ALG_ASYNC,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct ycc_crypto_ctx),
+			.cra_module = THIS_MODULE,
+		},
+		.init = ycc_aead_init,
+		.exit = ycc_aead_exit,
+		.setkey = ycc_aead_setkey,
+		.decrypt = ycc_aead_gcm_decrypt,
+		.encrypt = ycc_aead_gcm_encrypt,
+		.ivsize = SM4_BLOCK_SIZE,
+		.maxauthsize = SM4_BLOCK_SIZE,
+	},
+	{
+		.base = {
+			.cra_name = "ccm(aes)",
+			.cra_driver_name = "ccm-aes-ycc",
+			.cra_priority = 350,
+			.cra_flags = CRYPTO_ALG_ASYNC,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct ycc_crypto_ctx),
+			.cra_module = THIS_MODULE,
+		},
+		.init = ycc_aead_init,
+		.exit = ycc_aead_exit,
+		.setkey = ycc_aead_setkey,
+		.decrypt = ycc_aead_ccm_decrypt,
+		.encrypt = ycc_aead_ccm_encrypt,
+		.ivsize = AES_BLOCK_SIZE,
+		.maxauthsize = AES_BLOCK_SIZE,
+	},
+	{
+		.base = {
+			.cra_name = "ccm(sm4)",
+			.cra_driver_name = "ccm-sm4-ycc",
+			.cra_priority = 350,
+			.cra_flags = CRYPTO_ALG_ASYNC,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct ycc_crypto_ctx),
+			.cra_module = THIS_MODULE,
+		},
+		.init = ycc_aead_init,
+		.exit = ycc_aead_exit,
+		.setkey = ycc_aead_setkey,
+		.decrypt = ycc_aead_ccm_decrypt,
+		.encrypt = ycc_aead_ccm_encrypt,
+		.ivsize = SM4_BLOCK_SIZE,
+		.maxauthsize = SM4_BLOCK_SIZE,
+	},
+};
+
+int ycc_aead_register(void)
+{
+	return crypto_register_aeads(ycc_aeads, ARRAY_SIZE(ycc_aeads));
+}
+
+void ycc_aead_unregister(void)
+{
+	crypto_unregister_aeads(ycc_aeads, ARRAY_SIZE(ycc_aeads));
+}
diff --git a/drivers/crypto/ycc/ycc_algs.h b/drivers/crypto/ycc/ycc_algs.h
index 6c7b0dc..e3be83ec 100644
--- a/drivers/crypto/ycc/ycc_algs.h
+++ b/drivers/crypto/ycc/ycc_algs.h
@@ -3,6 +3,7 @@
 #define __YCC_ALG_H
 
 #include <crypto/skcipher.h>
+#include <crypto/aead.h>
 
 #include "ycc_ring.h"
 #include "ycc_dev.h"
@@ -70,6 +71,11 @@ enum ycc_ske_alg_mode {
 enum ycc_cmd_id {
 	YCC_CMD_SKE_ENC = 0x23,
 	YCC_CMD_SKE_DEC,
+
+	YCC_CMD_GCM_ENC = 0x25,
+	YCC_CMD_GCM_DEC,
+	YCC_CMD_CCM_ENC,
+	YCC_CMD_CCM_DEC, /* 0x28 */
 };
 
 struct ycc_crypto_ctx {
@@ -92,8 +98,10 @@ struct ycc_crypto_req {
 	dma_addr_t key_paddr;
 
 	struct ycc_cmd_desc desc;
-	struct skcipher_request *ske_req;
-	struct skcipher_request ske_subreq;
+	union {
+		struct skcipher_request *ske_req;
+		struct aead_request *aead_req;
+	};
 
 	void *src_vaddr;
 	dma_addr_t src_paddr;
@@ -105,10 +113,18 @@ struct ycc_crypto_req {
 	int aad_offset;
 	struct ycc_crypto_ctx *ctx;
 	u8 last_block[16]; /* used to store iv out when decrypt */
+
+	/* soft request for fallback, keep at the end */
+	union {
+		struct skcipher_request ske_subreq;
+		struct aead_request aead_subreq;
+	};
 };
 
 #define YCC_DEV(ctx)		(&(ctx)->ring->ydev->pdev->dev)
 
 int ycc_sym_register(void);
 void ycc_sym_unregister(void);
+int ycc_aead_register(void);
+void ycc_aead_unregister(void);
 #endif
diff --git a/drivers/crypto/ycc/ycc_drv.c b/drivers/crypto/ycc/ycc_drv.c
index 2cca83b..9522b42 100644
--- a/drivers/crypto/ycc/ycc_drv.c
+++ b/drivers/crypto/ycc/ycc_drv.c
@@ -95,8 +95,14 @@ int ycc_algorithm_register(void)
 	if (ret)
 		goto err;
 
+	ret = ycc_aead_register();
+	if (ret)
+		goto unregister_sym;
+
 	return 0;
 
+unregister_sym:
+	ycc_sym_unregister();
 err:
 	atomic_dec(&ycc_algs_refcnt);
 	return ret;
@@ -110,6 +116,7 @@ void ycc_algorithm_unregister(void)
 	if (atomic_dec_return(&ycc_algs_refcnt))
 		return;
 
+	ycc_aead_unregister();
 	ycc_sym_unregister();
 }
 
diff --git a/drivers/crypto/ycc/ycc_ring.h b/drivers/crypto/ycc/ycc_ring.h
index 78ba959..2caa9e0 100644
--- a/drivers/crypto/ycc/ycc_ring.h
+++ b/drivers/crypto/ycc/ycc_ring.h
@@ -87,8 +87,22 @@ struct ycc_skcipher_cmd {
 	u8 padding;
 } __packed;
 
+struct ycc_aead_cmd {
+	u8 cmd_id;
+	u8 mode;
+	u64 sptr:48;	/* include aad + payload */
+	u64 dptr:48;	/* encrypted/decrypted + tag */
+	u32 dlen;	/* data size */
+	u16 key_idx;
+	u16 kek_idx;
+	u64 keyptr:48;
+	u16 aadlen;
+	u8 taglen;	/* authenc size */
+} __packed;
+
 union ycc_real_cmd {
 	struct ycc_skcipher_cmd ske_cmd;
+	struct ycc_aead_cmd aead_cmd;
 	u8 padding[32];
 };
 
-- 
1.8.3.1

