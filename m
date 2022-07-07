Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC03656A356
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiGGNRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbiGGNRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:17:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCC02F3BC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:17:52 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bi22-20020a05600c3d9600b003a04de22ab6so10710416wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TUmKCpF42LYInfOgQlG8egN/lWmsI1+QPryCVpoZW2c=;
        b=Saj53ElWDQHXZtJb3sywvDx+JXx9xnQIgE7rSBsFEoa6D7nWto8pqwHB+Hdtqqebpx
         tLBnHc1tFwOBVfB4TcFpo7vpFdKnUIEw5aBT64sLJZ8MtOwj+VOvWWkvoKfd5udEXGQz
         wQ63tJeEF6xlZuS201/nvZo70zHXtEda5w2mgwrmYPjmn1LMwk4UWrgXjAktszVmm5wE
         u+YthCKAq6+XmRHuHT1jxxa2MDR6dXmHBChQbJWvoOmoYOcSSt6+NHHvgD7w9UyikF/Y
         qco7dmSfqq4hE/hiGIN8xBL7T3ecx0Ut5aQHMobPIjuDnXJ7qI0kI48jwRvS+3bmuePv
         JzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TUmKCpF42LYInfOgQlG8egN/lWmsI1+QPryCVpoZW2c=;
        b=d7pQgt2fINr4oaMsGfkyGfObTAS4D8PgCdV4L6fe4Bg/0XQjKtEod9QmyyQSARu/aS
         0VdqfIFkvR2jeInpzqmG+tAwwSuBtP9QPL9cR0bxZSKGnHAc4maz6eTUEcYQTj7bTYlS
         bjcPXnRavlGw2iWRi6szCVrPdeD8+azsvM5Mk8+Lx8Q+CA9kV2ngmLn911Cui7dTrGvf
         fjrmOq0dQrfwcxKKOppJKmkRwy4rhVROeXF36LF+diP5PK0vdx5R3y2t3WOeQPgBo9Fn
         ebK0Z5LMvVAYS65Gjut0QmKWCXVBkUnSAoWnzkuKSoass4ahXj/GNctZL2DdGDTvNedp
         1KiQ==
X-Gm-Message-State: AJIora8ODVOF+UgBBKYJxR3NO+nyplhO+atlNy51lpWYaVDA6iwPwsby
        8ZZ28v81/VjEGF4gXlABSzcckg==
X-Google-Smtp-Source: AGRyM1uwJR+PFZJ1CVmWj1U7VO8E10ApOxH3+EzvlRYe5TRRKfHweJ29v0Z/NQsNkrpumwYHPzW93w==
X-Received: by 2002:a05:600c:19c8:b0:3a1:7399:861d with SMTP id u8-20020a05600c19c800b003a17399861dmr4507694wmq.170.1657199870626;
        Thu, 07 Jul 2022 06:17:50 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id c2-20020adfe702000000b0021d69860b66sm13934550wrm.9.2022.07.07.06.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:17:50 -0700 (PDT)
Date:   Thu, 7 Jul 2022 13:17:48 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v9 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <Ysbc/B/cZvSKp9pH@google.com>
References: <20220701144013.1085272-1-sebastianene@google.com>
 <20220701144013.1085272-3-sebastianene@google.com>
 <20220706152101.GA3003@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706152101.GA3003@willie-the-truck>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 04:21:01PM +0100, Will Deacon wrote:

Hi Will,

> Hi Sebastian,
> 
> Thanks for working on this and apologies it's taken so long for me to
> review your changes.
> 
> On Fri, Jul 01, 2022 at 02:40:14PM +0000, Sebastian Ene wrote:
> > This driver creates per-cpu hrtimers which are required to do the
> > periodic 'pet' operation. On a conventional watchdog-core driver, the
> > userspace is responsible for delivering the 'pet' events by writing to
> > the particular /dev/watchdogN node. In this case we require a strong
> > thread affinity to be able to account for lost time on a per vCPU.
> > 
> > This part of the driver is the 'frontend' which is reponsible for
> > delivering the periodic 'pet' events, configuring the virtual peripheral
> > and listening for cpu hotplug events. The other part of the driver is
> > an emulated MMIO device which is part of the KVM virtual machine
> > monitor and this part accounts for lost time by looking at the
> > /proc/{}/task/{}/stat entries.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  drivers/misc/Kconfig               |  13 ++
> >  drivers/misc/Makefile              |   1 +
> >  drivers/misc/vcpu_stall_detector.c | 212 +++++++++++++++++++++++++++++
> >  3 files changed, 226 insertions(+)
> >  create mode 100644 drivers/misc/vcpu_stall_detector.c
> > 
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 41d2bb0ae23a..83afb41a85cf 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -483,6 +483,19 @@ config OPEN_DICE
> >  
> >  	  If unsure, say N.
> >  
> > +config VCPU_STALL_DETECTOR
> > +	tristate "VCPU stall detector"
> 
> I'd probably stick "Guest" in here somewhere, as this driver won't be
> useful on the host. So something like "Guest vCPU stall detector".
> 

