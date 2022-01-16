Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F6848FDE6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 17:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiAPQfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 11:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiAPQfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 11:35:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC27C061574;
        Sun, 16 Jan 2022 08:35:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 773D0B80D84;
        Sun, 16 Jan 2022 16:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C242C36AE7;
        Sun, 16 Jan 2022 16:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642350927;
        bh=TG8bFe/YQ4SfEpe1uR+dWRC9Z/suScV1haDJ8ijTz+8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a1YidBPYNqgH2RmHIiVrk5oyEzKtAFhD5uovYU+RxbbEMaX7JivapBpPMKbX3K1Wk
         RA/yYHlVxPJXxc9N6Ya8GvbiWpvegBLMJhtsVhOeQIqzD2wd6Bw3zt+IDN80QAp1gi
         jQ0/QsmCxyLBhYtF4+qR0HU5RzFWnOUbigS8NSQtHtCPpHkFIyXJ7LhgV02BlzjWUe
         6E+MHWKz+jqn8I33YHaKLJlpDLzSj6IowxqKJRptfoW2OyixhWF9nrH9f9XAK1JdWL
         qXFh2MVkXfy3gtevXMwafHrTBzdu//JNq//+RHOVmvQ+DE2pV98QNdmEMCS6beCNra
         KAU+YP9HDh9/g==
Date:   Sun, 16 Jan 2022 16:41:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Iain Hunter <drhunter95@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, lothar.felten@gmail.com,
        iain@hunterembedded.co.uk,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Zeng Tao <prime.zeng@hisilicon.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] workaround regression in ina2xx introduced by
 cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
Message-ID: <20220116164126.6b1f432d@jic23-huawei>
In-Reply-To: <8262640.lOV4Wx5bFT@stewarton>
References: <20211216183506.2247510-1-drhunter95@gmail.com>
        <db22c771-13be-11a2-a8db-b5d6b7d9e0c1@metafoo.de>
        <8262640.lOV4Wx5bFT@stewarton>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Dec 2021 11:39:20 +0000
Iain Hunter <drhunter95@gmail.com> wrote:

