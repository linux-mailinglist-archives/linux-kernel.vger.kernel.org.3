Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474C5560627
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiF2QpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiF2QpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:45:02 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99CE2F3A4;
        Wed, 29 Jun 2022 09:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/PxdZnuu0YdnXoJxDOwyCgD+uRHecC7Ik8hFFGcUdX83I1PpgHp1RVoHgUWkFSGrse/jvWVLmdzBe/l0maNj8mqz1d+S1N/ZEL0dWHXR3I1wKcrO8MFeXTNbVpB4DcqWTES5lTowUulOvMR78zFXDi7YNXFl67e3WuLUySeqQycYWNa7C711o6OfIZj5LCvOhWAJNVw5pNELV4Ta5yVVUSjm1tEdFmn9VFmsAQE6zeQ1AFpFGrSwkOl/UWez3r43hPx2nnUswphHvBCzHtMQN7ioar0Ps4IjFcQVBNY9ayQJwJ3PEcv2nzsYVnB99AxE8ROvsfGfPzHTghq66B89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ES9tKSNACeLdhmjAvUjn2F75Hedxt+9wk37c+RuGxw=;
 b=lyyoA8mMh9GmyOY8nK3vPcgmR4uyEBtqNzg1ZEic8BtpMjBFMrj6ovt3Nc8A9pWG83H+EpRgm8fvMEWH6odDzEGw8ts0e1qWdnAJHRRXF7eysVG2lcHkTNUY5Svbrq8uJmoxSClkPHQEFbD+SEQZg1NmB/mO6SbLELKCiJIgXEx7M+JiV8QsaHJgOg9sDOdvyoDnRQZM/iS150+2dHbGEEi2bYuOUApaBI3ZVB1CsDlUfPc1UhA1pTY4awW96VgKSwVXN+DgDJq/rSfW5XyF9F9Jjc+LN/GSpcdfyloisYu0GWKb6M3sAjjnjcC+CXno6vRXpwTEiaJzm8dKDwhgQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ES9tKSNACeLdhmjAvUjn2F75Hedxt+9wk37c+RuGxw=;
 b=GOSxxbMYzIXiY1QnswK7N3M/F6XTc45YvPqw0aJVvn2c+7xX1s1PXHHpmoOR8sWWPzw8ZM9rkc+Ucr/AVUd0pAGWl7a9uk0K7H66chDsTjHr+H6fsKKy9qFZTfIPnClJZnFejB1hJ9hbmZudxpRcd/PlxekSLl7hDgKBxUMGpCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6401.eurprd04.prod.outlook.com (2603:10a6:208:172::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 16:44:57 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:44:57 +0000
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
Subject: [PATCH v6 00/14] dt-bindings: arm: freescale: Switch fsl,scu from txt to yaml
Date:   Wed, 29 Jun 2022 19:44:00 +0300
Message-Id: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::33) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42548598-b210-44b4-fb1c-08da59eeb2f5
X-MS-TrafficTypeDiagnostic: AM0PR04MB6401:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NOzsBAQHm+Oz7YRDyBC05mxEiEozdKbM/eiWag/npmonXFU/AZC0+MpLm5kFX8Uz4s3esb9h+ZuZgA4xER45k2Sd8oJljrHmNe+zi13wwoopLmqWAYvuS0AHVMqYCxlDip/3B4DOn+P9233qZAinSaOcdJ6UX4FeFCSg7g/kRb/t+7uIGv5hKsb3mReusYv5yKvHGJrPtV9eHV12tk02+KDWQD8wAYEMUFujoPt7QfV+26gW8i49etlxSqbUim0ZtnYtrI5HUH3ZtRxdYjgSMq0FIdczKI6lPHjj3+LyYWkjgapQKJiM4O1Eb3EkG4Na3xM8P/lXe/ITb8Em5tvNZzqGeMLzrRtYAmJnrBEUBxRCRfRIXAGakiwypm40xwbTFnhLwyI8IZi3XhwCnOnU12EWb95eKthyrQ79ma6VXoW/+wRPsZeSphoRn/iS95+Mnrag9AircRrXOyRkul6uA9m9T3zpoD7MXMnmBpgtSfZOY0LhW8nhBfOskZS8CxXyXZsbPXHhL6xDNyi2+Xkr135OFacYz44Nogbe157Br6deOdd7QeJdnaKmExrFyX7yW+doXloIMVViJlo2z7vEp/mmoz74F/S8BbVg2fRFHjuz7wv6kZp3oXW44T9sd4pmymcGAl8uSOnz0MIfhN+N9PlLzX2GgKMROSqw9OFUlB0V9PWT55Ybi8XkvVBo7dhyngNZT0dP4dbriQwobF7CByv2qE4F15/UZLFTsbfLDZEyqkUQyNGkxw2vLa8OQtDmVjpNBVjyS4ZnS5nospxrsl2POnPTBvIjn8XBKN1FX5EpGbZ8cxTfLE3bevZ4yRnaYztx0LPooisVSGN+x2nKTXjhYhPvNPNmvpPGheiY+SCo650Zm0I4QwUq2dEUPXUT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(5660300002)(7416002)(38350700002)(110136005)(38100700002)(8936002)(316002)(2906002)(66946007)(66556008)(66476007)(52116002)(7406005)(8676002)(921005)(83380400001)(6512007)(26005)(6506007)(186003)(2616005)(478600001)(966005)(1076003)(6486002)(6666004)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4pzjhPiagqG4tKOP4bQXlA9MzXUa0fRpA+9byLoF/Lgs57hEAR/DNmzgKN?=
 =?iso-8859-1?Q?Njamn5IQdwN5oOYYSHfJarnyOUrSyAGWy9bMjMA9bBmz1/bUi0QWyARfIT?=
 =?iso-8859-1?Q?NLx14lu2ieoDqQJ5pCE5cBRYC7bhMRIxbZN8bVTtp73BPmhQJubB8LPUrB?=
 =?iso-8859-1?Q?AQFUqJAGl1NF28JZ5aVz3HCjMyOW2Ns1YsVBkVU00Pw20recRJpsxxWrQP?=
 =?iso-8859-1?Q?ISMDwFEyg3WjIypj/57Xd5NVLHxsyGH658nSgXKJqW1fRymhpw2+kHrDs9?=
 =?iso-8859-1?Q?b2NukQYKvSNXCyBYi2jKlIZP4dqU0bq4w1X5f5NwtrmMRt6McQnAVROKTw?=
 =?iso-8859-1?Q?84UjLJQrbrFGBfDToBWEAy/9b9AwykX0KaxPhlrkECoku45fxvuIubTCkT?=
 =?iso-8859-1?Q?pQj5r7IcsapMK2MjWENhEB3Fb65xqX1P3mxLsEVmRuF5eOc6hl1yjCb0NF?=
 =?iso-8859-1?Q?6kyPaLK0n/jiFT4VK4XDP1ilKsAMAwHSJj5lH0aP8IBTQa8YqZv09N3e9y?=
 =?iso-8859-1?Q?dk+Bern47ORvx0sSgTgJoxGm+WZG8xtahivVWpRXiaCspswYga4R+tzhcI?=
 =?iso-8859-1?Q?U+PKAtOQqiKX/rriMlnFlH0Eyb6hyz+VKOyR+TDGIwifEC6Vrk66tNmtH5?=
 =?iso-8859-1?Q?cPYwdaFLadoQVgF2jpuHbu4btG4R9I0bTChhXDTJ46ZWsiGLR1GLzzTuLy?=
 =?iso-8859-1?Q?R6YDczrPvlmh7vO2CFk2TUWUT6nWUk/rXNDbRe0pyq+ddQ95OCEIeH0poy?=
 =?iso-8859-1?Q?GnXRiWfgm9kdst+/028HZw2FE1zJIhTpWRkhvu3T8UJZjp56pYIodgDDTI?=
 =?iso-8859-1?Q?BGTkRqQZF+SjyjHQ8zTJRdxmDgkaXvQnaDspQKFt2P7I3EnPbkWDG03iAa?=
 =?iso-8859-1?Q?wc7pGAiF8ysTjw1RvsJrSY/F5KdjH1aAffG39UWBGzoRcUSTHb55GKj6U0?=
 =?iso-8859-1?Q?LpjrqXQdague5PfxG/LgHbRU32r8ZAVIBn42SIB24bm8zNQa0M/6TMZwlj?=
 =?iso-8859-1?Q?JTq9g8EhSqibKCMrYUaBm9x5ot9vW7QMD85fk/CkWCV+OMGC/zWnm5OySx?=
 =?iso-8859-1?Q?X0uKZ11jTUwxR82PAj8pgjA2bAloL1wOz0cgonGevtSZBt0QuV8d7BRcPX?=
 =?iso-8859-1?Q?hc6zvuKsiTPgXWKSfI5atKGDWGUw8aLbjBcvtYI3Vl96rnPE1RiySeldsn?=
 =?iso-8859-1?Q?Z4eois+0pfohz388NCe00i1T2pUdbj6GGJKQ3mioIZyEzdPzrZKvs6pjgY?=
 =?iso-8859-1?Q?nB7c55iq45i7s9A0mhLZRg72v9cvD6WNBOHm7W35lHcgmkgnCUwLSyht/Y?=
 =?iso-8859-1?Q?DbV62GSNeKmZ/CCSS64OKChRZbXlYf2ZNTuvbzycw1G9VdqJhSl2qSko+x?=
 =?iso-8859-1?Q?1Q5Nc1mVjIA9cknH27QZKR35Op1vg655/d3kRflqDZsuXjQhJPzy8zmFMY?=
 =?iso-8859-1?Q?11Cup4Fg3Gn0DbNu/AzQ/WlUXdBDrIpsz+B2ASzht10UV8g3vzVquDVQdI?=
 =?iso-8859-1?Q?ADNIJrSegp8DSTqXzNCJf45fhjDNlJsyGZm5qOU9VPkonoeeAyWIHSm/6B?=
 =?iso-8859-1?Q?ZihPqUIwe4M4PUZd/nfpSCaq1YfWnPxeidfFbUvlr0cYTU8f1X06J4klaZ?=
 =?iso-8859-1?Q?13ncV16OVVmYjcyrKgh6llnWsTebXLBo4o?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42548598-b210-44b4-fb1c-08da59eeb2f5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:44:56.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vr39LmdUMJ3+daUpFnURe5+vhHJnECJpkGgTCUGsE8eNixvzhiP4IEK+AyqKcsDh8TSQpkkx2g6MyBhWu/HElg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6401
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

