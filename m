Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33258479AF1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 14:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhLRNFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 08:05:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51482 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhLRNFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 08:05:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 588AAB8085B;
        Sat, 18 Dec 2021 13:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05359C36AE5;
        Sat, 18 Dec 2021 13:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639832737;
        bh=ZvlbLyB0vqd99ZIXWXan6MxAYM94nUiQOUxbVrzHNA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bLfX2LEaIe2kmeZx//nS/ko+b/xMxg1yk+XHVKZyaaDGzCxv6Grxsulet3vtiIEuc
         hwp4z/eflSfduNKGFkNqM8RQb9crbHF18fztITqaFUHK8U1rpdmTQc5sCFYTvKjlqD
         nowE9WLa67IySiH5VqcXPV/w9bPU/3lUdu5iWSjk=
Date:   Sat, 18 Dec 2021 14:05:29 +0100
From:   gregkh <gregkh@linuxfoundation.org>
To:     Tony Huang =?utf-8?B?6buD5oe35Y6a?= <tony.huang@sunplus.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: Re: [PATCH v3 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <Yb3cmUmXRhc16iEl@kroah.com>
References: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
 <bc15d5e8d7a5ec96582799fe513de4ace6fd4b8b.1639039163.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a2UGr6ZbHk6G=wh5XG_EGdJxGf6SfyN1sTb4aaUgiK8Lw@mail.gmail.com>
 <5c01390c485a44b6913dcb42e3677ed1@sphcmbx02.sunplus.com.tw>
 <YbytSBN+4M2JKAuJ@kroah.com>
 <6257a7c929064569aa46826d1bba9a2f@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6257a7c929064569aa46826d1bba9a2f@sphcmbx02.sunplus.com.tw>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 12:53:08PM +0000, Tony Huang 黃懷厚 wrote:
> Dear gregkh, arnd:
> 
> > > > wrote:
> > > > >
> > > > > IOP (IO Processor) embedded inside SP7021 which is used as
> > > > > Processor for I/O control, RTC wake-up and cooperation with CPU &
> > > > > PMC in power management purpose.
> > > > > The IOP core is DQ8051, so also named IOP8051, it supports
> > > > > dedicated JTAG debug pins which share with SP7021.
> > > > > In standby mode operation, the power spec reach 400uA.
> > > > >
> > > > > Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> > > >
> > > > Thanks for the improvements, this again looks better than the previous
> > version.
> > > > I still have some minor comments, and there are a couple of details
> > > > I have commented on before that would need to be addressed, but
> > > > let's focus on the one main issue for now:
> > > >
> > > > The driver still doesn't actually /do/ anything: you load the
> > > > firmware when the driver is loaded, and you shut it down when the
> > > > driver is removed, but otherwise there is no way to interact with
> > > > the iop. You had the miscdevice earlier, and you still register
> > > > that, but there are no file_operations associated with it, so it still doesn't
> > have any effect.
> > > >
> > > > In the original version you had a couple of user-side interfaces,
> > > > for which Greg and I commented that they were not using the correct
> > > > abstractions, and you still list them in the changelog text as "I/O
> > > > control, RTC wake-up and cooperation with CPU & PMC in power
> > management".
> > > >
> > > > If you want to make any progress with adding the driver, I'd say you
> > > > should implement at least two of those high-level interfaces that
> > > > interact with the respective kernel subsystems in order to show that the
> > abstraction works.
> > > >
> > >
> > > Q:"with respective kernel subsystems in order to show that the abstraction
> > works."
> > > May I ask you about repective kernel subsystem.
> > > If I use the file_operation method
> > > Provide user can read and write IOP(8051)'s register.
> > > Is this a repective kernel subsystem?
> > > if not
> > > There are other driver code can give me reference
> > >
> > 
> > I still do not understand what the goal of this driver is.
> > 
> 
> When the poweroff command is executed.

What exactly do you mean by this?  The power off command that is sent to
the kernel from userspace?

> 1.The 8051 has a register to control the power-on and power-off of the system(Linux kernel).
>  If you turn off the power through the 8051 register(DEF_PWR_EN_0=0),
>  The current measured by the circuit board is 0.4mA only. In order to save power.
> 2.The power is not turned off through the 8051 register.
>  The current measured on the circuit board is 33mA
> 3.When the system linux kerenl is powered off. /driver/rtc, /driver/gpio cannot operate.
>   8051 is still alive and operational
>   8051 has RTC register. When the time is up, 8051 powers on the system
>   The 8051 can detect GPIO0~7 pins, and GPIO pin high/low can be used as a power-on judgment mechanism for the system.

So what do you need to do?  When the kernel needs to shut down the
system, send a message to this hardware device?  If so, great, just tie
into the normal powerdown sequence, this is nothing new.

If not, I do not understand.

thanks,

greg k-h
