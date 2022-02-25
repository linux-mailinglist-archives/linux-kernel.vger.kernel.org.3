Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA3E4C47B1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241805AbiBYOfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiBYOfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:35:51 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50083.outbound.protection.outlook.com [40.107.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DC81AE645;
        Fri, 25 Feb 2022 06:35:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+deYNWoyhBv/3kjl1eiB2l+Rp1aiEFSeTcfb5aZlj8lJFELtvyytDQmvD0tszWSY+MyldNlvoQkcxsq7KyMmTo2RerOg0atdZQ90vIyUGVPir6m+AYw7VTyyeRLsvGgOt78BRDoMR1Yj5yvutUhvRf+ysOJDNNX1DdXQbbNHbwDaAbSepVz0ZxDwdiuKt6edbZ5VV6gV2qWlcQy2D0mJfJ8xME0jA+POKDWiMEcw3yKX+uENc1PrgnzLoE81SYgVv9l9vnmKEJk7SnRg65gOc0ydiBMekpx4GeCHKb6DtRKNtXnCYJn8ggiK+ld93sBZvrpZAsSPsa3rrvQts9lWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7vvH6kU8jFeYAER9fl2mTYgZzrGV0oSDlZpwduzTyE=;
 b=oTE1l8iKdFv2Es07YUwewQLJsfUwTREWGXaAI8LXZVWlnqKRTy85pzCEZq8pQJdoCnfrNL71bY5RRROHHxR1ENa4fQc+tIFshHq6REeomLos0aH6Iii7HwuSrUW/4JN2dV22b3x+4eiu9SExjdOBBG4aPLZqCGnRk38RVw83MWt6YMZuDsp/4l8Rfl9p8+pju7ioaMyeEZyRpoHvDQX+aBgt0DdYO64WaIkiREjOhDS+TyK1q843lgZOOJuJW+I1obMh265v+geUy7fI9RfJienTkXJHueJKdc60VGv9VI9efm6T0QPBrbTZQI6LwUuBiW0w7T7nTRXW39Zf41/hOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7vvH6kU8jFeYAER9fl2mTYgZzrGV0oSDlZpwduzTyE=;
 b=jjdEkdHYRbwRwSoEl4cdTLqRRRleTXnUUe67PEGVihN8D418YkaFtcC7g2OhAop8c1i6hxH9myVHW6QkFCrI72UlegyUrIRZZsgy5E7XWepFMt8AXPv8TaITXQqwvogwHnqq4blyMhqby0iVqC7w1MF15LGQ3B5ryDbI/Z8753w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM5PR0402MB2724.eurprd04.prod.outlook.com (2603:10a6:203:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 14:35:15 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::144c:129e:befa:2602]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::144c:129e:befa:2602%5]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 14:35:15 +0000
