Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC9D575931
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbiGOBqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiGOBqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:46:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F6066BB5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:46:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id g17so1972388plh.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oznUv9Gkf0CmbxoEd9D5/ZVJ/8pM7FYkscA40IRZvao=;
        b=OWyK69Gd5g6/baMmC5Jm8dicO84retVIkB+HKn10gq722CY4aROwjCYd7lijRnJrHB
         Fg7yd1bDFXSkFI9aAef0EtKeEYwEI5tgIFuISsZ+BEkkMhdzlSA5xrmHWbnJV/8X7Lt5
         6T+c7HChTah2HMrwcbXniJnd3jMpdtaEOVzTKQsp27ZMQWxA7o52o3/FQ9rKLan61qcw
         PS69ObP7O8PUqZcukoMN4cCJyiehHNpWGpZQUqWZyqcG6A8cWesOMiLXO6JBXvQQZ1hg
         yVsZO8JF2qKE/yUw0afPEEqlIHhrYqPxzedn4VKvv+mzGaaMrBgVgxlHxGa314lFw5U0
         PSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oznUv9Gkf0CmbxoEd9D5/ZVJ/8pM7FYkscA40IRZvao=;
        b=e8BsfQpeXcuiDFlocdNfPIdvrrZVX8xHoP1ymGZeVCpmhJfQNLcMM6nkkUyzC0q+68
         3ZwbU6z+LcHMWvwNiPUcJuypM810rgpuIr4wX22LnFKmcP7ArwSh0rPw/KsGjTYnNgAp
         LAANzoplVzej6F+Tf8Ch45XtM8L77gk7cWEmPDTAMyuWUTluEat9XGGct1Brpn7/l547
         21KXQDgu7Wof/9jPrurw84TJusZYAUR3rWW/UfZqIJjHhepVAwQb3sS53PX+E6+tOGIp
         st1qCsE897U7a4Xb773CC/yaUKGeKUW7+nBH49yOEjxtl7cafDjuF/zOkQpKrXBSTq+W
         oVqQ==
X-Gm-Message-State: AJIora8f5xC0t+Z62ZChdlZ0IXP43jltMeUwCVMjKx71gO3Mqb7YX685
        14t07mL095icSDfsWXy114dVt/VFS6otV/3yPpg=
X-Google-Smtp-Source: AGRyM1s4Scd99vDUoGZ9L/jc/8TdSIRvtEa0PDpNfU18IJAit1GOkW3zHy/IbaJED7XzDyigqPSRrQOuzCSA5nCMBGs=
X-Received: by 2002:a17:903:11c6:b0:167:90e5:59c2 with SMTP id
 q6-20020a17090311c600b0016790e559c2mr11300007plh.50.1657849565027; Thu, 14
 Jul 2022 18:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220606150305.1883410-1-hsinyi@chromium.org> <20220606150305.1883410-4-hsinyi@chromium.org>
 <CAEVVKH_6PEc0CEfVrThO9m3kdcHVA=-i5FXkQTKaCgESVkJpig@mail.gmail.com> <c02886b7-c3c0-aafa-d360-4bf54b972311@squashfs.org.uk>
In-Reply-To: <c02886b7-c3c0-aafa-d360-4bf54b972311@squashfs.org.uk>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Fri, 15 Jul 2022 09:45:38 +0800
Message-ID: <CAEVVKH_NemHoUuH6+Zf+gD5NgY_svGZ87G2XhHoK+1nEpL0sXA@mail.gmail.com>
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xiaohong.qi@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

Sorry for providing my test info so late.

On Fri, Jun 10, 2022 at 3:42 PM Phillip Lougher <phillip@squashfs.org.uk> w=
rote:
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

Please see the test results below, which are from my colleague Xiaohong Qi:

I test file size from  256KB to 5120KB with thread number
1,2,4,8,16,24,32(run ten times and get it=E2=80=99s average value). The rea=
d
performance is shown below. The difference of read performance between
4.18 kernel and 5.10(with squashfs_readahead() patch v7) seems is
caused by the files whose size is litter than 256KB.

                    T1              T2            T4             T8
         T16          T24          T32
All File Size
    4.18         136.8642   100.479    96.5523    96.1569    96.204
 96.0587    96.0519
    5.10-v7    138.474     103.1351  99.9192    99.7091    99.7894
100.2034   100.4447
    Delta        1.6098       2.6561      3.3669      3.5522
3.5854      4.1447      4.3928

Fsize < 256KB
    4.18          21.7949    14.6959    11.639     10.5154    10.14
  10.1092    10.1425
    5.10-v7     23.8629    16.2483    13.1475   12.3697    12.1985
