Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C1A4704FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhLJP6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhLJP6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:58:18 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EC0C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:54:43 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id q74so22256181ybq.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kW7Q/LugBcH/uCDE9PPR6dCoA6/hhRUnTlYK4AiWCpg=;
        b=AZl1o1IFb3Nz4EmhYiwZ5DlrcG8t2+Z9y6q6VAeByEdkqmgp+fBrONT7YTLF7IMttC
         WXARf589SjOf9ehimiLJYN9AQQGV2N+ZJBgMTOYyEYwQQL0T1MYqo8yXpUrrcHYRgAhS
         ELz8h4rWxgMux+V4wSNkaojNe9ow6TEIj+2BUZxxIYB7W9xtPx45s1+xmmQ5WCT6Bq94
         C0NhYMSOJ567UNemdlLp1XWjxURNHKmbc15AZtrXWQAfthPrjC7AjB0jqyeWNbiJFy5v
         I2xRfLiCNLdMVy1vyDKJWuiQBSBmdj6RCIarSib0cCuiQNK0mJSSKM6jYYE6k8+Bzvgo
         0UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kW7Q/LugBcH/uCDE9PPR6dCoA6/hhRUnTlYK4AiWCpg=;
        b=E+4GKHKdGbA2LHSpCYc0YeSkNNh/a0XYNcJx+a1ZriTqh83tflFzpomgDLoGxZcH6o
         4PMda0MMaO7VopX+frcCOEFXre6jlT6lvoc9x7P7LeNYyn8sNgsH6X4lbmXETYtlWT/P
         gMD0+ZERMYFpIRMd1TFetipStUlar+wj7BMj3V1PQ81kucrAgdN9Gaf7Of8txjiG35Hk
         XkBQvcfcNF625s0baCCdeiHkryAVvWRmJnN7cRpW7pqDI14KOrjfYM8PAKVW+cCy/xA6
         nITkIUCO1GgJuJMnAllNlrmm7dDb4BzIbfpLNPHPpNLxQ1o4c7U5+un4hDsx8UeURtb+
         vtfQ==
X-Gm-Message-State: AOAM5313C8fv4Lt8ScIKRYWoTr9M+HbYnUqeUYl87Y/P7jFU9f+UK/8G
        EY0LeGV09/oLzgr+6pPIKLXWJg4MIsUSTeaLRg82DQ==
X-Google-Smtp-Source: ABdhPJz3lecIwmiGJsNOCDla5KNxDmiTdHhAeGjqzPLGHn4JQfbuuJ2BRrxzXV2uq3KnACw2i4zSPW6BRg5Tyz6SAa4=
X-Received: by 2002:a25:610d:: with SMTP id v13mr14409655ybb.1.1639151682583;
 Fri, 10 Dec 2021 07:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20211209191325.3069345-1-surenb@google.com> <20211209191325.3069345-3-surenb@google.com>
 <20211209204816.GF6467@ziepe.ca>
In-Reply-To: <20211209204816.GF6467@ziepe.ca>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 10 Dec 2021 07:54:31 -0800
Message-ID: <CAJuCfpFr-3S2Ge56p3d8CYWFCSmVheLi-9aVBv2Utg9mwBgrcw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mm/oom_kill: allow process_mrelease to run under
 mmap_lock protection
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, mhocko@suse.com,
        rientjes@google.com, willy@infradead.org, hannes@cmpxchg.org,
        guro@fb.com, riel@surriel.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, luto@kernel.org,
        christian.brauner@ubuntu.com, fweimer@redhat.com, jengelh@inai.de,
        timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 12:48 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Dec 09, 2021 at 11:13:25AM -0800, Suren Baghdasaryan wrote:
> > With exit_mmap holding mmap_write_lock during free_pgtables call,
> > process_mrelease does not need to elevate mm->mm_users in order to
> > prevent exit_mmap from destrying pagetables while __oom_reap_task_mm
> > is walking the VMA tree. The change prevents process_mrelease from
> > calling the last mmput, which can lead to waiting for IO completion
> > in exit_aio.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > ---
> > changes in v5
> > - Removed Fixes: tag, per Michal Hocko
> > - Added Acked-by's
> >
> >  mm/oom_kill.c | 27 +++++++++++++++------------
> >  1 file changed, 15 insertions(+), 12 deletions(-)
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks!

>
> There are mmget_not_zero's all over the place, can others be cleaned
> after this series goes ahead too?
>
> It seems like anything doing the mmget just to look at the vma list
> under the mmap lock is now fine with only a mmgrab?

Sounds reasonable to me. I'll try to carve out some time to look into
it but no promises. Lots of loose ends to tie at the end of the year
:(

>
> A few I know about:
>
> drivers/infiniband/core/umem_odp.c:     if (!mmget_not_zero(umem->owning_mm)) {
>
> This is because mmu_interval_notifier_insert() might call
> mm_take_all_locks() which was unsafe with concurrent exit_mmap
>
> drivers/infiniband/core/umem_odp.c:     if (!owning_process || !mmget_not_zero(owning_mm)) {
>
> This is because it calls hmm_range_fault() which iterates over the vma
> list which is safe now
>
> drivers/iommu/iommu-sva-lib.c:  return mmget_not_zero(mm);
> drivers/iommu/iommu-sva-lib.c:  return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>
> It calls find_extend_vma() - but also it doesn't seem to have a mmgrab when it
> does that mmget. The rcu is messed up here too, so humm.
>
> Jason
