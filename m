Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FC9569687
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiGFXq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiGFXqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:46:25 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C0D199;
        Wed,  6 Jul 2022 16:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/4qHU+Ql7i7o//bCcSEOTkYsrZiXMi0QrP3iWCP54hsZzMiS7MFGAjuUqs8SEZjWKopyo3QEGkpQmn52TXmxl4gY29koaaDaBCRtq5JcYenzSsiJZI/oygRsazhmwLRrRWuM9+q/UWRFhb9JX1i9F5GuVPHdx/wzM58Kzg/ikep3igWy2L5eBT+NEz0pYdJtgisMenrDWgHvL0sM1bAkyssXaP5qLCx8nlASlwDnLm0WI4zz6bv2xO7IF+SR3bq7azk5PLcDQprOzw34Wvrr0TyBXk8wOO4myD+RbDqESxRGLptl7j8uIVxx23q7bnJ+rrwu14mry2YYceeDCqWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jK3VakMIZ7+oThnl16wZSlcAvK/bkSlFa+KYrmiYYjw=;
 b=IThO5OvhX5bQVC2weYEECr+te4vVAiH7/IR06r5u83LGbaLfHUNk8N6/KijBK5LhGR1mCEcpRZHvd8F4HpiT+ocuZJTuoLbfOIlmARNEB4nel7ehjscmKjPNAuF2fHK/RcJ1wYX7cAz1tBTGIkniEf+gQE8TTpLYyxxyBWHL92CaFBVZq7hmvnwKBeGKKupa0lhcP15pvxWyJqJI1jRW03j7coVx3R+MxmFsFoQAYaZ8XyEKqD5J/ejNsSjGzPpyjVseibZvwHyyYiB7ztJP+YTEVJjk7pATE2ZHksjlOtU641KxJkxLrK4N8BQ6xH2LbymT9L0BTNElyd58hiQ3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK3VakMIZ7+oThnl16wZSlcAvK/bkSlFa+KYrmiYYjw=;
 b=TdcIG19uTD5AZwDwl9vqnjbFNEJ6dzwRXCynT6PeLLmLwna35HTPDywkT7a8IoxA/AXQ+kssSvqOlRaT2Q1UShrhuooOknCe1tFdq4DPyXFxE020GnP7e9//2KsZDBH/W2ZHQ9YFSvl1ut/l//RwMvAUEQkc/0FSlYvC6KKWes4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by HE1PR0401MB2601.eurprd04.prod.outlook.com (2603:10a6:3:86::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 6 Jul
 2022 23:46:19 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::6da9:774d:eb1d:9ad5]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::6da9:774d:eb1d:9ad5%6]) with mapi id 15.20.5395.020; Wed, 6 Jul 2022
 23:46:19 +0000
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
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4] arm64: dts: imx8mp: add NoC node
Date:   Thu,  7 Jul 2022 07:47:57 +0800
Message-Id: <20220706234757.3162307-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cd1b91b-e8a2-48cd-788d-08da5fa9b91b
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2601:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcfMJxNlTlcdEHQWiLRfAODFYmtXGcVbPT70PH6vUU7EQETJpcT0erLyWsFKVGqiLNM8kgaLqPo3WZKJNRGXuXJQd1DmEcrt1poQZrA9toZ4ZdfvEZyGdZdK5pYGyTIZ8nJqh75rbRLeNGQxVBg3y8YY/vwoGReMrX5dyKYo0/rNuWYND8lcddaoMukT5P1HRvsCml+8FJLXVWxjc6n2KPXCPYG77SoLKLd3IrGPR/4KfmTqW/YNCUVR7sY776VDiEL2JajMD0EPO2aRR30Qp00TMuJ5QaWeXQE7aBDZbC8BG9pEmmSrXAiSOVPJx3X+8k5zX3IpJMC6aJxcCR3trRDZdRckCFryT6s3nl77xp6e9Nb2zKMxSovm7SbnHBwEYXMews55cY+qKnJ/33HnBV1Bh9NG6FLD+4AAQ2tFuTxJbdXedeAkP3Ziyl5Q+jBIsOfwImqB41o1/CaNCz3J8wueoxxqTr6loFHH+hNbGWLxc4PBHNQLQfiDma+x5T7QroDleTeCD6SR80dhS45Sx7d9fZ4ex+0YYrk7rne6K+gUTqJjD1lZapPsT64Hemo7M7dbRcmRIWgYc3uGyTu8MpJO478PAwrijd67Oi6w3y1sOV7awSnBWQnWRVUI9Ut0zXqMLuA82ji1XDN/2HdBmZR1sPuy17EL+fl/oy21rcWMokSrWmj57DraAURPivo5k2g3DiMNhp1uOyF1MAcahh1waXEPY4xneMvD/zEzPBVf1+F/2lBpdloMPvqoBWwfZ5XDcc1toAHJp/cfG+WSwH6fCqnR1LaeDJh9jGJKL477+lbeMZJkoOsHpyAZ7pdLJrq3D9HbhUwKLQXthn/p99SDI3BsQBnzeakm2BGDtKokBIz2vWkSzZFIHxWX6hAS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(2616005)(66476007)(186003)(66556008)(66946007)(1076003)(26005)(6512007)(52116002)(921005)(6506007)(83380400001)(4326008)(8676002)(6666004)(478600001)(86362001)(966005)(41300700001)(38100700002)(38350700002)(316002)(6486002)(7416002)(5660300002)(2906002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3jXrc+UvOA4/EA8NCz6WcHRQFJrZwwvn11YVr7aKZ4HKB5JWXyM3arwonRyV?=
 =?us-ascii?Q?3GI7hXjKz75GoCFQtKMD+qn7voluTxqPELQaI+WhjT0tvCUJZ3oh61ERCQIv?=
 =?us-ascii?Q?kfNnDe1UJmR9Sh4g2+rRsGjXLIZhUqNSdIdMVR3CqDEeODsF49rd8UM/9CUd?=
 =?us-ascii?Q?Jhs8qRwgHOUUS1vDfwNrog1YeJCsgu0BzFDXO3ybVqlWrIyhkSBBoC7ZTk5J?=
 =?us-ascii?Q?95mBywfmBYflk68/ENQSFdjN9q60yPZJuSvZ6JLaFwepn1ihrlExz56Lt8Sw?=
 =?us-ascii?Q?t/j/Vak8RJ+jK9IdPnLPomSvIu9zgr393MNuVRoH8M350CCxB+v4TAiJZtmS?=
 =?us-ascii?Q?Orc7mJdZTr2nrNwiWNTxLpY0Wb8DP7MtUgMeNb+IL69sY2VhwpmmiQ31PF+F?=
 =?us-ascii?Q?pZwtvIAARLJJjlifnHG7kYv1ic08suBnfqLV1U0+CLWGx/ydKumxwf1E5yg+?=
 =?us-ascii?Q?bSEakjxTQ5EV46wubvFEgZX4suUK8pavGzBttgnlbsHmM7rfk+8UYoOnrzpE?=
 =?us-ascii?Q?pNSExoLm9BElVxNt0K/tylCvsdEG4HQQfGTSUhmJCYrhbNs+cOxEfAZZI2n9?=
 =?us-ascii?Q?TqK473LFP0WeGfFt5WST019YMSv23otgStFEnidFsireFOwxZBfzaiXQ0HAB?=
 =?us-ascii?Q?FH6rf0BdDz9lZvS/x8w4Jn7+m9VbIE018NxiTe6lp5zaHvZNVkG4ztf4r7s/?=
 =?us-ascii?Q?76cZjpwhkItZCfJoSvCcIPbm61m/a9Fy11hzCY2N7L4OErqoLcfpMV5F02bR?=
 =?us-ascii?Q?qb6NX6T9xLarZ+/azvmspMvLfBUWtr/4JNyNS6hKR/U0mTtN2favX19i7IOM?=
 =?us-ascii?Q?DenWhRkkDxU42YN6IvmZuYxKO37LM+qITMwGg+yoQHJw9jCMb0U3EtBKsObN?=
 =?us-ascii?Q?f8w042Ni17oy9zpJ+gd20jkKxLF4Nif4wpoTKBrbXDPefI4zW1HNcdKWnPvd?=
 =?us-ascii?Q?KNUffN7v5Tjmwt/3zitVucfX5RcIDPYUt7euPFSobRNQ4oVAd+vfCJGYWSwK?=
 =?us-ascii?Q?8Ut8D4TES8v3XP/n9/NqjpMr4gI/VjC1COF1rkFI4alLSA6SUX1PgGJHOuIP?=
 =?us-ascii?Q?ixqXl9hAazbzUnd6yNTlxugSSeR1sNVlXsK19Jg0zhOD0GUqbhM+noRW/e29?=
 =?us-ascii?Q?nQ9F5QU8ansrZ4SUefYAbaD+k03T1tVAvM5AXd+AoId4uFZtZcj7fmArmIJb?=
 =?us-ascii?Q?25mJ5XGvkvQlI8LFYGYvHg+v3zGfONItLWgcLOXGF1wOyI3S/i4Xrr00b5fK?=
 =?us-ascii?Q?mn7Mq5nF8ZDiH3OGpSgWQHkvoBirmoKhYfFxqKMy0F/ZQgjKUD9sdQhz+zOH?=
 =?us-ascii?Q?Coy/0ZU4p9cUFQiYVxoH2cFImgHXHVdOE3bfTQr9Kxyn1cFC0EcgvqpqcSFD?=
 =?us-ascii?Q?Q1C+v5gOPtSuZHo/Jp15IuB1JGl1d9oTeDIC3p1HLE3au/v/k/3bIWMtdQYK?=
 =?us-ascii?Q?ajrqUAu2MpqndDTT1JWRL7NmNzXPck5ufTGRPM9Pd0nzfD6c0FTcupzr9Zch?=
 =?us-ascii?Q?o5+VAPu3ZVOI9zL9OV7ri6k6vaOpqe+Ea3UKAFQPLD3t7Lwh78GfEs4LT23N?=
 =?us-ascii?Q?sNodVzlVNy+LfwdNqkR36UdG2n4LCtF89HIvRZcq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd1b91b-e8a2-48cd-788d-08da5fa9b91b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 23:46:18.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WO0B3czP8BopSXCHWBF5ar13U9+2XNA4a4mm6VJ6ed/F9oHTBn2NkPmL74gwsd99KC/s0vHmYdc18AbhxBQP7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2601
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MP NoC node to make the interconnect i.MX8MP driver could work.
Currently dynamic frequency scaling of the i.MX8MP NoC has not been
supported, only NoC initial settings are configured by interconnect
driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V4:
 Georgi has merged the V3 driver and bindings patches. So only resend
 this patch. Per Georgi's comments:
  - Drop syscon from compatbile
  - Drop the header inclusion

 Seems I not see this patch in patchwork or mailist, maybe sent failed.
 So gave a resend of V4.

 V3:
  https://lore.kernel.org/linux-arm-kernel/20220703091132.1412063-1-peng.fan@oss.nxp.com/

 I not list the full change log, since this is only a minor patch

 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index eb2d516278eb..42ed8ee08548 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1019,6 +1019,27 @@ eqos: ethernet@30bf0000 {
 			};
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mp-noc", "fsl,imx8m-noc";
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

