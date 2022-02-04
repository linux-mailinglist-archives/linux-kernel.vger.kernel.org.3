Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E494A9F4D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377634AbiBDSgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377774AbiBDSgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:36:11 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27785C061749
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 10:36:11 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so6870594pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 10:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BcwpZRvksgICTx1+iO/egqqt+NXlQX0ke28GNdK6Yhs=;
        b=ZDDjrIRGaY9tCU9x5Hpo/VjyRKggTMeszzaUtriyuO9c5JxesdSNU6iwBTilN7ys/O
         a16l8CQ02GNY1tiDqpe82kuzvqHV6ftE4TK/bnuE6ueUPxNJ5OkDoZgAqOqP4fvThqsQ
         ioEYAQdu/4dplRlhCtX1z739wgPg6wz5HYzE/3/AGut2M4b7fjmgavl18x4S8j2UtB/1
         bINTBK7KmC6G+iL2E58cEEqYO72gd+cMYfiaN0xf2o/TJEKxl5LAzPykfG7isdbCFzGk
         3rU0Ps+obzTk3KaFVmB1rJ64xGuWrryX37moTeo27RZmM5FMw9VP+8/kjgcNngqUmprQ
         Zi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BcwpZRvksgICTx1+iO/egqqt+NXlQX0ke28GNdK6Yhs=;
        b=uzQSPt1XiUfzpU8owUc6afjIsz7CYk2zg6GmIc8iHgYmIFwVt+ZRZ7ZDLDuFQpoYz+
         C1/8rvQTjV84pUr1MrVjmac4s2obpUV2HVslrw1G5B23DwRZk9I5HkQ2w4yxq+NQFfzL
         AaO0dRCUHe3B8rqRHVR8816QHuuj3Kmu1Ykcu/ICsVoq2b6RmTSuJHSRd3QB0YHpKyNs
         qXh7A+n5hLVp30ZfzOA0yYxkWLnRjtS2vhOLOgCi2FQ3Wb1P6D4Qtoibf1RIXu/xDd4X
         Pn14zHJjidy+l8ZlyxWOvRluDRyevW5j+qoFU0oDcT/npqCq8+5L5Em9btbacYU8NT8Z
         XzFw==
X-Gm-Message-State: AOAM533iRXyUeyvJDhgxJZCrulOgzslqh5guUREn4+hze3M20AfcNNBN
        pjfopzQxsC998qTOKYQ1nQkCwxXTFgbbr1NqtyTVcP0D0NmlBw==
X-Google-Smtp-Source: ABdhPJzutWjHSYuX4RQzmzkKj/rWcWycTpNewSib0DfMN5FrH9UiynQr2LiqNCbRR6QBchNy8a/UpIVJAJhEt/04nb0=
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr4345895plr.132.1643999770584;
 Fri, 04 Feb 2022 10:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-39-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-39-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 10:35:59 -0800
Message-ID: <CAPcyv4iYOGD2XpmO3RH+wViuXx8EYrq-BK7vuKv6we+KR60YCg@mail.gmail.com>
Subject: Re: [PATCH V8 38/44] memremap_pages: Define pgmap_mk_{readwrite|noaccess}()
 calls
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Users will need a way to flag valid access to pages which have been
> protected with PGMAP protections.  Provide this by defining pgmap_mk_*()
> accessor functions.

I find the ambiguous use of "Users" not helpful to set the context. How about:

A thread that wants to access memory protected by PGMAP protections
must first enable access, and then disable access when it is done.

