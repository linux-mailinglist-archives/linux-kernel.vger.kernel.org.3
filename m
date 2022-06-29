Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A936B56063E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiF2QpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiF2QpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:45:05 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8623336D;
        Wed, 29 Jun 2022 09:45:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oh800PTF/+aly5gKUauPx7p6YwFrCoPqBMLW1P7TGVmPS+7zw0uEDNPCXa7hTJuVbFIej/Aeqmo612V5SreAdOtKhECH0eVqZrDsRnK+Usarcfa/SBHnceTI8ITRWhCUJyoYNUfuo497j/b/k8GcGQsgfwc9epRgfRY1B3pue/ayxA4I48izvuIg9JpNrZqYuJJ63AZp1x/GT0Tq+3M4M5f9bPQ4e810QjVlyla/eRW+txEuTFirspxAt7rxoa6oafnCaiczMD8FlFZoAkiwEx0aXMVZZ3R2vEjx5snUGQQtFTItZ+ukx88tmQbPBNzrrO6PGtMhv7BiobUfKUlqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTosZOddEdbWWgBLMwqV+YHkeUvJ5AzmezHDE9YXvXY=;
 b=G5LFgm40UbgXFOIzx0UZ/Gx1kwbUoMSVwR2MqfXVwFLiJ74e1Fs0AYO27M/zg8GXtk9hSbgnSWC6OuM1Wv9eUTwtCid7oyzNgkYyVoM59I9h3Y/9AYQSohT9Bzd+S19N4qbZg5RmzfT0o8xHhgtCqpivRVpEaaJ9Hn7mTjLmAGFfltF03pZrEpfM0wl4Fie1T5nVw6KMV6V+4sDOHgZ9OLa/qhpoWFXiD+Z6jwCBB5WmW/XPi8X6DOfls4G/5rTRnBIcH6CWnHJoPCc0Q7hy3pzq7smiOnUXPMl9Simd7Hd3Yx7k00aFXSR6ZJoBRm/1+pgRupNBom3Y8i0Bp8kLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTosZOddEdbWWgBLMwqV+YHkeUvJ5AzmezHDE9YXvXY=;
 b=M/IG51vFRe245BE/Oy0UVJP1WpjhpLsUIcTfdBZ0agYDiCdoakttJzhKW9OJpVg2/GugYIu/mDHqP1Q0/F2iwwnLnZCmClVk5YSTelnPsva6I/Fa/+O77bx14mzqaThCVKPN0YJQX2Nh0fpVN9l28gzyOndL9hx1ro53vKXXFSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6401.eurprd04.prod.outlook.com (2603:10a6:208:172::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 16:45:00 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:45:00 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
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
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 01/14] dt-bindings: clk: imx: Add fsl,scu-clk yaml file
Date:   Wed, 29 Jun 2022 19:44:01 +0300
Message-Id: <20220629164414.301813-2-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::33) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d4e43df-9278-4c91-643b-08da59eeb4ef
X-MS-TrafficTypeDiagnostic: AM0PR04MB6401:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zElbaNrDTuwTLyW7ftBkuxtDQLs5rGGYIX6cUwD3q226ipnl6lYcC3C4r7aSnLnJpg/COfi7q8uclPIQFyVJNQsHgcsFB7YQ9xbu2o3i9ccMcQkS1BUgMrZrskUvvtDVhqXwDElkKdmrjE1pjvW4eWXkWNx1rXyoXmNafcG0Fpf40PaEO679phn8+p6O61IZA62CxsSWkYx1HjFmtfbyxCRuqnalwblTuFV7x62c0osqZhTczjREqyQvEHls16Msl+EtM6f3rc88kDwEPQekChaL4lgMHTneeHoYdunTv5aOdEz7gqQSLg9Ktd8E2aoUf8LlWcGIXuwqABvj8a5LBx7MzLkA7jem8L8/8bJ6PVvR7tEvlRygCut5onEc5DiZ4mlysGCfYHwwri9tHLW7oQni08oFPNRXQfpmxgk/+0oqi2tW0ikv0VlAKL9esj+l54lqZxlicltKZRj6TwSREwdO5MaIJaaYFBYHXmhIrke5s8nz0abf/+vJWnkd3oH52DKt5OsLrjM3VgbKVgFofJar0bjmnCf2t0Kyu0rm1mibUySHiWTqE98GUtjS3RT7KigGwZCLf1mX7SkqBpYS3/Ljv2pkkDy+KktFBQDfNuiZsMBpQs0NZQzk3NFP+L2VghYQ/wgq2ivDuRQuKIrzIfzBxPK7Q8f46v5nrLrO7/aW4NU1bh0VfaYqOoBuUdnbVdQ22eOFLxUY7eS0/1UENkNScDb5VmKvfuvEhQRZpMVOe5lC7KxHQuUAUoi1nD2QaLz9dbW71cfKjoyAcp3g3D27MRXnhLWhMeuvCxAZjiIaK9A/HLZzhPAFYDOL3RBWlXchCucK5rsKOWmVA3JXD8TgrUJLNWnMAG+LW7mmb0+ng9lLpHNKtjwWlV+kos2f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(5660300002)(7416002)(38350700002)(110136005)(38100700002)(8936002)(316002)(2906002)(66946007)(66556008)(66476007)(52116002)(7406005)(8676002)(921005)(83380400001)(6512007)(26005)(6506007)(186003)(2616005)(478600001)(966005)(1076003)(6486002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jHjNlETJhEhe9ZBenYrAr2EQgJr6/8L1wPtTrdRRu03VkmL3K0IVjMgN6C?=
 =?iso-8859-1?Q?NlHCX9zN1JTZzwm3yj1+dNaGeDb1c918CbRxY5Qoasa7e84OgKV/Xv+o0z?=
 =?iso-8859-1?Q?YD3/o7ZcXuDnYNObSxLAFCzy5ucr0hb1YF3fo3E2UhBB7+tLLcTJvv7Iee?=
 =?iso-8859-1?Q?rOZ3AwsqUldKSqMsAtiK85q2pk8rl3/p2Lz4FNux3OQ9cQNTHQU7fPVKZ5?=
 =?iso-8859-1?Q?8mf9hIWumhbfjN2+6lcV+KQuMAMhDnu5NUHX3JMzF8xM4AX89hfW6Vv77g?=
 =?iso-8859-1?Q?wDdiFyOxfKDfWOyfh8g3r6+7GHaUAd3EZ2qPHfjeISDlEtH46NvQyJH31+?=
 =?iso-8859-1?Q?a736WNdmTaE+Er29Gil4PvX2PS+aPLE8Km5fFc/f6eic5cQWgn4Acpz2tP?=
 =?iso-8859-1?Q?e97xkXOVX+ugXcEDMm0Q5RzSuhd3tC48PebY4rT+gwEZ0FKD266MnTPDxd?=
 =?iso-8859-1?Q?NqS0sqsodULll9WbFYvkUN30oC812Xx6kyEN78ETLK7ky9Hj8/3fNs/ztL?=
 =?iso-8859-1?Q?DerGZ+RtyBv3yKQJvOAR+RN9apISSfhYp0hpIOMk9EhBPZ+DIm8ZeRYGj6?=
 =?iso-8859-1?Q?XkR0+H8FZPNDHQemDeFKvX3GlFCEUDCXS4YfbWlFU8UFFVEXmgmzfZ2Cz+?=
 =?iso-8859-1?Q?FqErWE/xl0WhaDcxGdaQfpreNR+6YAylHr0o7g08KoNo+CKmPprYWZcjUT?=
 =?iso-8859-1?Q?gZnqS+YZQVMZ54XLhEOZ1JpiGfvhtijcTDKGgpDkw1lheAxyJEhVTNCvrA?=
 =?iso-8859-1?Q?FX5j40rJ9NgA/rRAfxg8AvIRSxFToHPA2g/3m0G15daRIgOu1ckYSSdd+l?=
 =?iso-8859-1?Q?zDO6yR5iAaffjjkngh9kKo7uDoAYvFMl9sagTXfmM5oq/nqB8vzTnTumbQ?=
 =?iso-8859-1?Q?WkMmWYCCIpmLLPqzoZynhHoZaFuzv/OcDVt+Nmx/3mu0kZDHUSBpdsmbas?=
 =?iso-8859-1?Q?s9kohzeCDX/Y3FQ3UoxZhksREi9NepVxo+EsYbi2oVALJ39D0fh/c4RrqH?=
 =?iso-8859-1?Q?Kh+eKaN2ExCzZWIGa/uoTSzwMgcGh+gvfZPrfl65Gn3526jfk24ft4Ngjw?=
 =?iso-8859-1?Q?nm404YcrlSV9wbQecSjjH4+V0C2DXs8YIjNxVD3Ei5zVhMWOJe9IKnAPnh?=
 =?iso-8859-1?Q?JTDCkOHdx0WfzdAjGwlwGHttIuWGlPi+oyWizBKx6/vakE4lys9mJM7jZR?=
 =?iso-8859-1?Q?egKVsoru7JjWmh1WujpF45+xA7wV3Bp1fBMy8eoERZJN7umAbWKbaJEIYQ?=
 =?iso-8859-1?Q?Pu+GVlX7xoBRVB3UXWIFTo+gPlUvFyzzysW3Qtm1Ly4g5ArMteBh9JMV6z?=
 =?iso-8859-1?Q?ADSHkcYXV3A3JO6lwRYoPTQ7AU+PG1VDK3VXwEVRUcQCpTfnj/wzYXeu6G?=
 =?iso-8859-1?Q?wgdxk3+DfwkuUdZDaKfkZdIcmLfYjHC1YJjV3odaWHCNJBSz/NTFFPRwj2?=
 =?iso-8859-1?Q?ywIWaxw6Ci/ke8OM9S6nnwj0NYC9ou9D/iLaiPXOudFh1ZSJ4IxyzVLJsr?=
 =?iso-8859-1?Q?B6+RceX9YNiV0+VxULAk0OsCE8DnhWFS/yPX5M0p5CFnY5TTNwOCHEe4Cs?=
 =?iso-8859-1?Q?8ia2StIjcs+LX4URoOTqDxU0/EMc2ini5sS4IYsz2Xl7bkTz++pWqoliNa?=
 =?iso-8859-1?Q?3mY15XIZwuREZWtn3HUxl1j0ur6ZUGLDUU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4e43df-9278-4c91-643b-08da59eeb4ef
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:45:00.1522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElosnpZea+MwYs5pgiN7OS6YfsRM8p42Y7u5AM11G1/e6AZz3wjhCI10gvWlzcka5G12116UgQpgFEFR540WlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6401
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch documents
separately the 'clock' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 .../bindings/clock/fsl,scu-clk.yaml           | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
new file mode 100644
index 000000000000..f2c48460a399
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
@@ -0,0 +1,43 @@
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
+  ID in its "clocks" phandle cell. See the full list of clock IDs from
+  include/dt-bindings/clock/imx8qxp-clock.h
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8dxl-clk
+          - fsl,imx8qm-clk
+          - fsl,imx8qxp-clk
+      - const: fsl,scu-clk
+
+  '#clock-cells':
+    const: 2
+
+required:
+  - compatible
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller {
+        compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
+        #clock-cells = <2>;
+    };
-- 
2.25.1

