Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25EC467D05
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382427AbhLCSRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:17:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35248 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233009AbhLCSQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638555214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7dzgYUnnXmqI6YYZ1H+a9PomNsLF/wjAkKHffLwa6ac=;
        b=N5M1+QJMsRc71lUhz9BlH72Il2zwkTlUqPZgBY5e3xFp8r4kVSHgDd+hiCccPdkdTtTDZW
        IgogZOZmc8VCnLeHDJ3Sipn1dnnzax/mykDphestN6rwmIXU4PV7Mhec/jGtb3boITMKti
        SU1JiYt2oFp/a00XTqHCObHUX92mt8E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-1_gJO3NDPDu1JnQgf4cY1w-1; Fri, 03 Dec 2021 13:13:34 -0500
X-MC-Unique: 1_gJO3NDPDu1JnQgf4cY1w-1
Received: by mail-wm1-f70.google.com with SMTP id 201-20020a1c04d2000000b003335bf8075fso1922184wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 10:13:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=7dzgYUnnXmqI6YYZ1H+a9PomNsLF/wjAkKHffLwa6ac=;
        b=OxR1cmrUsK9RwQJPtSOFc4+H3z4cAxwWetH28Ll36/Sex0q65PusYoYkDYE4HHEkq6
         EGhB7s2pjwKJ769OyA+PXsinqV8adjewyNx2XoviIifyRV8+eFjds+JllnLnIjIvlADq
         xg414p8XwKRqHo8UVzy3TdLqRFLwKf1SH3DvkAZmJ+uuR0KJpOrICEJZcTW+x1pglVzt
         27bVarw2PrP+nd1TaTJfuhSPwZIxbp1Jl1AOf1zSE1i3/ZQQF57IaRg8XKkHYVLVuywJ
         hcuSNV67pXtIa6arwhOZKpI5H+Xzg4XpWj8Mgmfw+fUKhGBrnhw9Cgt8+oGxWRPUrDYL
         N7gg==
X-Gm-Message-State: AOAM530w+zLVth5lPPkBGB79ZbHcUxgODWzLuQLBtb1EH6geKPwtCyTo
        R3HRZxkPoLMLxhkw0AaIi7nwbwcyVGZJmJXNLAAKbCCq4wks/UECOaEK1incl0TUKRZBvp78Rmt
        H/BiuaJnbB/B4wuFzVpMZQfqy
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr16839749wmq.34.1638555212867;
        Fri, 03 Dec 2021 10:13:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlQzTObk/hk9+jr+MMNRGtLfch/MMPjlS2I6c1elKm0x59UVclr7egOypIDfOXdG7Naygxrw==
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr16839715wmq.34.1638555212592;
        Fri, 03 Dec 2021 10:13:32 -0800 (PST)
Received: from ?IPV6:2003:d8:2f44:9200:3344:447e:353c:bf0b? (p200300d82f4492003344447e353cbf0b.dip0.t-ipconnect.de. [2003:d8:2f44:9200:3344:447e:353c:bf0b])
        by smtp.gmail.com with ESMTPSA id n32sm6760560wms.1.2021.12.03.10.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 10:13:32 -0800 (PST)
Message-ID: <3c971e70-f8c7-4406-d098-74e92f3c7dc4@redhat.com>
Date:   Fri, 3 Dec 2021 19:13:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1] arm64/mm: avoid race condition of update page table
 when kernel init
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Jianyong Wu <Jianyong.Wu@arm.com>
Cc:     Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "gshan@redhat.com" <gshan@redhat.com>,
        Justin He <Justin.He@arm.com>, nd <nd@arm.com>
References: <20211027094828.7629-1-jianyong.wu@arm.com>
 <1cd8e875-24b1-2904-4e9f-2a4eb13674dc@arm.com>
 <AM9PR08MB72767A6DFA5A7ED8117E7C44F4869@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YapXa8JWPNhkePwO@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YapXa8JWPNhkePwO@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.12.21 18:44, Catalin Marinas wrote:
> On Thu, Oct 28, 2021 at 08:36:07AM +0100, Jianyong Wu wrote:
>> From Anshuman Khandual <anshuman.khandual@arm.com>:
>>> On 10/27/21 3:18 PM, Jianyong Wu wrote:
>>>> Race condition of page table update can happen in kernel boot period
>>>> as both of memory hotplug action when kernel init and the
>>>> mark_rodata_ro can update page table. For virtio-mem, the function excute flow chart is:
>>>>
>>>> -------------------------
>>>> kernel_init
>>>>   kernel_init_freeable
>>>>     ...
>>>>       do_initcall
>>>>         ...
>>>>           module_init [A]
>>>>
>>>>   ...
>>>>   mark_readonly
>>>>     mark_rodata_ro [B]
>>>> -------------------------
> [...]
>>>> We can see that the error derived from the l3 translation as the pte
>>>> value is *0*. That is because the fixmap has been clear when access.
>>>>
>>>> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
>>>> ---
>>>>  arch/arm64/mm/mmu.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c index
>>>> cfd9deb347c3..567dfba8f08a 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -564,8 +564,10 @@ void mark_rodata_ro(void)
>>>>      * to cover NOTES and EXCEPTION_TABLE.
>>>>      */
>>>>     section_size = (unsigned long)__init_begin - (unsigned long)__start_rodata;
>>>> +   get_online_mems();
>>>>     update_mapping_prot(__pa_symbol(__start_rodata), (unsigned long)__start_rodata,
>>>>                         section_size, PAGE_KERNEL_RO);
>>>> +   put_online_mems();
>>>>
>>>>     debug_checkwx();
>>>>  }
>>>
>>> While this should solve the current problem i.e race between concurrent
>>> memory hotplug operation and mark_rodata_ro(), but I am still wondering
>>> whether this is the fix at the right place and granularity. Basically a hotplug
>>> operation queued in an work queue at [A] can execute during [B] is the root
>>> cause of this problem.
>>
>> Not exactly, this issue doesn't only happen at the the *pure* kernel
>> boot. For example, hotplug memory through VM monitor when VM boot. We
>> can't foresee when that happen. Thus, this issue can affect all kinds
>> of memory hotplug mechanism, including ACPI based memory hotplug and
>> virtio-mem. I'm not sure that fix it here is the best way. If the race
>> only happens between kernel init and memory hotplug, I think it's fine
>> to fix it here. IMO, this issue results from the race for "fixmap"
>> resource. I wonder why this global resource is not protected by a
>> lock. Maybe we can add one and fix it there.
> 
> IIUC the race is caused by multiple attempts to use the fixmap at the
> same time. We can add a fixmap_lock and hold it during
> __create_pgd_mapping().
> 

IIRC that's something along the lines I suggested, so, yes :)

-- 
Thanks,

David / dhildenb

