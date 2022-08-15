Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4275F59285B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiHOEGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiHOEGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BAF4264F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660536392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/Qyy/TUtlP5wQvlalN7RTOTbhmCvMUhu++naFHk9Mk=;
        b=HfWtzkS9pQs5vMvmsTvDPJUWOjV3cYHkA4otEidI8RkB9R/N0+cA+WToVL52J87+ANcJWO
        JQylPQfIbVLZVv/3BvA0F3vpOVIOmH4Z9zOXUB2JSk6NTgnc8nB3IRB82GdlfelFqaJSpu
        TXv2C7sZokWtMyxR1VKB13NQ1vkn77M=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-96-9royAawXMq--32HRa2uVHQ-1; Mon, 15 Aug 2022 00:06:28 -0400
X-MC-Unique: 9royAawXMq--32HRa2uVHQ-1
Received: by mail-lf1-f72.google.com with SMTP id z3-20020a19f703000000b0048ae517ee7bso1014713lfe.14
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=g/Qyy/TUtlP5wQvlalN7RTOTbhmCvMUhu++naFHk9Mk=;
        b=H/Al9sjf4TnOQ0uhQVn9BWDieUCOSbjq8526bAB8WVRRlHtz3WzJF+jI7a3b4FVBbW
         g49gr/G4CIeICsMz+2yS8iOIz2RbuvQhVyMAmmooHApUfF7zEqmgaR5a4LkvAYyf3HKl
         MtH2RcDZ7RVR+XXoiPaXfLSg+wgp9octZi+TaBFe2r36JS1AO9QPfVxN8e6lcuydnyfR
         R6Rd2kTmXZFMMZEtD3gPnGVH/c/51F84udQa+pVSktPO6u3ybTvtVc5Fkde9xBdb181P
         bma7pestMFeIYbDTW5qHjldWNp+95aCnwgetaGzWW4FcZsNxaHxIA/7HMemt+2z6A/vR
         jOzA==
X-Gm-Message-State: ACgBeo33scfvH7+GA4Aywc0f1dcTCAM0PS2hnVGr6Qz2bPiDg31crzhN
        CGlNfghfHAvY+Wmsy7knunphhNEIUdlimBshoEPbR9aniw3U/bDE1sOd7X74XNqA6oCYNEFaWhM
        8z7jlJEb/8qDS0nYzwV/Vg8E=
X-Received: by 2002:a2e:2418:0:b0:25e:43f6:384f with SMTP id k24-20020a2e2418000000b0025e43f6384fmr4431480ljk.361.1660536387126;
        Sun, 14 Aug 2022 21:06:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR52qXe+GKx07PMg/MOOtNKldBHgwnksYeoALnBVSNmwcSekT1p1h2vXeTAa4vGQP4+hGNtN4A==
X-Received: by 2002:a2e:2418:0:b0:25e:43f6:384f with SMTP id k24-20020a2e2418000000b0025e43f6384fmr4431472ljk.361.1660536386930;
        Sun, 14 Aug 2022 21:06:26 -0700 (PDT)
Received: from [192.168.1.121] (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id g3-20020a2ea4a3000000b0025e5fd96bf6sm1284615ljm.15.2022.08.14.21.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 21:06:26 -0700 (PDT)
Message-ID: <490e670d-40fe-6284-04d9-9be8fd15d49f@redhat.com>
Date:   Mon, 15 Aug 2022 07:06:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] selftests/hmm-tests: Add test for dirty bits
Content-Language: en-US
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linuxram@us.ibm.com,
        paulus@ozlabs.org
References: <a9daea363991c023d0364be22a762405b6c6f5c4.1660281458.git-series.apopple@nvidia.com>
 <8f19b172d32be2e889b837f88b1ba070bf2c97ee.1660281458.git-series.apopple@nvidia.com>
 <1ec090fa-f93b-c197-e5b3-ff2b0d5862ef@redhat.com>
 <87lerqw72n.fsf@nvdebian.thelocal>
 <58be2b37-0c3a-06d8-35f5-50bf4b765fb2@redhat.com>
 <87h72ew4p6.fsf@nvdebian.thelocal>
 <2aa2013a-735d-a96a-2f35-0a44a06d85f0@redhat.com>
