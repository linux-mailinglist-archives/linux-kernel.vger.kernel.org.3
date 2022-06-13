Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C152547D74
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 03:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiFMBg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 21:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiFMBg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 21:36:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE1719E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 18:36:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x4so4475110pfj.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 18:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YgK1P4DnNw03xrma17RflN05RYina1qu+Lfry/mE4p0=;
        b=SQm8IgtngUd3X6rpwGRQDpf1E8DFnr+h6Czci9SQB0sLh22/YezNBzbHhzEhytHi7i
         OhxeJ5Mvm7BLcKi+qJ5ZSwKc7WswfGDvrqQ7xSq98NmtRCLtN3FIZB0+b4AWDXoRIGGm
         CLfI5rHO/yB0Zt59fxuVtnKLNHAzZGOzC5HaOETm4ddEQepWXic4w8lRqDLQXbMJs4I/
         zPX72TYpOr4oSXcVPgR2xXUPAQ/uPSA9UmQE47Q29iVAhUals0EX0CBp+wMRCkJ+Kh2U
         qTm1cACr0LMiqH5EDOW3HMRp1+jjwjqjUjN+VjSKjvxs7+h7yYGOw89e9nLZ+PAjQYgr
         ouJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YgK1P4DnNw03xrma17RflN05RYina1qu+Lfry/mE4p0=;
        b=FZZleuVW2eZ11iyGo5j6dWiVrx2DQ6DOZhCAyPZ7+H2MDKEvxCbJHc34NzooSHaQ9J
         cITePKsWmTghj0nbbiUqcoHQMQh4F1K7YcgUBdV5NXukUiU8Gl95A5liE9znvmkRiHRx
         P4COuNYEYNQsIlGo/5xTBNowJpySjJJnzpu2XcR93WRlpvbRu7QDhjP6AwlPtF1KfQr0
         Es2QCxuEDrttGglVkGMwGS+MG3MapI28snAMpCrPLW/YOotGZl+gtDmdYvuRO1yXReQz
         L0ReK1dzmJl0s8hPXfnGPvbA2I9RAzfoZ9nDBQopQNrWGWHpzQWAng8naMDc7+RL7PJf
         85Vg==
X-Gm-Message-State: AOAM531MXIbC/rG33LlGIR5QmGXAY1lKERZcvOgafB434MWWgQgHVT1M
        9Sy7/sbosi/RsvhYvPULwh2DHi46axf6vuB/EGw=
X-Google-Smtp-Source: ABdhPJy66UHxUTU5YwgSJD2tRzNLLJJg4Fs8nwZsmGxNuhfYq7AXlsqoyXjW1O0zS3ya+JkzImh1jCJgnQ6MieN1/wM=
X-Received: by 2002:a05:6a00:244a:b0:4fa:ebf9:75de with SMTP id
 d10-20020a056a00244a00b004faebf975demr57514716pfj.73.1655084214692; Sun, 12
 Jun 2022 18:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220606150305.1883410-1-hsinyi@chromium.org> <20220606150305.1883410-4-hsinyi@chromium.org>
 <CAEVVKH_6PEc0CEfVrThO9m3kdcHVA=-i5FXkQTKaCgESVkJpig@mail.gmail.com> <c02886b7-c3c0-aafa-d360-4bf54b972311@squashfs.org.uk>
In-Reply-To: <c02886b7-c3c0-aafa-d360-4bf54b972311@squashfs.org.uk>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Mon, 13 Jun 2022 09:36:28 +0800
Message-ID: <CAEVVKH9J7rwSbx6JB-Uby=9DXB5NwsueMr_Qrj-pSSbc3ex+7Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] squashfs: implement readahead
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
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

Hi,

