Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA74C530AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiEWHX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiEWHWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:22:17 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA95FD13
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:13:52 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id j7so1999652vsp.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9UkTAjLMqC/CtrhNDarVLoFGGkUR7Tt19k80EOtxRE8=;
        b=aCBkVFsRWNr28CopDM73cM4KAj/85Qvxiq/tyeO6j+KIX3qtRIlj77OOTO1H5iyuBr
         1ujVpwRhiY8hHDUIMvwvWUKLmcx5PFqk086fZw1OFbRs/YfJaCS8FLFHpXVuSZf1vuBi
         Nr2Q2NUjAOCd/29ZtcpurW2Z3vrh8AWQDS5TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9UkTAjLMqC/CtrhNDarVLoFGGkUR7Tt19k80EOtxRE8=;
        b=2Lg/VsgbMsmN1/WXOD298aJ4ddY7hVPsPMogNBCmQ6KHfbVQhar28NzdIWAalnXJlb
         n15/Uvi8EcF0ZN2pMod6pMpuhvV8T3ep89xOzMHs5d9IKHZY0mE/d/oVcGecJf3MJe+c
         0Q8vcReWpkbSMCqkYKR4REpCNfbp/2XP9gpJUvJL88yAtNjENGGQImcgE2aUW6rD8YFp
         ESbCUNxywFSUc6XxQVaAi62N12OdMWvnDmHg0tWzzhPz8+iIZiR0TddIGsNU9UO815oF
         SLYvVypjCUhJie1NsAIAf8npvKAA2xCSJi7kTFKUNBf42UdvBiBGmZAXXQveGab1a7jG
         hAFg==
X-Gm-Message-State: AOAM531MzRWiiFLHRSBjReF+tUI076VJ5ku3Px7Q1yrpKqv+nBUNynJ1
        hMFeiSEvuwWlhGxstKVjAaJ3xjj4/p9A9ek8YPt2ef6kIsY=
X-Google-Smtp-Source: ABdhPJy9l+YhOoCiDVJ0wj7674V7uWHHjjYFhjHGb8DHefA9ivXx6WBJL+51nXOC0KR40/bGgLA0JGRrTGlzinaxFMI=
X-Received: by 2002:a67:d488:0:b0:337:ad51:776a with SMTP id
 g8-20020a67d488000000b00337ad51776amr1637380vsj.80.1653289284739; Mon, 23 May
 2022 00:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220517082650.2005840-1-hsinyi@chromium.org> <20220517082650.2005840-4-hsinyi@chromium.org>
 <CAJMQK-hovwXsuVUDD6-eueD05srWVdx1OWZ9vBdp-bT6De25ig@mail.gmail.com>
 <eef04b7d-6778-ef7e-07a8-a2c916d21fdb@squashfs.org.uk> <CAJMQK-ig4QiTP-JqyuSLzWLrOCTKh4tb6D45ksqwMk2bvjkNsQ@mail.gmail.com>
 <8ac07f00-2e9e-ef98-f808-bcf62539d2da@squashfs.org.uk>
