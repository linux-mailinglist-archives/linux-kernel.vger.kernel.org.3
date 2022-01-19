Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C203649326D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350729AbiASBsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:48:07 -0500
Received: from mail-vi1eur05on2089.outbound.protection.outlook.com ([40.107.21.89]:41824
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238680AbiASBsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:48:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkPKirwCNe+LS918qVZbXLINQTdjR4gqyO9NV89pYK57OSYLOZqCinym5ruXAdRHx2+QhaAKAQyhjGcr2P6TMJDZwz11AX1NN+SsTbO9ZsqbLf7NoNBCvpq0yTcvcJQ2U/wkSP+yGtsnIcKtVBV2HFxY181pqHioU2JSGNBvb7y2M2ehrvvsKg4ldcpp9aKzpDYTJrd8/s2/Fxt+LZij6WIETd4+N4Kt6mBldBQ3tBBAcZU02zHugG1tjFHj1nd8ucuqnKt/mbrdg5Ecy+NJ3LcW6FlSRteJ1qsu5RF9BEmeBR5YfnD0tXPwHolVdEZHice54+WJGGuxxXZiB+ltfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=athG0omLLszGEKOIBNqh4eILY3bOgQrglj3V1BFMUas=;
 b=NRRPhcfcpCjk6aQeYzkEc6d8cH5g5/M+UZMK7NQgKUChbKArf8JLWlvvDt15cVa0NUXiEXLAyT+JkRSSYy7ZZjZhOI+ZEft7QiImUq38e47MvEK9fVoDX2fIheAEyFNsAuBvUmC4TUA1klmJ2TvEjOji2L/yV5cPFomKU9mic7hkwSq8sj/4fMDnH9++dSf2q2/ZqmtDvkETio6iSGHCl+kRFeAouyFb3zGRxwQ2DLTu1HNMlws8wbrTcYD9MHl1clhWRyVzW3bgj1P9NrRvSoMCcFQmjJSnIp/9+hHfAgzvfB9RuxP3yp8ei5EJLg2FCJ7XISsDNO2K5CMZ+dUJjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=athG0omLLszGEKOIBNqh4eILY3bOgQrglj3V1BFMUas=;
 b=ZJt4yWY+ydLTcAB4Q/+hL2DkkEWKjYUPOawa1TWkv3P4is5q4OXsTmGME7e6NQeo9bPNAUpK1xmYZ+KR0BLUtTa5PYYLupmMeIdN9hmSliWvE1VDhdsLNd7sjDy+9mjItWfXkamFGDiQ+xq7YWonzEKWRanKpDIc5RksrPifQHY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 01:48:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%4]) with mapi id 15.20.4888.013; Wed, 19 Jan 2022
 01:48:03 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>
CC:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2] dt-bindings: serial: fsl-lpuart: Add i.MX8DXL
 compatible
Thread-Topic: [PATCH v2] dt-bindings: serial: fsl-lpuart: Add i.MX8DXL
 compatible
