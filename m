Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E4F4FA8BB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242253AbiDINtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237578AbiDINtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:49:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D883F1DD
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:47:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so16770026wrg.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 06:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TZnfb759HcwuaB/QZMKlQAK+6O+n7loBzLhhlmus6gs=;
        b=H7vIF/G27Hb6PDC+XWb3XPpcoZBNY/irr7saMr4Zzlv5//du4N1f4HWZLbOWfv0jTq
         a44ju6+giDo4O5i/KS05RizAKoUgDneAPyv8/KlFcuq0gPCRcv6QMskaQ0yUJwO152Re
         r5ASmG1hCZL7cBbxK9UUun0AT5QM00LfacVecnJuVvmhSCih965lzBUrCmkLfeJ9EGww
         gNg/BuWh8NtHwm3CRjDnm7BqrnnpPFu+Wb8YRHXZ8aMKJ5KwAzOdgto9jq2Q+LOHF+qG
         mz1DWFdO+dNLVcpPuPSPKw+VwXCRwGjaVUyQ1R7ew8XYdaVcbOMzfdWN23xISVjd2lWw
         bEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TZnfb759HcwuaB/QZMKlQAK+6O+n7loBzLhhlmus6gs=;
        b=NYeNDPOKkkTwNEfwKCMR1KkVA4xAW4uvecWm2yKh2yrXAHBxsYi9yBaTSsH0LH7wc+
         +reS78ZoWnbf0yH9iV57Sfddc8wu5VyzXwBcUVRQ9dvHpqWepKAL0BuuLgFgsAuq/PEh
         zdyAFI6zHSV2TVUqs1Vjs/2bz/DODuk3VKD4/IxVWBY9w1O7IMr1etm6bkkgxKQtP3qj
         XfpvcemMv4xcFoqUlirwQVhAenflUBiTTatzkHmMUHRJWq3eDrPCJdd8ndK2yUOPWJog
         I31jkl5NMooRfcw7KJv7nFlEmrMI/uSYrYc88vriUkiU4w8fFCib7v4BztCDZY/zT7N4
         IIVA==
X-Gm-Message-State: AOAM5322LCeuSL60a1439nJfJotDBYkpDeSN3cVrWklLJydfknMB/7+F
        sfWCNG9xrarNsBBKeH4RwPE=
X-Google-Smtp-Source: ABdhPJwrL3Dl96oeoWT5B/P+SB57tnPGQx93a7n+LxBl5FdnJIbzMvl2fFRXw3C/s6T5nE4qrEVLHg==
X-Received: by 2002:adf:dec7:0:b0:207:a119:3fe3 with SMTP id i7-20020adfdec7000000b00207a1193fe3mr1410346wrn.591.1649512062339;
        Sat, 09 Apr 2022 06:47:42 -0700 (PDT)
Received: from ?IPV6:2a00:a040:197:458f:54dd:de54:82a2:f69a? ([2a00:a040:197:458f:54dd:de54:82a2:f69a])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm14317959wrb.63.2022.04.09.06.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 06:47:42 -0700 (PDT)
Message-ID: <2603cae9-3b75-cd13-1d41-2f1bed6ca32e@gmail.com>
Date:   Sat, 9 Apr 2022 16:47:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: False positive kmemleak report for dtb properties names on
 powerpc
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        akpm@linux-foundation.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <9dd08bb5-f39e-53d8-f88d-bec598a08c93@gmail.com>
 <YjtXXlnbEp64eL0T@arm.com> <Yjtvtkn+CishCef6@kernel.org>
From:   Ariel Marcovitch <arielmarcovitch@gmail.com>
In-Reply-To: <Yjtvtkn+CishCef6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe, did you get the chance to look at this?

