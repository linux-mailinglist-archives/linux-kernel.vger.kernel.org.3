Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAB752ADA1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiEQVoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiEQVnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:43:50 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF1F50441;
        Tue, 17 May 2022 14:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3MN9R0ncE8uUAxzrbD9D9kHBacmiEBQxp8Szamm8Dr4=; b=pWFJRn3NyAvA7NK+RkLv0kJiJs
        VBDQ6yEpt4u26gcaTk1U+5+K+FS8UZ8Voegl441DMsSZd1IY56qTPhXIaXeZ6I71rJH4jaKD93DiZ
        9Nx1X9TxTEwJ7ZAZQsD+l8bA2AZeTjy5ywW811CBhaiTqo/9rjnlGr8aoR86lAeBKYOC8te19VqNO
        zMtRn1TL8STcuT/cym0BXOz//P3q0x4JRwpuzhuGn/veX7GUSCr+wD3ajPINs9BcYQgWHr+wXZ8fu
        jiCNIyE+PYhgokvcfbFabgyXuX3ws3CCMtR9PTDJP16HSHBWJVVXPGzWBkPFi/ssLdOYET7Rvz+9l
        Zihc79yw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nr4yg-00FqGx-3D; Tue, 17 May 2022 21:43:38 +0000
Date:   Tue, 17 May 2022 21:43:38 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc:     serge@hallyn.com, jmorris@namei.org, dhowells@redhat.com,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] commoncap: check return value to avoid null pointer
 dereference
Message-ID: <YoQXClv8jlNcOg1p@zeniv-ca.linux.org.uk>
References: <1652722802-66170-1-git-send-email-lyz_cs@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652722802-66170-1-git-send-email-lyz_cs@pku.edu.cn>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 10:40:02AM -0700, Yongzhi Liu wrote:
> The pointer inode is dereferenced before a null pointer
> check on inode, hence if inode is actually null we will
> get a null pointer dereference. Fix this by only dereferencing
> inode after the null pointer check on inode.
> 
> Fixes: c6f493d631c ("VFS: security/: d_backing_inode() annotations")
> Fixes: 8db6c34 ("Introduce v3 namespaced file capabilities")
> 
> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
> ---
>  security/commoncap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 5fc8986..978f011 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -298,6 +298,8 @@ int cap_inode_need_killpriv(struct dentry *dentry)
>  	struct inode *inode = d_backing_inode(dentry);
>  	int error;
>  
> +	if (!inode)
> +		return 0;
>  	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
>  	return error > 0;
>  }


	Huh?  AFAICS, that has all of two callers - notify_change() and
dentry_needs_remove_privs().  Both of them should never be called on
negative dentries and both would have blown up well before the call of
security_inode_need_killpriv().

> @@ -545,11 +547,13 @@ int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
>  	const struct vfs_cap_data *cap = *ivalue;
>  	__u32 magic, nsmagic;
>  	struct inode *inode = d_backing_inode(dentry);
> -	struct user_namespace *task_ns = current_user_ns(),
> -		*fs_ns = inode->i_sb->s_user_ns;
> +	struct user_namespace *task_ns = current_user_ns(), *fs_ns;
>  	kuid_t rootid;
>  	size_t newsize;
>  
> +	if (!inode)
> +		return -EINVAL;
> +	fs_ns = inode->i_sb->s_user_ns;
>  	if (!*ivalue)
>  		return -EINVAL;
>  	if (!validheader(size, cap))

... and that one come from vfs_setxattr().  Again, calling that on a negative
dentry is an oopsable bug.  If you have any reproducers, please post the stack
traces so it would be possible to deal with the underlying problem.
