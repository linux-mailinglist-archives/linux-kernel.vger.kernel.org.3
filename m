Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0CE4C6C42
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbiB1MYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbiB1MXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:23:55 -0500
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00062.outbound.protection.outlook.com [40.107.0.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5E974878;
        Mon, 28 Feb 2022 04:23:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFq2hFf3qW0EflDKkjRFnns7nMgr+Bdi/ahPd4yEzVTyAM04plgX0D7WOeioOiDKHZhpNp8/FT9m4uKVXPj2DmGWRfETLEJhvv+DEzhWFgcm9JdzpyDNChpSsFrMRRRcK7pSo6BIN2925DHHMqfJxitn0gXyRuaUxud7EprKL9Z5DlWaoEMqdl0y79UMV07r42iDZCEyIilo13yc8LSMExboeO9DzH+2el6SCjT1/++XIknKmGpCqCVBSDRmgs18h89xblartMLPgJ2jJZcHIwKSVVecWjTyU0EDItnJiGZppTwXr9KCSf6GQzzOCRGpxcH8izZ7T2QPGhzpRr5fIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/si2X4naviL9qENeV1Injs75vYSBIt2u0E9g4nhO1U=;
 b=L6u1P6u17Hg3S6S2/EDf1khBx76YYLrqHJ87pWvpOcjIEVQtoC4DVotB8VKE4HK4OLXnjWDP7cC+sKohPWz6uIyropti45rZ3o1G2N9hqEt2XcC9a02iRDhBQLa1/tI3nMYB9xR9uo/b0MsH27/FTPoVCTEhENRrTliR3SXef/yaeLp50vEHkuSOGL1QZAYkLBDjAieWhZnp28CwrjLL6RnauRMdk+5xReF1bLKlzhBdfxNfLKUxNcMVtAQVzp7hBd4+hvBa3+92f7XFlOTAG7t6Znv1aiQG7eMhz0hgZXYSZHxDrYPBP6Q1n7fA+ngA/upSKYg5nRNquAU70fgZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/si2X4naviL9qENeV1Injs75vYSBIt2u0E9g4nhO1U=;
 b=n8ESO7OXDZP9I5aYl4Iu1TWDO9kvcWl2h3MUtX4OVwRSiDyb8fCJQqRynUQJUHEjZTjewF5uMcnY8qsffbgGtJ8nC2kPF+SiQMIvniAOuE3ec60BArzYWeK0yx0TOiUc7YZARGsUqZqe/Ufp4njE0yKvL5ggN3hTqs9krmj1bus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB7152.eurprd04.prod.outlook.com (2603:10a6:800:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 12:23:08 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 12:23:08 +0000
Date:   Mon, 28 Feb 2022 14:23:05 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] clk: imx8mp: remove SYS PLL 1/2 clock gates
Message-ID: <Yhy+qXnmo7gfGltn@abelvesa>
References: <20220225081733.2294166-1-peng.fan@oss.nxp.com>
 <20220225081733.2294166-4-peng.fan@oss.nxp.com>
 <YhjpIbIVf7DQh/Ja@abelvesa>
 <DU0PR04MB9417D1BF8C068E5636C60F9E88019@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417D1BF8C068E5636C60F9E88019@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR0602CA0016.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::26) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0c7f900-9930-489e-3b4b-08d9fab513d0
X-MS-TrafficTypeDiagnostic: VI1PR04MB7152:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB7152FE38B6E72C0A21002BBCF6019@VI1PR04MB7152.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cr4cme2wrB1AxOja1x/mAYBt/m1pnJAk8nTn6A1Fu/Lc3ce3Tu2Jc8qWKDW/aOzcMCdgKLM8Jw31pTMoIMm8ps+ymiR82cw5d/jBNegW95FbgCVnFT++kIm+fLK0QYamzACvjSakPvEsX+tm/Z4vf+EaTbGZh4l/6xbjpGaDNTnjELsetJCvtQOKBpTMsxZb1jZAGeZU76r594oAtT3jaBGsGHf5d/kFj+701orVwXjFwaWCArzPRtB12Fkxa3V9eEn75ojFwxS9HGTA+W5B40Txz41Q6Z7E9mmH3tLSPAVDOTgEp1eb5KybR3G+0ttT5dBXx5jbisXYUfUT/h6A/aSq9cH1B3PQK1C4PoEVnEiqsazkGYBdhtnb19a5NRbEq7GAMB0vKZzwUzfKXfhKN0jd2fcHm8Y65De8cU9gOseNFiB3AltfXJ9ckVA8I9Sc7+Cp8NdKg00AgUAot40J93KhKRgoHPBPo4VuNTcbtU5B7VZ+vyYd0G0D3Ri75LR2rBLESQmLRUt2i61bNH8Pdgy/JmhqT/L2EuS+RuwNTxLtq97CjELAamSH+HS1BX3JOtD9VhKgsL6v8JxJYMOrWtLNiDWQ6m0w394LwC4sGMqrEsxlw4CR1kT0ZJwsxPTaaw2uOhz67bxvqeDfN+byMHRugfiO8KenZUlY4Ro/7GrdfdoQxkDVGyWK24r6UeS+Or3h2TCnfuv+YPUS0nmZvfss/eSTUFmzYnkrVcMusy2PBY4ggKQjdLgaIw/GpyvM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(508600001)(6636002)(316002)(6666004)(38100700002)(8936002)(53546011)(6506007)(6512007)(9686003)(38350700002)(83380400001)(52116002)(86362001)(186003)(26005)(2906002)(5660300002)(6486002)(44832011)(7416002)(66476007)(66946007)(33716001)(66556008)(54906003)(6862004)(4326008)(8676002)(32563001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HJXS9PMj5sJjnNFv9C+6KG+PLwO4AmnOzJFNhqbNo6DQmIH4i/LxDAhwp6za?=
 =?us-ascii?Q?h6GGnhdMwoqJT90JBQ1VhMxI2M6+MQpe/9yOpwCboB+++6p6HvX4cnBUBY+8?=
 =?us-ascii?Q?hh3RaquvEZEsuFwndZ5jtogoETIrOOGrXZjf2FGnxYDX9+o9DLlzg3ta41Kp?=
 =?us-ascii?Q?qtGyLhmzDTVR2ibmPf689OtfPDXWK686yMGs/XFHsKIwqy7LaO3mM5sTQNhf?=
 =?us-ascii?Q?7Nh1ais28AqTL8P3uvmDK1WuWoPWoZXYhbW7ZCS2ZKjNKNZjkHnpMYJ3e+th?=
 =?us-ascii?Q?GUJivMXIUo3R43nncsE1+kpoJHJsmHed/sgLMmaK4hdI+KExSr+RLWWTzA7j?=
 =?us-ascii?Q?1hpyklb4VJSG9pQfEZgLnZ98Kl1fECS/KwiDtn5ixkChshjYvMBAdEI4Fl/7?=
 =?us-ascii?Q?s6p3bVB+Orb9osO341uMBDhWJpMCMTF/Ya8zoQ18Op5PEJEBpglsvBySt79Q?=
 =?us-ascii?Q?5meP9Go/Hxz0B5DMNMrrDG3nHCZ76wBnjLbGt3q6Ad+98XzUdTA8B5aYyje7?=
 =?us-ascii?Q?Z9eMF0yPo2K/PGIbrSb9NIWqJCzi26CrEQ66Slc+KLmqzSz7YJehnt1eK/tF?=
 =?us-ascii?Q?tv6fQyLXZBrSkKxfF9eV+cMyfLddBPS/GaVQooIi6NpO/U8ju9xU3FY1VsSD?=
 =?us-ascii?Q?1DC+Ibh4SFaOugmmnZVnVYUgD/CFRqwVumkkaD9yUxBIWJPUcIqvUsAmnmIB?=
 =?us-ascii?Q?7/NnIXXthFuZcdfPgpG2ps87pTIG/DLQEYyrfLfZy4jn4b5qfySqIgrb2oF2?=
 =?us-ascii?Q?lpeTgqPK55b8SEW64OWcv0ogQLGN3po8m0sshyaCbPYXYfCQrv0o7g9VFDZG?=
 =?us-ascii?Q?kWdCLEfPzFXQFNvJIn6alN4LYE2R7ptjeh7wdxtaxVxUxhOXjmEcDFWBy3Pb?=
 =?us-ascii?Q?ltULdXwZROgyh5Qm9SEObJw2KhqXX3JecLw7Oy0Yws5b4So53bjGxB00YI9o?=
 =?us-ascii?Q?x+oFBcrdP4C55WdE3U8aLm3kgJ+C4yoa+t6RKRw7J6J0vjNXDYmzglZ29JYM?=
 =?us-ascii?Q?KIw1BooUR3lGZwncNFyO9N7wvj79M4+SKVknxxd8292loIogl6aajsyp1bfG?=
 =?us-ascii?Q?ns4jxzMq+nD/RpQT7hwsioXNlAForsLDj5GQxlEP7KAEocLT2WRLnEwwIWdZ?=
 =?us-ascii?Q?n/8DGp+r9eqPo4xt1NaStqRfa2wae8QxjtkrUhjh3ucAYKzmVk46vTJmFyJz?=
 =?us-ascii?Q?1ijGB5z2LLpH0OoSphDB87rMURuI2Hh0Og8w4kHt7W7xY7nl+63DpCQGC0l+?=
 =?us-ascii?Q?ZZxXNgwctT3mIqrF5wcvVuyMxKDDUR5+E9wCgymsPhlewfr9GW0inzVbHs6Q?=
 =?us-ascii?Q?QJpzg681FpOApOKDvnFRToh14OcY+upg5sj7b916kRIh0MiGEJ837/pOB7tr?=
 =?us-ascii?Q?TGu4paHEv9hPlr2/S6Q9ikgGVQKd04H1B7hQcZGBuPUqYHEOh1QG7xe1brL2?=
 =?us-ascii?Q?PB//+pUcB83KiuNmo1ZN4JTHRKuYfEp8qHGHVuKcJgDiXw/taf3oVypCI07J?=
 =?us-ascii?Q?scWzRamdMX6BCtlLlr0lBg5t0sHpY3i36CdvImokSxWAgIpzEMxoDiXvxZKA?=
 =?us-ascii?Q?JZDj4ua3DZjl8eAmZf+t+ZlYFkvtLfCUQRGDNovS0cyZFideoxAeb0QakuHC?=
 =?us-ascii?Q?ru8pnPTdxxXy2PW4muMvoUE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c7f900-9930-489e-3b4b-08d9fab513d0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 12:23:08.0886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7X77D0c9DwmWqTmhXw5btnjTn1DrVqnLKY+JN6LKAyrUD63WeVC6cqjyIhcZfPNPsu8Xurnb1EQdCD/pVNyoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-28 02:39:45, Peng Fan wrote:
> Hi Abel,
> 
> > Subject: Re: [PATCH 3/3] clk: imx8mp: remove SYS PLL 1/2 clock gates
> > 
> > On 22-02-25 16:17:33, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Remove the PLL 1/2 gates as it make AMP clock management harder
> > > without obvious benifit.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/clk/imx/clk-imx8mp.c | 48
> > > ++++++++++++------------------------
> > >  1 file changed, 16 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/drivers/clk/imx/clk-imx8mp.c
> > > b/drivers/clk/imx/clk-imx8mp.c index f23b92906d3b..18f5b7c3ca9d
> > 100644
> > > --- a/drivers/clk/imx/clk-imx8mp.c
> > > +++ b/drivers/clk/imx/clk-imx8mp.c
> > > @@ -480,44 +480,28 @@ static int imx8mp_clocks_probe(struct
> > platform_device *pdev)
> > >  	hws[IMX8MP_ARM_PLL_OUT] = imx_clk_hw_gate("arm_pll_out",
> > "arm_pll_bypass", anatop_base + 0x84, 11);
> > >  	hws[IMX8MP_SYS_PLL3_OUT] = imx_clk_hw_gate("sys_pll3_out",
> > > "sys_pll3_bypass", anatop_base + 0x114, 11);
> > >
> > > -	hws[IMX8MP_SYS_PLL1_40M_CG] =
> > imx_clk_hw_gate("sys_pll1_40m_cg", "sys_pll1_bypass", anatop_base + 0x94,
> > 27);
> > 
> > Hmm, isn't there a chance that u-boot might gate these? Then, in kernel you
> > won't have a way to ungate them, leaving the consumers hanging.
> 
> Both NXP and Upstream U-Boot not touch these bits. With the CG managed
> by Linux, it is hard to support AMP. This is same to Lucas's patch to
> clk-imx8mq.c to drop the gate.
> 
> The other method to support AMP well, is to add the CGs clk in device tree node
> for Mcore. But we still need a method to support M core booted in U-Boot, and
> linux may gate off the clock.
> 

OK, thanks for clarifying that. Makes sense now.

> Thanks,
> Peng.
> 
> > 
> > > -	hws[IMX8MP_SYS_PLL1_80M_CG] =
> > imx_clk_hw_gate("sys_pll1_80m_cg", "sys_pll1_bypass", anatop_base + 0x94,
> > 25);
> > > -	hws[IMX8MP_SYS_PLL1_100M_CG] =
> > imx_clk_hw_gate("sys_pll1_100m_cg", "sys_pll1_bypass", anatop_base +
> > 0x94, 23);
> > > -	hws[IMX8MP_SYS_PLL1_133M_CG] =
> > imx_clk_hw_gate("sys_pll1_133m_cg", "sys_pll1_bypass", anatop_base +
> > 0x94, 21);
> > > -	hws[IMX8MP_SYS_PLL1_160M_CG] =
> > imx_clk_hw_gate("sys_pll1_160m_cg", "sys_pll1_bypass", anatop_base +
> > 0x94, 19);
> > > -	hws[IMX8MP_SYS_PLL1_200M_CG] =
> > imx_clk_hw_gate("sys_pll1_200m_cg", "sys_pll1_bypass", anatop_base +
> > 0x94, 17);
> > > -	hws[IMX8MP_SYS_PLL1_266M_CG] =
> > imx_clk_hw_gate("sys_pll1_266m_cg", "sys_pll1_bypass", anatop_base +
> > 0x94, 15);
> > > -	hws[IMX8MP_SYS_PLL1_400M_CG] =
> > imx_clk_hw_gate("sys_pll1_400m_cg", "sys_pll1_bypass", anatop_base +
> > 0x94, 13);
> > >  	hws[IMX8MP_SYS_PLL1_OUT] = imx_clk_hw_gate("sys_pll1_out",
> > > "sys_pll1_bypass", anatop_base + 0x94, 11);
> > >
> > > -	hws[IMX8MP_SYS_PLL1_40M] =
> > imx_clk_hw_fixed_factor("sys_pll1_40m", "sys_pll1_40m_cg", 1, 20);
> > > -	hws[IMX8MP_SYS_PLL1_80M] =
> > imx_clk_hw_fixed_factor("sys_pll1_80m", "sys_pll1_80m_cg", 1, 10);
> > > -	hws[IMX8MP_SYS_PLL1_100M] =
> > imx_clk_hw_fixed_factor("sys_pll1_100m", "sys_pll1_100m_cg", 1, 8);
> > > -	hws[IMX8MP_SYS_PLL1_133M] =
> > imx_clk_hw_fixed_factor("sys_pll1_133m", "sys_pll1_133m_cg", 1, 6);
> > > -	hws[IMX8MP_SYS_PLL1_160M] =
> > imx_clk_hw_fixed_factor("sys_pll1_160m", "sys_pll1_160m_cg", 1, 5);
> > > -	hws[IMX8MP_SYS_PLL1_200M] =
> > imx_clk_hw_fixed_factor("sys_pll1_200m", "sys_pll1_200m_cg", 1, 4);
> > > -	hws[IMX8MP_SYS_PLL1_266M] =
> > imx_clk_hw_fixed_factor("sys_pll1_266m", "sys_pll1_266m_cg", 1, 3);
> > > -	hws[IMX8MP_SYS_PLL1_400M] =
> > imx_clk_hw_fixed_factor("sys_pll1_400m", "sys_pll1_400m_cg", 1, 2);
> > > +	hws[IMX8MP_SYS_PLL1_40M] =
> > imx_clk_hw_fixed_factor("sys_pll1_40m", "sys_pll1_out", 1, 20);
> > > +	hws[IMX8MP_SYS_PLL1_80M] =
> > imx_clk_hw_fixed_factor("sys_pll1_80m", "sys_pll1_out", 1, 10);
> > > +	hws[IMX8MP_SYS_PLL1_100M] =
> > imx_clk_hw_fixed_factor("sys_pll1_100m", "sys_pll1_out", 1, 8);
> > > +	hws[IMX8MP_SYS_PLL1_133M] =
> > imx_clk_hw_fixed_factor("sys_pll1_133m", "sys_pll1_out", 1, 6);
> > > +	hws[IMX8MP_SYS_PLL1_160M] =
> > imx_clk_hw_fixed_factor("sys_pll1_160m", "sys_pll1_out", 1, 5);
> > > +	hws[IMX8MP_SYS_PLL1_200M] =
> > imx_clk_hw_fixed_factor("sys_pll1_200m", "sys_pll1_out", 1, 4);
> > > +	hws[IMX8MP_SYS_PLL1_266M] =
> > imx_clk_hw_fixed_factor("sys_pll1_266m", "sys_pll1_out", 1, 3);
> > > +	hws[IMX8MP_SYS_PLL1_400M] =
> > imx_clk_hw_fixed_factor("sys_pll1_400m",
> > > +"sys_pll1_out", 1, 2);
> > >  	hws[IMX8MP_SYS_PLL1_800M] =
> > imx_clk_hw_fixed_factor("sys_pll1_800m",
> > > "sys_pll1_out", 1, 1);
> > >
> > > -	hws[IMX8MP_SYS_PLL2_50M_CG] =
> > imx_clk_hw_gate("sys_pll2_50m_cg", "sys_pll2_bypass", anatop_base +
> > 0x104, 27);
> > > -	hws[IMX8MP_SYS_PLL2_100M_CG] =
> > imx_clk_hw_gate("sys_pll2_100m_cg", "sys_pll2_bypass", anatop_base +
> > 0x104, 25);
> > > -	hws[IMX8MP_SYS_PLL2_125M_CG] =
> > imx_clk_hw_gate("sys_pll2_125m_cg", "sys_pll2_bypass", anatop_base +
> > 0x104, 23);
> > > -	hws[IMX8MP_SYS_PLL2_166M_CG] =
> > imx_clk_hw_gate("sys_pll2_166m_cg", "sys_pll2_bypass", anatop_base +
> > 0x104, 21);
> > > -	hws[IMX8MP_SYS_PLL2_200M_CG] =
> > imx_clk_hw_gate("sys_pll2_200m_cg", "sys_pll2_bypass", anatop_base +
> > 0x104, 19);
> > > -	hws[IMX8MP_SYS_PLL2_250M_CG] =
> > imx_clk_hw_gate("sys_pll2_250m_cg", "sys_pll2_bypass", anatop_base +
> > 0x104, 17);
> > > -	hws[IMX8MP_SYS_PLL2_333M_CG] =
> > imx_clk_hw_gate("sys_pll2_333m_cg", "sys_pll2_bypass", anatop_base +
> > 0x104, 15);
> > > -	hws[IMX8MP_SYS_PLL2_500M_CG] =
> > imx_clk_hw_gate("sys_pll2_500m_cg", "sys_pll2_bypass", anatop_base +
> > 0x104, 13);
> > >  	hws[IMX8MP_SYS_PLL2_OUT] = imx_clk_hw_gate("sys_pll2_out",
> > > "sys_pll2_bypass", anatop_base + 0x104, 11);
> > >
> > > -	hws[IMX8MP_SYS_PLL2_50M] =
> > imx_clk_hw_fixed_factor("sys_pll2_50m", "sys_pll2_50m_cg", 1, 20);
> > > -	hws[IMX8MP_SYS_PLL2_100M] =
> > imx_clk_hw_fixed_factor("sys_pll2_100m", "sys_pll2_100m_cg", 1, 10);
> > > -	hws[IMX8MP_SYS_PLL2_125M] =
> > imx_clk_hw_fixed_factor("sys_pll2_125m", "sys_pll2_125m_cg", 1, 8);
> > > -	hws[IMX8MP_SYS_PLL2_166M] =
> > imx_clk_hw_fixed_factor("sys_pll2_166m", "sys_pll2_166m_cg", 1, 6);
> > > -	hws[IMX8MP_SYS_PLL2_200M] =
> > imx_clk_hw_fixed_factor("sys_pll2_200m", "sys_pll2_200m_cg", 1, 5);
> > > -	hws[IMX8MP_SYS_PLL2_250M] =
> > imx_clk_hw_fixed_factor("sys_pll2_250m", "sys_pll2_250m_cg", 1, 4);
> > > -	hws[IMX8MP_SYS_PLL2_333M] =
> > imx_clk_hw_fixed_factor("sys_pll2_333m", "sys_pll2_333m_cg", 1, 3);
> > > -	hws[IMX8MP_SYS_PLL2_500M] =
> > imx_clk_hw_fixed_factor("sys_pll2_500m", "sys_pll2_500m_cg", 1, 2);
> > > +	hws[IMX8MP_SYS_PLL2_50M] =
> > imx_clk_hw_fixed_factor("sys_pll2_50m", "sys_pll2_out", 1, 20);
> > > +	hws[IMX8MP_SYS_PLL2_100M] =
> > imx_clk_hw_fixed_factor("sys_pll2_100m", "sys_pll2_out", 1, 10);
> > > +	hws[IMX8MP_SYS_PLL2_125M] =
> > imx_clk_hw_fixed_factor("sys_pll2_125m", "sys_pll2_out", 1, 8);
> > > +	hws[IMX8MP_SYS_PLL2_166M] =
> > imx_clk_hw_fixed_factor("sys_pll2_166m", "sys_pll2_out", 1, 6);
> > > +	hws[IMX8MP_SYS_PLL2_200M] =
> > imx_clk_hw_fixed_factor("sys_pll2_200m", "sys_pll2_out", 1, 5);
> > > +	hws[IMX8MP_SYS_PLL2_250M] =
> > imx_clk_hw_fixed_factor("sys_pll2_250m", "sys_pll2_out", 1, 4);
> > > +	hws[IMX8MP_SYS_PLL2_333M] =
> > imx_clk_hw_fixed_factor("sys_pll2_333m", "sys_pll2_out", 1, 3);
> > > +	hws[IMX8MP_SYS_PLL2_500M] =
> > imx_clk_hw_fixed_factor("sys_pll2_500m",
> > > +"sys_pll2_out", 1, 2);
> > >  	hws[IMX8MP_SYS_PLL2_1000M] =
> > > imx_clk_hw_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1);
> > >
> > >  	hws[IMX8MP_CLK_A53_DIV] =
> > imx8m_clk_hw_composite_core("arm_a53_div",
> > > imx8mp_a53_sels, ccm_base + 0x8000);
> > > --
> > > 2.25.1
> > >
