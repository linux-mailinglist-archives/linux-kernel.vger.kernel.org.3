Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095B9574CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbiGNMGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbiGNMGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:06:10 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60069.outbound.protection.outlook.com [40.107.6.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52C25C372;
        Thu, 14 Jul 2022 05:06:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcF6MlGZ9t6Z95cNc+VayfmQ4phK3zcTf0M9gRQ3osh6hFqLjT0iDDhpbI/KKcp6deRgdI3Yd8WEpg8L27V2LXj9qsshoHwT8X+SRXKNLSkrLIhSC8FNyUN17mWUJeKkKAyc7fr0EY54eGTZA3Jn6xvp11RCD1NroFqA0+72CxSm9HtczNYOEzvOz7HKI3AAtUTuwnVI1QlzjetOq8RIcGu79C/mW6Fx17I/vJGC2lBCMFTFfyAYNI3olu56gObofuDPsxJA7ndqODkeG+Bj0D/6t7lwtslYyZoPHH3ofomV9FccFe/Cy6Ns+H8Sirtb5Ek8873MSjalYoJfCMfGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhPxwMO3h4zgg0l8fpWIGqDXwdGCC8sGtgQimjvENBw=;
 b=j6om8KsQIUU1aik1i7g0e9MP9Eu0qvdMNJtKVJV1qRouXl2sPtfxte/vlSUrfW+cscBF1kbCEn9QXzFYzxp+HrzNJEetKTNPNLMjDtS2isnuapbA1+3zbckW6lJC7EO7nZm7Iu01Ry01vOlifYNfW/HYvLjNenLN4EmIcTgVz/gHvrAa6f9jzu0iy2PhH0rXm1kQKUEd6O4i7xMYL0KXK017/TdoIH4NXYapsVp6Ua+2V02uebPVL/6LLHv1c1+zs4X1a1PMAjJNmy02vwAUcMOKe9pALNR8S5AqzZpb+HI8E8nUYte5jKZ2M1KRCw2Bepoob1NqocgsnQ18Akoe/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhPxwMO3h4zgg0l8fpWIGqDXwdGCC8sGtgQimjvENBw=;
 b=JvsccKITocjsE2s76oyaTs5SgAexhEOnPWC8SbsH4KzgJ+wcMS21U+rEL48EiuM8SjDtIVqguU+3DxiEUZCqXIyvGzURYNq0VmZBUlMyoTFPR+GWACxwt7+15v1IIMsosnvnSkL2gJAHBMGhU1WmEYSbZxptyoW/YsaIFxXDcasqK2DDYxocEw401j6sdaZ7bmKrvsDIOlEylpTdBO8xR13b0wEM+ITbQGrY49OcSp1557FIE4fQNtFwBYbB16DhozD0afIiCdOS24P3o98c8lALsquN9XQdmqzwpxRfW451s7051pd02+Ec9A0mwWNYWP+pe+lnN+YhHOT0XwgC0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AM8PR10MB4802.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:368::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 12:06:06 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::253b:4d66:1a99:f6e0]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::253b:4d66:1a99:f6e0%8]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 12:06:06 +0000
Date:   Thu, 14 Jul 2022 14:06:03 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 2/3] leds: simatic-ipc-leds-gpio: add new model 227G
Message-ID: <20220714140603.3a38ff50@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220712143237.13992-3-henning.schild@siemens.com>
References: <20220712143237.13992-1-henning.schild@siemens.com>
        <20220712143237.13992-3-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0080.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::25) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baf186ff-fc55-4450-3f09-08da65913b2d
