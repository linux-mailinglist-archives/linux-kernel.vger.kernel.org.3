Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99B352CDF0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbiESIJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbiESIJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:09:49 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9085DA34
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:09:48 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id d22so4645958vsf.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6CHqFUc2pzrLwDPfZGytZQ03T9cBPjhPzdLcOw4RoFA=;
        b=UbduS0B4a9VwGpxuxp3hYbv9y3h6h5rQFZpKQZ8qHUt7CDX0YahUxcwgoVq6NXDprY
         BMn44pHe9GlexYKSvuqDN6IC9F8Jr4J8DnB3t4ugT/7J7B2mxwncPcv3L+i8olECR3lD
         kuCHUqj7f7h8CGhjhfzNXibGCmlgzSvbntMys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CHqFUc2pzrLwDPfZGytZQ03T9cBPjhPzdLcOw4RoFA=;
        b=cSZK5z5UX97MmabEQj0mhLvcOJ8BYjxOGp8qcUJ3XuRy+9GSxbwRGqO3AqpB7r/gq3
         AE182gWjxvDQMz9IBfOGOZsUVryPP2T/WrSQRzTDdukwYWm45oGHgRD40aANFYzxlAMK
         z+9xg2HGGr0y7L3SnH3oqq+AMuTGrWxU7inm6/l/1Kft5S+gRmowQzlwoKgUXRCXjC6w
         qVXM3AkSj49PPqFuZ1YKDDHbLqvewLvPsgVESC0vqQskHedU9cCc/HXI5IFsSEwR9AQO
         +pOPrjAMYrz+A5BfggMxbcurn0R23JpzqjVIbzyE0BH/JiffmSAyBMGP/BqF00zX2vpN
         NDiQ==
X-Gm-Message-State: AOAM5336H/yLQAYfivXbEm/j6mqQwck7X/JLH1IkKFOrsP/Mt/xky/Vj
        Rri/CxKo+7FsuMoFb7N0Cu/V9ItUkhiCLqEdNVxjGw==
X-Google-Smtp-Source: ABdhPJyR0wfOdCkx9Ln3PXfB2tqqXTqSE4JnMb4pcTmgGOXyrijxP0mjju1tZU9SOZGyIg55wKrOSMCUloO1vRhUDvw=
X-Received: by 2002:a05:6102:3a76:b0:32c:e483:3e45 with SMTP id
 bf22-20020a0561023a7600b0032ce4833e45mr1650908vsb.19.1652947787618; Thu, 19
 May 2022 01:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220517082650.2005840-1-hsinyi@chromium.org> <20220517082650.2005840-4-hsinyi@chromium.org>
In-Reply-To: <20220517082650.2005840-4-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 19 May 2022 16:09:21 +0800
Message-ID: <CAJMQK-hovwXsuVUDD6-eueD05srWVdx1OWZ9vBdp-bT6De25ig@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] squashfs: implement readahead
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>
Cc:     Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 4:28 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Implement readahead callback for squashfs. It will read datablocks
> which cover pages in readahead request. For a few cases it will
> not mark page as uptodate, including:
> - file end is 0.
> - zero filled blocks.
> - current batch of pages isn't in the same datablock or not enough in a
>   datablock.
> Otherwise pages will be marked as uptodate. The unhandled pages will be
> updated by readpage later.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
> Reported-by: Xiongwei Song <sxwjean@gmail.com>
> ---
> v1->v2: remove unused check on readahead_expand().
> v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium.org/
> ---

Hi Phillip and Matthew,

Regarding the performance issue of this patch, I saw a possible
performance gain if we only read the first block instead of reading
until nr_pages == 0.

