Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435505A06F5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 03:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiHYBsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 21:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbiHYBrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:47:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD3D9F1B2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 18:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47A3C61ACA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE479C433D6;
        Thu, 25 Aug 2022 01:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661391666;
        bh=ZyTP4Ukh+Rt1oSIgcRAyWWPbfucjwy/cRpC7l3f+cF4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QVZSqqO9mfgICuDCulnsumuk9ZzEZT6MmPzfrFb4VksepHWNp/EhNUqltkrkpN4kJ
         5piRHqXGDW3JBnxADDWGNz3VDcuYofAfBlNyKKd83xr8MQ/+fcUY0GESv5UoX/5nPP
         /FQ65iwWdiO4W5Xa+Rh8SfFD+R7+uOSQpAoSeHn4q1IH31DjcxJJye4PEZkFP73So/
         Oujs3JFvEDWxkE8T4N2G18kzVZTRlZEKW5KWfKg85KWxUi1sVMONJa8SHroFYPdIdq
         qe1dT2GrNK4nRWEdBbTWiWpfYhKXXBRwSNeModOzY+FWxvL2jsDhGfXtrDfT379s+y
         T0V03TZCbzliQ==
Message-ID: <32dd704f-d393-e2bd-c09c-5e49dfea0c5f@kernel.org>
Date:   Thu, 25 Aug 2022 09:41:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: fix wrong dirty page count when
 race between mmap and fallocate.
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Shuqi Zhang <zhangshuqi3@huawei.com>
References: <20220815081555.2961943-1-zhangshuqi3@huawei.com>
 <a364da58-f476-69fd-3f90-448f35c8e151@kernel.org>
 <YwFaTprvOf8ckGsP@google.com> <YwFd/+YPfPz60uWg@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YwFd/+YPfPz60uWg@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/21 6:19, Jaegeuk Kim wrote:
