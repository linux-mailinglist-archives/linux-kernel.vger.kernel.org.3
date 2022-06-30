Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFF156153C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiF3Igz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiF3Igx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:36:53 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47724340E2;
        Thu, 30 Jun 2022 01:36:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSw6F0gv759jaYhLQ93Xe++9HgWvWZIfEWQpErOIuCqgNIj5tzFNFhLwhc98Y1sX8UVHTcD54uhg4QdMHce+gV+Uc0SCyLbvCRCG1DB0OwnNfBtPlG137nCHlO6rhtCOsUq9dtN8ahxlJsZlxOTWuBkcL7uvM3TNOkUt5yQ68trGiGfwEtAbmZ7P7yCcUHPtXX8UZNtlg0yg9HK+kbpKzGsvPHSweL6ZSjRJbKYjHuvUGsTflXE3C6ne363SG2p3qbIgvJTz4Vv0wHmAIgWgU3rmYxBw3QLYLnZOM1glkbmQzD5su4fexBgU6rwuhQjqXzF9XNTcw8pYIPvo1vmrSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFF6a57o2xRCd04noXHIZZR0YhO8eJFPxovZMIis6R0=;
 b=SdjNxrnkeEyXDwbreRSoejUv1Cd8iF6qDdH2V6bb/2Ni2dvaRSl0wxcMkuHCHL/J6naO2Sq2TFtZGAewBIUhKIDAopSiRnwizWUemPm26rnccotUTjm8FzQlzMNZEbCnxIkDYAmWRAzLg7sZr6ZHIWhcSR3nGD0TtU7Ln9k1Jt6g18iFmJVdT6dndZgLNmT+u+lZFcWLRb2YUWUqVkKfwtVSwn1lV0FjnMtKVCf+Io59+ifZqY7I3LJ0ZLMol/RHuS+3UHOAWuSFaUay0Dk1pX7fpLrdiwRF1ZE5fIGWtSP15JTB6DcokgQ25QLBAMF03HEdTDYwTDhYSJ9iHEwJng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFF6a57o2xRCd04noXHIZZR0YhO8eJFPxovZMIis6R0=;
 b=RyGd9mfIWnRgy7ATxWhfKyWGgBy/UAIgr+9ApdCg7HOGgvRK4IVhiup7muoxIjS9y6gJzYUIvHkYt1/etTVznUAsP/QSq6lLP20FHlnyx4H0Oc+m4/uqQzfw5sjrYdQVwJWf5Gqk3WCFrExSDXjrXbRF4Cgt7/7YyFN5q14RThs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by PAXPR04MB8623.eurprd04.prod.outlook.com (2603:10a6:102:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 08:36:49 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 08:36:49 +0000
Date:   Thu, 30 Jun 2022 11:36:36 +0300
From:   Viorel Suman <viorel.suman@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
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
Message-ID: <20220630083636.2c7mclmbq3tjma2j@fsr-ub1664-116>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
 <20220629164414.301813-11-viorel.suman@oss.nxp.com>
 <483d5115-4027-e811-8bce-15da6c7c660f@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <483d5115-4027-e811-8bce-15da6c7c660f@linaro.org>
X-ClientProxiedBy: AM4PR0902CA0012.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::22) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5238a5d4-7697-42aa-e2b8-08da5a73accd
X-MS-TrafficTypeDiagnostic: PAXPR04MB8623:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WaYwGmkhrBOHGGNNkq/5erOJkzZGIyTp8FNdbile4b4p0aBSeXMK2ykSmLZuf88DhaNcXATvEQmvRrjAl0SwX5ZpOT87UFFE6PVEdDPAiUDX+iDAErhqF8ICja1WSE6BSToZEHa0QavBdFnGVtetLq4D6oYxDcDScyeCwPc4YEGVgcWe+sLwjhkePRVvUbW2rMzpodPucP/WB1Hv+fPC2sc28wT9MKRnuTNxRzekgaeyv4KsYnqMTKKE9Ym5E6HKC2MlyXXTiJvFT3mYDStGh0oHW+Lm0V67WC5zgBM1cZ1mMUI7jJqfBJPNyRy209UEaHVCXJMnz9+18iM4Xt8e4W/3bh07r8r2A8k7FZUABUOjOf4MxSPEKasieLDgLl0KIrtH5nsM3aQSEYjGIqq4YH0lkm+ZubJMfSDcARSF39gXOb+NbaKxQFIJAkWRxBcQvOgfkQjxacsDcioSpyK5bae4JXFWFECS6OrG0eugZgUa4wR55wuyqgTBa23tuv8Vk97A7HqhWnlJTQrjPSdcdyccliOGsQAxJvNGtV418dAeodRguWVlbWr3z115JEiIqivwTebCrVDX/o68j59oeaS9YiesUmN2wI5crs0be8Z1YMOw0zVE7SS5lbQjRR5MutUwcFfxQZ3qpLISclK0zT8wGp0UNMAw6tczRKDJkBbj6KpvOoSsf8CLzz1MF/C/+CGrDl4eE7l89c1nqgXEo8bY0bXnxtoUuAVGFLLNXEqb4nihWgUUKL07B8wC0AwwSq3woFFjBdvtaT8OGXdlSTN1yaBEHdem26JlbQJi7uZ80b75kgmIGKzv4sKZl8QXMFinHm5hwf1urpNM2MH+0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(316002)(186003)(6666004)(2906002)(41300700001)(6486002)(26005)(33716001)(86362001)(44832011)(54906003)(6512007)(9686003)(1076003)(6916009)(478600001)(66476007)(5660300002)(7416002)(7406005)(38100700002)(38350700002)(8936002)(83380400001)(8676002)(4326008)(6506007)(52116002)(53546011)(66946007)(66556008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i+uOUD6mOb3bq51ikxjyifc/+X0bZz8+DcXcpYZsK5vqApkkL3inYYIiqIQp?=
 =?us-ascii?Q?/jZUFcCp49sSSHZaMoq67GHUp2qMxZKko9QTryu6BpxyzO3pNEv00qvEcUmi?=
 =?us-ascii?Q?4cV+Mv43tDzVc7m0AKG/lqEQ8QyaxIGsvtrLekUw9gGy+jYFtqIjQkNeS8wp?=
 =?us-ascii?Q?AxKSKzvWM83CE2+6KxQBQGFr5m4Scd2T2JcmmJLY8o8wAyaNuU0yaUHWmDUo?=
 =?us-ascii?Q?mxW7QwGFTELq85IDND3KWb6YgnduNde7Y035v3fj7UiX5mOWfWpLC9CCuqc8?=
 =?us-ascii?Q?tr3I4CiBJzDVtVhS1JzemmTqzAUKGk5BAkn+1eymLSczNs6X4hB3BaIIHLv1?=
 =?us-ascii?Q?EfrMe8I1uk1xRUzvn88kt0q84vFTV4MylbxAUP52xggnzGCgotlbJlp30ZxF?=
 =?us-ascii?Q?SVJPuUa0pMRnrmHqlyzfbU08R7WYKUeeKvVBtPySYw9WUgWZRsnXwi416N2S?=
 =?us-ascii?Q?QwimMJyjReFZ0YNHI8W2ul8H2D83rFcLa97KiUdCS5J+1JtCbSuzN7DXcRi+?=
 =?us-ascii?Q?scxWdFfscSEGIeEY6ovrU/9ySK2u258hPeZwWt9qebLTmlKz7A527xYd7hyJ?=
 =?us-ascii?Q?QgghlgGEnjnaXRoTbX56mEFHPtKKxNf6qXt1GPEejUh9dTgYYGkBcsq92WfP?=
 =?us-ascii?Q?Nv+AsKeVXGdz4GbYJYgLSm4VqD3miXyD8ZVwefYsfpUCw4tuj3jPEeRMcOcx?=
 =?us-ascii?Q?di8Z70qhDLkQLFv1t1lHFDLs0j9qZ8LP3X9kMA5OR14h4jEAyS7QYzPYLAZ7?=
 =?us-ascii?Q?llCWzLckefThRTW6n5jBtfDidTJWjhaj14ZtA/GgJBPJ4Gpqb3uu/GcHJH/5?=
 =?us-ascii?Q?LatxhYhdZhb8oN3S0HyV8z6w9dn+bQrl9xu796VKUNa2E8ejWmLcmTLLllnM?=
 =?us-ascii?Q?+AxITzh07J07Ia/NwoxXtn1iDNmGjC/jL12MnvCCb80nqVLTS+nOh0AZyBRU?=
 =?us-ascii?Q?GI6ObvCSAJOuassufMgR+22eq4BtsokzIv4w3i3Hr5OqVhHI99l8+krMKMXV?=
 =?us-ascii?Q?LRoQocYNLgq2hLk0WWi4droz3y4prJJla+GEMwxg8Mz9yaeG+Epty+DHgEsa?=
 =?us-ascii?Q?/oZjUye61gdb6W5kkOd7m19hlY+9Fr3RuIdeOS8I6TrMFvZwKos3RmgfCpbM?=
 =?us-ascii?Q?CHB9opdqAxvp7WjYfr6tZRx/sbq6fVFX+RxcV4w2fWzMeq0bD2zNz+JPi/8b?=
 =?us-ascii?Q?qwC+BEIg8B9VOK9UDdxEFd6i2JIVaCjkVrEvgXvvYUAqRLyX67hCrVpNqTw/?=
 =?us-ascii?Q?e+reOZQlA569aLoy/DPzIvdjWbouBX+SjOAzUBdGhUjO2gllX7Hk4DlelSXf?=
 =?us-ascii?Q?PBjnXKHA//oGLdZbmg19z3TuuR6GEhtGXLrOrKsBdvhAJPb2MDewsYfLQmEL?=
 =?us-ascii?Q?ae2YN0rw3kNQrO7WjWLVdOBxQq4G5GIcmpY3GJwK04nXCMUwG939DEkwRIpB?=
 =?us-ascii?Q?dza6/4p+fomuVa6tlJqW4JFEVxt+LqAnOnHUBbKQkGyzB7hiMMbt1/lkOAqz?=
 =?us-ascii?Q?53V4YrjEOpsqhBqGI0ezPjXVLvgMFXm4ESFevltxQxVHNxKNbk3J5dLE1ciw?=
 =?us-ascii?Q?B5XnCVB7Qaa6DGeBK6hctOw3O7UdKQYvWXQV5vn+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5238a5d4-7697-42aa-e2b8-08da5a73accd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 08:36:49.5290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUODE7D8V4y9UEWVHCjPNB2FRZKXsGrFsoPvDRtg26mQKD5CVPh+ioM7TzUbnYglxUcha4pgbvYYDC5gFqH0UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8623
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-29 20:04:43, Krzysztof Kozlowski wrote:
> On 29/06/2022 18:44, Viorel Suman (OSS) wrote:
> > From: Viorel Suman <viorel.suman@nxp.com>
> > 
> > "clocks" and "clock-names" are not used the driver, so
> > remove them in order to match the yaml definition.
> 
> So this explains the unexpected change in the bindings... but actually
> it does not explain whether it is correct or not. Just because driver
> does not use it, is not a proof that clocks are not there. In different
> OS/implementation this DTS might break stuff, so basically it is ABI
> break. DTS should describe the hardware fully, so if the clocks are
> there, should be in DTS regardless of the driver.

Hi Krzysztof,

Both XTAL clocks - 24MHz and 32kHz - are still defined in DTSI files, see for instance in
arch/arm64/boot/dts/freescale/imx8qxp.dtsi :
---------------
        xtal32k: clock-xtal32k {
                compatible = "fixed-clock";
                #clock-cells = <0>;
                clock-frequency = <32768>;
                clock-output-names = "xtal_32KHz";
        };

        xtal24m: clock-xtal24m {
                compatible = "fixed-clock";
                #clock-cells = <0>;
                clock-frequency = <24000000>;
                clock-output-names = "xtal_24MHz";
        };
---------------
Both can be seen in /sys/kernel/debug/clk/clk_summary once boot is complete, both can be referenced
in any DTS node, so there is no ABI break.

"DTS should describe the hardware fully" - this is true in case the OS is supposed to controll the
hardware fully. i.MX8 System Controller Unit concept implies resources being allocated and managed
by SCU, there is no direct OS access to some hardware. SCU actually defines the hardware environment
the OS is being able to see and run within. SCU is able to define several such isolated hardware
environments, each having its own OS running. So, in this particular case - i.MX8 SCU concept -
DTS should describe the hardware from the perspective of the hardware environment exposed by SCU to
OS.

Best regards,
Viorel 
