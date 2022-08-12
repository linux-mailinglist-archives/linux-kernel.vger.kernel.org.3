Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D329859116A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbiHLNa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238553AbiHLNau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:30:50 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130070.outbound.protection.outlook.com [40.107.13.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1A028709;
        Fri, 12 Aug 2022 06:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdJIugOMMB5jNDezuA4jBEBXQeslDuQPoT8aVHmnS8C2D99M2PLU8aIhEtOR4o2I+dnpDIGWJjBHD+3DnQIt+ZwcKKqnEO/Mqo56v+TldmsJeS2GOhLvF3qHdWKNS2yBgTwSjqZ7vhHN4pMAgw+QAc1HNQXl5OyoDQA8GnePCzLpOSTMRrhKX+na0XuTr8+llSqZWst4+M60ctcaqLwgfCaPWnKfCBK4uLBZBwqHo+HMxjDFCICxZtEUjWkx8TvTlPHtKlTBWxWxzeAlRTTzvHANBulPzU36/mrmaSc53nB262ER4dIpE6CVYZvfGkXu7n6xs+8WPADiG1UwgAJ99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nidv+/BQZd/PusygeCxcVcJlGxpsn20lmIu4M3juf98=;
 b=QgdBf7rW9dTTXGv0zIcEekB+tev1M1Z2b6LsTPW5Q1IX7NNC8MCLeyksOXWaw10kwv7RMnL4S6YLKC7hDezP7I7ZqZlbKBsJ8GcjhkuYLa3a2NbGbsM1IgU31E+FFU8rfBI29E16wOpi3ha1p3lnzU8EAoESFySqAWQhu2HDH6woTXQBHECJ8hPZ8ryoN1PDmNOU6fce7dVm0Ja7Now3wTqTDNmNRt/bC5Opb8Fw3L7GAOYHYcRtfmXra8wyVFNqgXqwirL3YbIT5kG4H08eoLyV1prgTtG89aPiER98AiQbW4Eb+OkQLUr6qlCpglS8YqW3rMjDxit7Wubci4HXjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nidv+/BQZd/PusygeCxcVcJlGxpsn20lmIu4M3juf98=;
 b=fEE89I4x5PhCtSQigEIXy8EwFlVuYEg78gM3wdp97gjZjaFbX+AArCgB096KUOq8Enh5pbWxGZIPZqL1n6pm8XxBa5vonlRAAwSKe17f0Ad4w4EaFgmCJoW4mgYRy6msHuV7TWAC0BOaYfRq1Xt2l8M1wIoAulN6drrF1fRxoQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by HE1PR0401MB2601.eurprd04.prod.outlook.com (2603:10a6:3:86::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Fri, 12 Aug
 2022 13:30:46 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 13:30:45 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v5 1/3] dt-bindings: gpio: Add imx scu gpio driver bindings
Date:   Fri, 12 Aug 2022 08:30:10 -0500
Message-Id: <20220812133012.7283-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812133012.7283-1-shenwei.wang@nxp.com>
References: <20220812133012.7283-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:806:d3::28) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20d6b33c-79b5-42d7-566d-08da7c66dc8a
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2601:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wOup1CC0d2pWSmk4WWw8RxnuUF5kHLvar3RtGtPa+Nzp9Ky+5mM8PlolDghq82nosLIOWPjBwoAHAPbtOlZvgaYtyzifJFWO2ysUIwjD1RtAPdtUkOqkzHxOpjyC7DIKI4Q7bGZv43q7O4FDJNdRk0hELWl90LzTW9G2uZUamDKyM4Z0nmKXPdwNU8wosQft9Z39aKCzriV1RZHDR00mrYz7XmmujC8NMv7bE16nWIiz/ny2ebIRML5Xvwcfal7ZmYwiYVWJ4nuBy7Hwlv/GXwSw6aF74oXOA4jR19DwrdHMi24xn3WGn9g+Yes1wKhmBXYRUnU8B6+PojdWBkthbuv6mDTlKIVhVtpTR3fstiLPOi2Tq2NXZ2ywwOuELSRNHBFnVo1xEiUTRVqpmb885qHfa2ZAPKub+6eVuKvl8bBCTx37LKMjUGtAqqjPQ/8LfExWaX/4lAVD/xKSvITVHQUBi9lUawzFJEcysZvq5SmolYQ/tPYSoMl2pTPlmF3aTjolrjS0+9RuPNTl6zeZg2dOuagCqcxLgLDmogzCJkGqzw20DylbLnVEo5H34i/zyK9guaN3x03TzheVvLacpRTVy6sjTCeV5JHEGn7BlziSkoMgYadG/eSn0U8suQQPMO5zSp2c7VVot8I5zNDdAvnESDhyPhdy/HCv+CjJ4fh6uSIId0ankZeM4WUqUM2BqV7VKXrXzSYekNZXML11+UP9wW0VnsFhtRJ3pB00genpjTQ3rD4ypYGd3Jn3VO4CLaRhrT7kHGn0X3DUPqmNalegfR+i3JFJVG3doWTgsJODWd7EeguPdp+1G/pUei8eIpEcGmZbIAILY8YrlD13JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(478600001)(2906002)(26005)(55236004)(38100700002)(41300700001)(6666004)(38350700002)(52116002)(44832011)(6506007)(2616005)(6512007)(1076003)(186003)(66476007)(36756003)(66946007)(4326008)(966005)(6636002)(316002)(86362001)(66556008)(6486002)(8936002)(8676002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+J7JFLgfETLM3zkNP27uYLoxUTxa9/Pv+qZ4jGcrtkE5Gxsad6+/dcNegSDH?=
 =?us-ascii?Q?HP5JBQd+97z2tlSTjunAYc/DXvj8SDLmfQVwbH4znTE1WdA/jdgBX9B4l/BY?=
 =?us-ascii?Q?uBJ0pwpHV0/DUCVN8eunFyr1JHK4QI7rB7BkicR2CUUk6nypqJ6QhE/kCJQ/?=
 =?us-ascii?Q?F7IK17aYU0UnErD5N+Mwf6puJGe8UV5gR8zP0y7nB5kW0CwWXjTnnTd02g4V?=
 =?us-ascii?Q?UOyjAAdBJFWZGDkBtR8ghlBgDgkW9IgkLwbePtR63EQ81HUCeHUvoyDjeP6a?=
 =?us-ascii?Q?uyiKFqSD6OF5NrCEL2lcEub99VeFg6RRJl+ej9ERm7ClUPe/mN2tRe1xrNGm?=
 =?us-ascii?Q?+P2s1OFoaD+XOdSvwcwKIgwdz572VHgknAbGtICnB3/lGsh2kddOtB7gQ/w2?=
 =?us-ascii?Q?4hHNtd/B2io7ffcnlaxOuE8UlIRkOJnMAp1CMa4iaqWB6B+0xI8V4UQCt1jn?=
 =?us-ascii?Q?VlFxN3UxiY88Ckm7wYjSo4PskClj+CZDhUqpXJjPfckMnnUoQqg2SM6mUn70?=
 =?us-ascii?Q?wnFL43DEYX7ypuO//3oVZa4eXX/Eg9Arr8+Ol5Q8dvwWHBKTf3brLb0IjHtE?=
 =?us-ascii?Q?Ccmljt83bDQFxOuGuhg6rbKt25PPRaYPBYBTeKTLYLcj8EESpAaGqcfc1Mf1?=
 =?us-ascii?Q?TNwsHeOEzfgK987OE+YAge5kFbIwdEBglVXDXePVs2d99KOlXh3GoaEyE69F?=
 =?us-ascii?Q?53fFRv4uHw04sGcB236C2Gogk/4uvH5toVfrZpIkt/fuTSXTHNSwTWPScPFB?=
 =?us-ascii?Q?3P/P3LK8ezvJEJ1vsWdaWB9BleULiuJYPfNdceaJNawRhk/mhCTck1jHOTrH?=
 =?us-ascii?Q?lx+zziIHsS/XWqeK791aIV77NCULYXSBeWH5VmYAahyO4fOU0khGyTgfiaL8?=
 =?us-ascii?Q?wwfdXISvWpqCRjhVdf5qbH5QruUOzAfBwsgGNcO7Aih99kKPhDFcdeWg2B8X?=
 =?us-ascii?Q?qLWBO5UVXz5JxstCx0eMN57wMt2+u8a1TUgNgcf9oFSrL5cYA5F4wnX9YNCz?=
 =?us-ascii?Q?IZgA19ku6QOdYBce/LBb5AJsLfODpkhbt1wbxQFHk1NHo2JZz3aQZgtYC0xu?=
 =?us-ascii?Q?OkuBrh/8gIf0EeEIdTRQ8TBDEM1cZs3EjBmW/dprxs8lN/IQqo/8wezIHWvz?=
 =?us-ascii?Q?LrZgjdQmXc/F4fM9YMHBW1N0uaQgsW3z5aRYMg7e6Gt8nSvYm6GYQPBYm5kH?=
 =?us-ascii?Q?fSPc4Dp2pBMvNOsaDyMpL2Qnz69TMNIGJ2PKdnzqfVR5zeU7WKIyvsDByC0M?=
 =?us-ascii?Q?22suLNXgNR2W5vifVVWnLy+RpDoDSBkePg0cxghVysGkid3NSj1tvqicEHIC?=
 =?us-ascii?Q?h/T3LukAtwVpFPYKPEbLrMSq7Thc2QTM/2ICvJ4it5tbtR2ib2hosmnShMKF?=
 =?us-ascii?Q?unqD9mfAr8yK1lth/OeQi1JOQNUu7ITeU5O/6fWxInP1Ymt1G95BhQaWbwWP?=
 =?us-ascii?Q?P2MoyZFJ8iRym6y9jtYjXmCzPnifntUOwdqUZWqtSsxPWAdSSJXbqH+2XaST?=
 =?us-ascii?Q?wEzDF0THWXjIaUsWaqcU9bTgLbHQJGjPDUFxVimoqWKwFD+2Qmfti3eAMWuF?=
 =?us-ascii?Q?tlseVyg0Wtx7drWr+MPqhyJIqkpMelReHkLRzZqCD8OI12oCq3xwOMBX9yHQ?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d6b33c-79b5-42d7-566d-08da7c66dc8a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 13:30:45.8970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyExgNkbwUWS4TF1yIabQJJYB1lVZjCiqzbHakJpC30vFbm72ZK1acojPJS5wMiXyn43o6p5wek+cr/vUlWhmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2601
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for the imx scu gpio driver.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 .../bindings/gpio/fsl,imx8qxp-sc-gpio.yaml    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/fsl,imx8qxp-sc-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/fsl,imx8qxp-sc-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl,imx8qxp-sc-gpio.yaml
new file mode 100644
index 000000000000..b7b32220935d
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/fsl,imx8qxp-sc-gpio.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/fsl,imx8qxp-sc-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO driver over IMX SCU firmware API
+
+maintainers:
+  - Shenwei Wang <shenwei.wang@nxp.com>
+
+description: |
+  This module provides the standard interface to control the
+  resource pins in SCU domain on i.MX8 platforms.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qxp-sc-gpio
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+required:
+  - compatible
+  - "#gpio-cells"
+  - gpio-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio0: gpio {
+        compatible = "fsl,imx8qxp-sc-gpio";
+        gpio-controller;
+        #gpio-cells = <2>;
+    };
-- 
2.25.1

