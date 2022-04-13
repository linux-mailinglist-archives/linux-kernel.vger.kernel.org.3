Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2C74FFD79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbiDMSJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbiDMSJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:09:46 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9104C7AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aal/xqE/MrCnMbuRYHxOvvOxwvIGfo2xNA62k9CkQyj/dHYKlJ4uZCPiuWA1K9xVHK9mh7h5SgBzFjto4Q3GuhU7Ar8pi5k1kcGXMwlcn2Nd93HtELdPhr5w+SAXWNHoOoSI/6bN4uXhj2gkq6/H1I4LFJ8OKRNowtZeFRPn6YEtEvVOHDw8sV86C6toI5lro6ifEEbxXTmU5hNrnTyIAeX6i/7wnlwz95PxVtAUhp/eSWlBMMB4NhYSVbynafixuZsnDe/4fIy86x0fmYrzKKr3jKewiUaZChVqGbIIcKTrY0FyTChvIlQCDKx5b3S6YJA+WkjMj/VnhkoWI/daIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgBAXYac1oTJhXKs/Sgl9uuvXZHpDJhLSRJqsqOGnYw=;
 b=f5Tf4DtVt/h3Cca1w0jTsXBoVY+wxrPAt37/ZMe/Wq8KV03KFPf17SEZEDXmFQHX/2QIxCD0wCI+mVk8oJozpXsvwFRsrVIbyJtrU0rht3MHCFqDidYeHhgyVGgSfsjcfpPz7H/ghAuM9NGfNEPHyPmswVDlXoeD61GjoR+XgX8IKrxyJo8A2oSX+CpDlezJ0eSf9m5oonSYIzpLCRHSeMU97T2gk4cdzKpCRTXBtCPmCkN30tW+nUDpdPAwRfVD0dCg5H2/U2X9b/KTG67PRXJ3o7Ox49lHAtMDc93TqFzjFs7RMYbPMa2rGFphJuzwXAyfuOUkMgIGrRwWvk5J5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgBAXYac1oTJhXKs/Sgl9uuvXZHpDJhLSRJqsqOGnYw=;
 b=Gjzis+l8mlh/9eEp+53C2rFahl6LcLGXrPKcDbbeA80M3tIjhXSUz46FwKx56Ot0kC2rL0MQmiIAgJV+3JLQbEXtoPboZoET+tFKpxyj6g0lvz+GBw67LGGpfv5Bf/c/Uv9olLoDqtC54YKn72xU8xktmBapF3bCA21+2A+RPqg=
