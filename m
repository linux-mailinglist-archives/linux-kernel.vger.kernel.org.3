Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B365A58751F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbiHBBlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiHBBlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:41:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CED21836F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFB7EB81624
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588EAC433D6;
        Tue,  2 Aug 2022 01:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659404503;
        bh=t/fKJPC3nkSuPHZydD7hHIqWuTS2YprxFWHmP6K1j7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOvN2Hqe9BFF2CjdZi4YiWsLDiqMoVNlE3OxhGkIkDitkLzVE0TSRkErXGdTQ7PdE
         3xkASBgR2Nocikr2Jfaq7/hu2dB9jm4e71Cl5uk5bLko/GryZVXB+3sSIhCUYdbnsw
         CLmPzajrmkOKSAIL37EAGP08CNUWYE3VE3C/gbao/Y3Yrfd1oEnYly6GNoOVHl+e8R
         88/9EbYvQLjdsby4uj6p22X4A9OgIXEn5nczXeZ3IcEqOnoA7qLQRFNG/buG8XLVfR
         Ykytx5kVSJuJcrG7Guo0YiTbPHBM4YT672HmLFNkoKbtHSJ8Vq3vlpiFRyg6uWCu62
         2af3UPUZn6q/g==
Date:   Mon, 1 Aug 2022 18:41:41 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     Ye Bin <yebin10@huawei.com>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH -next v2] f2fs: fix null-ptr-deref in
 f2fs_get_dnode_of_data
Message-ID: <YuiA1UcEV8PnUXeU@google.com>
References: <20220801112604.3406642-1-yebin10@huawei.com>
 <CACOAw_yes-aq2EMvXA6hCmV9FLXtRXXwaMW2iB3d7ynjPKa78Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_yes-aq2EMvXA6hCmV9FLXtRXXwaMW2iB3d7ynjPKa78Q@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01, Daeho Jeong wrote:
> On Mon, Aug 1, 2022 at 4:15 AM Ye Bin via Linux-f2fs-devel
> <linux-f2fs-devel@lists.sourceforge.net> wrote:
> >
> > There is issue as follows when test f2fs atomic write:
> > F2FS-fs (loop0): Can't find valid F2FS filesystem in 2th superblock
> > F2FS-fs (loop0): invalid crc_offset: 0
> > F2FS-fs (loop0): f2fs_check_nid_range: out-of-range nid=1, run fsck to fix.
> > F2FS-fs (loop0): f2fs_check_nid_range: out-of-range nid=2, run fsck to fix.
> > ==================================================================
> > BUG: KASAN: null-ptr-deref in f2fs_get_dnode_of_data+0xac/0x16d0
> > Read of size 8 at addr 0000000000000028 by task rep/1990
> >
> > CPU: 4 PID: 1990 Comm: rep Not tainted 5.19.0-rc6-next-20220715 #266
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x6e/0x91
> >  print_report.cold+0x49a/0x6bb
> >  kasan_report+0xa8/0x130
> >  f2fs_get_dnode_of_data+0xac/0x16d0
> >  f2fs_do_write_data_page+0x2a5/0x1030
> >  move_data_page+0x3c5/0xdf0
> >  do_garbage_collect+0x2015/0x36c0
> >  f2fs_gc+0x554/0x1d30
> >  f2fs_balance_fs+0x7f5/0xda0
> >  f2fs_write_single_data_page+0xb66/0xdc0
> >  f2fs_write_cache_pages+0x716/0x1420
> >  f2fs_write_data_pages+0x84f/0x9a0
> >  do_writepages+0x130/0x3a0
> >  filemap_fdatawrite_wbc+0x87/0xa0
> >  file_write_and_wait_range+0x157/0x1c0
> >  f2fs_do_sync_file+0x206/0x12d0
> >  f2fs_sync_file+0x99/0xc0
> >  vfs_fsync_range+0x75/0x140
> >  f2fs_file_write_iter+0xd7b/0x1850
> >  vfs_write+0x645/0x780
> >  ksys_write+0xf1/0x1e0
> >  do_syscall_64+0x3b/0x90
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > As 3db1de0e582c commit changed atomic write way which new a cow_inode for
> > atomic write file, and also mark cow_inode as FI_ATOMIC_FILE.
> > When f2fs_do_write_data_page write cow_inode will use cow_inode's cow_inode
> > which is NULL. Then will trigger null-ptr-deref.
> > To solve above issue, introduce FI_COW_FILE flag for COW inode.
> >
> > Fiexes: 3db1de0e582c("f2fs: change the current atomic write way")
> > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > ---
> >  fs/f2fs/f2fs.h    | 6 ++++++
> >  fs/f2fs/file.c    | 2 +-
> >  fs/f2fs/segment.c | 5 +++--
> >  3 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 8579b59b8a05..101f0064ee25 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -758,6 +758,7 @@ enum {
> >         FI_ENABLE_COMPRESS,     /* enable compression in "user" compression mode */
> >         FI_COMPRESS_RELEASED,   /* compressed blocks were released */
> >         FI_ALIGNED_WRITE,       /* enable aligned write */
> > +       FI_COW_FILE,            /* indicate COW file */
> >         FI_MAX,                 /* max flag, never be used */
> >  };
> >
> > @@ -3207,6 +3208,11 @@ static inline bool f2fs_is_atomic_file(struct inode *inode)
> >         return is_inode_flag_set(inode, FI_ATOMIC_FILE);
> >  }
> >
> > +static inline bool f2fs_is_cow_file(struct inode *inode)
> > +{
> > +       return is_inode_flag_set(inode, FI_COW_FILE);
> > +}
> > +
> >  static inline bool f2fs_is_first_block_written(struct inode *inode)
> >  {
> >         return is_inode_flag_set(inode, FI_FIRST_BLOCK_WRITTEN);
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index a90184900698..973a479f9a3d 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -2062,7 +2062,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> >         spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> >
> >         set_inode_flag(inode, FI_ATOMIC_FILE);
> > -       set_inode_flag(fi->cow_inode, FI_ATOMIC_FILE);
> > +       set_inode_flag(fi->cow_inode, FI_COW_FILE);
> >         clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
> >         f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> >
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 44a04a832e24..6d5fc221ef35 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -193,7 +193,7 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
> >         if (f2fs_is_atomic_file(inode)) {
> >                 if (clean)
> >                         truncate_inode_pages_final(inode->i_mapping);
> > -               clear_inode_flag(fi->cow_inode, FI_ATOMIC_FILE);
> > +               clear_inode_flag(fi->cow_inode, FI_COW_FILE);
> >                 iput(fi->cow_inode);
> >                 fi->cow_inode = NULL;
> >                 clear_inode_flag(inode, FI_ATOMIC_FILE);
> > @@ -3166,7 +3166,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
> >                         return CURSEG_COLD_DATA;
> >                 if (file_is_hot(inode) ||
> >                                 is_inode_flag_set(inode, FI_HOT_DATA) ||
> > -                               f2fs_is_atomic_file(inode))
> > +                               f2fs_is_atomic_file(inode) ||
> 
> I think we can remove f2fs_is_atomic_file(inode) now.

I removed it and applied the patch. :)
Thanks,

> 
> > +                               f2fs_is_cow_file(inode))
> >                         return CURSEG_HOT_DATA;
> >                 return f2fs_rw_hint_to_seg_type(inode->i_write_hint);
> >         } else {
> > --
> > 2.31.1
> >
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
