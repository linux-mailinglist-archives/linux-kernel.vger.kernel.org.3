Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3883B5AC928
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbiIEDgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIEDgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:36:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE622CDD8;
        Sun,  4 Sep 2022 20:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=oRVtV+KDU0L0hxdOqGB4binGje5K4V+L3ZgFTFnPQzs=; b=eZG6c0ynV+ttEFvsEXF4UbyPJS
        dVaStY3ltBUSznp2OIEzeNhHpZoSqOM2PB/E3MCNLJOJC7g0V3/SFZ44/WKgrqpFWKVuozSheQcj6
        bSgNfdxCOusQuBulXUEuVr7xbHzJUJU5KRAk+f0pYFcb0lgA9PISnh/Z/umEt4ZnbIQYbKw93jFCY
        1877jihYp+B41BKw6UTzOE58dVUoigx5PRQaoPzIHaR1TNZLhlDQgpscvYjKxjWzIA3exieJxmDui
        p0nyV/Qbp8Ct+oUdbsI+KYYb4hhb77FfdR70cwbUkxKVn6oUPFvsHQ88LGfwLtumgzKukvHkGMVAd
        gv5cClWg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oV2uQ-007Jzq-E5; Mon, 05 Sep 2022 03:36:32 +0000
Message-ID: <64caed2a-fafe-040d-c967-5eebaf6b144d@infradead.org>
Date:   Sun, 4 Sep 2022 20:36:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] crypto: aspeed: fix format unexpected build warning
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        BMC-SW@aspeedtech.com, kernel test robot <lkp@intel.com>
References: <20220905032838.1663510-1-neal_liu@aspeedtech.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220905032838.1663510-1-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/22 20:28, Neal Liu wrote:
> This fixes the following similar build warning when
> enabling compile test:
> 
> aspeed-hace-hash.c:188:9: warning: format '%x' expects argument of type
> 'unsigned int', but argument 7 has type 'size_t' {aka 'long unsigned int'}
> [-Wformat=]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/crypto/aspeed/aspeed-hace-hash.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c b/drivers/crypto/aspeed/aspeed-hace-hash.c
> index 0a44ffc0e13b..d0f61149fe24 100644
> --- a/drivers/crypto/aspeed/aspeed-hace-hash.c
> +++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
> @@ -186,7 +186,7 @@ static int aspeed_ahash_dma_prepare_sg(struct aspeed_hace_dev *hace_dev)
>  	length = rctx->total + rctx->bufcnt - remain;
>  
>  	AHASH_DBG(hace_dev, "%s:0x%x, %s:0x%x, %s:0x%x, %s:0x%x\n",
> -		  "rctx total", rctx->total, "bufcnt", rctx->bufcnt,
> +		  "rctx total", rctx->total, "bufcnt", (u32)rctx->bufcnt,
>  		  "length", length, "remain", remain);
>  
>  	sg_len = dma_map_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
> @@ -325,8 +325,8 @@ static int aspeed_hace_ahash_trigger(struct aspeed_hace_dev *hace_dev,
>  	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
>  
>  	AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x, length:0x%x\n",
> -		  hash_engine->src_dma, hash_engine->digest_dma,
> -		  hash_engine->src_length);
> +		  (u32)hash_engine->src_dma, (u32)hash_engine->digest_dma,
> +		  (u32)hash_engine->src_length);
>  
>  	rctx->cmd |= HASH_CMD_INT_ENABLE;
>  	hash_engine->resume = resume;

No, size_t values should be printed with %zu.
No cast needed.

-- 
~Randy
