Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE64545DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346615AbiFJHmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243900AbiFJHma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:42:30 -0400
Received: from p3plwbeout26-05.prod.phx3.secureserver.net (p3plsmtp26-05-2.prod.phx3.secureserver.net [216.69.139.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B108C13AF10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:42:24 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.141])
        by :WBEOUT: with ESMTP
        id zZHincTYauX6jzZHjn5XZG; Fri, 10 Jun 2022 00:42:23 -0700
X-CMAE-Analysis: v=2.4 cv=X5eXlEfe c=1 sm=1 tr=0 ts=62a2f5df
 a=bheWAUFm1xGnSTQFbH9Kqg==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=cm27Pg_UAAAA:8
 a=JfrnYn6hAAAA:8 a=FXvPX3liAAAA:8 a=t7CeM3EgAAAA:8 a=hD80L64hAAAA:8
 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=mp5Xolt3UYJuYFoM8lsA:9 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22 a=1CNFftbPRP8L7MoqJWF3:22 a=UObqyxdv-6Yh2QiB9mM_:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  zZHincTYauX6j
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp04.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1nzZHd-00067r-NR; Fri, 10 Jun 2022 08:42:22 +0100
Message-ID: <c02886b7-c3c0-aafa-d360-4bf54b972311@squashfs.org.uk>
Date:   Fri, 10 Jun 2022 08:42:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 3/3] squashfs: implement readahead
To:     Xiongwei Song <sxwjean@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
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
References: <20220606150305.1883410-1-hsinyi@chromium.org>
 <20220606150305.1883410-4-hsinyi@chromium.org>
 <CAEVVKH_6PEc0CEfVrThO9m3kdcHVA=-i5FXkQTKaCgESVkJpig@mail.gmail.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <CAEVVKH_6PEc0CEfVrThO9m3kdcHVA=-i5FXkQTKaCgESVkJpig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfIHUnsNDGqqM1veR6Fug5phtjfRpGzkDAcUnUqIQ70SV4Ru/ekXxaBWwS4HH00kvWngqmZiQ06OCpG2wOSq3S4QLmnqA/FD+oirgfGcZj+p+2wr5WOrl
 wr03OCEYsu44TGz1dY8nDsqtcMzVpuQZC/mUZ7qH2QLQWP4HLMQ4deIA1jq7VCo1dUCsPo+jP1WaE1hPasV6vTGGo1gFECoB+n8=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 15:46, Xiongwei Song wrote:
> This version is bad for my test. I ran the test below
> "for cnt in $(seq 0 9); do echo 3 > /proc/sys/vm/drop_caches; echo
> "Loop ${cnt}:"; time -v find /software/test[0-9][0-9] | xargs -P 24 -i
> cat {} > /dev/null 2>/dev/null; echo ""; done"
> in 90 partitions.
> 
> With 9eec1d897139 reverted:
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

Thank-you for your latest test results, and they tend to
imply that the latest version of the patch hasn't improved
performance in your use-case.

One thing which is becoming clear here is that the devil is in
the detail, and your results being summaries are not capturing
enough detail to understand what is happening.  They show
something is wrong, but, don't give any guidance as to what
is happening.

I think it will be difficult to capture more details from
your test case.  But, detail can be captured from summaries, by
varying the input and extrapolating from the results.

By that I mean have you tried changing anything, and observed any
changed results?

For instance have you tried any of the following

1.  Changing the parallelism of your test from 24 read threads.
     Does 1, 2, 4 etc parallel read threads change the observed
     behaviour?  In other words is the slow-down observed across
     all degrees of parallelism, or is there a critical point.

2. Does the Squashfs parallelism options in the kernel configuration
    change the behaviour?  Knowing if the number of "decompressors"
    available changes the difference in performance could be important.

3. Are your Squashfs filesystems built using fragments, or without
    fragments?  Rebuilding the filesystems without fragments, and
    observing any different performance, would help to pinpoint
    where the issue lies.

4. What is the block size used in your Squashfs filesystems.  Have
    you tried changing the block size, and seen what effect
    it has on the difference in performance between the patches?

