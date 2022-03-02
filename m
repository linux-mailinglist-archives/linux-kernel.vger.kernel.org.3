Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC744C9D93
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 06:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbiCBFq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 00:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiCBFqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 00:46:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564C08878B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 21:45:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 95AFCCE20F0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2BAC004E1;
        Wed,  2 Mar 2022 05:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646199939;
        bh=volcjSUHwwVSylhbVEb2XS2jZRERTMkqWLs2N8h9r8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iJq6XCeFYhz9jzuq0BAahxbq5t+6Dox+An0D7ti4589VvmXvq+BEmkzIxL04d/mRI
         WqTWQKokLwss59y9PpBaCy1bov4KROYSxRFetI6N09HM160FFMlBkgadGU6VbEveGL
         8Y9uG3jlX+cS2T1+OVWKwQZrEbvKwoesomXmH+EZz/tvwIKjlKmg7VMaCRXkVmjZJd
         JYQ/Qhl7VfWtF2+0aSaA8sLEktBCIms+NHtZ8b5+9M6TzM+QTnYkYePVz4wZJh6vOr
         pTSrFZ3qrFMhc6XvFt/LSCy2Rf3W5EZGVx2ob7ulspJmcbR/RB7laaZXmK3AkJGIRa
         iY6hc+yTCGj6A==
Date:   Tue, 1 Mar 2022 21:45:37 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid sb_start_intwrite during
 eviction
Message-ID: <Yh8EgciUTRAbWDNG@google.com>
References: <20220215220039.1477906-1-jaegeuk@kernel.org>
 <09683b83-b6c0-fe05-0dae-b93cab2f4b63@kernel.org>
 <YhkpjWZ3NO5ihvH5@google.com>
 <Yh2lpb3c5X9aPJ+r@google.com>
 <4b264607-4d60-7370-eca7-8816a3f8d29f@kernel.org>
 <Yh8B/w9kPGU98Hfh@google.com>
 <Yh8C4aA+nBajs+fc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh8C4aA+nBajs+fc@google.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01, Jaegeuk Kim wrote:
> On 03/01, Jaegeuk Kim wrote:
> > On 03/02, Chao Yu wrote:
> > > On 2022/3/1 12:48, Jaegeuk Kim wrote:
> > > > 1. waiting for f2fs_evict_inode
> > > > [ 5560.043945]  __wait_on_freeing_inode+0xac/0xf0
> > > > [ 5560.045540]  ? var_wake_function+0x30/0x30
> > > > [ 5560.047036]  find_inode_fast+0x6d/0xc0
> > > > [ 5560.048473]  iget_locked+0x79/0x230
> > > > [ 5560.049933]  f2fs_iget+0x27/0x1200 [f2fs]
> > > > [ 5560.051496]  f2fs_lookup+0x18c/0x3e0 [f2fs]
> > > > [ 5560.053069]  __lookup_slow+0x84/0x150
> > > > [ 5560.054503]  walk_component+0x141/0x1b0
> > > > [ 5560.055938]  link_path_walk.part.0+0x23b/0x360
> > > > [ 5560.057541]  ? end_bio_bh_io_sync+0x37/0x50
> > > > [ 5560.059086]  path_parentat+0x3c/0x90
> > > > [ 5560.060492]  filename_parentat+0xd7/0x1e0
> > > > [ 5560.062002]  ? blk_mq_free_request+0x127/0x150
> > > > [ 5560.063576]  do_renameat2+0xc1/0x5b0
> > > >   --> sb_start_write(m->mnt_sb); ->  __sb_start_write(sb, SB_FREEZE_WRITE);
> > > > 
> > > > [ 5560.064999]  ? __check_object_size+0x13f/0x150
> > > > [ 5560.066559]  ? strncpy_from_user+0x44/0x150
> > > > [ 5560.068038]  ? getname_flags.part.0+0x4c/0x1b0
> > > > [ 5560.069617]  __x64_sys_renameat2+0x51/0x60
> > > > 
> > > > 2. waiting for sb_start_intwrite -> __sb_start_write(sb, SB_FREEZE_FS);
> > > 
> > > It's still not clear that why __sb_start_write(sb, SB_FREEZE_FS) will be blocked,
> > > as SB_FREEZE_FS and SB_FREEZE_WRITE points to different locks.
> > 
> > It seems I missed another call, thaw_super(), got SB_FREEZE_FS and then being
> > stuck to grab SB_FREEZE_WRITE.
> 
> Ah, sorry. freeze_super().

