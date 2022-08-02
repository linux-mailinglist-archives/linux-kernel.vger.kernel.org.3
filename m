Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD7F587511
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiHBBag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiHBBae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:30:34 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583D8324
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:30:33 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31f445bd486so126094637b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 18:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hrCLnMRd56C0uKq9Xt+6DMM0LjkZgl31pvDWpB/p6Uk=;
        b=K5DC4PBZMQ0QfXuHhX/1Ps/QJsw11zK8BhmbsPKGxbegUZwqWUm6pHHD35zVJuVd6w
         lFk/LcqjloMTUP1FMC8MpLWhRxTGCmjHlRL+u54idLaGbnG1LtB2TX1pwkmYAlRWlKbF
         0n1IvSJaP7OkW6PAaVF2aeToc6oeBVaXplJ8y8VCgusd/XnEhxaWUAzrjaGKKv0DfYH2
         i5VqhtLOozeSpZJ6i54Yc72xUtIdPRWrFzPi5LwhYmehci+sgA9hkDC4QuKYq58Tofm6
         waCFgbxcb1nF0bR/Y1LfZL6X+wrjEKe6Hz3GpjScH1yxgecWTxow/ROCgi4RNhxD7Dx4
         MpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrCLnMRd56C0uKq9Xt+6DMM0LjkZgl31pvDWpB/p6Uk=;
        b=bdcEiouyXc+wDKdel2gIfRQCUKZb+PWPCmhYiJRCN8B/UreA7n+dLO4PrusPF1mGib
         RhJhgQjcwszTdetWJfyZ790WWyYcFabFLpNgHeizCqNkykdnQT/f30c6nAfaf6m5lAwj
         ToKRaqp0SS5al/nGpow8qIjngL9fFPyeHFVbcLfJOBuxsNRkPn4HKY6cVQ0lI/nOy8fz
         rO8aD/78jgrBxZ9lXRXe1nTtjWACbtcYub0Flx2sZ/SqfUEOcv0gyEhDCviGASRpYNr+
         aycYV7wTbBnUCJOqSg50/1z0JBSgmbfVC9yJ8Yb9H/X9U+PIekjsEpIvUyNbT/CUl8gp
         drFw==
X-Gm-Message-State: ACgBeo0Ru+Kmr1hFkOuQYpmM0WE78VfHpMMPlowz2yQsvTSc23zDKXxY
        meqwdTjERvvLv8az+AdE5FuPsUZXbKAKKiJq//k=
X-Google-Smtp-Source: AA6agR5Gqeg+KwjmHKNjezWbfmdmNrwr01emOToQvsPw2cGtvYuRoYceUu5tOiQzxJttiAminrnzlhNL6mUM/7AgvPE=
X-Received: by 2002:a81:588a:0:b0:31f:645a:e22 with SMTP id
 m132-20020a81588a000000b0031f645a0e22mr16123952ywb.430.1659403832424; Mon, 01
 Aug 2022 18:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220801112604.3406642-1-yebin10@huawei.com>
In-Reply-To: <20220801112604.3406642-1-yebin10@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 1 Aug 2022 18:30:21 -0700
Message-ID: <CACOAw_yes-aq2EMvXA6hCmV9FLXtRXXwaMW2iB3d7ynjPKa78Q@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH -next v2] f2fs: fix null-ptr-deref in f2fs_get_dnode_of_data
To:     Ye Bin <yebin10@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
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

On Mon, Aug 1, 2022 at 4:15 AM Ye Bin via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> wrote:
>
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
>  <TASK>
>  dump_stack_lvl+0x6e/0x91
>  print_report.cold+0x49a/0x6bb
>  kasan_report+0xa8/0x130
>  f2fs_get_dnode_of_data+0xac/0x16d0
>  f2fs_do_write_data_page+0x2a5/0x1030
>  move_data_page+0x3c5/0xdf0
>  do_garbage_collect+0x2015/0x36c0
>  f2fs_gc+0x554/0x1d30
>  f2fs_balance_fs+0x7f5/0xda0
>  f2fs_write_single_data_page+0xb66/0xdc0
>  f2fs_write_cache_pages+0x716/0x1420
>  f2fs_write_data_pages+0x84f/0x9a0
>  do_writepages+0x130/0x3a0
>  filemap_fdatawrite_wbc+0x87/0xa0
>  file_write_and_wait_range+0x157/0x1c0
>  f2fs_do_sync_file+0x206/0x12d0
>  f2fs_sync_file+0x99/0xc0
>  vfs_fsync_range+0x75/0x140
>  f2fs_file_write_iter+0xd7b/0x1850
>  vfs_write+0x645/0x780
>  ksys_write+0xf1/0x1e0
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> As 3db1de0e582c commit changed atomic write way which new a cow_inode for
> atomic write file, and also mark cow_inode as FI_ATOMIC_FILE.
> When f2fs_do_write_data_page write cow_inode will use cow_inode's cow_inode
> which is NULL. Then will trigger null-ptr-deref.
> To solve above issue, introduce FI_COW_FILE flag for COW inode.
>
> Fiexes: 3db1de0e582c("f2fs: change the current atomic write way")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/f2fs/f2fs.h    | 6 ++++++
>  fs/f2fs/file.c    | 2 +-
>  fs/f2fs/segment.c | 5 +++--
>  3 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 8579b59b8a05..101f0064ee25 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -758,6 +758,7 @@ enum {
>         FI_ENABLE_COMPRESS,     /* enable compression in "user" compression mode */
>         FI_COMPRESS_RELEASED,   /* compressed blocks were released */
>         FI_ALIGNED_WRITE,       /* enable aligned write */
> +       FI_COW_FILE,            /* indicate COW file */
>         FI_MAX,                 /* max flag, never be used */
>  };
>
> @@ -3207,6 +3208,11 @@ static inline bool f2fs_is_atomic_file(struct inode *inode)
>         return is_inode_flag_set(inode, FI_ATOMIC_FILE);
>  }
>
> +static inline bool f2fs_is_cow_file(struct inode *inode)
> +{
> +       return is_inode_flag_set(inode, FI_COW_FILE);
> +}
> +
>  static inline bool f2fs_is_first_block_written(struct inode *inode)
>  {
>         return is_inode_flag_set(inode, FI_FIRST_BLOCK_WRITTEN);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index a90184900698..973a479f9a3d 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2062,7 +2062,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>         spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
>
>         set_inode_flag(inode, FI_ATOMIC_FILE);
> -       set_inode_flag(fi->cow_inode, FI_ATOMIC_FILE);
> +       set_inode_flag(fi->cow_inode, FI_COW_FILE);
>         clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
>         f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 44a04a832e24..6d5fc221ef35 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -193,7 +193,7 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
>         if (f2fs_is_atomic_file(inode)) {
>                 if (clean)
>                         truncate_inode_pages_final(inode->i_mapping);
> -               clear_inode_flag(fi->cow_inode, FI_ATOMIC_FILE);
> +               clear_inode_flag(fi->cow_inode, FI_COW_FILE);
>                 iput(fi->cow_inode);
>                 fi->cow_inode = NULL;
>                 clear_inode_flag(inode, FI_ATOMIC_FILE);
> @@ -3166,7 +3166,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>                         return CURSEG_COLD_DATA;
>                 if (file_is_hot(inode) ||
>                                 is_inode_flag_set(inode, FI_HOT_DATA) ||
> -                               f2fs_is_atomic_file(inode))
> +                               f2fs_is_atomic_file(inode) ||

I think we can remove f2fs_is_atomic_file(inode) now.

> +                               f2fs_is_cow_file(inode))
>                         return CURSEG_HOT_DATA;
>                 return f2fs_rw_hint_to_seg_type(inode->i_write_hint);
>         } else {
> --
> 2.31.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
