Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366294FC0A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348037AbiDKP2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348375AbiDKP2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:28:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2F318E32;
        Mon, 11 Apr 2022 08:25:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso3691187wml.1;
        Mon, 11 Apr 2022 08:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RzsEqdN9GWBZCp9gbidm1vb5G8aw4lFe2X8gpnY6F9U=;
        b=JQrYEIFBxiKgk+B/U4eSm8qQmxNxlhQQJSFEVnH4IiJtIEp3Iyxq5LhWBdVbC9LXNE
         fjx+B0j5+rGkH6hhrv3Vhu2BCOPj7AWkXgjJ8+uaYU2cbY/BVn09qPoZtz4r7WmtCgRc
         6jAhjsJke1LITOa0Vfldz77wZj1VlbRfWgN7pe8I6kxAzvSOYjNJJc4Nw7MG9YNr4aUG
         SGm8GZ0/H9xwhSw4bjPRJ9LCkvogFt2nujW+EA73cCJFafK8gHwzuZw+mRbDJ1aVEqlI
         0njk9NS0L8d1rnRwHRpEArL4g96GYrOCP53MSQAnvE3aRkjnwc2JjwMeLuM8fqhl4EFJ
         Kb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RzsEqdN9GWBZCp9gbidm1vb5G8aw4lFe2X8gpnY6F9U=;
        b=owLh2HgLeV2mOLeM+m3QoIE+10TxU9l8YDJL6P+5Of4Mqyusetg4rjkuUD3STENhNI
         9dLu5XpxeweZ2UmQ6k3aMeCo35HDaqGh2fQBo7GEffyG87bx58w363k+Qbi/MMozCbih
         4U3QsGXHkWamBFOR8gxTXtap+r9QMqJ6C52LCKV5K6lZxhDbsS1HoloiEvhcLOM+QdkG
         JW4LSjo9nOHtTaWiHFTjqSwtUMSq6IkBmJl1HKO9gOkv7M3nfETNHIrSD/UT02Qm5/Pe
         r+WLFm9rGDtGGxd2UG8sfwW+395CZLred9PRaYyeCECohxE/p783eOxlOFKI4VwB4MfC
         xpRQ==
X-Gm-Message-State: AOAM532mQJXb5017l400UucUUVxr6LkoK6tXYje2uZyt9bisb5L90FDV
        FBOt0v2qLF9zx2TeDAm9Gs8=
X-Google-Smtp-Source: ABdhPJwEBfXcqXbo6nKoX7IGK2b48hhx00NtVYuq45Z9JeLIYxRw6WPyZdqv7NpnPbruES0SS+KWOQ==
X-Received: by 2002:a1c:f607:0:b0:381:1db:d767 with SMTP id w7-20020a1cf607000000b0038101dbd767mr28969100wmc.165.1649690700192;
        Mon, 11 Apr 2022 08:25:00 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id a7-20020adffb87000000b00207982c7f4dsm9126970wrr.67.2022.04.11.08.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:24:59 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi-ng: sun6i-rtc: Mark rtc-32k as critical
Date:   Mon, 11 Apr 2022 17:24:58 +0200
Message-ID: <2233461.ElGaqSPkdT@kista>
In-Reply-To: <20220411050100.40964-1-samuel@sholland.org>
References: <20220411050100.40964-1-samuel@sholland.org>
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

Dne ponedeljek, 11. april 2022 ob 07:00:59 CEST je Samuel Holland napisal(a):
> Because some newer hardware variants have multiple possible parents for
> the RTC's timekeeping clock, this driver models it as a "rtc-32k" clock.
> However, it does not add any consumer for this clock. This causes the
> common clock framework to disable it, preventing RTC time access.
> 
> Since the RTC's timekeeping clock should always be enabled, regardless
> of which drivers are loaded, let's mark this clock as critical instead
> of adding a consumer in the RTC driver.
> 
> Fixes: d91612d7f01a ("clk: sunxi-ng: Add support for the sun6i RTC clocks")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> 
>  drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-
sun6i-rtc.c
> index 8a10bade7e0d..3d9c9ce5a3db 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> @@ -241,6 +241,7 @@ static struct clk_init_data rtc_32k_init_data = {
>  	.ops		= &ccu_mux_ops,
>  	.parent_hws	= rtc_32k_parents,
>  	.num_parents	= ARRAY_SIZE(rtc_32k_parents), /* updated 
during probe */
> +	.flags		= CLK_IS_CRITICAL,
>  };
>  
>  static struct ccu_mux rtc_32k_clk = {
> -- 
> 2.35.1
> 
> 


