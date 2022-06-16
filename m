Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1B554E78E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378114AbiFPQo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377850AbiFPQoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:44:18 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30054.outbound.protection.outlook.com [40.107.3.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B6D286CF;
        Thu, 16 Jun 2022 09:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLWW9AT8TWv5SvGidbf7LS7Bops6wxGq9VNYj1kyGK3gTAMy78JgP3Y12gJiomSqDUK+1pB+kudj7jM2KKa5Hss0MM3LeUkrfw8aSkBCjp5DqVQL78FOAlfECZhcCYW/Na1M7es/Lz7MH6YcsQigJBGMDe9PFfYzZuqM8atSOkJNxb74pH8DKAa627gEBQ0UefY/H/b1UXX5grzn7XwbCNZWS16GaihJtG2FQiOb0/lyqYLmXeMJiN640wKULSTTsfCSinf/nzLDuluU7W5xnNYW7N9TmyzIyAkl1dcSAUjWV99bvvT5OU3dgJ+RmK6hhyPA19XYx/rKeNUws/bT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsB3AHX5PYn5ZOkKy4oLVMPx8x4wcVAZTqyKV0p6miA=;
 b=az8npWTNHFusS/VkvwWBln96CUKuXtpoGUd7T27/s+0AFTdNgU3niw1U/7EsHEwkmWAiHnhOxuILGGOpsS482iNoha7L0aqxsavur4YQkyex4/e3UXw3xSJO7YBxfzeHMoMsCX5+T/VE5FZrpyaU72dThc5Y4DDX5xoCHUhXqkT78of52bMl7s0oyQXFgP5kq2v0JO4KUzR4KBuMZkFuM/7NyvmNiLmtBtQ+NL2T9s44FsNjqRivBEO78n5kcmITFNLCfCPzdPUvTnEvmlXM2l0/790m9/IVCBCdwIlpbvD9JLhsf/Hz7G/aKwAmQy71D+jHUKbV4z4yPQRCe8hDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsB3AHX5PYn5ZOkKy4oLVMPx8x4wcVAZTqyKV0p6miA=;
 b=iXS7wd5urw7Ipvk7MmKty5LRApHzTrOPIkkJ1mnLt9irJDBh6GevjbqiWGYNKR14sNIS5DX69xqvL12nOHKXcpArlRbSZwEewV/VKHDm4pd0uujiEJjTU/jptrZ3NVNnQXBHC5nL1zMuZFY+uD6+7N0WWzaU935m0xy+RxBekFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by HE1PR0401MB2649.eurprd04.prod.outlook.com (2603:10a6:3:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 16:44:14 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:44:14 +0000
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
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v5 10/14] dt-bindings: firmware: Add fsl,scu yaml file
Date:   Thu, 16 Jun 2022 19:42:59 +0300
Message-Id: <20220616164303.790379-11-viorel.suman@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616164303.790379-1-viorel.suman@nxp.com>
References: <20220616164303.790379-1-viorel.suman@nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0029.eurprd04.prod.outlook.com
 (2603:10a6:208:122::42) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca079437-386a-45c6-c437-08da4fb7724e
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2649:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0401MB26497C4D5765D2C934ED37BA92AC9@HE1PR0401MB2649.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmdJSN+v+seWsQzw/4mt8B5PPH5RD+KrP2RWALbZu3iEbShGd33/QbJo8lpBY369+A3ghE5CvdQjKCGE0RL4FRkIIyul7VYfn5jRhyeoyROnQeZRgyuobogLw9xp3jZaEpt1+mKoiMfn285A4qSkFfUlnnLLZAvObNANoPcPc9kRnkwGCWv8lJGL45byfqSfqpGYBM3eNZg7LEkBNYC3UNEAs0lBDZLZnJMquLfdE9HHfS1FGHnXXZnSopw4NiGWJiiRNyhXkpt/01ciKnLoeJTO3nm/CfMV5LETBnmeopX/7qQNJHSY5IFkU5XA3P1L5eQXLBKTo89k8ynTe0wAAKTlSGtMaQVW/9aPcYTuaGypPaaUmlw+BYLP/K/fD5/0C27BMARCs4lIPLVCXUnBWj+LtGeztoJh0HVmkzstd79x+qStOKEPsnyCZ6x+wu+vD3l1c+mkdGF7KwTPPok/afLstqb/MW4dOP2BqZ5hrI57/vtHP9Vw3mD+tkkcMGUgl0m1YiILQHAHPHIhSjzPITU06wIqi4ciCyYnEw8bmNfgeCs9yYPQcx1VtRbdI/vY+jtKT7S0bXw3Bw0F/Eh9y+WTkKivm7TPf8pbRXswvcLwbZfrcKZfcQiOWOpzwmw+4TQBJz+OddnU51MEZP2CSuw8gau4H0QoZUKQAWXd3XOS7cST7DCNuhI47urGOEM0GbhQC1pmZ0kvhqKEPvWN1V09NZGl11kuho+g4dldJSc/MoBMMqcBryG3poLpkmI1easEflGMR3kphauHCAiZTxzFjaoGPcsEn24WZllb01vy/yP561FAoYBHyfyMcOeiONhWszm6nzMBRB/srSBK7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(86362001)(186003)(38100700002)(6666004)(5660300002)(2616005)(26005)(7416002)(6512007)(66556008)(7406005)(2906002)(83380400001)(66946007)(38350700002)(316002)(110136005)(52116002)(6506007)(8676002)(508600001)(44832011)(4326008)(966005)(36756003)(6486002)(66476007)(8936002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uYVNSpXibtvoTMHbhm2H90AVwRAfJKQfqLv+KY45G6O/ThQ33KDkB7da9H?=
 =?iso-8859-1?Q?dx6arIVjfyMeuSVGIHAH1vIz8hjs23w4cJJtZKaMbibvSH37F8jyxWCBgk?=
 =?iso-8859-1?Q?91AvmiVY26lgc0HYUNFb7w+aWORkB8twE6XzTklzvyWhOCGDJihCkVGSrk?=
 =?iso-8859-1?Q?E/axtbJ1NGJ9s9d9eI6uAINV2P/14sfoVTWRjqZOH51xKduXlW3SAY+SQt?=
 =?iso-8859-1?Q?PUtpWIh8GCOwaPokRJ45EC9U52X2EKvAK9x1ERIoxsoYwE9OoTFwRt1UAp?=
 =?iso-8859-1?Q?kUUvvd+i6JzlKGEJn/2VcxgSsAt7fNxpae+LAEWToZ4laouN4Nsk8Pd0ci?=
 =?iso-8859-1?Q?CORVFiv4mQ8w160q5Ixm6ovH2GY7K5g6lmZr1pMapGXW96HXy8fetlrYAd?=
 =?iso-8859-1?Q?+d9jxzDAHwcaxJe7rzAWqu1xxGCm7wCERimxWNwleJMIPgDKAr6I9k0P5j?=
 =?iso-8859-1?Q?MFgdeQYemHz8rO9eh+v+IfmaCpbLfAa3LHcV9wO2S+wL+S0hbRxHS5qdJ6?=
 =?iso-8859-1?Q?RGdC+093hBaIQyisLwlZqFBE+m7NLRBS8gD6km2ap6DpNo+HX5BhfqOsqK?=
 =?iso-8859-1?Q?XHmL5VFJedMTQUTGEet5oi3h4KNjl6tswwvo7V5/T/ZOT03ayPDtCDTVO0?=
 =?iso-8859-1?Q?OXLTO14tnukhFMyY7kOZxhEqvEt60HJme5dMs2LDEhKDY/ttmkNhwM7F2K?=
 =?iso-8859-1?Q?6ddcJmOBhZCnEwnyd18iznqImqPDT28lzAO93AK3TeZZsy0jyqfiER4+2Y?=
 =?iso-8859-1?Q?xQy7DhUUtKl2FOo8xKSiQUhuubPfWQaD2jC/7qq1RtswsN24TEooNK95uq?=
 =?iso-8859-1?Q?OXliA1Mxp4aTSpVRhudVn37UpEE+LJ0hHNAHFQu0/zWCdWbE4o15DAW/OF?=
 =?iso-8859-1?Q?dGRiSOtVRazZdYt86znQqa1ANkhzRGGhY4Y0o19FUfxAZFfT8QmMzOOATM?=
 =?iso-8859-1?Q?gnevCVtyzORahHlXFwr18H/RxdxqGPzcAXIkQZv2NrzuuFm3JTYCzjr8Sn?=
 =?iso-8859-1?Q?TYZETX1bzAb/C8jXkFNXAI6zc/ZqC6OslrOzS/svknwc2LZJswsrP3WvOh?=
 =?iso-8859-1?Q?xqsqT/BFhKjUi7+I80egmfxRsQQ5jKVnJJKrcnBNQJcQKu6yROf7/4mfxM?=
 =?iso-8859-1?Q?iymmWOZikovIB0f81ytrXi469CiTGvza7ieCNWlnTKLcaF6EO7FMZj6cyG?=
 =?iso-8859-1?Q?LyBm8AdJg1vSANYRUzLXTlBEOGeWkrNC7/6xj50A+BWKiMzPmFLPDKMnSe?=
 =?iso-8859-1?Q?U8MI8Jl0vsARrPK8SP4xv9qnUtqBQiwuEo2zusGdxHYbsRAN7JgM7zQdqx?=
 =?iso-8859-1?Q?FsgLsdZrIsO2yO4CFOJiAiaQrbsjhv0korL5QMe3RA4npgqFpxA4uSQPEs?=
 =?iso-8859-1?Q?/D1MUP9tykN0F7BfiVmoQUO+lD5P0K+OCM6k2tr8DiyM3MRioEoV/ELNVx?=
 =?iso-8859-1?Q?LVPejEw3K1LnfpzRTNXLy9kHmGur+0g1JVokMdDvxEre6fCk+cz2XF92VS?=
 =?iso-8859-1?Q?7rFRM4OTAVrRblsD/LGLlSZBGA3hyDIQyJOCNj3MXm/q9ahAuS8PNogX2i?=
 =?iso-8859-1?Q?uMKH5qe4UNIBRBrVMjWeqV5L4n1LbvAktJp/4jAUrlTOVO0RPE0ZfNW7IZ?=
 =?iso-8859-1?Q?q1OoDsTbhcswAJ+K4YqiSKIrGZCKHbnW/sNAJcKfQbDgV5b+sGB9NbNJtB?=
 =?iso-8859-1?Q?gdt08B2npm9NfDvLpkHpmFk+hdV8v9r3D9r1hcIgur1IAVuf8xBV9RHI/i?=
 =?iso-8859-1?Q?DGvlDhNF0rKJSB1cFgvQUvyU/5Qn30lJFGx03YqN3mvf6dhmPZ9AzM8a+8?=
 =?iso-8859-1?Q?niBQ9F9MEQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca079437-386a-45c6-c437-08da4fb7724e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:44:14.3439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQlv6/N9egopxTh8FWS1fYJ9KKCgSgfnAcfHinyzZ4z3jpMEEyi9g2gzH/jWr/8o8fwJXhPX+2AW+ohJ/DOZ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2649
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

