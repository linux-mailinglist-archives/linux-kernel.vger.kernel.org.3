Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526935664D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiGEIIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGEIH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:07:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA6613D70;
        Tue,  5 Jul 2022 01:07:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZA5COdfMAO+eO5zz47yaBcw1mlV8QXf6tiew7ABTDXXInLoLZ5LwRYTkOjZtmEPIE4dCjdGLfyObuXO/oO2RHruCAo7HdrC1JDJhp2nZKlZB6d/nSNXBtHIt6rcOuFhnrJFpTLmjd/LvlFW2uVKywlex/TG6zUUsrIVqEFdhWek38elBdfIGF43c4PuFQf+Ewu605x0AKEpkP58xzBM8tdU8PC2OBlzzsp8fKCLqAevCcoqPS9az0L+zpD+sNQaRugQjKdC7b6u5p+nBfAwKlWIF7ESyNv7Yf2fGzWFeiTPPOYypNJW3UUa+6xAh1BNguVAQ4/uTxok/qJKZxnBp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxcXMgPNj1fBy2LmrTwfcVLkei09WGwkgWTzA2LhAZc=;
 b=QZjSANmdnpqAcOfanYIWMob5ji+UX1UeUj4OSXQySIXqHwBuIkTmwpY8avgmopruVD7XEbg/w0mjztb7JyspGguUWBjBpKjdawnxTxmpLAEES2/rOcvl9IoExyDkINYZ1JmDBJMTaw7Jn4y+xZlr8spbQTm8I5uxJyeIKKnNhRK3RwXmdX7zhcpUqlHd/CNZEzXZt7ft75I3SnevLyY/NBUEtWGv+5poKVpCml00ihGFJcF5YtABnYfGt0TfB6iuXkD9DC3l3bLb97sdEeVB1PKJMspP3+6X5KaHbsWL+E6aRVXVeTu86mfVUGzt5OkTgp8aKmipwDqXtRE/Ubu8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxcXMgPNj1fBy2LmrTwfcVLkei09WGwkgWTzA2LhAZc=;
 b=aGPWNcM41RcI6im/CY6JFUPJ+uBlceysyLPi1xfWiu5vOehZ7/g1ERRsZlVygxmUfulfqXS4WAmOyU35lKjvt4x+pivA9orr2GrXC2G61WsBJ9bdI55tWij4j5hlhSCYN+GMphB8oqDxSV3ldfw+nvKcIJ7H9YbuiFHVda4shiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM9PR04MB7508.eurprd04.prod.outlook.com (2603:10a6:20b:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Tue, 5 Jul
 2022 08:07:53 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 08:07:53 +0000
Date:   Tue, 5 Jul 2022 11:07:39 +0300
From:   Viorel Suman <viorel.suman@oss.nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
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
Subject: Re: [PATCH v6 00/14] dt-bindings: arm: freescale: Switch fsl,scu
 from txt to yaml
Message-ID: <20220705080739.duoecsmajgslvjkf@fsr-ub1664-116>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
 <0e515289-9d3c-9c61-950d-09c14b33c8c2@linaro.org>
 <20220705003955.GO819983@dragon>
 <4da347bb-4210-e9a5-1bf7-988b95b1db53@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4da347bb-4210-e9a5-1bf7-988b95b1db53@linaro.org>
X-ClientProxiedBy: AS4PR09CA0006.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::16) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f76a55e3-396e-42ed-d396-08da5e5d759d
X-MS-TrafficTypeDiagnostic: AM9PR04MB7508:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wCATTUF8TIDrO5vgqXy77cYD92aEPUBGQeciWdZ0kzudOM88zDqjEtYgklBNb/tLHI2v/iaBnXNxS+J8S1uF+bNM5GDhS6Pq5TiXRZ2VvG/dBAw0UKP0RY/25jR42gNndSZgYwstlHgG+wYd+/kD2Yd+yV5n38BDX50AAk/yVV0Zu5OISG2UBIdXuLeu/GUbmSRvsPlrnDGKSiQYN4FsrpUXcYxP+PjhijmbGpLcRMuLEPdOCRjRY/AK7alMTqBCLQZj0I47Kw5ke9Pdgg6x27Pg3vuUdYsGv9WwmsKI7wBvfrF0mhwJAx+4iGNMKHWDYVchUYm4xarQnKWlIXPrBXxTrGFEHJHd+WdqB3zA0eQ9NlSigR+NzTB5ed1B1gj28zIhkm6VKXGdpYBMtk9a1YDXz5RUs9SaRYxXNDlD3p9k2y46gDxzsbJwPdgpLjjuI5KSas/AQxhRthQp/o0MLAio3nSHf68Cb6FghwyCPYr8o7p1G/EZD0B+1MzXDG2yMdlxHWNS8JxQfTP38WOJ19o/SjsqdT3X4G12WEMZkGLSwFtWWT3bSuaXKVxwk2GWB5uw8auwBV07IvGXElsdHQV5Xgy6JFYeKzr7HCpstJYuA1eJjqaxN1/+fMOMc8frog6H/ttSGvaJY4dZk5gdwFAVRKwcFK3Znvhe70tZdhhB4L6PVL1HG8bGI8rATye0+41FIEm+4L8eW6l+uzV90+Oa81vV4lFmcUWO7a0nookI9Lcm1mSktHfZN3onE278TS8Dq/6PUmslJCFUsg5MtwIdPtuyHjZwm/plrxEMWE+V2yOjro0Hsl9CczQkE8AOyA6OaMI0VDalwxxsswMbvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(396003)(366004)(39860400002)(136003)(346002)(8936002)(966005)(478600001)(86362001)(83380400001)(5660300002)(7416002)(7406005)(44832011)(6486002)(186003)(6916009)(316002)(54906003)(1076003)(9686003)(2906002)(33716001)(26005)(38350700002)(6506007)(6512007)(38100700002)(41300700001)(6666004)(53546011)(52116002)(66946007)(4326008)(8676002)(3716004)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H5WaZmAkxzqdKH58ARsezgPR2nqSNPoh7jz7H0yFwh/aj6oCInONB5eeXM0c?=
 =?us-ascii?Q?po3EycvUqAFTXTf8708PJ9oMJTKdo2XRkJg1AJPVoYwvWxUIHBmCigxmhGCh?=
 =?us-ascii?Q?IFu1IVESVPrJzZQUQcVO0jEmW905NUWz/Ca8AIE7EpkI+TsPL+NoDxjU2kvV?=
 =?us-ascii?Q?yWDKflxix8DkgV8L4/Qnbq3AScDMBIBm7BGExrEwc1wB3MGHJpM0aJZcbyuT?=
 =?us-ascii?Q?9LbgYBJsspvw0F0p1G96lK53KMbtQWHwBYjbfV6uzCcTNO9fbcXWJop8Iwel?=
 =?us-ascii?Q?iuVtupCV9o0QgpkMdbDpuS+QEY6MUhMOE+QwXHLt31cNrfkWIr1CgtBTYa22?=
 =?us-ascii?Q?mwqGs8PBHozBiNMlZ9ONrJd4BqzK3/bVpGez3zzutkOi/YKmf/uflkKmOjYA?=
 =?us-ascii?Q?F6SJ4HsgG0u1z/BGEiEi6zE/o/+aww4Dz+FHuH5dfI2NemP753g7RUHX5h0R?=
 =?us-ascii?Q?iG/jeuxK7vti/poTXr5/tzTc+2bO3ifthyAs1EjEKUxvo0nCcmFKE9Pk+Fbs?=
 =?us-ascii?Q?ldLHKXQ4nyKYvabSwYh6Y66i+bexTbCqMDsuixZ0B98UXP9a9LSzPpv2/vIn?=
 =?us-ascii?Q?K5irXbDBEkZKoyzYwz+TVJRgcD5vKf1//YoYfBSw86cvCPJZuV7YD8/CyMet?=
 =?us-ascii?Q?kZTMttnMqN4SPbdwh90gDRBLqOAPfKIVnTlMvlZ7nWQsXYdL0ttaxh4+4wcs?=
 =?us-ascii?Q?yXyyEtRh4qUASMgx/s/9AVKQWGsAUiZya7msK+RHE6gwJgHGvTc1SzSAZ5xB?=
 =?us-ascii?Q?+gcEvZCuRN7qadTI59auvJ578Fcb1DqCsBwYKDTaoEFwvrxcVuTaxTlK1tU8?=
 =?us-ascii?Q?xRvGWHYcClZQlxAskS2wVJVofmR9qNxwQC9RxFDNf7WZNB9L8Lyt97jys9jf?=
 =?us-ascii?Q?bO4x5a/B5za9UcjDvvfIHOjjD6qGhEcYqaywJtF/3HnynavHMIsPPdr1LjEv?=
 =?us-ascii?Q?Ozx9+Qop9kAA191Z6kkB+yXIDukhnuIdYJJhIUOoNKB3BVdI7GLRdWcEaz2F?=
 =?us-ascii?Q?Gw6NpkDLCUZSnPCrCDyU3/+sDrsd9ZguX3Nm1KYO5LQxznDjS0OZVobQhKnI?=
 =?us-ascii?Q?ep/m7KhfNAVP1JJg/qnoGRs4ocg3gVVtHfOCIf+O20PmxypLlREOwshq1bTH?=
 =?us-ascii?Q?/yDU3K5jPw4XUWT90f/+teWCeQr8z51DFJam3Ual/GvTPuwhYwyYccnd9vjZ?=
 =?us-ascii?Q?/yQOvSxQF8WszqXxUZlhzt0NmEJX4I8aqXstBhwheNCkG/xRh/m8qzPAcL2i?=
 =?us-ascii?Q?Y9LWe5TB0YnQoFlqmsmo512PLD9yrURrwb/cds3mLMGH4pfjmH+g3V0rd0aF?=
 =?us-ascii?Q?Ls8f1F1rsf+fOyDGrVolWAqWQ0oIozGel95tamQOfJkfndQPfh3EXego0l1l?=
 =?us-ascii?Q?WydwKxzJM0xbE0sxyzjFQH9YtHbN6yWpn4OhH2qVOdtX62/gfwK96LBVLZEm?=
 =?us-ascii?Q?VFIrkwXKgkzq8dhXqzsT0hsy73qTd4ic03rNfuxPaCwPmcs0itujIP4JIwlQ?=
 =?us-ascii?Q?heF2DsuASm1MnZ3Lc8GgEefyaF+6IWciG11fbIWiaquM+zNcjJ/oJS0FzxoZ?=
 =?us-ascii?Q?zZptY/ro5M+SvebMpLh1eMjFwCCki2uz0NxdLlIj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76a55e3-396e-42ed-d396-08da5e5d759d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 08:07:52.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfAjc3GKCn5YF/NjN5ERPmmq1j7yuW+shaBAkKIKoruR+vH+aPIWGaw9ibkNsjiL/b0dpJ03Zfg1eiSamymkIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7508
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-05 09:28:24, Krzysztof Kozlowski wrote:
> On 05/07/2022 02:39, Shawn Guo wrote:
> > On Wed, Jun 29, 2022 at 07:51:06PM +0200, Krzysztof Kozlowski wrote:
> >> On 29/06/2022 18:44, Viorel Suman (OSS) wrote:
> >>> From: Viorel Suman <viorel.suman@nxp.com>
> >>>
> >>> Changes since v5: https://lore.kernel.org/lkml/20220616164303.790379-1-viorel.suman@nxp.com/
> >>>   * Updated according to Krzysztof Kozlowski comments
> >>>
> >>
> >> My comment a about removal of each part of TXT bindings in each patch,
> >> was not addressed. Your approach makes it more difficult to read patches
> >> and makes sense only if each subsystem maintainer will take the patches
> >> (separately). If the patches are going through one tree, then better to
> >> remove the TXT gradually.
> >>
> >> So the question - who is going to take each of the patches?
> > 
> > I can take the series through IMX tree if that makes the most sense.
> 
> Sounds fine to me. Then however each piece of TXT file should be removed
> in each commit doing that piece conversion.
> 
> Best regards,
> Krzysztof

Just sent v7 which removes TXT in each commit which does the conversion.

Regards,
Viorel
