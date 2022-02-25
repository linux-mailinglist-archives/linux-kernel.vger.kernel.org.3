Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CA54C3C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbiBYDCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiBYDCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:02:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986F41C8869
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:02:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3219C61687
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B08AC340E9;
        Fri, 25 Feb 2022 03:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645758129;
        bh=GCfS0bK+I5I3lEZQRQftSGQK5WqxhpxFrjnWKkAWjZA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=QFL8Yh7vbeIGlR+R0CFQftd+sZ0lsyVOTa/808axopWHCppLI/fz9B5pMVGC6tyJ/
         OTl+sMsa7GpoL8UkEwZuUyviAcdDhEiLXgVBVvzQLZNz9Tv7OTDZPZw9mLQR27H6HF
         EFMoPjHpx7AV8+S6Lqhz77vYWI4pG+W8Unem+65NtbY4+Xn3S7zq3OL/uXWoLqDmZT
         JA25uo/FWSH+pDC7c/DM4Qde442vP6+4uypnXZAUcsQdcmsQ+IfVwfcxIVwt9gabXh
         vSLIqsPHoOwlvJN6QFMsT+/zLOg7rveRn1fQIchPaMvoF6gzE7eczFOsUI++GdDvmq
         Bhea/SzC10VXQ==
Message-ID: <5b5e20d1-877f-b321-b341-c0f233ee976c@kernel.org>
Date:   Fri, 25 Feb 2022 11:02:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid potential deadlock
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Jing Xia <jing.xia@unisoc.com>, Zhiguo Niu <zhiguo.niu@unisoc.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220127054449.24711-1-chao@kernel.org>
 <YfMVxzdhat01ca7m@google.com>
 <e434b0a4-a66a-eebc-cafc-f0bad03c3fa5@kernel.org>
 <YfSMMpj2GrYXAJK2@google.com>
 <51be77f1-6e85-d46d-d0d3-c06d2055a190@kernel.org>
 <Yfs1KRgwgzSOvocR@google.com>
 <86a175d3-c438-505b-1dbc-4ef6e8b5adcb@kernel.org>
In-Reply-To: <86a175d3-c438-505b-1dbc-4ef6e8b5adcb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/3 22:57, Chao Yu wrote:
> On 2022/2/3 9:51, Jaegeuk Kim wrote:
>> On 01/29, Chao Yu wrote:
>>> On 2022/1/29 8:37, Jaegeuk Kim wrote:
>>>> On 01/28, Chao Yu wrote:
>>>>> On 2022/1/28 5:59, Jaegeuk Kim wrote:
>>>>>> On 01/27, Chao Yu wrote:
>>>>>>> Quoted from Jing Xia's report, there is a potential deadlock may happen
>>>>>>> between kworker and checkpoint as below:
>>>>>>>
>>>>>>> [T:writeback]                [T:checkpoint]
>>>>>>> - wb_writeback
>>>>>>>     - blk_start_plug
>>>>>>> bio contains NodeA was plugged in writeback threads
>>>>>>
>>>>>> I'm still trying to understand more precisely. So, how is it possible to
>>>>>> have bio having node write in this current context?
>>>>>
>>>>> IMO, after above blk_start_plug(), it may plug some inode's node page in kworker
>>>>> during writebacking node_inode's data page (which should be node page)?
>>>>
>>>> Wasn't that added into a different task->plug?
>>>
>>> I'm not sure I've got your concern correctly...
>>>
>>> Do you mean NodeA and other IOs from do_writepages() were plugged in
>>> different local plug variables?
>>
>> I think so.
> 
> I guess block plug helper says it doesn't allow to use nested plug, so there
> is only one plug in kworker thread?
> 
> void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
> {
>      struct task_struct *tsk = current;
> 
>      /*
>       * If this is a nested plug, don't actually assign it.
>       */
>      if (tsk->plug)
>          return;
> ...
> }

Any further comments?

Thanks,

