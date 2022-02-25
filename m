Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CB84C4E53
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiBYTKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbiBYTKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:10:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E351F7699
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:10:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5769DB80D4A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 19:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64FFC340EF;
        Fri, 25 Feb 2022 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645816206;
        bh=zpuAbyKQAc/LwcuM/HX7IZL1oFvqzXoZb4G4XbEKzrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5+TA1F4+CtdgGvNJlRLIQGsAnWAEcTAOMKukJQw4ydiOQWt+IRgUWJodny0J+/8I
         n521DKk7PSIVrz3+ZwfNxoRqcsIyff8a/KZKJoEg+W7erGa44DpSTi6Cx4g6V0Bdtx
         +CgJ++rYLucQHjMEzJ08TVZYOw+64F6EqY8c1MTdXaBc4bE5FMalE7B8y2+6DohooZ
         CatwjrsZF46DG90A/r5SR+OSznP00RqyuCYkFq/JJ6dPDvQM9ygIpTDAgjQttDXNK8
         Ga/UI144p5CW0tVm9KTKHynMwKKBJKlvlGcc69D38qATjwg0qddS01c/BzqiP2s1dp
         4oWm7wAd1w3kg==
Date:   Fri, 25 Feb 2022 11:10:05 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid sb_start_intwrite during eviction
Message-ID: <YhkpjWZ3NO5ihvH5@google.com>
References: <20220215220039.1477906-1-jaegeuk@kernel.org>
 <09683b83-b6c0-fe05-0dae-b93cab2f4b63@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09683b83-b6c0-fe05-0dae-b93cab2f4b63@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25, Chao Yu wrote:
> On 2022/2/16 6:00, Jaegeuk Kim wrote:
> > 1. this thread is stuck in f2fs_evict_inode by #2:
> > [210757.653718]  __schedule+0x2e3/0x740
> > [210757.654811]  schedule+0x42/0xb0
> > [210757.655829]  rwsem_down_read_slowpath+0x16c/0x4a0
> 
> Who has held sb->s_writers.rw_sem?

I lost the history. Let me drop this and investigate once I hit this again.

> 
> Thanks,
> 
> > [210757.657161]  __down_read+0x6b/0x80
> > [210757.658254]  __percpu_down_read+0x54/0x80
> > [210757.659413]  __sb_start_write+0x79/0x80
> > [210757.660546]  f2fs_evict_inode+0x354/0x5c0 [f2fs]
> > [210757.661808]  ? var_wake_function+0x30/0x30
> > [210757.663016]  evict+0xd2/0x1b0
> > [210757.664007]  dispose_list+0x39/0x50
> > [210757.665083]  prune_icache_sb+0x5c/0x80
> > [210757.666226]  super_cache_scan+0x132/0x1b0
> > [210757.667373]  do_shrink_slab+0x150/0x2a0
> > [210757.668510]  shrink_slab+0x20c/0x2a0
> > [210757.669574]  drop_slab_node+0x33/0x60
> > [210757.670646]  drop_slab+0x3e/0x70
> > [210757.671633]  drop_caches_sysctl_handler+0x75/0x85
> > [210757.672904]  proc_sys_call_handler+0x1a2/0x1c0
> > [210757.674104]  proc_sys_write+0x14/0x20
> > [210757.675189]  __vfs_write+0x1b/0x40
> > [210757.676208]  vfs_write+0xb9/0x1a0
> > [210757.677219]  ksys_write+0x67/0xe0
> > [210757.678251]  __x64_sys_write+0x1a/0x20
> > 
> > 2. another thread is waiting for #1:
> > [210757.754646]  schedule+0x42/0xb0
> > [210757.755680]  rwsem_down_write_slowpath+0x244/0x4d0
> > [210757.757016]  ? _cond_resched+0x19/0x30
> > [210757.758140]  down_write+0x41/0x50
> > [210757.759223]  prealloc_shrinker+0x6a/0x120
> > [210757.760397]  alloc_super+0x275/0x2d0
> > [210757.761500]  sget_fc+0x74/0x220
> > [210757.762547]  ? set_anon_super+0x20/0x20
> > [210757.763711]  ? shmem_create+0x20/0x20
> > [210757.764842]  vfs_get_super+0x3d/0x100
> > [210757.765925]  get_tree_nodev+0x16/0x20
> > [210757.767046]  shmem_get_tree+0x15/0x20
> > [210757.768165]  vfs_get_tree+0x2a/0xc0
> > [210757.769248]  ? ns_capable+0x10/0x20
> > [210757.770361]  do_mount+0x7b6/0x9c0
> > [210757.771423]  ksys_mount+0x82/0xd0
> > [210757.772469]  __x64_sys_mount+0x25/0x30
> > [210757.773592]  do_syscall_64+0x57/0x190
> > 
> > 3. thaw_super is waiting for #2, resulting in xfstests/generic/068 being stuck.
> > [210757.695823]  __schedule+0x2e3/0x740
> > [210757.696897]  ? sched_clock+0x9/0x10
> > [210757.697959]  schedule+0x42/0xb0
> > [210757.698963]  rwsem_down_write_slowpath+0x244/0x4d0
> > [210757.700247]  down_write+0x41/0x50
> > [210757.701259]  thaw_super+0x17/0x30
> > [210757.702235]  do_vfs_ioctl+0x56f/0x670
> > [210757.703247]  ? do_user_addr_fault+0x216/0x450
> > [210757.704395]  ? _copy_to_user+0x2c/0x30
> > [210757.705443]  ksys_ioctl+0x67/0x90
> > [210757.706419]  __x64_sys_ioctl+0x1a/0x20
> > [210757.707437]  do_syscall_64+0x57/0x190
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/inode.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index ab8e0c06c78c..882db4bd917b 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -778,7 +778,6 @@ void f2fs_evict_inode(struct inode *inode)
> >   	f2fs_remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
> >   	f2fs_remove_ino_entry(sbi, inode->i_ino, FLUSH_INO);
> > -	sb_start_intwrite(inode->i_sb);
> >   	set_inode_flag(inode, FI_NO_ALLOC);
> >   	i_size_write(inode, 0);
> >   retry:
> > @@ -809,7 +808,6 @@ void f2fs_evict_inode(struct inode *inode)
> >   		if (dquot_initialize_needed(inode))
> >   			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
> >   	}
> > -	sb_end_intwrite(inode->i_sb);
> >   no_delete:
> >   	dquot_drop(inode);
