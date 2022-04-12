Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024DF4FDF79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353482AbiDLMJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354015AbiDLMET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:04:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B3E3F8BB;
        Tue, 12 Apr 2022 04:06:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id o2so9905625lfu.13;
        Tue, 12 Apr 2022 04:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P00jqtd+ILMRR9Q3mnllZuR6cE+BJcMxpj1JrqSYISk=;
        b=lVB+k306E9WmYZwtVGX776xFikOkDj8MIVvynihNeUlVqtHPKszbHgxVOvZFoyZ18+
         D7u4Sqd2codKn+ce6UTVew9fHiR5/0EGvTgwE6US1yPS7PwvoSScfnDjAwcP5vOuc4aZ
         YlGFHU4o2rYb9vg0B9MzkIX/K8t1JXkkFnlRm6EqJ5NgWGt7fyo1tIADEzIoANiIhEc9
         WSbmC57CohCUfwQxQZAOX0y1PONDJ5VSgMlUSDSqBN7FcNKjdpM8a4l2vjE/IUc3ajQx
         KUwsC6OLFImvyC69ajRlE0bQyUm+mt/a395P4TqyVaMityHzlfoUMWZlhkRZwwXTwQne
         YbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P00jqtd+ILMRR9Q3mnllZuR6cE+BJcMxpj1JrqSYISk=;
        b=HxxO3+8QjPPjBSm+2WwJa+/0XBbHQrKHj3XngLnBQEDqdJo4MVNIII0u6uRFVZgg7p
         rUO7eggloi7r1O0KNf+po9QITipbhZRu4hFALGnXI2g6pJA2rK9MZzGuBe1acTYcolbz
         cIj+fAKHDxX3Kvy2Qe0nd+0f+e5u0+cnkQwxDBoTa4fjRSSv38uMBvPnsr8MCFQAub3s
         M3LmPG5F72GyHFak/EsTrk1+f3uhoKKR2X8Yc7iBud2kSjm1zu0drTXz7HQYUp+44ze5
         GIsjoFeypOfgoThUWLFZ8jQwhbGGYQQ/EUZijR7lDg+v2duFpFf0whP0/yPSxMw2HrLV
         GFRw==
X-Gm-Message-State: AOAM530+/24N/pH4Pu8Ag5tjXy8Gtv6J1rvXgMf6ArdWP9o8Y0Yg/j8/
        nJIVvRMxZtR5X84V7Z4Mu2I=
X-Google-Smtp-Source: ABdhPJy9aINakzkHjO+kqosgdA0fO5BWmaepRXpf61n5eIKv/mmt/i8Zy/XATZczcwChIiHU/T6/cw==
X-Received: by 2002:a05:6512:1398:b0:445:bcef:e4fd with SMTP id p24-20020a056512139800b00445bcefe4fdmr24879325lfa.398.1649761585192;
        Tue, 12 Apr 2022 04:06:25 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id z16-20020a195e50000000b0044a77156ef5sm3623829lfi.242.2022.04.12.04.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 04:06:24 -0700 (PDT)
