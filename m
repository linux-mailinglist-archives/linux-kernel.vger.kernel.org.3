Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328AD53A108
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351443AbiFAJo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351416AbiFAJor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:44:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B887A33;
        Wed,  1 Jun 2022 02:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKGbg2NEiEGRWfi6hNBHGCWcwz33JmN8zR186+I2+o6Qu7MQmAkgU8K2jEVAAXg3jf7Xu74YavGmyRld5i1+arhcdcn9b65aTBjFvbLuiekbujGbk2KiByTh353sAztE+MmIZTzqP/A1a5hIsASQaWae1IoA17qDYr1Fba2IOo368TGLWZz3dlb8J5qD+gvKVuWT5l0rVuW5e1QLBLrfDA21klNQkPUmRtQzGXj5y/eUtweB4zlj8FMCnAaRd/bcxS8l0+o6cDrxj0WaxKL9FLpmJIA78ZbZo9ptcBck6oNhi95BG3i9jkzvqNZwKSuxhBcpcAgH9XkTvw6PSlRVXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59ZUhN2rWiP/5wuzIu1aesEX85+A7ZwJC1kogspT7fo=;
 b=Fnr3g6Wu33VldopOewbNTmCUWp1LBYGoK6go0DCMmCvOJbD8WAp7BIb7TxFYXN951Z/bh+qACOInjfJh1KHWgRgIdYBj9CwzkddyH2aH6O4CiQ1GeC5Yda4ouZKjHOE9Is1xYchqSAPyaqPSPTzHtXjnpK9fA6XRomKt9D+tV+nB68zmgoI464DH7Y9Sv6oypob05O/ylOSwtIsvkNU003tzBdRSqdeeOiJaMIrQuA35lqZJE5JCmu5bY2aL6/QlC2zmBGnIZzjK1jA2hcMeu2tr7wz49TBmzu2UwzL/d21CplOozj2aeKAmYFu7gkXUBCVkhF7kG2Ctpn7n+E4TkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59ZUhN2rWiP/5wuzIu1aesEX85+A7ZwJC1kogspT7fo=;
 b=XMtvUQFVWeXtIcg3G1rkBIrTZhqnxQ/oc3FL6owGSgqsu3rRo69cD420+hWk2c7e999L66XpwQcUGwJAYkl5gGMGvHr1wqrx5XqEaT0pB03vdpxq8tEW4ZKzcQftNyi89k5R8RZYqNUuqvgAbLnOOqkkwNsrkcSb00iWvhQVx3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB3PR0402MB3897.eurprd04.prod.outlook.com (2603:10a6:8:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 09:44:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:44:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 7/8] arm64: dts: imx8mp: add interconnects for media blk ctrl
