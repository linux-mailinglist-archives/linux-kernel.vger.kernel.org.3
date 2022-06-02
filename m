Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9304C53B637
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiFBJk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiFBJk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7F5EDC826
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 02:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654162822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=52LjxcDCDPkycB4f7TfSZD4ZH4TRdf/5KkEsxrmPS+E=;
        b=J06owR+A0CISQyNw/9Jx6rM7WLd5H58UuGE8fPS67OV04g+qRFD/qmYk+RygmXZEF7LR6d
        6xFHs3HnXdqs1Pb0S+VFahuzETADbsHZqKqjrUR0Orwv35IVV7L68ziqQI3bFs77i0+zbp
        0ThY9AgQTpjg08kc8yWQTtpWcw+w/eA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-O3F24AY2NKa2JelR44OExQ-1; Thu, 02 Jun 2022 05:40:21 -0400
X-MC-Unique: O3F24AY2NKa2JelR44OExQ-1
Received: by mail-wm1-f69.google.com with SMTP id bg40-20020a05600c3ca800b00394779649b1so4878407wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 02:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=52LjxcDCDPkycB4f7TfSZD4ZH4TRdf/5KkEsxrmPS+E=;
        b=wr63kF4l133c0QSLRv4J3fet4gQDaVUXXGdtXCljC8kvzNDbwN0MJVakssSUHOJbxg
         1KbNwapydB6AUOQFyxkNpIxtXO8g9Ghgv3AqxtZyAIQuAAA7JbiYp731r+9WiHTXV0P9
         rJpDxmnhGV/CEBdcJPTk6c2apgUfFiMHAxQ0N2gs9oy/DgT0Ewv5jdEHA/6q2MOrWakI
         pZjjW65gjstRffEGZLDmNabFpr/hbuc59mGioTNWg8i64oqX1P1k70AovWx3h43MQjl3
         VfcUYBPdATDfusdNTYT2KIZlonIzDPu1BAtuFMz2nZl/r8lriwB5hmywhe6o3CgS6nw5
         0vHA==
X-Gm-Message-State: AOAM533AAHtLiqsAqbTlkwgL7+17ZEfG+sJrnwWSuueni8SZtGWAaPfU
        a0cLiQDybtD2H0ZL587cICNulKeA//bD5S6ABp5CfNYV2oh2PdNFcmMIpn4cRec9a35YC9MyXGx
        OhQoPdBmIT4DnIqAUNMDDx8OL
X-Received: by 2002:a05:600c:5126:b0:39a:eede:5bf4 with SMTP id o38-20020a05600c512600b0039aeede5bf4mr3176141wms.81.1654162820604;
        Thu, 02 Jun 2022 02:40:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHYaDjNFGZohw0FilN1sHRbTenO2UBUUNE+T3ndq17x5ElP+Hjk2H4wgNC7lGgcxhyEKxNTg==
X-Received: by 2002:a05:600c:5126:b0:39a:eede:5bf4 with SMTP id o38-20020a05600c512600b0039aeede5bf4mr3176113wms.81.1654162820283;
        Thu, 02 Jun 2022 02:40:20 -0700 (PDT)
Received: from [192.168.178.20] (p57a1a7d6.dip0.t-ipconnect.de. [87.161.167.214])
        by smtp.gmail.com with ESMTPSA id d13-20020adfef8d000000b0020fc40d006bsm3830184wro.17.2022.06.02.02.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 02:40:19 -0700 (PDT)
Message-ID: <8e4ffc3f-62c3-636e-e65b-af4b5bbc6c99@redhat.com>
Date:   Thu, 2 Jun 2022 11:40:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
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
 <484546da-16cc-8070-2a2c-868717b8a75a@redhat.com>
 <fc4ade80-a40a-d24d-d44d-16b48232b89f@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <fc4ade80-a40a-d24d-d44d-16b48232b89f@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.22 11:28, zhenwei pi wrote:
