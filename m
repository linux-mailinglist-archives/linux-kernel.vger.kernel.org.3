Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708B9508E31
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380987AbiDTRQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbiDTRQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAFBF457A9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650474826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YUXfwOQompnJdIwVAr+ky90k3csgxSJYtFYxvhspJD8=;
        b=jBl1gmg6wPwLvVy+n5LEz1cBblL+6eeTmypLE3g+NlFdcUvl/JOa1EPCaFqBe0yCLCzuZq
        ay8nC4fqegacmTvzywG8D1tgPny6+mzYNpOamAhkR4xvjPSskD4zORFWurr4tjLQEVwzc+
        GWb8sH1K84KTed4ewb07KESHBQ5YDJk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-s8hxY59HP1KhFjzehQSw4w-1; Wed, 20 Apr 2022 13:13:45 -0400
X-MC-Unique: s8hxY59HP1KhFjzehQSw4w-1
Received: by mail-wm1-f70.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so1222107wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=YUXfwOQompnJdIwVAr+ky90k3csgxSJYtFYxvhspJD8=;
        b=S6iF1PotjeaRCsk7846OhoojX0yBG9BdKc5WLA5FGTbeQxhfhTMEcGlISLz6/2s+Xb
         NVfko7g79mD+jebwf8zRW3t6z9mB2c2BpWaPSDHijelsMKyQQ+adIrZCISOfch1Lt5A9
         egdTVLJA37tbYqt+4JNmQQxMOZD8E3qrIwtFK4SG/t4f9dWsC8fA6upo41uSd/o2qSPG
         ZqDyyZ6t4Z2M6Z2JemEWKnrIgeag7E1smISNFadfNyajkc3OEUhfrzEaTnKqKTcdfn0u
         pP+KnpMSBu8FvLSZYPyC3qNtoxO4ebUnyZ5iPgoul7uXg3ZqLtFJm+2nnLB4CkPU2UlQ
         G5Sg==
X-Gm-Message-State: AOAM531QW0phYFRp5relCAWD4l8plGOvX5wt7Y+ujJnBTsQe2c9yEXVh
        fcOZNy66o7nC647HEkz9k1ymSDjx9zRnxVhe8/H8/Km3zJ6u1so75XgPokD/XJp54mRp4hXyg7A
        nyWMOWp7vJv0xZmBeR9U0WNQE
X-Received: by 2002:a1c:21c5:0:b0:38e:b464:6a39 with SMTP id h188-20020a1c21c5000000b0038eb4646a39mr4624133wmh.186.1650474824361;
        Wed, 20 Apr 2022 10:13:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnxBGE3mnfNhX3DGODQmYyZGAR1i8EPUCCup/XZY5QMpdpdOqavd/9L1y6Dj1QMznlK0qbGA==
X-Received: by 2002:a1c:21c5:0:b0:38e:b464:6a39 with SMTP id h188-20020a1c21c5000000b0038eb4646a39mr4624108wmh.186.1650474824060;
        Wed, 20 Apr 2022 10:13:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:3d00:23e4:4c84:67a5:3ccf? (p200300cbc7023d0023e44c8467a53ccf.dip0.t-ipconnect.de. [2003:cb:c702:3d00:23e4:4c84:67a5:3ccf])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b00205aa05fa03sm313602wrr.58.2022.04.20.10.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 10:13:43 -0700 (PDT)
Message-ID: <c7e76985-f209-f110-0785-e2849acdd43c@redhat.com>
Date:   Wed, 20 Apr 2022 19:13:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 1/8] mm/swap: remember PG_anon_exclusive via a swp pte
 bit
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
References: <20220329164329.208407-1-david@redhat.com>
 <20220329164329.208407-2-david@redhat.com>
 <b49f1b4c-defa-ef32-1984-0273e1fad178@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <b49f1b4c-defa-ef32-1984-0273e1fad178@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.22 19:10, Vlastimil Babka wrote:
