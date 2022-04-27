Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BA9512544
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiD0Wcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiD0Wcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:32:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21DB65400
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:29:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p6so2634010pjm.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hA8Xq3m1wbXqH/a0qmeDa8TEICOu26xCCl40xL9zKg=;
        b=Herq3K81McYpTzvqFagSy1plhq9FEVLAQJ8qC9KUf2XMhZskLHV+XWGU0n9cS2agrU
         D6RecRZ2Jyfts5heQzpiDSjrRR9yonolcoSQa443BAV7XZEIXu68BLoZMXCDeHcLBn5A
         vfFKGPQchZCaphz6AWPPGj9aO/w9OMOMNKPMkktWvyZDkfK7NZjzEf+T8SbzT+ln1uvB
         vEiK5SGg6/OKPeqYdRumwdTnaQgsS+8TNm+xEHlqSfsJVY2mE2RSGGc4iXI7z01gm5Fg
         cmsuRvENz6YUo7aMZv7ltCb+c/uBoGKV+Ine5BIA1cY7/L1wI0dM4j/O0fw0xrKzABv6
         dvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hA8Xq3m1wbXqH/a0qmeDa8TEICOu26xCCl40xL9zKg=;
        b=a1a9VI9iIAmyeO9EbLI/1V37kx5IEjL3JQg/Z1prSDTYagTOEqSbUeXzA4WtEObNHP
         jYseeKdAoSx9elmYzGS327MLSMcIjmrs8tee8MDfD7ZYdJlkSJ9CbjMSNLWZJvZB8FF0
         Wx3ZXm/X/1LSxomsEQjPbvivVsvEr5ZVq9yh/SRrle0jPqpd4gifgvGcvlDLvSP1KfTB
         Gr3jBJYHBWAA3pKaf2gqG5BWaRXsRDsktfJs9luJjdnO+49Pw+6HOZkGduaXgGJJkyll
         d2tONryB8NuPQEks7zJ7ZEszNhfpGcvCE9YFQxZVssNLApH4azQDNVLVveZKkaZg5But
         cNIg==
X-Gm-Message-State: AOAM532gzgHTPnj307JsvHngqffpb7oqvlfGoOF6aDv7Z82jM/LX8JQ1
        Ig6nFCm1uSJ06djjAHMMUJwzre6wA8aZ2sScMv4JTgroKGA=
X-Google-Smtp-Source: ABdhPJxXGAMdkbpoJkYXcXbM4mJ3u4915SZ/ZExCjr10hG0A0gbchKsFGHeRE5A4+UcYOsXETcMs1KPF7CUx29sBu9E=
X-Received: by 2002:a17:903:32d2:b0:15d:ea5:3e0f with SMTP id
 i18-20020a17090332d200b0015d0ea53e0fmr18844184plr.117.1651098578376; Wed, 27
 Apr 2022 15:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220317065024.2635069-1-maobibo@loongson.cn> <20220427134843.576f0a18bea28de9e798004a@linux-foundation.org>
In-Reply-To: <20220427134843.576f0a18bea28de9e798004a@linux-foundation.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 27 Apr 2022 15:29:25 -0700
Message-ID: <CAHbLzkoVdxyxKopu7D=VzvnHoiA=KYgxVWwwZwahzTcfXfcg5g@mail.gmail.com>
Subject: Re: [PATCH v3] mm/khugepaged: sched to numa node when collapse huge page
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Bibo Mao <maobibo@loongson.cn>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 1:48 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 17 Mar 2022 02:50:24 -0400 Bibo Mao <maobibo@loongson.cn> wrote:
>
> > collapse huge page will copy huge page from general small pages,
> > dest node is calculated from most one of source pages, however
> > THP daemon is not scheduled on dest node. The performance may be
> > poor since huge page copying across nodes, also cache is not used
> > for target node. With this patch, khugepaged daemon switches to
> > the same numa node with huge page. It saves copying time and makes
> > use of local cache better.
> >
> > With this patch, specint 2006 base performance is improved with 6%
> > on Loongson 3C5000L platform with 32 cores and 8 numa nodes.
> >
>
> Are there any acks for this one please?

TBH, I'm a little bit reluctant to this patch. I agree running
khugepaged on the same node with the source and dest pages could
reduce cross socket traffic and use cache more efficiently. But I'm
not sure whether it is really worth it or not. For example, on a busy
system, khugepaged may jump from cpus to cpus, that may interfere with
the scheduler, and khugepaged has to wait to run on the target cpu, it
may take indefinite time. In addition the yield also depends on the
locality of source pages (how many of them are on the same node), how
often khugepaged is woken up on a different node, etc.

Even though it was proved worth it, I'd prefer set_cpus_allowed_ptr()
is called between mmap_read_unlock() and mmap_write_lock() in order to
avoid waste effort for some error paths.

>
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1066,6 +1066,7 @@ static void collapse_huge_page(struct mm_struct *mm,
> >       struct vm_area_struct *vma;
> >       struct mmu_notifier_range range;
> >       gfp_t gfp;
> > +     const struct cpumask *cpumask;
> >
> >       VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> >
> > @@ -1079,6 +1080,13 @@ static void collapse_huge_page(struct mm_struct *mm,
> >        * that. We will recheck the vma after taking it again in write mode.
> >        */
> >       mmap_read_unlock(mm);
> > +
> > +     /* sched to specified node before huage page memory copy */
> > +     if (task_node(current) != node) {
> > +             cpumask = cpumask_of_node(node);
> > +             if (!cpumask_empty(cpumask))
> > +                     set_cpus_allowed_ptr(current, cpumask);
> > +     }
> >       new_page = khugepaged_alloc_page(hpage, gfp, node);
> >       if (!new_page) {
> >               result = SCAN_ALLOC_HUGE_PAGE_FAIL;
> > --
> > 2.31.1
> >
