Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D171358DA9E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244660AbiHIO6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbiHIO6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:58:09 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150075.outbound.protection.outlook.com [40.107.15.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8156315A3F;
        Tue,  9 Aug 2022 07:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGiDQ5ZyjEtapMJ1XfLL+76Vc7E64mkiPDPetGsaz0rB79+LEW43XJCA7p3TqOe7e8BhyZqBTKXdX3HkL1Ao41lTjx0izLuZfMy/dyaeNPDMhVkNuMpaDWufb1GMDqV6sOEIIwlogw1p43Oqd0Pz9Ur8t329CRuOeeYLvd2+ipffa2EPXlpjrTzE4IC+Pn4mF1xT2DcndlVwBsr6AnkPJcWWnY1DasYLYKoPdoWpr4uewxTmt+7hrdGuvsTCZjIfZ/RsFZn8f+vLlWEtuwxlVsH942xv44ltuesmkblLg0nIhegzLAVsWlyU2TcAiwnRWra63/gbIsYr3UMP/1YhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwAQULlBSa6fXxOXQS3Rvc9fzDyHC2TgFhlcsljP5Jk=;
 b=esq5MvgG8Kr4TSTBOuSUwSlf7tRZrw2y+TYsPBgwmW2ETOHSCrrr2Pq5fDHUglA8fD+IhDmtXkmti7O2n/gmXpXSZmp5imkdsXq+xC/5NBkW/z7udytTfafiwrxev8RGjpZqpgpuqHIjCHA6BjNYDY99Eqbch2sWcL3KO4WX9STO6ocmXn+qEfztDInryQg+LmA2YnIzmcuJqsUenLC2euTBv6MuUhZVGhRhR5pSwdhS/cz+gux/xKfQiDpREh+oq09kE+65RkyDwNthYT4EUhJhRJoUli7oHbRYcngxgJwmJgGPWoj5NzRIUrSzgM8777unbsRvB62kaa/Dp2n0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwAQULlBSa6fXxOXQS3Rvc9fzDyHC2TgFhlcsljP5Jk=;
 b=V5fLYr8TqTlt2ZsqiMpy996BYFuYcsDcjzZ8NRYLxMqfdBaNZRH4E73Inmdsxq8adsPH9v67toh8Hft6Xbt2OBVt/wynnJcqId4lalXiDNYY9Nz1rRdMAEA+dZ+UYzcTzQUH2kpvoPq/IbNDlXnOF1z544bEQESZRtaiip1fvviw5A6bIdD7QMkVq6RCpBhYC3rFUGDnCwB6AP9mtUqQHzKvUZgL0Tc0sREr3EUPrmGomscQUE9B/7+rj2eI9RwKDo0oonlSKUG09GPlzX9f7j+4RaixgrUlpX1ifHVqpDyOty7/3vSQf93Vs41dkIipmEHFogiObK8tdSflckwTPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB4PR10MB6166.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 14:58:03 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 14:58:02 +0000
Date:   Tue, 9 Aug 2022 16:57:55 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
Cc:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/4] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
Message-ID: <20220809165755.252f34d0@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220728155652.29516-2-henning.schild@siemens.com>
References: <20220728155652.29516-1-henning.schild@siemens.com>
        <20220728155652.29516-2-henning.schild@siemens.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:610:50::21) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97237726-bafb-4e86-f019-08da7a178ee8