> On 3/29/22 18:43, David Hildenbrand wrote:
>> Currently, we clear PG_anon_exclusive in try_to_unmap() and forget about
>> it. We do this, to keep fork() logic on swap entries easy and efficient:
>> for example, if we wouldn't clear it when unmapping, we'd have to lookup
>> the page in the swapcache for each and every swap entry during fork() and
>> clear PG_anon_exclusive if set.
>>
>> Instead, we want to store that information directly in the swap pte,
>> protected by the page table lock, similarly to how we handle
>> SWP_MIGRATION_READ_EXCLUSIVE for migration entries. However, for actual
>> swap entries, we don't want to mess with the swap type (e.g., still one
>> bit) because it overcomplicates swap code.
>>
>> In try_to_unmap(), we already reject to unmap in case the page might be
>> pinned, because we must not lose PG_anon_exclusive on pinned pages ever.
>> Checking if there are other unexpected references reliably *before*
>> completely unmapping a page is unfortunately not really possible: THP
>> heavily overcomplicate the situation. Once fully unmapped it's easier --
>> we, for example, make sure that there are no unexpected references
>> *after* unmapping a page before starting writeback on that page.
>>
>> So, we currently might end up unmapping a page and clearing
>> PG_anon_exclusive if that page has additional references, for example,
>> due to a FOLL_GET.
>>
>> do_swap_page() has to re-determine if a page is exclusive, which will
>> easily fail if there are other references on a page, most prominently
>> GUP references via FOLL_GET. This can currently result in memory
>> corruptions when taking a FOLL_GET | FOLL_WRITE reference on a page even
>> when fork() is never involved: try_to_unmap() will succeed, and when
>> refaulting the page, it cannot be marked exclusive and will get replaced
>> by a copy in the page tables on the next write access, resulting in writes
>> via the GUP reference to the page being lost.
>>
>> In an ideal world, everybody that uses GUP and wants to modify page
>> content, such as O_DIRECT, would properly use FOLL_PIN. However, that
>> conversion will take a while. It's easier to fix what used to work in the
>> past (FOLL_GET | FOLL_WRITE) remembering PG_anon_exclusive. In addition,
>> by remembering PG_anon_exclusive we can further reduce unnecessary COW
>> in some cases, so it's the natural thing to do.
>>
>> So let's transfer the PG_anon_exclusive information to the swap pte and
>> store it via an architecture-dependant pte bit; use that information when
>> restoring the swap pte in do_swap_page() and unuse_pte(). During fork(), we
>> simply have to clear the pte bit and are done.
>>
>> Of course, there is one corner case to handle: swap backends that don't
>> support concurrent page modifications while the page is under writeback.
>> Special case these, and drop the exclusive marker. Add a comment why that
>> is just fine (also, reuse_swap_page() would have done the same in the
>> past).
>>
>> In the future, we'll hopefully have all architectures support
>> __HAVE_ARCH_PTE_SWP_EXCLUSIVE, such that we can get rid of the empty
>> stubs and the define completely. Then, we can also convert
>> SWP_MIGRATION_READ_EXCLUSIVE. For architectures it's fairly easy to
>> support: either simply use a yet unused pte bit that can be used for swap
>> entries, steal one from the arch type bits if they exceed 5, or steal one
>> from the offset bits.
>>
>> Note: R/O FOLL_GET references were never really reliable, especially
>> when taking one on a shared page and then writing to the page (e.g., GUP
>> after fork()). FOLL_GET, including R/W references, were never really
>> reliable once fork was involved (e.g., GUP before fork(),
>> GUP during fork()). KSM steps back in case it stumbles over unexpected
>> references and is, therefore, fine.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> With the fixup as reportedy by Miaohe Lin
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> (sent a separate mm-commits mail to inquire about the fix going missing from
> mmotm)
> 
> https://lore.kernel.org/mm-commits/c3195d8a-2931-0749-973a-1d04e4baec94@suse.cz/T/#m4e98ccae6f747e11f45e4d0726427ba2fef740eb

Yes I saw that, thanks for catching that!


-- 
Thanks,

David / dhildenb

