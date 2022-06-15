Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA11B54D05B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357946AbiFORtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349807AbiFORto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:49:44 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31B253C6A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:49:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m14so631406plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dxrmruEpWBNiTsmU9GR+aa+oV3xQ62ui5IIhqC69qf8=;
        b=oSwJGIdXlNb+VrbuYmZwvyElIOUy4rGhZWi9fpnNu7FdojLUivZ9i9L6uCNrU1Q2Tt
         n/umCEZoSGR98dFxtDgCa0LxlgZ9bijRCQ55rtowXl8EC3TqVq+jPeu//Cj7zgmt8m1e
         J3SzRHof8qUJZRSNPbtdyldeQgWjUx0XXXEnjZVIdFcul9WhGd5KohnAx3x6+Z9Nw085
         splTHWs/8MyWm/5nCOEX7GmRPNXJOzcAOQOvwjXvgaafaQmuGfAYoGB4b6Q4kGu2+L+H
         YO48rjoxrLwHF4FiOy+0pGcKCU2NwBtEG3nGADtL3TsIxtRHxTzqOj4A+gVQlraXs54X
         NeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxrmruEpWBNiTsmU9GR+aa+oV3xQ62ui5IIhqC69qf8=;
        b=1a9KHhE816+y6f2jgprW0ebxKlita19zXmvK+Ymk9fehB1205Fav1nyp55GIc2wEUG
         foi7EDwEEzP0dJ5eNlo67yo3F4RERXqVytAxN6KWOEOxi39zf8WI36wNXs33rk9M2MS6
         FfumnWlHui64MkQ2f4q6QJ38k+/60CNjCbdPUf695IJCpDLr4fG0Uy9yNjxapNAn27h3
         V84k/FCHL8Jk+b4X/tt21s4ipAazXgDe54F5lkpidFq80WldNw5RSXde/Wt+ejP0CYHG
         0PUcLomGnDCkYSb3OMUv3sEfIVdHADeFqQT6yiMnsd8aaw01FWfBmIAEx8zro4lD5DSJ
         I6xQ==
X-Gm-Message-State: AJIora8J9A0HBasfXi21n1QEQ7RCCff9Ry6H7MBSRKE90aTca8gHNqJg
        RVoL68UYP4jNnJHCjPFr2qUa0s3dGfPUQMcJ6bY=
X-Google-Smtp-Source: AGRyM1t2UBoLW2+ZbOanhvdwi+5bEkgN330M33Qf7uZdt3DeTPdlzbfwnL3AI5QNLUWCgXCTjJNJAHNq2KUJq5jePI4=
X-Received: by 2002:a17:90a:ce84:b0:1e4:d803:fad with SMTP id
 g4-20020a17090ace8400b001e4d8030fadmr11754466pju.99.1655315382973; Wed, 15
 Jun 2022 10:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220611084731.55155-1-linmiaohe@huawei.com> <20220611084731.55155-3-linmiaohe@huawei.com>
In-Reply-To: <20220611084731.55155-3-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Jun 2022 10:49:30 -0700
Message-ID: <CAHbLzkpc8ag7MkY_D17U1B7SjZFO2Bss8rVVj-scMOC8ttqxEg@mail.gmail.com>
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

On Sat, Jun 11, 2022 at 1:47 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> When do_swap_page returns VM_FAULT_RETRY, we do not retry here and thus
> swap entry will remain in pagetable. This will result in later failure.
> So stop swapping in pages in this case to save cpu cycles.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/khugepaged.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 73570dfffcec..a8adb2d1e9c6 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1003,19 +1003,16 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
>                 swapped_in++;
>                 ret = do_swap_page(&vmf);
>
> -               /* do_swap_page returns VM_FAULT_RETRY with released mmap_lock */
> +               /*
> +                * do_swap_page returns VM_FAULT_RETRY with released mmap_lock.
> +                * Note we treat VM_FAULT_RETRY as VM_FAULT_ERROR here because
> +                * we do not retry here and swap entry will remain in pagetable
> +                * resulting in later failure.

Yeah, it makes sense.

> +                */
>                 if (ret & VM_FAULT_RETRY) {
>                         mmap_read_lock(mm);

A further optimization, you should not need to relock mmap_lock. You
may consider returning a different value or passing in *locked and
setting it to false, then check this value in the caller to skip
unlock.

> -                       if (hugepage_vma_revalidate(mm, haddr, &vma)) {
> -                               /* vma is no longer available, don't continue to swapin */
> -                               trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> -                               return false;
> -                       }
> -                       /* check if the pmd is still valid */
> -                       if (mm_find_pmd(mm, haddr) != pmd) {
> -                               trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> -                               return false;
> -                       }
> +                       trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> +                       return false;
>                 }
>                 if (ret & VM_FAULT_ERROR) {
>                         trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);

And I think "swapped_in++" needs to be moved after error handling.

> --
> 2.23.0
>
>