Received: from DU2PR04MB8949.eurprd04.prod.outlook.com (2603:10a6:10:2e0::13)
 by HE1PR04MB3242.eurprd04.prod.outlook.com (2603:10a6:7:1a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 18:07:20 +0000
Received: from DU2PR04MB8949.eurprd04.prod.outlook.com
 ([fe80::a074:1c67:a763:25b8]) by DU2PR04MB8949.eurprd04.prod.outlook.com
 ([fe80::a074:1c67:a763:25b8%9]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 18:07:20 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Vladimir Oltean <olteanv@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biwen Li <biwen.li@nxp.com>
Subject: RE: [PATCH v3 3/8] arm64: dts: ls1028a: add flextimer based pwm nodes
Thread-Topic: [PATCH v3 3/8] arm64: dts: ls1028a: add flextimer based pwm
 nodes
Thread-Index: AQHX8M2Qp2fR5PuKkEeWcFzMp8XOI6zuxrMAgAAZn+A=
Date:   Wed, 13 Apr 2022 18:07:20 +0000
Message-ID: <DU2PR04MB894984A336667EF01DF709988FEC9@DU2PR04MB8949.eurprd04.prod.outlook.com>
References: <20211214093240.23320-1-leoyang.li@nxp.com>
 <20211214093240.23320-4-leoyang.li@nxp.com>
 <20220413163306.hp5qyxxgdlekczet@skbuf>
In-Reply-To: <20220413163306.hp5qyxxgdlekczet@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fad6453-9a35-4fd7-c81e-08da1d7873bc
x-ms-traffictypediagnostic: HE1PR04MB3242:EE_
x-microsoft-antispam-prvs: <HE1PR04MB3242B702D1C8CE2AEC2433018FEC9@HE1PR04MB3242.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BAATzBorJR6YB/SsIdeCxSDPfJdIvsK67PNKHgvrq9UZis0OM51G5+LZtdGpEKfX+eO0ZN6X1//ZJ4GE/ZiWxLQqfzg3XFwtAI47aN/t0Q2VV9nQQDMg9VrpTdscIAnVFMWQO5fVWnHVkBj2cNEzST8ZjyQ2OZh8wCBljwtW9mdd+/vwyp9Tk4aa8rIiEjqGZpIYl06bqoHoadAdu50Gl65nKs1e1cyRDY3ZGrCGnpiQ8hXpoHOQl5qLhgva8NwAgxKfwFseKr8zOP8ohqtSI+tpaJuIgoEamRlScyw4LU5PFgu2RsTBSvUYYrx6pEO5qbZCVMOXLUj5eMpktMigA2r9QvxvFxYQPV+h/2HBeyVTUe4OQ+yEdmc6U07uy2atTfse81cn/Mrjswvz6bKXdr+IOtKnSCi/78b09W/SKVpFXOGV2plq6TUX8Hi1xEWIQBYVvy/mwfFK4gBi7OiaiJdN9gpDNI6lqd2u3x0gXnA1usjRHziEfpb2zepYQtG1dUoZc1T6kYZxM+euZHnHd9CU7iudgJmPwjQu8/rUlgeDGG0iWCL26sq6r5Ne3SkytJELigg6yw9mlM6qPgVzJezm0nIDzSYqRrKtH793sCxQ413PkOoLTvR9SDioUutipkha7Pu9tdKqmZedHipdJC0Un9/BtfKsWC2iAwth1xAUFv8KjkoJwyekcLhEwmuO9jA1Ovkm0AmVZzcvpFy+BQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8949.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(9686003)(4326008)(66556008)(66446008)(66946007)(6506007)(7696005)(8676002)(66476007)(53546011)(122000001)(64756008)(5660300002)(55236004)(508600001)(55016003)(86362001)(8936002)(38100700002)(26005)(54906003)(6916009)(186003)(38070700005)(33656002)(52536014)(2906002)(83380400001)(316002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eGgZ0tyC5+SpFb2hnbw+DUjAAdp4Rk2Xu+7DXZ3l3aFAEqf/t4GhsBXQlz84?=
 =?us-ascii?Q?eYrkZwqlHLW5+cg4H/cbACM5g620ppFUKXCC2ub8GHKtzNWiyxGfCG0TCiz9?=
 =?us-ascii?Q?BxeFqloh9SGE4Js9SuXe217ltXT3kZv5eEhViS7AZPSx3ilWcKtqukLXK8Gb?=
 =?us-ascii?Q?aaTEaE1A9t6OmR4D2a0y+KyLpJ0+JrChtQU1fy0X+RVnjV5Q8lRwrdO1lteQ?=
 =?us-ascii?Q?pLG2T/NnIw+3025d/5iKR2ZibeLoks4wLsccY759hj0zkB0Z7qDzwEyQEJM8?=
 =?us-ascii?Q?pcMMzUr2B4Q54Ueym47Ybg4bKGxv3St7ZFwEmrpZ0i9PVvfw58LKqOTAooQi?=
 =?us-ascii?Q?cUXyH9+r46WuNUTsI8Uv8aMmrTF+YjwSs2K8HXmWM1zAdyOdbrScRbjhl4X2?=
 =?us-ascii?Q?bkswerTCLfzRPLH389NZIFXqHuFBWX0weMKNhPzcFYepPwISgMRMAMpVQlNU?=
 =?us-ascii?Q?hF/GHU/R25i0AHlN/gfIOWL/Wb7143XcTRyiqhsc6xVqPz0YdSQdPPgaUnao?=
 =?us-ascii?Q?Pw0I53Baaghmc7CJAM69bNzkSzlHOgQyO//tuEwbjas7Ci/6mUZzmI5zWLKf?=
 =?us-ascii?Q?FiQ7Cx9DbKKJZHu9xOTWNq8vlQ8nLRMAZEieX7JvsrreQkIvK/ZNqIeN2oIW?=
 =?us-ascii?Q?culp30PBohzOSP5FAIblvg4xaiKjBJdCt2g8xE3VYjTuWjYCVVermh0DYCdQ?=
 =?us-ascii?Q?6+koXHoC8gryFhykj1p/4JsMdu36I7qjX5TIBvPJBD6XIvPHLN9vNtgWw7mB?=
 =?us-ascii?Q?Ze7PUo+hNq496CnczpsMTEt5jJGZn8bIX7aqkrOuVIpAEpEGZol+lMZkNQz6?=
 =?us-ascii?Q?y4CsZKxp83Sx42nmGJITG+sZiaIHrf8roDp/H7bFn2dzLKGMPw6w0tz5lYlD?=
 =?us-ascii?Q?I68qwFQUAgT5vpqwI3HEDatLcJ4+uQRGZ2l77GUlloJKOP41ZMf200sXop/4?=
 =?us-ascii?Q?qUzKNl04K7V0jKnbbSZC5wY5o5gcSef5qexegj302Pmp7ZZZPgSKOgS6Lrll?=
 =?us-ascii?Q?RM35/lWKV4azRB+KUZQnJCM4fDp4My95OdlIehljjGBID6sc9ZNukR5L+wyH?=
 =?us-ascii?Q?2T3jys5cIgaCbG1qS6f/VM8i+NNTTB/epUHVnlYpawmotE38JNXp6Fhzb3yI?=
 =?us-ascii?Q?So22G9TJf+sXZht3RCV/l1cBQxqVbtJfuTg7MxB4kewjK1lOwZ9HUYztpq8Z?=
 =?us-ascii?Q?2Bal8pSaVyKtc//dbBpm1iDCr5krUnMwnblmnBmFdUBQ2EziDQBevXQ2RMzF?=
 =?us-ascii?Q?1Mg496FcxwZusLMpUzQ7IA+b9vPbyDYB0PvhlonnVRLcFo3UAsLTe+qkwmd4?=
 =?us-ascii?Q?HssiajOzorQpWhs5IJUawQbNjjba5Pw6WDaMxzA6e1TO2Ufz15+o4y+Om5e8?=
 =?us-ascii?Q?gEK1xPKNBgAto8YvQk3lQqhe1k9vAFMZsIpongejnfRbCaDBXwz86clf12qH?=
 =?us-ascii?Q?gtj5LCiyaaHTPflimS1ma4rwq64xiCBl0n9b+zWfOHQeV945hPa01QDw9JxO?=
 =?us-ascii?Q?BrOKrzhpR2JHIAdhPKuqWs8bAymPSHDrrY7rVprn7McLQP4zwPy2Rhvn709o?=
 =?us-ascii?Q?n/8FO9pnE0ARO+TsbOZpAiz+mXFH+Sq1xEfhszVEaNyeP8Byv+jZiwLFy2XY?=
 =?us-ascii?Q?0YgHjOuGgdhidu2LPIj1fJQmrETChw/2KLgVV54Gsge7VCc8apCR5f/Kbi9w?=
 =?us-ascii?Q?RLgOZtkdicPqjKoAgB21ZmgoALDZAMwf5qrNB6INHGEsHnAdDiFGsi/JUHOm?=
 =?us-ascii?Q?+7vaeSTDhw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8949.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fad6453-9a35-4fd7-c81e-08da1d7873bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 18:07:20.0285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iF8Sqa2//YAkj+iRwsMs1u7j1AqfgpHDcmag33ZAcNDr3SWNSBdYUbYWuRArrh2hvoPsKM4I/Ls7L1KroMHCpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3242
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
> From: Vladimir Oltean <olteanv@gmail.com>
> Sent: Wednesday, April 13, 2022 11:33 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Biwen Li
> <biwen.li@nxp.com>
> Subject: Re: [PATCH v3 3/8] arm64: dts: ls1028a: add flextimer based pwm
> nodes
>=20
> On Tue, Dec 14, 2021 at 03:32:35AM -0600, Li Yang wrote:
> > From: Biwen Li <biwen.li@nxp.com>
> >
> > Add pwm nodes using flextimer controller.
> >
> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> >  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 95 +++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > index f2564faf7067..5a7b26a1bad2 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > @@ -66,6 +66,13 @@ CPU_PW20: cpu-pw20 {
> >  		};
> >  	};
> >
> > +	rtc_clk: rtc-clk {
> > +		compatible =3D "fixed-clock";
> > +		#clock-cells =3D <0>;
> > +		clock-frequency =3D <32768>;
> > +		clock-output-names =3D "rtc_clk";
> > +	};
> > +
> >  	sysclk: sysclk {
> >  		compatible =3D "fixed-clock";
> >  		#clock-cells =3D <0>;
> > @@ -1186,6 +1193,94 @@ ierb@1f0800000 {
> >  			reg =3D <0x01 0xf0800000 0x0 0x10000>;
> >  		};
> >
> > +		pwm0: pwm@2800000 {
> > +			compatible =3D "fsl,vf610-ftm-pwm";
> > +			#pwm-cells =3D <3>;
> > +			reg =3D <0x0 0x2800000 0x0 0x10000>;
> > +			clock-names =3D "ftm_sys", "ftm_ext",
> > +				      "ftm_fix", "ftm_cnt_clk_en";
> > +			clocks =3D <&clockgen 4 1>, <&clockgen 4 1>,
> > +				 <&rtc_clk>, <&clockgen 4 1>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		pwm1: pwm@2810000 {
> > +			compatible =3D "fsl,vf610-ftm-pwm";
> > +			#pwm-cells =3D <3>;
> > +			reg =3D <0x0 0x2810000 0x0 0x10000>;
> > +			clock-names =3D "ftm_sys", "ftm_ext",
> > +				      "ftm_fix", "ftm_cnt_clk_en";
> > +			clocks =3D <&clockgen 4 1>, <&clockgen 4 1>,
> > +				 <&rtc_clk>, <&clockgen 4 1>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		pwm2: pwm@2820000 {
> > +			compatible =3D "fsl,vf610-ftm-pwm";
> > +			#pwm-cells =3D <3>;
> > +			reg =3D <0x0 0x2820000 0x0 0x10000>;
> > +			clock-names =3D "ftm_sys", "ftm_ext",
> > +				      "ftm_fix", "ftm_cnt_clk_en";
> > +			clocks =3D <&clockgen 4 1>, <&clockgen 4 1>,
> > +				 <&rtc_clk>, <&clockgen 4 1>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		pwm3: pwm@2830000 {
> > +			compatible =3D "fsl,vf610-ftm-pwm";
> > +			#pwm-cells =3D <3>;
> > +			reg =3D <0x0 0x2830000 0x0 0x10000>;
> > +			clock-names =3D "ftm_sys", "ftm_ext",
> > +				      "ftm_fix", "ftm_cnt_clk_en";
> > +			clocks =3D <&clockgen 4 1>, <&clockgen 4 1>,
> > +				 <&rtc_clk>, <&clockgen 4 1>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		pwm4: pwm@2840000 {
> > +			compatible =3D "fsl,vf610-ftm-pwm";
> > +			#pwm-cells =3D <3>;
> > +			reg =3D <0x0 0x2840000 0x0 0x10000>;
> > +			clock-names =3D "ftm_sys", "ftm_ext",
> > +				      "ftm_fix", "ftm_cnt_clk_en";
> > +			clocks =3D <&clockgen 4 1>, <&clockgen 4 1>,
> > +				 <&rtc_clk>, <&clockgen 4 1>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		pwm5: pwm@2850000 {
> > +			compatible =3D "fsl,vf610-ftm-pwm";
> > +			#pwm-cells =3D <3>;
> > +			reg =3D <0x0 0x2850000 0x0 0x10000>;
> > +			clock-names =3D "ftm_sys", "ftm_ext",
> > +				      "ftm_fix", "ftm_cnt_clk_en";
> > +			clocks =3D <&clockgen 4 1>, <&clockgen 4 1>,
> > +				 <&rtc_clk>, <&clockgen 4 1>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		pwm6: pwm@2860000 {
> > +			compatible =3D "fsl,vf610-ftm-pwm";
> > +			#pwm-cells =3D <3>;
> > +			reg =3D <0x0 0x2860000 0x0 0x10000>;
> > +			clock-names =3D "ftm_sys", "ftm_ext",
> > +				      "ftm_fix", "ftm_cnt_clk_en";
> > +			clocks =3D <&clockgen 4 1>, <&clockgen 4 1>,
> > +				 <&rtc_clk>, <&clockgen 4 1>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		pwm7: pwm@2870000 {
> > +			compatible =3D "fsl,vf610-ftm-pwm";
> > +			#pwm-cells =3D <3>;
> > +			reg =3D <0x0 0x2870000 0x0 0x10000>;
> > +			clock-names =3D "ftm_sys", "ftm_ext",
> > +				      "ftm_fix", "ftm_cnt_clk_en";
> > +			clocks =3D <&clockgen 4 1>, <&clockgen 4 1>,
> > +				 <&rtc_clk>, <&clockgen 4 1>;
> > +			status =3D "disabled";
> > +		};
> > +
> >  		rcpm: power-controller@1e34040 {
> >  			compatible =3D "fsl,ls1028a-rcpm", "fsl,qoriq-rcpm-
> 2.1+";
> >  			reg =3D <0x0 0x1e34040 0x0 0x1c>;
> > --
> > 2.25.1
> >
>=20
> arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:1210.21-1219.5: Warning
> (unique_unit_address): /soc/pwm@2800000: duplicate unit-address (also
> used in node /soc/timer@2800000)
> arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:1221.21-1230.5: Warning
> (unique_unit_address): /soc/pwm@2810000: duplicate unit-address (also
> used in node /soc/timer@2810000)

Well, this is similar situation as pcie.  The flextimer controller can be u=
sed as timer, PWM or alarm.  We have separate drivers and bindings for thes=
e modes which resulted in different nodes for the same controller.

Regards,
Leo
