Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42F353FCD4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242414AbiFGLEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242851AbiFGLAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:54 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150078.outbound.protection.outlook.com [40.107.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFDFDEFF;
        Tue,  7 Jun 2022 04:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOMNcLIDUbpw/favySYewtH8s9jIgQMfS11BWkqV+dE+rPhbpUv5MVSFMtpXnH3QtomD8U4yCTlQSok7fZxn+L0NfseIcpo4fibeCAsApG2WQEGjWbo49oL8uyCUF+OI+EeM6vliP6EFv4yumOIkwow/q05pxnDLi0h+SQmQLgInXe4lw5p2+uxJNZWVSejbEMDWZJS8ECL6E0T7NVwA9GJIgZbwRJRBq/u4wQpN5HD6qDF2PoBL/v5N6reqSFjgTE10rktR0rItykgrIN6tKFtyzMjLqZSs18mfnk5cQhmGRKUwwwQPrzDQXULIACsWQLc1/3b1uZ8zeyJiMqjzgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQF4+EKZdFhk9YcIwI2bKVfpbMh0q8gTOW5ztH9VlX8=;
 b=W4tsei280O52ow46hNG2ptZIdPi3dLpbYLdTAmTSfJ+kyZtjQR1vxyMVzT8Utt6gaqONlXZCaaHK9tfhVIUPr8tm1AYOwXKMswaqtZNdWxplLf9kYsTZbYybpySgWVLMztNyv0fivW01DcH2wsSQ/SkuqCQqTPdby4v/QQoUbGKmf+KNxC2st61y0K717Sg8DwHOG/tF+AbbvkpQUr0j+veYff5bXwkQC+h3d8FUebxJl7i18NohJnj3rCfd3vJ3sTAyz2v93Ek16mvKAJZs55JoSeO3CdYpYfhUl8tKl9b422ADWZdAX8etUIj6L8kpII3gFmvYWHLvwfPMf2Ujjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQF4+EKZdFhk9YcIwI2bKVfpbMh0q8gTOW5ztH9VlX8=;
 b=LGnLJiWRnyJ8aIQY3sSOAuHkfLQE5GhZ9z0RiZapAFW01dPtTWkRsraP2bPZ/TC3oMhJq96/IGFNRz/+KnJD1o1ww2m1D+b9C35xeU6+ABVdefqowGJveMal4KC4bR1D1IxnTA/2jVE0gttb59ZAcBhvNfklt//zJgLsIOFQHZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB3008.eurprd04.prod.outlook.com (2603:10a6:802:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 11:00:14 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 11:00:14 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/10] dt-bindings: arm: freescale: Add fsl,scu-pd yaml file
Date:   Tue,  7 Jun 2022 13:59:47 +0300
Message-Id: <20220607105951.1821519-7-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220607105951.1821519-1-abel.vesa@nxp.com>
References: <20220607105951.1821519-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0602CA0007.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::17) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2ce46d8-479e-4a54-4a12-08da4874e645
X-MS-TrafficTypeDiagnostic: VI1PR04MB3008:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB30084ADC8C6AF6ABC14E375CF6A59@VI1PR04MB3008.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EH05x2gox3d3XIBuw+TZXJ2Cn4EyBTgfHKFlro9NPJZWeo7c5cCoZeBXCIaCnWQusaoU9PWRhbC09XT1eY0t7ZHW1NxyE+PtaOzs4GSzXyatbf34GzXtbwLLZZWJEkEmNUT1V7vAvo901AvyhGFTcbP7qREj9W2nE1I22MtZHBfGD5BUhzknL9wdaKM/R0ezn64UgfFn6/ro58iU7DfQOg5ZEs9DEseeU7LzcYg79wlamouJrsXNsWgS7u/fY/wXVLc5ts0al47TxfuGExeYEPcv9W54ZV1KmosXYfZuYackPNKyXYTx5Xjh/Wp5pO6bUhuuo79vQpW5MorXRGjTNpzpH4F58z47W5AbNpMAXxsMSpplGOn2loWELG4f06lsF/+XQpHv+dVQ/Y5FYu0I7hSbcD29JtBEGpx3WsODKDXb8fylYp8OYGsLtYv39JhSfR6szDUW+zN+fGaQdj+kdgXTqnZFW0/NjBPfr4jyfuF2T8qe0I4TQ7JKIYS0+t0uro2JCu8yBiLlW7pQPNWDOwfcyEj0i8fsIx+wD7tdmvUxoK8Q5H25f8yrX0ZaMjV2+5ky1VErIxoyjucPi8tTPdVfkzwt7l/7HxXBVPwkcMKPd6wnquKC9oLSWND/jnAW5MIB3dUinyvyXT7kY3FThRALerJ+3V9goTFKCRrtNUvAH+Z079aMGObfmkSS7G2srR3zZBqzVv/Lgcqwg8M7Mc7bqEWpGNL1MjcPuN2vQLJB9S3CPEFo0vViMA1wFttxKNMRYZMt6EMXuwTBkUOICBrUlG2v/i72Pw7sKmaFcKLsg9XmU3NfxTsYQeYkt1QBfp1OInw2oTDUSrnkFn/SZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(36756003)(38350700002)(38100700002)(6666004)(966005)(52116002)(6486002)(86362001)(4326008)(66476007)(8676002)(2616005)(8936002)(186003)(5660300002)(2906002)(44832011)(508600001)(66556008)(1076003)(83380400001)(316002)(54906003)(110136005)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nipf8pUJ2+b3u1GJzD/qsRQHu8hbh+2/KyPcRPPxQYkFmZtB9xQ45rGUppyM?=
 =?us-ascii?Q?icErOQZTxMS8eDS7k4FrzbdDxBGBrjVbyd5sa1sooKX7/G40ftHa9MxgkFIp?=
 =?us-ascii?Q?2J8MD+AryMblrZMO+/pDXTknhWFREmEFvLGWQbB3iyBWQ+lAFhHPh2aqsfrJ?=
 =?us-ascii?Q?0CsmYv3gHcjBzk6eF0p7+ySd6jvkdM6b872lDGIorjau6nYuwvoCEglwvexG?=
 =?us-ascii?Q?lsJKo8TZm3QkLBJwG/us8Z5X5NJUjGW40uyFk3QiYoqD6HzfHBLLBP+wwkeE?=
 =?us-ascii?Q?rL5Mtxtdz4+8EXgVDob7Z/ZgCRLRy/DzS9ahPPHt5trtnczPgBQhilPYGkFU?=
 =?us-ascii?Q?rF8MZVW58TefCPux2ywVOTvHSigD49fHsJTi9V1hX6Oa7y17XswBZQQVUD9L?=
 =?us-ascii?Q?ET6a68x7uA1KyGbLTzaYi2GAajnEWGV64vt+0FJTXWnfIG7CUidBhOaRPuxO?=
 =?us-ascii?Q?OhS92YLZYVXEYUFFtUS/ld3dCheqU+nPq/3wlTh7yDTNcXRkMtrY6NDD97Py?=
 =?us-ascii?Q?pH/b4mJTV4KpksCgnz1vEPrqioDoePwy2A+G/0ROjnYn7i+Gx1aFiFj/+a/3?=
 =?us-ascii?Q?TUZybXhoPXhaqXDylaAxmWJogk/b7AQiGiJYCSQmERu9Qcx7tAAnYSZaxuRl?=
 =?us-ascii?Q?96AZo9fdjO5wXa2VaIpf30nABxm6797A0N2XP34Y4wAdVi4MXJX5oS0p0ilj?=
 =?us-ascii?Q?bR7/PpOBkumUjkuvLejzJN9JQIFVgE+m9WDygVOEqN98NzGuvQhr4230y5vb?=
 =?us-ascii?Q?Bjutg8nIVE7NDtkDGdE/TsKbKCu6NfCw1ogkAaYJqlVPZEdvizxEqx55C4kp?=
 =?us-ascii?Q?T9V0d0urcZFjzklrH2foWYVtKkSd8IodeOfxFQoIvRUrvMaYA1FFBJCLsnT4?=
 =?us-ascii?Q?EZ+UQpEOZa6iGo5OYjZNCxOLgELSwiic9skJGjgWlFk6cIchb2BFSiG4cVg/?=
 =?us-ascii?Q?kTemYRGS9QGbRvBiXo12zQo/jYI9X1w2YSGdx2zi5neEWBm9YtoULINlcV/P?=
 =?us-ascii?Q?htd4hkY87Gq4kdn/hsoa+g3psClJKdVSWQULe7Yh7+EdoikgUYM3OqHhSgXZ?=
 =?us-ascii?Q?gO8DQPJyCLQlrb71bMEKqBBgLqlkQb5u6mxqGMdrJSfT+qgT9mmJfvaTCIM4?=
 =?us-ascii?Q?fbVusyZMCx1m5jVF37FPjwrYkphSKDeRrhi81P2VXO4vW57j9dzWMH3YWxwc?=
 =?us-ascii?Q?yc98aYoitzMW8D/UXlKsNc58Jsgas4Wom02HIKTrWagshR9ZhSZE0X6G7dpJ?=
 =?us-ascii?Q?PjsrAUQcgHvrkcJmHS2hY/3ltEKCO5PJatQylG9YpZNPB4kVBQgC6ORzfeAr?=
 =?us-ascii?Q?SOawIOKODT/295GNRocEPsMxCCztNarAGDRO+rQbXRgm0o8gZfF/9WTwXycA?=
 =?us-ascii?Q?oT10cWW2aVXEE7bJUmvYMhLhDFDsYNtwCzceyS72vLVU3i8fDsXfOLu9xFbw?=
 =?us-ascii?Q?koY5neCTQ9WCZ5RTBVydK+SZXkQXL6AB+Qd0bl8ii4+GhLFW+GjQH72XCyQX?=
 =?us-ascii?Q?vCdtLaVZxJ41iv6HtUPFDelAeT8sE8lRuDQtwRURDt3wpqnyXYCZ7+fTbqCl?=
 =?us-ascii?Q?D8yraWNGvxnnLyX2sJYl3aI57ZglHIpI01+Xt6zRmm6fW/ab4HsYX9nVdYSo?=
 =?us-ascii?Q?iVxg6Re28vngfWUUJuXpYi8ry7Zk1uD9KkVcvDfusz1nVi8nVS/rh/fzTSU4?=
 =?us-ascii?Q?VVIV7thJAsxntClCyNBhnIduWRPxxvo7dVWYZvUcf64WEs/fMmICsdEdu/4o?=
 =?us-ascii?Q?uw2tDOLj9A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ce46d8-479e-4a54-4a12-08da4874e645
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:00:14.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsKJpXUt31hjk9VfzG4tXCZb8m7i03OI2iMp/aVvpV4mmhl3i/xuwm6UDyMbhHvdbfGBAclQOtTemokoAOxNWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents separately the PD child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu-pd.yaml    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-pd.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-pd.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-pd.yaml
new file mode 100644
index 000000000000..154a63495436
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-pd.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-pd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Power domain bindings based on SCU Message Protocol
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  Power domain bindings based on SCU Message Protocol
+  This binding for the SCU power domain providers uses the generic power
+  domain binding (Documentation/devicetree/bindings/power/power-domain.yaml)
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8qm-scu-pd
+          - fsl,imx8qxp-scu-pd
+      - const: fsl,scu-pd
+  '#power-domain-cells':
+    const: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - '#power-domain-cells'
-- 
2.34.3

