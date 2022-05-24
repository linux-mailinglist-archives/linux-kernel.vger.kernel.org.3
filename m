Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E095327E0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiEXKhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiEXKhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:37:14 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E3022BD8;
        Tue, 24 May 2022 03:37:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inOl/xFEZwvaBR17aI+wGUBHbQmsYR+tDtdRfuHFXnJcyTiztsyzwTzol+MKy2BWXfzVy0RtbVybDNZx0+cKmZwRM295+FFXuY5V/3a/NlQ+gft1J0KP1NrsEKQuyXqivNgiaLpH6OClxTq9to1SIKnFucREq9yQ+AYviogcDX4LzSZMP+kedY0Yfc7U1/tmXnSsHw4QTYVYLzSbdQ/Rc707oF8SDMgSsWi9jOl2I1X4AinC86bSGUiYuBxhtAzFe2+ePcTngiuhUzh4bjg9uAAZTCZBhd4ionurRihZ6cPIjkM7daOarV7i8ksrXJ9Drt2WQFB+feK2rqtu0yaydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMeLR1AtIK0w6BOOa0v3260a+7460TIooPMFx1a2fLQ=;
 b=MyE/5YLUIycGP8WrQC5wnQkOIAkgB7DMnHID8twRPWo4V16dspHYOdBg/Wsa9ZNiLxQS400M5ZhWnok2gRsD7bl7YpzpFh58u4iuhjtGXJbfsa6gNwxkmwhOFt1KbxLRsNRj8eBAjgrBs0cNsBgKQ2lWaNy0eaRpU+xsHwlFdweHUNANops1DA6mamML2PhQn3y7SSjvwl3cJNOG7vDtigiUrAmDIiMTbo4WgGxnfPmY+H57RqKq1F/3xvWPZx2Y8oJlRM0lFJ22U5ZmzunHxaaVmKg3NVw0w8f85FMTk5eoB8H/To5gTpvJhJTRHudlXmrqLBHGQPa8TTKMWoOJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMeLR1AtIK0w6BOOa0v3260a+7460TIooPMFx1a2fLQ=;
 b=n0sr4KkuEyJJUqsinSmR3m/sdnnztVcxlwhOXM9JcP5/7fSPMAMp4GsAj9ouQ1wTjI4I4B0+tO3QT4RDAhwoHw3+3IQMXjJ/PwT171Ev7aOwlLmKz2TSU8regMWq18thnysxIhUo1jW3r0EqLwHoS3qXdg2rXUGScJJ7uv9wMOo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB5914.eurprd04.prod.outlook.com (2603:10a6:10:b1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Tue, 24 May
 2022 10:37:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5273.020; Tue, 24 May 2022
 10:37:09 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93 SRC
Thread-Topic: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93 SRC
Thread-Index: AQHYbphE4hPgB8NWEUiwdYEo5yj0ra0tzvwAgAAFlVA=
Date:   Tue, 24 May 2022 10:37:09 +0000
Message-ID: <DU0PR04MB9417F22B607C95BDAB84C01488D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220523113029.842753-1-peng.fan@oss.nxp.com>
 <20220523113029.842753-2-peng.fan@oss.nxp.com>
 <c2882212-aa1e-4614-c982-43e6c793b34a@linaro.org>
In-Reply-To: <c2882212-aa1e-4614-c982-43e6c793b34a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bac327b0-4b4e-4d6a-55e8-08da3d715b30
x-ms-traffictypediagnostic: DB8PR04MB5914:EE_
x-microsoft-antispam-prvs: <DB8PR04MB5914CB99F952B0C7B597084388D79@DB8PR04MB5914.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IzhYHKaxvU6yKn5WBc0uKfFtSVnHmLRkX2GjnSiRF8LttqV4hvLW6FbEg6/7hkRnQ1cobESiWJ5XZf2xTrfZxwZdEflHZu8OxjwxHFHgVW6aM+ze+xGOy7HEB6oNzGmswSG/SC8wyniFGJmOL4Bu6Q7GJ6dGWxGPxxH12r2Bm3emUpuZjM2B5sGOETRNfc378OWKPmrOW0Kfz8GZyFd6GOYOZFbM0t4EOClLMWZFl/fRnWBaZyEuJp+OGhqXFZWDQR6YLn+DEfskCTItIQ+WfNYsj0e14PuRXjrhcOtXDvBiP9aJEGUbH3yqVlDbRQ+Z6ruYgLGI7Bfy03916auFFpTuXR3wBJZ1H6yHCG2iltBh29OTpC1qCzI0nluEbhyyjcfdsAypAWlLAsbMKA4ocKk5THsTYWfJNxzGSkfafmjm2HNSLEy7qZA4lIt+QiUfHlTf/+723iatx3LQOumUN2l1qvwgJRKLhDn3nLE0Y/AT43keMYNscjZDKdiIMnsfog9rQek9SVrSlSjdah7wu7DHRRDc9QFtNkOLFct0f72uBcWdoMynXY+SoeEpDTXSWnCyqn9Fr8LzceuqPzs63v1xYlF1I78Q+5oquamN+oDbBHGR/elBTI+2b/GZTWKUe1qTD3c84Yaoom+5gEUcXOxUVc8TY2I0oVSjLO0oRBqghrOFw7DNYqrxrMLk/XOM9nqSH1gycixsnILNVghYzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(2906002)(38100700002)(186003)(508600001)(86362001)(83380400001)(33656002)(110136005)(55016003)(66476007)(66556008)(66946007)(4326008)(76116006)(26005)(64756008)(9686003)(66446008)(54906003)(8676002)(5660300002)(52536014)(8936002)(7696005)(53546011)(6506007)(7416002)(44832011)(38070700005)(71200400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sjyegUFXHl21gFQ54kJv0QxY5JTqAROcRmlkBObHGlNXWIGPQpnubgB3pI2g?=
 =?us-ascii?Q?sP6k9MJdwr103aQQra7ntzTzFy0wNILzV9nXmhv+3+URtR/q3SaXxLxIetnd?=
 =?us-ascii?Q?v7fsw+JMhpqiAbDSgBvYkfhFVzQw2qfmPvfT3wC+yINnFo4qngQF+nut3LkO?=
 =?us-ascii?Q?RHW3bW4X2q6yxArISFI0uuFzebEG37Jtj+InmCgtL4wRE/pZ92qkeuIclA4A?=
 =?us-ascii?Q?TC4goYVHcuQu3DK9gUS7UEdzvVDrEnzyQhigQVWq6qa9m/Q7jAsa3KdzyXux?=
 =?us-ascii?Q?qa4iVEhGlcsY4SyyrTbiOzZcWiNu41pEz+SkDu/Qau2lACe91MkII2zrv5Ig?=
 =?us-ascii?Q?jI2xyGyjoBAeLmjm5UZjiU9ewJMuxNYVr02GIE5lxAEqQ39mN6/akNnRG4Rv?=
 =?us-ascii?Q?nrPxGqBzMIOOMOEte8OS93zY03vKlofZEcLynBiYztJUChEAj/pM9XCF8BuM?=
 =?us-ascii?Q?NUtAjjBCbSVYVOeEGEMRLbM4Kxwd+fI0CXvF6TDj8CfZ5nJ4kzjB5vaJKd2e?=
 =?us-ascii?Q?MSMJBnIbV5HZpbLGLrRlSasWFqfPrXy2Rzpdt336ko4gXwh0TXRfu/xpEM0n?=
 =?us-ascii?Q?hFg1L88dr6Z+se7IE74UO+rNoZKDQrcZSkLSUOohrkSD6D0A6lhYWt09Zpn2?=
 =?us-ascii?Q?E3eePE1MAldQArI6qDW5J1Albo5UrykopY5KLl2BDPQPXqxoJnmPb13zT3yA?=
 =?us-ascii?Q?rycl9YW6g5uyjTvflpADA923xNf4AqKSNTE1Cb78yB6u/qgBJkqzz0bu8pSc?=
 =?us-ascii?Q?fMH2DiomeqmAJKhdmjKoMyibSRBLt/lk8oxzE8lDSnSzE89FqPyF/Oz4tvz+?=
 =?us-ascii?Q?GhHZZMcloSPyZ5bi1jcgFzhnz5sHqkxsCTxwnqLZvYon0By8veZUABFWxC6x?=
 =?us-ascii?Q?nmXizVHoq+yT0W8RICYIeCSlpT3kidkoIv5TryMV8/vNlroMdCJ010LiDdZI?=
 =?us-ascii?Q?YNdyMyw9Qs9UZFfhs9bmbQ2Ugokq768Gg7e7fYQg7WUP8f2G668iwoybubLL?=
 =?us-ascii?Q?s545gOVTWX1YvTMDvNETV1p3ffpgKMgh6gROXi/AJEPbP/KEuE7Xg6vYTMlc?=
 =?us-ascii?Q?uqQU+n90jaqASA4g01WvAYp6eD20s0f0LM9zZ7yvLj3J3O+6VcEBBy1PPk2Q?=
 =?us-ascii?Q?IJfCcA0pJdAKjptpNMOP8X94itk0PJCt9/vTdyiPk1C4pRpUv3OBcFV8+wst?=
 =?us-ascii?Q?BM2+LzYJbGGDtH3ZNlz0XO1epW7FRCHMrN4MNpUZdjNHBgxjLgIJ4EzUOwtz?=
 =?us-ascii?Q?tLGY6ZcKOcoyIzFUXleb98aD3OuM5vPUxY+PWKo43sgtpZ5HENBbukCJPcYf?=
 =?us-ascii?Q?5xEuy8VEzP0L0o0qaH81guP7asdO01yePcQxGHfEE8X4tXa/fInqZag8Zy+z?=
 =?us-ascii?Q?vYxpxwyEbaaQtylg9g+GeMPDb4ddiY0D10qXo1AaUuhS77lifxNfcUgAAW5+?=
 =?us-ascii?Q?Oh4ZbD6ggDBn0w7kyq7qCG6M5GaJddfVGaeThcJNWRRDHySTfu+oh/31zEGl?=
 =?us-ascii?Q?2vgmF+309xUSQANoHD/iqHPiKUR0AHJDdqHq6ALk+OzSnozWtLPItmZBvSJ/?=
 =?us-ascii?Q?JDaQrY7Zn41k0bYxCGJs+QAYkrSwoSK6JoKQrubdBNRAAnSQ3lzPHDx4/s8W?=
 =?us-ascii?Q?ALNttOMk2q4jIjuV5i0yzMdIJk78gb/nr033izwz7soFf1aJhltjDkSrwBCu?=
 =?us-ascii?Q?zTSnHbRVm98s26HwoH/nQHz1b3uIW+Yr4n0FCmFwsN+GUTAHazgvw9tLImIM?=
 =?us-ascii?Q?6xhv0sxGUQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac327b0-4b4e-4d6a-55e8-08da3d715b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 10:37:09.6527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJm4+M+Y1tztcJVg5IXSlEHTvOCxv+uyeGdI2yAjJRMfY8Z/7r3+sqg3ewRzY7Y2snqITzTma9gDAtxdMVXesQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5914
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93 SRC
>=20
> On 23/05/2022 13:30, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
> > resets and power gating for mixes.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../bindings/soc/imx/fsl,imx93-src.yaml       | 88
> +++++++++++++++++++
> >  include/dt-bindings/power/imx93-power.h       | 11 +++
> >  2 files changed, 99 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
>=20
> File should be in respective subsystem, so probably power/reset?

ok, will put under power.

>=20
> >  create mode 100644 include/dt-bindings/power/imx93-power.h
> >
> > diff --git
> > a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
> > b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
> > new file mode 100644
> > index 000000000000..d45c1458b9c1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
> > @@ -0,0 +1,88 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +> > +title: NXP i.MX9 System Reset Controller
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +description: |
> > +  The System Reset Controller (SRC) is responsible for the generation
> > +of
> > +  all the system reset signals and boot argument latching.
> > +
> > +  Its main functions are as follows,
> > +  - Deals with all global system reset sources from other modules,
> > +    and generates global system reset.
> > +  - Responsible for power gating of MIXs (Slices) and their memory
> > +    low power control.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: fsl,imx93-src
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  slice:
>=20
> Why do you need this subnode, instead of listing domains here?

I follow
Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml

There are several slices in SRC, just like there are many pgcs in gpcv2.


>=20
> > +    type: object
> > +    description: list of power domains provided by this controller.
> > +
>=20
> Hm, what about address/size cells? Is syscon schema bringing these?

The slice submode should have address/size cells, but I not
meet yaml/dtbs check error. Will add it.

Not sure syscon bringing or not.

>=20
> > +    patternProperties:
> > +      "power-domain@[0-9]$":
> > +        type: object
>=20
> Missing ref to power-domain.yaml

Ok.

>=20
> > +        properties:
> > +
> > +          '#power-domain-cells':
> > +            const: 0
> > +
> > +          reg:
> > +            description: |
> > +              Power domain index. Valid values are defined in
> > +              include/dt-bindings/power/imx93-power.h for fsl,imx93-sr=
c
> > +            maxItems: 1
> > +
> > +          clocks:
> > +            description: |
> > +              A number of phandles to clocks that need to be enabled
> > +              during domain power-up sequencing to ensure reset
> > +              propagation into devices located inside this power domai=
n.
> > +            minItems: 1
> > +            maxItems: 5
> > +
> > +        required:
> > +          - '#power-domain-cells'
> > +          - reg
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - slice
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/imx93-clock.h>
> > +    #include <dt-bindings/power/imx93-power.h>
> > +
> > +    src@44460000 {
>=20
> reset-controller
> or some other generic node name.

It is not a single reset or power domain controller,
Currently linux driver just use it as a power domain
controller.

Thanks,
Peng.

>=20
> > +        compatible =3D "fsl,imx93-src", "syscon";
> > +        reg =3D <0x44460000 0x10000>;
> > +
> > +        slice {
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <0>;
> > +
> > +                mediamix: power-domain@0 {
>=20
> Best regards,
> Krzysztof
