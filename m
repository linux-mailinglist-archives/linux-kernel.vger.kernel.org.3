Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C290B56B106
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 05:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbiGHDZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 23:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236630AbiGHDZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 23:25:24 -0400
Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA16074799
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 20:25:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VIhZoLB_1657250717;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VIhZoLB_1657250717)
          by smtp.aliyun-inc.com;
          Fri, 08 Jul 2022 11:25:18 +0800
Date:   Fri, 8 Jul 2022 11:25:17 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Guowei Du <duguoweisz@gmail.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, duguowei <duguowei@xiaomi.com>
Subject: Re: [PATCH 2/2] erofs: sequence each shrink task
Message-ID: <YsejnaY7cy3SeHBF@B-P7TQMD6M-0146.local>
References: <20220708031155.21878-1-duguoweisz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220708031155.21878-1-duguoweisz@gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guowei,

On Fri, Jul 08, 2022 at 11:11:55AM +0800, Guowei Du wrote:
> From: duguowei <duguowei@xiaomi.com>
> 
> Because of 'list_move_tail', if two or more tasks are shrinking, there
> will be different results for them.

Thanks for the patch. Two quick questions:
 1) where is the PATCH 1/2;
 2) What problem is the current patch trying to resolve...

> 
> For example:
> After the first round, if shrink_run_no of entry equals run_no of task,
> task will break directly at the beginning of next round; if they are
> not equal, task will continue to shrink until encounter one entry
> which has the same number.
> 
> It is difficult to confirm the real results of all tasks, so add a lock
> to only allow one task to shrink at the same time.
> 
> How to test:
> task1:
> root#echo 3 > /proc/sys/vm/drop_caches
> [743071.839051] Call Trace:
> [743071.839052]  <TASK>
> [743071.839054]  do_shrink_slab+0x112/0x300
> [743071.839058]  shrink_slab+0x211/0x2a0
> [743071.839060]  drop_slab+0x72/0xe0
> [743071.839061]  drop_caches_sysctl_handler+0x50/0xb0
> [743071.839063]  proc_sys_call_handler+0x173/0x250
> [743071.839066]  proc_sys_write+0x13/0x20
> [743071.839067]  new_sync_write+0x104/0x180
> [743071.839070]  ? send_command+0xe0/0x270
> [743071.839073]  vfs_write+0x247/0x2a0
> [743071.839074]  ksys_write+0xa7/0xe0
> [743071.839075]  ? fpregs_assert_state_consistent+0x23/0x50
> [743071.839078]  __x64_sys_write+0x1a/0x20
> [743071.839079]  do_syscall_64+0x3a/0x80
> [743071.839081]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> task2:
> root#echo 3 > /proc/sys/vm/drop_caches
> [743079.843214] Call Trace:
> [743079.843214]  <TASK>
> [743079.843215]  do_shrink_slab+0x112/0x300
> [743079.843219]  shrink_slab+0x211/0x2a0
> [743079.843221]  drop_slab+0x72/0xe0
> [743079.843222]  drop_caches_sysctl_handler+0x50/0xb0
> [743079.843224]  proc_sys_call_handler+0x173/0x250
> [743079.843227]  proc_sys_write+0x13/0x20
> [743079.843228]  new_sync_write+0x104/0x180
> [743079.843231]  ? send_command+0xe0/0x270
> [743079.843233]  vfs_write+0x247/0x2a0
> [743079.843234]  ksys_write+0xa7/0xe0
> [743079.843235]  ? fpregs_assert_state_consistent+0x23/0x50
> [743079.843238]  __x64_sys_write+0x1a/0x20
> [743079.843239]  do_syscall_64+0x3a/0x80
> [743079.843241]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Signed-off-by: duguowei <duguowei@xiaomi.com>
> ---
>  fs/erofs/utils.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
> index ec9a1d780dc1..9eca13a7e594 100644
> --- a/fs/erofs/utils.c
> +++ b/fs/erofs/utils.c
> @@ -186,6 +186,8 @@ static unsigned int shrinker_run_no;
>  
>  /* protects the mounted 'erofs_sb_list' */
>  static DEFINE_SPINLOCK(erofs_sb_list_lock);
> +/* sequence each shrink task */
> +static DEFINE_SPINLOCK(erofs_sb_shrink_lock);
>  static LIST_HEAD(erofs_sb_list);
>  
>  void erofs_shrinker_register(struct super_block *sb)
> @@ -226,13 +228,14 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
>  	struct list_head *p;
>  
>  	unsigned long nr = sc->nr_to_scan;
> -	unsigned int run_no;
>  	unsigned long freed = 0;
>  
> +	spin_lock(&erofs_sb_shrink_lock);

Btw, we cannot make the whole shrinker under one spin_lock.

Thanks,
Gao Xiang
