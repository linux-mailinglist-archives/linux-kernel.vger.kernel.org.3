Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175074C0FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbiBWKGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiBWKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:06:33 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63EE8A6D4;
        Wed, 23 Feb 2022 02:06:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fd4RkrWN7FjnYFuVuaEM+c83aML/eUJ+KsrBPe+h5E4UsycyORdWUFZhV3ZfeL2UXWHsIxi5nbkIHLxf9TEiVwtOAsyLlS7Q59NOZA/SEPaY+0TYDFIh7zUNtTbjDWAWZZtcjbvR6Zo/vKLvoOFmC7YT6HlMCgmxRGmCJj+sYrL45GMrWDBQOnq66LfD3902kVQnhTyy0A9QXNGW3oG1Zm/rvkbMu5mlcgYN7kfd0y92KsNdpXWKQNM2kQFrA2gCAbPP8qlwKkqDnb5vrvzkXQXadvxWdA2TgauXK+crx7+xIbuFCUhwj6Kwx6uQ/jiEcnU8J9FW/4bwz0CZOqRsYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBMtEJ5bYzzj4X9km9DfvSBDTLvYo281Oabd+PTVask=;
 b=EC7Pfx2auARo25pHVNSwvTRaijC8xgE/rIY3tLPrAfyQYR8MZHJYtDc1s4cj2AqVxaT9USdpFnI6IlTLO7TlC1bAuZqyLkAws35uP8Re+9jUVWAGZSMcyXwIFiERZZactUCYjS0oKLC9wKawVx1/T1DjIPWRQn3J871fe4jpeK9EYO/XQQBgC8uSAELDDHvgtyVAwR92T04DmK4eCOLhjfewEuXb7KfBnswP3egEIhIrFqeW2/TC694J+QPa5o3jurTlRea1mzfYiRDSOlUcAg30Pv/lIBLaoiSIBl83nHST4az9b1/NO0IYmXl3Vj6sHPNuUbtWfRpUNSyXbXDslQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBMtEJ5bYzzj4X9km9DfvSBDTLvYo281Oabd+PTVask=;
 b=IlInizlsgQEOsi2ppcUEo7eDspTCc1Q1t7i513vUDu0GZ1B20RiKfgzO10df9iv8xZnwPgfQIwN7ilhruvV2E6McYoXWqkQeSYcR+8kFDcDWmElamhoOB2wxjpbrVYV0xBtgMnJ1OCdUnpb8Q279sNDmO7NGpt/RQDMRzaVgOBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM0PR04MB4482.eurprd04.prod.outlook.com (2603:10a6:208:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 10:06:02 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f%6]) with mapi id 15.20.4995.026; Wed, 23 Feb 2022
 10:06:02 +0000
Date:   Wed, 23 Feb 2022 12:06:00 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 4/5] clk: imx: support fracn gppll
Message-ID: <YhYHCJgMyHKIYwIi@abelvesa>
References: <20220223064358.4097307-1-peng.fan@oss.nxp.com>
 <20220223064358.4097307-5-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220223064358.4097307-5-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VE1PR03CA0052.eurprd03.prod.outlook.com
 (2603:10a6:803:118::41) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1841a11b-e5b8-45fb-aea5-08d9f6b418b9
