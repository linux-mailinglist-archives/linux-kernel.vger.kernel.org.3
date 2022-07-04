Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD1A565B52
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiGDQSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiGDQRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:17:41 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1266120BD;
        Mon,  4 Jul 2022 09:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+9GrHSKcgw4xbAMd3R+TJg3hCH0v+hU2PyeIKV8s1PNt/Ww+6OpPbdrDkSW7nTc1oHFEo9R6w2dFL4ZzYSfXZBWAhCFJiaxIejv7fWreM837CjO4NBh9pfptb5yKAuNp1i0S0PAd0p7COiO7nsb1VeQAP5k8bGbn8Kg8oHM4dW45M7X83LuO4r1OhYNjGm7p/wZ5+Wl0JWm3mh8OTDzHA9mJqe/NxNYg8kfq/Dy7/Z+pCKpncWe64W//lBDEYBjJrcM3UpcnXeqpSXegXx/NrQTh1scBNsT7ofjv2Xj01BUSbYxzP2z44CWdXKn4XzUBuEqc2ojzM0DRN54m/1Pqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6Qz8bG7EFeGQxxcGEl3M3BGepTij70D5bkS9ZS3Hks=;
 b=HH7UrWLchPCAJqS/qJp78aNTebDEmQpGCYyUbUCJqLHilnbd0dP0rSqCrAmpZyVHphTZDcEdcal8zUImeDtXb9DcyHNcHnpPHfCwPVbNwGuUC5sUdFd7UZyxLTrIFaBt7HhaKEqFQ8lAMI8P78O7Ay6T0nJ+/F05dUYbZqvXtzQzH1+9EmPscQm7s5657FOpbZyig8QVEtzCMTL6fQlI0ATp2OFZi49w4i+YDRijo8f0g6ArD2hPNQfAmVgq64gRwThI8SZhrqWkzOhq4vwcWiWmZVJlyI5m2WHL+cBLSP8Jz3shGneG1gG68jlOy0GEzsXZe/nbOk4I6qJW41kV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6Qz8bG7EFeGQxxcGEl3M3BGepTij70D5bkS9ZS3Hks=;
 b=Z/bh96meWIT+L4VJP+pRzevYqW+oeoNgyFs4i82CjhJZ+qff0167anoBWPddCf7bEfkpw8qVCcQScPbScfVn9TrTwns1/UTilLoVNPDgn7naC9UGWY+XJ0ugIawh+f7Plxpklzl3G5xu+774gEcHLF+ne97U+ICskYEtOeP40tY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM6PR04MB6293.eurprd04.prod.outlook.com (2603:10a6:20b:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:17:05 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:17:05 +0000
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
        Peng Fan <peng.fan@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v7 15/15] arm64: dts: freescale: imx8qxp: Fix the keys node name