I improved the description with your suggesion.

> > +	select LOCKUP_DETECTOR
> > +	depends on OF
> > +	help
> > +	  Detect CPU locks on a kvm virtual machine. This driver relies on
> > +	  the hrtimers which are CPU-binded to do the 'pet' operation. When a
> > +	  vCPU has to do a 'pet', it exits the guest through MMIO write and
> > +	  the backend driver takes into account the lost ticks for this
> > +	  particular CPU.
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called vcpu_stall_detector.
> 
> I suggest rewording this along the lines of:
> 
>   When this driver is bound inside a KVM guest, it will periodically
>   "pet" an MMIO stall detector device from each vCPU and allow the host
>   to detect vCPU stalls.
> 
>   To compile this driver as a module, choose M here: the module will
>   be called vcpu_stall_detector.
> 
>   If you do not intend to run this kernel as a guest, say N.
> 
> but up to you.
> 

I reworded this, thanks !

> >  source "drivers/misc/c2port/Kconfig"
> >  source "drivers/misc/eeprom/Kconfig"
> >  source "drivers/misc/cb710/Kconfig"
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index 70e800e9127f..2be8542616dd 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -60,3 +60,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
> >  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
> >  obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
> >  obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
> > +obj-$(CONFIG_VCPU_STALL_DETECTOR)	+= vcpu_stall_detector.o
> > \ No newline at end of file
> > diff --git a/drivers/misc/vcpu_stall_detector.c b/drivers/misc/vcpu_stall_detector.c
> > new file mode 100644
> > index 000000000000..039ac54564c1
> > --- /dev/null
> > +++ b/drivers/misc/vcpu_stall_detector.c
> > @@ -0,0 +1,212 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> This should probably be "GPL-2.0-only" for the avoidance of doubt.
> 

I updated the license.

> > +//
> > +// VCPU stall detector.
> > +//  Copyright (C) Google, 2022
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
> > +#define REG_STATUS		(0x00)
> > +#define REG_LOAD_CNT		(0x04)
> > +#define REG_CURRENT_CNT		(0x08)
> > +#define REG_CLOCK_FREQ_HZ	(0x0C)
> > +#define REG_LEN			(0x10)
> > +
> > +#define DEFAULT_CLOCK_HZ	(10)
> > +#define DEFAULT_TIMEOT_SEC	(8)
> 
> TIMEOUT instead of TIMEOT?
> 

I fixed the typo.

> Generally, I'd probably also prefix these definitions with VCPU_STALL_
> or something to avoid the potential for conflicting with the headers.
> 

I prefixed the definitions with VCPU_STALL_.

> > +struct vm_stall_detect_s {
> > +	void __iomem *membase;
> > +	u32 clock_freq;
> > +	u32 expiration_sec;
> > +	u32 ping_timeout_ms;
> > +	struct hrtimer per_cpu_hrtimer;
> > +	struct platform_device *dev;
> > +};
> > +
> > +#define vcpu_stall_detect_reg_write(stall_detect, reg, value)	\
> > +	iowrite32((value), (stall_detect)->membase + (reg))
> 
> You can use writel_relaxed() here as you don't require ordering guarantees
> against DMA.
> 

I updated it to use writel_relaxed(..) as suggested.

> > +#define vcpu_stall_detect_reg_read(stall_detect, reg)		\
> > +	io32read((stall_detect)->membase + (reg))
> 
> io32read() doesn't exist, but you also don't use this macro so just remove
> it :)
> 

I removed this unused definition.

