Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281DC4A50B5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379401AbiAaVBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:01:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231445AbiAaVBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643662891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPBUUUSIbdCMKHscebuvK+qxfZIc2zafw8L5TR48Ec8=;
        b=GlZmo6PLqF0LgSCzptDMaKgmKaHdkqoDyQwFVvqbyhewksDH4zMiG1Z9XbLr+9KkGl50rt
        ykoAZDxrAHayoKS3Wdputjv7/+DGpYzkTK3pbQf0/E0SeSbFkwDsxmWC2AaSFjCVoie42A
        hVVc2TPjryanJXQ03lYgFNGkhjDJ4lE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-Y7DuA8lJMS2TmL6p6Lwm3A-1; Mon, 31 Jan 2022 16:01:30 -0500
X-MC-Unique: Y7DuA8lJMS2TmL6p6Lwm3A-1
Received: by mail-ed1-f71.google.com with SMTP id ed6-20020a056402294600b004090fd8a936so7586546edb.23
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QPBUUUSIbdCMKHscebuvK+qxfZIc2zafw8L5TR48Ec8=;
        b=VIJWeJkEB1P9jAu0Bjk1JO7/L1oTqTxQg4cmu+oLA5U4WRY1neHue+akyjWk0gXOeG
         YHkQvVc6bq0u3wsEAwqg62T3PWuscEfs3xOfnjv0LGaaNYV6pNoGkZk1D0NT6HMzghz3
         rfRlCY3kCLyZ9ncVYGF4PkHr9WvA8PYDsPc7jXJqKT07OqldqY0fbuC6X/I22/r/SM1Y
         Jtb18OlPCijSifzpeOvBoH0lTx1nLWv6CMmVgxrXDl9BlBYVLNufHabHvCH/0o5K7Ygk
         KkwALJKQiSlPG+pc8+YCtUALyCjrjopevMVGW/lSCRikCRTt/3OORA4dzIHobsLe3mSL
         fC5g==
X-Gm-Message-State: AOAM533VUoAefq4AQr5rgaMmFZuU40NpGFEmBsF7SmTl5nJhYqaJZzDf
        tNEGZ4g+qpWwgvAmK5XDcYiTR7NEYxZCKZupsd/miDaUce7dgqBikH8tr6kQTFcSC3edIeuufc9
        M3+A/hIJAATMptRDSPBw41LFJ
X-Received: by 2002:a05:6402:34ca:: with SMTP id w10mr22805812edc.145.1643662888879;
        Mon, 31 Jan 2022 13:01:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQNpwY4VLzE85jbEqyTtYB3+udLiLxDc3EUrydHMlJ567geR0t5numq2jG5NKxlB0w9Q46VQ==
X-Received: by 2002:a05:6402:34ca:: with SMTP id w10mr22805800edc.145.1643662888671;
        Mon, 31 Jan 2022 13:01:28 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id lo15sm13780659ejb.28.2022.01.31.13.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 13:01:28 -0800 (PST)
Message-ID: <e1ac452b-0c72-6f22-764a-f34532ae6cce@redhat.com>
Date:   Mon, 31 Jan 2022 22:01:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 3/4] hwmon: (sch56xx-common) Replace msleep() with
 usleep_range()
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220131193137.3684-1-W_Armin@gmx.de>
 <20220131193137.3684-4-W_Armin@gmx.de>
 <3af7602a-1703-4ff2-3905-dfd35742dd90@roeck-us.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3af7602a-1703-4ff2-3905-dfd35742dd90@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/31/22 21:10, Guenter Roeck wrote:
> On 1/31/22 11:31, Armin Wolf wrote:
>> msleep(1) will often sleep more than 20ms, slowing down sensor
>> and watchdog reads/writes. Use usleep_range() as recommended
>> in timers-howto.rst to fix that.
>>
>> Tested on a Fujitsu Esprimo P720.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/hwmon/sch56xx-common.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
>> index 0172aa16dc0c..f66e1ed4b1aa 100644
>> --- a/drivers/hwmon/sch56xx-common.c
>> +++ b/drivers/hwmon/sch56xx-common.c
>> @@ -139,7 +139,7 @@ static int sch56xx_send_cmd(u16 addr, u8 cmd, u16 reg, u8 v)
>>       /* EM Interface Polling "Algorithm" */
>>       for (i = 0; i < max_busy_polls + max_lazy_polls; i++) {
>>           if (i >= max_busy_polls)
>> -            msleep(1);
>> +            usleep_range(1, 2);
> 
> This replaces a 1-millisecond sleep with a 1-2 microsecond sleep.
> 
> Are you sure this is what you want to do ? Given that task switches typically
> take several microseconds, the new code is pretty much identical to a busy
> loop, and the maximum sleep time is reduced significantly.

Ah good catch, I missed that will reviewing v1, sorry about that.

The issue is actually worse then busy-waiting the max wait time
in this code is expressed in a maximum number of polls, so
if usleep_range(1, 2) would really only sleep 1 usec, we would
wait much too short and may hit a false-positive timeout condition
here.

Regards,

Hans



