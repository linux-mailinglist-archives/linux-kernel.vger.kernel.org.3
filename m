Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9111D48D845
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiAMMzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:55:08 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54578
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234771AbiAMMzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:55:07 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2428A4001E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642078506;
        bh=PXcIYZEVRPMHXKWkXgjZM50R+tkU0aMoN3mUJ6g2+cY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=VmiSUgOCW7wPyXPHc22irfKKj9vgIqovg6J+yqnxyUyisqZfhM+yORM7SnJDkMqSj
         NdIs71JEuGQa4xPPpmhsr6rTAe22JgPEafo5NyWNT0HYa3Qu8Oz4ckaj/V3pym9c9D
         yomN7BblFk+/Lfh+h9qUuYnouLPOuzryh37/x0dGnotmGe6C9u1DJ0iVkMYsX2CJdM
         L4wCprzrLhuFmTicFJm1i7FuK0Cq0v2XtVMfpMga0pzETc/MBzwG2k9p8xVtEMhKHG
         SNdWXf+9nCo0r8pJXAtskNx5bOLknvQGW+Gv0C17lC4Ks7JE550f0lzj1kUu/wo5/m
         Lu4u8nD2sVS4w==
Received: by mail-ed1-f70.google.com with SMTP id o20-20020a056402439400b003f83cf1e472so5242908edc.18
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 04:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PXcIYZEVRPMHXKWkXgjZM50R+tkU0aMoN3mUJ6g2+cY=;
        b=6WuaFTYavq2gNNWBfEJi529uybbwUTn+RCzmEwuvodUF4WoTBMYp114W6D1OVxyWVs
         ttTZX7p/OnhRhz8DtTGMzh6eu7sZ0Nam5hyK2bm5h1fTPWUZpxUcZbkfCd87hBSR0Q4z
         C1M47hjfDLwktg8h/eBjGPcCHQghyxpYYtMVBGgGDzSRz7CtOWGfKmwTlVQWkjFJErUD
         Yz3HE+e2qE6rwsGdV8X6FdV0VXi8aDTfb1tbpofiaJ9p6IDU0pA0qn3OrAKz51Wrq5CU
         HLfE8buFgSegIPEwBXJGK4DTAcmgsgYp0wJtjXWUfKNSmDZU3Wn2fnBB4hzCal3wB1Wf
         QcIQ==
X-Gm-Message-State: AOAM532DgNBQirMkTdbXC7YVrSqwoecye4KNQITmZKzOpkeAB6Dwbgcf
        ngac35oFJTvmO9gYvLEAbFZPD7k1qhnpF6U3sYp+qaboj+1TAOFYtLD1ko1aVCWjDazHPCQcTUI
        0dnY6cWrj3mZ26Z86df0iZTph9dCrq7JKjqH9WTinBg==
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr3562348ejc.275.1642078505599;
        Thu, 13 Jan 2022 04:55:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/PYHSMLu1FwH6kqjx8H1obDsFC+1nj4fmqsLiCntlQc4FNn1c4c8k0043PmwcL4VmrIyrgw==
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr3562334ejc.275.1642078505371;
        Thu, 13 Jan 2022 04:55:05 -0800 (PST)
Received: from [192.168.0.29] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id jg41sm869622ejc.101.2022.01.13.04.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 04:55:04 -0800 (PST)
Message-ID: <1b246ad6-5b65-a02f-e887-5a07e8f12ec7@canonical.com>
Date:   Thu, 13 Jan 2022 13:55:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 04/23] clk: samsung: fsd: Add cmu_peric block clock
 information
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, Aswani Reddy <aswani.reddy@samsung.com>,
        Niyas Ahmed S T <niyas.ahmed@samsung.com>,
        Chandrasekar R <rcsekar@samsung.com>,
        Jayati Sahu <jayati.sahu@samsung.com>,
        Sriranjani P <sriranjani.p@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
 <CGME20220113122330epcas5p46ae5cd30950b1d9126479231dcf5da49@epcas5p4.samsung.com>
 <20220113121143.22280-5-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220113121143.22280-5-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 13:11, Alim Akhtar wrote:
