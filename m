Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74FF5B1829
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiIHJMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiIHJM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:12:27 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50058.outbound.protection.outlook.com [40.107.5.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D93FF50A;
        Thu,  8 Sep 2022 02:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TW6Z4BtfBWx7VBccbyeU1rRBbLNRRpz+V7k6cmsGmvqpXfjBuFVYZhn5qct5DIpDBdRjt+5ugNmuLCtPjxI5XKjtX+mtVZAv5PctArCNJDq52URLOQ5AOrZ42ANBQF8+E5SFkNZlt4d5KVDQHDW4VP5/5rRoQnVAoVyhuIjX2HrBUVjvjzak5LJsm+Devv09Heqys9kJxu2DFXDWlGfmxb6zho0vJXncAhNWK8vMdzDJSVUueFBZ99W762AeqtwpTx67aQcSqx9r+jDom+cCtDuegIwfpRvU+0bMhJAXcageWCLEAyMGr4cU3Ozwk/6ayEBZ59HCekjsY3BIQULqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukzEHnXXiPBO+hweLOMzWkmGphIMjVEQhoqgyevEz0w=;
 b=ZGDBT9HRJ/TdwU6EyM5iu23chQM9mawOx8o7A/Ntjpu6vEkACmZM3M246ZGosKEVL1JFX3lhg0IaXMH0YsZPpYc8J10V/HjHgxH/hiOwP9S2BhGtb8KH3JQfNm1wTouqTssBEO087TjRam44Fp4rWjUt6324ckQBhZt9cF3X4a9dp/oJt3oay0KNpsSIDM/gEQPap1mZEuOIsWyYAGyF53eKNhbrMcNJyZS4Kp8Dwgy2AlrLMdsZzt03dW6oVjcLe8wkpUTx2RzZg2Rfyk71WEuilXwcuUmMYCztCTQMbbcBNT1jFwSO42/qmpJqNba982Ty3HFMrSvYw19pgm5auQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukzEHnXXiPBO+hweLOMzWkmGphIMjVEQhoqgyevEz0w=;
 b=Eqwv3c2l+GQu7FvhcZa+cYVRwYNG3KfPPWPuOum29O7mDOKd77zqWoi5gVgd2XKKT9oPBmqwuccB+W51HjrZWkFDkNSRcsTWIW51+rCnVnS7wLfDnQpaIIdLZMj9wlOWjOK2qVNVYSIWhrApsUiXSjYQ3YBUfGecMJ/xSEIQuDc=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by PA4PR04MB7917.eurprd04.prod.outlook.com (2603:10a6:102:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 09:12:23 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::25b6:d7f1:c25e:24d2]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::25b6:d7f1:c25e:24d2%9]) with mapi id 15.20.5588.012; Thu, 8 Sep 2022
 09:12:23 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] arm64: dts: imx8mp: Add snps,gfladj-refclk-lpm-sel
 quirk to USB nodes
Thread-Topic: [PATCH 3/4] arm64: dts: imx8mp: Add snps,gfladj-refclk-lpm-sel
 quirk to USB nodes
Thread-Index: AQHYwsihDhk8Oa5k6kGFYSWlpJmj9K3VQBDg
Date:   Thu, 8 Sep 2022 09:12:23 +0000
Message-ID: <PA4PR04MB9640C21A8F2DC44DB58C5C9089409@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
 <20220907144624.2810117-4-alexander.stein@ew.tq-group.com>
