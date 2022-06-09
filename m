Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CE5544F9F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344240AbiFIOhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiFIOfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:35:54 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140079.outbound.protection.outlook.com [40.107.14.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1F2321613;
        Thu,  9 Jun 2022 07:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FijIybJT9YlPaMcF2WkWyCzDBVSxSylYxl3t3F3yFnRvlWYt9Zoli11Hl4QxeU/g0/oL4b5t9Jb1FcQIJYSOl2hCOUZFboy3Ro9ewscikyuNKh96Wke9dbrdWhB9T8Q33zY7ELLqQ4g9mRNEvXG0qlewHjVHbnptZl83P5bauMX6soC84vs5OUTnT2Qhx8L7uT6iDk/x/wn7D56mV2TugTDRxiLahvlapMqMdNBNU6uxhcTZKkkQitQ0Zm5LrZd6TcFQ43pKzqkNFYJyx67vfIhyEnT1qc1kJx01UOcsMt9UtaYBoB0qhdlSqoBl1UQz2BU7cAj9So0Y5unTgpRD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpcgTzCFwE7LhReWVrzfD9RbaZxu5jTi9TPpLDVwUlw=;
 b=QHB/9SMX5YpFOoU8qF+lQhYYeV99Byw9JhBN746HrKmoV1fSF/7TtwazqU7RJPa9+S+np3It3jj7iuTTiVt2Raf7/7PyQ53vuV6fN5K80YoBIw6T+M95srCCZi9TpCZ7HDS4Fn3XhuK7/0qvN5Lu9zFEWzKlHaB+JqCOfUputZlXb3/wXn32yjzXlwOG188dFWao0x6KbDF6vUWCOQNwWus2S7MMYTFeweRnKcdFH9HrqPYSM/tlvNW5IhPjWZtijEsHROISoEFdkR7P4Wfj+ZB3AtOomdLaoTwAE0QZYNk/QauPqjx7mCtTvEjorcqgH6HT6DjfrWS15MoJq+RUYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpcgTzCFwE7LhReWVrzfD9RbaZxu5jTi9TPpLDVwUlw=;
 b=iJcdIN2MN3cDNFe1/IhVxrx304JRlxV1IRml4xISEldxCshKCS1iTIXeMFAiLM+8km3UsWIjI0dolD08O3ZqeXU4Uh3tkSSFGT8c12BKlT//GnluzVsEBn6JyfTkjNfLebIjyoF24Rd3scC9DBybq2cWC7LjZlU/+voYOZs0pVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5885.eurprd04.prod.outlook.com (2603:10a6:803:e1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 14:35:31 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 14:35:31 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Stefan Agner <stefan@agner.ch>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v3 09/10] dt-bindings: watchdog: Add fsl,scu-wdt yaml file
Date:   Thu,  9 Jun 2022 17:34:22 +0300
Message-Id: <20220609143423.2839186-10-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220609143423.2839186-1-abel.vesa@nxp.com>
References: <20220609143423.2839186-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR07CA0042.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::29) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 591f18b0-95e8-4f3a-48ba-08da4a253eab
X-MS-TrafficTypeDiagnostic: VI1PR04MB5885:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB58852ACDB95E5AC42B070A8AF6A79@VI1PR04MB5885.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0kK2pCfdZecMwK0hPp0HUEF4dh23P4i/Yw1BXSOKW2aIMP8xZmxYLlmDAOnLsPmLe7GPh1NnzBWUOnLOKAMFPMi06wKdHzfZHF9h1QfaQjnb8+Igm1DNDrtb3h+nm492MpzaNSCMTGrDb4ZirhfB9rQsvq/iUjUI9C5twjS+iEd3hrpclCJJXv3JmcZ53lT4Cx0LhIZk8TcWIorYC35oimAEJBk16rzA14NIRbPUcqu7gCuDSHtcfY8M+z62NjNzMELatwfYSVYo+xiKItQYCmLXf1qoLGR5WYRhiktita4XrAAO6MR7EXtqsn3B+eHwwt1q0hWwGsNHFnB5h7BZFIKSsmYm/LeAf/SSlxPs22vS1U7aPO9CFUrv6MPJS6yNZTAcyk6fdwXV9fIZiBEmyj8cEzd0yBUGE+heasY7fTMZjaaPihEwTo0l4QX+y6XE36FnHVCMUW2lDDYfXosfXPiTEDuXOL7LcmYiFkNMSi5EDDmdP+WYvqXswgUEkDDkV7OCpE/x1llHD0HCS6amIgAR5h25GDfgTgFGK9SfyA5g1ZNDeeGtoONnq1/06CNlw1QgLxKiivD3GIjODN7otSba5Vb4y8fNrW91GemV9POOsqJq0sFCo5sH28jX47HLyJiF1inhkFghe0MxsiPjYATXNZnB+pEevwfxNp2NpIfWDCCAVfQWSyGguXYk5XBwDttjb9orUGsvXchGv4GXDTs+kWHTsCHzDJ0wB6iYxJzxtEI0gSUDJsilXy2+gPPbUGJ6wNaBuIawuq/en7/y2hSphfVipY4y9gi+gvC+D+poy7BArNUqC94XruitcUPLKaEpzIi32AmSDloxwnp1UStu4Qok16bwSIEX59fXQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(36756003)(54906003)(110136005)(6506007)(6486002)(508600001)(2906002)(966005)(7416002)(38100700002)(5660300002)(6666004)(86362001)(44832011)(8936002)(8676002)(83380400001)(2616005)(186003)(52116002)(38350700002)(921005)(1076003)(66556008)(26005)(6512007)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1mzQZPwrZ0wuIkwbzk0AaZG7a/31gSIJcsLmKgSbOUeOQhp9QQvT7UiTZRC6?=
 =?us-ascii?Q?wEa5OWOXnc48/6f0EcdKrrerm2+sXQul2cRKvdAaU7EySh/rJFZYPLmPt7bk?=
 =?us-ascii?Q?A+AeFRVEWieFvld1eUa/HcflSAKY1QaJun5wEbItJB2dtsF3nR2LwPtf/5H9?=
 =?us-ascii?Q?6ajZC7ZLJV59qxRRrmXxDYESSCHaDAeEdDMVgZAIFN9jhKG9AYTRbVMOdzKT?=
 =?us-ascii?Q?R/oxOT8sEAhn1Y7Yoyj8g2QrjcLHbbb1PK+EQqzCuXNA/Sn4k5PFdpET8/Ch?=
 =?us-ascii?Q?4qMKzHbiFW2ynvqgyxq411DEIbVyxzsW20//xwn6A6aeTovUNP3n6CZHzq36?=
 =?us-ascii?Q?vcUcEwh6+278V3KgWmwxCOwem0oUkg5LKnvPmrNdmc+ZC9h2gKiwU6WFbfBH?=
 =?us-ascii?Q?SE6tMZ9WL7H+1r+V28gerrtmhluoQDkFYNUUn1dho3AmqV5Ikre3cC2GgB4h?=
 =?us-ascii?Q?1tl8CCIHmbZNz3gUgqYjmeHZeTO00G/UiLebyc/K5+Hww3vFh8OS3fe1h4uw?=
 =?us-ascii?Q?l/W67P/SFp9V5KOuJuFKpg0ATjfKMjkomehgZNsIuLceg+USkROxwCOzWO2j?=
 =?us-ascii?Q?Rz+aWwtynAJSbwdATZsMFZ8vQW1v7ZI0vLMHlcdxWg3IICBnX5ji/fncEYfs?=
 =?us-ascii?Q?T/Y6N51s6jbLPJL25fPV10lNrC+Isg3PmxFbn1g+4AE7rS5ZFlGBwouTJjmI?=
 =?us-ascii?Q?iOczIjFkEXzj8gF/y+BBK4Y1V9Ioo4RTboAViWMtLMI1qtg7ycI//IMCAEzR?=
 =?us-ascii?Q?/nTZASU+YhUBOOrMJVjSRNphzuOc8VyIB5dFQcrcJxdKpDGkhNYJUrnRt6VB?=
 =?us-ascii?Q?mPDWeQqlShFPHd0M2sgO0Xnvo7ZTp2lebE2Ot1OisaSc06eFVBC3Umwj9JGM?=
 =?us-ascii?Q?GHEznuoY+fTNGKXA9TQ69R17ycrx1fgHJ5kmzJjm5SYxxDNgZHS27NyzZNdX?=
 =?us-ascii?Q?aXHGfYN8SI3h23ISJJ0tYcgAVmq6xeW8taNR5k1vfq942SIXrMz86qczWeVH?=
 =?us-ascii?Q?H/tTKqvw74SYL83sUWAVbp1tDRGbBgjC6bwfig4eo6o17QTPbwFG2/2DipuK?=
 =?us-ascii?Q?OXBM0RPS2kPDHycRx9Opcf4i3Ucl+Ap55Rlei2KACFzdJ3KdycRwGIu+mrcg?=
 =?us-ascii?Q?j6rTr2J9QpV5sza4OzfVrqtm+5ck2YwahcTkwCRRgjrqfUOzNjtor+zlzNvC?=
 =?us-ascii?Q?kZJu0U0WRE2k+XKHHBt04d1v1/W89msnzuHEHC/e4Kypa3zvaTIvTDxc88z2?=
 =?us-ascii?Q?EUUGeOKJiDxxioLyG4JbvB8/KxchiA9TZoXZ7rkLaVL4VjlylysyziXI404h?=
 =?us-ascii?Q?X91W8JAwT2H/Rcmy4KejTqSe0bMS/gmeV+oACW1BfpDVuFyO/MLB4mQbeIas?=
 =?us-ascii?Q?qNEpcnwXshl17aL9sly+rvE4U260sF8mF0mOi9anb1Uu55kZ+oRHG4nsmG0/?=
 =?us-ascii?Q?zbD2oJUoXBoMAN/KUC3MmTlO68kS9QY6s7F4Whe+5Uyt/6ov0WnuLOc+cVbd?=
 =?us-ascii?Q?NMnpuOLYvsSSPCZ/edsKuq1OK6ZXpa9R0qMnEpYA9BgyPd3d5C8dh+6/5HXA?=
 =?us-ascii?Q?YTssw3Q2XN4dIDqoqzH1QfZ1tN2k+mWL+V7Hnc3FKVymhT9yR5GiD+yQ8rbE?=
 =?us-ascii?Q?+BECR8T5ER2UIrPQShuuna0Y9ynVk6Bm40FhBl5r/R9rWzFLk+HPAhflQnm8?=
 =?us-ascii?Q?3Znz2IZqWejtaHyuLqgHZhRsb/2iMCjCgnV/JvEzomP8X2DLvrNVZMjj9S+A?=
 =?us-ascii?Q?TeRHiQaI4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591f18b0-95e8-4f3a-48ba-08da4a253eab
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:35:05.4191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQXyeKzasqVG9tlyG29f8czhfPbQeMhSpONEjwyio1GiNam3iA5NBXCrrRugYNWWdBhAPIs76CH+OQBMc4z3Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch documents
separately the 'watchdog' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/watchdog/fsl,scu-wdt.yaml        | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
new file mode 100644
index 000000000000..daf27af2865d
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/fsl,scu-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Watchdog bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+allOf:
+  - $ref: /schemas/watchdog/watchdog.yaml
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: fsl,imx8qxp-sc-wdt
+          - const: fsl,imx-sc-wdt
+
+  timeout-sec: true
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.34.3

