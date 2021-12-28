Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6049480C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbhL1Sdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 13:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbhL1Sdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:33:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E53C061574;
        Tue, 28 Dec 2021 10:33:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D098C611C8;
        Tue, 28 Dec 2021 18:33:44 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 9E4EAC36AEC;
        Tue, 28 Dec 2021 18:33:41 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:39:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     trix@redhat.com
Cc:     jacopo@jmondi.org, lars@metafoo.de, nathan@kernel.org,
        ndesaulniers@google.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] iio: chemical: set val parameter only on success
Message-ID: <20211228183925.059884e1@jic23-huawei>
In-Reply-To: <20211224150833.3278236-1-trix@redhat.com>
References: <20211224150833.3278236-1-trix@redhat.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021 07:08:33 -0800
trix@redhat.com wrote:

> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this representative warning
> 
> sunrise_co2.c:410:9: warning: Assigned value is garbage or undefined
>   *val = value;
>        ^ ~~~~~
> 
> The ealier call to sunrise_read_word can fail without setting
> value.  So defer setting val until we know the read was successful.
> 
> Fixes: c397894e24f1 ("iio: chemical: Add Senseair Sunrise 006-0-007 driver")
> Signed-off-by: Tom Rix <trix@redhat.com>
Hi Tom,

This won't have any actual affect as if the read_raw callback returns a negative
error code we won't use the value.  However, good to clean it up so applied
to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/chemical/sunrise_co2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/chemical/sunrise_co2.c b/drivers/iio/chemical/sunrise_co2.c
> index 233bd0f379c93..8440dc0c77cfe 100644
> --- a/drivers/iio/chemical/sunrise_co2.c
> +++ b/drivers/iio/chemical/sunrise_co2.c
> @@ -407,24 +407,24 @@ static int sunrise_read_raw(struct iio_dev *iio_dev,
>  			mutex_lock(&sunrise->lock);
>  			ret = sunrise_read_word(sunrise, SUNRISE_CO2_FILTERED_COMP_REG,
>  						&value);
> -			*val = value;
>  			mutex_unlock(&sunrise->lock);
>  
>  			if (ret)
>  				return ret;
>  
> +			*val = value;
>  			return IIO_VAL_INT;
>  
>  		case IIO_TEMP:
>  			mutex_lock(&sunrise->lock);
>  			ret = sunrise_read_word(sunrise, SUNRISE_CHIP_TEMPERATURE_REG,
>  						&value);
> -			*val = value;
>  			mutex_unlock(&sunrise->lock);
>  
>  			if (ret)
>  				return ret;
>  
> +			*val = value;
>  			return IIO_VAL_INT;
>  
>  		default:

