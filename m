Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A0E592D81
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiHOIrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiHOIrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:47:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574C9201BD
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F026B60F1E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B76AC433C1;
        Mon, 15 Aug 2022 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660553266;
        bh=bJvGWwT8A0Q4dyc+TqUEGNYC5aDA/VVaF5lmkOvETkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CCjMtUYFxI+t77nFtlJhFhhm2muo3L9o3y7rCbkgPhU1D9Vqabtz5aMXwlNpou+UN
         eiqAyZBC9CT71n1gsF4pNlrca827bX0+1vyavA/gJQA9bFaRW8To9BWQI72dkw5dmc
         osVRCyN6Fix9DNh2hQVSGiYhWgp9D80L01NBLP6U07kzsDqvuLlb4ljHQmXvI4vZVg
         jDvsvJM9lj2BOk+HKP6z5xbFNJWUDLOTWW65IIvNEg7NN8RYJjiv/NT4878P0gQvl3
         FEXYmCza5lHgra6ckAiZFHzS7qgEBryEZf0OfZnoK9wIeMKeSQCvgP68WNQL8e4/60
         MYT3icle7HFoA==
Date:   Mon, 15 Aug 2022 10:47:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: binderfs: fix memory leak in binderfs_fill_super
Message-ID: <20220815084740.2jpqud4htermrdko@wittgenstein>
References: <20220812132124.2053673-1-dzm91@hust.edu.cn>
 <YvZYmprZ1NiMkynp@kroah.com>
 <CAD-N9QWU_tcnHMtP3iWcQogSWwDET4nhK5AQKDbh2KJQzwfF9A@mail.gmail.com>
 <YvZfEwFL7GSHEzs8@kroah.com>
 <20220812142423.33wnvnjg6v2h2m3y@wittgenstein>
 <YvZkfPak2UMSc1tS@kroah.com>
 <YvmlfBJTiOQVfVtX@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvmlfBJTiOQVfVtX@ZenIV>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 02:46:36AM +0100, Al Viro wrote:
> On Fri, Aug 12, 2022 at 04:32:28PM +0200, Greg Kroah-Hartman wrote:
> 
> > > It's a bit tricky to follow but d_make_root() always consumes the inode.
> > > On success via d_instantiate() and on failure via iput(). So when
> > > d_make_root() has been called the inode is off limits. And as soon as
> > > d_make_root() has returned successfully we're guaranteed that
> > > sb->s_fs_info is cleaned up if a ->put_super() method has been defined.
> > > Just fyi.
> > 
> > Ah, thanks, that wasn't obvious at all.
> > 
> > greg k-h
> 
> FWIW, I would rather provide a proper ->kill_sb() and gotten rid of
> all that stuff.  The thing is, unlike ->put_super(), ->kill_sb() is
> called for *anything* that has gotten to foo_fill_super().  Usually
> allows to get rid of those "call all of or parts of foo_put_super()
> on failure exits" and associated bitrot...
> 
> Like this (completely untested):
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Sounds good,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 588d753a7a19..c760f3129768 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -340,22 +340,21 @@ static int binderfs_show_options(struct seq_file *seq, struct dentry *root)
>  	return 0;
>  }
>  
> -static void binderfs_put_super(struct super_block *sb)
> +static void binderfs_kill_super(struct super_block *sb)
>  {
>  	struct binderfs_info *info = sb->s_fs_info;
>  
> +	kill_litter_super(sb);
>  	if (info && info->ipc_ns)
>  		put_ipc_ns(info->ipc_ns);
>  
>  	kfree(info);
> -	sb->s_fs_info = NULL;
>  }
>  
>  static const struct super_operations binderfs_super_ops = {
>  	.evict_inode    = binderfs_evict_inode,
>  	.show_options	= binderfs_show_options,
>  	.statfs         = simple_statfs,
> -	.put_super	= binderfs_put_super,
>  };
>  
>  static inline bool is_binderfs_control_device(const struct dentry *dentry)
> @@ -789,7 +788,7 @@ static struct file_system_type binder_fs_type = {
>  	.name			= "binder",
>  	.init_fs_context	= binderfs_init_fs_context,
>  	.parameters		= binderfs_fs_parameters,
> -	.kill_sb		= kill_litter_super,
> +	.kill_sb		= binderfs_kill_super,
>  	.fs_flags		= FS_USERNS_MOUNT,
>  };
>  
