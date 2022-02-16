Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558BE4B8FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbiBPSK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:10:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237473AbiBPSK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:10:56 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ED62B1013
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:10:41 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h6so4820548wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/GDwCmOa4MtdZnSQteLqJB5ggHWRiUbbOudwWhAgHcI=;
        b=trUphBMT/37EFY19GX1DTH6KJWnDoyi+q8RVMHFeBja8rT3CLmZJKVZokGSaVj1noe
         SE9Y74qGSA1gl3/C3P3nDNY0ZiO7SAbFFhCMRRHwtNh0MTXGm67xIwY6TzClNNEvohhF
         Cn365qiU5EKO3MyIWHmio73G4ddp1+p+RpvQ+WphFF1F1GTNx2MAqKy2E1hi+dteQUAO
         nXGisZxF0F1h1UHECAnXoc10Tu8N+0Gt/IUM/QhRn0npOBWze5HXdcsjrdxGK30PBG3h
         OI8j/NQS+fFfnJHfrCIP59PMRy/gC47L7SkZt+uCwR1FIqhJkjbMz0vd6kIxnP3xgvmA
         tlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/GDwCmOa4MtdZnSQteLqJB5ggHWRiUbbOudwWhAgHcI=;
        b=mTqqsWZtE/6qZo7OgcsTkqtramS9waP1cjnWMUTM9BQb8ejFI4HjwVmE4kkhO6bfNT
         3StCLrjmOzDeemLTm7K4n7Mhee8rMMyfP7VwDJPhLt4v5ToIppg/fkVdJpZVNnnyUuRQ
         Jv3UzKWzq2DybiiXTBOLCq52y4xesseZYwDLAljhRuaSPZCE/EqPLduV1K3sEXOs1fuD
         hPC5EQR70LBvZsOtAzCtlHRRIkYkbVlDrr1WhKQlK/Rp90ZSmjRv59UcBWqvlMSn5Be2
         XEdLbNRpXbO7tNDUJYf/LnKAWw7t+5CI1VAafH1vOpNkI29ssJjkHtUh0U2V0IL1uRsb
         AGYg==
X-Gm-Message-State: AOAM53118naxbdPI/iATNdAB9KqnBP99mREKqkZSN6jjT1dBXH9DNZNv
        gJXJ9791hkOj6LuttsLZr5B8XA==
X-Google-Smtp-Source: ABdhPJzCLH7rGMIhynYdNXqwlOOJOhAjOeEZcgG3BuiMskbbYpYgii4hpA1AcoQiMSV2w8e/cc7zQQ==
X-Received: by 2002:a5d:40ca:0:b0:1e5:1996:fc88 with SMTP id b10-20020a5d40ca000000b001e51996fc88mr3314356wrq.222.1645035040170;
        Wed, 16 Feb 2022 10:10:40 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:6165:d98a:b553:c3c1? ([2a01:e34:ed2f:f020:6165:d98a:b553:c3c1])
        by smtp.googlemail.com with ESMTPSA id l12sm18045471wmd.44.2022.02.16.10.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 10:10:39 -0800 (PST)
Message-ID: <e44b9c4b-2ac4-4ea4-c771-bde13943af5f@linaro.org>
Date:   Wed, 16 Feb 2022 19:10:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 3/7] powercap/dtpm: Fixup kfree for virtual node
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
 <20220130210210.549877-3-daniel.lezcano@linaro.org>
 <CAPDyKFqV++g63Asax8TNSEgujxJ=uM9XG2_Advu34JidYBCGtg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAPDyKFqV++g63Asax8TNSEgujxJ=uM9XG2_Advu34JidYBCGtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2022 17:22, Ulf Hansson wrote:
> On Sun, 30 Jan 2022 at 22:02, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> When the node is virtual there is no release function associated which
>> can free the memory.
>>
>> Free the memory when no 'ops' exists.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/powercap/dtpm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
>> index 0b0121c37a1b..7bddd25a6767 100644
>> --- a/drivers/powercap/dtpm.c
>> +++ b/drivers/powercap/dtpm.c
>> @@ -181,12 +181,12 @@ int dtpm_release_zone(struct powercap_zone *pcz)
>>
>>          if (dtpm->ops)
>>                  dtpm->ops->release(dtpm);
>> +       else
>> +               kfree(dtpm);
>>
> 
> This doesn't look correct. Below you check dtpm against "root", which
> may be after its memory has been freed.
> 
> If the ->release() function should be responsible for freeing the
> dtpm, it needs to be called after the check below.

It is harmless, 'root' is not dereferenced but used as an ID

Moreover, in the patch 5/7 it is moved out this function.


>>          if (root == dtpm)
>>                  root = NULL;
>>
>> -       kfree(dtpm);
>> -
>>          return 0;
>>   }
>>
> 
> Kind regards
> Uffe


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
