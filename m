Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6BB47779A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbhLPQOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:14:19 -0500
Received: from mail-am6eur05on2044.outbound.protection.outlook.com ([40.107.22.44]:27809
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239193AbhLPQOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:14:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKXRRQyLi3W1CK3nA385gNL+nTrvpHwDcDoZgVs1wUj8US2rrcGV7SM72HL8uUUE3Ui1EJRhS/FSm0oYUQwepqYC4Crh3O7pugVPs7yp9saQxL8MNDUntHh8UIrKTtQIuTQkrCyrzzX1uPff3arxXCs1Q26Gvnfu4H8YCa4/hUP2ifwPPd66NvjRP0Xugm0GeFybhMABowge8s1ELUzT1mO7tlokkuLX3DqarvusScm+l/1URWVwtB6zXhPUcvUR0BUMrGG9nwJHHSXf9yK/4isq+eALf/UZbUTBTCcbwktPI3sowiyAvguoshRT7jrp8DVB5hQ1VqBcpTpqn5ju/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcXAnV/jwrAxwJEUK6xw8nA7Bc5tYzFR9/a13pYAxao=;
 b=d3zBkyZp5nVAeqPmjPwBbIOm6PaEypK4vo/t9+3e5zOkfL+QGxRaP/wpY9PzZobBLFI+kKqQAcubqAffLwPmOdRzm5CW7/FKFRmm5YN8pDz8621F8gtOYEZA7iwy6xx9+pkWSNspoVzsR69IWRgoYbqv4I+SlQRYcNC5VcW7aNcHiAxBd1ZDMm+O0vRGT/DEBaaKavnx7US+LP0rlWGFM3w/hjaOq5oz5vXH8OpnrtQnBExULSdjONSfjN0P/6o842Z2GdJZ4aRoBK3OSml6f8/cQy30Y/b8OX9pMKHYVFt93KTRcbde31r+86N8g9KjIEGS1rjo3nBvDSUkmMk3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcXAnV/jwrAxwJEUK6xw8nA7Bc5tYzFR9/a13pYAxao=;
 b=SfUTxCcHMERopsdxNx1waZ3ZKlYufQqzpSwPmqFWT+rJWJP2Fz8TRDMHiZLC+XTXsGe8J9OqwdfsIP5TSsaTFh0KOiRBDdo3POxwdOXBvyfkRU6MTzK3nQnmrDDQCmZPghU/TO1cm3PbvnqkJu/v4dS5zV9TN/eaLEEX3AeGugM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5693.eurprd04.prod.outlook.com (2603:10a6:803:e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 16 Dec
 2021 16:14:11 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 16:14:11 +0000
Date:   Thu, 16 Dec 2021 18:14:09 +0200
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
Subject: Re: [PATCH] clk: imx: Add imx8dxl clk driver
Message-ID: <Ybtl0cnd5nY1RsTp@ryzen>
References: <1636567000-24145-1-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636567000-24145-1-git-send-email-abel.vesa@nxp.com>
X-ClientProxiedBy: VI1PR07CA0193.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::17) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb66c0c5-3ba3-491f-0536-08d9c0af1895
X-MS-TrafficTypeDiagnostic: VI1PR04MB5693:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5693D0DDF3820AD5C50B63A2F6779@VI1PR04MB5693.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDOzZ+VHDPhWEZ3+1NWrcPE14jwMXpFKrJCy61vo7+60eMX8focQmC/Sg2g0Bp130O9rQeVbvhYFvq2sTOwuXGo1P53eOzvNosURg/zr5LWyYxVvNGR7yVjE2OGBsM2yaCJvL1HbJdfmGCFW4LfB0w4rmV1Sp2gKeBig8f0gvqNx1Wrpj5dfZpqVxYbuiu23IrF1WAIyaasbPqhklLdWqPGDONnUZ3mTSt71GwN0D5eafOfjjreTEpyOd9fbu5jja8kme3u4wcs5WL784/IIbA0bnJVGiz+0VKjBxSNgi0Q/NDW2Ei3n6pW3VRExMytAn1VBJBSgyKVU++Kxfb1t/qmxaw26m3BhsNfvS9V2mF20pA4glbyfTz/N1lgRIYnXKUsWSyez3lZBuu6D2sPSULD4Khnz1HQ7XpZKGvEtfWeq3Xb+saclkbrqQs9j0WvQ93tLk0RwYF/CQzIs/wirfta5uDYo/IF/NeVUCYCw3XH4bofC9NIw8tLw1zHYaEmplQAoEtWJmDvLtCfPPL+eneadjrXyW3hYoe0wC+uCG2wLQjsIvA0DU6c3iz2bI1Vvu9vbX3UqH6vqWAXherUniRWfG+csUmTwJt2nVdYD2oSFVplHHTRawyTk936UIt6elIvMXQIqFBghdKmK2ULrg357Twz7SfvEG9/NjIwqeShNUPx9JC1pAHXtJvwSYhTqRmWtLB3/nOhzYTWTj6kZQFiK723bFAMZa4JME4pVOJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(66556008)(38100700002)(8676002)(6512007)(110136005)(508600001)(186003)(33716001)(83380400001)(66946007)(2906002)(316002)(38350700002)(6486002)(9686003)(8936002)(66476007)(86362001)(6506007)(53546011)(44832011)(5660300002)(26005)(52116002)(4326008)(54906003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wf+6iQaeTFiDeoEoUs0tDrUdb0m6cl3g9YeN0pd1crxturaaC5SUYawMTiwf?=
 =?us-ascii?Q?cPBMuZT0kC9hmhn26wPtbdfUAuKiDSryzBKKvRssyCwsOs1BfqozEG5jc0YL?=
 =?us-ascii?Q?zZ/uzVSUmB3n8d6DKL5OiYIB2RXfJcvZAaVgZZaFLOd2hWehxUrFXnVeJfYS?=
 =?us-ascii?Q?3FAmcNMUrm0Ql18YTfvJY4LnX64QkaQIWzOETG+N0sTKmmbNhtxGZzJXlhmw?=
 =?us-ascii?Q?I33UPyh2M8yMsEob+af7xOMtLjc5mKRZMXFcBFdg2D0sc9v3ZdsMQIMbqttH?=
 =?us-ascii?Q?UZvXzRXEBdmSAKNDm3szXIE/Fqj3xmplaY5VWo/XDKzoewbRngL7ddR/P78i?=
 =?us-ascii?Q?XqBTmxD4UOub7MQ/5QD5mWz0SXYSpWpDW0vn73j1lUCrALkrTW2+U2mr4+HB?=
 =?us-ascii?Q?GNTIK5jc25Dp6Dp/UdJXT9XL2r0HECQMY6531DjOa28gsJXF/tvNfAFHm4Rt?=
 =?us-ascii?Q?Km+nWAakLkAALIExkCQmVtcyOiHO0gTKrrGZlDyA5RHMs2r55oNla3b0lYgS?=
 =?us-ascii?Q?wJtVW0K5egdCtkVAsY2FCzjreeZN6A1TaoiumboYCAXzLicpSqWs6ooKhqcy?=
 =?us-ascii?Q?MPqauE6RnD0D9vYZfNI+kEx+Lnfsbk0rXVZ5j9Q0qeXq7AqMFOZmOaL2bX/s?=
 =?us-ascii?Q?fokF2NteA6L2ESGdWa95bL+DJ+o5tf4lokLLbjuia7JIAaCOSsFFjP8KD7Ua?=
 =?us-ascii?Q?LzI4nN9wMOOErBGYpbqCUq2nSIH+3bUDgTsAOGm3OdB26+MC9ZHnGbNTWyPb?=
 =?us-ascii?Q?s1FoSO79OZO9kDlF9XeTQD50pYUybE0jW4KoDKX5XpEls65cn+RZaOV87Rgd?=
 =?us-ascii?Q?jagqftZdNfGQieVVXK+EqHaqSmfHOonr2VXyPNHc4DJSW45OWrPVsm03/kPX?=
 =?us-ascii?Q?sGoaXLPBZ4qa1IaNhTpKOQagGs3DNNguRrkIpZKoqFErHbt1pW0lXpUZ7JIM?=
 =?us-ascii?Q?M0h8JsZmxWLvnCv6Tdh8YdcNWCLAW133/vfLDaXLQ6oyAdbwO3MVdlsds3mR?=
 =?us-ascii?Q?54Jynkna/BvR2NTAFbm1fWa3rbo7kteq8jtnZetMwtProF+r1isMz3211ZfO?=
 =?us-ascii?Q?j+AEzfbKQivHB1DqYyO1QQaWd+poN8/apn7xySbxVSPj4tWc+fO6Mfu3QIZl?=
 =?us-ascii?Q?h58qUciQkkxJpASPCf3JC0KdUDK1PBsRPyETMJvhfAdwbn8DBxPzDiMH8Xg4?=
 =?us-ascii?Q?kDQ67LNHcNR6CCHRbu/U7FUrSqexhyAvvZJ4NsaMD9P3s3p865ME8XOufKSQ?=
 =?us-ascii?Q?xrmfPLiXa7IeYjXZ7yhbLUv9s3n8yN+MV72WEhW04WQqWIYA/Eh9zUECAk4t?=
 =?us-ascii?Q?QYCmYZfXjn8Sj72emWOCfJ/pMlmBpvypouYlkQ/EpoEvfaA7FcTDL2TCDRh5?=
 =?us-ascii?Q?IQL4h9adZ8bj4FgQc1wDOpU0JeJq7FXL1Se263YsK7wTSnTEbMkyHzRCnCOi?=
 =?us-ascii?Q?kOI8DHEZBYVEr6YybMiwh0yGg8NpgWt23sIfoA25rgw5gKxM/ok1zQ84nlei?=
 =?us-ascii?Q?A7XvsY5VVLKBIqhgxo4liZrPALAqm6h224Pmoc2rZ6t1hzo20Cgn9K6SPikt?=
 =?us-ascii?Q?HySjqWSMfO1wV8CWXJu/6bs70TIX4LDbkKMeutOe60ZLYnF2Hv8TUHY0h0hn?=
 =?us-ascii?Q?Pi+jlte+o5OXNNm1PYIpdjs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb66c0c5-3ba3-491f-0536-08d9c0af1895
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 16:14:11.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTADqe/qtGtSKGGGbe3aAd6OpTeJUTn7Yht4rFV5nRS1aYrEdVZNiQNAdihLLckNjeDpxMZk7lMKD1TYXmZjrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5693
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-10 19:56:40, Abel Vesa wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> Add files for imx8dxl clk driver which is based on imx8qxp clock driver.
> 
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Gentle ping.

> ---
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
> index c53a688d8ccc..7f4893706cc2 100644
> --- a/drivers/clk/imx/clk-imx8qxp.c
> +++ b/drivers/clk/imx/clk-imx8qxp.c
> @@ -297,6 +297,7 @@ static const struct of_device_id imx8qxp_match[] = {
>  	{ .compatible = "fsl,scu-clk", },
>  	{ .compatible = "fsl,imx8qxp-clk", &imx_clk_scu_rsrc_imx8qxp, },
>  	{ .compatible = "fsl,imx8qm-clk", &imx_clk_scu_rsrc_imx8qm, },
> +	{ .compatible = "fsl,imx8dxl-clk", &imx_clk_scu_rsrc_imx8dxl, },
>  	{ /* sentinel */ }
>  };
>  
> diff --git a/drivers/clk/imx/clk-scu.h b/drivers/clk/imx/clk-scu.h
> index 22156e93b85d..7d8069886b0c 100644
> --- a/drivers/clk/imx/clk-scu.h
> +++ b/drivers/clk/imx/clk-scu.h
> @@ -23,6 +23,7 @@ extern struct list_head imx_scu_clks[];
>  extern const struct dev_pm_ops imx_clk_lpcg_scu_pm_ops;
>  extern const struct imx_clk_scu_rsrc_table imx_clk_scu_rsrc_imx8qxp;
>  extern const struct imx_clk_scu_rsrc_table imx_clk_scu_rsrc_imx8qm;
> +extern const struct imx_clk_scu_rsrc_table imx_clk_scu_rsrc_imx8dxl;
>  
>  int imx_clk_scu_init(struct device_node *np,
>  		     const struct imx_clk_scu_rsrc_table *data);
> -- 
> 2.31.1
>
