Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25D352FA22
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 11:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiEUI7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 04:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiEUI7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 04:59:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC656A026
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 01:59:34 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j6so9533191pfe.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 01:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E0WYc4yl2hOxvVjD014+BuN0fQK0E8cu7fTbPkWjvWI=;
        b=weN7et924AvUjIP1i8JWA1zL+56fviklm7Aa1heNvbw4MBgbI3uJR454IV1k+DE0ZI
         Q/7l4h6d59R4X4ZsN3XKqcm7VOv7I11IZyk5g3fl5nUdOsaHrplUI/CmedG2geSnSimU
         +zcFW0DiFzZ2fac5NArpyiNIlySMEjlY6L8nDH5/B43oQ3LjM3ko9SplFEOfFeoY+V1T
         RxZiaWNp/rLfb4VZI35L30w+ix46kx4JVu3Jv47IJckKKwWuo67Ec2kobQeqdrLamBVz
         avWyXwuN+XbVjJzbaWnhfXJjv7UAuqzUr7udXxXQx7YOayobPpwEQD6nUyaN6bCx/P6X
         s1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E0WYc4yl2hOxvVjD014+BuN0fQK0E8cu7fTbPkWjvWI=;
        b=QCL+s9lLcxP2VHW2NCprY3OyiBIpC8XsDtIOA5qBhFR0hzFNOTfXtmKM0vc1edVxPn
         HDnKY3cx5io1+FNcjYb55KGTNfjsvbQUH0D052aJO7WME23FAGhRTU1Dg+is8DwRikS7
         cUysEkiDYYcdUhmzjWZTrYvF1pVu7s+2Jp+K7G/DfkSPuE3GhaslHA1RUK69NA5tH4JY
         TR0ujyWZQAucV23BxoZJnBaZxdyTFcZweSFGZIHbOwdHdN/fPdowS3oFzoPaTRbJoZ8T
         v+wcRChJjQIicNO4Hv/SgyuVxFSou2UX4rn7fdQgvy4tbeABmJ9fC7fPbMnjANQJt/OT
         9MyA==
X-Gm-Message-State: AOAM533Y0YLlqVkUIxKVlgVKMkwZ21v0UFRntibUBhYsXj5o3FA12KYl
        KmU9rR75eAKQy0QrcxrJjjx/dg==
X-Google-Smtp-Source: ABdhPJzOGq7Qvr7EqDbQ61V2idkOnETVQHJJUKZD2Z9unbLOUcA9SSSGfFJvRBY4sSfDpc6Yom6wTg==
X-Received: by 2002:a65:550c:0:b0:3da:fde8:62d7 with SMTP id f12-20020a65550c000000b003dafde862d7mr11904351pgr.334.1653123574410;
        Sat, 21 May 2022 01:59:34 -0700 (PDT)
Received: from [10.5.104.119] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902eacc00b0015e8d4eb288sm1063271pld.210.2022.05.21.01.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 01:59:33 -0700 (PDT)
Message-ID: <f9ccf33b-c81c-6b25-6471-80c600f06732@bytedance.com>
Date:   Sat, 21 May 2022 16:59:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [External] [RFC PATCH 0/6] Introduce Copy-On-Write to Page Table
Content-Language: en-US
To:     Chih-En Lin <shiyn.lin@gmail.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
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
        Jim Huang <jserv.tw@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220519183127.3909598-1-shiyn.lin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/20 2:31 AM, Chih-En Lin wrote:
> When creating the user process, it usually uses the Copy-On-Write (COW)
> mechanism to save the memory usage and the cost of time for copying.
> COW defers the work of copying private memory and shares it across the
> processes as read-only. If either process wants to write in these
> memories, it will page fault and copy the shared memory, so the process
> will now get its private memory right here, which is called break COW.
> 
> Presently this kind of technology is only used as the mapping memory.
> It still needs to copy the entire page table from the parent.
> It might cost a lot of time and memory to copy each page table when the
> parent already has a lot of page tables allocated. For example, here is
> the state table for mapping the 1 GB memory of forking.
> 
> 	    mmap before fork         mmap after fork
> MemTotal:       32746776 kB             32746776 kB
> MemFree:        31468152 kB             31463244 kB
> AnonPages:       1073836 kB              1073628 kB
> Mapped:            39520 kB                39992 kB
> PageTables:         3356 kB                 5432 kB
> 
> This patch introduces Copy-On-Write to the page table. This patch only
> implements the COW on the PTE level. It's based on the paper
> On-Demand Fork [1]. Summary of the implementation for the paper:
> 
> - Only implements the COW to the anonymous mapping
> - Only do COW to the PTE table which the range is all covered by a
>    single VMA.
> - Use the reference count to control the COW PTE table lifetime.
>    Decrease the counter when breaking COW or dereference the COW PTE
>    table. When the counter reduces to zero, free the PTE table.
> 

Hi,

To reduce the empty user PTE tables, I also introduced a reference
count (pte_ref) for user PTE tables in my patch[1][2], It is used
to track the usage of each user PTE tables.

The following people will hold a pte_ref:
  - The !pte_none() entry, such as regular page table entry that map
    physical pages, or swap entry, or migrate entry, etc.
  - Visitor to the PTE page table entries, such as page table walker.

With COW PTE, a new holder (the process using the COW PTE) is added.

It's funny, it leads me to see more meaning of pte_ref.

Thanks,
Qi

[1] [RFC PATCH 00/18] Try to free user PTE page table pages
     link: 
https://lore.kernel.org/lkml/20220429133552.33768-1-zhengqi.arch@bytedance.com/
     (percpu_ref version)

[2] [PATCH v3 00/15] Free user PTE page table pages
     link: 
https://lore.kernel.org/lkml/20211110105428.32458-1-zhengqi.arch@bytedance.com/
     (atomic count version)

-- 
Thanks,
Qi
