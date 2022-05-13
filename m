Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6A7526AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 21:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383904AbiEMTkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 15:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357622AbiEMTki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 15:40:38 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60065.outbound.protection.outlook.com [40.107.6.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F107286F6;
        Fri, 13 May 2022 12:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOzNcXE1gqHraBhgz6Lo3ujxwgA8LJjeB8o0NfxLlTHfSqETbesGkKEWU5IEcfHrNJJ9N32Lxf/XTcCMqXgEHftb8GhHreYdHBR+VouKUyp3zXvJiPnyoRJNq6ndIJASfoi0X2VRvhNeSlmTH4ke8Yir9ZIUTMbH32zEvV7LuyD9DhcuQFEYMHeIitHn7uYIl+2F7jW3gi5E3WSVoXsnQLp2xmBXLXm/fV2PVXkW0ABIgESCQdlmCacYwm5DSTAnXePHhFkOg4QjSjSuN0nA0ME+bXyt0aTTe+gs9jJegu6n8NNEMRtW0v1Z1FKFmbwoma3tCxOboG8/a95gpeMBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bmjGaQpMwIjeTV+VyjlX+OkRsDYrKUPnLDIH09gQZ0=;
 b=aGslk4qI1XDeaWfd/rII4NSM7NEfZS9gu0PvgQBCELd3KDXZlJtDBpWOHMCslL3Tk3eQplFLb0E3v8mGBfPKqXyDwJTCAe8qhp8eYcd8XpOu/yarCjz44UrHF7Ehf2Cs3+OcDajkVEfIwWCX1rqnr9jKUIC9cKVcxnrS4ZNz27HiU11i/yYUL96UCGXyPX8gvAjFZOifkBSvVPLa4+nuztQhJKEtsrVHO29CcVRAf8YU3dyzUVFfQFXsXH1sUo1OIqjptZQPPu1LRBGyoGea//ogw7pBR0zEVmibJTd5111vg0lKdom/wzzrvhzVtZfE3rIJTafUBn/6Aw0GynwM2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bmjGaQpMwIjeTV+VyjlX+OkRsDYrKUPnLDIH09gQZ0=;
 b=K9pVyJYFKeSdOXORnnwUyy9t0vzbd9afAwq0RlyS8VrjF0wwsb7J/51sHXyXaVD5osN3qCDNhqMxeb6pE/BhUW3/XVYZoNVI6MIZHBBPgzgbVY1Gcv95fg9lqe2BcfLn9ozD43Vbv7iVwW86Y6Xc+yzq2kxfduWfpXF3Rjgy1ySUTKZIILdZJXQKxVhCpR47kLbDTS1WSRtE0ghyZXND/xDd9R92Og1Md0D67Dx8U0HQnrp+OS/WxCzUNqG7ytPyZSvRnZ+WspWuTqRXQjQnc+2t4TBgNBVzo/uSCZpwy8ttATOS8b+ZR/kp7JKxV/Vm4mbhNkAx6xq/aUcFbQL6lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS1PR10MB5365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 19:40:34 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::160:83bb:cf0a:10da]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::160:83bb:cf0a:10da%4]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 19:40:34 +0000
Date:   Fri, 13 May 2022 21:40:30 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>
Cc:     Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        "Gerd Haeussler" <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Weigelt <lkml@metux.net>
Subject: Re: [PATCH v5 2/4] leds: simatic-ipc-leds: add new driver for
 Siemens Industial PCs
Message-ID: <20220513214030.7254b1bf@md1za8fc.ad001.siemens.net>
In-Reply-To: <20211213120502.20661-3-henning.schild@siemens.com>
References: <20211213120502.20661-1-henning.schild@siemens.com>
        <20211213120502.20661-3-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P192CA0080.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::21) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f940ea5-6389-4fa2-72b8-08da351872b5
