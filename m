Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1B35621BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbiF3SLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbiF3SLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:11:33 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8553AA6F;
        Thu, 30 Jun 2022 11:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HG+k/gOZFZTbjk7pwAjaRAYri60m8QPBg9BXTQ3khR4+nkY2Z4zWt7FXqBxBATskMv5uNrfGTh8v09aTFRP86tc5LK+bkK/bjCWG3a/45UJWaqVupIqXFVahkPXxzfIqEznv9k85qlFHn++PFUnJqx9nquBEgQKcDqGSkfKIApsvhKcI2TBcadpIOZsExrvtUbPHPHbKA7hnIUazf1RIOJnE4h0kfMDO04YvJ7i2MG6KrNY4y889lLP/Bx8xuvQ4RipE0ZoOpU61RS547AMT/UtiQGb3D/tz1lLNaXYN7LrlraE9kdZaFTg5CvgDFmjHIcUW+N0UmwzISXhmS2KUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvmN3vLS0sVKA7kNQGUlQJqf/Fs6lU4peowKtuhXyuI=;
 b=F6JWSPIL5WtEusK7IFHIZC1aLScmbXeoq3nyl1+kjyGb4SHxgT2KnSeQBlEmYXgk7E0tU/jVSEr/k1qcX8btPBIc1sErSMgfvLeurub0Yu9L4S2bbwnvMMVE4KjO5rPrDWtFCm6iSoqHAwmfyOK6lgvtThWJ3wJNVgyhhplQNUWV+xze2frVk6GW5kMv68/yonqkiSmxtA0y9bXHMb/FG9kKLnQJ5Au782Yma3gSXYAY1wl0RGJxM1TuaccxF7UWSpmP8Xt/9AiZ8vkur5PJS7dioJVTOgY2UiE5HnuByl6KVrZKgy5USpO2XQ+0vbON1YCb1d3XgWyGj29IvaW16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvmN3vLS0sVKA7kNQGUlQJqf/Fs6lU4peowKtuhXyuI=;
 b=Fw93oNiWZnhtnUFv3L7NPDnbqXuWV77/WwvuM6XJlDwDDXsWOA8epfyAxjaSYvkdh5tsG3AAs1EAzg7Wq5Vzuyd1obq+sD83sWysYPR/YFFSpj0HvcYVz+UmhfjgVLMvIdXnAh6Zr/HhEIy+51WQs/+2BIKjchgA4dcLg/b7GeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM9PR04MB8620.eurprd04.prod.outlook.com (2603:10a6:20b:43b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 18:11:27 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 18:11:27 +0000
Date:   Thu, 30 Jun 2022 21:11:12 +0300
From:   Viorel Suman <viorel.suman@oss.nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH v6 00/14] dt-bindings: arm: freescale: Switch fsl,scu
 from txt to yaml
Message-ID: <20220630181112.mr2256ukhcfnqrvj@fsr-ub1664-116>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
 <0e515289-9d3c-9c61-950d-09c14b33c8c2@linaro.org>
 <20220630121042.7kwomc4jc4zppoyw@fsr-ub1664-116>
 <c4f26508-45bb-d553-36b9-27ace8bed71f@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4f26508-45bb-d553-36b9-27ace8bed71f@linaro.org>
