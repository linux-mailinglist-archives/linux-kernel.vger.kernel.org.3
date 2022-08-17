Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05EC59729D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbiHQPGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbiHQPFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:05:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D035FA4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:05:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B8E26154D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C290FC433D6;
        Wed, 17 Aug 2022 15:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660748733;
        bh=tfwd0rUf/nGoXOai5hLFPQArp2xvz79+ZguU3BcAs90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tMOKTArVJ+btfvBAT9wiWXbIAixE2o3dKAW9wtwS8tcM4Usg8Wo0GObRgB3pK1SH3
         v9OD7F4t0fbI2PYpNSfPt1Hq+1LWv4jUM7sEHDfizrtQ73Otc1k6qKqMyahonm9P8I
         Pf7kL0nywvc02zI5BElQQIRmA2Lch4LG8V8BWYiSbhbNZRhrh/xNYTyE68cINOhntY
         3k5hgJiecCtudmbUGwVPNtQKaYxipBg/JNYNqCzh43BLWNOjDHEF2/2k6R/gMmMlvr
         A9sJ5UsPoC12612Ln6a63GY/lI4hxIav+ZxljOSJ0O5yHSaMkKonEHloDcg17uyy6f
         gbJHbohpx0SuQ==
Date:   Wed, 17 Aug 2022 17:05:27 +0200
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
Subject: Re: [PATCH] binderfs: rework superblock destruction
Message-ID: <20220817150527.g5l5cwhphx6wdvxr@wittgenstein>
References: <YvzUS/7bd1mm6c/V@kroah.com>
 <20220817130306.96978-1-brauner@kernel.org>
 <Yvz0JkdxXwY8uDyT@ZenIV>
 <20220817140149.pfakskeyxkqcot54@wittgenstein>
 <Yvz44WHBh94IvJt/@ZenIV>
 <Yvz747fDzx8oO2Ym@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yvz747fDzx8oO2Ym@ZenIV>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 03:32:03PM +0100, Al Viro wrote:
> On Wed, Aug 17, 2022 at 03:19:13PM +0100, Al Viro wrote:
> > On Wed, Aug 17, 2022 at 04:01:49PM +0200, Christian Brauner wrote:
> > > On Wed, Aug 17, 2022 at 02:59:02PM +0100, Al Viro wrote:
> > > > On Wed, Aug 17, 2022 at 03:03:06PM +0200, Christian Brauner wrote:
> > > > 
> > > > > +static void binderfs_kill_super(struct super_block *sb)
> > > > > +{
> > > > > +	struct binderfs_info *info = sb->s_fs_info;
> > > > > +
> > > > > +	if (info && info->ipc_ns)
> > > > > +		put_ipc_ns(info->ipc_ns);
> > > > > +
> > > > > +	kfree(info);
> > > > > +	kill_litter_super(sb);
> > > > > +}
> > > > 
> > > > Other way round, please - shut the superblock down, *then*
> > > > free the objects it'd been using.  IOW,
> > > 
> > > I wondered about that but a lot of places do it the other way around.
> > > So maybe the expected order should be documented somewhere.
> > 
> > ???
> > 
> > "If you are holding internal references to dentries/inodes/etc., drop them
> > first; if you are going to free something that is used by filesystem
> > methods, don't do that before the filesystem is shut down"
> > 
> > That's just common sense...  Which filesystems are doing that "the other
> > way around"?
> 
> Note that something like e.g. ramfs, where we have a dynamically allocated
> object ->s_fs_info is pointing to and gets freed early in their ->kill_sb()
> is somewhat misleading - it's used only for two things, one is the
> creation of root directory inode (obviously not going to happen at any
> point after mount) and another - ->show_options().  By the point we get
> around to killing a superblock, it would better *NOT* have mounts pointing
> to it that might show up in /proc/mounts and make us call ->show_options().
> 
> So there we really know that nothing during the shutdown will even look
> at that thing we'd just freed.  Not that there'd ever been a point allocating
> it - all that object contains is one unsigned short, so we might as well
> just have stored (void *)root_mode in ->s_fs_info.  Oh, well...

Binderfs was really the first fs I ever wrote and back then I was trying
to be as close to best practice at possible. One thing I remember being
unclear about was what the best practice for filesystem shutdown would
be. That included ->put_super() vs just ->kill_sb() but also the order
in which kill_litter_super() and sb->s_fs_info cleanup should happen.

For binderfs the order does matter and that's also the reason I
originally decided to use ->put_super() as it's called after
evict_inodes() and gives the required ordering.
