Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB3A569379
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiGFUks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiGFUkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 823351E3FF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657140044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hyj4lprFz5j3abxu3sXetpyRdsBIBJWEFHqu1EF5qFQ=;
        b=fsrHoYPAjGecj1139qFZmrChNXXBOR7M94DPpge4fpViqyrk8U9YtJjt6IaGHmvQqxt7/w
        ZX4MG3MDMhji+QuM9xI34Cm4UEJLC0MIR9WyrmoUjW/eZebAdZZqR+U4f2XlbERjMmol8z
        XVi02AC5PUecFJpqFKsicnLWY2y5OTg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-rD9UczZvN3K-3ZD4u9Rg7Q-1; Wed, 06 Jul 2022 16:40:43 -0400
X-MC-Unique: rD9UczZvN3K-3ZD4u9Rg7Q-1
Received: by mail-ej1-f69.google.com with SMTP id qa41-20020a17090786a900b00722f313a60eso4133684ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 13:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hyj4lprFz5j3abxu3sXetpyRdsBIBJWEFHqu1EF5qFQ=;
        b=TE9LrtWWaY5lBXYOqLgB0Js3BpHkyOYGclSehZMn2pAOukaDmp6ZZjCDPRXE5mYxNx
         IFgyxYvCMnHA7MJ0kTTC7z2CQqH2B1U1T879kSkKUyTh6XdSK/hmgV2HbNJN6KzNPksG
         r3is59XcUarYjbh1FmWA+9r5sJSdY7CGHIyw1gHUaSQWtbVBI33zLrA7BIcKjYdHgz7S
         rYvDzX/RGhsL4z9zqQ7QKiVoPV+ri5o43D1pZ0q/5P3Dx3/T/YeXoJ+SThTLywmiDhvb
         JRLLPJcJbjyYj1Zf1/FvIMsJmxXA0WWRmeRuvlGGPhqTEAuzhQRngDC2foCP35V8iyN8
         j1+g==
X-Gm-Message-State: AJIora84XBdw3Or4geEOzpCylDKR10Boz9shRHTbVmgoVvIr6GUcAnTO
        JwhrYn7A7tvE7KdKms+GGJa6z1sbovAlV+k9Yx0OS+bbgqmzlVkr4ixB+VthYxaHWGwQiFr1ZT2
        ZknTute/QFak879mr/bGQnqtm
X-Received: by 2002:a17:906:149:b0:712:c8:fa53 with SMTP id 9-20020a170906014900b0071200c8fa53mr40141713ejh.563.1657140042175;
        Wed, 06 Jul 2022 13:40:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u4UxV9JkVpXBsgVNdKHL/2t8bVeLlPY0ym46/GikBxF0WczYd8pgBk7Yq7f4iS+eixslN5hQ==
X-Received: by 2002:a17:906:149:b0:712:c8:fa53 with SMTP id 9-20020a170906014900b0071200c8fa53mr40141695ejh.563.1657140041983;
        Wed, 06 Jul 2022 13:40:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id z10-20020aa7c64a000000b0043a21e3b4a5sm9211675edr.40.2022.07.06.13.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 13:40:41 -0700 (PDT)
Message-ID: <39d56706-3fa8-bd3d-e661-6be91b8a2ea4@redhat.com>
Date:   Wed, 6 Jul 2022 22:40:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/1] Input: goodix - switch use of
 acpi_gpio_get_*_resource() APIs
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bastien Nocera <hadess@hadess.net>
References: <20220705180252.963-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220705180252.963-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/5/22 20:02, Andy Shevchenko wrote:
> No need to open code functionality that is provided by the
> acpi_gpio_get_irq_resource() and acpi_gpio_get_io_resource().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/input/touchscreen/goodix.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index 3ad9870db108..cc52f0d21dbb 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -822,22 +822,16 @@ static int goodix_resource(struct acpi_resource *ares, void *data)
>  	struct device *dev = &ts->client->dev;
>  	struct acpi_resource_gpio *gpio;
>  
> -	switch (ares->type) {
> -	case ACPI_RESOURCE_TYPE_GPIO:
> -		gpio = &ares->data.gpio;
> -		if (gpio->connection_type == ACPI_RESOURCE_GPIO_TYPE_INT) {
> -			if (ts->gpio_int_idx == -1) {
> -				ts->gpio_int_idx = ts->gpio_count;
> -			} else {
> -				dev_err(dev, "More then one GpioInt resource, ignoring ACPI GPIO resources\n");
> -				ts->gpio_int_idx = -2;
> -			}
> +	if (acpi_gpio_get_irq_resource(ares, &gpio)) {
> +		if (ts->gpio_int_idx == -1) {
> +			ts->gpio_int_idx = ts->gpio_count;
> +		} else {
> +			dev_err(dev, "More then one GpioInt resource, ignoring ACPI GPIO resources\n");
> +			ts->gpio_int_idx = -2;
>  		}
>  		ts->gpio_count++;
> -		break;
> -	default:
> -		break;
> -	}
> +	} else if (acpi_gpio_get_io_resource(ares, &gpio))
> +		ts->gpio_count++;
>  
>  	return 0;
>  }

