Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95AB5A1202
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbiHYN0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbiHYN0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:26:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C59A74CF;
        Thu, 25 Aug 2022 06:26:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 00745CE27FC;
        Thu, 25 Aug 2022 13:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A882C433C1;
        Thu, 25 Aug 2022 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661433958;
        bh=WV3SV5ZUCQ9b1KzcN/O97b6ginjUgIQSvd4hmW+3Bh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=leg+fjL1f1GGpC6l6DyGRi6igPNFf9HkkQYpuvFvbarrZS9QIumWZL97TjlZIZwjS
         dG/UZbKAGzXfAuGPD8+8MiOy2dzbH8sHLEhK4AO9Z96noCmnodb+nLyQaT2r0InsDi
         gViTuZLCv7DRa3bgI7RdfE/rzNfvsYDLPuzP+TQI3UIpN40ThRyJve+xk0Tu1GkQ6F
         /e8oNd1mrA0YSY7WJisWLz0UiY8IXznjJwE4JpxTXKMhs8zPnkEqNZSnlANjnU7OcY
         xGhPI2et8/KG1NKsZV9Y3ulFGvL8dWDrCsudnxaUJPIMayDRdpK3NHq/W1KGN3wfq9
         4ZE33AjXtib9Q==
Date:   Thu, 25 Aug 2022 15:25:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, amir73il@gmail.com,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: Re: [PATCH v2] ovl: Use current fsuid and fsgid in ovl_link()
Message-ID: <20220825132552.loybzprnkwdkmu3k@wittgenstein>
References: <20220825130552.29587-1-zhangtianci.1997@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220825130552.29587-1-zhangtianci.1997@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:05:52PM +0800, Zhang Tianci wrote:
> There is a wrong case of link() on overlay:
>   $ mkdir /lower /fuse /merge
>   $ mount -t fuse /fuse
>   $ mkdir /fuse/upper /fuse/work
>   $ mount -t overlay /merge -o lowerdir=/lower,upperdir=/fuse/upper,\
>     workdir=work
>   $ touch /merge/file
>   $ chown bin.bin /merge/file // the file's caller becomes "bin"
>   $ ln /merge/file /merge/lnkfile
> 
> Then we will get an error(EACCES) because fuse daemon checks the link()'s
> caller is "bin", it denied this request.
> 
> In the changing history of ovl_link(), there are two key commits:
> 
> The first is commit bb0d2b8ad296 ("ovl: fix sgid on directory") which
> overrides the cred's fsuid/fsgid using the new inode. The new inode's
> owner is initialized by inode_init_owner(), and inode->fsuid is
> assigned to the current user. So the override fsuid becomes the
> current user. We know link() is actually modifying the directory, so
> the caller must have the MAY_WRITE permission on the directory. The
> current caller may should have this permission. This is acceptable
> to use the caller's fsuid.
> 
> The second is commit 51f7e52dc943 ("ovl: share inode for hard link")
> which removed the inode creation in ovl_link(). This commit move
> inode_init_owner() into ovl_create_object(), so the ovl_link() just
> give the old inode to ovl_create_or_link(). Then the override fsuid
> becomes the old inode's fsuid, neither the caller nor the overlay's
> creator! So this is incorrect.
> 
> Fix this bug by using current fsuid/fsgid to do underlying fs's link().
> 
> Link: https://lore.kernel.org/all/20220817102951.xnvesg3a7rbv576x@wittgenstein/T
> 
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---

(Should probably also use a 
Suggested-by: Christian Brauner (Microsoft) <brauner@kernel.org>, I
think. But not that important.)

Looks good to me but this really should be tested to survive xfstests,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

>  fs/overlayfs/dir.c       | 16 +++++++++++-----
>  fs/overlayfs/overlayfs.h |  2 ++
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 6b03457f72bb..dd84e6fc5f6e 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -595,8 +595,8 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
>  	err = -ENOMEM;
>  	override_cred = prepare_creds();
>  	if (override_cred) {
> -		override_cred->fsuid = inode->i_uid;
> -		override_cred->fsgid = inode->i_gid;
> +		override_cred->fsuid = attr->fsuid;
> +		override_cred->fsgid = attr->fsgid;
>  		if (!attr->hardlink) {
>  			err = security_dentry_create_files_as(dentry,
>  					attr->mode, &dentry->d_name, old_cred,
> @@ -646,6 +646,8 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
>  	inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
>  	attr.mode = inode->i_mode;
>  
> +	attr.fsuid = inode->i_uid;
> +	attr.fsgid = inode->i_gid;
>  	err = ovl_create_or_link(dentry, inode, &attr, false);
>  	/* Did we end up using the preallocated inode? */
>  	if (inode != d_inode(dentry))
> @@ -702,6 +704,7 @@ static int ovl_link(struct dentry *old, struct inode *newdir,
>  {
>  	int err;
>  	struct inode *inode;
> +	struct ovl_cattr attr;
>  
>  	err = ovl_want_write(old);
>  	if (err)
> @@ -728,9 +731,12 @@ static int ovl_link(struct dentry *old, struct inode *newdir,
>  	inode = d_inode(old);
>  	ihold(inode);
>  
> -	err = ovl_create_or_link(new, inode,
> -			&(struct ovl_cattr) {.hardlink = ovl_dentry_upper(old)},
> -			ovl_type_origin(old));
> +	attr = (struct ovl_cattr) {
> +		.hardlink = ovl_dentry_upper(old),
> +		.fsuid = current_fsuid(),
> +		.fsgid = current_fsgid(),
> +	};
> +	err = ovl_create_or_link(new, inode, &attr, ovl_type_origin(old));
>  	if (err)
>  		iput(inode);
>  
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 87759165d32b..85043123a103 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -655,6 +655,8 @@ struct ovl_cattr {
>  	umode_t mode;
>  	const char *link;
>  	struct dentry *hardlink;
> +	kuid_t fsuid;
> +	kgid_t fsgid;
>  };
>  
>  #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode = (m) })
> -- 
> 2.32.1 (Apple Git-133)
> 
