Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBDB58C7D5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242945AbiHHLt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiHHLt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:49:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F446421;
        Mon,  8 Aug 2022 04:49:23 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M1ZCl4FX7z1M8YJ;
        Mon,  8 Aug 2022 19:46:11 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 8 Aug 2022 19:49:20 +0800
Received: from [10.67.102.118] (10.67.102.118) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 8 Aug 2022 19:49:19 +0800
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
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
References: <20220726113448.2964968-1-neal_liu@aspeedtech.com>
 <20220726113448.2964968-2-neal_liu@aspeedtech.com>
 <5ca081b1-9a96-5b58-7a27-75c94af119d2@huawei.com>
 <HK0PR06MB32026709F521B1D2F6A1B95C80639@HK0PR06MB3202.apcprd06.prod.outlook.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <256d64d6-0a27-7714-60ac-580b371c2502@huawei.com>
Date:   Mon, 8 Aug 2022 19:49:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <HK0PR06MB32026709F521B1D2F6A1B95C80639@HK0PR06MB3202.apcprd06.prod.outlook.com>
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

On 2022/8/8 17:30, Neal Liu wrote:
>> -----Original Message-----
>> From: liulongfang <liulongfang@huawei.com>
>> Sent: Monday, August 8, 2022 10:53 AM
>> To: Neal Liu <neal_liu@aspeedtech.com>; Corentin Labbe
>> <clabbe.montjoie@gmail.com>; Christophe JAILLET
>> <christophe.jaillet@wanadoo.fr>; Randy Dunlap <rdunlap@infradead.org>;
>> Herbert Xu <herbert@gondor.apana.org.au>; David S . Miller
>> <davem@davemloft.net>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>;
>> Andrew Jeffery <andrew@aj.id.au>; Dhananjay Phadke
>> <dhphadke@microsoft.com>; Johnny Huang
>> <johnny_huang@aspeedtech.com>
>> Cc: linux-aspeed@lists.ozlabs.org; linux-crypto@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
>> Subject: Re: [PATCH v8 1/5] crypto: aspeed: Add HACE hash driver
>>
>>
>> On 2022/7/26 19:34, Neal Liu wrote:
>>> Hash and Crypto Engine (HACE) is designed to accelerate the
>>> throughput of hash data digest, encryption, and decryption.
>>>
>>> Basically, HACE can be divided into two independently engines
>>> - Hash Engine and Crypto Engine. This patch aims to add HACE
>>> hash engine driver for hash accelerator.
>>>
>>> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
>>> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
>>> ---
>>>  MAINTAINERS                              |    7 +
>>>  drivers/crypto/Kconfig                   |    1 +
>>>  drivers/crypto/Makefile                  |    1 +
>>>  drivers/crypto/aspeed/Kconfig            |   32 +
>>>  drivers/crypto/aspeed/Makefile           |    6 +
>>>  drivers/crypto/aspeed/aspeed-hace-hash.c | 1389
>> ++++++++++++++++++++++
>>>  drivers/crypto/aspeed/aspeed-hace.c      |  213 ++++
>>>  drivers/crypto/aspeed/aspeed-hace.h      |  186 +++
>>>  8 files changed, 1835 insertions(+)
>>>  create mode 100644 drivers/crypto/aspeed/Kconfig
>>>  create mode 100644 drivers/crypto/aspeed/Makefile
>>>  create mode 100644 drivers/crypto/aspeed/aspeed-hace-hash.c
>>>  create mode 100644 drivers/crypto/aspeed/aspeed-hace.c
>>>  create mode 100644 drivers/crypto/aspeed/aspeed-hace.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index f55aea311af5..23a0215b7e42 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -3140,6 +3140,13 @@ S:	Maintained
>>>  F:	Documentation/devicetree/bindings/media/aspeed-video.txt
>>>  F:	drivers/media/platform/aspeed/
>>>
>>> +ASPEED CRYPTO DRIVER
>>> +M:	Neal Liu <neal_liu@aspeedtech.com>
>>> +L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
>>> +S:	Maintained
>>> +F:
>> 	Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml
>>> +F:	drivers/crypto/aspeed/
>>> +
>>>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>>>  M:	Corentin Chary <corentin.chary@gmail.com>
>>>  L:	acpi4asus-user@lists.sourceforge.net
>>> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
>>> index ee99c02c84e8..b9f5ee126881 100644
>>> --- a/drivers/crypto/Kconfig
>>> +++ b/drivers/crypto/Kconfig
>>> @@ -933,5 +933,6 @@ config CRYPTO_DEV_SA2UL
>>>  	  acceleration for cryptographic algorithms on these devices.
>>>
>>>  source "drivers/crypto/keembay/Kconfig"
>>> +source "drivers/crypto/aspeed/Kconfig"
>>>
>>>  endif # CRYPTO_HW
>>> diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
>>> index f81703a86b98..116de173a66c 100644
>>> --- a/drivers/crypto/Makefile
>>> +++ b/drivers/crypto/Makefile
>>> @@ -1,5 +1,6 @@
>>>  # SPDX-License-Identifier: GPL-2.0
>>>  obj-$(CONFIG_CRYPTO_DEV_ALLWINNER) += allwinner/
>>> +obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed/
>>>  obj-$(CONFIG_CRYPTO_DEV_ATMEL_AES) += atmel-aes.o
>>>  obj-$(CONFIG_CRYPTO_DEV_ATMEL_SHA) += atmel-sha.o
>>>  obj-$(CONFIG_CRYPTO_DEV_ATMEL_TDES) += atmel-tdes.o
>>> diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
>>> new file mode 100644
>>> index 000000000000..059e627efef8
>>> --- /dev/null
>>> +++ b/drivers/crypto/aspeed/Kconfig
>>> @@ -0,0 +1,32 @@
>>> +config CRYPTO_DEV_ASPEED
>>> +	tristate "Support for Aspeed cryptographic engine driver"
>>> +	depends on ARCH_ASPEED
>>> +	help
>>> +	  Hash and Crypto Engine (HACE) is designed to accelerate the
>>> +	  throughput of hash data digest, encryption and decryption.
>>> +
>>> +	  Select y here to have support for the cryptographic driver
>>> +	  available on Aspeed SoC.
>>> +
>>> +config CRYPTO_DEV_ASPEED_HACE_HASH
>>> +	bool "Enable Aspeed Hash & Crypto Engine (HACE) hash"
>>> +	depends on CRYPTO_DEV_ASPEED
>>> +	select CRYPTO_ENGINE
>>> +	select CRYPTO_SHA1
>>> +	select CRYPTO_SHA256
>>> +	select CRYPTO_SHA512
>>> +	select CRYPTO_HMAC
>>> +	help
>>> +	  Select here to enable Aspeed Hash & Crypto Engine (HACE)
>>> +	  hash driver.
>>> +	  Supports multiple message digest standards, including
>>> +	  SHA-1, SHA-224, SHA-256, SHA-384, SHA-512, and so on.
>>> +
>>> +config CRYPTO_DEV_ASPEED_HACE_HASH_DEBUG
>>> +	bool "Enable HACE hash debug messages"
>>> +	depends on CRYPTO_DEV_ASPEED_HACE_HASH
>>> +	help
>>> +	  Print HACE hash debugging messages if you use this option
>>> +	  to ask for those messages.
>>> +	  Avoid enabling this option for production build to
>>> +	  minimize driver timing.
>>> diff --git a/drivers/crypto/aspeed/Makefile
>> b/drivers/crypto/aspeed/Makefile
>>> new file mode 100644
>>> index 000000000000..8bc8d4fed5a9
>>> --- /dev/null
>>> +++ b/drivers/crypto/aspeed/Makefile
>>> @@ -0,0 +1,6 @@
>>> +obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
>>> +aspeed_crypto-objs := aspeed-hace.o \
>>> +		      $(hace-hash-y)
>>> +
>>> +obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) += aspeed-hace-hash.o
>>> +hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) :=
>> aspeed-hace-hash.o
>>> diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c
>> b/drivers/crypto/aspeed/aspeed-hace-hash.c
>>> new file mode 100644
>>> index 000000000000..63a8ad694996
>>> --- /dev/null
>>> +++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
>>> @@ -0,0 +1,1389 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (c) 2021 Aspeed Technology Inc.
>>> + */
>>> +
>>> +#include "aspeed-hace.h"
>>> +
>>> +#ifdef CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH_DEBUG
>>> +#define AHASH_DBG(h, fmt, ...)	\
>>> +	dev_info((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
>>> +#else
>>> +#define AHASH_DBG(h, fmt, ...)	\
>>> +	dev_dbg((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
>>> +#endif
>>> +
>>> +/* Initialization Vectors for SHA-family */
>>> +static const __be32 sha1_iv[8] = {
>>> +	cpu_to_be32(SHA1_H0), cpu_to_be32(SHA1_H1),
>>> +	cpu_to_be32(SHA1_H2), cpu_to_be32(SHA1_H3),
>>> +	cpu_to_be32(SHA1_H4), 0, 0, 0
>>> +};
>>> +
>>> +static const __be32 sha224_iv[8] = {
>>> +	cpu_to_be32(SHA224_H0), cpu_to_be32(SHA224_H1),
>>> +	cpu_to_be32(SHA224_H2), cpu_to_be32(SHA224_H3),
>>> +	cpu_to_be32(SHA224_H4), cpu_to_be32(SHA224_H5),
>>> +	cpu_to_be32(SHA224_H6), cpu_to_be32(SHA224_H7),
>>> +};
>>> +
>>> +static const __be32 sha256_iv[8] = {
>>> +	cpu_to_be32(SHA256_H0), cpu_to_be32(SHA256_H1),
>>> +	cpu_to_be32(SHA256_H2), cpu_to_be32(SHA256_H3),
>>> +	cpu_to_be32(SHA256_H4), cpu_to_be32(SHA256_H5),
>>> +	cpu_to_be32(SHA256_H6), cpu_to_be32(SHA256_H7),
>>> +};
>>> +
>>> +static const __be64 sha384_iv[8] = {
>>> +	cpu_to_be64(SHA384_H0), cpu_to_be64(SHA384_H1),
>>> +	cpu_to_be64(SHA384_H2), cpu_to_be64(SHA384_H3),
>>> +	cpu_to_be64(SHA384_H4), cpu_to_be64(SHA384_H5),
>>> +	cpu_to_be64(SHA384_H6), cpu_to_be64(SHA384_H7)
>>> +};
>>> +
>>> +static const __be64 sha512_iv[8] = {
>>> +	cpu_to_be64(SHA512_H0), cpu_to_be64(SHA512_H1),
>>> +	cpu_to_be64(SHA512_H2), cpu_to_be64(SHA512_H3),
>>> +	cpu_to_be64(SHA512_H4), cpu_to_be64(SHA512_H5),
>>> +	cpu_to_be64(SHA512_H6), cpu_to_be64(SHA512_H7)
>>> +};
>>> +
>>> +static const __be32 sha512_224_iv[16] = {
>>> +	cpu_to_be32(0xC8373D8CUL), cpu_to_be32(0xA24D5419UL),
>>> +	cpu_to_be32(0x6699E173UL), cpu_to_be32(0xD6D4DC89UL),
>>> +	cpu_to_be32(0xAEB7FA1DUL), cpu_to_be32(0x829CFF32UL),
>>> +	cpu_to_be32(0x14D59D67UL), cpu_to_be32(0xCF9F2F58UL),
>>> +	cpu_to_be32(0x692B6D0FUL), cpu_to_be32(0xA84DD47BUL),
>>> +	cpu_to_be32(0x736FE377UL), cpu_to_be32(0x4289C404UL),
>>> +	cpu_to_be32(0xA8859D3FUL), cpu_to_be32(0xC8361D6AUL),
>>> +	cpu_to_be32(0xADE61211UL), cpu_to_be32(0xA192D691UL)
>>> +};
>>> +
>>> +static const __be32 sha512_256_iv[16] = {
>>> +	cpu_to_be32(0x94213122UL), cpu_to_be32(0x2CF72BFCUL),
>>> +	cpu_to_be32(0xA35F559FUL), cpu_to_be32(0xC2644CC8UL),
>>> +	cpu_to_be32(0x6BB89323UL), cpu_to_be32(0x51B1536FUL),
>>> +	cpu_to_be32(0x19773896UL), cpu_to_be32(0xBDEA4059UL),
>>> +	cpu_to_be32(0xE23E2896UL), cpu_to_be32(0xE3FF8EA8UL),
>>> +	cpu_to_be32(0x251E5EBEUL), cpu_to_be32(0x92398653UL),
>>> +	cpu_to_be32(0xFC99012BUL), cpu_to_be32(0xAAB8852CUL),
>>> +	cpu_to_be32(0xDC2DB70EUL), cpu_to_be32(0xA22CC581UL)
>>> +};
>>> +
>>> +/* The purpose of this padding is to ensure that the padded message is a
>>> + * multiple of 512 bits (SHA1/SHA224/SHA256) or 1024 bits
>> (SHA384/SHA512).
>>> + * The bit "1" is appended at the end of the message followed by
>>> + * "padlen-1" zero bits. Then a 64 bits block (SHA1/SHA224/SHA256) or
>>> + * 128 bits block (SHA384/SHA512) equals to the message length in bits
>>> + * is appended.
>>> + *
>>> + * For SHA1/SHA224/SHA256, padlen is calculated as followed:
>>> + *  - if message length < 56 bytes then padlen = 56 - message length
>>> + *  - else padlen = 64 + 56 - message length
>>> + *
>>> + * For SHA384/SHA512, padlen is calculated as followed:
>>> + *  - if message length < 112 bytes then padlen = 112 - message length
>>> + *  - else padlen = 128 + 112 - message length
>>> + */
>>> +static void aspeed_ahash_fill_padding(struct aspeed_hace_dev *hace_dev,
>>> +				      struct aspeed_sham_reqctx *rctx)
>>> +{
>>> +	unsigned int index, padlen;
>>> +	__be64 bits[2];
>>> +
>>> +	AHASH_DBG(hace_dev, "rctx flags:0x%x\n", (u32)rctx->flags);
>>> +
>>> +	switch (rctx->flags & SHA_FLAGS_MASK) {
>>> +	case SHA_FLAGS_SHA1:
>>> +	case SHA_FLAGS_SHA224:
>>> +	case SHA_FLAGS_SHA256:
>>> +		bits[0] = cpu_to_be64(rctx->digcnt[0] << 3);
>>> +		index = rctx->bufcnt & 0x3f;
>>> +		padlen = (index < 56) ? (56 - index) : ((64 + 56) - index);
>>> +		*(rctx->buffer + rctx->bufcnt) = 0x80;
>>> +		memset(rctx->buffer + rctx->bufcnt + 1, 0, padlen - 1);
>>> +		memcpy(rctx->buffer + rctx->bufcnt + padlen, bits, 8);
>>> +		rctx->bufcnt += padlen + 8;
>>> +		break;
>>> +	default:
>>> +		bits[1] = cpu_to_be64(rctx->digcnt[0] << 3);
>>> +		bits[0] = cpu_to_be64(rctx->digcnt[1] << 3 |
>>> +				      rctx->digcnt[0] >> 61);
>>> +		index = rctx->bufcnt & 0x7f;
>>> +		padlen = (index < 112) ? (112 - index) : ((128 + 112) - index);
>>> +		*(rctx->buffer + rctx->bufcnt) = 0x80;
>>> +		memset(rctx->buffer + rctx->bufcnt + 1, 0, padlen - 1);
>>> +		memcpy(rctx->buffer + rctx->bufcnt + padlen, bits, 16);
>>> +		rctx->bufcnt += padlen + 16;
>>> +		break;
>>> +	}
>>> +}
>>> +
>>> +/*
>>> + * Prepare DMA buffer before hardware engine
>>> + * processing.
>>> + */
>>> +static int aspeed_ahash_dma_prepare(struct aspeed_hace_dev *hace_dev)
>>> +{
>>> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
>>> +	struct ahash_request *req = hash_engine->req;
>>> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
>>> +	int length, remain;
>>> +
>>> +	length = rctx->total + rctx->bufcnt;
>>> +	remain = length % rctx->block_size;
>>> +
>>> +	AHASH_DBG(hace_dev, "length:0x%x, remain:0x%x\n", length, remain);
>>> +
>>> +	if (rctx->bufcnt)
>>> +		memcpy(hash_engine->ahash_src_addr, rctx->buffer, rctx->bufcnt);
>>> +
>>> +	if (rctx->total + rctx->bufcnt < ASPEED_CRYPTO_SRC_DMA_BUF_LEN) {
>>> +		scatterwalk_map_and_copy(hash_engine->ahash_src_addr +
>>> +					 rctx->bufcnt, rctx->src_sg,
>>> +					 rctx->offset, rctx->total - remain, 0);
>>> +		rctx->offset += rctx->total - remain;
>>> +
>>> +	} else {
>>> +		dev_warn(hace_dev->dev, "Hash data length is too large\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	scatterwalk_map_and_copy(rctx->buffer, rctx->src_sg,
>>> +				 rctx->offset, remain, 0);
>>> +
>>> +	rctx->bufcnt = remain;
>>> +	rctx->digest_dma_addr = dma_map_single(hace_dev->dev, rctx->digest,
>>> +					       SHA512_DIGEST_SIZE,
>>> +					       DMA_BIDIRECTIONAL);
>>> +	if (dma_mapping_error(hace_dev->dev, rctx->digest_dma_addr)) {
>>> +		dev_warn(hace_dev->dev, "dma_map() rctx digest error\n");
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	hash_engine->src_length = length - remain;
>>> +	hash_engine->src_dma = hash_engine->ahash_src_dma_addr;
>>> +	hash_engine->digest_dma = rctx->digest_dma_addr;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/*
>>> + * Prepare DMA buffer as SG list buffer before
>>> + * hardware engine processing.
>>> + */
>>> +static int aspeed_ahash_dma_prepare_sg(struct aspeed_hace_dev
>> *hace_dev)
>>> +{
>>> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
>>> +	struct ahash_request *req = hash_engine->req;
>>> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
>>> +	struct aspeed_sg_list *src_list;
>>> +	struct scatterlist *s;
>>> +	int length, remain, sg_len, i;
>>> +	int rc = 0;
>>> +
>>> +	remain = (rctx->total + rctx->bufcnt) % rctx->block_size;
>>> +	length = rctx->total + rctx->bufcnt - remain;
>>> +
>>> +	AHASH_DBG(hace_dev, "%s:0x%x, %s:0x%x, %s:0x%x, %s:0x%x\n",
>>> +		  "rctx total", rctx->total, "bufcnt", rctx->bufcnt,
>>> +		  "length", length, "remain", remain);
>>> +
>>> +	sg_len = dma_map_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
>>> +			    DMA_TO_DEVICE);
>>> +	if (!sg_len) {
>>> +		dev_warn(hace_dev->dev, "dma_map_sg() src error\n");
>>> +		rc = -ENOMEM;
>>> +		goto end;
>>> +	}
>>> +
>>> +	src_list = (struct aspeed_sg_list *)hash_engine->ahash_src_addr;
>>> +	rctx->digest_dma_addr = dma_map_single(hace_dev->dev, rctx->digest,
>>> +					       SHA512_DIGEST_SIZE,
>>> +					       DMA_BIDIRECTIONAL);
>>> +	if (dma_mapping_error(hace_dev->dev, rctx->digest_dma_addr)) {
>>> +		dev_warn(hace_dev->dev, "dma_map() rctx digest error\n");
>>> +		rc = -ENOMEM;
>>> +		goto free_src_sg;
>>> +	}
>>> +
>>> +	if (rctx->bufcnt != 0) {
>>> +		rctx->buffer_dma_addr = dma_map_single(hace_dev->dev,
>>> +						       rctx->buffer,
>>> +						       rctx->block_size * 2,
>>> +						       DMA_TO_DEVICE);
>>> +		if (dma_mapping_error(hace_dev->dev, rctx->buffer_dma_addr)) {
>>> +			dev_warn(hace_dev->dev, "dma_map() rctx buffer error\n");
>>> +			rc = -ENOMEM;
>>> +			goto free_rctx_digest;
>>> +		}
>>> +
>>> +		src_list[0].phy_addr = rctx->buffer_dma_addr;
>>> +		src_list[0].len = rctx->bufcnt;
>>> +		length -= src_list[0].len;
>>> +
>>> +		/* Last sg list */
>>> +		if (length == 0)
>>> +			src_list[0].len |= HASH_SG_LAST_LIST;
>>> +
>>> +		src_list[0].phy_addr = cpu_to_le32(src_list[0].phy_addr);
>>> +		src_list[0].len = cpu_to_le32(src_list[0].len);
>>> +		src_list++;
>>> +	}
>>> +
>>> +	if (length != 0) {
>>> +		for_each_sg(rctx->src_sg, s, sg_len, i) {
>>> +			src_list[i].phy_addr = sg_dma_address(s);
>>> +
>>> +			if (length > sg_dma_len(s)) {
>>> +				src_list[i].len = sg_dma_len(s);
>>> +				length -= sg_dma_len(s);
>>> +
>>> +			} else {
>>> +				/* Last sg list */
>>> +				src_list[i].len = length;
>>> +				src_list[i].len |= HASH_SG_LAST_LIST;
>>> +				length = 0;
>>> +			}
>>> +
>>> +			src_list[i].phy_addr = cpu_to_le32(src_list[i].phy_addr);
>>> +			src_list[i].len = cpu_to_le32(src_list[i].len);
>>> +		}
>>> +	}
>>> +
>>> +	if (length != 0) {
>>> +		rc = -EINVAL;
>>> +		goto free_rctx_buffer;
>>> +	}
>>> +
>>> +	rctx->offset = rctx->total - remain;
>>> +	hash_engine->src_length = rctx->total + rctx->bufcnt - remain;
>>> +	hash_engine->src_dma = hash_engine->ahash_src_dma_addr;
>>> +	hash_engine->digest_dma = rctx->digest_dma_addr;
>>> +
>>> +	goto end;
>> Exiting via "goto xx" is not recommended in normal code logic (this requires
>> two jumps),
>> exiting via "return 0" is more efficient.
>> This code method has many times in your entire driver, it is recommended to
>> modify it.
> 
> If not exiting via "goto xx", how to release related resources without any problem?
> Is there any proper way to do this?
maybe I didn't describe it clearly enough.
"in normal code logic"  means rc=0
In this scenario (rc=0), "goto xx" is no longer required,
it can be replaced with "return 0"
> 
>>> +
>>> +free_rctx_buffer:
>>> +	if (rctx->bufcnt != 0)
>>> +		dma_unmap_single(hace_dev->dev, rctx->buffer_dma_addr,
>>> +				 rctx->block_size * 2, DMA_TO_DEVICE);
>>> +free_rctx_digest:
>>> +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
>>> +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
>>> +free_src_sg:
>>> +	dma_unmap_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
>>> +		     DMA_TO_DEVICE);
>>> +end:
>>> +	return rc;
>>> +}
>>> +
>>> +static int aspeed_ahash_complete(struct aspeed_hace_dev *hace_dev)
>>> +{
>>> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
>>> +	struct ahash_request *req = hash_engine->req;
>>> +
>>> +	AHASH_DBG(hace_dev, "\n");
>>> +
>>> +	hash_engine->flags &= ~CRYPTO_FLAGS_BUSY;
>>> +
>>> +	crypto_finalize_hash_request(hace_dev->crypt_engine_hash, req, 0);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/*
>>> + * Copy digest to the corresponding request result.
>>> + * This function will be called at final() stage.
>>> + */
>>> +static int aspeed_ahash_transfer(struct aspeed_hace_dev *hace_dev)
>>> +{
>>> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
>>> +	struct ahash_request *req = hash_engine->req;
>>> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
>>> +
>>> +	AHASH_DBG(hace_dev, "\n");
>>> +
>>> +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
>>> +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
>>> +
>>> +	dma_unmap_single(hace_dev->dev, rctx->buffer_dma_addr,
>>> +			 rctx->block_size * 2, DMA_TO_DEVICE);
>>> +
>>> +	memcpy(req->result, rctx->digest, rctx->digsize);
>>> +
>>> +	return aspeed_ahash_complete(hace_dev);
>>> +}
>>> +
>>> +/*
>>> + * Trigger hardware engines to do the math.
>>> + */
>>> +static int aspeed_hace_ahash_trigger(struct aspeed_hace_dev *hace_dev,
>>> +				     aspeed_hace_fn_t resume)
>>> +{
>>> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
>>> +	struct ahash_request *req = hash_engine->req;
>>> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
>>> +
>>> +	AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x,
>> length:0x%x\n",
>>> +		  hash_engine->src_dma, hash_engine->digest_dma,
>>> +		  hash_engine->src_length);
>>> +
>>> +	rctx->cmd |= HASH_CMD_INT_ENABLE;
>>> +	hash_engine->resume = resume;
>>> +
>>> +	ast_hace_write(hace_dev, hash_engine->src_dma,
>> ASPEED_HACE_HASH_SRC);
>>> +	ast_hace_write(hace_dev, hash_engine->digest_dma,
>>> +		       ASPEED_HACE_HASH_DIGEST_BUFF);
>>> +	ast_hace_write(hace_dev, hash_engine->digest_dma,
>>> +		       ASPEED_HACE_HASH_KEY_BUFF);
>>> +	ast_hace_write(hace_dev, hash_engine->src_length,
>>> +		       ASPEED_HACE_HASH_DATA_LEN);
>>> +
>>> +	/* Memory barrier to ensure all data setup before engine starts */
>>> +	mb();
>>> +
>>> +	ast_hace_write(hace_dev, rctx->cmd, ASPEED_HACE_HASH_CMD);
>> A hardware service sending requires 5 hardware commands to complete.
>> In a multi-concurrency scenario, how to ensure the order of commands?
>> (If two processes send hardware task at the same time,
>> How to ensure that the hardware recognizes which task the current
>> command belongs to?)
> 
> Linux crypto engine would guarantee that only one request at each time to be dequeued from engine queue to process.
> And there has lock mechanism inside Linux crypto engine to prevent the scenario you mentioned.
> So only 1 aspeed_hace_ahash_trigger() hardware service would go through at a time.
> 
> [...]
> .
> 
You may not understand what I mean, the command flow in a normal scenario:
request_A: Acmd1-->Acmd2-->Acmd3-->Acmd4-->Acmd5
request_B: Bcmd1-->Bcmd2-->Bcmd3-->Bcmd4-->Bcmd5
In a multi-process concurrent scenario, multiple crypto engines can be enabled,
and each crypto engine sends a request. If multiple requests here enter
aspeed_hace_ahash_trigger() at the same time, the command flow will be
intertwined like this:
request_A, request_B: Acmd1-->Bcmd1-->Acmd2-->Acmd3-->Bcmd2-->Acmd4-->Bcmd3-->Bcmd4-->Acmd5-->Bcmd5

In this command flow, how does your hardware identify whether these commands
belong to request_A or request_B?
Thanks.
Longfang.
