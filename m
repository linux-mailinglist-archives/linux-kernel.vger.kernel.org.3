Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3465AC923
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbiIEDcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiIEDcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:32:14 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BB72E9D5;
        Sun,  4 Sep 2022 20:32:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpK7ewZoOBf/1Bpz83vMB2kGr46mE+2ycKJwPyqfcvtjs0MYsk9CjMZfDhmBPuQXGmS9QMEHC2qJvZyjV6oiUeWNtu8n7+39UMjoGE7cFqnDtUo5G1P3ZRjUuD3+1UR+p+cqJOIJngmAJie2RqIJOM47DSChi7yfVlVgTLCRyReNG/8dAKXcnsdlT34/y+w7tF8cpkFrLhnfM4tjnHae5zpERS9QF4vhCbCbGKLCHWs1LHnQCJRV5Ll813MRDIrh7W2gE/1X5Awyv8zswKSz/FjG4UE6kcGtst2vnwl7jJu9LnO6K/IqgnyfzcxkAIh3tVFvdgIyaTC26Nv9hxuzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZO+dQ5SG7W64ahXB/cc5fA2rlRqgiKHOXCPBORiQRQ=;
 b=Owa+18BaXmskPKA9SzcC0bE0I9bBgRrnXcXbgInuWIh5weJXHn0yOvQFoKYB2DjE8bQd7xm2v8t+W3rZYw6u85i2xPjokYaKlh35EaUgu1INOPXHDBYZYXX+oGf1YWDfPDHSB7+NZkkhh+KN89Um7AvQvjDC3ASrZ9vZoNNvK07VXH4JBn1gCV0g/IJcHc6oRy0/nCq9U5WHKjSp7QbZnh25rckMFxnMSMCcnajVgBVdFtQGl1/UdAqIjKKzjen0PkgR9NGXNaSg6A1jjJK8ZCwfbzz8d/VzSrSnk9tJ1Dn4lpI6tg5iYoEzFwRR8g9S+Oyg+Z6g7tCvNac+v/MHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZO+dQ5SG7W64ahXB/cc5fA2rlRqgiKHOXCPBORiQRQ=;
 b=cZ4L9BEylZS9Ufe5gYywTqtqiPiUrexwMjrJOyAkBLZ0zMUV+SFBSNSzqSFEB34KYJ1swfFtq2qdM2k0Ft7vhHC3YLE8j9RR4xYFJ/SdZPse4xYgEyUexoGMpl+m3XYINg7vn7PA0NCwrHZAJQjcTcx0fFqCVQxjbfeJ0skhVVI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8231.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 03:32:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 03:32:11 +0000
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
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 2/6] arm64: dts: imx8ulp: correct the scmi sram node
 name
Thread-Topic: [PATCH V2 2/6] arm64: dts: imx8ulp: correct the scmi sram node
 name
Thread-Index: AQHYvUVerEhdkxZ7J0KD2PXOmnmPpq3QMmaAgAAChjA=
Date:   Mon, 5 Sep 2022 03:32:11 +0000
Message-ID: <DU0PR04MB9417B82900060E9BA6B2BAC3887F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220831142552.43393-1-peng.fan@oss.nxp.com>
 <20220831142552.43393-3-peng.fan@oss.nxp.com>
 <20220905032039.GG1728671@dragon>
