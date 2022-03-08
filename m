Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33B44D1F1F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349168AbiCHRbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiCHRba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:31:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FC6555223
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646760633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RrQZONKH8fANjG8V+2cdfnG5GYSQ2J7Zzmc69wjh+wI=;
        b=Ihj00Bvk5HyfNtL3CZ/g+VGodpKX98PY0yxUs4EIAaEXKz2D+VD6B5zkAoB170JvR6ubjA
        ceWwHSqcAd+nX0lFE0CybwguOxzzCdUJxkOEr3vu+6Oj7agMgZET8D+SZtJZyQF01BRAmK
        wAIjG5pf/5b5j+FgDJVBmGiFHlBnfS0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-oCvcH3QPO9e4RR9VE183tw-1; Tue, 08 Mar 2022 12:30:32 -0500
X-MC-Unique: oCvcH3QPO9e4RR9VE183tw-1
Received: by mail-wm1-f72.google.com with SMTP id m34-20020a05600c3b2200b0038115c73361so6706903wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 09:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=RrQZONKH8fANjG8V+2cdfnG5GYSQ2J7Zzmc69wjh+wI=;
        b=McKe/4TJe1an/2fJdiRvBK8nQwKNnuL5P1UegDhh/G6veyqFSa09arUDKX9wiv2elP
         t+dNfCjq7vOwl8PBfPvY2t4TaFd/dcSYTrhcnmKRODC4t7/z6bftWffTavupSE3E3dDy
         PIxpafm7DLBTtyyTUSgNgxmDHOwwYh13k+f99qTgzocNjdAyrFxEEEHilw5hHA6WOAM1
         JNpiKhj5/fSho+Wbf/p5uiUegrijOQ5+gemUOlvFFhH2ztyYa7qp4jrBS1MVENgBw+ef
         g2O3ReAZn6n9DKE6622HtJpyGMWgB2FyhMKV5Rw0k5AalFCZbiZD1IDrGOM9rBNBKmDF
         uvMw==
X-Gm-Message-State: AOAM531/CAEbhJv8f993LhapLMUzyx0CEigJD7ECb6w8SvgqDlFglMQP
        gM+SpMOt70S89Pyvl9kPhEjlB0vt7mYLYcQIe3Ytn535RwBd7ch/NEVLrmCbjEwbnpsLPXgOv9I
        99bZw/47cIboFmPQWGfiyBJTh
X-Received: by 2002:a05:6000:1ca:b0:1f0:2480:f52a with SMTP id t10-20020a05600001ca00b001f02480f52amr12482330wrx.388.1646760630563;
        Tue, 08 Mar 2022 09:30:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDAENBQc1zP8ZSIn+WSmfhqum7CTY69wlNEUhRmwNIuvNPsivAMbIoVqdXHnVzYYAoZMymqg==
X-Received: by 2002:a05:6000:1ca:b0:1f0:2480:f52a with SMTP id t10-20020a05600001ca00b001f02480f52amr12482301wrx.388.1646760630248;
        Tue, 08 Mar 2022 09:30:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:b000:acda:b420:16aa:6b67? (p200300cbc708b000acdab42016aa6b67.dip0.t-ipconnect.de. [2003:cb:c708:b000:acda:b420:16aa:6b67])
        by smtp.gmail.com with ESMTPSA id p11-20020adf9d8b000000b001f063deef80sm12426128wre.86.2022.03.08.09.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 09:30:29 -0800 (PST)
Message-ID: <e10f3099-9b2d-6636-54eb-fb03322e2d47@redhat.com>
Date:   Tue, 8 Mar 2022 18:30:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20220308141437.144919-1-david@redhat.com>
 <20220308141437.144919-6-david@redhat.com>
 <D7AB3A84-3FFB-4E8D-9E68-BF721CC4C6FC@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 05/15] mm/rmap: convert RMAP flags to a proper distinct
 rmap_t type
In-Reply-To: <D7AB3A84-3FFB-4E8D-9E68-BF721CC4C6FC@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 08.03.22 18:15, Nadav Amit wrote:
> 
> 
>> On Mar 8, 2022, at 6:14 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>> We want to pass the flags to more than one anon rmap function, getting
>> rid of special "do_page_add_anon_rmap()". So let's pass around a distinct
>> __bitwise type and refine documentation.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> include/linux/rmap.h | 22 ++++++++++++++++++----
>> mm/memory.c          |  6 +++---
>> mm/rmap.c            |  7 ++++---
>> 3 files changed, 25 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index 92c3585b8c6a..49f6b208938c 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -158,9 +158,23 @@ static inline void anon_vma_merge(struct vm_area_struct *vma,
>>
>> struct anon_vma *page_get_anon_vma(struct page *page);
>>
>> -/* bitflags for do_page_add_anon_rmap() */
>> -#define RMAP_EXCLUSIVE 0x01
>> -#define RMAP_COMPOUND 0x02
>> +/* RMAP flags, currently only relevant for some anon rmap operations. */
>> +typedef int __bitwise rmap_t;
>> +
>> +/*
>> + * No special request: if the page is a subpage of a compound page, it is
>> + * mapped via a PTE. The mapped (sub)page is possibly shared between processes.
>> + */
>> +#define RMAP_NONE		((__force rmap_t)0)
>> +
>> +/* The (sub)page is exclusive to a single process. */
>> +#define RMAP_EXCLUSIVE		((__force rmap_t)BIT(0))
>> +
>> +/*
>> + * The compound page is not mapped via PTEs, but instead via a single PMD and
>> + * should be accounted accordingly.
>> + */
>> +#define RMAP_COMPOUND		((__force rmap_t)BIT(1))
> 

Hi Nadav,

> I was once shouted at for a similar suggestion, but I am going to try
> once more… If you already define a new type, why not to use bitfields?

I don't have a strong opinion, however, I'd prefer keeping it consistent
with existing ways of passing flags.

Personally, I like __bitwise because it just behave the way we're used
to pass flags -- with additional type safety.

Especially once eventually passing many flags (like we do with GFP),
bitfields might turn out rather nasty -- IMHO.


Thanks!

-- 
Thanks,

David / dhildenb

