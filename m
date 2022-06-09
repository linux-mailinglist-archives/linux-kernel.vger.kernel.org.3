Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B333C544C20
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245397AbiFIMdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245241AbiFIMd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:33:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AA5192AB;
        Thu,  9 Jun 2022 05:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVRyIYRj+QSYNJRRNz41d6FAqZlDSgimWi+nXd0XtTp5b1q+rrj6MuFMLYhw9Q4KIBE4XtrUMp2n2Pt/ZbQWfcDX9Fze0h/xjG8eKk8XVDwmq/cALRIWTQ+Gfb7uGfZTmEa6sP3DBsPQyyEJvl+ztaih8EceW6XOE40Uk5Hlxp+oNcESxbztnwmQmS9L+bvH0/wIKuESJKVXBazsTXn93dF9qJaXk0Gabsixm1AQzPGischC5buyCN5mZ4Z2BtsamIlgPCIi5NIoVvTMxc+UvQjH6oK9UnNyeEPJQws3zbrlkIAbQXPUK+o7ukXhTVnF7ckTaaWcxyLf+1tAxRd2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08xmNNqjcWmhowrmJ7eQ29Kp6yFmubzsnyoFd2YZw6M=;
 b=Gxuz4wLzQAqBy9k7AiJZJVMCRNQhR4FEvEC3CLhP1B6BTx+6vmOw6tPxtyEHgagEyedlzv/wBXKD2WeYppQxex9zSrKT29yyeEPY1oUkhkiE9MiHZQCt/Tax/9eihyp0kCzhV7n6kU2iZkI4pqctbm9/gD49qS/s3C3H89S6AAdW2BBx3lOE4Lo/NQU4zzuwYTnVRFcEUcJGCFP6ROMNv2qhs5gNEYj7L3/BVIxJwiFSOqrvkcn7hrsibLBvzk2uGkqSNURPCm2NyewKf26gz83w/2/SqwtAwk3ns6wax9tsYHVB9Hl/flqUizOP6zv/4YX2Mk6ynF6EIRTDRrUloA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08xmNNqjcWmhowrmJ7eQ29Kp6yFmubzsnyoFd2YZw6M=;
 b=LiARiNYcv+xvE2vrkHGhWxgmAxHnAGwONNwQeLgVScliwBug+7EUdX4w6HPmR1wFBHN+zxvq4zVQnYCX/pFeB5Vl34RWVvuIFLORwkxNpFQbCYboacH0HRX9nzu8dW6DfbcxYs8wHlocbnYdBWFtle/KiCR1qCudz837nsnIpHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4475.eurprd04.prod.outlook.com (2603:10a6:5:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 12:33:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 12:33:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: remoteproc: imx_rproc: add fsl,startup-delay-ms
Date:   Thu,  9 Jun 2022 20:34:59 +0800
Message-Id: <20220609123500.3492475-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609123500.3492475-1-peng.fan@oss.nxp.com>
References: <20220609123500.3492475-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 784871db-ccda-46de-96ac-08da4a143db3
X-MS-TrafficTypeDiagnostic: DB7PR04MB4475:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB447561DBBDF83CB2525C5FCBC9A79@DB7PR04MB4475.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eopk2LmuVvZ1vG4+8vawKmolIvoa9VzuHROX1gD+bIzu3JJeIU7z1rP8BA810xVG5wl8wG1cbYL3ys0jBjnYk/A/dykNKrcqASlbqEIkgmK8kr3ZwXIMEYCTXLJTIm8H/WxSvLar4Y45Mbhzq0phd/MhK7Jjtc4AQZ3Nl4EMCTICGRUxmG8P39S4L+yD4dCWmo5rgDIaxkmSpFCGU6V3+0i3IFpExNOxRWLBYOhmnmRPF5XvQAPEPtGydIwJ7VQZf++tEgekWY6zkSx9g0qOJrolUAIhACQvOGTvGQcxLObQ770U/Rf0ob1VSTu5onWnenLjWN9zYgSCXcxvjxFLboRu+Uh26XpfYviDjXT6HCPNgP7n6xpQ8Qy/+kxkcgc8FsebJi6IHkChoxio9LxgXLYJz2VypgEJ+D/0XBurjcmOE4tfGOnvFjJBcvWQUVLaCxSJsYM9SGl4a+acOIPJVuUeyH0gTphA4NTKkuIxBHMOPMncpHm4/PcLuCCNu6jFQ6UP2yHB4HcYpuPl8dggxXiq6mPjsD6rxy7flwtgFIuV1ZwniUPrJQgX0BKArEpgVepDnO09G+EYy78NQ61cF1MJyzKEk2uRyHJz7Z7sKccc3Ig6JrPHNvJwJ/kMacQkAlX6B+CD9YaAQc3uoRw03u11b/b9/XazDEiPHbVn97OUPNiUXRoKt1S9s+IgEndYr7RpJ18FJmd/CSLgk1t5mWKiZb8EPEcTPLbsV7zo6mU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(921005)(4744005)(26005)(6512007)(4326008)(186003)(52116002)(316002)(6506007)(1076003)(8936002)(86362001)(8676002)(66946007)(6486002)(66476007)(66556008)(508600001)(6666004)(38350700002)(38100700002)(7416002)(5660300002)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1tQQggagSbaa6KdJGxMm7vLMLR/670m+9p2We+ZAeYCFe/7KFg+iG9Q6e+0a?=
 =?us-ascii?Q?MTQOfoTlXYGxFSWoA/5bth47rRGzUipuSJMYfLMGwV/yO/To7k4e6sd1EeUB?=
 =?us-ascii?Q?5HH/BCaoeLKhp/Lx3N1PLWSAeWwAlVyI+hGdG6gsVxR/CthH5QHuK3R5HLFy?=
 =?us-ascii?Q?Xme6Etx0llia2TED9iIegQc9hpXrnDbU0EpB9Qnpw18ZlUgP+3kj4Wkvy5H5?=
 =?us-ascii?Q?hMFlUzh43y1phquxJA6P0q4EJ/O8z27NuOwGByaPfjLZEvTeMkDnc1yfru3u?=
 =?us-ascii?Q?lYyi8ttkbcorU+cgD2LwuS/2MN+MPxbppH8nMnCP5jHti69gKiZV8uLZCrdY?=
 =?us-ascii?Q?dfGPiuIRi1YktnN1uRkklSJYx/NcoviFkpNzhs14X6fX6jgMqrq/DP1fbDSj?=
 =?us-ascii?Q?3gMwoGbjaTyt+vv9S8vKEoxeoXg8Qf6SrsKVeLguwoZl6WFc81gZiB2o+8nM?=
 =?us-ascii?Q?yD4xZ3Q/jJrapNDDGGiWMj/DTtgvL5IjMYit9s2Ksp4SKVThdBVsnONNuzGa?=
 =?us-ascii?Q?Gb7uNalb7R1LTmYYvq1JVCoekOV+EH6RcD8xYec9ihM5h2tpjuFTi60TXvrE?=
 =?us-ascii?Q?1FMlAOHIoME9PzBIRyoK2qB7fnLIiW2i9H5ogo2fBRSQ1QpJYtbMZaflSm1m?=
 =?us-ascii?Q?sAVmli/fcpfemNSI/96Wm0YZTDgsAzWNfuy+4txcTzeFzT8kJksvcuUGxkgw?=
 =?us-ascii?Q?T+otRLn2XQRcJRKOAfHIj+ZtlYR39qgHXm6g6MKpT9iI+UOFt/mh1xtNv7HZ?=
 =?us-ascii?Q?/rcY1q0M31BGBaKX2/Ep8flp+Xgae7W+p0/NwSq7RKh+LatzI03vrnqbaKfS?=
 =?us-ascii?Q?MEatCA0jBV1/wRjwpLKkVN7qUQkEDDzDDdjXB9RgMiqiKrrDKsCFoW7MGfE7?=
 =?us-ascii?Q?Hnj8eArbbDrKvH+uT32AMpfZWrhlTzMqCWostuMT8tpfbnY1xh8oS8jhkvld?=
 =?us-ascii?Q?a1pKvzpo+XZ0Twt7rITBIRMFAM6ha1tFzGEMx0D0E0yhMbEPNn0U7RtjhoiZ?=
 =?us-ascii?Q?yP+MvAkK39Lax4K5AABJtGiUPHhlI07aQi0tYoP8/qgyYRcXAIbaq5sxoBUd?=
 =?us-ascii?Q?rfNJ9sT0jfQuStJtjJKXzZ16I1yNlbRs4kdVxl9RHxRb+5o0bfbJfehqei+t?=
 =?us-ascii?Q?MoTCmlCJv8LtsKjpKy2Ns1elvWHdBZQrVAg7tHWEPYjjaruZyMXu64P1NyWG?=
 =?us-ascii?Q?57HoY4xxqa/8SReeLNvaNGXS1wy0FUzIj/NaaIFFKMLxg26mcnl+20iG0HHp?=
 =?us-ascii?Q?B2FkBlvtuLPHYJTbSTxBL0F18LmREe3qtrMQln4kfwWBFWs/AxObHZ2e0pBH?=
 =?us-ascii?Q?6OlR7GAo5cv/u3SSOmIcSzMs/xbQR01rI1wcgzCdC9ZBe+XtUTIEz3vRith/?=
 =?us-ascii?Q?IWUM1XiXJRaBsTAP5cnCHEfY0p+HaV51HSLasRsgSbJ7/SCTr+dxWFx7zVnY?=
 =?us-ascii?Q?o+SMihvwSPr5ibcM8l9Sc+LVmaRc0AWq8zVTg3oZ0h5ievqkcWUPxf2Uet6k?=
 =?us-ascii?Q?4MjVDLDECs4fVUvD75iHcMomFF/k8+bdnbVe+/gUhCtTjaVdW+IWEXWNLSPg?=
 =?us-ascii?Q?VGcJz4E0Dq3yai2qFUAeoYhzPGfz84gkZ1tLzGBuMb+OH6u5tyUS6D9NBxw1?=
 =?us-ascii?Q?1ilBXlEAU1F6Be8kcPMPkMshTORfr8+Rb3Deb1ADaeXSLlyeaBHJ7sgh+D0q?=
 =?us-ascii?Q?2YDyOg9mw2rNhY57zoPoBakPWGWozy2c/+Il/vlKFVW8vFdQIaakdmm0Kb8R?=
 =?us-ascii?Q?8O97Srguzg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784871db-ccda-46de-96ac-08da4a143db3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 12:33:22.5076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UojIMEqDteVCF0oCEUVlN8aVMaS3+7DpsdCUygGobk+dPQu3ag4eyxL/WtP2TGdf9kqjVzThbekp6giLQg5Ivw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4475
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

add fsl,startup-delay-ms property indicating delay some time after just
kicks remote processor.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
index 64e783234e38..56f3ed18c28c 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -76,6 +76,10 @@ properties:
       This property is to specify the resource id of the remote processor in SoC
       which supports SCFW
 
+  fsl,startup-delay-ms:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: Startup time that remote processor ready for communication
+
 required:
   - compatible
 
-- 
2.25.1

