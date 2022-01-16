Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338E948FC67
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 12:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiAPLwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 06:52:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45128 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiAPLwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 06:52:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B5C8B80978;
        Sun, 16 Jan 2022 11:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDF3C36AE7;
        Sun, 16 Jan 2022 11:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642333940;
        bh=Nn5UlheFW3tQqA1zQjKnG0yVDgckawJTxXhXNb922+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dO1X1bqItNZ+Swz4EtWfTIvkT02D1BqOWTiVxq4XpfymW2m89Q8BJipQBzwdVDcjg
         +UAYBO2I5FBYlRTCiWsVcccOpfHHanDJtluv7W7ocm5X8mj3cB0f/x7D/6WT+RttUB
         /9t976qnKrEkm+EBa1t+iy2cVjsOFCWWZR3iqfQ5mbUVb+k6SJ59QdqiMxC+XMVBDJ
         G+rKqIzivpfV8hjahhHBIJTGkAfMU6SdA6jrhoQls7pFOs33tsK5I8kAh6DWBNA9PK
         3zMfHAylOnXQUYhqz2KlAEOomgVtgsIXdyASR0wOBJ17sA6IalfO5WocBLZJmLutnM
         X9Ty5Yw3eMwzg==
Date:   Sun, 16 Jan 2022 11:58:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 1/1] iio: adc: tsc2046: fix memory corruption by
 preventing array overflow
Message-ID: <20220116115821.1d58b437@jic23-huawei>
In-Reply-To: <20220115181659.0c759ec5@jic23-huawei>
References: <20220107081401.2816357-1-o.rempel@pengutronix.de>
        <20220109152557.74f06d2d@jic23-huawei>
        <20220110071945.GB3326@pengutronix.de>
        <20220115181659.0c759ec5@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2022 18:16:59 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 10 Jan 2022 08:19:45 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Hi Jonathan,
> > 
> > On Sun, Jan 09, 2022 at 03:25:57PM +0000, Jonathan Cameron wrote:  
> > > On Fri,  7 Jan 2022 09:14:01 +0100
> > > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > >     
> > > > On one side we have indio_dev->num_channels includes all physical channels +
> > > > timestamp channel. On other side we have an array allocated only for
> > > > physical channels. So, fix memory corruption by ARRAY_SIZE() instead of
> > > > num_channels variable.
> > > > 
> > > > Fixes: 9374e8f5a38d ("iio: adc: add ADC driver for the TI TSC2046 controller")
> > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>    
> > > Hi Olesij,
> > > 
> > > Have you managed to make this occur, or is it inspection only?    
> > 
> > Yes, this bug has eaten my rx_one and tx_one pointers on probe. I wonted
> > to use this buffers for read_raw and noticed that they do not exist.  
> 
> I got hung up on the first case and failed to notice the second one was
> entirely different :(
> 
> >   
> > > I 'think' (it's been a while since I looked at the particular code) that the timestamp
> > > bit in active_scan_mask will never actually be set because we handle that as a
> > > separate flag.    
> > 
> > I didn't tested if active_scan_mask will trigger this issue as well, but
> > It it looked safer to me, to avoid this issue in both places. Even if on
> > of it is only theoretical.  
> 
> It certainly does no harm to not check a bit that is never set, so I'm fine with
> the change - just don't want to have lots of 'fixes' for this in other drivers
> adding noise and pointless backports.  This one is fine because we need the
> other part of the patch anyway.
> 
> Jonathan

On that note, applied to the fixes-togreg branch of iio.git and marked for stable
with a minor addition to the patch description to make
sure we don't get the first case cargo picked up by anyone who doesn't read this
thread as something to 'fix' everywhere else.

Thanks,

Jonathan

> 
> 
> >   
> > > So it is indeed an efficiency improvement to not check that bit but I don't think
> > > it's a bug to do so.  More than possible I'm missing something though!
> > > 
> > > This one had me quite worried when I first read it because this is a very common
> > > pattern to see in IIO drivers.    
> > 
> > I was thinking about this as well, because big part of this code was
> > inspired by other drivers. But i didn't reviewed other places so far.
> > 
> > Regards,
> > Oleksij  
> 

