Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E614A836B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350353AbiBCMAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiBCMAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:00:07 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E64C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 04:00:07 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id r8so4850334uaj.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 04:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WadOTv4fHD97vmRjgv+dPh0onajRQzxP4bZOYDKu81U=;
        b=jGNpQiapVrDLV2n99CgnSbZHZLbQI+3QZntc8nXorg1ZCMJHXzZ094DZYOciZDDdgU
         zQKyxkSrWJi4aTReB8HO8pMpGpT4ehnMD8eT7EkIN7v7C31qE4vqebthlxj3Hu3kNcAY
         xd/hj5Mu54sArNmb5DxZ4w0f0XXYPuqsOD3sgdu6Y1rbHZ8XIemR+7E3JNUVWiyxzuIA
         NUQoR2Kp701TNkbI9/X4cOg9w/ZaEmo/8umouCQkXt8bX+459o4qFmPC5wy1/nmhiFEt
         CiG4MYFpQFT0VIaWOFF6oEBDuXL0TjDNPve7MY1ixb8YPNh706B7+PU36YNJgmuaWCJL
         PxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WadOTv4fHD97vmRjgv+dPh0onajRQzxP4bZOYDKu81U=;
        b=2aKC7xfjNZWSVVa0eJ3EZBjt9GWaEsQrJufVZiWlAS6StryQlvhA/pdGcKEtYzCBKJ
         I2pLQ9pF0GCJxO71+qxu0ytShGqRnY5+PNk2G2STfmcVBB124Qc1VJAHjSep90sTTHAG
         VC6Dyua7WoXIzT9JmAMEuKDBM6BBGFnJN1HU/WLkOXe2diTjmDpL7dZHNl/fxOt6KlqT
         8cbiLregop2u/dFs9bUY9Gep0fyQd8hfPu/OcJe6Odtkf6AGTh9jh7xQGlXgM/fIG4LC
         0BQ9nDvxtCPdjDKQF05FjJDTgt6TIGVV2zrBaXjGNoGcxcLwuD9uZRszwJbF9zni5u4r
         hsDw==
X-Gm-Message-State: AOAM530Da9PYDbjurjQY5p2/RUzpOFkwnqzfFG55/Q6/CEYyzxhER9Jb
        Y7iZirjcRH3HdoBzSJgkD4lqD9f0PZuzcSkOxnKCNZwiOpI=
X-Google-Smtp-Source: ABdhPJz4E7U8ZVySsxa2gqBXDIJGQIBwyT7Lr6pkjggNJbLInIIWkKQlgfxQP8Jw8BG7LPr0DBHqYE73+qyobJnmaXk=
X-Received: by 2002:a67:b00e:: with SMTP id z14mr13142826vse.57.1643889606736;
 Thu, 03 Feb 2022 04:00:06 -0800 (PST)
MIME-Version: 1.0
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com> <20220202024137.2516438-16-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-16-Liam.Howlett@oracle.com>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Thu, 3 Feb 2022 11:59:54 +0000
Message-ID: <CANe_+Ui4tud5pnBx81qG-4V-pgO5XQX-rc9rXQWMCi6qqY5bew@mail.gmail.com>
Subject: Re: [PATCH v5 15/70] kernel/fork: Use maple tree for dup_mmap()
 during forking
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2022 at 03:23, Liam Howlett <liam.howlett@oracle.com> wrote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> The maple tree was already tracking VMAs in this function by an earlier
> commit, but the rbtree iterator was being used to iterate the list.
> Change the iterator to use a maple tree native iterator and switch to
> the maple tree advanced API to avoid multiple walks of the tree during
> insert operations.  Unexport the now-unused vma_store() function.
>
> We track whether we need to free the VMAs and tree nodes through RCU
> (ie whether there have been multiple threads that can see the mm_struct
> simultaneously; by pthread(), ptrace() or looking at /proc/$pid/maps).
> This setting is sticky because it's too tricky to decide when it's safe
> to exit RCU mode.
>
> For performance reasons we bulk allocate the maple tree nodes.  The node
> calculations are done internally to the tree and use the VMA count and
> assume the worst-case node requirements.  The VM_DONT_COPY flag does
> not allow for the most efficient copy method of the tree and so a bulk
> loading algorithm is used.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/mm.h       |  2 --
>  include/linux/sched/mm.h | 13 +++++++++++++
>  kernel/fork.c            | 35 +++++++++++++++++++++++++++++------
>  3 files changed, 42 insertions(+), 8 deletions(-)
....
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 51a7971651ef..8ea683fcefcd 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -377,6 +377,16 @@ void vm_area_free(struct vm_area_struct *vma)
>         kmem_cache_free(vm_area_cachep, vma);
>  }
>
> +void mm_set_in_rcu(struct mm_struct *mm)
> +{
> +       if (!mt_in_rcu(&mm->mm_mt))
> +               return;
> +       mmap_write_lock(mm);
> +       mm->mm_mt.ma_flags |= MT_FLAGS_USE_RCU;
> +       mmap_write_unlock(mm);
> +}
> +EXPORT_SYMBOL(mm_set_in_rcu);

The mt_in_rcu() test looks wrong (inverted).
mt_in_rcu() returns true only when MT_FLAGS_USE_RCU is set, so this
flag will never set here.
All callers of mm_set_in_rcu() check mt_in_rcu() so the test here
could be removed.

Cheers,
Mark
