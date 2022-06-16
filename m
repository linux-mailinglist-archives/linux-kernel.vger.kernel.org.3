Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A259254E65A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377157AbiFPPqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiFPPqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:46:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971D33A183
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:46:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso1847073pja.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ffzohgt2EvedcRRIMTsyG2X/MQ03c9wXeciF15Oq6Ng=;
        b=McIHuZzsC3H1kWSvrkdpTO2v2hoAt8o0owjGbfB5EPCmbMgt4giRh78MGrZAx1K/Vx
         3hSOUEHdeMDDoITFNpkasIjwM0dK5T3yz3A0SINbnVxVUXjZZOKW0WV3f5dhmz15gPwT
         TWuh6ozuMb7A65fCsoHeNppBEFcS+nva262G93J2ylDhaJh8ZFpv5F74asX6tlT1QXIj
         LiP883fjHg8Ncxc4RWeuDJ6dH8BFNPTyTIGU2N8EXEOfPqOXunEv8BxdFrXnV6dWzpBP
         tsoZuRXJmZ1wfgdFGWT5uxVXFIoVwwrImDl345kOvIlIrKh7tV0XSPHJWLPTX9F6x8oF
         lsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ffzohgt2EvedcRRIMTsyG2X/MQ03c9wXeciF15Oq6Ng=;
        b=bMV80XWxh3/HuAAlPrIybXBwkkle5fXX58pzBoRX75GegIyq6l8hEATDmczov/Ol5+
         1FU6lQhZVjK1/rvM37m50071Td7Nik7GEasSPjzNnH2Un612uyWlLiYUd6WHCQsenpPi
         3KzSq18240fJcOqr4Z9Lc+1OQadoKUUp4DnEXYQ98M+MEpTv2ZsnD5m6LZACkG1d75+q
         lT7FvnWnUK+k8OQw9Src9pUzc+B2144Igwc2ybuKEUh3gF2XGYmmpPjbVXqWouS3zj5T
         diUBCOB8rc1bHvfnHIMDmdO/zpqHh/TtiraXnSp3aWcwnwlKcIXIoLTFbX9sB2d8Qpa2
         FKDw==
X-Gm-Message-State: AJIora/8r0p2zkc306cnT5LJDWQqRAHkhBJZh6Np8bw3X+C4p9OuZf30
        KJGRa+TQ40qedrtztiel0QjKNTfWvRYWfI3E08gow0Hn
X-Google-Smtp-Source: AGRyM1unBGJnyU7EmMM+EJ6aDdAYlWIMWjsCS3b1VlsOjgrkz6vwZxC65ybO1b3St95lsFGnD2zhrSzxHZrK8JmIXcg=
X-Received: by 2002:a17:903:32c4:b0:167:6e6f:204b with SMTP id
 i4-20020a17090332c400b001676e6f204bmr5208083plr.117.1655394412127; Thu, 16
 Jun 2022 08:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220611084731.55155-1-linmiaohe@huawei.com> <20220611084731.55155-3-linmiaohe@huawei.com>
 <CAHbLzkpc8ag7MkY_D17U1B7SjZFO2Bss8rVVj-scMOC8ttqxEg@mail.gmail.com> <c5b8f0c3-de35-9f0e-a3a8-6e132ac398cc@huawei.com>
In-Reply-To: <c5b8f0c3-de35-9f0e-a3a8-6e132ac398cc@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 16 Jun 2022 08:46:39 -0700
Message-ID: <CAHbLzkqUgTS0La43PaAXEL81UGR4Z7_YDOCYiMa-KcX=CCe9AA@mail.gmail.com>
Subject: Re: [PATCH 2/7] mm/khugepaged: stop swapping in page when
 VM_FAULT_RETRY occurs
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:40 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/6/16 1:49, Yang Shi wrote:
> > On Sat, Jun 11, 2022 at 1:47 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
> >>
> >> When do_swap_page returns VM_FAULT_RETRY, we do not retry here and thus
> >> swap entry will remain in pagetable. This will result in later failure.
> >> So stop swapping in pages in this case to save cpu cycles.
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  mm/khugepaged.c | 19 ++++++++-----------
> >>  1 file changed, 8 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >> index 73570dfffcec..a8adb2d1e9c6 100644
> >> --- a/mm/khugepaged.c
> >> +++ b/mm/khugepaged.c
> >> @@ -1003,19 +1003,16 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
> >>                 swapped_in++;
> >>                 ret = do_swap_page(&vmf);
> >>
> >> -               /* do_swap_page returns VM_FAULT_RETRY with released mmap_lock */
> >> +               /*
> >> +                * do_swap_page returns VM_FAULT_RETRY with released mmap_lock.
> >> +                * Note we treat VM_FAULT_RETRY as VM_FAULT_ERROR here because
> >> +                * we do not retry here and swap entry will remain in pagetable
> >> +                * resulting in later failure.
> >
> > Yeah, it makes sense.
> >
> >> +                */
> >>                 if (ret & VM_FAULT_RETRY) {
> >>                         mmap_read_lock(mm);
> >
> > A further optimization, you should not need to relock mmap_lock. You
> > may consider returning a different value or passing in *locked and
> > setting it to false, then check this value in the caller to skip
> > unlock.
>
> Could we just keep the mmap_sem unlocked when __collapse_huge_page_swapin() fails due to the caller
> always doing mmap_read_unlock when __collapse_huge_page_swapin() returns false and add some comments
> about this behavior? This looks like a simple way for me.

Yeah, that sounds better.

>
> >
> >> -                       if (hugepage_vma_revalidate(mm, haddr, &vma)) {
> >> -                               /* vma is no longer available, don't continue to swapin */
> >> -                               trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> >> -                               return false;
> >> -                       }
> >> -                       /* check if the pmd is still valid */
> >> -                       if (mm_find_pmd(mm, haddr) != pmd) {
> >> -                               trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> >> -                               return false;
> >> -                       }
> >> +                       trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> >> +                       return false;
> >>                 }
> >>                 if (ret & VM_FAULT_ERROR) {
> >>                         trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> >
> > And I think "swapped_in++" needs to be moved after error handling.
>
> Do you mean do "swapped_in++" only after pages are swapped in successfully?

Yes.

>
> Thanks!
>
> >
> >> --
> >> 2.23.0
> >>
> >>
> > .
> >
>