Thread-Index: AQHYDG3HDZy63ejSQkytaGP58k4lUqxplDNw
Date:   Wed, 19 Jan 2022 01:48:03 +0000
Message-ID: <DU0PR04MB941773B00527243D9376DB2188599@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220118131715.2051965-1-abel.vesa@nxp.com>
In-Reply-To: <20220118131715.2051965-1-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0901cc3-7c18-47a9-30f1-08d9daedbb80
x-ms-traffictypediagnostic: DB8PR04MB6907:EE_
x-microsoft-antispam-prvs: <DB8PR04MB6907517157F306497CD03ED488599@DB8PR04MB6907.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TVXru/ZJc1pzLPcAAyqcCG7TGntb8F7LjQrbHNdAFdcIipF0pJg5dkUIfbFup7zd83myUiB/txoYH22EIvFhwnqkJX0JfdpMxFjQViwDiU6izBpf9ZJ06GJ+DYRimtu/2xD5R/iL0BP7aLJnMbl2eh71NhHr0q7nlrjHJEniR+ucjO3wcbAZM128YZ2XM7uAEHGBP9rzr4tyUKAGViEGwtPHOZe0E3d0uAjBJeGRxVvRw64aZUhpjky+dCg2hLatj1ZhXMS4ms5bgAApUOGHC+S2sJ/37YGX9kz605vANj35xktgCLp66RNi1jLTzaYddLJ/QpfuPb00QkOOoUo/tuTcAHMXEr1gWUtP1sPH2ReMTtOM9p2+FliTWM/e33e2+ByvJ6hlJjV3vJ8eoZ0ox4xPf0VrQAzCDhzhsNCXacmKki1OOAVVn5EIbfZ7YLilN10rWbneSbPeL1YjUsz8G86wZpEjGBPXSfIKSliKOvEF1NJK3yh2mKi/0Xv4sVefgP3Tmp9MCE1M3DPI7t+7MAfUTovzcrYipw8/An0nnkRJwLhnIbOCaF+SpvUUVYWiRaSZsW+QbrhmIKLkcF34voBWkhf1zA1tRL5Ewl9IJYce+743dDZ5brEP/kpjeS3y03yo5TbTMwB4WJvKK12u624VcDu4Bx6FGUuYvtj5Z9HGos79UMc8Z/sXXbqnmrXeUk7VPaRkEcRDdFhpNyScCH3sOVS+C+HVNxzSw+1Aw3aI3tUxtfoahcP1XvaUrPaNnn7HHWNADwf25JNBtCphZc4nDBbbyd4FvAxJubICKww=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(64756008)(66446008)(6636002)(66556008)(66476007)(54906003)(316002)(9686003)(76116006)(2906002)(4326008)(33656002)(110136005)(26005)(6506007)(8676002)(186003)(7696005)(86362001)(966005)(38070700005)(508600001)(55016003)(83380400001)(44832011)(52536014)(122000001)(5660300002)(38100700002)(8936002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1CyfZO/UU/db326HnVep5lm6HJj3ddcSFG9k9XVx7O0If92VJ0s+wlbfTRIc?=
 =?us-ascii?Q?ti0A9rg6iSmJHCnQ+E88wCiPvir6IxKXwvNGj50zGxnJ5gMLY0u7npRhkhE3?=
 =?us-ascii?Q?MuNqOZnmPasZK62dBEa6FzmLrjWQv6a3YT4cOQlhMaEUNE0rzZ4i/HVuu4ZA?=
 =?us-ascii?Q?qBUvMCjTttxss/PcqKMA+LvlcLRN1O09vP9fB22FxuLjbIszbbmLe9btJdfc?=
 =?us-ascii?Q?hZOfcjEP2zHHcc/9uDefr5M1gvsmmIbTS3K2mtu0ieUzqFbv0ju/6N2wjuVM?=
 =?us-ascii?Q?v6un7eu/sRbEemYx+G1zZH+HhXF0bhQOllmaHHiMP7yJ/8k0j49ZVWs5SsaS?=
 =?us-ascii?Q?ENADjEYKEKyD3gqlmkX8KH+1vi54K8IhlRBrJIeU491SWnumEWSvCuzA1RfR?=
 =?us-ascii?Q?IrJy4WrKT+ypaEfN/h96uoA4MqbV+jrwAQSqUZZLenG3NuKW3rOij/ESqRB/?=
 =?us-ascii?Q?IVvf9lD6fzX+hJ2Iv/fpUub90VaKgDmweUUO7pLsE6dDHPaok3c/WCxE6fxF?=
 =?us-ascii?Q?zLugOnGEQOpY/lfJViO7f4/aBkSTN8iak3UeEFCVJMClpHgkloKGlUgDQs3u?=
 =?us-ascii?Q?XmcY0Lw2AGsw8bNfKNVL6P2e1pasMnK2DKU5Kv4KDbWquijQ19S64blb2sY3?=
 =?us-ascii?Q?pmw43S5ER4/0DdtTMWUB7hLDtJjc9vyH5YQlQBhb/i7xN2Igm52RiSFrC598?=
 =?us-ascii?Q?PgTvGvfSCx7ZoE+hiGijSSFFNwfJb0b5M4XJOiTZY69nb+WK/1ZY21yQMIrq?=
 =?us-ascii?Q?LzzK1XxIHB8KwW4A1GotcADFV8TX9EE3j/SE+9O0CGZVVvEzjM/eyvG8Io78?=
 =?us-ascii?Q?ex4p63orqOLUNj6OpH117vEzQi4KflnyT90rXgVMvjQKcz2eTQ4ZRjTcKq+J?=
 =?us-ascii?Q?tvytPf8KmillAX8oE0FVEry3kwgGepk7uvXpttBW6gD8a6LfAnyUO3zT1th0?=
 =?us-ascii?Q?zG7tHaWX6FmTyU33Onz5vDwkMv8aH4Bjylje4ZutY3S2OKElfUa8A+t7Dlpz?=
 =?us-ascii?Q?6eYRLwA6se9v1j+f2ddrzv/q7NIQg/1OzV0V2Cf5RuwCrosQFXpMYQFCxCP0?=
 =?us-ascii?Q?A+nYqE+OSFDXLHrCNstBKIIpzOCYIuvy1WS2201sw0mK086ZBDvg2gdmO2Bs?=
 =?us-ascii?Q?pQXSt/c1sGHctuTJZd0RQCuAcM/wl0WbzMAD3XvJqybBrMex4E7RcHzvL3XL?=
 =?us-ascii?Q?d++Or+yxuk7qZBqem+ve/lu5o+6N145EFZPiFAB1Jc+0yuAaV+iF+75akDD9?=
 =?us-ascii?Q?dY92S5LGbFF3OtrppNoPxVBS7kmArkt3t+uCR/wPt39hTB3sl9pnzARLwkg/?=
 =?us-ascii?Q?e4DNVsDak2LhXPgBzBVcVa6lTBObb+pAYHPiwQipeja+J3hXSuj4c2aVqfbh?=
 =?us-ascii?Q?22B7L7vvKSGmb2MBYSKz5UHWWZKbjAUvXsFOom0p9Jv3hZlzjUZBIlkQhjDF?=
 =?us-ascii?Q?fLsHOyh82Mzdz0Ft33El+ljewpJo/vtAQurb5Kd2VbVb9l4INDbfrf9ecapI?=
 =?us-ascii?Q?SgikXvUZF9g78HV8MFpcmZGZ4M13KwaR2oQuw/08349t4RsiC1YrTAUv0dO2?=
 =?us-ascii?Q?E7w7zeg9/Gb8Wv6U3lwZIjyXUYW+glbp3ZXwncYGMF2fIZI+qA4RUvZJWcwz?=
 =?us-ascii?Q?NA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0901cc3-7c18-47a9-30f1-08d9daedbb80
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 01:48:03.6218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bu70fiw7sjLVQdByWCYcshknC9RSwis670iLxQs1TGLNIC8RQOyxnTOY/00/WcT0AwCDqEKC2CrbiVa5Fsp8Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v2] dt-bindings: serial: fsl-lpuart: Add i.MX8DXL compati=
ble
>=20
> Add i.MX8DXL lpuart compatible to the bindings documentation.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>=20
> Changes since v1:
>  * imx8dxl will only be backwards compatible with imx8qxp now,
>    like imx8qm
>=20
> Here is the last version of this patch:
> https://lore.kernel.org/all/1640085372-1972-1-git-send-email-abel.vesa@nx
> p.com/
>=20
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> index 6e04e3848261..c33e3af1b5ea 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> @@ -28,7 +28,9 @@ properties:
>                - fsl,imx8ulp-lpuart
>            - const: fsl,imx7ulp-lpuart
>        - items:
> -          - const: fsl,imx8qm-lpuart
> +          - enum:
> +              - fsl,imx8qm-lpuart
> +              - fsl,imx8dxl-lpuart
>            - const: fsl,imx8qxp-lpuart
>=20
>    reg:
> --
> 2.31.1

