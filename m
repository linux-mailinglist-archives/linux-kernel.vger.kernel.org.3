Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E9B521256
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiEJKmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbiEJKly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F69126CC61
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F293261785
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD9DC385A6;
        Tue, 10 May 2022 10:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652179070;
        bh=gEUdySVb9quKEsnAJIwkLpqXP8oiSnANbxwM2hILG4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GEBEEkNCmOrR73vQ5zxfIGz8bK0GKyIAMRVX3VqpYmF/bqlKyJkH1NAXc2tHQJtqv
         ZjcU8nuUgpN7sauTQ9GJtN2vWlQtGvW/Pr0RiSjn3F107H+aWGgljdlsAyCuzl12U7
         sjkNcD8qzklauXhca4u3qGQXVycvd5fGRBzRzf4lH2AA8lsZ6138w+R9X5okfsR0Do
         mJtdCAnvjDi9QrRfAFZSxU4GliIOR1QimftN8ZKBLYLmVNY2kIRT8hO+/8KaZdPqWn
         lzLizagW6lzZ3cTNnB1dAIeUHNkfz7gVrWT8VSMzAjZOvrsDo6YsP4cEszhpxKxqUa
         waENBEy7uH7Gg==
From:   SeongJae Park <sj@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 08/69] mm: start tracking VMAs with maple tree
Date:   Tue, 10 May 2022 10:37:47 +0000
Message-Id: <20220510103747.151886-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504010716.661115-10-Liam.Howlett@oracle.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Wed, 4 May 2022 01:07:52 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Start tracking the VMAs with the new maple tree structure in parallel with
> the rb_tree.  Add debug and trace events for maple tree operations and
> duplicate the rb_tree that is created on forks into the maple tree.
> 
> The maple tree is added to the mm_struct including the mm_init struct,
> added support in required mm/mmap functions, added tracking in kernel/fork
> for process forking, and used to find the unmapped_area and checked
> against what the rbtree finds.
> 
> This also moves the mmap_lock() in exit_mmap() since the oom reaper call
> does walk the VMAs.  Otherwise lockdep will be unhappy if oom happens.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  arch/x86/kernel/tboot.c     |   1 +
>  drivers/firmware/efi/efi.c  |   1 +
>  include/linux/mm.h          |   2 +
>  include/linux/mm_types.h    |   3 +
>  include/trace/events/mmap.h |  73 ++++++++
>  kernel/fork.c               |  20 ++-
>  mm/init-mm.c                |   2 +
>  mm/mmap.c                   | 323 +++++++++++++++++++++++++++++++++---
>  8 files changed, 396 insertions(+), 29 deletions(-)
> 
[...]
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d7e120ad5825..e777da0132f6 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
[...]
> @@ -680,6 +744,56 @@ static void __vma_link_file(struct vm_area_struct *vma)
>  	}
>  }
>  
> +/*
> + * vma_mas_store() - Store a VMA in the maple tree.
> + * @vma: The vm_area_struct
> + * @mas: The maple state
> + *
> + * Efficient way to store a VMA in the maple tree when the @mas has already
> + * walked to the correct location.
> + *
> + * Note: the end address is inclusive in the maple tree.
> + */
> +inline void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
> +{
> +	trace_vma_store(mas->tree, vma);
> +	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
> +	mas_store_prealloc(mas, vma);
> +}
> +
> +/*
> + * vma_mas_remove() - Remove a VMA from the maple tree.
> + * @vma: The vm_area_struct
> + * @mas: The maple state
> + *
> + * Efficient way to remove a VMA from the maple tree when the @mas has already
> + * been established and points to the correct location.
> + * Note: the end address is inclusive in the maple tree.
> + */
> +static inline void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
> +{
> +	trace_vma_mas_szero(mas->tree, vma->vm_start, vma->vm_end - 1);
> +	mas->index = vma->vm_start;
> +	mas->last = vma->vm_end - 1;
> +	mas_store_prealloc(mas, NULL);
> +}

Above two functions were defined in internal.h in v8[1], but moved to mmap.c in
this version.  As mmap.c is compiled when CONFIG_MMU, build fails when the
config is not set as below:

    .../mm/nommu.c: In function 'add_vma_to_mm':
    .../mm/nommu.c:575:2: error: implicit declaration of function 'vma_mas_store'; did you mean 'mas_store'? [-Werror=implicit-function-declaration]
      575 |  vma_mas_store(vma, &mas);
          |  ^~~~~~~~~~~~~
          |  mas_store
    .../mm/nommu.c: In function 'delete_vma_from_mm':
    .../mm/nommu.c:599:2: error: implicit declaration of function 'vma_mas_remove' [-Werror=implicit-function-declaration]
      599 |  vma_mas_remove(vma, &mas);
          |  ^~~~~~~~~~~~~~

Was there a reason to move these definitions?  I confirmed moving the
definition back to internal.h fixes this issue, but I'm unsure if that's the
right solution.

[1] https://lore.kernel.org/linux-mm/20220426150616.3937571-10-Liam.Howlett@oracle.com/


Thanks,
SJ

[...]
