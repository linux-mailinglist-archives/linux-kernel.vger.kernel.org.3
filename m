Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D22573473
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbiGMKjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiGMKjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:39:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA50FD231;
        Wed, 13 Jul 2022 03:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCvxUKXq+qoDtOH+SxVPeVeEB+Gop71EqaJsO64189ZErnCLdBI6Yd2kAkcRGscAYtEmXmydgEB1nsZt8edrvrJk0ZrC4lZNIPoqGIKB2/cN7C/zj89fMKpESTl03tLQ4cKalhLACZhxDOfTUM/42pjvsXin/wgowHUeHQKKAgmjRg8yw/hSrxaRlWas1GqCWY2lG14pMePcep+5TMm/YPn+lMoneHR3BaYtWufjQ4mnha8qt0qW0jUanyOtpdSv9RkyLy6Xtd3pE91pzGvfC5AH6Obu8OB1aJMW3OtTuyfZK6SvdH31Jcwr0dmkY1ljzHPbJyxUY0iOprXl0s4RrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KAWUZrNn1PVydcvki11e5an/4VHrB43jlk4oXPrUDk=;
 b=UXavIo33NiaI+1JuRPc259JdwTCAwUFZRwfx+WvECVURiBzDSmbKycnrp8tSbhoeVTWvH+loPEvVxf6gO8nr4CUH1/VLSuX6RgB5T0UtsoSHgw2ufRIDj204g8jrDDOL0So4EbYniA7CG4uQrVg/E9AxHayyQ+0LTHBwX+4v0fRYIiiiKP7puF0ixlYfvzPxGq0ik0AYH0MGCWEAt6mFdMtmMguAtfddohNDMie0ZA3pHcoaSoJiYXyiWXg4gRSJC9l3h7Y/8IvtRKRsY78WRQssBFP/0aDZtkYrtfNdSyKb7/R4/0UvA9CS9rkZSRQ+DUqb8Lzv4nOX4dWPgaronw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KAWUZrNn1PVydcvki11e5an/4VHrB43jlk4oXPrUDk=;
 b=th2iqxLI3bhIfxfB69MGkxBiLMIn6ebzoOdc5rQstDWyZGSezUEO1i4xh0GmMPDj2XawvbA64Z7Vg/x8Owssr5vkr1ltcgl6K8oztN9KE9EYDjaW0oXUQhx5SzK2qqfk18iL0kSs4pxPmg00iMu8kTZ4hb8LD5PFBP5c6RVQzvzc5QRowivnB7vM5c86bAWU+HxAX+Bsezyk3n87VRw1I6m7RLbIiMJgZ+CkFPQQyO6JdJ39UTy4Jx1aJLi7HBhK6p5AYyXcwmw3rHpcljxeqcR4JK0sifJM596dhOTPLUB+OdbTKSkIwE7JWfD6uchTYghv2vi/LOyJLHrsZLjwRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB8PR10MB2859.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 10:39:35 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::253b:4d66:1a99:f6e0]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::253b:4d66:1a99:f6e0%8]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 10:39:35 +0000
Date:   Wed, 13 Jul 2022 12:39:32 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/3] gpio: nct6116d: add new driver for several
 Nuvoton super io chips
Message-ID: <20220713123932.753367ec@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAMRc=Md7uVpwSweCSfrNJKqhQLYs2sVv9UasL59ZpqJ50fSC5w@mail.gmail.com>
References: <20220712143237.13992-1-henning.schild@siemens.com>
        <20220712143237.13992-2-henning.schild@siemens.com>
        <CAMRc=Md7uVpwSweCSfrNJKqhQLYs2sVv9UasL59ZpqJ50fSC5w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::6) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3642da7-1a87-473b-34ab-08da64bbfa68
