Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCFC483172
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 14:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiACNfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 08:35:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33688 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiACNfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 08:35:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 796436104B;
        Mon,  3 Jan 2022 13:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D2EC36AED;
        Mon,  3 Jan 2022 13:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641216907;
        bh=jFbww1NpkfvF5p1XfPt3zfR/YkekAF7W2Tm4G835O4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RrUNsbWOMvMY4xUSYjLPOr10hdRxw4E6URCeY7lFspPpcJ0/wdcZIrwtFEe/eUaXM
         ItgKGnDrDXSiTQrBHnR96QQ6s8q//vTQKBKN3BQe00AaPws/NIZ0LYnLyfaMO7BREK
         Z3QULJodnDdazkqb7LfgBWRHhbPQACcw4xgSzDok=
Date:   Mon, 3 Jan 2022 14:35:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yaqin Pan <akingchen@vivo.com>
Cc:     balbi@kernel.org, devicetree@vger.kernel.org, kernel@vivo.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v3 1/2] usb: dwc3: Add a quirk to set
 GUCTL.SPRSCTRLTRANSEN bit.
Message-ID: <YdL7iDbNk0cct1Bs@kroah.com>
References: <Yc3UuSRkgiopJ5jp@kroah.com>
 <20211231115931.20628-1-akingchen@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231115931.20628-1-akingchen@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 07:59:31PM +0800, Yaqin Pan wrote:
> On Thu, 30 Dec 2021 16:48:09 +0100 Greg Kroah-Hartman wrote:
> >On Thu, Dec 30, 2021 at 11:36:12PM +0800, Yaqin Pan wrote:
> >> On Thu, 30 Dec 2021 15:12:27 +0100 Greg Kroah-Hartman wrote:
> >> >> This quirk is only for dwc3 host mode.
> >> >> the dwc3 controller can't emurate some devices successfully.
> >> >> For example, TF card reader (aaaa:8816):
> >> >> failed log
> >> >> usb 1-1: new high-speed USB device number 2 using xhci-hcd
> >> >> usb 1-1: device descriptor read/all, error -110
> >> >> >From the usb analyzer, always return NAK in the data phase.
> >> >> if enable the GUCTL.SPRSCTRLTRANSEN bit. then the log is:
> >> >> usb 2-1: new high-speed USB device number 3 using xhci-hcd
> >> >> usb 2-1: New USB device found, idVendor=aaaa,
> >> >> idProduct=8816, bcdDevice=13.08
> >> >> usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> >> >> usb 2-1: Product: MXT USB Device
> >> >> usb 2-1: Manufacturer: MXTronics
> >> >> usb 2-1: SerialNumber: 150101v01
> >> >> usb 2-1: New USB device found, VID=aaaa, PID=8816
> >> >> 
> >> >> Some devices are slow in responding to Control transfers.
> >> >> Scheduling mulitiple transactions in one microframe/frame
> >> >> can cause the devices to misbehave. if this qurik is enabled,
> >> >> the host controller schedules transations for a Control transfer
> >> >> in defferent microframes/frame.
> >> >
> >> >If this is needed for all devices (i.e. you do not know what device is
> >> >going to be plugged in), why not just enable it for all controllers?
> >> >Why whould you NOT want this enabled?
> >> >
> >> >Or is this a broken hardware device and only specific host controllers
> >> >need this?  If so, how do we know which ones need this set and which do
> >> >not?
> >> 
> >> I think not all dwc3 controllers need this. For cell phone,customers may
> >> use various usb devices, we can enable this quirk to fix some compatibility
> >> issues. For some chip platform of qcom, i encounter this issue, not every
> >> platform i encounter this problem.
> >> 
> >> If enabled for all controllers, it will reduce the speed of Control transfers. 
> >> So i think it would be better for user to enable it by their own purposes.
> >
> >But how do hardware vendors know to enable this?  Can we trigger off of
> >PCI ids?  Do we need a list of quirks to show which host controllers are
> >broken this way?
> >
> >Burying something as basic as "reliable device connection" in a DT quirk
> >seems very sloppy to me.  We want reliable systems, right?
> 
> Yes, we want reliable systems. But i don't have a good ideal about this issue.
> when we meet this problem, and from the dwc-usb3 controller datasheet,we know
> enable one bit in dwc-usb3 controller's register can fixed this issue.
> 
> Of course, i can list the host controllers that i used broken this way if needed.

Please have a list of controller that this is needed for, and add the
quirk for them only.  Don't require this to be in a DT file as that will
never be noticed.

thanks,

greg k-h