In-Reply-To: <20220905032039.GG1728671@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0613fc39-bb95-43a7-36f8-08da8eef37e6
x-ms-traffictypediagnostic: AS8PR04MB8231:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nkpFqebwxccCpFS/MBaeF9tNOxR05O+IWXpIqBhKWtmL4HFlO2IYyEshig5SeBp2QxKs8Vd1rgA8qT5UMnq7uVKTseZoL/HY7A0CyVdodPED0UgJwhOHqsXf4CK1/KQpp2wCb9KVTFXx11kO06quX9FVzMt1hRuuX1mvmP/NrO/XENLJufBPwMIQVUbSx8nmMvwhqYNAmxnMtTms1S73XhQQeon91tinaKLbpTBNchXCYZlPstB/q8hpbiv4T5n9UEKEqbgaCefKpFueqWpDlPivcmOGWSNryNV02XhAax3TcHAh1d0tmcUKSk4eqrAl+mNzcOWwI54VNqmBCyX2edrFqyqXwLF/AMf15Ntp1xTJplthcPbXxh6zhs/+BUN+I1LJh94tvoOIGfkevowHdB9TeZ8SUUGrncCc7VvkNGqhM7UnNc3wRHk31Bbv31SWiymfNyHBXvuvvs59cYeNYUAvtodBsoWI0iHC8sbwp1qzRvTrTQYtNzCZwkrcBL916T0Axjmitf/WveF13APCclLJebqMMZbNrM5RX/YnkHsdk9a5ylUiC8FLFk4xFEa0MmUeV2ewDhSU8j+nLRHXURH0sDHKTeL0u0uQ1/Lq6DytUkuzNtPHgwCvTw637MdZkWRGI9js7U5XZ4Sir0GyntP78EUcvcxaA6+7TNGDD0sLY/7zsONq827Ean/RSgWo957ZDKyBpUWIkSboVvBhWaqjoJ9tLn8WkuNiBsqr5Cv4EzugTVA0o1uf2tVczbQ7IvzaoouehCJFKhqJ/g8Aui+BlOGl9RHZwu2Pk6ucfNI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(71200400001)(26005)(9686003)(41300700001)(478600001)(6506007)(7696005)(83380400001)(186003)(2906002)(52536014)(8936002)(5660300002)(316002)(44832011)(55016003)(110136005)(54906003)(66476007)(66556008)(4326008)(8676002)(76116006)(64756008)(66946007)(33656002)(86362001)(38070700005)(122000001)(38100700002)(66446008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ta/JafxF1fIXLWs1HoqZXUifGlINWI8huWoyag5XkYKUBEFKDyaJJNaugxsk?=
 =?us-ascii?Q?jQH+jPdqh+vfYOpzvab0TPpdqD1EnU/x1mya1f3yGc7lx1dhQwwuJeBPYZEg?=
 =?us-ascii?Q?RHmQMrmN/jolCgZcHACO9YTSEBpOSG2GvF18f93WPVnR+HXVuNW3peQVerWk?=
 =?us-ascii?Q?8swoaFzCDiHvl5aDJXjFhmpjCJD76z7JNp86ewsqA/+DKVKHJl0L5wAwrwko?=
 =?us-ascii?Q?X5M/QfV9Ovbl6uB1HrTw3cqzecKkOwE7SPxN7nwkMx0Sy31diTjz5MXU6stp?=
 =?us-ascii?Q?vPn7feaCYdWtyatQdIv2WNOrRHniLA5zo6yWNRB6LTzGDFKvlKlRtJocCWzN?=
 =?us-ascii?Q?dbWjvc93X0dxJH0G+LWRGVviphGMSoWJm965ci4yiqL2tl76lDbISaIH06FA?=
 =?us-ascii?Q?yaezbyOilbMoTNJBxBecczRoi0PPa1D1HXXhssx7l22JIwKazE3KE+Oc65yP?=
 =?us-ascii?Q?yPTaitT4zpkTMDYogKZFrx92aMgfx09ioLuct92UYid/Biuad+gclxRK1wzy?=
 =?us-ascii?Q?rQecYeSzx8A1yVGtJQL0Dz5UEUMpKv6UGzgU4hU0eHInNIpEn8U9Ee5SVJXU?=
 =?us-ascii?Q?bMmQYswD8tUTwMH5aX/5ta+H2RIunM0vI6WXZSpp9g/MgySByCXUIYceN8dD?=
 =?us-ascii?Q?O5FTeaDfZGD1dvrqTZHjqoIRhQc41MapWqzaD9nKRH+/VLfdb6JJ7lseL/z9?=
 =?us-ascii?Q?di7snvrMyZCIxvxQsWf2rgvHhlWdbEpCquw/oYHVwNoNyX3an0W5DSYxKbfz?=
 =?us-ascii?Q?QDLzdxTRB27VUVl2Voj5+VeyOTFFpnxzTIO2Ev1/kkjdV3Xv2TqwUYeGNcDS?=
 =?us-ascii?Q?IVp86mfN9Yp6uk+tPbhEAClZ7nGc5EpGWK3CAAsezjMstCHInUFqIUIacbzN?=
 =?us-ascii?Q?JR7WqKIyto4v0RSdD79mhTnh1n3K1zDclI1wZvzwINsRgb2HXVm/PnuHwOHm?=
 =?us-ascii?Q?xfUD738HYCVRgyDEURo6AXkTWoiodErQyXcPo2ovvhW+usBPqjmMzoompO9Z?=
 =?us-ascii?Q?leFDayTZAhu16/1x9YrTbAj3XY4X/CGgOemKjULSxu5Ps8V+TzuVnV7PKB46?=
 =?us-ascii?Q?Rf8nzc/Dl59Iif4J3NYnS5qe+3FhcFjdB853+xJB3Mj9Z4gMYTYYqVVgQ/qK?=
 =?us-ascii?Q?mMdAMQ4roZFZLVT5TnXIFon3/20+CSHUs+IbB56uoATGziUgvSUUCrcNJwPV?=
 =?us-ascii?Q?e8nprLR/U2NuC9l+oHgOWX04rEDAdqmGWTWNc0pkTGR7lc1gbbRb5z0i7eIM?=
 =?us-ascii?Q?768sg1/7ch2PBpEiRU130tx15Lfh7pWI2bRyxR8n5vSUMToN9mATmGz2m6Jw?=
 =?us-ascii?Q?LTNAsXrAMy6DPQqMIVl3DUGVyP+zHxsLY+iDONA9MB8zEV+vtW6DkNjU5VJH?=
 =?us-ascii?Q?Pc33aju9mMTSAZbjX0LIx/4UHgmtDS2GsbfmI68BxPc5ssTkHvPLxyHDlTt7?=
 =?us-ascii?Q?ZzTrUZygK8mZjsqJHofGmm7/R0xrBMYi71f5yaYOuVO1BVO1a3E0kH0HXJqa?=
 =?us-ascii?Q?MdOAYj+HcJgfgidfdIAemomCfcmwqXr13yMR8qn8FqivHZRFPZr1/0QOCblO?=
 =?us-ascii?Q?6EPx+GdcXiyM98xGLRE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0613fc39-bb95-43a7-36f8-08da8eef37e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 03:32:11.2039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzkR2N0kwh5rQtjswMyDWLoclxffPVFx80IyTVJX+jZZA9zjxBMFCL2yrBIt8eklVPDaBA5Mlg6jwd+AOjvcrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8231
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: Re: [PATCH V2 2/6] arm64: dts: imx8ulp: correct the scmi sram
> node name
>=20
> On Wed, Aug 31, 2022 at 10:25:48PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Follow sram/sram.yaml to update the sram node name.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > index 8460a3cba107..7a88d7016b49 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > @@ -112,7 +112,7 @@ sram@2201f000 {
> >  		#size-cells =3D <1>;
> >  		ranges =3D <0 0x0 0x2201f000 0x1000>;
> >
> > -		scmi_buf: scmi-buf@0 {
> > +		scmi_buf: scmi-sram-section@0 {
>=20
> While the commit log mentions sram/sram.yaml, the binding doc says:
>=20
>   $nodename:
>     pattern: "^sram(@.*)?"
>=20
> Does scmi-sram-section match the pattern?

Yes, it match. See line 66:
patternProperties:
  "^([a-z0-9]*-)?sram(-section)?@[a-f0-9]+$":

I also checked
Documentation/devicetree/bindings/firmware/arm,scmi.yaml

Thanks,
Peng.

>=20
> Shawn
>=20
> >  			compatible =3D "arm,scmi-shmem";
> >  			reg =3D <0x0 0x400>;
> >  		};
> > --
> > 2.37.1
> >
