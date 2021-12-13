Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1F8472B66
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhLMLaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:30:18 -0500
Received: from mail-am6eur05on2079.outbound.protection.outlook.com ([40.107.22.79]:34016
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232734AbhLMLaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:30:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5J12HXYL/na/qfeVY7RV7YrgZ5m40GDSC+Sg/0DabXfh2SApWdxIRqNTLxIQmBxg9Uko47me56UrX19ejgwmUdWtgLMz8A194+0/IVq2Ex/rLSQ3Y16d+jcnRw6YPuNisgxby9RPO7FDov/iyO2U5XGagPI6QPWKFBPFF2A0eYDzqkT2O3UIqZhu4oQ/UhGNrgRuZ1aPCF83/6RBBvMqZDBtk6bAj3JFXkdzjhSXVc0kzRi/7EwnimyFUph5GHqzsKppN3T5Ix1B5dXTbfGaBuULsCc4pa1I8TZqoubqF+WMcKm57bjE8lC+K86YioXq/FVOsF9OJnYbEuiBF5tpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzecVdSFV71KDBTsEfao5NIEEruj7C/0CdIEnfO1H6I=;
 b=F2rw/LQDJF9alh87cNGLHLh5DbPB0Wk2hyleMlde8TrNgmA8NeImG9N+4tweQeP2nHHhs+ecly5czb/AysxEGormIp1ZkJHdF6ZeNFC0/mPCqosW9j3w+au8UgVPpszn7h3IaQE6o/4vsjIpYMYjm+3HVCosmWQwzRV8TtTFiIeza6sk9viJwN0T+L8fJ8iGLzWRC7FOrGjA2BOfCE+BYwr2i8F3E/f95c/K6aztV0RkLhjCptKweR5SyyJS26JzrwnnCU5WEjIUTLhznMsAHx4vYgh5mgYWBigf7sfJDhBnYY2dG3Wono/HS6LtvtN5uj5kVWncRjjo5rfMlxkcMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzecVdSFV71KDBTsEfao5NIEEruj7C/0CdIEnfO1H6I=;
 b=FTamKKzY84YOvORFRYATtbzsAuuWik7NyHtf5UUiq/V8RWDFkm3dF0v0b5snsnX7Cl9AAeOo+qg3SSHOO2fHWvb85X6cS1PKHi+ldFOmCks7mO5dY4n7sNbMcwK7Z6INWPbLe9vBfaC1zWeXmT1t+lxhpM2QyXPAoAaJcbfAhYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB3966.eurprd04.prod.outlook.com (2603:10a6:803:4e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 11:30:12 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4755.028; Mon, 13 Dec 2021
 11:30:12 +0000
Date:   Mon, 13 Dec 2021 13:30:09 +0200
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
Subject: Re: [PATCH v4 07/13] clk: imx: Add initial support for i.MXRT clock
 driver
Message-ID: <YbcuweQlw3inhye1@ryzen>
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
 <20211204061042.1248028-8-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204061042.1248028-8-Mr.Bossman075@gmail.com>
X-ClientProxiedBy: VI1PR03CA0051.eurprd03.prod.outlook.com
 (2603:10a6:803:50::22) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
Received: from ryzen (188.25.169.131) by VI1PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:803:50::22) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 13 Dec 2021 11:30:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52ebcb3c-13b0-4d9f-bea6-08d9be2bece5
X-MS-TrafficTypeDiagnostic: VI1PR04MB3966:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB396610F9B60546D1B2ED4278F6749@VI1PR04MB3966.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlzyzrSSr5IjiYHOhgOuwaKZZ2FVkISpvS+dWjZvaeQZwgkah+UDau+2x8fd+HILv2fhTKMuQbpEj4RnliTOgHwvL4s7uww5kSaLkPY9GThsgqXoJDOaqwSsAxd2AoPwH+bOyTl0x5R277vvHiwVcD8TVi1hYq3xzpI6drwTCdQ9Ugwy2tVrV1wbWHawVkagCLp7lzEP+bCNNrD5w9VAyENoT6ff9GWbpX0e7IAtcWj+wx7xDtC4amSXliwgYK3f18sPQlpVfmI+PuERCqWOsOdB1Eh2p4t4bEY3LXSFmaRs7VV+cKaT0a2xFlr0cwiCTzzFE9IVYTECDpAK3okjJBpxwKV5uKtIrhdCEx2YdnCwjZIERBJviBoNLI9URaPy0ktIXLH7tuzANWTBevweaLePrnDmdX/vP3U7bF4z3D+hSFy0b75tqnBaRGWt6eDbcoc4gGtqCWJ0HRj84MPgtJgl3RZoqWtz+v5dHxle/zlGCOKThkRV5fPk7gwpIJVLg4k2/iAYGrF4tQzgnoqHMiOAJNDlsqUrjFtwqhFPjfRGFVxOvM9NQwgY90CoLCpraoXw6nNCHDCkGK7r4w3V4SRnQi1ClPSOIE2wG+UX1XdAb5wMNFxZVQ2eMAz2TUW8m9vA88BMcwZYKuZf8WrQGoVkm3kuw4xcHwR7+o/beYsrSwttpugA9Lgai2rbuwu7qHBCRFOusFpe9ovXojClEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(316002)(8676002)(7416002)(55016003)(6916009)(6496006)(52116002)(86362001)(4326008)(83380400001)(956004)(66476007)(9686003)(9576002)(508600001)(5660300002)(44832011)(2906002)(186003)(38350700002)(30864003)(38100700002)(8936002)(33716001)(26005)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nIbMsSoRkJKN8j12O+XlcoD9t7V5jOexbG8oLVxM+FDBgajMsIrQ8P2R7Xrg?=
 =?us-ascii?Q?/uO00V1SrVuZsRJ+CWO36T+l1CD5m2eRgnSNm/yxIgQrk18omf5kn/GBdr74?=
 =?us-ascii?Q?hh1S2Zezo9/BrHlqTh+VBrrXVadKQfjRF4G7i9LE7GGKYWBabSILxfgMxhYW?=
 =?us-ascii?Q?5t1REU5bvNKwSPcoER99N/94t/3sHWkwwaBciKlxUZm1fEhocC5U3tBnzcYu?=
 =?us-ascii?Q?Y5KGU4eKklZ716sNrZzG/1n6IJY9ZWBsO++NOdhi8jKpAtkEg3a6+Edud121?=
 =?us-ascii?Q?AXthJN8HB/boz2ijNz1vp9K4/6XRUQwRvCqwlAFUubTbzgRI4uqYgjdbTZzF?=
 =?us-ascii?Q?fGZtWJnqgbq6w2iDf4fu0HWP6wYIXIj3oMWHtFYSbr0DITeQBT9hSt2u0zAn?=
 =?us-ascii?Q?TiAFTLIVNNa103bpueOPwtZFTaNTQbeMIPGQsFvY7ZuLAHcMXbnQOY0WZwyD?=
 =?us-ascii?Q?8XHRLYr4ZV3ThHD4s7ThOiMhn1cW6nd7BehHN4KaNtEK9QsMqAwyjl0uRDLT?=
 =?us-ascii?Q?uelM8kAV0X0i9Q6jAHhu7DxnmAfA0tGxivF0HcbkNTviTekJOaUFaBl9rY2I?=
 =?us-ascii?Q?3evYGHDMrA8a5JVkvztI6NUJlhf8zMVwal4S5CJhFzm04Nb97YB0eKspxSdy?=
 =?us-ascii?Q?Nht8bFxneysjLE8S4qSxBsZ2LWnx3RGB3wzigUwd8F2LMuvBtQWU8zIPFm1i?=
 =?us-ascii?Q?mTrwZvLvg10c2fKcb0YWn04lQ40EHHLut0q2Zw+bVvIghM1ojBuFmkDiqVdz?=
 =?us-ascii?Q?g4HVhcdGexCOGmhc0LVD4QqbybQKrrT3KHGg3BUDUC35lQ/B3CDSMHlEpOsq?=
 =?us-ascii?Q?hqtKQ4NuiVruI7ER18yAGcq5xRxKGk/sCNknv8gU+/8+9yVrIovCc44YRHH+?=
 =?us-ascii?Q?BbP8EDb9mDlTFRct2EY9KUvh2nad/0ItKxF6tRcTj/spsi2yfaOJ/aTEBaA+?=
 =?us-ascii?Q?b3JRbsQaGRmwFQdI84UqsXfSvDh57rIp5IirpRyhS17ClLUas6keHUYF65o8?=
 =?us-ascii?Q?7p3z01KSTv6KAFSP2aFfxSfyo2bD83Fi3X0aCKI0ccBZF94TULKNdwpga0TH?=
 =?us-ascii?Q?lH7f3cO/0bcr40DKQ8rjznUlhRSnChOkZBTxvbVhF83L8er90P1qi2KZTgmC?=
 =?us-ascii?Q?5POQcCPEVFvpPDbjOnE27y5rD/SvRfcE2z0tPnHhRVWAwu9Xu01eQ4hdx2om?=
 =?us-ascii?Q?I/TmEdUV5VxrOS5mvbJMdGpIpdZZnvE3SYoRlM8RtwEQgyeKRRLGbhocknYf?=
 =?us-ascii?Q?IJI+pEngER11NcqfZPs3YLouHwf7wkQytL41qamcZplZjfmPnTXpnD5IBx5s?=
 =?us-ascii?Q?6m1zQXAiEQrkzeBtnejAIgsCcBGEHe/CI303n/GtqRPjz1Yr8Ydx3Eq2+ZNE?=
 =?us-ascii?Q?CNbAoVUIYEy6SiHRxtx+rroAi6HVlDUUo+3u0gQ5yAZFd7PyqF/P+1liVm2P?=
 =?us-ascii?Q?AswD714T8+VsgKFZVOFWEGJoVLJZsHzpce+nOgCX/B1phRJ9hsLdLn5WQMH8?=
 =?us-ascii?Q?+uwxw00fLm3h3/aUH/RwdUd4iaEwlem8SnQ9tJT9/gGmYLOeSV//zMDrSe1x?=
 =?us-ascii?Q?5Fa9ebEoPLwL7ocgkhzCjrFqJOwyZkgu9BwxNGJISnYca0qZ8u+ADu+3HfLe?=
 =?us-ascii?Q?dxJLyu1R2soAy2Q3ZpvFHLc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ebcb3c-13b0-4d9f-bea6-08d9be2bece5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 11:30:11.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adz9LLwAoY0mrj0iUdTgfHKf4KUD3wPwdtV+Uyu/E/fU1804MlUkr/LQiPdTjkeC8vPJgBLQYYzRG5P/8+NX4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3966
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-12-04 01:10:36, Jesse Taube wrote:
> Add clock driver support for i.MXRT1***s starting with the i.MXRT1050.
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
> ---
>  drivers/clk/imx/Kconfig         |   5 +
>  drivers/clk/imx/Makefile        |   1 +
>  drivers/clk/imx/clk-imxrt1050.c | 156 ++++++++++++++++++++++++++++++++
>  3 files changed, 162 insertions(+)
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
> index 000000000000..85ba1a240335
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imxrt1050.c
> @@ -0,0 +1,156 @@
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
> +static void __init imxrt1050_clocks_init(struct device_node *np)
> +{
> +	void __iomem *ccm_base;
> +	void __iomem *pll_base;
> +	struct device_node *anp;
> +
> +	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
> +					  IMXRT1050_CLK_END), GFP_KERNEL);
> +	if (WARN_ON(!clk_hw_data))
> +		return;
> +
> +	clk_hw_data->num = IMXRT1050_CLK_END;
> +	hws = clk_hw_data->hws;
> +
> +	hws[IMXRT1050_CLK_OSC] = __clk_get_hw(of_clk_get_by_name(np, "osc"));
> +
> +	anp = of_find_compatible_node(NULL, NULL, "fsl,imxrt-anatop");
> +	pll_base = of_iomap(anp, 0);
> +	WARN_ON(!pll_base);
> +	imxrt_clocks_common_init(pll_base);
> +	/* CCM clocks */
> +	ccm_base = of_iomap(np, 0);
> +	WARN_ON(!ccm_base);
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
> +	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> +}
> +CLK_OF_DECLARE(imxrt_ccm, "fsl,imxrt1050-ccm", imxrt1050_clocks_init);

I would suggest module platform driver instead.

Sorry for the late review.

> -- 
> 2.34.0
>
