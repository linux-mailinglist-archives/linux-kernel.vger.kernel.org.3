Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D0E53EF73
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiFFUTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiFFUTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:19:25 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697D23206B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:19:10 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id yJBgnu7iDeg3pyJBgnZwwi; Mon, 06 Jun 2022 22:19:08 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 06 Jun 2022 22:19:08 +0200
X-ME-IP: 90.11.190.129
Message-ID: <ef2fc6ab-e487-1f95-dceb-fd190f064ac2@wanadoo.fr>
Date:   Mon, 6 Jun 2022 22:18:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 5/5] crypto: aspeed: add HACE crypto driver
Content-Language: fr
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
References: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
 <20220606064935.1458903-6-neal_liu@aspeedtech.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220606064935.1458903-6-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/06/2022 à 08:49, Neal Liu a écrit :
> Add HACE crypto driver to support symmetric-key
> encryption and decryption with multiple modes of
> operation.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> ---

[...]

> +static int aspeed_sk_transfer_sg(struct aspeed_hace_dev *hace_dev)
> +{
> +	struct aspeed_engine_crypto *crypto_engine = &hace_dev->crypto_engine;
> +	struct device *dev = hace_dev->dev;
> +	struct aspeed_cipher_reqctx *rctx;
> +	struct skcipher_request *req;
> +
> +	CIPHER_DBG(hace_dev, "\n");
> +
> +	req = skcipher_request_cast(crypto_engine->areq);
> +	rctx = skcipher_request_ctx(req);
> +
> +	if (req->src == req->dst) {
> +		dma_unmap_sg(dev, req->src, rctx->src_nents, DMA_BIDIRECTIONAL);
> +

Unneeded empty line.

> +	} else {
> +		dma_unmap_sg(dev, req->src, rctx->src_nents, DMA_TO_DEVICE);
> +		dma_unmap_sg(dev, req->dst, rctx->dst_nents, DMA_FROM_DEVICE);
> +	}
> +
> +	return aspeed_sk_complete(hace_dev, 0);
> +}
> +

[...]

> +static int aspeed_sk_start_sg(struct aspeed_hace_dev *hace_dev)
> +{
> +	struct aspeed_engine_crypto *crypto_engine = &hace_dev->crypto_engine;
> +	struct aspeed_sg_list *src_list, *dst_list;
> +	dma_addr_t src_dma_addr, dst_dma_addr;
> +	struct aspeed_cipher_reqctx *rctx;
> +	struct skcipher_request *req;
> +	struct scatterlist *s;
> +	int src_sg_len;
> +	int dst_sg_len;
> +	int total, i;
> +	int rc;
> +
> +	CIPHER_DBG(hace_dev, "\n");
> +
> +	req = skcipher_request_cast(crypto_engine->areq);
> +	rctx = skcipher_request_ctx(req);
> +
> +	rctx->enc_cmd |= HACE_CMD_DES_SG_CTRL | HACE_CMD_SRC_SG_CTRL |
> +			 HACE_CMD_AES_KEY_HW_EXP | HACE_CMD_MBUS_REQ_SYNC_EN;
> +
> +	/* BIDIRECTIONAL */
> +	if (req->dst == req->src) {
> +		src_sg_len = dma_map_sg(hace_dev->dev, req->src,
> +					rctx->src_nents, DMA_BIDIRECTIONAL);
> +		dst_sg_len = src_sg_len;
> +		if (!src_sg_len) {
> +			dev_warn(hace_dev->dev, "dma_map_sg() src error\n");
> +			return -EINVAL;
> +		}
> +
> +	} else {
> +		src_sg_len = dma_map_sg(hace_dev->dev, req->src,
> +					rctx->src_nents, DMA_TO_DEVICE);
> +		if (!src_sg_len) {
> +			dev_warn(hace_dev->dev, "dma_map_sg() src error\n");
> +			return -EINVAL;
> +		}
> +
> +		dst_sg_len = dma_map_sg(hace_dev->dev, req->dst,
> +					rctx->dst_nents, DMA_FROM_DEVICE);
> +		if (!dst_sg_len) {
> +			dev_warn(hace_dev->dev, "dma_map_sg() dst error\n");
> +			rc = -EINVAL;
> +			goto free_req_src;

Should we realy call dma_unmap_sg() if dma_map_sg() fails?

> +		}
> +	}
> +
> +	src_list = (struct aspeed_sg_list *)crypto_engine->cipher_addr;
> +	src_dma_addr = crypto_engine->cipher_dma_addr;
> +	total = req->cryptlen;
> +
> +	for_each_sg(req->src, s, src_sg_len, i) {
> +		src_list[i].phy_addr = sg_dma_address(s);
> +
> +		/* last sg list */
> +		if (sg_dma_len(s) >= total) {
> +			src_list[i].len = total;
> +			src_list[i].len |= BIT(31);
> +			total = 0;
> +			break;
> +		}
> +
> +		src_list[i].len = sg_dma_len(s);
> +		total -= src_list[i].len;
> +	}
> +
> +	if (total != 0)
> +		return -EINVAL;

goto free_req_src; ?

> +
> +	if (req->dst == req->src) {
> +		dst_list = src_list;
> +		dst_dma_addr = src_dma_addr;
> +
> +	} else {
> +		dst_list = (struct aspeed_sg_list *)crypto_engine->dst_sg_addr;
> +		dst_dma_addr = crypto_engine->dst_sg_dma_addr;
> +		total = req->cryptlen;
> +
> +		for_each_sg(req->dst, s, dst_sg_len, i) {
> +			dst_list[i].phy_addr = sg_dma_address(s);
> +
> +			/* last sg list */
> +			if (sg_dma_len(s) >= total) {
> +				dst_list[i].len = total;
> +				dst_list[i].len |= BIT(31);
> +				total = 0;
> +				break;
> +			}
> +
> +			dst_list[i].len = sg_dma_len(s);
> +			total -= dst_list[i].len;
> +		}
> +
> +		dst_list[dst_sg_len].phy_addr = 0;
> +		dst_list[dst_sg_len].len = 0;
> +	}
> +
> +	if (total != 0)
> +		return -EINVAL;
> +
> +	crypto_engine->resume = aspeed_sk_transfer_sg;
> +
> +	/* Dummy read for barriers */
> +	readl(src_list);
> +	readl(dst_list);
> +
> +	/* Trigger engines */
> +	ast_hace_write(hace_dev, src_dma_addr, ASPEED_HACE_SRC);
> +	ast_hace_write(hace_dev, dst_dma_addr, ASPEED_HACE_DEST);
> +	ast_hace_write(hace_dev, req->cryptlen, ASPEED_HACE_DATA_LEN);
> +	ast_hace_write(hace_dev, rctx->enc_cmd, ASPEED_HACE_CMD);
> +
> +	return -EINPROGRESS;
> +
> +free_req_src:
> +	dma_unmap_sg(hace_dev->dev, req->src, rctx->src_nents, DMA_TO_DEVICE);
> +
> +	return rc;
> +}
> +

