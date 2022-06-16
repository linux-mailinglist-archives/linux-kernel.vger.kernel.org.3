Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8CD54E7E0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378171AbiFPQpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377303AbiFPQoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:44:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005F029C85;
        Thu, 16 Jun 2022 09:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzK82Po8qSaOooiK7dZx3K5oS6vDusOFP0cuezLEMeoEiAJ3P2B0pJPLu5zWMKa8OkzjWWoniKNF0JxLvVq/NikIK275rgUhcFkzqX09NkpbS92TdJ8/YHhD0Ci45iAFHdDz6pzsBQA++h/VwRwoumzJ5xhL6K3Zk/YdydRnWLYLBiBi36Q+bT4Ginxv1lwDo2JLrYfN08UWi12gMfgfJZEv9g9jX2x2JZtDCM9IRdJhqzTeGF+QQCFNnX/rGSagamuMCSzjGXJYTzHWrUGgznUjxAPCwbeRVu+oMcvrx0WH2iFDZsRUX1FROp6+LNeXY/UBtp+G5QXS+4EupiS8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkWKDzziamddDIP8L+D/ICg11Au2y/UfNy16cNmToL4=;
 b=SIEslYyyyfTw+E5hWYkDPM7WFPNyXJfjzDHxCzZSfIOfeJtzl2IIwSbD9u5oN1LiDfOP3TX7Eq4uR2+RWX/gT/q9g0edX4rXuTsAZ7HjDX67MblMq1LTDCfTh/050S+MsSk8U2eujoWfSiwbuoMhcVvG69xPvs0dDFTH5rj3DrS7JKQAXznFhwNtlGc+SAL3gV4wm40Y91oDvuYzbPQGYHjtYHutWlcGgSVwB+ln6MEHHRgSO+3S5Il3PjDadhL0dqzKxWq3sTt/wwi6zweFYfSZXjJbOthoOiW0bPTTtxH1lGCKvKTnV4x+uiWi5QM7Q2y8c8ffMb4GeYS6TT/lRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkWKDzziamddDIP8L+D/ICg11Au2y/UfNy16cNmToL4=;
 b=l/iUDhTq12guwLXrBrAy0mmweV3liSZ3QacLLQzC004RVs+kejLkIHdg1MWmeMHyLno6205h44OnEY90po2EKatACoW4BOS2w+YQvm7dIhmgvNUWUzTlP7qcLmAqYcI59nbFDJfwugftAhQrg07o95sMilmQGFnnU25eAndEobA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by HE1PR0401MB2649.eurprd04.prod.outlook.com (2603:10a6:3:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 16:44:17 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:44:17 +0000
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
Subject: [PATCH v5 11/14] arm64: dts: freescale: imx8: Fix power controller name
Date:   Thu, 16 Jun 2022 19:43:00 +0300
Message-Id: <20220616164303.790379-12-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa8566f3-33f9-4745-45e4-08da4fb773fe
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2649:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0401MB264967D887F7F7B8A511F63C92AC9@HE1PR0401MB2649.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74XOB5Z0RwycQJ2wiJ62MUIPEUk9z1KJLzJuwAqN6XokgFzsWhngL1pDfZ0TRyv95dIH/R9DqczVRSVs/wENhO9rib3eNumdd4ZrE8Gxo8NUTX1zd6Bgz2m9+gXAhNIdeRqMcJL0ZR8C1XzKrSGk7UVPDlwQlWQ+8oNW8GLj5OCoS6LJUuP1ZVyyn73gXr7cMWbcMuEZW46aYypK4Dv3GSUmmzwEoP2WAgLQY2yE0QjkMAje5Zk77vva6goYMgjY1Zs/SSOPdGvakkcAjkRdcTLmHz9dw7eZa+l5tMgX+n1xr0LCSKr5E/UL8HYXtmdutcG4T14V3PMtFeCVUMnS4ojK9mdw5KQy6A+Jvm1QxpLyJ/ELRdxzATuWfMjW3i6iTumKT/8+6fOJFjqLk4qV5PR6RvGHOewBlN9O/T5QFa+xdV0UD7UCRwgpwHUJNJ8lWi6zZ8g2a0fhmoawibby+LRkiFqQJzMFUzsq5UD7pGu/PIEEI1XfxYB3sE3vp1lnaUF3TkVShcL5lRBX4I/jJdCqeqCH+6WrAJzOe6z0HATXU7DXpPOTadCfItIWGQfYgjtTYESzUxFUaFqrixh/uPTNIC8DT+/j4B/pFHoEE0rFADBKhiwZ5Gd7cXPqLTCJrZhMfTiUZkipDzbmrLsoB4W10jrcv5SjuAreCtGKI2PD6v/SW3aeutTvuEr6zHNv3RYTYUL899l6kR+6KcYaTy+Ke4SNiLtU351UEdi4DUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(86362001)(186003)(38100700002)(6666004)(5660300002)(2616005)(26005)(7416002)(6512007)(66556008)(7406005)(2906002)(83380400001)(66946007)(38350700002)(316002)(110136005)(52116002)(6506007)(8676002)(508600001)(44832011)(4326008)(36756003)(6486002)(66476007)(8936002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?C33/nuxQ2iYkHoXC2BiwAjWF5+A/gq4FrNKk4w/KbA8j/tg9TQEkct6CjN?=
 =?iso-8859-1?Q?3d+BIVrzwfsS/7cMXx6V6lhHEloswXK0f/QmjlC/psMx81NSpMGyNTmPwt?=
 =?iso-8859-1?Q?eqTTKQ2IR6OtepqlZzLVUN9t8pBV6HxJFi9PCO42Hv/INaRTYUanvj/Akt?=
 =?iso-8859-1?Q?RLLB8KW8DAJL287xJpOtqRpVFCFtsoXNe1HB9li8O9TV3GVKbw1CDVq/Fk?=
 =?iso-8859-1?Q?mAW/4q4u4eO8wqsGzF1mxYrtA85+UvcqZ6/OyTC56E+vUFjQgEY1PXumPA?=
 =?iso-8859-1?Q?/Ll5WAvzFE3Oagtav77vjlAd6ZkSbjhcAQwjZ9snpZHoFFBqBugnFKw3yk?=
 =?iso-8859-1?Q?RVY0801hCqaVS6z0Z7s0aIVUxLRl7hSHILHDxaExc9JpdTGoEcAPNWy8Xw?=
 =?iso-8859-1?Q?m8mKGkj0HJh5TPYygT7oC1v2+0Ij+g1D6bVYDXQuiU235pEQdqgYI3oK2Z?=
 =?iso-8859-1?Q?6HIHCJvF4R7aug0z8xP/M07pNSKsWIG6xnIjD9amBBFizyiZ20mqpimPtl?=
 =?iso-8859-1?Q?MyZgmxikt5PMLfzb+Csvz/uEc/fxpCHvHirVfwPDBPr3X6CBapjaq2MT0Y?=
 =?iso-8859-1?Q?ZVI41jkNOJ5LlYjm6/aSgEkEhBgQQ07AByRi/oleayk9/aB0RKGcopSrHC?=
 =?iso-8859-1?Q?xTHiht74JYIliSvgXp3FpRAMKuhDkjf2z/uKIpmBkMPsINA4W6TZiwxld/?=
 =?iso-8859-1?Q?Pjm2uxt6AxdM0kD0oAprJZp2W3gD4h3PD9Ffrk1hbk16QyYg2j/UV3idNa?=
 =?iso-8859-1?Q?VIt2vTW5tZ+leaPHz8IPu0W8/p8PKUYnKteBlrhauw1XfI2LGEY6ITEyht?=
 =?iso-8859-1?Q?/1A/Hq5RggWJl8b4gG36jPyvtjFHqrFaz3QtYr67YeVb0+bsydfDz/C+Vs?=
 =?iso-8859-1?Q?8K4H26rgggoJMesdm+riNs99gd15trKAV5t/ewx7c0VRY4T+czoAJMxaFx?=
 =?iso-8859-1?Q?AJE6Ip0+JYy/gzN5mbNmpjJT0Et/aPhB9fypvg/SREPUzlx2z+ISJowuHN?=
 =?iso-8859-1?Q?2ZPHhXb9y5YnzdTvdqV6FRpfr/rIiQ4TqO1jdiusnM4yQZl7Py3W2DYaok?=
 =?iso-8859-1?Q?n5NRRQ2C5QrJeELuYWr3VuCw/ZcUd+HvKLfCf6rbID7m0Psrt55hV1bs59?=
 =?iso-8859-1?Q?mMt1C4bLkNLbzlseCD8o1WDQI6dyddeH3Os6HV/JroEDMXZ4AISEBs26LB?=
 =?iso-8859-1?Q?kJSnI2ZsHKkDiy2Y1Uz37Gs5E/YKQV+Bt+BA08J5cYb5sSpNcO3V9qFxEL?=
 =?iso-8859-1?Q?wWjRBdvzKj5A5KMiUXIls34qTPk1rhCBazR2NNLnk9iPZYzNy0K7oFdwim?=
 =?iso-8859-1?Q?ubtZD/01dF/Umrs3CcHNJ5PohZlO1ywSaj5omjo2+eocMotsisOA0jEI6G?=
 =?iso-8859-1?Q?JB6Ghg03SYuimZr0CyCoDSrNBo87yF0MoNiDkRjzW0akWelw7kUBWFclkd?=
 =?iso-8859-1?Q?IHlFpYRhXfWaVRcZMRYv17se/XbeQBB5QII78wTlodhmiXx1v3yNF2+4m5?=
 =?iso-8859-1?Q?D3kIaWh3sGL2B4x5VdF63ZfO/DKMVmV2O1XRICWKSYm/MqJn6RQLlBzsbH?=
 =?iso-8859-1?Q?RaNLXoQK1Hlp+RBY+L6h6ZCjWQObAAjWXWE5Qt4wD4CREJGRejUQjaDdek?=
 =?iso-8859-1?Q?4wMIx0cmVfBsubrtb4f6hMrqbS897nHWYU3zms+lmOZ2r1mhErE5vffXa8?=
 =?iso-8859-1?Q?6Lo7ptu8eabmxRoMZfoGjgXsw9oNZuJl+YP/s85e0IyhpWlVuKm6c51jDn?=
 =?iso-8859-1?Q?uPqw9YpjZHekyj9nBNhy71qhoAevvJ9BlgiEaHPD5ydt5YROkr+0482Z/M?=
 =?iso-8859-1?Q?4Z9+jeo06w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8566f3-33f9-4745-45e4-08da4fb773fe
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:44:17.1874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWlA93bsttVwNldx7UhNtqdWOe4SGRSDbgSigsM1bxdJQdMRbWVna4i05TyldX15SmdpsQ1b18y1IWNFtD2V8w==
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

The proper name is power-controller, not imx8qx-pd.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 4f767012f1f5..5ad1c9a5933c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -190,7 +190,7 @@ scu {
 			  &lsio_mu1 1 0
 			  &lsio_mu1 3 3>;
 
-		pd: imx8qx-pd {
+		pd: power-controller {
 			compatible = "fsl,imx8qm-scu-pd", "fsl,scu-pd";
 			#power-domain-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 483996a1f2d5..542bc47509ca 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -210,7 +210,7 @@ scu {
 			  &lsio_mu1 1 0
 			  &lsio_mu1 3 3>;
 
-		pd: imx8qx-pd {
+		pd: power-controller {
 			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
 			#power-domain-cells = <1>;
 		};
-- 
2.25.1

