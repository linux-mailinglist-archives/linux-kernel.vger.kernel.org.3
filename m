Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C0553029C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241198AbiEVLRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiEVLRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:17:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B503D1E1;
        Sun, 22 May 2022 04:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FE65B80AFD;
        Sun, 22 May 2022 11:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84466C385AA;
        Sun, 22 May 2022 11:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653218231;
        bh=FMgjFVda0G8ynRHRjbeXhrPkJH/y/1VulbL8kZ8FO5U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JQP7/FX4pAUCuhCG47MYkdEGEsGVAtOmlHUI9e/RJrHFXYRIhQEUQ6Nthx/1dWbt0
         1qmd8pel24MZj+rtu0xUsoZPdjV2/vXvLXevdbDFP9VOlqHywzVupWW3zqxr1vW6vv
         jqr+r7kDa8MKgvgLXcl6rs3E+g3RRnosp1kFcBffXOBg9xDyMytuJhQ4xHVilKVh54
         WyIG6LCnVHqrxLtA5qENeMZ3H0/iI8pSsw2npKoeNraquCQcdKspfSbSie5zhz57F2
         l1wz2BI9yd/T2RjAs7Gtmy+GrCin2aNdI5zjYeC1nWIxyrRNLXyMiSPO+FIOXOlR2f
         mOaF7U7Gx8wBQ==
Date:   Sun, 22 May 2022 12:25:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tamseel Shams <m.shams@samsung.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, krzk+dt@kernel.org,
        geert@linux-m68k.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, alim.akhtar@samsung.com,
        paul@crapouillou.net, linux-fsd@tesla.com
Subject: Re: [PATCH v2 2/3] iio: adc: exynos-adc: Add support for ADC FSD-HW
 controller
Message-ID: <20220522122555.6c65d2b6@jic23-huawei>
In-Reply-To: <20220520145820.67667-3-m.shams@samsung.com>
References: <20220520145820.67667-1-m.shams@samsung.com>
        <CGME20220520145802epcas5p2153cb572493e3bccd702e0ecce1171fb@epcas5p2.samsung.com>
        <20220520145820.67667-3-m.shams@samsung.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 20:28:19 +0530
Tamseel Shams <m.shams@samsung.com> wrote:

> From: Alim Akhtar <alim.akhtar@samsung.com>
> 
> Exynos's ADC-FSD-HW has some difference in registers set, number of
> programmable channels (16 channel) etc. This patch adds support for
> ADC-FSD-HW controller version.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>

Hi,

One suggestion inline, otherwise LGTM. Plenty of time to tidy this up as
this won't make the upcoming merge window - I'll be queuing it up for 5.20

Thanks,

Jonathan

> ---
> - Changes since v1
> * Addressed Jonathan's comment by using already provided isr handle
> 
>  drivers/iio/adc/exynos_adc.c | 55 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index cff1ba57fb16..183ae591327a 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -55,6 +55,11 @@
>  #define ADC_V2_INT_ST(x)	((x) + 0x14)
>  #define ADC_V2_VER(x)		((x) + 0x20)
>  
> +/* ADC_FSD_HW register definitions */
> +#define ADC_FSD_DAT(x)			((x) + 0x08)

I mention this below, but these different register sets
should be in the struct exynos_adc_data to avoid the need
for an if "compatible" == check on each use of them.


