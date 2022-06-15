Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC1754D063
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358016AbiFORve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242299AbiFORvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:51:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073DC544C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:51:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m14so635047plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kpn2Q2CsireSptzmUqdySxnWjnGpd3Q3NSEkQU1AXEY=;
        b=I4NZ826O2XxVNyXyxHS8+3OKpnYH2JJkLmwygLtw+BpcvgRcGWVOAtNSgP57L8I75l
         v+N7dKJcZFX0jjwzdnu5SRk6q1mAJlegmNuAR3QCtZAeCFRSLxfDP/g9T/aEH7QCaCg1
         pDy/Jnel+l4y6YXdRuoply+AI7cSElKHUpFTbUdpbNCghczWG7WTLPOLVrWOEXDWLM6+
         uXQJ1iJj+Gsf0As3WrV0UcEBjvQjWmyjEvid8c+tb40fUpdpsRlqhdeBEhyDuGSXHZ+3
         raV/Vl2R0x+XqGXVwDnucEbgR6m/OeK3oTZsXZ4FqQBPCiAl5ARzP+wHhEh+tMl0uYoU
         HujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kpn2Q2CsireSptzmUqdySxnWjnGpd3Q3NSEkQU1AXEY=;
        b=d4rNmwRJWebq5HfZEB6JzYxub5ZvNilFna7ma7NijCx4pXfcnGPf4DVLxaDrbeGDG/
         lGpbUhLEOQgG3hPWNWwYotmolzIA4qMOBuLIiP3/Tto/Sk/tF1t/Vm8gMEBpvparBqtO
         WCvspk/f38/iVVeGOGet4FyP06vgNQ+pOKyUVGgGRh3rNRyEqlK0HLQ0xy5Ya0/2Ft9B
         93+2QsrQuKDiWECLeeQRqa1VQVaI90Tk1MlIs9UJydvBcyZXnpg9qyyNJFS0bFsLOC0A
         /X17XrGe9TXF6fKxoVy09ZDVCJf1/faQaiBBmilMxZXM9qLxML8/zXqVHBsuXHYEKfIN
         b9vw==
X-Gm-Message-State: AJIora8cGrTxwbAyQyIzvYlSb4hvKER03CJ7Z7cFcBeQl1RkiwhVG4ZJ
        ymX51wKP8BIqDBgizeX9OWXmxxjm2gJtGcP6CaQ=
X-Google-Smtp-Source: AGRyM1s0onkd6H8EYWbqxfVIEQT4LwQoCoEnVoCVKtR+7/Xt45XQLNumd6t8f36YPumjGqvoiYv1no3bLjyDG11ZC/c=
X-Received: by 2002:a17:903:32c4:b0:167:6e6f:204b with SMTP id
 i4-20020a17090332c400b001676e6f204bmr682333plr.117.1655315489159; Wed, 15 Jun
 2022 10:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220611084731.55155-1-linmiaohe@huawei.com> <20220611084731.55155-3-linmiaohe@huawei.com>
 <Yqn3WLLy+5MnqZn3@google.com>
In-Reply-To: <Yqn3WLLy+5MnqZn3@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Jun 2022 10:51:17 -0700
Message-ID: <CAHbLzkrJJJHS-4MKPSdRsSjUwU-=q4y7xJfUx_ZRTohc034J_w@mail.gmail.com>
Subject: Re: [PATCH 2/7] mm/khugepaged: stop swapping in page when
 VM_FAULT_RETRY occurs
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Jun 15, 2022 at 8:14 AM Zach O'Keefe <zokeefe@google.com> wrote:
>
> On 11 Jun 16:47, Miaohe Lin wrote:
> > When do_swap_page returns VM_FAULT_RETRY, we do not retry here and thus
> > swap entry will remain in pagetable. This will result in later failure.
> > So stop swapping in pages in this case to save cpu cycles.
> >
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >  mm/khugepaged.c | 19 ++++++++-----------
> >  1 file changed, 8 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 73570dfffcec..a8adb2d1e9c6 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1003,19 +1003,16 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
> >               swapped_in++;
> >               ret = do_swap_page(&vmf);
> >
> > -             /* do_swap_page returns VM_FAULT_RETRY with released mmap_lock */
> > +             /*
> > +              * do_swap_page returns VM_FAULT_RETRY with released mmap_lock.
> > +              * Note we treat VM_FAULT_RETRY as VM_FAULT_ERROR here because
> > +              * we do not retry here and swap entry will remain in pagetable
> > +              * resulting in later failure.
> > +              */
> >               if (ret & VM_FAULT_RETRY) {
> >                       mmap_read_lock(mm);
> > -                     if (hugepage_vma_revalidate(mm, haddr, &vma)) {
> > -                             /* vma is no longer available, don't continue to swapin */
> > -                             trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> > -                             return false;
> > -                     }
> > -                     /* check if the pmd is still valid */
> > -                     if (mm_find_pmd(mm, haddr) != pmd) {
> > -                             trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> > -                             return false;
> > -                     }
> > +                     trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> > +                     return false;
> >               }
> >               if (ret & VM_FAULT_ERROR) {
> >                       trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> > --
> > 2.23.0
> >
> >
>
> I've convinced myself this is correct, but don't understand how we got here.
> AFAICT, we've always continued to fault in pages, and, as you mention, don't
> retry ones that have failed with VM_FAULT_RETRY - so
> __collapse_huge_page_isolate() should fail. I don't think (?) there is any
> benefit to continuing to swap if we don't handle VM_FAULT_RETRY appropriately.
>
> So, I think this change looks good from that perspective. I suppose the only
> other question would be: should we handle the VM_FAULT_RETRY case? Maybe 1
> additional attempt then fail? AFAIK, this mostly (?) happens when the page is
> locked.  Maybe it's not worth the extra complexity though..

It should be unnecessary for khugepaged IMHO since it will scan all
the valid mm periodically, so it will come back eventually.

>
