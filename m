Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FB953EB12
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbiFFLJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiFFLJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:09:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0095B1E4B43
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 04:09:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id s12so21013016ejx.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVB3XbU6kEJk6PZvO2s24tR9BLuUb9YyAtaHVff3Smg=;
        b=kCuKP28lLx9qHmUYTzw63TGSZ4ZLrTo9Mo4fi0LZ0fGgatjpSxWXEcT90a2dn/xtjQ
         mH67EVkxUS+BP3DG8v4cS3paK5FApfdQboxBLbYWVbJbFL0uxVj1SGaEc8s4Px7Lbnew
         w3CZ+PUghhKG76uflkVwMa5C+kn3vscdENOcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVB3XbU6kEJk6PZvO2s24tR9BLuUb9YyAtaHVff3Smg=;
        b=CO4AxrCAgTL6QPyjYf/yb4r/L3iKlgRVRShNbqqkjN01VjM7NdNS6gZxSjkSLWixUN
         viYVo/fgzF3F+K2IPuCzZhD2tYrO9nhzx0WvKMNX3brXKAmKgZ4PHJNMeefmEQHZxKwO
         gaFAMOHytD2TukHzZU2TqN1gzHF89qE/3BiteagSbgytpBRg309MQSb0MQ6JjETnQs+U
         UVesnCLxf0zg34q70ODZnV/hrdBif+k33ItKx3JF+7pwEe5bih1Phzhrn3A/mLbixSGf
         CVrTNhNbrnmBd4t3CmmFkl/CT6Ny6OXRrrU7fAa6NaxU3+xuhAIKDPFI4DFXwu9OWuSH
         UUig==
X-Gm-Message-State: AOAM530Vm+UXtzvrMHiRoXGPwW5LwnOUApBBdq73L2MJeS4SXvAURVB6
        lPETx6DWy6wWkCb/ztcqIKrT3/VkKAGUAqiHVorQNNQdZOc=
X-Google-Smtp-Source: ABdhPJyJPwoCQLz42TcsuXybDtT9fJIguSRG0tgbFV4k6nuX1TO+kFWCGNV1923oYfFqh4WJAVmqflPuyX0lpjJh6eY=
X-Received: by 2002:a17:906:ced1:b0:710:f654:87ef with SMTP id
 si17-20020a170906ced100b00710f65487efmr9799921ejb.194.1654513768335; Mon, 06
 Jun 2022 04:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220601103922.1338320-1-hsinyi@chromium.org> <20220601103922.1338320-4-hsinyi@chromium.org>
 <CGME20220603125421eucas1p17da286a3e7f2d4759aa4c7639dd62f75@eucas1p1.samsung.com>
 <c017d992-2746-045b-47c8-c5b9c3025f1a@samsung.com> <YpoFnROxAwdSScuV@casper.infradead.org>
 <90b228ea-1b0e-d2e8-62be-9ad5802dcce7@samsung.com> <CAJMQK-jDwchHokDZw7k24rGdy7OeUmiVWUCfxBiu1E1dZwuy2Q@mail.gmail.com>
 <Ypoo4WrVx5/YvaXx@casper.infradead.org> <aa54b4cb-e8ee-8c1a-c826-8016f42a5da1@samsung.com>
 <0e84fe64-c993-7f43-ca52-8fee735b0372@squashfs.org.uk> <CAJMQK-ijicqF3P8FC2kvJ4E3JTm237LkqwwZ1VfKD30GPRUYQw@mail.gmail.com>
