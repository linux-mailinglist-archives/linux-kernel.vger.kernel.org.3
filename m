Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B414F13CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359500AbiDDL23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbiDDL2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:28:25 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B78286F4;
        Mon,  4 Apr 2022 04:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=LnoUpy8pxIXgWxR6IblJWmslcB05NK68pxcDoWJlSfk=; b=DS0Ou
        KQrIxO23qLzQ+DvY1bPnIzGjxCX+gnmtE3eBpqcpIXxFZjFSi0XgG2mnhdIc4Ik7fv8qpH+1Rgp+N
        bQAnGfv54pnAWgdwYR1UMrCb9NdGt+QiiVIqgiNUo92tROAqdINZ3OmjptNRJAHgYZjzg5ApcVHgF
        8qi5gA8zjgnPzlvpFLmA4qADwJOYI+N1gZVF1k9AmJVnnNoySJHIcnq0XUMJuDM7rDIdn+zyxYOyP
        WRSJp0L+JBAhncHRrGKPhcBvUAs4WOLn31lJ2K4mOzr81hAXgB6yJ+DI8y9+qs/yI9COakF74xcid
        XUYRM30D38syFfuDQtjFlGRJoQvXw==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nbKqe-0004ue-SJ; Mon, 04 Apr 2022 12:26:16 +0100
Date:   Mon, 4 Apr 2022 12:26:15 +0100
From:   John Keeping <john@metanate.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 06/33] crypto: rockchip: add fallback for cipher
Message-ID: <YkrV1z5GPVXc+d/X@donbot>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
 <20220401201804.2867154-7-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401201804.2867154-7-clabbe@baylibre.com>
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

On Fri, Apr 01, 2022 at 08:17:37PM +0000, Corentin Labbe wrote:
> The hardware does not handle 0 size length request, let's add a
> fallback.
> Furthermore fallback will be used for all unaligned case the hardware
> cannot handle.
> 
> Fixes: ce0183cb6464b ("crypto: rockchip - switch to skcipher API")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
> index bbd0bf52bf07..c6b601086c04 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
> +++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
> @@ -13,6 +13,71 @@
>  
>  #define RK_CRYPTO_DEC			BIT(0)
>  
> +static int rk_cipher_need_fallback(struct skcipher_request *req)
> +{
> +	struct scatterlist *sgs, *sgd;
> +	unsigned int todo, len;
> +	unsigned int bs = crypto_skcipher_blocksize(tfm);
> +
> +	if (!req->cryptlen)
> +		return true;
> +
> +	len = req->cryptlen;
> +	sgs = req->src;
> +	while (sgs) {
> +		if (!IS_ALIGNED(sgs->offset, sizeof(u32))) {
> +			return true;
> +		}
> +		todo = min(len, sgs->length);
> +		if (todo % bs) {
> +			return true;
> +		}
> +		len -= todo;
> +		sgs = sg_next(sgs);
> +	}
> +	len = req->cryptlen;
> +	sgd = req->dst;
> +	while (sgd) {
> +		if (!IS_ALIGNED(sgd->offset, sizeof(u32))) {
> +			return true;
> +		}
> +		todo = min(len, sgd->length);
> +		if (todo % bs) {
> +			return true;
> +		}
> +		len -= todo;
> +		sgd = sg_next(sgd);
> +	}
> +	sgs = req->src;
> +	sgd = req->dst;
> +	while (sgs && sgd) {
> +		if (sgs->length != sgd->length)

This check still seems to be triggering the fallback when it is not
needed.

I've done some testing with fscrypt and the series is working great, but
the stats show the fallback triggering more than I'd expect.  With some
extra logging here I see output like:

	sgs->length=32 sgd->length=255 req->cryptlen=16

In this case sgs and sgd are both the first (and only) entries in the
list.  Should this take account of req->cryptlen as well?

In fact, can't this whole function be folded into one loop over src and
dst at the same time, since all the checks must be the same?  Something
like this (untested):

	while (sgs && sgd) {
		if (!IS_ALIGNED(sgs->offset, sizeof(u32)) ||
		    !IS_ALIGNED(sgd->offset, sizeof(u32)))
			return true;

		todo = min(len, sgs->length);
		if (todo % bs)
			return true;

		if (sgd->length < todo)
			return true;

		len -= todo;
		sgs = sg_next(sgs);
		sgd = sg_next(sgd);
	}

	if (len)
		return true;

> +			return true;
> +		sgs = sg_next(sgs);
> +		sgd = sg_next(sgd);
> +	}
> +	return false;
> +}
