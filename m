Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93E8571ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiGLPTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiGLPSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:18:39 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F45ECC011;
        Tue, 12 Jul 2022 08:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZ/r0yrAEumprJ59VfNAAWtccMwAUw1hBcSR9e2rLLv0EiiCcZnbO5LpscrTR0DtoOYTIHkyVkOHHdU5iv6GIBNdophaOjF3sk5hOX2PBE8lDWUFdvo+IF3JklGENeCoxPt3v7DPwG1sWHYkZu3Cqwu5iOEYYBKa7OzLaxSng0AwXn6d1WMfAAexUL4alnsy/wIIzK9H3stWi0TY+jWO1iZuxk2GPpim9835FEhnk+a9JbdS3+8JcOZUS1rBhGB/v8ARiD6YFVNi6pamp48BX7DxwYwpxTdkB54C6CP+Ha8Ls8+FMMNyGR1QJdDUvsr/ml9Nf4SpypjxgA9+M5e3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX59+FaevlwgOHLWJjwEUGMiJUVxxjE/bcw4atfHsIE=;
 b=bbthH8zRL9Zac25xNO5oi8DkhKDPVxIZ5eae4Rj7S34CuHXwOvlY1AxQ4dKwe4MqUv9KIVx9aJcqQF9CjQDYWPPvtc7y/8B/jHsNzhKCjIDGLS/MqkIJK1cOVAVniBNcdIoMVOwWKkZ8ynhO1N9Ii8ZyvK6dXYqIh7royUgtQZhgWpPXDpi8wfMRO0U5IRHQrA9HNMAbTVvkR9DcohaUcYqFUeQhvBwHgGrD+eQQz3JJLLdSMZEdooC/HUNkwfdjsKXlbl7mLKvHpR4B0vOahnX7FDSgairAaFXtSGr8ljoaOwNKt9czgJE6Xs/YIzvOhXIKIIaEI3Ux0OMb6KVM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX59+FaevlwgOHLWJjwEUGMiJUVxxjE/bcw4atfHsIE=;
 b=QwEQN9OEe6lwZNLb7F6S/ek3r9nv3UH27VX7ku8gwTp2NGEN+0p09knjJDBt+P5xfK/k5O5igA37FPaUY1ikqhkNX4VUEZ4XM/GSBOmXcvqOMjQ3zBaggDh5rKSRSWvkVjCHh+ESLnSCwgHYrtjhtuc46EY23ST6K7TcTi8xKXPyTsVTsDGEaJhpx9KsF3nN/jUCdyY4k/escUuDU+vkcHcLIqEFydl/KF6f7ijfY7Pw2G7SDpwCWjuzaB7a40N2Qp23jCbGDztxF/LbmVcos+3i/EeK//zXCR+3nFut+B7gE9w21MmWNH8MdbWD4dHLQ76FBw1duHexxnRQb7zHXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ed::13)
 by DB9PR10MB5236.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 15:13:52 +0000
Received: from DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec0a:6162:dc81:efb9]) by DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec0a:6162:dc81:efb9%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 15:13:52 +0000
Date:   Tue, 12 Jul 2022 17:13:45 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
Cc:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 2/3] leds: simatic-ipc-leds-gpio: add new model 227G
Message-ID: <20220712171345.055122d3@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220712143237.13992-3-henning.schild@siemens.com>
References: <20220712143237.13992-1-henning.schild@siemens.com>
        <20220712143237.13992-3-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:610:b2::11) To DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2ed::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48b6f853-68ac-498f-84a4-08da64192179
