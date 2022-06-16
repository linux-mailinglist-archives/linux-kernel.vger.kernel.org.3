Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53AD54E7BA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377420AbiFPQoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238314AbiFPQoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:44:01 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6FF28708;
        Thu, 16 Jun 2022 09:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pch6Exv2xBRhkWJYGkePTFcWJDWq/QpD0MxB3ISAgjdE3dJQyIFjWLlNjH6VdSCmAOo+0cMwpYU7/K9cOb/m/adW86XCccHabnJyey+y00rQJnt7cMWlBtStyXNnkCFw/sMfkxBuO7ea3ry6WCIiLxcI26pboOKZ//LKLOUdFqxVCL7bdqIUdH0Zi3KFkdkzXQTDYpkj7vb6qDMjqMwsnrwS8voxs1uaMZq0wlpLtv3+Kce39v/SaTdp3d3LH2QL21mB/M8N3yJzonWRGHhARlQM6p1SQrX10R0ZhwWgJapfMLxP2i5OTPWYvxHRE4NSKBQpbOKM/Lux9effMUOMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yciRjK5VMs5kFQp/Ck94eaQI0MASYSaCfcj294nfsBE=;
 b=CrQJO90KLCOcXJzjGfXbN16Ulnn9PtBSZb36/nw2ogGqtg97K8V/yhl/NhHYyj9/ONvI+Lmkuf5koAUF2JcODlUtyu0jHFlpLlXb/iVTPNtn1Az8lCQRJ378OK1BYfg+g4AoAVmeZOS63Ae7XIORqiSYP+AVpn2RJ0nFCtEK5HDfVbkcGgCw5jetJmoxtmuPfRG3lX0Lm/mYYcousXAQS/u4h/WTWCt0Ho7GKvuBnPwQzItvnUoo1zFQmBmdp08njiaAy4fcw4zrkUq+m7hbru7NBjKSWRNJnmbU1s67CyMEQwcGKrkrKSjiOc7Yr8NRzSTE7akrHiDtR76409qFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yciRjK5VMs5kFQp/Ck94eaQI0MASYSaCfcj294nfsBE=;
 b=NQYqKCdH1YNdj2PWYdZr9Ryaamhc+fbQ0WNB0a11jZWUAtQM9bGdQUFlZ4mDc98LO8E8IpQxfm9ARQdXX2EviLUXE2wkmYNK+Zf1osYPuTBt4y9Y+vFI9clkxdCrANyq4MVCpEZjgjXI+WqlCyNYhDaEkgxDlor9wCM7/IwFWb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by HE1PR0401MB2649.eurprd04.prod.outlook.com (2603:10a6:3:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 16:43:57 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:43:57 +0000
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
Subject: [PATCH v5 04/14] dt-bindings: input: Add fsl,scu-key yaml file
Date:   Thu, 16 Jun 2022 19:42:53 +0300
Message-Id: <20220616164303.790379-5-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 32dd8a60-cc7e-48df-5a33-08da4fb76810
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2649:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2649F77DD975D52D54F6197C92AC9@HE1PR0401MB2649.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4oOT/c85dePBCEF/T9a/w+bm5/jwLdIf0Vj6aAcXwC1QyR71Z4Bqt0C6OYsC58F64W6uEw2xFGkyRa1bef0oJSVo9ejt9O05nqX4lbNu0PmjXU3SZgLlac0zrXRdFutJVubTwbN7gnf4ZgPjFpgRhoW0vLhXX1RNOR56/rbK2FtMTE6hEMSztiOFP8/bfYVy9z9ULLu+1qoZam3QQV6YaA1bVWynQ1p4qXlQwLJpCtDDAewjNPzg+kH2/Gn+i1zn+UTjtmPO1pMSRigBTjY1NEmTaEp9vm1Ex6Rqd1Y7BtTbcKLSUj/Oee69U1/ELKNqlMksVRDNOeNB01i2fUgmvY+XptVtTtH2EFbQ9bvtroN1tcQb9HlT314/iSsgNeWsfWpnv1RjwbZQcZMuf5l49tXTrmj/0RsooslunUTW/Y1RKN/u03QPnF6fq1ZB/E8sE9hvwDJ/KL48wwP9HDdtHHhfv+xooTEOJ9cCk4cmlgUasrozKbuwR37AinclnH9x+08H4UO0o85BMBjVF4qAUJKvXM7n1TQnwnlRZWA7tK1djpQR0j0h5GwIrts6t1rbt2wYnaY/L1K4goSkBYheThO89lwMX6Fv/ziv/frO62NN8f667BcRNMnZv45xrf/tloqYI6JiZbfKFfdLD8/HgAPYEuLlM1R3M94Y1RBeAyW7BYis/5C7zto3VVfklL7G3xpvycdUr0bQUSIl57toUYs7szQ3rPmUy3PPaT2nlFoRotVeS2YxdfU0sbsotaVlmrdXrYyxZNbTAonORFLLYGpW6xjGkk1d66PlSb0pY44V7Umdiz3EBFN8VjchrCge9gDVbFnTW02E2lPBoir/poSM10dFN5LROWa+2ap3Fw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(86362001)(186003)(38100700002)(6666004)(5660300002)(2616005)(26005)(7416002)(6512007)(66556008)(7406005)(2906002)(83380400001)(66946007)(38350700002)(316002)(110136005)(52116002)(6506007)(8676002)(508600001)(44832011)(4326008)(966005)(36756003)(6486002)(66476007)(8936002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ksfjps2gmTo4FT/6drpM8sEqyZTtqrWKILUBNgsKVhk9QRCb0jRjGPHGvS?=
 =?iso-8859-1?Q?x0mXIpeXY8AtGIIzGfGHP0LfGQobsM0zIDSbT9cbm5dIn31gBzzq1xmYhQ?=
 =?iso-8859-1?Q?bUNeSMn9U9DyBozd9G3RS1qcD10Zg3FWGjBBR6xegqG1zAuXfLxe2XLR94?=
 =?iso-8859-1?Q?HgTRTfthRQIYXER+qBJWJnaBWoYAJNCOr5OzaPqGdcey7F3/GvpuJumiSV?=
 =?iso-8859-1?Q?nJBN+7Tkwn84Bdl2bZIn7O2rXvhQ54qL5uUXtEWKRLjLa73gn2F8SmjSgp?=
 =?iso-8859-1?Q?NFHHwB0jG/3d82BZtv3cWZL4H6LIJHYom3AQfTs/JMcCequTPJij6mbHZs?=
 =?iso-8859-1?Q?LBtKFsLDrt5HxZQMeEzXETCQ8vTedp4wYKa1MaqGm5rd7eDwK5Xr/2hzPN?=
 =?iso-8859-1?Q?DbwIgjfcKjw4OQfolEV8PI70sk1Gcbne3wHnEl2qVDxArHrADAWyFOowwZ?=
 =?iso-8859-1?Q?COyUiu3813u9yySqQ9ncByxynkbyZOH5V4+bU4CPjk0uI+SCj7t5L+lgL1?=
 =?iso-8859-1?Q?f0BxmFuajlAb+JdhhBrItrqboO3MPyT2h5cKhSHX2tUyXWUMuyyBEamgvH?=
 =?iso-8859-1?Q?tX9+huCC2zaXi6gsBZ0pS8gyXh8YEDQvyso0K12j6BkuMTUmD1Ynf53p3r?=
 =?iso-8859-1?Q?SoqsMFX3XlAa0zDjXrejVlFXR1SRH8JNHq1IdpBBjFStV6FquCFtZ0oGCr?=
 =?iso-8859-1?Q?EXZpVnKVJX1yR2IdkfTYaXwkkew74xMVum9FMcb4tt95BJGZ6MLE7IFveb?=
 =?iso-8859-1?Q?ko0WF9dCbZprORF5fIf/+GGyojSE0Ky/AUM8Ql3O+rUMwzC1EDR49U6HJP?=
 =?iso-8859-1?Q?k4WIhoPNh7h/IIhCrHiDmb0YzRVrf4SxLWDwYQfL5QLtNcKGLqqZ7Ns6Jg?=
 =?iso-8859-1?Q?M5FSrIciRTptnUuRmuPc3DybVZFBMNwU0WQsRUybvv1VfX/RtTAA+jgihR?=
 =?iso-8859-1?Q?obJqLyTL6VcFKAzP+WBA23eKJ2BCCYesWfFQqdyzYuws/gzZEdB6HmXQBT?=
 =?iso-8859-1?Q?pXXYGJz/j3zjYX2/XCacAXLIA3Vd8QxAnDP2q8q9VoBB+wNJnkauO6dUOm?=
 =?iso-8859-1?Q?0Y4/KxYBdhJoAjlCeJl4tmvLFEWZ1woAiBEjTFw2NtC0qR/EGfXR+I5gHW?=
 =?iso-8859-1?Q?igBEl7cY5VoF7BhUPysN45mr4kCPtx8pnwRqd+2dWq1vmwSh/SCkHF3JT4?=
 =?iso-8859-1?Q?jnbQZJwcDwG8MM9TZA3nAchgi08FDEoykNUU2fkXzbBrapnV4nGyjevkYH?=
 =?iso-8859-1?Q?VUPdfE8u5ku2953qTiDZpA6MMTN2A83QVSSuctpdBLqvLkVgypwgm1sYmg?=
 =?iso-8859-1?Q?ta8Ux8ItPwfgXylE5Hbq3lYCz2yBaKqfrQAvy9+fEyJmlz9abbD+dy09SO?=
 =?iso-8859-1?Q?FErtksOwaSHehIGGOMoHcQiXkEl3jF3pa8LvKRLGTkUCvjdjv5+C5aWSJ/?=
 =?iso-8859-1?Q?pD/DCWO39A2B4NL3jFkVHMvAwodbAsYelr1NCwKP+asl1FpqzdN/cNlpb4?=
 =?iso-8859-1?Q?7SNaaeP5Xn8poSxk8DoqBbY530IgLtvEmU6zVUmKl/UiHAM7qAOH8/qJkn?=
 =?iso-8859-1?Q?h9otaNWle191LWJH2gh5/MhN00xAiMG37mEDcKJQqzWIc3AA9aIy/cxfxr?=
 =?iso-8859-1?Q?ge2hirGthwvxo2NmixxPbyvYnbmcEnQvpUIzz8htxyo6mj8qhIfJM5uHhi?=
 =?iso-8859-1?Q?F4fdwVgHCaY2C+bu5rUyBZi8BTkBduDpZVsM9pxOKywterdJ/tyaRARIqp?=
 =?iso-8859-1?Q?3gm28w8RiGTPnLP4ecvdhcsE+7Ed2RS6PAaLbu8Vw0WjbZBYW412O9X40V?=
 =?iso-8859-1?Q?GG0Dr5IBAw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32dd8a60-cc7e-48df-5a33-08da4fb76810
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:43:57.1732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXn82ckoaqGtFMZpQVDUSGGtmRL31mlxKvmAvGhx6+Z+6Pzx6zxKVy3h9q3C62CvpLyaa25MSLsEAMMQ8GiF0A==
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
we need to split it between the right subsystems. This patch documents
separately the 'keys' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/input/fsl,scu-key.yaml           | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/fsl,scu-key.yaml

diff --git a/Documentation/devicetree/bindings/input/fsl,scu-key.yaml b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
new file mode 100644
index 000000000000..b0f4c5b553ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/fsl,scu-key.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - SCU key bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
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
+
+examples:
+  - |
+    #include <dt-bindings/input/input.h>
+
+    keys {
+             compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
+             linux,keycodes = <KEY_POWER>;
+    };
-- 
2.25.1

