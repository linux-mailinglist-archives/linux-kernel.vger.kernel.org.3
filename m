Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830944ACA69
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242447AbiBGU1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242771AbiBGUVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:21:45 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C54EC0401E1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 12:21:44 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 07E483F1D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 20:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644265303;
        bh=mLspqjX0Lft2tr0TmPEsp3zZT5X5x66kwxd+5Lj4EV4=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=c07KuxbNoaNquQpXWR6CYIz736CiRAqzSCwpKskQw7ulpZIcIvx6cQsp38s3ZqzyF
         kUf7zONk3E1jzYRtNCK1sI0dcaaa1TmWyekrVo4pGc439tyfHtzXnBLY1dpXVnoNR9
         Kfj8YJnOqOB/jSjT/dHwok/MO6uHOUVSJY0HrSWTuket4kRbQR7abUg8AYe81t4gm4
         dzM3c39PMYpHD01a6grqT9nkkvtJLIQpsaapSBeq52IVsMByNH6FaOwepnTiBivLiZ
         J3YiStmmxGewV6S942yxxfJdzYlpelFxDeqHtENd8BXj+2DSAh8piKfPioGfrFtPhE
         0JyGQwRRm/7bg==
Received: by mail-ed1-f72.google.com with SMTP id w15-20020a056402268f00b00408234dc1dfso8442301edd.16
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 12:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mLspqjX0Lft2tr0TmPEsp3zZT5X5x66kwxd+5Lj4EV4=;
        b=VWum8AEd0Nk8Kq9L/N59PVH2NR4IEuf8clzcwRvrMsuXFpNWaMAieKG54hcKqL9puj
         H0RkDG4VTdNYs05Dmi3R4SgQAqzEYdgIjxu9rXOpRc8jeyLlMQEQpx29VlCq0YFNZJDB
         kY2lDO5iDGZRFoevzoL95nasdTzNlEifS0gi9CKbPhiLnwKzVgMCWeS122CIUN6RtZQd
         nh+DFhsvD4iFa84dJ6xQzSDYBU0wYS8DXNHiRYs45TbfRZnKTkmYKeTjJgGqlfZAv7Bn
         iLo+o0OJwIJT3j3pGycv5AWSeVAM0jq5X+kLKbk+GCWQj/1r30qaHS2iQqJTYARuHaqs
         NT9A==
X-Gm-Message-State: AOAM530GztarAjEwp7W+VFZIA+FtUpccGpRbIcv1F6daLpn3rALR/Orv
        bHJ4OjBX6E8ZNAp62OaN9TvLcbS+nmhAQTNvYeoN3VjFAnuakNoxn6RdsEM1/5WECql94J3ewDR
        YNYQBUuvzKBEUkAkUd5ULkKTsZ2l7Nx9FuCF6Y/mQkQ==
X-Received: by 2002:a17:906:1291:: with SMTP id k17mr1041491ejb.451.1644265302517;
        Mon, 07 Feb 2022 12:21:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0kwnfPjxe+eAyvceLWpgxhJo4MLqyV51Bms0aKGMCeupSnVwj7sJw8ojqwojnfHrMwz89pw==
X-Received: by 2002:a17:906:1291:: with SMTP id k17mr1041478ejb.451.1644265302212;
        Mon, 07 Feb 2022 12:21:42 -0800 (PST)
Received: from [192.168.0.91] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id n25sm3991526ejx.92.2022.02.07.12.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 12:21:41 -0800 (PST)
Message-ID: <64f91b1a-93b9-941d-fdfa-271e198e1ab5@canonical.com>
Date:   Mon, 7 Feb 2022 21:21:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Content-Language: en-US
To:     Edwin Chiu <edwinchiu0505tw@gmail.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, edwin.chiu@sunplus.com
References: <cover.1644218105.git.edwinchiu0505tw@gmail.com>
 <957d882222d218b62fe3fb7a069e2f7952afc5be.1644218105.git.edwinchiu0505tw@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <957d882222d218b62fe3fb7a069e2f7952afc5be.1644218105.git.edwinchiu0505tw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2022 09:11, Edwin Chiu wrote:
