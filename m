Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0191F5B21ED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiIHPWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiIHPV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:21:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D1D112B0F;
        Thu,  8 Sep 2022 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662650512; x=1694186512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9MdbEENqAM49WrtPPiqhC1XbCo+sIU0DKqM5kkWdNM4=;
  b=v62g1V0+Uf5j5qzxu5K3d5u9UdhFMZo39TR/MbDIKXACKna5Akjf2VOP
   Ok2mWJ0B6yjy9sxGHoQhYRv9ydJPXFZV1TS9bg37W8vC4QYf30EI6Ouuf
   ZiJzY5qlQAQOSy1if0ArqdwQ27xUXocxppDHac/S5+ohQohCbMgIiXAlD
   HYUBg0mqEz0aCBOxTVKnhAanQoZ6ZEBe4gkDniCeYgIJTm28BnFcbM46V
   xSA1USBsaFMAHfMKkpA8koY+sFaN7TsAq3IPSdc0tFClgjHxBEhVDK8bM
   JfR4lv1FItUfcGej5iiYMFKN9u1ETpCZVOsNqHVYXF0+l3mayhf2t6GQJ
   A==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="179592824"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 08:21:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 08:21:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 8 Sep 2022 08:21:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh5pzOhT7FOVDZH7ghNLEB34JCdHVwRtqrN5SjmmoDCt7vUgR5ttkoHpBznHK3mfAnigjDsVjQPio9TBznfVxrQouV1eDgUkFw5+hsXGOAPXVbgyE59jkZcvCHNAqEFbFD/DM05eFl2tKL81gwdGgJWP25/I/5Tmi+MX2NKFEzUoG7Qr1e+Z/OmRRzyz6zGIvKD+3NhAE2oILfCLEw6cuciVoqZxwFvCHAygqUQAs7JtzAk17hiVzLcykPl1Ylp8D4vU8+4Bcm9t5QVnbKVNEaPiFa2amkkLLh1Kx8iAfdhlUwIMhlqNKoRqc8Q0NHfr/beccjytw2F7XOoFZNQIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B5NMVW1WWfaA7F/Ju3BpZ0USJyzstJw4TxALwKZEVI=;
 b=IRaCE+gAyEvJW7AlXD2YJIA+YMChpXm2nycuwSzI7odf+ECCI3QzZEx3CWUahlO5anHrBCtKXtDBvA6M6wDu35Jvt9uGP/BMzr98+DssouWcZbHvH4H5WyrZ47tNws3dWNVix3exB3rFI7IWvW0M60eXch/YNfT1h2p7thJY8U5YT7ClTqCWWlsFk8HL+Xc06Al31/Hq+tbiCnVmeXkVZ7nEyw1tgIxtRAoiQQoEEH8HD3kqB+IxrQxx4pK3XYFtwI8geeG/Y1NH8gvOn2p1Vvc5ScrMzEaT8iYWGfkWOz5a1UBm6l+fZZFF+KB/iaP/rZyUqnssGVtezIwCIiYOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6B5NMVW1WWfaA7F/Ju3BpZ0USJyzstJw4TxALwKZEVI=;
 b=UCqMZz49Bn+xyakoypOvlDfaNxq74uS4xmTt42AZiTsn5iHltDPCLLayPSpcOdRDZWnziYBEJ27PimFFvFkl6ct7nShErkpSxo7KtcGudiN+bxHib8KsSmRh+l3MBoDdsUDxRBDhfExwEp2+hTcvRofhBZc51gM9+Mjx2eCdKfE=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BL0PR11MB3282.namprd11.prod.outlook.com (2603:10b6:208:6a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 15:21:45 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6982:4db0:989c:c097]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6982:4db0:989c:c097%9]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 15:21:45 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <lee@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <Kavyasree.Kotagiri@microchip.com>, <Claudiu.Beznea@microchip.com>
