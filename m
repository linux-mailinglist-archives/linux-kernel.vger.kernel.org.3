Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E03544F78
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbiFIOf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245533AbiFIOfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:35:19 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10049.outbound.protection.outlook.com [40.107.1.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C57F32239F;
        Thu,  9 Jun 2022 07:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUYuYgOARxHecOLn/RhowTiNqzCHFuZBB1/r2xQxBo4wt3A+fZvE1VRvunkvuPYcKi2/lkD7rsiNFwiupzrc4m9kKIGRbiGxZ8SNjAbTadJmwXuPaftvgV5A8s/Awfxh0CDv9oxM7gYEVK0UZlMstQ9qGKCtcL8NsR6Mf4cYnc4Z+PqvJxGSKY5DmBrcroPrWAq+MPsKTH/WEd3NYj4NgQ3HZu1UB4F93ixFcH9gt9zZty6pr/X9az5JRcdhaDVdwA+iOwCYsH4lsS+v1/u4iw1/LGUeOpSaQXucc5sJOz153SlHvNaAkhvx/FPVC9mUvh/goWwYohahr4c77wApPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHJ7KKr3BTTj3gzs1gKfNtuSo9XmUvSvM1x8yKxpDQM=;
 b=oNL/he//vKgfRO4wv32M0NJ72uiG81llDB9UaZxFCtiYVsKhhRT3hz7KWxY+bmYp49p1d1yNRuSSPnDvdNP7e5QmyqUWsqTuLziokBQsCzW8jNw9hLJ7rgKG4HRlU6EK04jO9ymu3/wH3iCxcRZLSohv4Wov3rp1prTWEcVwopIxD31MkJD3s7L040zPyyhrwDZrSoElsIHinNSpTow1xcke41iSZkVpIvhzF/suJ2VahjfCK6KP7YYkZcDBr4Z2aLzqmigvFT+R6lFaev5t4dkZIncq3K4UiiztOJaw33/0SGvS15N3A4IDJpQn5jqJ4FLm3lD+lCcwh8EwQ1XKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHJ7KKr3BTTj3gzs1gKfNtuSo9XmUvSvM1x8yKxpDQM=;
 b=rp+xioOIKK+VDWLWopXLZ71uP94uRxb+8w4MB7XHVNVhDM/h2DWrF9uy7O2FK422CSCsFJPLxRwhZ6JiRDwPFyHbN4wfNd0wQO0WNh4uvVkIbVN5l1vlnfZBwGvH2DLHtJKnLe+kHz6xtvSq4XvIPs1JD2FBy+sAFxEnngBz5j0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5885.eurprd04.prod.outlook.com (2603:10a6:803:e1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 14:35:06 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 14:35:05 +0000
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
Subject: [PATCH v3 02/10] dt-bindings: clk: imx: Add fsl,scu-clk yaml file
Date:   Thu,  9 Jun 2022 17:34:15 +0300
Message-Id: <20220609143423.2839186-3-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 879fddc8-e319-4311-7237-08da4a25364e
X-MS-TrafficTypeDiagnostic: VI1PR04MB5885:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5885EE5FD822F442DEEDA633F6A79@VI1PR04MB5885.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lo/WDy019TpSpjS2Hz3bUGgonA41jpbPlvtg/qaYZ65MrafVjn+TOfltL8+8Lz7dOr/jt8Ya51wxR6kAHa8EY+oibgBD3UtoGBynWr0ovwE3+6OWhn3K7gGXqywovnWqa7bM2naoW1HGSVoIwPrqCLvUns2jdMOSIredMwvJo5zesBIjy9vlmA7mfK8+AV40xanqRAaWcb95/UnDULuBxsH8WB5dfKKwzgdc+sH4kxb7nVdvrTyITNM5BidfiSgxJCNttPRIAUGP6Y9DbBVmj5LZ1/WJWyMtyujcG+D0N58SK8SzIcUt6IBPGAu1tNxOOjNo6T5Rrq2Jre4A13EeaWRnd2lKv6NzWZMz9IEN7y/1nShrCl6E5/SH/2fxpTuKNgYrFCJclzc8tAqm9ufAICx26B1U8z2H3LQE/9VHKIVIFIl4C0b6m9cZAuFor4pNfs2+SEic7Xr4xRSzfn310ktYoW+JEp1tYBJwtFDqdRPwXdA66tHvwR0HRXAvfGNke2u0/sxq5bHYs/V8NIyr839SmI6rLizlJJqos5c7xD94S0FWmj0UVIqcv1GQw/wUy8HX2BqDK1Dl4G9nYFUL3MwHWmwX8gSuZSVVIUYyL8i6MdHeKst29PzU/fzRLQ9JGdtxeA23lC/kyPhaswj5uqrA+rIj0W9hTa+n6/NsITeDHPAmnWPOzx1DB6DKkzisGBE0CIE4mqA8DArkq2T53cRm+1ZVVbdyFGIzu/EdvAOX77IoB1Tb3Wz78R/U3Rfv8gY0bdIdMxSHbGAyD5OTr/wtal5BgTB+wE3Yyt3/gpc+Y9snFo4rGAIuRMLa+CAwdz4m/fpa3cjl0TBJSqTKY5mcP7jYfTve4O7Mo3kjRPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(36756003)(54906003)(110136005)(6506007)(6486002)(508600001)(2906002)(966005)(7416002)(38100700002)(5660300002)(6666004)(86362001)(44832011)(8936002)(8676002)(83380400001)(2616005)(186003)(52116002)(38350700002)(921005)(1076003)(66556008)(26005)(6512007)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wMYQI6ZcLSIZSd/zXAHPhhr4xhhoQ9RR2Uq1MmyMqwkhCMKcWZi/hzgd70OQ?=
 =?us-ascii?Q?bBVYKuNcAI9AaAvaktYzo+IIzkWr+OfV8IY1Y0om0G9uQ/M4fQT+yNR1JUw2?=
 =?us-ascii?Q?IRULgp88YhGXRJZlS7mMowLW4X8UDoQV9oCXZxAadfPcHxh4WJgjuVUYpOhS?=
 =?us-ascii?Q?HoIt8S8cbwwUiXL1RQAQsnBiUG6BLFGXxD2x0GlIGPxL1l0P6TSfg1DrvWsb?=
 =?us-ascii?Q?RnhYlky4hEXTVmmU1y6XRpl5FPuCUOPuaaGr8b2OdcnD7cX0C7HyvNN8KywW?=
 =?us-ascii?Q?LED7l3d97l0rLvfxcHu8zODYnyY4ArzC9qQQeDco5U31XafwVO31nqT1Nnic?=
 =?us-ascii?Q?Z+UOhPBTB22dEkoeNvOGy6mf1cHDAT2yO57X3o5s4l22s50oBNZR/hPNGWTK?=
 =?us-ascii?Q?aN3SuJJkMSDbXuwWcI+NPbDJ5AnmEWBSbJL5RZbgNp3YGZxODB6IIhcaG2Pz?=
 =?us-ascii?Q?WxtM5NX1RAX1I4zvoxlX3/A2XHd+UqoIXxVpUKkvBOgWqkWUreiGV29Jkx0l?=
 =?us-ascii?Q?qAF3OYzYYWLEDcgzlcvMq0kku7Msx7CvEboQr4aILsOPeR7hxXugHJLn0K5O?=
 =?us-ascii?Q?gWIq8t7aR6RRnbThhu7KMy43i4ZDUkMw3bgliTsG3IioNFzuMckjf/P89X7g?=
 =?us-ascii?Q?fYRUOo1nJdNeUCsKiOV8ZGiHC/BGLG5Pk55a0NakdajPer7taFEP0QbODy1B?=
 =?us-ascii?Q?igbiC1EsBrc3mZEXwYCzT5V4yCbT66Go1Ptg/HjlUpW9otZpSgpuoqxso722?=
 =?us-ascii?Q?zTz0ZIKgqmq6dCvDttzWlThgRQOfFDBlSz/GjG0LpU1QLr+5wxAmRsTSreD4?=
 =?us-ascii?Q?hmScE9/xEmFFh2anwYA96vXrgWuncSaEdc/jXPnf/9H2j/KZk9i5nJytKmzs?=
 =?us-ascii?Q?sqGfgbAKDhl/pPVXDXKqTAadIhWhiEUAK2T0SPMMQe/KIoe6JLW81NA10Qtb?=
 =?us-ascii?Q?PM6SEz1b90mxEHHqW7DsDJtyeSxHPOufkjkGrdtXTlkpbfVPauLE8+wB+8Cp?=
 =?us-ascii?Q?LWrLp+mUHR0cHe36j68Boge6/vUF+OmDpTw3Q8BtMZil8DJuyMf5F0hk7o1O?=
 =?us-ascii?Q?zHbXR8aEZqN1XZZ+b4CFEZG2R62szHqXCBCZXkkxkg2Ot53PMZMkHjq7jLTa?=
 =?us-ascii?Q?80RSh/hbWuZNHAPQwnpbS6lOHU0mPgWjX07PkAvAprqwkC4yYS4buyz1RX+v?=
 =?us-ascii?Q?Ux4vSxZUrRw9I6B++kH3u5AIrKV1U9m1jQU6PUvft7ZIAJYxPEns3sXadTix?=
 =?us-ascii?Q?ul200P3B1cFYplFGrp2NrabtsGrqzY23FRI0ytpCLc3OzS0IANhosAwhzrcq?=
 =?us-ascii?Q?g005xG1BxwevQYNChe/oApMKr4Qllp3+AiWiXii/UJt/2Z1LS32TLHTxtDxg?=
 =?us-ascii?Q?eQElJbrBNsghq2fj2cTMJ+TA786Tun7sYAxHTRmV3R7ph0XpgfeO3yM229jC?=
 =?us-ascii?Q?qG8CZ4cZmTo/3kcvF8ut7RS7kbc3Q+BgAoo4R5d9RffnVzBQF0d7zfu+qDeA?=
 =?us-ascii?Q?fLymR6XAGcKbvy5EA847E6sgs1VdTTcqma6fR1f1JXpFw6pejYeD6DPeUqew?=
 =?us-ascii?Q?E26FhJYp9kYZP/uP+D5+ihy7ci31+mSsV3wMx/u/exBYesFME4lN/YzeKSTD?=
 =?us-ascii?Q?sThHNLG2PXUST5ozix56SizRl+F2l/Ntztit86xix/UZlgbagea7dvgoFWba?=
 =?us-ascii?Q?+bhEIi0BsgQr49FTYtOU0LZYdDIsK2CF4FRAYXvIBWWBBFlvzVMvX2rk3mti?=
 =?us-ascii?Q?SLoBgWPQhQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879fddc8-e319-4311-7237-08da4a25364e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:34:51.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjEHsbad9755sj3GCp8IFFgFyzdQL/RBjSB23l3oTETj+DVecCVTAlQMDOiJhAQXiN/uJ3Qk4VpujglRQFDfjw==
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
separately the 'clock' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/clock/fsl,scu-clk.yaml           | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
new file mode 100644
index 000000000000..c5902733b7cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fsl,scu-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Clock bindings based on SCU Message Protocol
+
+maintainers:
+  - Abel Vesa <abel.vesa@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  This binding uses the common clock binding.
+  (Documentation/devicetree/bindings/clock/clock-bindings.txt)
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell.
+  See the full list of clock IDs from
+  include/dt-bindings/clock/imx8qxp-clock.h
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx8dxl-clk
+              - fsl,imx8qm-clk
+              - fsl,imx8qxp-clk
+          - const: fsl,scu-clk
+
+  '#clock-cells':
+    const: 2
+
+  clocks:
+    items:
+      - description: XTAL 32KHz
+      - description: XTAL 24MHz
+    minItems: 1
+
+  clock-names:
+    items:
+      enum:
+        - xtal_32KHz
+        - xtal_24Mhz
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+  - '#clock-cells'
+
+additionalProperties: false
-- 
2.34.3

