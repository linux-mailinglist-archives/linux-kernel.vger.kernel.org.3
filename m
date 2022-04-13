Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32DF4FF757
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbiDMNFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiDMNFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:05:15 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2925DE65;
        Wed, 13 Apr 2022 06:02:54 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id q14so2074871ljc.12;
        Wed, 13 Apr 2022 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DsoL7Mcff/P8yWSOuRYGPu9K0BPc5YFFt2P409KKx30=;
        b=QtFGvM8sKQvm+wJ/nBR2IAk5mWmH5cvQ/GCH/v+oSs7OUB6l3Ou9DY7xg8ZJhsXvOs
         D6cRQ3cK2ErFXozW6cGy1YFeSGS85X9D1Qs0gu5/cKhwE43RFT2O8/ntUcSoPVJAXkvN
         Tv7UYgzwt5HZ92OAE4ZBd3ARu4bzPoOkbVI55yyv9Gy7f3kHCBVHQ9mYh4hQq6WmJegU
         t6f0ouKcB2YCg3XqZlVE0VLijd4JM5o3+4ptuVLtOGuU76lh9Fb+QdqF/8CNhZwB2W/k
         HBQqL8BF+RWAmStqamMwLsquRTfBv0scm294NOxkb0ZbhYPdCcZWrGWj1ou/gm1PR4VC
         8nUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DsoL7Mcff/P8yWSOuRYGPu9K0BPc5YFFt2P409KKx30=;
        b=uuu4re/DiGlULOv+xalJkfsb1uy3yKuO7u369kKKTDK2ie3wvYqqv2X3hQMkTcM9GI
         VgNnG3DROATwUB6vRB8tZc4NX6vLX0eSBs6Gn6ohAad1r9Gges9YMOEPnpgCdshNhsqs
         SbrOAGhnEwIt/iKsOxWoneMxTOilHV2IS01M1SsS8n/e4r0WF6a6ncOoRpfUXePlMd5X
         SRxoptIQ+c+NBB1iVdUoqhoexYgXBTobrXDjJ473li899vDAhw0b1GZ3U9qanXgB2L0I
         jD9QD6a1H8wwvX8qztJSTUuE1IfzMLcXACOk9XsI85rRgOqfr3fJ8HcJ1HRXdoA7DFQa
         oK9Q==
X-Gm-Message-State: AOAM5324A6zyaAWQbCLvYiOc1P/kpC6qMjxVjTdm++efpe76rRRxFS2K
        EkSjCcfJ0GWjvI1vwd/KEWA=
X-Google-Smtp-Source: ABdhPJxc/V5JLlMRJgAOd2l146rnCBFwRMhZFDfuXG+2JXvrfZTAyMuP07tIUt8kQWhMa+l8Z3xwmQ==
X-Received: by 2002:a2e:80cb:0:b0:24a:ffba:4d49 with SMTP id r11-20020a2e80cb000000b0024affba4d49mr26659889ljg.385.1649854972218;
        Wed, 13 Apr 2022 06:02:52 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id q2-20020a19f202000000b0046bc590d460sm453995lfh.188.2022.04.13.06.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 06:02:51 -0700 (PDT)
Date:   Wed, 13 Apr 2022 16:02:49 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     nandhini.srikandan@intel.com
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: [PATCH v4 3/3] spi: dw: Add support for master mode selection
 for DWC SSI controller
Message-ID: <20220413130249.ueisqj5xs3komhmr@mobilestation>
References: <20220308103331.4116-1-nandhini.srikandan@intel.com>
 <20220308103331.4116-4-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308103331.4116-4-nandhini.srikandan@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nandhini

AFAICS this patch should go before
[PATCH v4 2/3] spi: dw: Add support for Intel Thunder Bay SPI
controller Thus you'd perform the DWC AHB SSI Master mode conversion
first, then introduce the new controller support. Otherwise without
this patch applied the DW SPI driver is most likely left broken for
the Intel SPI controllers since you drop the DW_SPI_CAP_KEEMBAY_MST
macro usage in [PATCH 2/3] while the new DW AHB SSI Master
functionality is introduced in the next patch [PATCH 3/3]. So please
convert the series to the harmless configuration on each git image
state.

On Tue, Mar 08, 2022 at 06:33:31PM +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> Add support to select the controller mode as master mode by setting
> Bit 31 of CTRLR0 register. This feature is supported for controller
> versions above v1.02.
> 
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> ---
>  drivers/spi/spi-dw-core.c | 4 ++--
>  drivers/spi/spi-dw.h      | 7 +++----
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index ecea471ff42c..68bfdf2c4dc7 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -307,8 +307,8 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
>  		if (spi->mode & SPI_LOOP)
>  			cr0 |= DW_HSSI_CTRLR0_SRL;
>  

> -		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> -			cr0 |= DW_HSSI_CTRLR0_KEEMBAY_MST;
> +		/* CTRLR0[31] MST */
> +		cr0 |= DW_HSSI_CTRLR0_MST;

Could you please conditionally set that flag here? That's what we
agreed to do in v3:
https://lore.kernel.org/linux-spi/20211116191542.vc42cxvflzn66ien@mobilestation/
like this:
+	/* CTRLR0[31] MST */
+	if (dw_spi_ver_is_ge(dws, HSSI, 102A))
+		cr0 |= DWC_HSSI_CTRLR0_MST;

>  	}
>  
>  	return cr0;
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index d5ee5130601e..2583b7314c41 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -23,7 +23,7 @@
>  	((_dws)->ip == DW_ ## _ip ## _ID)
>  

>  #define __dw_spi_ver_cmp(_dws, _ip, _ver, _op) \
> -	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ver)
> +	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ ## _ver)

Nice catch. My mistake. Could you please move this change into a
dedicated patch with the next fixes tag?
Fixes: 2cc8d9227bbb ("spi: dw: Introduce Synopsys IP-core versions interface")

>  
>  #define dw_spi_ver_is(_dws, _ip, _ver) __dw_spi_ver_cmp(_dws, _ip, _ver, ==)
>  
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
> @@ -100,7 +99,7 @@

>   * 0: SSI is slave
>   * 1: SSI is master
>   */
> -#define DW_HSSI_CTRLR0_KEEMBAY_MST		BIT(31)
> +#define DW_HSSI_CTRLR0_MST			BIT(31)

Could you please drop the redundant comment above and join the
macro with the DW_HSSI_* macros group?

-Sergey

>  
>  /* Bit fields in CTRLR1 */
>  #define DW_SPI_NDF_MASK				GENMASK(15, 0)
> -- 
> 2.17.1
> 
