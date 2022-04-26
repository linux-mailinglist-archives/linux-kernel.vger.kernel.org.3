Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD4850F378
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344177AbiDZIPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbiDZIPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:15:50 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0A86D38F;
        Tue, 26 Apr 2022 01:12:44 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id r14-20020a9d750e000000b00605446d683eso12536994otk.10;
        Tue, 26 Apr 2022 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QF8YkvFfz7v7jJW3CPEik5eZZ2OadQSHQGC1NH/WDbw=;
        b=VBuibKgVwMrwJaqiXQR5as8VpOuu69bk57GXTV7Lt3KL+OKaQArxg6JnuWdwM9nYyr
         vFwgKYlMz8RIsGILRA47P2SQs27AfiHRU8WW0hqV0HiP/MQVS8nOP2+QnleYS6ddRsXn
         COjeyhMAqzfNCFLqzPBE8OB3vSgiXfVAM1FMdsgN7Q7xGJwWylFvtk8KCbbUZjEkRUPr
         sZvFdO0q+QHbp99/N4wmzAnZZuLDPQjRJiwBicBuyEVsujRe4momUecG6n7gwMOMFL+L
         oAqsF/iaxf/ccy8hlSQAoA4nhgtOsqZny85kRgIuZ4dKFvajNq83djjbu/CsVuxoZW2W
         ek0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QF8YkvFfz7v7jJW3CPEik5eZZ2OadQSHQGC1NH/WDbw=;
        b=GnM8/jME5lMQY+0NPHeVfYan6Ir0oLuWhJb7ExKGUK33Rtcf7G69Z5IU0w2n8tCHZg
         Ks79Beo5zHbh3CPv/ldJcv9kvbwXnP6+dN49V1hNKPkl4nDGotbmMRvZOhmTnul9cm5p
         +R++i+erevSk+pzL2iFmwpk2rf9fr9aFbBJwM0S0/akAA4weCzlCG6CmSp/WcuGlgo9j
         fwIXVQFWk7pQkWCkNTGFA9KoxmWNz3YbalG5kD1z69VDGG0Jo09hR8wFVguER+9GH9x5
         3PxWyJZ0dMuZkdoRlwL1jGpqxqkShUwokUhvg6/iI+t6gZQ02BTYKcJwkHH98Rkmu8Lk
         NPJQ==
X-Gm-Message-State: AOAM533Y8pH+OVdxp1q8OsY5GnKaJsWkFnk6ki5H/bQFCb9BuCOEJVPH
        Y6l5tBRN+g6daqSjOJLhBGp9Acv8mvs=
X-Google-Smtp-Source: ABdhPJygeMhass6b1flMYKu7ccDwAi6SY57LHUsmInEjS6kFquf9+RpJkutj7+Z+pLibcb28voGOuQ==
X-Received: by 2002:a9d:7cc2:0:b0:605:77d1:b01 with SMTP id r2-20020a9d7cc2000000b0060577d10b01mr7945566otn.371.1650960763589;
        Tue, 26 Apr 2022 01:12:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c17-20020a9d6851000000b0060551d14386sm4663079oto.13.2022.04.26.01.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 01:12:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c36d2b28-d4e2-b952-d3bc-e060a3cb7412@roeck-us.net>
Date:   Tue, 26 Apr 2022 01:12:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/4] watchdog: wdat_wdg: Using the existed function to
 check parameter timeout
Content-Language: en-US
To:     Tzung-Bi Shih <tzungbi@kernel.org>,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1650944120-30954-1-git-send-email-liuxp11@chinatelecom.cn>
 <1650944120-30954-2-git-send-email-liuxp11@chinatelecom.cn>
 <YmeMyqNqnooVifz1@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YmeMyqNqnooVifz1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 23:10, Tzung-Bi Shih wrote:
> On Tue, Apr 26, 2022 at 11:35:17AM +0800, Liu Xinpeng wrote:
>> The module arguement timeout is a configured timeout value.
>> “separate minimum and maximum HW timeouts and configured timeout value.”
>> (patch v1 is explained by Guenter Roeck)
>>
>> So using watchdog_timeout_invalid to check timeout invalid is more justified.
> 
> The v3 commit message doesn't help too much for understanding the patch.  You
> could see [1] for some reference sentences.  See also [2].
> 
> [1]: https://patchwork.kernel.org/project/linux-watchdog/patch/1650874932-18407-2-git-send-email-liuxp11@chinatelecom.cn/#24831418
> [2]: https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/watchdog/watchdog-kernel-api.rst#L95
> 
>> @@ -14,6 +14,7 @@
>>   #include <linux/watchdog.h>
>>   
>>   #define MAX_WDAT_ACTIONS ACPI_WDAT_ACTION_RESERVED
>> +#define WDAT_TIMEOUT_MIN     1
> 
> To be consistent, would MIN_WDAT_TIMEOUT be a better name?
> 

Should just have set it to 1 below without using a define.

>> @@ -344,6 +345,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>>   	wdat->period = tbl->timer_period;
>>   	wdat->wdd.min_hw_heartbeat_ms = wdat->period * tbl->min_count;
>>   	wdat->wdd.max_hw_heartbeat_ms = wdat->period * tbl->max_count;
>> +	wdat->wdd.min_timeout = WDAT_TIMEOUT_MIN;
> 
> Does it really need to configure the `min_timeout`?  What if leave it as is
> (i.e. 0)?

It is better to set it to 1. Otherwise "0" is considered a valid timeout,
which doesn't make much sense.

Guenter
