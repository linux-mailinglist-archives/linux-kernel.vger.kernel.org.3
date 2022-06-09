Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2B7544FC1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243712AbiFIOrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242317AbiFIOrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:47:04 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349A1D6D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:47:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id j6so21238932pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 07:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=doMJm8RAJKQPombCk8jeFX6F/mzrF+61GJARc3fQjTE=;
        b=jWjLafpjePKW0FtxVCCEkUGe1afjkKYksBfPtbiwYG0xZnT0K22f2SCu22aId33jok
         vNBqt8E+iAWjsDrrNj6aa6QtDCPga0bniWCiSmkRZTpB4iLL8kNh++/He/EGLiAgk8kY
         T6cFoR0nzxCwlCc8vz4hEnVYPbArJSGuaiw3FVAu9xK2LpHj+OxT1vaBDLKH9d2G3qBv
         Fh8euTzGsmZavSe8WNRv2V05y5vhkJL43CtZjb4g1mvxwKNFNbCgkqPZIypPtak0YuuY
         QaFhshoLYJUKgZxzXWVpTgJr0q/PL/FI2yDK8XjFBEkZAj9uJ9xypeF4vndQsawWgt2F
         y66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=doMJm8RAJKQPombCk8jeFX6F/mzrF+61GJARc3fQjTE=;
        b=oxYttetn8mabm4NHpNxLnapD5kOSM1FWw+KPRg+LjjTHU4ph/GJ1fGyzzERYY5DFUP
         wn0i7VHby/oskLfQnxNvT2m2gqkB8H28rgXTJtk6DL4/MKQYVcnngCLglRVohSWlqJuN
         8EeUXiSCe2NV1NCjROK907Yf68FbSzHv2B4Whsu8KBhId+SA13q0jcuPxpUNQVHB50Ui
         3WB6vcdowvrZya0Y4D92/pLEWXpmr1dAwoNRSBLNqPObt4i68F7vpUrwGdqLNEtVONXc
         NHnjVblzPPU2YYXaY9qdCi2DSwCzrJqYBAkBE9Wqdq1resM4ouD/9271YrydLJiGFs+0
         z5WA==
X-Gm-Message-State: AOAM530DU0OHBVUCVP8r7QmceoylPc2FuPsVEyoJdELMrwZrmC4HuU94
        BJ0ZfIEoXT7V2K2S5lFZbGgoNIxVsWJnqAkKYwo=
X-Google-Smtp-Source: ABdhPJx5ha8f6h+E3NHWYdwnjCRQfgq7Py3/YA4sCBWpN00hsfKv9Qj2eDas9cMNkp+qNyQ9IFpTrFx4LTSN4t5eALw=
X-Received: by 2002:aa7:9f84:0:b0:51b:b64d:fc69 with SMTP id
 z4-20020aa79f84000000b0051bb64dfc69mr8403049pfr.7.1654786022670; Thu, 09 Jun
 2022 07:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220606150305.1883410-1-hsinyi@chromium.org> <20220606150305.1883410-4-hsinyi@chromium.org>
In-Reply-To: <20220606150305.1883410-4-hsinyi@chromium.org>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Thu, 9 Jun 2022 22:46:36 +0800
Message-ID: <CAEVVKH_6PEc0CEfVrThO9m3kdcHVA=-i5FXkQTKaCgESVkJpig@mail.gmail.com>
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

This version is bad for my test. I ran the test below
"for cnt in $(seq 0 9); do echo 3 > /proc/sys/vm/drop_caches; echo
"Loop ${cnt}:"; time -v find /software/test[0-9][0-9] | xargs -P 24 -i
cat {} > /dev/null 2>/dev/null; echo ""; done"
in 90 partitions.

With 9eec1d897139 reverted:
1:06.18 (1m + 6.18s)
1:05.65
1:06.34
1:06.88
1:06.52
1:06.78
1:06.61
1:06.99
1:06.60
1:06.79

With this version:
2:36.85 (2m + 36.85s)
2:28.89
1:43.46
1:41.50
1:42.75
1:43.46
1:43.67
1:44.41
1:44.91
1:45.44

Any thoughts?

Regards,
Xiongwei

