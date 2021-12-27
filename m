Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E14E47FC58
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 12:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhL0LxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 06:53:06 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53920 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhL0LxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 06:53:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EB5D8CE0EF0;
        Mon, 27 Dec 2021 11:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94117C36AEA;
        Mon, 27 Dec 2021 11:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640605982;
        bh=ZxiIva1jE9faop/ZsprofhcwQ/y/+Bk9xGDjZkcmpKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JkiTyM2LqbPgxURYEL6nE77yFrxFgyShyEsEErYQhizyrKWU7VL1//v2lWOoCXdbT
         vMRWuXN3CL/dXRXxTORcsSdCsIGbN4KBb16ExnbHV6wZ/Mdu1dSrXzxYVccUY5ikSh
         eXbpv5IC1obKpIF24bmPVKe3YfymlUzSg98Cthu0=
Date:   Mon, 27 Dec 2021 12:52:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/23] counter: Provide a wrapper to access device
 private data
Message-ID: <YcmpG78dI2nT/N8z@kroah.com>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-5-u.kleine-koenig@pengutronix.de>
 <YcmdNr8Y1jcMCwQQ@kroah.com>
 <cb583f3f-2cf9-2de5-8beb-da7c11ff1481@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb583f3f-2cf9-2de5-8beb-da7c11ff1481@metafoo.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 12:34:28PM +0100, Lars-Peter Clausen wrote:
> On 12/27/21 12:02 PM, Greg Kroah-Hartman wrote:
> > On Mon, Dec 27, 2021 at 10:45:07AM +0100, Uwe Kleine-König wrote:
> > > For now this just wraps accessing struct counter_device::priv. However
> > > this is about to change and converting drivers to this helper
> > > individually makes fixing device lifetime issues result in easier to
> > > review patches.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >   drivers/counter/counter-core.c | 12 ++++++++++++
> > >   include/linux/counter.h        |  2 ++
> > >   2 files changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
> > > index f053a43c6c04..00c41f28c101 100644
> > > --- a/drivers/counter/counter-core.c
> > > +++ b/drivers/counter/counter-core.c
> > > @@ -45,6 +45,18 @@ static struct bus_type counter_bus_type = {
> > >   static dev_t counter_devt;
> > > +/**
> > > + * counter_priv - access counter device private data
> > > + * @counter: counter device
> > > + *
> > > + * Get the counter device private data
> > > + */
> > > +void *counter_priv(const struct counter_device *const counter)
> > > +{
> > > +	return counter->priv;
> > > +}
> > > +EXPORT_SYMBOL_GPL(counter_priv);
> > Shouldn't this be usin gdev_get_drvdata() and using the private data
> > pointer that is already on the struct device structure itself?  The void
> > *priv; should be dropped from struct counter_device entirely.
> > 
> > Oh ick, I just now looked at 'struct counter_device', there are other
> > reference counting issues in there (hint, struct cdev has a reference
> > count...)  But that's independent of this patch series...
> This is not a problem. The struct cdev holds a reference to the struct dev.
> This allows them to use the same allocation. As long as there is a reference
> to the cdev there will be a reference to the dev and the memory will be kept
> alive.

Ick, a cdev shouldn't be doing stuff like that, but I see how people
like to use it that way :(

Ok, it's fine for now, but yet-another-reaason why the cdev api is a
mess in places...

thanks,

greg k-h