In-Reply-To: <CAJMQK-ijicqF3P8FC2kvJ4E3JTm237LkqwwZ1VfKD30GPRUYQw@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 6 Jun 2022 19:09:02 +0800
Message-ID: <CAJMQK-haQ92dQ1vrKhySvPx8kRvhKkqvgjG62eQfTZM9sExcag@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] squashfs: implement readahead
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
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
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 5:55 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Mon, Jun 6, 2022 at 11:54 AM Phillip Lougher <phillip@squashfs.org.uk> wrote:
> >
> > On 03/06/2022 16:58, Marek Szyprowski wrote:
> > > Hi Matthew,
> > >
> > > On 03.06.2022 17:29, Matthew Wilcox wrote:
> > >> On Fri, Jun 03, 2022 at 10:55:01PM +0800, Hsin-Yi Wang wrote:
> > >>> On Fri, Jun 3, 2022 at 10:10 PM Marek Szyprowski
> > >>> <m.szyprowski@samsung.com> wrote:
> > >>>> Hi Matthew,
> > >>>>
> > >>>> On 03.06.2022 14:59, Matthew Wilcox wrote:
> > >>>>> On Fri, Jun 03, 2022 at 02:54:21PM +0200, Marek Szyprowski wrote:
> > >>>>>> On 01.06.2022 12:39, Hsin-Yi Wang wrote:
> > >>>>>>> Implement readahead callback for squashfs. It will read datablocks
> > >>>>>>> which cover pages in readahead request. For a few cases it will
> > >>>>>>> not mark page as uptodate, including:
> > >>>>>>> - file end is 0.
> > >>>>>>> - zero filled blocks.
> > >>>>>>> - current batch of pages isn't in the same datablock or not enough in a
> > >>>>>>>       datablock.
> > >>>>>>> - decompressor error.
> > >>>>>>> Otherwise pages will be marked as uptodate. The unhandled pages will be
> > >>>>>>> updated by readpage later.
> > >>>>>>>
> > >>>>>>> Suggested-by: Matthew Wilcox <willy@infradead.org>
> > >>>>>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > >>>>>>> Reported-by: Matthew Wilcox <willy@infradead.org>
> > >>>>>>> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
> > >>>>>>> Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
> > >>>>>>> ---
> > >>>>>> This patch landed recently in linux-next as commit 95f7a26191de
> > >>>>>> ("squashfs: implement readahead"). I've noticed that it causes serious
> > >>>>>> issues on my test systems (various ARM 32bit and 64bit based boards).
> > >>>>>> The easiest way to observe is udev timeout 'waiting for /dev to be fully
> > >>>>>> populated' and prolonged booting time. I'm using squashfs for deploying
> > >>>>>> kernel modules via initrd. Reverting aeefca9dfae7 & 95f7a26191deon on
> > >>>>>> top of the next-20220603 fixes the issue.
> > >>>>> How large are these files?  Just a few kilobytes?
> > >>>> Yes, they are small, most of them are smaller than 16KB, some about
> > >>>> 128KB and a few about 256KB. I've sent a detailed list in private mail.
> > >>>>
> > >>> Hi Marek,
> > >>>
> > >>> Are there any obvious squashfs errors in dmesg? Did you enable
> > >>> CONFIG_SQUASHFS_FILE_DIRECT or CONFIG_SQUASHFS_FILE_CACHE?
> > >> I don't think it's an error problem.  I think it's a short file problem.
> > >>
> > >> As I understand the current code (and apologies for not keeping up
> > >> to date with how the patch is progressing), if the file is less than
> > >> msblk->block_size bytes, we'll leave all the pages as !uptodate, leaving
> > >> them to be brough uptodate by squashfs_read_folio().  So Marek is hitting
> > >> the worst case scenario where we re-read the entire block for each page
> > >> in it.  I think we have to handle this tail case in ->readahead().
> > >
> > > I'm not sure if this is related to reading of small files. There are
> > > only 50 modules being loaded from squashfs volume. I did a quick test of
> > > reading the files.
> > >
> > > Simple file read with this patch:
> > >
> > > root@target:~# time find /initrd/ -type f | while read f; do cat $f
> > >   >/dev/null; done
> > >
> > > real    0m5.865s
> > > user    0m2.362s
> > > sys     0m3.844s
> > >
> > > Without:
> > >
> > > root@target:~# time find /initrd/ -type f | while read f; do cat $f
> > >   >/dev/null; done
> > >
> > > real    0m6.619s
> > > user    0m2.112s
> > > sys     0m4.827s
> > >
> >
> > It has been a four day holiday in the UK (Queen's Platinum Jubilee),
> > hence the delay in responding.
> >
> > The above read use-case is sequential (only one thread/process),
> > whereas the use-case where the slow-down is observed may be
> > parallel (multiple threads/processes entering Squashfs).
> >
> > The above sequential use-case if the small files are held in
> > fragments, will be exhibiting caching behaviour that will
> > ameliorate the case where the same block is being repeatedly
> > re-read for each page in it.  Because each time
> > Squashfs is re-entered handling only a single page, the
> > decompressed block will be found in the fragment
> > cache, eliminating a block decompression for each page.
> >
> > In a parallel use-case the decompressed fragment block
> > may be being eliminated from the cache (by other reading
> > processes), hence forcing the block to be repeatedly
> > decompressed.
> >
> > Hence the slow-down will be much more noticable with a
> > parallel use-case than a sequential use-case.  It also may
> > be why this slipped through testing, if the test cases
> > are purely sequential in nature.
> >
> > So Matthew's previous comment is still the most likely
> > explanation for the slow-down.
> >
> Thanks for the pointers. To deal with short file cases (nr_pages <
> max_pages), Can we refer to squashfs_fill_page() used in
> squashfs_read_cache(), similar to the case where there are missing
> pages on the block?
>
> Directly calling squashfs_read_data() on short files will lead to crash:
>
> Unable to handle kernel paging request at virtual address:
> [   19.244654]  zlib_inflate+0xba4/0x10c8
> [   19.244658]  zlib_uncompress+0x150/0x1bc
> [   19.244662]  squashfs_decompress+0x6c/0xb4
> [   19.244669]  squashfs_read_data+0x1a8/0x298
> [   19.244673]  squashfs_readahead+0x2cc/0x4cc
>
> I also noticed that the function didn't set flush_dcache_page() with
> SetPageUptodate() previously.
>
> Put these 2 issues together:
>

The patch here is not correct. Please ignore it for now. Sorry for the noice.

> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index 658fb98af0cd..27519f1f9045 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -532,8 +532,7 @@ static void squashfs_readahead(struct
> readahead_control *ractl)
>                 if (!nr_pages)
>                         break;
>
> -               if (readahead_pos(ractl) >= i_size_read(inode) ||
> -                   nr_pages < max_pages)
> +               if (readahead_pos(ractl) >= i_size_read(inode))
>                         goto skip_pages;
>
>                 index = pages[0]->index >> shift;
> @@ -548,6 +547,23 @@ static void squashfs_readahead(struct
> readahead_control *ractl)
>                 if (bsize == 0)
>                         goto skip_pages;
>
> +               if (nr_pages < max_pages) {
> +                       struct squashfs_cache_entry *buffer;
> +
> +                       buffer = squashfs_get_datablock(inode->i_sb, block,
> +                                                       bsize);
> +                       if (!buffer->error) {
> +                               for (i = 0; i < nr_pages && expected > 0; i++,
> +                                                       expected -= PAGE_SIZE) {
> +                                       int avail = min_t(int,
> expected, PAGE_SIZE);
> +
> +                                       squashfs_fill_page(pages[i],
> buffer, i * PAGE_SIZE, avail);
> +                               }
> +                       }
> +                       squashfs_cache_put(buffer);
> +                       goto skip_pages;
> +               }
> +
>                 res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
>                                          actor);
>
> @@ -564,8 +580,10 @@ static void squashfs_readahead(struct
> readahead_control *ractl)
>                                 kunmap_atomic(pageaddr);
>                         }
>
> -                       for (i = 0; i < nr_pages; i++)
> +                       for (i = 0; i < nr_pages; i++) {
> +                               flush_dcache_page(pages[i]);
>                                 SetPageUptodate(pages[i]);
> +                       }
>                 }
>
>
> > Phillip
> >
> > > Best regards
> >
