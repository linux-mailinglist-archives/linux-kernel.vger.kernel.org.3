Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF378571459
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiGLIVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiGLIUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:20:52 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20082.outbound.protection.outlook.com [40.107.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1FDA2E47;
        Tue, 12 Jul 2022 01:20:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrSmjqrXxRTEbSMgiI9U9D2yFcxvHbWVDEnl94KAts/LmyuUmYRttG7yQL8xSovF1DQjQhXZ+jh2u4oAPfVn6cTSOmLAi9QEtS95qO1xS+At02innWj/tvDUCOQCOGU7USBzV8UbvD5IaP0r1wLQU4emE0ctP5+5lUBmOAklgLWftlWxxNLNKIuU6bC8LGqJKipkpU0J+Kb9F7QKbumehY7Vl299ScHRqw9zgclnMvHj50zVpC1nooT4z2LZV6R1pMMG4UI55KSOW6R2UbkXHSbeoUahf6vhw+ihzOD/d9VjT7Zm0izqBvMWtyPEPxjYdfNiPw2srQfZnmHq5+AMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfa5vQ+ePkVfuiBBRalWHVcNTV2Hx72NEQugO0H6P/4=;
 b=asVxoVyUuv4GFbXXnibmWS3YL1yddFF9w13m9kBQy2Yd3vmd5IoYk6z0yoVeT5wzk2vgIJHnwEg0n5mJBx8E/3f3uHllaMDY8KDLGwfR7Fh+gFNEB2XFzdPMR34ZRlLfnia788oXMjOkOEW1DzsVzymJW8eS1nDltBQsAMU797wy3U9jGIGF+quC+fOb+e1LZtHKK9oAURMtOp2yNuurnF1dTm3OipKYeoGvNxTwssBXZbSFk0NOP9IIArdm3VDYQ7BIb/ULBeJ6CBRHsLt49bNgHZSaQN42f045RfPPqj1J1h6JG8YnRX23GxKEdk/H9MFHxAa7Ix4fHZPhNuY7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfa5vQ+ePkVfuiBBRalWHVcNTV2Hx72NEQugO0H6P/4=;
 b=L2atdjehwIErYBEHLOeSpUrgJTM63XsIVEEi+z6c0J5b+socyEqcI3IGGhyJiGXpPBFhxF8xipPpc7Int+0bdaTojAoBgMR08f3ZMhyLPDKyYtK7gwVtgzip+d2rVN5BHrdy3X+bpIhpjV108/qHMyDit8uLL5qvbKa2yXvmMjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 08:20:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 08:20:36 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/6] arm64: dts: imx8mp: add vpu pgc nodes
Date:   Tue, 12 Jul 2022 16:21:45 +0800
Message-Id: <20220712082146.1192215-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712082146.1192215-1-peng.fan@oss.nxp.com>
References: <20220712082146.1192215-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0217.apcprd06.prod.outlook.com
 (2603:1096:4:68::25) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0657302-f4f6-4289-e766-08da63df65c2
