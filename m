Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE9F584107
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiG1OYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiG1OYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235C754AF0;
        Thu, 28 Jul 2022 07:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 905DB6102A;
        Thu, 28 Jul 2022 14:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B56C433D7;
        Thu, 28 Jul 2022 14:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659018247;
        bh=jGICmRzkN3mB2vVHmw3SJO6pEzZUPArOLL2IhzvWYfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cKDLWHduHYMvzFo69JVaBPtGcczE9v78EFedXugXg2Q26iUlJ+zz6lt6L+Rdgw3VQ
         VBZnZaYkjxvvx7eGqz0ffgyRIocMxEqtCGGFUBGBB8LkAWlrcugzepIfw4CnYpBYzh
         B3JtbldrLfFtDib0fdO2L8i3L9UusHFledAW7N18=
Date:   Thu, 28 Jul 2022 16:24:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, appanad@amd.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@amd.com, git@xilinx.com,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: Re: [PATCH v2 4/4] drivers: misc: Add Support for TMR Inject IP
Message-ID: <YuKcBO5JatwRYQJ3@kroah.com>
References: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
 <20220720060016.1646317-5-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720060016.1646317-5-appana.durga.kedareswara.rao@amd.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 11:30:16AM +0530, Appana Durga Kedareswara rao wrote:
> From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> 
> The Triple Modular Redundancy(TMR) provides functional fault injection by
> changing selected MicroBlaze instructions, which provides the possibility
> to verify that the TMR subsystem error detection and fault recovery logic
> is working properly, provided sysfs entries which allow the user to inject
> a fault.

We already have a fault-injection api, why are you not using that?

> 
> Usage:
> echo 1 > /sys/devices/platform/amba_pl/44a30000.tmr_inject/inject_err
> 
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>

Odd, just one is needed.

> ---
> Changes for v2:
> --> Added Examples for sysfs entries
> --> Removed uneeded struct dev from the driver private structure
> --> Updated driver to use sysfs_emit() API instead of sprintf() API
> --> Added error checks wherever applicable.
> --> Fixed sysfs registration.
>  .../testing/sysfs-driver-xilinx-tmr-inject    |  16 ++
>  MAINTAINERS                                   |   7 +
>  drivers/misc/Kconfig                          |  10 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/xilinx_tmr_inject.c              | 186 ++++++++++++++++++
>  5 files changed, 220 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
>  create mode 100644 drivers/misc/xilinx_tmr_inject.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
> new file mode 100644
> index 000000000000..d274b30ee24c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
> @@ -0,0 +1,16 @@
> +What:		/sys/devices/platform/amba_pl/<dev>/inject_err
> +Date:		June 2022

It's not June anymore, even when you sent this patch :(

> +Contact:	appana.durga.rao@xilinx.com
> +Description:	This control file allows to inject fault using tmr inject.
> +		This file is write only.
> +		Example:
> +		# echo 1 > /sys/devices/platform/amba_pl/44a30000.tmr_inject/inject_err
> +
> +What:		/sys/devices/platform/amba_pl/<dev>/inject_cpuid
> +Date:		June 2022
> +Contact:	appana.durga.rao@xilinx.com
> +Description:	This control file allows to configure the CPU identifier
> +		to enable fault injection.
> +		This file is write only.
> +		Example:
> +		# echo 1 > /sys/devices/platform/amba_pl/44a30000.tmr_inject/inject_cpuid

What errors and faults happen?  Where is that documented?  What happens
when you write to these sysfs files?  Does the system crash?  Why would
you want to use them ever?



