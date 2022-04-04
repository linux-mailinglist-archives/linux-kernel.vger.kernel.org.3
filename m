Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271E34F137F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358849AbiDDK5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358767AbiDDK5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:57:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FF82F3A3;
        Mon,  4 Apr 2022 03:55:11 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KX72Y2Jk5z1HBRD;
        Mon,  4 Apr 2022 18:54:45 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 18:55:08 +0800
Subject: Re: [PATCH -next v2] jbd2: Fix null-ptr-deref when process reserved
 list in jbd2_journal_commit_transaction
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
References: <20220317142137.1821590-1-yebin10@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        <lczerner@redhat.com>
From:   yebin <yebin10@huawei.com>
Message-ID: <624ACE8C.8010008@huawei.com>
Date:   Mon, 4 Apr 2022 18:55:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20220317142137.1821590-1-yebin10@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

On 2022/3/17 22:21, Ye Bin wrote:
> we got issue as follows:
> [   72.796117] EXT4-fs error (device sda): ext4_journal_check_start:83: comm fallocate: Detected aborted journal
> [   72.826847] EXT4-fs (sda): Remounting filesystem read-only
> fallocate: fallocate failed: Read-only file system
> [   74.791830] jbd2_journal_commit_transaction: jh=0xffff9cfefe725d90 bh=0x0000000000000000 end delay
> [   74.793597] ------------[ cut here ]------------
> [   74.794203] kernel BUG at fs/jbd2/transaction.c:2063!
> [   74.794886] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [   74.795533] CPU: 4 PID: 2260 Comm: jbd2/sda-8 Not tainted 5.17.0-rc8-next-20220315-dirty #150
> [   74.798327] RIP: 0010:__jbd2_journal_unfile_buffer+0x3e/0x60
> [   74.801971] RSP: 0018:ffffa828c24a3cb8 EFLAGS: 00010202
> [   74.802694] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [   74.803601] RDX: 0000000000000001 RSI: ffff9cfefe725d90 RDI: ffff9cfefe725d90
> [   74.804554] RBP: ffff9cfefe725d90 R08: 0000000000000000 R09: ffffa828c24a3b20
> [   74.805471] R10: 0000000000000001 R11: 0000000000000001 R12: ffff9cfefe725d90
> [   74.806385] R13: ffff9cfefe725d98 R14: 0000000000000000 R15: ffff9cfe833a4d00
> [   74.807301] FS:  0000000000000000(0000) GS:ffff9d01afb00000(0000) knlGS:0000000000000000
> [   74.808338] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   74.809084] CR2: 00007f2b81bf4000 CR3: 0000000100056000 CR4: 00000000000006e0
> [   74.810047] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   74.810981] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   74.811897] Call Trace:
> [   74.812241]  <TASK>
> [   74.812566]  __jbd2_journal_refile_buffer+0x12f/0x180
> [   74.813246]  jbd2_journal_refile_buffer+0x4c/0xa0
> [   74.813869]  jbd2_journal_commit_transaction.cold+0xa1/0x148
> [   74.817550]  kjournald2+0xf8/0x3e0
> [   74.819056]  kthread+0x153/0x1c0
> [   74.819963]  ret_from_fork+0x22/0x30
>
> Above issue may happen as follows:
>          write                   truncate                   kjournald2
> generic_perform_write
>   ext4_write_begin
>    ext4_walk_page_buffers
>     do_journal_get_write_access ->add BJ_Reserved list
>   ext4_journalled_write_end
>    ext4_walk_page_buffers
>     write_end_fn
>      ext4_handle_dirty_metadata
>                  ***************JBD2 ABORT**************
>       jbd2_journal_dirty_metadata
>   -> return -EROFS, jh in reserved_list
>                                                     jbd2_journal_commit_transaction
>                                                      while (commit_transaction->t_reserved_list)
>                                                        jh = commit_transaction->t_reserved_list;
>                          truncate_pagecache_range
>                           do_invalidatepage
> 			  ext4_journalled_invalidatepage
> 			   jbd2_journal_invalidatepage
> 			    journal_unmap_buffer
> 			     __dispose_buffer
> 			      __jbd2_journal_unfile_buffer
> 			       jbd2_journal_put_journal_head ->put last ref_count
> 			        __journal_remove_journal_head
> 				 bh->b_private = NULL;
> 				 jh->b_bh = NULL;
> 				                      jbd2_journal_refile_buffer(journal, jh);
> 							bh = jh2bh(jh);
> 							->bh is NULL, later will trigger null-ptr-deref
> 				 journal_free_journal_head(jh);
>
> As after 96f1e0974575 commit, handle reserved list will not hold "journal->j_state_lock"
> when kjournald2 commit transaction. So journal_unmap_buffer maybe free
> journal_head when handle reserved list. And lead to null-ptr-deref or some
> strange errors.
> As reserved list almost time is empty. Use "journal->j_state_lock" to protect
> handle reserved list can simply solve above issue.
>
> Fixes: 96f1e0974575("jbd2: avoid long hold times of j_state_lock while committing a transaction")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   fs/jbd2/commit.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 5b9408e3b370..ac7f067b7bdd 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -488,7 +488,6 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>   	jbd2_journal_wait_updates(journal);
>   
>   	commit_transaction->t_state = T_SWITCH;
> -	write_unlock(&journal->j_state_lock);
>   
>   	J_ASSERT (atomic_read(&commit_transaction->t_outstanding_credits) <=
>   			journal->j_max_transaction_buffers);
> @@ -508,6 +507,8 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>   	 * has reserved.  This is consistent with the existing behaviour
>   	 * that multiple jbd2_journal_get_write_access() calls to the same
>   	 * buffer are perfectly permissible.
> +	 * We use journal->j_state_lock here to serialize processing of
> +	 * t_reserved_list with eviction of buffers from journal_unmap_buffer().
>   	 */
>   	while (commit_transaction->t_reserved_list) {
>   		jh = commit_transaction->t_reserved_list;
> @@ -527,6 +528,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>   		jbd2_journal_refile_buffer(journal, jh);
>   	}
>   
> +	write_unlock(&journal->j_state_lock);
>   	/*
>   	 * Now try to drop any written-back buffers from the journal's
>   	 * checkpoint lists.  We do this *before* commit because it potentially

