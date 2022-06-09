Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BDA544F82
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344195AbiFIOg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344033AbiFIOf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:35:29 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140079.outbound.protection.outlook.com [40.107.14.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42E53223BC;
        Thu,  9 Jun 2022 07:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJuk2+e/DYdX3zOG2rxqyRRTvon5jXn8G5NsiA/+IWcrGtWEH23FZyW50bQD5aAuVKLa9hGcvU5vnJjZFfwgSRegZOf9WzoR1nNlAmF8aCbpObae0BivYfh2foRPLzJbU4oDqMs78R8BiTuyDogTQym8lStf1znbWlF/RHAoFlhGkZTP3L20dxVQ/4Y/tZ1p/Q7NJlyx7Fx6YKhGl5BY0GhsaaknTk0EqPza3i3MeM4z/x0kOCqHCd6K36YVwqdlDU2olv2954UbK+V924kJNiLquI1ql5A0YZZnqwMzwEYHIYBmfAxkNgY5LtzVRiPSyP/hRi+I8lsoUgYywKsZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgTEh1LFFr2s5XZtlmeawUmkJmXrG3igETN+Ahv0/hA=;
 b=Z9wK7fkLiCz0jQTbf9Hdj05WRECFw8qn6m7mTZBgrUJTpJyzxPHJ5unZzvI6VDUWNIgCJo26/3S3K4VJZLmKjD4+g3mYIJPaKmYN/zDCeIxcPz0j0fzgmfCHSBhFreF+zQHjzRNGZGUUpbxjGYNLKe56G9BbWJrO0Yfp2naltQfMZYVR01dYcSBXCRqocj/dJeKZqAVLdnY2hdPKZTZUWRf/GqR7yvnkqFBReY4boR5/lJ6cIKuubFfAaX9w2lfeO8osC2AkuxVg5cqfVGhMBbnMa519IxHFxczU+T29XNY0X6+DcP4UUAO8jDMp/Y9opPpb6QTdCEzFF0q9cDd99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgTEh1LFFr2s5XZtlmeawUmkJmXrG3igETN+Ahv0/hA=;
 b=Jw/zpBWKhkKskVuBkT9yzqgwK7nTKv+QTN77BiplqQCNBDHDmpd7VhViqY0A0HWJRcfMd0er3inVk6nGhiciJPjFMukeAxABVsib8XrPEYEU3bWaq795Ea9cN7Wg7R2+x5lch4rmJI9Dz+4HU2ytOdDM1vCx6p6Uavpp+pHxKik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5885.eurprd04.prod.outlook.com (2603:10a6:803:e1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 14:35:20 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 14:35:20 +0000
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
Subject: [PATCH v3 05/10] dt-bindings: nvmem: Add fsl,scu-ocotp yaml file
Date:   Thu,  9 Jun 2022 17:34:18 +0300
Message-Id: <20220609143423.2839186-6-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ac3d4072-068d-4953-49db-08da4a2539e4
X-MS-TrafficTypeDiagnostic: VI1PR04MB5885:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5885FDFFE31E6B215F28DC2DF6A79@VI1PR04MB5885.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMBJ1UVzx0HT+rkAYX7Ak7LW3zQTKyofIPXDLdshPd9PyEErwFmDW3tTa+5uatBD9URTtEKFjG6KSyHdg4kAVJ8XwK5kAYGYX5djTLkx9OqArdNI0+u8UjjUghypsH1GeQ4Y9yz0nHcKrmWiq7+BSgRMQpL85mc7KFNT7JXMRVuajpdO70/4BAlIfJMxeqjtcrklnBPWv9PDRp3THUVDEQm5NP+heOuh6vUgJV95PPXXBz6JErE/4gWJfyJ8Z+KyWSo3L1tBSHT9lvLAdRW1XN0i5ixA6CBBC3e0xsgOMniaeWbO5EWs87ThN9uNafZ7yMB1qzN2KUP5lxSPKY23H6ZlurQ9gVH2U5CCISvHPyrWdaXgtkK5gfirIY7Q4377VIPhc9T885a/qMrbjcbzY90ksbJJYLai//pfASMwxwr9hjznyq9ceY6fnT+3TL/Ilf8+u1IR/EoYwj8x+H+1cm2VdAcm1adpHhoqT8VPsO5JqVR6eWT8vgdlPhUKQQFvGnmrELkhLu+9iVHPYV8CqVZrU8Usm2atIR0HXgCmRE6cZ0fwTI82lWpqobD1saTcoZszZJe+fwzN0E7YveURTFvSPiEddU12MDWcfvZF3rdAegQPis2nwTbJVWPBdhazB6PXEbaPE5LX8b4jlsch3okMKkNg6fKAQeS+LfoZcBnxyRSQieS/JQEob0vxk+wqo1blfOUjDQoh+5M19qz9LDuW1gBIq5YzgC6NtbVgISauQE21pbkP0ara74ulAfDXPqBxlYxsO/LYfd8zE5VCVVK/MpW1AxxVT+fWFoEYstQCmmlnbDCgx/oIOEvsulov8eLbgMcZ74gFe3XnM3kZ/7Z1VslinFydEppVKuxq8Zg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(36756003)(54906003)(110136005)(6506007)(6486002)(508600001)(2906002)(966005)(7416002)(38100700002)(5660300002)(86362001)(44832011)(8936002)(8676002)(83380400001)(2616005)(186003)(52116002)(38350700002)(921005)(1076003)(66556008)(26005)(6512007)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PE+lQ0281QQXm+7BLR3uR10Ie46XJ/KDTe0+jDeCrOK2Wd3KQ5v1UYO7IDse?=
 =?us-ascii?Q?rk2xbnyzOwCAoRPnMEuivqnk6jcrb+HBx5jjAzF0IVLJyNcwY/1DDLwOqzXQ?=
 =?us-ascii?Q?38ekF1zCXN9DpEcmgOGhj/3Wg0jKIhuFMvhuhhMHOv26zwJi2mQ895P2MeI2?=
 =?us-ascii?Q?BrddVwiPbnFUs5MTVBqFiVqcY4LYKGdvG6YgQuGWVsQs4m6ao6ucG5Z86bbL?=
 =?us-ascii?Q?poCvBsNSldWuG7GOs3luqL5inuKUXsL7rwzfR5BEkyjk41nJVw3HnOPRs+ZS?=
 =?us-ascii?Q?QZrWj+CeV6AsRNCCa+4qYSQxY4qE7Bq1wZU6XAWJCEIvODdQgCT5TEY7MFj9?=
 =?us-ascii?Q?uiXYfp/2fQIapPJMMqr9mz2hpm42HPL/tdJF/yrucuCyxzy9VBUjhiAoCid2?=
 =?us-ascii?Q?ZdSmoxueUtGfKbMhHEb5xQnkQuhj8ksM7eHqObWhqCFGBHPvnaz/VAdbaOZI?=
 =?us-ascii?Q?OPRYxMHCo/IpAGSDZqcxkJaoX8nAnRdSgHnnWNr5WB5SloeiYAlc9Cxo0++W?=
 =?us-ascii?Q?m4lol74RXXrXbKDa6SRwYUNJq4zklBdNOXZnRjtnOcVouD1FL2ckOZJGP/C2?=
 =?us-ascii?Q?B/02T07x67iZhM8oqYUlSXytQQaFDhusdyGoLGvczj9+cmK2dg3UARkYfK9+?=
 =?us-ascii?Q?LdNS6ZWuRRp8FQhmuTlS6C+31VApB1cEUqfhT+jWAveLcPvsDamWp3GAj3Zg?=
 =?us-ascii?Q?OzcSf5ExHdVW3IZEXGo4E0qNHU6mv4IrnhwROVL0W2tgJFj/Ep6smVq8MAD+?=
 =?us-ascii?Q?NiNzIN16vO7w1utZi+1S3ZASvweJ5Q8c1vnUuUF6dlY9zKdrYZBE1rIJCFvN?=
 =?us-ascii?Q?RG/iK0cfF1uvbKWYMWZ4IFqNz5Ft7xjm5au+VnwPddWMxwle5NU64U8vfaNJ?=
 =?us-ascii?Q?91TljUc1icuZPWz46hxcG2ggofnQWjBdiLuQ75HMU/cn04dxQ+h5HkEVHmcs?=
 =?us-ascii?Q?amVWtcAv2STRBDG5ThXrSHM3CXiZ5pZ21oW5AJv047URqPIyxfCyH2m88GN1?=
 =?us-ascii?Q?6SYmRaoacJAUv01HT2v6lG8XxEBzP6SBebh4pJwArpBRD8vGU1kk4UN1iOQx?=
 =?us-ascii?Q?hxeBqUpJ7bJ0uikTYt+xrZ15OfqBPe02Z+G3SFw8ENckrGmzbwy7DnGBgQWj?=
 =?us-ascii?Q?49R0RfK77KNP7LGx0k0Z3IpS3ykygL+k5VbNI3oZTh7hlTBehxpq1IDhdR6W?=
 =?us-ascii?Q?8zJadKmfJUJXlr4OVyetfcBApehIY4w2vWHnoBS+aG3sOhFbePr9AfT2hcnq?=
 =?us-ascii?Q?m12f7aKYx90iu1a4K9fiGqW8AZ1nMb5Y4d0/+tsXbQOM56YTJ1sJXA/mNr24?=
 =?us-ascii?Q?owJkZZZnua9eNyQKeug386KqMJ6BzZiy4dWrGMj5EkzWKdiQMJJnq2Apk2Fa?=
 =?us-ascii?Q?msg/NJP81/cKiORxqKrhw2RywwlIZMVApQeXCebVFlYAxdsfgfpFgFtXB/lf?=
 =?us-ascii?Q?62raLofTCKukzol0zmqZRKPg8t+QBKmmFgJxPghcDUUxUJ9RoStyKwAkyi7Z?=
 =?us-ascii?Q?3dsC725EucQqwB48VzQoAER1tXa1mILaAvrMoU1MYBlOuuMlvn6ZBfxAiOwI?=
 =?us-ascii?Q?fjGxc4NnkVcprsJMTgVhJTVy/0ZQIeUW3wyQWZ2xZdDdWVf9KDHaYS9iNt4U?=
 =?us-ascii?Q?+agXIyg/0PanGch1Hz49/w/akPqjIhxPaZxqcZiwe8wLEUbZwysnKDs27G6Q?=
 =?us-ascii?Q?5Xy7eAXCBHDqWAIK9BipvnDIM5m4217PTNYEpiNwdVRZf3fHu15CQc8Y1sQ1?=
 =?us-ascii?Q?4XYz9OEIIA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3d4072-068d-4953-49db-08da4a2539e4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:34:57.4197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuDU9pzgSRSZu3YsturtA8pfh5WSDv0LHsEMUDkYjkj+Zd0Udmjm4WGK+7YYK6om4gR87Aoz3j6nrKRiO2+cjw==
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
separately the 'ocotp' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/nvmem/fsl,scu-ocotp.yaml         | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
new file mode 100644
index 000000000000..136ffd074511
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/fsl,scu-ocotp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - OCOTP bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  Detailed bindings are described in bindings/nvmem/nvmem.txt
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qm-scu-ocotp
+      - fsl,imx8qxp-scu-ocotp
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  "^mac@[0-9a-f]*$":
+    type: object
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
-- 
2.34.3

