Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366E6543988
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343737AbiFHQuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343632AbiFHQuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:50:05 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00046.outbound.protection.outlook.com [40.107.0.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8963D490;
        Wed,  8 Jun 2022 09:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7I03scgUpT5YG0EIQBAg8un34cfVrOnkGTLItcSudIZ4q3RcYu5sL1lu6rlw5g2ydFyvoDoAQvy4EtOqTCHvquJW4pMERbH2HLskiAieAeG5OTYHovoWlV00qp3J6/m7PBLGoSCG3BrQSHaC/nKz9MxzbjNClZpxboG8KV/D1Gx/GfxNrCZUNHic4Z5v1jACUpbfMvrbZA4lw5Od18sPym0KLtoOWpDP+fq1SQ4Z7hDEhaoSuiEqu8XnAXX1dVDILyVqcbZhjZfC2dxfIHMMLZwc0hlZcT2H30lLWclRTGKRysJRgAWn6xO1czvrWh8RNgi4s4R9E+i5i2ZPl6LbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yaewt/MkdjuKw6yzXhiCokEoZ5fl6ffv4h57jvWsEc=;
 b=mwyI1Oe4aCpKjSR+pHPYt+CooVTq0BtddTcBMbB/8uGNDvlGWjxkuvnQjxClnZKoV0t1mOq2rz8jfhaN2h+1Yz/vPK6crTr3h9VR/qY2TNqyzYWGGj9mYFmXuc5/uWxEgJYAMeKDdd3beVDTpk/FC0Nuwxim/JHN1dolt5KwRkzTzciOvFBiRbpGDx5SGxc8vKawriJMU5wDV0/sydpihwJClKNq/mMQlhmyzhrlXxgjQLzs6c/k4cI7f040rAB9XcunPvqoy3gVtctLNfdUIUWMOPYmtGZvf75Xh2GSMuKsUGYohNp7BtvlAL7yHaiVwq30O8exfFAj+SX+UUHHHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yaewt/MkdjuKw6yzXhiCokEoZ5fl6ffv4h57jvWsEc=;
 b=YwltbfpLv/XvsR+aLSsSYw/gB9z8eavbDqn4mLO1kRx4drAX0q0+Rv/wkP/3eeq2FqGGQwJLw3IvQZmskZT/O/2PYFzFLmkxiwZr0vdrEnD5vkPhhoDymSikIoQU3AHoywkaOD70LPpzJ7sOr6rCWITho4/LXNBkzPVdPj+2LkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DBAPR04MB7431.eurprd04.prod.outlook.com (2603:10a6:10:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 16:49:59 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 16:49:59 +0000
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
Subject: [PATCH v2 09/10] dt-bindings: watchdog: Add fsl,scu-wdt yaml file
Date:   Wed,  8 Jun 2022 19:49:27 +0300
Message-Id: <20220608164928.2706697-10-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7ad96ff2-dd07-4c57-889f-08da496eec72
X-MS-TrafficTypeDiagnostic: DBAPR04MB7431:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB74314BA3C0CE6E9EBC26A625F6A49@DBAPR04MB7431.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iQUqGxd+CL4zNqqG+Sh+HEz+77Yk91a7daAyGqPGIpNOcNZ10Je41yzIblSLyvNNqDh+S8gp+KJ5J5ut2AVpPcx18ddCpxkOVljLrXAfYJBQ1U+r9Jz1EQbCkykx6+3ota+aJwEyVIeahO/LIW76jMqr+2NOg429uykX3PV1YueDiPmSkp/OdAh+oN//WoX8zpMaMFAzoQMUd5tHB08h3ZVSz7h9IJsvmMeP7M6IUo98AJFDN+h+60FijCI2FIUraD2REBacAANM6s3jajmFUpLr4ImViZjkATNuxX56f8daXhWmN5FaDqTMxClnTZcKMiiuwYX7EqT5Q3jGE6In6J/n9/Mcn5MWF/BKxySfv2sUY4J7MCLgMzZ+MnI87dskEjfzlvnM8JroQm1Rb1daR2/Ut6/eI45QUinGz2OqNrDJJ6o7j5jPTzqYjOLJFlrRFQzb8FJk+EZqHB031aaMi41d+t15jl7cPLIkv0auMTsAugrTljigvXBeKGugSCbmSCyDI3dinQWzn0n5vuDdEqI8gTb71BZUfs2n0RVry8qt4PIO7rrKliI6+0h5gM43vRhvNbkVKVjwSrk0C0HhzF3Xn1HG7NzNuwT4BTnJKu/ma9aIupetgM546SxOYs7/hu9f9M5xCkwn30pQNZVt7RmgKMxGw4UfTROy6MIL90cE6nEGVM0P1Z/4mcBP5LlNEkwfz1jYLQiDeet2SnZQfDu01v6IUc7hZRLuM5TT8nuoOA4IIDQxe6eGo8+XcrNSXNrAynjZLGQF9nLJKei/vGRLPo7B/7QAi5VMdRsOGbAKDEYOFKGA1Et5cn26jAJXvP89YlrY1ySfbZw0OBJJ2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(83380400001)(66556008)(52116002)(38350700002)(44832011)(4326008)(110136005)(1076003)(508600001)(8676002)(86362001)(6486002)(966005)(186003)(2616005)(6666004)(66476007)(38100700002)(2906002)(8936002)(7416002)(54906003)(26005)(921005)(6512007)(316002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lDfXuWYk99QQpcvWMS2MJCaUrrbF2wJo+umAdBk7tWg1KiwFRx7nR96UwwY0?=
 =?us-ascii?Q?nJs57QpV3b8xw6Pd2HxA3M77PMJo27HpIcBwygUO/AoDlvyzBFaXwKFJgQot?=
 =?us-ascii?Q?XUd51JUXlTu2OMU3LjZp7Yy6gOHy66kA5uWml8ATtPgh1dNZsfa0q0hBvHVq?=
 =?us-ascii?Q?saKE1POz2hf8AYRVobp4M7dvtba7W7ihlPlcBWEphaxn03AdHr/Siv6NQxlc?=
 =?us-ascii?Q?e51VSsNpOV8TPpFeyn0uEowqapv9U8QoDB2BCkGLmUj3XiKjmgZzBpZd+fj0?=
 =?us-ascii?Q?YecZPPwT+sdl1jyxWm8mtqDCNcUT6j3bMNtxViVsQG/mjFgXtC5zeGD/LYOI?=
 =?us-ascii?Q?SH+/S6elo8+dB/N3TmpsKrXwEFoh0wrtUGutNfzOJp2WKKPxHxOT+6CUE4iZ?=
 =?us-ascii?Q?SWOE5Vu0o7/KmxEBHGiMvkOgJ7rqIHI/LMm7xivIW2d6ZOrBWt6woxpEQEcX?=
 =?us-ascii?Q?gcxdq+GlSE6NxbD2EoAFtfGNR+UDNIBimTYlF0JIsjjYj74aLDbds2nGZbTY?=
 =?us-ascii?Q?MRS9pc5LgRyeSj6TsGuLA0ivFPf5qKNKdtOfGCLpQOFGMe3u9RvFAKIr6n97?=
 =?us-ascii?Q?PbH3ubF4V1kn1v9YmI3RKs+SsA9uU1+3pe7vscJlfM+ljw2r0Nx8HCNznQWh?=
 =?us-ascii?Q?7gMAOHICoAYlVYXG787QJ8FuuuQB0nybwXxVR2OWm1qqgmbx+plhUy25NIHp?=
 =?us-ascii?Q?/Cqx9cqkWdSdlH/bQLvYrGL5lB9cvk9YN7Rev2jsAJ4js7CggEjEgUTnadOh?=
 =?us-ascii?Q?tt9xpdZwwrWS3mRghESTpeg6L7J1t5uVaBXbUTMyteexr9R3Jq+hf0A4TtCM?=
 =?us-ascii?Q?lvc0f5Z+2MAbGzLuKARGWgU9AX89dGNKfvCf82J6+tl8EFnfExvOGWR7K3Rs?=
 =?us-ascii?Q?3/7nLaBAOA18MZr3wWysnLHjNaQvfEvGpsHxuqf71Y04ySqgsyv8e0+R96Ov?=
 =?us-ascii?Q?g9yRvKmHfSl7sn2596x7jZZPATIHetd3G4csCpq0GFm1heNfAKdsSxvMbbtv?=
 =?us-ascii?Q?PFU2zEcNl2VhkHEYlaRzFB42sTTARnoOgHHxJTYW4OKwLX2LlYLqSJTwyXyT?=
 =?us-ascii?Q?PXWhmYdTfhBCLhEANVq1Cmf/RnbLsFWTQqlupzIyaaSoy6IOHnEa7lIomJuI?=
 =?us-ascii?Q?8v0GtgfdFRzoiQWWFPFKCd+TFN+osU/m7k/cx50uRe4lz/qGA3A9HtKvnbJm?=
 =?us-ascii?Q?yplbTZwP1qbWUDO01WkdXeVU5PmJDQU6goJtp7bb68OnG3m+DqabKubIHE7W?=
 =?us-ascii?Q?2rQmEVavIyJHY7NvtXrtYZNtkb77ksnlc/wMTjx/zOVZj2zwkjkKZqb0o1Zt?=
 =?us-ascii?Q?KbV6LFt0pMVGZdU4Udam7EBNTqpgJxMwsP1wDJdnAyLbpwFWdqMxUcbCdbg6?=
 =?us-ascii?Q?1iyPLMF/tXB7BNiyoAYWAhc6Ndnpzxkkhc5JIk4jvVCtuuid/ldPpemi2iIw?=
 =?us-ascii?Q?IEPTdkYIDyg8xCDQxW2M9hbo+zu1ThfUjhl+++oncdGlfLTNRq9XQoPwRero?=
 =?us-ascii?Q?upxag+vgtmTbHslchv4wkqlB5NVCwMJfuPF9M0gYQ4KJ2D0OevM7a+tEt6xj?=
 =?us-ascii?Q?Mzv7NZMrLnDgan33gxKEehCt3u++8JE9OlzmcPJ2mx3p6ZFHHljapE1QsaE+?=
 =?us-ascii?Q?9RMMjhKm/0JtVmaFQHIIjk0yP7upVAc0YYJveAfqGT2A3gxr8RGKRWf4QQLc?=
 =?us-ascii?Q?hzf480+BSzRDgnPsDE0IoyhxuZ4ulD5PYspVJFYfOw96VaOtJQ+gweotbW0C?=
 =?us-ascii?Q?Rr9oOKMpeg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad96ff2-dd07-4c57-889f-08da496eec72
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:49:59.0224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: li0NhMKJI+xpECXs6WkZM7ZBYoII6ypdAfgiux4JGatU4Yvs5GDF3zeeJ0EPiKp5sIU6gQaCvDNfRMbaKh3UpQ==
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
separately the 'watchdog' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/watchdog/fsl,scu-wdt.yaml        | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
new file mode 100644
index 000000000000..74427673f635
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
+  - Guenter Roeck <linux@roeck-us.net>
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

