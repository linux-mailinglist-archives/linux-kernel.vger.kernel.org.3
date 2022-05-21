Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BBD52FE08
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbiEUQHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiEUQHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13F4677F15
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653149255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zEmZQdHTHnyukv03PYK4ijYW3MmF2DErRa+vYpL0aV4=;
        b=A/hrzOvlRrQlYqZhStSMiyoGXNWNNO2t5g4kdeLIq7GabLLjA+x0gHeUlMirWsZ2oN3X3y
        1grWZJTqcKcG18xpTDg7tDy/5p2rEsConBT6p61B6W53tibpzKeBzcdyWfN1n0u0KGs2TX
        +kyLNYaouCbgSG816nnc2YOm1+zotmc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-OBD035cXOJueWj0GPnAgPw-1; Sat, 21 May 2022 12:07:33 -0400
X-MC-Unique: OBD035cXOJueWj0GPnAgPw-1
Received: by mail-ed1-f70.google.com with SMTP id w23-20020aa7da57000000b0042acd76347bso7581735eds.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=zEmZQdHTHnyukv03PYK4ijYW3MmF2DErRa+vYpL0aV4=;
        b=MuQs33SXpSdICRXlPf82Q/I0N4hXryth64RGPB0GI2S6rab+QePJY6zF6NQF+F3zcH
         h9Yir1A+YlW5QKmnQml9k6wrQquber9RP2SEIMspcJYgTA18KSc8eqXWrhjxjboxFq3J
         itFtGBOTfisJ8zvhkWCqQl1WVC6Y7Af7/eGSb8+PsjvlyIcWn3SCsLZgmYeFKQacvBto
         Ys4Pn/yofwZOFx8GULXApfLvbw8W9kp6uqWc5JepQVKbU86XpntrX0+c9SOekveBWUCW
         chrDkOknEYSM5BTT5NSullk/1DEYPscBrlPAgH/LnmljQArtVIEfSS6MEYDt22G40RDd
         O7bA==
X-Gm-Message-State: AOAM531EzC88Kjy9FbinvLn8CNyptNtwQa9ZtJ2H6T9V1gfAG47mP+/H
        fNIe3rsriktadLKZnVoWr2LJo5sxCJ2Wc4xSk6HUeFGKZ4xN0Kxeo+C8IUyxDI9cVNqI5VMD3Yn
        nc1cqBqF+97uBlYtj+yEgUdXT
X-Received: by 2002:a05:6402:524d:b0:42a:f9e9:8013 with SMTP id t13-20020a056402524d00b0042af9e98013mr15080656edd.65.1653149252566;
        Sat, 21 May 2022 09:07:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdpjMVJmJlPFOlsiFKQDHC2Jzo57iB/6ZxKyq3bvzfZFtw58NeDUiz3GtqrSeSSEi/eB0F+g==
X-Received: by 2002:a05:6402:524d:b0:42a:f9e9:8013 with SMTP id t13-20020a056402524d00b0042af9e98013mr15080623edd.65.1653149252328;
        Sat, 21 May 2022 09:07:32 -0700 (PDT)
Received: from [172.29.4.249] ([45.90.93.190])
        by smtp.gmail.com with ESMTPSA id r22-20020a170906351600b006f3ef214ddcsm407359eja.66.2022.05.21.09.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 09:07:31 -0700 (PDT)
Message-ID: <d1810538-9b4c-7f19-852f-7f6d255533c7@redhat.com>
Date:   Sat, 21 May 2022 18:07:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Chih-En Lin <shiyn.lin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
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
        Jim Huang <jserv.tw@gmail.com>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/6] Introduce Copy-On-Write to Page Table
In-Reply-To: <20220519183127.3909598-1-shiyn.lin@gmail.com>
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

On 19.05.22 20:31, Chih-En Lin wrote:
> When creating the user process, it usually uses the Copy-On-Write (COW)
> mechanism to save the memory usage and the cost of time for copying.
> COW defers the work of copying private memory and shares it across the
> processes as read-only. If either process wants to write in these
> memories, it will page fault and copy the shared memory, so the process
> will now get its private memory right here, which is called break COW.

Yes. Lately we've been dealing with advanced COW+GUP pinnings (which
resulted in PageAnonExclusive, which should hit upstream soon), and
hearing about COW of page tables (and wondering how it will interact
with the mapcount, refcount, PageAnonExclusive of anonymous pages) makes
me feel a bit uneasy :)

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


I'm missing the most important point: why do we care and why should we
care to make our COW/fork implementation even more complicated?

Yes, we might save some page tables and we might reduce the fork() time,
however, which specific workload really benefits from this and why do we
really care about that workload? Without even hearing about an example
user in this cover letter (unless I missed it), I naturally wonder about
relevance in practice.

I assume it really only matters if we fork() realtively large processes,
like databases for snapshotting. However, fork() is already a pretty
sever performance hit due to COW, and there are alternatives getting
developed as a replacement for such use cases (e.g., uffd-wp).

I'm also missing a performance evaluation: I'd expect some simple
workloads that use fork() might be even slower after fork() with this
change.

(I don't have time to read the paper, I'd expect an independent summary
in the cover letter)


I have tons of questions regarding rmap, accounting, GUP, page table
walkers, OOM situations in page walkers, but at this point I am not
(yet) convinced that the added complexity is really worth it. So I'd
appreciate some additional information.



[...]

> TODO list:
> - Handle the swap

Scary if that's not easy to handle :/

> - Rewrite the TLB flush for zapping the COW PTE table.
> - Experiment COW to the entire page table. (Now just for PTE level)
> - Bug in some case from copy_pte_range()::vm_normal_page()::print_bad_pte().
> - Bug of Bad RSS counter in multiple times COW PTE table forking.



-- 
Thanks,

David / dhildenb

