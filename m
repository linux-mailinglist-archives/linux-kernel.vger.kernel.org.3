Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E3653DE33
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 22:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347296AbiFEUiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 16:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347265AbiFEUiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 16:38:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4505C4B1C9;
        Sun,  5 Jun 2022 13:38:17 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id er5so16357157edb.12;
        Sun, 05 Jun 2022 13:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNnynUKcgeiozIU8KTHt+2yaOZmO7IY/1RKfVE219wo=;
        b=Ao31iEc9fXCxmKTxTr4wM66fMw79wMOQZC4rKQYRQwmMKzxtaRLJrXnxL5UvElU1TY
         SzY9z1jgrnKAIYBjH5hIm4aPAH47eN+ZsYQ1nNVafiKMlO1jY5VtsTknVkKchdKPZW8p
         CaZprYakNdm9F4aRs3rUhGNGL6QbR9FcZd/Y460D7ky3GaxcWS8RUaB5FkqtK2Qp8PSo
         HGsKB3sfdwoRIkVl7CEYcaF6NrRPlhgQ32P2MxubniEpX2jo6BUwNuk627A/Miu/MIA4
         +vid3CIUB0pEtlwuN6Q0EH6C/dJGQg6zyTnjM31KnouDAmCwLoVxLG6ZTVvEUQy+v+u7
         LB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNnynUKcgeiozIU8KTHt+2yaOZmO7IY/1RKfVE219wo=;
        b=Exyu72WqCYxv4K7WGauzFu2ERvZR1m7ibk0kxed9XaUMvaChHX8XinqNm5LMN+yCDI
         PNr0sVnDE8JW2yY/7BCiU9U+iF43G3h9N5nRRI2BYIFdwSjFse8ZYlqcOugdwtw9NJJC
         ft218akDej5bxML7stI49Ir64uKD3URStSkyFcA35k8ED8dEK8WkxO+t/XNKsHuhTINw
         u+gdNv62xw1KS0zSyvxBKZ+lYWHB+OZuJT2Pp54vbRQM2fygH2ocdwpNzmC/BOIaMxfH
         d4gAejbEMSroPKkqMq7Quu68r3XjYKQPavRW4IWG68EvHEMdX5/iDJaT81DVEOHZ85e9
         ln1g==
X-Gm-Message-State: AOAM5303ljmXyKU//BOOXHElKgTJ8nsKWBF7v8+f7HJBftVGYXTv5e69
        HgI/a3kYhWDQdUJC5ULfmTQ=
X-Google-Smtp-Source: ABdhPJyiDkRNcnB8KKBcbHBhV+v9pMBWdgEswYppYEgopYMoNaAtDKuz5Zoj6F5Uach1LVv644uS0A==
X-Received: by 2002:a05:6402:2409:b0:431:5c52:8128 with SMTP id t9-20020a056402240900b004315c528128mr1801841eda.290.1654461495716;
        Sun, 05 Jun 2022 13:38:15 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id aj12-20020a1709069a4c00b006fec56c57f3sm5475217ejc.178.2022.06.05.13.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 13:38:15 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi-ng: Deduplicate ccu_clks arrays
Date:   Sun, 05 Jun 2022 22:38:14 +0200
Message-ID: <2102959.irdbgypaU6@jernej-laptop>
In-Reply-To: <20220531043539.41549-1-samuel@sholland.org>
References: <20220531043539.41549-1-samuel@sholland.org>
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

