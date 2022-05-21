Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C0452FED7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 20:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241559AbiEUSuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 14:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiEUSuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 14:50:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A595B3DA
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 11:50:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so14096595pjp.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SU23bumSYKBIUo4teCSWP/ehFQ/sP8yH/N95PptWhVo=;
        b=iXPANNzMLMXwkrJHGa1A4Wgyc+6i++MYhPE1FYdRU94UFUHGgHf/dBBBzh7E9RFCFP
         uO6JakX0/iXGyWSF/+PVIGS9Xzo8UmcEcyQka08qoXUrXXGU6s4l6omiDna8e2gSzTW1
         mW4VLkRVMz7WH0nVgkZcmp+G2KZqvhFv/UtcKFvl1A00CZ/mpt7qc72iinsHGqPdUsaR
         DjXkHBWFglqXUC+/mj3iAGoBpIjjjAOtAC0NQjMv6QFpegU2u8iasvOGhBZFIdbNW1wG
         FAib7B9s4Oq4SMU6ylJmVne5HqGz3auabI9kiG7dXZiNRCNTFKOF09rDK710XLed5lti
         Z1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SU23bumSYKBIUo4teCSWP/ehFQ/sP8yH/N95PptWhVo=;
        b=EpuZgbE68Yo5b42GftdJbCopfDSG//8LXb1pPBvunLCXoxcYJ6aiFsNE7EafpdQYaL
         hMr1/V3b7qfeaZ+4DJ5K9JiZPYVvSidGj1AORD0hDSxVFf1xXCuDkQGHtZm73QVuiSHp
         UJAooQeHJJh0UK9q0C7obq4BygP3dGm4PnfyDaA7LYKrQxpYkxHX/8IVZ7Jw7yeJgEr6
         VHA+Bahu5MUoxe1BomsA28ryabzBKpmXue1UplVz23jm9QVCe0XJqtsGlmCxA3HhKc7w
         s2rQtWFxMen4Im61NpD4w98LGBwUQUOT7MnUHuCRsfsCelHu86sn6gFYk2JhEYK7eP4z
         /iPA==
X-Gm-Message-State: AOAM5311SNi8sPa0jIVSkvQO2DH941zJjLKGS8IQCkIU7MG97SOY8Cd1
        kjJxC4/ynGT1B0OY40wbkr0=
X-Google-Smtp-Source: ABdhPJzwkynMq9YMdxglKGxco/kxdXQ2g96qTaEOCShG7lSodqXT0GQBleiOfMWoH96zPmPWhjsdPw==
X-Received: by 2002:a17:90b:17c4:b0:1de:c92c:ad91 with SMTP id me4-20020a17090b17c400b001dec92cad91mr17666853pjb.169.1653159013179;
        Sat, 21 May 2022 11:50:13 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-15d4-84b3-8c62-a0b8-199e.dynamic-ip6.hinet.net. [2001:b011:20e0:15d4:84b3:8c62:a0b8:199e])
        by smtp.gmail.com with ESMTPSA id h17-20020a656391000000b003db6f4a96c4sm1845630pgv.32.2022.05.21.11.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 11:50:12 -0700 (PDT)
Date:   Sun, 22 May 2022 02:50:04 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     David Hildenbrand <david@redhat.com>
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
Subject: Re: [RFC PATCH 0/6] Introduce Copy-On-Write to Page Table
Message-ID: <20220521185004.GA1543057@strix-laptop>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <d1810538-9b4c-7f19-852f-7f6d255533c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1810538-9b4c-7f19-852f-7f6d255533c7@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 06:07:27PM +0200, David Hildenbrand wrote:
> On 19.05.22 20:31, Chih-En Lin wrote:
> > When creating the user process, it usually uses the Copy-On-Write (COW)
> > mechanism to save the memory usage and the cost of time for copying.
> > COW defers the work of copying private memory and shares it across the
> > processes as read-only. If either process wants to write in these
> > memories, it will page fault and copy the shared memory, so the process
> > will now get its private memory right here, which is called break COW.
> 
> Yes. Lately we've been dealing with advanced COW+GUP pinnings (which
> resulted in PageAnonExclusive, which should hit upstream soon), and
> hearing about COW of page tables (and wondering how it will interact
> with the mapcount, refcount, PageAnonExclusive of anonymous pages) makes
> me feel a bit uneasy :)

I saw the series patch of this and knew how complicated handling COW of
the physical page was [1][2][3][4]. So the COW page table will tend to
restrict the sharing only to the page table. This means any modification
to the physical page will trigger the break COW of page table.

Presently implementation will only update the physical page information
to the RSS of the owner process of COW PTE. Generally owner is the
parent process. And the state of the page, like refcount and mapcount,
will not change under the COW page table.

