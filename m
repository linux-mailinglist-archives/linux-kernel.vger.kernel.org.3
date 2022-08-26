Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE235A31A8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245668AbiHZWDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiHZWDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:03:25 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EC6D25FD;
        Fri, 26 Aug 2022 15:03:24 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id x24so2779674lji.9;
        Fri, 26 Aug 2022 15:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=mA6IyE56G8GmDzsNcP8sd1G+w7SoV0bjdvA2O1Tab5c=;
        b=nPfQjNLS+taj001CAmJNB1+It3HKUHAftq7IMgzaZObcRngSUAmp9/vy7JtOIqVL18
         rAs/abLTXXZmSGq2Wnxd2X9p6YICbpaYI7qChPReBQAEPXaVIMJwX2XqpknVMUO8ZWVJ
         Nwm8SxosjPGeu33/T+DmpmOVL3zzUokNJDTQghyw1JjDm/QMTGxa4z29oWpKbBhSLymh
         jWEq8ot1c5zg0BmeOpMQjgMQsKy+EE10SjujJQ3SvWZt7pWWgZFs/+vnp4OWWGinCFEZ
         /Mcdoh1arUk5OfAaw8AMkFZ3hVEiI11g3O0E75Yf+j2l9rsjuDjC9OxwcIF5Cc92kKNN
         /0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=mA6IyE56G8GmDzsNcP8sd1G+w7SoV0bjdvA2O1Tab5c=;
        b=xFo+hclF/8AAKXoMUbZdDJokCqOIj+LJKAzBjxZNc50E46dXXx8/tqOJRRBhvPGz1Y
         VI3DRnAEkSUJJyjdN2ATGUZbuBBLstx/qYP9LKasU76sZkegxoXmodpLkO3IHgGpAiwG
         C0k8OiN2CNNx0MAUiyrWJjrSs7JhkxL6cEt9MqhfBqLbikACA6iWev/AkUHcC+bVY2Ag
         z4iJ31tKhSJKu/B2NOSRfgsdJOTyzSrbc1a8ZvZUiO/kmYUMVFqeQ7lo88LPUwOqpNWf
         aYuNo9I0ZMHyv67AYYFV690OTEtTCuxZwLBcncesKV5dRLhEKL+mlONZFT5ARi9Z6QYN
         ez/Q==
X-Gm-Message-State: ACgBeo0hYnWjWOisvEnZsHoxk7qW8mv2DZYlXsgKIaAe2jbYbXtW0mnM
        T/2UjV6tp3b0mA8d8OyWe2E=
X-Google-Smtp-Source: AA6agR4g/s55SGc4KxQwpUzIETfEVdtbZP9sZhA5gYz7/0B2gtRkrLztI1477udrne+YlLPAmorVvw==
X-Received: by 2002:a2e:2a06:0:b0:261:cee4:e4b with SMTP id q6-20020a2e2a06000000b00261cee40e4bmr2623956ljq.260.1661551402434;
        Fri, 26 Aug 2022 15:03:22 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id f13-20020a056512092d00b00492ed031aacsm483538lft.173.2022.08.26.15.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 15:03:21 -0700 (PDT)
Date:   Sat, 27 Aug 2022 01:03:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com
Subject: Re: [PATCH 03/11] spi: dw: define spi_frf for dual/quad/octal modes
Message-ID: <20220826220319.5flk4zkz4gzzj7vh@mobilestation>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-4-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-4-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:57:47PM +0100, Sudip Mukherjee wrote:
> The SPI mode needs to be mentioned in CTRLR0[23:22] register. Define a
> configuration variable to keep the mode based on the buswidth, which will
> then be used to update CR0. If the transfer is using dual/quad/octal
> mode then mark enhanced_spi as true.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 29 +++++++++++++++++++++++++++++
>  drivers/spi/spi-dw.h      |  7 +++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 77529e359b6d..8c84a2e991b5 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -333,6 +333,14 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
>  		/* CTRLR0[11:10] Transfer Mode */
>  		cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_TMOD_MASK, cfg->tmode);
>  

