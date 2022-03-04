Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808504CDF33
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiCDUbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiCDUbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:31:33 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6931E482C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:30:43 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id h126so19172273ybc.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 12:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ketSkMCmDgphN6eJBfFEUz8Zxz1RJ3nAz1fm2gHdOIE=;
        b=aVp3F1SSGchsfdDXiebOzEgvgrssbOuvCyDTC/y9ZWZHua/1tx7G6uj7i95CITCt7c
         lDv1WWtpRWNGXbPddt6Kjnfl63WAKRLr7Jmv7A55TdkAl+vEggYUYTqzk9YyTMerxlfy
         IjqdbZY9znsNfURoi0XEpLdSN4xcDrV3z5NkuCYmaSzCxTjvQuiCCkI/SWvAcMbx75IM
         2HM3GAp7DQQeJypG2Cq088zHsSuyvqjQaoMPzYQP1DOjgueq6V7RbumTn+jZafIQ4RY8
         iZUecxy25vvx8clrXmXvD8FsncKV749SjUW7wqBAq9NvrwYQfe3UnySfERM4O9V6ea1s
         tq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ketSkMCmDgphN6eJBfFEUz8Zxz1RJ3nAz1fm2gHdOIE=;
        b=6Icff+9nu1SzjafFRbUCT+qu63rsD4cDDTtHUGtEy4fgdghPx9TV+2kQzZptqt9zTJ
         gg7+b3Hd731LxTAc8NZC+rly31TWfGgZny22NR1BElihN3E8lWSJsO+HgP56rvjcdvJu
         TiAmM9RsJ00oziRC58jHOjFjVIWv8QgiVBFz2Dc5OkTeDkKKabFUMybi0yvY1G8ZNeyq
         BWnVqXqIfp/KapXLtdlnkxnHd+SGPxGk8JxWBIdIHj5pUJTMM7Jm1JAi5+tnfT9mUDjp
         EL4jBNBTrDM4BOLH+rd5X+RLIWTDVF+95ghNvS2SE3D1ujEZyxF/PleKAcpOQUwrvrkM
         dqKw==
X-Gm-Message-State: AOAM5311iiUMOr1JR/Gg7Y+LXZ0FxAtcCLa66XNagUQZYwXzvfjIL4ej
        Czuu3hHnaPGY2CecuagcFIAqOsHvMVYPVLdat2EOaQ==
X-Google-Smtp-Source: ABdhPJxIUW1iojA/De28P636oj862zICxsKZSvLpVQO0Np7mvaK7NcdO8Wp6fG5wWHFTU0IpadQMSYmcjGS/1XJLXXo=
X-Received: by 2002:a25:8c8b:0:b0:627:f4a2:5a47 with SMTP id
 m11-20020a258c8b000000b00627f4a25a47mr184713ybl.543.1646425842648; Fri, 04
 Mar 2022 12:30:42 -0800 (PST)
MIME-Version: 1.0
References: <1644572051-24091-1-git-send-email-quic_charante@quicinc.com>
In-Reply-To: <1644572051-24091-1-git-send-email-quic_charante@quicinc.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 4 Mar 2022 12:30:31 -0800
Message-ID: <CAJuCfpGAaqZv68q-jrBuFArq+6wKBsNys+b=eaBr+03KZf-EHA@mail.gmail.com>
Subject: Re: [PATCH v4] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, markhemm@googlemail.com,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charan,
Couple nits inline.

On Fri, Feb 11, 2022 at 1:34 AM Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> Currently fadvise(2) is supported only for the files that doesn't
> associated with noop_backing_dev_info thus for the files, like shmem,
> fadvise results into NOP. But then there is file_operations->fadvise()
> that lets the file systems to implement their own fadvise
> implementation. Use this support to implement some of the POSIX_FADV_XXX
> functionality for shmem files.
>
> This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
> advices to shmem files which can be helpful for the drivers who may want
> to manage the shmem pages of the files that are created through
> shmem_file_setup[_with_mnt]().  An example usecase may be like, driver
> can create the shmem file of the size equal to its requirements and
> map the pages for DMA and then pass the fd to user. The user who knows
> well about the usage of these pages can now decide when these pages are
> not required push them to swap through DONTNEED thus free up memory well
> in advance rather than relying on the reclaim and use WILLNEED when it
> decide that they are useful in the near future. IOW, it lets the clients
> to free up/read the memory when it wants to. Another usecase is that GEM
> objets which are currenlty allocated and managed through shmem files can

