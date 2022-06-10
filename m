Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A501954599B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 03:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbiFJBcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 21:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiFJBcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:32:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB11D232A44
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 18:32:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 187so22554312pfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 18:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMc32X/LG6Z8TwD+zNHEh+hFbaMCmqWi0/o54N9U4X0=;
        b=V/T2/cF72+nZ5rzDzZ9B3IznZY7IG20V9kaZ9Bt3L1B5jSrEMVpwGF8ipKZN9BvJX5
         CnSip0HuZzrHxWPj4sI61mF+f2qVcd/MSiF7wZDBKTMiyPTM8P8HC8MSl7uAA2K3gJAb
         GGPNj38ifWROv2uwLLspF5+tVZqmmNqF9Kj/3vlnS5vsvXXEFZK6jenDpgAFRliQo1g0
         kwQ0Xy14y9vjvgPk1vMUvmKEbf12YbGgu8szSpbe3nUIJAKpCkDqr0axx2gjwOUA+/Gg
         Bd8hPgGKJpBzAmFKMtaNeY4VfYcyf1ndUjjHeByx8KFNZ+d7KrCS6JQaIuCSGhlYhUok
         I7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMc32X/LG6Z8TwD+zNHEh+hFbaMCmqWi0/o54N9U4X0=;
        b=eF0ro0i13crt6u562VSFyMdK9vq2Yjg3Org4Bfy6OH6imQDMk7/a3J8GHI9snqwClR
         cIMT4w3p3ZuZQvNb1uDna9pquoXuPj05v+QeOLwIpaCQq0kkxK3/CkOzhCHqh60n4EoP
         czbbEt4T8/Lp67cm7f3SJYYlIKC3H9WLFStaCq8fqRYLfDNgk/ykVpyaVfrix4d4oLcG
         R9x0NQnKgKJjUbcOi8YztbZT+gX4veTPbkPFtyJpPmMZ7wkTJih9H2mw0yqL47vmcTBT
         Xd6PsmdTH/tOMzszutwsKSKHapgGfg481ve8i6wMzfBxJrm9RUk3c09fTxqJcahyJ5Va
         HNIg==
X-Gm-Message-State: AOAM532ESXaz5QoCWyizNubWuzPcq/pc3xH7gOlEEjaaJ/D26x2hbgY8
        54xtkt3Tynnw43ssw+cHyb4U2h0nNt0gvLKufCyQ1xsIh6wir+hm
X-Google-Smtp-Source: ABdhPJyWOfiIYYBpWqc7ZGe4OsOZkgBiTFudIrtQXr8cV4X0A9BvDpZl48t2iM7nJs27JrfHaHZoOjHSS+I/hlUeV9Y=
X-Received: by 2002:a65:5504:0:b0:3fb:ac7a:ac1e with SMTP id
 f4-20020a655504000000b003fbac7aac1emr37635913pgr.476.1654824767177; Thu, 09
 Jun 2022 18:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220606150305.1883410-1-hsinyi@chromium.org> <20220606150305.1883410-4-hsinyi@chromium.org>
 <CAEVVKH_6PEc0CEfVrThO9m3kdcHVA=-i5FXkQTKaCgESVkJpig@mail.gmail.com>
In-Reply-To: <CAEVVKH_6PEc0CEfVrThO9m3kdcHVA=-i5FXkQTKaCgESVkJpig@mail.gmail.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Fri, 10 Jun 2022 09:32:20 +0800
Message-ID: <CAEVVKH9CdnbAdyKJ4xbZhi=KvJMQuiWfVpcRDw-umDZcwPixhQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] squashfs: implement readahead
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
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

On Thu, Jun 9, 2022 at 10:46 PM Xiongwei Song <sxwjean@gmail.com> wrote:
>
> This version is bad for my test. I ran the test below
> "for cnt in $(seq 0 9); do echo 3 > /proc/sys/vm/drop_caches; echo
> "Loop ${cnt}:"; time -v find /software/test[0-9][0-9] | xargs -P 24 -i
> cat {} > /dev/null 2>/dev/null; echo ""; done"
> in 90 partitions.
>
> With 9eec1d897139 reverted:

Sorry, it's with readahead enabled in linux 5.10.

Regards,
Xiongwei

