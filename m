Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E83749F729
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347783AbiA1KTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:19:30 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38144 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346985AbiA1KT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:19:28 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nDOLk-0005uy-4f; Fri, 28 Jan 2022 11:19:24 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     robh@kernel.org, lukasz.luba@arm.com, arnd@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v7 5/5] rockchip/soc/drivers: Add DTPM description for rk3399
Date:   Fri, 28 Jan 2022 11:19:22 +0100
Message-ID: <48865702.Mx8J7aE1p6@diego>
In-Reply-To: <20220125171809.1273269-6-daniel.lezcano@linaro.org>
References: <20220125171809.1273269-1-daniel.lezcano@linaro.org> <20220125171809.1273269-6-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 25. Januar 2022, 18:18:09 CET schrieb Daniel Lezcano:
> The DTPM framework does support now the hierarchy description.
> 
> The platform specific code can call the hierarchy creation function
> with an array of struct dtpm_node pointing to their parent.
> 
> This patch provides a description of the big / Little CPUs and the
> GPU and tie them together under a virtual 'package' name. Only rk3399 is
> described now.
> 
> The description could be extended in the future with the memory
> controller with devfreq.
> 
> The description is always a module and it describes the soft
> dependencies. The userspace has to load the softdeps module in the
> right order.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/soc/rockchip/Kconfig  |  8 +++++
>  drivers/soc/rockchip/Makefile |  1 +
>  drivers/soc/rockchip/dtpm.c   | 59 +++++++++++++++++++++++++++++++++++
>  3 files changed, 68 insertions(+)
>  create mode 100644 drivers/soc/rockchip/dtpm.c
> 
> diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
> index 25eb2c1e31bb..6dc017f02431 100644
> --- a/drivers/soc/rockchip/Kconfig
> +++ b/drivers/soc/rockchip/Kconfig
> @@ -34,4 +34,12 @@ config ROCKCHIP_PM_DOMAINS
>  
>            If unsure, say N.
>  
> +config ROCKCHIP_DTPM
> +	tristate "Rockchip DTPM hierarchy"
> +	depends on DTPM && DRM_PANFROST && m
> +	help
> +	 Describe the hierarchy for the Dynamic Thermal Power
> +	 Management tree on this platform. That will create all the
> +	 power capping capable devices.
> +
>  endif
> diff --git a/drivers/soc/rockchip/Makefile b/drivers/soc/rockchip/Makefile
> index 875032f7344e..05f31a4e743c 100644
> --- a/drivers/soc/rockchip/Makefile
> +++ b/drivers/soc/rockchip/Makefile
> @@ -5,3 +5,4 @@
>  obj-$(CONFIG_ROCKCHIP_GRF) += grf.o
>  obj-$(CONFIG_ROCKCHIP_IODOMAIN) += io-domain.o
>  obj-$(CONFIG_ROCKCHIP_PM_DOMAINS) += pm_domains.o
> +obj-$(CONFIG_ROCKCHIP_DTPM) += dtpm.o
> diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
> new file mode 100644
> index 000000000000..0b73a9cba954
> --- /dev/null
> +++ b/drivers/soc/rockchip/dtpm.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2021 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * DTPM hierarchy description
> + */
> +#include <linux/dtpm.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +static struct dtpm_node __initdata rk3399_hierarchy[] = {

The driver is tristate so buildable as module but uses __initdata.
As it depends on panfrost (which also can be a module) you
probably want a "__initdata_or_module" here .


> +	[0]{ .name = "rk3399",
> +	     .type = DTPM_NODE_VIRTUAL },
> +	[1]{ .name = "package",
> +	     .type = DTPM_NODE_VIRTUAL,
> +	     .parent = &rk3399_hierarchy[0] },
> +	[2]{ .name = "/cpus/cpu@0",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &rk3399_hierarchy[1] },
> +	[3]{ .name = "/cpus/cpu@1",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &rk3399_hierarchy[1] },
> +	[4]{ .name = "/cpus/cpu@2",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &rk3399_hierarchy[1] },
> +	[5]{ .name = "/cpus/cpu@3",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &rk3399_hierarchy[1] },
> +	[6]{ .name = "/cpus/cpu@100",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &rk3399_hierarchy[1] },
> +	[7]{ .name = "/cpus/cpu@101",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &rk3399_hierarchy[1] },
> +	[8]{ .name = "/gpu@ff9a0000",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &rk3399_hierarchy[1] },
> +	[9]{ },

hmm, do we want a "/* sentinel */" inside the empty last entry?
I think that is pretty common to denote the "this one is the last entry"
of a dynamic list ;-)

> +};
> +
> +static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
> +        { .compatible = "rockchip,rk3399", .data = rk3399_hierarchy },
> +        {},
> +};
> +
> +static int __init rockchip_dtpm_init(void)
> +{
> +	return dtpm_create_hierarchy(rockchip_dtpm_match_table);
> +}
> +module_init(rockchip_dtpm_init);

Just for my understanding what happens on driver unload?


Thanks
Heiko

> +
> +MODULE_SOFTDEP("pre: panfrost cpufreq-dt");
> +MODULE_DESCRIPTION("Rockchip DTPM driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:dtpm");
> +MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@kernel.org");
> 




