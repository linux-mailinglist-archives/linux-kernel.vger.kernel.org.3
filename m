Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B24F469146
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbhLFIRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:17:30 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37308
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238917AbhLFIR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:17:28 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 957243F1F3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638778438;
        bh=t/aPWlA/YyYn9aOnNkofK6XfIQNEgCB7YClWLI6auOI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=YpMkjrDCCGdYJIeR5PgVBA03tGvUSRwyKU4ADX7IrifMJ8DpM/sazaD2QWB+49tFW
         CVWX+l/+Tt17IE/AEI7aBDGaj/5ENveTzwSBtZCBTMQ0X/XDr9x+vmnRv3e3fIFq1Q
         x4C+0kcHQJ2PNfrnt3aJer+MQ/M+JLKVjgHB4YgU9kNVYvvxQjWlOP+Dtxo/WBHTzw
         2FE1Vn9SRT/jXch3M8mIMInZ0WpocULW6QvgtF1PkFpvIrxxCqjkWx4lfTC9+B/ISz
         EeKcPocruhh+T14ACI1Ymmu29zAmPuR26eICeO+kgRe7jb0aIUVSErnFBmqlkX+jhJ
         gUIF/d/Ah1jGw==
Received: by mail-lj1-f197.google.com with SMTP id 83-20020a2e0556000000b00218db3260bdso3148808ljf.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 00:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t/aPWlA/YyYn9aOnNkofK6XfIQNEgCB7YClWLI6auOI=;
        b=3PP//mSUmXRh7lvrGtJEZtaXOsYFilaIuz03JHTz9sMTM/jldBskM2cvMpz4zSULfz
         U78ZkLvC8nzjEtGT2TDf6tYlQ+mw+8767l83KJM2k7J+lLQBGDPuiwWPYAEzzfatn+b1
         kXY2jXjxDhP8KkMnUcswBOWZSuc65rv0oRTyuFQmuLP3wGjkxIHOWXPCeGzAdS9A6pWs
         nsPdI3/XEjtuHcMQz7ApRlovUNcnt3KeHgGWUywc47ONneAzhcgv0uosfkgOkzwb1juF
         z0iM68DmRxU9u+0SGQKPQMDtZgKTNBhwW0WCj48oszAspUQZdkjpN22JfIJ2TUcfXQ5X
         Vuxg==
X-Gm-Message-State: AOAM532snwYzf+iWyGS+qhV/905F6JM7lOFdKenkkrxqbdd39cThMAaD
        BsTtAtbBQF4bAFn8LekGWQjr7weenr1UXfR0kdb+iKpexYvLNVBi0p1RkiSbfO1wmN8xm6NTB9L
        q0kL5S7clkKKFkzuogV/9+v98phnHIYrgHW9kOc/N/g==
X-Received: by 2002:a05:6512:3c9f:: with SMTP id h31mr1693044lfv.253.1638778437932;
        Mon, 06 Dec 2021 00:13:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfYhg6MzsZl4yJB8DkgkM9iSdo4mYkhe3GJVNvCnUZSFJM203cw7Eq81EOjgNwL0y//AWs5w==
X-Received: by 2002:a05:6512:3c9f:: with SMTP id h31mr1693021lfv.253.1638778437730;
        Mon, 06 Dec 2021 00:13:57 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id l12sm1290291lfe.81.2021.12.06.00.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 00:13:57 -0800 (PST)
Message-ID: <023eb12a-902b-89f6-e1d5-066b86f42e65@canonical.com>
Date:   Mon, 6 Dec 2021 09:13:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 4/7] clk: samsung: Make exynos850_register_cmu shared
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20211205230804.202292-1-virag.david003@gmail.com>
 <20211205230804.202292-5-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211205230804.202292-5-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2021 00:07, David Virag wrote:
> Rename exynos850_register_cmu to exynos_arm64_register_cmu and move it
> to a new file called "clk-exynos-arm64.c".
> 
> This should have no functional changes, but it will allow this code to
> be shared between other arm64 Exynos SoCs, like the Exynos7885 and
> possibly ExynosAuto V9.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - New patch
> 
> Changes in v3:
>   - Fix SPDX comment style in clk-exynos-arm64.h
> 
>  drivers/clk/samsung/Makefile           |  1 +
>  drivers/clk/samsung/clk-exynos-arm64.c | 94 ++++++++++++++++++++++++++
>  drivers/clk/samsung/clk-exynos-arm64.h | 20 ++++++
>  drivers/clk/samsung/clk-exynos850.c    | 94 ++------------------------
>  4 files changed, 119 insertions(+), 90 deletions(-)
>  create mode 100644 drivers/clk/samsung/clk-exynos-arm64.c
>  create mode 100644 drivers/clk/samsung/clk-exynos-arm64.h
> 
> diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
> index c46cf11e4d0b..901e6333c5f0 100644
> --- a/drivers/clk/samsung/Makefile
> +++ b/drivers/clk/samsung/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_EXYNOS_5420_COMMON_CLK)	+= clk-exynos5-subcmu.o
>  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos5433.o
>  obj-$(CONFIG_EXYNOS_AUDSS_CLK_CON) += clk-exynos-audss.o
>  obj-$(CONFIG_EXYNOS_CLKOUT)	+= clk-exynos-clkout.o
> +obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos-arm64.o
>  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos7.o
>  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos850.o
>  obj-$(CONFIG_S3C2410_COMMON_CLK)+= clk-s3c2410.o
> diff --git a/drivers/clk/samsung/clk-exynos-arm64.c b/drivers/clk/samsung/clk-exynos-arm64.c
> new file mode 100644
> index 000000000000..b921b9a1134a
> --- /dev/null
> +++ b/drivers/clk/samsung/clk-exynos-arm64.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 Linaro Ltd.
> + * Copyright (C) 2021 Dávid Virág <virag.david003@gmail.com>
> + * Author: Sam Protsenko <semen.protsenko@linaro.org>
> + * Author: Dávid Virág <virag.david003@gmail.com>
> + *
> + * This file contains shared functions used by some arm64 Exynos SoCs,
> + * such as Exynos7885 or Exynos850 to register and init CMUs.
> + */
> +#include <linux/clk.h>
> +#include <linux/of_address.h>
> +
> +#include "clk-exynos-arm64.h"
> +
> +/* Gate register bits */
> +#define GATE_MANUAL		BIT(20)
> +#define GATE_ENABLE_HWACG	BIT(28)
> +
> +/* Gate register offsets range */
> +#define GATE_OFF_START		0x2000
> +#define GATE_OFF_END		0x2fff
> +
> +/**
> + * exynos_arm64_init_clocks - Set clocks initial configuration
> + * @np:			CMU device tree node with "reg" property (CMU addr)
> + * @reg_offs:		Register offsets array for clocks to init
> + * @reg_offs_len:	Number of register offsets in reg_offs array
> + *
> + * Set manual control mode for all gate clocks.
> + */
> +static void __init exynos_arm64_init_clocks(struct device_node *np,
> +		const unsigned long *reg_offs, size_t reg_offs_len)
> +{
> +	void __iomem *reg_base;
> +	size_t i;
> +
> +	reg_base = of_iomap(np, 0);
> +	if (!reg_base)
> +		panic("%s: failed to map registers\n", __func__);
> +
> +	for (i = 0; i < reg_offs_len; ++i) {
> +		void __iomem *reg = reg_base + reg_offs[i];
> +		u32 val;
> +
> +		/* Modify only gate clock registers */
> +		if (reg_offs[i] < GATE_OFF_START || reg_offs[i] > GATE_OFF_END)
> +			continue;
> +
> +		val = readl(reg);
> +		val |= GATE_MANUAL;
> +		val &= ~GATE_ENABLE_HWACG;
> +		writel(val, reg);
> +	}
> +
> +	iounmap(reg_base);
> +}
> +
> +/**
> + * exynos_arm64_register_cmu - Register specified Exynos CMU domain
> + * @dev:	Device object; may be NULL if this function is not being
> + *		called from platform driver probe function
> + * @np:		CMU device tree node
> + * @cmu:	CMU data
> + *
> + * Register specified CMU domain, which includes next steps:
> + *
> + * 1. Enable parent clock of @cmu CMU
> + * 2. Set initial registers configuration for @cmu CMU clocks
> + * 3. Register @cmu CMU clocks using Samsung clock framework API
> + */
> +void __init exynos_arm64_register_cmu(struct device *dev,
> +		struct device_node *np, const struct samsung_cmu_info *cmu)
> +{
> +	/* Keep CMU parent clock running (needed for CMU registers access) */
> +	if (cmu->clk_name) {
> +		struct clk *parent_clk;
> +
> +		if (dev)
> +			parent_clk = clk_get(dev, cmu->clk_name);
> +		else
> +			parent_clk = of_clk_get_by_name(np, cmu->clk_name);
> +
> +		if (IS_ERR(parent_clk)) {
> +			pr_err("%s: could not find bus clock %s; err = %ld\n",
> +			       __func__, cmu->clk_name, PTR_ERR(parent_clk));
> +		} else {
> +			clk_prepare_enable(parent_clk);
> +		}
> +	}
> +
> +	exynos_arm64_init_clocks(np, cmu->clk_regs, cmu->nr_clk_regs);
> +	samsung_cmu_register_one(np, cmu);
> +}
> diff --git a/drivers/clk/samsung/clk-exynos-arm64.h b/drivers/clk/samsung/clk-exynos-arm64.h
> new file mode 100644
> index 000000000000..184ca79ea649
> --- /dev/null
> +++ b/drivers/clk/samsung/clk-exynos-arm64.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 Linaro Ltd.
> + * Copyright (C) 2021 Dávid Virág <virag.david003@gmail.com>
> + * Author: Sam Protsenko <semen.protsenko@linaro.org>
> + * Author: Dávid Virág <virag.david003@gmail.com>
> + *
> + * This file contains shared functions used by some arm64 Exynos SoCs,
> + * such as Exynos7885 or Exynos850 to register and init CMUs.
> + */
> +
> +#ifndef __SAMSUNG_CLK_ARM64_H
> +#define __SAMSUNG_CLK_ARM64_H
> +
> +#include "clk.h"
> +
> +void exynos_arm64_register_cmu(struct device *dev,
> +		struct device_node *np, const struct samsung_cmu_info *cmu);
> +
> +#endif /* __CLK_EXYNOS_ARM64_H */
> diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
> index 568ac97c8120..3cc85b64cbff 100644
> --- a/drivers/clk/samsung/clk-exynos850.c
> +++ b/drivers/clk/samsung/clk-exynos850.c
> @@ -6,96 +6,10 @@
>   * Common Clock Framework support for Exynos850 SoC.
>   */
>  
> -#include <linux/clk.h>
> -#include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
>  #include <linux/of_device.h>
> -#include <linux/platform_device.h>

I missed that part and gave review tag too fast.  All headers which are
used here directly, should stay. You use here clk.h, clk-provider.h,
of.h, of_device.h and platform device, so all headers must stay.


Best regards,
Krzysztof
