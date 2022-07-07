Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8701756A25E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiGGMu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiGGMuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:50:54 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCB92BB11;
        Thu,  7 Jul 2022 05:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ob65cDvmTjAt5lYJ7ElQnCr41wlWx+KHf9390sfzZBhKkYK5ElI85LE+Fwu9ObdzE/rFY/ctfAcqOIDAmhW54znZ9nkiDMc5Mxd8682JSI7j/Zlb4BEKyPcNJFqhBgWe9xANpqh5PHuHi5gMWvpMkTn/oT8r711ePlSz3K9yzCKKJzxvi7fzHR9dwhceDVHZF9j/PXhMGh8BtxvFEtKqfUt61tCrrxMl5PFr4k5M28hajFFLvIJ8+XLyLNGIGeMqgv0MESdUzSm5z2KZfZJauQas2qVLOQQ/TUbdN5omT2baycj22joPHSXfIXippIzwrf0O/OUqtYeT/gsgbjDiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFL26jaC0mDaNwHponh0VpQIq4I6lMPZoPIuLQN/HaQ=;
 b=NninBTvfPsGJUoJIsqQZeAhLSjr4S5NhICbhp/E3EvhVcWgBGs67M/kIYyzdS8sivOc4bl+hrYVt/gZyGdSnz7YTgDV+fWqgnCOvrXhPHOsarki3+EmitkGKHfX0uMo+5Q3/MAImNK27m9K0/aFwf3L8emtu5gBNxf8/T5vQ5ND5pA5a/pMGhv0Uu3A8nMxkC5qqlKVvoqA8T7TGw7iF8DpIZmI97Cmao5j6hMrhkA6PrUnp1TqGWQL63lN92ejG+1FqAWAvq2hd61KX0B07LcitpbFv92wZwkWgKR/k9UZ2Zw/KvUMl/YSYvH79ySweNgBV1GwzqOiAibxhH0T7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFL26jaC0mDaNwHponh0VpQIq4I6lMPZoPIuLQN/HaQ=;
 b=XSgeaQvK1kWFE4WtK/a4UUjLWX41V/0HVHsv9yL7A6rZrujZRYWHgf1n34bGldXU+szhL0sP3aYSsT/iU0nuwZQgP/1xOrdCfA1+Z6eG8bjBmdLE4URDPsZd2fYVBN0iE19TKyAtTXteGDQNUM3LoyRa0xC/Aa5l5xgpNO9uhPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6418.eurprd04.prod.outlook.com (2603:10a6:208:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 12:50:49 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:50:49 +0000
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
Subject: [PATCH v8 00/15] dt-bindings: arm: freescale: Switch fsl,scu from txt to yaml
Date:   Thu,  7 Jul 2022 15:50:07 +0300
Message-Id: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::31) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecf6893f-3574-4b14-736a-08da60175128
X-MS-TrafficTypeDiagnostic: AM0PR04MB6418:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxVzHycaNY9Tket7hLcAZ9lLsY0+Lj5OdJkWAqDuEusvqHYI23gkwPCjglKHvpNPYevEnJsuDHVglorwjKj5QMn8arM9Ixzowo2PfVK6xMrJhY8xEiYLrQCuAajAql6ZLY1RdrIGc+GATMcYPeDT5OR3+lgVyeEsVGInQ0mMyOHvvY2XDiptJCsNUd9xUgu3ugG3OOA/XXlHM+Llkb1Jz5TrKkW9afoZixfLLJULbKCdSX3JxwE3ok+bQ3Oqh/FUBM7vzTBoZQGKmuOSJgqUiCJAyUMMbvUfYnl4gVeTrUpNReaWrvvYv1z7gly4f3Z8XniEuFs3OnioP2Hu1+Grea6vQAg8zxizTWONAXBPYN0vIipab4MYENwGkGRXTngcfU+tdygi3p8QgQ90GYulfmHojOqL2Pzv78oszdKZ4CUD/dMJiJ8IFsR9PJq4Uu5gEEdmLDQeEN3dCMu1fV/FZJ6GwraWIu3+KSftfD0J7JuXfNFzhSe/K67Ftphvnsse0AKXCkoMrmtOgKUzKZvMDPmxDYvy7YkoC54Y0+Ieu6lm1LbNtB48/l77N84I+KWkAxsr0X8XWACL0CdLTEUEhb2Yil7i8EHE/Ntu0afUMo5RK31qEiCZOj+sHMvPbD3lgi4BTmFV1WcVsOYMJC6FMv3LvxQDYQP2aNLIkAEa/zX1RIRGbIG6ZVHJRa4YtPnKQqj2ELBJKC0BCshLrlWJpvK5RGmJzs5Npf3U8GkoGv/ebJy9HZNOpUPF2dm5zmEZa8q5FNSwiwO6iJrPj3ELMJGLZ/Aox9c2OmDQA/T49m1hD8EcDlALWzf/YQdNhfuAJw3YPLnixIbuXogW9P2HWu83erTJmj0JrtSMB+sQpR3hPkx4jbowWvSwBzuKKlOSiz2rzrP66GHz+FLSxuZ75g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(6666004)(86362001)(5660300002)(966005)(38350700002)(6486002)(316002)(38100700002)(2906002)(41300700001)(7416002)(478600001)(921005)(7406005)(66946007)(66476007)(6512007)(66556008)(8676002)(4326008)(8936002)(186003)(52116002)(83380400001)(26005)(110136005)(2616005)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YKlqU+OGmXDosSzBQHyDXVEnqyfJw+FRem9dH9tuY2j+IgsEYFci61JbkR?=
 =?iso-8859-1?Q?VIYAxlNVi7iVkUh/WgaWa96s14Cf9Zo/cGYO7WtaOMBN+qIkEAjdlOAhEB?=
 =?iso-8859-1?Q?GdAVBLq5Kqqlmv/CRaHAg4IgYDY+W1TGhwyihUksReg15aoQn+OgGra9eb?=
 =?iso-8859-1?Q?a35cuy3DgaqgeMICO09FtJ2NqgySfHb3I8xkCYPzAE+TJ3fXROX/uHCHQi?=
 =?iso-8859-1?Q?x7s6IFI0/q0wcRWOAnSQo6FMfySjl5pCnmiSl+K6Y4PAWV1cFrlKQf8A99?=
 =?iso-8859-1?Q?5R6GN8EV3yzjMLnj/OMOlyMv7XjmVzPH2wvOjTzpz/o98J569p662ssiOO?=
 =?iso-8859-1?Q?WxdDmh6FIbW87fve4GY2kiXCaOoaKtErcEU4BosbMyMWu67FuaHOpl14vr?=
 =?iso-8859-1?Q?0fvm7ceVP1yPMYMgXr8P4RhgiZmuPEg6ypZzvmFSpxhZZRDjGY7n0giTIf?=
 =?iso-8859-1?Q?ZNqoLObnrpE8beDY/I70E0TtWSCEozfcYpZRmuiY8MelFLgwKaSFxNKwQC?=
 =?iso-8859-1?Q?RCs9aAVvvI28v9BZDyg/73PTqokzs3DVYkqPHFR1NZeXi1JyJYPeEl/4PQ?=
 =?iso-8859-1?Q?O1PfvjPhSWj+ilbN8FEin4beLDqAZn3C9v5zEh4SzwCzPCsaRflWXaxrtL?=
 =?iso-8859-1?Q?Whfhe9up8+VnpI/1tBX2fu8ffcs4YkrJ+3iaxOPGwRiQnzy1ljyW9eGlcQ?=
 =?iso-8859-1?Q?y00+TyhwSafsHN+EaFvb1s9dSGz69mTuG3ZwBYiqm/ml69epWNTq8Hxrae?=
 =?iso-8859-1?Q?SwDw48GN74Af3dxSyOIGcO0Cy4kcO6I5oXJKhmvWigBCiX5DUXJi/2GBjk?=
 =?iso-8859-1?Q?vZ19S/B+91YCHiwsLpQs/LthhRBEWw0v96vaS+hMxFlCKL22wZqxZBwy77?=
 =?iso-8859-1?Q?oOZ9yoF470loZY4Q44zB0VD/9qCPYT54+ktUBUvuYX6fxBCUUAk6hkUnOz?=
 =?iso-8859-1?Q?YU8/oATPGvGhMIPJ9IFnhrpYdHc7I3ST38uRF7aMzU+ASTgEAMvWYKyiT7?=
 =?iso-8859-1?Q?dvLcQRvbIJloiqqGx9jwq+HRfnnCmKhz1lhwvmuhh+pGrWaBhUExPLUixP?=
 =?iso-8859-1?Q?ySEGoGvhkx8V3Bdn/pnfWFowXvYjWnvyg6sos3vHwcGy/o89Z8EJBkaCB5?=
 =?iso-8859-1?Q?qpBSuM+pZiU/PQ/D8+LT6LHGymNlqLBjyXqF1P/wjiWb4xJViQuvPXu3+s?=
 =?iso-8859-1?Q?o36yaRHis5ptZ9eMCT1Czyo79F144H4Z7uyazHumlFtMWe+IyPlANZSyJk?=
 =?iso-8859-1?Q?nfSUKtX3L/fzCQQ5wr7wF7jP5ukaKscaNSsisB74ow5ficgJPbWwiwA1gT?=
 =?iso-8859-1?Q?t+1yzSuInqSVI9MSPQdi2p5jlkRNfq2ryywABv7jWZtI+L/2X9s2h1n5Yo?=
 =?iso-8859-1?Q?639bHv+viRm0NWqVS8SFp6vzODQVmg8LF2xkdDEJH+zqrZZQqFyVgeoQ25?=
 =?iso-8859-1?Q?uJkpRgKwTFPALYc3nRjWGEM8YJdl2r7Jalb4ZvoFlO6cBewkVjt/BIC5Qi?=
 =?iso-8859-1?Q?nXMIHMXItR/gNIgM3Tnv0lMBxYbuF/s9wD7lQq0RRr1865QT8/45vhomc/?=
 =?iso-8859-1?Q?EdTmBG8sb2Aq/GS76lGJANhJ5e5P1clvHHcXRIN4uaVEefs6fa2T9v4g+i?=
 =?iso-8859-1?Q?z/X1nwoT5lW33vTyry0iup51cFnkdLfpjQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf6893f-3574-4b14-736a-08da60175128
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:50:49.1122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfJSMzYpf1bupjC1F9ZdEGors5XcZYRMw/2t3kECyELOZ8HzJfT+0iSGLwUMasqgD19Z16c8kaZjLzvtOnKBSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6418
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

Changes since v7: https://lore.kernel.org/lkml/20220704161541.943696-1-viorel.suman@oss.nxp.com/
  * added missing Reviewed-By: 
  * Defined "mboxes" and "mbox-names" sections in scu-key.yaml as schema.

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
 .../devicetree/bindings/firmware/fsl,scu.yaml | 210 ++++++++++++++
 .../bindings/input/fsl,scu-key.yaml           |  40 +++
 .../bindings/nvmem/fsl,scu-ocotp.yaml         |  56 ++++
 .../bindings/pinctrl/fsl,scu-pinctrl.yaml     |  74 +++++
 .../devicetree/bindings/power/fsl,scu-pd.yaml |  41 +++
 .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  |  31 ++
 .../bindings/thermal/fsl,scu-thermal.yaml     |  38 +++
 .../bindings/watchdog/fsl,scu-wdt.yaml        |  34 +++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi     |   4 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |  12 +-
 12 files changed, 574 insertions(+), 280 deletions(-)
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

