Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDF95911EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiHLOJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237287AbiHLOJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:09:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAF8AB06A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:09:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD8CFB82435
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 14:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8FEC433C1;
        Fri, 12 Aug 2022 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660313366;
        bh=P/YwCx8KIlvJImMMOI4qn/OI5pBpHMATs70bdyoQlGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+vjPIgCvQjaedRp7HML66QeZ5xUX/j0pimp06TbIoGxywEZL8lNIzCE0Ldnt5ORc
         73JPwMiLoCd5P1qH7isVQgKtY3xX4l+OaBV+Gb+3UIIx75VkiyikcFR32Z2kbbjt2Z
         Bu6DnyCkoDhsjUFrU3hF35r51OGgvATbx4/7kuCg=
Date:   Fri, 12 Aug 2022 16:09:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: binderfs: fix memory leak in binderfs_fill_super
Message-ID: <YvZfEwFL7GSHEzs8@kroah.com>
References: <20220812132124.2053673-1-dzm91@hust.edu.cn>
 <YvZYmprZ1NiMkynp@kroah.com>
 <CAD-N9QWU_tcnHMtP3iWcQogSWwDET4nhK5AQKDbh2KJQzwfF9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-N9QWU_tcnHMtP3iWcQogSWwDET4nhK5AQKDbh2KJQzwfF9A@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 09:56:46PM +0800, Dongliang Mu wrote:
> On Fri, Aug 12, 2022 at 9:41 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Aug 12, 2022 at 09:21:24PM +0800, Dongliang Mu wrote:
> > > From: Dongliang Mu <mudongliangabcd@gmail.com>
> > >
> > > In binderfs_fill_super, if s_root is not successfully initialized by
> > > d_make_root, the previous allocated s_sb_info will not be freed since
> > > generic_shutdown_super first checks if sb->s_root and then does
> > > put_super operation. The put_super operation calls binderfs_put_super
> > > to deallocate s_sb_info and put ipc_ns. This will lead to memory leak
> > > in binderfs_fill_super.
> > >
> > > Fix this by invoking binderfs_put_super at error sites before s_root
> > > is successfully initialized.
> > >
> > > Fixes: 095cf502b31e ("binderfs: port to new mount api")
> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> >
> > Where is the specific syzkaller link for this report?  It would be good
> > to reference it so it can be properly checked.
> >
> > Also, how did you test this change?
> 
> I found this memory leak in my local syzkaller, and there is no any
> syzbot report about this crash, therefore I use such a Reported-by to
> indicate.
> 
> Although my local syzkaller does generate any reproducer, this bug can
> be triggered by injecting faults at new_inode and d_make_root (i.e.,
> between s_sb_info allocation and code after d_make_root).
> 
> >
> > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > ---
> > >  drivers/android/binderfs.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > > index 588d753a7a19..20f5bc77495f 100644
> > > --- a/drivers/android/binderfs.c
> > > +++ b/drivers/android/binderfs.c
> > > @@ -710,8 +710,10 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
> > >       info->mount_opts.stats_mode = ctx->stats_mode;
> > >
> > >       inode = new_inode(sb);
> > > -     if (!inode)
> > > +     if (!inode) {
> > > +             binderfs_put_super(sb);
> > >               return -ENOMEM;
> > > +     }
> > >
> > >       inode->i_ino = FIRST_INODE;
> > >       inode->i_fop = &simple_dir_operations;
> > > @@ -721,8 +723,10 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
> > >       set_nlink(inode, 2);
> > >
> > >       sb->s_root = d_make_root(inode);
> > > -     if (!sb->s_root)
> > > +     if (!sb->s_root) {
> > > +             binderfs_put_super(sb);
> > >               return -ENOMEM;
> > > +     }
> >
> > How did you test this change to verify that you are not now just leaking
> > memory?  It looks to me like you just changed one problem for another
> > one :(
> 
> As mentioned above, I just tested my change by injecting faults at
> new_inode and d_make_root.
> 
> Can you explain more about "changed one problem for another one"? I
> don't quite understand this statement.

I think you are leaking memory in at least your second change here,
possibly the first, I didn't look at the code very closely.

So please verify that you do not add problems when trying to remove
them.

Also, really, in a normal system, this path is impossible to hit.

thanks,

greg k-h