Changes since v5: https://lore.kernel.org/lkml/20220616164303.790379-1-viorel.suman@nxp.com/
  * Updated according to Krzysztof Kozlowski comments

Changes since v4: https://lore.kernel.org/lkml/20220615105834.743045-1-viorel.suman@nxp.com/
  * Missing SoB added

Changes since v3: https://lore.kernel.org/lkml/20220609143423.2839186-1-abel.vesa@nxp.com/
  * Examples included
  * Included Abel's patches fixing thermal zone, keys and power controller names.

Abel Vesa (13):
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

Viorel Suman (1):
  arm64: dts: freescale: imx8qxp: Remove unnecessary clock related
    entries

 .../bindings/arm/freescale/fsl,scu.txt        | 271 ------------------
 .../bindings/clock/fsl,scu-clk.yaml           |  43 +++
 .../devicetree/bindings/firmware/fsl,scu.yaml | 160 +++++++++++
 .../bindings/input/fsl,scu-key.yaml           |  40 +++
 .../bindings/nvmem/fsl,scu-ocotp.yaml         |  57 ++++
 .../bindings/pinctrl/fsl,scu-pinctrl.yaml     |  68 +++++
 .../devicetree/bindings/power/fsl,scu-pd.yaml |  41 +++
 .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  |  31 ++
 .../bindings/thermal/fsl,scu-thermal.yaml     |  38 +++
 .../bindings/watchdog/fsl,scu-wdt.yaml        |  34 +++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |   8 +-
 12 files changed, 516 insertions(+), 277 deletions(-)
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

