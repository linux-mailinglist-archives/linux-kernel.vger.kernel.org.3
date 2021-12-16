Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B93477BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhLPSrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:47:45 -0500
Received: from www381.your-server.de ([78.46.137.84]:36868 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhLPSro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=hIf+CanYFcd0zTq0Yl7/nrhvPbTQXi4vIwAVfBsh57w=; b=fxYYr3Moh6eHNn5mSQpzYd/hOW
        DYbghHlMI1i2o08PBWKkhzE+pIOt+Tlx8+jLyOdJ2mt8s3TrXFThbPfVB/GocYvGPJ2H0aj009boT
        VfeMRGtDtiW37vU9bhDoATKfIHqWwQaRuEld7MnJaol+9vMF4gCu0+jNEdTK3JsPXJKDi35YYIBSQ
        5ljZdpU0NRcqN0D1e65awZD1WoW7PL9KpQaE35ECg78xwEWLd1P/sC4MN4sdtTzgBl9Va6t3hRpJC
        7Y2qeXLcxVmvj/rIVBPQsMaMpLOlpvQEOzUBJGhpXJP2iXCcBef5H9HoO/odxhbJhkPpwVDRk8pgJ
        1EkIJa8g==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxvmt-0009pN-Lf; Thu, 16 Dec 2021 19:47:31 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxvmt-000VSO-CO; Thu, 16 Dec 2021 19:47:31 +0100
Subject: Re: [PATCH v5] workaround regression in ina2xx introduced by
 cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
To:     Iain Hunter <drhunter95@gmail.com>
Cc:     lothar.felten@gmail.com, iain@hunterembedded.co.uk,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Zeng Tao <prime.zeng@hisilicon.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211216183506.2247510-1-drhunter95@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <db22c771-13be-11a2-a8db-b5d6b7d9e0c1@metafoo.de>
Date:   Thu, 16 Dec 2021 19:47:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211216183506.2247510-1-drhunter95@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26389/Thu Dec 16 07:02:49 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 7:34 PM, Iain Hunter wrote:
> From: Iain Hunter <iain@hunterembedded.co.uk>
>
> Commit cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
> introduced a regression in the ina2xx driver.
> In ina2xx_capture_thread() a timespec64 structure is used to calculate
> the delta time until the next sample time. This delta can be negative if
> the next sample time was in the past which is common in ina2xx driver.
> In the negative case timespec64_to_ns() now clamps the negative time
> to KTIME_MAX. This essentially puts ina2xx thread to sleep forever.
> Proposed patch is to:
> a) change from timespec64_XXX() to standard raw ktime_XXX() APIs to remove
> non-standard timespec64 calls.
> b) split the functionality in the loop into two parts:
>   - do while loop only does the test to see if the next sample time is in the
> future or in the past. If in the past and the next sample time will be
> incremented until it is in the future. This test is done with a simple
> signed comparison as we are only interested in the sign being positive or
> negative.
>   - after do while loop we know that next is later than now and so delay is
> positive and ksub_sub() can be used to get the delay which is positive.

This sounds to me as if the original commit that introduced the change 
is broken since it doesn't handle negative timespecs. And other drivers 
would be affected by this as well.

Had a quick look and there is commit 39ff83f2f6cc "time: Handle negative 
seconds correctly in timespec64_to_ns()"[1].

Which should also fix this driver.

- Lars

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=39ff83f2f6cc


>
> Signed-off-by: Iain Hunter <iain@hunterembedded.co.uk>
>
> Fixes: cb47755725da("time: Prevent undef$
> ---
>   drivers/iio/adc/ina2xx-adc.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index a4b2ff9e0..17f702772 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -775,7 +775,7 @@ static int ina2xx_capture_thread(void *data)
>   	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
>   	int sampling_us = SAMPLING_PERIOD(chip);
>   	int ret;
> -	struct timespec64 next, now, delta;
> +	ktime_t next, now;
>   	s64 delay_us;
>   
>   	/*
> @@ -785,7 +785,7 @@ static int ina2xx_capture_thread(void *data)
>   	if (!chip->allow_async_readout)
>   		sampling_us -= 200;
>   
> -	ktime_get_ts64(&next);
> +	next = ktime_get();
>   
>   	do {
>   		while (!chip->allow_async_readout) {
> @@ -798,7 +798,7 @@ static int ina2xx_capture_thread(void *data)
>   			 * reset the reference timestamp.
>   			 */
>   			if (ret == 0)
> -				ktime_get_ts64(&next);
> +				next = ktime_get();
>   			else
>   				break;
>   		}
> @@ -807,7 +807,7 @@ static int ina2xx_capture_thread(void *data)
>   		if (ret < 0)
>   			return ret;
>   
> -		ktime_get_ts64(&now);
> +		now = ktime_get();
>   
>   		/*
>   		 * Advance the timestamp for the next poll by one sampling
> @@ -816,11 +816,10 @@ static int ina2xx_capture_thread(void *data)
>   		 * multiple times, i.e. samples are dropped.
>   		 */
>   		do {
> -			timespec64_add_ns(&next, 1000 * sampling_us);
> -			delta = timespec64_sub(next, now);
> -			delay_us = div_s64(timespec64_to_ns(&delta), 1000);
> -		} while (delay_us <= 0);
> +			next = ktime_add_us(next, sampling_us);
> +		} while (next <= now);
>   
> +		delay_us = ktime_to_us(ktime_sub(next, now));
>   		usleep_range(delay_us, (delay_us * 3) >> 1);
>   
>   	} while (!kthread_should_stop());


