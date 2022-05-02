Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBD5516D5D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbiEBJbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384229AbiEBJb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:31:28 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB9A2E699;
        Mon,  2 May 2022 02:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChznO03LlzycaVlh59eN9bIuJwqbYVSIUdnknTKFUTbPJOCtV5DEIpQ7+7pUV+8PyTTM5TZbQPiqCaGvsTGPezbW51FBQqwoHBz6uxbNmnWz0xy3/gDMiuklZ4/s5/ta5LhrPgTnu2NZSkyrNovlrQv10hWSKtLRnSirEVbj3pIYcULi3QyGNUYDxh3ZDzmTjfuQEtlo65hxTckF8JmsNa9KGzW+qyp1bJlvbyb8Vq5hqzmRy1OgHr1FxvyxPO5PmGTMNvCJKUacaDH29TsdIr86e+CSo7RFhikmdDKSb+7a27r7vp8i4b7NeoLW4N+hvH3453E2NAlJoBZsmiiZRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnUAca+XzuCAIpZGUiFX6zHpXUBXBdKEWlcX55FIMus=;
 b=QNsVwaH8bWpfBoh/Iymeh/4E0wwv2DpDXyf7Zal36irUQZ/Zf9ZMnoQEbbP9mTf//PHw+cuKsdvraWkGjWVO4deT9RpLRvhypqdY4SpxlLdk7aM4dOUpPnMLcaSeapq+H3pOA+ph4zUgyf5XUFj/0s1Xb7AawJNGFj6AEkDE65vQqF+c4NEpilWNlhcrgX9mzqWBMHKL+8D0nz8dYuD7HFGo6syWFu0Lxf1MpSctLit8MSl17YAzv58A+xNVav2YHlvAdS0Ax2u7Nwyov33N9u2tA+3RbmJiBEKyho+axGdPpb6Hn9RRYtWhpTbUX1sQ8Bbv3YKZ6tt9s2wnorvzvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnUAca+XzuCAIpZGUiFX6zHpXUBXBdKEWlcX55FIMus=;
 b=F1TbTjJERWqgsuUfz6MMsHBXxWerg8m4JdgduEld8T09EeONPxtFvj/4HIvdiRDLt75ynWzagI76b2cqfWkZeuDHiXj9FRY58Emgr6nr0lOeMC3KvXAJHtF/UNLvpWdzRVZG5f1SiOE+LPsIl0BgI5R6W++81/3zG9nvgJiB/QQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DB7PR04MB3980.eurprd04.prod.outlook.com (2603:10a6:5:25::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Mon, 2 May
 2022 09:27:53 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::78d8:955a:7946:fd78]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::78d8:955a:7946:fd78%6]) with mapi id 15.20.5206.013; Mon, 2 May 2022
 09:27:53 +0000
Date:   Mon, 2 May 2022 12:27:50 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org, linux@armlinux.org.uk,
        dev@lynxeye.de, marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 11/15] clk: imx: Add initial support for i.MXRT1170
 clock driver
Message-ID: <Ym+kFq4Bo6u+JzSe@abelvesa>
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
 <20220428214838.1040278-12-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428214838.1040278-12-Mr.Bossman075@gmail.com>