X-MS-TrafficTypeDiagnostic: AS1PR10MB5365:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-Microsoft-Antispam-PRVS: <AS1PR10MB5365CF37D7BDF7BDFA5EE0A985CA9@AS1PR10MB5365.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FUen9zWrCNgdQpWPqaA/UZBPTXA1VI1fsHyj8Lc+910EbqwjWRTSeD5VY5ssuyHrRUCUzTAf6842QwLlwtSxkvl66cSmwqVywT4xOFXAVBC0L0UB3nTxMWi1aJh7DyWUnng+05BvZQRMF3yl8YF0BqHfIWND0tKOIpr5zui68yYSY6KNT3OOtkaSoZIJmVZWOTkTYVuRJC9p95ln820jYsiWiqiEhOYGPLCM60udeBxHZRUb8/5WuoUMCCa7aPNUHTejqY0b884Gsq7BHk94UbW/25QapDVkmifr8fj62Bzrb9a7ZSNcSVsZXrPPU2h6CAXHrSpZl7G3VR63kt9wTkKIN6mKagMxwika1spBAgZ8L3Uok8uZbAj/cGAaveIt+mcsdBC//VizPBC+lmnTnCsxRmnY0Nn0PMqZpW2joZ7Fl/z3aSjAxtuCsIt3VBMgEEp3V2CcKAUdLFm17TXH4m5ZwNu1+tThXBsA6VBLDyE5WN3DKCpR/qD/QzqlbC17c+svuoWTprQELZYSua277Ewg8n2NSLgKGIZU8Bkt9g1ZLOY4ZMZccaExpMdgg7nLfQJH/Y3Es48j/v9xOgMYsklnCt0AYJR+kqBDAHZk31I5CbKfLtzZN0a8j5rpOUBO5+GGXN4gAEsepBNkSF8sQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(110136005)(44832011)(186003)(6486002)(316002)(54906003)(5660300002)(4326008)(66556008)(86362001)(66946007)(66476007)(8676002)(2906002)(7416002)(8936002)(1076003)(38100700002)(83380400001)(6506007)(9686003)(6512007)(6666004)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zZB862PXxwoXRJmaoJvZJQyen9x1I5ucTCKR++djseU1Sq9FPnf1DdGtDDgB?=
 =?us-ascii?Q?el+NBOqwLyA8WnyhwtWl27S5PaguCY9A3vxY8X8zQDdl5Sa312pe+eaa7LuH?=
 =?us-ascii?Q?t1nOH3ZkMC4zixy9eM8xEMTbyW7G6M8WhkLAQbni1lbyrjDkWnvND4fuNFiI?=
 =?us-ascii?Q?t/ptg2q2g5jNrKks7UzIw4CJcLMAWoKi9O2H+jUBaziXgpjdO9UxHoBPa1rc?=
 =?us-ascii?Q?L4QJK8wKCuk6P/8aEJKBaQDajGBbgd4LnZvm79XKqIP7ZtlpqqySeHFoeotq?=
 =?us-ascii?Q?OHsZLLVkkHG1Eaa/O6MdpZfzk2GrOAcc2GZc7AxQlXKFcQ21Ity6G7qmt0kI?=
 =?us-ascii?Q?EUKtUIdl2H3iopj5y68pIaJPM9uqrXeTgyB7Pi8yrhT4ALFZiFoOtG+bCo2h?=
 =?us-ascii?Q?Z+5SvsdCKpUhrcIoUdvDRdsdI9a0zJmqQJWt9o8V33xjqB6uj33xheYoi2vk?=
 =?us-ascii?Q?0lGqZWMPlux4QiWEDoKvbNZdJfd4ll8d0PqZyRA9PEw7HmLa0fWkN9zIv4B0?=
 =?us-ascii?Q?mGkyWXScdRWOZc0+eNwqmIHnLE7roNuJwzLkpxvNdkI/eO3aHfExlWbT2ovB?=
 =?us-ascii?Q?pX4xxeCSggWDtwC8r/tAlSSV3035T9I7fnbqGridZSqaYa/KGTPeXeZ45BKy?=
 =?us-ascii?Q?lY6eZ9HRCKyJrxhSYVFBl8AvGsRvOLgdyEt8tkwLwfDgOkrWns3V5vWPNvhp?=
 =?us-ascii?Q?ZZCGWWww/gRFsRN/rPEfR2f+pY5m8q8lWusbG8nBAULrngz+Dyo5vdwfug/k?=
 =?us-ascii?Q?bfchmj3XY1YhqqOv6xg1qKd9VXVZ0S/aSxfl0t1Vandx8W9Z2fjR1ujrUJRX?=
 =?us-ascii?Q?E0S69qNatvlA8153lTBr4hnzYPAc/7/XjYovEpUpAbOWrcC5BJeauAx5XBVh?=
 =?us-ascii?Q?ZoRjqPEOc4ncQegKcQSF6KfxU2FKhuykJfIYfJkxgY5/bieCngBJri1ytpGl?=
 =?us-ascii?Q?n+Gol1aB/3XwlblBN/EF1lWRkwvKX3z67pLQWzMCgdcpn9yeuXfrNOgEgCNG?=
 =?us-ascii?Q?gkJOjg4jjsQwPQ+120cTwgkaUZrZJ273F3vFDDLEPiJF2ePnd6Yvy1Amdr4O?=
 =?us-ascii?Q?siyrHjXb7Q2L/muxzkEbnELUe50Z4CqR1hjHCj+ckUyynyHgXf6fy84F0csS?=
 =?us-ascii?Q?ux/GNXi/X32ctInCOqwDlnYyIz/0CzuPm57+gE3DHf/EnSiAixXcMLUP3rVN?=
 =?us-ascii?Q?mXJGkZNP8iQUTsTL0iPNOqn/zCfI+6cltI0XRU6tuKf9ai4ecFE9mN+k8Xif?=
 =?us-ascii?Q?ZDDKUqzxsWFYuqccZuoq/8UwvYCI9QX9vrAf0Hda9x2D3gJy0nM0JOpKHkvx?=
 =?us-ascii?Q?DGPNKmPV1rRLU3sFz7TBdn0BryzrZYm5QsJpZXzaPT7A3lNDxz/Yt9C89Nad?=
 =?us-ascii?Q?SHJ8K6m8rkOHqHbqP3ZPJ2adkEJta+x+abhl320o3fk6/C//JdyJPfasE8HJ?=
 =?us-ascii?Q?QQcZ1vQD7LdwGCkhiz06nnVb7AMSd+h3gmAknC4pBI2sOgkPL0d/j2XuM37r?=
 =?us-ascii?Q?n13LUNaGQPmUPMCD13Je8mVO2NE0c0DM+BxqgNZhiNwfdzOdgvf9BKUbBGdj?=
 =?us-ascii?Q?lznotur4LCDS5+hveskpofUx1w2OJNQoWJpX69Ceta9sdHo5Doy4VgCQsmGm?=
 =?us-ascii?Q?qFL3RR0L7BrLGPrevyg5a6sZDU6eo0xW4rt7bzD4DpUe3uUkG6C/JShKDHMT?=
 =?us-ascii?Q?QF9fYhShTWVJHbHJMzFgkNHvD9MELyTQpvLXj11U1zTH3H05EYc/sun2vv7a?=
 =?us-ascii?Q?8wEdT1VirZIv7gHj044dVeuSN/AgE7v+ZPC5gN2a7wFFAmBuz0w9+F74Bo6U?=
