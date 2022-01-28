Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E255B49F0A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 02:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344672AbiA1Bnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 20:43:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35652 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiA1Bnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:43:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93F95B82104
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EE5C340E5;
        Fri, 28 Jan 2022 01:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643334211;
        bh=TkowqnMfrmwTAcJsGdAvnwq3afg44JpFf1XwkrSPxKo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hk6QOu3rIsQHhDpi2BCWY+cWfyR/YNeg4e14onaDxvIPcbSf2AGlf6qAnUhxUskl2
         1iIsNbwPzfnA/Ttdlirbmi3GsOJdNzX7LuUfl88RP6Sq7tn2yQpQZDJ4SBijNbAmU3
         IK3JxXuC997DZTyXuJRHX0S+0aA2EYth82qNVwAOjQj44AZSiNXG2LoDiXUl8vg9Sp
         YotnMNzAgoaTGyed/vkSusyudJwKrdsNx+4K9MfN+2m6LDwlTSthZZHj2WDNsjTrQ+
         +cL1+ehElCCAzQYHLYZ/hiM7XIqKT7VUWB3T+tGAU++CQqPVBfIAfwluMRpSMsojwF
         gIEn1fqnm5ZLA==
Message-ID: <e434b0a4-a66a-eebc-cafc-f0bad03c3fa5@kernel.org>
Date:   Fri, 28 Jan 2022 09:43:27 +0800
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
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YfMVxzdhat01ca7m@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/28 5:59, Jaegeuk Kim wrote:
> On 01/27, Chao Yu wrote:
>> Quoted from Jing Xia's report, there is a potential deadlock may happen
>> between kworker and checkpoint as below:
>>
>> [T:writeback]				[T:checkpoint]
>> - wb_writeback
>>   - blk_start_plug
>> bio contains NodeA was plugged in writeback threads
> 
> I'm still trying to understand more precisely. So, how is it possible to
> have bio having node write in this current context?

IMO, after above blk_start_plug(), it may plug some inode's node page in kworker
during writebacking node_inode's data page (which should be node page)?

Thanks,

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
>> 					   - inode_dec_dirty_pages
>>   - writeback_sb_inodes
>>    - writeback_single_inode
>>     - do_writepages
>>      - f2fs_write_data_pages -- skip writepages due to wb_sync_req[DATA]
>>       - wbc->pages_skipped += get_dirty_pages() -- PAGECACHE_TAG_DIRTY is not set but get_dirty_pages() returns one
>>    - requeue_inode -- requeue inode to wb->b_dirty queue due to non-zero.pages_skipped
>>   - blk_finish_plug
>>
>> Let's try to avoid deadlock condition by forcing unplugging previous bio via
>> blk_finish_plug(current->plug) once we'v skipped writeback in writepages()
>> due to valid sbi->wb_sync_req[DATA/NODE].
>>
>> Fixes: 687de7f1010c ("f2fs: avoid IO split due to mixed WB_SYNC_ALL and WB_SYNC_NONE")
>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>> Signed-off-by: Jing Xia <jing.xia@unisoc.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/data.c | 6 +++++-
>>   fs/f2fs/node.c | 6 +++++-
>>   2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 76d6fe7b0c8f..932a4c81acaf 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -3174,8 +3174,12 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>>   	/* to avoid spliting IOs due to mixed WB_SYNC_ALL and WB_SYNC_NONE */
>>   	if (wbc->sync_mode == WB_SYNC_ALL)
>>   		atomic_inc(&sbi->wb_sync_req[DATA]);
>> -	else if (atomic_read(&sbi->wb_sync_req[DATA]))
>> +	else if (atomic_read(&sbi->wb_sync_req[DATA])) {
>> +		/* to avoid potential deadlock */
>> +		if (current->plug)
>> +			blk_finish_plug(current->plug);
>>   		goto skip_write;
>> +	}
>>   
>>   	if (__should_serialize_io(inode, wbc)) {
>>   		mutex_lock(&sbi->writepages);
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 556fcd8457f3..69c6bcaf5aae 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -2106,8 +2106,12 @@ static int f2fs_write_node_pages(struct address_space *mapping,
>>   
>>   	if (wbc->sync_mode == WB_SYNC_ALL)
>>   		atomic_inc(&sbi->wb_sync_req[NODE]);
>> -	else if (atomic_read(&sbi->wb_sync_req[NODE]))
>> +	else if (atomic_read(&sbi->wb_sync_req[NODE])) {
>> +		/* to avoid potential deadlock */
>> +		if (current->plug)
>> +			blk_finish_plug(current->plug);
>>   		goto skip_write;
>> +	}
>>   
>>   	trace_f2fs_writepages(mapping->host, wbc, NODE);
>>   
>> -- 
>> 2.32.0
