Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2992A544E33
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244444AbiFINzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243565AbiFINzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:55:33 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30053.outbound.protection.outlook.com [40.107.3.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589B733E1D;
        Thu,  9 Jun 2022 06:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqJgnAHT63n/kvR+9FWFzloi+vewQkNP/ulavWP6z7TaMdMr2WNYmdm0JVwQ4ViVb50S3VwyES74QA2cklt0GNe6i1+m0Efld0DQ664tGr6PxVo29sjTkjnieJrgutZYOgfmh2aDHAuu3ltxVe1+SeCaGfap0VIJ7hF6KmPudfzLUpPp7mdkr8zSbbfNBEF1qcF7lyGebmbWA8tkZBSXHzIUW9EBLgm3fO/oN9jNSKBFWA+gnYkMJGtuykHndFja8Qn8ZATYOZSmC90FCOuIrxaFKepAigCXdkCpKiyPtHddVnUPa8PJYN9xvTVf9UlwTOtBqXd7MGBzPqE06TUQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oz9nGnF0VDq3aCXTGnDBxDQ4RFbjS6TO/aHkLTzDQpI=;
 b=e/Brh5xlNlh2hNtBdnUXIMp+Yv8ew0PdJ1v6jFYdmg6dDiBpXq3ZXb5SbJ10LKq7S5i0az1BbVoDHP1zRMqjW4/y1t/Myy6txDEgvD1FSBaBMjH4mwl4NLtglgT/P9gdsZ0UJMj1KEwOp8sffmhF5kVBmnBkXuIBawX9r1Nk5C3ttvMNfpc98lddH/dDa+2tiEODk5n+gdUu3ql0vT4jIQ/TUzEjbIUGCnfD1O35qcP1hJ72LfgC+LKsnxF6/5Luvv8TTAdKO4yo2Kyx4iyPbFy6QxRK6UZ8WYqC84GqpMs9IiYCEGa4HOYutbnAN00Df/Npk5cUhvCwAwQwmfvSqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oz9nGnF0VDq3aCXTGnDBxDQ4RFbjS6TO/aHkLTzDQpI=;
 b=OptSIMTerKSBX641WspyNCaaRXArilHhUGDNVFpogMNs/7AoDimAUauQNODCFEqlR0I+wZhqJRQCVuN7jSEwkJmg34W9gSXYSFWVkvxoJF5S7bzwxqfEr7Ho9CoFYn5OWGX7kn6KEgMB+9yTut+J2IdmiauaDbIQU71i6fH5NeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM9PR04MB8970.eurprd04.prod.outlook.com (2603:10a6:20b:409::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Thu, 9 Jun
 2022 13:55:30 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 13:55:29 +0000
Date:   Thu, 9 Jun 2022 16:55:26 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 07/10] dt-bindings: rtc: Add fsl,scu-rtc yaml file
Message-ID: <YqH7znVBPn1PEooj@abelvesa>
References: <20220608164928.2706697-1-abel.vesa@nxp.com>
 <20220608164928.2706697-8-abel.vesa@nxp.com>
 <YqDWt0w8/9bwz5OL@mail.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqDWt0w8/9bwz5OL@mail.local>
X-ClientProxiedBy: AS9P251CA0016.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:50f::28) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33245b5a-bc5f-4b9d-fc75-08da4a1fb680
X-MS-TrafficTypeDiagnostic: AM9PR04MB8970:EE_
X-Microsoft-Antispam-PRVS: <AM9PR04MB897036B12B02221ECB27E761F6A79@AM9PR04MB8970.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDfI8xaAdzD1Q8RoHQQp6Fec2OWJabgMYO0PYlYiuY94PeRT7wkRaJkQRN+TC1+9NeBRXYi9QRweLn2wz7Au1TG7lQ5oEoS52u12DaZuZIJmSugwXTTVxL8ittt46gf+Be7DZwH2p3+dOSNV2nkyr03g6nZFNwh/W0vN2PI5oX1a6B8Wu32x0dT5OsejCWQRlAD7pOaxsptrE79sz7g0qkEKxgaxtLvgoQJjV1Rgz8ovwOESPkkmFsvdoyXO1cBUBgm+33Ob15NmTxAw1sC6+/GrZZI/5ryxYI1iKcUvF7tjjCUb+7kBCGmF+7x36S6RqcUjWq2dBJ+F5nUeY+3s3/teUKsoeCY8awE3mAJZYu2epomXlSd1jkYrVZ3a0Khn+x5mG7t+CYKA8DbjML8b1tcbbxROC0pU0c+jMOpJi6jT4vIMzCl53B9g+FqLy3iRTFIjae6ct6IOMvX0dj37aMVz4GOZPdtGvYQr47cHr/fXUwCpFCkOLAL6yL0W+6rgAhQtU9s1fBAF43//lnzaSnTjNqFYG0GbWRJRAkiuS7aPOXpt93UWvugeeyGAEUPYpldBIJDWq3PLuxVYmz79yFhwmHSgmsGZ3xsrcLCob+W5vqsTEburQOC4jqF/qs73BbOfz7BocGUuSfvqK/IbbfXJGSMAVNBVrFB1EPJfhXJPWiCVev9A4Hv/XytF3/E7SLRLr8K4jAkOsLkI0jsIzP0ob/f2fb8u1Ub3zyC3rcwyVxxDnhQEG1JHtFDTnwHL+wS5btX4f1ebGQRbYg2+pTleXOHWvBz0pH8qZX6bsHIRc8O0NvXjrVDrp0gOXdwNrQrzyyCSNoQhmiUg+G2QJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(8676002)(86362001)(7416002)(66476007)(8936002)(508600001)(6486002)(966005)(38350700002)(44832011)(83380400001)(5660300002)(4326008)(66556008)(33716001)(38100700002)(66946007)(6666004)(6506007)(52116002)(186003)(53546011)(9686003)(6512007)(26005)(54906003)(6916009)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b/R3VsockM68cf17pbzeul1rOIdWLmf5f8+UcUApnC9x4xIu66VnYONtiryA?=
 =?us-ascii?Q?op/MZ6vQAz91xwyLvPYGVBedcgYz1PcVjTE1HIPfG1c2TDKD+fz6JKQYmTKu?=
 =?us-ascii?Q?vbjT3ke9DwORo0LnmgwP5z+llQ+o8Bu/GLt0meQ9Hvy6oAJI7cE9kpamc/1h?=
 =?us-ascii?Q?5MgG4MccjRjnZqoghYcuDMdQi55+r05D2HKG0E96vLH52GY17YdT54/lZvYr?=
 =?us-ascii?Q?j8fY3kyZHNPS1vIrfrIiLFAgf23o4lOcmbMuktBnzpKSfqITy6/ZcT63Qjg6?=
 =?us-ascii?Q?oUdiydlXo6voNB6vODxV6zYHwraSVfD1S3xByR/e6bvEZfaYmyVDVVOWxpHc?=
 =?us-ascii?Q?q87HZbXgsk2SKx80Q8oSdsSdrNyZQAry7UNub5W6NzuOzQc6ThdRACeTQbOw?=
 =?us-ascii?Q?1r4V7nujYVaTIyW6cqD2OHQx3ha031Ij7Bc8sH5ObHyS7GPfpWPysGreSoLe?=
 =?us-ascii?Q?9eKyaNIscgEg1aBamVveMAHEWZGAv15MCAm7loWmWB0S2Ib+z+DtULyGSA+7?=
 =?us-ascii?Q?26O960VSoyl2BWV8aERZ7RVJN6n2e/4WObopYlZo9UqfHqd1HCADwMp4OWtw?=
 =?us-ascii?Q?o5za8qIJRQEczUrXtFbC57xBhon9GABuJwNhjb3KIWlH5g9TnWAwWPNirZdy?=
 =?us-ascii?Q?OkkksXTxsaUZ0YVxxxS0spMlrn3gPyadLT6BUuao9mFVLC4otti3ZqZvVB7t?=
 =?us-ascii?Q?3ewGNLErZK1Gu0DITYQADQM+N3WHpGfK+LbDZ7Vy3cKs8H3S37I9jBOKu2T+?=
 =?us-ascii?Q?QiYa3POgL7yrfTw99t6+PS5Y+jsKHVc3qY9M05lQlq+gW18bmOQfvTbzNY+U?=
 =?us-ascii?Q?JpUSaV1FBRsA7/Bco84ni69c44TuOAna9kVCmQqSbE3b0QjCtsKIBaL2T+M5?=
 =?us-ascii?Q?fyXw5cBQHpZW8qHI2RYUxgDf09VmZsF/dcwsNjErnbhn8Jpbmhb1m8qr2cWY?=
 =?us-ascii?Q?MbGwd6s5p25lxxXW8KvjkquY2mjz/FN54GfdtB0LyHvx7inzvUJA6qDR+wOy?=
 =?us-ascii?Q?NO4bso3rbwbq5c7O8gG8H1Gw1m8dDJP4Vm3SLl3Ac3Kz7Avm1733OPbn77zQ?=
 =?us-ascii?Q?yzMJCctUPR9chfwkXZn+KVJha4+a+omlHdDc/u+kqKd0B2dPTMqkFoTIXx1x?=
 =?us-ascii?Q?G/359HGkJb+GyqWVqNG4HThyc/iCXvG3Y4cBJfrpjOLpsuznZNKcFzLQJnzK?=
 =?us-ascii?Q?1LvAoEW1E8CVsOcpJEYUJFeqzHZOrm2X921Spge4NCw8MArKHYQhcDJzw1d8?=
 =?us-ascii?Q?GTvvW6+YmtlAFTxwDemoa2UrULN+eT/Ypsp+Dt0cs/GCrbdyn9iLnFhcvb0d?=
 =?us-ascii?Q?p4GqYziqE8YCU3PMQYorRKX2QhxkCQnufSzEm4/QXLbfL8koQ+kGmfMtmgiw?=
 =?us-ascii?Q?U3t61yQ5du0pbP8R5eXaVSB+0giownVYCPxCQev40IcEaZuaowGtUt96XKi8?=
 =?us-ascii?Q?14HtAL6dHtOly8kWrgenN+YO44j3olwaN8qKrhW+pcV82gGSq2hElf5GKUFc?=
 =?us-ascii?Q?u9Teei/MIRNM1pVZ8l31aT1ZHFs0WWAjD7JM9WZh1xM+k9/pYFgDq6zM42e2?=
 =?us-ascii?Q?7NX4JTNOGzofNRmm/r7/tm7taKOIYZ9aMZFT5ej9cvhGLU9QjQKyEYH/lTWG?=
 =?us-ascii?Q?3h2MeHPO/PkawQPfus3CuXm9kNuMfiEisvy6xTbxNMcLpxamCK1ZiFX70//A?=
 =?us-ascii?Q?gCkEN1US0H39hWvXSBk4p7uXIeWUhO2QMnUeK1Sh+ZNC+rSu4oD5XW4Z72p6?=
 =?us-ascii?Q?d3J72i7XqA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33245b5a-bc5f-4b9d-fc75-08da4a1fb680
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 13:55:29.6756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64J8WwI0p6EIlBBGq7j45ePhta0scEykw43X6XFMKmGFSoSiMlbY2+gFv02Z2xySlNXbZvZNP6vXG5Xk964rPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8970
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-08 19:04:55, Alexandre Belloni wrote:
> On 08/06/2022 19:49:25+0300, Abel Vesa wrote:
> > In order to replace the fsl,scu txt file from bindings/arm/freescale,
> > we need to split it between the right subsystems. This patch documents
> > separately the 'rtc' child node of the SCU main node.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
> > new file mode 100644
> > index 000000000000..bd8c3cf365ff
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
> > @@ -0,0 +1,22 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rtc/fsl,scu-rtc.yaml
> > +$schema: http://devicetree.org/meta-schemas/core.yaml
> > +
> > +title: i.MX SCU Client Device Node - RTC bindings based on SCU Message Protocol
> > +
> > +maintainers:
> > +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> Isn't NXP going to maintain their binding?
>

Since there is no NXP maintainer for the i.MX rtc drivers,
I took whoever was in the MAINTAINERS file.

I had a chat with Aisheng Dong and he is OK being mentioned
as maintainer for all the binding docs related to SCU, not just this
one.

I'll send a new version.

> > +
> > +description: i.MX SCU Client Device Node
> > +  Client nodes are maintained as children of the relevant IMX-SCU device node.
> > +
> > +properties:
> > +  compatible:
> > +    const: fsl,imx8qxp-sc-rtc
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > --
> > 2.34.3
> >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com/
