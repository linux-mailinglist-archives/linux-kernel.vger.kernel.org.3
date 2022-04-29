Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A89515660
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381058AbiD2VHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbiD2VHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:07:06 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD43ED3DB4;
        Fri, 29 Apr 2022 14:03:47 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e922e68b0fso9349642fac.1;
        Fri, 29 Apr 2022 14:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sbKxgE0VFAUjsV8aDklSQZsp/MANbDsJlafyoGa1dhI=;
        b=75AMcu04F3f/cOO6PzPy4SWjUX7DTj5OgSozz3Z5robYFRsKeVppGDRnJcLaeb1i3/
         UTa0DwZzttQ8QOTIE/BphNkaPwz5ZId+z+A5rQusiuJ58UTZaQN17I4UkdTO8qEz6jG5
         n8dHtSf2sge6p0GVkzaKh2KO9XKM4hYVufwTaFaCDCdO0S01D01O5j0ULyjzHTiNtcAi
         4uXzXw36v0IUAm82VVU4QmBo2qW+yGTKXSjmC6e7Z9i7hHnmDzb3V0zg8AIyMJ8xryT7
         NqPO1E+bs+jhuoMoazbJDKWjwgecOYqPmVBiMMRs2ZjGAbgrn8ZWUNj2yz54hEXOiRFF
         9A7Q==
X-Gm-Message-State: AOAM532n0IVTRJJVXJItoGj0eRDENR1XV58/fzzlYfZnPOj5VfXoSqS5
        xkd8DgzkPmIEpCz+/CioJvrpsDM7Lg==
X-Google-Smtp-Source: ABdhPJyClOeqKHhfPKssXgrxN0WiaGeraSM8C1JjwVCk75IyfZHN9Z5vTF4ZAcHz8YKKxTNtoGe8Ug==
X-Received: by 2002:a05:6870:248b:b0:e5:9d7d:8795 with SMTP id s11-20020a056870248b00b000e59d7d8795mr569482oaq.74.1651266227123;
        Fri, 29 Apr 2022 14:03:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e125-20020aca3783000000b00325cda1ffa4sm112973oia.35.2022.04.29.14.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:03:46 -0700 (PDT)
Received: (nullmailer pid 2870003 invoked by uid 1000);
        Fri, 29 Apr 2022 21:03:45 -0000
Date:   Fri, 29 Apr 2022 16:03:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sebastian Ene <sebastianene@google.com>,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        qperret@google.com, will@kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YmxSsSxncvMak+L1@robh.at.kernel.org>
References: <20220429083030.3241640-1-sebastianene@google.com>
 <20220429083030.3241640-3-sebastianene@google.com>
 <YmunAm8ooJkNCx5D@kroah.com>
 <YmuvQvuPF/mn5S4C@google.com>
 <YmuyLCdpnCzGnILI@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmuyLCdpnCzGnILI@kroah.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 11:38:52AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Apr 29, 2022 at 09:26:26AM +0000, Sebastian Ene wrote:
> > On Fri, Apr 29, 2022 at 10:51:14AM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Apr 29, 2022 at 08:30:33AM +0000, Sebastian Ene wrote:
> > > > This driver creates per-cpu hrtimers which are required to do the
> > > > periodic 'pet' operation. On a conventional watchdog-core driver, the
> > > > userspace is responsible for delivering the 'pet' events by writing to
> > > > the particular /dev/watchdogN node. In this case we require a strong
> > > > thread affinity to be able to account for lost time on a per vCPU.
> > > > 
> > > > This part of the driver is the 'frontend' which is reponsible for
> > > > delivering the periodic 'pet' events, configuring the virtual peripheral
> > > > and listening for cpu hotplug events. The other part of the driver
> > > > handles the peripheral emulation and this part accounts for lost time by
> > > > looking at the /proc/{}/task/{}/stat entries and is located here:
> > > > https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
> > > > 
> > > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > > ---
> > > >  drivers/misc/Kconfig       |  12 +++
> > > >  drivers/misc/Makefile      |   1 +
> > > >  drivers/misc/vm-watchdog.c | 206 +++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 219 insertions(+)
> > > >  create mode 100644 drivers/misc/vm-watchdog.c
> > > > 
> > > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > > index 2b9572a6d114..26c3a99e269c 100644
> > > > --- a/drivers/misc/Kconfig
> > > > +++ b/drivers/misc/Kconfig
> > > > @@ -493,6 +493,18 @@ config OPEN_DICE
> > > >  
> > > >  	  If unsure, say N.
> > > >  
> > > > +config VM_WATCHDOG
> > > > +	tristate "Virtual Machine Watchdog"
> > > > +	select LOCKUP_DETECTOR
> > > > +	help
> > > > +	  Detect CPU locks on the virtual machine. This driver relies on the
> > > > +	  hrtimers which are CPU-binded to do the 'pet' operation. When a vCPU
> > > > +	  has to do a 'pet', it exits the guest through MMIO write and the
> > > > +	  backend driver takes into account the lost ticks for this particular
> > > > +	  CPU.
> > 
> > Hi,
> > 
> > > 
> > > There's nothing to keep this tied to a virtual machine at all, right?
> > > You are just relying on some iomem address to be updated, so it should
> > > be a "generic_iomem_watchdog" driver as there's nothing specific to vms
> > > at all from what I can tell.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > That's right although I might think of using the term "generic lockup detector"
> > instead of watchdog. The only reason why I would keep "virtual machine"
> > word in, is that there is no actual hardware for this.
> 
> That doesn't really matter, it's just a memory location in device tree
> that you are needing, odds are some hardware device could use it just
> like this.

Such as a shared on-chip memory that both a system control processor and 
the main processors can access. Of course, those also typically already 
have a comnunication channel.

But for a VM-hypervisor interface, why isn't one of the existing 
communications interfaces being used? One that is discoverable would be 
better than using DT.

Rob
