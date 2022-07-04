Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009E4565AE1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbiGDQQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbiGDQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:16:25 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60077.outbound.protection.outlook.com [40.107.6.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4603610C2;
        Mon,  4 Jul 2022 09:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7MgjZZD77Me/bP1tUhkd9pFpaq8r/sS1h8gaghTNv5RE9QeAsGHyUc94XwuTdX/t7QazKu3ik0y4vIrXv8zRZKJoAJeWjZJcaq+VOsbeK0CrzrJlZwy+xdTsj4ko9T7g+hOgdSqznMu+2IKBdGJlXvl8EE2OMUpAQNNqvhXefTV3XA7RtnaoUlgxiyL8ulqa5qF3Ox9zTO3ZwtpnFfhezy8gVhCtMwAg19BPTE+u9l5qCdO1zCscEt4N2nPe5UP6IglcM53RqFfCVNPzUObWXbWHYNo4Y8pvkE5htSmARYFw67WOMLYxf+jCVzzp5O3ROog84wKHjP/KQIOiCL9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGgj83yGzD6M1rPElUntrc2VoIA6exgXaV1BpStiUxA=;
 b=fF8ffyXK6C75PoGrSMD0IouwUH1YLoMTpBmkqargzysuOSih/sIvmSUfchNqxbwKwPCwlULJMZZMasTfnO+1kHt/e26SEM5/l0sC+lL6TyXvpRFjekeD+g8gNeiGDH/eAlsd7JCvesT1FCPFHsI8idKmrDmWNmQfUIsVd/5W/xtZ9G3w3BN1w2F2c4MZVUO0GcOckx7gA+QUx8hv18hn+O30pqCtK1UWpsr145/g48tQJVSzoPwRPoXOX+E8A6rRXBu+tSThWIwG2kTfXTgvLH4kxNZje+B4lTm/dAwJ7hUbEq67xcBoy77ZTJOYUwd8+sSP4/r4wHUCTe5LllIQDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGgj83yGzD6M1rPElUntrc2VoIA6exgXaV1BpStiUxA=;
 b=mscgz5J1LXe9iWVttNAito1AFtFSAdIh0F8EBlcHdoua0dUiPChb/6mUNT5tgs/W9DOfXx0hlnFeRltJjJ5/KdrpC2yTSfEkN8ZM13ioNWDzm6Pyt0jvvBkceh/GuL9OnBM4SU+geF1PLRL87aZkThtIpNaYQLM+aVOLD2yZwbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS8PR04MB8213.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:16:20 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:16:19 +0000
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
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>
Subject: [PATCH v7 00/15] dt-bindings: arm: freescale: Switch fsl,scu from txt to yaml
Date:   Mon,  4 Jul 2022 19:15:26 +0300
Message-Id: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::21) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b14d0db1-9d1a-44d1-b8bb-08da5dd8873f
X-MS-TrafficTypeDiagnostic: AS8PR04MB8213:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QbsX3ZuMjPc1KIF7EaG9hTfKYNyJCZKAL6UgzOfdjmgNqzKBmhW26TL2DG2N6PAiBsG4NCUOmQxTSthQ0Cb/88h4FQPdEOfyWzBUDqytxql+6mTDWSpsBV7NX0/MFtXjtEv5dNmem12/OK4jtzFYFqnK+0D4XicUrxmRNrNd74QuIDMM8fEKjhQmMT9jJbC70VjWGqztrNJUN5HyRhKHDJ9BvOnmu+krsHQNsHzHRqxUge8lpGxJg4LCnD+JWPjZaSf0eaGSb/Qj4kQ8VxOnbHSXiymLGmHO7yDdGdZR2TF5TM7g08b8su8BhzaHDTe0cwbJZ8yom/29UW7BLU4jFUrbaPjuhE7xzUY959lVOwnDmc7Vwm4aS3obijUN4+rDXf2izgYy5RJ6blN65d+oRPi8Rl4pCdUaEvzOZ7W0ZcPMEzJ3f3JCze8MIbyM+Wfwfka93fdfXr9r94hV1QCcenCFg0rF6vARwgVCu60vqh+rEEbUCboqmlSRVjkKJAloUCaWNBCYEKZO/8e5ZO6ooY8TL56RgbVJ+ca2TMfdpsaTvGZOxRfp/+pc8CbMft6qNZ1fVIeVszNzpi1rloyRvXjmS8Y010uLlHgguUilEY9784VaQtzoYeSGU55teYYEdJ479RoEepZ3CQEwHCMhH8ydw+53O9kwU94IK08TH8BQNkjAY99SAMoEl4yzy+8OwVie8Uf5TQmPKcIX0ubDEChro337VwV3U8gUujP/CGMipBY7XgK32DEEA9D0kTwRiOW6SiNOEqwr5/SCrds9FCMOI5WRZFwBXYeFeqoK+l/48O08IJimwv6cBdM2+g2GHquhMP6wRc309c3NXaMiuZComAz+OThbloCvD8cGRuJpQosjlBx1STFdo5sRkLLRIUeHSAyvWI70q3oXdt/Gbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(186003)(26005)(52116002)(2906002)(6506007)(6666004)(6512007)(1076003)(2616005)(41300700001)(86362001)(38350700002)(83380400001)(38100700002)(921005)(5660300002)(4326008)(316002)(8676002)(110136005)(66556008)(7416002)(7406005)(66946007)(8936002)(66476007)(6486002)(478600001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TOFE5Ke2wvx5m+CtcX1cubHvOdaGc0y0CxnNdfmCaXfAgfuNuVftSyy5VK?=
 =?iso-8859-1?Q?sIzLDJIsBM7yHtbLT0WK0miDwYsI7jak6uNONm7LNAO+0gQrE8J6brZbZ4?=
 =?iso-8859-1?Q?ULOAY91WhC1rbP2cJ2NaVJJF9eFlyw2XjO8U6d9dNmVU1tCh6Ss3R1SoTu?=
 =?iso-8859-1?Q?9S0EDDelREvM6IWncAV5omGM9nil6B0PZwjN2fz9CgytaiW9XVNxaD2axG?=
 =?iso-8859-1?Q?kKlgg3l0FgUrlSlnP8Wo7Y6twYjIqWbbCyYOmgOptMpebxJrXnPRnEr8+y?=
 =?iso-8859-1?Q?+Tr8o+uSM2HC0OBArvKcUihs7RLNNSfWw29N8dtnKrEIY7f8AIqXuai/Ai?=
 =?iso-8859-1?Q?CyPblYGCKdCnyh6FBaurgcMxwTg3h/kJUmF+NrgxsUEd1eyn4MussDLtqP?=
 =?iso-8859-1?Q?VONNIeynww85BGZqH7fMNiERxQ/vMqcqzjQ0XY/VZdzajA15SqqZrIODVJ?=
 =?iso-8859-1?Q?ptI0NTe8TUx/Ybz/cfrq2/oa60Z8MDotvCi2h9rtqQBnZ9YU6d7UT2TeUL?=
 =?iso-8859-1?Q?XX9UnhpOWX+furSXO4mJFXCrCln4lTChtEDwQMWInkfaKH6apcnr/8RSbx?=
 =?iso-8859-1?Q?x+mzh7qaN7GfPW0PDxxsYcGRKPdOtQJ5dG+bDp6b7pojnbgQoqbdXRIYMu?=
 =?iso-8859-1?Q?To5LZsChg4d4JTEIfxnzJXm6kNMolvsnf5Jq5P1qS+jWgHWZQQtoynd1cL?=
 =?iso-8859-1?Q?bXp0Htdg1dVhuIqrYNO1AAl1Z+Jobg2M7B051SVnsAbKjHkl7FoDdmfP7H?=
 =?iso-8859-1?Q?5/Lg62M9r4phWgECcn+Ro42kKrNMENrxHHegkAQilFptNWl2Cech1Ia/jx?=
 =?iso-8859-1?Q?JBah65MroV5f92zI7WhefnHANPBQhzHCU0PGXy0HoC6NAZ6XDf04l+RRPQ?=
 =?iso-8859-1?Q?Qsr02v0doLiJ4M1PPeuL96ng7jMRIR/758llGJ2y0LFVB59+n71yUV4K/F?=
 =?iso-8859-1?Q?wsWBpPStT07Msm+RgJTUE/zfez2zjUgB+W8EpuTdQBpugE2pnrCyaJblIq?=
 =?iso-8859-1?Q?AQokhjAIA/q16xxzsDAiehizKjHYFcAbKL/EbXnlQD5uhhlHZJjsQOi1ex?=
 =?iso-8859-1?Q?S8reXoanFIdD42ZpcC4qV2iI2TMMr7VEqJqplYohNGsRpnbTPEfm0i0Z2j?=
 =?iso-8859-1?Q?fiBS9JSOw3Xlikf9Pon7xsD1rgQPCQW3lexp1WZpjQN2DHTId2LuMyd5j7?=
 =?iso-8859-1?Q?Y52/XU67rOGkfEJO6fj53umuY5abxM8byjjbH7mJWk3yHwK/FoYvUfFSCD?=
 =?iso-8859-1?Q?1BMtglweD8nlwmek1qR/WbxAPfi6/R/IgqJssoIcxwcZ4y2ERNhaOAkJKi?=
 =?iso-8859-1?Q?msQtdbKMnhvclMFPkwJY6ac7GTQIjUmcutsZD6WbvXgwmM2tNHyogn6PVW?=
 =?iso-8859-1?Q?RzIa0LqfcTCAvcOfLhHYrwgj8kynOg7Imarmf4elEaSwda2VH0ktpmHBfl?=
 =?iso-8859-1?Q?ITcJrs0bfCX8D9GHwGFEYV920INeBERmWCKSLM+LvDjqv8rcVDdN+Y/gBt?=
 =?iso-8859-1?Q?5mGlsNCnQNBGU2+1yV49s07Kn2Z5vQCVkKkRskccxCZephELRZNBitNodd?=
 =?iso-8859-1?Q?uN6LBngRPS7HKnosHbk9y//UQ7ZzUb2RAVFYs02mkCB1OP2psZNak7xQh6?=
 =?iso-8859-1?Q?nkQKg72EGhhdMjyuXme9oiO0ZnKtRwtyve?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14d0db1-9d1a-44d1-b8bb-08da5dd8873f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:16:19.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/i/Vp97mAqXjZkkmIfCQJLw4YtwYUwTdGguAxzWauFghp8lEkwaMNDUmBOJZlFwF8SAK4GWK8DR3hn3bg6dmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8213
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

Changes since v6: https://lore.kernel.org/lkml/20220629164414.301813-1-viorel.suman@oss.nxp.com/
  * The series updated so that each patch making the conversion removes
    the piece being converted, then finally the patch adding fsl,scu.yaml
    removes the last pieces, as suggested by Krzysztof Kozlowski.
  * Updated ocotp and system-controller node names in the existing DTS
    files

Changes since v5: https://lore.kernel.org/lkml/20220616164303.790379-1-viorel.suman@nxp.com/
  * Updated according to Krzysztof Kozlowski comments

Changes since v4: https://lore.kernel.org/lkml/20220615105834.743045-1-viorel.suman@nxp.com/
  * Missing SoB added

Changes since v3: https://lore.kernel.org/lkml/20220609143423.2839186-1-abel.vesa@nxp.com/
  * Examples included
  * Included Abel's patches fixing thermal zone, keys and power controller names.

Abel Vesa (12):
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

Viorel Suman (3):
  arm64: dts: freescale: imx8qxp: Remove unnecessary clock related
    entries
  arm64: dts: freescale: imx8qxp: Fix the ocotp node name
  arm64: dts: freescale: imx8: Fix the system-controller node name

 .../bindings/arm/freescale/fsl,scu.txt        | 271 ------------------
 .../bindings/clock/fsl,scu-clk.yaml           |  43 +++
 .../devicetree/bindings/firmware/fsl,scu.yaml | 160 +++++++++++
 .../bindings/input/fsl,scu-key.yaml           |  40 +++
 .../bindings/nvmem/fsl,scu-ocotp.yaml         |  56 ++++
 .../bindings/pinctrl/fsl,scu-pinctrl.yaml     |  74 +++++
 .../devicetree/bindings/power/fsl,scu-pd.yaml |  41 +++
 .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  |  31 ++
 .../bindings/thermal/fsl,scu-thermal.yaml     |  38 +++
 .../bindings/watchdog/fsl,scu-wdt.yaml        |  34 +++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi     |   4 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |  12 +-
 12 files changed, 524 insertions(+), 280 deletions(-)
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

