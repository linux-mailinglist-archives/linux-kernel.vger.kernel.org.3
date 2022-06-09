Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E74544F56
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbiFIOgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344012AbiFIOf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:35:28 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140079.outbound.protection.outlook.com [40.107.14.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EC032163B;
        Thu,  9 Jun 2022 07:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKW8FgG5tttJCvH6sLLS7mIIKOC2thFmw8V5EUH06rtUEU1mWDqiYHa1aOtX7fTD/Fxm4zLbIZn/XBwziCQ107oMxww/UEh22+FHVTLzP8JWhKAY5ReTyt/UD+9grb6NFJ0WT8HaGbBkElDJ8kkJJSWxuKf1jA14vXG60pz3XpqpMzlMy8xBz0akhwwqViAvxKHjKBMih45LFcexOkCkt7KroA9xOYGCBGQgI914sEgBD5ODc2sKf8AJundBNzdv6IIst+V5jDLlAcdqw6xlvEU7YRTUjXIuOOhFqkiF+jJcIBAHDW7B8R1Y2zAB+3xIdo60CeDNvt4Y01ra7KB/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uW57PMaLvRqfh03PPnQdRIsNlnrD9YMR+TCrIKw/2c=;
 b=EVufpN4ZrdN5jGOOg+/iMgV7b1KYUgWlJmXL4galAiwEHyJd0F+kTE808TqCEVElOewO5F/MTnckyJjrGT/jcflvkhFgwH02MoshbPzlh+n99jB5kRcrRD6e5hOkK2RITfMdhqxzL3R1LCcC1GPU+9DbcFbusknwMQAU7wzWhGVXTx9pkT2FoQzY8IlQjqTnxSN6amshrx4/rdMyht0z15Bjc5jPtb+jRzJ/RYts880G4BO0DhYibYZGPCwgvUz7FJhS2uUWY05/+wTnu/VFamMHO4QSTf/XUmo6MZR4j3tRehZA2yGAWywA7qy7Mh/cLtR/KeS/VB2yDIaIvR7uyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uW57PMaLvRqfh03PPnQdRIsNlnrD9YMR+TCrIKw/2c=;
 b=OVnPX/qe/4vPdj9CD6FHgnmKPPM89Wpv0P9F008fkFyS8BHXkFBgXR1CgIHNR3vOidAGyDNA3FOKUfPQxn8XDhsT/bS/C2L2QNDtxnvJrrlN24ID/563+GkQvZxyJdTq1M8KdqmtG5nHoPW9tX2rFDA2awuJEBulq69+qGsBZSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5885.eurprd04.prod.outlook.com (2603:10a6:803:e1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 14:35:15 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 14:35:15 +0000
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
Subject: [PATCH v3 04/10] dt-bindings: input: Add fsl,scu-key yaml file
Date:   Thu,  9 Jun 2022 17:34:17 +0300
Message-Id: <20220609143423.2839186-5-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d9111211-4627-4185-3738-08da4a2538a7
X-MS-TrafficTypeDiagnostic: VI1PR04MB5885:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5885476520883976903F81E0F6A79@VI1PR04MB5885.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBSjNMKnIYc7xq3BP6XgFYUs8yAC4ksEPfaV6Jb/TEsKj30j9KWgfTU1Nv/Lc2qJJYJmxohmJwak2pJBBhh5OqHelXKkXSgy+MnC+VRRTltbosMrwvA75kgwPOM1pQayKAXWBlSAQoRR0crhF7TPr/hOwmA2FI9RQbhW0bjWyM2QZ+Tm5zjqQh1xVzNWnhnFzOk6CwcTShmAsfvOtWBZQrL544rG9KitfQln7PSoilpxczyLJD0seMSasEsIUAJTWsfgOcVF9LBaDTjsrdK2ROinRUC6V081IWXZo51KDzJERqTXtEeoMquirbJQy28JY84xUSxlEvp77vkUsxWwJ09CDpRvuXlMwVPGFAUBvp3PT9KGn1MIAZyb+UeHPtsMrjoRZAvOLlata73PI4v/pKB+khMkOv0OOb6DstwH/yLA8ORTce80LlHM0Z72T0Nn6PHOY8/+KQI0zlkh1nP6VQP6WP2vYidguoOFTUET+50uUirNpKvWLgA9Kd9uFVz+N9gOb8F+zU6m6VMe5oK7Yyr9Dhq0R7exZT8R9jbKMPM9d8EB+18UPAJYzsYDNsgwM5RA/qLNh77ZAZ5jrbrXPiOIfgoblXrAXofqstNxbCEFqMIBDWWtsgfSuRyUgi9W5J08yTrdB0dMkTqluvJQ4ElXJCvU/ovAkykCM8W5ehSawOjPoZ5acknUU6UAPUwfV+2vOg5O5vHjSPfJVMLggxcqgh00oaGVKf39X7N1RB9NPDv3sfV0hsXd/moQ8G6wW7QWckSJSDL9+EOab0N90TLo1QNV+VS1lYCZrtPAaimEi/Psd7v6lg0oNs3jKHMMBFyLP8x/1p+sVHeTBNfgppzFTMT4TDnvK7CW5mWPv2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(36756003)(54906003)(110136005)(6506007)(6486002)(508600001)(2906002)(966005)(7416002)(38100700002)(5660300002)(86362001)(44832011)(8936002)(8676002)(83380400001)(2616005)(186003)(52116002)(38350700002)(921005)(1076003)(66556008)(26005)(6512007)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/h88/kZKIY4wzRHb32ojZLy2UTVJKq964ukN5ndaBlPmzsid12W0jA0ckL8h?=
 =?us-ascii?Q?jloUEPaEd8XcHJzeyiC0EjBr/Dh9wAB0Kr1gscML47JV4jOPPpUzI9saNkeI?=
 =?us-ascii?Q?D53wuhoA1wmIxRI83NJ+d7CRHCzQPBLzAw7dHatGDBx2QYdggXvtt3KPzW8A?=
 =?us-ascii?Q?VaYKJ52XZUqWg3sOYPX3+T/UJ6bB2d9x7bPiOzpUyl06B0f7lnF7Q4YQ9TtB?=
 =?us-ascii?Q?tTUyRmgPt5WYJxwOJRIHb/LYeIN5cxooawDhoh4OnZkny82nG8pDljk8HSn1?=
 =?us-ascii?Q?dXwbxGAAp2nk+f9Z5rTtamZtPbwpxpOQeVbpb1COrvQBAnM+TiI4kRxaCpoL?=
 =?us-ascii?Q?LwdEeoijZF1ng0+76gSBWowqVRhDmFuxm0Ngw53V8yN3m2o6Ldzj9gS+su4/?=
 =?us-ascii?Q?+Gik97W37X1nox+Nb00/lRduQG7vAbiEqilBNXEj2/GZk2CcQ5tkAoYmTjvf?=
 =?us-ascii?Q?axBplBjfQeEgG8Ho4G5bDyDCGVpvI1cKWtWh0UsAIWg5etBSwLgm7JaUQNy+?=
 =?us-ascii?Q?DeHnoNg/XpXopfuTiIlwOTFlKPES3yAcLbV+mzyjkP/ipgCZIWg2xL/6iPC5?=
 =?us-ascii?Q?lota4G5czL1EXxq2T3/bA8wemqkYuVVVg/nTeMAQO2Lg9OKa3McX+Dh0KkWd?=
 =?us-ascii?Q?XeedGcEqc4hbBm509QHKdQvDGsYNxinkx7pfpVLtgNF1DI/07Km/Md+YJEvE?=
 =?us-ascii?Q?aVPn7/Egvf3CfV99oP+fawb5C0QL8dacWFnwmNltBTUvc2Z6DLK97ZQbkNuY?=
 =?us-ascii?Q?WRd+iPXhMGOCtkGPDoYus/Dv7x5wy8aickTPMS1xPQ8YTtPy/1y08eupuQq0?=
 =?us-ascii?Q?MEGBcyjkgAzzwqvUyI8NcdNMdU0RzOQlBsnw2W6oODqCXVflYkrYxvwAF7mQ?=
 =?us-ascii?Q?+fPwgRWXAuq4CNJe10DhM5OZ5UNSY2BykoxEGB9rCZ3u4jr+aJ68sGTtPTKZ?=
 =?us-ascii?Q?KFBhdsiWJwnAMtX/FHYpMAgaDPm3Tfjl2gMYUQL+HDBdmaihz3ni2AXxx2MW?=
 =?us-ascii?Q?nNiovvXpcMu8aFQrAmOrHQmLlv17WiiPvInf2fMJqS6FLTE2m2RUdkGVdCEg?=
 =?us-ascii?Q?tKmM2btiyQsXcp/ULxVPurVI8NvIWeYJYaQ42aSxG2Uv8quDn+Fmbf5O4uIy?=
 =?us-ascii?Q?5HoodLLjwQ2FpXEjhNgLH64emQpKW4GguPDeRhRKg04nVsBDT5b5PBDBP63f?=
 =?us-ascii?Q?09edO9HWYp39HPjsf7XX5iv1Zec45vo/M3x0v3zrRIA1NGftVwitEokeKlNR?=
 =?us-ascii?Q?YPJVp6TEbt8tQaWmS49GcfrgjHEaA+vz3U9hh+tdurkRqHIU1rRef3nOhm41?=
 =?us-ascii?Q?0XG0Qe08gD7L9oBPOHSuA6oysA5a6PCyg/h7s93vt8FGFs1m8gnsZCIgNiAJ?=
 =?us-ascii?Q?M2Rwv1AuugMHIos6Hk9QNxXhKEYoaZA+xlvvDNict1QO5F3P4lyNMlf5YHRp?=
 =?us-ascii?Q?klgztJQ3CttzdlaAINU80OoV4HopjS/hyeq5OJ3NyaIBB6iA73BkxoqV0sxU?=
 =?us-ascii?Q?QBbBtK+85SqGXEfHSuepX2looEYQrSAsmk8KyYPkVj5HekrwqjAnWmP498ap?=
 =?us-ascii?Q?ucn3Me+uNayf5l8Hi8zC5i/Xu6WrjtzJ15L4XTGKWNlTWDdZsgrLaMTDu/95?=
 =?us-ascii?Q?KV/4/Z2SLRH2bk5rP+9rXlRKZMXVlTwAMSU8emslZ2ZjZI5K2mckQmEQuOpT?=
 =?us-ascii?Q?u9LATSTjrXUja9L9DViWHZg+EicJvLrXBa2OKoIy7vBc/lvFiWpTjQIWZAkr?=
 =?us-ascii?Q?lEYkTbMSaw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9111211-4627-4185-3738-08da4a2538a7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:34:55.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6FaI02G/3r8eCcYLEEcIOafSANv2b9EnvsZM2EcRkZezjzfsT2ozvZPmvE2XmFfO+VYDtJJRzTZqJ1lHQBokg==
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
separately the 'keys' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/input/fsl,scu-key.yaml           | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/fsl,scu-key.yaml

diff --git a/Documentation/devicetree/bindings/input/fsl,scu-key.yaml b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
new file mode 100644
index 000000000000..e89b4b998076
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/fsl,scu-key.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - SCU key bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+allOf:
+  - $ref: /schemas/input/input.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx8qxp-sc-key
+      - const: fsl,imx-sc-key
+
+  linux,keycodes: true
+
+required:
+  - compatible
+  - linux,keycodes
+
+additionalProperties: false
-- 
2.34.3

