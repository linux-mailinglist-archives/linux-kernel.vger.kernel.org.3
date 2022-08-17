Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F0A5972D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbiHQPVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbiHQPV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:21:28 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5476E78207
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WtsfTpO10I2ZK8vFQPpo9DxkDvYTT/yJN+heAiZTZXI=; b=GO2vADmBKsECuNthUvzfdCzAhr
        pAdeA388YWxFtJIy1WCpDbzxBybj+clguL/G0s9eZT6mkp8eTOqsRb96RNuaZ6/g/G91aJBUbJU8f
        7eyom1H6Lv4XYyNSW5Ya3ihwVcHGYqGdM+m4zgoPeFsUgq0W9gXmaa6pnMaH2N5CnE7ZNiHMcgN2L
        ztFMMSLRHNuP+GiPzwZuNeTth6LBt64q7QYHxYnorJDxW/iHxf14A+Bt+3hmOLvF9GESwrQjHjCCc
        U8267o8/jI4HFcuKah5yf3XLTJ0qonNgD0kj54VLGTtkZFym7jeg7NtX7BJbK4ssgXd5CRy8NS3Xp
        0noLZMsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oOKr1-005PIZ-M6;
        Wed, 17 Aug 2022 15:21:11 +0000
Date:   Wed, 17 Aug 2022 16:21:11 +0100
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
Message-ID: <Yv0HZ8lxn2m6sUut@ZenIV>
References: <YvzUS/7bd1mm6c/V@kroah.com>
 <20220817130306.96978-1-brauner@kernel.org>
 <Yvz0JkdxXwY8uDyT@ZenIV>
 <20220817140149.pfakskeyxkqcot54@wittgenstein>
 <Yvz44WHBh94IvJt/@ZenIV>
 <20220817145144.mbcbvpepusdvrds4@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817145144.mbcbvpepusdvrds4@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 04:51:44PM +0200, Christian Brauner wrote:

> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> index 5c97f48cea91..d7d275ef132f 100644
> --- a/arch/s390/hypfs/inode.c
> +++ b/arch/s390/hypfs/inode.c
> @@ -329,9 +329,8 @@ static void hypfs_kill_super(struct super_block *sb)
>  		hypfs_delete_tree(sb->s_root);
>  	if (sb_info && sb_info->update_file)
>  		hypfs_remove(sb_info->update_file);
> -	kfree(sb->s_fs_info);
> -	sb->s_fs_info = NULL;
>  	kill_litter_super(sb);
> +	kfree(sb->s_fs_info);

UAF, that - *sb gets freed by the time you try to fetch sb->s_fs_info...
Fetch the pointer first, then destroy the object you've fetched it
from, then free what it points to...

> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index 4f25015aa534..78a9095e1748 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -509,10 +509,10 @@ static void devpts_kill_sb(struct super_block *sb)
>  {
>  	struct pts_fs_info *fsi = DEVPTS_SB(sb);
>  
> +	kill_litter_super(sb);
>  	if (fsi)
>  		ida_destroy(&fsi->allocated_ptys);
>  	kfree(fsi);
> -	kill_litter_super(sb);
>  }
>  

That one's fine.

>  static struct file_system_type devpts_fs_type = {
> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index bc66d0173e33..bff49294e037 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -280,8 +280,10 @@ int ramfs_init_fs_context(struct fs_context *fc)
>  
>  static void ramfs_kill_sb(struct super_block *sb)
>  {
> -	kfree(sb->s_fs_info);
> +	struct ramfs_fs_info *fsi = sb->s_fs_info;
> +
>  	kill_litter_super(sb);
> +	kfree(fsi);
>  }

Cosmetical, really - see another posting in the same thread.

>  static struct file_system_type ramfs_fs_type = 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 8fcdd494af27..fb1dae422d93 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -96,9 +96,8 @@ static int selinux_fs_info_create(struct super_block *sb)
>  	return 0;
>  }
>  
> -static void selinux_fs_info_free(struct super_block *sb)
> +static void selinux_fs_info_free(struct selinux_fs_info *fsi)
>  {
> -	struct selinux_fs_info *fsi = sb->s_fs_info;
>  	int i;
>  
>  	if (fsi) {
> @@ -107,8 +106,7 @@ static void selinux_fs_info_free(struct super_block *sb)
>  		kfree(fsi->bool_pending_names);
>  		kfree(fsi->bool_pending_values);
>  	}
> -	kfree(sb->s_fs_info);
> -	sb->s_fs_info = NULL;
> +	kfree(fsi);
>  }
>  
>  #define SEL_INITCON_INO_OFFSET		0x01000000
> @@ -2180,7 +2178,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
>  	pr_err("SELinux: %s:  failed while creating inodes\n",
>  		__func__);
>  
> -	selinux_fs_info_free(sb);
> +	selinux_fs_info_free(fsi);
>  
>  	return ret;
>  }
> @@ -2202,8 +2200,10 @@ static int sel_init_fs_context(struct fs_context *fc)
>  
>  static void sel_kill_sb(struct super_block *sb)
>  {
> -	selinux_fs_info_free(sb);
> +	struct selinux_fs_info *fsi = sb->s_fs_info;
> +
>  	kill_litter_super(sb);
> +	selinux_fs_info_free(fsi);
>  }

A real bug, but an incomplete fix - you've just gotten yourself a double-free;
failure in sel_fill_super() has no need to do selinux_fs_info_free() now.
