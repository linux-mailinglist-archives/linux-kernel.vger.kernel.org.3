Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284F85906B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbiHKSxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiHKSxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33A099E132
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660244008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ozah201mnfEEDkVFShrVs48byUP3DGG4fcUS7109nSU=;
        b=MHR15G1PInDUWUMNmzmaSdZaH1ixrJ2LRE1mKO8Wde2jE7N4OxbrjpAiSbBry5B66H4r8v
        qGFvhhLbRgE7Ogih2ANBnSJAsk/o+SsJd8NZdtdj+sVf90yBeh5wvfrywYS4uyFLvQcoUi
        9/ZyHU5C3ugdGewgExzdie5iN0RgAOk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-615-7PIlt6izO_Sb4pOC9mM2TA-1; Thu, 11 Aug 2022 14:53:27 -0400
X-MC-Unique: 7PIlt6izO_Sb4pOC9mM2TA-1
Received: by mail-ej1-f72.google.com with SMTP id ga16-20020a1709070c1000b007331af32d3aso1692039ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Ozah201mnfEEDkVFShrVs48byUP3DGG4fcUS7109nSU=;
        b=uBUWNqe5RLLwhIdAJLsCbwRSf82kb2gP6lKoWiNcco2wc9iPSJz12amxVSnX1cYfEF
         XXIWSLVYo00Uj4YluuHeMkibYte0BX1XLe7qWU1hWHZdl1gnjevuiR3IGZx2aVM5ssib
         zStVSGrlq7Vw4Y3fgRFdsTzb1Z2XU03PdBj6s9pN3UHf5ZPCXDTk5CbWfBjlKMcYkyOG
         XtM3O62LnIO/m0Blg3DsvwpHuiHlcGERLjIQUzj3IXNylDz6aHeJAJweJxqS54bTGHSU
         E5UJLfH/ysS3nGz7C0SJN/O/3s653vFYKGEqGGKD4/cgx4wZ4IwTMc3T1XQPuwdv9dgZ
         6xXg==
X-Gm-Message-State: ACgBeo32yToIY6z69BDpRB3KXHEHGF12+Cw+A/4yz8iELWDOz+ShKUpw
        tJMChCqVDzndVb7ri2Ks9HF6TaMvqY0VbA5O9XfZyLBvU98kQo8yOnzBqjAXnQVkHJL28TxtUkB
        5Ngg+4tE+JP951NCskrPmd2z+
X-Received: by 2002:a05:6402:538a:b0:43a:298e:bc2b with SMTP id ew10-20020a056402538a00b0043a298ebc2bmr407780edb.125.1660244005846;
        Thu, 11 Aug 2022 11:53:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4Hf0C3qERg79013qKBqVwC7oHyWQmFquBERdgftTvV6Wvyxf06qOEovcWRBXcfm3s3neBGlw==
X-Received: by 2002:a05:6402:538a:b0:43a:298e:bc2b with SMTP id ew10-20020a056402538a00b0043a298ebc2bmr407757edb.125.1660244005666;
        Thu, 11 Aug 2022 11:53:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id f2-20020a17090660c200b007317ad29921sm3879701ejk.13.2022.08.11.11.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 11:53:25 -0700 (PDT)
Message-ID: <23778397-8080-da39-fbde-22a10c820fbd@redhat.com>
Date:   Thu, 11 Aug 2022 20:53:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 3/4] leds: simatic-ipc-leds-gpio: add new model 227G
Content-Language: en-US
To:     Henning Schild <henning.schild@siemens.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>, Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        simon.guinot@sequanux.org
References: <20220811153908.31283-1-henning.schild@siemens.com>
 <20220811153908.31283-4-henning.schild@siemens.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220811153908.31283-4-henning.schild@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/11/22 17:39, Henning Schild wrote:
