Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C06249D595
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiAZWl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiAZWl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:41:26 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36309C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:41:26 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id n10so1185081edv.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPtlTy67Yq/R5pUJBh8Cj52Wrm9Q+Vs7xmfGLT5AbpA=;
        b=SetlsjCWFNKYNBg+4fhvjOH1cu+KPd/Q3nNl2FWu5Rl3JA+3w/gqKotxQ4V2hIj2zY
         vV6idOd5VQausx01qBw99aqtP3cAOzFFTrSUYfY1O336iqcRwDy+b1cSDAecK5MgVtOJ
         kPXi3Fs51HjeCquzMFeyfJ196Z8G3Pc9c5bGfDMrn/HKhSzm6vst4bdlZoHQL7A6eV05
         T0p/ZNN6X0t1lKamtBqWWrsmqJzIecVCuALFwnB2z+pblaUyTWjMER/9kc0YIhpDXEw7
         CY2c9SBzgsvKlJz7jM4NGxiqljk6q/1kWYZJQqwPAwvmU03GC01lsUp/prt1bEeqlkKM
         WQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPtlTy67Yq/R5pUJBh8Cj52Wrm9Q+Vs7xmfGLT5AbpA=;
        b=LUjFS+pZ7fMZT/PJBwQYYBM929c5XWPOZRZVnYYP9+KnE6bUvkebVD31scRci/Ifge
         7Nn384iQXqgfVNeOWETYgDh5Yz6wWW8h4NNNOSL4KLACvYCThnbIk7U5bQhuSTYXzDty
         NniMb5i1iy6n2q9Dpd1YKEGW1N5dnNoRntS7Vh764xGq1SPze3UPo3SqtE/w/mANYJmj
         B/It3iEPj3XKcBkoF8DBxBrGStegEgN0ODu2oTa+u/dW2VHHU7EknKHsj09uMaRm5gth
         gw7oPa/dSlrBAw5Qa4ufwaTIDNDzIZLf206BhT1zLykryaAGztP0as4MBH5kq1HjvC//
         w2dw==
X-Gm-Message-State: AOAM5323vt98kSUqHfY/FCT2rcKNGV5bl03hdkUfLUtzSSI2shfSna45
        iA2DgIskbNGbl3161j8h4k/fMwsmbx31IGDiqbiR7w==
X-Google-Smtp-Source: ABdhPJw5o4z8TJT1hnIdh2XuXnqKEEYj45WboF/3FXlzBvnWx2lvxlXR9cXGB9QCVLsS8inljCwxV8MKMEAwR23dChU=
X-Received: by 2002:a05:6402:11d2:: with SMTP id j18mr1016217edw.349.1643236884660;
 Wed, 26 Jan 2022 14:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
 <20220126183429.1840447-2-pasha.tatashin@soleen.com> <YfGZ/0hhkqVeX04p@casper.infradead.org>
 <CA+CK2bDHkOQbTrK=GbsGbojAj_6gaAX_8w3cBCd_LWqXt--yZA@mail.gmail.com> <YfGkxtQd0KE8YNXt@casper.infradead.org>
In-Reply-To: <YfGkxtQd0KE8YNXt@casper.infradead.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 26 Jan 2022 17:40:47 -0500
Message-ID: <CA+CK2bAvGjieaXRcHqfhfPp0uogfLOmCtbE_9w3ULFbM+ZuHNg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] mm: add overflow and underflow checks for page->_refcount
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 2:45 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jan 26, 2022 at 02:22:26PM -0500, Pasha Tatashin wrote:
> > On Wed, Jan 26, 2022 at 1:59 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Jan 26, 2022 at 06:34:21PM +0000, Pasha Tatashin wrote:
> > > > The problems with page->_refcount are hard to debug, because usually
> > > > when they are detected, the damage has occurred a long time ago. Yet,
> > > > the problems with invalid page refcount may be catastrophic and lead to
> > > > memory corruptions.
> > > >
> > > > Reduce the scope of when the _refcount problems manifest themselves by
> > > > adding checks for underflows and overflows into functions that modify
> > > > _refcount.
> > >
> > > If you're chasing a bug like this, presumably you turn on page
> > > tracepoints.  So could we reduce the cost of this by putting the
> > > VM_BUG_ON_PAGE parts into __page_ref_mod() et al?  Yes, we'd need to
> > > change the arguments to those functions to pass in old & new, but that
> > > should be a cheap change compared to embedding the VM_BUG_ON_PAGE.
> >
> > This is not only about chasing a bug. This also about preventing
> > memory corruption and information leaking that are caused by ref_count
> > bugs from happening.
> > Several months ago a memory corruption bug was discovered by accident:
> > an engineer was studying a process core from a production system and
> > noticed that some memory does not look like it belongs to the original
> > process. We tried to manually reproduce that bug but failed. However,
> > later analysis by our team, explained that the problem occured due to
> > ref_count bug in Linux, and the bug itself was root caused and fixed
> > (mentioned in the cover letter).  This work would have prevented
> > similar ref_count bugs from yielding to the memory corruption
> > situation.
>
> But the VM_BUG_ON_PAGE tells us next to nothing useful.  To take
> your first example [1] as the kind of thing you say this is going to
> help fix:
>
> 1. Page p is allocated by thread a (refcount 1)
> 2. Thread b gets mistaken pointer to p

Thread b gets a mistaken pointer to p because of a bug in the kernel.
The different types of bugs can lead to such scenarios, and it is
probably not feasible to prevent all of them. However, one of such
scenarios is that we lost control of ref_count, and the page was then
incorrectly remapped or even copied (perhaps migrated) into another
address space.

While studying the logs of the machine on which the double mapping
occured, we noticed that ref_count was underflowed. This was the
smoking gun for the problem, and that is why we concentrated our
search for the root cause of memory leak around places where ref_count
can be incorrectly modified.

This patch series ensures that once we get to a situation where
ref_count is for some reason becomes negative we panic immediately as
there is a possibility that a  leak can occur.

The second benefit of this series is that it makes the ref_count
changes contiguous, with this series we never reset the value to 0,
instead we only operate using offsets and add/sub operations. This
helps with tracing the history of ref_count via tracepoints.

> 3. Thread b calls put_page(), __put_page(), page goes to memory
>    allocator.
> 4. Thread c calls alloc_page(), also gets page p (refcount 1 again).
> 5. Thread a calls put_page(), __put_page()
> 6. Thread c calls put_page() and gets a VM_BUG_ON_PAGE.
>
> How do we find thread b's involvement?  I don't think we can even see
> thread a's involvement in all of this!  All we know is a backtrace
> pointing to thread c, who is a completely innocent bystander.  I think
> you have to enable page tracepoints to have any shot at finding thread
> b's involvement.

You are right, we cannot get to see thread's involvement, we only get
a panic closer to the damage and hopefully prior to leak occurs.
Again, this is just one of the mitigation techniques. Another one is
this page table check [2].

[2] https://lore.kernel.org/all/20211221154650.1047963-1-pasha.tatashin@soleen.com
>
> [1] https://lore.kernel.org/stable/20211122171825.1582436-1-gthelen@google.com/
