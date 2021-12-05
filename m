Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD39A468C40
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 17:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhLERAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:00:37 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56762
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236114AbhLERAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:00:36 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 53A4E3F1EF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 16:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638723428;
        bh=nSLKlIsCiPB42ckUpSHy4pa9flxMtR9ISD15kq5k0zw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=wObLa1Z9dtJmS0BrAYQGwqGIx2krmbs2R/7nJt+Ut93juJMvFfl92joYnYZNCo+AE
         9bKG9nkO6jRn0IvRZquly4TI38ck4X3dTzf4EskxOzXqV0p8oTOk6zZspOO7mcZpt8
         kDbP6nqZ4pDHaeEf2gfvBtSzLq3lOALMsGs9uSTb71FocRRAwYwW2AUpnRmICn0SUi
         JFnSJOKd+MPFciFQB7Sr3pq9yo9SjlliPl6jG5nxTQGfRzI865QkYzU2/WSlggak1e
         xOKPPRy8fd0qod7783ndDAXsEkrSa4nA5qNOK5flx+QkFfzOu2uIFquoaYJQ6QWC1/
         5pylpf71u68KA==
Received: by mail-lj1-f200.google.com with SMTP id 2-20020a2e0902000000b00218c22336abso2938674ljj.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 08:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nSLKlIsCiPB42ckUpSHy4pa9flxMtR9ISD15kq5k0zw=;
        b=DIynFhXOLKhhAjGZS+TJ8PKybd/QXk8y2VRk+NdDpPrUu427D+14EYzsgeTxrn0S0U
         IDS9RiJdfYm/5Tj6WBCAfSQz8oo6E+AgbYN5j4mr4Yh174+iD4R3ficCyMnvIukGjwLE
         uNgSvbqMmxKIPQqpGOUYN3KcoScEQajgXV2aTVY1zlToydxU+Rz4BxVIUIDuMSlYDKsI
         GLksASm914xVFsxHchlIyleDqGCCMLiLx0/JLxl/C1gNBWXMpSkyEwXcx5NewKVaEwpZ
         z/4LG4YWpI1qtYZi5gcfa2CJNz8nltRxsXswA0Lex7QYXxyO/FrK79DHRaZUW3OR0OqR
         tcOg==
X-Gm-Message-State: AOAM53345xGGDGLEhJsAxp9hf7qwsiXYVnjygVNxBlUl4P7Sud8ZH4/D
        MuIavNkKaZ4zdc0lgd+SDJ42QUPrh/9MwIc0MT3laKm5Fvy9bhNUpxvBY4GmnuEfbEKElq428xw
        F7T6EEoLDJVhEJSSzNxSgqsbTSZoM/a76/KAb7kS2JQ==
X-Received: by 2002:a05:651c:1411:: with SMTP id u17mr30781239lje.483.1638723427208;
        Sun, 05 Dec 2021 08:57:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQ00TJdes4mjN9ik7dFbBvXF8Oz+ThyEv0Bpp/XOTHSh59puJh3JzjeswV38YgZSFM8Mwq6A==
X-Received: by 2002:a05:651c:1411:: with SMTP id u17mr30781214lje.483.1638723426928;
        Sun, 05 Dec 2021 08:57:06 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id q26sm1117465lfa.203.2021.12.05.08.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Dec 2021 08:57:06 -0800 (PST)
Message-ID: <8518adaf-fa07-c17a-5618-5c0359cf5bff@canonical.com>
Date:   Sun, 5 Dec 2021 17:57:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 4/6] clk: samsung: Add initial Exynos7885 clock driver
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20211205153302.76418-1-virag.david003@gmail.com>
 <20211205153302.76418-5-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211205153302.76418-5-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2021 16:32, David Virag wrote:
> This is an initial implementation adding basic clocks, such as UART,
> USI, I2C, WDT, ect. and their parent clocks. It is heavily based on the
> Exynos850 clock driver at 'drivers/clk/samsung/clk-exynos850.c' which
> was made by Sam Protsenko, thus the copyright and author lines were
> kept.
> 
> Bus clocks are enabled by default as well to avoid hangs while trying to
> access CMU registers.
> 
> Only the parts of CMU_TOP needed for CMU_CORE and CMU_PERI, a bit of
> CMU_CORE, and most of CMU_PERI is implemented as of now.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
>  drivers/clk/samsung/Makefile         |   1 +
>  drivers/clk/samsung/clk-exynos7885.c | 680 +++++++++++++++++++++++++++
>  2 files changed, 681 insertions(+)
>  create mode 100644 drivers/clk/samsung/clk-exynos7885.c
> 
> diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
> index c46cf11e4d0b..149258b232a9 100644
> --- a/drivers/clk/samsung/Makefile
> +++ b/drivers/clk/samsung/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_EXYNOS_AUDSS_CLK_CON) += clk-exynos-audss.o
>  obj-$(CONFIG_EXYNOS_CLKOUT)	+= clk-exynos-clkout.o
>  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos7.o
>  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos850.o
> +obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos7885.o
>  obj-$(CONFIG_S3C2410_COMMON_CLK)+= clk-s3c2410.o
>  obj-$(CONFIG_S3C2410_COMMON_DCLK)+= clk-s3c2410-dclk.o
>  obj-$(CONFIG_S3C2412_COMMON_CLK)+= clk-s3c2412.o
> diff --git a/drivers/clk/samsung/clk-exynos7885.c b/drivers/clk/samsung/clk-exynos7885.c
> new file mode 100644
> index 000000000000..088f36e64609
> --- /dev/null
> +++ b/drivers/clk/samsung/clk-exynos7885.c
> @@ -0,0 +1,680 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 Linaro Ltd.
> + * Copyright (C) 2021 Dávid Virág <virag.david003@gmail.com>
> + * Author: Sam Protsenko <semen.protsenko@linaro.org>
> + * Author: Dávid Virág <virag.david003@gmail.com>
> + *
> + * Common Clock Framework support for Exynos7885 SoC.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/clock/exynos7885.h>
> +
> +#include "clk.h"
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
> + * exynos7885_init_clocks - Set clocks initial configuration
> + * @np:			CMU device tree node with "reg" property (CMU addr)
> + * @reg_offs:		Register offsets array for clocks to init
> + * @reg_offs_len:	Number of register offsets in reg_offs array
> + *
> + * Set manual control mode for all gate clocks.
> + */
> +static void __init exynos7885_init_clocks(struct device_node *np,
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
> + * exynos7885_register_cmu - Register specified Exynos7885 CMU domain
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
> +static void __init exynos7885_register_cmu(struct device *dev,
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
> +	exynos7885_init_clocks(np, cmu->clk_regs, cmu->nr_clk_regs);
> +	samsung_cmu_register_one(np, cmu);
> +}

All this looks exactly the same as Exynos850, so this should be shared.
Could be a new file - clk-exynos-arm64.c

> +
> +/* ---- CMU_TOP ------------------------------------------------------------- */
> +
> +/* Register Offset definitions for CMU_TOP (0x12060000) */
> +#define PLL_LOCKTIME_PLL_SHARED0		0x0000
> +#define PLL_LOCKTIME_PLL_SHARED1		0x0004
> +#define PLL_CON0_PLL_SHARED0			0x0100
> +#define PLL_CON0_PLL_SHARED1			0x0120
> +#define CLK_CON_MUX_MUX_CLKCMU_CORE_BUS		0x1014
> +#define CLK_CON_MUX_MUX_CLKCMU_CORE_CCI		0x1018
> +#define CLK_CON_MUX_MUX_CLKCMU_CORE_G3D		0x101c
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_BUS		0x1058
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_SPI0	0x105c
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_SPI1	0x1060
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_UART0	0x1064
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_UART1	0x1068
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_UART2	0x106c
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_USI0	0x1070
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_USI1	0x1074
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_USI2	0x1078
> +#define CLK_CON_DIV_CLKCMU_CORE_BUS		0x181c
> +#define CLK_CON_DIV_CLKCMU_CORE_CCI		0x1820
> +#define CLK_CON_DIV_CLKCMU_CORE_G3D		0x1824
> +#define CLK_CON_DIV_CLKCMU_PERI_BUS		0x1874
> +#define CLK_CON_DIV_CLKCMU_PERI_SPI0		0x1878
> +#define CLK_CON_DIV_CLKCMU_PERI_SPI1		0x187c
> +#define CLK_CON_DIV_CLKCMU_PERI_UART0		0x1880
> +#define CLK_CON_DIV_CLKCMU_PERI_UART1		0x1884
> +#define CLK_CON_DIV_CLKCMU_PERI_UART2		0x1888
> +#define CLK_CON_DIV_CLKCMU_PERI_USI0		0x188c
> +#define CLK_CON_DIV_CLKCMU_PERI_USI1		0x1890
> +#define CLK_CON_DIV_CLKCMU_PERI_USI2		0x1894
> +#define CLK_CON_DIV_PLL_SHARED0_DIV2		0x189c
> +#define CLK_CON_DIV_PLL_SHARED0_DIV3		0x18a0
> +#define CLK_CON_DIV_PLL_SHARED0_DIV4		0x18a4
> +#define CLK_CON_DIV_PLL_SHARED0_DIV5		0x18a8
> +#define CLK_CON_DIV_PLL_SHARED1_DIV2		0x18ac
> +#define CLK_CON_DIV_PLL_SHARED1_DIV3		0x18b0
> +#define CLK_CON_DIV_PLL_SHARED1_DIV4		0x18b4
> +#define CLK_CON_GAT_GATE_CLKCMUC_PERI_UART1	0x2004
> +#define CLK_CON_GAT_GATE_CLKCMU_CORE_BUS	0x201c
> +#define CLK_CON_GAT_GATE_CLKCMU_CORE_CCI	0x2020
> +#define CLK_CON_GAT_GATE_CLKCMU_CORE_G3D	0x2024
> +#define CLK_CON_GAT_GATE_CLKCMU_PERI_BUS	0x207c
> +#define CLK_CON_GAT_GATE_CLKCMU_PERI_SPI0	0x2080
> +#define CLK_CON_GAT_GATE_CLKCMU_PERI_SPI1	0x2084
> +#define CLK_CON_GAT_GATE_CLKCMU_PERI_UART0	0x2088
> +#define CLK_CON_GAT_GATE_CLKCMU_PERI_UART2	0x208c
> +#define CLK_CON_GAT_GATE_CLKCMU_PERI_USI0	0x2090
> +#define CLK_CON_GAT_GATE_CLKCMU_PERI_USI1	0x2094
> +#define CLK_CON_GAT_GATE_CLKCMU_PERI_USI2	0x2098
> +
> +static const unsigned long top_clk_regs[] __initconst = {
> +	PLL_LOCKTIME_PLL_SHARED0,
> +	PLL_LOCKTIME_PLL_SHARED1,
> +	PLL_CON0_PLL_SHARED0,
> +	PLL_CON0_PLL_SHARED1,
> +	CLK_CON_MUX_MUX_CLKCMU_CORE_BUS,
> +	CLK_CON_MUX_MUX_CLKCMU_CORE_CCI,
> +	CLK_CON_MUX_MUX_CLKCMU_CORE_G3D,
> +	CLK_CON_MUX_MUX_CLKCMU_PERI_BUS,
> +	CLK_CON_MUX_MUX_CLKCMU_PERI_SPI0,
> +	CLK_CON_MUX_MUX_CLKCMU_PERI_SPI1,
> +	CLK_CON_MUX_MUX_CLKCMU_PERI_UART0,
> +	CLK_CON_MUX_MUX_CLKCMU_PERI_UART1,
> +	CLK_CON_MUX_MUX_CLKCMU_PERI_UART2,
> +	CLK_CON_MUX_MUX_CLKCMU_PERI_USI0,
> +	CLK_CON_MUX_MUX_CLKCMU_PERI_USI1,
> +	CLK_CON_MUX_MUX_CLKCMU_PERI_USI2,
> +	CLK_CON_DIV_CLKCMU_CORE_BUS,
> +	CLK_CON_DIV_CLKCMU_CORE_CCI,
> +	CLK_CON_DIV_CLKCMU_CORE_G3D,
> +	CLK_CON_DIV_CLKCMU_PERI_BUS,
> +	CLK_CON_DIV_CLKCMU_PERI_SPI0,
> +	CLK_CON_DIV_CLKCMU_PERI_SPI1,
> +	CLK_CON_DIV_CLKCMU_PERI_UART0,
> +	CLK_CON_DIV_CLKCMU_PERI_UART1,
> +	CLK_CON_DIV_CLKCMU_PERI_UART2,
> +	CLK_CON_DIV_CLKCMU_PERI_USI0,
> +	CLK_CON_DIV_CLKCMU_PERI_USI1,
> +	CLK_CON_DIV_CLKCMU_PERI_USI2,
> +	CLK_CON_DIV_PLL_SHARED0_DIV2,
> +	CLK_CON_DIV_PLL_SHARED0_DIV3,
> +	CLK_CON_DIV_PLL_SHARED0_DIV4,
> +	CLK_CON_DIV_PLL_SHARED0_DIV5,
> +	CLK_CON_DIV_PLL_SHARED1_DIV2,
> +	CLK_CON_DIV_PLL_SHARED1_DIV3,
> +	CLK_CON_DIV_PLL_SHARED1_DIV4,
> +	CLK_CON_GAT_GATE_CLKCMUC_PERI_UART1,
> +	CLK_CON_GAT_GATE_CLKCMU_CORE_BUS,
> +	CLK_CON_GAT_GATE_CLKCMU_CORE_CCI,
> +	CLK_CON_GAT_GATE_CLKCMU_CORE_G3D,
> +	CLK_CON_GAT_GATE_CLKCMU_PERI_BUS,
> +	CLK_CON_GAT_GATE_CLKCMU_PERI_SPI0,
> +	CLK_CON_GAT_GATE_CLKCMU_PERI_SPI1,
> +	CLK_CON_GAT_GATE_CLKCMU_PERI_UART0,
> +	CLK_CON_GAT_GATE_CLKCMU_PERI_UART2,
> +	CLK_CON_GAT_GATE_CLKCMU_PERI_USI0,
> +	CLK_CON_GAT_GATE_CLKCMU_PERI_USI1,
> +	CLK_CON_GAT_GATE_CLKCMU_PERI_USI2,
> +};
> +
> +static const struct samsung_pll_clock top_pll_clks[] __initconst = {
> +	PLL(pll_1417x, CLK_FOUT_SHARED0_PLL, "fout_shared0_pll", "oscclk",
> +	    PLL_LOCKTIME_PLL_SHARED0, PLL_CON0_PLL_SHARED0,
> +	    NULL),
> +	PLL(pll_1417x, CLK_FOUT_SHARED1_PLL, "fout_shared1_pll", "oscclk",
> +	    PLL_LOCKTIME_PLL_SHARED1, PLL_CON0_PLL_SHARED1,
> +	    NULL),
> +};
> +
> +/* List of parent clocks for Muxes in CMU_TOP: for CMU_CORE */
> +PNAME(mout_core_bus_p)		= { "dout_shared0_div2", "dout_shared1_div2",
> +				    "dout_shared0_div3", "dout_shared0_div3" };
> +PNAME(mout_core_cci_p)		= { "dout_shared0_div2", "dout_shared1_div2",
> +				    "dout_shared0_div3", "dout_shared0_div3" };
> +PNAME(mout_core_g3d_p)		= { "dout_shared0_div2", "dout_shared1_div2",
> +				    "dout_shared0_div3", "dout_shared0_div3" };
> +
> +/* List of parent clocks for Muxes in CMU_TOP: for CMU_PERI */
> +PNAME(mout_peri_bus_p)		= { "dout_shared0_div4", "dout_shared1_div4" };
> +PNAME(mout_peri_spi0_p)		= { "oscclk", "dout_shared0_div4" };
> +PNAME(mout_peri_spi1_p)		= { "oscclk", "dout_shared0_div4" };
> +PNAME(mout_peri_uart0_p)	= { "oscclk", "dout_shared0_div4" };
> +PNAME(mout_peri_uart1_p)	= { "oscclk", "dout_shared0_div4" };
> +PNAME(mout_peri_uart2_p)	= { "oscclk", "dout_shared0_div4" };
> +PNAME(mout_peri_usi0_p)		= { "oscclk", "dout_shared0_div4" };
> +PNAME(mout_peri_usi1_p)		= { "oscclk", "dout_shared0_div4" };
> +PNAME(mout_peri_usi2_p)		= { "oscclk", "dout_shared0_div4" };
> +
> +

No need for double line break.


Best regards,
Krzysztof
