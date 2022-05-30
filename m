Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E6D5374FF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiE3G6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiE3G57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:57:59 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20069.outbound.protection.outlook.com [40.107.2.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA005DD24;
        Sun, 29 May 2022 23:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSMMYei62MR621qOi5sNSXzdpu0oAIc9Op7Xsul307edn0iCnO1sRYTrH/oKqIZs1nDJiiiUoCFng6EfrNa0g9+xaMdd8+SpnmQ7Wg1tui6MRrKhV45S6q8K2oZV570+ADtpIrVxVYciv9Sm/xM4Zlm+rS7V4qPH5+HNrrmRhIdur/eiMFMsjSwPPjpwc7Y/aM4jYyAnV4AcBVhDTEKpY3YwfZYDMtYX0iwBQwtIDD9gQK9DXzeP3BZa3FbAY7HMW3ITiXOoegIpAMaxnBrZ9FLmYerf2l30mVP3/12fLHR1pVZa7xZaaFR1bLclz5UZE8ZjJhXW2SIUacEg0AAafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xnTV8zublXgsVCOYJe2xns2KZ8NiP1tCh29lf2htMY=;
 b=KZGXvdCnQHyIzIsJzBvyic8V7hjrgjc4U0GBuH2KnYOoL1vOqilIs6HsUroSDZLc9IJzRSvv5xDH1V62S2dwrp6Kp+Wz878vypNACKw8U00JbyDtBx4M1+06xrH0vmhpDsJGHVY2GwE2ThBiTNStb7FNCWtLG1jAJd5+hOwiOsz3B4/0BCsqe7xdYodKPt4A30Dv+yp5kEUrBfHv43hyP2QONvy0AWDGJohWUj4/Y2IDIkKL85yEkV5LpJ6Lye6liM2gzWVRfYjaKlyoMezwNTQmW3HWFo0Pbczkzq0t6sEZKwnk5ZMzJ0YbisgcUi/z7wc3R90oDvsWUuhtOrnMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xnTV8zublXgsVCOYJe2xns2KZ8NiP1tCh29lf2htMY=;
 b=UM10UYx/G9AptOFrBkEo6gzZiUH7zQ+1AVclm68rcVRKa3zstJ08Bcp4KsWm8eTnLOdehbSVhl/qRxhsIaZDl8xgTP/BqQgMhzfBjwNA5frUJqAAeeobU32Sjz18aVj/ItnxZVH7p6bBTRQjGVCI9r2clwsU0KTkiy4oegtAylk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7517.eurprd04.prod.outlook.com (2603:10a6:102:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 06:57:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 06:57:55 +0000
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
Subject: RE: [PATCH V2 1/7] dt-bindings: soc: add i.MX93 SRC
Thread-Topic: [PATCH V2 1/7] dt-bindings: soc: add i.MX93 SRC
Thread-Index: AQHYcPyuO/w4rU1nh0Kasa3cbr7cq602/ywAgAACr3A=
Date:   Mon, 30 May 2022 06:57:55 +0000
Message-ID: <DU0PR04MB9417353FE7BA649887E7C5B188DD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220526123411.270083-1-peng.fan@oss.nxp.com>
 <20220526123411.270083-2-peng.fan@oss.nxp.com>
 <2e6c2995-9204-61fa-0aee-f4ea4cce084c@linaro.org>
In-Reply-To: <2e6c2995-9204-61fa-0aee-f4ea4cce084c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27f39b78-ce0c-4a0b-69a2-08da4209b915
x-ms-traffictypediagnostic: PA4PR04MB7517:EE_
x-microsoft-antispam-prvs: <PA4PR04MB75173A9910FEF9628195AC3188DD9@PA4PR04MB7517.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MrkFMQG0RX4Nc7OhD0b7GLw0irzN0P2GjaDLSHz/vgmeeXySNBiyWesaWw2WBUITjnKP7UTZlHDhQAsp8jiDynwPshAOxsgSbSJLpE3R8r/7Q/EKFSXn//Ndat6/7Ulqum8RpaMIOYgw/SVZjl/Nwoe73AKYHS0jPpG8uHuULR73V6PXQ1Vi47cf1Qy4FOR14P8CByHTwRiBvuLSZR6c0a1PoOl8KwlR1TDJjCzRv54x5hVjP5K0qIZEyeJzdPzqgQKCm2HHLtPApRN5iQlM1SM4ZnxCryCfOrFlGa46+si423bOhWybPTiSRGKCbjVIQTv0sfSCrJpe5mwbksXEFpt0fwvzk5LOSBmyNZG7JAQPE4KKa+j3ryxFP2BDz7FGy34fpJqB+DkMggBOZh+EhjZQ4CxDM0Fi8pVSB8kI+gxYqS6btGheEleBylcLIPMCmd0FNLvKixE2OPCoW6NVYUzniTH/xFha0tXY2D8BnANVcWkKc/MIOXQuk9g3nkDldkzeFObP/wJvpm1WI00mjqB85JlY1P0vxwTK0SVop3WqWNbg7oKWUNU7/9t/R9B90vHbm2PZOZh9j3Ievm5o/jb8aeLLv9Bk+mL3Tq+n6vcm2+MgmttSg4QYeK4MVPc+5DtSBTZ6oooJFCQnrQBfreIsc5x3I8533Jq7eruCZQrgoIZAk4mu4jeungvo1RBKxh6r0P0D2GmDR0D2wOay0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(508600001)(26005)(38070700005)(2906002)(122000001)(7696005)(53546011)(9686003)(186003)(6506007)(71200400001)(316002)(110136005)(66946007)(66556008)(64756008)(4326008)(76116006)(66476007)(8676002)(66446008)(52536014)(54906003)(44832011)(55016003)(86362001)(8936002)(7416002)(5660300002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NfGYSKWzUviNmE3NL67Et4q62iRsAFyzpwyuCBn4YhxXMj8pOq+UylTj45uj?=
 =?us-ascii?Q?rClDlMvZ/nUn1JGF5K9BUrMcLRpC7GVdWH0jPguGNr8nT5p93mXJB0V2SUq0?=
 =?us-ascii?Q?2YeuEivZUNV4/eRejq8gR2JXjg/rRsLAutHGUxBsavJ8sgFs5bkvdwi/GrDU?=
 =?us-ascii?Q?2TBg2MyD1aGIdfnak1G2+2xHR+S46dhaGD0bLU6AItRq3w9ZxOfG2a1wIiDu?=
 =?us-ascii?Q?6w41Y492iy5tQ52Tn/fnpPmx6YJ4wqRphj5qDA/FSgQyz1OvHBoFIx4KyoOg?=
 =?us-ascii?Q?UTid/cbvJRqBSOn1qEpSGWrokRvp8MVBghEPuqfzjdNnsJn5RHbwyVWT0BYl?=
 =?us-ascii?Q?E0/r/aawZlzQRdQjAwG+EygUYRMYT9Pm4cDf/ZMS+zFzoHjAPYPDcsD6NfMn?=
 =?us-ascii?Q?3Nc4gBVFQUo+INBcMD01LwgzZ1Ytdgql6tD6vhFkeAyOjVvI+6SMhi4XxAYq?=
 =?us-ascii?Q?rf6DMfyMiqdruYs9qJrL8KV/AjW66zrpjRffTG5qAgAMQegBgsN/EZOw+4Cq?=
 =?us-ascii?Q?+99PUjpUKF7tO21aD1fnDx96Qf6eTXESVYIawzNdO8igwICsxcIFD1bhdnA+?=
 =?us-ascii?Q?YAo0MIzKP8Z/ZoxxxA2ofQGf4uxBQShihlMGALMh/djF51bjD3zGIfKO3H7N?=
 =?us-ascii?Q?EXqjkKKrl13GcUdG+YOx4sOGeWRLf0a6fcgAw1Jbn6L8Gv9hvEFB6/jmUky+?=
 =?us-ascii?Q?Dni3cazVgS+hOP+vGXRzGq0fNgbFjXY9wHnuemNM5VlfgaNZP/1lRG0CZz/0?=
 =?us-ascii?Q?Qn963ROSqvzme8KTzbGbi0hUHv6Mlou80fpHAh2GzpFsPstsBbXXTeQYCYkh?=
 =?us-ascii?Q?NH7dGSfs5v6TOGZgmSKhmWapVBtwDz6kBaXtKhPa08BkBPeNaW5VPt1hliBd?=
 =?us-ascii?Q?xnvF4bm/Be92EiAl+Dkz5d0dTZHRb7WOpouksbal0l7UbXbRxfmgthscoiRv?=
 =?us-ascii?Q?sUQMYdZwALcwHBbejIwQEuEOTfhQFgE3iUPfFoLJVB/szca3dQ7RvT9Xl8w4?=
 =?us-ascii?Q?CZPnAd95su6WhJuWB9hC4uExYHgLqD2QrVcH7NppCg6Wlc8eFacZE3+jBpCa?=
 =?us-ascii?Q?NMiO3DxuXtQ4EU41tXOX+P1eA7dpzDS+oJ1/iEbpLlra5xKUTYQeSjX9AW17?=
 =?us-ascii?Q?TK7cVGeuT2qGzEkQ2oJcakoJ/SQcmqfx4kOlZjMFx1ePYOYHpYXsZhZtPOtX?=
 =?us-ascii?Q?B3IVhsw2bK2svqqwmUEwWNofZd2Kk6q3FRbdo5zrTJ1jn88cme4woO60Y7bk?=
 =?us-ascii?Q?St3ophjae1vhapErx25GayhiPi79ERRcDXPtrMeYxwLWicG0/AAgAfPKNl8D?=
 =?us-ascii?Q?I46QoXmI0qkGMWGvZlChRB+N2w+HfQgqr3jGVzbeFXcanqKq4Z7kIhNs8QCz?=
 =?us-ascii?Q?zalYJyFctHj45sq3gf9qNmAMSlBfWDUa7KJkGYWxilUmU80URc976fwI7/q4?=
 =?us-ascii?Q?H9M13x07+r3JWtljwdNWYrPOxx0uldseXB1BDwdKPJxKgItd1bG6hVTFBcdn?=
 =?us-ascii?Q?9YHU7RLpewUqOV2mkQhx4ND+vMBhox7qtkINsht7Q4i79TYYoLFgOKkAMn6M?=
 =?us-ascii?Q?0UfmsCNhX3h/nq6M2VI6LfXBQ0fD6e7w2kYJYor/Cf/q4WKiceWCTAtzyZtV?=
 =?us-ascii?Q?jZzm4uqnS9Y8YdgJjWvluTRlwlqBNoseF9VWpmqeZsBnoSulEXPNspEe+Rit?=
 =?us-ascii?Q?Jmj7QAi5SIVTNzWuT79lvGJd3jLIgFN59qI2wQt4R9nswihq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f39b78-ce0c-4a0b-69a2-08da4209b915
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 06:57:55.3517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CkjLtrrGnAsOffLjJqPq+qMnXAYHNYQmIkZXPVzROUD9jxDhE0mBTZFX73OPsGclhlLhxlF/+lE0fElED485hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2 1/7] dt-bindings: soc: add i.MX93 SRC
>=20
> On 26/05/2022 14:34, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
> > resets and power gating for mixes.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../bindings/soc/imx/fsl,imx93-src.yaml       | 96
> +++++++++++++++++++
>=20
> Still wrong location of bindings.

Although it is called SRC(system reset controller), but actually
it not functions only as reset controller, it also supports power
gating of each slice including slice's memory low power control.
It also includes some system general configuration.

So follow your suggestion in V1, I rename it as system-controller,
but I not find a directory for system-controller.

>=20
> >  include/dt-bindings/power/fsl,imx93-power.h   | 11 +++
> >  2 files changed, 107 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
> >  create mode 100644 include/dt-bindings/power/fsl,imx93-power.h
> >
> > diff --git
> > a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
> > b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
> > new file mode 100644
> > index 000000000000..c20f0bb692fe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
> > @@ -0,0 +1,96 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +
> > +title: NXP i.MX9 System Reset Controller
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
> > +    type: object
> > +    description: list of power domains provided by this controller.
>=20
> Continuing our discussion, I think I see the point of having the node gro=
uping
> subnodes, just the name confused me. Please make it plural, so "slices".

Sure, fix in V3.

Thanks,
Peng.

>=20
>=20
> Best regards,
> Krzysztof