> This patch adds CMU_PERIC block clock information needed
> for various IPs functions found in this block.

Here and in all other commits, please do not use "This patch". Instead:
https://elixir.bootlin.com/linux/v5.13/source/Documentation/process/submitting-patches.rst#L89

> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
> Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/clk/samsung/clk-fsd.c | 464 +++++++++++++++++++++++++++++++++-
>  1 file changed, 463 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
> index e47523106d9e..6da20966ba99 100644
> --- a/drivers/clk/samsung/clk-fsd.c
> +++ b/drivers/clk/samsung/clk-fsd.c
> @@ -9,12 +9,59 @@
>   *
>   */
>  
> -#include <linux/clk-provider.h>
>  #include <linux/of.h>
> +#include <linux/clk.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>

Please order the includes alphabetically.

>  
>  #include "clk.h"
>  #include <dt-bindings/clock/fsd-clk.h>
>  
> +/* Gate register bits */
> +#define GATE_MANUAL		BIT(20)
> +#define GATE_ENABLE_HWACG	BIT(28)
> +
> +/* Gate register offsets range */
> +#define GATE_OFF_START		0x2000
> +#define GATE_OFF_END		0x2fff
> +
> +/**
> + * fsd_init_clocks - Set clocks initial configuration
> + * @np:			CMU device tree node with "reg" property (CMU addr)
> + * @reg_offs:		Register offsets array for clocks to init
> + * @reg_offs_len:	Number of register offsets in reg_offs array
> + *
> + * Set manual control mode for all gate clocks.
> + */
> +static void __init fsd_init_clocks(struct device_node *np,
> +		const unsigned long *reg_offs, size_t reg_offs_len)

The same as exynos_arm64_init_clocks - please re-use instead of duplicating.

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

(...)

> +/**
> + * fsd_cmu_probe - Probe function for FSD platform clocks
> + * @pdev: Pointer to platform device
> + *
> + * Configure clock hierarchy for clock domains of FSD platform
> + */
> +static int __init fsd_cmu_probe(struct platform_device *pdev)
> +{
> +	const struct samsung_cmu_info *info;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +
> +	info = of_device_get_match_data(dev);
> +	fsd_init_clocks(np, info->clk_regs, info->nr_clk_regs);
> +	samsung_cmu_register_one(np, info);
> +
> +	/* Keep bus clock running, so it's possible to access CMU registers */
> +	if (info->clk_name) {
> +		struct clk *bus_clk;
> +
> +		bus_clk = clk_get(dev, info->clk_name);
> +		if (IS_ERR(bus_clk)) {
> +			pr_err("%s: could not find bus clock %s; err = %ld\n",
> +			       __func__, info->clk_name, PTR_ERR(bus_clk));
> +		} else {
> +			clk_prepare_enable(bus_clk);
> +		}
> +	}
> +
> +	return 0;
> +}

Please re-use exynos_arm64_register_cmu(). This will also solve my
previous comment about exynos_arm64_init_clocks().

> +
> +/* CMUs which belong to Power Domains and need runtime PM to be implemented */
> +static const struct of_device_id fsd_cmu_of_match[] = {
> +	{
> +		.compatible = "tesla,fsd-clock-peric",
> +		.data = &peric_cmu_info,
> +	}, {
> +	},
> +};
> +
> +static struct platform_driver fsd_cmu_driver __refdata = {
> +	.driver	= {
> +		.name = "fsd-cmu",
> +		.of_match_table = fsd_cmu_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = fsd_cmu_probe,
> +};
> +
> +static int __init fsd_cmu_init(void)
> +{
> +	return platform_driver_register(&fsd_cmu_driver);
> +}
> +core_initcall(fsd_cmu_init);
> 


Best regards,
Krzysztof
