Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D36B48CAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356141AbiALST2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:19:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59388 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242533AbiALST1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:19:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2166612C6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 18:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C362C36AEA;
        Wed, 12 Jan 2022 18:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642011566;
        bh=l47Jm8P0EX3l5sMAft6aWn59YNlIBSwdUxjG781mXYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFvb9uC23j2MIUFHYOAzcrfdBTb1HVHOW99ocEKQtDsa9khfZB1ysuNxsijvXFzlW
         hE/pi+zYkAdQBMrIq0TYpAWWFBp7ycD1a8YbvSbDwtmiaA+yGzAGxpCI5/gebSp2Sr
         pa7APIC1tGa4fQWx1jOFf0oqszAqDWDsyU6W14Q0=
Date:   Wed, 12 Jan 2022 19:19:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Marc Zyngier <maz@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] platform: finally disallow IRQ0 in platform_get_irq()
 and its ilk
Message-ID: <Yd8bq7sZ3WNWruqM@kroah.com>
References: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru>
 <87pmp7volh.wl-maz@kernel.org>
 <9c3f9a6e-89b6-b73b-032f-e4b4ee6f72ac@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c3f9a6e-89b6-b73b-032f-e4b4ee6f72ac@omp.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 08:53:51PM +0300, Sergey Shtylyov wrote:
> On 1/4/22 12:26 PM, Marc Zyngier wrote:
> 
> > [Adding Geert]
> > 
> > On Sat, 06 Nov 2021 20:26:47 +0000,
> > Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> >>
> >> The commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is
> >> invalid") only calls WARN() when IRQ0 is about to be returned, however
> >> using IRQ0 is considered invalid (according to Linus) outside the arch/
> >> code where it's used by the i8253 drivers. Many driver subsystems treat
> >> 0 specially (e.g. as an indication of the polling mode by libata), so
> >> the users of platform_get_irq[_byname]() in them would have to filter
> >> out IRQ0 explicitly and this (quite obviously) doesn't scale...
> >> Let's finally get this straight and return -EINVAL instead of IRQ0!
> >>
> >> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> >> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> >>
> >> ---
> >> The patch is against the 'driver-core-linus' branch of Greg Kroah-Hartman's
> >> 'driver-core.git' repo.
> >>
> >>  drivers/base/platform.c |    6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> Index: driver-core/drivers/base/platform.c
> >> ===================================================================
> >> --- driver-core.orig/drivers/base/platform.c
> >> +++ driver-core/drivers/base/platform.c
> >> @@ -231,7 +231,8 @@ int platform_get_irq_optional(struct pla
> >>  out_not_found:
> >>  	ret = -ENXIO;
> >>  out:
> >> -	WARN(ret == 0, "0 is an invalid IRQ number\n");
> >> +	if (WARN(!ret, "0 is an invalid IRQ number\n"))
> >> +		return -EINVAL;
> >>  	return ret;
> >>  }
> >>  EXPORT_SYMBOL_GPL(platform_get_irq_optional);
> >> @@ -445,7 +446,8 @@ static int __platform_get_irq_byname(str
> >>  
> >>  	r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
> >>  	if (r) {
> >> -		WARN(r->start == 0, "0 is an invalid IRQ number\n");
> >> +		if (WARN(!r->start, "0 is an invalid IRQ number\n"))
> >> +			return -EINVAL;
> >>  		return r->start;
> >>  	}
> > 
> > Geert recently mentioned that a few architectures (such as sh?) still
> > use IRQ0 as something valid in limited cases.
> > 
> > From my PoV, this patch is fine, but please be prepared to fix things
> > in a couple of years when someone decides to boot a recent kernel on
> > their pet dinosaur. With that in mind:
> > 
> > Acked-by: Marc Zyngier <maz@kernel.org>
> 
>    Greg, so would that ACK be enough? Is there a chance this patch gets finally included
> into 5.17-rc1? Or should I look into fixing the recently found arch/sh/ issue 1st (as you
> can see, just WARN()'ing about IRQ0 wasn't enough to get this fixed)?

5.17-rc1 is way too late, sorry.  It would have had to be in my tree
early last week to make it there, my pull requests are already sent to
Linus.

Please fix this up properly, and resend the correct patch series, there
is no rush.

thanks,

greg k-h
