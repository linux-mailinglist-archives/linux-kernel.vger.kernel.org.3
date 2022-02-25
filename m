Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52984C3B33
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbiBYBqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiBYBqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:46:49 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577262399E3;
        Thu, 24 Feb 2022 17:46:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kF8xm3z7kju8QJlVdL9LQl5E+yegl75JnoWpmlGdQ67lgFNy25U+FRrGVY4SbDZwLrV7GLeYPXAIGhGunhzSXIs/vVaofKPqpoX4f+Ocudpjb6czsTaUdDhGKlNIYOqwXPj1+KUX/8/cPTkfgAQ0858cmUVOyjtkHyERv4NAs3sdYa1UsKDPKgTrdwrKOiEygxpNLNtEsamp0s0Cl9bYBuPBO31E07YwCt+Q9S52rKs2kG0ykeos36Hd9nG8ghrr9Iqwf7p0c2YouIiQ9gU3rC8rMKRK++7+Jae8Kuy2PDQswoLaxYMp+FwFan554CjE1UJVOzkBFv+Jak3JT3eVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSePFoJNTkHDoPWkbpowLwtjnmGCkK1j6HF/BVtY6mc=;
 b=ZNZluq7dMMf0qo/+Aq0C0p5WPkOT3aD31Qy2DLhgMgeQq5yVKVNuUYf/e6w4sWdkJlIGv2FD1UmBv4j8MDqJaL26vcZyDnRCi5Qp52ZRAU+mNxjFUJjjt3Yw0lyapO8jgcp7PXGC/BUxMiCAgmtWvrg8gUf2Sazv9d/TFpLIU2TSZChdpHezEWhTUzb2pg7TfAIBqoCLyyAKTQzuVVpD+Ma3Q3C7tPeh4RKEqdS0EUYDvd2OIIzTLZStAqL5TQ1ci7uPH8iPCEypWwavpo6ruCBY1u4PPJRtA8ELvkvglxmSCCdNjQ5+riAkLwVW5KEdBybg3yleDtO2+s3OCCGVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSePFoJNTkHDoPWkbpowLwtjnmGCkK1j6HF/BVtY6mc=;
 b=QnlXQ5E3LR9ur8CJJc0MqeBSGbnPv0JLgrH2mF8I92QrmF/GUJLzX9PlRSFzC/4x4j7Z4fFQ8JedqOjMTKETq19C6rS7OrV8ldCwIyEUYcP7TbyRGHarVZpdLEA4qVve5eeH6eYkAAJc7OBh60B0+OGxIgZrr31aZRJ67GVtDJI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5268.eurprd04.prod.outlook.com (2603:10a6:208:c0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 01:46:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Fri, 25 Feb 2022
 01:46:15 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH V4 2/5] dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU
 support
Thread-Topic: [PATCH V4 2/5] dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU
 support
Thread-Index: AQHYKF1MqNltMWS5SU+6uS/TNysqHKyjFyYAgABqXaA=
Date:   Fri, 25 Feb 2022 01:46:15 +0000
Message-ID: <DU0PR04MB9417BD76E66DAFE2D8E505F6883E9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220223023157.3478540-1-peng.fan@oss.nxp.com>
 <20220223023157.3478540-3-peng.fan@oss.nxp.com>
 <YhfbFi4Cl1TfWqX7@robh.at.kernel.org>
