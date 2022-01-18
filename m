Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287D84923BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiARK1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:27:06 -0500
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:42451
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229561AbiARK1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:27:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA3gwv9XHhH/5CFHc8m2k/oJyvdKFGSj2aU6LAzwN4dl6KyOUGqFm6YzX0FQGNsFR3Ds43OYT1a5gwHESBGYWG+BHxfGgyjvzG8GgpOzF/o5Q6cIqQiZd8rEi00QUGzmoltPbBQMaWAeOH+krDKufBW/nTyio2Cq+gpznc/55vGTdGmqaIRF35NYUa5mZRD8qE/oeEx+oLVSO7r++5nY+9t5D/68ATj2Hmdr2yF5bkevxSjNnfioFOgq8HaBbRa3lTIfRFLB1Znmyo0bfWmvWyaq4h3pckQt7NccnqEqXpZ4qS0C6YzXw8OZtRZF6AMtaRynLe2VUSlf7BbLJuEVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yC68+QfohNG0KiZC0QO8cPwbeXWnLHWsEbOZNyt3Qg=;
 b=OKCO12f+DdOFfjK9dmaM5TkaZxonBU7JF8pSx+Z8i38FGRTYtXujFEkPHksl0HqKUoC9ZrilA+Hk17eWezMStc5FTuE4QWcB9bjDbwEjtC0/GuTl1EqSG6lP4gKqY+7uU0rcEFvmLj17seeKmXB6J3ULI/1NOzSQOc0A+UY62HYmQfQkhsdi1uwtOUKC9a8J+mBrT5F55ldSZuC20aG7zXNFCTnRmdbHZEgx99cXqIflHm6lKI1V0pKLOTS5E3X1cQNBjVm3m15Z/JDDk4frTZVX9tAs5qBkMA8WIk6hwgvWgMG2HpMxoSEqorb2WExen1JsVUq84fO/2YDQEnJcEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yC68+QfohNG0KiZC0QO8cPwbeXWnLHWsEbOZNyt3Qg=;
 b=MqSlW6j66d3xCqFPynsCE3JbfIYZjHs7uzC+VD7s980uMf61SzfVKgrBly7preALJ8hJ30l/CyboFSVhRF6pJ5104suUUhUaWmhju/J5LmMLgnmj3YRCheyCplW/6rHvmDC1oxiRxHx6SNKgU+3SKFdNWunNKZ14H4q6G+eqeD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by HE1PR04MB3098.eurprd04.prod.outlook.com (2603:10a6:7:20::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 10:26:57 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 10:26:57 +0000
Date:   Tue, 18 Jan 2022 12:26:55 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH v2] clk: imx: Add imx8dxl clk driver
Message-ID: <YeaV7+nx2pDWlfiO@abelvesa>
References: <1639747533-9778-1-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639747533-9778-1-git-send-email-abel.vesa@nxp.com>
X-ClientProxiedBy: VE1PR08CA0014.eurprd08.prod.outlook.com
 (2603:10a6:803:104::27) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd914509-0c82-46e2-ec64-08d9da6d0e61
