Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F35AAC38
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiIBKTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiIBKTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:19:15 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46043BD0B4;
        Fri,  2 Sep 2022 03:19:14 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oU3ku-000Kds-Rx; Fri, 02 Sep 2022 20:18:33 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Sep 2022 18:18:32 +0800
Date:   Fri, 2 Sep 2022 18:18:32 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-crypto@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Peng Wu <wupeng58@huawei.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] crypto: allwinner: Fix dma_map_sg error check
Message-ID: <YxHYeCSwfAEgMngX@gondor.apana.org.au>
References: <20220825072421.29020-1-jinpu.wang@ionos.com>
 <20220825072421.29020-6-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825072421.29020-6-jinpu.wang@ionos.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:24:20AM +0200, Jack Wang wrote:
> dma_map_sg return 0 on error.
> 
> Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Minghao Chi <chi.minghao@zte.com.cn>
> Cc: Peng Wu <wupeng58@huawei.com>
> Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Fixes: 06f751b61329 ("crypto: allwinner - Add sun8i-ce Crypto Engine")
> Fixes: d9b45418a917 ("crypto: sun8i-ss - support hash algorithms")
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c | 6 +++---
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c   | 2 +-
>  drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c | 4 ++--
>  drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c   | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
> index 74b4e910a38d..be7f46faef7e 100644
> --- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
> +++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
> @@ -208,7 +208,7 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
>  
>  	if (areq->src == areq->dst) {
>  		nr_sgs = dma_map_sg(ce->dev, areq->src, ns, DMA_BIDIRECTIONAL);
> -		if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
> +		if (!nr_sgs || nr_sgs > MAX_SG) {

This is also less robust than the original code and I'll be
reverting it.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