> On 08/20, Jaegeuk Kim wrote:
>> On 08/20, Chao Yu wrote:
>>> On 2022/8/15 16:15, Shuqi Zhang wrote:
>>>> This is a BUG_ON issue as follows when running xfstest-generic-503:
>>>> WARNING: CPU: 21 PID: 1385 at fs/f2fs/inode.c:762 f2fs_evict_inode+0x847/0xaa0
>>>> Modules linked in:
>>>> CPU: 21 PID: 1385 Comm: umount Not tainted 5.19.0-rc5+ #73
>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-4.fc34 04/01/2014
>>>>
>>>> Call Trace:
>>>> evict+0x129/0x2d0
>>>> dispose_list+0x4f/0xb0
>>>> evict_inodes+0x204/0x230
>>>> generic_shutdown_super+0x5b/0x1e0
>>>> kill_block_super+0x29/0x80
>>>> kill_f2fs_super+0xe6/0x140
>>>> deactivate_locked_super+0x44/0xc0
>>>> deactivate_super+0x79/0x90
>>>> cleanup_mnt+0x114/0x1a0
>>>> __cleanup_mnt+0x16/0x20
>>>> task_work_run+0x98/0x100
>>>> exit_to_user_mode_prepare+0x3d0/0x3e0
>>>> syscall_exit_to_user_mode+0x12/0x30
>>>> do_syscall_64+0x42/0x80
>>>> entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>>>
>>>> Function flow analysis when BUG occurs:
>>>> f2fs_fallocate                    mmap
>>>>                                     do_page_fault
>>>>                                       pte_spinlock  // ---lock_pte
>>>>                                       do_wp_page
>>>>                                         wp_page_shared
>>>>                                           pte_unmap_unlock   // unlock_pte
>>>>                                             do_page_mkwrite
>>>>                                             f2fs_vm_page_mkwrite
>>>>                                               down_read(i_mmap_sem)
>>>>                                               lock_page
>>>>                                               if (PageMappedToDisk(page))
>>>>                                                 goto out;
>>>>                                               // set_page_dirty  --NOT RUN
>>>>                                               out: up_read(i_mmap_sem)
>>>>                                             lock_page
>>>>                                           finish_mkwrite_fault // unlock_pte
>>>> f2fs_collapse_range
>>>>     down_write(i_mmap_sem)
>>>>     truncate_pagecache
>>>>       unmap_mapping_pages
>>>>         i_mmap_lock_write // down_write(i_mmap_rwsem)
>>>>           ......
>>>>           zap_pte_range
>>>>             pte_offset_map_lock // ---lock_pte
>>>>             f2fs_set_data_page_dirty
>>>
>>> I didn't get it, why zap_pte_range() can set page dirty w/o lock_page?
>>>
>>> I found it's very easy to reproduce this bug, but previously I never saw this...
>>> is there any code udpate around truncate_pagecache()?
>>
>> Found this.
>>
>> 2637  * The caller must ensure this doesn't race with truncation.  Most will
>> 2638  * simply hold the folio lock, but e.g. zap_pte_range() calls with the
>> 2639  * folio mapped and the pte lock held, which also locks out truncation.
>> 2640  */
>> 2641 bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio)
>> 2642 {
>>
>>>
>>> Thanks,
>>>
>>>>               if (!PageDirty(page)) {
>>>>                                           fault_dirty_shared_page
>>>>                                             f2fs_set_data_page_dirty
>>>>                                               if (!PageDirty(page)) {
>>>>                                                 __set_page_dirty_nobuffer
>>>>                                                 f2fs_update_dirty_page // ++
>>>>                                               }
>>>>                                             unlock_page
>>>>                 __set_page_dirty_nobuffers
>>>>                 f2fs_update_dirty_page // page count++
>>>>               }
>>>>             pte_unmap_unlock  // --unlock_pte
>>>>         i_mmap_unlock_write  // up_write(i_mmap_rwsem)
>>>>     truncate_inode_pages
>>>>     up_write(i_mmap_sem)
>>>>
>>>> When race happens between mmap-do_page_fault-wp_page_shared and
>>>> fallocate-truncate_pagecache-zap_pte_range, the zap_pte_range calls
>>>> function set_page_dirty without page lock. Besides, though
>>>> truncate_pagecache has immap and pte lock, wp_page_shared calls
>>>> fault_dirty_shared_page without any. In this case, two threads race
>>>> in f2fs_set_data_page_dirty function. Page is set to dirty only ONCE,
>>>> but the count is added TWICE by calling f2fs_update_dirty_page.
>>>> Thus the count of dirty page cannot accord with the real dirty pages.
>>>>
>>>> Following is the solution to in case of race happens without any lock.
>>>> If making sure f2fs_vm_page_mkwrite calls set_page_dirty within immap
>>>> lock area, page will already be dirtied when running into
>>>> fault_dirty_shared_page-f2fs_set_data_page_dirty.
>>>> The count of dirty page will not be increased wrong times.
>>>>
>>>> Signed-off-by: Shuqi Zhang <zhangshuqi3@huawei.com>
>>>> ---
>>>>    fs/f2fs/file.c | 11 ++++++-----
>>>>    1 file changed, 6 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>> index ce4905a073b3..d837359a9c00 100644
>>>> --- a/fs/f2fs/file.c
>>>> +++ b/fs/f2fs/file.c
>>>> @@ -140,7 +140,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>>>>    	 * check to see if the page is mapped already (no holes)
>>>>    	 */
>>>>    	if (PageMappedToDisk(page))
>>>> -		goto out_sem;
>>>> +		goto set_dirty;
>>>>    	/* page is wholly or partially inside EOF */
>>>>    	if (((loff_t)(page->index + 1) << PAGE_SHIFT) >
>>>> @@ -150,14 +150,15 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>>>>    		offset = i_size_read(inode) & ~PAGE_MASK;
>>>>    		zero_user_segment(page, offset, PAGE_SIZE);
>>>>    	}
>>>> -	set_page_dirty(page);
>>>> -	if (!PageUptodate(page))
>>>> -		SetPageUptodate(page);
>>>>    	f2fs_update_iostat(sbi, APP_MAPPED_IO, F2FS_BLKSIZE);
>>>> -	f2fs_update_time(sbi, REQ_TIME);
>>>> +set_dirty:
>>>>    	trace_f2fs_vm_page_mkwrite(page, DATA);
>>>> +	set_page_dirty(page);
>>>> +	if (!PageUptodate(page))
>>>> +		SetPageUptodate(page);
> 
> Actually we don't need to call SetPageUptodate() since set_page_dirty() should
> do? And, it seems the call stack is out-dated as well.
> 
> By the way, do we just need to get the right count by this?
> 
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3697,8 +3697,7 @@ static bool f2fs_dirty_data_folio(struct address_space *mapping,
>                  folio_mark_uptodate(folio);
>          BUG_ON(folio_test_swapcache(folio));
> 
> -       if (!folio_test_dirty(folio)) {
> -               filemap_dirty_folio(mapping, folio);
> +       if (filemap_dirty_folio(mapping, folio)) {

Agreed, how about checking return value of filemap_dirty_folio() in
f2fs_dirty_{meta,node}_folio as well for cleanup.

>                  f2fs_update_dirty_folio(inode, folio);
>                  return true;

I suspect we may still suffer from below race condition? due to we will access/update
page private stuff w/o page lock in zap_pte_range.

- zap_pte_range					- f2fs_defragment_range
  - f2fs_dirty_data_folio
   - f2fs_update_dirty_folio			 - lock_page
    - set_page_private_reference			  - set_page_private_gcing

Thanks,

>          }
> 
>>>> +	f2fs_update_time(sbi, REQ_TIME);
>>>>    out_sem:
>>>>    	filemap_invalidate_unlock_shared(inode->i_mapping);
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