But if any situations will lead to the COW page table needs to consider
the state of physical page, it might be fretful. ;-)

> > 
> > Presently this kind of technology is only used as the mapping memory.
> > It still needs to copy the entire page table from the parent.
> > It might cost a lot of time and memory to copy each page table when the
> > parent already has a lot of page tables allocated. For example, here is
> > the state table for mapping the 1 GB memory of forking.
> > 
> > 	    mmap before fork         mmap after fork
> > MemTotal:       32746776 kB             32746776 kB
> > MemFree:        31468152 kB             31463244 kB
> > AnonPages:       1073836 kB              1073628 kB
> > Mapped:            39520 kB                39992 kB
> > PageTables:         3356 kB                 5432 kB
> 
> 
> I'm missing the most important point: why do we care and why should we
> care to make our COW/fork implementation even more complicated?
> 
> Yes, we might save some page tables and we might reduce the fork() time,
> however, which specific workload really benefits from this and why do we
> really care about that workload? Without even hearing about an example
> user in this cover letter (unless I missed it), I naturally wonder about
> relevance in practice.
> 
> I assume it really only matters if we fork() realtively large processes,
> like databases for snapshotting. However, fork() is already a pretty
> sever performance hit due to COW, and there are alternatives getting
> developed as a replacement for such use cases (e.g., uffd-wp).
> 
> I'm also missing a performance evaluation: I'd expect some simple
> workloads that use fork() might be even slower after fork() with this
> change.
> 

The paper mentioned a list of benchmarks of the time cost for On-Demand
fork. For example, on Redis, the meantime of fork when taking the
snapshot. Default fork() got 7.40 ms; On-demand Fork (COW PTE table) got
0.12 ms. But there are some other cases, like the Response latency
distribution of Apache HTTP Server, are not have significant benefits
from their On-demand fork.

For the COW page table from this patch, I also take the perf to analyze
the cost time. But it looks like not different from the default fork.

Here is the report, the mmap-sfork is COW page table version:

 Performance counter stats for './mmap-fork' (100 runs):

            373.92 msec task-clock                #    0.992 CPUs utilized            ( +-  0.09% )
                 1      context-switches          #    2.656 /sec                     ( +-  6.03% )
                 0      cpu-migrations            #    0.000 /sec
               881      page-faults               #    2.340 K/sec                    ( +-  0.02% )
     1,860,460,792      cycles                    #    4.941 GHz                      ( +-  0.08% )
     1,451,024,912      instructions              #    0.78  insn per cycle           ( +-  0.00% )
       310,129,843      branches                  #  823.559 M/sec                    ( +-  0.01% )
         1,552,469      branch-misses             #    0.50% of all branches          ( +-  0.38% )

          0.377007 +- 0.000480 seconds time elapsed  ( +-  0.13% )

 Performance counter stats for './mmap-sfork' (100 runs):

            373.04 msec task-clock                #    0.992 CPUs utilized            ( +-  0.10% )
                 1      context-switches          #    2.660 /sec                     ( +-  6.58% )
                 0      cpu-migrations            #    0.000 /sec
               877      page-faults               #    2.333 K/sec                    ( +-  0.08% )
     1,851,843,683      cycles                    #    4.926 GHz                      ( +-  0.08% )
     1,451,763,414      instructions              #    0.78  insn per cycle           ( +-  0.00% )
       310,270,268      branches                  #  825.352 M/sec                    ( +-  0.01% )
         1,649,486      branch-misses             #    0.53% of all branches          ( +-  0.49% )

          0.376095 +- 0.000478 seconds time elapsed  ( +-  0.13% )

So, the COW of the page table may reduce the time of forking. But it
builds on the transfer of the copy work to other modified operations
to the physical page.

> (I don't have time to read the paper, I'd expect an independent summary
> in the cover letter)

Sure, I will add more performance evaluations and descriptions in the
next version.

> I have tons of questions regarding rmap, accounting, GUP, page table
> walkers, OOM situations in page walkers, but at this point I am not
> (yet) convinced that the added complexity is really worth it. So I'd
> appreciate some additional information.

It seems like I have a lot of work to do. ;-)

> 
> [...]
> 
> > TODO list:
> > - Handle the swap
> 
> Scary if that's not easy to handle :/

;-)

> -- 
> Thanks,
> 
> David / dhildenb
>

Thanks!

[1] https://lore.kernel.org/all/20220131162940.210846-1-david@redhat.com/T/
[2] https://lore.kernel.org/linux-mm/20220315104741.63071-2-david@redhat.com/T/
[3] https://lore.kernel.org/linux-mm/51afa7a7-15c5-8769-78db-ed2d134792f4@redhat.com/T/
[4] https://lore.kernel.org/all/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com/
