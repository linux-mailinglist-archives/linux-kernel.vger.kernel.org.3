Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC94956D8C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiGKIt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGKItZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:49:25 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A3A29B;
        Mon, 11 Jul 2022 01:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2gEUJYXCbo1p5dsI+Ifis3awLvNlSdVzVW+lLFgORgdY+s7s69oIqsI48KChCrP65n6fwzlqcBHpPNmtHre9xqesdhRQwkuk1wSKDX8/b9ZkYhlEnAa5N7puEe25BFA2+8VaeP/Q/yQvSxMZ3JK1WwmEyI7wE8R9pq8tZs/iluCfq8+ly6FVwQjGPZ+N5LxZhv8jWud13OvDgKhMnUANLJsJqIyWsVN/7gal6BgTXz2oT0mTqBV0AoypksXb6iSo5kruHIe9KJLcpf48Ks4/1PEh/jyHoWcizYSYaIzZXu5agHrnYBKkGoDXe1pxuls9iFLUfvPtlz2T9YKgSKdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oq3CHZjriQT8RtBMN6HwGopYVHQWT9Ku/Y3q3lbdGPw=;
 b=A+/j8tn/f0AB2E5flANJTgYfAoADZIwS9z21Hw8L5m91sWqJD0ox3afKbh87wRHKQbMApKrzaVNR8AO8I51ZNc+GJhpi0Exx48NIbaMcE1H0Dm6aYgXtGQw9izrRzvGkc+TarjZOhYH9YsLVuLlZuy0VRmXO+6oHIX4rqjO/CiNUHDM9k4NtldeoZ4DughGyB3iqf+H421pAXts46x6lgs43FUU7CP5DJO2Pa3hwemlbUzKGajXYKCZs5HWVr298D8GLFvkFn9Bwf2Vl9iXqbBPsm4BKFcDiZ9Dv1iRwnZei7BM6EsdQ9Ek/xvARcyfiR1xAKdXZaNO6aJAUk40rQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq3CHZjriQT8RtBMN6HwGopYVHQWT9Ku/Y3q3lbdGPw=;
 b=WhbaCfQv23GEL9fcXDmfwD0BgQk7w2UHeVoX49YnuUILnvUwqkHaVGvvYH7xtnGNZQdvS7jYkJc6Aol1dfF3gpXUhS8WNojBsB3vZcJPyEvNIVC9ZW2J87JqCZ0qAm7qxlDw+nBTguwnFjrH9ypZRODRDFFEQwey3mjztfiOdqnK1XfhiqWVEG3/PR7SSYhdExbxYtzjCH45nzU21fsrOqjUr1lzcyYzjagfx+nb4+zqpKZa+S+2UHtTGqOndRfokcl+zPXUiESgp9eO05ViPL2fhRnWpN/o6YGJCNqTJ2mXrPsTdulF5k+drDeysBcduNTEqTdpa0NIPqYVYTDiXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AM0PR10MB2356.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 08:49:20 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::253b:4d66:1a99:f6e0]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::253b:4d66:1a99:f6e0%9]) with mapi id 15.20.5417.025; Mon, 11 Jul 2022
 08:49:20 +0000
Date:   Mon, 11 Jul 2022 10:49:14 +0200
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
Message-ID: <20220711104914.4a613c44@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAMRc=MeGahTCvXBgvRYSLzgPyB4gw+9EUnp7ijQUm+z0sP-BCA@mail.gmail.com>
References: <20220704130602.12307-1-henning.schild@siemens.com>
        <20220704130602.12307-2-henning.schild@siemens.com>
        <CAMRc=MeJ4LiYkCDScGBhnaDbxQsHQ8T9R2MwGOy6Ju=tkWdzXw@mail.gmail.com>
        <20220708193147.5f03c436@md1za8fc.ad001.siemens.net>
        <CAMRc=MeGahTCvXBgvRYSLzgPyB4gw+9EUnp7ijQUm+z0sP-BCA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::21) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45489c59-cb08-4cff-4cb6-08da631a3ee6
