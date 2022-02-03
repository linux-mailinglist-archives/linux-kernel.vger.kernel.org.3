Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448FF4A8392
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiBCMIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiBCMIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:08:38 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C91C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 04:08:38 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id b16so4776815uaq.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 04:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+xYUiL1/dI8fAOExcqcrQPfM5bBJBMlqGF1dPN8Xu7M=;
        b=eQspLdFmo5bLzpsBd7r1CYb2D4Q9sL2/j664dwJwUYpjvTA//39tbXI1vT8fF6NXOC
         KMWbSUqEahpnuupz+auUcbjQBFz8D+szV7X0VKfCH+NmMVkIPvpLkKNjJpA/eEl4y4Km
         S9yyRwX2cvgPPd/1ErQ29GhzIXyLdahed72rnXv0G6S9Kwp5KZx3qp13Ixm5fLveVEJd
         y0H/j8HzYld8eGOKAsI7Tx5MpxczyuG69p7El8JkfeXVHXciuJM7N5WqVZbuSvw6G6be
         0G3ZwCun7OmdTkoLM4OnyScjnW+R62w3t09ZxRma30mJYrFwiNEEwbYwtiD2IMEKOxdK
         mCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xYUiL1/dI8fAOExcqcrQPfM5bBJBMlqGF1dPN8Xu7M=;
        b=ZhfCl+gzquurJwYsrm9nTqfaH6/HonQU/KpDbGUY55kBwqJ9vJv9NJngmkkSozD6EW
         GG9DAiXA9IkvNtTcqA8Rv281w6H9Bb88uQGCsjPBT2saEanLU7v/StQea1nNm33/s+uZ
         RzUl6On5EtagOxcc8KVT8K6dES+z7wIFLzGfK8SYOEykkiL7iasM9wjJCVONBjKPq9so
         crXYnj/rAzLGaw2ZmrOxSlD64ZNFGQZRQsiF4hMWM16vQhh6GJh5wAakFTuDAbNpIQUa
         GjLSWhNiukGzeRtfLoPRBR5II19n9Awb8MQ2mRWZ9pd4SUnRAOtV4Lr/OwMUX/SfHJRi
         OAdw==
X-Gm-Message-State: AOAM531oGb3po4sg6zTNBGjnR/N9PJnuu//VywneaPOk9MKBo5YYpia+
        maB6d4Nv50OeKJMz5cYbdIoeXt/T7nc+IoJfMYA=
X-Google-Smtp-Source: ABdhPJwtdfOagc6zgauDjS1hUg9bQ5nC5Fe+Sy2qhjzZy2FWSESY4+L8x3I6a3hk6zmVP6x/50ss2i7VWweJyIcxYbg=
X-Received: by 2002:a05:6130:315:: with SMTP id ay21mr16140257uab.49.1643890117561;
 Thu, 03 Feb 2022 04:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com> <20220202024137.2516438-69-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-69-Liam.Howlett@oracle.com>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Thu, 3 Feb 2022 12:08:25 +0000
Message-ID: <CANe_+UjtS5_ynjfMfHC_hkb7mAADbsL8UWG7HOwM0aN3Mjn58Q@mail.gmail.com>
Subject: Re: [PATCH v5 68/70] mm: Remove the vma linked list
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2022 at 02:43, Liam Howlett <liam.howlett@oracle.com> wrote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Replace any vm_next use with vma_find().
>
> Update free_pgtables(), unmap_vmas(), and zap_page_range() to use the
> maple tree.
>
> Use the new free_pgtables() and unmap_vmas() in do_mas_align_munmap().
> At the same time, alter the loop to be more compact.
>
> Now that free_pgtables() and unmap_vmas() take a maple tree as an
> argument, rearrange do_mas_align_munmap() to use the new tree to hold
> the vmas to remove.
>
> Remove __vma_link_list() and __vma_unlink_list() as they are exclusively
> used to update the linked list
>
> Drop linked list update from __insert_vm_struct().
>
> Rework validation of tree as it was depending on the linked list.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  include/linux/mm.h       |   5 +-
>  include/linux/mm_types.h |   4 -
>  kernel/fork.c            |  13 +-
>  mm/debug.c               |  14 +-
>  mm/gup.c                 |   2 +-
>  mm/internal.h            |  10 +-
>  mm/memory.c              |  33 ++-
>  mm/mmap.c                | 518 +++++++++++++++++----------------------
>  mm/nommu.c               |   2 -
>  mm/util.c                |  40 ---
>  10 files changed, 264 insertions(+), 377 deletions(-)
...
> -static inline int
> -unlock_range(struct vm_area_struct *start, struct vm_area_struct **tail,
> -            unsigned long limit)
> -{
> -       struct mm_struct *mm = start->vm_mm;
> -       struct vm_area_struct *tmp = start;
> -       int count = 0;
> -
> -       while (tmp && tmp->vm_start < limit) {
> -               *tail = tmp;
> -               count++;
> -               if (tmp->vm_flags & VM_LOCKED) {
> -                       mm->locked_vm -= vma_pages(tmp);
> -                       munlock_vma_pages_all(tmp);
> -               }
> -
> -               tmp = tmp->vm_next;
> -       }
> -
> -       return count;
> -}

Trivial: Comment in exit_mmap(), for oom-victim case, has a reference
to this removed function (unlock_range()).

Cheers,
Mark
