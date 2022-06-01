Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E2F539ED5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350452AbiFAH73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244461AbiFAH7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D65168A300
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654070361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X57AV1JS1Mqn7vo0Jw9w21QgY8DunEV7ImYYwrtqE0c=;
        b=bBt1PD2s7e3YcIw0NykXHCeXnwxaEL7LpkvPb5dwcuDBhnLLLpoLKel+/Gm5oPigL33Yfv
        e++8NvhnL7P/fig3H5tHqtqW4DMkv+yxc/YXZZRpzEwqp51jlpncIfIena8fyWeXbRr7PV
        e6QeKACXnCIRMgxA71nEMnom2BNX7MA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-JQlLufZaMCiV8y2roF9FpQ-1; Wed, 01 Jun 2022 03:59:19 -0400
X-MC-Unique: JQlLufZaMCiV8y2roF9FpQ-1
Received: by mail-wm1-f72.google.com with SMTP id bg40-20020a05600c3ca800b00394779649b1so2939431wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 00:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=X57AV1JS1Mqn7vo0Jw9w21QgY8DunEV7ImYYwrtqE0c=;
        b=OeoGFq+G0HjKBm3w7XqZrsIB8p/UJ3VNOQ6TiCcx5Q5eE/8ItLMxgu0udU1rnFpCcY
         g/5sTRBzqAMqL7v4oF7O27fKvmgLRjnGG2EvwIGICWBJCAiqIIdjMO+sMpNXeG/tgRTW
         D6s16mu/u0PwXQLKxK+w7aXD17MTDIATR6aQTS1GZN1rIah+wxVNKn48WdNo9IOnB+lH
         d+mGJroOT6CmrMsCZxFxmu0eQeBvTrIf0HDrqE6CxAsUIG51Dv9SN6AgMs7FOQUzxv2+
         HrAZjxKHi5rQoOtfg5hMlybnMyex5msvTCWxfbf3S+l+1gRzXvE4oU6e8uIXl12O3AL5
         QpUg==
X-Gm-Message-State: AOAM532rLKXqwJ38ihcFj/d9/8oINOHmvNgvCQV4He/i92CxCKZwfESL
        2q+hKiQERjXRp5yjfM5jCCTqKZGN05Hi3bm9TR+uC+W9teYm6N7HedskgZdraQIgXMqP6RzV9G5
        o0TcN2hMZOELZ8MO2j0VDShYI
X-Received: by 2002:a05:6000:1d86:b0:20f:fcae:57f8 with SMTP id bk6-20020a0560001d8600b0020ffcae57f8mr29128557wrb.262.1654070357986;
        Wed, 01 Jun 2022 00:59:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRXopFFdxewjiXZogv3wBRsP/bd8pMpOz5TV6kA8hkaTRFy4NC/B3PyodLYhUx84ns8W9osQ==
X-Received: by 2002:a05:6000:1d86:b0:20f:fcae:57f8 with SMTP id bk6-20020a0560001d8600b0020ffcae57f8mr29128536wrb.262.1654070357654;
        Wed, 01 Jun 2022 00:59:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2600:951d:63df:c091:3b45? (p200300cbc7052600951d63dfc0913b45.dip0.t-ipconnect.de. [2003:cb:c705:2600:951d:63df:c091:3b45])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d44cd000000b0020e6c51f070sm818410wrr.112.2022.06.01.00.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 00:59:16 -0700 (PDT)
