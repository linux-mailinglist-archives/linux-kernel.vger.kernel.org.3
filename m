Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B735459F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 04:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345775AbiFJCK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 22:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346050AbiFJCKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 22:10:25 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10048.outbound.protection.outlook.com [40.107.1.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95FB274D61;
        Thu,  9 Jun 2022 19:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0Y7JGkRaXMG+46SkUn7DHDGjAxAuzHsv8Cucw1tQlHS+iFx8Rgw8YrQMQ5YM+ybUJIsbdR9aHfabwmaN/LK5Y1x98GNBn8clUrh+Pc4jXRD099kQ1XAK395u3BKUco8jMGpPGh/ebC9eW3qofmZkCBRxNMgYODPlTPZlj1Sjbz9YZxMaQdgIEoCqWffbymcmafiC+9ktyZaT9ESh9a8aqFHHcN6dRmqpUNTZnfgmXXS0Si4we51TzVj5PSYAig3mV+uh7nSPwHaAEm/YWJdYhbTm2hRmNtFAOCpU8F6LJzBOjWeSHsYCUFXDToOiJu7LOCzREWgENAni6cV5ENOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfXXyBpToIttZRrCO2lnId/v5kZgP2fX8qMDhfzHxt4=;
 b=dyufgG+5Ztv4oD4gJ8ah9EBl32vRUG2rbTm+kegvJFsJoYJ+jUXEepKNVG2k3c4Xk/GLOEpAL5HWNd7nQeOVdj5V+4S2DOr7+Esl5IHXZcc20jBmPfjgaokO2TgKOGGYA7qcDUCNCrweo3gha/WeZpEg1pNf4hmXb0/VyMhzJfiG2jkjS9y7DaU45n3Qt1KN9tg3oq78e8gPNye3ZidBcaVOPxoB4A917Rux9BhbB4DQRe2uJURV5A0FB0AJZkKeTHrK6KKbAD/GPjHk3WKPngg5FLdxcIEeJpBstufTbYURxzm9dRzgZBP9sn2VWufARO74nBd+Hwzp68vDA+9vFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfXXyBpToIttZRrCO2lnId/v5kZgP2fX8qMDhfzHxt4=;
 b=ITLwYdf5zgb+w/YigY7Na9M9nOkqI3a7F1j8T/d06QMbAIeveTkHV/clZ4H+1vA97+oGnjnUQE78q+0+H7cMZmYnAMP4z1NLBAgazT+tJUPAKdrMAaP+Z4TY6czQE8FhM6MIobutaQYvUs5eaGQMskUKRV0/VstbOJn/6kujMdE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8092.eurprd04.prod.outlook.com (2603:10a6:10:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 10 Jun
 2022 02:10:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.012; Fri, 10 Jun 2022
 02:10:17 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
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
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: remoteproc: imx_rproc: add
 fsl,startup-delay-ms
Thread-Topic: [PATCH 1/2] dt-bindings: remoteproc: imx_rproc: add
 fsl,startup-delay-ms
Thread-Index: AQHYe/0bVUqiw/9GdUieMD58uGUMs61HMdmAgAC0C4A=
Date:   Fri, 10 Jun 2022 02:10:17 +0000
Message-ID: <DU0PR04MB94170970CD52BACDAC9E3A6B88A69@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220609123500.3492475-1-peng.fan@oss.nxp.com>
 <20220609123500.3492475-2-peng.fan@oss.nxp.com>
 <20220609152347.GA3817946-robh@kernel.org>
In-Reply-To: <20220609152347.GA3817946-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de9b5cfb-4c7d-45c2-016c-08da4a865ced
x-ms-traffictypediagnostic: DB9PR04MB8092:EE_
x-microsoft-antispam-prvs: <DB9PR04MB8092DC253D2AB30F60465EC588A69@DB9PR04MB8092.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2B5Lcvz4TDA+xzAq41hMXtrGFwBGaP4RGnMV1Q7pRO0mJPvn3BujQGRaBAEbxkREAPHqLgjTmGJYPeZkEHWMul928NhNNMn01N122ldTU0f2wdhbuplIf52dET2DYdSUt+0LBQmwTBUjSj/J2MFBCQtdUWuMkqRCoBotLkqMa0PS44CNhuw4v9xQYy1ocDeaZV4oRWhgm+yh9fPQIvCD+YKn4wUgQ3JGaxaiXWCAn/6cP9UuivHrTeCc2fRGFsUIB80Ep3n6KvLgBizPfipt5Ie16xn7dX4gX5PAYVWKomUYNqQ9V+UMIa+9v9IaRFXH+ZmVfTUCNaJyPdFbbqDloztzpnpb0iSWhLN+8CX9ofPliyJSQfQ2XebxjPOE+FpoVksm75dIuEu4zncHiI6F2gN9xSfFVRVyuzSPQ1t0+HRHfR5ZbcI5b/vWQ4gSQrxAhntpw/DQWO4wXO4Skt19N5pIRwmb5T0gCIsUg8miRAsySCJr4QLXyMXWWALFCR4KYsrfWnj+9rYl2qwE+OpyK8oAMmQ7ltqVoVS5UJUVj9HXrrFJZky8f3nTUEMZXDDsABUWWOr7FV7V9lRAFLJVAz26EPtRclH8yFIOSgEI/faFNzckcD9ctTcVdI2mslcTsVvcWB6l+d13RgK6ecIfvSYtZhPr1uA33rnFGz30/cpj8DCGLTwgB2Xo7zXNoGjGkAe6GdEebHld5FnwGcYetylzsAxKKxSvkPji/WX/wZaeROYS25TBQsR+CPdbO8pNJVuF0enkWvGU/hOr1IgFpVA7o0UHmVz1wO4m7cyOeC8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(86362001)(8936002)(316002)(64756008)(54906003)(66476007)(66556008)(66946007)(66446008)(76116006)(6506007)(38100700002)(110136005)(33656002)(7696005)(8676002)(52536014)(4326008)(38070700005)(55016003)(71200400001)(186003)(122000001)(7416002)(44832011)(5660300002)(9686003)(508600001)(26005)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qi820v2JfGfc73it96zvw7wuNNay0SN3ZnyY0vLIwLGrJ9Gl4W261tA/IUnw?=
 =?us-ascii?Q?hDycV1+gxJ+HY4kBmCgDa2Hi3Vz7rIWoie637BtlZtA1SHp5B45c1f3uMV2p?=
 =?us-ascii?Q?hj8E/36KDETekTfEl7QnriGFXh4Zpcqx5j7UfUFaKE8iYZwQcD7feL4HPr8f?=
 =?us-ascii?Q?WozmXLxHQpPvO79b1g1/dmaJxah4kJSXsHWs7CAnjEoBQDOtOibU2sXOeIi5?=
 =?us-ascii?Q?u1qxniAQIhFuwJkoAXUZJq7zHlSCbFiN7GfRFw3ywohx8bnaqJo6WJygvQkE?=
 =?us-ascii?Q?4cMGLsrH5wPu9+YcSjbW4LtdfPU8NMQNy3qwPM6MOZ2ZrCG9gTFyYLFhsDGL?=
 =?us-ascii?Q?uzlwy9/fUDMdk4UPucmb47X6rBy7Ttoma/1ZHS/ZF49kZzbsn7nKezG3oAag?=
 =?us-ascii?Q?GJiU4Qin53VCVMljatuxtMlHSMZQ3rW2p2QfPnTDff9/yicdJqWAti0Iz15+?=
 =?us-ascii?Q?3FApdkr1hY/wI1B9PHPWnNE/t7kf2AMaX4vurnvHht+MbFb4GfeTJcvMusfW?=
 =?us-ascii?Q?C8D2jv5tVQiE2xBh/YmvCya5Ad2AV8uCRD7XWY2cuLB9cXPJH5w0ra47/V+M?=
 =?us-ascii?Q?C3W9XgY4UQ34OQBPrLyx/4JFt7DGxG3OqgvyYPAY6Gh4mnVbjm/KzN4A75j6?=
 =?us-ascii?Q?B0Vl5Fhb3mhjX6EwqihrqbJYIvTveA8UAN+PN1TQ9/ImMspwPKfmCXJIgG7T?=
 =?us-ascii?Q?ve1S6atOVM3N7vKFQcOXOnmGizslurc2eNy4SfCq5XDrq6iVLzcYP+kcAkXs?=
 =?us-ascii?Q?vxudcyt2XvriOCH43+8+Pv0cUzUnEkH8B0HAWIaYASLnjedFAkPSX8zTW64E?=
 =?us-ascii?Q?neknHGKmWusJ8HOqZ+TrGgnzBhOQ36Afi7sU6x+Y9Rd2TBZqM2S9l6gUJXiL?=
 =?us-ascii?Q?iR2WiV/72ub4AU+LwwLajdzBuMSsbcDyx6HLiX93z+GoaTAE8f9nvNHHg5bU?=
 =?us-ascii?Q?ruLUMQfeLQWfjAdzSjOoLDhUazykAaMahyergcq4pj8q9VcFBc2PjNGLYl6r?=
 =?us-ascii?Q?EyC3lzPEr2yKrOSfapMPiaSi8bygEVWcd1tkwhzV0WYQu5mZ4mr+gdLOBYuY?=
 =?us-ascii?Q?iec9SDNKjdCIk+qT5db/DTUacnwTqvg+oUMyhVSABwXdst6UeXyn23/okiS6?=
 =?us-ascii?Q?Blkh0sj8nNVQh6Zavzlco2QlVln/ic8X2YoX03Bki0RSdmwpAQt6utpb17Iw?=
 =?us-ascii?Q?f0iiZIio5HsKmTBPKIs9P0JiarCzPNCyqIZoS/LcSZrpgQA4FxN7Kl7fhvud?=
 =?us-ascii?Q?mNDlq2caNgjCGzlebiQ1wsyNBuAswdTKyAc7bGEdsAUL12NY6SQfmh3+sZyv?=
 =?us-ascii?Q?DBZTRtKw+hwFkjKcOsLFtFHspv3wL1CTsdOiwH2Pun7JWmo8ZDTJu516uaG3?=
 =?us-ascii?Q?v1NYCIPNEu5TBMDaqRbFnOAeN0AfNyO1HKICX0LaqWYatdosLQc44DANznAl?=
 =?us-ascii?Q?yQ/ZPp3WmZHui/2YWHQFjPS6L9d+yIDd94iyjf1+cXTfjQqrwIrONzaBuDHb?=
 =?us-ascii?Q?fSUwCOwS7jOPvP94cI0IGiPUU5VkhQfEmTvuvMtuYzrLiewDcFtIBwFTTHUp?=
 =?us-ascii?Q?liE7Rr/5nFDPb2F8Gm3TmCZ8wDVmD1+XjJ1yeKNvkWl8OY0s4fuI1qZIBXyR?=
 =?us-ascii?Q?gtbaph2ph5c9DNZj4Jfk+qx2FNkhuSCyyRYIR37Oz2KDuZmxuSPdT5r8BesI?=
 =?us-ascii?Q?4QunigdI0ZsDpIyB/ds6w3cP80AZGNNoBt6oU0SPrhVWr8xy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9b5cfb-4c7d-45c2-016c-08da4a865ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 02:10:17.1144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCHAlLYS9jforR1LM2KpN7J/DbGVCYk3sGXZJMOAPCk1lZ5KIyp4ATMqn+D1z8HkVD220kDxKZtrOG02NECsqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: imx_rproc: add
> fsl,startup-delay-ms
>=20
> On Thu, Jun 09, 2022 at 08:34:59PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > add fsl,startup-delay-ms property indicating delay some time after
> > just kicks remote processor.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml         | 4 ++++
> >  1 file changed, 4 insertions(+)
>=20
> What's the base? Doesn't apply to v5.19-rc1 for me.

Sorry, I missed to mention that this patchset is based on the patchset
which support i.MX8QM/QXP:

https://patchwork.kernel.org/project/linux-remoteproc/cover/
20220517064937.4033441-1-peng.fan@oss.nxp.com/

>=20
> >
> > diff --git
> > a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> > b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> > index 64e783234e38..56f3ed18c28c 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> > @@ -76,6 +76,10 @@ properties:
> >        This property is to specify the resource id of the remote proces=
sor in
> SoC
> >        which supports SCFW
> >
> > +  fsl,startup-delay-ms:
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
>=20
> Standard unit types don't need a type. 'make dt_binding_check' should hav=
e
> told you this.
>=20
> > +    description: Startup time that remote processor ready for
> > + communication
> > +
> >  required:
> >    - compatible
> >
> > --
> > 2.25.1
> >
> >