>
> pgmap_mk_{readwrite|noaccess}() take a struct page for convenience.
> They determine if the page is protected by dev_pagemap protections.  If
> so, they perform the requested operation.
>
> In addition, the lower level __pgmap_* functions are exported.  They
> take the dev_pagemap object directly for internal users who have
> knowledge of the of the dev_pagemap.
>
> All changes in the protections must be through the above calls.  They
> abstract the protection implementation (currently the PKS api) from the
> upper layer users.
>
> Furthermore, the calls are nestable by the use of a per task reference
> count.  This ensures that the first call to re-enable protection does
> not 'break' the last access of the device memory.
>
> Access to device memory during exceptions (#PF) is expected only from
> user faults.  Therefore there is no need to maintain the reference count
> when entering or exiting exceptions.  However, reference counting will
> occur during the exception.  Recall that protection is automatically
> enabled during exceptions by the PKS core.[1]
>
> NOTE: It is not anticipated that any code paths will directly nest these
> calls.  For this reason multiple reviewers, including Dan and Thomas,
> asked why this reference counting was needed at this level rather than
> in a higher level call such as kmap_{atomic,local_page}().  The reason
> is that pgmap_mk_readwrite() could nest with regards to other callers of
> pgmap_mk_*() such as kmap_{atomic,local_page}().  Therefore push this
> reference counting to the lower level and just ensure that these calls
> are nestable.

I still don't think that explains why task struct has a role to play
here, see below.

Another missing bit of clarification, maybe I missed it, is why are
the protections toggled between read-write and noaccess. For
stray-write protection toggling between read-write and read-only is
sufficient. I can imagine speculative execution and debug rationales
for noaccess, but those should be called out explicitly.

>
> [1] https://lore.kernel.org/lkml/20210401225833.566238-9-ira.weiny@intel.com/
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes for V8
>         Split these functions into their own patch.
>                 This helps to clarify the commit message and usage.
> ---
>  include/linux/mm.h    | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/sched.h |  7 +++++++
>  init/init_task.c      |  3 +++
>  mm/memremap.c         | 14 ++++++++++++++
>  4 files changed, 58 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6e4a2758e3d3..60044de77c54 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1162,10 +1162,44 @@ static inline bool devmap_protected(struct page *page)
>         return false;
>  }
>
> +void __pgmap_mk_readwrite(struct dev_pagemap *pgmap);
> +void __pgmap_mk_noaccess(struct dev_pagemap *pgmap);
> +
> +static inline bool pgmap_check_pgmap_prot(struct page *page)
> +{
> +       if (!devmap_protected(page))
> +               return false;
> +
> +       /*
> +        * There is no known use case to change permissions in an irq for pgmap
> +        * pages
> +        */
> +       lockdep_assert_in_irq();
> +       return true;
> +}
> +
> +static inline void pgmap_mk_readwrite(struct page *page)
> +{
> +       if (!pgmap_check_pgmap_prot(page))
> +               return;
> +       __pgmap_mk_readwrite(page->pgmap);
> +}
> +static inline void pgmap_mk_noaccess(struct page *page)
> +{
> +       if (!pgmap_check_pgmap_prot(page))
> +               return;
> +       __pgmap_mk_noaccess(page->pgmap);
> +}
> +
>  bool pgmap_protection_available(void);
>
>  #else
>
> +static inline void __pgmap_mk_readwrite(struct dev_pagemap *pgmap) { }
> +static inline void __pgmap_mk_noaccess(struct dev_pagemap *pgmap) { }
> +static inline void pgmap_mk_readwrite(struct page *page) { }
> +static inline void pgmap_mk_noaccess(struct page *page) { }
> +
>  static inline bool pgmap_protection_available(void)
>  {
>         return false;
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f5b2be39a78c..5020ed7e67b7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1492,6 +1492,13 @@ struct task_struct {
>         struct callback_head            l1d_flush_kill;
>  #endif
>
> +#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
> +       /*
> +        * NOTE: pgmap_prot_count is modified within a single thread of
> +        * execution.  So it does not need to be atomic_t.
> +        */
> +       u32                             pgmap_prot_count;
> +#endif

It's not at all clear why the task struct needs to be burdened with
this accounting. Given that a devmap instance is needed to manage page
protections, why not move the nested protection tracking to a percpu
variable relative to an @pgmap arg? Something like:

void __pgmap_mk_readwrite(struct dev_pagemap *pgmap)
{
       migrate_disable();
       preempt_disable();
       if (this_cpu_add_return(pgmap->pgmap_prot_count, 1) == 1)
               pks_mk_readwrite(PKS_KEY_PGMAP_PROTECTION);
}
EXPORT_SYMBOL_GPL(__pgmap_mk_readwrite);

void __pgmap_mk_noaccess(struct dev_pagemap *pgmap)
{
       if (!this_cpu_sub_return(pgmap->pgmap_prot_count, 1))
               pks_mk_noaccess(PKS_KEY_PGMAP_PROTECTION);
       preempt_enable();
       migrate_enable();
}
EXPORT_SYMBOL_GPL(__pgmap_mk_noaccess);

The naming, which I had a hand in, is not aging well. When I see "mk"
I expect it to be building some value like a page table entry that
will be installed later. These helpers are directly enabling and
disabling access and are meant to be called symmetrically. So I would
expect symmetric names like:

pgmap_enable_access()
pgmap_disable_access()


>         /*
>          * New fields for task_struct should be added above here, so that
>          * they are included in the randomized portion of task_struct.
> diff --git a/init/init_task.c b/init/init_task.c
> index 73cc8f03511a..948b32cf8139 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -209,6 +209,9 @@ struct task_struct init_task
>  #ifdef CONFIG_SECCOMP_FILTER
>         .seccomp        = { .filter_count = ATOMIC_INIT(0) },
>  #endif
> +#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
> +       .pgmap_prot_count = 0,
> +#endif
>  };
>  EXPORT_SYMBOL(init_task);
>
> diff --git a/mm/memremap.c b/mm/memremap.c
> index d3e6f328a711..b75c4f778c59 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -96,6 +96,20 @@ static void devmap_protection_disable(void)
>         static_branch_dec(&dev_pgmap_protection_static_key);
>  }
>
> +void __pgmap_mk_readwrite(struct dev_pagemap *pgmap)
> +{
> +       if (!current->pgmap_prot_count++)
> +               pks_mk_readwrite(PKS_KEY_PGMAP_PROTECTION);
> +}
> +EXPORT_SYMBOL_GPL(__pgmap_mk_readwrite);
> +
> +void __pgmap_mk_noaccess(struct dev_pagemap *pgmap)
> +{
> +       if (!--current->pgmap_prot_count)
> +               pks_mk_noaccess(PKS_KEY_PGMAP_PROTECTION);
> +}
> +EXPORT_SYMBOL_GPL(__pgmap_mk_noaccess);
> +
>  bool pgmap_protection_available(void)
>  {
>         return pks_available();
> --
> 2.31.1
>
