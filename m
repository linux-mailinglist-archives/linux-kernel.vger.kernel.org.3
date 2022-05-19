Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89EF52CA98
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 05:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbiESD7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 23:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiESD7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 23:59:12 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BB2DFA7
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 20:59:11 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y41so3994666pfw.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 20:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jgzwIp+OLqmV4OrwP8NZjS9UzJNPt/KLVim9ZoWuO2s=;
        b=Q3IF358UtjRo01Rw7Uxhizqgu6PT+HfYRMWgSHoDIvhjDIA5Daxjy/coNvC5gB/6jT
         U4MHSFWPzoPZfcryNbtRDxPaxpoyEghT9ii39CTQaJvdrsG7wXuOnRCY8kIsi5rQhIBT
         hT67XUXbWkOUYSgCCbCS4hraUKwfHC+Z3mvkJAqrd9OP+T/a1emdrp3Ry5oVgUnCs8/C
         N4rbGtvX+0sywF4OYA0ubMvof58c17dIYr/nTD0FnnF3Decb0wnNfSGbQC2APzk6q1W4
         IEyM1yfuYFZv214PdaHPm0tlXlwy108wBaLbnq7tIHbf1I0e5pOLuqL5wzEEQ10TL0as
         g9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jgzwIp+OLqmV4OrwP8NZjS9UzJNPt/KLVim9ZoWuO2s=;
        b=lS5dKrfDBmVQ5LBFft8Fpb1oW66blT/7+nmjN1aaSp+/4vvLSrZ0ZDwsbuoOmYykat
         L+kc1pM9ACheeUMRkJyQ3yh9xp0Yf9GuDEebCw3N0F+Ul810T00KQ8Ea0Btx2+GEc0Hm
         qETy9Vf+SDxrluvuIEm0q/j5UGCj9KyXjhR/FLau9U/ttLEO4HOZSkFmsbget56jaRY3
         zM2nYsv43ZLeZgZVWSCozpipVG/Mm16w7beLp0UjBNClSoGPulfoGZn1kgfpEGcTx8zS
         SjAGviPhBIeXZ2DmCI1f61KCZtPuwR0MEVpZNXtlvY3tcRwJClcXn+Cl8Fl8pCYJWXtF
         a2Dw==
X-Gm-Message-State: AOAM531g9enaEqdS1N/a9H1FstDts8+6EYqMDE2fP0feRFApQ6E5zGEf
        7IAOFAsEm42rQm9+zZTVnXu+KA==
X-Google-Smtp-Source: ABdhPJz/KxbhH/zBrf3OLSkZTNGNkIGNa+MVOM+9QLitznVlr6UaoJP3iAuiiwNVlQ1MPXbw7yt4EQ==
X-Received: by 2002:a63:6d8c:0:b0:3f6:3ff:234d with SMTP id i134-20020a636d8c000000b003f603ff234dmr2354200pgc.320.1652932751187;
        Wed, 18 May 2022 20:59:11 -0700 (PDT)
Received: from [10.70.252.135] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b0015e9d4a5d27sm2483691pla.23.2022.05.18.20.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 20:59:10 -0700 (PDT)
Message-ID: <4cd048bb-49b4-bd84-1d89-95dbb3bfa0fc@bytedance.com>
Date:   Thu, 19 May 2022 11:58:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 00/18] Try to free user PTE page table pages
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, akpm@linux-foundation.org,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
 <8c51d9ae-5a8e-74a9-ddc2-70b5fcd38427@bytedance.com>
 <37055be1-05af-f7ef-c33e-27f90fa0f9ca@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <37055be1-05af-f7ef-c33e-27f90fa0f9ca@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/18 10:51 PM, David Hildenbrand wrote:
> On 17.05.22 10:30, Qi Zheng wrote:
>>
>>
>> On 2022/4/29 9:35 PM, Qi Zheng wrote:
>>> Hi, >>>
>>> Different from the idea of another patchset of mine before[1], the pte_ref
>>> becomes a struct percpu_ref type, and we switch it to atomic mode only in cases
>>> such as MADV_DONTNEED and MADV_FREE that may clear the user PTE page table
>>> entryies, and then release the user PTE page table page when checking that
>>> pte_ref is 0. The advantage of this is that there is basically no performance
>>> overhead in percpu mode, but it can also free the empty PTEs. In addition, the
>>> code implementation of this patchset is much simpler and more portable than the
>>> another patchset[1].
>>
>> Hi David,
>>
>> I learned from the LWN article[1] that you led a session at the LSFMM on
>> the problems posed by the lack of page-table reclaim (And thank you very
>> much for mentioning some of my work in this direction). So I want to
>> know, what are the further plans of the community for this problem?
> 
> Hi,
> 
> yes, I talked about the involved challenges, especially, how malicious
> user space can trigger allocation of almost elusively page tables and
> essentially consume a lot of unmovable+unswappable memory and even store
> secrets in the page table structure.

It is indeed difficult to deal with malicious user space programs,
because as long as there is an entry in PTE page table page that
maps the physical page, the entire PTE page cannot be freed.

So maybe we should first solve the problems encountered in engineering
practice. We encountered the problems I mentioned in the cover letter
several times on our server:

	VIRT:  55t
         RES:   590g
         VmPTE: 110g

They are not malicious programs, they just use jemalloc/tcmalloc
normally (currently jemalloc/tcmalloc often uses mmap+madvise instead
of mmap+munmap to improve performance). And we checked and found taht
most of these VmPTEs are empty.

Of course, normal operations may also lead to the consequences of
similar malicious programs, but we have not found such examples
on our servers.

> 
> Empty PTE tables is one such case we care about, but there is more. Even
> with your approach, we can still end up with many page tables that are
> allocated on higher levels (e.g., PMD tables) or page tables that are

Yes, currently my patch does not consider PMD tables. The reason is that
its maximum memory consumption is only 1G on 64-bits system, the impact
is smaller that 512G of PTE tables.

> not empty (especially, filled with the shared zeropage).

This case is indeed a problem, and more difficult. :(

> 
> Ideally, we'd have some mechanism that can reclaim also other
> reclaimable page tables (e.g., filled with shared zeropage). One idea
> was to add reclaimable page tables to the LRU list and to then
> scan+reclaim them on demand. There are multiple challenges involved,
> obviously. One is how to synchronize against concurrent page table

Agree, the current situation is that holding the read lock of mmap_lock
can ensure that the PTE tables is stable. If the refcount method is not
considered or the logic of the lock that protects the PTE tables is not
changed, then the write lock of mmap_lock should be held to ensure
synchronization (this has a huge impact on performance).

> walkers, another one is how to invalidate MMU notifiers from reclaim
> context. It would most probably involve storing required information in
> the memmap to be able to lock+synchronize.

This may also be a way to explore.

> 
> Having that said, adding infrastructure that might not be easy to extend
> to the more general case of reclaiming other reclaimable page tables on
> multiple levels (esp PMD tables) might not be what we want. OTOH, it
> gets the job done for once case we care about.
> 
> It's really hard to tell what to do because reclaiming page tables and
> eventually handling malicious user space correctly is far from trivial :)

Yeah, agree :(

> 
> I'll be on vacation until end of May, I'll come back to this mail once
> I'm back.
> 

OK, thanks, and have a nice holiday.

-- 
Thanks,
Qi
