Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D325F5906B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbiHKSwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiHKSwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:52:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 107F99DFB3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660243933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sgm5mcggNid13CMQID8h+6VTN/oeMOW9HM233F0QERg=;
        b=f7WsR833N2tKMDtRkWyBQSHqnmTUS5Tr5cC2IYQ2dD8G6Lb2NAv/phBDIbO9OhS/vHK5cJ
        PzudsESdnSK2yLywSnN8jzFil/uw+heX3BZK61ukN6Z4Kyt8Xn58d+vy5EsLhzdM6YmPg3
        F1yuz9e5itU4Lwlgo+tVEtGjoPBCCRI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-QrbFfyd9NFm72DOCwvd-Xw-1; Thu, 11 Aug 2022 14:52:11 -0400
X-MC-Unique: QrbFfyd9NFm72DOCwvd-Xw-1
Received: by mail-ed1-f71.google.com with SMTP id w5-20020a05640234c500b0043dda025648so11399999edc.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Sgm5mcggNid13CMQID8h+6VTN/oeMOW9HM233F0QERg=;
        b=ygWGz75MNGD/Kx+1EFdMC1kUFO+fj/Q+wGghszxQKaIV3GHNLbyCMOS6QViUshpgKq
         FIY3rnx7ZUxg1KuzF7eG7qQbCQYvssET3lb46+KwDGTPh0NPNKGjWk6b8DNaGq+WfCl/
         vNVn8nPk2GXmiapadJKKOHxWf1fZ8jONv21B05/1BsTcEI2momnMsNPTrFtJqaFatdT0
         mYSfU/4qw34mhjIwI5ng1KCi/3vTGvRGsG2d/+MP1V94KynYlbuG99fzDu4ODZus9WE+
         HYOsEtl3bwZIzqFUDsn8DPRtuVY/k7XbusbVCCTOzbWhdEcLndlmofG49UnEZ7exd/07
         4twg==
X-Gm-Message-State: ACgBeo0OrARm6OqCoWSC1bAJxVocqUku+X7h6Oeu2kNcN7fAZ+jM/eRH
        Yjs6vr0O/XD6y/T653fXxHtm9psO0yBRxPOGD7mBtiAy3jF435UICFl+873RILfpgk8NG+lJY3Q
        bWKqn3+bMxe2p40rjU1Q1QZH5
X-Received: by 2002:a05:6402:b6a:b0:43d:2454:ddd3 with SMTP id cb10-20020a0564020b6a00b0043d2454ddd3mr443105edb.138.1660243930844;
        Thu, 11 Aug 2022 11:52:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7bwetI42qiOhekFkq9dHevVo2z0CuUYEvdStjoch2SCNke1QA1jtM0is+OAm4MLRBP9b9A5A==
X-Received: by 2002:a05:6402:b6a:b0:43d:2454:ddd3 with SMTP id cb10-20020a0564020b6a00b0043d2454ddd3mr443088edb.138.1660243930641;
        Thu, 11 Aug 2022 11:52:10 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id f11-20020a05640214cb00b0043a5bcf80a2sm112450edx.60.2022.08.11.11.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 11:52:10 -0700 (PDT)
Message-ID: <adaf33ba-b9dd-8ed3-a55e-40fded404fea@redhat.com>
Date:   Thu, 11 Aug 2022 20:52:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 5/6] asus-wmi: Convert all attr-show to use sysfs_emit
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Luke D. Jones" <luke@ljones.dev>
Cc:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220809025054.1626339-1-luke@ljones.dev>
 <20220809025054.1626339-6-luke@ljones.dev>
 <CAHp75VdoqPOZz4GG6Sr2npZwjYHDVMo2pmNGqyBRrnen2j8k7g@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VdoqPOZz4GG6Sr2npZwjYHDVMo2pmNGqyBRrnen2j8k7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/9/22 11:27, Andy Shevchenko wrote:
> On Tue, Aug 9, 2022 at 4:51 AM Luke D. Jones <luke@ljones.dev> wrote:
>>
>> This changes all *_show attributes in asus-wmi.c to use sysfs_emit()
>> instead of the older method of writing to the output buffer manually.
> 
> This looks good to me,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> (Carry the tag with a new version of the series in this patch)
> 
> Hans, I guess this one can be applied so it will be less of a burden
> on reviewing the rest.

Thanks for the review. I agree that this one can be merged
already, so I have just merged it:

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Patches which are added to review-hans now are intended for
the next rc1. This branch will get rebased to the next rc1 when
it is out and after the rebasing the contents of review-hans
will be pushed to the platform-drivers-x86/for-next branch.

Regards,

Hans


> 
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>> ---
>>  drivers/platform/x86/asus-wmi.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>> index 719223804c0e..78f1f3af1b12 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -942,7 +942,7 @@ static ssize_t charge_control_end_threshold_show(struct device *device,
>>                                                  struct device_attribute *attr,
>>                                                  char *buf)
>>  {
>> -       return sprintf(buf, "%d\n", charge_end_threshold);
>> +       return sysfs_emit(buf, "%d\n", charge_end_threshold);
>>  }
>>
>>  static DEVICE_ATTR_RW(charge_control_end_threshold);
>> @@ -2032,7 +2032,7 @@ static ssize_t pwm1_show(struct device *dev,
>>                 value = -1;
>>         }
>>
>> -       return sprintf(buf, "%d\n", value);
>> +       return sysfs_emit(buf, "%d\n", value);
>>  }
>>
>>  static ssize_t pwm1_store(struct device *dev,
>> @@ -2092,7 +2092,7 @@ static ssize_t fan1_input_show(struct device *dev,
>>                 return -ENXIO;
>>         }
>>
>> -       return sprintf(buf, "%d\n", value < 0 ? -1 : value*100);
>> +       return sysfs_emit(buf, "%d\n", value < 0 ? -1 : value * 100);
>>  }
>>
>>  static ssize_t pwm1_enable_show(struct device *dev,
>> @@ -2110,7 +2110,7 @@ static ssize_t pwm1_enable_show(struct device *dev,
>>          * in practice on X532FL at least (the bit is always 0) and there's
>>          * also nothing in the DSDT to indicate that this behaviour exists.
>>          */
>> -       return sprintf(buf, "%d\n", asus->fan_pwm_mode);
>> +       return sysfs_emit(buf, "%d\n", asus->fan_pwm_mode);
>>  }
>>
>>  static ssize_t pwm1_enable_store(struct device *dev,
>> @@ -2178,7 +2178,7 @@ static ssize_t fan1_label_show(struct device *dev,
>>                                           struct device_attribute *attr,
>>                                           char *buf)
>>  {
>> -       return sprintf(buf, "%s\n", ASUS_FAN_DESC);
>> +       return sysfs_emit(buf, "%s\n", ASUS_FAN_DESC);
>>  }
>>
>>  static ssize_t asus_hwmon_temp1(struct device *dev,
>> @@ -2371,7 +2371,7 @@ static ssize_t fan_boost_mode_show(struct device *dev,
>>  {
>>         struct asus_wmi *asus = dev_get_drvdata(dev);
>>
>> -       return scnprintf(buf, PAGE_SIZE, "%d\n", asus->fan_boost_mode);
>> +       return sysfs_emit(buf, "%d\n", asus->fan_boost_mode);
>>  }
>>
>>  static ssize_t fan_boost_mode_store(struct device *dev,
>> @@ -2924,7 +2924,7 @@ static ssize_t throttle_thermal_policy_show(struct device *dev,
>>         struct asus_wmi *asus = dev_get_drvdata(dev);
>>         u8 mode = asus->throttle_thermal_policy_mode;
>>
>> -       return scnprintf(buf, PAGE_SIZE, "%d\n", mode);
>> +       return sysfs_emit(buf, "%d\n", mode);
>>  }
>>
>>  static ssize_t throttle_thermal_policy_store(struct device *dev,
>> --
>> 2.37.1
>>
> 
> 

