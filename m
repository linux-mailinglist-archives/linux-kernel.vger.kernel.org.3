Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB280524512
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349965AbiELFfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349953AbiELFfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:35:50 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2107.outbound.protection.outlook.com [40.107.113.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188DB19C02;
        Wed, 11 May 2022 22:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fp25cHX7nAwUlNcJSLzx+TsEGCSboxWvP/cKeigodqTRCYKaa8svSFJ6tsKEex0yiHEvcDcnG/RM5KacCgElTzKxs0h+XoN3F5XS5uMT6NxG8+ik+iqyn8AmAUbkeEtTeEFaQlycQfiNhaut2oc2iVRRpdblnU1mHFv4boD8OLAN0/YX/hw73Zt6g7xhXWOmgZbzMV8gyW1hjs1AdVEuADqpAtSCpVdDEoVzbMfIhN2rxbh74Av60Q7Aw9uOLmY2Rg7ayohI/Eb5rUy1m3GHjo4MNU4i12wZFYbfw3mgFxfdxgSKoOvI6GmekP5+76lVYN0VsM4bRvT3zhTUTE2jRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHa+2VCxJwBtdp155QppxqElYaV10eP+gxpzp+iDVsU=;
 b=MMV3NsakYnth3fVggpI1Ib/loXqkyaEnROA7cVU7J5yYE+TlR62eVhJwqvkJDdPHuSb9+fxjZk3JeZ1X7mvnym44drvcWqOU6NabIUCB+/o1eM+vfjTDreFniBsd1kjptg4Qh97gPEO3gKvZB5tw/bd/LQJHUtwQ8LNXls7qe+cZ1S5rD0Mb7/CWelsbHjSLQYzwzXVMJPjxFASZRH3qltGK0V+YneTLhlvNYoLKyeohmMQKBa4M7ca1HaWpVm89MfG9iOL7t1wENSXEpi1NfrMHWNTfVZ1LS7cRdr5ICpDuGrpBcpyoBY8HcuqyUgKPWetQTA/dvBW8DQR4XYH8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHa+2VCxJwBtdp155QppxqElYaV10eP+gxpzp+iDVsU=;
 b=bk0C90652g3a9i0WP9SWpj78K8yGWmA/XkQ2RUGkSSF7EjoooosQmkl6jAnKA4PC9Ps1V1Ykdujn96vpOFcbqXf4CHlrO7o0S5iT6aBKaXXce/NAAAzBYk8y828dOOytEtDEuAqguZy1vGIV5zPrM6sn/qiNJTyPMaZ1SHT7Hms=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYYPR01MB6779.jpnprd01.prod.outlook.com (2603:1096:400:ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Thu, 12 May
 2022 05:35:45 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 05:35:45 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
Thread-Topic: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain
 to handle GPIO interrupt
Thread-Index: AQHYZWWEBd/euhXmSkarEpD10nkci60auG0w
Date:   Thu, 12 May 2022 05:35:45 +0000
Message-ID: <OS0PR01MB59221ADFC86483FE2C8765C486CB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f64c447-f721-4ff7-b39f-08da33d9434c
x-ms-traffictypediagnostic: TYYPR01MB6779:EE_
x-microsoft-antispam-prvs: <TYYPR01MB67794A567ED88E68B10DDA6C86CB9@TYYPR01MB6779.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 51t5tLnyCyJ//eDALoeDqCyATuzQOh1euG20Ezouq/QpzEfGa0O8oXuE/Om8XbdkXRG2kJGYBirrFAjsnbAvn3+8HZGnzbM9+HKYH6kbLR4F/EG47KkK5U0Ms8D/pqtIJupt5TEXFHLD9BzuEqebUay2bb9LMLfSY+pBLjIFJy24Zr8+eSivhkbssd1bdWhkfHKP16CfaaTdw8Nnnd7nA82aJZ1bJFtB6nnFFXqfeI6pXw1wVL3Q6beljaTR7VHEjmDNJKt4B+z2PnqPBD98Oe1kfFoFaUjKm+f87mYBY94jyBzmneJlNKBG0w3FlXQzonC5jDGZvmxzojVzUjdKn6jgQGkpq4hXmQxJXDv4YqV5C6Y8dM5R57BrD6kMhhUi66twDXcz5O1V6IZ58WPS0hTF4ea/08HJ99TKVsLPZ83mb0/L35IfLpV2fWFrsCazK+En5oAmliHXGNAlfBQ0pT1/UUukIlGHducTHjbpPHCi8eKq2r3XYSHWDgRRk9R3X8WXEOSzkK24iW2u+jf8Z25aRdhTS1EAYcPDhySdv7FxZ9CEe2auBGOe1hD1tlL+QnBnL/E7F3AOsnmP1H7GelfDJWL8cY2oM2tM4ANlxoNorikb7nViGt1osCBbgIkWWVH6inRotGL9m8ZUhqQHfng7PO4h7XiBYqcZodKJjYhrc63wOJGMZs6diDNcxtatFbTmlFfy/I2eVFoGTQqnOESlL5teiflDzfVRjiMQuGDymU212zIvQo9DDBQ6IKt4w5h+KOIJC1YDCfSNeXAnorJtSoDT5ioz/5jkogX7nGg3vFzAcXQo+ucf1iKxXjyadNwuea+nlgDg4jdCFFqmK5S9cFNs5xYN5GB28CQeDIQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(6506007)(966005)(86362001)(71200400001)(52536014)(5660300002)(508600001)(38100700002)(8936002)(7416002)(33656002)(921005)(83380400001)(38070700005)(9686003)(107886003)(55016003)(2906002)(26005)(122000001)(186003)(316002)(110136005)(66946007)(64756008)(66476007)(76116006)(54906003)(66556008)(8676002)(4326008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g/MJhmqx8k4UX0uXEaCDvgUCLH/x8D5htV/XuM1Lut3azZd/uprBJgW6OrQU?=
 =?us-ascii?Q?cVhUTUUrkdmr6Ns4F9sPYjBGRYJD1yxwKzDyfA4Ywr9Ya2TEExoJFbwMAC7L?=
 =?us-ascii?Q?rZT87GEUiPUt0k4SDftOJ8EHmmB0HlwlhTVJZCOvwIA+YyT8T35DulAFoLHr?=
 =?us-ascii?Q?CGdKyvzfluK7y/41ycgXpH3DcXFWc425BUVuSkDztxSKxKXMoCgSdcK0i1hv?=
 =?us-ascii?Q?CzFnJd2/rvJd2PdLJ0qVnFVQKZSJyDelJwfpariqRmylzT8jL+kiudPtG758?=
 =?us-ascii?Q?qh5IPhSd1fKz3EKOTRas2pRQtH4POEN4/rjyy87T2ZRj4kO7zuYgTRxDe2Ss?=
 =?us-ascii?Q?KRMljtL36Tn33vAROIcGSamQh0tqvVrivAxE5KoYggLv3m6SiVBco47hl8dH?=
 =?us-ascii?Q?2+XuxfRVHq1SV/o/ELoKzSv2SPIC7KE0WUCbQRHYkvNc4V2Wmo3xU2nGCKJG?=
 =?us-ascii?Q?oHWHsXHCZD7UJnlWL/r9hKeikVHM7aBgYfS7C6PWVrtjeVjSfP36258QOYrk?=
 =?us-ascii?Q?eFnUdT9xMrydL7V7yPiNa8gzdPFGPb2QWDC8KkYxI6Fdrho1Ii/jWahiL81L?=
 =?us-ascii?Q?qL+MXK9JrPS+eKJ7l2WBVJAC8nZR+ob5E6qYxDx3Eh3U/VZxiYQ7gFyGsx2d?=
 =?us-ascii?Q?2QKjqpykdax1lKrhfDLJ3Wiim6hcR5SRM1xAbujPARHpvWKIJ7+NTfMz2mu3?=
 =?us-ascii?Q?jKJ4oQf7OPd0LTaguEM+mJydWkjHucmvYTqMVcC12YD81L3v/02lY6xsRKyT?=
 =?us-ascii?Q?ayEyS1Ch8mpO2JdmSUkz0DouKwGam83QmiDS0svf+4LZ3NEkGWaf4LruWU/2?=
 =?us-ascii?Q?Nq3vgl7cZHnyKTsptJf6UhIHEnqmAWNELA1WNkVfIQuCYi+AU/4B8HWJqcIS?=
 =?us-ascii?Q?0Sinec+NIM6j7mErhFDv+FOPuOGALt3oDHTC7oZ8bn8S9StHAfniq04gtIz1?=
 =?us-ascii?Q?XqFZXVwBJWe9z7UZWsD0orxlelUchQKPo7yNF/X5TtAvfZZ9Zi6pYsgmehek?=
 =?us-ascii?Q?xhqO2/bIMOLUi+vtmH2hRSbh/MAlFtypmABvXGPQ7yNGJikIQje2aINkgzo1?=
 =?us-ascii?Q?NVsLF2puF6wieEQO29QGGqlGOByZChrFPIJaGMl+3eDI9/c23341+W3B9oNO?=
 =?us-ascii?Q?PihF9PMvv+fud5Im3mfMRBI2aFWTWIW2pAwisL/kayPwVn6bMURMYTRyLW4a?=
 =?us-ascii?Q?mRNi2lDgzOfoT3Lbx/FarrJsSpeN+y2YTT2uBX3OgUolwre4L22UV0UnOlIh?=
 =?us-ascii?Q?uDl/F15s0Mci6kWBbj4nfb61fU1bGFdhNFtgmJMUWmayhSxYkbwOsB9v0Civ?=
 =?us-ascii?Q?kOIf1n7Pg3r/XCpljdKgyIlsnmHm2YLxOiYLLyfPlH2Sp0W9w/P2iq6LOfkt?=
 =?us-ascii?Q?kX7+1pBERO4JrIn9lkOrg5N8PwsDXusHG+DcrRe9Jar4Y+N/UbmkPOzChSDI?=
 =?us-ascii?Q?a9rWdcuRm6n/4INMqJyR8IEtKqyKzz549NxDq8yIflL+1xzF9YYv93+0AmaA?=
 =?us-ascii?Q?oMM5c6nn4CetcExv9AgfJEXiUL6GNzRw+ot9XaEBHDG6E0i9WkwJ0Sz4bjjp?=
 =?us-ascii?Q?qCXso6GPhXczeqmhd0DsdVy4ecV8aHnFzSR65nMrFKywyQSws8iXxKjcdBXE?=
 =?us-ascii?Q?P2wl+g1/hGN0rKGKJV58YJblGekxrx0NrNso/IwHiHlUhZtNGH9jC/Jv4Fky?=
 =?us-ascii?Q?qcVGfEDoiVnjZu6gId6qpctqSBgUyE8RjSDwdS05JH/mNJ10C67x76g3UxlX?=
 =?us-ascii?Q?2x0YgxyJyRLRD/tUq5Nd7AoVTKltKE4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f64c447-f721-4ff7-b39f-08da33d9434c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 05:35:45.5399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4NsIP1rcZdTjafsblgqmL+6mA58x2KZItgY6D6qJNIsHNLEuwHhdHrmYoaCcZvZhgrcNHqywnNIgyU5Hvbw6TjNJDt4Wkc2fPazEs6MGw94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6779
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thanks for the patch.

> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain t=
o
> handle GPIO interrupt
>=20
> Add IRQ domian to RZ/G2L pinctrl driver to handle GPIO interrupt.
>=20
> GPIO0-GPIO122 pins can be used as IRQ lines but only 32 pins can be used =
as
> IRQ lines at given time. Selection of pins as IRQ lines is handled by IA5=
5
> (which is the IRQC block) which sits in between the GPIO and GIC.

Do we need to update bindings with interrupt-cells on [1] like [2] as it ac=
t as parent for GPIO interrupts?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml?h=3D=
next-20220511

[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/Documentation/devicetree/bindings/gpio/renesas,rcar-gpio.yaml?h=3Dnext-20=
220511#n81

Cheers,
Biju

>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 202 ++++++++++++++++++++++++
>  1 file changed, 202 insertions(+)
>=20
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index a48cac55152c..af2c739cdbaa 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -9,8 +9,10 @@
>  #include <linux/clk.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/io.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/of_irq.h>
>  #include <linux/pinctrl/pinconf-generic.h>  #include
> <linux/pinctrl/pinconf.h>  #include <linux/pinctrl/pinctrl.h> @@ -89,6
> +91,7 @@
>  #define PIN(n)			(0x0800 + 0x10 + (n))
>  #define IOLH(n)			(0x1000 + (n) * 8)
>  #define IEN(n)			(0x1800 + (n) * 8)
> +#define ISEL(n)			(0x2c80 + (n) * 8)
>  #define PWPR			(0x3014)
>  #define SD_CH(n)		(0x3000 + (n) * 4)
>  #define QSPI			(0x3008)
> @@ -112,6 +115,10 @@
>  #define RZG2L_PIN_ID_TO_PORT_OFFSET(id)	(RZG2L_PIN_ID_TO_PORT(id) +
> 0x10)
>  #define RZG2L_PIN_ID_TO_PIN(id)		((id) % RZG2L_PINS_PER_PORT)
>=20
> +#define RZG2L_TINT_MAX_INTERRUPT	32
> +#define RZG2L_TINT_IRQ_START_INDEX	9
> +#define RZG2L_PACK_HWIRQ(t, i)		(((t) << 16) | (i))
> +
>  struct rzg2l_dedicated_configs {
>  	const char *name;
>  	u32 config;
> @@ -137,6 +144,9 @@ struct rzg2l_pinctrl {
>=20
>  	struct gpio_chip		gpio_chip;
>  	struct pinctrl_gpio_range	gpio_range;
> +	DECLARE_BITMAP(tint_slot, RZG2L_TINT_MAX_INTERRUPT);
> +	spinlock_t			bitmap_lock;
> +	unsigned int			hwirq[RZG2L_TINT_MAX_INTERRUPT];
>=20
>  	spinlock_t			lock;
>  };
> @@ -883,6 +893,8 @@ static int rzg2l_gpio_get(struct gpio_chip *chip,
> unsigned int offset)
>=20
>  static void rzg2l_gpio_free(struct gpio_chip *chip, unsigned int offset)
> {
> +	unsigned int virq;
> +
>  	pinctrl_gpio_free(chip->base + offset);
>=20
>  	/*
> @@ -890,6 +902,10 @@ static void rzg2l_gpio_free(struct gpio_chip *chip,
> unsigned int offset)
>  	 * drive the GPIO pin as an output.
>  	 */
>  	rzg2l_gpio_direction_input(chip, offset);
> +
> +	virq =3D irq_find_mapping(chip->irq.domain, offset);
> +	if (virq)
> +		irq_dispose_mapping(virq);
>  }
>=20
>  static const char * const rzg2l_gpio_names[] =3D { @@ -1104,14 +1120,190=
 @@
> static struct {
>  	}
>  };
>=20
> +static int rzg2l_gpio_get_gpioint(unsigned int virq) {
> +	unsigned int gpioint;
> +	unsigned int i;
> +	u32 port, bit;
> +
> +	port =3D virq / 8;
> +	bit =3D virq % 8;
> +
> +	if (port >=3D ARRAY_SIZE(rzg2l_gpio_configs) ||
> +	    bit >=3D RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[port]))
> +		return -EINVAL;
> +
> +	gpioint =3D bit;
> +	for (i =3D 0; i < port; i++)
> +		gpioint +=3D RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[i]);
> +
> +	return gpioint;
> +}
> +
> +static void rzg2l_gpio_irq_domain_free(struct irq_domain *domain, unsign=
ed
> int virq,
> +				       unsigned int nr_irqs)
> +{
> +	struct irq_data *d;
> +
> +	d =3D irq_domain_get_irq_data(domain, virq);
> +	if (d) {
> +		struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +		struct rzg2l_pinctrl *pctrl =3D container_of(gc, struct
> rzg2l_pinctrl, gpio_chip);
> +		irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
> +		unsigned long flags;
> +		unsigned int i;
> +
> +		for (i =3D 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
> +			if (pctrl->hwirq[i] =3D=3D hwirq) {
> +				spin_lock_irqsave(&pctrl->bitmap_lock, flags);
> +				bitmap_release_region(pctrl->tint_slot, i,
> get_order(1));
> +				spin_unlock_irqrestore(&pctrl->bitmap_lock,
> flags);
> +				pctrl->hwirq[i] =3D 0;
> +				break;
> +			}
> +		}
> +	}
> +	irq_domain_free_irqs_common(domain, virq, nr_irqs); }
> +
> +static void rzg2l_gpio_irq_disable(struct irq_data *d) {
> +	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +	struct rzg2l_pinctrl *pctrl =3D container_of(gc, struct rzg2l_pinctrl,
> gpio_chip);
> +	unsigned int hwirq =3D irqd_to_hwirq(d);
> +	unsigned long flags;
> +	void __iomem *addr;
> +	u32 port;
> +	u8 bit;
> +
> +	port =3D RZG2L_PIN_ID_TO_PORT(hwirq);
> +	bit =3D RZG2L_PIN_ID_TO_PIN(hwirq);
> +
> +	addr =3D pctrl->base + ISEL(port);
> +	if (bit >=3D 4) {
> +		bit -=3D 4;
> +		addr +=3D 4;
> +	}
> +
> +	spin_lock_irqsave(&pctrl->lock, flags);
> +	writel(readl(addr) & ~BIT(bit * 8), addr);
> +	spin_unlock_irqrestore(&pctrl->lock, flags);
> +
> +	irq_chip_disable_parent(d);
> +}
> +
> +static void rzg2l_gpio_irq_enable(struct irq_data *d) {
> +	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +	struct rzg2l_pinctrl *pctrl =3D container_of(gc, struct rzg2l_pinctrl,
> gpio_chip);
> +	unsigned int hwirq =3D irqd_to_hwirq(d);
> +	unsigned long flags;
> +	void __iomem *addr;
> +	u32 port;
> +	u8 bit;
> +
> +	port =3D RZG2L_PIN_ID_TO_PORT(hwirq);
> +	bit =3D RZG2L_PIN_ID_TO_PIN(hwirq);
> +
> +	addr =3D pctrl->base + ISEL(port);
> +	if (bit >=3D 4) {
> +		bit -=3D 4;
> +		addr +=3D 4;
> +	}
> +
> +	spin_lock_irqsave(&pctrl->lock, flags);
> +	writel(readl(addr) | BIT(bit * 8), addr);
> +	spin_unlock_irqrestore(&pctrl->lock, flags);
> +
> +	irq_chip_enable_parent(d);
> +}
> +
> +static int rzg2l_gpio_irq_set_type(struct irq_data *d, unsigned int
> +type) {
> +	return irq_chip_set_type_parent(d, type); }
> +
> +static void rzg2l_gpio_irqc_eoi(struct irq_data *d) {
> +	irq_chip_eoi_parent(d);
> +}
> +
> +static struct irq_chip rzg2l_gpio_irqchip =3D {
> +	.name =3D "rzg2l-gpio",
> +	.irq_disable =3D rzg2l_gpio_irq_disable,
> +	.irq_enable =3D rzg2l_gpio_irq_enable,
> +	.irq_mask =3D irq_chip_mask_parent,
> +	.irq_unmask =3D irq_chip_unmask_parent,
> +	.irq_set_type =3D rzg2l_gpio_irq_set_type,
> +	.irq_eoi =3D rzg2l_gpio_irqc_eoi,
> +};
> +
> +static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
> +					    unsigned int child,
> +					    unsigned int child_type,
> +					    unsigned int *parent,
> +					    unsigned int *parent_type)
> +{
> +	struct rzg2l_pinctrl *pctrl =3D gpiochip_get_data(gc);
> +	unsigned long flags;
> +	int gpioint, irq;
> +
> +	gpioint =3D rzg2l_gpio_get_gpioint(child);
> +	if (gpioint < 0)
> +		return gpioint;
> +
> +	spin_lock_irqsave(&pctrl->bitmap_lock, flags);
> +	irq =3D bitmap_find_free_region(pctrl->tint_slot,
> RZG2L_TINT_MAX_INTERRUPT, get_order(1));
> +	spin_unlock_irqrestore(&pctrl->bitmap_lock, flags);
> +	if (irq < 0)
> +		return -ENOSPC;
> +	pctrl->hwirq[irq] =3D child;
> +	irq +=3D RZG2L_TINT_IRQ_START_INDEX;
> +
> +	/* All these interrupts are level high in the CPU */
> +	*parent_type =3D IRQ_TYPE_LEVEL_HIGH;
> +	*parent =3D RZG2L_PACK_HWIRQ(gpioint, irq);
> +	return 0;
> +}
> +
> +static void *rzg2l_gpio_populate_parent_fwspec(struct gpio_chip *chip,
> +					       unsigned int parent_hwirq,
> +					       unsigned int parent_type)
> +{
> +	struct irq_fwspec *fwspec;
> +
> +	fwspec =3D kzalloc(sizeof(*fwspec), GFP_KERNEL);
> +	if (!fwspec)
> +		return NULL;
> +
> +	fwspec->fwnode =3D chip->irq.parent_domain->fwnode;
> +	fwspec->param_count =3D 2;
> +	fwspec->param[0] =3D parent_hwirq;
> +	fwspec->param[1] =3D parent_type;
> +
> +	return fwspec;
> +}
> +
>  static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)  {
>  	struct device_node *np =3D pctrl->dev->of_node;
>  	struct gpio_chip *chip =3D &pctrl->gpio_chip;
>  	const char *name =3D dev_name(pctrl->dev);
> +	struct irq_domain *parent_domain;
>  	struct of_phandle_args of_args;
> +	struct device_node *parent_np;
> +	struct gpio_irq_chip *girq;
>  	int ret;
>=20
> +	parent_np =3D of_irq_find_parent(np);
> +	if (!parent_np)
> +		return -ENXIO;
> +
> +	parent_domain =3D irq_find_host(parent_np);
> +	of_node_put(parent_np);
> +	if (!parent_domain)
> +		return -EPROBE_DEFER;
> +
>  	ret =3D of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0,
> &of_args);
>  	if (ret) {
>  		dev_err(pctrl->dev, "Unable to parse gpio-ranges\n"); @@ -
> 1138,6 +1330,15 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl
> *pctrl)
>  	chip->base =3D -1;
>  	chip->ngpio =3D of_args.args[2];
>=20
> +	girq =3D &chip->irq;
> +	girq->chip =3D &rzg2l_gpio_irqchip;
> +	girq->fwnode =3D of_node_to_fwnode(np);
> +	girq->parent_domain =3D parent_domain;
> +	girq->child_to_parent_hwirq =3D rzg2l_gpio_child_to_parent_hwirq;
> +	girq->populate_parent_alloc_arg =3D rzg2l_gpio_populate_parent_fwspec;
> +	girq->child_irq_domain_ops.free =3D rzg2l_gpio_irq_domain_free;
> +	girq->ngirq =3D RZG2L_TINT_MAX_INTERRUPT;
> +
>  	pctrl->gpio_range.id =3D 0;
>  	pctrl->gpio_range.pin_base =3D 0;
>  	pctrl->gpio_range.base =3D 0;
> @@ -1253,6 +1454,7 @@ static int rzg2l_pinctrl_probe(struct platform_devi=
ce
> *pdev)
>  	}
>=20
>  	spin_lock_init(&pctrl->lock);
> +	spin_lock_init(&pctrl->bitmap_lock);
>=20
>  	platform_set_drvdata(pdev, pctrl);
>=20
> --
> 2.25.1

