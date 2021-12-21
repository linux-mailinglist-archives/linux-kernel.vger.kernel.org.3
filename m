Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C2D47C228
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbhLUPCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbhLUPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:02:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9131CC061574;
        Tue, 21 Dec 2021 07:02:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DFF461639;
        Tue, 21 Dec 2021 15:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B5BC36AEB;
        Tue, 21 Dec 2021 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640098965;
        bh=PNKSsW6U222Ve/AYah5qTkiRKKA3jh4SZumvMFaxkuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XsXRLJB0NYW7K779m/cF/pjwQbm9wE8X+JvXfR29QrNqsTiC53T0A1MQLHsRc1Pb1
         NrVX+JIq9r/yJU1mhIIzYXhBXzG6wPSXqbWXe8fNdfpl14DZzY7qUns8qSjmmCSgz7
         cOsKUJLc+dg57ue61fJ40bbcYTS0bQymV2qqIX+M=
Date:   Tue, 21 Dec 2021 15:27:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/2] nvmem: expose NVMEM cells in sysfs
Message-ID: <YcHkS0iDUhplbqUc@kroah.com>
References: <YcF1Kizcvgqa9ZT4@kroah.com>
 <d68ba301-7877-a8d8-8700-c601a4996818@gmail.com>
 <YcF4E82M89huIbSD@kroah.com>
 <3cb1d0a4-6e20-f751-6d66-c1487ef31f30@gmail.com>
 <YcF+g0ra5tttXOQF@kroah.com>
 <0527135c-35f5-bc63-edb3-81cb03eb03f6@gmail.com>
 <YcHPGQ0FH0kTzpbq@kroah.com>
 <ab52292c-3065-789b-d5ae-ef24bab5fc90@gmail.com>
 <YcHWVMa6vjz3Gp51@kroah.com>
 <d626c2c2-5071-522f-330f-688254087d74@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d626c2c2-5071-522f-330f-688254087d74@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 02:52:05PM +0100, Rafał Miłecki wrote:
> > How are nvmem devices named?
> 
> $ ls /sys/bus/nvmem/devices/
> brcm-nvram0
> mtd0
> mtd1
> u-boot-envvar0

So no naming scheme at all.

{sigh}

> > > Example:
> > > $ cat /sys/bus/nvmem/devices/foo/cells/bootcmd
> > > tftp
> > > $ cat /sys/bus/nvmem/devices/foo/cells/bootdelay
> > > 5
> > > 
> > > As you can see above NVMEM cells are not known at compilation time.
> > 
> > Why do you want to expose these in a way that forces the kernel to parse
> > these key/value pairs?  Why not just do it all in userspace like you can
> > today?  What forces the kernel to do it and not a perl script?
> > 
> > > So I believe the question is: how can I expose cells in sysfs?
> > 
> > You can do this by dynamically creating the attributes on the fly, but
> > your show function is going to be rough and it's not going to be simple
> > to do so.  One example will be the code that creates the
> > /sys/devices/system/machinecheck/machinecheckXX/bank* files.
> > 
> > But I will push back again, why not just do it all in userspace?  What
> > userspace tool is requiring the kernel to do this work for it?
> 
> Environment data contains info that may be required by kernel.
> 
> For example some home routers store two firmwares on flash. Kernel needs
> to read index of currently booted firmware to make sure MTD subsystem
> creates partitions correctly.

You are talking about a kernel<->kernel api here, that's not what sysfs
is for at all.

> Another example: MAC address. Ethernet subsystem supports reading MAC
> from NVMEM cell.

Again, internal kernel api, nothing sysfs is ever involved in.

> One could argue those tasks could be handled from userspace but that
> would get tricky. Sure - we have API for setting MAC address. However
> other cases (like setting active firmware partition and asking MTD to
> parse it into subpartitions) would require new user <-> kernel
> interfaces.

Ok, but again, sysfs is for userspace to get access to these values.
That's what I'm concerned about.  If you want to make an in-kernel api
for other subsystems to get these key/value pairs, wonderful, that has
nothing to do with sysfs.

So I ask again, why do you want to expose these to userspace through
sysfs in a new format from what you have today.  Who is going to use
that information and what is it going to be used for.

thanks,

greg k-h
