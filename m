Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAE756A276
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbiGGMvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbiGGMvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:51:09 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706112BB34;
        Thu,  7 Jul 2022 05:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO/OWLvQbNavHrded/5h4aevOvRRhlRU288WazUvdS2pJ2puaMRCVDNyvs26rvfc9NeYkBAbgeckkMMo+BZ8RAIwx3Y99O5YdRro01h0n8r4h9cPJzvEZT6uDO5rBSAwgGlab5hl3yyJlI9EscssfQS93DU2L6oDOCtMYKdk2ISI/MHzzCR209GD0UNDgpG3PQtCRGNr1ocHw3T6ZB0/Qfaz3z6LqHX75nk+Y4V8ERuLHNsOY04ey9AkyQwhfVmDfRwe/YIOktCbWYidG1Hgrc6RM3yd+cwVZNXtVXV5rOKdWy+6vTmhwVWs4os1wtSWTvenrjTaKmKiLNfTt/QwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMdQHOwDTIsAKgEIOrUlM+jfdc6vmQyGTL4GHeTeTAQ=;
 b=oX5RYZiqv1pp6STc17V/ZbpVM3N/esgru25uB1vmbkmSRZ/5s6NXdmWwUXdtFp+HzLZ6+kvzLJIPsb6un1CkXYb3RuZI7rK7iN7uebNmfbcgWJ5fwr8vd4qYfvFVAI+lfkQvccK8oBHYMwlTrVd2/FwYqABZmQE1ev8+vbHcBrlrT921YXrLbShzuzuoAVttGq/M0NeyN25JLtphQLOze5rYvbhjI0qgIrxWAEwscdXM0B/ATE/p6AzxpD8HM+YmHBMSjxgfgUKELEq4LmpkGt3HHHiooEB/8uCe8vmTo09WIwubaJ66EyPszLGvJ2KsL2r3d72EblRLuP+OOhR9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMdQHOwDTIsAKgEIOrUlM+jfdc6vmQyGTL4GHeTeTAQ=;
 b=MCXKLlbedM2tiICHCi1gNTCQWvmJuLMjbZpeQV3GaWx9stD0zg3KUQvcJZH/9M5MayUoDnyOjD5eVeVCbUhpe3nOZ6yNjRN7omwTD/X1oo/vAKzsafUZnz0LNsDqVpw2PxCYpe7C8lUgrl46yRpSHLe4wnIR8sNjlBEf0t/oYJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6418.eurprd04.prod.outlook.com (2603:10a6:208:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 12:51:04 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:51:04 +0000
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
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>
Subject: [PATCH v8 04/15] dt-bindings: nvmem: Add fsl,scu-ocotp yaml file
Date:   Thu,  7 Jul 2022 15:50:11 +0300
Message-Id: <20220707125022.1156498-5-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
References: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::31) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83c1105d-e69b-4154-deed-08da60175a1d
X-MS-TrafficTypeDiagnostic: AM0PR04MB6418:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01mt4o2x3gIxUQkhivJTshaFdNWTiGJSoUhv9tavZPXYx05DsoE5frgYtTxALKpLGr3RiJ4xW0w6FwF9NXtxfEgdAveh+BWA2mBijarlkFt3l03ALRNzJSisab4Yovb7zlh/JkYwisDn4RTRZ/qq2hjgRwJnzGKEIq4QjrFWX5VGpri2LydebZInQ746lQI67Skw0gAIJHo1gWl7z0ovZuxl6dEHHC5rYvvqu5jo3W0mzkCZNuBJtXfdurQvLzDcUC7GH4KFzCx1rFLH/Bi/e/i7enr2p73VDirqpS7hL6tdff/M1KwTgN5VwD1WuAD/mjiJC9pschEoWtS6ffQ7wQEW86Ag1Qe7Hm+WFAtudkBhBPvlT2opd5RmGsVa+NVYV6Soord9HKpALpREFTmllItboB/uxlnDC6tKsrB2GNTaM/UjaoCJO5C3o/omACFaabnWkZpDHuDaSyvBBYFLBAi1LpFNeLaaGMPoAes+O8BIUWkqRzPBhIQqrUSlb9D4Vtn2MfsRDCliQFdb1Va+8vUkPvrx6SqWIE6MEXGzymSS7NzNRiRuiJ2pef3fFaU+cfPn5dOl3Y1nujM+4bGZt0kC4SXHLOVxHKlZAK4QFi1pJLbgMNTmVScvVz6kVhZJLAWUGm3FyK4BES0Q+Y6FIm7P1U6xh6Fyr7Lrq6ym9ARENj9XQGnakd/6wraFoSvOmsjaBUvUJAjlBkNmT9BsvMEGSZjNMN/ahyIyOE/A9TTNSdl85v5z4gZTg66AIvX8zNfvHMU6cwOkFzNJPEOaoVj9OXFRKRI+nQxKFsxQRLdrppICC8RVSVGKRx724hmTOy2rNhsdqpw6iTursJkwhjTtYvdespU/jeoQqIOmrwlLEQ5IAFDmyOFiwidQKDeqj5qAkNEKjU1+hJyPOU87DA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(6666004)(86362001)(5660300002)(966005)(38350700002)(6486002)(316002)(38100700002)(2906002)(41300700001)(7416002)(478600001)(921005)(7406005)(66946007)(66476007)(6512007)(66556008)(8676002)(4326008)(8936002)(186003)(52116002)(83380400001)(26005)(110136005)(2616005)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UJQBNqFPe2k2puo8PrgfTZdPIeN+dULC3SCF1lZ33u5hCkUsaoI9J4JjBD?=
 =?iso-8859-1?Q?vdfTIne38VsOnPP3sOWUzTj4PRKQkmPZeclPI/jKw0Fe00EkZn6mUH6hJD?=
 =?iso-8859-1?Q?LOqd6dgDBVwqUD8I0VKTE0I4tw8ZcGThFjVU3F8sptsaJGM0Pt7e9NBFwH?=
 =?iso-8859-1?Q?nrpnb/m4/PXSDr+F9BOHC0XsS+TnsfNuuVWxFyFB6kIljUoADeOvIEqoWC?=
 =?iso-8859-1?Q?WBAT2UUd1kBLjdTRTAzf/1ml82A+ss5QKu5Bp7+XhNFBkXm4smhdXI+sXs?=
 =?iso-8859-1?Q?7EFvohqc+55FWN28ITvEmEjC0A99BuM6E6DQlO8nzMd4n/M1GZdTvjyrLs?=
 =?iso-8859-1?Q?RkyYpJRXUEqUU76Gkx0moqK6YamrXqwKWCmGlbnJeyyr03seKzzrTf/i7N?=
 =?iso-8859-1?Q?btwvSP0lClrdHPTJ7bxPwlzlNAXzEzzj4WDiL0KkDwmdwnjrFrolPNgN/O?=
 =?iso-8859-1?Q?t85HpExQKuHS4KV1bbumazMjrS14Gm7flKCl8IUVlOeAnFFVdKns6lRmeu?=
 =?iso-8859-1?Q?QGsVL8Njz5mdPrNixK9MkhmBq+1XRHR0KvbhaoMH3tHWIReStPzfD5+JfX?=
 =?iso-8859-1?Q?R7jYQGfOaYthUr0DFkHFSftCc6fRpttdmS7aKZFXHX4BLj8m8elYTc69uu?=
 =?iso-8859-1?Q?vt/aVK/ZQKeOLW5QcpaUF89zCGMYsZnnxOJekTBvx19H5I5/nMvXwir3Ag?=
 =?iso-8859-1?Q?KFl6FCted3kQoxt6i3pKz0rpRboqshIcOHWzUwiJCUPLndFpd/10gb8zmY?=
 =?iso-8859-1?Q?cL2J0v1rZUArcQ9FtneK2vBMfb3KzoHmQutSmQtawbH3UK7th2mJZRLyEM?=
 =?iso-8859-1?Q?Vt+LkwLq4JX5psePcpaJzE+ot/sCF5YtVONv2iQsqZG+pRhh21EQoAcKBO?=
 =?iso-8859-1?Q?JIHB4KR9bDeKt65WVR4nYlzekpdk9H+YqdHHJRg889CMGP8WPA098n9Wk5?=
 =?iso-8859-1?Q?cZBkTm2P2Jl9Kx2GLEoyUWbTFQyP5mGee1OnujaSYdo88v40ULfvsPczNy?=
 =?iso-8859-1?Q?B+6TkzzJrHea585Juk52DLBIftiG2GVoD6AOz75m/HhcT+GCvfrh+A3LQQ?=
 =?iso-8859-1?Q?B8eRm0aPxtj9e/1VGCGUcLU2gj3FFZ9+/8kJyT0aCOqVakixR9xsGHBbpJ?=
 =?iso-8859-1?Q?/U+NOs6dsCDgmBIo86UWANz7erjm/810Gu2kSGU++DrLMH9FYcfU56zcuf?=
 =?iso-8859-1?Q?rt3D+/otOgEQTvTxZEA05UqfLgjo/ntGWh1oSGhaO6f4vpz7AWLyvYiAEA?=
 =?iso-8859-1?Q?W8kdTf/Kr9CUQRC+4GpaJpVxxxtsQSOY5Zh8lTGcYSfIfweRJ8j2Xl5n1V?=
 =?iso-8859-1?Q?ZCvl1/24hFBRj9Qyy/TglGWZukNxdHp8y3b9aGgjdrGWDo8hJjqPk1Us0S?=
 =?iso-8859-1?Q?SxshWXp1R82USu7v/XQeXbz6mZ069G0rXcruGNn6pNFc2ancQYu+Hvfv8U?=
 =?iso-8859-1?Q?+8c0mV32OWISn37ioZ5fQ/6pKXLp+/rYDkS2W4YJt/3khuMvvWg/qAT0z8?=
 =?iso-8859-1?Q?vnWIbnMslzuExUr1j0iO3m74LDkWmbiswYfUqhPamRkDcaVsYe/zSPEFi5?=
 =?iso-8859-1?Q?B6UbDNUnjdqkNTsn9FhhqxLeLEFl+lvAiZn33UyPuHMWF0BkY6CT1LHekl?=
 =?iso-8859-1?Q?trFUFvUr2GpN8G64yDjIady3EO1kuZXfWF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c1105d-e69b-4154-deed-08da60175a1d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:51:04.1892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vniun9uMPy6J+mZnwifuUOX/wmmulHMFEcNaIH907P7WfZ2Y/BJrvOZHtSj5jpxF34P3bb4i8zu81UWA+YdL0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6418
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
separately the 'ocotp' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 24 --------
 .../bindings/nvmem/fsl,scu-ocotp.yaml         | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 572cb2e628bf..0841ad8bbd22 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -87,20 +87,6 @@ RTC bindings based on SCU Message Protocol
 Required properties:
 - compatible: should be "fsl,imx8qxp-sc-rtc";
 
