Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA3B59C1FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiHVO6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiHVO6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:58:40 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20060.outbound.protection.outlook.com [40.107.2.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C865DF21;
        Mon, 22 Aug 2022 07:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bu5iP8jvD+J9kBE4VrbjszZHqwWaptQbmIr/6zE1YO1ywtGY7KoVFxxC11gjqxOnAPdYR2O0IpZB4vHfc1d4mtblBthBUBA9B/3VaUZ9cE84BseP4aV5H+CuSKoOIAwY5B9zQiFHmLLbIWuKh321roiHX7PMRy77MYMNS1H4AEV+M+jnTAqUVW8tNJ4yM8wbjgFw4HQQbRjhrKVnslaf6FfKqEH3pfmM8zKZ59ipXBFH95hCocWykRlGPfVe2qr/slzD4QG5odHdk+KN8DbWuxfFrFNXMjIdi9629cSA/TrVgLmr8X67zQqmIj25buvaZmQK6uVRa6q67CS4H+Tsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJYGu8VCO6uWZNqNtlg/SuFgD1KzkdAeuwCJSvK3RGU=;
 b=bHi3vjXCicOpb/2+HTr6yHw3EZFH2sYiXjhk+Fpydv8G5dIltQefBPcDen/4moKqTtZ0eXFLJjM+Lc/zgxGxuJ3m4d7e/OlzgZcq+7A/oxt2XMuBJLTNAsQR2YensPepzFIXKHQSBz2/WemONluzvSuwqGk3Ra9BrBeDZhH/1Ykvr63HxlhD+2RuA51GLCt+YKd3QyW07pzn4FN9tm6T3V81EBcKAVVRADQGW48P0pmrNIrPpKzprML7uvcDbvcBpyXfkphpdWmAlVPRK1LIUn3Lz8CWh2YADhtFbzyTUVJ26KTSVQ50nvJlb6pGXIAQIjAV52bEZeP0szqLwCaGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJYGu8VCO6uWZNqNtlg/SuFgD1KzkdAeuwCJSvK3RGU=;
 b=PavCwrFhM13biuyPTVFVE/zJkXm+WxdLwzADEe02Ce3P41m8QgYNIviPZQ/b8mj5TJQlikgt0wpV5GYvOLL/b9JM5Zx2qqhOIAB4xEurgWddDO21NC9GDd7KYlkPrj/H1BWSba66REjqRuzZMC1/pRBig9DZQg6gbtjO637BoAdVU7kdJFJeQdvrzKl+Xj8lKA1Py3wWH+igko57b8zMwrc/ObpRk76a308RQ3ark2mNDQZsRGyQmolqeGF14S76uk+UIh4yz7Otk0musTEY5EWF/JjnapbvHgkLyq88wENdnyKncyrm4yIRvPFXZnDFH1OUtX7lPNDMfqjNBHfFoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AM7PR10MB3528.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 14:58:35 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 14:58:35 +0000
Date:   Mon, 22 Aug 2022 16:58:29 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Cc:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        <simon.guinot@sequanux.org>
Subject: Re: [PATCH v3 1/4] gpio-f7188x: Add GPIO support for Nuvoton
 NCT6116
Message-ID: <20220822165829.1e4fbc5f@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220811153908.31283-2-henning.schild@siemens.com>
References: <20220811153908.31283-1-henning.schild@siemens.com>
        <20220811153908.31283-2-henning.schild@siemens.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6e6298d-ba5e-4860-6cb4-08da844ec9ec
X-MS-TrafficTypeDiagnostic: AM7PR10MB3528:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKGq+2cQZfMp72v0qOeYc8oCPE8RjKVOA5IsVHDleytb8jcwRDg+RkzgDKF53XqeUkDw/jUAxpq6pLBN9/p9tyjl0JSIgNBjAniM/oFFIWWOlACBYB82tNKAD2Hqe0IHW3Xdl0RGdMp2A2Z3Fbmj1JAe3yiLaLJ0OyJkN3yfRiJ/DM/kPKALSDmuUeCzJzTLRO2Cu69JCwsJuAEzk8wIXISThzHq/oRLQFT0ZZUx/n5NgEiBPU1zWUVzpws9LCI2CyHIjCMzbA0cE2pI0URzCysBRmHmGDFJj9gA8vgEsE4TJC7aSqd96FDQ60jyPOlNUmWDMbSi5Rx3TEMFcNJcKsFFl1x/ea2ROpKY2e+heoqJqLLTIwrsXxdXhOXbIopgaXhrHmBoIPMnVMm3imp7B2M5Jx0BhujQLO+qBvmwPWBDZ7RUvTgrl8ngq5uOlEJ2Gvps3Hq8dJj6lLhFIj9SzRkrxi32yFd8fR3uVK9Zfv2jd06UpvIZO5Xw7+j+UcEMUzmzimrs/+c3GncBAIEso0mZak6Ukz+dTVwTn+J8yBHeVst3jObluedWZREdUSSXADwrKyOMWVSphAyWoIYFeDJ8uletu5/ciGZd3kLs4e4Fo/hvaAAl+7wDVrXEWKByQTmkU4vlUtzxkTZv3L9MG7Qzyf+kgvnZ5QE4ryLcijUEhVdaXp/fmmGiGbNkLT9hw5lj16lqI1lWFeS+5nNvAtQfRNgoB7J+ZYsN9jlVELHvIB83FtGdhTcgcj+VfEqx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(316002)(66946007)(4326008)(66556008)(66476007)(8676002)(8936002)(186003)(1076003)(44832011)(110136005)(7416002)(5660300002)(2906002)(54906003)(82960400001)(41300700001)(6666004)(6512007)(86362001)(26005)(6506007)(921005)(9686003)(83380400001)(478600001)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/gNaoqNfP11xU04bbHqfA1FU4nmMIEWiNfTdE/dbwL9zR1+FNbj3kllgc1sF?=
 =?us-ascii?Q?+5hg4kDb6aIhNiDN57+fKpeeoAxJgdXnbJczk6M25Ds4pmpb+nYTwUH0WsS4?=
 =?us-ascii?Q?yXtNrZQOV5mx/f0qeEe7zO5Io15Fx2owU7xYSFhP9CMUr0Cwyw92Cp4VvTgu?=
 =?us-ascii?Q?FLdiLzZxgjmecvRIBVYf3cjai0ZCur16flwbC5fptzxlPJXnhEvgZKn0OjSu?=
 =?us-ascii?Q?tgzuEh0VMyal98G/hbC6ZgvBMVcJLBLZgTapbArW4zCWdF/OzDBl/zHDETBZ?=
 =?us-ascii?Q?gF9x72cgwKJb4eMTB3FbhJLyyg7NuEA90CkowXQbHm9Qx3bT/rnPVHOFMVm7?=
 =?us-ascii?Q?8S9iiDljjZox6KIcYV12ReoJAcwWJQ+CCidKTxam2PGh71h03oJZVl7TmK72?=
 =?us-ascii?Q?Q/L2Z/Ue5OA0cjtCHTDqjxlrXoXqKVhk4nSPUSv//PlJWwJJ13W0ctQ/9nUV?=
 =?us-ascii?Q?+Ascde8k3Qe2/L9w5ZbJ0L/73Ai0g1Us7cs8hkhvLNwgBE2eaQtAp9kiHMBQ?=
 =?us-ascii?Q?iYVQsmdH65RNOdjp8oDKGllAe3aWSv4YgchGWSTiQCuce4lcaPL1/FcDCekf?=
 =?us-ascii?Q?cNpA366LFA7Iq5N+9G4yIyCZlG/bCQFHED24OeZc+JcUQHaLmTtiD0+mgzRs?=
 =?us-ascii?Q?lohPD29Ww1RfOqU2tAtHzhS9hkf/3kDDAcsOPeodGy59NcvMXcJIcNQIhoX4?=
 =?us-ascii?Q?5jc7fx1fYYHbOcYjeM/VRBNa4/VvTjlrmT1fx6LVL+gVB8uRSMoOKzsN5vhp?=
 =?us-ascii?Q?tzN8aLEl1/VDndERYmNdot2aNmjL2X8uaikiNr4VBg988Lc/scoq59lIOHdP?=
 =?us-ascii?Q?GVRbyArHoLXX/WU1YzhhMSvrofg5ArkWH/M8ItOh1SjR44D0+lnHWdFxS5Tq?=
 =?us-ascii?Q?eY8F1BJ1fNOvm6es0bAmOI8o/+EzIVPU9B0JoU9ZwJpqo6Bn+G/U/Q5YKFIo?=
 =?us-ascii?Q?t8eWrJfzSsPPJQbUtFfxprE4xLjgKU/8X923akoamdGmqmH37cXPDyzjvuy2?=
 =?us-ascii?Q?DKZ71eUs8R0P4fRysqHbHPI01WSbcp5psdU6SFbRJVgWrXFwhujUygoV1Khl?=
 =?us-ascii?Q?jeoW7Ta2B2Swocwz4pPsgHTLT/ObNdr6ay8eWZw6sbrE51+iYh5wIp3jC0ny?=
 =?us-ascii?Q?Q2qHL/O/rDA7JbG1o2w2sLPJtlM7/PU6MyJe3MzVPkd+xoAK7/PPFO4bBYGb?=
 =?us-ascii?Q?68BDC1534Jvrp1k6iT3tJALOTJbmD5ClLSKRUhz6RtiW0bgMwP1zXEUCSmUv?=
 =?us-ascii?Q?mbDymcbfNTXH+otDi8BUDTNlGDdJHUn+YkEugbzg3HgXEKkadTm8xJRLPx3D?=
 =?us-ascii?Q?E7jlByNWkLSU7ZtpPpTJw13HEDsdpXNXn6B1WNNJA/i3ZYhiKKR/88wHnjSs?=
 =?us-ascii?Q?e2bo+7cV8B24jHt3Z+S0h4wqzndDpMjmYo0/veoNhhKsNWtoRNzULi5u6WSz?=
 =?us-ascii?Q?/cGJ6Z+200yH7lBkTzWOW1BvDbiwX65PMSvHtXnEgtA//JjE3ajwguHMmYjJ?=
 =?us-ascii?Q?8ziJ3H8yCY+G+QQXceH0EeQRg+yqfIQh5Zs1Lj69yLLCgl0UE9x80zGvMMht?=
 =?us-ascii?Q?570q7ONYRZDmMX4zdM9qH6YtQVIWDVAKxqIKLqgYFQ+rdHmJMDTZSdIaysMC?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e6298d-ba5e-4860-6cb4-08da844ec9ec
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 14:58:35.7314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihJtvrPX0oNze/pjhA/gnbKYfKc2P64rQsaPU3fNosXOsUnHCJiPUKcDPjgEvX3DB2EHMSbX2h7vAN9IjwNwq41XgsFsQXd3fPAv/oXCxqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3528
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 11 Aug 2022 17:39:05 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO chips are
> very similar to the ones from Fintek. In other subsystems they also
> share drivers and are called a family of drivers.
> 
> For the GPIO subsystem the only difference is that the direction bit
> is reversed and that there is only one data bit per pin. On the
> SuperIO level the logical device is another one.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/gpio/gpio-f7188x.c | 71
> +++++++++++++++++++++++++++----------- 1 file changed, 51
> insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> index 18a3147f5a42..7b05ecc611e9 100644
> --- a/drivers/gpio/gpio-f7188x.c
> +++ b/drivers/gpio/gpio-f7188x.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * GPIO driver for Fintek Super-I/O F71869, F71869A, F71882, F71889
> and F81866
> + * and Nuvoton Super-I/O NCT6116D

That Kconfig item could also use an update, will include in next
version.

Henning

>   *
>   * Copyright (C) 2010-2013 LaCie
>   *
> @@ -22,13 +23,12 @@
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
> device */ +#define SIO_LD_GPIO_NUVOTON	0x07	/* GPIO
> logical device */ #define SIO_F71869_ID		0x0814
> /* F71869 chipset ID */ #define SIO_F71869A_ID
> 0x1007	/* F71869A chipset ID */ #define SIO_F71882_ID
> 	0x0541	/* F71882 chipset ID */ @@ -37,7 +37,7 @@
>  #define SIO_F81866_ID		0x1010	/* F81866 chipset
> ID */ #define SIO_F81804_ID		0x1502  /* F81804 chipset
> ID, same for f81966 */ #define SIO_F81865_ID
> 0x0704	/* F81865 chipset ID */ -
> +#define SIO_NCT6116D_ID		0xD283  /* NCT6116D chipset
> ID */ 
>  enum chips {
>  	f71869,
> @@ -48,6 +48,7 @@ enum chips {
>  	f81866,
>  	f81804,
>  	f81865,
> +	nct6116d,
>  };
>  
>  static const char * const f7188x_names[] = {
> @@ -59,10 +60,12 @@ static const char * const f7188x_names[] = {
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
> @@ -170,6 +173,9 @@ static int f7188x_gpio_set_config(struct
> gpio_chip *chip, unsigned offset, /* Output mode register (0:open
> drain 1:push-pull). */ #define gpio_out_mode(base) (base + 3)
>  
> +#define gpio_dir_invert(type)	((type) == nct6116d)
> +#define gpio_data_single(type)	((type) == nct6116d)
> +
>  static struct f7188x_gpio_bank f71869_gpio_bank[] = {
>  	F7188X_GPIO_BANK(0, 6, 0xF0),
>  	F7188X_GPIO_BANK(10, 8, 0xE0),
> @@ -254,6 +260,17 @@ static struct f7188x_gpio_bank
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
> @@ -264,13 +281,16 @@ static int f7188x_gpio_get_direction(struct
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
> +	if (gpio_dir_invert(sio->type))
> +		dir = ~dir;
> +
> +	if (dir & BIT(offset))
>  		return GPIO_LINE_DIRECTION_OUT;
>  
>  	return GPIO_LINE_DIRECTION_IN;
> @@ -286,10 +306,14 @@ static int f7188x_gpio_direction_in(struct
> gpio_chip *chip, unsigned offset) err = superio_enter(sio->addr);
>  	if (err)
>  		return err;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
>  
>  	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> -	dir &= ~BIT(offset);
> +
> +	if (gpio_dir_invert(sio->type))
> +		dir |= BIT(offset);
> +	else
> +		dir &= ~BIT(offset);
>  	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
>  
>  	superio_exit(sio->addr);
> @@ -307,11 +331,11 @@ static int f7188x_gpio_get(struct gpio_chip
> *chip, unsigned offset) err = superio_enter(sio->addr);
>  	if (err)
>  		return err;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
>  
>  	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
>  	dir = !!(dir & BIT(offset));
> -	if (dir)
> +	if (gpio_data_single(sio->type) || dir)
>  		data = superio_inb(sio->addr,
> gpio_data_out(bank->regbase)); else
>  		data = superio_inb(sio->addr,
> gpio_data_in(bank->regbase)); @@ -332,7 +356,7 @@ static int
> f7188x_gpio_direction_out(struct gpio_chip *chip, err =
> superio_enter(sio->addr); if (err)
>  		return err;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
>  
>  	data_out = superio_inb(sio->addr,
> gpio_data_out(bank->regbase)); if (value)
> @@ -342,7 +366,10 @@ static int f7188x_gpio_direction_out(struct
> gpio_chip *chip, superio_outb(sio->addr,
> gpio_data_out(bank->regbase), data_out); 
>  	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> -	dir |= BIT(offset);
> +	if (gpio_dir_invert(sio->type))
> +		dir &= ~BIT(offset);
> +	else
> +		dir |= BIT(offset);
>  	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
>  
>  	superio_exit(sio->addr);
> @@ -360,7 +387,7 @@ static void f7188x_gpio_set(struct gpio_chip
> *chip, unsigned offset, int value) err = superio_enter(sio->addr);
>  	if (err)
>  		return;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
>  
>  	data_out = superio_inb(sio->addr,
> gpio_data_out(bank->regbase)); if (value)
> @@ -388,7 +415,7 @@ static int f7188x_gpio_set_config(struct
> gpio_chip *chip, unsigned offset, err = superio_enter(sio->addr);
>  	if (err)
>  		return err;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
>  
>  	data = superio_inb(sio->addr, gpio_out_mode(bank->regbase));
>  	if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN)
> @@ -449,6 +476,10 @@ static int f7188x_gpio_probe(struct
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
> @@ -485,12 +516,8 @@ static int __init f7188x_find(int addr, struct
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
> @@ -517,8 +544,12 @@ static int __init f7188x_find(int addr, struct
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