X-MS-TrafficTypeDiagnostic: DB8PR04MB6890:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H61kBalHAG/e6Ji6Y1eOMe+jIME4/3NuLLcZdBzTBvVqdw33InKPHMUIRifF8/sEbroIx2R0jO6hZindpjK5nE/+t8RA0bDMSSFA14/QF+SoWxtQ3VgUp8z7E/r8y5TxfNfl2+xvmNgrmEmfZ3i+8E6mct2cIjcGKaq/CoebAnEvWzPmASUPMBV1f/umLG0OkCLf1qdRSewwftgxAsuqHMTlYP9aHh1yhMGhZxPphFV5RZj1GGcoDca9ScISO0Ja1NakY7vqRrdTGW3vw0Owp3k1oDXj3Zn7wt2EzDOBiBQb740xv+H/5QuQrMnGY6Djip9J66yFtEMfAA2tg/I5WVbOQmmgzRPrs7WRHuh9ehXg1Ama6zLCTLeSatszJCPovX2lAbN+GtaHjWz7AiutwVlkGNYdYJj99XATeloXSuiQ6esnE2JQ6MRsmCL4aGhT8TRz38SSEj51OQAhFCZ95aC+yGWat8SdoCuh2XsUzZrzzVhjItbhpijwHMqe7pYcDyLkihU3GhzjGb/HMzyKOr0uaXbbCnLEd+XxA3gfmfRpWOiiX8b89gyFN0qddrQve2s6FUduSGFQ0icJEVRwD4Ego0APzIh8mb1kygpPhaR2V9fqWjM9qR0NWS/4brwggPmgx/G3//F26BIDJM1xzzQgrC+Pz8isxXrVcSf3DI3VcHS4WWhN/Z/RwhLgzOIcZwQdjtOqtPA7GIPMxjO1NrheIPNXCqnCDK05++2f9m7RuMb99vl36Tj/ORK0yIkp1AHuCCRV3DKeIA/hBSum1N4WCVeVVk3/J1Mc2FOWY5LRgqFEi1IgqiO6CN+0j41TtC4n4wAijY7XpkIZrVmf1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(83380400001)(186003)(1076003)(2616005)(2906002)(38100700002)(38350700002)(7416002)(4326008)(66556008)(316002)(66946007)(6512007)(86362001)(5660300002)(26005)(6506007)(6486002)(478600001)(66476007)(8936002)(6666004)(8676002)(41300700001)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bsZAEb8u5z6VLxAfkDjvzdSnKjKyxijOgwGE2GzDDcK+w2hzdq7ZtXkz+Z7I?=
 =?us-ascii?Q?XZyzjFsBuKTOFcaZaOW16Hv9WE5NWUrGJB/Nlm75f707jj8yBsJBoYBuYx23?=
 =?us-ascii?Q?a9EcQXZfw/DV1hBo1JikJjLsOqTtrWQLJOuTajdp378+84H6CgcOT2/x9EcD?=
 =?us-ascii?Q?5UUp5pVM2+/ZxZsG2tzBdLVNpwkyH3DI36o6JHMtYAXjT0VLnpdcy7NZqyQo?=
 =?us-ascii?Q?GTs4etT/lswzmvm4OgWU7HntMvxNNyLzbExy61hoakevI3cGw/ErFP9QOkGY?=
 =?us-ascii?Q?HtTJwT+wf7W0kgB/Eh/hwtMZb8DUZ76SawswajUPeVafr4ZqYyR2Pv6+KPpT?=
 =?us-ascii?Q?JPrdUcYAEXugCQuuFwVzOzRWCdwGfgKpK9bayCTw/BXHrmnMK4ccLNH3Mexo?=
 =?us-ascii?Q?ouH4mUr7Z2M/11RsK+fFSaThdLdogw5msZXkgFnF+QWqvmkZk1SaEM8df937?=
 =?us-ascii?Q?oSgJc90KK/U6KDTSSruV6Gs0UEll1pmapwuXNTnxmhMGOWIm5xMi9rUq5Kzk?=
 =?us-ascii?Q?n8DX7DFd3VQHb2twinSXw2riWl0VodsyYHej8HeUhpj/U/qUuZ4uvCwUDOZP?=
 =?us-ascii?Q?kS0McJZ8ZYwEF01EaS6GoYm6Zc2bLkVxynfJIKGbNQg96PeNjqINyLUOQHwL?=
 =?us-ascii?Q?hd+Pdl75Ogn4y86DDHW2XUPz5GEu7XKsJKsWb3ovDmyFjb2Ys3yPGL6XyLIy?=
 =?us-ascii?Q?WffuG1mQaJFuJfNA18hxYdFVaUcVTvF7f2UnXPnuebACLjGqpI6BHKQ3KDpA?=
 =?us-ascii?Q?S7bf/Qa38Sqk7K/buAjZ6U0K+YrR2NL9EALGvEyMG4MZXGJJFTLA17+0f0Gg?=
 =?us-ascii?Q?drkVxxmMiKW6LDhTcEYIv2/WT1kW0Ve0B8zXiEC1a699vFRcdy0jMScEDSTJ?=
 =?us-ascii?Q?mXb80q3SLKQ80dfJnw37OGCRf6YuqPe9Zaa2xcoxR0zthh7zoLA+Kz8u6P/2?=
 =?us-ascii?Q?vhTwCUoKvv+1eV7xR8i6R6DmRab1omQSSpv3bZ8eFL8IUlgMDkjIqHw2kIe5?=
 =?us-ascii?Q?rOe1Npci4lQ54D0d4tSE9N6y2q6CZb3A4NV41po7QnnwYxZI2HsvNAnHgvYo?=
 =?us-ascii?Q?NXCcNgXUb0ds/v3YY9EtB0EyEOlweDOoFDQaj3PoYWriiGa+hDVC6djZYZgn?=
 =?us-ascii?Q?aamzQq1YrGBLIswY/KHcLswYC4vFw5cfmc2jJNOpQu61BPZKbQXY0UimNw3R?=
 =?us-ascii?Q?g8tTIUu22YbS6BwcI64vbjfZ4IWmsVgE+RXcyUptDIFIBrDWnnlRl1pteJ5U?=
 =?us-ascii?Q?g4i3rI+ZbnO7/62318l3zjVMzRn4g5pN3bPHeLG/u/pyDlTuIRLHKD/J5/GW?=
 =?us-ascii?Q?zgMgc8/4hLxB/4L168WHccz6S2hC9xzb9loreyCYDzcLWJorgP7Sv0juNH1E?=
 =?us-ascii?Q?MALmrdSLsTH31vLPr5SKSzNPjfIdpkv+qag46JCV7dD7Pv4pCICFTOGs4xWb?=
 =?us-ascii?Q?XbehJXoon3rNAQ8fuI5NIeCQXn9kU+5l7Uf09fYUsXOZdMj+E2u/pyC6qF/K?=
 =?us-ascii?Q?2uZZa3I1SE0b/UFi50fNQVU8zo3B6Lw5ixt7nMbfApoxbmjqFXULV0N4t9rm?=
 =?us-ascii?Q?GmX2y+tcDWi/P7vsO0a774Jy1tPk06B3MKg3U18W?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0657302-f4f6-4289-e766-08da63df65c2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 08:20:36.4364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOeCJmKuwfdBDEIgBYl927zXIaJUOk+UrzuGN2/dvQzlG7p4uYxmCL/1vP3sNg5ABqJkG+bZJk1NhNHwd2m2EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MP PGC nodes for vpu, which are used to supply power for VPU.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 0b165f98a82c..fb52404f4cdf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -598,6 +598,33 @@ pgc_ispdwp: power-domain@18 {
 						reg = <IMX8MP_POWER_DOMAIN_MEDIAMIX_ISPDWP>;
 						clocks = <&clk IMX8MP_CLK_MEDIA_ISP_ROOT>;
 					};
+
+					pgc_vpumix: power-domain@19 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_VPUMIX>;
+						clocks =<&clk IMX8MP_CLK_VPU_ROOT>;
+					};
+
+					pgc_vpu_g1: power-domain@20 {
+						#power-domain-cells = <0>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_G1>;
+						clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>;
+					};
+
+					pgc_vpu_g2: power-domain@21 {
+						#power-domain-cells = <0>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_G2>;
+						clocks = <&clk IMX8MP_CLK_VPU_G2_ROOT>;
+					};
+
+					pgc_vpu_h1: power-domain@22 {
+						#power-domain-cells = <0>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
+						clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
+					};
 				};
 			};
 		};
-- 
2.25.1