> > +
> > +static struct vm_stall_detect_s __percpu *vm_stall_detect;
> > +
> > +static enum hrtimer_restart
> > +vcpu_stall_detect_timer_fn(struct hrtimer *hrtimer)
> > +{
> > +	struct vm_stall_detect_s *cpu_stall_detect;
> > +	u32 ticks;
> > +
> > +	cpu_stall_detect = container_of(hrtimer, struct vm_stall_detect_s,
> > +					per_cpu_hrtimer);
> > +	ticks = cpu_stall_detect->clock_freq * cpu_stall_detect->expiration_sec;
> > +	vcpu_stall_detect_reg_write(cpu_stall_detect, REG_LOAD_CNT, ticks);
> > +	hrtimer_forward_now(hrtimer,
> > +			    ms_to_ktime(cpu_stall_detect->ping_timeout_ms));
> > +
> > +	return HRTIMER_RESTART;
> > +}
> > +
> > +static void vcpu_stall_detect_start(void *arg)
> > +{
> > +	u32 ticks;
> > +	struct vm_stall_detect_s *cpu_stall_detect = arg;
> > +	struct hrtimer *hrtimer = &cpu_stall_detect->per_cpu_hrtimer;
> > +
> > +	vcpu_stall_detect_reg_write(cpu_stall_detect, REG_CLOCK_FREQ_HZ,
> > +				    cpu_stall_detect->clock_freq);
> > +
> > +	/* Compute the number of ticks required for the stall detector counter
> > +	 * register based on the internal clock frequency and the timeout
> > +	 * value given from the device tree.
> > +	 */
> > +	ticks = cpu_stall_detect->clock_freq *
> > +		cpu_stall_detect->expiration_sec;
> > +	vcpu_stall_detect_reg_write(cpu_stall_detect, REG_LOAD_CNT, ticks);
> > +
> > +	/* Enable the internal clock and start the stall detector */
> > +	vcpu_stall_detect_reg_write(cpu_stall_detect, REG_STATUS, 1);
> > +
> > +	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > +	hrtimer->function = vcpu_stall_detect_timer_fn;
> > +	hrtimer_start(hrtimer, ms_to_ktime(cpu_stall_detect->ping_timeout_ms),
> > +		      HRTIMER_MODE_REL_PINNED);
> > +}
> > +
> > +static void vcpu_stall_detect_stop(void *arg)
> > +{
> > +	struct vm_stall_detect_s *cpu_stall_detect = arg;
> > +	struct hrtimer *hrtimer = &cpu_stall_detect->per_cpu_hrtimer;
> > +
> > +	hrtimer_cancel(hrtimer);
> > +
> > +	/* Disable the stall detector */
> > +	vcpu_stall_detect_reg_write(cpu_stall_detect, REG_STATUS, 0);
> > +}
> > +
> > +static int start_stall_detector_on_cpu(unsigned int cpu)
> > +{
> > +	vcpu_stall_detect_start(this_cpu_ptr(vm_stall_detect));
> > +	return 0;
> > +}
> > +
> > +static int stop_stall_detector_on_cpu(unsigned int cpu)
> > +{
> > +	vcpu_stall_detect_stop(this_cpu_ptr(vm_stall_detect));
> > +	return 0;
> > +}
> > +
> > +static int vcpu_stall_detect_probe(struct platform_device *dev)
> > +{
> > +	int cpu, ret, err;
> > +	void __iomem *membase;
> > +	struct resource *r;
> > +	u32 stall_detect_clock, stall_detect_timeout_sec = 0;
> > +
> > +	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
> > +	if (r == NULL)
> > +		return -ENODEV;
> > +
> > +	vm_stall_detect = alloc_percpu(typeof(struct vm_stall_detect_s));
> > +	if (!vm_stall_detect)
> > +		return -ENOMEM;
> > +
> > +	membase = ioremap(r->start, resource_size(r));
> > +	if (!membase) {
> > +		ret = -ENOMEM;
> > +		goto err_withmem;
> > +	}
> 
> Can you use devm_platform_get_and_ioremap_resource() to avoid calling
> both platform_get_resource() and ioremap() explicitly? I think the devm_
> handling there also means you don't need to worry about the iounmap(),
> which seems to be missing here anyway.
> 

Thanks, I updated the code to use the
devm_platform_get_and_ioremap_resource(..) API and I modified the
Kconfig so that the driver would depend on HAS_IOMEM.

> > +
> > +	if (of_property_read_u32(dev->dev.of_node, "clock-frequency",
> > +				 &stall_detect_clock))
> > +		stall_detect_clock = DEFAULT_CLOCK_HZ;
> > +
> > +	if (of_property_read_u32(dev->dev.of_node, "timeout-sec",
> > +				 &stall_detect_timeout_sec))
> > +		stall_detect_timeout_sec = DEFAULT_TIMEOT_SEC;
> > +
> > +	for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask) {
> 
> What prevents CPUs from coming up and down during this loop?
> 
> I also don't think we should be using 'watchdog_cpumask' here -- that's
> part of the watchdog core; instead we should either take the mask in the
> DT description or rely on the device exposing an interface for every CPU
> in the system.
> 
> > +		struct vm_stall_detect_s *cpu_stall_detect;
> > +
> > +		cpu_stall_detect = per_cpu_ptr(vm_stall_detect, cpu);
> > +		cpu_stall_detect->membase = membase + cpu * REG_LEN;
> > +		cpu_stall_detect->clock_freq = stall_detect_clock;
> > +		cpu_stall_detect->expiration_sec = stall_detect_timeout_sec;
> > +
> > +		/* Pet the stall detector at half of its expiration timeout
> > +		 * to prevent spurios resets.
> 
> typo: spurious
> 

Fixed the typo.

> > +		 */
> > +		cpu_stall_detect->ping_timeout_ms = stall_detect_timeout_sec *
> > +			MSEC_PER_SEC / 2;
> 
> All of these fields are the same for each core apart from the membase,
> which a CPU can compute locally using its smp_processor_id() so I don't
> think you need to include these in the per-cpu structure. It would be
> simpler if you tracked these invariants in a separate structure (either
> a global static structure or indirected by a per-cpu pointer).
> 
> Then the only thing left for the per-cpu structure would be the hrtimer.
>

I removed the fields which are not needed per-cpu and I only kept the
hrtimers. I created a separate global config structure which holds the
removed data.

> > +		smp_call_function_single(cpu, vcpu_stall_detect_start,
> > +					 cpu_stall_detect, true);
> > +	}
> > +
> > +	err = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> > +					"virt/vcpu_stall_detector:online",
> > +					start_stall_detector_on_cpu,
> > +					stop_stall_detector_on_cpu);
> 
> If you drop the "_nocalls" variant then I think you can avoid the explicit
> previous call to smp_call_function_single() entirely and just rely on the
> notifiers to do the right thing. That also solves the hotplug race I
> mentioned.
> 

