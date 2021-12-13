Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7074721D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhLMHhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:37:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230053AbhLMHhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639381028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HG5GXt2X3txUdKV6Wl9T8pkiLGxRuVFP50xZy6gQCPI=;
        b=SSOXogj0Eg9NAgpyp6xHdY4S02jTqtYBZSdOrlwxeZWFtbgvgLVIC7IiOGWoVTpezfrGY3
        bN/vDiWupOkXIP5dlzu372EYnH+Wg1K/8ZQisQmnHBd9Ts+66hcqHAkSVQReFP09nofdaR
        /wVUAOvHkPhvIAgUIdHdMdefzsq4qMw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-XDprZHNUNwmGmdGSJs5LUg-1; Mon, 13 Dec 2021 02:37:07 -0500
X-MC-Unique: XDprZHNUNwmGmdGSJs5LUg-1
Received: by mail-wr1-f71.google.com with SMTP id f3-20020a5d50c3000000b00183ce1379feso3556737wrt.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=HG5GXt2X3txUdKV6Wl9T8pkiLGxRuVFP50xZy6gQCPI=;
        b=x46jgohhBRyEu+DJkDScCDTdEofeoCUlG6Z1jxvt9lln/nCi5oA7Ls4BHicLddtq2W
         cpWnd8PN7MET22JARJvDzy8rYio6i//+U0bdE4Wy1lTJInrh8akT/KCLuhDh+oHSHpn6
         68OlKf9i130/tKlBOSgmn1fQYusHUxITzJ3y6Z9R0yK7A4JkMkKZVmB6ZLemjsf67fOb
         CL93uYeqjzMax9U07DkogkxT7mNFdUWX1kXyfGRSiQA7giBqyrr8XbSSO051v7ZcngBH
         ca9YEzHkpoiK7QO7Qo2efcGv5mCkFyuVC0EnywVWEYlWwCORhgFgMQZWp/byUSalBAzc
         AsUQ==
X-Gm-Message-State: AOAM533I4CHZ2ZeQ8raSMYEsKmShwqXBYxYyrgKGNXHO312bFxpeqa1/
        /0X023r6ulV3ghdEXJMcF7+gq210rP+FDLSJx2uyQlFUv2wVZn21F3hM88tQQ5nlF9nSfnGtdq7
        AXuRKeIfcH14Dk1MAVDB4AUiC
X-Received: by 2002:a1c:7f43:: with SMTP id a64mr35961254wmd.133.1639381026575;
        Sun, 12 Dec 2021 23:37:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzELkYNz/2adwZUHSUUG9XDtH76JyPqxjTL2ad3vfwMERgieLxcHKAA9dThvvLRhPxv+xoWbg==
X-Received: by 2002:a1c:7f43:: with SMTP id a64mr35961235wmd.133.1639381026356;
        Sun, 12 Dec 2021 23:37:06 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6276.dip0.t-ipconnect.de. [91.12.98.118])
        by smtp.gmail.com with ESMTPSA id t8sm7581987wmq.32.2021.12.12.23.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 23:37:06 -0800 (PST)
Message-ID: <3366ba9f-5993-1c52-de0c-53e618f20cd8@redhat.com>
Date:   Mon, 13 Dec 2021 08:37:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud
 mapping
Content-Language: en-US
To:     Jianyong Wu <Jianyong.Wu@arm.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "ardb@kernel.org" <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>,
        Justin He <Justin.He@arm.com>, nd <nd@arm.com>
References: <20211210095432.51798-1-jianyong.wu@arm.com>
 <f9b090b9-d730-c3d0-ef6f-5170d9809026@arm.com>
 <AM9PR08MB7276135C8586C80BD51A5A68F4749@AM9PR08MB7276.eurprd08.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <AM9PR08MB7276135C8586C80BD51A5A68F4749@AM9PR08MB7276.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.12.21 08:27, Jianyong Wu wrote:
