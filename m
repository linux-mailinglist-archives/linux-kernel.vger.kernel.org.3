Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038FF4C8D92
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiCAOXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiCAOXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:23:19 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80074.outbound.protection.outlook.com [40.107.8.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6E05FD0;
        Tue,  1 Mar 2022 06:22:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OukmE5iuzXgERgOKJq7LggCSv1enV93cHLkfPDSKSUiuD5eNuITZw2DK92OLhEPygL80ym32+va3YRagyYpu9Xg3Cwy1TZHJgzqThQy7LbuNLrq2m//umLVinS8X/hpa9pMgqeYcdpRTOMg6RaURdgn3mH2LtU7j/8H9Xmj+BV8uw/sSsPP53mvmrY+9aQmqpChxlUeLZcXeXMnt0/Qwrejdy3F0dnG8KE65N6Ejwbbvirz5m1bgBxvyVW3hYyQilRHdfI0UKBF7BLXT2qJlIN7hum51SNawtTb7sZD7svI+FECN21t9v9im2VPqp/CKHARIX2wr5B+bqbQl8YRY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ttllDBA5Fp/TycfzTJXQt9EGQTMvyRYuswtuBes43w=;
 b=T5lxFumTVZ6KreNegcz7C/+TZkp3UalsoNTI7LTg43qFi5ox15pBsektDYBOoWC2TMl4Qqmx+2CDbanzmUmFsxU2DRZD7GzbiaOwYOZGtKapxk/4WxW5bDBj273QyI6Dh3vB1kYq6I/udcOo11U+9kD8IF8G5OuSNqnWQI9LXkYkqAbYo86LTEMMa3RMjQP55uyPs2evQALnxCkqoMZw1dZ7yuoz8ZbKkUNX+KTrhJy7sx+2RW2jFA6jbwnyCCb6wD/m2tL0Jc2UvZ7jSZxSdAGKmk0soT+S60IxhZTqbkNYno+xxLtnMva41r9w099Vw1y8/kTPmrNJXA70hXp73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ttllDBA5Fp/TycfzTJXQt9EGQTMvyRYuswtuBes43w=;
 b=FdBAeIwlj+8YAcaUnaoi5kHvdLNIHQfgsaPjx33p444fEMFkphUWLed00QQIVXM5OwcCIPCTfmhbXX8U3gChQU0gff+7i769x+6dGv5rVj5uPfJeL8/PPsWih/BcKc4s1zHV0XbnSzHfTqLX35sznTt69HQb0ADQLpCzUuvXlTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB4957.eurprd04.prod.outlook.com (2603:10a6:803:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 14:22:34 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e%5]) with mapi id 15.20.5017.026; Tue, 1 Mar 2022
 14:22:34 +0000
Date:   Tue, 1 Mar 2022 16:22:32 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V6 5/5] clk: imx: add i.MX93 clk
Message-ID: <Yh4sKFwJT/58EAKB@abelvesa>
References: <20220228020908.2810346-1-peng.fan@oss.nxp.com>
 <20220228020908.2810346-6-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228020908.2810346-6-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1PR0102CA0079.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::20) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77eb9cad-6e56-4e78-f0fd-08d9fb8eeda1