> +#define ADC_FSD_DAT_SUM(x)		((x) + 0x0C)
> +#define ADC_FSD_DBG_DATA(x)		((x) + 0x1C)
> +
>  /* Bit definitions for ADC_V1 */
>  #define ADC_V1_CON_RES		(1u << 16)
>  #define ADC_V1_CON_PRSCEN	(1u << 14)
> @@ -92,6 +97,7 @@
>  
>  /* Bit definitions for ADC_V2 */
>  #define ADC_V2_CON1_SOFT_RESET	(1u << 2)
> +#define ADC_V2_CON1_SOFT_NON_RESET	(1u << 1)
>  
>  #define ADC_V2_CON2_OSEL	(1u << 10)
>  #define ADC_V2_CON2_ESEL	(1u << 9)
> @@ -100,6 +106,7 @@
>  #define ADC_V2_CON2_ACH_SEL(x)	(((x) & 0xF) << 0)
>  #define ADC_V2_CON2_ACH_MASK	0xF
>  
> +#define MAX_ADC_FSD_CHANNELS		16
>  #define MAX_ADC_V2_CHANNELS		10
>  #define MAX_ADC_V1_CHANNELS		8
>  #define MAX_EXYNOS3250_ADC_CHANNELS	2
> @@ -484,6 +491,43 @@ static const struct exynos_adc_data exynos7_adc_data = {
>  	.start_conv	= exynos_adc_v2_start_conv,
>  };
>  
> +static void exynos_adc_fsd_init_hw(struct exynos_adc *info)
> +{
> +	u32 con2;
> +
> +	writel(ADC_V2_CON1_SOFT_RESET, ADC_V2_CON1(info->regs));
> +
> +	writel(ADC_V2_CON1_SOFT_NON_RESET, ADC_V2_CON1(info->regs));
> +
> +	con2 = ADC_V2_CON2_C_TIME(6);
> +	writel(con2, ADC_V2_CON2(info->regs));
> +
> +	/* Enable interrupts */
> +	writel(1, ADC_V2_INT_EN(info->regs));
> +}
> +
> +static void exynos_adc_fsd_exit_hw(struct exynos_adc *info)
> +{
> +	u32 con2;
> +
> +	con2 = readl(ADC_V2_CON2(info->regs));
> +	con2 &= ~ADC_V2_CON2_C_TIME(7);
> +	writel(con2, ADC_V2_CON2(info->regs));
> +
> +	/* Disable interrupts */
> +	writel(0, ADC_V2_INT_EN(info->regs));
> +}
> +
> +static const struct exynos_adc_data fsd_hw_adc_data = {
> +	.num_channels	= MAX_ADC_FSD_CHANNELS,
> +	.mask		= ADC_DATX_MASK, /* 12 bit ADC resolution */
> +
> +	.init_hw	= exynos_adc_fsd_init_hw,
> +	.exit_hw	= exynos_adc_fsd_exit_hw,
> +	.clear_irq	= exynos_adc_v2_clear_irq,
> +	.start_conv	= exynos_adc_v2_start_conv,
> +};
> +
>  static const struct of_device_id exynos_adc_match[] = {
>  	{
>  		.compatible = "samsung,s3c2410-adc",
> @@ -518,6 +562,9 @@ static const struct of_device_id exynos_adc_match[] = {
>  	}, {
>  		.compatible = "samsung,exynos7-adc",
>  		.data = &exynos7_adc_data,
> +	}, {
> +		.compatible = "samsung,exynos-adc-fsd-hw",
> +		.data = &fsd_hw_adc_data,
>  	},
>  	{},
>  };
> @@ -626,6 +673,8 @@ static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
>  		info->ts_x = readl(ADC_V1_DATX(info->regs));
>  		info->ts_y = readl(ADC_V1_DATY(info->regs));
>  		writel(ADC_TSC_WAIT4INT | ADC_S3C2443_TSC_UD_SEN, ADC_V1_TSC(info->regs));
> +	} else if (of_device_is_compatible(info->dev->of_node, "samsung,exynos-adc-fsd-hw")) {

Rather than a fairly expensive look up into a device tree node, why not add
the information to the struct exynos_adc_adc in some fashion?  Maybe as an offset
for the register block?

 
> +		info->value = readl(ADC_FSD_DAT(info->regs)) & mask;
>  	} else {
>  		info->value = readl(ADC_V1_DATX(info->regs)) & mask;
>  	}
> @@ -719,6 +768,12 @@ static const struct iio_chan_spec exynos_adc_iio_channels[] = {
>  	ADC_CHANNEL(7, "adc7"),
>  	ADC_CHANNEL(8, "adc8"),
>  	ADC_CHANNEL(9, "adc9"),
> +	ADC_CHANNEL(10, "adc10"),
> +	ADC_CHANNEL(11, "adc11"),
> +	ADC_CHANNEL(12, "adc12"),
> +	ADC_CHANNEL(13, "adc13"),
> +	ADC_CHANNEL(14, "adc14"),
> +	ADC_CHANNEL(15, "adc15"),
>  };
>  
>  static int exynos_adc_remove_devices(struct device *dev, void *c)