On Fri, Jun 10, 2022 at 3:42 PM Phillip Lougher <phillip@squashfs.org.uk> wrote:
>
> On 09/06/2022 15:46, Xiongwei Song wrote:
> > This version is bad for my test. I ran the test below
> > "for cnt in $(seq 0 9); do echo 3 > /proc/sys/vm/drop_caches; echo
> > "Loop ${cnt}:"; time -v find /software/test[0-9][0-9] | xargs -P 24 -i
> > cat {} > /dev/null 2>/dev/null; echo ""; done"
> > in 90 partitions.
> >
> > With 9eec1d897139 reverted:
> > 1:06.18 (1m + 6.18s)
> > 1:05.65
> > 1:06.34
> > 1:06.88
> > 1:06.52
> > 1:06.78
> > 1:06.61
> > 1:06.99
> > 1:06.60
> > 1:06.79
> >
> > With this version:
> > 2:36.85 (2m + 36.85s)
> > 2:28.89
> > 1:43.46
> > 1:41.50
> > 1:42.75
> > 1:43.46
> > 1:43.67
> > 1:44.41
> > 1:44.91
> > 1:45.44
> >
> > Any thoughts?
>
> Thank-you for your latest test results, and they tend to
> imply that the latest version of the patch hasn't improved
> performance in your use-case.
>
> One thing which is becoming clear here is that the devil is in
> the detail, and your results being summaries are not capturing
> enough detail to understand what is happening.  They show
> something is wrong, but, don't give any guidance as to what
> is happening.
>
> I think it will be difficult to capture more details from
> your test case.  But, detail can be captured from summaries, by
> varying the input and extrapolating from the results.
>
> By that I mean have you tried changing anything, and observed any
> changed results?
>
> For instance have you tried any of the following
>
> 1.  Changing the parallelism of your test from 24 read threads.
>      Does 1, 2, 4 etc parallel read threads change the observed
>      behaviour?  In other words is the slow-down observed across
>      all degrees of parallelism, or is there a critical point.
>
> 2. Does the Squashfs parallelism options in the kernel configuration
>     change the behaviour?  Knowing if the number of "decompressors"
>     available changes the difference in performance could be important.
>
> 3. Are your Squashfs filesystems built using fragments, or without
>     fragments?  Rebuilding the filesystems without fragments, and
>     observing any different performance, would help to pinpoint
>     where the issue lies.
>
> 4. What is the block size used in your Squashfs filesystems.  Have
>     you tried changing the block size, and seen what effect
>     it has on the difference in performance between the patches?
>
> 5. You don't mention where your Squashfs filesystems are stored.
>     Is this slow media or fast media?  Have you tried moving
>     the Squashfs filesystems onto different media and observed
>     any difference in performance between the patches?
>

Thanks for your response and inputs.  I really appreciated your help.
 I can try these things  but can't provide the detailed results for
now because I'm busy with a few things, hence It's hard to focus
on this one thing for me.

> The fact of the matter is there are many over-lapping factors
> which affect the performance of Squashfs filesystems (like any
> reasonably complex code), which may be elsewhere.  It can only
> take a small change somewhere to have a dramatic affect on
> performance.
>
> This is particularly the case with embedded systems, which
> may be short on CPU performance, short on RAM, and have low
> performance media, and be effectively operating on the "edge".
> It can only take a small change, an update for instance, to
> change from performing well to badly.

Totally agree.

>
> I speak from experience, having spent over ten years in embedded
> Linux as a senior engineer and then as a consultant.  I have
> my own horror tales as a consultant, dealing with systems pushed
> beyond the edge (with hacks), and the customer insisting they
> didn't do anything to cause the system to finally break.
>
> Maybe it is off topic here.  But, I remember one instance where
> a customer had a system out in the field, which "inexplicably"
> started to lock up every 6 months or so.  This system had regular
> updates "over the air", and I discovered the "lock up" only
> started happening after the latest update.  It turns out the new version
> of the application had grown a new feature which needed more
> RAM than normal.  This feature wasn't used very often, but,
> if it coincided with an infrequent "house-keeping" background task,
> the system ran out of memory and locked up (they had disabled the OOM
> killer).  This was so rare it might only coincide after six months.  No
> bug, but a slow growth in working set RAM over a number of versions.
>
> In other words we may be looking at a knock-on side effect of
> readahead, which is either caused by issues elsewhere or is
> causing issues elsewhere.
>
> Dealing with it in isolation, as bug in the readahead code is going
> to get us nowhere, looking for something that isn't there.
>
> I'm not saying that this is the case here.  But, the more detail
> you can provide, and the more test variants you can provide will
> help to determine what is the problem.