12.8799    13.3292
    Delta         2.068        1.5524      1.5085     1.8543
2.0585     2.7707     3.1867

256KB < Fsize < 512KB
    4.18          11.8042    7.9228     7.6891     7.7924     7.8181
 7.8548     7.8496
    5.10-v7     12.0505    8.2506     8.1557     8.156       8.16
  8.1577     8.1611
    Delta         0.2463      0.3278     0.4666     0.3636     0.3419
  0.3029     0.3115

512KB < Fsize < 1024KB
    4.18           7.7806     5.5496     5.496      5.4912     5.4897
  5.4883     5.6602
    5.10-v7      8.1283     5.8784     5.8486    5.8505     5.8523
5.8511     5.856
    Delta          0.3477     0.3288     0.3526     0.3593     0.3626
  0.3628     0.1958

1024KB < Fsize < 1536KB
    4.18           10.2686    7.5294     7.5012     7.4902     7.4855
  7.4858     7.4851
    5.10-v7      10.5289    7.8486     7.8502     7.8477     7.849
7.8482     7.8542
    Delta          0.2603     0.3192     0.349      0.3575     0.3635
  0.3624     0.3691

1536KB < Fsize < 2048KB
    4.18           5.6439     4.0588     3.9974     3.9946     3.9949
  3.9942     3.9925
    5.10-v7      6.2263     4.6009     4.6062     4.6069     4.6078
4.6074     4.6099
    Delta          0.5824     0.5421     0.6088     0.6123     0.6129
  0.6132     0.6174

2048KB < Fsize < 5120KB
    4.18           34.9166    28.7944    28.7355    28.7192    28.7046
  28.6976    28.69
    5.10-v7      33.8689    27.9726    27.9747    27.9801    27.9849
27.9855    27.9915
    Delta          -1.0477    -0.8218     -0.7608     -0.7391
-0.7197    -0.7121     -0.6985

> 5120KB
    4.18           45.6575    33.8609    33.7512    33.7349    33.7196
  33.7166    33.708
    5.10-v7      45.3494    34.0473    34.0443    34.0692    34.0635
34.0622    34.0599
    Delta          -0.3081     0.1864     0.2931       0.3343
0.3439     0.3456      0.3519

(T1 means test with 1 thread, File size unit: KB, time unit: second,
5.10-v7 means
 we backported squashfs_readahead() v7 patchset on linux 5.10)

The command to test is like:
echo 3 > /proc/sys/vm/drop_caches; sleep 3; time -v find /test/ -type
f -size -256k | xargs -P 32 -i cat {} > /dev/null 2>/dev/null
echo 3 > /proc/sys/vm/drop_caches; sleep 3; time -v find /test/ -type
f -size +256k -size -512k | xargs -P 32 -i cat {} > /dev/null
2>/dev/null

>
> 2. Does the Squashfs parallelism options in the kernel configuration
>     change the behaviour?  Knowing if the number of "decompressors"
>     available changes the difference in performance could be important.

In our ENV, the config SQUASHFS_DECOMP_MULTI_PERCPU is enalbed. There are
12 cpus in our board. We tried to enable CONFIG_SQUASHFS_DECOMP_MULTI and
read files with 2/4/6/8/12/16/24/32 threads, the performance was not
improved and even a bit worse.

>
> 3. Are your Squashfs filesystems built using fragments, or without
>     fragments?  Rebuilding the filesystems without fragments, and
>     observing any different performance, would help to pinpoint
>     where the issue lies.

We didn't use option "-no-fragments" when build the squashfs image.
The steps of build squashfs partition is:
        a. mksquashfs /lib64/ test.squash
        b. lvcreate -L 24M /dev/vg0 -n test -y
        c. dd if=3D/root/test.squash of=3D/dev/vg0/test
        d. mount -t squashfs /dev/vg0/test xxx

When using "-no-fragments", the performance is much worse than with
fragments. As you can see, the test files are from /lib64, most of
them are small files.

>
> 4. What is the block size used in your Squashfs filesystems.  Have
>     you tried changing the block size, and seen what effect
>     it has on the difference in performance between the patches?

We configured CONFIG_SQUASHFS_4K_DEVBLK_SIZE to "y", so the blk size
should be 4k. We didn't try other block sizes because we have identical squ=
ashfs
configs on 4.18 and 5.10.

>
> 5. You don't mention where your Squashfs filesystems are stored.
>     Is this slow media or fast media?

