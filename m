Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06DE523D59
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346769AbiEKTZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiEKTZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:25:07 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2106.outbound.protection.outlook.com [40.107.113.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDAFC9EE0;
        Wed, 11 May 2022 12:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d20rLRM1IkyFgCMzzeV5bSgqPTMTyQ2FdRs7bywXcbmLEALvfXMdmm7t3N+C4/gMfikWvJF85pwzxqw8kbTY0B7Xv9FunM4fKfJ+c2jgeo7sYDrDnozCV3Zm812JXV76VuJbPj95/qvYkQcLkn00PJ2nUneaGG08AOw/93vDPQzotoh0VkHIjVlagzOw3eknA2SdsJzPIkuka+ox1P/o76Yq7d094Tv++sXnL2WqY0iIawg+ymXO3MlQSc+TmUK16w0LIHL3KGKQecnYn89c2XAbZwDmMimDM3x4VLR+mjqzWK+Sz6akHGGz4gD17e9pJNXp/MW7Auqjm6WzQmS3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0N2s/iWwYlC0ycoZdVSUhyt4nVTp4+iW270optUtwk=;
 b=da6h60MpDckG4yacTefAvPDfga0qV/72oE3aqDoAQh8fyOwNr8oJcb0Glydn/gBYyr3P2XCT9LhDjfkc94LfIluvA0T7BnZkivI4NYb7SVpf63A9FHGrDTat7oQtCxjfTG8naFuAC1sbMye0Xljc3mJfS2Sy/Yx34RmjlNFYrfb3DUoExuOrJ6sKr646I4om8ME1WiT4vHAhoizVFaAPNW2jd7okEmsLq4s2mD8skT4VCaNDF4991Glrz8OTZpIPh9hsmgMCb1bKKBRbee+zxIoRQ1tGW+9ooM6aUTDjb9EEp/hR750EQBayGR5Lne852b4n8V5eRt49dt3LJKEG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0N2s/iWwYlC0ycoZdVSUhyt4nVTp4+iW270optUtwk=;
 b=IOiw/MEDHOh1SKOXP0w94KOw+Y4HyAYpohwsgPBXTzFGwawIgXH1IQz8I2aRyo9IE8eVbQb2YaHGaTHJzzNS8Bc4iT/Ik4aNijW04q9XE3ukr2Yy2s5LPGqwXvttaViBfjOGVzdeIR1erlFdHD16lM8bH6iOaLj9OhpgvEVJTmg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8013.jpnprd01.prod.outlook.com (2603:1096:400:186::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 19:25:01 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 19:25:01 +0000
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
Subject: RE: [PATCH v3 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller
 driver
Thread-Topic: [PATCH v3 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller
 driver
Thread-Index: AQHYZWV6Wwi7zT4wrk2UDJHE1Y8qm60aDbjQ
Date:   Wed, 11 May 2022 19:25:01 +0000
Message-ID: <OS0PR01MB5922AC4FB9D5A04180F46C2A86C89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220511183210.5248-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c03dd19-22ef-4eb9-b9d0-08da3383f19a
x-ms-traffictypediagnostic: TYCPR01MB8013:EE_
x-microsoft-antispam-prvs: <TYCPR01MB8013D5514871A807CAB3783686C89@TYCPR01MB8013.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FqpiXKO11xu7LOmFDz4riql+hF8QhVwH0v18RNdEsaFHokvrSjf8n4Smps0kJPzyHEnzXdfCEMJLOLNM9GlO7Mf65kiOqGAAqoYvCg+w/Np/OtClGUVIwqcecy4ZEUwz3blKVcvz0g+9MirE+/l9AINv4s51RlfOziB+nopSQy57FZKTSkt1oB0d21tP+YyPxoHaahnvCaqBOPl0yGFajKiKoPNwEDWnL0sLP1ZYSzGLPXweXkuFbfrBhJZ3ZPBkZBjRD/6mMh4+pVfvrupqTVuYwGaJMKXsKUkNK0zRGFVeLqrDBMX60v4RLGQEGAOs8hkeJsy8w6tjxpITLki+ljU5WDyvEzufBBYQ+Mp87SK2TAg3uiaOfpbWveQ34LwswZu8ex+lSh6RweWcg17tE+KrsNAFtSt3/2UbP83pYmUuReuPFUtciMJaoAJdF2/zfMlLY8Oa/vYCSrqSKTuAYtm8tgQWu6XhotkRl77g3hoaPiyhia+paO+5iWIvEXEDcoiYT99qqivtTtuBsWx9ZCKtnziiAZbzW7RTe7RQi9EBNrnR0YXHn295d+09bYcZOY8UF1oYi+GDXRElmPsUvkmXdHTV9bV2YzbyAQ6hQo4uEOUBPPlgMzAb7xWXN17yDCn9eIRnbLnlSy7Nco57SYwXAYHISALT5214HnCuU2RNa67OfiDd2VQmCrW51sTbkCyPcbi1H2jD+kkCueWyx4tX+N3b1Fp4iFbefQ1WAHk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(7416002)(7696005)(921005)(52536014)(38100700002)(30864003)(26005)(9686003)(5660300002)(54906003)(8936002)(107886003)(186003)(2906002)(83380400001)(38070700005)(55016003)(33656002)(508600001)(71200400001)(86362001)(4326008)(110136005)(76116006)(316002)(66556008)(122000001)(66946007)(66476007)(66446008)(8676002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ImH9Gs2dlmh2oBAI0+zinnJfCD03MPC+mb8nL+J897Uu00iUvqok+YZpZd6d?=
 =?us-ascii?Q?GJcpD53vU++0jcRKGIGB0HnnUBeG60CRFNRBID+QinB2FYWQPFh3DkFen7r7?=
 =?us-ascii?Q?t3MCB8sec9gyBT1Pjz6TXpKG/uD4w3GxnxOhFb9u53OvrqHCgnrUcwSbhK2T?=
 =?us-ascii?Q?vdBvTe5oq10LzARdCPZyxHoRHg/tA2zv7nwDDzo/K5ae6U08m93qOl5yawwX?=
 =?us-ascii?Q?JnolaDiJus1peRNSP6lqN1MHOYhDknPAHSnF4GXtSaLTIo8JPFnL0geo0F16?=
 =?us-ascii?Q?ehFpT+MAiz7zgJwFQcMD/uwOoSu4zvRd+hxo/xBygAJuEuUa4XwwyG0jFMM7?=
 =?us-ascii?Q?2qVU0KQqmTvCEj4EcR3norpIoqCbhQuVqWwCg8XMVCVAd9rI43Bt5dHk5GOG?=
 =?us-ascii?Q?p76k9vQ6OQa4H97wBYooKl+TJzjbkWvkd5Hgh7Trtrj2cb0BWT/g+9gQfwLS?=
 =?us-ascii?Q?nCs90ohCU1eH8u+RYjg67QVZpFVuey0wg6XCHojxU/aY7jbCOg2K51MO3hU/?=
 =?us-ascii?Q?71vg4FdNw7SYyobkW5Ui1LO4WyBxasSafa9McKF3/OVhJfz7kNpnec2qkq+O?=
 =?us-ascii?Q?WdaCIS0Xs2oxWbMnfc5V7sf3A6S7+j+vZ+s5Ym9OOyEYbkGR/jrfJLGY/dUn?=
 =?us-ascii?Q?POYMe8I2AGYbMcRD8P84UwvQbLs5bjdHdsfbCjMaTnUqECyc+EzRbyBfXpB1?=
 =?us-ascii?Q?bGo7KS7zjUEzzjSBdwvUQJKxyfBjnC11FpkViHtGPa3oU/vUZtWPfRBCpud6?=
 =?us-ascii?Q?SyG5VMVcv50qvce9nTjtrf0HkL69Zo2maJarw+LEtOY6Bh3klRwSMWjhl5R5?=
 =?us-ascii?Q?jzJG+oCzvjBtURTwQ8kpoYX6RD/ETaBUgZ/OjkesvIuSv4U3Tsb6azZTPe9j?=
 =?us-ascii?Q?TQPgpFVQ2xIvClb9IJ9Cqd8bk7T+EDlLecVyxAu7k48aDkX8+avSeqxWzhXR?=
 =?us-ascii?Q?ajD/uGdOH6d81rTT/a7wBTiETe0NzbDZZmfHBJrQVFnvQsliJi34jDjrJN3x?=
 =?us-ascii?Q?+ISflmqVbcHHc/2Y/kK+9+zJRFbG3h5jejPPBy5yZnkJRvxcF5jU1Bqq8BqS?=
 =?us-ascii?Q?LudLdw+i7dFugckzNZuXuAn55XIXU1UfySCK1gBFbyN0voCEgXqCnlZoGlIo?=
 =?us-ascii?Q?K/HbywQxFW/pD139vl7+6K/J+2agMqc35w5vXzQzvRfgaUF/b5uAmOJlj6TI?=
 =?us-ascii?Q?BQm+FFdEhQr3rNuFTz1FxOf8+kFR8WAl9dKrayik0po5ig4hdttVB4XI33Cg?=
 =?us-ascii?Q?NyGl/2zLKgOZEj1kZ8FdEIE04VI0UWjI2mF7QJs+RpROQInw2wt+3oLlOA+B?=
 =?us-ascii?Q?ne+aBpHFzf24pogxr7GCb0cxx/GYN4/9yWpfTrZA1Z79nadvkHuO01AAHiXg?=
 =?us-ascii?Q?uRqXj8fVEIl9lHo/gE1go5R+yz0QMzdcY8PM8MOzroxekPvORegfNZ10iwfI?=
 =?us-ascii?Q?DPCMwWh4yIFFMiZz4Hf1E93Fr5wcHCm3zDVSQKzPxeHgJEhnbXdbI19L99Co?=
 =?us-ascii?Q?cvoR/YlNVm/pFHtibspSyOMc9/sX87YK5AWLUa6uEq86mSEUsEnG7xjfvOC6?=
 =?us-ascii?Q?SOYwYBs7/tY/i0txcoWXZxhyJOwyrOkIS/dt+VlZiI25OJRW7Gt+dQFaH1rP?=
 =?us-ascii?Q?H9fl6EGMeisfECFoDvzPkqZqnxyQH5Xnov4KNznpLfoosTh8urtSUMAVmMQS?=
 =?us-ascii?Q?lS5FI4dBQupJ4BIQGKL0C3oIRgdL4cXZ1EjcwV9etRVjt2F1iKe3zRUQSi5q?=
 =?us-ascii?Q?qAYxwokOsgItkosM0vOpiXE/YpVpXVQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c03dd19-22ef-4eb9-b9d0-08da3383f19a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 19:25:01.3371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +tf354TpReYa1tO5FSr05mEoNb9tW/5CveGsbeoJFA5TvLrC6zvMRCTjX7vSuZLUbTHlpd0nuF2vp2GR8PVIBEr02EjoOf8O7LBjGsErMIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8013
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

> Subject: [PATCH v3 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller
> driver
>=20
> Add a driver for the Renesas RZ/G2L Interrupt Controller.
>=20
> This supports external pins being used as interrupts. It supports one lin=
e
> for NMI, 8 external pins and 32 GPIO pins (out of 123) to be used as IRQ
> lines.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/irqchip/Kconfig             |   8 +
>  drivers/irqchip/Makefile            |   1 +
>  drivers/irqchip/irq-renesas-rzg2l.c | 444 ++++++++++++++++++++++++++++
>  3 files changed, 453 insertions(+)
>  create mode 100644 drivers/irqchip/irq-renesas-rzg2l.c
>=20
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig index
> 15edb9a6fcae..f3d071422f3b 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -242,6 +242,14 @@ config RENESAS_RZA1_IRQC
>  	  Enable support for the Renesas RZ/A1 Interrupt Controller, to use
> up
>  	  to 8 external interrupts with configurable sense select.
>=20
> +config RENESAS_RZG2L_IRQC
> +	bool "Renesas RZ/G2L (and alike SoC) IRQC support" if COMPILE_TEST
> +	select GENERIC_IRQ_CHIP
> +	select IRQ_DOMAIN_HIERARCHY
> +	help
> +	  Enable support for the Renesas RZ/G2L (and alike SoC) Interrupt
> Controller
> +	  for external devices.
> +
>  config SL28CPLD_INTC
>  	bool "Kontron sl28cpld IRQ controller"
>  	depends on MFD_SL28CPLD=3Dy || COMPILE_TEST diff --git
> a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile index
> 160a1d8ceaa9..eaa56eec2b23 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_RDA_INTC)			+=3D irq-rda-intc.o
>  obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+=3D irq-renesas-intc-irqpin.o
>  obj-$(CONFIG_RENESAS_IRQC)		+=3D irq-renesas-irqc.o
>  obj-$(CONFIG_RENESAS_RZA1_IRQC)		+=3D irq-renesas-rza1.o
> +obj-$(CONFIG_RENESAS_RZG2L_IRQC)	+=3D irq-renesas-rzg2l.o
>  obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+=3D irq-versatile-fpga.o
>  obj-$(CONFIG_ARCH_NSPIRE)		+=3D irq-zevio.o
>  obj-$(CONFIG_ARCH_VT8500)		+=3D irq-vt8500.o
> diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-
> renesas-rzg2l.c
> new file mode 100644
> index 000000000000..61435d8dbe1a
> --- /dev/null
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> @@ -0,0 +1,444 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L IRQC Driver
> + *
> + * Copyright (C) 2022 Renesas Electronics Corporation.
> + *
> + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>
> +#include <linux/reset.h>
> +#include <linux/spinlock.h>
> +
> +#define IRQC_IRQ_START			1
> +#define IRQC_IRQ_COUNT			8
> +#define IRQC_TINT_START			(IRQC_IRQ_START + IRQC_IRQ_COUNT)
> +#define IRQC_TINT_COUNT			32
> +#define IRQC_NUM_IRQ			(IRQC_TINT_START + IRQC_TINT_COUNT)
> +
> +#define ISCR				0x10
> +#define IITSR				0x14
> +#define TSCR				0x20
> +#define TITSR0				0x24
> +#define TITSR1				0x28
> +#define TITSR0_MAX_INT			16
> +#define TITSEL_WIDTH			0x2
> +#define TSSR(n)				(0x30 + ((n) * 4))
> +#define TIEN				BIT(7)
> +#define TSSEL_SHIFT(n)			(8 * (n))
> +#define TSSEL_MASK			GENMASK(7, 0)
> +#define IRQ_MASK			0x3
> +
> +#define TSSR_OFFSET(n)			((n) % 4)
> +#define TSSR_INDEX(n)			((n) / 4)
> +
> +#define TITSR_TITSEL_EDGE_RISING	0
> +#define TITSR_TITSEL_EDGE_FALLING	1
> +#define TITSR_TITSEL_LEVEL_HIGH		2
> +#define TITSR_TITSEL_LEVEL_LOW		3
> +
> +#define IITSR_IITSEL(n, sense)		((sense) << ((n) * 2))
> +#define IITSR_IITSEL_LEVEL_LOW		0
> +#define IITSR_IITSEL_EDGE_FALLING	1
> +#define IITSR_IITSEL_EDGE_RISING	2
> +#define IITSR_IITSEL_EDGE_BOTH		3
> +#define IITSR_IITSEL_MASK(n)		IITSR_IITSEL((n), 3)
> +
> +#define TINT_EXTRACT_HWIRQ(x)		((x) & ~GENMASK(31, 16))
> +#define TINT_EXTRACT_GPIOINT(x)		((x) >> 16)
> +
> +struct rzg2l_irqc_priv {
> +	void __iomem *base;
> +	struct of_phandle_args map[IRQC_NUM_IRQ];
> +	raw_spinlock_t lock;
> +};
> +
> +struct rzg2l_irqc_chip_data {
> +	int tint;
> +};
> +
> +static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
> +{
> +	return data->domain->host_data;
> +}
> +
> +static void rzg2l_irq_eoi(struct irq_data *d) {
> +	unsigned int hw_irq =3D irqd_to_hwirq(d) - IRQC_IRQ_START;
> +	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> +	u32 bit =3D BIT(hw_irq);
> +	u32 reg;
> +
> +	reg =3D readl_relaxed(priv->base + ISCR);
> +	if (reg & bit)
> +		writel_relaxed(reg & ~bit, priv->base + ISCR); }
> +
> +static void rzg2l_tint_eoi(struct irq_data *d) {
> +	unsigned int hw_irq =3D irqd_to_hwirq(d) - IRQC_TINT_START;
> +	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> +	u32 bit =3D BIT(hw_irq);
> +	u32 reg;
> +
> +	reg =3D readl_relaxed(priv->base + TSCR);
> +	if (reg & bit)
> +		writel_relaxed(reg & ~bit, priv->base + TSCR); }
> +
> +static void rzg2l_irqc_eoi(struct irq_data *d) {
> +	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> +	unsigned int hw_irq =3D irqd_to_hwirq(d);
> +
> +	raw_spin_lock(&priv->lock);
> +	if (hw_irq >=3D IRQC_IRQ_START && hw_irq <=3D IRQC_IRQ_COUNT)
> +		rzg2l_irq_eoi(d);
> +	else if (hw_irq >=3D IRQC_TINT_START && hw_irq <=3D IRQC_TINT_COUNT)
> +		rzg2l_tint_eoi(d);
> +	raw_spin_unlock(&priv->lock);
> +	irq_chip_eoi_parent(d);
> +}
> +
> +static void rzg2l_irqc_irq_disable(struct irq_data *d) {
> +	unsigned int hw_irq =3D irqd_to_hwirq(d);
> +
> +	if (hw_irq >=3D IRQC_TINT_START && hw_irq <=3D IRQC_TINT_COUNT) {
> +		struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> +		u32 offset =3D hw_irq - IRQC_TINT_START;
> +		u32 tssr_offset =3D TSSR_OFFSET(offset);
> +		u8 tssr_index =3D TSSR_INDEX(offset);
> +		u32 reg;
> +
> +		raw_spin_lock(&priv->lock);
> +		reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
> +		reg &=3D ~(TSSEL_MASK << tssr_offset);
> +		writel_relaxed(reg, priv->base + TSSR(tssr_index));
> +		raw_spin_unlock(&priv->lock);
> +	}
> +	irq_chip_disable_parent(d);
> +}
> +
> +static void rzg2l_irqc_irq_enable(struct irq_data *d) {
> +	unsigned int hw_irq =3D irqd_to_hwirq(d);
> +
> +	if (hw_irq >=3D IRQC_TINT_START && hw_irq <=3D IRQC_TINT_COUNT) {
> +		struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> +		struct rzg2l_irqc_chip_data *chip_data =3D d->chip_data;
> +		u32 offset =3D hw_irq - IRQC_TINT_START;
> +		u32 tssr_offset =3D TSSR_OFFSET(offset);
> +		u8 tssr_index =3D TSSR_INDEX(offset);
> +		u32 reg;
> +
> +		raw_spin_lock(&priv->lock);
> +		reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
> +		reg |=3D (TIEN | chip_data->tint) << TSSEL_SHIFT(tssr_offset);
> +		writel_relaxed(reg, priv->base + TSSR(tssr_index));
> +		raw_spin_unlock(&priv->lock);
> +	}
> +	irq_chip_enable_parent(d);
> +}
> +
> +static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type) {
> +	unsigned int hw_irq =3D irqd_to_hwirq(d) - IRQC_IRQ_START;
> +	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> +	u16 sense, tmp;
> +
> +	switch (type & IRQ_TYPE_SENSE_MASK) {
> +	case IRQ_TYPE_LEVEL_LOW:
> +		sense =3D IITSR_IITSEL_LEVEL_LOW;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_FALLING:
> +		sense =3D IITSR_IITSEL_EDGE_FALLING;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_RISING:
> +		sense =3D IITSR_IITSEL_EDGE_RISING;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_BOTH:
> +		sense =3D IITSR_IITSEL_EDGE_BOTH;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	raw_spin_lock(&priv->lock);
> +	tmp =3D readl_relaxed(priv->base + IITSR);
> +	tmp &=3D ~IITSR_IITSEL_MASK(hw_irq);
> +	tmp |=3D IITSR_IITSEL(hw_irq, sense);
> +	writel_relaxed(tmp, priv->base + IITSR);
> +	raw_spin_unlock(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type) {
> +	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> +	unsigned int hwirq =3D irqd_to_hwirq(d);
> +	u32 titseln =3D hwirq - IRQC_TINT_START;
> +	u32 offset;
> +	u8 sense;
> +	u32 reg;
> +
> +	switch (type & IRQ_TYPE_SENSE_MASK) {
> +	case IRQ_TYPE_EDGE_RISING:
> +		sense =3D TITSR_TITSEL_EDGE_RISING;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_FALLING:
> +		sense =3D TITSR_TITSEL_EDGE_FALLING;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	offset =3D TITSR0;
> +	if (titseln >=3D TITSR0_MAX_INT) {
> +		titseln -=3D TITSR0_MAX_INT;
> +		offset =3D TITSR1;
> +	}
> +
> +	raw_spin_lock(&priv->lock);
> +	reg =3D readl_relaxed(priv->base + offset);
> +	reg &=3D ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
> +	reg |=3D sense << (titseln * TITSEL_WIDTH);
> +	writel_relaxed(reg, priv->base + offset);
> +	raw_spin_unlock(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static int rzg2l_irqc_set_type(struct irq_data *d, unsigned int type) {
> +	unsigned int hw_irq =3D irqd_to_hwirq(d);
> +	int ret =3D -EINVAL;
> +
> +	if (hw_irq >=3D IRQC_IRQ_START && hw_irq <=3D IRQC_IRQ_COUNT)
> +		ret =3D rzg2l_irq_set_type(d, type);
> +	else if (hw_irq >=3D IRQC_TINT_START && hw_irq <=3D IRQC_TINT_COUNT)
> +		ret =3D rzg2l_tint_set_edge(d, type);
> +	if (ret)
> +		return ret;
> +
> +	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH); }
> +
> +static struct irq_chip irqc_chip =3D {
> +	.name			=3D "rzg2l-irqc",
> +	.irq_eoi		=3D rzg2l_irqc_eoi,
> +	.irq_mask		=3D irq_chip_mask_parent,
> +	.irq_unmask		=3D irq_chip_unmask_parent,
> +	.irq_disable		=3D rzg2l_irqc_irq_disable,
> +	.irq_enable		=3D rzg2l_irqc_irq_enable,
> +	.irq_get_irqchip_state	=3D irq_chip_get_parent_state,
> +	.irq_set_irqchip_state	=3D irq_chip_set_parent_state,
> +	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
> +	.irq_set_type		=3D rzg2l_irqc_set_type,
> +	.flags			=3D IRQCHIP_MASK_ON_SUSPEND |
> +				  IRQCHIP_SET_TYPE_MASKED |
> +				  IRQCHIP_SKIP_SET_WAKE,
> +};
> +
> +static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq=
,
> +			    unsigned int nr_irqs, void *arg) {
> +	struct rzg2l_irqc_priv *priv =3D domain->host_data;
> +	struct rzg2l_irqc_chip_data *chip_data =3D NULL;
> +	struct irq_fwspec spec;
> +	irq_hw_number_t hwirq;
> +	int tint =3D -EINVAL;
> +	unsigned int type;
> +	unsigned int i;
> +	int ret;
> +
> +	ret =3D irq_domain_translate_twocell(domain, arg, &hwirq, &type);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * For TINIT interrupts ie where pinctrl driver is child of irqc

Minor pick. Typo TINIT->TINT?? Similarly, 2 other places below.

> domain
> +	 * the hwirq and TINT are encoded in fwspec->param[0].
> +	 * hwirq for TINIT range from 9-40, hwirq is embedded 0-15 bits and
> TINT
> +	 * from 16-31 bits. TINIT from the pinctrl driver needs to be
> programmed
> +	 * in IRQC registers to enable a given gpio pin as interrupt.
> +	 */
> +	if (hwirq > IRQC_IRQ_COUNT) {
> +		tint =3D TINT_EXTRACT_GPIOINT(hwirq);
> +		hwirq =3D TINT_EXTRACT_HWIRQ(hwirq);
> +
> +		if (hwirq < IRQC_TINT_START)
> +			return -EINVAL;
> +	}
> +
> +	if (hwirq > (IRQC_NUM_IRQ - 1))
> +		return -EINVAL;
> +
> +	chip_data =3D kzalloc(sizeof(*chip_data), GFP_KERNEL);
> +	if (!chip_data)
> +		return -ENOMEM;
> +	chip_data->tint =3D tint;
> +
> +	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &irqc_chip,
> +					    chip_data);
> +	if (ret) {
> +		kfree(chip_data);
> +		return ret;
> +	}
> +
> +	spec.fwnode =3D domain->parent->fwnode;
> +	spec.param_count =3D priv->map[hwirq].args_count;
> +	for (i =3D 0; i < spec.param_count; i++)
> +		spec.param[i] =3D priv->map[hwirq].args[i];
> +
> +	ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &spec);
> +	if (ret)
> +		kfree(chip_data);
> +
> +	return ret;
> +}
> +
> +static void rzg2l_irqc_domain_free(struct irq_domain *domain, unsigned i=
nt
> virq,
> +				   unsigned int nr_irqs)
> +{
> +	struct irq_data *d;
> +
> +	d =3D irq_domain_get_irq_data(domain, virq);
> +	if (d) {
> +		struct rzg2l_irqc_chip_data *chip_data =3D d->chip_data;
> +
> +		kfree(chip_data);
> +	}
> +	irq_domain_free_irqs_common(domain, virq, nr_irqs); }
> +
> +static const struct irq_domain_ops rzg2l_irqc_domain_ops =3D {
> +	.alloc =3D rzg2l_irqc_alloc,
> +	.free =3D rzg2l_irqc_domain_free,
> +	.translate =3D irq_domain_translate_twocell, };
> +
> +static int rzg2l_irqc_parse_map(struct rzg2l_irqc_priv *priv,
> +				struct device_node *np)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	for (i =3D 0; i < IRQC_NUM_IRQ; i++) {
> +		ret =3D of_irq_parse_one(np, i, &priv->map[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rzg2l_irqc_init(struct device_node *node, struct device_node
> +*parent) {
> +	struct irq_domain *irq_domain, *parent_domain;
> +	struct reset_control *resetn;
> +	struct rzg2l_irqc_priv *priv;
> +	struct clk *clk;
> +	struct clk *pclk;
> +	int ret;
> +
> +	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base =3D of_iomap(node, 0);
> +	if (!priv->base) {
> +		ret =3D -ENXIO;
> +		goto free_priv;
> +	}
> +
> +	clk =3D of_clk_get_by_name(node, "clk");
> +	if (IS_ERR(clk)) {
> +		ret =3D IS_ERR(clk);
> +		goto iounmap_base;
> +	}
> +
> +	pclk =3D of_clk_get_by_name(node, "pclk");
> +	if (IS_ERR(pclk)) {
> +		ret =3D IS_ERR(pclk);
> +		goto iounmap_base;
> +	}
> +
> +	resetn =3D of_reset_control_get_exclusive_by_index(node, 0);
> +	if (IS_ERR(resetn)) {
> +		ret =3D IS_ERR(resetn);
> +		goto iounmap_base;
> +	}
> +
> +	parent_domain =3D irq_find_host(parent);
> +	if (!parent_domain) {
> +		pr_err("%pOF: cannot find parent domain\n", node);
> +		ret =3D -ENODEV;
> +		goto iounmap_base;
> +	}
> +
> +	ret =3D rzg2l_irqc_parse_map(priv, node);
> +	if (ret) {
> +		pr_err("%pOF: cannot parse interrupts: %d\n", node, ret);
> +		goto iounmap_base;
> +	}
> +
> +	ret =3D reset_control_deassert(resetn);
> +	if (ret) {
> +		pr_err("%pOF: failed to deassert resetn pin, %d\n", node,
> ret);
> +		goto iounmap_base;
> +	}
> +
> +	raw_spin_lock_init(&priv->lock);
> +
> +	ret =3D clk_prepare_enable(clk);
> +	if (ret)
> +		goto assert_reset;
> +
> +	ret =3D clk_prepare_enable(pclk);
> +	if (ret)
> +		goto disable_clk;
> +
> +	irq_domain =3D irq_domain_add_hierarchy(parent_domain, 0,
> IRQC_NUM_IRQ,
> +					      node, &rzg2l_irqc_domain_ops,
> +					      priv);
> +	if (!irq_domain) {
> +		pr_err("%pOF: cannot initialize irq domain\n", node);
> +		ret =3D -ENOMEM;
> +		goto fail_irq_domain;
> +	}
> +
> +	return 0;
> +
> +fail_irq_domain:
> +	clk_disable_unprepare(pclk);
> +disable_clk:
> +	clk_disable_unprepare(clk);
> +assert_reset:
> +	reset_control_assert(resetn);
> +iounmap_base:
> +	iounmap(priv->base);
> +free_priv:
> +	kfree(priv);
> +	return ret;
> +}
> +
> +IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
> +IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
> +IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
> +MODULE_AUTHOR("Lad Prabhakar
> +<prabhakar.mahadev-lad.rj@bp.renesas.com>");
> +MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1

