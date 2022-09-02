Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EF45AA777
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiIBGAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiIBGA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:00:28 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D607A3121E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:00:25 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2825eWm4091015;
        Fri, 2 Sep 2022 13:40:32 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 2 Sep
 2022 14:00:15 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "Joel Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Chia-Wei Wang --cc=linux-kernel @ vger . kernel . org" 
        <chiawei_wang@aspeedtech.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: [PATCH v1 1/4] crypto: aspeed: Add ACRY RSA driver
Date:   Fri, 2 Sep 2022 14:00:09 +0800
Message-ID: <20220902060012.3758637-2-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902060012.3758637-1-neal_liu@aspeedtech.com>
References: <20220902060012.3758637-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2825eWm4091015
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACRY Engine is designed to accelerate the throughput of
ECDSA/RSA signature and verification.

This patch aims to add ACRY RSA engine driver for hardware
acceleration.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 drivers/crypto/aspeed/Kconfig       |  11 +
 drivers/crypto/aspeed/Makefile      |   5 +-
 drivers/crypto/aspeed/aspeed-acry.c | 848 ++++++++++++++++++++++++++++
 3 files changed, 863 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/aspeed/aspeed-acry.c

diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
index 001bf2e09a72..d0d88196ccc1 100644
--- a/drivers/crypto/aspeed/Kconfig
+++ b/drivers/crypto/aspeed/Kconfig
@@ -47,3 +47,14 @@ config CRYPTO_DEV_ASPEED_HACE_CRYPTO
 	  crypto driver.
 	  Supports AES/DES symmetric-key encryption and decryption
 	  with ECB/CBC/CFB/OFB/CTR options.
+
+config CRYPTO_DEV_ASPEED_ACRY
+	bool "Enable Aspeed ACRY RSA Engine"
+	depends on CRYPTO_DEV_ASPEED
+	select CRYPTO_ENGINE
+	select CRYPTO_RSA
+	help
+	  Select here to enable Aspeed ECC/RSA Engine (ACRY)
+	  RSA driver.
+	  Supports 256 bits to 4096 bits RSA encryption/decryption
+	  and signature/verification.
diff --git a/drivers/crypto/aspeed/Makefile b/drivers/crypto/aspeed/Makefile
index 4cc1a7ad3652..8a2a8c905860 100644
--- a/drivers/crypto/aspeed/Makefile
+++ b/drivers/crypto/aspeed/Makefile
@@ -2,8 +2,11 @@ obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) += aspeed-hace-hash.o
 hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) := aspeed-hace-hash.o
 obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) += aspeed-hace-crypto.o
 hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) := aspeed-hace-crypto.o
+obj-$(CONFIG_CRYPTO_DEV_ASPEED_ACRY) += aspeed-acry.o
+hace-crypto-$(CONFIG_CRYPTO_DEV_ACRY) := aspeed-acry.o
 
 obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
 aspeed_crypto-objs := aspeed-hace.o	\
 		      $(hace-hash-y)	\
