Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE635972DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbiHQPY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbiHQPYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:24:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B44F474D0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0299B81DEB
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C5BC433D6;
        Wed, 17 Aug 2022 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660749856;
        bh=xTtJjXGNhDWke+LchiMrKqaxAdbT5dOBP8kw/+hqhVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KSvwHzhIDTxfugXMZn1HGBze0PFIQabONX4VdldMUbsVDCjzEl3ZQ2DQu3Bg26epb
         MjkpRbqGd1Y+7c7B9fVIWtANKWsERSovMkzP1Cv2E5f52vCsGseKHGqj7X4VHrWY0E
         mfQwIcKEEUG5VVsSutuy4y5Vfd0rTi+QWqUR03tf33pDhdJBYlaQCgybGwdyGH+2+S
         wEjrmewHS+Rg5K/RCSA1GTAJ30f+z3GMcBhcLhopcPEwuie3V4jGMoNSH7YaMCOgAH
         oaWpMX5tGwF38DhIhY2Qw1Me2Fc615ni1r3vS+RjckxCNeNGAjAPhV4XCFBtMTHCHr
         yiGISl/qT//xA==
Date:   Wed, 17 Aug 2022 17:24:10 +0200
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
Message-ID: <20220817152410.7uhhmumubcead2at@wittgenstein>
References: <YvzUS/7bd1mm6c/V@kroah.com>
 <20220817130306.96978-1-brauner@kernel.org>
 <Yvz0JkdxXwY8uDyT@ZenIV>
 <20220817140149.pfakskeyxkqcot54@wittgenstein>
 <Yvz44WHBh94IvJt/@ZenIV>
 <20220817145144.mbcbvpepusdvrds4@wittgenstein>
 <Yv0HZ8lxn2m6sUut@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv0HZ8lxn2m6sUut@ZenIV>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 04:21:11PM +0100, Al Viro wrote:
> On Wed, Aug 17, 2022 at 04:51:44PM +0200, Christian Brauner wrote:
> 
> > diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> > index 5c97f48cea91..d7d275ef132f 100644
> > --- a/arch/s390/hypfs/inode.c
> > +++ b/arch/s390/hypfs/inode.c
> > @@ -329,9 +329,8 @@ static void hypfs_kill_super(struct super_block *sb)
> >  		hypfs_delete_tree(sb->s_root);
> >  	if (sb_info && sb_info->update_file)
> >  		hypfs_remove(sb_info->update_file);
> > -	kfree(sb->s_fs_info);
> > -	sb->s_fs_info = NULL;
> >  	kill_litter_super(sb);
> > +	kfree(sb->s_fs_info);
> 
> UAF, that - *sb gets freed by the time you try to fetch sb->s_fs_info...
> Fetch the pointer first, then destroy the object you've fetched it
> from, then free what it points to...

Please note the "completely untested" in the draft... ;)

If you want me to, I can turn this into something serious to review.

> 
> > diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> > index 4f25015aa534..78a9095e1748 100644
> > --- a/fs/devpts/inode.c
> > +++ b/fs/devpts/inode.c
> > @@ -509,10 +509,10 @@ static void devpts_kill_sb(struct super_block *sb)
> >  {
> >  	struct pts_fs_info *fsi = DEVPTS_SB(sb);
> >  
> > +	kill_litter_super(sb);
> >  	if (fsi)
> >  		ida_destroy(&fsi->allocated_ptys);
> >  	kfree(fsi);
> > -	kill_litter_super(sb);
> >  }
> >  
> 
> That one's fine.
> 
> >  static struct file_system_type devpts_fs_type = {
> > diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> > index bc66d0173e33..bff49294e037 100644
> > --- a/fs/ramfs/inode.c
> > +++ b/fs/ramfs/inode.c
> > @@ -280,8 +280,10 @@ int ramfs_init_fs_context(struct fs_context *fc)
> >  
> >  static void ramfs_kill_sb(struct super_block *sb)
> >  {
> > -	kfree(sb->s_fs_info);
> > +	struct ramfs_fs_info *fsi = sb->s_fs_info;
> > +
> >  	kill_litter_super(sb);
> > +	kfree(fsi);
> >  }
> 
> Cosmetical, really - see another posting in the same thread.
> 
> >  static struct file_system_type ramfs_fs_type = 
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > index 8fcdd494af27..fb1dae422d93 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -96,9 +96,8 @@ static int selinux_fs_info_create(struct super_block *sb)
> >  	return 0;
> >  }
> >  
> > -static void selinux_fs_info_free(struct super_block *sb)
> > +static void selinux_fs_info_free(struct selinux_fs_info *fsi)
> >  {
> > -	struct selinux_fs_info *fsi = sb->s_fs_info;
> >  	int i;
> >  
> >  	if (fsi) {
> > @@ -107,8 +106,7 @@ static void selinux_fs_info_free(struct super_block *sb)
> >  		kfree(fsi->bool_pending_names);
> >  		kfree(fsi->bool_pending_values);
> >  	}
> > -	kfree(sb->s_fs_info);
> > -	sb->s_fs_info = NULL;
> > +	kfree(fsi);
> >  }
> >  
> >  #define SEL_INITCON_INO_OFFSET		0x01000000
> > @@ -2180,7 +2178,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
> >  	pr_err("SELinux: %s:  failed while creating inodes\n",
> >  		__func__);
> >  
> > -	selinux_fs_info_free(sb);
> > +	selinux_fs_info_free(fsi);
> >  
> >  	return ret;
> >  }
> > @@ -2202,8 +2200,10 @@ static int sel_init_fs_context(struct fs_context *fc)
> >  
> >  static void sel_kill_sb(struct super_block *sb)
> >  {
> > -	selinux_fs_info_free(sb);
> > +	struct selinux_fs_info *fsi = sb->s_fs_info;
> > +
> >  	kill_litter_super(sb);
> > +	selinux_fs_info_free(fsi);
> >  }
> 
> A real bug, but an incomplete fix - you've just gotten yourself a double-free;
> failure in sel_fill_super() has no need to do selinux_fs_info_free() now.

Please note the "completely untested" in the draft... ;)