Dne torek, 31. maj 2022 ob 06:35:39 CEST je Samuel Holland napisal(a):
> The ccu_clks arrays are used to link ccu_common objects to a platform
> device during probe. There is no requirement that the clk_hw inside the
> ccu_common object ever gets registered with the clock framework. So the
> drivers do not need a separate ccu_clks array for each CCU variant.
> A single array per driver, containing the union of the CCU clocks from
> all variants, is sufficient.
> 
> Let's save some space by combining the ccu_clks arrays in each driver.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> 
>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c |  16 +---
>  drivers/clk/sunxi-ng/ccu-sun8i-de2.c   |  77 +++++------------
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c    | 113 +------------------------
>  drivers/clk/sunxi-ng/ccu-sun8i-r.c     |  40 ++-------
>  drivers/clk/sunxi-ng/ccu-sun8i-v3s.c   |  80 +----------------
>  5 files changed, 37 insertions(+), 289 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c index 29a8c710ae06..001582ea71ba
> 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> @@ -138,19 +138,9 @@ static struct ccu_common *sun50i_h6_r_ccu_clks[] = {
>  	&r_apb2_rsb_clk.common,
>  	&r_apb1_ir_clk.common,
>  	&r_apb1_w1_clk.common,
> -	&ir_clk.common,
> -	&w1_clk.common,
> -};
> -
> -static struct ccu_common *sun50i_h616_r_ccu_clks[] = {
> -	&r_apb1_clk.common,
> -	&r_apb2_clk.common,
> -	&r_apb1_twd_clk.common,
> -	&r_apb2_i2c_clk.common,
> -	&r_apb2_rsb_clk.common,
> -	&r_apb1_ir_clk.common,
>  	&r_apb1_rtc_clk.common,
>  	&ir_clk.common,
> +	&w1_clk.common,
>  };
> 
>  static struct clk_hw_onecell_data sun50i_h6_r_hw_clks = {
> @@ -218,8 +208,8 @@ static const struct sunxi_ccu_desc sun50i_h6_r_ccu_desc
> = { };
> 
>  static const struct sunxi_ccu_desc sun50i_h616_r_ccu_desc = {
> -	.ccu_clks	= sun50i_h616_r_ccu_clks,
> -	.num_ccu_clks	= ARRAY_SIZE(sun50i_h616_r_ccu_clks),
> +	.ccu_clks	= sun50i_h6_r_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun50i_h6_r_ccu_clks),
> 
>  	.hw_clks	= &sun50i_h616_r_hw_clks,
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c index e7e3ddf4a227..2f6f02f00be2
> 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> @@ -53,65 +53,26 @@ static SUNXI_CCU_M(wb_div_a83_clk, "wb-div", "pll-de",
> 0x0c, 8, 4, static SUNXI_CCU_M(rot_div_a83_clk, "rot-div", "pll-de", 0x0c,
> 0x0c, 4, CLK_SET_RATE_PARENT);
> 
> -static struct ccu_common *sun8i_a83t_de2_clks[] = {
> +static struct ccu_common *sun8i_de2_ccu_clks[] = {
>  	&mixer0_clk.common,
>  	&mixer1_clk.common,
>  	&wb_clk.common,
> -
> -	&bus_mixer0_clk.common,
> -	&bus_mixer1_clk.common,
> -	&bus_wb_clk.common,
> -
> -	&mixer0_div_a83_clk.common,
> -	&mixer1_div_a83_clk.common,
> -	&wb_div_a83_clk.common,
> -
> -	&bus_rot_clk.common,
>  	&rot_clk.common,
> -	&rot_div_a83_clk.common,
> -};
> -
> -static struct ccu_common *sun8i_h3_de2_clks[] = {
> -	&mixer0_clk.common,
> -	&mixer1_clk.common,
> -	&wb_clk.common,
> -
> -	&bus_mixer0_clk.common,
> -	&bus_mixer1_clk.common,
> -	&bus_wb_clk.common,
> -
> -	&mixer0_div_clk.common,
> -	&mixer1_div_clk.common,
> -	&wb_div_clk.common,
> -};
> -
> -static struct ccu_common *sun8i_v3s_de2_clks[] = {
> -	&mixer0_clk.common,
> -	&wb_clk.common,
> -
> -	&bus_mixer0_clk.common,
> -	&bus_wb_clk.common,
> -
> -	&mixer0_div_clk.common,
> -	&wb_div_clk.common,
> -};
> -
> -static struct ccu_common *sun50i_a64_de2_clks[] = {
> -	&mixer0_clk.common,
> -	&mixer1_clk.common,
> -	&wb_clk.common,
> 
>  	&bus_mixer0_clk.common,
>  	&bus_mixer1_clk.common,
>  	&bus_wb_clk.common,
> +	&bus_rot_clk.common,
> 
>  	&mixer0_div_clk.common,
>  	&mixer1_div_clk.common,
>  	&wb_div_clk.common,
> -
> -	&bus_rot_clk.common,
> -	&rot_clk.common,
>  	&rot_div_clk.common,
> +
> +	&mixer0_div_a83_clk.common,
> +	&mixer1_div_a83_clk.common,
> +	&wb_div_a83_clk.common,
> +	&rot_div_a83_clk.common,
>  };
> 
>  static struct clk_hw_onecell_data sun8i_a83t_de2_hw_clks = {
> @@ -219,8 +180,8 @@ static struct ccu_reset_map sun50i_h5_de2_resets[] = {
>  };
> 
>  static const struct sunxi_ccu_desc sun8i_a83t_de2_clk_desc = {
> -	.ccu_clks	= sun8i_a83t_de2_clks,
> -	.num_ccu_clks	= ARRAY_SIZE(sun8i_a83t_de2_clks),
> +	.ccu_clks	= sun8i_de2_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun8i_de2_ccu_clks),
> 
>  	.hw_clks	= &sun8i_a83t_de2_hw_clks,
> 
> @@ -229,8 +190,8 @@ static const struct sunxi_ccu_desc
> sun8i_a83t_de2_clk_desc = { };
> 
>  static const struct sunxi_ccu_desc sun8i_h3_de2_clk_desc = {
> -	.ccu_clks	= sun8i_h3_de2_clks,
> -	.num_ccu_clks	= ARRAY_SIZE(sun8i_h3_de2_clks),
> +	.ccu_clks	= sun8i_de2_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun8i_de2_ccu_clks),
> 
>  	.hw_clks	= &sun8i_h3_de2_hw_clks,
> 
> @@ -239,8 +200,8 @@ static const struct sunxi_ccu_desc sun8i_h3_de2_clk_desc
> = { };
> 
>  static const struct sunxi_ccu_desc sun8i_r40_de2_clk_desc = {
> -	.ccu_clks	= sun50i_a64_de2_clks,
> -	.num_ccu_clks	= ARRAY_SIZE(sun50i_a64_de2_clks),
> +	.ccu_clks	= sun8i_de2_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun8i_de2_ccu_clks),
> 
>  	.hw_clks	= &sun50i_a64_de2_hw_clks,
> 
> @@ -249,8 +210,8 @@ static const struct sunxi_ccu_desc
> sun8i_r40_de2_clk_desc = { };
> 
>  static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_desc = {
> -	.ccu_clks	= sun8i_v3s_de2_clks,
> -	.num_ccu_clks	= ARRAY_SIZE(sun8i_v3s_de2_clks),
> +	.ccu_clks	= sun8i_de2_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun8i_de2_ccu_clks),
> 
>  	.hw_clks	= &sun8i_v3s_de2_hw_clks,
> 
> @@ -259,8 +220,8 @@ static const struct sunxi_ccu_desc
> sun8i_v3s_de2_clk_desc = { };
> 
>  static const struct sunxi_ccu_desc sun50i_a64_de2_clk_desc = {
> -	.ccu_clks	= sun50i_a64_de2_clks,
> -	.num_ccu_clks	= ARRAY_SIZE(sun50i_a64_de2_clks),
> +	.ccu_clks	= sun8i_de2_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun8i_de2_ccu_clks),
> 
>  	.hw_clks	= &sun50i_a64_de2_hw_clks,
> 
> @@ -269,8 +230,8 @@ static const struct sunxi_ccu_desc
> sun50i_a64_de2_clk_desc = { };
> 
>  static const struct sunxi_ccu_desc sun50i_h5_de2_clk_desc = {
> -	.ccu_clks	= sun8i_h3_de2_clks,
> -	.num_ccu_clks	= ARRAY_SIZE(sun8i_h3_de2_clks),
> +	.ccu_clks	= sun8i_de2_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun8i_de2_ccu_clks),
> 
>  	.hw_clks	= &sun8i_h3_de2_hw_clks,
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c index e058cf691aea..d3fcb983c17c
> 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> @@ -562,6 +562,7 @@ static struct ccu_common *sun8i_h3_ccu_clks[] = {
>  	&bus_uart2_clk.common,
>  	&bus_uart3_clk.common,
>  	&bus_scr0_clk.common,
> +	&bus_scr1_clk.common,
>  	&bus_ephy_clk.common,
>  	&bus_dbg_clk.common,
>  	&ths_clk.common,
> @@ -612,114 +613,6 @@ static struct ccu_common *sun8i_h3_ccu_clks[] = {
>  	&gpu_clk.common,
>  };
> 
> -static struct ccu_common *sun50i_h5_ccu_clks[] = {
> -	&pll_cpux_clk.common,
> -	&pll_audio_base_clk.common,
> -	&pll_video_clk.common,
> -	&pll_ve_clk.common,
> -	&pll_ddr_clk.common,
> -	&pll_periph0_clk.common,
> -	&pll_gpu_clk.common,
> -	&pll_periph1_clk.common,
> -	&pll_de_clk.common,
> -	&cpux_clk.common,
> -	&axi_clk.common,
> -	&ahb1_clk.common,
> -	&apb1_clk.common,
> -	&apb2_clk.common,
> -	&ahb2_clk.common,
> -	&bus_ce_clk.common,
> -	&bus_dma_clk.common,
> -	&bus_mmc0_clk.common,
> -	&bus_mmc1_clk.common,
> -	&bus_mmc2_clk.common,
> -	&bus_nand_clk.common,
> -	&bus_dram_clk.common,
> -	&bus_emac_clk.common,
> -	&bus_ts_clk.common,
> -	&bus_hstimer_clk.common,
> -	&bus_spi0_clk.common,
> -	&bus_spi1_clk.common,
> -	&bus_otg_clk.common,
> -	&bus_ehci0_clk.common,
> -	&bus_ehci1_clk.common,
> -	&bus_ehci2_clk.common,
> -	&bus_ehci3_clk.common,
> -	&bus_ohci0_clk.common,
> -	&bus_ohci1_clk.common,
> -	&bus_ohci2_clk.common,
> -	&bus_ohci3_clk.common,
> -	&bus_ve_clk.common,
> -	&bus_tcon0_clk.common,
> -	&bus_tcon1_clk.common,
> -	&bus_deinterlace_clk.common,
> -	&bus_csi_clk.common,
> -	&bus_tve_clk.common,
> -	&bus_hdmi_clk.common,
> -	&bus_de_clk.common,
> -	&bus_gpu_clk.common,
> -	&bus_msgbox_clk.common,
> -	&bus_spinlock_clk.common,
> -	&bus_codec_clk.common,
> -	&bus_spdif_clk.common,
> -	&bus_pio_clk.common,
> -	&bus_ths_clk.common,
> -	&bus_i2s0_clk.common,
> -	&bus_i2s1_clk.common,
> -	&bus_i2s2_clk.common,
> -	&bus_i2c0_clk.common,
> -	&bus_i2c1_clk.common,
> -	&bus_i2c2_clk.common,
> -	&bus_uart0_clk.common,
> -	&bus_uart1_clk.common,
> -	&bus_uart2_clk.common,
> -	&bus_uart3_clk.common,
> -	&bus_scr0_clk.common,
> -	&bus_scr1_clk.common,
> -	&bus_ephy_clk.common,
> -	&bus_dbg_clk.common,
> -	&ths_clk.common,
> -	&nand_clk.common,
> -	&mmc0_clk.common,
> -	&mmc1_clk.common,
> -	&mmc2_clk.common,
> -	&ts_clk.common,
> -	&ce_clk.common,
> -	&spi0_clk.common,
> -	&spi1_clk.common,
> -	&i2s0_clk.common,
> -	&i2s1_clk.common,
> -	&i2s2_clk.common,
> -	&spdif_clk.common,
> -	&usb_phy0_clk.common,
> -	&usb_phy1_clk.common,
> -	&usb_phy2_clk.common,
> -	&usb_phy3_clk.common,
> -	&usb_ohci0_clk.common,
> -	&usb_ohci1_clk.common,
> -	&usb_ohci2_clk.common,
> -	&usb_ohci3_clk.common,
> -	&dram_clk.common,
> -	&dram_ve_clk.common,
> -	&dram_csi_clk.common,
> -	&dram_deinterlace_clk.common,
> -	&dram_ts_clk.common,
> -	&de_clk.common,
> -	&tcon_clk.common,
> -	&tve_clk.common,
> -	&deinterlace_clk.common,
> -	&csi_misc_clk.common,
> -	&csi_sclk_clk.common,
> -	&csi_mclk_clk.common,
> -	&ve_clk.common,
> -	&ac_dig_clk.common,
> -	&avs_clk.common,
> -	&hdmi_clk.common,
> -	&hdmi_ddc_clk.common,
> -	&mbus_clk.common,
> -	&gpu_clk.common,
> -};
> -
>  static const struct clk_hw *clk_parent_pll_audio[] = {
>  	&pll_audio_base_clk.common.hw
>  };
> @@ -1116,8 +1009,8 @@ static const struct sunxi_ccu_desc sun8i_h3_ccu_desc =
> { };
> 
>  static const struct sunxi_ccu_desc sun50i_h5_ccu_desc = {
> -	.ccu_clks	= sun50i_h5_ccu_clks,
> -	.num_ccu_clks	= ARRAY_SIZE(sun50i_h5_ccu_clks),
> +	.ccu_clks	= sun8i_h3_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun8i_h3_ccu_clks),
> 
>  	.hw_clks	= &sun50i_h5_hw_clks,
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
> b/drivers/clk/sunxi-ng/ccu-sun8i-r.c index 5b7fab832a52..4221649b311f
> 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
> @@ -114,32 +114,7 @@ static struct ccu_mp a83t_ir_clk = {
>  	},
>  };
> 
> -static struct ccu_common *sun8i_a83t_r_ccu_clks[] = {
> -	&ar100_clk.common,
> -	&apb0_clk.common,
> -	&apb0_pio_clk.common,
> -	&apb0_ir_clk.common,
> -	&apb0_timer_clk.common,
> -	&apb0_rsb_clk.common,
> -	&apb0_uart_clk.common,
> -	&apb0_i2c_clk.common,
> -	&apb0_twd_clk.common,
> -	&a83t_ir_clk.common,
> -};
> -
> -static struct ccu_common *sun8i_h3_r_ccu_clks[] = {
> -	&ar100_clk.common,
> -	&apb0_clk.common,
> -	&apb0_pio_clk.common,
> -	&apb0_ir_clk.common,
> -	&apb0_timer_clk.common,
> -	&apb0_uart_clk.common,
> -	&apb0_i2c_clk.common,
> -	&apb0_twd_clk.common,
> -	&ir_clk.common,
> -};
> -
> -static struct ccu_common *sun50i_a64_r_ccu_clks[] = {
> +static struct ccu_common *sun8i_r_ccu_clks[] = {
>  	&ar100_clk.common,
>  	&apb0_clk.common,
>  	&apb0_pio_clk.common,
> @@ -150,6 +125,7 @@ static struct ccu_common *sun50i_a64_r_ccu_clks[] = {
>  	&apb0_i2c_clk.common,
>  	&apb0_twd_clk.common,
>  	&ir_clk.common,
> +	&a83t_ir_clk.common,
>  };
> 
>  static struct clk_hw_onecell_data sun8i_a83t_r_hw_clks = {
> @@ -226,8 +202,8 @@ static struct ccu_reset_map sun50i_a64_r_ccu_resets[] =
> { };
> 
>  static const struct sunxi_ccu_desc sun8i_a83t_r_ccu_desc = {
> -	.ccu_clks	= sun8i_a83t_r_ccu_clks,
> -	.num_ccu_clks	= ARRAY_SIZE(sun8i_a83t_r_ccu_clks),
> +	.ccu_clks	= sun8i_r_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun8i_r_ccu_clks),
> 
>  	.hw_clks	= &sun8i_a83t_r_hw_clks,
> 
> @@ -236,8 +212,8 @@ static const struct sunxi_ccu_desc sun8i_a83t_r_ccu_desc
> = { };
> 
>  static const struct sunxi_ccu_desc sun8i_h3_r_ccu_desc = {
> -	.ccu_clks	= sun8i_h3_r_ccu_clks,
> -	.num_ccu_clks	= ARRAY_SIZE(sun8i_h3_r_ccu_clks),
> +	.ccu_clks	= sun8i_r_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun8i_r_ccu_clks),
> 
>  	.hw_clks	= &sun8i_h3_r_hw_clks,
> 
> @@ -246,8 +222,8 @@ static const struct sunxi_ccu_desc sun8i_h3_r_ccu_desc =
> { };
> 
>  static const struct sunxi_ccu_desc sun50i_a64_r_ccu_desc = {
> -	.ccu_clks	= sun50i_a64_r_ccu_clks,
> -	.num_ccu_clks	= ARRAY_SIZE(sun50i_a64_r_ccu_clks),
> +	.ccu_clks	= sun8i_r_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun8i_r_ccu_clks),
> 
>  	.hw_clks	= &sun50i_a64_r_hw_clks,
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c index 87f87d6ea3ad..fbb3529f0d3e
> 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> @@ -421,6 +421,7 @@ static struct ccu_common *sun8i_v3s_ccu_clks[] = {
>  	&bus_de_clk.common,
>  	&bus_codec_clk.common,
>  	&bus_pio_clk.common,
> +	&bus_i2s0_clk.common,
>  	&bus_i2c0_clk.common,
>  	&bus_i2c1_clk.common,
>  	&bus_uart0_clk.common,
> @@ -439,6 +440,7 @@ static struct ccu_common *sun8i_v3s_ccu_clks[] = {
>  	&mmc2_output_clk.common,
>  	&ce_clk.common,
>  	&spi0_clk.common,
> +	&i2s0_clk.common,
>  	&usb_phy0_clk.common,
>  	&usb_ohci0_clk.common,
>  	&dram_clk.common,
> @@ -463,80 +465,6 @@ static const struct clk_hw *clk_parent_pll_audio[] = {
>  	&pll_audio_base_clk.common.hw
>  };
> 
> -static struct ccu_common *sun8i_v3_ccu_clks[] = {
> -	&pll_cpu_clk.common,
> -	&pll_audio_base_clk.common,
> -	&pll_video_clk.common,
> -	&pll_ve_clk.common,
> -	&pll_ddr0_clk.common,
> -	&pll_periph0_clk.common,
> -	&pll_isp_clk.common,
> -	&pll_periph1_clk.common,
> -	&pll_ddr1_clk.common,
> -	&cpu_clk.common,
> -	&axi_clk.common,
> -	&ahb1_clk.common,
> -	&apb1_clk.common,
> -	&apb2_clk.common,
> -	&ahb2_clk.common,
> -	&bus_ce_clk.common,
> -	&bus_dma_clk.common,
> -	&bus_mmc0_clk.common,
> -	&bus_mmc1_clk.common,
> -	&bus_mmc2_clk.common,
> -	&bus_dram_clk.common,
> -	&bus_emac_clk.common,
> -	&bus_hstimer_clk.common,
> -	&bus_spi0_clk.common,
> -	&bus_otg_clk.common,
> -	&bus_ehci0_clk.common,
> -	&bus_ohci0_clk.common,
> -	&bus_ve_clk.common,
> -	&bus_tcon0_clk.common,
> -	&bus_csi_clk.common,
> -	&bus_de_clk.common,
> -	&bus_codec_clk.common,
> -	&bus_pio_clk.common,
> -	&bus_i2s0_clk.common,
> -	&bus_i2c0_clk.common,
> -	&bus_i2c1_clk.common,
> -	&bus_uart0_clk.common,
> -	&bus_uart1_clk.common,
> -	&bus_uart2_clk.common,
> -	&bus_ephy_clk.common,
> -	&bus_dbg_clk.common,
> -	&mmc0_clk.common,
> -	&mmc0_sample_clk.common,
> -	&mmc0_output_clk.common,
> -	&mmc1_clk.common,
> -	&mmc1_sample_clk.common,
> -	&mmc1_output_clk.common,
> -	&mmc2_clk.common,
> -	&mmc2_sample_clk.common,
> -	&mmc2_output_clk.common,
> -	&ce_clk.common,
> -	&spi0_clk.common,
> -	&i2s0_clk.common,
> -	&usb_phy0_clk.common,
> -	&usb_ohci0_clk.common,
> -	&dram_clk.common,
> -	&dram_ve_clk.common,
> -	&dram_csi_clk.common,
> -	&dram_ohci_clk.common,
> -	&dram_ehci_clk.common,
> -	&de_clk.common,
> -	&tcon_clk.common,
> -	&csi_misc_clk.common,
> -	&csi0_mclk_clk.common,
> -	&csi1_sclk_clk.common,
> -	&csi1_mclk_clk.common,
> -	&ve_clk.common,
> -	&ac_dig_clk.common,
> -	&avs_clk.common,
> -	&mbus_clk.common,
> -	&mipi_csi_clk.common,
> -};
> -
>  /* We hardcode the divider to 1 for SDM support */
>  static CLK_FIXED_FACTOR_HWS(pll_audio_clk, "pll-audio",
>  			    clk_parent_pll_audio,
> @@ -798,8 +726,8 @@ static const struct sunxi_ccu_desc sun8i_v3s_ccu_desc =
> { };
> 
>  static const struct sunxi_ccu_desc sun8i_v3_ccu_desc = {
> -	.ccu_clks	= sun8i_v3_ccu_clks,
> -	.num_ccu_clks	= ARRAY_SIZE(sun8i_v3_ccu_clks),
> +	.ccu_clks	= sun8i_v3s_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun8i_v3s_ccu_clks),
> 
>  	.hw_clks	= &sun8i_v3_hw_clks,