Date:   Fri, 25 Feb 2022 16:35:13 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 3/3] clk: imx8mp: remove SYS PLL 1/2 clock gates
Message-ID: <YhjpIbIVf7DQh/Ja@abelvesa>
References: <20220225081733.2294166-1-peng.fan@oss.nxp.com>
 <20220225081733.2294166-4-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225081733.2294166-4-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1PR08CA0252.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::25) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7f60f9a-276a-4c5d-9091-08d9f86c09df
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2724:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2724491D365017C344915B41F63E9@AM5PR0402MB2724.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jf/SDrhcgO69GfXz/d+dkv6CPkKv8mbVTStSvtCK31NVvdL/ueG017WAHbIaUcqnV4UTC0cXQjNCk0dMqw3cntLBHTVEyn+GvKUGO7K8fw/vgHJZo7PwXJcyO7amOMKx1xpT1d7FrPnPOMognma9809noH+/5UBshW9gG5IBdtT+6veie8DWcunaGTocRLuqS6TYEZ6T0b5vS3WXFpXVBBQ7bf5c0p+LlB86VF+rUc0HGKyQNXWoVFm/TVN5Y7YiitWiyc+LufOjLDPY/sQzlfCcokX9pvRBmkhUiouZ/uAO5UN/dOun0kiWS5wRs63qchX9TRK5rsoirOzCqZJbEaxXfTWZNyGNypfjpqxvvkgm4diqjqdUqf0ZeidF9ImJjEsbcixH9Fud3HgQmaOU2nNMSfLR+UACikWKTIcuyEPMIhKbQg1Cz6bpL2mlpVlJcDU4uhI0099yOSTn8iRXXZMUoXRpYg5AIBt8MZybsTkFd9E+sd0sBzdSkA2Ph4WHiUFxVo2vQugUMtx6+d+YLcRxCTIb+2Kqh01DXQrUHfKHzGnva2G29ePiyKr2HEdRvWbcSvafeXXuTws2BkrUKbSBlcbq988YM8h0loTHF5rR2ljPm9dXPN8n1BuEMWqfZKXK7cO4H2s9D/sVOa31ZcMXRC0JaFrGimpZo3MPyI83QEYZb7gFrgc6XsA8Z+rAo4bmS3Hnzb5f9pkPPZv1P8R3oJgJUV/H4m9hUy1G/0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6486002)(6512007)(38350700002)(83380400001)(86362001)(38100700002)(66476007)(8676002)(66556008)(4326008)(508600001)(316002)(6862004)(66946007)(5660300002)(2906002)(44832011)(9686003)(7416002)(52116002)(53546011)(33716001)(186003)(26005)(8936002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wp8v0yTQlt1SRe1AfCItcZqmz7elblaLZ8N+NqefmizI+/P1oWaEfhGV7d68?=
 =?us-ascii?Q?2TmeLJ/aeRR9Du4YYzZH4XhfBag8YB9C5hpI+xjm6mGfTeobdQCBNjB63Fhq?=
 =?us-ascii?Q?kvK0EXML5+PqfnO2XAQ8TbQyr4aa0wk1X5hAKSWPXOY21Vd4R0naZbqgHLpV?=
 =?us-ascii?Q?IqIUoVcjs2WA9Z/OUXSUVlWGVbG6US16VxaYXbrHrRe8fbsN8/muOVs9RTLO?=
 =?us-ascii?Q?BvsY69mPRt7ylr8bbt4pwQoj++SCcr8efkr71zRDxMKMJ+XEZUkmkejFbFlO?=
 =?us-ascii?Q?Ba9Ks8oLDZl0CAQV8IZXU54Yr/FT5w/7aepqyTDhn1FlrQMq5iwtX0nAzTNU?=
 =?us-ascii?Q?EwXyhkucW5uh3mxCUHJ8BQLNLK1IVCR6eonvzVcfMl6Zyo6JEhzdFqH7ff9c?=
 =?us-ascii?Q?vfy6R6ln0LqsBP7LYGnA1VLC9m/B0mss8aia8ubct4xwEhK5flYHvvH13Ow9?=
 =?us-ascii?Q?dLp/Se5fsoLIhMvhLquHRoYd+c0P7GcxapSfAGYiOkENbgqaerTn7RsjX6iA?=
 =?us-ascii?Q?mRaSgfhcCH9Ccyc+0Sh7trdjzVmim/x6hL7HzV1QwW8DQYez6y7jDVXO2NZC?=
 =?us-ascii?Q?F7q9QGVVIJpXX9wW7/kYia1S+8mjuo/qZnv4IdMhS5vrgFr45JlPYnGszIT/?=
 =?us-ascii?Q?cZnqN/amfZqeTZkqa7qSq8Pox2Zn+TzdFN06eVCxp9MCFIA9k5osT4tjuQK9?=
 =?us-ascii?Q?02s7PFWz3Rh9XkanLg1ZZqJ/82BzQyJc492HJuWYqDUCo3fmEvSemdR8fsoA?=
 =?us-ascii?Q?cOpk8WtNw2Vd4jvUM6Ax0t6yccaPiucasNjLJlgy3YBlSxsrlVqv60mT63Bg?=
 =?us-ascii?Q?Bzk3ZaOoThwW92s7xDpiA2Pd1Z0aT0uy19pGqw5LC1FaPq1rZxaXflkaqnE3?=
 =?us-ascii?Q?ZbTWwM2/odfIpXz33V8y9P6KpLex9x/oY0ASC8qNqgZSfH3GeIZnwzFyUf2V?=
 =?us-ascii?Q?fT6wSDaC0tnWeJTKAYGjc1zsXxG/IB1yIEgCY3OHn3zqHqwWL6eLXQjQK3VZ?=
 =?us-ascii?Q?hLpSbzVxpvqElmCGROp3+O4W1momJmMdMahwTY6RrXy3LbWI1TwJglzepGYJ?=
 =?us-ascii?Q?ebDzkdb5yHoXfSkY+ZuGbcoLjiNm8+KPEXmhcVRFtkEtuw0t7pghGyqmTpjW?=
 =?us-ascii?Q?UzWB4Y3slOnMKxmNw7EyN+6dBOLAVAmqzp2dTdAvPs2EDNfWAgPUer0DxYv/?=
 =?us-ascii?Q?/ouzFYoIfFIavtsORrD8KrGaxPqhU5x7R8XoEzE1/HMk5rAN7Q1oyNmPUZKS?=
 =?us-ascii?Q?tj8P4AXNG05unvlHcq3ioqbUpTSWgABw+2FGhQw9nQdVDXXU3bR/1AuPcC7e?=
 =?us-ascii?Q?hSy7EIksCYaLaSpgESB+/ictC7Jd/Z7Rf+QNzAwLV0XuUIwQByGxK+Ptr/rB?=
 =?us-ascii?Q?EVSj1wAadDwDR8S8+qtCUZDHBm7kDD2v3TfZN6WW8WafwHR8778zP72HsWg6?=
 =?us-ascii?Q?wvHG2C3cf8aY1cJhpJhmuXdL5tQ7xBWgBKO5FQL14/OHgaAgB3p1rRXmBGQH?=
 =?us-ascii?Q?OgUctWqpiwtaljZqNCEtAnsJms42OjfD/TIHVaBgs+BzVAmZuIZ2yvaX+yRW?=
 =?us-ascii?Q?41ocWj5xpgpR9RBE0g+wvduGL+HXwmOH5/TRgt7p+4DjC0ZqDMaO6E0oi9QI?=
 =?us-ascii?Q?ZRRNVkDP6+LKA2WHxKQgx54=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f60f9a-276a-4c5d-9091-08d9f86c09df
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 14:35:15.7469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xxqqr1hF3uTjXiRqsuRhqL9RWvahXz3BDgCmCtIRZn59jqXcwGufWE1YEPMIJV5/v2d8yGnCvXLBRMXEag/bxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2724
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-25 16:17:33, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Remove the PLL 1/2 gates as it make AMP clock management harder without
> obvious benifit.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mp.c | 48 ++++++++++++------------------------
>  1 file changed, 16 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index f23b92906d3b..18f5b7c3ca9d 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -480,44 +480,28 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MP_ARM_PLL_OUT] = imx_clk_hw_gate("arm_pll_out", "arm_pll_bypass", anatop_base + 0x84, 11);
>  	hws[IMX8MP_SYS_PLL3_OUT] = imx_clk_hw_gate("sys_pll3_out", "sys_pll3_bypass", anatop_base + 0x114, 11);
>  
> -	hws[IMX8MP_SYS_PLL1_40M_CG] = imx_clk_hw_gate("sys_pll1_40m_cg", "sys_pll1_bypass", anatop_base + 0x94, 27);

