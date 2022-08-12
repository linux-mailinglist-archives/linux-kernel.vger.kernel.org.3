Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65C95911A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbiHLNlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbiHLNlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:41:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEDE9F751
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B07D3617E8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 13:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4873EC433D6;
        Fri, 12 Aug 2022 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660311705;
        bh=m1iZhLzdIcy6lPMcG+UufINcqDuACgcrNOkjp/F6Obw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QpO32sO8PhYZEVT69tBOA1fR9EtwY32slMa1L5mgbesYV20NEzpJtzfGPrbY4SYHH
         +/EvCbkKkV7nPz9o//Lw1tcQ7BKsmG2jgYMD54wKPx0/1NVOvKk5XsixDQHv1Wse02
         tr1pJR100XM1FVmIB9/lWxEl4vKUMtCCIXCtMh26RM9c+W/SW9iGRooujCeR92zFTC
         R1Pvy9qedeJc931avUsm1OK28ckVKdB4PriNwAwZlaWPMucrEEdFF+nh6M+uYpFHDd
         UdcB8+TYxQaO5/Cm8KywwEVHr/+CJaUCy4uOx+XAL1WeqqFnZOCAJN2pJhMR7skoyr
         kcRpFdgAnAg2g==
Date:   Fri, 12 Aug 2022 15:41:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: binderfs: fix memory leak in binderfs_fill_super
Message-ID: <20220812134138.gpu7274yahlvr6hr@wittgenstein>
References: <20220812132124.2053673-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220812132124.2053673-1-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 09:21:24PM +0800, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> In binderfs_fill_super, if s_root is not successfully initialized by
> d_make_root, the previous allocated s_sb_info will not be freed since
> generic_shutdown_super first checks if sb->s_root and then does
> put_super operation. The put_super operation calls binderfs_put_super
> to deallocate s_sb_info and put ipc_ns. This will lead to memory leak
> in binderfs_fill_super.
> 
> Fix this by invoking binderfs_put_super at error sites before s_root
> is successfully initialized.
> 
> Fixes: 095cf502b31e ("binderfs: port to new mount api")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---

Seems right but where's the full syzbot link to the issue?
Also, wouldn't (untested) sm like the below be better?:

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 588d753a7a19..4582b043d21e 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -692,6 +692,15 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
        sb->s_magic = BINDERFS_SUPER_MAGIC;
        sb->s_op = &binderfs_super_ops;
        sb->s_time_gran = 1;
+       sb->s_fs_info = NULL;
+
+       inode = new_inode(sb);
+       if (!inode)
+               return -ENOMEM;
+
+       sb->s_root = d_make_root(inode);
+       if (!sb->s_root)
+               return -ENOMEM;

        sb->s_fs_info = kzalloc(sizeof(struct binderfs_info), GFP_KERNEL);
        if (!sb->s_fs_info)
@@ -709,10 +718,6 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
        info->mount_opts.max = ctx->max;
        info->mount_opts.stats_mode = ctx->stats_mode;

-       inode = new_inode(sb);
-       if (!inode)
-               return -ENOMEM;
-
        inode->i_ino = FIRST_INODE;
        inode->i_fop = &simple_dir_operations;
        inode->i_mode = S_IFDIR | 0755;
@@ -720,10 +725,6 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
        inode->i_op = &binderfs_dir_inode_operations;
        set_nlink(inode, 2);

-       sb->s_root = d_make_root(inode);
-       if (!sb->s_root)
-               return -ENOMEM;
-
        ret = binderfs_binder_ctl_create(sb);
        if (ret)
                return ret;

>  drivers/android/binderfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 588d753a7a19..20f5bc77495f 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -710,8 +710,10 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	info->mount_opts.stats_mode = ctx->stats_mode;
>  
>  	inode = new_inode(sb);
> -	if (!inode)
> +	if (!inode) {
> +		binderfs_put_super(sb);
>  		return -ENOMEM;
> +	}
>  
>  	inode->i_ino = FIRST_INODE;
>  	inode->i_fop = &simple_dir_operations;
> @@ -721,8 +723,10 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	set_nlink(inode, 2);
>  
>  	sb->s_root = d_make_root(inode);
> -	if (!sb->s_root)
> +	if (!sb->s_root) {
> +		binderfs_put_super(sb);
>  		return -ENOMEM;
> +	}
>  
>  	ret = binderfs_binder_ctl_create(sb);
>  	if (ret)
> -- 
> 2.25.1
> 
