Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54DB46D45A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhLHNZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:25:46 -0500
Received: from mail-am6eur05on2079.outbound.protection.outlook.com ([40.107.22.79]:25440
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231373AbhLHNZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:25:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQ/l5ijuqNNZLK4vufTmTvP9yIoq9ekK+Mm1z3hxg2mG5o7FovMSzfip9y+PFXUb80fCOPGeeAhS6L39QdbgOqdoufdyGdcjGlJ3VWRr4p4/v8UqM1zL8TAoTSJj4MLenu690QqZ2KeZ89Qv98sOLGK51mhTWF2keouOurEufXfozlZ9pErVgBv57iEBOhMi/VAtZdY10n6LD91fdDS86P7W/GdMwIGGGuJD3CQD7DDIfDvEMQ3mn1JM52wN129Sq8KJrWY9ifVCRbw++UKQQMdBwBMcRZUzX+lsP8Wv/QCshULks+oXaEg0Gl4a6Rog6zge+8istbTb6ChqHIUW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkPuIQhep/6rUC8AinATdZYJoBow/loK3qi1yraQVnU=;
 b=bt5BNB3Otpz415/s0AmkAFUlNAL4vmClRJMm3dlZHVlGYtHVEzcjYTO2EQlUdvBD7/NDAL7Nwq1u6KKzmSWh9aJEEQVaoXl6rYuxundb901YTbFLgpqTMtryS5xnF1hZVfyZsuyz2h9fOdsLlIDzkwcybp4txUJy4ZyhbyG6C4t2vE80JNGrPLpowKukoHUoYJnYt9NNKIQwUXZGwwjnZIJn74LPnjpamNRGJAsAeW1kw0VROkbLUbwgTTOJUFhL3jxxm4tsNYpsoT/XfhugDpLjtXJXdvd0NhXnuTWvKFsL5GIRngeEeGQbTw+XVAAf1hbfsqf+wRzSgGdFtoVT/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkPuIQhep/6rUC8AinATdZYJoBow/loK3qi1yraQVnU=;
 b=VAcS595a9Htw4jHw69vZzcgar9lCOlJ2xGlfemYZ+sqlWPL1JMfdnP2BUs94YYECuszhqMe6pUctoxX/sU44bjfhlhphkNVXdXDaSlmVWUflCeKeLOJATycxboXAWWcwe/61U+5tPbENu8VUA4mUlGntQABmUsL4hQAXAp8rcWg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 13:22:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Wed, 8 Dec 2021
 13:22:05 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] arm64: dts: imx8ulp: add scmi firmware node
Thread-Topic: [PATCH 2/3] arm64: dts: imx8ulp: add scmi firmware node
Thread-Index: AQHX22M3wqoeGEsc2kKun9YdpXFw4qwookUAgAATN0A=
Date:   Wed, 8 Dec 2021 13:22:05 +0000
Message-ID: <DU0PR04MB94179D73EA3E9585D76F2DAB886F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20211117032740.2518926-1-peng.fan@oss.nxp.com>
 <20211117032740.2518926-3-peng.fan@oss.nxp.com>
 <20211208121000.GG4216@dragon>
