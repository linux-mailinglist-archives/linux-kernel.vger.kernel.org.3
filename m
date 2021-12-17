Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFFA479617
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbhLQVRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:17:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237226AbhLQVRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639775839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q8mMbbXNNFkQCye2i+vJ7bGpp5qprCcUMSqt2cqb7yI=;
        b=Q8t8TmEh1Y2ojgaaD0+/HkaNqG+bbMROip/uKihExUBYsiQsq4Tp0FzZCwFSZFMFV8w1/7
        /5LIc4+Jt9qVR7PgbDs3VP2hzDvVzj4yO6wKrXwc2DqdvyWLD1ZtBV+MrKTdA95tFKGXYg
        uHYEBhbILTeY+kvprxEH8JZZujEDg/c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-nbP4CQg8PluhpgNBDRRHoA-1; Fri, 17 Dec 2021 16:17:18 -0500
X-MC-Unique: nbP4CQg8PluhpgNBDRRHoA-1
Received: by mail-wm1-f71.google.com with SMTP id n41-20020a05600c502900b003335ab97f41so1594694wmr.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 13:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Q8mMbbXNNFkQCye2i+vJ7bGpp5qprCcUMSqt2cqb7yI=;
        b=Ax5Mvmu9ZuUsQ02ZKjGAAv72f4DmmegD2Y6MGzLu4OOFkSSosxv6rU8u3lMx4AUPF1
         V4EtzDH5gwukoHKgY7JuUUnnjcHAtcfDeFgTeou6+50NxWGZpdR8GR182iIbkwl0kQAf
         19JKyQopDaVAPzrckwjl+nJy1Ky2fEHMFn9PjDKKfIZn1+p0fB1U1+tbgH5yhEc05m8u
         hclVuu/giv3diYFZVdAeT4w9jAZWr0Xvh8IznYJIkdPxykzV0k7gOSkuImQ4Ut3vWL8p
         H3h54Ir3Easr6U8ekbhlyzUn5hP2vQNSuFBYZxN+CtDfatFzQJcLvyxgtoTdiWMW6NLH
         bACQ==
X-Gm-Message-State: AOAM532Uw3YyRii+oez3V8xZ8FZCrVfpt0JWXnMVrhW6QeF0QdgmrQgJ
        UTl4Ob4dVNt7ZQ81bHt6au02zuXw/7abtsP7QQi0AafShGUUoVL0xi7023+vldBBHZi2q3QLht3
        AQPQEWq2Rn4Q8VdDElkHKUQLM
X-Received: by 2002:adf:ce84:: with SMTP id r4mr4060393wrn.131.1639775837475;
        Fri, 17 Dec 2021 13:17:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyHFjtfUP+UrzLUR48hxKqEKlGEluE4bUcCBZtUym2XEAAEZjLDhDIAoq52AL8Giwi/+zzjw==
X-Received: by 2002:adf:ce84:: with SMTP id r4mr4060376wrn.131.1639775837280;
        Fri, 17 Dec 2021 13:17:17 -0800 (PST)
Received: from [192.168.3.132] (p4ff234b8.dip0.t-ipconnect.de. [79.242.52.184])
        by smtp.gmail.com with ESMTPSA id m3sm1977816wms.25.2021.12.17.13.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 13:17:16 -0800 (PST)
Message-ID: <4bc68a26-5924-4766-2e6a-b18a523a2621@redhat.com>
Date:   Fri, 17 Dec 2021 22:17:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
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
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
 <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com>
 <CAHk-=wgO9Zmc3S+cG=xFuUAgkZ3Ti9fOdUr4Q72EPwrxX67YAA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
In-Reply-To: <CAHk-=wgO9Zmc3S+cG=xFuUAgkZ3Ti9fOdUr4Q72EPwrxX67YAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.21 21:56, Linus Torvalds wrote:
> On Fri, Dec 17, 2021 at 12:47 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> To remind all, the GUP users, like RDMA, VFIO use
>> FOLL_FORCE|FOLL_WRITE to get a 'r/o pin' specifically because of the
>> COW breaking the coherence. In these case 'r/o pin' does not mean
>> "snapshot the data", but its only a promise not to write to the pages
>> and still desires coherence with the memory map.
>>
>> Eg in RDMA we know of apps asking for a R/O pin of something in .bss
>> then filling that something with data finally doing the actual
>> DMA. Breaking COW after pin breaks those apps.
> 
> I agree.
> 

I agree that breaking COW after a pin should never be done. Therefore,
break the COW before the pin -> unsharing as implemented here.

> And my argument is that those kinds of things that ask for a R/O pin
> are broken, and should just make sure to use the shared pins.

And trigger a write fault although they are just reading. To me this is
just a band aid instead of eventually ...

...
> What's the downside of just doing this properly?

Doing it properly by fixing GUP and not the COW logic. GUP and COW are
just incompatible and we should unshare early.

Honestly, the memory corruptions we can trigger in user space due to the
current COW logic *especially* with FOLL_WRITE users such O_DIRECT,
io_uring or vfio are not a joke anymore. (again, link in the cover letter)

-- 
Thanks,

David / dhildenb

