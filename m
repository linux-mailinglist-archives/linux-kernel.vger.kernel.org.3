Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2FA4EDAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiCaNsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbiCaNsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 077E41042B2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648734385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C4Vh0RqP+GZ21MRJn3PqH0IuI8ZeNebvuM8i4oIwPFs=;
        b=CjDi1BuiazqsQ0X1FSMYnV7PHQnVS0LTyI4IQxer8fzKyn1t26+b63x4T/auYWZ8FX8RMX
        lY9riv81JcaBo9NThs0ci5O5GLsRFftkimAOFZYHom6Q7A0ylRKnFAloHt8mzFYVtJVBZC
        3/Kbo/CIUdTzoT2xRtindMa7xlrY9Ps=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-mnAEG1ntMJClWyIJJ0KH_g-1; Thu, 31 Mar 2022 09:46:23 -0400
X-MC-Unique: mnAEG1ntMJClWyIJJ0KH_g-1
Received: by mail-wm1-f69.google.com with SMTP id 9-20020a05600c240900b0038c99b98f6fso1191856wmp.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=C4Vh0RqP+GZ21MRJn3PqH0IuI8ZeNebvuM8i4oIwPFs=;
        b=KIVEJ6rWI6IfZ3tnFCLunUFt21Q4pWWf7cgSORtV++jz+2oCRXE0lWj7CJxCEMnmwg
         xjqWI/1YMf98iOnPf3eQej9aEa1vRrv0PC0Kgw2sFvXZAynt9vJsCDaP6g+VCnOHG369
         p5NcaxXliFMET2V1Cf+t2JS4sM3TSpQS26yCpY8DuSvZ71xo4nJfM1l11zF0mxJmHVzE
         swgx76Wo3UwsljkiUDQMIgF9+C2sGEYOuI1cXjBdMEzpAlYWM5dyHoZCLxdPEovJnp9t
         DdRUVI+zFSyfyNmfefkwn9YC9IAGrX0vNZ3GDUSWHAMUSgfpQ+jpdYMShYwu0vmkvdl+
         av0g==
X-Gm-Message-State: AOAM533dat2ILf7M+vkAucXfT41RCrslr/a4hEs01sq5jusfPEWGBBnt
        2MHa02s8GSdkAIThK2f6FZLsQKBzy2sfVzU/Reiw5tsZe+PrijLpe7DHTsadmX82D51YvwwDiOK
        RJ1JeHjhWO+hTYQ01QBqSSbPc
X-Received: by 2002:a5d:6651:0:b0:203:fc53:cf22 with SMTP id f17-20020a5d6651000000b00203fc53cf22mr4110459wrw.365.1648734382342;
        Thu, 31 Mar 2022 06:46:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4oUI2/ThFdvSfSKYkBlLO/JOXVqYiGz/W2ANcPKnyfSgHWNfiqvsbxo79KJKL2VH7gS+41w==
X-Received: by 2002:a5d:6651:0:b0:203:fc53:cf22 with SMTP id f17-20020a5d6651000000b00203fc53cf22mr4110428wrw.365.1648734382057;
        Thu, 31 Mar 2022 06:46:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:ac00:381c:2e8b:3b48:488e? (p200300cbc707ac00381c2e8b3b48488e.dip0.t-ipconnect.de. [2003:cb:c707:ac00:381c:2e8b:3b48:488e])
        by smtp.gmail.com with ESMTPSA id y5-20020a1c4b05000000b0038cbf571334sm7063506wma.18.2022.03.31.06.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 06:46:21 -0700 (PDT)
Message-ID: <2eaa2667-219c-1bac-8f50-0020fa42e54e@redhat.com>
Date:   Thu, 31 Mar 2022 15:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Khalid Aziz <khalid.aziz@oracle.com>, linux-kernel@vger.kernel.org
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
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220315104741.63071-1-david@redhat.com>
 <20220315104741.63071-2-david@redhat.com>
 <d98bd1f9-e9b7-049c-7bde-3348b074eb18@redhat.com>
 <909cc1b6-6f4f-4c45-f418-31d5dd5acaa3@oracle.com>
 <b46a5be4-27a0-6ab6-0f98-658ca82339db@redhat.com>
 <689c199f-9954-524b-7a2d-40f186e87b34@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 01/15] mm/rmap: fix missing swap_free() in
 try_to_unmap() after arch_unmap_one() failed
