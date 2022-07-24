Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD8657F4AA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 12:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiGXKVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 06:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiGXKVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 06:21:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDFB13E12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 03:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B692E61029
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 10:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B791CC3411E;
        Sun, 24 Jul 2022 10:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658658062;
        bh=N/BRF6ybrbTj/8aBJzvPdT6j6K1TWBKn2MYdG1LcXhs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nkPCu9vSElkTL6Yk01gNIGAoF1F23y9wHIbO5pL5VkjftLiXMZOsSdRarudGN+djJ
         6kHeWUJJRc6erQuqoFDn8bZebY6MFRY9Y9mZqACC/bK2H4U1GFCP+Y5VykanijGbH/
         ZKLdAZjwP1jACgFJuomG5PiAwS/roRqnQgat0wHgNKlRWjH1cHbFq5yAivm616u/NP
         kw/HxBEcm2ef7rfb2h2QDVVQ8w0Glgh9GEBYeLAHIRV8n0Zx7qzQhfIMOVzgf0HlbX
         b3n+vbw0vOOK+D11Ayystysy/vlKcUnAEFrdjVEbPdu/7BFa0Ouosm2fTPfpx1jDRC
         HKOn5abbj7Ovg==
Message-ID: <e82f0d90-7fda-c944-149f-d18491008f3f@kernel.org>
Date:   Sun, 24 Jul 2022 18:20:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next RFC] f2fs: fix null-ptr-deref in
 f2fs_get_dnode_of_data
Content-Language: en-US
To:     Ye Bin <yebin10@huawei.com>, jaegeuk@kernel.org,
        Daeho Jeong <daeho43@gmail.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220718113609.154371-1-yebin10@huawei.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220718113609.154371-1-yebin10@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/18 19:36, Ye Bin wrote:
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
> To solve above issue, don't mark cow_inode as FI_ATOMIC_FILE.
> 
> Fiexes: 3db1de0e582c("f2fs: change the current atomic write way")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   fs/f2fs/file.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 466eb00aa516..735802b6b754 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2062,7 +2062,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>   	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
>   
>   	set_inode_flag(inode, FI_ATOMIC_FILE);
> -	set_inode_flag(fi->cow_inode, FI_ATOMIC_FILE);

It needs to remove clear_inode_flag(fi->cow_inode, FI_ATOMIC_FILE) in
f2fs_abort_atomic_write()?

To Daeho, could you please review this patch? IIUC, cow_inode doesn't
need to be set as atomic file?

Thanks,

>   	clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
>   	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>   
