Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC57561A79
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 14:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiF3MiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 08:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiF3MiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:38:13 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E656659E;
        Thu, 30 Jun 2022 05:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBTsAw+msGTESoHfkAjUZkAK5mLbNWwc9IU6sjkqlInSCnIkwkxnxmb9p9eVBhDiSMYQhHwNuPJcbnru0irRi589+IMI95dE/YucRYkvNlzMjsNjKS0XLCatXbUXmNGuGwCGpMtNjGtWMKuSFGnqI2zbk63Jm9bAQGC1GK0v4H7ollmg4axs5UNJBgqHqUMlu7Q2ZeOqKV3HZzcCaWK/BVBiUZVVpF3zMuWexOSB/1FSNQIHp/jlCO6MtQ+LMRpgmK6PzUhOdZEiyPD9Pf/WHk1XBSkEq3IjdCLLdhYUHHYyslmpWGyJH6C4DRlnmj2TiedTVjoVqanvaNovqbZt3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/K1gDfT/pRzQijuTtT7/uNvohdOLPyFppu/xb/j7uQ=;
 b=EVoIb3IXWtNE+AEgDSM83DZmj3EJmu4+vVR/WzJ80vfFOfbvl5hTI/QdkdesJUP9JYbanpe332XKxQKrhcWm0JeGqzINzuFmlCJNl3ATEyGoUvSMopUL5WD1i3mM89eYts3dxxp9ssceuP7bf35ryE+L7FdpDQJN5qxmU8hi6QSduAoPqAKU8PBDBkWf9v+iKGU8USthrOLPXslBoV7NxMyrNtgSlFgaJTVg+MGC8k0dD/mxktwa0juFklhZ8ZoW2+uJzhNPb52QreoP3JW9cIxqZjrnuvkC718LjEij2g9+G0tn0dkv07yiPh8s1l0UiU/GVOuT8YWQKCFNWXQY9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/K1gDfT/pRzQijuTtT7/uNvohdOLPyFppu/xb/j7uQ=;
 b=KAX7ShatYwzFwPl4Dh7+BwAp/iIr306/8BxHml7xT6Mee6byED33XSCgb8XJRduXJST3vma7GDQKmCTOQwEbmBDkHNz/6lWsYx8f1AfyGREitRABulGHd79mPmg4QeM6omLVzRCts+8P//1VF/ZsWPh6fvX1SEPpDL7gq9Si8wA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 12:38:08 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 12:38:08 +0000
Date:   Thu, 30 Jun 2022 15:37:54 +0300
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
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
Subject: Re: [PATCH v6 02/14] dt-bindings: pinctrl: imx: Add fsl,scu-iomux
 yaml file
Message-ID: <20220630123754.esbuac4pfktlseh2@fsr-ub1664-116>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
 <20220629164414.301813-3-viorel.suman@oss.nxp.com>
 <f0634bf0-77e9-939e-693f-31d50af4768c@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0634bf0-77e9-939e-693f-31d50af4768c@linaro.org>
X-ClientProxiedBy: AM3PR07CA0094.eurprd07.prod.outlook.com
 (2603:10a6:207:6::28) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5a2f908-7267-4d9f-7378-08da5a95629e
