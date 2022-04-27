Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0F55112EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359120AbiD0Hy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244093AbiD0Hy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:54:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0CBFF5;
        Wed, 27 Apr 2022 00:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651045907; x=1682581907;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kHEYCuupGjrrRD+V/W1xr234pxONkXoJXwGYNFi1AnY=;
  b=c/ag03qwg6YUwGCbifFKxR7uflUW0yNVtBCqJLbNOi/FY/DmV2hnboO6
   TwuumgneO/uRscmKELluW0r9PSuRGCvF0wJlw39k/HTxQJdw3NQt5fYs+
   qBWvzNAZJGd0Vd2lZXXUXlLq4OYld2d+Yx8ptgB5sUM+4CMbg9RRmd+2n
   vDDWWlRx7DvOh7e504QgrSJAYYr0bcKKa/rHCeCJWm9Zm5jBtuECIX/60
   wNZOWHgEMBT7hpk0Y3xiJQ7C+ffpoGPUvRLuH7P322bZFenq/0h8MINvv
   bG7WgZL8qmT43NsKnFwMCJVR0oStskyzkrD3Oux93dRsJdYEHdnwliPnt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="291001023"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="291001023"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 00:51:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="580450929"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 00:51:41 -0700
Message-ID: <cf0b7980-e58d-e5f8-682c-c5defdffb872@intel.com>
Date:   Wed, 27 Apr 2022 10:51:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCHv1 10/19] mmc: sdhci-of-dwcmshc: add support for rk3588
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>, kernel@collabora.com
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
 <20220422170920.401914-11-sebastian.reichel@collabora.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220422170920.401914-11-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/22 20:09, Sebastian Reichel wrote:
> From: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> 
> Add support for RK3588's DWCMSHC controller, which is used for
> providing the rootfs on the RK3588 evaluation board.
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> [port from vendor BSP]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

