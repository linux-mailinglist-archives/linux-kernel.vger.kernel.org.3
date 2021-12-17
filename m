Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3EC478FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhLQPct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238253AbhLQPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:32:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EF1C061D5E;
        Fri, 17 Dec 2021 07:31:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46960B828CD;
        Fri, 17 Dec 2021 15:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737F2C36AE7;
        Fri, 17 Dec 2021 15:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639755083;
        bh=avPBKd+RqLywFvQBtsPcEY5SehnPRvYg2uoOp7Zx7bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1PvPyKDO1WOKI5LWFjGyctPXtrHVyN2HPfkVHs0JtGsCP/j2lj3iXHR8tvF7QT/C
         uQoMqFvrCGYbz7C8YUviATcccdYcxkAlBagSO3zaoHB8B4opiEsLNpG6RxO20PYBz2
         wm4U9qehGP7nB2EiwPI6d1r8R/dx5BRA4EhrK6YM=
Date:   Fri, 17 Dec 2021 16:31:20 +0100
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
Message-ID: <YbytSBN+4M2JKAuJ@kroah.com>
References: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
 <bc15d5e8d7a5ec96582799fe513de4ace6fd4b8b.1639039163.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a2UGr6ZbHk6G=wh5XG_EGdJxGf6SfyN1sTb4aaUgiK8Lw@mail.gmail.com>
 <5c01390c485a44b6913dcb42e3677ed1@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c01390c485a44b6913dcb42e3677ed1@sphcmbx02.sunplus.com.tw>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 03:16:53PM +0000, Tony Huang 黃懷厚 wrote:
> Dear Arnd:
> 
> > On Thu, Dec 9, 2021 at 9:58 AM Tony Huang <tonyhuang.sunplus@gmail.com>
> > wrote:
> > >
> > > IOP (IO Processor) embedded inside SP7021 which is used as Processor
> > > for I/O control, RTC wake-up and cooperation with CPU & PMC in power
> > > management purpose.
> > > The IOP core is DQ8051, so also named IOP8051, it supports dedicated
> > > JTAG debug pins which share with SP7021.
> > > In standby mode operation, the power spec reach 400uA.
> > >
> > > Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> > 
> > Thanks for the improvements, this again looks better than the previous version.
> > I still have some minor comments, and there are a couple of details I have
> > commented on before that would need to be addressed, but let's focus on the
> > one main issue for now:
> > 
> > The driver still doesn't actually /do/ anything: you load the firmware when the
> > driver is loaded, and you shut it down when the driver is removed, but
> > otherwise there is no way to interact with the iop. You had the miscdevice
> > earlier, and you still register that, but there are no file_operations associated
> > with it, so it still doesn't have any effect.
> > 
> > In the original version you had a couple of user-side interfaces, for which Greg
> > and I commented that they were not using the correct abstractions, and you
> > still list them in the changelog text as "I/O control, RTC wake-up and
> > cooperation with CPU & PMC in power management".
> > 
> > If you want to make any progress with adding the driver, I'd say you should
> > implement at least two of those high-level interfaces that interact with the
> > respective kernel subsystems in order to show that the abstraction works.
> > 
> 
> Q:"with respective kernel subsystems in order to show that the abstraction works."
> May I ask you about repective kernel subsystem.
> If I use the file_operation method
> Provide user can read and write IOP(8051)'s register.
> Is this a repective kernel subsystem?
> if not
> There are other driver code can give me reference
> 

I still do not understand what the goal of this driver is.

What is the problem that you are needing to solve?  What needs to access
this hardware, and what exactly was this hardware designed to do?

thanks,

greg k-h
