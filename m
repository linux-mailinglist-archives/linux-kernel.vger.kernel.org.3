Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F44549FEB2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350463AbiA1RKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245716AbiA1RKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:10:18 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358E6C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:10:18 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ah7so18107618ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJFLMYfeBc27lfteK8I/Xg4Hqnx+r1AHTLd0EGvbGxk=;
        b=dsKVOFNOF44GnkUGcoT5B3Ty8lDnYmmdoMzj5d9Vye57YmP9H4tbcOz/Q0P1LFPbFM
         Xtq7bR20UT0O+hTCcFyHLQXZfxfdhDxpdPKSa85HDErtb7qqzVTMPcosdUobwvGdM+f7
         ZDSfjcBi/DWTDhisIO7fmwUYROEICBDbQyqDVZ8E1WRPv9hfBY7PbuVWV5OSV7itZ0FX
         MrmsgY4A7fd0iTM+6YOKFCIFVyx6CbgV9/ihwX0NXXcfDxBzIYtMKZIlfsbV3+J+S/yX
         SUuBKyrzalD3dEJc08zzKx3abdu8rZKjIMejO1dil/KIW2N3RYC+MWjIW1MIuyOtZpXF
         Z5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJFLMYfeBc27lfteK8I/Xg4Hqnx+r1AHTLd0EGvbGxk=;
        b=xxiIT+Ltj0jeTl8ORtrL5jcIzc5Tkc1A4VI4n1Nov24HPQaAGtLE1ta8sj6wH9ZzR1
         N91iezwgj5m73YU+hn4tpMPjDKakreW5DZJzQ5ajOj5DNhCjctqXvFPUXT6AqOSMSqqN
         543xlCyT6cgGdiTq5BE/wE5WWiDaH1H51CenNOUQib5c823az9cToN6DiIHtVJ9wAMl9
         H6c6X6fVdiZcwIwxsDmAPpuSUpJzBeaefntxbiRk7Lukc3u01TB0OazuU9yvbGX6nMO+
         /xgQsH7Sutt/qgUFOGs39bvli0RHx+5ivct7b4y3FsNIcOIpWfUatLKQao64Y8YX8RbH
         qmRA==
X-Gm-Message-State: AOAM530rw3mYlnTGYZEZUzC7Z4SKyBzXPK8rCDBqJPjhmX3CktjkSLLo
        Fam8mf8Gqm0082V3r+j6oJzr7/2uOxOGk9YsMII=
X-Google-Smtp-Source: ABdhPJw0W7zj0PgCh2/VyMXKSlg1ZLCQamlHrW1cI6CEQbPtb7XznIP1IvGBIdREhQflgYvBBQLLQ3Dx5ZmqVkZ5NuQ=
X-Received: by 2002:a17:906:2287:: with SMTP id p7mr8039922eja.239.1643389816758;
 Fri, 28 Jan 2022 09:10:16 -0800 (PST)
MIME-Version: 1.0
References: <20220126095557.32392-1-david@redhat.com> <20220126095557.32392-7-david@redhat.com>
 <CAHbLzkpRgeYkPHUc3KAUc_Fr-YexQxK1cH92Suueac5GrwZHsw@mail.gmail.com> <205231d0-2b4e-7d93-1028-2d501c1cbf74@redhat.com>
In-Reply-To: <205231d0-2b4e-7d93-1028-2d501c1cbf74@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 28 Jan 2022 09:10:04 -0800
Message-ID: <CAHbLzkqX9tYqVnjnQN5AF2k3J7TQKXKbyG2u1LSnHc=bMPzORw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 6/9] mm/khugepaged: remove reuse_swap_page() usage
To:     David Hildenbrand <david@redhat.com>
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
        Liang Zhang <zhangliang5@huawei.com>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 12:41 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 27.01.22 22:23, Yang Shi wrote:
> > On Wed, Jan 26, 2022 at 2:00 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> reuse_swap_page() currently indicates if we can write to an anon page
> >> without COW. A COW is required if the page is shared by multiple
> >> processes (either already mapped or via swap entries) or if there is
> >> concurrent writeback that cannot tolerate concurrent page modifications.
> >>
> >> reuse_swap_page() doesn't check for pending references from other
> >> processes that already unmapped the page, however,
> >> is_refcount_suitable() essentially does the same thing in the context of
> >> khugepaged. khugepaged is the last remaining user of reuse_swap_page() and
> >> we want to remove that function.
> >>
> >> In the context of khugepaged, we are not actually going to write to the
> >> page and we don't really care about other processes mapping the page:
> >> for example, without swap, we don't care about shared pages at all.
> >>
> >> The current logic seems to be:
> >> * Writable: -> Not shared, but might be in the swapcache. Nobody can
> >>   fault it in from the swapcache as there are no other swap entries.
> >> * Readable and not in the swapcache: Might be shared (but nobody can
> >>   fault it in from the swapcache).
> >> * Readable and in the swapcache: Might be shared and someone might be
> >>   able to fault it in from the swapcache. Make sure we're the exclusive
> >>   owner via reuse_swap_page().
> >>
> >> Having to guess due to lack of comments and documentation, the current
> >> logic really only wants to make sure that a page that might be shared
> >> cannot be faulted in from the swapcache while khugepaged is active.
> >> It's hard to guess why that is that case and if it's really still required,
> >> but let's try keeping that logic unmodified.
> >
> > I don't think it could be faulted in while khugepaged is active since
> > khugepaged does hold mmap_lock in write mode IIUC. So page fault is
> > serialized against khugepaged.
>
> It could get faulted in by another process sharing the page, because we
> only synchronize against the current process.

Yes, sure. I'm supposed you meant do_swap_page() called by another
process. But it is serialized by page lock. So khugepaged won't see
something in limbo state IIUC.

>
> >
> > My wild guess is that collapsing shared pages was not supported before
> > v5.8, so we need reuse_swap_page() to tell us if the page in swap
> > cache is shared or not. But it is not true anymore. And khugepaged
> > just allocates a THP then copy the data from base pages to huge page
> > then replace PTEs to PMD, it doesn't change the content of the page,
> > so I failed to see a problem by collapsing a shared page in swap
> > cache. But I'm really not entirely sure, I may miss something...
>
>
> Looking more closely where this logic originates from, it was introduced in:
>
> commit 10359213d05acf804558bda7cc9b8422a828d1cd
> Author: Ebru Akagunduz <ebru.akagunduz@gmail.com>
> Date:   Wed Feb 11 15:28:28 2015 -0800
>
>     mm: incorporate read-only pages into transparent huge pages
>
>     This patch aims to improve THP collapse rates, by allowing THP collapse in
>     the presence of read-only ptes, like those left in place by do_swap_page
>     after a read fault.
>
>     Currently THP can collapse 4kB pages into a THP when there are up to
>     khugepaged_max_ptes_none pte_none ptes in a 2MB range.  This patch applies
>     the same limit for read-only ptes.
>
>
> The change essentially results in a read-only mapped PTE page getting copied and
> mapped writable via a new PMD-mapped THP.
>
> It mentions do_swap_page(), so I assume it just tried to do what do_swap_page()
> would do when trying to map a page swapped in from the page cache writable
> immediately.
>
> But we differ from do_swap_page() that we're not actually going to map the page
> writable, we're going to copy the page (__collapse_huge_page_copy()) and map
> the copy writable.

Yeah, this is the point. Khugepaged or the process being collapsed
won't write to the original page. Just unshare it.

>
> I assume we can remove that logic.
>
> --
> Thanks,
>
> David / dhildenb
>
