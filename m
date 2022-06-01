Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262A2539F9F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245286AbiFAIhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbiFAIhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:37:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C2621819
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:37:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v25so1166042eda.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZXVqu+h9NXbHvrC2CE+JHc/yJMidzZ16AsBJPRrJPE=;
        b=V0iPmt+kTBJH5ivwrDvWTMPC9WwYqethXf9BHUztx9gbkHKvHcvpU6Ty1cRNR4mHPd
         sy43RmmEcF13bNjbgYbYDMygYypovBn5LwM4kIw4hq/ucZuP7/72mTjQIg9seBTTX4iP
         iN7Gtk0gAfuRXlU6PqGiHGz7dupYyUlAQXeHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZXVqu+h9NXbHvrC2CE+JHc/yJMidzZ16AsBJPRrJPE=;
        b=Mk0gQs5Bt3/M5BmlKhuXFfgfSrqCDdE6c2ISsZsQRW8PGS6MkCZbocCuN0/udIKPXk
         inGe87EOVrw8FZAaVSab7cA4GlBjW/liXiMNNewU8mP9Xb8thAOMcWOdmHmE7dL7fUCH
         iK3YFB6iOZK4wfqxX5rDUu+AJYfquTZ39CFFp8DdyjgwmdlZIbLyLKHShzbVKfyGaGlY
         NuAKqsRjlWglin97TisSnzhOs6+Q3gl+y5Mxs7EqjQgeNUs9/5VptJSQXKQBhGEtcpMs
         i0Nj2TSsJR11DSY/A+/l/PTH99ZHRG5Srsv3MPwjea8X1gMvLfx8CXwGvHBm+Re/Slxy
         bzaQ==
X-Gm-Message-State: AOAM533f6BjZ72GZReFNBXmAUn+Pt8zuYzeMj6J5R1rDC8mVyehj7Lt7
        mP3+vRbr9rs6XbxtQ42IBAG1KzqC3IOSTBIevEG6Bg==
X-Google-Smtp-Source: ABdhPJymQSOKf855e7dfllaefJZ/lv3bCjmLAxuMnHWvIuClKGxEYglMyqZaP4fn7g0f7+FddB96W87/zPbulc5iUYc=
X-Received: by 2002:a05:6402:f1b:b0:42d:e92f:c924 with SMTP id
 i27-20020a0564020f1b00b0042de92fc924mr1936092eda.389.1654072625416; Wed, 01
 Jun 2022 01:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220523065909.883444-1-hsinyi@chromium.org> <20220523065909.883444-4-hsinyi@chromium.org>
 <20220531134740.91ae4dcea1e06640ba1bfc12@linux-foundation.org> <e4de2e23-bbb8-369f-fa3b-4f4e296ab494@squashfs.org.uk>
In-Reply-To: <e4de2e23-bbb8-369f-fa3b-4f4e296ab494@squashfs.org.uk>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 1 Jun 2022 16:36:39 +0800
Message-ID: <CAJMQK-iAZARENZsOxjBvxHJw5DJOjpL_zkzW19_cA9BsHc6SGQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] squashfs: implement readahead
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
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

