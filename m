Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDC854396E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343656AbiFHQuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343597AbiFHQtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:49:53 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50053.outbound.protection.outlook.com [40.107.5.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F996162B;
        Wed,  8 Jun 2022 09:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXdGTIiZfxkb1oYl9ogkD/woxLL5r9Q8JKJTB2iYQXvPamcmqqWApnStiN7DWaRsa3hqvoFOp+54Nz0+1pbXPkC8zuUG6YJqBwaN9qCZRq/B+4Rn3YOFtEpmPocBohFWjlEgi2hgj6aOIoIgK88fE2g+WUhgNEEK/3Y/Sc1qt1gJ9uh/qb4JX5f1NgrN/FMxOwUFzFQnuRO7Uth6rg+9VHDpLEkEzYZkMPeqUTBBIZsRhbDY6WZVDmRj1B9RrF7a3gISwFHvthEzLJP426RWKJVnbVLSFs63Di7lvMQAPGlb9bMjEDKOp4retnJCSIhh72t24VDoXVu14+FlE4Zu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENuM0AEC2WBbG54zWEJInVrHHikBk745SDwQcV9U7T4=;
 b=J0bRDKhUhveqYrn9xGL/jeKHhU0DzQEKJotj5XjRQEeKX9+Aj68PLT9dArU02n6smFCZ0XyO5N7LFdD5AKSHG2tFvY5aMmoMiMz49hSUwd0yUCiQbuO3N+iPRWs6OxEP67FW2fmNkAyQpKZ9EveAZhJ5DQbv8WE6AQE4K+a9OA0+OdI1Oenew5EkzAOuH3cItvgb3vkBMe6uO7Jreznt3rQ2jX9G0XPBe7l0ZhMRL7zKnCoCrRpy0+ZVs+U0cax5tXJBTxX5eOhT2u6Y7OLHwB0L0HkFRJW7cmNvpIQ+AKCpXyYBI56B067bcUFpM11JUQIL3jgutmUHBuBRzc2kWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENuM0AEC2WBbG54zWEJInVrHHikBk745SDwQcV9U7T4=;
 b=mmRM6U/+tVTNYKL0jeRTNIiQfomhxS1UjmUype+ZhLLPRQ6CiDkBwZvZPIHXmR1v5uxIZM+fOHOzgaLPG5mT1H4goI+3obFUCajuGnua3RKE4Bc0UgiR9B+0ik6bu5tdahibCTB0zUWcgQO6Y0kvPpdOqcle6YN/rFDkyFQR6hY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DBAPR04MB7431.eurprd04.prod.outlook.com (2603:10a6:10:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 16:49:49 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 16:49:49 +0000
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
        Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 04/10] dt-bindings: input: Add fsl,scu-key yaml file
Date:   Wed,  8 Jun 2022 19:49:22 +0300
Message-Id: <20220608164928.2706697-5-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220608164928.2706697-1-abel.vesa@nxp.com>
References: <20220608164928.2706697-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0701CA0052.eurprd07.prod.outlook.com
 (2603:10a6:203:2::14) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61aaac98-b4f3-476d-97d9-08da496ee6d2
X-MS-TrafficTypeDiagnostic: DBAPR04MB7431:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB7431543D9107788EFF980B3BF6A49@DBAPR04MB7431.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0aJH6cPNNbe8BiKj0AUloFRmL2nmeUXVcC+bwasUYAMQTQahWyp0N6k8b+zpSnZtv+ZxwI23RKj//7c7bWRXD9k7u3I5nl8Y/Qra14tv0g9CFUxtAJQLmuQeEvk+nqyAqy8QPldeubpB9lDa2baELQUDZzu4s9e5sj/P44Tf1REOAwD4aJbot1jGdx1hFfvPHeFe1OGGqhnLn70LHm66JiImSgsGFIt3B07HSqSjHHn8IAcAqVPY2mmRx7GV1szCvpgdzNw2jNE66ObXoK0AxI1hDnIjv4DQPxXjTYVM6XFCbo9hNz2xiNDW4B2BJVLFwEHlKsy7RPeApy33WrwNfjl+zznfElcBZNG7pJDbgQoOl0/0dgAbBwpBUSFdrCJif2RAgcxVY7rYJxrqSWivfJ96cf89JFy7VGfWHtDzuaXYjiu+lecj+CQONyr1fXT5k9fbZdnl2ocu1vdMlRh6yyRXPTfLM5FKOwI9tgIWJasuahK9ZBtCy1zcpw/SUlfZm2nOkGaPW9KLnzGyU5F35GMwvHMfCxCC6yKxYS05UrLt7lmQtpvsV07iXEMpz+vGoutajf8/OWpirWO+7S0MUwFPkVjbR+kUcXnF9jdrHwfYliUU2dZjGw89qPO+pioSXJNvn/sCdMGXN78TJ20DWfTiwiqWFjRVTUuilmnQSeCsdhYzpbPDuAhrZlZSnTMWWUg2kOuXqkrIXTYMIewPEjp8wUWl1Z1d8v5HRln5L+/vOfWms1q2BCHDsDWCGUYde8bQS94VB9xZ8byiz7vUNwYJsoMU2+B/1yhx32a1bHHPQSe9flB0EE8G7m+52+abLYR5maQIXno0+b9/DImVFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(83380400001)(66556008)(52116002)(38350700002)(44832011)(4326008)(110136005)(1076003)(508600001)(8676002)(86362001)(6486002)(966005)(186003)(2616005)(6666004)(66476007)(38100700002)(2906002)(8936002)(7416002)(54906003)(26005)(921005)(6512007)(316002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6SjpHHEmNDmAcr4/RxZpI0ofu+7rdFvuNb+rPEnpz89m29Uy6u6lC0wPKtHG?=
 =?us-ascii?Q?ya36LJlQ1Bo5MMfvb3wvYtyumGlknzduIM3ee2w4EKAE1XGN7c8rdp602VUk?=
 =?us-ascii?Q?haHsSaJ/x4GKweK3USUHSaocx0mLma/mmjePn9tqeEp1/j9Xuob5G/4RHPJJ?=
 =?us-ascii?Q?RtpmV/HElEAvuRNIOhzpWYzuYjlM60AbrokUm0p9dkGhVo8z9ko9wAdUsfTj?=
 =?us-ascii?Q?cra5ovvpAzvM2StiY8sTA4zM1apRVij2VQ8GUWvyM2Uh623mt392bH3VKB29?=
 =?us-ascii?Q?kyAVsSDdFgbyrndwZITWgXRPZSVzYKtl7Jc5hRn2GofyCU52B1WN6Y+PCLCn?=
 =?us-ascii?Q?KIeibijKcjVG3YM9b9P/r3u+5P6gRdjtqwhDfy8sQIggp5rgqBj6ReK/jVTh?=
 =?us-ascii?Q?hQ/553zKu6aqw5k+hL+CyIq+HFvJmwPOV136fgaU+JNNdSWpxUwmeqnbOM/h?=
 =?us-ascii?Q?oyrI2nlPZIUGzVi+fgxyY5rBI8h/xvcNy9ojq2DK2mqPy9KpH00hG+FwbJhS?=
 =?us-ascii?Q?n03YTWDDABMHEy5UyWLcpOLjnsyUs5/MT2m8Qhmt4PnXfFvBwnlQ2OGW4+Ka?=
 =?us-ascii?Q?1hEV37rQcf5U0KBRme+DNEl7WKeR/qVp67RNxAsH5HM/vN61MIep5HfVjeJl?=
 =?us-ascii?Q?ZVMxU5CIT2xjdiF8weE5SnOMVaQjIXessYFqdW4UisUSmZy99gqdaLF89wUv?=
 =?us-ascii?Q?C6XnTZVWxKISc5Cc0wXwi0SiR+U8wrFWUxVL/Z/ronNV3XItmsJCc+lk95u3?=
 =?us-ascii?Q?HUDO6IFvhg6EpZQmp+pkFN/Up0dLCf37cE2WAJZtDTRPd20DhEm7NOgNTTXD?=
 =?us-ascii?Q?oRYt33NYQFcwgNaIlV7dwcoBZ1rDWKdsSLlrGtXSfyh8F9kPUrZhjf1Ebl1M?=
 =?us-ascii?Q?vtO2RYTImviqv600K3D0dxzsJ9vf1Vw6taT0xvrNg+UgK/tnEW/QnL/1vzT1?=
 =?us-ascii?Q?7ihttag/WTZ2XU/9+08xbCet4apfC+RAMs63jfGUb+WZt1pQ39vyxk/6efn0?=
 =?us-ascii?Q?lI/xSlF+J0Vd7aa97tfZ0E3f0ciy8/KO0QUkLBVkOQc4zh8bs0HH0ZPwSpJP?=
 =?us-ascii?Q?loQeMFIIoAn+ySvleOSzkjYu23G84oAQTzM5Q/FSGFScoNpZD6gbw/K3wnVJ?=
 =?us-ascii?Q?e4xjGzw2/x/oET/VrAVaiaCRXhhP7996hIlygIhYL/tfi3LKq5LSFZWeWBgz?=
 =?us-ascii?Q?rqVOD0OHT85tcLAk7JD8Z6kz/sr5arT/j6jAFmXvRj52FaHKcvsmJIkCheMQ?=
 =?us-ascii?Q?KJDkPao05Op3U6qhddfldgcm+rS2SOPdG5t9OaV1yiGnIxJYtLWpoqNH9eL/?=
 =?us-ascii?Q?C+YrTNxWOoy4e+3SZiQ/NU65Kh8SCXs4SAtt7CQbVDtVjg12fqYc1jSOQlKP?=
 =?us-ascii?Q?5gaYYiLgqizhI+DcQK1zl3JzL7l9VgNIosWQzFgTz3Cb5M4aPPLOEjJu4VDS?=
 =?us-ascii?Q?k0EnnvkQ6bqQY80rX0gTmIMguffnCMSjlUvNtvpnPbV9/qSSM8zMKv41vCC6?=
 =?us-ascii?Q?EB4baSqsnQGUCxV/hYEf0CpZhPEJ7mu3mHvPEA32u6hYk7eZ24azh0xDxcuJ?=
 =?us-ascii?Q?FNs/a6LCa99BrDRwWXH/D4SNp1jrjWG6GzokIhhouD6XgY5jdRKAMuA7jBn6?=
 =?us-ascii?Q?SGw1/bJ2EYfkdnmBnJh+zURRKpEiGB/VwMtV75f40rwHg8+N0UTPjhyUb158?=
 =?us-ascii?Q?U0S95Wm2u1E6vzrcUa+UDWkjmhSasjhGEQfayOMfg+kuBc5HjEky5aHxTq5/?=
 =?us-ascii?Q?dJXz40bW5Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61aaac98-b4f3-476d-97d9-08da496ee6d2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:49:49.6168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/8WiP/KxwMivVeRbjnhm6luh+uFF5PT80SG5dWwFPCLKNO9tsTWj1NAlm1V1gWh9i4eB5uTg+NZTR7Rrj+6pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..c0a563aef5dd
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
+  - Dmitry Torokhov <dmitry.torokhov@gmail.com>
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

