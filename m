Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AF654E7F1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378174AbiFPQpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378139AbiFPQpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:45:05 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30044.outbound.protection.outlook.com [40.107.3.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85882DA96;
        Thu, 16 Jun 2022 09:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0rDIX3gJTCVIN4cdNwc7vG2h3Ifyr5eg963dFD/cbjRyJOgpG8wkF8TWPoUSpVYNiirbppY+U2NvZ6A2X5IKyUo2Ko6yMoPPw9QT0XNQ56gY7ibnuQQ4L/MhHWefIqmE24c456D442cpByxF1MzF2BBcT3KePl1q9ydvv4ZZKkMzsVeNR/xr+4LfYA5jYY+PpAWM2vb1m8RCqFcXpeZDNEszvyI1QYQWPqdmfD9kA0KC9igpGPv40ztrZ2AF04TBiwXWyVBqA4kKmFCTuaLAJYpuiwdd7+f0YNSpep0MIw6d31JsXgpAX4JNaJC0VEU6KZUFo90hemvANp5qs7c1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmvZuov1bWzSuIePc+fURkWMa24hcuw4hTzM7bn6owA=;
 b=bDQIozZ+K1ZXalsSpAKenR9F7HIiHcck2DOsURJmyzJf3Bpbkx0b5Z4cRsIG12FYRNKYu37PhYJxJYXBwFlfEDD2u11r6i/hsmSMFGRAvtmlWv5xBrv2cLHEmG06dZTnehtog9zJKeD7npKwC3e//NKwkxCp+mQ11V/nTExR1A71kVBpmf70S399vvYdFgLrcJp53scaM6xtouUkGNqzbxgK2vrebhLlu48WMKn++ZNvTS0Mn4O0oPcb3bVrJbtcHpUUbyr1XjrSGQIwucdrL8kYTfKx/okgHl+Z1tiy4r4/GUEvNUYFNvt3CteEBzrCYrMZi+tGdn8B+xB5jqBz6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmvZuov1bWzSuIePc+fURkWMa24hcuw4hTzM7bn6owA=;
 b=XGA7qyIHFuL/gkbsA/HsAurCuHllqvDVBVQ7RxdoAVzuAB2WOgHFIZjkCZDT0RljOrvNOlIsfg7EuFYdqj2AhRyfGmU/odjAeAS/pytWSLKw1ju4ZhJn0hgyRwTh1WYMVt9fVelqG0Fun2+enaBszgsvhWB+XQ+qTI3GyidvRkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by HE1PR0401MB2649.eurprd04.prod.outlook.com (2603:10a6:3:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 16:44:23 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:44:23 +0000
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
Subject: [PATCH v5 13/14] arm64: dts: freescale: imx8qxp: Fix the keys node name
Date:   Thu, 16 Jun 2022 19:43:02 +0300
Message-Id: <20220616164303.790379-14-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c6f18c07-ac27-4c7c-e6e4-08da4fb7775a
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2649:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2649CA1D456A85BEFA281A0B92AC9@HE1PR0401MB2649.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+nUREjNLfylS7DgrL5Wa8bybH9SFGWKVkDkg9KhsNhR10BSkNWnFEQiFPaxLspKod5KcbuTTOi/dmFJpi6JW2KItYCyMET/DsdXvS3PXRb8U+EP92d1jo7aKCzu1nxxK2lXaNtiJx1pO/SIq9nnIygEE8asQe8hB/bQfeMRzil7hvS2ZH45lEV4aUNw2Xb4x7wWS5WVACvk3gNem3bIzg0EsZ1d4uHqEvP7UJLIilw3djjpASiND+xiI11XSxIBE0wRJsOd7YUyUoufM3Mma29DoI9FFmzl/Vw77PLMczLMWRulei4WV5Uw+oOTFlKMBFX1/7lw9Bd/zyQnCO0H5xVZZyhR6YXNugvufMD4xZiV+vVCv/qXfcudS8mEJ1pY9ndnCMEpPbQjwyowudwPo1IWkLGIzsWppZ1xdtZqm16DqM/yg3p8WGjNelUoN25UAtx8A+Og2XuggYQ/idY860jqo4K8Q7KmyNtLAHuofPl+Po0djuE12hozo4VjNCzkxBd4DV26wQU67NrFAr0BHwnfIyIOf/II8pJCvjlAcQWEgYAH5JM4AFMHzY+L1RUTusdldk0cm2Ahtb4adKFXWA6pTeoYiUHkUYsH7SAigFTUDcokD2N3aDGi0VzXLje0xGg3CYKfrfVBp5vD/EJ1P2Db/ez5gLU13G6XF/GUPjvjH1tvETIbY9Rsy8Eztmhv2V1fXOMeQtO4oHKVytCUw4Ce55DknoO2OfY4Yt1rg0SFaMktxf9obzbAW68FPPYT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(86362001)(186003)(38100700002)(6666004)(4744005)(5660300002)(2616005)(26005)(7416002)(6512007)(66556008)(7406005)(2906002)(83380400001)(66946007)(38350700002)(316002)(110136005)(52116002)(6506007)(8676002)(508600001)(44832011)(4326008)(36756003)(6486002)(66476007)(8936002)(921005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LTarlczJh/sZp6Kxsne14bNRW3wWrRA1kYZRDlgYXfg/tdaprbspapL7SR?=
 =?iso-8859-1?Q?JNOK35cfaoUvjuB5TO/gttuG5+/Cc2ndD67k94Ksln8nHtbh/Al7wTIsY6?=
 =?iso-8859-1?Q?1Lw4QLVg5A/gCt8+ZGBSmqda8Qt/Et7iThF+AlFxLNoYwoj0uODJvtT6S3?=
 =?iso-8859-1?Q?mYrsqvCeaDOwMWPXW3V9SJvzeXM0E0/TxTZDsl/gJMamRpBwmgKqgIlSQb?=
 =?iso-8859-1?Q?e14nlkBGlXrT4tSxeLivq7bxtrlrKY4NNxc+D2Bbm8/r2iyhZpYo1zbqtd?=
 =?iso-8859-1?Q?4kZi8+L55y1r4Q+nOwPALmPWXxNGCkGraFYWyoVVaQQ5YyDYx7APRP1t4h?=
 =?iso-8859-1?Q?od3RLgP/hCS3u+lbD2RekiNPj4A8sQ/xFne4YdlgD5X1xnELWkgSal72U7?=
 =?iso-8859-1?Q?/XWwmNG7S+237Wy63K3aCuycS3rwZNSCqH5VANy0VrnQomTPJgdcEprmYM?=
 =?iso-8859-1?Q?SZw6O5HSVFqB1M/bppmtUGV5AkaR82mceaxVjHPaObgkpod5Sp0vUTZjWd?=
 =?iso-8859-1?Q?SU6BRk3sFkjoDkuR79iU7qfkoaW0V2Q0uZ+GSY/toM+GBAPhDm3hXFpSX4?=
 =?iso-8859-1?Q?qjjhQpJpjX3CisXxpplGISGjDsFaPQ7FMp7QmBP1jUygmy38plGMN/E3g+?=
 =?iso-8859-1?Q?LVQDGfHX+b3U58+dsKjHJogPSDShw1WKzB+O083sUfdjwM6P9Vz25DCiDy?=
 =?iso-8859-1?Q?HfuVrV3jemYUut26epz6mF2BR70mGAT91lb/1c4idd+n1Pia1GrTTfoSkv?=
 =?iso-8859-1?Q?xQWA33wSU/ewS0MmQwefUnz+nnIx9z2YWjdVfxtQJiWTR1PvfhTlSvgGrI?=
 =?iso-8859-1?Q?pVdqeI3qNbKCn6rsQBVpRrdfOFIbLpQSX+dW79pMwLSR/X5eqdWmt0b0DT?=
 =?iso-8859-1?Q?bUYGkVWE24loK7qqNSp4AgfeKWTLfMFUV/Qm6DxChVKOhK2B0BwoaPMBFi?=
 =?iso-8859-1?Q?y0jajUZIPcE23ZCJr85NVK79v2PKfC6eJXsr1Ob1MC6fGmB09JXmFbp43Y?=
 =?iso-8859-1?Q?V4J4sNoIgB1yvTVzBS/ugvpcEQ3SKRs3J+JWEgh6E+mJMJSbWeGmwGrfdp?=
 =?iso-8859-1?Q?lgubHjeipelweDFJ+wZk1zysryr5q0I80btrSy0pdtjJW0PKFF/6WvKpBL?=
 =?iso-8859-1?Q?STUwG5UFiRVMsp09v6qGaixlerACOy63p9m1Fjcv4/pXkedEB42ux0DcGj?=
 =?iso-8859-1?Q?o+IaX0bLF4jyxzCTX8+MjTjZzEnq9nJ2aTQT2mmmlEDU6WPNeI0ImAxpC2?=
 =?iso-8859-1?Q?FUGkFvVPWw9e0ig5rL81fdTNE9FBdAaKXEQ02CFB3tGbBkGqvpEfAm8lMO?=
 =?iso-8859-1?Q?IfDbmQYRr4mheN9D1Fk71ovLuSk+kpKRJiy5P0GZn/QbyKkKzxwOXIgzFW?=
 =?iso-8859-1?Q?nK5oScDV7z8DiH8F+krwtgOFX6mCqyo9SFb2DlJclgmH1G6MUXBhanPjbb?=
 =?iso-8859-1?Q?TCLjK4m+V14meD6QwZR6vyBTbBKjhqT4bFgRpxoIHYr3OgW7gFxbgwQpME?=
 =?iso-8859-1?Q?9LED6GdcEJYmiikmp9idsfmxcNCnrmoE++kCGy2k2BHWGpykLh/8pMLJrO?=
 =?iso-8859-1?Q?pRC830LhcxAZZRKB9DyBV/rfAjNSe0nA0J38PC7svqUQ9fwV0vLWXhdnIJ?=
 =?iso-8859-1?Q?mSQL9FZs+mHdxTi6ga1eQVpNbLPzrvSjJDlYmNVUAFLpopE3E7qQOpoqq4?=
 =?iso-8859-1?Q?7SBuvbkumcnW7N2DhD0gdxhLf5bw1oALRJCOnrDmg0Jy4OqTFZ7NtCnyOK?=
 =?iso-8859-1?Q?aFipCTbfCuSfbh51Lq3JqtBpw07lEXTcAMiDxktKdjAb9YS9aZ7/zPZhfX?=
 =?iso-8859-1?Q?m5xx3S4pfQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f18c07-ac27-4c7c-e6e4-08da4fb7775a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:44:22.8276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zj5Hqlfdd1+VAwK3YudTpUHoqGI3URRbFLIVP9n/lDYTeSpERlbhJA+Hzy3HOT/m2r2MdFk9u3uVXfmdclrQ3w==
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

The proper name is 'keys', not 'scu-keys'.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index f9c3090c632e..1ef736815969 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -232,7 +232,7 @@ ocotp: imx8qx-ocotp {
 			#size-cells = <1>;
 		};
 
-		scu_key: scu-key {
+		scu_key: keys {
 			compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
 			linux,keycodes = <KEY_POWER>;
 			status = "disabled";
-- 
2.25.1