> diff --git a/MAINTAINERS b/MAINTAINERS
> index 732fd9ae7d9f..c903b45c204a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13087,6 +13087,13 @@ F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
>  F:	Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
>  F:	drivers/misc/xilinx_tmr_manager.c
>  
> +MICROBLAZE TMR INJECT
> +M:	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
> +S:	Supported
> +F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
> +F:	Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
> +F:	drivers/misc/xilinx_tmr_inject.c
> +
>  MICROCHIP AT91 DMA DRIVERS
>  M:	Ludovic Desroches <ludovic.desroches@microchip.com>
>  M:	Tudor Ambarus <tudor.ambarus@microchip.com>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 555ae2e33b91..0989c36f3051 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -493,6 +493,16 @@ config TMR_MANAGER
>  
>  	  Say N here unless you know what you are doing.
>  
> +config TMR_INJECT
> +	bool "Select TMR Inject"
> +	depends on TMR_MANAGER
> +	help
> +	  This option enables the driver developed for TMR Inject.
> +	  The Triple Modular Redundancy(TMR) Inject provides
> +	  fault injection.
> +
> +	  Say N here unless you know what you are doing.

Why can't this be a module?



> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 28b9803f909b..e9d0a709e207 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -61,3 +61,4 @@ obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
>  obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
>  obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
>  obj-$(CONFIG_TMR_MANAGER)	+= xilinx_tmr_manager.o
> +obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
> diff --git a/drivers/misc/xilinx_tmr_inject.c b/drivers/misc/xilinx_tmr_inject.c
> new file mode 100644
> index 000000000000..930d89e90b61
> --- /dev/null
> +++ b/drivers/misc/xilinx_tmr_inject.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Xilinx TMR Inject IP.
> + *
> + * Copyright (C) 2022 Xilinx, Inc.
> + *
> + * Description:
> + * This driver is developed for TMR Inject IP,The Triple Modular Redundancy(TMR)
> + * Inject provides fault injection.
> + * Fault injection and detection features are provided through sysfs entries
> + * which allow the user to generate a fault.
> + */
> +
> +#include <asm/xilinx_mb_manager.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +
> +/* TMR Inject Register offsets */
> +#define XTMR_INJECT_CR_OFFSET		0x0
> +#define XTMR_INJECT_AIR_OFFSET		0x4
> +#define XTMR_INJECT_IIR_OFFSET		0xC
> +#define XTMR_INJECT_EAIR_OFFSET		0x10
> +#define XTMR_INJECT_ERR_OFFSET		0x204
> +
> +/* Register Bitmasks/shifts */
> +#define XTMR_INJECT_CR_CPUID_SHIFT	8
> +#define XTMR_INJECT_CR_IE_SHIFT		10
> +#define XTMR_INJECT_IIR_ADDR_MASK	GENMASK(31, 16)
> +
> +#define XTMR_INJECT_MAGIC_MAX_VAL	255
> +
> +/**
> + * struct xtmr_inject_dev - Driver data for TMR Inject
> + * @regs: device physical base address
> + * @cr_val: control register value
> + * @magic: Magic hardware configuration value
> + * @err_cnt: error statistics count
> + */
> +struct xtmr_inject_dev {
> +	void __iomem *regs;
> +	u32 cr_val;
> +	u32 magic;
> +	u32 err_cnt;
> +};
> +
> +/* IO accessors */
> +static inline void xtmr_inject_write(struct xtmr_inject_dev *xtmr_inject,
> +				     u32 addr, u32 value)
> +{
> +	iowrite32(value, xtmr_inject->regs + addr);
> +}
> +
> +static inline u32 xtmr_inject_read(struct xtmr_inject_dev *xtmr_inject,
> +				   u32 addr)
> +{
> +	return ioread32(xtmr_inject->regs + addr);
> +}
> +
> +static ssize_t inject_err_store(struct device *dev,
> +				struct device_attribute *attr, const char *buf,
> +				size_t size)
> +{
> +	int ret;
> +	long value;
> +
> +	ret = kstrtoul(buf, 16, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (value > 1)
> +		return -EINVAL;

That does not match your documentation :(


> +
> +	xmb_inject_err();
> +
> +	return size;
> +}
> +static DEVICE_ATTR_WO(inject_err);
> +
> +static ssize_t inject_cpuid_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t size)
> +{
> +	struct xtmr_inject_dev *xtmr_inject = dev_get_drvdata(dev);
> +	int ret;
> +	long value;
> +
> +	ret = kstrtoul(buf, 0, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (value > 3)
> +		return -EINVAL;

Again, does not match the documentation at all.

confused,

greg k-h
