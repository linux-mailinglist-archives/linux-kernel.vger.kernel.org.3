Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDB451EF56
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiEHTGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244940AbiEHSqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:46:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E473B85F;
        Sun,  8 May 2022 11:42:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s14so11988909plk.8;
        Sun, 08 May 2022 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IMO3JIMi22IO+hwWBmWKXtb8kUpSnjqE7Vl3ahEaqwI=;
        b=K8N5U77Yr6n4pHiUjWYuQl7IfGe4W8zWHrZoWQJBeu/1bJVfNUxsb3zRetjDM6lYLk
         hazhGdYvcyPSMbsTy6QZcLCBsA4Lq3I894wxZ9NB2h/2gmKMp43uiB6X2Zsi58kuoTx4
         0yFzTOWeS1AP/VMfGeZwHTsSa5eGiNR2hCq7947GWfBFOJ7mq0L8+6dj7QvEt+WB8Izm
         WMNd7PpWoyohy9dxeL6gwWc8Y0a6iCQY867QiYW4CSFTwzF9vfFl6A1JSr1/uwKZkupr
         Oiw7qsIynoUGRj3h/0xG6fvB4OOQpHmLxh+MXpzC5mRzfwaowCsjFm7OD9UMx+lzkPtr
         zOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IMO3JIMi22IO+hwWBmWKXtb8kUpSnjqE7Vl3ahEaqwI=;
        b=ksNSeEtGo7v4TArHC/4KYA/KQu3LYBlPqqNZCKoCa9sA00js7aoCOnwSEhoks8zYZr
         QhdmlCvOvIgrQv72dmuh608va3QyYYFB2ddg2DeQLJDxLLzb2PvlFtUFKL+4YfKPlYvK
         FErNbnj0kKyzu4HMXNHiwNNa7W76sR0cN3DyDkBvIJNtUC5ZaWh1JTetx37bWksKriED
         uljf03OzElSt1PV99AbG4VZtBqyqRi4yFMCuWybu7whNLTbU+su1x11JgOzs3ff4iPBd
         6A8/6A5nQULAxeM6z0QZ5lC0tF/J55YWiZTsQd73ulzRHPUHddM+M8yVQWKRurxmhBw2
         pXSQ==
X-Gm-Message-State: AOAM53141apoL6WPT8f64kxIi4XvTGg7KOCdEDGQF4HQTc3xfIMdB29o
        zrWS0wXOIESDeV9H1zgAl9ntdgea+7ZX7g==
X-Google-Smtp-Source: ABdhPJz5w8CFl7rCXPIolx29bkbpweJz41F2IEFIvYrs59TbolXN5i67/eGp5kjzMSaZWwXM+IPiDA==
X-Received: by 2002:a17:902:e5d2:b0:15e:9467:187 with SMTP id u18-20020a170902e5d200b0015e94670187mr13183152plf.123.1652035329537;
        Sun, 08 May 2022 11:42:09 -0700 (PDT)
Received: from [172.30.1.41] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id 2-20020aa79242000000b0050dc762813csm6968013pfp.22.2022.05.08.11.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 11:42:09 -0700 (PDT)
Message-ID: <fa739928-ed1d-ed6f-52c2-541319d9cc2f@gmail.com>
Date:   Mon, 9 May 2022 03:42:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 2/2] PM / devfreq: rk3399_dmc: Block PMU during
 transitions
Content-Language: en-US
To:     Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20220406014842.2771799-1-briannorris@chromium.org>
 <582e3645-b24e-356e-7f0f-0d37bb1e32e6@gmail.com>
 <6c6ec0db-111c-e48f-57ce-0e444a0d168e@gmail.com> <44651538.fMDQidcC6G@phil>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <44651538.fMDQidcC6G@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 5. 9. 00:07, Heiko Stuebner wrote:
> Am Samstag, 7. Mai 2022, 16:21:59 CEST schrieb Chanwoo Choi:
>> On 22. 4. 14. 08:13, Chanwoo Choi wrote:
>>> On 22. 4. 14. 07:45, Heiko Stübner wrote:
>>>> Hi,
>>>>
>>>> Am Donnerstag, 14. April 2022, 00:14:40 CEST schrieb Chanwoo Choi:
>>>>> On 22. 4. 6. 10:48, Brian Norris wrote:
>>>>>> See the previous patch ("soc: rockchip: power-domain: Manage resource
>>>>>> conflicts with firmware") for a thorough explanation of the conflicts.
>>>>>> While ARM Trusted Firmware may be modifying memory controller and
>>>>>> power-domain states, we need to block the kernel's power-domain driver.
>>>>>>
>>>>>> If the power-domain driver is disabled, there is no resource conflict
>>>>>> and this becomes a no-op.
>>>>>>
>>>>>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>>>>>> ---
>>>>>>
>>>>>>     drivers/devfreq/rk3399_dmc.c | 13 +++++++++++++
>>>>>>     1 file changed, 13 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/devfreq/rk3399_dmc.c
>>>>>> b/drivers/devfreq/rk3399_dmc.c
>>>>>> index e494d1497d60..daff40702615 100644
>>>>>> --- a/drivers/devfreq/rk3399_dmc.c
>>>>>> +++ b/drivers/devfreq/rk3399_dmc.c
>>>>>> @@ -21,6 +21,7 @@
>>>>>>     #include <linux/rwsem.h>
>>>>>>     #include <linux/suspend.h>
>>>>>> +#include <soc/rockchip/pm_domains.h>
>>>>>>     #include <soc/rockchip/rk3399_grf.h>
>>>>>>     #include <soc/rockchip/rockchip_sip.h>
>>>>>> @@ -93,6 +94,16 @@ static int rk3399_dmcfreq_target(struct device
>>>>>> *dev, unsigned long *freq,
>>>>>>         mutex_lock(&dmcfreq->lock);
>>>>>> +    /*
>>>>>> +     * Ensure power-domain transitions don't interfere with ARM
>>>>>> Trusted
>>>>>> +     * Firmware power-domain idling.
>>>>>> +     */
>>>>>> +    err = rockchip_pmu_block();
>>>>>> +    if (err) {
>>>>>> +        dev_err(dev, "Failed to block PMU: %d\n", err);
>>>>>> +        goto out_unlock;
>>>>>> +    }
>>>>>> +
>>>>>>         /*
>>>>>>          * Some idle parameters may be based on the DDR controller
>>>>>> clock, which
>>>>>>          * is half of the DDR frequency.
>>>>>> @@ -198,6 +209,8 @@ static int rk3399_dmcfreq_target(struct device
>>>>>> *dev, unsigned long *freq,
>>>>>>         dmcfreq->volt = target_volt;
>>>>>>     out:
>>>>>> +    rockchip_pmu_unblock();
>>>>>> +out_unlock:
>>>>>>         mutex_unlock(&dmcfreq->lock);
>>>>>>         return err;
>>>>>>     }
>>>>>
>>>>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>
>>>> so I guess you're ok with me picking up both patches, right?
>>>> [Just making sure :-) ]
>>>
>>> This patch have the dependency of latest devfreq-next branch.
>>> So that need to make the immutable branch between rockchip and devfreq.
>>>
>>
>> Hi Heiko and Brian,
>>
>> Is there any other progress?
>>
>> IMHO, if rockchip maintainer reply the acked-by from patch1
>> and then agree these patches to be applied to devfreq.git,
>> I can take them.
> 
> sounds good to me. Patch1 looks good and correct to me, so
> I've added a Reviewed-by for it and it defintily makes sense for
> both to go through the devfreq tree then, so we don't need
> additional stable-branches :-)

OK. I'll take them with your reviewed-by tag. Thanks.


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
