Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225EA46C26C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbhLGSNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhLGSNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:13:14 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3E2C061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 10:09:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v11so31199525wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 10:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fY/jHtU/GYMXorfTVFXQ30fSTwFEiSufcpsSR+/W5Kc=;
        b=oI1q+SaXW973wDODj5VSLnY4R5m0cWsQkAQuYIcPg3DKkAMoojt/knseSDNTDqENsf
         UdDOHM0R3Z9CLyS8C+ASL4XRmDO/R1QBMi/eC0s0uHjZQrpfOCPNmhRSJMv03Sqf6K1Z
         LETtkDTeKz15GCJee+Z7OHnm2xZTwatuZQAVG3+i0flHS+rxIbXFpcth4WNY/59ZQGDU
         Qmva6z88oFYJFGk0sb0kyPiqRrsciI686yrtnWLzSzIJ3MAc9Xoh/ORsWTGfOaipU14c
         OuvEGCSP8BeRsJHVD2IBS+sozdTVDJMu23teEWofNR+oYnfBvw8/jZnkyss6hyNewoNT
         qXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fY/jHtU/GYMXorfTVFXQ30fSTwFEiSufcpsSR+/W5Kc=;
        b=V/zi0agTTA2NAEsUCXI4+y4RSAysXZY4VHxCxCE5zf5xMNzF8hthN5DGxhoy/XOrI0
         2FchSPDVmG58p9HUeWxARXacKr0URTxhWJJN9o/SJaVCe7kVZBZL9agZvMKTDdfQnobq
         85NTXhsgDJG1N2kHH3eiQ6VF+QtTmY+bPMPQ5qlGH87xXC2v61S1zSDYpAnmcbqA7O/Z
         VHc4QJwMr8S2aoLAaXrw3E0T3DSqTIc2ymB89dY65xTbVOHxpaWVYxwj8izlT4E7OhVf
         EXy72l0KgbmuRbFQqSOUiPkYNUqj0tRFlEj4GaoboWpM8HOhRHaa0H3ErSZ329u/3Fru
         W3/A==
X-Gm-Message-State: AOAM5300BjSZ+QCjy3i8jtpiGAJQt//RgQO/WbBN7nopH60d10Ftmsxx
        vD0WyEuSnLvCHyX3dI8EfQ50bw==
X-Google-Smtp-Source: ABdhPJyye2Hjazi9nHZZCKQzQZScll/sBT42r8LwSccet9VbL9oK2W7DyQh0tW2+zvoSZ/urhTWRZg==
X-Received: by 2002:adf:f80f:: with SMTP id s15mr53192966wrp.542.1638900581687;
        Tue, 07 Dec 2021 10:09:41 -0800 (PST)
Received: from google.com ([2a00:79e0:d:209:cb8b:b013:316d:b2f1])
        by smtp.gmail.com with ESMTPSA id t17sm3741660wmq.15.2021.12.07.10.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:09:40 -0800 (PST)
Date:   Tue, 7 Dec 2021 18:09:37 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <Ya+jYcynLTxfdtON@google.com>
References: <20211207123617.3040177-1-dbrazdil@google.com>
 <20211207123617.3040177-3-dbrazdil@google.com>
 <Ya9cwZ94QatewwIc@kroah.com>
 <Ya+PYiP43YxfLS4x@google.com>
 <Ya+W4YpxtB08F1sd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya+W4YpxtB08F1sd@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 06:16:17PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 07, 2021 at 04:44:18PM +0000, David Brazdil wrote:
> > Hi Greg,
> > 
> > On Tue, Dec 07, 2021 at 02:08:17PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Dec 07, 2021 at 12:36:17PM +0000, David Brazdil wrote:
> > > > Open Profile for DICE is a protocol for deriving unique secrets at boot,
> > > > used by some Android devices. The firmware/bootloader hands over secrets
> > > > in a reserved memory region, this driver takes ownership of the memory
> > > > region and exposes it to userspace via a character device that
> > > > lets userspace mmap the memory region into its process.
> > > > 
> > > > The character device can only be opened once at any given time.
> > > 
> > > Why?  That should not matter.  And your code (correctly), does not check
> > > for that.  So why say that here?
> > 
> > It does check - open() returns -EBUSY if cmpxchg of the state from READY
> > to BUSY fails. I agree this is a bit unconventional but it makes things
> > easier to reason about. With multiple open FDs the driver would have to
> > wait for all of them to get released before wiping, so one user could
> > block the wiping requested by others by holding the FD indefinitely.
> > And wiping despite other open FDs seems wrong, too. Is there a better
> > way of doing this?
> 
> Yes, totally ignore it from the kernel point of view.  You don't know
> what userspace just did with that FD the kernel gave it, it could have
> sent it across a pipe, run dup() on it, or any sort of other things.
> Just rely on open/release to know when the device is opened, and then
> when that instance is released.  If userspace wants to do looney things,
> and oddities happen, that's userspace's problem, not yours :)
> 
Fair point.

> > > > +#include <linux/cdev.h>
> > > > +#include <linux/dice.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/mm.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of_reserved_mem.h>
> > > > +#include <linux/platform_device.h>
> > > > +
> > > > +#define DICE_MKDEV		MKDEV(MAJOR(dice_devt), 0)
> > > > +#define DICE_MINOR_COUNT	1
> > > 
> > > Please just use the misc_device api, no need to try to claim a major
> > > number for just one device node.  That will simplify your code a lot as
> > > well.
> > 
> > Ok, I'll look into it.
> > 
> > > > +static int dice_open(struct inode *inode, struct file *filp)
> > > > +{
> > > > +	struct dice_data *data;
> > > > +
> > > > +	data = container_of(inode->i_cdev, struct dice_data, cdev);
> > > > +
> > > > +	/* Never allow write access. */
> > > > +	if (filp->f_mode & FMODE_WRITE)
> > > > +		return -EROFS;
> > > 
> > > Why do you care?  Writes just will not work anyway, right?
> > 
> > There is nothing else preventing writes, the reserved memory is just plain
> > old RAM.
> 
> And you can rely on this check only?  Nothing else needed with mmap?
> And why can't userspace write to this?  What's wrong with that
> happening?

AFAICT vm_iomap_memory takes care of it. It will allow a MAP_PRIVATE
mapping of a read-only FD but not a MAP_SHARED one. I think that gives
nice guarantees to userspace that if a process opens the char device itself,
it's getting the original data, not something another process wrote there.

-David
