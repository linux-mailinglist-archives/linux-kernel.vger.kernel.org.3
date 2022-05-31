Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5910538E07
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245383AbiEaJv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245369AbiEaJvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:51:41 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3403222
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:51:38 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id y2so4619061uan.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MpCPQJh9DbmIe7accXEFW1MsdAJOpJw3XILL74h1u8M=;
        b=MFZ8iyL11Ahdehuvsatbb06YXUeBsjmmb4uQxxiEae3fLZHKfCTK4VDf6cZQPHCaV8
         tkVMOXgiraMtFgSfjb5LW9Nzzpcy22Z/UEO2ruWxUhPAsmAvPmg8rH6sUbIVNB3fUKzW
         D3P1gtyIXJNTmrDoKPsRwYasWaR0V08emUExg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MpCPQJh9DbmIe7accXEFW1MsdAJOpJw3XILL74h1u8M=;
        b=78Xk0uvZcfgwpYvPRU8iKupSvderp3e+ZL2tFVun4jQuyWLefhVgMTt9bzI19fqcJA
         mC5vmboeIztuasFKBZlg+68iYVqQgsgUc0UNjW6tgVPRPIpw07FJtdZIxfz6rN+L30YW
         RcoAKyjJnUmCEHyjjSIDFXU3tfPAuZC298CngkD7y2Xk2auGiVYmRMYWM0sRpy8hy9AR
         5tcfvS5ApKnne3rYDRIAgCjy5lX8Vz9aVfwUBOPjAuczyZdfguftIq1CiJIoxVJcEqeX
         JhHvfW+Imxa6g/41XwBzcfdtompRKsAn2D32+jkrmmIG1iRVk7/hI9Na4Uw/VApoE1Gf
         mmvA==
X-Gm-Message-State: AOAM532RtjzTHFy8ZLLaGb8vmoTCsmjlK4C2lEXdnolcurfh8VM4zhY4
        +XreWWCH4z5LKl9RPJHJlLLeOay0aTL+FIPSoPoGgQ==
X-Google-Smtp-Source: ABdhPJykLd5RBbYQLFNRj8qD1kI6mK6loSCqsvU5Zt6aNJlpFZyIHg+9EsfgCS83B9dFxPv55dhHgtyOoUrD/CXhMqU=
X-Received: by 2002:ab0:3492:0:b0:368:b577:bfd with SMTP id
 c18-20020ab03492000000b00368b5770bfdmr20306664uar.110.1653990697684; Tue, 31
 May 2022 02:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220523065909.883444-1-hsinyi@chromium.org> <20220523065909.883444-4-hsinyi@chromium.org>
In-Reply-To: <20220523065909.883444-4-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 31 May 2022 17:51:11 +0800
Message-ID: <CAJMQK-isVhkhGu3=QAWaDvOd9sXgNep3ZrZ6jjoa2j+h6Uc45w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] squashfs: implement readahead
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
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 3:00 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Implement readahead callback for squashfs. It will read datablocks
> which cover pages in readahead request. For a few cases it will
> not mark page as uptodate, including:
> - file end is 0.
> - zero filled blocks.
> - current batch of pages isn't in the same datablock or not enough in a
>   datablock.
> - decompressor error.
> Otherwise pages will be marked as uptodate. The unhandled pages will be
> updated by readpage later.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
> Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
> ---

Kindly ping on the thread. Conversations on v2:
https://patchwork.kernel.org/project/linux-mm/patch/20220517082650.2005840-4-hsinyi@chromium.org/#24869037
This version mainly addressed the error handling.

Thanks

> v2->v3: Add checks on
> - decompressed block size.
> - fill zeros if the last page is not a full page.
>
> v2: https://lore.kernel.org/lkml/20220517082650.2005840-4-hsinyi@chromium.org/
> v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium.org/
> ---
>  fs/squashfs/file.c | 91 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 90 insertions(+), 1 deletion(-)
>
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index a8e495d8eb86..c311fc685fe4 100644
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
> @@ -495,7 +496,95 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
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
> +       int bsize, res, i, index, bytes, expected;
> +       int file_end = i_size_read(inode) >> msblk->block_log;
> +       unsigned int max_pages = 1UL << shift;
> +       void *pageaddr;
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
> +               expected = index == file_end ?
> +                          (i_size_read(inode) & (msblk->block_size - 1)) :
> +                           msblk->block_size;
> +
> +               bsize = read_blocklist(inode, index, &block);
> +               if (bsize == 0)
> +                       goto skip_pages;
> +
> +               res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
> +                                        actor);
> +
> +               if (res == expected) {
> +                       /* Last page may have trailing bytes not filled */
> +                       bytes = res % PAGE_SIZE;
> +                       if (bytes) {
> +                               pageaddr = kmap_atomic(pages[nr_pages - 1]);
> +                               memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
> +                               kunmap_atomic(pageaddr);
> +                       }
> +
> +                       for (i = 0; i < nr_pages; i++)
> +                               SetPageUptodate(pages[i]);
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
> 2.36.1.124.g0e6072fb45-goog
>
