Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBAA4932DB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350907AbiASCUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:20:37 -0500
Received: from mail-eopbgr40054.outbound.protection.outlook.com ([40.107.4.54]:21151
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350898AbiASCUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:20:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlbLxdOGcZEYyASNkoRnEdWMzjuMC0+x3AMrZBS4RdYq89bgVaUX44NTqvwhlLO7VWyc2eCvjFrue5ij6DxGCrAHUtp5kqsu8JcYeB6yp0dQAsboYKcEeziFcsonnJIRqO+PfPKZhuqnf+TOjkLZ6vIRWZsIH1oMld0/9rg6C6bBjmoDMPz2e3CyItyNmk+1BEO++XmasOt7rxfVsuziP8NmPRPXWCbk5vAj0p8YrIKknW+3TL457+zqbEQCVmpNCimdfpSZ1WB5v8lXuZANHTjLk4KATMUboH/wlTYEGL2ud7WwCtssYL+NU57BJp5KBOf9zj4MmI0IDc1fFqbj7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbqseQfmL/vYT18lq4VqpIpeAUTxjTXvfkZo32rXaXo=;
 b=ZKXfL7fRWKZ3RvyLfadt+aEkokotV/lUPP/tMMxXC4b0lvjZylrCrb6/y2u0j6TFsJlv0Rn/bjYChy/OQWBfgM55SY5kYLBSkFyjouKO8w6Pzms3hB6N5XIPsCiiJd5FCaaiJv70JZK837ufE5dVzjx52HVOCK4PtJ6wBIqCMY07fG+Msybauea9Kra4UHH1qZlh2g3NXZQRDpAtsrAkhFfj8pmJk6y7MZjFLEwnsFsBd51zGIJo3Pti/keTRfSIACMbcad0KtPFjrtgZUlcHy/VWWH1MkX/U6lB/vL+JmufdkoKLQioVwk5WR/dWplYWR5us7mw2MnNgnRXuyAyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbqseQfmL/vYT18lq4VqpIpeAUTxjTXvfkZo32rXaXo=;
 b=XUCVrgQj06xbSK6K2G8qi4GTVp1Oo35KoT92u4CaVF0XM6l23ed5SIV9CFb130y7yjMCoE+myHiIjzPou7nfIOoJwpetBQPALtYbbpbgM3yd23mEyBRiHNpyQlQHN2m1qnyX9c9Qdzo2yjKjjgrLDy/7XRz/T3wmaBjVvISiXe4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4763.eurprd04.prod.outlook.com (2603:10a6:10:1c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 02:20:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%4]) with mapi id 15.20.4888.013; Wed, 19 Jan 2022
 02:20:30 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/9] dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
Thread-Topic: [PATCH 1/9] dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
Thread-Index: AQHYBpwqPpFjre1FRE2CDzo8h2g4iKxpKMOAgAB//MA=
Date:   Wed, 19 Jan 2022 02:20:30 +0000
Message-ID: <DU0PR04MB9417338F4E1E7F6866AFF16888599@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-4-peng.fan@oss.nxp.com>
 <20220118184123.GD1119324@p14s>
