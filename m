Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDFC56A3C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbiGGNfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbiGGNe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:34:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7172655A;
        Thu,  7 Jul 2022 06:34:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id o7so2019513lfq.9;
        Thu, 07 Jul 2022 06:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=npiD/6MFuemklK5N4fd6uEHkHHXVXjti7J9gtHmU40s=;
        b=cmR5ozNZsfKwq+weP+rKFbYmiNDOv4zHFvDr74i6ujcsQwO0YoGkRHvB/r+oFAKln/
         W11UC3fqmlyqvR+6CbzCDzCLdMYwgHza8uFRgDkO7C1awgsO/JmWB+MbfUzog3DiVu47
         SmU0GTAFMxexZskW24NxGnRQGPDyWdrsB9Yk8VTH5+UvadZMjmvM7errXPz0ONFxdpes
         L3yHBqGL9K0X8kTgjtjNpE0R1FyzKgWc7EW/XSwu3g3yC5wtu+2tQAzMnM1CJFHGvBhQ
         As1fim7+PS/2Rpf2C08sKYdWSNDqKr+uFkp6evVmL1r80feRCQ5kwD79EqQSG/ovLXUc
         XHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=npiD/6MFuemklK5N4fd6uEHkHHXVXjti7J9gtHmU40s=;
        b=suk+xXeg1DyacU9i/PwibfMxcH4GD6UdijeiDlHhjsmSz6DD5q8uHgVDqNjO6hjtpL
         9BI2KPxUtteaig/wm4k9H5n12uM5es+O5g2dS/4F1pMfmG49sirw9Fl/9RME+wh6GUXa
         LkglUOT6gebJSiUZvI62hNnple7SFx+b+JQCnFvKshTI5wQI2HyPuUZY0Y0Fq3upBSNi
         YUZMThlDC2r+eayqThw3IgGVaVYx1UsYTGxRM2q2jJ7QuvqxjwAQLIJDoxto+yjObp9b
         rs+uCKCphnq7yUqg7/xfjuJ28Znb9cLRJAP3yoaxHfOpkNKsa/vs+Jxwr7Ul1zNP5cd5
         oAjA==
X-Gm-Message-State: AJIora+uVC956oJXyhD4G0LFErJ1CX1lv36LJYsqbN6ZQcU6hUnITHoR
        MGEnb+ok2+52WazpyVIGCELCbUeyqGakIg==
X-Google-Smtp-Source: AGRyM1t5LzkNfwoBmsfHPCq31xvTANN944FKw4IxGkardC72NgDlX20ozt87xTwTiQciTV9VJcUGxQ==
X-Received: by 2002:ac2:5d66:0:b0:481:55cb:9b8b with SMTP id h6-20020ac25d66000000b0048155cb9b8bmr24579768lft.546.1657200896548;
        Thu, 07 Jul 2022 06:34:56 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id y5-20020a05651c106500b0025d520648d1sm223570ljm.43.2022.07.07.06.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:34:55 -0700 (PDT)
Date:   Thu, 7 Jul 2022 16:34:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     nandhini.srikandan@intel.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: [PATCH v5 4/4] spi: dw: Add support for Intel Thunder Bay SPI
 controller
Message-ID: <20220707133452.w4ljjvdglvh3nkyw@mobilestation>
References: <20220706042039.5763-1-nandhini.srikandan@intel.com>
 <20220706042039.5763-5-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706042039.5763-5-nandhini.srikandan@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 12:20:39PM +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> Add support for Intel Thunder Bay SPI controller, which uses DesignWare
> DWC_ssi core and also add common init function for both Keem Bay and
> Thunder Bay.
> 
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
>  drivers/spi/spi-dw-mmio.c | 8 ++++----
>  drivers/spi/spi-dw.h      | 3 +--
>  2 files changed, 5 insertions(+), 6 deletions(-)
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
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 8b8f924ac410..9e8eb2b52d5c 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -31,8 +31,7 @@
>  
>  /* DW SPI controller capabilities */
>  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
> -#define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
> -#define DW_SPI_CAP_DFS32		BIT(2)
> +#define DW_SPI_CAP_DFS32		BIT(1)
>  
>  /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
>  #define DW_SPI_CTRLR0			0x00
> -- 
> 2.17.1
> 