X-MS-TrafficTypeDiagnostic: HE1PR04MB3098:EE_
X-Microsoft-Antispam-PRVS: <HE1PR04MB30986CFE1F58EBB6E093EFCBF6589@HE1PR04MB3098.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhdp18YhG35X+lDtPjA5FaLkE90qVeF6UVvxCjXRBeH5o3dcevFMqXX20HoH/YxoL3Eoy+ooRX+3Riw/dh7Dw/hmo/6a6ZvTADRfvvVpTB3BmHkGohKTZGIhN0oUnCjVVOtQki0O9kHK6OL7v/0SVIt+1V53eAifSH14kAscDzOnoZWtEbNDIh8OFPWxW47kVoX3TdYOcwbtkERyWizgg5xIeEsW1g3rIWU90+2DabOQC/McNI5FRMXXvP0V5uAz21diYBz23HApXsppIE2vQe9dJC/EK1wYlv5gjC2xyRNvncQClWDQKCWegklBpQSZfluqrmfqbgwkZ9RXYLxfcuH9HGiSsQ7SPpbfnsk4MqZz/53IMHVRYMVnA7VA7+fWK5qDFPgkOnqmSRxskz+p9dN7EvHB5032kSTx5+VaGMPw/Dc2pKUgQr13wthgBB91DxyRCprfHGvfnCq6TNrW8sR4zXSp6QZ5rIAOl8Uo6pEpx20J2Di1VbPge2FSaeL0IFlhDwD9Ba0VaVMnVBC83lN/wIXiYO4Gl6l8D/vWknaCjJd0Upy20I8RqYxYk1XGplYbdtuIg3aq+muT9zR1AqzNAcMoSQlAiubIAMAhnPqUZ3S1H1MQdzdY7oaN4p1SvyQFU3IydTrGQZiiXrk12VqlVFEXR3YBZu54cWOAvGQIYFAanrbRv72T0TSPkp+xJsk0J/FbIXbF2RrgPyBvS+N9cG3JGagJkjDLCLLZ27PgMGDkZPxSR+S7i47M2AY0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(2906002)(6512007)(9686003)(66946007)(53546011)(6506007)(52116002)(186003)(26005)(38350700002)(86362001)(44832011)(38100700002)(66556008)(66476007)(4326008)(508600001)(6486002)(5660300002)(83380400001)(8936002)(8676002)(316002)(110136005)(54906003)(33716001)(32563001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+7mbiOnWuvDllewkOBe5e8A0zKB52koIQLF+Q/DVezwFMuzbRfuiVllQwfCr?=
 =?us-ascii?Q?wHi2USVowtnLBxLLo97JoRLkEPzerThClUwXZx5FV10S6RWHKw+qHeoU1sbV?=
 =?us-ascii?Q?pNzGcVB8zbOukjgUuwYCyaO8+eYS1TIw08DdU1BzWzdO4OG8Paio3GIW3PeU?=
 =?us-ascii?Q?mQnLEYTYfeFE3FKRuOUdW7+MDpmXjPuQ3ntOWqXpTS1Zyq4zzql5DyEJRIlb?=
 =?us-ascii?Q?06rJSfYzijS0PCeO7SqYw2cIGxgWnxE77A5nBMGLcBv9URmLr+Yj+wJCDS9Q?=
 =?us-ascii?Q?Ur6vrpyIHqI34/E5HH/VB1DreHsrghAXtnILILle3z5Y3Fl6SJs2RA1yqaPW?=
 =?us-ascii?Q?TjWTM5jeXGB/18mSEaYMSbIME3pYrP/n7EPP+q/sqKZroIpGE9UCl7jf1PLs?=
 =?us-ascii?Q?OyRQN30uwmQeMcUBJbPgVgGMfuJuIAcypXQYmK6GJfT8RanZXblUZhKAw/eC?=
 =?us-ascii?Q?VtNdXJqlXNiOUt6GrdEDHwICVnlnYDSdmhD3FM57UdL+rYYXjkBGKeguWwLb?=
 =?us-ascii?Q?sl1v/ErH/FKUnD0QT+/33Q2JaAA9s6Rv+7l22c0AhOTQL85rA3Z5goR+T5v9?=
 =?us-ascii?Q?NRc8xAIZxElPaiMCHeks0mntOHg/vJIiFAH0CkLu+vbJDpwZF9DkshCGIFK2?=
 =?us-ascii?Q?igsMxu046OH62cbdxhA/gKvbeT6DvQZWI4jFujPjFp3L/PD7UTZ4j+33HeZf?=
 =?us-ascii?Q?5Z6kqh4OpvsngMm+8ktmTjgw/DbFYAhlp6iZT8mnIGTDWrD2RXM/Q/tkupJ8?=
 =?us-ascii?Q?pbZ5JeROlYEG1w5mMps4UFhvx0c4o95skJwecEfFbOJMm7MZXKGTrPyhx+w8?=
 =?us-ascii?Q?gOwMiTS4UEuXfGFFamBx8Sst3piezYStpiXuFmI8WqLusdAQWIfwgF/H9Ux+?=
 =?us-ascii?Q?tBvQhT9vc4HlrHLVDZr3Gp6LQYtM+uQw2l+oHM24/7uTjEeNm53A/YhErE0s?=
 =?us-ascii?Q?Jhj/oU5C9ns119hyMcsuUaIT/bnWaoBGMACt2VP5qD6gIQbbIi5TOdiVOSLY?=
 =?us-ascii?Q?SZcYN++sKEQvit0DVVidEGB0fzdAQZrw0t2JKkOAR6IgUdU6MAn+4BCS2Buk?=
 =?us-ascii?Q?qj0/9BZH/mtEleoBDs2aievrtfLBJo7UZUdOMi7u5cx2j5sKkvhSBKkDx7Rn?=
 =?us-ascii?Q?LCbLiknfN5ZHpjiVSpew9tswpOwZDdKZRSQTYv8oEC3OFfO6S++2O4aKjDXe?=
 =?us-ascii?Q?W1WyH4iQe4/qTlSrRW5sYhuM76dXvYxF0XGuzXc5dwldPGzRZyMWiuub0jGv?=
 =?us-ascii?Q?Y+lGNN3rzbPpJw52rST3m4CiuisvX5XMFy5SH/koU8J0NSQ34GLWKHnOlgBg?=
 =?us-ascii?Q?tZF+TIjfo4rP3QvrTQIEqjVjmMRcnJC2SX3XbQLyhzfZG993LFlEQobXlsQ9?=
 =?us-ascii?Q?4z1NTnI1HoV5Y24jDQs6XLCooFEkV9FOYyl/1UQDbSrD8wm2dqt8cVsN1UI2?=
 =?us-ascii?Q?Q7FLWVQFCuEHOIKQ2R1DXdJ579VfTqEV5URAGyTZSZlQl5do21PiSVeUrnln?=
 =?us-ascii?Q?xSYe7Zlsc8o9ZBm/wAYokJHG17T7A7x9lYoSuuORpMMmXnFhsfUJ/SiwjA1M?=
 =?us-ascii?Q?rrx7A8wqRxPFW36ETjxXHO5t6Va1DSZlGQ2hovNwqh8FY356MBWNtjdx/jbq?=
 =?us-ascii?Q?O38xyIUG8ZTMJ6RRvZB2nIQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd914509-0c82-46e2-ec64-08d9da6d0e61
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 10:26:57.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xp17s3shy44VEOP8h3vMw3BHBGP+bwuRSNy6KKFCM8+OnssJeBkBAMREpJ+4wWjjXKBquVUn6ubrBlIoLezztw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-12-17 15:25:33, Abel Vesa wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> Add files for imx8dxl clk driver which is based on imx8qxp clock driver.
> 
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied.

> ---
> 
> Changes since v1:
>  * Moved the dxl compatible and rsrc table to be sorted alphabetically.
> 
>  drivers/clk/imx/Makefile           |  3 +-
>  drivers/clk/imx/clk-imx8dxl-rsrc.c | 66 ++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk-imx8qxp.c      |  1 +
>  drivers/clk/imx/clk-scu.h          |  1 +
>  4 files changed, 70 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/imx/clk-imx8dxl-rsrc.c
> 
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index b5e040026dfb..f8a44c4ca94a 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -28,7 +28,8 @@ obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
>  
>  obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
>  clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o \
> -				     clk-imx8qxp-rsrc.o clk-imx8qm-rsrc.o
> +				     clk-imx8qxp-rsrc.o clk-imx8qm-rsrc.o \
> +				     clk-imx8dxl-rsrc.o
>  clk-imx-lpcg-scu-$(CONFIG_CLK_IMX8QXP) += clk-lpcg-scu.o clk-imx8qxp-lpcg.o
>  
>  obj-$(CONFIG_CLK_IMX8ULP) += clk-imx8ulp.o
> diff --git a/drivers/clk/imx/clk-imx8dxl-rsrc.c b/drivers/clk/imx/clk-imx8dxl-rsrc.c
> new file mode 100644
> index 000000000000..69b7aa34fff5
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imx8dxl-rsrc.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019~2020 NXP
> + */
> +
> +#include <dt-bindings/firmware/imx/rsrc.h>
> +
> +#include "clk-scu.h"
> +
> +/* Keep sorted in the ascending order */
> +static u32 imx8dxl_clk_scu_rsrc_table[] = {
> +	IMX_SC_R_SPI_0,
> +	IMX_SC_R_SPI_1,
> +	IMX_SC_R_SPI_2,
> +	IMX_SC_R_SPI_3,
> +	IMX_SC_R_UART_0,
> +	IMX_SC_R_UART_1,
> +	IMX_SC_R_UART_2,
> +	IMX_SC_R_UART_3,
> +	IMX_SC_R_I2C_0,
> +	IMX_SC_R_I2C_1,
> +	IMX_SC_R_I2C_2,
> +	IMX_SC_R_I2C_3,
> +	IMX_SC_R_ADC_0,
> +	IMX_SC_R_FTM_0,
> +	IMX_SC_R_FTM_1,
> +	IMX_SC_R_CAN_0,
> +	IMX_SC_R_LCD_0,
> +	IMX_SC_R_LCD_0_PWM_0,
> +	IMX_SC_R_PWM_0,
> +	IMX_SC_R_PWM_1,
> +	IMX_SC_R_PWM_2,
> +	IMX_SC_R_PWM_3,
> +	IMX_SC_R_PWM_4,
> +	IMX_SC_R_PWM_5,
> +	IMX_SC_R_PWM_6,
> +	IMX_SC_R_PWM_7,
> +	IMX_SC_R_GPT_0,
> +	IMX_SC_R_GPT_1,
> +	IMX_SC_R_GPT_2,
> +	IMX_SC_R_GPT_3,
> +	IMX_SC_R_GPT_4,
> +	IMX_SC_R_FSPI_0,
> +	IMX_SC_R_FSPI_1,
> +	IMX_SC_R_SDHC_0,
> +	IMX_SC_R_SDHC_1,
> +	IMX_SC_R_SDHC_2,
> +	IMX_SC_R_ENET_0,
> +	IMX_SC_R_ENET_1,
> +	IMX_SC_R_MLB_0,
> +	IMX_SC_R_USB_1,
> +	IMX_SC_R_NAND,
> +	IMX_SC_R_M4_0_I2C,
> +	IMX_SC_R_M4_0_UART,
> +	IMX_SC_R_ELCDIF_PLL,
> +	IMX_SC_R_AUDIO_PLL_0,
> +	IMX_SC_R_AUDIO_PLL_1,
> +	IMX_SC_R_AUDIO_CLK_0,
> +	IMX_SC_R_AUDIO_CLK_1,
> +	IMX_SC_R_A35
> +};
> +
> +const struct imx_clk_scu_rsrc_table imx_clk_scu_rsrc_imx8dxl = {
> +	.rsrc = imx8dxl_clk_scu_rsrc_table,
> +	.num = ARRAY_SIZE(imx8dxl_clk_scu_rsrc_table),
> +};
> diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
> index 40a2efb1329b..546a3703bfeb 100644
> --- a/drivers/clk/imx/clk-imx8qxp.c
> +++ b/drivers/clk/imx/clk-imx8qxp.c
> @@ -295,6 +295,7 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id imx8qxp_match[] = {
>  	{ .compatible = "fsl,scu-clk", },
> +	{ .compatible = "fsl,imx8dxl-clk", &imx_clk_scu_rsrc_imx8dxl, },
>  	{ .compatible = "fsl,imx8qxp-clk", &imx_clk_scu_rsrc_imx8qxp, },
>  	{ .compatible = "fsl,imx8qm-clk", &imx_clk_scu_rsrc_imx8qm, },
>  	{ /* sentinel */ }
> diff --git a/drivers/clk/imx/clk-scu.h b/drivers/clk/imx/clk-scu.h
> index 22156e93b85d..af7b697f51ca 100644
> --- a/drivers/clk/imx/clk-scu.h
> +++ b/drivers/clk/imx/clk-scu.h
> @@ -21,6 +21,7 @@ struct imx_clk_scu_rsrc_table {
>  
>  extern struct list_head imx_scu_clks[];
>  extern const struct dev_pm_ops imx_clk_lpcg_scu_pm_ops;
> +extern const struct imx_clk_scu_rsrc_table imx_clk_scu_rsrc_imx8dxl;
>  extern const struct imx_clk_scu_rsrc_table imx_clk_scu_rsrc_imx8qxp;
>  extern const struct imx_clk_scu_rsrc_table imx_clk_scu_rsrc_imx8qm;
>  
> -- 
> 2.31.1
>