> Create cpuidle driver for sunplus sp7021 chip
> 
> Signed-off-by: Edwin Chiu <edwinchiu0505tw@gmail.com>
> ---
> Changes in v3
>  - Rearrangement #include sequence
>  - Change remark style to /*~*/
>  - Align author email address to same as sob
>  - Optimal code
> Changes in v4
>  - According Rob Herringrobh's comment
>    There is no need for this binding.
>    Just wanting a different driver is not a reason for a duplicate schema.
>    So remove yaml file and submit driver again.
> 
>  MAINTAINERS                                   |   8 ++
>  drivers/cpuidle/Kconfig.arm                   |   7 ++
>  drivers/cpuidle/Makefile                      |   1 +
>  drivers/cpuidle/cpuidle-sunplus.c             | 167 ++++++++++++++++++++++++++
>  include/linux/platform_data/cpuidle-sunplus.h |  19 +++
>  5 files changed, 202 insertions(+)
>  create mode 100644 drivers/cpuidle/cpuidle-sunplus.c
>  create mode 100644 include/linux/platform_data/cpuidle-sunplus.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0dca8f..a938a58 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18252,6 +18252,14 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
> +SUNPLUS CPUIDLE DRIVER
> +M:	Edwin Chiu <edwinchiu0505tw@gmail.com>
> +S:	Maintained
> +F:	drivers/cpuidle/Kconfig.arm
> +F:	drivers/cpuidle/Makefile

This does not belong here.

