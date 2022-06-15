Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D16B54C715
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349813AbiFOLDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347124AbiFOK7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:59:46 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C333E51E6C;
        Wed, 15 Jun 2022 03:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yhi5rL2IYv1iTWfRM1uAA5snfSB7iNCstg7hcaO3gw+6WTUSAPZctDbE/fQPYlDO7bHFdaS1Vv7JjxmxtP8Qlz4ELU05tEQWJy8+nloNW2ZN9/j0E9JwIsF1UCicw4K7qqc2NnKFQsz7E/nk3huMT+TZDsQDl5E66cvdjqZMP4ihF8NvlKURHMR1m2wIeZ1seBp67Te+3K53d4W4eM2sm79TwZnBwaEYeJbsrej2nC7HiukTpHE5XkwNsB7HmSmc9Tt4PE8B78Qi9mc0DM0gulh+3qmR4Yzpton7iD/IEaQfTuACJgwCWblkWKlesgUezCAdhSr9S2n+mLwzT/nVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8LE+x3TttH7qT+Takh6K2M/5SNH7ZTo25mc68bUfwU=;
 b=nu0lYCyJ6s1UgUbaRLeGSKg7aSiKOARXq8ZWeBjswgVmoAEmc5W4blw79d3S+VVSkj/14n51MgKcYolS3kzCeagFV4mA8WjFFYKLXFR9iTFBFwjWLNIQSvNic2yJpKgopP/QGSw1VdUuf/dQiLryIgDI2FbUGRu9ZPWK73gKc3Q8WcRTJ57X8LDGRvHDrq3SAlPkuhWmBOkZ7QwbGkgAUtAVbzqsGbFWxnXL2zymtIv/DcXyZv+MxWy4LDuaxs2T+lZOzBe49MLOvFuNausUBpBrOPD1vLO8wyV7Yf4x/g8nrDgi8l/B+jOS4GpOcS4YRF27SmWI1kTAwYdSlnIKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8LE+x3TttH7qT+Takh6K2M/5SNH7ZTo25mc68bUfwU=;
 b=RzZQecIne7dRW7c8QJVoBYn/cYE421apr5vq3gGEHyjTC1KDkmxL+7ukpwaAoApCzGiXqIuazxDnsXO7OaZLg/DZ0ft1NvbgvkTUuviGGdJfJ9QruvLYT7mKgRAhZsffFNyJuXhbW/Cwko5c3wEROVVNmfo2KpskdiVD/9ArO3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR0402MB3939.eurprd04.prod.outlook.com (2603:10a6:208:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.23; Wed, 15 Jun
 2022 10:59:42 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 10:59:42 +0000
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
Subject: [PATCH v4 09/14] dt-bindings: watchdog: Add fsl,scu-wdt yaml file
Date:   Wed, 15 Jun 2022 13:58:29 +0300
Message-Id: <20220615105834.743045-10-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 88450a3f-3ea4-4edc-88ca-08da4ebe269f
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3939:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM0PR0402MB393976B14B03AD90EDCE0E2392AD9@AM0PR0402MB3939.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ej3ODDRFxWEUiZeNUNmfT5PCubnpXyrnaKfYVLAorAHtoxB9J4j63cAeOqluzhv6YJHqGQZhRzhq66kCFjGBIEpXv2gHBZ3/qOJR+dRfjZwB5XdKue8a4g59A95XoDXnLXjqfbEsBj8Qb6dmX59mUq5KnGKk/sZ8qY5jjM3B7qhLn2aNYi6fH8jkf85rNUOgnU8lj4d13hilmZMgI9Qpuutos+JWVFWBV+HLG0vFYUiKrn55EDHBRG33qozzaY2URydbkHwftQ7YfxVJUEZzN78j3eNnIC89Zg4aYFoSLCOZDgaILB2Oo7R/PPRdcaQ5opMX4BwrA/RKmeXXuWB0QRg5TLKTAfuq3s2v8/w+XtRdc62Ocbx+kVcWpmpN5VPEyByRw19VubpKa1TpD+W1yx2pTq8NZRHj+8mMiAiHT1mCKbXHOOCM45Y9wUwLi6JqSKQKg2nit2POyxPGjSTVxSZ26zxhvObD79zc1nU6T/gPJl8c1UIe75aIjeDmjlRKJFm4OpaxKnWoauxH2ELvr2XSXcDzMn0vE6pOb10tvloE3bTDS0x4md98jRv0opGsSA05zPgZO+xgRuxzr7sQNWhThQ2yriZ/Mt+bXzdDWXE1cRMKHh014E0+HkPrO0axE6SJXrkXZVnu23XfrV9Pj2rT+hjQo3O57mWK82VrrXOOd6pFITpFlFWQIFl4BztFJzLfwjNnabp73xMlkSCt+yBb+qM0kzSM2/cDiqD3Fr8nDyjvbfuYUn0CJdYg/dGQ4blwWl6qf0Akpt7549bFG2q5/ewVzN1K/CA3Qt+GzChgGW0QTrxkzsQIKkpOsniWsIWQO8t26fpRf3hJ+wWBMI5oWimEEwKNr+m/ZXjkEUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(4326008)(66556008)(66476007)(66946007)(8676002)(316002)(1076003)(2616005)(8936002)(26005)(6486002)(38100700002)(966005)(6512007)(508600001)(6666004)(38350700002)(6506007)(52116002)(86362001)(5660300002)(83380400001)(110136005)(921005)(2906002)(7406005)(7416002)(186003)(44832011)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/LZLbZdOHGg3D8s8iTsN1zVQrd+8CzBGwExjupvesYIj6YaR7aWZ/0v08X?=
 =?iso-8859-1?Q?zP68cFZfoZAL9SsgpAQzN7EmfrfFuiZduVCTEuIn4f8nBqLy4gML/zdCT7?=
 =?iso-8859-1?Q?RgPsCDcHsBp2byIo4yfUr7c9AF981E4FWRAs5GZ2DeW9QXJpCA8RLvIzzj?=
 =?iso-8859-1?Q?AXS0c5NIj7SEtuPlTdSAPZcBdaYaUQP3O9dK+MB/Q2C2Pyihw1VjPbjpfK?=
 =?iso-8859-1?Q?q6Yu0BIcUd63AZVJmqUsw6Rtbr9MdC9iyQ/GY4YiSWoN16Y4ixh4fVHVXK?=
 =?iso-8859-1?Q?YveLuWvL6YXMnwfL8Pzs5Sd2Zzo0d4Sffffbci4gu2OaNEuQRtRZweY5y7?=
 =?iso-8859-1?Q?GT9cOJKNkZJ1KI9knWoLKEzFae8a2MR4qaWXkL01EJzgiFRb62TxWAUFNc?=
 =?iso-8859-1?Q?DKuC2dIA76F6KYH1cKiZOZo2+9p2qBlCXNpUMPA+J/LhLJ9kHQOlCCIcjJ?=
 =?iso-8859-1?Q?0lBYXaA/NcmaJHfX2wUWFEzMwuOSTsgwlSEr/KHz50PcjmK64RKLUx7G06?=
 =?iso-8859-1?Q?QdvXeKnZ0oEXOUtbhwal2lBKn8tM3dKPTEpOtl2SBtV3DLuWRAx9sw7XnQ?=
 =?iso-8859-1?Q?A3H9fHSpIpmQ4MsZ0OxU7bEPp0Wzj3g9Ku8maFp5DGCFc5q4l8zqhGbcUq?=
 =?iso-8859-1?Q?MSWE7Y6+YwXhRYnrpQIcw+tcNI2A91DdKqTH8MRgXUUwXydFAHyLG3SLhu?=
 =?iso-8859-1?Q?N4GpFuChqTEhp8nIkmyV41QLgvObd6insKL+6qMbGwd6YgoF1d9cQx4spJ?=
 =?iso-8859-1?Q?Sfm8iyuLVaeFg+odyErCFgwtQ5AHnOEwigR4xwZWN6IFOZyH8SBrLLXZPw?=
 =?iso-8859-1?Q?tOa8kCA9I+bCXGlXXQQyl8+4uDXkrTmfp1isvGgKrDt8vpgfUVCgnQLPBB?=
 =?iso-8859-1?Q?q/r07VwiU1ojVooQ3LSgQ9iiQYtsT3FzMTa30gn+ismhKOkJ3QIPtLjqYm?=
 =?iso-8859-1?Q?7m1J2+pbRYT/kj1Rn7x+Ee4Df0Lk3jYIgdsGHjfFsJcfP9cBlmESiRykUq?=
 =?iso-8859-1?Q?SejSK++FnN53oog4sQdd/MReAyLWAsWAq0x/0nh/7EN8w+/DRzTOvt2b7u?=
 =?iso-8859-1?Q?PN3J6Mgkohoq/WFdl0mMBfjHuU/wETYGmeBlsgWI/yk9SI0wAR9QZQL/Ua?=
 =?iso-8859-1?Q?88O9vgAY/+6ZUsbSA0tzljru4NkjEzWDzqNscYOL5YdFquM9tKT8zgBdxm?=
 =?iso-8859-1?Q?cBJe9kE/UrTgMltHfVzyvzEfGFoUp+h6Xauzp0V7khZ/2l/lKahGYjgaln?=
 =?iso-8859-1?Q?A7S0gcRQMwXRWd1pymVngtscyhcPqNVuZrIstwO+EBWLF/lpJ+fNHukPaU?=
 =?iso-8859-1?Q?b64otJph4Z30zkNiqUc8bqfkdnMeiHjLvTDKiTpd7SM4EHgHPVFOcwin6A?=
 =?iso-8859-1?Q?/If7cLAqNgjDh39J1vn+xlAL25t+jrESEloQUmtXjzinzmR1BA1J9cwKV1?=
 =?iso-8859-1?Q?icf5esaSdENQhOIZnyK8EEpqcEyEsZ3BGIjlK5J9HrnTf6hcTYsHrXW83F?=
 =?iso-8859-1?Q?XtOdI1JllqHdKPb43Te3395U3dSG9ZZZjLf8/NC+bEmhQwzaBFhJA0Ss59?=
 =?iso-8859-1?Q?TKV+/D3R3rKZlcN59Jqhkc3npcXEuBtODPiMAQmHJ6Lf/cKGsCxh0xXRd9?=
 =?iso-8859-1?Q?z7Eh5ey0r0Zcy3L4uoUXUhfehXaMg3ADV0AbV6m7BjDLH6a7PLJ4ac8sA0?=
 =?iso-8859-1?Q?2zFSCvA7Mj4ZormIpjGrYlWq7bQVbzhgGw1R+9HLT4vho0H0IKOqzxydQI?=
 =?iso-8859-1?Q?LEyc14XLfLsSwDg0v/YqNqEgU7+aknfFMN4y5xgPx5ayCj7TTsMxX9Ibdp?=
 =?iso-8859-1?Q?DhKulRlXKA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88450a3f-3ea4-4edc-88ca-08da4ebe269f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 10:59:42.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiTjIAZxlmpkSb13MFakOBbsu0MGlehFVgYnc+rmrrR88UMwzzmxgQkycTTAZucRMVlW0myvOdQhmlBdyaZmLA==
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
separately the 'watchdog' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/watchdog/fsl,scu-wdt.yaml        | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
new file mode 100644
index 000000000000..c5d3063a4130
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/fsl,scu-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Watchdog bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+allOf:
+  - $ref: /schemas/watchdog/watchdog.yaml
+properties:
+  compatible:
+    items:
+      - const: fsl,imx8qxp-sc-wdt
+      - const: fsl,imx-sc-wdt
+
+  timeout-sec: true
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    watchdog {
+             compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
+             timeout-sec = <60>;
+    };
-- 
2.25.1

