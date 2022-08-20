Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECBF59ABC7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 08:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbiHTGfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 02:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245086AbiHTGfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:35:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900DF7CAA5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:35:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39C20B81F0E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 06:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38F5C433D6;
        Sat, 20 Aug 2022 06:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660977328;
        bh=/qmbfU8kfUzbCZP4PWtMT4PUnuedkebAdEAPd6s3x6M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M1hhGLGbSeU1icVCmy9qsyHe4DIYZvFkPjLbtGW2/gWjz6tZz0ZjIYHrkvPo43T3p
         bLj+w95IAbT7wqy1Aay7fL9cpAxmp47/xSqYtPD3nX21lrjeHtxgvIeJ9Vw767p+Iv
         FOZ0gTvCEQ/M90wf2aeFzl6CIxRxQDcn2kHMbolbmgtMDeYxn154mpE+zv3H2ab+nJ
         Gz/iSRZ4M7lAdhfrApHdSEKWsiVctI4UYmojX2mMf6a2TRCi32je9ZM2dwm08oL+tE
         Wg6TZIQNn2BdDThimGV1KprDUqUMNZbo4Gos6Wc/ureN/L/yYJ5bgKPd9lqZosvCSR
         1gGjyVYMUSOuQ==
Message-ID: <a364da58-f476-69fd-3f90-448f35c8e151@kernel.org>
Date:   Sat, 20 Aug 2022 14:35:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] f2fs: fix wrong dirty page count when race between
 mmap and fallocate.
Content-Language: en-US
To:     Shuqi Zhang <zhangshuqi3@huawei.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220815081555.2961943-1-zhangshuqi3@huawei.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220815081555.2961943-1-zhangshuqi3@huawei.com>
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

On 2022/8/15 16:15, Shuqi Zhang wrote:
> This is a BUG_ON issue as follows when running xfstest-generic-503:
> WARNING: CPU: 21 PID: 1385 at fs/f2fs/inode.c:762 f2fs_evict_inode+0x847/0xaa0
> Modules linked in:
> CPU: 21 PID: 1385 Comm: umount Not tainted 5.19.0-rc5+ #73
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-4.fc34 04/01/2014
> 
> Call Trace:
> evict+0x129/0x2d0
> dispose_list+0x4f/0xb0
> evict_inodes+0x204/0x230
> generic_shutdown_super+0x5b/0x1e0
> kill_block_super+0x29/0x80
> kill_f2fs_super+0xe6/0x140
> deactivate_locked_super+0x44/0xc0
> deactivate_super+0x79/0x90
> cleanup_mnt+0x114/0x1a0
> __cleanup_mnt+0x16/0x20
> task_work_run+0x98/0x100
> exit_to_user_mode_prepare+0x3d0/0x3e0
> syscall_exit_to_user_mode+0x12/0x30
> do_syscall_64+0x42/0x80
> entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Function flow analysis when BUG occurs:
> f2fs_fallocate                    mmap
>                                    do_page_fault
>                                      pte_spinlock  // ---lock_pte
>                                      do_wp_page
>                                        wp_page_shared
>                                          pte_unmap_unlock   // unlock_pte
>                                            do_page_mkwrite
>                                            f2fs_vm_page_mkwrite
>                                              down_read(i_mmap_sem)
>                                              lock_page
>                                              if (PageMappedToDisk(page))
>                                                goto out;
>                                              // set_page_dirty  --NOT RUN
>                                              out: up_read(i_mmap_sem)
>                                            lock_page
>                                          finish_mkwrite_fault // unlock_pte
> f2fs_collapse_range
>    down_write(i_mmap_sem)
>    truncate_pagecache
>      unmap_mapping_pages
>        i_mmap_lock_write // down_write(i_mmap_rwsem)
>          ......
>          zap_pte_range
>            pte_offset_map_lock // ---lock_pte
>            f2fs_set_data_page_dirty

I didn't get it, why zap_pte_range() can set page dirty w/o lock_page?

I found it's very easy to reproduce this bug, but previously I never saw this...
is there any code udpate around truncate_pagecache()?

Thanks,

>              if (!PageDirty(page)) {
>                                          fault_dirty_shared_page
>                                            f2fs_set_data_page_dirty
>                                              if (!PageDirty(page)) {
>                                                __set_page_dirty_nobuffer
>                                                f2fs_update_dirty_page // ++
>                                              }
>                                            unlock_page
>                __set_page_dirty_nobuffers
>                f2fs_update_dirty_page // page count++
>              }
>            pte_unmap_unlock  // --unlock_pte
>        i_mmap_unlock_write  // up_write(i_mmap_rwsem)
>    truncate_inode_pages
>    up_write(i_mmap_sem)
> 
> When race happens between mmap-do_page_fault-wp_page_shared and
> fallocate-truncate_pagecache-zap_pte_range, the zap_pte_range calls
> function set_page_dirty without page lock. Besides, though
> truncate_pagecache has immap and pte lock, wp_page_shared calls
> fault_dirty_shared_page without any. In this case, two threads race
> in f2fs_set_data_page_dirty function. Page is set to dirty only ONCE,
> but the count is added TWICE by calling f2fs_update_dirty_page.
> Thus the count of dirty page cannot accord with the real dirty pages.
> 
> Following is the solution to in case of race happens without any lock.
> If making sure f2fs_vm_page_mkwrite calls set_page_dirty within immap
> lock area, page will already be dirtied when running into
> fault_dirty_shared_page-f2fs_set_data_page_dirty.
> The count of dirty page will not be increased wrong times.
> 
> Signed-off-by: Shuqi Zhang <zhangshuqi3@huawei.com>
> ---
>   fs/f2fs/file.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ce4905a073b3..d837359a9c00 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -140,7 +140,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>   	 * check to see if the page is mapped already (no holes)
>   	 */
>   	if (PageMappedToDisk(page))
> -		goto out_sem;
> +		goto set_dirty;
>   
>   	/* page is wholly or partially inside EOF */
>   	if (((loff_t)(page->index + 1) << PAGE_SHIFT) >
> @@ -150,14 +150,15 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>   		offset = i_size_read(inode) & ~PAGE_MASK;
>   		zero_user_segment(page, offset, PAGE_SIZE);
>   	}
> -	set_page_dirty(page);
> -	if (!PageUptodate(page))
> -		SetPageUptodate(page);
>   
>   	f2fs_update_iostat(sbi, APP_MAPPED_IO, F2FS_BLKSIZE);
> -	f2fs_update_time(sbi, REQ_TIME);
>   
> +set_dirty:
>   	trace_f2fs_vm_page_mkwrite(page, DATA);
> +	set_page_dirty(page);
> +	if (!PageUptodate(page))
> +		SetPageUptodate(page);
> +	f2fs_update_time(sbi, REQ_TIME);
>   out_sem:
>   	filemap_invalidate_unlock_shared(inode->i_mapping);
>   
