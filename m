Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9D5472CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbhLMNLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:11:15 -0500
Received: from mail-vi1eur05on2053.outbound.protection.outlook.com ([40.107.21.53]:10336
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231616AbhLMNLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:11:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vc4Drb+lQQyvC+wK2oOOMDfRvIfb5GIK8BMwmd+FBUcoqTY7imYLkeWrTrGWudBmEXt+KkfLk1O3gvotn39GDVE4tAMFkIab28bkEzl/z4FVKI9Yt+fPLUukIQEvonFVKhjQ9hs/b2u867rjm/VH/hfRw500/miQDoNwFDdw+dSz6ZiUrNBg9nzhmYZ8NMidwNtkM0+ZP77HUqlLKsZ9yXRo7yotBzLBIh8D5BBU1Sy2nIfeDJ8+sgJf8jskX+6KG/SNgbcAF0Y0NQmJ2C7AO9M9P2t1JuiEck7qUb3TSR0ouBSoFPnX/0lGOY/sTC/z48vGtntQSmrjHPulFTXxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsetCi7vKzoSSQwg7j9gZLWdqiAU8BBNtZDZx6c2yN0=;
 b=YZFTJYWIUFgV9EGRO7QG/5g0uCajDtQ9jK2lzpf8/niL27OQU7A9OOWBUMzhIzJ09OTXbctoTmDYSGVQTTCFNr7MT04xcojwM6mUlv4mQLj6SOKCR5Ys6AF/iGlnOHVxx5UiulBhrVQLcfDLwdXmdGK+aTpizJ0Ndx9C45U6nMZIZnzOOGS28j4XRHecjL5+PMyYdRAmeq3FHAchVogpdRv1Jut7OaGdhU5OxaLfkqu4dSYfKJIks7WBQa6FlA1VVFyx4PITnBTte7pzYrGaWahdoR2nJtW+sgoz6eb9lN2vorGLdPN3sxuSv/2nTQCN2oHG/6mbzXlEhN4OgU65+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsetCi7vKzoSSQwg7j9gZLWdqiAU8BBNtZDZx6c2yN0=;
 b=GdWj+7yNnEgIj3bAjeo1NnJysBuVN9OP1jFI23HNLAH0jxuTEca1/aajdxPhwErA+SkzIrQuvc/03ndTfJ6JtlFT+Tk60OPx5y6BiNnOR8waAsm+orOhKHw3ifUl7NCvRcfHzk34jqO3XFe+kM21mGtQMgI9iHqHwrfzui656/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 13 Dec
 2021 13:11:09 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4755.028; Mon, 13 Dec 2021
 13:11:09 +0000
Date:   Mon, 13 Dec 2021 15:11:07 +0200
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
Subject: Re: [PATCH v4 05/13] dt-bindings: imx: Add clock binding for
 i.MXRT1050
Message-ID: <YbdGayLPH2c0vRob@ryzen>
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
 <20211204061042.1248028-6-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204061042.1248028-6-Mr.Bossman075@gmail.com>
X-ClientProxiedBy: VI1PR0302CA0002.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::12) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
Received: from ryzen (188.25.169.131) by VI1PR0302CA0002.eurprd03.prod.outlook.com (2603:10a6:800:e9::12) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 13 Dec 2021 13:11:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 977aa03d-feb6-4208-b8a1-08d9be3a0784
X-MS-TrafficTypeDiagnostic: VI1PR04MB4688:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB4688B0D8E717F8FBE4D691EEF6749@VI1PR04MB4688.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvgA69aHwWTvKL29wu2e/tBf2wNvxkw5MRVuJn+Sp5GmAQVCQfPOff0RmzwYuTSkdoibvG4wCIz8497FxvrVdarai69HoySjRerjGiZkDEEL73nI+UGPqLCjD5ucmB+snX4ZKgLpEjjn8EjSU8VUBEVJmja5HDg39YcR/PVioUTQi7FkoXiLkYUpksypAV8EwQSW6fgYWdviWvVKl/mweqTG1TB9+ALLirsjnATtWvS92frUqzWO2/UKWiHI8RA0/miZ08KNcxF/oZB0aywZ+UDuSRyeY5mCT0aRKO5S02TU3qlzWnAZUoR+TR2C75BdC2SuTCUI8Fzodje0nDSS60FHS7D/hz7HGA4nBkn6WWr7E3Pr3+YFqUt+FcXe2a1NWe591af3/Va+cTsNZjMi9rHT1n1fS8OODiZBXEJwqrzD+bIiyVjYaWC0aPDci0F9IHtkjzGW95pgqo2+CG+RmP6S6hlpUPhSMPgZkqXK2rT3mZytOZPmrJQYhWurX7aK9vdM0ddFdDeHGvf++wV3lqNjcKsYkmRtasVdJH67XA60M1O01wSe/jJTRK5/ixjKP9EXygAZ1CaPJUv0He0RIA35BUMVx6NBSCmspCtRL4GtUTpMFddjwl6d6ZjZMKwSty8ZlwbbV7wkjLfCMWUuq53LqUIH701LJ5prUtibB02u4GApEUXzIYg1X8+KKXC2qKl0MmZgh6JEg5idOk0TkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(44832011)(66476007)(316002)(38350700002)(7416002)(55016003)(186003)(26005)(53546011)(33716001)(9576002)(86362001)(66556008)(66946007)(8676002)(6916009)(6496006)(8936002)(508600001)(4326008)(83380400001)(38100700002)(956004)(52116002)(9686003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i+V8aNMHa8tQsRQu05M6y3iVnjckiKvJTd+YVwJmn+DOn+vVbXPtzSMteoSD?=
 =?us-ascii?Q?0fz1PQJSUFVsjoPo07UkMNBJ1XOBNa6Co/bLAnTq0OAc8wyJsMr9eI/uURl+?=
 =?us-ascii?Q?JGUWB6gB57Fbzfb3mKbCEwqwZD7gbP9/bTl2KvwE6ysd4cwI0LwwjTewS1DV?=
 =?us-ascii?Q?NXFKjDlKYwJOy7Mta8p5m8pMbxA1ecz1f3CwgNTNvhtpmiNEStjF7pgfrSo0?=
 =?us-ascii?Q?PFiLK+nCvJqBZGe0/vwOi7pk/EF6fDNScz6LHRAGE1Vz9Fl+fDfrqTxDuPYX?=
 =?us-ascii?Q?E6b/5wM52h2EJ2AX7ZOcuQMHP0SJTb2ebf8hshRyvZ50pcOlfkhguo3ccNIY?=
 =?us-ascii?Q?jTEE3oV0i2PkDuiy6bdiUQhtiXeXiLmYaoMtGzgf9jPriHgGH/YR2rizXRjb?=
 =?us-ascii?Q?rC1QBdf5Lnn3PKDkXbP6LO+5c5Jmke9pkjXmDdqfJxFrl4tq4VHb0MOys87+?=
 =?us-ascii?Q?wmY35HnqUsKkWb2jzkaG0hGvCuOO+zXuA/EcttFdKqLK2cARXU7BM62vTZK4?=
 =?us-ascii?Q?aBwhJSchlKdKvVxzfuJPD0benSU8cuwCZvz0iLs39fgu2aUp8fdNYEW3eddx?=
 =?us-ascii?Q?OwO67t3Vt7LfRhSK8V5wY0Z+SlZHGVr5qzNEpDK3nflsTSZvQo+il2l1V29M?=
 =?us-ascii?Q?t65Z+NRkGo8WLFCe31m/vt4CEdkQT35S15sGghFHHy3sOb0VAHNAR+L6hR2G?=
 =?us-ascii?Q?wIbTrQNk6VvUgMhFfl0NrFfBI3Cl/PZOn3cJ6+mIdpKNOXbzRWqiJ5QqUyFV?=
 =?us-ascii?Q?l3wpkWQe+ApGTYiAWJ9XTqdpxB5skixWApBMFNKSPjujXvVcgy5g3czfWKFO?=
 =?us-ascii?Q?5WdOKIdn7VWKYbAic9uM+VXLAM4Najfbo7y3kmZFmF9M78fKurXo7vhNZvWr?=
 =?us-ascii?Q?02Z0sa4H2gAuIuAQTPVfl7G8+SMnj1r9JKy+JyXdYLdWfW0x/zBk/s+RD8hD?=
 =?us-ascii?Q?wBl3PlIReoYeMhhpZyvU0D5uxwRGuAjGK6SQwEuqu2BwmxHwPfYCVL70KT16?=
 =?us-ascii?Q?eVAHmg3eo/Bz7qMHbv3wvWe8U+wUtI6exX8NGVLoSRI5jWW0Bac2UJh4pWEZ?=
 =?us-ascii?Q?GKOZo8uyn59jR2uQG+MvmRm42noxjOtohUQQ1TssX4tb5ZTI+l1rxfuf5Jyw?=
 =?us-ascii?Q?vewckXJrnhbIiEhiLCRvOjB2VI+6nvfPtk/ovhUDEFFsLXN7Qm6eMebZo8Tw?=
 =?us-ascii?Q?Mpsodij98Sd3pRA1yLzOiXo2lRHny/MziK3yQgh9T0lJ73Z6/qwGvPe3zmk5?=
 =?us-ascii?Q?MZnk5I9JPAvawXAoq2UYpI6eeNHT6/FBOcoBhMlRYY4ju5ckeZ27q05aELgi?=
 =?us-ascii?Q?ZqA+yk4pTld/cc4OFermQ/b/A1gnzxIyqu2O70X9s2ienVgeW5CMDk28rl6d?=
 =?us-ascii?Q?C3PNZVYVDnPPepknPsHB+2WUMp+1BN02PSjrB/5xWvT0h+qGiQC86J93z/YA?=
 =?us-ascii?Q?KqQk0zL//IpKaM5Mq77pa9StGiF80+coodBGaVH8DG2Pr3YmOuuvn6kmvQrC?=
 =?us-ascii?Q?8zYO/apa7m72tzeaMyXAtitWGWBh8T3ZTpNgPuWcwPRaFubejSagyWEm9ao0?=
 =?us-ascii?Q?L9XKA77fGGnZui0YArBfSghf9ZxNEAncNlaeRLNGqoTkzbFAYaB8XLsLTKDC?=
 =?us-ascii?Q?aW+yJYeMfOtzDwuUD/SyzpI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977aa03d-feb6-4208-b8a1-08d9be3a0784
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 13:11:09.5103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yH+z418hwHLYAwlnfyFwiGY6kGsud8/05a/0ReqWDfvVxqqiC8pizmruVzBzzjgJsv02RjfiqT0Mp062xFj+Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-12-04 01:10:34, Jesse Taube wrote:
> From: Giulio Benetti <giulio.benetti@benettiengineering.com>
> 
> Add the clock binding doc for i.MXRT1050.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> [Giulio: added all clocks up to IMXRT1050_CLK_USBOH3]
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> [Jesse: added clocks from IMXRT1050_CLK_IPG_PDOF to
> IMXRT1050_CLK_DMA_MUX and moved IMXRT1050_CLK_END on]

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
> V1->V2:
> * Nothing done
> V2->V3:
> * Added GPT binding
> V3->V4:
> * Change License to MIT or GPL-2
> ---
>  include/dt-bindings/clock/imxrt1050-clock.h | 73 +++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 include/dt-bindings/clock/imxrt1050-clock.h
> 
> diff --git a/include/dt-bindings/clock/imxrt1050-clock.h b/include/dt-bindings/clock/imxrt1050-clock.h
> new file mode 100644
> index 000000000000..e5d26be8621a
> --- /dev/null
> +++ b/include/dt-bindings/clock/imxrt1050-clock.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright(C) 2019
> + * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_IMXRT1050_H
> +#define __DT_BINDINGS_CLOCK_IMXRT1050_H
> +
> +#define IMXRT1050_CLK_DUMMY			0
> +#define IMXRT1050_CLK_CKIL			1
> +#define IMXRT1050_CLK_CKIH			2
> +#define IMXRT1050_CLK_OSC			3
> +#define IMXRT1050_CLK_PLL2_PFD0_352M		4
> +#define IMXRT1050_CLK_PLL2_PFD1_594M		5
> +#define IMXRT1050_CLK_PLL2_PFD2_396M		6
> +#define IMXRT1050_CLK_PLL3_PFD0_720M		7
> +#define IMXRT1050_CLK_PLL3_PFD1_664_62M		8
> +#define IMXRT1050_CLK_PLL3_PFD2_508_24M		9
> +#define IMXRT1050_CLK_PLL3_PFD3_454_74M		10
> +#define IMXRT1050_CLK_PLL2_198M			11
> +#define IMXRT1050_CLK_PLL3_120M			12
> +#define IMXRT1050_CLK_PLL3_80M			13
> +#define IMXRT1050_CLK_PLL3_60M			14
> +#define IMXRT1050_CLK_PLL1_BYPASS		15
> +#define IMXRT1050_CLK_PLL2_BYPASS		16
> +#define IMXRT1050_CLK_PLL3_BYPASS		17
> +#define IMXRT1050_CLK_PLL5_BYPASS		19
> +#define IMXRT1050_CLK_PLL1_REF_SEL		20
> +#define IMXRT1050_CLK_PLL2_REF_SEL		21
> +#define IMXRT1050_CLK_PLL3_REF_SEL		22
> +#define IMXRT1050_CLK_PLL5_REF_SEL		23
> +#define IMXRT1050_CLK_PRE_PERIPH_SEL		24
> +#define IMXRT1050_CLK_PERIPH_SEL		25
> +#define IMXRT1050_CLK_SEMC_ALT_SEL		26
> +#define IMXRT1050_CLK_SEMC_SEL			27
> +#define IMXRT1050_CLK_USDHC1_SEL		28
> +#define IMXRT1050_CLK_USDHC2_SEL		29
> +#define IMXRT1050_CLK_LPUART_SEL		30
> +#define IMXRT1050_CLK_LCDIF_SEL			31
> +#define IMXRT1050_CLK_VIDEO_POST_DIV_SEL	32
> +#define IMXRT1050_CLK_VIDEO_DIV			33
> +#define IMXRT1050_CLK_ARM_PODF			34
> +#define IMXRT1050_CLK_LPUART_PODF		35
> +#define IMXRT1050_CLK_USDHC1_PODF		36
> +#define IMXRT1050_CLK_USDHC2_PODF		37
> +#define IMXRT1050_CLK_SEMC_PODF			38
> +#define IMXRT1050_CLK_AHB_PODF			39
> +#define IMXRT1050_CLK_LCDIF_PRED		40
> +#define IMXRT1050_CLK_LCDIF_PODF		41
> +#define IMXRT1050_CLK_USDHC1			42
> +#define IMXRT1050_CLK_USDHC2			43
> +#define IMXRT1050_CLK_LPUART1			44
> +#define IMXRT1050_CLK_SEMC			45
> +#define IMXRT1050_CLK_LCDIF_APB			46
> +#define IMXRT1050_CLK_PLL1_ARM			47
> +#define IMXRT1050_CLK_PLL2_SYS			48
> +#define IMXRT1050_CLK_PLL3_USB_OTG		49
> +#define IMXRT1050_CLK_PLL4_AUDIO		50
> +#define IMXRT1050_CLK_PLL5_VIDEO		51
> +#define IMXRT1050_CLK_PLL6_ENET			52
> +#define IMXRT1050_CLK_PLL7_USB_HOST		53
> +#define IMXRT1050_CLK_LCDIF_PIX			54
> +#define IMXRT1050_CLK_USBOH3			55
> +#define IMXRT1050_CLK_IPG_PDOF			56
> +#define IMXRT1050_CLK_PER_CLK_SEL		57
> +#define IMXRT1050_CLK_PER_PDOF			58
> +#define IMXRT1050_CLK_DMA			59
> +#define IMXRT1050_CLK_DMA_MUX			60
> +#define IMXRT1050_CLK_GPT			70
> +#define IMXRT1050_CLK_END			71
> +
> +#endif /* __DT_BINDINGS_CLOCK_IMXRT1050_H */
> -- 
> 2.34.0
>
