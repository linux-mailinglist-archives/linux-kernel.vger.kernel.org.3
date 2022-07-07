Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5155F56A2A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbiGGMwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbiGGMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:51:46 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C074B2C669;
        Thu,  7 Jul 2022 05:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBGKGmFtcx+wCX4Zj++ZPZIQrm/4BlaQaZd8BfJAdq0yMKKXrn03Bh47fIeBQeK0diigLLlXkosjcfzf+JTVZRSCzOADTBM1L0Fo6zMaV3Y6+PXbrDKJuYtkkvpJuuNQe5OLHVslPklz8Zmx8xY9lR/k2p1/4TP7wRAiYsEBrxcGASIQfpN9NICFDhljwJDQVEvJqsDiYHo7qXiDefSdiK13F2VkZezzuKODt3uLmmZ7rOO/4rENaNp0pMZ9tpbQGFyEta7yHu9+Tls3PFogaYBmDwWBnRhpDP35DEaBxkcCfFYcIgn5AgVcL9rzgImOizwjO5QmhFp30Cd7VzUwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6Qz8bG7EFeGQxxcGEl3M3BGepTij70D5bkS9ZS3Hks=;
 b=beB1aTpV8Fc6DZVQX8MpUDpsyNCxxgOL9QNRLYXP2Zh+rSmzHD9X46BLABIFK/hGKEtPCP2qA7q/HDQvzypFk377P1VQrtCFQnqK7AWYpdO1kdJ0aQDGPbiY2D+VzPP+c87GvcrmpIbIeus0g8Y6CHHbBelK1PNkf1Ruo3U12tO8HXBjv4t5N3ucEnE6CsxBl41fkv1Va9nQlUDvfjSPgpOHbhQcacMj5/MszQIij5mg6U8MbKrsaSdPRuO5PmWCb4NsVWd13kq9sJ3DEMrRi/3HfNIP7KYeLeaRd6SnjTDg8MVyf1eSVLY7v2WppVB1UlydhzM6WzkHQ6bu4rtn1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6Qz8bG7EFeGQxxcGEl3M3BGepTij70D5bkS9ZS3Hks=;
 b=ViDBNLWmmUtn8Jk1FHc/I/tflhRnj9f5XKU+SH98Cw30fcfWB/xGaol5Njzc/2TDBXIIWecEcL9DguwmD9KkecHRVoXRJWnquSa/Pjv0kjYYSAWwuglErXzmH37o7aqAqY28PbZicywDT9zsih0/WIOwCHp+DBGUF2ljQLqiBpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Thu, 7 Jul
 2022 12:51:37 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:51:37 +0000
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
Subject: [PATCH v8 15/15] arm64: dts: freescale: imx8qxp: Fix the keys node name
Date:   Thu,  7 Jul 2022 15:50:22 +0300
Message-Id: <20220707125022.1156498-16-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a881357a-de8b-491b-6d1a-08da60176e10
X-MS-TrafficTypeDiagnostic: DU0PR04MB9276:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JyF/r8mBGD3UG5iS7cD5+kx41V2ABvjTLs+THMSeTRiOAZ2x83BXM4z75nmGa08o5zZGFWVRJhVDppQDj7z1q7J8dtl4zv5HTqZ+rFlWTyFFeew9fdtCGs4JJfHJLwBzafb7b1o15t61qvMTu2zMO2JWJj0J7ZW/FKOkkzRtf0cpws2wGwxP1J4fbcGkGLNGb5PAy2qS//tfcqe9s7LBWlP8YoXfvgShR3ky8Ds0mMfRbxKdxF43BJbRXxw3S0I0LqGp+VlnFtJCUaVFGAnJWiCTuBaXD2++hyTBFm2Z5+9aqe1K4oXwcV4EJ68qlM4jYY+M9Ka09X16uzrjUrO6Q89hdbSUbXuBsdk29WiGS121D6xpcHDspmDcXVuA6qQp1x2DvUzwxE9ZXzIECa0EvOUcNHHNPAGUDpcCaAefbu9Cpb9Vcf8vF5gig24sFdEMAcs7mO2a4eaZ685oVxMhPUwULGHalD2tNg7rrXuoeTJKSAyDyUguMHc38719jE/tl0BRIKmoeUo3x681hwRQKV2zZZ8HsjRglcdJVma5L9z4emVmzC+mMCXlMzekXRx3mGOkrsP2TLkJieDCPqqwCZb2b7uJv3qjljkDwpuMtHJsWU2fz8uJKNFSCm4M1OjREKCCdJ5ISpPuhmuhDOWyurxj62b4l3+Dz4j7J+AB5lX27wUl12HqbUoXXUjJDIMg4LnaP3nyYo5Iw5h7ZTS8GNNsxFNdjQduVi3cfohSC1aHjq3tWOBqD8+4fFjJO6+RkSMQwckcw1rAL5jf1meiSYQdsdQ2pdECsJzAkDHCNP3FPfQTZVstA+Au5m1DnNt2YwZKARXDh542yf3q+7jhWg+WgxL0l1356HSaqzXs6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(921005)(5660300002)(7406005)(4744005)(7416002)(8936002)(8676002)(66476007)(66946007)(83380400001)(6512007)(86362001)(316002)(26005)(2616005)(4326008)(186003)(1076003)(38350700002)(6666004)(478600001)(6486002)(38100700002)(52116002)(66556008)(6506007)(110136005)(2906002)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yUjvcfan5aRO4fQa4jKhR1bY+sEIo/Gq4UAZWdZqF+y3pUlkZ5diTRa6Di?=
 =?iso-8859-1?Q?WyZF035BkypsVzXajZ0faZskcin+b7jcKct0IjExFRjzZX6IOrt0e6m01Z?=
 =?iso-8859-1?Q?OX0nREjwAk9JMhg0p7pSUNf84L21E+zu5cLoZwg9uaEHMwmIYHnjhv4eC5?=
 =?iso-8859-1?Q?Y0sivKbe4MKq0bDT8bU8vsOiWWlCF7wLY7dlzPA+AHwEq34FkFQQXavN5Y?=
 =?iso-8859-1?Q?R+3/ER5qLkDAa8xfQv1v8oYVXbyoxn0BfTECQFx5dmFe1rNftMAwtsbzmg?=
 =?iso-8859-1?Q?+EMS/N0zt4AFyUhazSrBV7xZQg0znZW4II7sl8q3xTNFlyWDtCC19T7Xgu?=
 =?iso-8859-1?Q?DpXRcmoGfY5CuOJbqKY6GnzuZrTBZhdrzFtw4eM5nmccw6i1NDKY5f6Yor?=
 =?iso-8859-1?Q?QeGpt7tgf5lSNP8hE1y7mSPDQcjaTv45dyPTArIqhO18npB2+fzvRO63mR?=
 =?iso-8859-1?Q?lA/luN1ctcZHwiqQLuew7Xi5bnSHGIdRJE1/KzbRYNudPrx9Yb4GfO2vfZ?=
 =?iso-8859-1?Q?RTxf4PbIWqC5k6WRp9J8dL1nlTGIO/m4VhTj17vLeQGYEnUBbLO4GnJRFG?=
 =?iso-8859-1?Q?IBiBd5EM8uu8sY5fVnxgCTPOefQ1QX3R65XzxttLJbK0NqHwHRM/6HENdp?=
 =?iso-8859-1?Q?egxCuCTaS/ireU0KMe0YABE3IP5YpwmFuUqDI4ntywnAAggueZEs+FUXCN?=
 =?iso-8859-1?Q?brW+f+td/SZpN/HMKRa8eKGyqFulskne1RFuvvf5lMvQOdnYvpVabKq1+v?=
 =?iso-8859-1?Q?OaulwZmpKmxnBpNc5h6t8/CVxhAr33gllpCISmd9H57aH0z85QVYxrEooF?=
 =?iso-8859-1?Q?6X9YuU1dJzKzSIQRuXiEM24RV92n+sR0EhdBEgGWXjsWLi10jKWM4jxuW6?=
 =?iso-8859-1?Q?ItFBEywF18Av1MjqrIUOT/jFGhAr73quJRdGU/ETeOPzL0L+nNXFEoxs0E?=
 =?iso-8859-1?Q?OMSxhqLhx0e2GU8BFBcc9jkIXUWuWZ42UlTvC1QKnw3amAiPgHluavIb1P?=
 =?iso-8859-1?Q?AL7rONWiR+wqUS2H0DxIc9v76yjcA/TnTdva/YC6H0hTrKp3sEGqJ7hNGL?=
 =?iso-8859-1?Q?jxxKQBIBpvQKpnGrIzwDOAxG+GPePIjRPtxAhBVGcPTmH7bFdvWiusdNQx?=
 =?iso-8859-1?Q?2Q+fUI4GnUj+rQYAI9PiEp19vO4+qDyfQm+ZmT7lYN19hgMCydU2qzHhj2?=
 =?iso-8859-1?Q?0+abE1udnJzb7+n/lRjfaU+OYqyJJe5O05HsOHZlca97b8xdN55KUJiNcm?=
 =?iso-8859-1?Q?h3rGfAIiUHc8s+sD62IjC/Vsjqb7tLn0xK8BYtFpMXGtBPTxDDqOz/VAXA?=
 =?iso-8859-1?Q?+7JNDxqpNr6LJqU5AzyXCInYBeUKlncNHto+xGhLdS3cOxMT8cpI2o2r1W?=
 =?iso-8859-1?Q?PQ1Q+d7DERXboiEVjYJbl4miTmQ2wHE0qqc71Vtz5j7qyLVS+BW/7Y7I40?=
 =?iso-8859-1?Q?bMQ8tV/lGW4hP9YFVTeep//I7TLA8cK3Pd63pWObnlNKI8c+Q1E1rFjCYh?=
 =?iso-8859-1?Q?o45bT7IDnogOUn2HzyKfE5pzKn3f0g95ZcqGAFal18uMnMvwtHw4ifxCKV?=
 =?iso-8859-1?Q?CCJCFY+39AOlvKV968eAkG07BkhRilfhCXYP/CRmb3pP03XgNBt6GopUZy?=
 =?iso-8859-1?Q?Uru2M4Hq8tc5JYGDMgADmkJTf/yqliEuPo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a881357a-de8b-491b-6d1a-08da60176e10
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:51:37.5149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CvDYsfe6GbllYjKYrXThp6HjGwhNzKvhGEG9aWRqyL2rWIfHRY7hPZ9Wgf8urdaoQhNyOespHbYUaTXJZMhQQ==
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

