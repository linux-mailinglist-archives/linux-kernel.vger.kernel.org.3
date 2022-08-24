Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D7859F6D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbiHXJvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiHXJud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:50:33 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8993ECC7;
        Wed, 24 Aug 2022 02:50:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VN6v3aO_1661334627;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VN6v3aO_1661334627)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 17:50:27 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     herbert@gondor.apana.org.au
Cc:     zelin.deng@linux.alibaba.com, guanjun@linux.alibaba.com,
        xuchun.shang@linux.alibaba.com, artie.ding@linux.alibaba.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/9] crypto/ycc: Add rsa algorithm support
Date:   Wed, 24 Aug 2022 17:50:19 +0800
Message-Id: <1661334621-44413-8-git-send-email-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
References: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guanjun <guanjun@linux.alibaba.com>

Support rsa algorithm for ycc. That includes encryption\decryption
and verification\signature

Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
---
 drivers/crypto/ycc/Makefile   |   2 +-
 drivers/crypto/ycc/ycc_algs.h |  44 +++
 drivers/crypto/ycc/ycc_drv.c  |   7 +
 drivers/crypto/ycc/ycc_pke.c  | 696 ++++++++++++++++++++++++++++++++++++++++++
 drivers/crypto/ycc/ycc_ring.h |  23 ++
 5 files changed, 771 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/ycc/ycc_pke.c

diff --git a/drivers/crypto/ycc/Makefile b/drivers/crypto/ycc/Makefile
index 78fdeed..89d6d6f 100644
--- a/drivers/crypto/ycc/Makefile
+++ b/drivers/crypto/ycc/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-(CONFIG_CRYPTO_DEV_YCC) += ycc.o
-ycc-objs := ycc_drv.o ycc_isr.o ycc_cdev.o ycc_ring.o ycc_ske.o ycc_aead.o
+ycc-objs := ycc_drv.o ycc_isr.o ycc_cdev.o ycc_ring.o ycc_ske.o ycc_aead.o ycc_pke.o
diff --git a/drivers/crypto/ycc/ycc_algs.h b/drivers/crypto/ycc/ycc_algs.h
index e3be83ec..6a13230a 100644
--- a/drivers/crypto/ycc/ycc_algs.h
+++ b/drivers/crypto/ycc/ycc_algs.h
@@ -76,6 +76,13 @@ enum ycc_cmd_id {
 	YCC_CMD_GCM_DEC,
 	YCC_CMD_CCM_ENC,
 	YCC_CMD_CCM_DEC, /* 0x28 */
+
+	YCC_CMD_RSA_ENC = 0x83,
+	YCC_CMD_RSA_DEC,
+	YCC_CMD_RSA_CRT_DEC,
+	YCC_CMD_RSA_CRT_SIGN,
+	YCC_CMD_RSA_SIGN,
+	YCC_CMD_RSA_VERIFY, /* 0x88 */
 };
 
 struct ycc_crypto_ctx {
@@ -121,10 +128,47 @@ struct ycc_crypto_req {
 	};
 };
 
+#define YCC_RSA_KEY_SZ_512	64
+#define YCC_RSA_KEY_SZ_1536	192
+#define YCC_RSA_CRT_PARAMS	5
+#define YCC_RSA_E_SZ_MAX	8
+#define YCC_CMD_DATA_ALIGN_SZ	64
+#define YCC_PIN_SZ		16
+
+struct ycc_pke_ctx {
+	struct rsa_key *rsa_key;
+
+	void *priv_key_vaddr;
+	dma_addr_t priv_key_paddr;
+	void *pub_key_vaddr;
+	dma_addr_t pub_key_paddr;
+
+	unsigned int key_len;
+	unsigned int e_len;
+	bool crt_mode;
+	struct ycc_ring *ring;
+	struct crypto_akcipher *soft_tfm;
+};
+
+struct ycc_pke_req {
+	void *src_vaddr;
+	dma_addr_t src_paddr;
+	void *dst_vaddr;
+	dma_addr_t dst_paddr;
+
+	struct ycc_cmd_desc desc;
+	union {
+		struct ycc_pke_ctx *ctx;
+	};
+	struct akcipher_request *req;
+};
+
 #define YCC_DEV(ctx)		(&(ctx)->ring->ydev->pdev->dev)
 
 int ycc_sym_register(void);
 void ycc_sym_unregister(void);
 int ycc_aead_register(void);
 void ycc_aead_unregister(void);
