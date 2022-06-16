Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E4D54E7B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbiFPQoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiFPQnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:43:55 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A16B286C3;
        Thu, 16 Jun 2022 09:43:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVnuWsckal0ibjOJZlQ5Sl2AQxaoksjBYWAGuArB/f+TeadeWXCtf90m4ZtZ+V5yJlK5taROD9kHzofBzyZraRsmxluw5XW+deuO9Pya3yDNrax/D8EM1PFwMDDa797rHBBLcFv2p82JHo1XWaFb2+A/37Djhd2nhTmLVJz7RVH1uH0nfI+AViPxnQM4/dJdTXK8s3VuDPkKiVFzlIlgAW6gFRg5yu7lIZVoey3tHJPLuj4/H83QpzNQiEAx3Ex/za3GwV6Q5pnZgOpqU/vQzUtHWrxzVi5rk4W0azF92h8hGkUXdlDjg4l/dpfxAQoZNf/Ob+wjfuKKjjfqwpuarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pxzOVcL1xHcj3GLXV0c3gB+wBpvOAuC68eePgU3l7Y=;
 b=QMf3vrIiXgiwIOhh8+mlMSZQHSoCKYyIrFabEWEb1pU+1TNeDrnrXQ/0wJHEyuQqZ2XipYhSVHnazNTVar1DO7E0T00zC9H0AHfyECOPXiDv+azT8tCeNxRpvTEGLLUj+qMI/6i/aVya0MxQqI0Sxmb+GdvzxlJNFGjQO/1pUbVbz+HAAEzPpG6OhbsR+7O/4sJASqoqjkY9IOxFWzZfRPXYNStiQx5mfBxEAu+TJXAu+Tk/suggAzOwO6CXB7ZvnuU2oeBMCFbTgPH0bJyY1fizRMWeCKOikiszrFfGrHe0jgOK57NeA0E+Vqt14G6F68yjzGT2xFVthIcPNYC1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pxzOVcL1xHcj3GLXV0c3gB+wBpvOAuC68eePgU3l7Y=;
 b=qu+9TvXS+I1eMeAQRSVmhBSxU1mfXQjxOpI0aBks2lDG7Dbj2S/F4kpPIeUZuHIZePzAxTm3xnA1n6KJ9LIckjE2dioKJRNwnppXvN2N5j95mTtX2iMp6hw6ObYGToaM5S2+teFUv9gwKdqJodjmse/7tolOlJxE0xod6CXgoLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by HE1PR0401MB2649.eurprd04.prod.outlook.com (2603:10a6:3:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 16:43:46 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:43:46 +0000
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
Subject: [PATCH v5 00/14] dt-bindings: arm: freescale: Switch fsl,scu from txt to yaml
Date:   Thu, 16 Jun 2022 19:42:49 +0300
Message-Id: <20220616164303.790379-1-viorel.suman@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0029.eurprd04.prod.outlook.com
 (2603:10a6:208:122::42) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 156737df-2028-43ae-05cb-08da4fb76144
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2649:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2649A8C40724FE5B416E72E592AC9@HE1PR0401MB2649.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOsfVHeOm2QiitsSjQa0rJjtsyx5VLU27t7uEgU4gocR24LK/OW1pzWMMk53ZccaPaAX3Gsfl9EzYnysYJSZnkkkXOxoDVHUkB7Gx/GZsN+plmUKVZPFjsIRQwoTvbe85VkNtMi8cSFczpRCYKP3TCgisaf9QW858u3RarFcwFJmk1wsRtQ+84RPQm0nmbKlvAxUN2ija7Hzwly2MgyEAuwmPm3zlJeaJ+nksB0aa9D6hCDW4IqoMAuixpbHeJPRACwk64BATF7ktq4AGzOdL8p0DZpQP7uZ+aj7ayqaLu2dtlIFF3o9mRTOiL9iawLa6zjjd4tUy2c4wGQBTOM3toH85+7UAfj9+kgZugeWFEVnCd4h6adMFSAZwNmegJ9gBCdIBPWrgR2TT+dSCoP9GWRdo9rjrXEvRHgIp6YMZLfeNec9s5DD+0Q8K0xhKwD2RSL1MAEqqT/GCj5i+6RIUectaoVve179UILIfB2FWREwEruZuQ5hvMw5LJqfAweSWEJR71gAIx6Nk7RPjBCQWAYSm0IU6Bc5fXjSfqWYvtQs5FL/9urLWvra22pdxX5unLA7gpqRrEowksCSkYEpyjRzv/HqcxoB0mu2D/GwBsNQ6seDPFGoZfYVa0KDY+mvRaBeZqRtApmt8BkSblaVqKwJ3IgZzNJrz/6StS+wXj9qbfc8gNBsAAF/P1FrEH+fUuR3rLEeXvVAWRl2ntpx2uiHTikfMiavDgamvubwf2BGTuvJfCqEReWQP+pc9Hz5tua36rY2p8r3Dkd1FBB0f6qooH6s/zYYrCh3mE3kPNMkEBEooFkQOxppJszSLyO2KMrQR2HxvIhUSbkf9kxr8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(86362001)(186003)(38100700002)(5660300002)(2616005)(26005)(7416002)(6512007)(66556008)(7406005)(2906002)(83380400001)(66946007)(38350700002)(316002)(110136005)(52116002)(6506007)(8676002)(508600001)(44832011)(966005)(36756003)(6486002)(66476007)(8936002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9Zk051uWEC6ycNLa+FZvNz56BS+fIqHsCFfQmABzcn87ijfcvrxfXbsG/2?=
 =?iso-8859-1?Q?A/UDLwG4vH+zar4Mbk/nn7CgTl0QUWeLd9soWIufnvF7ELqWKTwKRfOhKg?=
 =?iso-8859-1?Q?rUfqdLYO44Yzzmri06TK6Wm+n8DwbnnMLgAGe1Nh9S2rztltW7AzEcXiX0?=
 =?iso-8859-1?Q?w92Jw87+ll0iA6LZ6n7AFwjfWoZyD8wwQhqsXT9DdHC9KgpAO1uQPi/5Nm?=
 =?iso-8859-1?Q?zNYHdrjp4Kc8232Z+vOwojh45qbxZVHA2olAnj6pPMuT/QHTXFMR0wZpve?=
 =?iso-8859-1?Q?sSk50+Xq7zRET+ypPjoL+peJDToNSIVZWQYGIMbb+Ify6ZanqYvpbvrQt7?=
 =?iso-8859-1?Q?Nii5ZBIjZ+mxwlsum/YDa+J571K+N8e6qH+m6OmrdtJ7md1XRlTs5Vn6qq?=
 =?iso-8859-1?Q?EXnmGb59m9muMrrB9SZf7igXmdL+komKNgc5N109piUUuBrxv0Kv+Es1Nt?=
 =?iso-8859-1?Q?pRMl/P+R5TdMjfdNv8tLbtVIIaRFiCA16LldDhYoRayT2Mr/B2JW3xmUxf?=
 =?iso-8859-1?Q?Nja1UHFhcW4Ua3PxcSs5TDhtkStW4DmlqQUF0xY35xJzvcKrUNiJYBNJxT?=
 =?iso-8859-1?Q?M/v3Oc9S13Htp1fEbIV8seM9C8h2UITAbxJwpRY5g0OogzmfXfPsLPYfDb?=
 =?iso-8859-1?Q?4AARlvRw+KoypnSL+ZFZyWDgTmt+8OrSWEdbTFI8aq/JpXfi8T47L/An1E?=
 =?iso-8859-1?Q?AbRchs3JJgP7NVg8mMg62XaYdRhAPVr+kc+0ew7xcvRBAFlC2oxVZAyG0C?=
 =?iso-8859-1?Q?m591nH2OLK1ORAfxy14zKhSWkVP7JzuM3CMRMgS2Ny6u/I0LHnyJjjLVz0?=
 =?iso-8859-1?Q?dtgDM5WC6+WQSxKmEUVMij+bWJY/9TNKVxlSTw4U96wYHuMlMGKDs794t5?=
 =?iso-8859-1?Q?+Kyf103f1Q4pcXLtfhUNiRHNJobMbAbl6R54rdFJ7OkE+LdpCde8XiEOUw?=
 =?iso-8859-1?Q?q5R+jRVOcej5QHdEo558uFlEvvNb3fokmWUcXs3wGr5SFZVSxNLdMXvhv3?=
 =?iso-8859-1?Q?29jl6DF6wztqu6BfTNsmKaRXKHpZsnMAtL9CcStjHAfnGKU2n09PhGHicI?=
 =?iso-8859-1?Q?wuVx+6N0oTl9Bb2Jm1ZIYjsmU4Tib7v2Q7HkAo1R8lspzmW6A0RG/IOiDM?=
 =?iso-8859-1?Q?2OMot0jzqxXBw5lvt5Q2boE2XMN0A5ev+kGnnceA1IS5y3a7WGTyKY8CoX?=
 =?iso-8859-1?Q?TEyTWxPDtwD1lTQbJP0TSWXfMNP60D427aelvT8Yjxck2ZagautmhMm7QE?=
 =?iso-8859-1?Q?0RKPZHGk6H2MA7pWA4es+DExo/vkDfV+GHoMjb8qDer765UWZdrJ0xzzFg?=
 =?iso-8859-1?Q?uMvSlYphkPMIoI3ZNe5v7NqwxKFlIdQWthkedBe2EBEbwcn3CIfOw+NSKD?=
 =?iso-8859-1?Q?4p8K9cgg9T7bLppe0AF537/3IrQCqjokvNvKw0p0+ku1nCZqvfAg2Omyw2?=
 =?iso-8859-1?Q?BpHDpdCtqWgShLrf2Ano3J3rrLV+qiJxFywJeYu7kh2LjpjnJNxChsnbU7?=
 =?iso-8859-1?Q?TUE8Nd2qOiNoe1UX8fFBMDeynQxNqpru/PF0CJVRtIENSpAvS+87jQrKrw?=
 =?iso-8859-1?Q?N7VTW52+VIYtys/DjuggcxulP2wtZKo9GmaSg17Mtyp97if1WFe2sebG/M?=
 =?iso-8859-1?Q?W3Ajc7RTBtu4JAwpmb30tC7RN1UYaYfnPYNjcxD38x94B2ncQXQlAF6pEa?=
 =?iso-8859-1?Q?jP8PQTflsoiDfvHVPohxHjwF1kHamChJ2apBCgWARmXehMshe9ceSQliXy?=
 =?iso-8859-1?Q?SnCYd0On2gPxc5QUiBqdF3fxl5VIYPIuHFXdIEMvBwISFb0DEbI1ZI8zcV?=
 =?iso-8859-1?Q?wDZ+tScn+w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156737df-2028-43ae-05cb-08da4fb76144
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:43:45.8147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEnGKrEgjEA9CQbelWvW3zbY5eUeFGTaEwgO8NgM7YtfLpWWMXcA85pBlAj/87culINu09vy9+PJoxFJAMB9rg==
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

Changes since v4: https://lore.kernel.org/lkml/20220615105834.743045-1-viorel.suman@nxp.com/
  * Missing SoB added

Changes since v3: https://lore.kernel.org/lkml/20220609143423.2839186-1-abel.vesa@nxp.com/
  * Examples included
  * Included Abel's patches fixing thermal zone, keys and power controller names.

Abel Vesa (14):
  arm64: dts: freescale: imx8qxp: Fix thermal zone name for cpu0
  dt-bindings: clk: imx: Add fsl,scu-clk yaml file
  dt-bindings: pinctrl: imx: Add fsl,scu-iomux yaml file
  dt-bindings: input: Add fsl,scu-key yaml file
  dt-bindings: nvmem: Add fsl,scu-ocotp yaml file
  dt-bindings: power: Add fsl,scu-pd yaml file
  dt-bindings: rtc: Add fsl,scu-rtc yaml file
  dt-bindings: thermal: Add fsl,scu-thermal yaml file
  dt-bindings: watchdog: Add fsl,scu-wdt yaml file
  dt-bindings: firmware: Add fsl,scu yaml file
  arm64: dts: freescale: imx8: Fix power controller name
  arm64: dts: freescale: imx8qxp: Add fallback compatible for clock
    controller
  arm64: dts: freescale: imx8qxp: Fix the keys node name
  dt-bindings: arm: freescale: Remove fsl,scu txt file

 .../bindings/arm/freescale/fsl,scu.txt        | 271 ------------------
 .../bindings/clock/fsl,scu-clk.yaml           |  58 ++++
 .../devicetree/bindings/firmware/fsl,scu.yaml | 170 +++++++++++
 .../bindings/input/fsl,scu-key.yaml           |  39 +++
 .../bindings/nvmem/fsl,scu-ocotp.yaml         |  49 ++++
 .../bindings/pinctrl/fsl,scu-pinctrl.yaml     |  47 +++
 .../devicetree/bindings/power/fsl,scu-pd.yaml |  41 +++
 .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  |  28 ++
 .../bindings/thermal/fsl,scu-thermal.yaml     |  38 +++
 .../bindings/watchdog/fsl,scu-wdt.yaml        |  35 +++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |   8 +-
 12 files changed, 510 insertions(+), 276 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/firmware/fsl,scu.yaml
 create mode 100644 Documentation/devicetree/bindings/input/fsl,scu-key.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml

-- 
2.25.1