> +	if (dws->caps & DW_SPI_CAP_EXT_SPI) {

Drop this conditional statement. Just always set the spi_frf field.


> +		if (cfg->spi_frf)

Drop this conditional statement. Just always set the spi_frf. It shall
be zero if the Enhanced SPI modes are unsupported.

> +			cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_SPI_FRF_MASK,

Since the SPI_FRF field has different offset in the DW APB and DW AHB
SSI controllers, you'll need to initialize the mode based on the
IP-core ID using the dw_spi_ip_is() macro (see the as it's done for
tmode).

> +				cfg->spi_frf);
> +		else

> +			cr0 &= ~DW_HSSI_CTRLR0_SPI_FRF_MASK;

This is redundant. The initial value never has the SPI_FRF field set
(see the dw_spi_setup() and dw_spi_prepare_cr0() methods for details).

> +	}
> +
>  	dw_writel(dws, DW_SPI_CTRLR0, cr0);
>  
>  	if (cfg->tmode == DW_SPI_CTRLR0_TMOD_EPROMREAD ||
> @@ -679,10 +687,31 @@ static void dw_spi_stop_mem_op(struct dw_spi *dws, struct spi_device *spi)
>  static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  {
>  	struct dw_spi *dws = spi_controller_get_devdata(mem->spi->controller);
> +	bool enhanced_spi = false;
>  	struct dw_spi_cfg cfg;
>  	unsigned long flags;
>  	int ret;
>  

> +	if (dws->caps & DW_SPI_CAP_EXT_SPI) {
> +		switch (op->data.buswidth) {
> +		case 2:
> +			cfg.spi_frf = DW_SSI_CTRLR0_SPI_FRF_DUAL_SPI;
> +			enhanced_spi = true;
> +			break;
> +		case 4:
> +			cfg.spi_frf = DW_SSI_CTRLR0_SPI_FRF_QUAD_SPI;
> +			enhanced_spi = true;
> +			break;
> +		case 8:
> +			cfg.spi_frf = DW_SSI_CTRLR0_SPI_FRF_OCT_SPI;
> +			enhanced_spi = true;
> +			break;
> +		default:
> +			cfg.spi_frf = 0;
> +			break;
> +		}
> +	}
> +

Please create a separate dw_spi_exec_enh_mem_op() method for the
Enhanced SPI communications and parse the data.buswidth field there.
Also it would be better to define a new macro
DW_SSI_CTRLR0_SPI_FRF_STD_SPI and use it instead of the explicit zero
SPI_FRF value.

>  	/*
>  	 * Collect the outbound data into a single buffer to speed the
>  	 * transmission up at least on the initial stage.
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 71d18e9291a3..b8cc20e0deaa 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -96,6 +96,12 @@
>  #define DW_HSSI_CTRLR0_SRL			BIT(13)
>  #define DW_HSSI_CTRLR0_MST			BIT(31)
>  

> +/* Bit fields in CTRLR0 for enhanced SPI */

No need in the comment. The macros name is descriptive enough.

> +#define DW_HSSI_CTRLR0_SPI_FRF_MASK		GENMASK(23, 22)

Please also add the next new macros
#define DW_PSSI_CTRLR0_SPI_FRF_MASK		GENMASK(22, 21)
#define DW_SSI_CTRLR0_SPI_FRF_STD_SPI		0x0

and group them together with the rest of the APB SSI CTRL0 macros.

> +#define DW_SSI_CTRLR0_SPI_FRF_DUAL_SPI		0x1
> +#define DW_SSI_CTRLR0_SPI_FRF_QUAD_SPI		0x2
> +#define DW_SSI_CTRLR0_SPI_FRF_OCT_SPI		0x3

Please move these to be defined together with the APB SSI
CTRL0.SPI_FRF-related macros.

-Sergey

> +
>  /* Bit fields in CTRLR1 */
>  #define DW_SPI_NDF_MASK				GENMASK(15, 0)
>  
> @@ -136,6 +142,7 @@ struct dw_spi_cfg {
>  	u8 dfs;
>  	u32 ndf;
>  	u32 freq;
> +	u8 spi_frf;
>  };
>  
>  struct dw_spi;
> -- 
> 2.30.2
> 
