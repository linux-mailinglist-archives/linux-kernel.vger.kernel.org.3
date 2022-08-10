Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD2558E932
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiHJI7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiHJI70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:59:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F4486887
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:59:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so647325wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc;
        bh=i1qljQ5ZHwaRxT6plDgGryxnhTQKflslCJUPBdVZVjU=;
        b=MlPsHL7h+ulRKM6eAvg8dZTehU3UMkpCA+zvRt8OrSSr+n8xHuPSxJXLHxYen61eJS
         mFmPtUw+YojO3qzXGo247J0dEzaX4ynuYer4Ow1B4ClkXF9EBnjNvPTKBARMqb1UOEg6
         ZU4OkKa9+y78Fo9MyRLUVdjSPssH3QwBMdT0OoAFW7Ciase6v6f8ftIhoWkcki7DceRt
         7evIzhEvXOOLqD8H7f2KKKIoRU6LW9FL/YHgftCIZdSGTduajuFTVoeRlJi49rWR4sxc
         lae5JKVP/ozb3NpQkafuZ/dU9ll6vypY+Ya3gIohZfzFG/yTjeJL3rcqXd3mIlJ9w7Ar
         CMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc;
        bh=i1qljQ5ZHwaRxT6plDgGryxnhTQKflslCJUPBdVZVjU=;
        b=2Hh72twc1DVb56Ksk2MHUQ/zvGFk5O3cRNJmzQy7UDK4euY9xbE5wSN4pqmpNP4wVr
         wSIbvzZUaVEOcqTu2YcR0/P6QS86ghKw/hsv9nukbB3cXxpx1SqJDHPLIFLCB5OEl7Mg
         6wwaR/Z5EldWrDfnGVdbanUHZ59WUMcoASH2ib2+I1dZf5WtxBGDpGWZr13uOi5vdg+l
         dIO8ssBdE5ivGDhO+9OBQLYhYYwhgGxBFEU+TR/h7W/WIelDsJiCvAOEcJeLqiCfXArX
         kJNgQfzosbPCl4L1TY0B8bTYXuKBDYy1x6XU5c0RbtRkV3riPBhQVO+Uv9dxNFADRyn3
         Xa/w==
X-Gm-Message-State: ACgBeo2vMOTAJMwUNTBabwG/bhcQxohIxZ4g3E1j24NxF6iszJsmIkhH
        MxF4NCLOaCr6yJrReEbWDi3uCQ==
X-Google-Smtp-Source: AA6agR6D8n7WACH0wC2rppBy+qXxyRn3cKOv9fesW1W54WbcQTKe/8inD+7UNpGSMAIBdE7G37U9Yg==
X-Received: by 2002:a05:600c:4f44:b0:3a5:6de3:8375 with SMTP id m4-20020a05600c4f4400b003a56de38375mr1670825wmq.198.1660121962814;
        Wed, 10 Aug 2022 01:59:22 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f5-20020a5d58e5000000b0021eed2414c9sm15370686wrd.40.2022.08.10.01.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 01:59:22 -0700 (PDT)
References: <20220809172017.215412-1-aouledameur@baylibre.com>
 <20220809172017.215412-3-aouledameur@baylibre.com>
User-agent: mu4e 1.8.7; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        narmstrong@baylibre.com, Da Xue <da@libre.computer>
Subject: Re: [PATCH 2/2] spi: meson-spicc: Use pinctrl to drive CLK line
 when idle
Date:   Wed, 10 Aug 2022 10:52:16 +0200
In-reply-to: <20220809172017.215412-3-aouledameur@baylibre.com>
Message-ID: <1jsfm4xymu.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 09 Aug 2022 at 19:20, Amjad Ouled-Ameur <aouledameur@baylibre.com> wrote:

> Between SPI transactions, all SPI pins are in HiZ state. When using the SS
> signal from the SPICC controller it's not an issue because when the
> transaction resumes all pins come back to the right state at the same time
> as SS.
>
> The problem is when we use CS as a GPIO. In fact, between the GPIO CS
> state change and SPI pins state change from idle, you can have a missing or
> spurious clock transition.
>
> Set a bias on the clock depending on the clock polarity requested before CS
> goes active, by passing a special "idle-low" and "idle-high" pinctrl state
> and setting the right state at a start of a message
>
> Reported-by: Da Xue <da@libre.computer>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 14 ++++++++
>  drivers/spi/spi-meson-spicc.c              | 39 +++++++++++++++++++++-

