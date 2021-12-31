Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A494823E0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 12:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhLaL7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 06:59:41 -0500
Received: from mail-m17657.qiye.163.com ([59.111.176.57]:46808 "EHLO
        mail-m17657.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhLaL7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 06:59:40 -0500
DKIM-Signature: a=rsa-sha256;
        b=Lna4XiTM7iHww4ApUraRr9mvVuU24WLQIvz1YVAKLe16UrF5agqs70g6orxJUot4Uh6c1VGFHm2PfH+UuSRZmNQR1zJ8WKlq31sZ0+O7MNyxdyVgnnkVeJhuzFlpamHUozNXt7QVaJg8ERNKeHctJNA7Sjg6YV5TSeu/N3HCEPk=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=9MIgr6Arv1aOpfBUNJL+JGVVAKUrRBu+eNkhXJWH6XU=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-600-G6.vivo.xyz (unknown [109.244.72.201])
        by mail-m17657.qiye.163.com (Hmail) with ESMTPA id 3DC7B28013F;
        Fri, 31 Dec 2021 19:59:38 +0800 (CST)
From:   Yaqin Pan <akingchen@vivo.com>
To:     gregkh@linuxfoundation.org
Cc:     akingchen@vivo.com, balbi@kernel.org, devicetree@vger.kernel.org,
        kernel@vivo.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 1/2] usb: dwc3: Add a quirk to set GUCTL.SPRSCTRLTRANSEN bit.
Date:   Fri, 31 Dec 2021 19:59:31 +0800
Message-Id: <20211231115931.20628-1-akingchen@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <Yc3UuSRkgiopJ5jp@kroah.com>
References: <Yc3UuSRkgiopJ5jp@kroah.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUIdGR9WT0sYSU5LSUtNTB
        4ZVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PC46HDo6PD5RSBcLFlZCExU3
        OC9PCy5VSlVKTU9LQk5KQkxDTE9KVTMWGhIXVRoQEhUcGBMeFTsNEg0UVRgUFkVZV1kSC1lBWUpL
        QlVJT09VTElVSUtKWVdZCAFZQUhDS043Bg++
X-HM-Tid: 0a7e105c19efda03kuws3dc7b28013f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021 16:48:09 +0100 Greg Kroah-Hartman wrote:
>On Thu, Dec 30, 2021 at 11:36:12PM +0800, Yaqin Pan wrote:
>> On Thu, 30 Dec 2021 15:12:27 +0100 Greg Kroah-Hartman wrote:
>> >> This quirk is only for dwc3 host mode.
>> >> the dwc3 controller can't emurate some devices successfully.
>> >> For example, TF card reader (aaaa:8816):
>> >> failed log
>> >> usb 1-1: new high-speed USB device number 2 using xhci-hcd
>> >> usb 1-1: device descriptor read/all, error -110
>> >> >From the usb analyzer, always return NAK in the data phase.
>> >> if enable the GUCTL.SPRSCTRLTRANSEN bit. then the log is:
>> >> usb 2-1: new high-speed USB device number 3 using xhci-hcd
>> >> usb 2-1: New USB device found, idVendor=aaaa,
>> >> idProduct=8816, bcdDevice=13.08
>> >> usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>> >> usb 2-1: Product: MXT USB Device
>> >> usb 2-1: Manufacturer: MXTronics
>> >> usb 2-1: SerialNumber: 150101v01
>> >> usb 2-1: New USB device found, VID=aaaa, PID=8816
>> >> 
>> >> Some devices are slow in responding to Control transfers.
>> >> Scheduling mulitiple transactions in one microframe/frame
>> >> can cause the devices to misbehave. if this qurik is enabled,
>> >> the host controller schedules transations for a Control transfer
>> >> in defferent microframes/frame.
>> >
>> >If this is needed for all devices (i.e. you do not know what device is
>> >going to be plugged in), why not just enable it for all controllers?
>> >Why whould you NOT want this enabled?
>> >
>> >Or is this a broken hardware device and only specific host controllers
>> >need this?  If so, how do we know which ones need this set and which do
>> >not?
>> 
>> I think not all dwc3 controllers need this. For cell phone,customers may
>> use various usb devices, we can enable this quirk to fix some compatibility
>> issues. For some chip platform of qcom, i encounter this issue, not every
>> platform i encounter this problem.
>> 
>> If enabled for all controllers, it will reduce the speed of Control transfers. 
>> So i think it would be better for user to enable it by their own purposes.
>
>But how do hardware vendors know to enable this?  Can we trigger off of
>PCI ids?  Do we need a list of quirks to show which host controllers are
>broken this way?
>
>Burying something as basic as "reliable device connection" in a DT quirk
>seems very sloppy to me.  We want reliable systems, right?

Yes, we want reliable systems. But i don't have a good ideal about this issue.
when we meet this problem, and from the dwc-usb3 controller datasheet,we know
enable one bit in dwc-usb3 controller's register can fixed this issue.

Of course, i can list the host controllers that i used broken this way if needed.

thanks,

Yaqin pan

