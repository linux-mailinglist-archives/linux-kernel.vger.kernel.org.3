Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAC756B4E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbiGHIzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbiGHIze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:55:34 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10056.outbound.protection.outlook.com [40.107.1.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AA67C190;
        Fri,  8 Jul 2022 01:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5lqUoTJpLhUCtZo7fxbjIfI6OcvbHaEdtikGQBzMsLkygZBrUfqz+B6gvf0td3iOphzhXodo+VyHV5ewfAwNybyGsjWcb3JLfzOV2CzVW92qGI33G38ib6CtlPz2MpRduLVJU4UeU6mwPIcI+KzfaLG7xFXdShWHapbpT+FNA/c3iulXRoa/QkeYTKso+iwADkKDTpSZeK3xNuDxUI8Rp3szi1L1OA8Kg3mRehtdT9p4pnCLnrO0CQhyPHRLlOdHLcH0T/m7WEfY/pXCn3/IS0MNlRabZ2JJ8jaYdmF+o+V9y0kAK0yMajt+D12zzWWfG/Pp9yjhTwS7ntAt1rwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFlvW02VimVmEgUUmKdXJjMmpTOuNn25tbNIrU7TBzU=;
 b=XGFwcys5og5e+LRFYUANQFRwB/vfT2paGz0synXn3QBtgmXU3CAWbtMk5ALWlBMhUpUMgBOY+AE83Nh0pO4RMdpTpCm7TaqyQgOP8Dr7PRfrbRm8M6UM4rD632+wNZHch+yv4BXmzWko58qL66kxdn3EMLnbq0OdX3yixFFDDfbT1x4tPnlZgv668w75tIQoVsK2UI7hOOWk6lwiSbzOmVlli7PZTbu9Zna4Si63fk3Z4aWdl/BNY+ciDDZ0XFsLXJP7+hPBWoVJur2BzeJrYSAX3TW4ZC5OZ+FOrmCnzvuHNa0hkz6WrQfK1c+6CbR2dsgUHkGc3LdleIb6n7fuew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFlvW02VimVmEgUUmKdXJjMmpTOuNn25tbNIrU7TBzU=;
 b=QEvXIWLt40Y+b9D9fOvUDPcPH+3N+C+u+bVWIrVN0QmCvO/MSgniINsxD5IQS7E1KW40Z4XWU/uWuZSJ/ONOW023KF1k0Em3llQGrdCYUhzNynHAyMH2nzQAu1Rq+rnNdHI6d/MyimxX6AORldzhINSN4I740sVFaDcx9q7cweQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6503.eurprd04.prod.outlook.com (2603:10a6:20b:ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19; Fri, 8 Jul
 2022 08:55:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 08:55:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abelvesa@kernel.org,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 6/7] arm64: dts: imx8mp: add interconnects for media blk ctrl
Date:   Fri,  8 Jul 2022 16:56:31 +0800
Message-Id: <20220708085632.1918323-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
References: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cb180f9-616b-47cb-c172-08da60bf9c11
X-MS-TrafficTypeDiagnostic: AM6PR04MB6503:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTKiX70lQK6pFzYFA6yGg2uNJQFVVWLWNqVaSSny77zYUQKdwSJfrMvCzqSGbFmBY9n2qj3KABqjZCFAnIHAg9YMUMSFCkUBtONnLptl+IHFAD9+wohXVT6Q6qcAWlZdKzIUFEXPux6yBi1NIfSsf7XzkdE8rEi0ftAdWmwU1EAjSsfcScLfb3dfx/qRYckl4gFCnn2L81BGLgFR616DaVJhqIU76grejlnULCAnJcEV6/UH+nLSxWupjd8uwhOCFt9nWd9LCA/NVhuV7rGk+i4xwzGn4PoJY7Esp/vRl3CrRPoXRuHiVf8bN2/1WK27uzD0eU0Yls/R3CuiFk0mtT5DZeqMhMcI16g0LW2PO1QLz0ejP9X3PegbFnZYXV2ZqAtxt01Uz2CI1fEkEDj3rsbufoFkH6Bdtpz8qT508uwUJCZUrYHG5hGDtRBUSYpfEK8bOv0fQrVhGm+ElVgUJ081T/i/OOKQc74IOw/arp16y8a3JLb6CXgSsohdraO4MbJXjFUwBMkTRZcx02R8X4i8dupf7zPTPKKMT6GOB7jzPF8XcwLO5OgiobW2f6Xk7r94fKaP20iol1fLO2ume2CVyMd7xDfoaBrh33XTjHhLYH2Wy5HL+p3AlKiwN5drTMzkl/ZZN3ZAZU31hTpjTbnQeCdkCEKoLZaO9jhaKVlCU6sLSLXM+MNK8kt+MKbYNrOmuz1jT4hxH2INjjz02scdXfDi9COImfV8fJiqYiW9SmtcN2K4HFbTQPpa6+4ocvXnfYy02s3+9ST4gLxX+NoR7umGOlAiK4C50heAaNTKpICDkn7heIfkw0P8Z0wD4NDPON34gnZJhoEtidvqvPWj+8r2udTKoDqoiLFGO8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(66556008)(66476007)(186003)(66946007)(2616005)(8936002)(1076003)(7416002)(4326008)(8676002)(5660300002)(83380400001)(6512007)(52116002)(478600001)(2906002)(38350700002)(38100700002)(6506007)(26005)(41300700001)(921005)(6486002)(86362001)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Zw1PhswyIXDbzKfxxKVrYb2C8DDk+g9mo2Gy6fJKybngxHlcXgVSLPoKjxs?=
 =?us-ascii?Q?y/igIgU6cSISEEEMAwSbcaqMc5F+SX9Y0kkzS3UXkhP3IqMFz4DQLhcbjFBL?=
 =?us-ascii?Q?Y276IMSfylPPO8W4t6KXRwMtVN4GB8a153eF/5Q4d+U7oY5u22NM8m7wrCgQ?=
 =?us-ascii?Q?WYMHuFWjEIK5xYqT0djW10WwHUnyv5tutXaS8fvhYW5pxpbLVJPsJ8FUztBz?=
 =?us-ascii?Q?ANt3o7itXrwdl2Uf6Z2su2AnfnFqKMXrUx6/k3/n4+q4k8NCm7iVq1pU86rj?=
 =?us-ascii?Q?Z4EB59QVMMsObU5dzHm0tvV6uQMWo6CYClUadsN7GW/nMSK98ZKL7HLOcy9N?=
 =?us-ascii?Q?8veI1k82mm6S/0nSEWIfqUvDIVYw8uZ/1+NZCDKzWeKgZlovuNkvZbf1/E4u?=
 =?us-ascii?Q?E4P3ffKBgYmb8xo4C9mP93y70jBEQH4ow+DmYsjDcHe2KP59XpuCxncBxrOm?=
 =?us-ascii?Q?FDNO3tOqrZqq3y3Qk6hG2nZyMZjWAqOXbWCc5M+cksgk66BfJFCBa10RoUiI?=
 =?us-ascii?Q?wo5h4MrMv1XJUkj/SB9K6OtL6B4lWE8Enbzr1hdukjXVFKynEanuVg5ATxV6?=
 =?us-ascii?Q?tJ/cYKGZIxF90L2NO6/e3wlWwguKEi1JqKpFTqD6E0sd6VL95vnD8/8+sDFM?=
 =?us-ascii?Q?yNsnm0R4iiLyYcLTXfs7lJuOJh8S/ij55eFeE0w/B1/m+b55ck3WzFJdWtjY?=
 =?us-ascii?Q?xiqgGIkvoapD7b+RC2vRYscRhd54P+4toCQ4Sf4J7VyaIMkJqfhhaY44m9E5?=
 =?us-ascii?Q?gLhK4K7RnjKWK5xgUWWlMhlIKpu4goQcagHWA0+LjmguMTTHqimtNOmS8QXC?=
 =?us-ascii?Q?tvhnMzYineTwR5NWqBm2tA8jCfSSghVRNGgw6m2roA2gwTOX3oovMNx2NzTx?=
 =?us-ascii?Q?LvBmNv82GHs0dGbisNnZ2sxzSMiHR27MB1ekhh8cphbv4d6CyL6wogjkMA5b?=
 =?us-ascii?Q?VDp9CsNLS5UrpQTY1JpR/WON+8Ja8DtV1qndWm+v8QbG6BUc9Cbn/mJQ+46I?=
 =?us-ascii?Q?uUlZomg53gGXgfmB7Inaa9TCms3ECgbD66wXmzPPWaiRiK2cT9t8xve+DjWF?=
 =?us-ascii?Q?yTSPkHAfHSldu8x7Jy+4eBzd33UQkoV7Rn9fKS/fH+i9+syD3QEixP8IwfrB?=
 =?us-ascii?Q?bEM73DePBivxyU/XKkp+Os7z0MIVz1frAk7qqud3w7gXEG5YTVxCfdw/MSdy?=
 =?us-ascii?Q?+G6A8w6atCIxaVVD7H8rIL07qZSP6s6qix2UghWaC7vRfj/an7/a3kCmpTqz?=
 =?us-ascii?Q?eRzo5CH43jgXXWKzE30Fa4qbDmbg4/FxVo//e8FZc2ujhufNlOf2TY8cpULA?=
 =?us-ascii?Q?dJUppdnPXcGBTW/ueY43zgktBCLiVvnhv/0wPqFJI5ASPoffVwfK4Mr2Ckb3?=
 =?us-ascii?Q?iklSpHhtNYMhTRBUTEez79ocRlSUzZ+Ewc3M2QN0dojZ+mEG1Npo6d+G4v76?=
 =?us-ascii?Q?e5flhuXqXRSlV7etj9FBT2kpMLs64uCHsuMiUYHxyJLUXOZkubMKbdjs1cMp?=
 =?us-ascii?Q?cryn+c5w9tHDvPir3JHIYeoNZshVsuwhe6zsTo0IWSE8PqGJ4E4MOzioOL6X?=
 =?us-ascii?Q?ru80g3EMgYLephcmTkZiSKiNfq7IBrTa1ffpVFmh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb180f9-616b-47cb-c172-08da60bf9c11
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 08:55:30.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqmmuo4TTaVPr0Ua+h0NbGbUwxtFSyHi36IxUjkSftCdFIs32T4PhaSO5WDQQnIP+V/FF2fxfYPAF1bfFIkemw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6503
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
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index fe178b7d063c..a36d53914a24 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/power/imx8mp-power.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interconnect/fsl,imx8mp.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -1064,6 +1065,18 @@ media_blk_ctrl: blk-ctrl@32ec0000 {
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