Please see the disk info we are testing on:
    """
    $ hdparm -I /dev/sda1

    /dev/sda1:
    SG_IO: bad/missing sense data, sb[]: 70 00 05 00 00 00 00 0a 00 00
00 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

    ATA device, with non-removable media
    Standards:
    Likely used: 1
    Configuration:
    Logical max current
    cylinders 0 0
    heads 0 0
    sectors/track 0 0
    =E2=80=93
    Logical/Physical Sector size: 512 bytes
    device size with M =3D 1024*1024: 0 MBytes
    device size with M =3D 1000*1000: 0 MBytes
    cache/buffer size =3D unknown
    Capabilities:
    IORDY not likely
    Cannot perform double-word IO
    R/W multiple sector transfer: not supported
    DMA: not supported
    PIO: pio0
    """

>    Have you tried moving
>     the Squashfs filesystems onto different media and observed
>     any difference in performance between the patches?

Sorry, I still didn't get a chance to test on other medias.

>
> The fact of the matter is there are many over-lapping factors
> which affect the performance of squashfs filesystems (like any
> reasonably complex code), which may be elsewhere.  It can only
> take a small change somewhere to have a dramatic affect on
> performance.

We found the performance is improved when running our test after remaking
the partitions with my steps in item 3 above. The following data is the
elapsed times of squashfs_readahead() when reading files before(this status
means we have run the test command many times) and after remaking the
partitions. I captured the data below with ftrace:

Fo 14k file:
Before partition remade     After partition remade:
4352.306 us                      3943.846 us
4321.176 us                      3929.255 us

For 1.8M file:
Before partition remade     After partition remade:
17446.73 us                     16506.58 us
17446.73 us                     16201.32 us
18465.38 us                     17548.96 us
12269.78 us                     11939.09 us
9627.990 us                     9167.052 us

As you can see the elapsed times of squashfs_readahead() got significant
reduction after fresh partitions. We hit same problem on linux 4.18.

By the way, I think my test results that I have ever sent out in v5 thread
is related with if the partitions remade:
https://lore.kernel.org/lkml/20220606150305.1883410-1-hsinyi@chromium.org/T=
/#m5f3f8386eb8b72a1f63b60be37ea2cc6d03c5f84

>
> This is particularly the case with embedded systems, which
> may be short on CPU performance, short on RAM, and have low
> performance media, and be effectively operating on the "edge".
> It can only take a small change, an update for instance, to
> change from performing well to badly.

  Checked cpu usage it's not over 11%. The RAM is also enough:
              total        used        free      shared  buff/cache   avail=
able
Mem:    15837684   531420  11051344      262080     4254920    14858224
Swap:             0