On 23/03/2022 21:06, Mike Rapoport wrote:
> Hi Catalin,
>
> On Wed, Mar 23, 2022 at 05:22:38PM +0000, Catalin Marinas wrote:
>> Hi Ariel,
>>
>> On Fri, Feb 18, 2022 at 09:45:51PM +0200, Ariel Marcovitch wrote:
>>> I was running a powerpc 32bit kernel (built using
>>> qemu_ppc_mpc8544ds_defconfig
>>> buildroot config, with enabling DEBUGFS+KMEMLEAK+HIGHMEM in the kernel
>>> config)
>>> on qemu and invoked the kmemleak scan (twice. for some reason the first time
>>> wasn't enough).
>> [...]
>>> I got 97 leak reports, all similar to the following:
>> [...]
>>> memblock_alloc lets kmemleak know about the allocated memory using
>>> kmemleak_alloc_phys (in mm/memblock.c:memblock_alloc_range_nid()).
>>>
>>> The problem is with the following code (mm/kmemleak.c):
>>>
>>> ```c
>>>
>>> void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
>>>                                 gfp_t gfp)
>>> {
>>>          if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) < max_low_pfn)
>>>                  kmemleak_alloc(__va(phys), size, min_count, gfp);
>>> }
>>>
>>> ```
>>>
>>> When CONFIG_HIGHMEM is enabled, the pfn of the allocated memory is checked
>>> against max_low_pfn, to make sure it is not in the HIGHMEM zone.
>>>
>>> However, when called through unflatten_device_tree(), max_low_pfn is not yet
>>> initialized in powerpc.
>>>
>>> max_low_pfn is initialized (when NUMA is disabled) in
>>> arch/powerpc/mm/mem.c:mem_topology_setup() which is called only after
>>> unflatten_device_tree() is called in the same function (setup_arch()).
>>>
>>> Because max_low_pfn is global it is 0 before initialization, so as far as
>>> kmemleak_alloc_phys() is concerned, every memory is HIGHMEM (: and the
>>> allocated memory is not tracked by kmemleak, causing references to objects
>>> allocated later with kmalloc() to be ignored and these objects are marked as
>>> leaked.
>> Thanks for digging into this. It looks like the logic doesn't work (not
>> sure whether it ever worked).
>>
>>> I actually tried to find out whether this happen on other arches as well,
>>> and it seems like arm64 also have this problem when dtb is used instead of
>>> acpi, although I haven't had the chance to confirm this.
>> arm64 doesn't enable CONFIG_HIGHMEM, so it's not affected.
>>
>>> I don't suppose I can just shuffle the calls in setup_arch() around, so I
>>> wanted to hear your opinions first
>> I think it's better if we change the logic than shuffling the calls.
>> IIUC MEMBLOCK_ALLOC_ACCESSIBLE means that __va() works on the phys
>> address return by memblock, so something like below (untested):
> MEMBLOCK_ALLOC_ACCESSIBLE means "anywhere", see commit e63075a3c937
> ("memblock: Introduce default allocation limit and use it to replace
> explicit ones"), so it won't help to detect high memory.
>
> If I remember correctly, ppc initializes memblock *very* early, so setting
> max_low_pfn along with lowmem_end_addr in
> arch/powerpc/mm/init_32::MMU_init() makes sense to me.
>
> Maybe ppc folks have other ideas...
> I've added Christophe who works on ppc32 these days.
>   
>> -------------8<----------------------
>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index 7580baa76af1..f3599e857c13 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -1127,8 +1127,7 @@ EXPORT_SYMBOL(kmemleak_no_scan);
>>   void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
>>   			       gfp_t gfp)
>>   {
>> -	if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) < max_low_pfn)
>> -		kmemleak_alloc(__va(phys), size, min_count, gfp);
>> +	kmemleak_alloc(__va(phys), size, min_count, gfp);
>>   }
>>   EXPORT_SYMBOL(kmemleak_alloc_phys);
>>   
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index b12a364f2766..2515bd4331e8 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1397,7 +1397,7 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>>   	 * Skip kmemleak for those places like kasan_init() and
>>   	 * early_pgtable_alloc() due to high volume.
>>   	 */
>> -	if (end != MEMBLOCK_ALLOC_NOLEAKTRACE)
>> +	if (end == MEMBLOCK_ALLOC_ACCESSIBLE)
> This change would enable kmemleak for KASAN on arm and arm64 that AFAIR
> caused OOM in kmemleak and it also will limit tracking only to allocations
> that do not specify 'end' explicitly ;-)
>
>>   		/*
>>   		 * The min_count is set to 0 so that memblock allocated
>>   		 * blocks are never reported as leaks. This is because many
>> -------------8<----------------------
>>
>> But I'm not sure whether we'd now miss some genuine allocations where
>> the memblock limit is different from MEMBLOCK_ALLOC_ACCESSIBLE but still
>> within the lowmem limit. If the above works, we can probably get rid of
>> some other kmemleak callbacks in the kernel.
>>
>> Adding Mike for any input on memblock.
>>
>> -- 
>> Catalin
