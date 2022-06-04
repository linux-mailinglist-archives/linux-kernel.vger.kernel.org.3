Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA22C53D724
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbiFDOBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFDOBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B99E43616C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654351308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OfcPj+cwztaLSei0IVYo5rrELt9/llylwn3d2kpTpuU=;
        b=btNou6lVTgWQ2lLFx9ySjW0ndwNAKKIqvUoLPOpRDUStuRgmzc3yKx3gUq4ywiZAjk0IO4
        +RM9NaN/CI2rz/wx59ebkVOjkATMRT8iFM3EDBYKYrxP2vQfBzaZK1FeFMctYs+XhIlkKM
        cAWxgM6M9fvMrG7nGOZXtIxcSjV70XA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-felbLr0vNxWj6WmzSmzdbA-1; Sat, 04 Jun 2022 10:01:47 -0400
X-MC-Unique: felbLr0vNxWj6WmzSmzdbA-1
Received: by mail-lf1-f71.google.com with SMTP id bu3-20020a056512168300b0047791fb1d68so5469227lfb.23
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 07:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OfcPj+cwztaLSei0IVYo5rrELt9/llylwn3d2kpTpuU=;
        b=Ed+2MtcQvNT9vj/fDNYynwkMSZWK9o/baWTYIrZrJYeii95SQ5ECuhDcWRwRWuPAcp
         5Esx0Vg3WGgwwTePNvdsPXLAGOgNy9Fnlbavcknjd1AiPODfu/hlImiA9zLwVON5wUfo
         0abg0KZr/oHShjFYz35p8YwiMmZs7HDGL6E08BiGMf1zURwi+zZLcrlXIiear+Kbs/w8
         NVdBW3FVG1nxBCtSOwDeWKmp0ConGsggdySsMKae6X1P0HbdZ8bPoeHCfJvrk1i4fHAj
         B6vk4mHzibjz3B07FaPJiGjQ8m+JNSGL9u29+cU0hH0p7zMjkFcMCNP8Fd0KS4kFv5tC
         APzQ==
X-Gm-Message-State: AOAM533WYWREU7S0MX05Ck2FGYiVFmGX7LnB3M4EJqRyBmZGm+WJfSVK
        5XaF6ea5VvxxYiROJb0T+b2pA1rqyvGKUL7j88qv/4dYMfL7Ith8H6U1CHamTfbWL64/RgUy4yw
        GsAP73LdiX7+nUTAFEcPhVu3C
X-Received: by 2002:a05:6512:1092:b0:478:689e:a8dc with SMTP id j18-20020a056512109200b00478689ea8dcmr10185936lfg.33.1654351305892;
        Sat, 04 Jun 2022 07:01:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT3qpmanR4n7brU/292+Dw3t7QHTij6GV5mvwsw5m9yfdSwNADAz3WPl+vnnFOK77YoYVY3g==
X-Received: by 2002:a05:6512:1092:b0:478:689e:a8dc with SMTP id j18-20020a056512109200b00478689ea8dcmr10185915lfg.33.1654351305600;
        Sat, 04 Jun 2022 07:01:45 -0700 (PDT)
Received: from [10.101.1.23] (ip-185-104-137-32.ptr.icomera.net. [185.104.137.32])
        by smtp.gmail.com with ESMTPSA id u26-20020ac248ba000000b00478fa47592asm2102110lfg.141.2022.06.04.07.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jun 2022 07:01:44 -0700 (PDT)
Message-ID: <d01f87e0-66fa-e727-f08d-347e0f0853de@redhat.com>
Date:   Sat, 4 Jun 2022 16:01:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] Input: soc_button_array - also add Lenovo Yoga Tablet2
 1051F to dmi_use_low_level_irq
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marius Hoch <mail@mariushoch.de>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220603120246.3065-1-mail@mariushoch.de>
 <YpqMMmIH6Rr0RbeP@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YpqMMmIH6Rr0RbeP@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/4/22 00:33, Dmitry Torokhov wrote:
> On Fri, Jun 03, 2022 at 02:02:46PM +0200, Marius Hoch wrote:
>> Commit 223f61b8c5ad ("Input: soc_button_array - add Lenovo Yoga Tablet2
>> 1051L to the dmi_use_low_level_irq list") added the 1051L to this list
>> already, but the same problem applies to the 1051F. As there are no
>> further 1051 variants (just the F/L), we can just DMI match 1051.
>>
>> Tested on a Lenovo Yoga Tablet2 1051F: Without this patch the
>> home-button stops working after a wakeup from suspend.
>>
>> Signed-off-by: Marius Hoch <mail@mariushoch.de>
> 
> Adding Hans for his input...

This patch is obviously correct the F/L postfix just differs between
wiFi vs LTE, not sure if I already knew this when I wrote this patch
(and did not think things through) or if it is knowledge which I
gathered later, anyway:

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
>> ---
>>  drivers/input/misc/soc_button_array.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
>> index cbb1599a520e..480476121c01 100644
>> --- a/drivers/input/misc/soc_button_array.c
>> +++ b/drivers/input/misc/soc_button_array.c
>> @@ -85,13 +85,13 @@ static const struct dmi_system_id dmi_use_low_level_irq[] = {
>>  	},
>>  	{
>>  		/*
>> -		 * Lenovo Yoga Tab2 1051L, something messes with the home-button
>> +		 * Lenovo Yoga Tab2 1051F/1051L, something messes with the home-button
>>  		 * IRQ settings, leading to a non working home-button.
>>  		 */
>>  		.matches = {
>>  			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>  			DMI_MATCH(DMI_PRODUCT_NAME, "60073"),
>> -			DMI_MATCH(DMI_PRODUCT_VERSION, "1051L"),
>> +			DMI_MATCH(DMI_PRODUCT_VERSION, "1051"),
>>  		},
>>  	},
>>  	{} /* Terminating entry */
>> -- 
>> 2.36.1
>>
> 

