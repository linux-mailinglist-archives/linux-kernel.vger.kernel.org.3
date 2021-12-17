Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BE2479590
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 21:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbhLQUkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 15:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhLQUkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:40:01 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4CFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:40:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g14so12364817edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fFYHj/85wq9sp2q1J+u1Ml7YxuIRP5NvJyUtf+MXyA=;
        b=cJw7R6IKrWDvsdo4quNKJl7yowzlSAHbDI1qyzLRE08kUlNHdph4InZjJ8Da37rlMW
         TYTu57W8GfVaR3uyaMrsqy6OJvP+dnCqaEhL+vDOl/t5etD3LFAphX+fle4Z+4q5JUHs
         HptT4U/SfI31C1p3odw09uIZxNiTnn51wMLzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fFYHj/85wq9sp2q1J+u1Ml7YxuIRP5NvJyUtf+MXyA=;
        b=Y7kAK3oyD4Glrj1IHRwhgMCHgN3uz3gq+W3NYXci/ApA83cYB07jlCXhoFa2K40m7z
         f8HMwhvE8yqTlJT2Or0VYG+irnwDH8j0AhOWCzXitxpKbu1YDDv9NatRzK7gKxjaKycw
         shigL+wRaa8e07RGCv6zMdC6+JhB+qQGai+8Y6VWKLJRiCu+1xodKxinuU9ECCbxz5S5
         qbRfzfFeo2N5bK8MJ/px6kUoKLU2L9Pe2Z712b5j0Xj0yZCncpjRUrVbBa2Wnh2IljGp
         fG+2wszLTvogKBX5N6Go+EJkzVvehSX9uNlk2Cw7EJlVGGoZkWaQrsWO0joOu1XJZILJ
         g5TA==
X-Gm-Message-State: AOAM530XKWHBT/P5C7iL+4EABObGsXuCQqnPP9kKsddjcQ8MFsF0HiNp
        5Xc+70jW6nb4bzOxXtDOKw46V/XXZ5fp11tiQu8=
X-Google-Smtp-Source: ABdhPJztnsIzCtvsuExYRVe7fKNkIVoPeHSKoqP7vkn3MFXX8GF63An+ARkj3z3LaEm4ZuQw/NfhuA==
X-Received: by 2002:a05:6402:26c8:: with SMTP id x8mr4398174edd.156.1639773599289;
        Fri, 17 Dec 2021 12:39:59 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id s8sm3167527ejs.174.2021.12.17.12.39.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 12:39:58 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id v11so6209494wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:39:58 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr3847861wrp.442.1639773598131;
 Fri, 17 Dec 2021 12:39:58 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com> <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 12:39:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgD1Y_hV3eCRL55m+sGfmwic0wbq+0LV8youYKirHJTog@mail.gmail.com>
Message-ID: <CAHk-=wgD1Y_hV3eCRL55m+sGfmwic0wbq+0LV8youYKirHJTog@mail.gmail.com>
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

On Fri, Dec 17, 2021 at 12:36 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> >
> > 5. Take a R/O pin (RDMA, VFIO, ...)
> > -> refcount > 1
> >
> > 6. memset(mem, 0xff, pagesize);
> > -> Write fault -> COW
>
> I do not believe this is actually a bug.
>
> You asked for a R/O pin, and you got one.

If you want a shared pin that actually follows the changes of your
process around, then that is what you should have asked for.

At the time of such a shared pin, you can do what we already do:
re-use the page if it has a refcount of 1. Or do an early COW event
(feel free to avoid the "mark it writable and dirty").

But note: *refcount* of 1. Not "mapcount". Because mapcount would be
broken garbage.

                Linus
