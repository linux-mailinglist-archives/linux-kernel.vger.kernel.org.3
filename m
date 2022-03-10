Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F974D3F67
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 03:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbiCJCwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 21:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiCJCwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 21:52:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815AA125591
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 18:51:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 275BF61552
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F309C340E8;
        Thu, 10 Mar 2022 02:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646880694;
        bh=wnMbY2M5xbXyRTNGfw/R/oyMLMef861Nh511DGSVEUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4LYAoe7BpzUz5yzavMhQrLSYbktYNURouVVoJvApDaEtt2v2S3r7gQvTuXEG5Qp4
         kntjBeYSqVKJ86Xi9eOe9d7mza7ec9rlDiqmAQWvJxw0N84T+QO8IKXAlGhqCIQ+e9
         2i6ui4O4+CpwErc+Kjn1ky93AYAVO9V0FDV/Y099Bx9cNTPdrmG/Q6Y3pBVEOEe3Ut
         3v1+YacxfoW5tLpB1exeiJt7QWyvuxwCfSQK4PeE0T55isKef/WdtmSiT2mOz0YRW8
         g8Y7x/w4LJm2qUdSuLFkR/EN80j1EKYQbCVR3OYNVVXRHruFqOV7TRseNFKOAoTv/h
         dlBWvsY9hoStQ==
Date:   Wed, 9 Mar 2022 18:51:32 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: use spin_lock to avoid hang
Message-ID: <YilntIMrQchFfq9n@google.com>
References: <20220309214834.3408741-1-jaegeuk@kernel.org>
 <20220309214834.3408741-2-jaegeuk@kernel.org>
 <7b12573b-cad4-45b0-9e8a-9cc40a08b856@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b12573b-cad4-45b0-9e8a-9cc40a08b856@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10, Chao Yu wrote:
> On 2022/3/10 5:48, Jaegeuk Kim wrote:
> > [14696.634553] task:cat             state:D stack:    0 pid:1613738 ppid:1613735 flags:0x00000004
> > [14696.638285] Call Trace:
> > [14696.639038]  <TASK>
> > [14696.640032]  __schedule+0x302/0x930
> > [14696.640969]  schedule+0x58/0xd0
> > [14696.641799]  schedule_preempt_disabled+0x18/0x30
> > [14696.642890]  __mutex_lock.constprop.0+0x2fb/0x4f0
> > [14696.644035]  ? mod_objcg_state+0x10c/0x310
> > [14696.645040]  ? obj_cgroup_charge+0xe1/0x170
> > [14696.646067]  __mutex_lock_slowpath+0x13/0x20
> > [14696.647126]  mutex_lock+0x34/0x40
> > [14696.648070]  stat_show+0x25/0x17c0 [f2fs]
> > [14696.649218]  seq_read_iter+0x120/0x4b0
> > [14696.650289]  ? aa_file_perm+0x12a/0x500
> > [14696.651357]  ? lru_cache_add+0x1c/0x20
> > [14696.652470]  seq_read+0xfd/0x140
> > [14696.653445]  full_proxy_read+0x5c/0x80
> > [14696.654535]  vfs_read+0xa0/0x1a0
> > [14696.655497]  ksys_read+0x67/0xe0
> > [14696.656502]  __x64_sys_read+0x1a/0x20
> > [14696.657580]  do_syscall_64+0x3b/0xc0
> > [14696.658671]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [14696.660068] RIP: 0033:0x7efe39df1cb2
> > [14696.661133] RSP: 002b:00007ffc8badd948 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [14696.662958] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007efe39df1cb2
> > [14696.664757] RDX: 0000000000020000 RSI: 00007efe399df000 RDI: 0000000000000003
> > [14696.666542] RBP: 00007efe399df000 R08: 00007efe399de010 R09: 00007efe399de010
> > [14696.668363] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000000
> > [14696.670155] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
> > [14696.671965]  </TASK>
> > [14696.672826] task:umount          state:D stack:    0 pid:1614985 ppid:1614984 flags:0x00004000
> > [14696.674930] Call Trace:
> > [14696.675903]  <TASK>
> > [14696.676780]  __schedule+0x302/0x930
> > [14696.677927]  schedule+0x58/0xd0
> > [14696.679019]  schedule_preempt_disabled+0x18/0x30
> > [14696.680412]  __mutex_lock.constprop.0+0x2fb/0x4f0
> > [14696.681783]  ? destroy_inode+0x65/0x80
> > [14696.683006]  __mutex_lock_slowpath+0x13/0x20
> > [14696.684305]  mutex_lock+0x34/0x40
> > [14696.685442]  f2fs_destroy_stats+0x1e/0x60 [f2fs]
> > [14696.686803]  f2fs_put_super+0x158/0x390 [f2fs]
> > [14696.688238]  generic_shutdown_super+0x7a/0x120
> > [14696.689621]  kill_block_super+0x27/0x50
> > [14696.690894]  kill_f2fs_super+0x7f/0x100 [f2fs]
> > [14696.692311]  deactivate_locked_super+0x35/0xa0
> > [14696.693698]  deactivate_super+0x40/0x50
> > [14696.694985]  cleanup_mnt+0x139/0x190
> > [14696.696209]  __cleanup_mnt+0x12/0x20
> > [14696.697390]  task_work_run+0x64/0xa0
> > [14696.698587]  exit_to_user_mode_prepare+0x1b7/0x1c0
> > [14696.700053]  syscall_exit_to_user_mode+0x27/0x50
> > [14696.701418]  do_syscall_64+0x48/0xc0
> > [14696.702630]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Any race case here? I didn't catch the root cause here...

This is the only clue that I could use. :(

> Thanks,
