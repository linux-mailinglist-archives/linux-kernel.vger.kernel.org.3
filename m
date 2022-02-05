Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299134AAA86
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380683AbiBERYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376612AbiBERYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:24:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595F7C061348;
        Sat,  5 Feb 2022 09:24:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B977D61143;
        Sat,  5 Feb 2022 17:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E90C340E8;
        Sat,  5 Feb 2022 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644081885;
        bh=6w/99GRGMgWgYWe4X+KfojXSRYWk/PfNkbE0hES5fiM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vEptM6qr2UhahzEMsHKHAI5fI/NvwY4hHTg5yr6Nwen7w0VGgwmS1F7ntE3krzCWJ
         EJX4oTvBObppZGwzwEMahBSyBLY/gPloCdWW1EqguPmwMkRTyW7kIbvHbRVvdRu6BV
         N9BARRQfKKvVPUQhd5/6xrZZGCxDqq2DhaPHDqC81mx1/d2Ua7yLXBepVOMyIhjQuS
         i3iRMYcPArqq+B68TBnTyFopBk9cNNvfh9q5JcEKcK3DeT/l0cV83F26XBGpR2Yobw
         RLPKjpYEiQx8Kk/UGGB2pTJBU+8Z/CY34M/R+Mv7+CVx5e3sMcWkitA58bohHPT6sK
         d8ay07M1QlJ7Q==
Date:   Sat, 5 Feb 2022 17:31:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH v2 1/1] iio: trigger: stm32-timer: Make use of device
 properties
Message-ID: <20220205173114.5a60fc47@jic23-huawei>
In-Reply-To: <20220202204112.57095-1-andriy.shevchenko@linux.intel.com>
References: <20220202204112.57095-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Feb 2022 22:41:12 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Looks fine to me.  The stm32 drivers are well maintained so I'll
leave this one on list a little longer for feedback.

+Cc: Fabrice

> ---
> v2: dropped depends on OF
>  drivers/iio/trigger/Kconfig               |  2 +-
>  drivers/iio/trigger/stm32-timer-trigger.c | 11 ++++++-----
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
> index 8cef2f7452e8..7ecb69725b1d 100644
> --- a/drivers/iio/trigger/Kconfig
> +++ b/drivers/iio/trigger/Kconfig
> @@ -38,7 +38,7 @@ config IIO_STM32_LPTIMER_TRIGGER
>  
>  config IIO_STM32_TIMER_TRIGGER
>  	tristate "STM32 Timer Trigger"
> -	depends on (ARCH_STM32 && OF && MFD_STM32_TIMERS) || COMPILE_TEST
> +	depends on (ARCH_STM32 && MFD_STM32_TIMERS) || COMPILE_TEST
>  	help
>  	  Select this option to enable STM32 Timer Trigger
>  
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 4f9461e1412c..5049d9ecfc1a 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -11,9 +11,10 @@
>  #include <linux/iio/timer/stm32-timer-trigger.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/mfd/stm32-timers.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> -#include <linux/of_device.h>
> +#include <linux/property.h>
>  
>  #define MAX_TRIGGERS 7
>  #define MAX_VALIDS 5
> @@ -771,11 +772,11 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>  	unsigned int index;
>  	int ret;
>  
> -	if (of_property_read_u32(dev->of_node, "reg", &index))
> -		return -EINVAL;
> +	ret = device_property_read_u32(dev, "reg", &index);
> +	if (ret)
> +		return ret;
>  
> -	cfg = (const struct stm32_timer_trigger_cfg *)
> -		of_match_device(dev->driver->of_match_table, dev)->data;
> +	cfg = device_get_match_data(dev);
>  
>  	if (index >= ARRAY_SIZE(triggers_table) ||
>  	    index >= cfg->num_valids_table)

