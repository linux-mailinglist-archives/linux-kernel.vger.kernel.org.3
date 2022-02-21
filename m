Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA14BE18C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355701AbiBULRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:17:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355585AbiBULPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:15:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F27A42DD1;
        Mon, 21 Feb 2022 02:52:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88698150C;
        Mon, 21 Feb 2022 02:52:42 -0800 (PST)
Received: from bogus (unknown [10.57.3.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D52D83F66F;
        Mon, 21 Feb 2022 02:52:40 -0800 (PST)
Date:   Mon, 21 Feb 2022 10:51:51 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Edwin Chiu <edwinchiu0505tw@gmail.com>
Cc:     edwin.chiu@sunplus.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Message-ID: <20220221105151.6rvyoqyvj6ehhtnj@bogus>
References: <cover.1645427180.git.edwinchiu0505tw@gmail.com>
 <1628e048220f066204b8ac27f3cedf7f3cc02963.1645427180.git.edwinchiu0505tw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628e048220f066204b8ac27f3cedf7f3cc02963.1645427180.git.edwinchiu0505tw@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 03:26:18PM +0800, Edwin Chiu wrote:
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
>    Just wanting a different driver is not a reason
>    for a duplicate schema.
>    So remove yaml file and submit driver again.
> Changes in v5
>  - According Krzysztof's comment
>    You either use appropriate compatible in DT
>    or add your compatible to cpuidle-arm.
>    Even if this did not work, then the solution is to
>    use common parts, not to duplicate entire driver.
>    According Sudeep's comment
>    In short NACK for any dedicated driver for this platform,
>    use the generic cpuidle-arm driver with appropriate platform hooks
>    Create cpuidle-sunplus.c in arch/arm/mach-sunplus/
>    for hook generic cpuidle-arm driver
> 
>  MAINTAINERS                                   |  6 ++
>  arch/arm/mach-sunplus/cpuidle-sunplus.c       | 88 +++++++++++++++++
>  include/linux/platform_data/cpuidle-sunplus.h | 12 ++++
>  3 files changed, 106 insertions(+)
>  create mode 100644 arch/arm/mach-sunplus/cpuidle-sunplus.c
>  create mode 100644 include/linux/platform_data/cpuidle-sunplus.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0dca8f..5c96428 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18252,6 +18252,12 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
> +SUNPLUS CPUIDLE DRIVER
> +M:	Edwin Chiu <edwinchiu0505tw@gmail.com>
> +S:	Maintained
> +F:	arch/arm/mach-sunplus/cpuidle-sunplus.c
> +F:	include/linux/platform_data/cpuidle-sunplus.h
> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>
> diff --git a/arch/arm/mach-sunplus/cpuidle-sunplus.c b/arch/arm/mach-sunplus/cpuidle-sunplus.c
> new file mode 100644
> index 0000000..e9d9738
> --- /dev/null
> +++ b/arch/arm/mach-sunplus/cpuidle-sunplus.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SP7021 cpu idle Driver.
> + * Copyright (C) Sunplus Tech / Tibbo Tech.
> + */
> +#define pr_fmt(fmt) "CPUidle arm: " fmt
> +
> +#include <linux/cpuidle.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_data/cpuidle-sunplus.h>
> +
> +#include <asm/cpuidle.h>
> +
> +typedef int (*idle_fn)(void);
> +
> +static DEFINE_PER_CPU(idle_fn*, sp7021_idle_ops);
> +
> +static int sp7021_cpuidle_enter(unsigned long index)
> +{
> +	return __this_cpu_read(sp7021_idle_ops)[index]();
> +}
> +static int sp7021_cpu_spc(void)
> +{
> +	cpu_v7_do_idle();   /* idle to WFI */
> +	return 0;
> +}

You really don't need a cpuidle driver to just WFI for any states.
Add the driver when you have something non WFI in the suspend function.

> +static const struct of_device_id sp7021_idle_state_match[] = {
> +	{ .compatible = "arm,idle-state", .data = sp7021_cpu_spc },
> +	{ },
> +};

This is better than adding new driver like you did in previous version.

I did a quick check but couldn't figure out. How do cpus get switched
ON or OFF on this platform(for example during CPU hotplug) ?

-- 
Regards,
Sudeep
