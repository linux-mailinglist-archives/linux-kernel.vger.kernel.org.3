Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390C757145D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiGLIVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiGLIU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:20:59 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20063.outbound.protection.outlook.com [40.107.2.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914F8A4381;
        Tue, 12 Jul 2022 01:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjLTRHvmUKZz7z5by7+EdxU9MD6Ng+nTGre6V+HSHgzC9KHqD1pNXIcHTZUdsPGED9BWym0jT0mar5yQNsnnSZYwkGhoiPKoXzW2XnmH4FtyKLXn7XkVSs0m8Vso23haPqo8TR/fPo+7cVwsgLafrZzByqcBNQ/HGYAfM7q+mhnASuAtEEUY7qxO7xBrvuP40+8JxjNcfP8DNwKPm+CcIgfe0UVCmiQjt2b0KM3tuNMH4buZCxtrVYeIWNnvMM2wuPpgojtS2lZO92VBn3sSUYWrlLeOFZoXysgiSUBTH8hg0LBSOutUQQ6x5v9J/EmVW8CKm52STW3jRcSg02EzLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7npUNLhZo7sommEdOQFrpBqsqT7vxwROz0+M5bRxxk=;
 b=dxomX8yW5cQVMS9SIozfjV1YIQiPvgHz7b/iKb01m+Eun/iSAgMA53MbaotCwdUrADMZD+deFKwP9xy1U8Tn7heM+K/JZLOoyFHbsQundVEiNsjqJGw3ZFCm1V7OS2XF1mZZZ7lhboQ7T/be8SHFb/WgWeO33A+IwvOAQoJTHE5AUUtDTFl1RBICE8HCO4Ede9Y0AO8US8/YZt8gdpl3/Sq1W1ITJj5hTl2/sJw+oD5i6PZdbEsxcjJ9fV+xy36ZC/zk7rKE6agaury65EOIWwRUGum+4pwbi+BgeHlccSY5IA8dQZ9DbV9Lg8YElQRfO9XRqbW5DCfIOLPn8KEe9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7npUNLhZo7sommEdOQFrpBqsqT7vxwROz0+M5bRxxk=;
 b=OtBKm0hx5ClUn+Ykgs/WCzvlGPUfYP2R/LDgplW2ZZA71F30unopNRJKls6C1Oh8jYeZzx3XtyDDo+4pcFIeZXJtDLuU0KF2lkmvwCCZX8atN6k80S5fuRa4PMfhjGPhUVcCAwte8q4Nk6X+jdsrL8nxNKK9FucO+Yv5FBkL4v4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0402MB3485.eurprd04.prod.outlook.com (2603:10a6:803:7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 08:20:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 08:20:42 +0000
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
Subject: [PATCH 6/6] arm64: dts: imx8mp: add VPU blk ctrl node
Date:   Tue, 12 Jul 2022 16:21:46 +0800
Message-Id: <20220712082146.1192215-7-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f9def7ab-6203-4991-2f05-08da63df6908
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3485:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hOUAUoSU9z8VGdcI4Pw4wlAgAztgNlQkDLNTECMziTPKXS+XmV1iGVaJUgKBUwhZH1o8hFBLyd6nUdMuX2+dZH6E0RLqGZKWQmI2A0tQo+azFAQ9kAG+/XfcFwyKObbwOMcQWN3evYcvSjpUQ98gAg+JrkxVKUXR3YZlADtmFMXc7i2IRLLDCFdMGlUCmqKz80q1Y3bNowyuioHEq3YCM/3ANEfaueqzVztcKigxgD5xBKlKe4RPQCpeGuykKYSE9Cne01kqJ9wt62kYUjWTnrh9s+/VY1EODOF98+bV0ian8XCHyxQiBEQ1nUUhXLcwnLOfsFUw48q71sm6kPa6Dfu/hvK9khmOf0se691o2Bdhd/Vb/0zc16/DEh+svrNYP9W6GY8L7VOfli94K3+/Ln17giBtysimA5MxVEveBU9j0cU3GqFDrVfuYIpX8R9OgJ5IYanqJjxnnGKgkxVL3P5qdxYN+10e5J15pKDcs0zYQf1NcCPiUaME/mBLBnu6D/8Sz3HIx7KCQlzMkxRSUrW6uo++1aGo+NC2KT5WSU86QyABepr7QYXthf0HN+lvFtuapSpcyKRXK6tb6IreZSNaetnTi8P8BQTC1vaCyBbAz/r34tyn/onzz7EDkIBPWThSMW6zY3nF0juNe2E42mL2d73QlfFQC81Dz0BDi8slcU3l598oBbGDgtzcl4nu45/RTkoWRY4VIw+ZqIyqkjuAj6aJem84ShxRccnA7Skp3xHVbDnnh0XF3Dm53qgKj2EGA7xQLtMsyVkfvl5N9wicDjlND4gpNuXvYAe/5tu1dWy74I9l/dBQfkh7L9bDNHlMSbg8+kygVF2tKfDcKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(2906002)(66476007)(41300700001)(66556008)(8676002)(2616005)(4326008)(316002)(66946007)(1076003)(83380400001)(186003)(26005)(52116002)(6512007)(6506007)(7416002)(478600001)(6486002)(8936002)(5660300002)(86362001)(38350700002)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tmr5CIroYHN/guvEncAnZ+wlMIYXYeXu1zqMTd+uqGNNwR8bZw0VZVxdnJPh?=
 =?us-ascii?Q?oeR0vRaDitFkkGu7VO3d+gQeQgQZAlp5kD9ULZYupKLA7ip/p79qZ8KIwqZU?=
 =?us-ascii?Q?9J1uMgbWhP5D/0vYy/vubNDN1sOKMUGFVXB/mG08ziiFR4tUnes27QcLuL3X?=
 =?us-ascii?Q?WF9ntpTybp31DrbhmYnIqmVuPfdt9OSvc5IO0ZGwb8hVuhkDGg0bBGuYNloB?=
 =?us-ascii?Q?ONNzMoXNlv0agUQH5rjgXMgFMFatmdtcpc0ZtdJcm2V8IQSHhPyj9VI2wfdo?=
 =?us-ascii?Q?0pU2PLr9XewTmqSio+wXAXf5oOda+HlEK7eYD8S0dFmIZ0Aocgeugc1IH3b/?=
 =?us-ascii?Q?fm2ueeZVbMeom1smUPfJJZtddFGd/QrW7F1kY3EpB06rlMOYuIc/IZXqA1RU?=
 =?us-ascii?Q?IST1LPXf6BCeH3+YubMeZjPp6LJVl+h8XmN0xVIYdWcP+9kVjz6esfUJqEp9?=
 =?us-ascii?Q?h5MMxZGaGEnNpwz6QJ53FkH+wfRkvbMz9/LFZz+B0Fg3PcZdzI7zWWJ4FK2T?=
 =?us-ascii?Q?0ekOIAAbCHdXMJk6iqiWuCt0vHIsF2O0krzjuStr8SWouovOP7nDPNRkbkRQ?=
 =?us-ascii?Q?oj+Ja177U/EG5IMMCMpD6NJJJKoS5OQrvFAmW7pjqUYGZnMM/ldHpbO4MLG2?=
 =?us-ascii?Q?2ecGb/GfUDVVUwmm+uMk8Ue4p8+DZ2rOc2jFtNCI/RkEdw0YRCRCDoC65AA4?=
 =?us-ascii?Q?ubm97UtsiS79fVtVtLJ+gkCp93rGcn69gDNbMUyCZ4DWtMEZhHjIRI3eUcE3?=
 =?us-ascii?Q?a39ymbipMby3NDZzxM41k5WkejFqQmj+G5+qexdWQhpwAAyYviy07KZDUQmm?=
 =?us-ascii?Q?tzLTdaLb/HdZdheIYlXbsHMWBPoVg9ZI5O0S+bDtLm2tLDP8vyFVel8M/gG3?=
 =?us-ascii?Q?D9mOgiVdY7q5dNaiKv21ncvxo8z4BzqJr+CGOoDmdJqEf+p1DHSza3cf4hj1?=
 =?us-ascii?Q?1UaMrdX/cagx3wb5aZpAUuClXwaI57Ljh6UtI88fRJxpugTqbyXTMM7BM2uV?=
 =?us-ascii?Q?k5mRL5q7jiaYIzwZc6CfSL7+0joFAKmma0t5yQGjrGOAJnW7YEo2ad/1kcHU?=
 =?us-ascii?Q?QfmgrtZ1ZUG7sxfGJcAuSlxr21IthFPrLsl4CVL//uM/kChqLDwTy8YjOwTg?=
 =?us-ascii?Q?Pdj2D+2IBA1y4ZEtwqa05DIObv7YQxcynJzObCGAppX3uJjrXC5ELP3z+UEV?=
 =?us-ascii?Q?q+3jG0EH4V8l/Zndd9H+p4oq8GOBcJz0TknOQiqidTji+cLuvuYZsibtajl3?=
 =?us-ascii?Q?0dXCP3QNddnafnXdK7YVg3TBwPWw9BSs3Z+fcYyl7oU/mLnO5Sgk8H8cjqBM?=
 =?us-ascii?Q?Xruu6KqtOOSkzM93/DqbnPkXeBk1d3c0q2jhR6CYg1GC7LA117ktYL3F6wiw?=
 =?us-ascii?Q?1MgasL0IIQpdn1IR/KrTHtFOwd90BvPLCC/E2OknnNr/SCcTHmfhimGpseQl?=
 =?us-ascii?Q?y6Cw7/vZtaKF50DK5yQl2K+QMEdZ09UfEODybX/xwSsOjmZS255bKUnKfDdJ?=
 =?us-ascii?Q?3bDKWSYyZIovlOhrTyJXxBVG35nwpq+CYAlDPvXULcQl3X094oTgaTirQTyc?=
 =?us-ascii?Q?Qrn1SP3vhidVqOWmlMcAks+z/Ao0g7XzL9Xkb8mm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9def7ab-6203-4991-2f05-08da63df6908
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 08:20:41.8909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3IdMJs6UNWyTEl4FD8oxKjzO7qoTDWLaF0ICFJX7381CATI8P+F1h2RwG1ghaEpIedB0393bf7g1pAx0vcvBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3485
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MP VPU blk ctrl node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index fb52404f4cdf..b906aabf0685 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1185,6 +1185,24 @@ gic: interrupt-controller@38800000 {
 			interrupt-parent = <&gic>;
 		};
 
+		vpumix_blk_ctl: blk-ctl@38330000 {
+			compatible = "fsl,imx8mp-vpu-blk-ctrl", "syscon";
+			reg = <0x38330000 0x100>;
+			#power-domain-cells = <1>;
+			power-domains = <&pgc_vpumix>, <&pgc_vpu_g1>,
+					<&pgc_vpu_g2>, <&pgc_vpu_h1>;
+			power-domain-names = "bus", "g1", "g2", "h1";
+			clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>,
+				 <&clk IMX8MP_CLK_VPU_G2_ROOT>,
+				 <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
+			clock-names = "g1", "g2", "h1";
+			interconnects = <&noc IMX8MP_ICM_VPU_G1 &noc IMX8MP_ICN_VIDEO>,
+					<&noc IMX8MP_ICM_VPU_G2 &noc IMX8MP_ICN_VIDEO>,
+					<&noc IMX8MP_ICM_VPU_H1 &noc IMX8MP_ICN_VIDEO>;
+			interconnect-names = "g1", "g2", "h1";
+		};
+
+
 		edacmc: memory-controller@3d400000 {
 			compatible = "snps,ddrc-3.80a";
 			reg = <0x3d400000 0x400000>;
-- 
2.25.1

