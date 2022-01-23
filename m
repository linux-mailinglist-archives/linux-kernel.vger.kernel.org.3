Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9739B49719B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 14:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiAWNL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 08:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbiAWNL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 08:11:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7D0C06173B;
        Sun, 23 Jan 2022 05:11:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81F4F60C39;
        Sun, 23 Jan 2022 13:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7CAC340E2;
        Sun, 23 Jan 2022 13:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642943516;
        bh=hbUfVMU2bZlrW0CzEvUsgkEjWKgaY+dlpXOgLu/TPoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k5CIsUBUzLgYba2+YuGB3NAF9aO5RU2vxVWRZs5Us8EvQBAahFSdfSBggc9yjYCZp
         kYT8Y+LLkMZuI1d1rbfTkL/h3hXRiT4wmNN2Fd8pkFgQLTrX/ViL/O6UqN7GCnYX3y
         H289ERDbUtT1lkSuFM8zkeJdD5bGsz6qWmsEYqo4=
Date:   Sun, 23 Jan 2022 14:11:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: kernel crash/disc errors when unbinding USB devices
Message-ID: <Ye1UGnov84vpLDfK@kroah.com>
References: <7865ae26-2df0-892b-eb65-ce341eb9daea@gmx.de>
 <Ye03Cz7fHFJ3bPmO@kroah.com>
 <2ce0e792-ac09-a973-6751-6ed187b6fae6@gmx.de>
 <Ye1LCATpTIRr/yZt@kroah.com>
 <1a5d9e02-856c-8e2d-4eae-cb5a1b5c4652@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a5d9e02-856c-8e2d-4eae-cb5a1b5c4652@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 02:07:24PM +0100, Helge Deller wrote:
> On 1/23/22 13:33, Greg Kroah-Hartman wrote:
> > On Sun, Jan 23, 2022 at 12:59:21PM +0100, Helge Deller wrote:
> >> On 1/23/22 12:07, Greg Kroah-Hartman wrote:
> >>> On Sun, Jan 23, 2022 at 11:40:01AM +0100, Helge Deller wrote:
> >>>> On all kernels 5.15.x and 5.16.x I noticed that resetting
> >>>> the USB devices with this shell script:
> >>>>
> >>>>        for i in $(ls /sys/bus/pci/drivers/ahci/|grep :)
> >>>>          do
> >>>>          echo $i
> >>>>          echo $i >/sys/bus/pci/drivers/ahci/unbind
> >>>>          sleep 1
> >>>>          echo $i >/sys/bus/pci/drivers/ahci/bind
> >>>>         done
> >>>
> >>> That is dangerous to do, why do this?  All of your block devices might
> >>> have disappeard.
> >>>
> >>>>         # reseting USB3 ports (if there none you'll get errors)
> >>>>         for i in $(ls /sys/bus/pci/drivers/xhci_hcd/|grep :)
> >>>>          do
> >>>>          echo $i
> >>>>          echo $i >/sys/bus/pci/drivers/xhci_hcd/unbind
> >>>>          sleep 1
> >>>>          echo $i >/sys/bus/pci/drivers/xhci_hcd/bind
> >>>>         done
> >>>
> >>> Again, why do this at all?
> >>
> >> I need to reset some of the USB devices after a suspend/resume cycle.
> >
> > The devices, or the host controllers?  They are different things.
> >
> >> The problem is, that some of the USB devices are
> >> handed over into a running VirtualBox VM and after
> >> the suspend/resume they need to be virtually plugged out/in
> >> so that the running Windows VM will reconnect them.
> >
> > unbind/bind is a very harsh way of doing this.  but do it on the USB
> > devics, not the host controllers.
> >
> >> If you search in the internet, you will find many places
> >> where this unbind/bind process is mentioned, e.g.:
> >> https://askubuntu.com/questions/645/how-do-you-reset-a-usb-device-from-the-command-line
> >> This procedure did worked in the past.
> >
> > Never trust the internet :)
> >
> > But note, there is a usbreset program mentioned there, which is part of
> > 'usbutils' and should already be installed on your machine.  Why not
> > just use that?
> >
> >> I think the main problem is, that it's somehow unexpected that
> >> the SATA controllers are logically attached to the USB
> >> controllers.
> >
> > Huh?  No they are not.
> >
> > 'ahci' is a SATA controller.
> > 'xhci' is a USB controller.
> >
> > Two totally different things.
> 
> Right, and that was my fault.
> I mixed up "ahci" and "ehci" (the USB2.0 controller).

No worries, but please, do not just disable the USB host controllers
like this as well, as that will tear down, and then build back up the
whole USB device trees.  Any device that has anything open/running with
it will get confused.

good luck!

greg k-h