In-Reply-To: <20220118184123.GD1119324@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6acdd887-9078-4523-5b0d-08d9daf24428
x-ms-traffictypediagnostic: DB7PR04MB4763:EE_
x-microsoft-antispam-prvs: <DB7PR04MB4763EC260B0B7695D3461F8988599@DB7PR04MB4763.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CClOB28ablHZQHGdYdHDgbsRyeKpAyu3BYk0ewxO3y3SA35m0BAR9Om8yI2zT4443L9KLEnYU3EVruJnX5PO6xKhzUJ41rTulMr1/fj9daYZE3gDDPd+iKWoxIHOQ/hgh8vkb+TjFZZk0+2f3NcQXtaOlqHdAjM69IAX3+Q+q76QXbDPb57OEVTqsb3Yv5L7NzdRWjkZz+lx6TEWOjJwyafx0HQd5jCRF70M5OerlO5MwPOVR0jvIbowfTx6e6kBRLl+Q66WyUuIuTlz95MH+Bl4SIVnnSknorbR90mVVnuRaWW1zrMd4iTPkYvn2Y3Moxzrf12qLgfpV26AXJuIcxoRoq8bsJeszzRRYPzxAjfG7aRPPb8iHRYlF16fL6PY2pyRrxAEoM6nPOR80CoItslX1p6nd0DExZZLzPOUrQQ/zDvJodekZj4hoY6+/CCJc+wr40FhCvkuF6DI1zhIyB7YjckudT/ZJjlHhNgrNgtIu0IpVH/EX0GuaqZX+rChvBUxyAxC5S1EtKypVA1FLchncQ6aRG4vdvJeDs/xn9p5wXgKiZoHB7hoJ3MG8r0aBpeqMQZPx5R+L32zfhKxA9t4pJvJwwUYK7X73Jy+eTgk8h7xQwg01LgBFXMmm+WrqoVguUFXvL85r7yyhev7DAmv4Ya1J1N3lhMA6QoQ8A2Qzg1DNltMy3bjRi5R9C51G83TV4MGuqdtcFVITh9a0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(86362001)(76116006)(66946007)(66476007)(55016003)(66446008)(66556008)(64756008)(186003)(4326008)(52536014)(6506007)(7696005)(9686003)(38100700002)(316002)(8936002)(508600001)(8676002)(26005)(33656002)(71200400001)(110136005)(44832011)(5660300002)(38070700005)(122000001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4PL/ygnOonDrsvuj/5JJSc7cvCvqrEIXAVuXzZUDToHh7quVSk8HdMqJhhbK?=
 =?us-ascii?Q?mP0wDbl60Qg4KbeVhUj/+9fBrToZmVfVcsCLmxSfAdJNp9f2rZ3PyVCV5BIo?=
 =?us-ascii?Q?p8yCi7C1hRrgrUQChN/TXUCjpk1lEvzgMtfAHqMVx3o40Y5J3jLkLJgsjI2W?=
 =?us-ascii?Q?A6eS/YrqxCjsniuemBEBLLwQmT7P8nB6QSyLKWOllxP55/jAtUw8vC0FUboA?=
 =?us-ascii?Q?UGaepItFRmp46dp9mciSm1irBXlRIXqUmbMque8gms4UE2ph/B6OoPJRIgu2?=
 =?us-ascii?Q?muoSytcFTUlQmhKl/S88KRiBpAckDcQfq9Hk9FZ1GiaAkoE2rJtidls0qMAv?=
 =?us-ascii?Q?A7PP3+QVzeWIUqIMoJifAjqthAM0FPHWMIl9EZzK6EzrHSenZW7I3eiGWFPx?=
 =?us-ascii?Q?dS++7Y5qcqFdwrdoEMchNQXXaN+9bb+iitTwCoQRwrg2SLALNY8DifVidDXh?=
 =?us-ascii?Q?/XUWBxV6EZwjpxwIn/iK5ED+JKldhP5xmaR5Jo6bsWTTyzD/K5NHhNr0aCoD?=
 =?us-ascii?Q?YgLkqbJKY9UNM78HoqV3B8dI7BciATdaFWapuCv645aCvVWo3GeZnmunNcKv?=
 =?us-ascii?Q?5pXRwTWMN0fAE4Wy1cbtUOp+H+v1VlSG7taAfxdbxN+rf+FDlA/TFLVEJKes?=
 =?us-ascii?Q?IzOt4TEnrWtReKBbn8pUIgzZfW2GOfPcCc3FUQjZ2SgAo9xPDY5K/gPnvrms?=
 =?us-ascii?Q?8GuRMm5uZg6ehKGyYJOTitBjGQqK4Bq/d3ma8SlUxWRukhLY6yMeaZQL0wHa?=
 =?us-ascii?Q?w6CNWNnBKnh28Fx15cYVTP4in90kKJ5FWLTa2H8Vp9jFCvUIEunOhlZYDIZe?=
 =?us-ascii?Q?Y8jybGsSNhUV9Egq13zf6oZWFqrm9EQeN21aV2iSQOHXWpkNchFjd3omm4Yf?=
 =?us-ascii?Q?aChQma99AW/io58xWeqFHdDtNGheDvhSqmhkp3kGgcTvo1avgksY2OTYuHLp?=
 =?us-ascii?Q?m93bEhnUXoxEeD0DzVLqWEfo3bSDH5CwAEjiV/xQXqwUDD4F0lOAOETEGgoB?=
 =?us-ascii?Q?/zqzLprN0AQhMLj2fSYJg3kSQuqQCDAEB21/wE4EQ4HrfA9y32wjODxNRDji?=
 =?us-ascii?Q?/z94ztj0bstzGpJ6nyaUWA9IctyZXKKAm5i1N3wQT+PGmU98ZgJmnkKtlGe0?=
 =?us-ascii?Q?6gkvx2/X8wfuHsQV+7s+uFFd3M3AM4rVseqM3UWWOszjAVJmeRGGQ7r6f+Bw?=
 =?us-ascii?Q?gktFzhLPtdbQ3FAJlR6o8Teqfgi2XHgDabT19hweJcOoJn/fvbTjor7KscB9?=
 =?us-ascii?Q?fewFRzWDng4N+qctsrcy1tkGowrF/orbyMq2EY65nJhOwMmYsjSSyvRyn+oK?=
 =?us-ascii?Q?NW06EbdNrHLxdB5ahUIbLSeEa/whVr8sBgGZFNsnstpuUy9cfmcU1SPiGWRv?=
 =?us-ascii?Q?7lHwaJk4xtW6PsAQEkrs5fbaEm+iG/DKPSSP+e4MTZ2FaCyXySmUeyVvXa7F?=
 =?us-ascii?Q?WwQOWMRWu3Ek9l9vjFeveqlfBcsTNHp+v7ZCj1fM0aNAL2X/cOFuW4xSHwnI?=
 =?us-ascii?Q?7/vHJxX38lypUHc7wTw1bRhF3a0glgbN2GvQnJxiRfMQts7GVjjGdEAMLPsf?=
 =?us-ascii?Q?JIlVZhyDTKiqV9vb4OgIf1mhg4QWwNG28LLIyL5MDqiFQheK8J5hnVPmrLZ+?=
 =?us-ascii?Q?LWUxBjaEiLZtXdJVyTpNsZU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acdd887-9078-4523-5b0d-08d9daf24428
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 02:20:30.8809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZ35ZHCgmGkLSZkNjetE/LUuPSH0JR2nfVOO9ej84UIVNDbLsybj/JMEILPjlbAC+9+UsrfDCcQ9yBmMb8fIiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 1/9] dt-bindings: remoteproc: imx_rproc: support
> i.MX8QXP
>=20
> On Tue, Jan 11, 2022 at 11:33:25AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add i.MX8QXP compatible
> >
> > Add a new property rsrc-id for SoC which supports SCFW. This rsrc-id
>=20
> You are introducing an acronym that doesn't have a definition - I have to=
 grep