s/objets/objects
s/currenlty/currently


> use vfs_fadvise(DONT|WILLNEED) on shmem fd when the driver comes to
> know(like through some hints from user space) that GEM objects are not
> going to use/will need in the near future.
>
> Some questions asked while reviewing this patch:
>
> Q) Can the same thing be achieved with FD mapped to user and use
> madvise?
> A) All drivers are not mapping all the shmem fd's to user space and want
> to manage them with in the kernel. Ex: shmem memory can be mapped to the
> other subsystems and they fill in the data and then give it to other
> subsystem for further processing, where, the user mapping is not at all
> required.  A simple example, memory that is given for gpu subsystem
> which can be filled directly and give to display subsystem. And the
> respective drivers know well about when to keep that memory in ram or
> swap based on may be a user activity.
>
> Q) Should we add the documentation section in Manual pages?
> A) The man[1] pages for the fadvise() whatever says is also applicable
> for shmem files. so couldn't feel it correct to add specific to shmem
> files separately.
> [1] https://linux.die.net/man/2/fadvise
>
> Q) The proposed semantics of POSIX_FADV_DONTNEED is actually similar to
> MADV_PAGEOUT and different from MADV_DONTNEED. This is a user facing API
> and this difference will cause confusion?
> A) man pages [1] says that "POSIX_FADV_DONTNEED attempts to free cached
> pages associated with the specified region." This means on issuing this
> FADV, it is expected to free the file cache pages. And it is
> implementation defined If the dirty pages may be attempted to writeback.
> And the unwritten dirty pages will not be freed. So, FADV_DONTNEED also
> covers the semantics of MADV_PAGEOUT for file pages and there is no
> purpose of PAGEOUT for file pages.
> [1] https://man7.org/linux/man-pages/man2/posix_fadvise.2.html
>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
> Changes in V4:
>   -- Changed the code to use reclaim_pages() to writeout the shmem pages to swap and then reclaim.
>   -- Addressed comments from Mark Hemment and Matthew.
>   -- fadvise() on shmem file may even unmap a page.
>
> Changes in V3:
>   -- Considered THP pages while doing FADVISE_[DONT|WILL]NEED, identified by Matthew.
>   -- xarray used properly, as identified by Matthew.
>   -- Excluded mapped pages as it requires unmapping and the man pages of fadvise don't talk about them.
>   -- RESEND: Fixed the compilation issue when CONFIG_TMPFS is not defined.
>   -- https://patchwork.kernel.org/project/linux-mm/patch/1641488717-13865-1-git-send-email-quic_charante@quicinc.com/
>
> Changes in V2:
>   -- Rearranged the code to not to sleep with rcu_lock while using xas_() functionality.
>   -- Addressed the comments from Suren.
>   -- https://patchwork.kernel.org/project/linux-mm/patch/1638442253-1591-1-git-send-email-quic_charante@quicinc.com/
>
> changes in V1:
>   -- Created the interface for fadvise(2) to work on shmem files.
>   -- https://patchwork.kernel.org/project/linux-mm/patch/1633701982-22302-1-git-send-email-charante@codeaurora.org/
>
>  mm/shmem.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 18f93c2..fe475af 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -39,6 +39,9 @@
>  #include <linux/frontswap.h>
>  #include <linux/fs_parser.h>
>  #include <linux/swapfile.h>
> +#include <linux/mm_inline.h>
> +#include <linux/fadvise.h>
> +#include <linux/page_idle.h>
>
>  static struct vfsmount *shm_mnt;
>
> @@ -2275,6 +2278,131 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>         return 0;
>  }
>
> +static void shmem_isolate_pages_range(struct address_space *mapping, loff_t start,
> +                               loff_t end, struct list_head *list)
> +{
> +       XA_STATE(xas, &mapping->i_pages, start);
> +       struct page *page;
> +
> +       rcu_read_lock();
> +       xas_for_each(&xas, page, end) {
> +               if (xas_retry(&xas, page))
> +                       continue;
> +               if (xa_is_value(page))
> +                       continue;
> +
> +               if (!get_page_unless_zero(page))
> +                       continue;
> +               if (isolate_lru_page(page)) {
> +                       put_page(page);
> +                       continue;
> +               }
> +               put_page(page);
> +
> +               if (PageUnevictable(page) || page_mapcount(page) > 1) {
> +                       putback_lru_page(page);
> +                       continue;
> +               }
> +
> +               /*
> +                * Prepare the page to be passed to the reclaim_pages().
> +                * VM couldn't reclaim the page unless we clear PG_young.
> +                * Also, to ensure that the pages are written before
> +                * reclaiming, page is set to dirty.
> +                * Since we are not clearing the pte_young in the mapped
> +                * page pte's, its reclaim may not be attempted.
> +                */
> +               ClearPageReferenced(page);
> +               test_and_clear_page_young(page);
> +               SetPageDirty(page);

I asked Hugh about how clean shmem pages are handled during normal
reclaim and his reply is:

Clean shmem pages are rare: they correspond to where a hole in a
sparse file has been mapped read-only to userspace. Those get dropped
from pagecache without being written to swap, when memory pressure
comes to reclaim them. Otherwise, shmem pages are dirty: as soon as
they've been read from swap and identified as shmem (moved from swap
cache to page cache), that swap is freed so they're no longer clean
representations of anything on swap. (Our use of "swap cache" and/or
"page cache" may have inconsistencies in what I've written: sometimes
we use them interchangeably, sometimes we're making a distinction.)

So, IIUC his explanation, you don't really need to mark clean shmem
pages dirty for FADV_DONTNEED since normal reclaim does not do that
either.

> +               list_add(&page->lru, list);
> +               if (need_resched()) {
> +                       xas_pause(&xas);
> +                       cond_resched_rcu();
> +               }
> +       }
> +       rcu_read_unlock();
> +}
> +
> +static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t start,
> +                               loff_t end)
> +{
> +       LIST_HEAD(list);
> +
> +       if (!shmem_mapping(mapping))
> +               return -EINVAL;
> +
> +       if (!total_swap_pages)
> +               return 0;
> +
> +       lru_add_drain();
> +       shmem_isolate_pages_range(mapping, start, end, &list);
> +       reclaim_pages(&list);
> +
> +       return 0;
> +}
> +
> +static int shmem_fadvise_willneed(struct address_space *mapping,
> +                                pgoff_t start, pgoff_t long end)
> +{
> +       struct page *page;
> +       pgoff_t index;
> +
> +       xa_for_each_range(&mapping->i_pages, index, page, start, end) {
> +               if (!xa_is_value(page))
> +                       continue;
> +               page = shmem_read_mapping_page(mapping, index);
> +               if (!IS_ERR(page))
> +                       put_page(page);
> +       }
> +
> +       return 0;
> +}
> +
> +static int shmem_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
> +{
> +       loff_t endbyte;
> +       pgoff_t start_index;.
> +       pgoff_t end_index;
> +       struct address_space *mapping;
> +       int ret = 0;
> +
> +       mapping = file->f_mapping;
> +       if (!mapping || len < 0)
> +               return -EINVAL;
> +
> +       endbyte = (u64)offset + (u64)len;
> +       if (!len || endbyte < len)
> +               endbyte = -1;
> +       else
> +               endbyte--;

The above block is exactly the same as in
https://elixir.bootlin.com/linux/latest/source/mm/fadvise.c#L73 with
the exception that generic_fadvise has comments with explanations of
this math. You might consider consolidating them into a helper
function to calculate the endbyte.

> +
> +
> +       start_index = offset >> PAGE_SHIFT;
> +       end_index   = endbyte >> PAGE_SHIFT;
> +       switch (advice) {
> +       case POSIX_FADV_DONTNEED:
> +               ret = shmem_fadvise_dontneed(mapping, start_index, end_index);
> +               break;
> +       case POSIX_FADV_WILLNEED:
> +               ret = shmem_fadvise_willneed(mapping, start_index, end_index);
> +               break;
> +       case POSIX_FADV_NORMAL:
> +       case POSIX_FADV_RANDOM:
> +       case POSIX_FADV_SEQUENTIAL:
> +       case POSIX_FADV_NOREUSE:
> +               /*
> +                * No bad return value, but ignore advice. May have to
> +                * implement in future.
> +                */
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
>  static struct inode *shmem_get_inode(struct super_block *sb, const struct inode *dir,
>                                      umode_t mode, dev_t dev, unsigned long flags)
>  {
> @@ -3777,6 +3905,7 @@ static const struct file_operations shmem_file_operations = {
>         .splice_write   = iter_file_splice_write,
>         .fallocate      = shmem_fallocate,
>  #endif
> +       .fadvise        = shmem_fadvise,
>  };
>
>  static const struct inode_operations shmem_inode_operations = {
> --
> 2.7.4
>
>