In-Reply-To: <2aa2013a-735d-a96a-2f35-0a44a06d85f0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.8.2022 7.05, Mika Penttilä wrote:
> 
> 
> On 15.8.2022 6.21, Alistair Popple wrote:
>>
>> Mika Penttilä <mpenttil@redhat.com> writes:
>>
>>> On 15.8.2022 5.35, Alistair Popple wrote:
>>>> Mika Penttilä <mpenttil@redhat.com> writes:
>>>>
>>>>> Hi Alistair!
>>>>>
>>>>> On 12.8.2022 8.22, Alistair Popple wrote:
>>>> [...]
>>>>
>>>>>> +    buffer->ptr = mmap(NULL, size,
>>>>>> +               PROT_READ | PROT_WRITE,
>>>>>> +               MAP_PRIVATE | MAP_ANONYMOUS,
>>>>>> +               buffer->fd, 0);
>>>>>> +    ASSERT_NE(buffer->ptr, MAP_FAILED);
>>>>>> +
>>>>>> +    /* Initialize buffer in system memory. */
>>>>>> +    for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>>>>>> +        ptr[i] = 0;
>>>>>> +
>>>>>> +    ASSERT_FALSE(write_cgroup_param(cgroup, "memory.reclaim", 
>>>>>> 1UL<<30));
>>>>>> +
>>>>>> +    /* Fault pages back in from swap as clean pages */
>>>>>> +    for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>>>>>> +        tmp += ptr[i];
>>>>>> +
>>>>>> +    /* Dirty the pte */
>>>>>> +    for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>>>>>> +        ptr[i] = i;
>>>>>> +
>>>>>
>>>>> The anon pages are quite likely in memory at this point, and dirty 
>>>>> in pte.
>>>> Why would the pte be dirty? I just confirmed using some modified 
>>>> pagemap
>>>> code that on my system at least this isn't the case.
>>>>
>>>>>> +    /*
>>>>>> +     * Attempt to migrate memory to device, which should fail 
>>>>>> because
>>>>>> +     * hopefully some pages are backed by swap storage.
>>>>>> +     */
>>>>>> +    ASSERT_TRUE(hmm_migrate_sys_to_dev(self->fd, buffer, npages));
>>>>>
>>>>> And pages marked dirty also now. But could you elaborate how and 
>>>>> where the above
>>>>> fails in more detail, couldn't immediately see it...
>>>> Not if you don't have patch 1 of this series applied. If the
>>>> trylock_page() in migrate_vma_collect_pmd() succeeds (which it almost
>>>> always does) it will have cleared the pte without setting PageDirty.
>>>>
>>>
>>> Ah yes but I meant with the patch 1 applied, the comment "Attempt to 
>>> migrate
>>> memory to device, which should fail because hopefully some pages are 
>>> backed by
>>> swap storage" indicates that hmm_migrate_sys_to_dev() would fail..and 
>>> there's
>>> that ASSERT_TRUE which means fail here.
>>>
>>> So I understand the data loss but where is the 
>>> hmm_migrate_sys_to_dev() failing,
>>> with or wihtout patch 1 applied?
>>
>> Oh right. hmm_migrate_sys_to_dev() will fail because the page is in the
>> swap cache, and migrate_vma_*() doesn't currently support migrating
>> pages with a mapping.
>>
> 
> Ok I forgot we skip also page cache pages, not just file pages...

Meant we skip swap cache pages also, not just file pages..



> 
> 
> 
> 
>>>> So now we have a dirty page without PageDirty set and without a dirty
>>>> pte. If this page gets swapped back to disk and is still in the swap
>>>> cache data will be lost because reclaim will see a clean page and won't
>>>> write it out again.
>>>> At least that's my understanding - please let me know if you see
>>>> something that doesn't make sense.
>>>>
>>>>>> +
>>>>>> +    ASSERT_FALSE(write_cgroup_param(cgroup, "memory.reclaim", 
>>>>>> 1UL<<30));
>>>>>> +
>>>>>> +    /* Check we still see the updated data after restoring from 
>>>>>> swap. */
>>>>>> +    for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>>>>>> +        ASSERT_EQ(ptr[i], i);
>>>>>> +
>>>>>> +    hmm_buffer_free(buffer);
>>>>>> +    destroy_cgroup();
>>>>>> +}
>>>>>> +
>>>>>>     /*
>>>>>>      * Read anonymous memory multiple times.
>>>>>>      */
>>>>>
>>>>>
>>>>> --Mika
>>>>
>>