X-MS-Exchange-AntiSpam-MessageData-1: 9lljwOAJhsCj8mS2hkhk9m84J0Z6aoXTvnM=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f940ea5-6389-4fa2-72b8-08da351872b5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 19:40:34.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LU3tzU6eGEoVDZilc8jcXWk6FiD96QRJ8GTjev7ggn+F38E+q93pLuYWTONNHFbi+o/fpPVdAsYvZFVhgMFKwiU+WvKOVbZ6lfEx+fsCkx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5365
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 13 Dec 2021 13:05:00 +0100
schrieb Henning Schild <henning.schild@siemens.com>:

> This driver adds initial support for several devices from Siemens. It
> is based on a platform driver introduced in an earlier commit.
> 
> One of the supported machines has GPIO connected LEDs, here we poke
> GPIO memory directly because pinctrl does not come up.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/leds/Kconfig                   |   3 +
>  drivers/leds/Makefile                  |   3 +
>  drivers/leds/simple/Kconfig            |  11 ++
>  drivers/leds/simple/Makefile           |   2 +
>  drivers/leds/simple/simatic-ipc-leds.c | 202
> +++++++++++++++++++++++++ 5 files changed, 221 insertions(+)
>  create mode 100644 drivers/leds/simple/Kconfig
>  create mode 100644 drivers/leds/simple/Makefile
>  create mode 100644 drivers/leds/simple/simatic-ipc-leds.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index ed800f5da7d8..ac6688d7a3f4 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -879,4 +879,7 @@ source "drivers/leds/flash/Kconfig"
>  comment "LED Triggers"
>  source "drivers/leds/trigger/Kconfig"
>  
> +comment "Simple LED drivers"
> +source "drivers/leds/simple/Kconfig"
> +
>  endif # NEW_LEDS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index c636ec069612..1a719caf14c0 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -105,3 +105,6 @@ obj-$(CONFIG_LEDS_TRIGGERS)		+=
> trigger/ 
>  # LED Blink
>  obj-y					+= blink/
> +
> +# Simple LED drivers
> +obj-y					+= simple/
> diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
> new file mode 100644
> index 000000000000..9f6a68336659
> --- /dev/null
> +++ b/drivers/leds/simple/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config LEDS_SIEMENS_SIMATIC_IPC
> +	tristate "LED driver for Siemens Simatic IPCs"
> +	depends on LEDS_CLASS
> +	depends on SIEMENS_SIMATIC_IPC