These 2 changes should not be in the same patch.

>  2 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> index c3ac531c4f84..04e9d0f1bde0 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi

Does the problem applies only the gxl ? not gxbb, g12, axg ?

> @@ -429,6 +429,20 @@ mux {
>  			};
>  		};
>  
> +		spi_idle_high_pins: spi-idle-high-pins {
> +			mux {
> +				groups = "spi_sclk";
> +				bias-pull-up;
> +			};
> +		};
> +
> +		spi_idle_low_pins: spi-idle-low-pins {
> +			mux {
> +				groups = "spi_sclk";
> +				bias-pull-down;

Would it be safer to properly drive the pin in push-pull mode ?
Like using gpio pinumux mode and output-high/output-low pinconf ?

> +			};
> +		};
> +
>  		spi_ss0_pins: spi-ss0 {
>  			mux {
>  				groups = "spi_ss0";
> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
> index 0bc7daa7afc8..d42171ee1d61 100644
> --- a/drivers/spi/spi-meson-spicc.c
> +++ b/drivers/spi/spi-meson-spicc.c
> @@ -21,6 +21,7 @@
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
>  #include <linux/reset.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  /*
>   * The Meson SPICC controller could support DMA based transfers, but is not
> @@ -166,14 +167,31 @@ struct meson_spicc_device {
>  	unsigned long			tx_remain;
>  	unsigned long			rx_remain;
>  	unsigned long			xfer_remain;
> +	struct pinctrl			*pinctrl;
> +	struct pinctrl_state		*pins_idle_high;
> +	struct pinctrl_state		*pins_idle_low;
>  };
>  
>  static void meson_spicc_oen_enable(struct meson_spicc_device *spicc)
>  {
>  	u32 conf;
>  
> -	if (!spicc->data->has_oen)
> +	if (!spicc->data->has_oen) {
> +		/* Try to get pinctrl states for idle high/low */
> +		spicc->pins_idle_high = pinctrl_lookup_state(spicc->pinctrl,
> +							     "idle-high");
> +		if (IS_ERR(spicc->pins_idle_high)) {
> +			dev_warn(&spicc->pdev->dev, "can't get idle-high pinctrl\n");
> +			spicc->pins_idle_high = NULL;
> +		}
> +		spicc->pins_idle_low = pinctrl_lookup_state(spicc->pinctrl,
> +							     "idle-low");
> +		if (IS_ERR(spicc->pins_idle_low)) {
> +			dev_warn(&spicc->pdev->dev, "can't get idle-low pinctrl\n");
> +			spicc->pins_idle_low = NULL;
> +		}
>  		return;
> +	}
>  
>  	conf = readl_relaxed(spicc->base + SPICC_ENH_CTL0) |
>  		SPICC_ENH_MOSI_OEN | SPICC_ENH_CLK_OEN | SPICC_ENH_CS_OEN;
> @@ -438,6 +456,16 @@ static int meson_spicc_prepare_message(struct spi_master *master,
>  	else
>  		conf &= ~SPICC_POL;
>  
> +	if (!spicc->data->has_oen) {
> +		if (spi->mode & SPI_CPOL) {
> +			if (spicc->pins_idle_high)
> +				pinctrl_select_state(spicc->pinctrl, spicc->pins_idle_high);
> +		} else {
> +			if (spicc->pins_idle_low)
> +				pinctrl_select_state(spicc->pinctrl, spicc->pins_idle_low);
> +		}
> +	}
> +
>  	if (spi->mode & SPI_CPHA)
>  		conf |= SPICC_PHA;
>  	else
> @@ -482,6 +510,9 @@ static int meson_spicc_unprepare_transfer(struct spi_master *master)
>  
>  	device_reset_optional(&spicc->pdev->dev);
>  
> +	if (!spicc->data->has_oen)
> +		pinctrl_select_default_state(&spicc->pdev->dev);
> +
>  	return 0;
>  }
>  
> @@ -733,6 +764,12 @@ static int meson_spicc_probe(struct platform_device *pdev)
>  		goto out_core_clk;
>  	}
>  
> +	spicc->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (IS_ERR(spicc->pinctrl)) {
> +		ret = PTR_ERR(spicc->pinctrl);
> +		goto out_clk;
> +	}
> +
>  	device_reset_optional(&pdev->dev);
>  
>  	master->num_chipselect = 4;