5. You don't mention where your Squashfs filesystems are stored.
    Is this slow media or fast media?  Have you tried moving
    the Squashfs filesystems onto different media and observed
    any difference in performance between the patches?

The fact of the matter is there are many over-lapping factors
which affect the performance of Squashfs filesystems (like any
reasonably complex code), which may be elsewhere.  It can only
take a small change somewhere to have a dramatic affect on
performance.

This is particularly the case with embedded systems, which
may be short on CPU performance, short on RAM, and have low
performance media, and be effectively operating on the "edge".
It can only take a small change, an update for instance, to
change from performing well to badly.

I speak from experience, having spent over ten years in embedded
Linux as a senior engineer and then as a consultant.  I have
my own horror tales as a consultant, dealing with systems pushed
beyond the edge (with hacks), and the customer insisting they
didn't do anything to cause the system to finally break.

Maybe it is off topic here.  But, I remember one instance where
a customer had a system out in the field, which "inexplicably"
started to lock up every 6 months or so.  This system had regular
updates "over the air", and I discovered the "lock up" only
started happening after the latest update.  It turns out the new version
of the application had grown a new feature which needed more
RAM than normal.  This feature wasn't used very often, but,
if it coincided with an infrequent "house-keeping" background task,
the system ran out of memory and locked up (they had disabled the OOM
killer).  This was so rare it might only coincide after six months.  No
bug, but a slow growth in working set RAM over a number of versions.

In other words we may be looking at a knock-on side effect of
readahead, which is either caused by issues elsewhere or is
causing issues elsewhere.

Dealing with it in isolation, as bug in the readahead code is going
to get us nowhere, looking for something that isn't there.

I'm not saying that this is the case here.  But, the more detail
you can provide, and the more test variants you can provide will
help to determine what is the problem.

Thanks

Phillip


