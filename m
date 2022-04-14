Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A607950178E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358232AbiDNPlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353866AbiDNOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:41:28 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FD9BD7C7;
        Thu, 14 Apr 2022 07:32:41 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t207so3995886qke.2;
        Thu, 14 Apr 2022 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=emZ7XYPyCRycoXxp05wXOrh8mpo5yDWCQQvk32Zm7lU=;
        b=i66eVPB+lzhboiXlRHKgeDJD31kRfFC8OiORnXb0A3xXoW/PqCKD4TLQdQRKImo74R
         jvMgERqUa9HQ0V/klW+xCXYIQ2PhOHSnbEbDpeuPVluaZvI45kPrPp8HFZMDL+Ut3LrO
         LuzPH2OgiUu6M4e8zWJcen2EBOw5SNCTGNccvnBPbBwjO6KPGIJDWHGqLYy36lKCkNet
         QOpD6vMMunKVJh7H3kdQr3MC7P3xkXUzW2t3A/Rdq49mGdlRYc9OrB+T+sB1UG3UF0Eh
         IGrS0zlEl8lSeNkRiA7KsAxqVztDl2nrd14Pr0RBYmjKrAA/2h1D1SOt2ZlUu/E/BD/N
         Jh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=emZ7XYPyCRycoXxp05wXOrh8mpo5yDWCQQvk32Zm7lU=;
        b=7GE3Nmr83HSBSFQIwqthfwdiLoYwAn9WywWoFY6RDVlTSVZ5XJwGd3pCLo1pAaju17
         ol6Gfx7lmoRcwLmgMf58wowQsASe9Tm/fKexO3u6MKtt7Po2sXRdhnVoXBpgdN1rNQXW
         yWod96nFVax0BIyjFveBK/K7aokd7rXbHqcZd6deSrv539yeWIzyI9VtfoY750K2VxUR
         /n46BDtmcqmKm187MJpScDt7camiX1Cbz3lDNM+1bysuBLJc2pswddmClEewa0mEuRF8
         lZctmE3GfliAYzeYf/P25FObNq3RllYvEJNenvKk5EU5VcdZrQtrIfCDqU5aZX5lYQhT
         I4WA==
X-Gm-Message-State: AOAM5305H6L+mu4sPxh0afZklw67dWOc9aV8XqPAt4gybSp69yl09/dc
        EiO50+0kbGOZu+iv9xQXhbBTipp3d2Q=
X-Google-Smtp-Source: ABdhPJxKgOA2wI1T+BJbaHAI6XntjtvHEqwGf3e4MZP/bapA/JyfHEH/H7F7N5yCBjWYEj6tYUQTaw==
X-Received: by 2002:a05:620a:406:b0:69b:e25c:778c with SMTP id 6-20020a05620a040600b0069be25c778cmr2052455qkp.224.1649946760549;
        Thu, 14 Apr 2022 07:32:40 -0700 (PDT)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id l9-20020a05622a174900b002ee2fed0583sm1331298qtk.27.2022.04.14.07.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 07:32:39 -0700 (PDT)
Date:   Thu, 14 Apr 2022 10:32:38 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: afe: rescale: Make use of device properties
Message-ID: <Ylgwhu9zdmwwYnAq@shaak>
References: <20220413190117.29814-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413190117.29814-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Apr 13, 2022 at 10:01:17PM +0300, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/afe/Kconfig       | 1 -
>  drivers/iio/afe/iio-rescale.c | 5 ++---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/afe/Kconfig b/drivers/iio/afe/Kconfig
> index 4fa397822cff..9a1d95c1c7ed 100644
> --- a/drivers/iio/afe/Kconfig
> +++ b/drivers/iio/afe/Kconfig
> @@ -8,7 +8,6 @@ menu "Analog Front Ends"
>  
>  config IIO_RESCALE
>  	tristate "IIO rescale"
> -	depends on OF || COMPILE_TEST
>  	help
>  	  Say yes here to build support for the IIO rescaling
>  	  that handles voltage dividers, current sense shunts and
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 7e511293d6d1..c6cf709f0f05 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -10,9 +10,8 @@
>  
>  #include <linux/err.h>
>  #include <linux/gcd.h>
> +#include <linux/mod_devicetable.h>

Is this really needed?
device_get_match_data() is already defined in <linux/property.h>

Cheers,
Liam

>  #include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  
> @@ -536,7 +535,7 @@ static int rescale_probe(struct platform_device *pdev)
>  
>  	rescale = iio_priv(indio_dev);
>  
> -	rescale->cfg = of_device_get_match_data(dev);
> +	rescale->cfg = device_get_match_data(dev);
>  	rescale->numerator = 1;
>  	rescale->denominator = 1;
>  	rescale->offset = 0;
> -- 
> 2.35.1
> 
