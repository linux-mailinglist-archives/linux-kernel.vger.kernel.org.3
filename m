Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE750592798
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiHOBq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHOBq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:46:56 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021B5270F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=04Ly7rVHtCVp63y7Is8m4DOrsuVX/Szmz+79w4M/yxc=; b=luj+3rPhMJ1NYhS2VgcrtPh+DD
        9yMwyNDUyrgEolY89SijzP9UR8j4tnRS7E4UTkxFHHOpPsvj1kbgsn5wgiol9FIn9bvFVcgrVNuT5
        RfE5/cUfSdPglvRDGPj8ML68Y1GBEtfE1kTUJ5ZXcxg7DTU7Rc4YBhQ2rqGhFRBimADNMBfA7hg0/
        uklvDu+hiitgYXsQ/TmIYrg+MI7C9v0WYr5Tc2EaL4RR4siMJwhb82GQfjc8o3v2Bb5HHeApoeoX9
        z0zjxPd0CtDbbQAbLEl4DiF8znEVDD/X8j3b5/ePvC/XLSHbB3HV9IDadsDsq1UruifVLvHgy7+AU
        fbIakg3g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oNPBc-004OEl-1R;
        Mon, 15 Aug 2022 01:46:36 +0000
Date:   Mon, 15 Aug 2022 02:46:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
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
Subject: Re: [PATCH] drivers: binderfs: fix memory leak in binderfs_fill_super
Message-ID: <YvmlfBJTiOQVfVtX@ZenIV>
References: <20220812132124.2053673-1-dzm91@hust.edu.cn>
 <YvZYmprZ1NiMkynp@kroah.com>
 <CAD-N9QWU_tcnHMtP3iWcQogSWwDET4nhK5AQKDbh2KJQzwfF9A@mail.gmail.com>
 <YvZfEwFL7GSHEzs8@kroah.com>
 <20220812142423.33wnvnjg6v2h2m3y@wittgenstein>
 <YvZkfPak2UMSc1tS@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvZkfPak2UMSc1tS@kroah.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 04:32:28PM +0200, Greg Kroah-Hartman wrote:

> > It's a bit tricky to follow but d_make_root() always consumes the inode.
> > On success via d_instantiate() and on failure via iput(). So when
> > d_make_root() has been called the inode is off limits. And as soon as
> > d_make_root() has returned successfully we're guaranteed that
> > sb->s_fs_info is cleaned up if a ->put_super() method has been defined.
> > Just fyi.
> 
> Ah, thanks, that wasn't obvious at all.
> 
> greg k-h

FWIW, I would rather provide a proper ->kill_sb() and gotten rid of
all that stuff.  The thing is, unlike ->put_super(), ->kill_sb() is
called for *anything* that has gotten to foo_fill_super().  Usually
allows to get rid of those "call all of or parts of foo_put_super()
on failure exits" and associated bitrot...

Like this (completely untested):

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 588d753a7a19..c760f3129768 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -340,22 +340,21 @@ static int binderfs_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
-static void binderfs_put_super(struct super_block *sb)
+static void binderfs_kill_super(struct super_block *sb)
 {
 	struct binderfs_info *info = sb->s_fs_info;
 
+	kill_litter_super(sb);
 	if (info && info->ipc_ns)
 		put_ipc_ns(info->ipc_ns);
 
 	kfree(info);
-	sb->s_fs_info = NULL;
 }
 
 static const struct super_operations binderfs_super_ops = {
 	.evict_inode    = binderfs_evict_inode,
 	.show_options	= binderfs_show_options,
 	.statfs         = simple_statfs,
-	.put_super	= binderfs_put_super,
 };
 
 static inline bool is_binderfs_control_device(const struct dentry *dentry)
@@ -789,7 +788,7 @@ static struct file_system_type binder_fs_type = {
 	.name			= "binder",
 	.init_fs_context	= binderfs_init_fs_context,
 	.parameters		= binderfs_fs_parameters,
-	.kill_sb		= kill_litter_super,
+	.kill_sb		= binderfs_kill_super,
 	.fs_flags		= FS_USERNS_MOUNT,
 };
 
