Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEAA56067F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiF2Qqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiF2QqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:46:18 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1B839824;
        Wed, 29 Jun 2022 09:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDOyLzgQZy/m8s7a/sP9zLK5RtOHE6RwFQEnSjkYI2FIlb0EQD6Vj2PQeviIyTJzJFS9h4wEBl58d/2e1x1IDA2IG0Z4rfTETvk5vMqXooSS5EMUcFINsT3qJ6ArFKc6vtb2bLJtNVo2kbAR04VdivXGcyW2VQ+VrHcdY9Jyfg6WFXoKahRNOZb3qdqn62VBHT7xCcepN2oR4nnaq1DWsSZjSkA2g0kw5CYA7slRLFuadgq6EdAcEJ6eK/PQLV0LSumNaFge86kAQIggcCokxLOLappdQK8bIxLvcW6qVJ8GE5NCr4h66oROLhrj2Kjxk5FFRk8p58AjusXvCadHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI4oejGXuCy2Y2FQ+M8kieCzFeO0K5hroMLoeq7AZ0c=;
 b=mkiugjqes+BC0MSYAHH7TRoHI2Lvn0RHQhHMkWQhasHtxBGG1QZSkR/sLt+2UwbFERZwYuPmNX6O+wgtS1QC76PUn9kGfcwjCLFbE6+wShXtuMjO77sUSQvspTyvvI/E79QozV0dzWEFK0ofodI4rJkzVn+5s+VomQDUdru4gPHOJp7rBdRYBONc6VHqWGHUL/s2gepdoqIYXaJ3lGy9NWtR9oWSGlcfBaR6kUaH9JE4VdA6k2IsXBxIdpZJhepZDuQ2Tiselrdh5KY4Mh3CvY0kRVs6AI8/m/v/CYJtZQz/fcG4RgyT9YSijJZHI1mkKkRw+LiIkp+WmB3mcHgZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI4oejGXuCy2Y2FQ+M8kieCzFeO0K5hroMLoeq7AZ0c=;
 b=G1VISrc65kibab516VjmTGRDHY/JwLBw3npKFR9mhaB3ZcYwhkBln748i4DRUgSZGUlVei+veO3ZToPEVxO5/o1Uc6vE3TV8oxdTuFvamMrj3i0Vndc6KFQLpW0Ad2dEtLH1Zy46c/ysNqrBohqDsr63Mui8PAyWfIkJWCjeKlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI1PR04MB5840.eurprd04.prod.outlook.com (2603:10a6:803:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 16:45:28 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:45:28 +0000
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
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 11/14] arm64: dts: freescale: imx8: Fix power controller name
Date:   Wed, 29 Jun 2022 19:44:11 +0300
Message-Id: <20220629164414.301813-12-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::33) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab149ee2-3e58-407b-74ee-08da59eec5ca
X-MS-TrafficTypeDiagnostic: VI1PR04MB5840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4pT2s2FCLz3LzKAnm7p4vVwiCCDUEbG3A4mjlU39H6CM7c8whtoVBnh/YmxHgVHGn2C/Ucz7ke3vIxPNuhXaoMsYnXtAwpGT+ePj4CGLSQcXw8GkByl6rnBNuJxLMxdkfhi4BPt1g3IFB3ZQOfltJ8lye9q8f6v50tdqZIpyHmSkE6ij75OxMQUj0tgknWgnWIf+YKuUN+ny+xRFofgZhDn+EJ6qM9iopqNY1h7ytfoJGlCom8iWwuQp+lcfjShOgH+G8H7GIBvGYfaELx71wBREmjKWOF132kdvYWpAmyLwQSWcQ5NHrAidVSSvQqAgHZIHJuGgCJic+W+bO3JwZv59oFk2hynXKaNfgwAs3sRlU3pFH2UgZeZA7BbLkaU98qgSaZHtME/Wc5/JAY8FY4wq9bBGJ2MTocIwL3g+srwYx4ypOGEc9Pfb7XmSgFSIpBONbcrChSgWLxtLmbnolwKC4NOakFMJFjqt5vviWA3Lz8+iPhIvBFzU2s/PRe1tchyGIUwRA2ODc0GL8Ct5o9alxFolGhOVZo9zw19aYvoCLzvPML7i3/36hgH7sMf3Sepb7UEXHqnm3n/OJXohiCP3XlZ8gA6CRdylQiZYhTR0ads1SjamhxTzViQwW3/OlRZcOaivpUN7+0U7BE/Bs8If0uvqBIyvNi4vPwjryTva2lVZjjNU5PwkzRqR69K2NqKVEJesggsqUNc/a7J7CxkG8Yf1VBykq+EY9hsJouQddSzwmdWLb+ITM3QDjGAcj8z/XHh3tytUcQF5WPkCdXdLE4aApnn+D9rDt1yzi1iwJojN4my1kk3Tye0Uxdg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(66946007)(6506007)(26005)(316002)(6512007)(66476007)(5660300002)(66556008)(6486002)(8676002)(8936002)(52116002)(921005)(38350700002)(41300700001)(186003)(2616005)(7416002)(478600001)(86362001)(110136005)(6666004)(83380400001)(1076003)(38100700002)(7406005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LO1dk5XbAT4xAxbgEOO+bwIvd28+xI8DxIqDKMRJjhCjmu0w0vSWWi2HKP?=
 =?iso-8859-1?Q?QiiQpwPMZGZLCLXQgFZOKiNWuuZ31EvZ90R8jt9BfDOS9YCO6TyuV7VIPJ?=
 =?iso-8859-1?Q?rbWaKG2VnfBa6u/nOdju1+YeqdxvjIIWw3kXweigqV7AvxCVlc/iyTogsb?=
 =?iso-8859-1?Q?8/P8h6RYisLc8oEfxzcxFvE9iVtaLmBtYMRgE0oT5Y5RuZsftfK7FesK5p?=
 =?iso-8859-1?Q?laQWBlsPhvj7E0M+I8LlOVLYUhtq1Rqui8ZPOn3uUcHL2syelPAs1ZOhdZ?=
 =?iso-8859-1?Q?KFioY6FPMxI6KgIj1NUp3Qn1PgV3Rl0wGv/FH17osRVQlqEHbiAuN7XNBD?=
 =?iso-8859-1?Q?y2qQeRfj+z4Z9GF73tHntFi9GLexKXpCqnUY5f6E9YektuLaZIAvR6zQvM?=
 =?iso-8859-1?Q?8nITiy4tOgpkWouVDZKvl4MyXfvA3CiH9ZbrIY+Vvmem9NdRmJpwqrgOLP?=
 =?iso-8859-1?Q?CLFs9/GrV+1Y4RJgr5Ll+qQn9BgXOzFHtfrBGsoqO/HBNg1doMslUQjwi/?=
 =?iso-8859-1?Q?761mJ6Ugfcx18kFYIZi3SWqq4MR6WY6hny4HBtakYnR33XZywb0RMMC2pc?=
 =?iso-8859-1?Q?bQgzAPUVv64mBXa3cl/MEwr2wZFkzpRzvkfL7u+4Fm72Hw0AITV9jsyyfF?=
 =?iso-8859-1?Q?1nbbHDWMUS3J/pTttDBEdrVmHjdYZt6lEZUBdEpl7SSyDmJJglHdjt4nLi?=
 =?iso-8859-1?Q?teBRE8iowkBPWfdmSDQTrBabCGCnt10hrvG0SRPjXfIdz1uRFAhwsTJ1PO?=
 =?iso-8859-1?Q?84YH2cvJrSSpQbQXjVDxZlrquj1//2/fsoIMM3+eaV0dUSxmlX6z1sgTEY?=
 =?iso-8859-1?Q?pXB2GLt0Os3V9N+sCKs/bq1pecWb5SoH7zE/6bOS1PIllxMxknmbZk82lM?=
 =?iso-8859-1?Q?szIPQ3146I7UHdqarYOEC1VNGvMjqg+btJYUA692evBeKDLU2u5qZ/xV94?=
 =?iso-8859-1?Q?SzUEnXdVLCaLjUD7QLJiSzE8qJReGfMemfXbrec6KJibpHdgqWvPY+oQjQ?=
 =?iso-8859-1?Q?boy628Ot9YfKwJVgMPG3SNL6AX4yQajLC+DqDgXZG6FFi9/rwsWsJ6ddQF?=
 =?iso-8859-1?Q?eBlWi7I3cJHDBh1ad9T2iJ6kcco7FUkfu7hAoC0uPUWau8cfAKl6waDT0Y?=
 =?iso-8859-1?Q?w6bnGNomw2FiVktCn8KvAOipY3Pl28x3Ju2sabXhY1m+b4koJeGqD9tBes?=
 =?iso-8859-1?Q?bwS2Vszr991XvT8af1mjF7LsD8sY4ZQBtGAEsBPbvLZubvN+istxR2mgUY?=
 =?iso-8859-1?Q?dX1N44l8v7HXEe7q9arf1RQCB+i9pvRfQd/Qao0hUK50lonWwMpZjEhtX8?=
 =?iso-8859-1?Q?oj1pVIcWv1L8Vd1m0UKvDezwngZC8wbe6AIL7P6/ZsMOKjMiFTfIf/qsg6?=
 =?iso-8859-1?Q?c+HE8ZOKOxTfus5jDxJAplYNWAZu1mDMzU2f6kpky5119tplNxOW5IKWri?=
 =?iso-8859-1?Q?Ct4BtmQQsofu8n0SWZGWsByjjjdqlWY8SX3kepSwED5xcwDMHJzqPXPFC9?=
 =?iso-8859-1?Q?DNYTHLy6f0f5qFPOb/oRkwPLaK2XCGSFIiC5byP6xMT0lP65M7RMNGhV/N?=
 =?iso-8859-1?Q?E/G2kEFGCRWZymvtyaQGArdDwMtFTs+WdTIqdGz5B6lGAqFHc+c60028kQ?=
 =?iso-8859-1?Q?pQoc5XPWBtFT2j1jXG7QPiSxZmhDjKIvZ4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab149ee2-3e58-407b-74ee-08da59eec5ca
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:45:28.3220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8q+V2g+j8VR+U7V6VZV2yvQ0IxRohT28cWvLeZEBah5h7iG8242dTQKJwm4Wpg55hmPQCeiqPRzFpUYwn+eqdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5840
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