Date:   Tue, 12 Apr 2022 14:06:22 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, olof@lixom.net, dac2@pensando.io,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] spi: dw: Add support for Pensando Elba SoC
Message-ID: <20220412110622.2xsk3k63dafqxib5@mobilestation>
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-11-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406233648.21644-11-brad@pensando.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 04:36:47PM -0700, Brad Larson wrote:
> The Pensando Elba SoC includes a DW apb_ssi v4 controller
> with device specific chip-select control.  The Elba SoC
> provides four chip-selects where the native DW IP supports
> two chip-selects.  The Elba DW_SPI instance has two native
> CS signals that are always overridden.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
> Change from V3:
> - Use more descriptive dt property pensando,syscon-spics
> - Minor changes from review input
> 
>  drivers/spi/spi-dw-mmio.c | 85 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 5101c4c6017b..f4636b271818 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -53,6 +53,24 @@ struct dw_spi_mscc {
>  	void __iomem        *spi_mst; /* Not sparx5 */
>  };
>  
> +struct dw_spi_elba {
> +	struct regmap *regmap;
> +	unsigned int reg;
> +};
> +
> +/*
> + * Elba SoC does not use ssi, pin override is used for cs 0,1 and
> + * gpios for cs 2,3 as defined in the device tree.
> + *
> + * cs:  |       1               0
> + * bit: |---3-------2-------1-------0
> + *      |  cs1   cs1_ovr   cs0   cs0_ovr
> + */
> +#define ELBA_SPICS_SHIFT(cs)		(2 * (cs))
> +#define ELBA_SPICS_MASK(cs)		(0x3 << ELBA_SPICS_SHIFT(cs))
> +#define ELBA_SPICS_SET(cs, val)	\
> +			((((val) << 1) | 0x1) << ELBA_SPICS_SHIFT(cs))
> +
>  /*
>   * The Designware SPI controller (referred to as master in the documentation)
>   * automatically deasserts chip select when the tx fifo is empty. The chip
> @@ -238,6 +256,72 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
>  	return 0;
>  }
>  

> +static void elba_spics_set_cs(struct dw_spi_elba *dwselba, int cs, int enable)
> +{
> +	regmap_update_bits(dwselba->regmap, dwselba->reg, ELBA_SPICS_MASK(cs),
> +			   ELBA_SPICS_SET(cs, enable));
> +}
> +
> +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)

The methods naming is ambiguous. Moreover it breaks this module naming
convention. Could you change them to something like:
dw_spi_elba_override_cs()
and
dw_spi_elba_set_cs()
?

> +{
> +	struct dw_spi *dws = spi_master_get_devdata(spi->master);
> +	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
> +	struct dw_spi_elba *dwselba = dwsmmio->priv;
> +	u8 cs;
> +
> +	cs = spi->chip_select;
> +	if (cs < 2) {
> +		/* overridden native chip-select */
> +		elba_spics_set_cs(dwselba, spi->chip_select, enable);
> +	}
> +
> +	/*
> +	 * The DW SPI controller needs a native CS bit selected to start
> +	 * the serial engine and the platform may have fewer native CSs
> +	 * than needed, so use CS0 always.
> +	 */
> +	spi->chip_select = 0;
> +	dw_spi_set_cs(spi, enable);
> +	spi->chip_select = cs;
> +}
> +
> +static int dw_spi_elba_init(struct platform_device *pdev,
> +			    struct dw_spi_mmio *dwsmmio)
> +{
> +	struct of_phandle_args args;
> +	struct dw_spi_elba *dwselba;
> +	struct regmap *regmap;
> +	int rc;
> +
> +	rc = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
> +			"pensando,syscon-spics", 1, 0, &args);
> +	if (rc) {
> +		dev_err(&pdev->dev, "could not find spics\n");
> +		return rc;
> +	}
> +
> +	regmap = syscon_node_to_regmap(args.np);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(regmap),
> +				     "could not map spics");
> +
> +	dwselba = devm_kzalloc(&pdev->dev, sizeof(*dwselba), GFP_KERNEL);
> +	if (!dwselba)
> +		return -ENOMEM;
> +
> +	dwselba->regmap = regmap;
> +	dwselba->reg = args.args[0];
> +
> +	/* deassert cs */

> +	elba_spics_set_cs(dwselba, 0, 1);
> +	elba_spics_set_cs(dwselba, 1, 1);

What if the CS lines are of the active-high type? In that case basically
you get to do the opposite to what you claim in the comment here.

Note the CS setting into the deactivated state is done in the spi_setup()
method anyway, at the moment of the peripheral SPI device registration
stage (see its calling the spi_set_cs() function). Thus what you are doing
here is redundant.

-Sergey

> +
> +	dwsmmio->priv = dwselba;
> +	dwsmmio->dws.set_cs = dw_spi_elba_set_cs;
> +
> +	return 0;
> +}
> +
>  static int dw_spi_mmio_probe(struct platform_device *pdev)
>  {
>  	int (*init_func)(struct platform_device *pdev,
> @@ -352,6 +436,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
>  	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
>  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
>  	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
> +	{ .compatible = "pensando,elba-spi", .data = dw_spi_elba_init},
>  	{ /* end of table */}
>  };
>  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
> -- 
> 2.17.1
> 