> the kernel tree to have an idea of what SCFW is.  That consumes time that=
 I
> don't have to review your code or someone else's.

Sorry. SCFW(System controller Unit Firmware).

>=20
> > is used to check whether remote process is under control of Linux or
>=20
> s/process/processor

Fix in v2.

Thanks,
Peng.

>=20
> > not.
> >
> > To i.MX8QM/QXP, when M4 is in the same hardware partition with
> > Cortex-A cores, need power up M4 through SCFW, then M4 could start. So
> > introduce power-domains property
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml  | 10
> > ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> > b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> > index fc16d903353e..ed1bcb3046a9 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> > @@ -19,6 +19,7 @@ properties:
> >        - fsl,imx8mm-cm4
> >        - fsl,imx8mn-cm7
> >        - fsl,imx8mp-cm7
> > +      - fsl,imx8qxp-cm4
> >        - fsl,imx8ulp-cm33
> >        - fsl,imx7d-cm4
> >        - fsl,imx7ulp-cm4
> > @@ -59,6 +60,15 @@ properties:
> >        Indicate whether need to load the default firmware and start the
> remote
> >        processor automatically.
> >
> > +  power-domains:
> > +    maxItems: 8
> > +
> > +  rsrc-id:
> > +    description:
> > +      This property is to specify the resource id of the remote proces=
sor
> in SoC
> > +      which supports SCFW
> > +    maxItems: 1
> > +
> >  required:
> >    - compatible
> >
> > --
> > 2.25.1
> >
