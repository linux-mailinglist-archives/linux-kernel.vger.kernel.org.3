Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD61539E97
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350303AbiFAHlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346393AbiFAHlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:41:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFBACF7;
        Wed,  1 Jun 2022 00:41:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso581764wmp.0;
        Wed, 01 Jun 2022 00:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TKkT3uiSaLRmEOf26dVneL8JWxoGI5l1lO/ofIOAaHY=;
        b=pNORKMVjx2zXFXlSuiuZP5pSf1MSEDMoXNA3NPKsspPOupbaadegHRHg4NwdiR22UT
         GcHOmtQvIVHmDh3IjKDirx8nRq4awKfxn6ll9NUzbacb58pxJMGhqdU+F13V6UFz53dR
         tWxZmCbEzKl9t+oYkRBL8SB0hZ6de8EWuD3zdtUXqyLPrh95l8awsyyrl+IVlMA7/idx
         wIFaADrHgXqy/Qqjl90Lihi8SNVpQlIUlkolAJUvF/gQaXwR7yZ6B6sNhNbkaBW8aS+d
         DV5TN91XkrJjhNQ64A6/ChiPH8ENqNRwn2gnaumOHmTZgrA/QD8sWf3zGZ+spvIIeWM3
         hT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TKkT3uiSaLRmEOf26dVneL8JWxoGI5l1lO/ofIOAaHY=;
        b=1zmCrMKer5RtuexEYw655SX0ROSHNEdSXcHlQ3PWjXVtRpZhCgs0x82j867RLdHXZp
         OkD9QFXn9FE/Y7N26l7P6lxVjrU7KKKa3edftS0JUGuce4YZgr4euAvmnTq85MeHeP1D
         OcsuWmWDX4T98qLVx668lv1lvJp3UGCXSHiwR7xWdyUAvAR2DiULDT7yzAKpRo9vSVN5
         rcryG/k3Um9UCi8qVo0QuahIdXRYQNem6TIas8WpIx1FyRyWKRAmIOxobBV1qBz6JsrD
         jcaPOBVm7h+597pMVm6RJeTkMdHsKk1XI5NFG7s98ryMcWulJfe2KaqhpIFL1qhohwrd
         CfyQ==
X-Gm-Message-State: AOAM531TGd9H/h3f29rLvanAfx7Wl1SnhTjUQ8WAPBJ9cYsTMLe98MoP
        GmvBHObHQDJOPxSdxMFcg2Q=
X-Google-Smtp-Source: ABdhPJy9hW8FCFdY9h3Hn72mzoFUIIDxEyAvG6uOx8dDxXyssXRN2nFMKe3nfTaPr2LMy8VsKXqT+w==
X-Received: by 2002:a05:600c:3542:b0:39c:235d:1a40 with SMTP id i2-20020a05600c354200b0039c235d1a40mr818276wmq.121.1654069300078;
        Wed, 01 Jun 2022 00:41:40 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id p9-20020adf9d89000000b0020d10a249eesm890444wre.13.2022.06.01.00.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 00:41:39 -0700 (PDT)
Date:   Wed, 1 Jun 2022 09:41:34 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>,
        linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] crypto: aspeed: Add HACE hash driver
Message-ID: <YpcYLiJfC6tgP2Nj@Red>
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-2-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220601054204.1522976-2-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Jun 01, 2022 at 01:42:00PM +0800, Neal Liu a écrit :
> Hash and Crypto Engine (HACE) is designed to accelerate the
> throughput of hash data digest, encryption, and decryption.
> 
> Basically, HACE can be divided into two independently engines
> - Hash Engine and Crypto Engine. This patch aims to add HACE
> hash engine driver for hash accelerator.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>

Hello

Did you test with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y (you should said it in cover letter).
There are several easy style fixes to do (please run checkpatch --strict)
Did you test your driver with both little and big endian mode ?

Also please see my comment below.

[...]
> +/* Initialization Vectors for SHA-family */
> +static const u32 sha1_iv[8] = {
> +	0x01234567UL, 0x89abcdefUL, 0xfedcba98UL, 0x76543210UL,
> +	0xf0e1d2c3UL, 0, 0, 0
> +};
> +
> +static const u32 sha224_iv[8] = {
> +	0xd89e05c1UL, 0x07d57c36UL, 0x17dd7030UL, 0x39590ef7UL,
> +	0x310bc0ffUL, 0x11155868UL, 0xa78ff964UL, 0xa44ffabeUL
> +};
> +
> +static const u32 sha256_iv[8] = {
> +	0x67e6096aUL, 0x85ae67bbUL, 0x72f36e3cUL, 0x3af54fa5UL,
> +	0x7f520e51UL, 0x8c68059bUL, 0xabd9831fUL, 0x19cde05bUL
> +};
> +
> +static const u32 sha384_iv[16] = {
> +	0x5d9dbbcbUL, 0xd89e05c1UL, 0x2a299a62UL, 0x07d57c36UL,
> +	0x5a015991UL, 0x17dd7030UL, 0xd8ec2f15UL, 0x39590ef7UL,
> +	0x67263367UL, 0x310bc0ffUL, 0x874ab48eUL, 0x11155868UL,
> +	0x0d2e0cdbUL, 0xa78ff964UL, 0x1d48b547UL, 0xa44ffabeUL
> +};
> +
> +static const u32 sha512_iv[16] = {
> +	0x67e6096aUL, 0x08c9bcf3UL, 0x85ae67bbUL, 0x3ba7ca84UL,
> +	0x72f36e3cUL, 0x2bf894feUL, 0x3af54fa5UL, 0xf1361d5fUL,
> +	0x7f520e51UL, 0xd182e6adUL, 0x8c68059bUL, 0x1f6c3e2bUL,
> +	0xabd9831fUL, 0x6bbd41fbUL, 0x19cde05bUL, 0x79217e13UL
> +};
> +
> +static const u32 sha512_224_iv[16] = {
> +	0xC8373D8CUL, 0xA24D5419UL, 0x6699E173UL, 0xD6D4DC89UL,
> +	0xAEB7FA1DUL, 0x829CFF32UL, 0x14D59D67UL, 0xCF9F2F58UL,
> +	0x692B6D0FUL, 0xA84DD47BUL, 0x736FE377UL, 0x4289C404UL,
> +	0xA8859D3FUL, 0xC8361D6AUL, 0xADE61211UL, 0xA192D691UL
> +};
> +
> +static const u32 sha512_256_iv[16] = {
> +	0x94213122UL, 0x2CF72BFCUL, 0xA35F559FUL, 0xC2644CC8UL,
> +	0x6BB89323UL, 0x51B1536FUL, 0x19773896UL, 0xBDEA4059UL,
> +	0xE23E2896UL, 0xE3FF8EA8UL, 0x251E5EBEUL, 0x92398653UL,
> +	0xFC99012BUL, 0xAAB8852CUL, 0xDC2DB70EUL, 0xA22CC581UL
> +};