+int ycc_pke_register(void);
+void ycc_pke_unregister(void);
 #endif
diff --git a/drivers/crypto/ycc/ycc_drv.c b/drivers/crypto/ycc/ycc_drv.c
index 9522b42..88cfb22 100644
--- a/drivers/crypto/ycc/ycc_drv.c
+++ b/drivers/crypto/ycc/ycc_drv.c
@@ -99,8 +99,14 @@ int ycc_algorithm_register(void)
 	if (ret)
 		goto unregister_sym;
 
+	ret = ycc_pke_register();
+	if (ret)
+		goto unregister_aead;
+
 	return 0;
 
+unregister_aead:
+	ycc_aead_unregister();
 unregister_sym:
 	ycc_sym_unregister();
 err:
@@ -116,6 +122,7 @@ void ycc_algorithm_unregister(void)
 	if (atomic_dec_return(&ycc_algs_refcnt))
 		return;
 
+	ycc_pke_unregister();
 	ycc_aead_unregister();
 	ycc_sym_unregister();
 }
diff --git a/drivers/crypto/ycc/ycc_pke.c b/drivers/crypto/ycc/ycc_pke.c
new file mode 100644
index 00000000..559f7f7
--- /dev/null
+++ b/drivers/crypto/ycc/ycc_pke.c
@@ -0,0 +1,696 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "YCC: Crypto: " fmt
+
+#include <crypto/internal/akcipher.h>
+#include <crypto/internal/rsa.h>
+#include <crypto/scatterwalk.h>
+#include <linux/dma-mapping.h>
+#include <linux/crypto.h>
+#include <linux/mpi.h>
+#include "ycc_algs.h"
+
+static int ycc_rsa_done_callback(void *ptr, u16 state)
+{
+	struct ycc_pke_req *rsa_req = (struct ycc_pke_req *)ptr;
+	struct ycc_pke_ctx *ctx = rsa_req->ctx;
+	struct akcipher_request *req = rsa_req->req;
+	struct device *dev = YCC_DEV(ctx);
+	unsigned int dma_length = ctx->key_len;
+
+	if (rsa_req->desc.cmd.rsa_enc_cmd.cmd_id == YCC_CMD_RSA_VERIFY)
+		dma_length = ctx->key_len << 1;
+
+	/* For signature verify, dst is NULL */
+	if (rsa_req->dst_vaddr) {
+		sg_copy_from_buffer(req->dst, sg_nents_for_len(req->dst, req->dst_len),
+				    rsa_req->dst_vaddr, req->dst_len);
+		dma_free_coherent(dev, ALIGN(ctx->key_len, 64),
+				  rsa_req->dst_vaddr, rsa_req->dst_paddr);
+	}
+	dma_free_coherent(dev, ALIGN(dma_length, 64),
+			  rsa_req->src_vaddr, rsa_req->src_paddr);
+
+	if (req->base.complete)
+		req->base.complete(&req->base, state == CMD_SUCCESS ? 0 : -EBADMSG);
+
+	return 0;
+}
+
+static int ycc_prepare_dma_buf(struct ycc_pke_req *rsa_req, int is_src)
+{
+	struct ycc_pke_ctx *ctx = rsa_req->ctx;
+	struct akcipher_request *req = rsa_req->req;
+	struct device *dev = YCC_DEV(ctx);
+	unsigned int dma_length = ctx->key_len;
+	dma_addr_t tmp;
+	void *ptr;
+	int shift;
+
+	/*
+	 * Ycc requires 2 key_len blocks, the first block stores
+	 * message pre-padding with 0, the second block stores signature.
+	 * LCKF akcipher verify, the first sg contains signature and
+	 * the second contains message while src_len is signature
+	 * length, dst len is message length
+	 */
+	if (rsa_req->desc.cmd.rsa_enc_cmd.cmd_id == YCC_CMD_RSA_VERIFY) {
+		dma_length = ctx->key_len << 1;
+		shift = ctx->key_len - req->dst_len;
+	} else {
+		shift = ctx->key_len - req->src_len;
+	}
+
+	if (unlikely(shift < 0))
+		return -EINVAL;
+
+	ptr = dma_alloc_coherent(dev, ALIGN(dma_length, 64), &tmp, GFP_ATOMIC);
+	if (unlikely(!ptr)) {
+		pr_err("Failed to alloc dma for %s data\n", is_src ? "src" : "dst");
+		return -ENOMEM;
+	}
+
+	memset(ptr, 0, ALIGN(dma_length, 64));
+	if (is_src) {
+		if (rsa_req->desc.cmd.rsa_enc_cmd.cmd_id ==
+		    YCC_CMD_RSA_VERIFY) {
+			/* Copy msg first with prepadding 0 */
+			sg_copy_buffer(req->src, sg_nents(req->src), ptr + shift,
+				       req->dst_len, req->src_len, 1);
+			/* Copy signature */
+			sg_copy_buffer(req->src, sg_nents(req->src), ptr + ctx->key_len,
+				       req->src_len, 0, 1);
+		} else {
+			sg_copy_buffer(req->src, sg_nents(req->src), ptr + shift,
+				       req->src_len, 0, 1);
+		}
+		rsa_req->src_vaddr = ptr;
+		rsa_req->src_paddr = tmp;
+	} else {
+		rsa_req->dst_vaddr = ptr;
+		rsa_req->dst_paddr = tmp;
+	}
+
+	return 0;
+}
+
+/*
+ * Using public key to encrypt or verify
+ */
+static int ycc_rsa_submit_pub(struct akcipher_request *req, bool is_enc)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct ycc_pke_req *rsa_req = akcipher_request_ctx(req);
+	struct ycc_pke_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct ycc_rsa_enc_cmd *rsa_enc_cmd;
+	struct ycc_ring *ring = ctx->ring;
+	struct device *dev = YCC_DEV(ctx);
+	struct ycc_flags *aflags;
+	int ret = -ENOMEM;
+
+	if (req->dst_len > ctx->key_len || req->src_len > ctx->key_len)
+		return -EINVAL;
+
+	rsa_req->ctx = ctx;
+	rsa_req->req = req;
+
+	if (unlikely(!ctx->pub_key_vaddr))
+		return -EINVAL;
+
+	aflags = kzalloc(sizeof(struct ycc_flags), GFP_ATOMIC);
+	if (!aflags)
+		goto out;
+
+	aflags->ptr = (void *)rsa_req;
+	aflags->ycc_done_callback = ycc_rsa_done_callback;
+
+	memset(&rsa_req->desc, 0, sizeof(rsa_req->desc));
+	rsa_req->desc.private_ptr = (u64)(void *)aflags;
+
+	rsa_enc_cmd         = &rsa_req->desc.cmd.rsa_enc_cmd;
+	rsa_enc_cmd->cmd_id = is_enc ? YCC_CMD_RSA_ENC : YCC_CMD_RSA_VERIFY;
+	rsa_enc_cmd->keyptr = ctx->pub_key_paddr;
+	rsa_enc_cmd->elen   = ctx->e_len << 3;
+	rsa_enc_cmd->nlen   = ctx->key_len << 3;
+
+	ret = ycc_prepare_dma_buf(rsa_req, 1);
+	if (unlikely(ret))
+		goto free_aflags;
+
+	rsa_enc_cmd->sptr = rsa_req->src_paddr;
+	if (is_enc) {
+		ret = ycc_prepare_dma_buf(rsa_req, 0);
+		if (unlikely(ret))
+			goto free_src;
+
+		rsa_enc_cmd->dptr = rsa_req->dst_paddr;
+	} else {
+		rsa_req->dst_vaddr = NULL;
+	}
+
+	ret = ycc_enqueue(ring, (u8 *)&rsa_req->desc);
+	if (!ret)
+		return -EINPROGRESS;
+
+	if (rsa_req->dst_vaddr)
+		dma_free_coherent(dev, ALIGN(ctx->key_len, 64),
+				  rsa_req->dst_vaddr, rsa_req->dst_paddr);
+
+free_src:
+	dma_free_coherent(dev, ALIGN(is_enc ? ctx->key_len : ctx->key_len << 1, 64),
+			  rsa_req->src_vaddr, rsa_req->src_paddr);
+free_aflags:
+	kfree(aflags);
+out:
+	return ret;
+}
+
+/*
+ * Using private key to decrypt or signature
+ */
+static int ycc_rsa_submit_priv(struct akcipher_request *req, bool is_dec)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct ycc_pke_req *rsa_req = akcipher_request_ctx(req);
+	struct ycc_pke_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct ycc_rsa_dec_cmd *rsa_dec_cmd;
+	struct ycc_ring *ring = ctx->ring;
+	struct device *dev = YCC_DEV(ctx);
+	struct ycc_flags *aflags;
+	int ret = -ENOMEM;
+
+	if (req->dst_len > ctx->key_len || req->src_len > ctx->key_len)
+		return -EINVAL;
+
+	rsa_req->ctx = ctx;
+	rsa_req->req = req;
+
+	if (unlikely(!ctx->priv_key_vaddr))
+		return -EINVAL;
+
+	aflags = kzalloc(sizeof(struct ycc_flags), GFP_ATOMIC);
+	if (!aflags)
+		goto out;
+
+	aflags->ptr = (void *)rsa_req;
+	aflags->ycc_done_callback = ycc_rsa_done_callback;
+
+	memset(&rsa_req->desc, 0, sizeof(rsa_req->desc));
+	rsa_req->desc.private_ptr = (u64)(void *)aflags;
+
+	rsa_dec_cmd         = &rsa_req->desc.cmd.rsa_dec_cmd;
+	rsa_dec_cmd->keyptr = ctx->priv_key_paddr;
+	rsa_dec_cmd->elen   = ctx->e_len << 3;
+	rsa_dec_cmd->nlen   = ctx->key_len << 3;
+	if (ctx->crt_mode)
+		rsa_dec_cmd->cmd_id = is_dec ? YCC_CMD_RSA_CRT_DEC : YCC_CMD_RSA_CRT_SIGN;
+	else
+		rsa_dec_cmd->cmd_id = is_dec ? YCC_CMD_RSA_DEC : YCC_CMD_RSA_SIGN;
+
+	ret = ycc_prepare_dma_buf(rsa_req, 1);
+	if (unlikely(ret))
+		goto free_aflags;
+
+	ret = ycc_prepare_dma_buf(rsa_req, 0);
+	if (unlikely(ret))
+		goto free_src;
+
+	rsa_dec_cmd->sptr = rsa_req->src_paddr;
+	rsa_dec_cmd->dptr = rsa_req->dst_paddr;
+
+	ret = ycc_enqueue(ring, (u8 *)&rsa_req->desc);
+	if (!ret)
+		return -EINPROGRESS;
+
+	dma_free_coherent(dev, ALIGN(ctx->key_len, 64), rsa_req->dst_vaddr,
+			  rsa_req->dst_paddr);
+free_src:
+	dma_free_coherent(dev, ALIGN(ctx->key_len, 64), rsa_req->src_vaddr,
+			  rsa_req->src_paddr);
+free_aflags:
+	kfree(aflags);
+out:
+	return ret;
+}
+
+static inline bool ycc_rsa_do_soft(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct ycc_pke_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct ycc_dev *ydev = ctx->ring->ydev;
+
+	if (ctx->key_len == YCC_RSA_KEY_SZ_512 ||
+	    ctx->key_len == YCC_RSA_KEY_SZ_1536 ||
+	    !test_bit(YDEV_STATUS_READY, &ydev->status))
+		return true;
+
+	return false;
+}
+
+enum rsa_ops {
+	RSA_ENC,
+	RSA_DEC,
+	RSA_SIGN,
+	RSA_VERIFY,
+};
+
+static inline int ycc_rsa_soft_fallback(struct akcipher_request *req, int ops)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct ycc_pke_ctx *ctx = akcipher_tfm_ctx(tfm);
+	int ret = -EINVAL;
+
+	akcipher_request_set_tfm(req, ctx->soft_tfm);
+
+	switch (ops) {
+	case RSA_ENC:
+		ret = crypto_akcipher_encrypt(req);
+		break;
+	case RSA_DEC:
+		ret = crypto_akcipher_decrypt(req);
+		break;
+	case RSA_SIGN:
+		ret = crypto_akcipher_sign(req);
+		break;
+	case RSA_VERIFY:
+		ret = crypto_akcipher_verify(req);
+		break;
+	default:
+		break;
+	}
+
+	akcipher_request_set_tfm(req, tfm);
+	return ret;
+}
+
+static int ycc_rsa_encrypt(struct akcipher_request *req)
+{
+	if (ycc_rsa_do_soft(req))
+		return ycc_rsa_soft_fallback(req, RSA_ENC);
+
+	return ycc_rsa_submit_pub(req, true);
+}
+
+static int ycc_rsa_decrypt(struct akcipher_request *req)
+{
+	if (ycc_rsa_do_soft(req))
+		return ycc_rsa_soft_fallback(req, RSA_DEC);
+
+	return ycc_rsa_submit_priv(req, true);
+}
+
+static int ycc_rsa_verify(struct akcipher_request *req)
+{
+	if (ycc_rsa_do_soft(req))
+		return ycc_rsa_soft_fallback(req, RSA_VERIFY);
+
+	return ycc_rsa_submit_pub(req, false);
+}
+
+static int ycc_rsa_sign(struct akcipher_request *req)
+{
+	if (ycc_rsa_do_soft(req))
+		return ycc_rsa_soft_fallback(req, RSA_SIGN);
+
+	return ycc_rsa_submit_priv(req, false);
+}
+
+static int ycc_rsa_validate_n(unsigned int len)
+{
+	unsigned int bitslen = len << 3;
+
+	switch (bitslen) {
+	case 512:
+	case 1024:
+	case 1536:
+	case 2048:
+	case 3072:
+	case 4096:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static void __ycc_rsa_drop_leading_zeros(const u8 **ptr, size_t *len)
+{
+	if (!*ptr)
+		return;
+
+	while (!**ptr && *len) {
+		(*ptr)++;
+		(*len)--;
+	}
+}
+
+static int ycc_rsa_set_n(struct ycc_pke_ctx *ctx, const char *value,
+			 size_t value_len, bool private)
+{
+	const char *ptr = value;
+
+	/* e should be set before n as we need e_len */
+	if (!ctx->e_len || !value_len)
+		return -EINVAL;
+
+	if (!ctx->key_len)
+		ctx->key_len = value_len;
+
+	if (private && !ctx->crt_mode)
+		memcpy(ctx->priv_key_vaddr + ctx->e_len + YCC_PIN_SZ +
+		       ctx->rsa_key->d_sz, ptr, value_len);
+
+	memcpy(ctx->pub_key_vaddr + ctx->e_len, ptr, value_len);
+	return 0;
+}
+
+static int ycc_rsa_set_e(struct ycc_pke_ctx *ctx, const char *value,
+			 size_t value_len, bool private)
+{
+	const char *ptr = value;
+
+	if (!ctx->key_len || !value_len || value_len > YCC_RSA_E_SZ_MAX)
+		return -EINVAL;
+
+	ctx->e_len = value_len;
+	if (private)
+		memcpy(ctx->priv_key_vaddr, ptr, value_len);
+
+	memcpy(ctx->pub_key_vaddr, ptr, value_len);
+	return 0;
+}
+
+static int ycc_rsa_set_d(struct ycc_pke_ctx *ctx, const char *value,
+			 size_t value_len)
+{
+	const char *ptr = value;
+
+	if (!ctx->key_len || !value_len || value_len > ctx->key_len)
+		return -EINVAL;
+
+	memcpy(ctx->priv_key_vaddr + ctx->e_len + YCC_PIN_SZ, ptr, value_len);
+	return 0;
+}
+
+static int ycc_rsa_set_crt_param(char *param, size_t half_key_len,
+				 const char *value, size_t value_len)
+{
+	const char *ptr = value;
+	size_t len = value_len;
+
+	if (!len || len > half_key_len)
+		return -EINVAL;
+
+	memcpy(param, ptr, len);
+	return 0;
+}
+
+static int ycc_rsa_setkey_crt(struct ycc_pke_ctx *ctx, struct rsa_key *rsa_key)
+{
+	unsigned int half_key_len = ctx->key_len >> 1;
+	u8 *tmp = (u8 *)ctx->priv_key_vaddr;
+	int ret;
+
+	tmp += ctx->rsa_key->e_sz + 16;
+	/* TODO: rsa_key is better to be kept original */
+	ret = ycc_rsa_set_crt_param(tmp, half_key_len, rsa_key->p, rsa_key->p_sz);
+	if (ret)
+		goto err;
+
+	tmp += half_key_len;
+	ret = ycc_rsa_set_crt_param(tmp, half_key_len, rsa_key->q, rsa_key->q_sz);
+	if (ret)
+		goto err;
+
+	tmp += half_key_len;
+	ret = ycc_rsa_set_crt_param(tmp, half_key_len, rsa_key->dp, rsa_key->dp_sz);
+	if (ret)
+		goto err;
+
+	tmp += half_key_len;
+	ret = ycc_rsa_set_crt_param(tmp, half_key_len, rsa_key->dq, rsa_key->dq_sz);
+	if (ret)
+		goto err;
+
+	tmp += half_key_len;
+	ret = ycc_rsa_set_crt_param(tmp, half_key_len, rsa_key->qinv, rsa_key->qinv_sz);
+	if (ret)
+		goto err;
+
+	ctx->crt_mode = true;
+	return 0;
+
+err:
+	ctx->crt_mode = false;
+	return ret;
+}
+
+static void ycc_rsa_clear_ctx(struct ycc_pke_ctx *ctx)
+{
+	struct device *dev = YCC_DEV(ctx);
+	size_t size;
+
+	if (ctx->pub_key_vaddr) {
+		size = ALIGN(ctx->rsa_key->e_sz + ctx->key_len, YCC_CMD_DATA_ALIGN_SZ);
+		dma_free_coherent(dev, size, ctx->pub_key_vaddr, ctx->pub_key_paddr);
+		ctx->pub_key_vaddr = NULL;
+	}
+
+	if (ctx->priv_key_vaddr) {
+		size = ALIGN(ctx->rsa_key->e_sz + YCC_PIN_SZ + ctx->rsa_key->d_sz +
+			     ctx->key_len, YCC_CMD_DATA_ALIGN_SZ);
+		memzero_explicit(ctx->priv_key_vaddr, size);
+		dma_free_coherent(dev, size, ctx->priv_key_vaddr, ctx->priv_key_paddr);
+		ctx->priv_key_vaddr = NULL;
+	}
+
+	if (ctx->rsa_key) {
+		memzero_explicit(ctx->rsa_key, sizeof(struct rsa_key));
+		kfree(ctx->rsa_key);
+		ctx->rsa_key = NULL;
+	}
+
+	ctx->key_len = 0;
+	ctx->e_len = 0;
+	ctx->crt_mode = false;
+}
+
+static void ycc_rsa_drop_leading_zeros(struct rsa_key *rsa_key)
+{
+	__ycc_rsa_drop_leading_zeros(&rsa_key->n, &rsa_key->n_sz);
+	__ycc_rsa_drop_leading_zeros(&rsa_key->e, &rsa_key->e_sz);
+	__ycc_rsa_drop_leading_zeros(&rsa_key->d, &rsa_key->d_sz);
+	__ycc_rsa_drop_leading_zeros(&rsa_key->p, &rsa_key->p_sz);
+	__ycc_rsa_drop_leading_zeros(&rsa_key->q, &rsa_key->q_sz);
+	__ycc_rsa_drop_leading_zeros(&rsa_key->dp, &rsa_key->dp_sz);
+	__ycc_rsa_drop_leading_zeros(&rsa_key->dq, &rsa_key->dq_sz);
+	__ycc_rsa_drop_leading_zeros(&rsa_key->qinv, &rsa_key->qinv_sz);
+}
+
+static int ycc_rsa_alloc_key(struct ycc_pke_ctx *ctx, bool priv)
+{
+	struct device *dev = YCC_DEV(ctx);
+	struct rsa_key *rsa_key = ctx->rsa_key;
+	unsigned int half_key_len;
+	size_t size;
+	int ret;
+
+	ycc_rsa_drop_leading_zeros(rsa_key);
+	ctx->key_len = rsa_key->n_sz;
+
+	ret = ycc_rsa_validate_n(ctx->key_len);
+	if (ret) {
+		pr_err("Invalid n size:%d bits\n", ctx->key_len << 3);
+		goto out;
+	}
+
+	ret = -ENOMEM;
+	if (priv) {
+		if (!(rsa_key->p_sz + rsa_key->q_sz + rsa_key->dp_sz +
+		      rsa_key->dq_sz + rsa_key->qinv_sz)) {
+			size = ALIGN(rsa_key->e_sz + YCC_PIN_SZ + rsa_key->d_sz +
+				     ctx->key_len, YCC_CMD_DATA_ALIGN_SZ);
+		} else {
+			half_key_len = ctx->key_len >> 1;
+			size = ALIGN(rsa_key->e_sz + YCC_PIN_SZ + half_key_len *
+				     YCC_RSA_CRT_PARAMS, YCC_CMD_DATA_ALIGN_SZ);
+			ctx->crt_mode = true;
+		}
+		ctx->priv_key_vaddr = dma_alloc_coherent(dev, size,
+							 &ctx->priv_key_paddr,
+							 GFP_KERNEL);
+		if (!ctx->priv_key_vaddr)
+			goto out;
+		memset(ctx->priv_key_vaddr, 0, size);
+	}
+
+	if (!ctx->pub_key_vaddr) {
+		size = ALIGN(ctx->key_len + rsa_key->e_sz, YCC_CMD_DATA_ALIGN_SZ);
+		ctx->pub_key_vaddr = dma_alloc_coherent(dev, size,
+							&ctx->pub_key_paddr,
+							GFP_KERNEL);
+		if (!ctx->pub_key_vaddr)
+			goto out;
+		memset(ctx->pub_key_vaddr, 0, size);
+	}
+
+	ret = ycc_rsa_set_e(ctx, rsa_key->e, rsa_key->e_sz, priv);
+	if (ret) {
+		pr_err("Failed to set e for rsa %s key\n", priv ? "private" : "public");
+		goto out;
+	}
+
+	ret = ycc_rsa_set_n(ctx, rsa_key->n, rsa_key->n_sz, priv);
+	if (ret) {
+		pr_err("Failed to set n for rsa private key\n");
+		goto out;
+	}
+
+	if (priv) {
+		if (ctx->crt_mode) {
+			ret = ycc_rsa_setkey_crt(ctx, rsa_key);
+			if (ret) {
+				pr_err("Failed to set private key for rsa crt key\n");
+				goto out;
+			}
+		} else {
+			ret = ycc_rsa_set_d(ctx, rsa_key->d, rsa_key->d_sz);
+			if (ret) {
+				pr_err("Failed to set d for rsa private key\n");
+				goto out;
+			}
+		}
+	}
+
+	return 0;
+
+out:
+	ycc_rsa_clear_ctx(ctx);
+	return ret;
+}
+
+static int ycc_rsa_setkey(struct crypto_akcipher *tfm, const void *key,
+			  unsigned int keylen, bool priv)
+{
+	struct ycc_pke_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct rsa_key *rsa_key;
+	int ret;
+
+	if (priv)
+		ret = crypto_akcipher_set_priv_key(ctx->soft_tfm, key, keylen);
+	else
+		ret = crypto_akcipher_set_pub_key(ctx->soft_tfm, key, keylen);
+	if (ret)
+		return ret;
+
+	ycc_rsa_clear_ctx(ctx);
+
+	rsa_key = kzalloc(sizeof(struct rsa_key), GFP_KERNEL);
+	if (!rsa_key)
+		return -ENOMEM;
+
+	if (priv)
+		ret = rsa_parse_priv_key(rsa_key, key, keylen);
+	else if (!ctx->pub_key_vaddr)
+		ret = rsa_parse_pub_key(rsa_key, key, keylen);
+	if (ret) {
+		pr_err("Failed to parse %s key\n", priv ? "private" : "public");
+		kfree(rsa_key);
+		return ret;
+	}
+
+	ctx->rsa_key = rsa_key;
+	return ycc_rsa_alloc_key(ctx, priv);
+}
+
+static int ycc_rsa_setpubkey(struct crypto_akcipher *tfm, const void *key,
+			     unsigned int keylen)
+{
+	return ycc_rsa_setkey(tfm, key, keylen, false);
+}
+
+static int ycc_rsa_setprivkey(struct crypto_akcipher *tfm, const void *key,
+			      unsigned int keylen)
+{
+	return ycc_rsa_setkey(tfm, key, keylen, true);
+}
+
+static unsigned int ycc_rsa_max_size(struct crypto_akcipher *tfm)
+{
+	struct ycc_pke_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	/*
+	 * 512 and 1536 bits key size are not supported by YCC,
+	 * we use soft tfm instead
+	 */
+	if (ctx->key_len == YCC_RSA_KEY_SZ_512 ||
+	    ctx->key_len == YCC_RSA_KEY_SZ_1536)
+		return crypto_akcipher_maxsize(ctx->soft_tfm);
+
+	return ctx->rsa_key ? ctx->key_len : 0;
+}
+
+static int ycc_rsa_init(struct crypto_akcipher *tfm)
+{
+	struct ycc_pke_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct ycc_ring *ring;
+
+	ctx->soft_tfm = crypto_alloc_akcipher("rsa-generic", 0, 0);
+	if (IS_ERR(ctx->soft_tfm)) {
+		pr_err("Can not alloc_akcipher!\n");
+		return PTR_ERR(ctx->soft_tfm);
+	}
+
+	/* Reserve enough space if soft request reqires additional space */
+	akcipher_set_reqsize(tfm, sizeof(struct ycc_pke_req) +
+			     crypto_akcipher_alg(ctx->soft_tfm)->reqsize);
+
+	ring = ycc_crypto_get_ring();
+	if (!ring) {
+		crypto_free_akcipher(ctx->soft_tfm);
+		return -EINVAL;
+	}
+
+	ctx->ring = ring;
+	ctx->key_len = 0;
+	return 0;
+}
+
+static void ycc_rsa_exit(struct crypto_akcipher *tfm)
+{
+	struct ycc_pke_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	if (ctx->ring)
+		ycc_crypto_free_ring(ctx->ring);
+
+	ycc_rsa_clear_ctx(ctx);
+	crypto_free_akcipher(ctx->soft_tfm);
+}
+
+static struct akcipher_alg ycc_rsa = {
+	.base = {
+		.cra_name = "rsa",
+		.cra_driver_name = "ycc-rsa",
+		.cra_priority = 1000,
+		.cra_module = THIS_MODULE,
+		.cra_ctxsize = sizeof(struct ycc_pke_ctx),
+	},
+	.sign = ycc_rsa_sign,
+	.verify = ycc_rsa_verify,
+	.encrypt = ycc_rsa_encrypt,
+	.decrypt = ycc_rsa_decrypt,
+	.set_pub_key = ycc_rsa_setpubkey,
+	.set_priv_key = ycc_rsa_setprivkey,
+	.max_size = ycc_rsa_max_size,
+	.init = ycc_rsa_init,
+	.exit = ycc_rsa_exit,
+};
+
+int ycc_pke_register(void)
+{
+	return crypto_register_akcipher(&ycc_rsa);
+}
+
+void ycc_pke_unregister(void)
+{
+	crypto_unregister_akcipher(&ycc_rsa);
+}
diff --git a/drivers/crypto/ycc/ycc_ring.h b/drivers/crypto/ycc/ycc_ring.h
index 2caa9e0..c47fc18 100644
--- a/drivers/crypto/ycc/ycc_ring.h
+++ b/drivers/crypto/ycc/ycc_ring.h
@@ -100,9 +100,32 @@ struct ycc_aead_cmd {
 	u8 taglen;	/* authenc size */
 } __packed;
 
+struct ycc_rsa_enc_cmd {
+	u8 cmd_id;
+	u64 sptr:48;
+	u16 key_id;
+	u64 keyptr:48;	/* public key e+n Bytes */
+	u16 elen;	/* bits not byte */
+	u16 nlen;
+	u64 dptr:48;
+} __packed;
+
+struct ycc_rsa_dec_cmd {
+	u8 cmd_id;
+	u64 sptr:48;
+	u16 key_id;
+	u16 kek_id;
+	u64 keyptr:48;	/* private key e + pin + d + n */
+	u16 elen;	/* bits not byte */
+	u16 nlen;
+	u64 dptr:48;
+} __packed;
+
 union ycc_real_cmd {
 	struct ycc_skcipher_cmd ske_cmd;
 	struct ycc_aead_cmd aead_cmd;
+	struct ycc_rsa_enc_cmd rsa_enc_cmd;
+	struct ycc_rsa_dec_cmd rsa_dec_cmd;
 	u8 padding[32];
 };
 
-- 
1.8.3.1