-OCOTP bindings based on SCU Message Protocol
-------------------------------------------------------------
-Required properties:
-- compatible:		Should be one of:
-			"fsl,imx8qm-scu-ocotp",
-			"fsl,imx8qxp-scu-ocotp".
-- #address-cells:	Must be 1. Contains byte index
-- #size-cells:		Must be 1. Contains byte length
-
-Optional Child nodes:
-
-- Data cells of ocotp:
-  Detailed bindings are described in bindings/nvmem/nvmem.txt
-
 Watchdog bindings based on SCU Message Protocol
 ------------------------------------------------------------
 
@@ -149,16 +135,6 @@ firmware {
 			  &lsio_mu1 1 3
 			  &lsio_mu1 3 3>;
 
-		ocotp: imx8qx-ocotp {
-			compatible = "fsl,imx8qxp-scu-ocotp";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			fec_mac0: mac@2c4 {
-				reg = <0x2c4 8>;
-			};
-		};
-
 		pd: imx8qx-pd {
 			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
 			#power-domain-cells = <1>;
diff --git a/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
new file mode 100644
index 000000000000..682688299b26
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
@@ -0,0 +1,56 @@
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
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qm-scu-ocotp
+      - fsl,imx8qxp-scu-ocotp
+
+patternProperties:
+  '^mac@[0-9a-f]*$':
+    type: object
+    description:
+      MAC address.
+
+    properties:
+      reg:
+        description:
+          Byte offset within OCOTP where the MAC address is stored
+        maxItems: 1
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ocotp {
+        compatible = "fsl,imx8qxp-scu-ocotp";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        fec_mac0: mac@2c4 {
+            reg = <0x2c4 6>;
+        };
+    };
-- 
2.25.1