I updated the code to use the cpuhp_setup_state API.

> > +	if (err < 0) {
> > +		dev_err(&dev->dev, "failed to install cpu hotplug");
> > +		ret = err;
> > +		goto err_withmem;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_withmem:
> > +	free_percpu(vm_stall_detect);
> 
> Looks like there's a devm_alloc_percpu() which might make this a bit
> simpler.
>

I updated the code to use devm_alloc_percpu(..) and I got rid of the
free_percpu(..).

> > +	return ret;
> > +}
> > +
> > +static int vcpu_stall_detect_remove(struct platform_device *dev)
> > +{
> > +	int cpu;
> > +
> > +	for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask) {
> > +		struct vm_stall_detect_s *cpu_stall_detect;
> > +
> > +		cpu_stall_detect = per_cpu_ptr(vm_stall_detect, cpu);
> > +		smp_call_function_single(cpu, vcpu_stall_detect_stop,
> > +					 cpu_stall_detect, true);
> > +	}
> 
> I don't think you need to cross-call here, and it looks racy again with
> hotplug; you should be able to do something like:
> 
>   1. Unregister the hotplug notifier (looks like you're missing this?)
>   2. Call hrtimer_cancel() for each percpu timer
>   3. Disable the watchdog for each CPU
>

Thanks for pointing our ! I restructured the code on the teardown path.

> > +	free_percpu(vm_stall_detect);
> > +	vm_stall_detect = NULL;
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id vcpu_stall_detect_of_match[] = {
> > +	{ .compatible = "qemu,vcpu-stall-detector", },
> 
> I'm not sure why we're mentioning qemu here; something as boring as "virt"
> (like you use for the cpuhp notifier) or "dummy" might be better, but given
> that Rob is happy with the binding then I won't complain further. We can
> always add extra strings later if we need to.
>
I used this because I originaly designed this for qemu and then I ported
it to crovm.

> > +	{}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, vcpu_stall_detect_of_match);
> > +
> > +static struct platform_driver vcpu_stall_detect_driver = {
> > +	.probe  = vcpu_stall_detect_probe,
> > +	.remove = vcpu_stall_detect_remove,
> > +	.driver = {
> > +		.name           = KBUILD_MODNAME,
> > +		.of_match_table = vcpu_stall_detect_of_match,
> > +	},
> > +};
> > +
> > +module_platform_driver(vcpu_stall_detect_driver);
> > +
> > +MODULE_LICENSE("GPL");
> 
> This needs to be "GPL v2".
>
I think this should stay as is.

> Will

Thanks for reviewing my code !
Seb