Date:   Wed,  1 Jun 2022 17:45:36 +0800
Message-Id: <20220601094537.3390127-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
References: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f91dd38-ca90-43c8-fdf8-08da43b35786
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3897:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3897D75665172C48EF923946C9DF9@DB3PR0402MB3897.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: du0T2N2tz3xxTlN5vM+e5yZWccw0pXAIq5dP4nzgs1BV6bGCPQzQXIOAt6s4AjgVNiEcZekoMON12rFuDcofmyK1N/fiIpSK5IJvpn2Nz4gdBhm3Lb3owm2w63yVWGdfz5L0K3VlWjBKJl0RvLcerKXBSgxWY2hXzYVXwKHX/Uet6D9K0bdiLft11eoIAWhYHYalSkY9caSnNlbP2L/tzT6YP9LoNGm+cWutbyYiCBAEGyvwx6kb8EwYbymDgqnjgGdEGNZqgqpPUjQ5kfOzDr3fB3ixXt6A/Mc3/P2qI1r3pZlw2Xi+1NsB8/SIow9S2ODuYLGBLT2kBJhS0T3LSC7qoAYSZMQB4dsT1N4GobjGej3gRhvzwSYvjTR4PlYmlGKNrudKgKxT84wiNiJaXdjRGS6Xtpk05ddeuL6I+aQt+Eyr6fq97VGT4JoG10UomJ2W+/RYDnALduJTTBlYFg4GDIZdIx6aJZGponwAHnkdYpKhwupb6KK7XgWi/k8XAYy93NKMTtoqaUTKPCuSZLM540ZsQbsmhI0Ty9Juyk4dgZmIiWxXzMw2rE7LwIQvX1xeO3hVgBp7Rq26lBinpCdO3lCAOcXr9CcUZC1TUH9z4xRsPj5WvyeGw2B5Rm68aIdUE595Bszt8kaKPjLiPxfkh54JMu3/fuS3yNrdEDzT2el9IuQySjlgqasJ6BR1NfhUblUPX0MmYZzI+n9vYY4xx/Sc0Mfy0NU0tBOUqQQP8xp8fL6pI3MRyFadZFPy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(66946007)(2616005)(86362001)(52116002)(2906002)(508600001)(38100700002)(7416002)(8936002)(316002)(8676002)(6512007)(186003)(66476007)(66556008)(26005)(4326008)(6506007)(921005)(6486002)(5660300002)(83380400001)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PH+TPx+nxdhYW/tfOylLi0//wILf4ykeuApeK/guLUoZmZSIWE5jh7EFQ32I?=
 =?us-ascii?Q?CSs/6UYjRKWKM2mmE1nV0hpApYgUta+8g/L2Rm5kpT6vZX11j9JmrnBG5Z1f?=
 =?us-ascii?Q?77BmdhnklAZtKIIVX8Y9vVeVnzoXXLY/WTAEtQOSnau+J4GlTuuIAFTNSFP+?=
 =?us-ascii?Q?nSJOfPZyKro7SOAY0mUt16LRnQbORwQ7Kr0IhDNU+X6zsTdSlMnr5hNa70dp?=
 =?us-ascii?Q?kzwMtspfER2c9rObmDcXJrVtGT42Nj7EtDNAuEoFe6OJNxy5JEJnAJJr5/fX?=
 =?us-ascii?Q?WDB6hcny38uAz4eJviKvdnmKF8Q+AMBW+flnPVGGRWGE+Rl8E7/D4tF+wfmR?=
 =?us-ascii?Q?CGkJEcJdZBhVWEsPrkuZozCPNzGx8MnU1UUwLD33zNTvLhDdGn1mt0ZWNMuO?=
 =?us-ascii?Q?0rNRGUI1LCpVqVxntP8SQe5hnKRLeA2/1zjLKcYCafalw47RwVw7nH9e4nvT?=
 =?us-ascii?Q?nH9MsYLTXA82X5XzswdpWd/3dnR5R87ZY2Lz+eTlhbKYDLWxlgM24FJnUN23?=
 =?us-ascii?Q?jlBq3FvJdi7wMwd644uo+wU0tB+xqGomPZURq3mi+tErtahckuuTSOi69O8g?=
 =?us-ascii?Q?heH3ui3rV1W0gRVJppYT5jKs1KFXvsF0M/PEUMv7q0NNyyGgwTVUyg/V1PhA?=
 =?us-ascii?Q?nwoQLQy7ijUkGnO83U7a/jxmoMRjbBuKjk+oZpZnX1DSknnkU3pA1+kKszlA?=
 =?us-ascii?Q?pZKw0IWYeLH9S/dVyKN5vOiOvpoefA18wnsuVCv5kGfU9vAuDU7ns84Gkrz9?=
 =?us-ascii?Q?oqhnOMmqRU1elF3u2wnhjpsZbEoyHDEXbSodyyIqp26P3U7R854c5e95jI8z?=
 =?us-ascii?Q?OVVAXCUvLzBscd2Evq9wwRRrIUHKfI23of0UMBQdemKNVw5aTFNCD22KSvd3?=
 =?us-ascii?Q?KaG6l0o7EG8hxSn8ivuKGDeA0wveJnx/O9HpJptfuf5iwZ68cTBjGzcQZV8e?=
 =?us-ascii?Q?+3GUxJaZISN3oGmdJPtanHmTjuT4qQx8shBGLwDBsVyOH+AjPPFN7WWS9ZBV?=
 =?us-ascii?Q?hDimMKT1fDJmJzFTIqK489WB79ziDOpIUerIdNPCrRISNQ9LbEMHiP1+ye8s?=
 =?us-ascii?Q?U7ZB/rBu/oh0BPYyldTeWaWun91YPkBsm7v9k6/rOp1HgOgLnRAjXQ+TfeM7?=
 =?us-ascii?Q?MVJg9+9uM1KB4NR93vOahlNS657QlNq8e7cM3MEmQrO0sUTgLVuS1Ay5ttkN?=
 =?us-ascii?Q?H7NqS6I90Fn9nL9NO5HGrPpuO/oIkmCLxLc2uCIZdkgUqbtXYZI02pgLt+ey?=
 =?us-ascii?Q?da+wXaVLlYNraWlSErroiL3JiSIw537vcrwa7huY2flO05wKdeIEOgaca/pk?=
 =?us-ascii?Q?RJXSu3Oolb8rTqwm99nwz1iEts9CiWqjNDTMUJ7cHTRrUl16Uu9+h2evzytq?=
 =?us-ascii?Q?4FwhlP5o5kxVS2csdxF+LUKMGlLTOiuHv66eMNNl2j+eBaC+c9TU1G+0mbAI?=
 =?us-ascii?Q?R6xdenWLhoaIzWFlSqJF3vYDsI2Iid1cfYP/mbXitAAXFmmje2q4Ya8F4zO3?=
 =?us-ascii?Q?JRgDbLXCkFAla4fBqRlIgB2xVeNTD3a5I2VYU/m7Xmt9RZtavI4FrrL+Z3Lf?=
 =?us-ascii?Q?g7RCaa2vthTR8QM/oLJIOZi6Pjdb8yE1yKwNiNZ5JI33H7jATxW2wRAhczx/?=
 =?us-ascii?Q?xRondfoBO3bqfKLlFWCR9CrqF50RBmCaFwdZg2PqibfUd9ipGslNZWLNHwIi?=
 =?us-ascii?Q?88PkYeEhNZbuGPOH0ZRsYFwKx/xTyqyZKaU1yXoAQwEiAD1UDTYhvb37jUkS?=
 =?us-ascii?Q?uYgMaUkVZg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f91dd38-ca90-43c8-fdf8-08da43b35786
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:44:37.6454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2KwYOvurMcnWGxVMxt0xcjvTf6tTM23jqmvesCBxM3fd0eNaQdrBjYxI/Mu0OgMXQHNnUU8CoDZyFqM3hCLaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3897
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
index 9e9e941a8906..53813f6766f6 100644
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