X-MS-TrafficTypeDiagnostic: DB8PR10MB2859:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3l5LKKtyF6DLkM7nOnctqnWqoAxga90EG/wtfg8JyRbai5RC8h2+EUFtjIvSE8+aafgmuA+0TB0WnBlGttqBMU0gLUFWSEOU3bMpZ1YUTkKQjsNPbHrIyImpL/1a0l//pMaMGy7R3l7rpqQUOOv0jyYG5QxO01Ce1Xz0oaf5yQgdr0Fah0Xb2ayeAXkPCLQyIxzvT6FW5bS5svdrHR8BFsjm/TMSG1wiuwhU7v08BC3LulZkbqMrlmPdtCD7D1w3jOKHDPKoiH8MdK5sazOf7bDTbPaq0infS2j4DFrU4EbigOZvsBzBbN+Icy4N9bnyA2Duq+SelHO/7gnFcIkTpr2nkf3Nk09jyKXprb64Nh696BsOMhX9W9ub3HlYk/1PONmDU+jtFuVrl1FGUud6MyLfgRy7rVLOSIcg5CIvFu2rNWSn5rtfORVG8GDx7v2Fcn4av6ta/plKqRRDtSGdCEkOSCyb4n0zxxU6PkIj5RHT6ZfndwLdmtI7ow66y1t/MrXhZahRktkBxpsj2dtiwOXkBtVo9t9Blgb7pryXWbqxXauIObUrO/AkdTvnFYFPzlHoauyUaXPoCcGNmxznqtnntYamYRnem59MKsnUXVcrOfupomKkgg1ONbQXuAlB+4w/7mJ5NPNFNFHyZCxLNa+QTz97MdahD7sqE0WH7PLpfaoXRII3gda8oZkVoB/WbPq+ayNPHtFvKKnok2f+CyLWEfuzsxFee5MJZSMOCA7lXuMf4W+YE1FT77s/XcM0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(9686003)(1076003)(6512007)(66946007)(186003)(4326008)(8676002)(6666004)(6506007)(86362001)(41300700001)(82960400001)(53546011)(6916009)(478600001)(66476007)(54906003)(6486002)(2906002)(26005)(44832011)(316002)(38100700002)(5660300002)(8936002)(83380400001)(30864003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4jPihsBLllLRuz0OPeGFRkklnmf4m5Xfzkln5gh7tO9v6g0glGAoi5HtLSXi?=
 =?us-ascii?Q?bsmcFx//B9hG39P0t6uv962nrahbWJUNlfezLIxthGJK7Lj9foisQQxSpT8u?=
 =?us-ascii?Q?9uO37asX9PvYN4qGdyAV1ungvT/2mSGl/gON0kJa0DGcbzwADjGlJnyZUgYF?=
 =?us-ascii?Q?e2Vy3kl9Q+peDvRqSq28GUpZ4LRpYIDmH00ceCH/hOiPE55d19ibo6YZ7jg+?=
 =?us-ascii?Q?w5wG0wExZRkfxLzAN7mxYklzyb9JMiEdNUNId28U4OkzKONDoI9IToQDJVKT?=
 =?us-ascii?Q?kiWsrsdX3EJ+dqSvDpAN4AnQz5omxmaMMeWciYnur1DLDEhF7gtqqe6S0RJt?=
 =?us-ascii?Q?Dpg77ep2yC+2Hd9XUQxXP92onC9kDKIjtwid7tcQmbw3xmu+CK1YFTgHqKKq?=
 =?us-ascii?Q?yK5A70kSxcp83YAQ4VeMIG4TGyovXcPSfB6chWbtwjpNr4+Jw+ff2hlT/6Oq?=
 =?us-ascii?Q?r7nYrJkwVjH3UC4b4Kryhrbpn2LQrurvr40rFyqkSzBhcg5Hb0x7N9RZB4Gh?=
 =?us-ascii?Q?bqJUeHls4xWB7Wx1pHUO3w2AO/bq/7Qb+JGqcwfxOeRg/m+ELbLY0CCAE2r0?=
 =?us-ascii?Q?Lqo1asPT4C+yV2w4HyKjAVKVzWDFWS3tsURO7RVU1Zowuj3a14TX5XjDBrp1?=
 =?us-ascii?Q?5ZNDSYL/v7Tib8zCZ411wZ+tx3K7RmjvXX7WY+khfMnfmPefZF+DOuziDZ1K?=
 =?us-ascii?Q?e2HwBp651WueGnR5egzOx1N5UTZaAgn7p0UVNqE7mFOiSan3lnZlhGToJpfX?=
 =?us-ascii?Q?C/pysYQfP2YO3bvlWOnGhvHS0mZRKjf7mhs+KpQ1v5EQ6V/G7szDk0Q4zDdf?=
 =?us-ascii?Q?g1BJCowwGBunB0CHivgFHGf6YAW3gEdhvmoqaSo3mZ8/hExeMJFd1c72JQG2?=
 =?us-ascii?Q?geFsO9V5TXR/wZILOvTUs9KwzDK0CUFm2rn+LDvlvoNly1VW6mGYOi3LA3jD?=
 =?us-ascii?Q?tjSIO5HgI70MxXtDDPTKnDBqsDQH2HaWN9ogQo8M8yjwNdtEk/1rRzfzucYM?=
 =?us-ascii?Q?jPd+xBpte7zvijfEXEUuTyJImJx4HIQGeddk2LRVMHc1MzT94s3w3gbmYPRz?=
 =?us-ascii?Q?u80ZFkK9KzBnsMBfhbpOK72P6V8DvRo5ykwhrewXX1u3er+fLlqwbeF+k1qQ?=
 =?us-ascii?Q?KKYDASr+YxIz7HZAB81+hE1goB/QbNepgmAsv2EyjN9GmIpN6/VuvIz4Fhce?=
 =?us-ascii?Q?W/Gvf+juapFHH1GHktQmQBbZiPj8ynFn50T1eBYAhSNA/1T5Krifg8BfFE70?=
 =?us-ascii?Q?p49b28D1WGVDPtWxA30b1+zNYIZJcxJN4l5So7sbLCiJQKCLxPbRGzIZjpj8?=
 =?us-ascii?Q?wTVEY8AGjhlH9B/An8+7LyyaIf8RlUVpxE5kkthQ+9Pgk3aS6VKIKVLf6UdR?=
 =?us-ascii?Q?ZPtKXN0TZo5uFyuDC5MtvxU8bYkV/wWlPVH3m7l/Wq5of+RT8pcfJiHkurvc?=
 =?us-ascii?Q?GTiwH5UQ5vaOsBwTDGEWsJQCfNKge65YOC1lxbYZLO0dchJW7pXvdH6eSlRm?=
 =?us-ascii?Q?2PlmFWNT4rQ7RpAY1zsdjbyOBsOqz+Lu4cQQRqdLuHuFjoBaBTVpjJOV3OSG?=
 =?us-ascii?Q?87vJM7slez0WOpDZm8/c+FZq4QXwg1UOc/1lpWJhqGjYzRvVdhavQB+1Hpw0?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3642da7-1a87-473b-34ab-08da64bbfa68
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 10:39:35.0093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqmwMwnRLEydqa0H5OLQ+RhF8nNKaMZf+NGS6dX7fji676X7NwEWn7ZcEPsa3fwPxuOWR3iuGzJ5zZY6ztDsjqhJiMrlxayokQcdgB9mRuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2859
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 13 Jul 2022 09:27:56 +0200
schrieb Bartosz Golaszewski <brgl@bgdev.pl>:

> On Tue, Jul 12, 2022 at 4:32 PM Henning Schild
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
> > index b01961999ced..1f1ec035f3c6 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -899,6 +899,15 @@ config GPIO_IT87
> >           To compile this driver as a module, choose M here: the
> > module will be called gpio_it87.
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
> > +         be called gpio_nct6116d.
> > +
> >  config GPIO_SCH
> >         tristate "Intel SCH/TunnelCreek/Centerton/Quark X1000 GPIO"
> >         depends on (X86 || COMPILE_TEST) && ACPI
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
> > index 000000000000..2ff92f3e11aa
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
> 
> I'm confused - have we not discussed removing this part?

Ah, i thought the problem was the use of subsys_initcall because the
comment was under that line.

To he honest i do not know all the details since i really just received
that driver.

What is happening here is that some init code goes and probes well
known ports to discover which chip might be connected there. Looking at
hwmon, watchdog and similar gpios ... that is the established pattern
for Super IOs.
Not DT or ACPI bindings. Something has to load that module to make it
init, where it will go and enumerate/poke around.

While i could likely put a platform_device_register_simple("driver",
0x42, "chip42") into the simatic platform, then the driver would be
pretty useless when not having ACPI (for there Super IOs in general!).
There already are hwmon and watchdog drivers for exactly that chip.

watchdog/w83627hf_wdt.c
hwmon/nct6775*

All are based on someone has to "know" and "modprobe", which will cause
"finding"

The pattern we have here seems all copied from gpio/gpio-f7188x.c,
another super similar driver is gpio/gpio-winbond.c (which is param
based and not at all reusable in other drivers).

Looking at hwmon or watchdog, Nuvoton/Fintek/Windbond are sometimes
called a family. But the driver landscape in the kernel is very spread
and a lot of copied around code. I did not even look into tty/serial or
whatever other functions these Super I/Os offer.

Looking at the way Super IO chips are driven in the kernel, it seems
all about writing a driver for each sub-function (uart, hwmon, watchdog
... and gpio). Where even very similar chips gets new drivers instead of
making existing drivers more generic.

I am just observing this and proposing a "similar copy", which i did
not even write myself. At some point it might be better to rewrite all
that and make Super I/Os platforms that discover the chip once and then
register all the many devices they have. Where ressources are properly
reserved and not that really weird "superio_enter" with
"request_muxed_region(base, 2, DRVNAME)" which can be found all over
the place. But hey that allows a very smooth mix of in-tree and
out-of-tree.

When reviewing this driver i suggest to measure it against i.e. f7188
or winbond and maybe others.

Say i would manage to make the nct6116d chip supported by f7188, would
that be acceptable? I would have the "init pattern" i need without
copying it. But i would add a Nuvoton chip to a Fintek driver ... might
be the same family ... no clue.

Henning

> Bart
> 
> > +
> > +static void __exit nct6116d_gpio_exit(void)
> > +{
> > +       platform_device_unregister(nct6116d_gpio_pdev);
> > +       platform_driver_unregister(&nct6116d_gpio_driver);
> > +}
> > +module_init(nct6116d_gpio_init);
> > +module_exit(nct6116d_gpio_exit);
> > +
> > +MODULE_DESCRIPTION("GPIO driver for Nuvoton Super-I/O chips
> > NCT5104D, NCT6106D, NCT6116D, NCT6122D");
> > +MODULE_AUTHOR("Tasanakorn Phaipool <tasanakorn@gmail.com>");
> > +MODULE_LICENSE("GPL"); --
> > 2.35.1
> >  

