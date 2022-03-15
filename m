Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531164DA45D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351237AbiCOVNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351886AbiCOVMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:12:53 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130071.outbound.protection.outlook.com [40.107.13.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D21156434;
        Tue, 15 Mar 2022 14:11:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjQ+ylLhFuu5h96x/ggKtZj4j5aTjdn8+MxSakSRePleH8ZpQ0MwTGPSlXYuBMpNgm3M+5KYxiiUALow59GeAa49aNf4ZbBUhgq3jDuNXBEsPxXcLhFYE2hiHmEYHPCm3+UPKqrzHPrcW/hwRh/IICW3NU/uvz41z8ylKvEq1wIJyw0nNwcRhNv3GaC8OTdTTv99FrC7e5cn/WN4+rbnS6Vz5aDVF5ho3WjtCGNNSI7jlmEzEh3L35Du63e9493awB46EtJVICF8UjwREwAD0sOsoG6+hvTbL/XComOJLB00Xvx9YiNGUlfDwN841clqJtIxKC0/bTdSNcYnH0tBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dvzsrdj6/2rQymmUdz0yP6aom1r30dmelDOxYts2feM=;
 b=PeWNUXAVUAl6/CjXPBKom+R/LvutscgIZz6+KDnfPiiGlQCn2OCXfAPjeiFFWrF/Xukzj5TAUNvTpKKXrX6N9Y9DqH0U5Y+xmHk0MOqrjb1FyMxrLJ0mzO/D8+ssNsJYG4DQa4nHZM5Q913mkdQ6JaeFO1EWdtoXoci58Rlpareo9ieEpECynej9sYpgRtSvX6rzvKxoS+4873yAg3CxlvZgpMcT8gDj0Cf21XE+SAWc/3+WSRgeMJIyNufJQLDfS9RGQqBLf7fKkOxQ1ERMXPOL/shAMBisUByZj/haRb3DyeE+GZZtZ9b656tTcHCmFZGo/7tcuKZD4z+bPclnSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dvzsrdj6/2rQymmUdz0yP6aom1r30dmelDOxYts2feM=;
 b=nyjn+h8f3L9rf5Hq2JrurVvfeAK++JVsnDrI7agiFKCNPVkKgQ1hno0f/x1iWd97EYxsRzMUjcrW+7bJhHKNau7Ps4rf2vtRa7Cnvw+AUSAG9M6mCS/195v9F7Gp8Njy37caUDH4cFvmiyQGGNAaZkhpXb8VJ+qAUQUyNMUihuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.29; Tue, 15 Mar
 2022 21:11:37 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::786c:4be5:dd16:f773]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::786c:4be5:dd16:f773%3]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 21:11:37 +0000
Date:   Tue, 15 Mar 2022 23:11:35 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] clk: imx: Select MXC_CLK for i.MX93 clock driver
Message-ID: <YjEBB9EdC09bQ62M@abelvesa>
References: <20220315082446.3120850-1-abel.vesa@nxp.com>
 <DU0PR04MB94178847ACC8BC6E5D1ADBDF88109@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB94178847ACC8BC6E5D1ADBDF88109@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR07CA0197.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::21) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd27dfb1-82e0-4a08-1fe0-08da06c8644a
