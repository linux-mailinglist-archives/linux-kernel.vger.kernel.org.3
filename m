Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8C14C602E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 01:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiB1Apd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 19:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiB1Ap1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 19:45:27 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50052.outbound.protection.outlook.com [40.107.5.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB60344C4;
        Sun, 27 Feb 2022 16:44:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDmGvfLyssO5NZ1bY1ioJHPPthOjFYL3UOEKAL/gDUauPzeWYtdophtUdjykbw0nW9Fw3A6l1fWnobIY/7lp3hUbycTZnY+6JOTX/gguq3E5b1fXxNU/aJzADlKwmKatrbDpOE+a6Q00crj/8rSAzk9SK11mJ7psXWmG9gLjCWOgonvE2XIrV4dL6+wjWzVKSJTMPRmOQnR/LCSIbKmRKxxFnCUf9MehvMXTaWwvPilrJO59ujfD2je/a2Q45cQM4D3923UVYMXr0psTGJ7lm/AsZ9fnbFCk9RUPeZep9VVwiSurfgDpnHwD6utbyPsx8ZL6OTeIxb1e3WnhiNBdpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+zCbLCCEMrWrk/Q+TUZ6k32wWembxhtKw3wE8qlKus=;
 b=lvQS3IKEzlgsnDYOwe2D3sR3YsCQZZ43e7Ywz4DiqlRkyiXvIzVB71+XQw7Phr5iCW1vA1KnCJ7KT1MqHqGy9wPQbP94HZsALMHp9vYMSgk617QzkUnDEu2z1jbB3smi9I6a25ovXjyLS9DUqekztmIclzSZo+xUDasdkBR3HnKwGPiYV0KKXe4Mh5UPgNlE6KiphwlVTW+YHhjab1LFJU0m6S0v+l1VL141cF6t57Dzckjpb0J7USP79fyqzGbNyyTdWOT96YgobwLsBtkwEf4e6RELRR7aW1hy4QkOiTee/aBioGiG7HsEceXPwKp/31b+/Hq4xc1zaCRGrslnSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+zCbLCCEMrWrk/Q+TUZ6k32wWembxhtKw3wE8qlKus=;
 b=YB8Y0TKR/a5DiENlYvbh+M3HzBajL+3wbRJ/b97ZT4RjCls2RnwGXi0EcMdgs7ZxHJDBAf7sSov6OExPP7lHd4wpf3RGI7ZX3G2E9Wnspkrk76zSu9UAHSjkBh/voI770umdkPSyfxT4n8XrTjx7VR3uxzTkMsTViOKPfiYzHE0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8675.eurprd04.prod.outlook.com (2603:10a6:20b:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 00:44:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 00:44:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: serial: fsl-lpuart: Add imx93 compatible
 string
Thread-Topic: [PATCH] dt-bindings: serial: fsl-lpuart: Add imx93 compatible
 string
Thread-Index: AQHYIkQLsWfV0rmwl0a6my6eQFwuT6ykfZ0AgAO1SJA=
Date:   Mon, 28 Feb 2022 00:44:46 +0000
Message-ID: <DU0PR04MB94172264E2DCE759EE3B9A3688019@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220215081334.788419-1-peng.fan@oss.nxp.com>
 <Yhj9joQkgTswMVcs@robh.at.kernel.org>
In-Reply-To: <Yhj9joQkgTswMVcs@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2ff4d42-19ba-4e50-0fca-08d9fa5384ac
x-ms-traffictypediagnostic: AS8PR04MB8675:EE_
x-microsoft-antispam-prvs: <AS8PR04MB86758CB8A4F9FCF5A21A6AFA88019@AS8PR04MB8675.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bw5RwjP0D9wdpevbCWaAKfZ5kUB3y8+IXr67ZhupwMXQ7x5tkK68TyPQu7KWl4S6UjGF2djp2vvOPVtNZQZS3rv58T2e6L+YZys3ROPUoEmhCUJ2bSQRRJlk7U3LnzWHhpuR7nMg82QNFd1CKMqtyMnoQqtIbsUJ2BawZXC7BBA4W2Hr+rL7o1x2UeikDVatJnCFzNI8sNGbocHLjssPAV4InJxwDq4CNwcif1A3Rlwb+uhht4a9ua7L9SgyTiHoxoBmm0XiL4jMHlMLc8XpP8O/UTgOId1Z5nVq5CQkr5NYzxTa71WUSjBXkqW+psh0HyN6XSdold6YQznpaLB5utyCTp1dCjz7lcPsGnAeXNwwPITHnb5+O2y7C5lnRAIdP0dg65oppWfmUUEfbhAV2hLGhhNdzxRy6zvIXhc94D96+AJ/pta98t89/VAT74ufaLJNdoEDMDCPxRNHIH3A3cr8Ojpbo5erbUI74yzqbPmA6Blv/WChhfO83txH4GpSHdZBMGgEx7hF+29BkcslyIANNdE4g6ZVaeDjKL/gPbl32eh73MW6E9C2BZXM/8l6AuZLUMqz3cOJ1a4djBxkreUOT004h9z4uoJEryGl6wsbeVkGyofv1dZJrX5NGpij4URNpgcSxcDiF1zO6qW0AHFMvIQLi2bfJwLGdDwUdmD0ta5Pf17V4VudCMeA08ifUzFKH6/jqahkU0rVe8jqCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(8936002)(5660300002)(44832011)(55016003)(33656002)(86362001)(38100700002)(186003)(2906002)(38070700005)(71200400001)(26005)(7696005)(6506007)(9686003)(83380400001)(110136005)(54906003)(316002)(122000001)(8676002)(66946007)(64756008)(66476007)(66556008)(66446008)(4326008)(76116006)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d3aPgcW5HjyZJuew0uy57GkYObjpd07V7XH547+TqKfA6KHDZvwLm08acVGe?=
 =?us-ascii?Q?+X5n9LXvVE7DmeVfK/oKzbXHry/GLAodvjzvkiJdoNUw8OODJa4svOpnsZTc?=
 =?us-ascii?Q?ClJagB7WnBYy+22n2te8F2kdP5IbUttfVDYkEsVZNs5jW56RLaoQH6KEIvsU?=
 =?us-ascii?Q?w9WzeqlrNazh56DMBiLRCYRV10YyBSEoP/gwOWfwZpMRSg0oZUTXTpR7/3Zb?=
 =?us-ascii?Q?RRbwSyKzKQpSLhnhyoJT6yyAg5GExX7b0DxY8W0Yels+9RBWiRXavQJ4EXzL?=
 =?us-ascii?Q?Etx+XrJZS0v5m2IDf+5MUHMMBO9Diq6amgQHvEiJM9sTyDwOzlue25RoInVp?=
 =?us-ascii?Q?eUppPbLqBerww8KuyhzuRkW0MHDXBZNUf5Ur/jHSNfMVH3ct3JHeIxTCqmiO?=
 =?us-ascii?Q?ryz5OapJAey3ZYbseuXTSu6O7raNjcwAyc7IvNqUcKB/zOA8QxnqIhcwOH7B?=
 =?us-ascii?Q?Tt6aGz36AcToby8YSpmysN+uIiskAHJrnm5HncMV8Eglt31idKzcE46KxVS+?=
 =?us-ascii?Q?noEWAlKsbzdd64AO1Y5bEoIjr2HTLVp16y1/tKjuwWc3Q7VRmBkG3nMKjPN9?=
 =?us-ascii?Q?/acfn01KOjlHn4/R+onSfYUbWCuL+StzC752qXpPABIOv0PL+lX8P49wpJU1?=
 =?us-ascii?Q?CF8/4F5/A9Z6+ppr6SJ3UFAYHMFTwz7Z5Pq2BETxojG6V18YkQdQxSN6V/oF?=
 =?us-ascii?Q?vLnIH98Av/Lz7s6fptHC6h7vk7Ntl3MqJwhLWasvlXINsApWDdLr6liZDTJn?=
 =?us-ascii?Q?CfgG54DipfKKz2QpwOJ9i1v/o06fODki9trOLaYlEjjHbpWKVQfar2J+rnhN?=
 =?us-ascii?Q?WzBHO6qVuJcTY/9hdSvW9OuvNs8gDh0ND2NVsq1S79tOXD3IszlrjN+NZN+u?=
 =?us-ascii?Q?i0Y0Go9SxLiQ5TEpa750ms5azfEtFP6BCdataqun3PwaP9JutsXAyhFtMz67?=
 =?us-ascii?Q?GJzn9b1GDe4ceZJYE8aeA4qzXsn3MC5zgGrUghemCmC8koh6QVcR6lHUaPf/?=
 =?us-ascii?Q?HJsMwA9HW+esSCs3+5RJ4ysMVvtEIdSmKQNHaJA84ERxmqr7NEX5Lth/aAVW?=
 =?us-ascii?Q?KoAkEkN/RyILva+UebGMG9a5aq+91f42GonVsQBw+CYuY7y5g/k6qX8muFBd?=
 =?us-ascii?Q?58S/eFjjR2MCr7K8zUfCbpF8SNff/xgAHz2E2yAihk7M12hhHl+6Yn0NIB7A?=
 =?us-ascii?Q?z9sJOtwBrI7G+9ghcU66s2PXIyQ/l5jiJDcRVMvZXRIeK49PY5p6JQoSWdnA?=
 =?us-ascii?Q?CHumphvLdfO0gR0rdP8q5+m/QMsTOe53fDimUEok4P7e1cQynDuNlpSpcERV?=
 =?us-ascii?Q?A5buimmlKf5RSI1pt+veYAjGI+N9JGIz/lTvtTtGjmLMwbGHXQNOwDK8bsb+?=
 =?us-ascii?Q?Yx6oX15biujp0iADpXgbWPi62nl9fXnajwNtMjTFJdzktjVPN5HBrsx9JrwW?=
 =?us-ascii?Q?eLqfU5x7q2WS8OY4ey4Li2PxgO0UQq2FYYuI0zeYNEexcx1c7zMV7iTRpkZk?=
 =?us-ascii?Q?Sl+toy0Hs3GqvZOaMC/nHxRxjeZWFbcBdYtqeFq7MAE77tdZmIKK3uoRlvPA?=
 =?us-ascii?Q?ol3DBKMksly277FenqBxR6c1hkM2cV4EWMXR1qqWIrdVdJUYDu/unF6R0Tjr?=
 =?us-ascii?Q?wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ff4d42-19ba-4e50-0fca-08d9fa5384ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 00:44:46.4109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJh+l2IfiP6Q0neHcfUPUwKdNALOKNEpzUZN3b3U7RJOo5MkJdFTsMeuOb9d3wuPpQuvmTEXDYi1UkhuB9FbCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8675
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> Subject: Re: [PATCH] dt-bindings: serial: fsl-lpuart: Add imx93 compatibl=
e
> string
>=20
> On Tue, Feb 15, 2022 at 04:13:34PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The lpuart on i.MX93 is derived from i.MX8ULP with some industrial
> > enhancements, it uses three compatible strings, so update the
>=20
> Looks like it's 2 compatible strings...

Oh, yes. i.MX8ULP/7ULP is same uart IP.

>=20
> > compatible string for i.MX93. But for a few instants,
>=20
> s/instants/instances/
>=20
> > DTR_B, DSR_B, DCD_B and RIN_B pins are supported, so use one
> > compatible string fsl,imx93-lpuart-v2
>=20
> If the differences are just what gets pinned out, then I think the differ=
ences
> should be handled with separate properties. We probably already have some=
.
>=20
> Plus, while you may have all the above signals, a board design may still =
only
> use a subset.

It is SoC integration level with above features not support in some instanc=
es,
so no such signals connected to SoC pin.

Saying LPUART IP itself support DTR/DSR/DCD/RIN, but instance A has the
feature disabled when doing SoC integration, instance B has the feature ena=
bled
when doing SoC integration. What's your suggestion with such case?

Thanks,
Peng.

>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> > b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> > index 6e04e3848261..d7805f31ccc2 100644
> > --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> > @@ -24,6 +24,8 @@ properties:
> >            - fsl,imxrt1050-lpuart
> >        - items:
> >            - enum:
> > +              - fsl,imx93-lpuart
> > +              - fsl,imx93-lpuart-v2
> >                - fsl,imx8qxp-lpuart
> >                - fsl,imx8ulp-lpuart
> >            - const: fsl,imx7ulp-lpuart
> > --
> > 2.25.1
> >
> >
