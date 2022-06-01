Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0861A53A511
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352893AbiFAMck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351258AbiFAMcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:32:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900BB3FD80
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:32:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so6076328pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 05:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=aNiEaNz3PE8EusgnD+3ibkIGrbwL5BaMxt0546m/AT0=;
        b=7LFoWcKWkG9OxI3/dLi7p9o3QifvcD7DXsD+OPVitSZbZ+T2UyHOHk5v3bBfRhyRZo
         hXpFPnPNnifxYROZmf3HvRaSmMING8uX8pqc3yvviDrLbqj5V6FlhErC7FjfPZapbhde
         6ggTFVVuFNQZTWcWhPU01mptOwUELhAqHQGdUM7hRUyhoqdDu/gjAUymuJrqDrQRSjPP
         ej1GZRJm5JIMAHm39fCbQzPs4+F5GJjYIDd2agQlmkoXBjv/ibFeJw9rYjMUmO5Q/VD8
         Pyck5Ea9JibWRUnR3Ndo5h7x2xcGg0PQ+3On5OKwCanHoRq+R6xZwdOOsWq+zfya1VaW
         Nwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=aNiEaNz3PE8EusgnD+3ibkIGrbwL5BaMxt0546m/AT0=;
        b=mkOLFdLnjHx0SobsK4BrbeXMpfcemelIIs75qcbjj8fDT9JSiJadK0vRvdAvk+FCae
         cswpNqsAoV4HBEvViXQMbEePeZDFBQPcwYCB+9jhQHNNrJ8mekhptyzvypP+CPHh8FnI
         ku5WMe2Vwo/OUHw6ekhdx6TkepjSKZk/cPQkCt5eNkgK6xy8xbOtuaaTLBJaaHUDYE1N
         zboAK8c3hUuhrbCZcItMwXDfHL4FalOU75MN1qo+NtRyNAu4B7pnIeHJM7Fkqd49bdel
         mdRx6DSbBtoZXWwYzWt+6zjKM+AI7uF5VoGSMoMSECLdwUJRw9H7Eny9oTRrfOwTTtFK
         PsBw==
X-Gm-Message-State: AOAM530qZHpisbiSOYO+n+GxT7VkEhvnLyncYMqAgFfPB13iDheFVF50
        b9E1Ngac14ga26UZ99Zk6n+dzA==
X-Google-Smtp-Source: ABdhPJwUKBFlsa9ecDKitfTCWR3Frt6/fJqwij4Dl0w7nYOx8kQQEFrF1dIIZ7O90+SsdC/CYwQa3g==
X-Received: by 2002:a17:90a:d58d:b0:1e0:adde:a7f8 with SMTP id v13-20020a17090ad58d00b001e0addea7f8mr34225334pju.74.1654086757120;
        Wed, 01 Jun 2022 05:32:37 -0700 (PDT)
Received: from [10.4.211.178] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id e13-20020aa798cd000000b0050dc76281b8sm1438328pfm.146.2022.06.01.05.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 05:32:36 -0700 (PDT)
Message-ID: <08dac681-6877-1323-9394-ffe812c07934@bytedance.com>
Date:   Wed, 1 Jun 2022 20:32:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] blk-iocost: fix false positive lagging
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220526133554.21079-1-zhouchengming@bytedance.com>
 <c76ee7e2-3dfe-b645-c32f-4f061b22ebc9@bytedance.com>
In-Reply-To: <c76ee7e2-3dfe-b645-c32f-4f061b22ebc9@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/28 16:17, Chengming Zhou wrote:
> On 2022/5/26 21:35, Chengming Zhou wrote:
>> I found many false positive lagging during iocost test.
>>
>> Since iocg->vtime will be advanced to (vnow - margins.target)
>> in hweight_after_donation(), which called throw away excess,
>> the iocg->done_vtime will also be advanced that much.
>>
>>        period_at_vtime  <--period_vtime-->  vnow
>>               |                              |
>>   --------------------------------------------------->
>>         |<--->|
>>      margins.target
>>         |->
>>   vtime, done_vtime
>>
>> If that iocg has some inflight io when vnow, but its done_vtime
>> is before period_at_vtime, ioc_timer_fn() will think it has
>> lagging io, even these io maybe issued just before now.
>>
>> This patch change the condition to check if vdone is before
>> (period_at_vtime - margins.target) instead of period_at_vtime.
>>
>> But there is another problem that this patch doesn't fix.
>> Since vtime will be advanced, we can't check if vtime is
>> after (vnow - MAX_LAGGING_PERIODS * period_vtime) to tell
>> whether this iocg pin lagging for too long.
>>
>> Maybe we can add lagging_periods in iocg to record how many
>> periods this iocg pin lagging, but I don't know when to clean it.
> 
> Hello tejun, I add lagging_periods in iocg based on the original patch,
> to record how many periods this iocg pin lagging. So we can use it to
> avoid letting cmds which take a very long time pin lagging for too long.
> 
> Thanks.
> 
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 33a11ba971ea..998bb38ffb37 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -541,6 +541,8 @@ struct ioc_gq {
>         u64                             indebt_since;
>         u64                             indelay_since;
> 
> +       int                             lagging_periods;
> +
>         /* this iocg's depth in the hierarchy and ancestors including self */
>         int                             level;
>         struct ioc_gq                   *ancestors[];
> @@ -2257,10 +2259,13 @@ static void ioc_timer_fn(struct timer_list *timer)
>                 if ((ppm_rthr != MILLION || ppm_wthr != MILLION) &&
>                     !atomic_read(&iocg_to_blkg(iocg)->use_delay) &&
>                     time_after64(vtime, vdone) &&
> -                   time_after64(vtime, now.vnow -
> -                                MAX_LAGGING_PERIODS * period_vtime) &&
> -                   time_before64(vdone, now.vnow - period_vtime))
> -                       nr_lagging++;
> +                   time_before64(vdone, ioc->period_at_vtime - ioc->margins.target)) {
> +                       if (iocg->lagging_periods < MAX_LAGGING_PERIODS) {
> +                               nr_lagging++;
> +                               iocg->lagging_periods++;
> +                       }
> +               } else if (iocg->lagging_periods)
> +                       iocg->lagging_periods = 0;
> 
>                 /*
>                  * Determine absolute usage factoring in in-flight IOs to avoid
> 

Hi, I tested with this version, previous false laggings are gone. So I wonder
if I should send v2 for review?

Thanks!

> 
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  block/blk-iocost.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index 33a11ba971ea..42e301b7527b 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
>> @@ -2259,7 +2259,7 @@ static void ioc_timer_fn(struct timer_list *timer)
>>  		    time_after64(vtime, vdone) &&
>>  		    time_after64(vtime, now.vnow -
>>  				 MAX_LAGGING_PERIODS * period_vtime) &&
>> -		    time_before64(vdone, now.vnow - period_vtime))
>> +		    time_before64(vdone, ioc->period_at_vtime - ioc->margins.target))
>>  			nr_lagging++;
>>  
>>  		/*
