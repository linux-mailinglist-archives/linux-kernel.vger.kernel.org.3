Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AAD5237AE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343942AbiEKPtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbiEKPtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:49:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A516A43C;
        Wed, 11 May 2022 08:48:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfxUVZDs4Rd5UnlsNJwpN13R4v8f+hb6e5rlfgHhcW/IIWJ4gm5rDW3V8jGPjbeJg30JNij/WXMMFX2HUxmBkde5IFNhFyU1SrX4hPNtUjrWiel4dfW9r7abg7stOZnsFVpzOXL9i49FjxVOQiJx+TZs/p5deHl7DrR7jg4hCOYOcbhXwYM13Vx8qYFqhzFl5pD40NJtTJKZnVdGTMLRJtwYSVggSw1UICBdheP+N+PLoQet7Uvgc4NELGXkH+KCV75SfkB16XDHpgW7/MqIQXar5ULhdUXVGKYhEVcBFT/6v0BZCVuQfjABQFeCY0VqxBXd2xbbxJVFZoyI+dqOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTlnohQVwJRE7AWOokqfD1g5w9B0HEBZOweOXKLhEFs=;
 b=DXRMp1sBnF5v0rd75omOovzQoNbRlpO446Job2bEsvI2NFXcV5U9IseXoekLqOa5AfIyCp3Y5pxpFKFz1S3Fvw5LXU2SuyA7NvDtEgnwY0h/+oxWxS77LO04sCiP+X6M8mSr+xVG7mEBbNWYCAJl54CX8KFMgukIERxLJ1OW9C7moJLmQB/W+5qMnQ8zHwMPWZxQnueUTAZpAuM5MnQjXyEE0SMEBPwoI8km+6RNo5mVDfXWWbffGB9Tb9QHkbiwITlFyPA1YEfPuFk12Bltz9fmLrQ1g//RqsVFQLAKv33FA4UhsVUuRaMbJin5AUlAQrE9YmoLdJ7c8pSZqqEQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTlnohQVwJRE7AWOokqfD1g5w9B0HEBZOweOXKLhEFs=;
 b=oTjlAY494Q3/FuM69kJdaq+C45/xlVCXgvsW8oaua/yvgG0KHFFQ8psN9cGeqrpfMq7tcP3jIc0nn7zuY5dZfCzCi6eYbNuJzF/Ze64j4mjyVQGu/PfRb1WT0T91LYqOtvHLsHuk2sEV/ar+LOWi53ZTEQdzmu6nBIKTGbOha82qaMAe7nFLnsVZTy0xAcgx89gR6CYkL3Th9Ma/gwg+ieYC1OBCfIhv606Ho/SnVnYQ+6JKVL4ZclwA8AEhYCpAlgHd9ScShCzC8X45QNad00tYyzaqtHSKr5IyTjkMqZPOhBy30myOFV8lxlWglIcD2YUPx6bngWycdIgg4Hf78A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by VI1PR10MB1903.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:2e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 15:48:55 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a852:a1:7888:f20f]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a852:a1:7888:f20f%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 15:48:55 +0000
Date:   Wed, 11 May 2022 17:48:52 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH v2 4/4] leds: simatic-ipc-leds-gpio: add GPIO version of
 Siemens driver
Message-ID: <20220511174852.5a22816d@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220511153905.13980-5-henning.schild@siemens.com>
References: <20220511153905.13980-1-henning.schild@siemens.com>
        <20220511153905.13980-5-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0500.eurprd06.prod.outlook.com
 (2603:10a6:20b:49b::25) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d85bf91b-e7e3-4503-202b-08da3365c11d
