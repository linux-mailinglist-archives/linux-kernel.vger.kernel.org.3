Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B57749328A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350792AbiASBvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:51:18 -0500
Received: from mail-vi1eur05on2087.outbound.protection.outlook.com ([40.107.21.87]:46663
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350784AbiASBu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:50:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNpSwrIDxOWjl5qZnAhl1om0x8TpmaBUkPg2Oa9oiPuxkVKqu2tSPKhm6Xcd3EryVQv94yRwIEdz2QTsMcp5YhZOeb+hE7XMexq5koe/jS4PlyTz4QGqz11VbuGRUnfcEE7+FHVXS6TL3WZNTUT326+hBqQSKulXbpY6X7VU2a/dWcmnr+iTjeeSbdw1CzApgkAmlPrUcY6orXxTfm0EmbhFd2cxmtO9axfMeAMxedONMC15nTu31SesU92ld6ya8p1Vr7fSV50sP1Fp5sxLXOqfDJ6iObLPF0nDZgPVFxDphOEYrBzjp0D2LXDB/scYAtD2y5AKE8vgBHPezvXEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=purUjKF4BnzAlu66khNPA2GluVTmNFBFCP7c5MtGtdU=;
 b=czhz51CaceWejVHOthxIxAxYSdKl40VMHpJ/NmhYIC7Iu0WdiJTBa5P0V4eISDmsuOSIgZ4KmQpU33uqLqLqjeQCDQfoe0zX9zfkzfaq6I9/nx6rA76BYQNlEuzdbx4ZZOeQhrLF81TE7HlCIrlNF2r1ntYgV4JsvMEHptDajkJNohJsG+a6OimKfjpkrPEq3V7iD8vhuBldM95QnWFLCccPZV5Rz8/WIXZIrWGZ3Hy8nDydQP2MT5lSnK3OafTTyzyvOdZhi1Za8qqgNAOj84r/72fOToOD43v6r5yCWRM6VGw27iDUqPz5Z67c7ifONzbvwJ0JsN0nFQa3/n9eSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=purUjKF4BnzAlu66khNPA2GluVTmNFBFCP7c5MtGtdU=;
 b=qL9XV0RmoV37N79SXR8VYMAj261OlJdfK/Dn4OwVga/+IrQHixdk8zf4gTXG/7Kf3T9lamhMTCar8xeBiwPcIzcFUDZjhwA4YFXwJxLCpJnuMxHSuuilBGC2WexY0TFMM464rFanNgBS/j7L9JD+2Fp6z6VNVLfzt0cYo1UPh6I=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 01:50:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%4]) with mapi id 15.20.4888.013; Wed, 19 Jan 2022
 01:50:57 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] arm64: dts: imx8qxp-ss-adma: Drop fsl,imx7ulp-lpuart
 comaptible
Thread-Topic: [PATCH 2/2] arm64: dts: imx8qxp-ss-adma: Drop fsl,imx7ulp-lpuart
 comaptible
Thread-Index: AQHYDHO+msV/nEWujE2GthKesaqJsqxplQwA
Date:   Wed, 19 Jan 2022 01:50:57 +0000
Message-ID: <DU0PR04MB941710BD11CD7BA2EC25667888599@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220118135918.2126010-1-abel.vesa@nxp.com>
 <20220118135918.2126010-2-abel.vesa@nxp.com>
