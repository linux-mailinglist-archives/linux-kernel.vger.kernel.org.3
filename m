Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15956C04B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbiGHRb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237954AbiGHRbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:31:55 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE3C13D1F;
        Fri,  8 Jul 2022 10:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/emsBRLVMdnYpCHS5JrJ3IPE18KNnD8gg8J9LfdEvQDIM05qzAK6LvbAPM1b+sCOiVK0t1jrXmv9PiY/rjc8r3YQhPhDGEKUDeE20+AgUoPl64gWXCP7w9IuNF+0PWphJ0KVzK8GIV2Qn/KDCx4fGbW0PPdKOxA2LmH/LI4xaQvtf4EXxwM2EKM6aeGdb3THUbcUyDU9GY7jGCv62wjK2rFqauWVOIrd8bVqc0F32X/Bo8tdcKaF9NY8yyt0fshTSHjhCMK13QqFzyM1EdvhsVAm00jRYKYYcvWe8WhkPuuVAE90yk4gtd2PBeOlkDpFSFRWBmBu06MjfFw4Qy8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0za0VU+PIz1DsuHWKQWKoXalZO/Dk8nWSv9NLHU7uw=;
 b=a2xTB5G2lFgcp4RxV5WPFyxoqkwWCDzxF6cjfxeB8vgX0rUkIAh0lRiGNOIaIpOkLBR8vg1X8OwpdSMSwgz1ZKFXDUvamVnMEdCU8oFl0o7q92doApR17ttJVukzBaAEdzxV/3KK8ywSxskW5XBXN60OPgL4SvvQG9z6CK1dHZpj0hEIiq2GzEY4OJiyZJ2jeo8zAHuZe8AulZLK3NbAqjmzRYfOwsC1Hr4tEEv2N6EMAR2q3VPsnqns3kI7BmO5lSAuav/c6YUJZf2CLUh/p77H2lsICfz3joYP99Q5GI5To1CzUlHuI7XXnloFfdVX5c47Zyo/nZ/H9+7Ibm1/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0za0VU+PIz1DsuHWKQWKoXalZO/Dk8nWSv9NLHU7uw=;
 b=rcXK7jiBcLStnGxaBy1dh3z/y2YCuw0iPYq5fz2wrr6FsRbe5S0arc9RoSZo3jgA+h/EcLMRax6VouqIOVgkeTt7YuUjyh2zRUbLnxmk1It8i4pCWQZbpwRjZCepg2fk5dNpSJKyoMtCVPSAd69tUUbJszvIMXv4RecrGG0eiXod9brtu9LiCyoWYdzDX33F1/kbDkIyS+H7iMVP+nV+kUD7bjJ6dbkTcZ3nnJYJ+TrmVszGxtH4026TZqtTTUijYmb6jqKbfo08yR6hi2R3r6xFCkZRx6kQXQdkoDgzQGcf9LjhSo9L7pZME1BGTF70ZtsHKCxxMrOOX6oEIrrfrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by GV2PR10MB6113.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 17:31:50 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::253b:4d66:1a99:f6e0]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::253b:4d66:1a99:f6e0%7]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 17:31:50 +0000
Date:   Fri, 8 Jul 2022 19:31:47 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: nct6116d: add new driver for several
 Nuvoton super io chips
Message-ID: <20220708193147.5f03c436@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAMRc=MeJ4LiYkCDScGBhnaDbxQsHQ8T9R2MwGOy6Ju=tkWdzXw@mail.gmail.com>
References: <20220704130602.12307-1-henning.schild@siemens.com>
        <20220704130602.12307-2-henning.schild@siemens.com>
        <CAMRc=MeJ4LiYkCDScGBhnaDbxQsHQ8T9R2MwGOy6Ju=tkWdzXw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::9) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1bd6188-7197-4102-b4a0-08da6107bd5a
