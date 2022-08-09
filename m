Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6130558E0A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345969AbiHIUHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346430AbiHIUGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:06:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B2C61EAED
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660075597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tnFi6UtyTY9WNAK3ojJYdk14zblLhZ4ZNfoakUrtm+A=;
        b=RRiSmuFGaAVaXZg6OWVjPlgu5WMHvcU7AnqD5I/zEQL97l58WkRa222T2lCiOEkMhlhqOD
        j2H23ffFtxQXCtiJ69C/nfFlwEP9AyRnum6zHdAH6oazWSWtshBAUIIW8nVM/SaQp0HkbK
        kxbmQYO9b9nY0mgu6SW1IDd9COBUy98=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-IxuZWIk0NhiobfKkJCcBcQ-1; Tue, 09 Aug 2022 16:06:28 -0400
X-MC-Unique: IxuZWIk0NhiobfKkJCcBcQ-1
Received: by mail-wm1-f70.google.com with SMTP id j22-20020a05600c485600b003a50fa6981bso8510283wmo.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=tnFi6UtyTY9WNAK3ojJYdk14zblLhZ4ZNfoakUrtm+A=;
        b=Y16XgQoICCdxiDm/tiw1ZlMLY6m6eGAlea+2wWWzQLpq+3hb+J6B8X8Jeynrxszxm5
         eLZQ+CCjD+zUt+jORvzvAAuCttWWp995YyI27LWMe/GGWANhnqpiUE2XYTSQZiGU41k/
         unA8t1Ga6yuj442v9/aTLT+HeU2jcfF7N1zJPxDHFncMGj5+tSWjZr3oO+Pxd4CVUhH7
         qINKObta921SaYY1zOtu/WWlBcydtCVw/RtqWlnJh8UL3kT9D077FW5NRMWp8Q7yMpxt
         Nz2J8cO+2jIQEJOBnkO7G9v48xH3q1fWIHT/We2JRCjO+Zfjm2+ksfNrokNIrnSYb3Ob
         Sw3w==
X-Gm-Message-State: ACgBeo0GXF42ShZqbQ3zQ4TKDaRvcr4z9OJyfjykHRJkT3S6y1hOwvTL
        Ib1e50ZJR7+lVjQHgmQTU0N6ocqgkyQSczju8SkEq7sMAmxuGv4RuF6H2wOZYHWh0Q97ASrvsMk
        oj5ayW4T0CXZnsGCJQznjTPX1
X-Received: by 2002:a05:600c:1c83:b0:3a3:1f70:25a5 with SMTP id k3-20020a05600c1c8300b003a31f7025a5mr96406wms.54.1660075587257;
        Tue, 09 Aug 2022 13:06:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR66DZ40NogmO6UZUwoav9+z+Te4GfHYB3lGDXDsf01sUqvkBPwo8yj0Y6XaOnjGX9a867sFmQ==
X-Received: by 2002:a05:600c:1c83:b0:3a3:1f70:25a5 with SMTP id k3-20020a05600c1c8300b003a31f7025a5mr96390wms.54.1660075586937;
        Tue, 09 Aug 2022 13:06:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:3700:aed2:a0f8:c270:7f30? (p200300cbc7053700aed2a0f8c2707f30.dip0.t-ipconnect.de. [2003:cb:c705:3700:aed2:a0f8:c270:7f30])
        by smtp.gmail.com with ESMTPSA id a7-20020a056000100700b0021f0c0c62d1sm14231325wrx.13.2022.08.09.13.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 13:06:26 -0700 (PDT)
Message-ID: <92f5352e-c903-0413-6dea-9758222c79ad@redhat.com>
Date:   Tue, 9 Aug 2022 22:06:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] mm/gup: fix FOLL_FORCE COW security issue and remove
 FOLL_COW
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220808073232.8808-1-david@redhat.com>
 <CAHk-=wgsDOz5MfYYS9mE7PvFn4kLhTFdBwXvN6HCEsw1kvJnRQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHk-=wgsDOz5MfYYS9mE7PvFn4kLhTFdBwXvN6HCEsw1kvJnRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.22 22:00, Linus Torvalds wrote:
> On Mon, Aug 8, 2022 at 12:32 AM David Hildenbrand <david@redhat.com> wrote:
>>
> 
> So I've read through the patch several times, and it seems fine, but
> this function (and the pmd version of it) just read oddly to me.
> 
>> +static inline bool can_follow_write_pte(pte_t pte, struct page *page,
>> +                                       struct vm_area_struct *vma,
>> +                                       unsigned int flags)
>> +{
>> +       if (pte_write(pte))
>> +               return true;
>> +       if (!(flags & FOLL_FORCE))
>> +               return false;
>> +
>> +       /*
>> +        * See check_vma_flags(): only COW mappings need that special
>> +        * "force" handling when they lack VM_WRITE.
>> +        */
>> +       if (vma->vm_flags & VM_WRITE)
>> +               return false;
>> +       VM_BUG_ON(!is_cow_mapping(vma->vm_flags));
> 
> So apart from the VM_BUG_ON(), this code just looks really strange -
> even despite the comment. Just conceptually, the whole "if it's
> writable, return that you cannot follow it for a write" just looks so
> very very strange.
> 
> That doesn't make the code _wrong_, but considering how many times
> this has had subtle bugs, let's not write code that looks strange.
> 
> So I would suggest that to protect against future bugs, we try to make
> it be fairly clear and straightforward, and maybe even a bit overly
> protective.
> 
> For example, let's kill the "shared mapping that you don't have write
> permissions to" very explicitly and without any subtle code at all.
> The vm_flags tests are cheap and easy, and we could very easily just
> add some core ones to make any mistakes much less critical.
> 
> Now, making that 'is_cow_mapping()' check explicit at the very top of
> this would already go a long way:
> 
>         /* FOLL_FORCE for writability only affects COW mappings */
>         if (!is_cow_mapping(vma->vm_flags))
>                 return false;

I actually put the is_cow_mapping() mapping check in there because
check_vma_flags() should make sure that we cannot possibly end up here
in that case. But we can spell it out with comments, doesn't hurt.

> 
> but I'd actually go even further: in this case that "is_cow_mapping()"
> helper to some degree actually hides what is going on.
> 
> So I'd actually prefer for that function to be written something like
> 
>         /* If the pte is writable, we can write to the page */
>         if (pte_write(pte))
>                 return true;
> 
>         /* Maybe FOLL_FORCE is set to override it? */
>         if (flags & FOLL_FORCE)
>                 return false;
> 
>         /* But FOLL_FORCE has no effect on shared mappings */
>         if (vma->vm_flags & MAP_SHARED)
>                 return false;
> 
>         /* .. or read-only private ones */
>         if (!(vma->vm_flags & MAP_MAYWRITE))
>                 return false;
> 
>         /* .. or already writable ones that just need to take a write fault */
>         if (vma->vm_flags & MAP_WRITE)
>                 return false;
> 
> and the two first vm_flags tests above are basically doing tat
> "is_cow_mapping()", and maybe we could even have a comment to that
> effect, but wouldn't it be nice to just write it out that way?
> 
> And after you've written it out like the above, now that
> 
>         if (!page || !PageAnon(page) || !PageAnonExclusive(page))
>                 return false;
> 
> makes you pretty safe from a data sharing perspective: it's most
> definitely not a shared page at that point.
> 
> So if you write it that way, the only remaining issues are the magic
> special soft-dirty and uffd ones, but at that point it's purely about
> the semantics of those features, no longer about any possible "oh, we
> fooled some shared page to be writable".
> 
> And I think the above is fairly legible without any subtle cases, and
> the one-liner comments make it all fairly clear that it's testing.
> 
> Is any of this in any _technical_ way different from what your patch
> did? No. It's literally just rewriting it to be a bit more explicit in
> what it is doing, I think, and it makes that odd "it's not writable if
> VM_WRITE is set" case a bit more explicit.
> 
> Hmm?

No strong opinion. I'm happy as long as it's fixed, and the fix is robust.


-- 
Thanks,

David / dhildenb

