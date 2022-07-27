Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A4E582319
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiG0J2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiG0J2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:28:00 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2131.outbound.protection.outlook.com [40.107.114.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BBD47BBD;
        Wed, 27 Jul 2022 02:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQRhiieNUuHAlOWEOj/uw9J5zDV4A/HYksbs6F9G1Wi9VqzdwMH0jIE6EQOcp8gXtgiCNlMcXNayLdA1XezanFfThkcKAlLcTV+dgU47RcxFcVVz6XKTByBpC2GBftpUpkG6+H44ls53dzZc3SeDd0n3iBC+zz+g8JyH81kP7UnhFfxl0u7phMIlMoQx8uHLUwEnUDlVatmv/9/t+H4PRY0zusJzLAm0mm6yGp/xLSsMAUh/3mVnUYcMRrNNNu9fVfiaE54jAsXca5hYwxHNRHxUrjHGuqY0rJTl+3xM9gkk4Dd8TjE5NnwKQvLaRwmlBp3OaiXOL5Ad9qdwKz1kHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38h+QdXuMS31j3y+n6G4U0/bY/j98iMbIcHQLACdE9o=;
 b=QHoCYDCWL6niGqxnyPU9G7l5YzVzI6KT8NeYOqNXv5qAJBbaoiXk73Spsdo8wUw5QOZdwi+RyMzZeqi0E2A6KbsQXjSbAhsv4Lk5o60EGOt60AnsmYJiPJDJ52Gpb499w+1U/g1dnLnbg2yaFweyI7bshAeS8GrU/Y6QFc59hvejt2QVM2D04uJvzQYjQC6OrY+uS3Fo1D7K+ERYliqYUA7AyIrfRX0S/aPNfb3pEPBB6qRHCxTff4d9mH/UMZ+fk2iA0s7x/h/C+cTjSdbuTKLqeZw8ArkEDcRvoUqSS1FDLD5VmZbeNxLHgwQvDPdOaKCE9yDLWga8jcFBdFQvYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38h+QdXuMS31j3y+n6G4U0/bY/j98iMbIcHQLACdE9o=;
 b=B7nxL8eAQQBaKY8Dl2WrXThultYVTF2pyVsUy5f/2+vJSCNJjT4Id0zccecv7qZxYd+davYeGx4Mu0WbT5oZBnQP9IWO6DAaYr+tVawKOwLYdD8Q0OrU0jVRCPoQpP9EzoAOmlGRj+b7/bZSXVAanUZ3jGdTdqjUsMe7PXyXvKo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB5744.jpnprd01.prod.outlook.com (2603:1096:400:45::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 09:27:56 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%6]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 09:27:56 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for
 Renesas RZ/Five SoC and SMARC EVK
Thread-Topic: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for
 Renesas RZ/Five SoC and SMARC EVK
Thread-Index: AQHYoRp+5i2kwB4v6Ue8zM4Y97KIiq2R6rqAgAADKoCAAAU84A==
Date:   Wed, 27 Jul 2022 09:27:56 +0000
Message-ID: <OS0PR01MB5922F1DEF93337884249DBF586979@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <636e9214-4b36-e9a6-3c6b-b6edb944335e@linaro.org>
 <CA+V-a8sTw1qzuTeD2vb7RgDmmNdEP5qEcxXCjrFgkyrBrLrt5Q@mail.gmail.com>
In-Reply-To: <CA+V-a8sTw1qzuTeD2vb7RgDmmNdEP5qEcxXCjrFgkyrBrLrt5Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a8dbb9b-e974-4448-31d2-08da6fb24a34
x-ms-traffictypediagnostic: TYCPR01MB5744:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3kAaPWW5z7cbLoDCW/Avjkk9nuHTG91DvWG+gUtDaYx28j/Uo9W3BmBgfcMStAsYKGvOf8BNTYCr+DO6OkwDGaNPbs/4CiBYfuTROkA+chszfznJdnk9HweshtafLZ0olM3UaiDU6fyPIQs9UR2eMnTZLFuNM3mdInZVBt9iZ6DWjPSsWjjKQ3uR9XcmTlDPUu6irKtQcIfa5yntGH8j6GyxeyXmvTujNP5pK0HllDiAYgekyTKh2SCHPFX7KQ/E4s6MUtgmfAsLQvPg69K/FQMFLJM78WmLAa0WXttAvVbEyQX9qfHeFMCn7f26aAuyTLITb4sxutNJFXom+TN1rknfbhuYhVloDJpCaldnjGeo2fv/3R1HX0mgfVyz6q/1ljLG159eubZF7iaj5bITYJO4jcquloYu/VpgZXhkeTRr+Bj48s/ZjPWjJieFfLtAMKj7dW4IV7RA8LRh9APX3eIyj0S4MUposZp12DAQU3jjYXPAuh/Y5TeNZz08EMRUMWHEtfVcnrVFA3Qx4lNYcZtiPb9btiqtB7sFWw/TAAixp82iE+lhq52WSNPpO4rSzwOCFSjEGddbJMJ98tEo0GDPbOgpZDxkU63V3+Veu3T/drWZsa0YYnpPA1zcs4et/qdTMh7puIj2MPkEblTRjqVtPNHqeMN/r5XSfUvbot9m80xKWm2Q3SFhRhdwnojUXVgDc0Q8oUCOfNN/+T3mR/TA8Zh0y6POI/cnNeg2Y8datXnBU9JLZMvY+loDAfCXX9O8OEBcOKwzzTHlzzkcZ/5M1SR0MYyU7xnpQOWX2CnVAKUowy+zcyI7BEqxtOEI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(122000001)(38070700005)(38100700002)(33656002)(86362001)(8936002)(316002)(52536014)(7416002)(478600001)(55016003)(5660300002)(4326008)(66556008)(66476007)(64756008)(8676002)(186003)(110136005)(54906003)(66946007)(53546011)(6506007)(26005)(2906002)(9686003)(71200400001)(7696005)(76116006)(41300700001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YHcQomNJn9FRFWNlK1eMYdvlCWCOZlJsbmDYgZIb/Ys5eXR0Hs+2FA9Wt3u+?=
 =?us-ascii?Q?8TokNXNYZ8SLhtjd6ZR9SIbkjUj2q7hxRSevi9F89L1kxEbPjUSuDKBqdRAC?=
 =?us-ascii?Q?BRz7y+/AfJMbS/8ah/EkOc9BEKZaJNGRZCeB1oAlXHJppf4vzSbN2a8dEMmw?=
 =?us-ascii?Q?NpMYeBUfEdayTcukau6YLUzT/71oX+cb1N08Zl+b+FxMs6WvQc22U8IfQxeu?=
 =?us-ascii?Q?7N92oUd7d0SBr1raaPDS6EPc7/Lyy9pv90XP6+KFBAf7q2XMUkcJdRiGZ4xw?=
 =?us-ascii?Q?tEjZg/KQSMPzjjEVZW2faGNpKqq9khx/ky4YLRTjQLnUHG26Xr2LdKHCWQvh?=
 =?us-ascii?Q?POCGiY9pUR7hTKF/ftpwKaeZe9UHWVvwqBLX7Ry5TvvIp/4GQRfOsvZKWYFv?=
 =?us-ascii?Q?gZ85fwNSMWRhbL/SM+Z9C1rW+AsEC5ePh2PVfksG8Q1vE9rqkWZfMABd6nig?=
 =?us-ascii?Q?7kPkDgKoYQp1Ycl5Bxx9y2p6ruK9XYZLu8vKhH/NPuYJZKqfpr08z6m5NBqH?=
 =?us-ascii?Q?IBl9d9wd9hgWkeMdRHJ6u3OEHN4aMs7r9djNxqnz1dVorbl0yjUe0z3/U1Yr?=
 =?us-ascii?Q?M/wfPoRt41mZDPouW5t3lElu7Rmb4JzvVUWlAuXqDoRauZCR8SmoU7fph7+F?=
 =?us-ascii?Q?uCjqyQOiS/DZlSeu7Djqj3b7KKqlBn/JlQhL/L8wLS2s+xFSdEhGZ2RXkh/1?=
 =?us-ascii?Q?vMQjW33qfMuzKBJpZb6m8rdqvkCjwCGdwMj51keg9Fl7/2TRFG1HA8g2H9eq?=
 =?us-ascii?Q?kZx5oea4DkGnwEgVtkbi6U88xh8XN8n9cJsFtphpwA/2nBqEsfJiNlW+t5mg?=
 =?us-ascii?Q?G8h08AkK8M+OnJTVq0phjEKTnddKSZ40Gg/UzKZ1kOmvbUuUQzbOdW/02pbW?=
 =?us-ascii?Q?s+ex1IsaVxhQRTY8sEGGn9vnPKDhueI7tOttP+S89eVLSBaW4zXZx2od2qnb?=
 =?us-ascii?Q?WixgaTuo7CgfkWga3WKgM6PvWhDTIhrJSGcBAarxVOMiwxxfVZ+8dmTDzq89?=
 =?us-ascii?Q?NqQtZ1ATmH84PeLhWgoHNtLoGKCbmoz+DUSQF+DCGBtKAoxKeGKfKetmaoJr?=
 =?us-ascii?Q?HJGzVvpJD6ON6q+MzjRte2Zt/XCPsRrTjcZZvTrAofQro4Yz2un92qV5Za/V?=
 =?us-ascii?Q?Px5j1FKfeHgUaKTt+2dY93Cr8DwSSUHxAQMZRb8ccdK5w3Me9v5st3FXIPMF?=
 =?us-ascii?Q?4RSRyOh/cWIkKGvVy2cj0qRe1bpWUAFz+fhddNZAtzBJMWR2GC71xY6XWDJc?=
 =?us-ascii?Q?Mvpo9Wh6u/Ft2TKXEAz5ziF870s/jsAEH7/pXimOiZAwXayp8NGlpOxFKC1q?=
 =?us-ascii?Q?5dXCrSMfSj4+VNt8JIoTLdio/wyw0GgbS3SeNXuMl2aCpZDh3SGQjL362iP2?=
 =?us-ascii?Q?8RzqyFskDjxIQ+JX2UtaHvlCXET0CD/9Hhe+H2fOnfBnsKeq17oGWc/E0iRL?=
 =?us-ascii?Q?G+FlbjjKL1Guuk5s0pdqr/CwZoUVoC8gZ7QoMg3V5nl/LwAcx6XwiyXYDbEQ?=
 =?us-ascii?Q?jNVYnwVA7GQCZPSDJg4XTXd2s0KbVnXQ0VMUtUryJbYJf1pwb1j/EPCVsSKF?=
 =?us-ascii?Q?v9YWw3ZEgs8AzOtREyhDx6JKwKd94/wCN9YEQAsUZ1Gcnlz+akCgJQItWyip?=
 =?us-ascii?Q?BA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8dbb9b-e974-4448-31d2-08da6fb24a34
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 09:27:56.5882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X22etiEiOIBjx51fSKLty0X5TJRylseFEUYgHSesytaZzBP5Kq9YVb79C16Z0gvXX0dTPEgIPNiaSpgCDvmxBkfjbO+4qK/OoIeTxcBVl2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5744
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad, Prabhakar,

> Subject: Re: [PATCH 4/6] dt-bindings: riscv: Add DT binding
> documentation for Renesas RZ/Five SoC and SMARC EVK
>=20
> Hi Krzysztof,
>=20
> Thank you for the review.
>=20
> On Wed, Jul 27, 2022 at 9:54 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 26/07/2022 20:06, Lad Prabhakar wrote:
> > > Document Renesas RZ/Five (R9A07G043) SoC and SMARC EVK based on this
> SoC.
> > >
> > > Signed-off-by: Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  .../devicetree/bindings/riscv/renesas.yaml    | 49
> +++++++++++++++++++
> > >  1 file changed, 49 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/riscv/renesas.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/renesas.yaml
> > > b/Documentation/devicetree/bindings/riscv/renesas.yaml
> > > new file mode 100644
> > > index 000000000000..f72f8aea6a82
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/riscv/renesas.yaml
> > > @@ -0,0 +1,49 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id:

> > > +
> > > +title: Renesas RZ/Five Platform Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Geert Uytterhoeven <geert+renesas@glider.be>
> > > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > +
> > > +# We want to ignore this schema if the board is SMARC EVK based on
> > > +ARM64 arch
> > > +select:
> > > +  not:
> > > +    properties:
> > > +      compatible:
> > > +        contains:
> > > +          items:
> >
> > I think you should rather ignore the RiscV SoCs, not specific board.
> >
> You mean to ignore ARM/64 SoCs?
>=20
> Agreed just the below enum, should do the trick.
>=20
>             - enum:
>                 - renesas,r9a07g043u11
>                 - renesas,r9a07g043u12
>                 - renesas,r9a07g044c1
>                 - renesas,r9a07g044c2
>                 - renesas,r9a07g044l1
>                 - renesas,r9a07g044l2
>                 - renesas,r9a07g054l1
>                 - renesas,r9a07g054l2

Why do we need to add renesas,r9a07g044 and renesas,r9a07g054
in riscv file? These are arm64 only SoC's.

Cheers,
Biju



>=20
> > > +            - const: renesas,smarc-evk
> > > +            - enum:
> > > +                - renesas,r9a07g043u11
> > > +                - renesas,r9a07g043u12
> > > +                - renesas,r9a07g044c1
> > > +                - renesas,r9a07g044c2
> > > +                - renesas,r9a07g044l1
> > > +                - renesas,r9a07g044l2
> > > +                - renesas,r9a07g054l1
> > > +                - renesas,r9a07g054l2
> > > +            - enum:
> > > +                - renesas,r9a07g043
> > > +                - renesas,r9a07g044
> > > +                - renesas,r9a07g054
> >
> > Did you actually test that it works and properly matches?
> >
> Yes I have run the dtbs_check and dt_binding _check for ARM64 and RISC-
> V. Do you see any cases where it can fail?
>=20
> Cheers,
> Prabhakar
