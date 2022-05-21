Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F7C52FF5F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 22:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245289AbiEUU3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 16:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiEUU3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 16:29:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A6B45A2C4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653164946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l2rd6z+aj/tuB8cg5bDKCIXQg0ISWpKUU0eJWv7WGlM=;
        b=K9b9Dmh7SSLfkzMiUFrDQv1860Ygc1Z4XesngV4UX21FfUQHhV79s+9EUU0PQmSJKJ5/H7
        y/xm9bet3AcgeXterVam5HnSpPtd7Jc4/12KiiipNyLfo32hFWKTB5AObaLGhkH4t7yelE
        DPPakGKkYVne21jzOIuo4VyD2Binh1o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-NaGe0ceoMtyeDQlRtIqtlg-1; Sat, 21 May 2022 16:29:05 -0400
X-MC-Unique: NaGe0ceoMtyeDQlRtIqtlg-1
Received: by mail-ed1-f72.google.com with SMTP id w14-20020a50fa8e000000b0042ab142d677so7886235edr.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=l2rd6z+aj/tuB8cg5bDKCIXQg0ISWpKUU0eJWv7WGlM=;
        b=mlu3Q2Dg0GZc4gpN08D6aRg+3sGZBtBx8TaGNuvf9/QH6CY4NoyOcPI4EDnuRQZwSB
         oqpQvv1Jg1ErP3Dq45eF2HK2s5AZmWn2zM8E9IhuU9voo3F3wb4ojxwgxFr2DKUjB3xW
         l23xUb8m+U3f12yxrMg/FDt0t+579RuuS5rIMQxO+mbgVs4t0FDIlQpoZrqy25aTQAhn
         8oGgNWRYgqYVXW/iuQPBjN/JN5HdC2w2tTV1edr18imX0G6DslvAwSb5V0pAcgfRGPl1
         1cwZnjBnaZpJYb6A7crEjkTEZhZsVAn/qeScRE2rygjcBSwqvE6xNMkjzdxkS0Qu+dmz
         vbmQ==
X-Gm-Message-State: AOAM5303TQro08g33o7rnniChAgbru/IYU3BhxGn2BQpve4WuXl1Lva4
        AKmxkudd5y24hMywGWGq8moC5Y7cT3/6KnIecgZugfV/uHV4Nn22Lr1r0R/EmGfXVJxgqQ5wqZa
        4Tgqi+7qY0/VI0kaq6xpzqK42
X-Received: by 2002:a17:906:99c3:b0:6f4:b02a:d53b with SMTP id s3-20020a17090699c300b006f4b02ad53bmr13328109ejn.331.1653164943855;
        Sat, 21 May 2022 13:29:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYbs393kTM1pCpblXsuEBNlBEDLwRom5qe400oDZeR/4L0vf7QhkhXGo9Bv0Ta/xzPwyec+Q==
X-Received: by 2002:a17:906:99c3:b0:6f4:b02a:d53b with SMTP id s3-20020a17090699c300b006f4b02ad53bmr13328063ejn.331.1653164943534;
        Sat, 21 May 2022 13:29:03 -0700 (PDT)
Received: from [172.29.4.249] ([45.90.93.190])
        by smtp.gmail.com with ESMTPSA id s9-20020a170906778900b006f3ef214df5sm4624415ejm.91.2022.05.21.13.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 13:29:02 -0700 (PDT)
Message-ID: <c931c9dc-c0ed-05f3-7364-a06088ca7754@redhat.com>
Date:   Sat, 21 May 2022 22:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Chih-En Lin <shiyn.lin@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Colin Cross <ccross@google.com>,
        Feng Tang <feng.tang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel@vger.kernel.org, Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <d1810538-9b4c-7f19-852f-7f6d255533c7@redhat.com>
 <20220521185004.GA1543057@strix-laptop>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/6] Introduce Copy-On-Write to Page Table
In-Reply-To: <20220521185004.GA1543057@strix-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.05.22 20:50, Chih-En Lin wrote:
> On Sat, May 21, 2022 at 06:07:27PM +0200, David Hildenbrand wrote:
>> On 19.05.22 20:31, Chih-En Lin wrote:
>>> When creating the user process, it usually uses the Copy-On-Write (COW)
>>> mechanism to save the memory usage and the cost of time for copying.
>>> COW defers the work of copying private memory and shares it across the
>>> processes as read-only. If either process wants to write in these
>>> memories, it will page fault and copy the shared memory, so the process
>>> will now get its private memory right here, which is called break COW.
>>
>> Yes. Lately we've been dealing with advanced COW+GUP pinnings (which
>> resulted in PageAnonExclusive, which should hit upstream soon), and
>> hearing about COW of page tables (and wondering how it will interact
>> with the mapcount, refcount, PageAnonExclusive of anonymous pages) makes
>> me feel a bit uneasy :)
> 
> I saw the series patch of this and knew how complicated handling COW of
> the physical page was [1][2][3][4]. So the COW page table will tend to
> restrict the sharing only to the page table. This means any modification
> to the physical page will trigger the break COW of page table.
> 
> Presently implementation will only update the physical page information
> to the RSS of the owner process of COW PTE. Generally owner is the
> parent process. And the state of the page, like refcount and mapcount,
> will not change under the COW page table.
> 
> But if any situations will lead to the COW page table needs to consider
> the state of physical page, it might be fretful. ;-)

