Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E820C567B91
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 03:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiGFBd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 21:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiGFBdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 21:33:53 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73CE18B1C;
        Tue,  5 Jul 2022 18:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xj+8LssfFAGyW79hqPSoMEwVvV+iKVZ2yclArPp5dirKY0EaL8P5P2HPbHhP9UA0zd9LowqWy5CH/48uK6MvDjN4pmsbz53hItpfQTUhX+ejBQx/rvGkDUYPc+IFQMm6WapuDR1hIxeSu2tRvbXRH7FBeffUmEjkaXo8lCfB9knlpiA05dxM4Q2LIALjRE7ZHD3yOiQUinNRtbPdfWwSlQt+4jgGxgEuKRV6UBnDwwC7LYlJyh0LuwTnGB9b8NXdYs0/ucCyIEnBRgn42zJQGe5hkq10taX5d9WrtsqOsZe27zxxx+cIEySXgyqMxPuPGaPsDtPBn08h1ftzPbZ6cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg4VKaqA2QaZd/zcNlL9JGMIr9mW/5XH/vQuMNrGYGE=;
 b=XKA0qZPGhnVIZxeqrA+C1SkEhqaP+gFcQ6BpXPoc6IeZGS8vKcQeJQvTtAnJ3r63/+6NhvxuqB0anxX1A04f4H9sdTB0oKhLufwVyFUu4i3fo1Wl9lY51m08CDgF8M+1x1j2BlyxUK7xlGrfJMsuBVBnBZbD6CjtrgoQTpFjnQAlsfuwil+Mu2205r6f2K23RhKgWZqJBF9aKD3k8eGEsPZHzuyCA1cYs/Ru+lTRLU0UwV8g/T9fvtIi3yeAzpgM2fej7gSk0quD5nGXzvH8IgHLZu3FtcjxfleABoLwaahhPm9oJoe4VxQcUEQa1aTGg4WF24/7nxWeDyDC3u/Gew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg4VKaqA2QaZd/zcNlL9JGMIr9mW/5XH/vQuMNrGYGE=;
 b=AT0tQ/bzC58ex+Y3xW6BsbEiXKlkyLrRYWFVYcjVVkS/XEac9GHwUL/dO4Xl/uE7njOPPixaqsrq+YThOTGRYEB1a4IgMweH1SJaRxC6qZjSU8OfbrcD3f2OkO+GF8k51qKagWzyKjPs1cm2t+FYZJh+ZaofOBrtMv9Sez8wOuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PAXPR04MB8407.eurprd04.prod.outlook.com (2603:10a6:102:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 01:33:49 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::416e:6e99:bac6:d3a9]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::416e:6e99:bac6:d3a9%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 01:33:49 +0000
Message-ID: <e39faddb23c80a5cfa600109ae2d20335435c234.camel@nxp.com>
Subject: Re: [PATCH v3 3/3] phy: freescale: Add i.MX8qm Mixel LVDS PHY
 support
