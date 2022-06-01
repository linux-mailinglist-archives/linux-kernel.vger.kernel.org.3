Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77476539B31
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 04:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349137AbiFACWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 22:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240621AbiFACV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 22:21:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6FE25C54
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 19:21:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g205so616124pfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 19:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2okyrQI7zzxx6armVnSyvWo3k8iS+WCjiSoArjw0fEE=;
        b=lNtCXz826IraqgepKCt/0lBy+mvMAaE2ivM/1NtE1GDoY942T5NsfhN91WTgx4ANjM
         0xSVtO126oHxAM52jRDdWZORous5WBraQcL6dZQ8Ia53sJcte67lY7MPex9Z5MtwU/t3
         gxaV3/h3l0sz5h8It0hfiUZ5SYwVEdE3yMgblQkT9Y7FDq3ZPzr1CjWqoNE8KqzydtL7
         /271RuA8uiEl61xA0JyyHu0VZm0P0a/V1g89g4LrVnV+p4AgH0064N0SDE9eU5hfMl7g
         VE5X+2RmPw9fzhPqM6nWyZPLMWd+FDtQhwGBuRG5GGmVbXw2C45XfOEmviQBpXcD90GI
         aq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2okyrQI7zzxx6armVnSyvWo3k8iS+WCjiSoArjw0fEE=;
        b=V4s1L+OLfLcbn5yBIIK8nks6hxUbaR/yljRpwtX8FAtUWoZvaNoLLrDpZw0NanbmAJ
         yh43dyxnnOG9FHg1akvKFX8487foSCG9nfkGFIl/24vhJmJ1PP7AzDxdsB48jsc8n9TV
         NSD0G8ZAXVaK80uNRfzSkecM6Sln97J3HIY6bzxWCJwU/y7HQpXWSqsDfC8wbY1/BdwF
         eOtJJw411kxblCmE3dD6V5XtUFL5jcmS+gRbVQwR0dgik/hfHwTba/8kAbfcXLtPsaJM
         o9in36hwmgiBEpKAK8rhkmP6kVBD7h+GLkv9JbjRdvRcGCZrPXg0yGiyvPJezgPiQQ/p
         Bqsw==
X-Gm-Message-State: AOAM532CIG8+JjI8sLDKB/qLhpmsQDniL1buyaSB8Jy/WOTiLw4T6GiO
        XBGECxdpRkeQQEosblSDXM3Vew==
X-Google-Smtp-Source: ABdhPJzW0LFXWu1OWiBefZkXNcr/MWs15wzhND3amhX9Ouk0RYJnIvws91AeF3f0YhsM1ih2w98Iwg==
X-Received: by 2002:a05:6a00:23ce:b0:50d:823f:981 with SMTP id g14-20020a056a0023ce00b0050d823f0981mr65646297pfc.10.1654050116005;
        Tue, 31 May 2022 19:21:56 -0700 (PDT)
