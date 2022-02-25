Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2387E4C503D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbiBYU6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiBYU6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:58:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A949AE62;
        Fri, 25 Feb 2022 12:57:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD25A61AC1;
        Fri, 25 Feb 2022 20:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1B6C340E7;
        Fri, 25 Feb 2022 20:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645822656;
        bh=pTLVN6Q36v9FGaQsclC6B9u/5ZBd4A+IfXNUIDYGclo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=a0/b6yQNvdXyuNjn4EY+Am5w60ieOzKMcnS1N5zJASF4Z+YmBPBB22e8WBj6dLrV7
         Hu0Oz04GVrG8Sd/etCpEqvIPoMyzXlgPUD2RGB1IHuDXnAyrfClyyWm4eX06xCe4/f
         gPye/E/pEHCY3Ys9czH7eYGFyKaPcQJEQ7P3BmQ+EG4JhwIKsGo/rtkJsVDcCs8/uU
         QzmVWj5p1JM2Cktt0eFzvd7Bv1EewtdOtDUFH0owWT53BTJS1WjnywZL8bElEod3Qy
         F+YTsbHlj4CTXTrAlM7PlIHfJ2mnaoecrlXOHeMVLriRr4FfUzThR0iqvff693lo1i
         NmolK5e4C8EAg==
Message-ID: <57461c8994f5eb15409ae1cfe452b3d6b2263645.camel@kernel.org>
Subject: Re: [RFC PATCH] ceph: add support for encrypted snapshot names
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Feb 2022 15:57:34 -0500
In-Reply-To: <20220224112142.18052-1-lhenriques@suse.de>
References: <20220224112142.18052-1-lhenriques@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-24 at 11:21 +0000, Luís Henriques wrote:
> Since filenames in encrypted directories are already encrypted and shown
> as a base64-encoded string when the directory is locked, snapshot names
> should show a similar behaviour.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  fs/ceph/dir.c   | 15 +++++++++++++++
>  fs/ceph/inode.c | 10 +++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> Support on the MDS for names that'll be > MAX_NAME when base64 encoded is
> still TBD.  I thought it would be something easy to do, but snapshots
> don't seem to make use of the CDir/CDentry (which is where alternate_name
> is stored on the MDS).  I'm still looking into this, but I may need some
> help there :-(
> 
> Cheers,
> --
> Luís
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index a449f4a07c07..20ae600ee7cd 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1065,6 +1065,13 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>  		op = CEPH_MDS_OP_MKSNAP;
>  		dout("mksnap dir %p snap '%pd' dn %p\n", dir,
>  		     dentry, dentry);
> +		/* XXX missing support for alternate_name in snapshots */
> +		if (IS_ENCRYPTED(dir) && (dentry->d_name.len >= 189)) {
> +			dout("encrypted snapshot name too long: %pd len: %d\n",
> +			     dentry, dentry->d_name.len);
> +			err = -ENAMETOOLONG;
> +			goto out;
> +		}

Where does 189 come from? You probably want to use CEPH_NOHASH_NAME_MAX.

>  	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
>  		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
>  		op = CEPH_MDS_OP_MKDIR;
> @@ -1109,6 +1116,14 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>  	    !req->r_reply_info.head->is_target &&
>  	    !req->r_reply_info.head->is_dentry)
>  		err = ceph_handle_notrace_create(dir, dentry);
> +
> +	/*
> +	 * If we have created a snapshot we need to clear the cache, otherwise
> +	 * snapshot will show encrypted filenames in readdir.
> +	 */
> +	if (ceph_snap(dir) == CEPH_SNAPDIR)
> +		d_drop(dentry);
> +

This looks hacky, but I just caught up on the discussion between you and
Xiubo, so I assume you're addressing that.

>  out_req:
>  	ceph_mdsc_put_request(req);
>  out:
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 8b0832271fdf..080824610b73 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -182,6 +182,13 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>  	ci->i_rbytes = 0;
>  	ci->i_btime = ceph_inode(parent)->i_btime;
>  
> +	/* if encrypted, just borough fscrypt_auth from parent */
> +	if (IS_ENCRYPTED(parent)) {
> +		struct ceph_inode_info *pci = ceph_inode(parent);
> +		inode->i_flags |= S_ENCRYPTED;
> +		ci->fscrypt_auth_len = pci->fscrypt_auth_len;
> +		ci->fscrypt_auth = pci->fscrypt_auth;
> +	}
>  	if (inode->i_state & I_NEW) {
>  		inode->i_op = &ceph_snapdir_iops;
>  		inode->i_fop = &ceph_snapdir_fops;
> @@ -632,7 +639,8 @@ void ceph_free_inode(struct inode *inode)
>  
>  	kfree(ci->i_symlink);
>  #ifdef CONFIG_FS_ENCRYPTION
> -	kfree(ci->fscrypt_auth);
> +	if (ceph_snap(inode) != CEPH_SNAPDIR)
> +		kfree(ci->fscrypt_auth);

Can a snapdir inode outlive its parent?

>  #endif
>  	fscrypt_free_inode(inode);
>  	kmem_cache_free(ceph_inode_cachep, ci);

-- 
Jeff Layton <jlayton@kernel.org>