In-Reply-To: <20220907144624.2810117-4-alexander.stein@ew.tq-group.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3540751-7d37-4571-4843-08da917a3ddb
x-ms-traffictypediagnostic: PA4PR04MB7917:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EWMZZ5qgdOtKNq9dp1UWa9s53dHaHVz6kZ5oj7sbRpwz4E+oLGNvy3x8RuARmDL6XXZdC8ygB3TAX05PCoRraBT7l9Tirojj4YX7pjLIByIbGpCAaFfnKhmPyetUYGZRWgIW1diEAGP/J1GigvbiceEi0+hQZ/W3hfF0CcOTS/z7QrT/gUV60yKbvoVgzNaZ276q1VKig07V6VJNU8TVoegVqws5dLEVnHoD+qQLiSX7UL0N4A3fnEXQqdQ0URMEmAOa27mRpYo7072ENnNLLA5l5Gn8p0dX+9ZKqUW6CL6IveaiNE2MhzjwPwOM8KCHxgnYgPhzyj9eJ9cs0FIwDRRrgDLColVNn5qlHb4zAoSd6bCeHJqY1w57MxpXYdNtyw2a5aCYJOZDq337WdAtfjl1e0KB9EZKDK/GUGfdUtNCQ/g3q6oVvQHc0OBz7OuPvkMirgGTuWYQkVM5wKN7HnBJjnb9t0ezSZocEBR41RNkFN4O3h9z+Hq778gNITfMHYlSO9KMOqr1UqBQwSYgUkOMGLpxb4Ts09a+Fiq9E0PvNRiwqTgN/DQ+jN6MP/sNVg+7ixgrgL18fV3t5ensyDZSWFHX0fLsMsTBJJdiWRx04HBvs+Jp+InZmSDPuDEL0O0GUg9731XFKR3rVif89q/pNlOqThi1kAOfG9UkUTVGnZPbdiSqiqlDuX/dqXeMQssg/NKbroyrbdh2jV9lzt0CcuPIBzaxHdoLXolds934wemi2USDivLcb48kx6o+5nm+OV7lEbboU9xVPTbSy2E273nGxldFBRM6Itdt0PI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(54906003)(6636002)(76116006)(83380400001)(9686003)(26005)(7696005)(478600001)(6506007)(53546011)(316002)(110136005)(186003)(86362001)(33656002)(66946007)(55016003)(66476007)(66446008)(66556008)(8676002)(4326008)(44832011)(2906002)(52536014)(64756008)(5660300002)(7416002)(8936002)(41300700001)(71200400001)(38070700005)(38100700002)(122000001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NPAgyi0Kg5YveFwbmfamLDi/si5AWCeCy3AeN1gY327/+qNyFPEJOnxXfFuc?=
 =?us-ascii?Q?mj7qgr9x+IvcWFipmG3KoN475PMlnvMS8con99mB5KW3GYioYn4F8eGPJL2Z?=
 =?us-ascii?Q?TxEqKkVg/Oq7Gafzzf5ptRCtk4buA4CsN1AznzfqmaBxOIP1fB3gNRUdrfWl?=
 =?us-ascii?Q?vDdNZgU8oJ7nW+Yr2hMEKMfVxiRpTEamlRX7LP+kw1BoQCwVVkC9/Srkb+YI?=
 =?us-ascii?Q?KHPZgI4qeZkxoZtCxP5As4/MIp2HwNVbnDtgAMf7JCI/Oc1GS5Wu/SYs199G?=
 =?us-ascii?Q?bkIVJcIxorw8Hfd2jD0nv1Q5tvyk6E91NSfvP39yOmcjW8Lbd7zSShOzMojV?=
 =?us-ascii?Q?vV5tDp+YsTGeDerqxX3PKluI8lTGR3zj+/NqwsexnAIMrDTC2xbSRNqd/h+x?=
 =?us-ascii?Q?DyeMoSVLzOVRP2xtZ11j+Cx6bPgmst9Cg/wLaLDiSyzA8uggog7f9Dwa/WKc?=
 =?us-ascii?Q?ziAo2n7T9xEVEiKLPMb1V7KLQL5bArl2oHx2vFJJ9TOv9bLjKp/KZQltEZvp?=
 =?us-ascii?Q?96QOAP2bnMmfLgS0NTXrPiDwPaf2wB8aCw2AKzy6gLseNxn1K6QFsI4W9fmc?=
 =?us-ascii?Q?RhnKi3Jc5ctX4LQouWi58IB3gFy1wrNie+JOAapMVZGJTL2T288CGPHfUY7N?=
 =?us-ascii?Q?KONZbAxreUMkajat3jHXajdpDtNzSMNWf4SzStFFcH1tGIk53G99nEWmAEha?=
 =?us-ascii?Q?qcwfGB596gpPSXDggC3i8tqMtLshsj07LHve+TgGx/iPPlVn1/mAdxFiHW37?=
 =?us-ascii?Q?f/ukXzumEU2ouS5j6iws+a9PihNE5Qfn3GD1BTJdrmU328qOBrXm1HzX8d0f?=
 =?us-ascii?Q?QuTup1g7Rmw1szHH0D5U0N3RiBgf09eHJ9WmaMhbzDZaXMWueFVgXxNKWd51?=
 =?us-ascii?Q?unzZTsJDuEKr4ic0QrrXS4H+nXGTAftE1YzeDrQCnqKqSKQiGdvdlUrkS478?=
 =?us-ascii?Q?LP1rEoKODX6R34h+B2354dUrsaNtty/iPDPY8qycXzFD+xFHS3G4Dq3Moby4?=
 =?us-ascii?Q?TI438jVtNgHqxw1bqLWqGPKXpfdf5Relurl+Lg/9RY26DdzJU/ZygQCFBraM?=
 =?us-ascii?Q?ASuiloisH1knfDbSU4WpfF5TDPU158nCYxV/sMleakn39pSjTYG3hQU3H8NG?=
 =?us-ascii?Q?cteJkjqlc8edvDRvG3jEfj92KqzM7wVMPTXVtLEaf3mbaAtubBb8/f4Y2UIo?=
 =?us-ascii?Q?OQMUg1f4LmX299T9GY+N1mDqu7esG4zjdOpZ51q+yzw/qM2rM2hLLUASDoKp?=
 =?us-ascii?Q?PyZz400hcMWbMvN+TNcesP1NSnefLdz0za26Nef8cZ74/D9/kmrdAEJhZwAV?=
 =?us-ascii?Q?nqEoSThpr0E91RIUEGls/NalJn/MGcXFKn3Ss64ka8Ya24w8WsZZKD8LFK6/?=
 =?us-ascii?Q?Gq83qISmKLDDKqe8Nal+qWEaXCE6TUd9a1oFcxKtY2hlgNZzjvmtRNFJWnbv?=
 =?us-ascii?Q?GRWBvZ/gZLawPl+X1qZlPLtF6eAMXiM0xBrYbq3UCdq4pMKtS7CuNOVqVImV?=
 =?us-ascii?Q?9dbLVkbhR2IV9ytC+vmiDOXRSpvCxdNTWW9EXTJ5c97Ag7vzK9eO9wzz11MN?=
 =?us-ascii?Q?f4boXV8MC2QqZkSmIVI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3540751-7d37-4571-4843-08da917a3ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 09:12:23.5540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvODot3svI4ILXqhIhUfmE8O1wVCNwfXxsMfm8+b0O9Bk3mBVd85y5K2UW3M/03+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7917
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alexander Stein <alexander.stein@ew.tq-group.com>
> Sent: Wednesday, September 7, 2022 10:46 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; dl-linux-imx
> <linux-imx@nxp.com>; Jun Li <jun.li@nxp.com>
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>;
> linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH 3/4] arm64: dts: imx8mp: Add snps,gfladj-refclk-lpm-sel
> quirk to USB nodes
>=20
> With this set the SOF/ITP counter is based on ref_clk when 2.0 ports are
> suspended.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 53493dc7d976..0e7f5842a3e4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1300,6 +1300,7 @@ usb_dwc3_0: usb@38100000 {
>  				phys =3D <&usb3_phy0>, <&usb3_phy0>;
>  				phy-names =3D "usb2-phy", "usb3-phy";
>  				snps,dis-u2-freeclk-exists-quirk;

So this property can be removed?

> +				snps,gfladj-refclk-lpm-sel-quirk;
>  			};
>=20
>  		};
> @@ -1342,6 +1343,7 @@ usb_dwc3_1: usb@38200000 {
>  				phys =3D <&usb3_phy1>, <&usb3_phy1>;
>  				phy-names =3D "usb2-phy", "usb3-phy";
>  				snps,dis-u2-freeclk-exists-quirk;

Ditto.

Li Jun
> +				snps,gfladj-refclk-lpm-sel-quirk;
>  			};
>  		};
>=20
> --
> 2.25.1

