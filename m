Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE7478624
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhLQIYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:24:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41986 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhLQIYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:24:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A460061FCC;
        Fri, 17 Dec 2021 08:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B924C36AE1;
        Fri, 17 Dec 2021 08:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639729487;
        bh=CbaFWW4ZNZTH1DI4qN8igDyU8NcMcrxlUtLugBF1z2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OwzwgO2/tQcE5OVcqx2S7YU5QuqvLtn5aK9H2iIw5ACZaTLINdbqFwQU1vkQXHo4U
         j9MCOhlncsTM2ifqf7eAeFjqN1UIiLKfU5pplziMDORm0yB7tGjxygPPpLLRNBsX3v
         x2jzmYHFxI2iYxCMcoZPx3AUFh9/eQEMksdrkR8Y=
Date:   Fri, 17 Dec 2021 09:24:43 +0100
From:   gregkh <gregkh@linuxfoundation.org>
To:     Tony Huang =?utf-8?B?6buD5oe35Y6a?= <tony.huang@sunplus.com>
Cc:     Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?B?6buD5oe35Y6a?= <tonyhuang.sunplus@gmail.com>
Subject: Re: [PATCH v4 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <YbxJSxjumZ8nkOm8@kroah.com>
References: <cover.1639557112.git.tonyhuang.sunplus@gmail.com>
 <c3a3b64c38807b2f344c3df500eb4c60b885eadf.1639557112.git.tonyhuang.sunplus@gmail.com>
 <YbrsbtBgUDnjZJ/o@kroah.com>
 <CAHpW4oRTcXq6k2o4cjFeHznZrR737947UPE60nWyPTRLPTR0Gw@mail.gmail.com>
 <3a2820c389444f7db99712f7cd11de30@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a2820c389444f7db99712f7cd11de30@sphcmbx02.sunplus.com.tw>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 08:10:45AM +0000, Tony Huang 黃懷厚 wrote:
> Dear Gregkh:
> 
> > > +
> > > +static ssize_t sp_iop_state1_show(struct device *dev, struct
> > > +device_attribute *attr, char *buf) {
> > > +     struct sp_iop *iop = dev_get_drvdata(dev);
> > > +     ssize_t len = 0;
> > > +
> > > +     sp_iop_standby_mode(iop);
> > > +     mdelay(10);
> > > +     sp_iop_s1mode(dev, iop);
> > > +     return len;
> > > +}
> > 
> > This function is not showing anything.
> > 
> 							
> The purpose of this function:							
> SP7021 has three power states:S0, S1 and S3.							
> S0:Default domain is on. IOP domain is on. AO domain is on.							
> S1:Default domain is off. IOP domain is on. AO domain is on.							
> S3:Default domain is off. IOP domain is off. AO domain is on.							
> System enter S1 mode when read sysfs sp_iop_state1,							

That is not what sysfs is for, sorry.

> I hope to provide users with the ability to enter S1 mode by themselves.							
> So I cannot use DEVICE_ATTR. I should use file_operations method.							

No, please use the normal power management callbacks for your driver
that all other drivers use in the kernel.  There is nothing special
about this one driver to warrant a totally new user/kernel api for it.

thanks,

greg k-h