Date:   Mon,  4 Jul 2022 19:15:41 +0300
Message-Id: <20220704161541.943696-16-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
References: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::21) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1d0c764-cbd1-4ea7-ca90-08da5dd8a2b3
X-MS-TrafficTypeDiagnostic: AM6PR04MB6293:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VR/LRtHsg8MAnOc5oi3qI0aej6cb8fPJSgG96lkvWSdCAqjwZ6ehIcvX7X+X5GVPuaNF0MvuSpp/6PFJgSQ//08Ei8su1Hyfx98GNemrpdSrdW74v2Qj8Zmpumnmq5rApebdeo6QprCuY+5yXYfRttk13fWs5+SmLYhxC1cQd4TNO57kF1MLb2YCuKWirlOuXCor3A7A2L1ZpLP+77SGRy8G69wCLA+FEoideHuncEcHDozvtDjtCpJzD8p50WGs8lrq0PtMNK5voZyZeWLM9RaQ6BllKnLclI+r3NmNZEM14lH8TcEHPsfxsBJ9sXO0a0Dcc0RBYdjwadT4AxQHFh3m3A+QSGwZLU/j/rAEayyJyUubjV937HfPIFTAYQ3v0HLXTfk6finKw4FUqXPHRr4Fnuh+rQhJ7mEpXt6NVRVxsQz9CzwXASjhTG+cbZ1qeup0EB77lzFbNQ1M4wis1J1Rhhg/RhZJOpqyDPe3rDPnLYg2XB1znNb2Iy3bjIn3Qnz3ve5TluyyHUdznu1vYmX/Ew7T8y4eIhsLfYwh1LLcbkalLcjMStnaIUxGvuo1S84AqATNyfQjGFO664OhpMq7zbcFqllhzds7HMOmRcV4qYqhmtKgqhHHIeOIuR6HhX4TyvHR25FBKNdlpVPDJjp+ZkXa8IToG3Cx71AT6jdmBNaJzDuHKZhdIJ+BdB9REupR3xWT1KO5CXLsX0u0hSef00ny+NSQUO9VWA9fE97l9RiIjr5v3H9Lb2g0A2loeSW7t373u9Q4wZcdxU3lx8eOAzqEsqbzMN+Tm4WlCoGgwEj1QwMWsXI+/QUe0JcwvD9pJc/cp91HBn7fOkD2YBRAezlot64lKGNBo/WOWTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(2616005)(186003)(1076003)(38100700002)(38350700002)(54906003)(110136005)(66476007)(66946007)(8676002)(4326008)(83380400001)(66556008)(316002)(86362001)(5660300002)(6512007)(4744005)(7416002)(7406005)(6486002)(478600001)(8936002)(26005)(6666004)(6506007)(41300700001)(2906002)(921005)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VA2gpVs/m6Jtc+cXSY8RJrEVlRcee96PSEMD9nLTlhEunm8r0kJP1llUPW?=
 =?iso-8859-1?Q?0gMcwQjVEwBoIjfx6d6CQG0f2B+NKficc/NkcY4qIzVZucz8XHD35v6cOa?=
 =?iso-8859-1?Q?yqlBFjbKDo1Dzwq5/vJmtIF+XPK8TGjxbkLZKtu1gc7t+eNNRyg1uhG/Zv?=
 =?iso-8859-1?Q?nV5i/6zVWXOCTvlGV45ewCephlX3c9VN47npYHvBZne2NqSraHuCeS3eR+?=
 =?iso-8859-1?Q?sn8Cx7bMYIh1zIh8ou4xhXvwvcKDS94VeHBobaf4paHvLlOoUlDL+ruW7c?=
 =?iso-8859-1?Q?881nQ5qLV7imKFQt7ZNy/pskYSGujAbkA+TrjPiNmPEhb4pGx1lI/TfOqk?=
 =?iso-8859-1?Q?/tkS7O0O/giX0ips4LFs3igvyKJzQSbqzUtCNCN/k48xn+j/WWKAgh8hSH?=
 =?iso-8859-1?Q?+YCmbygrCx5/lnsCIEGNkx6Gkiw6XE7iYO9k8v1m8WTySHT/p33VXTPicV?=
 =?iso-8859-1?Q?FVhb+/6jRIUJNeAABK8GXTaiRAQhh/x9IHsMOc+Ry6K5Thn0ci813O4Boj?=
 =?iso-8859-1?Q?BTa0CThq1vOzh0lQDpawd8vyvl4k6C6qMz6YMRyujRcRRlj/GNL+mPBjOd?=
 =?iso-8859-1?Q?D5BgRxQ1iHy7tynm1cdeSas/vObMsuqTNAyyyYNZByWJ1D7QHL0ZtzuoYk?=
 =?iso-8859-1?Q?rQIkov2dpJqHtqDcyif9YK/ox2K/TTEOm0OH8+O5lTs4TlSylV7zD3TRy8?=
 =?iso-8859-1?Q?98YYImxL66qum+l1QpjW25utEDrwi7bdJvv+PBupNKTdmNxI4Dz86YfOBw?=
 =?iso-8859-1?Q?3QX0Rdfly18jn5kl79g6EHcdnPTrFNXAeHXiEKeGKfhTS/fawGP9pk3Op6?=
 =?iso-8859-1?Q?jYHauYyitf5/8xo/nDSutC1JTxDzOKBDKm0ZsAU2stsaRlGZ8NBxz2hd0d?=
 =?iso-8859-1?Q?iefvx+/Ptmk4zXarTJkpDsWlhz/Lx4Y05ZFL/lIn5xytgcl6Z4a9IW01pR?=
 =?iso-8859-1?Q?dJTjMGus1VPHwhJye+OXbgFsdJVdO+ornhTVAB0lnNjVd1XWd7wqPVVAlg?=
 =?iso-8859-1?Q?G+4lJYIYJ5hksnYfutqkqZcgdm9gUiKTY0eT5+/yXlYdHjBhN2BjwbzdHd?=
 =?iso-8859-1?Q?Bot7WmxcDYBMkvbKn8ZLvamdqjyHNINdaw55/yNZbyHBE0yJxZd1Ln+hDS?=
 =?iso-8859-1?Q?afA8cAJXwqHE8CcR2RJ6/G96ozkPtWbaw4KmYeiwsdTc1s5OEr3ethtbrH?=
 =?iso-8859-1?Q?d6lHW+oHHNB4JMZMA2kDkdJusxoO/N5eMUkNaQEmHU01AhydPPo9tX5ZnF?=
 =?iso-8859-1?Q?Eyn8gWOY0SBQKHj6SdBXhHfmtqac8WGfvKpv89dWOqSrdmJur/4q4RGD65?=
 =?iso-8859-1?Q?pElR5p1GZxb09EVDtLVfhYMhsu8vNGU6CaMwLpyEezJhzAKlq1lwjSHoeU?=
 =?iso-8859-1?Q?K1N5sVUM5L+WOYUKCbnlLQETyXfkQqOGcqSxxFjw70t6X8t2OIk+BXXESa?=
 =?iso-8859-1?Q?kaizfFTJONTgytYJe3VpKLqbn0QN9fiXxu0Ufa//5kdzHdGklcwP9WIGKG?=
 =?iso-8859-1?Q?jDy45VdA/WGxFNYNPMXNleeLrBvP0fCbx2xiibcRp/vuu+CAz1dmrWoBXX?=
 =?iso-8859-1?Q?Ug4oJ95YF5m4oYHVoKGRYFCHhxhdgwGoissEx7weIJH/0jSSBSxSsj8Oms?=
 =?iso-8859-1?Q?ApPV4/lCtCZXjlYUqBLfacbYuNnDAn+/oP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d0c764-cbd1-4ea7-ca90-08da5dd8a2b3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:17:05.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8t8CXCsGeuH8xeHb4nr4Tc5iqmbeHWzuA6/lTSuv6BFyjzXx3IWa/1oMQnfnkZ/abhL3MvoPjLRK74GrkXjP9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6293
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

The proper name is 'keys', not 'scu-keys'.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index ddcc0131b861..f4ea18bb95ab 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -230,7 +230,7 @@ ocotp: ocotp {
 			#size-cells = <1>;
 		};
 
-		scu_key: scu-key {
+		scu_key: keys {
 			compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
 			linux,keycodes = <KEY_POWER>;
 			status = "disabled";
-- 
2.25.1

