Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F0F5A7843
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiHaH6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiHaH6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:58:08 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60069.outbound.protection.outlook.com [40.107.6.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9169011827;
        Wed, 31 Aug 2022 00:57:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXCV2Q3JnnStuSnNvRt3kzbWw1X87imzK3P0aoaw99JdvsbM5ng5K8EIQ+aYNM/rxV68kfI9I7wOSyLBfe3UxasGGd+ufQVHZGK4wlVAnZIdTLPURAo1f2K/2B5nioT0hvPUZb7qTZMzgxdQXU9fnWy9XoAe7MElcTKmxl8VosEQMSHWPW29YV758ul8dJNBNrY1EAuQTSY2TGKprRD3Mr7oAr77YiZP2jU7dACkTt8HNt28eYnjW23K3b/UsXH5ECodijGhZl94rQouB7NuFNOP6aIZCftsDIFl88Ss6j16atDmWTvUrR9wrj90on8/KnAifQGc7bDnoutoRasS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wVWTu4FyLmVU1GFnd083MuSecKmPDb52xjqNi1goew=;
 b=JsVegtwykguuyU2g+xlInoYJ7kGiUwV/kFajWnsU+xde0tj8DycFl3JeclEPAJmZykXUzGuXmaInHniASsYN3fI7L6YAptjeSfo7F87KfLhX93h3RMMhL47NwwLiDLalKp86AmGj04h2pBac2Wz9cr4rVzyecZLGRrXxIbNEghKUHVuXRdjUW+DmD5jQDaRkY7wtx+nZYy0wmY9d+Hv9LX+ZoRpAuEfWNsESK92/DAwsdwAcvJMXj2ELHeVC54/JOlS4qcurbm9RAKYRWueqtO2fLOjACu4HB1C824R4fcUQb5HEnHgFTF28G9hEYABxXtaWrzwhjq3yyXwlmE2f3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wVWTu4FyLmVU1GFnd083MuSecKmPDb52xjqNi1goew=;
 b=oExQZHp8HnDquTwdNQzDIEu/aUjCckNBY1fA+1q2T8drOFOTvNpbOHkN/rjbGZi5z9fK6AvaOUvQIuEL7u84rezW6PJcnddg+y750hTX+jV8hArqETX2Bi7BxYA6Ni/DPf4sqhpVafB8RQWCeAYFp9ArCqRLCJaLjrA8ajCDTec=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 07:57:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 07:57:56 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 1/8] dt-bindings: soc: imx: add binding for i.MX9
 syscon
Thread-Topic: [PATCH V2 1/8] dt-bindings: soc: imx: add binding for i.MX9
 syscon
Thread-Index: AQHYvQ369ZT276n1A02SkSng27WawK3IotSAgAAAVOA=
Date:   Wed, 31 Aug 2022 07:57:56 +0000
Message-ID: <DU0PR04MB94171C9075A78E962D7DD58888789@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220831074923.3085937-1-peng.fan@oss.nxp.com>
 <20220831074923.3085937-2-peng.fan@oss.nxp.com>
 <26b5442a-5224-4252-f141-e85b33fa4f53@linaro.org>
