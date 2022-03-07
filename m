Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606E64D0229
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239824AbiCGO4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbiCGO41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:56:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B8089137C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646664931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5zPX7+bWmI/CpaY4FGFLKYM45UiVk77Y9xHMmgz+n8=;
        b=TfFokRXEOpugpbElX+Pa9zP+ZH741b3reDKciLQGyvxdb4u2M9m/cMbDjMo/oETg/QJ0QM
        HYEwQI8eKkNMJgr6qAzquhQ/ofFDZx6bjw37T/4n/p4DPQHkRQlykngyWy7aBv7h34OFza
        aALgR4z7dnxSG9RFLzzeCW/kmM3llJE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-ZPVXWx4PPbeOElJ86Kjs1w-1; Mon, 07 Mar 2022 09:55:30 -0500
X-MC-Unique: ZPVXWx4PPbeOElJ86Kjs1w-1
Received: by mail-ed1-f72.google.com with SMTP id n11-20020a50cc4b000000b00415e939bf9eso6590261edi.22
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D5zPX7+bWmI/CpaY4FGFLKYM45UiVk77Y9xHMmgz+n8=;
        b=leIPh5dic0HJoej/VhVJqZYYxqyRZbxUFTbqnYH175VlsoVnFbXFkoQu0VoIcfGryH
         R578KEdRgS5lvQQBs+BP2t2WS2XRiT0Y9WBnM/28BjRQkg4Bb83gDxcQzn57S9poU+Sw
         v458LwXeJHT2l6oxWe5AUD061sXCn0Qfo4UO4KjcC2z//KHvWzjbBRpPrXQSr3q8CEHi
         bjFzO/Is4zCT9OeUkeLmoDjp2EOICXw29Dgk5ae+TlZubNqiJVMyD4FNQn7wMpZjRm6C
         JjamgsH6RzRVk29QY0fAlKtn+QfLzb4RLYIjIuNpmRjgTWIx5dnfY1ARxZgvJpX8hTML
         r5xw==
X-Gm-Message-State: AOAM531MpW8zeGfboIFvLHe6upF1y9MkGeBu1qB5f6hQzLT9UW4pSwqa
        Mj4Z3k0soC7AKZpQbtGa/TPxV42c7NhS+MV6cg4liSuTILfeAeTFEzUWfrGbKLywEPQGg2wACOu
        huqm0rIA9ZSJK+mohk5np8Y+T
X-Received: by 2002:a05:6402:386:b0:415:ead8:ced with SMTP id o6-20020a056402038600b00415ead80cedmr11409633edv.407.1646664928823;
        Mon, 07 Mar 2022 06:55:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySUeZ/g15Q+Zh/jVxG1SoCZ4fgYUQpZ1q4Lpw/TD/4UegnrNhxHRfVUXWGGufXmdViY21jeA==
X-Received: by 2002:a05:6402:386:b0:415:ead8:ced with SMTP id o6-20020a056402038600b00415ead80cedmr11409623edv.407.1646664928587;
        Mon, 07 Mar 2022 06:55:28 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id bk1-20020a170906b0c100b006d47308d84dsm4820465ejb.33.2022.03.07.06.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 06:55:28 -0800 (PST)
Message-ID: <ac21f173-2cba-0ddc-67db-27e06950c2d4@redhat.com>
Date:   Mon, 7 Mar 2022 15:55:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] mfd: arizona-spi: Add Android board ACPI table
 handling
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
References: <20220223134222.730886-1-hdegoede@redhat.com>
 <20220223134222.730886-2-hdegoede@redhat.com> <YiYb+Ea7aKO99gXL@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YiYb+Ea7aKO99gXL@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/7/22 15:51, Lee Jones wrote:
> On Wed, 23 Feb 2022, Hans de Goede wrote:
> 
>> x86/ACPI boards with an arizona WM5102 codec ship with either Windows or
>> Android as factory installed OS.
>>
>> The ACPI fwnode for the codec on Android boards misses 2 things compared
>> to the Windows boards (this is hardcoded in the Android board kernels):
>>
>> 1. There is no CLKE ACPI method to enabe the 32 KHz clock the codec needs
>>    for jack-detection.
>>
>> 2. The GPIOs used by the codec are not listed in the fwnode for the codec.
>>
>> The ACPI tables on x86/ACPI boards shipped with Android being incomplete
>> happens a lot. The special drivers/platform/x86/x86-android-tablets.c
>> module contains DMI based per model handling to compensate for this.
>>
>> This module will enable the 32KHz clock through the pinctrl framework
>> to fix 1. and it will also register a gpio-lookup table for all GPIOs
>> needed by the codec + machine driver, including the GPIOs coming from
>> the codec itself.
>>
>> Add an arizona_spi_acpi_android_probe() function which waits for the
>> x86-android-tablets to have set things up before continue with probing
>> the arizona WM5102 codec.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/mfd/arizona-spi.c | 34 +++++++++++++++++++++++++++++++++-
>>  1 file changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
>> index 238355542ab1..2c686e71db21 100644
>> --- a/drivers/mfd/arizona-spi.c
>> +++ b/drivers/mfd/arizona-spi.c
>> @@ -81,6 +81,29 @@ static int arizona_spi_acpi_windows_probe(struct arizona *arizona)
>>  	return 0;
>>  }
>>  
>> +/* For ACPI tables from boards which ship with Android as factory OS */
>> +static int arizona_spi_acpi_android_probe(struct arizona *arizona)
>> +{
>> +	int ret;
>> +
>> +	/*
>> +	 * Get the reset GPIO, treating -ENOENT as -EPROBE_DEFER to wait for
>> +	 * the x86-android-tablets module to register the board specific GPIO
>> +	 * lookup table.
>> +	 */
>> +	arizona->pdata.reset = devm_gpiod_get(arizona->dev, "reset", GPIOD_OUT_LOW);
>> +	if (IS_ERR(arizona->pdata.reset)) {
>> +		ret = PTR_ERR(arizona->pdata.reset);
>> +		if (ret == -ENOENT) {
>> +			dev_info_once(arizona->dev, "Deferring probe till GPIO lookup is registered\n");
> 
> Nit: How many chars is this?

105.

> I thought we were drawing the line at 100 these days?

We have an exception for log lines, since we don't want to break them
up because that makes grepping for them impossible.

> Does this patch pass checkpatch.pl?

Yes because of the exception for log lines:

[hans@x1 linux]$ scripts/checkpatch.pl 0001-mfd-arizona-spi-Add-Android-board-ACPI-table-handlin.patch 
total: 0 errors, 0 warnings, 54 lines checked

0001-mfd-arizona-spi-Add-Android-board-ACPI-table-handlin.patch has no obvious style problems and is ready for submission.

Regards,

Hans


> 
>> +			ret = -EPROBE_DEFER;
>> +		}
>> +		return dev_err_probe(arizona->dev, ret, "getting reset GPIO\n");
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * The AOSP 3.5 mm Headset: Accessory Specification gives the following values:
>>   * Function A Play/Pause:           0 ohm
>> @@ -102,9 +125,14 @@ static const struct arizona_micd_range arizona_micd_aosp_ranges[] = {
>>  
>>  static int arizona_spi_acpi_probe(struct arizona *arizona)
>>  {
>> +	struct acpi_device *adev = ACPI_COMPANION(arizona->dev);
>>  	int ret;
>>  
>> -	ret = arizona_spi_acpi_windows_probe(arizona);
>> +	if (acpi_dev_hid_uid_match(adev, "10WM5102", NULL))
>> +		ret = arizona_spi_acpi_android_probe(arizona);
>> +	else
>> +		ret = arizona_spi_acpi_windows_probe(arizona);
>> +
>>  	if (ret)
>>  		return ret;
>>  
>> @@ -142,6 +170,10 @@ static const struct acpi_device_id arizona_acpi_match[] = {
>>  		.id = "WM510205",
>>  		.driver_data = WM5102,
>>  	},
>> +	{
>> +		.id = "10WM5102",
>> +		.driver_data = WM5102,
>> +	},
>>  	{ }
>>  };
>>  MODULE_DEVICE_TABLE(acpi, arizona_acpi_match);
> 

