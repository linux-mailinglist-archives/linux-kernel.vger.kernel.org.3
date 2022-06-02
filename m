Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D6653B613
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiFBJcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiFBJcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:32:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E5E5DA4C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 02:32:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y196so4282434pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 02:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7I3ikvFHTI+6AcR3ilkUpnEXgPD/1szD0jLieUltRxk=;
        b=ItV3NywPYNHm1FfgUjBMRW09NCS6oZOMYKz9eWsHEfWk8NyiBKqb/2k4YL46y5CYnS
         blv+H/a7RyNuy6xKLlhF3jjuJhJr5mcHOPtnbO/jkk6avb7yQjCS4MILmz0LsS5C90bQ
         2bi6vOnb22JDvS3GDo/U2ag2yMtw9pvUFAWAPHoaf6ogV7rhYjAH7RVXa4ug20vRoC1q
         8sbl0XOZqCq4DQ7fsF6gXfURhOy2h7n3cxn2UDORy08kinTTXUX3gSKIz5tIRQXutU96
         sjFjTgmRcpZ0ybdSelwgQIopM8JAAX5NjwYRPfgweHy78H1EOXprtzPilNT8DlE6W4nQ
         Jpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7I3ikvFHTI+6AcR3ilkUpnEXgPD/1szD0jLieUltRxk=;
        b=WohCp4M9NzBC0UiWP81hpwIUY4qsd+/dRGQ2dyI+VszzhDb6z6IWqBw0gOFP+IWykA
         2JueT3h9lcFZQzLvIGh5/+sj15Mc+meoBaoyAmO+xtaGxiGqO0ZSVpaJqQutz7nhT4Zg
         WkuluwIJFgSokMdQs/oRnUg/zQ7ABVVa2uPJD1A2TvvQY1AAvnomO7CpO7NAex2GvKeA
         adgbkYUm1Ac+SPO9b8solrlw6jvZ6mupOyPNUzJpeQQFvnmDhhkfeLc+VoLBEsf9BAR3
         yGlJDsdxt4DJKtsILehIK57bSKm9zZpQTz3PdysBKn60sh7d9NjS83A2+5dwzF0Zhijt
         sJFQ==
X-Gm-Message-State: AOAM532ftSdmcOK0cY8xdPQeg4s5NzR1p/qk+ovh6j/PKWClzyeNcXD3
        krpGI7CkqSUM3JTyCn9XRH6hng==
X-Google-Smtp-Source: ABdhPJyGhLUAVF5lUAJbWPQRaAlP5yR+8T7MH5RjDJxKjPQKPSggZoMgr0IYcNvpnD6X4KJsg11e7w==
X-Received: by 2002:a63:754b:0:b0:3fb:2109:e4d2 with SMTP id f11-20020a63754b000000b003fb2109e4d2mr3421775pgn.447.1654162321444;
        Thu, 02 Jun 2022 02:32:01 -0700 (PDT)
Received: from [10.255.89.136] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id d15-20020a056a0024cf00b00512ee2f2363sm3131645pfv.99.2022.06.02.02.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 02:32:00 -0700 (PDT)
Message-ID: <fc4ade80-a40a-d24d-d44d-16b48232b89f@bytedance.com>
Date:   Thu, 2 Jun 2022 17:28:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Peter Xu <peterx@redhat.com>, Jue Wang <juew@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, jasowang@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, mst@redhat.com,
        qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
References: <CAPcxDJ5pduUyMA0rf+-aTjK_2eBvig05UTiTptX1nVkWE-_g8w@mail.gmail.com>
 <Yo/I3oLkd9OU0ice@xz-m1.local>
 <24a95dea-9ea6-a904-7c0b-197961afa1d1@bytedance.com>
 <0d266c61-605d-ce0c-4274-b0c7e10f845a@redhat.com>
 <4b0c3e37-b882-681a-36fc-16cee7e1fff0@bytedance.com>
 <YpTngZ5Qr0KIvL0H@xz-m1.local>
 <CAPcxDJ5UMfpys8KyLQVnkV9BPO1vaubxbhc7f4XC_TdNO7jr7g@mail.gmail.com>
 <5f622a65-8348-8825-a167-414f2a8cd2eb@bytedance.com>
 <484546da-16cc-8070-2a2c-868717b8a75a@redhat.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <484546da-16cc-8070-2a2c-868717b8a75a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/22 15:59, David Hildenbrand wrote:
