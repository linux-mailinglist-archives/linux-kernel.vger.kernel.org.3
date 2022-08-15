Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B0A592CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241874AbiHOJKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiHOJKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:10:00 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E796D21807
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:09:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id az6-20020a05600c600600b003a530cebbe3so3645108wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=KbV88Nyfrl4D5bH5/FyHyQsFA/7mQKDev2c0JUEvauU=;
        b=USMSxPjaLyEqSmOQ+JNN+dZVW+o9dCB2RaU8Pv+eZeHGjWtBbUjmstLH8bSjQ++6x2
         kNEtBgTVplhY4ClvB/8+vUiE7nLRptbhCKdxOfmBKH1U6EezrlndG+b5CVeRY9eNKeTR
         qdB0fVb/1aLzjvQKIPcKptj/PBCJIIumKARLKhsfmfWm77+DFUkhGfzRpFQrMsnfYPTl
         TJXHF5c4VDZtHdeUBAjBtlgP6CPzdWvNixDxThTIY8lrhRcmXkCeCrEySGN1C3j/kdiF
         WmJGbmgplTIb+k1cEWo/H435UKgWDCR2n7P26AS6sM8WMzWUs1tuPKIFrCvo0ZFSctdR
         4qWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KbV88Nyfrl4D5bH5/FyHyQsFA/7mQKDev2c0JUEvauU=;
        b=zB3CLEKECxkKLE2fLl3F46Oayi/Ro8ZDoRk2yX4+nRQELSTkSsqS11NsXyrDTKr85F
         3NRCEb5IkO9epLyMo+RC40Xr/5cuDKvCRbtmMbTC3WshXWkZReiDYOVeiTHHcot8YwMP
         eNFWq9SsutXgauDPM7UNukkj2One/WSpVuchQQkD7xZLqqkJtrwTSk7CDhwT4b3RWUoP
         rnoomCi8dsxXG15gYd/pT2CeROkYeNViTG2CGJjg1yCWnbJ4GYmtRL29pzSh6ywJnuQ6
         mPe3FSLPK2ekBf1AHC1y74brHoYeEL02WJLnMzmHaTp0to7V+YJhUkoCwtc5QfJBwAXH
         KNZg==
X-Gm-Message-State: ACgBeo3D0O4owMJ/M0E8Vffad9pR5w7GnnRrawqFzJs32Is0OZqQD6pE
        1zCcB/ivdfVF4zUnd/vsdYrLIw==
X-Google-Smtp-Source: AA6agR5+bgtG2yUf7658VOqMIddUylxAqR2nIRuGuCRZU2nZPbNOpPJOIXjHe9nh7q6W/suV5c3erA==
X-Received: by 2002:a05:600c:19c6:b0:3a5:ffb3:d527 with SMTP id u6-20020a05600c19c600b003a5ffb3d527mr890642wmq.106.1660554597513;
        Mon, 15 Aug 2022 02:09:57 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id b21-20020a05600c4e1500b003a50924f1c0sm8834296wmq.18.2022.08.15.02.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:09:56 -0700 (PDT)
Date:   Mon, 15 Aug 2022 12:09:54 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, abelvesa@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH V2 7/8] clk: imx93: add MU1/2 clock
Message-ID: <YvoNYidBvJ/dkonW@linaro.org>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
 <20220815013039.474970-8-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815013039.474970-8-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-15 09:30:38, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The clk tree should be as:
> bus_aon_root------>\               /--->MU1_B IP
>                     -->MU_B gate-->
> bus_wakeup_root--->/               \--->MU2_B IP
> 
> bus_aon_root------>\               /--->MU1_A IP
>                     -->MU_A gate-->
> bus_wakeup_root--->/               \--->MU2_A IP
> 
> So need use shared count gate. And linux use MU_B,
> so set MU_A clk as CLK_IGNORE_UNUSED.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/clk-imx93.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> index 73d30a2e64b0..4008ab075dfe 100644
> --- a/drivers/clk/imx/clk-imx93.c
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -28,6 +28,8 @@ enum clk_sel {
>  	MAX_SEL
>  };
>  
> +static u32 share_count_mub;
> +
>  static const char *parent_names[MAX_SEL][4] = {
>  	{"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "video_pll"},
>  	{"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "sys_pll_pfd2_div2"},
> @@ -159,8 +161,10 @@ static const struct imx93_clk_ccgr {
>  	{ IMX93_CLK_WDOG5_GATE,		"wdog5",	"osc_24m",		0x8400, },
>  	{ IMX93_CLK_SEMA1_GATE,		"sema1",	"bus_aon_root",		0x8440, },
>  	{ IMX93_CLK_SEMA2_GATE,		"sema2",	"bus_wakeup_root",	0x8480, },
> -	{ IMX93_CLK_MU_A_GATE,		"mu_a",		"bus_aon_root",		0x84c0, },
> -	{ IMX93_CLK_MU_B_GATE,		"mu_b",		"bus_aon_root",		0x8500, },
> +	{ IMX93_CLK_MU1_A_GATE,		"mu1_a",	"bus_aon_root",		0x84c0, CLK_IGNORE_UNUSED },
> +	{ IMX93_CLK_MU2_A_GATE,		"mu2_a",	"bus_wakeup_root",	0x84c0, CLK_IGNORE_UNUSED },
> +	{ IMX93_CLK_MU1_B_GATE,		"mu1_b",	"bus_aon_root",		0x8500, 0, &share_count_mub },
> +	{ IMX93_CLK_MU2_B_GATE,		"mu2_b",	"bus_wakeup_root",	0x8500, 0, &share_count_mub },
>  	{ IMX93_CLK_EDMA1_GATE,		"edma1",	"m33_root",		0x8540, },
>  	{ IMX93_CLK_EDMA2_GATE,		"edma2",	"wakeup_axi_root",	0x8580, },
>  	{ IMX93_CLK_FLEXSPI1_GATE,	"flexspi",	"flexspi_root",		0x8640, },
> -- 
> 2.37.1
> 
