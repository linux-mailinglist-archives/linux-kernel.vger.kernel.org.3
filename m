Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE6A5792C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiGSFuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236967AbiGSFuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:50:05 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2478BBD7;
        Mon, 18 Jul 2022 22:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5YCreAsZ4DcHJlLrK1wuxntmL1ynpSE9KLOZn9jiGDD5vbTWYI1VJMWHws3K8vY1jiy73DhCjRIxTk9bsPfNbpdQS24OJBxh0PQOYLwZfJma64Xt7PvmId7M5/xaGFWinnf2IevDb7TjMVnIDupdfpTnUWLicn41lR6O7MJU8tpaahdQeP5iGIdDImZIdl4+489hkEHJDHEMLzpav1AVnZ4VdjfnOcCfCLwcMvYA+AcjOonYpXadXMXIW5CU5C+8vRV8bFTJB9znG/s67LtR51cZOG/WCDinYsNOJ2Ml8F4W9BD/hvfI7vbiTR0iUlcTQpfg07upy8LTqRVc43Zaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AorRxksbXeVxubLoSc+lsLswoLaLtAUA5dm1bM1U1k=;
 b=g0R9SxiM9kJUc9heB6dDbLusMvEcrVzGY2qclN7XHLokOE8ZkDJxD7ezxMLD5/vLWEJYYcV2gmFFIWUFq1afPAmb1P0I/a8qAzJ1oayQus7p3t5NjmkzNwDHloNm1+YwadxsmtapLuIc72/PPtcGfiAkTaVwP3UskJomAHVtNIo3MohHAK5I6ABCDnDYp0gToJfU1SLruL6P3i8ycTp9q1uGoMMZhfim+ZzaaeBmb9AQ7RapLByiSSm99/CMzuvtbED15iO4aiaM0txprvSfXbz+YIQRan0v2nPoYLAthHRLblQQ1Cbb0nse5Fkfq7qHaCOuY45AWwB6sFkHx7K++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AorRxksbXeVxubLoSc+lsLswoLaLtAUA5dm1bM1U1k=;
 b=I9154/hmf/kmT8lvEJufZD+1K6CAgtbIcdKbEWFwqkEDOcIc6MEeZ4wKJuzg8DCIhGYY0OXC+eh5VWyUJM4kfoJxAlcmNGkcJBs0DpDWZWqPAF8qftyT9w3WBFi9AfXq71Ef+3ijDJag7iSncVWuVkkKFRgkL5YMNuKcnNz5apo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2937.eurprd04.prod.outlook.com (2603:10a6:3:d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 05:49:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 05:49:59 +0000
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
Subject: [PATCH V3 6/7] arm64: dts: imx8mp: add vpu pgc nodes
Date:   Tue, 19 Jul 2022 13:50:53 +0800
Message-Id: <20220719055054.3855979-7-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b3c4ba76-292b-462d-673c-08da694a842e
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2937:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WF/hL3uwvxZn7c6pdhPE1a4PK55rpmVb4Hc59pqP6ugJM2Xja+UH88fg+W/JBjFENRhA8rApD6E/svz5JX+x5J8xzc51MQFHVKCbIRHZLA7bqpKzOZwgxWqoDHWJsR0Heu4V4MXYTzc26nupn506e3W2tvDC6z/FxKf+zBUHWdLl/BhhvXd0r5T+uFpKUUh3VDoMSW837Gdt0a0gx1t5CRszJMhh72GmtA7IZhW6EEl6BoOEnEoK0H11gJ0s3ohzCk7ZMoLYewq6CIA3/FT6PYCUGfEQoElu2GZsGTXy11Ee2PqsYV/cS2DxwDPQencSfA1rc4WQ8EbPPkS/DM4WZ2yJatFf1x25Wgj3qq9ubfw/A+zKHbmjNYFHGgbYVVgAu8gaUODFFC7p99cLoLlGgE7GcM2NiIuanZfWj/2UQjtuIQSQs5YNxQfsVHbB39ubHMJX8aTQsCao+sXFfiYto0gGI7JtWgApptIvdKF24hsN1FVfU1Ny1ZzYYkksdvuLxHepZAyjUN/eX7WGpsKsRHnQRdOqGmroq1AGNnJVdiojekITVuPAhQT1DydpnDxEBA7bxX4oJqU2AIIZzy8jeLL3L+5zaNQukk6lZRzRvk471zuOFG92usSVzCtD2Qfux5YtyVgP/Yx7N96mcyt0yhP2HSloi4q48dnAMGH8f1thGFFReSblpuwd60ye9fIFPVzwjIYxBRmuVszvP3hf17x4CUJlrMMqtLKlALi4ZZTu4PxJZZe063N4bJ3FPpLOZUQkkMDpodUu66P2QFOeBY5bGUo+5QgtzcNxF+3/QhL6uFuYoKLn2zcESBFREbnjnqjCWdl8nRMP4/yhNysQYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(41300700001)(7416002)(26005)(6512007)(6506007)(38100700002)(6666004)(2906002)(52116002)(38350700002)(2616005)(83380400001)(1076003)(186003)(316002)(66476007)(8936002)(478600001)(4326008)(86362001)(66556008)(8676002)(66946007)(5660300002)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EALh2VKgbjCNjZ5gVg6D1NmxXQWGl7kE4UkDtlyw/QJYXajpk+VjaXyzO2W5?=
 =?us-ascii?Q?QiGwz7Kfxv2lJOl6sIDX+caqUqnYx0jyN7VzEI56pF+LpKiYoGU9qxAoINwg?=
 =?us-ascii?Q?g08z/i+4CjwWryAB0IzVPYyMflp7u4DuUlrB8lYXZ62iRM84DMtWTkn17PYH?=
 =?us-ascii?Q?uKZ8pddhXCIc74MCjPVOBpLxxlOOZfqu6tDOBmx/WSzmBYX/llgQmFh1d5sm?=
 =?us-ascii?Q?/tSAd3KGGTqlw3/y1YYDcJ3vecurO0rcEs9coul+cDwiIryW1kdCsuZBM8Ms?=
 =?us-ascii?Q?PempW6F2A/plVxNUeQllnp9kdOkYUE2vQMyxeT90IgUHUpEJb+r+RywxCQjI?=
 =?us-ascii?Q?NRBLXmILGrg+yNwjt7utyi3HDx1WdrxI3NNnItd4fTRsjga6ApOILtDdIC/M?=
 =?us-ascii?Q?j17WKTPjs3HSwOYeJift87Nf7mYzLFiCfyE38zJxDTTKC5yqH5Ua38mRxL3R?=
 =?us-ascii?Q?f2z5UBxC+Z4XT88m6wnRHkQPTmJF9USpwO9dsytjA9nGaHmRCzSKfntJzdEn?=
 =?us-ascii?Q?O42PGYJ7R7AkpIO/6rFdeUp3QhsBcUYxQHpex/VOKwmC4FWn87KvvIVuv6fT?=
 =?us-ascii?Q?cMSziMypRBdnIqXsUpkJH/7wBSt2yHgFhIu2pxYvuVbo0R3RiEhybNfNw3/P?=
 =?us-ascii?Q?qJitwYmXIQK7qjJbgoaunHITKYMNzPCD32KBn88UJzy8JkxnpZ/Oxe5YI3FK?=
 =?us-ascii?Q?tHy7fpAw/b0aExlb4paxvlt0NRfsyMEHE3D2sQTXmUgQt+Qvq6udKJvhRQ43?=
 =?us-ascii?Q?+bPF625IDnKTJxSij2a+IyNMa/8n+QA5L395YtTUcOVYy2kkXXmVcG7iKhAG?=
 =?us-ascii?Q?52B86rIN8Shmk0GGWp6v9sOkYpZrYQEIY08GgZFBVYuABbbbbeQ17zzXuWqp?=
 =?us-ascii?Q?UW2tf6dlgaThFw4bf70GDg7hOZsuYKWA9VypALqE0zIn7ZjsoLuqe+mwqLgE?=
 =?us-ascii?Q?Wv35yY80SuRHbYZdi0gamS4Gm0OfrqsHmsGX0iM56HnZA3iCK9p9gc0wRpVQ?=
 =?us-ascii?Q?okL1uRgv+sY6c33dRgsPkjoZitKHMWMrLFwsIHLM4Vh8bT0iGtUwSgNIdekq?=
 =?us-ascii?Q?VFDdYPyxibPb5rVabaqAFrIBk7HuaALDkAOae/z47ZOiyjq0vwTH2CelyK9o?=
 =?us-ascii?Q?Sv3QdQ9ZhbeHxV3vE3Y3NGzfrDcRgJl9yB+AWHm+tnNskUcWCyV7vxTOFGIN?=
 =?us-ascii?Q?gxRxqt3+ORrdtEI+vhGZmZHvQS3S/DoOfPSUkyl/yj1mphCHm1jj0hhM2tDl?=
 =?us-ascii?Q?xplkBPG9Vqb6uhjFBtMFNbC5IcW+B34pUJej7sfHnprcrHBhIZVZYp8MpKne?=
 =?us-ascii?Q?yg/kyOTy5/yXUBxv4J5VVUoX+s/jcaSX6zBKzBgd5h2yvY3rTKxL2IEhGFEn?=
 =?us-ascii?Q?+nJVIihp2NH/bwfUsAR35vIj8nTVELbHDdbNthU/ZDwMAWz7Zj9JNd8jNxVd?=
 =?us-ascii?Q?51f2zZiBfDKwfZzYeCBiAsW7JFfK61hhGKMTUvJt6hjS9kqKiNuIIqFjSbj5?=
 =?us-ascii?Q?ObNYBG54lBBU0j0AbUIPOrS0GzYFYhbgIGFK8JDjTpbGqkOF/wj1wZ5/5RJK?=
 =?us-ascii?Q?+B440vmhp63sKPj3jrLdz4UQfgBSNdhUAg3sNdzP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c4ba76-292b-462d-673c-08da694a842e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 05:49:59.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCkcY53YPXtO0Srax8B4/rVNZIm13/AE2TwS0RBEiKsW+OXJv0BtUWqgutqzBDJRwjnPNNjj0zC/2iE6WSgxHw==
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

Add i.MX8MP PGC nodes for vpu, which are used to supply power for VPU.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 0b165f98a82c..34af983b0210 100644
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
+					pgc_vpu_vc8000e: power-domain@22 {
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

