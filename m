Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69EC46C17D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbhLGRT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:19:56 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43440 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhLGRTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:19:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6B474CE1C4B;
        Tue,  7 Dec 2021 17:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE93EC341C3;
        Tue,  7 Dec 2021 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638897380;
        bh=msCm2s4EM69yiV9jR5VyG96141b9uBc0mx/hEdnJskA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q/F77Mmsls3bReyCvn2u/26L70wkiszfZIJAsC7wBaaRr7Wnv3owVzcr24Q5CFXcF
         ql342dQdxb/2WVNsEJIxM1aOAJQUCfFeExGEqutHCBt3vH6DR/YjZxjC4ZtNUOLVJt
         NWJbdIujJG0cqCIP1/je2taKojOct3RmHWpCCAbU=
Date:   Tue, 7 Dec 2021 18:16:17 +0100
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
Subject: Re: [PATCH 2/2] misc: dice: Add driver to forward secrets to
 userspace
Message-ID: <Ya+W4YpxtB08F1sd@kroah.com>
References: <20211207123617.3040177-1-dbrazdil@google.com>
 <20211207123617.3040177-3-dbrazdil@google.com>
 <Ya9cwZ94QatewwIc@kroah.com>
 <Ya+PYiP43YxfLS4x@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya+PYiP43YxfLS4x@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 04:44:18PM +0000, David Brazdil wrote:
> Hi Greg,
> 
> On Tue, Dec 07, 2021 at 02:08:17PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Dec 07, 2021 at 12:36:17PM +0000, David Brazdil wrote:
> > > Open Profile for DICE is a protocol for deriving unique secrets at boot,
> > > used by some Android devices. The firmware/bootloader hands over secrets
> > > in a reserved memory region, this driver takes ownership of the memory
> > > region and exposes it to userspace via a character device that
> > > lets userspace mmap the memory region into its process.
> > > 
> > > The character device can only be opened once at any given time.
> > 
> > Why?  That should not matter.  And your code (correctly), does not check
> > for that.  So why say that here?
> 
> It does check - open() returns -EBUSY if cmpxchg of the state from READY
> to BUSY fails. I agree this is a bit unconventional but it makes things
> easier to reason about. With multiple open FDs the driver would have to
> wait for all of them to get released before wiping, so one user could
> block the wiping requested by others by holding the FD indefinitely.
> And wiping despite other open FDs seems wrong, too. Is there a better
> way of doing this?

Yes, totally ignore it from the kernel point of view.  You don't know
what userspace just did with that FD the kernel gave it, it could have
sent it across a pipe, run dup() on it, or any sort of other things.
Just rely on open/release to know when the device is opened, and then
when that instance is released.  If userspace wants to do looney things,
and oddities happen, that's userspace's problem, not yours :)


> > > +#include <linux/cdev.h>
> > > +#include <linux/dice.h>
> > > +#include <linux/io.h>
> > > +#include <linux/mm.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_reserved_mem.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +#define DICE_MKDEV		MKDEV(MAJOR(dice_devt), 0)
> > > +#define DICE_MINOR_COUNT	1
> > 
> > Please just use the misc_device api, no need to try to claim a major
> > number for just one device node.  That will simplify your code a lot as
> > well.
> 
> Ok, I'll look into it.
> 
> > > +static int dice_open(struct inode *inode, struct file *filp)
> > > +{
> > > +	struct dice_data *data;
> > > +
> > > +	data = container_of(inode->i_cdev, struct dice_data, cdev);
> > > +
> > > +	/* Never allow write access. */
> > > +	if (filp->f_mode & FMODE_WRITE)
> > > +		return -EROFS;
> > 
> > Why do you care?  Writes just will not work anyway, right?
> 
> There is nothing else preventing writes, the reserved memory is just plain
> old RAM.

And you can rely on this check only?  Nothing else needed with mmap?
And why can't userspace write to this?  What's wrong with that
happening?

thanks,

greg k-h
