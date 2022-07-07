Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1D856A2B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbiGGMvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiGGMv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:51:29 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BAB2B639;
        Thu,  7 Jul 2022 05:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/e4TZK7vmolJVCO+HLtZOS6G6vvWL1LfoFFEmruBj1AlvNZryXQWOr6B6OqN6lasnuh5W+U0tIkL3DNqYWPnsZmz4jMOxunBpDvWF+8eJwiJhtpZrVWNMVSVnaDFiP9r5dItbBHAm8J8iIkcHx8v3u6ybgB2gDO2N/mBPun2iSPmhK8/GZFLTf6d1c4pbwgjX/J37wDgXsTVVpM1zX9L8yuI05a9uUMvkD7JgIjgWmbVut3OFwpnI58toZuSnjr31vzM4a6zkjk8/3QdqW68hZzqj740vH7gEnB5sIcUmHk0QFW9e3UtFQpbFoWGNV4Kt2IiCkCzertnqjkL5TxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI4oejGXuCy2Y2FQ+M8kieCzFeO0K5hroMLoeq7AZ0c=;
 b=FfqiIvlwwb8lLXbltUYOqZPQFg3mdmwiYCxAVqAJF6VaVgpnDAc0aTus1LhKzw5/iCoGQ1vIQrBnPr/1WztMbS6+DQGZB2Jubx7l/H4L+aQ9opwLXoo+ppzMUSS73rHou+TjtmKnolLr08c/Rwb/msHgNXRLIp6znIr0RBX3eWAaA59EOnsxlLmh0ZJZqqcQvsizFEOPtK0PhCGu6lcUKWJjvzOAbJ3bw73Vw6HszMFetlmkVcOkZqCc1yPOSF7+mVA4pvDXVCDZv2bjsuTPC1AOSdwgUMDQz+Tz5SYTnf71QXyxsZlLxyZtxjODaWJY4vVuFaiAW1SVYZ03x3Ncgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI4oejGXuCy2Y2FQ+M8kieCzFeO0K5hroMLoeq7AZ0c=;
 b=XFFDq4fQNhax5mB5mTepDK4ZTA+20qdvw3lO3cgV0HkJ/vSB23bQkK2iZK0XeeX5/FD/FLNsoCoiIsVH5l52b0/a7bfnlxeV+3NZbVK6syhckQJZIp1aZrKOeTkIcXspN2kqnJ6EdoSzdPKtfvjwmq0T33Xey9OlRXVL3DgxxIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Thu, 7 Jul
 2022 12:51:25 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:51:25 +0000
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
Subject: [PATCH v8 11/15] arm64: dts: freescale: imx8: Fix power controller name
Date:   Thu,  7 Jul 2022 15:50:18 +0300
Message-Id: <20220707125022.1156498-12-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fc298198-6b6b-4aeb-45b9-08da601766ee
X-MS-TrafficTypeDiagnostic: DU0PR04MB9276:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrncK5rDy0BCSkZ0iP1EE+tzYLhroxg2dwgP9BBdowGQoN/LdQL7gOgPy5QRa3hyYptuQ0YWknig8pVxi+9fHA/HZZN4LuJ+MJ0UBJsf4GXw4h6l8d9NdIkF+Zo/OdLlFLA10+PXcWrWwvgJ8VZ15pWJhk75XSsihai6Fx91m40qpBxa5o82gBjBL2qcXdEk3pp7stKsUEluZJ1rAzwcuyjv4EvKaL3aTr3AC4flmvLm3I3EsjmYfrY6kUk90eeKtYlbsfdF1vCahJWU/Be7RdeaK8og5/TbD6oCC4UfCZpyXAV8VTHz1CaP2p+kzyRFpptzYuNMxaHfvEZPcpKbhZlcNwQMh7YQD1jt7yJUJh1B6GxIqoQrxRxD/san6FZE/NBVzoiqzLrnHLA1Ihe2U64xlnkDHwj+Cv8uh9j6wkh65JGKyNF4wUtD50hQBZ2rYTzCS3JwWnO78pD6RZJ+Y8i9K/4spWxEsyjRcLdYoUogoNI6GdWvzgZjJljldL37t9wAvYfNNIBOht7ShpkDyLfs/39joNLxvqBROYeI4XgSre3aFptXJuIYWajZVZK4orGSvNbzRiI3fdnHYKLrO9uvQsNhqbUvcaDoyNrnj1Ly92SkooJGUox+LbY4a3T+Z+8SyjkbB7a53vm6RNk4KKDrRR6K14N/8zy34woi6q1w/f1Ai9Pf0bs3qu3ENInuv+BVDjkkFkZaciRdux16N5vXrVoja335DZvWO4bMdZkL4b5mk8tcbrmp3v2QxngycC9MQ+m8se0ZBO+uNjPeBR282rgcujjIN3QCW/jnwKLZZNCOOvLIgadyy4p3ZgtL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(921005)(5660300002)(7406005)(7416002)(8936002)(8676002)(66476007)(66946007)(83380400001)(6512007)(86362001)(316002)(26005)(2616005)(4326008)(186003)(1076003)(38350700002)(6666004)(478600001)(6486002)(38100700002)(52116002)(66556008)(6506007)(110136005)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9Bm66eVfKo+TVUsrKVjyfpRF8Oi4bL7YwwM0sBxGOSkze9/coYjXgB06Kv?=
 =?iso-8859-1?Q?Gi3+HVqOY+76oBTwseo0yh0xTVwvxFLZCAhLufBRIpd2BCpsVBDQ02F3af?=
 =?iso-8859-1?Q?UCFO2VWSXtZ5QG0fjfp76P7Pun9S73FHB6ENQwUBuvIq3O/VUQqxcOXRQB?=
 =?iso-8859-1?Q?4QNXQ1N5Jlg85fwDNun8onzNHbYGCVSZOAWVnFiltTSzlYhyEQ0cadCHtE?=
 =?iso-8859-1?Q?Pqhj0kl8VKv1HGCVjuxI8VB9gGaZ+2vyO75JYfKEQMnb8jlszDUiWwvwID?=
 =?iso-8859-1?Q?lsYKIngu8vYoy8jHd7RqhNnEEa6a+gsikgHUj5sadcvANti8raff11CIQk?=
 =?iso-8859-1?Q?3gfk8ojKELpK+1dId8HGtxjXG/2V70uNyQrwDLatk5LMmhDvkjxPvea8eM?=
 =?iso-8859-1?Q?pPH/aMkr7eLRv5fMXVoI7sf4izNgc8DTdit8YJxKLCEDlAPxnfgUX/TYB0?=
 =?iso-8859-1?Q?ecRM37M2lxnECiiy+aYELfn9K1MwzWXJ+6UXQHC7WIAI23h27r0ARXkA3L?=
 =?iso-8859-1?Q?iY7KA9WsBQi64rl6tiRXTlYv2On5WHoL0J3oqJB9Z3Gxax68Iw/cLm2j6v?=
 =?iso-8859-1?Q?FZweybUKWnmX9vp8sfCy2mX5uRdZhSYKQaWO5Iq6OvRd0dLAgSXT6J14z9?=
 =?iso-8859-1?Q?vJMWQTwPsEm19hezOsWNz5s0qUXH+zf6X8u5jUNZYimKxmRN5p9XSjdow+?=
 =?iso-8859-1?Q?NEPHetuTj0Qvd6a9B1AKQKxQbYbEESWC4vE4s+l7ilPvrcPlOqe1/qP58N?=
 =?iso-8859-1?Q?skolrAQ//8CheksrpAmejortjkpO2bvz5rscQ6irksWdzijqJCa5OFFIK0?=
 =?iso-8859-1?Q?EO7YoCYuj6FdhuK+TQI1J0VtQEvxJg5Cw3NVoCYmj8rMkskg9ACHXCEhe5?=
 =?iso-8859-1?Q?zHOD6K9VQeBxexotub5/GxhetK5Djg1eNUBLSvopBFqJlSag2KO4lrcS+f?=
 =?iso-8859-1?Q?E93EHaYPfCH0L/bA4RRz1nP2Kmxt++7o6Dqv9yZzp3mQX85B/LeuIL6Mmn?=
 =?iso-8859-1?Q?jGEbkT7uU9hy88pEhe5w2VFQlNPWsRcvw07GMI16DBQBCagIH99OooNnd9?=
 =?iso-8859-1?Q?tcsXFxzYJeFoG2VrMUlWpGjTkAl1RltKzRWHWyXCeIfOMDJ1WC3q/Mf3He?=
 =?iso-8859-1?Q?cVnKgN/DtcRY6jfJH5+tDr2kqazb1mkTrOhFLTPz7N80ySjbOOEqei2BF5?=
 =?iso-8859-1?Q?YRwRASiW0KWXjwKSv0s8Ru2QIOvXneBt27BAebAIq7ZLaNo8LcIBRWcT6L?=
 =?iso-8859-1?Q?rFYBfb18sQDf7Rv1Wn2NR3RgrHI4I+46Ehuz52EPfBXSqXVqxwnHMA2jGk?=
 =?iso-8859-1?Q?2F17oHk8KN5OZJ/1q0Ax/cIVln3/eUyapkorT5KgKNWMJ/8HlzcuwdYMdj?=
 =?iso-8859-1?Q?I7Y1Oehyhx9XQI3Rs+Zca9oNVLYaMTGLsag0sM77SlNSMBqol00fj76ayt?=
 =?iso-8859-1?Q?VDUXcYkVP327jwYfcoTns/tu0qTYfR44X2uzvaEmSSu87pPLVZimSQBJPI?=
 =?iso-8859-1?Q?WIOOdyPWJLpZgxwXkW31tDlsHSGpRicGaOaLJFGpYQoRUU8CWvuR0kUjmB?=
 =?iso-8859-1?Q?FieCcqlonOHvGdavKY4nLPNBJVR/Qu1iqdyljQ/ECf1HfP2pWMGm0eI5uV?=
 =?iso-8859-1?Q?a0SXLiwaTdGDMsQdxH/z/AdTN4xKx60YKY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc298198-6b6b-4aeb-45b9-08da601766ee
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:51:25.6877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZCfSzOASWf7bqiOkNuomK2ni4gRwKg0KuuZFh4IUodQQ1skDdmK0M+Fk6t5tl5RdtBhS2YwYsymvFypBhVDZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 878c2aa663f1..4f8cd7339112 100644
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

