Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786E1539CBF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 07:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244992AbiFAFoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 01:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349691AbiFAFoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 01:44:13 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ED84C7AB;
        Tue, 31 May 2022 22:44:08 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2515Rn6B027924;
        Wed, 1 Jun 2022 13:27:49 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 1 Jun
 2022 13:42:17 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        "Andrew Jeffery" <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     <linux-aspeed@lists.ozlabs.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] crypto: aspeed: Add HACE hash driver
Date:   Wed, 1 Jun 2022 13:42:00 +0800
Message-ID: <20220601054204.1522976-2-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2515Rn6B027924
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hash and Crypto Engine (HACE) is designed to accelerate the
throughput of hash data digest, encryption, and decryption.

Basically, HACE can be divided into two independently engines
- Hash Engine and Crypto Engine. This patch aims to add HACE
hash engine driver for hash accelerator.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
---
 MAINTAINERS                              |    7 +
 drivers/crypto/Kconfig                   |    1 +
 drivers/crypto/Makefile                  |    1 +
 drivers/crypto/aspeed/Kconfig            |   22 +
 drivers/crypto/aspeed/Makefile           |    6 +
 drivers/crypto/aspeed/aspeed-hace-hash.c | 1335 ++++++++++++++++++++++
 drivers/crypto/aspeed/aspeed-hace.c      |  210 ++++
 drivers/crypto/aspeed/aspeed-hace.h      |  179 +++
 8 files changed, 1761 insertions(+)
 create mode 100644 drivers/crypto/aspeed/Kconfig
 create mode 100644 drivers/crypto/aspeed/Makefile
 create mode 100644 drivers/crypto/aspeed/aspeed-hace-hash.c
 create mode 100644 drivers/crypto/aspeed/aspeed-hace.c
 create mode 100644 drivers/crypto/aspeed/aspeed-hace.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e8c52d0192a6..c020e0893eed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3109,6 +3109,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/aspeed-video.txt
 F:	drivers/media/platform/aspeed/
 
+ASPEED CRYPTO DRIVER
+M:	Neal Liu <neal_liu@aspeedtech.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/crypto/aspeed,hace.yaml
+F:	drivers/crypto/aspeed/
+
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
 M:	Corentin Chary <corentin.chary@gmail.com>
 L:	acpi4asus-user@lists.sourceforge.net
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 7b2d138bc83e..2b22d550c217 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -933,5 +933,6 @@ config CRYPTO_DEV_SA2UL
 	  acceleration for cryptographic algorithms on these devices.
 
 source "drivers/crypto/keembay/Kconfig"
+source "drivers/crypto/aspeed/Kconfig"
 
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 0a4fff23d272..b619c0732bc3 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CRYPTO_DEV_ALLWINNER) += allwinner/
+obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed/
 obj-$(CONFIG_CRYPTO_DEV_ATMEL_AES) += atmel-aes.o
 obj-$(CONFIG_CRYPTO_DEV_ATMEL_SHA) += atmel-sha.o
 obj-$(CONFIG_CRYPTO_DEV_ATMEL_TDES) += atmel-tdes.o
diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
new file mode 100644
index 000000000000..17b800286a51
--- /dev/null
+++ b/drivers/crypto/aspeed/Kconfig
@@ -0,0 +1,22 @@
+config CRYPTO_DEV_ASPEED
+	tristate "Support for Aspeed cryptographic engine driver"
+	depends on ARCH_ASPEED
+	help
+	Hash and Crypto Engine (HACE) is designed to accelerate the
+	throughput of hash data digest, encryption and decryption.
+
+	Select y here to have support for the cryptographic driver
+	available on Aspeed SoC.
+
+config CRYPTO_DEV_ASPEED_HACE_HASH
+        bool "Enable ASPEED Hash & Crypto Engine (HACE) hash"
+        depends on CRYPTO_DEV_ASPEED
+	select CRYPTO_SHA1
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select CRYPTO_HMAC
+	help
+	  Select here to enable ASPEED Hash & Crypto Engine (HACE)
+	  hash driver.
+	  Supports multiple message digest standards, including
+	  SHA-1, SHA-224, SHA-256, SHA-384, SHA-512, and so on.
diff --git a/drivers/crypto/aspeed/Makefile b/drivers/crypto/aspeed/Makefile
new file mode 100644
index 000000000000..8bc8d4fed5a9
--- /dev/null
+++ b/drivers/crypto/aspeed/Makefile
@@ -0,0 +1,6 @@
+obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
+aspeed_crypto-objs := aspeed-hace.o \
+		      $(hace-hash-y)
+
+obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) += aspeed-hace-hash.o
+hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) := aspeed-hace-hash.o
diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c b/drivers/crypto/aspeed/aspeed-hace-hash.c
new file mode 100644
index 000000000000..40b316d86670
--- /dev/null
+++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
@@ -0,0 +1,1335 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2021 Aspeed Technology Inc.
+ */
+
+#include "aspeed-hace.h"
+
+//#define ASPEED_AHASH_DEBUG
+
+#ifdef ASPEED_AHASH_DEBUG
+#define AHASH_DBG(h, fmt, ...)	\
+	dev_info((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
+#else
+#define AHASH_DBG(h, fmt, ...)	\
+	((void)(h))
+#endif
+
+/* Initialization Vectors for SHA-family */
+static const u32 sha1_iv[8] = {
+	0x01234567UL, 0x89abcdefUL, 0xfedcba98UL, 0x76543210UL,
+	0xf0e1d2c3UL, 0, 0, 0
+};
+
+static const u32 sha224_iv[8] = {
+	0xd89e05c1UL, 0x07d57c36UL, 0x17dd7030UL, 0x39590ef7UL,
+	0x310bc0ffUL, 0x11155868UL, 0xa78ff964UL, 0xa44ffabeUL
+};
+
+static const u32 sha256_iv[8] = {
+	0x67e6096aUL, 0x85ae67bbUL, 0x72f36e3cUL, 0x3af54fa5UL,
+	0x7f520e51UL, 0x8c68059bUL, 0xabd9831fUL, 0x19cde05bUL
+};
+
+static const u32 sha384_iv[16] = {
+	0x5d9dbbcbUL, 0xd89e05c1UL, 0x2a299a62UL, 0x07d57c36UL,
+	0x5a015991UL, 0x17dd7030UL, 0xd8ec2f15UL, 0x39590ef7UL,
+	0x67263367UL, 0x310bc0ffUL, 0x874ab48eUL, 0x11155868UL,
+	0x0d2e0cdbUL, 0xa78ff964UL, 0x1d48b547UL, 0xa44ffabeUL
+};
+
+static const u32 sha512_iv[16] = {
+	0x67e6096aUL, 0x08c9bcf3UL, 0x85ae67bbUL, 0x3ba7ca84UL,
+	0x72f36e3cUL, 0x2bf894feUL, 0x3af54fa5UL, 0xf1361d5fUL,
+	0x7f520e51UL, 0xd182e6adUL, 0x8c68059bUL, 0x1f6c3e2bUL,
+	0xabd9831fUL, 0x6bbd41fbUL, 0x19cde05bUL, 0x79217e13UL
+};
+
+static const u32 sha512_224_iv[16] = {
+	0xC8373D8CUL, 0xA24D5419UL, 0x6699E173UL, 0xD6D4DC89UL,
+	0xAEB7FA1DUL, 0x829CFF32UL, 0x14D59D67UL, 0xCF9F2F58UL,
+	0x692B6D0FUL, 0xA84DD47BUL, 0x736FE377UL, 0x4289C404UL,
+	0xA8859D3FUL, 0xC8361D6AUL, 0xADE61211UL, 0xA192D691UL
+};
+
+static const u32 sha512_256_iv[16] = {
+	0x94213122UL, 0x2CF72BFCUL, 0xA35F559FUL, 0xC2644CC8UL,
+	0x6BB89323UL, 0x51B1536FUL, 0x19773896UL, 0xBDEA4059UL,
+	0xE23E2896UL, 0xE3FF8EA8UL, 0x251E5EBEUL, 0x92398653UL,
+	0xFC99012BUL, 0xAAB8852CUL, 0xDC2DB70EUL, 0xA22CC581UL
+};
+
+static void aspeed_ahash_iV(struct aspeed_sham_reqctx *rctx)
+{
+	if (rctx->flags & SHA_FLAGS_SHA1)
+		memcpy(rctx->digest, sha1_iv, 32);
+	else if (rctx->flags & SHA_FLAGS_SHA224)
+		memcpy(rctx->digest, sha224_iv, 32);
+	else if (rctx->flags & SHA_FLAGS_SHA256)
+		memcpy(rctx->digest, sha256_iv, 32);
+	else if (rctx->flags & SHA_FLAGS_SHA384)
+		memcpy(rctx->digest, sha384_iv, 64);
+	else if (rctx->flags & SHA_FLAGS_SHA512)
+		memcpy(rctx->digest, sha512_iv, 64);
+	else if (rctx->flags & SHA_FLAGS_SHA512_224)
+		memcpy(rctx->digest, sha512_224_iv, 64);
+	else if (rctx->flags & SHA_FLAGS_SHA512_256)
+		memcpy(rctx->digest, sha512_256_iv, 64);
+}
+
+/* The purpose of this padding is to ensure that the padded message is a
+ * multiple of 512 bits (SHA1/SHA224/SHA256) or 1024 bits (SHA384/SHA512).
+ * The bit "1" is appended at the end of the message followed by
+ * "padlen-1" zero bits. Then a 64 bits block (SHA1/SHA224/SHA256) or
+ * 128 bits block (SHA384/SHA512) equals to the message length in bits
+ * is appended.
+ *
+ * For SHA1/SHA224/SHA256, padlen is calculated as followed:
+ *  - if message length < 56 bytes then padlen = 56 - message length
+ *  - else padlen = 64 + 56 - message length
+ *
+ * For SHA384/SHA512, padlen is calculated as followed:
+ *  - if message length < 112 bytes then padlen = 112 - message length
+ *  - else padlen = 128 + 112 - message length
+ */
+static void aspeed_ahash_fill_padding(struct aspeed_hace_dev *hace_dev,
+				      struct aspeed_sham_reqctx *rctx)
+{
+	unsigned int index, padlen;
+	u64 bits[2];
+
+	AHASH_DBG(hace_dev, "rctx flags:0x%x\n", rctx->flags);
+
+	switch (rctx->flags & SHA_FLAGS_MASK) {
+	case SHA_FLAGS_SHA1:
+	case SHA_FLAGS_SHA224:
+	case SHA_FLAGS_SHA256:
+		bits[0] = cpu_to_be64(rctx->digcnt[0] << 3);
+		index = rctx->bufcnt & 0x3f;
+		padlen = (index < 56) ? (56 - index) : ((64 + 56) - index);
+		*(rctx->buffer + rctx->bufcnt) = 0x80;
+		memset(rctx->buffer + rctx->bufcnt + 1, 0, padlen - 1);
+		memcpy(rctx->buffer + rctx->bufcnt + padlen, bits, 8);
+		rctx->bufcnt += padlen + 8;
+		break;
+	default:
+		bits[1] = cpu_to_be64(rctx->digcnt[0] << 3);
+		bits[0] = cpu_to_be64(rctx->digcnt[1] << 3 |
+				      rctx->digcnt[0] >> 61);
+		index = rctx->bufcnt & 0x7f;
+		padlen = (index < 112) ? (112 - index) : ((128 + 112) - index);
+		*(rctx->buffer + rctx->bufcnt) = 0x80;
+		memset(rctx->buffer + rctx->bufcnt + 1, 0, padlen - 1);
+		memcpy(rctx->buffer + rctx->bufcnt + padlen, bits, 16);
+		rctx->bufcnt += padlen + 16;
+		break;
+	}
+}
+
+/*
+ * Prepare DMA buffer before hardware engine
+ * processing.
+ */
+static int aspeed_ahash_dma_prepare(struct aspeed_hace_dev *hace_dev)
+{
+	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
+	struct ahash_request *req = hash_engine->ahash_req;
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+	struct device *dev = hace_dev->dev;
+	int length, remain;
+
+	length = rctx->total + rctx->bufcnt;
+	remain = length % rctx->block_size;
+
+	AHASH_DBG(hace_dev, "length:0x%x, remain:0x%x\n", length, remain);
+
+	if (rctx->bufcnt)
+		memcpy(hash_engine->ahash_src_addr, rctx->buffer, rctx->bufcnt);
+
+	if (rctx->total + rctx->bufcnt < ASPEED_CRYPTO_SRC_DMA_BUF_LEN) {
+		scatterwalk_map_and_copy(hash_engine->ahash_src_addr +
+					 rctx->bufcnt, rctx->src_sg,
+					 rctx->offset, rctx->total - remain, 0);
+		rctx->offset += rctx->total - remain;
+
+	} else {
+		dev_warn(dev, "Hash data length is too large\n");
+	}
+
+	scatterwalk_map_and_copy(rctx->buffer, rctx->src_sg,
+				 rctx->offset, remain, 0);
+
+	rctx->bufcnt = remain;
+	rctx->digest_dma_addr = dma_map_single(hace_dev->dev, rctx->digest,
+					       SHA512_DIGEST_SIZE,
+					       DMA_BIDIRECTIONAL);
+
+	hash_engine->src_length = length - remain;
+	hash_engine->src_dma = hash_engine->ahash_src_dma_addr;
+	hash_engine->digest_dma = rctx->digest_dma_addr;
+
+	return 0;
+}
+
+/*
+ * Prepare DMA buffer as SG list buffer before
+ * hardware engine processing.
+ */
+static int aspeed_ahash_dma_prepare_sg(struct aspeed_hace_dev *hace_dev)
+{
+	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
+	struct ahash_request *req = hash_engine->ahash_req;
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+	struct aspeed_sg_list *src_list;
+	struct scatterlist *s;
+	int length, remain, sg_len, i;
+
+	remain = (rctx->total + rctx->bufcnt) % rctx->block_size;
+	length = rctx->total + rctx->bufcnt - remain;
+
+	AHASH_DBG(hace_dev, "%s:0x%x, %s:0x%x, %s:0x%x, %s:0x%x\n",
+		  "rctx total", rctx->total, "bufcnt", rctx->bufcnt,
+		  "length", length, "remain", remain);
+
+	sg_len = dma_map_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
+			    DMA_TO_DEVICE);
+	if (!sg_len) {
+		dev_warn(hace_dev->dev, "dma_map_sg() src error\n");
+		return -EINVAL;
+	}
+
+	src_list = (struct aspeed_sg_list *)hash_engine->ahash_src_addr;
+	rctx->digest_dma_addr = dma_map_single(hace_dev->dev, rctx->digest,
+					       SHA512_DIGEST_SIZE,
+					       DMA_BIDIRECTIONAL);
+	if (rctx->bufcnt != 0) {
+		rctx->buffer_dma_addr = dma_map_single(hace_dev->dev,
+						       rctx->buffer,
+						       rctx->block_size * 2,
+						       DMA_TO_DEVICE);
+
+		src_list[0].phy_addr = rctx->buffer_dma_addr;
+		src_list[0].len = rctx->bufcnt;
+		length -= src_list[0].len;
+
+		/* Last sg list */
+		if (length == 0)
+			src_list[0].len |= BIT(31);
+		src_list++;
+	}
+
+	if (length != 0) {
+		for_each_sg(rctx->src_sg, s, sg_len, i) {
+			src_list[i].phy_addr = sg_dma_address(s);
+
+			if (length > sg_dma_len(s)) {
+				src_list[i].len = sg_dma_len(s);
+				length -= sg_dma_len(s);
+
+			} else {
+				/* Last sg list */
+				src_list[i].len = length;
+				src_list[i].len |= BIT(31);
+				length = 0;
+				break;
+			}
+		}
+	}
+
+	if (length != 0)
+		return -EINVAL;
+
+	rctx->offset = rctx->total - remain;
+	hash_engine->src_length = rctx->total + rctx->bufcnt - remain;
+	hash_engine->src_dma = hash_engine->ahash_src_dma_addr;
+	hash_engine->digest_dma = rctx->digest_dma_addr;
+
+	return 0;
+}
+
+static int aspeed_ahash_complete(struct aspeed_hace_dev *hace_dev)
+{
+	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
+	struct ahash_request *req = hash_engine->ahash_req;
+
+	AHASH_DBG(hace_dev, "\n");
+
+	hash_engine->flags &= ~CRYPTO_FLAGS_BUSY;
+
+	if (req->base.complete)
+		req->base.complete(&req->base, 0);
+
+	tasklet_schedule(&hash_engine->queue_task);
+
+	return 0;
+}
+
+/*
+ * Copy digest to the corresponding request result.
+ * This function will be called at final() stage.
+ */
+static int aspeed_ahash_transfer(struct aspeed_hace_dev *hace_dev)
+{
+	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
+	struct ahash_request *req = hash_engine->ahash_req;
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+
+	AHASH_DBG(hace_dev, "\n");
+
+	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
+			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
+
+	dma_unmap_single(hace_dev->dev, rctx->buffer_dma_addr,
+			 rctx->block_size * 2, DMA_TO_DEVICE);
+
+	memcpy(req->result, rctx->digest, rctx->digsize);
+
+	return aspeed_ahash_complete(hace_dev);
+}
+
+/*
+ * Trigger hardware engines to do the math.
+ */
+static int aspeed_hace_ahash_trigger(struct aspeed_hace_dev *hace_dev,
+				     aspeed_hace_fn_t resume)
+{
+	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
+	struct ahash_request *req = hash_engine->ahash_req;
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+
+	AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x, length:0x%x\n",
+		  hash_engine->src_dma, hash_engine->digest_dma,
+		  hash_engine->src_length);
+
+	rctx->cmd |= HASH_CMD_INT_ENABLE;
+	hash_engine->resume = resume;
+
+	ast_hace_write(hace_dev, hash_engine->src_dma, ASPEED_HACE_HASH_SRC);
+	ast_hace_write(hace_dev, hash_engine->digest_dma,
+		       ASPEED_HACE_HASH_DIGEST_BUFF);
+	ast_hace_write(hace_dev, hash_engine->digest_dma,
+		       ASPEED_HACE_HASH_KEY_BUFF);
+	ast_hace_write(hace_dev, hash_engine->src_length,
+		       ASPEED_HACE_HASH_DATA_LEN);
+
+	/* Dummy read for barriers */
+	readl(hash_engine->ahash_src_addr);
+	ast_hace_write(hace_dev, rctx->cmd, ASPEED_HACE_HASH_CMD);
+
+	return -EINPROGRESS;
+}
+
+/*
+ * HMAC resume aims to do the second pass produces
+ * the final HMAC code derived from the inner hash
+ * result and the outer key.
+ */
+static int aspeed_ahash_hmac_resume(struct aspeed_hace_dev *hace_dev)
+{
+	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
+	struct ahash_request *req = hash_engine->ahash_req;
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct aspeed_sha_hmac_ctx *bctx = tctx->base;
+
+	AHASH_DBG(hace_dev, "\n");
+
+	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
+			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
+
+	dma_unmap_single(hace_dev->dev, rctx->buffer_dma_addr,
+			 rctx->block_size * 2, DMA_TO_DEVICE);
+
+	/* o key pad + hash sum 1 */
+	memcpy(rctx->buffer, bctx->opad, rctx->block_size);
+	memcpy(rctx->buffer + rctx->block_size, rctx->digest, rctx->digsize);
+
+	rctx->bufcnt = rctx->block_size + rctx->digsize;
+	rctx->digcnt[0] = rctx->block_size + rctx->digsize;
+
+	aspeed_ahash_fill_padding(hace_dev, rctx);
+	aspeed_ahash_iV(rctx);
+
+	rctx->digest_dma_addr = dma_map_single(hace_dev->dev, rctx->digest,
+					       SHA512_DIGEST_SIZE,
+					       DMA_BIDIRECTIONAL);
+
+	rctx->buffer_dma_addr = dma_map_single(hace_dev->dev, rctx->buffer,
+					       rctx->block_size * 2,
+					       DMA_TO_DEVICE);
+
+	hash_engine->src_dma = rctx->buffer_dma_addr;
+	hash_engine->src_length = rctx->bufcnt;
+	hash_engine->digest_dma = rctx->digest_dma_addr;
+
+	return aspeed_hace_ahash_trigger(hace_dev, aspeed_ahash_transfer);
+}
+
+static int aspeed_ahash_req_final(struct aspeed_hace_dev *hace_dev)
+{
+	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
+	struct ahash_request *req = hash_engine->ahash_req;
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+
+	AHASH_DBG(hace_dev, "\n");
+
+	aspeed_ahash_fill_padding(hace_dev, rctx);
+
+	rctx->digest_dma_addr = dma_map_single(hace_dev->dev,
+					       rctx->digest,
+					       SHA512_DIGEST_SIZE,
+					       DMA_BIDIRECTIONAL);
+
+	rctx->buffer_dma_addr = dma_map_single(hace_dev->dev,
+					       rctx->buffer,
+					       rctx->block_size * 2,
+					       DMA_TO_DEVICE);
+
+	hash_engine->src_dma = rctx->buffer_dma_addr;
+	hash_engine->src_length = rctx->bufcnt;
+	hash_engine->digest_dma = rctx->digest_dma_addr;
+
+	if (rctx->flags & SHA_FLAGS_HMAC)
+		return aspeed_hace_ahash_trigger(hace_dev,
+						 aspeed_ahash_hmac_resume);
+
+	return aspeed_hace_ahash_trigger(hace_dev, aspeed_ahash_transfer);
+}
+
+static int aspeed_ahash_update_resume_sg(struct aspeed_hace_dev *hace_dev)
+{
+	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
+	struct ahash_request *req = hash_engine->ahash_req;
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+
+	AHASH_DBG(hace_dev, "\n");
+
+	dma_unmap_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
+		     DMA_TO_DEVICE);
+
+	if (rctx->bufcnt != 0)
+		dma_unmap_single(hace_dev->dev, rctx->buffer_dma_addr,
+				 rctx->block_size * 2,
+				 DMA_TO_DEVICE);
+
+	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
+			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
+
+	scatterwalk_map_and_copy(rctx->buffer, rctx->src_sg, rctx->offset,
+				 rctx->total - rctx->offset, 0);
+
+	rctx->bufcnt = rctx->total - rctx->offset;
+	rctx->cmd &= ~HASH_CMD_HASH_SRC_SG_CTRL;
+
+	// no need to call final()?
+	if (rctx->flags & SHA_FLAGS_FINUP)
+		return aspeed_ahash_req_final(hace_dev);
+
+	return aspeed_ahash_complete(hace_dev);
+}
+
+static int aspeed_ahash_update_resume(struct aspeed_hace_dev *hace_dev)
+{
+	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
+	struct ahash_request *req = hash_engine->ahash_req;
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+
+	AHASH_DBG(hace_dev, "\n");
+
+	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
+			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
+
+	if (rctx->flags & SHA_FLAGS_FINUP)
+		return aspeed_ahash_req_final(hace_dev);
+
+	return aspeed_ahash_complete(hace_dev);
+}
+
+static int aspeed_ahash_req_update(struct aspeed_hace_dev *hace_dev)
+{
+	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
+	struct ahash_request *req = hash_engine->ahash_req;
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+	aspeed_hace_fn_t resume;
+
+	AHASH_DBG(hace_dev, "\n");
+
+	if (hace_dev->version == AST2600_VERSION) {
+		rctx->cmd |= HASH_CMD_HASH_SRC_SG_CTRL;
+		resume = aspeed_ahash_update_resume_sg;
+	} else
+		resume = aspeed_ahash_update_resume;
+
+	hash_engine->dma_prepare(hace_dev);
+
+	return aspeed_hace_ahash_trigger(hace_dev, resume);
+}
+
+int aspeed_hace_hash_handle_queue(struct aspeed_hace_dev *hace_dev,
+				  struct crypto_async_request *new_areq)
+{
+	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
+	struct crypto_async_request *areq, *backlog;
+	struct aspeed_sham_reqctx *rctx;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&hash_engine->lock, flags);
+
+	if (new_areq)
+		ret = crypto_enqueue_request(&hash_engine->queue, new_areq);
+
+	if (hash_engine->flags & CRYPTO_FLAGS_BUSY) {
+		spin_unlock_irqrestore(&hash_engine->lock, flags);
+		return ret;
+	}
+
+	backlog = crypto_get_backlog(&hash_engine->queue);
+	areq = crypto_dequeue_request(&hash_engine->queue);
+	if (areq)
+		hash_engine->flags |= CRYPTO_FLAGS_BUSY;
+
+	spin_unlock_irqrestore(&hash_engine->lock, flags);
+
+	if (!areq)
+		return ret;
+
+	if (backlog)
+		backlog->complete(backlog, -EINPROGRESS);
+
+	if (hace_dev->version == AST2600_VERSION)
+		hash_engine->dma_prepare = aspeed_ahash_dma_prepare_sg;
+	else
+		hash_engine->dma_prepare = aspeed_ahash_dma_prepare;
+
+	hash_engine->ahash_req = ahash_request_cast(areq);
+	rctx = ahash_request_ctx(hash_engine->ahash_req);
+
+	if (rctx->op == SHA_OP_UPDATE)
+		ret = aspeed_ahash_req_update(hace_dev);
+	else if (rctx->op == SHA_OP_FINAL)
+		ret = aspeed_ahash_req_final(hace_dev);
+
+	return ret;
+}
+
+static int aspeed_sham_update(struct ahash_request *req)
+{
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
+
+	AHASH_DBG(hace_dev, "req->nbytes: %d\n", req->nbytes);
+
+	rctx->total = req->nbytes;
+	rctx->src_sg = req->src;
+	rctx->offset = 0;
+	rctx->src_nents = sg_nents(req->src);
+	rctx->op = SHA_OP_UPDATE;
+
+	rctx->digcnt[0] += rctx->total;
+	if (rctx->digcnt[0] < rctx->total)
+		rctx->digcnt[1]++;
+
+	if (rctx->bufcnt + rctx->total < rctx->block_size) {
+		scatterwalk_map_and_copy(rctx->buffer + rctx->bufcnt,
+					 rctx->src_sg, rctx->offset,
+					 rctx->total, 0);
+		rctx->bufcnt += rctx->total;
+
+		return 0;
+	}
+
+	return aspeed_hace_hash_handle_queue(hace_dev, &req->base);
+}
+
+static int aspeed_sham_shash_digest(struct crypto_shash *tfm, u32 flags,
+				    const u8 *data, unsigned int len, u8 *out)
+{
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tfm;
+
+	return crypto_shash_digest(shash, data, len, out);
+}
+
+static int aspeed_sham_final(struct ahash_request *req)
+{
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
+
+	AHASH_DBG(hace_dev, "req->nbytes:%d, rctx->total:%d\n",
+		  req->nbytes, rctx->total);
+	rctx->op = SHA_OP_FINAL;
+
+	return aspeed_hace_hash_handle_queue(hace_dev, &req->base);
+}
+
+static int aspeed_sham_finup(struct ahash_request *req)
+{
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
+	int rc1, rc2;
+
+	AHASH_DBG(hace_dev, "req->nbytes: %d\n", req->nbytes);
+
+	rctx->flags |= SHA_FLAGS_FINUP;
+
+	rc1 = aspeed_sham_update(req);
+	if (rc1 == -EINPROGRESS || rc1 == -EBUSY)
+		return rc1;
+
+	/*
+	 * final() has to be always called to cleanup resources
+	 * even if update() failed, except EINPROGRESS
+	 */
+	rc2 = aspeed_sham_final(req);
+
+	return rc1 ? : rc2;
+}
+
+static int aspeed_sham_init(struct ahash_request *req)
+{
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
+	struct aspeed_sha_hmac_ctx *bctx = tctx->base;
+
+	AHASH_DBG(hace_dev, "%s: digest size:%d\n",
+		  crypto_tfm_alg_name(&tfm->base),
+		  crypto_ahash_digestsize(tfm));
+
+	rctx->cmd = HASH_CMD_ACC_MODE;
+	rctx->flags = 0;
+
+	switch (crypto_ahash_digestsize(tfm)) {
+	case SHA1_DIGEST_SIZE:
+		rctx->cmd |= HASH_CMD_SHA1 | HASH_CMD_SHA_SWAP;
+		rctx->flags |= SHA_FLAGS_SHA1;
+		rctx->digsize = SHA1_DIGEST_SIZE;
+		rctx->block_size = SHA1_BLOCK_SIZE;
+		memcpy(rctx->digest, sha1_iv, 32);
+		break;
+	case SHA224_DIGEST_SIZE:
+		rctx->cmd |= HASH_CMD_SHA224 | HASH_CMD_SHA_SWAP;
+		rctx->flags |= SHA_FLAGS_SHA224;
+		rctx->digsize = SHA224_DIGEST_SIZE;
+		rctx->block_size = SHA224_BLOCK_SIZE;
+		memcpy(rctx->digest, sha224_iv, 32);
+		break;
+	case SHA256_DIGEST_SIZE:
+		rctx->cmd |= HASH_CMD_SHA256 | HASH_CMD_SHA_SWAP;
+		rctx->flags |= SHA_FLAGS_SHA256;
+		rctx->digsize = SHA256_DIGEST_SIZE;
+		rctx->block_size = SHA256_BLOCK_SIZE;
+		memcpy(rctx->digest, sha256_iv, 32);
+		break;
+	case SHA384_DIGEST_SIZE:
+		rctx->cmd |= HASH_CMD_SHA512_SER | HASH_CMD_SHA384 |
+			     HASH_CMD_SHA_SWAP;
+		rctx->flags |= SHA_FLAGS_SHA384;
+		rctx->digsize = SHA384_DIGEST_SIZE;
+		rctx->block_size = SHA384_BLOCK_SIZE;
+		memcpy(rctx->digest, sha384_iv, 64);
+		break;
+	case SHA512_DIGEST_SIZE:
+		rctx->cmd |= HASH_CMD_SHA512_SER | HASH_CMD_SHA512 |
+			     HASH_CMD_SHA_SWAP;
+		rctx->flags |= SHA_FLAGS_SHA512;
+		rctx->digsize = SHA512_DIGEST_SIZE;
+		rctx->block_size = SHA512_BLOCK_SIZE;
+		memcpy(rctx->digest, sha512_iv, 64);
+		break;
+	default:
+		dev_warn(tctx->hace_dev->dev, "digest size %d not support\n",
+			crypto_ahash_digestsize(tfm));
+		return -EINVAL;
+	}
+
+	rctx->bufcnt = 0;
+	rctx->total = 0;
+	rctx->digcnt[0] = 0;
+	rctx->digcnt[1] = 0;
+
+	/* HMAC init */
+	if (tctx->flags & SHA_FLAGS_HMAC) {
+		rctx->digcnt[0] = rctx->block_size;
+		rctx->bufcnt = rctx->block_size;
+		memcpy(rctx->buffer, bctx->ipad, rctx->block_size);
+		rctx->flags |= SHA_FLAGS_HMAC;
+	}
+
+	return 0;
+}
+
+static int aspeed_sha512s_init(struct ahash_request *req)
+{
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
+	struct aspeed_sha_hmac_ctx *bctx = tctx->base;
+
+	AHASH_DBG(hace_dev, "digest size: %d\n", crypto_ahash_digestsize(tfm));
+
+	rctx->cmd = HASH_CMD_ACC_MODE;
+	rctx->flags = 0;
+
+	switch (crypto_ahash_digestsize(tfm)) {
+	case SHA224_DIGEST_SIZE:
+		rctx->cmd |= HASH_CMD_SHA512_SER | HASH_CMD_SHA512_224 |
+			     HASH_CMD_SHA_SWAP;
+		rctx->flags |= SHA_FLAGS_SHA512_224;
+		rctx->digsize = SHA224_DIGEST_SIZE;
+		rctx->block_size = SHA512_BLOCK_SIZE;
+		memcpy(rctx->digest, sha512_224_iv, SHA224_BLOCK_SIZE);
+		break;
+	case SHA256_DIGEST_SIZE:
+		rctx->cmd |= HASH_CMD_SHA512_SER | HASH_CMD_SHA512_256 |
+			     HASH_CMD_SHA_SWAP;
+		rctx->flags |= SHA_FLAGS_SHA512_256;
+		rctx->digsize = SHA256_DIGEST_SIZE;
+		rctx->block_size = SHA512_BLOCK_SIZE;
+		memcpy(rctx->digest, sha512_256_iv, SHA256_BLOCK_SIZE);
+		break;
+	default:
+		dev_warn(tctx->hace_dev->dev, "digest size %d not support\n",
+			crypto_ahash_digestsize(tfm));
+		return -EINVAL;
+	}
+
+	rctx->bufcnt = 0;
+	rctx->total = 0;
+	rctx->digcnt[0] = 0;
+	rctx->digcnt[1] = 0;
+
+	/* HMAC init */
+	if (tctx->flags & SHA_FLAGS_HMAC) {
+		rctx->digcnt[0] = rctx->block_size;
+		rctx->bufcnt = rctx->block_size;
+		memcpy(rctx->buffer, bctx->ipad, rctx->block_size);
+		rctx->flags |= SHA_FLAGS_HMAC;
+	}
+
+	return 0;
+}
+
+static int aspeed_sham_digest(struct ahash_request *req)
+{
+	return aspeed_sham_init(req) ? : aspeed_sham_finup(req);
+}
+
+static int aspeed_sham_setkey(struct crypto_ahash *tfm, const u8 *key,
+			      unsigned int keylen)
+{
+	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
+	struct aspeed_sha_hmac_ctx *bctx = tctx->base;
+	int ds = crypto_shash_digestsize(bctx->shash);
+	int bs = crypto_shash_blocksize(bctx->shash);
+	int err = 0;
+	int i;
+
+	AHASH_DBG(hace_dev, "%s: keylen:%d\n", crypto_tfm_alg_name(&tfm->base),
+		  keylen);
+
+	if (keylen > bs) {
+		err = aspeed_sham_shash_digest(
+				bctx->shash,
+				crypto_shash_get_flags(bctx->shash),
+				key, keylen, bctx->ipad);
+		if (err)
+			return err;
+		keylen = ds;
+
+	} else {
+		memcpy(bctx->ipad, key, keylen);
+	}
+
+	memset(bctx->ipad + keylen, 0, bs - keylen);
+	memcpy(bctx->opad, bctx->ipad, bs);
+
+	for (i = 0; i < bs; i++) {
+		bctx->ipad[i] ^= 0x36;
+		bctx->opad[i] ^= 0x5c;
+	}
+
+	return err;
+}
+
+static int aspeed_sham_cra_init_alg(struct crypto_tfm *tfm,
+				    const char *alg_base)
+{
+	struct ahash_alg *alg = __crypto_ahash_alg(tfm->__crt_alg);
+	struct aspeed_sham_ctx *tctx = crypto_tfm_ctx(tfm);
+	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
+	struct aspeed_hace_alg *ast_alg;
+
+	ast_alg = container_of(alg, struct aspeed_hace_alg, alg.ahash);
+	tctx->hace_dev = ast_alg->hace_dev;
+	tctx->flags = 0;
+
+	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
+				 sizeof(struct aspeed_sham_reqctx));
+
+	if (alg_base) {
+		struct aspeed_sha_hmac_ctx *bctx = tctx->base;
+
+		tctx->flags |= SHA_FLAGS_HMAC;
+		bctx->shash = crypto_alloc_shash(alg_base, 0,
+						 CRYPTO_ALG_NEED_FALLBACK);
+		if (IS_ERR(bctx->shash)) {
+			dev_warn(hace_dev->dev,
+				"base driver '%s' could not be loaded.\n",
+				alg_base);
+			return PTR_ERR(bctx->shash);
+		}
+	}
+
+	return 0;
+}
+
+static int aspeed_sham_cra_init(struct crypto_tfm *tfm)
+{
+	return aspeed_sham_cra_init_alg(tfm, NULL);
+}
+
+static int aspeed_sham_cra_sha1_init(struct crypto_tfm *tfm)
+{
+	return aspeed_sham_cra_init_alg(tfm, "sha1");
+}
+
+static int aspeed_sham_cra_sha224_init(struct crypto_tfm *tfm)
+{
+	return aspeed_sham_cra_init_alg(tfm, "sha224");
+}
+
+static int aspeed_sham_cra_sha256_init(struct crypto_tfm *tfm)
+{
+	return aspeed_sham_cra_init_alg(tfm, "sha256");
+}
+
+static int aspeed_sham_cra_sha384_init(struct crypto_tfm *tfm)
+{
+	return aspeed_sham_cra_init_alg(tfm, "sha384");
+}
+
+static int aspeed_sham_cra_sha512_init(struct crypto_tfm *tfm)
+{
+	return aspeed_sham_cra_init_alg(tfm, "sha512");
+}
+
+static int aspeed_sham_cra_sha512_224_init(struct crypto_tfm *tfm)
+{
+	return aspeed_sham_cra_init_alg(tfm, "sha512_224");
+}
+
+static int aspeed_sham_cra_sha512_256_init(struct crypto_tfm *tfm)
+{
+	return aspeed_sham_cra_init_alg(tfm, "sha512_256");
+}
+
+static void aspeed_sham_cra_exit(struct crypto_tfm *tfm)
+{
+	struct aspeed_sham_ctx *tctx = crypto_tfm_ctx(tfm);
+	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
+
+	AHASH_DBG(hace_dev, "%s\n", crypto_tfm_alg_name(tfm));
+
+	if (tctx->flags & SHA_FLAGS_HMAC) {
+		struct aspeed_sha_hmac_ctx *bctx = tctx->base;
+
+		crypto_free_shash(bctx->shash);
+	}
+}
+
+static int aspeed_sham_export(struct ahash_request *req, void *out)
+{
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+
+	memcpy(out, rctx, sizeof(*rctx));
+
+	return 0;
+}
+
+static int aspeed_sham_import(struct ahash_request *req, const void *in)
+{
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+
+	memcpy(rctx, in, sizeof(*rctx));
+
+	return 0;
+}
+
+struct aspeed_hace_alg aspeed_ahash_algs[] = {
+	{
+		.alg.ahash = {
+			.init	= aspeed_sham_init,
+			.update	= aspeed_sham_update,
+			.final	= aspeed_sham_final,
+			.finup	= aspeed_sham_finup,
+			.digest	= aspeed_sham_digest,
+			.export	= aspeed_sham_export,
+			.import	= aspeed_sham_import,
+			.halg = {
+				.digestsize = SHA1_DIGEST_SIZE,
+				.statesize = sizeof(struct aspeed_sham_reqctx),
+				.base = {
+					.cra_name		= "sha1",
+					.cra_driver_name	= "aspeed-sha1",
+					.cra_priority		= 300,
+					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
+								  CRYPTO_ALG_ASYNC |
+								  CRYPTO_ALG_KERN_DRIVER_ONLY,
+					.cra_blocksize		= SHA1_BLOCK_SIZE,
+					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
+					.cra_alignmask		= 0,
+					.cra_module		= THIS_MODULE,
+					.cra_init		= aspeed_sham_cra_init,
+					.cra_exit		= aspeed_sham_cra_exit,
+				}
+			}
+		},
+	},
+	{
+		.alg.ahash = {
+			.init	= aspeed_sham_init,
+			.update	= aspeed_sham_update,
+			.final	= aspeed_sham_final,
+			.finup	= aspeed_sham_finup,
+			.digest	= aspeed_sham_digest,
+			.export	= aspeed_sham_export,
+			.import	= aspeed_sham_import,
+			.halg = {
+				.digestsize = SHA256_DIGEST_SIZE,
+				.statesize = sizeof(struct aspeed_sham_reqctx),
+				.base = {
+					.cra_name		= "sha256",
+					.cra_driver_name	= "aspeed-sha256",
+					.cra_priority		= 300,
+					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
+								  CRYPTO_ALG_ASYNC |
+								  CRYPTO_ALG_KERN_DRIVER_ONLY,
+					.cra_blocksize		= SHA256_BLOCK_SIZE,
+					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
+					.cra_alignmask		= 0,
+					.cra_module		= THIS_MODULE,
+					.cra_init		= aspeed_sham_cra_init,
+					.cra_exit		= aspeed_sham_cra_exit,
+				}
+			}
+		},
+	},
+	{
+		.alg.ahash = {
+			.init	= aspeed_sham_init,
+			.update	= aspeed_sham_update,
+			.final	= aspeed_sham_final,
+			.finup	= aspeed_sham_finup,
+			.digest	= aspeed_sham_digest,
+			.export	= aspeed_sham_export,
+			.import	= aspeed_sham_import,
+			.halg = {
+				.digestsize = SHA224_DIGEST_SIZE,
+				.statesize = sizeof(struct aspeed_sham_reqctx),
+				.base = {
+					.cra_name		= "sha224",
+					.cra_driver_name	= "aspeed-sha224",
+					.cra_priority		= 300,
+					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
+								  CRYPTO_ALG_ASYNC |
+								  CRYPTO_ALG_KERN_DRIVER_ONLY,
+					.cra_blocksize		= SHA224_BLOCK_SIZE,
+					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
+					.cra_alignmask		= 0,
+					.cra_module		= THIS_MODULE,
+					.cra_init		= aspeed_sham_cra_init,
+					.cra_exit		= aspeed_sham_cra_exit,
+				}
+			}
+		},
+	},
+	{
+		.alg.ahash = {
+			.init	= aspeed_sham_init,
+			.update	= aspeed_sham_update,
+			.final	= aspeed_sham_final,
+			.finup	= aspeed_sham_finup,
+			.digest	= aspeed_sham_digest,
+			.setkey	= aspeed_sham_setkey,
+			.export	= aspeed_sham_export,
+			.import	= aspeed_sham_import,
+			.halg = {
+				.digestsize = SHA1_DIGEST_SIZE,
+				.statesize = sizeof(struct aspeed_sham_reqctx),
+				.base = {
+					.cra_name		= "hmac(sha1)",
+					.cra_driver_name	= "aspeed-hmac-sha1",
+					.cra_priority		= 300,
+					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
+								  CRYPTO_ALG_ASYNC |
+								  CRYPTO_ALG_KERN_DRIVER_ONLY,
+					.cra_blocksize		= SHA1_BLOCK_SIZE,
+					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx) +
+								sizeof(struct aspeed_sha_hmac_ctx),
+					.cra_alignmask		= 0,
+					.cra_module		= THIS_MODULE,
+					.cra_init		= aspeed_sham_cra_sha1_init,
+					.cra_exit		= aspeed_sham_cra_exit,
+				}
+			}
+		},
+	},
+	{
+		.alg.ahash = {
+			.init	= aspeed_sham_init,
+			.update	= aspeed_sham_update,
+			.final	= aspeed_sham_final,
+			.finup	= aspeed_sham_finup,
+			.digest	= aspeed_sham_digest,
+			.setkey	= aspeed_sham_setkey,
+			.export	= aspeed_sham_export,
+			.import	= aspeed_sham_import,
+			.halg = {
+				.digestsize = SHA224_DIGEST_SIZE,
+				.statesize = sizeof(struct aspeed_sham_reqctx),
+				.base = {
+					.cra_name		= "hmac(sha224)",
+					.cra_driver_name	= "aspeed-hmac-sha224",
+					.cra_priority		= 300,
+					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
+								  CRYPTO_ALG_ASYNC |
+								  CRYPTO_ALG_KERN_DRIVER_ONLY,
+					.cra_blocksize		= SHA224_BLOCK_SIZE,
+					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx) +
+								sizeof(struct aspeed_sha_hmac_ctx),
+					.cra_alignmask		= 0,
+					.cra_module		= THIS_MODULE,
+					.cra_init		= aspeed_sham_cra_sha224_init,
+					.cra_exit		= aspeed_sham_cra_exit,
+				}
+			}
+		},
+	},
+	{
+		.alg.ahash = {
+			.init	= aspeed_sham_init,
+			.update	= aspeed_sham_update,
+			.final	= aspeed_sham_final,
+			.finup	= aspeed_sham_finup,
+			.digest	= aspeed_sham_digest,
+			.setkey	= aspeed_sham_setkey,
+			.export	= aspeed_sham_export,
+			.import	= aspeed_sham_import,
+			.halg = {
+				.digestsize = SHA256_DIGEST_SIZE,
+				.statesize = sizeof(struct aspeed_sham_reqctx),
+				.base = {
+					.cra_name		= "hmac(sha256)",
+					.cra_driver_name	= "aspeed-hmac-sha256",
+					.cra_priority		= 300,
+					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
+								  CRYPTO_ALG_ASYNC |
+								  CRYPTO_ALG_KERN_DRIVER_ONLY,
+					.cra_blocksize		= SHA256_BLOCK_SIZE,
+					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx) +
+								sizeof(struct aspeed_sha_hmac_ctx),
+					.cra_alignmask		= 0,
+					.cra_module		= THIS_MODULE,
+					.cra_init		= aspeed_sham_cra_sha256_init,
+					.cra_exit		= aspeed_sham_cra_exit,
+				}
+			}
+		},
+	},
+};
+
+struct aspeed_hace_alg aspeed_ahash_algs_g6[] = {
+	{
+		.alg.ahash = {
+			.init	= aspeed_sham_init,
+			.update	= aspeed_sham_update,
+			.final	= aspeed_sham_final,
+			.finup	= aspeed_sham_finup,
+			.digest	= aspeed_sham_digest,
+			.export	= aspeed_sham_export,
+			.import	= aspeed_sham_import,
+			.halg = {
+				.digestsize = SHA384_DIGEST_SIZE,
+				.statesize = sizeof(struct aspeed_sham_reqctx),
+				.base = {
+					.cra_name		= "sha384",
+					.cra_driver_name	= "aspeed-sha384",
+					.cra_priority		= 300,
+					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
+								  CRYPTO_ALG_ASYNC |
+								  CRYPTO_ALG_KERN_DRIVER_ONLY,
+					.cra_blocksize		= SHA384_BLOCK_SIZE,
+					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
+					.cra_alignmask		= 0,
+					.cra_module		= THIS_MODULE,
+					.cra_init		= aspeed_sham_cra_init,
+					.cra_exit		= aspeed_sham_cra_exit,
+				}
+			}
+		},
+	},
+	{
+		.alg.ahash = {
+			.init	= aspeed_sham_init,
+			.update	= aspeed_sham_update,
+			.final	= aspeed_sham_final,
+			.finup	= aspeed_sham_finup,
+			.digest	= aspeed_sham_digest,
+			.export	= aspeed_sham_export,
+			.import	= aspeed_sham_import,
+			.halg = {
+				.digestsize = SHA512_DIGEST_SIZE,
+				.statesize = sizeof(struct aspeed_sham_reqctx),
+				.base = {
+					.cra_name		= "sha512",
+					.cra_driver_name	= "aspeed-sha512",
+					.cra_priority		= 300,
+					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
+								  CRYPTO_ALG_ASYNC |
+								  CRYPTO_ALG_KERN_DRIVER_ONLY,
+					.cra_blocksize		= SHA512_BLOCK_SIZE,
+					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
+					.cra_alignmask		= 0,
+					.cra_module		= THIS_MODULE,
+					.cra_init		= aspeed_sham_cra_init,
+					.cra_exit		= aspeed_sham_cra_exit,
+				}
+			}
+		},
+	},
+	{
+		.alg.ahash = {
+			.init	= aspeed_sha512s_init,
+			.update	= aspeed_sham_update,
+			.final	= aspeed_sham_final,
+			.finup	= aspeed_sham_finup,
+			.digest	= aspeed_sham_digest,
+			.export	= aspeed_sham_export,
+			.import	= aspeed_sham_import,
+			.halg = {
+				.digestsize = SHA224_DIGEST_SIZE,
+				.statesize = sizeof(struct aspeed_sham_reqctx),
+				.base = {
+					.cra_name		= "sha512_224",
+					.cra_driver_name	= "aspeed-sha512_224",
+					.cra_priority		= 300,
+					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
+								  CRYPTO_ALG_ASYNC |
+								  CRYPTO_ALG_KERN_DRIVER_ONLY,
+					.cra_blocksize		= SHA512_BLOCK_SIZE,
+					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
+					.cra_alignmask		= 0,
+					.cra_module		= THIS_MODULE,
+					.cra_init		= aspeed_sham_cra_init,
+					.cra_exit		= aspeed_sham_cra_exit,
+				}
+			}
+		},
+	},
+	{
+		.alg.ahash = {
+			.init	= aspeed_sha512s_init,
+			.update	= aspeed_sham_update,
+			.final	= aspeed_sham_final,
+			.finup	= aspeed_sham_finup,
+			.digest	= aspeed_sham_digest,
+			.export	= aspeed_sham_export,
+			.import	= aspeed_sham_import,
+			.halg = {
+				.digestsize = SHA256_DIGEST_SIZE,
+				.statesize = sizeof(struct aspeed_sham_reqctx),
+				.base = {
+					.cra_name		= "sha512_256",
+					.cra_driver_name	= "aspeed-sha512_256",
+					.cra_priority		= 300,
+					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
+								  CRYPTO_ALG_ASYNC |
+								  CRYPTO_ALG_KERN_DRIVER_ONLY,
+					.cra_blocksize		= SHA512_BLOCK_SIZE,
+					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
+					.cra_alignmask		= 0,
+					.cra_module		= THIS_MODULE,
+					.cra_init		= aspeed_sham_cra_init,
+					.cra_exit		= aspeed_sham_cra_exit,
+				}
+			}
+		},
+	},
+	{
+		.alg.ahash = {
+			.init	= aspeed_sham_init,
+			.update	= aspeed_sham_update,
+			.final	= aspeed_sham_final,
+			.finup	= aspeed_sham_finup,
+			.digest	= aspeed_sham_digest,
+			.setkey	= aspeed_sham_setkey,
+			.export	= aspeed_sham_export,
+			.import	= aspeed_sham_import,
+			.halg = {
+				.digestsize = SHA384_DIGEST_SIZE,
+				.statesize = sizeof(struct aspeed_sham_reqctx),
+				.base = {
+					.cra_name		= "hmac(sha384)",
+					.cra_driver_name	= "aspeed-hmac-sha384",
+					.cra_priority		= 300,
+					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
+								  CRYPTO_ALG_ASYNC |
+								  CRYPTO_ALG_KERN_DRIVER_ONLY,
+					.cra_blocksize		= SHA384_BLOCK_SIZE,
+					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx) +
+								sizeof(struct aspeed_sha_hmac_ctx),
+					.cra_alignmask		= 0,
+					.cra_module		= THIS_MODULE,
+					.cra_init		= aspeed_sham_cra_sha384_init,
+					.cra_exit		= aspeed_sham_cra_exit,
+				}
+			}
+		},
+	},
+	{
+		.alg.ahash = {
+			.init	= aspeed_sham_init,
+			.update	= aspeed_sham_update,
+			.final	= aspeed_sham_final,
+			.finup	= aspeed_sham_finup,
+			.digest	= aspeed_sham_digest,
+			.setkey	= aspeed_sham_setkey,
+			.export	= aspeed_sham_export,
+			.import	= aspeed_sham_import,
+			.halg = {
+				.digestsize = SHA512_DIGEST_SIZE,
+				.statesize = sizeof(struct aspeed_sham_reqctx),
+				.base = {
+					.cra_name		= "hmac(sha512)",
+					.cra_driver_name	= "aspeed-hmac-sha512",
+					.cra_priority		= 300,
+					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
+								  CRYPTO_ALG_ASYNC |
+								  CRYPTO_ALG_KERN_DRIVER_ONLY,
+					.cra_blocksize		= SHA512_BLOCK_SIZE,
+					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx) +
+								sizeof(struct aspeed_sha_hmac_ctx),
+					.cra_alignmask		= 0,
+					.cra_module		= THIS_MODULE,
+					.cra_init		= aspeed_sham_cra_sha512_init,
+					.cra_exit		= aspeed_sham_cra_exit,
+				}
+			}
+		},
+	},
+	{
+		.alg.ahash = {
+			.init	= aspeed_sha512s_init,
+			.update	= aspeed_sham_update,
+			.final	= aspeed_sham_final,
+			.finup	= aspeed_sham_finup,
+			.digest	= aspeed_sham_digest,
+			.setkey	= aspeed_sham_setkey,
+			.export	= aspeed_sham_export,
+			.import	= aspeed_sham_import,
+			.halg = {
+				.digestsize = SHA224_DIGEST_SIZE,
+				.statesize = sizeof(struct aspeed_sham_reqctx),
+				.base = {
+					.cra_name		= "hmac(sha512_224)",
+					.cra_driver_name	= "aspeed-hmac-sha512_224",
+					.cra_priority		= 300,
+					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
+								  CRYPTO_ALG_ASYNC |
+								  CRYPTO_ALG_KERN_DRIVER_ONLY,
+					.cra_blocksize		= SHA512_BLOCK_SIZE,
+					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx) +
+								sizeof(struct aspeed_sha_hmac_ctx),
+					.cra_alignmask		= 0,
+					.cra_module		= THIS_MODULE,
+					.cra_init		= aspeed_sham_cra_sha512_224_init,
+					.cra_exit		= aspeed_sham_cra_exit,
+				}
+			}
+		},
+	},
+	{
+		.alg.ahash = {
+			.init	= aspeed_sha512s_init,
+			.update	= aspeed_sham_update,
+			.final	= aspeed_sham_final,
+			.finup	= aspeed_sham_finup,
+			.digest	= aspeed_sham_digest,
+			.setkey	= aspeed_sham_setkey,
+			.export	= aspeed_sham_export,
+			.import	= aspeed_sham_import,
+			.halg = {
+				.digestsize = SHA256_DIGEST_SIZE,
+				.statesize = sizeof(struct aspeed_sham_reqctx),
+				.base = {
+					.cra_name		= "hmac(sha512_256)",
+					.cra_driver_name	= "aspeed-hmac-sha512_256",
+					.cra_priority		= 300,
+					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
+								  CRYPTO_ALG_ASYNC |
+								  CRYPTO_ALG_KERN_DRIVER_ONLY,
+					.cra_blocksize		= SHA512_BLOCK_SIZE,
+					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx) +
+								sizeof(struct aspeed_sha_hmac_ctx),
+					.cra_alignmask		= 0,
+					.cra_module		= THIS_MODULE,
+					.cra_init		= aspeed_sham_cra_sha512_256_init,
+					.cra_exit		= aspeed_sham_cra_exit,
+				}
+			}
+		},
+	},
+};
+
+void aspeed_unregister_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(aspeed_ahash_algs); i++)
+		crypto_unregister_ahash(&aspeed_ahash_algs[i].alg.ahash);
+
+	if (hace_dev->version != AST2600_VERSION)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(aspeed_ahash_algs_g6); i++)
+		crypto_unregister_ahash(&aspeed_ahash_algs_g6[i].alg.ahash);
+}
+
+int aspeed_register_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
+{
+	int rc, i;
+
+	AHASH_DBG(hace_dev, "\n");
+
+	for (i = 0; i < ARRAY_SIZE(aspeed_ahash_algs); i++) {
+		aspeed_ahash_algs[i].hace_dev = hace_dev;
+		rc = crypto_register_ahash(&aspeed_ahash_algs[i].alg.ahash);
+		if (rc)
+			return rc;
+	}
+
+	if (hace_dev->version != AST2600_VERSION)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(aspeed_ahash_algs_g6); i++) {
+		aspeed_ahash_algs_g6[i].hace_dev = hace_dev;
+		rc = crypto_register_ahash(&aspeed_ahash_algs_g6[i].alg.ahash);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
diff --git a/drivers/crypto/aspeed/aspeed-hace.c b/drivers/crypto/aspeed/aspeed-hace.c
new file mode 100644
index 000000000000..f25b13d120e8
--- /dev/null
+++ b/drivers/crypto/aspeed/aspeed-hace.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2021 Aspeed Technology Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "aspeed-hace.h"
+
+// #define ASPEED_HACE_DEBUG
+#ifdef ASPEED_HACE_DEBUG
+#define HACE_DBG(d, fmt, ...)	\
+	dev_dbg((d)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
+#else
+#define HACE_DBG(d, fmt, ...)
+#endif
+
+/* Weak function for HACE hash */
+int __weak aspeed_hace_hash_handle_queue(struct aspeed_hace_dev *hace_dev,
+					 struct crypto_async_request *new_areq)
+{
+	pr_warn("%s: Not supported yet\n", __func__);
+	return -EINVAL;
+}
+
+int __weak aspeed_register_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
+{
+	pr_warn("%s: Not supported yet\n", __func__);
+	return -EINVAL;
+}
+
+void __weak aspeed_unregister_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
+{
+	pr_warn("%s: Not supported yet\n", __func__);
+}
+
+/* HACE interrupt service routine */
+static irqreturn_t aspeed_hace_irq(int irq, void *dev)
+{
+	struct aspeed_hace_dev *hace_dev = (struct aspeed_hace_dev *)dev;
+	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
+	u32 sts;
+
+	HACE_DBG("irq status: 0x%x\n", sts);
+
+	sts = ast_hace_read(hace_dev, ASPEED_HACE_STS);
+	ast_hace_write(hace_dev, sts, ASPEED_HACE_STS);
+
+	if (sts & HACE_HASH_ISR) {
+		if (hash_engine->flags & CRYPTO_FLAGS_BUSY)
+			tasklet_schedule(&hash_engine->done_task);
+		else
+			dev_warn(hace_dev->dev, "no active requests.\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void aspeed_hace_hash_done_task(unsigned long data)
+{
+	struct aspeed_hace_dev *hace_dev = (struct aspeed_hace_dev *)data;
+	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
+
+	hash_engine->resume(hace_dev);
+}
+
+static void aspeed_hace_hash_queue_task(unsigned long data)
+{
+	struct aspeed_hace_dev *hace_dev = (struct aspeed_hace_dev *)data;
+
+	aspeed_hace_hash_handle_queue(hace_dev, NULL);
+}
+
+static int aspeed_hace_register(struct aspeed_hace_dev *hace_dev)
+{
+	return aspeed_register_hace_hash_algs(hace_dev);
+}
+
+static void aspeed_hace_unregister(struct aspeed_hace_dev *hace_dev)
+{
+	aspeed_unregister_hace_hash_algs(hace_dev);
+}
+
+static const struct of_device_id aspeed_hace_of_matches[] = {
+	{ .compatible = "aspeed,ast2500-hace", .data = (void *) 5,},
+	{ .compatible = "aspeed,ast2600-hace", .data = (void *) 6,},
+	{},
+};
+
+static int aspeed_hace_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *hace_dev_id;
+	struct aspeed_engine_hash *hash_engine;
+	struct aspeed_hace_dev *hace_dev;
+	struct resource *res;
+	int rc;
+
+	hace_dev = devm_kzalloc(&pdev->dev, sizeof(struct aspeed_hace_dev),
+				GFP_KERNEL);
+	if (!hace_dev)
+		return -ENOMEM;
+
+	hace_dev_id = of_match_device(aspeed_hace_of_matches, &pdev->dev);
+	if (!hace_dev_id) {
+		dev_err(&pdev->dev, "Failed to match hace dev id\n");
+		return -EINVAL;
+	}
+
+	hace_dev->dev = &pdev->dev;
+	hace_dev->version = (unsigned long)hace_dev_id->data;
+	hash_engine = &hace_dev->hash_engine;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	platform_set_drvdata(pdev, hace_dev);
+
+	spin_lock_init(&hash_engine->lock);
+	tasklet_init(&hash_engine->done_task, aspeed_hace_hash_done_task,
+		     (unsigned long)hace_dev);
+	tasklet_init(&hash_engine->queue_task, aspeed_hace_hash_queue_task,
+		     (unsigned long)hace_dev);
+	crypto_init_queue(&hash_engine->queue, ASPEED_HASH_QUEUE_LENGTH);
+
+	hace_dev->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (!hace_dev->regs) {
+		dev_err(&pdev->dev, "Failed to map resources\n");
+		return -ENOMEM;
+	}
+
+	hace_dev->irq = platform_get_irq(pdev, 0);
+	if (!hace_dev->irq) {
+		dev_err(&pdev->dev, "Failed to get interrupt\n");
+		return -ENXIO;
+	}
+
+	rc = devm_request_irq(&pdev->dev, hace_dev->irq, aspeed_hace_irq, 0,
+			      dev_name(&pdev->dev), hace_dev);
+	if (rc) {
+		dev_err(&pdev->dev, "Failed to request interrupt\n");
+		return rc;
+	}
+
+	hace_dev->yclk = devm_clk_get(&pdev->dev, "yclk");
+	if (IS_ERR(hace_dev->yclk)) {
+		dev_err(&pdev->dev, "Failed to get yclk\n");
+		return -ENODEV;
+	}
+
+	rc = clk_prepare_enable(hace_dev->yclk);
+	if (rc) {
+		dev_err(&pdev->dev, "Failed to enable clock 0x%x\n", rc);
+		return rc;
+	}
+
+	hash_engine->ahash_src_addr =
+		dma_alloc_coherent(&pdev->dev,
+				   ASPEED_HASH_SRC_DMA_BUF_LEN,
+				   &hash_engine->ahash_src_dma_addr,
+				   GFP_KERNEL);
+	if (!hash_engine->ahash_src_addr) {
+		dev_err(&pdev->dev, "Failed to allocate dma buffer\n");
+		return -ENOMEM;
+	}
+
+	rc = aspeed_hace_register(hace_dev);
+	if (rc) {
+		dev_err(&pdev->dev, "Failed to register hash alg, rc:0x%x\n", rc);
+		rc = 0;
+	}
+
+	dev_info(&pdev->dev, "ASPEED Crypto Accelerator successfully registered\n");
+
+	return rc;
+}
+
+static int aspeed_hace_remove(struct platform_device *pdev)
+{
+	struct aspeed_hace_dev *hace_dev = platform_get_drvdata(pdev);
+	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
+
+	aspeed_hace_unregister(hace_dev);
+
+	tasklet_kill(&hash_engine->done_task);
+	tasklet_kill(&hash_engine->queue_task);
+
+	return 0;
+}
+
+MODULE_DEVICE_TABLE(of, aspeed_hace_of_matches);
+
+static struct platform_driver aspeed_hace_driver = {
+	.probe		= aspeed_hace_probe,
+	.remove		= aspeed_hace_remove,
+	.driver         = {
+		.name   = KBUILD_MODNAME,
+		.of_match_table = aspeed_hace_of_matches,
+	},
+};
+
+module_platform_driver(aspeed_hace_driver);
+
+MODULE_AUTHOR("Neal Liu <neal_liu@aspeedtech.com>");
+MODULE_DESCRIPTION("ASPEED HACE driver Crypto Accelerator");
+MODULE_LICENSE("GPL");
diff --git a/drivers/crypto/aspeed/aspeed-hace.h b/drivers/crypto/aspeed/aspeed-hace.h
new file mode 100644
index 000000000000..0a16d48e78ac
--- /dev/null
+++ b/drivers/crypto/aspeed/aspeed-hace.h
@@ -0,0 +1,179 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __ASPEED_HACE_H__
+#define __ASPEED_HACE_H__
+
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/fips.h>
+#include <linux/dma-mapping.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/internal/aead.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/kpp.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/algapi.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+
+/*****************************
+ *                           *
+ * HACE register definitions *
+ *                           *
+ * ***************************/
+
+#define ASPEED_HACE_STS			0x1C	/* HACE Status Register */
+#define ASPEED_HACE_HASH_SRC		0x20	/* Hash Data Source Base Address Register */
+#define ASPEED_HACE_HASH_DIGEST_BUFF	0x24	/* Hash Digest Write Buffer Base Address Register */
+#define ASPEED_HACE_HASH_KEY_BUFF	0x28	/* Hash HMAC Key Buffer Base Address Register */
+#define ASPEED_HACE_HASH_DATA_LEN	0x2C	/* Hash Data Length Register */
+#define ASPEED_HACE_HASH_CMD		0x30	/* Hash Engine Command Register */
+
+/* interrupt status reg */
+#define  HACE_HASH_ISR			BIT(9)
+#define  HACE_HASH_BUSY			BIT(0)
+
+/* hash cmd reg */
+#define  HASH_CMD_MBUS_REQ_SYNC_EN	BIT(20)
+#define  HASH_CMD_HASH_SRC_SG_CTRL	BIT(18)
+#define  HASH_CMD_SHA512_224		(0x3 << 10)
+#define  HASH_CMD_SHA512_256		(0x2 << 10)
+#define  HASH_CMD_SHA384		(0x1 << 10)
+#define  HASH_CMD_SHA512		(0)
+#define  HASH_CMD_INT_ENABLE		BIT(9)
+#define  HASH_CMD_HMAC			(0x1 << 7)
+#define  HASH_CMD_ACC_MODE		(0x2 << 7)
+#define  HASH_CMD_HMAC_KEY		(0x3 << 7)
+#define  HASH_CMD_SHA1			(0x2 << 4)
+#define  HASH_CMD_SHA224		(0x4 << 4)
+#define  HASH_CMD_SHA256		(0x5 << 4)
+#define  HASH_CMD_SHA512_SER		(0x6 << 4)
+#define  HASH_CMD_SHA_SWAP		(0x2 << 2)
+
+#define CRYPTO_FLAGS_BUSY		BIT(1)
+
+#define SHA_OP_UPDATE			1
+#define SHA_OP_FINAL			2
+
+#define SHA_FLAGS_SHA1			BIT(0)
+#define SHA_FLAGS_SHA224		BIT(1)
+#define SHA_FLAGS_SHA256		BIT(2)
+#define SHA_FLAGS_SHA384		BIT(3)
+#define SHA_FLAGS_SHA512		BIT(4)
+#define SHA_FLAGS_SHA512_224		BIT(5)
+#define SHA_FLAGS_SHA512_256		BIT(6)
+#define SHA_FLAGS_HMAC			BIT(8)
+#define SHA_FLAGS_FINUP			BIT(9)
+#define SHA_FLAGS_MASK			(0xff)
+
+#define ASPEED_CRYPTO_SRC_DMA_BUF_LEN	0xa000
+#define ASPEED_CRYPTO_DST_DMA_BUF_LEN	0xa000
+#define ASPEED_CRYPTO_GCM_TAG_OFFSET	0x9ff0
+#define ASPEED_HASH_SRC_DMA_BUF_LEN	0xa000
+#define ASPEED_HASH_QUEUE_LENGTH	50
+
+struct aspeed_hace_dev;
+
+typedef int (*aspeed_hace_fn_t)(struct aspeed_hace_dev *);
+
+struct aspeed_sg_list {
+	u32 len;
+	u32 phy_addr;
+};
+
+struct aspeed_engine_hash {
+	struct crypto_queue		queue;
+	struct tasklet_struct		done_task;
+	struct tasklet_struct		queue_task;
+	spinlock_t			lock;
+	unsigned long			flags;
+
+	struct ahash_request		*ahash_req;
+	void				*ahash_src_addr;
+	dma_addr_t			ahash_src_dma_addr;
+
+	dma_addr_t			src_dma;
+	size_t				src_length;
+	dma_addr_t			digest_dma;
+
+	/* callback func */
+	aspeed_hace_fn_t		resume;
+	aspeed_hace_fn_t		dma_prepare;
+};
+
+struct aspeed_sha_hmac_ctx {
+	struct crypto_shash *shash;
+	u8 ipad[SHA512_BLOCK_SIZE];
+	u8 opad[SHA512_BLOCK_SIZE];
+};
+
+struct aspeed_sham_ctx {
+	struct aspeed_hace_dev		*hace_dev;
+	unsigned long			flags;	/* hmac flag */
+
+	/* fallback stuff */
+	struct aspeed_sha_hmac_ctx	base[0];
+};
+
+struct aspeed_sham_reqctx {
+	unsigned long		flags;		/* final update flag should no use*/
+	unsigned long		op;		/* final or update */
+	u32			cmd;		/* trigger cmd */
+
+	dma_addr_t		digest_dma_addr;
+	u8			digest[SHA512_DIGEST_SIZE] __aligned(64);
+	u64			digcnt[2];
+	size_t			digsize;
+
+	/* walk state */
+	struct scatterlist	*src_sg;
+	int			src_nents;
+	unsigned int		offset;		/* offset in current sg */
+	unsigned int		total;		/* per update length */
+
+	size_t			block_size;
+
+	dma_addr_t		buffer_dma_addr;
+	size_t			bufcnt;		/* buffer counter */
+	u8			buffer[SHA512_BLOCK_SIZE * 2];
+};
+
+struct aspeed_hace_dev {
+	void __iomem			*regs;
+	void __iomem			*sec_regs;
+	struct device			*dev;
+	int				irq;
+	struct clk			*yclk;
+	struct clk			*rsaclk;
+	unsigned long			version;
+	struct aspeed_engine_hash	hash_engine;
+};
+
+struct aspeed_hace_alg {
+	struct aspeed_hace_dev		*hace_dev;
+	union {
+		struct skcipher_alg	skcipher;
+		struct aead_alg		aead;
+		struct ahash_alg	ahash;
+		struct kpp_alg		kpp;
+		struct akcipher_alg	akcipher;
+	} alg;
+};
+
+enum aspeed_version {
+	AST2500_VERSION = 5,
+	AST2600_VERSION
+};
+
+#define ast_hace_write(hace, val, offset)	\
+	writel((val), (hace)->regs + (offset))
+#define ast_hace_read(hace, offset)		\
+	readl((hace)->regs + (offset))
+
+int aspeed_hace_hash_handle_queue(struct aspeed_hace_dev *hace_dev,
+				  struct crypto_async_request *new_areq);
+int aspeed_register_hace_hash_algs(struct aspeed_hace_dev *hace_dev);
+void aspeed_unregister_hace_hash_algs(struct aspeed_hace_dev *hace_dev);
+
+#endif
-- 
2.25.1

