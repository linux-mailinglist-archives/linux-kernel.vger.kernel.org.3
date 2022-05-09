Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2294151F4F5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbiEIHFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiEIGxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:53:51 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2095.outbound.protection.outlook.com [40.107.114.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA5019CED8;
        Sun,  8 May 2022 23:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aT4vRIcukIvaxpWLt3C1hNepXn2H4QccOPbO4w9Jeq/F8l8iqT/ICJyFZ4nTXncK6PzXegG1B84/N3whBYIU+fXMp8qHHOeFl370XZmMFnaDEb4zcRxwijlj+GVFSi5/soPTEIs51UJRCw5RMFFQR2FNvHmxwjSfFtjpXiGq6vepMbUPHyCqTXUvNqZxfafzdfyG3r4CaE+aLPm0vQM9rDFA8oUnAk0yI9rFLppwb0wZDYGljzJEUBcJMVYsWWHKq7o8rgDZ+Dhj/IkL8d5mUdVlyF8Y/CRZH/TV/g2WmJEP+M7ExfmXZQhaHjiMH+kccQjUJtATKgzG7Nrt9GYAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLCJ910pfyc0hRScdrrkD2Unilx4o8/MBOLEPHDVlz8=;
 b=IK96cyiro2UkrrpBqwn59sEHkobUHGbtl6ngwW9ot/7AeLo0lmjSM3Ao44sLXhRIz0dzVIjXLQer89F93uHnYQdH1jQHY6Vh8th6qxb//165/JHAAQ7VkXuJhiE+t/HtHLQUNlXe/CLAW83GAH+P5L6lw8yOnzqHclJCuFT10DzAWDn6geyudgsDfYsV9clM4UBDUhhJA4kkJqMWvzocexJPHhCJtIVHaXMuOnBFr16xsyUb2GVOaeQJuK4AhH6cFm4arAisjjeKShfzbNF+iepcMTt2hvbekZ804w1F+Bis8c+ev2HnJkKET1LebnC7GI1DKqXj+t1eW+WZo0Vbvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLCJ910pfyc0hRScdrrkD2Unilx4o8/MBOLEPHDVlz8=;
 b=rOuk392AR/e7rZGDXzRiV57P5M8pF86n+/d0bEfZUXsNT61I6gHB8ewm32qnBnTHRa3tEOHiXMDfo1n/FgSlj5vkyKQIQ3CYB6jA3jb5BMzkVwJ3X6E8Y6j2c356V7Qxayda02+bSMQrHACIPrMTklUUVw5RuOa2229sqlpDbnk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB5632.jpnprd01.prod.outlook.com (2603:1096:400:47::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 06:49:08 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 06:49:07 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
Thread-Topic: [PATCH v2 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain
 to handle GPIO interrupt
Thread-Index: AQHYY2Mk76CXU0rqe0uShlNWW0dHWq0WGfew
Date:   Mon, 9 May 2022 06:49:07 +0000
Message-ID: <OS0PR01MB59228AE4AF4EE53C382E8BA986C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220509050953.11005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220509050953.11005-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220509050953.11005-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dde74dbd-06d4-4710-25ab-08da318803bd
x-ms-traffictypediagnostic: TYCPR01MB5632:EE_
x-microsoft-antispam-prvs: <TYCPR01MB5632BAFA9943D6C5283089FC86C69@TYCPR01MB5632.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pRggfQtFT0CGjgZ68nSmEBMaA2nrboXF3Zv4mn92A1a2U20uRHs9SUBEMRHhEWu36FHZ3qd86yFCn8Y4Uf2aT2ZVozTIOrWAgMKYinM9FuiJK69D0W2lpM5XYcDMb6wVq0CBTY2RinrBxx9OPiSQwyiComeg8Z/Xq79sJfThVsnlkJrs5yN3PrWrDSmq3iz0Uy5MR/EddCiElJrQPFzM6MBLFT9/VX2DTKAga6CCBAUXHmgJix2YbKCDUZxvLCZMiDkNPmu3k/pzsrYnINAobWHaBGbB3Q6K6mFXG73Mydn0JQTcpprlvLvF1krOjVUGaM7KC5aOsxFEze4Grij74SOfw/yYh29aOBROa4egOjOuEIm4BZ40FXAENvSVB6pP01xPUiEiC9P3CUGETJg8KGZhn6CUCodgX/LtXbtVaUcOM8aoxzQyXbOiyZQYw3areZFTjh+3q9DGoc2lG5dPK1FCRoPiAMFXukQMEVUormg/ZLcY4PZEXOclxeINSFsOiaP/wyRUeZ9EtKwg4z6vGok8LJOpmzXxFgHeJe99c2hV6jClkzF3D+PfSSK1W5YqYtT5jXkgH7C1GQEgqazqBolY9S4V3ktshznk8nhvsZ3h26CooHy3ltgd5okewLgkFpcOXMZmZCThauct7Z6cuJIMXMRx4VlsQMsLJIAxPY1So0Kf4xcFZz0SADM7YAQGkguxoaid67MiGNTBnXt3cGMzuiXrYNBX+Apjg+BVFWs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(52536014)(54906003)(66556008)(8936002)(26005)(7416002)(66946007)(71200400001)(5660300002)(76116006)(66446008)(64756008)(66476007)(107886003)(316002)(4326008)(8676002)(86362001)(83380400001)(921005)(6506007)(186003)(55016003)(7696005)(38100700002)(38070700005)(2906002)(9686003)(508600001)(33656002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lkVX3Ss1zJsfR/KnpzGAN1bKNc0G+FaR5Uh4hLrNiOAYkvAX1wbmFUZdND3r?=
 =?us-ascii?Q?9dgqdSYjMyjPpA+EdGs0gImskJFsJn0bml/Dpk+BMB3E6RslDD/LX+G7bpY2?=
 =?us-ascii?Q?HZsLPVr58gQI3FPvPlpKz1sYYWyR11ZnbYWJHM/GCtsyzxjSTGP9xb9do+k1?=
 =?us-ascii?Q?z/CSTuxId1iz2NxiXBGUcW3BlpWsOAZmO5x+mznkCsXTA6nzaEZIWXXXZKVT?=
 =?us-ascii?Q?XMn+Q7zHe8ln+gR/iWwK+r5wiclQq5DEBFRp/MfHZnjR69ezDosihTaSGBOK?=
 =?us-ascii?Q?UlUUXX0rIu4aBM9RCoMcx7AXeuPdPz4oMpHN2Z48TMfTMJbtTRYvkjNC8njC?=
 =?us-ascii?Q?G7IanciYIge1IBpCj+dYkkYn+ErwP4zM25ERtVYct7WHst6iYh2iv4WivM8S?=
 =?us-ascii?Q?O59zGaq4A/LSqKDXkNnfStmGxkITBXKIAgqcLqeqLuWLHif4Z7d7hkhUgAv1?=
 =?us-ascii?Q?uhKkL6tz9vPUJkFVujDHMq+0BsS5uF2NtQNKUBtv1kotA9WIm3IeqcyMh0be?=
 =?us-ascii?Q?Ws1KL95Q0goOw7odfF2/eM1qRTKBmOsOWxAoq/OaZuHG4MaXxd+b5PnI47WX?=
 =?us-ascii?Q?g9O8dUtJDXCTOaMC+l9/XeutD3wFdvNZQrMOGvRXLXU440hGoBhLuXWyALgp?=
 =?us-ascii?Q?W9BTfuvdMNSS1OMfbElrYDY4TIPGm+Tmxabwe/xBZXEkkudhjHdLHR+ZmLUd?=
 =?us-ascii?Q?en2uAM1XuKUvYM/vsop9dozcbyKwVWXGtMGf9Be0tTZFZpc3EZMuv4JDMpKW?=
 =?us-ascii?Q?IcNjGSByP0gzVfGJLGIfM19Zjc5ZrtFNTg3CGsOUNzoSQjgTT98S6Uu6OcM5?=
 =?us-ascii?Q?OFomldQJhgCQ6VFHlPVmedLiMnMesIOyeGHOFDGYes8xtEt2OGDzH9bEm7Zk?=
 =?us-ascii?Q?UcNHmFYSrrbxQd0nDRG7GuVEmpA1/Csd4wWw5BAdSmdI7hd+vvLEaSTu2h7l?=
 =?us-ascii?Q?JewIFijjvQI2NLzl9V9K/pM7EaS2yfCV+OasEVyB9Asnay8d++ahFboqn6K3?=
 =?us-ascii?Q?EyVJuNohBboa8Unu/n/0d2Z1J4V6zOeO9tx9MgS7/aSkUpG+8pZ21yP8PpHA?=
 =?us-ascii?Q?yF6xNhTWdykVj2DbsCFltvUb4bwuL2rb0VEQ2hytMRvJRIa+qC1VfQDdpm2z?=
 =?us-ascii?Q?zTpnuthOr3Ia3ei64H/KdQdqoKWg9E+lTGuFor0HNYkrsmeOeLirLMe5Fz6J?=
 =?us-ascii?Q?yj9qrPpaSsRArEvi7/0CyZvEVvZ4AtXC+rNC+hDe1nk941asFVWWQ+NmVzf8?=
 =?us-ascii?Q?Nq2Od0Sa/45rrXkg9QUk5EBJTl/jS2xJL2CxctMp0O5bDHL3+4PX95j1pHpd?=
 =?us-ascii?Q?T8X3W0C2Fs6nnVf7HItWlq6QxTSai2mda8ymjFJorLR2Z/5K6iXqLEKmlmBB?=
 =?us-ascii?Q?Fr1hZ8fCP0BlGTXrrm01DxTdmgDFV7bZJL09wHh53oTNvJBuXQbJclaW2bJF?=
 =?us-ascii?Q?EYXIl0I+H3LotzcN+HnlNL6EqNcG35HD3dgWX6XYZxR6rMvAZCv0eaPOwFss?=
 =?us-ascii?Q?vwoNTKDAeYeYPFPoywvEl7MDOjv9g2CDyFUEMUFODl4OrUvrAJGjw4ggN/bH?=
 =?us-ascii?Q?yMM8qUyni8cJvoN9FKq8Uzg/Epe1NryqY91DwhHuIAJrRJ8bhA/LCdFbWRzS?=
 =?us-ascii?Q?ZNIpcpx/3Riyzq72xawTJbro9YeKQGjJMsUazYqhpfUVxGRf2bxsm2aF6TI6?=
 =?us-ascii?Q?cIB0HreVg8RlkT5sHBjr5VlJh6Hbv/ndG8vzqjEVbtqA4zI9NcgzVfftj4eh?=
 =?us-ascii?Q?Ri9Oh2p3PD16fSsU6BfUUd12P6vd4X0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde74dbd-06d4-4710-25ab-08da318803bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 06:49:07.4074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1KkKk8a1MJOxrupYtUrbFLKaMyj+/UUWimVpwnaILwLCuRlyGUBtnOTPXwTslS5RAjT7mwCabDBWqJWIYtlqM6qaPSlLrqwpsGKSazYUfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5632
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

> Subject: [PATCH v2 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain t=
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
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 205 ++++++++++++++++++++++++
>  1 file changed, 205 insertions(+)
>=20
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index a48cac55152c..275dfec74329 100644
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
>  static const char * const rzg2l_gpio_names[] =3D { @@ -1104,14 +1120,193=
 @@
> static struct {
>  	}
>  };
>=20
> +static int rzg2l_gpio_get_gpioint(unsigned int virq) {
> +	unsigned int gpioint =3D 0;
> +	unsigned int i =3D 0;
> +	u32 port, bit;
> +
> +	port =3D virq / 8;
> +	bit =3D virq % 8;
> +
> +	if (port >=3D ARRAY_SIZE(rzg2l_gpio_configs))
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < port; i++)
> +		gpioint +=3D RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[i]);
> +
> +	if (bit >=3D RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[i]))
> +		return -EINVAL;

May be combine this statement to above with=20

|| (bit >=3D RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[port]))
		return -EINVAL;

Cheers,
BIju

> +
> +	gpioint +=3D bit;
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
> 1138,6 +1333,15 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl
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
> @@ -1253,6 +1457,7 @@ static int rzg2l_pinctrl_probe(struct platform_devi=
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