X-MS-TrafficTypeDiagnostic: VI1PR10MB1903:EE_
X-Microsoft-Antispam-PRVS: <VI1PR10MB1903ACBC10A63D6CCF900F7485C89@VI1PR10MB1903.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VqtK5yQTEY/rcKZ8p7sncTbjFr9syFCGFo9+Xxl3KT/O0QnHM4MIiuELTwQf5i0/ahspphYLbWUHhRY0V4Jve+8SHPZon0PblKoapsd9lv94sVVozeFg4KCZygLEyqHaoGtYkE9l2Eo+Exzk5K8t9hC3jEMryVkqS3Zyd3D6suhSXFWjgeWYgDtLagwJVyn4AatNoQHlE801nJaLUueFWNTRWotB3iHn0Sy6C27TNbS1rPt6Nv0/Q3vL76N9T1UwJrEtCyhd/BCztoq+hTl9qs3fKyLzLHGuWBfTZj7tGtbNRyXyst6is7FGhkSqsLZiJPVlARsMuiuRuUY45IgBK6WxLPH4Zt5340ZelQxtVmkaUhGfJXT/nzPGqkAppmrfTfLqiepQuDVIZRVvRS0j6Af+Ao98oxLtV5tpYE8npTXudUWXiDfiHTC1jQy1zL55EIIVcyVA/YKWqQDeaXHYaJq3Z+zHBX8IznOkSA8Ite/X6aNUbJAzGONH6rfHds4Syzg2QOKhcfOArDmOilniEuze1vt0N5pTxn0Bjtw0/yE1a8+bxjBhAocJTYU7OVgSC2Uted6Exla1MygvcxIkl2UMCRA0j9NGF9L+mu0WYaT56cuzYPUqN71JrS+XiRgGg6CW6xDrcnRk8+rnJuSzxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(6506007)(38100700002)(6916009)(82960400001)(9686003)(30864003)(6512007)(44832011)(26005)(5660300002)(2906002)(508600001)(86362001)(6486002)(316002)(8936002)(107886003)(1076003)(54906003)(4326008)(186003)(8676002)(83380400001)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n6nsFMTWdtGvr9/7i4slaBGxJq9XD3yROIl/tjocBYDX/13qiI336eeXZpxm?=
 =?us-ascii?Q?Hzhu864vMlCMCpha2bLszGgWJP2m2VHfCDNJIPJd7qotqDs/40Wg7WDy6vqW?=
 =?us-ascii?Q?ZAhbmCxMWiBbKS4iwqElxEDBDqjy3hxG6c5YiesrpAIViVRCD9fj1iEoqcDI?=
 =?us-ascii?Q?qi1COejf+ImdPDKnxCkgNS2qSTAbwf/48laJvIdoEmeegxiMFrxCPNR5Q5NG?=
 =?us-ascii?Q?wubZeuHq1PTn3c+YBKZkPOpOMXgSPg+IqeaaTauxMcFAjDWmNjgFxrr8iJFF?=
 =?us-ascii?Q?FukAIoVu6Gpd2vll/M7FSoc4wwK6aMSy/7O7lXxYo8nw+ahziWqyYM5XyOpF?=
 =?us-ascii?Q?J6NflNNDXCThxghK8glRQ1ga6dL4O5hX9KUPY0W+12WFIHTBK9idL40Muiqv?=
 =?us-ascii?Q?AnbiPZLos+evVNjE66SoSZDbp1FRrT2i+Z3p0W4G6Wc2T/rj7IEGeXTCEH09?=
 =?us-ascii?Q?YtOhU3bNDBceD3Mo6mqzFDFeznTQfZhFbl98ViEmeQ11sP9jSS05r51+W/I+?=
 =?us-ascii?Q?8P8YyE5zgMUzISnvtkVWZT005zf/j0FYjIolUXQcXqql68F904aw7iL8fBGW?=
 =?us-ascii?Q?M+V/gn8AtpjfHZY8PmiXeakBeYnR0q+U6149srNOzsg1bGgFCb/CD6eFMyft?=
 =?us-ascii?Q?43OCXwvgcybdbUnVBgouUEyf5rJSyawyT/mkoH0GNFjPrt8+j/gypeTov/O+?=
 =?us-ascii?Q?A/nxslwIf5SAsqs4Y162v//YXml7vfG52Ie2Z0etDovPoNxf9VFHqXp9qShC?=
 =?us-ascii?Q?t7wNcvcBKQm5RiQYw/4UoWCRizAy8RSgv7c0DECQPz46lDy2ptXzFnBxAb6V?=
 =?us-ascii?Q?4P2Rw6KXK8wiqZgA/eIGHv6BdGySO7lbyY+lJgrY06o0amVS2ECRSfaSFw05?=
 =?us-ascii?Q?rDPVcA7jl93xuM1VV5RIMa9E/Gkq09KNI1aFg6l88ng3tvc9cUZdZlWYXfp9?=
 =?us-ascii?Q?f7gTCxOlGXZEZJ/qEKX8xj9xNBuBcNwvSvxw9qgZE2MsDlX4YbbzV8FaFJgN?=
 =?us-ascii?Q?ZxdftJpeINgbqEUmv28wsuNddg1eHtQKKUDiikao7HVa8nmNsXkCmI1fWSeA?=
 =?us-ascii?Q?jW6p49B6zTJk/Uank3nkmDnwFCTlVsHCJg3CpcsL4PJb6yqZyMFnIq5d/op5?=
 =?us-ascii?Q?VZ1lYQHaiVH/kmZ8rTRbtZvMd5D4Q1baF1rDwizFmlqfudNfZLc16aOBdLL6?=
 =?us-ascii?Q?geFVYgLRw0mytf04J/KJBpzquMmaMoPJSMhS5PiI+lFXQrMxdYYxOqLotZBl?=
 =?us-ascii?Q?vNEg3FJGJMHiaV7/k2GHWqJGW7k7oh71GUC6eLaxOboSKNoGZPEjbjCJjeYA?=
 =?us-ascii?Q?1BSL9mxqtkVge78F0GLBMdCZS2HhLmpznLPyYAtpw1j/s07d8dNV4XJaMKD0?=
 =?us-ascii?Q?4PmebdllrrP29z18TQcMVPKELQo5PuA+IXFAF6YmAWMg04UPurbOL5hfPhfM?=
 =?us-ascii?Q?D/wQ7RMLieCcloofZCqKzyHZtlF0czpLAE1sT3JWzuoDiLc9WI34pzAqOHOt?=
 =?us-ascii?Q?NT57Lc2Lum09JG3sFN5fqkFYEZPaaUUvvuhr7F4eqCps9BWmQyyaMuC3VyBI?=
 =?us-ascii?Q?kMq75h/r7PErw0404Z+ZAEGyuUG7AMmB7WRjFfwqQP+EMceaDboUfAGA4d2D?=
 =?us-ascii?Q?FUOV+TZ0/PAsBI8HUa29IJFaoyv6/nPGha15ofZytoHYj2LU2Mh1E0T4m+c9?=
 =?us-ascii?Q?ogvrkZ3/F7tvP/pCcaFsKhn+mYoMZWmoqKCKryIDXDap5S0Erh1YuP8U4X0a?=
 =?us-ascii?Q?3s3H7VwqjC8zABY4v7ljOVDu67uiJ1PCcmrSKZo3XJSRLcbaONNW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85bf91b-e7e3-4503-202b-08da3365c11d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 15:48:55.2190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LogY5JfjXrKfhU1OAvOiga8aniesCx+Xjsq/gFRJsvavumMde4q9gW9DBjviYcDBpmmhnEABG1MDsUi5wstV9CdRDCVW92J11YI8+spkNqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1903
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 11 May 2022 17:39:05 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> On Apollo Lake the pinctrl drivers will now come up without ACPI. Use
> that instead of open coding it.
> Create a new driver for that which can later be filled with more GPIO
> based models, and which has different dependencies.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/leds/simple/Kconfig                 |  12 ++-
>  drivers/leds/simple/Makefile                |   3 +-
>  drivers/leds/simple/simatic-ipc-leds-gpio.c | 108
> ++++++++++++++++++++ drivers/leds/simple/simatic-ipc-leds.c      |
> 80 +-------------- drivers/platform/x86/simatic-ipc.c          |   5
> +- 5 files changed, 129 insertions(+), 79 deletions(-)
>  create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
> 
> diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
> index 9293e6b36c75..9d2487908743 100644
> --- a/drivers/leds/simple/Kconfig
> +++ b/drivers/leds/simple/Kconfig
> @@ -3,10 +3,20 @@ config LEDS_SIEMENS_SIMATIC_IPC
>  	tristate "LED driver for Siemens Simatic IPCs"
>  	depends on LEDS_CLASS
>  	depends on SIEMENS_SIMATIC_IPC
> -	select P2SB if X86
>  	help
>  	  This option enables support for the LEDs of several
> Industrial PCs from Siemens.
>  
>  	  To compile this driver as a module, choose M here: the
> module will be called simatic-ipc-leds.
> +
> +config LEDS_SIEMENS_SIMATIC_IPC_GPIO
> +	tristate "LED driver for Siemens Simatic IPCs, GPIO based"
> +	depends on SIEMENS_SIMATIC_IPC
> +	depends on LEDS_GPIO
> +	help
> +	  This option enables support for the LEDs of several
> Industrial PCs
> +	  from Siemens.
> +
> +	  To compile this driver as a module, choose M here: the
> module
> +	  will be called simatic-ipc-leds-gpio.
> diff --git a/drivers/leds/simple/Makefile
> b/drivers/leds/simple/Makefile index 8481f1e9e360..e1df74fb5915 100644
> --- a/drivers/leds/simple/Makefile
> +++ b/drivers/leds/simple/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds.o
> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)		+=
> simatic-ipc-leds.o
> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_GPIO)	+=
> simatic-ipc-leds-gpio.o diff --git
> a/drivers/leds/simple/simatic-ipc-leds-gpio.c
> b/drivers/leds/simple/simatic-ipc-leds-gpio.c new file mode 100644
> index 000000000000..552b65a72e04 --- /dev/null +++
> b/drivers/leds/simple/simatic-ipc-leds-gpio.c @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Siemens SIMATIC IPC driver for GPIO based LEDs
> + *
> + * Copyright (c) Siemens AG, 2022
> + *
> + * Authors:
> + *  Henning Schild <henning.schild@siemens.com>
> + */
> +
> +#include <linux/gpio/machine.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
> +	.dev_id = "leds-gpio",
> +	.table = {
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 0,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 1,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 2,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 3,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 4,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 5,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7,
> GPIO_ACTIVE_HIGH),
> +	}