X-MS-TrafficTypeDiagnostic: VI1PR04MB4957:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB495750B273CE0DADF31731E4F6029@VI1PR04MB4957.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdoJ8CbQMXNggAahv6/9/8GNR/mdDljRxCfwM5TaKA5UD2oZ6AF0HiYBk21e/IvSc/rpX+9Tc67yPCxePcmhAkiSJ4wvAqPhXVsRV9W3Bp5iiv/1fJ6XAbBDo6pa21yA4BEJIwuDuTwr4rSMKE+0yGESrrbfYTjcUvLuMmSdLTDaZj8G8iioIoDZAgurTnXGIpToJuchSwcg3/75HHsiUFDSLduqixUjXACi1Jrno6VYyZXw7xzyhdKWdC3ocisGZsRlphSQlkzQn5/beWBP1mwHAfunAk4ZDMiEHhDMBjp4SbHeJAdclEMG745VKo42Ta3Xsa9GHVcL+YxzQKWri2PdB0ivG3BrzBzOXwIreW1twh/g2EE2ZOH3iDUDe6UsFOAOM+iKxfm0LbPcAxQ7XHoPRhmTJD/Z4KQd5i2er27J+vZ6c4tXun9Gqzx9ofDjcMse/Aib1+gPpUFf4mZloURtXdYJ/nPqguomc46SdQ8a7sKcv8RPaU3JhsMSe6SDaN03Th+1nQOZyoKD91LiCmfET5o2gq49Bnhy0VmeJEbanl2qZ1PWLgUwVvWwpoHvULQkzNXf7edOX8ZJJ9rg7eTnJQU9v/FpghHFWo6I3/QHf00rlQi6xwzIlv4Yp7hOe9+OFqxPUsgFojxR1wVCnmO7uXxx4O0GvQuY/gqP4ynpIjiH1HcClTzM1/rThOFfrGqbjZssDyLeq/2ez0jgag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(5660300002)(33716001)(52116002)(53546011)(7416002)(30864003)(38100700002)(38350700002)(44832011)(6512007)(9686003)(66476007)(66556008)(66946007)(6486002)(316002)(83380400001)(8936002)(6506007)(6862004)(8676002)(4326008)(186003)(86362001)(508600001)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eh7Cdu0+frUlMBGehe4zSro9aUlYY4W8anspfwpRBTtiNPVtyy0YNVljd/Jg?=
 =?us-ascii?Q?lyu1CAkG20A6jjKj3HNzswni/+FWIKBTPN3U7KwSsNoBo4Mr8qHN6gRTuGeL?=
 =?us-ascii?Q?xUnm2AzGLtnNkf577SHZFMmZBDdKqQBaNStkmggx/ryhRPU65en7qNN17GHg?=
 =?us-ascii?Q?RB2Jw8Ufl3TBYYXF4V/osPK4h2n9WWYWEidXicdRzIi0OoW+RewDeTmnXJBc?=
 =?us-ascii?Q?3hEVFh31lCtTbovWakIl2sANBBP3zRa2ke5H73lboKTNlVRbtU8b2IyEjBoP?=
 =?us-ascii?Q?Fmf8gPRzKcN6J7NMfVcO6/EPqCyhLzNqvorL6alFfYeCWOTdhzioX18stR80?=
 =?us-ascii?Q?592wu/N3qCskpMnAsn3S1QSjWT02BT0qle7PDF6fWZ29rLnsJg9jcYdHlfT0?=
 =?us-ascii?Q?CbojG1hISSjz/o6uzhiUmg4cVWi7baWMyzb0CB/uFGOyhM4Zd7+pUP6gEpto?=
 =?us-ascii?Q?sQFnuLEeUj4Roe0NMq2urFSl/oNus9b5xt6nN2r4Zv1Wlh80zek3oLfC6l4X?=
 =?us-ascii?Q?NNdDy/S/bYdHRknA5B/MpOYnyuoUpAF2l7glcv8HtX7bTI2L4s4neK3IjlLX?=
 =?us-ascii?Q?eyrGwPWkLm0tkLWvSuvkB9a8QjOoQ0Xtq49w8lGr01pXKz45T1IOxfy7b46A?=
 =?us-ascii?Q?eZRw8FQtkvhKjgMhY+4W4Gvcfu08YqCCUzGfglbWCwyZzZCs1JH7vfHoatuE?=
 =?us-ascii?Q?zOcHci2ZC6hB+xS+VePxzyVsjpYmeSmq+8Z5CS0qXm2eB803AQDNbuBaOJE6?=
 =?us-ascii?Q?1h2BnsANX7tePXEoiRMqts874OjhE0dsoru2M5B2O5pCfVFaCek9jZ5L45jL?=
 =?us-ascii?Q?L1YbVytH5uBkg4HcaQOacWYnKSwJsOOz29hbBxkVZvCH5IbGpCbROg/BiVbQ?=
 =?us-ascii?Q?BHTMYlFkMMK7HPMAbQb34T6xQ1uObLWEUjZinLhKcmEhvyvlx/fPQIFuVNda?=
 =?us-ascii?Q?pqgX7n4atvwtk7al6b6LgRLZ6cTmFJyx4kCDgX1aZPOk141k/w/Z8Rgl7DkZ?=
 =?us-ascii?Q?RpltHfw7E6UnKxyL0HnBSLF5UnghK0u9pvPwKalmoNtMFqGTQN1QVr4iR7kS?=
 =?us-ascii?Q?t1jvTTv8dG3onQUFalWyco58U3iexXF1c0O5wrUgCT8Nwu81sMImUpVQbiA0?=
 =?us-ascii?Q?L+2Yu9mczLheS5m1uaY45S0N9pZOP5GULla4Mttg3W/m9CgAqZJ+kFiuJ5qm?=
 =?us-ascii?Q?9f0tBDKA8s6A3G//iJe7nB+LkJtYrlngkXMGEkRwC+s0Sssg9M2ES/Jd6qOl?=
 =?us-ascii?Q?kgO36Ps01xhJb45fm8wr38BY0gc4V0scsCsnVNCYjvoRmr+w5VYLXyo50Ra2?=
 =?us-ascii?Q?FkYtb1Lnj4qMf9qirvThTWaKbEhKpi/xfOu9GNbdyx19E5VwzKNaWCK5ti7F?=
 =?us-ascii?Q?KtAbQCxsjjMsaDrYCRD/em0ZhHjUrOIlKTH1MWYl58RK55v4m05U1UzGhbXD?=
 =?us-ascii?Q?YYGQK+W66k5OLe4kTHa4eS2TFXl4u/jEIyIduQ4mm/3PpC8UaglSNcI0QGLS?=
 =?us-ascii?Q?oSOPNCpePR0A91/T74mUHqyS5g3JA+RR7YjDJ3zN+sK2QUIA5EYlGCfwxCBD?=
 =?us-ascii?Q?pUD3IeoxCCxN0QlCTv2dKLb2uU8k6j5+5SA1BMFoZpc9HeAWZl6XoGXVk0rg?=
 =?us-ascii?Q?3aOD6lM+wx84lNb+72xzSWA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77eb9cad-6e56-4e78-f0fd-08d9fb8eeda1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 14:22:34.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+vg2hQTq35cfUrxqgRHu2pOftu+kWgXBjuqpE+6LcyfQ4mgKlYh8ntPJhhQIYUrW0QC2PwOPL/0am/B1xLSeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4957
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-28 10:09:08, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX93 clk driver. i.MX93 clk hardware design is different compared
> with i.MX8M. It supports 4 sources for each clk root and the sources
> are separated into a few groups, low speed/fast io/audio and etc.
> 
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/Kconfig     |   6 +
>  drivers/clk/imx/Makefile    |   2 +
>  drivers/clk/imx/clk-imx93.c | 338 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 346 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-imx93.c
> 
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index 45641b8bdc50..cc464a42d646 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -106,6 +106,12 @@ config CLK_IMX8ULP
>  	help
>  	    Build the driver for i.MX8ULP CCM Clock Driver
>  
> +config CLK_IMX93
> +	tristate "IMX93 CCM Clock Driver"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	help
> +	    Build the driver for i.MX93 CCM Clock Driver
> +
>  config CLK_IMXRT1050
>  	tristate "IMXRT1050 CCM Clock Driver"
>  	depends on SOC_IMXRT
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 60c8a4bb7574..88b9b9285d22 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -28,6 +28,8 @@ obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
>  obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
>  obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
>  
> +obj-$(CONFIG_CLK_IMX93) += clk-imx93.o
> +
>  obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
>  clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o \
>  				     clk-imx8qxp-rsrc.o clk-imx8qm-rsrc.o \
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> new file mode 100644
> index 000000000000..56d0d34cbdec
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -0,0 +1,338 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 NXP.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <dt-bindings/clock/imx93-clock.h>
> +
> +#include "clk.h"
> +
> +enum clk_sel {
> +	LOW_SPEED_IO_SEL,
> +	NON_IO_SEL,
> +	FAST_SEL,
> +	AUDIO_SEL,
> +	VIDEO_SEL,
> +	TPM_SEL,
> +	CKO1_SEL,
> +	CKO2_SEL,
> +	MISC_SEL,
> +	MAX_SEL
> +};
> +
> +static const char *parent_names[MAX_SEL][4] = {
> +	{"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "video_pll"},
> +	{"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "sys_pll_pfd2_div2"},
> +	{"osc_24m", "sys_pll_pfd0", "sys_pll_pfd1", "sys_pll_pfd2"},
> +	{"osc_24m", "audio_pll", "video_pll", "clk_ext1"},
> +	{"osc_24m", "audio_pll", "video_pll", "sys_pll_pfd0"},
> +	{"osc_24m", "sys_pll_pfd0", "audio_pll", "clk_ext1"},
> +	{"osc_24m", "sys_pll_pfd0", "sys_pll_pfd1", "audio_pll"},
> +	{"osc_24m", "sys_pll_pfd0", "sys_pll_pfd1", "video_pll"},
> +	{"osc_24m", "audio_pll", "video_pll", "sys_pll_pfd2"},
> +};
> +
> +static const struct imx93_clk_root {
> +	u32 clk;
> +	char *name;
> +	u32 off;
> +	enum clk_sel sel;
> +	unsigned long flags;
> +} root_array[] = {
> +	/* a55/m33/bus critical clk for system run */
> +	{ IMX93_CLK_A55_PERIPH,		"a55_periph_root",	0x0000,	FAST_SEL, CLK_IS_CRITICAL },
> +	{ IMX93_CLK_A55_MTR_BUS,	"a55_mtr_bus_root",	0x0080,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
> +	{ IMX93_CLK_A55,		"a55_root",		0x0100,	FAST_SEL, CLK_IS_CRITICAL },
> +	{ IMX93_CLK_M33,		"m33_root",		0x0180,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
> +	{ IMX93_CLK_BUS_WAKEUP,		"bus_wakeup_root",	0x0280,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
> +	{ IMX93_CLK_BUS_AON,		"bus_aon_root",		0x0300,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
> +	{ IMX93_CLK_WAKEUP_AXI,		"wakeup_axi_root",	0x0380,	FAST_SEL, CLK_IS_CRITICAL },
> +	{ IMX93_CLK_SWO_TRACE,		"swo_trace_root",	0x0400,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_FLEXIO1,		"flexio1_root",		0x0500,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_FLEXIO2,		"flexio2_root",		0x0580,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPIT1,		"lpit1_root",		0x0600,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPIT2,		"lpit2_root",		0x0680,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPTMR1,		"lptmr1_root",		0x0700,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPTMR2,		"lptmr2_root",		0x0780,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_TPM1,		"tpm1_root",		0x0800,	TPM_SEL, },
> +	{ IMX93_CLK_TPM2,		"tpm2_root",		0x0880,	TPM_SEL, },
> +	{ IMX93_CLK_TPM3,		"tpm3_root",		0x0900,	TPM_SEL, },
> +	{ IMX93_CLK_TPM4,		"tpm4_root",		0x0980,	TPM_SEL, },
> +	{ IMX93_CLK_TPM5,		"tpm5_root",		0x0a00,	TPM_SEL, },
> +	{ IMX93_CLK_TPM6,		"tpm6_root",		0x0a80,	TPM_SEL, },
> +	{ IMX93_CLK_FLEXSPI1,		"flexspi1_root",	0x0b00,	FAST_SEL, },
> +	{ IMX93_CLK_CAN1,		"can1_root",		0x0b80,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_CAN2,		"can2_root",		0x0c00,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPUART1,		"lpuart1_root",		0x0c80,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPUART2,		"lpuart2_root",		0x0d00,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPUART3,		"lpuart3_root",		0x0d80,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPUART4,		"lpuart4_root",		0x0e00,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPUART5,		"lpuart5_root",		0x0e80,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPUART6,		"lpuart6_root",		0x0f00,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPUART7,		"lpuart7_root",		0x0f80,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPUART8,		"lpuart8_root",		0x1000,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPI2C1,		"lpi2c1_root",		0x1080,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPI2C2,		"lpi2c2_root",		0x1100,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPI2C3,		"lpi2c3_root",		0x1180,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPI2C4,		"lpi2c4_root",		0x1200,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPI2C5,		"lpi2c5_root",		0x1280,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPI2C6,		"lpi2c6_root",		0x1300,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPI2C7,		"lpi2c7_root",		0x1380,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPI2C8,		"lpi2c8_root",		0x1400,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPSPI1,		"lpspi1_root",		0x1480,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPSPI2,		"lpspi2_root",		0x1500,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPSPI3,		"lpspi3_root",		0x1580,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPSPI4,		"lpspi4_root",		0x1600,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPSPI5,		"lpspi5_root",		0x1680,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPSPI6,		"lpspi6_root",		0x1700,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPSPI7,		"lpspi7_root",		0x1780,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_LPSPI8,		"lpspi8_root",		0x1800,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_I3C1,		"i3c1_root",		0x1880,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_I3C2,		"i3c2_root",		0x1900,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_USDHC1,		"usdhc1_root",		0x1980,	FAST_SEL, },
> +	{ IMX93_CLK_USDHC2,		"usdhc2_root",		0x1a00,	FAST_SEL, },
> +	{ IMX93_CLK_USDHC3,		"usdhc3_root",		0x1a80,	FAST_SEL, },
> +	{ IMX93_CLK_SAI1,		"sai1_root",		0x1b00,	AUDIO_SEL, },
> +	{ IMX93_CLK_SAI2,		"sai2_root",		0x1b80,	AUDIO_SEL, },
> +	{ IMX93_CLK_SAI3,		"sai3_root",		0x1c00,	AUDIO_SEL, },
> +	{ IMX93_CLK_CCM_CKO1,		"ccm_cko1_root",	0x1c80,	CKO1_SEL, },
> +	{ IMX93_CLK_CCM_CKO2,		"ccm_cko2_root",	0x1d00,	CKO2_SEL, },
> +	{ IMX93_CLK_CCM_CKO3,		"ccm_cko3_root",	0x1d80,	CKO1_SEL, },
> +	{ IMX93_CLK_CCM_CKO4,		"ccm_cko4_root",	0x1e00,	CKO2_SEL, },
> +	{ IMX93_CLK_HSIO,		"hsio_root",		0x1e80,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_HSIO_USB_TEST_60M,	"hsio_usb_test_60m_root", 0x1f00, LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_HSIO_ACSCAN_80M,	"hsio_acscan_80m_root",	0x1f80,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_HSIO_ACSCAN_480M,	"hsio_acscan_480m_root", 0x2000, MISC_SEL, },
> +	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, },
> +	{ IMX93_CLK_MEDIA_AXI,		"media_axi_root",	0x2280,	FAST_SEL, },
> +	{ IMX93_CLK_MEDIA_APB,		"media_apb_root",	0x2300,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_MEDIA_LDB,		"media_ldb_root",	0x2380,	VIDEO_SEL, },
> +	{ IMX93_CLK_MEDIA_DISP_PIX,	"media_disp_pix_root",	0x2400,	VIDEO_SEL, },
> +	{ IMX93_CLK_CAM_PIX,		"cam_pix_root",		0x2480,	VIDEO_SEL, },
> +	{ IMX93_CLK_MIPI_TEST_BYTE,	"mipi_test_byte_root",	0x2500,	VIDEO_SEL, },
> +	{ IMX93_CLK_MIPI_PHY_CFG,	"mipi_phy_cfg_root",	0x2580,	VIDEO_SEL, },
> +	{ IMX93_CLK_ADC,		"adc_root",		0x2700,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_PDM,		"pdm_root",		0x2780,	AUDIO_SEL, },
> +	{ IMX93_CLK_TSTMR1,		"tstmr1_root",		0x2800,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_TSTMR2,		"tstmr2_root",		0x2880,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_MQS1,		"mqs1_root",		0x2900,	AUDIO_SEL, },
> +	{ IMX93_CLK_MQS2,		"mqs2_root",		0x2980,	AUDIO_SEL, },
> +	{ IMX93_CLK_AUDIO_XCVR,		"audio_xcvr_root",	0x2a00,	NON_IO_SEL, },
> +	{ IMX93_CLK_SPDIF,		"spdif_root",		0x2a80,	AUDIO_SEL, },
> +	{ IMX93_CLK_ENET,		"enet_root",		0x2b00,	NON_IO_SEL, },
> +	{ IMX93_CLK_ENET_TIMER1,	"enet_timer1_root",	0x2b80,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_ENET_TIMER2,	"enet_timer2_root",	0x2c00,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_ENET_REF,		"enet_ref_root",	0x2c80,	NON_IO_SEL, },
> +	{ IMX93_CLK_ENET_REF_PHY,	"enet_ref_phy_root",	0x2d00,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_I3C1_SLOW,		"i3c1_slow_root",	0x2d80,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_I3C2_SLOW,		"i3c2_slow_root",	0x2e00,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_USB_PHY_BURUNIN,	"usb_phy_root",		0x2e80,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_PAL_CAME_SCAN,	"pal_came_scan_root",	0x2f00,	MISC_SEL, }
> +};
> +
> +static const struct imx93_clk_ccgr {
> +	u32 clk;
> +	char *name;
> +	char *parent_name;
> +	u32 off;
> +	unsigned long flags;
> +} ccgr_array[] = {
> +	{ IMX93_CLK_A55_GATE,		"a55",		"a55_root",		0x8000, },
> +	/* M33 critical clk for system run */
> +	{ IMX93_CLK_CM33_GATE,		"cm33",		"m33_root",		0x8040, CLK_IS_CRITICAL },
> +	{ IMX93_CLK_ADC1_GATE,		"adc1",		"osc_24m",		0x82c0, },
> +	{ IMX93_CLK_WDOG1_GATE,		"wdog1",	"osc_24m",		0x8300, },
> +	{ IMX93_CLK_WDOG2_GATE,		"wdog2",	"osc_24m",		0x8340, },
> +	{ IMX93_CLK_WDOG3_GATE,		"wdog3",	"osc_24m",		0x8380, },
> +	{ IMX93_CLK_WDOG4_GATE,		"wdog4",	"osc_24m",		0x83c0, },
> +	{ IMX93_CLK_WDOG5_GATE,		"wdog5",	"osc_24m",		0x8400, },
> +	{ IMX93_CLK_SEMA1_GATE,		"sema1",	"bus_aon_root",		0x8440, },
> +	{ IMX93_CLK_SEMA2_GATE,		"sema2",	"bus_wakeup_root",	0x8480, },
> +	{ IMX93_CLK_MU_A_GATE,		"mu_a",		"bus_aon_root",		0x84c0, },
> +	{ IMX93_CLK_MU_B_GATE,		"mu_b",		"bus_aon_root",		0x8500, },
> +	{ IMX93_CLK_EDMA1_GATE,		"edma1",	"wakeup_axi_root",	0x8540, },
> +	{ IMX93_CLK_EDMA2_GATE,		"edma2",	"wakeup_axi_root",	0x8580, },
> +	{ IMX93_CLK_FLEXSPI1_GATE,	"flexspi",	"flexspi_root",		0x8640, },
> +	{ IMX93_CLK_GPIO1_GATE,		"gpio1",	"m33_root",		0x8880, },
> +	{ IMX93_CLK_GPIO2_GATE,		"gpio2",	"bus_wakeup_root",	0x88c0, },
> +	{ IMX93_CLK_GPIO3_GATE,		"gpio3",	"bus_wakeup_root",	0x8900, },
> +	{ IMX93_CLK_GPIO4_GATE,		"gpio4",	"bus_wakeup_root",	0x8940, },
> +	{ IMX93_CLK_FLEXIO1_GATE,	"flexio1",	"flexio1_root",		0x8980, },
> +	{ IMX93_CLK_FLEXIO2_GATE,	"flexio2",	"flexio2_root",		0x89c0, },
> +	{ IMX93_CLK_LPIT1_GATE,		"lpit1",	"lpit1_root",		0x8a00, },
> +	{ IMX93_CLK_LPIT2_GATE,		"lpit2",	"lpit2_root",		0x8a40, },
> +	{ IMX93_CLK_LPTMR1_GATE,	"lptmr1",	"lptmr1_root",		0x8a80, },
> +	{ IMX93_CLK_LPTMR2_GATE,	"lptmr2",	"lptmr2_root",		0x8ac0, },
> +	{ IMX93_CLK_TPM1_GATE,		"tpm1",		"tpm1_root",		0x8b00, },
> +	{ IMX93_CLK_TPM2_GATE,		"tpm2",		"tpm2_root",		0x8b40, },
> +	{ IMX93_CLK_TPM3_GATE,		"tpm3",		"tpm3_root",		0x8b80, },
> +	{ IMX93_CLK_TPM4_GATE,		"tpm4",		"tpm4_root",		0x8bc0, },
> +	{ IMX93_CLK_TPM5_GATE,		"tpm5",		"tpm5_root",		0x8c00, },
> +	{ IMX93_CLK_TPM6_GATE,		"tpm6",		"tpm6_root",		0x8c40, },
> +	{ IMX93_CLK_CAN1_GATE,		"can1",		"can1_root",		0x8c80, },
> +	{ IMX93_CLK_CAN2_GATE,		"can2",		"can2_root",		0x8cc0, },
> +	{ IMX93_CLK_LPUART1_GATE,	"lpuart1",	"lpuart1_root",		0x8d00, },
> +	{ IMX93_CLK_LPUART2_GATE,	"lpuart2",	"lpuart2_root",		0x8d40, },
> +	{ IMX93_CLK_LPUART3_GATE,	"lpuart3",	"lpuart3_root",		0x8d80, },
> +	{ IMX93_CLK_LPUART4_GATE,	"lpuart4",	"lpuart4_root",		0x8dc0, },
> +	{ IMX93_CLK_LPUART5_GATE,	"lpuart5",	"lpuart5_root",		0x8e00, },
> +	{ IMX93_CLK_LPUART6_GATE,	"lpuart6",	"lpuart6_root",		0x8e40, },
> +	{ IMX93_CLK_LPUART7_GATE,	"lpuart7",	"lpuart7_root",		0x8e80, },
> +	{ IMX93_CLK_LPUART8_GATE,	"lpuart8",	"lpuart8_root",		0x8ec0, },
> +	{ IMX93_CLK_LPI2C1_GATE,	"lpi2c1",	"lpi2c1_root",		0x8f00, },
> +	{ IMX93_CLK_LPI2C2_GATE,	"lpi2c2",	"lpi2c2_root",		0x8f40, },
> +	{ IMX93_CLK_LPI2C3_GATE,	"lpi2c3",	"lpi2c3_root",		0x8f80, },
> +	{ IMX93_CLK_LPI2C4_GATE,	"lpi2c4",	"lpi2c4_root",		0x8fc0, },
> +	{ IMX93_CLK_LPI2C5_GATE,	"lpi2c5",	"lpi2c5_root",		0x9000, },
> +	{ IMX93_CLK_LPI2C6_GATE,	"lpi2c6",	"lpi2c6_root",		0x9040, },
> +	{ IMX93_CLK_LPI2C7_GATE,	"lpi2c7",	"lpi2c7_root",		0x9080, },
> +	{ IMX93_CLK_LPI2C8_GATE,	"lpi2c8",	"lpi2c8_root",		0x90c0, },
> +	{ IMX93_CLK_LPSPI1_GATE,	"lpspi1",	"lpspi1_root",		0x9100, },
> +	{ IMX93_CLK_LPSPI2_GATE,	"lpspi2",	"lpspi2_root",		0x9140, },
> +	{ IMX93_CLK_LPSPI3_GATE,	"lpspi3",	"lpspi3_root",		0x9180, },
> +	{ IMX93_CLK_LPSPI4_GATE,	"lpspi4",	"lpspi4_root",		0x91c0, },
> +	{ IMX93_CLK_LPSPI5_GATE,	"lpspi5",	"lpspi5_root",		0x9200, },
> +	{ IMX93_CLK_LPSPI6_GATE,	"lpspi6",	"lpspi6_root",		0x9240, },
> +	{ IMX93_CLK_LPSPI7_GATE,	"lpspi7",	"lpspi7_root",		0x9280, },
> +	{ IMX93_CLK_LPSPI8_GATE,	"lpspi8",	"lpspi8_root",		0x92c0, },
> +	{ IMX93_CLK_I3C1_GATE,		"i3c1",		"i3c1_root",		0x9300, },
> +	{ IMX93_CLK_I3C2_GATE,		"i3c2",		"i3c2_root",		0x9340, },
> +	{ IMX93_CLK_USDHC1_GATE,	"usdhc1",	"usdhc1_root",		0x9380, },
> +	{ IMX93_CLK_USDHC2_GATE,	"usdhc2",	"usdhc2_root",		0x93c0, },
> +	{ IMX93_CLK_USDHC3_GATE,	"usdhc3",	"usdhc3_root",		0x9400, },
> +	{ IMX93_CLK_SAI1_GATE,		"sai1",		"sai1_root",		0x9440, },
> +	{ IMX93_CLK_SAI2_GATE,		"sai2",		"sai2_root",		0x9480, },
> +	{ IMX93_CLK_SAI3_GATE,		"sai3",		"sai3_root",		0x94c0, },
> +	{ IMX93_CLK_MIPI_CSI_GATE,	"mipi_csi",	"media_apb_root",	0x9580, },
> +	{ IMX93_CLK_MIPI_DSI_GATE,	"mipi_dsi",	"media_apb_root",	0x95c0, },
> +	{ IMX93_CLK_LVDS_GATE,		"lvds",		"media_ldb_root",	0x9600, },
> +	{ IMX93_CLK_LCDIF_GATE,		"lcdif",	"media_apb_root",	0x9640, },
> +	{ IMX93_CLK_PXP_GATE,		"pxp",		"media_apb_root",	0x9680, },
> +	{ IMX93_CLK_ISI_GATE,		"isi",		"media_apb_root",	0x96c0, },
> +	{ IMX93_CLK_NIC_MEDIA_GATE,	"nic_media",	"media_apb_root",	0x9700, },
> +	{ IMX93_CLK_USB_CONTROLLER_GATE, "usb_controller", "hsio_root",		0x9a00, },
> +	{ IMX93_CLK_USB_TEST_60M_GATE,	"usb_test_60m",	"hsio_usb_test_60m_root", 0x9a40, },
> +	{ IMX93_CLK_HSIO_TROUT_24M_GATE, "hsio_trout_24m", "osc_24m",		0x9a80, },
> +	{ IMX93_CLK_PDM_GATE,		"pdm",		"pdm_root",		0x9ac0, },
> +	{ IMX93_CLK_MQS1_GATE,		"mqs1",		"sai1_root",		0x9b00, },
> +	{ IMX93_CLK_MQS2_GATE,		"mqs2",		"sai3_root",		0x9b40, },
> +	{ IMX93_CLK_AUD_XCVR_GATE,	"aud_xcvr",	"audio_xcvr_root",	0x9b80, },
> +	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, },
> +	{ IMX93_CLK_HSIO_32K_GATE,	"hsio_32k",	"osc_32k",		0x9dc0, },
> +	{ IMX93_CLK_ENET1_GATE,		"enet1",	"enet_root",		0x9e00, },
> +	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, },
> +	{ IMX93_CLK_SYS_CNT_GATE,	"sys_cnt",	"osc_24m",		0x9e80, },
> +	{ IMX93_CLK_TSTMR1_GATE,	"tstmr1",	"bus_aon_root",		0x9ec0, },
> +	{ IMX93_CLK_TSTMR2_GATE,	"tstmr2",	"bus_wakeup_root",	0x9f00, },
> +	{ IMX93_CLK_TMC_GATE,		"tmc",		"osc_24m",		0x9f40, },
> +	{ IMX93_CLK_PMRO_GATE,		"pmro",		"osc_24m",		0x9f80, }
> +};
> +
> +static struct clk_hw_onecell_data *clk_hw_data;
> +static struct clk_hw **clks;
> +
> +static int imx93_clocks_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	const struct imx93_clk_root *root;
> +	const struct imx93_clk_ccgr *ccgr;
> +	void __iomem *base = NULL;
> +	int i, ret;
> +
> +	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
> +					  IMX93_CLK_END), GFP_KERNEL);
> +	if (!clk_hw_data)
> +		return -ENOMEM;
> +
> +	clk_hw_data->num = IMX93_CLK_END;
> +	clks = clk_hw_data->hws;
> +
> +	clks[IMX93_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0);
> +	clks[IMX93_CLK_24M] = imx_obtain_fixed_clk_hw(np, "osc_24m");
> +	clks[IMX93_CLK_32K] = imx_obtain_fixed_clk_hw(np, "osc_32k");
> +	clks[IMX93_CLK_EXT1] = imx_obtain_fixed_clk_hw(np, "clk_ext1");
> +
> +	clks[IMX93_CLK_SYS_PLL_PFD0] = imx_clk_hw_fixed("sys_pll_pfd0", 1000000000);
> +	clks[IMX93_CLK_SYS_PLL_PFD0_DIV2] = imx_clk_hw_fixed_factor("sys_pll_pfd0_div2",
> +								    "sys_pll_pfd0", 1, 2);
> +	clks[IMX93_CLK_SYS_PLL_PFD1] = imx_clk_hw_fixed("sys_pll_pfd1", 800000000);
> +	clks[IMX93_CLK_SYS_PLL_PFD1_DIV2] = imx_clk_hw_fixed_factor("sys_pll_pfd1_div2",
> +								    "sys_pll_pfd1", 1, 2);
> +	clks[IMX93_CLK_SYS_PLL_PFD2] = imx_clk_hw_fixed("sys_pll_pfd2", 625000000);
> +	clks[IMX93_CLK_SYS_PLL_PFD2_DIV2] = imx_clk_hw_fixed_factor("sys_pll_pfd2_div2",
> +								    "sys_pll_pfd2", 1, 2);
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-anatop");
> +	base = of_iomap(np, 0);
> +	of_node_put(np);
> +	if (WARN_ON(!base))
> +		return -ENOMEM;
> +
> +	clks[IMX93_CLK_AUDIO_PLL] = imx_clk_fracn_gppll("audio_pll", "osc_24m", base + 0x1200,
> +							&imx_fracn_gppll);
> +	clks[IMX93_CLK_VIDEO_PLL] = imx_clk_fracn_gppll("video_pll", "osc_24m", base + 0x1400,
> +							&imx_fracn_gppll);
> +
> +	np = dev->of_node;
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (WARN_ON(IS_ERR(base)))
> +		return PTR_ERR(base);
> +
> +	for (i = 0; i < ARRAY_SIZE(root_array); i++) {
> +		root = &root_array[i];
> +		clks[root->clk] = imx93_clk_composite_flags(root->name,
> +							    parent_names[root->sel],
> +							    4, base + root->off,
> +							    root->flags);
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(ccgr_array); i++) {
> +		ccgr = &ccgr_array[i];
> +		clks[ccgr->clk] = imx_clk_hw_gate4_flags(ccgr->name,
> +							 ccgr->parent_name,
> +							 base + ccgr->off, 0,
> +							 ccgr->flags);
> +	}
> +
> +	imx_check_clk_hws(clks, IMX93_CLK_END);
> +
> +	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register clks for i.MX93\n");
> +		goto unregister_hws;
> +	}
> +
> +	return 0;
> +
> +unregister_hws:
> +	imx_unregister_hw_clocks(clks, IMX93_CLK_END);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id imx93_clk_of_match[] = {
> +	{ .compatible = "fsl,imx93-ccm" },
> +	{ /* Sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, imx93_clk_of_match);
> +
> +static struct platform_driver imx93_clk_driver = {
> +	.probe = imx93_clocks_probe,
> +	.driver = {
> +		.name = "imx93-ccm",
> +		.suppress_bind_attrs = true,
> +		.of_match_table = of_match_ptr(imx93_clk_of_match),
> +	},
> +};
> +module_platform_driver(imx93_clk_driver);

Building as module fails due to MODULE_LICENSE missing:

ERROR: modpost: missing MODULE_LICENSE() in drivers/clk/imx/clk-imx93.o

So I squashed in the following two lines:

+MODULE_DESCRIPTION("NXP i.MX93 clock driver");
+MODULE_LICENSE("GPL v2");

No need to resend.

> -- 
> 2.25.1
>
