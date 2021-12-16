Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614C34775FE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbhLPPbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbhLPPbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:31:42 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA14AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:31:41 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso23003357pjl.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=l6LvE0tdF/ri+A9zgAE580bkzjjff8YwYMCAYxHLAzE=;
        b=mvOdgs8ysGAbyp7kwJo0T2wfPEL8nOZFTDV1Tnc0v0NJMLV3AHJpFONGmI6pQtX7gA
         AWlPBvlx9uY8166HJKOjHkoitFySnuaPr0ieOqxyatwT31mAQMfpdzHW28N5NZu+WD24
         R2wBQhcWs7CdjLddFZyLw1fPgFVfjrEwHKaZ+lo7m9e9O51718RJ+sS3lKXzxLyWCrfc
         aixARH4dzBrMVsD7zRxo9+iSMX5TgaZu8S3/P+mTi4WO6Bh8XN7YEtCPHsLgRHsGQrmF
         lMPhNa9Z7IDBzpPniaXtNDtaK3drXmSnPgxAZueJSGEEJW1Vr3r+/aCwulEXGFR3g/Gk
         LTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l6LvE0tdF/ri+A9zgAE580bkzjjff8YwYMCAYxHLAzE=;
        b=MN9yqn7xuJwZe/NKwLReRd2AzcSghBjEVhL63VyCaKZ9OKa6zlEq3ucEVNWsrf2qfT
         VKDRbaOYA2nl8jBXo01m6wLwutrCEdBRFIGNoLSOraiVsNNHE+n8yU+tZ81JQOY7CIQu
         Pleu+Ata3quJId+vGO56YcKu1VPLE2JLNWrvo02skxo4RAEMs5nHsYqHctUYzFlqKcKl
         OKpmdzggLH9sxOO7jugvH2fxAOptiFVOFdx3SKiroxKZoE9AyrfJD3FEU0cwaCRvr1PE
         GUON4io3ZXnRSjFBI1PqTQL58CkJopS9jpo2HmAw7xU3/+x88L2xG6dbtwaf2O37o5mY
         d5aw==
X-Gm-Message-State: AOAM531XKY0XJ3g/XDG3SoLHuFFDXKBoiznxuWi016LbjNFyBOLrkrX/
        M2QbRTUjHIZ1WN98yVP4gQNw+w==
X-Google-Smtp-Source: ABdhPJyB7csupnNgQv6T0IUbYKW6vNSHYJMhs8CvsQBg79ExMKklWow9wrwx8W3a3lGXUelF1IOaKg==
X-Received: by 2002:a17:903:1208:b0:143:e4e9:4ce3 with SMTP id l8-20020a170903120800b00143e4e94ce3mr16458248plh.21.1639668701217;
        Thu, 16 Dec 2021 07:31:41 -0800 (PST)
Received: from [10.255.28.103] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id q10sm6869782pfk.180.2021.12.16.07.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 07:31:40 -0800 (PST)
Message-ID: <34cc2f26-9fba-f7c6-5dae-d21498ccbe2d@bytedance.com>
Date:   Thu, 16 Dec 2021 23:31:36 +0800
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
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Ybs8P3WcPtShi15o@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/21 9:16 PM, Greg KH wrote:
> On Thu, Dec 16, 2021 at 08:46:54PM +0800, Qi Zheng wrote:
>> In /proc/meminfo, we can show the sum of all the available memory
>> as "MemAvailable". Add the same counter also to per-node meminfo
>> under /sys.
>>
>> With this counter, some processes that bind nodes can make some
>> decisions by reading the "MemAvailable" of the corresponding nodes
>> directly.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   drivers/base/node.c    |  4 ++++
>>   include/linux/mm.h     |  1 +
>>   include/linux/mmzone.h |  5 +++++
>>   mm/page_alloc.c        | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 59 insertions(+)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index 87acc47e8951..deb2a7965ae4 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -375,8 +375,10 @@ static ssize_t node_read_meminfo(struct device *dev,
>>   	struct sysinfo i;
>>   	unsigned long sreclaimable, sunreclaimable;
>>   	unsigned long swapcached = 0;
>> +	long available;
>>   
>>   	si_meminfo_node(&i, nid);
>> +	available = si_mem_available_node(&i, nid);
>>   	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
>>   	sunreclaimable = node_page_state_pages(pgdat, NR_SLAB_UNRECLAIMABLE_B);
>>   #ifdef CONFIG_SWAP
>> @@ -386,6 +388,7 @@ static ssize_t node_read_meminfo(struct device *dev,
>>   			    "Node %d MemTotal:       %8lu kB\n"
>>   			    "Node %d MemFree:        %8lu kB\n"
>>   			    "Node %d MemUsed:        %8lu kB\n"
>> +			    "Node %d MemAvailable:   %8lu kB\n"
> 
> You just changed a user/kernel api without documenting it anywhere, or
> ensuring that you did not just break anything.

Hi greg k-h,

The MemAvailable has long existed in the /proc/meminfo, it's meaning
has been described in the Documentation/filesystems/proc.rst. Since
the semantics of per-node MemAvailable has not changed, so I did not
add a new document description.

> 
> Also, this api is crazy, and not ok, please never add anything new to
> it, it is broken as-is.

The consideration of adding per-node MemAvailable is that some processes
that bind nodes need this information to do some decisions.

Now their approach is to read other information in per-node meminfo
and /proc/sys/vm/watermark_scale_factor, and then approximate this
value. With this counter, they can directly read
/sys/devices/system/node/node*/meminfo to get the MemAvailable
information of each node.

And MemTotal, MemFree and SReclaimable(etc.) all have corresponding
per-node versions, so I think that adding per-node MemAvailable might
also make sense. :)

Thanks,
Qi

> 
> thanks,
> 
> greg k-h
> 

-- 
Thanks,
Qi
