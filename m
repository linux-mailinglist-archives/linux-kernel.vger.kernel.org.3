Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36C9529DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244664AbiEQJSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243266AbiEQJSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:18:17 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126E833A0B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:17:09 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 202so16402441pgc.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8YGWSWWojih1VKbtgTaPJ1Z6S4eE96LyrRQW+VNJuo=;
        b=JI/N/9lYrny+vGuuJmW/Mz1EwloPiEjhN5PZon9WeBaiDjglsT4Enu5a5xHVRZowOg
         9f3A17ll9qIQChEyLVLsVampoZaCPeLaG4XBeilDJhXBWZbrmNaGpxkZOVLYFaQLD6yh
         /m2bw9s2rGOy5vAk+xOFwaw/t8tuyJV2+DyDH+XizMJ6Gm5RhK7wbA1qpyUv7p3SdWZr
         DHfk71IEAw0lPD8PMXyKfPLy8XSSFX2sAnqmA9/yObH9mgCAlICK9Y2fzSydlVHpzxhR
         9KZFz/lLG0hIcoEFXrFxC6O06kxPgggx5ocXTGPVirYrnk1XPOE+jT9zbPorcmfYK9q2
         2h3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8YGWSWWojih1VKbtgTaPJ1Z6S4eE96LyrRQW+VNJuo=;
        b=Fa4cbPqVox4nJxdZ3meuh45lcuVfLi6yGRXIWjUt32CuSOPdhjxjcpHSDh6WiW2CNx
         ZuxC3Q1mnJ+qwrDVfQwEnVLA3KTN0RXliu1Diyzdne59DtCutQmtnCLlLPIlBONop2LL
         aaRinb8d6ZsQVD43scYpLz/6hZgEH3wgexSx5QMw29IOwcp3HXRiVxLaOSByaUgOjPv8
         Ekw9FzR+q0zufY6Y4HXDV6RnlT8rrs+312k5hjgY6R/zhsmTHZlI4vMMucrgEjGrl69U
         grPAumA29vJAsMkFri9uIiW3UFxteY8JRaPZ3eoMFJA3J1iJjQmET1hhDGqhNPzz2CKN
         9aDg==
X-Gm-Message-State: AOAM533H1cf1WMwpAeFZODkW2VVQdZ0EKb5W/q+AFlIor5S4BvLC2gXn
        lbFI/zdiXTbmIrWItColPtBr0ZniQYXc9NWCZvo=
X-Google-Smtp-Source: ABdhPJyQmaSFdo5O73mmcLowlQG4SBLDZevrKgfoPfruisJEss3MbayYyRyPbPsBJRt31o5gOkJvjo7bWF5VvtSyJEA=
X-Received: by 2002:a05:6a00:244a:b0:4fa:ebf9:75de with SMTP id
 d10-20020a056a00244a00b004faebf975demr21562526pfj.73.1652779028918; Tue, 17
 May 2022 02:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220517082650.2005840-1-hsinyi@chromium.org> <20220517082650.2005840-4-hsinyi@chromium.org>
In-Reply-To: <20220517082650.2005840-4-hsinyi@chromium.org>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Tue, 17 May 2022 17:16:42 +0800
Message-ID: <CAEVVKH8vJ4KZ8VX=paXdZ7Ci8rLF=nh4OA2eP96JzUDeeGEtJQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] squashfs: implement readahead
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

"xiongwei.song@windriver.com" too.

> ---
> v1->v2: remove unused check on readahead_expand().
> v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium.org/
> ---
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
>
