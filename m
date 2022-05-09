Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA4051F54C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiEIH3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbiEIH0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:26:40 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2110.outbound.protection.outlook.com [40.107.113.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C693CF29DA;
        Mon,  9 May 2022 00:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPpe/SatYlxSF3AhaQtJO5yYd60eF0KzPK30K6rwGkyPmDYxKMw/9UkzvFr70K/FlIGR6i6jDgTJMxEgompal44RqMpGN3OrF7loTVYg265KaxEPzS7CAmQK6TnRbJUAjUHgp7dnbBMPxGhUOHl0zR9fpIy6HPzfjJxVPll/aQwvuAtyW1IeFyKa6REbA+ZZHJUTa31/duMPTFHMRSV0RmPjLMQKyc09L8hRwFK65HHo+YMeWQvWdjQPZTIs398ODGkYXGsm5WAji3o30AK0LQe+yFzu12TNxU6aOfFaxKwCzxdXzL+Frf8mHSZp/FzrIs3DolKWT51FRiafko+GxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8tdCjJcyViViq4A6d2ZQ+yv2KvG5+bzQg/ZtSHjQ7I=;
 b=klybATdLHWcb+/+fGR8Q8yUTWFhbq1mluWWi8MJiO83FWFUyhAfONvp3yURdTjlJmixjdpH5vqHvslEolbJrGTPvrr6LUa3aED41JojIqvPH7+rwLGPAN0bAJvAHC5nt+AdXgGbEYBJEMTPXiv1J3H15E4b4q2K5/JwFVD1TxAAgwDXlbCMjSC6z8cGkrijLxYZhJ1cfduo+hVqMlw4DyQ5pWib4FXs9nCU6wjLfYZywm9mBxS/FiNW3ftGf7LUKaxDZfh3sEzUtjRvZhuj71XnS7EMWcgRQDXh04PzGtFPlGrjIvMGbBA/5GFWFTOzMeB8DF6HvTreALQT+dZsUog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8tdCjJcyViViq4A6d2ZQ+yv2KvG5+bzQg/ZtSHjQ7I=;
 b=PYCg+6lubzSH4NH9r2ZdhA++Ww0QUeDEEKvn37/c4+3s5zANOE5L+piPBFAR3a2YToPExWoQFDd8Y/dy0I202fxbRtEzwazttxC5ZdL2NrJ2OunAoORdmSnSaGFosDsmMz+I2ZZDRt7gUJUQW2pVPFP7X9yS47v1Wn+curL9HCA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5515.jpnprd01.prod.outlook.com (2603:1096:404:8031::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 07:22:17 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 07:22:17 +0000
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
Subject: RE: [PATCH v2 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller
 driver
Thread-Topic: [PATCH v2 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller
 driver
Thread-Index: AQHYY2MbQjblJUq3sUO9QcDIGdXk560WIB+w
Date:   Mon, 9 May 2022 07:22:17 +0000
Message-ID: <OS0PR01MB5922B58BB70B92813041745786C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220509050953.11005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220509050953.11005-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220509050953.11005-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43389423-cb4c-431b-1d2e-08da318ca608
x-ms-traffictypediagnostic: TYAPR01MB5515:EE_
x-microsoft-antispam-prvs: <TYAPR01MB55156F48D75FA7666D121B9486C69@TYAPR01MB5515.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vTSP3CngW6v7CV3rwuL/s8+CA3H0uuFDXPi/jVNaMEPpMXy/xeBEr6hHKdy6H+m24TFcdMcifP/hOEdfqzhDItFS5h0G0OAL7z/oJZ6t7dktYRcvrvtbx0iwK3YjMQB0teSTFZvudfDcNABlBLKfO9s4mmQUaX+1mUJsELOxdWZUPK82PO4d1xhshKr+fGHp8cB4JYcxvixlv2OKD8djWEg+Gm9Y4v+5w9MM3AELpbWrAfB2m3wcXPqzjPmwQ/ag9t5QElltE3gL3R0ALNKzWOo7UXKz4K7Z/Hy80R93/a7V8dLB2Mb+1Kzll+L+tKIYLnzsKYlUMg0k5yfARQf8oLAuI/61TZ+GGW7ebcPEtdwonDGOCQ2y8eR9gsxtruCJUvdIZ/IWQGMmR2cbXH8fPOsUQJgcFE2NIl2qI0ucx8WQTmp+uwKGsGyEhZUSLJU7KlKhZapif21lE5ySXQjsopkcvEeeB9s6QYpCRNCe/msyfdfc8PO98Pri6KxUElmdlG9loL8hLkIKn+otlFdsP7RcBf8PjDKombI/yi/b5OHEI9zOyFENXoSd612rIGHpKVz61SpiQM7yP6ulRMfkAGkkzvuHM0zmwiAJ0ski5wzwX2rD4wUOUkXnm59aNpMEA72tE66pC3Wi9x+e4qNqyQMQl9E4mU/9bfF6mw/hajrSb8ZTdEJaY9KdnvUjrEh8JSsybtUwFWAX8iznN1WpS7Kwj3JnnteP1LVL07cPYKs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(76116006)(66946007)(83380400001)(64756008)(38100700002)(2906002)(8676002)(38070700005)(66476007)(921005)(66446008)(66556008)(508600001)(54906003)(55016003)(7696005)(110136005)(52536014)(316002)(6506007)(71200400001)(33656002)(30864003)(26005)(9686003)(107886003)(7416002)(5660300002)(186003)(86362001)(122000001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K74QsMAElERvXHmneJSl1qy+ajiTwUus/GGnBxqbpg4z4ByGPi8NrW1/YZlQ?=
 =?us-ascii?Q?Fcs2wAKlP4ULn4bWu5pOZwPmvAEmorJYf8jcRXhnM9OMJ2OPGYWhg8u65GfT?=
 =?us-ascii?Q?KPoQ9YcP7uKCNDQuZIf8xCjxWErCsIc2QImUDfw8wlJhaUlzW3N8DAc4a0m6?=
 =?us-ascii?Q?dQxBLXBO8XyzpzFnlemTcrugGj0wnie8Tk5Qe3kZot+eQezfLFnaxVkPFyff?=
 =?us-ascii?Q?BRsav5GXc+AShJPQcsPhbToTygaLgkMbz/88ydp/OdHozjGY0CWcQqyC4z5G?=
 =?us-ascii?Q?KPrMYmRGP7wTa0sPhTKFpCA4eyn/Nh3mYl94JaYSrvYvYph5tHZ9fYs7r1PI?=
 =?us-ascii?Q?KMxdK/wnlBfiRBrU2j6BhqIaq6Pj6iIZfcvLpSFBm2Iy9aYs5iIiSHN/3b2y?=
 =?us-ascii?Q?LSWnywK9O6f6/VqQzrdhy7FhEYWZxiW7kJ1KuevWFfy086sV43pxobSgKcKZ?=
 =?us-ascii?Q?AJ6lyxjrsrlnEWYiHazhpWjH+ogPvjaIVMH0fMSprqYzcBPPTRfORWR3U0ae?=
 =?us-ascii?Q?ELtLh+MbPn3aPW8u2nq86bAxUqPTH0aHA+CQ7fC+J80YAgyDB+qAzHXpUZD6?=
 =?us-ascii?Q?WUZl8Wk/qTEMobn/71QXStlTCfSU3QwviQrDz4dyn7hp/yd4/RUKwI6FPv1d?=
 =?us-ascii?Q?uaKeuLPqIYoMw7OHMHBCjf0WKAttgAEWc7DqdtKB+sXblJmvOSmJTXLxn1BV?=
 =?us-ascii?Q?44rKwDYsRbN4fsX5eBvx6fBcMdrlrJac7OfrdmkuhxyWwpv5ftlZdXBQ4UUY?=
 =?us-ascii?Q?o7Fa77bpWFmQtNfErJniZctB/KOVST+qWnZZ1uqlDs3791FVTzOAmqpI8B0z?=
 =?us-ascii?Q?G5OoBEIT+GO77f0FThiv8g52P6d65IAfmJPyyzxZu1Qbe/inSIfTi9O4Poze?=
 =?us-ascii?Q?veC16U96nWe0UMAPBpYoQZFnh+2aw7DDqyEG9ScYN2p8Vz6pBOuPA8JIf1yU?=
 =?us-ascii?Q?m6PHfsvIlX3wiLuu4t3xmIa2shJs6oa8rWdJP4riXRTyEDnN4j/KWmgp8pNa?=
 =?us-ascii?Q?aYyMAA2D16xGbxpIVuS0OecWcnsWwGSAwP6QrCWftAHmgiI8MSFuekXUdeBB?=
 =?us-ascii?Q?jgYdhpICpU0KCJCY1cqu2Jl2cJbydg5mrOlV7RiFmNIDDGZpJX3nrSstDdCj?=
 =?us-ascii?Q?XkPtUZsJ77lu4XOhHUqtZiMj8VKqao4XGiNHXaHb6frGSDiG2R1EYcjEIYWn?=
 =?us-ascii?Q?ua5msK5vyIKczN75QzUgCyxEN9dNFndoFiqgoX9ct+2BRCrn5ZZ9XcMSS2xz?=
 =?us-ascii?Q?sQO/d1Dq1A5EIHdTN1qydxUIE5IfR1Uvv0WNX10689ktLRvDuSNJOL1rnBUp?=
 =?us-ascii?Q?tWAjvQCEAsn98uGYbz3FxTZ02bSZJ0hplMm5VVkd7KbITeWSmx45RC2+iCDO?=
 =?us-ascii?Q?PdIKn5rBWhty6GKJ364w6+OE9O4UsBYIhd5k8kyPE36cmUEPoIEq3CRSDVRH?=
 =?us-ascii?Q?wgi7O3RcTP5D9Fit3L2CuPiv5Qb1j7gVd0jtdikwnRtsATJ6dUOmc/oR0RlL?=
 =?us-ascii?Q?eRaQsAEsDYhRsx/eGNuWYFeXnxQN7RjkIrUhY3LJ2H61GVTFjUAdbR4vLecE?=
 =?us-ascii?Q?WMRD+fCeW7Akzm1hGcuiX2p511OOTvVAOhlOWMlzZb7dSOxbWKfvjlyrSf1Q?=
 =?us-ascii?Q?PFVcGJhxq7vv22Alxo8hOiKfZIevCYbRl+IDYO6djmRMVuJk4S2w7kZ/ce7y?=
 =?us-ascii?Q?KQWmKfV/lQnZq6DIJ1CYTiodsv1HZ5rH2U2/voF9WvlDQcX7AEOfG2bQ6N1w?=
 =?us-ascii?Q?TSpjChH8HCDbVo+b/2v8xcB+6cTKq6s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43389423-cb4c-431b-1d2e-08da318ca608
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 07:22:17.6922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pA7JVTNcg9GQsKl8zqPYYoKsLwKOoUIKHqR+KB/Df8CqZTcpiLc4+3T/eBnnnr3waf+iNVPx/PwA4DF2S5ovNVNPV8eaTF7cWmofy+jeChM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5515
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

> Subject: [PATCH v2 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller
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
>  drivers/irqchip/irq-renesas-rzg2l.c | 445 ++++++++++++++++++++++++++++
>  3 files changed, 454 insertions(+)
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
> index 000000000000..bd6e82100caf
> --- /dev/null
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> @@ -0,0 +1,445 @@
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

> +	if (titseln < TITSR0_MAX_INT) {
> +		offset =3D TITSR0;
> +	} else {
> +		titseln /=3D TITSEL_WIDTH;
> +		offset  =3D TITSR1;
> +	}

as TITSR0 (0x24) and TITSR1(0x28) are contiguous address location

May be like others, above declare it as
u32 offset =3D TITSR0; ??

and here
 if ((titseln >=3D TITSR0_MAX_INT) {
	titseln /=3D TITSEL_WIDTH;
	offset  +=3D 4;
 }

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
> +	}
> +
> +	if (hwirq > (IRQC_NUM_IRQ - 1))
> +		return -EINVAL;


> +
> +	if (tint !=3D -EINVAL && (hwirq < IRQC_TINT_START || hwirq >
> (IRQC_NUM_IRQ - 1)))
> +		return -EINVAL;

hwirq > (IRQC_NUM_IRQ - 1) is redundant check, as it is checked above.


Cheers,
Biju

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

