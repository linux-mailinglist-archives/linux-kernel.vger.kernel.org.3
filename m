Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E98B544F9B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241109AbiFIOg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343983AbiFIOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:35:34 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140079.outbound.protection.outlook.com [40.107.14.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B55322397;
        Thu,  9 Jun 2022 07:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUNchdz+VclcSEUAnaQp0YQ9AMinY57Xj8xD8ltpAAjZM8RIbxnAUkZ8jXVOtit5nBVrIESfDacwpUgW3EJTejeculBZTM4eHmzWxCSv6LiPjPOOFD775T0QouXXx8BwJ7g97VYDOupLNHuW6dYuu0ao0UbgG4b7YsK5c3BlOQI17IAzgQ66TN0+BC88sN/i7bUk3nGi5JOkOrIcbxhKjLNhpCfzWYC/aN6MyqwjLN1zm1oY9nMthLT3gn39B/1fektb9OrOtIqUoXoEbOnaU+Q50wSYbvI1K0oPKPlpLqyQ7eeF2EPnmtvMwbw4QiD2Mj2F6iv9dTnW9I9cMp6iqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZaX10cPl5rmEGJohVsrEEBQBMQUDFKEKWOlhuqBbsI=;
 b=OUEb7Kg3Jvp+nhIFnxpKSDJMDGto3rzlnbg0zrhBLZHG8yaS+mnZIdNZXU/RVm2P88oWxLUnDgBJ7uxuYdnR4VBYyXIueDJHEVbD7hqFy+sCmL4mmzOsgD0/a+i043xSlj2YTnM3x54eK2Tv6J3CHWpXA1ULXQGLFb7b5gzj/TJqFq20gynfKzSxmHRNcn6kZojwm7NbKQMuVUfSjKgBFJy6k1LPkiOU+I88p5aV0SZLUVBD4HSujkQ3uC1YiH7oqyvNE16LW1sEzqvsygFW0GEVnswas0oDRSeb1z5+LTdek0/f2ACExKs96IuiL0bwy2UVl1WG+Zj6r3yp65bHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZaX10cPl5rmEGJohVsrEEBQBMQUDFKEKWOlhuqBbsI=;
 b=rOFo0M1vOgYV69JvxLWCFem9Uhf9C7t1eM99m8Nv2fmQomLi9aw1E4RzceVPVuknMV2rQMaQP+hdhSfk4S+EhBLkxVZBpl6F2XJSxvvnIZUV2X13zE/cVnVm0XlC1sQQ25Vx4yhNd0jcOJ2L4Z+ADZR/tmQxyc6ViDc25xTi7Aw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5885.eurprd04.prod.outlook.com (2603:10a6:803:e1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 14:35:25 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 14:35:25 +0000
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
Subject: [PATCH v3 06/10] dt-bindings: power: Add fsl,scu-pd yaml file
Date:   Thu,  9 Jun 2022 17:34:19 +0300
Message-Id: <20220609143423.2839186-7-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7bba8f71-30fc-4eec-d353-08da4a253b17
X-MS-TrafficTypeDiagnostic: VI1PR04MB5885:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB58854444BC87AA18EE4D6BF8F6A79@VI1PR04MB5885.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D53AuuqICRBzXs+HGPaY4V7iBQbPgItAKF8QVzUMZOstEi5Xmp7CL1pJEjh/tVyl//3MqFCZF6AY6WyLtILCKSuUymM+5vvzKwMIVDTguRHH9cUIVLvtlndLTqjNi3Iw53UJ+MlrECbm582h+/8aK8KlZztvRS7EIRlqAPTV0xQ6Ji3o+bO+cwJlLPBZDhM43Z0uQ3+gj7f1IAiBVIY84y9Hz34eoLhTXnCtRwMy/k0hjWRnF+Gf7HfQV76lFzmE1NEgFom5UjfD+6LdLlCdQdhKXVS4sUgl3tHl9KqRtcfhXcSv+XmGuQkM4aasL3IDjMmlEVaht7eiYRLETPNHej0VHpLwrwAvqDA6J64ZhwZki9raIpEawEz5IpPOTKsE2s2CI8KsCkw91FEvw3xYDUE2y4M+Z1XwdEdiTAJetmr1DioezJAo4hcxmDjIvTNNJPFIiqW2vznwwp+QzuySWm9CbDqu3m9ZEm15Xd3QJ5BNhuY0UwaOUjguO26/2R/UeUKjNd8C+bzTaDxjpgDMvjUhANHxn9WSO12koDIPFed+dpfhNWeqzxEjEpbUg84z01dwK9sBf+ukx2rsXBDxxsbvHSpBgJkmQ+8Ug4k/YQm80ON3CsduCZNznKxckudaoxy6vg5F8YWwcWgG7eqO/S+8DydbGc1fJ/oxWzafNGUoiUacjEY0TwGIwYWqkmXehOmcHGJKjfFoo1i7cUjgp3Gd8NEwV41ICjlneyQdIQgswM75tcl1F7ip+WTHOtVRsA0e8rqzN5+5OuaUlZLtlYTBxfqDuWhel5p/naqTdGVl4hH6CNQFpKxCKrhO4A7dPOrGPPsAQusz55C46DnfA7WVC5KDdxkMcuZPAMm+J/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(36756003)(54906003)(110136005)(6506007)(6486002)(508600001)(2906002)(966005)(7416002)(38100700002)(5660300002)(6666004)(86362001)(44832011)(8936002)(8676002)(83380400001)(2616005)(186003)(52116002)(38350700002)(921005)(1076003)(66556008)(26005)(6512007)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yk2W4lKdBzZHu8yw/lVDjxfNOBSzqgd6d2kKcXyYfTnE2nS15wxrXMOoTIOP?=
 =?us-ascii?Q?AYjrlis8r9XgqTB5BBjdJHtAblE1RheGsKrmu5+z5tfV6iW0V0PPFCv0zOBe?=
 =?us-ascii?Q?dWmqbPNsyOCTwRBrcgNwG1dF8s25ayVDSq2RF5A7rN4F7c4ixXHzaNzWgUy1?=
 =?us-ascii?Q?uCWxGuVf7qRfXmHQqeswquuuA5sbhMc5gi/04O1RlsKgu7chjQ7PLKEOeqPm?=
 =?us-ascii?Q?4diDFe0841Vv/IhgoWCw8KTVdtmpirNpd02g6qTB6MrkxfSvDtle4XRB10mP?=
 =?us-ascii?Q?HGM9qEGSBbJFjnzC5xOz9Sdl2Ob2F34x+5gE0AxbvlmgM+FZiFom1pCp4S2i?=
 =?us-ascii?Q?n6GzgnZF/8MZcCKkNmBhsO1A+FRGfzOVnKQjCVNJhh8ONfihn1gw7sKQxw0M?=
 =?us-ascii?Q?MHhQmBfrkwIwUOnaHOYQRxWZB/pg9G1XT5MEMVsUUSmehAj+SzWKICW4x/Oh?=
 =?us-ascii?Q?MyeBoQbc5ikxXAWMzV1SZ1e3tLU6n0OBeyXHaGeVKebf0V673HWt0T+/fwnu?=
 =?us-ascii?Q?oR/p68g8WK2XndJMCgG7DlNLiSXhre6B+RMNGYhEYmXx4dki6pVRdp8KdV5Y?=
 =?us-ascii?Q?BlsPxr1ErpVytpZwJWLYYNAHlEele9ZRlkE4fBtGUw5N9pEjYsRfWs3VKAa5?=
 =?us-ascii?Q?WIa51EDlJPwCVNu2QevXzZqOvOlTZZoFLeL/HDGs0y8gKXRoRiBtYIXirIS+?=
 =?us-ascii?Q?dulny1zahPMS0mUyxqoSIuxB2ebOm45s1165S37lyFCUr/D28q6lks4qaAyt?=
 =?us-ascii?Q?GY329bblh6jUWXBsQex3qnHlanLSp92PRDLe4UmWaifusNwHVP9moKJXFOkp?=
 =?us-ascii?Q?azyKWu2ZKii5yG7TbDSPJjqzSR/ZU5PUYaq+sFrXXxNGRTfBZfpMYIg8bljD?=
 =?us-ascii?Q?CfLGA/lwzcwA4EEOC4zjkK24fadwmyI5nm2XQJheqRPFw4DanY8w6OdN8nXw?=
 =?us-ascii?Q?KNZPlsJI8vuEJZEvVPn3pBRniw80LCSZ0g8Za5Cm9TH3Z1PIEuz44Yvhmlyj?=
 =?us-ascii?Q?+/EAgZeyB2KsLfIyxrtMQJ1DL6J9Z59YfLDHeEARkV5m8iUBxPRKi2z0EaEl?=
 =?us-ascii?Q?+ADZC62G8z6uQ0iQpdflmkZxsQX4xi70Sir5ZdoHgdk4siHgXwt/HIKp7AkN?=
 =?us-ascii?Q?df9k7SGFA+KnLel0LZidSnC15vUPK0T2Qtfv2xhXct3inxUapQoXKZ6JLey0?=
 =?us-ascii?Q?a78jTnD2bLYTYWINrAMiKAqxllzu5qplVhW+E6z2ShhEFX2fPYpsrxeRLETS?=
 =?us-ascii?Q?ZTRIGPCgKbPwxEUTPG6A53VWU0VHw80DFNimNtykB4DKt4gdwD/CTx1plM/e?=
 =?us-ascii?Q?QZp3D28oQ+c92N5b6vmNvMxS2FoS2dgYU6dM1l3FYysn2d8sHwUPXRZ8+/yx?=
 =?us-ascii?Q?w/OM+xHlbx2rjm0WqbmwZFjokw/E7r/wvQPC22TtBd7gEb9bXtGaU0ic8T32?=
 =?us-ascii?Q?xbvnhXpJQUIazlcOgg3FR80xwvb7YxJat9QuzOItggHUBfVooHflWJabxkY1?=
 =?us-ascii?Q?zDIXtjwc/EWCQPBgnMBkFYif9FJWm6cuY6DqzIDkhfUzfyPzsM9U5G4KXDur?=
 =?us-ascii?Q?dlCYV3wEnRjZIr90hStgk+3U4O14/oFtdqBswdlvXWrDm9ygqAwoWxbr7fuq?=
 =?us-ascii?Q?E1QjB75T/Rf+TuBMU/dZmaAreolVHD9xYHBCaXHOVgIeANJG4trqyvo2TIVr?=
 =?us-ascii?Q?Oj7O1rRDCXA96LfVjqBzOIB4X0EUts73loMufCIssmC3WSOT/XoUWll6lpV1?=
 =?us-ascii?Q?2Xxm4uHcsA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bba8f71-30fc-4eec-d353-08da4a253b17
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:34:59.4040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvN/kLK96fxp7z4+YE+LBiEIl+hCobc1VQMgjSMew95ihSbJuF8BCEoHzFOXkZLKjTuztMrmmGgOug9jP6PJHw==
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
separately the 'power controller' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../devicetree/bindings/power/fsl,scu-pd.yaml | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,scu-pd.yaml

diff --git a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
new file mode 100644
index 000000000000..b7d76bb25016
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/fsl,scu-pd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Power domain bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  Power domain bindings based on SCU Message Protocol
+
+allOf:
+  - $ref: /schemas/power/power-domain.yaml
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8qm-scu-pd
+          - fsl,imx8qxp-scu-pd
+      - const: fsl,scu-pd
+
+  '#power-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#power-domain-cells'
+
+additionalProperties: false
-- 
2.34.3