In-Reply-To: <YhfbFi4Cl1TfWqX7@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 991183bf-c37d-425f-ce04-08d9f8009c70
x-ms-traffictypediagnostic: AM0PR04MB5268:EE_
x-microsoft-antispam-prvs: <AM0PR04MB52686CC3751B55B72C2E6F44883E9@AM0PR04MB5268.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MYoHltOg4RFC9u5TKT+pNCarj/N018w/n4iAceZN+GW6ZvlSY4KGaN6DPFb3p5vp5Y4f1NNEtt2On1aMXbUsmI5YaMstBebCAMDNYeOtBqYEj9RTmA7nKwPKCWaQDCteimCrnfeXtnzcAIm9K/GMIq14fuMNFgd/6/rtcukAwgcc1z7QZyH+5/yAjeNzlmtUsVwM3a2+lKgTYqCDSHgWFB97wIbsxkOAHSFqYgmD3fiOp6saVbgfGkptJ6yTcDPdtZ7MgdpIQmAgSd9C2EamBJoHB9djYqEpSz08JKLmDtDsfZUhgPI3mZ6O+FILskJQhHr02GXlHlQ283B9KvcdL37s3I58I8TA76B6mcdNjNzABgveuo7bd17oFW7/wXMg8dJoaIkcm1JSchGZXMBU2dU3n+0RUxqjQ3nC+GinLDW5XyvQ2/Xe2I3maxkY5u3s5Nev5E7Jds83BQMJe0OxBmqn8QP/jsmkRwkj2E4NrSNlBnYoPRTZoV1YFuMisGnbBitvjHdQjFmSGrh1y1hBtPwZZXR3G/ljVOQIYEziqfZOdhJ+9Es6R/N/8FJLvr1g0sb1zUsEKI/3pV9WCv1jqxKRh/FW3gOr8v7n2/byqm9k5xQI/GNm3QJVM4Oau5hfiZ7kHevoMFI7PCGaIg6avQl1Pp283BIw9PFp4pw/6z3nDbNeUD4tws5JpQxCIJvIAGCT/tzbV9kdSTpT+O3JrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(2906002)(71200400001)(83380400001)(55016003)(52536014)(44832011)(7416002)(8936002)(9686003)(7696005)(33656002)(86362001)(508600001)(6506007)(38070700005)(316002)(4326008)(15650500001)(5660300002)(8676002)(110136005)(54906003)(66946007)(38100700002)(66476007)(66556008)(66446008)(76116006)(122000001)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PG4DCpOzMPrl78EM54XWtVLn9Q1v4oKxj5kJ685mgPpTsGJ+9kO1GV6NK6KU?=
 =?us-ascii?Q?OcuehBfc558WVbks4EQJh50mlZYr4gxeueRmJAZeLFaYZwkCciIzNRhrfcB2?=
 =?us-ascii?Q?mQ2W4/EpaAJQ3gT0q8haw8vKndd7oJI5u3MDS+KVwEeW989GNtI8pgE0owKL?=
 =?us-ascii?Q?pukQEbBC+gYpEDC/KbsbVRkQavkqx/2pgOtqYCRcjpAH0gIV+cyD51TVPRdk?=
 =?us-ascii?Q?QAAOT7A/PT3n0DKUL/3OaHw0UTWhI2vK7XFpanDqNzQEAd58mA1MCzjwu6v8?=
 =?us-ascii?Q?WqiYkV39DOaY1UArqT2HwYwsg+3lQUyvxXxF02BGUlez6jOKYUBevKDAoqdO?=
 =?us-ascii?Q?ipKfAVCMQoLnpCbnnHVOiCpb4bNNt6y2KJrLFeVgcslhCZkIWJwx3gTSp9p7?=
 =?us-ascii?Q?JM2DNXyRfv9hL8EmzdzqJzPMSV30tgUwOMwDOQauKQzeL0AvP+he+bIgcUVo?=
 =?us-ascii?Q?gu5BswkeRnk6wY8gOzZNEwTee8xSZ9hIQPZZVifkgkq+437RQ9rbeHTIZHDr?=
 =?us-ascii?Q?WOYcYC1U+lcpKrjvz4byOCCyKzTxqm3WRUco7guiRKXvN8eC3lRVLUUHiclj?=
 =?us-ascii?Q?eCMgH2m8QCzPsQTmkxx+d7B1OfTbtFC0yswbQyHjpdbEafTJKSmM6INCOeBS?=
 =?us-ascii?Q?29EaVme/awTwTSvdXgHSdfnWfrMfPBt8LEootKQmrWLHatNSE2yInDwV6pca?=
 =?us-ascii?Q?YWoLC7QrY5AVBB6pCKS71l5Trlc6uWefn3C2bpOVvoU4y4ALr+t0LfFyQ4Db?=
 =?us-ascii?Q?KruIgnEMJfbNhGzEQcNjgNmyGgO/B0VpOqvxWVe7wiunjZfwkTG92p2EE7+C?=
 =?us-ascii?Q?UQ/eWuZvrb2Gqsocr3BUPawnMNY6P7ypL8fRn6lE0m94jCIBefoHE9Sqy4Ev?=
 =?us-ascii?Q?wb0ezj2/8+uwYQDQZRlgJP7cB4KCqLi8jVBoJo+94uWg4t5oAGIGg2tUwkej?=
 =?us-ascii?Q?7nBn1xHhn8U98tijG8Khu8OKoXdYLhnjXcvIZNxCJe0kAFJLk0pO4yGpCtDi?=
 =?us-ascii?Q?p+otpEssOcFWjA8gRbgJPYC7RAqeWHKxDNvpMsc0bkV5byRV/dZuW+H4c+/z?=
 =?us-ascii?Q?p/xc9/We6l49AL1WDmtxaMXipD8FXn3fa5mG+ni4qtKw6iIUUtZPK74YykVB?=
 =?us-ascii?Q?A+vn/fjybvJRPCxQ9abWI0yC6TwhneXladc69+mmiXMdBQ57LIV70JUg/hZv?=
 =?us-ascii?Q?UvzDVJromdtTIA0jzEXjOFjd905KNYKDencF+ziREgW8ZWh3r3NtWlqEC9AG?=
 =?us-ascii?Q?WyT2NXx8P+scfRu0+qNf9umBr7Z4j6HjP1V8hbYuTGl7rFYuCkmDOdPET1UX?=
 =?us-ascii?Q?sWq0TBsWkGI7LI9UNReEPrXvZY5DNAAcPPh0xyrCR4+VV6KxAOMxVs6AuBo6?=
 =?us-ascii?Q?jjmPDJ4qlZ+PlFblXY2YHL+gp0Yv9HHRX2romx818uXy1kw+EGUUnYSnqI0A?=
 =?us-ascii?Q?yOVeyLTyh/sLwSX73DVw7P3fiNrJUiv56//lS+IugDXybLoyOZKL4EscAAl2?=
 =?us-ascii?Q?1RbB9Am4At+oGFYkSreT2ILAO3PK13ffFG53hs7Nphg2rF1xNXN4SHrMMTXr?=
 =?us-ascii?Q?vgATTj6n8Si5YU19kuNrLzdcnhR2mj0Tcd0K/0TMS/7w6WKuSpa8iOaMP2Ao?=
 =?us-ascii?Q?NA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991183bf-c37d-425f-ce04-08d9f8009c70
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 01:46:15.7025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cl40OiVNr6bCvVYjIM3QgLgPPRfCpmn1B4YCcUg/knBI2eocRvSuNY/dztL1mBbKTlNwBrrvk10Ro0tELQT9aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5268
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V4 2/5] dt-bindings: mailbox: imx-mu: add i.MX93 S4 M=
U
> support
>=20
> On Wed, Feb 23, 2022 at 10:31:54AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Similar to i.MX8ULP S4 MU, i.MX93 MU is dedicated for communication
> > between Sentinel and Cortex-A cores from hardware design, it could not
> > be reused for other purpose.
> >
> > However i.MX93 S4 MU use separate tx/rx interrupt, so update
> > interrupts and add interrupt-names property.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/mailbox/fsl,mu.yaml   | 27
> ++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> > b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> > index 6d056d5e16bf..f5f9d501845d 100644
> > --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> > +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> > @@ -29,6 +29,7 @@ properties:
> >        - const: fsl,imx8ulp-mu
> >        - const: fsl,imx8-mu-scu
> >        - const: fsl,imx8-mu-seco
> > +      - const: fsl,imx93-mu-s4
> >        - const: fsl,imx8ulp-mu-s4
> >        - items:
> >            - const: fsl,imx93-mu
> > @@ -55,7 +56,13 @@ properties:
> >      maxItems: 1
> >
> >    interrupts:
> > -    maxItems: 1
> > +    minItems: 1
>=20
> I still don't think you tested this with 2 items. You need minItems and
> maxItems.

dt_binding check and dtbs_check both pass two interrupts entry.

So here it should be?
interrupts:
 minItems: 1
 maxItems: 2=20

>=20
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    items:
> > +      - const: tx
> > +      - const: rx
> >
> >    "#mbox-cells":
> >      description: |
> > @@ -90,6 +97,24 @@ required:
> >    - interrupts
> >    - "#mbox-cells"
> >
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,imx93-mu-s4
> > +    then:
> > +      properties:
> > +        interrupt-names:
> > +          minItems: 2
> > +        interrupts:
> > +          maxItems: 2
>=20
> s/maxItems/minItems/

Fix  in V5.

Thanks,
Peng.

>=20
> > +
> > +    else:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 1
> > +
> >  additionalProperties: false
> >
> >  examples:
> > --
> > 2.25.1
> >
> >
