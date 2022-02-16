Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931C84B7CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245634AbiBPBrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:47:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245628AbiBPBri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:47:38 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310522BB17
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:47:26 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id h7-20020a17090a648700b001b927560c2bso1043467pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nlq8z2arOhNkxaYYwLaD3RpZ3GoR+UWwTLLnfnZTXnY=;
        b=DMFJ896b0Vz97kUGCM8E2K0r8djjVIJRIYsuIAYOAkaBkfNx2QQREloFJCf8CCj90h
         nKbD8u01PBQSSUY4vqTZ47YDWw/7PCDnAZR43J2UUhOWiepjRATef/AE87HO4hR7J2nz
         GU11Ftko5mrJ93140D/KkqH3K/LZp7UXoU/O7KYuYnti1rfi+dGGasqbL8Ese5rf7bo9
         0zlx0b2y45jW/cov0X+AFCz60VpwmqGu+eu6OeJ6DLRZRoZejU+362F7o9KjYYX+BWaK
         Z6uEVIvEuOOUm7Sj5OgLhqGQtk5FGMlS5mNoa//ff5PaLIM4owD5EtniIIHFb0scDZ9e
         EWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlq8z2arOhNkxaYYwLaD3RpZ3GoR+UWwTLLnfnZTXnY=;
        b=UDLzxXlV8lJoEg7UoPJ0BHI/k5bhW41hzGDxUMaQ3RKMKKUcMDInpmaG1wePgUbzTD
         5r2FW0dKUV6oYvHcYw+JNu7SUfEzzIJVIG3368rNtk8fXtFIypUGJRY/8lch7e8UrjOE
         pbVOwJJvgKkB1szN4XbrEpK+WuTrMqIL7Vo+0BPmO96vVLrzKQMZ1vNZRSg1a4kxLjmP
         NqyjLDn2osIzlLhiBnkKZH6TUoFsiDZAu5HgBIajNLWP/l/2XL7q32xAfdRwqvzPzxCA
         9CF/6Jvyb4/yWgkuDIW2UECDJab/UbPfI6sd3wnrI3RjTZc2j3tb3M3EHbA8xO1h7/v0
         6okw==
X-Gm-Message-State: AOAM531uBzsMasQjFiseP6lS7CcX71DtM03pbSM1JURSImJ8K0/5zxPB
        hOfdiG8/nt9hTVCzc+a1q17ADe8KTZw7OZ+iJrQPp//XXok=
X-Google-Smtp-Source: ABdhPJwT3hvSagc3TEPzllcZbvtit0z9Qok37GmkfTUSfHMWGioDKT1cQ4/685zOQu/6xCOe6mcuODN03F7rGWAFZWg=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr636363pll.132.1644976045685; Tue, 15
 Feb 2022 17:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com> <20220127124058.1172422-8-ruansy.fnst@fujitsu.com>
In-Reply-To: <20220127124058.1172422-8-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Feb 2022 17:47:19 -0800
Message-ID: <CAPcyv4i_mGFO4z3sVYShhhvBO_WASee-EfZK0U+qWw5usDWzxQ@mail.gmail.com>
Subject: Re: [PATCH v10 7/9] mm: Introduce mf_dax_kill_procs() for fsdax case
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 4:41 AM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>
> This function is called at the end of RMAP routine, i.e. filesystem
> recovery function, to collect and kill processes using a shared page of
> DAX file.  The difference with mf_generic_kill_procs() is, it accepts
> file's (mapping,offset) instead of struct page because different files'
> mappings and offsets may share the same page in fsdax mode.
> It will be called when filesystem's RMAP results are found.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  include/linux/mm.h  |  4 ++
>  mm/memory-failure.c | 91 +++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 84 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9b1d56c5c224..0420189e4788 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3195,6 +3195,10 @@ enum mf_flags {
>         MF_SOFT_OFFLINE = 1 << 3,
>         MF_UNPOISON = 1 << 4,
>  };
> +#if IS_ENABLED(CONFIG_FS_DAX)
> +int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
> +                     unsigned long count, int mf_flags);
> +#endif /* CONFIG_FS_DAX */
>  extern int memory_failure(unsigned long pfn, int flags);
>  extern void memory_failure_queue(unsigned long pfn, int flags);
>  extern void memory_failure_queue_kick(int cpu);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index b2d13eba1071..8d123cc4102e 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -304,10 +304,9 @@ void shake_page(struct page *p)
>  }
>  EXPORT_SYMBOL_GPL(shake_page);
>
> -static unsigned long dev_pagemap_mapping_shift(struct page *page,
> -               struct vm_area_struct *vma)
> +static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
> +               unsigned long address)
>  {
> -       unsigned long address = vma_address(page, vma);
>         unsigned long ret = 0;
>         pgd_t *pgd;
>         p4d_t *p4d;
> @@ -347,9 +346,8 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
>   * Schedule a process for later kill.
>   * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
>   */
> -static void add_to_kill(struct task_struct *tsk, struct page *p,
> -                      struct vm_area_struct *vma,
> -                      struct list_head *to_kill)
> +static void add_to_kill(struct task_struct *tsk, struct page *p, pgoff_t pgoff,
> +                       struct vm_area_struct *vma, struct list_head *to_kill)
>  {
>         struct to_kill *tk;
>
> @@ -360,9 +358,15 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>         }
>
>         tk->addr = page_address_in_vma(p, vma);
> -       if (is_zone_device_page(p))
> -               tk->size_shift = dev_pagemap_mapping_shift(p, vma);
> -       else
> +       if (is_zone_device_page(p)) {
> +               /*
> +                * Since page->mapping is not used for fsdax, we need
> +                * calculate the address based on the vma.
> +                */
> +               if (p->pgmap->type == MEMORY_DEVICE_FS_DAX)
> +                       tk->addr = vma_pgoff_address(vma, pgoff);
> +               tk->size_shift = dev_pagemap_mapping_shift(vma, tk->addr);
> +       } else
>                 tk->size_shift = page_shift(compound_head(p));
>
>         /*
> @@ -510,7 +514,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
>                         if (!page_mapped_in_vma(page, vma))
>                                 continue;
>                         if (vma->vm_mm == t->mm)
> -                               add_to_kill(t, page, vma, to_kill);
> +                               add_to_kill(t, page, 0, vma, to_kill);

Why is the @pgoff argument 0? @pgoff is available. Not that I expect
dax pages will ever be anonymous, might as well not leave that land
mine for future refactoring.

Other than that you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
