Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E466356066F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiF2QqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiF2Qpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:45:42 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C04F3C704;
        Wed, 29 Jun 2022 09:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7YpwVI7oX3oEWy9tHVJCQFfxv3IeRD0/YnXDA6H9Hgo6wAN7Pqv378++FWDeosLJqnyg2OmgSJ/jfwDKrKU2doyrrc2NgzUPtgZJ+GRqTEdhq2GpLmRTlJcR9V2Vlg0uXvHPOb/IXFY9ONRp90eneCQY739zN+j8CbpraGyVVoVHmurB7F4fKwZmPWkigmi7kE6Vh9FsFhKG/E64rE3bgI1hHAqdVjk8kRiK6yVd0OSJ289x5YZw3ZyxinVjXli2QJV/0eaa16WfX9fkAh1RsVRZFQWI6aEDGlNkY0Y9UEZlBtKejfK/ypSCbNPQNt/2SS3ChlRoV5SfNMhGhUp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAoBYu6U67TVxQFwxdx+e5GMNWqrwameUa3lJaMA6VE=;
 b=ALR+uROjbegxj685utp2T0DecvybQnEGVo5P+zgrIMkd3Dg8HZw0imtobHvD3VOQruZQTuLOho48Mc6yH2kI/aN2gcQiEYg+8Zz7woCujVT1mP+0cVUbT70yKjy96FaQSDDFq7jzuC9fjHi9VtnLlYwdk05U9lj8eGJHTtxOj2AUwj9bHpOMlcjPVm78MOO+g5Lgj6F7gvPO8Bn+1IUAqQPnJbUejzsqNoEuBNzBAIz64P4WUjyfGFQALCY2y5mm/xBaecRCV1ieKXfRoPA0crOfg87GXkTE89OA1DSU1Iu1DwjrAbTQMpiYwnYtIlueWASppyOOWsnnoB4U/ExMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAoBYu6U67TVxQFwxdx+e5GMNWqrwameUa3lJaMA6VE=;
 b=BhRfbVFxQnf/fGTDfLMNqM58meN6TkGuV1XLsz+pQpJDzIXucAeBZ5fxR01mWHzE6nKhfolx7Jm8U2onfcVmn++WEVcYqwmltNRdUE1PR3+0GLtFrx1mT1sInbNAf9UDW+x43nOfSdOPi/DGcXSASg13X4cvTMsjYeNs+y/bye0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI1PR04MB5840.eurprd04.prod.outlook.com (2603:10a6:803:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 16:45:23 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:45:22 +0000
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
Subject: [PATCH v6 09/14] dt-bindings: firmware: Add fsl,scu yaml file
Date:   Wed, 29 Jun 2022 19:44:09 +0300
Message-Id: <20220629164414.301813-10-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8517bb6-ee67-481a-5d1e-08da59eec277
X-MS-TrafficTypeDiagnostic: VI1PR04MB5840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /mbulvmQDjOQnjstmqjE96CL5wL7eq/LBtMYvlWqOwY9JKOgDjBzEmh57a8owBAG0DQ7xcALHtcFrMm7z8xoA8HXcRgU2e3vViRdq8r7cempmUbxzcu2kBrbdLKT5GCuDXmkbKUTXJiSpp/6FAeYP7cQ61+sTmdbHUSB/7fENKibIqeFHlW0EJa+9yBPydY7cErcbdCTolpFAtTSzVkao/CaHngo00G+rSkv5XE7sh7nPE/U3SzOD9N8O40NMhkj2LpB0q7y4Gq86Z/6s3yMdXWULHcolqi0CymoQoP76bbNmJHGzOQ0YVJjP5854StV2QY2YwYpTNzBK0/1DHbMa8W6f2g/BbQ9wBgQ0SDE076hYXRVZ5KkuDHhy9VTEyzcSPJ7wRbfUPDUtrv98iTSEw+mB2imyGvm+BVPmT93bkSp5h6FKRzMhHTU9/OCs5wURt9hr02XR2Meuoc9YKTB71vfe3HezEgZ6Qsano3HlThWZxABmPzSHcYRCHT2RQXZnN4ZlcT6Iwp76IsFeqtUYUm7zwZqrF6NRCbdMWyJHB32Vu432sNVJyuZGQWOIJl5mESEcq9de26wep9QKRATE1TdMEyhfutYLnUcLeoiZzuWxlySpokgks2q/YYtLIDq2mM26ajF/s5V7iP6AVM6TBftqftzld2l1hWkoJzNDC8+oWWNghSpnse44CbpSHGC2QxzQO4auRnqfx76oNAZXhnl9Euqt2Kz/DBLn4+A+kA+qQheDo9pvAGM1X/LrNiiZLOkt48En1b6vpt14rl6SG6/w6HHXHYUeuH9uQ1jkbAVXbefP72iU+ct72ennf5f6/cgyNqeMtowVvNZpKm8ktF2C6i/j06GYVpu3D1CEam35btUHIlXq5u8QHqOY8Xo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(66946007)(6506007)(26005)(316002)(6512007)(66476007)(5660300002)(66556008)(6486002)(8676002)(8936002)(52116002)(921005)(38350700002)(41300700001)(186003)(2616005)(7416002)(478600001)(86362001)(110136005)(6666004)(83380400001)(966005)(1076003)(38100700002)(7406005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9FbxgZROKCFbwt9OWxhLTCkw6JoA50E7STQfrFWKr6jxXiglc+tVzu0d5L?=
 =?iso-8859-1?Q?SmwlZzyBOlZAj1GMH0r+RFO9dCODoKuf+XTwPEMRnC1Za0oaLExAyvrjgW?=
 =?iso-8859-1?Q?zla33TKnvej5lbXw1ayuX6y4XPG6gi+52JfoODqNl6ebER3TwHYwHTW0CE?=
 =?iso-8859-1?Q?gwU7gBbSb/LhR4LaZWAEd9WE4+vtv7x9zeud2//GISlc1zZTZ1L2K9hR6E?=
 =?iso-8859-1?Q?3Y9SjQ1rV3ZXl6Z6DNRstnqqQOQRZv/dFB24v1AQ4CYgJpZNkLF+nJpIqw?=
 =?iso-8859-1?Q?MILSNLIA7X5f+kMh6foXYzhfYutHfMyibMWUMi1GvhYbajOUov8oOg0FMj?=
 =?iso-8859-1?Q?8T78C6dAhzBxUzeVnAR1XgGkmEZzb3069mpXYwWExk9w8CzLfdaJ409hQt?=
 =?iso-8859-1?Q?wyGMXqP48mFXrDb+3K1xP8lW6sRlzRiKACGgKWuBs4fGmNUcv/8nqTz4jV?=
 =?iso-8859-1?Q?7c/fWvVWsVaVvDd8QEGX3f0ryNyFnw18v4X5IUIzsWLst1ZsO6AaTZPeR6?=
 =?iso-8859-1?Q?OqWGXQXpIsNipXceHAPTeTYG1ae/cnxi1MBJLAjr2pZYSe6WBYIOeo2F0X?=
 =?iso-8859-1?Q?T4oufuys9GGGaYykewC9Zs+6RACK1oOwm0kiu2KgH6XfpkM+EpTKMG/UwS?=
 =?iso-8859-1?Q?Hjyy3TQhWtDPX9t1j2nQnWXEZLL3w525Z8AbkOZeNrNZBsDpQZBul9mF3F?=
 =?iso-8859-1?Q?Z50qFSOrb+1dZPmrsmSwn7fxCVdaN3xoTeGmQKvZ9lwrSshlzd5iEj+/ar?=
 =?iso-8859-1?Q?vmmuNK8cSzhyx7b+ve1euXwIqLZcHo/NoDVwDwobojih6zY6eQo3bcm9ku?=
 =?iso-8859-1?Q?iU9ATc7yfbkCgMpIysQVAlLRwVcKoWHvp4gYhAwz7jX5mKiT2XBbPqylUX?=
 =?iso-8859-1?Q?QBjMYNARqSZMbQwKmiG7LLNBFkBVzKMyELNLALxH2+Q3ikifhnfbH5H5kJ?=
 =?iso-8859-1?Q?PGJJCTDY28cJ/M1Jrl327Upd/tV1/5SoFmhd40D1c4sO0n/Tj+km/dyCjw?=
 =?iso-8859-1?Q?hGS8yZzbwzqJljV+1yvRfx5Na7cqP0Xm1hwGT8PqkPQfeGjyIOVSdkpx5b?=
 =?iso-8859-1?Q?oQ+heRs0kQVMkhDM5sbj0TtD0uwdaCjqgiFFDISFd/cb/7THBlYRJdZz7w?=
 =?iso-8859-1?Q?fog064qUThz1hUKiJX/UYNxtAhexfGgapHkmpNwU3sQra9YM51NxNerf6j?=
 =?iso-8859-1?Q?Nxls7KXM4XEbY7CH27g0mPsRiidl5cU0GJ1zLKXtxwSTiKG/RsiQa1boIp?=
 =?iso-8859-1?Q?sjE3OiHK+rrnBSmplq47XeOBrhsiHFGkZn24jKf5kBECCyEu0ZvtsY230i?=
 =?iso-8859-1?Q?xRHEbOxZEkOc9q/2KsrajbOAnW9tAdfh9u18PKuLidgMstWTV9x/7QuCI1?=
 =?iso-8859-1?Q?Z7ZWfDKDpirg8nDHoFhmi7tBykE3b/qqvqTUpbfBpD0KS5SMzdEMF90j0b?=
 =?iso-8859-1?Q?b4HxEGJYfUMXSW+V3oq+A2OkrDU8QtjaH3SNw/bY0sXf5XGX7bp5eqbUYs?=
 =?iso-8859-1?Q?vZWEZZhUIt4Xr7JsR2lNK9H9Obyq+HAl5UecYXf4xOwqhV/5Rt97V9eQhR?=
 =?iso-8859-1?Q?0nqspMWMkjtXaOiUSdcxoCGMS0D54IbsVMuhu38OdtI8ofNOkcRBumMiSt?=
 =?iso-8859-1?Q?0LO65qjNlSOJ8vKfj/oDAv7l6clARiVc5x?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8517bb6-ee67-481a-5d1e-08da59eec277
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:45:22.7912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5iv37mwGuTtlnf5UGtnqbJDDTdE2Pg0JmE3dt9amgouRrAqEpfmksLwkaWh2sKFBLGfsvM+P0d6Z+Z/bXsF0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5840
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
we need to split it between the right subsystems. This patch adds the
fsl,scu.yaml in the firmware bindings folder. This one is only for
the main SCU node. The old txt file will be removed only after all
the child nodes have been properly switch to yaml.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../devicetree/bindings/firmware/fsl,scu.yaml | 160 ++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/fsl,scu.yaml

diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
new file mode 100644
index 000000000000..bf13a1e88ecf
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
@@ -0,0 +1,160 @@
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
+  compatible:
+    const: fsl,imx-scu
+
+  clock-controller:
+    description:
+      Clock controller node that provides the clocks controlled by the SCU
+    $ref: /schemas/clock/fsl,scu-clk.yaml
+
+  imx8qx-ocotp:
+    description:
+      OCOTP controller node provided by the SCU
+    $ref: /schemas/nvmem/fsl,scu-ocotp.yaml
+
+  keys:
+    description:
+      Keys provided by the SCU
+    $ref: /schemas/input/fsl,scu-key.yaml
+
+  mboxes:
+    description: |
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
+    description:
+      Pin controller provided by the SCU
+    $ref: /schemas/pinctrl/fsl,scu-pinctrl.yaml
+
+  power-controller:
+    description: |
+      Power domains controller node that provides the power domains
+      controlled by the SCU
+    $ref: /schemas/power/fsl,scu-pd.yaml
+
+  rtc:
+    description:
+      RTC controller provided by the SCU
+    $ref: /schemas/rtc/fsl,scu-rtc.yaml
+
+  thermal-sensor:
+    description:
+      Thermal sensor provided by the SCU
+    $ref: /schemas/thermal/fsl,scu-thermal.yaml
+
+  watchdog:
+    description:
+      Watchdog controller provided by the SCU
+    $ref: /schemas/watchdog/fsl,scu-wdt.yaml
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
+        system-controller {
+            compatible = "fsl,imx-scu";
+            mbox-names = "tx0", "tx1", "tx2", "tx3",
+                         "rx0", "rx1", "rx2", "rx3",
+                         "gip3";
+            mboxes = <&lsio_mu1 0 0 &lsio_mu1 0 1 &lsio_mu1 0 2 &lsio_mu1 0 3
+                      &lsio_mu1 1 0 &lsio_mu1 1 1 &lsio_mu1 1 2 &lsio_mu1 1 3
+                      &lsio_mu1 3 3>;
+
+            clock-controller {
+                compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
+                #clock-cells = <2>;
+            };
+
+            pinctrl {
+                compatible = "fsl,imx8qxp-iomuxc";
+
+                pinctrl_lpuart0: lpuart0grp {
+                    fsl,pins = <
+                        IMX8QXP_UART0_RX_ADMA_UART0_RX   0x06000020
+                        IMX8QXP_UART0_TX_ADMA_UART0_TX   0x06000020
+                    >;
+                };
+            };
+
+            imx8qx-ocotp {
+                compatible = "fsl,imx8qxp-scu-ocotp";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                fec_mac0: mac@2c4 {
+                    reg = <0x2c4 6>;
+                };
+            };
+
+            power-controller {
+                compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
+                #power-domain-cells = <1>;
+            };
+
+            rtc {
+                compatible = "fsl,imx8qxp-sc-rtc";
+            };
+
+            keys {
+                compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
+                linux,keycodes = <KEY_POWER>;
+            };
+
+            watchdog {
+                compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
+                timeout-sec = <60>;
+            };
+
+            thermal-sensor {
+                compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
+                #thermal-sensor-cells = <1>;
+            };
+        };
+    };
-- 
2.25.1

