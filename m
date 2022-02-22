Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFD94BF341
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiBVINF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiBVINB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:13:01 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6703114995E;
        Tue, 22 Feb 2022 00:12:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWPIoVE5DAISuXrv38WoDI+70l7KJ+wKjF8HkgbYz0mloyhSmtSNlOdYLMq7/sdo0SxnL/uGxkcyYEW2s9zWHDTOWhv+xXvnlACOQY4mKwntAV0Nx/lKtH87MwtzE5BN1g7QzzvaC0ijrl9+lsyBIDDAWweMRgEvPOntQrjCmRgMc2b6OaEu5AOBAwpcur9zXx1YaWxPRXhZqqe3rwCR6hPv0S4lES4N9wQvTxogR5Q1siKsslE3c4Euu41WE4fFc9zkbv1U12btlbf1pkas2hfHo3ddr2hPY9jxkYSEKiFWDW3YSKkKDMPpSIPIozLIJZ+2KuSp3+0bGpZaOgU5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGd8sJWU9vOeIqa1FsASzWzYWI7hXnXhk5FnCmQWokw=;
 b=jBB5i1U0jRVMTN0aIfp13xNixlyBIMHimFZusHk5IAxD/fhJ1cJg8jb+Al5x1KeRjCgd0NBbtgeIsgnM+Aq9OLBtTLMZ5P78OVM/DXumrA1zQMxIhymcgXbnnY++mvN0jmO0bPBUJuGk0SDCUKZIy2v+49BvvZ6ofvqVbx4OJUv6KP/kfkI0ZSvWKma8U4GML2ooajWhgcjewaT5PjBjVmkzX2/HQ/f2wJupcV2/jjXWomH77+g9uTgQBKzeyODTC3LSrWE3oHIPWkwLnss0mgb1yUJtzm1ESdU3W62KwJwUk+vtcHbTIe/qK6pQBl1ZMI5miuAhYenD5AkH+NMfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGd8sJWU9vOeIqa1FsASzWzYWI7hXnXhk5FnCmQWokw=;
 b=AqZE1oQDlP4IsWfImaVvYT9+K1qJzQMKJtkEa5828x87BqFem3w6KtIbpNDO6EhUjmrtQLx7bsDau2JtGFm6iUkZ5UtRd4n9GIArcnnRJsBXaikWDjwI1WNrTTJ8DxdVIKyi+8R29TgJBK175DB79XewpwaYeuGJCd1Ub9OBdws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by PAXPR04MB9327.eurprd04.prod.outlook.com (2603:10a6:102:2b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 08:12:27 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f%6]) with mapi id 15.20.4995.026; Tue, 22 Feb 2022
 08:12:27 +0000
Date:   Tue, 22 Feb 2022 10:12:23 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mike Turquette <mturquette@baylibre.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Frank Li <frank.li@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, David Wolfe <david.wolfe@nxp.com>
Subject: Re: [PATCH 2/2] clk: imx: Remove audio_mclk_root_clk
Message-ID: <YhSa54RPjJQ9AE96@abelvesa>
References: <20220127141052.1900174-1-abel.vesa@nxp.com>
 <20220127141052.1900174-2-abel.vesa@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127141052.1900174-2-abel.vesa@nxp.com>
