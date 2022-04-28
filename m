Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316B65136CD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348292AbiD1O0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbiD1O0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:26:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D15DB7177
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:23:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e2so7015505wrh.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T4OMoRCcRVFA0GeITjWTTDrrAy3UuDdOn8MZYxeYMis=;
        b=fImJLDZTPArsLzV9PRdwFEyKlSRMrN5LdM1x+ekTA138hg+0H5oafdm8imQPdZiKPF
         KeV7HuMjKfgEfZmJVXlVt3uhOTw3txj9LTWHunMbrxbQeBIUfetQPz7Aq4cFz4RuL8x5
         eOO4eDEE0ldw2I+rp3vPFg6kptFNeoVznsFuKixY1wirzck4E3yEk6cAh0SL/qOYVCKL
         QywOvJ1fm57xbRvYQfptdv2h/bVJmwpO4vGJQ2P9LZjkBiZoboObEQKvS/UD7JMTylM9
         /+2jRT3lH5X8VL7E4v6538rmtlv7rPb0uZ49sSPCb3MHtHqjQQR+T/RQ0XYcd5Rs/LP1
         c5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T4OMoRCcRVFA0GeITjWTTDrrAy3UuDdOn8MZYxeYMis=;
        b=rEcQWMyVJ2cU3hYimxsZ0O7nAlnyEzMuRsKGL7z6E4XIzw7xfVJ6gk9dSabeTDUkOu
         V3+375WrM9UiK0XjeLov0G+pZf6TRn1bwHusAIARb9EQ1sJEOrMIay+yFh+QkvapOpEl
         HasrIiQGzv75qRg7DV5BDWT0/mF3+xafiea0oeBFYv+uoGEweVsFyB8X3BsqsA3jiN28
         4KCyN4/jvDvKtKOEwTkG+hohS77fxtbEgX0gaEBwc2a1KTKUIm9zGd9WoGQT7gSuduCO
         /gQXAzgWqPdNe5N4XaGtYLL2PZKtEXuYuiSvN/181LGKtgze6FTGmcVucMx9F3rJ0gPK
         AGtQ==
X-Gm-Message-State: AOAM533R3LbvjM7qeVRQCtlkUTn34NgCA7eEdxtXQJW60lz2WiabIjvg
        HoaOHU4l4DiVBSYVkwDIdDG1Tg==
X-Google-Smtp-Source: ABdhPJxFwFWv25lUO45yoxx4zaBAdRGsWMAwwanW5Af0EZ/KUaWE0nXEVHMN96zefB66I2AhTNvOgg==
X-Received: by 2002:a5d:6daf:0:b0:20a:dd36:7296 with SMTP id u15-20020a5d6daf000000b0020add367296mr15658915wrs.274.1651155805911;
        Thu, 28 Apr 2022 07:23:25 -0700 (PDT)
