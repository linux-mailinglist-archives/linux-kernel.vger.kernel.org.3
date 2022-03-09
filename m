Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95CF4D385A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiCISBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiCISBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:01:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01C1610C52C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 10:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646848851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ioZlG4TTJ46/PtmS5HOswJBTZfkBKrgjXju5JFTxq0A=;
        b=EmMqbmYLIPBmVXcAkZdtPMApU6m7kORi7RgHFYU/ifQuTpo5x8wbYUgmHXQd09lfF2xEBw
        3ZLUlNmG9vazS9QqKmwGNAWNtfqRvOOuhnKpHCt81LLBGdkyZXSsfnrWuLjODTAv7oR8t7
        aUUqTCD8KknKWW35qFKDT8RHZclzByU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-g97dLYG4Mv-ht22mq8hA_g-1; Wed, 09 Mar 2022 13:00:49 -0500
X-MC-Unique: g97dLYG4Mv-ht22mq8hA_g-1
Received: by mail-wm1-f72.google.com with SMTP id 187-20020a1c19c4000000b0037cc0d56524so2904632wmz.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 10:00:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=ioZlG4TTJ46/PtmS5HOswJBTZfkBKrgjXju5JFTxq0A=;
        b=vkCLm+F5ln8UzxFvvQbrWMeZK+8ose3l2CAjG/My5hd91hH4cqMqnmvSdB70q2WZeg
         kIT9b0yHG8upecCqlLq3BzkMUsmdKgU8L7cssZF1KJ4BnJMbfBN8rf/5qeiF6/e/Cfow
         6uO3gXXKOlEffijlCQ4oE0iOFpXv0cT2tZfmFPvxDer83CcbGIHG8ZjZEdjTmC33PmAi
         OycZgLzcvhzkU+hgR9zPDDlUDZyuZZoB2c8zqQ10RNdo6LeXuhd6sYQPb82kF50ln5zI
         AlxPhMkprzADOMdVY7M5KgjYrVsPMiHiqk3vGWCU+AuZSce4hgi6wGK1jI+/xhSuP9e4
         VBew==
X-Gm-Message-State: AOAM532HMsYxziGkAbW4C5vVOeEFDZUFoqVLbT8YJ6lMFDk5oV3SupO3
        qm6uv+9MdT6eSfJNPO9wP86zfEh5qCS19Yv0kM2qG30vJFw3kdEI65rj8ONNjIwWuairb6pCP1X
        wTEkiIPeJRmjSxeo7M896uXVn
X-Received: by 2002:a05:600c:2241:b0:382:9bc7:4e66 with SMTP id a1-20020a05600c224100b003829bc74e66mr439429wmm.21.1646848848581;
        Wed, 09 Mar 2022 10:00:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1vBEzmmJUDBABmo9d7yLfOhotaoWLOZ2KIAwGqRgZaOMTGz+JBTQoPp+EozsfzKUqlnWhUg==
X-Received: by 2002:a05:600c:2241:b0:382:9bc7:4e66 with SMTP id a1-20020a05600c224100b003829bc74e66mr439398wmm.21.1646848848287;
        Wed, 09 Mar 2022 10:00:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6300:8418:c653:d01f:3bd2? (p200300cbc70763008418c653d01f3bd2.dip0.t-ipconnect.de. [2003:cb:c707:6300:8418:c653:d01f:3bd2])
        by smtp.gmail.com with ESMTPSA id v25-20020a05600c215900b0038117f41728sm5444951wml.43.2022.03.09.10.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 10:00:47 -0800 (PST)
Message-ID: <32c4bd91-08cf-7318-02b7-f43452447aef@redhat.com>
Date:   Wed, 9 Mar 2022 19:00:46 +0100
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
 <d5b7cd5c-73eb-a1cf-5519-5d13fa6e6b00@redhat.com>
 <YijmoncSWx/XWkOW@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 10/15] mm/page-flags: reuse PG_slab as
 PG_anon_exclusive for PageAnon() pages
In-Reply-To: <YijmoncSWx/XWkOW@casper.infradead.org>
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

>> It's making the semantics of PG_slab depend on another bit in the head
>> page. I agree, it's not perfect, but it's not *too* crazy. As raised in
>> the cover letter, not proud of this, but I didn't really find an
>> alternative for the time being.
>>
>>> requirement that SL[AOU]B doesn't use the bottom two bits of
>>
>> I think only the last bit (0x1)
> 
> Yeah, OK, they can use three of the four possible combinations of the
> bottom two bits ;-)  Still, it's yet more constraints on use of struct
> page, which aren't obvious (and are even upside down for the casual
> observer).