One thing i found is that rmmod will turn those LEDs off. Not sure how
relevant that is and if someone would ever unload the driver. But i
kind of think the driver should not change the last state of the LEDs,
not on init nor on exit. If there is a way to make that happen i would
probably try and add that.

I guess i might have to look into LED_RETAIN_AT_SHUTDOWN and/or
LED_CORE_SUSPENDRESUME.

A thing to maybe do in the next round, or on top if these patches get
merged. At least the prior implementation, not based on GPIO did
"retain".

regards,
Henning

> +};
> +
> +static const struct gpio_led simatic_ipc_gpio_leds[] = {
> +	{ .name = "green:" LED_FUNCTION_STATUS "-3" },
> +	{ .name = "red:" LED_FUNCTION_STATUS "-1" },
> +	{ .name = "green:" LED_FUNCTION_STATUS "-1" },
> +	{ .name = "red:" LED_FUNCTION_STATUS "-2" },
> +	{ .name = "green:" LED_FUNCTION_STATUS "-2" },
> +	{ .name = "red:" LED_FUNCTION_STATUS "-3" },
> +};
> +
> +static const struct gpio_led_platform_data
> simatic_ipc_gpio_leds_pdata = {
> +	.num_leds	= ARRAY_SIZE(simatic_ipc_gpio_leds),
> +	.leds		= simatic_ipc_gpio_leds,
> +};
> +
> +static struct platform_device *simatic_leds_pdev;
> +
> +static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
> +{
> +	gpiod_remove_lookup_table(&simatic_ipc_led_gpio_table);
> +	platform_device_unregister(simatic_leds_pdev);
> +
> +	return 0;
> +}
> +
> +static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
> +{
> +	struct gpio_desc *gpiod;
> +	int err;
> +
> +	gpiod_add_lookup_table(&simatic_ipc_led_gpio_table);
> +	simatic_leds_pdev = platform_device_register_resndata(NULL,
> +		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
> +		&simatic_ipc_gpio_leds_pdata,
> +		sizeof(simatic_ipc_gpio_leds_pdata));
> +	if (IS_ERR(simatic_leds_pdev)) {
> +		err = PTR_ERR(simatic_leds_pdev);
> +		goto out;
> +	}
> +
> +	/* PM_BIOS_BOOT_N */
> +	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 6, 0);
> +	if (IS_ERR(gpiod)) {
> +		err = PTR_ERR(gpiod);
> +		goto out;
> +	}
> +	gpiod_set_value(gpiod, 0);
> +	gpiod_put(gpiod);
> +
> +	/* PM_WDT_OUT */
> +	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 7, 0);
> +	if (IS_ERR(gpiod)) {
> +		err = PTR_ERR(gpiod);
> +		goto out;
> +	}
> +	gpiod_set_value(gpiod, 0);
> +	gpiod_put(gpiod);
> +
> +	return 0;
> +out:
> +	simatic_ipc_leds_gpio_remove(pdev);
> +
> +	return err;
> +}
> +
> +static struct platform_driver simatic_ipc_led_gpio_driver = {
> +	.probe = simatic_ipc_leds_gpio_probe,
> +	.remove = simatic_ipc_leds_gpio_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +	}
> +};
> +
> +module_platform_driver(simatic_ipc_led_gpio_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" KBUILD_MODNAME);
> +MODULE_SOFTDEP("pre: platform:leds-gpio");
> +MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
> diff --git a/drivers/leds/simple/simatic-ipc-leds.c
> b/drivers/leds/simple/simatic-ipc-leds.c index
> 2e7597c143d8..4894c228c165 100644 ---
> a/drivers/leds/simple/simatic-ipc-leds.c +++
> b/drivers/leds/simple/simatic-ipc-leds.c @@ -15,7 +15,6 @@
>  #include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> -#include <linux/platform_data/x86/p2sb.h>
>  #include <linux/platform_data/x86/simatic-ipc-base.h>
>  #include <linux/platform_device.h>
>  #include <linux/sizes.h>
> @@ -24,7 +23,7 @@
>  #define SIMATIC_IPC_LED_PORT_BASE	0x404E
>  
>  struct simatic_ipc_led {
> -	unsigned int value; /* mask for io and offset for mem */
> +	unsigned int value; /* mask for io */
>  	char *name;
>  	struct led_classdev cdev;
>  };
> @@ -39,21 +38,6 @@ static struct simatic_ipc_led
> simatic_ipc_leds_io[] = { { }
>  };
>  
> -/* the actual start will be discovered with p2sb, 0 is a placeholder
> */ -static struct resource simatic_ipc_led_mem_res =
> DEFINE_RES_MEM_NAMED(0, 0, KBUILD_MODNAME); -
> -static void __iomem *simatic_ipc_led_memory;
> -
> -static struct simatic_ipc_led simatic_ipc_leds_mem[] = {
> -	{0x500 + 0x1A0, "red:" LED_FUNCTION_STATUS "-1"},
> -	{0x500 + 0x1A8, "green:" LED_FUNCTION_STATUS "-1"},
> -	{0x500 + 0x1C8, "red:" LED_FUNCTION_STATUS "-2"},
> -	{0x500 + 0x1D0, "green:" LED_FUNCTION_STATUS "-2"},
> -	{0x500 + 0x1E0, "red:" LED_FUNCTION_STATUS "-3"},
> -	{0x500 + 0x198, "green:" LED_FUNCTION_STATUS "-3"},
> -	{ }
> -};
> -
>  static struct resource simatic_ipc_led_io_res =
>  	DEFINE_RES_IO_NAMED(SIMATIC_IPC_LED_PORT_BASE, SZ_2,
> KBUILD_MODNAME); 
> @@ -89,28 +73,6 @@ static enum led_brightness
> simatic_ipc_led_get_io(struct led_classdev *led_cd) return
> inw(SIMATIC_IPC_LED_PORT_BASE) & led->value ? LED_OFF :
> led_cd->max_brightness; } 
> -static void simatic_ipc_led_set_mem(struct led_classdev *led_cd,
> -				    enum led_brightness brightness)
> -{
> -	struct simatic_ipc_led *led = cdev_to_led(led_cd);
> -	void __iomem *reg = simatic_ipc_led_memory + led->value;
> -	u32 val;
> -
> -	val = readl(reg);
> -	val = (val & ~1) | (brightness == LED_OFF);
> -	writel(val, reg);
> -}
> -
> -static enum led_brightness simatic_ipc_led_get_mem(struct
> led_classdev *led_cd) -{
> -	struct simatic_ipc_led *led = cdev_to_led(led_cd);
> -	void __iomem *reg = simatic_ipc_led_memory + led->value;
> -	u32 val;
> -
> -	val = readl(reg);
> -	return (val & 1) ? LED_OFF : led_cd->max_brightness;
> -}
> -
>  static int simatic_ipc_leds_probe(struct platform_device *pdev)
>  {
>  	const struct simatic_ipc_platform *plat =
> pdev->dev.platform_data; @@ -118,9 +80,7 @@ static int
> simatic_ipc_leds_probe(struct platform_device *pdev) struct
> simatic_ipc_led *ipcled; struct led_classdev *cdev;
>  	struct resource *res;
> -	void __iomem *reg;
> -	int err, type;
> -	u32 val;
> +	int err;
>  
>  	switch (plat->devmode) {
>  	case SIMATIC_IPC_DEVICE_227D:
> @@ -135,51 +95,19 @@ static int simatic_ipc_leds_probe(struct
> platform_device *pdev) }
>  			ipcled = simatic_ipc_leds_io;
>  		}
> -		type = IORESOURCE_IO;
>  		if (!devm_request_region(dev, res->start,
> resource_size(res), KBUILD_MODNAME)) { dev_err(dev, "Unable to
> register IO resource at %pR\n", res); return -EBUSY;
>  		}
>  		break;
> -	case SIMATIC_IPC_DEVICE_127E:
> -		res = &simatic_ipc_led_mem_res;
> -		ipcled = simatic_ipc_leds_mem;
> -		type = IORESOURCE_MEM;
> -
> -		err = p2sb_bar(NULL, 0, res);
> -		if (err)
> -			return err;
> -
> -		/* do the final address calculation */
> -		res->start = res->start + (0xC5 << 16);
> -		res->end = res->start + SZ_4K - 1;
> -
> -		simatic_ipc_led_memory = devm_ioremap_resource(dev,
> res);
> -		if (IS_ERR(simatic_ipc_led_memory))
> -			return PTR_ERR(simatic_ipc_led_memory);
> -
> -		/* initialize power/watchdog LED */
> -		reg = simatic_ipc_led_memory + 0x500 + 0x1D8; /*
> PM_WDT_OUT */
> -		val = readl(reg);
> -		writel(val & ~1, reg);
> -
> -		reg = simatic_ipc_led_memory + 0x500 + 0x1C0; /*
> PM_BIOS_BOOT_N */
> -		val = readl(reg);
> -		writel(val | 1, reg);
> -		break;
>  	default:
>  		return -ENODEV;
>  	}
>  
>  	while (ipcled->value) {
>  		cdev = &ipcled->cdev;
> -		if (type == IORESOURCE_MEM) {
> -			cdev->brightness_set =
> simatic_ipc_led_set_mem;
> -			cdev->brightness_get =
> simatic_ipc_led_get_mem;
> -		} else {
> -			cdev->brightness_set =
> simatic_ipc_led_set_io;
> -			cdev->brightness_get =
> simatic_ipc_led_get_io;
> -		}
> +		cdev->brightness_set = simatic_ipc_led_set_io;
> +		cdev->brightness_get = simatic_ipc_led_get_io;
>  		cdev->max_brightness = LED_ON;
>  		cdev->name = ipcled->name;
>  
> diff --git a/drivers/platform/x86/simatic-ipc.c
> b/drivers/platform/x86/simatic-ipc.c index 26c35e1660cb..ca3647b751d5
> 100644 --- a/drivers/platform/x86/simatic-ipc.c
> +++ b/drivers/platform/x86/simatic-ipc.c
> @@ -51,6 +51,7 @@ static int register_platform_devices(u32 station_id)
>  {
>  	u8 ledmode = SIMATIC_IPC_DEVICE_NONE;
>  	u8 wdtmode = SIMATIC_IPC_DEVICE_NONE;
> +	char *pdevname = KBUILD_MODNAME "_leds";
>  	int i;
>  
>  	platform_data.devmode = SIMATIC_IPC_DEVICE_NONE;
> @@ -64,10 +65,12 @@ static int register_platform_devices(u32
> station_id) }
>  
>  	if (ledmode != SIMATIC_IPC_DEVICE_NONE) {
> +		if (ledmode == SIMATIC_IPC_DEVICE_127E)
> +			pdevname = KBUILD_MODNAME "_leds_gpio";
>  		platform_data.devmode = ledmode;
>  		ipc_led_platform_device =
>  			platform_device_register_data(NULL,
> -				KBUILD_MODNAME "_leds",
> PLATFORM_DEVID_NONE,
> +				pdevname, PLATFORM_DEVID_NONE,
>  				&platform_data,
>  				sizeof(struct simatic_ipc_platform));
>  		if (IS_ERR(ipc_led_platform_device))

