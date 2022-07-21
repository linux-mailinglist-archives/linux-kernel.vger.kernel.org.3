Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C8357C42A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiGUGIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGUGIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:08:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DEF7AC29;
        Wed, 20 Jul 2022 23:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658383731; x=1689919731;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Se3f4J+MSPa2+jZljuhDztkrG++pSwCoNzijaormp+4=;
  b=IObcMj9Cx/NBvUPsLsLH+gfCH+9AUMLsEzdckQUvOtPcZzCKLYhIl8E3
   L1MhOqLgvQJcU8AasXaIpPfu1q8k+HjH79J2BBtRVzIrZ2cRrrdy4VfPx
   g0dD8QR4oTtf8WoZyUAgWCBmCsQB8ok0zfrCKYvRPkZN+T2wxDl0TSM3K
   XAydGmD5nypi0cISSaVt5glJy+HFPZKi7J7lmCpK4m70VR1ecj4j8mPU5
   Eve1p7z1VWM87F4z9l+1teNuYUrIoJFPUWROUYfQ0g1VzWbuDfBGqJDlu
   tUtZoyWwW7E34BbFPINSmv5Vq1t36JnfgUBZCw/0N/xy1UkGr7/q5evCS
   A==;
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="173209107"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2022 23:08:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Jul 2022 23:08:49 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 20 Jul 2022 23:08:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPLX5s3Oje7kbe9YUhkAYtF4TG1WkkN0xxghTkKSncYXy90y/LBoCoIzKfLOKn/dU4LMU6DUwXl4Ih77W19qk1Dw86c/jHHnBy+LxCGAhngLLGSYoUUdpg3//9Y+7V6DjVelyp+DisxRccP65M5Ql5eTeas6i2+VapQaR2d1jG0gFhm4zMHlvr0WRDeyAQovXu//E+LnfkQxzboAc197roHBQmrddIyeABH5xC1RGnNK/gaTWtk1MdkvAHp6OncicXE/1sr0zXFI6QW3KZizAuZynJpHS+yQR4045UphAvat0x0XNN8YfcXvwUMImWI3g8YI4uXqcmwvkVMuUg9oPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5CwPtgyVX57lk2Mndy6kSxuEpUvhvJVXQCzxFUAev8=;
 b=eRq0tNRNsbAd4+07meG7FfcC2YD+cMVF+Df6vnmlP0eaIBRdp4UIrPpOb6ZIsz1Y9q9UmwvfPWs/Joz50+EH0dot8JZH8UxxP3n57sAQxorDvbbCLZUmDRhQJMK0TFAZdAVsNVPwbT/VX+gdQ8YalNKv1StS6pCnrgev8ZT0mue9ma4Eso3x3BIIyZQND+0KN0V0oED4qFBH4biiZATf6uVBeVVAPYsTAMU+AaIpXK93tnJ0vtjqqbSWdQ7KMZtZg4BwbVzxFi9lLwzwvyGMOy8HTcgRg+phm9YmLQCMPn19foxWNrZWYaa0j1U5L1wUvPTM0ZjGGr2IBxPaXNvHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5CwPtgyVX57lk2Mndy6kSxuEpUvhvJVXQCzxFUAev8=;
 b=IQoU1z0YgKjzy+2isHhNhpZP7FJ19qkDamCsRPi26Rknamtjwoz0YBARekBn+AQVDpzbk6TowQr1u5QWFgBG22p+pVbVSD1sScsiCoUEMJ96DSw2BW7ahu/F2iUCE6wVUxXPCPA8W4S+Cpi1tiBzmY++Grg9HdD1uQKAophaYO4=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by CY4PR11MB1736.namprd11.prod.outlook.com (2603:10b6:903:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Thu, 21 Jul
 2022 06:08:47 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::b82d:23c3:ea1:a5fa]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::b82d:23c3:ea1:a5fa%7]) with mapi id 15.20.5438.024; Thu, 21 Jul 2022
 06:08:46 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <Horatiu.Vultur@microchip.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <UNGLinuxDriver@microchip.com>,
        <maxime.chevallier@bootlin.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] ARM: dts: lan966x: add support for pcb8309
