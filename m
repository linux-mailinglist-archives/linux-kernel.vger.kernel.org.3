Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB7447A06E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 12:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhLSLj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 06:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhLSLjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 06:39:25 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59964C061574;
        Sun, 19 Dec 2021 03:39:25 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so4737445wmd.5;
        Sun, 19 Dec 2021 03:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ft3oKLurF6hMCVQa74jdw4TXbHeKdSU3wNMJqgY4OlY=;
        b=k863Aej6xkdXYwDACmqLplaqiKEcX+HqvwG4vhLwfApgmqlbU+olOIE05jNjEhz0QZ
         WCA2Y+c0AJHlHb70H1Fswoy1DqJ/3pUJrP+ksomuzKGZLu9KD0keHKYq7EIjKQoG7Qw4
         qU9AT5gg5WRNMyUHHYAnVtXlpX4838z/ubUWSOvcd5cHvNYzZUDedrrRZ3LjrCXnUQ3+
         4YFQ8U6787hQGe8BrkesyrDspHC6FK2DRgZeXQjNNv/0G9pYDXjiZdn2Iz6sec0zTL4C
         rd0vY5EGHrFg8vwX4sweYyP306axPNz6F+2ZgYhFsvQpDw+ewGGJ1FwDFSX3+myifkNB
         vEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ft3oKLurF6hMCVQa74jdw4TXbHeKdSU3wNMJqgY4OlY=;
        b=AEipHxA3yVannpMrlwfsvQ4g14OcIzRmtPMaSYTNwqiI7Q+zIfjhxZfI02PD5x0YVQ
         MbVOxF85ZWCZ/mb/OulOMMMwAhumRfi83dui9eWFIn3kDbsThAxSuiP5s3q0vsUQyTBp
         P5gJFQKUPJ4OgsfdzW4MiOtw1rb9PUmWPpRQxAHIxl0NVPydDIZ0BiUG1YSw4zfH4s1T
         FVN3aiw1S2PPvF0f2SjX/QdsfkwafZNKrI7ax+rEtbinPMJ6qvON8xGjv2xrdkTq6mMT
         tE24UODeJ8BBrm/O7AuFrI3pXC6P7ccyX/eoRAHJv26dFJuWZ6Gc8Hi3H4UHqgB7IlKs
         U59g==
X-Gm-Message-State: AOAM531tX0NHX44oqp24YlqeB6GRtSCq5EmbKw+qQwk4jYf79rjriZBY
        +FfxT6kJYPRUU4fhSAmLo3Q=
X-Google-Smtp-Source: ABdhPJxzL03FHeD0Kjr65V2jgTmiVk1X/WAddNETGyx7YxktpPurJZm8JlexZtKsG9Uqxff+v1bj0g==
X-Received: by 2002:a1c:1903:: with SMTP id 3mr16718031wmz.89.1639913962499;
        Sun, 19 Dec 2021 03:39:22 -0800 (PST)
Received: from stewarton.localnet ([87.75.41.141])
        by smtp.gmail.com with ESMTPSA id u2sm14063631wrs.17.2021.12.19.03.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 03:39:22 -0800 (PST)
From:   Iain Hunter <drhunter95@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     lothar.felten@gmail.com, iain@hunterembedded.co.uk,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Zeng Tao <prime.zeng@hisilicon.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] workaround regression in ina2xx introduced by cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
Date:   Sun, 19 Dec 2021 11:39:20 +0000
Message-ID: <8262640.lOV4Wx5bFT@stewarton>
In-Reply-To: <db22c771-13be-11a2-a8db-b5d6b7d9e0c1@metafoo.de>
References: <20211216183506.2247510-1-drhunter95@gmail.com> <db22c771-13be-11a2-a8db-b5d6b7d9e0c1@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 16 December 2021 18:47:30 GMT Lars-Peter Clausen wrote:
> On 12/16/21 7:34 PM, Iain Hunter wrote:
> > From: Iain Hunter <iain@hunterembedded.co.uk>
> > 
> > Commit cb47755725da("time: Prevent undefined behaviour in
> > timespec64_to_ns()") introduced a regression in the ina2xx driver.
> > In ina2xx_capture_thread() a timespec64 structure is used to calculate
> > the delta time until the next sample time. This delta can be negative if
> > the next sample time was in the past which is common in ina2xx driver.
> > In the negative case timespec64_to_ns() now clamps the negative time
> > to KTIME_MAX. This essentially puts ina2xx thread to sleep forever.
> > Proposed patch is to:
> > a) change from timespec64_XXX() to standard raw ktime_XXX() APIs to remove
> > non-standard timespec64 calls.
> > 
> > b) split the functionality in the loop into two parts:
> >   - do while loop only does the test to see if the next sample time is in
> >   the
> > 
> > future or in the past. If in the past and the next sample time will be
> > incremented until it is in the future. This test is done with a simple
> > signed comparison as we are only interested in the sign being positive or
> > negative.
> > 
> >   - after do while loop we know that next is later than now and so delay
> >   is
> > 
> > positive and ksub_sub() can be used to get the delay which is positive.
> 
> This sounds to me as if the original commit that introduced the change
> is broken since it doesn't handle negative timespecs. And other drivers
> would be affected by this as well.
> 
> Had a quick look and there is commit 39ff83f2f6cc "time: Handle negative
> seconds correctly in timespec64_to_ns()"[1].
> 
> Which should also fix this driver.
> 
> - Lars