X-MS-TrafficTypeDiagnostic: PR3PR04MB7228:EE_
X-Microsoft-Antispam-PRVS: <PR3PR04MB7228F384A258635058EF311AF6109@PR3PR04MB7228.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ie6cZNWVct3PtJsR219Z1jp2RMYUqXAnatXnFvrj42RkIrHnPeRjjfCT+2u6Uo8SdxCp+OmLPYgs0DUcsoV6NnS5S+1jkmyvnAsCWidGJkFb76BaN/DH20oAuUWTebx6vgslD/S2NtnX1KJ/1g6I5AKefBj6An1JBcBpJPRduyYy1v6J7Eh8AdhF2B4iXyDssfhouSyEE/p+rhQldhiS8dKrtw+1o9EAPmpDzha3iU9t1HeHmPtw7roPFFuiOHCWT3y3dezF9Ni2GdPe/B6eODP/9HdsS/u2a0Ebeq1GNt2Vgz/Xr1zib7c+tVQ//EJB1r71qdAQFjhAkUgLcPghhSnJGB5lJtBtwpWC+W4n8Zv5BOwhPhCkraFwqfZZ4c/gX1rcALriSwBAZPstLFXMOr5zANug5NKNgODuVcu9MFdqO02l8U0ZYvzMOtLlyvqjcX7y41FyX3Toa60N+K4w+2Jl9GHNO7xalmSke/qjay57WS4bN7jU/lDMBN9fpwXjDszVUffnrar+JiMiqeqbHLUbHnOcz0H2M2GTGcysKzRjRfSoZzD4V0YhBzFFwZU7pYETIHo3rtxqJXCF0Fr4PgTwY6HczSKeCLfIkp9OQ5OG5t3nluTJALrWSnk9cf4BOc24Kaw4Xh0pN6ISGMh6vWjEGIhkLjcalwJKExRDWStuaZw9JgeyLt3tPOWER0dLoZWk0jPT0APIBGgbpCczYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(8936002)(44832011)(86362001)(5660300002)(38350700002)(38100700002)(186003)(26005)(33716001)(83380400001)(6506007)(6512007)(9686003)(53546011)(52116002)(6486002)(508600001)(66476007)(66556008)(66946007)(8676002)(4326008)(6862004)(54906003)(316002)(6636002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jgBr896xh62LTDEFFkJOuHrAr5CrlVJ3NXfoFHG5NXQOXXhGcWZqoVzVmUDQ?=
 =?us-ascii?Q?jn8nn4xDYxL9lqsh5GygZUVsEpNKvEkLeyrMdB6oAT88fBn6QZdm7pUGEJrO?=
 =?us-ascii?Q?2TZqb6Sd1LAFCh9TB7rzdMniP6tFflWWccMD/7jXhGbOcpqO6uPzeuaeslFY?=
 =?us-ascii?Q?4o6av5jUvGwAAO0lXZg+3Svuhowv+fpZqzB9bUL5bzaFNqImr1MG31ysG+WS?=
 =?us-ascii?Q?JnrCtHOQQ9+KSNxq6+aawZsdqDvVTW3X3SkTKFGBaLmidXpcO3x0eczRzfef?=
 =?us-ascii?Q?lhgfduVuS3lZsFoU2471EOtP2iS+T1iPpbab5sxZDqpWBG2MUEDw+nKBR17C?=
 =?us-ascii?Q?sdZsLg2x3FEdIOt4ZIMQg0WxOl2tZJpIJyb/n8OmVtkpyRSs/Y8R2FUk7PER?=
 =?us-ascii?Q?8aSHGfjeAxYo1GoO3KccQo2YJJmLvhtR8Q5LIkPIwcHHeI5Fvr9+4N+JZC/Z?=
 =?us-ascii?Q?G2hlJpYszR+EOC2dcUqZd2nxzDVP93AP1/cF3X3QdsPS58oifXvJ3GJgZWmJ?=
 =?us-ascii?Q?XtvmkT5i7QKlKiJV2uoc0Z8stGkoWeacUIHO0cipGYZLwgMlGxmt/bUUDZ+t?=
 =?us-ascii?Q?r8oathrwG2/MJ9MQ9aF/nPSHgPpxG48FhlGEvIdaC13s+KniodJYv32LMZg6?=
 =?us-ascii?Q?vI5x1TjY3/PzQzvtcUPVr2LTNwrnENVpLNmP5kYhgD4DIrJontE0g+6jtnfG?=
 =?us-ascii?Q?0dOfCFPgItFgsYYFsFIhpacjeRlzsc9RE8/tCb3oQfrgCUUnHiAN7ejCAO5F?=
 =?us-ascii?Q?NNdTiV2an2hcA3+ZLvGMSlruK6OtRNkbhuno4WTHgNzGRoAcGayfuakKCQQP?=
 =?us-ascii?Q?rCLYzzA0FAYJGUAYPA36nl9GE+vDOVxwojFbS/uTMg/ZLSaFkd8timHHN6BY?=
 =?us-ascii?Q?CQ49r8QYwdN07rV3TlB8WW2yVSedHBobsSwtOGkBdj6nm+HchSTmkXq0P6RL?=
 =?us-ascii?Q?ZVCHYyHqDPRdoWeIewu7bnviKDg++2n2xaWmGx/aWf5ftGecQae+FpdM/e3J?=
 =?us-ascii?Q?YQcVg4YikPVfzgwg1Qz/OEaEtvGEWJ8eC90dLWV0Ybo76zZjGcHJarGIinQI?=
 =?us-ascii?Q?talFsibEJ7Ud6XsCCs1zZdKH48X/UZ/paVv++FcL/R1J6q4j+9ht/e8HfDhR?=
 =?us-ascii?Q?npo1sO4Y+so0AunG3WazgkOX2WdWXmND37Q79D9DmyBOiVSMfkMp/5s27s9k?=
 =?us-ascii?Q?wgJ2uAeLNf0uE12R3M9S2KGHXLHB+bj5bzA0AZiiVZyvfCd+FzfL2fr/d28W?=
 =?us-ascii?Q?8iSLxw6p1Pos3ZrYjLVHll8cZc1wKP8rv96KDVSgPWXpKbe8BH1eg+iJ1T3k?=
 =?us-ascii?Q?vv/f/EYnpNkDZiXijvmY1OTtC2Tj/hZPDY7outNMXPjzbE05Pf6P8OgAQtqj?=
 =?us-ascii?Q?PaSaUhSXsjzc03iBvE5cUzYrGGEKeIIEBtZWlhhPySpUCX9PtVHNVa9J63Kv?=
 =?us-ascii?Q?Bfuzit5WjesDHDZG4Lk95w4Nrrzb5nrq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd27dfb1-82e0-4a08-1fe0-08da06c8644a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 21:11:37.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oplHhWuNDocQGMS7Y4qCjeUWF8A1UObmPz6nwK9OTanxks04oYhBMaEDfw64dGsIYHlNyP0IbnixaAjCsLAFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7228
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-03-15 10:26:43, Peng Fan wrote:
> > Subject: [PATCH] clk: imx: Select MXC_CLK for i.MX93 clock driver
> > 
> > Most of the i.MX clock generic API is built by selecting MXC_CLK.
> > Without it, the i.MX93 clock driver will fail to build:
> > 
> > aarch64-linux-gnu-ld: drivers/clk/imx/clk-imx93.o:
> > in function `imx93_clocks_probe': clk-imx93.c:(.text+0xa8):
> > undefined reference to `imx_obtain_fixed_clk_hw'
> > 
> > So fix this by selecting MXC_CLK for the CLK_IMX93.
> > 
> > Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Thanks, Peng.

Stephen, can you please pick this up?

> 
> > ---
> >  drivers/clk/imx/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig index
> > cc464a42d646..25785ec9c276 100644
> > --- a/drivers/clk/imx/Kconfig
> > +++ b/drivers/clk/imx/Kconfig
> > @@ -109,6 +109,7 @@ config CLK_IMX8ULP
> >  config CLK_IMX93
> >  	tristate "IMX93 CCM Clock Driver"
> >  	depends on ARCH_MXC || COMPILE_TEST
> > +	select MXC_CLK
> >  	help
> >  	    Build the driver for i.MX93 CCM Clock Driver
> > 
> > --
> > 2.34.1
>
