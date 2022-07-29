Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A05585484
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbiG2RbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiG2RbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:31:05 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD77315702
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:31:02 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31f445bd486so57686787b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ks2Xaq3aimkHGcY2BTkihJ+k/bcPqBj8oKyRR6HCXEw=;
        b=qqeytMJyWaGHIOkiwfk0edsMlhdhvGZnezlc7rqmMiLvbbXp8qX+Otc/BkjD4zzKCA
         IZ4coVKJrZFBxmJMeo1PZmk6RTgc1CQ13u1yRbU1Rs+XdEiWemOryygZnzjEAugS6lD4
         s0n1ul7Mhzjon80HMvZ3VkcbAeZoS1/BtbxPXvqSBxzaVWoHLhuYdBsK1o1D5uz4e9rO
         7zprjwooSB7/UXyNzJVR5ZW4fq2C284cPv6JT9q6d1+i/JIiZhOsToFP9tBibisit34c
         zUio5qv40SWeZzEffuKQ4ui3iVeIepzQnATxSuDNBhR/nDFY9yEnFEORVituom0Nsd/E
         yQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ks2Xaq3aimkHGcY2BTkihJ+k/bcPqBj8oKyRR6HCXEw=;
        b=vL+pA9FcXrXSUWqe6jY2o5YGByLHqmAMcFeNN1eljpMknTTI//lQ0nUBhYlM3Yjpd8
         idaZftQJDfLTCOUA4O7/c7r33gkyVvis6xJtVzwYAiENeJKTRg6lVGpOLS4vQtDlorfL
         84kra9C4KdnZoJ4sXHcHrzVcuicnKzydmGrTnRXteuu+Cve9wnMVJgt0aSowV36GLOB5
         f4UUEsArNbILvwNddw1ISDyo8ASwaMa5CptCN/pUL5w1XXC+kk/n3SuIOF1FDqCMwolB
         YR5QUcmYru29eAv4i4t6iTfmdq1NGc7tytpbRJ+w5PwpBFNfNPp6qL56DDCjP6nZ6ery
         8lKQ==
X-Gm-Message-State: ACgBeo3gB40+HIYGxk3Jp1YpbYnfNOMrw9pNaPMTIv8JYOVLzfQFm1Yi
        NXrR7l0MJRzOtVApQIEJYGRjBYobkl1n2Q9tV4U=
X-Google-Smtp-Source: AA6agR5aHVWeIdVQn7lagAV2GwBcncryimhtMowoxBxSTFyYGC21RHTcj2zWwIR+SG7/hl5QydnPj+0AtQcxRmSzuT0=
X-Received: by 2002:a81:78d:0:b0:2e5:d440:d921 with SMTP id
 135-20020a81078d000000b002e5d440d921mr3861530ywh.251.1659115861813; Fri, 29
 Jul 2022 10:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220718113609.154371-1-yebin10@huawei.com> <e82f0d90-7fda-c944-149f-d18491008f3f@kernel.org>
In-Reply-To: <e82f0d90-7fda-c944-149f-d18491008f3f@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 29 Jul 2022 10:30:50 -0700
Message-ID: <CACOAw_xCdz4rO-LGshaZin4CzsE+8MTb_DPe0h+=vJ8KGwXa1A@mail.gmail.com>
Subject: Re: [PATCH -next RFC] f2fs: fix null-ptr-deref in f2fs_get_dnode_of_data
To:     Chao Yu <chao@kernel.org>
Cc:     Ye Bin <yebin10@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 3:21 AM Chao Yu <chao@kernel.org> wrote:
>
> On 2022/7/18 19:36, Ye Bin wrote:
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
> >   <TASK>
> >   dump_stack_lvl+0x6e/0x91
> >   print_report.cold+0x49a/0x6bb
> >   kasan_report+0xa8/0x130
> >   f2fs_get_dnode_of_data+0xac/0x16d0
> >   f2fs_do_write_data_page+0x2a5/0x1030
> >   move_data_page+0x3c5/0xdf0
> >   do_garbage_collect+0x2015/0x36c0
> >   f2fs_gc+0x554/0x1d30
> >   f2fs_balance_fs+0x7f5/0xda0
> >   f2fs_write_single_data_page+0xb66/0xdc0
> >   f2fs_write_cache_pages+0x716/0x1420
> >   f2fs_write_data_pages+0x84f/0x9a0
> >   do_writepages+0x130/0x3a0
> >   filemap_fdatawrite_wbc+0x87/0xa0
> >   file_write_and_wait_range+0x157/0x1c0
> >   f2fs_do_sync_file+0x206/0x12d0
> >   f2fs_sync_file+0x99/0xc0
> >   vfs_fsync_range+0x75/0x140
> >   f2fs_file_write_iter+0xd7b/0x1850
> >   vfs_write+0x645/0x780
> >   ksys_write+0xf1/0x1e0
> >   do_syscall_64+0x3b/0x90
> >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > As 3db1de0e582c commit changed atomic write way which new a cow_inode for
> > atomic write file, and also mark cow_inode as FI_ATOMIC_FILE.
> > When f2fs_do_write_data_page write cow_inode will use cow_inode's cow_inode
> > which is NULL. Then will trigger null-ptr-deref.
> > To solve above issue, don't mark cow_inode as FI_ATOMIC_FILE.
> >
> > Fiexes: 3db1de0e582c("f2fs: change the current atomic write way")
> > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > ---
> >   fs/f2fs/file.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 466eb00aa516..735802b6b754 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -2062,7 +2062,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> >       spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> >
> >       set_inode_flag(inode, FI_ATOMIC_FILE);
> > -     set_inode_flag(fi->cow_inode, FI_ATOMIC_FILE);
>
> It needs to remove clear_inode_flag(fi->cow_inode, FI_ATOMIC_FILE) in
> f2fs_abort_atomic_write()?
>
> To Daeho, could you please review this patch? IIUC, cow_inode doesn't
> need to be set as atomic file?
>

Sorry for the late reply, I was OOO.

I think I missed the FG GC case for COW inode. :(
I used the FI_ATOMIC_FILE flag for COW inode in
__get_segment_type_6(). Maybe we need another flag for the COW inode
case in the function, if we remove the flag from the COW inode.
Plus, we need to remove clear_inode_flag(fi->cow_inode,
FI_ATOMIC_FILE) too in f2fs_abort_atomic_write().

Thanks,

> Thanks,
>
> >       clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
> >       f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> >
