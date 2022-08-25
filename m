Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8C5A1805
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242476AbiHYRdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbiHYRdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:33:49 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECFBB72A6;
        Thu, 25 Aug 2022 10:33:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oR+FnzheiXFSlRj2TQ3vJX0WuWZ83ae5gKxZ3Wh8Rsufj2xS7MM7IhRRfbULXuvYC5hUnIqKUOh7hTSyF/REsECfnwqGZEGXAgjQS2vK+WAdSFjuSpYHnaDCIZkslaA3yXZIjAXRD28jcor4Uy6RoLjVfyYIwYcHC8yAe2mgAE+Kz7aKNeyKMiLEv0UPbATc21fUtTH33JTpZWfUqHw4y9QcrBhFxEQXnqgyr/VpPY4TMfq54BCckFEsZvMcEsEiNz8RMassrXcsVmW/aha5Jja34QqCCNPe3122jjDY+8tAxOF5AZczOoxEXpLWVHEvs/Ixbw4R+FpWK5oAz7g6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zgx6Rf+b7lOzXCtm5COLsvT7XnUdTpeTn0367c7oMLA=;
 b=Wyp6fsI1y/GtpNV6b+gXlHG4wvIla+PMptsXbeut2VUoxWI7MlYg8qphQbkpFnB4PbVu3gf2XAZCqKwbx8mjEfpDr+so2/LBvmxT9SqLSrkI//ZRpOuCO5Bbw8L378wg0d8Iq97IT23b58PlBO5xG3LGBB7PHye+Yr8J8SNOCzDefUlHnUNMlhzDyUavMRW2IeOnnAVRVsG9/ofCLdcXkuY4X4zjWeWNHuviF9Zyq1ZqIYAGfJ/gKhNKFGF65+lx3cv6rHsC7o7UMiPK8NcqGT6HisfAePpgjXYHt6KiHdmQNIsjJ6Pk9/fbOIdc+YpMd6m7LjjsiN290yu9xNoW3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zgx6Rf+b7lOzXCtm5COLsvT7XnUdTpeTn0367c7oMLA=;
 b=Ct45ZfmKSc5L1mxeubOkljdfyrvgXDG7KFV/MnYM4+fP7jPUScDKncWElwKamwY2+aHxIX6fHj9sNdnzH2WPikPaXx2Gs5AP/U7wGiOLmq+saGB5HFT/yxSTPWPhoQy/3IleJVbwSlWiPHkmlo3M94ChgJZZynune5QJPdH38E5GHId8ImEj6Mbme5V+CQwcdwWpXCYgJt6v4Ytsj0PZCAMvXymmN4xvhbAqJ68sX8LWGT3tatNUV3uUTEZlqNivZT0hZDzhML+296hbR6GwzTzjSrPQqW6IF+eqPJMBqsRXy4qPzdosvgp5bgsLVzMoCFpGz063qVv5p560cQU8rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AM4PR1001MB1427.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:200:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Thu, 25 Aug
 2022 17:33:45 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 17:33:44 +0000
Date:   Thu, 25 Aug 2022 19:33:40 +0200
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
Subject: Re: [PATCH v6 5/7] leds: simatic-ipc-leds-gpio: add new model 227G
Message-ID: <20220825193340.058fd4c5@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220825104422.14156-6-henning.schild@siemens.com>
References: <20220825104422.14156-1-henning.schild@siemens.com>
        <20220825104422.14156-6-henning.schild@siemens.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR08CA0037.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::25) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80b5d40e-42c4-44ae-0728-08da86bff5cc