X-ClientProxiedBy: VI1PR07CA0258.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::25) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d95bb8e-9c23-4c53-e8aa-08d9f5db1026
X-MS-TrafficTypeDiagnostic: PAXPR04MB9327:EE_
X-Microsoft-Antispam-PRVS: <PAXPR04MB9327BBDD94A355AEF51D1173F63B9@PAXPR04MB9327.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOcs2YHYEHtKLCfZ4y7RIUBCJvi5ntIkFXxvb7o2yeP4OBdiIE9k97eS55pA/wy+2TcDo5jWaFvkg0hiGGGJFyMGv0gwpYhazmmbLj3L3n5Ii1I8uOBx1mhIBn2KyC4ht1yZnX0wPXPPyKjBu9C4jpGIuzpy7GB1GY045KeEj5/0VUtnRFlKiRMtmLvMVxh/JRtcfBRFt2h/TvfjantT2dYPI42nwv1c9K6Q+vtRQy4zTWVw/rzBwn+JxDQutazLIvdJCAfmB7fF+8GVNMpa8Tn/Z1WgtEFrhBGEzdqHi2OXHPMJ85hYZpFtqIIFMylbBfyGe3zKTyqFxSvsLrTKtg6JePasCoQHh3ZUn/9IMSIMGxhYOzii7zEwTFdqFoFpHwzgDOedetoGcs/YUUjgbMpuisf++aUBUwaLpi3tQsQSwROHqQvO566TX+VIg5it4gi9U/IJpLhouIThcCuo3ZOVFp65UGRXSLIATFnFOWQLwcTk7GzGtSZAE5qurZP98VHbVGaGjmK3MJfhBibXLx822NM3ntJUbswCrNSvxALbf6fZl+wLQjXZVymXuxfOEtsBk60N9jEhXw9VuNOrTqim0IFhBbdfE0F5oyQWddUxnjJZH23kIZIEY0nvwOUCJlxk4baQZTeFjLh8pDtpx5ZnOa2G6lHheFZoIRDOBKI0/iBdSEHWwx0yxIV79FUchX/zmPXrwu7JrEVaA8SldQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(33716001)(26005)(186003)(83380400001)(8676002)(9686003)(7416002)(8936002)(53546011)(52116002)(86362001)(5660300002)(44832011)(66476007)(66556008)(38100700002)(38350700002)(6512007)(6506007)(6666004)(4326008)(316002)(54906003)(508600001)(110136005)(6486002)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ucN2JDuG9Av88TOvDwNGHSmx1KUsUc9hw8IJ+sTW2iJ8uIC7h8IuZ/JX+Ez/?=
 =?us-ascii?Q?mAGirUQHsHKkjdKyD2MA9frlJd3lhgsu1oVW+ENRWLKEGZfvPWGqTB41kR2q?=
 =?us-ascii?Q?+dTRxKUnA8i+dDGj4/G62yMxMhVURuEvGdOHb1RsrxQOseLrNm07P0rke+Cr?=
 =?us-ascii?Q?GSAAXcVEvLqroxqr4cvepgz6iKfWEvGHGElYxL65QghL+MoUZxyL0+2fUn4L?=
 =?us-ascii?Q?Wmi3/eo2BojVnSP0jOmuyi9qkl/v01lYEPB48GM6rXb9W9AQOcm47haBaPG/?=
 =?us-ascii?Q?olSQZntW7V8XKBoifiXLJrefalZkiYp8wnII8hW8xv3UQTrHRa6bS9fmfQtG?=
 =?us-ascii?Q?ErB38W90jHB4QvwqBtkY3dbGLjyNDC11IJ93PfvXgLE/5fNnEfZwqAuSqtUm?=
 =?us-ascii?Q?58Yb56ykjkfTf5YYEIWp4Cal5Dc4e7wiOoY05fQsaq7gqQkE6iZTMJy41Ek6?=
 =?us-ascii?Q?Uqww4N9yIWVmMg+UKwzLv2s7tp8rcjbi74WRK5JpFJfgIk+Zgr4PCxADr/XS?=
 =?us-ascii?Q?KpakjAI6QD8fziL9dUe3wKKBX1tQJjPckni3OfrvG3Xa5fkC6sgutrC5yZHY?=
 =?us-ascii?Q?ntUIuVPSkZAJ8skzKbL2/JZL1GqcCvQWVe9gOs0tsCmqC6kps2gCpwweQI6J?=
 =?us-ascii?Q?bm46tMfvyc1Lxh/KN1oew8zlg598W/xbpel5SS3OTxM4K2VnfMrce9/nE/zO?=
 =?us-ascii?Q?XXlj5k0Yzb+loShw9XeJDTkQGuEFv0pGAk/ZXEMc0ICPN6FlEixFAGpzJVK7?=
 =?us-ascii?Q?etaBmSdiisR5oAjcB6lqMRbeNLaClJnBksm4IS+Kyk8fC5VOroHU8WRUija+?=
 =?us-ascii?Q?PCVFTdCNNtz/3PVAnrepzBXHVqDLps71FbsD4UjDtqtdQOAb4xbDbuDPOz9j?=
 =?us-ascii?Q?uhyZ+2Vjlv0QkoTjZglY+GU869kmiJQo4WUHG3CSqk0Z4vmhHG33cOlqikvx?=
 =?us-ascii?Q?b6kSgCIieb2txw1TVAFa1TIeCgCkUe652jiTEv6YS75kDt9/NS2GEJC2mqTa?=
 =?us-ascii?Q?5I8BNWphLxBoknbsJDfgaX3C11kaLohaEwIaKIjMllcXsM5aKsK33+GkTskw?=
 =?us-ascii?Q?3Hs/0zYRnueWc8JdZUqMliTfYFSS3eEwQL6uLlBJ1N+53hJjKFCaX4eBzTtn?=
 =?us-ascii?Q?SYhCt+CNEbSYSwXBRfZSW8rXFEnZdK/QFeg5LcR3+Hx33tmxVBldc2gRihlO?=
 =?us-ascii?Q?nJ4dITqSTUG9vulnWLEh1JR3Bf104DLVYKt7j5SuTiA5Ze3vEi6IMfCuXGeW?=
 =?us-ascii?Q?vAfwIwUyPaPqJu94yoYQSAdo6wZ1dEBRgb+XvEReRNX/P31004z1lBbtNOvD?=
 =?us-ascii?Q?VaS+WbvXOnRrqnE3i2fXyeG554BaLB3jH7/y/n1oQBvsp6gebhr7CkxU6oqP?=
 =?us-ascii?Q?ZDS2SIiYW7m1PV/sEUYAFR8Yx1KpojYdbNkeXcDAmYmNa0inlPyfWmPkaeYq?=
 =?us-ascii?Q?R8smvgFErdZdS4sCPGlvqKvHVY0IX6+zOEvquyFra9Ym2Pvw4r6WeC6mULU9?=
 =?us-ascii?Q?QYLo94SBVry2b+9EaQcj9P/JH1wbuc0/CbLUwh4t5yqVd7etfAts3yICYNMO?=
 =?us-ascii?Q?DRAvS/Z9kHlqPTGCMAzYD+GsZPjcv1A/Z2TaZ9wGXiGfvM0qQ3Mz+q2Bw+mF?=
 =?us-ascii?Q?axdNktoQlzKGeRsNTFhtibs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d95bb8e-9c23-4c53-e8aa-08d9f5db1026
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 08:12:27.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siRmF7aKwN0vlr4AiPuyJDeFQ+Q15RMQ7VqZ+odKgP/J3LJtj+Snl5ddCtv2+bNOL2CMX6mio9+GOXukmOdWSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9327
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-27 16:10:52, Abel Vesa wrote:
> The audio_mclk_root_clk was added as a gate with the CCGR121 (0x4790),
> but according to the reference manual, there is no such gate. The
> CCGR121 belongs to ECSPI2 and it is not shared.
> 
> Fixes: 8f6d8094b215b57 ("ARM: imx: add imx7d clk tree support")
> Reported-by: David Wolfe <david.wolfe@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied.

