Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368DC50CCBF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 19:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiDWRth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 13:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbiDWRtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 13:49:35 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10041.outbound.protection.outlook.com [40.107.1.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA28220F3;
        Sat, 23 Apr 2022 10:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOYbgezZMcYxrYsw/5aMq2qS+HjSf+NUa4xBhVSjb0BxrRu/kq2D47z+m8eznGB76GtugnzbVfBInR65E8Dff+5dY+kH1Kj/xbXqm5PB2eyamJnDvWCr91YWIvEXB3puY/YjLDS7ZFr5iywFyJqwSWRXKACuK3Womr4P4HYzHV0HR1lPaVPXHtbHwVHJK1g2GMGARixMVW7fHIbpuj7VgduKlPp0mceFE7S7bkcnxKePx+vlF/q82pXHyG8mYAo/TdHIPvvmOdsV+OJ0YqzJCwd5HZrLJPVRoK4w1rpdzLIuc+yN7kqjjZ3ke0I+6aIwxAY1J3V1kkzQC3WGJdytIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuAUrWp9NFImWwZkWfm9wgI8PzdKLH9WSqGb9DN+r1c=;
 b=X/GLvTNRxWwH5b3eBMBTGzCSxIXkiSBnY1wMj9u/8IQSnsTb0r/WpxptHAeg6ByRA5OO88AvCcifjqM1w8a1BWh/LYrg1fjzuHwju7hWlhpM9VUKX0z4LtG8kZ8E1Ojq3kEoGizMRe9SUe6Mrv2Agx4373Ti2U8xHuDLax1/g6nyivznlq9Fwy9kZBqctmtwIt7Y/HRR8+21KDAi0U3N/IIm2V5JRL4A+DAlDSTmNDL9juUMA/QPlrGd5rf7s5mNaRGmq5ewgWW3jB9XDcjcRtKf+N01a6upibr1DIc7uUwymgWgUtwJAmcQilnuqAY2FAqyY/MqSMXzzoI1ku4YFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuAUrWp9NFImWwZkWfm9wgI8PzdKLH9WSqGb9DN+r1c=;
 b=amXMjytH4U5UK2SltJFU6sibuAzbLwjQsHiI+ZMOdJxYV2ruIkVkXgHnszkYROpzJuyH8Ss9Yci/+FK5uYYgUv7wmyiUqtVbZlts0J01INM2RTdwBfpBxAl8GGzEYZYKccslGCTsEiNgCATbnhsgx2A6TS/rp0WLC9SSGagsXyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM6PR04MB4295.eurprd04.prod.outlook.com (2603:10a6:209:4f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Sat, 23 Apr
 2022 17:46:29 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::78d8:955a:7946:fd78]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::78d8:955a:7946:fd78%6]) with mapi id 15.20.5186.020; Sat, 23 Apr 2022
 17:46:29 +0000
Date:   Sat, 23 Apr 2022 20:46:26 +0300
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
Subject: Re: [PATCH v1 08/12] clk: imx: Add initial support for i.MXRT1170
 clock driver
Message-ID: <YmQ7ckrUYYgzVdWF@abelvesa>
References: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
 <20220326144313.673549-9-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220326144313.673549-9-Mr.Bossman075@gmail.com>
