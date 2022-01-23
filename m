Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D04B49717C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 13:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbiAWMdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 07:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiAWMdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 07:33:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D2DC06173B;
        Sun, 23 Jan 2022 04:33:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B99D60BAC;
        Sun, 23 Jan 2022 12:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3A4C340E2;
        Sun, 23 Jan 2022 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642941195;
        bh=CtWcco0BMqT7FNN3g0VMv1nc9Id3y/Xf4ZM5JVL28g4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cSyS6xxNfW6CcqKY0pTjpFPj3BT//A9qKbw3w0ieXHNpXm3VdwhFR4y2v8cXNlHo2
         HcOqRmR8Lk4iciXNCGoeJTyQ8qDCrgrE3u8HuZopjkZfQ8Mrkq+48mJ93xg57wFbLk
         MBX8dgCFLYcQlKVIXB3kthlnWuh1qoD+bge4qPxs=
Date:   Sun, 23 Jan 2022 13:33:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: kernel crash/disc errors when unbinding USB devices
Message-ID: <Ye1LCATpTIRr/yZt@kroah.com>
References: <7865ae26-2df0-892b-eb65-ce341eb9daea@gmx.de>
 <Ye03Cz7fHFJ3bPmO@kroah.com>
 <2ce0e792-ac09-a973-6751-6ed187b6fae6@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ce0e792-ac09-a973-6751-6ed187b6fae6@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 12:59:21PM +0100, Helge Deller wrote:
> On 1/23/22 12:07, Greg Kroah-Hartman wrote:
> > On Sun, Jan 23, 2022 at 11:40:01AM +0100, Helge Deller wrote:
> >> On all kernels 5.15.x and 5.16.x I noticed that resetting
> >> the USB devices with this shell script:
> >>
> >>        for i in $(ls /sys/bus/pci/drivers/ahci/|grep :)
> >>          do
> >>          echo $i
> >>          echo $i >/sys/bus/pci/drivers/ahci/unbind
> >>          sleep 1
> >>          echo $i >/sys/bus/pci/drivers/ahci/bind
> >>         done
> >
> > That is dangerous to do, why do this?  All of your block devices might
> > have disappeard.
> >
> >>         # reseting USB3 ports (if there none you'll get errors)
> >>         for i in $(ls /sys/bus/pci/drivers/xhci_hcd/|grep :)
> >>          do
> >>          echo $i
> >>          echo $i >/sys/bus/pci/drivers/xhci_hcd/unbind
> >>          sleep 1
> >>          echo $i >/sys/bus/pci/drivers/xhci_hcd/bind
> >>         done
> >
> > Again, why do this at all?
> 
> I need to reset some of the USB devices after a suspend/resume cycle.

The devices, or the host controllers?  They are different things.

> The problem is, that some of the USB devices are
> handed over into a running VirtualBox VM and after
> the suspend/resume they need to be virtually plugged out/in
> so that the running Windows VM will reconnect them.

unbind/bind is a very harsh way of doing this.  but do it on the USB
devics, not the host controllers.

> If you search in the internet, you will find many places
> where this unbind/bind process is mentioned, e.g.:
> https://askubuntu.com/questions/645/how-do-you-reset-a-usb-device-from-the-command-line
> This procedure did worked in the past.

Never trust the internet :)

But note, there is a usbreset program mentioned there, which is part of
'usbutils' and should already be installed on your machine.  Why not
just use that?

> I think the main problem is, that it's somehow unexpected that
> the SATA controllers are logically attached to the USB
> controllers.

Huh?  No they are not.

'ahci' is a SATA controller.
'xhci' is a USB controller.

Two totally different things.

> So, if you believe to unbind "just" the USB devices you
> suddenly unbind SATA controllers too.

Again, no, you are unbinding two different things here.  And a USB host
controller is different than individual USB devices as well.

> >> immediately leads to a non-functional system, because the discs
> >> face I/O errors and will switch to read-only mode.
> >
> > Sure, the disks are gone, this is expected.
> 
> Ok.
> 
> >> Effectively I have to reboot the machine.
> >
> > I'm amazed it keeps working at all.
> 
> :-)
> 
> >> It's reproduceable for me on two completely different x86 machines with
> >> different USB devices.
> >
> > What do you expect this to do instead?  You just disabled all block
> > controllers in your system, followed by all USB controllers.  And then
> > attempted to add them back, but given that the old devices still had
> > userspace references on them, the devices will come back with different
> > names and so you need to mount them again.
> >
> > So this looks like it is working as intended.  Just don't do this :)
> 
> Ok, sure, but I think it's unexpected that the SATA ports are listed
> beneath the USB controllers, beside USB devices.

Where are they listed like that?

> If I run "lsusb", the SATA controllers don't show up either.

That is because they are independant and have nothing to do with each
otner.

> They are listed when I run "lspci".
> Shouldn't they maybe show up somewhere else, e.g.
> /sys/bus/pci/drivers/sata/*

The controllers are PCI drivers.  The block devices they create are
scsi devices (through the ata system).  This has nothing to do with USB.

confused,

greg k-h