From:   Liu Ying <victor.liu@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
In-Reply-To: <YsP8TYgA7SU72/xE@matsya>
References: <20220620123854.1138028-1-victor.liu@nxp.com>
         <20220620123854.1138028-4-victor.liu@nxp.com> <YsP8TYgA7SU72/xE@matsya>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 05 Jul 2022 23:10:29 +0800
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cdf0049-8997-4765-0c29-08da5eef932f
X-MS-TrafficTypeDiagnostic: PAXPR04MB8407:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A71o1C9KkoF4unqvwCdqSBYzaRDAWYhRP28MO1BQqtyo79MyuQUA6ziP9gTdIVxc6vHyTbLMnDU1uu0B2twPe6ObneAJfAppOESufV3rc5DWcwW7A9wY1ffxTGsVIUAEcWfcDdrUJPVhXguGShXTp9GM+saNQVbNSqA4d7MmUOEGZ2ZpXxt/I7FYa+d6XeCDegFLr8nWIvdAs5FumYsIyZ+zsgJg2RGvATb5xUJgRb6WH75rAUCv4PuvSOu92bHP7X2osylWbZ3luNNXrAdaY2wMyrg01E3uVgmeKAfCkJH9wTEfAxARbmd9eKSuoU0M24o+c5pgjqnC6niypVpIxyy/0CT2Zk6nT4UAS+1/Wa4aEyLYLeCBx1okyqz2bhxODr3QNBH0Fk7M93gbnBzW2aE9cfsb2XDq2oc4QJn/KztdNkWI1lKpYuQmAl4tR3NOWg3dd+pqQgaM5vkqouzkluB66iQtBmr4T4BQNHb9/nf9FKQyR76EXrciq0d1j7+H8grogCt/UHh2cIA/bjNuNiHQWRqjJ5oX0iHDQYkbyEHb8L0CfQGPwjPn1v/0oaGUO+3VxIst4qcziwC/v25J5gNSFs4U8QPMmulLJo4Xo/kTuEsb4pXojlVuyTt+mQ0MuaLgXoKt7riWJiD+HuuSPGnOq0zF/rV2MzsdWMwF3R/p2yeM6ok8KimCLAwTB2imwVo12gjOeIfCe84NSskyEDpjpEr9GiWu3F5pqP8gwcyfyUZVxS3t2c5+s5BFF6aEkIGt/LRzEp81poBho4mX4Yi7fbuoA8QHzeUFSvWX1qUjiwjZdszf4IC9Ql8nxhydySk9IsrBsqnBMbO40lc05A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(6506007)(36756003)(6916009)(53546011)(52116002)(86362001)(38100700002)(38350700002)(6666004)(316002)(8676002)(2906002)(83380400001)(41300700001)(4326008)(6486002)(5660300002)(66476007)(66556008)(6512007)(26005)(66946007)(186003)(8936002)(7416002)(478600001)(2616005)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzZDMHBHelpKajFPVmpmMmRhSGxBRUtGRHJsZmJRSUpsWnJCd3MvdXBjL09T?=
 =?utf-8?B?OTF1d3BReFlhSnE4bnNseW5iNGgzb2toRDRUYTJsemQ3V09QWFdBZzNMOXBr?=
 =?utf-8?B?c01EUWhjYW42c3ZUWDk5OSsrUWdVQkg0ekFmcVdsKzMvVTBxVHV0aDAzbGZ6?=
 =?utf-8?B?R2VKVTFoT1g0MENiclZRODAwQUxuUHkvSmxFampkS1FJOUhFS1d4Zi9CQ3Bl?=
 =?utf-8?B?ZzlyTHpvQzhwcjhIaHF2M3hCY1lmS0VpSFEzUnd1V0h0QlFOUU1sbXVyd01k?=
 =?utf-8?B?bm9ScjM1Z2Z2TVBjNFJTdWtXTGZxblhJYTEyalZEUmZQWTFBa2Zwd280VmQ4?=
 =?utf-8?B?c0dCbk52NGpTQUdhbUtCdVpoNDhmVGJqRFRlR1FrWCsxdjRiMnRWdjJGS0RQ?=
 =?utf-8?B?Rnc0a0E0am9EVmloNk1aeldUaUhIeFM4SHR4REgxc1I1a2ZIVVFKQk02U2Rt?=
 =?utf-8?B?VG9MRDBWcnpOZzdUVjk0b0xKa2lkcnkxSDhRYnc0cDdCK015K2RweXZXck51?=
 =?utf-8?B?blhTVkNhazlZeFFzOFAxRDlibWZGSGhDaW9HbVlpWUZJdHh1RVNYTmVGTU1T?=
 =?utf-8?B?NnhSa0tXZ1FrRkoxUGRFa1NiM0FwWWVYTERxeGsyMU52a04vcjV0MU5pRzls?=
 =?utf-8?B?ZHM3aWVvaFJiSnFYak5ja25FVjRMMGJqdnhLeTdPcFVscUd4b3NwSFZRUlcz?=
 =?utf-8?B?WEdnVlBkL2haRFNwcjVuSlUzV1B4TmxQbTlJN0ZYSVBRQlBwcnpJbDZvZ2pU?=
 =?utf-8?B?TXBFWE5LQXV6SUNmVEd6c1F5TXIva1h4Smhjc0hydlRZMkRWQ0ZmbU02ekRi?=
 =?utf-8?B?WjcvM0NMTHByQnJoVTNuQWlqdVhJM1grNTdvUU9tSFR1VnQzRnpUek9hM0Fr?=
 =?utf-8?B?c2JOZHJqUk9uaDZaMVNsYmFiK0NSVmdtekxONERXV0V3NHM4MUNUeXlYeHNk?=
 =?utf-8?B?czFkNVFGY25KWGVFdHJkNkdwdWw5dE1PMkE2MTJqRmIwY0FxMTR2bFkvTDJF?=
 =?utf-8?B?amtXNHVrRUJCUzZIeTdpYUUvUU4wMHdPTVZac0wzaFhDTUxKQ2Fib1RNNmt0?=
 =?utf-8?B?RXFZbDUxSXFIeUFCekpYNk5pNDhwUXZDc2dqUUlVRlZreFVyV0ttZGJLbHp5?=
 =?utf-8?B?R2ZhTmRFaVBkVjJYSVJYbkNLVVNCenU2U2lSMXlXNTl2WTVuZkI0cE5CUWtJ?=
 =?utf-8?B?OXhIb1dXd2VOblpZREUwNHVwYWdHZXJTQU5xaG5odElxVks2Z3JXR2ljb1NY?=
 =?utf-8?B?b0xJZUhYZ2kyUkptRURUeVJXVUhUMWhSdEZQQkhBeElheEZ4N2xTeC9YV0hh?=
 =?utf-8?B?WHVyYTAvbmtkWnhXQjhtK1BXcVVzZFJZNWdSdlV0a1NzempWRTZJeTYrai9J?=
 =?utf-8?B?NEVaZ3lJMWYvSE1GWGpYYUFEWmY4NVIxL1ZtcmRObVFleW1tL2VLV28rdlpy?=
 =?utf-8?B?VHJ4OUtLbit3WWdFRWxRa0lRR1dseEE0S2xieXUvSWVzbVhicDZxenh4MmZZ?=
 =?utf-8?B?eHV3REtsMDByMDRvWUZObHdUQ3lhNGpvemI2Vk9EOCtnV0N3NHlDVlg5VUw0?=
 =?utf-8?B?RUt3bFRtalVrazBBQ1pteEVlakhoQmtXWEJ2OEJSdEFNUUZHL1dPSWJ4WmE4?=
 =?utf-8?B?VEdqRjVtcDdpR2lvTm9nb2tYNVJSWm9WYjVYK2libnNzd21mS2hiSVBhdmZB?=
 =?utf-8?B?V1ZYb0d2UWlIcXZrME9leVJORUw3NFQwZEpuRzRlOFZxTHdNVFM3WmZLU2x6?=
 =?utf-8?B?Y1Z4dUpCc1pGOGlqWHhRcmtITUFYbHVTdWdvNEVyanFKV1Zia2p5V3Q1a3dt?=
 =?utf-8?B?NDdPcXQwaUdDRVlsUWtWSWhmajZYZjVTcFVwczZhbUVZVkF2ZmJab2FVbWk2?=
 =?utf-8?B?MmloU2NuYmdkcUxoMmpaVHZnY0EwaDg3RU5mZlk3cEpqYXZtWkcvbGdGZ1hO?=
 =?utf-8?B?QnR4dnpEWWZEU1N0R0l1RmhZZTk0akJDL01STDRlYmgwZFV5QS9EZE1zcW55?=
 =?utf-8?B?OTI1UTZ1L2YvN0orODc1YUQrWW9hYmZPdC80a3JhY3NWeTArR3JpTUtXVmFu?=
 =?utf-8?B?WkhuazcxUjJETXpQL21WTUFHUnVFVEZGcGJNWFljcHpoY2lTVzhhdE5VNFdH?=
 =?utf-8?Q?XrNpzZAvD+enYQWLjE0hXCSI7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdf0049-8997-4765-0c29-08da5eef932f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 01:33:48.8999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJM+/F15JSWLoRgpw/PrQWSgsqBu6aYU8kVP1YpnKWukC/YshCYBe7x4x3DSc0Ko02+vvQKWaWio74NKaKIbjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8407
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-05 at 14:24 +0530, Vinod Koul wrote:
> On 20-06-22, 20:38, Liu Ying wrote:
> > Add Freescale i.MX8qm LVDS PHY support.
> > The PHY IP is from Mixel, Inc.
> > 
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> > v2->v3:
> > * No change.
> > 
> > v1->v2:
> > * Drop 'This patch' from commit message. (Krzysztof)
> > * Make dev_err_probe() function calls as one-liners. (Krzysztof)
> > * Drop unnecessary debug messages. (Krzysztof)
> > * Get phy_ref_clk without name specified due to 'clock-names'
> > dropped from
> >   dt-binding.
> > 
> >  drivers/phy/freescale/Kconfig                 |   9 +
> >  drivers/phy/freescale/Makefile                |   1 +
> >  .../phy/freescale/phy-fsl-imx8qm-lvds-phy.c   | 440
> > ++++++++++++++++++
> >  3 files changed, 450 insertions(+)
> >  create mode 100644 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
> > 
> > diff --git a/drivers/phy/freescale/Kconfig
> > b/drivers/phy/freescale/Kconfig
> > index f9c54cd02036..853958fb2c06 100644
> > --- a/drivers/phy/freescale/Kconfig
> > +++ b/drivers/phy/freescale/Kconfig
> > @@ -8,6 +8,15 @@ config PHY_FSL_IMX8MQ_USB
> >  	select GENERIC_PHY
> >  	default ARCH_MXC && ARM64
> >  
> > +config PHY_MIXEL_LVDS_PHY
> > +	tristate "Mixel LVDS PHY support"
> > +	depends on OF
> > +	select GENERIC_PHY
> > +	select REGMAP_MMIO
> > +	help
> > +	  Enable this to add support for the Mixel LVDS PHY as found
> > +	  on NXP's i.MX8qm SoC.
> > +
> >  config PHY_MIXEL_MIPI_DPHY
> >  	tristate "Mixel MIPI DSI PHY support"
> >  	depends on OF && HAS_IOMEM
> > diff --git a/drivers/phy/freescale/Makefile
> > b/drivers/phy/freescale/Makefile
> > index 3518d5dbe8a7..cedb328bc4d2 100644
> > --- a/drivers/phy/freescale/Makefile
> > +++ b/drivers/phy/freescale/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  obj-$(CONFIG_PHY_FSL_IMX8MQ_USB)	+= phy-fsl-imx8mq-usb.o
> > +obj-$(CONFIG_PHY_MIXEL_LVDS_PHY)	+= phy-fsl-imx8qm-lvds-phy.o
> >  obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)	+= phy-fsl-imx8-mipi-dphy.o
> >  obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)	+= phy-fsl-imx8m-pcie.o
> >  obj-$(CONFIG_PHY_FSL_LYNX_28G)		+= phy-fsl-lynx-28g.o
> > diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
> > b/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
> > new file mode 100644
> > index 000000000000..37f77115ddab
> > --- /dev/null
> > +++ b/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
> > @@ -0,0 +1,440 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2017-2020,2022 NXP
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +
> > +#define REG_SET		0x4
> > +#define REG_CLR		0x8
> > +
> > +#define PHY_CTRL	0x0
> > +#define  M_MASK		GENMASK(18, 17)
> > +#define  M(n)		FIELD_PREP(M_MASK, (n))
> > +#define  CCM_MASK	GENMASK(16, 14)
> > +#define  CCM(n)		FIELD_PREP(CCM_MASK, (n))
> > +#define  CA_MASK	GENMASK(13, 11)
> > +#define  CA(n)		FIELD_PREP(CA_MASK, (n))
> > +#define  TST_MASK	GENMASK(10, 5)
> > +#define  TST(n)		FIELD_PREP(TST_MASK, (n))
> > +#define  CH_EN(id)	BIT(3 + (id))
> > +#define  NB		BIT(2)
> > +#define  RFB		BIT(1)
> > +#define  PD		BIT(0)
> > +
> > +/* Power On Reset(POR) value */
> > +#define  CTRL_RESET_VAL	(M(0x0) | CCM(0x4) | CA(0x4) |
> > TST(0x25))
> > +
> > +/* PHY initialization value and mask */
> > +#define  CTRL_INIT_MASK	(M_MASK | CCM_MASK | CA_MASK | TST_MASK
> > | NB | RFB)
> > +#define  CTRL_INIT_VAL	(M(0x0) | CCM(0x5) | CA(0x4) |
> > TST(0x25) | RFB)
> > +
> > +#define PHY_STATUS	0x10
> > +#define  LOCK		BIT(0)
> > +
> > +#define PHY_NUM		2
> > +
> > +#define MIN_CLKIN_FREQ	25000000
> 
> this is 25MHz, so lets write as 25 * MEGA (see units.h)

