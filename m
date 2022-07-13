Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681B0573FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbiGMWqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiGMWqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:46:44 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5224F1AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:46:43 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id k1so47287ilu.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUjyOf0yqWbtmoJVmUzPdPx8CgvmqB2wj4J+/5xtVEo=;
        b=eJ+EKHcT3rbS+tFdvIEqpvHXsfqe+T1C6Y27MaVrAYD0y6pvZn4BETZUgJpq92SNkh
         ya0/Yt9n3YO6jCtaVeS7UAhiq5Xk3F/4w0Fa8tfGfCpb//cB7C/+tMyRw0+6y8nHOpq8
         xBk4TseGtpF+wl2t6Ng3OyQtBEfrhPFPL459Q+DWz0njOuDVH3E+Ns4NG0R8giaatofP
         bAjWOLqe8UsMfsmft4v818VseaZD8rr76lZzRWytLZlCifHJFD+1vVyfpUOVvFzqbBCO
         aMViiduLtXJFsW4MK/2sJgtPHR6WEdj2hpn4UQ3TXPlkPIj49u3ktBJT7Ced9/vzSEVE
         bgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUjyOf0yqWbtmoJVmUzPdPx8CgvmqB2wj4J+/5xtVEo=;
        b=HkbFeuAPLyFsdO5uRYfhc7VWAhmdNT+vbi3X7CkYgnIXIke/BGuxj79ePMIkfQe281
         kGtPmNudZ1Z/g9xkuqPY4Pghepwx21rH7IQuyuCWcrdUQ3TEw8ZY6S0vJA0AMSJLa3PL
         we7iwXOrMsza9FlteoN1tFt2f+NSRU1TrKFOoxx+Jy9PWjqgNPzF7XpLxzdMWOIWlGi/
         8B9qfY1XAOOh0oZwR52m6tYzoWxF8Tk+JBI5cug2G9Dr8J9gBCbLpk3u2pzAIvPS0Z21
         316zZlAi/zfziGvkzC3+jlo9ocRfyPCmODv4mhA49N8G/x0CVwXhuzgS4r+HJK4Z04WJ
         C1og==
X-Gm-Message-State: AJIora8HHS0MsaSAy4VWT+shug0ukM4B+L+BjCqWLIkxWpusbBnQcsND
        e93lgkKcsrXyF7tbHFk8djSRYqzTv4OYmzsECiaOAg==
X-Google-Smtp-Source: AGRyM1va1xZyVCIOolaP1ogeUVdO3Zk/o5dg4DYT3LF29gUCdDFfYdJj9NmtnAyhMSMjGLkerQY8wNOtwZ8PJ7wHH4k=
X-Received: by 2002:a05:6e02:1be9:b0:2dc:7fb2:706e with SMTP id
 y9-20020a056e021be900b002dc7fb2706emr2948941ilv.239.1657752402648; Wed, 13
 Jul 2022 15:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220712130542.18836-1-linmiaohe@huawei.com> <Ys2xyCUnqpJt0eIo@monkey>
 <Ys7ViSsOxLaQJIfy@xz-m1.local> <Ys7uXHdzzFezUub5@xz-m1.local>
In-Reply-To: <Ys7uXHdzzFezUub5@xz-m1.local>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 13 Jul 2022 15:46:06 -0700
Message-ID: <CAJHvVcgqb6R6ePMbgmA8LpMpMgrGWie9ZCTuR4MA77GTvi4XAw@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in hugetlb_mcopy_atomic_pte
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think there is a small mistake in this patch.

Consider the non-minor-fault case. We have this block:

/* Add shared, newly allocated pages to the page cache. */
if (vm_shared && !is_continue) {
        /* ... */
}

In here, we've added the newly allocated page to the page cache, and
we've set this page_in_pagecache flag to true. But we *do not* setup
rmap for this page in this block. I think in this case, the patch will
cause us to do the wrong thing: we should hugepage_add_new_anon_rmap()
further down, but with this patch we dup instead.

On Wed, Jul 13, 2022 at 9:10 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jul 13, 2022 at 10:24:09AM -0400, Peter Xu wrote:
> > On Tue, Jul 12, 2022 at 10:39:20AM -0700, Mike Kravetz wrote:
> > > On 07/12/22 21:05, Miaohe Lin wrote:
> > > > In MCOPY_ATOMIC_CONTINUE case with a non-shared VMA, pages in the page
> > > > cache are installed in the ptes. But hugepage_add_new_anon_rmap is called
> > > > for them mistakenly because they're not vm_shared. This will corrupt the
> > > > page->mapping used by page cache code.
> > > >
> > > > Fixes: f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl")
> > > > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > > > ---
> > > >  mm/hugetlb.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > This looks correct to me.
> > >
> > > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > >
> > > However, I am having a hard time wrapping my head around how UFFDIO_CONTINUE
> > > should work on non-anon private mappings.  For example, a private mapping of
> > > a hugetlbfs file.  I think we just map the page in the file/cache and do not
> > > set the write bit in the pte.  So, yes we would want page_dup_file_rmap()
> > > in this case as shown below.
> > >
> > > Adding Axel and Peter on Cc: as they were more involved in adding that code
> > > and the design of UFFDIO_CONTINUE.
> >
> > Yes the change makes sense to me too.  There's just one thing to check on
> > whether minor mode should support private mappings at all as it's probably
> > not in the major goal of when it's proposed.
> >
> > I don't see why it can't logically, but I think we should have failed the
> > uffdio-register already somewhere before when the vma was private and
> > registered with minor mode.  It's just that I cannot quickly find it in the
> > code anywhere..  ideally it should be checked in vma_can_userfault() but it
> > seems not.
> >
> > Axel?
> >
> > PS: the minor mode man page update seems to be still missing.
>
> Oh I should have done a pull first on the man-page repo..
>
> From the man page indeed I didn't see anything mentioned on not allowing
> private mappings.  There's the example given on using two mappings for
> modifying pages but logically that applies to private mappings too - we
> could have mapped the uffd region with private mappings but the other one
> shared, then we can modify page caches but later after pte installed it'll
> trigger cow for writes.
>
> So I think we need to confirm whether private mappings are supported. If
> no, we should be crystal clear in both the code and man page (we probably
> want a follow up patch to man-page to mention that too?).  If yes, we'll
> need Miaohe's patch and also make sure they're enabled in the current code
> path.  We'll also want to set test_uffdio_minor=1 for "hugetlb" test case
> in the userfaultfd kselftest (currently it's not there).

So, originally when I proposed minor fault handling, I was expecting
to only support VM_SHARED VMAs. Indeed, I too have a hard time
imagining how one might benefit from using it with a private mapping.
If my memory serves this restriction was relaxed due to feedback on
the original RFC proposal [1], essentially on the basis of: why make
it more restrictive than it needs to be? Since all we need for a minor
fault to happen is for the pages to be in the page cache, that's the
only restriction we should have.

I don't see why it shouldn't work in principle though. Imagine a
scenario where the VM guest's mapping is private, and the memory
manager's mapping is shared. I guess in this case, say for a write
from the guest:

1. The guest will generate a minor fault
2. The memory manager can modify the page via its shared mapping, and
the guest will see those changes
3. After UFFDIO_CONTINUE resolves the fault, the page is CoW-ed, and
the memory manager can no longer see the guest's version of the page

I'm not really sure *why* you'd want to do this, but it seems like it
should work.

[1]: https://patchwork.kernel.org/project/linux-mm/patch/20210107190453.3051110-2-axelrasmussen@google.com/

>
> --
> Peter Xu
>
