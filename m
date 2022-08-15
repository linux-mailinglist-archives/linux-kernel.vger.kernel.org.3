Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE55592BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241911AbiHOJMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241895AbiHOJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:12:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02883220D4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:12:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bv3so8369489wrb.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=mZGNEIa1pqWi28sYb3bc4F38nKBbuQz26ll0NQAydIc=;
        b=VhLb3fH+gl+hRv8bCbnX9IKPW+Z4faV4V6Ta2OZT+8e/NlnviwsfWIcwQaPbz5lldW
         EcXJyhqjJHrT1YRTYnn6yar+BRSHvON/LyFf4cwvV8skNiKHl8KOq8nAkOofCnUfJtHl
         fCx3gr52DU8RXMCJX8iEjwDR9jpIMkjqtE+nxm46NCuluM59G1d4UeBQAvYy0c5O9abe
         r1+CZalq6T3OI67sUotRCxM68nhDxvNMKle/X7APXs+ERgk2NIiK926XrXaG9kL7wpAt
         p7aTH9lCAekFv7+rcYA0Jalnf3TvwuNXkKVKJV4zj2XpNBqUXZp6c2yyQW6Om2duSXz7
         3i1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=mZGNEIa1pqWi28sYb3bc4F38nKBbuQz26ll0NQAydIc=;
        b=JXRLeX8JImoBH1qSKCqPxB9M5W3Owf78Ap8LjseQAGKDVVdxi/41XVMpQyuYkaXRrZ
         4foPbPM9PO8Ci94JYvIM++7twctWoSzgSePWOLP6cYQWXm3H6B3H1xKpwvjK5coJ+YJL
         aDDE97fNvxxE3pZCXNEDGvZUO0B3ux4Xlmfl9YvolXRo4/nAwtI4vf7/P/O3EkEBLYxX
         sKP1LJmTSZqaQ+/VchysjI8z61m7JiZHgle6upU5kZTTeFgbMwmWb9ye/TgcpSVxqXYK
         QOAvmrKDxsPqpq0vc3gR29u1k4ktFEu+Nzo1FLMdvOJxzPPcWyV9RPFMktF9Yc89cfgk
         HEsQ==
X-Gm-Message-State: ACgBeo1qpjtH8f1wZQpKXCuO8Tv0M+7npgV2RbmMymhb+ig3G6Yn/CwN
        TOspZngJRne4RSFysRVGT6Y8pQ==
X-Google-Smtp-Source: AA6agR5eXQemuYfviMG9u2GM6Erb8/7KMsoyHCidkfaSXGw3KPxNvEbaJ+VcyGH4MM8tz9h/JWb8VA==
X-Received: by 2002:adf:fd4f:0:b0:220:60bc:3fc9 with SMTP id h15-20020adffd4f000000b0022060bc3fc9mr8217875wrs.398.1660554755381;
        Mon, 15 Aug 2022 02:12:35 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b002205ffe88edsm6705381wrr.31.2022.08.15.02.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:12:34 -0700 (PDT)
Date:   Mon, 15 Aug 2022 12:12:33 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, abelvesa@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 8/8] clk: imx93: add SAI IPG clk
Message-ID: <YvoOAYvLF9TTfK+w@linaro.org>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
 <20220815013039.474970-9-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815013039.474970-9-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-15 09:30:39, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The clk topology is as below:
> bus_aon_root------>\                  /--->SAI IPG
>                     -->SAI LPCG gate-->
> sai[x]_clk_root--->/                  \--->SAI MCLK
> 
> So use shared count as i.MX93 MU_B gate.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/clk-imx93.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> index 4008ab075dfe..6a76b9fdf18d 100644
> --- a/drivers/clk/imx/clk-imx93.c
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -28,6 +28,9 @@ enum clk_sel {
>  	MAX_SEL
>  };
>  
> +static u32 share_count_sai1;
> +static u32 share_count_sai2;
> +static u32 share_count_sai3;
>  static u32 share_count_mub;
>  
>  static const char *parent_names[MAX_SEL][4] = {
> @@ -215,9 +218,12 @@ static const struct imx93_clk_ccgr {
>  	{ IMX93_CLK_USDHC1_GATE,	"usdhc1",	"usdhc1_root",		0x9380, },
>  	{ IMX93_CLK_USDHC2_GATE,	"usdhc2",	"usdhc2_root",		0x93c0, },
>  	{ IMX93_CLK_USDHC3_GATE,	"usdhc3",	"usdhc3_root",		0x9400, },
> -	{ IMX93_CLK_SAI1_GATE,		"sai1",		"sai1_root",		0x9440, },
> -	{ IMX93_CLK_SAI2_GATE,		"sai2",		"sai2_root",		0x9480, },
> -	{ IMX93_CLK_SAI3_GATE,		"sai3",		"sai3_root",		0x94c0, },
> +	{ IMX93_CLK_SAI1_GATE,          "sai1",         "sai1_root",            0x9440, 0, &share_count_sai1},
> +	{ IMX93_CLK_SAI1_IPG,		"sai1_ipg_clk", "bus_aon_root",		0x9440, 0, &share_count_sai1},
> +	{ IMX93_CLK_SAI2_GATE,          "sai2",         "sai2_root",            0x9480, 0, &share_count_sai2},
> +	{ IMX93_CLK_SAI2_IPG,		"sai2_ipg_clk", "bus_wakeup_root",	0x9480, 0, &share_count_sai2},
> +	{ IMX93_CLK_SAI3_GATE,          "sai3",         "sai3_root",            0x94c0, 0, &share_count_sai3},
> +	{ IMX93_CLK_SAI3_IPG,		"sai3_ipg_clk", "bus_wakeup_root",	0x94c0, 0, &share_count_sai3},
>  	{ IMX93_CLK_MIPI_CSI_GATE,	"mipi_csi",	"media_apb_root",	0x9580, },
>  	{ IMX93_CLK_MIPI_DSI_GATE,	"mipi_dsi",	"media_apb_root",	0x95c0, },
>  	{ IMX93_CLK_LVDS_GATE,		"lvds",		"media_ldb_root",	0x9600, },
> -- 
> 2.37.1
> 
