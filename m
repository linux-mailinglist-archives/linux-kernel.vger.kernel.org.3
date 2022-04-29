Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53070514587
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356669AbiD2JmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356614AbiD2JmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:42:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D81BC879;
        Fri, 29 Apr 2022 02:38:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F45962269;
        Fri, 29 Apr 2022 09:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED33C385A4;
        Fri, 29 Apr 2022 09:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651225135;
        bh=7wQ6VFKp/al5aiAM5L8qP/IgOcL9rHjqdl9Sb4sPKwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u2DbfNQ45vxveL0XtmTG+CKMjygaqgD8Av0W6Kuw+VJ5e+DYDWKJCIGvORHScfh88
         iOaoWBEB7wOFUBnM32SqMwumKX4AAc65EApor5VRNyd3szCKI2Oli1y9B8/Aue3YEK
         mT2GYzXYKkLbWiopnuKH89/cQU4e8m+wfzfw22Rk=
Date:   Fri, 29 Apr 2022 11:38:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        qperret@google.com, will@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YmuyLCdpnCzGnILI@kroah.com>
References: <20220429083030.3241640-1-sebastianene@google.com>
 <20220429083030.3241640-3-sebastianene@google.com>
 <YmunAm8ooJkNCx5D@kroah.com>
 <YmuvQvuPF/mn5S4C@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmuvQvuPF/mn5S4C@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 09:26:26AM +0000, Sebastian Ene wrote:
> On Fri, Apr 29, 2022 at 10:51:14AM +0200, Greg Kroah-Hartman wrote:
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
> > >  drivers/misc/Kconfig       |  12 +++
> > >  drivers/misc/Makefile      |   1 +
> > >  drivers/misc/vm-watchdog.c | 206 +++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 219 insertions(+)
> > >  create mode 100644 drivers/misc/vm-watchdog.c
> > > 
> > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > index 2b9572a6d114..26c3a99e269c 100644
> > > --- a/drivers/misc/Kconfig
> > > +++ b/drivers/misc/Kconfig
> > > @@ -493,6 +493,18 @@ config OPEN_DICE
> > >  
> > >  	  If unsure, say N.
> > >  
> > > +config VM_WATCHDOG
> > > +	tristate "Virtual Machine Watchdog"
> > > +	select LOCKUP_DETECTOR
> > > +	help
> > > +	  Detect CPU locks on the virtual machine. This driver relies on the
> > > +	  hrtimers which are CPU-binded to do the 'pet' operation. When a vCPU
> > > +	  has to do a 'pet', it exits the guest through MMIO write and the
> > > +	  backend driver takes into account the lost ticks for this particular
> > > +	  CPU.
> 
> Hi,
> 
> > 
> > There's nothing to keep this tied to a virtual machine at all, right?
> > You are just relying on some iomem address to be updated, so it should
> > be a "generic_iomem_watchdog" driver as there's nothing specific to vms
> > at all from what I can tell.
> > 
> > thanks,
> > 
> > greg k-h
> 
> That's right although I might think of using the term "generic lockup detector"
> instead of watchdog. The only reason why I would keep "virtual machine"
> word in, is that there is no actual hardware for this.

That doesn't really matter, it's just a memory location in device tree
that you are needing, odds are some hardware device could use it just
like this.

thanks,

greg k-h