X-MS-TrafficTypeDiagnostic: GV2PR10MB6113:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bT/MtOKjmIXsT1ckrRQiSaL9y++sk0sdIA993wctrTEfnIVOfCcFW/G+eL6LwiH5VDt7+aACMLroKvmaVCKFNpnPqWMBW0S4lQiez/Wg0hJ9KeHWQYHxJn3OZ7BXDGcwLiESAaeZk8YoJCXqUeas3q4DokNPpSTM4c+O2+ibDRaD9RLTpsB6wXhm2ySwjMV+v7VxtJKekcFEacjy4x/TT0CGPn0nVpy2r1hnpKRw5SkP9YpFeFwjIuK3AlvBs7nHAqygielGIQV3eM+Pco+DTeQpYRqCMaylp5APyt1Bj7qH0ExJNg8tJi/Do3TWP1vC2lUuIM93A8ZRpCMPH9hEPsugYBSLfXJxJPuKsiHhOLzfju/HpxcdRHqmj+m2631VlZbjyNOuH5SovqVPtQp7DEi27N1AVnqzIARuu2hXBby1SgadvWu9hcwCbsHnXA5s8EMVLv2jYB2XC6PdyMsVlqt6rowkfGJyEJCjo70nfFDMGIs4UxtESZV6MUn7Je9soevX68+oQuxCxTHxs3k93l6QXLFJm8c+HLUx5+QyOmN0+bgu7VCcuNBs6RtdfnnxlP8W2Kv2DPB725NNcpfF8DTGqdernnZ/k/Jd0Ezo6PF69CwCZcu2p1jsxbugYGwJjJwOaWA5dV36PUkt2Qtn/kuIvcMS+QgCSYPc+BOzfuLUEAN14QavXZ95VLvLEQwsnG5z7bj5oESJWso7OeKmOX4xagseSZdo+RPUb2InJwKxU6zi7+NnShyobRNnmMKL7ZLJ9oAfWxqkayW9K8NOXKpUr/CqzV++fH4lgLrhZGtSByIhx2dYSB6snsW4D4vh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(86362001)(66946007)(6512007)(8936002)(6666004)(4326008)(66476007)(66556008)(41300700001)(478600001)(6506007)(44832011)(83380400001)(9686003)(82960400001)(2906002)(5660300002)(8676002)(6486002)(26005)(38100700002)(1076003)(316002)(30864003)(186003)(54906003)(6916009)(53546011)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c/qL3dNswzCPLR0fkgLT4VTBsesaTxlM+hsK0XGr1rwURl+Wdk///3YRN8aB?=
 =?us-ascii?Q?vEAVdrVJo0TvxBLWyFueuOn9kXkUlCXgzQG5WpLdOJ6zidK0KrQN5+9HwQgH?=
 =?us-ascii?Q?/zpI4D7wuUJzn5SyDcksnIAiwAYwE40GJV0Bi3Y4T1rVbj4F0Jm1mgk3arnZ?=
 =?us-ascii?Q?X350D84aj6bI3cPdcU7eynhqZRRVno0+4jrMXf+EAkRD6HXxyhwZBdacUdPu?=
 =?us-ascii?Q?nbBgkeYpaCjQTk33eErOu6mJdpa35nnSKUS/qVcIRH77A7MJ8Zue9alDwvbT?=
 =?us-ascii?Q?TZT8gz24vnWYZUVHGT/YrbdQG8S5u6P0HG/aArrLIfGrJ8bInNEOFP2wzrLF?=
 =?us-ascii?Q?YMV9a9C9a/20nLEEfH6Rc1wibQitk4JHMbjXWLohFExhPSzJjoxCRh4fN2Bu?=
 =?us-ascii?Q?3CiipBImi84PYjI0w56nlUZWj5X4DHNRbhDWoDCYv2F1OqV281WbR538/VWA?=
 =?us-ascii?Q?PvgDZzNJ2mA09X0DW7O68NLj/pFfMsb+CTT0HQDY/nlXn0k1vj26P28McNkK?=
 =?us-ascii?Q?ZbpPO7uI0IMReJTzRAK8h9jSvONlwXJ/AP4KSctVcAQE5Ip2Q2LYvxgkWZe2?=
 =?us-ascii?Q?UCTp4XOMubv/grv2OqSh7YQ0zlMFevpyKdcvbdPpiKWep7Q29hr4BAke07pH?=
 =?us-ascii?Q?2fhAdyrS0Huu2daHiZsB8p/CVPM62GFf4Ji5JEECI+xVm/Gl3B+h1Ck8wyJG?=
 =?us-ascii?Q?QXlMSeRGnjadJdLMY5whdIMWtY2xFiJsPyX5fCyOXc1tu1vReicz0COHGaGv?=
 =?us-ascii?Q?h/Dm7MeBNbKibY+FVrKAmFn8BDT2lqh9PCDc0rUB8TuD81OJHUJ3ndb9chv/?=
 =?us-ascii?Q?GYyPXys4nVtfwawP6LjBqDKG2/AQQBhU51L390hh8hIzt88mp6nLbV0Bx1Un?=
 =?us-ascii?Q?ffCAjydPZGrX0KCJbw/XTq1u8wFXCg4hi52UvWNEtXsLwxMWTK1zr8Z91ccf?=
 =?us-ascii?Q?gXLR37tuxgSVOLjkmlSjuNzH1+7aHAfr+nhuV9iq5klvHCy40JUM6XJy6ngk?=
 =?us-ascii?Q?k0oBGf1vJtMB6dxdTWIQZOY+4krbyRnUci0BWjDlLRk+Efd1Tz2oh+44iBwL?=
 =?us-ascii?Q?Bgy4BSMRtUZOS2c2pY+Wpq65aZSuEWBRZuEDJ6xNvVU2hyxtaAZdyvbi3kTd?=
 =?us-ascii?Q?T0KP4ftKJBVoWifY6sakN8bk94ch0BKpkL0KFhU5M0QDicfgEHzqd24DsG6L?=
 =?us-ascii?Q?qmZ5FUlvRbGHc0e2FyehSADo+y5X6NJ3w2nqh+ofgySnRqPYb9j4bWnFxwDS?=
 =?us-ascii?Q?sjG8NzWo41bNSxGLvX5WmNQyoKk6sHK7thknotZwLaq2Ehe4DtfX7WRlvouT?=
 =?us-ascii?Q?Gxh+2psJkeVW7OkVonKdLKYNp00s/JuA0wFocHL+aCnBPY2XtOe3HuqKsYP5?=
 =?us-ascii?Q?bamOuC2Ot05jcUQGnIHLcMZmhYTZ71Na/Uezx+V4A8HohqkFuXjqstXckbKe?=
 =?us-ascii?Q?BGJIVlZX1Caj1EZD30msgkQOVoPJbt3XRH4GOaw61Sz6bhw9LasbqUpH+ma0?=
 =?us-ascii?Q?NHqMR6QbXmQsKjzBViOqvoPKsyku4VcriAO16+WdnMAproSrF1fF+YCfhuIi?=
 =?us-ascii?Q?K4YC9tzSS1KxUaXVJUiJcm/YCuJexu5ODh8Ir4kYFVTfQUw4KR+8Ry+ByAdo?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bd6188-7197-4102-b4a0-08da6107bd5a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 17:31:50.1161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dP3kJJfo9n3CxHT+u/0WE4lq3PeQER5p7wXTWMTtrJ/9gXNlus7+N6OcuPTZ981PP4ZjGohjHAuo1VHLzMG18vFEnuuzf9QUfjJkmbsbWU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, 8 Jul 2022 18:00:27 +0200
