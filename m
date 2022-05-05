Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49F851BA71
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349168AbiEEIdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348978AbiEEIdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:33:01 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50047.outbound.protection.outlook.com [40.107.5.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF603340E9;
        Thu,  5 May 2022 01:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBBx85/unKi38++2kCd9qNDNr4JigIVFgBcIO7CLoNx2xqWVh7U6bkJ2BI8x7PsmtfRVhrbyYkhBoaSbpn72iyLs3dn5CeKOLyRXL4aLSgtRtPTyrpX+xUcjYaUHnyApPvN40vzciAFlf3hu+BOQoatWNJ9zm+uXl+9vYEsaaTUKRb5ctYmOgoXa3Hjsv5A6iyPCgSBl9YHSwpiowStOO/qEK5+ukt0TP/6Zo09KgrY9uvUQD+reEW0XCW+JBGNPkt1CbvpYUXMoFHp64nrSW5/3IKPraN8TWcxC5gQ8lnMaJ2f5LhOXa1/ylDjD/uBa8HB0dVadGg423fkAymaZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wB+LHolwlkwToOfivH2cVV5G3mxjc0Shf1qMJ8X6l+o=;
 b=TxcwfVeP5ZSvM3KCYkf3BsknBkY9HpFNN2tDj5pLOTPKDOWy1j7KYVfSXOME8I15UeNg7YyYJOBZmfCf0oBzwxLYwxJ60L5ZUCxVGU8zBxr0AOfrNFz2E8eWjA520Bt61JjkNaVUt2AsW3U0QtROxq8EtvPkPxT49/4ep4+23nRkos7zwOVsjnSDmBxEMFJohAJnXywz3kzQvGdLDs1Si+LpVsK74+JI3UCFNCzzIx7yHTYAng7wckplZafxvJ/hBhRvUiXNAGq+N8IC/GNEJPt1aZM12lDpjRh0pAy15CwWpgv5/Abjmc22CKETxQlaB8r2pF1yCVjzLZwMft3Dfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wB+LHolwlkwToOfivH2cVV5G3mxjc0Shf1qMJ8X6l+o=;
 b=QkYikDQxltmMtqWUl9O8jizRfoCsn0QZF3tOHWZSE6KeJPxo6JDi/4y/aWLASESKb98mfAGqZG+dM19a6+W+/ie1noB8CtmxR2fxP7LvmRtk2A8qeStSFwDRNOxaTYcvEwmMsqpREJXHcwj6OKh9vMqjYng+4XcnEa8d8Zfj0BU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6982.eurprd04.prod.outlook.com (2603:10a6:20b:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Thu, 5 May
 2022 08:29:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 08:29:18 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2 0/3] arm64: add i.MX93 support
Thread-Topic: [PATCH V2 0/3] arm64: add i.MX93 support
Thread-Index: AQHYXulHF+y34Ra6sk+O6vv1l7ZMaK0P9baAgAAAvkA=
Date:   Thu, 5 May 2022 08:29:18 +0000
Message-ID: <DU0PR04MB94173D505B2428714FD0968588C29@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220503122951.4147636-1-peng.fan@oss.nxp.com>
 <20220505082607.GE14615@dragon>
In-Reply-To: <20220505082607.GE14615@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6eed2b70-d461-4813-f633-08da2e7158f4
x-ms-traffictypediagnostic: AM7PR04MB6982:EE_
x-microsoft-antispam-prvs: <AM7PR04MB69826ABF642B2C32FDC8619188C29@AM7PR04MB6982.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 61dO/g506lFUmdDIfjsyNWEM9PKxn+YAV1dxCDDDxo0kgwNIyYNsaLvoMY8K6RA3i5rUs+7v7isRXBXPBkzg+NY9NKKQV9qPuboH9a6vcY/XFvkEWjlG/n8dJofXiqATvlODq3FskzVY199jF522j+DjYQQ5bSY2j5nItaAelJod8i/eglEvGnDSxuQatgWU+c37mUbGwqY+Ac95WxmINEX2ON1IdYBa4QsL1/DZW9Zi6kh0u/tVofS+1XMtdEuJA86g9imMkNpXgHMaCGNQv6eHmrkrr/DTYWbXXRMQ8dWPln4aTpBUy0CJOSEK8ORXDTd4V5tWaCON5Mw14Fy8iLGwc3Tk5kdW6pg6z3uOL0QV23kPuSh4Qv6g6qv5CNmO1k0Z1ll+FsgWL/S3+XmKUnXaKtPic/TAoirinfMTwP8wTxXdUjPpFy7U0s0uxYe5VTD56yCBCfSNzKPQhFL7GSqQxugYLlNZSGCbSv5RbdbOFSditj7skS1UQ6D7PtY/2WGw326G/qjjRinSID1xlamOj/iTh/AQbESu1qhbqVXd7A4xjwXjrU8L+5IkmnSkAR2sB3y+xY6ezwAeeYylCYhXW+sUpAfQU0jM7oijtrEt+MCHOUQDMK+/PFuTTDJsx62T/lEYslOWWqBrWl3dO+CLPQWlYlLgUZ4nOleVSRqsg7dQxsm6eV5Jb35fEakfYM5SeAFVODluYBK86oIwQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(86362001)(5660300002)(122000001)(38100700002)(54906003)(71200400001)(110136005)(7696005)(186003)(55016003)(44832011)(316002)(66476007)(33656002)(66946007)(2906002)(83380400001)(6506007)(76116006)(8676002)(4326008)(66556008)(8936002)(38070700005)(52536014)(66446008)(64756008)(26005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nveXB/zj+RC4wNpYcnQd522S4QNsraFyrUq3Od6qajPFgyAhmLv6zg8cD6Vz?=
 =?us-ascii?Q?1M4li68fueFHuNSffFNwzK44nLINgIb/hHitSSEAveRuW8yXXbFYOsm6IFaT?=
 =?us-ascii?Q?vDjyd3CKHZ9Z4VwHiupWadNESuxdrmPQfDV61FlAYVV71/0rA7FEIunOVjGv?=
 =?us-ascii?Q?KJbXjTyCTWI+E9JFOcsfLuXW3ntHRPwOPUTC3Iq94ix+qB721pesbP9XFQ51?=
 =?us-ascii?Q?6RHNvRP2OFR7Jcvtmc5HDwN/TrRs7y0yrzJ2wH2XIrt9UyEO1FHG0hnuAzhc?=
 =?us-ascii?Q?N5s6uqksEh71tbbZU57NdHYvS4lZKOwr4x02F2bXLRmqqEHW9Dl0ubZprHgo?=
 =?us-ascii?Q?O3OCMue2ztzxes0APnxhkRIqDtKQOUk6QWadAYO/wYYKvc+XKLm442XbkCfY?=
 =?us-ascii?Q?iL4R33e0p2SVbSbB7G2K4FZbu53uikgEdR88wGu569++wJAE+lS8Mc2wF59H?=
 =?us-ascii?Q?oTg6uwrdiUfS+OwKpcSZ7opv8JJH2kWWYLu09asYBsl4H7cRCzBH7s9V6BFl?=
 =?us-ascii?Q?jkb8SFICm8Gz8RBlUV2o+qHPDF0YWMPWRjN6FPNzg1bvI9VSeiwXhncPD4Ox?=
 =?us-ascii?Q?18m/AHg8SaQQmmH11wInX3HP9HhpXRtQC+CJeppOXkidrY1KdvStcXOlx8X+?=
 =?us-ascii?Q?YGXG1HyLxZ1PVb+iEQwP7GHsfhKhVqFVltmZ04i/maPP51HTJHpxq38n87CZ?=
 =?us-ascii?Q?sxTYYde/GTYGC3NsPM4W6NNvSbvfhBIE1MY4VjjLfRDen/hhgzCIKROYGon+?=
 =?us-ascii?Q?MSWoMXrevCCYkMqk1y2/F5Sp2NsgaxYU3IKL3mpL4xwsU2HJ+4yUh0p2jIo9?=
 =?us-ascii?Q?kwowvgE4rx6Z5f6V9OFxIMD5VyfHQeajV7I1qY7EAZcnzCf5ZEFuWQsKYZXV?=
 =?us-ascii?Q?uV3va5zu0F0apQ9C/MYKoAiZVL9npoFh+8HXAdXinzA5mXVOOuZDOWXibZ4G?=
 =?us-ascii?Q?DWZ8r0hvcS5T4ADJakoY84kYNTu+3IU/nnLWvL+Vb4iolzuWMISnujwoGMIz?=
 =?us-ascii?Q?SEF8tkgsXVAJOLDS4LE2AYG2XhqHKzmho4rdarbB7e4n5VAk9JKeAuW9zsrT?=
 =?us-ascii?Q?iRWSVeW6qBg2Okb3nE5TfzbF9kuDrLaa3YznRy+65eiHqy7uL9oFcmvUwVrO?=
 =?us-ascii?Q?f0TYab5SDxlSQpsmNosGExS3wQW4Sj8DntGuxotwuHwyn1bbyql5cunIJZEK?=
 =?us-ascii?Q?1MmoTfrO67VUjSnzW81S0d9LoHsyO3EA6TqaIy9srFJDMm5SVAte6uppM0gE?=
 =?us-ascii?Q?lk6iGZxQQdWLqLEBjW0zj6kEOwH/YsHvU1YpSPWmoh0BJz+AoHCFJWZvOKFl?=
 =?us-ascii?Q?HpGwzWJXrUC2gO2PEodo4JAX74JvhZYdN7daLE8+BQWK5/4QsGFHRizLqp+X?=
 =?us-ascii?Q?PeV/0OVprUnhniibg5BkGb/AO75q2ltJq89tHd+zs5ofg4ifIpW8omOd+UEp?=
 =?us-ascii?Q?8rYi8c2M4wTjgH9uFiZcIgdw697BTNbW/5Nan1Oop07IKh9LUHXKErOyGxNm?=
 =?us-ascii?Q?m0cNZe+YcpVZwKHpSnYiJxdyaL2Yh9mx5D/ozLQnV4RL0SHWt19owqcyOWz6?=
 =?us-ascii?Q?zNpr/qKwBTTwD1xqo6D/cDjI++nMjjqbFXd1wjduev1B14NwVXhHBUZ3ncBc?=
 =?us-ascii?Q?q302Dchlqyl5RyYrxwAVO/77Z8Svg4qg0vNh6fS7ZE0Wa2QMjeh9ISELkaG/?=
 =?us-ascii?Q?fuX3H2FRKD+hMZRwziHYe//Vsd+ROR1ThntiGZzTrmiJBvxYnuqnYlKA2HKl?=
 =?us-ascii?Q?AYYLNWuMCg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eed2b70-d461-4813-f633-08da2e7158f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 08:29:18.4664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: asOwwDXA2utobpbJ1p6mfMYqw/J9oReP9eMOvXr/uoV2/d9OGjNMnO9hRMMrQrHUOGOmmGbVO5SrodbX2DErxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn,

> Subject: Re: [PATCH V2 0/3] arm64: add i.MX93 support
>=20
> Hi Peng,
>=20
> On Tue, May 03, 2022 at 08:29:48PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> >
> > V2:
> >  Update License
> >
> > Add i.MX93 dtsi and 11x11 evk board support
> >
> > The required bindings and drivers has already been in tree.
> > There arem checkpatch error for the pin header files as other i.MX pin
> > pin header files.
> >
> > Peng Fan (3):
> >   arm64: dts: freescale: Add i.MX93 dtsi support
> >   arm64: dts: freescale: add i.MX93 11x11 EVK basic support
> >   arm64: defconfig: enable i.MX93 clk & pinctrl
>=20
> Could you check if we can eliminate some (if not all) of the dtbs_check i=
ssues
> below?

Sorry for this. Will fix in v3.

Thanks,
Peng.

>=20
> Shawn
>=20
>=20
>   DTC     arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb
>   CHECK   arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: /: 'compatible' is a
> required property
> 	From schema: .local/lib/python3.8/site-
> packages/dtschema/schemas/root-node.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: /: 'model' is a requir=
ed
> property
> 	From schema: .local/lib/python3.8/site-
> packages/dtschema/schemas/root-node.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@44380000:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> 	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuar=
t',
> 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,im=
xrt1050-
> lpuart']
> 	'fsl,imx8ulp-lpuart' was expected
> 	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpua=
rt']
> 	'fsl,imx8qxp-lpuart' was expected
> 	From schema:
> repos/korg/imx/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@44000000/serial@44380000: failed to match any schema with
> compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@44390000:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> 	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuar=
t',
> 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,im=
xrt1050-
> lpuart']
> 	'fsl,imx8ulp-lpuart' was expected
> 	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpua=
rt']
> 	'fsl,imx8qxp-lpuart' was expected
> 	From schema:
> repos/korg/imx/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@44000000/serial@44390000: failed to match any schema with
> compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: pinctrl@443c0000:
> 'pinctrl-0' is a dependency of 'pinctrl-names'
> 	From schema: .local/lib/python3.8/site-
> packages/dtschema/schemas/pinctrl/pinctrl-consumer.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@44000000/anatop@44480000: failed to match any schema with
> compatible: ['fsl,imx93-anatop', 'syscon']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@42570000:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> 	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuar=
t',
> 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,im=
xrt1050-
> lpuart']
> 	'fsl,imx8ulp-lpuart' was expected
> 	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpua=
rt']
> 	'fsl,imx8qxp-lpuart' was expected
> 	From schema: Documentation/devicetree/bindings/serial/fsl-
> lpuart.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@42000000/serial@42570000: failed to match any schema with
> compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@42580000:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> 	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuar=
t',
> 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,im=
xrt1050-
> lpuart']
> 	'fsl,imx8ulp-lpuart' was expected
> 	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpua=
rt']
> 	'fsl,imx8qxp-lpuart' was expected
> 	From schema: Documentation/devicetree/bindings/serial/fsl-
> lpuart.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@42000000/serial@42580000: failed to match any schema with
> compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@42590000:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> 	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuar=
t',
> 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,im=
xrt1050-
> lpuart']
> 	'fsl,imx8ulp-lpuart' was expected
> 	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpua=
rt']
> 	'fsl,imx8qxp-lpuart' was expected
> 	From schema: Documentation/devicetree/bindings/serial/fsl-
> lpuart.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@42000000/serial@42590000: failed to match any schema with
> compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@425a0000:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> 	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuar=
t',
> 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,im=
xrt1050-
> lpuart']
> 	'fsl,imx8ulp-lpuart' was expected
> 	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpua=
rt']
> 	'fsl,imx8qxp-lpuart' was expected
> 	From schema: Documentation/devicetree/bindings/serial/fsl-
> lpuart.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@42000000/serial@425a0000: failed to match any schema with
> compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@42690000:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> 	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuar=
t',
> 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,im=
xrt1050-
> lpuart']
> 	'fsl,imx8ulp-lpuart' was expected
> 	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpua=
rt']
> 	'fsl,imx8qxp-lpuart' was expected
> 	From schema: Documentation/devicetree/bindings/serial/fsl-
> lpuart.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@42000000/serial@42690000: failed to match any schema with
> compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@426a0000:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> 	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuar=
t',
> 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,im=
xrt1050-
> lpuart']
> 	'fsl,imx8ulp-lpuart' was expected
> 	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpua=
rt']
> 	'fsl,imx8qxp-lpuart' was expected
> 	From schema: Documentation/devicetree/bindings/serial/fsl-
> lpuart.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@42000000/serial@426a0000: failed to match any schema with
> compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: gpio@43810000:
> interrupts: [[0, 57, 4], [0, 58, 4]] is too long
> 	From schema: Documentation/devicetree/bindings/gpio/gpio-
> vf610.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: gpio@43820000:
> interrupts: [[0, 59, 4], [0, 60, 4]] is too long
> 	From schema: Documentation/devicetree/bindings/gpio/gpio-
> vf610.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: gpio@43830000:
> interrupts: [[0, 189, 4], [0, 190, 4]] is too long
> 	From schema: Documentation/devicetree/bindings/gpio/gpio-
> vf610.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: gpio@47400000:
> interrupts: [[0, 10, 4], [0, 11, 4]] is too long
> 	From schema: Documentation/devicetree/bindings/gpio/gpio-
> vf610.yaml