Thoses IV already exists as define in linux headers (SHA1_H0 for example)
But I am puzzled on why you invert them.

> +
> +static void aspeed_ahash_iV(struct aspeed_sham_reqctx *rctx)
> +{
> +	if (rctx->flags & SHA_FLAGS_SHA1)
> +		memcpy(rctx->digest, sha1_iv, 32);
> +	else if (rctx->flags & SHA_FLAGS_SHA224)
> +		memcpy(rctx->digest, sha224_iv, 32);
> +	else if (rctx->flags & SHA_FLAGS_SHA256)
> +		memcpy(rctx->digest, sha256_iv, 32);
> +	else if (rctx->flags & SHA_FLAGS_SHA384)
> +		memcpy(rctx->digest, sha384_iv, 64);
> +	else if (rctx->flags & SHA_FLAGS_SHA512)
> +		memcpy(rctx->digest, sha512_iv, 64);
> +	else if (rctx->flags & SHA_FLAGS_SHA512_224)
> +		memcpy(rctx->digest, sha512_224_iv, 64);
> +	else if (rctx->flags & SHA_FLAGS_SHA512_256)
> +		memcpy(rctx->digest, sha512_256_iv, 64);
> +}
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
> +	u64 bits[2];
> +
> +	AHASH_DBG(hace_dev, "rctx flags:0x%x\n", rctx->flags);
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

bits should be __be64

> +
> +/*
> + * Prepare DMA buffer before hardware engine
> + * processing.
> + */
> +static int aspeed_ahash_dma_prepare(struct aspeed_hace_dev *hace_dev)
> +{
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	struct ahash_request *req = hash_engine->ahash_req;
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +	struct device *dev = hace_dev->dev;
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
> +		dev_warn(dev, "Hash data length is too large\n");

What user could do with such message ?
This seems like an unhandled error.

> +	}
> +
> +	scatterwalk_map_and_copy(rctx->buffer, rctx->src_sg,
> +				 rctx->offset, remain, 0);
> +
> +	rctx->bufcnt = remain;
> +	rctx->digest_dma_addr = dma_map_single(hace_dev->dev, rctx->digest,
> +					       SHA512_DIGEST_SIZE,
> +					       DMA_BIDIRECTIONAL);
> +

All your dma_map_xx() are not checked for errors.
You should test your driver with CONFIG_DMA_API_DEBUG=y

[...]
> +		src_list[0].phy_addr = rctx->buffer_dma_addr;
> +		src_list[0].len = rctx->bufcnt;
> +		length -= src_list[0].len;
> +
> +		/* Last sg list */
> +		if (length == 0)
> +			src_list[0].len |= BIT(31);

The BIT(31) is used on lot of place, so you can use a define.

[...]
> +static int aspeed_hace_ahash_trigger(struct aspeed_hace_dev *hace_dev,
> +				     aspeed_hace_fn_t resume)
> +{
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	struct ahash_request *req = hash_engine->ahash_req;
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
> +	/* Dummy read for barriers */
> +	readl(hash_engine->ahash_src_addr);

Probably a real barrier function will be better.

[...]
> +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
> +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
> +
> +	scatterwalk_map_and_copy(rctx->buffer, rctx->src_sg, rctx->offset,
> +				 rctx->total - rctx->offset, 0);
> +
> +	rctx->bufcnt = rctx->total - rctx->offset;
> +	rctx->cmd &= ~HASH_CMD_HASH_SRC_SG_CTRL;
> +
> +	// no need to call final()?
> +	if (rctx->flags & SHA_FLAGS_FINUP)
> +		return aspeed_ahash_req_final(hace_dev);

This seems like a forgotten todo.

[...]
> +int aspeed_hace_hash_handle_queue(struct aspeed_hace_dev *hace_dev,
> +				  struct crypto_async_request *new_areq)
> +{
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	struct crypto_async_request *areq, *backlog;
> +	struct aspeed_sham_reqctx *rctx;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&hash_engine->lock, flags);
> +
> +	if (new_areq)
> +		ret = crypto_enqueue_request(&hash_engine->queue, new_areq);

Why didnt you use the crypto_engine API instead of rewriting it.

Regards