Received: from google.com (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id g13-20020a5d64ed000000b0020a9e488976sm21664wri.25.2022.04.28.07.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:23:25 -0700 (PDT)
Date:   Thu, 28 Apr 2022 14:23:24 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        qperret@google.com, will@kernel.org, maz@kernel.org
Subject: Re: [PATCH v3 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YmqjXDJCnuEZVGpa@google.com>
References: <20220425134204.149042-1-sebastianene@google.com>
 <20220425134204.149042-3-sebastianene@google.com>
 <YmatGqfEZOSL0Yfg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmatGqfEZOSL0Yfg@kroah.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 04:15:54PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 25, 2022 at 01:42:07PM +0000, Sebastian Ene wrote:
> > This driver creates per-cpu hrtimers which are required to do the
> > periodic 'pet' operation. On a conventional watchdog-core driver, the
> > userspace is responsible for delivering the 'pet' events by writing to
> > the particular /dev/watchdogN node. In this case we require a strong
> > thread affinity to be able to account for lost time on a per vCPU.
> > 
> > This part of the driver is the 'frontend' which is reponsible for
> > delivering the periodic 'pet' events, configuring the virtual peripheral
> > and listening for cpu hotplug events. The other part of the driver
> > handles the peripheral emulation and this part accounts for lost time by
> > looking at the /proc/{}/task/{}/stat entries and is located here:
> > https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  drivers/misc/Kconfig  |  12 +++
> >  drivers/misc/Makefile |   1 +
> >  drivers/misc/vm-wdt.c | 207 ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 220 insertions(+)
> >  create mode 100644 drivers/misc/vm-wdt.c
> > 
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 2b9572a6d114..71c173e3f064 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -493,6 +493,18 @@ config OPEN_DICE
> >  
> >  	  If unsure, say N.
> >  
> > +config VM_WATCHDOG
> > +	tristate "Virtual Machine Watchdog"
> > +	select LOCKUP_DETECTOR
> > +	help
> > +	  Detect CPU locks on the virtual machine. This driver relies on the
> > +	  hrtimers which are CPU-binded to do the 'pet' operation. When a vCPU
> > +	  has to do a 'pet', it exists the guest through MMIO write and the
> > +	  backend driver takes into account the lost ticks for this particular
> > +	  CPU.
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called vm-wdt.
> > +
> >  source "drivers/misc/c2port/Kconfig"
> >  source "drivers/misc/eeprom/Kconfig"
> >  source "drivers/misc/cb710/Kconfig"
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index 2ec634354cf5..fa9d644da5db 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -59,3 +59,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
> >  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
> >  obj-$(CONFIG_UID_SYS_STATS)	+= uid_sys_stats.o
> >  obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
> > +obj-$(CONFIG_VM_WATCHDOG)	+= vm-wdt.o

Hi,

> 
> We have no limit on names, why not "vm-watchdog"?
> 

I will update the name to vm-watchdog.

> > \ No newline at end of file
> > diff --git a/drivers/misc/vm-wdt.c b/drivers/misc/vm-wdt.c
> > new file mode 100644
> > index 000000000000..0c4df2fefbb9
> > --- /dev/null
> > +++ b/drivers/misc/vm-wdt.c
> > @@ -0,0 +1,207 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Virtual watchdog driver.
> > +//  Copyright (C) Google, 2022
> 
> I will need a watchdog maintainer to agree that this is the way to do
> this as I really really do not understand why you can not use that
> subsystem here.
> 

Sure, let me CC Guenter Roeck as he initially helped me with the
feedback on this.

> > +
> > +#include <linux/cpu.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +
> > +#include <linux/device.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/nmi.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/param.h>
> > +#include <linux/percpu.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#define DRV_NAME			"vm_wdt"
> 
> KBUILD_MODNAME please
> 

Fixed.

> > +
> > +#define VMWDT_REG_STATUS		(0x00)
> > +#define VMWDT_REG_LOAD_CNT		(0x04)
> > +#define VMWDT_REG_CURRENT_CNT		(0x08)
> > +#define VMWDT_REG_CLOCK_FREQ_HZ		(0x0C)
> > +#define VMWDT_REG_LEN			(0x10)
> > +
> > +#define VMWDT_DEFAULT_CLOCK_HZ		(10)
> > +#define VMWDT_DEFAULT_TIMEOT_SEC	(8)
> > +
> > +struct vm_wdt_s {
> > +	void __iomem *membase;
> > +	u32 clock_freq;
> > +	u32 expiration_sec;
> > +	u32 ping_timeout_ms;
> > +	struct hrtimer per_cpu_hrtimer;
> > +	struct platform_device *dev;
> > +};
> > +
> > +#define vmwdt_reg_write(wdt, reg, value)	\
> > +	iowrite32((value), (wdt)->membase + (reg))
> > +#define vmwdt_reg_read(wdt, reg)		\
> > +	io32read((wdt)->membase + (reg))
> > +
> > +static struct platform_device *virt_dev;
> 
> Only one device in the system?  Please no, use the correct apis and you
> will not have any limits like this.
> 

Can you please explain what do you mean by use the correct APIs ? I
don't think it will be possible or necessary to register multipple
instances of this. 

> > +
> > +static enum hrtimer_restart vmwdt_timer_fn(struct hrtimer *hrtimer)
> > +{
> > +	struct vm_wdt_s *cpu_wdt;
> > +	u32 ticks;
> > +
> > +	cpu_wdt = container_of(hrtimer, struct vm_wdt_s, per_cpu_hrtimer);
> > +	ticks = cpu_wdt->clock_freq * cpu_wdt->expiration_sec;
> > +	vmwdt_reg_write(cpu_wdt, VMWDT_REG_LOAD_CNT, ticks);
> > +	hrtimer_forward_now(hrtimer, ms_to_ktime(cpu_wdt->ping_timeout_ms));
> > +
> > +	return HRTIMER_RESTART;
> > +}
> > +
> > +static void vmwdt_start(void *arg)
> > +{
> > +	u32 ticks;
> > +	struct vm_wdt_s *cpu_wdt = arg;
> > +	struct hrtimer *hrtimer = &cpu_wdt->per_cpu_hrtimer;
> > +
> > +	vmwdt_reg_write(cpu_wdt, VMWDT_REG_CLOCK_FREQ_HZ,
> > +			cpu_wdt->clock_freq);
> > +
> > +	/* Compute the number of ticks required for the watchdog counter
> > +	 * register based on the internal clock frequency and the watchdog
> > +	 * timeout given from the device tree.
> > +	 */
> > +	ticks = cpu_wdt->clock_freq * cpu_wdt->expiration_sec;
> > +	vmwdt_reg_write(cpu_wdt, VMWDT_REG_LOAD_CNT, ticks);
> > +
> > +	/* Enable the internal clock and start the watchdog */
> > +	vmwdt_reg_write(cpu_wdt, VMWDT_REG_STATUS, 1);
> > +
> > +	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > +	hrtimer->function = vmwdt_timer_fn;
> > +	hrtimer_start(hrtimer, ms_to_ktime(cpu_wdt->ping_timeout_ms),
> > +		      HRTIMER_MODE_REL_PINNED);
> > +}
> > +
> > +static void vmwdt_stop(void *arg)
> > +{
> > +	struct vm_wdt_s *cpu_wdt = arg;
> > +	struct hrtimer *hrtimer = &cpu_wdt->per_cpu_hrtimer;
> > +
> > +	hrtimer_cancel(hrtimer);
> > +
> > +	/* Disable the watchdog */
> > +	vmwdt_reg_write(cpu_wdt, VMWDT_REG_STATUS, 0);
> > +}
> > +
> > +static int start_watchdog_on_cpu(unsigned int cpu)
> > +{
> > +	struct vm_wdt_s *vm_wdt = platform_get_drvdata(virt_dev);
> > +
> > +	vmwdt_start(this_cpu_ptr(vm_wdt));
> > +	return 0;
> > +}
> > +
> > +static int stop_watchdog_on_cpu(unsigned int cpu)
> > +{
> > +	struct vm_wdt_s *vm_wdt = platform_get_drvdata(virt_dev);
> > +
> > +	vmwdt_stop(this_cpu_ptr(vm_wdt));
> > +	return 0;
> > +}
> > +
> > +static int vmwdt_probe(struct platform_device *dev)
> > +{
> > +	int cpu, ret, err;
> > +	void __iomem *membase;
> > +	struct resource *r;
> > +	struct vm_wdt_s *vm_wdt;
> > +	u32 wdt_clock, wdt_timeout_sec = 0;
> > +
> > +	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
> > +	if (r == NULL)
> > +		return -ENOENT;
> > +
> > +	vm_wdt = alloc_percpu(typeof(struct vm_wdt_s));
> > +	if (!vm_wdt)
> > +		return -ENOMEM;
> > +
> > +	membase = ioremap(r->start, resource_size(r));
> > +	if (!membase) {
> > +		ret = -ENXIO;
> > +		goto err_withmem;
> > +	}
> > +
> > +	virt_dev = dev;
> > +	platform_set_drvdata(dev, vm_wdt);
> > +	if (of_property_read_u32(dev->dev.of_node, "clock", &wdt_clock))
> > +		wdt_clock = VMWDT_DEFAULT_CLOCK_HZ;
> > +
> > +	if (of_property_read_u32(dev->dev.of_node, "timeout-sec",
> > +				 &wdt_timeout_sec))
> > +		wdt_timeout_sec = VMWDT_DEFAULT_TIMEOT_SEC;
> > +
> > +	for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask) {
> > +		struct vm_wdt_s *cpu_wdt = per_cpu_ptr(vm_wdt, cpu);
> > +
> > +		cpu_wdt->membase = membase + cpu * VMWDT_REG_LEN;
> > +		cpu_wdt->clock_freq = wdt_clock;
> > +		cpu_wdt->expiration_sec = wdt_timeout_sec;
> > +		cpu_wdt->ping_timeout_ms = wdt_timeout_sec * MSEC_PER_SEC / 2;
> > +		smp_call_function_single(cpu, vmwdt_start, cpu_wdt, true);
> > +	}
> > +
> > +	err = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> > +					"virt/watchdog:online",
> > +					start_watchdog_on_cpu,
> > +					stop_watchdog_on_cpu);
> > +	if (err < 0) {
> > +		pr_warn("could not be initialized");
> 
> drivers should never use pr_* calls.  dev_warn() please.
>

Removed this call,

> thanks,
> 
> greg k-h

Thanks,
Sebastian
