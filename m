Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30F45A323F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345413AbiHZWyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiHZWyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:54:52 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32B4A451;
        Fri, 26 Aug 2022 15:54:46 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id l8so3750918lfc.12;
        Fri, 26 Aug 2022 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=KlUKhmVSDGLCq+qNQ31AyWcV10ZGUtGSbO9GS22mMcA=;
        b=lLS0FZcnxFXAi3kgiP927ytXkZfOvQ9ymvRh+YXeGeTre/DbZagcwR93jp9RvaId89
         TixILG5Qb4Hf3WPjfTbXPVzYJvMKFKLS5yMtLcm5OtdQQ8Eq2o/oWcc40KiwHTOLLoid
         bsnoK0oW1iHv3dDUQfWY2N9jJZVtp/x4IS5ngzcZwa9uMFdGtpDC0N5wlEqCreIjQYJY
         K8rb3V4bKRGu49MmkjtJSNpGs4irVdrphystcDSLCwnuTW4wVb1X6Ayy46uWLyAlu35o
         VCZ8mTfYBhOe4hrQjPWSPG8lDUwrKnj7Wlr4wLoVU8ozFBfLrE+y/p5GHHaPgBngLemL
         P4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KlUKhmVSDGLCq+qNQ31AyWcV10ZGUtGSbO9GS22mMcA=;
        b=pNtVs5krcctg5hqENyA0m2M/kwhPK7pIY+Ay3amh9zohS1gHNpHCG9Vrt2tc+ML58q
         LmbCUYaOfRNLV89F6PY3vg+y3UIVsMHdfkak+eCOyHfdMsZTBb5XspIP+Jmy9rivapbg
         /q286KEtLSO1B41xhJ52ux9tAATdaouBq8RzujflzRPqnig7WKZjRGN/6SIB/qfaMstf
         qlryl7C/juqVF1uq5cdoRv/Lbq2RL9LEbNs7F/qDliSYDoqiaUEq8et5nuACCE88BSEF
         u5Q1ZGusc0Qj00cZxaUa+qUsjjFpBvbujv7Hwh2NvLhlzTzNNbPjUvJ6WqkzUlnHqw6o
         vODg==
X-Gm-Message-State: ACgBeo0OL3XvhyZZeTGVreCN7X7Pi1xK5yl7ICHDJpE7le6ggF297AaU
        Nr3K48spiRTOwiH3+cf8Iu8=
X-Google-Smtp-Source: AA6agR4FMcVQU80dpr8mT6ZRiA/JM9VOd0+JpfKocz9y7nlDSQxFgjX5FpERSnvV3Kw9mzb7vnuJwg==
X-Received: by 2002:a19:f246:0:b0:493:50d:6bb with SMTP id d6-20020a19f246000000b00493050d06bbmr2891864lfk.461.1661554485298;
        Fri, 26 Aug 2022 15:54:45 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id w6-20020ac25d46000000b0048a85334a11sm496254lfd.143.2022.08.26.15.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 15:54:44 -0700 (PDT)
Date:   Sat, 27 Aug 2022 01:54:42 +0300
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
Subject: Re: [PATCH 07/11] spi: dw: update NDF while writing in enhanced spi
 mode
Message-ID: <20220826225442.47r6mjzkxbj3io5u@mobilestation>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-8-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-8-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:57:51PM +0100, Sudip Mukherjee wrote:
> If the transfer of Transmit only mode is using dual/quad/octal SPI then
> NDF needs to be updated with the number of data frames.
> If the Transmit FIFO goes empty in-between, DWC_ssi masks the serial
> clock and wait for rest of the data until the programmed amount of
> frames are transferred successfully.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 9d499bdf2ce6..8cb30540ad5b 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -344,7 +344,9 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
>  	dw_writel(dws, DW_SPI_CTRLR0, cr0);
>  
>  	if (cfg->tmode == DW_SPI_CTRLR0_TMOD_EPROMREAD ||
> -	    cfg->tmode == DW_SPI_CTRLR0_TMOD_RO)
> +	    cfg->tmode == DW_SPI_CTRLR0_TMOD_RO ||

> +	    (cfg->tmode == DW_SPI_CTRLR0_TMOD_TO &&
> +	     (dws->caps & DW_SPI_CAP_EXT_SPI) && cfg->spi_frf))

just (cfg->spi_frf != DW_SPI_CTRLR0_SPI_FRF_STD_SPI &&
      cfg->tmode == DW_SPI_CTRLR0_TMOD_TO)

>  		dw_writel(dws, DW_SPI_CTRLR1, cfg->ndf ? cfg->ndf - 1 : 0);
>  
>  	/* Note DW APB SSI clock divider doesn't support odd numbers */
> @@ -760,6 +762,8 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		cfg.ndf = op->data.nbytes;
>  	} else {
>  		cfg.tmode = DW_SPI_CTRLR0_TMOD_TO;

> +		if (enhanced_spi)
> +			cfg.ndf = op->data.nbytes;

This shall be moved to the Enhanced SPI-specific mem-op execution method:
dw_spi_exec_enh_mem_op().

-Sergey

>  	}
>  
>  	dw_spi_enable_chip(dws, 0);
> -- 
> 2.30.2
> 