> 
> Regards,
> Xiongwei
> 
> On Mon, Jun 6, 2022 at 11:03 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>>
>> Implement readahead callback for squashfs. It will read datablocks
>> which cover pages in readahead request. For a few cases it will
>> not mark page as uptodate, including:
>> - file end is 0.
>> - zero filled blocks.
>> - current batch of pages isn't in the same datablock.
>> - decompressor error.
>> Otherwise pages will be marked as uptodate. The unhandled pages will be
>> updated by readpage later.
>>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> Reported-by: Matthew Wilcox <willy@infradead.org>
>> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
>> Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Reported-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>> v4->v5:
>> - Handle short file cases reported by Marek and Matthew.
>> - Fix checkpatch error reported by Andrew.
>>
>> v4: https://lore.kernel.org/lkml/20220601103922.1338320-4-hsinyi@chromium.org/
>> v3: https://lore.kernel.org/lkml/20220523065909.883444-4-hsinyi@chromium.org/
>> v2: https://lore.kernel.org/lkml/20220517082650.2005840-4-hsinyi@chromium.org/
>> v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium.org/
>> ---
>>   fs/squashfs/file.c | 124 ++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 123 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
>> index a8e495d8eb86..fbd096cd15f4 100644
>> --- a/fs/squashfs/file.c
>> +++ b/fs/squashfs/file.c
>> @@ -39,6 +39,7 @@
>>   #include "squashfs_fs_sb.h"
>>   #include "squashfs_fs_i.h"
>>   #include "squashfs.h"
>> +#include "page_actor.h"
>>
>>   /*
>>    * Locate cache slot in range [offset, index] for specified inode.  If
>> @@ -495,7 +496,128 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>>          return 0;
>>   }
>>
>> +static void squashfs_readahead(struct readahead_control *ractl)
>> +{
>> +       struct inode *inode = ractl->mapping->host;
>> +       struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>> +       size_t mask = (1UL << msblk->block_log) - 1;
>> +       unsigned short shift = msblk->block_log - PAGE_SHIFT;
>> +       loff_t start = readahead_pos(ractl) & ~mask;
>> +       size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
>> +       struct squashfs_page_actor *actor;
>> +       unsigned int nr_pages = 0;
>> +       struct page **pages;
>> +       int i, file_end = i_size_read(inode) >> msblk->block_log;
>> +       unsigned int max_pages = 1UL << shift;
>> +
>> +       readahead_expand(ractl, start, (len | mask) + 1);
>> +
>> +       if (file_end == 0)
>> +               return;
>> +
>> +       pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
>> +       if (!pages)
>> +               return;
>> +
>> +       actor = squashfs_page_actor_init_special(pages, max_pages, 0);
>> +       if (!actor)
>> +               goto out;
>> +
>> +       for (;;) {
>> +               pgoff_t index;
>> +               int res, bsize;
>> +               u64 block = 0;
>> +               unsigned int expected;
>> +
>> +               nr_pages = __readahead_batch(ractl, pages, max_pages);
>> +               if (!nr_pages)
>> +                       break;
>> +
>> +               if (readahead_pos(ractl) >= i_size_read(inode))
>> +                       goto skip_pages;
>> +
>> +               index = pages[0]->index >> shift;
>> +               if ((pages[nr_pages - 1]->index >> shift) != index)
>> +                       goto skip_pages;
>> +
>> +               expected = index == file_end ?
>> +                          (i_size_read(inode) & (msblk->block_size - 1)) :
>> +                           msblk->block_size;
>> +
>> +               bsize = read_blocklist(inode, index, &block);
>> +               if (bsize == 0)
>> +                       goto skip_pages;
>> +
>> +               if (nr_pages < max_pages) {
>> +                       struct squashfs_cache_entry *buffer;
>> +                       unsigned int block_mask = max_pages - 1;
>> +                       int offset = pages[0]->index - (pages[0]->index & ~block_mask);
>> +
>> +                       buffer = squashfs_get_datablock(inode->i_sb, block,
>> +                                                       bsize);
>> +                       if (buffer->error) {
>> +                               squashfs_cache_put(buffer);
>> +                               goto skip_pages;
>> +                       }
>> +
>> +                       expected -= offset * PAGE_SIZE;
>> +                       for (i = 0; i < nr_pages && expected > 0; i++,
>> +                                               expected -= PAGE_SIZE, offset++) {
>> +                               int avail = min_t(int, expected, PAGE_SIZE);
>> +
>> +                               squashfs_fill_page(pages[i], buffer,
>> +                                               offset * PAGE_SIZE, avail);
>> +                               unlock_page(pages[i]);
>> +                       }
>> +
>> +                       squashfs_cache_put(buffer);
>> +                       continue;
>> +               }
>> +
>> +               res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
>> +                                        actor);
>> +
>> +               if (res == expected) {
>> +                       int bytes;
>> +
>> +                       /* Last page may have trailing bytes not filled */
>> +                       bytes = res % PAGE_SIZE;
>> +                       if (bytes) {
>> +                               void *pageaddr;
>> +
>> +                               pageaddr = kmap_atomic(pages[nr_pages - 1]);
>> +                               memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
>> +                               kunmap_atomic(pageaddr);
>> +                       }
>> +
>> +                       for (i = 0; i < nr_pages; i++) {
>> +                               flush_dcache_page(pages[i]);
>> +                               SetPageUptodate(pages[i]);
>> +                       }
>> +               }
>> +
>> +               for (i = 0; i < nr_pages; i++) {
>> +                       unlock_page(pages[i]);
>> +                       put_page(pages[i]);
>> +               }
>> +       }
>> +
>> +       kfree(actor);
>> +       kfree(pages);
>> +       return;
>> +
>> +skip_pages:
>> +       for (i = 0; i < nr_pages; i++) {
>> +               unlock_page(pages[i]);
>> +               put_page(pages[i]);
>> +       }
>> +
>> +       kfree(actor);
>> +out:
>> +       kfree(pages);
>> +}
>>
>>   const struct address_space_operations squashfs_aops = {
>> -       .read_folio = squashfs_read_folio
>> +       .read_folio = squashfs_read_folio,
>> +       .readahead = squashfs_readahead
>>   };
>> --
>> 2.36.1.255.ge46751e96f-goog
>>
>>

