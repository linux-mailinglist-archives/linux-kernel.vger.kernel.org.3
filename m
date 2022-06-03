Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4B953CDF6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344347AbiFCRRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344314AbiFCRRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:17:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B9852B05;
        Fri,  3 Jun 2022 10:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0A6861A91;
        Fri,  3 Jun 2022 17:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD596C385B8;
        Fri,  3 Jun 2022 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654276648;
        bh=25W8vm1WR/xlJug3mdevOmNy9GipHwHhqTX4oo5o8Lo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oSNaJW2ph29l1IqDszjEUzTPPnWLFCgcEl5UcGTo2DZNM6jLQLYG1BI5FiIVK6Jkn
         HaSYPERhS76bCLotVOgii5sFp8KTL+1Dmke0YxeIbpvBzRY55sRQ+Ozf8bUIlq+J7i
         MJUBiUMFUj+Hmi7WorZ3KajlirTpL2enviCl3NuiVGaGpleqIdwUstAe28UF6Ldx/r
         V1kjgBflys5lnkzbm5Kp+sGCTqSz0D9ZD58M/7zzLpA4we8EzjU1FcW1zpRIUphZBG
         R9+oW3Mc0la5vM0wV5mCU9ckgmmAXoA9V7pI/RHVmbCIbZWoEpXJbsit1XKtOQWW3a
         GIfOe6x3Sc8dQ==
Date:   Fri, 3 Jun 2022 18:26:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?B?QW5kcsOp?= Gustavo Nakagomi Lopez <andregnl@usp.br>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH v1 1/1] iio: adc: lpc18xx_adc: Switch from of headers to
 mod_devicetable.h
Message-ID: <20220603182628.36f3a170@jic23-huawei>
In-Reply-To: <20220531212218.72189-1-andriy.shevchenko@linux.intel.com>
References: <20220531212218.72189-1-andriy.shevchenko@linux.intel.com>
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

On Wed,  1 Jun 2022 00:22:18 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is nothing directly using of specific interfaces in this driver,
> so lets not include the headers.
> 
> While at it, drop dependency to OF, which currently makes no sense.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied
> ---
>  drivers/iio/adc/Kconfig       | 2 +-
>  drivers/iio/adc/lpc18xx_adc.c | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 448ae243cd31..b9e913e25a5d 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -562,7 +562,7 @@ config LP8788_ADC
>  config LPC18XX_ADC
>  	tristate "NXP LPC18xx ADC driver"
>  	depends on ARCH_LPC18XX || COMPILE_TEST
> -	depends on OF && HAS_IOMEM
> +	depends on HAS_IOMEM
>  	help
>  	  Say yes here to build support for NXP LPC18XX ADC.
>  
> diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
> index ae9c9384f23e..42e6cd6fa6f7 100644
> --- a/drivers/iio/adc/lpc18xx_adc.c
> +++ b/drivers/iio/adc/lpc18xx_adc.c
> @@ -17,10 +17,9 @@
>  #include <linux/iio/driver.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  