I haven't looked into the details of how GUP deals with these COW page
tables. But I suspect there might be problems with page pinning:
skipping copy_present_page() even for R/O pages is usually problematic
with R/O pinnings of pages. I might be just wrong.

> 
>>>
>>> Presently this kind of technology is only used as the mapping memory.
>>> It still needs to copy the entire page table from the parent.
>>> It might cost a lot of time and memory to copy each page table when the
>>> parent already has a lot of page tables allocated. For example, here is
>>> the state table for mapping the 1 GB memory of forking.
>>>
>>> 	    mmap before fork         mmap after fork
>>> MemTotal:       32746776 kB             32746776 kB
>>> MemFree:        31468152 kB             31463244 kB
>>> AnonPages:       1073836 kB              1073628 kB
>>> Mapped:            39520 kB                39992 kB
>>> PageTables:         3356 kB                 5432 kB
>>
>>
>> I'm missing the most important point: why do we care and why should we
>> care to make our COW/fork implementation even more complicated?
>>
>> Yes, we might save some page tables and we might reduce the fork() time,
>> however, which specific workload really benefits from this and why do we
>> really care about that workload? Without even hearing about an example
>> user in this cover letter (unless I missed it), I naturally wonder about
>> relevance in practice.
>>
>> I assume it really only matters if we fork() realtively large processes,
>> like databases for snapshotting. However, fork() is already a pretty
>> sever performance hit due to COW, and there are alternatives getting
>> developed as a replacement for such use cases (e.g., uffd-wp).
>>
>> I'm also missing a performance evaluation: I'd expect some simple
>> workloads that use fork() might be even slower after fork() with this
>> change.
>>
> 
> The paper mentioned a list of benchmarks of the time cost for On-Demand
> fork. For example, on Redis, the meantime of fork when taking the
> snapshot. Default fork() got 7.40 ms; On-demand Fork (COW PTE table) got
> 0.12 ms. But there are some other cases, like the Response latency
> distribution of Apache HTTP Server, are not have significant benefits
> from their On-demand fork.

Thanks. I expected that snapshotting would pop up and be one of the most
prominent users that could benefit. However, for that specific use case
I am convinced that uffd-wp is the better choice and fork() is just the
old way of doing it. having nothing better at hand. QEMU already
implements snapshotting of VMs that way and I remember that redis also
intended to implement support for uffd-wp. Not sure what happened with
that and if there is anything missing to make it work.

> 
> For the COW page table from this patch, I also take the perf to analyze
> the cost time. But it looks like not different from the default fork.

Interesting, thanks for sharing.

> 
> Here is the report, the mmap-sfork is COW page table version:
> 
>  Performance counter stats for './mmap-fork' (100 runs):
> 
>             373.92 msec task-clock                #    0.992 CPUs utilized            ( +-  0.09% )
>                  1      context-switches          #    2.656 /sec                     ( +-  6.03% )
>                  0      cpu-migrations            #    0.000 /sec
>                881      page-faults               #    2.340 K/sec                    ( +-  0.02% )
>      1,860,460,792      cycles                    #    4.941 GHz                      ( +-  0.08% )
>      1,451,024,912      instructions              #    0.78  insn per cycle           ( +-  0.00% )
>        310,129,843      branches                  #  823.559 M/sec                    ( +-  0.01% )
>          1,552,469      branch-misses             #    0.50% of all branches          ( +-  0.38% )
> 
>           0.377007 +- 0.000480 seconds time elapsed  ( +-  0.13% )
> 
>  Performance counter stats for './mmap-sfork' (100 runs):
> 
>             373.04 msec task-clock                #    0.992 CPUs utilized            ( +-  0.10% )
>                  1      context-switches          #    2.660 /sec                     ( +-  6.58% )
>                  0      cpu-migrations            #    0.000 /sec
>                877      page-faults               #    2.333 K/sec                    ( +-  0.08% )
>      1,851,843,683      cycles                    #    4.926 GHz                      ( +-  0.08% )
>      1,451,763,414      instructions              #    0.78  insn per cycle           ( +-  0.00% )
>        310,270,268      branches                  #  825.352 M/sec                    ( +-  0.01% )
>          1,649,486      branch-misses             #    0.53% of all branches          ( +-  0.49% )
> 
>           0.376095 +- 0.000478 seconds time elapsed  ( +-  0.13% )
> 
> So, the COW of the page table may reduce the time of forking. But it
> builds on the transfer of the copy work to other modified operations
> to the physical page.

Right.

> 
>> I have tons of questions regarding rmap, accounting, GUP, page table
>> walkers, OOM situations in page walkers, but at this point I am not
>> (yet) convinced that the added complexity is really worth it. So I'd
>> appreciate some additional information.
> 
> It seems like I have a lot of work to do. ;-)

Messing with page tables and COW is usually like opening a can of worms :)

-- 
Thanks,

David / dhildenb