In-Reply-To: <20211208121000.GG4216@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f25bb869-423a-4b0b-fa5d-08d9ba4dbad0
x-ms-traffictypediagnostic: DU0PR04MB9372:EE_
x-microsoft-antispam-prvs: <DU0PR04MB93727AC14A1D4DFB9F144A22886F9@DU0PR04MB9372.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kVBTnBpM+2x7OhkI8AQVgo5+AyPRHAAM/8/gwFUnUPHN987469WyxnC0XoJcNxXo0XXTfPt/QUjWOQ14SOcYm15hE9+6fP3zBMZYq6YIjnsKAikEc8TSuTJlBHKZ8oDmCuqncE3qWHHj4lLc13bsUUSyPOMlRCzMF6KK5hWhMcrWHy2LrN3CbNaMKwCrCjKJaBpj5Hp5mRp+9SydGCIRsQMCrFNOsjfRzbhbggMBROGwUUu/863L3lLveq22E8aPUOt3H31+ELuVsroCOWypLHWXic1y7XdbfQeddGHLCTUoClUGkE606AwuphrIWUovGwz2rxB4x5gQcAMMUugMOi5OM2I43ZZ1u8PVIMq1HN0KurnZz90dBrIBeThWloWEErHJ2PWSDOLh6GLyiNBRvf4kTkrDk5z+ElICmySoVhQ89TXWPySWBbObb+/iOYkB4t2zXqsbaIvbVXRdd15nH3yN5RtLBRFlm9RBIqwd38Y9pqSIKtgeiD/5o4NR4D0gxaJJiKGhEg6WwC3JAnhtbT0Gkc9kQ3Hd2tys4qI1kCJoA+BZObraASvOpczl1KQaShe7iadnNI2aU/9tXjLXQTXiZ7EIvfsB2jeTuHgqBx4KcfkINlTCTQhdHWzX7M3etMD7U3aYJRqRyw3N6diy/ExnmnI9dEQv0ovXMbhcKYxCGmMBx/bNwjTKywXOyhmyoDf8B7DbzFUwGmLNYqkHcPOSvYskABmGALSEzkkSYgY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(55016003)(83380400001)(6506007)(5660300002)(2906002)(8936002)(186003)(7696005)(508600001)(38070700005)(110136005)(38100700002)(122000001)(26005)(66476007)(316002)(54906003)(66556008)(33656002)(76116006)(66946007)(86362001)(4326008)(52536014)(9686003)(71200400001)(44832011)(66446008)(64756008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3RfJVva76Z+3NDhJ0PlzSBQvzvFALkQm6wPOqzC2FszxQRkrILA2TpA7+yaf?=
 =?us-ascii?Q?FEA61hjCwrjAigciAOJkJm2fh8/s1XI8jpEXUeiBmVuK2/tY/raThcxcZDYK?=
 =?us-ascii?Q?FLpWgh+8QpBAfaEsO9zhPA3WAauQuUnUsh26h1y+wGa9akBbPQsGRkqIXFHQ?=
 =?us-ascii?Q?iD3A5VYjoHhhNR3zLkSmJNJviTdebdqSLOA7/78r/tXe0RC7brC5c1xgAm6o?=
 =?us-ascii?Q?8bxM7ZBg85M0QZfqVrIqTeo+SqP/5033H9SribwQK+ykXVqaa/WqnsO/SRMQ?=
 =?us-ascii?Q?1FTIuaXdmC+UAjpv9hJACLLdDhtXdmGzCQGp30iB7nHhDne0H5NmBRrgDkFZ?=
 =?us-ascii?Q?jwv6+PjcmI+iduBG78ClXa2C8uEql5KIalcLYGxUodBe9hMEn92/pDC96Tej?=
 =?us-ascii?Q?AiO9gvYgV6fj1/+9T5VcA8cUePu8vu6ATWwiCSS1sJ1sy3Hvu4Uz4tUZQUpZ?=
 =?us-ascii?Q?I0CKNbjx3/xUqyygTPKgQib9WMtUvb1cA2ICksgY+vsjA+ow3+Tcj/sMGykg?=
 =?us-ascii?Q?8PNX3LN+YH4QClcVxqi0P49YtmqL6U9o/tZ7CwS4XD+WgOwKWlphxM50ZPq7?=
 =?us-ascii?Q?mwi7kM/qTk4p6H1JfJSeOPsZdFhWE7zxLLv/SYG08NFV1c+dHcOdyE3eN0Nt?=
 =?us-ascii?Q?rHxum1g4l6XbWdS2foOwjVBKwwV6cvWHH/AaakqpBjGdMbipk/4T/58mjseN?=
 =?us-ascii?Q?wrDnUqzvLtJsLhEOyc2Ydz1F3qeBGhUtbz7rRcS2Sm1LXzNpkyQX8TNVXCtp?=
 =?us-ascii?Q?zLubW73X1gwcvLS4ALeoKW8DaUB5lZ4ORAeyvKN6Aws6aQlNdoJS3QP66D2f?=
 =?us-ascii?Q?jc6hTzHA6Zi0d8Gmz2wP9h8FdI6gplL5dI2IH+qeJUyFDenIba65FiDleawx?=
 =?us-ascii?Q?IcQDkhzk5OzAo9pkNQIK1x1PxE+g4W+m60gEJXKf658qSVPRryTPgztLDlS/?=
 =?us-ascii?Q?9JGk5bfvryTJLJ+N9DIC9tcWAyt24IvtrEImizIlCSB5Fmc9tcuXhEx6RNmZ?=
 =?us-ascii?Q?+HevuNAq8YX2LwAlgJ+RONenmSaflSPRwej7lX+o3utDDMHSGtjGlBcyBk14?=
 =?us-ascii?Q?sVrXQOB8gQR0bi1NKzP5mWeho6ggBTrNH6tugSmTuBuT+E2EHyqbMsYZ5qDT?=
 =?us-ascii?Q?y8ltGxWR2QhhgID7fBudxWMlnV7Hn9TO7PV+iAtj+MAV4VeO6xlfkouGCvCG?=
 =?us-ascii?Q?OruGlulR9ceorHJaQAMMNYr09uWfvnNBiccl7H7fvnznYcs+WogGKaMX9RuD?=
 =?us-ascii?Q?xRTts+Hwbp/TuZuTy/NPjfXAOf8NyrLhXDXCGiKSr4MFY7JtDTETzk2GOlX4?=
 =?us-ascii?Q?ZjqTwya+LO9GCwP/BN4Kq6CxvjZFaGexhhN8qqYxDQnqxvsZJ/siGsZR+UW/?=
 =?us-ascii?Q?D2R+6KPIFaxSWDljywoL8tBx6bx8Whacmrra495bn6qg/bOP1f/WYsgSbkX7?=
 =?us-ascii?Q?oByq/PwDxuILa/A3TvNVe8uYmoHc7uTxqgjIUFQBKX02w+4LStEp+SWAzISu?=
 =?us-ascii?Q?kTyMd/39e4WB3XDiDK3rp9cdb7FRcLt9IRrtwPxqvIhXaArvWLD7W2hb5f9g?=
 =?us-ascii?Q?bd/KHigDLAQ8XJFg5qeFmq2dDn3B7ogGFLR4mlUyBdRD8vDuRgLJYHKUn1mv?=
 =?us-ascii?Q?Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25bb869-423a-4b0b-fa5d-08d9ba4dbad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 13:22:05.7956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lP5/E/2tTD2xKZbDMFJO4KcjlnJFwjNU8t4KjUjF6uYMLtceBkxNINkO2EPoAUC1LnFjHrOHOl3uXPhNYkxagA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9372
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: Re: [PATCH 2/3] arm64: dts: imx8ulp: add scmi firmware node
>=20
> On Wed, Nov 17, 2021 at 11:27:39AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8ULP use scmi firmware based power domain and sensor support.
> > So add the firmware node and the sram it uses.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 35
> > ++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > index fb8714379026..d567ef93f8d8 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > @@ -6,6 +6,7 @@
> >  #include <dt-bindings/clock/imx8ulp-clock.h>
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/power/imx8ulp-power.h>
> >
> >  #include "imx8ulp-pinfunc.h"
> >
> > @@ -102,6 +103,40 @@ sosc: clock-sosc {
> >  		#clock-cells =3D <0>;
> >  	};
> >
> > +	sram@2201f000 {
> > +		compatible =3D "mmio-sram";
> > +		reg =3D <0x0 0x2201f000 0x0 0x1000>;
> > +
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		ranges =3D <0 0x0 0x2201f000 0x1000>;
> > +
> > +		scmi_buf: scmi_buf@0 {
>=20
> Hyphen is more recommended than underscore for node name. =20

Just send out v2 to address this issue.

Or just
> follow the naming in arm,scmi.yaml example?

No need to follow its name there, it support many protocols
and need different shmem for performance and others.

Thanks,
Peng.


>=20
> Shawn
>=20
> > +			compatible =3D "arm,scmi-shmem";
> > +			reg =3D <0x0 0x400>;
> > +		};
> > +	};
> > +
> > +	firmware {
> > +		scmi {
> > +			compatible =3D "arm,scmi-smc";
> > +			arm,smc-id =3D <0xc20000fe>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			shmem =3D <&scmi_buf>;
> > +
> > +			scmi_devpd: protocol@11 {
> > +				reg =3D <0x11>;
> > +				#power-domain-cells =3D <1>;
> > +			};
> > +
> > +			scmi_sensor: protocol@15 {
> > +				reg =3D <0x15>;
> > +				#thermal-sensor-cells =3D <0>;
> > +			};
> > +		};
> > +	};
> > +
> >  	soc@0 {
> >  		compatible =3D "simple-bus";
> >  		#address-cells =3D <1>;
> > --
> > 2.25.1
> >