X-MS-TrafficTypeDiagnostic: AM0PR04MB4482:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB44827114A94BCC6DF225CE42F63C9@AM0PR04MB4482.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ue1Csi9TxwvEUpmuW0MyWPn2m60NWCjRpYmcmzDGB19RezXXkKhLEqrtgSL7LsPL+lf4eRw8ikeB3k+eZPvYpLxeFjseaARaC54Mo08R2w/Bgbx8Ru2EdL6EW4oNs2EJiNgMi6ZdGyT5OX1aVBpX0pIu1EUxCeF7Qgizhc26HCnrgl95rB8U81Q8FAlulhF6WZI533EY4xmWHCf63SSur2NLw3u/bWdaho83fA95x4nUT1Mnq3UB0S2lycYZz2LqDqX95QGJKGOn0+a9V98ahThMY4a/VEYU2LAQTjPmbRaV7PaLvuVgU1eOM+d/FoancnKg9W0bK+nse+CzRhQFl+qB8RyYaD4X+9bAsXDJ4oJs7gtvtihH2zKNllFylpQIO5bo9Dad4PBzRUyN7csZ7Kge6CLu1Pobg78sHH8+feM06o2xechUWN/kZ1ADTM6W5Rp94Eqt3whh0lxn/nUOlZm8WILXuQK98bYUEwhjN2OI2EsabH90CVHvUUEBiyjbE6j2ha7nR/eVQkv+Vz+Myzc/N1rJCbtA7mk83flYGgAGd0SSiK3av4yTE+Y9HvKb2klNfYuD7R/BZPQWckqwqwUM9Rj5YW56FRc3kIoA5sA/vDm7KwaOHzeQ04w8cQT6LhJK/TKtTPhZ4yszrFPdyG+SHFqZLuAfGARv4UB/3K/caCSEAHzUFchzQPWEFpEIhaayKPAqOWHk1SpCqPjwBHVuFyeiSEZmq5BBzIfW0dnRA+0HYQgtm5aNhmTjkNYZ2ohvwT0wPbu7eEi4w4yyZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(52116002)(53546011)(8936002)(7416002)(5660300002)(6506007)(9686003)(6512007)(30864003)(316002)(38100700002)(83380400001)(38350700002)(44832011)(8676002)(66946007)(26005)(508600001)(66476007)(66556008)(6862004)(6486002)(33716001)(4326008)(186003)(2906002)(86362001)(56820400005)(54580400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW9NbU9CS1dFWDZOcjFwbGxMNUd1MjRJSGtGMVpxZFdQTGFOdTE2MmUzQWZQ?=
 =?utf-8?B?N29hQTAwdzJmQWE3MmZtZElrVE1xTkpUVzZucmhoT203NWNSSzYzdjBTdnAx?=
 =?utf-8?B?SllSdmhjNGw1K0ZFKzJCK0ZJV3JwYjJpYkJTNCtpNWJ6MmJaeUVtOUhOOVhk?=
 =?utf-8?B?alJzTTVhaWpjL0VjalgrSDBMcHFZdHBmakp1UHhSOXBUeWdhcnVaV3ZBNEdP?=
 =?utf-8?B?RStSQ21iSXNBOHVMS05MVnM5N3I0bUh3N09iY2U5NkF1c3JVYWMzVFNrK1Vu?=
 =?utf-8?B?UTNzVlk3S2FhdFpmOWNOTVBjWXdsbTIxd0JoRDZnaTVrRTJKL3RmelFhMmRH?=
 =?utf-8?B?cEJsalZOay9RdGdvNktKVks0QU15Z29VeWlvNm9tUE5HajFNY2xrZDl5M1Zz?=
 =?utf-8?B?d08ycTJJVTIzR21xbW4ySEc5MFFibmw1Vmp5RUtRUkRmZnZ5Y1VzeUVYV1hZ?=
 =?utf-8?B?cUdvRmwwNmk5c3JTbVNXOERHcXZiVE9wV1pMaVdHYllPdFo0YzYwS0IrT1Rk?=
 =?utf-8?B?U09QQlI3SkhKUittaFVRMUlDWHZIVExydDVKalVjVnZ5b2pJUXZYY1VVbnhW?=
 =?utf-8?B?a01yU1h5ZUlSc1ZFMW9mMTdLWXptZldtaWNLMkUxeVE0VjlXcXIrQllFVmlx?=
 =?utf-8?B?cHFoUlZiKytUMk00RmwxYjBGZVJmWFF2dUkrZ1FBYTREY1FVejYzUEI5bmhG?=
 =?utf-8?B?SitCbU9OTHdGaWtzQml1bGNXaFU4cTIzWnhnLzliM0xDbFljQjl6aTZ6amFh?=
 =?utf-8?B?VWVEbFUvRUtoc1Nia21VNmd4ZklrVy8wN1ZzWUg1UUJHb2lNbk1FOHRVU0Np?=
 =?utf-8?B?VHJURWJVamQrYVQ0M05KLzNVNmk0SHZqUm9pSXNQRjh4OTlkZy9YeGEwVjNU?=
 =?utf-8?B?YWU5TWRrUjBFT2s0TTZnc0V0akFUenhYaklheEg5M2Mxc3ZxWlZIc3dnNzE2?=
 =?utf-8?B?T29tZ2E0bWRwL1BTeHlGZ0VCb2ptbHR5VEVzVE1MOTF5bVhXYnpuV2NBaW54?=
 =?utf-8?B?Yng4V3U5RTM5N1dISmt5V2pUOFlkNjd4L2o3MTJYNHBRbENWQTMrQXpFUjlo?=
 =?utf-8?B?OGFKV2VMb3M2MjcrOC9FOWVQM2lnNVVCWlBJalZoRUdXZGFBUk00ZFBFdGJu?=
 =?utf-8?B?R3lEQURScXVoT2t6YlVhZzJDR3Fza1ZOQkJwQWl0TTdrRDliSzRMcFl3MHV6?=
 =?utf-8?B?UEcxSCtwNG5xVzR4R1VQR0dsZyt5TC8ycWZWR2RZYXVhckRsd2ZuMXRmN3dm?=
 =?utf-8?B?N2JlS3FtY1ZJSkZGNk9BRzRXMFkxNVoxNHd4Y3FLK3kxdkFaTXFITzBkdUVk?=
 =?utf-8?B?NGxWM3hUZ1ZtYmF3N1lqdXhNUFVhQmlxMWEzYUJNQU9raWdhVjM5RHZFbTZv?=
 =?utf-8?B?OFA1MUpVTzFLdXptekYzMldrVDhOMFpCdFljOUNwYWNFME1hZUo4SCtIbXJP?=
 =?utf-8?B?UHBHeFQ4QUw0NnJ1aHlxV001SXFKUjNzd3kxam1HZWV4M2UxbklOaWt6ODNa?=
 =?utf-8?B?RkVpY083cTZXNFZ1czF1SzVMOEhyeXEveFE2N0tYVWIzclZaRmhrL1lHR3pS?=
 =?utf-8?B?a1pNUGJpU0FTS3lQSUdVdm1DWGFMMlhmRGlXTHRhMUNvM2o0WGRIeGtOdmR3?=
 =?utf-8?B?d0NQYy9qRG9KU20ybHhLaGdyN3lWd1BIZWNMOUZoQ0wrT3IxNGhCdDg4VXRV?=
 =?utf-8?B?YWtZWU5IWjJYaUpWWUE1aW9RZlhWYmpzMko1aVV6MXg1ejgya3pyQk14dnZT?=
 =?utf-8?B?OHcwQW04Ui9XR0pvV0NwYVI1bEZPTEdrNDRzRnZ6RmYwYXh0K2ViTENFQk9F?=
 =?utf-8?B?RjZlNlRleUpnZHNHbWNGU2tyQTFwWWFnVGhiZ0F3MmYwR0ladlBJTngrTkh4?=
 =?utf-8?B?bTJHSDJEVVNvbDNwWWF0eEI2dEFHQ2xPVXM2TW16UExCaGRhYjBlUFNTbmlZ?=
 =?utf-8?B?VUo3VlBkSW5rOGlsQjRkUll2Y3dtYTAxNGdwd2hRdWZLZXIxSXVmMVRXdVU3?=
 =?utf-8?B?L0pvYjVVeWtqU1pDQlFVK3RVdTQ3d2FyQjRaT3VhTHVqR0xpaWRUWG5WVE9n?=
 =?utf-8?B?Z3NJUzFUdE9ZSTlaTkNTMW43VkJKczBZbkx1MnNveGQ0QjVwdnkyY2pMTDcz?=
 =?utf-8?B?UmZQbXV3dTVZcU5mdUVCejhhU0pwaHlUcWJQRnVjNFptOW5UMzVJb1crT2tj?=
 =?utf-8?Q?NOAVdnHc1eOcuQOBs9ZEQIo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1841a11b-e5b8-45fb-aea5-08d9f6b418b9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 10:06:02.0878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZh9V1CiClbf7Uwq55Vg4TnkSQcwCt3BNw0IxxNzdM3VVym3e/lkDSLbaHxlKKTlGPl4/IBs7rrMFE8OdXSM6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-23 14:43:57, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This PLL module is a Fractional-N synthesizer,
> supporting 30-bit numerator and denominator. Numerator is a signed
> number. It has feature to adjust fractional portion of feedback
> divider dynamically. This fracn gppll is used in i.MX93.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/Makefile          |   1 +
>  drivers/clk/imx/clk-fracn-gppll.c | 328 ++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h             |  21 ++
>  3 files changed, 350 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
> 
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 36c04922d789..60c8a4bb7574 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -5,6 +5,7 @@ mxc-clk-objs += clk-busy.o
>  mxc-clk-objs += clk-composite-7ulp.o
>  mxc-clk-objs += clk-composite-8m.o
>  mxc-clk-objs += clk-composite-93.o
> +mxc-clk-objs += clk-fracn-gppll.o
>  mxc-clk-objs += clk-cpu.o
>  mxc-clk-objs += clk-divider-gate.o
>  mxc-clk-objs += clk-fixup-div.o
> diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
> new file mode 100644
> index 000000000000..6c9946a4bdb7
> --- /dev/null
> +++ b/drivers/clk/imx/clk-fracn-gppll.c
> @@ -0,0 +1,328 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 NXP
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +
> +#include "clk.h"
> +
> +#define PLL_CTRL		0x0
> +#define CLKMUX_BYPASS		BIT(2)
> +#define CLKMUX_EN		BIT(1)
> +#define POWERUP_MASK		BIT(0)
> +
> +#define PLL_ANA_PRG		0x10
> +#define PLL_SPREAD_SPECTRUM	0x30
> +
> +#define PLL_NUMERATOR		0x40
> +#define PLL_MFN_MASK		GENMASK(31, 2)
> +#define PLL_MFN_SHIFT		2
> +
> +#define PLL_DENOMINATOR		0x50
> +#define PLL_MFD_MASK		GENMASK(29, 0)
> +
> +#define PLL_DIV			0x60
> +#define PLL_MFI_MASK		GENMASK(24, 16)
> +#define PLL_MFI_SHIFT		16
> +#define PLL_RDIV_MASK		GENMASK(15, 13)
> +#define PLL_RDIV_SHIFT		13
> +#define PLL_ODIV_MASK		GENMASK(7, 0)
> +
> +#define PLL_DFS_CTRL(x)		(0x70 + (x) * 0x10)
> +
> +#define PLL_STATUS		0xF0
> +#define LOCK_STATUS		BIT(0)
> +
> +#define DFS_STATUS		0xF4
> +
> +#define LOCK_TIMEOUT_US		200
> +
> +#define PLL_FRACN_GP(_rate, _mfi, _mfn, _mfd, _rdiv, _odiv)	\
> +	{							\
> +		.rate	=	(_rate),			\
> +		.mfi	=	(_mfi),				\
> +		.mfn	=	(_mfn),				\
> +		.mfd	=	(_mfd),				\
> +		.rdiv	=	(_rdiv),			\
> +		.odiv	=	(_odiv),			\
> +	}
> +
> +struct clk_fracn_gppll {
> +	struct clk_hw			hw;
> +	void __iomem			*base;
> +	const struct imx_fracn_gppll_rate_table *rate_table;
> +	int rate_count;
> +};
> +
> +#define to_clk_fracn_gppll(_hw) container_of(_hw, struct clk_fracn_gppll, hw)
> +
> +/*
> + * Fvco = 𝐹𝑟𝑒𝑓∙(𝑀𝐹𝐼+𝑀𝐹𝑁/𝑀𝐹𝐷)
> + * Fout = Fvco / (rdiv * odiv)
> + */
> +static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
> +	PLL_FRACN_GP(650000000U, 81, 0, 0, 0, 3),
> +	PLL_FRACN_GP(594000000U, 198, 0, 0, 0, 8),
> +	PLL_FRACN_GP(560000000U, 70, 0, 0, 0, 3),
> +	PLL_FRACN_GP(400000000U, 50, 0, 0, 0, 3),
> +	PLL_FRACN_GP(393216000U, 81, 92, 100, 0, 5)
> +};
> +
> +struct imx_fracn_gppll_clk imx_fracn_gppll = {
> +	.rate_table = fracn_tbl,
> +	.rate_count = ARRAY_SIZE(fracn_tbl),
> +};
> +EXPORT_SYMBOL_GPL(imx_fracn_gppll);
> +
> +static const struct imx_fracn_gppll_rate_table *
> +imx_get_pll_settings(struct clk_fracn_gppll *pll, unsigned long rate)
> +{
> +	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
> +	int i;
> +
> +	for (i = 0; i < pll->rate_count; i++)
> +		if (rate == rate_table[i].rate)
> +			return &rate_table[i];
> +
> +	return NULL;
> +}
> +
> +static long clk_fracn_gppll_round_rate(struct clk_hw *hw, unsigned long rate,
> +				       unsigned long *prate)
> +{
> +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> +	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
> +	int i;
> +
> +	/* Assumming rate_table is in descending order */
> +	for (i = 0; i < pll->rate_count; i++)
> +		if (rate >= rate_table[i].rate)
> +			return rate_table[i].rate;
> +
> +	if (i == pll->rate_count)
> +		pr_err("Not able to round rate for %s: %lu\n", clk_hw_get_name(hw), rate);
> +
> +	/* return minimum supported value */
> +	return rate_table[i - 1].rate;
> +}
> +
> +static unsigned long clk_fracn_gppll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> +	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
> +	u32 pll_numerator, pll_denominator, pll_div;
> +	u32 mfi, mfn, mfd, rdiv, odiv;
> +	u64 fvco = parent_rate;
> +	long rate = 0;
> +	int i;
> +
> +	pll_numerator = readl_relaxed(pll->base + PLL_NUMERATOR);
> +	mfn = (pll_numerator & PLL_MFN_MASK) >> PLL_MFN_SHIFT;
> +
> +	pll_denominator = readl_relaxed(pll->base + PLL_DENOMINATOR);
> +	mfd = pll_denominator & PLL_MFD_MASK;
> +
> +	pll_div = readl_relaxed(pll->base + PLL_DIV);
> +	mfi = (pll_div & PLL_MFI_MASK) >> PLL_MFI_SHIFT;
> +
> +	rdiv = (pll_div & PLL_RDIV_MASK) >> PLL_RDIV_SHIFT;
> +	rdiv = rdiv + 1;
> +	odiv = pll_div & PLL_ODIV_MASK;
> +	switch (odiv) {
> +	case 0:
> +		odiv = 2;
> +		break;
> +	case 1:
> +		odiv = 3;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	/*
> +	 * Sometimes, the recalculated rate has deviation due to
> +	 * the frac part. So find the accurate pll rate from the table
> +	 * first, if no match rate in the table, use the rate calculated
> +	 * from the equation below.
> +	 */
> +	for (i = 0; i < pll->rate_count; i++) {
> +		if (rate_table[i].mfn == mfn && rate_table[i].mfi == mfi &&
> +		    rate_table[i].mfd == mfd && rate_table[i].rdiv == rdiv &&
> +		    rate_table[i].odiv == odiv)
> +			rate = rate_table[i].rate;
> +	}
> +
> +	/* Fvco = 𝐹𝑟𝑒𝑓∙(𝑀𝐹𝐼+𝑀𝐹𝑁/𝑀𝐹𝐷) */
> +	fvco = fvco * mfi + fvco * mfn / mfd;
> +
> +	do_div(fvco, rdiv * odiv);
> +
> +	return rate ? (unsigned long) rate : (unsigned long)fvco;
> +}
> +
> +static int clk_fracn_gppll_wait_lock(struct clk_fracn_gppll *pll)
> +{
> +	u32 val;
> +
> +	return readl_poll_timeout(pll->base + PLL_STATUS, val,
> +				  val & LOCK_STATUS, 0, LOCK_TIMEOUT_US);
> +}
> +
> +static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
> +				    unsigned long prate)
> +{
> +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> +	const struct imx_fracn_gppll_rate_table *rate;
> +	u32 tmp, pll_div, ana_mfn;
> +	int ret;
> +
> +	rate = imx_get_pll_settings(pll, drate);
> +	if (!rate) {
> +		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
> +			drate, clk_hw_get_name(hw));
> +		return -EINVAL;
> +	}
> +
> +	/* Disable output */
> +	tmp = readl_relaxed(pll->base + PLL_CTRL);
> +	tmp &= ~CLKMUX_EN;
> +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> +
> +	/* Power Down */
> +	tmp &= ~POWERUP_MASK;
> +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> +
> +	/* Disable BYPASS */
> +	tmp &= ~CLKMUX_BYPASS;
> +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> +
> +	pll_div = (rate->rdiv << PLL_RDIV_SHIFT) | rate->odiv | (rate->mfi << PLL_MFI_SHIFT);
> +	writel_relaxed(pll_div, pll->base + PLL_DIV);
> +	writel_relaxed(rate->mfd, pll->base + PLL_DENOMINATOR);
> +	writel_relaxed(rate->mfn << PLL_MFN_SHIFT, pll->base + PLL_NUMERATOR);
> +
> +	/* Wait for 5us according to fracn mode pll doc */
> +	udelay(5);
> +
> +	/* Enable Powerup */
> +	tmp |= POWERUP_MASK;
> +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> +
> +	/* Wait Lock*/
> +	ret = clk_fracn_gppll_wait_lock(pll);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable output */
> +	tmp |= CLKMUX_EN;
> +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> +
> +	ana_mfn = (readl_relaxed(pll->base + PLL_STATUS) & PLL_MFN_MASK) >> PLL_MFN_SHIFT;
> +
> +	WARN(ana_mfn != rate->mfn, "ana_mfn != rate->mfn\n");
> +
> +	return 0;
> +}
> +
> +static int clk_fracn_gppll_prepare(struct clk_hw *hw)
> +{
> +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> +	u32 val;
> +	int ret;
> +
> +	val = readl_relaxed(pll->base + PLL_CTRL);
> +	if (val & POWERUP_MASK)
> +		return 0;
> +
> +	val |= CLKMUX_BYPASS;
> +	writel_relaxed(val, pll->base + PLL_CTRL);
> +
> +	val |= POWERUP_MASK;
> +	writel_relaxed(val, pll->base + PLL_CTRL);
> +
> +	val |= CLKMUX_EN;
> +	writel_relaxed(val, pll->base + PLL_CTRL);
> +
> +	ret = clk_fracn_gppll_wait_lock(pll);
> +	if (ret)
> +		return ret;
> +
> +	val &= ~CLKMUX_BYPASS;
> +	writel_relaxed(val, pll->base + PLL_CTRL);
> +
> +	return 0;
> +}
> +
> +static int clk_fracn_gppll_is_prepared(struct clk_hw *hw)
> +{
> +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> +	u32 val;
> +
> +	val = readl_relaxed(pll->base + PLL_CTRL);
> +
> +	return (val & POWERUP_MASK) ? 1 : 0;
> +}
> +
> +static void clk_fracn_gppll_unprepare(struct clk_hw *hw)
> +{
> +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> +	u32 val;
> +
> +	val = readl_relaxed(pll->base + PLL_CTRL);
> +	val &= ~POWERUP_MASK;
> +	writel_relaxed(val, pll->base + PLL_CTRL);
> +}
> +
> +static const struct clk_ops clk_fracn_gppll_ops = {
> +	.prepare	= clk_fracn_gppll_prepare,
> +	.unprepare	= clk_fracn_gppll_unprepare,
> +	.is_prepared	= clk_fracn_gppll_is_prepared,
> +	.recalc_rate	= clk_fracn_gppll_recalc_rate,
> +	.round_rate	= clk_fracn_gppll_round_rate,
> +	.set_rate	= clk_fracn_gppll_set_rate,
> +};
> +
> +struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
> +				   const struct imx_fracn_gppll_clk *pll_clk)
> +{
> +	struct clk_fracn_gppll *pll;
> +	struct clk_hw *hw;
> +	struct clk_init_data init;
> +	int ret;
> +	u32 val;

Unused. I'll drop it and squash it in myself.

> +
> +	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.flags = pll_clk->flags;
> +	init.parent_names = &parent_name;
> +	init.num_parents = 1;
> +	init.ops = &clk_fracn_gppll_ops;
> +
> +	pll->base = base;
> +	pll->hw.init = &init;
> +	pll->rate_table = pll_clk->rate_table;
> +	pll->rate_count = pll_clk->rate_count;
> +
> +	hw = &pll->hw;
> +
> +	ret = clk_hw_register(NULL, hw);
> +	if (ret) {
> +		pr_err("%s: failed to register pll %s %d\n", __func__, name, ret);
> +		kfree(pll);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return hw;
> +}
> +EXPORT_SYMBOL_GPL(imx_clk_fracn_gppll);
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index 63eb7c53b123..a7cbbcd1a3f4 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -72,6 +72,27 @@ extern struct imx_pll14xx_clk imx_1416x_pll;
>  extern struct imx_pll14xx_clk imx_1443x_pll;
>  extern struct imx_pll14xx_clk imx_1443x_dram_pll;
>  
> +/* NOTE: Rate table should be kept sorted in descending order. */
> +struct imx_fracn_gppll_rate_table {
> +	unsigned int rate;
> +	unsigned int mfi;
> +	unsigned int mfn;
> +	unsigned int mfd;
> +	unsigned int rdiv;
> +	unsigned int odiv;
> +};
> +
> +struct imx_fracn_gppll_clk {
> +	const struct imx_fracn_gppll_rate_table *rate_table;
> +	int rate_count;
> +	int flags;
> +};
> +
> +struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
> +				   const struct imx_fracn_gppll_clk *pll_clk);
> +
> +extern struct imx_fracn_gppll_clk imx_fracn_gppll;
> +
>  #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \
>  	to_clk(imx_clk_hw_cpu(name, parent_name, div, mux, pll, step))
>  
> -- 
> 2.25.1
>
