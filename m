Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF24346912B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbhLFIKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbhLFIKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:10:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AA9C0613F8;
        Mon,  6 Dec 2021 00:06:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93D5CB80FD4;
        Mon,  6 Dec 2021 08:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59151C341C2;
        Mon,  6 Dec 2021 08:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638778004;
        bh=+JYZABa/VNnMN1aH4mPbwaAywvvIBRASbF3zU3rogs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZnXaNUqLSG+dgefMM3cHVoBtYn50A2WCzc2EuCx3D2rJOCVb1PFUD9xgHFReEfQ6
         UdRnrk/ZcE/Z6rXN0L7CtI3T52so49h4NSeZjP6t9WN8MCYXEFmNZJkdMGSG0yRtZ8
         W2xTrhPc6qq6NjdEYWwvE2fLd+4rJiG0T6qUzMH0=
Date:   Mon, 6 Dec 2021 09:06:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tony Huang =?utf-8?B?6buD5oe35Y6a?= <tony.huang@sunplus.com>
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: Re: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <Ya3EjykU5RMaRbkt@kroah.com>
References: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
 <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
 <Yanz1xpZamJVZ0LE@kroah.com>
 <5ab2710b37784d51a3f4f90f625ae907@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ab2710b37784d51a3f4f90f625ae907@sphcmbx02.sunplus.com.tw>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 06:48:46AM +0000, Tony Huang 黃懷厚 wrote:
> Dear Greg KH, Arnd:
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, December 3, 2021 6:39 PM
> > To: Tony Huang <tonyhuang.sunplus@gmail.com>
> > Cc: derek.kiernan@xilinx.com; dragan.cvetic@xilinx.com; arnd@arndb.de;
> > linux-kernel@vger.kernel.org; robh+dt@kernel.org; devicetree@vger.kernel.org;
> > Wells Lu 呂芳騰 <wells.lu@sunplus.com>; Tony Huang 黃懷厚
> > <tony.huang@sunplus.com>
> > Subject: Re: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
> > 
> > On Fri, Dec 03, 2021 at 11:48:45AM +0800, Tony Huang wrote:
> > > IOP (IO Processor) embedded inside SP7021 which is used as Processor
> > > for I/O control, RTC wake-up and cooperation with CPU & PMC in power
> > > management purpose.
> > > The IOP core is DQ8051, so also named IOP8051, it supports dedicated
> > > JTAG debug pins which share with SP7021.
> > > In standby mode operation, the power spec reach 400uA.
> > >
> > > Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> > > ---
> > > Changes in v2:
> > >  - Addressed comments from Arnd Bergmann.
> > >  - Addressed comments from Greg KH.
> > >  - Addressed comments from kernel test robot.
> > >
> > >  MAINTAINERS                    |   1 +
> > >  drivers/misc/Kconfig           |   1 +
> > >  drivers/misc/Makefile          |   1 +
> > >  drivers/misc/iop/Kconfig       |  13 ++
> > >  drivers/misc/iop/Makefile      |   6 +
> > 
> > Why do you need a subdirectory for a single .c file?
> > 
> 
> 1. Currently my bin file is placed in the root file system. I need to
> wait for the kernel booting to succeed before loading the bin code.

What "bin file"?

> 2. In addition, I need the kernel booting process to be able to mount
> the iop module and load bin file.I need to put bin file in /iop.

That is an odd directory location.

> Do you have a good way to load bin code during kernel booting?

Is this firmware?  Put it in the normal location for firware that the
kernel expects to see.

thanks,

greg k-h
