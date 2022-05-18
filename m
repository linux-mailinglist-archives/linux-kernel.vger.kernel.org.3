Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FBB52BEAC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbiEROvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239091AbiEROvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EF7213E9D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652885477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qb8my2fczKVu20tRdn0IXcPprd3BkcG8GVQrCiJBFwI=;
        b=Cvq55359mLAdNsAPLmzKVCoOv8NBKd1RG355ihJ5ImjY0pQ6504CpKuxTlbu5R50KG2PG1
        prI0iJdODp5aIE2DkY/Z+WdwYNToVLBibKNUcAyeWHOg1Doj2iiHr0mg7cl+zXmES/bdH2
        2BXSRKgoLG6tmudWqCstD2owc1m7V8s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-mrWGTXEnMbumtBNZrjvm7g-1; Wed, 18 May 2022 10:51:16 -0400
X-MC-Unique: mrWGTXEnMbumtBNZrjvm7g-1
Received: by mail-ed1-f71.google.com with SMTP id w5-20020a056402128500b0042aa2647eb6so1779206edv.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=qb8my2fczKVu20tRdn0IXcPprd3BkcG8GVQrCiJBFwI=;
        b=44nqucmECCXdNNlDvGCFawiUd/ZyhoyevbPblgbKNISCIGqM2ctFbhmGuwTsyx1H/1
         D/kFBEJzaezrgVvbtq3LcqQ1rarHQUdvq9VS9xuVSCxO0scQnZGBD4PG1YNaW22FK79u
         fs/4wH/EJhEcW44xJSFoQYHUEn5VPS/n0r7EuH28JvCslFx93uvPaocdjJicvHRwfxTu
         Yw1HpeaMk9v2qHj/BN+IJg6S780FVKGQdBGHZI7WqS9fk9Td/oUFayu+YROYyu3KN88Y
         N7YukTSLu8tpRyA3YBJ2S/PKzwWP8hS6Yz31QDNhQbgWh8Af6QOqymoYwD8JZId8Cd/1
         XT7A==
X-Gm-Message-State: AOAM531jENymG9E7f0kcMGPUR9udL122X3Wjl9mK3UoC/mwxDpifqC/y
        x8UKO64ZS9Eig/4Uobzw2LZD4Na9hpODZlnGEF5K64cjqRUELgQsqPb7OEtxi/Wz3Vch8CPeiLK
        qMlYRic7KKimXdngdVB/RoqIL
X-Received: by 2002:a17:906:c109:b0:6f4:d700:2e66 with SMTP id do9-20020a170906c10900b006f4d7002e66mr25007084ejc.738.1652885474591;
        Wed, 18 May 2022 07:51:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmzs57k/68Qokor/FvHbio0zYGP5h1PlDbp4XTszFDGA6dpLXKw1qKh1lZMzCBSxCvDlIUFg==
X-Received: by 2002:a17:906:c109:b0:6f4:d700:2e66 with SMTP id do9-20020a170906c10900b006f4d7002e66mr25007055ejc.738.1652885474283;
        Wed, 18 May 2022 07:51:14 -0700 (PDT)
Received: from [172.29.4.249] ([45.90.93.190])
        by smtp.gmail.com with ESMTPSA id hy11-20020a1709068a6b00b006f3ef214e75sm994119ejc.219.2022.05.18.07.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 07:51:13 -0700 (PDT)
Message-ID: <37055be1-05af-f7ef-c33e-27f90fa0f9ca@redhat.com>
Date:   Wed, 18 May 2022 16:51:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, akpm@linux-foundation.org,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
 <8c51d9ae-5a8e-74a9-ddc2-70b5fcd38427@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 00/18] Try to free user PTE page table pages
In-Reply-To: <8c51d9ae-5a8e-74a9-ddc2-70b5fcd38427@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.22 10:30, Qi Zheng wrote:
> 
> 
> On 2022/4/29 9:35 PM, Qi Zheng wrote:
>> Hi,
>>
>> This patch series aims to try to free user PTE page table pages when no one is
>> using it.
>>
>> The beginning of this story is that some malloc libraries(e.g. jemalloc or
>> tcmalloc) usually allocate the amount of VAs by mmap() and do not unmap those
>> VAs. They will use madvise(MADV_DONTNEED) to free physical memory if they want.
>> But the page tables do not be freed by madvise(), so it can produce many
>> page tables when the process touches an enormous virtual address space.
>>
>> The following figures are a memory usage snapshot of one process which actually
>> happened on our server:
>>
>>          VIRT:  55t
>>          RES:   590g
>>          VmPTE: 110g
>>
>> As we can see, the PTE page tables size is 110g, while the RES is 590g. In
>> theory, the process only need 1.2g PTE page tables to map those physical
>> memory. The reason why PTE page tables occupy a lot of memory is that
>> madvise(MADV_DONTNEED) only empty the PTE and free physical memory but
>> doesn't free the PTE page table pages. So we can free those empty PTE page
>> tables to save memory. In the above cases, we can save memory about 108g(best
>> case). And the larger the difference between the size of VIRT and RES, the
>> more memory we save.
>>
>> In this patch series, we add a pte_ref field to the struct page of page table
>> to track how many users of user PTE page table. Similar to the mechanism of page
>> refcount, the user of PTE page table should hold a refcount to it before
>> accessing. The user PTE page table page may be freed when the last refcount is
>> dropped.
>>
>> Different from the idea of another patchset of mine before[1], the pte_ref
>> becomes a struct percpu_ref type, and we switch it to atomic mode only in cases
>> such as MADV_DONTNEED and MADV_FREE that may clear the user PTE page table
>> entryies, and then release the user PTE page table page when checking that
>> pte_ref is 0. The advantage of this is that there is basically no performance
>> overhead in percpu mode, but it can also free the empty PTEs. In addition, the
>> code implementation of this patchset is much simpler and more portable than the
>> another patchset[1].
> 
> Hi David,
> 
> I learned from the LWN article[1] that you led a session at the LSFMM on
> the problems posed by the lack of page-table reclaim (And thank you very
> much for mentioning some of my work in this direction). So I want to
> know, what are the further plans of the community for this problem?

Hi,

yes, I talked about the involved challenges, especially, how malicious
user space can trigger allocation of almost elusively page tables and
essentially consume a lot of unmovable+unswappable memory and even store
secrets in the page table structure.

Empty PTE tables is one such case we care about, but there is more. Even
with your approach, we can still end up with many page tables that are
allocated on higher levels (e.g., PMD tables) or page tables that are
not empty (especially, filled with the shared zeropage).

Ideally, we'd have some mechanism that can reclaim also other
reclaimable page tables (e.g., filled with shared zeropage). One idea
was to add reclaimable page tables to the LRU list and to then
scan+reclaim them on demand. There are multiple challenges involved,
obviously. One is how to synchronize against concurrent page table
walkers, another one is how to invalidate MMU notifiers from reclaim
context. It would most probably involve storing required information in
the memmap to be able to lock+synchronize.

Having that said, adding infrastructure that might not be easy to extend
to the more general case of reclaiming other reclaimable page tables on
multiple levels (esp PMD tables) might not be what we want. OTOH, it
gets the job done for once case we care about.

It's really hard to tell what to do because reclaiming page tables and
eventually handling malicious user space correctly is far from trivial :)

I'll be on vacation until end of May, I'll come back to this mail once
I'm back.

-- 
Thanks,

David / dhildenb

