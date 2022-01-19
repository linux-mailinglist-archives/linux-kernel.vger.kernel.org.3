Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AAE493673
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352569AbiASIkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiASIkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:40:05 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E67C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:40:05 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso977874wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ko+bB25CPWuF/Cdu+tkXOHeEGmLNqBJEq8dY/pEJw2Y=;
        b=VTDBsAJPqvy8JMaOAjB9eBH06Zz4rdHjy32T53T5frR1vZahU7OrRRceaL+fpO10p4
         cRYgbpX2Cq8t89Kz1xHjoZyJSKsyciUHAmIsKarsKVbcWo2Iw751dURhN0Xum6I7zkzW
         JG/kOABJqRLKobE8HNM73hv3LkHGquxtaJV+FpL24/gWCqY361CxEnfU/uWqpA+kL2lo
         7uDw1of2ipQz2mVTfBAJj2UMCMv4NemIqhBrDtePn0/RBSbx19aCYxyirYNRvNwXaB90
         CyKuvzlL0lXbzc4ZqXnOfxnomswsDlRIQRyiKVQbqu0JwaZUA/T2dsGkHME0KY0aL5l0
         N2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ko+bB25CPWuF/Cdu+tkXOHeEGmLNqBJEq8dY/pEJw2Y=;
        b=RgZlRIQi5i9IuCHfJT5osReAawbvW5U9fmVnij5zy0w5NnXMuKE6d4hYEj4wlTjNMc
         HtJYIjim7nVHLNgonN1YFl2Ke63KgvlBgPUVli4vcciqHR9ZaC9akBydp8w0DdM4xd2q
         qhFelfq0jPU/0yh7VVsgUhKmkSDMikSR5JJUrnZ73dGTfs4nLSDe5qruMQav9yuuOTBP
         igP4tAqQxNCtYCq3tULFeHREUanPA3hncHiAi1S3sp0lCXsqio5PJNPs5v8IWOxSbQCE
         p226BL0bpF80bmXbqTM5LndYRzc3l9dxLjWNTuH3ADS8pPAEcN9GlAb5JJsRdHGast3b
         oGDg==
X-Gm-Message-State: AOAM533BFh5ARIpbKLZrWoPh5Z7mMjDknHIKXWj2q+kBvdCbxXuGh96A
        WLBGPnUXIayz3+WKknRPbHm6PQ==
X-Google-Smtp-Source: ABdhPJwtSWjyQo0XaG+dpWnZP2dr8x9mQ6InIpglijeqZONVIhKBnA1LHxIiDnWk4/USbXH5XgZb8w==
X-Received: by 2002:a1c:f302:: with SMTP id q2mr2333072wmq.107.1642581603645;
        Wed, 19 Jan 2022 00:40:03 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:d394:97d0:bc02:3846? ([2001:861:44c0:66c0:d394:97d0:bc02:3846])
        by smtp.gmail.com with ESMTPSA id x8sm18074431wru.102.2022.01.19.00.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 00:40:02 -0800 (PST)
