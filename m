Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27A94E9CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbiC1Q7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiC1Q7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:59:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E340C4CD4B;
        Mon, 28 Mar 2022 09:57:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a8so29908300ejc.8;
        Mon, 28 Mar 2022 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wBY8GOjTBGWVEL0GTMWI6P1arfhZD9nF3EMgpiHJ8pg=;
        b=TrhfV81sE8oJYSmCYeOpiNX4rwzFlNa0YYzLP08JEAl6V9ZLFZAITEpA+veBQrtYXd
         nTIjE75VTCdIqCw6ACstHID8jmEUgPezsa2Ye+Q8W1m3xfHTfeACSgW68kRyL0MmayFL
         y6fCbN7XOb4+BqlfFW+POMeDwCKcSLdInFNbxW1/RObEC7S48YVIEaaj7mIRVg9cBG15
         2beqkvhDpR66XCMne9A7AkOOyftPDo8lqXCdH3KL4usS/GBmP0v4FgXC0I0ohOZ3So6t
         JRh1x+o00LD4zh72QK1QlcGKLfNkewdqNuktuGZnEQEyx0ijfjAX/mqSuMPxI5K9/NIS
         EQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wBY8GOjTBGWVEL0GTMWI6P1arfhZD9nF3EMgpiHJ8pg=;
        b=b/HWAANSSAgj7N2sbARHIp85cju/6wieArTUtr9yRGrt9z9kXzj6UpHVpMAnhGilMC
         USkt6cHlb2vm8qJakP0bEV1YdB7djmEvfMipWYYqk1txS2txLIWe9Dq7JEsycTgTTkXr
         uMFNThoE7jBMeflNREz2ueNZKp8Zp1IiMiqZHBRk2e8MmuYCguLYyloQRrsqgl/JVobM
         XNH8Y8vsQYW3AWvDhz/tVfqEN29AHYDJzsWC3sPC5MhCy5eIzLTyPsq6DzfVSWPBenpK
         6WPvxCwSvN1OjC65evSGXX5HI3Mcw+e29gZs8tGrZ+p68f8m1jXXjym+uKeA7XXG3GBu
         XRRQ==
X-Gm-Message-State: AOAM531OKdieaSY5IKM5b8byoB4DjSecZCZcsXKRjHOWZqe4t/l+Y3Rz
        cos9igW8S7oWOiRCuVOUTqo=
X-Google-Smtp-Source: ABdhPJwbZdbg18gH4uRako7Q+MjVs4nlqqVBcAfzLaiEeJvaLPgfUTObm+Sv22eUIX11zO3Tys/+HQ==
X-Received: by 2002:a17:907:2a53:b0:6ce:e4fe:3f92 with SMTP id fe19-20020a1709072a5300b006cee4fe3f92mr28685432ejc.389.1648486649986;
        Mon, 28 Mar 2022 09:57:29 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090635cc00b006e055c9c91esm6038305ejb.101.2022.03.28.09.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 09:57:29 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wan Jiabing <wanjiabing@vivo.com>
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: Re: [PATCH] clk: sunxi-ng: fix not NULL terminated coccicheck error
Date:   Mon, 28 Mar 2022 18:57:28 +0200
Message-ID: <2621623.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20220328073931.36544-1-wanjiabing@vivo.com>
References: <20220328073931.36544-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 28. marec 2022 ob 09:39:31 CEST je Wan Jiabing napisal(a):
> Fix the following coccicheck error:
> ./drivers/clk/sunxi-ng/ccu-sun6i-rtc.c:348:1-2: sun6i_rtc_ccu_match is
> not NULL terminated at line 348
> 
> Fixes: d91612d7f01a ("clk: sunxi-ng: Add support for the sun6i RTC clocks")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c index 8a10bade7e0d..ffb72d9a9c36
> 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> @@ -346,6 +346,7 @@ static const struct of_device_id sun6i_rtc_ccu_match[] =
> { .compatible	= "allwinner,sun50i-r329-rtc",
>  		.data		= &sun50i_r329_rtc_ccu_data,
>  	},
> +	{},
>  };
> 
>  int sun6i_rtc_ccu_probe(struct device *dev, void __iomem *reg)




