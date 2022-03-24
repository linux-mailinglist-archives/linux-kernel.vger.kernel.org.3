Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EB14E5D61
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 03:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347880AbiCXCz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 22:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbiCXCz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:55:57 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800F264EA;
        Wed, 23 Mar 2022 19:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiN7I2GkPkMfUkha8wyZOydfTHbMtyQhtgI/vUBo6ZsXrn1vbAeJW0hRfoS9Mz42XwHoBwb6EGlsf2khBp6VK7qfMkv8V6LP5xJ9c8WlAumuR4qsEsXwd6jxct9wsbRCfkz83M9Z0jiuPgBCYmyzA3dP1JWyGvh/EAgvls/HTGpouBLCqqVxl0dnwQb9zLNfZYJT99uMk7LYtZxhKmo1NhvzzSyOMNCG7IeqPICEddTC56l0Eamn+4vTS8lHAi/RgA7UGK7Ej/AlIWbQbgzIpiSLC6vkOQH9MFE16HCT+cE4o5hspHOcSn/SY25nPuyTyIp2mGWxc7YTxc+BgRkrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEiZsxKbUqnipiVa6zuS4UbUmJJOTVmlvaWrYmeTVs4=;
 b=EYdtBfrY1cJasFgR0q72DTjTUIQ/6O3gFvqh7u+LQC1e+UUTFaOtJ502/N2teiuiMAZJ48qeZIATgd7qsiHtNy2Z+8+7USmgezO1DbTd3hi0XkZLdJa1BJHetTvmaJXACh+Ah/vjRobpLNK0BgVoYdevseK4YEBqa8m0GrwHt0+opA0pOov4ISvi+gR6zQwhT+mIahWILcDVOHGrO3Zu/GsNs570T5fnbvvuV3yCDLHSKGR5WTni2uW684VNgYoMroVkuxW/RFcXyXANfjDZx9UJkT+OpjLTwicb+KdL580XklUtiJeKu+Ad72LJAnNC4rQ6dHotkENPBZfXK5e83w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEiZsxKbUqnipiVa6zuS4UbUmJJOTVmlvaWrYmeTVs4=;
 b=r2XY1wgSwPv46MyJVmVWne1m3THU3SSxcldTs0yAKUcjQx38Ro6uo14R+THnLlnJJdXwJiuxuDAB/VP1+G/O3WCAlJ4dQIwzpCLVz+d0yqFgNVV22IO9Xlxznq0XqlWqErE+4CEV6bKEc3V8LcyUizI6mSVMOA80iUw3UEZQvwc=