> +F:	drivers/cpuidle/cpuidle-sunplus.c
> +F:	include/linux/platform_data/cpuidle-sunplus.h
> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 15d6c46..fd921c5 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -118,3 +118,10 @@ config ARM_QCOM_SPM_CPUIDLE
>  	  The Subsystem Power Manager (SPM) controls low power modes for the
>  	  CPU and L2 cores. It interface with various system drivers to put
>  	  the cores in low power modes.
> +
> +config ARM_SUNPLUS_CPUIDLE
> +	bool "CPU Idle Driver For SUNPLUS SoCs"
> +	depends on !ARM64
> +	select DT_IDLE_STATES
> +	help
> +	  Select this to enable cpuidle on SP7021 processors.
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 26bbc5e..0a020d1 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle-psci.o
>  obj-$(CONFIG_ARM_PSCI_CPUIDLE_DOMAIN)	+= cpuidle-psci-domain.o
>  obj-$(CONFIG_ARM_TEGRA_CPUIDLE)		+= cpuidle-tegra.o
>  obj-$(CONFIG_ARM_QCOM_SPM_CPUIDLE)	+= cpuidle-qcom-spm.o
> +obj-$(CONFIG_ARM_SUNPLUS_CPUIDLE)		+= cpuidle-sunplus.o
>  
>  ###############################################################################
>  # MIPS drivers
> diff --git a/drivers/cpuidle/cpuidle-sunplus.c b/drivers/cpuidle/cpuidle-sunplus.c
> new file mode 100644
> index 0000000..0e7bf43
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-sunplus.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2014,2015, Linaro Ltd.
> + *
> + * SAW power controller driver
> + */
> +#define pr_fmt(fmt) "CPUidle arm: " fmt
> +
> +#include <asm/suspend.h>
> +#include <linux/cpu_cooling.h>
> +#include <linux/cpuidle.h>
> +#include <linux/cpumask.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/platform_data/cpuidle-sunplus.h>
> +
> +#include "dt_idle_states.h"
> +
> +static int sp7021_wfi_finisher(unsigned long flags)
> +{
> +	cpu_v7_do_idle();   /* idle to WFI */
> +
> +	return -1;
> +}
> +
> +static int sp7021_enter_idle_state(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int idx)
> +{
> +	int ret;
> +
> +  /* if idx=0, call cpu_do_idle() */

Wrong indentation.

> +	if (!idx) {
> +		cpu_v7_do_idle();
> +		return idx;
> +	}
> +
> +	/* if idx>0, call cpu_suspend() */
> +	ret = cpu_pm_enter();
> +	if (!ret) {
> +	/*
> +	 * Pass idle state index to cpuidle_suspend which in turn
> +	 * will call the CPU ops suspend protocol with idle index as a
> +	 * parameter.
> +	 */

The same.

> +		ret = cpu_suspend(idx, sp7021_wfi_finisher);
> +	}
> +	cpu_pm_exit();
> +
> +	return ret ? -1:idx;
> +}
> +
> +static struct cpuidle_driver sp7021_idle_driver = {
> +	.name = "sp7021_idle",
> +	.owner = THIS_MODULE,
> +	/*
> +	 * State at index 0 is standby wfi and considered standard
> +	 * on all ARM platforms. If in some platforms simple wfi
> +	 * can't be used as "state 0", DT bindings must be implemented
> +	 * to work around this issue and allow installing a special
> +	 * handler for idle state index 0.
> +	 */
> +	.states[0] = {
> +		.enter                  = sp7021_enter_idle_state,
> +		.exit_latency           = 1,
> +		.target_residency       = 1,
> +		.power_usage		= UINT_MAX,
> +		.name                   = "WFI",
> +		.desc                   = "ARM WFI",

I have impression that there is no point in having custom driver with WFI...

Still the main question from Daniel and Sudeep stays: why do you need
this? You copied exactly cpuildle-arm driver, there is nothing different
here. At least I could not spot differences. Maybe except that you use
cpu_v7_do_idle explicitly.

Unfortunately I cannot understand the explanation here:
https://lore.kernel.org/all/0812c44f777d4026b79df2e3698294be@sphcmbx02.sunplus.com.tw/
Why exactly cpuidle-arm does not work in your case?


> +	}
> +};
> +
> +static const struct of_device_id sp7021_idle_state_match[] = {
> +	{ .compatible = "sunplus,sp7021-idle-state",
> +		.data = sp7021_enter_idle_state },
> +	{ },
> +};
> +
> +/*
> + * sp7021_idle_init - Initializes sp7021 cpuidle driver
> + *
> + * Initializes sp7021 cpuidle driver for all CPUs, if any CPU fails
> + * to register cpuidle driver then rollback to cancel all CPUs
> + * registration.
> + */
> +static int __init sp7021_idle_init(void)
> +{
> +	int cpu, ret;
> +	struct cpuidle_driver *drv;
> +	struct cpuidle_device *dev;
> +
> +	drv = kmemdup(&sp7021_idle_driver, sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
> +	/*
> +	 * Initialize idle states data, starting at index 1.  This
> +	 * driver is DT only, if no DT idle states are detected (ret
> +	 * == 0) let the driver initialization fail accordingly since
> +	 * there is no reason to initialize the idle driver if only
> +	 * wfi is supported.
> +	 */
> +	ret = dt_init_idle_driver(drv, sp7021_idle_state_match, 1);
> +	if (ret <= 0)
> +		return ret ? : -ENODEV;
> +
> +	ret = cpuidle_register_driver(drv);
> +	if (ret) {
> +		pr_err("Failed to register cpuidle driver\n");
> +		return ret;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +		if (!dev) {
> +			ret = -ENOMEM;
> +			goto out_fail;
> +		}
> +		dev->cpu = cpu;
> +
> +		ret = cpuidle_register_device(dev);
> +		if (ret) {
> +			pr_err("Failed to register cpuidle device for CPU %d\n", cpu);
> +			kfree(dev);
> +			goto out_fail;
> +		}
> +	}
> +
> +	return 0;
> +
> +out_fail:
> +	while (--cpu >= 0) {
> +		dev = per_cpu(cpuidle_devices, cpu);
> +		cpuidle_unregister_device(dev);
> +		kfree(dev);
> +	}
> +	cpuidle_unregister_driver(drv);
> +
> +	return ret;
> +}
> +
> +static int __init idle_init(void)
> +{
> +	int ret;
> +
> +	if (of_machine_is_compatible("sunplus,sp7021-achip")) {
> +		sp7021_idle_init();
> +		ret = 0;
> +	}	else
> +		ret = -1;
> +
> +	if (ret) {
> +		pr_err("failed to cpuidle init\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +device_initcall(idle_init);
> +
> +MODULE_AUTHOR("Edwin Chiu <edwinchiu0505tw@gmail.com>");
> +MODULE_DESCRIPTION("Sunplus sp7021 cpuidle driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_data/cpuidle-sunplus.h b/include/linux/platform_data/cpuidle-sunplus.h
> new file mode 100644
> index 0000000..bf87682
> --- /dev/null
> +++ b/include/linux/platform_data/cpuidle-sunplus.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Do not duplicate SPDX.

> + */
> +
> +#ifndef __CPUIDLE_SP7021_H
> +#define __CPUIDLE_SP7021_H
> +
> +struct cpuidle_sp7021_data {
> +	int (*cpu23_powerdown)(void);
> +	void (*pre_enter_aftr)(void);
> +	void (*post_enter_aftr)(void);

Where are these used?

> +};
> +
> +extern int cpu_v7_do_idle(void);> +
> +#endif


Best regards,
Krzysztof
