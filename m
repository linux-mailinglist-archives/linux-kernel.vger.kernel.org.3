Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CDD481DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbhL3PsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhL3PsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:48:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE3DC061574;
        Thu, 30 Dec 2021 07:48:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6E48B81B43;
        Thu, 30 Dec 2021 15:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E594EC36AE9;
        Thu, 30 Dec 2021 15:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640879292;
        bh=JvVoEwdYgeg3rOYT/Axpw64/dBLzVHDVgTeukJnHDis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kFDNpcGQICetMqMHefNsgCVFQ6dQczTgcgwqr+RCXCWmqkJZ7QKs7fSxxsKnx7hX6
         wa3BPGeA1UU3GYuc5sM327c170zmq9oYglXZ0TeA90jYRdpDYc/Ih4UFHmqrFzOoao
         QoZqQdTZ96H5z4VzwMTmaLooLjPIimjsO/UMRzcs=
Date:   Thu, 30 Dec 2021 16:48:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yaqin Pan <akingchen@vivo.com>
Cc:     balbi@kernel.org, devicetree@vger.kernel.org, kernel@vivo.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v3 1/2] usb: dwc3: Add a quirk to set
 GUCTL.SPRSCTRLTRANSEN bit.
Message-ID: <Yc3UuSRkgiopJ5jp@kroah.com>
References: <Yc2+S6u++cXYAnkt@kroah.com>
 <20211230153612.15063-1-akingchen@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230153612.15063-1-akingchen@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 11:36:12PM +0800, Yaqin Pan wrote:
> On Thu, 30 Dec 2021 15:12:27 +0100 Greg Kroah-Hartman wrote:
> >> This quirk is only for dwc3 host mode.
> >> the dwc3 controller can't emurate some devices successfully.
> >> For example, TF card reader (aaaa:8816):
> >> failed log
> >> usb 1-1: new high-speed USB device number 2 using xhci-hcd
> >> usb 1-1: device descriptor read/all, error -110
> >> >From the usb analyzer, always return NAK in the data phase.
> >> if enable the GUCTL.SPRSCTRLTRANSEN bit. then the log is:
> >> usb 2-1: new high-speed USB device number 3 using xhci-hcd
> >> usb 2-1: New USB device found, idVendor=aaaa,
> >> idProduct=8816, bcdDevice=13.08
> >> usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> >> usb 2-1: Product: MXT USB Device
> >> usb 2-1: Manufacturer: MXTronics
> >> usb 2-1: SerialNumber: 150101v01
> >> usb 2-1: New USB device found, VID=aaaa, PID=8816
> >> 
> >> Some devices are slow in responding to Control transfers.
> >> Scheduling mulitiple transactions in one microframe/frame
> >> can cause the devices to misbehave. if this qurik is enabled,
> >> the host controller schedules transations for a Control transfer
> >> in defferent microframes/frame.
> >
> >If this is needed for all devices (i.e. you do not know what device is
> >going to be plugged in), why not just enable it for all controllers?
> >Why whould you NOT want this enabled?
> >
> >Or is this a broken hardware device and only specific host controllers
> >need this?  If so, how do we know which ones need this set and which do
> >not?
> 
> I think not all dwc3 controllers need this. For cell phone,customers may
> use various usb devices, we can enable this quirk to fix some compatibility
> issues. For some chip platform of qcom, i encounter this issue, not every
> platform i encounter this problem.
> 
> If enabled for all controllers, it will reduce the speed of Control transfers. 
> So i think it would be better for user to enable it by their own purposes.

But how do hardware vendors know to enable this?  Can we trigger off of
PCI ids?  Do we need a list of quirks to show which host controllers are
broken this way?

Burying something as basic as "reliable device connection" in a DT quirk
seems very sloppy to me.  We want reliable systems, right?

thanks,

greg k-h
