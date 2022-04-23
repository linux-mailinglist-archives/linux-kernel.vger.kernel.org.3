Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A80950C88C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 11:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiDWJZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 05:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbiDWJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 05:25:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6752512AC4;
        Sat, 23 Apr 2022 02:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9F9C60DB9;
        Sat, 23 Apr 2022 09:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89833C385A0;
        Sat, 23 Apr 2022 09:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650705760;
        bh=/6spwuGD7s6k5UHwAOLGYEIQIzOZnVQGDC4yY3txoKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h2LX6ZP24fTlcGrkoq5wVmIZcwurxakm29bL0fc3LDYWG5juoJb19oivrAdoQPOvU
         o9DeigacFjPqHtiWfW3XnRRPFXdFZ2qPMaIMUFquNz+2238fyPcCudOdXfr3oiF1Sc
         BoNXQXdkTEhwPTcNO3NZ3rKZYWE1b2Bh32x8E+VU=
Date:   Sat, 23 Apr 2022 11:22:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        qperret@google.com, will@kernel.org, maz@kernel.org
Subject: Re: [PATCH  v2 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YmPFXETRICsFIrR7@kroah.com>
References: <20220422141949.3456505-1-sebastianene@google.com>
 <20220422141949.3456505-3-sebastianene@google.com>
 <YmOhmzmBL36rBO30@kroah.com>
 <YmPDjWK5X1O3HQvk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmPDjWK5X1O3HQvk@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 09:14:53AM +0000, Sebastian Ene wrote:
> On Sat, Apr 23, 2022 at 08:50:03AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Apr 22, 2022 at 02:19:50PM +0000, Sebastian Ene wrote:
> 
> Hello Greg,
> 
> > > This patch adds support for a virtual watchdog which relies on the
> > > per-cpu hrtimers to pet at regular intervals.
> > > 
> > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > ---
> > >  drivers/misc/Kconfig  |   8 ++
> > >  drivers/misc/Makefile |   1 +
> > >  drivers/misc/vm-wdt.c | 215 ++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 224 insertions(+)
> > >  create mode 100644 drivers/misc/vm-wdt.c
> > > 
> > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > index 2b9572a6d114..0e710149ff95 100644
> > > --- a/drivers/misc/Kconfig
> > > +++ b/drivers/misc/Kconfig
> > > @@ -493,6 +493,14 @@ config OPEN_DICE
> > >  
> > >  	  If unsure, say N.
> > >  
> > > +config VM_WATCHDOG
> > > +	tristate "Virtual Machine Watchdog"
> > > +	select LOCKUP_DETECTOR
> > > +	help
> > > +	  Detect CPU locks on the virtual machine.
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called vm-wdt.
> > > +
> > >  source "drivers/misc/c2port/Kconfig"
> > >  source "drivers/misc/eeprom/Kconfig"
> > >  source "drivers/misc/cb710/Kconfig"
> > > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > > index 2ec634354cf5..868e28d01b75 100644
> > > --- a/drivers/misc/Makefile
> > > +++ b/drivers/misc/Makefile
> > > @@ -59,3 +59,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
> > >  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
> > >  obj-$(CONFIG_UID_SYS_STATS)	+= uid_sys_stats.o
> > >  obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
> > > +obj-$(CONFIG_VM_WATCHDOG) += vm-wdt.o
> > 
> > No tab?
> > 
> 
> I will add one.
> 
> > > \ No newline at end of file
> > > diff --git a/drivers/misc/vm-wdt.c b/drivers/misc/vm-wdt.c
> > > new file mode 100644
> > > index 000000000000..ea4351754645
> > > --- /dev/null
> > > +++ b/drivers/misc/vm-wdt.c
> > > @@ -0,0 +1,215 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > 
> > I have to ask, do you really mean "+" here as this is not the overall
> > license of the kernel.  It's not a normal license for your employer to
> > pick, so as long as you have legal approval, it's fine, but if not, you
> > need to get that.
> > 
> 
> Thanks for letting me know, I think this should be :
> SPDX-License-Identifier: GPL-2.0 without "+".
> 
> > > +//
> > > +// Virtual watchdog driver.
> > > +//  Copyright (C) Google, 2022
> > > +
> > > +#define pr_fmt(fmt) "vm-watchdog: " fmt
> > 
> > It's a driver, you shouldn't need any pr_* calls.
> >
> 
> I will remove those.
> 
> > > +
> > > +#include <linux/cpu.h>
> > > +#include <linux/init.h>
> > > +#include <linux/io.h>
> > > +#include <linux/kernel.h>
> > > +
> > > +#include <linux/device.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/module.h>
> > > +#include <linux/nmi.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/param.h>
> > > +#include <linux/percpu.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#define DRV_NAME			"vm_wdt"
> > 
> > KBUILD_MODNAME?
> > 
> > > +#define DRV_VERSION			"1.0"
> > 
> > "versions" mean nothing once the code is in the kernel, please drop
> > this.
> > 
> 
> I will drop this.
> 
> > But why isn't this in the normal watchdog subdirectory?  Why is this a
> > special driver?
> > 
> > > +
> > > +#define VMWDT_REG_STATUS		(0x00)
> > > +#define VMWDT_REG_LOAD_CNT		(0x04)
> > > +#define VMWDT_REG_CURRENT_CNT		(0x08)
> > > +#define VMWDT_REG_CLOCK_FREQ_HZ		(0x0C)
> > > +#define VMWDT_REG_LEN			(0x10)
> > > +
> > > +#define VMWDT_DEFAULT_CLOCK_HZ		(10)
> > > +#define VMWDT_DEFAULT_TIMEOT_SEC	(8)
> > > +
> > > +struct vm_wdt_s {
> > > +	void __iomem *membase;
> > > +	u32 clock_freq;
> > > +	u32 expiration_sec;
> > > +	u32 ping_timeout_ms;
> > > +	struct hrtimer per_cpu_hrtimer;
> > > +	struct platform_device *dev;
> > > +};
> > > +
> > > +#define vmwdt_reg_write(wdt, reg, value)	\
> > > +	iowrite32((value), (wdt)->membase + (reg))
> > > +#define vmwdt_reg_read(wdt, reg)		\
> > > +	io32read((wdt)->membase + (reg))
> > > +
> > > +static struct platform_device *virt_dev;
> > > +
> > > +static enum hrtimer_restart vmwdt_timer_fn(struct hrtimer *hrtimer)
> > > +{
> > > +	struct vm_wdt_s *cpu_wdt;
> > > +	u32 ticks;
> > > +
> > > +	cpu_wdt = container_of(hrtimer, struct vm_wdt_s, per_cpu_hrtimer);
> > > +	ticks = cpu_wdt->clock_freq * cpu_wdt->expiration_sec;
> > > +	vmwdt_reg_write(cpu_wdt, VMWDT_REG_LOAD_CNT, ticks);
> > > +	hrtimer_forward_now(hrtimer, ms_to_ktime(cpu_wdt->ping_timeout_ms));
> > > +
> > > +	return HRTIMER_RESTART;
> > > +}
> > > +
> > > +static void vmwdt_start(void *arg)
> > > +{
> > > +	u32 ticks;
> > > +	int cpu = smp_processor_id();
> > > +	struct vm_wdt_s *cpu_wdt = arg;
> > > +	struct hrtimer *hrtimer = &cpu_wdt->per_cpu_hrtimer;
> > > +
> > > +	pr_info("cpu %u vmwdt start\n", cpu);
> > 
> > When drivers work properly, they are quiet.
> > 
> 
> I will drop this.
> 
> > Again, why not have this in drivers/watchdog/ and use the apis there
> > instead of creating a custom one for no reason?
> > 
> 
> I submitted this patch to the drivers/watchdog and I received some
> feedback on it stating that this type of driver is not intended to be
> used with watchdog core, because the drivers don't have a notion of
> CPU. Moreover, we need to keep track of the elapsed time on a per-cpu
> basis and the core watchdog framework doesn't provide this
> functionality.

Then please document the heck out of this in the changelog and in the
Kconfig help text as others will have the same question.

thanks,

greg k-h