X-ClientProxiedBy: VI1PR0102CA0039.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::16) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f26e8c7-1dcd-4a0f-f612-08da2c1e0847
X-MS-TrafficTypeDiagnostic: DB7PR04MB3980:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <DB7PR04MB398070A655649B0245B2F79AF6C19@DB7PR04MB3980.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zm7N0S1kOc/t/2NqisBCPrZvd8Eyl/bvPS8ThD3YbK1cuk6rwJ92BjN+ijpPXIW+YwBVN4Am4Jgj+5c5cSdCeSCu5c6LB1kJPj/5PBxvUl4lPUZ5TJpR5lIyn8cBwBRvooaGaworXdu2hP4WEGRvQzEucwikZO1MF4T/QrKx+F+dACSbtaU45Ek7807tqiOjRTz2/MBwgLuwF62dHNiJs5jC8XJn9lX5oNxu1FVjHfGWxgaWjxnbulmYdq1p/NwpnyUhA+1M3L143b9YEZjfLi644WqAhrzxKuFwVmpGzbepoFSFPTsuPXlA+HgvszsQk7zo1yiWByfJBpeYQ1bu7TpAEkSw5+wqTLUbkNOYutFx3Aj6UTdUXUJFMmGv4760yJMkV3HT9+B52ZXKyRFMueGsCp5rpoNYnfcnbdsktrQiNneM64RktrcdvNqMHhc7riUVV/LN1k9NX+cCMaVJhYZINS7SzwhZRZr2PrMD/hHFtVq+YmNUTkuiqE3q+5LV8AKmDBUfQ2U/OAGeldOYgYGwCk0Teg8HMtqNYUT3yg7mHeq9c3OQz69vCkd9kUjvp3eacY+LaPIuh7eElokTawd1WXelgFjEgEar4SdBd50EK0zBvRs9nzXwlCFHGCGHltKuXiMwOyeSw8wrerEzoH7tGHZaI7p0IojlFOd7EJFDTTFEpvMEm+P3jM7sKM1QzyZqx+h9Je5yHLGfHV+7lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(4326008)(66556008)(2906002)(66946007)(66476007)(8676002)(53546011)(6512007)(6506007)(33716001)(9686003)(316002)(6486002)(83380400001)(26005)(6916009)(86362001)(186003)(38100700002)(7416002)(38350700002)(44832011)(8936002)(508600001)(52116002)(5660300002)(30864003)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rpr9V1UUX6AFEkRYwTSKQIm6Kw9JW/tQs/GsuDRn+jM3ENtKTSJBbKn/7w3d?=
 =?us-ascii?Q?hc6m8LEwKTztSQ+PbW8ef9Qd4LZEYe29ikRIiuYx7Vla2rluHnhWiFGXPd/j?=
 =?us-ascii?Q?1S8HWWdHyMnYndsyXEGuW6gQAB5ZsYpJocXJWC+OnBZxpkLRCWdu0g7onZZP?=
 =?us-ascii?Q?r92TOKSLVFGpcv1he8iJlOgRs0CDW0bpkMqRfKX//hCLn0c4o3TqrtC5XIiO?=
 =?us-ascii?Q?vDWs65ssMF8MkY/5ka+nySf35gv6XBy0YbWSXhuDVHHkIpXsT6MhK/bYlwR5?=
 =?us-ascii?Q?FyRxhPecVh/cLAW9uXrQN0Of4qLHZWlfuGPVIyR6GuH8Y/BiM7LW+ES0Lmun?=
 =?us-ascii?Q?9dpbloFKHnnEheqorElcO9wk88FlDZQaKcV51CYO5vSbBKJiaL85mD7VNOQ0?=
 =?us-ascii?Q?3cKx/hvRHuSMBXqvMeKx4VrM2qN+E1BggrUiC5FwdRPyPqMooyqKtfq4sf3K?=
 =?us-ascii?Q?Dr0cQCLGvXKktzlwPfUqQ2mCdyVyDXeIuUKhzLTGDr2Z6gZ/CAiMxoV2Kxa9?=
 =?us-ascii?Q?rlbFx76kZ/JzFLxpmJwLI39pyDaeL3063l4JibJrDh/ZWgZe/33WBla7nhMZ?=
 =?us-ascii?Q?BTvTSarq1TxbIEz/VYp7b++IP675p/ZU5GfyVX7YXbq9JETOFk6U9yDh9hYU?=
 =?us-ascii?Q?cQqvvuoehk6RoL5tvW4GNhgQ3nZDWkw98gXwV0qYZ0PAdFwa2cHn/mJFr35R?=
 =?us-ascii?Q?2bjpSINZxigvFVIkx17S7tAnnerpyEk77aMtNo0UGO0Wq+bg24+8/W7fLpFV?=
 =?us-ascii?Q?rkCQT/d9wNtUXynxmMvJ+N3jQ0l669n07xpML3oVwbzmQqJyFzJRXYd0xEnU?=
 =?us-ascii?Q?ABjo+jFp8FkwEuDvWWl7qk04rNgfoAWSUFA+SGJU39/3y4lb3L1+qWh/WA1P?=
 =?us-ascii?Q?mfrG4JTaZqYhjFdN5nSmiwgnidF3JQZ3p0k3MBvYOZoIPTkzTOxTkIsJ2RLT?=
 =?us-ascii?Q?iAP0m+PYzUkgwgPCfmCxvsis1s5+hX151a39sFBp+E0tmbUrbCq947ckbwj7?=
 =?us-ascii?Q?hkf7vJkrjd8aPvgZdXjZaX0vaCMJQAjNx+Fw2MDkQp4PpRibBNYbAOSmbg/G?=
 =?us-ascii?Q?XHog3m9vyVvRv8d+D/brVjp2NytBqjwB+kQv9X4EySMTihEZNRsqsxjU8TmB?=
 =?us-ascii?Q?GMJH5Fe8YoFS902WEiqcZnlwmmeHMFzRcRcBrZL9hBuUbMF6fNwh0VpvFSa4?=
 =?us-ascii?Q?EIhxFgCyPBomnFOZhslZKuPJSGLYM+w6yGCwm9EXYE0odV0lUEbZT4+Uy2C6?=
 =?us-ascii?Q?6+D1wTzhlwSOyX9teDQZj66rKl62yYVEGED5Uj7AQqtpG1I6jICHSFePwK9G?=
 =?us-ascii?Q?ifg/sDtjQO+KBQ/DrY4tybj0VhkKY4nU7byyaf8wqplMi6gU4VSu0o3fsmay?=
 =?us-ascii?Q?OaJYxI59HvCrUiH5+LSlJ40yDg1vTq2OpC3qfXJ3R3NBISENp0B6cUltByOn?=
 =?us-ascii?Q?O9l7z6tRDY1wka+F7PPMLId/ywYuu3MkiUyzWpXkNqShhaitmbOHXe3sODvP?=
 =?us-ascii?Q?YULFJTlvK8t0VsFGz+z/Gj+NUdjV2k43+MojYFDaqoVNQ13bpPJqUA7dsANz?=
 =?us-ascii?Q?5Qow5wqkPu0Op1GgO3vaVXOm3WJMWUIFvPSQ2pbaDbr2U5rjCcrIdN//dBcw?=
 =?us-ascii?Q?yJqwiPHhtiFNw0OUUv3GcT7gj9xzTSNgZ/+De88qnEAn1QtCUlr9uopTw01O?=
 =?us-ascii?Q?lf7sBj6JM3EmS+GCd5qmAKzkEwG9IBiN6DsYdXhiQeVSDrJ1Z8f9ldndC85R?=
 =?us-ascii?Q?kIkabNaY3A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f26e8c7-1dcd-4a0f-f612-08da2c1e0847
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 09:27:52.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/Py0L9neEdBGoruEiiUbvBt9MAPa3oaY6Li8S7BLtk44WPqCMjEoI3bjWpkhGQKlT6WrM2u9LyQTB3QdXyGmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3980
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-28 17:48:34, Jesse Taube wrote:
> Add clock driver support for i.MXRT1170.
>
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1 -> V2:
>  - Add slab.h and clock-provider.h
>  - Add spaces in `root_clocks`
>  - Expand and sort macro
>  - Move `clk_hw` structs to `clocks_probe`
>  - Remove of_irq.h
>  - Remove unused code/comments
> ---
>  drivers/clk/imx/Kconfig         |   7 +
>  drivers/clk/imx/Makefile        |   1 +
>  drivers/clk/imx/clk-imxrt1170.c | 536 ++++++++++++++++++++++++++++++++
>  3 files changed, 544 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-imxrt1170.c
>
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index 45641b8bdc50..009adbe8059f 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -112,3 +112,10 @@ config CLK_IMXRT1050
>  	select MXC_CLK
>  	help
>  	    Build the driver for i.MXRT1050 CCM Clock Driver
> +
> +config CLK_IMXRT1170
> +	tristate "IMXRT1170 CCM Clock Driver"
> +	depends on SOC_IMXRT
> +	select MXC_CLK
> +	help
> +	    Build the driver for i.MXRT1170 CCM Clock Driver
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 1e13c5cb37d9..0968d9ffcf6b 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -47,4 +47,5 @@ obj-$(CONFIG_CLK_IMX6UL) += clk-imx6ul.o
>  obj-$(CONFIG_CLK_IMX7D)  += clk-imx7d.o
>  obj-$(CONFIG_CLK_IMX7ULP) += clk-imx7ulp.o
>  obj-$(CONFIG_CLK_IMXRT1050)  += clk-imxrt1050.o
> +obj-$(CONFIG_CLK_IMXRT1170)  += clk-imxrt1170.o
>  obj-$(CONFIG_CLK_VF610)  += clk-vf610.o
> diff --git a/drivers/clk/imx/clk-imxrt1170.c b/drivers/clk/imx/clk-imxrt1170.c
> new file mode 100644
> index 000000000000..bcae3b687be6
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imxrt1170.c
> @@ -0,0 +1,536 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) 2022
> + * Author(s):
> + * Jesse Taube <Mr.Bossman075@gmail.com>
> + */
> +#include <linux/clk.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/imxrt1170-clock.h>
> +
> +#include "clk.h"
> +
> +#define CLOCK_MUX_DEFAULT "rcosc48M_div2", "osc", "rcosc400M", "rcosc16M"
> +
> +#define LPCG_GATE(gate) (0x6000 + (gate * 0x20))
> +
> +enum root_clock_names {
> +	m7,
> +	m4,
> +	bus,
> +	bus_lpsr,
> +	semc,
> +	cssys,
> +	cstrace,
> +	m4_systick,
> +	m7_systick,
> +	adc1,
> +	adc2,
> +	acmp,
> +	flexio1,
> +	flexio2,
> +	gpt1,
> +	gpt2,
> +	gpt3,
> +	gpt4,
> +	gpt5,
> +	gpt6,
> +	flexspi1,
> +	flexspi2,
> +	can1,
> +	can2,
> +	can3,
> +	lpuart1,
> +	lpuart2,
> +	lpuart3,
> +	lpuart4,
> +	lpuart5,
> +	lpuart6,
> +	lpuart7,
> +	lpuart8,
> +	lpuart9,
> +	lpuart10,
> +	lpuart11,
> +	lpuart12,
> +	lpi2c1,
> +	lpi2c2,
> +	lpi2c3,
> +	lpi2c4,
> +	lpi2c5,
> +	lpi2c6,
> +	lpspi1,
> +	lpspi2,
> +	lpspi3,
> +	lpspi4,
> +	lpspi5,
> +	lpspi6,
> +	emv1,
> +	emv2,
> +	enet1,
> +	enet2,
> +	enet_qos,
> +	enet_25m,
> +	enet_timer1,
> +	enet_timer2,
> +	enet_timer3,
> +	usdhc1,
> +	usdhc2,
> +	asrc,
> +	mqs,
> +	mic,
> +	spdif,
> +	sai1,
> +	sai2,
> +	sai3,
> +	sai4,
> +	gc355,
> +	lcdif,
> +	lcdifv2,
> +	mipi_ref,
> +	mipi_esc,
> +	csi2,
> +	csi2_esc,
> +	csi2_ui,
> +	csi,
> +	cko1,
> +	cko2,
> +	end,
> +};
> +
> +static const char * const root_clocks[79][8] = {
> +	{ CLOCK_MUX_DEFAULT, "pll_arm", "pll1_sys", "pll3_sys", "pll_video" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_sys", "pll1_div5" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_sys", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_sys", "pll1_div5" },
> +	{ CLOCK_MUX_DEFAULT, "pll1_div5", "pll2_sys", "pll2_pfd1", "pll3_pfd0" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },

Please drop these entirely. This root clock array is used multiple
times thoughout. And so goes for the rest of them. Moreover, this is
hard to keep track of. Imagine what happens if someone comes around and
tries to fix a parent for one of the lpuarts.

Just do what the other i.MX clock drivers do. Add dedicated arrays that
are unique and that's it. There aren't that many.

> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_pfd1", "pll2_sys" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd0", "pll1_div5" },
> +	{ CLOCK_MUX_DEFAULT, "pll2_sys", "pll3_div2", "pll1_div5", "pll2_pfd0" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_sys", "pll1_div5", "pll_audio", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll3_pfd2", "pll3_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll_audio", "pll_video" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll_audio", "pll_video" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll3_pfd2", "pll3_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll3_pfd2", "pll3_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll3_pfd2", "pll3_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd0", "pll2_sys", "pll2_pfd2", "pll3_sys" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd0", "pll2_sys", "pll2_pfd2", "pll3_sys" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll3_pfd2", "pll1_div5" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll3_pfd2", "pll1_div5" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1" },
> +	{ CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1" },
> +	{ CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1" },
> +	{ CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1" },
> +	{ CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1" },
> +	{ CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1" },
> +	{ CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1" },
> +	{ CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll2_pfd0", "pll1_div5", "pll_arm" },
> +	{ CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll2_pfd0", "pll1_div5", "pll_arm" },
> +	{ CLOCK_MUX_DEFAULT, "pll1_div5", "pll3_div2", "pll_audio", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll1_div5", "pll3_div2", "pll_audio", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll_audio", "pll1_div5" },
> +	{ CLOCK_MUX_DEFAULT, "pll_audio", "pll3_sys", "pll3_pfd2", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll_audio", "pll3_pfd2", "pll1_div5", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll_audio", "pll3_pfd2", "pll1_div5", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll_audio", "pll3_pfd2", "pll1_div5", "pll2_pfd3" },
> +	{ CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll_audio", "pll1_div5" },
> +	{ CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd1", "pll3_sys", "pll_video" },
> +	{ CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd2", "pll3_pfd0", "pll_video" },
> +	{ CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd2", "pll3_pfd0", "pll_video" },
> +	{ CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd0", "pll3_pfd0", "pll_video" },
> +	{ CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd0", "pll3_pfd0", "pll_video" },
> +	{ CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll3_sys", "pll2_pfd0", "pll_video" },
> +	{ CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll3_sys", "pll2_pfd0", "pll_video" },
> +	{ CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll3_sys", "pll2_pfd0", "pll_video" },
> +	{ CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll3_sys", "pll3_pfd1", "pll_video" },
> +	{ CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll2_sys", "pll3_pfd1", "pll1_div5" },
> +	{ CLOCK_MUX_DEFAULT, "pll2_pfd3", "rcosc48M", "pll3_pfd1", "pll_audio"}
> +};
> +
> +static const char * const pll_arm_mux[] = {"pll_arm_pre", "osc"};
> +static const char * const pll3_mux[] = {"pll3_pre", "osc"};
> +static const char * const pll2_mux[] = {"pll2_pre", "osc"};
> +
> +static const struct clk_div_table post_div_table[] = {
> +	{ .val = 3, .div = 1, },
> +	{ .val = 2, .div = 8, },
> +	{ .val = 1, .div = 4, },
> +	{ .val = 0, .div = 2, },
> +	{ }
> +};
> +
> +static int imxrt1170_clocks_probe(struct platform_device *pdev)
> +{
> +	void __iomem *ccm_base;
> +	void __iomem *pll_base;
> +	struct clk_hw **hws;
> +	struct clk_hw_onecell_data *clk_hw_data;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *anp;
> +	int ret;
> +
> +	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
> +					  IMXRT1170_CLK_END), GFP_KERNEL);
> +	if (WARN_ON(!clk_hw_data))
> +		return -ENOMEM;
> +
> +	clk_hw_data->num = IMXRT1170_CLK_END;
> +	hws = clk_hw_data->hws;
> +
> +	hws[IMXRT1170_CLK_OSC] = imx_obtain_fixed_clk_hw(np, "osc");
> +	hws[IMXRT1170_CLK_RCOSC_16M] = imx_obtain_fixed_clk_hw(np, "rcosc16M");
> +	hws[IMXRT1170_CLK_OSC_32K] = imx_obtain_fixed_clk_hw(np, "osc32k");
> +
> +	hws[IMXRT1170_CLK_RCOSC_48M] = imx_clk_hw_fixed_factor("rcosc48M",  "rcosc16M", 3, 1);
> +	hws[IMXRT1170_CLK_RCOSC_400M] = imx_clk_hw_fixed_factor("rcosc400M",  "rcosc16M", 25, 1);
> +	hws[IMXRT1170_CLK_RCOSC_48M_DIV2] = imx_clk_hw_fixed_factor("rcosc48M_div2",  "rcosc48M", 1, 2);
> +
> +	anp = of_find_compatible_node(NULL, NULL, "fsl,imxrt-anatop");
> +	pll_base = of_iomap(anp, 0);
> +	of_node_put(anp);
> +	if (WARN_ON(!pll_base))
> +		return -ENOMEM;
> +
> +	/* Anatop clocks */
> +	hws[IMXRT1170_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0UL);
> +
> +	hws[IMXRT1170_CLK_PLL_ARM_PRE] = imx_clk_hw_pllv3(IMX_PLLV3_SYSV2, "pll_arm_pre", "osc", pll_base + 0x200, 0xff);
> +	imx_clk_hw_pll3_powerbit(hws[IMXRT1170_CLK_PLL_ARM_PRE], 13);
> +	hws[IMXRT1170_CLK_PLL_ARM_BYPASS] = imx_clk_hw_mux("pll_arm_bypass",
> +		pll_base + 0x200, 17, 1, pll_arm_mux, 2);
> +	hws[IMXRT1170_CLK_PLL_ARM_DIV] = clk_hw_register_divider_table(NULL, "pll_arm_div",
> +		"pll_arm_bypass", CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
> +		pll_base + 0x200, 15, 2, 0, post_div_table, &imx_ccm_lock);
> +	hws[IMXRT1170_CLK_PLL_ARM] = imx_clk_hw_gate("pll_arm", "pll_arm_div", pll_base + 0x200, 14);
> +
> +	hws[IMXRT1170_CLK_PLL3_PRE] = imx_clk_hw_pllv3(IMX_PLLV3_GENERICV2, "pll3_pre", "osc", pll_base + 0x210, 0x1);
> +	imx_clk_hw_pll3_powerbit(hws[IMXRT1170_CLK_PLL3_PRE], 21);
> +	hws[IMXRT1170_CLK_PLL3_BYPASS] = imx_clk_hw_mux("pll3_bypass",
> +		pll_base + 0x210, 16, 1, pll3_mux, 2);
> +	hws[IMXRT1170_CLK_PLL3] = imx_clk_hw_gate("pll3_sys", "pll3_bypass", pll_base + 0x210, 13);
> +
> +	hws[IMXRT1170_CLK_PLL2_PRE] = imx_clk_hw_pllv3(IMX_PLLV3_GENERICV2, "pll2_pre", "osc", pll_base + 0x240, 0x1);
> +	imx_clk_hw_pll3_powerbit(hws[IMXRT1170_CLK_PLL2_PRE], 23);
> +	hws[IMXRT1170_CLK_PLL2_BYPASS] = imx_clk_hw_mux("pll2_bypass",
> +		pll_base + 0x240, 16, 1, pll2_mux, 2);
> +	hws[IMXRT1170_CLK_PLL2] = imx_clk_hw_gate("pll2_sys", "pll2_bypass", pll_base + 0x240, 13);
> +
> +	hws[IMXRT1170_CLK_PLL3_PFD0] = imx_clk_hw_pfd("pll3_pfd0", "pll3_sys", pll_base + 0x230, 0);
> +	hws[IMXRT1170_CLK_PLL3_PFD1] = imx_clk_hw_pfd("pll3_pfd1", "pll3_sys", pll_base + 0x230, 1);
> +	hws[IMXRT1170_CLK_PLL3_PFD2] = imx_clk_hw_pfd("pll3_pfd2", "pll3_sys", pll_base + 0x230, 2);
> +	hws[IMXRT1170_CLK_PLL3_PFD3] = imx_clk_hw_pfd("pll3_pfd3", "pll3_sys", pll_base + 0x230, 3);
> +	hws[IMXRT1170_CLK_PLL3_DIV2_GATE] = imx_clk_hw_fixed_factor("pll3_div2_gate", "pll3_sys", 1, 2);
> +	hws[IMXRT1170_CLK_PLL3_DIV2] = imx_clk_hw_gate("pll3_div2", "pll3_sys", pll_base + 0x210, 3);
> +
> +	hws[IMXRT1170_CLK_PLL2_PFD0] = imx_clk_hw_pfd("pll2_pfd0", "pll2_sys", pll_base + 0x270, 0);
> +	hws[IMXRT1170_CLK_PLL2_PFD1] = imx_clk_hw_pfd("pll2_pfd1", "pll2_sys", pll_base + 0x270, 1);
> +	hws[IMXRT1170_CLK_PLL2_PFD2] = imx_clk_hw_pfd("pll2_pfd2", "pll2_sys", pll_base + 0x270, 2);
> +	hws[IMXRT1170_CLK_PLL2_PFD3] = imx_clk_hw_pfd("pll2_pfd3", "pll2_sys", pll_base + 0x270, 3);
> +
> +	/* CCM clocks */
> +	ccm_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (WARN_ON(IS_ERR(ccm_base)))
> +		return PTR_ERR(ccm_base);
> +
> +	hws[IMXRT1170_CLK_M7_SEL] = imx_clk_hw_mux("m7_sel", ccm_base + (m7 * 0x80), 8, 3, root_clocks[m7], 8);
> +	hws[IMXRT1170_CLK_M4_SEL] = imx_clk_hw_mux("m4_sel", ccm_base + (m4 * 0x80), 8, 3, root_clocks[m4], 8);
> +	hws[IMXRT1170_CLK_BUS_SEL] = imx_clk_hw_mux("bus_sel", ccm_base + (bus * 0x80), 8, 3, root_clocks[bus], 8);
> +	hws[IMXRT1170_CLK_BUS_LPSR_SEL] = imx_clk_hw_mux("bus_lpsr_sel", ccm_base + (bus_lpsr * 0x80), 8, 3, root_clocks[bus_lpsr], 8);
> +	hws[IMXRT1170_CLK_SEMC_SEL] = imx_clk_hw_mux("semc_sel", ccm_base + (semc * 0x80), 8, 3, root_clocks[semc], 8);
> +	hws[IMXRT1170_CLK_CSSYS_SEL] = imx_clk_hw_mux("cssys_sel", ccm_base + (cssys * 0x80), 8, 3, root_clocks[cssys], 8);
> +	hws[IMXRT1170_CLK_CSTRACE_SEL] = imx_clk_hw_mux("cstrace_sel", ccm_base + (cstrace * 0x80), 8, 3, root_clocks[cstrace], 8);
> +	hws[IMXRT1170_CLK_M4_SYSTICK_SEL] = imx_clk_hw_mux("m4_systick_sel", ccm_base + (m4_systick * 0x80), 8, 3, root_clocks[m4_systick], 8);
> +	hws[IMXRT1170_CLK_M7_SYSTICK_SEL] = imx_clk_hw_mux("m7_systick_sel", ccm_base + (m7_systick * 0x80), 8, 3, root_clocks[m7_systick], 8);
> +	hws[IMXRT1170_CLK_ADC1_SEL] = imx_clk_hw_mux("adc1_sel", ccm_base + (adc1 * 0x80), 8, 3, root_clocks[adc1], 8);
> +	hws[IMXRT1170_CLK_ADC2_SEL] = imx_clk_hw_mux("adc2_sel", ccm_base + (adc2 * 0x80), 8, 3, root_clocks[adc2], 8);
> +	hws[IMXRT1170_CLK_ACMP_SEL] = imx_clk_hw_mux("acmp_sel", ccm_base + (acmp * 0x80), 8, 3, root_clocks[acmp], 8);
> +	hws[IMXRT1170_CLK_FLEXIO1_SEL] = imx_clk_hw_mux("flexio1_sel", ccm_base + (flexio1 * 0x80), 8, 3, root_clocks[flexio1], 8);
> +	hws[IMXRT1170_CLK_FLEXIO2_SEL] = imx_clk_hw_mux("flexio2_sel", ccm_base + (flexio2 * 0x80), 8, 3, root_clocks[flexio2], 8);
> +	hws[IMXRT1170_CLK_GPT1_SEL] = imx_clk_hw_mux("gpt1_sel", ccm_base + (gpt1 * 0x80), 8, 3, root_clocks[gpt1], 8);
> +	hws[IMXRT1170_CLK_GPT2_SEL] = imx_clk_hw_mux("gpt2_sel", ccm_base + (gpt2 * 0x80), 8, 3, root_clocks[gpt2], 8);
> +	hws[IMXRT1170_CLK_GPT3_SEL] = imx_clk_hw_mux("gpt3_sel", ccm_base + (gpt3 * 0x80), 8, 3, root_clocks[gpt3], 8);
> +	hws[IMXRT1170_CLK_GPT4_SEL] = imx_clk_hw_mux("gpt4_sel", ccm_base + (gpt4 * 0x80), 8, 3, root_clocks[gpt4], 8);
> +	hws[IMXRT1170_CLK_GPT5_SEL] = imx_clk_hw_mux("gpt5_sel", ccm_base + (gpt5 * 0x80), 8, 3, root_clocks[gpt5], 8);
> +	hws[IMXRT1170_CLK_GPT6_SEL] = imx_clk_hw_mux("gpt6_sel", ccm_base + (gpt6 * 0x80), 8, 3, root_clocks[gpt6], 8);
> +	hws[IMXRT1170_CLK_FLEXSPI1_SEL] = imx_clk_hw_mux("flexspi1_sel", ccm_base + (flexspi1 * 0x80), 8, 3, root_clocks[flexspi1], 8);
> +	hws[IMXRT1170_CLK_FLEXSPI2_SEL] = imx_clk_hw_mux("flexspi2_sel", ccm_base + (flexspi2 * 0x80), 8, 3, root_clocks[flexspi2], 8);
> +	hws[IMXRT1170_CLK_CAN1_SEL] = imx_clk_hw_mux("can1_sel", ccm_base + (can1 * 0x80), 8, 3, root_clocks[can1], 8);
> +	hws[IMXRT1170_CLK_CAN2_SEL] = imx_clk_hw_mux("can2_sel", ccm_base + (can2 * 0x80), 8, 3, root_clocks[can2], 8);
> +	hws[IMXRT1170_CLK_CAN3_SEL] = imx_clk_hw_mux("can3_sel", ccm_base + (can3 * 0x80), 8, 3, root_clocks[can3], 8);
> +	hws[IMXRT1170_CLK_LPUART1_SEL] = imx_clk_hw_mux("lpuart1_sel", ccm_base + (lpuart1 * 0x80), 8, 3, root_clocks[lpuart1], 8);
> +	hws[IMXRT1170_CLK_LPUART2_SEL] = imx_clk_hw_mux("lpuart2_sel", ccm_base + (lpuart2 * 0x80), 8, 3, root_clocks[lpuart2], 8);
> +	hws[IMXRT1170_CLK_LPUART3_SEL] = imx_clk_hw_mux("lpuart3_sel", ccm_base + (lpuart3 * 0x80), 8, 3, root_clocks[lpuart3], 8);
> +	hws[IMXRT1170_CLK_LPUART4_SEL] = imx_clk_hw_mux("lpuart4_sel", ccm_base + (lpuart4 * 0x80), 8, 3, root_clocks[lpuart4], 8);
> +	hws[IMXRT1170_CLK_LPUART5_SEL] = imx_clk_hw_mux("lpuart5_sel", ccm_base + (lpuart5 * 0x80), 8, 3, root_clocks[lpuart5], 8);
> +	hws[IMXRT1170_CLK_LPUART6_SEL] = imx_clk_hw_mux("lpuart6_sel", ccm_base + (lpuart6 * 0x80), 8, 3, root_clocks[lpuart6], 8);
> +	hws[IMXRT1170_CLK_LPUART7_SEL] = imx_clk_hw_mux("lpuart7_sel", ccm_base + (lpuart7 * 0x80), 8, 3, root_clocks[lpuart7], 8);
> +	hws[IMXRT1170_CLK_LPUART8_SEL] = imx_clk_hw_mux("lpuart8_sel", ccm_base + (lpuart8 * 0x80), 8, 3, root_clocks[lpuart8], 8);
> +	hws[IMXRT1170_CLK_LPUART9_SEL] = imx_clk_hw_mux("lpuart9_sel", ccm_base + (lpuart9 * 0x80), 8, 3, root_clocks[lpuart9], 8);
> +	hws[IMXRT1170_CLK_LPUART10_SEL] = imx_clk_hw_mux("lpuart10_sel", ccm_base + (lpuart10 * 0x80), 8, 3, root_clocks[lpuart10], 8);
> +	hws[IMXRT1170_CLK_LPUART11_SEL] = imx_clk_hw_mux("lpuart11_sel", ccm_base + (lpuart11 * 0x80), 8, 3, root_clocks[lpuart11], 8);
> +	hws[IMXRT1170_CLK_LPUART12_SEL] = imx_clk_hw_mux("lpuart12_sel", ccm_base + (lpuart12 * 0x80), 8, 3, root_clocks[lpuart12], 8);
> +	hws[IMXRT1170_CLK_LPI2C1_SEL] = imx_clk_hw_mux("lpi2c1_sel", ccm_base + (lpi2c1 * 0x80), 8, 3, root_clocks[lpi2c1], 8);
> +	hws[IMXRT1170_CLK_LPI2C2_SEL] = imx_clk_hw_mux("lpi2c2_sel", ccm_base + (lpi2c2 * 0x80), 8, 3, root_clocks[lpi2c2], 8);
> +	hws[IMXRT1170_CLK_LPI2C3_SEL] = imx_clk_hw_mux("lpi2c3_sel", ccm_base + (lpi2c3 * 0x80), 8, 3, root_clocks[lpi2c3], 8);
> +	hws[IMXRT1170_CLK_LPI2C4_SEL] = imx_clk_hw_mux("lpi2c4_sel", ccm_base + (lpi2c4 * 0x80), 8, 3, root_clocks[lpi2c4], 8);
> +	hws[IMXRT1170_CLK_LPI2C5_SEL] = imx_clk_hw_mux("lpi2c5_sel", ccm_base + (lpi2c5 * 0x80), 8, 3, root_clocks[lpi2c5], 8);
> +	hws[IMXRT1170_CLK_LPI2C6_SEL] = imx_clk_hw_mux("lpi2c6_sel", ccm_base + (lpi2c6 * 0x80), 8, 3, root_clocks[lpi2c6], 8);
> +	hws[IMXRT1170_CLK_LPSPI1_SEL] = imx_clk_hw_mux("lpspi1_sel", ccm_base + (lpspi1 * 0x80), 8, 3, root_clocks[lpspi1], 8);
> +	hws[IMXRT1170_CLK_LPSPI2_SEL] = imx_clk_hw_mux("lpspi2_sel", ccm_base + (lpspi2 * 0x80), 8, 3, root_clocks[lpspi2], 8);
> +	hws[IMXRT1170_CLK_LPSPI3_SEL] = imx_clk_hw_mux("lpspi3_sel", ccm_base + (lpspi3 * 0x80), 8, 3, root_clocks[lpspi3], 8);
> +	hws[IMXRT1170_CLK_LPSPI4_SEL] = imx_clk_hw_mux("lpspi4_sel", ccm_base + (lpspi4 * 0x80), 8, 3, root_clocks[lpspi4], 8);
> +	hws[IMXRT1170_CLK_LPSPI5_SEL] = imx_clk_hw_mux("lpspi5_sel", ccm_base + (lpspi5 * 0x80), 8, 3, root_clocks[lpspi5], 8);
> +	hws[IMXRT1170_CLK_LPSPI6_SEL] = imx_clk_hw_mux("lpspi6_sel", ccm_base + (lpspi6 * 0x80), 8, 3, root_clocks[lpspi6], 8);
> +	hws[IMXRT1170_CLK_EMV1_SEL] = imx_clk_hw_mux("emv1_sel", ccm_base + (emv1 * 0x80), 8, 3, root_clocks[emv1], 8);
> +	hws[IMXRT1170_CLK_EMV2_SEL] = imx_clk_hw_mux("emv2_sel", ccm_base + (emv2 * 0x80), 8, 3, root_clocks[emv2], 8);
> +	hws[IMXRT1170_CLK_ENET1_SEL] = imx_clk_hw_mux("enet1_sel", ccm_base + (enet1 * 0x80), 8, 3, root_clocks[enet1], 8);
> +	hws[IMXRT1170_CLK_ENET2_SEL] = imx_clk_hw_mux("enet2_sel", ccm_base + (enet2 * 0x80), 8, 3, root_clocks[enet2], 8);
> +	hws[IMXRT1170_CLK_ENET_QOS_SEL] = imx_clk_hw_mux("enet_qos_sel", ccm_base + (enet_qos * 0x80), 8, 3, root_clocks[enet_qos], 8);
> +	hws[IMXRT1170_CLK_ENET_25M_SEL] = imx_clk_hw_mux("enet_25m_sel", ccm_base + (enet_25m * 0x80), 8, 3, root_clocks[enet_25m], 8);
> +	hws[IMXRT1170_CLK_ENET_TIMER1_SEL] = imx_clk_hw_mux("enet_timer1_sel", ccm_base + (enet_timer1 * 0x80), 8, 3, root_clocks[enet_timer1], 8);
> +	hws[IMXRT1170_CLK_ENET_TIMER2_SEL] = imx_clk_hw_mux("enet_timer2_sel", ccm_base + (enet_timer2 * 0x80), 8, 3, root_clocks[enet_timer2], 8);
> +	hws[IMXRT1170_CLK_ENET_TIMER3_SEL] = imx_clk_hw_mux("enet_timer3_sel", ccm_base + (enet_timer3 * 0x80), 8, 3, root_clocks[enet_timer3], 8);
> +	hws[IMXRT1170_CLK_USDHC1_SEL] = imx_clk_hw_mux("usdhc1_sel", ccm_base + (usdhc1 * 0x80), 8, 3, root_clocks[usdhc1], 8);
> +	hws[IMXRT1170_CLK_USDHC2_SEL] = imx_clk_hw_mux("usdhc2_sel", ccm_base + (usdhc2 * 0x80), 8, 3, root_clocks[usdhc2], 8);
> +	hws[IMXRT1170_CLK_ASRC_SEL] = imx_clk_hw_mux("asrc_sel", ccm_base + (asrc * 0x80), 8, 3, root_clocks[asrc], 8);
> +	hws[IMXRT1170_CLK_MQS_SEL] = imx_clk_hw_mux("mqs_sel", ccm_base + (mqs * 0x80), 8, 3, root_clocks[mqs], 8);
> +	hws[IMXRT1170_CLK_MIC_SEL] = imx_clk_hw_mux("mic_sel", ccm_base + (mic * 0x80), 8, 3, root_clocks[mic], 8);
> +	hws[IMXRT1170_CLK_SPDIF_SEL] = imx_clk_hw_mux("spdif_sel", ccm_base + (spdif * 0x80), 8, 3, root_clocks[spdif], 8);
> +	hws[IMXRT1170_CLK_SAI1_SEL] = imx_clk_hw_mux("sai1_sel", ccm_base + (sai1 * 0x80), 8, 3, root_clocks[sai1], 8);
> +	hws[IMXRT1170_CLK_SAI2_SEL] = imx_clk_hw_mux("sai2_sel", ccm_base + (sai2 * 0x80), 8, 3, root_clocks[sai2], 8);
> +	hws[IMXRT1170_CLK_SAI3_SEL] = imx_clk_hw_mux("sai3_sel", ccm_base + (sai3 * 0x80), 8, 3, root_clocks[sai3], 8);
> +	hws[IMXRT1170_CLK_SAI4_SEL] = imx_clk_hw_mux("sai4_sel", ccm_base + (sai4 * 0x80), 8, 3, root_clocks[sai4], 8);
> +	hws[IMXRT1170_CLK_GC355_SEL] = imx_clk_hw_mux("gc355_sel", ccm_base + (gc355 * 0x80), 8, 3, root_clocks[gc355], 8);
> +	hws[IMXRT1170_CLK_LCDIF_SEL] = imx_clk_hw_mux("lcdif_sel", ccm_base + (lcdif * 0x80), 8, 3, root_clocks[lcdif], 8);
> +	hws[IMXRT1170_CLK_LCDIFV2_SEL] = imx_clk_hw_mux("lcdifv2_sel", ccm_base + (lcdifv2 * 0x80), 8, 3, root_clocks[lcdifv2], 8);
> +	hws[IMXRT1170_CLK_MIPI_REF_SEL] = imx_clk_hw_mux("mipi_ref_sel", ccm_base + (mipi_ref * 0x80), 8, 3, root_clocks[mipi_ref], 8);
> +	hws[IMXRT1170_CLK_MIPI_ESC_SEL] = imx_clk_hw_mux("mipi_esc_sel", ccm_base + (mipi_esc * 0x80), 8, 3, root_clocks[mipi_esc], 8);
> +	hws[IMXRT1170_CLK_CSI2_SEL] = imx_clk_hw_mux("csi2_sel", ccm_base + (csi2 * 0x80), 8, 3, root_clocks[csi2], 8);
> +	hws[IMXRT1170_CLK_CSI2_ESC_SEL] = imx_clk_hw_mux("csi2_esc_sel", ccm_base + (csi2_esc * 0x80), 8, 3, root_clocks[csi2_esc], 8);
> +	hws[IMXRT1170_CLK_CSI2_UI_SEL] = imx_clk_hw_mux("csi2_ui_sel", ccm_base + (csi2_ui * 0x80), 8, 3, root_clocks[csi2_ui], 8);
> +	hws[IMXRT1170_CLK_CSI_SEL] = imx_clk_hw_mux("csi_sel", ccm_base + (csi * 0x80), 8, 3, root_clocks[csi], 8);
> +	hws[IMXRT1170_CLK_CKO1_SEL] = imx_clk_hw_mux("cko1_sel", ccm_base + (cko1 * 0x80), 8, 3, root_clocks[cko1], 8);
> +	hws[IMXRT1170_CLK_CKO2_SEL] = imx_clk_hw_mux("cko2_sel", ccm_base + (cko2 * 0x80), 8, 3, root_clocks[cko2], 8);
> +
> +	hws[IMXRT1170_CLK_M7_GATE] = imx_clk_hw_gate_dis_flags("m7_gate", "m7_sel", ccm_base + (m7 * 0x80), 24, CLK_IS_CRITICAL);
> +	hws[IMXRT1170_CLK_M4_GATE] = imx_clk_hw_gate_dis_flags("m4_gate", "m4_sel", ccm_base + (m4 * 0x80), 24, CLK_IS_CRITICAL);
> +	hws[IMXRT1170_CLK_BUS_GATE] = imx_clk_hw_gate_dis_flags("bus_gate", "bus_sel", ccm_base + (bus * 0x80), 24, CLK_IS_CRITICAL);
> +	hws[IMXRT1170_CLK_BUS_LPSR_GATE] = imx_clk_hw_gate_dis_flags("bus_lpsr_gate", "bus_lpsr_sel", ccm_base + (bus_lpsr * 0x80), 24, CLK_IS_CRITICAL);
> +	hws[IMXRT1170_CLK_SEMC_GATE] = imx_clk_hw_gate_dis_flags("semc_gate", "semc_sel", ccm_base + (semc * 0x80), 24, CLK_IS_CRITICAL);
> +	hws[IMXRT1170_CLK_CSSYS_GATE] = imx_clk_hw_gate_dis_flags("cssys_gate", "cssys_sel", ccm_base + (cssys * 0x80), 24, CLK_IS_CRITICAL);
> +	hws[IMXRT1170_CLK_CSTRACE_GATE] = imx_clk_hw_gate_dis_flags("cstrace_gate", "cstrace_sel", ccm_base + (cstrace * 0x80), 24, CLK_IS_CRITICAL);
> +	hws[IMXRT1170_CLK_M4_SYSTICK_GATE] = imx_clk_hw_gate_dis_flags("m4_systick_gate", "m4_systick_sel", ccm_base + (m4_systick * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_M7_SYSTICK_GATE] = imx_clk_hw_gate_dis_flags("m7_systick_gate", "m7_systick_sel", ccm_base + (m7_systick * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_ADC1_GATE] = imx_clk_hw_gate_dis_flags("adc1_gate", "adc1_sel", ccm_base + (adc1 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_ADC2_GATE] = imx_clk_hw_gate_dis_flags("adc2_gate", "adc2_sel", ccm_base + (adc2 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_ACMP_GATE] = imx_clk_hw_gate_dis_flags("acmp_gate", "acmp_sel", ccm_base + (acmp * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_FLEXIO1_GATE] = imx_clk_hw_gate_dis_flags("flexio1_gate", "flexio1_sel", ccm_base + (flexio1 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_FLEXIO2_GATE] = imx_clk_hw_gate_dis_flags("flexio2_gate", "flexio2_sel", ccm_base + (flexio2 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_GPT1_GATE] = imx_clk_hw_gate_dis_flags("gpt1_gate", "gpt1_sel", ccm_base + (gpt1 * 0x80), 24, CLK_IS_CRITICAL);
> +	hws[IMXRT1170_CLK_GPT2_GATE] = imx_clk_hw_gate_dis_flags("gpt2_gate", "gpt2_sel", ccm_base + (gpt2 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_GPT3_GATE] = imx_clk_hw_gate_dis_flags("gpt3_gate", "gpt3_sel", ccm_base + (gpt3 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_GPT4_GATE] = imx_clk_hw_gate_dis_flags("gpt4_gate", "gpt4_sel", ccm_base + (gpt4 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_GPT5_GATE] = imx_clk_hw_gate_dis_flags("gpt5_gate", "gpt5_sel", ccm_base + (gpt5 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_GPT6_GATE] = imx_clk_hw_gate_dis_flags("gpt6_gate", "gpt6_sel", ccm_base + (gpt6 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_FLEXSPI1_GATE] = imx_clk_hw_gate_dis_flags("flexspi1_gate", "flexspi1_sel", ccm_base + (flexspi1 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_FLEXSPI2_GATE] = imx_clk_hw_gate_dis_flags("flexspi2_gate", "flexspi2_sel", ccm_base + (flexspi2 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_CAN1_GATE] = imx_clk_hw_gate_dis_flags("can1_gate", "can1_sel", ccm_base + (can1 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_CAN2_GATE] = imx_clk_hw_gate_dis_flags("can2_gate", "can2_sel", ccm_base + (can2 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_CAN3_GATE] = imx_clk_hw_gate_dis_flags("can3_gate", "can3_sel", ccm_base + (can3 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPUART1_GATE] = imx_clk_hw_gate_dis_flags("lpuart1_gate", "lpuart1_sel", ccm_base + (lpuart1 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPUART2_GATE] = imx_clk_hw_gate_dis_flags("lpuart2_gate", "lpuart2_sel", ccm_base + (lpuart2 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPUART3_GATE] = imx_clk_hw_gate_dis_flags("lpuart3_gate", "lpuart3_sel", ccm_base + (lpuart3 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPUART4_GATE] = imx_clk_hw_gate_dis_flags("lpuart4_gate", "lpuart4_sel", ccm_base + (lpuart4 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPUART5_GATE] = imx_clk_hw_gate_dis_flags("lpuart5_gate", "lpuart5_sel", ccm_base + (lpuart5 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPUART6_GATE] = imx_clk_hw_gate_dis_flags("lpuart6_gate", "lpuart6_sel", ccm_base + (lpuart6 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPUART7_GATE] = imx_clk_hw_gate_dis_flags("lpuart7_gate", "lpuart7_sel", ccm_base + (lpuart7 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPUART8_GATE] = imx_clk_hw_gate_dis_flags("lpuart8_gate", "lpuart8_sel", ccm_base + (lpuart8 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPUART9_GATE] = imx_clk_hw_gate_dis_flags("lpuart9_gate", "lpuart9_sel", ccm_base + (lpuart9 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPUART10_GATE] = imx_clk_hw_gate_dis_flags("lpuart10_gate", "lpuart10_sel", ccm_base + (lpuart10 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPUART11_GATE] = imx_clk_hw_gate_dis_flags("lpuart11_gate", "lpuart11_sel", ccm_base + (lpuart11 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPUART12_GATE] = imx_clk_hw_gate_dis_flags("lpuart12_gate", "lpuart12_sel", ccm_base + (lpuart12 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPI2C1_GATE] = imx_clk_hw_gate_dis_flags("lpi2c1_gate", "lpi2c1_sel", ccm_base + (lpi2c1 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPI2C2_GATE] = imx_clk_hw_gate_dis_flags("lpi2c2_gate", "lpi2c2_sel", ccm_base + (lpi2c2 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPI2C3_GATE] = imx_clk_hw_gate_dis_flags("lpi2c3_gate", "lpi2c3_sel", ccm_base + (lpi2c3 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPI2C4_GATE] = imx_clk_hw_gate_dis_flags("lpi2c4_gate", "lpi2c4_sel", ccm_base + (lpi2c4 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPI2C5_GATE] = imx_clk_hw_gate_dis_flags("lpi2c5_gate", "lpi2c5_sel", ccm_base + (lpi2c5 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPI2C6_GATE] = imx_clk_hw_gate_dis_flags("lpi2c6_gate", "lpi2c6_sel", ccm_base + (lpi2c6 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPSPI1_GATE] = imx_clk_hw_gate_dis_flags("lpspi1_gate", "lpspi1_sel", ccm_base + (lpspi1 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPSPI2_GATE] = imx_clk_hw_gate_dis_flags("lpspi2_gate", "lpspi2_sel", ccm_base + (lpspi2 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPSPI3_GATE] = imx_clk_hw_gate_dis_flags("lpspi3_gate", "lpspi3_sel", ccm_base + (lpspi3 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPSPI4_GATE] = imx_clk_hw_gate_dis_flags("lpspi4_gate", "lpspi4_sel", ccm_base + (lpspi4 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPSPI5_GATE] = imx_clk_hw_gate_dis_flags("lpspi5_gate", "lpspi5_sel", ccm_base + (lpspi5 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LPSPI6_GATE] = imx_clk_hw_gate_dis_flags("lpspi6_gate", "lpspi6_sel", ccm_base + (lpspi6 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_EMV1_GATE] = imx_clk_hw_gate_dis_flags("emv1_gate", "emv1_sel", ccm_base + (emv1 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_EMV2_GATE] = imx_clk_hw_gate_dis_flags("emv2_gate", "emv2_sel", ccm_base + (emv2 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_ENET1_GATE] = imx_clk_hw_gate_dis_flags("enet1_gate", "enet1_sel", ccm_base + (enet1 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_ENET2_GATE] = imx_clk_hw_gate_dis_flags("enet2_gate", "enet2_sel", ccm_base + (enet2 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_ENET_QOS_GATE] = imx_clk_hw_gate_dis_flags("enet_qos_gate", "enet_qos_sel", ccm_base + (enet_qos * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_ENET_25M_GATE] = imx_clk_hw_gate_dis_flags("enet_25m_gate", "enet_25m_sel", ccm_base + (enet_25m * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_ENET_TIMER1_GATE] = imx_clk_hw_gate_dis_flags("enet_timer1_gate", "enet_timer1_sel", ccm_base + (enet_timer1 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_ENET_TIMER2_GATE] = imx_clk_hw_gate_dis_flags("enet_timer2_gate", "enet_timer2_sel", ccm_base + (enet_timer2 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_ENET_TIMER3_GATE] = imx_clk_hw_gate_dis_flags("enet_timer3_gate", "enet_timer3_sel", ccm_base + (enet_timer3 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_USDHC1_GATE] = imx_clk_hw_gate_dis_flags("usdhc1_gate", "usdhc1_sel", ccm_base + (usdhc1 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_USDHC2_GATE] = imx_clk_hw_gate_dis_flags("usdhc2_gate", "usdhc2_sel", ccm_base + (usdhc2 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_ASRC_GATE] = imx_clk_hw_gate_dis_flags("asrc_gate", "asrc_sel", ccm_base + (asrc * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_MQS_GATE] = imx_clk_hw_gate_dis_flags("mqs_gate", "mqs_sel", ccm_base + (mqs * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_MIC_GATE] = imx_clk_hw_gate_dis_flags("mic_gate", "mic_sel", ccm_base + (mic * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_SPDIF_GATE] = imx_clk_hw_gate_dis_flags("spdif_gate", "spdif_sel", ccm_base + (spdif * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_SAI1_GATE] = imx_clk_hw_gate_dis_flags("sai1_gate", "sai1_sel", ccm_base + (sai1 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_SAI2_GATE] = imx_clk_hw_gate_dis_flags("sai2_gate", "sai2_sel", ccm_base + (sai2 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_SAI3_GATE] = imx_clk_hw_gate_dis_flags("sai3_gate", "sai3_sel", ccm_base + (sai3 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_SAI4_GATE] = imx_clk_hw_gate_dis_flags("sai4_gate", "sai4_sel", ccm_base + (sai4 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_GC355_GATE] = imx_clk_hw_gate_dis_flags("gc355_gate", "gc355_sel", ccm_base + (gc355 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LCDIF_GATE] = imx_clk_hw_gate_dis_flags("lcdif_gate", "lcdif_sel", ccm_base + (lcdif * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_LCDIFV2_GATE] = imx_clk_hw_gate_dis_flags("lcdifv2_gate", "lcdifv2_sel", ccm_base + (lcdifv2 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_MIPI_REF_GATE] = imx_clk_hw_gate_dis_flags("mipi_ref_gate", "mipi_ref_sel", ccm_base + (mipi_ref * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_MIPI_ESC_GATE] = imx_clk_hw_gate_dis_flags("mipi_esc_gate", "mipi_esc_sel", ccm_base + (mipi_esc * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_CSI2_GATE] = imx_clk_hw_gate_dis_flags("csi2_gate", "csi2_sel", ccm_base + (csi2 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_CSI2_ESC_GATE] = imx_clk_hw_gate_dis_flags("csi2_esc_gate", "csi2_esc_sel", ccm_base + (csi2_esc * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_CSI2_UI_GATE] = imx_clk_hw_gate_dis_flags("csi2_ui_gate", "csi2_ui_sel", ccm_base + (csi2_ui * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_CSI_GATE] = imx_clk_hw_gate_dis_flags("csi_gate", "csi_sel", ccm_base + (csi * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_CKO1_GATE] = imx_clk_hw_gate_dis_flags("cko1_gate", "cko1_sel", ccm_base + (cko1 * 0x80), 24, 0);
> +	hws[IMXRT1170_CLK_CKO2_GATE] = imx_clk_hw_gate_dis_flags("cko2_gate", "cko2_sel", ccm_base + (cko2 * 0x80), 24, 0);
> +
> +	hws[IMXRT1170_CLK_M7] = imx_clk_hw_divider("m7", "m7_gate", ccm_base + (m7 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_M4] = imx_clk_hw_divider("m4", "m4_gate", ccm_base + (m4 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_BUS] = imx_clk_hw_divider("bus", "bus_gate", ccm_base + (bus * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_BUS_LPSR] = imx_clk_hw_divider("bus_lpsr", "bus_lpsr_gate", ccm_base + (bus_lpsr * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_SEMC] = imx_clk_hw_divider("semc", "semc_gate", ccm_base + (semc * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_CSSYS] = imx_clk_hw_divider("cssys", "cssys_gate", ccm_base + (cssys * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_CSTRACE] = imx_clk_hw_divider("cstrace", "cstrace_gate", ccm_base + (cstrace * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_M4_SYSTICK] = imx_clk_hw_divider("m4_systick", "m4_systick_gate", ccm_base + (m4_systick * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_M7_SYSTICK] = imx_clk_hw_divider("m7_systick", "m7_systick_gate", ccm_base + (m7_systick * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_ADC1] = imx_clk_hw_divider("adc1", "adc1_gate", ccm_base + (adc1 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_ADC2] = imx_clk_hw_divider("adc2", "adc2_gate", ccm_base + (adc2 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_ACMP] = imx_clk_hw_divider("acmp", "acmp_gate", ccm_base + (acmp * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_FLEXIO1] = imx_clk_hw_divider("flexio1", "flexio1_gate", ccm_base + (flexio1 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_FLEXIO2] = imx_clk_hw_divider("flexio2", "flexio2_gate", ccm_base + (flexio2 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_GPT1] = imx_clk_hw_divider("gpt1", "gpt1_gate", ccm_base + (gpt1 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_GPT2] = imx_clk_hw_divider("gpt2", "gpt2_gate", ccm_base + (gpt2 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_GPT3] = imx_clk_hw_divider("gpt3", "gpt3_gate", ccm_base + (gpt3 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_GPT4] = imx_clk_hw_divider("gpt4", "gpt4_gate", ccm_base + (gpt4 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_GPT5] = imx_clk_hw_divider("gpt5", "gpt5_gate", ccm_base + (gpt5 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_GPT6] = imx_clk_hw_divider("gpt6", "gpt6_gate", ccm_base + (gpt6 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_FLEXSPI1] = imx_clk_hw_divider("flexspi1", "flexspi1_gate", ccm_base + (flexspi1 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_FLEXSPI2] = imx_clk_hw_divider("flexspi2", "flexspi2_gate", ccm_base + (flexspi2 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_CAN1] = imx_clk_hw_divider("can1", "can1_gate", ccm_base + (can1 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_CAN2] = imx_clk_hw_divider("can2", "can2_gate", ccm_base + (can2 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_CAN3] = imx_clk_hw_divider("can3", "can3_gate", ccm_base + (can3 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPUART1] = imx_clk_hw_divider("lpuart1", "lpuart1_gate", ccm_base + (lpuart1 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPUART2] = imx_clk_hw_divider("lpuart2", "lpuart2_gate", ccm_base + (lpuart2 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPUART3] = imx_clk_hw_divider("lpuart3", "lpuart3_gate", ccm_base + (lpuart3 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPUART4] = imx_clk_hw_divider("lpuart4", "lpuart4_gate", ccm_base + (lpuart4 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPUART5] = imx_clk_hw_divider("lpuart5", "lpuart5_gate", ccm_base + (lpuart5 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPUART6] = imx_clk_hw_divider("lpuart6", "lpuart6_gate", ccm_base + (lpuart6 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPUART7] = imx_clk_hw_divider("lpuart7", "lpuart7_gate", ccm_base + (lpuart7 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPUART8] = imx_clk_hw_divider("lpuart8", "lpuart8_gate", ccm_base + (lpuart8 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPUART9] = imx_clk_hw_divider("lpuart9", "lpuart9_gate", ccm_base + (lpuart9 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPUART10] = imx_clk_hw_divider("lpuart10", "lpuart10_gate", ccm_base + (lpuart10 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPUART11] = imx_clk_hw_divider("lpuart11", "lpuart11_gate", ccm_base + (lpuart11 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPUART12] = imx_clk_hw_divider("lpuart12", "lpuart12_gate", ccm_base + (lpuart12 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPI2C1] = imx_clk_hw_divider("lpi2c1", "lpi2c1_gate", ccm_base + (lpi2c1 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPI2C2] = imx_clk_hw_divider("lpi2c2", "lpi2c2_gate", ccm_base + (lpi2c2 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPI2C3] = imx_clk_hw_divider("lpi2c3", "lpi2c3_gate", ccm_base + (lpi2c3 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPI2C4] = imx_clk_hw_divider("lpi2c4", "lpi2c4_gate", ccm_base + (lpi2c4 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPI2C5] = imx_clk_hw_divider("lpi2c5", "lpi2c5_gate", ccm_base + (lpi2c5 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPI2C6] = imx_clk_hw_divider("lpi2c6", "lpi2c6_gate", ccm_base + (lpi2c6 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPSPI1] = imx_clk_hw_divider("lpspi1", "lpspi1_gate", ccm_base + (lpspi1 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPSPI2] = imx_clk_hw_divider("lpspi2", "lpspi2_gate", ccm_base + (lpspi2 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPSPI3] = imx_clk_hw_divider("lpspi3", "lpspi3_gate", ccm_base + (lpspi3 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPSPI4] = imx_clk_hw_divider("lpspi4", "lpspi4_gate", ccm_base + (lpspi4 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPSPI5] = imx_clk_hw_divider("lpspi5", "lpspi5_gate", ccm_base + (lpspi5 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LPSPI6] = imx_clk_hw_divider("lpspi6", "lpspi6_gate", ccm_base + (lpspi6 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_EMV1] = imx_clk_hw_divider("emv1", "emv1_gate", ccm_base + (emv1 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_EMV2] = imx_clk_hw_divider("emv2", "emv2_gate", ccm_base + (emv2 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_ENET1] = imx_clk_hw_divider("enet1", "enet1_gate", ccm_base + (enet1 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_ENET2] = imx_clk_hw_divider("enet2", "enet2_gate", ccm_base + (enet2 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_ENET_QOS] = imx_clk_hw_divider("enet_qos", "enet_qos_gate", ccm_base + (enet_qos * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_ENET_25M] = imx_clk_hw_divider("enet_25m", "enet_25m_gate", ccm_base + (enet_25m * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_ENET_TIMER1] = imx_clk_hw_divider("enet_timer1", "enet_timer1_gate", ccm_base + (enet_timer1 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_ENET_TIMER2] = imx_clk_hw_divider("enet_timer2", "enet_timer2_gate", ccm_base + (enet_timer2 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_ENET_TIMER3] = imx_clk_hw_divider("enet_timer3", "enet_timer3_gate", ccm_base + (enet_timer3 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_USDHC1] = imx_clk_hw_divider("usdhc1", "usdhc1_gate", ccm_base + (usdhc1 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_USDHC2] = imx_clk_hw_divider("usdhc2", "usdhc2_gate", ccm_base + (usdhc2 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_ASRC] = imx_clk_hw_divider("asrc", "asrc_gate", ccm_base + (asrc * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_MQS] = imx_clk_hw_divider("mqs", "mqs_gate", ccm_base + (mqs * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_MIC] = imx_clk_hw_divider("mic", "mic_gate", ccm_base + (mic * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_SPDIF] = imx_clk_hw_divider("spdif", "spdif_gate", ccm_base + (spdif * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_SAI1] = imx_clk_hw_divider("sai1", "sai1_gate", ccm_base + (sai1 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_SAI2] = imx_clk_hw_divider("sai2", "sai2_gate", ccm_base + (sai2 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_SAI3] = imx_clk_hw_divider("sai3", "sai3_gate", ccm_base + (sai3 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_SAI4] = imx_clk_hw_divider("sai4", "sai4_gate", ccm_base + (sai4 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_GC355] = imx_clk_hw_divider("gc355", "gc355_gate", ccm_base + (gc355 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LCDIF] = imx_clk_hw_divider("lcdif", "lcdif_gate", ccm_base + (lcdif * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_LCDIFV2] = imx_clk_hw_divider("lcdifv2", "lcdifv2_gate", ccm_base + (lcdifv2 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_MIPI_REF] = imx_clk_hw_divider("mipi_ref", "mipi_ref_gate", ccm_base + (mipi_ref * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_MIPI_ESC] = imx_clk_hw_divider("mipi_esc", "mipi_esc_gate", ccm_base + (mipi_esc * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_CSI2] = imx_clk_hw_divider("csi2", "csi2_gate", ccm_base + (csi2 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_CSI2_ESC] = imx_clk_hw_divider("csi2_esc", "csi2_esc_gate", ccm_base + (csi2_esc * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_CSI2_UI] = imx_clk_hw_divider("csi2_ui", "csi2_ui_gate", ccm_base + (csi2_ui * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_CSI] = imx_clk_hw_divider("csi", "csi_gate", ccm_base + (csi * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_CKO1] = imx_clk_hw_divider("cko1", "cko1_gate", ccm_base + (cko1 * 0x80), 0, 8);
> +	hws[IMXRT1170_CLK_CKO2] = imx_clk_hw_divider("cko2", "cko2_gate", ccm_base + (cko2 * 0x80), 0, 8);
> +
> +	hws[IMXRT1170_CLK_USB] = imx_clk_hw_gate("usb", "bus", ccm_base + LPCG_GATE(115), 0);
> +
> +	imx_check_clk_hws(hws, IMXRT1170_CLK_END);
> +
> +	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register clks for i.MXRT1170.\n");
> +		imx_unregister_hw_clocks(hws, IMXRT1170_CLK_END);
> +	}
> +	return ret;
> +}
> +
> +static const struct of_device_id imxrt1170_clk_of_match[] = {
> +	{ .compatible = "fsl,imxrt1170-ccm" },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imxrt1170_clk_of_match);
> +
> +static struct platform_driver imxrt1170_clk_driver = {
> +	.probe = imxrt1170_clocks_probe,
> +	.driver = {
> +		.name = "imxrt1170-ccm",
> +		.of_match_table = imxrt1170_clk_of_match,
> +	},
> +};
> +module_platform_driver(imxrt1170_clk_driver);
> --
> 2.35.1
>