Received: from [10.255.89.136] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b001641a68f1c7sm190180plg.273.2022.05.31.19.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 19:21:55 -0700 (PDT)
Message-ID: <5f622a65-8348-8825-a167-414f2a8cd2eb@bytedance.com>
Date:   Wed, 1 Jun 2022 10:17:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: Re: [PATCH 0/3] recover hardware corrupted page by virtio
 balloon
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
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
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <CAPcxDJ5UMfpys8KyLQVnkV9BPO1vaubxbhc7f4XC_TdNO7jr7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/22 12:08, Jue Wang wrote:
> On Mon, May 30, 2022 at 8:49 AM Peter Xu <peterx@redhat.com> wrote:
>>
>> On Mon, May 30, 2022 at 07:33:35PM +0800, zhenwei pi wrote:
>>> A VM uses RAM of 2M huge page. Once a MCE(@HVAy in [HVAx,HVAz)) occurs, the
>>> 2M([HVAx,HVAz)) of hypervisor becomes unaccessible, but the guest poisons 4K
>>> (@GPAy in [GPAx, GPAz)) only, it may hit another 511 MCE ([GPAx, GPAz)
>>> except GPAy). This is the worse case, so I want to add
>>>   '__le32 corrupted_pages' in struct virtio_balloon_config, it is used in the
>>> next step: reporting 512 * 4K 'corrupted_pages' to the guest, the guest has
>>> a chance to isolate the other 511 pages ahead of time. And the guest
>>> actually loses 2M, fixing 512*4K seems to help significantly.
>>
>> It sounds hackish to teach a virtio device to assume one page will always
>> be poisoned in huge page granule.  That's only a limitation to host kernel
>> not virtio itself.
>>
>> E.g. there're upstream effort ongoing with enabling doublemap on hugetlbfs
>> pages so hugetlb pages can be mapped in 4k with it.  It provides potential
>> possibility to do page poisoning with huge pages in 4k too.  When that'll
>> be ready the assumption can go away, and that does sound like a better
>> approach towards this problem.
> 
> +1.
> 
> A hypervisor should always strive to minimize the guest memory loss.
> 
> The HugeTLB double mapping enlightened memory poisoning behavior (only
> poison 4K out of a 2MB huge page and 4K in guest) is a much better
> solution here. To be completely transparent, it's not _strictly_
> required to poison the page (whatever the granularity it is) on the
> host side, as long as the following are true:
> 
> 1. A hypervisor can emulate the _minimized_ (e.g., 4K) the poison to the guest.
> 2. The host page with the UC error is "isolated" (could be PG_HWPOISON
> or in some other way) and prevented from being reused by other
> processes.
> 
> For #2, PG_HWPOISON and HugeTLB double mapping enlightened memory
> poisoning is a good solution.
> 
>>
>>>
>>>>
>>>> I assume when talking about "the performance memory drops a lot", you
>>>> imply that this patch set can mitigate that performance drop?
>>>>
>>>> But why do you see a performance drop? Because we might lose some
>>>> possible THP candidates (in the host or the guest) and you want to plug
>>>> does holes? I assume you'll see a performance drop simply because
>>>> poisoning memory is expensive, including migrating pages around on CE.
>>>>
>>>> If you have some numbers to share, especially before/after this change,
>>>> that would be great.
>>>>
>>>
>>> The CE storm leads 2 problems I have even seen:
>>> 1, the memory bandwidth slows down to 10%~20%, and the cycles per
>>> instruction of CPU increases a lot.
>>> 2, the THR (/proc/interrupts) interrupts frequently, the CPU has to use a
>>> lot time to handle IRQ.
>>
>> Totally no good knowledge on CMCI, but if 2) is true then I'm wondering
>> whether it's necessary to handle the interrupts that frequently.  When I
>> was reading the Intel CMCI vector handler I stumbled over this comment:
>>
>> /*
>>   * The interrupt handler. This is called on every event.
>>   * Just call the poller directly to log any events.
>>   * This could in theory increase the threshold under high load,
>>   * but doesn't for now.
>>   */
>> static void intel_threshold_interrupt(void)
>>
>> I think that matches with what I was thinking..  I mean for 2) not sure
>> whether it can be seen as a CMCI problem and potentially can be optimized
>> by adjust the cmci threshold dynamically.
> 
> The CE storm caused performance drop is caused by the extra cycles
> spent by the ECC steps in memory controller, not in CMCI handling.
> This is observed in the Google fleet as well. A good solution is to
> monitor the CE rate closely in user space via /dev/mcelog and migrate
> all VMs to another host once the CE rate exceeds some threshold.
> 
> CMCI is a _background_ interrupt that is not handled in the process
> execution context and its handler is setup to switch to poll (1 / 5
> min) mode if there are more than ~ a dozen CEs reported via CMCI per
> second.
>>
>> --
>> Peter Xu
>>

Hi, Andrew, David, Naoya

According to the suggestions, I'd give up the improvement of memory 
failure on huge page in this series.

Is it worth recovering corrupted pages for the guest kernel? I'd follow 
your decision.

-- 
zhenwei pi
