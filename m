Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D68597159
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbiHQOc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbiHQOcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:32:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EF89676C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ci/l+oJ2hlAsRJOTtN5Ym+rTxP3jH6w4L9DWyAnNO5s=; b=kqvrMuMqEGhoSnMRwHTyieN5hi
        oNJwGcdEvn2+JXgNxDvz9G8nqXYsxtOciMl6t1za+cI5jFHl6CDAhquxE+b752NZcO5NKfwHQDIcb
        B9Z6x7LMD2ZCxIGNZcZsfZzA+d/Zyb2aNeqSL0/8MY0CxgIkEqa1toTz6ZdLaYv5rJJ2WUyQx15UB
        ZPBjljHiSQ5Vjly+ZdCQkktTE7EvHzjO4gpR3x+/+WAHHv5biqeduAWAvzh7vim2Kz1vvo+B5mfjY
        3TG1y+WvEB0QQ4/gl6GCUWHQqzqOUiTEkxI8OIqbdKklo+KUo5xFF/vE3E6TBZMZvftReFol6Glyp
        GiV10RhQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oOK5T-005OCZ-5v;
        Wed, 17 Aug 2022 14:32:03 +0000
Date:   Wed, 17 Aug 2022 15:32:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] binderfs: rework superblock destruction
Message-ID: <Yvz747fDzx8oO2Ym@ZenIV>
References: <YvzUS/7bd1mm6c/V@kroah.com>
 <20220817130306.96978-1-brauner@kernel.org>
 <Yvz0JkdxXwY8uDyT@ZenIV>
 <20220817140149.pfakskeyxkqcot54@wittgenstein>
 <Yvz44WHBh94IvJt/@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvz44WHBh94IvJt/@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 03:19:13PM +0100, Al Viro wrote:
> On Wed, Aug 17, 2022 at 04:01:49PM +0200, Christian Brauner wrote:
> > On Wed, Aug 17, 2022 at 02:59:02PM +0100, Al Viro wrote:
> > > On Wed, Aug 17, 2022 at 03:03:06PM +0200, Christian Brauner wrote:
> > > 
> > > > +static void binderfs_kill_super(struct super_block *sb)
> > > > +{
> > > > +	struct binderfs_info *info = sb->s_fs_info;
> > > > +
> > > > +	if (info && info->ipc_ns)
> > > > +		put_ipc_ns(info->ipc_ns);
> > > > +
> > > > +	kfree(info);
> > > > +	kill_litter_super(sb);
> > > > +}
> > > 
> > > Other way round, please - shut the superblock down, *then*
> > > free the objects it'd been using.  IOW,
> > 
> > I wondered about that but a lot of places do it the other way around.
> > So maybe the expected order should be documented somewhere.
> 
> ???
> 
> "If you are holding internal references to dentries/inodes/etc., drop them
> first; if you are going to free something that is used by filesystem
> methods, don't do that before the filesystem is shut down"
> 
> That's just common sense...  Which filesystems are doing that "the other
> way around"?

Note that something like e.g. ramfs, where we have a dynamically allocated
object ->s_fs_info is pointing to and gets freed early in their ->kill_sb()
is somewhat misleading - it's used only for two things, one is the
creation of root directory inode (obviously not going to happen at any
point after mount) and another - ->show_options().  By the point we get
around to killing a superblock, it would better *NOT* have mounts pointing
to it that might show up in /proc/mounts and make us call ->show_options().

So there we really know that nothing during the shutdown will even look
at that thing we'd just freed.  Not that there'd ever been a point allocating
it - all that object contains is one unsigned short, so we might as well
just have stored (void *)root_mode in ->s_fs_info.  Oh, well...
