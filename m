Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE6D54C6C6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347512AbiFOLAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348682AbiFOK7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:59:19 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10045.outbound.protection.outlook.com [40.107.1.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0939351E56;
        Wed, 15 Jun 2022 03:59:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwoB/w3QKhV8md6qpvC6+5Nfb2l9vKsB+VuzP+lT9OpVCWudoaZ9FTTn1PtFdN7oHYcxMedLwWFQ09iJScOQ8/1O8WTEQYz9iG2TvPyLdPlQfPtTz9GRmqJjPrPNxmyoqAbqNC3qcejcpyThLu3XLeiAqzsgBiqMLTHXoLzCgxebEasZ5HFPtaRrQRL6YpuLUt6f932toYpPqJpaOFfPr+WZKdb6NxCXpIYB7YIE93qqgXqUN4yh8xoikuLyBd3rTzv9UVcey78n2HRBkBZoDQprcrQs828dNIIEuPysQRTI0BTDOx4YeTEILEQhPtlhiMpHBw5/P7p8YixxhfvSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yodX5fD3JvTU/tfcp8JwhxT0yehhXXM/g1Wl3LHcr70=;
 b=CRX++ILwsSOfhyT4c7rEIyQPFIyrjxqncIopzHbkHWKt+t7zJSpTxkj8Rjuuvt6HNHjYhLlw/Bt7ssu7RYB8KgltacStrHbFpdivIrBZmBS9JklqwfTt7/EzYeTRGrUnAGMHD26XEE4Y45sl8c7xpJRZpxGK4qJOWz1LJMl2JwXllSsbwI3cDyYG5pN7Xc7uJ4ClW2oHLOtilYsbgt2XD/BeQFJxdlT5wJpdK/cSTmjcvkxiq92fwAUdkhlgGhSpW+/c/GTcMpmT5RhI0Sgm5NcNNS9hjgfQ5jYD9dd4mY3irMElIem116cCuz/mkgLmTwy9xU2aJ9uD3CF/o/pDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yodX5fD3JvTU/tfcp8JwhxT0yehhXXM/g1Wl3LHcr70=;
 b=MlINUrxpqPT84NwPR92dnU2Zkn8lDZJwkNnnytqYjEpAc6Vq/AQB84b44EkcwO1hMb1uq3R5Y1i203pJwwn7caxdBYbuWALmWlIA95/WVEsKWlMUqW5kJmlcoJl+99ZsuL0zpCiF20UNgK/YRo0z4wGwyv8RUy+IPgCzoIT1Z8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR0402MB3939.eurprd04.prod.outlook.com (2603:10a6:208:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.23; Wed, 15 Jun
 2022 10:59:15 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 10:59:15 +0000
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
        Abel Vesa <abel.vesa@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Peng Fan <peng.fan@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     LnxNXP@nxp.com
Subject: [PATCH v4 00/14] dt-bindings: arm: freescale: Switch fsl,scu from txt to yaml
Date:   Wed, 15 Jun 2022 13:58:20 +0300
Message-Id: <20220615105834.743045-1-viorel.suman@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0159.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::26) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af110a09-b919-4a2f-4aec-08da4ebe161a
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3939:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3939157971D1AE817BF6EE3992AD9@AM0PR0402MB3939.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJpBFoQDYpeWFqauJosZovu61aJuutkPSLZo1s2w2oDqKas0p5nQUjrq1th41SVS9cQJ/3oxau6IJhA0HmsFSRMSp7mXaLZr3THuY+67SEP7X3gRrEiHDDnoRonZ01Dj4AKh7cU+HxHUCU4Ai0yIkmkRe+SruUWtF1KMng4oSLpbulWkQhYoajNJ72z0c6eGBo4PL8sOiz6+werYdRDY8YWHHN1nwAd8rHg8pgE9QJBqx2MJzlyVy/1k6qTmqfhaqoJ4abcdjjqOl5GGJS7dkTg/lu7cFtKyLhrEARcM6kymtx0Rultcwbcj5QHduNprmAowPETAEFXASrlTqmp/w9gpnNixH9MJ/3pC+PTm44GYz/8CYkq5KAEO/vOAxHJLmcmUvEDchpj/RnKC4PssNTnyLzdTqKAv1r6EgvpkJ01XgOEKbRijBdyi66D2rGjVI7jXwficgFSHym5qHfmCrXvB5po/I1cdn6izClbs0JAodvBnFqPAC15so5N4wznrleJWZcCRV7by9cZkK7qEkiuoIw3Ba/C3MjaFYpjpngVTg09aFH39/ZO6ovGGXT9oqhdGIVkev9gN+1+Q5LLtpG9CbxJ/Uy5l30wyOTz2Mzy8TWoMRIkFXtO9kasccbj9wOpzNqZJYflaNtHXxXO9rtC6nD/g4UzMqxtPOdw2GiP/h2YCFdLbNGAyaZAK31j/EtizBV69AyH0q0rTSr9av8r0dIixtTP94rCDo0d28HfigYW3SrM5wkUc0AFIyjw4RnGcmWSSXrt75byyjQuboQXuNC9YVaizV9COAHRwQCW9y4rkXbFK1bJx35Mk2vxg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(4326008)(66556008)(66476007)(66946007)(8676002)(316002)(1076003)(2616005)(8936002)(26005)(6486002)(38100700002)(966005)(6512007)(508600001)(6666004)(38350700002)(6506007)(52116002)(86362001)(5660300002)(83380400001)(110136005)(921005)(2906002)(7406005)(7416002)(186003)(44832011)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZpKWIVth82fWWYG2tC1dCrqkjX6oRE3ndM/1hPzz50gpGLKBWOyboNawmy?=
 =?iso-8859-1?Q?mjX7jl5SPK7FNax66D61ivLY+PiM/0mg7JUeOJU9Roa6dU5OmUSmJxi87+?=
 =?iso-8859-1?Q?z3vgiCRyQJAT7BQNTbnlmH2fHwhRme9Rtk4PJ4hpb3gMRCqdXch+eY2fTu?=
 =?iso-8859-1?Q?cJPQCiAbvzwx/AGu8t5KtmCH6Xq+us8ydMw6RhpY+tpUpmBgEnV+j5am14?=
 =?iso-8859-1?Q?zC0ZQOe6ad5vrYPCNqC8yEgF3GFVLE6lIzV2/3snu3Q32P6un2HvaG47Eu?=
 =?iso-8859-1?Q?5gDQkkIHXeh2jtj59+609rdYZUhKVtrxl9N1uTLgmV9pR19u2L6OCXP9wA?=
 =?iso-8859-1?Q?3c4o1MxhpT36e3XaFVBtw4dMzUICBHjLQPti/fvBSDgvn2dVdFSu2Sk1Am?=
 =?iso-8859-1?Q?Oz/uO91esUQb6OoMlJNC/p0ygqsJLtH0K4sdu/SWEB30+PIBBHRp80zr2x?=
 =?iso-8859-1?Q?7ZEbAvxJwUtSx+LiRAtZczTX090EOfLccIwwCIMYG2MvDWKQFRLEFjEhOp?=
 =?iso-8859-1?Q?ot16E9p+diNfZ1KCMuGzZKUXHg6Jf7ixzPebrLlvPvjou2UsD8sAQL+CbJ?=
 =?iso-8859-1?Q?qLlI0EgTlK3lAvQlGcLRlT6sbtMqEcMEls4DdKHnL3yApUmlqUy+/F7ldz?=
 =?iso-8859-1?Q?K24hM0FQsyZWDqGV3B3kivMymAb+7L0OqIlVIEVh8M0gQCL3G7v6zpImt2?=
 =?iso-8859-1?Q?GOeYgEprqTFLIox8CMaNdewzycAlHWUcVtLI8+v6QtIzLFBcQZdC6T9F9D?=
 =?iso-8859-1?Q?3/q+DfXX2+D89qL4tCB7TDLnTd9DOwrfvr2Y/rEf1Xe+AyTQ4LILwpPop8?=
 =?iso-8859-1?Q?qQZ7g4PAEhUfQdBeAXBieydYuaKjF+n6S+O6ZNUNsXy8Jlcb4dgkjtbkMD?=
 =?iso-8859-1?Q?BiAMt4v+L/4LADyfWsmfpU8iEQvuErZqqBicwO6BtrWX2aRW3p0KHANE2N?=
 =?iso-8859-1?Q?f4L9px6mYkuu6LrnhaRr2kr5CGrmgny7eYxXDXiVTgE5bv2HE872KjayOQ?=
 =?iso-8859-1?Q?MeODsv2w22RQ3eYLweQgO02YZcW8eMVSKMEGZvrRAycy/mzXtiTKuA8+hU?=
 =?iso-8859-1?Q?XAnFt21kbR6Me+uzUoM7jqKIcRGsBwiepQajUImOEY5rpx2zoEjEiLAHqD?=
 =?iso-8859-1?Q?wxJvBKdPNyihfJ9er/Gifzh0IN8Ua9pKmy9cQvusK/nVpo7ySq51GgB+Cg?=
 =?iso-8859-1?Q?LkMNziODGmc+g7y55Ea7+H2yWttYTbVYafQUbMWuJRq8ZiilYISKudj2m2?=
 =?iso-8859-1?Q?UkGiukkZsP2YZRM5RYOZXQwoR+KqE21WVUQuLnR8vUkfSTAj5mDftKpa02?=
 =?iso-8859-1?Q?HXxQ1cGdynb5QiQ41IPMsOz8J7CJlDT+oAFb9+af3SThk1luTUCSHuznBf?=
 =?iso-8859-1?Q?hcH/LCMKfTPYBE3Rt+sUasdVrRfcdOUp4RvqhDBiYCl1kjD/zt50XwTvxV?=
 =?iso-8859-1?Q?FwReH2cwiUDgxwladwXjEKAvJ2JzMLAgeYUezXKxkMQ5dOvDReD3znDmR2?=
 =?iso-8859-1?Q?6rPiWCACHW/pjTJRVN8OIilKXcmEPv5IHJCk0l+1uwiq+jpU64OK2ciX35?=
 =?iso-8859-1?Q?3xyJyg6F9Uar5rydZ5RluaslQinWuWW7D1j53KO9mk+OCUCd1rZm3yv6t/?=
 =?iso-8859-1?Q?9QjN67/JbWrEttWsJMzFityweEUUMCzVS2RwzTyCZ3khSyGtOz6bgXQcYA?=
 =?iso-8859-1?Q?OoJAgITiocEIWwRvf53Wj/wB24U1C9nK08YUNk51Bk7V6u39dyHwozkBAT?=
 =?iso-8859-1?Q?Zd6ghgKm0ynsRn91zDeOP3LiAe9EFgVp/sYFZLONz6glAewLA2p1LpDtMq?=
 =?iso-8859-1?Q?nbW1bJ9aKw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af110a09-b919-4a2f-4aec-08da4ebe161a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 10:59:14.9952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HobKTj9eu3Se+csxHA7+1JamPFEsE8qcH4x1lqDwjbyLwO5RRT10z15zh5anq1LT7tkUZIs53YMiFlinaEVViw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3939
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the v3:
  https://lore.kernel.org/lkml/20220609143423.2839186-1-abel.vesa@nxp.com/

Changes since v3:
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

