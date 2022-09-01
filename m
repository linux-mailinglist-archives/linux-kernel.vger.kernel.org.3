Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB645A8EEF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiIAG66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiIAG6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E541636D1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662015531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NP3BgHkO7zL9QtOduyDvBAI5h7SLpCA3Geb5dem5JMs=;
        b=cEnHLB5V4oJLWtdZMSlt75bWGELkRxfPJv/fDSWwRrZyy8p8H+pweE3ojoubd9aB4N70de
        CZTkGZnL40nYYKZWZD3g4RyW2n2qAJg8fkz9lOCDn6dzQfg9zvi2+fM8VcN6IKxhz45tnW
        BPcxQQAyID9v/tKEIGMDJP1yR7NGkrk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-48-F2gwWt3yPkOGqrumRQAKIA-1; Thu, 01 Sep 2022 02:58:50 -0400
X-MC-Unique: F2gwWt3yPkOGqrumRQAKIA-1
Received: by mail-wm1-f69.google.com with SMTP id h133-20020a1c218b000000b003a5fa79008bso831430wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=NP3BgHkO7zL9QtOduyDvBAI5h7SLpCA3Geb5dem5JMs=;
        b=4lCpRjsdn3fSKQ+feNw6Zsg0IiQudD4a9mWx9wkg2Sot6oyr2VmhNsT25dQylRMHx4
         9GeL44dogVrquFh3OGwrteCUddAij56JW0W+0+bpn7XdwVtEY6GMl40mqKWHVWaIIPYz
         ptnoc964SRieFnA+mrGeVI3zNH7SMY5rwCno46SfgoT8ZQweh9sM0+nOv9XADEidtEC6
         CdT7Pu6s3E5vHSTlPy1CtOZVPu7iULjYPB8khq/j4haW7yXQTZSkiKmX+iLku0is8GsB
         h2Xiz+hJAKBmB7003+569TnE13DIo6gHMCKZEVEP4JahwHD3DChSLz8zScUFzXrybvqh
         pqLQ==
X-Gm-Message-State: ACgBeo3S9kxvmr6uvOpZOKCsgI/dgjAilbr7NAQSbL6HPUNjYv/jPMxU
        xC35AC0y9btmj+K5nypS9+WlVkdnPn0qSg9nZqCoNqcTknDqXG2H243Uy4ifiuY1EtFBzGz1oMs
        suk87YeiWeDZcJnKd8ySv/rv9
X-Received: by 2002:a7b:cd11:0:b0:3a8:3f6c:9abf with SMTP id f17-20020a7bcd11000000b003a83f6c9abfmr4234644wmj.30.1662015529169;
        Wed, 31 Aug 2022 23:58:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6selz8IoQMvN8smZKwySY3y3y8uR2hOOnmvhTkF7tEVcHaCNxWJ6MsInQkmFJjyfxSFj4zUA==
X-Received: by 2002:a7b:cd11:0:b0:3a8:3f6c:9abf with SMTP id f17-20020a7bcd11000000b003a83f6c9abfmr4234634wmj.30.1662015528910;
        Wed, 31 Aug 2022 23:58:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9e00:fec0:7e96:15cb:742? (p200300cbc7079e00fec07e9615cb0742.dip0.t-ipconnect.de. [2003:cb:c707:9e00:fec0:7e96:15cb:742])
        by smtp.gmail.com with ESMTPSA id bg41-20020a05600c3ca900b003a62bc1735asm5003223wmb.9.2022.08.31.23.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 23:58:48 -0700 (PDT)
Message-ID: <a5277667-1b41-dabe-837a-19afd0a68fd1@redhat.com>
Date:   Thu, 1 Sep 2022 08:58:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1] mm/ksm: update stale comment in write_protect_page()
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20220831083024.37138-1-david@redhat.com>
 <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
 <4845ae71-b7dd-1707-ebc3-2eb3521e7fa0@redhat.com>
 <CAHbLzkoMMWAgai2bvgu7y5EAcKOhhx3gK+OA4v2+kOHBW4cauw@mail.gmail.com>
 <ab41f458-eb0f-5edb-ccab-643bf00d5110@redhat.com>
 <CAHbLzkpFqSBTv3HVye4UCKj93NPW8VRqCGZO1p5hk_wfNA_GtQ@mail.gmail.com>
 <94c3217d-df73-2b6b-21f0-95baf117c584@redhat.com>
 <CAHbLzkp+HNmz7hGS5uDrfDDW0HpSj5Z+xmmkRbwvgn1qYk8Btg@mail.gmail.com>
 <CAHbLzkqM5qj7AZRpeCemsA56oKuHo2T51chTbh1pkGrr0wRFDQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHbLzkqM5qj7AZRpeCemsA56oKuHo2T51chTbh1pkGrr0wRFDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.22 00:18, Yang Shi wrote:
