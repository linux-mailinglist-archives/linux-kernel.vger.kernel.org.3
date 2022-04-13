Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2264FF764
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiDMNHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbiDMNH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:07:27 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9EC3153C;
        Wed, 13 Apr 2022 06:05:06 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id k5so3388799lfg.9;
        Wed, 13 Apr 2022 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MguF2RYo44MgrbhGTKMKxgWnE3eXi7QoNyV4A0lbMkU=;
        b=OMGKkYidNXblMlGPauRd7HZZrDaGyhOAGqWUKhUW7b9lIZpPhYesNwO0osykEVGO6Q
         6isboAeZeKTcv5//xD2RZcP74xvNR4w0yKIS0N0s+dPMX4K5nnj9sDXSrkhLJA5roxkl
         yCks0Zdmv9i1+2CAbRI8eqtGFYLF7+KX2WqWjZcIBMSX1AtiEfYLODPfk+IJzegO78sS
         vBp8fU6tDB3u7OC/eMs/eP0EfN/351DSlipBOaNYv8/fDoRO4EDvNlC6lnmIsTZzYmr2
         a9eK5fpZvoGfS4Q3aYYS8i9TeGSJrofKQs4N/Ddpm+/+200i8srxT2BZJQ8KHD54YJev
         OteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MguF2RYo44MgrbhGTKMKxgWnE3eXi7QoNyV4A0lbMkU=;
        b=eWzxYkxAG6E9+MLa68jhHiROn7YbVmV3ooYWpHRLiTSzi3nswAFlTgfZkbUC24m5v1
         jyPVCzwbW5DbGacFjpBqtWClbleWoGARS4dQVeFiqfLX6zFK7aro63PnHpH1Ar4PuK33
         5YlL+lPsg//dcNAX5XM31RZknwxTtpIu4gngjQStp+Pvtnlt0HtsKeRtnmzSS4wT0Mz7
         +sILXNtiML9u2i31OPhMVzFR38VyH+PzxtsqWDc7+Pg4GYuhvRq7/n3dAvIm0/Rlp51K
         macZIv5FGY+OYzgggXlPUe1SGe8lZveCKZBShq0uuElQur26THv0lI+AWGqOQ1BtDV3O
         /2tw==
X-Gm-Message-State: AOAM531HNwvs9/AjEMJvtPe/kXrZfiH9j29SsDgm2NdEMmUNNX6wIk/r
        VO9RpbD/psT1a1BtwQCWN8c=
X-Google-Smtp-Source: ABdhPJzUZEtK+7+xivPvVN1qQdh3Ze9UHqVekTAgLrdc4Qpf/Dm2vVfyTcwmYpLG2GVL/DSvCFAkjQ==
X-Received: by 2002:a05:6512:b19:b0:44a:b7c4:3d94 with SMTP id w25-20020a0565120b1900b0044ab7c43d94mr27445841lfu.358.1649855104383;
        Wed, 13 Apr 2022 06:05:04 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id p25-20020a056512329900b0046bc5c83fb7sm451552lfe.148.2022.04.13.06.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 06:05:03 -0700 (PDT)
Date:   Wed, 13 Apr 2022 16:05:02 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     nandhini.srikandan@intel.com
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: [PATCH v4 2/3] spi: dw: Add support for Intel Thunder Bay SPI
 controller
Message-ID: <20220413130502.amnwjuspgmm2mj3s@mobilestation>
References: <20220308103331.4116-1-nandhini.srikandan@intel.com>
 <20220308103331.4116-3-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308103331.4116-3-nandhini.srikandan@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 06:33:30PM +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> Add support for Intel Thunder Bay SPI controller, which uses DesignWare
> DWC_ssi core and also add common init function for both Keem Bay and
> Thunder Bay.

Please see my comments to the patch
[PATCH v4 3/3] spi: dw: Add support for master mode selection for DWC SSI controller
of this series. I think this patch should go after that one so to
introduce a safer conversion of the DWC AHB SSI functionality.

-Sergey

> 
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> ---
>  drivers/spi/spi-dw-mmio.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 5101c4c6017b..26c40ea6dd12 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -214,11 +214,10 @@ static int dw_spi_hssi_init(struct platform_device *pdev,
>  	return 0;
>  }
>  
> -static int dw_spi_keembay_init(struct platform_device *pdev,
> -			       struct dw_spi_mmio *dwsmmio)
> +static int dw_spi_intel_init(struct platform_device *pdev,
> +			     struct dw_spi_mmio *dwsmmio)
>  {
>  	dwsmmio->dws.ip = DW_HSSI_ID;
> -	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST;
>  
>  	return 0;
>  }
> @@ -349,7 +348,8 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
>  	{ .compatible = "amazon,alpine-dw-apb-ssi", .data = dw_spi_alpine_init},
>  	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_pssi_init},
>  	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_hssi_init},
> -	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
> +	{ .compatible = "intel,keembay-ssi", .data = dw_spi_intel_init},
> +	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
>  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
>  	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
>  	{ /* end of table */}
> -- 
> 2.17.1
> 