> This adds support of the Siemens Simatic IPC227G. Its LEDs are connected
> to GPIO pins provided by the gpio-f7188x module. We make sure that
> gets loaded, if not enabled in the kernel config no LED support will be
> available.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/leds/simple/simatic-ipc-leds-gpio.c   | 42 ++++++++++++++++---
>  drivers/platform/x86/simatic-ipc.c            |  4 +-
>  .../platform_data/x86/simatic-ipc-base.h      |  1 +
>  include/linux/platform_data/x86/simatic-ipc.h |  1 +
>  4 files changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
> index 4c9e663a90ba..0d73dcbeec2d 100644
> --- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
> +++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
> @@ -13,28 +13,45 @@
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
> -		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 0, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 1, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 2, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 3, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 4, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 5, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 0, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
>  	},
>  };
>  
> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
> +	.dev_id = "leds-gpio",
> +	.table = {
> +		GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-2", 1, NULL, 1, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-2", 2, NULL, 2, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 3, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-2", 4, NULL, 4, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
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
>  static const struct gpio_led_platform_data simatic_ipc_gpio_leds_pdata = {
> @@ -46,7 +63,7 @@ static struct platform_device *simatic_leds_pdev;
>  
>  static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
>  {
> -	gpiod_remove_lookup_table(&simatic_ipc_led_gpio_table);
> +	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table);
>  	platform_device_unregister(simatic_leds_pdev);
>  
>  	return 0;
> @@ -54,10 +71,25 @@ static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
>  
>  static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
>  {
> +	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
>  	struct gpio_desc *gpiod;
>  	int err;
>  
> -	gpiod_add_lookup_table(&simatic_ipc_led_gpio_table);
> +	switch (plat->devmode) {
> +	case SIMATIC_IPC_DEVICE_127E:
> +		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_127e;
> +		break;
> +	case SIMATIC_IPC_DEVICE_227G:
> +		if (!IS_ENABLED(CONFIG_GPIO_F7188X))
> +			return -ENODEV;
> +		request_module("gpio-f7188x");
> +		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_227g;
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	gpiod_add_lookup_table(simatic_ipc_led_gpio_table);
>  	simatic_leds_pdev = platform_device_register_resndata(NULL,
>  		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
>  		&simatic_ipc_gpio_leds_pdata,
> diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
> index ca3647b751d5..1825ef21a86d 100644
> --- a/drivers/platform/x86/simatic-ipc.c
> +++ b/drivers/platform/x86/simatic-ipc.c
> @@ -41,6 +41,7 @@ static struct {
>  	{SIMATIC_IPC_IPC127E, SIMATIC_IPC_DEVICE_127E, SIMATIC_IPC_DEVICE_NONE},
>  	{SIMATIC_IPC_IPC227D, SIMATIC_IPC_DEVICE_227D, SIMATIC_IPC_DEVICE_NONE},
>  	{SIMATIC_IPC_IPC227E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_227E},
> +	{SIMATIC_IPC_IPC227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_NONE},
>  	{SIMATIC_IPC_IPC277E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E},
>  	{SIMATIC_IPC_IPC427D, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE},
>  	{SIMATIC_IPC_IPC427E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_427E},
> @@ -65,7 +66,8 @@ static int register_platform_devices(u32 station_id)
>  	}
>  
>  	if (ledmode != SIMATIC_IPC_DEVICE_NONE) {
> -		if (ledmode == SIMATIC_IPC_DEVICE_127E)
> +		if (ledmode == SIMATIC_IPC_DEVICE_127E ||
> +		    ledmode == SIMATIC_IPC_DEVICE_227G)
>  			pdevname = KBUILD_MODNAME "_leds_gpio";
>  		platform_data.devmode = ledmode;
>  		ipc_led_platform_device =
> diff --git a/include/linux/platform_data/x86/simatic-ipc-base.h b/include/linux/platform_data/x86/simatic-ipc-base.h
> index 39fefd48cf4d..57d6a10dfc9e 100644
> --- a/include/linux/platform_data/x86/simatic-ipc-base.h
> +++ b/include/linux/platform_data/x86/simatic-ipc-base.h
> @@ -19,6 +19,7 @@
>  #define SIMATIC_IPC_DEVICE_427E 2
>  #define SIMATIC_IPC_DEVICE_127E 3
>  #define SIMATIC_IPC_DEVICE_227E 4
> +#define SIMATIC_IPC_DEVICE_227G 5
>  
>  struct simatic_ipc_platform {
>  	u8	devmode;
> diff --git a/include/linux/platform_data/x86/simatic-ipc.h b/include/linux/platform_data/x86/simatic-ipc.h
> index f3b76b39776b..7a2e79f3be0b 100644
> --- a/include/linux/platform_data/x86/simatic-ipc.h
> +++ b/include/linux/platform_data/x86/simatic-ipc.h
> @@ -31,6 +31,7 @@ enum simatic_ipc_station_ids {
>  	SIMATIC_IPC_IPC427E = 0x00000A01,
>  	SIMATIC_IPC_IPC477E = 0x00000A02,
>  	SIMATIC_IPC_IPC127E = 0x00000D01,
> +	SIMATIC_IPC_IPC227G = 0x00000F01,
>  };
>  
>  static inline u32 simatic_ipc_get_station_id(u8 *data, int max_len)