> On Wed, Aug 31, 2022 at 12:43 PM Yang Shi <shy828301@gmail.com> wrote:
>>
>> On Wed, Aug 31, 2022 at 12:36 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 31.08.22 21:34, Yang Shi wrote:
>>>> On Wed, Aug 31, 2022 at 12:15 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 31.08.22 21:08, Yang Shi wrote:
>>>>>> On Wed, Aug 31, 2022 at 11:29 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>
>>>>>>> On 31.08.22 19:55, Yang Shi wrote:
>>>>>>>> On Wed, Aug 31, 2022 at 1:30 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> The comment is stale, because a TLB flush is no longer sufficient and
>>>>>>>>> required to synchronize against concurrent GUP-fast. This used to be true
>>>>>>>>> in the past, whereby a TLB flush would have implied an IPI on architectures
>>>>>>>>> that support GUP-fast, resulting in GUP-fast that disables local interrupts
>>>>>>>>> from completing before completing the flush.
>>>>>>>>
>>>>>>>> Hmm... it seems there might be problem for THP collapse IIUC. THP
>>>>>>>> collapse clears and flushes pmd before doing anything on pte and
>>>>>>>> relies on interrupt disable of fast GUP to serialize against fast GUP.
>>>>>>>> But if TLB flush is no longer sufficient, then we may run into the
>>>>>>>> below race IIUC:
>>>>>>>>
>>>>>>>>          CPU A                                                CPU B
>>>>>>>> THP collapse                                             fast GUP
>>>>>>>>
>>>>>>>> gup_pmd_range() <-- see valid pmd
>>>>>>>>
>>>>>>>> gup_pte_range() <-- work on pte
>>>>>>>> clear pmd and flush TLB
>>>>>>>> __collapse_huge_page_isolate()
>>>>>>>>     isolate page <-- before GUP bump refcount
>>>>>>>>
>>>>>>>>    pin the page
>>>>>>>> __collapse_huge_page_copy()
>>>>>>>>     copy data to huge page
>>>>>>>>     clear pte (don't flush TLB)
>>>>>>>> Install huge pmd for huge page
>>>>>>>>
>>>>>>>> return the obsolete page
>>>>>>>
>>>>>>> Hm, the is_refcount_suitable() check runs while the PTE hasn't been
>>>>>>> cleared yet. And we don't check if the PMD changed once we're in
>>>>>>> gup_pte_range().
>>>>>>
>>>>>> Yes
>>>>>>
>>>>>>>
>>>>>>> The comment most certainly should be stale as well -- unless there is
>>>>>>> some kind of an implicit IPI broadcast being done.
>>>>>>>
>>>>>>> 2667f50e8b81 mentions: "The RCU page table free logic coupled with an
>>>>>>> IPI broadcast on THP split (which is a rare event), allows one to
>>>>>>> protect a page table walker by merely disabling the interrupts during
>>>>>>> the walk."
>>>>>>>
>>>>>>> I'm not able to quickly locate that IPI broadcast -- maybe there is one
>>>>>>> being done here (in collapse) as well?
>>>>>>
>>>>>> The TLB flush may call IPI. I'm supposed it is arch dependent, right?
>>>>>> Some do use IPI, some may not.
>>>>>
>>>>> Right, and the whole idea of the RCU GUP-fast was to support
>>>>> architectures that don't do it. x86-64 does it. IIRC, powerpc doesn't do
>>>>> it -- but maybe it does so for PMDs?
>>>>
>>>> It looks powerpc does issue IPI for pmd flush. But arm64 doesn't IIRC.
>>>>
>>>> So maybe we should implement pmdp_collapse_flush() for those arches to
>>>> issue IPI.
>>>
>>> ... or find another way to detect and handle this in GUP-fast?
>>>
>>> Not sure if, for handling PMDs, it could be sufficient to propagate the
>>> pmdp pointer + value and double check that the values didn't change.
>>
>> Should work too, right before pinning the page.
> 
> I actually mean the same place for checking pte. So, something like:
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 5abdaf487460..2b0703403902 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2392,7 +2392,8 @@ static int gup_pte_range(pmd_t pmd, unsigned
> long addr, unsigned long end,
>                         goto pte_unmap;
>                 }
> 
> -               if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> +               if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
> +                   unlikely(pte_val(pte) != pte_val(*ptep))) {
>                         gup_put_folio(folio, 1, flags);
>                         goto pte_unmap;
>                 }
> 
> It doesn't build, just shows the idea.

Exactly what I had in mind. We should add a comment spelling out that
this is for handling huge PMD collapse.


-- 
Thanks,

David / dhildenb

