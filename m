Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1725D50E2CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242376AbiDYOTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiDYOTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:19:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914B41E3E2;
        Mon, 25 Apr 2022 07:16:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D517B817A8;
        Mon, 25 Apr 2022 14:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D70FC385A4;
        Mon, 25 Apr 2022 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650896158;
        bh=ObPIVtTbvCraR/YbjPvUK8Y6ju5wG0xNdhLgS6UHZ2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J1iXCxiN/QCneMX3FPuKnrMmHcZRFw+NjCrrnflAmszFQDxktmqvIpI1PhPQPm1jM
         TsPWULLG54d1xTUoZwahdv3ilPlejEhOJ3Hk0jQk9oNcMVwJzDjXL/gCdxaRL16Q4B
         nm/klqWOeVCaN2jriRx36X7L+5xxx2pS46cBApmw=
Date:   Mon, 25 Apr 2022 16:15:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, qperret@google.com
Subject: Re: [PATCH v3 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YmatGqfEZOSL0Yfg@kroah.com>
References: <20220425134204.149042-1-sebastianene@google.com>
 <20220425134204.149042-3-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425134204.149042-3-sebastianene@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 01:42:07PM +0000, Sebastian Ene wrote:
> This driver creates per-cpu hrtimers which are required to do the
> periodic 'pet' operation. On a conventional watchdog-core driver, the
> userspace is responsible for delivering the 'pet' events by writing to
> the particular /dev/watchdogN node. In this case we require a strong
> thread affinity to be able to account for lost time on a per vCPU.
> 
> This part of the driver is the 'frontend' which is reponsible for
> delivering the periodic 'pet' events, configuring the virtual peripheral
> and listening for cpu hotplug events. The other part of the driver
> handles the peripheral emulation and this part accounts for lost time by
> looking at the /proc/{}/task/{}/stat entries and is located here:
> https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  drivers/misc/Kconfig  |  12 +++
>  drivers/misc/Makefile |   1 +
>  drivers/misc/vm-wdt.c | 207 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 220 insertions(+)
>  create mode 100644 drivers/misc/vm-wdt.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 2b9572a6d114..71c173e3f064 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -493,6 +493,18 @@ config OPEN_DICE
>  
>  	  If unsure, say N.
>  
> +config VM_WATCHDOG
> +	tristate "Virtual Machine Watchdog"
> +	select LOCKUP_DETECTOR
> +	help
> +	  Detect CPU locks on the virtual machine. This driver relies on the
> +	  hrtimers which are CPU-binded to do the 'pet' operation. When a vCPU
> +	  has to do a 'pet', it exists the guest through MMIO write and the
> +	  backend driver takes into account the lost ticks for this particular
> +	  CPU.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called vm-wdt.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 2ec634354cf5..fa9d644da5db 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -59,3 +59,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
>  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
>  obj-$(CONFIG_UID_SYS_STATS)	+= uid_sys_stats.o
>  obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
> +obj-$(CONFIG_VM_WATCHDOG)	+= vm-wdt.o

We have no limit on names, why not "vm-watchdog"?

> \ No newline at end of file
> diff --git a/drivers/misc/vm-wdt.c b/drivers/misc/vm-wdt.c
> new file mode 100644
> index 000000000000..0c4df2fefbb9
> --- /dev/null
> +++ b/drivers/misc/vm-wdt.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Virtual watchdog driver.
> +//  Copyright (C) Google, 2022

I will need a watchdog maintainer to agree that this is the way to do
this as I really really do not understand why you can not use that
subsystem here.

> +
> +#include <linux/cpu.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/nmi.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/param.h>
> +#include <linux/percpu.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define DRV_NAME			"vm_wdt"

KBUILD_MODNAME please

> +
> +#define VMWDT_REG_STATUS		(0x00)
> +#define VMWDT_REG_LOAD_CNT		(0x04)
> +#define VMWDT_REG_CURRENT_CNT		(0x08)
> +#define VMWDT_REG_CLOCK_FREQ_HZ		(0x0C)
> +#define VMWDT_REG_LEN			(0x10)
> +
> +#define VMWDT_DEFAULT_CLOCK_HZ		(10)
> +#define VMWDT_DEFAULT_TIMEOT_SEC	(8)
> +
> +struct vm_wdt_s {
> +	void __iomem *membase;
> +	u32 clock_freq;
> +	u32 expiration_sec;
> +	u32 ping_timeout_ms;
> +	struct hrtimer per_cpu_hrtimer;
> +	struct platform_device *dev;
> +};
> +
> +#define vmwdt_reg_write(wdt, reg, value)	\
> +	iowrite32((value), (wdt)->membase + (reg))
> +#define vmwdt_reg_read(wdt, reg)		\
> +	io32read((wdt)->membase + (reg))
> +
> +static struct platform_device *virt_dev;

Only one device in the system?  Please no, use the correct apis and you
will not have any limits like this.

> +
> +static enum hrtimer_restart vmwdt_timer_fn(struct hrtimer *hrtimer)
> +{
> +	struct vm_wdt_s *cpu_wdt;
> +	u32 ticks;
> +
> +	cpu_wdt = container_of(hrtimer, struct vm_wdt_s, per_cpu_hrtimer);
> +	ticks = cpu_wdt->clock_freq * cpu_wdt->expiration_sec;
> +	vmwdt_reg_write(cpu_wdt, VMWDT_REG_LOAD_CNT, ticks);
> +	hrtimer_forward_now(hrtimer, ms_to_ktime(cpu_wdt->ping_timeout_ms));
> +
> +	return HRTIMER_RESTART;
> +}
> +
> +static void vmwdt_start(void *arg)
> +{
> +	u32 ticks;
> +	struct vm_wdt_s *cpu_wdt = arg;
> +	struct hrtimer *hrtimer = &cpu_wdt->per_cpu_hrtimer;
> +
> +	vmwdt_reg_write(cpu_wdt, VMWDT_REG_CLOCK_FREQ_HZ,
> +			cpu_wdt->clock_freq);
> +
> +	/* Compute the number of ticks required for the watchdog counter
> +	 * register based on the internal clock frequency and the watchdog
> +	 * timeout given from the device tree.
> +	 */
> +	ticks = cpu_wdt->clock_freq * cpu_wdt->expiration_sec;
> +	vmwdt_reg_write(cpu_wdt, VMWDT_REG_LOAD_CNT, ticks);
> +
> +	/* Enable the internal clock and start the watchdog */
> +	vmwdt_reg_write(cpu_wdt, VMWDT_REG_STATUS, 1);
> +
> +	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer->function = vmwdt_timer_fn;
> +	hrtimer_start(hrtimer, ms_to_ktime(cpu_wdt->ping_timeout_ms),
> +		      HRTIMER_MODE_REL_PINNED);
> +}
> +
> +static void vmwdt_stop(void *arg)
> +{
> +	struct vm_wdt_s *cpu_wdt = arg;
> +	struct hrtimer *hrtimer = &cpu_wdt->per_cpu_hrtimer;
> +
> +	hrtimer_cancel(hrtimer);
> +
> +	/* Disable the watchdog */
> +	vmwdt_reg_write(cpu_wdt, VMWDT_REG_STATUS, 0);
> +}
> +
> +static int start_watchdog_on_cpu(unsigned int cpu)
> +{
> +	struct vm_wdt_s *vm_wdt = platform_get_drvdata(virt_dev);
> +
> +	vmwdt_start(this_cpu_ptr(vm_wdt));
> +	return 0;
> +}
> +
> +static int stop_watchdog_on_cpu(unsigned int cpu)
> +{
> +	struct vm_wdt_s *vm_wdt = platform_get_drvdata(virt_dev);
> +
> +	vmwdt_stop(this_cpu_ptr(vm_wdt));
> +	return 0;
> +}
> +
> +static int vmwdt_probe(struct platform_device *dev)
> +{
> +	int cpu, ret, err;
> +	void __iomem *membase;
> +	struct resource *r;
> +	struct vm_wdt_s *vm_wdt;
> +	u32 wdt_clock, wdt_timeout_sec = 0;
> +
> +	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (r == NULL)
> +		return -ENOENT;
> +
> +	vm_wdt = alloc_percpu(typeof(struct vm_wdt_s));
> +	if (!vm_wdt)
> +		return -ENOMEM;
> +
> +	membase = ioremap(r->start, resource_size(r));
> +	if (!membase) {
> +		ret = -ENXIO;
> +		goto err_withmem;
> +	}
> +
> +	virt_dev = dev;
> +	platform_set_drvdata(dev, vm_wdt);
> +	if (of_property_read_u32(dev->dev.of_node, "clock", &wdt_clock))
> +		wdt_clock = VMWDT_DEFAULT_CLOCK_HZ;
> +
> +	if (of_property_read_u32(dev->dev.of_node, "timeout-sec",
> +				 &wdt_timeout_sec))
> +		wdt_timeout_sec = VMWDT_DEFAULT_TIMEOT_SEC;
> +
> +	for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask) {
> +		struct vm_wdt_s *cpu_wdt = per_cpu_ptr(vm_wdt, cpu);
> +
> +		cpu_wdt->membase = membase + cpu * VMWDT_REG_LEN;
> +		cpu_wdt->clock_freq = wdt_clock;
> +		cpu_wdt->expiration_sec = wdt_timeout_sec;
> +		cpu_wdt->ping_timeout_ms = wdt_timeout_sec * MSEC_PER_SEC / 2;
> +		smp_call_function_single(cpu, vmwdt_start, cpu_wdt, true);
> +	}
> +
> +	err = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +					"virt/watchdog:online",
> +					start_watchdog_on_cpu,
> +					stop_watchdog_on_cpu);
> +	if (err < 0) {
> +		pr_warn("could not be initialized");

drivers should never use pr_* calls.  dev_warn() please.

thanks,

greg k-h
