Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40963529C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiEQIau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbiEQIar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:30:47 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E362AE0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:30:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f10so4819068pjs.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2robtToebhCJsj//+rjVAeUiUWyJBEWRWL7VlRXuVdw=;
        b=sRixCFeTMkU8HP8osRxeH2iWC/3m6kqziSLu2JTGTSwIzIPoNfPMa4aj4W7jCDPLhV
         2m0mT+0Hk4yrgEUN+arz8BVGLhHFhpaaUnCDmBj3XUEUQzg+7d+Qj924AoSmZGAHMiBp
         kmPid0yZqL/cHNQJdJSa5b0ohBkhk3mhm7OKryJB77nt5YMXN06zqJ3aoAn7asNyBK6I
         K1lOxbu/I/e4LhLe8qiGDcobBnMqYY7PK2+yww38QH6+bG0R3NMVzbCGwU/wsQ+NLrGD
         NoVqvWvvVm0Q4o/qtBW2Ah7hktpdY+yGIK9hclRbc/O3X+STjmyizT8Rzyk+WuSs9OQg
         ghNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2robtToebhCJsj//+rjVAeUiUWyJBEWRWL7VlRXuVdw=;
        b=0gzvqtUVLGhtibpPiYo9/UEH1UxGHUnUMNNhhJw/XGPNclnrFAZKZgRcDtvDEnzv6C
         EFXEL6DbLe2jUrjftYfrE852EM3sKl2yFstNrO/Zcbm3GSe5cE6nHMLufGv0j/CfFHtQ
         sn4+GpL3sXR8hJKY6c80PZcStHlGCo/U0+V/eDXGt3QVHa713RJ4Esb4M7nNGacGtjVc
         0A/fDGtOFhN3b0hHJBVY04YlScMgqP8fWtVx7HZfs1Of9lDIF+R7kFu93bBQpBCla/WO
         XGgEEkDCr5mmxLbNv9TdguuC0CO0/B2T0DC1ytdT505fwAWMqkbxP8Lj3KFr48u3U2ei
         4xDQ==
X-Gm-Message-State: AOAM532lx+04Pz+2t3mFh0SyX75M79LzPmGpUIOb9gS1Vgy2sdwa7I0j
        LlSMM+4B0KO/7EncLbD1r5HffA==
X-Google-Smtp-Source: ABdhPJy80COtDL5kaZEPgNnbz2MiEgHlQL5wffg2ZGBCyQPaSpadFLGKrn78jo1eoyr2Mhl8etg1iw==
X-Received: by 2002:a17:90a:2a48:b0:1df:42e6:ff21 with SMTP id d8-20020a17090a2a4800b001df42e6ff21mr11726788pjg.209.1652776242582;
        Tue, 17 May 2022 01:30:42 -0700 (PDT)
Received: from [10.254.206.69] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id p26-20020a62b81a000000b00517de3dc3c6sm3663017pfe.84.2022.05.17.01.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 01:30:41 -0700 (PDT)
Message-ID: <8c51d9ae-5a8e-74a9-ddc2-70b5fcd38427@bytedance.com>
Date:   Tue, 17 May 2022 16:30:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 00/18] Try to free user PTE page table pages
Content-Language: en-US
To:     david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, akpm@linux-foundation.org,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/29 9:35 PM, Qi Zheng wrote:
> Hi,
> 
> This patch series aims to try to free user PTE page table pages when no one is
> using it.
> 
> The beginning of this story is that some malloc libraries(e.g. jemalloc or
> tcmalloc) usually allocate the amount of VAs by mmap() and do not unmap those
> VAs. They will use madvise(MADV_DONTNEED) to free physical memory if they want.
> But the page tables do not be freed by madvise(), so it can produce many
> page tables when the process touches an enormous virtual address space.
> 
> The following figures are a memory usage snapshot of one process which actually
> happened on our server:
> 
>          VIRT:  55t
>          RES:   590g
>          VmPTE: 110g
> 
> As we can see, the PTE page tables size is 110g, while the RES is 590g. In
> theory, the process only need 1.2g PTE page tables to map those physical
> memory. The reason why PTE page tables occupy a lot of memory is that
> madvise(MADV_DONTNEED) only empty the PTE and free physical memory but
> doesn't free the PTE page table pages. So we can free those empty PTE page
> tables to save memory. In the above cases, we can save memory about 108g(best
> case). And the larger the difference between the size of VIRT and RES, the
> more memory we save.
> 
> In this patch series, we add a pte_ref field to the struct page of page table
> to track how many users of user PTE page table. Similar to the mechanism of page
> refcount, the user of PTE page table should hold a refcount to it before
> accessing. The user PTE page table page may be freed when the last refcount is
> dropped.
> 
> Different from the idea of another patchset of mine before[1], the pte_ref
> becomes a struct percpu_ref type, and we switch it to atomic mode only in cases
> such as MADV_DONTNEED and MADV_FREE that may clear the user PTE page table
> entryies, and then release the user PTE page table page when checking that
> pte_ref is 0. The advantage of this is that there is basically no performance
> overhead in percpu mode, but it can also free the empty PTEs. In addition, the
> code implementation of this patchset is much simpler and more portable than the
> another patchset[1].

Hi David,

I learned from the LWN article[1] that you led a session at the LSFMM on
the problems posed by the lack of page-table reclaim (And thank you very
much for mentioning some of my work in this direction). So I want to
know, what are the further plans of the community for this problem?

For the way of adding pte_ref to each PTE page table page, I currently
posted two versions: atomic count version[2] and percpu_ref version(This
patchset).

For the atomic count version:
- Advantage: PTE pages can be freed as soon as the reference count drops
              to 0.
- Disadvantage: The addition and subtraction of pte_ref are atomic
                 operations, which have a certain performance overhead,
                 but should not become a performance bottleneck until the
                 mmap_lock contention problem is resolved.

For the percpu_ref version:
- Advantage: In the percpu mode, the addition and subtraction of the
              pte_ref are all operations on local cpu variables, there
              is basically no performance overhead.
Disadvantage: Need to explicitly convert the pte_ref to atomic mode so
               that the unused PTE pages can be freed.

There are still many places to optimize the code implementation of these
two versions. But before I do further work, I would like to hear your
and the community's views and suggestions on these two versions.

Thanks,
Qi

[1]: https://lwn.net/Articles/893726 (Ways to reclaim unused page-table 
pages)
[2]: 
https://lore.kernel.org/lkml/20211110105428.32458-1-zhengqi.arch@bytedance.com/

> 

-- 
Thanks,
Qi
