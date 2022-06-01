Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCE553A109
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351365AbiFAJox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351369AbiFAJoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:44:37 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A72B69B63;
        Wed,  1 Jun 2022 02:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auyBYUYM4aV9YEX5jKNDWlLXhvUPdzfPZgOrBWeeVqE4Lx+jvSKoApabTeKfBY/EzX4gfz+6RCKtxgK7sRGAR3IILlTCSxkmSuVB0TfUe+xnEqgnArc2oPLCWGFyLGeoUZMmt9Xk2C6uzEE6Pt9nbaNQE5YcsOIZF7HjNF01rGYt6fsYtr3qggzbg8Rauz3etDStm50JiWxYGT5t/TsquVI+dSv9iCppwQTuoI1NhEK465WdGLuxRXNsYP443gp3ezYlfwM/BewdsaTogSoXE+wsNBiAFJ1Q5TYE9I2tEmwuNo7Ds7Y8bxOnmgKjiQjmGTA48wDUiBYmJEdEZWsmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Z0PZbRevF9S2O9h031bIrnbw2fVL7CN/+W+4QhXhDs=;
 b=AMt6lYVbiL+3vhMcPd0veWAA20c3QK3xGpOrdrVvHH1ClptJyymQBlERIIPXD+IfVI77i/CtZBOHoGyVhMh1XHg45VRPiPE0UqmKZT01hmcLO4h5G+oxpegF/4VBiZGmLJyqnkejZooRgteJ83zBD1TsYHWgi31/jlwbXVPvo14iakOpWIrrzA/lSWjHN52m2oUnpVcm8LBAssvgxf7fyGGr/RAvEKtxogbwXVbxmCaW2avZyJGg8HJxoua/75qqGzNZmSPdulKseWSumAhxcrq8/1ByMBXvNj34+bjtVvwlXrADAi+WoYj8zarX1VUl/gToEpE2a1IFp6hDV7i2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Z0PZbRevF9S2O9h031bIrnbw2fVL7CN/+W+4QhXhDs=;
 b=AD0yLW2px89H+6qf8IY+5Wpzvl3tYUMmLBHadML/ID7bozbOo34jGw9Vxl1+k3LTujkfncfVi2shpAF7ZWhO6hc6v1CSJDLf3a9CUblZBwkZVoCOT/w+vlhrdNQi+K7umQhbBvcWMYwMdRK3cIha27KpHE/EDC7FahnqP4Z3/hs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB3PR0402MB3897.eurprd04.prod.outlook.com (2603:10a6:8:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 09:44:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:44:31 +0000
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
Subject: [PATCH 6/8] arm64: dts: imx8mp: add NoC node
Date:   Wed,  1 Jun 2022 17:45:35 +0800
Message-Id: <20220601094537.3390127-7-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: eff4027f-86e8-4caf-86e2-08da43b353c8
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3897:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3897A9046CA8EA9DEB61F64DC9DF9@DB3PR0402MB3897.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22whfOEKE89HPCcw8ITc6vKVzDkqpGoQabuMcFQiXpPN51u5BBO6nkdn8pT1NtjRqhsipLKe9p78q4U9uGqGO76Hif8qfpnbrMW8MeB69Oprmu7cvD4Aawu7GtEL6OydPSdO6DgIJXe38FqCjJ1Bgg/B0VleCCb7f/TIPSyXpgG4lddq3RuLD+V9qGL0TzVUJ4LGTaOA0A2J8RdZ2b0Ud3orwcXTLfKRXgF5woChI0tWcbpGP+6Y4IoyTmD9Ak3oLPdEzFe/ZglyAQApDc7AUzHv5ms3qvuhVz+aukdzjzexjezt1kZp0RLrKXeCIh39JWaSaO0/746PGtQmqWYbddYsdwGiM11tWlFgeLY/dkpMge+ay1z+pO46sNDunIL+Zt122H67I6dMVFPHouf84wDiImW2Lg2qGaEWfEgXmANN6OELghrpuwl7dHYuD26Bdkolncefi3KaL4xKX/IeQtDZqc5DombQQq8FZKXzD+xeZ7ICGs46bhjqFM2xpBYI4UgltozkocMgkC3D/kvH3WKQsGMtPXS9/wwOCepinuuCgmlsM6fHkPOX12LW+sxVfBvfk2Le5XMB8yPVLGV1hwAtkHj6leeoFeEPuqfRIRxz2PL5iKth7HN2cQoGeXKI2vaOV1OAfe37ErDPsNLjqGx2By2HHBWsdm1fy2lPdZ2sx32fRQ5PMjT1J3aMqXHx/XDJ8U8VGpdEcJCqNGC1NFcxArLR/uiZAOk9G5jA6bViMqYmrUJ95ekj9JVOAgHK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(66946007)(2616005)(86362001)(52116002)(2906002)(508600001)(38100700002)(7416002)(8936002)(316002)(8676002)(6512007)(186003)(66476007)(66556008)(26005)(4326008)(6506007)(921005)(6486002)(5660300002)(83380400001)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j9paYeOUyBSh889ZqfUsmSJUnmoXJX64aUeyRrIKNRuXYi/9Ej/Lf5ws99qf?=
 =?us-ascii?Q?Lp2zB4cdc7uLw3nLys9K8b9n2cMRc+C4FQ62JGRuDR2hwEW9RmkgeCPU4kPY?=
 =?us-ascii?Q?/O3uNIZe6+iUFNU7qgCJ6TkhBmzXxrDxFeWvaJm0K/pkoWGas3mQ7PXdL/n2?=
 =?us-ascii?Q?IAGGibCMujzpDQwS99DeG6vg08z5T7CekuoM0RfMJq2uWgTHio0U8IRqZ0j8?=
 =?us-ascii?Q?9O8hN5Jmgli9i33kcTyaaxpvek8WObub1N0c2TnGMK8NAyEyjf7CMdJQXZG1?=
 =?us-ascii?Q?Qdfo1zZE/ZY9VVV2zBUkC1PdB7IQDJLDSpdwuL9cO4GwdvHs6QPpeYnJjrH6?=
 =?us-ascii?Q?8mVCmXIRCdsiwmXxFi/IGJO8kIgFxGU/Be898G8ALXOVr3z20Eweehkt3YTY?=
 =?us-ascii?Q?ESre2HIVze+Eub//3cdQKDKYAI1n5b7C2GNNL7X7vRNzQgO7PDZwUhDHJSCu?=
 =?us-ascii?Q?FSHKUluwlFxMnB5mbhns/3iEZaaxd4Dp6Z/CANglUULLQBeDZaWlEA2PQ3Bo?=
 =?us-ascii?Q?Ejfzv+PYA730+3ad5WASUvO5Mx7GecNxBWtcAXo3hl58lQiSeYLUdbSr+99Z?=
 =?us-ascii?Q?cfqNcR8LmaMqx0glM2jf9fggIv3FgiwOrJNZA7ZiATthdXBnnJZw5868cpWU?=
 =?us-ascii?Q?o799IeNQ8BimI5zteBx4cFNi+G44a26WO2b7DaFzSRBJm98b/rrdkADBFgKP?=
 =?us-ascii?Q?FFpuT0rCZs5oFNTdUi3RSrwzPoCcQduRBHTY6AU/uCnKypYVyW7mogCjjWCX?=
 =?us-ascii?Q?69fBKSxvMC8gNPffNxCb3OWzMPJbgAnHh7/tEj2FG94WPQTMAKZqRxMczlN3?=
 =?us-ascii?Q?iqpg4I6sh5vcHpSXXG2K702cEEBlWnGzWOZohHomIJUtJvJaUcx/bPaJV56X?=
 =?us-ascii?Q?jZlAt34gPl2pF0e2h/8cwzIVE7JDB4+X50WtJD7+xReg7Du7v26/X8kBNQyv?=
 =?us-ascii?Q?2ADyTOTWnpgAhLMwN0IcVADV8I0+AkBsq8UWIGERsAD6ZkT3z2TS40Eyc2vH?=
 =?us-ascii?Q?JEtLHXENHbMzmfbec7lrShfpfpLiYOtiXuKSnT06O515jIOEObpj4WvbQxNT?=
 =?us-ascii?Q?clKGGInUEc+OfeMzekO7RWNfiBJs0x2RAvtoNra99R0Gpgr453XF5QFHYmxq?=
 =?us-ascii?Q?XsyAxbjc59ocjsEXG/ObHpQSpNL3qEf75Ef2QQf9n7JU2EwHakd3G1trYR/Z?=
 =?us-ascii?Q?QczDmm2ETbpsgvzHxKD4RblKFxoRzqik7jp9hoWdO68MCKZpsz20x9taH2O2?=
 =?us-ascii?Q?xq6vYvOdq22D6ytD/7c/mw7D6kymkN4EzuUtOgXlS6R8OFR1Bu5T/z6CsRrs?=
 =?us-ascii?Q?1ZPTx5RgK5+9vxNrBsJhjJSTgS/sy06XajoRxlYVLk6rkXY3Hw62Ec7lqGB1?=
 =?us-ascii?Q?7ONV/TITygZHPCly60D35hy0IVshRMMoZOu2ECYu98wE3dn/wc/if+JqOtx6?=
 =?us-ascii?Q?JqgvVBsUd2YmaXUcq6XAPfQyOH3X8LpJtRXg0RIvMMgVXDOnC2ji2EqvKQrk?=
 =?us-ascii?Q?SZK1z7KTPuYB3+AzimNOgEZLD0ZhtgqbOfgoVmPWn+v/WmBTscu74OycD5PK?=
 =?us-ascii?Q?pn3FlldF4B8EjgUKZBss/oTasQ7ojXyegXrPLCBiaunARXyjx7q+PP0qG9dK?=
 =?us-ascii?Q?MtCyj3hh6GzQk8Y9yKr5zQAiL9vi8XXAGK496RIgZDcTbOTQCh9MjPU2hy7x?=
 =?us-ascii?Q?lhf20kpG9jVkRCBREBSQXMvhL+NlpwG/T+dalGd3AYmAOdO7/zrqx7JbsXR/?=
 =?us-ascii?Q?pACQaXDnhg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff4027f-86e8-4caf-86e2-08da43b353c8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:44:31.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OTq0t6OiIDz7focsdRLNyHZmD0Va7ScmpaKS96x5kD3faw5zcuojFXvD5le4usbp+ZvFE55QJjxgXKSkzGNOw==
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

Add i.MX8MP NoC node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 2a1c6ff37e03..9e9e941a8906 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1019,6 +1019,27 @@ eqos: ethernet@30bf0000 {
 			};
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mp-noc", "fsl,imx8m-noc", "syscon";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MP_CLK_NOC>;
+			#interconnect-cells = <1>;
+
+			operating-points-v2 = <&noc_opp_table>;
+
+			noc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-200M {
+					opp-hz = /bits/ 64 <200000000>;
+				};
+
+				opp-1000M {
+					opp-hz = /bits/ 64 <1000000000>;
+				};
+			};
+		};
+
 		aips4: bus@32c00000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x32c00000 0x400000>;
-- 
2.25.1

