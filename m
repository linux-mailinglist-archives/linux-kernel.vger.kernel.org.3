Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1955C5282CC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242889AbiEPLEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiEPLEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:04:37 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64FD2D1C5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 04:04:35 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id v139so15140291vsv.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 04:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vkeDkFkYpkmRJ364RgcYqVHpDHCVzTSeOQ89Cq0MtS8=;
        b=S5+KmO4aosUfRV541We6wTd6sve2C2jxofS550PddoyoaVJyjTlteA1h6W6VFPgoyA
         HCgQ7fPNUxmrLAVaKGHu9qXG6jQkUitCp/l3whsMngT4ONWPKuQhQxL493inaHD5bLee
         t5wT7tF+V/bEUVcxyxY0dirsJhDND54dcGfzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkeDkFkYpkmRJ364RgcYqVHpDHCVzTSeOQ89Cq0MtS8=;
        b=OoDEblRLECWdTQTJae/PhqlVf2tXFtHwqB1hBGgFat7aHIJ46dEUQJUWRzHMUFkyCc
         8ZDRunmTLd02R170EfHT4j1a0hmAZp4VNJVguIg6Wt2Y3sqy5BVSZeY9NAipOp2hG9+c
         5TZ/4tbJoDxDWKSkrsUA5MdCReLJJ8QHFpDJ6PNUWUnMf7lpZqAmwSbQgxXB6OASDoQe
         FnAahr0XIFhnXEGdHa5HnTZA9paL+ID9Lfd6NG1AJcTOMus4y1UhaUl5PmmX1A+1vjsb
         NCfCVsNv+0C5L4VhNn1+OPbwcH4uwGsaMVZbeJZI/lrhxWPBCEzP9hAQ84FNchdljtK2
         SPdg==
X-Gm-Message-State: AOAM533obAFIxa0OUoEWYXnucDwksC54OR/lFJDFKs36mfu4NTut01DW
        O0OdmrYDkuclKZNNT+B0QfBrQ8c//fEY2ctFLxtsKw==
X-Google-Smtp-Source: ABdhPJy/t2EK0wj7DIUgHQJxkAvMKiBtEuItKuf9ivBIXzsz1re04fcHg/GAOshdJcGvYzYj1/2wgalPsfQJVHRkehM=
X-Received: by 2002:a05:6102:558f:b0:32d:7901:edcc with SMTP id
 dc15-20020a056102558f00b0032d7901edccmr6119228vsb.80.1652699074738; Mon, 16
 May 2022 04:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220516105100.1412740-1-hsinyi@chromium.org> <20220516105100.1412740-3-hsinyi@chromium.org>
In-Reply-To: <20220516105100.1412740-3-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 16 May 2022 19:04:08 +0800
Message-ID: <CAJMQK-jjNRuZFOJrd2knQHwPERaJ64pyys+14cCVyfdsP1GZSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] squashfs: implement readahead
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
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 6:51 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
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
Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> Note that this patch was not formally sent to the list before. It's
> attached to email thread for discussion as it's still under development.
>
> - v1:
> The patch outline was suggested by Matthew. It went through a few
> reviews by Matthew offline.
>
> - v2:
> https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#m442435c149d411c5c9d8019cff5915419b04bf10
> This is a resend of v1.
>
> - v3:
> https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#m55a709e6ba5ec59fe95323a67a7f3d6b1953e470
> Fix page actor size to avoid a crash from squashfs_decompress().
> Suggested by Phillip Lougher[1]
> [1] https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#m687f82debb7667ff31982a05aef3eba081eb5039
>
> - v4:
> https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#mf93267690ec2e841dade6a494fe72c84b61328d9
> Fix to free page after used. Suggested by Xiongwei Song[2]
> Refactor the skip page logic to possible improve the performance.
> Suggested by Phillip Lougher[3]
> [2] https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#m0e7b33d167b1ef0eb39b9f41c32ed3f80dfced18
> [3] https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#m1e0a8f8e4a98d79d14c81b66e197b6dc0a3b77a1
> ---
>  fs/squashfs/file.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index a8e495d8eb86..91dfec792f4c 100644
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
> @@ -495,7 +496,83 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>         return 0;
>  }
>
> +static void squashfs_readahead(struct readahead_control *ractl)
> +{
> +       struct inode *inode = ractl->mapping->host;
> +       struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
> +       size_t mask = (1UL << msblk->block_log) - 1;
> +       size_t shift = msblk->block_log - PAGE_SHIFT;
> +       loff_t req_end = readahead_pos(ractl) + readahead_length(ractl);
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
> +       if (readahead_pos(ractl) + readahead_length(ractl) < req_end ||
> +           file_end == 0)
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
>         .read_folio = squashfs_read_folio
> +       .readahead = squashfs_readahead
>  };
> --
> 2.36.0.550.gb090851708-goog
>
