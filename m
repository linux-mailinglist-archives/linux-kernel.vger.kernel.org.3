Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40E24FC17B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348286AbiDKPyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241114AbiDKPyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:54:06 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1181157;
        Mon, 11 Apr 2022 08:51:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r206-20020a1c44d7000000b0038ccb70e239so4870867wma.3;
        Mon, 11 Apr 2022 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YS8EHgwmMuCqhyig1rAaWaRxXw3QqtoY27L8Jll0TfY=;
        b=As31xpNOOXW4cOL7/qqPuWMExguKMbXyka+Vh9C9W/8PbSFivYI75aVr2GVZmJcjgr
         kV8l4qy2Tg7yf0ZL0HMf5UlajwgEf/6IO/yB2BV/rekMrDTVP6T54LENY+PjKv515hDK
         ZulGZCIDUpMCpb47TlwyOwE+tf8P1n0XEh5rwPXgJlJVevhJ/jqjrXGRRzT3fvG8b2KJ
         fYzEnlx7I+/Lhth6iiZHjNNVJEmdTdiiMSUZ0YhWi1SfgfKAuAC/pvQ0gPD0kQRLB5k4
         WGwwSqF83vJ73SX0VyHlRTH15XOHjv+7fdr0/gn9Z0trOGwQ9wpZUIlh8rozIZsSrxgX
         wqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YS8EHgwmMuCqhyig1rAaWaRxXw3QqtoY27L8Jll0TfY=;
        b=0Ji2G9N/m1GLdbzX3IiOHmmuexY2aJgT3FNfaIroypNmL6wiNv6cLjhK2k5Ix3aItz
         KqV11reX2iYAyuLDR9ZQ2og3s+H6nZe8wnSnUU6ukggN6G19mAtePs6Nc0kjxS7KLppP
         s5aXDZgF3T43SXEoX53BcOQq1vI0r1Im1NM9yEf+LzGVhPxXaE+wCxoo+7ZXf4G6r0UX
         uU/vUQta2vZ4UwbotqrVaZeZJQ6edxNffnKuTn4ynxqULFTxnXfGiETFrSOYYOx9838S
         Ke70RmvJROnpR3t7m18shZvHh5bTrdNZoXOSUyiAwufruWwSeBhjkEEhHpBv6X4+RSp6
         Rd6Q==
X-Gm-Message-State: AOAM531jt84EtQIxJXBFeZMDaFu60KgTwXaWRvZU2cVHoEd+iLif3LO2
        kN9wj9b6C79jxRHpRv1WHqw=
X-Google-Smtp-Source: ABdhPJxvtJQJT9jI/s9bYQuO90GNiVMlLPs03qEqheRFSe8rV0SXjb9P9bAhHpKdX5WiBso6FB1JZw==
X-Received: by 2002:a7b:cb05:0:b0:38c:7910:d935 with SMTP id u5-20020a7bcb05000000b0038c7910d935mr29586332wmj.170.1649692310794;
        Mon, 11 Apr 2022 08:51:50 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id u1-20020a056000038100b00207a578e9d4sm4140041wrf.89.2022.04.11.08.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:51:50 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 07/10] drm/sun4i: Add support for D1 mixers
Date:   Mon, 11 Apr 2022 17:51:49 +0200
Message-ID: <1721354.VLH7GnMWUR@kista>
In-Reply-To: <20220411043423.37333-8-samuel@sholland.org>
References: <20220411043423.37333-1-samuel@sholland.org> <20220411043423.37333-8-samuel@sholland.org>
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

Dne ponedeljek, 11. april 2022 ob 06:34:19 CEST je Samuel Holland napisal(a):
> D1 has a display engine with the usual pair of mixers, albeit with
> relatively few layers. In fact, D1 appears to be the first SoC to have
> a mixer without any UI layers. Add support for these new variants.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> 
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/
sun8i_mixer.c
> index f5e8aeaa3cdf..49c0d17c6f0a 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -585,6 +585,24 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg 
= {
>  	.mod_rate = 150000000,
>  };
>  
> +static const struct sun8i_mixer_cfg sun20i_d1_mixer0_cfg = {
> +	.ccsc		= 2,
> +	.mod_rate	= 297000000,
> +	.scaler_mask	= 0x3,
> +	.scanline_yuv	= 2048,
> +	.ui_num		= 1,
> +	.vi_num		= 1,
> +};
> +
> +static const struct sun8i_mixer_cfg sun20i_d1_mixer1_cfg = {
> +	.ccsc		= 1,
> +	.mod_rate	= 297000000,
> +	.scaler_mask	= 0x1,
> +	.scanline_yuv	= 1024,
> +	.ui_num		= 0,
> +	.vi_num		= 1,
> +};
> +
>  static const struct sun8i_mixer_cfg sun50i_a64_mixer0_cfg = {
>  	.ccsc		= 0,
>  	.mod_rate	= 297000000,
> @@ -638,6 +656,14 @@ static const struct of_device_id sun8i_mixer_of_table[] 
= {
>  		.compatible = "allwinner,sun8i-v3s-de2-mixer",
>  		.data = &sun8i_v3s_mixer_cfg,
>  	},
> +	{
> +		.compatible = "allwinner,sun20i-d1-de2-mixer-0",
> +		.data = &sun20i_d1_mixer0_cfg,
> +	},
> +	{
> +		.compatible = "allwinner,sun20i-d1-de2-mixer-1",
> +		.data = &sun20i_d1_mixer1_cfg,
> +	},
>  	{
>  		.compatible = "allwinner,sun50i-a64-de2-mixer-0",
>  		.data = &sun50i_a64_mixer0_cfg,
> -- 
> 2.35.1
> 
> 


