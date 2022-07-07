Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED7156A3B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiGGNdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiGGNc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:32:58 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484D83193C;
        Thu,  7 Jul 2022 06:32:57 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t19so30512900lfl.5;
        Thu, 07 Jul 2022 06:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TtuCctLiUBsDg/El2R/LFu8UcsQyJ3QYHLK3i09xrZo=;
        b=TgK5U6kdSEmWxBs+Qle+io/mX+szrObSFd6XeExsi/+ahqjy/S3i0GPj0KiFyyE+kg
         oXrHAjM+d9nTaBLC2rIsFvLMH3mWvn5+kxo2MyWwK8Mqy4UWkUCCaUe06jfpRj98eoIy
         6jaHQOZ7U8AuVqO/MuVJzWwwKBrBVdzNNf3SJIljeiJs+1tN4DDxyC/GG5QXNMo7QY9X
         Jp2/fB3dJYA+9bDmU/UW/6FGZMnpCQT0KX7/zBwyP8ieGeiJ+U6HtG4cvMwvKCUPrbdF
         oxSCZX05CLayqk92AjCSt3Jgj1ZxKmGCVy1g7jqhLOdE0ZltDFFc17FWOL2g0NPR5Vl9
         mLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TtuCctLiUBsDg/El2R/LFu8UcsQyJ3QYHLK3i09xrZo=;
        b=BSvD8NzsNQB0N94iuLh98GwI5p4uU81l1KVoKBqOsaZcrtL9k2ThMs88LdTNfuqgYQ
         kUkF1FZKLcMK3/DZwVV7a4I6ca265uJMy5ODXZsSBXiH+PXF+3bavZZOdbXvZ9XtT1Qw
         I7I7LYpRtbs/kjsgEzbgB65H8z+PS87sjDgZO1Dx6oRCOAqslz1dkyo75TA5ntxoUuXT
         sIqax2pwN/2BeD+HjlVfIinD2IfJFMLqr3wVnkdThHIMj3X4IJyM/hrEofhXVq9fn7Us
         YxpQnwl2akOyl8bjR2BPA5pEYxJ9NTgKGeVzygWsEzXkLYX9Ui0wfoZ19illuAs8sj0I
         4jxQ==
X-Gm-Message-State: AJIora/wZUad9oUKGQgLTvCDWQrm24qpjQ7p09UxSS2ZklnTuO3lSTBl
        nd2jMIHblfipga9D+H22VtzkEtReyZA72A==
X-Google-Smtp-Source: AGRyM1vV9Ll9A0NQJjqT0fJm6rV5zJcuTNNNvEOpNpoodgBpp9bqjiPCRzKfak0FwdzMVEcFACvi+w==
X-Received: by 2002:a05:6512:3d86:b0:47f:9adc:cc27 with SMTP id k6-20020a0565123d8600b0047f9adccc27mr29274359lfv.608.1657200774963;
        Thu, 07 Jul 2022 06:32:54 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id f19-20020a2eb5b3000000b0025d4866b2c7sm867045ljn.4.2022.07.07.06.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:32:53 -0700 (PDT)
Date:   Thu, 7 Jul 2022 16:32:51 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     nandhini.srikandan@intel.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: [PATCH v5 3/4] spi: dw: Add support for master mode selection
 for DWC SSI controller
Message-ID: <20220707133251.36gb5cgqygz22jl3@mobilestation>
References: <20220706042039.5763-1-nandhini.srikandan@intel.com>
 <20220706042039.5763-4-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706042039.5763-4-nandhini.srikandan@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 12:20:38PM +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> Add support to select the controller mode as master mode by setting
> Bit 31 of CTRLR0 register. This feature is supported for controller
> versions above v1.02.
> 
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
>  drivers/spi/spi-dw-core.c | 5 +++--
>  drivers/spi/spi-dw.h      | 8 +-------
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index ecea471ff42c..41ae21e1b879 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -307,8 +307,9 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
>  		if (spi->mode & SPI_LOOP)
>  			cr0 |= DW_HSSI_CTRLR0_SRL;
>  
> -		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> -			cr0 |= DW_HSSI_CTRLR0_KEEMBAY_MST;
> +		/* CTRLR0[31] MST */
> +		if (dw_spi_ver_is_ge(dws, HSSI, 102A))
> +			cr0 |= DW_HSSI_CTRLR0_MST;
>  	}
>  
>  	return cr0;
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 79d853f6d192..8b8f924ac410 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -94,13 +94,7 @@
>  #define DW_HSSI_CTRLR0_SCPOL			BIT(9)
>  #define DW_HSSI_CTRLR0_TMOD_MASK		GENMASK(11, 10)
>  #define DW_HSSI_CTRLR0_SRL			BIT(13)
> -
> -/*
> - * For Keem Bay, CTRLR0[31] is used to select controller mode.
> - * 0: SSI is slave
> - * 1: SSI is master
> - */
> -#define DW_HSSI_CTRLR0_KEEMBAY_MST		BIT(31)
> +#define DW_HSSI_CTRLR0_MST			BIT(31)
>  
>  /* Bit fields in CTRLR1 */
>  #define DW_SPI_NDF_MASK				GENMASK(15, 0)
> -- 
> 2.17.1
> 