-		      $(hace-crypto-y)
+		      $(hace-crypto-y)	\
+		      $(acry-y)
diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
new file mode 100644
index 000000000000..1d9a9b71afca
--- /dev/null
+++ b/drivers/crypto/aspeed/aspeed-acry.c
@@ -0,0 +1,848 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021 Aspeed Technology Inc.
+ */
+#include <crypto/akcipher.h>
+#include <crypto/algapi.h>
+#include <crypto/engine.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/internal/rsa.h>
+#include <crypto/scatterwalk.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/interrupt.h>
+#include <linux/count_zeros.h>
+#include <linux/err.h>
+#include <linux/dma-mapping.h>
+#include <linux/regmap.h>
+
+#ifdef CONFIG_CRYPTO_DEV_ASPEED_DEBUG
+#define ACRY_DBG(d, fmt, ...)	\
+	dev_info((d)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
+#else
+#define ACRY_DBG(d, fmt, ...)	\
+	dev_dbg((d)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
+#endif
+
+/*****************************
+ *                           *
+ * ACRY register definitions *
+ *                           *
+ * ***************************/
+#define ASPEED_ACRY_TRIGGER		0x000	/* ACRY Engine Control: trigger */
+#define ASPEED_ACRY_DMA_CMD		0x048	/* ACRY Engine Control: Command */
+#define ASPEED_ACRY_DMA_SRC_BASE	0x04C	/* ACRY DRAM base address for DMA */
+#define ASPEED_ACRY_DMA_LEN		0x050	/* ACRY Data Length of DMA */
+#define ASPEED_ACRY_RSA_KEY_LEN		0x058	/* ACRY RSA Exp/Mod Key Length (Bits) */
+#define ASPEED_ACRY_INT_MASK		0x3F8	/* ACRY Interrupt Mask */
+#define ASPEED_ACRY_STATUS		0x3FC	/* ACRY Interrupt Status */
+
+/* rsa trigger */
+#define  ACRY_CMD_RSA_TRIGGER		BIT(0)
+#define  ACRY_CMD_DMA_RSA_TRIGGER	BIT(1)
+
+/* rsa dma cmd */
+#define  ACRY_CMD_DMA_SRAM_MODE_RSA	(0x3 << 4)
+#define  ACRY_CMD_DMEM_AHB		BIT(8)
+#define  ACRY_CMD_DMA_SRAM_AHB_ENGINE	0
+
+/* rsa key len */
+#define  RSA_E_BITS_LEN(x)		(x << 16)
+#define  RSA_M_BITS_LEN(x)		(x)
+
+/* acry isr */
+#define  ACRY_RSA_ISR			BIT(1)
+
+#define ASPEED_ACRY_BUFF_SIZE		0x1800	/* DMA buffer size */
+#define ASPEED_ACRY_SRAM_MAX_LEN	2048	/* ACRY SRAM maximum length (Bytes) */
+#define ASPEED_ACRY_RSA_MAX_KEY_LEN	512	/* ACRY RSA maximum key length (Bytes) */
+
+#define CRYPTO_FLAGS_BUSY		BIT(1)
+#define BYTES_PER_DWORD			4
+
+/*****************************
+ *                           *
+ * AHBC register definitions *
+ *                           *
+ * ***************************/
+#define AHBC_REGION_PROT		0x240
+#define REGION_ACRYM			BIT(23)
+
+#define ast_acry_write(acry, val, offset)	\
+	writel((val), (acry)->regs + (offset))
+
+#define ast_acry_read(acry, offset)		\
+	readl((acry)->regs + (offset))
+
+struct aspeed_acry_dev;
+
+typedef int (*aspeed_acry_fn_t)(struct aspeed_acry_dev *);
+
+struct aspeed_acry_dev {
+	void __iomem			*regs;
+	struct device			*dev;
+	int				irq;
+	struct clk			*clk;
+	struct regmap			*ahbc;
+
+	struct akcipher_request		*req;
+	struct tasklet_struct		done_task;
+	aspeed_acry_fn_t		resume;
+	unsigned long			flags;
+
+	/* ACRY output SRAM buffer */
+	void __iomem			*acry_sram;
+
+	/* ACRY input DMA buffer */
+	void				*buf_addr;
+	dma_addr_t			buf_dma_addr;
+
+	struct crypto_engine		*crypt_engine_rsa;
+
+	/* ACRY SRAM memory mapped */
+	int				exp_dw_mapping[ASPEED_ACRY_RSA_MAX_KEY_LEN];
+	int				mod_dw_mapping[ASPEED_ACRY_RSA_MAX_KEY_LEN];
+	int				data_byte_mapping[ASPEED_ACRY_SRAM_MAX_LEN];
+};
+
+struct aspeed_acry_ctx {
+	struct crypto_engine_ctx	enginectx;
+	struct aspeed_acry_dev		*acry_dev;
+
+	struct rsa_key			key;
+	int				enc;
+	u8				*n;
+	u8				*e;
+	u8				*d;
+	size_t				n_sz;
+	size_t				e_sz;
+	size_t				d_sz;
+
+	aspeed_acry_fn_t		trigger;
+
+	struct crypto_akcipher          *fallback_tfm;
+};
+
+struct aspeed_acry_alg {
+	struct aspeed_acry_dev		*acry_dev;
+	struct akcipher_alg		akcipher;
+};
+
+enum aspeed_rsa_key_mode {
+	ASPEED_RSA_EXP_MODE = 0,
+	ASPEED_RSA_MOD_MODE,
+	ASPEED_RSA_DATA_MODE,
+};
+
+static inline struct akcipher_request *akcipher_request_cast(
+		struct crypto_async_request *req)
+{
+	return container_of(req, struct akcipher_request, base);
+}
+
+static int aspeed_acry_do_fallback(struct akcipher_request *req)
+{
+	struct crypto_akcipher *cipher = crypto_akcipher_reqtfm(req);
+	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(cipher);
+	int err;
+
+	akcipher_request_set_tfm(req, ctx->fallback_tfm);
+
+	if (ctx->enc)
+		err = crypto_akcipher_encrypt(req);
+	else
+		err = crypto_akcipher_decrypt(req);
+
+	akcipher_request_set_tfm(req, cipher);
+
+	return err;
+}
+
+static bool aspeed_acry_need_fallback(struct akcipher_request *req)
+{
+	struct crypto_akcipher *cipher = crypto_akcipher_reqtfm(req);
+	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(cipher);
+
+	if (ctx->key.n_sz > ASPEED_ACRY_RSA_MAX_KEY_LEN)
+		return true;
+
+	return false;
+}
+
+static int aspeed_acry_handle_queue(struct aspeed_acry_dev *acry_dev,
+				    struct akcipher_request *req)
+{
+	if (aspeed_acry_need_fallback(req)) {
+		ACRY_DBG(acry_dev, "SW fallback\n");
+		return aspeed_acry_do_fallback(req);
+	}
+
+	return crypto_transfer_akcipher_request_to_engine(
+			acry_dev->crypt_engine_rsa, req);
+}
+
+static int aspeed_acry_do_request(struct crypto_engine *engine, void *areq)
+{
+	struct akcipher_request *req = akcipher_request_cast(areq);
+	struct crypto_akcipher *cipher = crypto_akcipher_reqtfm(req);
+	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(cipher);
+	struct aspeed_acry_dev *acry_dev = ctx->acry_dev;
+	int rc;
+
+	acry_dev->req = req;
+	acry_dev->flags |= CRYPTO_FLAGS_BUSY;
+	rc = ctx->trigger(acry_dev);
+
+	if (rc != -EINPROGRESS)
+		return -EIO;
+
+	return 0;
+}
+
+static int aspeed_acry_complete(struct aspeed_acry_dev *acry_dev, int err)
+{
+	struct akcipher_request *req = acry_dev->req;
+
+	acry_dev->flags &= ~CRYPTO_FLAGS_BUSY;
+
+	crypto_finalize_akcipher_request(acry_dev->crypt_engine_rsa, req, err);
+
+	return err;
+}
+
+/*
+ * Copy Data to DMA buffer for engine used.
+ */
+static void aspeed_acry_rsa_sg_copy_to_buffer(struct aspeed_acry_dev *acry_dev,
+					      u8 *buf, struct scatterlist *src,
+					      size_t nbytes)
+{
+	static u8 dram_buffer[ASPEED_ACRY_SRAM_MAX_LEN];
+	int i = 0, j;
+	int data_idx;
+
+	ACRY_DBG(acry_dev, "\n");
+
+	scatterwalk_map_and_copy(dram_buffer, src, 0, nbytes, 0);
+
+	for (j = nbytes - 1; j >= 0; j--) {
+		data_idx = acry_dev->data_byte_mapping[i];
+		buf[data_idx] =  dram_buffer[j];
+		i++;
+	}
+
+	for (; i < ASPEED_ACRY_SRAM_MAX_LEN; i++) {
+		data_idx = acry_dev->data_byte_mapping[i];
+		buf[data_idx] = 0;
+	}
+}
+
+/*
+ * Copy Exp/Mod to DMA buffer for engine used.
+ *
+ * Params:
+ * - mode 0 : Exponential
+ * - mode 1 : Modulus
+ *
+ * Example:
+ * - DRAM memory layout:
+ *	D[0], D[4], D[8], D[12]
+ * - ACRY SRAM memory layout should reverse the order of source data:
+ *	D[12], D[8], D[4], D[0]
+ */
+static int aspeed_acry_rsa_ctx_copy(struct aspeed_acry_dev *acry_dev, void *buf,
+				    const void *xbuf, size_t nbytes,
+				    enum aspeed_rsa_key_mode mode)
+{
+	const uint8_t *src = xbuf;
+	u32 *dw_buf = (u32 *)buf;
+	int nbits, ndw;
+	int i, j, idx;
+	u32 data;
+
+	ACRY_DBG(acry_dev, "nbytes:0x%x, mode:%d\n", nbytes, mode);
+
+	if (nbytes > ASPEED_ACRY_RSA_MAX_KEY_LEN)
+		return -ENOMEM;
+
+	/* Remove the leading zeros */
+	while (nbytes > 0 && src[0] == 0) {
+		src++;
+		nbytes--;
+	}
+
+	nbits = nbytes * 8;
+	if (nbytes > 0)
+		nbits -= count_leading_zeros(src[0]) - (BITS_PER_LONG - 8);
+
+	/* double-world alignment */
+	ndw = DIV_ROUND_UP(nbytes, BYTES_PER_DWORD);
+
+	if (nbytes > 0) {
+		i = BYTES_PER_DWORD - nbytes % BYTES_PER_DWORD;
+		i %= BYTES_PER_DWORD;
+
+		for (j = ndw; j > 0; j--) {
+			for (; i < BYTES_PER_DWORD; i++) {
+				data <<= 8;
+				data |= *src++;
+			}
+
+			i = 0;
+
+			if (mode == ASPEED_RSA_EXP_MODE)
+				idx = acry_dev->exp_dw_mapping[j - 1];
+			else if (mode == ASPEED_RSA_MOD_MODE)
+				idx = acry_dev->mod_dw_mapping[j - 1];
+
+			dw_buf[idx] = cpu_to_le32(data);
+		}
+	}
+
+	return nbits;
+}
+
+static int aspeed_acry_rsa_transfer(struct aspeed_acry_dev *acry_dev)
+{
+	struct akcipher_request *req = acry_dev->req;
+	u8 *sram_buffer = (u8 *)acry_dev->acry_sram;
+	struct scatterlist *out_sg = req->dst;
+	static u8 dram_buffer[ASPEED_ACRY_SRAM_MAX_LEN];
+	int leading_zero = 1;
+	int result_nbytes;
+	int i = 0, j;
+	int data_idx;
+
+	/* Set Data Memory to AHB(CPU) Access Mode */
+	ast_acry_write(acry_dev, ACRY_CMD_DMEM_AHB, ASPEED_ACRY_DMA_CMD);
+
+	/* Disable ACRY SRAM protection */
+	regmap_update_bits(acry_dev->ahbc, AHBC_REGION_PROT,
+			   REGION_ACRYM, 0);
+
+	result_nbytes = ASPEED_ACRY_SRAM_MAX_LEN;
+
+	for (j = ASPEED_ACRY_SRAM_MAX_LEN - 1; j >= 0; j--) {
+		data_idx = acry_dev->data_byte_mapping[j];
+		if (sram_buffer[data_idx] == 0 && leading_zero) {
+			result_nbytes--;
+		} else {
+			leading_zero = 0;
+			dram_buffer[i] = sram_buffer[data_idx];
+			i++;
+		}
+	}
+
+	ACRY_DBG(acry_dev, "result_nbytes:%d, req->dst_len:%d\n",
+		 result_nbytes, req->dst_len);
+
+	if (result_nbytes <= req->dst_len) {
+		scatterwalk_map_and_copy(dram_buffer, out_sg, 0, result_nbytes,
+					 1);
+		req->dst_len = result_nbytes;
+
+	} else {
+		dev_err(acry_dev->dev, "RSA engine error!\n");
+	}
+
+	memzero_explicit(acry_dev->buf_addr, ASPEED_ACRY_BUFF_SIZE);
+
+	return aspeed_acry_complete(acry_dev, 0);
+}
+
+static int aspeed_acry_rsa_trigger(struct aspeed_acry_dev *acry_dev)
+{
+	struct akcipher_request *req = acry_dev->req;
+	struct crypto_akcipher *cipher = crypto_akcipher_reqtfm(req);
+	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(cipher);
+	int ne, nm;
+
+	if (!ctx->n || !ctx->n_sz) {
+		dev_err(acry_dev->dev, "%s: key n is not set\n", __func__);
+		return -EINVAL;
+	}
+
+	memzero_explicit(acry_dev->buf_addr, ASPEED_ACRY_BUFF_SIZE);
+
+	/* Copy source data to DMA buffer */
+	aspeed_acry_rsa_sg_copy_to_buffer(acry_dev, acry_dev->buf_addr,
+					  req->src, req->src_len);
+
+	nm = aspeed_acry_rsa_ctx_copy(acry_dev, acry_dev->buf_addr, ctx->n,
+				      ctx->n_sz, ASPEED_RSA_MOD_MODE);
+	if (ctx->enc) {
+		if (!ctx->e || !ctx->e_sz) {
+			dev_err(acry_dev->dev, "%s: key e is not set\n",
+				__func__);
+			return -EINVAL;
+		}
+		/* Copy key e to DMA buffer */
+		ne = aspeed_acry_rsa_ctx_copy(acry_dev, acry_dev->buf_addr,
+					      ctx->e, ctx->e_sz,
+					      ASPEED_RSA_EXP_MODE);
+	} else {
+		if (!ctx->d || !ctx->d_sz) {
+			dev_err(acry_dev->dev, "%s: key d is not set\n",
+				__func__);
+			return -EINVAL;
+		}
+		/* Copy key d to DMA buffer */
+		ne = aspeed_acry_rsa_ctx_copy(acry_dev, acry_dev->buf_addr,
+					      ctx->key.d, ctx->key.d_sz,
+					      ASPEED_RSA_EXP_MODE);
+	}
+
+	ast_acry_write(acry_dev, acry_dev->buf_dma_addr,
+			  ASPEED_ACRY_DMA_SRC_BASE);
+	ast_acry_write(acry_dev, (ne << 16) + nm,
+			  ASPEED_ACRY_RSA_KEY_LEN);
+	ast_acry_write(acry_dev, ASPEED_ACRY_BUFF_SIZE,
+			  ASPEED_ACRY_DMA_LEN);
+
+	acry_dev->resume = aspeed_acry_rsa_transfer;
+
+	/* Enable ACRY SRAM protection */
+	regmap_update_bits(acry_dev->ahbc, AHBC_REGION_PROT,
+			   REGION_ACRYM, REGION_ACRYM);
+
+	ast_acry_write(acry_dev, ACRY_RSA_ISR, ASPEED_ACRY_INT_MASK);
+	ast_acry_write(acry_dev, ACRY_CMD_DMA_SRAM_MODE_RSA |
+			  ACRY_CMD_DMA_SRAM_AHB_ENGINE, ASPEED_ACRY_DMA_CMD);
+
+	/* Trigger RSA engines */
+	ast_acry_write(acry_dev, ACRY_CMD_RSA_TRIGGER |
+			  ACRY_CMD_DMA_RSA_TRIGGER, ASPEED_ACRY_TRIGGER);
+
+	return -EINPROGRESS;
+}
+
+static int aspeed_acry_rsa_enc(struct akcipher_request *req)
+{
+	struct crypto_akcipher *cipher = crypto_akcipher_reqtfm(req);
+	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(cipher);
+	struct aspeed_acry_dev *acry_dev = ctx->acry_dev;
+
+	ctx->trigger = aspeed_acry_rsa_trigger;
+	ctx->enc = 1;
+
+	return aspeed_acry_handle_queue(acry_dev, req);
+}
+
+static int aspeed_acry_rsa_dec(struct akcipher_request *req)
+{
+	struct crypto_akcipher *cipher = crypto_akcipher_reqtfm(req);
+	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(cipher);
+	struct aspeed_acry_dev *acry_dev = ctx->acry_dev;
+
+	ctx->trigger = aspeed_acry_rsa_trigger;
+	ctx->enc = 0;
+
+	return aspeed_acry_handle_queue(acry_dev, req);
+}
+
+static u8 *aspeed_rsa_key_copy(u8 *src, size_t len)
+{
+	u8 *dst;
+
+	dst = kmemdup(src, len, GFP_DMA | GFP_KERNEL);
+	return dst;
+}
+
+static int aspeed_rsa_set_n(struct aspeed_acry_ctx *ctx, u8 *value,
+			    size_t len)
+{
+	ctx->n_sz = len;
+	ctx->n = aspeed_rsa_key_copy(value, len);
+	if (!ctx->n)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int aspeed_rsa_set_e(struct aspeed_acry_ctx *ctx, u8 *value,
+			    size_t len)
+{
+	ctx->e_sz = len;
+	ctx->e = aspeed_rsa_key_copy(value, len);
+	if (!ctx->e)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int aspeed_rsa_set_d(struct aspeed_acry_ctx *ctx, u8 *value,
+			    size_t len)
+{
+	ctx->d_sz = len;
+	ctx->d = aspeed_rsa_key_copy(value, len);
+	if (!ctx->d)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void aspeed_rsa_key_free(struct aspeed_acry_ctx *ctx)
+{
+	kfree_sensitive(ctx->n);
+	kfree_sensitive(ctx->e);
+	kfree_sensitive(ctx->d);
+	ctx->n_sz = 0;
+	ctx->e_sz = 0;
+	ctx->d_sz = 0;
+}
+
+static int aspeed_acry_rsa_setkey(struct crypto_akcipher *tfm, const void *key,
+				  unsigned int keylen, int priv)
+{
+	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct aspeed_acry_dev *acry_dev = ctx->acry_dev;
+	int ret;
+
+	if (priv)
+		ret = rsa_parse_priv_key(&ctx->key, key, keylen);
+	else
+		ret = rsa_parse_pub_key(&ctx->key, key, keylen);
+
+	if (ret) {
+		dev_err(acry_dev->dev, "rsa parse key failed, ret:0x%x\n",
+			ret);
+		return ret;
+	}
+
+	/* Aspeed engine supports up to 4096 bits,
+	 * Use software fallback instead.
+	 */
+	if (ctx->key.n_sz > ASPEED_ACRY_RSA_MAX_KEY_LEN)
+		return 0;
+
+	ret = aspeed_rsa_set_n(ctx, (u8 *)ctx->key.n, ctx->key.n_sz);
+	if (ret)
+		goto err;
+
+	ret = aspeed_rsa_set_e(ctx, (u8 *)ctx->key.e, ctx->key.e_sz);
+	if (ret)
+		goto err;
+
+	if (priv) {
+		ret = aspeed_rsa_set_d(ctx, (u8 *)ctx->key.d, ctx->key.d_sz);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	dev_err(acry_dev->dev, "rsa set key failed\n");
+	aspeed_rsa_key_free(ctx);
+
+	return ret;
+}
+
+static int aspeed_acry_rsa_set_pub_key(struct crypto_akcipher *tfm,
+				       const void *key,
+				       unsigned int keylen)
+{
+	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(tfm);
+	int ret;
+
+	ret = crypto_akcipher_set_pub_key(ctx->fallback_tfm, key, keylen);
+	if (ret)
+		return ret;
+
+	return aspeed_acry_rsa_setkey(tfm, key, keylen, 0);
+}
+
+static int aspeed_acry_rsa_set_priv_key(struct crypto_akcipher *tfm,
+					const void *key,
+					unsigned int keylen)
+{
+	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(tfm);
+	int ret;
+
+	ret = crypto_akcipher_set_priv_key(ctx->fallback_tfm, key, keylen);
+	if (ret)
+		return ret;
+
+	return aspeed_acry_rsa_setkey(tfm, key, keylen, 1);
+}
+
+static unsigned int aspeed_acry_rsa_max_size(struct crypto_akcipher *tfm)
+{
+	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	if (ctx->key.n_sz > ASPEED_ACRY_RSA_MAX_KEY_LEN)
+		return crypto_akcipher_maxsize(ctx->fallback_tfm);
+
+	return ctx->n_sz;
+}
+
+static int aspeed_acry_rsa_init_tfm(struct crypto_akcipher *tfm)
+{
+	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct akcipher_alg *alg = crypto_akcipher_alg(tfm);
+	const char *name = crypto_tfm_alg_name(&tfm->base);
+	struct aspeed_acry_alg *acry_alg;
+
+	acry_alg = container_of(alg, struct aspeed_acry_alg, akcipher);
+
+	ctx->acry_dev = acry_alg->acry_dev;
+
+	ctx->fallback_tfm = crypto_alloc_akcipher(name, 0, CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->fallback_tfm)) {
+		dev_err(ctx->acry_dev->dev, "ERROR: Cannot allocate fallback for %s %ld\n",
+			name, PTR_ERR(ctx->fallback_tfm));
+		return PTR_ERR(ctx->fallback_tfm);
+	}
+
+	ctx->enginectx.op.do_one_request = aspeed_acry_do_request;
+	ctx->enginectx.op.prepare_request = NULL;
+	ctx->enginectx.op.unprepare_request = NULL;
+
+	return 0;
+}
+
+static void aspeed_acry_rsa_exit_tfm(struct crypto_akcipher *tfm)
+{
+	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	crypto_free_akcipher(ctx->fallback_tfm);
+}
+
+struct aspeed_acry_alg aspeed_acry_akcipher_algs[] = {
+	{
+		.akcipher = {
+			.encrypt = aspeed_acry_rsa_enc,
+			.decrypt = aspeed_acry_rsa_dec,
+			.sign = aspeed_acry_rsa_dec,
+			.verify = aspeed_acry_rsa_enc,
+			.set_pub_key = aspeed_acry_rsa_set_pub_key,
+			.set_priv_key = aspeed_acry_rsa_set_priv_key,
+			.max_size = aspeed_acry_rsa_max_size,
+			.init = aspeed_acry_rsa_init_tfm,
+			.exit = aspeed_acry_rsa_exit_tfm,
+			.base = {
+				.cra_name = "rsa",
+				.cra_driver_name = "aspeed-rsa",
+				.cra_priority = 300,
+				.cra_flags = CRYPTO_ALG_TYPE_AKCIPHER |
+					     CRYPTO_ALG_ASYNC |
+					     CRYPTO_ALG_KERN_DRIVER_ONLY |
+					     CRYPTO_ALG_NEED_FALLBACK,
+				.cra_module = THIS_MODULE,
+				.cra_ctxsize = sizeof(struct aspeed_acry_ctx),
+			},
+		},
+	},
+};
+
+static void aspeed_acry_register(struct aspeed_acry_dev *acry_dev)
+{
+	int i, rc;
+
+	for (i = 0; i < ARRAY_SIZE(aspeed_acry_akcipher_algs); i++) {
+		aspeed_acry_akcipher_algs[i].acry_dev = acry_dev;
+		rc = crypto_register_akcipher(&aspeed_acry_akcipher_algs[i].akcipher);
+		if (rc) {
+			ACRY_DBG(acry_dev, "Failed to register %s\n",
+				 aspeed_acry_akcipher_algs[i].akcipher.base.cra_name);
+		}
+	}
+}
+
+static void aspeed_acry_unregister(struct aspeed_acry_dev *acry_dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(aspeed_acry_akcipher_algs); i++)
+		crypto_unregister_akcipher(&aspeed_acry_akcipher_algs[i].akcipher);
+}
+
+/* ACRY interrupt service routine. */
+static irqreturn_t aspeed_acry_irq(int irq, void *dev)
+{
+	struct aspeed_acry_dev *acry_dev = (struct aspeed_acry_dev *)dev;
+	u32 sts;
+
+	sts = ast_acry_read(acry_dev, ASPEED_ACRY_STATUS);
+	ast_acry_write(acry_dev, sts, ASPEED_ACRY_STATUS);
+
+	ACRY_DBG(acry_dev, "irq sts:0x%x\n", sts);
+
+	if (sts & ACRY_RSA_ISR) {
+		/* Stop RSA engine */
+		ast_acry_write(acry_dev, 0, ASPEED_ACRY_TRIGGER);
+
+		if (acry_dev->flags & CRYPTO_FLAGS_BUSY)
+			tasklet_schedule(&acry_dev->done_task);
+		else
+			dev_err(acry_dev->dev, "RSA no active requests.\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * ACRY SRAM has its own memory layout.
+ * Set the DRAM to SRAM indexing for future used.
+ */
+static void aspeed_acry_sram_mapping(struct aspeed_acry_dev *acry_dev)
+{
+	int i, j = 0;
+
+	for (i = 0; i < (ASPEED_ACRY_SRAM_MAX_LEN / BYTES_PER_DWORD); i++) {
+		acry_dev->exp_dw_mapping[i] = j;
+		acry_dev->mod_dw_mapping[i] = j + 4;
+		acry_dev->data_byte_mapping[(i * 4)] = (j + 8) * 4;
+		acry_dev->data_byte_mapping[(i * 4) + 1] = (j + 8) * 4 + 1;
+		acry_dev->data_byte_mapping[(i * 4) + 2] = (j + 8) * 4 + 2;
+		acry_dev->data_byte_mapping[(i * 4) + 3] = (j + 8) * 4 + 3;
+		j++;
+		j = j % 4 ? j : j + 8;
+	}
+}
+
+static void aspeed_acry_done_task(unsigned long data)
+{
+	struct aspeed_acry_dev *acry_dev = (struct aspeed_acry_dev *)data;
+
+	(void)acry_dev->resume(acry_dev);
+}
+
+static const struct of_device_id aspeed_acry_of_matches[] = {
+	{ .compatible = "aspeed,ast2600-acry", },
+	{},
+};
+
+static int aspeed_acry_probe(struct platform_device *pdev)
+{
+	struct aspeed_acry_dev *acry_dev;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int rc;
+
+	acry_dev = devm_kzalloc(dev, sizeof(struct aspeed_acry_dev),
+				GFP_KERNEL);
+	if (!acry_dev)
+		return -ENOMEM;
+
+	acry_dev->dev = dev;
+
+	platform_set_drvdata(pdev, acry_dev);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	acry_dev->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(acry_dev->regs))
+		return PTR_ERR(acry_dev->regs);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	acry_dev->acry_sram = devm_ioremap_resource(dev, res);
+	if (IS_ERR(acry_dev->acry_sram))
+		return PTR_ERR(acry_dev->acry_sram);
+
+	/* Get irq number and register it */
+	acry_dev->irq = platform_get_irq(pdev, 0);
+	if (!acry_dev->irq) {
+		dev_err(dev, "Failed to get interrupt\n");
+		return -ENXIO;
+	}
+
+	rc = devm_request_irq(dev, acry_dev->irq, aspeed_acry_irq, 0,
+			      dev_name(dev), acry_dev);
+	if (rc) {
+		dev_err(dev, "Failed to request irq.\n");
+		return rc;
+	}
+
+	acry_dev->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(acry_dev->clk)) {
+		dev_err(dev, "Failed to get clk\n");
+		return -ENODEV;
+	}
+
+	acry_dev->ahbc = syscon_regmap_lookup_by_phandle(dev->of_node,
+							 "aspeed,ahbc");
+	if (IS_ERR(acry_dev->ahbc)) {
+		dev_err(dev, "Failed to get AHBC regmap\n");
+		return -ENODEV;
+	}
+
+	rc = clk_prepare_enable(acry_dev->clk);
+	if (rc) {
+		dev_err(dev, "Failed to enable clock 0x%x\n", rc);
+		return rc;
+	}
+
+	/* Initialize crypto hardware engine structure for RSA */
+	acry_dev->crypt_engine_rsa = crypto_engine_alloc_init(dev, true);
+	if (!acry_dev->crypt_engine_rsa) {
+		rc = -ENOMEM;
+		goto clk_exit;
+	}
+
+	rc = crypto_engine_start(acry_dev->crypt_engine_rsa);
+	if (rc)
+		goto err_engine_rsa_start;
+
+	tasklet_init(&acry_dev->done_task, aspeed_acry_done_task,
+		     (unsigned long)acry_dev);
+
+	/* Set Data Memory to AHB(CPU) Access Mode */
+	ast_acry_write(acry_dev, ACRY_CMD_DMEM_AHB, ASPEED_ACRY_DMA_CMD);
+
+	/* Initialize ACRY SRAM index */
+	aspeed_acry_sram_mapping(acry_dev);
+
+	acry_dev->buf_addr = dmam_alloc_coherent(dev, ASPEED_ACRY_BUFF_SIZE,
+						 &acry_dev->buf_dma_addr,
+						 GFP_KERNEL);
+	memzero_explicit(acry_dev->buf_addr, ASPEED_ACRY_BUFF_SIZE);
+
+	aspeed_acry_register(acry_dev);
+
+	dev_info(dev, "Aspeed ACRY Accelerator successfully registered\n");
+
+	return 0;
+
+err_engine_rsa_start:
+	crypto_engine_exit(acry_dev->crypt_engine_rsa);
+clk_exit:
+	clk_disable_unprepare(acry_dev->clk);
+
+	return rc;
+}
+
+static int aspeed_acry_remove(struct platform_device *pdev)
+{
+	struct aspeed_acry_dev *acry_dev = platform_get_drvdata(pdev);
+
+	aspeed_acry_unregister(acry_dev);
+	crypto_engine_exit(acry_dev->crypt_engine_rsa);
+	tasklet_kill(&acry_dev->done_task);
+	clk_disable_unprepare(acry_dev->clk);
+
+	return 0;
+}
+
+MODULE_DEVICE_TABLE(of, aspeed_acry_of_matches);
+
+static struct platform_driver aspeed_acry_driver = {
+	.probe		= aspeed_acry_probe,
+	.remove		= aspeed_acry_remove,
+	.driver		= {
+		.name   = KBUILD_MODNAME,
+		.of_match_table = aspeed_acry_of_matches,
+	},
+};
+
+module_platform_driver(aspeed_acry_driver);
+
+MODULE_AUTHOR("Neal Liu <neal_liu@aspeedtech.com>");
+MODULE_DESCRIPTION("ASPEED ACRY driver for hardware RSA Engine");
+MODULE_LICENSE("GPL");
-- 
2.25.1