[...]

> +static int aspeed_aes_setkey(struct crypto_skcipher *cipher, const u8 *key,
> +			     unsigned int keylen)
> +{
> +	struct aspeed_cipher_ctx *ctx = crypto_skcipher_ctx(cipher);
> +	struct aspeed_hace_dev *hace_dev = ctx->hace_dev;
> +	struct crypto_aes_ctx gen_aes_key;
> +
> +	CIPHER_DBG(hace_dev, "keylen: %d bits\n", (keylen * 8));
> +
> +	if (keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_192 &&
> +	    keylen != AES_KEYSIZE_256)
> +		return -EINVAL;
> +
> +	if (ctx->hace_dev->version == AST2500_VERSION) {
> +		aes_expandkey(&gen_aes_key, key, keylen);
> +		memcpy(ctx->key, gen_aes_key.key_enc, AES_MAX_KEYLENGTH);
> +

Unneeded empty line

> +	} else {
> +		memcpy(ctx->key, key, keylen);
> +	}
> +
> +	ctx->key_len = keylen;
> +
> +	return 0;
> +}
> +

[...]

> +	crypto_engine->cipher_ctx =
> +		dma_alloc_coherent(&pdev->dev,
> +				   PAGE_SIZE,
> +				   &crypto_engine->cipher_ctx_dma,
> +				   GFP_KERNEL);
> +	if (!crypto_engine->cipher_ctx) {
> +		dev_err(&pdev->dev, "Failed to allocate cipher ctx dma\n");
> +		rc = -ENOMEM;
> +		goto free_hash_src;
> +	}
> +
> +	crypto_engine->cipher_addr =
> +		dma_alloc_coherent(&pdev->dev,
> +				   ASPEED_CRYPTO_SRC_DMA_BUF_LEN,
> +				   &crypto_engine->cipher_dma_addr,
> +				   GFP_KERNEL);
> +	if (!crypto_engine->cipher_addr) {
> +		dev_err(&pdev->dev, "Failed to allocate cipher addr dma\n");
> +		rc = -ENOMEM;
> +		goto free_cipher_ctx;
> +	}
> +
> +	if (hace_dev->version == AST2600_VERSION) {
> +		crypto_engine->dst_sg_addr =
> +			dma_alloc_coherent(&pdev->dev,
> +					   ASPEED_CRYPTO_DST_DMA_BUF_LEN,
> +					   &crypto_engine->dst_sg_dma_addr,
> +					   GFP_KERNEL);
> +		if (!crypto_engine->dst_sg_addr) {
> +			dev_err(&pdev->dev, "Failed to allocate dst_sg dma\n");
> +			rc = -ENOMEM;
> +			goto free_cipher_addr;
> +		}
> +	}
> +
>   	rc = aspeed_hace_register(hace_dev);
>   	if (rc) {
>   		dev_err(&pdev->dev, "Failed to register algs, rc:0x%x\n", rc);

I guess that the new dma_alloc_coherent() just a few lines above should 
also be undone in error hanfling path if aspeed_hace_register() fails?

> @@ -179,6 +282,18 @@ static int aspeed_hace_probe(struct platform_device *pdev)
>   
>   	return 0;
>   
> +free_cipher_addr:
> +	dma_free_coherent(&pdev->dev, ASPEED_CRYPTO_SRC_DMA_BUF_LEN,
> +			  crypto_engine->cipher_addr,
> +			  crypto_engine->cipher_dma_addr);
> +free_cipher_ctx:
> +	dma_free_coherent(&pdev->dev, PAGE_SIZE,
> +			  crypto_engine->cipher_ctx,
> +			  crypto_engine->cipher_ctx_dma);
> +free_hash_src:
> +	dma_free_coherent(&pdev->dev, ASPEED_HASH_SRC_DMA_BUF_LEN,
> +			  hash_engine->ahash_src_addr,
> +			  hash_engine->ahash_src_dma_addr);
>   end:
>   	clk_disable_unprepare(hace_dev->clk);
>   	return rc;