Received: from AM0PR04MB4001.eurprd04.prod.outlook.com (2603:10a6:208:5d::20)
 by DB8PR04MB6841.eurprd04.prod.outlook.com (2603:10a6:10:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 24 Mar
 2022 02:54:20 +0000
Received: from AM0PR04MB4001.eurprd04.prod.outlook.com
 ([fe80::7d05:fb24:8147:8065]) by AM0PR04MB4001.eurprd04.prod.outlook.com
 ([fe80::7d05:fb24:8147:8065%6]) with mapi id 15.20.5102.017; Thu, 24 Mar 2022
 02:54:20 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Adam Ford <aford173@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: mmc: imx-esdhc: Change imx8mn and imx8mp
 compatible fallback
Thread-Topic: [PATCH 1/3] dt-bindings: mmc: imx-esdhc: Change imx8mn and
 imx8mp compatible fallback
Thread-Index: AQHYPruVil8qRYU9SEieNBZcJMh8hKzM/geAgAABWICAAALggIAANaYAgACdT4A=
Date:   Thu, 24 Mar 2022 02:54:20 +0000
Message-ID: <AM0PR04MB4001A479B5C25EBABF1AE11890199@AM0PR04MB4001.eurprd04.prod.outlook.com>
References: <20220323134019.3796178-1-aford173@gmail.com>
 <35f58894-ed6d-0af0-e483-7a161ad6625a@kernel.org>
 <CAHCN7x+RLAFnES8b3UMoc6n69ZVSFGOmAZyMeeY1g3aoiDNbZg@mail.gmail.com>
 <354951e0-d2a8-bf4f-e0c5-081e836bb3c3@kernel.org>
 <CAHCN7xLWoUGi-jfxR2a0gvEFkPT3USUEb+8U3CCqCb5wWEJ8xw@mail.gmail.com>
In-Reply-To: <CAHCN7xLWoUGi-jfxR2a0gvEFkPT3USUEb+8U3CCqCb5wWEJ8xw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a7a254c-3745-44fd-f260-08da0d41987b
x-ms-traffictypediagnostic: DB8PR04MB6841:EE_
x-microsoft-antispam-prvs: <DB8PR04MB6841F034EE1CD49618FC584B90199@DB8PR04MB6841.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nk9gZKO9SB/U9yumMknaHpLI9gXxp9sa057Sso0Tt0hJWFhgQEoIv5SDHzABykUB4iW+Yl+0SaSId0FyA36dXKXm110Rn/ayqOJMzhajdZBrCiArGtMLQKbz66LlJLanlBFHljEi5Kcz4eoIYgZ0plHUWODS21nlprXFfpxTpC7CZ2KXLWlQBmOCtJeFcozMWS08vYo8PRzjdyHDQH5MJkx3qKgAuRf/+TqbgO72bW73WGmfZAHKwxMrU5KeECuqUjL+BwDZYnfRKphTpF81SQvOVcJiSNW5Ae+fxKKtR0stMaiX7QAdlB/vrrwLmojn8uuEKIYLYRW3u9BEFDGA80eenQYSrLM+wiabjixEOLCBC4FhHayePpmY6a07QqoBGMoNV8v5njsD3Wl7IHE8TmYmfnSts9fUlCoDbENBVXaqVtqEAv6xR56f41ICpSkPQgvDqUEqIKk0xAtaAb+trEN0H/fJq2pVCOeI0IFIq3y+/V4b2ZkPamVOLXW+30ozWn5HFAtvvSG7o6QpLZ4SfGX+uv5zTrtEXp2Olwr7RJGPuNl5zW7/9k5SC/KqDYaxhpAhHJ3X6wcxT794zpGIOX1kAvfAG3TAKyq96noAPN2SQusxQhTcOBF5QlcoFFyaRW2oQicNWP7EOTq4hXzRb4rEx1r9NRbTRGKPWE7HhMeMUL+rfnQ3StasMzUFu9OH4KyFcqIJlG638NiXncSjRVC04q+FVSkxAoNWJQn0wis=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4001.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(26005)(55016003)(508600001)(71200400001)(38070700005)(7696005)(53546011)(6506007)(33656002)(38100700002)(99936003)(83380400001)(122000001)(186003)(86362001)(54906003)(2906002)(76116006)(64756008)(66556008)(66476007)(66446008)(5660300002)(4326008)(66946007)(110136005)(8676002)(316002)(52536014)(7416002)(8936002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFVtM1paVUxuSnE0MTRYR1JGTkNYT0RqeFIzRTRVRGxUZ1NQQ0l5QW5kMExx?=
 =?utf-8?B?b1I3QzJlMXVLSXRVTUplUGxvNFBrcHpKOW1TU2NRZUlwNHJnc083Slp5cTdh?=
 =?utf-8?B?S21lSHJtbkJZbDlPdGwzUFh2dlIvQzVHZG56TkQzdmhSUzd4VEhSSmxJMGhY?=
 =?utf-8?B?OGQ0eDd6QjIxSEhLWXo5TG4zVU45M2w3NU9zVEVhVjZ0ZEdhSXVsMEh3K1Fs?=
 =?utf-8?B?azNwdmw0M0w3a2lXeWtVQUl5UzdwdUhNUXdVUmduRTR0VTR3N3dvQjV1aUlh?=
 =?utf-8?B?ZXZ1YkdNR3JmWTVvdFVmSTZpWXVNdSszQnFacXBvcXk2NVNKUUJ6T2xUeHJx?=
 =?utf-8?B?SXhIQkc5bXlrbWc4TmdlK25KZUMvR2Z3OTh5REF0dktORWk4L0J6NUhjVnhw?=
 =?utf-8?B?WnZ6R3VGM2FSZUtxVlBTSkl2c3JPaFZzQTNLeUUwYkhTQ3BOaEpkK2VFNjdr?=
 =?utf-8?B?RUhjd0hBWC9oUGYzMGtUZ004WmZEWGdSeGxDV0xSR28vb1gvUjRvd0pqcURH?=
 =?utf-8?B?aC8rTUVvcmozajhVMXYyVC90Y2FheVFoR3dSTDhydmhvbXNvcXg2K3RkS25I?=
 =?utf-8?B?N2JQb3N2OHNHRDdXRmllVmxEcGJsOUpvMzNvM2VWNjU4N25qa01iTlhzNWJB?=
 =?utf-8?B?TCtWN0crenFpTnhEYUFZdVJaZjlIZnNMUHZoMnIrQmNMRlNMVFRJN1h3UmNN?=
 =?utf-8?B?b1B0aHV0cExFQWE5a0VWUFoyNHFxWWN4cE00dklhb0xBLzJIbWl2ZzdXcmtW?=
 =?utf-8?B?enpYSnRSaTRLNFFEOFhud1orcHROTDR2VUZEamo5SzFPeE5pYnNIRDZXMnlC?=
 =?utf-8?B?Z1ErNnZBL3ErenNYdFlhbE5POVQ1NDJoek1lU3R6NG9Nd05FYVR5T2tqY2VS?=
 =?utf-8?B?OHFQbzdweEp0U2RjeTRQcmVpVWc1Z3N6T0NiRS9RSWtrbTlvdGs5YWxHaGY0?=
 =?utf-8?B?LzUrdk5xdkF6RkxvRnNZeURNWTNETmZyVnRlUVhEWWszZStpc3NJQ255MC9t?=
 =?utf-8?B?NUg3enFrSGxTVXRBeUllYjZ5aW5nWElhbHFQM3c3VGp4TXdXZStUc0lITnJk?=
 =?utf-8?B?YmRtVVdVY1o5eStSV1dSd2JZR2FZdTI3WUpJTysvMld6cHdRR3IwNzBUVWtw?=
 =?utf-8?B?TUUrcVBnZjhITTJ1MmQ0SXAxamhVd0dZUWhhWTNtWGlRQXhsM1BkeURVeE04?=
 =?utf-8?B?dEFEaEkySWNKdTF2RU05Z2ZYNm0yek51aDI3MXgzUGhNR29SMUd5UW00QjJs?=
 =?utf-8?B?d0pFQjJVYmpCMUtQSlpSOXZpaTYzaHo2bHVjVGRqOUNlMTFBczJNQlNQQ3VC?=
 =?utf-8?B?ckNscUM0ejI2OEdGRzZvS0dub1E3ZVArS0VPV0dONzBueXFOSGF6MFdqdyt3?=
 =?utf-8?B?djRjNlJlOHp3Q1daaDBPQkR3N3d5REVIb0I3Vm1EcEordVMraXZTclkyTXBo?=
 =?utf-8?B?YitEL3lkNVhuekExejA5YU4wVFRmU3ZvLzRlSDVRYmxJU0NwRTVRU1kyVk04?=
 =?utf-8?B?RVRLSGZDd2VHc0VzUlRDSE5rT0FiK0lGdWNYSXlTZUp2dG9FaXlkaGJvaFRv?=
 =?utf-8?B?MDZGMU05enVIWHZSWUlKRFQxUTJMWExKdVUzSEpCa2RwcVFDS2N4UnlqbVBW?=
 =?utf-8?B?SFpOOTZvN1ZCakhoRmRhc0tranduVHNhdjZCbElNVkNlR2M4b3JPSkJqSEZH?=
 =?utf-8?B?WWh2bUIySURZVlVYVzQxNExJM1Rrc0cvdUtFazdoZWJ6MWxBTXZ0UFpqR0dv?=
 =?utf-8?B?a2w2NVorKzQvUEFMeHdUUjdWODQ2eWFuTW9IQUF3b1lPWEMvNkZaWTU3ekpn?=
 =?utf-8?B?RXdibDNmY05VZS8xM0NPWjJmbDAwMkFTN1dNOWVDL3NBUWdVMnQva1B6ZWdy?=
 =?utf-8?B?WWREQ0h3OTdNbnR2amFrbzdKd1ZJbmI4RFdPNGxFSEQvQldZN1d4b09ML21i?=
 =?utf-8?B?NFBUYmdUNzlSWHlaQnR1c1dzRlVCWGFJcmJIdTY3SlpUeGs3QURhYVBhMm54?=
 =?utf-8?B?SGZnK3NOejZHZmJlajV6UkFFRndLZWQ2Z3Z1QVlJZys0NmhpV1d3UnZOK1Zj?=
 =?utf-8?B?ckNlVjV0TW5RanQwaGlnMEJrUFp0ZnFMRnJRaXZOaStmTkRTZXFwZTJ4dXRU?=
 =?utf-8?B?dG1vd1JmcmVtUTZ6Z3hsbUZ4dTc5bFZ5YWJlZVpDdGZPamVMN0tXcEFVd2xK?=
 =?utf-8?B?ck9GQTBqVGFoS0kxazYvOE1nQUh6ZFJTcHp6bWNXSVljYzQ1Sk1rd0dFVnJW?=
 =?utf-8?B?YkduOVo4UE5TNHRxTENqTkdiRnU1bzdXTFMxYXJKUHJrMUUxMFFIVHVGRFVw?=
 =?utf-8?B?L2UvbWNjd1hQZXU0N0NncXJHWUtVS0RKZW5OVEE1cE9kZTdUcTd4UT09?=
Content-Type: multipart/signed;
        micalg=SHA1;
        protocol="application/x-pkcs7-signature";
        boundary="----=_NextPart_000_014C_01D83F6D.81FB39E0"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4001.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7a254c-3745-44fd-f260-08da0d41987b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 02:54:20.8172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SY373p4LrbXBt8XnMbByahLeBl6FMhc5Y2XTI/CtTFqK2vh3EHDnYodAjkPT80QIaUWEuHWstpDrQ8riwYQ5wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6841
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_014C_01D83F6D.81FB39E0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Adam Ford [mailto:aford173@gmail.com]
> Sent: 2022=E5=B9=B43=E6=9C=8824=E6=97=A5 1:23
> To: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: arm-soc <linux-arm-kernel@lists.infradead.org>; Adam Ford-BE
> <aford@beaconembedded.com>; Ulf Hansson <ulf.hansson@linaro.org>; Rob
> Herring <robh+dt@kernel.org>; Krzysztof Kozlowski =
<krzk+dt@kernel.org>;
> Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> dl-linux-imx <linux-imx@nxp.com>; linux-mmc =
<linux-mmc@vger.kernel.org>;
> devicetree <devicetree@vger.kernel.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 1/3] dt-bindings: mmc: imx-esdhc: Change imx8mn =
and
> imx8mp compatible fallback
>=20
> On Wed, Mar 23, 2022 at 9:11 AM Krzysztof Kozlowski <krzk@kernel.org>
> wrote:
> >
> > On 23/03/2022 15:00, Adam Ford wrote:
> > > On Wed, Mar 23, 2022 at 8:56 AM Krzysztof Kozlowski =
<krzk@kernel.org>
> wrote:
> > >>
> > >> On 23/03/2022 14:40, Adam Ford wrote:
> > >>> The SDHC controller in the imx8mn and imx8mp have the same
> > >>> controller as the imx8mm which is slightly different than that =
of the
> imx7d.
> > >>> Using the fallback of the imx8mm enables the controllers to
> > >>> support HS400-ES which is not available on the imx7d.
> > >>>
> > >>> Signed-off-by: Adam Ford <aford173@gmail.com>
> > >>>
> > >>> diff --git
> > >>> a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > >>> b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > >>> index 7dbbcae9485c..d6ea73d76bdd 100644
> > >>> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > >>> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > >>> @@ -39,14 +39,14 @@ properties:
> > >>>        - items:
> > >>>            - enum:
> > >>>                - fsl,imx8mm-usdhc
> > >>
> > >> Your change looks reasonable, but why imx8mm is compatible with =
imx7d?
> > >
> > > I saw that, and I wasn't sure the best way to go about  fixing it.
> > > If I move the 8mm out of the imx7d category, do I need to add it =
to
> > > the enum list associated with the imx8mm, or can I just delete it
> > > from the enum leaving the const for imx8mm good enough?
> > >
> >
> > The DTS is using:
> >   compatible =3D "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc"
> > which looks incorrect, based on what you wrote in commit =
description.
> > Since fsl,imx8mm-usdhc has its own compatibility-group and defines =
the
> > properties for entire family (imx8mm + imx8mn + imx8mp), then I =
would
> > assume that either fsl,imx8mm-usdhc is not be compatible with imx7d =
or
> > everything is compatible with imx7d. IOW, DTS and bindings should be
> > changed to one of following:
> > 1. Everything compatible with imx7d:
> >   compatible =3D "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
> >   compatible =3D "fsl,imx8mq-usdhc", "fsl,imx8mm-usdhc",
> > "fsl,imx7d-usdhc";
> >
> > 2. A new group:
> >   compatible =3D "fsl,imx8mm-usdhc";
> >   compatible =3D "fsl,imx8mq-usdhc", "fsl,imx8mm-usdhc";
> >
> > Which one, I am not sure. My commit 80fd350b95 organized it in (1)
> > approach, because also that time there was no new group for 8mm =
(added
> > in commit 431fae8). I assume NXP engineer knows better, so the =
better
> > solution would be (2). In such case, imx8mm has to be moved to the
> > first enum and all DTS have to be adjusted.
>=20
> I pulled NXP's downtream kernel based on 5.15.y, and grepped the code =
for
> imx8mm-usdhc.  It looks like the imx8mm, imx8mn, imx8mp, and imx8ulp =
use
> the imx8mm compatible flag.
> The imx8mq uses the older imx7d.  I'll do a second revision later =
today or
> tomorrow.  Looking inside the driver, it appears there are some other =
quirks
> that different between the imx7d and imx8mm beyond just support for
> HS400-ES, so I think your option 2 is appropriate.
> Hopefully someone from NXP can comment.
>=20

I think better to change like this, and dts need change accordingly.

  compatible:
    oneOf:
      - enum:
          - fsl,imx25-esdhc
          - fsl,imx35-esdhc
          - fsl,imx51-esdhc
          - fsl,imx53-esdhc
          - fsl,imx6q-usdhc
          - fsl,imx6sl-usdhc
          - fsl,imx6sll-usdhc
          - fsl,imx6sx-usdhc
          - fsl,imx6ull-usdhc
          - fsl,imx7d-usdhc
          - fsl,imx7ulp-usdhc
          - fsl,imxrt1050-usdhc
          - fsl,imx8mm-usdhc
          - fsl,imx8qxp-usdhc
          - nxp,s32g2-usdhc
      - items:
          - enum:
              - fsl,imx8mq-usdhc
          - const: fsl,imx7d-usdhc
      - items:
          - enum:
              - fsl,imx93-usdhc
              - fsl,imx8ulp-usdhc
              - fsl,imx8mn-usdhc
              - fsl,imx8mp-usdhc
          - const: fsl,imx8mm-usdhc
      - items:
          - enum:
              - fsl,imx8qm-usdhc
          - const: fsl,imx8qxp-usdhc


Best Regards
Haibo Chen

> adam
> >
> >
> > Best regards,
> > Krzysztof

------=_NextPart_000_014C_01D83F6D.81FB39E0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
MjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIw
S2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhw
LERDPWNvbT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlz
dHJpYnV0aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VD
QTUuY3Jshi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCC
ARAGCCsGAQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVy
cHJpc2UlMjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZp
Y2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9i
YXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0B
AQsFAAOCAQEAJpGYHveFzmgLQ4J62fcmPkd4wJ8urL46itMWCgyLBPRARYB9oArCqPd4j0Yl0RmS
F1oNZgVDYQTy2aLoe+YGm23TkdJsTx1ExTxtv+njRnvvlSXMMULlOIt25/Vj+vTZ/wjFDq6PJOSZ
MSQHaVHSUrkLBT1H0pBmCA1Ecjuo7gUpG5T2NqD5KJP083pJZ+nogA9TVC9Ob+jNx0d/UR7UgRLf
KOxBG05AakTa4luadPIRktiULtjzG20WDhvAIg4M9w1+9SV+LpvvqBtkovpCfj9Rf4pNRV1CjjTY
AFIH0s3Q11HnFd1UNHKUvpp7/SrTyxaCXBO68U5aJz4zDjwIPzCCB+swggbToAMCAQICEy0ABsdV
/0AV+3f0TucAAAAGx1UwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMTA5MjIwMTMw
MTRaFw0yMzA5MjIwMTMwMTRaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
MjkzNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL6VTRRCbJgUEuoR2bppNZQc3ghr
l0pDEZjK8uaayFYadelTc6iWe8EBLWrrOWd17yNeXc054yw+Yu8eI1IWMEE/mo5l93Kw+BkuCUda
vpqZUMOvaPDKkHNPBNPJ6AP+vmZW8p/46dxo6Nx6xGzkpbUZ1Ju1a9LuxeFQBNNvV54wYbFmoKJF
eQQ3RZdEafNucOw8ukTyWurcC8fPUQwqE1sFRdtjLeJWZBtrvNim4oikb5UFxcmoaQkJ/sqoJGZL
+bR3ZZx3101+Y7RJp56hfqT1eqkJkc7OTz+tsZx3p1a6r266NCB/RBIGVD2cFmhUs2Uitp/oB+9k
BhycuX8wowECAwEAAaOCBAowggQGMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/heaKboS14X4CAWQCATowEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwQQYDVR0RBDowOKAiBgorBgEEAYI3FAIDoBQM
EmhhaWJvLmNoZW5AbnhwLmNvbYESaGFpYm8uY2hlbkBueHAuY29tMB0GA1UdDgQWBBQY587dMxoS
HzI5SkUyoLrumaVa5jAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhedBzCCAUYGA1UdHwSC
AT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1
LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2Vy
dmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGL2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9odHRwOi8vd3d3LnBr
aS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCB
uwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049QUlB
LENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24s
REM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRp
ZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2Vy
dHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0BAQsFAAOCAQEAsjJuJnMzvA59CAlY
87eQCOafWbMF4HfC4oobtAqboB48BtCZ5dOeo+X4XQRaSmTwFJ2hZjX614KFnRGXLk/nDIY4pp8+
fqfgHKUdY1ceVqs+Kjtabk3gY8zq7PtFUsAkwp4OW23kwphh7Awx1tf3XRZeOqwiVuk5V57GT8Tu
dKNiOZqut3mrcdZINNUsqjt7ZA82r4ov5MbEBHeWVjo7CeWbgZFZhKhMKC9+2DKEUkdDJUcDYqxz
+Rh+6B+dgxeYkTGIqHELhkMjMCC5SwRNHfCxXCI+qRy4zIAo2K3V96zs3ungqiFZuFrpatfSBfAL
d86AIrOgsHhvOB0UU1W//zGCBLMwggSvAgEBMIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlz
ZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3Zl
bjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT
8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0ABsdWyH4wxYEw
yQ4AAAAGx1YwCQYFKw4DAhoFAKCCArkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjIwMzI0MDI1NDE3WjAjBgkqhkiG9w0BCQQxFgQUYDKOcfgBQEXcyWpA9V0Sy0ws
2q8wgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3
DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhow
CwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwgd8GCSsGAQQBgjcQBDGB0TCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMIHhBgsqhkiG9w0BCRACCzGB0aCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMA0GCSqGSIb3DQEBAQUABIIBABHB
le7mLiELPcjpeforfgbYO2lwlTFTX4Tj61pFGlv4Rb4LZTxzt8byYe3zRI4uObPfm6bZ6VtMWjdR
99SGA3mcSDux+MQd2E7IHyliPAQgHExL2RSUNLLcwEJjtApK4Tb3WTESF+SG1wkPXEqmE0hQ/JWp
JDdxu4Wt0w+PVvOxQFH5ItuJiBMau7a0hRjw7QIBe3Ed3dtF/PSgl9urtXw5ygM/nz5mqayXW7MU
KWRuEAt/3he4BMX5tC5CWOlMvwalHPo1HlfxFzKzKg9IIhalx0hE2ohERDVZs/BrY4ga/kBCydv6
hb9zdTTwJv6XG4ZUv5aYIk4VqHTkYj6NxtQAAAAAAAA=

------=_NextPart_000_014C_01D83F6D.81FB39E0--
