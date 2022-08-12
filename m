Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13D25911B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbiHLNt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiHLNtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:49:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52584A50E5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:49:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x21so1425607edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7AFiTG5TAXnB5fvKCQf+++SXrQCe+l505NPj1becQ5c=;
        b=jCnxehuYeSEg1Bm3oVBS7KAsoXbC4hrLuDdUs9sIjOdLeKDUnNGJHzhCTDBuFxrx0V
         NvvBEt8C6sEWWrdV8FhV5816gW8j8MoNPP0I8jCt2Gvv+Uf3QvroZ4F5IzHA0FL6ATxj
         4MjPKr7YHsa+lQBZdABoGhJceirzjr6VZrhT5ZhYGGogNs7laJ5W57iYfxviFpHE7cdU
         g4219lS9EgcvYR7babmOPuDQPFzXZ6Q/Pk5CDDAiz7KcEKigyupZVlgRNaW/Cm1v3Mif
         c9VdzX1a0d+8L2gn1wk9HsGAeUpob85NgQueeQkNtIo1LCdorT9TnH8lrPb6xjfrSGMa
         iHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7AFiTG5TAXnB5fvKCQf+++SXrQCe+l505NPj1becQ5c=;
        b=rn66t6zZXz2nXA/bJ6jmcAlJNigY8u7SSs3JMpN1UmLP5tyBddfv/Y08zA1lSnn+KL
         MIs9cXSGyLV8zfWC+WRvCeENb/bHv2SocMTdEsvUjq/I7ulQeF+IgvlYS+nNqZjsqRuC
         IFU65F3D1K6GaNuRjfz0YTlltmU4/AZPOgloFbEWs0oZ4qIu2ndxRR5KurrkziTvU3M+
         Fb18nymYC7/ZBFJo4d0Ru2GTBTA+6SZU//WOd160M8hYHkQx448YVOHMJToT0A17taw/
         vGIKNfs7jnGfAEtRclxLMgz54s/29BWA/kSUMxTVlD0r1HDyrn6zSQAqz0Ur1j84QBlF
         y/Sw==
X-Gm-Message-State: ACgBeo2pz2mXAjN29mVkhSc8cArZSLrr0M2tIPSIdCLAX+AvJj6lzUS4
        f5R2LBr7FYEF1uu0wwsXDLlUxbwUcvyGbe9CR1Kb9rgI
X-Google-Smtp-Source: AA6agR4VtibhFUH/ds8v9YejB0qbw6TefHdMOit3eiELmgq02Gvf77Rl81V0dmPpWbb6J2DbEAoVheUzb4Pca85IHZY=
X-Received: by 2002:a05:6402:268a:b0:43e:84d:c5cc with SMTP id
 w10-20020a056402268a00b0043e084dc5ccmr3731031edd.372.1660312158755; Fri, 12
 Aug 2022 06:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220812132124.2053673-1-dzm91@hust.edu.cn> <20220812134138.gpu7274yahlvr6hr@wittgenstein>
In-Reply-To: <20220812134138.gpu7274yahlvr6hr@wittgenstein>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 12 Aug 2022 21:48:40 +0800
Message-ID: <CAD-N9QWSwoLw9nvaQieUCPZoAYXyNTymUVOzKOTUOfC38FkXnA@mail.gmail.com>
Subject: Re: [PATCH] drivers: binderfs: fix memory leak in binderfs_fill_super
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 9:41 PM Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Aug 12, 2022 at 09:21:24PM +0800, Dongliang Mu wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > In binderfs_fill_super, if s_root is not successfully initialized by
> > d_make_root, the previous allocated s_sb_info will not be freed since
> > generic_shutdown_super first checks if sb->s_root and then does
> > put_super operation. The put_super operation calls binderfs_put_super
> > to deallocate s_sb_info and put ipc_ns. This will lead to memory leak
> > in binderfs_fill_super.
> >
> > Fix this by invoking binderfs_put_super at error sites before s_root
> > is successfully initialized.
> >
> > Fixes: 095cf502b31e ("binderfs: port to new mount api")
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
>
> Seems right but where's the full syzbot link to the issue?
> Also, wouldn't (untested) sm like the below be better?:

I originally would like to change the order to object initialization,
but I am not sure if they can be exchanged since many *_fill_super are
ended with d_make_root.

If you are sure about this exchange, I can resubmit a v2 patch.

>
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 588d753a7a19..4582b043d21e 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -692,6 +692,15 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
>         sb->s_magic = BINDERFS_SUPER_MAGIC;
>         sb->s_op = &binderfs_super_ops;
>         sb->s_time_gran = 1;
> +       sb->s_fs_info = NULL;
> +
> +       inode = new_inode(sb);
> +       if (!inode)
> +               return -ENOMEM;
> +
> +       sb->s_root = d_make_root(inode);
> +       if (!sb->s_root)
> +               return -ENOMEM;
>
>         sb->s_fs_info = kzalloc(sizeof(struct binderfs_info), GFP_KERNEL);
>         if (!sb->s_fs_info)
> @@ -709,10 +718,6 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
>         info->mount_opts.max = ctx->max;
>         info->mount_opts.stats_mode = ctx->stats_mode;
>
> -       inode = new_inode(sb);
> -       if (!inode)
> -               return -ENOMEM;
> -
>         inode->i_ino = FIRST_INODE;
>         inode->i_fop = &simple_dir_operations;
>         inode->i_mode = S_IFDIR | 0755;
> @@ -720,10 +725,6 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
>         inode->i_op = &binderfs_dir_inode_operations;
>         set_nlink(inode, 2);
>
> -       sb->s_root = d_make_root(inode);
> -       if (!sb->s_root)
> -               return -ENOMEM;
> -
>         ret = binderfs_binder_ctl_create(sb);
>         if (ret)
>                 return ret;
>
> >  drivers/android/binderfs.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > index 588d753a7a19..20f5bc77495f 100644
> > --- a/drivers/android/binderfs.c
> > +++ b/drivers/android/binderfs.c
> > @@ -710,8 +710,10 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
> >       info->mount_opts.stats_mode = ctx->stats_mode;
> >
> >       inode = new_inode(sb);
> > -     if (!inode)
> > +     if (!inode) {
> > +             binderfs_put_super(sb);
> >               return -ENOMEM;
> > +     }
> >
> >       inode->i_ino = FIRST_INODE;
> >       inode->i_fop = &simple_dir_operations;
> > @@ -721,8 +723,10 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
> >       set_nlink(inode, 2);
> >
> >       sb->s_root = d_make_root(inode);
> > -     if (!sb->s_root)
> > +     if (!sb->s_root) {
> > +             binderfs_put_super(sb);
> >               return -ENOMEM;
> > +     }
> >
> >       ret = binderfs_binder_ctl_create(sb);
> >       if (ret)
> > --
> > 2.25.1
> >