In-Reply-To: <26b5442a-5224-4252-f141-e85b33fa4f53@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65685199-ef1f-48c3-288c-08da8b2683eb
x-ms-traffictypediagnostic: DBBPR04MB7577:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2r8w4yCOSoXSYJ19EmBOJLSAF7Z/117l0gRmfIJJG7pzKxA41GUyaMntQ5GA+ZOv1ZA2f3f10luGNjQdgIi44hoxgSZ0g8DY0haMbVpKN36385bOpmmCwI0GjNU/6uE0gGXmwb09qC1nysCIUo6EEZsP+F7OySIgZEinTQUNiRGeEmgKRbRXwpvBIKDpsa0OgIxdeoRK0f5C3uej4fhl3+HgKytsFkQUMVV7LvLb+QOewR7WLTm9JfSKwHxH96m4OnnI9TDuGYZit0MbNr0OHWSeN7DqwO4IppJeZiLh0S8TgV8loSBE320xY9ivwxwoPmpWUXMKqP0W4U3gptfk45tSzqYIm+wRmfX1lKMagHIEhqj0KN766yq0l7uOZ11wpv862GZseFf3LKlXckYBbs8JQ/NfvNPlvcwEp6BRHA+XRVjyMm16oXTPxj4UDRjEzXkQDbbiNlGr987Od+DRuWiXvUMF1hwirQxOYam/gIyUj/y3WL6JMHC0Pi4TbQgJxlXvOl4pXx3jNSh6mqouIMKxVXaGA89NiuI9xGvWuViZFpDJGs7Tye0aUWiH9TWtZnZjqd1VGUnzzkk6OGgpZjywqh87RPOBMtd3iANOoHGbYb7RIDxN6/XDFNA4wsFEKFTg1auNAZdIna5qd+bk0gJMSpeZa6u+TJwDckWyFWEcl5mNAsIxlsPNvFZOTPwlYLyB6e7z+u4i8gfwbRBSegOqilW1UOgHCVaYwLcwwTg6MwK6r6BrhPm8jDhlgknA4g6ItqJa92FxguRonIZhC4LbgyNwYCWcbKYsAG3uex4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(186003)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(44832011)(5660300002)(8676002)(33656002)(71200400001)(478600001)(55016003)(26005)(41300700001)(53546011)(7696005)(6506007)(9686003)(38070700005)(86362001)(54906003)(316002)(45080400002)(52536014)(8936002)(2906002)(7416002)(110136005)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N8ca7e8AoxuaigKpUlSlWkiGbrLgMBnqmvmaGpQ4CiV6Ruof175svt1YbI9a?=
 =?us-ascii?Q?rpwSBgt58ym+z0oJ1bk54yLIb7kAFfDXD6CdJfKgVz6Wl7YK+HN9we+KxEDY?=
 =?us-ascii?Q?C/Qzbkig9JRaU+goxcb4rnl3ZzsSZawcoJu122JdwZ6KHkTJ596HbKABKH0L?=
 =?us-ascii?Q?Qhph6+JaQXa3pWJ2RQkENxyMQZSNGDpZkSmGAc2cINK75+Cc12aeuhlfGekA?=
 =?us-ascii?Q?+T2CK/KE3ulzlADZnBMFCWo0/V4D5iUCYRgdTRjlbV+caQ0ZKA5laoNB0vYQ?=
 =?us-ascii?Q?B/pw2VtaVp1z4gXgG0QSmBWOBx6iJfJEC0E5QU7rWDw00GcAudxsD/3kLyw4?=
 =?us-ascii?Q?AQZ8yNywUxRQ8CKwRs0A17dM7jgrLeVzBff1xjXlLurrEAl7wSqpmUud7Fwv?=
 =?us-ascii?Q?Ki5+xG8/jV+Mok4Xag3rVCDIS5Q8INQUYmO2x5YpcF3f1Ys/StpJnLawknUf?=
 =?us-ascii?Q?0SC7xsTuYDGPfdvJLbqEZmfmAyh+tSzlz3Sn2RZE5H+doeiytoUqhjIhb5pA?=
 =?us-ascii?Q?vbSfAfS7faJXQsKPzrox4HRQP8SAwYH+PSN8ydDYhyBJN/xCSJD2Bjyb1ddY?=
 =?us-ascii?Q?V+t2wg9dw5h1Rg5GIiU7Pd0E9SfYL6QGBCynDFho6Xlbg7UjFcOE/2gmeKJ7?=
 =?us-ascii?Q?cIqUKlshJnakY+noK/kik+exu7/dXA0M3h5GDd+ZdVKolb6QDbs4hXNWFUdn?=
 =?us-ascii?Q?X0Jkojj/pNiczZr4Rj8zFWTbMDH2uAHmeOka432xfWh36RJuiEtbXRzaeS6t?=
 =?us-ascii?Q?o4LGZl2qvLM64PjzQXgHEndCEkFEaTnRKlAE1DBECb8kRJMnw2Er4ZxxLWdJ?=
 =?us-ascii?Q?NY1qlYg68GTwANDSwBgXhveggFVHM1LTMzq+xtRLTSRhjehb4LGN/knD8Qok?=
 =?us-ascii?Q?d9+XDTD1uiD4XdEbYuSkYXI53BcwVdFGoErxwgJCCw5Olgs4oCJXJWnCPlVc?=
 =?us-ascii?Q?bkgquiio/Hhi4OUmh9whYScvhJfYvDXN9wr3K9TFU3WYSMV2QfqfCchUCah6?=
 =?us-ascii?Q?SSX32zaH6RcHZNmrolU9zcsY9/8WuArRu5ulCTY6JRGjTfCKtUKluR3QKuM/?=
 =?us-ascii?Q?ieh31kVmy78s4yOR4a7ZWV0pYdExhoep7o2wKbkqkEWXxB7bagadl9yQsnLg?=
 =?us-ascii?Q?A2TFOWvUj9PDTMWxO5lypTr+Ju9YqJj4EI3c9ZQEjMaE3rXjxtx89Z3MW9C6?=
 =?us-ascii?Q?S0Shh86eQkh4qcFL6MwOeRiML4rlxP0gVwEdJ0sGqOMv+00Rgsk6mN9nrrv0?=
 =?us-ascii?Q?73RCKZqovSf3Hv0WT0a8h/H4u2OjCicBzSgUkgpg2CCXy6AptPEA1cmKOWfX?=
 =?us-ascii?Q?OfjSyild8/ZWX/uupyYCfHhu4HbxtVNIOqCHG+IBu6cawc3mnSJGHNx6Giic?=
 =?us-ascii?Q?Aqo94LG6DzGy9Lt6m/swZ+7O/YmI6d9Xtb7/Xc6m7mv+oYQxXCnClv/YC8Xo?=
 =?us-ascii?Q?NlpkydzRTlUfGs8BYkwh2yzpTbbe1D6r3q7MUcJRc6CwSzmAmI23pw7/M4x+?=
 =?us-ascii?Q?czIK9Sy4EKEE+FcOtcuhZi/YrBw+Ri2xj1YtckJ9ZaC4ehifly4TSX0+cTnb?=
 =?us-ascii?Q?UfAfl7BTC7fyZGrwcl0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65685199-ef1f-48c3-288c-08da8b2683eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 07:57:56.3966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKTTTOeC9rteJuKc8f3HX/sGznGvLKotE6ybUp3KSX1UVubvNrBMdiNcCej+VvWz2gIqOYW3oYIa7rVBuGtTvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> Subject: Re: [PATCH V2 1/8] dt-bindings: soc: imx: add binding for i.MX9
