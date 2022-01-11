Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7E48A7E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348276AbiAKGpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:45:07 -0500
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:4578
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234266AbiAKGpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:45:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqjrc4G/kVpZfOhguoS/VC8ydCGmkkhCGmIg2SP+66AWQ2DN/3+TeA19NY6fT2uAXic1bu43fxFYjPgCCsT03sRbMW2hWhxAsDcxf9kU5a1KJomxm711fz0xjunjScVkFZ67C1jl12jRMNJpkxuUQWL+Ui8QR9Cjsr+S1upDTSs7aRFRIgHQzshW/f/12QvmtYygJj7mP4Ng3FTdDMFNCZ+KnwraYrbwDSju9eFpnAWKBhpo51seRs3p/k8PbZsJvguJtG7durxnSyivGk/M6tCev719vbHRpZZdwqdS7s/o7ihxuLziGbqfZ1gXzaeRFftT3V5rhR4bJV1I4fq5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3KPgP18tkJvzeeCMzOS9XuTICfjoxGR9lnEXZNoxh0=;
 b=DlZFknQGbneFEOYWK1I5Xla4OJzP1fKIygP3LMdR9edn2ofJ1V+VCt0fSm6/iFSl47h2vV+gaD0gtsCcrgdfULiMmvny7jFyXC+/qCOEPQwAzK97zlwDkUvN6qmTU0piMiEuhqzxXpoeYLAAq+mXuW9sAJ2jozkN2auVuqEebzjcjIuSsIOMWeSJPPxbvGWyahhMIhHnY/iMpgUBn3etJLEdHsv1RLKZDfb98CdjbykTtBRQtnGDA9/xosurWA3opMGuIKqP2JfwoVTXgNt0krmPKBdhRtA8ScXiHwp8Y7je+Rv0bmkaw9S7oXFKgKSW+ICUt1u7NW4HU7PTY7y2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3KPgP18tkJvzeeCMzOS9XuTICfjoxGR9lnEXZNoxh0=;
 b=KCCiHQdZraU3O4W/ApDazCBFkQYZq5cuPrmRyipKaONO6/B3RP9X0xoXc5hGpmo4t1NftW4+pyoZM1OT6LKNr2tf+sXAfMXoDyNUeB2w2lYpAmvOuKZ6sqBWwOqNbdhTFQcDgfAIVnekX0Gp5YxpwibiY6wwW7OZfUhnxei6578=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9402.eurprd04.prod.outlook.com (2603:10a6:10:36a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 06:45:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 06:45:00 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/9] dt-bindings: remoteproc: imx_rproc: support i.MX8QM
