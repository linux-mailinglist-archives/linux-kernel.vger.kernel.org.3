Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B47A54C718
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355516AbiFOLD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348767AbiFOK7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:59:24 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE5A51E6C;
        Wed, 15 Jun 2022 03:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzvF4VPmJePGR1kZPYja+Xb2BKIFBEZfmuEFblZLbugqVS2akHfgBJO0NBJFIsIyFKEud2D1pkRLqTG3hYum86CUqT08xk5XCJPVA65I3esh2NCBdnFNbXWtEOLgPSGQjEX+QzDZTyIWB7ynRk19ukPAVsu9yjvcg9JfV6Zf4iNJ/9maTY6JEk5SgrkBA6RO3FuX5WjY53+MiFP1cpzJDPXa3V1ZOt8vBOz6maJj30yMQu4/UQj3Y4BKqrHB2XRpiPcKJsRYr9V4ODOOxWoMDSfz855TGil9zWAYKjKVHr0gpJsnvq48bwGNbtCgcJzKSPUY9YRVZsgQUiTuFQ4nRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EzT+PaHe5icekHLA1ZJgt6MAMIzeFsGgUW+oG7l2+c=;
 b=PPPlpdHyvWqt+2nYysTWuRX624vkHWniBcs54XV60rpopurpUpfGwggkbW4/gw+k6kxGngoOm70L0wLdCwMMGGDflnN2kKN19O8Mq038j2pk8Igs3CtRTQfetUaNPtsj5rnHfxudPFPS4asPzfSHAiR40RL8okbrl0W1nUcsUNKB4d1fjppMU88nh9EY2bFUUGra7Ax4vxXW937h3NeImYvJHVSR7wNUo1a8J8SbfPtJQbiMtz2BvOApAgX88hJ6LwnB6d8GitiCRE/Cz2p4FqB7u0AzHJQcouoO2qrIYMEgzTU0j3WL0JR1ov9fB6RWTQkVBmYL5sM+MQ3oj3L93w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EzT+PaHe5icekHLA1ZJgt6MAMIzeFsGgUW+oG7l2+c=;
 b=Pi5KebAg5qU4Kq2Olq63iB5OVsWdWsOFGuOpXVNj8ldxiqSlCiJcWohB6vyQrR1KEAb2BAaszD/CdjdUgYwfk541o7Y7U6fEsThEQoXJUkvN4hA36xEL0w0PB5EBymZEdudNZ45Y4rCLJjDBQX6i/sWTEy0dp0q2iYTgkqhzS20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR0402MB3939.eurprd04.prod.outlook.com (2603:10a6:208:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.23; Wed, 15 Jun
 2022 10:59:21 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 10:59:21 +0000
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
Subject: [PATCH v4 02/14] dt-bindings: clk: imx: Add fsl,scu-clk yaml file
Date:   Wed, 15 Jun 2022 13:58:22 +0300
Message-Id: <20220615105834.743045-3-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3ba9d3d9-2473-476c-bf1e-08da4ebe19cc
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3939:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM0PR0402MB39391B899ADB32037140CD7D92AD9@AM0PR0402MB3939.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOF6oxMaKvZR+U4F3iPuD6Td5wuOtVQpRHwr8H1k9tIflPBhsQUKA7CjPgerUkh8f0nklTOikdJXT41TJzDn7U6pXl30x4PgsglPdRKRjb4n15Ae8heCklkfdoWOI1II+iaS9Lzc6kIHWT/0W2qkEERpWqpC/0skO/gDBn+124QIOhnssbczYrL6b+zeJvjv3Jdf/kh68VKnAF5meDQt50mnqOY3aza2msdwF6dFwVTEBjQ4N/78B6zpZmASM6bJSPiRWKa2Bu2/WyWsL1HfSlcwOCthU/ruO9+rstoW5tZbfWH7fZUrIHmtma9Dcrv0A2C7mpylcRMdnT6T89iUMn9mvJYY3J8QqfzoIN8D+UnMESK1H+IpA21bAOEUkjdnx2ubImjm6E2x2Ej1F3CNPrXHO7S3ueqUwK/fTR+MZx87Mu4zEwsU+ttlkcIlvWcMUB0rClF7assV320GhQDceOqCdCbdquSLZlt5GH6DWVd3T5beYQb6RViEm0U5j6DCxCdm3Y5dtIEFZ7mUOMEx7JPNEXLOyCDLVGCFyOtD0hnN+ECG5IJJQgDQ6phLpYa6rVy7ThkIhjg+1JveYIqr2gPsIW3jyuuNrHaNjz/lnEbcMhVuAkf41njSeQcAF102jsNVMxXhTXN7xMwJco/7Id3tolOXtsgwBusd1slZ9OPE5ZjF1uaufJIP6EFUMB85UTumal6QA42m4d+cq1ZpKQF7R59E0LGaTvzvUdDA01HggjKtienCBppPHulm05ziVl6jznqvdK+W89xRt8/T4NShLvfVtoJMCAxr2FZ2GLatz+d+H8Uor1mE9b1LKRqgk/lmNfvGVXLl2aQVh0Z/vl8Akyhy+Uq9KvAgC9sGeSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(4326008)(66556008)(66476007)(66946007)(8676002)(316002)(1076003)(2616005)(8936002)(26005)(6486002)(38100700002)(966005)(6512007)(508600001)(38350700002)(6506007)(52116002)(86362001)(5660300002)(83380400001)(110136005)(921005)(2906002)(7406005)(7416002)(186003)(44832011)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4jZOs1WAsUkvTGe0Xlo60iav8u6GiisE4ha0Vs0kVTPsIsMsKzgpL1G3Gz?=
 =?iso-8859-1?Q?QvX4pmR/e/JRlGSOaabjgnJZYzMV16L/9m+yM1s73oekt1m2kkab1OdZFf?=
 =?iso-8859-1?Q?5VzPVrNNNP8h5cY0WwrxR4fFJxzUgDF5CzXx8FPk3Kb13Iu7C7rdazGtpX?=
 =?iso-8859-1?Q?Nryap8noF5vWcqgrWL6I1tJYU6RPkeH5L0iyQL9KYMjq/0oQRMiZb/8U8q?=
 =?iso-8859-1?Q?UqiB6iDmBStZwBrBD7q53qlkNzzp8Sa12FNMZUmcKdMDXPGzYyRFY567Pj?=
 =?iso-8859-1?Q?XkUirxEJfk01KvMCZeGWp/lx5GuUE1YO9SMOiY8ZMsrOkTRUyVRdPVPzcU?=
 =?iso-8859-1?Q?8LpsFsQN3NpXumJ/mTTEOMxr9BEMxpnn4qoq495TRm9mzya5gxngXsuOrA?=
 =?iso-8859-1?Q?lVSyek3RKU1PHM/u2SG9phHqqIvL5elrNNsLdq/ZvZVzwfurXD6LMG3ZQQ?=
 =?iso-8859-1?Q?R6xRCEolXRufZ7yu49oZ1EvgM69HXRPmIsYUYM2XxNWlRR1zu2H+sshSb3?=
 =?iso-8859-1?Q?1VNcYNqlSHuNIoe4xwQ2RuLtCVmyWWAK7qMjLxYrH8YQGkdzSETMHxYtSk?=
 =?iso-8859-1?Q?xF9MV9GPjqdntb4U64c2jzsMJCk92fMYq+mmWWXoJSizhCbC/M0HWqM0L8?=
 =?iso-8859-1?Q?4uASf6x8Zyb8SjREg3Cc/T5tbO4g/l/B4Zufzd2JPewC2RLgABAV5XqZHe?=
 =?iso-8859-1?Q?qtKo+EGCLBM78SYx1wfECxiqhIIIhVKPY3y34vL7BS1HfFVUzwgCb2IDBm?=
 =?iso-8859-1?Q?uAJPOG7I/0Ku/x95XPBuXHzK3LK2Z3YmdIqfkOcA1DUOaWaO62G9gBgvZE?=
 =?iso-8859-1?Q?2+lW9g5+ncXw2SEiHc2inAx1F+NC1revTUhoTiCr1HPRyfpDJPoco5YcH9?=
 =?iso-8859-1?Q?ojYu6lEghitYsq58hPZnOVEh5i/u3U341X0rkW6N31a0M+CGzFwmEjSVHG?=
 =?iso-8859-1?Q?QRrvHBpkTgCaDdtJhmZIqEOC6hESAXttOBHs/Ut97z3ymf/SyM66D0Ym2g?=
 =?iso-8859-1?Q?Xd0dl6p8OH/FQptTOXaN4fjsa/izYtg1FhqxU3nOlnZhxoYBsfJxPZfWm0?=
 =?iso-8859-1?Q?CwGgRwwCyiBev289xzc6QIW5iNqACHmRnmhAGX2knl2PlVZy2e+PaFdrQJ?=
 =?iso-8859-1?Q?bQ2Vmdpo3A9coznnl1d6Dey1VmaYxwCGOINKJDIxMvL+AaESzUtwEJFr0W?=
 =?iso-8859-1?Q?1g6+GzVJEMjLaLe/zSmM4ITVUTtd3ioifpEEeLclQek8F1xy1/IPoV1EDo?=
 =?iso-8859-1?Q?s6AEUbfT/w5UzRT37ziuBAtA6HfINhPgkntvDXXDNfUdB1yU9SSlT7HPky?=
 =?iso-8859-1?Q?rPTNKWnQZE+g3odUVZEMijD3f+LejjSWuKA1BtzpvTEDk3UmhVXOeoMFbz?=
 =?iso-8859-1?Q?NAQ/oPyR67CEZTX/rpb2MnZOjld1nE4CP4RlDyxqDMDAdHhccDVmhGh9th?=
 =?iso-8859-1?Q?rrDlx/QKQReK/LJyT8Yi93VfuLpWS6Gv6OOpc1k5BBx15yrRJ25oh9hZlK?=
 =?iso-8859-1?Q?ptdloCH6Iv41sd5mm+keltZuLBUTWmZMRYyr+n9lvtMfhKr6iZuXuHF49P?=
 =?iso-8859-1?Q?jfae0Vg3oBE0ozzxtUToCdI+h55qOUI3l+P4dhaqdAggFHu1B5+YFJWZ5s?=
 =?iso-8859-1?Q?2seGET0smKJtyXIxnn5x/61hswwLywkB79VSadhG7uqFIZL1VBt7lMamW1?=
 =?iso-8859-1?Q?DRg6j9RTZKvf83khmwLqWFQgHXymJPXkTkueye227/aAr97WFX98D6zZsB?=
 =?iso-8859-1?Q?WxM5YK5RmAA8QTSpIvzgICFfrnKB/wporXve9f/CxAMhwg3vFkpSeywfdm?=
 =?iso-8859-1?Q?HytFYrxkXA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba9d3d9-2473-476c-bf1e-08da4ebe19cc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 10:59:21.1354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHQgNVmeCcVyITpeSEHW3J1UOUKTzZkfOSJ9wY0S5g5FVcWyUFvcn4Sa4Wi+XUkg0KVumpF38sj7RbWerMd0tA==
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
we need to split it between the right subsystems. This patch documents
separately the 'clock' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/clock/fsl,scu-clk.yaml           | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
new file mode 100644
index 000000000000..8b59758eee4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
@@ -0,0 +1,58 @@
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
+
+examples:
+  - |
+    clock-controller {
+           compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
+           #clock-cells = <2>;
+    };
-- 
2.25.1

