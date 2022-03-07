Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5AD4D0550
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243808AbiCGRfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiCGRfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:35:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA76F580FC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646674462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FbdNSKrGS4JCoM1jH1uzcLnG2rPnhs6mYtyt0Arre8w=;
        b=dv8iAeCrVmJmr4WFBvR6/WTFT1ecr7zUJzGkCHLofsnkm9ikdojxCmuOogIiCTJcOWYjDr
        O2ILdUaX5Z//pxYkctVf+HNwv6K/R3QhgjxUiqcWlEvMebogE8wyEzsy5ZgMpf+8WUm6DJ
        l8/ptS5WO6TFC5FM+8XvXTEFDOl/Rkc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149--CFLNOgeNyO7Vzv0KSE2LQ-1; Mon, 07 Mar 2022 12:34:21 -0500
X-MC-Unique: -CFLNOgeNyO7Vzv0KSE2LQ-1
Received: by mail-ed1-f71.google.com with SMTP id y10-20020a056402358a00b00410deddea4cso9048449edc.16
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 09:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FbdNSKrGS4JCoM1jH1uzcLnG2rPnhs6mYtyt0Arre8w=;
        b=JoTIlwanJYqK65U0t+Mby7CeZaeay0JbGNt2t5fmLE0Ltk1rQDbipa3Zv8nlBY3brK
         7zya8IjUineul7I0/6yVARbax9NiKIBekQhUtagEo6Fwr24tT/NjEQjXEKaaiLSZy2uV
         hUnYD/MHYvi5qwx+GMniEfrO3bvsGyUudtvqMISRR+i6w7Hf+8cG/3cLuxATJHVGSp4l
         ypJ2XZwUeguJMiXXEX7FMPnT/cz89Zr/zewwOFmeFTOhrl0TPi+0f3jIyEZLkuSheQJ+
         34P3LR1b41RbYqoW7CxH4/gtLB+Xkz5NEh+FxZd2nXM8GsPQdl0syLFhTd7iH0CQFAoR
         X9WQ==
X-Gm-Message-State: AOAM53050M8ua7ep0IHaKDjGX3UPEyZGUwq8efn93E02+88DMNNvyjF7
        GvbFChqJ7DL7LsvjaQ/zBIEdgYlnBJvc4fJQZovvCjlUUDoRjWEIOM3qO+ryNTUJghnUElHOtLR
        iOhyrjesBO6iaDogRBjrY0nyQ
X-Received: by 2002:a05:6402:292c:b0:416:8eb:3fc4 with SMTP id ee44-20020a056402292c00b0041608eb3fc4mr12030111edb.2.1646674460479;
        Mon, 07 Mar 2022 09:34:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWa96UGbyv2h0LnPbaGrA8o8YFfAmGRjN5CFcGQ22V5m7lS0/DD1p/0fxHylTw7f/14YG/Jg==
X-Received: by 2002:a05:6402:292c:b0:416:8eb:3fc4 with SMTP id ee44-20020a056402292c00b0041608eb3fc4mr12030095edb.2.1646674460257;
        Mon, 07 Mar 2022 09:34:20 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id fs6-20020a170907600600b006da8ec6e4a6sm4940420ejc.26.2022.03.07.09.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 09:34:19 -0800 (PST)
Message-ID: <743f08ed-1a26-8cc0-4f7a-32e41f5040f1@redhat.com>
Date:   Mon, 7 Mar 2022 18:34:19 +0100
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
 <ac21f173-2cba-0ddc-67db-27e06950c2d4@redhat.com>
 <YiYicoaSc7KYTbvj@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YiYicoaSc7KYTbvj@google.com>
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

On 3/7/22 16:19, Lee Jones wrote:
> On Mon, 07 Mar 2022, Hans de Goede wrote:
> 
>> Hi,
>>
>> On 3/7/22 15:51, Lee Jones wrote:
>>> On Wed, 23 Feb 2022, Hans de Goede wrote:
>>>
>>>> x86/ACPI boards with an arizona WM5102 codec ship with either Windows or
>>>> Android as factory installed OS.
>>>>
>>>> The ACPI fwnode for the codec on Android boards misses 2 things compared
>>>> to the Windows boards (this is hardcoded in the Android board kernels):
>>>>
>>>> 1. There is no CLKE ACPI method to enabe the 32 KHz clock the codec needs
>>>>    for jack-detection.
>>>>
>>>> 2. The GPIOs used by the codec are not listed in the fwnode for the codec.
>>>>
>>>> The ACPI tables on x86/ACPI boards shipped with Android being incomplete
>>>> happens a lot. The special drivers/platform/x86/x86-android-tablets.c
>>>> module contains DMI based per model handling to compensate for this.
>>>>
>>>> This module will enable the 32KHz clock through the pinctrl framework
>>>> to fix 1. and it will also register a gpio-lookup table for all GPIOs
>>>> needed by the codec + machine driver, including the GPIOs coming from
>>>> the codec itself.
>>>>
>>>> Add an arizona_spi_acpi_android_probe() function which waits for the
>>>> x86-android-tablets to have set things up before continue with probing
>>>> the arizona WM5102 codec.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>  drivers/mfd/arizona-spi.c | 34 +++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 33 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
>>>> index 238355542ab1..2c686e71db21 100644
>>>> --- a/drivers/mfd/arizona-spi.c
>>>> +++ b/drivers/mfd/arizona-spi.c
>>>> @@ -81,6 +81,29 @@ static int arizona_spi_acpi_windows_probe(struct arizona *arizona)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +/* For ACPI tables from boards which ship with Android as factory OS */
>>>> +static int arizona_spi_acpi_android_probe(struct arizona *arizona)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	/*
>>>> +	 * Get the reset GPIO, treating -ENOENT as -EPROBE_DEFER to wait for
>>>> +	 * the x86-android-tablets module to register the board specific GPIO
>>>> +	 * lookup table.
>>>> +	 */
>>>> +	arizona->pdata.reset = devm_gpiod_get(arizona->dev, "reset", GPIOD_OUT_LOW);
>>>> +	if (IS_ERR(arizona->pdata.reset)) {
>>>> +		ret = PTR_ERR(arizona->pdata.reset);
>>>> +		if (ret == -ENOENT) {
>>>> +			dev_info_once(arizona->dev, "Deferring probe till GPIO lookup is registered\n");
>>>
>>> Nit: How many chars is this?
>>
>> 105.
>>
>>> I thought we were drawing the line at 100 these days?
>>
>> We have an exception for log lines, since we don't want to break them
>> up because that makes grepping for them impossible.
>>
>>> Does this patch pass checkpatch.pl?
>>
>> Yes because of the exception for log lines:
>>
>> [hans@x1 linux]$ scripts/checkpatch.pl 0001-mfd-arizona-spi-Add-Android-board-ACPI-table-handlin.patch 
>> total: 0 errors, 0 warnings, 54 lines checked
>>
>> 0001-mfd-arizona-spi-Add-Android-board-ACPI-table-handlin.patch has no obvious style problems and is ready for submission.
> 
> What do you mean by long lines?

Not long lines, log lines, as in lines logging a message,
sorry if that was unclear.

> I'm aware of the exception for long strings.
> 
> Not sure why anyone would grep for "dev_info_once(arizona->dev, ".
> 
> I would break this after the first comma.

Ok, I'll send a v2 with a break after the first comma.

Regards,

Hans