In-Reply-To: <689c199f-9954-524b-7a2d-40f186e87b34@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi David,

Hi,

> 
> arch_remap_one() sounds reasonable. Would you like to add that in your patch series, or would you like me to create a 
> separate patch for adding this on top of your patch series?

Let's handle it separately, because I think there is still a lot to be
clarified. I also feel like the terminology ("arch_unmap_one()") is a
little too generic, if we really only care about anonymous pages (do we?).

> 
>>
>>>
>>>>
>>>> arch_unmap_one() calls adi_save_tags(), which allocates memory.
>>>> adi_restore_tags()->del_tag_store() reverts that operation and ends up
>>>> freeing memory conditionally; However, it's only
>>>> called from arch_do_swap_page().
>>>>
>>>>
>>>> Here is why I have to scratch my head:
>>>>
>>>> a) arch_do_swap_page() is only called from do_swap_page(). We don't do anything similar
>>>> for mm/swapfile.c:unuse_pte(), aren't we missing something?
>>>
>>> My understanding of this code path maybe flawed, so do correct me if this does not sound right. unused_pte() is called
>>> upon user turning off swap on a device. unused_pte() is called by unused_pte_range() which swaps the page back in from
>>> swap device before calling unuse_pte(). Once the page is read back in from swap, ultimately access to the va for the
>>> page will result in call to __handle_mm_fault() which in turn will call handle_pte_fault() to insert a new pte for this
>>> mapping and handle_pte_fault() will call arch_do_swap_page() which will restore the tags.
>>
>> unuse_pte() will replace a swap pte directly by a proper, present pte,
>> just like do_swap_page() would. You won't end up in do_swap_page()
>> anymore and arch_do_swap_page() won't be called, because there is no
>> swap PTE anymore.
>>
>>>
>>>>
>>>> b) try_to_migrate_one() does the arch_unmap_one(), but who will do the
>>>> restore+free after migration succeeded or failed, aren't we missing something?
>>>
>>> try_to_migrate_one() replaces the current pte with a migration pte after calling arch_unmap_one(). This causes
>>> __handle_mm_fault() to be called when a reference to the va covered by migration pte is made. This will in turn finally
>>> result in a call to arch_do_swap_page() which restores the tags.
>>
>> Migration PTEs are restore via mm/migrate.c:remove_migration_ptes().
>> arch_do_swap_page() won't be called.
>>
>> What you mention is if someone accesses the migration PTE while
>> migration is active and the migration PTEs have not been removed yet.
>> While we'll end up in do_swap_page(), we'll do a migration_entry_wait(),
>> followed by an effective immediate "return 0;". arch_do_swap_page()
>> won't get called.
>>
>>
>> So in essence, I think this doesn't work as expected yet. In the best
>> case we don't immediately free memory. In the worst case we lose the tags.
>>
> 
> I see what you mean. I can work on fixing these issues up.

Ideally, I think we'd handle migration differently: migrate the tags
directly instead of temporarily storing them

I also wonder, how to handle migration of THP (which uses migration
PMDs) and THP splitting (which also uses migration PTEs); maybe they
don't apply on sparc?

Further, I wonder if you have to handle zapping of swap/migration PTEs,
and if you'd also have to cleanup+freeup any allcoated tag memory?
E.g., zap_pte_range() can simply zap swap and migration entries, wouldn't

Last but not least, I do wonder if mremap() -- e.g., move_pte() -- and
fork() -- e.g., copy_pte_range() -- are handled properly, where we can
end up moving/copying swap+migration PTEs around.

-- 
Thanks,

David / dhildenb

