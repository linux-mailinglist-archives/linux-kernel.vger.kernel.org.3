Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B7F477630
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbhLPPn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhLPPn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:43:28 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E3FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:43:27 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n15-20020a17090a394f00b001b0f6d6468eso2940822pjf.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=DvAPGtEpiVuU2kvz5o3dTRnY8wThKOHqUQeQ2z/x2nI=;
        b=TDw2lsfmLNMlPpF/QUBVtH96UAWZMsN2GODesQ5HklEqtoo0QugXSDaDPwbEd4RnWy
         8eDBR1nDxvH2lPAMAWSabqcQU12Rvhfw7X2c6voSULc6AiieTCIJBIA9yydPw92UdAe2
         +adEr8c4TaqyrlVHL0zY6KGeGEeBAghwQMMWeSfwK9f3NwUwE00h+PFpdPRlQUHWiepY
         0HY8aT7QWedjpygs9ZDS+GzVpWEtN78WlRyCyHkTGO94sMuCghojbVHhHnq0be/wa8Ws
         d5MMQpkOu2xeFC90SUHL4e7DBwx83a0qDVrNGDcc1NwFymh2OqM4/GvnCM4uOi4U194a
         LnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DvAPGtEpiVuU2kvz5o3dTRnY8wThKOHqUQeQ2z/x2nI=;
        b=fULMfkUVr6pO6jHH0UHOgC7hDVXWGeYgXmYJfq2DIO0WssWvDs5of7+PFCqtmCqASQ
         JMKiibyodTd6inPJcsobHUHvYV0PxF8W3lpQVA9qXTIH9+TSh46UiDf/ksNkqQpRe/7A
         ZlXDHZIjzTcXqMw+7XMDx56ezk6+S9sKRSczq80+jNYxGFfKtxOJfBEwrp/0Pt1vFyEa
         kBZMFS7gJqedGOmtbgQrArh2J3vNgiEkUPKK11LGo7Q4IrNjMMLBFWd1eiN2WfETyHZA
         xIa93C2mQENnCGBDGyd2kiVM0d5DqVfrDEX4dg4O749pzQ7TTLe8aogqAiNERqjlma5x
         mDYQ==
X-Gm-Message-State: AOAM531SvbhKMeHNvr/uJ8jSGXvhlN/Ct26NM7Cad8PFb2X9MZA2pvVw
        wpu4MPVRmc1T8Moos59D6Cjtcnasi5fN4A==
X-Google-Smtp-Source: ABdhPJw9xZUGD7sedtpr2wZO0uk5qeTLPkVOD4gbQBdsF2irncVIbC4KF0hJQDMYHvMkGBrFf32Buw==
X-Received: by 2002:a17:90a:b103:: with SMTP id z3mr6719356pjq.23.1639669407379;
        Thu, 16 Dec 2021 07:43:27 -0800 (PST)
Received: from [10.255.28.103] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id j1sm6944895pfu.47.2021.12.16.07.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 07:43:27 -0800 (PST)
Message-ID: <917bb0a2-acb5-f2af-317b-73f1fa60f22d@bytedance.com>
Date:   Thu, 16 Dec 2021 23:43:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 1/2] mm: add MemAvailable to per-node meminfo
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, rafael@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20211216124655.32247-1-zhengqi.arch@bytedance.com>
 <20211216124655.32247-2-zhengqi.arch@bytedance.com>
 <Ybs8P3WcPtShi15o@kroah.com>
 <34cc2f26-9fba-f7c6-5dae-d21498ccbe2d@bytedance.com>
 <YbtdIpJal3keEWf8@kroah.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <YbtdIpJal3keEWf8@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/21 11:37 PM, Greg KH wrote:
> On Thu, Dec 16, 2021 at 11:31:36PM +0800, Qi Zheng wrote:
>>
>>
>> On 12/16/21 9:16 PM, Greg KH wrote:
>>> On Thu, Dec 16, 2021 at 08:46:54PM +0800, Qi Zheng wrote:
>>>> In /proc/meminfo, we can show the sum of all the available memory
>>>> as "MemAvailable". Add the same counter also to per-node meminfo
>>>> under /sys.
>>>>
>>>> With this counter, some processes that bind nodes can make some
>>>> decisions by reading the "MemAvailable" of the corresponding nodes
>>>> directly.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>>    drivers/base/node.c    |  4 ++++
>>>>    include/linux/mm.h     |  1 +
>>>>    include/linux/mmzone.h |  5 +++++
>>>>    mm/page_alloc.c        | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    4 files changed, 59 insertions(+)
>>>>
>>>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>>>> index 87acc47e8951..deb2a7965ae4 100644
>>>> --- a/drivers/base/node.c
>>>> +++ b/drivers/base/node.c
>>>> @@ -375,8 +375,10 @@ static ssize_t node_read_meminfo(struct device *dev,
>>>>    	struct sysinfo i;
>>>>    	unsigned long sreclaimable, sunreclaimable;
>>>>    	unsigned long swapcached = 0;
>>>> +	long available;
>>>>    	si_meminfo_node(&i, nid);
>>>> +	available = si_mem_available_node(&i, nid);
>>>>    	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
>>>>    	sunreclaimable = node_page_state_pages(pgdat, NR_SLAB_UNRECLAIMABLE_B);
>>>>    #ifdef CONFIG_SWAP
>>>> @@ -386,6 +388,7 @@ static ssize_t node_read_meminfo(struct device *dev,
>>>>    			    "Node %d MemTotal:       %8lu kB\n"
>>>>    			    "Node %d MemFree:        %8lu kB\n"
>>>>    			    "Node %d MemUsed:        %8lu kB\n"
>>>> +			    "Node %d MemAvailable:   %8lu kB\n"
>>>
>>> You just changed a user/kernel api without documenting it anywhere, or
>>> ensuring that you did not just break anything.
>>
>> Hi greg k-h,
>>
>> The MemAvailable has long existed in the /proc/meminfo, it's meaning
>> has been described in the Documentation/filesystems/proc.rst. Since
>> the semantics of per-node MemAvailable has not changed, so I did not
>> add a new document description.
> 
> This is not a proc file, it is in sysfs.
> 
> And it violates all of the sysfs rules, and has all of the problems that
> proc files have.  So the worst of both worlds :(
> 
>>> Also, this api is crazy, and not ok, please never add anything new to
>>> it, it is broken as-is.
>>
>> The consideration of adding per-node MemAvailable is that some processes
>> that bind nodes need this information to do some decisions.
>>
>> Now their approach is to read other information in per-node meminfo
>> and /proc/sys/vm/watermark_scale_factor, and then approximate this
>> value. With this counter, they can directly read
>> /sys/devices/system/node/node*/meminfo to get the MemAvailable
>> information of each node.
>>
>> And MemTotal, MemFree and SReclaimable(etc.) all have corresponding
>> per-node versions, so I think that adding per-node MemAvailable might
>> also make sense. :)
> 
> Please no, I do not want new things added to this file, as you might
> break parsers of this file.

OK, Got it.

Thank,
Qi

> 
> Also, again, you did not document this at all in Documentation/ABI/ so
> for that reason alone it is not ok.
> 
> thanks,
> 
> greg k-h
> 

-- 
Thanks,
Qi
