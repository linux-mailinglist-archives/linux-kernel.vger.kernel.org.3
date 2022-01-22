Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A816496CE7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 17:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiAVQct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 11:32:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54386 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiAVQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 11:32:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79803B8091A;
        Sat, 22 Jan 2022 16:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917E6C004E1;
        Sat, 22 Jan 2022 16:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642869162;
        bh=O1YKP2zxAjxpYTB2jpe00SOrFFC7mU73AH0qfZgF2cU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zq3oPdsdyVX+OzGH3z8AmCWvJL6SOUkLbu2T+K74FakINASMU7CVl0AV6YBE0jcSX
         Oj1GA3fw3gE5GdfrxszdfD86JtsD4DqO0lvCv/xciWpwXdu+erYEE633mOSEtbBiK2
         RCY7OBGJRW94eOVh966ZvDFku1SJxZ3o6pkCxaHlwLWanMkN7bE7IjMpegRCFCYIlN
         cqLdAB49NKTBdyO43ArCI3/gP2ium+jZ7tMvsSFwcfxv32bcoX7wQgaRbnrgVkJpJn
         xhKDa92qBIl/MdGKz5EuO+n6B74Qdl3R7w5WVs7FvZY+N6ClNhy293ONRxDb8MLjjc
         CtZz620cKBlcQ==
Date:   Sat, 22 Jan 2022 16:38:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/31] iio: light: cm3605: changing LED_* from enum
 led_brightness to actual value
Message-ID: <20220122163851.1aa52770@jic23-huawei>
In-Reply-To: <20220121165436.30956-5-sampaio.ime@gmail.com>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
        <20220121165436.30956-5-sampaio.ime@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 13:54:09 -0300
Luiz Sampaio <sampaio.ime@gmail.com> wrote:

> The enum led_brightness, which contains the declaration of LED_OFF,
> LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
> max_brightness.

No sign-off and please always cc everyone on the cover letter of a series
including all mailing lists.  Otherwise we have no visibility of the
reasoning behind the change.  We all need to see the cover letter.
Sure I can go search for this patch on lore.kernel.org, but why
make it hard :)

Thanks,

Jonathan

> ---
>  drivers/iio/light/cm3605.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
> index 50d34a98839c..f60db6cd9e6d 100644
> --- a/drivers/iio/light/cm3605.c
> +++ b/drivers/iio/light/cm3605.c
> @@ -238,7 +238,7 @@ static int cm3605_probe(struct platform_device *pdev)
>  
>  	/* Just name the trigger the same as the driver */
>  	led_trigger_register_simple("cm3605", &cm3605->led);
> -	led_trigger_event(cm3605->led, LED_FULL);
> +	led_trigger_event(cm3605->led, 255);
>  
>  	indio_dev->info = &cm3605_info;
>  	indio_dev->name = "cm3605";
> @@ -255,7 +255,7 @@ static int cm3605_probe(struct platform_device *pdev)
>  	return 0;
>  
>  out_remove_trigger:
> -	led_trigger_event(cm3605->led, LED_OFF);
> +	led_trigger_event(cm3605->led, 0);
>  	led_trigger_unregister_simple(cm3605->led);
>  out_disable_aset:
>  	gpiod_set_value_cansleep(cm3605->aset, 0);
> @@ -269,7 +269,7 @@ static int cm3605_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct cm3605 *cm3605 = iio_priv(indio_dev);
>  
> -	led_trigger_event(cm3605->led, LED_OFF);
> +	led_trigger_event(cm3605->led, 0);
>  	led_trigger_unregister_simple(cm3605->led);
>  	gpiod_set_value_cansleep(cm3605->aset, 0);
>  	iio_device_unregister(indio_dev);
> @@ -283,7 +283,7 @@ static int __maybe_unused cm3605_pm_suspend(struct device *dev)
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct cm3605 *cm3605 = iio_priv(indio_dev);
>  
> -	led_trigger_event(cm3605->led, LED_OFF);
> +	led_trigger_event(cm3605->led, 0);
>  	regulator_disable(cm3605->vdd);
>  
>  	return 0;
> @@ -298,7 +298,7 @@ static int __maybe_unused cm3605_pm_resume(struct device *dev)
>  	ret = regulator_enable(cm3605->vdd);
>  	if (ret)
>  		dev_err(dev, "failed to enable regulator in resume path\n");
> -	led_trigger_event(cm3605->led, LED_FULL);
> +	led_trigger_event(cm3605->led, 255);
>  
>  	return 0;
>  }

