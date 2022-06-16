Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E8654E810
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378258AbiFPQs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378477AbiFPQsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:48:31 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FC3483AC;
        Thu, 16 Jun 2022 09:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3pF1nFsL73cCnCNLKVqKC+FfUaS+7Dc1BQg9vVC9ufHN4Ha/zNNpsSujCldRwS99fNlxdOCXmFPQcdxEey2EViNT74Y5RelkFEeIxyCJsxlGVUNbZRWBUHZAQzEY9twChZqTTmGhO4uYmtIfZe+yQ3StdvmpDVneVzq9Mp4nYIM3bE8X6TBkq0ZMebn1EysudlQehz7CQSFZldL5Z7IRxZP/H/jSlo6LXNDKNrDhkmoZwDIaAEINw4aADBZGaVdX9diZ4q7kHVLrny44lYURYt3rimpyMykGvc48NeE5qCZzyscEiI0XQkkSAini0mYZF+vB/VxSYHFfz20SNQevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8GLwX1DMh9D0ebaKutVwV0uBbWg3yNF1zumBUrTZ2Y=;
 b=UtZR6VuONtouOR4r/bY2xOYxOBod20ZfaGnFlcMs5APuFb3NlFcASCDvspouKn0wEj72fAAJnzZPDhNuClG3VolfebxHp6i5GX9N73AdRZFm0bn9uKhmwRALwAGFh9aewvbf85eSQI9Z1KhFHAh40bzXhm8fXVzMePnyF0UOSvih+ASj8E6T1tcITHD/Ql8UgfhKR9+bpg6/BxEynmM4gSZ/s7cJD0AtpAgOGu78ppc+cbtT8n9P2y8dZjIVEHLT/xrDi2Zl3GktfMnTb7sGvyIVjTwzOz2x9dzr2rrmlgDs5/5pwLgMOGkrYeuztLvLPEDrynAoyIOsPN3cmIzRIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8GLwX1DMh9D0ebaKutVwV0uBbWg3yNF1zumBUrTZ2Y=;
 b=CY3XOD3nBQYJQ30SmVKNz+NlsStYfM4t170NKPZ8JYgE5YjwR9UUZowWFZGbyWBbWs1HEmDqYjRKby5PVFGyxOwg7ASJLqobMhq8YPq8OORX2dbhiEJGV3rMWwlaeEoJGbBvEzizm1qeaYFjQSoYUavNOSwi16OILVvTd3ZsxqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM8PR04MB7939.eurprd04.prod.outlook.com (2603:10a6:20b:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Thu, 16 Jun
 2022 16:48:25 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:48:25 +0000
Date:   Thu, 16 Jun 2022 19:48:13 +0300
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
Subject: Re: [PATCH v4 00/14] dt-bindings: arm: freescale: Switch fsl,scu
 from txt to yaml
Message-ID: <20220616164813.jf6og7d4wf25xx4w@fsr-ub1664-116>
References: <20220615105834.743045-1-viorel.suman@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615105834.743045-1-viorel.suman@nxp.com>
X-ClientProxiedBy: AM0PR03CA0098.eurprd03.prod.outlook.com
 (2603:10a6:208:69::39) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd4a935e-9266-4210-f257-08da4fb807ca
X-MS-TrafficTypeDiagnostic: AM8PR04MB7939:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM8PR04MB793934D2FEDE7F3DD89A3BCD92AC9@AM8PR04MB7939.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZhMPZyWJlyqkWiASHjXLA0cfVnaseDcGiafRe8C7RMoR+VODqWrdAZ4qNZAXFIZ4p9BIy1lg0wxUYeY0HKQhS3pMWRyLPFrxd/B8sxpKhjoQNkMktKdhi3CtrDWluMWW/dt1jq78IwxizYkLQXAy/yD8FjMk6XZl6nzog4IO1Yrob/tEOvDiSW6BGTsI1KCgznDIoOAHoCaGkK4hSzMCh57Bu33/72ylT+5AOLAEl9XQXW7tatdzwlLAoMr7pmu2xAD3d9IBN2CfCGvJj0odGkFwcICelLtfc7IJf0YNsTefQTZCWAdgbHVKKVgWgvgNW60dZtDR+66udBrRVQ1cdHwl/KA+E4qZcVUTU/TUgjmx91kI+V70jogUFTaCUogGlXjO4xO5x9sVbT1cusDvaqN9CjG0dHyi4mL5Oiax75ujW9rPJjENrbJ/bEg89akvVCHheJsutkxdMUv+EmLKxN797iYbpoPjJA0mi+3LDGsjbt6ZRBW08kyLevRD01/fPH4OfbZsqLx9wfZXSMomEY8HUGBrdAnfV0IFWvl26C0KLjrqosPuKUgroi0U7hZpptQ8TmGDIZXqbKxjcHGRAoBCphgCCKdqSyKRBeI89TbSe+wzbylR/3dYBecGYSGfRwOUGNJsOrfB8Uxr/zGuO18Uox+J3nHRVw6fBXTNKjvzFXYzViO7U3pVx1ii1GuAuksSTelUtwDGUIawmCDgaKLYXZcWDFEkfpRw1Tf355P2EYtF5g/gcyUJ+gYJT88BzfbipTBGkVYEJarXrwLUmie2n60DLj0iraF7ebBUvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(38100700002)(186003)(38350700002)(1076003)(921005)(86362001)(33716001)(83380400001)(8936002)(316002)(8676002)(110136005)(66946007)(4326008)(66476007)(66556008)(26005)(6486002)(966005)(5660300002)(52116002)(6506007)(53546011)(6512007)(44832011)(508600001)(6666004)(9686003)(2906002)(7406005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AzkXtBI48EgDzpE/JJvxYCzZM4sjGdzdBQ8hsgAbFfHYnIJEooLjqOle0xja?=
 =?us-ascii?Q?+OI/FLb3lUvB338I22+gq5LYZlLZBCUf1Hk2oorsXafGJZqhyopVKWjP0bET?=
 =?us-ascii?Q?WCOQHMzoh+1qmGU/dOPB+0VszgXqD1NJpibuctU3lVslS35EOJOFNwduRIgG?=
 =?us-ascii?Q?SRHVGX9mMnLVW30IHOz3MuUQ6s/S5zAFBtHjDouJ9/ZUqWU+vSw9wxtq0D+q?=
 =?us-ascii?Q?GIFJvCm4OaE7AB5tLiu2Smu9vu+Cg2ulQ7BQcQrjXw6gxFj1Y6tMic70WLzi?=
 =?us-ascii?Q?Dw90u6Zkc5Wf3aNOFVgGWGS9P/OUE8mB4NzywYHAjX6CS4jIv3YB82vsTgmS?=
 =?us-ascii?Q?ohbAtg9hDInm8z696/EILwky6IVQ/zKedVZUoKI8e03dqj5ZcvjT6dwrlVTL?=
 =?us-ascii?Q?d+enNyowkr1PEzZQntN4O/UX9X1CFLEfXNxgRolC1bqfMUEcanLv1kMCA7DV?=
 =?us-ascii?Q?WEYJ0dxpyvcoDa+4GBsnQoK+fibxh0afhSHIYPY+ydZTerhiaW6Tlo+v7R1i?=
 =?us-ascii?Q?HBFx7/BlzjlAe7H5x5qBat8SktNBJJjBlbs8mPAT958vqIugOOim+J1eYLwk?=
 =?us-ascii?Q?XX3VQ5eeJ79XIc6k8l1QDF5u8nKkZrWhRd5J6jZcFxLdlzzg2YYaKcj6bg3h?=
 =?us-ascii?Q?w5XY1C19OhcCTi3lMp3IgibJyfdGgOVaK+kmat11zJgzzRo7v+chU8PxdUTN?=
 =?us-ascii?Q?blOsWOsiVWV1TNKVOEDSUWBJjhmp4C8zZrNtGGg2YONlQuKy9YHeX4FziFeJ?=
 =?us-ascii?Q?c0nNv7NcksD0imi1bp5tpHqekKwMql85GCVZ3mbSK5YVcZU4VrJ9dez7GRn5?=
 =?us-ascii?Q?lnAKH353VxUcyf1gHa34++p0hQSEdPnzJQ2Nul+fM2gzQX+erYhmFvGeuGIy?=
 =?us-ascii?Q?h9MFQjX73Lz8DEGkreJSvb2Hxt2JN8sBHoLkTAzLz9/gTFgEIACg+wLcRbN+?=
 =?us-ascii?Q?kkIB7kkEZOccXtI/2uY1ok01VF8Nfnh+7Dzn+3jptpylWO26bLn04VGi+HWJ?=
 =?us-ascii?Q?LCEqD9x6CHT1quSSJwZOIOiuLVPouOA9kmQl5muC7WORMnrnKe3Fu8LmuTvU?=
 =?us-ascii?Q?/epKc3iWH/9+QI4JJv+eQwQANk7KJap5S6Vp6nkmYTLP5muV/dFnV8p4Tiit?=
 =?us-ascii?Q?Ux3weJ913JLG352FX9NnKYgV+taSyUMntx24PgD8OwHfXZ+uWWvplI4uTn1Z?=
 =?us-ascii?Q?NzRje0/IDkrOPlWcAmwuMCPkqf4TdB2/yfKzfBzt7FfTofgzDzl5BJKK2r3w?=
 =?us-ascii?Q?selfy+W1xQkLI0gvxJbVSy8BaUMF3LPUPpFl2lqSnfWWKAmw19INVhkmOh4C?=
 =?us-ascii?Q?wIUz19x2TxlRKeemHFvtrrQTgyvyKJyZlgaKs1nEYCV+WqEdhGV8Gou1Gtr/?=
 =?us-ascii?Q?DccPyqrmBI+Q89zFPXDqB5M3UkAl1Jtgv253K6XxkukbzVfW2iWr3yha9avB?=
 =?us-ascii?Q?I4RvF2M3PX5UzY6ph+ZO9Gwz4a2p7yRZ8LQrEI7fD7gJlCiu8i402r4dZy6o?=
 =?us-ascii?Q?9lkRWKpXAKusHrA4r41J4HInLFQA5lhD+V9Y9OdhSP4o/FG2ATF07ohnFlhf?=
 =?us-ascii?Q?3aWVxPgqXM0xMio+emf0obk842NtfArz0JQBvpaiPu6ssbzgOWTxhnPRA3no?=
 =?us-ascii?Q?s5hjO98OfGVGL38omcHd2IEDcHp8Xm517CrJY8U22eVXNOOnHFhrgx9cXyzt?=
 =?us-ascii?Q?zeGVpGpQvKuJGeKraqzdxpz9D7ZoQLPUs15kFL6ENUEM4/vo4ua8J4lArfbN?=
 =?us-ascii?Q?kue2f5uIRw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4a935e-9266-4210-f257-08da4fb807ca
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:48:25.2632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6F8yQ9XSRHwbhApbCcRQ0p63k+fGOW8o/EKFbSIQ/HPEIEK6G7fz6rvCATbo2TF9Y+tDjRm77hgpryIi9+v2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7939
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All, please ignore this patchset. Sent V5 for review.

Thanks,
Viorel

On 22-06-15 13:58:20, Viorel Suman wrote:
> Here is the v3:
>   https://lore.kernel.org/lkml/20220609143423.2839186-1-abel.vesa@nxp.com/
> 
> Changes since v3:
>   * Examples included
>   * Included Abel's patches fixing thermal zone, keys and power controller names.
> 
> Abel Vesa (14):
>   arm64: dts: freescale: imx8qxp: Fix thermal zone name for cpu0
>   dt-bindings: clk: imx: Add fsl,scu-clk yaml file
>   dt-bindings: pinctrl: imx: Add fsl,scu-iomux yaml file
>   dt-bindings: input: Add fsl,scu-key yaml file
>   dt-bindings: nvmem: Add fsl,scu-ocotp yaml file
>   dt-bindings: power: Add fsl,scu-pd yaml file
>   dt-bindings: rtc: Add fsl,scu-rtc yaml file
>   dt-bindings: thermal: Add fsl,scu-thermal yaml file
>   dt-bindings: watchdog: Add fsl,scu-wdt yaml file
>   dt-bindings: firmware: Add fsl,scu yaml file
>   arm64: dts: freescale: imx8: Fix power controller name
>   arm64: dts: freescale: imx8qxp: Add fallback compatible for clock
>     controller
>   arm64: dts: freescale: imx8qxp: Fix the keys node name
>   dt-bindings: arm: freescale: Remove fsl,scu txt file
> 
>  .../bindings/arm/freescale/fsl,scu.txt        | 271 ------------------
>  .../bindings/clock/fsl,scu-clk.yaml           |  58 ++++
>  .../devicetree/bindings/firmware/fsl,scu.yaml | 170 +++++++++++
>  .../bindings/input/fsl,scu-key.yaml           |  39 +++
>  .../bindings/nvmem/fsl,scu-ocotp.yaml         |  49 ++++
>  .../bindings/pinctrl/fsl,scu-pinctrl.yaml     |  47 +++
>  .../devicetree/bindings/power/fsl,scu-pd.yaml |  41 +++
>  .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  |  28 ++
>  .../bindings/thermal/fsl,scu-thermal.yaml     |  38 +++
>  .../bindings/watchdog/fsl,scu-wdt.yaml        |  35 +++
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi     |   2 +-
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |   8 +-
>  12 files changed, 510 insertions(+), 276 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/firmware/fsl,scu.yaml
>  create mode 100644 Documentation/devicetree/bindings/input/fsl,scu-key.yaml
>  create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
>  create mode 100644 Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
>  create mode 100644 Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
>  create mode 100644 Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
>  create mode 100644 Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
> 
> -- 
> 2.25.1
> 