X-ClientProxiedBy: AS4P189CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::15) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b0370cb-9c44-420e-537f-08da5ac3f301
X-MS-TrafficTypeDiagnostic: AM9PR04MB8620:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wU+jJIEUQANyIC3HvEoYIgdtsewgzI8Fa1c3B5rgKxrU/MtqBoqt+5J4KuI6yxn8QIwiOEZ+0D+/nCDbGbo5L+g8zPMGVCP1i02eCh6sORoaK+/CgIL3zSn1/WmdUyR8N7Os/1P8YVEH5J/iayZ8YzqjN3YNpxK8X9xGU3y4+rlX+/Iad+C1XAERw4z1TadPSxc0WIng7XsPjh1NHxtrpwe/k0YT2AikUP82JCs5LDQc+SZobYNoBA3H8VG98BsHNiNXfXYLyiEF1qBIEz0aKpzJYAOu4+Mf6gxS85fBXRjHvm2/6Bme0dIkztBhyXdJA/fPDC+JHtSUMmFd2ataR5Tofn6f+XwY3uzAlzz1IK9hCn2FiYbvlJynxYHktmiTMaJva++rqdEOjvvYiYE0u1qEFYTiagcimZRQnBB3gL4Dxz7sTY5ECYOYrEDBayAL2KImc80Lvs9mN2F52bbP59lOldS3LCwLL4R3tFu3GUSOx3ZpcojUnVmfECu6e+S1cAAxCRUm0t0brRiTv86SqlgkwX2I9GYLJzCC28SIIGfviZopRAY0GuWSNa6osKd0RZ9gClnXFQcTuUUSUPeX3VcahsYblZiVDeX475ept2rWyxNKoPGuOQzymibqyf8WPbutQWzJc9I0GFdypxLxGE2xxNpp1U7+OCvCQaqpTI4mns7dpqIbhD/HC8Ln13zg/sU3XYpWsEdbD3yBvJN8rlLQJU4iVVzKFE+aaGTwhjMprDw/NSn2hvcGld6glA+k27pBcwG3hjmsiyHHFkv5R77rIQde6V5F822s2CBa3JVRsXyRDs/avOKWRV780FsQ/tDIxWNcEhUtHxWcmGiSgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(66946007)(66476007)(66556008)(38350700002)(86362001)(38100700002)(7406005)(54906003)(4326008)(8676002)(6512007)(9686003)(52116002)(53546011)(186003)(5660300002)(26005)(1076003)(33716001)(6506007)(316002)(966005)(6486002)(41300700001)(6666004)(7416002)(478600001)(2906002)(44832011)(83380400001)(8936002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?36HGGGWQXzib4Ot+n71zyCgjVMzinMBXe7iFvZflD+KC7lM22GnQ7DbAZBn3?=
 =?us-ascii?Q?7XUWNIShGgrCeyJLRcUkhQM3u+EOk2kJWyrtsIhBKdLKavr/8TXWjlIA1iR0?=
 =?us-ascii?Q?Z1F2ArrHNVa80LUn07KDR3hmttg7Usk24FWRIrpafIGp4oiltrAK69oGgTJh?=
 =?us-ascii?Q?0KRpWJqSsd2tylwJCqS8TYYgmRbgj4/lDQSDSM/kwHQUA2C+tg04wBABR08i?=
 =?us-ascii?Q?L6JkDIqdTbi1QdyQ9Ze3KXilCSP6DPM9zqTAtxGVpiasVOeqwlreubBN3VDo?=
 =?us-ascii?Q?MocfgFS032PDE8e9g6F4UWT3YbgHV5jCc1v+GNpu0gFJdRwuGSNkr1VPU2oo?=
 =?us-ascii?Q?rXpEAGlzZJAi3Tu5lh7iw7nUKpyiWjUBxLB9i9+qsEuKpS76+IqZeCHaiRku?=
 =?us-ascii?Q?tusUKD989D3OcSznRlgWvwsxn4XmrWRsx6C3bl0lVPZ9lfR9zpzXYisB9QNA?=
 =?us-ascii?Q?14sHY5rb544Efqhbgpy0CL4nRQqpx5YoC2HGWEQAiG5nKszjDzanyUFdWFWc?=
 =?us-ascii?Q?ahxcw9c+Y1S0LAWLIuoDTxOMiMoEdyR8UVsbXG936weQPNeCTgQ4+lgqQI3/?=
 =?us-ascii?Q?Ow52x3seRZPvlplF5E4WaE4TZzAdji2CB2FAVmkog38yJDw4VcNHIUZOqy8w?=
 =?us-ascii?Q?wIuHngZ6RuITDycBGsMlBHGy8sCq9kb/dJGdeoBLWfdhWBKboPO+tNAEzTBD?=
 =?us-ascii?Q?1QPp+nqVCBp8fzfXMtaedBZlNmEjgu8cZzzskAFLYHS04mMI5tS9NPGrIVTB?=
 =?us-ascii?Q?s/7v7qnd0gOZ9w5B1tl7w8m9Lv931V0JByDtITXjK70+pvEvVBf6VOzX+ae7?=
 =?us-ascii?Q?DGO1uGIX4hrRviEqQ7IcCprOQFvDNAtjkDgpaPE0tBLXZk8OTbXxzpddRE6v?=
 =?us-ascii?Q?JNjbA14u8DthkgKtpPXa/5aI4l8UXTy1qhxJHy62TSR5Anc2ypDAbTspyDoY?=
 =?us-ascii?Q?UkDs9uQFFPvRUW8qmtURxhWVcYdPPxmX8HUzHfLXIkkUvQGeKtJYNCkXr1HR?=
 =?us-ascii?Q?xMUN2aD9vtlJ8dW3KEmI/CQSgMuE1vIUhtbe/4a1EoYArSCEuotc/IiZB2n1?=
 =?us-ascii?Q?ZJPNjMLhuJ00R/GLIoZ7NgVB0xa9rEpA2w4E0BoVq1wSUqSNozcctKkm+41v?=
 =?us-ascii?Q?8qvdRvkEwwws6jQVWZ2hn1F0Ndyd1joX1865DUpUZT+vF58EKBdIYsJhbK6s?=
 =?us-ascii?Q?hMvXxtYVhH6utNnspwgQEc9ATe/wsLvYt6ws4YNH1jTgG9ZcmBSfj7JWuOm4?=
 =?us-ascii?Q?KOaqSbeeDWDtnPhbGg6rA841UK00Ry63LYKGP6LUG3/Lv4x4aKOeSTY21FfS?=
 =?us-ascii?Q?ZIxTxK+NwLuFFukR8JkTatk1TbF0Vg/t3zgdE3llx67p4wGk1Tjcxg0QJhCA?=
 =?us-ascii?Q?aUHfT05vXU7Fx/kwA1FnbuewFH23DFHRpn6Rf4DwRjgGJ3/Az1gGjS9ySMDf?=
 =?us-ascii?Q?NRhrzBNywNyMJg2K96AsCPU6UDUJHNwJcROupbxTFrkD1uHg20EbD4WSeSA7?=
 =?us-ascii?Q?Nrh0Wr1Dt167TNnPw/bWnsTldp9m43bATBJ5bMb0Zina+1Hz4wQGWOnY98V9?=
 =?us-ascii?Q?CyR6CwCkBnVqdpKQxrpcamufEqYsEK2tVCZpSmIy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0370cb-9c44-420e-537f-08da5ac3f301
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 18:11:27.0138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vh/b/X5hXuhX/PY0I4gTl19a8cO+X4ayzT9kkBCrmk1fp1TaW4cVzVC+TEa16UY1VFGnPLaf+Uc6jCLSGn4rIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8620
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-30 20:03:07, Krzysztof Kozlowski wrote:
> On 30/06/2022 14:13, Viorel Suman (OSS) wrote:
> > On 22-06-29 19:51:06, Krzysztof Kozlowski wrote:
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
> > Hi Krzysztof,
> > 
> > I just understood the context of your comment, will do it in the next version.
> > 
> > Assuming TXT is removed from aggregating TXT - fsl,scu.txt - gradually, do you expect the
> > removed to be added into the aggregating YAML - fsl,scu.yaml - also gradually within the
> > same patch ?
> 
> Each patch making the conversion should remove the piece being
> converted. Then finally the patch adding fsl,scu.yaml should remove the
> last pieces (remaining ones).

Thank you for clarification, will follow this approach in the next version.

Regards,
Viorel
