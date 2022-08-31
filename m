Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2A85A7762
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiHaHTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiHaHSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E7875CCA
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661930120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Ugr0/BQaONBL+J1aV+ArK6pvARf5BKw9bkgKBReafA=;
        b=FCc91irDiYhS9Hdofr1cnaPdFAGn2sJ1n7Os9K3dwsUn+/mVslL3MsJDLFj2rBp9G4Twwn
        P823a2+/HXQvDupJfgIq/iDNKEYBxVdEw1DW2larlcU3V7SEHDhquCM2QjjNqi4EWqif9/
        ol4ua6xyWjl20Vx2d8fXjf1kFC+rGrk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-463-58LxR1WIPsKQOknRygNZJw-1; Wed, 31 Aug 2022 03:15:19 -0400
X-MC-Unique: 58LxR1WIPsKQOknRygNZJw-1
Received: by mail-wm1-f71.google.com with SMTP id c66-20020a1c3545000000b003a5f6dd6a25so11339629wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=3Ugr0/BQaONBL+J1aV+ArK6pvARf5BKw9bkgKBReafA=;
        b=A4Tzq3Lf8lr6Wd8zEGOquHqiZjH+1/qzSRoOWm+MgcmiYEfEa2fP856ZtJMVIoZued
         Zi7O+iNiPZnPt+bu62BbB3RQqJ+bRwl4YpWkgIM/KQRGQwnyCmxfF1MghDNIUmtrqlWf
         flzwiTiSUXANwEAjwY7COvNQkjcyfGnojLMcH5Yq84i8BXCmWUjuI2vRELFe2ZBoQH4j
         c8lvLgTEK1sj7Yh2QYHoZDj75JyxyzVxh1HmxoaQrBbiEP/xN/8AvsJK+JdWiXW9KTsT
         LD7BLYgwPh60cyCWDg2avApMPhICgji5phYxJv6+NENzbf6pLN4Eeul450qG4Vf3aFap
         KW1w==
X-Gm-Message-State: ACgBeo2oTm0jjWXt+FoxCHZn0mjlgcLtGU5X34e6mdxe4QOiUtLkN2oB
        TTqgLsyp7Uf06pytmGISHxbikOcqg/+mw1x5pT58eq7Ric2ZoOUbYHSmSxcTgV3dO05DJUBtOyG
        1qT5g7Y3ycHcJWJgKd73jK2km
X-Received: by 2002:a05:6000:1806:b0:225:5c19:6c75 with SMTP id m6-20020a056000180600b002255c196c75mr10653428wrh.524.1661930117854;
        Wed, 31 Aug 2022 00:15:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR723+Rr5Dy6J76zhlwMTrPcNUT/pDcSIM5sgUhaKBYe4ypSdMgsFrIoyvzF2dpiRyzCLlePGg==
X-Received: by 2002:a05:6000:1806:b0:225:5c19:6c75 with SMTP id m6-20020a056000180600b002255c196c75mr10653419wrh.524.1661930117550;
        Wed, 31 Aug 2022 00:15:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:2900:1613:4308:aca3:2786? (p200300cbc706290016134308aca32786.dip0.t-ipconnect.de. [2003:cb:c706:2900:1613:4308:aca3:2786])
        by smtp.gmail.com with ESMTPSA id o7-20020adfeac7000000b00226332f9275sm11171246wrn.22.2022.08.31.00.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 00:15:17 -0700 (PDT)
Message-ID: <60bbe75b-8dd1-3c46-2f8f-c2407493ffb8@redhat.com>
Date:   Wed, 31 Aug 2022 09:15:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        John Hubbard <jhubbard@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
References: <20220825164659.89824-1-david@redhat.com>
 <20220825164659.89824-3-david@redhat.com>
 <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
 <2e20c90d-4d1f-dd83-aa63-9d8d17021263@redhat.com>
 <Yw5a1paQJ9MNdgmW@nvidia.com>
 <9ce3aaaa-71a6-5a81-16a3-36e6763feb91@redhat.com>
 <Yw5rwIUPm49XtqOB@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 2/3] mm/gup: use gup_can_follow_protnone() also in
 GUP-fast
