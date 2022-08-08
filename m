Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A418058C1E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiHHCxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiHHCxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:53:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D96388B;
        Sun,  7 Aug 2022 19:53:03 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M1LLC6DynzmVN5;
        Mon,  8 Aug 2022 10:50:59 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 8 Aug 2022 10:53:01 +0800
Received: from [10.67.102.118] (10.67.102.118) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 8 Aug 2022 10:53:00 +0800
Subject: Re: [PATCH v8 1/5] crypto: aspeed: Add HACE hash driver
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
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
References: <20220726113448.2964968-1-neal_liu@aspeedtech.com>
 <20220726113448.2964968-2-neal_liu@aspeedtech.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <5ca081b1-9a96-5b58-7a27-75c94af119d2@huawei.com>
Date:   Mon, 8 Aug 2022 10:53:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220726113448.2964968-2-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/26 19:34, Neal Liu wrote:
> Hash and Crypto Engine (HACE) is designed to accelerate the
> throughput of hash data digest, encryption, and decryption.
> 
> Basically, HACE can be divided into two independently engines
> - Hash Engine and Crypto Engine. This patch aims to add HACE
> hash engine driver for hash accelerator.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> ---
>  MAINTAINERS                              |    7 +
>  drivers/crypto/Kconfig                   |    1 +
>  drivers/crypto/Makefile                  |    1 +
>  drivers/crypto/aspeed/Kconfig            |   32 +
>  drivers/crypto/aspeed/Makefile           |    6 +
>  drivers/crypto/aspeed/aspeed-hace-hash.c | 1389 ++++++++++++++++++++++
>  drivers/crypto/aspeed/aspeed-hace.c      |  213 ++++
>  drivers/crypto/aspeed/aspeed-hace.h      |  186 +++
>  8 files changed, 1835 insertions(+)
>  create mode 100644 drivers/crypto/aspeed/Kconfig
>  create mode 100644 drivers/crypto/aspeed/Makefile
>  create mode 100644 drivers/crypto/aspeed/aspeed-hace-hash.c
>  create mode 100644 drivers/crypto/aspeed/aspeed-hace.c
>  create mode 100644 drivers/crypto/aspeed/aspeed-hace.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f55aea311af5..23a0215b7e42 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3140,6 +3140,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/media/aspeed-video.txt
>  F:	drivers/media/platform/aspeed/
>  
> +ASPEED CRYPTO DRIVER
> +M:	Neal Liu <neal_liu@aspeedtech.com>
> +L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml
> +F:	drivers/crypto/aspeed/
> +
>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>  M:	Corentin Chary <corentin.chary@gmail.com>
>  L:	acpi4asus-user@lists.sourceforge.net
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index ee99c02c84e8..b9f5ee126881 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -933,5 +933,6 @@ config CRYPTO_DEV_SA2UL
>  	  acceleration for cryptographic algorithms on these devices.
>  
>  source "drivers/crypto/keembay/Kconfig"
> +source "drivers/crypto/aspeed/Kconfig"
>  
>  endif # CRYPTO_HW
> diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
> index f81703a86b98..116de173a66c 100644
> --- a/drivers/crypto/Makefile
> +++ b/drivers/crypto/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CRYPTO_DEV_ALLWINNER) += allwinner/
> +obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed/
>  obj-$(CONFIG_CRYPTO_DEV_ATMEL_AES) += atmel-aes.o
>  obj-$(CONFIG_CRYPTO_DEV_ATMEL_SHA) += atmel-sha.o
>  obj-$(CONFIG_CRYPTO_DEV_ATMEL_TDES) += atmel-tdes.o
> diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
> new file mode 100644
> index 000000000000..059e627efef8
> --- /dev/null
> +++ b/drivers/crypto/aspeed/Kconfig
> @@ -0,0 +1,32 @@
> +config CRYPTO_DEV_ASPEED
> +	tristate "Support for Aspeed cryptographic engine driver"
> +	depends on ARCH_ASPEED
> +	help
> +	  Hash and Crypto Engine (HACE) is designed to accelerate the
> +	  throughput of hash data digest, encryption and decryption.
> +
> +	  Select y here to have support for the cryptographic driver
> +	  available on Aspeed SoC.
> +
> +config CRYPTO_DEV_ASPEED_HACE_HASH
> +	bool "Enable Aspeed Hash & Crypto Engine (HACE) hash"
> +	depends on CRYPTO_DEV_ASPEED
> +	select CRYPTO_ENGINE
> +	select CRYPTO_SHA1
> +	select CRYPTO_SHA256
> +	select CRYPTO_SHA512
> +	select CRYPTO_HMAC
> +	help
> +	  Select here to enable Aspeed Hash & Crypto Engine (HACE)
> +	  hash driver.
> +	  Supports multiple message digest standards, including
> +	  SHA-1, SHA-224, SHA-256, SHA-384, SHA-512, and so on.
> +
> +config CRYPTO_DEV_ASPEED_HACE_HASH_DEBUG
> +	bool "Enable HACE hash debug messages"
> +	depends on CRYPTO_DEV_ASPEED_HACE_HASH
> +	help
> +	  Print HACE hash debugging messages if you use this option
> +	  to ask for those messages.
> +	  Avoid enabling this option for production build to
> +	  minimize driver timing.
> diff --git a/drivers/crypto/aspeed/Makefile b/drivers/crypto/aspeed/Makefile
> new file mode 100644
> index 000000000000..8bc8d4fed5a9
> --- /dev/null
> +++ b/drivers/crypto/aspeed/Makefile
> @@ -0,0 +1,6 @@
> +obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
> +aspeed_crypto-objs := aspeed-hace.o \
> +		      $(hace-hash-y)
> +
> +obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) += aspeed-hace-hash.o
> +hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) := aspeed-hace-hash.o
> diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c b/drivers/crypto/aspeed/aspeed-hace-hash.c
> new file mode 100644
> index 000000000000..63a8ad694996
> --- /dev/null
> +++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
> @@ -0,0 +1,1389 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2021 Aspeed Technology Inc.
> + */
> +
> +#include "aspeed-hace.h"
> +
> +#ifdef CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH_DEBUG
> +#define AHASH_DBG(h, fmt, ...)	\
> +	dev_info((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
> +#else
> +#define AHASH_DBG(h, fmt, ...)	\
> +	dev_dbg((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
> +#endif
> +
> +/* Initialization Vectors for SHA-family */
> +static const __be32 sha1_iv[8] = {
> +	cpu_to_be32(SHA1_H0), cpu_to_be32(SHA1_H1),
> +	cpu_to_be32(SHA1_H2), cpu_to_be32(SHA1_H3),
> +	cpu_to_be32(SHA1_H4), 0, 0, 0
> +};
> +
> +static const __be32 sha224_iv[8] = {
> +	cpu_to_be32(SHA224_H0), cpu_to_be32(SHA224_H1),
> +	cpu_to_be32(SHA224_H2), cpu_to_be32(SHA224_H3),
> +	cpu_to_be32(SHA224_H4), cpu_to_be32(SHA224_H5),
> +	cpu_to_be32(SHA224_H6), cpu_to_be32(SHA224_H7),
> +};
> +
> +static const __be32 sha256_iv[8] = {
> +	cpu_to_be32(SHA256_H0), cpu_to_be32(SHA256_H1),
> +	cpu_to_be32(SHA256_H2), cpu_to_be32(SHA256_H3),
> +	cpu_to_be32(SHA256_H4), cpu_to_be32(SHA256_H5),
> +	cpu_to_be32(SHA256_H6), cpu_to_be32(SHA256_H7),
> +};
> +
> +static const __be64 sha384_iv[8] = {
> +	cpu_to_be64(SHA384_H0), cpu_to_be64(SHA384_H1),
> +	cpu_to_be64(SHA384_H2), cpu_to_be64(SHA384_H3),
> +	cpu_to_be64(SHA384_H4), cpu_to_be64(SHA384_H5),
> +	cpu_to_be64(SHA384_H6), cpu_to_be64(SHA384_H7)
> +};
> +
> +static const __be64 sha512_iv[8] = {
> +	cpu_to_be64(SHA512_H0), cpu_to_be64(SHA512_H1),
> +	cpu_to_be64(SHA512_H2), cpu_to_be64(SHA512_H3),
> +	cpu_to_be64(SHA512_H4), cpu_to_be64(SHA512_H5),
> +	cpu_to_be64(SHA512_H6), cpu_to_be64(SHA512_H7)
> +};
> +
> +static const __be32 sha512_224_iv[16] = {
> +	cpu_to_be32(0xC8373D8CUL), cpu_to_be32(0xA24D5419UL),
> +	cpu_to_be32(0x6699E173UL), cpu_to_be32(0xD6D4DC89UL),
> +	cpu_to_be32(0xAEB7FA1DUL), cpu_to_be32(0x829CFF32UL),
> +	cpu_to_be32(0x14D59D67UL), cpu_to_be32(0xCF9F2F58UL),
> +	cpu_to_be32(0x692B6D0FUL), cpu_to_be32(0xA84DD47BUL),
> +	cpu_to_be32(0x736FE377UL), cpu_to_be32(0x4289C404UL),
> +	cpu_to_be32(0xA8859D3FUL), cpu_to_be32(0xC8361D6AUL),
> +	cpu_to_be32(0xADE61211UL), cpu_to_be32(0xA192D691UL)
> +};
> +
> +static const __be32 sha512_256_iv[16] = {
> +	cpu_to_be32(0x94213122UL), cpu_to_be32(0x2CF72BFCUL),
> +	cpu_to_be32(0xA35F559FUL), cpu_to_be32(0xC2644CC8UL),
> +	cpu_to_be32(0x6BB89323UL), cpu_to_be32(0x51B1536FUL),
> +	cpu_to_be32(0x19773896UL), cpu_to_be32(0xBDEA4059UL),
> +	cpu_to_be32(0xE23E2896UL), cpu_to_be32(0xE3FF8EA8UL),
> +	cpu_to_be32(0x251E5EBEUL), cpu_to_be32(0x92398653UL),
> +	cpu_to_be32(0xFC99012BUL), cpu_to_be32(0xAAB8852CUL),
> +	cpu_to_be32(0xDC2DB70EUL), cpu_to_be32(0xA22CC581UL)
> +};
> +
> +/* The purpose of this padding is to ensure that the padded message is a
> + * multiple of 512 bits (SHA1/SHA224/SHA256) or 1024 bits (SHA384/SHA512).
> + * The bit "1" is appended at the end of the message followed by
> + * "padlen-1" zero bits. Then a 64 bits block (SHA1/SHA224/SHA256) or
> + * 128 bits block (SHA384/SHA512) equals to the message length in bits
> + * is appended.
> + *
> + * For SHA1/SHA224/SHA256, padlen is calculated as followed:
> + *  - if message length < 56 bytes then padlen = 56 - message length
> + *  - else padlen = 64 + 56 - message length
> + *
> + * For SHA384/SHA512, padlen is calculated as followed:
> + *  - if message length < 112 bytes then padlen = 112 - message length
> + *  - else padlen = 128 + 112 - message length
> + */
> +static void aspeed_ahash_fill_padding(struct aspeed_hace_dev *hace_dev,
> +				      struct aspeed_sham_reqctx *rctx)
> +{
> +	unsigned int index, padlen;
> +	__be64 bits[2];
> +
> +	AHASH_DBG(hace_dev, "rctx flags:0x%x\n", (u32)rctx->flags);
> +
> +	switch (rctx->flags & SHA_FLAGS_MASK) {
> +	case SHA_FLAGS_SHA1:
> +	case SHA_FLAGS_SHA224:
> +	case SHA_FLAGS_SHA256:
> +		bits[0] = cpu_to_be64(rctx->digcnt[0] << 3);
> +		index = rctx->bufcnt & 0x3f;
> +		padlen = (index < 56) ? (56 - index) : ((64 + 56) - index);
> +		*(rctx->buffer + rctx->bufcnt) = 0x80;
> +		memset(rctx->buffer + rctx->bufcnt + 1, 0, padlen - 1);
> +		memcpy(rctx->buffer + rctx->bufcnt + padlen, bits, 8);
> +		rctx->bufcnt += padlen + 8;
> +		break;
> +	default:
> +		bits[1] = cpu_to_be64(rctx->digcnt[0] << 3);
> +		bits[0] = cpu_to_be64(rctx->digcnt[1] << 3 |
> +				      rctx->digcnt[0] >> 61);
> +		index = rctx->bufcnt & 0x7f;
> +		padlen = (index < 112) ? (112 - index) : ((128 + 112) - index);
> +		*(rctx->buffer + rctx->bufcnt) = 0x80;
> +		memset(rctx->buffer + rctx->bufcnt + 1, 0, padlen - 1);
> +		memcpy(rctx->buffer + rctx->bufcnt + padlen, bits, 16);
> +		rctx->bufcnt += padlen + 16;
> +		break;
> +	}
> +}
> +
> +/*
> + * Prepare DMA buffer before hardware engine
> + * processing.
> + */
> +static int aspeed_ahash_dma_prepare(struct aspeed_hace_dev *hace_dev)
> +{
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	struct ahash_request *req = hash_engine->req;
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +	int length, remain;
> +
> +	length = rctx->total + rctx->bufcnt;
> +	remain = length % rctx->block_size;
> +
> +	AHASH_DBG(hace_dev, "length:0x%x, remain:0x%x\n", length, remain);
> +
> +	if (rctx->bufcnt)
> +		memcpy(hash_engine->ahash_src_addr, rctx->buffer, rctx->bufcnt);
> +
> +	if (rctx->total + rctx->bufcnt < ASPEED_CRYPTO_SRC_DMA_BUF_LEN) {
> +		scatterwalk_map_and_copy(hash_engine->ahash_src_addr +
> +					 rctx->bufcnt, rctx->src_sg,
> +					 rctx->offset, rctx->total - remain, 0);
> +		rctx->offset += rctx->total - remain;
> +
> +	} else {
> +		dev_warn(hace_dev->dev, "Hash data length is too large\n");
> +		return -EINVAL;
> +	}
> +
> +	scatterwalk_map_and_copy(rctx->buffer, rctx->src_sg,
> +				 rctx->offset, remain, 0);
> +
> +	rctx->bufcnt = remain;
> +	rctx->digest_dma_addr = dma_map_single(hace_dev->dev, rctx->digest,
> +					       SHA512_DIGEST_SIZE,
> +					       DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(hace_dev->dev, rctx->digest_dma_addr)) {
> +		dev_warn(hace_dev->dev, "dma_map() rctx digest error\n");
> +		return -ENOMEM;
> +	}
> +
> +	hash_engine->src_length = length - remain;
> +	hash_engine->src_dma = hash_engine->ahash_src_dma_addr;
> +	hash_engine->digest_dma = rctx->digest_dma_addr;
> +
> +	return 0;
> +}
> +
> +/*
> + * Prepare DMA buffer as SG list buffer before
> + * hardware engine processing.
> + */
> +static int aspeed_ahash_dma_prepare_sg(struct aspeed_hace_dev *hace_dev)
> +{
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	struct ahash_request *req = hash_engine->req;
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +	struct aspeed_sg_list *src_list;
> +	struct scatterlist *s;
> +	int length, remain, sg_len, i;
> +	int rc = 0;
> +
> +	remain = (rctx->total + rctx->bufcnt) % rctx->block_size;
> +	length = rctx->total + rctx->bufcnt - remain;
> +
> +	AHASH_DBG(hace_dev, "%s:0x%x, %s:0x%x, %s:0x%x, %s:0x%x\n",
> +		  "rctx total", rctx->total, "bufcnt", rctx->bufcnt,
> +		  "length", length, "remain", remain);
> +
> +	sg_len = dma_map_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
> +			    DMA_TO_DEVICE);
> +	if (!sg_len) {
> +		dev_warn(hace_dev->dev, "dma_map_sg() src error\n");
> +		rc = -ENOMEM;
> +		goto end;
> +	}
> +
> +	src_list = (struct aspeed_sg_list *)hash_engine->ahash_src_addr;
> +	rctx->digest_dma_addr = dma_map_single(hace_dev->dev, rctx->digest,
> +					       SHA512_DIGEST_SIZE,
> +					       DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(hace_dev->dev, rctx->digest_dma_addr)) {
> +		dev_warn(hace_dev->dev, "dma_map() rctx digest error\n");
> +		rc = -ENOMEM;
> +		goto free_src_sg;
> +	}
> +
> +	if (rctx->bufcnt != 0) {
> +		rctx->buffer_dma_addr = dma_map_single(hace_dev->dev,
> +						       rctx->buffer,
> +						       rctx->block_size * 2,
> +						       DMA_TO_DEVICE);
> +		if (dma_mapping_error(hace_dev->dev, rctx->buffer_dma_addr)) {
> +			dev_warn(hace_dev->dev, "dma_map() rctx buffer error\n");
> +			rc = -ENOMEM;
> +			goto free_rctx_digest;
> +		}
> +
> +		src_list[0].phy_addr = rctx->buffer_dma_addr;
> +		src_list[0].len = rctx->bufcnt;
> +		length -= src_list[0].len;
> +
> +		/* Last sg list */
> +		if (length == 0)
> +			src_list[0].len |= HASH_SG_LAST_LIST;
> +
> +		src_list[0].phy_addr = cpu_to_le32(src_list[0].phy_addr);
> +		src_list[0].len = cpu_to_le32(src_list[0].len);
> +		src_list++;
> +	}
> +
> +	if (length != 0) {
> +		for_each_sg(rctx->src_sg, s, sg_len, i) {
> +			src_list[i].phy_addr = sg_dma_address(s);
> +
> +			if (length > sg_dma_len(s)) {
> +				src_list[i].len = sg_dma_len(s);
> +				length -= sg_dma_len(s);
> +
> +			} else {
> +				/* Last sg list */
> +				src_list[i].len = length;
> +				src_list[i].len |= HASH_SG_LAST_LIST;
> +				length = 0;
> +			}
> +
> +			src_list[i].phy_addr = cpu_to_le32(src_list[i].phy_addr);
> +			src_list[i].len = cpu_to_le32(src_list[i].len);
> +		}
> +	}
> +
> +	if (length != 0) {
> +		rc = -EINVAL;
> +		goto free_rctx_buffer;
> +	}
> +
> +	rctx->offset = rctx->total - remain;
> +	hash_engine->src_length = rctx->total + rctx->bufcnt - remain;
> +	hash_engine->src_dma = hash_engine->ahash_src_dma_addr;
> +	hash_engine->digest_dma = rctx->digest_dma_addr;
> +
> +	goto end;
Exiting via "goto xx" is not recommended in normal code logic (this requires two jumps),
exiting via "return 0" is more efficient.
This code method has many times in your entire driver, it is recommended to modify it.
> +
> +free_rctx_buffer:
> +	if (rctx->bufcnt != 0)
> +		dma_unmap_single(hace_dev->dev, rctx->buffer_dma_addr,
> +				 rctx->block_size * 2, DMA_TO_DEVICE);
> +free_rctx_digest:
> +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
> +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
> +free_src_sg:
> +	dma_unmap_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
> +		     DMA_TO_DEVICE);
> +end:
> +	return rc;
> +}
> +
> +static int aspeed_ahash_complete(struct aspeed_hace_dev *hace_dev)
> +{
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	struct ahash_request *req = hash_engine->req;
> +
> +	AHASH_DBG(hace_dev, "\n");
> +
> +	hash_engine->flags &= ~CRYPTO_FLAGS_BUSY;
> +
> +	crypto_finalize_hash_request(hace_dev->crypt_engine_hash, req, 0);
> +
> +	return 0;
> +}
> +
> +/*
> + * Copy digest to the corresponding request result.
> + * This function will be called at final() stage.
> + */
> +static int aspeed_ahash_transfer(struct aspeed_hace_dev *hace_dev)
> +{
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	struct ahash_request *req = hash_engine->req;
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +
> +	AHASH_DBG(hace_dev, "\n");
> +
> +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
> +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
> +
> +	dma_unmap_single(hace_dev->dev, rctx->buffer_dma_addr,
> +			 rctx->block_size * 2, DMA_TO_DEVICE);
> +
> +	memcpy(req->result, rctx->digest, rctx->digsize);
> +
> +	return aspeed_ahash_complete(hace_dev);
> +}
> +
> +/*
> + * Trigger hardware engines to do the math.
> + */
> +static int aspeed_hace_ahash_trigger(struct aspeed_hace_dev *hace_dev,
> +				     aspeed_hace_fn_t resume)
> +{
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	struct ahash_request *req = hash_engine->req;
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +
> +	AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x, length:0x%x\n",
> +		  hash_engine->src_dma, hash_engine->digest_dma,
> +		  hash_engine->src_length);
> +
> +	rctx->cmd |= HASH_CMD_INT_ENABLE;
> +	hash_engine->resume = resume;
> +
> +	ast_hace_write(hace_dev, hash_engine->src_dma, ASPEED_HACE_HASH_SRC);
> +	ast_hace_write(hace_dev, hash_engine->digest_dma,
> +		       ASPEED_HACE_HASH_DIGEST_BUFF);
> +	ast_hace_write(hace_dev, hash_engine->digest_dma,
> +		       ASPEED_HACE_HASH_KEY_BUFF);
> +	ast_hace_write(hace_dev, hash_engine->src_length,
> +		       ASPEED_HACE_HASH_DATA_LEN);
> +
> +	/* Memory barrier to ensure all data setup before engine starts */
> +	mb();
> +
> +	ast_hace_write(hace_dev, rctx->cmd, ASPEED_HACE_HASH_CMD);
A hardware service sending requires 5 hardware commands to complete.
In a multi-concurrency scenario, how to ensure the order of commands?
(If two processes send hardware task at the same time,
How to ensure that the hardware recognizes which task the current
command belongs to?)
> +
> +	return -EINPROGRESS;
> +}
> +
> +/*
> + * HMAC resume aims to do the second pass produces
> + * the final HMAC code derived from the inner hash
> + * result and the outer key.
> + */
> +static int aspeed_ahash_hmac_resume(struct aspeed_hace_dev *hace_dev)
> +{
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	struct ahash_request *req = hash_engine->req;
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
> +	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
> +	struct aspeed_sha_hmac_ctx *bctx = tctx->base;
> +	int rc = 0;
> +
> +	AHASH_DBG(hace_dev, "\n");
> +
> +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
> +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
> +
> +	dma_unmap_single(hace_dev->dev, rctx->buffer_dma_addr,
> +			 rctx->block_size * 2, DMA_TO_DEVICE);
> +
> +	/* o key pad + hash sum 1 */
> +	memcpy(rctx->buffer, bctx->opad, rctx->block_size);
> +	memcpy(rctx->buffer + rctx->block_size, rctx->digest, rctx->digsize);
> +
> +	rctx->bufcnt = rctx->block_size + rctx->digsize;
> +	rctx->digcnt[0] = rctx->block_size + rctx->digsize;
> +
> +	aspeed_ahash_fill_padding(hace_dev, rctx);
> +	memcpy(rctx->digest, rctx->sha_iv, rctx->ivsize);
> +
> +	rctx->digest_dma_addr = dma_map_single(hace_dev->dev, rctx->digest,
> +					       SHA512_DIGEST_SIZE,
> +					       DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(hace_dev->dev, rctx->digest_dma_addr)) {
> +		dev_warn(hace_dev->dev, "dma_map() rctx digest error\n");
> +		rc = -ENOMEM;
> +		goto end;
> +	}
> +
> +	rctx->buffer_dma_addr = dma_map_single(hace_dev->dev, rctx->buffer,
> +					       rctx->block_size * 2,
> +					       DMA_TO_DEVICE);
> +	if (dma_mapping_error(hace_dev->dev, rctx->buffer_dma_addr)) {
> +		dev_warn(hace_dev->dev, "dma_map() rctx buffer error\n");
> +		rc = -ENOMEM;
> +		goto free_rctx_digest;
> +	}
> +
> +	hash_engine->src_dma = rctx->buffer_dma_addr;
> +	hash_engine->src_length = rctx->bufcnt;
> +	hash_engine->digest_dma = rctx->digest_dma_addr;
> +
> +	return aspeed_hace_ahash_trigger(hace_dev, aspeed_ahash_transfer);
> +
> +free_rctx_digest:
> +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
> +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
> +end:
> +	return rc;
> +}
> +
> +static int aspeed_ahash_req_final(struct aspeed_hace_dev *hace_dev)
> +{
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	struct ahash_request *req = hash_engine->req;
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +	int rc = 0;
> +
> +	AHASH_DBG(hace_dev, "\n");
> +
> +	aspeed_ahash_fill_padding(hace_dev, rctx);
> +
> +	rctx->digest_dma_addr = dma_map_single(hace_dev->dev,
> +					       rctx->digest,
> +					       SHA512_DIGEST_SIZE,
> +					       DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(hace_dev->dev, rctx->digest_dma_addr)) {
> +		dev_warn(hace_dev->dev, "dma_map() rctx digest error\n");
> +		rc = -ENOMEM;
> +		goto end;
> +	}
> +
> +	rctx->buffer_dma_addr = dma_map_single(hace_dev->dev,
> +					       rctx->buffer,
> +					       rctx->block_size * 2,
> +					       DMA_TO_DEVICE);
> +	if (dma_mapping_error(hace_dev->dev, rctx->buffer_dma_addr)) {
> +		dev_warn(hace_dev->dev, "dma_map() rctx buffer error\n");
> +		rc = -ENOMEM;
> +		goto free_rctx_digest;
> +	}
> +
> +	hash_engine->src_dma = rctx->buffer_dma_addr;
> +	hash_engine->src_length = rctx->bufcnt;
> +	hash_engine->digest_dma = rctx->digest_dma_addr;
> +
> +	if (rctx->flags & SHA_FLAGS_HMAC)
> +		return aspeed_hace_ahash_trigger(hace_dev,
> +						 aspeed_ahash_hmac_resume);
> +
> +	return aspeed_hace_ahash_trigger(hace_dev, aspeed_ahash_transfer);
> +
> +free_rctx_digest:
> +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
> +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
> +end:
> +	return rc;
> +}
> +
> +static int aspeed_ahash_update_resume_sg(struct aspeed_hace_dev *hace_dev)
> +{
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	struct ahash_request *req = hash_engine->req;
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +
> +	AHASH_DBG(hace_dev, "\n");
> +
> +	dma_unmap_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
> +		     DMA_TO_DEVICE);
> +
> +	if (rctx->bufcnt != 0)
> +		dma_unmap_single(hace_dev->dev, rctx->buffer_dma_addr,
> +				 rctx->block_size * 2,
> +				 DMA_TO_DEVICE);
> +
> +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
> +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
> +
> +	scatterwalk_map_and_copy(rctx->buffer, rctx->src_sg, rctx->offset,
> +				 rctx->total - rctx->offset, 0);
> +
> +	rctx->bufcnt = rctx->total - rctx->offset;
> +	rctx->cmd &= ~HASH_CMD_HASH_SRC_SG_CTRL;
> +
> +	if (rctx->flags & SHA_FLAGS_FINUP)
> +		return aspeed_ahash_req_final(hace_dev);
> +
> +	return aspeed_ahash_complete(hace_dev);
> +}
> +
> +static int aspeed_ahash_update_resume(struct aspeed_hace_dev *hace_dev)
> +{
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	struct ahash_request *req = hash_engine->req;
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +
> +	AHASH_DBG(hace_dev, "\n");
> +
> +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
> +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
> +
> +	if (rctx->flags & SHA_FLAGS_FINUP)
> +		return aspeed_ahash_req_final(hace_dev);
> +
> +	return aspeed_ahash_complete(hace_dev);
> +}
> +
> +static int aspeed_ahash_req_update(struct aspeed_hace_dev *hace_dev)
> +{
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	struct ahash_request *req = hash_engine->req;
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +	aspeed_hace_fn_t resume;
> +	int ret;
> +
> +	AHASH_DBG(hace_dev, "\n");
> +
> +	if (hace_dev->version == AST2600_VERSION) {
> +		rctx->cmd |= HASH_CMD_HASH_SRC_SG_CTRL;
> +		resume = aspeed_ahash_update_resume_sg;
> +
> +	} else {
> +		resume = aspeed_ahash_update_resume;
> +	}
> +
> +	ret = hash_engine->dma_prepare(hace_dev);
> +	if (ret)
> +		return ret;
> +
> +	return aspeed_hace_ahash_trigger(hace_dev, resume);
> +}
> +
> +static int aspeed_hace_hash_handle_queue(struct aspeed_hace_dev *hace_dev,
> +				  struct ahash_request *req)
> +{
> +	return crypto_transfer_hash_request_to_engine(
> +			hace_dev->crypt_engine_hash, req);
> +}
> +
> +static int aspeed_ahash_do_request(struct crypto_engine *engine, void *areq)
> +{
> +	struct ahash_request *req = ahash_request_cast(areq);
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
> +	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
> +	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
> +	struct aspeed_engine_hash *hash_engine;
> +	int ret = 0;
> +
> +	hash_engine = &hace_dev->hash_engine;
> +	hash_engine->flags |= CRYPTO_FLAGS_BUSY;
> +
> +	if (rctx->op == SHA_OP_UPDATE)
> +		ret = aspeed_ahash_req_update(hace_dev);
> +	else if (rctx->op == SHA_OP_FINAL)
> +		ret = aspeed_ahash_req_final(hace_dev);
> +
> +	if (ret != -EINPROGRESS)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int aspeed_ahash_prepare_request(struct crypto_engine *engine,
> +					void *areq)
> +{
> +	struct ahash_request *req = ahash_request_cast(areq);
> +	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
> +	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
> +	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
> +	struct aspeed_engine_hash *hash_engine;
> +
> +	hash_engine = &hace_dev->hash_engine;
> +	hash_engine->req = req;
> +
> +	if (hace_dev->version == AST2600_VERSION)
> +		hash_engine->dma_prepare = aspeed_ahash_dma_prepare_sg;
> +	else
> +		hash_engine->dma_prepare = aspeed_ahash_dma_prepare;
> +
> +	return 0;
> +}
> +
> +static int aspeed_sham_update(struct ahash_request *req)
> +{
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
> +	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
> +	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
> +
> +	AHASH_DBG(hace_dev, "req->nbytes: %d\n", req->nbytes);
> +
> +	rctx->total = req->nbytes;
> +	rctx->src_sg = req->src;
> +	rctx->offset = 0;
> +	rctx->src_nents = sg_nents(req->src);
> +	rctx->op = SHA_OP_UPDATE;
> +
> +	rctx->digcnt[0] += rctx->total;
> +	if (rctx->digcnt[0] < rctx->total)
> +		rctx->digcnt[1]++;
> +
> +	if (rctx->bufcnt + rctx->total < rctx->block_size) {
> +		scatterwalk_map_and_copy(rctx->buffer + rctx->bufcnt,
> +					 rctx->src_sg, rctx->offset,
> +					 rctx->total, 0);
> +		rctx->bufcnt += rctx->total;
> +
> +		return 0;
> +	}
> +
> +	return aspeed_hace_hash_handle_queue(hace_dev, req);
> +}
> +
> +static int aspeed_sham_shash_digest(struct crypto_shash *tfm, u32 flags,
> +				    const u8 *data, unsigned int len, u8 *out)
> +{
> +	SHASH_DESC_ON_STACK(shash, tfm);
> +
> +	shash->tfm = tfm;
> +
> +	return crypto_shash_digest(shash, data, len, out);
> +}
> +
> +static int aspeed_sham_final(struct ahash_request *req)
> +{
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
> +	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
> +	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
> +
> +	AHASH_DBG(hace_dev, "req->nbytes:%d, rctx->total:%d\n",
> +		  req->nbytes, rctx->total);
> +	rctx->op = SHA_OP_FINAL;
> +
> +	return aspeed_hace_hash_handle_queue(hace_dev, req);
> +}
> +
> +static int aspeed_sham_finup(struct ahash_request *req)
> +{
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
> +	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
> +	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
> +	int rc1, rc2;
> +
> +	AHASH_DBG(hace_dev, "req->nbytes: %d\n", req->nbytes);
> +
> +	rctx->flags |= SHA_FLAGS_FINUP;
> +
> +	rc1 = aspeed_sham_update(req);
> +	if (rc1 == -EINPROGRESS || rc1 == -EBUSY)
> +		return rc1;
> +
> +	/*
> +	 * final() has to be always called to cleanup resources
> +	 * even if update() failed, except EINPROGRESS
> +	 */
> +	rc2 = aspeed_sham_final(req);
> +
> +	return rc1 ? : rc2;
> +}
> +
> +static int aspeed_sham_init(struct ahash_request *req)
> +{
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
> +	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
> +	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
> +	struct aspeed_sha_hmac_ctx *bctx = tctx->base;
> +
> +	AHASH_DBG(hace_dev, "%s: digest size:%d\n",
> +		  crypto_tfm_alg_name(&tfm->base),
> +		  crypto_ahash_digestsize(tfm));
> +
> +	rctx->cmd = HASH_CMD_ACC_MODE;
> +	rctx->flags = 0;
> +
> +	switch (crypto_ahash_digestsize(tfm)) {
> +	case SHA1_DIGEST_SIZE:
> +		rctx->cmd |= HASH_CMD_SHA1 | HASH_CMD_SHA_SWAP;
> +		rctx->flags |= SHA_FLAGS_SHA1;
> +		rctx->digsize = SHA1_DIGEST_SIZE;
> +		rctx->block_size = SHA1_BLOCK_SIZE;
> +		rctx->sha_iv = sha1_iv;
> +		rctx->ivsize = 32;
> +		memcpy(rctx->digest, sha1_iv, rctx->ivsize);
> +		break;
> +	case SHA224_DIGEST_SIZE:
> +		rctx->cmd |= HASH_CMD_SHA224 | HASH_CMD_SHA_SWAP;
> +		rctx->flags |= SHA_FLAGS_SHA224;
> +		rctx->digsize = SHA224_DIGEST_SIZE;
> +		rctx->block_size = SHA224_BLOCK_SIZE;
> +		rctx->sha_iv = sha224_iv;
> +		rctx->ivsize = 32;
> +		memcpy(rctx->digest, sha224_iv, rctx->ivsize);
> +		break;
> +	case SHA256_DIGEST_SIZE:
> +		rctx->cmd |= HASH_CMD_SHA256 | HASH_CMD_SHA_SWAP;
> +		rctx->flags |= SHA_FLAGS_SHA256;
> +		rctx->digsize = SHA256_DIGEST_SIZE;
> +		rctx->block_size = SHA256_BLOCK_SIZE;
> +		rctx->sha_iv = sha256_iv;
> +		rctx->ivsize = 32;
> +		memcpy(rctx->digest, sha256_iv, rctx->ivsize);
> +		break;
> +	case SHA384_DIGEST_SIZE:
> +		rctx->cmd |= HASH_CMD_SHA512_SER | HASH_CMD_SHA384 |
> +			     HASH_CMD_SHA_SWAP;
> +		rctx->flags |= SHA_FLAGS_SHA384;
> +		rctx->digsize = SHA384_DIGEST_SIZE;
> +		rctx->block_size = SHA384_BLOCK_SIZE;
> +		rctx->sha_iv = (const __be32 *)sha384_iv;
> +		rctx->ivsize = 64;
> +		memcpy(rctx->digest, sha384_iv, rctx->ivsize);
> +		break;
> +	case SHA512_DIGEST_SIZE:
> +		rctx->cmd |= HASH_CMD_SHA512_SER | HASH_CMD_SHA512 |
> +			     HASH_CMD_SHA_SWAP;
> +		rctx->flags |= SHA_FLAGS_SHA512;
> +		rctx->digsize = SHA512_DIGEST_SIZE;
> +		rctx->block_size = SHA512_BLOCK_SIZE;
> +		rctx->sha_iv = (const __be32 *)sha512_iv;
> +		rctx->ivsize = 64;
> +		memcpy(rctx->digest, sha512_iv, rctx->ivsize);
> +		break;
> +	default:
> +		dev_warn(tctx->hace_dev->dev, "digest size %d not support\n",
> +			 crypto_ahash_digestsize(tfm));
> +		return -EINVAL;
> +	}
> +
> +	rctx->bufcnt = 0;
> +	rctx->total = 0;
> +	rctx->digcnt[0] = 0;
> +	rctx->digcnt[1] = 0;
> +
> +	/* HMAC init */
> +	if (tctx->flags & SHA_FLAGS_HMAC) {
> +		rctx->digcnt[0] = rctx->block_size;
> +		rctx->bufcnt = rctx->block_size;
> +		memcpy(rctx->buffer, bctx->ipad, rctx->block_size);
> +		rctx->flags |= SHA_FLAGS_HMAC;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aspeed_sha512s_init(struct ahash_request *req)
> +{
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
> +	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
> +	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
> +	struct aspeed_sha_hmac_ctx *bctx = tctx->base;
> +
> +	AHASH_DBG(hace_dev, "digest size: %d\n", crypto_ahash_digestsize(tfm));
> +
> +	rctx->cmd = HASH_CMD_ACC_MODE;
> +	rctx->flags = 0;
> +
> +	switch (crypto_ahash_digestsize(tfm)) {
> +	case SHA224_DIGEST_SIZE:
> +		rctx->cmd |= HASH_CMD_SHA512_SER | HASH_CMD_SHA512_224 |
> +			     HASH_CMD_SHA_SWAP;
> +		rctx->flags |= SHA_FLAGS_SHA512_224;
> +		rctx->digsize = SHA224_DIGEST_SIZE;
> +		rctx->block_size = SHA512_BLOCK_SIZE;
> +		rctx->sha_iv = sha512_224_iv;
> +		rctx->ivsize = 64;
> +		memcpy(rctx->digest, sha512_224_iv, rctx->ivsize);
> +		break;
> +	case SHA256_DIGEST_SIZE:
> +		rctx->cmd |= HASH_CMD_SHA512_SER | HASH_CMD_SHA512_256 |
> +			     HASH_CMD_SHA_SWAP;
> +		rctx->flags |= SHA_FLAGS_SHA512_256;
> +		rctx->digsize = SHA256_DIGEST_SIZE;
> +		rctx->block_size = SHA512_BLOCK_SIZE;
> +		rctx->sha_iv = sha512_256_iv;
> +		rctx->ivsize = 64;
> +		memcpy(rctx->digest, sha512_256_iv, rctx->ivsize);
> +		break;
> +	default:
> +		dev_warn(tctx->hace_dev->dev, "digest size %d not support\n",
> +			 crypto_ahash_digestsize(tfm));
> +		return -EINVAL;
> +	}
> +
> +	rctx->bufcnt = 0;
> +	rctx->total = 0;
> +	rctx->digcnt[0] = 0;
> +	rctx->digcnt[1] = 0;
> +
> +	/* HMAC init */
> +	if (tctx->flags & SHA_FLAGS_HMAC) {
> +		rctx->digcnt[0] = rctx->block_size;
> +		rctx->bufcnt = rctx->block_size;
> +		memcpy(rctx->buffer, bctx->ipad, rctx->block_size);
> +		rctx->flags |= SHA_FLAGS_HMAC;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aspeed_sham_digest(struct ahash_request *req)
> +{
> +	return aspeed_sham_init(req) ? : aspeed_sham_finup(req);
> +}
> +
> +static int aspeed_sham_setkey(struct crypto_ahash *tfm, const u8 *key,
> +			      unsigned int keylen)
> +{
> +	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
> +	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
> +	struct aspeed_sha_hmac_ctx *bctx = tctx->base;
> +	int ds = crypto_shash_digestsize(bctx->shash);
> +	int bs = crypto_shash_blocksize(bctx->shash);
> +	int err = 0;
> +	int i;
> +
> +	AHASH_DBG(hace_dev, "%s: keylen:%d\n", crypto_tfm_alg_name(&tfm->base),
> +		  keylen);
> +
> +	if (keylen > bs) {
> +		err = aspeed_sham_shash_digest(bctx->shash,
> +					       crypto_shash_get_flags(bctx->shash),
> +					       key, keylen, bctx->ipad);
> +		if (err)
> +			return err;
> +		keylen = ds;
> +
> +	} else {
> +		memcpy(bctx->ipad, key, keylen);
> +	}
> +
> +	memset(bctx->ipad + keylen, 0, bs - keylen);
> +	memcpy(bctx->opad, bctx->ipad, bs);
> +
> +	for (i = 0; i < bs; i++) {
> +		bctx->ipad[i] ^= HMAC_IPAD_VALUE;
> +		bctx->opad[i] ^= HMAC_OPAD_VALUE;
> +	}
> +
> +	return err;
> +}
> +
> +static int aspeed_sham_cra_init(struct crypto_tfm *tfm)
> +{
> +	struct ahash_alg *alg = __crypto_ahash_alg(tfm->__crt_alg);
> +	struct aspeed_sham_ctx *tctx = crypto_tfm_ctx(tfm);
> +	struct aspeed_hace_alg *ast_alg;
> +
> +	ast_alg = container_of(alg, struct aspeed_hace_alg, alg.ahash);
> +	tctx->hace_dev = ast_alg->hace_dev;
> +	tctx->flags = 0;
> +
> +	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
> +				 sizeof(struct aspeed_sham_reqctx));
> +
> +	if (ast_alg->alg_base) {
> +		/* hmac related */
> +		struct aspeed_sha_hmac_ctx *bctx = tctx->base;
> +
> +		tctx->flags |= SHA_FLAGS_HMAC;
> +		bctx->shash = crypto_alloc_shash(ast_alg->alg_base, 0,
> +						 CRYPTO_ALG_NEED_FALLBACK);
> +		if (IS_ERR(bctx->shash)) {
> +			dev_warn(ast_alg->hace_dev->dev,
> +				 "base driver '%s' could not be loaded.\n",
> +				 ast_alg->alg_base);
> +			return PTR_ERR(bctx->shash);
> +		}
> +	}
> +
> +	tctx->enginectx.op.do_one_request = aspeed_ahash_do_request;
> +	tctx->enginectx.op.prepare_request = aspeed_ahash_prepare_request;
> +	tctx->enginectx.op.unprepare_request = NULL;
> +
> +	return 0;
> +}
> +
> +static void aspeed_sham_cra_exit(struct crypto_tfm *tfm)
> +{
> +	struct aspeed_sham_ctx *tctx = crypto_tfm_ctx(tfm);
> +	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
> +
> +	AHASH_DBG(hace_dev, "%s\n", crypto_tfm_alg_name(tfm));
> +
> +	if (tctx->flags & SHA_FLAGS_HMAC) {
> +		struct aspeed_sha_hmac_ctx *bctx = tctx->base;
> +
> +		crypto_free_shash(bctx->shash);
> +	}
> +}
> +
> +static int aspeed_sham_export(struct ahash_request *req, void *out)
> +{
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +
> +	memcpy(out, rctx, sizeof(*rctx));
> +
> +	return 0;
> +}
> +
> +static int aspeed_sham_import(struct ahash_request *req, const void *in)
> +{
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +
> +	memcpy(rctx, in, sizeof(*rctx));
> +
> +	return 0;
> +}
> +
> +struct aspeed_hace_alg aspeed_ahash_algs[] = {
> +	{
> +		.alg.ahash = {
> +			.init	= aspeed_sham_init,
> +			.update	= aspeed_sham_update,
> +			.final	= aspeed_sham_final,
> +			.finup	= aspeed_sham_finup,
> +			.digest	= aspeed_sham_digest,
> +			.export	= aspeed_sham_export,
> +			.import	= aspeed_sham_import,
> +			.halg = {
> +				.digestsize = SHA1_DIGEST_SIZE,
> +				.statesize = sizeof(struct aspeed_sham_reqctx),
> +				.base = {
> +					.cra_name		= "sha1",
> +					.cra_driver_name	= "aspeed-sha1",
> +					.cra_priority		= 300,
> +					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
> +								  CRYPTO_ALG_ASYNC |
> +								  CRYPTO_ALG_KERN_DRIVER_ONLY,
> +					.cra_blocksize		= SHA1_BLOCK_SIZE,
> +					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
> +					.cra_alignmask		= 0,
> +					.cra_module		= THIS_MODULE,
> +					.cra_init		= aspeed_sham_cra_init,
> +					.cra_exit		= aspeed_sham_cra_exit,
> +				}
> +			}
> +		},
> +	},
> +	{
> +		.alg.ahash = {
> +			.init	= aspeed_sham_init,
> +			.update	= aspeed_sham_update,
> +			.final	= aspeed_sham_final,
> +			.finup	= aspeed_sham_finup,
> +			.digest	= aspeed_sham_digest,
> +			.export	= aspeed_sham_export,
> +			.import	= aspeed_sham_import,
> +			.halg = {
> +				.digestsize = SHA256_DIGEST_SIZE,
> +				.statesize = sizeof(struct aspeed_sham_reqctx),
> +				.base = {
> +					.cra_name		= "sha256",
> +					.cra_driver_name	= "aspeed-sha256",
> +					.cra_priority		= 300,
> +					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
> +								  CRYPTO_ALG_ASYNC |
> +								  CRYPTO_ALG_KERN_DRIVER_ONLY,
> +					.cra_blocksize		= SHA256_BLOCK_SIZE,
> +					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
> +					.cra_alignmask		= 0,
> +					.cra_module		= THIS_MODULE,
> +					.cra_init		= aspeed_sham_cra_init,
> +					.cra_exit		= aspeed_sham_cra_exit,
> +				}
> +			}
> +		},
> +	},
> +	{
> +		.alg.ahash = {
> +			.init	= aspeed_sham_init,
> +			.update	= aspeed_sham_update,
> +			.final	= aspeed_sham_final,
> +			.finup	= aspeed_sham_finup,
> +			.digest	= aspeed_sham_digest,
> +			.export	= aspeed_sham_export,
> +			.import	= aspeed_sham_import,
> +			.halg = {
> +				.digestsize = SHA224_DIGEST_SIZE,
> +				.statesize = sizeof(struct aspeed_sham_reqctx),
> +				.base = {
> +					.cra_name		= "sha224",
> +					.cra_driver_name	= "aspeed-sha224",
> +					.cra_priority		= 300,
> +					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
> +								  CRYPTO_ALG_ASYNC |
> +								  CRYPTO_ALG_KERN_DRIVER_ONLY,
> +					.cra_blocksize		= SHA224_BLOCK_SIZE,
> +					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
> +					.cra_alignmask		= 0,
> +					.cra_module		= THIS_MODULE,
> +					.cra_init		= aspeed_sham_cra_init,
> +					.cra_exit		= aspeed_sham_cra_exit,
> +				}
> +			}
> +		},
> +	},
> +	{
> +		.alg_base = "sha1",
> +		.alg.ahash = {
> +			.init	= aspeed_sham_init,
> +			.update	= aspeed_sham_update,
> +			.final	= aspeed_sham_final,
> +			.finup	= aspeed_sham_finup,
> +			.digest	= aspeed_sham_digest,
> +			.setkey	= aspeed_sham_setkey,
> +			.export	= aspeed_sham_export,
> +			.import	= aspeed_sham_import,
> +			.halg = {
> +				.digestsize = SHA1_DIGEST_SIZE,
> +				.statesize = sizeof(struct aspeed_sham_reqctx),
> +				.base = {
> +					.cra_name		= "hmac(sha1)",
> +					.cra_driver_name	= "aspeed-hmac-sha1",
> +					.cra_priority		= 300,
> +					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
> +								  CRYPTO_ALG_ASYNC |
> +								  CRYPTO_ALG_KERN_DRIVER_ONLY,
> +					.cra_blocksize		= SHA1_BLOCK_SIZE,
> +					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx) +
> +								sizeof(struct aspeed_sha_hmac_ctx),
> +					.cra_alignmask		= 0,
> +					.cra_module		= THIS_MODULE,
> +					.cra_init		= aspeed_sham_cra_init,
> +					.cra_exit		= aspeed_sham_cra_exit,
> +				}
> +			}
> +		},
> +	},
> +	{
> +		.alg_base = "sha224",
> +		.alg.ahash = {
> +			.init	= aspeed_sham_init,
> +			.update	= aspeed_sham_update,
> +			.final	= aspeed_sham_final,
> +			.finup	= aspeed_sham_finup,
> +			.digest	= aspeed_sham_digest,
> +			.setkey	= aspeed_sham_setkey,
> +			.export	= aspeed_sham_export,
> +			.import	= aspeed_sham_import,
> +			.halg = {
> +				.digestsize = SHA224_DIGEST_SIZE,
> +				.statesize = sizeof(struct aspeed_sham_reqctx),
> +				.base = {
> +					.cra_name		= "hmac(sha224)",
> +					.cra_driver_name	= "aspeed-hmac-sha224",
> +					.cra_priority		= 300,
> +					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
> +								  CRYPTO_ALG_ASYNC |
> +								  CRYPTO_ALG_KERN_DRIVER_ONLY,
> +					.cra_blocksize		= SHA224_BLOCK_SIZE,
> +					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx) +
> +								sizeof(struct aspeed_sha_hmac_ctx),
> +					.cra_alignmask		= 0,
> +					.cra_module		= THIS_MODULE,
> +					.cra_init		= aspeed_sham_cra_init,
> +					.cra_exit		= aspeed_sham_cra_exit,
> +				}
> +			}
> +		},
> +	},
> +	{
> +		.alg_base = "sha256",
> +		.alg.ahash = {
> +			.init	= aspeed_sham_init,
> +			.update	= aspeed_sham_update,
> +			.final	= aspeed_sham_final,
> +			.finup	= aspeed_sham_finup,
> +			.digest	= aspeed_sham_digest,
> +			.setkey	= aspeed_sham_setkey,
> +			.export	= aspeed_sham_export,
> +			.import	= aspeed_sham_import,
> +			.halg = {
> +				.digestsize = SHA256_DIGEST_SIZE,
> +				.statesize = sizeof(struct aspeed_sham_reqctx),
> +				.base = {
> +					.cra_name		= "hmac(sha256)",
> +					.cra_driver_name	= "aspeed-hmac-sha256",
> +					.cra_priority		= 300,
> +					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
> +								  CRYPTO_ALG_ASYNC |
> +								  CRYPTO_ALG_KERN_DRIVER_ONLY,
> +					.cra_blocksize		= SHA256_BLOCK_SIZE,
> +					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx) +
> +								sizeof(struct aspeed_sha_hmac_ctx),
> +					.cra_alignmask		= 0,
> +					.cra_module		= THIS_MODULE,
> +					.cra_init		= aspeed_sham_cra_init,
> +					.cra_exit		= aspeed_sham_cra_exit,
> +				}
> +			}
> +		},
> +	},
> +};
> +
> +struct aspeed_hace_alg aspeed_ahash_algs_g6[] = {
> +	{
> +		.alg.ahash = {
> +			.init	= aspeed_sham_init,
> +			.update	= aspeed_sham_update,
> +			.final	= aspeed_sham_final,
> +			.finup	= aspeed_sham_finup,
> +			.digest	= aspeed_sham_digest,
> +			.export	= aspeed_sham_export,
> +			.import	= aspeed_sham_import,
> +			.halg = {
> +				.digestsize = SHA384_DIGEST_SIZE,
> +				.statesize = sizeof(struct aspeed_sham_reqctx),
> +				.base = {
> +					.cra_name		= "sha384",
> +					.cra_driver_name	= "aspeed-sha384",
> +					.cra_priority		= 300,
> +					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
> +								  CRYPTO_ALG_ASYNC |
> +								  CRYPTO_ALG_KERN_DRIVER_ONLY,
> +					.cra_blocksize		= SHA384_BLOCK_SIZE,
> +					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
> +					.cra_alignmask		= 0,
> +					.cra_module		= THIS_MODULE,
> +					.cra_init		= aspeed_sham_cra_init,
> +					.cra_exit		= aspeed_sham_cra_exit,
> +				}
> +			}
> +		},
> +	},
> +	{
> +		.alg.ahash = {
> +			.init	= aspeed_sham_init,
> +			.update	= aspeed_sham_update,
> +			.final	= aspeed_sham_final,
> +			.finup	= aspeed_sham_finup,
> +			.digest	= aspeed_sham_digest,
> +			.export	= aspeed_sham_export,
> +			.import	= aspeed_sham_import,
> +			.halg = {
> +				.digestsize = SHA512_DIGEST_SIZE,
> +				.statesize = sizeof(struct aspeed_sham_reqctx),
> +				.base = {
> +					.cra_name		= "sha512",
> +					.cra_driver_name	= "aspeed-sha512",
> +					.cra_priority		= 300,
> +					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
> +								  CRYPTO_ALG_ASYNC |
> +								  CRYPTO_ALG_KERN_DRIVER_ONLY,
> +					.cra_blocksize		= SHA512_BLOCK_SIZE,
> +					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
> +					.cra_alignmask		= 0,
> +					.cra_module		= THIS_MODULE,
> +					.cra_init		= aspeed_sham_cra_init,
> +					.cra_exit		= aspeed_sham_cra_exit,
> +				}
> +			}
> +		},
> +	},
> +	{
> +		.alg.ahash = {
> +			.init	= aspeed_sha512s_init,
> +			.update	= aspeed_sham_update,
> +			.final	= aspeed_sham_final,
> +			.finup	= aspeed_sham_finup,
> +			.digest	= aspeed_sham_digest,
> +			.export	= aspeed_sham_export,
> +			.import	= aspeed_sham_import,
> +			.halg = {
> +				.digestsize = SHA224_DIGEST_SIZE,
> +				.statesize = sizeof(struct aspeed_sham_reqctx),
> +				.base = {
> +					.cra_name		= "sha512_224",
> +					.cra_driver_name	= "aspeed-sha512_224",
> +					.cra_priority		= 300,
> +					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
> +								  CRYPTO_ALG_ASYNC |
> +								  CRYPTO_ALG_KERN_DRIVER_ONLY,
> +					.cra_blocksize		= SHA512_BLOCK_SIZE,
> +					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
> +					.cra_alignmask		= 0,
> +					.cra_module		= THIS_MODULE,
> +					.cra_init		= aspeed_sham_cra_init,
> +					.cra_exit		= aspeed_sham_cra_exit,
> +				}
> +			}
> +		},
> +	},
> +	{
> +		.alg.ahash = {
> +			.init	= aspeed_sha512s_init,
> +			.update	= aspeed_sham_update,
> +			.final	= aspeed_sham_final,
> +			.finup	= aspeed_sham_finup,
> +			.digest	= aspeed_sham_digest,
> +			.export	= aspeed_sham_export,
> +			.import	= aspeed_sham_import,
> +			.halg = {
> +				.digestsize = SHA256_DIGEST_SIZE,
> +				.statesize = sizeof(struct aspeed_sham_reqctx),
> +				.base = {
> +					.cra_name		= "sha512_256",
> +					.cra_driver_name	= "aspeed-sha512_256",
> +					.cra_priority		= 300,
> +					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
> +								  CRYPTO_ALG_ASYNC |
> +								  CRYPTO_ALG_KERN_DRIVER_ONLY,
> +					.cra_blocksize		= SHA512_BLOCK_SIZE,
> +					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
> +					.cra_alignmask		= 0,
> +					.cra_module		= THIS_MODULE,
> +					.cra_init		= aspeed_sham_cra_init,
> +					.cra_exit		= aspeed_sham_cra_exit,
> +				}
> +			}
> +		},
> +	},
> +	{
> +		.alg_base = "sha384",
> +		.alg.ahash = {
> +			.init	= aspeed_sham_init,
> +			.update	= aspeed_sham_update,
> +			.final	= aspeed_sham_final,
> +			.finup	= aspeed_sham_finup,
> +			.digest	= aspeed_sham_digest,
> +			.setkey	= aspeed_sham_setkey,
> +			.export	= aspeed_sham_export,
> +			.import	= aspeed_sham_import,
> +			.halg = {
> +				.digestsize = SHA384_DIGEST_SIZE,
> +				.statesize = sizeof(struct aspeed_sham_reqctx),
> +				.base = {
> +					.cra_name		= "hmac(sha384)",
> +					.cra_driver_name	= "aspeed-hmac-sha384",
> +					.cra_priority		= 300,
> +					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
> +								  CRYPTO_ALG_ASYNC |
> +								  CRYPTO_ALG_KERN_DRIVER_ONLY,
> +					.cra_blocksize		= SHA384_BLOCK_SIZE,
> +					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx) +
> +								sizeof(struct aspeed_sha_hmac_ctx),
> +					.cra_alignmask		= 0,
> +					.cra_module		= THIS_MODULE,
> +					.cra_init		= aspeed_sham_cra_init,
> +					.cra_exit		= aspeed_sham_cra_exit,
> +				}
> +			}
> +		},
> +	},
> +	{
> +		.alg_base = "sha512",
> +		.alg.ahash = {
> +			.init	= aspeed_sham_init,
> +			.update	= aspeed_sham_update,
> +			.final	= aspeed_sham_final,
> +			.finup	= aspeed_sham_finup,
> +			.digest	= aspeed_sham_digest,
> +			.setkey	= aspeed_sham_setkey,
> +			.export	= aspeed_sham_export,
> +			.import	= aspeed_sham_import,
> +			.halg = {
> +				.digestsize = SHA512_DIGEST_SIZE,
> +				.statesize = sizeof(struct aspeed_sham_reqctx),
> +				.base = {
> +					.cra_name		= "hmac(sha512)",
> +					.cra_driver_name	= "aspeed-hmac-sha512",
> +					.cra_priority		= 300,
> +					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
> +								  CRYPTO_ALG_ASYNC |
> +								  CRYPTO_ALG_KERN_DRIVER_ONLY,
> +					.cra_blocksize		= SHA512_BLOCK_SIZE,
> +					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx) +
> +								sizeof(struct aspeed_sha_hmac_ctx),
> +					.cra_alignmask		= 0,
> +					.cra_module		= THIS_MODULE,
> +					.cra_init		= aspeed_sham_cra_init,
> +					.cra_exit		= aspeed_sham_cra_exit,
> +				}
> +			}
> +		},
> +	},
> +	{
> +		.alg_base = "sha512_224",
> +		.alg.ahash = {
> +			.init	= aspeed_sha512s_init,
> +			.update	= aspeed_sham_update,
> +			.final	= aspeed_sham_final,
> +			.finup	= aspeed_sham_finup,
> +			.digest	= aspeed_sham_digest,
> +			.setkey	= aspeed_sham_setkey,
> +			.export	= aspeed_sham_export,
> +			.import	= aspeed_sham_import,
> +			.halg = {
> +				.digestsize = SHA224_DIGEST_SIZE,
> +				.statesize = sizeof(struct aspeed_sham_reqctx),
> +				.base = {
> +					.cra_name		= "hmac(sha512_224)",
> +					.cra_driver_name	= "aspeed-hmac-sha512_224",
> +					.cra_priority		= 300,
> +					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
> +								  CRYPTO_ALG_ASYNC |
> +								  CRYPTO_ALG_KERN_DRIVER_ONLY,
> +					.cra_blocksize		= SHA512_BLOCK_SIZE,
> +					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx) +
> +								sizeof(struct aspeed_sha_hmac_ctx),
> +					.cra_alignmask		= 0,
> +					.cra_module		= THIS_MODULE,
> +					.cra_init		= aspeed_sham_cra_init,
> +					.cra_exit		= aspeed_sham_cra_exit,
> +				}
> +			}
> +		},
> +	},
> +	{
> +		.alg_base = "sha512_256",
> +		.alg.ahash = {
> +			.init	= aspeed_sha512s_init,
> +			.update	= aspeed_sham_update,
> +			.final	= aspeed_sham_final,
> +			.finup	= aspeed_sham_finup,
> +			.digest	= aspeed_sham_digest,
> +			.setkey	= aspeed_sham_setkey,
> +			.export	= aspeed_sham_export,
> +			.import	= aspeed_sham_import,
> +			.halg = {
> +				.digestsize = SHA256_DIGEST_SIZE,
> +				.statesize = sizeof(struct aspeed_sham_reqctx),
> +				.base = {
> +					.cra_name		= "hmac(sha512_256)",
> +					.cra_driver_name	= "aspeed-hmac-sha512_256",
> +					.cra_priority		= 300,
> +					.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
> +								  CRYPTO_ALG_ASYNC |
> +								  CRYPTO_ALG_KERN_DRIVER_ONLY,
> +					.cra_blocksize		= SHA512_BLOCK_SIZE,
> +					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx) +
> +								sizeof(struct aspeed_sha_hmac_ctx),
> +					.cra_alignmask		= 0,
> +					.cra_module		= THIS_MODULE,
> +					.cra_init		= aspeed_sham_cra_init,
> +					.cra_exit		= aspeed_sham_cra_exit,
> +				}
> +			}
> +		},
> +	},
> +};
> +
> +void aspeed_unregister_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(aspeed_ahash_algs); i++)
> +		crypto_unregister_ahash(&aspeed_ahash_algs[i].alg.ahash);
> +
> +	if (hace_dev->version != AST2600_VERSION)
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(aspeed_ahash_algs_g6); i++)
> +		crypto_unregister_ahash(&aspeed_ahash_algs_g6[i].alg.ahash);
> +}
> +
> +void aspeed_register_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
> +{
> +	int rc, i;
> +
> +	AHASH_DBG(hace_dev, "\n");
> +
> +	for (i = 0; i < ARRAY_SIZE(aspeed_ahash_algs); i++) {
> +		aspeed_ahash_algs[i].hace_dev = hace_dev;
> +		rc = crypto_register_ahash(&aspeed_ahash_algs[i].alg.ahash);
> +		if (rc) {
> +			AHASH_DBG(hace_dev, "Failed to register %s\n",
> +				  aspeed_ahash_algs[i].alg.ahash.halg.base.cra_name);
> +		}
> +	}
> +
> +	if (hace_dev->version != AST2600_VERSION)
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(aspeed_ahash_algs_g6); i++) {
> +		aspeed_ahash_algs_g6[i].hace_dev = hace_dev;
> +		rc = crypto_register_ahash(&aspeed_ahash_algs_g6[i].alg.ahash);
> +		if (rc) {
> +			AHASH_DBG(hace_dev, "Failed to register %s\n",
> +				  aspeed_ahash_algs_g6[i].alg.ahash.halg.base.cra_name);
> +		}
> +	}
> +}
> diff --git a/drivers/crypto/aspeed/aspeed-hace.c b/drivers/crypto/aspeed/aspeed-hace.c
> new file mode 100644
> index 000000000000..89b1585d72e2
> --- /dev/null
> +++ b/drivers/crypto/aspeed/aspeed-hace.c
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2021 Aspeed Technology Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#include "aspeed-hace.h"
> +
> +#ifdef ASPEED_HACE_DEBUG
> +#define HACE_DBG(d, fmt, ...)	\
> +	dev_info((d)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
> +#else
> +#define HACE_DBG(d, fmt, ...)	\
> +	dev_dbg((d)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
> +#endif
> +
> +/* Weak function for HACE hash */
> +void __weak aspeed_register_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
> +{
> +	dev_warn(hace_dev->dev, "%s: Not supported yet\n", __func__);
> +}
> +
> +void __weak aspeed_unregister_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
> +{
> +	dev_warn(hace_dev->dev, "%s: Not supported yet\n", __func__);
> +}
> +
> +/* HACE interrupt service routine */
> +static irqreturn_t aspeed_hace_irq(int irq, void *dev)
> +{
> +	struct aspeed_hace_dev *hace_dev = (struct aspeed_hace_dev *)dev;
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	u32 sts;
> +
> +	sts = ast_hace_read(hace_dev, ASPEED_HACE_STS);
> +	ast_hace_write(hace_dev, sts, ASPEED_HACE_STS);
> +
> +	HACE_DBG(hace_dev, "irq status: 0x%x\n", sts);
> +
> +	if (sts & HACE_HASH_ISR) {
> +		if (hash_engine->flags & CRYPTO_FLAGS_BUSY)
> +			tasklet_schedule(&hash_engine->done_task);
> +		else
> +			dev_warn(hace_dev->dev, "HASH no active requests.\n");
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void aspeed_hace_hash_done_task(unsigned long data)
> +{
> +	struct aspeed_hace_dev *hace_dev = (struct aspeed_hace_dev *)data;
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +
> +	hash_engine->resume(hace_dev);
> +}
> +
> +static void aspeed_hace_register(struct aspeed_hace_dev *hace_dev)
> +{
> +	aspeed_register_hace_hash_algs(hace_dev);
> +}
> +
> +static void aspeed_hace_unregister(struct aspeed_hace_dev *hace_dev)
> +{
> +	aspeed_unregister_hace_hash_algs(hace_dev);
> +}
> +
> +static const struct of_device_id aspeed_hace_of_matches[] = {
> +	{ .compatible = "aspeed,ast2500-hace", .data = (void *)5, },
> +	{ .compatible = "aspeed,ast2600-hace", .data = (void *)6, },
> +	{},
> +};
> +
> +static int aspeed_hace_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *hace_dev_id;
> +	struct aspeed_engine_hash *hash_engine;
> +	struct aspeed_hace_dev *hace_dev;
> +	struct resource *res;
> +	int rc;
> +
> +	hace_dev = devm_kzalloc(&pdev->dev, sizeof(struct aspeed_hace_dev),
> +				GFP_KERNEL);
> +	if (!hace_dev)
> +		return -ENOMEM;
> +
> +	hace_dev_id = of_match_device(aspeed_hace_of_matches, &pdev->dev);
> +	if (!hace_dev_id) {
> +		dev_err(&pdev->dev, "Failed to match hace dev id\n");
> +		return -EINVAL;
> +	}
> +
> +	hace_dev->dev = &pdev->dev;
> +	hace_dev->version = (unsigned long)hace_dev_id->data;
> +	hash_engine = &hace_dev->hash_engine;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	platform_set_drvdata(pdev, hace_dev);
> +
> +	hace_dev->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (!hace_dev->regs) {
> +		dev_err(&pdev->dev, "Failed to map resources\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Get irq number and register it */
> +	hace_dev->irq = platform_get_irq(pdev, 0);
> +	if (!hace_dev->irq) {
> +		dev_err(&pdev->dev, "Failed to get interrupt\n");
> +		return -ENXIO;
> +	}
> +
> +	rc = devm_request_irq(&pdev->dev, hace_dev->irq, aspeed_hace_irq, 0,
> +			      dev_name(&pdev->dev), hace_dev);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Failed to request interrupt\n");
> +		return rc;
> +	}
> +
> +	/* Get clk and enable it */
> +	hace_dev->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(hace_dev->clk)) {
> +		dev_err(&pdev->dev, "Failed to get clk\n");
> +		return -ENODEV;
> +	}
> +
> +	rc = clk_prepare_enable(hace_dev->clk);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Failed to enable clock 0x%x\n", rc);
> +		return rc;
> +	}
> +
> +	/* Initialize crypto hardware engine structure for hash */
> +	hace_dev->crypt_engine_hash = crypto_engine_alloc_init(hace_dev->dev,
> +							       true);
> +	if (!hace_dev->crypt_engine_hash) {
> +		rc = -ENOMEM;
> +		goto clk_exit;
> +	}
> +
> +	rc = crypto_engine_start(hace_dev->crypt_engine_hash);
> +	if (rc)
> +		goto err_engine_hash_start;
> +
> +	tasklet_init(&hash_engine->done_task, aspeed_hace_hash_done_task,
> +		     (unsigned long)hace_dev);
> +
> +	/* Allocate DMA buffer for hash engine input used */
> +	hash_engine->ahash_src_addr =
> +		dmam_alloc_coherent(&pdev->dev,
> +				    ASPEED_HASH_SRC_DMA_BUF_LEN,
> +				    &hash_engine->ahash_src_dma_addr,
> +				    GFP_KERNEL);
> +	if (!hash_engine->ahash_src_addr) {
> +		dev_err(&pdev->dev, "Failed to allocate dma buffer\n");
> +		rc = -ENOMEM;
> +		goto err_engine_hash_start;
> +	}
> +
> +	aspeed_hace_register(hace_dev);
> +
> +	dev_info(&pdev->dev, "Aspeed Crypto Accelerator successfully registered\n");
> +
> +	return 0;
> +
> +err_engine_hash_start:
> +	crypto_engine_exit(hace_dev->crypt_engine_hash);
> +clk_exit:
> +	clk_disable_unprepare(hace_dev->clk);
> +
> +	return rc;
> +}
> +
> +static int aspeed_hace_remove(struct platform_device *pdev)
> +{
> +	struct aspeed_hace_dev *hace_dev = platform_get_drvdata(pdev);
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +
> +	aspeed_hace_unregister(hace_dev);
> +
> +	crypto_engine_exit(hace_dev->crypt_engine_hash);
> +
> +	tasklet_kill(&hash_engine->done_task);
> +
> +	clk_disable_unprepare(hace_dev->clk);
> +
> +	return 0;
> +}
> +
> +MODULE_DEVICE_TABLE(of, aspeed_hace_of_matches);
> +
> +static struct platform_driver aspeed_hace_driver = {
> +	.probe		= aspeed_hace_probe,
> +	.remove		= aspeed_hace_remove,
> +	.driver         = {
> +		.name   = KBUILD_MODNAME,
> +		.of_match_table = aspeed_hace_of_matches,
> +	},
> +};
> +
> +module_platform_driver(aspeed_hace_driver);
> +
> +MODULE_AUTHOR("Neal Liu <neal_liu@aspeedtech.com>");
> +MODULE_DESCRIPTION("Aspeed HACE driver Crypto Accelerator");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/crypto/aspeed/aspeed-hace.h b/drivers/crypto/aspeed/aspeed-hace.h
> new file mode 100644
> index 000000000000..3494ff22f69d
> --- /dev/null
> +++ b/drivers/crypto/aspeed/aspeed-hace.h
> @@ -0,0 +1,186 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef __ASPEED_HACE_H__
> +#define __ASPEED_HACE_H__
> +
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/fips.h>
> +#include <linux/dma-mapping.h>
> +#include <crypto/scatterwalk.h>
> +#include <crypto/internal/aead.h>
> +#include <crypto/internal/akcipher.h>
> +#include <crypto/internal/hash.h>
> +#include <crypto/internal/kpp.h>
> +#include <crypto/internal/skcipher.h>
> +#include <crypto/algapi.h>
> +#include <crypto/engine.h>
> +#include <crypto/hmac.h>
> +#include <crypto/sha1.h>
> +#include <crypto/sha2.h>
> +
> +/*****************************
> + *                           *
> + * HACE register definitions *
> + *                           *
> + * ***************************/
> +
> +#define ASPEED_HACE_STS			0x1C	/* HACE Status Register */
> +#define ASPEED_HACE_HASH_SRC		0x20	/* Hash Data Source Base Address Register */
> +#define ASPEED_HACE_HASH_DIGEST_BUFF	0x24	/* Hash Digest Write Buffer Base Address Register */
> +#define ASPEED_HACE_HASH_KEY_BUFF	0x28	/* Hash HMAC Key Buffer Base Address Register */
> +#define ASPEED_HACE_HASH_DATA_LEN	0x2C	/* Hash Data Length Register */
> +#define ASPEED_HACE_HASH_CMD		0x30	/* Hash Engine Command Register */
> +
> +/* interrupt status reg */
> +#define  HACE_HASH_ISR			BIT(9)
> +#define  HACE_HASH_BUSY			BIT(0)
> +
> +/* hash cmd reg */
> +#define  HASH_CMD_MBUS_REQ_SYNC_EN	BIT(20)
> +#define  HASH_CMD_HASH_SRC_SG_CTRL	BIT(18)
> +#define  HASH_CMD_SHA512_224		(0x3 << 10)
> +#define  HASH_CMD_SHA512_256		(0x2 << 10)
> +#define  HASH_CMD_SHA384		(0x1 << 10)
> +#define  HASH_CMD_SHA512		(0)
> +#define  HASH_CMD_INT_ENABLE		BIT(9)
> +#define  HASH_CMD_HMAC			(0x1 << 7)
> +#define  HASH_CMD_ACC_MODE		(0x2 << 7)
> +#define  HASH_CMD_HMAC_KEY		(0x3 << 7)
> +#define  HASH_CMD_SHA1			(0x2 << 4)
> +#define  HASH_CMD_SHA224		(0x4 << 4)
> +#define  HASH_CMD_SHA256		(0x5 << 4)
> +#define  HASH_CMD_SHA512_SER		(0x6 << 4)
> +#define  HASH_CMD_SHA_SWAP		(0x2 << 2)
> +
> +#define HASH_SG_LAST_LIST		BIT(31)
> +
> +#define CRYPTO_FLAGS_BUSY		BIT(1)
> +
> +#define SHA_OP_UPDATE			1
> +#define SHA_OP_FINAL			2
> +
> +#define SHA_FLAGS_SHA1			BIT(0)
> +#define SHA_FLAGS_SHA224		BIT(1)
> +#define SHA_FLAGS_SHA256		BIT(2)
> +#define SHA_FLAGS_SHA384		BIT(3)
> +#define SHA_FLAGS_SHA512		BIT(4)
> +#define SHA_FLAGS_SHA512_224		BIT(5)
> +#define SHA_FLAGS_SHA512_256		BIT(6)
> +#define SHA_FLAGS_HMAC			BIT(8)
> +#define SHA_FLAGS_FINUP			BIT(9)
> +#define SHA_FLAGS_MASK			(0xff)
> +
> +#define ASPEED_CRYPTO_SRC_DMA_BUF_LEN	0xa000
> +#define ASPEED_CRYPTO_DST_DMA_BUF_LEN	0xa000
> +#define ASPEED_CRYPTO_GCM_TAG_OFFSET	0x9ff0
> +#define ASPEED_HASH_SRC_DMA_BUF_LEN	0xa000
> +#define ASPEED_HASH_QUEUE_LENGTH	50
> +
> +struct aspeed_hace_dev;
> +
> +typedef int (*aspeed_hace_fn_t)(struct aspeed_hace_dev *);
> +
> +struct aspeed_sg_list {
> +	__le32 len;
> +	__le32 phy_addr;
> +};
> +
> +struct aspeed_engine_hash {
> +	struct tasklet_struct		done_task;
> +	unsigned long			flags;
> +	struct ahash_request		*req;
> +
> +	/* input buffer */
> +	void				*ahash_src_addr;
> +	dma_addr_t			ahash_src_dma_addr;
> +
> +	dma_addr_t			src_dma;
> +	dma_addr_t			digest_dma;
> +
> +	size_t				src_length;
> +
> +	/* callback func */
> +	aspeed_hace_fn_t		resume;
> +	aspeed_hace_fn_t		dma_prepare;
> +};
> +
> +struct aspeed_sha_hmac_ctx {
> +	struct crypto_shash *shash;
> +	u8 ipad[SHA512_BLOCK_SIZE];
> +	u8 opad[SHA512_BLOCK_SIZE];
> +};
> +
> +struct aspeed_sham_ctx {
> +	struct crypto_engine_ctx	enginectx;
> +
> +	struct aspeed_hace_dev		*hace_dev;
> +	unsigned long			flags;	/* hmac flag */
> +
> +	struct aspeed_sha_hmac_ctx	base[0];
> +};
> +
> +struct aspeed_sham_reqctx {
> +	unsigned long		flags;		/* final update flag should no use*/
> +	unsigned long		op;		/* final or update */
> +	u32			cmd;		/* trigger cmd */
> +
> +	/* walk state */
> +	struct scatterlist	*src_sg;
> +	int			src_nents;
> +	unsigned int		offset;		/* offset in current sg */
> +	unsigned int		total;		/* per update length */
> +
> +	size_t			digsize;
> +	size_t			block_size;
> +	size_t			ivsize;
> +	const __be32		*sha_iv;
> +
> +	/* remain data buffer */
> +	u8			buffer[SHA512_BLOCK_SIZE * 2];
> +	dma_addr_t		buffer_dma_addr;
> +	size_t			bufcnt;		/* buffer counter */
> +
> +	/* output buffer */
> +	u8			digest[SHA512_DIGEST_SIZE] __aligned(64);
> +	dma_addr_t		digest_dma_addr;
> +	u64			digcnt[2];
> +};
> +
> +struct aspeed_hace_dev {
> +	void __iomem			*regs;
> +	struct device			*dev;
> +	int				irq;
> +	struct clk			*clk;
> +	unsigned long			version;
> +
> +	struct crypto_engine		*crypt_engine_hash;
> +
> +	struct aspeed_engine_hash	hash_engine;
> +};
> +
> +struct aspeed_hace_alg {
> +	struct aspeed_hace_dev		*hace_dev;
> +
> +	const char			*alg_base;
> +
> +	union {
> +		struct skcipher_alg	skcipher;
> +		struct ahash_alg	ahash;
> +	} alg;
> +};
> +
> +enum aspeed_version {
> +	AST2500_VERSION = 5,
> +	AST2600_VERSION
> +};
> +
> +#define ast_hace_write(hace, val, offset)	\
> +	writel((val), (hace)->regs + (offset))
> +#define ast_hace_read(hace, offset)		\
> +	readl((hace)->regs + (offset))
> +
> +void aspeed_register_hace_hash_algs(struct aspeed_hace_dev *hace_dev);
> +void aspeed_unregister_hace_hash_algs(struct aspeed_hace_dev *hace_dev);
> +
> +#endif
> 
Thanks.
Longfang.