> 
> 
>> -----Original Message-----
>> From: Anshuman Khandual <anshuman.khandual@arm.com>
>> Sent: Monday, December 13, 2021 2:56 PM
>> To: Jianyong Wu <Jianyong.Wu@arm.com>; Catalin Marinas
>> <Catalin.Marinas@arm.com>; will@kernel.org; akpm@linux-foundation.org
>> Cc: ardb@kernel.org; linux-kernel@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; david@redhat.com; gshan@redhat.com; Justin
>> He <Justin.He@arm.com>; nd <nd@arm.com>
>> Subject: Re: [PATCH v2] arm64/mm: avoid fixmap race condition when create
>> pud mapping
>>
>>
>>
>> On 12/10/21 3:24 PM, Jianyong Wu wrote:
>>> fixmap is a global resource and is used recursively in create pud mapping.
>>> It may lead to race condition when alloc_init_pud is called concurrently.
>>>
>>> Fox example:
>>> alloc_init_pud is called when kernel_init. If memory hotplug thread,
>>> which will also call alloc_init_pud, happens during kernel_init, the
>>> race for fixmap occurs.
>>>
>>> The race condition flow can be:
>>>
>>> *************** begin **************
>>>
>>> kerenl_init thread                          virtio-mem workqueue thread
>>> ==================                          ======== ==================
>>> alloc_init_pud(...)
>>>   pudp = pud_set_fixmap_offset(..)          alloc_init_pud(...)
>>> ...                                         ...
>>>     READ_ONCE(*pudp) //OK!                    pudp = pud_set_fixmap_offset(
>>> ...                                         ...
>>>   pud_clear_fixmap() //fixmap break
>>>                                               READ_ONCE(*pudp) //CRASH!
>>>
>>> **************** end ***************
>>>
>>> Hence, a spin lock is introduced to protect the fixmap during create
>>> pdg mapping.
>>>
>>> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
>>> ---
>>>  arch/arm64/mm/mmu.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c index
>>> acfae9b41cc8..98ac09ae9588 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -63,6 +63,7 @@ static pmd_t bm_pmd[PTRS_PER_PMD]
>> __page_aligned_bss
>>> __maybe_unused;  static pud_t bm_pud[PTRS_PER_PUD]
>> __page_aligned_bss
>>> __maybe_unused;
>>>
>>>  static DEFINE_SPINLOCK(swapper_pgdir_lock);
>>> +static DEFINE_SPINLOCK(fixmap_lock);
>>>
>>>  void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)  { @@ -329,6 +330,11 @@
>>> static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long
>> end,
>>>  	}
>>>  	BUG_ON(p4d_bad(p4d));
>>>
>>> +	/*
>>> +	 * fixmap is global resource, thus it needs to be protected by a lock
>>> +	 * in case of race condition.
>>> +	 */
>>> +	spin_lock(&fixmap_lock);
>>>  	pudp = pud_set_fixmap_offset(p4dp, addr);
>>>  	do {
>>>  		pud_t old_pud = READ_ONCE(*pudp);
>>> @@ -359,6 +365,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned
>> long addr, unsigned long end,
>>>  	} while (pudp++, addr = next, addr != end);
>>>
>>>  	pud_clear_fixmap();
>>> +	spin_unlock(&fixmap_lock);
>>>  }
>>>
>>>  static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>>>
>>
>> As the race could only happen with memory hotplug being enabled, could
>> not we wrap this around with CONFIG_MEMORY_HOTPLUG, just to narrow
>> its scope possibly speed up other non-hotplug cases ?
> 
> I think it's better.

We better avoid using ifdef if not really necessary, it just uglifies
the code. We could add

if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
	...

But should we really try to micto-optimize this code and make it harder
to read for the purpose of an unproven performance gain? (if there is no
contention, we'll most probably not even recognize that we're taking a lock)

-- 
Thanks,

David / dhildenb

