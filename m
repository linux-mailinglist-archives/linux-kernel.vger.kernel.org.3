Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04BE4CBFEB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiCCOWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiCCOWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:22:39 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462C118E3E6;
        Thu,  3 Mar 2022 06:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=qjeRQXDRHJDEOFaM/bFhRf+N+QLbWVSGAMDaOy7ZtIw=; b=Rvpp4
        8c8iAHDqTdLm8OD88p2G1kMMZO1W9Qi8uaYRy6VtgwIne1WnNP5cFq+1yHtWWbJKgAzkyrTZ2OD/t
        1GAjcpLSaQ2q1Z/zbJhwn+ZgShs+EEoJtL4NtYR7Lr4tJBrTiRgJjUiYtedY05KN3wsNw56tzeXd5
        xYsbHbNtEHBnddcHxE2yKCNmG24T3XqK0lcyH9rwZlwmW76WtWKTAsk6ZiB2mxqelhLwKG/iIkfPH
        Q4t4f9pYMq0gttOHOmdDFCcchJpb1xwWOAz2XvzIyq0SEQiHiymNXyNpwu9qTLXc/GpjeaUg474I2
        zs2suSeUxZ4I2VTyRjKIDlr7YdiWQ==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nPmKo-0005yL-KP; Thu, 03 Mar 2022 14:21:38 +0000
Date:   Thu, 3 Mar 2022 14:21:37 +0000
From:   John Keeping <john@metanate.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 06/18] crypto: rockchip: add fallback for cipher
Message-ID: <YiDO8Tt9Lhx530Oz@donbot>
References: <20220302211113.4003816-1-clabbe@baylibre.com>
 <20220302211113.4003816-7-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302211113.4003816-7-clabbe@baylibre.com>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 09:11:01PM +0000, Corentin Labbe wrote:
> The hardware does not handle 0 size length request, let's add a
> fallback.
> Furthermore fallback will be used for all unaligned case the hardware
> cannot handle.
> 
> Fixes: ce0183cb6464b ("crypto: rockchip - switch to skcipher API")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/crypto/rockchip/rk3288_crypto.h       |  2 +
>  .../crypto/rockchip/rk3288_crypto_skcipher.c  | 97 ++++++++++++++++---
>  2 files changed, 86 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
> index c919d9a43a08..8b1e15d8ddc6 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto.h
> +++ b/drivers/crypto/rockchip/rk3288_crypto.h
> @@ -246,10 +246,12 @@ struct rk_cipher_ctx {
>  	struct rk_crypto_info		*dev;
>  	unsigned int			keylen;
>  	u8				iv[AES_BLOCK_SIZE];
> +	struct crypto_skcipher *fallback_tfm;
>  };
>  
>  struct rk_cipher_rctx {
>  	u32				mode;
> +	struct skcipher_request fallback_req;   // keep at the end
>  };
>  
>  enum alg_type {
> diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
> index bbd0bf52bf07..bf9d398cc54c 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
> +++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
> @@ -13,6 +13,63 @@
>  
>  #define RK_CRYPTO_DEC			BIT(0)
>  
> +static int rk_cipher_need_fallback(struct skcipher_request *req)
> +{
> +	struct scatterlist *sgs, *sgd;
> +
> +	if (!req->cryptlen)
> +		return true;
> +
> +	sgs = req->src;
> +	while (sgs) {
> +		if (!IS_ALIGNED(sgs->offset, sizeof(u32))) {
> +			return true;
> +		}
> +		if (sgs->length % 16) {

Can this be relaxed to check for alignment to 4 rather than 16?  That's
the requirement for programming the registers.

But I think this check is wrong in general as it doesn't account for
cryptlen; with fscrypt I'm seeing sgs->length == 255 but cryptlen == 16
so the hardware can be used but at the moment the fallback path is
triggered.