X-MS-TrafficTypeDiagnostic: DU2PR04MB8629:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjLxHMKu3sDf+jqRjhldKRz0X6PArGfevtLNm5ThYTfTIY2Bfu0vTlI6gXaM7/KCj0FkiVsvzwClozHzvJl1FVhkZ0v3R/EP/YzmfEWpI/Z7dHBD/MLdnSw0jLBroIpCVWtCq6U22m6J0bSUKUCI5VYv/J0h/eTo3mJPoKqiUN/koT3zilxqYTKBwRlmq0c/bBX2QbppNiCZs9/hEcVhef7U9so8lGTdc4EsIbvMNiQ5TFMTK2KcL375R0fK8eDNVm1BP32e/dqZPMRqojj8BE+MedVR5aAjSibF4qpot4saCMpRG6Wwl3crvOWGtofiMf47jro0YGMkgqGmg3atJ12sKfQQi8TpZnEjFauy1ghgcAmOaJnnWpQymoo8bKoyMbUxyDv/PKrQudV1rv2zV/HG0jW7a5K5pLaYZnkepaW0QOqM6xjL2okTIFEsIXhlg7TNXkiskqh1ro6Ydmn2wL3OLR04bS6agpwT1GIJmfLzcTfDzhmpLZsCLQmfREc6+lWYz0u/vstUgXTNnW6F7ITbbt6ZWYoGKUAIvE9Z1rsPaNsvhIsBEp/jSQLOWAYSmmM5U3eR4TcU8vNmWMVcUOGWeLJsPATRT4VlC5k4slzXq83a/ve8k2sD3fO4cXzrsf9Wl7FPOCFf5Oo4+BgX396/s8t7ZTwOR7jsxyEiXUNt0PWsOICTJdouI6EbQtwBDDPk+eBC7k032gqRwc1OXP5yBVpSayjIQ/AU5BNQkBDhhJjqhctRwImlpBaZCBRtm/719Z9grQb2PcNpq8nn/TJoB4LHef9GEKWc8nVoAZ+CrzONLX3AVn/vlrhMSCsU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(86362001)(41300700001)(1076003)(6666004)(7406005)(5660300002)(2906002)(9686003)(6486002)(38350700002)(6916009)(38100700002)(26005)(7416002)(6512007)(6506007)(186003)(478600001)(54906003)(52116002)(53546011)(83380400001)(8936002)(4326008)(8676002)(66946007)(66476007)(66556008)(33716001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d9OHX4+DBX7xLkhYsZikk3S9f3HE5QI6i5mR2NTr1uCcKq+kIejxE1Xx9Ttg?=
 =?us-ascii?Q?b0MmOGEgaHrc4cfaxCsKUSq3TFD1fBA+pNnNN3cqq+ubCFC23p+XEVpGbdfy?=
 =?us-ascii?Q?i5SeUy8aDm1eOZAIqWxk9n0cpTwB8fdfDwmaI4wGpcuqlBuckrYYDR5TxgVc?=
 =?us-ascii?Q?fjjaTOjIBM5/E9aU2i/ISZBThbD75ix0uBd7U4OQsLgAhDHw5nGpRhDfAMJJ?=
 =?us-ascii?Q?wuj0UJcEaQToHUZT2mLl3ThLXX48kyEB3x1fL0Jf0s955zMNxi113dOAoQVQ?=
 =?us-ascii?Q?DL9nG/ge4Tm084pWBoqtvVeA6rf22IMDIAfFtau6AN8oUXHFEGA6hvDCE1rq?=
 =?us-ascii?Q?//KXa7l2XcT2zXhOd9KC7r3wQfvcgL5yFJgEiG0iERRN2FJXaYHtBLSV6qB6?=
 =?us-ascii?Q?9WQwCuKSh/UgdaprGeGfPk0b55t2lDU4Q1RALh1DY0qT0Nu15hVZS3LLStsr?=
 =?us-ascii?Q?+2npviadFoBzZ025ZYUBIIeJb+xlgzdfW3Dvv7cm8YLV+Af2VIMhzu8MJVYx?=
 =?us-ascii?Q?s3r2TUdCPj2Z8CxlOGiB1PmnG5npuQ5RYhMX93hJtTh0NFZsh6cQCpY6aStJ?=
 =?us-ascii?Q?+OziYlfsdUBZYi6Va7zlaGARSSARzBT1lLXUDMWsbGOZysCygXm+jlxg/zwO?=
 =?us-ascii?Q?LS9AdYn4TJ1hgLa0lUE+6UDS4kaV9Uak6QLqycoi1OMLKurJc63NB445es85?=
 =?us-ascii?Q?ANvfGGt+ajghqRwTTC2oZNIzH35O1HfYSrfVHmgibLW8nZika5r0FDXqPpZ4?=
 =?us-ascii?Q?ikDq3+e9+Gn/Kh6rgNZqZxAnfSqkS6TO4rX19cr0G6OobtIEkfyorSDr6Vre?=
 =?us-ascii?Q?yHdPLdmQ2OmpxOSu+U9zJXLt4rQZkbptHFhSyj/fBDwjNxaYWFkgj2FSwXYP?=
 =?us-ascii?Q?si+JV11MjkSqsbR1U8pH4rPy37gEiZ40/wTS7Rv/piBJlRF6IOC/xCvfYEsL?=
 =?us-ascii?Q?2BpHD4E931ec1MvWPPwAiKhx0//bRnl6g6Hyv10u0ubuWg8Q8UsamsPeezh1?=
 =?us-ascii?Q?IrM4SOx5xXHKn9HDPXn+WgXmAmkPUp+uwJqANYdQ1/EVAKQHNt9YFTVy0RWF?=
 =?us-ascii?Q?ZXfkHoyynT8w/AoPDFm/07k9HL8TyE7+L5io+h6oJkZ/Hnz+vXAMfq3yyjwe?=
 =?us-ascii?Q?Jneb/1tWCTbAvTE4U1ROS3cnc+2rPd469Rh3yMWaCNyx9LFCssfmYnzuVYzD?=
 =?us-ascii?Q?kETd7USa+oZpYSjID+G8Hle4OqXNqL11q+nQ/JdLVND5Wv6Ed4vFURU9nx4s?=
 =?us-ascii?Q?JABhRvTz475LZW628FWyuOn7xDhG5kjR6r0BDXgePdHGRPif6W/9wLLjqi01?=
 =?us-ascii?Q?aM1q3q3aXA6gJJehhP8tRxs/aOrxEsPVHcdMxSexvlA3G9pvaaUGYC+0CwST?=
 =?us-ascii?Q?PIoZFaqkdXnsJKdXQHsoVw9flRi+VV9ODUOx2e3fm8Eb7dVsh0kJnSBj6vo6?=
 =?us-ascii?Q?YECHgL4YepvufU+KjlBrmAhZbqZpajn8G9USwDmp5bbPDxQnX0EbNI6mDzua?=
 =?us-ascii?Q?qI/5CNNxdhbb5xkrsBcNgpoqWXtZSxUca59d18HxKmHBzt8BMGY23Byc7LXn?=
 =?us-ascii?Q?+f/KGbrOxs2dW1Rdq0HGDoj4nNMWbp2IsI+6LIAS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a2f908-7267-4d9f-7378-08da5a95629e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 12:38:08.0805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ox5VTZk+H7qpcBhoyvEeUsytovZl6nu5XALOEpoz91TekBFYzQm1HstiHN8UsZxXNFAsh96P5Jjqa41Bx51mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8629
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-29 19:53:51, Krzysztof Kozlowski wrote:
> On 29/06/2022 18:44, Viorel Suman (OSS) wrote:
> > From: Abel Vesa <abel.vesa@nxp.com>
> > 
> > In order to replace the fsl,scu txt file from bindings/arm/freescale,
> > we need to split it between the right subsystems. This patch documents
> > separately the 'iomux/pinctrl' child node of the SCU main node.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > ---
> >  .../bindings/pinctrl/fsl,scu-pinctrl.yaml     | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
> > new file mode 100644
> > index 000000000000..76a2e7b28172
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
[...]
> > +      fsl,pins:
> > +        description:
> > +          each entry consists of 3 integers and represents the pin ID, the mux value
> > +          and config setting for the pin. The first 2 integers - pin_id and mux_val - are
> > +          specified using a PIN_FUNC_ID macro, which can be found in
> > +          <include/dt-bindings/pinctrl/pads-imx8qxp.h>. The last integer CONFIG is
> > +          the pad setting value like pull-up on this pin. Please refer to the
> > +          appropriate i.MX8 Reference Manual for detailed CONFIG settings.
> > +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> 
> Look at fsl,imx8mq-pinctrl.yaml. Each item is described (items under items).

Added them initially, but later dropped because of some logs like
"pinctrl@xxxxxxx: usdhc1grp:fsl,pins:0: [...] is too long" shown by
"make dt_binding_check dtbs_check DT_SCHEMA_FILES=[...]/fsl,scu-pinctrl.yaml"

Same logs are shown for "fsl,imx8mq-pinctrl.yaml". Will add the items description in the next
version.

Thank you,
Viorel 