X-MS-TrafficTypeDiagnostic: DB4PR10MB6166:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZFxhGANjr/UPwOaqm23ldU+DTBA30nBLhhn1Tol4hTUyLc3EOhIuNqzNi9lvRxy19gkvDn3C2rPp/VIE/vo8T7abTunPrT+nAt+gzp5KjaKQOPRwvoazYQbVnQ4WWkGvYYx+oL9eGZsaWVtyJ988GfF6PRpx8E42e3g9lpz9/1PKGgWo6jRqFGubrMnD63FP+PKjRuIQSXBist1gqLksffAjGInHOMBT0ddR5VALx1ZeqrqsQDPj6vfh8OtcnPwsYhqnHvjFtORhL1g6oX/8i2HX1zf5c615xVJI/ktKEU07V+XnFMAqfFL178G6QqQEQyEKvPK3KeF8A3EvVoqwkspn+eiqixOdda+g30UJ8PMugQn/pfh42diptenr0VcYG//lkcBm0d2v0TBRQcv8qV7OhWQadWI8YVhmHcO0NqPzwAqhlgG2RsOFzQLU6hp+T0RDzM1OEA7/Q1YxcHl/+Shn4+9Em7+4XbYopBlg2Vwlc1ZcYnhI8iogObqF/0XqxqPwm90Ff/qtsp6exqwnu3g0XijdjGG4wIccTwrxkERlFWzgYRH2WUUIRFyQnzRHIxO3+NkZHX4cm9wAhE8wo0a4dTHm9Wn2zMAG7FWpyNdjkeGS1I6eeLLtAQDDvECS+GpFN15pJj9LHe/mpztPesXzUA4x4U2vjkId/8Mxud66hhD5ySsuhBv+mQTsJeiLwo3NhwD/dXzIq0YwRbeST7t6795fEH/ShD9tL8dhZzDd2FiQKO2r3LTzuTNPhZIi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(66946007)(4326008)(66556008)(41300700001)(186003)(1076003)(9686003)(66476007)(6506007)(478600001)(316002)(6666004)(6486002)(6512007)(110136005)(86362001)(82960400001)(26005)(8676002)(2906002)(5660300002)(8936002)(83380400001)(38100700002)(54906003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O9p0qguYE6ZLQv5zLjivDJEB1nFKLd25MNjg6uRtJU73D1mCwrI/62rQWoq8?=
 =?us-ascii?Q?0WH2YR8+mfUrXeXWpuPlOq/IhjWH3Sc6fzfqbUjSQvufymBdNF1tCdNJH4oc?=
 =?us-ascii?Q?tiWhVZVNZVLGyi5qm4EdB2q769BB1osNoqHftB+KCoiDO5fZR4Dlx/83Y34p?=
 =?us-ascii?Q?LtJ/ctZjdQgFEkUhDOEfdiYKeBjdMxOJQzgFu7nHDcHsL/SYQadT4HnDGoe6?=
 =?us-ascii?Q?Bqncm4ZDP5EtoI2WRQSaX0H1Bg2mLgjZG0TSBPB36Bnl2Lu/a53NBo0d/HDY?=
 =?us-ascii?Q?/SVPTNtYAlIb7LPJ6s6uejqED7WlwNVgl7/2H0edtXVLqN+91OExBJIiYRFp?=
 =?us-ascii?Q?EmcwssuAmCgNfci26LZ7wmMMDKH7h/PsuHxmHigAZs8suNhywH+05NbSTw3U?=
 =?us-ascii?Q?Yg3Jt7r9sDquGrR/R4xqhsV2Xnq5sGqrD22iDWiBR/YW1C9jHqhztbW2OxOz?=
 =?us-ascii?Q?eGflCFrSK1HyacLYm6L8SZoYy4vXHl98KgLCo8tbfkaO6xPWiV1Hq9fkLjIf?=
 =?us-ascii?Q?Bc8efgV/MYY1NkWVAfWlM97l9CrBrQLNLHLDOSe8jztNxWBIxSaLcx8gySm8?=
 =?us-ascii?Q?OMWV/sMmHkBzPDb4RfQpnu0KCtqkVzcQjo6GuIxkOWMHQB+goKjc8wA3zPNu?=
 =?us-ascii?Q?uJZAbYrxHpqb6TdYK8Xr8E8rI75srz1M7yqlsdycYcdVtlnU9B5tE9J3kNLq?=
 =?us-ascii?Q?902SeX7Yvv00k3ANPJazz+MiBltNFKC2qOxWgaYhVwqILPj2m/TpEvNFE0RJ?=
 =?us-ascii?Q?5d39AY2pLyUvN+SVcMAS/dpLglK7Zl1n/yZuHEczIOb9XIo9v/VDZjcVGR02?=
 =?us-ascii?Q?ARzykkLR5VpEnMbZWHB2YVIWYQhinlfuZtD6QZ6Q9FMjXn7f3d5g6nFaIViG?=
 =?us-ascii?Q?Nb9hBj7JE07elJUg/I+poeqwjCtBKCkGgtTuQxy/2Zbvb3nXm7hh0MSlmwGi?=
 =?us-ascii?Q?g6+/iwp0Z1znk9LODrDvqS3mQSdpCqzIrCFRIkfNIipkV2APjuR9zzIVzllX?=
 =?us-ascii?Q?a/oe9CYAjozSjTyUhqcFtBu3qRPtJB/P4/3XVqpP6JeijIdHZiTXhfgEgab8?=
 =?us-ascii?Q?BGq0wObnk6HLlMoXTyZJKPNkipidI+sqhn/wZy45PSbVpGQAhSK7L/YzgHvg?=
 =?us-ascii?Q?K8x4Vguu9qGHb/9sMhNmvDp+EnLu9VKbFJDa6RhhvtejA54LyoBsYOQzacHr?=
 =?us-ascii?Q?iezsKFdZrfDkLfBMWhSvx2VuOyU9FIb/PAx+HcXH5fIX8tp3Blo4LFQe3SUE?=
 =?us-ascii?Q?GpWiauHqjoruLZ+bTClWLMfL6t0jOiR2fNhzk9tBrkE10W7WNoXx/3kXJvyo?=
 =?us-ascii?Q?yoczGNL0kqWOe37VI0HIzrnYiu6jyulXH5YAD2SERMoqn5SnxXZtrZzZt06w?=
 =?us-ascii?Q?hpVT3EB0TqRJnwEnZluyEjNwr8Jqq0jd0BoYVkQvSfWY4pcKpwjKq4oWU5Du?=
 =?us-ascii?Q?azqpXpugZKTbPDYxYz1a9rg4X7KMPfC+iS/Bid4m8jt9dqA8j9V0dMgkq6Xl?=
 =?us-ascii?Q?YgBG8iwVAy3LMKEOyyvQv8cRLyzXE90lhZMJPZiUoPlvDtH1re92x0yLuxSu?=
 =?us-ascii?Q?o7W526afD56BYAVQqIUszGoc3FzOm0TyURq6kWX4whrk8uzJpE/qKrb/G9nA?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97237726-bafb-4e86-f019-08da7a178ee8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 14:58:02.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42MqGZWSKaoaz+xNXyQMoxbVDv5rrTim5jCHue9yR1dOzWu4NP+7r6R/dIctegaEPkoDMQjruy2JQkBuDP1w6gpR7n5JqcNz6p31bMnH6Dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6166
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 28 Jul 2022 17:56:49 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO chips are
> very similar to the ones from Fintek. In other subsystems they also
> share drivers and are called a family of drivers.
> 
> For the GPIO subsystem the only difference is that the direction bit
> is reversed and that there is only one data bit per pin. 