X-MS-TrafficTypeDiagnostic: AM4PR1001MB1427:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YvAB/h5u0eLMDEUXZtyhvAP2csuHk4ni0vQZxLa3s96urclSgwANLRk/J7+tzpYFCe0dI7AnCTPxJvohg5W0dcylqat3siBx7pRZ4+XZjnPN3OK/7CjF9L9qNE/etM9sVGB/hncGf3Io1DdEyEUca0b7BzBAtMFVvQHWB36jRtsjnvUraKwsiUM30GyiytAoWRm1UOcHo9k34TefOe3k90Z36iA0AALQ/KkDYOgfVZcCyEGukVnCuJyuGeKntgAod6Xmw/xh5Yz6cC0hfNi7b+3wG9bl/sTkL/rLB/BiSg0LKPlSlhamFJ0YaGLRyJt6oiW3mm4ZhaUcCBBEReGVH4fxrlIzKSerAv+X550RRYnfbqwNx/4r4LhtHDQQEHP+kHY1mndXxXihOEUe048r+Q+JS7CwUlgh8pCugQOYmsr6pXERAvA518vhoBdFM3QjsduIRC5OwTVuMYzJxrQNzN4nHJ80TpOmgM4tPnqSiPDbBOD+dOlRhto9FCN83ODbS6jBwOfAkwL0HY+zgDR7odXiM5eYayayoyJ1YxY3ND6MU/NdmHQl70/DDk8eQOkTb01iwJOZwD5PBOAqa35N/1AheS5CKK9TnCUAK6cLeOu/ScTB0IKjS/459ilceZpVeHkMZMbOzsqTaVejQpARO7Lr8cuAoQGBTdYWlc1FSqIfKVeQBssYRHeFZ/V7H1Htm/M759Tj7mSAKt+wt4CwfMUJwhmFf1tf1mhbswPQzbPOf0H3OtUtbWWZLFEvU64t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(82960400001)(4326008)(66476007)(54906003)(86362001)(66556008)(110136005)(921005)(8676002)(316002)(66946007)(6486002)(1076003)(83380400001)(478600001)(186003)(38100700002)(6512007)(9686003)(6506007)(2906002)(41300700001)(7416002)(44832011)(5660300002)(8936002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SN0zhrxZCR0q7XPjiu8AgTNygHkHiGokniJ7XSj3DuatehxCZilbPvAN+Pm9?=
 =?us-ascii?Q?DysFZr5aAOTzeUoTJHbQSAD07ThOY+f0wa/9IHkMNvsjU12Civxh77dBoBTQ?=
 =?us-ascii?Q?PxNhAyOifK2lRSmTK6FphcilFPA8Yo2x6bthf6+vO9BlfxW1+unDRqWl52fp?=
 =?us-ascii?Q?AVplxvxa02nEpn9EuOx5vauK2L7dY5WlLmKqJmuDXkydx05TIdmk83LzXDJj?=
 =?us-ascii?Q?FAhxtfy9us9isSDz6aGQnRp1i3QKVJhrgKmWh/QP+obDroUflClG/Cn8WYo/?=
 =?us-ascii?Q?xpRpjLUnmUyYo9+dSc/FOBkl3EOnHU45xSPNeMLsEJbVXDf9aGOh8GplvkSX?=
 =?us-ascii?Q?69pZsKmzhCsUm6LivSLedwDMgfpSFioOFkh2qLQ+mL1T6U5a+d3cgM+I81BI?=
 =?us-ascii?Q?OOepotOpTxM1kZcp1KJNpxvx876N+fmBsDq93N8zeaV+YrCrHL4Q9GS6MGw5?=
 =?us-ascii?Q?DpyOw2Mamrxp7XQazDH+bSDnsCsERGEiaZiEO/PLsyAIPGeFdVKc2dcGtztw?=
 =?us-ascii?Q?0DSoY4T2iGpvIRXGs95YNWYZavXXdYtw47EldzUUh4xO9nDFU2eZAWGxqgi2?=
 =?us-ascii?Q?XQUOoYI4KO5M50GEBCOlZsFpeRxepMGJ1rNzombzfvyYjKwwYRdijXogzm0l?=
 =?us-ascii?Q?bIyyU9WXjMF5d3brQOl40LCZqkakDw5z+3oCBRnqyJRHbWURglKNicBqNMyg?=
 =?us-ascii?Q?1tDlWiKTs5S5b1OWLo6DKVDyc5b3gP78C9vKsgFNKRGfZ/8I0A59tyySsgOE?=
 =?us-ascii?Q?8u2tG4TBqFcQAD0CQS0+y5foLfZKeCv+euhw+IdZ29hfxUNX5Og3a+nj8g9g?=
 =?us-ascii?Q?XkLhOCAovFKSXdUckcMNfRhaocrnTnrI8mufsEYbCl3J38+56FhBJ7FhgSzW?=
 =?us-ascii?Q?XXEsJVnfH5iUx9GZeP434OxWmSP6ErzIAhgtIWhTA4tgye64qdrMRo46OA9L?=
 =?us-ascii?Q?mnKp7SWz5zGblBfrzaxzKt2IfenGBFWRvlGmGe4pi5TFF5Bcgpae9mn24kTR?=
 =?us-ascii?Q?DUbp4DnWGZM/6lwaSRGty4uNjPj+3xEhuTzQv2PVZuvi02x5lVsFfGmLvHcf?=
 =?us-ascii?Q?kAiUyqqjnETgL44zkCJ4ij3MtfjfXqKcbyNGviZSam1hoyrFhnNC1p4+Emxw?=
 =?us-ascii?Q?GQ2ZRchboyBgZLLP1X0aKWWIpJKFf3+3X3ZwjHqVcMMq70zhfJDV3BggpZ3p?=
 =?us-ascii?Q?07wOcgFQLJeVt5/IcrCMzirCcAVfJXFhRsVV0C15WoZDoUbYOKAlCpa8eRY6?=
 =?us-ascii?Q?b2rTmyUWfKFyKQ63kqTBtRukz/Csqo87ayHNhWo1Ncix/F3FXwLuhmYOipOh?=
 =?us-ascii?Q?hmEAR2+4nCiL9XGBG60CTbWCBbjxNK05rLpg6sTiJWEeyLAPr/74GzXrxlBs?=
 =?us-ascii?Q?kDhnvUcocUtYqFk2qitLHuZmgUl9uumRFkIKmrG+xRYmuQaE/6dLjP+AmkYE?=
 =?us-ascii?Q?xEiVvCf4FpQgrpAu5wnl6dV3KOYi/mfQNi939LRj0f73EMpErq1pJTDqLND4?=
 =?us-ascii?Q?9habMvqPUVliB/WGK5DgperTTT4vFTDNJCyiuxIl1im5WLIIHI+WKCF678A8?=
 =?us-ascii?Q?wl0ZdE9JouMzlfdwUfDKWUHR9KtpD2d9dkPRlItsbsX+Z/M49LcD2wNZRy2r?=
 =?us-ascii?Q?3kG4NCtTX6mgQph8h5ubkN1YwyatH2YsHGRFHopkL8ylZmkPLSbXH/2UmDjZ?=
 =?us-ascii?Q?01JeXw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b5d40e-42c4-44ae-0728-08da86bff5cc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 17:33:44.8730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5e+0aqI1MhGkxJf2D41IEcx+WMQvsQ/V1oGSAJKVmSmQGxDyXEz0vrIuhQK+j6CmZvkj+CDhEAGXfDIFt+nmRfaosSYXz/g23fO8e1mE/lI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR1001MB1427
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 25 Aug 2022 12:44:20 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> This adds support of the Siemens Simatic IPC227G. Its LEDs are
> connected to GPIO pins provided by the gpio-f7188x module. We make
> sure that gets loaded, if not enabled in the kernel config no LED
> support will be available.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/leds/simple/simatic-ipc-leds-gpio.c   | 42
> ++++++++++++++++--- drivers/platform/x86/simatic-ipc.c            |
> 4 +- .../platform_data/x86/simatic-ipc-base.h      |  1 +
>  include/linux/platform_data/x86/simatic-ipc.h |  1 +
>  4 files changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c
> b/drivers/leds/simple/simatic-ipc-leds-gpio.c index
> 4c9e663a90ba..0d73dcbeec2d 100644 ---
> a/drivers/leds/simple/simatic-ipc-leds-gpio.c +++
> b/drivers/leds/simple/simatic-ipc-leds-gpio.c @@ -13,28 +13,45 @@
>  #include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/platform_data/x86/simatic-ipc-base.h>
>  
> -static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
> +struct gpiod_lookup_table *simatic_ipc_led_gpio_table;
> +
> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
>  	.dev_id = "leds-gpio",
>  	.table = {
> -		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 0,
> GPIO_ACTIVE_LOW), GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL,
> 1, GPIO_ACTIVE_LOW), GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53,
> NULL, 2, GPIO_ACTIVE_LOW), GPIO_LOOKUP_IDX("apollolake-pinctrl.0",
> 57, NULL, 3, GPIO_ACTIVE_LOW),
> GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 4,
> GPIO_ACTIVE_LOW), GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL,
> 5, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 0,
> GPIO_ACTIVE_LOW), GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL,
> 6, GPIO_ACTIVE_LOW), GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59,
> NULL, 7, GPIO_ACTIVE_HIGH), },
>  };
>  
> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
> +	.dev_id = "leds-gpio",
> +	.table = {
> +		GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-2", 1, NULL, 1,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-2", 2, NULL, 2,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 3,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-2", 4, NULL, 4,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6,
> GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7,
> GPIO_ACTIVE_HIGH),
> +	}
> +};
> +
>  static const struct gpio_led simatic_ipc_gpio_leds[] = {
> -	{ .name = "green:" LED_FUNCTION_STATUS "-3" },
>  	{ .name = "red:" LED_FUNCTION_STATUS "-1" },
>  	{ .name = "green:" LED_FUNCTION_STATUS "-1" },
>  	{ .name = "red:" LED_FUNCTION_STATUS "-2" },
>  	{ .name = "green:" LED_FUNCTION_STATUS "-2" },
>  	{ .name = "red:" LED_FUNCTION_STATUS "-3" },
> +	{ .name = "green:" LED_FUNCTION_STATUS "-3" },
>  };