In-Reply-To: <8ac07f00-2e9e-ef98-f808-bcf62539d2da@squashfs.org.uk>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 23 May 2022 15:00:58 +0800
Message-ID: <CAJMQK-iBYwb6q6ZQosRdLMfHgpaCpbq39yPOc3WUH+18UcE5ag@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] squashfs: implement readahead
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 4:22 AM Phillip Lougher <phillip@squashfs.org.uk> wrote:
>
> On 20/05/2022 08:38, Hsin-Yi Wang wrote:
> > On Fri, May 20, 2022 at 11:02 AM Phillip Lougher
> > <phillip@squashfs.org.uk> wrote:
> >>
> >> On 19/05/2022 09:09, Hsin-Yi Wang wrote:
> >>> On Tue, May 17, 2022 at 4:28 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >>>>
> >>>> Implement readahead callback for squashfs. It will read datablocks
> >>>> which cover pages in readahead request. For a few cases it will
> >>>> not mark page as uptodate, including:
> >>>> - file end is 0.
> >>>> - zero filled blocks.
> >>>> - current batch of pages isn't in the same datablock or not enough in a
> >>>>     datablock.
> >>>> Otherwise pages will be marked as uptodate. The unhandled pages will be
> >>>> updated by readpage later.
> >>>>
> >>>> Suggested-by: Matthew Wilcox <willy@infradead.org>
> >>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >>>> Reported-by: Matthew Wilcox <willy@infradead.org>
> >>>> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
> >>>> Reported-by: Xiongwei Song <sxwjean@gmail.com>
> >>>> ---
> >>>> v1->v2: remove unused check on readahead_expand().
> >>>> v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium.org/
> >>>> ---
> >>>
> >>> Hi Phillip and Matthew,
> >>>
> >>> Regarding the performance issue of this patch, I saw a possible
> >>> performance gain if we only read the first block instead of reading
> >>> until nr_pages == 0.
> >>>
> >>> To be more clear, apply the following diff (Please ignore the skipping
> >>> of nr_pages check first. This is a demonstration of "only read and
> >>> update the first block per readahead call"):
> >>>
> >>> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> >>> index aad6823f0615..c52f7c4a7cfe 100644
> >>> --- a/fs/squashfs/file.c
> >>> +++ b/fs/squashfs/file.c
> >>> @@ -524,10 +524,8 @@ static void squashfs_readahead(struct
> >>> readahead_control *ractl)
> >>>           if (!actor)
> >>>                   goto out;
> >>>
> >>> -       for (;;) {
> >>> +       {
> >>>                   nr_pages = __readahead_batch(ractl, pages, max_pages);
> >>> -               if (!nr_pages)
> >>> -                       break;
> >>>
> >>>                   if (readahead_pos(ractl) >= i_size_read(inode) ||
> >>>                       nr_pages < max_pages)
> >>>
> >>>
> >>> All the performance numbers:
> >>> 1. original: 39s
> >>> 2. revert "mm: put readahead pages in cache earlier": 2.8s
> >>> 3. v2 of this patch: 2.7s
> >>> 4. v2 of this patch and apply the diff: 1.8s
> >>>
> >>> In my testing data, normally it reads and updates 1~2 blocks per
> >>> readahead call. The change might not make sense since the performance
> >>> improvement may only happen in certain cases.
> >>> What do you think? Or is the performance of the current patch
> >>> considered reasonable?
> >>
> >> It entirely depends on where the speed improvement comes from.
> >>
> >>   From experience, the speed improvement is probably worthwhile,
> >> and probably isn't gained at the expense of worse performance
> >> on other work-loads.
> >>
> >> But this is a guestimate, based on the fact timings 2 and 3
> >> (2.8s v 2.7s) are almost identical.  Which implies the v2
> >> patch isn't now doing any more work than the previous
> >> baseline before the "mm: put readahead pages in cache earlier"
> >> patch (*).
> >>
> >> As such the speed improvement must be coming from increased
> >> parallelism.  Such as moving from serially reading the
> >> readahead blocks to parallel reading.
> >>
> > Thanks for the idea. I checked this by offlining other cores until
> > only one core exists. Removing loops still results in less time.
> >
> > But after counting the #traces lines in squashfs_read_data():
> > If we remove the for loop (timings 4), the logs are less: 2.3K lines,
> > while v2 (timings 3) has 3.7K (other timings are also around 3.7K), so
> > removing loop doesn't look right.
>
> If a lot less data is being read than the other timings, then this does
> look incorrect.
>
> >
> > I think v2 should be fine considering the slightly to none regression
> > compared to before.
> >
>
> The fact the timings are almost identical implies all that needs
> to be done to remove the performance regression has been done.
>
> There are two things missing from the patch which need to
> be handled.  These are not related to performance but error
> handling and correctness.  So I have waited until now to
> raise it.
>
> If you look at the code for file_direct.c::squashfs_readpage_block()
>
> https://elixir.bootlin.com/linux/latest/source/fs/squashfs/file_direct.c#L93
>
> ****
>         res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
>         if (res < 0)
>                 goto mark_errored;
>
>         if (res != expected) {
>                 res = -EIO;
>                 goto mark_errored;
>         }
> ****
>
> You will see that it checks for two return conditions from
> squashfs_read_data().
>
> If the decompressor returns error, or if the decompressed block
> is different in size to that expected, then this is an error situation
> (e.g. corrupted filesystem), and the read is marked as bad.
>
> The current V2 patch doesn't check that the block decompressed
> to the correct size (res != expected), and this could mean
> filesystem corruption is not detected, which will be an
> error handling regression.
>
Thanks for the review. In v3:

Added the check to see if the returned size is expected too. Since we
didn't mark error pages here (in readahead), if the size wasn't
expected, we just don't mark the page as Uptodate.

> Secondly, if you look at
> https://elixir.bootlin.com/linux/latest/source/fs/squashfs/file_direct.c#L102
>
> ****
>         /* Last page may have trailing bytes not filled */
>         bytes = res % PAGE_SIZE;
>         if (bytes) {
>                 pageaddr = kmap_atomic(page[pages - 1]);
>                 memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
>                 kunmap_atomic(pageaddr);
>         }
> ****
>
> The V2 patch is always reading max_pages, but at the
> end of a file the last page may not be a full page.  This
> is because the last block may not be complete (i.e. it is
> only 126 Kbytes rather than the block_size of 128 Kbytes).
>
> This will leave part of the last page unfilled by the decompressor,
> and it should be zero filled, to avoid leaking data to user-space.

If the size was expected, further check if it's not a full page. If
so, fill it with zeros at the end.

Performance is the same as v2.


>
> Phillip
>
>
> > Hi Matthew, what do you think? Do you have other comments? If not,
> > should I send a v3 to change Xiongwei Song's email address or can you
> > help modify it?
> >
> > Thanks
> >
> >> But, without looking at any trace output, that is just a
> >> guestimate.
> >>
> >> Phillip
> >>
> >> (*) multiply decompressing the same blocks, which
> >>       is the cause of the performance regression.
> >>>
> >>> Thanks.
> >>>
> >>> testing env:
> >>> - arm64 on kernel 5.10
> >>> - data: ~ 300K pack file contains some android files
> >>>
> >>>>    fs/squashfs/file.c | 77 +++++++++++++++++++++++++++++++++++++++++++++-
> >>>>    1 file changed, 76 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> >>>> index a8e495d8eb86..e10a55c5b1eb 100644
> >>>> --- a/fs/squashfs/file.c
> >>>> +++ b/fs/squashfs/file.c
> >>>> @@ -39,6 +39,7 @@
> >>>>    #include "squashfs_fs_sb.h"
> >>>>    #include "squashfs_fs_i.h"
> >>>>    #include "squashfs.h"
> >>>> +#include "page_actor.h"
> >>>>
> >>>>    /*
> >>>>     * Locate cache slot in range [offset, index] for specified inode.  If
> >>>> @@ -495,7 +496,81 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
> >>>>           return 0;
> >>>>    }
> >>>>
> >>>> +static void squashfs_readahead(struct readahead_control *ractl)
> >>>> +{
> >>>> +       struct inode *inode = ractl->mapping->host;
> >>>> +       struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
> >>>> +       size_t mask = (1UL << msblk->block_log) - 1;
> >>>> +       size_t shift = msblk->block_log - PAGE_SHIFT;
> >>>> +       loff_t start = readahead_pos(ractl) &~ mask;
> >>>> +       size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
> >>>> +       struct squashfs_page_actor *actor;
> >>>> +       unsigned int nr_pages = 0;
> >>>> +       struct page **pages;
> >>>> +       u64 block = 0;
> >>>> +       int bsize, res, i, index;
> >>>> +       int file_end = i_size_read(inode) >> msblk->block_log;
> >>>> +       unsigned int max_pages = 1UL << shift;
> >>>> +
> >>>> +       readahead_expand(ractl, start, (len | mask) + 1);
> >>>> +
> >>>> +       if (file_end == 0)
> >>>> +               return;
> >>>> +
> >>>> +       pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
> >>>> +       if (!pages)
> >>>> +               return;
> >>>> +
> >>>> +       actor = squashfs_page_actor_init_special(pages, max_pages, 0);
> >>>> +       if (!actor)
> >>>> +               goto out;
> >>>> +
> >>>> +       for (;;) {
> >>>> +               nr_pages = __readahead_batch(ractl, pages, max_pages);
> >>>> +               if (!nr_pages)
> >>>> +                       break;
> >>>> +
> >>>> +               if (readahead_pos(ractl) >= i_size_read(inode) ||
> >>>> +                   nr_pages < max_pages)
> >>>> +                       goto skip_pages;
> >>>> +
> >>>> +               index = pages[0]->index >> shift;
> >>>> +               if ((pages[nr_pages - 1]->index >> shift) != index)
> >>>> +                       goto skip_pages;
> >>>> +
> >>>> +               bsize = read_blocklist(inode, index, &block);
> >>>> +               if (bsize == 0)
> >>>> +                       goto skip_pages;
> >>>> +
> >>>> +               res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
> >>>> +                                        actor);
> >>>> +
> >>>> +               if (res >= 0)
> >>>> +                       for (i = 0; i < nr_pages; i++)
> >>>> +                               SetPageUptodate(pages[i]);
> >>>> +
> >>>> +               for (i = 0; i < nr_pages; i++) {
> >>>> +                       unlock_page(pages[i]);
> >>>> +                       put_page(pages[i]);
> >>>> +               }
> >>>> +       }
> >>>> +
> >>>> +       kfree(actor);
> >>>> +       kfree(pages);
> >>>> +       return;
> >>>> +
> >>>> +skip_pages:
> >>>> +       for (i = 0; i < nr_pages; i++) {
> >>>> +               unlock_page(pages[i]);
> >>>> +               put_page(pages[i]);
> >>>> +       }
> >>>> +
> >>>> +       kfree(actor);
> >>>> +out:
> >>>> +       kfree(pages);
> >>>> +}
> >>>>
> >>>>    const struct address_space_operations squashfs_aops = {
> >>>> -       .read_folio = squashfs_read_folio
> >>>> +       .read_folio = squashfs_read_folio,
> >>>> +       .readahead = squashfs_readahead
> >>>>    };
> >>>> --
> >>>> 2.36.0.550.gb090851708-goog
> >>>>
> >>
>