Thread-Topic: [PATCH 2/2] ARM: dts: lan966x: add support for pcb8309
Thread-Index: AQHYnHFivQ+9+83cwEOVN6Agi6GAea2IVJeg
Date:   Thu, 21 Jul 2022 06:08:46 +0000
Message-ID: <CO1PR11MB4865A1118ACB74B06408BBC792919@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220720194904.2025384-1-horatiu.vultur@microchip.com>
 <20220720194904.2025384-3-horatiu.vultur@microchip.com>
In-Reply-To: <20220720194904.2025384-3-horatiu.vultur@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05e1d481-f432-4646-db36-08da6adf7928
x-ms-traffictypediagnostic: CY4PR11MB1736:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FfHsNqk5UBsLph18UGryE+Ij6iOUdjjcWmzC1yHpX4i/g0Rra9hTiXRrmcv6fjY+8zqF6+7JkFxlTy6+CpJVtu7/CP8uUjGM8IKIxqtCVqrVQV/E90AhZCejX97cTRtj2VjIkmUhixE2jLmkfqpCiscAdDyf1MRbE3PPZ0nXF0PpZoY4VkldyYU9HjGYCCcPSnnk+Jf8mWCLLViSFwiVKm2sdbr6uobiD4I/rYSrc97l/qi7uEBhf7XHue0RnMirbjF/esvo6dzuzKu4WNnzGPK+spyFSM5PEroQ82Q07OYHW5MBMAUYdqYq3VpvV4Ws6GpxcYOvGa4ScCDZe5+KJZMQOV3X18O6B5Epho73EdzPidwJdogKSp64l6faYZNg2m9V1Fyo5TJyIJeCJjFucocCiQBE5aJFS42TDRgmkWw7cvqHaAHU9m2k2j3pg4COn/vo8r/PpZsRa1zQsyzfnIj9o7VPP8lK628IEu+EUV97hU2au584dMeMIi9vO5JBTrpUEDkJNAFFGv6pmk8QIynbdaeqrhaevwbb12qkdf4hlv1mM872AkS6i/Y6eM7FGKcPbwuivTwtzAql7W8Yx3Josj0Qc6s37xqwrDWPJhp4W5Nek64fGPIfeUzI8cXoUV+eiHYh9j0zcKZzOThdV4OL+rxHBTP2iE/3qGX9L5TlIGedSfg8pP5r7l/HXDXykUa1bl/z3VRBh+2c5RUoRr9s6osOKDt7i9PY0wmTvg7eDvoVDHJfVIGuj2H7+1JAywUUbI01BQ6bKEu2izHMtmDQfaLWJcbPAt7ZI0D+eeI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(39860400002)(366004)(136003)(64756008)(66476007)(66946007)(4326008)(38100700002)(8676002)(5660300002)(55016003)(76116006)(52536014)(478600001)(8936002)(7416002)(66446008)(6862004)(66556008)(83380400001)(186003)(9686003)(316002)(7696005)(54906003)(6506007)(86362001)(122000001)(33656002)(6636002)(26005)(41300700001)(2906002)(38070700005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SpTqwE2GjatjFmz0CVoBrznSzw/EeYSZeBkUzBODRk1VYTszrcYbmty06sfz?=
 =?us-ascii?Q?eRcfLmHhrfEIeRlOUg4UrpimJxY5bSbOM6tAZyoNqvPuugwQTn2/8oUZmfO1?=
 =?us-ascii?Q?wIC8nI8nfEb0rpaSJk3GQkGgdw9rFmogum9IgJgQHD64MXYqRBtGzfaEE7Rt?=
 =?us-ascii?Q?zc0deJYZqhWUs7c7Js9acUo+x4bue5e+YNUguSq/Ap2mcd9hl8ZQbKnpw2e2?=
 =?us-ascii?Q?mYnfcJZm0Gb0szJdYLhwPeRBfnm6ODknah3u5R+3zWG7+45KYrtHtsgqoTd2?=
 =?us-ascii?Q?QaJLMtSZAOfL3BZbAAWEwKRtoYWT4Kik4tQNftGvkOpk7IZdAafzftUmDR2r?=
 =?us-ascii?Q?LQHtJ5oNn4OSuFonoJlyLbicSTC7wETOOpM6GPE0qPox+r3+bmfXRP3wxSr4?=
 =?us-ascii?Q?XQFioo5TYpFgmyYeauHIo52uZAYb1iVHVN3l//x4jrkJFyOQdG7qDZXGtJb+?=
 =?us-ascii?Q?OS9Wl2S7AocBmphsN9cQV5BuNFhNqC/HxuMYx9Qy7CMUHjJsdkFkE3ypdvAS?=
 =?us-ascii?Q?jQwI/PlVZvKBW28FV6iQwCS0v0Le2o018ztQYzBtLMRBPc08pKbpb45SAcmL?=
 =?us-ascii?Q?YwcmSO2lV3lp8uBKaZbsyVYBRIow89ReOA0iljks2Q4gSoyDIlRWe1CAtgfX?=
 =?us-ascii?Q?fBl1CNHNJRAwNpBZ15QPpsXRiYJZckt2CYFf5Ky7WIQL4bO69c0RIXmo9BRC?=
 =?us-ascii?Q?vNjFmf/HRplMBfkEcIhqLMdXcSPZv25EP2+Zu/bJYih5KoEdqPzy60yYpNqv?=
 =?us-ascii?Q?2nD0xrrpYsTiETNiVN1gBsTh0RNwteXFoLD/uPko5ukAW/ZRJJICaIJRvw2w?=
 =?us-ascii?Q?l39yofGMnd8aCm+gOWD1j/+txPs9Zn9I7QR/XPiglg9kryRsTYdSC81XdEL+?=
 =?us-ascii?Q?vyS3bayevq0wDcXqht6t1U04VI/uPg2nP/lI92rsXvUqNujgN5F0KzwWMUzg?=
 =?us-ascii?Q?skU2JA8BLtmUDl6knTXWV4IFaEuYsX0kNpeyd+uVteZ6BoLQ/Ve1V9xfci/Q?=
 =?us-ascii?Q?rn4X5Dk+VI2/QMZ6az9fLmax3CDOwSPxbOTREmVJYvkIlXsH0dWH9asjC41H?=
 =?us-ascii?Q?p3Zp2vVnNiIQ9Fv6d3zv8V16mmyoW+LQ9rUUw93GkiLQA6Yb02V3fFUnSM7w?=
 =?us-ascii?Q?D+SyH04uqD5nhH7ZCFjglGXN49ejaSWBqJRgCKPlxlxyjVXW7molRPRIH3Xl?=
 =?us-ascii?Q?M3T2UtYKNCm3BGIEgAJ0BjcJlvVFHV9dpo/qsyu+u11m9d87D8HXV/uMhnMZ?=
 =?us-ascii?Q?d1lVIF9ZFo2j1y8uJMCZYYAgveyXuatr2HOhKqCLSlRWlzz+diIzduKeNiqh?=
 =?us-ascii?Q?OeB2RjcmPf0rVWnl4HLhDK52Gk0+4CPUCcUQucrEq7xRAZ9UYN7UigpUlfue?=
 =?us-ascii?Q?jo6yanIh8Ncu2odWunA+HARMbzBZzpwAfKyeJU8oQRvJ7z4hG2YcB/cYeRrW?=
 =?us-ascii?Q?hrHro/SLmEMJ9UV1BHOh3gnWa2pVoKLqBfd0CvWDxjxnd3Bws0vhmcG5apAl?=
 =?us-ascii?Q?qUYvDUvIHDGPzTrSa0LF0GO71erlPUWMi9AwlXpj7bt+cos7piLy9pzLCW7y?=
 =?us-ascii?Q?ssl1vDo/hjKwssFiu1dO2bniVNCk+mF5febHBq+l4FPfF1+QKIqIDCA8PD4r?=
 =?us-ascii?Q?ZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e1d481-f432-4646-db36-08da6adf7928
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 06:08:46.9161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dT/3d0quKm7z/RMNQRn8Hi46UCgsBcFx5I/fS0W9Wl66obnlbdJnhnRUFv1NfnX+0leTSsd9tWhYcMt4ZPp8SM6bxgZeGJCLLIlivJPVw4b9q0JPbNnVv4jXF9q6uM5I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1736
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add basic support for pcb8309. It is similar with pcb8291 with one big
> difference that is having 2 SFP cages. Therefore it has 4 network ports.
>=20
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  arch/arm/boot/dts/Makefile            |   3 +-
>  arch/arm/boot/dts/lan966x-pcb8309.dts | 189
> ++++++++++++++++++++++++++
>  2 files changed, 191 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/lan966x-pcb8309.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 184899808ee7..6a6166e3a405 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -772,7 +772,8 @@ dtb-$(CONFIG_SOC_IMXRT) +=3D \
>  dtb-$(CONFIG_SOC_LAN966) +=3D \
>  	lan966x-pcb8291.dtb \
>  	lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb \
> -	lan966x-kontron-kswitch-d10-mmt-8g.dtb
> +	lan966x-kontron-kswitch-d10-mmt-8g.dtb \
> +	lan966x-pcb8309.dtb
>  dtb-$(CONFIG_SOC_LS1021A) +=3D \
>  	ls1021a-iot.dtb \
>  	ls1021a-moxa-uc-8410a.dtb \
> diff --git a/arch/arm/boot/dts/lan966x-pcb8309.dts
> b/arch/arm/boot/dts/lan966x-pcb8309.dts
> new file mode 100644
> index 000000000000..ef441195e8c1
> --- /dev/null
> +++ b/arch/arm/boot/dts/lan966x-pcb8309.dts
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * lan966x_pcb8309.dts - Device Tree file for PCB8309
> + */
> +/dts-v1/;
> +#include "lan966x.dtsi"
> +#include "dt-bindings/phy/phy-lan966x-serdes.h"
> +
> +/ {
> +	model =3D "Microchip EVB - LAN9662";
> +	compatible =3D "microchip,lan9662-pcb8309", "microchip,lan9662",
> "microchip,lan966";
> +
> +	aliases {
> +		serial0 =3D &usart3;
> +		i2c102 =3D &i2c102;
> +		i2c103 =3D &i2c103;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	gpio-restart {
> +		compatible =3D "gpio-restart";
> +		gpios =3D <&gpio 56 GPIO_ACTIVE_LOW>;
> +		priority =3D <200>;
> +	};
> +
> +	i2c-mux {
> +		compatible =3D "i2c-mux";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		mux-controls =3D <&mux>;
> +		i2c-parent =3D <&i2c4>;
> +
> +		i2c102: i2c-sfp@1 {
> +			reg =3D <1>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;

Why do you need #address-cells and #size-cells here?
> +		};
> +
> +		i2c103: i2c-sfp@2 {
> +			reg =3D <2>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
Same here
> +		};
> +	};
> +
> +	mux: mux-controller {
> +		compatible =3D "gpio-mux";
> +		#mux-control-cells =3D <0>;
> +
> +		mux-gpios =3D <&sgpio_out 11 0 GPIO_ACTIVE_HIGH>, /*
> p11b0 */
> +			    <&sgpio_out 11 1 GPIO_ACTIVE_HIGH>; /* p11b1
> */
> +	};
> +
> +	sfp2: sfp2 {
> +		compatible =3D "sff,sfp";
> +		i2c-bus =3D <&i2c102>;
> +		tx-disable-gpios =3D <&sgpio_out 10 0 GPIO_ACTIVE_LOW>;
> +		los-gpios =3D <&sgpio_in  2 0 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpios =3D <&sgpio_in  2 1 GPIO_ACTIVE_LOW>;
> +		tx-fault-gpios =3D <&sgpio_in  1 0 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	sfp3: sfp3 {
> +		compatible =3D "sff,sfp";
> +		i2c-bus =3D <&i2c103>;
> +		tx-disable-gpios =3D <&sgpio_out 10 1 GPIO_ACTIVE_LOW>;
> +		los-gpios =3D <&sgpio_in  3 0 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpios =3D <&sgpio_in  3 1 GPIO_ACTIVE_LOW>;
> +		tx-fault-gpios =3D <&sgpio_in  1 1 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&flx3 {
> +	atmel,flexcom-mode =3D <ATMEL_FLEXCOM_MODE_USART>;
> +	status =3D "okay";
> +
> +	usart3: serial@200 {
> +		pinctrl-0 =3D <&fc3_b_pins>;
> +		pinctrl-names =3D "default";
> +		status =3D "okay";
> +	};
> +};
> +
> +&flx4 {
> +	atmel,flexcom-mode =3D <ATMEL_FLEXCOM_MODE_TWI>;
> +	status =3D "okay";
> +};
> +
> +&gpio {
> +	fc3_b_pins: fc3-b-pins {
> +		/* RXD, TXD */
> +		pins =3D "GPIO_52", "GPIO_53";
> +		function =3D "fc3_b";
> +	};
> +
> +	fc4_b_pins: fc4-b-pins {
> +		/* SCL, SDA */
> +		pins =3D "GPIO_57", "GPIO_58";
> +		function =3D "fc4_b";
> +	};
> +
> +	sgpio_a_pins: sgpio-a-pins {
> +		/* SCK, D0, D1, LD */
> +		pins =3D "GPIO_32", "GPIO_33", "GPIO_34", "GPIO_35";
> +		function =3D "sgpio_a";
> +	};
> +};
> +
> +&i2c4 {
> +	compatible =3D "microchip,sam9x60-i2c";
> +	reg =3D <0x600 0x200>;
> +	interrupts =3D <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;

Same here=20

> +	clocks =3D <&nic_clk>;
> +	pinctrl-0 =3D <&fc4_b_pins>;
> +	pinctrl-names =3D "default";
> +	i2c-analog-filter;
> +	i2c-digital-filter;
> +	i2c-digital-filter-width-ns =3D <35>;
> +	i2c-sda-hold-time-ns =3D <1500>;
> +	status =3D "okay";
> +};
> +
> +&mdio1 {
> +	status =3D "okay";
> +};
> +
> +&phy0 {
> +	status =3D "okay";
> +};
> +
> +&phy1 {
> +	status =3D "okay";
> +};
> +
> +&port0 {
> +	status =3D "okay";
> +	phy-handle =3D <&phy0>;
> +	phy-mode =3D "gmii";
> +	phys =3D <&serdes 0 CU(0)>;
> +};
> +
> +&port1 {
> +	status =3D "okay";
> +	phy-handle =3D <&phy1>;
> +	phy-mode =3D "gmii";
> +	phys =3D <&serdes 1 CU(1)>;
> +};
> +
> +&port2 {
> +	status =3D "okay";
> +	sfp =3D <&sfp2>;
> +	managed =3D "in-band-status";
> +	phy-mode =3D "sgmii";
> +	phys =3D <&serdes 2 SERDES6G(0)>;
> +};
> +
> +&port3 {
> +	status =3D "okay";
> +	sfp =3D <&sfp3>;
> +	managed =3D "in-band-status";
> +	phy-mode =3D "sgmii";
> +	phys =3D <&serdes 3 SERDES6G(1)>;
> +};
> +
> +&serdes {
> +	status =3D "okay";
> +};
> +
> +&sgpio {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&sgpio_a_pins>;
> +	pinctrl-names =3D "default";
> +	microchip,sgpio-port-ranges =3D <0 3>, <8 11>;
> +	gpio@0 {
> +		ngpios =3D <64>;
> +	};
> +	gpio@1 {
> +		ngpios =3D <64>;
> +	};
> +};
> +
> +&switch {
> +	status =3D "okay";
> +};
> --
> 2.33.0