X-MS-TrafficTypeDiagnostic: DB9PR10MB5236:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G52kBKS+ukrgSvfPjAP3wupXZLmYlcOKJr3JFlxuipRtxIi7YcpLLpxNw05QeG4s2Yx+eRVTIaZQXIEQ0kk2rJoe/9QNaz50uqNa49zyZs4G+b7eF4wtrjj5q9cRipiunZHwQuibZwfVkU36m2u/pJmvmAS02oGkc7ypv08AdZMr3zre2tUnR2Alaoz93Gft4eYrcMhgivIzHp4nf/im9XqTk5GOhyIv8grceyQit9AKVzF8EqCl2PuTzYa2l/BUVCDDBXzjYl1Fpat7/iE+YKSO/OWcYgNCpSyoLKu78QgHG7d+twAHYH1TZZonPF9hJPIIeUv61vBz7bzACQQbVqyqCsX/tr/hjJwkxdi7bN44BoNZ/ZZVwgkLWxFkkVsTjiT639ttjy5dsVkKdecQ9veJpnLL+9molLakH4qH21EhylOqnpeiJGgcB9MXgSARnDz+pfs5YMGE7UvQWH+TteA5vdVv1jZWvMYr+EaTCcpNF3vU4F6ceYUIDWQaXv5POR3z9O25S0DdUDpx8+m0Bc9k6t4Tk3wd4iDMKhWaKOMBe9TBPJZmv7P8shipjYQe/tjWzCGl+2uRzPeUmlGXKb6lGuf64pN+MyrrR8SRvOxlxCnGFEuTPeT0Gozcdqd03ilZ9Wj5yGiEzuURNq7PpMYLAEMzBhppq6qHoYPZqjbEwdAOhFoj+Uur4lcNe68H6fHU38KZ0nY80ezEgY8UbBIOBopEvQ5kDHa7Ew8J18R7ateDscsKsi1Kvf6x3QAifMN0dHIWjl+7J/m4ssKEXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(186003)(8676002)(66476007)(6486002)(66946007)(66556008)(6506007)(9686003)(110136005)(1076003)(26005)(6512007)(83380400001)(54906003)(41300700001)(82960400001)(4326008)(86362001)(8936002)(38100700002)(316002)(44832011)(2906002)(5660300002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?whRMpmgtqGyYl2zntS+uCz7dN8kMIiPXP05jPON7ZO+JXc4Z6hUbwJVX9qtH?=
 =?us-ascii?Q?85dQ0Qe1Mmday7J6Yquz9Wurt1f/RvnDOBwgB4QT3mcrKnoTzqOCSr/lIjup?=
 =?us-ascii?Q?C5pyu3Ba90N80wkjhuAcoIhCjBXNMAihrQAeDHKeOFfzq2iODwZ4QeMR44w6?=
 =?us-ascii?Q?/eeRGeZif0/YM46d2BRVny4mGNt2ojHfjpYSUfv5L2VXLM7GS8aicCR2Va3P?=
 =?us-ascii?Q?H21PWMdX9cuRgsQGvQochIYmdTgvvht9SyWt1q2A7BRmI7yL41AGK9Qn61MG?=
 =?us-ascii?Q?yaPI3sHokLpZQVATg5ra76YVbkXiin6fxSJfjPACgNE8u1oqUFAgjelKB/1Y?=
 =?us-ascii?Q?4ymDBvCwgf6huFCzuicTMeRI7I0MjXLYaN6f9iSIAwDw4KtlFFMtPcY4gDBi?=
 =?us-ascii?Q?B/XRdTyp1aAY2MGbvuUHhnTd4vCzW0Qzww8bFtMS3Kyn/DeYmCpnNrLOGqZa?=
 =?us-ascii?Q?/AFuKBE0hYW6uGPbrwe8iuFNlpKYrvWzqh7UirCwM3UkRcbrs+t5I2erNKA0?=
 =?us-ascii?Q?RuMGxkLVW2/f2dc5O4GGnCykxTiSwHfnwq7UPdCEKwub6aVJ/KaLfKMpTIq3?=
 =?us-ascii?Q?/G4lPR6V1gxw+r2cF9d6E6anLpWzgKNW6A+hmgzAh6SfrhAAOhmyUiRK2naH?=
 =?us-ascii?Q?mRwNPGdjfmerTSpRvaDJYZkQVfVcjkhjLDDQnhR/dIPvk/RVxXrRAf1XKMUP?=
 =?us-ascii?Q?1VZV3J/tc7cBx8+J9UJcAyBNntCmnUFDiKVhMdbBf2CCOSoEqKyfuAUfburk?=
 =?us-ascii?Q?DxxW/nKm4uyaN95dhbU7SraUCNORQStla3lSsT4yek7sAnKvJaxm87yl725H?=
 =?us-ascii?Q?r2E3/964j7qXtGTSUjbrWl5cdNHPixNiyj/kn60fzkcVGXPLxTa0DrzFKCpX?=
 =?us-ascii?Q?Cw3x0cotAMy/QamXp6lYfVp80CP66QOYO0SgbCz5Rm63uS/TBQDB9zRqUr0p?=
 =?us-ascii?Q?xud+VqEQ3K8PKTwEoPOc4fjdmB+DalN4sR31IwNiEz4PYLQNLa6jz1zwO1kb?=
 =?us-ascii?Q?5RPwg+VcuRVyMlVEvk/Q6bgANRIIAk+0w4T9rBhWEJR1bb0VJl5JGI7Pojp2?=
 =?us-ascii?Q?M6vkQ4jY/atjQYmNlYyWwJR+L19+Uu2TnvnoA/fEyIQRbNYJXntOBKenfPqi?=
 =?us-ascii?Q?jR2ZT/9TgEqgfpU8H1F26L/3Suyb8IzpXvep6o6ONuvrRoUJr1VMdt6M6h+e?=
 =?us-ascii?Q?bg1W4UxVcqK5jNdDU0NH0+Y2myQYFZr9eKV9LnobBDA9ffFEmfO4ElTEt8jc?=
 =?us-ascii?Q?RkjGCCxI8BmybgDGk3aWKSGPQVKnpzlDjQwlJwbj9Q7daZ+phwFLywU43ohh?=
 =?us-ascii?Q?vMnHvwflEYc+UdpC3CUpzy9hMTtjFNbYzbUGbmO0c+9f7h8ru3go2Rcmoptq?=
 =?us-ascii?Q?IvLCDmFxUkVqBvjND0rPCaVvihZhE3F1K8nbce5/UGUIz3V4XZlNsI9HHL8c?=
 =?us-ascii?Q?BdKJj+/3ijQg0WEwzRycfSh0Ul/+sdZs4V+CSi3o7EV0Yjc1Wm7juQ+BvrhJ?=
 =?us-ascii?Q?elRxPGS9uJPYOYK0OAz1Zb/8JvKURa1Wo72wzQ2V1U4jPaMvsP0kJ6bKoaXK?=
 =?us-ascii?Q?z6iR5YLoPt4eMzrNNZg3g6R87yzy4fJBebyCdIeX9HuXZkUh47Pq/4j/0E6a?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b6f853-68ac-498f-84a4-08da64192179
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:13:52.7261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDYZULcij3x7uWYLpWNHavSRCjN+Zo2TtahPsEiYlKC1ZKaFZ4oVCwGC4Epqg08aaWLE01oocD0iD1bKf3je7VEC7e7UosuPCsKY8TvvaWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5236
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that this patch will only apply on another patch series which is
currently waiting for feedback from the LED subsystem. This patch and
in fact the next one are basically only sent to show how i am planning
to continue with that given p1 gets merged.
But i will have to wait for the series i depend on.

Am Tue, 12 Jul 2022 16:32:36 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> This adds support of the Siemens Simatic IPC227G. Its LEDs are
> connected to GPIO pins provided by the gpio_nct6116d module. We make
> sure that gets loaded, if not enabled in the kernel config no LED
> support will be available.
> 
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
> 4c9e663a90ba..2931e2e2dcd4 100644 ---
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
> +		GPIO_LOOKUP_IDX("gpio_nct6116d-2", 0, NULL, 0,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio_nct6116d-2", 1, NULL, 1,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio_nct6116d-2", 2, NULL, 2,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio_nct6116d-2", 3, NULL, 3,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio_nct6116d-2", 4, NULL, 4,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio_nct6116d-2", 5, NULL, 5,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio_nct6116d-2", 6, NULL, 6,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio_nct6116d-3", 6, NULL, 7,
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
>  
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
> +		if (!IS_ENABLED(CONFIG_GPIO_NCT6116D))
> +			return -ENOTSUPP;
> +		request_module("gpio_nct6116d");

This is where the "magic" happens. We basically say that we need that
gpio driver to be loaded or builtin. We do not create a
platform_device, because that gpio driver does that on its own and has
enumeration code to find and ident which chip. Here we really just say
we need that guy to have LEDs.

Not sure that is a good/acceptable pattern. But to show why i use it
here i also decided to include the watchdog support. That watchdog
module has no MODULE_ALIAS at all and the only way to get it would be
builtin or modprobe.
If i wanted to show hwmon code for those Super I/Os ... i would have
the same problem. Drivers to some degree are already in the tree, but
with no autoloading support.

Even if i went to use platform_device_register for that new nct gpio
module, i would still end up using request_module in the simatic ipc
platform to "load modules needed for some boards".

regards,
Henning

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

