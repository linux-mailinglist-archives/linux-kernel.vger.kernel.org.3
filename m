Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC504BD0E6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244622AbiBTTZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:25:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiBTTZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:25:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B313C715;
        Sun, 20 Feb 2022 11:24:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m27so11711447wrb.4;
        Sun, 20 Feb 2022 11:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VkufqB68vwU82OqW1wmmBDTcSYneYNTpwXuWchj68oY=;
        b=BQAEOqjgCS43797jo9OoAHnbWjCc0lci0e2p//X296F4B7h+l2Fur4fw6HKrQMhQ2a
         K2YjtUWCID637pDp1UT7DASqfoYKWvlOaO1K9fUPC2KAh+8/Kq9lfd3PjNTTgnKqJpTq
         xSH6ERovv99mUBjjSMP/SzY47PuFBWt9S0AuyEAmVKs3xb8m9i0BqrXmO3v4kMAbMP6A
         eoBZc+hu2QSNTsXStYqiolrENJRrP3l167agG/qXcPMjEUPsVBIDi0uKYi0YZR3G9BY2
         soNbjCZv8ppFZEAvLYm6HT3iTcvYcRUqPf2sy1k7QBQqq8W0rfL7HahrFsuvKmYrbFdk
         CBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VkufqB68vwU82OqW1wmmBDTcSYneYNTpwXuWchj68oY=;
        b=h0DngN7oRkCGTNnv7Acdi5aFLmGasRHm+AksXAc46M6/s2Y9Di19dCxx6t5b04WJGm
         orDGuk0DUqak1iaJloadGw/XD82nBFOOSe9Ug6/+0c5cBcKmXHLwkV7xCLkVy7TFlV4A
         LURHE9lJlwF0PyN1GKrcwoENrjN5ZuGKMMHidbO1x0kCJW5OlLYuyD0wBdQWEjCJ4rYf
         AF0tjWgpWFsK/QdfdXiJxDKqveUtUoYbGbYcNLqQ6j5iu82hern/ZNLYUi8pOWqc3CAL
         108IqOGuGH5AMMaFi0t9EWOWDfrrhF1JuN3EEz1+pkqGQUYQJfR+EojNo5YK40dX7XhA
         qv9w==
X-Gm-Message-State: AOAM530Ijszv+ecEf7cYoPNzWqkOzR2HJg6Ja4TBv9VQ1B/VvecV1d+G
        kzmGGA8g3N8jGXdM49nVyxaYPfshet4=
X-Google-Smtp-Source: ABdhPJz+6O/3f2qhitHyPOo8SiWkDrBCqXn48A/dehEtKdB3vRyvtwqZlbnkDPdSH/XeFwFxqOd0pQ==
X-Received: by 2002:adf:fe0f:0:b0:1e2:f9dc:6ed with SMTP id n15-20020adffe0f000000b001e2f9dc06edmr13605627wrr.530.1645385078997;
        Sun, 20 Feb 2022 11:24:38 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id f25sm5345021wml.16.2022.02.20.11.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 11:24:38 -0800 (PST)
Date:   Sun, 20 Feb 2022 20:24:36 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ccree: don't attempt 0 len DMA mappings
Message-ID: <YhKVdOI02tnvOl7R@Red>
References: <20220217192726.612328-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220217192726.612328-1-gilad@benyossef.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, Feb 17, 2022 at 09:27:26PM +0200, Gilad Ben-Yossef a écrit :
> Refuse to try mapping zero bytes as this may cause a fault
> on some configurations / platforms and it seems the prev.
> attempt is not enough and we need to be more explicit.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> Fixes: ce0fc6db38de ("crypto: ccree - protect against empty or NULL
> scatterlists")
> ---
>  drivers/crypto/ccree/cc_buffer_mgr.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c b/drivers/crypto/ccree/cc_buffer_mgr.c
> index a5e041d9d2cf..11e0278c8631 100644
> --- a/drivers/crypto/ccree/cc_buffer_mgr.c
> +++ b/drivers/crypto/ccree/cc_buffer_mgr.c
> @@ -258,6 +258,13 @@ static int cc_map_sg(struct device *dev, struct scatterlist *sg,
>  {
>  	int ret = 0;
>  
> +	if (!nbytes) {
> +		*mapped_nents = 0;
> +		*lbytes = 0;
> +		*nents = 0;
> +		return 0;
> +	}
> +
>  	*nents = cc_get_sgl_nents(dev, sg, nbytes, lbytes);
>  	if (*nents > max_sg_nents) {
>  		*nents = 0;
> -- 
> 2.25.1
> 

Hello

With this patch, the stacktrace I reported is not present anymore.

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-on: r8a7795-salvator-x

Regards
