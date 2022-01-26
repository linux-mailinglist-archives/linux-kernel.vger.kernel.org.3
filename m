Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9900649C750
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbiAZKRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:17:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239894AbiAZKRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643192266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SILyOQqKrzuALl9m/eqyPTkpkJunL5lLtYUAWYstulM=;
        b=VO3aIX8GRTLh08n4VhFPBLlGsop8SwD5KqWG0W7bDaUr0J1P3PWubkDqkqDFPpQF9yhVj1
        AVBxUVfNtYD06LcvNFoTEo9ZjH/3CT1G1GK7E25cBi8pjqX0xn6eqwah7cGOLulOUOFDch
        z6NXYckntVS4pqjrupNi46yyeTJiHy4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-eIb-Zqa2NK-S7ExpcDV2ZA-1; Wed, 26 Jan 2022 05:17:45 -0500
X-MC-Unique: eIb-Zqa2NK-S7ExpcDV2ZA-1
Received: by mail-wm1-f72.google.com with SMTP id i26-20020a1c541a000000b0034dc8bd7078so6524360wmb.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=SILyOQqKrzuALl9m/eqyPTkpkJunL5lLtYUAWYstulM=;
        b=l0sk6jAcOUGbPgOdTCE1MlLlIOCtGbMPYGNQ2w0ZE51kGi68TWziJzV7mjAnhbMbcq
         lefHUorc/nmyP7rD0Jhhwo7pgcFP3bvvpFcWlJRRa26X5fYe3ZVV3Wm01YmppUViQ9rl
         KKOfQF7Mvgsb/nIMNbMXhYv5tsYkCfuuvBqqvpSe1f/oqoh6eQHVET+5MJO/yj+QjiSn
         gS35TqLVXml5zlGwCO67wlhKZdWZqrnphzYTKlJXe0aZsMn5CTnW1NE0ubYXH2jmrIUP
         q7xDbUNNnCeNAuFz7fr2vdykx1qLnUGguwgfEVxMNzxP5uFDPnqEp65yllKBIlChh/IG
         jJKg==
X-Gm-Message-State: AOAM532QxyiaLBD6PDybqz5xZd2CWviPOESHf7/nYuUIX+qAlfCy3m6w
        5XE6GmmdnA11T95on80mAboHo+qWFPi9eDoyIppBT8OhWcUyg4sMXrJ2xJJeFBd0LS29HLgCXAD
        YsN26eP5nFjbgIVPf0uFFkh+S
X-Received: by 2002:a5d:6190:: with SMTP id j16mr22342941wru.471.1643192264241;
        Wed, 26 Jan 2022 02:17:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPITbtNxwMRyOvup3XQ/BmJaIQPNmfEryURdj55eCY/UP2rFdKRH2JcVV8T8UOHULQZ29/gQ==
X-Received: by 2002:a5d:6190:: with SMTP id j16mr22342928wru.471.1643192264026;
        Wed, 26 Jan 2022 02:17:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:2700:cdd8:dcb0:2a69:8783? (p200300cbc7092700cdd8dcb02a698783.dip0.t-ipconnect.de. [2003:cb:c709:2700:cdd8:dcb0:2a69:8783])
        by smtp.gmail.com with ESMTPSA id 8sm23765087wrz.57.2022.01.26.02.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 02:17:43 -0800 (PST)
Message-ID: <3e6513f9-77ca-79e5-d185-7e9a11ec7689@redhat.com>
Date:   Wed, 26 Jan 2022 11:17:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, Jianyong Wu <Jianyong.Wu@arm.com>
Cc:     Justin He <Justin.He@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_qiancai@quicinc.com" <quic_qiancai@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>, nd <nd@arm.com>
References: <20211216082812.165387-1-jianyong.wu@arm.com>
 <YdXdjcJ7jbnkFsqp@arm.com>
 <AM9PR08MB7276E0DE6B4224C22B20A89CF44C9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdcRLohx777jzWah@arm.com>
 <AM9PR08MB7276B412F02CA0431E30E06CF44D9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdgZJ/mBG+BCxmEv@arm.com>
 <DB7PR08MB3737631DEE8D6625D3A9E393F7209@DB7PR08MB3737.eurprd08.prod.outlook.com>
 <CAMj1kXF7DJ5UeMn=9gw_Hs3Fa525OFEPsriO=ZprT3rN83=qtQ@mail.gmail.com>
 <AM9PR08MB72763D5DA0C5F22D2126ABF4F4209@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <CAMj1kXGjAxd2xb0u1PLSLGAe8jJdhJm3wR+y=7qB4C1J6Ebgcw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAMj1kXGjAxd2xb0u1PLSLGAe8jJdhJm3wR+y=7qB4C1J6Ebgcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.01.22 11:12, Ard Biesheuvel wrote:
> On Wed, 26 Jan 2022 at 11:09, Jianyong Wu <Jianyong.Wu@arm.com> wrote:
>>
>> Hi Ard,
>>
>>> -----Original Message-----
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>> Sent: Wednesday, January 26, 2022 4:37 PM
>>> To: Justin He <Justin.He@arm.com>
>>> Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Jianyong Wu
>>> <Jianyong.Wu@arm.com>; will@kernel.org; Anshuman Khandual
>>> <Anshuman.Khandual@arm.com>; akpm@linux-foundation.org;
>>> david@redhat.com; quic_qiancai@quicinc.com; linux-
>>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>> gshan@redhat.com; nd <nd@arm.com>
>>> Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create
>>> pud mapping
>>>
>>> On Wed, 26 Jan 2022 at 05:21, Justin He <Justin.He@arm.com> wrote:
>>>>
>>>> Hi Catalin
>>>>
>>>>> -----Original Message-----
>>>>> From: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Sent: Friday, January 7, 2022 6:43 PM
>>>>> To: Jianyong Wu <Jianyong.Wu@arm.com>
>>>>> Cc: will@kernel.org; Anshuman Khandual
>>> <Anshuman.Khandual@arm.com>;
>>>>> akpm@linux-foundation.org; david@redhat.com;
>>>>> quic_qiancai@quicinc.com; ardb@kernel.org;
>>>>> linux-kernel@vger.kernel.org; linux-arm- kernel@lists.infradead.org;
>>>>> gshan@redhat.com; Justin He <Justin.He@arm.com>; nd <nd@arm.com>
>>>>> Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when
>>>>> create pud mapping
>>>>>
>>>>> On Fri, Jan 07, 2022 at 09:10:57AM +0000, Jianyong Wu wrote:
>>>>>> Hi Catalin,
>>>>>>
>>>>>> I roughly find the root cause.
>>>>>>  alloc_init_pud will be called at the very beginning of kernel
>>>>>> boot in
>>>>> create_mapping_noalloc where no memory allocator is initialized. But
>>>>> lockdep check may need allocate memory. So, kernel take exception
>>>>> when acquire lock.(I have not found the exact code that cause this
>>>>> issue) that's say we may not be able to use a lock so early.
>>>>>>
>>>>>> I come up with 2 methods to address it.
>>>>>> 1) skip dead lock check at the very beginning of kernel boot in
>>>>>> lockdep
>>>>> code.
>>>>>> 2) provided 2 two versions of __create_pgd_mapping, one with lock
>>>>>> in it and the other without. There may be no possible of race for
>>>>>> memory mapping at the very beginning time of kernel boot, thus we
>>>>>> can use the no lock version of __create_pgd_mapping safely.
>>>>>> In my test, this issue is gone if there is no lock held in
>>>>>> create_mapping_noalloc. I think create_mapping_noalloc is called
>>>>>> early enough to avoid the race conditions of memory mapping,
>>>>>> however, I have not proved it.
>>>>>
>>>>> I think method 2 would work better but rather than implementing new
>>>>> nolock functions I'd add a NO_LOCK flag and check it in
>>>>> alloc_init_pud() before mutex_lock/unlock. Also add a comment when
>>>>> passing the NO_LOCK flag on why it's needed and why there wouldn't
>>>>> be any races at that stage (early boot etc.)
>>>>>
>>>> The problematic code path is:
>>>> __primary_switched
>>>>         early_fdt_map->fixmap_remap_fdt
>>>>                 create_mapping_noalloc->alloc_init_pud
>>>>                         mutex_lock (with Jianyong's patch)
>>>>
>>>> The problem seems to be that we will clear BSS segment twice if kaslr
>>>> is enabled. Hence, some of the static variables in lockdep init
>>>> process were messed up. That is to said, with kaslr enabled we might
>>>> initialize lockdep twice if we add mutex_lock/unlock in alloc_init_pud().
>>>>
>>>
>>> Thanks for tracking that down.
>>>
>>> Note that clearing the BSS twice is not the root problem here. The root
>>> problem is that we set global state while the kernel runs at the default link
>>> time address, and then refer to it again after the entire kernel has been
>>> shifted in the kernel VA space. Such global state could consist of mutable
>>> pointers to statically allocated data (which would be reset to their default
>>> values after the relocation code runs again), or global pointer variables in BSS.
>>> In either case, relying on such a global variable after the second relocation
>>> performed by KASLR would be risky, and so we should avoid manipulating
>>> global state at all if it might involve pointer to statically allocated data
>>> structures.
>>>
>>>> In other ways, if we invoke mutex_lock/unlock in such a early booting stage.
>>>> It might be unsafe because lockdep inserts lock_acquire/release as the
>>>> complex hooks.
>>>>
>>>> In summary, would it better if Jianyong splits these early boot and
>>>> late boot case? e.g. introduce a nolock version for
>>> create_mapping_noalloc().
>>>>
>>>> What do you think of it?
>>>>
>>>
>>> The pre-KASLR case definitely doesn't need a lock. But given that
>>> create_mapping_noalloc() is only used to map the FDT, which happens very
>>> early one way or the other, wouldn't it be better to move the lock/unlock
>>> into other callers of __create_pgd_mapping()? (and make sure no other
>>> users of the fixmap slots exist)
>>
>> There are server callers of __create_pgd_mapping. I think some of them need no fixmap lock as they are called so early. I figure out all of them here:
>> create_mapping_noalloc:   no lock
>> create_pgd_mapping:   no lock
>> __map_memblock:    no lock
>> map_kernel_segment:  no lock
>> map_entry_trampoline: no lock
>> update_mapping_prot:    need lock
>> arch_add_memory:  need lock
>>
>> WDYT?
>>
> 
> That seems reasonable, but it needs to be documented clearly in the code.
> 

Just a random thought, could we rely on system_state to do the locking
conditionally?

-- 
Thanks,

David / dhildenb

