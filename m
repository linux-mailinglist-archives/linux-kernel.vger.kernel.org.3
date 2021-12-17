Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70ED47967D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhLQVr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:47:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229590AbhLQVrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639777645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WvXlhuvoyqQ/nEvi2sE+ZfIFkcm6bbvZ5PcvxRE9QYk=;
        b=VJ/TMY8cwbsL/ppfYHmGuz3gLIgTbxgSl/+sWwa5iJoWygSNrjRbC7hp681Iows2qX2yvm
        BngC+QhdPtE9CJR3V36OvxxOAp4uuNevkuehJb/hh4yNJ5gtR3eIEpJdv4Zh3jck45D44y
        aA6QQxfEURTYMwOVaFSxXuAkXTtd0Xo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-6_1JLRpzNEqwxrKcOQC47Q-1; Fri, 17 Dec 2021 16:47:23 -0500
X-MC-Unique: 6_1JLRpzNEqwxrKcOQC47Q-1
Received: by mail-wm1-f71.google.com with SMTP id az35-20020a05600c602300b00345812649ddso90766wmb.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 13:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=WvXlhuvoyqQ/nEvi2sE+ZfIFkcm6bbvZ5PcvxRE9QYk=;
        b=4XRhkxtyqkbKpDft0giy2xndFR92s/FjUKeMbA/R6HSdozmmvwjH8DcBD1V5ScKtjP
         dV+9LeZOJdIbsvJ9a3REVopDYjjs33EQxZ9W+AAaxbP3Pm2Dsb3r/vfT4VxDwgAqsBY/
         94F24GMlVJcfOF7YHQcCeMEmrffsO3da6qvnQ3ehanVCu4yFEkFEUdBa99ziWi0/a0P1
         v1qGn6A3Gk9uvwoYsZMCDiARdbQ3TVbqwKJu9wSe9B5O6kHkLd9jpXaDofipXUvfLDme
         44oekGPciGA+eVrpHmiJcP+pbQfKVyCdhk4ciRyinE714zpbHWVHkgeyIyfrK11apoBa
         N0eA==
X-Gm-Message-State: AOAM530U6ErcSlIN5IRgfVeBTTJ29twbUjwGKFqhLPBu0EhlJpTUMsoU
        2jCknoWugYzEjyz2KQM9aQWKAm2w/rikNBdw05zZNlintdQixHDlCq2j8gIWYJUvY0nWWuUURUo
        6eIL4eTqoXXxDbOciX9+6tRYo
X-Received: by 2002:a05:600c:1e1c:: with SMTP id ay28mr11017047wmb.131.1639777642021;
        Fri, 17 Dec 2021 13:47:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJedX+I/4u/x6GDRH9l8IWq6Pzbh4I8I+fvWisIgceyydoV9yQ3TNEm9r2dxERxeBN0DVJVA==
X-Received: by 2002:a05:600c:1e1c:: with SMTP id ay28mr11017038wmb.131.1639777641748;
        Fri, 17 Dec 2021 13:47:21 -0800 (PST)
Received: from [192.168.3.132] (p4ff234b8.dip0.t-ipconnect.de. [79.242.52.184])
        by smtp.gmail.com with ESMTPSA id n24sm8313296wms.45.2021.12.17.13.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 13:47:21 -0800 (PST)
Message-ID: <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com>
Date:   Fri, 17 Dec 2021 22:47:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
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
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com>
 <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
 <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com>
 <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
In-Reply-To: <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.21 22:36, Linus Torvalds wrote:
> On Fri, Dec 17, 2021 at 12:55 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> If we have a shared anonymous page we cannot have GUP references, not
>> even R/O ones. Because GUP would have unshared and copied the page,
>> resulting in a R/O mapped anonymous page.
> 
> Doing a GUP on an actual shared page is wrong to begin with.
> 
> You even know that, you try to use "page_mapcount() > 1" to disallow it.

GUP is incomaptible with shared anonymous pages, therefore it has to
trigger unsharing, correct.

> 
> My point is that it's wrong regardless, and that "mapcount" is
> dubious, and that COW cannot - and must not - use mapcount, and that I
> think your shared case should strive to avoid it for the exact same
> reason.

For now I have not heard a compelling argument why the mapcount is
dubious, I repeat:

* mapcount can only increase due to fork()
* mapcount can decrease due to unmap / zap

We can protect from the transtition == 1 -> >1 using the mmap_lock.

For COW the mapcount is the only thing that matters *if we take GUP* out
of the equation. And that's exactly what we

OTOH, take a look which issues resulted from the page_count changes.
That's what I call dubious, sorry to say.

> 
> So, what I think should happen is:
> 
>  (a) GUP makes sure that it only ever looks up pages that can be
> shared with this VM. This may in involve breaking COW early with any
> past fork().

Is that unsharing as we propose it?

> 
>  (b) it marks such pages so that any future work will not cause them
> to COW either

Right, exactly. GUP before fork does not result in a page getting shared
again.

> 
> Note that (a) is not necessarily "always COW and have to allocate and
> copy new page". In particular, if the page is already writable, you
> know you already have exclusive access to it and don't need to COW.
> 
> And if it isn't writable, then the other common case is "the cow has
> only one user, and it's us" - that's the "refcount == 1" case.
> 
> And (b) is what we do with that page_maybe_dma_pinned() logic for
> fork(), but also for things like swap cache creation (eg see commit
> feb889fb40fa: "mm: don't put pinned pages into the swap cache").

I fully agree with b). GUP before fork is a totally different set of
problems than GUP after fork.

> 
> Note that this code all already exists, and already works - even
> without getting the (very expensive) mmap_sem. So it works with
> fast-GUP and it can race with concurrent forking by another thread,
> which is why we also have that seqcount thing.

I know, I studied it intensively :)

> 
> As far as I can tell, your "mapcount" logic fundamentally requires
> mmap_sem for the fork() race avoidance, for example.

Yes. Or any other more lightweight synchronization in the future. For
now this is just perfect.

> 
> So this is why I don't like the mapcount games - I think they are very
> fragile, and not at all as logical as the two simple rules a/b above.

I don't really see anything fragile, really. I'm happy to learn as always.

> 
> I believe you can make mapcount games _work_ - we used to have
> something like that. It was incredibly fragile, and it had its own set
> of bugs, but with enough care it's doable.

We made it work, and it was comparatively simple.

-- 
Thanks,

David / dhildenb

