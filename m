Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85004843F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiADO5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:57:13 -0500
Received: from mail-m17657.qiye.163.com ([59.111.176.57]:59660 "EHLO
        mail-m17657.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiADO5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:57:06 -0500
DKIM-Signature: a=rsa-sha256;
        b=WahZq+y3AikCNe/exLHi/0ybc0w3qC5cqUDbQKJ34IH0g4scsH/3VrVnU07S2VhQa5+pNwYb2J5Gebs179v7ge2CR2Sc0Jdt9B7eDoBFJCnVTuT2psbPnXxg05QUPBrngMU2ZmiB2xWCzeofEd6/RzRNyo344tHLszhpXnEFCzI=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=XTw2N7E7lKxzJ8b3zO8P0M0zLQGt1OIHCzEObglDE0c=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-600-G6.vivo.xyz (unknown [109.244.72.201])
        by mail-m17657.qiye.163.com (Hmail) with ESMTPA id 824E3280162;
        Tue,  4 Jan 2022 22:57:01 +0800 (CST)
From:   Yaqin Pan <akingchen@vivo.com>
To:     gregkh@linuxfoundation.org
Cc:     akingchen@vivo.com, balbi@kernel.org, devicetree@vger.kernel.org,
        kernel@vivo.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 1/2] usb: dwc3: Add a quirk to set GUCTL.SPRSCTRLTRANSEN bit.
Date:   Tue,  4 Jan 2022 22:56:55 +0800
Message-Id: <20220104145655.4802-1-akingchen@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YdL7iDbNk0cct1Bs@kroah.com>
References: <YdL7iDbNk0cct1Bs@kroah.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRofSx1WHUpLQ0pKS0NOSh
        lLVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kww6DQw6LT5WFws*Hx4rTwkr
        Ni0wFBxVSlVKTU9KSEtDSUlJS0lNVTMWGhIXVRoQEhUcGBMeFTsNEg0UVRgUFkVZV1kSC1lBWUpL
        QlVJT09VTElVSUtKWVdZCAFZQU9PS0o3Bg++
X-HM-Tid: 0a7e2597f14cda03kuws824e3280162
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-03 13:35 UTC Greg Kroah-Hartman wrote:
>On Fri, Dec 31, 2021 at 07:59:31PM +0800, Yaqin Pan wrote:
>> On Thu, 30 Dec 2021 16:48:09 +0100 Greg Kroah-Hartman wrote:
>> >On Thu, Dec 30, 2021 at 11:36:12PM +0800, Yaqin Pan wrote:
>> >> On Thu, 30 Dec 2021 15:12:27 +0100 Greg Kroah-Hartman wrote:
>> >> >> This quirk is only for dwc3 host mode.
>> >> >> the dwc3 controller can't emurate some devices successfully.
>> >> >> For example, TF card reader (aaaa:8816):
>> >> >> failed log
>> >> >> usb 1-1: new high-speed USB device number 2 using xhci-hcd
>> >> >> usb 1-1: device descriptor read/all, error -110
>> >> >> >From the usb analyzer, always return NAK in the data phase.
>> >> >> if enable the GUCTL.SPRSCTRLTRANSEN bit. then the log is:
>> >> >> usb 2-1: new high-speed USB device number 3 using xhci-hcd
>> >> >> usb 2-1: New USB device found, idVendor=aaaa,
>> >> >> idProduct=8816, bcdDevice=13.08
>> >> >> usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>> >> >> usb 2-1: Product: MXT USB Device
>> >> >> usb 2-1: Manufacturer: MXTronics
>> >> >> usb 2-1: SerialNumber: 150101v01
>> >> >> usb 2-1: New USB device found, VID=aaaa, PID=8816
>> >> >> 
>> >> >> Some devices are slow in responding to Control transfers.
>> >> >> Scheduling mulitiple transactions in one microframe/frame
>> >> >> can cause the devices to misbehave. if this qurik is enabled,
>> >> >> the host controller schedules transations for a Control transfer
>> >> >> in defferent microframes/frame.
>> >> >
>> >> >If this is needed for all devices (i.e. you do not know what device is
>> >> >going to be plugged in), why not just enable it for all controllers?
>> >> >Why whould you NOT want this enabled?
>> >> >
>> >> >Or is this a broken hardware device and only specific host controllers
>> >> >need this?  If so, how do we know which ones need this set and which do
>> >> >not?
>> >> 
>> >> I think not all dwc3 controllers need this. For cell phone,customers may
>> >> use various usb devices, we can enable this quirk to fix some compatibility
>> >> issues. For some chip platform of qcom, i encounter this issue, not every
>> >> platform i encounter this problem.
>> >> 
>> >> If enabled for all controllers, it will reduce the speed of Control transfers. 
>> >> So i think it would be better for user to enable it by their own purposes.
>> >
>> >But how do hardware vendors know to enable this?  Can we trigger off of
>> >PCI ids?  Do we need a list of quirks to show which host controllers are
>> >broken this way?
>> >
>> >Burying something as basic as "reliable device connection" in a DT quirk
>> >seems very sloppy to me.  We want reliable systems, right?
>> 
>> Yes, we want reliable systems. But i don't have a good ideal about this issue.
>> when we meet this problem, and from the dwc-usb3 controller datasheet,we know
>> enable one bit in dwc-usb3 controller's register can fixed this issue.
>> 
>> Of course, i can list the host controllers that i used broken this way if needed.
>
>Please have a list of controller that this is needed for, and add the
>quirk for them only.  Don't require this to be in a DT file as that will
>never be noticed.

The dwc3-core i list below:
qcom,sm8350-dwc3;
qcom,sm7325-dwc3;
qcom,sm6225-dwc3;
....
And i will try to contact with qcom for further help.

thanks,

Yaqin pan