X-MS-TrafficTypeDiagnostic: AM8PR10MB4802:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDuzuzysyRthpmjCDOqJEMa7bZe0XeJMNT5P5JNBqAdFLCHkvjNU04i4P6S7m+9hc3P/lwnIKwNQLtV0DeX3leeqAHpi3hjPwN14nTaFAkXvmw3v0GwkI296RmuRLO/CRit7Sbxjtn/TCi+3XMNSVKPsfjxd7+CA+qTWOniTGTTA2DULLGFfVYu+U0X34voH8YbD4X4XEjQAgdad9JnzB/eYExpWz23z3g1rrX9SwoCJYZGANvC7znsclUOE0pEMQUfiVE6+5a7SKTu2I+kB/8Yc155SmWGbHr9D2NPjGso7FUWxKXtykgTS6fp96HyW5LabcZLNNIp92m0TPzGbe+hGO04B4+MjU3dtDJacV99laO9MJQn5/2gBhKBL31tb+J7cfc8TxlTT9f/tL8lXyHuo8QXAdE0y9bPnrE8lkkSuS3st43dZqEn3z66kGl1uaTtsoDJzdTmI6z2f54beOJqfCVCGqrJdudP6hrIryqkG+SWpQVDgH4B6XFtKN1GzJWwC4/foq6/4UiA0An32WII66PTb7FHaUJMAolDxB7fLVMC9gwdgeCRSvC6uajRi+5KXdbFLavPEjSyP1h7JdrdgnlOgf54PsNVu2B5rY3OZLVraZIXpkUJeY1FBzyVu7/sDZhzzaDHfQTZrdesniegQrFvDBJSAxVUD9wqu5O8wD8V3mEC63ywLnzYys0cWP1DDPh12ZyMG5EB0/osZCjdSvA2ejDtunsV64f/rsP5TgqdSv6K1bPS1Dc07PPhv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(54906003)(38100700002)(110136005)(316002)(186003)(6512007)(9686003)(1076003)(8676002)(66556008)(5660300002)(478600001)(66476007)(4326008)(82960400001)(86362001)(6506007)(66946007)(83380400001)(6666004)(6486002)(8936002)(2906002)(41300700001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r24My847x1YZKwuwe+LvnV/qbq4+YRrhgszrscczIj7Y3MJjxAUY7ExYalxX?=
 =?us-ascii?Q?03WF5OgdqRAxdY2Bx7lQDSa4LZDUD5Sqc3QyHUDTfUZhsDCZ4rRtanOXYIlE?=
 =?us-ascii?Q?yxekGnmLmwgvbvcDK+v18AREWVd6J+cIihvgionyDrxn8rM307BbD5zDEMuW?=
 =?us-ascii?Q?86LoDsyuFrsEdOx2tRj+heJG+I7Tb6KZltEI8cf20c93KYtfSvrxgS4T4nQp?=
 =?us-ascii?Q?RD7e5R2JG5F1/TRMBfGObgjwp2KgsTekBIwc/HK7/8MW7JxsCryPFk5tiTjH?=
 =?us-ascii?Q?sPagTsOX4aslot6+FAomAOSvkxLTHfD+e1Yy/MPzgBgZHoIepNrwCWSBaMfc?=
 =?us-ascii?Q?g4PbsSiXcEyD2Nsr8Y+Qf02vp4pd4j6wG5LS58U1bugDk5+3tXjNHwh1kZN0?=
 =?us-ascii?Q?ba6P/GdYx9Qn8wU4NOC45H+aKnwJmrOoDCYPom4msD7oKTY6r9TgQBIBgnTh?=
 =?us-ascii?Q?IE6Ns3SrFLLGs63lGeo50wmdgGsQ+jVwtwzmI7+OPCdmE00NAOl01TWQl9Rk?=
 =?us-ascii?Q?11SPa6HVDRf9rcMQgytGNidXJYX/cHWusvQ7RmZiC9OivZvjp7rglZUvLQ+O?=
 =?us-ascii?Q?z1wW/WR4fWddt2qgIBkoXsPscmhHE3Ep2VZKj3Xl5RT5yI0UtadQUmOH+vm7?=
 =?us-ascii?Q?iXp5BWOILAP+QOYLnX7vKbPGwciOm6PepAIg8xw3JH5SRLkJg9iP4Db6wnMn?=
 =?us-ascii?Q?nXeCASY33xm9LH4YYJCg1Iq1UzUcdoWcse7VuBLGYq8sYqmSBDMlKf0Fjidk?=
 =?us-ascii?Q?4PGauUYG8ecfvntCxcEZHrtJt1iqyUpW061LP8y+HwdKyHQ4Jt3QEED4rHa6?=
 =?us-ascii?Q?x9uyU+pcZaaUDdS/9Wu7eTril61kZYrszX3V/Oxu5+gvdc4dW3K3fQSEMKSQ?=
 =?us-ascii?Q?r81qg0eguTfCh39QPQaBSTIA+Me0L+lgJPBn3cRZQQ8j8jrevyvoXp1t1+Vu?=
 =?us-ascii?Q?BZ950sN0PsY4vMhM8mNVC+Qz+bpUm9a5XPXne22IMJ0hQWluV1q+7DF9ozaX?=
 =?us-ascii?Q?pU621c4Evv5MJk847YZ9amPzmjPVI7oDdsN1CFyqHsbYnsXfCqowUVrkaH4q?=
 =?us-ascii?Q?sYPvM2BonIhApPyPMfeFFivCAOfv1hTOzK23D/4s30aP6q9AGnwnp1bYMm1Y?=
 =?us-ascii?Q?2oK+9JaCwC88u6WmubBVzxjvWWdGOeUqxosRDjUcOTbe3R1Io0aLFcch2TbQ?=
 =?us-ascii?Q?pqX3KBdr7ZPWlziSYax/ooc+j/D3GugE4j70uFrzA8tb4VjHD4b8QU9LPSMn?=
 =?us-ascii?Q?ggeBSQ3EoMu+5b8YFO3au01qMrPr9E3K5hT/VmG7zBUV8W+y3SDsyITRzozk?=
 =?us-ascii?Q?ZDi56X+d0zgJ0cDp7WEUwQYpF09xap/rOPSE9jm3NekPQdKnMqBFeXRIwnfH?=
 =?us-ascii?Q?DhXWTu5TQwoWfoYVRcLz+IpZd6/5EoApy8XsCgW67vZIdoDZ0GzDhqIYF4k3?=
 =?us-ascii?Q?dWrWs5ngAVhcCCBx03jsfVJLbptY4pFp8Av891pGIg/sgsoUwC6874xnj3Xr?=
 =?us-ascii?Q?EuTR4aS+Pd21m/JICUvQ/lWhw3FniTeHl7s5D3h1ExkTl9rSusnDHoHN7/Ic?=
 =?us-ascii?Q?h7QrNzqIzup7z1Niv8KBpxm8RulSQzV7bHl4U3tOh8jBFgmvbhfa0H/VVBaE?=
 =?us-ascii?Q?y52ny/urmIX0p5oak7f+odkFCiTbBH1m4IQAZ4BoMK0spnNq7fWC0TgX7tBc?=
 =?us-ascii?Q?sQ+xkw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf186ff-fc55-4450-3f09-08da65913b2d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 12:06:06.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2i0sdlWMJ7pOmL/CfAUCdFwC0pqtQQhZcxTI6UhdXG+5eqOvYWqX81WGbUjC01kr3Q3Xmh9EmZMtBAugAIs9oYn+d2Fn4/jiPQK2fiDZnJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4802
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

When i did send v3 i wanted to point attention mainly to this here and
get an opinion on that.

Here i am in a context where i already know exactly which board i am
on. Now i need to bring up my gpio before putting those LEDs on top.

I meanwhile managed to add the chip nct6116d into gpio/gpio-f7188x.c,
which i think looks better and is significantly less code. Easier to
maintain hopefully, but less strict separation of concerns. With a
Fintec driver driving a Nuvoton chip ... no matter how very similar
they are, some people might have objections. I will send the code in a
few days so we can discuss.

But be it in that existing gpio driver or in a new one, the need to init
that one from here or the simatic-platform will remain. And for hwmon
and watchdog i plan to use the same "request_module" trick.

Only here it is guarded by an IS_ENABLED because the feature is not
optional, it is needed for LEDs. And for watchdog i just request the
module ... so it comes up should it be configured into the kernel.

checkpatch did not like ENOTSUPP, happy to take suggestions on a better
error code to say "LEDs can only work when GPIO is enabled ... and
probed"

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