Regards,
Xiongwei


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
> > On Mon, Jun 6, 2022 at 11:03 PM Hsin-Yi Wang <hsinyi@chromium.org> wrot=
e:
> >>
> >> Implement readahead callback for squashfs. It will read datablocks
> >> which cover pages in readahead request. For a few cases it will
> >> not mark page as uptodate, including:
> >> - file end is 0.
> >> - zero filled blocks.
> >> - current batch of pages isn't in the same datablock.
> >> - decompressor error.
> >> Otherwise pages will be marked as uptodate. The unhandled pages will b=
e
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
> >> v4: https://lore.kernel.org/lkml/20220601103922.1338320-4-hsinyi@chrom=
ium.org/
> >> v3: https://lore.kernel.org/lkml/20220523065909.883444-4-hsinyi@chromi=
um.org/
> >> v2: https://lore.kernel.org/lkml/20220517082650.2005840-4-hsinyi@chrom=
ium.org/
> >> v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chrom=
ium.org/
> >> ---
> >>   fs/squashfs/file.c | 124 +++++++++++++++++++++++++++++++++++++++++++=
+-
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
> >>    * Locate cache slot in range [offset, index] for specified inode.  =
If
> >> @@ -495,7 +496,128 @@ static int squashfs_read_folio(struct file *file=
, struct folio *folio)
> >>          return 0;
> >>   }
> >>
> >> +static void squashfs_readahead(struct readahead_control *ractl)
> >> +{
> >> +       struct inode *inode =3D ractl->mapping->host;
> >> +       struct squashfs_sb_info *msblk =3D inode->i_sb->s_fs_info;
> >> +       size_t mask =3D (1UL << msblk->block_log) - 1;
> >> +       unsigned short shift =3D msblk->block_log - PAGE_SHIFT;
> >> +       loff_t start =3D readahead_pos(ractl) & ~mask;
> >> +       size_t len =3D readahead_length(ractl) + readahead_pos(ractl) =
- start;
> >> +       struct squashfs_page_actor *actor;
> >> +       unsigned int nr_pages =3D 0;
> >> +       struct page **pages;
> >> +       int i, file_end =3D i_size_read(inode) >> msblk->block_log;
> >> +       unsigned int max_pages =3D 1UL << shift;
> >> +
> >> +       readahead_expand(ractl, start, (len | mask) + 1);
> >> +
> >> +       if (file_end =3D=3D 0)
> >> +               return;
> >> +
> >> +       pages =3D kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL)=
;
> >> +       if (!pages)
> >> +               return;
> >> +
> >> +       actor =3D squashfs_page_actor_init_special(pages, max_pages, 0=
);
> >> +       if (!actor)
> >> +               goto out;
> >> +
> >> +       for (;;) {
> >> +               pgoff_t index;
> >> +               int res, bsize;
> >> +               u64 block =3D 0;
> >> +               unsigned int expected;
> >> +
> >> +               nr_pages =3D __readahead_batch(ractl, pages, max_pages=
);
> >> +               if (!nr_pages)
> >> +                       break;
> >> +
> >> +               if (readahead_pos(ractl) >=3D i_size_read(inode))
> >> +                       goto skip_pages;
> >> +
> >> +               index =3D pages[0]->index >> shift;
> >> +               if ((pages[nr_pages - 1]->index >> shift) !=3D index)
> >> +                       goto skip_pages;
> >> +
> >> +               expected =3D index =3D=3D file_end ?
> >> +                          (i_size_read(inode) & (msblk->block_size - =
1)) :
> >> +                           msblk->block_size;
> >> +
> >> +               bsize =3D read_blocklist(inode, index, &block);
> >> +               if (bsize =3D=3D 0)
> >> +                       goto skip_pages;
> >> +
> >> +               if (nr_pages < max_pages) {
> >> +                       struct squashfs_cache_entry *buffer;
> >> +                       unsigned int block_mask =3D max_pages - 1;
> >> +                       int offset =3D pages[0]->index - (pages[0]->in=
dex & ~block_mask);
> >> +
> >> +                       buffer =3D squashfs_get_datablock(inode->i_sb,=
 block,
> >> +                                                       bsize);
> >> +                       if (buffer->error) {
> >> +                               squashfs_cache_put(buffer);
> >> +                               goto skip_pages;
> >> +                       }
> >> +
> >> +                       expected -=3D offset * PAGE_SIZE;
> >> +                       for (i =3D 0; i < nr_pages && expected > 0; i+=
+,
> >> +                                               expected -=3D PAGE_SIZ=
E, offset++) {
> >> +                               int avail =3D min_t(int, expected, PAG=
E_SIZE);
> >> +
> >> +                               squashfs_fill_page(pages[i], buffer,
> >> +                                               offset * PAGE_SIZE, av=
ail);
> >> +                               unlock_page(pages[i]);
> >> +                       }
> >> +
> >> +                       squashfs_cache_put(buffer);
> >> +                       continue;
> >> +               }
> >> +
> >> +               res =3D squashfs_read_data(inode->i_sb, block, bsize, =
NULL,
> >> +                                        actor);
> >> +
> >> +               if (res =3D=3D expected) {
> >> +                       int bytes;
> >> +
> >> +                       /* Last page may have trailing bytes not fille=
d */
> >> +                       bytes =3D res % PAGE_SIZE;
> >> +                       if (bytes) {
> >> +                               void *pageaddr;
> >> +
> >> +                               pageaddr =3D kmap_atomic(pages[nr_page=
s - 1]);
> >> +                               memset(pageaddr + bytes, 0, PAGE_SIZE =
- bytes);
> >> +                               kunmap_atomic(pageaddr);
> >> +                       }
> >> +
> >> +                       for (i =3D 0; i < nr_pages; i++) {
> >> +                               flush_dcache_page(pages[i]);
> >> +                               SetPageUptodate(pages[i]);
> >> +                       }
> >> +               }
> >> +
> >> +               for (i =3D 0; i < nr_pages; i++) {
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
> >> +       for (i =3D 0; i < nr_pages; i++) {
> >> +               unlock_page(pages[i]);
> >> +               put_page(pages[i]);
> >> +       }
> >> +
> >> +       kfree(actor);
> >> +out:
> >> +       kfree(pages);
> >> +}
> >>
> >>   const struct address_space_operations squashfs_aops =3D {
> >> -       .read_folio =3D squashfs_read_folio
> >> +       .read_folio =3D squashfs_read_folio,
> >> +       .readahead =3D squashfs_readahead
> >>   };
> >> --
> >> 2.36.1.255.ge46751e96f-goog
> >>
> >>
>
