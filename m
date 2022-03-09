Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D2E4D376D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiCIRJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbiCIRHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:07:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 440DC38BC4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646845076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jrei6r5qb5eeU3vEpF+OMacc1dbR/CuSODNaTWujW4w=;
        b=V9K74cxD4OqkLvurhmZTudERs710rsAIR07dzRphjLiuZtyt0AUs89LOS6dGIVbzjgj4zZ
        u83Q/e453fuBZ3IqI/SNbNHXPNoL+ZTNdd4wDhB1exGD3PW2N8AckITns8RdefVvySfar3
        TUTkpkyZqZkoyMMhA0ubCEYk822SoT8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-f5kw1ds_MY6zAHPN7qY00g-1; Wed, 09 Mar 2022 11:57:55 -0500
X-MC-Unique: f5kw1ds_MY6zAHPN7qY00g-1
Received: by mail-wm1-f70.google.com with SMTP id f189-20020a1c38c6000000b0037d1bee4847so2819373wma.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 08:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=jrei6r5qb5eeU3vEpF+OMacc1dbR/CuSODNaTWujW4w=;
        b=fiJoJaoLAdCU2dLW8yf9QBEdsTyuO9tCIkTFWGtDAmx2x6mosqpTOFDr7+SbnzVuZc
         ommjiX0zJPxe/79lxgfXMbCOuhjzILNIovEJ/jgLsl6xCjQyNseyKRftBgmuCP6m0EHc
         U8P9GuyxR9/u/O77PbMGuoVxfPfU0nXf+3g5MG97DusV7wnuCBIEkI566cduAvChKg7N
         nJ+2f8mdbXbdbHtmUBMPCxgdZ23T/nLzbZzhUUEh4ukDgbDtRE0lrcoyfXFPzBTGu2ah
         nJgF3XTxMb7kYkPzVbYoBD06cLaY1C0+RtJlFfTfQ2B7EF4wLp7OB8qGHcdelYpcXYNH
         976g==
X-Gm-Message-State: AOAM530u4xvUmHvfzJEoIVRq8xRRQtHPVUoQ8HzYbO6rMYLSK0SbcOBP
        qaGUKhxRXHy9qwCwiIX9htE7V4flUJSvWp1PINxIgOajiN3HsV7Bnt6Kuu8R+3U9E/X9wNT7lTT
        NE/UiawfB10+mabz58A0VUAY+
X-Received: by 2002:a5d:66c3:0:b0:203:7b33:30c7 with SMTP id k3-20020a5d66c3000000b002037b3330c7mr439616wrw.74.1646845073836;
        Wed, 09 Mar 2022 08:57:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytKkiKYZw0e+6gF/vyhHHzutjAY6E9zelqV3NxtNje4tiGshyMdrhc2Knbp1y6rhHNrKkO1g==
X-Received: by 2002:a5d:66c3:0:b0:203:7b33:30c7 with SMTP id k3-20020a5d66c3000000b002037b3330c7mr439579wrw.74.1646845073508;
        Wed, 09 Mar 2022 08:57:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6300:8418:c653:d01f:3bd2? (p200300cbc70763008418c653d01f3bd2.dip0.t-ipconnect.de. [2003:cb:c707:6300:8418:c653:d01f:3bd2])
        by smtp.gmail.com with ESMTPSA id u4-20020adfed44000000b0020373d356f8sm2124523wro.84.2022.03.09.08.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 08:57:53 -0800 (PST)
Message-ID: <d5b7cd5c-73eb-a1cf-5519-5d13fa6e6b00@redhat.com>
Date:   Wed, 9 Mar 2022 17:57:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org,
        Alexander Potapenko <glider@google.com>
References: <20220308141437.144919-1-david@redhat.com>
 <20220308141437.144919-11-david@redhat.com>
 <YijL+qwc/Y1kmlnj@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 10/15] mm/page-flags: reuse PG_slab as
 PG_anon_exclusive for PageAnon() pages
In-Reply-To: <YijL+qwc/Y1kmlnj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09.03.22 16:47, Matthew Wilcox wrote:
> On Tue, Mar 08, 2022 at 03:14:32PM +0100, David Hildenbrand wrote:
>> The basic question we would like to have a reliable and efficient answer
>> to is: is this anonymous page exclusive to a single process or might it
>> be shared?
> 
> Is this supposed to be for PAGE_SIZE pages as well, or is it only used
> on pages > PAGE_SIZE?