In-Reply-To: <Yw5rwIUPm49XtqOB@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.22 21:57, Jason Gunthorpe wrote:
> On Tue, Aug 30, 2022 at 08:53:06PM +0200, David Hildenbrand wrote:
>> On 30.08.22 20:45, Jason Gunthorpe wrote:
>>> On Tue, Aug 30, 2022 at 08:23:52PM +0200, David Hildenbrand wrote:
>>>> ... and looking into the details of TLB flush and GUP-fast interaction
>>>> nowadays, that case is no longer relevant. A TLB flush is no longer
>>>> sufficient to stop concurrent GUP-fast ever since we introduced generic
>>>> RCU GUP-fast.
>>>
>>> Yes, we've had RCU GUP fast for a while, and it is more widely used
>>> now, IIRC.
>>>
>>> It has been a bit, but if I remember, GUP fast in RCU mode worked on a
>>> few principles:
>>>
>>>  - The PTE page must not be freed without RCU
>>>  - The PTE page content must be convertable to a struct page using the
>>>    usual rules (eg PTE Special)
>>>  - That struct page refcount may go from 0->1 inside the RCU
>>>  - In the case the refcount goes from 0->1 there must be sufficient
>>>    barriers such that GUP fast observing the refcount of 1 will also
>>>    observe the PTE entry has changed. ie before the refcount is
>>>    dropped in the zap it has to clear the PTE entry, the refcount
>>>    decr has to be a 'release' and the refcount incr in gup fast has be
>>>    to be an 'acquire'.
>>>  - The rest of the system must tolerate speculative refcount
>>>    increments from GUP on any random page
>>>> The basic idea being that if GUP fast obtains a valid reference on a
>>> page *and* the PTE entry has not changed then everything is fine.
>>>
>>> The tricks with TLB invalidation are just a "poor mans" RCU, and
>>> arguably these days aren't really needed since I think we could make
>>> everything use real RCU always without penalty if we really wanted.
>>>
>>> Today we can create a unique 'struct pagetable_page' as Matthew has
>>> been doing in other places that guarentees a rcu_head is always
>>> available for every page used in a page table. Using that we could
>>> drop the code in the TLB flusher that allocates memory for the
>>> rcu_head and hopes for the best. (Or even is the common struct page
>>> rcu_head already guarenteed to exist for pagetable pages now a days?)
>>>
>>> IMHO that is the main reason we still have the non-RCU mode at all..
>>
>>
>> Good, I managed to attract the attention of someone who understands that machinery :)
>>
>> While validating whether GUP-fast and PageAnonExclusive code work correctly,
>> I started looking at the whole RCU GUP-fast machinery. I do have a patch to
>> improve PageAnonExclusive clearing (I think we're missing memory barriers to
>> make it work as expected in any possible case), but I also stumbled eventually
>> over a more generic issue that might need memory barriers.
>>
>> Any thoughts whether I am missing something or this is actually missing
>> memory barriers?
> 
> I don't like the use of smb_mb very much, I deliberately choose the
> more modern language of release/acquire because it makes it a lot
> clearer what barriers are doing..
> 
> So, if we dig into it, using what I said above, the atomic refcount is:
> 
> gup_pte_range()
>   try_grab_folio()
>    try_get_folio()
>     folio_ref_try_add_rcu()
>      folio_ref_add_unless()
>        page_ref_add_unless()
>         atomic_add_unless()

Right, that seems to work as expected for checking the refcount after
clearing the PTE.

Unfortunately, it's not sufficien to identify whether a page may be
pinned, because the flow continues as

folio = try_get_folio(page, refs)
...
if (folio_test_large(folio))
	atomic_add(refs, folio_pincount_ptr(folio));
else
	folio_ref_add(folio, ...)

So I guess we'd need a smb_mb() before re-checking the PTE for that case.

> 
> So that wants to be an acquire
> 
> The pairing release is in the page table code that does the put_page,
> it wants to be an atomic_dec_return() as a release.
> 
> Now, we go and look at Documentation/atomic_t.txt to try to understand
> what are the ordering semantics of the atomics we are using and become
> dazed-confused like me:

I read that 3 times and got dizzy. Thanks for double-checking, very much
appreciated!

> 
>  ORDERING  (go read memory-barriers.txt first)
>  --------
> 
>   - RMW operations that have a return value are fully ordered;
> 
>   - RMW operations that are conditional are unordered on FAILURE,
>     otherwise the above rules apply.
> 
>  Fully ordered primitives are ordered against everything prior and everything
>  subsequent. Therefore a fully ordered primitive is like having an smp_mb()
>  before and an smp_mb() after the primitive.
> 
> So, I take that to mean that both atomic_add_unless() and
> atomic_dec_return() are "fully ordered" and "fully ordered" is a super
> set of acquire/release.
> 
> Thus, we already have the necessary barriers integrated into the
> atomic being used.
> 
> The smb_mb_after_atomic stuff is to be used with atomics that don't
> return values, there are some examples in the doc

Yes, I missed the point that RMW operations that return a value are
fully ordered and imply smp_mb() before / after.

-- 
Thanks,

David / dhildenb