Messed up. So, the lock order is SB_FREEZE_WRITE -> SB_FREEZE_FS in both cases.

> 
> > 
> > > 
> > > Thread A				Thread B				Thread C
> > > - rename
> > >  - sb_start_write
> > >   - __sb_start_write(SB_FREEZE_WRITE)
> > > ...
> > >      - f2fs_lookup
> > > ...
> > >        - __wait_on_freeing_inode
> > > 					- drop_slab
> > > 					 - prune_icache_sb
> > > 					  - inode_lru_isolate
> > > 					   :inode->i_state |= I_FREEING
> > > 										- Is there any flow that it has already held
> > > 										 SB_FREEZE_FS and try to lock SB_FREEZE_WRITE?
> > > 					   - f2fs_evict_inode
> > > 					    - __sb_start_write(SB_FREEZE_FS)
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > [ 5560.152447]  percpu_rwsem_wait+0xaf/0x160
> > > > [ 5560.154000]  ? percpu_down_write+0xd0/0xd0
> > > > [ 5560.155498]  __percpu_down_read+0x4e/0x60
> > > > [ 5560.157000]  f2fs_evict_inode+0x5a3/0x610 [f2fs]
> > > > [ 5560.158648]  ? var_wake_function+0x30/0x30
> > > > [ 5560.160341]  evict+0xd2/0x180
> > > > [ 5560.161728]  prune_icache_sb+0x81/0xb0
> > > >   --> inode_lru_isolate() -> inode->i_state |= I_FREEING;
> > > > 
> > > > [ 5560.163179]  super_cache_scan+0x169/0x1f0
> > > > [ 5560.164675]  do_shrink_slab+0x145/0x2b0
> > > > [ 5560.166121]  shrink_slab+0x186/0x2d0
> > > > [ 5560.167481]  drop_slab_node+0x4a/0x90
> > > > [ 5560.168876]  drop_slab+0x3e/0x80
> > > > [ 5560.170178]  drop_caches_sysctl_handler+0x75/0x90
> > > > [ 5560.171761]  proc_sys_call_handler+0x149/0x280
> > > > [ 5560.173328]  proc_sys_write+0x13/0x20
> > > > [ 5560.174667]  new_sync_write+0x117/0x1b0
> > > > [ 5560.176120]  vfs_write+0x1d5/0x270
> > > > [ 5560.177409]  ksys_write+0x67/0xe0
> > > > 
> > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > ---
> > > >   Note, I found this call stack.
> > > > 
> > > >   fs/f2fs/inode.c | 2 --
> > > >   1 file changed, 2 deletions(-)
> > > > 
> > > > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > > > index ab8e0c06c78c..882db4bd917b 100644
> > > > --- a/fs/f2fs/inode.c
> > > > +++ b/fs/f2fs/inode.c
> > > > @@ -778,7 +778,6 @@ void f2fs_evict_inode(struct inode *inode)
> > > >   	f2fs_remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
> > > >   	f2fs_remove_ino_entry(sbi, inode->i_ino, FLUSH_INO);
> > > > -	sb_start_intwrite(inode->i_sb);
> > > >   	set_inode_flag(inode, FI_NO_ALLOC);
> > > >   	i_size_write(inode, 0);
> > > >   retry:
> > > > @@ -809,7 +808,6 @@ void f2fs_evict_inode(struct inode *inode)
> > > >   		if (dquot_initialize_needed(inode))
> > > >   			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
> > > >   	}
> > > > -	sb_end_intwrite(inode->i_sb);
> > > >   no_delete:
> > > >   	dquot_drop(inode);
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