As documented, simple/ordinary PAGE_SIZE pages as well (unfortunately ,
otherwise we'd have more space :) ).

> 
>> In an ideal world, we'd have a spare pageflag. Unfortunately, pageflags
>> don't grow on trees, so we have to get a little creative for the time
>> being.
> 
> This feels a little _too_ creative to me.  There's now an implicit

It's making the semantics of PG_slab depend on another bit in the head
page. I agree, it's not perfect, but it's not *too* crazy. As raised in
the cover letter, not proud of this, but I didn't really find an
alternative for the time being.

> requirement that SL[AOU]B doesn't use the bottom two bits of

I think only the last bit (0x1)

> ->slab_cache, which is probably OK but would need to be documented.

We'd already have false positive PageAnon() if that wasn't the case. At
least in stable_page_flags() would already indicate something wrong I
think (KPF_ANON). We'd need !PageSlab() checks at a couple of places
already if I'm not wrong.

I had a comment in there, but after the PageSlab cleanups came in, I
dropped it because my assumption was that actually nobody is really
allowed to use the lowest mapping bit for something else. We can
document that, of course.

So at least in that regard, I think this is fine.

> 
> I have plans to get rid of PageError and PagePrivate, but those are going
> to be too late for you.  I don't think mappedtodisk has meaning for anon
> pages, even if they're in the swapcache.  It would need PG_has_hwpoisoned

Are you sure it's not used if the page is in the swapcache? I have no
detailed knowledge how file-back swap targets are handled in that
regard. So fs experience would be highly appreciated :)

> to shift to another bit ... but almost any bit will do for has_hwpoisoned.
> Or have I overlooked something?

Good question, I assume we could use another bit that's not already
defined/check on subpages of a compound page.


Overloading PG_reserved would be an alternative, however, that flag can
also indicate that the remainder of the memmap might be mostly garbage,
so it's not that good of a fit IMHO.

> 
>> @@ -920,6 +976,70 @@ extern bool is_free_buddy_page(struct page *page);
>>  
>>  __PAGEFLAG(Isolated, isolated, PF_ANY);
>>  
>> +static __always_inline bool folio_test_slab(struct folio *folio)
>> +{
>> +	return !folio_test_anon(folio) &&
>> +	       test_bit(PG_slab, folio_flags(folio, FOLIO_PF_NO_TAIL));
>> +}
>> +
>> +static __always_inline int PageSlab(struct page *page)
>> +{
>> +	return !PageAnon(page) &&
>> +		test_bit(PG_slab, &PF_NO_TAIL(page, 0)->flags);
>> +}
> 
> In case we do end up using this, this would be better implemented as
> 
> static __always_inline int PageSlab(struct page *page)
> {
> 	return folio_test_slab(page_folio(page));
> }
> 
> since PageAnon already has a page_folio() call embedded in it.

Agreed, I mainly copied the stubs and extended them.

> 
>> +static __always_inline void __SetPageSlab(struct page *page)
>> +{
>> +	VM_BUG_ON_PGFLAGS(PageAnon(page), page);
>> +	__set_bit(PG_slab, &PF_NO_TAIL(page, 1)->flags);
>> +}
> 
> There's only one caller of __SetPageSlab() left, in kfence.  And that
> code looks ... weird.
> 
>         for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
>                 if (!i || (i % 2))
>                         continue;
> 
>                 /* Verify we do not have a compound head page. */
>                 if (WARN_ON(compound_head(&pages[i]) != &pages[i]))
>                         goto err;
> 
>                 __SetPageSlab(&pages[i]);
> 
> I think the author probably intended WARN_ON(PageCompound(page)) because
> they're actually verifying that it's not a tail page, rather than head
> page.

It's certainly a head-scratcher.

> 
>> +static __always_inline void __ClearPageSlab(struct page *page)
>> +{
>> +	VM_BUG_ON_PGFLAGS(PageAnon(page), page);
>> +	__clear_bit(PG_slab, &PF_NO_TAIL(page, 1)->flags);
>> +}
> 
> There are no remaining callers of __ClearPageSlab().  yay.
> 

Indeed, nice.

Thanks!

-- 
Thanks,

David / dhildenb

