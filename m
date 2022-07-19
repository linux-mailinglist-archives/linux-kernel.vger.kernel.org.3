Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60995792C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbiGSFuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbiGSFuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:50:13 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D08D5FFE;
        Mon, 18 Jul 2022 22:50:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcXgcKiaGGhl7RmeZqkkOf7+5H5SKUy2ZdSqzmF3tTA6iHQCMXJ7r01xFl4RzWcHkcxSxB1XktTuLGzTamNiaoeZO9E3xhCWARZ++NHgM83GvUi4oTh+O3BHvTyBm0o37hNyCdhBON4RpV1PywnhY4I5xQ5Ut0aLZv9fZPOnLp3r9f3sHPJvjmMjGC5M7LtV9d0VKUXnLDL5h4/QBQPyKAE8tuYfJljEnlfLjhyPIsnmGfMzWJTlUt3vbb5Lsgh5TYkqJrzWBmYxgsunwPKDG4SYQa5+bpzIh4xxfXeLbvU2vE+zygSCdGxVrcrObWZ/dh2IadHMMT1PXpslXFXzyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olONIe1IcfxoeeiMmRevLFQZZOGiT0LONaCz3vBzlbo=;
 b=XzAxSPOUxV4OPGf6VIKihhA1HiOhnLqvLKzAQ04Sxb23b17K+K0H67u+YJFZ/JdDUmwPlWs7cywT1rYKqzRaMHYZLMR5solNt+FdherUbIj8pkOjOrLoy6TKWeCS/F+mk8yoSNDmOzvd4GUoS7VnIXDK8INnHDANXpUw3AUAY7nLsVFzWuusew4cZ3MiGYmDdWMfgO3Z0AzJSglbUlcKr+03spi/Mn5MJeVBCWxnXAAPwXZjHFjjxZ10SmDkR6jGmCjdZGJy69hsmDGUhdIN3s5pOLDaBeIrkHvyvdOeBdKkISGjmAGBuMvrs0yM2q3kpVdlG0xn/xeIgiQg7iHLAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olONIe1IcfxoeeiMmRevLFQZZOGiT0LONaCz3vBzlbo=;
 b=Ddg1pJypHJCezFkJG9uBEAw5/zi3SjUdAxSXKnuCHRo9oVTGrG/ysVFLqz5p7Xbth7ayTAlIZrYsegAWZi+Jxqh8/W+WzAQHoy/AlRmvUYLxyktURz/D+gVCWNkUeSkOxPWTFdadi3j+SSDVsR55eFtWBEzYf/JGLJKHfsiWbjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2937.eurprd04.prod.outlook.com (2603:10a6:3:d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 05:50:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 05:50:04 +0000
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
Subject: [PATCH V3 7/7] arm64: dts: imx8mp: add VPU blk ctrl node
Date:   Tue, 19 Jul 2022 13:50:54 +0800
Message-Id: <20220719055054.3855979-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
References: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4a5d52c-e4ad-49e1-ae7b-08da694a8766
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2937:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JiLZmarVeYA/yUNGmztmw/Pq41VfQ+O4RnKWiiOfUtaAWpExLJEcCM6sixQOlSSdIeWOTNmF2NJ9anqeFYdfhTNAruux3m8kBWeeuq0vDXDgKfI+2UXAsrK0tZblXd1sB/NEM/Io8ZcQaBLUsN2ceZAuRwFqewifk7bpfMuwIKuFnTqmMMetzSRsMCKZuRWJmwUmnwbNPJ21aWtdDWBYAwLiMDfRmgx4wtS43CcQ932OYE6Q8TSs68yHtcojOtROSGTxxC4k6MJ7NXj+NX08FwMgN8xKJIePtW3mFBgOJ9wMPzblpffkCP7ir6/lGW1EpDkOgMwS063KIzpGAvsCrO7c3PjUzF6ZQEMNDVMEWW1RFE1HJiZ9/+A1rVfxbFzyilUKLOCPGpLPjq5xOyJLbTyatFhWGH7EsoXB6ZpfXlWUcSHxiwopRbpOIHSKXKKfsh6lCskzoEvHtK6E3TNzE/N8L6ogzNz6eowhm+5FJI7XQX0Rxp4LdvLRdWxPyAYiKnMh30cmetkMQJfNxPgAJmjuk9gVzSkJmIAJTxntisxsqvnNdnkgT15hQYSIKi7i1Ipu9BX1H6twJiK2OGQG5pVvEr121XIUAd2Uz7DqSSq6958rif/CKjF5m6j0KhYfdB5ikboZWHSksbG60drno4IppH7kPk9jymchOIXOwhOBM5E15a2uBsuJGpRchIrKUvOebocp1Djvb89TjCiSNQgJUVFbrpGD2OqPBrjll8UkRfoI6Kd2UMB6QPvKdQoDcU1KFXzuc/dPEei3x4YnJuOjqt/uAprxNMk1k1BSr5/5RxSC2Snn8FA7OYoMNKboxY6V4aIcDjjNLn0K2+hc/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(41300700001)(7416002)(26005)(6512007)(6506007)(38100700002)(6666004)(2906002)(52116002)(38350700002)(2616005)(83380400001)(1076003)(186003)(316002)(66476007)(8936002)(478600001)(4326008)(86362001)(66556008)(8676002)(66946007)(5660300002)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LLo6v8WAU+ck0S+FQrg5Udm8WTOTEmpYllztN8rQZwEA/wV29BOqJv0ufZB9?=
 =?us-ascii?Q?WtLTCxjX4S4MyYcdJc0cB8GwBsrAMcWMIEk8G1hu7ETx1hYj1NRTikQBJMik?=
 =?us-ascii?Q?e/lvkBGePuVATrAMypKr1/6oUKdQSq4hNWDnFHp0GXRio2OY27+hQtBgjLCm?=
 =?us-ascii?Q?Dt/4zyIqrbrZr4pK6Xggt6auAD2lT+WKfmro5DDY3wSJ36iueAHI2dM2Mfyt?=
 =?us-ascii?Q?Wsf3k/brsVSxBV9zrtPVJe3nCW9B/VWA01zTzQFbFstl3W/BQdeJV2gAeSy4?=
 =?us-ascii?Q?lgmw8lmTF0GrZXl98GkyKL8TwapHJuH9S2u/DU3rngDb8iGE6IBQNc7hppmb?=
 =?us-ascii?Q?IyKbXIIhvvSKwm39KhwbU9V9kcK952ZCNUswk4D/nR3xCXOjmTvrqsfpLWz5?=
 =?us-ascii?Q?JWOr3iaVVgBLgo4IQvDKPCOt55UxJtFS8+pHOcXaMGFPXx6i9grF9KCO57uX?=
 =?us-ascii?Q?qveCkUc/EOfyKu3FHHlhTmOX4IY9hQv20l79EpWkZHBPDEMIzneZ0gJ0hur8?=
 =?us-ascii?Q?TR+8v6BC77O+CEEpLTkB9Qhri8sbaXyxz3usRDHovVLyEgyQ5b4IJzJQEUw/?=
 =?us-ascii?Q?k4VPkjheV5h/91zaYQQmoWAxhf4OotmpDBWBL8QVA8cCvqeZrYkYYrb07bjw?=
 =?us-ascii?Q?H6Vd/xsjW6U7UkeAaf4/wSBp/0neNgsWmGRmob2JG3bhBk8nDMcz7yGStupu?=
 =?us-ascii?Q?BQoSiHVwqJINBFp+8sg3RPjclPdJY1s3JBmGjeNAbYQgjlpKZ4DLlmHKk4Dz?=
 =?us-ascii?Q?HV2keReT6IImDG/1jU9kq02dHSoVJ4wDG7WNbw0/OlDTfHKPZ6NdiM/7nKJg?=
 =?us-ascii?Q?18QxvJPAB+v8RqR5C5rG3bPA6Zwt2xOmTqxVlXwEQnkTdr5VYAgnCELJqcJf?=
 =?us-ascii?Q?mXWMYCa1eghUjHdLxL86sMZyR5U4grrxyATLprnYZ8Ag+TcNrOwgFOmc6lDz?=
 =?us-ascii?Q?+3qzEHztIC6D9FU19Dxgf2uZGEjKZ18aV4hSg5m0LFxQaOdc15nK0nYxdyjr?=
 =?us-ascii?Q?MeDld1fimCy6XHTf9ySV5I1uZbeQ9TNtk6QQRJWJ2e2LrsjmlhB9COvoAwMc?=
 =?us-ascii?Q?FXPdqCmYYRTwDieVH+RQCWThuFlwOtUGFfUwnK6GSa23gIM2Lbjp44Or9Ydl?=
 =?us-ascii?Q?H9UU4YCg0xVC1EmydVk26lxe3Eo77of1J0twqEUGJe2K4SZjsyvW4PMmMOQo?=
 =?us-ascii?Q?+XkbxTKVVwt3O2KqcB1/u0fJ3iJmNkK8km6B4VcRwO1OhL/Yp2HxmErcSWxQ?=
 =?us-ascii?Q?kTBHp1THFvXzXnGl4RUXBo6WCSoU6ecWjFER/vepMCjprNMbT6jQOpVqmQhY?=
 =?us-ascii?Q?Gqek9vlWpYRXqjyCQEf0ehnp1kP0Z1LWdY30+NTat6E8BJxm518b4jAXYRFt?=
 =?us-ascii?Q?I8UM4mrns8CVeMAOmAx5ukdkKdLmGRsozjG5g4XjG8IHypy3GamG6aRJo6lJ?=
 =?us-ascii?Q?cIAyRP+Q+Q2sGfuWKQu4iIgZA/oF043wzpOUrSps8+8OKV+djkpmj6e0Xm1h?=
 =?us-ascii?Q?KTjWLwJ4zCVpRlPAbe56iVJeDmbyyHCd5ue93og5QyQ2yTU1dq67/zdyd/JJ?=
 =?us-ascii?Q?vUJIbi/uPX47EpQ0BWcy1IrcZdbExGBBMgT4vDv5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a5d52c-e4ad-49e1-ae7b-08da694a8766
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 05:50:04.8214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNDQTE0RuEhPOorplN5kptChpiMWm1OAa/vxnpfn8qUtx+u+exoq+M+OHIkbjaU5dgB1gL35mupG2UUVlbOiEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2937
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 34af983b0210..493fc3ceec1f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1185,6 +1185,24 @@ gic: interrupt-controller@38800000 {
 			interrupt-parent = <&gic>;
 		};
 
+		vpumix_blk_ctrl: blk-ctrl@38330000 {
+			compatible = "fsl,imx8mp-vpu-blk-ctrl", "syscon";
+			reg = <0x38330000 0x100>;
+			#power-domain-cells = <1>;
+			power-domains = <&pgc_vpumix>, <&pgc_vpu_g1>,
+					<&pgc_vpu_g2>, <&pgc_vpu_vc8000e>;
+			power-domain-names = "bus", "g1", "g2", "vc8000e";
+			clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>,
+				 <&clk IMX8MP_CLK_VPU_G2_ROOT>,
+				 <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
+			clock-names = "g1", "g2", "vc8000e";
+			interconnects = <&noc IMX8MP_ICM_VPU_G1 &noc IMX8MP_ICN_VIDEO>,
+					<&noc IMX8MP_ICM_VPU_G2 &noc IMX8MP_ICN_VIDEO>,
+					<&noc IMX8MP_ICM_VPU_H1 &noc IMX8MP_ICN_VIDEO>;
+			interconnect-names = "g1", "g2", "vc8000e";
+		};
+
+
 		edacmc: memory-controller@3d400000 {
 			compatible = "snps,ddrc-3.80a";
 			reg = <0x3d400000 0x400000>;
-- 
2.25.1