> On 01.06.22 04:17, zhenwei pi wrote:
>> On 5/31/22 12:08, Jue Wang wrote:
>>> On Mon, May 30, 2022 at 8:49 AM Peter Xu <peterx@redhat.com> wrote:
>>>>
>>>> On Mon, May 30, 2022 at 07:33:35PM +0800, zhenwei pi wrote:
>>>>> A VM uses RAM of 2M huge page. Once a MCE(@HVAy in [HVAx,HVAz)) occurs, the
>>>>> 2M([HVAx,HVAz)) of hypervisor becomes unaccessible, but the guest poisons 4K
>>>>> (@GPAy in [GPAx, GPAz)) only, it may hit another 511 MCE ([GPAx, GPAz)
>>>>> except GPAy). This is the worse case, so I want to add
>>>>>    '__le32 corrupted_pages' in struct virtio_balloon_config, it is used in the
>>>>> next step: reporting 512 * 4K 'corrupted_pages' to the guest, the guest has
>>>>> a chance to isolate the other 511 pages ahead of time. And the guest
>>>>> actually loses 2M, fixing 512*4K seems to help significantly.
>>>>
>>>> It sounds hackish to teach a virtio device to assume one page will always
>>>> be poisoned in huge page granule.  That's only a limitation to host kernel
>>>> not virtio itself.
>>>>
>>>> E.g. there're upstream effort ongoing with enabling doublemap on hugetlbfs
>>>> pages so hugetlb pages can be mapped in 4k with it.  It provides potential
>>>> possibility to do page poisoning with huge pages in 4k too.  When that'll
>>>> be ready the assumption can go away, and that does sound like a better
>>>> approach towards this problem.
>>>
>>> +1.
>>>
>>> A hypervisor should always strive to minimize the guest memory loss.
>>>
>>> The HugeTLB double mapping enlightened memory poisoning behavior (only
>>> poison 4K out of a 2MB huge page and 4K in guest) is a much better
>>> solution here. To be completely transparent, it's not _strictly_
>>> required to poison the page (whatever the granularity it is) on the
>>> host side, as long as the following are true:
>>>
>>> 1. A hypervisor can emulate the _minimized_ (e.g., 4K) the poison to the guest.
>>> 2. The host page with the UC error is "isolated" (could be PG_HWPOISON
>>> or in some other way) and prevented from being reused by other
>>> processes.
>>>
>>> For #2, PG_HWPOISON and HugeTLB double mapping enlightened memory
>>> poisoning is a good solution.
>>>
>>>>
>>>>>
>>>>>>
>>>>>> I assume when talking about "the performance memory drops a lot", you
>>>>>> imply that this patch set can mitigate that performance drop?
>>>>>>
>>>>>> But why do you see a performance drop? Because we might lose some
>>>>>> possible THP candidates (in the host or the guest) and you want to plug
>>>>>> does holes? I assume you'll see a performance drop simply because
>>>>>> poisoning memory is expensive, including migrating pages around on CE.
>>>>>>
>>>>>> If you have some numbers to share, especially before/after this change,
>>>>>> that would be great.
>>>>>>
>>>>>
>>>>> The CE storm leads 2 problems I have even seen:
>>>>> 1, the memory bandwidth slows down to 10%~20%, and the cycles per
>>>>> instruction of CPU increases a lot.
>>>>> 2, the THR (/proc/interrupts) interrupts frequently, the CPU has to use a
>>>>> lot time to handle IRQ.
>>>>
>>>> Totally no good knowledge on CMCI, but if 2) is true then I'm wondering
>>>> whether it's necessary to handle the interrupts that frequently.  When I
>>>> was reading the Intel CMCI vector handler I stumbled over this comment:
>>>>
>>>> /*
>>>>    * The interrupt handler. This is called on every event.
>>>>    * Just call the poller directly to log any events.
>>>>    * This could in theory increase the threshold under high load,
>>>>    * but doesn't for now.
>>>>    */
>>>> static void intel_threshold_interrupt(void)
>>>>
>>>> I think that matches with what I was thinking..  I mean for 2) not sure
>>>> whether it can be seen as a CMCI problem and potentially can be optimized
>>>> by adjust the cmci threshold dynamically.
>>>
>>> The CE storm caused performance drop is caused by the extra cycles
>>> spent by the ECC steps in memory controller, not in CMCI handling.
>>> This is observed in the Google fleet as well. A good solution is to
>>> monitor the CE rate closely in user space via /dev/mcelog and migrate
>>> all VMs to another host once the CE rate exceeds some threshold.
>>>
>>> CMCI is a _background_ interrupt that is not handled in the process
>>> execution context and its handler is setup to switch to poll (1 / 5
>>> min) mode if there are more than ~ a dozen CEs reported via CMCI per
>>> second.
>>>>
>>>> --
>>>> Peter Xu
>>>>
>>
>> Hi, Andrew, David, Naoya
>>
>> According to the suggestions, I'd give up the improvement of memory
>> failure on huge page in this series.
>>
>> Is it worth recovering corrupted pages for the guest kernel? I'd follow
>> your decision.
> 
> Well, as I said, I am not sure if we really need/want this for a handful
> of 4k poisoned pages in a VM. As I suspected, doing so might primarily
> be interesting for some sort of de-fragmentation (allow again a higher
> order page to be placed at the affected PFNs), not because of the slight
> reduction of available memory. A simple VM reboot would get the job
> similarly done.
> 

Sure, Let's drop this idea. Thanks to all for the suggestions.

Hi, Naoya
It seems that memory failure notifier is not required currently, so I'll 
not push the next version of:
[PATCH 1/3] memory-failure: Introduce memory failure notifier
[PATCH 2/3] mm/memory-failure.c: support reset PTE during unpoison

Thanks you for review work!

> As the poisoning refcount code is already a bit shaky as I learned
> recently in the context of memory offlining, I do wonder if we really
> want to expose the unpoisoning code outside of debugfs (hwpoison) usage.
> 
> Interestingly, unpoison_memory() documents: "This is only done on the
> software-level, so it only works for linux injected failures, not real
> hardware failures" -- ehm?
> 

I guess unpoison_memory() is designed/tested by hwpoison-inject only, I 
have no idea to fix memory failure on a hardware platform. I suppose 
it's the first time that unpoison_memory() is required by hardware-level 
(balloon VQ).

-- 
zhenwei pi
