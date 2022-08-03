Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975BA588F18
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbiHCPH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbiHCPHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3373527B06
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659539241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7lNGhxjjGu08FSGFBXhTH69Oxbw+MkSJTjAc38J6fuE=;
        b=OipM1y35AXJ7Z/UXwN5WuB53bUiSLZLwvhQoZAZoeq1bRZyNXyKMOw2COIPaLgx7s4ENoa
        5AsoakBl7Ar4ImtRgj/oa2z3lMj2dlEWqxLHgIBZD9kfpbmkB41Pm7b5QegJaf6DSWX2QZ
        /fCpuToLdFxPUg6rqOX5SfvdEWNoEB0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-ONWekeOUNOaJ9bP-xrPySg-1; Wed, 03 Aug 2022 11:07:18 -0400
X-MC-Unique: ONWekeOUNOaJ9bP-xrPySg-1
Received: by mail-ed1-f69.google.com with SMTP id b13-20020a056402350d00b0043dfc84c533so3236484edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 08:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7lNGhxjjGu08FSGFBXhTH69Oxbw+MkSJTjAc38J6fuE=;
        b=wZjTZLtq871qc5mdisy1m3jmGEBCcJSrTo5o9n1nsXa4mCFKZkFiNDr9ZhN8Af9hiL
         rvZpwW4E/72nYEkCmXglmInEaQSgtCjUIRgaNvEmR33BvKICLMhnoFDqBR/gIQzD51Hi
         Yc2bcFhRJ3WktRux3mAmLqeaxW2KT8eP0WOgGP/gLImUHMAsJVx7YPDRddLZaTjvKb/6
         dEOSpqVK5sdpxI59bzqLBsVDWHSLNagVOjI2H63VrpVyjSzut3bKxxHinI0qmeBDB3Wf
         tTbGEGmfe3ohng6+s1Vmx5HWbcEpFVHwVJFV97bRTHPQSRBUKjL0VtCu3JaP5dH/JN8O
         RTtQ==
X-Gm-Message-State: ACgBeo1Y0iLyCrmdH9+KaOSSq2LHbM0pJ4aF0SnSL5WMEhbKomVP4KIX
        Je16ymVSukq5YjKTGASjzNk4qd0BASA7tsu54fLPZov1XZouI5ooOzoCNfnmqZS8YZ/xRN1GtfQ
        Iv8YVW3RpYljx6oZVGat5FMNp
X-Received: by 2002:a17:907:2cf6:b0:730:6068:2ebb with SMTP id hz22-20020a1709072cf600b0073060682ebbmr14584705ejc.82.1659539237141;
        Wed, 03 Aug 2022 08:07:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5/cp0xu71LITXglQORiwlvEXhNzF2RKntpmFpUmHGqrWzuSaYh6itFi0C/5awzknxs05iw2g==
X-Received: by 2002:a17:907:2cf6:b0:730:6068:2ebb with SMTP id hz22-20020a1709072cf600b0073060682ebbmr14584691ejc.82.1659539236919;
        Wed, 03 Aug 2022 08:07:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id kz25-20020a17090777d900b0073085243f3fsm3409392ejc.64.2022.08.03.08.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 08:07:16 -0700 (PDT)
Message-ID: <efb83a0c-7617-894e-a34d-37280238d5aa@redhat.com>
Date:   Wed, 3 Aug 2022 17:07:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] gpiolib: acpi: Add support to ignore programming
 an interrupt
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220803042501.515-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220803042501.515-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/3/22 06:24, Mario Limonciello wrote:
> gpiolib-acpi already had support for ignoring a pin for wakeup, but
> if an OEM configures a floating pin as an interrupt source then
> stopping it from being a wakeup won't do much good to stop the
> interrupt storm.
> 
> Add support for a module parameter and quirk infrastructure to
> ignore interrupts as well.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> v1->v2:
>  * Drop enum
>  * Drop Tested-by tag
> 
>  drivers/gpio/gpiolib-acpi.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index c2523ac26fac..f993f6f728ad 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -32,9 +32,16 @@ MODULE_PARM_DESC(ignore_wake,
>  		 "controller@pin combos on which to ignore the ACPI wake flag "
>  		 "ignore_wake=controller@pin[,controller@pin[,...]]");
>  
> +static char *ignore_interrupt;
> +module_param(ignore_interrupt, charp, 0444);
> +MODULE_PARM_DESC(ignore_interrupt,
> +		 "controller@pin combos on which to ignore interrupt "
> +		 "ignore_interrupt=controller@pin[,controller@pin[,...]]");
> +
>  struct acpi_gpiolib_dmi_quirk {
>  	bool no_edge_events_on_boot;
>  	char *ignore_wake;
> +	char *ignore_interrupt;
>  };
>  
>  /**
> @@ -317,14 +324,15 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
>  	return desc;
>  }
>  
> -static bool acpi_gpio_in_ignore_list(const char *controller_in, unsigned int pin_in)
> +static bool acpi_gpio_in_ignore_list(const char *ignore_list, const char *controller_in,
> +				     unsigned int pin_in)
>  {
>  	const char *controller, *pin_str;
>  	unsigned int pin;
>  	char *endp;
>  	int len;
>  
> -	controller = ignore_wake;
> +	controller = ignore_list;
>  	while (controller) {
>  		pin_str = strchr(controller, '@');
>  		if (!pin_str)
> @@ -348,7 +356,7 @@ static bool acpi_gpio_in_ignore_list(const char *controller_in, unsigned int pin
>  
>  	return false;
>  err:
> -	pr_err_once("Error: Invalid value for gpiolib_acpi.ignore_wake: %s\n", ignore_wake);
> +	pr_err_once("Error: Invalid value for gpiolib_acpi.ignore_...: %s\n", ignore_list);
>  	return false;
>  }
>  
> @@ -360,7 +368,7 @@ static bool acpi_gpio_irq_is_wake(struct device *parent,
>  	if (agpio->wake_capable != ACPI_WAKE_CAPABLE)
>  		return false;
>  
> -	if (acpi_gpio_in_ignore_list(dev_name(parent), pin)) {
> +	if (acpi_gpio_in_ignore_list(ignore_wake, dev_name(parent), pin)) {
>  		dev_info(parent, "Ignoring wakeup on pin %u\n", pin);
>  		return false;
>  	}
> @@ -427,6 +435,11 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
>  		goto fail_unlock_irq;
>  	}
>  
> +	if (acpi_gpio_in_ignore_list(ignore_interrupt, dev_name(chip->parent), pin)) {
> +		dev_info(chip->parent, "Ignoring interrupt on pin %u\n", pin);
> +		return AE_OK;
> +	}
> +
>  	event = kzalloc(sizeof(*event), GFP_KERNEL);
>  	if (!event)
>  		goto fail_unlock_irq;
> @@ -1582,6 +1595,9 @@ static int __init acpi_gpio_setup_params(void)
>  	if (ignore_wake == NULL && quirk && quirk->ignore_wake)
>  		ignore_wake = quirk->ignore_wake;
>  
> +	if (ignore_interrupt == NULL && quirk && quirk->ignore_interrupt)
> +		ignore_interrupt = quirk->ignore_interrupt;
> +
>  	return 0;
>  }
>  

