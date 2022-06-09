Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A51544FAE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiFIOn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243807AbiFIOnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:43:46 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D036B3895;
        Thu,  9 Jun 2022 07:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTCPwFOiiM9uC00CF9PI5wqCPBOF/SGbBySDh+wPOv0aXo0ZTOAt4Z0dfeN1rfHOb/qNsR0WsFJRSbLcGAw7n9y0tk0kSiN38lnhXhUxYTSkFtLayGRP416kGIrWSorafZtA42ESrYpvNcnczUtDvhnyJvB4Umq9+wAgG3t/80HlVA761uFvLvCv7vIqARG/QBpSeb4bbA15uIO12jLTGkBfVgW7H6iH1Ofnr84FSq0yY403wgI/aJbePSCrKubVuf4s9EZuvEaWBp8eEoVooW7HVUjvedMlUS7L0jXA4dcm5FFoxnlaovSsnq31RxRpXb/ki4Ubd4u8chKBqgC1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zYgmqnJuj7MiADC+9RxUtkxhMDtJ2GBCRP/aT2zgWg=;
 b=N4wJRdyx02icfeeJAKTIhmjuc7dl+kELVEZB9EVN89LX1I+60YLLLuhOy+TZ2J/27whRuiXc11iKCNLneUF69WQwYK+RMb02RJTkblnoAoIy1crolD8gXr6+A0DYNRxuENrfXIPZ0g1Kaq0GynvsD8nGN6lwxUmHPICaqb/uNrG28mjNIgOooo8dtkUJNmpmlKqBVo9TpvsSCIN+0QyhVdxdUT35Rc9Xgaz9S/glvsATbqziGD5/jpzJMFzrUanlPsQ6TpFOEXcbZZNRwm8MRRRpG/v6vCeOKArghNZ8ufgLr162Ol7CVoTJQpOhSPMAsNI5KJ5VNvzR9OlN60lUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zYgmqnJuj7MiADC+9RxUtkxhMDtJ2GBCRP/aT2zgWg=;
 b=F+0Ks81lP04HvVuBDtpay1cOyTphRh9vCAXTfPkPJkyELzdqZQsxjuUcOUumPmrXromshA4TvUnoLZ3tC9hZnIWuKcn8PjYMb1uZ9Y3loKQwEcYqRK8+wci38MQxtltGRmwPTekqbA4hyaQAFHl9sbTxTqO8lelLBqDmPKv9f54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM6PR04MB4472.eurprd04.prod.outlook.com (2603:10a6:20b:23::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 14:43:39 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 14:43:39 +0000
Date:   Thu, 9 Jun 2022 17:43:36 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 00/10] dt-bindings: arm: freescale: Switch fsl,scu
 from txt to yaml