To be more clear, apply the following diff (Please ignore the skipping
of nr_pages check first. This is a demonstration of "only read and
update the first block per readahead call"):

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index aad6823f0615..c52f7c4a7cfe 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -524,10 +524,8 @@ static void squashfs_readahead(struct
readahead_control *ractl)
        if (!actor)
                goto out;

-       for (;;) {
+       {
                nr_pages = __readahead_batch(ractl, pages, max_pages);
-               if (!nr_pages)
-                       break;

                if (readahead_pos(ractl) >= i_size_read(inode) ||
                    nr_pages < max_pages)


All the performance numbers:
1. original: 39s
2. revert "mm: put readahead pages in cache earlier": 2.8s
3. v2 of this patch: 2.7s
4. v2 of this patch and apply the diff: 1.8s

In my testing data, normally it reads and updates 1~2 blocks per
readahead call. The change might not make sense since the performance
improvement may only happen in certain cases.

What do you think? Or is the performance of the current patch
considered reasonable?

Thanks.

testing env:
- arm64 on kernel 5.10
- data: ~ 300K pack file contains some android files

>  fs/squashfs/file.c | 77 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
>
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index a8e495d8eb86..e10a55c5b1eb 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -39,6 +39,7 @@
>  #include "squashfs_fs_sb.h"
>  #include "squashfs_fs_i.h"
>  #include "squashfs.h"
> +#include "page_actor.h"
>
>  /*
>   * Locate cache slot in range [offset, index] for specified inode.  If
> @@ -495,7 +496,81 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>         return 0;
>  }
>
> +static void squashfs_readahead(struct readahead_control *ractl)
> +{
> +       struct inode *inode = ractl->mapping->host;
> +       struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
> +       size_t mask = (1UL << msblk->block_log) - 1;
> +       size_t shift = msblk->block_log - PAGE_SHIFT;
> +       loff_t start = readahead_pos(ractl) &~ mask;
> +       size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
> +       struct squashfs_page_actor *actor;
> +       unsigned int nr_pages = 0;
> +       struct page **pages;
> +       u64 block = 0;
> +       int bsize, res, i, index;
> +       int file_end = i_size_read(inode) >> msblk->block_log;
> +       unsigned int max_pages = 1UL << shift;
> +
> +       readahead_expand(ractl, start, (len | mask) + 1);
> +
> +       if (file_end == 0)
> +               return;
> +
> +       pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
> +       if (!pages)
> +               return;
> +
> +       actor = squashfs_page_actor_init_special(pages, max_pages, 0);
> +       if (!actor)
> +               goto out;
> +
> +       for (;;) {
> +               nr_pages = __readahead_batch(ractl, pages, max_pages);
> +               if (!nr_pages)
> +                       break;
> +
> +               if (readahead_pos(ractl) >= i_size_read(inode) ||
> +                   nr_pages < max_pages)
> +                       goto skip_pages;
> +
> +               index = pages[0]->index >> shift;
> +               if ((pages[nr_pages - 1]->index >> shift) != index)
> +                       goto skip_pages;
> +
> +               bsize = read_blocklist(inode, index, &block);
> +               if (bsize == 0)
> +                       goto skip_pages;
> +
> +               res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
> +                                        actor);
> +
> +               if (res >= 0)
> +                       for (i = 0; i < nr_pages; i++)
> +                               SetPageUptodate(pages[i]);
> +
> +               for (i = 0; i < nr_pages; i++) {
> +                       unlock_page(pages[i]);
> +                       put_page(pages[i]);
> +               }
> +       }
> +
> +       kfree(actor);
> +       kfree(pages);
> +       return;
> +
> +skip_pages:
> +       for (i = 0; i < nr_pages; i++) {
> +               unlock_page(pages[i]);
> +               put_page(pages[i]);
> +       }
> +
> +       kfree(actor);
> +out:
> +       kfree(pages);
> +}
>
>  const struct address_space_operations squashfs_aops = {
> -       .read_folio = squashfs_read_folio
> +       .read_folio = squashfs_read_folio,
> +       .readahead = squashfs_readahead
>  };
> --
> 2.36.0.550.gb090851708-goog
>