X-ClientProxiedBy: VI1PR09CA0156.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::40) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2066803-b30b-4a34-d3ae-08da2551320d
X-MS-TrafficTypeDiagnostic: AM6PR04MB4295:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM6PR04MB42954E6A33EE96C4C478CCECF6F69@AM6PR04MB4295.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ECltJg3zXNzKStvKhJDPBT9Ns2v+IdAhpmn7WN9ZdP58Zce33j6FepwjCxaS2zR9DOeWvMcUz3xPU4DbbI0hvxofleDcJDfJyvuXsFYnqcw2dig0GiryM3UIqgBA1ksoOD9S00flc9CJHC6+kFiUFV7RbQfD0H3GXy4LLpxRDRLMtMP/hbbbAK9z2vYXfLv3vMjQdHukxhPE4S0CbVZbLHofDEGwdoFcvtvUyH8yWQRaLQNT0nVP2HmYqAoYY7I3qMS/VLSmFc25v1CkLn4uMqe33VUKTKARPQIYOk1NBzyzIialBwLr3SZl1RoBFmUqfs00MijG2D+ad//IuLzYHmRae4TWV4q6n++PjBPv4jhSwuBs7TWMbVn8Afkm3GmX6k+IiTqze2FxxzO5mb8D1Rgd0nkF7rhjncREZr/IuHwoY5wDAlYjqi1N+udpfiJhXdVSayy5OzHIPxL1FK1KYbaF8IryH8DG4Bh41j95Yvpbl436S3ELTm6oAExgsLk/M9R4cXYFvHjaeGNtEvnYWfBkIRf9LWzSI2V68g+cE0BYQfQ7Vq1EfhJv+B2Flplf+d/kCyLK1r3H1TOjhoTfIcK8bHXt0ucv5dm1tITc48ea0qvQnevwVaSUh3IUXeNcV5OlfFhAbPQ1J+swFr+DcUB6szjCY2XMNgSeamsiUEQKe4tpZ+FG42odSgr2dSEvQCIy3omcKMtpmGhq/zqjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(52116002)(186003)(6666004)(6506007)(7416002)(53546011)(86362001)(6512007)(2906002)(44832011)(8936002)(5660300002)(508600001)(9686003)(30864003)(83380400001)(26005)(6916009)(33716001)(6486002)(38100700002)(316002)(38350700002)(8676002)(66476007)(66556008)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b0T76wnacFjUBN48921lDaOEjIAw4O9ZAhfHztalmnWBHLuMuMrdIuHk4lRh?=
 =?us-ascii?Q?JgBEkSs4tRbWVvdkN14KiehZea42hGSFcXrwFHBQ3Fjeafv9HxnYV+wVXPeE?=
 =?us-ascii?Q?Ia6hVAL5eZGZm3AqMsRDCOutDW7nPU7OQ9gEBBkNipHhwgSxmIy+czRqiHno?=
 =?us-ascii?Q?oVl9AUEA/tqKOKCk1G1fiweC/F5hDiMhdRouf3FhcBrI4hd5yAWGj6y3ZlBO?=
 =?us-ascii?Q?+Zf1GW21eo/3nw9nvVc6VwSgmUJKmcagG+ySOiFeltuvL2A82QBKvbBnm0OS?=
 =?us-ascii?Q?17sK9Y8YA686YF4a8f4DRmfusSksFpaL/La9fe8I0ctwCQbpihMGX1ds8UPC?=
 =?us-ascii?Q?7tSClGacPzQalNgnEZp5RWtAUjgch7MPzgseVJb9mCIhloXcqsQvJRaoMPCZ?=
 =?us-ascii?Q?eHm+DJ5NNB2ZEoDNtSVNJd5TWjQWQCRxIWS6/G84V6EXt6CW6qD4B2jy0eFi?=
 =?us-ascii?Q?1h+fS121c5shnx5RMBw71BnzHCfNGhG755jgpLzohBbpgdrZ82msb3ASuO9q?=
 =?us-ascii?Q?VC9YOaRZ4847nWniNSzYZzRYsaGznUs2EEGYID6Ujyh0LJc89RTwJkT6TupD?=
 =?us-ascii?Q?CzloWoXFYRMA1jrmyRR40q44y9nqQXXeUYzn35joLdFMaqr3ZKMjGq5UJZzu?=
 =?us-ascii?Q?W/W044V3WbcWz+nSpeEDb0WXuYdJ8davF3bR0y29UnpSt3kacmw3w//vDkvT?=
 =?us-ascii?Q?fguHjJxG1pC7c1UIFCQ0f8gN9iFUUL0FKtRbyjHOuSLA5UlP5zc5O5Ntf6yl?=
 =?us-ascii?Q?eD8SwV+RWavBJOYzUnncEt3savRnydxsxCNYr6Ufqw5rV43K3fF+wMSdIhd2?=
 =?us-ascii?Q?7y1zsAtXG6l/SRUSq3poR3IK0g0UUJNaY2I5RP+iKdqL4iylLqVhN9mMdUE3?=
 =?us-ascii?Q?g4giw1Tb9hWcptYpJUZYq90bBQxKi+M/wKWsyLXm86Vnnh1dtX9xVqCI88TT?=
 =?us-ascii?Q?upHI6nANrLlBntQw/F2eb3doamvHWgjdI5Ot22mICVxd5MYtkXDGix6jAVjo?=
 =?us-ascii?Q?7JW/rvQoFQDUpEzH/+fc9I+Nmn+p13BiqRUkVHAUEzVjW4luAXHXMSQdFUoR?=
 =?us-ascii?Q?qE7nIh8kDUE+Vahww161thvNRQS53R8ztlg56Fyhx+K/+saqIA0MXiYKkyVy?=
 =?us-ascii?Q?vtAx/c6Q0qDxF8/fm8zpNr8lNi1RAhw7yNHY5Eyt6iR/yfL/8q1WwsJv8wzk?=
 =?us-ascii?Q?SjqpSY37D3RyIzVYYzdplJyNMy1+QeU2vDZ4NFAeNT1eS7ET29SsZ3fw5fDr?=
 =?us-ascii?Q?1FhyK56jYMdw+0VUjpynkmX6MaAmnEVubAd9vGyywAqgyMeosfpQATnO+hNa?=
 =?us-ascii?Q?e9GU7rsKgMGOFPKU+0tg9AMPwRxZULrj2JdmSF0a3yKA+d/Ehs13O3B5ajCy?=
 =?us-ascii?Q?18KA3kAlENiRjKTwDqo8mZ+NH1YjmWWfL6RxW6lL4eioZM7fga/qMX1R/Uin?=
 =?us-ascii?Q?4Rqn6fK982Uf/1NO7DzSM87unbFwporCLARxotUp5FmZRxDZJDG4x5kMT8rm?=
 =?us-ascii?Q?ByyhLxTB2r/ijevTWfICyUAPgSSRfuTk4aioJwi+gzuUtQsrCVRwgzccTY63?=
 =?us-ascii?Q?rmhnee8k10/fpm8xvC++doDS9sEbbVvmu8VtVDC3agtPaWakB8DDHwcDF7fY?=
 =?us-ascii?Q?pB1fw1RS0aT+0UnRqizF55Ecs1JMIDsGJBpEEFUivgKJoEj4ugZVCp3q/9eI?=
 =?us-ascii?Q?paIu+UzX8uceMjtFV6ELcjMF8NoMOlI6P+/UOGArWXfOZekwdxkTGmIBOLIh?=
 =?us-ascii?Q?iSJF6w0H1A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2066803-b30b-4a34-d3ae-08da2551320d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 17:46:29.1504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHp3B6A7XFLS5RBcrq+PFk1lwmZM6skMnpvKs6rj/NxWhSnT6g+55psZCrWs9bffL0XIfF5ja8IxjXezWHbgHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4295
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-03-26 10:43:09, Jesse Taube wrote:
> Add clock driver support for i.MXRT1170.
>
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>  drivers/clk/imx/Kconfig         |   7 +
>  drivers/clk/imx/Makefile        |   1 +
>  drivers/clk/imx/clk-imxrt1170.c | 391 ++++++++++++++++++++++++++++++++
>  3 files changed, 399 insertions(+)
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
> index 000000000000..041aea3d4b02
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imxrt1170.c
> @@ -0,0 +1,391 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) 2022
> + * Author(s):
> + * Jesse Taube <Mr.Bossman075@gmail.com>
> + */
> +#include <linux/clk.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/imxrt1170-clock.h>
> +
> +#include "clk.h"
> +
> +#define CLOCK_MUX_DEFAULT "rcosc48M_div2", "osc", "rcosc400M", "rcosc16M"
> +
> +#define LPCG_GATE(gate) (0x6000 + (gate * 0x20))
> +
> +#define DEF_CLOCK(flags, macro, name) \
> +do { \
> +	hws[macro##_SEL] = imx_clk_hw_mux(#name"_sel", ccm_base + (name * 0x80), \
> +		8, 3, root_clocks[name], 8); \
> +	hws[macro##_GATE] = imx_clk_hw_gate_dis_flags(#name"_gate", #name"_sel", \
> +		ccm_base + (name * 0x80), 24, flags); \
> +	hws[macro] = imx_clk_hw_divider(#name, #name"_gate", ccm_base + (name * 0x80), 0, 8); \
> +} while (0)

I really don't see the value of doing this.

Lets just stick with how the other i.MX drivers do it.

Maybe a composite clock would work better, but for now let's do it the
old-school way. Add the muxes first, then the gates and the dividers at
the end.

> +
> +enum root_clock_names {
> +	m7,		/* root clock m7. */
> +	m4,		/* root clock m4. */
> +	bus,		/* root clock bus. */
> +	bus_lpsr,	/* root clock bus lpsr. */
> +	semc,		/* root clock semc. */
> +	cssys,		/* root clock cssys. */
> +	cstrace,	/* root clock cstrace. */
> +	m4_systick,	/* root clock m4 systick. */
> +	m7_systick,	/* root clock m7 systick. */
> +	adc1,		/* root clock adc1. */
> +	adc2,		/* root clock adc2. */
> +	acmp,		/* root clock acmp. */
> +	flexio1,	/* root clock flexio1. */
> +	flexio2,	/* root clock flexio2. */
> +	gpt1,		/* root clock gpt1. */
> +	gpt2,		/* root clock gpt2. */
> +	gpt3,		/* root clock gpt3. */
> +	gpt4,		/* root clock gpt4. */
> +	gpt5,		/* root clock gpt5. */
> +	gpt6,		/* root clock gpt6. */
> +	flexspi1,	/* root clock flexspi1. */
> +	flexspi2,	/* root clock flexspi2. */
> +	can1,		/* root clock can1. */
> +	can2,		/* root clock can2. */
> +	can3,		/* root clock can3. */
> +	lpuart1,	/* root clock lpuart1. */
> +	lpuart2,	/* root clock lpuart2. */
> +	lpuart3,	/* root clock lpuart3. */
> +	lpuart4,	/* root clock lpuart4. */
> +	lpuart5,	/* root clock lpuart5. */
> +	lpuart6,	/* root clock lpuart6. */
> +	lpuart7,	/* root clock lpuart7. */
> +	lpuart8,	/* root clock lpuart8. */
> +	lpuart9,	/* root clock lpuart9. */
> +	lpuart10,	/* root clock lpuart10. */
> +	lpuart11,	/* root clock lpuart11. */
> +	lpuart12,	/* root clock lpuart12. */
> +	lpi2c1,		/* root clock lpi2c1. */
> +	lpi2c2,		/* root clock lpi2c2. */
> +	lpi2c3,		/* root clock lpi2c3. */
> +	lpi2c4,		/* root clock lpi2c4. */
> +	lpi2c5,		/* root clock lpi2c5. */
> +	lpi2c6,		/* root clock lpi2c6. */
> +	lpspi1,		/* root clock lpspi1. */
> +	lpspi2,		/* root clock lpspi2. */
> +	lpspi3,		/* root clock lpspi3. */
> +	lpspi4,		/* root clock lpspi4. */
> +	lpspi5,		/* root clock lpspi5. */
> +	lpspi6,		/* root clock lpspi6. */
> +	emv1,		/* root clock emv1. */
> +	emv2,		/* root clock emv2. */
> +	enet1,		/* root clock enet1. */
> +	enet2,		/* root clock enet2. */
> +	enet_qos,	/* root clock enet qos. */
> +	enet_25m,	/* root clock enet 25m. */
> +	enet_timer1,	/* root clock enet timer1. */
> +	enet_timer2,	/* root clock enet timer2. */
> +	enet_timer3,	/* root clock enet timer3. */
> +	usdhc1,		/* root clock usdhc1. */
> +	usdhc2,		/* root clock usdhc2. */
> +	asrc,		/* root clock asrc. */
> +	mqs,		/* root clock mqs. */
> +	mic,		/* root clock mic. */
> +	spdif,		/* root clock spdif */
> +	sai1,		/* root clock sai1. */
> +	sai2,		/* root clock sai2. */
> +	sai3,		/* root clock sai3. */
> +	sai4,		/* root clock sai4. */
> +	gc355,		/* root clock gc355. */
> +	lcdif,		/* root clock lcdif. */
> +	lcdifv2,	/* root clock lcdifv2. */
> +	mipi_ref,	/* root clock mipi ref. */
> +	mipi_esc,	/* root clock mipi esc. */
> +	csi2,		/* root clock csi2. */
> +	csi2_esc,	/* root clock csi2 esc. */
> +	csi2_ui,	/* root clock csi2 ui. */
> +	csi,		/* root clock csi. */
> +	cko1,		/* root clock cko1. */
> +	cko2,		/* root clock cko2. */
> +	end,		/* root clock end. */
> +};
> +
> +static const char * const root_clocks[79][8] = {
> +	{CLOCK_MUX_DEFAULT, "pll_arm", "pll1_sys", "pll3_sys", "pll_video"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_sys", "pll1_div5"},
> +	{CLOCK_MUX_DEFAULT, "pll3_sys", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_sys", "pll1_div5"},
> +	{CLOCK_MUX_DEFAULT, "pll1_div5", "pll2_sys", "pll2_pfd1", "pll3_pfd0"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_pfd1", "pll2_sys"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd0", "pll1_div5"},
> +	{CLOCK_MUX_DEFAULT, "pll2_sys", "pll3_div2", "pll1_div5", "pll2_pfd0"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_sys", "pll1_div5", "pll_audio", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll3_pfd2", "pll3_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll_audio", "pll_video"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll_audio", "pll_video"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll3_pfd2", "pll3_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll3_pfd2", "pll3_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll3_pfd2", "pll3_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd0", "pll2_sys", "pll2_pfd2", "pll3_sys"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd0", "pll2_sys", "pll2_pfd2", "pll3_sys"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll3_pfd2", "pll1_div5"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll3_pfd2", "pll1_div5"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1"},
> +	{CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1"},
> +	{CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1"},
> +	{CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1"},
> +	{CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1"},
> +	{CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1"},
> +	{CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1"},
> +	{CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll2_pfd0", "pll1_div5", "pll_arm"},
> +	{CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll2_pfd0", "pll1_div5", "pll_arm"},
> +	{CLOCK_MUX_DEFAULT, "pll1_div5", "pll3_div2", "pll_audio", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll1_div5", "pll3_div2", "pll_audio", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll_audio", "pll1_div5"},
> +	{CLOCK_MUX_DEFAULT, "pll_audio", "pll3_sys", "pll3_pfd2", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll_audio", "pll3_pfd2", "pll1_div5", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll_audio", "pll3_pfd2", "pll1_div5", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll_audio", "pll3_pfd2", "pll1_div5", "pll2_pfd3"},
> +	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll_audio", "pll1_div5"},
> +	{CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd1", "pll3_sys", "pll_video"},
> +	{CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd2", "pll3_pfd0", "pll_video"},
> +	{CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd2", "pll3_pfd0", "pll_video"},
> +	{CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd0", "pll3_pfd0", "pll_video"},
> +	{CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd0", "pll3_pfd0", "pll_video"},
> +	{CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll3_sys", "pll2_pfd0", "pll_video"},
> +	{CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll3_sys", "pll2_pfd0", "pll_video"},
> +	{CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll3_sys", "pll2_pfd0", "pll_video"},
> +	{CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll3_sys", "pll3_pfd1", "pll_video"},
> +	{CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll2_sys", "pll3_pfd1", "pll1_div5"},
> +	{CLOCK_MUX_DEFAULT, "pll2_pfd3", "rcosc48M", "pll3_pfd1", "pll_audio"}
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
> +static struct clk_hw **hws;
> +static struct clk_hw_onecell_data *clk_hw_data;
> +
> +static int imxrt1170_clocks_probe(struct platform_device *pdev)
> +{
> +	void __iomem *ccm_base;
> +	void __iomem *pll_base;
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
> +	hws[IMXRT1170_CLK_PLL_ARM_PRE] = imx_clk_hw_pllv3(IMX_PLLV3_SYSV2,
> +		"pll_arm_pre", "osc", pll_base + 0x200, 0xff);

I know checkpatch complains here, but please make them single line. Looks cleaner.

> +	imx_clk_hw_pll3_powerbit(hws[IMXRT1170_CLK_PLL_ARM_PRE], 13);
> +	hws[IMXRT1170_CLK_PLL_ARM_BYPASS] = imx_clk_hw_mux("pll_arm_bypass",
> +		pll_base + 0x200, 17, 1, pll_arm_mux, 2);
> +	hws[IMXRT1170_CLK_PLL_ARM_DIV] = clk_hw_register_divider_table(NULL, "pll_arm_div",
> +		"pll_arm_bypass", CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
> +		pll_base + 0x200, 15, 2, 0, post_div_table, &imx_ccm_lock);
> +	hws[IMXRT1170_CLK_PLL_ARM] = imx_clk_hw_gate("pll_arm", "pll_arm_div", pll_base + 0x200, 14);
> +
> +	hws[IMXRT1170_CLK_PLL3_PRE] = imx_clk_hw_pllv3(IMX_PLLV3_GENERICV2,
> +		"pll3_pre", "osc", pll_base + 0x210, 0x1);
> +	imx_clk_hw_pll3_powerbit(hws[IMXRT1170_CLK_PLL3_PRE], 21);
> +	hws[IMXRT1170_CLK_PLL3_BYPASS] = imx_clk_hw_mux("pll3_bypass",
> +		pll_base + 0x210, 16, 1, pll3_mux, 2);
> +	hws[IMXRT1170_CLK_PLL3] = imx_clk_hw_gate("pll3_sys", "pll3_bypass", pll_base + 0x210, 13);
> +
> +	hws[IMXRT1170_CLK_PLL2_PRE] = imx_clk_hw_pllv3(IMX_PLLV3_GENERICV2,
> +		"pll2_pre", "osc", pll_base + 0x240, 0x1);
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
> +	DEF_CLOCK(CLK_IS_CRITICAL, IMXRT1170_CLK_M7, m7);
> +	DEF_CLOCK(CLK_IS_CRITICAL, IMXRT1170_CLK_M4, m4);
> +	DEF_CLOCK(CLK_IS_CRITICAL, IMXRT1170_CLK_BUS, bus);
> +	DEF_CLOCK(CLK_IS_CRITICAL, IMXRT1170_CLK_BUS_LPSR, bus_lpsr);
> +	DEF_CLOCK(CLK_IS_CRITICAL, IMXRT1170_CLK_SEMC, semc);
> +	DEF_CLOCK(CLK_IS_CRITICAL, IMXRT1170_CLK_CSSYS, cssys);
> +	DEF_CLOCK(CLK_IS_CRITICAL, IMXRT1170_CLK_CSTRACE, cstrace);
> +	DEF_CLOCK(0, IMXRT1170_CLK_M4_SYSTICK, m4_systick);
> +	DEF_CLOCK(0, IMXRT1170_CLK_M7_SYSTICK, m7_systick);
> +	DEF_CLOCK(0, IMXRT1170_CLK_ADC1, adc1);
> +	DEF_CLOCK(0, IMXRT1170_CLK_ADC2, adc2);
> +	DEF_CLOCK(0, IMXRT1170_CLK_ACMP, acmp);
> +	DEF_CLOCK(0, IMXRT1170_CLK_FLEXIO1, flexio1);
> +	DEF_CLOCK(0, IMXRT1170_CLK_FLEXIO2, flexio2);
> +	DEF_CLOCK(CLK_IS_CRITICAL, IMXRT1170_CLK_GPT1, gpt1);
> +	DEF_CLOCK(0, IMXRT1170_CLK_GPT2, gpt2);
> +	DEF_CLOCK(0, IMXRT1170_CLK_GPT3, gpt3);
> +	DEF_CLOCK(0, IMXRT1170_CLK_GPT4, gpt4);
> +	DEF_CLOCK(0, IMXRT1170_CLK_GPT5, gpt5);
> +	DEF_CLOCK(0, IMXRT1170_CLK_GPT6, gpt6);
> +	DEF_CLOCK(0, IMXRT1170_CLK_FLEXSPI1, flexspi1);
> +	DEF_CLOCK(0, IMXRT1170_CLK_FLEXSPI2, flexspi2);
> +	DEF_CLOCK(0, IMXRT1170_CLK_CAN1, can1);
> +	DEF_CLOCK(0, IMXRT1170_CLK_CAN2, can2);
> +	DEF_CLOCK(0, IMXRT1170_CLK_CAN3, can3);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPUART1, lpuart1);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPUART2, lpuart2);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPUART3, lpuart3);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPUART4, lpuart4);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPUART5, lpuart5);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPUART6, lpuart6);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPUART7, lpuart7);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPUART8, lpuart8);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPUART9, lpuart9);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPUART10, lpuart10);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPUART11, lpuart11);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPUART12, lpuart12);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPI2C1, lpi2c1);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPI2C2, lpi2c2);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPI2C3, lpi2c3);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPI2C4, lpi2c4);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPI2C5, lpi2c5);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPI2C6, lpi2c6);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPSPI1, lpspi1);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPSPI2, lpspi2);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPSPI3, lpspi3);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPSPI4, lpspi4);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPSPI5, lpspi5);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LPSPI6, lpspi6);
> +	DEF_CLOCK(0, IMXRT1170_CLK_EMV1, emv1);
> +	DEF_CLOCK(0, IMXRT1170_CLK_EMV2, emv2);
> +	DEF_CLOCK(0, IMXRT1170_CLK_ENET1, enet1);
> +	DEF_CLOCK(0, IMXRT1170_CLK_ENET2, enet2);
> +	DEF_CLOCK(0, IMXRT1170_CLK_ENET_QOS, enet_qos);
> +	DEF_CLOCK(0, IMXRT1170_CLK_ENET_25M, enet_25m);
> +	DEF_CLOCK(0, IMXRT1170_CLK_ENET_TIMER1, enet_timer1);
> +	DEF_CLOCK(0, IMXRT1170_CLK_ENET_TIMER2, enet_timer2);
> +	DEF_CLOCK(0, IMXRT1170_CLK_ENET_TIMER3, enet_timer3);
> +	DEF_CLOCK(0, IMXRT1170_CLK_USDHC1, usdhc1);
> +	DEF_CLOCK(0, IMXRT1170_CLK_USDHC2, usdhc2);
> +	DEF_CLOCK(0, IMXRT1170_CLK_ASRC, asrc);
> +	DEF_CLOCK(0, IMXRT1170_CLK_MQS, mqs);
> +	DEF_CLOCK(0, IMXRT1170_CLK_MIC, mic);
> +	DEF_CLOCK(0, IMXRT1170_CLK_SPDIF, spdif);
> +	DEF_CLOCK(0, IMXRT1170_CLK_SAI1, sai1);
> +	DEF_CLOCK(0, IMXRT1170_CLK_SAI2, sai2);
> +	DEF_CLOCK(0, IMXRT1170_CLK_SAI3, sai3);
> +	DEF_CLOCK(0, IMXRT1170_CLK_SAI4, sai4);
> +	DEF_CLOCK(0, IMXRT1170_CLK_GC355, gc355);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LCDIF, lcdif);
> +	DEF_CLOCK(0, IMXRT1170_CLK_LCDIFV2, lcdifv2);
> +	DEF_CLOCK(0, IMXRT1170_CLK_MIPI_REF, mipi_ref);
> +	DEF_CLOCK(0, IMXRT1170_CLK_MIPI_ESC, mipi_esc);
> +	DEF_CLOCK(0, IMXRT1170_CLK_CSI2, csi2);
> +	DEF_CLOCK(0, IMXRT1170_CLK_CSI2_ESC, csi2_esc);
> +	DEF_CLOCK(0, IMXRT1170_CLK_CSI2_UI, csi2_ui);
> +	DEF_CLOCK(0, IMXRT1170_CLK_CSI, csi);
> +	DEF_CLOCK(0, IMXRT1170_CLK_CKO1, cko1);
> +	DEF_CLOCK(0, IMXRT1170_CLK_CKO2, cko2);
> +
> +	hws[IMXRT1170_CLK_USB] = imx_clk_hw_gate("usb", "bus", ccm_base + LPCG_GATE(115), 0);
> +
> +	clk_set_rate(hws[IMXRT1170_CLK_PLL_ARM]->clk, 90000000);
> +
> +	imx_check_clk_hws(hws, IMXRT1170_CLK_END);
> +
> +	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register clks for i.MXRT1170.\n");
> +		imx_unregister_hw_clocks(hws, IMXRT1170_CLK_END);
> +	}
> +	return ret;
> +
> +	return 0;

Drop this one.

> +}
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
> 2.34.1
>
