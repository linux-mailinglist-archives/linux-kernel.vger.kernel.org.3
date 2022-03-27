Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8256D4E88D2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbiC0QZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiC0QZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:25:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3AE4C40C;
        Sun, 27 Mar 2022 09:23:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90A9861090;
        Sun, 27 Mar 2022 16:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1471EC340EC;
        Sun, 27 Mar 2022 16:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648398228;
        bh=YkDb6E6VtnXov8jHR1w8NK/7WAyUsl5XyV+mYViI/iE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kf2cFa0wjjny3JaXVOXkLznTZSEzTiJG74AgLuspd+sBI6qwCUs6j+1HJZmiPVKEo
         AQegVXVtLyP0vibmflnZhuY77ZgkvWLVe4QS1n7k+SdcWYLz4EfhinS4mdJlmLy9+N
         zAvJCUxVDpG59aISHiO26KDh8flWqCA3ljekS4RFHUCwnCWlx9MrQUyiMKfLc+C7Zj
         vhlvL3TDjgXdo65htGao+nYkEGyyaue5J75HM/OXp7+t1RBXHmgDSd/HdbKxtu2lUo
         lVzSIFznum8jc0na+LePshZjhTt72aOS85Yd9JQ9+k5I9GauKgRgJHthh32klFnKtM
         Y4Kizvk4vbRRg==
Date:   Sun, 27 Mar 2022 17:31:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iio: accel: bma400: Fix the scale min and max
 macro values
Message-ID: <20220327173120.78fd5148@jic23-huawei>
In-Reply-To: <20220326194146.15549-2-jagathjog1996@gmail.com>
References: <20220326194146.15549-1-jagathjog1996@gmail.com>
        <20220326194146.15549-2-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2022 01:11:42 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Changing the scale macro values to match the bma400 sensitivity
> for 1 LSB of all the available ranges.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
Hi Jagath,

> ---
>  drivers/iio/accel/bma400.h | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index c4c8d74155c2..190366debdb3 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -83,8 +83,26 @@
>  #define BMA400_ACC_ODR_MIN_WHOLE_HZ 25
>  #define BMA400_ACC_ODR_MIN_HZ       12
>  
> -#define BMA400_SCALE_MIN            38357
> -#define BMA400_SCALE_MAX            306864
> +/* BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
Multiline comment syntax in IIO is
/*
 * BMA400....

> + * converting to micro values for +-2g range.
> + *
> + * For +-2g - 1 LSB = 0.976562 milli g = 0.009576 m/s^2
> + * For +-4g - 1 LSB = 1.953125 milli g = 0.019153 m/s^2
> + * For +-16g - 1 LSB = 7.8125 milli g = 0.076614 m/s^2
> + *
> + * The raw value which is used to select the different ranges is determined
> + * by the first bit set position from the scale value, so BMA400_SCALE_MIN
> + * should be odd.
> + *
> + * Scale values for +-2g, +-4g, +-8g and +-16g is populated into bma400_scales
> + * array by left shifting BMA400_SCALE_MIN.
> + * eg:
> + * To select +-2g = 9577 << 0 = raw value to write is 0.
> + * To select +-8g = 9577 << 2 = raw value to write is 2.
> + * To select +-16g = 9677 << 3 = raw value to write is 3.

9667?

> + */
> +#define BMA400_SCALE_MIN            9577
> +#define BMA400_SCALE_MAX            76617
>  
>  #define BMA400_NUM_REGULATORS       2
>  #define BMA400_VDD_REGULATOR        0

