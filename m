Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D31478E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhLQOo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbhLQOo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:44:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDF9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 06:44:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49179621F9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 14:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6FEC36AE1;
        Fri, 17 Dec 2021 14:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639752295;
        bh=b3+gCykY1dUkHW8+a815nEF3WybWz0Du+ysQp05AYPc=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=JHc0n6tEQthnAEArfH5wsb83o7AXV4bFbbmw46yhv+J3owCyOZW8IH7HsbOikm3Ez
         oKXhpXZEUaKDhMdKaRJCN/wLE9zbjoC+KJoYjfyE3K5jY/dbTdXAy+IOvPv/CACd0m
         a95FtDSfXPL4IAPhR8UT+kC4X5EynMuckP2uUwCu/+zCzNET4c4i0X4Y04bABxEf/a
         0HB3ANNjN6A6nSMMHv52fi+eh3RjR3PuRFwAXZInMAjRVi9wbAIrjU7St6bdLP9DRs
         IfbGlFXob+7+72my0ylCRC/Y0D+W1yFogN/jzfLzNb6ai02tcKMQSdsnK4vZycV51K
         5r+T72VJQhsUA==
Message-ID: <00db09fe-122a-2c2c-1c6c-b6987db3d78b@kernel.org>
Date:   Fri, 17 Dec 2021 22:44:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [f2fs-dev] [PATCH Vx 1/1] f2fs: Avoid deadlock between writeback
 and checkpoint
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, niuzhiguo84@gmail.com
Cc:     Jing.Xia@unisoc.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <1636438608-27597-1-git-send-email-niuzhiguo84@gmail.com>
 <YZU0TFBH6k2Q6fJZ@google.com>
 <e28d4963-d816-b568-dec8-60a79a9fe88d@kernel.org>
 <e25053e9-f97e-6a2f-3bac-acfcd689fdcb@kernel.org>
In-Reply-To: <e25053e9-f97e-6a2f-3bac-acfcd689fdcb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/20 9:50, Chao Yu wrote:
> On 2021/11/18 14:46, Chao Yu wrote:
>> On 2021/11/18 0:56, Jaegeuk Kim wrote:
>>> On 11/09, niuzhiguo84@gmail.com wrote:
>>>> From: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>>>
>>>> There could be a scenario as following:
>>>> The inodeA and inodeB are in b_io queue of writeback
>>>> inodeA : f2fs's node inode
>>>> inodeB : a dir inode with only one dirty pages, and the node page
>>>> of inodeB cached into inodeA
>>>>
>>>> writeback:
>>>>
>>>> wb_workfn
>>>> wb_writeback
>>>> blk_start_plug
>>>>            loop {
>>>>            queue_io
>>>>            progress=__writeback_inodes_wb
>>>>                    __writeback_single_inode
>>>>                            do_writepages
>>>>                                    f2fs_write_data_pages
>>>>                                    wbc->pages_skipped +=get_dirty_pages
>>>>                            inode->i_state &= ~dirty
>>>>                    wrote++
>>>>                    requeue_inode
>>>>            }
>>>> blk_finish_plug
>>>>
>>>> checkpoint:
>>>>
>>>> f2fs_write_checkpoint
>>>> f2fs_sync_dirty_inodes
>>>> filemap_fdatawrite
>>>> do_writepages
>>>> f2fs_write_data_pages
>>>>            f2fs_write_single_data_page
>>>>                    f2fs_do_write_data_page
>>>>                            set_page_writeback
>>>>                            f2fs_outplace_write_data
>>>>                                    f2fs_update_data_blkaddr
>>>>                                            f2fs_wait_on_page_writeback
>>>>                    inode_dec_dirty_pages
>>>>
>>>> 1. Writeback thread flush inodeA, and push it's bio request in task's plug;
>>>> 2. Checkpoint thread writes inodeB's dirty page, and then wait its node
>>>>        page writeback cached into inodeA which is in writeback task's plug
>>>> 3. Writeback thread flush inodeB and skip writing the dirty page as
>>>>        wb_sync_req[DATA] > 0.
>>>> 4. As none of the inodeB's page is marked as PAGECACHE_TAG_DIRTY, writeback
>>>>        thread clear inodeB's dirty state.
>>>> 5. Then inodeB is moved from b_io to b_dirty because of pages_skipped > 0
>>>>        as checkpoint thread is stuck before dec dirty_pages.
>>>>
>>>> This patch collect correct pages_skipped according to the tag state in
>>>> page tree of inode
>>>>
>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>>> Signed-off-by: Jing Xia <jing.xia@unisoc.com>
>>>> ---
>>>>     fs/f2fs/data.c | 4 +++-
>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index f4fd6c246c9a..e98628e3868c 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -3237,7 +3237,9 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>>>>     	return ret;
>>>>     
>>>>     skip_write:
>>>> -	wbc->pages_skipped += get_dirty_pages(inode);
>>>> +	wbc->pages_skipped +=
>>>> +		mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY) ?
>>>
>>> Is there any race condition to get 0, if there's any dirty page? IOWs, it
>>
>> Quoted from Jing Xia's explanation:
>>
>> [T:writeback]				[T:checkpoint]
> 
> My bad, [1] should be here:
> 
> bio contains NodeA was plugged in writeback threads
> 
> Thanks,
> 
>> 					- do_writepages  -- sync write inodeB, inc wb_sync_req[DATA]
>> 					 - f2fs_write_data_pages
>> 					  - f2fs_write_single_data_page -- write last dirty page
>> 					   - f2fs_do_write_data_page
>> 					    - set_page_writeback  -- clear page dirty flag and
>> 					    PAGECACHE_TAG_DIRTY tag in radix tree
>> 					    - f2fs_outplace_write_data
>> 					     - f2fs_update_data_blkaddr
>> 					      - f2fs_wait_on_page_writeback -- wait NodeA to writeback here