Trying to bring this into distros i think this one should rather be
"select SIEMENS_SIMATIC_IPC" and the same thought goes for wdt.

Users care about enabling a feature and maybe not too much about having
to enable infra, enabling SIEMENS_SIMATIC_IPC is just infra and useless
without LEDS_SIEMENS_SIMATIC_IPC and/or SIEMENS_SIMATIC_IPC_WDT.

So those two should probably "select" and not "depend".

I will send a patch, feel free to tell me that i am wrong and teach me
about how deps should work.

regards,
Henning

> +	help
> +	  This option enables support for the LEDs of several
> Industrial PCs
> +	  from Siemens.
> +
> +	  To compile this driver as a module, choose M here: the
> module
> +	  will be called simatic-ipc-leds.
> diff --git a/drivers/leds/simple/Makefile
> b/drivers/leds/simple/Makefile new file mode 100644
> index 000000000000..8481f1e9e360
> --- /dev/null
> +++ b/drivers/leds/simple/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds.o
> diff --git a/drivers/leds/simple/simatic-ipc-leds.c
> b/drivers/leds/simple/simatic-ipc-leds.c new file mode 100644
> index 000000000000..ff2c96e73241
> --- /dev/null
> +++ b/drivers/leds/simple/simatic-ipc-leds.c
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Siemens SIMATIC IPC driver for LEDs
> + *
> + * Copyright (c) Siemens AG, 2018-2021
> + *
> + * Authors:
> + *  Henning Schild <henning.schild@siemens.com>
> + *  Jan Kiszka <jan.kiszka@siemens.com>
> + *  Gerd Haeussler <gerd.haeussler.ext@siemens.com>
> + */
> +
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/platform_data/x86/simatic-ipc-base.h>
> +#include <linux/platform_device.h>
> +#include <linux/sizes.h>
> +#include <linux/spinlock.h>
> +
> +#define SIMATIC_IPC_LED_PORT_BASE	0x404E
> +
> +struct simatic_ipc_led {
> +	unsigned int value; /* mask for io and offset for mem */
> +	char *name;
> +	struct led_classdev cdev;
> +};
> +
> +static struct simatic_ipc_led simatic_ipc_leds_io[] = {
> +	{1 << 15, "green:" LED_FUNCTION_STATUS "-1" },
> +	{1 << 7,  "yellow:" LED_FUNCTION_STATUS "-1" },
> +	{1 << 14, "red:" LED_FUNCTION_STATUS "-2" },
> +	{1 << 6,  "yellow:" LED_FUNCTION_STATUS "-2" },
> +	{1 << 13, "red:" LED_FUNCTION_STATUS "-3" },
> +	{1 << 5,  "yellow:" LED_FUNCTION_STATUS "-3" },
> +	{ }
> +};
> +
> +/* the actual start will be discovered with PCI, 0 is a placeholder
> */ +struct resource simatic_ipc_led_mem_res = DEFINE_RES_MEM_NAMED(0,
> SZ_4K, KBUILD_MODNAME); +
> +static void *simatic_ipc_led_memory;
> +
> +static struct simatic_ipc_led simatic_ipc_leds_mem[] = {
> +	{0x500 + 0x1A0, "red:" LED_FUNCTION_STATUS "-1"},
> +	{0x500 + 0x1A8, "green:" LED_FUNCTION_STATUS "-1"},
> +	{0x500 + 0x1C8, "red:" LED_FUNCTION_STATUS "-2"},
> +	{0x500 + 0x1D0, "green:" LED_FUNCTION_STATUS "-2"},
> +	{0x500 + 0x1E0, "red:" LED_FUNCTION_STATUS "-3"},
> +	{0x500 + 0x198, "green:" LED_FUNCTION_STATUS "-3"},
> +	{ }
> +};
> +
> +static struct resource simatic_ipc_led_io_res =
> +	DEFINE_RES_IO_NAMED(SIMATIC_IPC_LED_PORT_BASE, SZ_2,
> KBUILD_MODNAME); +
> +static DEFINE_SPINLOCK(reg_lock);
> +
> +static inline struct simatic_ipc_led *cdev_to_led(struct
> led_classdev *led_cd) +{
> +	return container_of(led_cd, struct simatic_ipc_led, cdev);
> +}
> +
> +static void simatic_ipc_led_set_io(struct led_classdev *led_cd,
> +				   enum led_brightness brightness)
> +{
> +	struct simatic_ipc_led *led = cdev_to_led(led_cd);
> +	unsigned long flags;
> +	unsigned int val;
> +
> +	spin_lock_irqsave(&reg_lock, flags);
> +
> +	val = inw(SIMATIC_IPC_LED_PORT_BASE);
> +	if (brightness == LED_OFF)
> +		outw(val | led->value, SIMATIC_IPC_LED_PORT_BASE);
> +	else
> +		outw(val & ~led->value, SIMATIC_IPC_LED_PORT_BASE);
> +
> +	spin_unlock_irqrestore(&reg_lock, flags);
> +}
> +
> +static enum led_brightness simatic_ipc_led_get_io(struct
> led_classdev *led_cd) +{
> +	struct simatic_ipc_led *led = cdev_to_led(led_cd);
> +
> +	return inw(SIMATIC_IPC_LED_PORT_BASE) & led->value ? LED_OFF
> : led_cd->max_brightness; +}
> +
> +static void simatic_ipc_led_set_mem(struct led_classdev *led_cd,
> +				    enum led_brightness brightness)
> +{
> +	struct simatic_ipc_led *led = cdev_to_led(led_cd);
> +
> +	u32 *p;
> +
> +	p = simatic_ipc_led_memory + led->value;
> +	*p = (*p & ~1) | (brightness == LED_OFF);
> +}
> +
> +static enum led_brightness simatic_ipc_led_get_mem(struct
> led_classdev *led_cd) +{
> +	struct simatic_ipc_led *led = cdev_to_led(led_cd);
> +
> +	u32 *p;
> +
> +	p = simatic_ipc_led_memory + led->value;
> +	return (*p & 1) ? LED_OFF : led_cd->max_brightness;
> +}
> +
> +static int simatic_ipc_leds_probe(struct platform_device *pdev)
> +{
> +	const struct simatic_ipc_platform *plat =
> pdev->dev.platform_data;
> +	struct device *dev = &pdev->dev;
> +	struct simatic_ipc_led *ipcled;
> +	struct led_classdev *cdev;
> +	struct resource *res;
> +	int err, type;
> +	u32 *p;
> +
> +	switch (plat->devmode) {
> +	case SIMATIC_IPC_DEVICE_227D:
> +	case SIMATIC_IPC_DEVICE_427E:
> +		res = &simatic_ipc_led_io_res;
> +		ipcled = simatic_ipc_leds_io;
> +		/* on 227D the two bytes work the other way araound
> */
> +		if (plat->devmode == SIMATIC_IPC_DEVICE_227D) {
> +			while (ipcled->value) {
> +				ipcled->value =
> swab16(ipcled->value);
> +				ipcled++;
> +			}
> +			ipcled = simatic_ipc_leds_io;
> +		}
> +		type = IORESOURCE_IO;
> +		if (!devm_request_region(dev, res->start,
> resource_size(res), KBUILD_MODNAME)) {
> +			dev_err(dev, "Unable to register IO resource
> at %pR\n", res);
> +			return -EBUSY;
> +		}
> +		break;
> +	case SIMATIC_IPC_DEVICE_127E:
> +		res = &simatic_ipc_led_mem_res;
> +		ipcled = simatic_ipc_leds_mem;
> +		type = IORESOURCE_MEM;
> +
> +		/* get GPIO base from PCI */
> +		res->start = simatic_ipc_get_membase0(PCI_DEVFN(13,
> 0));
> +		if (res->start == 0)
> +			return -ENODEV;
> +
> +		/* do the final address calculation */
> +		res->start = res->start + (0xC5 << 16);
> +		res->end += res->start;
> +
> +		simatic_ipc_led_memory = devm_ioremap_resource(dev,
> res);
> +		if (IS_ERR(simatic_ipc_led_memory))
> +			return PTR_ERR(simatic_ipc_led_memory);
> +
> +		/* initialize power/watchdog LED */
> +		p = simatic_ipc_led_memory + 0x500 + 0x1D8; /*
> PM_WDT_OUT */
> +		*p = (*p & ~1);
> +		p = simatic_ipc_led_memory + 0x500 + 0x1C0; /*
> PM_BIOS_BOOT_N */
> +		*p = (*p | 1);
> +
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	while (ipcled->value) {
> +		cdev = &ipcled->cdev;
> +		if (type == IORESOURCE_MEM) {
> +			cdev->brightness_set =
> simatic_ipc_led_set_mem;
> +			cdev->brightness_get =
> simatic_ipc_led_get_mem;
> +		} else {
> +			cdev->brightness_set =
> simatic_ipc_led_set_io;
> +			cdev->brightness_get =
> simatic_ipc_led_get_io;
> +		}
> +		cdev->max_brightness = LED_ON;
> +		cdev->name = ipcled->name;
> +
> +		err = devm_led_classdev_register(dev, cdev);
> +		if (err < 0)
> +			return err;
> +		ipcled++;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver simatic_ipc_led_driver = {
> +	.probe = simatic_ipc_leds_probe,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +	}
> +};
> +
> +module_platform_driver(simatic_ipc_led_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" KBUILD_MODNAME);
> +MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");