Message-ID: <YqIHF9QyYjfqryjn@abelvesa>
References: <20220608164928.2706697-1-abel.vesa@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608164928.2706697-1-abel.vesa@nxp.com>
X-ClientProxiedBy: AS9PR04CA0082.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b::6) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 249991b4-86bb-49a1-757d-08da4a2670e9
X-MS-TrafficTypeDiagnostic: AM6PR04MB4472:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB4472D9C67B0F34EE34A743CDF6A79@AM6PR04MB4472.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DORtr1odhiArtczQaVIY90gbuFVJBtCR/OVXA/5KLND7K5F+BW2jxK7Rp/ZHThh6j2s7VyUE7l2OWeHbSes0dMdXuUmK8432fMgaN2+2x290hXKk8rrSVxBX6cFaigrmfhEzOHL+3zgpzC7un4t3cBpe5WQ0uf4c8zLo6ZxdBh4FU8YRlEWvXUc5jADDrBb1cSgZb2z4n3rqFQn6gywipoKs+i5pLwwIUYfK1TdCf2126wB3Tdz+5vegCxMD9+Z63iP91jTm0a+3ZHlwoCmDF+TboH4TpAnxThQGwJOi0gui7niQDv1+r85U1gV79ESqELmEdhsQyY4lOEV79jOEl2O/Vt0WHI7KyjezW869sjGzUm7rbwKKzZsQ6oziRLTdZCw+5/yMvBf3KfcfZcjAel9J0uTbLR84LghCWLy30SypHS3JVHWBQ8xotDwhDWmJhMhIgqdHaB0kIighDRTTcGM+P29u0NfHpoRxsfGkP9YZTiHZcfnpyxQLqIpqq+U3N/zErkovzzrmfsb/4heP+azsmdKkGx57Ols+DwA5dulgBpfFt5eujCNdEl2uRIClC5sYyy4FZAaPK7OkSm1Y0bh/WA6lmQIa2Nh6Zz8xop+4qy/K9R3Kw8upL5anOVPMWa44DBxVQQ/swJiNcOQz/nqM5g7ttUuXh4zZ3z5xg38CQZkwuoFsHc1L8igu8Hfpk+wrLglcGHINR5kd37a69/3hMqhB/ecDEGlnMEZZM7SHLWwO98GEvlhiqw0xJj65YQOkZmsY9iy36LMEFyid8ysEFqU11Z1T/RiEhwX0O3OQsVFXW+SOoeklsFEue+yx4Rdjj6jrj8Dq+RAwUK6a7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(66946007)(8676002)(6512007)(66556008)(9686003)(2906002)(4326008)(921005)(66476007)(6666004)(54906003)(53546011)(110136005)(26005)(6506007)(38100700002)(44832011)(52116002)(38350700002)(508600001)(86362001)(8936002)(33716001)(316002)(7416002)(83380400001)(5660300002)(186003)(6486002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?saNyWnsX3ly0sNQTs3ehxce8TxK4TCohQDkkdVK6mmYeDWmhrh6N4do6ZfKR?=
 =?us-ascii?Q?y3M7NOfkvZyVteaEY8bPDny0s3KompudOv/liPm4SadZBwIgBkFC5JyXuSum?=
 =?us-ascii?Q?6X4bD85fg95YehocMbVJAU1i++68CkfroabM5e1HMZiNjPWSfEniAb9DxBus?=
 =?us-ascii?Q?/D66GsG2dWHm1dtsGN5stAS2JYyXPNRVxhPYRiHX68cYypDv0+IIJNOTqGj5?=
 =?us-ascii?Q?P/Y4DuF0Kj40aytTz4KfHboCONeia3xQ3iSaKXVchUHsm/3DnayJ7sCg7QLm?=
 =?us-ascii?Q?d5gZkGMqEUdhnVxDJYVBHq3UBpz1wKM3w3/u04pBJApYEQA1UR9rxVbSeC2V?=
 =?us-ascii?Q?VpAKPjM56VIydhal1Bn/wURZEp6E9JxJhIuFGkIYtpIE46uh7VJAh7BbufGu?=
 =?us-ascii?Q?SU9hzD+LmRmdERInBo27XWC9VTLZxHgNwMhQ7nlM33maBEL4Fh1twWeGDNQr?=
 =?us-ascii?Q?4pbCDN+vQYdZ+MgyZeRtvHMRjS2+97l+FX9H/4E3j3+ryOOsqlwyzKu4xQFI?=
 =?us-ascii?Q?v3MIg4AlwqYmrRhb7DBmj/kepGAvf+lQo54S2RzRr/itu13SLNFKcicsUtR2?=
 =?us-ascii?Q?uWXut+xYeL4ytfsg+2OanBhvFRiLKtW88EejeVz8KAd1Q/1XQr3f8CkxmUkv?=
 =?us-ascii?Q?wu14vHUdLiXTCbCRbXCDyKKI8XPj8VVIr1lnPxlkFAyve1aXIdvtAFtWqEbF?=
 =?us-ascii?Q?eBmevP5PXN0FAnqDauFas+XkHzNr6xhagZ7bjpEuKgilyuQTsYup6lojcl4D?=
 =?us-ascii?Q?3m040nPJFbDOzJKcTnDx24YfytcTwryooIJVa2skyj/yywmxkvYahq8X9WCa?=
 =?us-ascii?Q?LULUKDcXjwCB6zJAnIaaWLnv7p8GcTf/yqBXls2yKfgEItf33xAh1cV/i+GY?=
 =?us-ascii?Q?vMfWm7tdzeIR0gA8mo1DkAAhAHzUJP7RrL66bDaKimiT9U7lStCPmWlYTgYh?=
 =?us-ascii?Q?KQGnvVBzmE+pvK/2t285iXGjrUbDHh4zq/2+QblH9I3ulU87Cz6YM1MF96IT?=
 =?us-ascii?Q?VZjuKLXrH2BC7n9GapHKt6xCJoXU3LQ5Q7cDvNKMWti99tgK8eLzEPU2QHRI?=
 =?us-ascii?Q?ShoaPLCo5ctVlZYxsiQUO2HKmMvR9HCgKRwqGv0S5ycd5k+Ov5OpTNcF9yhT?=
 =?us-ascii?Q?JwAliteCTdVSSNt7Cw+JeuK1foTAcgovqk5mokj/mh4cni7IvBcQRZHFTf3z?=
 =?us-ascii?Q?UMGDLGeTv9xcWz+rPPF0u2TR1ElLTqnm9sICi8sfDxjrIX/wkzcIqH1HLfHM?=
 =?us-ascii?Q?JBcWtrwuQOwqV4TwWLmJLmeCpQB3QSPps4jthLn4LBXdj2/sIlEyuo2mz5Xs?=
 =?us-ascii?Q?RHo3VMbpX05M0dEpNiFMmo9pg+ZeXRsHKfwOjZOOj7yyBwT4ldQfb5POaxcR?=
 =?us-ascii?Q?c+Xy8GzKsLT0N/32vnrXFM14/yKuRUQSxG8flIyNMsBvMsQQFs/0y5RHBJXq?=
 =?us-ascii?Q?RvcTedIKcRH33gfOpPxjD89emRwXBDZ8cJ0R8TkosX42zpvXhlk+9iZEpcPJ?=
 =?us-ascii?Q?VdUoZy2op7GbuK87mhjr7ahay3GWup6HlRb+/rXW+jpDrxla220dwqmcJwc+?=
 =?us-ascii?Q?/xPfBnGJ1Coyz0UEV79MAvrBQ6RVvhdVDqhMxAjTA4UwT73fWmij3cs9mA+y?=
 =?us-ascii?Q?f8Xqm5s1ey8+UmBXt1f53LAHD0CDvQHD0qyQp+le3BHMyep64WksxxP5QKGk?=
 =?us-ascii?Q?G54PqzCV/Zm3BjmMXfWdeYz5+tnr5lgzUu52TIFItiCj5SxzJwkXSADe1ZnM?=
 =?us-ascii?Q?R6EU8+qM1A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249991b4-86bb-49a1-757d-08da4a2670e9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:43:39.1625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4qAJS0PpUlFWVuh7kAskkXOb+rJWHXN9hYZXq7vY6yl4KFmLIVme6OG2QhPhkcXB8PVUTpPCSnuh+/m1EgaDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4472
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-08 19:49:18, Abel Vesa wrote:
> This patchset is splitting the fsl,scu.txt file from
> bindings/arm/freescale into different yaml files throughout multiple
> bindings directories. Last patch actually removes the file entirely.

Everyone, please ignore this version. Here is the new (3rd) version:
https://lore.kernel.org/lkml/20220609143423.2839186-1-abel.vesa@nxp.com/

>
> Here is the v1:
> https://lore.kernel.org/lkml/20220607105951.1821519-1-abel.vesa@nxp.com/
>
> Changes since v1:
>  * added the yaml files to their proper subsystems
>  * cleaned up according with Krzysztof's and Rob's comments
>  * changed commit messages to reflect that the fsl,scu.txt needs to go away
>
> Abel Vesa (10):
>   dt-bindings: firmware: Add fsl,scu yaml file
>   dt-bindings: clk: imx: Add fsl,scu-clk yaml file
>   dt-bindings: pinctrl: imx: Add fsl,scu-iomux yaml file
>   dt-bindings: input: Add fsl,scu-key yaml file
>   dt-bindings: nvmem: Add fsl,scu-ocotp yaml file
>   dt-bindings: power: Add fsl,scu-pd yaml file
>   dt-bindings: rtc: Add fsl,scu-rtc yaml file
>   dt-bindings: thermal: Add fsl,scu-thermal yaml file
>   dt-bindings: watchdog: Add fsl,scu-wdt yaml file
>   dt-bindings: arm: freescale: Remove fsl,scu txt file
>
>  .../bindings/arm/freescale/fsl,scu.txt        | 271 ------------------
>  .../bindings/clock/fsl,scu-clk.yaml           |  52 ++++
>  .../devicetree/bindings/firmware/fsl,scu.yaml | 162 +++++++++++
>  .../bindings/input/fsl,scu-key.yaml           |  30 ++
>  .../bindings/nvmem/fsl,scu-ocotp.yaml         |  37 +++
>  .../bindings/pinctrl/fsl,scu-pinctrl.yaml     |  32 +++
>  .../devicetree/bindings/power/fsl,scu-pd.yaml |  34 +++
>  .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  |  22 ++
>  .../bindings/thermal/fsl,scu-thermal.yaml     |  32 +++
>  .../bindings/watchdog/fsl,scu-wdt.yaml        |  29 ++
>  10 files changed, 430 insertions(+), 271 deletions(-)
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
> 2.34.3
>