Concerning these two tables from above i have a question i need to find
an answer for for maintaining the out-of-tree modules of these drivers.

When getting the drivers into the kernel i had to rename the leds but
in out-of-tree i would like to keep the old names and just equip their
setters/getters with a deprecation warning. Just to give existing
users time to slowly adopt the upstream name change if i can.

In the open-coded way i just defined each LED twice and added a strcmp
+ pr_warn. With the "leds-gpio" version i still fail to find a solution
which does not get me into -EBUSY. So i already fail at the second
definition of the legacy name, not even had a chance to think about how
to smuggle in my deprecation warning.

I know out-of-tree is not a concern to people here, but someone might
have an answer anyhow.

Thanks,
Henning

>  static const struct gpio_led_platform_data
> simatic_ipc_gpio_leds_pdata = { @@ -46,7 +63,7 @@ static struct
> platform_device *simatic_leds_pdev; 
>  static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
>  {
> -	gpiod_remove_lookup_table(&simatic_ipc_led_gpio_table);
> +	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table);
>  	platform_device_unregister(simatic_leds_pdev);
>  
>  	return 0;
> @@ -54,10 +71,25 @@ static int simatic_ipc_leds_gpio_remove(struct
> platform_device *pdev) 
>  static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
>  {
> +	const struct simatic_ipc_platform *plat =
> pdev->dev.platform_data; struct gpio_desc *gpiod;
>  	int err;
>  
> -	gpiod_add_lookup_table(&simatic_ipc_led_gpio_table);
> +	switch (plat->devmode) {
> +	case SIMATIC_IPC_DEVICE_127E:
> +		simatic_ipc_led_gpio_table =
> &simatic_ipc_led_gpio_table_127e;
> +		break;
> +	case SIMATIC_IPC_DEVICE_227G:
> +		if (!IS_ENABLED(CONFIG_GPIO_F7188X))
> +			return -ENODEV;
> +		request_module("gpio-f7188x");
> +		simatic_ipc_led_gpio_table =
> &simatic_ipc_led_gpio_table_227g;
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	gpiod_add_lookup_table(simatic_ipc_led_gpio_table);
>  	simatic_leds_pdev = platform_device_register_resndata(NULL,
>  		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
>  		&simatic_ipc_gpio_leds_pdata,
> diff --git a/drivers/platform/x86/simatic-ipc.c
> b/drivers/platform/x86/simatic-ipc.c index ca3647b751d5..1825ef21a86d
> 100644 --- a/drivers/platform/x86/simatic-ipc.c
> +++ b/drivers/platform/x86/simatic-ipc.c
> @@ -41,6 +41,7 @@ static struct {
>  	{SIMATIC_IPC_IPC127E, SIMATIC_IPC_DEVICE_127E,
> SIMATIC_IPC_DEVICE_NONE}, {SIMATIC_IPC_IPC227D,
> SIMATIC_IPC_DEVICE_227D, SIMATIC_IPC_DEVICE_NONE},
> {SIMATIC_IPC_IPC227E, SIMATIC_IPC_DEVICE_427E,
> SIMATIC_IPC_DEVICE_227E},
> +	{SIMATIC_IPC_IPC227G, SIMATIC_IPC_DEVICE_227G,
> SIMATIC_IPC_DEVICE_NONE}, {SIMATIC_IPC_IPC277E,
> SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E},
> {SIMATIC_IPC_IPC427D, SIMATIC_IPC_DEVICE_427E,
> SIMATIC_IPC_DEVICE_NONE}, {SIMATIC_IPC_IPC427E,
> SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_427E}, @@ -65,7 +66,8 @@
> static int register_platform_devices(u32 station_id) } 
>  	if (ledmode != SIMATIC_IPC_DEVICE_NONE) {
> -		if (ledmode == SIMATIC_IPC_DEVICE_127E)
> +		if (ledmode == SIMATIC_IPC_DEVICE_127E ||
> +		    ledmode == SIMATIC_IPC_DEVICE_227G)
>  			pdevname = KBUILD_MODNAME "_leds_gpio";
>  		platform_data.devmode = ledmode;
>  		ipc_led_platform_device =
> diff --git a/include/linux/platform_data/x86/simatic-ipc-base.h
> b/include/linux/platform_data/x86/simatic-ipc-base.h index
> 39fefd48cf4d..57d6a10dfc9e 100644 ---
> a/include/linux/platform_data/x86/simatic-ipc-base.h +++
> b/include/linux/platform_data/x86/simatic-ipc-base.h @@ -19,6 +19,7 @@
>  #define SIMATIC_IPC_DEVICE_427E 2
>  #define SIMATIC_IPC_DEVICE_127E 3
>  #define SIMATIC_IPC_DEVICE_227E 4
> +#define SIMATIC_IPC_DEVICE_227G 5
>  
>  struct simatic_ipc_platform {
>  	u8	devmode;
> diff --git a/include/linux/platform_data/x86/simatic-ipc.h
> b/include/linux/platform_data/x86/simatic-ipc.h index
> f3b76b39776b..7a2e79f3be0b 100644 ---
> a/include/linux/platform_data/x86/simatic-ipc.h +++
> b/include/linux/platform_data/x86/simatic-ipc.h @@ -31,6 +31,7 @@
> enum simatic_ipc_station_ids { SIMATIC_IPC_IPC427E = 0x00000A01,
>  	SIMATIC_IPC_IPC477E = 0x00000A02,
>  	SIMATIC_IPC_IPC127E = 0x00000D01,
> +	SIMATIC_IPC_IPC227G = 0x00000F01,
>  };
>  
>  static inline u32 simatic_ipc_get_station_id(u8 *data, int max_len)