> 
> Thanks,
> 
>>
>>>
>>> Thanks,
>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>>>                     - do_writepages  -- sync write inodeB, inc wb_sync_req[DATA]
>>>>>>>                      - f2fs_write_data_pages
>>>>>>>                       - f2fs_write_single_data_page -- write last dirty page
>>>>>>>                        - f2fs_do_write_data_page
>>>>>>>                         - set_page_writeback  -- clear page dirty flag and
>>>>>>>                         PAGECACHE_TAG_DIRTY tag in radix tree
>>>>>>>                         - f2fs_outplace_write_data
>>>>>>>                          - f2fs_update_data_blkaddr
>>>>>>>                           - f2fs_wait_on_page_writeback -- wait NodeA to writeback here
>>>>>>>                        - inode_dec_dirty_pages
>>>>>>>     - writeback_sb_inodes
>>>>>>>      - writeback_single_inode
>>>>>>>       - do_writepages
>>>>>>>        - f2fs_write_data_pages -- skip writepages due to wb_sync_req[DATA]
>>>>>>>         - wbc->pages_skipped += get_dirty_pages() -- PAGECACHE_TAG_DIRTY is not set but get_dirty_pages() returns one
>>>>>>>      - requeue_inode -- requeue inode to wb->b_dirty queue due to non-zero.pages_skipped
>>>>>>>     - blk_finish_plug
>>>>>>>
>>>>>>> Let's try to avoid deadlock condition by forcing unplugging previous bio via
>>>>>>> blk_finish_plug(current->plug) once we'v skipped writeback in writepages()
>>>>>>> due to valid sbi->wb_sync_req[DATA/NODE].
>>>>>>>
>>>>>>> Fixes: 687de7f1010c ("f2fs: avoid IO split due to mixed WB_SYNC_ALL and WB_SYNC_NONE")
>>>>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>>>>>> Signed-off-by: Jing Xia <jing.xia@unisoc.com>
>>>>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>>>>> ---
>>>>>>>     fs/f2fs/data.c | 6 +++++-
>>>>>>>     fs/f2fs/node.c | 6 +++++-
>>>>>>>     2 files changed, 10 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>>>> index 76d6fe7b0c8f..932a4c81acaf 100644
>>>>>>> --- a/fs/f2fs/data.c
>>>>>>> +++ b/fs/f2fs/data.c
>>>>>>> @@ -3174,8 +3174,12 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>>>>>>>         /* to avoid spliting IOs due to mixed WB_SYNC_ALL and WB_SYNC_NONE */
>>>>>>>         if (wbc->sync_mode == WB_SYNC_ALL)
>>>>>>>             atomic_inc(&sbi->wb_sync_req[DATA]);
>>>>>>> -    else if (atomic_read(&sbi->wb_sync_req[DATA]))
>>>>>>> +    else if (atomic_read(&sbi->wb_sync_req[DATA])) {
>>>>>>> +        /* to avoid potential deadlock */
>>>>>>> +        if (current->plug)
>>>>>>> +            blk_finish_plug(current->plug);
>>>>>>>             goto skip_write;
>>>>>>> +    }
>>>>>>>         if (__should_serialize_io(inode, wbc)) {
>>>>>>>             mutex_lock(&sbi->writepages);
>>>>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>>>>>> index 556fcd8457f3..69c6bcaf5aae 100644
>>>>>>> --- a/fs/f2fs/node.c
>>>>>>> +++ b/fs/f2fs/node.c
>>>>>>> @@ -2106,8 +2106,12 @@ static int f2fs_write_node_pages(struct address_space *mapping,
>>>>>>>         if (wbc->sync_mode == WB_SYNC_ALL)
>>>>>>>             atomic_inc(&sbi->wb_sync_req[NODE]);
>>>>>>> -    else if (atomic_read(&sbi->wb_sync_req[NODE]))
>>>>>>> +    else if (atomic_read(&sbi->wb_sync_req[NODE])) {
>>>>>>> +        /* to avoid potential deadlock */
>>>>>>> +        if (current->plug)
>>>>>>> +            blk_finish_plug(current->plug);
>>>>>>>             goto skip_write;
>>>>>>> +    }
>>>>>>>         trace_f2fs_writepages(mapping->host, wbc, NODE);
>>>>>>> -- 
>>>>>>> 2.32.0
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