In fact the modification of f7188x_gpio_get is missing in this patch,
the function needs to be modified for this chip variant, where the
given bit has another meaning. (value invert, not used in the driver)

Will send a fixed version

Henning

> On the
> SuperIO level the logical device is another one.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/gpio/gpio-f7188x.c | 70
> ++++++++++++++++++++++++++++---------- 1 file changed, 52
> insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> index 18a3147f5a42..431ce2cda1d8 100644
> --- a/drivers/gpio/gpio-f7188x.c
> +++ b/drivers/gpio/gpio-f7188x.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * GPIO driver for Fintek Super-I/O F71869, F71869A, F71882, F71889
> and F81866
> + * and Nuvoton Super-I/O NCT6116D
>   *
>   * Copyright (C) 2010-2013 LaCie
>   *
> @@ -22,13 +23,11 @@
>  #define SIO_LDSEL		0x07	/* Logical device
> select */ #define SIO_DEVID		0x20	/* Device ID
> (2 bytes) */ #define SIO_DEVREV		0x22	/* Device
> revision */ -#define SIO_MANID		0x23	/* Fintek
> ID (2 bytes) */ 
> -#define SIO_LD_GPIO		0x06	/* GPIO logical
> device */ #define SIO_UNLOCK_KEY		0x87	/* Key to
> enable Super-I/O */ #define SIO_LOCK_KEY		0xAA
> /* Key to disable Super-I/O */ 
> -#define SIO_FINTEK_ID		0x1934	/* Manufacturer
> ID */ +#define SIO_LD_GPIO_FINTEK	0x06	/* GPIO logical
> device */ #define SIO_F71869_ID		0x0814	/*
> F71869 chipset ID */ #define SIO_F71869A_ID
> 0x1007	/* F71869A chipset ID */ #define SIO_F71882_ID
> 	0x0541	/* F71882 chipset ID */ @@ -38,6 +37,9 @@
>  #define SIO_F81804_ID		0x1502  /* F81804 chipset ID,
> same for f81966 */ #define SIO_F81865_ID		0x0704
> /* F81865 chipset ID */ 
> +#define SIO_LD_GPIO_NUVOTON	0x07	/* GPIO logical
> device */ +#define SIO_NCT6116D_ID		0xD283  /* NCT6116D
> chipset ID */ +#define SIO_GPIO_ENABLE		0x30	/*
> GPIO enable */ 
>  enum chips {
>  	f71869,
> @@ -48,6 +50,7 @@ enum chips {
>  	f81866,
>  	f81804,
>  	f81865,
> +	nct6116d,
>  };
>  
>  static const char * const f7188x_names[] = {
> @@ -59,10 +62,12 @@ static const char * const f7188x_names[] = {
>  	"f81866",
>  	"f81804",
>  	"f81865",
> +	"nct6116d",
>  };
>  
>  struct f7188x_sio {
>  	int addr;
> +	int device;
>  	enum chips type;
>  };
>  
> @@ -254,6 +259,17 @@ static struct f7188x_gpio_bank
> f81865_gpio_bank[] = { F7188X_GPIO_BANK(60, 5, 0x90),
>  };
>  
> +static struct f7188x_gpio_bank nct6116d_gpio_bank[] = {
> +	F7188X_GPIO_BANK(0, 8, 0xE0),
> +	F7188X_GPIO_BANK(10, 8, 0xE4),
> +	F7188X_GPIO_BANK(20, 8, 0xE8),
> +	F7188X_GPIO_BANK(30, 8, 0xEC),
> +	F7188X_GPIO_BANK(40, 8, 0xF0),
> +	F7188X_GPIO_BANK(50, 8, 0xF4),
> +	F7188X_GPIO_BANK(60, 8, 0xF8),
> +	F7188X_GPIO_BANK(70, 1, 0xFC),
> +};
> +
>  static int f7188x_gpio_get_direction(struct gpio_chip *chip,
> unsigned offset) {
>  	int err;
> @@ -264,13 +280,20 @@ static int f7188x_gpio_get_direction(struct
> gpio_chip *chip, unsigned offset) err = superio_enter(sio->addr);
>  	if (err)
>  		return err;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
>  
>  	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
>  
>  	superio_exit(sio->addr);
>  
> -	if (dir & 1 << offset)
> +	if (sio->device == SIO_LD_GPIO_NUVOTON) {
> +		if (dir & BIT(offset))
> +			return GPIO_LINE_DIRECTION_IN;
> +
> +		return GPIO_LINE_DIRECTION_OUT;
> +	}
> +
> +	if (dir & BIT(offset))
>  		return GPIO_LINE_DIRECTION_OUT;
>  
>  	return GPIO_LINE_DIRECTION_IN;
> @@ -286,10 +309,14 @@ static int f7188x_gpio_direction_in(struct
> gpio_chip *chip, unsigned offset) err = superio_enter(sio->addr);
>  	if (err)
>  		return err;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
>  
>  	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> -	dir &= ~BIT(offset);
> +
> +	if (sio->device == SIO_LD_GPIO_FINTEK)
> +		dir &= ~BIT(offset);
> +	else
> +		dir |= BIT(offset);
>  	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
>  
>  	superio_exit(sio->addr);
> @@ -307,7 +334,7 @@ static int f7188x_gpio_get(struct gpio_chip
> *chip, unsigned offset) err = superio_enter(sio->addr);
>  	if (err)
>  		return err;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
>  
>  	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
>  	dir = !!(dir & BIT(offset));
> @@ -332,7 +359,7 @@ static int f7188x_gpio_direction_out(struct
> gpio_chip *chip, err = superio_enter(sio->addr);
>  	if (err)
>  		return err;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
>  
>  	data_out = superio_inb(sio->addr,
> gpio_data_out(bank->regbase)); if (value)
> @@ -342,7 +369,10 @@ static int f7188x_gpio_direction_out(struct
> gpio_chip *chip, superio_outb(sio->addr,
> gpio_data_out(bank->regbase), data_out); 
>  	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> -	dir |= BIT(offset);
> +	if (sio->device == SIO_LD_GPIO_FINTEK)
> +		dir |= BIT(offset);
> +	else
> +		dir &= ~BIT(offset);
>  	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
>  
>  	superio_exit(sio->addr);
> @@ -360,7 +390,7 @@ static void f7188x_gpio_set(struct gpio_chip
> *chip, unsigned offset, int value) err = superio_enter(sio->addr);
>  	if (err)
>  		return;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
>  
>  	data_out = superio_inb(sio->addr,
> gpio_data_out(bank->regbase)); if (value)
> @@ -388,7 +418,7 @@ static int f7188x_gpio_set_config(struct
> gpio_chip *chip, unsigned offset, err = superio_enter(sio->addr);
>  	if (err)
>  		return err;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
>  
>  	data = superio_inb(sio->addr, gpio_out_mode(bank->regbase));
>  	if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN)
> @@ -449,6 +479,10 @@ static int f7188x_gpio_probe(struct
> platform_device *pdev) data->nr_bank = ARRAY_SIZE(f81865_gpio_bank);
>  		data->bank = f81865_gpio_bank;
>  		break;
> +	case nct6116d:
> +		data->nr_bank = ARRAY_SIZE(nct6116d_gpio_bank);
> +		data->bank = nct6116d_gpio_bank;
> +		break;
>  	default:
>  		return -ENODEV;
>  	}
> @@ -485,12 +519,8 @@ static int __init f7188x_find(int addr, struct
> f7188x_sio *sio) return err;
>  
>  	err = -ENODEV;
> -	devid = superio_inw(addr, SIO_MANID);
> -	if (devid != SIO_FINTEK_ID) {
> -		pr_debug(DRVNAME ": Not a Fintek device at
> 0x%08x\n", addr);
> -		goto err;
> -	}
>  
> +	sio->device = SIO_LD_GPIO_FINTEK;
>  	devid = superio_inw(addr, SIO_DEVID);
>  	switch (devid) {
>  	case SIO_F71869_ID:
> @@ -517,8 +547,12 @@ static int __init f7188x_find(int addr, struct
> f7188x_sio *sio) case SIO_F81865_ID:
>  		sio->type = f81865;
>  		break;
> +	case SIO_NCT6116D_ID:
> +		sio->device = SIO_LD_GPIO_NUVOTON;
> +		sio->type = nct6116d;
> +		break;
>  	default:
> -		pr_info(DRVNAME ": Unsupported Fintek device
> 0x%04x\n", devid);
> +		pr_info(DRVNAME ": Unsupported device 0x%04x\n",
> devid); goto err;
>  	}
>  	sio->addr = addr;