Subject: RE: [RESEND PATCH v9 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Topic: [RESEND PATCH v9 3/3] mfd: atmel-flexcom: Add support for
 lan966x flexcom chip-select configuration
Thread-Index: AQHYw5Tj+r+Ipvs67ESTns9FdHcC1a3Vpfvw
Date:   Thu, 8 Sep 2022 15:21:45 +0000
Message-ID: <SA2PR11MB48748FC1CD96E56B5C07513C92409@SA2PR11MB4874.namprd11.prod.outlook.com>
References: <20220908150658.1839520-1-kavyasree.kotagiri@microchip.com>
 <20220908150658.1839520-4-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220908150658.1839520-4-kavyasree.kotagiri@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4874:EE_|BL0PR11MB3282:EE_
x-ms-office365-filtering-correlation-id: 0ca49add-6678-4db7-b521-08da91add74e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dqbuyy+6PwTIbzW6sKWLRJOjTFin9fkt9xizdwoRQ6KMzGiEGjOkQPNkZitYKt71qX1V88BuO9cqzMysmaFVoMkTJizI8MAwG/OfZw8X69HhNhHpBZgl4/HEG4Jwk+Mlx70gRNZgY1VJ5O26fkuujkRNgaNBwqeEghL4+kTNtcFG0EExzX27HhBe6gZ91oPGoeRNBrjF5qqJP3ast4dWNp7BMMKN9kNHupXEkQXITRbmF103ZoVrZmgv9a6artIX4ACYRC4ScqdQTjmxo9OcGAWQoHCInfXnTMIW3MdFFmTwJ6SCjvfcE4HYsOo6SxcFB5Z2DoVV0IJHQAjfQxmNrzBexRX9oRiL0Mc7V9QeNUm8VChOZVj2Y5sgExnWpTqUYbu4gymluI7/JGO42bNByMws8iW2ReaRx3k2CxoWFhrQHjqbUk9C1ZyrSc4NMAH35SgQEO7W/HSmqevr2pXZNNWx8Uojmnz3+QxVsnKVZfOUWWvfrakblzGPWZ1jZrfgaMVbIJJ034r2L98iqSlhNalX3s0oeCxefOnlnt0bSS4JBV0QZFmJvoGhUEOVAaM5eVh2ZVpFrdVPwYmE7rwEh/vtUOV0zWs4HeY2NXLnT08Sh+JGn9e3YAd03qTe9iev+8tIBtnaAZUyh1agDUyuwQX7SFXXK4302dJgkYSXw77bYDO1NhCWCm9bNJ1zRH3Mmg9pRXX/20+Pt4aCGAMD49LU8SWlsCZBYcS5dlWqa1bvva04ao3p6SJNlaja5rZeZB53LqeqDlnF7Ti35jEmCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(376002)(366004)(396003)(55016003)(38070700005)(38100700002)(122000001)(316002)(6916009)(54906003)(71200400001)(5660300002)(52536014)(8936002)(8676002)(76116006)(64756008)(66946007)(2906002)(4326008)(66556008)(66476007)(66446008)(186003)(83380400001)(41300700001)(6506007)(478600001)(107886003)(9686003)(86362001)(33656002)(26005)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?erllnwqq7IvyZfl6/vjlYSDo+jgzvyl9nOZcN15nXQPGO3paidefd9agxzys?=
 =?us-ascii?Q?YUdyYlTXFKd7Xc89Mt5JneTLnYU8vQORiHtpdBkkQN7M5TIKgTwPgkg2rBJR?=
 =?us-ascii?Q?vchZdmEvDQPh3bGzIiT8yhK0BuQpwZvj2yD7Fx8yoErxGoLm7oQOrJKNrlSS?=
 =?us-ascii?Q?oml5EpDhP8XhB87a7/DzeVBUMq6E+s4soB9S/iaZE+BvLzUU5IHgODcXzszO?=
 =?us-ascii?Q?+gtOxS6uVxPr1/9E9ejb2QPqqj4TCsdzDPGlDpjniKsPA7Qlm2cfPHzX9cf1?=
 =?us-ascii?Q?rzdfC8QuN9CidGlIppYDLtDp2vwMAAvvSfiu5LuRuqawUJ6dwt3SzCv4Iucb?=
 =?us-ascii?Q?bCmsr1MJ6Aob45n4svUsww07hShRv8HQZWULsBevDciFv9/925vrPcSRki3k?=
 =?us-ascii?Q?6F/pLzb3OUqK68ONZ7sgwTd8jFGmiWtQiLjTZo9l09MB70kG8DUay/dAGc0L?=
 =?us-ascii?Q?iUWjFnbMq7sOxVaQIcEaEA47Yip4rjto7UYKSbkRc3ufXwKjUjHctrf5HolT?=
 =?us-ascii?Q?BJNgHZgMwtiJIhC0C+oG9zdmdf5rZ+N24I1WZBfYJS8XIz0P0jXDIbX91rqW?=
 =?us-ascii?Q?L4JdMixE6DvHcHyZwqLjarH7in8Sxqf++USGHSAP3l61yS0pe7qOSZwEryXc?=
 =?us-ascii?Q?Y023WAkxe1ESdAGFLWjTyjteqZFsdCafjCUNPlT/TnFqxQc6+hnKuoMTxzDB?=
 =?us-ascii?Q?2s0QwqNRK0PMVkMjaXWEgbClqBXO1WQC/YpyYLG1dW+/BqxoQZ3zCVEOx3T+?=
 =?us-ascii?Q?dR9GubxWsU1b9FwNFg6eVIC7JuMfHfRDSQ9jdaqZDXB0qg95HJUzZBiuX2Kx?=
 =?us-ascii?Q?aW3OZB/Lu/hLtKTZ7cLjh8FMeMYmD0D+tH1a1eWCyM5kUygPchDdOKSLbYyn?=
 =?us-ascii?Q?UoH+YgDCw3q/L0THcZY/Wx0b4h2pIhHwhxSFlNtVkFCys7a7eu5yowF2fR4Z?=
 =?us-ascii?Q?bL8C/lTc82T5RR4aIlnXEQTUwZi7Mpx+BlnDS8pzfsoUYt2T3F+CBfxVUIc8?=
 =?us-ascii?Q?5J3v/YN/6lP5QPoK/GurMElgvOMcaC1/UelQPYuaVnpo6NZuKEFSiBWTc4rZ?=
 =?us-ascii?Q?BHXzOYtxctytpBmhyavZWuWZlrnGkKQDpRMGhRZZUqP5cfc+koKNPnPgfE31?=
 =?us-ascii?Q?YuLYD7KE6TIIPUbdDaa6/z93OudEMg0z1cjfpZzMIKGFfVBdurPyPL1ms8gx?=
 =?us-ascii?Q?cV3Eda8IcLwOIEinKBa/30wLv3oLWADKR3miGxlKNW6nW2iA0im8ak6mcbo0?=
 =?us-ascii?Q?OjieHi6Fvet36APJhlWAmGJNXtR+uIPkKxK59H7nefhmp97s83ezBILbakl/?=
 =?us-ascii?Q?ZG3IyhDgcWgqHQvyy+xOipDFES9yEl6ctDZLEYuSSIM3uXcS52UhBvySBdXu?=
 =?us-ascii?Q?Qky15O7zBJEMn3gVpmbDXdFa1iO7KFUkfMVdYA1jW2Y4L9rx0oL+9bO8jbqv?=
 =?us-ascii?Q?3l0ne+nTREbw78Ja/SSWLlNSIdVqZtN8aM4GlU1TNy5ukOeOAwu0RRAjORDT?=
 =?us-ascii?Q?jsptWomvYP6BSH0y6EeppXxqAdgJx/thL+s8ISRg4f0yIDDIjU8rkeRAKHsy?=
 =?us-ascii?Q?ZN1V19tcMF5zMqavzyUlgBLOJ060xOHB7wmC1Q0YJRSgn0HzAziLIFuMWlem?=
 =?us-ascii?Q?/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca49add-6678-4db7-b521-08da91add74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 15:21:45.3350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFiQgNr2IdvaQQ1lFOxjkpkZWKVOWnRhMhzmkLlSyg8CB5Id/WnVAxO1SO20WUaHhWnWGnCAx2xYVVloh/YBiiXtqquauYK0tDKasIX1pORpbEbCp9Koax0K2w0ln7h8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3282
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [RESEND PATCH v9 3/3] mfd: atmel-flexcom: Add support for
> lan966x flexcom chip-select configuration
>=20
> LAN966x SoC have 5 flexcoms. Each flexcom has 2 chip-selects
> which are optional I/O lines. For each chip select of each
> flexcom there is a configuration register FLEXCOM_SHARED[0-4]:SS_MASK[0-
> 1].
> The width of configuration register is 21 because there are
> 21 shared pins on each of which the chip select can be mapped.
> Each bit of the register represents a different FLEXCOM_SHARED pin.
>=20
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>

Missed adding tag - Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.c=
om>

> ---
> v8 -> v9:
>  - No changes.
>=20
> v7 -> v8:
>  - Changed compatible string to microchip,lan9668-flexcom.
>=20
> v6 -> v7:
>  - No changes.
>=20
> v5 -> v6:
>  - No changes.
>=20
> v4 -> v5:
>  - No changes.
>=20
> v3 -> v4:
>  - Add condition for a flexcom whether to configure chip-select lines
>    or not, based on "microchip,flx-shrd-pins" property existence because
>    chip-select lines are optional.
>=20
> v2 -> v3:
>  - used goto label for clk_disable in error cases.
>=20
> v1 -> v2:
>  - use GENMASK for mask, macros for maximum allowed values.
>  - use u32 values for flexcom chipselects instead of strings.
>  - disable clock in case of errors.
>=20
>  drivers/mfd/atmel-flexcom.c | 94
> ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 93 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
> index 33caa4fba6af..92ea15d5fd72 100644
> --- a/drivers/mfd/atmel-flexcom.c
> +++ b/drivers/mfd/atmel-flexcom.c
> @@ -28,15 +28,68 @@
>  #define FLEX_MR_OPMODE(opmode)	(((opmode) <<
> FLEX_MR_OPMODE_OFFSET) &	\
>  				 FLEX_MR_OPMODE_MASK)
>=20
> +/* LAN966x flexcom shared register offsets */
> +#define FLEX_SHRD_SS_MASK_0	0x0
> +#define FLEX_SHRD_SS_MASK_1	0x4
> +#define FLEX_SHRD_PIN_MAX	20
> +#define FLEX_CS_MAX		1
> +#define FLEX_SHRD_MASK		GENMASK(20, 0)
> +
> +struct atmel_flex_caps {
> +	bool has_flx_cs;
> +};
> +
>  struct atmel_flexcom {
>  	void __iomem *base;
> +	void __iomem *flexcom_shared_base;
>  	u32 opmode;
>  	struct clk *clk;
>  };
>=20
> +static int atmel_flexcom_lan966x_cs_config(struct platform_device *pdev)
> +{
> +	struct atmel_flexcom *ddata =3D dev_get_drvdata(&pdev->dev);
> +	struct device_node *np =3D pdev->dev.of_node;
> +	u32 flx_shrd_pins[2], flx_cs[2], val;
> +	int err, i, count;
> +
> +	count =3D of_property_count_u32_elems(np, "microchip,flx-shrd-
> pins");
> +	if (count <=3D 0 || count > 2) {
> +		dev_err(&pdev->dev, "Invalid %s property (%d)\n", "flx-shrd-
> pins",
> +				count);
> +		return -EINVAL;
> +	}
> +
> +	err =3D of_property_read_u32_array(np, "microchip,flx-shrd-pins",
> flx_shrd_pins, count);
> +	if (err)
> +		return err;
> +
> +	err =3D of_property_read_u32_array(np, "microchip,flx-cs", flx_cs,
> count);
> +	if (err)
> +		return err;
> +
> +	for (i =3D 0; i < count; i++) {
> +		if (flx_shrd_pins[i] > FLEX_SHRD_PIN_MAX)
> +			return -EINVAL;
> +
> +		if (flx_cs[i] > FLEX_CS_MAX)
> +			return -EINVAL;
> +
> +		val =3D ~(1 << flx_shrd_pins[i]) & FLEX_SHRD_MASK;
> +
> +		if (flx_cs[i] =3D=3D 0)
> +			writel(val, ddata->flexcom_shared_base +
> FLEX_SHRD_SS_MASK_0);
> +		else
> +			writel(val, ddata->flexcom_shared_base +
> FLEX_SHRD_SS_MASK_1);
> +	}
> +
> +	return 0;
> +}
> +
>  static int atmel_flexcom_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np =3D pdev->dev.of_node;
> +	const struct atmel_flex_caps *caps;
>  	struct resource *res;
>  	struct atmel_flexcom *ddata;
>  	int err;
> @@ -76,13 +129,52 @@ static int atmel_flexcom_probe(struct
> platform_device *pdev)
>  	 */
>  	writel(FLEX_MR_OPMODE(ddata->opmode), ddata->base +
> FLEX_MR);
>=20
> +	caps =3D of_device_get_match_data(&pdev->dev);
> +	if (!caps) {
> +		dev_err(&pdev->dev, "Could not retrieve flexcom caps\n");
> +		err =3D -EINVAL;
> +		goto clk_disable;
> +	}
> +
> +	if (caps->has_flx_cs && of_property_read_bool(np, "microchip,flx-
> shrd-pins")) {
> +		ddata->flexcom_shared_base =3D
> devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
> +		if (IS_ERR(ddata->flexcom_shared_base)) {
> +			err =3D dev_err_probe(&pdev->dev,
> +					PTR_ERR(ddata-
> >flexcom_shared_base),
> +					"failed to get flexcom shared base
> address\n");
> +			goto clk_disable;
> +		}
> +
> +		err =3D atmel_flexcom_lan966x_cs_config(pdev);
> +		if (err)
> +			goto clk_disable;
> +	}
> +
> +clk_disable:
>  	clk_disable_unprepare(ddata->clk);
> +	if (err)
> +		return err;
>=20
>  	return devm_of_platform_populate(&pdev->dev);
>  }
>=20
> +static const struct atmel_flex_caps atmel_flexcom_caps =3D {};
> +
> +static const struct atmel_flex_caps lan966x_flexcom_caps =3D {
> +	.has_flx_cs =3D true,
> +};
> +
>  static const struct of_device_id atmel_flexcom_of_match[] =3D {
> -	{ .compatible =3D "atmel,sama5d2-flexcom" },
> +	{
> +		.compatible =3D "atmel,sama5d2-flexcom",
> +		.data =3D &atmel_flexcom_caps,
> +	},
> +
> +	{
> +		.compatible =3D "microchip,lan9668-flexcom",
> +		.data =3D &lan966x_flexcom_caps,
> +	},
> +
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
> --
> 2.25.1