On Wed, Jun 1, 2022 at 9:08 AM Phillip Lougher <phillip@squashfs.org.uk> wrote:
>
> On 31/05/2022 21:47, Andrew Morton wrote:
> > On Mon, 23 May 2022 14:59:13 +0800 Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> >> Implement readahead callback for squashfs. It will read datablocks
> >> which cover pages in readahead request. For a few cases it will
> >> not mark page as uptodate, including:
> >> - file end is 0.
> >> - zero filled blocks.
> >> - current batch of pages isn't in the same datablock or not enough in a
> >>    datablock.
> >> - decompressor error.
> >> Otherwise pages will be marked as uptodate. The unhandled pages will be
> >> updated by readpage later.
> >>
> >> ...
> >>
> >
> > The choice of types seems somewhat confused.
> >
> >> @@ -495,7 +496,95 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
> >>      return 0;
> >>   }
> >>
> >> +static void squashfs_readahead(struct readahead_control *ractl)
> >> +{
> >> +    struct inode *inode = ractl->mapping->host;
> >> +    struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
> >> +    size_t mask = (1UL << msblk->block_log) - 1;
> >> +    size_t shift = msblk->block_log - PAGE_SHIFT;
> >
> > block_log is unsigned short.  Why size_t?

Will update in the next version.

> >
> >> +    loff_t start = readahead_pos(ractl) &~ mask;
> >> +    size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
> >> +    struct squashfs_page_actor *actor;
> >> +    unsigned int nr_pages = 0;
> >
> > OK.
> >
> >> +    struct page **pages;
> >> +    u64 block = 0;
> >> +    int bsize, res, i, index, bytes, expected;
> >
> > `res' could be local to the inner loop.
> >
> > `i' is used in situations where an unsigned type would be more
> > appropriate.  If it is made unsigned then `i' is no longer a suitable
> > identifier.  Doesn't matter much.
> >
> > `index' is from page.index, which is pgoff_t.
> >
> > `bytes' could be local to the innermost loop.
> >
> > `expected' is inappropriately a signed type and could be local to the
> > inner loop.

Will update them in the next version.
> >
> >> +    int file_end = i_size_read(inode) >> msblk->block_log;
> >> +    unsigned int max_pages = 1UL << shift;
> >> +    void *pageaddr;
> >> +
>
> pageaddr could be made local to the innermost scope.
>
Will update them in the next version.

Thanks for your comments.

> Apart from that the patch and updated error handling looks
> good.
>
> Phillip
>
> >> +    readahead_expand(ractl, start, (len | mask) + 1);
> >> +
> >> +    if (file_end == 0)
> >> +            return;
> >> +
> >> +    pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
> >> +    if (!pages)
> >> +            return;
> >> +
> >> +    actor = squashfs_page_actor_init_special(pages, max_pages, 0);
> >> +    if (!actor)
> >> +            goto out;
> >> +
> >> +    for (;;) {
> >> +            nr_pages = __readahead_batch(ractl, pages, max_pages);
> >> +            if (!nr_pages)
> >> +                    break;
> >> +
> >> +            if (readahead_pos(ractl) >= i_size_read(inode) ||
> >> +                nr_pages < max_pages)
> >> +                    goto skip_pages;
> >> +
> >> +            index = pages[0]->index >> shift;
> >> +            if ((pages[nr_pages - 1]->index >> shift) != index)
> >> +                    goto skip_pages;
> >> +
> >> +            expected = index == file_end ?
> >> +                       (i_size_read(inode) & (msblk->block_size - 1)) :
> >> +                        msblk->block_size;
> >> +
> >> +            bsize = read_blocklist(inode, index, &block);
> >> +            if (bsize == 0)
> >> +                    goto skip_pages;
> >> +
> >> +            res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
> >> +                                     actor);
> >> +
> >> +            if (res == expected) {
> >> +                    /* Last page may have trailing bytes not filled */
> >> +                    bytes = res % PAGE_SIZE;
> >> +                    if (bytes) {
> >> +                            pageaddr = kmap_atomic(pages[nr_pages - 1]);
> >> +                            memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
> >> +                            kunmap_atomic(pageaddr);
> >> +                    }
> >> +
> >> +                    for (i = 0; i < nr_pages; i++)
> >> +                            SetPageUptodate(pages[i]);
> >> +            }
> >
> > res == -EIO is unhandled?
> >
> >> +            for (i = 0; i < nr_pages; i++) {
> >> +                    unlock_page(pages[i]);
> >> +                    put_page(pages[i]);
> >> +            }
> >> +    }
> >> +
> >> +    kfree(actor);
> >> +    kfree(pages);
> >> +    return;
> >> +
> >> +skip_pages:
> >> +    for (i = 0; i < nr_pages; i++) {
> >> +            unlock_page(pages[i]);
> >> +            put_page(pages[i]);
> >> +    }
> >> +
> >> +    kfree(actor);
> >> +out:
> >> +    kfree(pages);
> >> +}
> >>
> >>   const struct address_space_operations squashfs_aops = {
> >> -    .read_folio = squashfs_read_folio
> >> +    .read_folio = squashfs_read_folio,
> >> +    .readahead = squashfs_readahead
> >>   };
> >
>
