Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6273F4A2B0C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 02:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352076AbiA2Bse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 20:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344830AbiA2Bsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 20:48:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41329C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 17:48:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D23856164D
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 01:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8ED7C340E7;
        Sat, 29 Jan 2022 01:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643420909;
        bh=U4yFyHtwMRnXHRamWfKkGK76Ozd5kjk/jL2nRTJ0Woc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SgNJ3wxqNsT4ys0KRFXW4k41B8pB08uCH0tVI4di5yabwdCTREf6UR8U3YVnWOnRN
         OaMYcSVV6XZgxuZVvy+UemvsuJm6bBHqiVdbIZ5HW4CZ3FyNUEVeztVFgLcn7T2eYI
         mM7G8NB0LtN/N6yiAdoViAs0oGQGXs0kTr1YDnvtPvkb9Mad2HbQBx5JW20dwia7F+
         x2ZY8bOYokrqC0lUp8Vabw1gwIPPRN6BtDYYivhh5uSbilMRGfCWNGQ7iLIjEMkxsa
         ZPVOSxe0T8yNk8YIGX7jNeeiiGyDHyst45goYYlyuMdQB/OqdlMXiEbjyLLLOdj52j
         dT3/wrLvV/B/w==
Message-ID: <51be77f1-6e85-d46d-d0d3-c06d2055a190@kernel.org>
Date:   Sat, 29 Jan 2022 09:48:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] f2fs: fix to avoid potential deadlock
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Zhiguo Niu <zhiguo.niu@unisoc.com>,
        Jing Xia <jing.xia@unisoc.com>
References: <20220127054449.24711-1-chao@kernel.org>
 <YfMVxzdhat01ca7m@google.com>
 <e434b0a4-a66a-eebc-cafc-f0bad03c3fa5@kernel.org>
 <YfSMMpj2GrYXAJK2@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YfSMMpj2GrYXAJK2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/29 8:37, Jaegeuk Kim wrote:
> On 01/28, Chao Yu wrote:
>> On 2022/1/28 5:59, Jaegeuk Kim wrote:
>>> On 01/27, Chao Yu wrote:
>>>> Quoted from Jing Xia's report, there is a potential deadlock may happen
>>>> between kworker and checkpoint as below:
>>>>
>>>> [T:writeback]				[T:checkpoint]
>>>> - wb_writeback
>>>>    - blk_start_plug
>>>> bio contains NodeA was plugged in writeback threads
>>>
>>> I'm still trying to understand more precisely. So, how is it possible to
>>> have bio having node write in this current context?
>>
>> IMO, after above blk_start_plug(), it may plug some inode's node page in kworker
>> during writebacking node_inode's data page (which should be node page)?
> 
> Wasn't that added into a different task->plug?

I'm not sure I've got your concern correctly...

Do you mean NodeA and other IOs from do_writepages() were plugged in
different local plug variables?

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>> 					- do_writepages  -- sync write inodeB, inc wb_sync_req[DATA]
>>>> 					 - f2fs_write_data_pages
>>>> 					  - f2fs_write_single_data_page -- write last dirty page
>>>> 					   - f2fs_do_write_data_page
>>>> 					    - set_page_writeback  -- clear page dirty flag and
>>>> 					    PAGECACHE_TAG_DIRTY tag in radix tree
>>>> 					    - f2fs_outplace_write_data
>>>> 					     - f2fs_update_data_blkaddr
>>>> 					      - f2fs_wait_on_page_writeback -- wait NodeA to writeback here
>>>> 					   - inode_dec_dirty_pages
>>>>    - writeback_sb_inodes
>>>>     - writeback_single_inode
>>>>      - do_writepages
>>>>       - f2fs_write_data_pages -- skip writepages due to wb_sync_req[DATA]
>>>>        - wbc->pages_skipped += get_dirty_pages() -- PAGECACHE_TAG_DIRTY is not set but get_dirty_pages() returns one
>>>>     - requeue_inode -- requeue inode to wb->b_dirty queue due to non-zero.pages_skipped
>>>>    - blk_finish_plug
>>>>
>>>> Let's try to avoid deadlock condition by forcing unplugging previous bio via
>>>> blk_finish_plug(current->plug) once we'v skipped writeback in writepages()
>>>> due to valid sbi->wb_sync_req[DATA/NODE].
>>>>
>>>> Fixes: 687de7f1010c ("f2fs: avoid IO split due to mixed WB_SYNC_ALL and WB_SYNC_NONE")
>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>>> Signed-off-by: Jing Xia <jing.xia@unisoc.com>
>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>> ---
>>>>    fs/f2fs/data.c | 6 +++++-
>>>>    fs/f2fs/node.c | 6 +++++-
>>>>    2 files changed, 10 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index 76d6fe7b0c8f..932a4c81acaf 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -3174,8 +3174,12 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>>>>    	/* to avoid spliting IOs due to mixed WB_SYNC_ALL and WB_SYNC_NONE */
>>>>    	if (wbc->sync_mode == WB_SYNC_ALL)
>>>>    		atomic_inc(&sbi->wb_sync_req[DATA]);
>>>> -	else if (atomic_read(&sbi->wb_sync_req[DATA]))
>>>> +	else if (atomic_read(&sbi->wb_sync_req[DATA])) {
>>>> +		/* to avoid potential deadlock */
>>>> +		if (current->plug)
>>>> +			blk_finish_plug(current->plug);
>>>>    		goto skip_write;
>>>> +	}
>>>>    	if (__should_serialize_io(inode, wbc)) {
>>>>    		mutex_lock(&sbi->writepages);
>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>>> index 556fcd8457f3..69c6bcaf5aae 100644
>>>> --- a/fs/f2fs/node.c
>>>> +++ b/fs/f2fs/node.c
>>>> @@ -2106,8 +2106,12 @@ static int f2fs_write_node_pages(struct address_space *mapping,
>>>>    	if (wbc->sync_mode == WB_SYNC_ALL)
>>>>    		atomic_inc(&sbi->wb_sync_req[NODE]);
>>>> -	else if (atomic_read(&sbi->wb_sync_req[NODE]))
>>>> +	else if (atomic_read(&sbi->wb_sync_req[NODE])) {
>>>> +		/* to avoid potential deadlock */
>>>> +		if (current->plug)
>>>> +			blk_finish_plug(current->plug);
>>>>    		goto skip_write;
>>>> +	}
>>>>    	trace_f2fs_writepages(mapping->host, wbc, NODE);
>>>> -- 
>>>> 2.32.0