X-MS-TrafficTypeDiagnostic: AM0PR10MB2356:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4sUyVsN0zynYPcbkJ6hF/EoZBzbyibEi4lTXJcqiY6t3zt2aTwr+AbDBrPZB4rm24PN7b1yVM7gpylY9e8EJOSDsS9DBqC7c/nRo2mJZUhqm3EwCXVrEDQY5taHILu21kGlxSDgrJcJNLu+oj/Dsxe+1pKmlJNvXkjoKnVZP0VBXocEUbGWyIv0d6YGYbDnbPgbDagSaNXAdDHJLp1kJAGoN5yT2CrIBdRzaRXN0tehGjglAl9/tZiWZH7MeylkQwOys259nez4nKickO5uvbw2dXoa4u4TwSypyVGTTMNaCRNpD3Kz5IVAb2xrzcJ6HKQWHivbsXGOtMQXa5hQBAKRGgsCvS9rciM0Qga8ypHxsFbl5zm6+AjkX+NT+S+XBZ8uRvliSukte0x47KJwhKCxaCaA28WaT4vorTbIQObFcDTQIQNPpB/NFeNEEW78ub2JqpxP59QIv443XgC4DTnMFEaPzBRqOXrhvsUKBzm9b4TeFqgSdQ7AlYU2PjqtjWQIsRrYGCAIE0P4p9oGiWyb0KI8JDnJK8InlMe30Gbq2EcF9Zz/hqaSeaMKTU1BlAHgzZz4n98n37QmSe3el2Or7enGJyeh/QuEfAJeK+Qtl3jKkdO7vDFyH/6LkbWozpgnkQepaygmWX84eEAGrUhy5R5GrUwEGpzGxXf/F3/gwYCp/6OtO2E7oBV/Adc6kGvJ0zYRlzscVpYmsPq2vsHhbnhuonqvHQYqaQzUQsNWhmbPmfip83uh3nfY5R/OtZqjHwSEABahqhxwrVhkYdckUAkBO+ahV9xXYhBx1UWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(5660300002)(8936002)(44832011)(6512007)(30864003)(2906002)(83380400001)(82960400001)(86362001)(38100700002)(54906003)(478600001)(6486002)(8676002)(66476007)(66556008)(66946007)(6916009)(316002)(4326008)(1076003)(186003)(6666004)(41300700001)(53546011)(9686003)(26005)(6506007)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?29AZM/1uFVg7isIJzWP2KVJX2OTzaZ4Ed6XlV1+ZSWhHnc5jlVs0i+FP8uEj?=
 =?us-ascii?Q?ubHp1Ot/BvgHD3+gafE7JU/fkU3GDCKwqoD8wt9zbPzB0GYgtYl17LIwOa3U?=
 =?us-ascii?Q?FxvXuFQjjwRfWTpjXttrPHMnFWTnMxw8rAvWhLrH0rjn8f7ECIY0zIRcYByG?=
 =?us-ascii?Q?hzqhcfvdc5B2yzYAOU1A2Fr6xnDwrJb9Ms6JTxHx6XfbsIDcAmkipZMD7O1v?=
 =?us-ascii?Q?sCgGdaJXM/FAmYw+9B/7YKWi7tXdSe7VXwXqbOGJ7rd5YKEIxU9Nv2kGLWBQ?=
 =?us-ascii?Q?NMFveZq+dodhEOoWqyBmlyORQxJbCaHVi0lJrjil5/gRr7BGpfwjlWfzL2Mm?=
 =?us-ascii?Q?QTk9I8gfEL2MNQ74shomHSIRwT9GyJlC1v8mMIPfiPMnmKkfzGkKJXbIexWc?=
 =?us-ascii?Q?/N5LfUIBwV87dS3H2uMxPDj9PyRr9iLrGjAAXg5NrYTOm260LJfMd7RJK48q?=
 =?us-ascii?Q?mk7qcOrLfw2B3N8mZN6/Eg8KNKayezU60kPN7outuecQDScyIkAQOAJW8M/O?=
 =?us-ascii?Q?lF/iBomKWPBQBsGTeCQTxN6GFxRQci/UEbSDr4W70TmrK8KgIb1Zh56DWUq/?=
 =?us-ascii?Q?0IvqEwTBgvQo78uuuEudiUN96s0zkFK6fEcHm4dUuAR1tUvmgNDk3IH6v21C?=
 =?us-ascii?Q?jnZakvSL1mSLeFYnNLzd5JuPptS9QQ85fEMLciNWILwLriQn+MUP9JB9V5KK?=
 =?us-ascii?Q?MpuJslUGNCFGw/wcCpd4QmwfkFNh1t96tc8Wnb8E2HyPhUlc/9cXHL8pVNoG?=
 =?us-ascii?Q?64CTY7/+DF6a4fMKPPvlOJmFRXocHsaNYltuyZV0rzJgFK8zkZ66TncN43PU?=
 =?us-ascii?Q?Z75HX6q/eVz+1BR3/CCLd/WZDgsb+mDX7y5vhefyCZgPZv1/oAeBJUua/Qxj?=
 =?us-ascii?Q?6R1q2fbJI4NOqc2Cs57rrKSQNkNPllciO9Vbvuc9nWkrPCBHq0DvuihUREpi?=
 =?us-ascii?Q?ySUtEGVWwh+TKx8GCCcZoT+lgEVbTb+eQZ4EB2E8doCHCbhw/loG1Tna7Fxx?=
 =?us-ascii?Q?d61tXAEXVXz2A3gOiGsoVbveswV0cdlkjLHrij1Q0B4cxYHbtnfo+BjqpyDL?=
 =?us-ascii?Q?lNc1Ik7ofU5YKWC+SWgnryeHd1ziEUn6ad1R3HwH3kHNo+eNHyANKZjzM2dU?=
 =?us-ascii?Q?X+t394pjafeCANNknBdBkpVKwxZEskCn6kYfXFLp7u6kwuB1MbF2Lyaub4J+?=
 =?us-ascii?Q?++yoQ3S28WWHuWZSyrJE74EfyjFd6fZ6FApviupGiP8TeC7OgZR7jltr950V?=
 =?us-ascii?Q?4D8ZmaEU0erKBrCYH+ZrxNMNDVXXYk80EHa5el1MHRqMpb98PjNu7kI9J5/A?=
 =?us-ascii?Q?YnIAjC4Hiw0ykS3KKLb/tYbr+rP33C8r9Kvi2PxsESnjHf09T025Bk5tqqm0?=
 =?us-ascii?Q?IpOYgNX4SQVUsojEDs1vEyJcfJOETeSpKCVgy96Tdc+Zo5hg4bDT82YxgUkz?=
 =?us-ascii?Q?pgvOFRuxxPa37djrhVaPRWsOWA4Eh/H1SefvQ8FUGq4PcobvnnpEbOotDIHe?=
 =?us-ascii?Q?7MyeL49naRPPxIRXTd9+KNfkXkCJyvG6zhya9XXcvMU7/vWdifad3WVYoPMQ?=
 =?us-ascii?Q?lXV5CqN6RaHTK7qqoc0xtk03/CpqV+m/q5iYKuJjvZ4LwHwbiOeOcjzDt44B?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45489c59-cb08-4cff-4cb6-08da631a3ee6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 08:49:20.3488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vNAVu2oDWvdYE/Rfc8JALh4b3hK0gEuvvCyOLA7YPgKBEFuzpgbXEjCctJiCdW6JUZcPkYW+o/Zo34S7/PaKAezoo5LpPRnom94DH/MrpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2356
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 11 Jul 2022 10:02:47 +0200
schrieb Bartosz Golaszewski <brgl@bgdev.pl>:

> On Fri, Jul 8, 2022 at 7:31 PM Henning Schild
> <henning.schild@siemens.com> wrote:
> >
> > Am Fri, 8 Jul 2022 18:00:27 +0200
> > schrieb Bartosz Golaszewski <brgl@bgdev.pl>:
> >  
> > > On Mon, Jul 4, 2022 at 3:06 PM Henning Schild
> > > <henning.schild@siemens.com> wrote:  
> > > >
> > > > This patch adds gpio support for several Nuvoton NCTXXX chips.
> > > > These Super-I/O chips offer multiple functions of which several
> > > > already have drivers in the kernel, i.e. hwmon and watchdog.
> > > >
> > > > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > > > ---
> > > >  drivers/gpio/Kconfig         |   9 +
> > > >  drivers/gpio/Makefile        |   1 +
> > > >  drivers/gpio/gpio-nct6116d.c | 412
> > > > +++++++++++++++++++++++++++++++++++ 3 files changed, 422
> > > > insertions(+) create mode 100644 drivers/gpio/gpio-nct6116d.c
> > > >
> > > > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > > > index b01961999ced..40f1494b1adc 100644
> > > > --- a/drivers/gpio/Kconfig
> > > > +++ b/drivers/gpio/Kconfig
> > > > @@ -457,6 +457,15 @@ config GPIO_MXS
> > > >         select GPIO_GENERIC
> > > >         select GENERIC_IRQ_CHIP
> > > >
> > > > +config GPIO_NCT6116D
> > > > +       tristate "Nuvoton Super-I/O GPIO support"
> > > > +       help
> > > > +         This option enables support for GPIOs found on Nuvoton
> > > > Super-I/O
> > > > +         chips NCT5104D, NCT6106D, NCT6116D, NCT6122D.
> > > > +
> > > > +         To compile this driver as a module, choose M here: the
> > > > module will
> > > > +         be called gpio-nct6116d.
> > > > +
> > > >  config GPIO_OCTEON
> > > >         tristate "Cavium OCTEON GPIO"
> > > >         depends on CAVIUM_OCTEON_SOC
> > > > diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> > > > index 14352f6dfe8e..87f1b0a0cda2 100644
> > > > --- a/drivers/gpio/Makefile
> > > > +++ b/drivers/gpio/Makefile
> > > > @@ -107,6 +107,7 @@ obj-$(CONFIG_GPIO_MT7621)           +=
> > > > gpio-mt7621.o obj-$(CONFIG_GPIO_MVEBU)               +=
> > > > gpio-mvebu.o obj-$(CONFIG_GPIO_MXC)                 +=
> > > > gpio-mxc.o obj-$(CONFIG_GPIO_MXS)                 += gpio-mxs.o
> > > > +obj-$(CONFIG_GPIO_NCT6116D)            += gpio-nct6116d.o
> > > >  obj-$(CONFIG_GPIO_OCTEON)              += gpio-octeon.o
> > > >  obj-$(CONFIG_GPIO_OMAP)                        += gpio-omap.o
> > > >  obj-$(CONFIG_GPIO_PALMAS)              += gpio-palmas.o
> > > > diff --git a/drivers/gpio/gpio-nct6116d.c
> > > > b/drivers/gpio/gpio-nct6116d.c new file mode 100644
> > > > index 000000000000..6c277636c773
> > > > --- /dev/null
> > > > +++ b/drivers/gpio/gpio-nct6116d.c
> > > > @@ -0,0 +1,412 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * GPIO driver for Nuvoton Super-I/O chips NCT5104D, NCT6106D,
> > > > NCT6116D, NCT6122D
> > > > + *
> > > > + * Authors:
> > > > + *  Tasanakorn Phaipool <tasanakorn@gmail.com>
> > > > + *  Sheng-Yuan Huang <syhuang3@nuvoton.com>
> > > > + *  Kuan-Wei Ho <cwho@nuvoton.com>
> > > > + *  Henning Schild <henning.schild@siemens.com>
> > > > + */
> > > > +
> > > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > > +
> > > > +#include <linux/gpio/driver.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/platform_device.h>
> > > > +
> > > > +/*
> > > > + * Super-I/O registers
> > > > + */
> > > > +#define SIO_LDSEL              0x07    /* Logical device
> > > > select */ +#define SIO_CHIPID             0x20    /* Chaip ID
> > > > (2 bytes) */ +#define SIO_GPIO_ENABLE                0x30    /*
> > > > GPIO enable */ +
> > > > +#define SIO_LD_GPIO            0x07    /* GPIO logical device
> > > > */ +#define SIO_UNLOCK_KEY         0x87    /* Key to enable
> > > > Super-I/O */ +#define SIO_LOCK_KEY           0xAA    /* Key to
> > > > disable Super-I/O */ +
> > > > +#define SIO_ID_MASK            GENMASK(15, 4)
> > > > +#define SIO_NCT5104D_ID                0x1061
> > > > +#define SIO_NCT6106D_ID                0xC452
> > > > +#define SIO_NCT6116D_ID                0xD282
> > > > +#define SIO_NCT6122D_ID                0xD2A3
> > > > +
> > > > +enum chips {
> > > > +       nct5104d,
> > > > +       nct6106d,
> > > > +       nct6116d,
> > > > +       nct6122d,
> > > > +};
> > > > +
> > > > +static const char * const nct6116d_names[] = {
> > > > +       [nct5104d] = "nct5104d",
> > > > +       [nct6106d] = "nct6106d",
> > > > +       [nct6116d] = "nct6116d",
> > > > +       [nct6122d] = "nct6122d",
> > > > +};
> > > > +
> > > > +struct nct6116d_sio {
> > > > +       int addr;
> > > > +       enum chips type;
> > > > +};
> > > > +
> > > > +struct nct6116d_gpio_bank {
> > > > +       struct gpio_chip chip;
> > > > +       unsigned int regbase;
> > > > +       struct nct6116d_gpio_data *data;
> > > > +};
> > > > +
> > > > +struct nct6116d_gpio_data {
> > > > +       struct nct6116d_sio *sio;
> > > > +       int nr_bank;
> > > > +       struct nct6116d_gpio_bank *bank;
> > > > +};
> > > > +
> > > > +/*
> > > > + * Super-I/O functions.
> > > > + */
> > > > +
> > > > +static inline int superio_inb(int base, int reg)
> > > > +{
> > > > +       outb(reg, base);
> > > > +       return inb(base + 1);
> > > > +}
> > > > +
> > > > +static int superio_inw(int base, int reg)
> > > > +{
> > > > +       int val;
> > > > +
> > > > +       outb(reg++, base);
> > > > +       val = inb(base + 1) << 8;
> > > > +       outb(reg, base);
> > > > +       val |= inb(base + 1);
> > > > +
> > > > +       return val;
> > > > +}
> > > > +
> > > > +static inline void superio_outb(int base, int reg, int val)
> > > > +{
> > > > +       outb(reg, base);
> > > > +       outb(val, base + 1);
> > > > +}
> > > > +
> > > > +static inline int superio_enter(int base)
> > > > +{
> > > > +       /* Don't step on other drivers' I/O space by accident.
> > > > */
> > > > +       if (!request_muxed_region(base, 2, KBUILD_MODNAME)) {
> > > > +               pr_err("I/O address 0x%04x already in use\n",
> > > > base);
> > > > +               return -EBUSY;
> > > > +       }
> > > > +
> > > > +       /* According to the datasheet the key must be send
> > > > twice. */
> > > > +       outb(SIO_UNLOCK_KEY, base);
> > > > +       outb(SIO_UNLOCK_KEY, base);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static inline void superio_select(int base, int ld)
> > > > +{
> > > > +       outb(SIO_LDSEL, base);
> > > > +       outb(ld, base + 1);
> > > > +}
> > > > +
> > > > +static inline void superio_exit(int base)
> > > > +{
> > > > +       outb(SIO_LOCK_KEY, base);
> > > > +       release_region(base, 2);
> > > > +}
> > > > +
> > > > +/*
> > > > + * GPIO chip.
> > > > + */
> > > > +
> > > > +#define gpio_dir(base) ((base) + 0)
> > > > +#define gpio_data(base) ((base) + 1)
> > > > +
> > > > +static inline void *nct6116d_to_gpio_bank(struct gpio_chip
> > > > *chip) +{
> > > > +       return container_of(chip, struct nct6116d_gpio_bank,
> > > > chip); +}
> > > > +
> > > > +static int nct6116d_gpio_get_direction(struct gpio_chip *chip,
> > > > unsigned int offset) +{
> > > > +       struct nct6116d_gpio_bank *bank =
> > > > nct6116d_to_gpio_bank(chip);
> > > > +       struct nct6116d_sio *sio = bank->data->sio;
> > > > +       int err;
> > > > +       u8 dir;
> > > > +
> > > > +       err = superio_enter(sio->addr);
> > > > +       if (err)
> > > > +               return err;
> > > > +       superio_select(sio->addr, SIO_LD_GPIO);
> > > > +
> > > > +       dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> > > > +
> > > > +       superio_exit(sio->addr);
> > > > +
> > > > +       if (dir & 1 << offset)
> > > > +               return GPIO_LINE_DIRECTION_OUT;
> > > > +
> > > > +       return GPIO_LINE_DIRECTION_IN;
> > > > +}
> > > > +
> > > > +static int nct6116d_gpio_direction_in(struct gpio_chip *chip,
> > > > unsigned int offset) +{
> > > > +       struct nct6116d_gpio_bank *bank =
> > > > nct6116d_to_gpio_bank(chip);
> > > > +       struct nct6116d_sio *sio = bank->data->sio;
> > > > +       int err;
> > > > +       u8 dir;
> > > > +
> > > > +       err = superio_enter(sio->addr);
> > > > +       if (err)
> > > > +               return err;
> > > > +       superio_select(sio->addr, SIO_LD_GPIO);
> > > > +
> > > > +       dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> > > > +       dir |= BIT(offset);
> > > > +       superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
> > > > +
> > > > +       superio_exit(sio->addr);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int nct6116d_gpio_get(struct gpio_chip *chip, unsigned
> > > > int offset) +{
> > > > +       struct nct6116d_gpio_bank *bank =
> > > > nct6116d_to_gpio_bank(chip);
> > > > +       struct nct6116d_sio *sio = bank->data->sio;
> > > > +       int err;
> > > > +       u8 data;
> > > > +
> > > > +       err = superio_enter(sio->addr);
> > > > +       if (err)
> > > > +               return err;
> > > > +       superio_select(sio->addr, SIO_LD_GPIO);
> > > > +
> > > > +       data = superio_inb(sio->addr, gpio_data(bank->regbase));
> > > > +
> > > > +       superio_exit(sio->addr);
> > > > +
> > > > +       return !!(data & BIT(offset));
> > > > +}
> > > > +
> > > > +static int nct6116d_gpio_direction_out(struct gpio_chip *chip,
> > > > +                                    unsigned int offset, int
> > > > value) +{
> > > > +       struct nct6116d_gpio_bank *bank =
> > > > nct6116d_to_gpio_bank(chip);
> > > > +       struct nct6116d_sio *sio = bank->data->sio;
> > > > +       u8 dir, data_out;
> > > > +       int err;
> > > > +
> > > > +       err = superio_enter(sio->addr);
> > > > +       if (err)
> > > > +               return err;
> > > > +       superio_select(sio->addr, SIO_LD_GPIO);
> > > > +
> > > > +       data_out = superio_inb(sio->addr,
> > > > gpio_data(bank->regbase));
> > > > +       if (value)
> > > > +               data_out |= BIT(offset);
> > > > +       else
> > > > +               data_out &= ~BIT(offset);
> > > > +       superio_outb(sio->addr, gpio_data(bank->regbase),
> > > > data_out); +
> > > > +       dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> > > > +       dir &= ~BIT(offset);
> > > > +       superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
> > > > +
> > > > +       superio_exit(sio->addr);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static void nct6116d_gpio_set(struct gpio_chip *chip, unsigned
> > > > int offset, int value) +{
> > > > +       struct nct6116d_gpio_bank *bank =
> > > > nct6116d_to_gpio_bank(chip);
> > > > +       struct nct6116d_sio *sio = bank->data->sio;
> > > > +       u8 data_out;
> > > > +       int err;
> > > > +
> > > > +       err = superio_enter(sio->addr);
> > > > +       if (err)
> > > > +               return;
> > > > +       superio_select(sio->addr, SIO_LD_GPIO);
> > > > +
> > > > +       data_out = superio_inb(sio->addr,
> > > > gpio_data(bank->regbase));
> > > > +       if (value)
> > > > +               data_out |= BIT(offset);
> > > > +       else
> > > > +               data_out &= ~BIT(offset);
> > > > +       superio_outb(sio->addr, gpio_data(bank->regbase),
> > > > data_out); +
> > > > +       superio_exit(sio->addr);
> > > > +}
> > > > +
> > > > +#define NCT6116D_GPIO_BANK(_base, _ngpio, _regbase, _label)
> > > >             \
> > > > +       {
> > > >             \
> > > > +               .chip = {
> > > >             \
> > > > +                       .label            = _label,
> > > >             \
> > > > +                       .owner            = THIS_MODULE,
> > > >             \
> > > > +                       .get_direction    =
> > > > nct6116d_gpio_get_direction,        \
> > > > +                       .direction_input  =
> > > > nct6116d_gpio_direction_in,         \
> > > > +                       .get              = nct6116d_gpio_get,
> > > >             \
> > > > +                       .direction_output =
> > > > nct6116d_gpio_direction_out,        \
> > > > +                       .set              = nct6116d_gpio_set,
> > > >             \
> > > > +                       .base             = _base,
> > > >             \
> > > > +                       .ngpio            = _ngpio,
> > > >             \
> > > > +                       .can_sleep        = false,
> > > >             \
> > > > +               },
> > > >             \
> > > > +               .regbase = _regbase,
> > > >             \
> > > > +       }
> > > > +
> > > > +static struct nct6116d_gpio_bank nct6116d_gpio_bank[] = {
> > > > +       NCT6116D_GPIO_BANK(0, 8, 0xE0, KBUILD_MODNAME "-0"),
> > > > +       NCT6116D_GPIO_BANK(10, 8, 0xE4, KBUILD_MODNAME "-1"),
> > > > +       NCT6116D_GPIO_BANK(20, 8, 0xE8, KBUILD_MODNAME "-2"),
> > > > +       NCT6116D_GPIO_BANK(30, 8, 0xEC, KBUILD_MODNAME "-3"),
> > > > +       NCT6116D_GPIO_BANK(40, 8, 0xF0, KBUILD_MODNAME "-4"),
> > > > +};
> > > > +
> > > > +/*
> > > > + * Platform device and driver.
> > > > + */
> > > > +
> > > > +static int nct6116d_gpio_probe(struct platform_device *pdev)
> > > > +{
> > > > +       struct nct6116d_sio *sio = pdev->dev.platform_data;
> > > > +       struct nct6116d_gpio_data *data;
> > > > +       int err;
> > > > +       int i;
> > > > +
> > > > +       data = devm_kzalloc(&pdev->dev, sizeof(*data),
> > > > GFP_KERNEL);
> > > > +       if (!data)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       data->nr_bank = ARRAY_SIZE(nct6116d_gpio_bank);
> > > > +       data->bank = nct6116d_gpio_bank;
> > > > +       data->sio = sio;
> > > > +
> > > > +       platform_set_drvdata(pdev, data);
> > > > +
> > > > +       /* For each GPIO bank, register a GPIO chip. */
> > > > +       for (i = 0; i < data->nr_bank; i++) {
> > > > +               struct nct6116d_gpio_bank *bank =
> > > > &data->bank[i]; +
> > > > +               bank->chip.parent = &pdev->dev;
> > > > +               bank->data = data;
> > > > +
> > > > +               err = devm_gpiochip_add_data(&pdev->dev,
> > > > &bank->chip, bank);
> > > > +               if (err)
> > > > +                       return dev_err_probe(&pdev->dev, err,
> > > > +                               "Failed to register gpiochip
> > > > %d\n", i);
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int __init nct6116d_find(int addr, struct nct6116d_sio
> > > > *sio) +{
> > > > +       u16 devid;
> > > > +       int err;
> > > > +
> > > > +       err = superio_enter(addr);
> > > > +       if (err)
> > > > +               return err;
> > > > +
> > > > +       devid = superio_inw(addr, SIO_CHIPID);
> > > > +       superio_exit(addr);
> > > > +       switch (devid & SIO_ID_MASK) {
> > > > +       case SIO_NCT5104D_ID & SIO_ID_MASK:
> > > > +               sio->type = nct5104d;
> > > > +               break;
> > > > +       case SIO_NCT6106D_ID & SIO_ID_MASK:
> > > > +               sio->type = nct6106d;
> > > > +               break;
> > > > +       case SIO_NCT6116D_ID & SIO_ID_MASK:
> > > > +               sio->type = nct6116d;
> > > > +               break;
> > > > +       case SIO_NCT6122D_ID & SIO_ID_MASK:
> > > > +               sio->type = nct6122d;
> > > > +               break;
> > > > +       default:
> > > > +               pr_info("Unsupported device 0x%04x\n", devid);
> > > > +               return -ENODEV;
> > > > +       }
> > > > +       sio->addr = addr;
> > > > +
> > > > +       pr_info("Found %s at 0x%x chip id 0x%04x\n",
> > > > +               nct6116d_names[sio->type], addr, devid);
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static struct platform_device *nct6116d_gpio_pdev;
> > > > +
> > > > +static int __init
> > > > +nct6116d_gpio_device_add(const struct nct6116d_sio *sio)
> > > > +{
> > > > +       int err;
> > > > +
> > > > +       nct6116d_gpio_pdev =
> > > > platform_device_alloc(KBUILD_MODNAME, -1);
> > > > +       if (!nct6116d_gpio_pdev)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       err = platform_device_add_data(nct6116d_gpio_pdev, sio,
> > > > sizeof(*sio));
> > > > +       if (err) {
> > > > +               pr_err("Platform data allocation failed\n");
> > > > +               goto err;
> > > > +       }
> > > > +
> > > > +       err = platform_device_add(nct6116d_gpio_pdev);
> > > > +       if (err) {
> > > > +               pr_err("Device addition failed\n");
> > > > +               goto err;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +
> > > > +err:
> > > > +       platform_device_put(nct6116d_gpio_pdev);
> > > > +
> > > > +       return err;
> > > > +}
> > > > +
> > > > +static struct platform_driver nct6116d_gpio_driver = {
> > > > +       .driver = {
> > > > +               .name   = KBUILD_MODNAME,
> > > > +       },
> > > > +       .probe          = nct6116d_gpio_probe,
> > > > +};
> > > > +
> > > > +static int __init nct6116d_gpio_init(void)
> > > > +{
> > > > +       struct nct6116d_sio sio;
> > > > +       int err;
> > > > +
> > > > +       if (nct6116d_find(0x2e, &sio) &&
> > > > +           nct6116d_find(0x4e, &sio))
> > > > +               return -ENODEV;
> > > > +
> > > > +       err = platform_driver_register(&nct6116d_gpio_driver);
> > > > +       if (!err) {
> > > > +               err = nct6116d_gpio_device_add(&sio);
> > > > +               if (err)
> > > > +
> > > > platform_driver_unregister(&nct6116d_gpio_driver);
> > > > +       }
> > > > +
> > > > +       return err;
> > > > +}
> > > > +subsys_initcall(nct6116d_gpio_init);
> > > > +  
> > >
> > > I need some explanation on this part. You load the module and it
> > > creates and registers the platform device? This is not how it's
> > > done in the kernel. It's a platform device so it shouldn't be
> > > dynamically probed for in the module's init function. It should
> > > be defined in device-tree or ACPI. What platform are you using it
> > > on? Manual creation of platform devices is limited to a small set
> > > of special cases.  
> >
> > I only received this code from Nuvoton and can not explain all the
> > bits. This is clearly a copied pattern from other gpio-xxx.c files,
> > where exceptions might apply that this one does not deserve.
> >
> > For the machines i care about i will already have a platform device
> > driver where i can pull that gpio driver in, either using
> > platform_device_register or request_module.
> >
> > So i guess that part can simply be dropped.
> >  
> 
> Yes please, the platform driver looks fine but that device
> registration part must go.

So the other style changes Andy was pointing out would not be needed? I
would do them but really it is just work to receive a driver that looks
different than others in the subsystem. So i am not even sure it adds
value.

> > On top of this GPIO driver i will later propose changes to
> > drivers/platform/x86/simatic-ipc.c
> > drivers/leds/simple/simatic-ipc-leds*
> > But the GPIO driver is useful on its own so i did not yet send the
> > user of the GPIO driver. It can be useful for people going to
> > "modprobe" and use the sysfs gpio interface.
> >
> > I wanted to keep the discussion small, not hide the user. Also the
> > LED subsystem currently seems kind of stuck so i wanted to avoid
> > touching it.
> >
> > If it helps i can send the gpio driver with the "coming in-tree
> > user". Will do so on request, but as said .. it is useful on its
> > own and keeping the rounds small might be good.
> >  
> 
> Yes, please, that would be helpful. It would also indicate how you
> want to define the device (device-tree?) for your system.

The device would not be defined in device-tree or ACPI. It would be
registered by "simatic-ipc" after detecting the device model via DMI.
So the knowledge that a particular model has that particiular Super-IO
for its LEDs ... would be knowledge of that x86 platform driver.

I know that is not ideal, but it is what it is. And these boxes can be
identified very clearly by unique identifiers in DMI.

I will include code to show that, probably not intended for a merge.
Since i have simatic-ipc LED patches queued up elsewhere and am just
trying to get the infra for the next models of that platform.

regards,
Henning

> Bart
> 
> > regards,
> > Henning
> >  
> > > Bart
> > >  
> > > > +static void __exit nct6116d_gpio_exit(void)
> > > > +{
> > > > +       platform_device_unregister(nct6116d_gpio_pdev);
> > > > +       platform_driver_unregister(&nct6116d_gpio_driver);
> > > > +}
> > > > +module_exit(nct6116d_gpio_exit);
> > > > +
> > > > +MODULE_DESCRIPTION("GPIO driver for Nuvoton Super-I/O chips
> > > > NCT5104D, NCT6106D, NCT6116D, NCT6122D");
> > > > +MODULE_AUTHOR("Tasanakorn Phaipool <tasanakorn@gmail.com>");
> > > > +MODULE_LICENSE("GPL"); --
> > > > 2.35.1
> > > >  
> >  

