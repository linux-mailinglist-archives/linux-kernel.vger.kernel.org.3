Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C96515AC5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 08:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbiD3GVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 02:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiD3GVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 02:21:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B970ACFB8C;
        Fri, 29 Apr 2022 23:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F12E460A28;
        Sat, 30 Apr 2022 06:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD55C385AA;
        Sat, 30 Apr 2022 06:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651299503;
        bh=uYF2s/xQF4T6AlR6mb0JRgmAFtb0jfMpWbE35bo1HwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2BQcS/4NH+9ysls92X0SSlMU05RTtCM3xnAEHjDjzcWSOmFuV9GpH39yV9EC6WDyn
         rYjTAhmhtnXik1cjo64wcxr4gxnmY32CXfbLqPHcxoEwfikfFZutcJacNREFh2olqH
         giURfq009PrksK7aWDe/vXUbWBgFCAsvr8YuvCM0=
Date:   Sat, 30 Apr 2022 08:18:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sebastian Ene <sebastianene@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, qperret@google.com
Subject: Re: [PATCH v4 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YmzUpr0e+eq0NUYc@kroah.com>
References: <20220429083030.3241640-1-sebastianene@google.com>
 <20220429083030.3241640-3-sebastianene@google.com>
 <YmumSgiTrQUWoXsb@kroah.com>
 <e94fdd89-7b8e-eec3-4b2f-dcea55c7f0bc@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e94fdd89-7b8e-eec3-4b2f-dcea55c7f0bc@roeck-us.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 09:51:51AM -0700, Guenter Roeck wrote:
> On 4/29/22 01:48, Greg Kroah-Hartman wrote:
> > On Fri, Apr 29, 2022 at 08:30:33AM +0000, Sebastian Ene wrote:
> > > This driver creates per-cpu hrtimers which are required to do the
> > > periodic 'pet' operation. On a conventional watchdog-core driver, the
> > > userspace is responsible for delivering the 'pet' events by writing to
> > > the particular /dev/watchdogN node. In this case we require a strong
> > > thread affinity to be able to account for lost time on a per vCPU.
> > > 
> > > This part of the driver is the 'frontend' which is reponsible for
> > > delivering the periodic 'pet' events, configuring the virtual peripheral
> > > and listening for cpu hotplug events. The other part of the driver
> > > handles the peripheral emulation and this part accounts for lost time by
> > > looking at the /proc/{}/task/{}/stat entries and is located here:
> > > https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
> > > 
> > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > ---
> > >   drivers/misc/Kconfig       |  12 +++
> > >   drivers/misc/Makefile      |   1 +
> > >   drivers/misc/vm-watchdog.c | 206 +++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 219 insertions(+)
> > >   create mode 100644 drivers/misc/vm-watchdog.c
> > > 
> > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > index 2b9572a6d114..26c3a99e269c 100644
> > > --- a/drivers/misc/Kconfig
> > > +++ b/drivers/misc/Kconfig
> > > @@ -493,6 +493,18 @@ config OPEN_DICE
> > >   	  If unsure, say N.
> > > +config VM_WATCHDOG
> > > +	tristate "Virtual Machine Watchdog"
> > > +	select LOCKUP_DETECTOR
> > > +	help
> > > +	  Detect CPU locks on the virtual machine. This driver relies on the
> > > +	  hrtimers which are CPU-binded to do the 'pet' operation. When a vCPU
> > > +	  has to do a 'pet', it exits the guest through MMIO write and the
> > > +	  backend driver takes into account the lost ticks for this particular
> > > +	  CPU.
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called vm-wdt.
> > 
> > You forgot to name the module properly here based on the Makefile change
> > you made.
> > 
> > And again, as this is called a "watchdog", it seems crazy that it is not
> > in drivers/watchdog/
> > 
> 
> I disagree. It is not a watchdog driver in the traditional sense (it does
> not use, want to use, or need to use the watchdog driver API or ABI).
> Its functionality is similar to the functionality of kernel/watchdog.c,
> which doesn't belong into drivers/watchdog either.

Ah, ok, that makes more sense, the user/kernel api is not the same.
Someone should put that in the changelog next time :)

thanks,

greg k-h
