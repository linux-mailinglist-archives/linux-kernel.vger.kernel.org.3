Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC05F4D392F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbiCIStn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbiCIStg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:49:36 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE99A1A39F0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 10:48:35 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so3102774pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvs4wUkEI3AtSweELbG0/fXXinq75WyLekwDxmjo0Pc=;
        b=YlzjEPe1xEmK+sY/CImJXAlfj9ZDiWWMlWq/1+rmGwLnPSArxZVHBK74+hSNPw7JIw
         yj2X8+VH0+WOt3SSXKiIVHVvKY7AaM6uDCBII9/qOl1vIP8SONFtgN0kx1abVQAIf1Rp
         OVa7e+k9y4s6Kyk0dc3larGnr8KxDnThJvACaTM2HnhzIKtMjljD0HWjLh1eDYAhBhca
         pohsGzEjrouJgnSjrPPT6wwOOqyphzaNYcZc7FzFJsBGOIvo+hbBEyMs+YFvPsoBIj9g
         iZpCJNblczziVOJjA67euin7YRsHsZjTP0eLZQRKJ5ni0/8vGTgiC7RlMDof+sFZp31i
         1AiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvs4wUkEI3AtSweELbG0/fXXinq75WyLekwDxmjo0Pc=;
        b=BlN+gk+29USrBuGX/9wnac3RDCRQdBfZL6xxjBLWa0ANwoFZ4zz8JlINjOVPL99qPf
         n4YHFAskS5+LztEU28zhwhLAEYhs8JfPSReYl3868s7EDFEAIKru02bNPGa+Cbw0V5MD
         2rH+MaFPpvqFHPV2t/0vpPtkipZXJG1Pnv57bDJc9QeH+PGzWLYdd/984HZMp4EaOiBr
         Ta704pmzwDquRytIS63SHAqlT4JUw8N8BsP59NMr/25q6bCS4Bo5t0A42liYAxBAusxL
         aWbs6TVukrQE9KWE4GgqiHsB2T/ncy+GChglonw5G/SXahPm9MBfPSLrayl5b4YTIz/r
         m/DQ==
X-Gm-Message-State: AOAM531XmjLRyIUtufb6rPuOUSRPf5TmqqU/lyhNmlsIAB3RvnSY2bT/
        hSyf8hM0cm/hXmliTLtuWSLMmzEtvBeEQ3UdFxc=
X-Google-Smtp-Source: ABdhPJwLizqpQx/dAQGBodHku7mkZHsuWBpMHCTfVyID0S6V6MXHIR++YHIHgjK1Wb/aVVol1fHbcw3tIJL86iV+msg=
X-Received: by 2002:a17:903:124a:b0:151:99fe:1a10 with SMTP id
 u10-20020a170903124a00b0015199fe1a10mr847964plh.87.1646851715266; Wed, 09 Mar
 2022 10:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20220131162940.210846-1-david@redhat.com> <20220131162940.210846-4-david@redhat.com>
In-Reply-To: <20220131162940.210846-4-david@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 9 Mar 2022 10:48:23 -0800
Message-ID: <CAHbLzkpoNeSPyzGV9arXK7BrVWpERy0yGRggn1ZaRam8RrHyRQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] mm: slightly clarify KSM logic in do_swap_page()
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 8:33 AM David Hildenbrand <david@redhat.com> wrote:
>
> Let's make it clearer that KSM might only have to copy a page
> in case we have a page in the swapcache, not if we allocated a fresh
> page and bypassed the swapcache. While at it, add a comment why this is
> usually necessary and merge the two swapcache conditions.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 923165b4c27e..3c91294cca98 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3615,21 +3615,29 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 goto out_release;
>         }
>
> -       /*
> -        * Make sure try_to_free_swap or reuse_swap_page or swapoff did not

We could remove the reference to "reuse_swap_page", right?

> -        * release the swapcache from under us.  The page pin, and pte_same
> -        * test below, are not enough to exclude that.  Even if it is still
> -        * swapcache, we need to check that the page's swap has not changed.
> -        */
> -       if (unlikely((!PageSwapCache(page) ||
> -                       page_private(page) != entry.val)) && swapcache)
> -               goto out_page;
> -
> -       page = ksm_might_need_to_copy(page, vma, vmf->address);
> -       if (unlikely(!page)) {
> -               ret = VM_FAULT_OOM;
> -               page = swapcache;
> -               goto out_page;
> +       if (swapcache) {
> +               /*
> +                * Make sure try_to_free_swap or reuse_swap_page or swapoff did
> +                * not release the swapcache from under us.  The page pin, and
> +                * pte_same test below, are not enough to exclude that.  Even if
> +                * it is still swapcache, we need to check that the page's swap
> +                * has not changed.
> +                */
> +               if (unlikely(!PageSwapCache(page) ||
> +                            page_private(page) != entry.val))
> +                       goto out_page;
> +
> +               /*
> +                * KSM sometimes has to copy on read faults, for example, if
> +                * page->index of !PageKSM() pages would be nonlinear inside the
> +                * anon VMA -- PageKSM() is lost on actual swapout.
> +                */
> +               page = ksm_might_need_to_copy(page, vma, vmf->address);
> +               if (unlikely(!page)) {
> +                       ret = VM_FAULT_OOM;
> +                       page = swapcache;
> +                       goto out_page;
> +               }
>         }
>
>         cgroup_throttle_swaprate(page, GFP_KERNEL);
> --
> 2.34.1
>