In-Reply-To: <20220118135918.2126010-2-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d10fba2-24d3-43f7-c3a8-08d9daee22f1
x-ms-traffictypediagnostic: DB8PR04MB6907:EE_
x-microsoft-antispam-prvs: <DB8PR04MB6907267A4A3B729E07470E4B88599@DB8PR04MB6907.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /NN6NfXU1hSElA105ckO1il29iG21QHroq8RdJ9NTLJIrEJEcKiDuLsIFU7xKfKE7J5HS2KRQH4L05X0++djGPkddLVW1HherIEnWb6Nna0Q1daBHEAqD6Vf8uL6ukKbprTnBe5WKvpfTN2daSIMcd6AI/kfIonF/4sITG2u9eVSYM1x+pLF3t/mI27NahDuunGiQkBeVfzfg473T2HcXOzy08Hww3lUAqaBNkHA0Wb52UjICXPq365pcjuEDGSwsHjC8nQdWkw9N3nFGsvBQBHbSjR/BqNVJ1PIyOWBlJV38d2jJTiPiJ+BznBSyq9urAwDrfoFqP/aspMiIPumh3ITL6RWEHSZBlsDE1GbNRBI8wdlyHeLKmH9eB+4946hKZ7gXEU8F2RIlJIhucFd3lMa4qafFNKroF5QLzRaGANIgkZoET2QKDxxoj+4sc0sd+8V37olbHXynbOPbbO7k76fxkNnYfrskBvwdc5zXcnmjOnNmuM1aGEDhO07cWFu49plfgzvCgTHrDA4OntptsCPXch65SYkqHYzDlOt+PQrzOmk7ThOSPY0ijc/ivyibcHDtfrRhGC+he7/gaEcdcsHtfRzqyi8oH0VSOJukiAsXa2eurxe11//riQV7ARdT3nV+e/QUQY7HRQWUZo9yqEjupuGThgCYml/7Z7Hnh4qR7Z9MBgIILWZ4wAWE3bBtCHWSHRNVWzq3/wGUbX+iB9JxFHmEiryeYoGptLGQ44=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016003)(508600001)(83380400001)(44832011)(38070700005)(86362001)(8936002)(71200400001)(52536014)(122000001)(5660300002)(38100700002)(7416002)(54906003)(316002)(9686003)(4326008)(76116006)(2906002)(6636002)(66556008)(66476007)(66946007)(64756008)(66446008)(7696005)(186003)(8676002)(33656002)(26005)(6506007)(110136005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VA9+4E2JG1eOeX70mXW4Cw6cPjzP4UmTsb/MMsVyxhh3cSVx7pkiWfMjatYR?=
 =?us-ascii?Q?ohZ49YBJHQ7AxABO9PGzUdQYedDYThPQq9XBqZ8NSug/n6iQB8a6U4g1q5Ee?=
 =?us-ascii?Q?5gKf2Xuh2mg1wm0WF973zJO+e98OyC3MqRRCzQ/J39xQ1D9vNiCNmx79bpoc?=
 =?us-ascii?Q?A/Sb7/FQbDZsx1dCee6/5FJL6BabIUQ3bfianTrq96velCZjM4Op/SY9Dw+5?=
 =?us-ascii?Q?mbcuk3snuPjgGKuoZYzwDOO9VRKmp8bVvnsbK/moJe8wy17v/y0Fk5HFAn6H?=
 =?us-ascii?Q?i9soE0ux7KW6aL1yG2SEjqyPRbdIpSfd6xlXfvgrR7iQUWy/312LdNf1i4Qa?=
 =?us-ascii?Q?rwnJBoVDqWFAmNGd/2CC5NdfOZlhwnTDnYFUNU+2y2G9jBMNWghA1a6ctpAJ?=
 =?us-ascii?Q?OB2kUvvOEVfK10ovDOk9oRNKPeEPbwlKOodA4fL7dNcX8uLiDrGCAaB+RrJC?=
 =?us-ascii?Q?FnABHs2NvD86Az3tH9OsGJ5y9HLl0qU5hPP0YEkCKXE8UkPqxXlFceTlKF5F?=
 =?us-ascii?Q?mdqMmfwXzrnDRFHp5/0C4g8mqQqbsyPkQig8IxXnwo7Y+rSQbGbrJ1Q9h26P?=
 =?us-ascii?Q?MM4oXbuQWtUtrptI1yaooZjk4IpTgCpkQxYr634UFDPR5Efe0DBBhdR6ASDc?=
 =?us-ascii?Q?d4yV8xjBNhaEUIZ4sZShJUI9/5tn4sMTPWjp28TLV2AgZnW1Mzzy1MMNAdIH?=
 =?us-ascii?Q?Bqmz4PkV4kkkk+Nx12oEirEGgsHL3aYYAE4SVAqHANdc311/Ry2LzPVIi5MO?=
 =?us-ascii?Q?jsC+18bg2iC+nuOtBZCSnKZ9Rr4UtSH7icW/axvSxe4lgrBp5tzkyyVcvc/M?=
 =?us-ascii?Q?097nHghLWi+QLzeW2LbjMhOo0/3yYBb7sfcSAgs3Hmf2SFQo9gom51QOCkrQ?=
 =?us-ascii?Q?ho7KYbeQD8R4RYl+/JZqclnd1xBscKF2JvCfuSCQJ27Whv8n2SWHfYzqVlr2?=
 =?us-ascii?Q?7USNIPl763XtKiCu49oWnzyJ55H8Ixq7+ThunNKQiDQnhU6mwvD/d7wUIvyX?=
 =?us-ascii?Q?C6jAT96ocv7GmN1VC/9gihsC93KR74Gmq4CPhe3OSvCFTBBiw0bCGH2iCSOc?=
 =?us-ascii?Q?1ljRi/EB+UfzI2ZtGABZuUbwDk35ImoCrcZNmOehJQNjgV3r8wOYOtx5qjiV?=
 =?us-ascii?Q?IgNCOWZJLW6sSRStQn88NfyKMNfllS9gxvlZVdHITDtB8ogRHNZNoB4CiPN4?=
 =?us-ascii?Q?RzIgbrCoQTT1SJcvyFgnkXV0SyHmcTGRU59aswR5+UXMnou8qIECCy0Z+BHK?=
 =?us-ascii?Q?iuhJn6kYX7uOd3zeR+9FaCSzFpdQ6Dfz2dIiynVocE/LpKqA4GVdzAvWBh+c?=
 =?us-ascii?Q?7sV9P0LcowWFC5DGOEU4x+UyqgYbIejz3+S3++ja9orlT7bzUEMakgwiFF3U?=
 =?us-ascii?Q?m3iUNiKiRKVmMCmqJSC74zbKUstiqEBa/naTrsRKz09adKWonhRd5uEJaTQD?=
 =?us-ascii?Q?YIp9LoF1i1RBCoi7cHcgfttC4P9ddbf2weIHeFEQWF9ytySGro6WkFaJm09f?=
 =?us-ascii?Q?lkUfVRYHW5+OwYi0++LIz/2dfBaQvV/I8KJ4uMOOyeOzD8MWujHFDwDyUHFJ?=
 =?us-ascii?Q?jGENh4zesi/RRLauSZj+hygFfqHSOBrnYQpEkVwtPvkmwucDxY7PGis29xT0?=
 =?us-ascii?Q?rQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d10fba2-24d3-43f7-c3a8-08d9daee22f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 01:50:57.2040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xRD1BoXwBURQToeNXTw19ehnlToLVHXgG+R18aNdKqwGo8WIFdwEcFNT2QaTxS1RABsdvKK+KOQEzdVkV7fnEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 2/2] arm64: dts: imx8qxp-ss-adma: Drop fsl,imx7ulp-lpuart
> comaptible
>=20
> The driver differs from clocks point of view, so the i.MX8QXP is not back=
wards
> compatible with i.MX7ULP.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
> b/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
> index dc1daa8dc72f..7bae516004bf 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
> @@ -5,19 +5,19 @@
>   */
>=20
>  &lpuart0 {
> -	compatible =3D "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> +	compatible =3D "fsl,imx8qxp-lpuart";
>  };
>=20
>  &lpuart1 {
> -	compatible =3D "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> +	compatible =3D "fsl,imx8qxp-lpuart";
>  };
>=20
>  &lpuart2 {
> -	compatible =3D "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> +	compatible =3D "fsl,imx8qxp-lpuart";
>  };
>=20
>  &lpuart3 {
> -	compatible =3D "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> +	compatible =3D "fsl,imx8qxp-lpuart";
>  };
>=20
>  &i2c0 {
> --
> 2.31.1

