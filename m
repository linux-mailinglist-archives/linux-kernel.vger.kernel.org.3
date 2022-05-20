Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52E852F458
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 22:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353443AbiETUYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 16:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352457AbiETUYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 16:24:53 -0400
X-Greylist: delayed 166 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 May 2022 13:24:49 PDT
Received: from p3plwbeout06-06.prod.phx3.secureserver.net (p3plsmtp06-06-2.prod.phx3.secureserver.net [97.74.135.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C2D15D310
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:24:49 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.143])
        by :WBEOUT: with ESMTP
        id s98MnyJdZXdlAs98NnxHTT; Fri, 20 May 2022 13:22:03 -0700
X-CMAE-Analysis: v=2.4 cv=MfqpB7zf c=1 sm=1 tr=0 ts=6287f86b
 a=EhJYbXVJKsomWlz4CTV+qA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=FXvPX3liAAAA:8
 a=cm27Pg_UAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=P-IC7800AAAA:8 a=6uq74eNh84PtuNhnpxIA:9 a=QEXdDO2ut3YA:10
 a=UObqyxdv-6Yh2QiB9mM_:22 a=xmb-EsYY8bH0VWELuYED:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=AjGcO6oz07-iQ99wixmX:22 a=d3PnA9EDa4IxuAV0gXij:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  s98MnyJdZXdlA
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp07.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1ns98J-0002dT-TE; Fri, 20 May 2022 21:22:02 +0100
Message-ID: <8ac07f00-2e9e-ef98-f808-bcf62539d2da@squashfs.org.uk>
Date:   Fri, 20 May 2022 21:21:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 3/3] squashfs: implement readahead
To:     Hsin-Yi Wang <hsinyi@chromium.org>
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
References: <20220517082650.2005840-1-hsinyi@chromium.org>
 <20220517082650.2005840-4-hsinyi@chromium.org>
 <CAJMQK-hovwXsuVUDD6-eueD05srWVdx1OWZ9vBdp-bT6De25ig@mail.gmail.com>
 <eef04b7d-6778-ef7e-07a8-a2c916d21fdb@squashfs.org.uk>
 <CAJMQK-ig4QiTP-JqyuSLzWLrOCTKh4tb6D45ksqwMk2bvjkNsQ@mail.gmail.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <CAJMQK-ig4QiTP-JqyuSLzWLrOCTKh4tb6D45ksqwMk2bvjkNsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfNHrbM0B3ZGFlcZBvhBrw1/AKTH/zL0gEUrdbE3e1vb/BQhD1qRoW756c5OL4lqp6ZsY1jeLxBAb2qMMYbnekjc7qoge66kDU0cQafYYq/vZvNPAHEOB
 YMSnz+56czmYi/hP2dEgsSyYd9OjYH3f6XY4UeE225mDtghIf1I3h1w9rstvgsmKMOk04A34CxNlVAgRfKPJBMU23xDHszc+hJo=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 08:38, Hsin-Yi Wang wrote:
> On Fri, May 20, 2022 at 11:02 AM Phillip Lougher
> <phillip@squashfs.org.uk> wrote:
>>
>> On 19/05/2022 09:09, Hsin-Yi Wang wrote:
>>> On Tue, May 17, 2022 at 4:28 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>>>>
>>>> Implement readahead callback for squashfs. It will read datablocks
>>>> which cover pages in readahead request. For a few cases it will
>>>> not mark page as uptodate, including:
>>>> - file end is 0.
>>>> - zero filled blocks.
>>>> - current batch of pages isn't in the same datablock or not enough in a
>>>>     datablock.
>>>> Otherwise pages will be marked as uptodate. The unhandled pages will be
>>>> updated by readpage later.
>>>>
>>>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>>> Reported-by: Matthew Wilcox <willy@infradead.org>
>>>> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
>>>> Reported-by: Xiongwei Song <sxwjean@gmail.com>
>>>> ---
>>>> v1->v2: remove unused check on readahead_expand().
>>>> v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium.org/
>>>> ---
>>>
>>> Hi Phillip and Matthew,
>>>
>>> Regarding the performance issue of this patch, I saw a possible
>>> performance gain if we only read the first block instead of reading
>>> until nr_pages == 0.
>>>
>>> To be more clear, apply the following diff (Please ignore the skipping
>>> of nr_pages check first. This is a demonstration of "only read and
>>> update the first block per readahead call"):
>>>
>>> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
>>> index aad6823f0615..c52f7c4a7cfe 100644
>>> --- a/fs/squashfs/file.c
>>> +++ b/fs/squashfs/file.c
>>> @@ -524,10 +524,8 @@ static void squashfs_readahead(struct
>>> readahead_control *ractl)
>>>           if (!actor)
>>>                   goto out;
>>>
>>> -       for (;;) {
>>> +       {
>>>                   nr_pages = __readahead_batch(ractl, pages, max_pages);
>>> -               if (!nr_pages)
>>> -                       break;
>>>
>>>                   if (readahead_pos(ractl) >= i_size_read(inode) ||
>>>                       nr_pages < max_pages)
>>>
>>>
>>> All the performance numbers:
>>> 1. original: 39s
>>> 2. revert "mm: put readahead pages in cache earlier": 2.8s
>>> 3. v2 of this patch: 2.7s
>>> 4. v2 of this patch and apply the diff: 1.8s
>>>
>>> In my testing data, normally it reads and updates 1~2 blocks per
>>> readahead call. The change might not make sense since the performance
>>> improvement may only happen in certain cases.
>>> What do you think? Or is the performance of the current patch
>>> considered reasonable?
>>
>> It entirely depends on where the speed improvement comes from.
>>
>>   From experience, the speed improvement is probably worthwhile,
>> and probably isn't gained at the expense of worse performance
>> on other work-loads.
>>
>> But this is a guestimate, based on the fact timings 2 and 3
>> (2.8s v 2.7s) are almost identical.  Which implies the v2
>> patch isn't now doing any more work than the previous
>> baseline before the "mm: put readahead pages in cache earlier"
>> patch (*).
>>
>> As such the speed improvement must be coming from increased
>> parallelism.  Such as moving from serially reading the
>> readahead blocks to parallel reading.
>>
> Thanks for the idea. I checked this by offlining other cores until
> only one core exists. Removing loops still results in less time.
> 
> But after counting the #traces lines in squashfs_read_data():
> If we remove the for loop (timings 4), the logs are less: 2.3K lines,
> while v2 (timings 3) has 3.7K (other timings are also around 3.7K), so
> removing loop doesn't look right.

If a lot less data is being read than the other timings, then this does
look incorrect.

> 
> I think v2 should be fine considering the slightly to none regression
> compared to before.
> 

The fact the timings are almost identical implies all that needs
to be done to remove the performance regression has been done.

There are two things missing from the patch which need to
be handled.  These are not related to performance but error
handling and correctness.  So I have waited until now to
raise it.

If you look at the code for file_direct.c::squashfs_readpage_block()

https://elixir.bootlin.com/linux/latest/source/fs/squashfs/file_direct.c#L93

****
	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
	if (res < 0)
		goto mark_errored;

	if (res != expected) {
		res = -EIO;
		goto mark_errored;
	}
****

You will see that it checks for two return conditions from 
squashfs_read_data().

If the decompressor returns error, or if the decompressed block
is different in size to that expected, then this is an error situation
(e.g. corrupted filesystem), and the read is marked as bad.

The current V2 patch doesn't check that the block decompressed
to the correct size (res != expected), and this could mean
filesystem corruption is not detected, which will be an
error handling regression.

Secondly, if you look at
https://elixir.bootlin.com/linux/latest/source/fs/squashfs/file_direct.c#L102

****
	/* Last page may have trailing bytes not filled */
	bytes = res % PAGE_SIZE;
	if (bytes) {
		pageaddr = kmap_atomic(page[pages - 1]);
		memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
		kunmap_atomic(pageaddr);
	}
****

The V2 patch is always reading max_pages, but at the
end of a file the last page may not be a full page.  This
is because the last block may not be complete (i.e. it is
only 126 Kbytes rather than the block_size of 128 Kbytes).

This will leave part of the last page unfilled by the decompressor,
and it should be zero filled, to avoid leaking data to user-space.

Phillip


> Hi Matthew, what do you think? Do you have other comments? If not,
> should I send a v3 to change Xiongwei Song's email address or can you
> help modify it?
> 
> Thanks
> 
>> But, without looking at any trace output, that is just a
>> guestimate.
>>
>> Phillip
>>
>> (*) multiply decompressing the same blocks, which
>>       is the cause of the performance regression.
>>>
>>> Thanks.
>>>
>>> testing env:
>>> - arm64 on kernel 5.10
>>> - data: ~ 300K pack file contains some android files
>>>
>>>>    fs/squashfs/file.c | 77 +++++++++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 76 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
>>>> index a8e495d8eb86..e10a55c5b1eb 100644
>>>> --- a/fs/squashfs/file.c
>>>> +++ b/fs/squashfs/file.c
>>>> @@ -39,6 +39,7 @@
>>>>    #include "squashfs_fs_sb.h"
>>>>    #include "squashfs_fs_i.h"
>>>>    #include "squashfs.h"
>>>> +#include "page_actor.h"
>>>>
>>>>    /*
>>>>     * Locate cache slot in range [offset, index] for specified inode.  If
>>>> @@ -495,7 +496,81 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>>>>           return 0;
>>>>    }
>>>>
>>>> +static void squashfs_readahead(struct readahead_control *ractl)
>>>> +{
>>>> +       struct inode *inode = ractl->mapping->host;
>>>> +       struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>>>> +       size_t mask = (1UL << msblk->block_log) - 1;
>>>> +       size_t shift = msblk->block_log - PAGE_SHIFT;
>>>> +       loff_t start = readahead_pos(ractl) &~ mask;
>>>> +       size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
>>>> +       struct squashfs_page_actor *actor;
>>>> +       unsigned int nr_pages = 0;
>>>> +       struct page **pages;
>>>> +       u64 block = 0;
>>>> +       int bsize, res, i, index;
>>>> +       int file_end = i_size_read(inode) >> msblk->block_log;
>>>> +       unsigned int max_pages = 1UL << shift;
>>>> +
>>>> +       readahead_expand(ractl, start, (len | mask) + 1);
>>>> +
>>>> +       if (file_end == 0)
>>>> +               return;
>>>> +
>>>> +       pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
>>>> +       if (!pages)
>>>> +               return;
>>>> +
>>>> +       actor = squashfs_page_actor_init_special(pages, max_pages, 0);
>>>> +       if (!actor)
>>>> +               goto out;
>>>> +
>>>> +       for (;;) {
>>>> +               nr_pages = __readahead_batch(ractl, pages, max_pages);
>>>> +               if (!nr_pages)
>>>> +                       break;
>>>> +
>>>> +               if (readahead_pos(ractl) >= i_size_read(inode) ||
>>>> +                   nr_pages < max_pages)
>>>> +                       goto skip_pages;
>>>> +
>>>> +               index = pages[0]->index >> shift;
>>>> +               if ((pages[nr_pages - 1]->index >> shift) != index)
>>>> +                       goto skip_pages;
>>>> +
>>>> +               bsize = read_blocklist(inode, index, &block);
>>>> +               if (bsize == 0)
>>>> +                       goto skip_pages;
>>>> +
>>>> +               res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
>>>> +                                        actor);
>>>> +
>>>> +               if (res >= 0)
>>>> +                       for (i = 0; i < nr_pages; i++)
>>>> +                               SetPageUptodate(pages[i]);
>>>> +
>>>> +               for (i = 0; i < nr_pages; i++) {
>>>> +                       unlock_page(pages[i]);
>>>> +                       put_page(pages[i]);
>>>> +               }
>>>> +       }
>>>> +
>>>> +       kfree(actor);
>>>> +       kfree(pages);
>>>> +       return;
>>>> +
>>>> +skip_pages:
>>>> +       for (i = 0; i < nr_pages; i++) {
>>>> +               unlock_page(pages[i]);
>>>> +               put_page(pages[i]);
>>>> +       }
>>>> +
>>>> +       kfree(actor);
>>>> +out:
>>>> +       kfree(pages);
>>>> +}
>>>>
>>>>    const struct address_space_operations squashfs_aops = {
>>>> -       .read_folio = squashfs_read_folio
>>>> +       .read_folio = squashfs_read_folio,
>>>> +       .readahead = squashfs_readahead
>>>>    };
>>>> --
>>>> 2.36.0.550.gb090851708-goog
>>>>
>>