> On 6/1/22 15:59, David Hildenbrand wrote:
>> On 01.06.22 04:17, zhenwei pi wrote:
>>> On 5/31/22 12:08, Jue Wang wrote:
>>>> On Mon, May 30, 2022 at 8:49 AM Peter Xu <peterx@redhat.com> wrote:
>>>>>
>>>>> On Mon, May 30, 2022 at 07:33:35PM +0800, zhenwei pi wrote:
>>>>>> A VM uses RAM of 2M huge page. Once a MCE(@HVAy in [HVAx,HVAz)) occurs, the
>>>>>> 2M([HVAx,HVAz)) of hypervisor becomes unaccessible, but the guest poisons 4K
>>>>>> (@GPAy in [GPAx, GPAz)) only, it may hit another 511 MCE ([GPAx, GPAz)
>>>>>> except GPAy). This is the worse case, so I want to add
>>>>>>    '__le32 corrupted_pages' in struct virtio_balloon_config, it is used in the
>>>>>> next step: reporting 512 * 4K 'corrupted_pages' to the guest, the guest has
>>>>>> a chance to isolate the other 511 pages ahead of time. And the guest
>>>>>> actually loses 2M, fixing 512*4K seems to help significantly.
>>>>>
>>>>> It sounds hackish to teach a virtio device to assume one page will always
>>>>> be poisoned in huge page granule.  That's only a limitation to host kernel
>>>>> not virtio itself.
>>>>>
>>>>> E.g. there're upstream effort ongoing with enabling doublemap on hugetlbfs
>>>>> pages so hugetlb pages can be mapped in 4k with it.  It provides potential
>>>>> possibility to do page poisoning with huge pages in 4k too.  When that'll
>>>>> be ready the assumption can go away, and that does sound like a better
>>>>> approach towards this problem.
>>>>
>>>> +1.
>>>>
>>>> A hypervisor should always strive to minimize the guest memory loss.
>>>>
>>>> The HugeTLB double mapping enlightened memory poisoning behavior (only
>>>> poison 4K out of a 2MB huge page and 4K in guest) is a much better
>>>> solution here. To be completely transparent, it's not _strictly_
>>>> required to poison the page (whatever the granularity it is) on the
>>>> host side, as long as the following are true:
>>>>
>>>> 1. A hypervisor can emulate the _minimized_ (e.g., 4K) the poison to the guest.
>>>> 2. The host page with the UC error is "isolated" (could be PG_HWPOISON
>>>> or in some other way) and prevented from being reused by other
>>>> processes.
>>>>
>>>> For #2, PG_HWPOISON and HugeTLB double mapping enlightened memory
>>>> poisoning is a good solution.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> I assume when talking about "the performance memory drops a lot", you
>>>>>>> imply that this patch set can mitigate that performance drop?
>>>>>>>
>>>>>>> But why do you see a performance drop? Because we might lose some
>>>>>>> possible THP candidates (in the host or the guest) and you want to plug
>>>>>>> does holes? I assume you'll see a performance drop simply because
>>>>>>> poisoning memory is expensive, including migrating pages around on CE.
>>>>>>>
>>>>>>> If you have some numbers to share, especially before/after this change,
>>>>>>> that would be great.
>>>>>>>
>>>>>>
>>>>>> The CE storm leads 2 problems I have even seen:
>>>>>> 1, the memory bandwidth slows down to 10%~20%, and the cycles per
>>>>>> instruction of CPU increases a lot.
>>>>>> 2, the THR (/proc/interrupts) interrupts frequently, the CPU has to use a
>>>>>> lot time to handle IRQ.
>>>>>
>>>>> Totally no good knowledge on CMCI, but if 2) is true then I'm wondering
>>>>> whether it's necessary to handle the interrupts that frequently.  When I
>>>>> was reading the Intel CMCI vector handler I stumbled over this comment:
>>>>>
>>>>> /*
>>>>>    * The interrupt handler. This is called on every event.
>>>>>    * Just call the poller directly to log any events.
>>>>>    * This could in theory increase the threshold under high load,
>>>>>    * but doesn't for now.
>>>>>    */
>>>>> static void intel_threshold_interrupt(void)
>>>>>
>>>>> I think that matches with what I was thinking..  I mean for 2) not sure
>>>>> whether it can be seen as a CMCI problem and potentially can be optimized
>>>>> by adjust the cmci threshold dynamically.
>>>>
>>>> The CE storm caused performance drop is caused by the extra cycles
>>>> spent by the ECC steps in memory controller, not in CMCI handling.
>>>> This is observed in the Google fleet as well. A good solution is to
>>>> monitor the CE rate closely in user space via /dev/mcelog and migrate
>>>> all VMs to another host once the CE rate exceeds some threshold.
>>>>
>>>> CMCI is a _background_ interrupt that is not handled in the process
>>>> execution context and its handler is setup to switch to poll (1 / 5
>>>> min) mode if there are more than ~ a dozen CEs reported via CMCI per
>>>> second.
>>>>>
>>>>> --
>>>>> Peter Xu
>>>>>
>>>
>>> Hi, Andrew, David, Naoya
>>>
>>> According to the suggestions, I'd give up the improvement of memory
>>> failure on huge page in this series.
>>>
>>> Is it worth recovering corrupted pages for the guest kernel? I'd follow
>>> your decision.
>>
>> Well, as I said, I am not sure if we really need/want this for a handful
>> of 4k poisoned pages in a VM. As I suspected, doing so might primarily
>> be interesting for some sort of de-fragmentation (allow again a higher
>> order page to be placed at the affected PFNs), not because of the slight
>> reduction of available memory. A simple VM reboot would get the job
>> similarly done.
>>
> 
> Sure, Let's drop this idea. Thanks to all for the suggestions.

Thanks for the interesting idea + discussions.

Just a note that if you believe that we want/need something like that,
and there is a reasonable use case, please tell us we're wrong and push
back :)

-- 
Thanks,

David / dhildenb