Jaegeuk,

checkpoint() will stuck on waiting NodeA to writeback.

>> 					   - inode_dec_dirty_pages
> 
>> bio contains NodeA was plugged in writeback threads
> 
> [1]
> 
> Thanks,
> 
>> - writeback_sb_inodes
>>     - writeback_single_inode
>>      - do_writepages
>>       - f2fs_write_data_pages -- skip writepages due to wb_sync_req[DATA]
>>        - wbc->pages_skipped += get_dirty_pages() -- PAGECACHE_TAG_DIRTY is not set but get_dirty_pages() returns one
>>     - requeue_inode -- requeue inode to wb->b_dirty queue due to non-zero.pages_skipped

Meanwhile, kworker plugged NodeA, and then loop writebacking inode due to
inode will be requeued all the time.

Thanks,

>>
>>> seems the current condition is just requeuing the inode as dirty, but next
>>> flushing time will remove it from dirty list. Is this giving too much overheads?
>>
>> I prefer to let writeback thread call blk_flush_plug() after skipping
>> writepages() due to wb_sync_req[DATA/NODE] check condition, thoughts?
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 9f754aaef558..b6e1ed73f8f5 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -3087,6 +3087,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>>     			/* give a priority to WB_SYNC threads */
>>     			if (atomic_read(&sbi->wb_sync_req[DATA]) &&
>>     					wbc->sync_mode == WB_SYNC_NONE) {
>> +				if (current->plug)
>> +					blk_flush_plug(current->plug, false);
>>     				done = 1;
>>     				break;
>>     			}
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 556fcd8457f3..dd9a817d8dab 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -1946,6 +1946,8 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>>     			if (atomic_read(&sbi->wb_sync_req[NODE]) &&
>>     					wbc->sync_mode == WB_SYNC_NONE) {
>>     				done = 1;
>> +				if (current->plug)
>> +					blk_flush_plug(current->plug, false);
>>     				break;
>>     			}
>>
>>
>>
>> Thanks,
>>
>>>
>>>> +		get_dirty_pages(inode) : 0;
>>>>     	trace_f2fs_writepages(mapping->host, wbc, DATA);
>>>>     	return 0;
>>>>     }
>>>> -- 
>>>> 2.28.0
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
