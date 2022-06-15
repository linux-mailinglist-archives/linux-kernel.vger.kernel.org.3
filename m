Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA04D54C713
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351801AbiFOLDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348633AbiFOK7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:59:50 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A797D527EB;
        Wed, 15 Jun 2022 03:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GP0QaHM1C6tg4qFOStrPus1yv+Q1SmK2BxuuA8eD5AXmzHqG3FzzhPOWQMXtGx0pKnGN7hLwRUMkpERMAphP9fHQ+2UsyYiHrwZGKxEO7VERM+DDsMq4ZsTA7nQqhqVz4tlq2Y+FCMY2+p052R9eUSzvRG0O0MMPCFp3lL5qTePc3+DztAQVEaNDyRHS6uXP3KZrxJZoACS7aEw/ozaOV5R3TdqEjMsAG3T7wTA0KTm5sO5e48uluFNhiVoOyLkw6Mo2lkSj+Q50mx16JCSUCel1vWc4wtsQUOQpfCjxU2BkfjSsYnm/ALG22Uxo9/ZPGkbr7iiQViGGu636E0UMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsB3AHX5PYn5ZOkKy4oLVMPx8x4wcVAZTqyKV0p6miA=;
 b=NQK/fnmrXlX33kMCp5+6mltl52qJgdoBVXsky69PoxYqlZ5FpVl292AgRUkJ6AcabdiA+GgLOEMynKFCQqE7GFqc5Vw83BL/ty2CdkdDXPaeYVeZTVYPLVTOepN1LvMRkS6n9JwkuRvsgYnWp6a1up8amLf9b7ifyTYpttx0kBowbefa5mfzlaJWpctRlCio3+FGEG3vrTQ7miGfbrYwDL7DZU00wOvBufeT+xfhLoDnYjF6RG9oiTADqNvLntAi2BiY2jmb49q7N0Er8tZ1mfRt0YK7gFJG7MMxoXecnvPfSBLZ5AdqZH38nuIqpTFegl4G7YdfxvMlLzVkScGprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsB3AHX5PYn5ZOkKy4oLVMPx8x4wcVAZTqyKV0p6miA=;
 b=E3lWmZ23v7RmVok3dZeXmS9UTHLuccIPB7QlPlDNlSDoz8eydR7edog5iI0jypatkJoVOAYBRlKrn6w6gM01prkQnAQd/Nlw6jI40t8iNDsRwyZghwwZJvLWoUCgezCe7kTY6ZnFvvK+GMSsw+Y126jYDeeg280seBusaoCmB9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR0402MB3939.eurprd04.prod.outlook.com (2603:10a6:208:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.23; Wed, 15 Jun
 2022 10:59:46 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 10:59:46 +0000
From:   Viorel Suman <viorel.suman@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Peng Fan <peng.fan@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     LnxNXP@nxp.com
Subject: [PATCH v4 10/14] dt-bindings: firmware: Add fsl,scu yaml file
Date:   Wed, 15 Jun 2022 13:58:30 +0300
Message-Id: <20220615105834.743045-11-viorel.suman@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615105834.743045-1-viorel.suman@nxp.com>
References: <20220615105834.743045-1-viorel.suman@nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0159.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::26) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a020bd86-6549-4818-a436-08da4ebe288a
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3939:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM0PR0402MB39397DA5AFEADF46DC77B74A92AD9@AM0PR0402MB3939.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNgx/skCDU3DMtOWNnUvMq3B4TI/Cjtxhm7hfP6R5sYk1z48C1IiCaovcuGXVoQJs2UbDSTrwRWAZAI9uFh9N4nkcqCTzzss0IfbChmaNOJdf3x0wEPLtm5UTH7uBmA4c74oM/XbAB61NsZJ//YymICW/m/gc1Pn+Ne7v9ls4CrKDYP98fMFUJgTWzjd/iymuy9uvBA/PoDQ6ZBanQf3rHtESbjDE00OqvPsdoZNWToU7N6wRZ+13+pt6zssbKtzLKrmRcUgJSbNLmUjWz63ZfHRTlH2RrDBs6I4lr8cBFrYUMyXCZcZFWymMXP7MSvzJ0p6HZUtZTeHvD/e12VV5e6YbzAlFPuRBLLS1/Cfotcqlzz2dn5l+RoqenzGowdZw9lKfv6q0QdmCT9jFonu1KvRQO2UdczCWftpTH39w+RPEFvQxazIVrwG9xodltUtw6giOMLDHBSwa1nsw8ouxo+0Ga4uee1PnC3t0RUASS8HJAElgfQ/Lb+RLfgSR8p/9oenguSFEqpwhNFlQ2oEIvKn4mtgH47Js+ip5kBMtv+pVlsToyg/aYWWgqqiEFjBJYh2xQeFs7/i9StcWDX2KhThHsXm/nNt2xgbbB6UQh1gQmiDKpt2ux+Z+HY0FtREeinkdJHLvHD+0W8ZYqvlvO7+YVuZZPth+8RAqkBojoA872Y3HPb7eCDpG/epELw6je7TNnMghdV9IxyccC77m/sHmbC9SD3itCePzCF+NoKokHtPSRF979IG+fZrb0Rjl7TNpmcLE8poysMl1j9YB2bOx6EdhaWKqQyu3S2xVgXvPU83mzZ5hECf5Po8CBFVsg7K7b0gLGt1erdH/kQ2RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(4326008)(66556008)(66476007)(66946007)(8676002)(316002)(1076003)(2616005)(8936002)(26005)(6486002)(38100700002)(966005)(6512007)(508600001)(6666004)(38350700002)(6506007)(52116002)(86362001)(5660300002)(83380400001)(110136005)(921005)(2906002)(7406005)(7416002)(186003)(44832011)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Xv0jEqtW9hcZVJJIWCCDNu2Qj6+mGcOLuDyv5dDKNVWihwBE7tEfm96Lnf?=
 =?iso-8859-1?Q?uvzqsLMZHmyH9UybwmktzrJUTT6CBNQNqwNGTo9rR6o6y2TEXP0Vb9aN2O?=
 =?iso-8859-1?Q?4NI89tcJNJliR5w2FfmwGKj9guvxeckVnXG2WvjfAjpZwL6c6EYbEXgDTL?=
 =?iso-8859-1?Q?THU43wIiY3RcypXzrriCYDC8WsYJqK2gzHJxZVW6CxM+tWNFZqp5FwVbx1?=
 =?iso-8859-1?Q?GFv1+vT4TVBCLIHV38VE8kxpITELoaKrPdH3lEUGZUVGFzRY5yfEpWzXJI?=
 =?iso-8859-1?Q?U2GisqHc7ulURPUwb+Ukk+mLK0GxzIsfM8ATvGqn4ZN+3MctgW+30et8KX?=
 =?iso-8859-1?Q?N9LfUHQyGgSbgTdywrt1prubl+YmahcdqBsDfGvsQbbtvozzuVb+sH4QgE?=
 =?iso-8859-1?Q?4k1MnGhvEFl3UfSicQPbAsA39bY/lvYGYKZs+Y4MAdMmbEL3aOPGMjH8Wo?=
 =?iso-8859-1?Q?IMDtoM1NWKXTwBLMsaA2BY5ctpj64KHaMEPkTZpeKScLgpgyYQ+M1iQaya?=
 =?iso-8859-1?Q?Tygi/lGpGA3nAy3zniigUlC7uLSgvvlfp7NLiHLNtGWAjXD3h6uPs94T4N?=
 =?iso-8859-1?Q?Y2MvXMqlW8hg/LV1kCROiWSnQW9Zteb6jX62elUcLsfkOlBdMyv8hyclUC?=
 =?iso-8859-1?Q?LAzynQnDH4yPenrEmhr7Db5XVth4/QPZ5oSbyBKLVyGZz75AHq7ZCv77Wg?=
 =?iso-8859-1?Q?sSRzPZB7dDkrxyBP+mZPF2jiE6uR5WeXAYqNxhfY0dhepAfn/4u3hR3TAb?=
 =?iso-8859-1?Q?9jBW7hbFtFFqMyU1HEnqfeR4TEXYwYpBOG1jrAzW5/SwsudxeitR0RaZ5w?=
 =?iso-8859-1?Q?BSPFTdvhXUN50QisKK/FIA4upsaa32T7+qXibCsjGUw51SzQjUMo1fMC/Z?=
 =?iso-8859-1?Q?RAD5iwd5izkpkMDiOJb4hPkk0FGOmpLoInHmSD1DEHdl/s7fQZcgcObF/W?=
 =?iso-8859-1?Q?YBEU7caCyB9lKUxEpz28kxxr67zBHLzRXwTmZ5uJsUul2M/S7duLeASt2u?=
 =?iso-8859-1?Q?SZfO+7P57vXHVK+8695DkRkUYEvb/fA9MGYlHbSnklSvMqhM1P9aP6H/tQ?=
 =?iso-8859-1?Q?xWiyQbXcKJtvRbg9FQJBGZqbEzIvGYjOTemL+/PkNjBnrII8EAnhD+KYYV?=
 =?iso-8859-1?Q?t/OE+pbEd76v3hQzGT8pZVMEHyxgp0NSyoYNqivDkrYRkv21K+8DTnvKn/?=
 =?iso-8859-1?Q?atFCjFl1zPxtoT2rsye9bXLoHbSDP+yQmFfK8z98Wk3XozaFcV784LyN2B?=
 =?iso-8859-1?Q?HySANtWO7YEpCx4kJgxCvWKCpGvUBHn794A+trCaHyQsNW4Sd8FK/lJq5S?=
 =?iso-8859-1?Q?sWfvOvdMrE2DInOhuoWVzJqM4TbJ3RDDHM4Rql+6qKngjm+DPIFAylwcSB?=
 =?iso-8859-1?Q?/NDWfZaUegJzeifffcYTTxXC5M+Uc1aF3S6cpB5OwJS+9AZYcOarbW+hDd?=
 =?iso-8859-1?Q?shvofNPKCZIOMWQJ3E5/4VOYRcUqzW8XUTDX+Hc2l3QurZCdbTtQyZ8IkY?=
 =?iso-8859-1?Q?Nfo5JSWqdeTKdp9G15xqmaj/fFpR6i376B3FDoLTU7emjJiQbYhantydwH?=
 =?iso-8859-1?Q?lOvqOKTN/ATiZ5yrbOXdLOWBOUZzSRjZmZHReqHEybiLOrBwjw+4aV7d86?=
 =?iso-8859-1?Q?2WTnqGsZ3m0tr5q8NJCbeI5ifyRiGRmaZz3tcLkyrAYRn+AyIoAN87t388?=
 =?iso-8859-1?Q?I42fDkk3jdBaTu+/3gxmHVoasfi1CkGjGDpWvjh2pRcH+9GI+9WyIjJ3D/?=
 =?iso-8859-1?Q?nIiHaKi7wjMQfBk/yv0e1cmrrTY+8byXZepSZc0z3g+je4SmBN9t9NEaHt?=
 =?iso-8859-1?Q?LqLU/J1wCQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a020bd86-6549-4818-a436-08da4ebe288a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 10:59:45.9617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPSA5hyIZK8uKkaPc60U7PhQRyPwMFpR6J4y1qJu87oDnXeg8U/ZYrCDlAcQ8HHrgHJt0ZInzIYm0xuy3zB1Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3939
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch adds the
fsl,scu.yaml in the firmware bindings folder. This one is only for
the main SCU node. The old txt file will be removed only after all
the child nodes have been properly switch to yaml.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../devicetree/bindings/firmware/fsl,scu.yaml | 170 ++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/fsl,scu.yaml

diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
new file mode 100644
index 000000000000..a28f729bfadb
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,scu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX System Controller Firmware (SCFW)
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: System Controller Device Node
+  The System Controller Firmware (SCFW) is a low-level system function
+  which runs on a dedicated Cortex-M core to provide power, clock, and
+  resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
+  (QM, QP), and i.MX8QX (QXP, DX).
+  The AP communicates with the SC using a multi-ported MU module found
+  in the LSIO subsystem. The current definition of this MU module provides
+  5 remote AP connections to the SC to support up to 5 execution environments
+  (TZ, HV, standard Linux, etc.). The SC side of this MU module interfaces
+  with the LSIO DSC IP bus. The SC firmware will communicate with this MU
+  using the MSI bus.
+
+properties:
+  $nodename:
+    const: 'scu'
+
+  compatible:
+    const: fsl,imx-scu
+
+  clock-controller:
+    description: |
+      $ref: /schemas/clock/fsl,scu-clk.yaml
+      Clock controller node that provides the clocks controlled by the SCU
+
+  imx8qx-ocotp:
+    description: |
+      $ref: /schemas/nvmem/fsl,scu-ocotp.yaml
+      OCOTP controller node provided by the SCU
+
+  keys:
+    description: |
+      $ref: /schemas/input/fsl,scu-key.yaml
+      Keys provided by the SCU
+
+  mboxes:
+    description: |
+      $ref: /schemas/mailbox/fsl,mu.yaml
+      List of phandle of 4 MU channels for tx, 4 MU channels for
+      rx, and 1 optional MU channel for general interrupt.
+      All MU channels must be in the same MU instance.
+      Cross instances are not allowed. The MU instance can only
+      be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
+      to make sure use the one which is not conflict with other
+      execution environments. e.g. ATF.
+    minItems: 1
+    maxItems: 10
+
+  mbox-names:
+    description:
+      include "gip3" if want to support general MU interrupt.
+    minItems: 1
+    maxItems: 10
+
+  pinctrl:
+    description: |
+      $ref: /schemas/pinctrl/fsl,scu-pinctrl.yaml
+      Pin controller provided by the SCU
+
+  power-controller:
+    description: |
+      $ref: /schemas/power/fsl,scu-pd.yaml
+      Power domains controller node that provides the power domains
+      controlled by the SCU
+
+  rtc:
+    description: |
+      $ref: /schemas/rtc/fsl,scu-rtc.yaml
+      RTC controller provided by the SCU
+
+  thermal-sensor:
+    description: |
+      $ref: /schemas/thermal/fsl,scu-thermal.yaml
+      Thermal sensor provided by the SCU
+
+  watchdog:
+    description: |
+      $ref: /schemas/watchdog/fsl,scu-wdt.yaml
+      Watchdog controller provided by the SCU
+
+required:
+  - compatible
+  - mbox-names
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/pinctrl/pads-imx8qxp.h>
+
+    firmware {
+           scu {
+                   compatible = "fsl,imx-scu";
+                   mbox-names = "tx0", "tx1", "tx2", "tx3",
+                                "rx0", "rx1", "rx2", "rx3",
+                                "gip3";
+                   mboxes = <&lsio_mu1 0 0
+                            &lsio_mu1 0 1
+                            &lsio_mu1 0 2
+                            &lsio_mu1 0 3
+                            &lsio_mu1 1 0
+                            &lsio_mu1 1 1
+                            &lsio_mu1 1 2
+                            &lsio_mu1 1 3
+                            &lsio_mu1 3 3>;
+
+                   clock-controller {
+                            compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
+                            #clock-cells = <2>;
+                   };
+
+                   pinctrl {
+                            compatible = "fsl,imx8qxp-iomuxc";
+
+                            pinctrl_lpuart0: lpuart0grp {
+                                   fsl,pins = <
+                                           IMX8QXP_UART0_RX_ADMA_UART0_RX   0x06000020
+                                           IMX8QXP_UART0_TX_ADMA_UART0_TX   0x06000020
+                                   >;
+                            };
+                   };
+
+                   imx8qx-ocotp {
+                            compatible = "fsl,imx8qxp-scu-ocotp";
+                            #address-cells = <1>;
+                            #size-cells = <1>;
+
+                            fec_mac0: mac@2c4 {
+                                   reg = <0x2c4 6>;
+                            };
+                   };
+
+                   power-controller {
+                            compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
+                            #power-domain-cells = <1>;
+                   };
+
+                   rtc {
+                            compatible = "fsl,imx8qxp-sc-rtc";
+                   };
+
+                   keys {
+                            compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
+                            linux,keycodes = <KEY_POWER>;
+                   };
+
+                   watchdog {
+                            compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
+                            timeout-sec = <60>;
+                   };
+
+                   thermal-sensor {
+                            compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
+                            #thermal-sensor-cells = <1>;
+                   };
+            };
+    };
-- 
2.25.1

