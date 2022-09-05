Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA865AD4AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiIEOWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiIEOWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:22:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896A13B958;
        Mon,  5 Sep 2022 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=N7pFEpgeBITd5OyNwVUMI6CTbDxc2SQpld2QOauPWdU=; b=aof6Eyb7jjCXNwHwOoNzI7JX5Q
        XfDCkDcFFfP3QOsO5n0j9PbnMzE99XZesQ0FP+ytaZKGolBb4Ozmgw5pInJje5pDV9FT/sNhFkJFX
        qcAFjaEsHxtDxqT3L5LH30QD9UVehlEOIltBORXyGQndGAAKTkPDys1Y5DPgDdcbv4DiS7uMeTVKT
        LE7NjptLVxKe7IL3JBQsjkM2PgFE0dbAhhczhr1VwmrmF8zHvP7e60CMjlg+PTGBQAwFSvzFpU80S
        EKwXsGuKauhQBXgGUXTTaf6ZAgYiFC79ak2It1J/rRPQvMdV4o9WrluTJwDYQVPAFtNowdIJA0fIU
        FaPhRx8A==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVCzT-004M2O-6j; Mon, 05 Sep 2022 14:22:19 +0000
Message-ID: <c6335594-88f2-3769-234f-1135e3bb09b9@infradead.org>
Date:   Mon, 5 Sep 2022 07:22:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] crypto: aspeed: fix format unexpected build warning
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        BMC-SW@aspeedtech.com, kernel test robot <lkp@intel.com>
References: <20220905052449.1830669-1-neal_liu@aspeedtech.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220905052449.1830669-1-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/22 22:24, Neal Liu wrote:
> This fixes the following similar build warning when
> enabling compile test:
> 
> aspeed-hace-hash.c:188:9: warning: format '%x' expects argument of type
> 'unsigned int', but argument 7 has type 'size_t' {aka 'long unsigned int'}
> [-Wformat=]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> v2: Use "%zu" format to print size_t.
> 
>  drivers/crypto/aspeed/aspeed-hace-hash.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c b/drivers/crypto/aspeed/aspeed-hace-hash.c
> index 0a44ffc0e13b..6e833d238253 100644
> --- a/drivers/crypto/aspeed/aspeed-hace-hash.c
> +++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
> @@ -185,7 +185,7 @@ static int aspeed_ahash_dma_prepare_sg(struct aspeed_hace_dev *hace_dev)
>  	remain = (rctx->total + rctx->bufcnt) % rctx->block_size;
>  	length = rctx->total + rctx->bufcnt - remain;
>  
> -	AHASH_DBG(hace_dev, "%s:0x%x, %s:0x%x, %s:0x%x, %s:0x%x\n",
> +	AHASH_DBG(hace_dev, "%s:0x%x, %s:%zu, %s:0x%x, %s:0x%x\n",
>  		  "rctx total", rctx->total, "bufcnt", rctx->bufcnt,
>  		  "length", length, "remain", remain);
>  
> @@ -324,7 +324,7 @@ static int aspeed_hace_ahash_trigger(struct aspeed_hace_dev *hace_dev,
>  	struct ahash_request *req = hash_engine->req;
>  	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
>  
> -	AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x, length:0x%x\n",
> +	AHASH_DBG(hace_dev, "src_dma:%zu, digest_dma:%zu, length:%zu\n",
>  		  hash_engine->src_dma, hash_engine->digest_dma,
>  		  hash_engine->src_length);
>  

-- 
~Randy
