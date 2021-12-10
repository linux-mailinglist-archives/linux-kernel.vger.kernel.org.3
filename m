Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DD14702FF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242292AbhLJOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:43:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51708 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbhLJOnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:43:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4884B82801;
        Fri, 10 Dec 2021 14:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F54C00446;
        Fri, 10 Dec 2021 14:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639147187;
        bh=NjGZs6PWE81gbPC3h5fTas+11hRzKnJiUy44GMGQxiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MpVXuKt6gi0J/aPTHT+aoDvTN1Cz71WbBd9624eObniO3xYHPOZKngEWKp7epDTmm
         fbijoTNTkr1hEAimnRQVWMM1gK9ZvMW/zYq8T6AIIViy1c9KysDIpCCkV9B0nZXDuF
         +wKaugxZ/91TTNj02TpJ6kKtuZKfrjFhcTtzVLK0=
Date:   Fri, 10 Dec 2021 15:39:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/2] misc: dice: Add driver to forward secrets to
 userspace
Message-ID: <YbNmsFAYDVUYopFO@kroah.com>
References: <20211209151123.3759999-1-dbrazdil@google.com>
 <20211209151123.3759999-3-dbrazdil@google.com>
 <YbIhaWC8b2DV5C7Y@kroah.com>
 <YbM29thQ7U4oUmhi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbM29thQ7U4oUmhi@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 11:16:06AM +0000, David Brazdil wrote:
> On Thu, Dec 09, 2021 at 04:31:53PM +0100, Greg Kroah-Hartman wrote:
> > What is the module name, please add that here.
> > 
> > And "dice" is a very generic name.  I don't mind, but if you want to
> > name it a bit more specific, that might be better.
> Does "open-dice" sound good? I think that's the shorthand used on the
> official website.

That might be better.

Naming is hard.

> > > +static long dice_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> > > +{
> > > +	switch (cmd) {
> > > +	case DICE_GET_SIZE:
> > > +		/* Checked against INT_MAX in dice_probe(). */
> > > +		return dice_rmem->size;
> > > +	case DICE_WIPE:
> > > +		return dice_wipe();
> > > +	}
> > > +
> > > +	return -ENOIOCTLCMD;
> > 
> > -ENOTTY please.
> I have no personal attachment to ENOIOCTLCMD, but it is documented as
> "no ioctl command" and converted to ENOTTY before returning to userspace.
> That made me think this was the right thing to do.

ENOTTY is better please.

> > As you only have 2 ioctls, why not just use read/write for this?  Write
> > would cause dice_wipe() to happen, and read would return the size in the
> > buffer provided.  Then no ioctl is needed at all.
> Fine by me but does feel like a bit of a hack. Is that a common pattern?

ioctls are hacks too :)

read/write like this is fine to do, might make the code simpler, and
allow the code to be used by scripts easier.  At the very least, wipe
can be done by any language instead of only those that allow ioctls.

thanks,

greg k-h