Message-ID: <484546da-16cc-8070-2a2c-868717b8a75a@redhat.com>
Date:   Wed, 1 Jun 2022 09:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
In-Reply-To: <5f622a65-8348-8825-a167-414f2a8cd2eb@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.22 04:17, zhenwei pi wrote:
> On 5/31/22 12:08, Jue Wang wrote:
>> On Mon, May 30, 2022 at 8:49 AM Peter Xu <peterx@redhat.com> wrote:
>>>
>>> On Mon, May 30, 2022 at 07:33:35PM +0800, zhenwei pi wrote:
>>>> A VM uses RAM of 2M huge page. Once a MCE(@HVAy in [HVAx,HVAz)) occurs, the
>>>> 2M([HVAx,HVAz)) of hypervisor becomes unaccessible, but the guest poisons 4K
>>>> (@GPAy in [GPAx, GPAz)) only, it may hit another 511 MCE ([GPAx, GPAz)
>>>> except GPAy). This is the worse case, so I want to add
>>>>   '__le32 corrupted_pages' in struct virtio_balloon_config, it is used in the
>>>> next step: reporting 512 * 4K 'corrupted_pages' to the guest, the guest has
>>>> a chance to isolate the other 511 pages ahead of time. And the guest
>>>> actually loses 2M, fixing 512*4K seems to help significantly.
>>>
>>> It sounds hackish to teach a virtio device to assume one page will always
>>> be poisoned in huge page granule.  That's only a limitation to host kernel
>>> not virtio itself.
>>>
>>> E.g. there're upstream effort ongoing with enabling doublemap on hugetlbfs
>>> pages so hugetlb pages can be mapped in 4k with it.  It provides potential
>>> possibility to do page poisoning with huge pages in 4k too.  When that'll
>>> be ready the assumption can go away, and that does sound like a better
>>> approach towards this problem.
>>
>> +1.
>>
>> A hypervisor should always strive to minimize the guest memory loss.
>>
>> The HugeTLB double mapping enlightened memory poisoning behavior (only
>> poison 4K out of a 2MB huge page and 4K in guest) is a much better
>> solution here. To be completely transparent, it's not _strictly_
>> required to poison the page (whatever the granularity it is) on the
>> host side, as long as the following are true:
>>
>> 1. A hypervisor can emulate the _minimized_ (e.g., 4K) the poison to the guest.
>> 2. The host page with the UC error is "isolated" (could be PG_HWPOISON
>> or in some other way) and prevented from being reused by other
>> processes.
>>
>> For #2, PG_HWPOISON and HugeTLB double mapping enlightened memory
>> poisoning is a good solution.
>>
>>>
>>>>
>>>>>
>>>>> I assume when talking about "the performance memory drops a lot", you
>>>>> imply that this patch set can mitigate that performance drop?
>>>>>
>>>>> But why do you see a performance drop? Because we might lose some
>>>>> possible THP candidates (in the host or the guest) and you want to plug
>>>>> does holes? I assume you'll see a performance drop simply because
>>>>> poisoning memory is expensive, including migrating pages around on CE.
>>>>>
>>>>> If you have some numbers to share, especially before/after this change,
>>>>> that would be great.
>>>>>
>>>>
>>>> The CE storm leads 2 problems I have even seen:
>>>> 1, the memory bandwidth slows down to 10%~20%, and the cycles per
>>>> instruction of CPU increases a lot.
>>>> 2, the THR (/proc/interrupts) interrupts frequently, the CPU has to use a
>>>> lot time to handle IRQ.
>>>
>>> Totally no good knowledge on CMCI, but if 2) is true then I'm wondering
>>> whether it's necessary to handle the interrupts that frequently.  When I
>>> was reading the Intel CMCI vector handler I stumbled over this comment:
>>>
>>> /*
>>>   * The interrupt handler. This is called on every event.
>>>   * Just call the poller directly to log any events.
>>>   * This could in theory increase the threshold under high load,
>>>   * but doesn't for now.
>>>   */
>>> static void intel_threshold_interrupt(void)
>>>
>>> I think that matches with what I was thinking..  I mean for 2) not sure
>>> whether it can be seen as a CMCI problem and potentially can be optimized
>>> by adjust the cmci threshold dynamically.
>>
>> The CE storm caused performance drop is caused by the extra cycles
>> spent by the ECC steps in memory controller, not in CMCI handling.
>> This is observed in the Google fleet as well. A good solution is to
>> monitor the CE rate closely in user space via /dev/mcelog and migrate
>> all VMs to another host once the CE rate exceeds some threshold.
>>
>> CMCI is a _background_ interrupt that is not handled in the process
>> execution context and its handler is setup to switch to poll (1 / 5
>> min) mode if there are more than ~ a dozen CEs reported via CMCI per
>> second.
>>>
>>> --
>>> Peter Xu
>>>
> 
> Hi, Andrew, David, Naoya
> 
> According to the suggestions, I'd give up the improvement of memory 
> failure on huge page in this series.
> 
> Is it worth recovering corrupted pages for the guest kernel? I'd follow 
> your decision.

Well, as I said, I am not sure if we really need/want this for a handful
of 4k poisoned pages in a VM. As I suspected, doing so might primarily
be interesting for some sort of de-fragmentation (allow again a higher
order page to be placed at the affected PFNs), not because of the slight
reduction of available memory. A simple VM reboot would get the job
similarly done.

As the poisoning refcount code is already a bit shaky as I learned
recently in the context of memory offlining, I do wonder if we really
want to expose the unpoisoning code outside of debugfs (hwpoison) usage.

Interestingly, unpoison_memory() documents: "This is only done on the
software-level, so it only works for linux injected failures, not real
hardware failures" -- ehm?

-- 
Thanks,

David / dhildenb

