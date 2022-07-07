Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3C756A278
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiGGMvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbiGGMvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:51:14 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6532A427;
        Thu,  7 Jul 2022 05:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYMwxQKcimMN8j2uI4XCBODmckp0fF5/tlGkUeyHJ58GA6fXszJ4kv9k+NfGxr5F98FuaAtgcRGxfnnnlRWUJCYITtTU14zmYUKev9uyRIRU9r/XmtPk4T4ouYGdCvv+vaHpwa1C1msSqW/Nq5C5JCZycxaqvh4Jo5mFzIcKC+weY2L9PTun/XJZ360N8cxSUcN6x2SNj/L7Z07zeNe9Yi6d5SQIciB4seWu2OLbj31VLxP0Q4zTRgzeGiE67k2EtWM9OwFQL/kZ8r/EqcAlHoEXoPdsfdjRMBIj842+j3pqiI6OXuhEmZjr4JzkEtVxbONIb6xFmjrvSwv9ccLCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajmS145l2hraJV0hvsPvp7Rtw7WtNorKE0MuE39VJNo=;
 b=OJqbsc7xWDitmPlBHWsZwt+gUCkSdA0VWQRDlvSzvQyBJiHkHBuWnE621/AQw4x6jQq+3NXqpkPQ2amnnq/EazPSN+vsa1hiq2mzwQ8jZ28XACmhZ5MYJNXqyAechh655COYZlbtEUkmowUj8cOi/aB0tCz3Jz4DhVYkZ7SbRembdA/2nbIJKXkrc7fWueC5kK6FoOLjHY7Mgo7GO1LQHATSnKyqsSAGx2JNS1UaDL7+qAwPA/Ck+g8f3YEhr5oH+pY21+nq6z64iGCgc+sT3vnVdWGW+o7uMQEOk3uZt0ZdkfXtoYxp0B8ol/+/GjyM0ipDRbay1JrBMOBl2j7ilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajmS145l2hraJV0hvsPvp7Rtw7WtNorKE0MuE39VJNo=;
 b=WRUFipZYnd71YQ/66xAxcJy7XJKw0fiHpygo71w5+8Cc05uAWtXDldMLGMIpd7t3VGDCO+u4AiBM9hf10D6Wk6Uv4dsjEbyITTcPzpJHM7F+xenXOB0UV2YFzZMZCXDa7n0DLDdWStHJvT88RWK07IqGmc0/2zcKonHbAN+M77w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6418.eurprd04.prod.outlook.com (2603:10a6:208:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 12:51:10 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:51:10 +0000
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
Subject: [PATCH v8 06/15] dt-bindings: rtc: Add fsl,scu-rtc yaml file
Date:   Thu,  7 Jul 2022 15:50:13 +0300
Message-Id: <20220707125022.1156498-7-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c93cf305-4ef8-4e1c-8e50-08da60175dcb
X-MS-TrafficTypeDiagnostic: AM0PR04MB6418:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2Z+HISxK2EKFtLcCQ+NGVm+7njtF/qlFgYYccxw2KhjDll7aIA9CFGukriIvvWdHCDrCf+TyEmbdb7jc4Fn4TTNK9EkMLeljEx/ux8U+/0NTX6JGBBCVStCjuTCpq+SJ25vJrK4hR98urVFfkvdulGErvgTQw+c9I0T7ckLL33wPKomH7hmsE6Y7TLTLU65xcGJrPz72d7TCZEVz/ikhNoIpkItDN6gtu+SfxB4hnyvQHagMigx4Dyz6ZgS5eZtKNT3zhOJIds216NpRDNK/We6Q5M8+G8pFIm/uqR6uLzMwQP+iJ/5Ayz1PjXzpOGwMXueGW/PzBX4JdgXkSFT9vfDE27KHM74Ze6xIS+mpJv1zi0jiXMOIV0fA4Vh5vTHMX4IdIavT18KBLfJdrmOtUC/bDAhYppTqGAxzVa6gwb0Hme2JV8Q+2n1FzrWzjv+4PCGNVyidVfeSwBvM9B4C5wQq+7fphTDHuqxEsPwC6yOmI94JgH9Q1QrDy1pEXNSTRZdjbG0hv38+ZAFmyngH6bwITUrFBCEr7jNicnONojgXCzRz6YnkOAoYYv16LVQcZn1sYC7QU4h3x4ORNYMF8M+3Ojxhe8pVSGbZ/jt43nOgzAFPueR1yaJpvbstQ3qBOae02Lw6fEdKLWKXXROhO+apYNzh/fHxMNiJYwTEobbHV4ofWuIOsh3WVNnk8hdi5U6Yoh2a5tmteWBPA0mjcJfy00iYJv19fXWJQ+G88TQBqraa2NurwPOi88kdK0sg7tbJcGwTgbs5Y96IoUDuwko6dJoU6KUY5BNC7OBzztOIqOzd7RpzsSzgnPoR0wnMJJiCICFd03jHEy6MF+585AVKQp1azXwCOSSB9VqIYmE4U4rWXNLDFEpQ1fHBniA4vd9y7/ewYIHuYZrB8zNfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(86362001)(5660300002)(966005)(38350700002)(6486002)(316002)(38100700002)(2906002)(41300700001)(7416002)(478600001)(921005)(7406005)(66946007)(66476007)(6512007)(66556008)(8676002)(4326008)(8936002)(186003)(52116002)(83380400001)(26005)(110136005)(2616005)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?rK0s0H78JX5yeRn2qVXSd7jMVJ4485R2xK22hks0CHPqwPaSLhtyd4Oe1M?=
 =?iso-8859-1?Q?GSoip/t4qb3jCwo5+83I7TkvdDHbq3spf5rBC99ZEtRmOX4cTB3wJjP5So?=
 =?iso-8859-1?Q?x4ApPt4uMiObdav67gMOE5Afd5jLGRW3KLYyY1I3oUDl7niVEL9yZ5iCff?=
 =?iso-8859-1?Q?iQR2YYqkwzNqkQMAD9TiurVbsbztKGru1455uCDZJ8TnMn0jjN+YLTtxGN?=
 =?iso-8859-1?Q?+blp9aD9FDwrqLUYMQUxSFoYOSK64jjdllK5YHUIZ6dgzyskOus7y6v7b5?=
 =?iso-8859-1?Q?vBDwkISMymHeoS/E377anYZcr37asIxkXvNAeARoonY7gL9c4lHDoRujQQ?=
 =?iso-8859-1?Q?9+a0dLFYWRZgYGOqeaZTaNipf5wRXb4JR3PHOaewnkmGtNwkOrCYji+mS2?=
 =?iso-8859-1?Q?NmdmyZNtd++GA08fmrFXmgyoSmn4hyo+5BKwypRuSWh1qAE7wEUYY8KJM9?=
 =?iso-8859-1?Q?pmbMlDsE2vX9iQAOmdCUfQfIWiyeC1zfDbMqviPXoc387y4q4OsvICIgcU?=
 =?iso-8859-1?Q?lvOmoGvjuQJs+sRXEyddSN/IkuWzXIt/QP7cVjTMSAvHSotXSLDfbuvkto?=
 =?iso-8859-1?Q?dH53Py3oPtz4mZed7KsWVJ8s2ztw1iEJGmc0NHP3FwpABH8bkpkdHD/VBp?=
 =?iso-8859-1?Q?qyh2rTM+MHR2FoNqXzqP/Ds7W07jBPVXZu99TOTDbpsW+yeaxQRtdbiGOo?=
 =?iso-8859-1?Q?K4ugU8jHdoBq2gIE+Z+oD0jhSL7KjFUUhwaK2eIEbPOX/qB8Vt4uQPYUwM?=
 =?iso-8859-1?Q?0fIf7av9jk+wbk169ZdBMqf9UwyF/JjzEQuzsxbT8t4dexh4vk8I5c3z2F?=
 =?iso-8859-1?Q?roqy0zhYd+mzcqfFFAZqs8LPuB9vfgUSuOXFzxsIDl8ssVYQdm+c79lW29?=
 =?iso-8859-1?Q?BkQJvmAJ8JgO/5815apfeckrF3E1TGJH+XFGSMKFcPT5Yx/HN5LIWR14Ga?=
 =?iso-8859-1?Q?YV9N+BHJdhk2P9Xxz3kpqO/gjgUfQV3pncawfCJBZWom+G6vBEsmcNjTrt?=
 =?iso-8859-1?Q?Osr4nhTJ7NqJ0NvpLq72dM++H2GfeLCsk1FIZCIiXxdBt/CUUsf9bL2pjS?=
 =?iso-8859-1?Q?gnZh98MsAqiNrB2BIZqYKtwFtZC3yf5eUoDQzAQP8VHdO8KQIO9VI0jCLj?=
 =?iso-8859-1?Q?FzEg56KSfWokB2OdZaSxkT6c73vXDQhpZGfYmxG2nXxAfPGZET2dnbD5sX?=
 =?iso-8859-1?Q?IvvV7p1pXu7HOjHY123a0c5FQyezAOoiN8t0O2VsDKFM1rGrMq78tdDeKw?=
 =?iso-8859-1?Q?dhNIXUZRDl52lk7QU3I/PKgNz2os7rgbJfRhRVxdivo8gK60MCKMl356x9?=
 =?iso-8859-1?Q?fOKYf1w1dhf4wX6Nf4PpBtGlIpSa1z5apwowfxaF15X0Tom+o6vpbQpBFo?=
 =?iso-8859-1?Q?g9SX+iR9hxNcr3jSRkW4A7PygrqnBd9cuN9g0hdeHsNjW2eNAf19RlCI3b?=
 =?iso-8859-1?Q?400EXFMNOhB9cNfz73WtxSOGpMEW1/Pg9GohOBWbc0qEVGcPSeiwvbzFp+?=
 =?iso-8859-1?Q?Tt+7HSEqSA2maiwuSh/rIyHML/pTTFrjTaiVaiyBgrtu3eN5w9NFPPTLMl?=
 =?iso-8859-1?Q?50NpiA0c+k8Oy+pssw7NwZWx9QzbUYD1ufe9SXPKtm0UYgRDlbdRuUwdvx?=
 =?iso-8859-1?Q?AVh3XhvcSZQXheLCqpRQkpiejPI161llLz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93cf305-4ef8-4e1c-8e50-08da60175dcb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:51:10.2200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHDOOuu914TLPIE3L6i2iymRW4md1XwSVESbyO24ycmJUHYdsgSByp2Qd3/2srMiTlv0AQb7UWZChYI7WFexrg==
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
separately the 'rtc' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 10 ------
 .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  | 31 +++++++++++++++++++
 2 files changed, 31 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 1a06f627b125..6c0161fa4adf 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -62,12 +62,6 @@ i.MX SCU Client Device Node:
 
 Client nodes are maintained as children of the relevant IMX-SCU device node.
 
-RTC bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-Required properties:
-- compatible: should be "fsl,imx8qxp-sc-rtc";
-
 Watchdog bindings based on SCU Message Protocol
 ------------------------------------------------------------
 
@@ -116,10 +110,6 @@ firmware {
 			  &lsio_mu1 1 3
 			  &lsio_mu1 3 3>;
 
-		rtc: rtc {
-			compatible = "fsl,imx8qxp-sc-rtc";
-		};
-
 		watchdog {
 			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
 			timeout-sec = <60>;
diff --git a/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
new file mode 100644
index 000000000000..8c102b70d735
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/fsl,scu-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - RTC bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: fsl,imx8qxp-sc-rtc
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    rtc {
+        compatible = "fsl,imx8qxp-sc-rtc";
+    };
-- 
2.25.1

