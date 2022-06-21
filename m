Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E312552D94
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347174AbiFUIy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348465AbiFUIyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:54:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5B626ACA;
        Tue, 21 Jun 2022 01:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05E72614E6;
        Tue, 21 Jun 2022 08:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03ADC3411C;
        Tue, 21 Jun 2022 08:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655801679;
        bh=stOJe6Yy2xjGc5GXNNTGn9kaJkwY1JpspK8KOB4uxx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCTrCaUXgRpWTvpAB4Hn9pCQ0nVvRQ8SFBS77UtpNg0k0obRA+v3fIPp80pSLnZfn
         WF5g6hzW+JUhCcFneEfOGuQPktDhG2r0foiv6ouWnUK9oLyV5i74PIcy8AjGls1FDS
         dN1/ean6Zhb9xoNCMRqdIKIvhMOTY5v0WkUWnTr0=
Date:   Tue, 21 Jun 2022 10:54:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sebastian Ene <sebastianene@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        will@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YrGHS48LR759stoL@kroah.com>
References: <20220621080308.3952915-1-sebastianene@google.com>
 <20220621080308.3952915-3-sebastianene@google.com>
 <YrGBBFW2d/scKDeN@kroah.com>
 <6b5bb5e69888f69fcfdcb8c9c2fd2660@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b5bb5e69888f69fcfdcb8c9c2fd2660@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:44:35AM +0100, Marc Zyngier wrote:
> On 2022-06-21 09:27, Greg Kroah-Hartman wrote:
> > On Tue, Jun 21, 2022 at 08:03:09AM +0000, Sebastian Ene wrote:
> > > This driver creates per-cpu hrtimers which are required to do the
> > > periodic 'pet' operation. On a conventional watchdog-core driver, the
> > > userspace is responsible for delivering the 'pet' events by writing to
> > > the particular /dev/watchdogN node. In this case we require a strong
> > > thread affinity to be able to account for lost time on a per vCPU.
> > > 
> > > This part of the driver is the 'frontend' which is reponsible for
> > > delivering the periodic 'pet' events, configuring the virtual
> > > peripheral
> > > and listening for cpu hotplug events. The other part of the driver
> > > handles the peripheral emulation and this part accounts for lost
> > > time by
> > > looking at the /proc/{}/task/{}/stat entries and is located here:
> > > https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
> > > 
> > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > ---
> > >  drivers/misc/Kconfig               |  12 ++
> > >  drivers/misc/Makefile              |   1 +
> > >  drivers/misc/vcpu_stall_detector.c | 222
> > > +++++++++++++++++++++++++++++
> > >  3 files changed, 235 insertions(+)
> > >  create mode 100644 drivers/misc/vcpu_stall_detector.c
> > > 
> > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > index 41d2bb0ae23a..e15c85d74c4b 100644
> > > --- a/drivers/misc/Kconfig
> > > +++ b/drivers/misc/Kconfig
> > > @@ -483,6 +483,18 @@ config OPEN_DICE
> > > 
> > >  	  If unsure, say N.
> > > 
> > > +config VCPU_STALL_DETECTOR
> > > +	tristate "VCPU stall detector"
> > > +	select LOCKUP_DETECTOR
> > > +	help
> > > +	  Detect CPU locks on a kvm virtual machine. This driver relies on
> > > +	  the hrtimers which are CPU-binded to do the 'pet' operation.
> > > When a
> > > +	  vCPU has to do a 'pet', it exits the guest through MMIO write and
> > > +	  the backend driver takes into account the lost ticks for this
> > > +	  particular CPU.
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called vcpu_stall_detector.
> > 
> > Should this depend on KVM_GUEST?
> 
> Not all architectures have KVM_GUEST, and arm64 has no use for it.

Ah, I thought this was a requirement (or created a better guest image)
for use under KVM.  Nevermind then...

thanks,

greg k-h
