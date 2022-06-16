Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F81F54DBF2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359278AbiFPHjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359507AbiFPHio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:38:44 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50049.outbound.protection.outlook.com [40.107.5.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF1B554B7;
        Thu, 16 Jun 2022 00:38:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccIpdEpItRCamg+HvJYqF0GiJk8l6rHFB6Fn51OvNIBhQDsmsQBoZLGIZyvgpuecHchiJNUT42T04/4okilcMB/FmkWR2rDxPAjMIkItGoOWKX3rdBe1mtoi6k068z6Mo96FUq0whGSdOJUfkXmsu/YRoDnqgzq5irTuB5xm7+9YJnZUJwwWFmJLgtKE7llIOLV7bYKqepUg1C9pwh9rXAF1mO4zISbYcucx0VxA2TBDT2kKqXQwTX5cpUfyhJ+QwAt+zV0vgr5gdZXDEjGN5kneLG7tZIk51RiPJEjISI6NYjAZr+sJtNVqKIfjemkIujjcHHI0yK8gt+3jTmm9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndLoqBIaP/ZAWG7Rss8laE1prNddw5yCiNnIIsVq1z4=;
 b=Jz1fLCPt9TOvoWXj1lwwtPIEKzjZHLR1SfpbeFar7SiCBI4586GnU3A9vTuO/YYMxgp5+EfjN0SIjBoD47hdyZlTx1YywGFbQl8Ep4prZeus9GcejsRkpJiz/zAN2yRYJowUycfv2WIRBkTbrWbZyQTfKj5Lw9fkt6liNSGRdr7RFhFhQ+kk1PRxzeK7AxmgSNT/PEm5IF8kWgBPzZOxkwUvb5o9S6swlgrEabze+sss1TMjjoL3qAGjmvLEwYbxeuS8FpPjbXiiy83LCoVgiR4Kg4olnwz0g/mCAJIloSQ+mNGSCGEUEJUWpwFx1YhJrkHh6tgVUqHNs3WeXj/nDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndLoqBIaP/ZAWG7Rss8laE1prNddw5yCiNnIIsVq1z4=;
 b=UTFiYeQsTP5T4aB6Vxt2w5Ix6LpvmCLaHGbDqCD7hL+Pt4aW7x4GR3baBfgcjz1xmzi8TuhrqtcuhK7Gi6F500L4B5+2Y05a2x2IAGoQQmS0bZwvF0rK+UWbbHFhz9Rj3Tob3rFoSM0bn7QoZFQZ97JuyjSkarztp6KEDVTgR6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB5739.eurprd04.prod.outlook.com (2603:10a6:10:a5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Thu, 16 Jun
 2022 07:38:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:38:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, paul.elder@ideasonboard.com,
        marex@denx.de, aford173@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 7/8] arm64: dts: imx8mp: add interconnects for media blk ctrl
Date:   Thu, 16 Jun 2022 15:39:52 +0800
Message-Id: <20220616073953.2204978-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616073953.2204978-1-peng.fan@oss.nxp.com>
References: <20220616073953.2204978-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d348af23-c7f8-4e58-33c8-08da4f6b3ae1
X-MS-TrafficTypeDiagnostic: DB8PR04MB5739:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB5739B3C7485CF0FD99DC6038C9AC9@DB8PR04MB5739.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kv+BIx/KFBPjNE+TTpO+CASPZr8CngPmdiJy1tyCz0VgLTSV4pbVlft8+bznSuHwInK44qOanQCg0LLjCUtrqEBU/V4TAdrOgKohFEnJ3he3FgWBfR+MSlUO1tJxA7O3y1baW91VQStXCSoSu8VyDm2GP5OqmQ9GeE+k38bCgPlCK96qqcrk6aYF3bwaQi8OHS5/1hvIjFe/dnvwHHWi5GAkotJ9NcZzXVaQCu+t4pNBbDxiVsQWYC4eB1OvuARHVCqMcQgTQKb9q5gOotHPThIGBBCZq0pOoqdM3DOfoYBeGToNsmvXfrAm81AaHf1Lj83vbESa70H9YHf9dhxhZVUqWde9YnSt6k9BaTEfsI3I2FHs5Jl9jnk+SORz8IQIFKpwyYLZfkUl6xM5EcGWLujxv8o88M/eN2Ekk5YHIzgOOE70k9j48wT2a3aS5xeFY3Qce0N7XBkCs2CWoPuqr9q0GEhdJCmOIuJO8wQlXiC0m1k2GWF3Yek2vtQSPh8Py7zmG6Y2L9UmQqmofij5bzY0lLwjKCL6ziyuDG646G5Lm6ElgEC3I2B3h/lF2F6YPrFzrn0UoA0jfcrAignKQoacnBrmDb2PF7GORRUNEcGsvVTbG9yGfBvDoyFPNzyoXfLIrhtSuhb/gYERdcmPxgJnEbqOiIAVFl9tcmLyiZB4b/0HQpsnbhiGv/CMGGiLtO/Xmol6Ir4LKnIJBzfaB4uohWalFqgEDpsRieNOncM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(38350700002)(38100700002)(66946007)(316002)(8936002)(2616005)(86362001)(6666004)(186003)(26005)(66476007)(66556008)(4326008)(83380400001)(8676002)(7416002)(6506007)(52116002)(5660300002)(2906002)(508600001)(6486002)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UldVrViMfKoio/pBHQ61fty0uwdCm3pc8IpNjvGFAKSV6cCCdzux+0mmZOlg?=
 =?us-ascii?Q?JycAwrkyn0V+bNGI9hK/BtYzSDxuqjhgR7a/MAUpqfM5TaRokhA7Pe+xbxKy?=
 =?us-ascii?Q?GOjxg8ocaiGOypb6ODi2YZ4eTG5OK2WqJuDn4mdRRkejgL/hHNl61KW89AZK?=
 =?us-ascii?Q?aUkDXBNkp+EeXRQL/kGbLmKwQwueiJ7GQFugt9aiW5Si63imvvec9cq7idAC?=
 =?us-ascii?Q?ocL2BdgSQv9q+TZwh0ZIRZqu1CtomWeNFc7Q1Nlw4NtJsFKlK5XGV8fy5QPP?=
 =?us-ascii?Q?vwnWxrfDpx36uJnVOkOTADVdz66g3IPqJ+Lb+EZlfy85mjnQiKmleqiJ1TNd?=
 =?us-ascii?Q?stH7LLR4p7zXy5k0VpDwCRAa61/HtTShC6q1jPiWkcrC/l5uA8bpe20PZehx?=
 =?us-ascii?Q?RTCyyZBplU4tTAEVn3Gpe+arJCrHURj+ngvs6xvAGUVHShH857RWwikTYCZb?=
 =?us-ascii?Q?p522x7P9Dx1MU36r4tAC94+KulvZylBYg1rhOeyj6YmC6IBMftwJHlCrGR9q?=
 =?us-ascii?Q?TtdZUfcOjDfScIalpcX42zFXO2ZxfKF/oP6PX0XFi4RW3q4CFI6+VVuE5N32?=
 =?us-ascii?Q?PeN+jlYSbpLYz+DkxFNg1c9gDnGusaTnFh0YpJ3ME8cReumZ85TugduD9/FV?=
 =?us-ascii?Q?yJf5lFaBZLUAh0UU+IZlgnjze1yiivD4MkKbjtG+6Ajw3qfiNFBf0J7nTqlF?=
 =?us-ascii?Q?o0Yl6dzMYNmzirjWx+wA3AGpfC2nxzCF1N7s3Jf8dhruvYYLxk2Gc172n2Zt?=
 =?us-ascii?Q?KgvS98g2U0DvF3zY1iJUy36iy8WTEpIonM8nQxNHxjACabipTILwsTZ7Ps3Y?=
 =?us-ascii?Q?pUElQR54/03ZQ117B5EmyRFM2i6ZR+9rlOFyhNYXD0hGL4b+oVwQG1elkGYk?=
 =?us-ascii?Q?0CP6QgdH58gPpKxrvtPGAWWG2wCwfvnGBzdoH7spT01CcVfDmSsARMxioaiN?=
 =?us-ascii?Q?m05/hSQYRYmcpSlGx6RidPAdp/40wORMOI2Q99tZVaWis0ZgbJbozp0+uFx1?=
 =?us-ascii?Q?LI0wd3Aopl+Qm3i02CyR3ihc18OPPC6ZBnbfOX8H8WvhC2UTPv/u9VcjXuuk?=
 =?us-ascii?Q?r0WoPLsLfC1/VGExqc5eAcUbJCWPpB40OhLAJ0OcE7nHmoMpiNcpZlmQZDub?=
 =?us-ascii?Q?pJ8FvkHdfSs/DpPd6QXNHhbd+XFKPZZgd2jt7k+3q6DPV58r6T/NvLykhp6B?=
 =?us-ascii?Q?5Kg21gEK2XBzODevQS1VnnlMkI6IqELGb6datBk2JfV99hIxv1Xvg6zDw66K?=
 =?us-ascii?Q?xPWJhhtr3WporTXY+ZbPPWHo7V8A2LDVxmDEd9xp9IQu7u6M+FHthRqmi+/u?=
 =?us-ascii?Q?s+91+kf7RoabAahJ0wxoqT88ttschL3FznFKOdL7pC83lvRfbZwYRz/vKF8e?=
 =?us-ascii?Q?moAneZaxHOpYOvFHMHO4bNDtHp/v31wIvwoab/J7f+9AWHnu+6bMspJFTA0o?=
 =?us-ascii?Q?k67Oh6TJKihoJiTAnZUTq6znIDMOLQW4xpz6B5zFYflTnCBds+ZkVLJ/V0St?=
 =?us-ascii?Q?Dt8/+pcPCsW7QlkRAA2nrsfwc+GSbL1rXcSBxQllFDzdLdPbv/H47QqdSAJD?=
 =?us-ascii?Q?N60WAe2mDVmVelv+By/C4is+cU4rzaX4q342ogliZHuzfjyKS94HvVmlWEeP?=
 =?us-ascii?Q?b+KGzP4Ojya5hqXFxtS92rXb4IwK/HW4sd2Bxup/pwm3mkau7PT6s0WXPJC0?=
 =?us-ascii?Q?KYZ/D1ZeFHdbsAdHL7UWQa1U88sKLs5U39cs8xRTSHALQsGkXYhNdMGzlTIv?=
 =?us-ascii?Q?PA6A8bBxLA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d348af23-c7f8-4e58-33c8-08da4f6b3ae1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:38:39.5528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 381ZIHUycpSz/STVtjNK78wJJ/fpFdp3XPC+tqiP1NIPFvgyHYmtQsQipJR+6Ij1CYgo0SJuvOy4O+rCHbtKzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5739
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect property for media blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index dd6ee0a79cce..c9bd2e502b26 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1065,6 +1065,18 @@ media_blk_ctrl: blk-ctrl@32ec0000 {
 						     "lcdif1", "isi", "mipi-csi2",
 						     "lcdif2", "isp", "dwe",
 						     "mipi-dsi2";
+				interconnects =
+					<&noc IMX8MP_ICM_LCDIF_RD &noc IMX8MP_ICN_MEDIA>,
+					<&noc IMX8MP_ICM_LCDIF_WR &noc IMX8MP_ICN_MEDIA>,
+					<&noc IMX8MP_ICM_ISI0 &noc IMX8MP_ICN_MEDIA>,
+					<&noc IMX8MP_ICM_ISI1 &noc IMX8MP_ICN_MEDIA>,
+					<&noc IMX8MP_ICM_ISI2 &noc IMX8MP_ICN_MEDIA>,
+					<&noc IMX8MP_ICM_ISP0 &noc IMX8MP_ICN_MEDIA>,
+					<&noc IMX8MP_ICM_ISP1 &noc IMX8MP_ICN_MEDIA>,
+					<&noc IMX8MP_ICM_DWE &noc IMX8MP_ICN_MEDIA>;
+				interconnect-names = "lcdif-rd", "lcdif-wr", "isi0",
+						     "isi1", "isi2", "isp0", "isp1",
+						     "dwe";
 				clocks = <&clk IMX8MP_CLK_MEDIA_APB_ROOT>,
 					 <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>,
 					 <&clk IMX8MP_CLK_MEDIA_CAM1_PIX_ROOT>,
-- 
2.25.1

