Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FB7479C6D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 20:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhLRTxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 14:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhLRTxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 14:53:01 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E7BC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 11:53:00 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id j21so16980975edt.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 11:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FwDKq6c1mQYLU0p0J66kK9b9U2JQzk1+tCZIkkXvJ6I=;
        b=U5uC3Kaqj3Jyz9ClVkVNdaCklm+oiz2jhIexhCBthnjLmX3U7Wkoqfro6mIgIQYih1
         fYnIl74HxHVmm4oN5qZYu46cLpq/0a9MM0L7iLgtvdvWn7S16gUCjgjGv0WBg5JYcwY8
         2t/4p+6P3qYm2phM4iAacdJb1uzh4Bb51ORJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FwDKq6c1mQYLU0p0J66kK9b9U2JQzk1+tCZIkkXvJ6I=;
        b=pEE7H6pjrTDP2qTZhajTFhNNiwSik+V5SVi6MknBfeoTfHbUJwoR8FsQK36xC4o7ZJ
         o6phbABOXG+aKO332v6CVy6X/7xtu9UlA92Zydv3fsLFo15vG5sCHaJ8hez6Y7KDcqPe
         vNDaP/bYt8BdZNKmi43U/AmkftZXf0gKeP1yLVQdZtn6Hrc3Kby6KAAhD4cXNDX2TaG5
         6zvH51DPE6J0SJAAcM1gkkCTqd3NEwBS+gq45zv4SIda9GhIempZfVxomt/cA++JmR1T
         mG5wzP/APgNrcXXtt4AR46FrDu9vysajJf4V9IlbMgv+W3dLH1Vq/j+rZROlO6bOJDlR
         bIYw==
X-Gm-Message-State: AOAM531B1TT05ZROH6hkfSwZcfvguPZZ9XuyZbujn2fqpwOjhOZTXcKg
        AZ5OBg/atQU9pJzhDUr2Q0NZ0w+ph06tc3CGJp0=
X-Google-Smtp-Source: ABdhPJxJZLGI3zXGaPdxAnGq7GIDcgFTWVLd+cel6NNRm6GJpfPlH7HRygCT6zcHFC1MrOUhmBqCiA==
X-Received: by 2002:a17:906:c12:: with SMTP id s18mr7508706ejf.723.1639857179142;
        Sat, 18 Dec 2021 11:52:59 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id p7sm4868966edu.84.2021.12.18.11.52.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 11:52:58 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id v11so10937178wrw.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 11:52:57 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr6423478wrx.193.1639857177671;
 Sat, 18 Dec 2021 11:52:57 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com> <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
 <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com> <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
 <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com> <CAHk-=wiujJLsLdGQho8oSbEe2-B1k1tJg6pzePkbqZBqEZL56A@mail.gmail.com>
 <f271bb98-dfdd-1126-d9b9-3103e4398e00@redhat.com> <CAHk-=wjvoTRSb87R-D50yOXqX4mshjiiAyurAKCsdW0_J+sf7A@mail.gmail.com>
 <40e7e0ab-0828-b2e7-339f-35f68a228b3d@redhat.com> <CAHk-=wg95CiyT45ZOxtnWQ7cdKmejXcOydEyJcTTNnp5-nd+xg@mail.gmail.com>
In-Reply-To: <CAHk-=wg95CiyT45ZOxtnWQ7cdKmejXcOydEyJcTTNnp5-nd+xg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Dec 2021 11:52:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjevjeL44qafYd8=cJHZgNUOUuWVJ28vkS4U4v_Af-xaQ@mail.gmail.com>
Message-ID: <CAHk-=wjevjeL44qafYd8=cJHZgNUOUuWVJ28vkS4U4v_Af-xaQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     David Hildenbrand <david@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 11:21 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> To recap:
>  (1) is important, and page_count() is the only thing that guarantees
> "you get full access to a page only when it's *obviously* exclusively
> yours".
>  (2) is NOT important, but could be a performance issue, but we have
> real data from the past year that it isn't.
>  (3) is important, and has a really spectacularly simple conceptual
> fix with quite simple code too.
>
> In contrast, with the "mapcount" games you can't even explain why they
> should work, and the patches I see are actively buggy because
> everything is so subtle.

So to challenge you, please explain exactly how mapcount works to
solve (1) and (3), and how it incidentally guarantees that (2) doesn't
happen.

And that really involves explaining the actual code too. I can explain
the high-level concepts in literally a couple of sentences.

For (1), "the page_count()==1 guarantees you are the only owner, so a
COW event can re-use the page" really explains it. And the code is
pretty simple too. There's nothing subtle about "goto copy" when
pagecount is not 1. And even the locking is simple: "we hold the page
table lock, we found a page, it has only one ref to it, we own it"

Our VM is *incredibly* complicated. There really are serious
advantages to having simple rules in place.

And for (2), the simple rule is "yeah, we can cause spurious cow
events". That's not only simple to explain, it's simple to code for.
Suddenly you don't need to worry. "Copying the page is always safe".
That's a really really powerful statement.

Now, admittedly (3) is the one that ends up being more complicated,
but the *concept* sure is simple. "If you don't want to COW this page,
then don't mark it for COW".

The *code* for (3) is admittedly a bit more complicated. The "don't
mark it for COW" is simple to say, but we do have that fairly odd
locking thing with fork() doing a seqcount_write_begin/end, and then
GIP does the read-seqcount thing with retry. So it's a bit unusual,
and I don't think we have that particular pattern anywhere else, but
it's one well-defined lock and while unusual it's not *complicated* as
far as kernel locking rules go. It's unusual and perhaps not trivial,
but in the end those seqcount code sequences are maybe 10 lines total,
and they don't interact with anything else.

And yes, the "don't mark it for COW" means that write-protecting
something is special, mainly because we sadly do not have extra bits
in the page tables. It would be *really* easy if we could just hide
this "don't COW this page" in the page table. Truly trivial. We don't,
because of portability across different architectures ;(

So I'll freely give you that my (3) is somewhat painful, but it's
painful with a really simple concept.

And the places that get (3) wrong are generally places that nobody has
been able to care about. I didn't realize the problem with creating a
swap page after the fact for a while, so that commit feb889fb40fa
("mm: don't put pinned pages into the swap cache") came later, but
it's literally a very simple two-liner.

The commit message for commit feb889fb40fa may be worth reading. It
very much explains the spirit of the thing, and is much longer than
the trivial patch itself.

Simple and clear concepts matter. Code gets complicated even then, but
complex code with complex concepts is a bad combination.

              Linus
