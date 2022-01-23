Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C6549710D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbiAWLIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:08:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37876 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbiAWLIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:08:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4B9860BA7;
        Sun, 23 Jan 2022 11:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA01FC340E2;
        Sun, 23 Jan 2022 11:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642936079;
        bh=Ziajwqy7kzLRP1YgkI4QjrtuZSGrHBYFiprova5on80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzG5N2hqCbOO5r1AwIPjZcjKOdaxly3FjZdBn+k9iPqwWDi2BMEfE4/D6INssGTFi
         cryhitdcEfvQChGr7vvSmZl7ujUajTRrcbOCCcb5dQywTZHmrEi04mDPp0Oi6C6CYk
         lnXoa7HhtYh1CSDEZWIhMB4m/YLXRvZ3g+R5N/lQ=
Date:   Sun, 23 Jan 2022 12:07:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: kernel crash/disc errors when unbinding USB devices
Message-ID: <Ye03Cz7fHFJ3bPmO@kroah.com>
References: <7865ae26-2df0-892b-eb65-ce341eb9daea@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7865ae26-2df0-892b-eb65-ce341eb9daea@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 11:40:01AM +0100, Helge Deller wrote:
> On all kernels 5.15.x and 5.16.x I noticed that resetting
> the USB devices with this shell script:
> 
>        for i in $(ls /sys/bus/pci/drivers/ahci/|grep :)
>          do
>          echo $i
>          echo $i >/sys/bus/pci/drivers/ahci/unbind
>          sleep 1
>          echo $i >/sys/bus/pci/drivers/ahci/bind
>         done

That is dangerous to do, why do this?  All of your block devices might
have disappeard.

>         # reseting USB3 ports (if there none you'll get errors)
>         for i in $(ls /sys/bus/pci/drivers/xhci_hcd/|grep :)
>          do
>          echo $i
>          echo $i >/sys/bus/pci/drivers/xhci_hcd/unbind
>          sleep 1
>          echo $i >/sys/bus/pci/drivers/xhci_hcd/bind
>         done

Again, why do this at all?

> immediately leads to a non-functional system, because the discs
> face I/O errors and will switch to read-only mode.

Sure, the disks are gone, this is expected.

> Effectively I have to reboot the machine.

I'm amazed it keeps working at all.

> It's reproduceable for me on two completely different x86 machines with
> different USB devices.

What do you expect this to do instead?  You just disabled all block
controllers in your system, followed by all USB controllers.  And then
attempted to add them back, but given that the old devices still had
userspace references on them, the devices will come back with different
names and so you need to mount them again.

So this looks like it is working as intended.  Just don't do this :)

greg k-h
