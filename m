Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC1F54E796
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377769AbiFPQoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbiFPQoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:44:00 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E6E27FE4;
        Thu, 16 Jun 2022 09:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2u3BEW8Y05Yj4sblenNfAecT+vvc8LUl7hTJ6dEkU/kQpObQWG8c+nmvfrKPltBOnZEvwW+D9FD/5Xf/QxnrMZ7X0KEdNjHvDmbHM5UZeGJ6AYuozNX9adJhrjm86I6SmNP1F88tYWEuC+AQAMUrrUIiNSYovDP8zSl/VQu0zIGU4zcm968qKddC+xrKqS18BGQj3lzeXi+W83oeFOXQTdJPqo/i45iDXe7vwy5W6/1orG7biMuqrPkDcd0FWWn6JXnakBDNS3cT8mkiOopb1mag7fneNNu37OqR1tl8/hbG7djlBWg1tfd2N5lKH93n9SaBAOhzUZ1dM25tuxx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5wUbaAZdJFlpGZaetcp4JEeTlgz0rwU5d7fK0zE0J0=;
 b=D825T8AwkR1NUYnMatzV27a2wu3WmDVVkDXsNBOwTLZ4jRnRqtqIGDSz4bvJN96RzsqddXgw24rdhTpMCU3pDgvi3UZBsSb+Ml1gnS2CJjxkBY+9Ogq/XEU7FkciyXqnqM7slnuH2VooU7fCd1wY0Lj5RH44a857N3TwVP0T5A5Xjg0oF3eb2oFFlJksesQTtZtwe5iPCjL//NzVJnm57fOxsE62C2jtXnMTZInBTuyiAAC43UnAgqfClHPXkbpPbvfDjl+gIkveVNgG3HzSz7FMhdCjU1e+fC4iVZX4sMZ08vGlCrI2y73AhPrlMrNw++S+p9hhTJ5xOdlpW8GTMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5wUbaAZdJFlpGZaetcp4JEeTlgz0rwU5d7fK0zE0J0=;
 b=OdQnxfPDHynLExgdGMrdpouZSpXX6qq2nkOmmcCMo7Fk0plz4BETvUvP7COehKxltFrzVz9uS/Yn9i3yrcKYvo82g0GJkO2LxUttimM6kCtWHyidvzjL3dgB6/Aw17gdqINGRg+UvwwmSrNGCufOLXowzJVbQw0b0ZtO4MOeESY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by HE1PR0401MB2649.eurprd04.prod.outlook.com (2603:10a6:3:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 16:43:54 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:43:54 +0000
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
Subject: [PATCH v5 03/14] dt-bindings: pinctrl: imx: Add fsl,scu-iomux yaml file
Date:   Thu, 16 Jun 2022 19:42:52 +0300
Message-Id: <20220616164303.790379-4-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: baaebe14-7756-4866-d885-08da4fb76660
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2649:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0401MB264938250E37D599D34F6E2792AC9@HE1PR0401MB2649.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Bd+VeWuCcwR41AqXNQJB/B7H28eDmuvM6z7fGGsNsGMHJuhw6OGNTJcZONIf5bBhdJIEKqXWv7rChLSpJYVvIcgxRGdO/ycGYhAtmG0KD+P4HLDm7VWVmUCIifQa+9cHjfm+Nd28iiOtyK80IpEsFXyNcALTRKpyODKKlovC9kkrvKnZ2cfpaqzokl2UoL4vxHHh2h4FcwWfvcrcQuAXI5ua+CWMt9rJnhPBW0I5hvkBztlVqY9DD83WoXQtranlN+V6+f8E7wPNjXi+7RGo1SmJwVRvnJCAt/jd2jPNWqVxB7IoYv8kpq00FOsSm0rhTGt89a5RwMgQMY+1lNH7AopGoW6ORtNpUIA2krnSCWFPx19XSBcvs+O5mX5K3x1U4Ov3f4L7WKShkM4KtiAU/lVgpi2Q5AcC2JWTircuL4yvaucwALatZW/mPW+wCv7d3uVAS+no2XqrijPULpcdQ/6wCw/HgLmEK1XPA2kO3FuJmucS3KPAvwOxeW/ub7VD9iZgscQo8UEyp44VYBn+N2T75Y49al15uDs0qX6fZzqT3gNkWqJc/CTzVKlIyLKrup8gdKU/6H2+fN7aolJMZhCUmbhRECscgwlQKjh7wMJNoIJTolZ3OhAVm/cJbA1A63EerVEe4hKrMeA+ogpe3UoM+P6vw++1HkfJsAdgRHmPDF7W1MMCdtFb5qH8Aa1ZICdVIRUzJA7fiO9AnzfAKj3EdfUaCtNccDTfbxfqZWI3XBysWBsX7Nl/+Jp1yJqPWQdUj9r8/DNhbIrIsTyFMwKLb8xgEkPsjA8ozPojDl1ZoPGZaowRqGKJf7e+RwjlXYrt3I0mK9oACucMk337u0Yvaa29D2Y0aBtfNi9eB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(86362001)(186003)(38100700002)(5660300002)(2616005)(26005)(7416002)(6512007)(66556008)(7406005)(2906002)(83380400001)(66946007)(38350700002)(316002)(110136005)(52116002)(6506007)(8676002)(508600001)(44832011)(4326008)(966005)(36756003)(6486002)(66476007)(8936002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ls8eIPuFF/YswaPQHD3DqxK0MHhQBvKJuFzv1EFiWJ4HXN+KM/pdjpEHzj?=
 =?iso-8859-1?Q?kWE9ZXBVsV2V1SYd7GPB1C9/OPRzpr6gA3Q7tX646STXb7MFP1Fvj1UZFB?=
 =?iso-8859-1?Q?YLcokOSi2fdIP9SIjBKAKAdzxTpeH0cWuNpurSXnm6XSWBe7Ei2E9pAORw?=
 =?iso-8859-1?Q?gZuXeAXHUlguQ5q54/7ncaaA6CYyj3cu65PvbaR62VSXotbmRvy4pdcU++?=
 =?iso-8859-1?Q?Znz+W7U2xJCw9kHbVpjzLWPleSvv6lLswv6G8ufh6mhexpOWZSVEQdySEK?=
 =?iso-8859-1?Q?KwTwiwZhbNRRheivLHz4X+yrxSY8iAKlJI7rbNkYTZq+2cvw5wO9097g7F?=
 =?iso-8859-1?Q?SXObKQsSi5xbJ435bI/TtwC9uP/uXL+SbpWE4slsUF1YLv1dgSzLDlK58Y?=
 =?iso-8859-1?Q?Gxjun5nXzn4voQDV0Ef5wgPzCfek+VDu3A7OIU/yZbFs2Cgx6c0IaqI5Sm?=
 =?iso-8859-1?Q?MCeQqf5bVWz1A/5LVmEr1sJzNkz5b7d6Kp5de4SlqxHtSF5LhUsUKilgvx?=
 =?iso-8859-1?Q?hnuZyZPOCrySMSrcQHtTGiL9zHVGco8F5GmGyzdtSG/3woucTO7xprDE5d?=
 =?iso-8859-1?Q?d5247eMHcifpK4lDKSvLZxr+sRoUTX/zNEHETvHJxM5wIRR9XeR/o13j62?=
 =?iso-8859-1?Q?6rovqeqFnVSccin8nZPp1gSjZMeU6wCF+rPqQerToSsSavjbFCcvv/pVWD?=
 =?iso-8859-1?Q?+boLH8T95h2Q0rltzwNjLeJauwM9wdJlmY+gCOL0jKg01QGheRwqojvyht?=
 =?iso-8859-1?Q?QZI4efqagwf1lg6KAhob3OXP9L04UHF0274DbGfTC3oE9HSIrzBtl33JGk?=
 =?iso-8859-1?Q?LHKZzwSj8OSf3E/Rjenm6js+qVwa/LQj8Rsh9HB9L3JNFJIzvlmRpsg3uT?=
 =?iso-8859-1?Q?UJrEOB45iQJmSXP4Hg+pH4JWAswJ5U1YuynsMdPfYrVvbtEG2oexgfUj3d?=
 =?iso-8859-1?Q?4vDhNha/VndEkMVK4eJAI8tWMfA7qZs+JKSgFkv2Co4H6S1/AZ2MtxVDbe?=
 =?iso-8859-1?Q?Vp2BZq09pqkPBtJVfI8KG+HM5eI/KcyYTNaCKoIReb4TFrnxMVUZhVlD0b?=
 =?iso-8859-1?Q?ztQlJVYTvzbNARBb9hUzuYsB12QzAwPo6AduliMlsKAaKg/WH6be3kjNYT?=
 =?iso-8859-1?Q?E5ZkXuktE9Q4gBGvap/FF5//ECyflN1gEeKLoNtaD8Z4SPrzOdwfa2d1wx?=
 =?iso-8859-1?Q?5UtkkdyTp8E2H7FhjaD/mAEjaEpaHBrVeNHzWyulJnq1+ZeqMH3goM48Vu?=
 =?iso-8859-1?Q?tNvxQ2KUdk0aKH/ItlzN1/GZZFB9g+GSFwmWtdN4JuGP5RX5ervBQzLP8p?=
 =?iso-8859-1?Q?AdrI7xnFrq/xqaDF98vyEqfO2sOOn8LJv2ktix3nusZX1SspRWDhu8QFVK?=
 =?iso-8859-1?Q?8bvw8eRxQjcBet9ljly/4vJRM6cm9tvJOxsb2FVealmem7deNA9JQSl2XD?=
 =?iso-8859-1?Q?+9vuFPle7cGxLioBxG+hJ+ZlFYRq55Ez1SkU+J6i/Z3IiEIWF1QD9DEAw0?=
 =?iso-8859-1?Q?9XvxzfTnydTcCm7Mm13IGIRe07Y6pGg6fcD/FZUYTF4osgOlMVc/lUn8RZ?=
 =?iso-8859-1?Q?OTtM9tNgKxt0zjFamgDUFF5ZBAtmW6eGUWbPM80PnKVZ5f2H4AOOT75DLs?=
 =?iso-8859-1?Q?+Y7Hwg/JCQaq6Jl0OkSWzKzFcAbAOfoGzfGoSIuS+ukpz5X5JQSo0xUwer?=
 =?iso-8859-1?Q?V7z/4Vf3ZNPMPAtctj7kcuagkzKuFKVHihDaJOyPd6I/TU5LM656IqSGVv?=
 =?iso-8859-1?Q?6xz+fzF4fwLn+gF5319jWC+c9COHyI+8pA4fPzam1jhWrDRFbm1/mlG2+c?=
 =?iso-8859-1?Q?BI1W6Bkykg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baaebe14-7756-4866-d885-08da4fb76660
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:43:54.3453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9oIL4BIxFt1SqNKOzb9yYu9SY6OF+4+S9JHbM5clQUuiZN9tdEpbFp4Y63VtlQ7INahjpfNAw1rI/VmXZiUjw==
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
separately the 'iomux/pinctrl' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/pinctrl/fsl,scu-pinctrl.yaml     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
new file mode 100644
index 000000000000..7a08c60da66f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/fsl,scu-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Pinctrl bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  This binding uses the i.MX common pinctrl binding.
+  (Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt)
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8qm-iomuxc
+          - fsl,imx8qxp-iomuxc
+          - fsl,imx8dxl-iomuxc
+
+patternProperties:
+  "grp$":
+    type: object
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/pinctrl/pads-imx8qxp.h>
+
+    pinctrl {
+             compatible = "fsl,imx8qxp-iomuxc";
+
+             pinctrl_lpuart0: lpuart0grp {
+                    fsl,pins = <
+                            IMX8QXP_UART0_RX_ADMA_UART0_RX   0x06000020
+                            IMX8QXP_UART0_TX_ADMA_UART0_TX   0x06000020
+                    >;
+             };
+    };
-- 
2.25.1