schrieb Bartosz Golaszewski <brgl@bgdev.pl>:

> On Mon, Jul 4, 2022 at 3:06 PM Henning Schild
> <henning.schild@siemens.com> wrote:
> >
> > This patch adds gpio support for several Nuvoton NCTXXX chips. These
> > Super-I/O chips offer multiple functions of which several already
> > have drivers in the kernel, i.e. hwmon and watchdog.
> >
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  drivers/gpio/Kconfig         |   9 +
> >  drivers/gpio/Makefile        |   1 +
> >  drivers/gpio/gpio-nct6116d.c | 412
> > +++++++++++++++++++++++++++++++++++ 3 files changed, 422
> > insertions(+) create mode 100644 drivers/gpio/gpio-nct6116d.c
> >
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index b01961999ced..40f1494b1adc 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -457,6 +457,15 @@ config GPIO_MXS
> >         select GPIO_GENERIC
> >         select GENERIC_IRQ_CHIP
> >
> > +config GPIO_NCT6116D
> > +       tristate "Nuvoton Super-I/O GPIO support"
> > +       help
> > +         This option enables support for GPIOs found on Nuvoton
> > Super-I/O
> > +         chips NCT5104D, NCT6106D, NCT6116D, NCT6122D.
> > +
> > +         To compile this driver as a module, choose M here: the
> > module will
> > +         be called gpio-nct6116d.
> > +
> >  config GPIO_OCTEON
> >         tristate "Cavium OCTEON GPIO"
> >         depends on CAVIUM_OCTEON_SOC
> > diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> > index 14352f6dfe8e..87f1b0a0cda2 100644
> > --- a/drivers/gpio/Makefile
> > +++ b/drivers/gpio/Makefile
> > @@ -107,6 +107,7 @@ obj-$(CONFIG_GPIO_MT7621)           +=
> > gpio-mt7621.o obj-$(CONFIG_GPIO_MVEBU)               += gpio-mvebu.o
> >  obj-$(CONFIG_GPIO_MXC)                 += gpio-mxc.o
> >  obj-$(CONFIG_GPIO_MXS)                 += gpio-mxs.o
> > +obj-$(CONFIG_GPIO_NCT6116D)            += gpio-nct6116d.o
> >  obj-$(CONFIG_GPIO_OCTEON)              += gpio-octeon.o
> >  obj-$(CONFIG_GPIO_OMAP)                        += gpio-omap.o
> >  obj-$(CONFIG_GPIO_PALMAS)              += gpio-palmas.o
> > diff --git a/drivers/gpio/gpio-nct6116d.c
> > b/drivers/gpio/gpio-nct6116d.c new file mode 100644
> > index 000000000000..6c277636c773
> > --- /dev/null
> > +++ b/drivers/gpio/gpio-nct6116d.c
> > @@ -0,0 +1,412 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * GPIO driver for Nuvoton Super-I/O chips NCT5104D, NCT6106D,
> > NCT6116D, NCT6122D
> > + *
> > + * Authors:
> > + *  Tasanakorn Phaipool <tasanakorn@gmail.com>
> > + *  Sheng-Yuan Huang <syhuang3@nuvoton.com>
> > + *  Kuan-Wei Ho <cwho@nuvoton.com>
> > + *  Henning Schild <henning.schild@siemens.com>
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/gpio/driver.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +
> > +/*
> > + * Super-I/O registers
> > + */
> > +#define SIO_LDSEL              0x07    /* Logical device select */
> > +#define SIO_CHIPID             0x20    /* Chaip ID (2 bytes) */
> > +#define SIO_GPIO_ENABLE                0x30    /* GPIO enable */
> > +
> > +#define SIO_LD_GPIO            0x07    /* GPIO logical device */
> > +#define SIO_UNLOCK_KEY         0x87    /* Key to enable Super-I/O
> > */ +#define SIO_LOCK_KEY           0xAA    /* Key to disable
> > Super-I/O */ +
> > +#define SIO_ID_MASK            GENMASK(15, 4)
> > +#define SIO_NCT5104D_ID                0x1061
> > +#define SIO_NCT6106D_ID                0xC452
> > +#define SIO_NCT6116D_ID                0xD282
> > +#define SIO_NCT6122D_ID                0xD2A3
> > +
> > +enum chips {
> > +       nct5104d,
> > +       nct6106d,
> > +       nct6116d,
> > +       nct6122d,
> > +};
> > +
> > +static const char * const nct6116d_names[] = {
> > +       [nct5104d] = "nct5104d",
> > +       [nct6106d] = "nct6106d",
> > +       [nct6116d] = "nct6116d",
> > +       [nct6122d] = "nct6122d",
> > +};
> > +
> > +struct nct6116d_sio {
> > +       int addr;
> > +       enum chips type;
> > +};
> > +
> > +struct nct6116d_gpio_bank {
> > +       struct gpio_chip chip;
> > +       unsigned int regbase;
> > +       struct nct6116d_gpio_data *data;
> > +};
> > +
> > +struct nct6116d_gpio_data {
> > +       struct nct6116d_sio *sio;
> > +       int nr_bank;
> > +       struct nct6116d_gpio_bank *bank;
> > +};
> > +
> > +/*
> > + * Super-I/O functions.
> > + */
> > +
> > +static inline int superio_inb(int base, int reg)
> > +{
> > +       outb(reg, base);
> > +       return inb(base + 1);
> > +}
> > +
> > +static int superio_inw(int base, int reg)
> > +{
> > +       int val;
> > +
> > +       outb(reg++, base);
> > +       val = inb(base + 1) << 8;
> > +       outb(reg, base);
> > +       val |= inb(base + 1);
> > +
> > +       return val;
> > +}
> > +
> > +static inline void superio_outb(int base, int reg, int val)
> > +{
> > +       outb(reg, base);
> > +       outb(val, base + 1);
> > +}
> > +
> > +static inline int superio_enter(int base)
> > +{
> > +       /* Don't step on other drivers' I/O space by accident. */
> > +       if (!request_muxed_region(base, 2, KBUILD_MODNAME)) {
> > +               pr_err("I/O address 0x%04x already in use\n", base);
> > +               return -EBUSY;
> > +       }
> > +
> > +       /* According to the datasheet the key must be send twice. */
> > +       outb(SIO_UNLOCK_KEY, base);
> > +       outb(SIO_UNLOCK_KEY, base);
> > +
> > +       return 0;
> > +}
> > +
> > +static inline void superio_select(int base, int ld)
> > +{
> > +       outb(SIO_LDSEL, base);
> > +       outb(ld, base + 1);
> > +}
> > +
> > +static inline void superio_exit(int base)
> > +{
> > +       outb(SIO_LOCK_KEY, base);
> > +       release_region(base, 2);
> > +}
> > +
> > +/*
> > + * GPIO chip.
> > + */
> > +
> > +#define gpio_dir(base) ((base) + 0)
> > +#define gpio_data(base) ((base) + 1)
> > +
> > +static inline void *nct6116d_to_gpio_bank(struct gpio_chip *chip)
> > +{
> > +       return container_of(chip, struct nct6116d_gpio_bank, chip);
> > +}
> > +
> > +static int nct6116d_gpio_get_direction(struct gpio_chip *chip,
> > unsigned int offset) +{
> > +       struct nct6116d_gpio_bank *bank =
> > nct6116d_to_gpio_bank(chip);
> > +       struct nct6116d_sio *sio = bank->data->sio;
> > +       int err;
> > +       u8 dir;
> > +
> > +       err = superio_enter(sio->addr);
> > +       if (err)
> > +               return err;
> > +       superio_select(sio->addr, SIO_LD_GPIO);
> > +
> > +       dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> > +
> > +       superio_exit(sio->addr);
> > +
> > +       if (dir & 1 << offset)
> > +               return GPIO_LINE_DIRECTION_OUT;
> > +
> > +       return GPIO_LINE_DIRECTION_IN;
> > +}
> > +
> > +static int nct6116d_gpio_direction_in(struct gpio_chip *chip,
> > unsigned int offset) +{
> > +       struct nct6116d_gpio_bank *bank =
> > nct6116d_to_gpio_bank(chip);
> > +       struct nct6116d_sio *sio = bank->data->sio;
> > +       int err;
> > +       u8 dir;
> > +
> > +       err = superio_enter(sio->addr);
> > +       if (err)
> > +               return err;
> > +       superio_select(sio->addr, SIO_LD_GPIO);
> > +
> > +       dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> > +       dir |= BIT(offset);
> > +       superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
> > +
> > +       superio_exit(sio->addr);
> > +
> > +       return 0;
> > +}
> > +
> > +static int nct6116d_gpio_get(struct gpio_chip *chip, unsigned int
> > offset) +{
> > +       struct nct6116d_gpio_bank *bank =
> > nct6116d_to_gpio_bank(chip);
> > +       struct nct6116d_sio *sio = bank->data->sio;
> > +       int err;
> > +       u8 data;
> > +
> > +       err = superio_enter(sio->addr);
> > +       if (err)
> > +               return err;
> > +       superio_select(sio->addr, SIO_LD_GPIO);
> > +
> > +       data = superio_inb(sio->addr, gpio_data(bank->regbase));
> > +
> > +       superio_exit(sio->addr);
> > +
> > +       return !!(data & BIT(offset));
> > +}
> > +
> > +static int nct6116d_gpio_direction_out(struct gpio_chip *chip,
> > +                                    unsigned int offset, int value)
> > +{
> > +       struct nct6116d_gpio_bank *bank =
> > nct6116d_to_gpio_bank(chip);
> > +       struct nct6116d_sio *sio = bank->data->sio;
> > +       u8 dir, data_out;
> > +       int err;
> > +
> > +       err = superio_enter(sio->addr);
> > +       if (err)
> > +               return err;
> > +       superio_select(sio->addr, SIO_LD_GPIO);
> > +
> > +       data_out = superio_inb(sio->addr, gpio_data(bank->regbase));
> > +       if (value)
> > +               data_out |= BIT(offset);
> > +       else
> > +               data_out &= ~BIT(offset);
> > +       superio_outb(sio->addr, gpio_data(bank->regbase), data_out);
> > +
> > +       dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> > +       dir &= ~BIT(offset);
> > +       superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
> > +
> > +       superio_exit(sio->addr);
> > +
> > +       return 0;
> > +}
> > +
> > +static void nct6116d_gpio_set(struct gpio_chip *chip, unsigned int
> > offset, int value) +{
> > +       struct nct6116d_gpio_bank *bank =
> > nct6116d_to_gpio_bank(chip);
> > +       struct nct6116d_sio *sio = bank->data->sio;
> > +       u8 data_out;
> > +       int err;
> > +
> > +       err = superio_enter(sio->addr);
> > +       if (err)
> > +               return;
> > +       superio_select(sio->addr, SIO_LD_GPIO);
> > +
> > +       data_out = superio_inb(sio->addr, gpio_data(bank->regbase));
> > +       if (value)
> > +               data_out |= BIT(offset);
> > +       else
> > +               data_out &= ~BIT(offset);
> > +       superio_outb(sio->addr, gpio_data(bank->regbase), data_out);
> > +
> > +       superio_exit(sio->addr);
> > +}
> > +
> > +#define NCT6116D_GPIO_BANK(_base, _ngpio, _regbase, _label)
> >             \
> > +       {
> >             \
> > +               .chip = {
> >             \
> > +                       .label            = _label,
> >             \
> > +                       .owner            = THIS_MODULE,
> >             \
> > +                       .get_direction    =
> > nct6116d_gpio_get_direction,        \
> > +                       .direction_input  =
> > nct6116d_gpio_direction_in,         \
> > +                       .get              = nct6116d_gpio_get,
> >             \
> > +                       .direction_output =
> > nct6116d_gpio_direction_out,        \
> > +                       .set              = nct6116d_gpio_set,
> >             \
> > +                       .base             = _base,
> >             \
> > +                       .ngpio            = _ngpio,
> >             \
> > +                       .can_sleep        = false,
> >             \
> > +               },
> >             \
> > +               .regbase = _regbase,
> >             \
> > +       }
> > +
> > +static struct nct6116d_gpio_bank nct6116d_gpio_bank[] = {
> > +       NCT6116D_GPIO_BANK(0, 8, 0xE0, KBUILD_MODNAME "-0"),
> > +       NCT6116D_GPIO_BANK(10, 8, 0xE4, KBUILD_MODNAME "-1"),
> > +       NCT6116D_GPIO_BANK(20, 8, 0xE8, KBUILD_MODNAME "-2"),
> > +       NCT6116D_GPIO_BANK(30, 8, 0xEC, KBUILD_MODNAME "-3"),
> > +       NCT6116D_GPIO_BANK(40, 8, 0xF0, KBUILD_MODNAME "-4"),
> > +};
> > +
> > +/*
> > + * Platform device and driver.
> > + */
> > +
> > +static int nct6116d_gpio_probe(struct platform_device *pdev)
> > +{
> > +       struct nct6116d_sio *sio = pdev->dev.platform_data;
> > +       struct nct6116d_gpio_data *data;
> > +       int err;
> > +       int i;
> > +
> > +       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > +       if (!data)
> > +               return -ENOMEM;
> > +
> > +       data->nr_bank = ARRAY_SIZE(nct6116d_gpio_bank);
> > +       data->bank = nct6116d_gpio_bank;
> > +       data->sio = sio;
> > +
> > +       platform_set_drvdata(pdev, data);
> > +
> > +       /* For each GPIO bank, register a GPIO chip. */
> > +       for (i = 0; i < data->nr_bank; i++) {
> > +               struct nct6116d_gpio_bank *bank = &data->bank[i];
> > +
> > +               bank->chip.parent = &pdev->dev;
> > +               bank->data = data;
> > +
> > +               err = devm_gpiochip_add_data(&pdev->dev,
> > &bank->chip, bank);
> > +               if (err)
> > +                       return dev_err_probe(&pdev->dev, err,
> > +                               "Failed to register gpiochip %d\n",
> > i);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int __init nct6116d_find(int addr, struct nct6116d_sio *sio)
> > +{
> > +       u16 devid;
> > +       int err;
> > +
> > +       err = superio_enter(addr);
> > +       if (err)
> > +               return err;
> > +
> > +       devid = superio_inw(addr, SIO_CHIPID);
> > +       superio_exit(addr);
> > +       switch (devid & SIO_ID_MASK) {
> > +       case SIO_NCT5104D_ID & SIO_ID_MASK:
> > +               sio->type = nct5104d;
> > +               break;
> > +       case SIO_NCT6106D_ID & SIO_ID_MASK:
> > +               sio->type = nct6106d;
> > +               break;
> > +       case SIO_NCT6116D_ID & SIO_ID_MASK:
> > +               sio->type = nct6116d;
> > +               break;
> > +       case SIO_NCT6122D_ID & SIO_ID_MASK:
> > +               sio->type = nct6122d;
> > +               break;
> > +       default:
> > +               pr_info("Unsupported device 0x%04x\n", devid);
> > +               return -ENODEV;
> > +       }
> > +       sio->addr = addr;
> > +
> > +       pr_info("Found %s at 0x%x chip id 0x%04x\n",
> > +               nct6116d_names[sio->type], addr, devid);
> > +       return 0;
> > +}
> > +
> > +static struct platform_device *nct6116d_gpio_pdev;
> > +
> > +static int __init
> > +nct6116d_gpio_device_add(const struct nct6116d_sio *sio)
> > +{
> > +       int err;
> > +
> > +       nct6116d_gpio_pdev = platform_device_alloc(KBUILD_MODNAME,
> > -1);
> > +       if (!nct6116d_gpio_pdev)
> > +               return -ENOMEM;
> > +
> > +       err = platform_device_add_data(nct6116d_gpio_pdev, sio,
> > sizeof(*sio));
> > +       if (err) {
> > +               pr_err("Platform data allocation failed\n");
> > +               goto err;
> > +       }
> > +
> > +       err = platform_device_add(nct6116d_gpio_pdev);
> > +       if (err) {
> > +               pr_err("Device addition failed\n");
> > +               goto err;
> > +       }
> > +
> > +       return 0;
> > +
> > +err:
> > +       platform_device_put(nct6116d_gpio_pdev);
> > +
> > +       return err;
> > +}
> > +
> > +static struct platform_driver nct6116d_gpio_driver = {
> > +       .driver = {
> > +               .name   = KBUILD_MODNAME,
> > +       },
> > +       .probe          = nct6116d_gpio_probe,
> > +};
> > +
> > +static int __init nct6116d_gpio_init(void)
> > +{
> > +       struct nct6116d_sio sio;
> > +       int err;
> > +
> > +       if (nct6116d_find(0x2e, &sio) &&
> > +           nct6116d_find(0x4e, &sio))
> > +               return -ENODEV;
> > +
> > +       err = platform_driver_register(&nct6116d_gpio_driver);
> > +       if (!err) {
> > +               err = nct6116d_gpio_device_add(&sio);
> > +               if (err)
> > +
> > platform_driver_unregister(&nct6116d_gpio_driver);
> > +       }
> > +
> > +       return err;
> > +}
> > +subsys_initcall(nct6116d_gpio_init);
> > +  
> 
> I need some explanation on this part. You load the module and it
> creates and registers the platform device? This is not how it's done
> in the kernel. It's a platform device so it shouldn't be dynamically
> probed for in the module's init function. It should be defined in
> device-tree or ACPI. What platform are you using it on? Manual
> creation of platform devices is limited to a small set of special
> cases.

I only received this code from Nuvoton and can not explain all the
bits. This is clearly a copied pattern from other gpio-xxx.c files,
where exceptions might apply that this one does not deserve.

For the machines i care about i will already have a platform device
driver where i can pull that gpio driver in, either using
platform_device_register or request_module.

So i guess that part can simply be dropped.

On top of this GPIO driver i will later propose changes to
drivers/platform/x86/simatic-ipc.c
drivers/leds/simple/simatic-ipc-leds*
But the GPIO driver is useful on its own so i did not yet send the user
of the GPIO driver. It can be useful for people going to "modprobe" and
use the sysfs gpio interface. 

I wanted to keep the discussion small, not hide the user. Also the LED
subsystem currently seems kind of stuck so i wanted to avoid touching
it.

If it helps i can send the gpio driver with the "coming in-tree user".
Will do so on request, but as said .. it is useful on its own and
keeping the rounds small might be good.

regards,
Henning

> Bart
> 
> > +static void __exit nct6116d_gpio_exit(void)
> > +{
> > +       platform_device_unregister(nct6116d_gpio_pdev);
> > +       platform_driver_unregister(&nct6116d_gpio_driver);
> > +}
> > +module_exit(nct6116d_gpio_exit);
> > +
> > +MODULE_DESCRIPTION("GPIO driver for Nuvoton Super-I/O chips
> > NCT5104D, NCT6106D, NCT6116D, NCT6122D");
> > +MODULE_AUTHOR("Tasanakorn Phaipool <tasanakorn@gmail.com>");
> > +MODULE_LICENSE("GPL"); --
> > 2.35.1
> >  