Hi Lars,
From a functionality point of view commit[1] would fix the ina2xx driver. 
However, during the original patch discussion it was pointed out that ktime 
API is a much more standard solution to work out timings and that timespec64 
didn't provide any benefit. There is only one other reference to timespec64 in 
drivers/iio (in industrialio-core.c) but many usages of ktime.
Iain
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?i
> d=39ff83f2f6cc
> > Signed-off-by: Iain Hunter <iain@hunterembedded.co.uk>
> > 
> > Fixes: cb47755725da("time: Prevent undef$
> > ---
> > 
> >   drivers/iio/adc/ina2xx-adc.c | 15 +++++++--------
> >   1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> > index a4b2ff9e0..17f702772 100644
> > --- a/drivers/iio/adc/ina2xx-adc.c
> > +++ b/drivers/iio/adc/ina2xx-adc.c
> > @@ -775,7 +775,7 @@ static int ina2xx_capture_thread(void *data)
> > 
> >   	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
> >   	int sampling_us = SAMPLING_PERIOD(chip);
> >   	int ret;
> > 
> > -	struct timespec64 next, now, delta;
> > +	ktime_t next, now;
> > 
> >   	s64 delay_us;
> >   	
> >   	/*
> > 
> > @@ -785,7 +785,7 @@ static int ina2xx_capture_thread(void *data)
> > 
> >   	if (!chip->allow_async_readout)
> >   	
> >   		sampling_us -= 200;
> > 
> > -	ktime_get_ts64(&next);
> > +	next = ktime_get();
> > 
> >   	do {
> >   	
> >   		while (!chip->allow_async_readout) {
> > 
> > @@ -798,7 +798,7 @@ static int ina2xx_capture_thread(void *data)
> > 
> >   			 * reset the reference timestamp.
> >   			 */
> >   			
> >   			if (ret == 0)
> > 
> > -				ktime_get_ts64(&next);
> > +				next = ktime_get();
> > 
> >   			else
> >   			
> >   				break;
> >   		
> >   		}
> > 
> > @@ -807,7 +807,7 @@ static int ina2xx_capture_thread(void *data)
> > 
> >   		if (ret < 0)
> >   		
> >   			return ret;
> > 
> > -		ktime_get_ts64(&now);
> > +		now = ktime_get();
> > 
> >   		/*
> >   		
> >   		 * Advance the timestamp for the next poll by one sampling
> > 
> > @@ -816,11 +816,10 @@ static int ina2xx_capture_thread(void *data)
> > 
> >   		 * multiple times, i.e. samples are dropped.
> >   		 */
> >   		
> >   		do {
> > 
> > -			timespec64_add_ns(&next, 1000 * sampling_us);
> > -			delta = timespec64_sub(next, now);
> > -			delay_us = div_s64(timespec64_to_ns(&delta), 
1000);
> > -		} while (delay_us <= 0);
> > +			next = ktime_add_us(next, sampling_us);
> > +		} while (next <= now);
> > 
> > +		delay_us = ktime_to_us(ktime_sub(next, now));
> > 
> >   		usleep_range(delay_us, (delay_us * 3) >> 1);
> >   	
> >   	} while (!kthread_should_stop());