Subject: Re: [PATCH v2] phy: dphy: Correct clk_pre parameter
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     linux-imx@nxp.com, Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
References: <20220119023714.1498508-1-victor.liu@nxp.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <28e3f723-daf0-b3c5-ee10-519c4cabfe17@baylibre.com>
Date:   Wed, 19 Jan 2022 09:40:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220119023714.1498508-1-victor.liu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/01/2022 03:37, Liu Ying wrote:
> The D-PHY specification (v1.2) explicitly mentions that the T-CLK-PRE
> parameter's unit is Unit Interval(UI) and the minimum value is 8.  Also,
> kernel doc of the 'clk_pre' member of struct phy_configure_opts_mipi_dphy
> mentions that it should be in UI.  However, the dphy core driver wrongly
> sets 'clk_pre' to 8000, which seems to hint that it's in picoseconds.
> And, the kernel doc of the 'clk_pre' member wrongly says the minimum value
> is '8 UI', instead of 8.
> 
> So, let's fix both the dphy core driver and the kernel doc of the 'clk_pre'
> member to correctly reflect the T-CLK-PRE parameter's unit and the minimum
> value according to the D-PHY specification.
> 
> I'm assuming that all impacted custom drivers shall program values in
> TxByteClkHS cycles into hardware for the T-CLK-PRE parameter.  The D-PHY
> specification mentions that the frequency of TxByteClkHS is exactly 1/8
> the High-Speed(HS) bit rate(each HS bit consumes one UI).  So, relevant
> custom driver code is changed to program those values as
> DIV_ROUND_UP(cfg->clk_pre, BITS_PER_BYTE), then.
> 
> Note that I've only tested the patch with RM67191 DSI panel on i.MX8mq EVK.
> Help is needed to test with other i.MX8mq, Meson and Rockchip platforms,
> as I don't have the hardwares.
> 
> Fixes: 2ed869990e14 ("phy: Add MIPI D-PHY configuration options")
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Guido Günther <agx@sigxcpu.org>
> Tested-by: Liu Ying <victor.liu@nxp.com> # RM67191 DSI panel on i.MX8mq EVK
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v1->v2:
> * Use BITS_PER_BYTE macro. (Andrzej)
> * Drop dsi argument from ui2bc() in nwl-dsi.c.
> 
>  drivers/gpu/drm/bridge/nwl-dsi.c                 | 12 +++++-------
>  drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c    |  3 ++-
>  drivers/phy/phy-core-mipi-dphy.c                 |  4 ++--
>  drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c |  3 ++-
>  include/linux/phy/phy-mipi-dphy.h                |  2 +-
>  5 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index a7389a0facfb..af07eeb47ca0 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/irq.h>
>  #include <linux/math64.h>
> @@ -196,12 +197,9 @@ static u32 ps2bc(struct nwl_dsi *dsi, unsigned long long ps)
>  /*
>   * ui2bc - UI time periods to byte clock cycles
>   */
> -static u32 ui2bc(struct nwl_dsi *dsi, unsigned long long ui)
> +static u32 ui2bc(unsigned int ui)
>  {
> -	u32 bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
> -
> -	return DIV64_U64_ROUND_UP(ui * dsi->lanes,
> -				  dsi->mode.clock * 1000 * bpp);
> +	return DIV_ROUND_UP(ui, BITS_PER_BYTE);
>  }
>  
>  /*
> @@ -232,12 +230,12 @@ static int nwl_dsi_config_host(struct nwl_dsi *dsi)
>  	}
>  
>  	/* values in byte clock cycles */
> -	cycles = ui2bc(dsi, cfg->clk_pre);
> +	cycles = ui2bc(cfg->clk_pre);
>  	DRM_DEV_DEBUG_DRIVER(dsi->dev, "cfg_t_pre: 0x%x\n", cycles);
>  	nwl_dsi_write(dsi, NWL_DSI_CFG_T_PRE, cycles);
>  	cycles = ps2bc(dsi, cfg->lpx + cfg->clk_prepare + cfg->clk_zero);
>  	DRM_DEV_DEBUG_DRIVER(dsi->dev, "cfg_tx_gap (pre): 0x%x\n", cycles);
> -	cycles += ui2bc(dsi, cfg->clk_pre);
> +	cycles += ui2bc(cfg->clk_pre);
>  	DRM_DEV_DEBUG_DRIVER(dsi->dev, "cfg_t_post: 0x%x\n", cycles);
>  	nwl_dsi_write(dsi, NWL_DSI_CFG_T_POST, cycles);
>  	cycles = ps2bc(dsi, cfg->hs_exit);
> diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c b/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
> index cd2332bf0e31..fdbd64c03e12 100644
> --- a/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
> +++ b/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> @@ -250,7 +251,7 @@ static int phy_meson_axg_mipi_dphy_power_on(struct phy *phy)
>  		     (DIV_ROUND_UP(priv->config.clk_zero, temp) << 16) |
>  		     (DIV_ROUND_UP(priv->config.clk_prepare, temp) << 24));
>  	regmap_write(priv->regmap, MIPI_DSI_CLK_TIM1,
> -		     DIV_ROUND_UP(priv->config.clk_pre, temp));
> +		     DIV_ROUND_UP(priv->config.clk_pre, BITS_PER_BYTE));
>  
>  	regmap_write(priv->regmap, MIPI_DSI_HS_TIM,
>  		     DIV_ROUND_UP(priv->config.hs_exit, temp) |

I'll try to run a test, currently the calculation gives 2, so this would give 1.

Neil

> diff --git a/drivers/phy/phy-core-mipi-dphy.c b/drivers/phy/phy-core-mipi-dphy.c
> index 288c9c67aa74..ccb4045685cd 100644
> --- a/drivers/phy/phy-core-mipi-dphy.c
> +++ b/drivers/phy/phy-core-mipi-dphy.c
> @@ -36,7 +36,7 @@ int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
>  
>  	cfg->clk_miss = 0;
>  	cfg->clk_post = 60000 + 52 * ui;
> -	cfg->clk_pre = 8000;
> +	cfg->clk_pre = 8;
>  	cfg->clk_prepare = 38000;
>  	cfg->clk_settle = 95000;
>  	cfg->clk_term_en = 0;
> @@ -97,7 +97,7 @@ int phy_mipi_dphy_config_validate(struct phy_configure_opts_mipi_dphy *cfg)
>  	if (cfg->clk_post < (60000 + 52 * ui))
>  		return -EINVAL;
>  
> -	if (cfg->clk_pre < 8000)
> +	if (cfg->clk_pre < 8)
>  		return -EINVAL;
>  
>  	if (cfg->clk_prepare < 38000 || cfg->clk_prepare > 95000)
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
> index 347dc79a18c1..630e01b5c19b 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
> @@ -5,6 +5,7 @@
>   * Author: Wyon Bi <bivvy.bi@rock-chips.com>
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/kernel.h>
>  #include <linux/clk.h>
>  #include <linux/iopoll.h>
> @@ -364,7 +365,7 @@ static void inno_dsidphy_mipi_mode_enable(struct inno_dsidphy *inno)
>  	 * The value of counter for HS Tclk-pre
>  	 * Tclk-pre = Tpin_txbyteclkhs * value
>  	 */
> -	clk_pre = DIV_ROUND_UP(cfg->clk_pre, t_txbyteclkhs);
> +	clk_pre = DIV_ROUND_UP(cfg->clk_pre, BITS_PER_BYTE);
>  
>  	/*
>  	 * The value of counter for HS Tlpx Time
> diff --git a/include/linux/phy/phy-mipi-dphy.h b/include/linux/phy/phy-mipi-dphy.h
> index a877ffee845d..59a5e77ab409 100644
> --- a/include/linux/phy/phy-mipi-dphy.h
> +++ b/include/linux/phy/phy-mipi-dphy.h
> @@ -42,7 +42,7 @@ struct phy_configure_opts_mipi_dphy {
>  	 * the transmitter prior to any associated Data Lane beginning
>  	 * the transition from LP to HS mode.
>  	 *
> -	 * Minimum value: 8 UI
> +	 * Minimum value: 8
>  	 */
>  	unsigned int		clk_pre;
>  
> 

