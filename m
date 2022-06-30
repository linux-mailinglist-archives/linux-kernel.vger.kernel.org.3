Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B07556236F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbiF3TsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbiF3TsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:48:24 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60073.outbound.protection.outlook.com [40.107.6.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C4818361;
        Thu, 30 Jun 2022 12:48:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jmj3kNoIhAHUtI4Tpq+C/AqWDEJkERNN9Lq4EfnRf/ySyPOyCdFYu431oX4lFWBwDE8iP1VXGfAoQK6HS+cTWZKg1/FvEJkdKYF5nGqXW2oZOP+C78z3vlfe8qN4JY8x79fqdirNJevQEeH/SxLixwJaK2l1mNt57PwWlttla8xxxEDfIpzkC6ssrxPhnLHvpye7sggx5BJ6BZvWOW4qANf8wrnGPQHKwznVxUKdwQlhkSufoRt4FXrnhfyIkguUX6wW+HxPZPVDwRHYNoYeiYELYDwLMD7LuJWxxHbSve+5FktFJdyKg3QniaeKFskjlTcu0QbpzuAtbO0a8ZN9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXX11JFzO/TcGM5yLVqfqcAY9R41AjkPlIcbJBX/nbU=;
 b=dmh1/xq4RYn+0+u3qghP6PjPeItmg2w0fw9Lc3BeSMjM/cs4P0p6VMpJTkDuArbs76eHhNoz2KQTmOjv8sxKyjCKHooqyxM/ciMWltvKhOTg5AL0rlbVYGoWny3OgQr6IAA5UyMemYANUqsT5VnTaQb/01Hsc6tCbe6C9CAsz0W4bEQjS1JiHYqzv4ySFlx2XI6SWJx5d26U4MwBwUSpAYaRgMYTfR92ZKF93OdaQ+/RBgIliku2CaMJO4H5RmMKizEVJMmvZQ7GDfSaIRIEevXXJEdTUvqV3PK8eFwAdf38KGb/GcH+OSUV1hlN88YMMrIg3opsw9CmRBtKvb+03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXX11JFzO/TcGM5yLVqfqcAY9R41AjkPlIcbJBX/nbU=;
 b=UCVJirw4ONO0kPXpnH72IZncpKv+vrtdtSeKUr/HEQtRCaKujixYSQ3p9MuBee9+XQ5jKO/cYANIFjDfNModWasB5YD0OVvrjljZcRbUoKYbGf+YqqIsKcLhotEPXWDHQQGlISkXmIo9QSVlctYeTUaaavI1bcJ82RnQdm0mBOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB3PR0402MB3689.eurprd04.prod.outlook.com (2603:10a6:8:b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 19:48:18 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 19:48:18 +0000
Date:   Thu, 30 Jun 2022 22:48:04 +0300
From:   Viorel Suman <viorel.suman@oss.nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Viorel Suman <viorel.suman@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 10/14] arm64: dts: freescale: imx8qxp: Remove
 unnecessary clock related entries
Message-ID: <20220630194804.sa3mvokpv7iksgbx@fsr-ub1664-116>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
 <20220629164414.301813-11-viorel.suman@oss.nxp.com>
 <483d5115-4027-e811-8bce-15da6c7c660f@linaro.org>
 <20220630083636.2c7mclmbq3tjma2j@fsr-ub1664-116>
 <5d8b2044-5ca6-c90c-57b4-afbb2ae20dde@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d8b2044-5ca6-c90c-57b4-afbb2ae20dde@linaro.org>
X-ClientProxiedBy: AM9P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::23) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2a7b9d3-5be5-46b1-acfa-08da5ad17ae2
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3689:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6zRqIzhzRA4oymeIsRZZ2fg72Ee6oZ2EUZJGl1TPIIRLDcTTBkT0o73J03g41usdQiRX8Oltbm4bq4N4GEUSbEAaLytoe/HnpvjSC6xziOkYEgNNA/xP7YtTWwvvYwHaD/xNoYAekMHp6mFSHi7RUXxDpbQINP4x+DT3QXrwBodu6eumBnWtPDANA5hCiwTselfGxSc0SQJB1heRXOLxUJ0rT2WTkwMAju0k1yftIsK0otoryz0R3qUpeu4EbyhrlhZX8XwowKY9heJ0dDjHkCucYxN7fXcgryNaSUV/aVzm8dSs8HTZgTAe1eAyR6ePAlQNGSul1ngiPuTz26VdUSfzqz3BITGRPnkFcZ72HwlnpYAvA3lZ5bxCEkHBAbAagZeyH5T3JZl7mNYtSj8LWzM5RtvECjyBb/4fhyKlvYazqKp45za/Qr0fl7yCobcwzHlbAypliGJg6GwEsMqgaiEMHkASKb0UOBbuVfbl2zQyXvnmTJhFKgd2OaHqvrA4EDVCkhA1N9yFR9AOZgg6TILG6UOE3KvtGSNyZtnliXqaGDPWwPaUaFsZOx6XBoYfejAqULXPG1tjKsXKP2NpQ0cqwXyNcVUMth1l9tDoZ34HgUFzW+qHQ3bZiEBfsgXY9WoEUxQzKAeVC8h4F5cCeXGaXOcTmoOv3h1abgjxOmotgOvZOZcQhBrVITMXjPIaj36Spcv23o7ha48vGgUe0LYdQhik/qIjbgSak9n+w71wDnlZC+SUqYPX8e4R0OEZtmOMCsxlUJzsaUx/5WvTImSqQHP/Cp6FcQCqE4ndUo0UWjxhDnyv+FqjzV+EHq+VehZs11OBwZZpgs50II/48Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(39860400002)(136003)(346002)(366004)(376002)(7406005)(7416002)(478600001)(33716001)(38350700002)(38100700002)(6486002)(53546011)(52116002)(6512007)(26005)(1076003)(6506007)(9686003)(8936002)(86362001)(66556008)(83380400001)(6666004)(41300700001)(2906002)(186003)(5660300002)(4326008)(8676002)(44832011)(54906003)(6916009)(316002)(66946007)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TsqnnqefiXGJxwmac6DvRuZwkyKXjlZZhFJM6uBqv3SR90wbAIL5IGkBblA6?=
 =?us-ascii?Q?rPiFsKMSh7T4IIG9iEgxKjoJ6G9f9bnzRjZfNMceMmo5ePMggiY5On5lixr0?=
 =?us-ascii?Q?C6yhWE86fR3onbVoMeCdOB1xv/rUP/H42im6DPtHi6ZuJW5qU01kpTGH7//T?=
 =?us-ascii?Q?H6qvOf4BrYRv4HqRhIwf6fpdagp1jP+HPYdlS5zmx2Sfk74v+uokih86kHF+?=
 =?us-ascii?Q?cZFuj2NVQG5zp10hWwNXa5MxeQnZbdcbAJmX/rYeA7P0PU8pn4YaKvDAv6qj?=
 =?us-ascii?Q?0d5GsplMlKF6O5TFlYB1Vu6lJsI3tQ46P7Euz6yxnUxYIq4YL+O/yGT1Na+l?=
 =?us-ascii?Q?Qb9RCpmD86Fab+JwRNWgGm9vmH6AfRvIn9wWToZOb+avDV2y5l/TbE4cyVoT?=
 =?us-ascii?Q?IZP/fslf168saVY2GuSuugakX23gFhiMaFojYuuduXKW1NA/yjEmdIivIvq4?=
 =?us-ascii?Q?/02siskYRDB07Z5CznOh5RiPoPrm5Ux0sRvw+7RVdhzvME+5IzBJdKoqTXAz?=
 =?us-ascii?Q?lSZ+rKGZyJROf6Pk0TdxPgN4d/xsJ3xxiBMEYigYZbhYwO6SpjycV+2HlYVZ?=
 =?us-ascii?Q?2yMhkYZyuPjru5Or4i86eysvdb1fO8E28hQ5t/GtooGfCEP04TB69n2SpHM4?=
 =?us-ascii?Q?ymLsxsVFip2boURK8XvIOuDS5/1ZkHCf+2v/dnT2tVIAhgq4HSYZJFlDrHlN?=
 =?us-ascii?Q?d9ZhFqQ8b1BqUaW3yNxlJk10Uj+lkShgQez9r5QxU+jJB7LVmGFlaSxivNXI?=
 =?us-ascii?Q?waKWWRv6OY6Pf58HN8o7vzabLFrizE7J7k8S2EXyy4Q8ej0hCxu7Vhl6Pw8M?=
 =?us-ascii?Q?yB+nhVwRiW1Y45avYmMy40DAyvxFhhF2Q0qg4uShQ1zgkacIs6tGcGzMKPzn?=
 =?us-ascii?Q?eYs12gpPPWW80RA6dUEE+WSdQmS03yvriCe518o6CaGRyM4TA8jGVcwL5w0s?=
 =?us-ascii?Q?tKMZ4aJHkOowFkGKgqNCuuxy6zFBdi+nMvv6Y+kML3TWrFQLsbPBqW/KJNUO?=
 =?us-ascii?Q?SlY4KBVcUH13bC1hLP//Gmo+efbKtY/Sw+RLnNrg2XlRhMCBIkjPSfG5ypow?=
 =?us-ascii?Q?onr3e+zsQ6gTz55kDEibuKaP7BiP40+D5NJirWPKTxxqSg1nCJqDQJYFOa8D?=
 =?us-ascii?Q?yhPZ0+/oG22e+Nxfa4vzATNNpuDfdcCOD80LNiUKPTes2dgI8xCpGmok7+bu?=
 =?us-ascii?Q?C780Gahs12UFV3yrP1nJADiPAtX6A571q3+tlse0KikB1e2WcnHQbLg+QmHy?=
 =?us-ascii?Q?xAFM+3PFI2JIHK4ltZxWlHBBkjK94kCu4nbTdLcgB7Bv98NsqfyLGmRSk/cq?=
 =?us-ascii?Q?ijIEb184vxjMraSFOspIDrWlTz8iGBWhWqVTlX36G9tnnENkmmTM6YPVBfsu?=
 =?us-ascii?Q?nJGQnMS+u/DZna147p+5x0Va1VTXi9xeCLzyibsZm2IwRFj1hejZEezyXviX?=
 =?us-ascii?Q?SUAbRE/JRWCLe3vSlLcvF/dzVCPOtF/tvUQegL0XoG996gw4jDApbjOY0+Vl?=
 =?us-ascii?Q?rwBGGBqSX42W8XdS4BCFUvsqu/Jw4+5CY8DnmeKrPo3/hmPAv8mapgJBINMW?=
 =?us-ascii?Q?gvz6C2gi2rjP0pAAPIdZqQnyRQSvxon6F2ElOg/U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a7b9d3-5be5-46b1-acfa-08da5ad17ae2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:48:18.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kICC0qbe5b6BQoIRW3Da8dDVMUD+jiCKFvMp/K3+FTPVpSh3HLiXLeZZyLpPpj321S2F1fFOaU2Okdq5YVwW8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3689
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-30 20:01:31, Krzysztof Kozlowski wrote:
> On 30/06/2022 10:36, Viorel Suman wrote:
> > On 22-06-29 20:04:43, Krzysztof Kozlowski wrote:
> >> On 29/06/2022 18:44, Viorel Suman (OSS) wrote:
> >>> From: Viorel Suman <viorel.suman@nxp.com>
> >>>
> >>> "clocks" and "clock-names" are not used the driver, so
> >>> remove them in order to match the yaml definition.
> >>
> >> So this explains the unexpected change in the bindings... but actually
> >> it does not explain whether it is correct or not. Just because driver
> >> does not use it, is not a proof that clocks are not there. In different
> >> OS/implementation this DTS might break stuff, so basically it is ABI
> >> break. DTS should describe the hardware fully, so if the clocks are
> >> there, should be in DTS regardless of the driver.
> > 
> > Hi Krzysztof,
> > 
> > Both XTAL clocks - 24MHz and 32kHz - are still defined in DTSI files, see for instance in
> > arch/arm64/boot/dts/freescale/imx8qxp.dtsi :
> > ---------------
> >         xtal32k: clock-xtal32k {
> >                 compatible = "fixed-clock";
> >                 #clock-cells = <0>;
> >                 clock-frequency = <32768>;
> >                 clock-output-names = "xtal_32KHz";
> >         };
> > 
> >         xtal24m: clock-xtal24m {
> >                 compatible = "fixed-clock";
> >                 #clock-cells = <0>;
> >                 clock-frequency = <24000000>;
> >                 clock-output-names = "xtal_24MHz";
> >         };
> > ---------------
> > Both can be seen in /sys/kernel/debug/clk/clk_summary once boot is complete, both can be referenced
> > in any DTS node, so there is no ABI break.
> 
> ABI break is not relevant to the fixed clocks being or not being defined
> in the DTS. You have a device which was taking the clock inputs, so the
> clocks stayed enabled.
> 
> Now, you don't take these inputs, so for example the clocks are getting
> disabled as not used.

Ok, thanks for the explanation.

> > 
> > "DTS should describe the hardware fully" - this is true in case the OS is supposed to controll the
> > hardware fully. i.MX8 System Controller Unit concept implies resources being allocated and managed
> > by SCU, there is no direct OS access to some hardware. SCU actually defines the hardware environment
> > the OS is being able to see and run within. SCU is able to define several such isolated hardware
> > environments, each having its own OS running. So, in this particular case - i.MX8 SCU concept -
> > DTS should describe the hardware from the perspective of the hardware environment exposed by SCU to
> > OS.
> 
> OK, that sounds good, but the question about these clocks remain - are
> they inputs to the SCU or not.

The question context looks a bit shifted. The "clocks" and "clock-names"
attributes are removed from a clock provider device.

The OS clock provider in this case is a client which uses some protocol
to communicate with SCU via a messaging unit. There is no
access to xtal clocks via the existing OS<->SCU communication protocol.

> 
> Regardless whether they are actual input or not, you used not
> appropriate argument here - that Linux OS implementation does not use
> them. The proper argument is - whether the hardware environment has them
> connected or not.

Right, agreed.

Regards,
Viorel
