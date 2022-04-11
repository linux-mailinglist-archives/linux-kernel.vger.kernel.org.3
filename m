Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3734FB60A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343862AbiDKIfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343848AbiDKIfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:35:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67AC3E5FC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:33:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e8so5458918wra.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=27lr1TeRoTWAFLVF9iWjZf9oxGgkBi1ijJ2WmnDVaWw=;
        b=FCiOpWwMz1l33QbeB+Jtt4vgr1FQhMBvYuXg9CwxMEZsIcuVknweKFjUN7iW+2i9cK
         6icNeAlKmv9KMrFKBYTeJzTuTaLQrqAz87rGMry1dWZXm4WaTRZD8qkPhMoBRQIgboJq
         gkDMBZ4Iywc5c8AWFqttqw8Mf9H62DLQn1ShJ5V1P9YTxEyxOqX6P+22Zz2p+H8QQk7b
         72SKN7Xp2UiqKy1gotmgGVAH985FbXgT7oZ+HcB5XzDQ6YLW+zqHRxDP9MiZ9FTJ2hbG
         /qFhqT7Bdal9IeLusenPQiG3Pw7Ma5BF2J+9ynOn0iiNwFlEPSEVFRAdzuuhc8ZgZNrz
         60Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=27lr1TeRoTWAFLVF9iWjZf9oxGgkBi1ijJ2WmnDVaWw=;
        b=rFXqIX/LpZxaQdyRqZ+ehROGanxYH+xwQzZEtmq9DKYwcWpVTg+5DBURsCNeIidO1K
         M+7gaRfUISaaZvZY+jvVSCt3ggxsadKVjTbkRmq9qRxApNJ7vP7I0os/FcrqqWQPQflT
         wW2fIWllyyJFk5YM+JUGByuY4R4BI4Tz2DytMDavrgrYltgdGE0IUuoz7TmVb1bFEDWO
         Q4yb3lN0p9P6X0zZjoMgvKwzgsRim7xNPx6N3bSy/AlizghjLb2CBFmT8F7XlF3keGpy
         xGdLhwl8G2xYXAqO6Y/tMOqkNt1TNUtXiAit7tlTJvy75j8DNHdjL4tyYr8huWUA0hPd
         +P+w==
X-Gm-Message-State: AOAM530g5eHprCclEJMS1lGEOSUVcUJpbporQcYUb6ghTxCbev8TbhUk
        uBGBVDNZ6rzbqjXYxBa2tIurNQ==
X-Google-Smtp-Source: ABdhPJyMduce5eskJ2Cz9CC/3y6wawMSFNfIrfesrt3XjKQQPdmm+A6C+5gLz1aqtTxhi5MfzzLSUg==
X-Received: by 2002:a05:6000:1c14:b0:207:9988:2af0 with SMTP id ba20-20020a0560001c1400b0020799882af0mr11267923wrb.324.1649666005486;
        Mon, 11 Apr 2022 01:33:25 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm20206956wmp.44.2022.04.11.01.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 01:33:24 -0700 (PDT)
Date:   Mon, 11 Apr 2022 10:33:22 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     John Keeping <john@metanate.com>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 17/33] crypto: rockchip: use read_poll_timeout
Message-ID: <YlPn0nevX6zdYWwG@Red>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
 <20220401201804.2867154-18-clabbe@baylibre.com>
 <YkrYs87bgWs7+tOm@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YkrYs87bgWs7+tOm@donbot>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Apr 04, 2022 at 12:38:27PM +0100, John Keeping a écrit :
> On Fri, Apr 01, 2022 at 08:17:48PM +0000, Corentin Labbe wrote:
> > Use read_poll_timeout instead of open coding it
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  drivers/crypto/rockchip/rk3288_crypto_ahash.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
> > index 137013bd4410..21c9a0327ddf 100644
> > --- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
> > +++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
> > @@ -10,6 +10,7 @@
> >   */
> >  #include <linux/device.h>
> >  #include <asm/unaligned.h>
> > +#include <linux/iopoll.h>
> >  #include "rk3288_crypto.h"
> >  
> >  /*
> > @@ -305,8 +306,8 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
> >  		 * efficiency, and make it response quickly when dma
> >  		 * complete.
> >  		 */
> > -	while (!CRYPTO_READ(tctx->dev, RK_CRYPTO_HASH_STS))
> > -		udelay(10);
> > +	read_poll_timeout(readl, v, v == 0, 10, 1000, false,
> > +			  tctx->dev->dev + RK_CRYPTO_HASH_STS);
> 
> This can be simplified to:
> 
> 	readl_poll_timeout(tctx->dev->dev + RK_CRYPTO_HASH_STS,
> 			   v, v == 0, 10, 1000);

Thanks, this is better.

> 
> But shouldn't this be tctx->dev->reg ?!

Yes, I will fix it.

Thanks
Regards
