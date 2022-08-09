Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B77E58E0B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346302AbiHIUIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346021AbiHIUHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 286AF2714B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660075669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3azFgO8JKu87JR5Z/ksyBZsLVlOgq+jrxUxM8a69wNY=;
        b=QaVQySwcvaC9Pp33RKD19f85nBMlOU+ZgRLfCAetjMdvlBhITYGWG+2TJxR5PEpGp/w4wm
        TAQh6ejp+rTPPM6+QpW/qSBGbalC5mD15nPRhgw0cRwhEgqJP6IpWg2QFLSo7HmQe2sC3s
        2YldDa5Anv/6xVohkH6rdpbd3455bew=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-LMoFDuktOw6b-IG5QcBThg-1; Tue, 09 Aug 2022 16:07:47 -0400
X-MC-Unique: LMoFDuktOw6b-IG5QcBThg-1
Received: by mail-wm1-f71.google.com with SMTP id h62-20020a1c2141000000b003a4f57eaeaaso1212857wmh.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=3azFgO8JKu87JR5Z/ksyBZsLVlOgq+jrxUxM8a69wNY=;
        b=K87cBT5LniCepSsEdgKAe18zG6gsVANRDcANNL9W0DGZS7GmT3E4SFWOat2zFWLYa9
         GXq8GVU5BHIJRhgVwba87DtwEsVOGIEAX0l2yiBkJkGo54H5XRDJO0e4xknOAzrhyGoN
         AI9+xlet2rhdWOvve62JqR9nYC4Lq4+mpSOXBjl9kb+LQVOHXZthTJ6UkaNzBcuBsQds
         6NIj4voj4319RIURkyd5ngulS4odvwo6UBvYNh/H+zeSHiX+3tDGNLU31nApTEiAPBG9
         b3l8pIX5rTOG972wqnNOuRa6QQd9rMMMbKxB2W37E6HGgGQsl0URLXqdF35QSJyq9i4x
         w/Qg==
X-Gm-Message-State: ACgBeo3HR15fQFL3vT4/6zudhrd5IIsQpGnH2c9fKMP+jY1pFIDy0vIo
        d+Y/XPStCK9BUADGJXOrYrYZ7F5sFtpxVqq9w3IgU5KX68It5Ut86IjA4NowGbPAwKShUe9apcJ
        btOISITR7E5bAVehhFGmG7ooW
X-Received: by 2002:a1c:4c0d:0:b0:3a5:a401:a1ed with SMTP id z13-20020a1c4c0d000000b003a5a401a1edmr80845wmf.15.1660075666483;
        Tue, 09 Aug 2022 13:07:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6iROr/HGqtHBiJViJaW8tR4bgXV1aGxKbJzMgNfa+Vc+A05fUZPbPT7b7bKfz9aIA31r+kHA==
X-Received: by 2002:a1c:4c0d:0:b0:3a5:a401:a1ed with SMTP id z13-20020a1c4c0d000000b003a5a401a1edmr80838wmf.15.1660075666240;
        Tue, 09 Aug 2022 13:07:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:3700:aed2:a0f8:c270:7f30? (p200300cbc7053700aed2a0f8c2707f30.dip0.t-ipconnect.de. [2003:cb:c705:3700:aed2:a0f8:c270:7f30])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600001c900b0021eaf4138aesm16846626wrx.108.2022.08.09.13.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 13:07:45 -0700 (PDT)
Message-ID: <91e18a2f-c93d-00b8-7c1b-6d8493c3b2d5@redhat.com>
Date:   Tue, 9 Aug 2022 22:07:44 +0200
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
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

I'd actually rather check for MAP_MAYSHARE here, which is even stronger.
Thoughts?

-- 
Thanks,

David / dhildenb

