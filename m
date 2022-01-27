Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511F549DA61
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 06:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbiA0F74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 00:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiA0F7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 00:59:54 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F2BC061714
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 21:59:54 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v13so2675688wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 21:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G8p9n+htg/79lkjPBzyjVNa8biwypRxIALTw6/oqEQI=;
        b=Za26JLsU1BtatOrze/S5zzcABpHZeyndaurLEd67odktXAQRGo4lg7AJTqCVeCifgj
         aJ304MiWYNo4Po/J1LvQY/iu8I5/lYP3kAQkv9V4ZPJGYTECEjX5+dfNDvOfb5aXXbRs
         oYDJeI8qAmMAXgiZJqOVby+OgARgJkusd0VSiEWiC1j8/0TQ2wpJ3QV+LUP/HQyfcA+D
         n7t+ag/Sziw8WcK6/Hb/yhMOB607B8jGqJZsN35izDRDnID6CJ9DVT+E/cueuDOobF90
         tGLRvllv/SuHEdAw01wQd/wCI8uflQC/PkyQYVBtE6u5hXL8I9BAcTHCvf/IDfR3WfTH
         RFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G8p9n+htg/79lkjPBzyjVNa8biwypRxIALTw6/oqEQI=;
        b=DREM43X6+wQWYFe5DNhUiCxzr82ZHkYJuXfNAiLqQNw7Wt4uQS/6z8yJ1AnCDazmiC
         N/Cp8B2+LUBdfB7i6oWc37gVgeWRM4y9K4XnhuAO5VOMW20nS1dEYY5+cZBlw3vOMfSz
         8QfRdNaH9PReYAyG/StPYaj1zcQC7xbpoacOhPcIu8jCiA4WQLU8NTFayHP9L/uTpltx
         7BYJryQEMz5mjxarQw6cEf/fJB3+7O/jLMnm7hV7C43inM53mwZIsLlwGW9omk7kddWm
         Sk5R93ZU6lBXrgrUoSFBnfsiN8MDGRP8iqOizhbB3NBn2yxLhmpTO4R1fr55uct/y1gl
         qiyg==
X-Gm-Message-State: AOAM530IZh5saUVfGi/h1j+j2K3QaFmmktlOAEIuV3gXusXESnFwx7Fk
        VMYJfRr34GNrrgyAIcfQP4T2vQ==
X-Google-Smtp-Source: ABdhPJxpkN+X0z8qoZuuqurO2M6v5ztcgkmZkwhoxudB/VDoodE5ESz0XltB6fblLQcbOpeGeBNIXQ==
X-Received: by 2002:a5d:584e:: with SMTP id i14mr1540824wrf.197.1643263192768;
        Wed, 26 Jan 2022 21:59:52 -0800 (PST)
Received: from ?IPV6:2003:d9:9707:d500:f72a:8d22:e3d4:f73? (p200300d99707d500f72a8d22e3d40f73.dip0.t-ipconnect.de. [2003:d9:9707:d500:f72a:8d22:e3d4:f73])
        by smtp.googlemail.com with ESMTPSA id n13sm1166998wrv.94.2022.01.26.21.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 21:59:52 -0800 (PST)
Message-ID: <c658f8c5-a808-f2f1-2e1e-cfb68dd19d6a@colorfullife.com>
Date:   Thu, 27 Jan 2022 06:59:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm/util.c: Make kvfree() safe for calling while holding
 spinlocks
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>, cgel.zte@gmail.com,
        shakeelb@google.com, rdunlap@infradead.org, dbueso@suse.de,
        unixbhaskar@gmail.com, chi.minghao@zte.com.cn, arnd@arndb.de,
        Zeal Robot <zealci@zte.com.cn>, linux-mm@kvack.org,
        1vier1@web.de, stable@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>
References: <20211222194828.15320-1-manfred@colorfullife.com>
 <20220126185340.58f88e8e1b153b6650c83270@linux-foundation.org>
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20220126185340.58f88e8e1b153b6650c83270@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 1/27/22 03:53, Andrew Morton wrote:
> On Wed, 22 Dec 2021 20:48:28 +0100 Manfred Spraul <manfred@colorfullife.com> wrote:
>
>> One codepath in find_alloc_undo() calls kvfree() while holding a spinlock.
>> Since vfree() can sleep this is a bug.
>>
>> Previously, the code path used kfree(), and kfree() is safe to be called
>> while holding a spinlock.
>>
>> Minghao proposed to fix this by updating find_alloc_undo().
>>
>> Alternate proposal to fix this: Instead of changing find_alloc_undo(),
>> change kvfree() so that the same rules as for kfree() apply:
>> Having different rules for kfree() and kvfree() just asks for bugs.
>>
>> Disadvantage: Releasing vmalloc'ed memory will be delayed a bit.
> I know we've been around this loop a bunch of times and deferring was
> considered.   But I forget the conclusion.  IIRC, mhocko was involved?

I do not remember a mail from mhocko.

Shakeel proposed to use the approach from Chi.

Decision: https://marc.info/?l=linux-kernel&m=164132032717757&w=2

With Reviewed-by:

https://marc.info/?l=linux-kernel&m=164132744522325&w=2
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -610,12 +610,12 @@ EXPORT_SYMBOL(kvmalloc_node);
>>    * It is slightly more efficient to use kfree() or vfree() if you are certain
>>    * that you know which one to use.
>>    *
>> - * Context: Either preemptible task context or not-NMI interrupt.
>> + * Context: Any context except NMI interrupt.
>>    */
>>   void kvfree(const void *addr)
>>   {
>>   	if (is_vmalloc_addr(addr))
>> -		vfree(addr);
>> +		vfree_atomic(addr);
>>   	else
>>   		kfree(addr);
>>   }


