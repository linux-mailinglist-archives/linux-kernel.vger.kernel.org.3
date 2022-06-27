Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C65155C5B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239949AbiF0MCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbiF0Lxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:53:33 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140078.outbound.protection.outlook.com [40.107.14.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17469DFD5;
        Mon, 27 Jun 2022 04:50:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsuEEU405zu9dpeAY2r3/56uoQ6njmozL2DL+ULqyz0IVpvEUN76r4NYh8SBSaTgkwnv9GQbtcqW7aQ33LmpHLZByU4y5YmgNWwsI40K+CMLNqYyU20T84TNb5XWMzvSnbgZwkVP1kPARqKJ9nXzheN6wbB+J1KWajY70bcMoNbDbWoo9HFgjT4YlP9uHLbuUHdPjcAGaXfrO0doTtCbz8AxXx+w7bRveNUIGzoG6e1mQMtQAXpCBTfhkG9XUeyxtWU8Js2BMNw7ObWIvBZS4+Z65sMuVjuyrbfkgRQPv7nV0E4Y/rGApHbBQpWWP8csfjoDo/g2EV231Cpgbff7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHge1mOZi7B52SFpKOWy5FFR1kjh/HiE0mYl8VY7Rp8=;
 b=HKQ/TKXg2VemiaK3T8LxXI/Ql0KqmUyP1sk8GrfXs61PllWN/LnUgW+fxSHUSV1c+ZN7F9rmk3j3FqsYmvkvlYKiUP3bONr5eKdBZqTBDNu3cylGEWPmbwNNpxy0oGbLkybZa1KgjmL9+appSmN9RFQ3VCMziKCFT2eqg/icLVCX3RL7L6qObEqNwSgfbJycstl1DAhSA3HIHeIv44pz3mWBO+Ozdd+y6HRBzL9/utBho0vqaFe0sdKf8KQUF6GGQoXXiV/2fPW8pc2oeL8WL9hmtGgrMLHdPfyvlwSlsMZdDMqcp8EMY8u928Pe9LsawiQRe5y7b1jbwVGzR3ffYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHge1mOZi7B52SFpKOWy5FFR1kjh/HiE0mYl8VY7Rp8=;
 b=TayJQzofilL7hZsUc+w/2Fh45wAfpMCPOlRhtVWRzwjbLP7WfEwRb+ya1OR82Jwim+m4fbWpMWcGD9whGvMM11MQbBqZmqv0vbQfZB4pqdFwyNKIxnRgR47hwmM3Pbeq9hxfkYPvyDyRd3SkTf16AztqhGusnDvE22Fq91cPw0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB7PR04MB5484.eurprd04.prod.outlook.com (2603:10a6:10:8a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 11:50:05 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5373.015; Mon, 27 Jun 2022
 11:50:05 +0000
Date:   Mon, 27 Jun 2022 14:49:49 +0300
From:   Viorel Suman <viorel.suman@nxp.com>
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
        Oliver Graute <oliver.graute@kococonnector.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [PATCH v5 10/14] dt-bindings: firmware: Add fsl,scu yaml file
Message-ID: <20220627114949.pg7az36fz4jrwebp@fsr-ub1664-116>
References: <20220616164303.790379-1-viorel.suman@nxp.com>
 <20220616164303.790379-11-viorel.suman@nxp.com>
 <b653d7af-f846-abb2-d260-3ce615b070a4@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b653d7af-f846-abb2-d260-3ce615b070a4@linaro.org>
X-ClientProxiedBy: AM3PR05CA0150.eurprd05.prod.outlook.com
 (2603:10a6:207:3::28) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0448d220-e139-44e5-1291-08da58332d0a
X-MS-TrafficTypeDiagnostic: DB7PR04MB5484:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPgC7Av1gG3RCcUKNTSd2+8WnY1V2XUBS1HW0tFJqMqyBwAMhsYlJnQMZn4fFss0zJ3jEGXBItqMcettNuiBf1poybjcRtSRghaEXtCSAEwdvfWTuEo2tbssK/bli/lNKpdGL2gW+1JNbClV+G8uLImV8fhRL76ErYDXK+ZgL8k+A99yicqQ6G+DbAraemHrIkks2spVPvYdJMj+AYkNjcHcT/IpsBW8rOf0CaaME9D+eOfkeSeCYy4Uye+4UD6Y33P4hVlIm4MAg34sBiKOq43CR6RPkdE/ufpTmiJLB9lgABHfgomdDhQc1HOHfmqDoGEb9avLS2G4Fhg/kYjDn0DP+qoTNZgpnTXoCE4tLtwHFA8/r3ObEPNcemkR8QBcUT23UE1/Y/FryPRIyJqxR2TFgnsgGFT07bJvxmiXOeDkCaTAsgROVIyh/PA1qmBx49OH/ZSVtAUz41LMNnhEzQLtnrT/s3MOtPmeprMCXKgNrCSWZHuuAYkyS0jvbYFpDQ4/jUx4K0k3dI7DUBg51R8zOBCjaFLvdOaCG5XWeYS7jbyhDwveuvUKPt64/AW5ZgoJVvLAAYmjxb5WrRPg+notEwOMo1NkVYueU/oh26mJXpT3Vl2GdxBEdWqDEe6xPuUi3MomcfAusMRfcz9/5OrUVsaduTrcv8OQ3oejs9xOZtXu3JSSfE5p40vjHM+AN2jxvxMtrfJmZ53dbHoSjKrXlfOKGvRutwKRm4fwvp8AJ8FnUzBOVCZPGodx/eQQNYDRaoxCDmark2XYjcM1Y7KvZV08CYqWUOzjLSJ7cKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(136003)(366004)(376002)(346002)(396003)(6916009)(54906003)(83380400001)(41300700001)(86362001)(44832011)(316002)(7406005)(5660300002)(186003)(1076003)(4326008)(8936002)(38100700002)(6486002)(6666004)(7416002)(478600001)(8676002)(33716001)(53546011)(9686003)(52116002)(26005)(6512007)(6506007)(2906002)(66476007)(66946007)(38350700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k4GOIOj9KR0SmLgkAxygpLWtFlhX9zo5cS18dcl24GYoItxuKvWDtvDBt7jd?=
 =?us-ascii?Q?D6aAghnkXqJ3mwg+l9iTLdrZ2tOUJISeYQ3pLrL2BF9/6IDMI8yoSiTA/+SO?=
 =?us-ascii?Q?w8zxRCEEICGNW0r3XQdv8K8mYklhCLL5ijNPuq+pc7n7IXyf7G1/AF64vQYK?=
 =?us-ascii?Q?6+no8iz2yGFQHE79mDiBmyNsVa+eS5MQYWg0Ijp+RcxqGl27Uaq9RH7aOTS2?=
 =?us-ascii?Q?0G84nWG+0C/LJFbl6k21UTKNIu9uT8T+E+dGfZkoHLYjrsZDV7CXYBLT4hWO?=
 =?us-ascii?Q?gnVPjCJvWa0vDJg6aH2+UrPCGEeEvQeUeSVTDMsEO6a/losnMaZJXjOZuFyg?=
 =?us-ascii?Q?LzbsP+E/Wikp54frMrk0tTm4ngtm6YNhKtvccdSaz1dYyjeXgo0ignLEqVjv?=
 =?us-ascii?Q?IBmlCMh1We55iWWQL8L3Qt6y8/k+l7NR+Z7qN6GTWDvtZnBZVmSAwcY48a2p?=
 =?us-ascii?Q?Xt+upYS2Ble9kbTZ0fN39REFDoF45olZ4oUasyL+bcmS3MXdF6Zm2q+0VE+X?=
 =?us-ascii?Q?NDfutwV4PkkKxN5UpxlL/NnR7PO273lY7+scjT+w53mreQSU+oxKPSQzsTpd?=
 =?us-ascii?Q?A1Nixh0OB3tJYCZANx9mjgbMrQo5PJP1sczFaRvlH8xv2ULZsYJP2ZwasCCs?=
 =?us-ascii?Q?wN3/RjE2Y31TUtsIzdyMAB5PnzdhjCAS280DmAL4+PR5YdEnFGEHRbv1SSwj?=
 =?us-ascii?Q?7UHzOV6El67dfI0Q9MbY6hSnXV5ECTX6bf3LbvHNyGI7XXkMVWI5Vpz+1B0R?=
 =?us-ascii?Q?8jJOhKEJr2LyFTCa4uMKcWeGeCropp+0QpXZ8UUawopJ/C3+Yv6OBQ/LCsoV?=
 =?us-ascii?Q?WueDcRf7uN3t4cuHITSFpcaLCWXHcwKPNzmLGKwiSTl1QSgpUmNXjhpbHT1Y?=
 =?us-ascii?Q?fBUXhQ09WA/PsfGpy6VYJU0nYy1wkpjkneFCpbALNizcjPV1Mx1GGQRMPJ9B?=
 =?us-ascii?Q?P2HiRfFQuf8DtU96UFFozPtXZ/9MuSMIc9WiZT0KTZKrBZisfGLud2zr+3pb?=
 =?us-ascii?Q?4A7Q7hmd2Nx91pu4lAT1Qb9BlWlUFNCEvuhjeQeOAEFwaYDMM24UVx2mTlup?=
 =?us-ascii?Q?V+OJBhg+IRfsOlZ2Q7bx3LoSPG1VxtRmJ/hCvX9NMIbOwIZK1oz0Hwk9D+8v?=
 =?us-ascii?Q?GkO6MmTD0rbD0fGgpKIAkYbI/gVvq9AA4VfYDXsVgt56JigQSVDP/rrDWjqo?=
 =?us-ascii?Q?8KdbKXiC2XypZUbuO6kIYuYKxQdefXxBvuFl4LG4VjZj8VImk3ARAlDxWeGs?=
 =?us-ascii?Q?ZdlyiOl5AGlmoWIabgUf7o76q+aUXcItvfXkrO6iWUS0BXsUSnyGrvCijGjT?=
 =?us-ascii?Q?lPudeSRQnWv1XJSGwLO2mAndyjZZrhWk6PxFIgG8OFWTEcz6lGxUL/EUiJQX?=
 =?us-ascii?Q?9Uuq0bkB2oTkTUPC521GB/xZWrvsBBDV4VxCCgZcpXFnniod+u7sD1IDOZoK?=
 =?us-ascii?Q?aYyfp8K7ECQVUQq8h8NzEKojDbaumqwUBf7dFAZ7/+8/9161Cz8kHdpK65bM?=
 =?us-ascii?Q?N2ZqmX+e3s+LzN6OJRqHkbK8ixoKcsqOHWWWslR+zdOSfscs+6HOOtW+HDrW?=
 =?us-ascii?Q?KQh3rQs9WUOpBL9N3BB6EiBOk9yzGK/FHOpf5s0A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0448d220-e139-44e5-1291-08da58332d0a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 11:50:05.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxe8mnobozH6XABoZZHiGNnxa/aMVBz+N7ZWJxXfGM1kmvWTrzfxtASuPoS11u+MFyyvB1TV6GUOLzwFunZ4/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5484
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-24 12:25:44, Krzysztof Kozlowski wrote:
> On 16/06/2022 18:42, Viorel Suman wrote:
> > From: Abel Vesa <abel.vesa@nxp.com>
> > 
> > In order to replace the fsl,scu txt file from bindings/arm/freescale,
> > we need to split it between the right subsystems. This patch adds the
> > fsl,scu.yaml in the firmware bindings folder. This one is only for
> > the main SCU node. The old txt file will be removed only after all
> > the child nodes have been properly switch to yaml.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > ---
> >  .../devicetree/bindings/firmware/fsl,scu.yaml | 170 ++++++++++++++++++
> >  1 file changed, 170 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml

[...]

> > +properties:
> > +  $nodename:
> > +    const: 'scu'
> 
> Why enforcing node name? Second point is that node names should be
> generic, so I wonder what "SCU" exactly means and whether it is generic?
> 

It stands for "System Control Unit" - looks generic to me.
I guess a reason to enforce it - need to check with Abel - might be
the need to group multiple SCU implementations under a common known name.

> > +
> > +  compatible:
> > +    const: fsl,imx-scu
> > +
> > +  clock-controller:
> > +    description: |
> > +      $ref: /schemas/clock/fsl,scu-clk.yaml
> 
> That's not a valid syntax. ref is not part of description
> 

Right, will fix that, thank you for review.

Regards,
Viorel