> syscon
>=20
> On 31/08/2022 10:49, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add binding doc for i.MX9 blk_ctrl_ns_aonmix and blk_ctrl_wakeupmix
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../bindings/soc/imx/fsl,imx9-syscon.yaml     | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
> > b/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
> > new file mode 100644
> > index 000000000000..90c5e354f86c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
>=20
> Filename: fsl,imx93-syscon.yaml

There are more i.MX9 SoCs in the coming days, I am thinking to let this yam=
l
could cover i.MX9[X].=20
So should I use fsl,imx93-syscon.yaml for now, and rename to
fsl,imx9-syscon.yaml in future?

>=20
> > @@ -0,0 +1,37 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> "https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevic
> etree.org%2Fschemas%2Fsoc%2Fimx%2Ffsl%2Cimx9-
> syscon.yaml%23&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7C9dec9a
> aefa1e4c992bd708da8b259c6a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C637975290892739302%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30
> 00%7C%7C%7C&amp;sdata=3DTvEdbjOMcDosQr5Q82t4aaO7KHJDn5YcSA%2B
> 9XDjj8%2Fc%3D&amp;reserved=3D0"
> > +$schema:
> "https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevic
> etree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%
> 7C9dec9aaefa1e4c992bd708da8b259c6a%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C637975290892739302%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C3000%7C%7C%7C&amp;sdata=3D0G8y17uvPiZ22xChJCmlTWFX6Tl%2Fq
> G2kXF2bSUXDBaI%3D&amp;reserved=3D0"
> > +
> > +title: NXP i.MX9 Platforms System Controller bindings
>=20
> s/bindings//
Drop "bindings" in V3.
>=20
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
>=20
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see Documentation/devicetree/bindings/writing-
> schema.rst for instructions).
>=20
> You miss here select.

There is no error when I ran dt_binding_check
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/soc/imx/fsl,imx9-syscon=
.yaml=20
 make ARCH=3Darm64 DT_CHECKER_FLAGS=3D-m dt_binding_check
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTEX    Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.example=
.dts
  DTC     Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.example=
.dtb
  CHECK   Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.example=
.dtb
>=20
> > +properties:
> > +  compatible:
> > +    oneOf:
>=20
> Drop oneOf, unless you already have patch adding something more?

Ok, drop in v3.

Thanks,
Peng.

>=20
> > +      - items:
> > +          - enum:
> > +              - fsl,imx93-aonmix-ns-syscfg
> > +              - fsl,imx93-wakeupmix-syscfg
> > +          - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
>=20
>=20
> Best regards,
> Krzysztof