Thread-Topic: [PATCH 2/9] dt-bindings: remoteproc: imx_rproc: support i.MX8QM
Thread-Index: AQHYBpwsoGAlBXQvO0OoMA1IWZ2/a6xdYEfg
Date:   Tue, 11 Jan 2022 06:45:00 +0000
Message-ID: <DU0PR04MB941738987CD958741E42E34B88519@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-5-peng.fan@oss.nxp.com>
In-Reply-To: <20220111033333.403448-5-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f97deb2b-2f10-417c-fb7e-08d9d4cde400
x-ms-traffictypediagnostic: DB9PR04MB9402:EE_
x-microsoft-antispam-prvs: <DB9PR04MB940298073AB456A933FC5D6788519@DB9PR04MB9402.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8e+nDWaiFq0O8etnH0BR2GSFNgat7P4e7adHQRFhWV7mFe/a30sk75iYxEBsnpuwVPYz/0txmM+gMli3m0ebyejLOqFovbnsmmBvFIL1zeWDXndhv4QJ+dCRAjqXMktlj3DKhcrQ6lhYCK8OVMfzUjoNKqRZumVEoh466Z74TJVNJGl2+nqh00ktJAauQHLp1QF/+OCkGOW6NMXd108gqCPclIqad7o3I0x7UBe5TI93V55q/Ph+2SGPK1FEvDU+iagKOUVA0xP5SAVJO+N3fiWW/IxxrdiwlPx6Q/xgXc6fO2kCfYXIYevY2RPlU+jspT1ft+v9k7iQuP6HDfxzYgo+FZWRA9osuLbLc/Aq4yBoB+Gd9fADnkJTHHizQoFMLuCdHTGaa290cH8OgR/OgZ7s9CCGsebY05gbnAjBlYeErZoQyFc3eh+hV9tFHXIXOn6YBernkFmVB3oERFslHjwsEbLgbkQvq0A+VN9TbuEC6VnTbCCgE210AYnbj36jrBCah7D7OhQNjGP5j21uvp+sn05oSffupwUAC6Ugv1HJPy5izVK6P/rMbk9oALgUNRQD1vA9d2vRCpMxByvTJTp92RQeUfrSMOggDCeZjt9KEp73B0KVDmsZ1mn/avl3S8GePZ1MuSv2tvksxjpE1fthfD2MA6nvgqMyUVMNDtS7nL5FexUkn7xhuX5dP2d/iQre8Oo2gC3ze0UtedOPf76ARp2TIRDmwTxuD/nZEns=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(66476007)(186003)(9686003)(110136005)(71200400001)(26005)(8676002)(6506007)(8936002)(66946007)(76116006)(55016003)(66556008)(316002)(66446008)(64756008)(921005)(38100700002)(122000001)(33656002)(5660300002)(38070700005)(44832011)(52536014)(508600001)(2906002)(86362001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Fy48OFhrP8IfiMMt1kerpjI6gi88apBVlU8q5HMToaKAkVVcTMhV9SN+buw?=
 =?us-ascii?Q?sWxfTqsWHLhBU4EgWv5Kpql4qSDed+/CQXzvP7os31k6qtr1xkMf8QpgywA5?=
 =?us-ascii?Q?87LvOKgtbCLNk4cPyBXkpT53HPrkM/9cFKDeYQ9BY2X4RCcWYxE2pdCdopto?=
 =?us-ascii?Q?p2YhKfEICPlTL+42ugSmOgdSShiG9LLCVMpV/8Yb376xv8kV2IUe1zgDQ5NY?=
 =?us-ascii?Q?rPKCaoUefcT1YuUjX7D0TISsnzt/tX1Use9clpg8FEyO1Pt9cAsvo2krhcle?=
 =?us-ascii?Q?aIgM8fEMdPX0UpfnGur1rEaJNUW3bX6lm6Li/hbaNeLGzx40QeU0FPU/XMOA?=
 =?us-ascii?Q?0W71Tm9X5vcq6SM0jCbmepQyzISOXAb6Gdt3pa5yJf/gmMT0NJISXwyz5Xat?=
 =?us-ascii?Q?RDV9r6hQ1VXLhJJJRFH5nqGzNGtg7aqFCQInbaT82s51D6S3u7ELHrr6QwVo?=
 =?us-ascii?Q?x/bjdOo2M9bNglk84lXKjPgaPIvBPIPCshb7fddNA+eLHyRbVbWDKca0JlBc?=
 =?us-ascii?Q?CgoyHZpoTxy4werAEZyu5msF4RSsn660utc92bcfFXfOEVDO7Ix7caL380LT?=
 =?us-ascii?Q?Z8kw+VcPgxHomG94ZVeMmNZQCz/jbtOawSxRnh9eKM8zg4z2QWbBICdZ3wbz?=
 =?us-ascii?Q?xN/2oBNzohRB845FvUwEskOL56+j2DlNjWgLc5kA8x25BU/yYVkIWwa1pfru?=
 =?us-ascii?Q?fRK5uQlEFHcp1xM93qM8X/0Lr+SGgl8r5YrvO8ckOavVE6K7RF/lZTtrRXR8?=
 =?us-ascii?Q?5XC4N6imtkaw0k6fI8SmAt95g3RSIPHdFx4gf8Wm611a/qcjVYWPBV8TB0WN?=
 =?us-ascii?Q?L0WUhc8NEDzO2ExXPMYdv9D+8SkZSfd/FTlKqingk+j5D1wH2NGm2hOGS3qU?=
 =?us-ascii?Q?0eB2tNmcVIA0G0bgDt+wL4dLpB9F7nBxLbt9tbMzx3xlWLZ/v2WuH80WcAkS?=
 =?us-ascii?Q?a4cGntigzcTeSCg9jZgSlTgbXZtg+vOK/CFKDxIbF+Iypk1py5wVMrzXULvG?=
 =?us-ascii?Q?uAxkeR5Y9eBy2EapWDB2hMfcMxqv8RpujIPoOXTQn3n08Ipfy5SDCvJsxDNH?=
 =?us-ascii?Q?rNzkoTd0xqfNgex2HtOInCy+FsVEd8K+BJaL1UpREgAk6J+ReLZTwvEdDrKJ?=
 =?us-ascii?Q?qnWRjSOK1i1LDoURVB0GN+FEMw7kUPYBQN/hKM7JJ8TUl9DORKhw4J5WRjKf?=
 =?us-ascii?Q?dp/ifRjzDL/v/XY1U+0zIaUUWQ3Oh8BkPnu8EZar7tMsHkJL5qTn8DbxHNhF?=
 =?us-ascii?Q?Pje2dx5gUnWQGYjONHHyANtQfc8IeLgNTvstWsbEhF2r2Xsvpjb9z/8Zm63O?=
 =?us-ascii?Q?Gov9vbUf/c4BeUILayLUoITqWHjRmSuVeBoboYqUXrIZ2vl/C6Zlrs0o4Sge?=
 =?us-ascii?Q?+tpga6ACD4HUL+vqwAA+vWufnlTMocqlAUTYQ+noDpTlKY/DeIC91RPmoGOb?=
 =?us-ascii?Q?96fhBQMliLkayIX3YqZWB7fpeUgKnuvGOYFuQ9u5hqh1pgxQtsfSAqZCs2e0?=
 =?us-ascii?Q?40hu/WO73NY7H/1PG2fTe+Awvxlv8v5DF93RMI/iRDzv4A3fI7QKW8ObKigH?=
 =?us-ascii?Q?DVONmOM04YcDQE5lHJevz/u2vBkwuYFEuPJOzAA9uJqL5pDi8OSkRTN+oHKc?=
 =?us-ascii?Q?hz3AuPrNCv5tLb8ZW8SHR7A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97deb2b-2f10-417c-fb7e-08d9d4cde400
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 06:45:00.7196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMKtp+2hkk5NY6w1ZKFYXVpvPUMtjO9bxzFZE0k0vBVQR/sXag2aHL1ozKq0ONigFMkfBnm895WAgJw+ZhKRyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9402
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 2/9] dt-bindings: remoteproc: imx_rproc: support i.MX8QM

+Rob

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add i.MX8QM compatible
>=20
> There are two general purpose M4, so add reg property to indicate the id.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml         | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git
> a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> index ed1bcb3046a9..cd9dcb63b176 100644
> --- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> @@ -20,6 +20,7 @@ properties:
>        - fsl,imx8mn-cm7
>        - fsl,imx8mp-cm7
>        - fsl,imx8qxp-cm4
> +      - fsl,imx8qm-cm4
>        - fsl,imx8ulp-cm33
>        - fsl,imx7d-cm4
>        - fsl,imx7ulp-cm4
> @@ -63,6 +64,9 @@ properties:
>    power-domains:
>      maxItems: 8
>=20
> +  reg:
> +    maxItems: 1
> +
>    rsrc-id:
>      description:
>        This property is to specify the resource id of the remote processo=
r in
> SoC
> --
> 2.25.1

