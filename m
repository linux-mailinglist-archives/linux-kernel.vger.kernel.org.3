Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC1F586E07
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiHAPrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiHAPrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:47:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67060A1BD
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:47:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29CF8B81217
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 15:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9523EC433C1;
        Mon,  1 Aug 2022 15:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659368835;
        bh=EelFEDjYIFAlC+o2r5NZx9bJaOmFQVywzegLhjqSaC4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HuJwsZ9xV38BeQqatGjqnIImOC1cOM0xch1ETGPfrPJ6nL3+K5D/o2cLSRwXpApHk
         1kTUNtJqk1PLn5Tj0ceFqZ8COJSwzW1Tb1eTxb+iEafBAV6wxcQsJR8RwDy9mivsq1
         uW0BcmC4tSANkv4EGbqc94hXDgVBZKEIq3RbN/mc4W/fRdKnjXpOWuau1/I1LRpuAr
         C4Uubjj5670tgl1vfpReX7s4px+rTrYZTAop3l7AFmRfoBUxmcU1ETYhWESW2op+Nx
         xEJglOCfSo1dTo7pZTLTfZ6aSdlKJ0QxJxphnOIBDrhZg7z3Fc5KnAQO9qTVN5/XCF
         Y5684Qu87fzFg==
Message-ID: <9db28a6d-38a4-b22b-ad5e-10b7d4617385@kernel.org>
Date:   Mon, 1 Aug 2022 23:47:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next v2] f2fs: fix null-ptr-deref in
 f2fs_get_dnode_of_data
Content-Language: en-US
To:     Ye Bin <yebin10@huawei.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220801112604.3406642-1-yebin10@huawei.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220801112604.3406642-1-yebin10@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/1 19:26, Ye Bin wrote:
> There is issue as follows when test f2fs atomic write:
> F2FS-fs (loop0): Can't find valid F2FS filesystem in 2th superblock
> F2FS-fs (loop0): invalid crc_offset: 0
> F2FS-fs (loop0): f2fs_check_nid_range: out-of-range nid=1, run fsck to fix.
> F2FS-fs (loop0): f2fs_check_nid_range: out-of-range nid=2, run fsck to fix.
> ==================================================================
> BUG: KASAN: null-ptr-deref in f2fs_get_dnode_of_data+0xac/0x16d0
> Read of size 8 at addr 0000000000000028 by task rep/1990
> 
> CPU: 4 PID: 1990 Comm: rep Not tainted 5.19.0-rc6-next-20220715 #266
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x6e/0x91
>   print_report.cold+0x49a/0x6bb
>   kasan_report+0xa8/0x130
>   f2fs_get_dnode_of_data+0xac/0x16d0
>   f2fs_do_write_data_page+0x2a5/0x1030
>   move_data_page+0x3c5/0xdf0
>   do_garbage_collect+0x2015/0x36c0
>   f2fs_gc+0x554/0x1d30
>   f2fs_balance_fs+0x7f5/0xda0
>   f2fs_write_single_data_page+0xb66/0xdc0
>   f2fs_write_cache_pages+0x716/0x1420
>   f2fs_write_data_pages+0x84f/0x9a0
>   do_writepages+0x130/0x3a0
>   filemap_fdatawrite_wbc+0x87/0xa0
>   file_write_and_wait_range+0x157/0x1c0
>   f2fs_do_sync_file+0x206/0x12d0
>   f2fs_sync_file+0x99/0xc0
>   vfs_fsync_range+0x75/0x140
>   f2fs_file_write_iter+0xd7b/0x1850
>   vfs_write+0x645/0x780
>   ksys_write+0xf1/0x1e0
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> As 3db1de0e582c commit changed atomic write way which new a cow_inode for
> atomic write file, and also mark cow_inode as FI_ATOMIC_FILE.
> When f2fs_do_write_data_page write cow_inode will use cow_inode's cow_inode
> which is NULL. Then will trigger null-ptr-deref.
> To solve above issue, introduce FI_COW_FILE flag for COW inode.
> 
> Fiexes: 3db1de0e582c("f2fs: change the current atomic write way")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
