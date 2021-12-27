Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD48847FC38
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 12:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbhL0Leb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 06:34:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44484 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhL0Lea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 06:34:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C762B80EB9;
        Mon, 27 Dec 2021 11:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789B7C36AE7;
        Mon, 27 Dec 2021 11:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640604868;
        bh=rO4AaYp2PPlYpnfsXgEaDeglHQ0sUH11MYTFvZLv5X0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFTjksTifO6xVXE0EcE6oTnxhlZRxq9leW+IpQZnkEFfu7d6NbqAv6MzN2a1WNDyf
         BptNSc9jx46heYXuZWqDtnRPuyp5i9U9YKNqRlV8HJiL6D6oM584j8T5Uu/RW3QR+t
         IFYvkJQDBG6d2Ks8QdKmvV8B5OEzuu0CV6+mzS74=
Date:   Mon, 27 Dec 2021 12:34:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH v2 16/23] counter: interrupt-cnt: Convert to new counter
 registration
Message-ID: <YcmkwaeHBy9Jca+2@kroah.com>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-17-u.kleine-koenig@pengutronix.de>
 <YcmcdftX3YO06nD1@kroah.com>
 <7e3a4a67-4e97-8660-9437-0250588d5e5e@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e3a4a67-4e97-8660-9437-0250588d5e5e@metafoo.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 12:21:14PM +0100, Lars-Peter Clausen wrote:
> On 12/27/21 11:59 AM, Greg Kroah-Hartman wrote:
> > On Mon, Dec 27, 2021 at 10:45:19AM +0100, Uwe Kleine-König wrote:
> > > This fixes device lifetime issues where it was possible to free a live
> > > struct device.
> > > 
> > > Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >   drivers/counter/interrupt-cnt.c | 28 ++++++++++++++++------------
> > >   1 file changed, 16 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> > > index 4bf706ef46e2..9e99702470c2 100644
> > > --- a/drivers/counter/interrupt-cnt.c
> > > +++ b/drivers/counter/interrupt-cnt.c
> > > @@ -16,7 +16,6 @@
> > >   struct interrupt_cnt_priv {
> > >   	atomic_t count;
> > > -	struct counter_device counter;
> > >   	struct gpio_desc *gpio;
> > >   	int irq;
> > >   	bool enabled;
> > > @@ -148,12 +147,14 @@ static const struct counter_ops interrupt_cnt_ops = {
> > >   static int interrupt_cnt_probe(struct platform_device *pdev)
> > >   {
> > >   	struct device *dev = &pdev->dev;
> > > +	struct counter_device *counter;
> > >   	struct interrupt_cnt_priv *priv;
> > >   	int ret;
> > > -	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > -	if (!priv)
> > > +	counter = devm_counter_alloc(dev, sizeof(*priv));
> > I just picked one of these patches at random, nothing specific about
> > this driver...
> > 
> > You can not have a 'struct device' in memory allocated by devm_*()
> > functions for the obvious reason that now that memory is being
> > controlled by a reference count that is OUTSIDE of the structure itself.
> > 
> > So while your goal might be good here, this is not the correct solution
> > at all, sorry.
> 
> Before this patch the memory for the struct device was devm_kzalloc'ed.
> Which as you point out is a bug.
> 
> After this patch the memory is reference counted and will be freed when the
> last reference is dropped, in the release callback of the struct device.
> 
> The alloc function is still a devm_ function, but on 'free' it will only
> drop the reference to the struct device that it holds. This is a very common
> pattern that is used by basically any driver subsystem in the kernel.

Then it is not a real devm_() call, let's not call it that please as it
is obviously very confusing :)

Just call it counter_alloc(), or , counter_create(), or something a bit
more in line with the rest of all driver subsystems.

thanks,

greg k-h