> 1:06.18 (1m + 6.18s)
> 1:05.65
> 1:06.34
> 1:06.88
> 1:06.52
> 1:06.78
> 1:06.61
> 1:06.99
> 1:06.60
> 1:06.79
>
> With this version:
> 2:36.85 (2m + 36.85s)
> 2:28.89
> 1:43.46
> 1:41.50
> 1:42.75
> 1:43.46
> 1:43.67
> 1:44.41
> 1:44.91
> 1:45.44
>
> Any thoughts?
>
> Regards,
> Xiongwei
>
> On Mon, Jun 6, 2022 at 11:03 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > Implement readahead callback for squashfs. It will read datablocks
> > which cover pages in readahead request. For a few cases it will
> > not mark page as uptodate, including:
> > - file end is 0.
> > - zero filled blocks.
> > - current batch of pages isn't in the same datablock.
> > - decompressor error.
> > Otherwise pages will be marked as uptodate. The unhandled pages will be
> > updated by readpage later.
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
> > Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Reported-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > v4->v5:
> > - Handle short file cases reported by Marek and Matthew.
> > - Fix checkpatch error reported by Andrew.
> >
> > v4: https://lore.kernel.org/lkml/20220601103922.1338320-4-hsinyi@chromium.org/
> > v3: https://lore.kernel.org/lkml/20220523065909.883444-4-hsinyi@chromium.org/
> > v2: https://lore.kernel.org/lkml/20220517082650.2005840-4-hsinyi@chromium.org/
> > v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium.org/
> > ---
> >  fs/squashfs/file.c | 124 ++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 123 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> > index a8e495d8eb86..fbd096cd15f4 100644
> > --- a/fs/squashfs/file.c
> > +++ b/fs/squashfs/file.c
> > @@ -39,6 +39,7 @@
> >  #include "squashfs_fs_sb.h"
> >  #include "squashfs_fs_i.h"
> >  #include "squashfs.h"
> > +#include "page_actor.h"
> >
> >  /*
> >   * Locate cache slot in range [offset, index] for specified inode.  If
> > @@ -495,7 +496,128 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
> >         return 0;
> >  }
> >
> > +static void squashfs_readahead(struct readahead_control *ractl)
> > +{
> > +       struct inode *inode = ractl->mapping->host;
> > +       struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
> > +       size_t mask = (1UL << msblk->block_log) - 1;
> > +       unsigned short shift = msblk->block_log - PAGE_SHIFT;
> > +       loff_t start = readahead_pos(ractl) & ~mask;
> > +       size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
> > +       struct squashfs_page_actor *actor;
> > +       unsigned int nr_pages = 0;
> > +       struct page **pages;
> > +       int i, file_end = i_size_read(inode) >> msblk->block_log;
> > +       unsigned int max_pages = 1UL << shift;
> > +
> > +       readahead_expand(ractl, start, (len | mask) + 1);
> > +
> > +       if (file_end == 0)
> > +               return;
> > +
> > +       pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
> > +       if (!pages)
> > +               return;
> > +
> > +       actor = squashfs_page_actor_init_special(pages, max_pages, 0);
> > +       if (!actor)
> > +               goto out;
> > +
> > +       for (;;) {
> > +               pgoff_t index;
> > +               int res, bsize;
> > +               u64 block = 0;
> > +               unsigned int expected;
> > +
> > +               nr_pages = __readahead_batch(ractl, pages, max_pages);
> > +               if (!nr_pages)
> > +                       break;
> > +
> > +               if (readahead_pos(ractl) >= i_size_read(inode))
> > +                       goto skip_pages;
> > +
> > +               index = pages[0]->index >> shift;
> > +               if ((pages[nr_pages - 1]->index >> shift) != index)
> > +                       goto skip_pages;
> > +
> > +               expected = index == file_end ?
> > +                          (i_size_read(inode) & (msblk->block_size - 1)) :
> > +                           msblk->block_size;
> > +
> > +               bsize = read_blocklist(inode, index, &block);
> > +               if (bsize == 0)
> > +                       goto skip_pages;
> > +
> > +               if (nr_pages < max_pages) {
> > +                       struct squashfs_cache_entry *buffer;
> > +                       unsigned int block_mask = max_pages - 1;
> > +                       int offset = pages[0]->index - (pages[0]->index & ~block_mask);
> > +
> > +                       buffer = squashfs_get_datablock(inode->i_sb, block,
> > +                                                       bsize);
> > +                       if (buffer->error) {
> > +                               squashfs_cache_put(buffer);
> > +                               goto skip_pages;
> > +                       }
> > +
> > +                       expected -= offset * PAGE_SIZE;
> > +                       for (i = 0; i < nr_pages && expected > 0; i++,
> > +                                               expected -= PAGE_SIZE, offset++) {
> > +                               int avail = min_t(int, expected, PAGE_SIZE);
> > +
> > +                               squashfs_fill_page(pages[i], buffer,
> > +                                               offset * PAGE_SIZE, avail);
> > +                               unlock_page(pages[i]);
> > +                       }
> > +
> > +                       squashfs_cache_put(buffer);
> > +                       continue;
> > +               }
> > +
> > +               res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
> > +                                        actor);
> > +
> > +               if (res == expected) {
> > +                       int bytes;
> > +
> > +                       /* Last page may have trailing bytes not filled */
> > +                       bytes = res % PAGE_SIZE;
> > +                       if (bytes) {
> > +                               void *pageaddr;
> > +
> > +                               pageaddr = kmap_atomic(pages[nr_pages - 1]);
> > +                               memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
> > +                               kunmap_atomic(pageaddr);
> > +                       }
> > +
> > +                       for (i = 0; i < nr_pages; i++) {
> > +                               flush_dcache_page(pages[i]);
> > +                               SetPageUptodate(pages[i]);
> > +                       }
> > +               }
> > +
> > +               for (i = 0; i < nr_pages; i++) {
> > +                       unlock_page(pages[i]);
> > +                       put_page(pages[i]);
> > +               }
> > +       }
> > +
> > +       kfree(actor);
> > +       kfree(pages);
> > +       return;
> > +
> > +skip_pages:
> > +       for (i = 0; i < nr_pages; i++) {
> > +               unlock_page(pages[i]);
> > +               put_page(pages[i]);
> > +       }
> > +
> > +       kfree(actor);
> > +out:
> > +       kfree(pages);
> > +}
> >
> >  const struct address_space_operations squashfs_aops = {
> > -       .read_folio = squashfs_read_folio
> > +       .read_folio = squashfs_read_folio,
> > +       .readahead = squashfs_readahead
> >  };
> > --
> > 2.36.1.255.ge46751e96f-goog
> >
> >