> ---
>  drivers/clk/imx/clk-imx7d.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> index c4e0f1c07192..3f6fd7ef2a68 100644
> --- a/drivers/clk/imx/clk-imx7d.c
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -849,7 +849,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
>  	hws[IMX7D_WDOG4_ROOT_CLK] = imx_clk_hw_gate4("wdog4_root_clk", "wdog_post_div", base + 0x49f0, 0);
>  	hws[IMX7D_KPP_ROOT_CLK] = imx_clk_hw_gate4("kpp_root_clk", "ipg_root_clk", base + 0x4aa0, 0);
>  	hws[IMX7D_CSI_MCLK_ROOT_CLK] = imx_clk_hw_gate4("csi_mclk_root_clk", "csi_mclk_post_div", base + 0x4490, 0);
> -	hws[IMX7D_AUDIO_MCLK_ROOT_CLK] = imx_clk_hw_gate4("audio_mclk_root_clk", "audio_mclk_post_div", base + 0x4790, 0);
>  	hws[IMX7D_WRCLK_ROOT_CLK] = imx_clk_hw_gate4("wrclk_root_clk", "wrclk_post_div", base + 0x47a0, 0);
>  	hws[IMX7D_USB_CTRL_CLK] = imx_clk_hw_gate4("usb_ctrl_clk", "ahb_root_clk", base + 0x4680, 0);
>  	hws[IMX7D_USB_PHY1_CLK] = imx_clk_hw_gate4("usb_phy1_clk", "pll_usb1_main_clk", base + 0x46a0, 0);
> -- 
> 2.31.1
>