On Mon, Jun 6, 2022 at 11:03 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Implement readahead callback for squashfs. It will read datablocks
> which cover pages in readahead request. For a few cases it will
> not mark page as uptodate, including:
> - file end is 0.
> - zero filled blocks.
> - current batch of pages isn't in the same datablock.
> - decompressor error.
> Otherwise pages will be marked as uptodate. The unhandled pages will be
> updated by readpage later.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
> Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> v4->v5:
> - Handle short file cases reported by Marek and Matthew.
> - Fix checkpatch error reported by Andrew.
>
> v4: https://lore.kernel.org/lkml/20220601103922.1338320-4-hsinyi@chromium.org/
> v3: https://lore.kernel.org/lkml/20220523065909.883444-4-hsinyi@chromium.org/
> v2: https://lore.kernel.org/lkml/20220517082650.2005840-4-hsinyi@chromium.org/
> v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium.org/
> ---
>  fs/squashfs/file.c | 124 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 123 insertions(+), 1 deletion(-)
>
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index a8e495d8eb86..fbd096cd15f4 100644
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
> @@ -495,7 +496,128 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>         return 0;
>  }
>
> +static void squashfs_readahead(struct readahead_control *ractl)
> +{
> +       struct inode *inode = ractl->mapping->host;
> +       struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
> +       size_t mask = (1UL << msblk->block_log) - 1;
> +       unsigned short shift = msblk->block_log - PAGE_SHIFT;
> +       loff_t start = readahead_pos(ractl) & ~mask;
> +       size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
> +       struct squashfs_page_actor *actor;
> +       unsigned int nr_pages = 0;
> +       struct page **pages;
> +       int i, file_end = i_size_read(inode) >> msblk->block_log;
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
> +               pgoff_t index;
> +               int res, bsize;
> +               u64 block = 0;
> +               unsigned int expected;
> +
> +               nr_pages = __readahead_batch(ractl, pages, max_pages);
> +               if (!nr_pages)
> +                       break;
> +
> +               if (readahead_pos(ractl) >= i_size_read(inode))
> +                       goto skip_pages;
> +
> +               index = pages[0]->index >> shift;
> +               if ((pages[nr_pages - 1]->index >> shift) != index)
> +                       goto skip_pages;
> +
> +               expected = index == file_end ?
> +                          (i_size_read(inode) & (msblk->block_size - 1)) :
> +                           msblk->block_size;
> +
> +               bsize = read_blocklist(inode, index, &block);
> +               if (bsize == 0)
> +                       goto skip_pages;
> +
> +               if (nr_pages < max_pages) {
> +                       struct squashfs_cache_entry *buffer;
> +                       unsigned int block_mask = max_pages - 1;
> +                       int offset = pages[0]->index - (pages[0]->index & ~block_mask);
> +
> +                       buffer = squashfs_get_datablock(inode->i_sb, block,
> +                                                       bsize);
> +                       if (buffer->error) {
> +                               squashfs_cache_put(buffer);
> +                               goto skip_pages;
> +                       }
> +
> +                       expected -= offset * PAGE_SIZE;
> +                       for (i = 0; i < nr_pages && expected > 0; i++,
> +                                               expected -= PAGE_SIZE, offset++) {
> +                               int avail = min_t(int, expected, PAGE_SIZE);
> +
> +                               squashfs_fill_page(pages[i], buffer,
> +                                               offset * PAGE_SIZE, avail);
> +                               unlock_page(pages[i]);
> +                       }
> +
> +                       squashfs_cache_put(buffer);
> +                       continue;
> +               }
> +
> +               res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
> +                                        actor);
> +
> +               if (res == expected) {
> +                       int bytes;
> +
> +                       /* Last page may have trailing bytes not filled */
> +                       bytes = res % PAGE_SIZE;
> +                       if (bytes) {
> +                               void *pageaddr;
> +
> +                               pageaddr = kmap_atomic(pages[nr_pages - 1]);
> +                               memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
> +                               kunmap_atomic(pageaddr);
> +                       }
> +
> +                       for (i = 0; i < nr_pages; i++) {
> +                               flush_dcache_page(pages[i]);
> +                               SetPageUptodate(pages[i]);
> +                       }
> +               }
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
> 2.36.1.255.ge46751e96f-goog
>
>