Thanks for your sharing. I will provide detail later.

Regards,
Xiongwei

>
> Thanks
>
> Phillip
>
>
> >
> > Regards,
> > Xiongwei
> >
> > On Mon, Jun 6, 2022 at 11:03 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >>
> >> Implement readahead callback for squashfs. It will read datablocks
> >> which cover pages in readahead request. For a few cases it will
> >> not mark page as uptodate, including:
> >> - file end is 0.
> >> - zero filled blocks.
> >> - current batch of pages isn't in the same datablock.
> >> - decompressor error.
> >> Otherwise pages will be marked as uptodate. The unhandled pages will be
> >> updated by readpage later.
> >>
> >> Suggested-by: Matthew Wilcox <willy@infradead.org>
> >> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >> Reported-by: Matthew Wilcox <willy@infradead.org>
> >> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
> >> Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
> >> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Reported-by: Andrew Morton <akpm@linux-foundation.org>
> >> ---
> >> v4->v5:
> >> - Handle short file cases reported by Marek and Matthew.
> >> - Fix checkpatch error reported by Andrew.
> >>
> >> v4: https://lore.kernel.org/lkml/20220601103922.1338320-4-hsinyi@chromium.org/
> >> v3: https://lore.kernel.org/lkml/20220523065909.883444-4-hsinyi@chromium.org/
> >> v2: https://lore.kernel.org/lkml/20220517082650.2005840-4-hsinyi@chromium.org/
> >> v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium.org/
> >> ---
> >>   fs/squashfs/file.c | 124 ++++++++++++++++++++++++++++++++++++++++++++-
> >>   1 file changed, 123 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> >> index a8e495d8eb86..fbd096cd15f4 100644
> >> --- a/fs/squashfs/file.c
> >> +++ b/fs/squashfs/file.c
> >> @@ -39,6 +39,7 @@
> >>   #include "squashfs_fs_sb.h"
> >>   #include "squashfs_fs_i.h"
> >>   #include "squashfs.h"
> >> +#include "page_actor.h"
> >>
> >>   /*
> >>    * Locate cache slot in range [offset, index] for specified inode.  If
> >> @@ -495,7 +496,128 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
> >>          return 0;
> >>   }
> >>
> >> +static void squashfs_readahead(struct readahead_control *ractl)
> >> +{
> >> +       struct inode *inode = ractl->mapping->host;
> >> +       struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
> >> +       size_t mask = (1UL << msblk->block_log) - 1;
> >> +       unsigned short shift = msblk->block_log - PAGE_SHIFT;
> >> +       loff_t start = readahead_pos(ractl) & ~mask;
> >> +       size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
> >> +       struct squashfs_page_actor *actor;
> >> +       unsigned int nr_pages = 0;
> >> +       struct page **pages;
> >> +       int i, file_end = i_size_read(inode) >> msblk->block_log;
> >> +       unsigned int max_pages = 1UL << shift;
> >> +
> >> +       readahead_expand(ractl, start, (len | mask) + 1);
> >> +
> >> +       if (file_end == 0)
> >> +               return;
> >> +
> >> +       pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
> >> +       if (!pages)
> >> +               return;
> >> +
> >> +       actor = squashfs_page_actor_init_special(pages, max_pages, 0);
> >> +       if (!actor)
> >> +               goto out;
> >> +
> >> +       for (;;) {
> >> +               pgoff_t index;
> >> +               int res, bsize;
> >> +               u64 block = 0;
> >> +               unsigned int expected;
> >> +
> >> +               nr_pages = __readahead_batch(ractl, pages, max_pages);
> >> +               if (!nr_pages)
> >> +                       break;
> >> +
> >> +               if (readahead_pos(ractl) >= i_size_read(inode))
> >> +                       goto skip_pages;
> >> +
> >> +               index = pages[0]->index >> shift;
> >> +               if ((pages[nr_pages - 1]->index >> shift) != index)
> >> +                       goto skip_pages;
> >> +
> >> +               expected = index == file_end ?
> >> +                          (i_size_read(inode) & (msblk->block_size - 1)) :
> >> +                           msblk->block_size;
> >> +
> >> +               bsize = read_blocklist(inode, index, &block);
> >> +               if (bsize == 0)
> >> +                       goto skip_pages;
> >> +
> >> +               if (nr_pages < max_pages) {
> >> +                       struct squashfs_cache_entry *buffer;
> >> +                       unsigned int block_mask = max_pages - 1;
> >> +                       int offset = pages[0]->index - (pages[0]->index & ~block_mask);
> >> +
> >> +                       buffer = squashfs_get_datablock(inode->i_sb, block,
> >> +                                                       bsize);
> >> +                       if (buffer->error) {
> >> +                               squashfs_cache_put(buffer);
> >> +                               goto skip_pages;
> >> +                       }
> >> +
> >> +                       expected -= offset * PAGE_SIZE;
> >> +                       for (i = 0; i < nr_pages && expected > 0; i++,
> >> +                                               expected -= PAGE_SIZE, offset++) {
> >> +                               int avail = min_t(int, expected, PAGE_SIZE);
> >> +
> >> +                               squashfs_fill_page(pages[i], buffer,
> >> +                                               offset * PAGE_SIZE, avail);
> >> +                               unlock_page(pages[i]);
> >> +                       }
> >> +
> >> +                       squashfs_cache_put(buffer);
> >> +                       continue;
> >> +               }
> >> +
> >> +               res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
> >> +                                        actor);
> >> +
> >> +               if (res == expected) {
> >> +                       int bytes;
> >> +
> >> +                       /* Last page may have trailing bytes not filled */
> >> +                       bytes = res % PAGE_SIZE;
> >> +                       if (bytes) {
> >> +                               void *pageaddr;
> >> +
> >> +                               pageaddr = kmap_atomic(pages[nr_pages - 1]);
> >> +                               memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
> >> +                               kunmap_atomic(pageaddr);
> >> +                       }
> >> +
> >> +                       for (i = 0; i < nr_pages; i++) {
> >> +                               flush_dcache_page(pages[i]);
> >> +                               SetPageUptodate(pages[i]);
> >> +                       }
> >> +               }
> >> +
> >> +               for (i = 0; i < nr_pages; i++) {
> >> +                       unlock_page(pages[i]);
> >> +                       put_page(pages[i]);
> >> +               }
> >> +       }
> >> +
> >> +       kfree(actor);
> >> +       kfree(pages);
> >> +       return;
> >> +
> >> +skip_pages:
> >> +       for (i = 0; i < nr_pages; i++) {
> >> +               unlock_page(pages[i]);
> >> +               put_page(pages[i]);
> >> +       }
> >> +
> >> +       kfree(actor);
> >> +out:
> >> +       kfree(pages);
> >> +}
> >>
> >>   const struct address_space_operations squashfs_aops = {
> >> -       .read_folio = squashfs_read_folio
> >> +       .read_folio = squashfs_read_folio,
> >> +       .readahead = squashfs_readahead
> >>   };
> >> --
> >> 2.36.1.255.ge46751e96f-goog
> >>
> >>
>