> On Thursday, 16 December 2021 18:47:30 GMT Lars-Peter Clausen wrote:
> > On 12/16/21 7:34 PM, Iain Hunter wrote:  
> > > From: Iain Hunter <iain@hunterembedded.co.uk>
> > > 
> > > Commit cb47755725da("time: Prevent undefined behaviour in
> > > timespec64_to_ns()") introduced a regression in the ina2xx driver.
> > > In ina2xx_capture_thread() a timespec64 structure is used to calculate
> > > the delta time until the next sample time. This delta can be negative if
> > > the next sample time was in the past which is common in ina2xx driver.
> > > In the negative case timespec64_to_ns() now clamps the negative time
> > > to KTIME_MAX. This essentially puts ina2xx thread to sleep forever.
> > > Proposed patch is to:
> > > a) change from timespec64_XXX() to standard raw ktime_XXX() APIs to remove
> > > non-standard timespec64 calls.
> > > 
> > > b) split the functionality in the loop into two parts:
> > >   - do while loop only does the test to see if the next sample time is in
> > >   the
> > > 
> > > future or in the past. If in the past and the next sample time will be
> > > incremented until it is in the future. This test is done with a simple
> > > signed comparison as we are only interested in the sign being positive or
> > > negative.
> > > 
> > >   - after do while loop we know that next is later than now and so delay
> > >   is
> > > 
> > > positive and ksub_sub() can be used to get the delay which is positive.  
> > 
> > This sounds to me as if the original commit that introduced the change
> > is broken since it doesn't handle negative timespecs. And other drivers
> > would be affected by this as well.
> > 
> > Had a quick look and there is commit 39ff83f2f6cc "time: Handle negative
> > seconds correctly in timespec64_to_ns()"[1].
> > 
> > Which should also fix this driver.
> > 
> > - Lars  
> 
> Hi Lars,
> From a functionality point of view commit[1] would fix the ina2xx driver. 
> However, during the original patch discussion it was pointed out that ktime 
> API is a much more standard solution to work out timings and that timespec64 
> didn't provide any benefit. There is only one other reference to timespec64 in 
> drivers/iio (in industrialio-core.c) but many usages of ktime.
> Iain
> > 
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?i
> > d=39ff83f2f6cc  
> > > Signed-off-by: Iain Hunter <iain@hunterembedded.co.uk>
> > > 
> > > Fixes: cb47755725da("time: Prevent undef$

Please fix this tag and resend.  Also there should be no blank lines in the tag
block. 

Or perhaps drop the tag and treat this as a cleanup, which is what I believe it
is after the fix Lars called out.

Patch title also should be in keeping with patches to the subsystem in question.
Here something like:

iio:adc:ina2xx: Switch from timespec64 to ktime_t.

Thanks,

Jonathan

> > > ---
> > > 
> > >   drivers/iio/adc/ina2xx-adc.c | 15 +++++++--------
> > >   1 file changed, 7 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> > > index a4b2ff9e0..17f702772 100644
> > > --- a/drivers/iio/adc/ina2xx-adc.c
> > > +++ b/drivers/iio/adc/ina2xx-adc.c
> > > @@ -775,7 +775,7 @@ static int ina2xx_capture_thread(void *data)
> > > 
> > >   	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
> > >   	int sampling_us = SAMPLING_PERIOD(chip);
> > >   	int ret;
> > > 
> > > -	struct timespec64 next, now, delta;
> > > +	ktime_t next, now;
> > > 
> > >   	s64 delay_us;
> > >   	
> > >   	/*
> > > 
> > > @@ -785,7 +785,7 @@ static int ina2xx_capture_thread(void *data)
> > > 
> > >   	if (!chip->allow_async_readout)
> > >   	
> > >   		sampling_us -= 200;
> > > 
> > > -	ktime_get_ts64(&next);
> > > +	next = ktime_get();
> > > 
> > >   	do {
> > >   	
> > >   		while (!chip->allow_async_readout) {
> > > 
> > > @@ -798,7 +798,7 @@ static int ina2xx_capture_thread(void *data)
> > > 
> > >   			 * reset the reference timestamp.
> > >   			 */
> > >   			
> > >   			if (ret == 0)
> > > 
> > > -				ktime_get_ts64(&next);
> > > +				next = ktime_get();
> > > 
> > >   			else
> > >   			
> > >   				break;
> > >   		
> > >   		}
> > > 
> > > @@ -807,7 +807,7 @@ static int ina2xx_capture_thread(void *data)
> > > 
> > >   		if (ret < 0)
> > >   		
> > >   			return ret;
> > > 
> > > -		ktime_get_ts64(&now);
> > > +		now = ktime_get();
> > > 
> > >   		/*
> > >   		
> > >   		 * Advance the timestamp for the next poll by one sampling
> > > 
> > > @@ -816,11 +816,10 @@ static int ina2xx_capture_thread(void *data)
> > > 
> > >   		 * multiple times, i.e. samples are dropped.
> > >   		 */
> > >   		
> > >   		do {
> > > 
> > > -			timespec64_add_ns(&next, 1000 * sampling_us);
> > > -			delta = timespec64_sub(next, now);
> > > -			delay_us = div_s64(timespec64_to_ns(&delta),   
> 1000);
> > > -		} while (delay_us <= 0);
> > > +			next = ktime_add_us(next, sampling_us);
> > > +		} while (next <= now);
> > > 
> > > +		delay_us = ktime_to_us(ktime_sub(next, now));
> > > 
> > >   		usleep_range(delay_us, (delay_us * 3) >> 1);
> > >   	
> > >   	} while (!kthread_should_stop());  
> 
> 
> 
> 