Hmm, isn't there a chance that u-boot might gate these? Then, in kernel
you won't have a way to ungate them, leaving the consumers hanging.

> -	hws[IMX8MP_SYS_PLL1_80M_CG] = imx_clk_hw_gate("sys_pll1_80m_cg", "sys_pll1_bypass", anatop_base + 0x94, 25);
> -	hws[IMX8MP_SYS_PLL1_100M_CG] = imx_clk_hw_gate("sys_pll1_100m_cg", "sys_pll1_bypass", anatop_base + 0x94, 23);
> -	hws[IMX8MP_SYS_PLL1_133M_CG] = imx_clk_hw_gate("sys_pll1_133m_cg", "sys_pll1_bypass", anatop_base + 0x94, 21);
> -	hws[IMX8MP_SYS_PLL1_160M_CG] = imx_clk_hw_gate("sys_pll1_160m_cg", "sys_pll1_bypass", anatop_base + 0x94, 19);
> -	hws[IMX8MP_SYS_PLL1_200M_CG] = imx_clk_hw_gate("sys_pll1_200m_cg", "sys_pll1_bypass", anatop_base + 0x94, 17);
> -	hws[IMX8MP_SYS_PLL1_266M_CG] = imx_clk_hw_gate("sys_pll1_266m_cg", "sys_pll1_bypass", anatop_base + 0x94, 15);
> -	hws[IMX8MP_SYS_PLL1_400M_CG] = imx_clk_hw_gate("sys_pll1_400m_cg", "sys_pll1_bypass", anatop_base + 0x94, 13);
>  	hws[IMX8MP_SYS_PLL1_OUT] = imx_clk_hw_gate("sys_pll1_out", "sys_pll1_bypass", anatop_base + 0x94, 11);
>  
> -	hws[IMX8MP_SYS_PLL1_40M] = imx_clk_hw_fixed_factor("sys_pll1_40m", "sys_pll1_40m_cg", 1, 20);
> -	hws[IMX8MP_SYS_PLL1_80M] = imx_clk_hw_fixed_factor("sys_pll1_80m", "sys_pll1_80m_cg", 1, 10);
> -	hws[IMX8MP_SYS_PLL1_100M] = imx_clk_hw_fixed_factor("sys_pll1_100m", "sys_pll1_100m_cg", 1, 8);
> -	hws[IMX8MP_SYS_PLL1_133M] = imx_clk_hw_fixed_factor("sys_pll1_133m", "sys_pll1_133m_cg", 1, 6);
> -	hws[IMX8MP_SYS_PLL1_160M] = imx_clk_hw_fixed_factor("sys_pll1_160m", "sys_pll1_160m_cg", 1, 5);
> -	hws[IMX8MP_SYS_PLL1_200M] = imx_clk_hw_fixed_factor("sys_pll1_200m", "sys_pll1_200m_cg", 1, 4);
> -	hws[IMX8MP_SYS_PLL1_266M] = imx_clk_hw_fixed_factor("sys_pll1_266m", "sys_pll1_266m_cg", 1, 3);
> -	hws[IMX8MP_SYS_PLL1_400M] = imx_clk_hw_fixed_factor("sys_pll1_400m", "sys_pll1_400m_cg", 1, 2);
> +	hws[IMX8MP_SYS_PLL1_40M] = imx_clk_hw_fixed_factor("sys_pll1_40m", "sys_pll1_out", 1, 20);
> +	hws[IMX8MP_SYS_PLL1_80M] = imx_clk_hw_fixed_factor("sys_pll1_80m", "sys_pll1_out", 1, 10);
> +	hws[IMX8MP_SYS_PLL1_100M] = imx_clk_hw_fixed_factor("sys_pll1_100m", "sys_pll1_out", 1, 8);
> +	hws[IMX8MP_SYS_PLL1_133M] = imx_clk_hw_fixed_factor("sys_pll1_133m", "sys_pll1_out", 1, 6);
> +	hws[IMX8MP_SYS_PLL1_160M] = imx_clk_hw_fixed_factor("sys_pll1_160m", "sys_pll1_out", 1, 5);
> +	hws[IMX8MP_SYS_PLL1_200M] = imx_clk_hw_fixed_factor("sys_pll1_200m", "sys_pll1_out", 1, 4);
> +	hws[IMX8MP_SYS_PLL1_266M] = imx_clk_hw_fixed_factor("sys_pll1_266m", "sys_pll1_out", 1, 3);
> +	hws[IMX8MP_SYS_PLL1_400M] = imx_clk_hw_fixed_factor("sys_pll1_400m", "sys_pll1_out", 1, 2);
>  	hws[IMX8MP_SYS_PLL1_800M] = imx_clk_hw_fixed_factor("sys_pll1_800m", "sys_pll1_out", 1, 1);
>  
> -	hws[IMX8MP_SYS_PLL2_50M_CG] = imx_clk_hw_gate("sys_pll2_50m_cg", "sys_pll2_bypass", anatop_base + 0x104, 27);
> -	hws[IMX8MP_SYS_PLL2_100M_CG] = imx_clk_hw_gate("sys_pll2_100m_cg", "sys_pll2_bypass", anatop_base + 0x104, 25);
> -	hws[IMX8MP_SYS_PLL2_125M_CG] = imx_clk_hw_gate("sys_pll2_125m_cg", "sys_pll2_bypass", anatop_base + 0x104, 23);
> -	hws[IMX8MP_SYS_PLL2_166M_CG] = imx_clk_hw_gate("sys_pll2_166m_cg", "sys_pll2_bypass", anatop_base + 0x104, 21);
> -	hws[IMX8MP_SYS_PLL2_200M_CG] = imx_clk_hw_gate("sys_pll2_200m_cg", "sys_pll2_bypass", anatop_base + 0x104, 19);
> -	hws[IMX8MP_SYS_PLL2_250M_CG] = imx_clk_hw_gate("sys_pll2_250m_cg", "sys_pll2_bypass", anatop_base + 0x104, 17);
> -	hws[IMX8MP_SYS_PLL2_333M_CG] = imx_clk_hw_gate("sys_pll2_333m_cg", "sys_pll2_bypass", anatop_base + 0x104, 15);
> -	hws[IMX8MP_SYS_PLL2_500M_CG] = imx_clk_hw_gate("sys_pll2_500m_cg", "sys_pll2_bypass", anatop_base + 0x104, 13);
>  	hws[IMX8MP_SYS_PLL2_OUT] = imx_clk_hw_gate("sys_pll2_out", "sys_pll2_bypass", anatop_base + 0x104, 11);
>  
> -	hws[IMX8MP_SYS_PLL2_50M] = imx_clk_hw_fixed_factor("sys_pll2_50m", "sys_pll2_50m_cg", 1, 20);
> -	hws[IMX8MP_SYS_PLL2_100M] = imx_clk_hw_fixed_factor("sys_pll2_100m", "sys_pll2_100m_cg", 1, 10);
> -	hws[IMX8MP_SYS_PLL2_125M] = imx_clk_hw_fixed_factor("sys_pll2_125m", "sys_pll2_125m_cg", 1, 8);
> -	hws[IMX8MP_SYS_PLL2_166M] = imx_clk_hw_fixed_factor("sys_pll2_166m", "sys_pll2_166m_cg", 1, 6);
> -	hws[IMX8MP_SYS_PLL2_200M] = imx_clk_hw_fixed_factor("sys_pll2_200m", "sys_pll2_200m_cg", 1, 5);
> -	hws[IMX8MP_SYS_PLL2_250M] = imx_clk_hw_fixed_factor("sys_pll2_250m", "sys_pll2_250m_cg", 1, 4);
> -	hws[IMX8MP_SYS_PLL2_333M] = imx_clk_hw_fixed_factor("sys_pll2_333m", "sys_pll2_333m_cg", 1, 3);
> -	hws[IMX8MP_SYS_PLL2_500M] = imx_clk_hw_fixed_factor("sys_pll2_500m", "sys_pll2_500m_cg", 1, 2);
> +	hws[IMX8MP_SYS_PLL2_50M] = imx_clk_hw_fixed_factor("sys_pll2_50m", "sys_pll2_out", 1, 20);
> +	hws[IMX8MP_SYS_PLL2_100M] = imx_clk_hw_fixed_factor("sys_pll2_100m", "sys_pll2_out", 1, 10);
> +	hws[IMX8MP_SYS_PLL2_125M] = imx_clk_hw_fixed_factor("sys_pll2_125m", "sys_pll2_out", 1, 8);
> +	hws[IMX8MP_SYS_PLL2_166M] = imx_clk_hw_fixed_factor("sys_pll2_166m", "sys_pll2_out", 1, 6);
> +	hws[IMX8MP_SYS_PLL2_200M] = imx_clk_hw_fixed_factor("sys_pll2_200m", "sys_pll2_out", 1, 5);
> +	hws[IMX8MP_SYS_PLL2_250M] = imx_clk_hw_fixed_factor("sys_pll2_250m", "sys_pll2_out", 1, 4);
> +	hws[IMX8MP_SYS_PLL2_333M] = imx_clk_hw_fixed_factor("sys_pll2_333m", "sys_pll2_out", 1, 3);
> +	hws[IMX8MP_SYS_PLL2_500M] = imx_clk_hw_fixed_factor("sys_pll2_500m", "sys_pll2_out", 1, 2);
>  	hws[IMX8MP_SYS_PLL2_1000M] = imx_clk_hw_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1);
>  
>  	hws[IMX8MP_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mp_a53_sels, ccm_base + 0x8000);
> -- 
> 2.25.1
>
