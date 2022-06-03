Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAE953CD94
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbiFCQy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344127AbiFCQyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:54:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A19517FC;
        Fri,  3 Jun 2022 09:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EDCBB823A5;
        Fri,  3 Jun 2022 16:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EDAC385A9;
        Fri,  3 Jun 2022 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654275287;
        bh=nJDlaPVv1/V2QMFRZSMeGdjlbru3qoJgFHs4acH/VCI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f2bcnq/dtEyqSfGKM9xkhsnsX9DRvo6Ajnnglt+DUCZX/6Ns/LUk8f/rWz8OeSX2p
         d6PRpAZPCZvw8NeCY77evHvySMWc8ACGZccTLlMfPDrrcx9fTTCwxEwcnsXRwK9JpF
         gMcRCX+RUn67t5PojSNveufivxFXuNrNBbVq7gIfbUPBpnMOxbCw1E1Z7OPfeTHkHG
         IrBltCOd0fRZCb2sAz2TtA6cUf6xRzW3e2GSBcYAc7TqYBbopkCB8YP0HwNOHZhF0x
         T45IjVEmnD1ID5xH4uDJT+Dy+gxX5F2PPmXs3RvO2TatxN8HnPheCl/oigj3sTxCFf
         1UYIwRiZ/3KPQ==
Date:   Fri, 3 Jun 2022 18:03:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cixi Geng <cixi.geng1@unisoc.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: adc: sc27xx_adc: Re-use generic struct
 u32_fract
Message-ID: <20220603180347.2b0d0f08@jic23-huawei>
In-Reply-To: <20220530180910.2533-1-andriy.shevchenko@linux.intel.com>
References: <20220530180910.2533-1-andriy.shevchenko@linux.intel.com>
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

On Mon, 30 May 2022 21:09:10 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Instead of custom data type re-use generic struct u32_fract.

There isn't a custom data type  - I'll reword this whilst applying
if there is no reason for a v2.

> No changes intended.

functional changes

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Given they have been active recently I'd ideally like Cixi Geng
to take a quick glance at this before I apply it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/sc27xx_adc.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index e9ff2d6a8a57..f8421cbba8fa 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -579,15 +579,14 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>  	return ret;
>  }
>  
> -static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
> -				  int channel, int scale,
> -				  u32 *div_numerator, u32 *div_denominator)
> +static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data, int channel, int scale,
> +				  struct u32_fract *fract)
>  {
>  	u32 ratio;
>  
>  	ratio = data->var_data->get_ratio(channel, scale);
> -	*div_numerator = ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
> -	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
> +	fract->numerator = ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
> +	fract->denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
>  }
>  
>  static int adc_to_volt(struct sc27xx_adc_linear_graph *graph,
> @@ -615,7 +614,7 @@ static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
>  static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data, int channel,
>  				   int scale, int raw_adc)
>  {
> -	u32 numerator, denominator;
> +	struct u32_fract fract;
>  	u32 volt;
>  
>  	/*
> @@ -637,9 +636,9 @@ static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data, int channel,
>  		break;
>  	}
>  
> -	sc27xx_adc_volt_ratio(data, channel, scale, &numerator, &denominator);
> +	sc27xx_adc_volt_ratio(data, channel, scale, &fract);
>  
> -	return DIV_ROUND_CLOSEST(volt * denominator, numerator);
> +	return DIV_ROUND_CLOSEST(volt * fract.denominator, fract.numerator);
>  }
>  
>  static int sc27xx_adc_read_processed(struct sc27xx_adc_data *data,

