Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9409529CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiEQIn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243631AbiEQInF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:43:05 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC4343EE8;
        Tue, 17 May 2022 01:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8SJm9XZ/CEZAqLUoBYpLD+nFR71PzWOAWEUiRL1O0vOdha/ApQqd1nxH2CagALVpM4pfGt/0LioSNvDX2KJY0RIFW0+hkob5LcVA1lLbwa8lyJxeMbJ9T9aDNWdgi+huCMIzuNirTfsUvnXZ6KBSv+Pvbok6jEB++lzFG6bWEnmTCNdozwddDp83CKWxdSPFOVhmUlBKGmWptbM0VrwBmDC3dIaHe+6nIGGsjNUSDcSrpHqVJXsV/4kBmazymfxxV6ps58cEP562r86zYmLEtxTzXfIEF8ncDKORjMtYUTAqGMqR4p+OPkQykaIhXApKpc+TMVumnYXI7/jORPAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLdl1QtXNdk826eXHFZ9Ps0BSCp2qwXg3yx0RuEfPb0=;
 b=VrABH6fPYXz9uyAwC6pSNWNJoZTWjTf6jT0le0aIKx7eOUoczTz8X0V3K0TuI2Bui85D4+c5neqcAlhAyMEh3+VylAOjlRSTb1kyjB+xMWLp+TEudA5Co/oVXzyPuhGOiSZ4udMy4ipPtOcfLL9hAB+e6noyZtc5yJb7v+QPEGMNzZ/oZoGXof4+BsKBoRKCDvy0fwwQmLYjUxVNGjlJEKy7/9JtXMg49Vag25y5T0UVRUiSQ6FnmTQBpNWnj7/vqgFrjsXA6mT4Z3yQs+7EOZcqUn01OxaaPVeYGlLvlePmeVRvQ7zM+TiCXFcDvDgUjgB2h1rSrouJHR6WdYchUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLdl1QtXNdk826eXHFZ9Ps0BSCp2qwXg3yx0RuEfPb0=;
 b=QAKj3CTQEevJ5YTxBeSQi2HniikTiWMzxobYQWo1AJWEUha114Jasc7tK/AwEyE/fdpSrvR+Wr6hMtUisIFXotX5u1agD/xHAGfTRJp79vI1H3PwiXJsNtcWCwDda9aDa74g11+gQO2FU202512FGwWJsoocqcbpMu5nBa0h2Qs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DB7PR04MB4186.eurprd04.prod.outlook.com (2603:10a6:5:22::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 08:42:58 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::9060:4119:5466:f5d]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::9060:4119:5466:f5d%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 08:42:58 +0000
Date:   Tue, 17 May 2022 11:42:56 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] clk: imx8mp: fix usb_root_clk parent
Message-ID: <YoNgEMgEUQ99Z+T1@abelvesa>
References: <20220507125430.793287-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507125430.793287-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: AS9PR04CA0080.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b::28) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80f16a29-2da0-43fd-c319-08da37e13ea3
X-MS-TrafficTypeDiagnostic: DB7PR04MB4186:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4186097C6EA2E790B222B9E2F6CE9@DB7PR04MB4186.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4Bo7pWBUXFdMpdlUBHC4TwssrrI9sO6KN52Wx8W311mtn0tcWRQF47NYbWuN0Xn4xgjwrGfbtIJ+8XHxshmOwr0C0Cg6EGpzXL84D8v48UrewMZYWl2TFLynjsRWyD2BPSfc6pgbenFYdT0pi8UE6SRdGHng6bBMu9Q0PE0z1w8bxiDyrUinf4aRz7XvQbyiCJNoqYPqrX/Na67D/8ZEd90qAWyxNpXlMf1ZOn3uslC7zzBTdcyJl8DCGTfzOXPZQFAk6oLFYnhMG+jtPKrZcuUTSTkf9jJAyRJ4pCIyLd/VhI4sveNHbvTg3HwTzCeYBcU5gFb06FfGjBpmHwpg6xdx+cpVgqn0UlXflo+PZBHM/4FVY0au6ZHyPnEVDb+10aSHPv8fmNJBOhOIMPJOUOhFS08WOi32nuuiKACj0hPmt5u0DEKhOKbQgap7QyPmN4YryNZMUAVbT+ZMyd4Xv9h2QOdLpn8vUPnoaJ0TMtwQEN3hwe0bSB3buo6hs5WlYJf8Qh6v2f3qmm3aVl3c6DsE4m/dFSu1NM+hBaxB9g70ED0b85r9I14NxDV2UZUOmFjmp4ZTLbPjTFqD5Gc6zKOZxgIePxJJ9Dqd35PecyIuhIWGiE4NYqbi6w24Jrd9ikFrTiR8xSsiNAZ+9dNbl0PulxWu/bxuQLYgJJ1sT3aPlPix/S3VNIJc7CkRTvlBc69hTFAlcWntvzQLntTOr9JMxhlZVj6bcwUVLJ2NmlPwFHSbITmZMfnhcuINpi+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(44832011)(5660300002)(508600001)(8936002)(4326008)(6862004)(8676002)(66476007)(66556008)(66946007)(86362001)(6486002)(6506007)(53546011)(26005)(186003)(52116002)(2906002)(38350700002)(38100700002)(33716001)(6512007)(83380400001)(9686003)(316002)(32563001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wu1Viucysa9PhE8WpSGpKyD48j2nnaUHtUfguSAZQyNR6tjrm31fZStpte9E?=
 =?us-ascii?Q?hT3bt36GjM7M/mv0uBbeN6z95PXX6fkOM5rK4PsaWjdgDlqzalkVb1z9RmOb?=
 =?us-ascii?Q?j51PO1/MYr0BdbHKgzQkNpmUcjkTD+vX8M8FtMq+hR+kVfGhZFFP0mraHnwG?=
 =?us-ascii?Q?nWSUva6JVIA48GTLFo/nO7hc+gfxB2RF7V44wkV8rV65KsZ0o4qAd9A17AiP?=
 =?us-ascii?Q?DjsYxiaC926QVkoZCtBK/9wxyTItCWlQnHjGMhTn6fp9a4br2GoszqIBH3Hj?=
 =?us-ascii?Q?v3jAWSDSlvJ27ClSNv+SkYWsVeJgMOikZcy3YHPUIc3ozRQWcUaN3jAmuUPk?=
 =?us-ascii?Q?6A6TFP2kLOYYVlgZA+PsDIG+GI/ffxj3SoEKpjyX3DbbOG+F2KUnIOO4RiRU?=
 =?us-ascii?Q?W4re1VX/wFJm0NA7QLe696QazfV2EH8CZAG6YDTi4xm+VBgCCrIRhMx2cYZQ?=
 =?us-ascii?Q?SwmFeLg/mx8ze0Jt7zCbgHtvJA63eGcFbruCqKsYW01NUY1XA990Ad06o94n?=
 =?us-ascii?Q?oiT9CrJZs0yTD2jaRESpQiRK4tircmLA5ChZPXr7T8VFmiVoX0P+YGkxTwgd?=
 =?us-ascii?Q?bYdw/T6ez5UhtfPUDqTfsfKHXSwCs/4Uhm1wnsy2Ey4cEW8uSKuv/+pLOktk?=
 =?us-ascii?Q?NvQ+PqW3+SGaTacEdZoROf7TsRZkcpojubppft7NiEjXjIdJVrFz9yD8RcVL?=
 =?us-ascii?Q?CWFPCOB0bIYBVvtxUD3NZRFz2YLUcFs53vL6MCVIKbMEG5J1NyrmEQ12h8W/?=
 =?us-ascii?Q?EJwnjPJnzbu+TCTe5YfppNTuR4JScgtIuirzTQDJiZ88LsIB6/tYp9K9NKuO?=
 =?us-ascii?Q?Ul6v8CCribCOPvDMHGi6dnnYZCFsqMnzVqZgSpEiOLydwClbzchO4af8Wo2d?=
 =?us-ascii?Q?ghXv5nXJu8JmyliO7coeqi4FGFv9Vllab+WPCtKvLBjxa8FJH0BpBOuKiJ9J?=
 =?us-ascii?Q?PQWnrfF0i/ymRMQnOdsevYRGbfKlefwcRJZE2cAwzSF+8YoPPcSJUpnsGyCQ?=
 =?us-ascii?Q?5414TB9J9vzUimppuB5lGv8+uucMqmRd1XQPpHPWk5Al4AqYHPJdkDmN56Oh?=
 =?us-ascii?Q?U7LeF3lrdqQN5FxAnaSjM0hTD4CcJxwUBhKZCJKWO+D2Shyi2sEAAeAK+OOs?=
 =?us-ascii?Q?2u7Q3T6kbEdpQgJ6nAtd3fADZoC7AhZDc/d9hKowYiYEo4UPbFyuGRg1MIca?=
 =?us-ascii?Q?2WFYKdiRdJY4HhnxOdTEJIyGkOZLWSTy476QCxmZGRiQlQCAdXNPgQTFUrU+?=
 =?us-ascii?Q?pnzWPzonfeozqkBI+js5EW/r9s7MaYPNuQXKMMY9zWb9XbspYa/PkkXMujiS?=
 =?us-ascii?Q?UVqF+Cg/bCGhFnCsebb8AaQtQri9GzycYHCJR6Y3lJA3a4YVs0RIFYwo+c1d?=
 =?us-ascii?Q?X+ZhAtLG9+xNgZoHRwVymYUI4HKbN4N4nbtVDOwZUWjUAOCgMULHEhO+ohm8?=
 =?us-ascii?Q?kT/3Hwvv/97MelmWEN5qIpyRz5D+SAuY7gjqviHU4XlMmKSAakPeSSgf0cyr?=
 =?us-ascii?Q?/vD4cvjgALFyQ6/p5pnT0rk/3Gs68SSnm/YNxBwKSD/rhbcFahyreDXKLstQ?=
 =?us-ascii?Q?hxGTzulnHEUl/YeDaVjh7Ybl57zlS/pTpvb02Ii2ozhG3L3No6P57BKgJ6JJ?=
 =?us-ascii?Q?YRAbHEsyi9uDbIHkwF029IyNooXGHFM3LRjd87BA6XJkKILeO55/xOPUggMZ?=
 =?us-ascii?Q?RpUv58/fYhiohs2cCvA388Y3jeikoFI4L9xsdqCpgC80kkV0xbTffpCs4JwD?=
 =?us-ascii?Q?MWUp6gWhcA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f16a29-2da0-43fd-c319-08da37e13ea3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 08:42:58.8341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlSA4xPPnXvV0LeQSmPxq5hF3NkkvgShRsEXmuphgGJQf8zBydG+g2GrOmtmsxmHyP3vL5YTRU8y1PFTZvaQwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4186
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-07 20:54:30, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> According to reference mannual CCGR77(usb) sources from hsio_axi, fix
> it.
>
> Fixes: 9c140d9926761 ("clk: imx: Add support for i.MX8MP clock driver")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.

> ---
>  drivers/clk/imx/clk-imx8mp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index ba058fbccecc..e89db568f5a8 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -673,7 +673,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MP_CLK_UART2_ROOT] = imx_clk_hw_gate4("uart2_root_clk", "uart2", ccm_base + 0x44a0, 0);
>  	hws[IMX8MP_CLK_UART3_ROOT] = imx_clk_hw_gate4("uart3_root_clk", "uart3", ccm_base + 0x44b0, 0);
>  	hws[IMX8MP_CLK_UART4_ROOT] = imx_clk_hw_gate4("uart4_root_clk", "uart4", ccm_base + 0x44c0, 0);
> -	hws[IMX8MP_CLK_USB_ROOT] = imx_clk_hw_gate4("usb_root_clk", "osc_32k", ccm_base + 0x44d0, 0);
> +	hws[IMX8MP_CLK_USB_ROOT] = imx_clk_hw_gate4("usb_root_clk", "hsio_axi", ccm_base + 0x44d0, 0);
>  	hws[IMX8MP_CLK_USB_PHY_ROOT] = imx_clk_hw_gate4("usb_phy_root_clk", "usb_phy_ref", ccm_base + 0x44f0, 0);
>  	hws[IMX8MP_CLK_USDHC1_ROOT] = imx_clk_hw_gate4("usdhc1_root_clk", "usdhc1", ccm_base + 0x4510, 0);
>  	hws[IMX8MP_CLK_USDHC2_ROOT] = imx_clk_hw_gate4("usdhc2_root_clk", "usdhc2", ccm_base + 0x4520, 0);
> --
> 2.25.1
>