Will do.

> 
> > +#define MAX_CLKIN_FREQ	165000000
> 
> here too

Will do.

> > +
> > +#define PLL_LOCK_SLEEP		10
> > +#define PLL_LOCK_TIMEOUT	1000
> > +
> > 

[...]

> > +
> > +static int mixel_lvds_phy_power_off(struct phy *phy)
> > +{
> > +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(phy-
> > >dev.parent);
> > +	struct mixel_lvds_phy *lvds_phy = phy_get_drvdata(phy);
> > +
> > +	mutex_lock(&priv->lock);
> > +	regmap_write(priv->regmap, PHY_CTRL + REG_CLR, CH_EN(lvds_phy-
> > >id));
> > +	mutex_unlock(&priv->lock);
> 
> No check for slave here?

I don't worry too much about separate channel power off. But, it should
be fine to power off the two channels together if the companion is a
slave phy. So, will check for slave here.

> 
> > +
> > +	clk_disable_unprepare(priv->phy_ref_clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mixel_lvds_phy_configure(struct phy *phy,
> > +				    union phy_configure_opts *opts)
> > +{
> > +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(phy-
> > >dev.parent);
> > +	struct phy_configure_opts_lvds *cfg = &opts->lvds;
> > +	int ret;
> > +
> > +	ret = clk_set_rate(priv->phy_ref_clk, cfg-
> > >differential_clk_rate);
> > +	if (ret)
> > +		dev_err(&phy->dev,
> > +			"failed to set PHY reference clock rate(%lu):
> > %d\n",
> 
> this can fit in a single line (100 chars is okay)

Will do.

> 
> > +			cfg->differential_clk_rate, ret);
> > +
> > +	return ret;
> > +}
> > +
> > 

[...]

> > +static int mixel_lvds_phy_validate(struct phy *phy, enum phy_mode
> > mode,
> > +				   int submode, union
> > phy_configure_opts *opts)
> > +{
> > +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(phy-
> > >dev.parent);
> > +	struct mixel_lvds_phy *lvds_phy = phy_get_drvdata(phy);
> > +	struct phy_configure_opts_lvds *cfg = &opts->lvds;
> > +	int ret = 0;
> > +
> > +	if (mode != PHY_MODE_LVDS) {
> > +		dev_err(&phy->dev, "invalid PHY mode(%d)\n", mode);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (cfg->bits_per_lane_and_dclk_cycle != 7 &&
> > +	    cfg->bits_per_lane_and_dclk_cycle != 10) {
> > +		dev_err(&phy->dev, "invalid bits per data lane(%u)\n",
> > +			cfg->bits_per_lane_and_dclk_cycle);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (cfg->lanes != 4 && cfg->lanes != 3) {
> > +		dev_err(&phy->dev, "invalid data lanes(%u)\n", cfg-
> > >lanes);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (cfg->differential_clk_rate < MIN_CLKIN_FREQ ||
> > +	    cfg->differential_clk_rate > MAX_CLKIN_FREQ) {
> > +		dev_err(&phy->dev, "invalid differential clock
> > rate(%lu)\n",
> > +			cfg->differential_clk_rate);
> > +		return -EINVAL;
> > +	}
> > +
> > +	mutex_lock(&priv->lock);
> > +	/* cache configuration set of our own for check */
> > +	memcpy(&lvds_phy->cfg, cfg, sizeof(*cfg));
> > +
> > +	if (cfg->is_slave) {
> > +		ret = mixel_lvds_phy_check_slave(phy);
> > +		if (ret)
> > +			dev_err(&phy->dev,
> > +				"failed to check slave PHY: %d\n",
> > ret);
> 
> very ugly, single line pls

Will do.

> 
> > +	}
> > +	mutex_unlock(&priv->lock);
> > +
> > +	return ret;
> > +}
> > +
> > 

[...]

> > +
> > +static int mixel_lvds_phy_reset(struct device *dev)
> > +{
> > +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = pm_runtime_get_sync(dev);
> 
> pm_runtime_resume_and_get() pls

Will do.

> 
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to get PM runtime: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	regmap_write(priv->regmap, PHY_CTRL, CTRL_RESET_VAL);
> > +
> > +	ret = pm_runtime_put(dev);
> 
> this seems to be done only around reset, why not in on/off method?

The reason is that phy-core.c does that (See phy_pm_runtime_get_sync
and phy_pm_runtime_put).

Thanks,
Liu Ying

