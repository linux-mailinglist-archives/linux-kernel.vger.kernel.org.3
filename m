Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C174FDEC9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346752AbiDLMAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352422AbiDLL62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:58:28 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00053.outbound.protection.outlook.com [40.107.0.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E40864BEF;
        Tue, 12 Apr 2022 03:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5GOnDS+tFX8I2SgpfXvM5YQuDV5GgmdD4axJv3OZlOmS9ttL1+42qwNcncrYGx16Om+yRtLJbm0oMmACpAv8DQ+6F3xJAfbCCrbLYXT3rxsVuOBhkqKlruVG5QAoQYQZKd8G2S8ujH2he+UEOEXWOAAYIwdeAtp9eviJRiIm7rpuXSrXEMEM84ShxxXZzXrzdHDyb146akrUZC2r9BNmXZcIFxb47UWK1h52ryO8BpYpmygP3qL/X9S75roeSmLvd+6eLGEDQgb90wxuuSY68OAElftz0rwCZ5YiPYGx6pR+E0vCkg/fUaQAQLX4uJGOh+wBhncxLs9UX74x3xMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+gbW5uDb44kNuk9zOee43YxgdK9QXOzmkeLJbinXGU=;
 b=MFWwGRAc/GiAutByuMrVJgiXkEOcgSSSeUV6WpcV8dWdvJAmh1dp2AZcc7YgVf8AMKTO6rLrOMLe++d5KQ159SPC1NimwkSeg4UTLfYr59mpVqMhkD90oFz0pTnbb5e5+GZe2uwCobxolna2ZjKB5tWRPCoxQ1O+d2g/i1zj0iQG0mOPX3q6Px+FC+HxXaaO3Gdjvvqe2JYzI+RM0VIlf0StDdcNOmdx2TBykYO9ye8hy1Lcl4M0cVdYv6I0iUivMW1vXM+t0lRI/HVDJUh8eiWey8VGmqoSlUThbpRo7/5Qrlaop3yA2/lMIGvb7Jvw/K/A5pQ72ip2q9f8odK1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+gbW5uDb44kNuk9zOee43YxgdK9QXOzmkeLJbinXGU=;
 b=RqWp5SRkDfS4zkTCIvC+H+REYdw2++j4wLup09OXiGe8Dh9M+71FvbFGjZExvlrst/4R3teJXYRFNipClUtvcVflixBt0+/3sOCtMNddjgNo3zzRQmGJzi7LBn0He7Xz8uXLnl6+3RO7fQ3n2sZGBaxRJRXP+GHhFZt1HoWenBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM5PR04MB3059.eurprd04.prod.outlook.com (2603:10a6:206:b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.25; Tue, 12 Apr
 2022 10:48:46 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 10:48:46 +0000
Date:   Tue, 12 Apr 2022 13:48:44 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 1/2] clk: imx: add mcore_booted module paratemter
Message-ID: <YlVZDGhbY0rCWHnk@abelvesa>
References: <20220228124112.3974242-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228124112.3974242-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1PR0502CA0030.eurprd05.prod.outlook.com
 (2603:10a6:803:1::43) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6956374f-acf0-4be4-7bcd-08da1c7204e5
X-MS-TrafficTypeDiagnostic: AM5PR04MB3059:EE_
X-Microsoft-Antispam-PRVS: <AM5PR04MB30597234F59992A626538BE4F6ED9@AM5PR04MB3059.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfeDhV4No1umq8d8vEld71CSlME4VM5nspsLe8NUAbdFkSdtLynvv4YMEfpzp7OKzur7pfmOmB/aSfiaKIVJYgj6F3AEBZk6TD5FTF+ox8T9ncvKCoRx631nFFx40VwII4cqolJ49QHgWwgj9DCQXs4rq59V/m+Ozd96qXkwxcWjoZ9npGZ18GMmUmA1YFaWT5YAD0dMOe+fv9qz4bSgjJjz4xrXmd5AAxQ2du9LoF8f+/YXvUb8Sv/ISjEdyOwLXclt6Nt5mlT5UzVQQg95xNBtXGPsLDNy9N6TD+AI+Gh366uvWOQwLT8rqYb+lvv9cp78bHjLld6urS7SCD0YpA/B4+iZA92LbmSr3rDcPNk7sEoggrtHsdidboWdgSPDcmmDo4mgnRsfITse74vAhAhS0ZqVQ90KIxdsukMIkDyaB1ZZ6ufWN/9EhE+ZGpt0sem/YK3fN+RAmVqfc6eh8wdyLCmgEYWB7M4odNGDSgnjQq6psCUFGt4bPmC8Wj/mP3FREPfWiuYnQhqso4ZvZWPt+id9D+Ju/XlCHsHDwGNPjafY/X0vDFRJPGM3IpThdH1Z74JTo9iBvP9kBTLoGt6Cu9Rqi1r3kOp4wvubENlC7IFfkDZK1NBSWXkhCFTAlmPYTWeeBna+/nYfoyc2vZBqdqGrVYACNe0I/CGyehlkB7wFnSDx0fuiGoi3UQ72hjwvgOz4ObtThhbGNldSxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(52116002)(9686003)(53546011)(316002)(38350700002)(6486002)(38100700002)(83380400001)(86362001)(44832011)(2906002)(8936002)(5660300002)(508600001)(33716001)(6512007)(66476007)(4326008)(66946007)(186003)(66556008)(6506007)(8676002)(26005)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TMNqbii/ZeV2uE5IElDhMIPcr0mrIqeExdd+o7esZwdFHHXOk7Ez2dt0EzZX?=
 =?us-ascii?Q?KDH3B4KGdOwbmdVbywOdeiJvO8FR9KKVbQdt823sfhU823vzUifNsicij5M3?=
 =?us-ascii?Q?8TsT/xmWh75U3853Vbx/sHsCDzuDHrFgZ6ZySzjLopWNNGVek56Ta4/sSzAC?=
 =?us-ascii?Q?/1X0p5C8dRhdOPbhTL8SPWvDKhaZlFVtXjRYJ6M439KtNk4LeKsVgB1h+3mg?=
 =?us-ascii?Q?MhYub3VW2rC6VM9HjpUvDpiOH916jWmyllt9nStilWHAjJv7KoGuUhrq+Pd5?=
 =?us-ascii?Q?5Xfbgt62wXYHKv2Qge69ZbwCGVAqqsrBHb34aJtaDvuHWHkOCVDTNDvwl+E5?=
 =?us-ascii?Q?Ly6+KxcY6JBM2ll9EhukxPB8X0rNbCb7ZtHvh70dyAhwjZ1wDjf/R3z7egFS?=
 =?us-ascii?Q?yu89/+kXVemkW88Sg0T/cfiRGSLuoA+q21RV8tJx4vqxtzRxVKLGnTmG06M9?=
 =?us-ascii?Q?a+I+tjbvBYeOZW7MoP2gfkZn/pXD6rXIz9uUCRdOD3MuOgL5rxAnoGD6iII1?=
 =?us-ascii?Q?fDebjDtk4r9lY/ridpIoAQBAYp+sKtOccutX1vHFmbfiFWvq6ekwNHp0LEkG?=
 =?us-ascii?Q?+BKs2d/GQ4ohwcIIMQ7nW7tDvOY8dTc/TXYS4yzxL8Bthu9RlQIXAmrQN+FS?=
 =?us-ascii?Q?yfr+bNyFeToctE1o0qlyZCMsB89UL8i5YD6ztcdbBgpCCc9z+6drfN78Dz+k?=
 =?us-ascii?Q?CZVK6FU0+LtSPCwN0VtL6ieQHlcrLeNmGE1XN1+TqI2t4s7aFVd8BYBi9Exk?=
 =?us-ascii?Q?DmM0H7q+pe1ZIuQMbd35255upI11FHcMldpwwKQrFZZqSEJtGS9E+q/Azrys?=
 =?us-ascii?Q?QgR3INQ86BIrgU8eFrTuVGUeZvDCq/xIzM+ZIswzsRXBYtC6SHgvHmt+rMMY?=
 =?us-ascii?Q?dJ872a0H5hMZD+qn+3x8TYnwCV5eaTOpdPW/4y+tN1R1cxTQAfrQp4jQtLt3?=
 =?us-ascii?Q?zm0Qx9A0q4Yka9GjuwxB4OCdfqxUUomLyeQ7HNRRbXP+yLIbEwb6oj/pnHnK?=
 =?us-ascii?Q?P/zM1m0umB9s5f1ukYYTuBpbRxX6ECMOBnmtvSEXmrQKH7fYWXMDWmsoQlKK?=
 =?us-ascii?Q?9lR2D+VBB+c9i8MqtJxH6vPKWMV9WTBn9Q64MT5VdpSu+5AXHwj1tfQdPwB9?=
 =?us-ascii?Q?m0orFHXO6mJrx1NKP3mf7rvaP5zkFqwT50frxlVjHDjf/V1npCOL1AvT5v1Z?=
 =?us-ascii?Q?7Uj88xhJRKty5sYcnL2zMQWwVKDbtbtD+NzjfAxIuscVu4O2WMBCXVtvo3Sq?=
 =?us-ascii?Q?LEjfjuJHvP9dmuZLrVvpJBpNSFXqS6I5zhr1J7atDrN5vVIzuteCHjtkrZf6?=
 =?us-ascii?Q?fGXXD+dFuoG0xjOrPm6iMf3OZ+WgMSVADlUpfQA/6OzpJLc8htf3p2Cu4OU4?=
 =?us-ascii?Q?g9E4RiitSncHBIoGtZKKZd8iFZ8D9/wdiB7Aj7OFe1VECGng90hVqrda1yyX?=
 =?us-ascii?Q?eokmk6oABqbmh1SwHk2/4QcFHaOM7sMR08h5F93tPutKRj5Vsw6h27ULJuFE?=
 =?us-ascii?Q?jwGToJ1XuUVbYbxCIZjc2Wo7WvgjIBiPuXvaI/H27HmCbwCyXZ4Z8uSeOW26?=
 =?us-ascii?Q?h4Y4zffLZE6pwX2xilyqLs36ZsyongcCJzuTo29LaQPaQt3aHlSoLsDnGs/J?=
 =?us-ascii?Q?UUlwy+oCDRR5tqWyp4Szw+VCQNraUeCzyGTiPpPUEzGbAzbONbMdx3l0qqYD?=
 =?us-ascii?Q?Nk4rxnH+RwaMKIkm4yR364A1AYAYEBB6Ui1LVEepQJRvmuCuNz2/toiJN7/k?=
 =?us-ascii?Q?6T7lQ9C28A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6956374f-acf0-4be4-7bcd-08da1c7204e5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 10:48:46.3000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHVjT+baEN0KB3+D71fI22O07qWBqSXDIAZZ/izJWKt7hbVsVrhr/8ghfBKc4OdokOEoGGgelvBOGO5Adjvu3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-28 20:41:11, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Add mcore_booted boot parameter which could simplify AMP clock
> management. To i.MX8M, there is CCM(clock control Module) to generate
> clock root clock, anatop(analog PLL module) to generate PLL, and CCGR
> (clock gating) to gate clocks to peripherals. As below:
>   anatop->ccm->ccgr->peripheral
>
> Linux handles the clock management and the auxiliary core is under
> control of Linux. Although there is per hardware domain control for CCGR
> and CCM, auxiliary core normally only use CCGR hardware domain control
> to avoid linux gate off the clk to peripherals and leave CCM ana anatop
> to Linux.
>
> Per NXP hardware design, because CCGR already support gate to
> peripherals, and clk root gate power leakage is negligible. So
> when in AMP case, we could not register the clk root gate.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied both, thanks.

> ---
>
> V2:
>  Switch to use module parameter, tested on i.MX8MP-EVK
>
>  drivers/clk/imx/clk-imx8mm.c | 2 ++
>  drivers/clk/imx/clk-imx8mn.c | 2 ++
>  drivers/clk/imx/clk-imx8mp.c | 2 ++
>  drivers/clk/imx/clk-imx8mq.c | 2 ++
>  drivers/clk/imx/clk.c        | 3 +++
>  drivers/clk/imx/clk.h        | 1 +
>  6 files changed, 12 insertions(+)
>
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index e8cbe181ec06..a452fd1bb891 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -639,6 +639,8 @@ static struct platform_driver imx8mm_clk_driver = {
>  	},
>  };
>  module_platform_driver(imx8mm_clk_driver);
> +module_param(mcore_booted, bool, S_IRUGO);
> +MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
>
>  MODULE_AUTHOR("Bai Ping <ping.bai@nxp.com>");
>  MODULE_DESCRIPTION("NXP i.MX8MM clock driver");
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 92fcbab4f5be..dc69b7464b3d 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -594,6 +594,8 @@ static struct platform_driver imx8mn_clk_driver = {
>  	},
>  };
>  module_platform_driver(imx8mn_clk_driver);
> +module_param(mcore_booted, bool, S_IRUGO);
> +MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
>
>  MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
>  MODULE_DESCRIPTION("NXP i.MX8MN clock driver");
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 18f5b7c3ca9d..250e45d9f844 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -721,6 +721,8 @@ static struct platform_driver imx8mp_clk_driver = {
>  	},
>  };
>  module_platform_driver(imx8mp_clk_driver);
> +module_param(mcore_booted, bool, S_IRUGO);
> +MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
>
>  MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
>  MODULE_DESCRIPTION("NXP i.MX8MP clock driver");
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index 83cc2b1c3294..33897b56130d 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -632,6 +632,8 @@ static struct platform_driver imx8mq_clk_driver = {
>  	},
>  };
>  module_platform_driver(imx8mq_clk_driver);
> +module_param(mcore_booted, bool, S_IRUGO);
> +MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
>
>  MODULE_AUTHOR("Abel Vesa <abel.vesa@nxp.com>");
>  MODULE_DESCRIPTION("NXP i.MX8MQ clock driver");
> diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> index 7cc669934253..4bd6ad060eea 100644
> --- a/drivers/clk/imx/clk.c
> +++ b/drivers/clk/imx/clk.c
> @@ -17,6 +17,9 @@
>  DEFINE_SPINLOCK(imx_ccm_lock);
>  EXPORT_SYMBOL_GPL(imx_ccm_lock);
>
> +bool mcore_booted;
> +EXPORT_SYMBOL_GPL(mcore_booted);
> +
>  void imx_unregister_clocks(struct clk *clks[], unsigned int count)
>  {
>  	unsigned int i;
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index a7cbbcd1a3f4..5061a06468df 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -7,6 +7,7 @@
>  #include <linux/clk-provider.h>
>
>  extern spinlock_t imx_ccm_lock;
> +extern bool mcore_booted;
>
>  void imx_check_clocks(struct clk *clks[], unsigned int count);
>  void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
> --
> 2.25.1
>