One comment otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 113 +++++++++++++++++++++++-----
>  1 file changed, 96 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 54ae0268e002..bc365767e66c 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -31,6 +31,7 @@
>  /* Offset inside the  vendor area 1 */
>  #define DWCMSHC_HOST_CTRL3		0x8
>  #define DWCMSHC_EMMC_CONTROL		0x2c
> +#define DWCMSHC_CARD_IS_EMMC		BIT(0)
>  #define DWCMSHC_ENHANCED_STROBE		BIT(8)
>  #define DWCMSHC_EMMC_ATCTRL		0x40
>  
> @@ -39,7 +40,7 @@
>  #define DWCMSHC_EMMC_DLL_RXCLK		0x804
>  #define DWCMSHC_EMMC_DLL_TXCLK		0x808
>  #define DWCMSHC_EMMC_DLL_STRBIN		0x80c
> -#define DLL_STRBIN_TAPNUM_FROM_SW	BIT(24)
> +#define DECMSHC_EMMC_DLL_CMDOUT		0x810
>  #define DWCMSHC_EMMC_DLL_STATUS0	0x840
>  #define DWCMSHC_EMMC_DLL_START		BIT(0)
>  #define DWCMSHC_EMMC_DLL_LOCKED		BIT(8)
> @@ -48,11 +49,21 @@
>  #define DWCMSHC_EMMC_DLL_START_POINT	16
>  #define DWCMSHC_EMMC_DLL_INC		8
>  #define DWCMSHC_EMMC_DLL_DLYENA		BIT(27)
> -#define DLL_TXCLK_TAPNUM_DEFAULT	0x8
> -#define DLL_STRBIN_TAPNUM_DEFAULT	0x8
> +#define DLL_TXCLK_TAPNUM_DEFAULT	0x10
> +#define DLL_TXCLK_TAPNUM_90_DEGREES	0xA
>  #define DLL_TXCLK_TAPNUM_FROM_SW	BIT(24)
> +#define DLL_STRBIN_TAPNUM_DEFAULT	0x8
> +#define DLL_STRBIN_TAPNUM_FROM_SW	BIT(24)
> +#define DLL_STRBIN_DELAY_NUM_SEL	BIT(26)
> +#define DLL_STRBIN_DELAY_NUM_OFFSET	16
> +#define DLL_STRBIN_DELAY_NUM_DEFAULT	0x16
>  #define DLL_RXCLK_NO_INVERTER		1
>  #define DLL_RXCLK_INVERTER		0
> +#define DLL_CMDOUT_TAPNUM_90_DEGREES	0x8
> +#define DLL_CMDOUT_TAPNUM_FROM_SW	BIT(24)
> +#define DLL_CMDOUT_SRC_CLK_NEG		BIT(28)
> +#define DLL_CMDOUT_EN_SRC_CLK_NEG	BIT(29)
> +
>  #define DLL_LOCK_WO_TMOUT(x) \
>  	((((x) & DWCMSHC_EMMC_DLL_LOCKED) == DWCMSHC_EMMC_DLL_LOCKED) && \
>  	(((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
> @@ -61,10 +72,16 @@
>  #define BOUNDARY_OK(addr, len) \
>  	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
>  
> +enum dwcmshc_rk_type {
> +	DWCMSHC_RK3568,
> +	DWCMSHC_RK3588,
> +};
> +
>  struct rk35xx_priv {
>  	/* Rockchip specified optional clocks */
>  	struct clk_bulk_data rockchip_clks[RK35xx_MAX_CLKS];
>  	struct reset_control *reset;
> +	enum dwcmshc_rk_type devtype;
>  	u8 txclk_tapnum;
>  };
>  
> @@ -133,7 +150,9 @@ static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
>  				      unsigned int timing)
>  {
> -	u16 ctrl_2;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u16 ctrl, ctrl_2;
>  
>  	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>  	/* Select Bus Speed Mode for host */
> @@ -151,8 +170,15 @@ static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
>  	else if ((timing == MMC_TIMING_UHS_DDR50) ||
>  		 (timing == MMC_TIMING_MMC_DDR52))
>  		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
> -	else if (timing == MMC_TIMING_MMC_HS400)
> +	else if (timing == MMC_TIMING_MMC_HS400) {
> +		/* set CARD_IS_EMMC bit to enable Data Strobe for HS400 */
> +		ctrl = sdhci_readw(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +		ctrl |= DWCMSHC_CARD_IS_EMMC;
> +		sdhci_writew(host, ctrl, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +
>  		ctrl_2 |= DWCMSHC_CTRL_HS400;
> +	}
> +
>  	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>  }
>  
> @@ -185,17 +211,11 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  
>  	host->mmc->actual_clock = 0;
>  
> -	/*
> -	 * DO NOT TOUCH THIS SETTING. RX clk inverter unit is enabled
> -	 * by default, but it shouldn't be enabled. We should anyway
> -	 * disable it before issuing any cmds.
> -	 */
> -	extra = DWCMSHC_EMMC_DLL_DLYENA |
> -		DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL;
> -	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
> -
> -	if (clock == 0)
> +	if (clock == 0) {
> +		/* Disable interface clock at initial state. */
> +		sdhci_set_clock(host, clock);
>  		return;
> +	}
>  
>  	/* Rockchip platform only support 375KHz for identify mode */
>  	if (clock <= 400000)
> @@ -213,9 +233,21 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  	extra &= ~BIT(0);
>  	sdhci_writel(host, extra, reg);
>  
> -	if (clock <= 400000) {
> -		/* Disable DLL to reset sample clock */
> +	if (clock <= 52000000) {
> +		/* Disable DLL and reset both of sample and drive clock */
>  		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
> +		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_RXCLK);
> +		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
> +		sdhci_writel(host, 0, DECMSHC_EMMC_DLL_CMDOUT);
> +		/*
> +		 * Before switching to hs400es mode, the driver will enable
> +		 * enhanced strobe first. PHY needs to configure the parameters
> +		 * of enhanced strobe first.
> +		 */
> +		extra = DWCMSHC_EMMC_DLL_DLYENA |
> +			DLL_STRBIN_DELAY_NUM_SEL |
> +			DLL_STRBIN_DELAY_NUM_DEFAULT << DLL_STRBIN_DELAY_NUM_OFFSET;
> +		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
>  		return;
>  	}
>  
> @@ -224,6 +256,15 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  	udelay(1);
>  	sdhci_writel(host, 0x0, DWCMSHC_EMMC_DLL_CTRL);
>  
> +	/*
> +	 * We shouldn't set DLL_RXCLK_NO_INVERTER for identify mode but
> +	 * we must set it in higher speed mode.
> +	 */
> +	extra = DWCMSHC_EMMC_DLL_DLYENA;
> +	if (priv->devtype == DWCMSHC_RK3568)
> +		extra |= DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL;
> +	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
> +
>  	/* Init DLL settings */
>  	extra = 0x5 << DWCMSHC_EMMC_DLL_START_POINT |
>  		0x2 << DWCMSHC_EMMC_DLL_INC |
> @@ -246,8 +287,20 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  	    host->mmc->ios.timing == MMC_TIMING_MMC_HS400)
>  		txclk_tapnum = priv->txclk_tapnum;
>  
> +	if ((priv->devtype == DWCMSHC_RK3588) && host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
> +		txclk_tapnum = DLL_TXCLK_TAPNUM_90_DEGREES;
> +
> +		extra = DLL_CMDOUT_SRC_CLK_NEG |
> +			DLL_CMDOUT_EN_SRC_CLK_NEG |
> +			DWCMSHC_EMMC_DLL_DLYENA |
> +			DLL_CMDOUT_TAPNUM_90_DEGREES |
> +			DLL_CMDOUT_TAPNUM_FROM_SW;
> +		sdhci_writel(host, extra, DECMSHC_EMMC_DLL_CMDOUT);
> +	}
> +
>  	extra = DWCMSHC_EMMC_DLL_DLYENA |
>  		DLL_TXCLK_TAPNUM_FROM_SW |
> +		DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL |
>  		txclk_tapnum;
>  	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_TXCLK);
>  
> @@ -347,7 +400,25 @@ static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
>  	return 0;
>  }
>  
> +static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> +{
> +	/*
> +	 * Don't support highspeed bus mode with low clk speed as we
> +	 * cannot use DLL for this condition.
> +	 */
> +	if (host->mmc->f_max <= 52000000) {
> +		dev_info(mmc_dev(host->mmc), "Disabling HS200/HS400, frequency too low (%d)\n",
> +			 host->mmc->f_max);
> +		host->mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
> +		host->mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR);

Ideally, this should be done before mmc_add_host(), for example by using
sdhci_setup_host() + __sdhci_add_host() instead of sdhci_add_host(), and
putting dwcmshc_rk35xx_postinit() between sdhci_setup_host() and
__sdhci_add_host().

> +	}
> +}
> +
>  static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
> +	{
> +		.compatible = "rockchip,rk3588-dwcmshc",
> +		.data = &sdhci_dwcmshc_rk35xx_pdata,
> +	},
>  	{
>  		.compatible = "rockchip,rk3568-dwcmshc",
>  		.data = &sdhci_dwcmshc_rk35xx_pdata,
> @@ -435,6 +506,11 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  			goto err_clk;
>  		}
>  
> +		if (of_device_is_compatible(pdev->dev.of_node, "rockchip,rk3588-dwcmshc"))
> +			rk_priv->devtype = DWCMSHC_RK3588;
> +		else
> +			rk_priv->devtype = DWCMSHC_RK3568;
> +
>  		priv->priv = rk_priv;
>  
>  		err = dwcmshc_rk35xx_init(host, priv);
> @@ -448,6 +524,9 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	if (err)
>  		goto err_clk;
>  
> +	if (rk_priv)
> +		dwcmshc_rk35xx_postinit(host, priv);
> +
>  	return 0;
>  
>  err_clk:

