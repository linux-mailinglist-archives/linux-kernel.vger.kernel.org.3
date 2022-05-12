Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DD952466D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350694AbiELHF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350731AbiELHEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:04:47 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60054.outbound.protection.outlook.com [40.107.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC45612A0;
        Thu, 12 May 2022 00:04:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYqNe3FHa0ZS5PVIv0oosLXNUrkoQZdULMR00m97GfgDiRiEuwkxOXHx3p6s/H8NZsTX6G0hW0CDFaXZmKxRUa9h6eHAPgAo/xqKCwpgJsO67UEwR4iDbK5YZsaGYLHEr44QOp4B1Jyi0L4BoTcmIHiiq7klVbE8HrO2GBSX4VA5Bn+asKDaZbZG2nKlbM0wwThUMqB1HDJIrBYIHlVBAhmB0RxBB4YbYW1RUa5cwV2OZvjUuCJojQZW7AOfXNiTPs6I48UuNQ08gvo2zfd1vWcEVj27sm5BWO2GddIXRFe/V1Wfgs+8m2g0J0xv8UwCiNcmEXU4psIVjgEN+jZ7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUGgLvWGLp3vL4pp6UrIIvSNJ9DzY9if4T8+JNRtg4k=;
 b=KxUn+oXh4hrnz1aAj20tKNB5vj4EopgpZFnbqepgyiDqiu7/k/gsEmhPJcdFlR4WibCws3L64YsZqsIvUoWSzzHQusJp3Pag2RmBbax83vT896PVoUsIeNIcBIcy0PsWSrJgyHE/qIWXKNf4etj+SZG/Yq1XJZWgGr5ua+PGy3nKyh4Vbr99gh72tdpZqgnXTfVWbOtswhCumKtVDBpmpJi2NogW2xG8uyMvy4eLSvjkYhvUKwuNjcFYJntNuyvm585EJN/yWYrJTmTQed1J3t7BZb+Y5LodbvNs0fCLemPd2wAzy6bkGswodtlLouKchGTtKaSKgSOJGe8pMqXUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUGgLvWGLp3vL4pp6UrIIvSNJ9DzY9if4T8+JNRtg4k=;
 b=Wr+LrOTN5p7Knfu88ipe0Sx843OfdU2N0hoUbyXVXM7RixShI360Ngo3zoGY1umWellr6C5bEqDkOb5bjK21bwbc8dT6GMWmarNMY/4fsj7QdfyoePBy4/X/n9ULA38hCUaKyweGffxsF4ervdjV7oR3i4iO8TkRxJfdbqELqr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by PAXPR04MB9643.eurprd04.prod.outlook.com (2603:10a6:102:241::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 07:04:40 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::9060:4119:5466:f5d]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::9060:4119:5466:f5d%3]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 07:04:40 +0000
Date:   Thu, 12 May 2022 10:04:37 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] clk: imx8mp: fix usb_root_clk parent
Message-ID: <YnyxhduCou/wU+ue@abelvesa>
References: <20220507125430.793287-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507125430.793287-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: AM5PR0601CA0071.eurprd06.prod.outlook.com
 (2603:10a6:206::36) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e2a59fa-94bd-4b47-49d4-08da33e5af00
X-MS-TrafficTypeDiagnostic: PAXPR04MB9643:EE_
X-Microsoft-Antispam-PRVS: <PAXPR04MB964344E602E193F372F0765BF6CB9@PAXPR04MB9643.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ram19i6JaSGINsI1I9Zn2l89KqnV5dZJjTI4pbAfDcFnNyWJRnB8IEPdmnVxknJAUsKii5vzn1V3/YgwriYCCSpe0C06XN+OPTkn7Iq/KPnB3Xb3hhFn9y/CbSsmlm+tWeJTAMWGQPinguQ2iVewVPGD48NkEZUkchlLPVOrVlBUh4/sdMXI4+InBdQxwYRBZWKoa7D9WwdygS6GNsSnsAfPr2FrAu7913PjH7Rw670NqRrcRtq8jpYMX4wC2/7Pa5DpO/AzFJmQtUcMhw20grB6I7S3zRSs5FyPcKQoklaQu/jQ9gnqMHzF0DMexeRh1qXyRxMsXhvdaIII+IMxMybBHeB268X7lW1cUpTktmHBIH77l3CCuQahnKtWUb7+h3gXQ0bdoOdGD8YyoEBMAUJ6O8CGaGxQ/17feb5x8G5WAHQggbzn8ceRHyt5saO/g+OPF3Zjv75sg71pbXWEFaXpE+Pfo7VM0MJP5bYcjKR6SHFOY+fGmggfyKiinsr6dOn7NkOTO2yiNEakPxGBgyx/Ah4M+5uU/29iPG+ePPu6FfVyA3SVamkabS5Pxcki5J2qpPVn8JM5r4hiQ5zlw8qFKpiSvDICn9Jk6dQrwdFefUC+icAUn/0Xo1ssTO9CRHAz317sjKj8OZfNVFmJy8xjAGKBnPbCIL90rUPmDWKfMPBpwIuw34hzW59tC5xggtO1fJLpZaQsvHw3IHe8mh/Lr/eQEzjcfaKeUoLRCoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(2906002)(8936002)(33716001)(44832011)(5660300002)(66556008)(8676002)(66946007)(66476007)(6862004)(4326008)(186003)(83380400001)(86362001)(38350700002)(38100700002)(9686003)(6486002)(53546011)(6506007)(26005)(316002)(52116002)(6666004)(6512007)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1rexKTgAeo4KURcD3YqIznAgVadBvchGBFT9s75CnPB0Sgk1Pg+lE2sX8U+l?=
 =?us-ascii?Q?GTdVf6Z4H3vObMp+BiAtpHjSSpwIEuFynBQZfc+KQWPm5vLpFbuAvgyLsrCs?=
 =?us-ascii?Q?HbwJZeCnKvCXSVXNZOs58OufIMoJIgLUkUATEjp/PXZyqXrRx2Az6RUbpHW5?=
 =?us-ascii?Q?C+j5xUgb8sfX8NAEEmaTytzCR2hMtnsnNlpe5qC30fcEX/Fl99hoZk4KZ5Ad?=
 =?us-ascii?Q?mHlVUiPEz8XYvvrCskMRWFWW7KYgpNmGI219mpYgdypAGtzTE/ay4J7kmPuZ?=
 =?us-ascii?Q?cKTPiPFw6yDIQ27Txwmi5l+Z0f7C4UcLoVZMeI//759kPM7tJMmXaQW2DnLZ?=
 =?us-ascii?Q?5OLueAE7E0QgpRkPOetP2TGyVsHNSfP8SzKBIhgEtvv2ry/YfTTTIsobWEuY?=
 =?us-ascii?Q?ACP/qpiENIjpA+JDnyC1tbH8JYI+QEUtSVcslYg11KxxejfsvRAMsn0yqfdu?=
 =?us-ascii?Q?UxnivlRLjN6U6ykJHeazPt1K2nE6lTQ44RAkBvpyIbkqWsRPEQ2Lh09KRKCI?=
 =?us-ascii?Q?EA0wfecbpgDMQ2C9rJbx/YRACUo1B6RFDhVJuZm/uAwdpXeHtJ1C4M4W65Aj?=
 =?us-ascii?Q?6hpXCb0LM+kNxLLArrdRprR/K4iwOGRiNBOQuODQJ7bH7kThYO5g1sL5Ns2M?=
 =?us-ascii?Q?7Sb+iyYvTGnQ+Eui/eM1ELNW9R01clez/jkVFuhVBAj5zgAZNsK6slLZJG8j?=
 =?us-ascii?Q?ya1T9Pc06Esv72cShLX6FEBBkSuIsfzGlZWRxoZbY4+7cXDTB1LCufQimPly?=
 =?us-ascii?Q?eWUlfboZuZrnukitAygEftULXU3CTW84YYzLf4X5ykw1z4FokZcaYdQp3hLX?=
 =?us-ascii?Q?QnOQJtnTaXTC2/eln/o6VuOV8nnN6B2L2zaSg+jPusUjx3w6NrFY5jnEchdA?=
 =?us-ascii?Q?242Eu/Xtlnmt2ESK6av5AzSwbdMq1ipfqwSopqT3pRBimc8usiAA96JAMBes?=
 =?us-ascii?Q?gblvRIYqJ+4EiIvhnWmEKg0r77IrLxWdHu01fPuOmBVokMiEOl4wWcRivz1f?=
 =?us-ascii?Q?uRABrLVVWp2mARKNgimNLmVm8L7AZbCCdc6CYwCe8/jPRnvgFqXm+1x6B7mo?=
 =?us-ascii?Q?PIzCinWpeFqA4FScaZUuv49E6vfkcawCmnIqGKxcndVSUcYIn99daxQqe88l?=
 =?us-ascii?Q?6elIRtEB/3Moe5nhlVqxydBQwDvS8Nh8NLj+Mu9hsxhgGazOK1qR7bhqWtTs?=
 =?us-ascii?Q?kbfv/sdEFh4o+xVlvadTSHtKhji3VYvSg3FmMWWnUmHX3nDzAkpYZmvE4lcI?=
 =?us-ascii?Q?bBYmhs2ZgOKyzgcd3k2JSpfbbVtQ0PaaBw48D6AulgoSiGOxBhUNJRb7NaHo?=
 =?us-ascii?Q?2vGjfm4tqAIOo10Km/EJU8p3tL+CQZRK9DySaXlC5zEboFF277XSB4MSyFnK?=
 =?us-ascii?Q?ThW6jZtEm0VoI5YlrTVevVA1WK3/L9VZ/4cOb/0fa+wMmEDl5Fqf8z7N23MV?=
 =?us-ascii?Q?QCdNu9S5H8pInGlr0+Wce33GT0TsKo2VM/3Wrp4DK1QOJ+dL50hARZ1Oj8h1?=
 =?us-ascii?Q?P/Yzik7Zd/b4p7qQScQa1Ly0XKtiZpqZniAX1FE548vALzUcZqE0AoVIzhOp?=
 =?us-ascii?Q?qeDioQ65XJT5cSXWdh+0Uu4LZCATqvfG95vF5g7hEbHjM1sEittLrvEytLVm?=
 =?us-ascii?Q?HfD2O0LBKs7YOGPx7AwHvg6Ij6tsLS7/GY0qVTGAGzylhTxydtLhjN9E7CAr?=
 =?us-ascii?Q?7NmW2BZSkh6rqniKLL5NpUXoLF4CKiFY6Z6gQOuC2rjowezuLX/D2ovGfDaR?=
 =?us-ascii?Q?BDMQxwgsjQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2a59fa-94bd-4b47-49d4-08da33e5af00
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 07:04:40.4155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQvNqjHUktdfbP2vU0n4qNbC0I0uJVCVh1hHbGnmqWRPflALoKulHDM1Yvx5lUvZvYLHMRlaqO+aizlpXybYfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9643
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

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

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
