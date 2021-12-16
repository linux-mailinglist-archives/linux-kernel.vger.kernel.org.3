Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F0B4776E8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbhLPQHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:07:34 -0500
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:46238
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238879AbhLPQHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:07:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzOEkhZ1eBCJb7YYHnrrirawxy3U42V1/y1a0WK9FYUBwzuQe2/eIKliE7RGwtgVLeRXrO9+KznqcNbYwTjjS3dkMKyC5U9qamhm7Eazxo1QpwTHGlOkETLH1HyFYhXOiEj+sGoL9ILfK7PIw44HJmhWu1O17Y4ey9he9caSlO+iuTE6yg0kB3TBBOiZrS6TJoYwC6EQ5l8OdwbCYRdv7m1CRMDscXg0pgyHspa91Hb1FNqutCHa+RCbazMLCev1z2bLqkOHlbv4uH6B1UjkPZr7xwts9q+sGftbbn1vV9Jx/zpXjuBjwaH/CPV98K2bLuyd30IB/Zg010vLuwD8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rFss1nsHb8fiGsERJS3sqTCt3dX2AfVo2bbZilrj24=;
 b=KzyD0FjuZt09Ud/6fz2/AgCv1Dp8hNZncS8BhggEsJ7WqAV+SovuULq2C1uNb3Nqhe+N2HMuduik+h3d3wlybznNHpkdI+TtHQhVpm13zD4qsS74cAN5zgFbyn9jXyI/TCQ2EnwHbsyRFRLDn8b0e01sDPNbuaadVWPnpviDQ9iTZXnx2TzFNDbwRXQ7ok7an1NRzMqHe+8pByhF3Gh6yyD5XWHaOceNI21iLe1/BmGodDU06zVH/q/KZ40Umf7ZZXb2qJ1Mxy+OHVtH6ef9kuW8DCixUyE+qyJFj/xrc3P4gXHwEwoaac3inZsSr5kj1ZVC87B2pUKUXZvl8hNAjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rFss1nsHb8fiGsERJS3sqTCt3dX2AfVo2bbZilrj24=;
 b=GYNX5+rPiK8jLwOVntTxPp78wigvrhbE5haVvewnbtlGNGAo3JqZQeAJr5MPGtpkifuQfflEXUFlaUp2M2mJkctkyDCZKO1aP8HKpotm973BLIvqG3hX/0Hu47iAvH6IjLnHjHSiWGEVrQCKee/E2MiVRxGYf1rTXQfLLfTu6ys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0401MB2687.eurprd04.prod.outlook.com (2603:10a6:800:57::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 16:07:29 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 16:07:28 +0000
Date:   Thu, 16 Dec 2021 18:07:26 +0200
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
Subject: Re: [PATCH v5 5/9] clk: imx: Add initial support for i.MXRT1050
 clock driver
Message-ID: <YbtkPkRyaw47+8z1@ryzen>
References: <20211215220538.4180616-1-Mr.Bossman075@gmail.com>
 <20211215220538.4180616-6-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215220538.4180616-6-Mr.Bossman075@gmail.com>
X-ClientProxiedBy: VI1PR0102CA0075.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::16) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d83706df-a9f3-424f-a431-08d9c0ae284f
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2687:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0401MB26879868B88A02142B58BCA9F6779@VI1PR0401MB2687.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJtnI6xcKkrXgDB60muFqAV1lS7g4QhaE/xZnfZUWPEOS+kmILmRbRJhSFDUUOxr6bIYMgsIm3yWgD5g4XqPV019xaN90YAOFz7SEAOTRZ7aCBX0OJ0fC4QOuxKVOQf/ZQi0oS7bUiypu4U7zqrS/taUTckVsS9+YiFzFJeYqrQZ4VYW93iHV+IUQUX+BDnrTetyGQFo4zOppL7RwM80NL0br/tXuIDISjhq3j+13ADI991cP4oYjS2zaokLzjYIGxlh8T9cfoHaUAYOiweQZW8eXVUcKR+N3NdriV+w4sepquDwDpTGWfn4YioNUEqItvn2FbCIuUXPvI0EhsET0oi1Hz7VP5jwlTwgWviQ2CXiVwVSg4iNaJ9JTLwT4eqXY3zjJVgDFdmrMijHhgwDHxbz/kbuTrgh0H3OBoPAyJrmGfQkvw8SijndUJ0i+6YVklNB+GjXOlEnExpJRcHCSjr6JqH7TqBKG+ZftaEck1TGR0GtfPfZEsCQhKcqHoTx1CapiaF6ywWNC22qUaSuFKKCoKx9Zi3K9/iWYhGDqAL5NdqqKBdTpoQFKslG0VYt9WjuIXsXmCYuZ8YxHWSS8PTBJtGBPEnq4B56EVO9dN36KbhsD9xqDJhtJ+EZaTS1QUl4/oapntmWLczSSa9Xt8x8Elsp5Z6AtQR1bhfrveZuwdPoLYZXlAAXGHkvedV1d1RiULC07hUw4mgzj0EtwCsqsQzIJsB9KzTgGyzaFGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(6916009)(38100700002)(9686003)(26005)(508600001)(86362001)(66946007)(66476007)(8936002)(52116002)(66556008)(30864003)(53546011)(316002)(2906002)(6506007)(8676002)(6512007)(38350700002)(5660300002)(6486002)(4326008)(44832011)(186003)(83380400001)(7416002)(33716001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h5KfKXQm7LhtqJbBymCDv5dT/ufBsGRRrn6oBekiMA3dSUOUlzxfyK2K1ytu?=
 =?us-ascii?Q?aY7dOyjRZhNE4Wn5J7ACBaLSd5rwJLpEOMHOAdHia5KPDDct6IKLO8HDvvkA?=
 =?us-ascii?Q?TLudUALRdt/Z9zHGPIMXtpMReJ6w/M8cl/XNXLrkXAH5eM3GRAP1P93SjG5X?=
 =?us-ascii?Q?pTbbuXI8vHQwpNRpjjxk7U8TYb24abMBi+1eHpXXMswdpM5fhxQSusF5fNXA?=
 =?us-ascii?Q?ZEqfOjhY65LBnaPzIKgCzqI8gBe8pRZu28cBeHzpYEwKpOud0Dl3C0hvD7v/?=
 =?us-ascii?Q?152XmC8LhfP86yIuTqfgjv+drY3xEbYbDnDutiUwaCfQnhdf5XYfGwLtz9wG?=
 =?us-ascii?Q?k0r31gXx0xoL0Q/ruwkObJy5YCS8t/vCc5v4cNawDVcwAIwEcjoGz2jFgsgB?=
 =?us-ascii?Q?+v+Bfh0cjyNwRGZjEBcvgwsf/gHO6Pgox0KBJsbIZ7qgPGmCaMtMqqrXzybF?=
 =?us-ascii?Q?0ZBBdCdmWXOREQWcYf8ReXl8d/4hs3w1Gt3r4R12NYs06bhvl7KphFAhXxe+?=
 =?us-ascii?Q?j1ax/6mwJ4dm3/L3gdlVh+m4TeUv5g/XaJ6jA5EGUHuFx3VQ7rMKMqau7uxg?=
 =?us-ascii?Q?ZHU4LQBraE7WoX9vHgdUi0PO5Of8/nMOPMiSt448GBrW+gugWITx94zyTVQW?=
 =?us-ascii?Q?MOFDwLxtpiWXh3d6fYduQ+JITD6S53lOxOudsFCR6UbJ3lSMP19XJTFAds6b?=
 =?us-ascii?Q?oqgcOU5DSbBzeRPluMrRRUpRczMqjppLXAOIeaO+PBGL6R872sIe3R0T31jP?=
 =?us-ascii?Q?AuvEeAElGqIu8//6TFTfVXCctYprroMhXluw8NaUUiGGC58n4oCHVVj4Xg63?=
 =?us-ascii?Q?ovh5TnkzGnNb4Yc92u56DeliHibbxFqLpzD4xNt0hIwC+sFDmr2KAaOh/5GN?=
 =?us-ascii?Q?EdfFN51aHvQvDhxAel5GO8vFqpQ8ToYyjWyS/yhxEY+ZDzMqAiTBESD+sCUJ?=
 =?us-ascii?Q?ygFx1EHKxhYbeQVhQnXgRJjGzCnNBfeaC9fSpsRaKjoWcKCuulqaYmm11N6n?=
 =?us-ascii?Q?Rni0xu05/RwFdU3vxmlL9i/KVp4fLjarj/+HF/ScUjmlCo02PTMOPlR9ipTH?=
 =?us-ascii?Q?IOyAFplEz4T32EPQ3E/7PEoRARgFFtDSjUFzR/VXM561YMtTFOLriWW6j0xx?=
 =?us-ascii?Q?gakRRdWcP3hQKaHbEbo4/gjw7crBre8b1xxm8U1swo59X4O8GbuSqQ86aPYE?=
 =?us-ascii?Q?GaGaNoLY/4gsOeoFmiA7qcfjbp6B4r4PHck49G6UHYVtQ9865ChY4UIIK6E9?=
 =?us-ascii?Q?d4AUhYJKGzGEUFqvgnR7OEVMkiGsXK3lJaC/zSkad96ll3F6BQR/809jTu7z?=
 =?us-ascii?Q?Syifm+u3Q8iaFw8pZfockBISrvj1I6o6HdbXkl+naCEwDkFbgnwqpbcVLlRh?=
 =?us-ascii?Q?COvn3eUEiOOA1VSjNEZZ0vQtmmwDosObZMB262dNcnknUJ1OkqcBOKCu6LsY?=
 =?us-ascii?Q?GlNTPo323haABbKOhZG3PFWGKaxnA/RDAInt/R5m/xvecy/Hb+yoOSFLima+?=
 =?us-ascii?Q?jnbignwsA6wTne6aLYttqmlLn6KJ5QYrOAeSM93ZD6s67lWRBE5DtXb7v1OA?=
 =?us-ascii?Q?WZRumael/0ODwmvRdwa9/xfg9Y6CmKKM8rlPHiFfGAMU3XUpJpqbQkRBXwvW?=
 =?us-ascii?Q?OKueRE90WLn2kNS9pOo3gyk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83706df-a9f3-424f-a431-08d9c0ae284f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 16:07:28.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyohC+nV1NLqsk4035ircRkG3JFvnweZAVHfIG+oR9FsgKD+ZuSFj87nBP3vD9jckQbxaQ7dAj+3oWl9X+2xLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2687
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-12-15 17:05:34, Jesse Taube wrote:
> Add clock driver support for i.MXRT1050.
> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> Suggested-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
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
> ---
>  drivers/clk/imx/Kconfig         |   5 +
>  drivers/clk/imx/Makefile        |   1 +
>  drivers/clk/imx/clk-imxrt1050.c | 181 ++++++++++++++++++++++++++++++++
>  3 files changed, 187 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-imxrt1050.c
> 
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index c08edbd04d22..f697652ab19c 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -105,3 +105,8 @@ config CLK_IMX8ULP
>  	select MXC_CLK
>  	help
>  	    Build the driver for i.MX8ULP CCM Clock Driver
> +
> +config CLK_IMXRT1050
> +	bool "IMXRT1050 CCM Clock Driver"
> +	depends on SOC_IMXRT
> +	select MXC_CLK
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index b5e040026dfb..3d9a1e3b5fc6 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -47,3 +47,4 @@ obj-$(CONFIG_CLK_IMX6UL) += clk-imx6ul.o
>  obj-$(CONFIG_CLK_IMX7D)  += clk-imx7d.o
>  obj-$(CONFIG_CLK_IMX7ULP) += clk-imx7ulp.o
>  obj-$(CONFIG_CLK_VF610)  += clk-vf610.o
> +obj-$(CONFIG_CLK_IMXRT1050)  += clk-imxrt1050.o
> diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
> new file mode 100644
> index 000000000000..0132ff45e716
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imxrt1050.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) 2021
> + * Author(s):
> + * Jesse Taube <Mr.Bossman075@gmail.com>
> + * Giulio Benetti <giulio.benetti@benettiengineering.com>
> + */
> +#include <linux/mm.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/sizes.h>
> +#include <soc/imx/revision.h>
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
> +static void __init imxrt_clocks_common_init(void __iomem *base)
> +{
> +	/* Anatop clocks */
> +	hws[IMXRT1050_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0UL);
> +
> +	hws[IMXRT1050_CLK_PLL1_REF_SEL] = imx_clk_hw_mux("pll1_arm_ref_sel",
> +		base + 0x0, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +	hws[IMXRT1050_CLK_PLL2_REF_SEL] = imx_clk_hw_mux("pll2_sys_ref_sel",
> +		base + 0x30, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +	hws[IMXRT1050_CLK_PLL3_REF_SEL] = imx_clk_hw_mux("pll3_usb_otg_ref_sel",
> +		base + 0x10, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +	hws[IMXRT1050_CLK_PLL5_REF_SEL] = imx_clk_hw_mux("pll5_video_ref_sel",
> +		base + 0xa0, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +
> +	hws[IMXRT1050_CLK_PLL1_ARM] = imx_clk_hw_pllv3(IMX_PLLV3_SYS, "pll1_arm",
> +		"pll1_arm_ref_sel", base + 0x0, 0x7f);
> +	hws[IMXRT1050_CLK_PLL2_SYS] = imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2_sys",
> +		"pll2_sys_ref_sel", base + 0x30, 0x1);
> +	hws[IMXRT1050_CLK_PLL3_USB_OTG] = imx_clk_hw_pllv3(IMX_PLLV3_USB, "pll3_usb_otg",
> +		"pll3_usb_otg_ref_sel", base + 0x10, 0x1);
> +	hws[IMXRT1050_CLK_PLL5_VIDEO] = imx_clk_hw_pllv3(IMX_PLLV3_AV, "pll5_video",
> +		"pll5_video_ref_sel", base + 0xa0, 0x7f);
> +
> +	/* PLL bypass out */
> +	hws[IMXRT1050_CLK_PLL1_BYPASS] = imx_clk_hw_mux_flags("pll1_bypass", base + 0x0, 16, 1,
> +		pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PARENT);
> +	hws[IMXRT1050_CLK_PLL2_BYPASS] = imx_clk_hw_mux_flags("pll2_bypass", base + 0x30, 16, 1,
> +		pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PARENT);
> +	hws[IMXRT1050_CLK_PLL3_BYPASS] = imx_clk_hw_mux_flags("pll3_bypass", base + 0x10, 16, 1,
> +		pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PARENT);
> +	hws[IMXRT1050_CLK_PLL5_BYPASS] = imx_clk_hw_mux_flags("pll5_bypass", base + 0xa0, 16, 1,
> +		pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PARENT);
> +
> +	hws[IMXRT1050_CLK_VIDEO_POST_DIV_SEL] = imx_clk_hw_divider("video_post_div_sel",
> +		"pll5_video", base + 0xa0, 19, 2);
> +	hws[IMXRT1050_CLK_VIDEO_DIV] = imx_clk_hw_divider("video_div",
> +		"video_post_div_sel", base + 0x170, 30, 2);
> +
> +	hws[IMXRT1050_CLK_PLL3_80M] = imx_clk_hw_fixed_factor("pll3_80m",  "pll3_usb_otg", 1, 6);
> +
> +	hws[IMXRT1050_CLK_PLL2_PFD0_352M] = imx_clk_hw_pfd("pll2_pfd0_352m", "pll2_sys", base + 0x100, 0);
> +	hws[IMXRT1050_CLK_PLL2_PFD1_594M] = imx_clk_hw_pfd("pll2_pfd1_594m", "pll2_sys", base + 0x100, 1);
> +	hws[IMXRT1050_CLK_PLL2_PFD2_396M] = imx_clk_hw_pfd("pll2_pfd2_396m", "pll2_sys", base + 0x100, 2);
> +	hws[IMXRT1050_CLK_PLL3_PFD1_664_62M] = imx_clk_hw_pfd("pll3_pfd1_664_62m", "pll3_usb_otg", base + 0xf0, 1);
> +	hws[IMXRT1050_CLK_PLL3_PFD3_454_74M] = imx_clk_hw_pfd("pll3_pfd3_454_74m", "pll3_usb_otg", base + 0xf0, 3);
> +}
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
> +	hws[IMXRT1050_CLK_OSC] = __clk_get_hw(of_clk_get_by_name(np, "osc"));
> +
> +	anp = of_find_compatible_node(NULL, NULL, "fsl,imxrt-anatop");
> +	pll_base = of_iomap(anp, 0);
> +	of_node_put(anp)
> +	if (WARN_ON(!pll_base))
> +		return -ENOMEM;
> +	imxrt_clocks_common_init(pll_base);
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
> +	hws[IMXRT1050_CLK_GPT] = imx_clk_hw_fixed_factor("gpt", "osc", 1, 8);
> +	imx_check_clk_hws(hws, IMXRT1050_CLK_END);
> +
> +	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register clks for i.MXRT1050.\n");
> +		imx_unregister_hw_clocks(hws, IMXRT1050_CLK_END);
> +		return ret;
> +	}
> +	return 0;
> +}
> +static const struct of_device_id imxrt1050_clk_of_match[] = {
> +	{ .compatible = "fsl,imxrt1050-ccm" },
> +	{ /* Sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, imxrt1050_clk_of_match);
> +
> +static struct platform_driver imxrt1050_clk_driver = {
> +	.probe = imxrt1050_clocks_probe,
> +	.driver = {
> +		.name = "fsl,imxrt1050-ccm",

Name here should be: "imxrt1050-ccm". Drop the "fsl,".

Look at the other imx clock drivers::
	$ git grep "\.name = \"" drivers/clk/imx/clk-imx*
	drivers/clk/imx/clk-imx8mm.c:           .name = "imx8mm-ccm",
	drivers/clk/imx/clk-imx8mn.c:           .name = "imx8mn-ccm",
	drivers/clk/imx/clk-imx8mp.c:           .name = "imx8mp-ccm",
	drivers/clk/imx/clk-imx8mq.c:           .name = "imx8mq-ccm",
	drivers/clk/imx/clk-imx8qxp-lpcg.c:             .name = "imx8qxp-lpcg-clk",
	drivers/clk/imx/clk-imx8qxp.c:          .name = "imx8qxp-clk",
	$


> +		.of_match_table = of_match_ptr(imxrt1050_clk_of_match),
> +	},
> +};
> +module_platform_driver(imxrt1050_clk_driver);
> -- 
> 2.34.1
>