I don't disagree that such constraints are nasty.

Having that said, I'd really like to avoid overloading PG_slab
(especially, such that I don't have to mess with
scripts/crash/makedumpfile). So if we can reuse MappedToDisk, that would
be very nice.

> 
>>> I have plans to get rid of PageError and PagePrivate, but those are going
>>> to be too late for you.  I don't think mappedtodisk has meaning for anon
>>> pages, even if they're in the swapcache.  It would need PG_has_hwpoisoned
>>
>> Are you sure it's not used if the page is in the swapcache? I have no
>> detailed knowledge how file-back swap targets are handled in that
>> regard. So fs experience would be highly appreciated :)
> 
> I have two arguments here.  One is based on grep:
> 
> $ git grep mappedtodisk
> fs/proc/page.c: u |= kpf_copy_bit(k, KPF_MAPPEDTODISK,  PG_mappedtodisk);
> include/linux/page-flags.h:     PG_mappedtodisk,        /* Has blocks allocated on-disk */
> include/linux/page-flags.h:     PG_has_hwpoisoned = PG_mappedtodisk,
> include/linux/page-flags.h:PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
> include/trace/events/mmflags.h: {1UL << PG_mappedtodisk,        "mappedtodisk"  },              \
> include/trace/events/pagemap.h: (folio_test_mappedtodisk(folio) ? PAGEMAP_MAPPEDDISK : 0) | \
> mm/migrate.c:   if (folio_test_mappedtodisk(folio))
> mm/migrate.c:           folio_set_mappedtodisk(newfolio);
> mm/truncate.c:  folio_clear_mappedtodisk(folio);
> tools/vm/page-types.c:  [KPF_MAPPEDTODISK]      = "d:mappedtodisk",
> 
> $ git grep MappedToDisk
> fs/buffer.c:            SetPageMappedToDisk(page);
> fs/buffer.c:    if (PageMappedToDisk(page))
> fs/buffer.c:            SetPageMappedToDisk(page);
> fs/ext4/readpage.c:                     SetPageMappedToDisk(page);
> fs/f2fs/data.c:         SetPageMappedToDisk(page);
> fs/f2fs/file.c: if (PageMappedToDisk(page))
> fs/fuse/dev.c:  ClearPageMappedToDisk(newpage);
> fs/mpage.c:             SetPageMappedToDisk(page);
> fs/nilfs2/file.c:       if (PageMappedToDisk(page))
> fs/nilfs2/file.c:                       SetPageMappedToDisk(page);
> fs/nilfs2/page.c:       ClearPageMappedToDisk(page);
> fs/nilfs2/page.c:               SetPageMappedToDisk(dpage);
> fs/nilfs2/page.c:               ClearPageMappedToDisk(dpage);
> fs/nilfs2/page.c:       if (PageMappedToDisk(src) && !PageMappedToDisk(dst))
> fs/nilfs2/page.c:               SetPageMappedToDisk(dst);
> fs/nilfs2/page.c:       else if (!PageMappedToDisk(src) && PageMappedToDisk(dst))
> fs/nilfs2/page.c:               ClearPageMappedToDisk(dst);
> fs/nilfs2/page.c:       ClearPageMappedToDisk(page);
> include/linux/page-flags.h:PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
> 
> so you can see it's _rarely_ used, and only by specific filesystems.

Right, but I spot ext4 and fs/buffer.c core functionality. That
naturally makes me nervous :)

> 
> The swap code actually bypasses the filesystem (except for network
> filesystems) and submits BIOs directly (see __swap_writepage() and
> swap_readpage()).  There's no check for MappedToDisk, and nowhere to
> set it/clear it.
> 
> The second argument is that MappedToDisk is used for delayed allocation
> on writes for filesystems.  But swap is required to be allocated at
> swapfile setup (so that the swap code can bypass the filesystem ...)
> and so this flag is useless.

I have some faint memory that there are corner cases, but maybe
(hopefully) my memory is wrong.

> 
> Of course, I may have missed something.  This is complex.
> 

Yeah, that's why I was very careful. If any FS would end up setting that
flag we'd be in trouble and would have to blacklist that fs for swapping
or rework it (well, if we're even able to identify such a file system).

I think one sanity check I could add is making sure that
PageAnonExclusive() is never set when getting a page from the swapcache
in do_swap_page(). I think that would take care of the obvious bugs.

-- 
Thanks,

David / dhildenb

