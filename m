Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A73474163
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhLNLVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhLNLVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:21:06 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E16C061574;
        Tue, 14 Dec 2021 03:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=re+A+VgqWP+VuzBjah9LZeI0kzGTDdBNysKZxjJuNuQ=; b=N7lITvbQDgqsVxtZNfGzciFiiM
        b+UX7mxnZh4LF+I5narByKnmJvv+zPLGOffFa1x+SIAA4YPV3Ywkhcc9X+Op4aOMrGMK/uo71r0Rd
        SRNAjhkRywLfYRajb2D798hIyrC+BsJ0Fgx5mX3HB+L8v0Rkn3pvrCRDlAbyAZkduTYw2qJKS7BFu
        vSVpJYGv0jGv6mH22JSLHUwf/OGPDFUwTrMIvyOYg1uMWubsCGMG8y8HmQ9j3gZ2B1tq4gCNqn6XZ
        EJTwPmbiHyAPHfi+wOofHq07AU+cF2u1kkg8jNRTPL+lBCIL9TlbcoAp068AG1dxAHR+mjQkLflge
        idoqGWcw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56270)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mx5re-0004pu-SQ; Tue, 14 Dec 2021 11:20:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mx5ra-0003Sj-4R; Tue, 14 Dec 2021 11:20:54 +0000
Date:   Tue, 14 Dec 2021 11:20:54 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: Unhandled prefetch abort when probing USB flash drive
Message-ID: <Ybh+FhDYN1CSzXi+@shell.armlinux.org.uk>
References: <d23175b8312e4b4093943b38c2ed59d2@svr-chch-ex1.atlnz.lc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d23175b8312e4b4093943b38c2ed59d2@svr-chch-ex1.atlnz.lc>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 05:13:20AM +0000, Joshua Scott wrote:
> Hi,
> 
> I have been running into a kernel panic when probing a USB flash drive, and was after some advice or suggestions on what might be going wrong.
> 
> First up, the details of my setup:
>  * Initially seen on Linux 5.7.19, but I've tested on a vanilla copy of Linux 5.15.0 without any extra modules, and the panic still occurs.
>  * Flash drive (lsusb): Bus 001 Device 002: ID 1005:b113 Apacer Technology, Inc. Handy Steno 2.0/HT203
>  * Our system is based on the Marvell 98DX323x SoC (Arm v7, based on the Armada 370/XP)

Does it work with any kernel? If it doesn't, then I would suspect a
hardware bug, power supply glitch, or a SDRAM timing issue.

Why? These seem somewhat random and spurious. In the example prefetch
abort, it's weird on two accounts:

1) "external abort on non-linefetch" means that we weren't accessing
   cached memory, but the kernel is always in cached memory.
2) prefetch abort means the instruction stream failed to read from
   this location, but we later see in the Code: line that we have been
   able to read the instructions into the data cache.

If the system runs fine without the flash drive attached, I would
suggest it's a power issue. I would suggest trying with an externally
powered USB hub, so the hub sources the power for the flash drive and
see whether that makes a difference.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
