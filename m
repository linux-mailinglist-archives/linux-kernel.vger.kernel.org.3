Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34B454732A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 11:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiFKJZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 05:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiFKJZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 05:25:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5892F5F8C1;
        Sat, 11 Jun 2022 02:25:43 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so723165wmz.2;
        Sat, 11 Jun 2022 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Y8/6Pp5nGe2A+PBHGnSzBKqXDqyKAzy6/w/p+LLoPqE=;
        b=fKuH9IFPhd8ollg8ZJdh50nLElXMUmYvIXhDkBYh6EsB9ZMN6jd9Bm+K47cU3nr7q3
         tVbyu6GfEZCxth2w9I1GSRzp9ytqPLPlFBedJ7DT1lDhxHu/+bzqtkFqlzCs6yl2Lnn+
         oHcXLBcrLdA85eSsdPZsTHB1JKzL2piN7aD2Jn/pEIRPzxOmozbZaMKoOMhRoFHs2N2l
         i/LaE0qNCn1JS8YMUpkn7QRyO5d29soOih/KyfGCYd5pWJQsMbuLpk/a8CeDKq+mUFrD
         Vcy7iQ4+RbEzxL1TR5Uys8uQ8gFv07vBGBzfn9uo8KvjP2ryp3O9Q0f8ejr7/XaJZ+y8
         LBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Y8/6Pp5nGe2A+PBHGnSzBKqXDqyKAzy6/w/p+LLoPqE=;
        b=WM0lVj3kWxOmhDi8uSj5QHVxYLXLBPNp1X9mGvI7sAn5ikss2criDtguOIIPnv/1LU
         Yp/aDcuqv1wOBU2vABw8GDVf9l1sXl0Bc+FfTQ6jaJBqeJLosJpz6k66CEHJHWlCNnDs
         iWWgbgC6JBfecm0cxkNyhvV+yNY2aos1WMIVoCxYkv3bfbPtUNb8l1IPK8eXDmBJWPAv
         sSaHdC3T+e9ehiqKnCBZhssKqenjvSj+e4fx2+oKm8O3VNTjfPWTBZc871YGxp3wax66
         xQeTCxb8HZ4XofZI8Z6zpQzoCzegMs6KvjfDjixq0M2/cIG6HhWii+hvr1mrsJl3xrNT
         j8cw==
X-Gm-Message-State: AOAM5313ysEKgdIAoLKR1L8TxPzadezC5yek9FxfRExEBvs4w/eqYrKl
        yKV1zHBNVpKCj2Oce56xYGw=
X-Google-Smtp-Source: ABdhPJyODB04BV+Y8YIGQ2QxI4z6EUu+ICtspXZRf3LSI9ZoiefZdZbGVuNKzB2ZMiYafTKqHOfgCQ==
X-Received: by 2002:a7b:cc8e:0:b0:39c:829d:609b with SMTP id p14-20020a7bcc8e000000b0039c829d609bmr2927131wma.160.1654939541797;
        Sat, 11 Jun 2022 02:25:41 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id q17-20020adffed1000000b00219f9829b71sm477266wrs.56.2022.06.11.02.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 02:25:41 -0700 (PDT)
Date:   Sat, 11 Jun 2022 11:25:39 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] crypto: sun8i-ss - fix infinite loop in
 sun8i_ss_setup_ivs()
Message-ID: <YqRfk2Jr++9WUk7h@Red>
References: <1654885635-32290-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1654885635-32290-1-git-send-email-khoroshilov@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Jun 10, 2022 at 09:27:15PM +0300, Alexey Khoroshilov a écrit :
> There is no i decrement in while (i >= 0) loop.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Fixes: 359e893e8af4 ("crypto: sun8i-ss - rework handling of IV")
> ---
>  drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
> index 5bb950182026..910d6751644c 100644
> --- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
> +++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
> @@ -170,6 +170,7 @@ static int sun8i_ss_setup_ivs(struct skcipher_request *areq)
>  	while (i >= 0) {
>  		dma_unmap_single(ss->dev, rctx->p_iv[i], ivsize, DMA_TO_DEVICE);
>  		memzero_explicit(sf->iv[i], ivsize);
> +		i--;
>  	}
>  	return err;
>  }
> -- 
> 2.7.4
> 

Acked-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks
