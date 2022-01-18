Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89ED44923AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbiARKRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:17:20 -0500
Received: from mail-vi1eur05on2066.outbound.protection.outlook.com ([40.107.21.66]:31200
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237058AbiARKRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:17:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7/iLAf3DzVuO3FcdWUWZXOgwt+WmR9QxHISp10X6FMPdb+t/vCJhB5yx9Ir9YPkdCuHZb5kJnnAQ6tJGd/q1v4URZ9h75A8sRyK9DwwIh7nSZnDaq5nBtIiJnq7vZ5ZalPWOeeD3G0FVoJKKEAYp8lZMxLisZ3AuGu7v8HcuJ6igUFd8Fw1MIJmRB0PntEIeOZ4P8BcPuUFxAejNYP/3RWeiN1iowABbP3gYs3dRhImXQ/hDCuHVThEsMjvaKEmOnSyaRH3CTQqdILBhpg2IT6sWSokfs8W+3Urxte0ygc6svAc29SWuUDs1M4eknz0uNasd2hoECS/4srT6n884Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJKwxhVb3LxJlBBsZeUYhi0NQ8IILO3PusRgQf6m2Wo=;
 b=kpoEcWZ2DLuHGg7hjJ9l8jLUPZqeO346lpgC1TkOjKh4cHPcrdpuBB+EBpcgb1kPLmtvGl03JEWz8peu/jbzJ9gY3PMLbrW9iYA1Qtxex86aq0En31cjmKhN48df9Y9C32ih5rWYfQBFtTGs2mAQiTRl1KCbTLwbct0lP06j9zM8y1BGBooadUTmkiTobf5xkF9D2aqr21aw1cKbQCnQ7U0O+4nJQXvXK8NdZQ6z0mfKXN6ptkDH3Pq4aBihwz2YdUMgIXla/icUdc9zrl6vH54Sw/CAi8h3x/YR/xlANNx54RVxwVewiRvwIqetQOkeGnnD2hEtBIQFi09IYHAyQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJKwxhVb3LxJlBBsZeUYhi0NQ8IILO3PusRgQf6m2Wo=;
 b=qNBVixOjHtpDokMnihGGdlVBR7s8+fv0ZZyBfk3nSY916iYHpJPdEta2y1cPf7wlSX2PdXLe4D3CYJJxXxmCYQKygQU2OmV5tx/BrEUTV/1f2qsG+cA+xRpLrxnXJ1naTNX+1NX5pnGGjM1RoqFe4RzwnXZZ7tBc8Rt3BX0/lLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DU0PR04MB9324.eurprd04.prod.outlook.com (2603:10a6:10:357::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 10:17:15 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 10:17:15 +0000
Date:   Tue, 18 Jan 2022 12:17:12 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, ulf.hansson@linaro.org,
        aisheng.dong@nxp.com, stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, adrian.hunter@intel.com,
        jirislaby@kernel.org, giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v8 5/7] clk: imx: Add initial support for i.MXRT1050
 clock driver
Message-ID: <YeaTqBwGxSWzqZqT@abelvesa>
References: <20220111212606.2072669-1-Mr.Bossman075@gmail.com>
 <20220111215415.2075257-1-Mr.Bossman075@gmail.com>
 <20220111215415.2075257-6-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111215415.2075257-6-Mr.Bossman075@gmail.com>
X-ClientProxiedBy: VI1PR06CA0213.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::34) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbfad0f3-eda0-46c6-c37c-08d9da6bb2f5
X-MS-TrafficTypeDiagnostic: DU0PR04MB9324:EE_
X-Microsoft-Antispam-PRVS: <DU0PR04MB932406AE80084B1353CDD302F6589@DU0PR04MB9324.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftc33J2CxwQg9Kn6gvcgvWw+dvQhZLsJ8W5RdElggciIVtxYgdxeh2WK/xcDRxiYtUKSFPbp2M0rAhKGX6rP5sqanil1zdtW70M/wHsqskVFSrZVWiIZ2REa0+SZ4hOMA85z19ix1OIs7yHga6/FLgk/3by3cnNORi/xOojlTsAneKk3PmzkP65BTVnc2MVGEqqPXRL+SfLUIuE9gDvuE7C/ZBIVBc+7Xmdt35iuyJoMp67bJWrU8RPnl35pSJqRL+mASgPXqXTILDFAI+lOrWEeeFdmjOM6MgSksI/lwxS40KDs3EYxrAOAmUSlCbxBC9yUCtLA2B1WjIVwblBswjaTGFQszCETUv/FnUqj9f8+fxexXf6EfmMxjOINcvhlYqkR6bVZMQ0CFPrUv5bRMwNst5TH+qF1a06Pqeo+pgrt7NaPXJ9d26n+i2Q42AyqhvLBTUmSRiv2LyFqCKRAfn4CAFl/izIpJfhWHhl9qB4qXBkQyUq7FNbKAYi1YiKqUzrWnC+IOyvnIga63+CO2FtxSGp2fPVqOEozoPU6q51WyVhWdNB5wQRjC/SovriAR981o5H/4OTPRcG7gfZ0Naiv9JYgbHLbELicNnLFqBanji15sTJZcd7bcIH4Ad1NLjGvptXe1/wnNXotRwtdMoTZW8jPEZG6TimKiZdxtsofW8v1qW4rhlkEZT+cOS6c5Ixwa9uVII7C200M3phyQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(66476007)(66946007)(316002)(66556008)(508600001)(9686003)(6512007)(6486002)(6666004)(53546011)(33716001)(6506007)(26005)(52116002)(86362001)(2906002)(4326008)(44832011)(6916009)(38100700002)(5660300002)(8936002)(186003)(38350700002)(83380400001)(30864003)(7416002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4IQcm/dzUirG+lNaUlNYdR8e2s1AnrbXBlZDNI2Yx8ViKFH1FPKQZmjM3fp4?=
 =?us-ascii?Q?YCvrg9Uq/Gq2Cozd5eNWlM3zH18cneXmCIOZxj5X65kFs88qVD77izEqhUKS?=
 =?us-ascii?Q?xWww1n7j1Nig8vv7ghb2QnxjKT5q+ezmwetMyQGvc2P+I4Nhw6ThcJj9yOvv?=
 =?us-ascii?Q?E0CVgirp6ARbBDeBdX7w4BMSORquCW8sF8FHq5PDv/cdsz0e7+OHZ/UgTgc/?=
 =?us-ascii?Q?fr3t7nmru9Z/SdT7o5sDW8jtuUD9x9uEwFdJPnY5ojlH2KmRCWYhMorsoeI+?=
 =?us-ascii?Q?CAfHq9nXsD0X/o/hiOmoxDUlQWxpkg7qXGgecv4eiyRkcvA04m/mY4DP2xQS?=
 =?us-ascii?Q?QG/QOQ9XWD41sz5BK58lhBvtlq5jU4kU/ordiVXp18IMXx2YEGitnW5wZo9R?=
 =?us-ascii?Q?4DhgeGtUm0zWu1dShHLObJMH5bnAymX4N2lLpJcrshCjo3SOAnrBB7HezQvm?=
 =?us-ascii?Q?8ndXV0MnXRGSCVHVuj/upu4bCSFu01M4G2VIe6452Tz3Dktke/53jAcx+C4r?=
 =?us-ascii?Q?E+/VGCKa2gsaZ/OTtNknOnsZV0XR139wmRjB8sjWm+OvQZ+9NQKcNUH0kpnY?=
 =?us-ascii?Q?rmtQzSoF3Up5KLUU82M91nmX7Hj8dohaiQ5uRjJXNdq9yo3FFEjvaiGmvb/6?=
 =?us-ascii?Q?4p4C5Rfy0WonLCAF5b6f8NOZ56s1I/3V7+ujXdfkK/DEKvuudRHSiTAVTpMr?=
 =?us-ascii?Q?CwyGV5+AeRecQN1T3aHGpKuHatAmYwGwaXGAb5zh0h9Pzy9DguAicPQck1Nj?=
 =?us-ascii?Q?tPqeN7EqWtC86SGSdWxsdBk4rwJXRNVTyLvXTh2cn7Z5JD1feM9YKvq019dJ?=
 =?us-ascii?Q?n9mXHj2mj4+HOpGv9AkpZ41h2x6JPIoSmI3bZhUe2TsjS6ahFxh1iJHHntRv?=
 =?us-ascii?Q?2/cA9FX3LMBSLkF8Y6hZGhizb9xMpko1lGmWkmiOT2bXrsEP9FGx0ukG1o0N?=
 =?us-ascii?Q?6ze5G13dwYrzdSYtlkVmly45zkH6bc+74tILHCifN+Qy5VybWSDAhTNeGrHg?=
 =?us-ascii?Q?XPWdwTv6XO6xBP09zolzb0GP8A+s8LZV6wkov/k8RcNJK3Q2gqvYsg2HDchK?=
 =?us-ascii?Q?36m9gaM5/fryBfj5q6luga4yW4Yo2eqdKXiOuj5LCHxbT6YSL1lW1mSVqOHD?=
 =?us-ascii?Q?gslifHizqtFubqvC+gjMuHNzk6AdEgh9XiMr6QTHWWgNHU5zBLgAz6eGoPgL?=
 =?us-ascii?Q?yq3c/lbczerwkzFdvIvUxnbwRWGDmOWu0Pmxa+xYKdBASUs5IGU/uGoGo6jN?=
 =?us-ascii?Q?3rTrAKEF5zsXNCHXAFYLJuKKDGtw9itxqY3kqozLMTypb9+LEAgzluuCaDvm?=
 =?us-ascii?Q?TyCkukmfwaDqcO9OVEajviZ/OkKdB3PTmN4/e6ppwBxHC5tinpPjf2jMPb4g?=
 =?us-ascii?Q?hbwVHKnSzoV++9P/c8H3WKUDoIs+HGUl5FR/YxL6qgFBdhKRy56jLKdlNmEr?=
 =?us-ascii?Q?moLipYdMY3H7544MbXzsPgpTaM6CqQSbdEYaeQERM33kw7vPj6jHuQZsmArV?=
 =?us-ascii?Q?MpgXVqZr9udvLI1FeNL12wRs0frbz7YYDBHFygu8/1i1MZJ6Q43tVXrEBWmJ?=
 =?us-ascii?Q?32MywPRuu491aKGBLAgxaXzJI4A15i6W1csasGd2RCTM0VcXXweBbu66NuIR?=
 =?us-ascii?Q?5mkOCeIK2cvIoiXAkujSIu4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfad0f3-eda0-46c6-c37c-08d9da6bb2f5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 10:17:14.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thza9URVH/0pzcEi3Che8jsH6vPXjSVwJtPUpjP3ztKD9JGht5bOtZO/Y31J4xjJSRQJc8iUPCB3CjDXljjUyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9324
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-11 16:54:13, Jesse Taube wrote:
> Add clock driver support for i.MXRT1050.
> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> Suggested-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Applied, thanks.

> ---
> V1->V2:
> * Kconfig: Add new line
> * clk-imxrt.c: Remove unused const
> * clk-imxrt.c: Remove set parents
> * clk-imxrt.c: Use fsl,imxrt-anatop for anatop base address
> V2->V3:
> * Remove unused ANATOP_BASE_ADDR
> * Move to hw API
> * Add GPT's own clock
> * Add SEMC clocks to set muxing to CRITICAL
> V3->V4:
> * Rename clk-imxrt.c to clk-imxrt1050.c
> * Rename CONFIG_CLK_IMXRT to CONFIG_CLK_IMXRT1050
> * Make CONFIG_CLK_IMXRT1050 selectable
> V4->V5:
> * Move to platform driver
> V5->V6:
> * Remove "fsl" from platform driver name
> V6->V7:
> * Remove GPT
> * Remove of_match_ptr
> V7->V8:
> * Add help message
> * Change to config to tristate
> * Fix Makefile ordering
> * Remove unused inlcude
> * Remove imxrt_clocks_common_init
> ---
>  drivers/clk/imx/Kconfig         |   7 ++
>  drivers/clk/imx/Makefile        |   1 +
>  drivers/clk/imx/clk-imxrt1050.c | 168 ++++++++++++++++++++++++++++++++
>  3 files changed, 176 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-imxrt1050.c
> 
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index c08edbd04d22..45641b8bdc50 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -105,3 +105,10 @@ config CLK_IMX8ULP
>  	select MXC_CLK
>  	help
>  	    Build the driver for i.MX8ULP CCM Clock Driver
> +
> +config CLK_IMXRT1050
> +	tristate "IMXRT1050 CCM Clock Driver"
> +	depends on SOC_IMXRT
> +	select MXC_CLK
> +	help
> +	    Build the driver for i.MXRT1050 CCM Clock Driver
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index b5e040026dfb..1e13c5cb37d9 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -46,4 +46,5 @@ obj-$(CONFIG_CLK_IMX6SX) += clk-imx6sx.o
>  obj-$(CONFIG_CLK_IMX6UL) += clk-imx6ul.o
>  obj-$(CONFIG_CLK_IMX7D)  += clk-imx7d.o
>  obj-$(CONFIG_CLK_IMX7ULP) += clk-imx7ulp.o
> +obj-$(CONFIG_CLK_IMXRT1050)  += clk-imxrt1050.o
>  obj-$(CONFIG_CLK_VF610)  += clk-vf610.o
> diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
> new file mode 100644
> index 000000000000..9539d35588ee
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imxrt1050.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) 2021
> + * Author(s):
> + * Jesse Taube <Mr.Bossman075@gmail.com>
> + * Giulio Benetti <giulio.benetti@benettiengineering.com>
> + */
> +#include <linux/clk.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/imxrt1050-clock.h>
> +
> +#include "clk.h"
> +
> +static const char * const pll_ref_sels[] = {"osc", "dummy", };
> +static const char * const per_sels[] = {"ipg_pdof", "osc", };
> +static const char * const pll1_bypass_sels[] = {"pll1_arm", "pll1_arm_ref_sel", };
> +static const char * const pll2_bypass_sels[] = {"pll2_sys", "pll2_sys_ref_sel", };
> +static const char * const pll3_bypass_sels[] = {"pll3_usb_otg", "pll3_usb_otg_ref_sel", };
> +static const char * const pll5_bypass_sels[] = {"pll5_video", "pll5_video_ref_sel", };
> +static const char *const pre_periph_sels[] = {
> +	"pll2_sys", "pll2_pfd2_396m", "pll2_pfd0_352m", "arm_podf", };
> +static const char *const periph_sels[] = { "pre_periph_sel", "todo", };
> +static const char *const usdhc_sels[] = { "pll2_pfd2_396m", "pll2_pfd0_352m", };
> +static const char *const lpuart_sels[] = { "pll3_80m", "osc", };
> +static const char *const lcdif_sels[] = {
> +	"pll2_sys", "pll3_pfd3_454_74m", "pll5_video", "pll2_pfd0_352m",
> +	"pll2_pfd1_594m", "pll3_pfd1_664_62m", };
> +static const char *const semc_alt_sels[] = { "pll2_pfd2_396m", "pll3_pfd1_664_62m", };
> +static const char *const semc_sels[] = { "periph_sel", "semc_alt_sel", };
> +
> +static struct clk_hw **hws;
> +static struct clk_hw_onecell_data *clk_hw_data;
> +
> +static int imxrt1050_clocks_probe(struct platform_device *pdev)
> +{
> +	void __iomem *ccm_base;
> +	void __iomem *pll_base;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *anp;
> +	int ret;
> +
> +	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
> +					  IMXRT1050_CLK_END), GFP_KERNEL);
> +	if (WARN_ON(!clk_hw_data))
> +		return -ENOMEM;
> +
> +	clk_hw_data->num = IMXRT1050_CLK_END;
> +	hws = clk_hw_data->hws;
> +
> +	hws[IMXRT1050_CLK_OSC] = imx_obtain_fixed_clk_hw(np, "osc");
> +
> +	anp = of_find_compatible_node(NULL, NULL, "fsl,imxrt-anatop");
> +	pll_base = of_iomap(anp, 0);
> +	of_node_put(anp);
> +	if (WARN_ON(!pll_base))
> +		return -ENOMEM;
> +
> +	/* Anatop clocks */
> +	hws[IMXRT1050_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0UL);
> +
> +	hws[IMXRT1050_CLK_PLL1_REF_SEL] = imx_clk_hw_mux("pll1_arm_ref_sel",
> +		pll_base + 0x0, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +	hws[IMXRT1050_CLK_PLL2_REF_SEL] = imx_clk_hw_mux("pll2_sys_ref_sel",
> +		pll_base + 0x30, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +	hws[IMXRT1050_CLK_PLL3_REF_SEL] = imx_clk_hw_mux("pll3_usb_otg_ref_sel",
> +		pll_base + 0x10, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +	hws[IMXRT1050_CLK_PLL5_REF_SEL] = imx_clk_hw_mux("pll5_video_ref_sel",
> +		pll_base + 0xa0, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +
> +	hws[IMXRT1050_CLK_PLL1_ARM] = imx_clk_hw_pllv3(IMX_PLLV3_SYS, "pll1_arm",
> +		"pll1_arm_ref_sel", pll_base + 0x0, 0x7f);
> +	hws[IMXRT1050_CLK_PLL2_SYS] = imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2_sys",
> +		"pll2_sys_ref_sel", pll_base + 0x30, 0x1);
> +	hws[IMXRT1050_CLK_PLL3_USB_OTG] = imx_clk_hw_pllv3(IMX_PLLV3_USB, "pll3_usb_otg",
> +		"pll3_usb_otg_ref_sel", pll_base + 0x10, 0x1);
> +	hws[IMXRT1050_CLK_PLL5_VIDEO] = imx_clk_hw_pllv3(IMX_PLLV3_AV, "pll5_video",
> +		"pll5_video_ref_sel", pll_base + 0xa0, 0x7f);
> +
> +	/* PLL bypass out */
> +	hws[IMXRT1050_CLK_PLL1_BYPASS] = imx_clk_hw_mux_flags("pll1_bypass", pll_base + 0x0, 16, 1,
> +		pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PARENT);
> +	hws[IMXRT1050_CLK_PLL2_BYPASS] = imx_clk_hw_mux_flags("pll2_bypass", pll_base + 0x30, 16, 1,
> +		pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PARENT);
> +	hws[IMXRT1050_CLK_PLL3_BYPASS] = imx_clk_hw_mux_flags("pll3_bypass", pll_base + 0x10, 16, 1,
> +		pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PARENT);
> +	hws[IMXRT1050_CLK_PLL5_BYPASS] = imx_clk_hw_mux_flags("pll5_bypass", pll_base + 0xa0, 16, 1,
> +		pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PARENT);
> +
> +	hws[IMXRT1050_CLK_VIDEO_POST_DIV_SEL] = imx_clk_hw_divider("video_post_div_sel",
> +		"pll5_video", pll_base + 0xa0, 19, 2);
> +	hws[IMXRT1050_CLK_VIDEO_DIV] = imx_clk_hw_divider("video_div",
> +		"video_post_div_sel", pll_base + 0x170, 30, 2);
> +
> +	hws[IMXRT1050_CLK_PLL3_80M] = imx_clk_hw_fixed_factor("pll3_80m",  "pll3_usb_otg", 1, 6);
> +
> +	hws[IMXRT1050_CLK_PLL2_PFD0_352M] = imx_clk_hw_pfd("pll2_pfd0_352m", "pll2_sys", pll_base + 0x100, 0);
> +	hws[IMXRT1050_CLK_PLL2_PFD1_594M] = imx_clk_hw_pfd("pll2_pfd1_594m", "pll2_sys", pll_base + 0x100, 1);
> +	hws[IMXRT1050_CLK_PLL2_PFD2_396M] = imx_clk_hw_pfd("pll2_pfd2_396m", "pll2_sys", pll_base + 0x100, 2);
> +	hws[IMXRT1050_CLK_PLL3_PFD1_664_62M] = imx_clk_hw_pfd("pll3_pfd1_664_62m", "pll3_usb_otg", pll_base + 0xf0, 1);
> +	hws[IMXRT1050_CLK_PLL3_PFD3_454_74M] = imx_clk_hw_pfd("pll3_pfd3_454_74m", "pll3_usb_otg", pll_base + 0xf0, 3);
> +
> +	/* CCM clocks */
> +	ccm_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (WARN_ON(IS_ERR(ccm_base)))
> +		return PTR_ERR(ccm_base);
> +
> +	hws[IMXRT1050_CLK_ARM_PODF] = imx_clk_hw_divider("arm_podf", "pll1_arm", ccm_base + 0x10, 0, 3);
> +	hws[IMXRT1050_CLK_PRE_PERIPH_SEL] = imx_clk_hw_mux("pre_periph_sel", ccm_base + 0x18, 18, 2,
> +		pre_periph_sels, ARRAY_SIZE(pre_periph_sels));
> +	hws[IMXRT1050_CLK_PERIPH_SEL] = imx_clk_hw_mux("periph_sel", ccm_base + 0x14, 25, 1,
> +		periph_sels, ARRAY_SIZE(periph_sels));
> +	hws[IMXRT1050_CLK_USDHC1_SEL] = imx_clk_hw_mux("usdhc1_sel", ccm_base + 0x1c, 16, 1,
> +		usdhc_sels, ARRAY_SIZE(usdhc_sels));
> +	hws[IMXRT1050_CLK_USDHC2_SEL] = imx_clk_hw_mux("usdhc2_sel", ccm_base + 0x1c, 17, 1,
> +		usdhc_sels, ARRAY_SIZE(usdhc_sels));
> +	hws[IMXRT1050_CLK_LPUART_SEL] = imx_clk_hw_mux("lpuart_sel", ccm_base + 0x24, 6, 1,
> +		lpuart_sels, ARRAY_SIZE(lpuart_sels));
> +	hws[IMXRT1050_CLK_LCDIF_SEL] = imx_clk_hw_mux("lcdif_sel", ccm_base + 0x38, 15, 3,
> +		lcdif_sels, ARRAY_SIZE(lcdif_sels));
> +	hws[IMXRT1050_CLK_PER_CLK_SEL] = imx_clk_hw_mux("per_sel", ccm_base + 0x1C, 6, 1,
> +		per_sels, ARRAY_SIZE(per_sels));
> +	hws[IMXRT1050_CLK_SEMC_ALT_SEL] = imx_clk_hw_mux("semc_alt_sel", ccm_base + 0x14, 7, 1,
> +		semc_alt_sels, ARRAY_SIZE(semc_alt_sels));
> +	hws[IMXRT1050_CLK_SEMC_SEL] = imx_clk_hw_mux_flags("semc_sel", ccm_base + 0x14, 6, 1,
> +		semc_sels, ARRAY_SIZE(semc_sels), CLK_IS_CRITICAL);
> +
> +	hws[IMXRT1050_CLK_AHB_PODF] = imx_clk_hw_divider("ahb", "periph_sel", ccm_base + 0x14, 10, 3);
> +	hws[IMXRT1050_CLK_IPG_PDOF] = imx_clk_hw_divider("ipg", "ahb", ccm_base + 0x14, 8, 2);
> +	hws[IMXRT1050_CLK_PER_PDOF] = imx_clk_hw_divider("per", "per_sel", ccm_base + 0x1C, 0, 5);
> +
> +	hws[IMXRT1050_CLK_USDHC1_PODF] = imx_clk_hw_divider("usdhc1_podf", "usdhc1_sel", ccm_base + 0x24, 11, 3);
> +	hws[IMXRT1050_CLK_USDHC2_PODF] = imx_clk_hw_divider("usdhc2_podf", "usdhc2_sel", ccm_base + 0x24, 16, 3);
> +	hws[IMXRT1050_CLK_LPUART_PODF] = imx_clk_hw_divider("lpuart_podf", "lpuart_sel", ccm_base + 0x24, 0, 6);
> +	hws[IMXRT1050_CLK_LCDIF_PRED] = imx_clk_hw_divider("lcdif_pred", "lcdif_sel", ccm_base + 0x38, 12, 3);
> +	hws[IMXRT1050_CLK_LCDIF_PODF] = imx_clk_hw_divider("lcdif_podf", "lcdif_pred", ccm_base + 0x18, 23, 3);
> +
> +	hws[IMXRT1050_CLK_USDHC1] = imx_clk_hw_gate2("usdhc1", "usdhc1_podf", ccm_base + 0x80, 2);
> +	hws[IMXRT1050_CLK_USDHC2] = imx_clk_hw_gate2("usdhc2", "usdhc2_podf", ccm_base + 0x80, 4);
> +	hws[IMXRT1050_CLK_LPUART1] = imx_clk_hw_gate2("lpuart1", "lpuart_podf", ccm_base + 0x7c, 24);
> +	hws[IMXRT1050_CLK_LCDIF_APB] = imx_clk_hw_gate2("lcdif", "lcdif_podf", ccm_base + 0x74, 10);
> +	hws[IMXRT1050_CLK_DMA] = imx_clk_hw_gate("dma", "ipg", ccm_base + 0x7C, 6);
> +	hws[IMXRT1050_CLK_DMA_MUX] = imx_clk_hw_gate("dmamux0", "ipg", ccm_base + 0x7C, 7);
> +	imx_check_clk_hws(hws, IMXRT1050_CLK_END);
> +
> +	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register clks for i.MXRT1050.\n");
> +		imx_unregister_hw_clocks(hws, IMXRT1050_CLK_END);
> +	}
> +	return ret;
> +}
> +static const struct of_device_id imxrt1050_clk_of_match[] = {
> +	{ .compatible = "fsl,imxrt1050-ccm" },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imxrt1050_clk_of_match);
> +
> +static struct platform_driver imxrt1050_clk_driver = {
> +	.probe = imxrt1050_clocks_probe,
> +	.driver = {
> +		.name = "imxrt1050-ccm",
> +		.of_match_table = imxrt1050_clk_of_match,
> +	},
> +};
> +module_platform_driver(imxrt1050_clk_driver);
> -- 
> 2.34.1
>
