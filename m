Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F93549DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350545AbiFMTbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349981AbiFMTaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:30:30 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CF6B5E743
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:55:13 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4AF5620C154C;
        Mon, 13 Jun 2022 10:55:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4AF5620C154C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1655142912;
        bh=Lp4H9Ky+giu6nloH3mnnTx2vGUxThQju2/nrU7FOEAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBx26soRq6ImeRjp8HyLTVpuyL/+9CkcCPzI7NQxRsDaNQaHc+pXbp9EJU+Keijym
         DtMW+CiCZkdpDmXBfRw3zcLZkEVXACK9TAftts4Ijxm1SVy/+Va3bW7nRtbO6wnS//
         SkmDg4pHTINLBfoY7aRO1VhSpf5PqsK6Xqb+vHh8=
Date:   Mon, 13 Jun 2022 12:55:09 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/06] 9p fid refcount: cleanup p9_fid_put calls
Message-ID: <20220613175509.GE7401@sequoia>
References: <20220612085330.1451496-1-asmadeus@codewreck.org>
 <20220612085330.1451496-7-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612085330.1451496-7-asmadeus@codewreck.org>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-12 17:53:29, Dominique Martinet wrote:
> Simplify p9_fid_put cleanup path in many 9p functions since the function
> is noop on null or error fids.
> 
> Also make the *_add_fid() helpers "steal" the fid by nulling its
> pointer, so put after them will be noop.
> 
> This should lead to no change of behaviour

Another really nice cleanup. Only one small comment below.

> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
>  fs/9p/fid.c            | 24 +++++++++++------
>  fs/9p/fid.h            |  4 +--
>  fs/9p/vfs_file.c       |  5 ++--
>  fs/9p/vfs_inode.c      | 61 +++++++++++++++++-------------------------
>  fs/9p/vfs_inode_dotl.c | 58 +++++++++++++--------------------------
>  fs/9p/vfs_super.c      |  2 +-
>  6 files changed, 64 insertions(+), 90 deletions(-)
> 
> diff --git a/fs/9p/fid.c b/fs/9p/fid.c
> index d792499349c4..289a85eae2ae 100644
> --- a/fs/9p/fid.c
> +++ b/fs/9p/fid.c
> @@ -31,11 +31,15 @@ static inline void __add_fid(struct dentry *dentry, struct p9_fid *fid)
>   * @fid: fid to add
>   *
>   */
> -void v9fs_fid_add(struct dentry *dentry, struct p9_fid *fid)
> +void v9fs_fid_add(struct dentry *dentry, struct p9_fid **pfid)
>  {
> +	struct p9_fid *fid = *pfid;
> +
>  	spin_lock(&dentry->d_lock);
>  	__add_fid(dentry, fid);
>  	spin_unlock(&dentry->d_lock);
> +
> +	*pfid = NULL;
>  }
>  
>  /**
> @@ -72,11 +76,15 @@ static struct p9_fid *v9fs_fid_find_inode(struct inode *inode, kuid_t uid)
>   *
>   */
>  
> -void v9fs_open_fid_add(struct inode *inode, struct p9_fid *fid)
> +void v9fs_open_fid_add(struct inode *inode, struct p9_fid **pfid)
>  {
> +	struct p9_fid *fid = *pfid;
> +
>  	spin_lock(&inode->i_lock);
>  	hlist_add_head(&fid->ilist, (struct hlist_head *)&inode->i_private);
>  	spin_unlock(&inode->i_lock);
> +
> +	*pfid = NULL;
>  }
>  
>  
> @@ -189,13 +197,13 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
>  		else
>  			uname = v9ses->uname;
>  
> -		root_fid = p9_client_attach(v9ses->clnt, NULL, uname, uid,
> -					    v9ses->aname);
> -		if (IS_ERR(root_fid))
> -			return root_fid;
> +		fid = p9_client_attach(v9ses->clnt, NULL, uname, uid,

To keep the readability benefits in my "9p: Track the root fid with its
own variable during lookups" patch, I think root_fid should be assigned
here and then used in the error check and return statement.

> +				       v9ses->aname);
> +		if (IS_ERR(fid))
> +			return fid;
>  
> -		p9_fid_get(root_fid);
> -		v9fs_fid_add(dentry->d_sb->s_root, root_fid);
> +		root_fid = p9_fid_get(fid);
> +		v9fs_fid_add(dentry->d_sb->s_root, &fid);

root_fid should be used in the two lines above, too.

With these changes, 

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

>  	}
>  	/* If we are root ourself just return that */
>  	if (dentry->d_sb->s_root == dentry)
> diff --git a/fs/9p/fid.h b/fs/9p/fid.h
> index 3168dfad510e..8a4e8cd12ca2 100644
> --- a/fs/9p/fid.h
> +++ b/fs/9p/fid.h
> @@ -13,9 +13,9 @@ static inline struct p9_fid *v9fs_parent_fid(struct dentry *dentry)
>  {
>  	return v9fs_fid_lookup(dentry->d_parent);
>  }
> -void v9fs_fid_add(struct dentry *dentry, struct p9_fid *fid);
> +void v9fs_fid_add(struct dentry *dentry, struct p9_fid **fid);
>  struct p9_fid *v9fs_writeback_fid(struct dentry *dentry);
> -void v9fs_open_fid_add(struct inode *inode, struct p9_fid *fid);
> +void v9fs_open_fid_add(struct inode *inode, struct p9_fid **fid);
>  static inline struct p9_fid *clone_fid(struct p9_fid *fid)
>  {
>  	return IS_ERR(fid) ? fid :  p9_client_walk(fid, 0, NULL, 1);
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 8276f3af35d7..aec43ba83799 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -69,9 +69,10 @@ int v9fs_file_open(struct inode *inode, struct file *file)
>  		if ((file->f_flags & O_APPEND) &&
>  			(!v9fs_proto_dotu(v9ses) && !v9fs_proto_dotl(v9ses)))
>  			generic_file_llseek(file, 0, SEEK_END);
> +
> +		file->private_data = fid;
>  	}
>  
> -	file->private_data = fid;
>  	mutex_lock(&v9inode->v_mutex);
>  	if ((v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) &&
>  	    !v9inode->writeback_fid &&
> @@ -95,7 +96,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
>  	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
>  		fscache_use_cookie(v9fs_inode_cookie(v9inode),
>  				   file->f_mode & FMODE_WRITE);
> -	v9fs_open_fid_add(inode, fid);
> +	v9fs_open_fid_add(inode, &fid);
>  	return 0;
>  out_error:
>  	p9_fid_put(file->private_data);
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 38186d1a1440..1b11a92208fd 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -398,10 +398,8 @@ void v9fs_evict_inode(struct inode *inode)
>  
>  	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
>  	/* clunk the fid stashed in writeback_fid */
> -	if (v9inode->writeback_fid) {
> -		p9_fid_put(v9inode->writeback_fid);
> -		v9inode->writeback_fid = NULL;
> -	}
> +	p9_fid_put(v9inode->writeback_fid);
> +	v9inode->writeback_fid = NULL;
>  }
>  
>  static int v9fs_test_inode(struct inode *inode, void *data)
> @@ -632,14 +630,12 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
>  	if (IS_ERR(ofid)) {
>  		err = PTR_ERR(ofid);
>  		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n", err);
> -		p9_fid_put(dfid);
> -		return ERR_PTR(err);
> +		goto error;
>  	}
>  
>  	err = p9_client_fcreate(ofid, name, perm, mode, extension);
>  	if (err < 0) {
>  		p9_debug(P9_DEBUG_VFS, "p9_client_fcreate failed %d\n", err);
> -		p9_fid_put(dfid);
>  		goto error;
>  	}
>  
> @@ -650,8 +646,6 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
>  			err = PTR_ERR(fid);
>  			p9_debug(P9_DEBUG_VFS,
>  				   "p9_client_walk failed %d\n", err);
> -			fid = NULL;
> -			p9_fid_put(dfid);
>  			goto error;
>  		}
>  		/*
> @@ -662,21 +656,17 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
>  			err = PTR_ERR(inode);
>  			p9_debug(P9_DEBUG_VFS,
>  				   "inode creation failed %d\n", err);
> -			p9_fid_put(dfid);
>  			goto error;
>  		}
> -		v9fs_fid_add(dentry, fid);
> +		v9fs_fid_add(dentry, &fid);
>  		d_instantiate(dentry, inode);
>  	}
>  	p9_fid_put(dfid);
>  	return ofid;
>  error:
> -	if (ofid)
> -		p9_fid_put(ofid);
> -
> -	if (fid)
> -		p9_fid_put(fid);
> -
> +	p9_fid_put(dfid);
> +	p9_fid_put(ofid);
> +	p9_fid_put(fid);
>  	return ERR_PTR(err);
>  }
>  
> @@ -803,9 +793,9 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
>  	res = d_splice_alias(inode, dentry);
>  	if (!IS_ERR(fid)) {
>  		if (!res)
> -			v9fs_fid_add(dentry, fid);
> +			v9fs_fid_add(dentry, &fid);
>  		else if (!IS_ERR(res))
> -			v9fs_fid_add(res, fid);
> +			v9fs_fid_add(res, &fid);
>  		else
>  			p9_fid_put(fid);
>  	}
> @@ -846,7 +836,6 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
>  						v9fs_proto_dotu(v9ses)));
>  	if (IS_ERR(fid)) {
>  		err = PTR_ERR(fid);
> -		fid = NULL;
>  		goto error;
>  	}
>  
> @@ -881,7 +870,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
>  	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
>  		fscache_use_cookie(v9fs_inode_cookie(v9inode),
>  				   file->f_mode & FMODE_WRITE);
> -	v9fs_open_fid_add(inode, fid);
> +	v9fs_open_fid_add(inode, &fid);
>  
>  	file->f_mode |= FMODE_CREATED;
>  out:
> @@ -889,8 +878,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
>  	return err;
>  
>  error:
> -	if (fid)
> -		p9_fid_put(fid);
> +	p9_fid_put(fid);
>  	goto out;
>  }
>  
> @@ -938,9 +926,9 @@ v9fs_vfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  	struct inode *old_inode;
>  	struct inode *new_inode;
>  	struct v9fs_session_info *v9ses;
> -	struct p9_fid *oldfid, *dfid;
> -	struct p9_fid *olddirfid;
> -	struct p9_fid *newdirfid;
> +	struct p9_fid *oldfid = NULL, *dfid = NULL;
> +	struct p9_fid *olddirfid = NULL;
> +	struct p9_fid *newdirfid = NULL;
>  	struct p9_wstat wstat;
>  
>  	if (flags)
> @@ -957,21 +945,22 @@ v9fs_vfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  
>  	dfid = v9fs_parent_fid(old_dentry);
>  	olddirfid = clone_fid(dfid);
> -	if (dfid && !IS_ERR(dfid))
> -		p9_fid_put(dfid);
> +	p9_fid_put(dfid);
> +	dfid = NULL;
>  
>  	if (IS_ERR(olddirfid)) {
>  		retval = PTR_ERR(olddirfid);
> -		goto done;
> +		goto error;
>  	}
>  
>  	dfid = v9fs_parent_fid(new_dentry);
>  	newdirfid = clone_fid(dfid);
>  	p9_fid_put(dfid);
> +	dfid = NULL;
>  
>  	if (IS_ERR(newdirfid)) {
>  		retval = PTR_ERR(newdirfid);
> -		goto clunk_olddir;
> +		goto error;
>  	}
>  
>  	down_write(&v9ses->rename_sem);
> @@ -982,7 +971,7 @@ v9fs_vfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  			retval = p9_client_rename(oldfid, newdirfid,
>  						  new_dentry->d_name.name);
>  		if (retval != -EOPNOTSUPP)
> -			goto clunk_newdir;
> +			goto error_locked;
>  	}
>  	if (old_dentry->d_parent != new_dentry->d_parent) {
>  		/*
> @@ -991,14 +980,14 @@ v9fs_vfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  
>  		p9_debug(P9_DEBUG_ERROR, "old dir and new dir are different\n");
>  		retval = -EXDEV;
> -		goto clunk_newdir;
> +		goto error_locked;
>  	}
>  	v9fs_blank_wstat(&wstat);
>  	wstat.muid = v9ses->uname;
>  	wstat.name = new_dentry->d_name.name;
>  	retval = p9_client_wstat(oldfid, &wstat);
>  
> -clunk_newdir:
> +error_locked:
>  	if (!retval) {
>  		if (new_inode) {
>  			if (S_ISDIR(new_inode->i_mode))
> @@ -1019,12 +1008,10 @@ v9fs_vfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  		d_move(old_dentry, new_dentry);
>  	}
>  	up_write(&v9ses->rename_sem);
> +
> +error:
>  	p9_fid_put(newdirfid);
> -
> -clunk_olddir:
>  	p9_fid_put(olddirfid);
> -
> -done:
>  	p9_fid_put(oldfid);
>  	return retval;
>  }
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 09b124fe349c..5cfa4b4f070f 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -238,7 +238,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
>  	struct inode *inode;
>  	struct p9_fid *fid = NULL;
>  	struct v9fs_inode *v9inode;
> -	struct p9_fid *dfid, *ofid, *inode_fid;
> +	struct p9_fid *dfid = NULL, *ofid = NULL, *inode_fid = NULL;
>  	struct v9fs_session_info *v9ses;
>  	struct posix_acl *pacl = NULL, *dacl = NULL;
>  	struct dentry *res = NULL;
> @@ -274,7 +274,6 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
>  	if (IS_ERR(ofid)) {
>  		err = PTR_ERR(ofid);
>  		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n", err);
> -		p9_fid_put(dfid);
>  		goto out;
>  	}
>  
> @@ -286,38 +285,34 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
>  	if (err) {
>  		p9_debug(P9_DEBUG_VFS, "Failed to get acl values in creat %d\n",
>  			 err);
> -		p9_fid_put(dfid);
> -		goto error;
> +		goto out;
>  	}
>  	err = p9_client_create_dotl(ofid, name, v9fs_open_to_dotl_flags(flags),
>  				    mode, gid, &qid);
>  	if (err < 0) {
>  		p9_debug(P9_DEBUG_VFS, "p9_client_open_dotl failed in creat %d\n",
>  			 err);
> -		p9_fid_put(dfid);
> -		goto error;
> +		goto out;
>  	}
>  	v9fs_invalidate_inode_attr(dir);
>  
>  	/* instantiate inode and assign the unopened fid to the dentry */
>  	fid = p9_client_walk(dfid, 1, &name, 1);
> -	p9_fid_put(dfid);
>  	if (IS_ERR(fid)) {
>  		err = PTR_ERR(fid);
>  		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n", err);
> -		fid = NULL;
> -		goto error;
> +		goto out;
>  	}
>  	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
>  	if (IS_ERR(inode)) {
>  		err = PTR_ERR(inode);
>  		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n", err);
> -		goto error;
> +		goto out;
>  	}
>  	/* Now set the ACL based on the default value */
>  	v9fs_set_create_acl(inode, fid, dacl, pacl);
>  
> -	v9fs_fid_add(dentry, fid);
> +	v9fs_fid_add(dentry, &fid);
>  	d_instantiate(dentry, inode);
>  
>  	v9inode = V9FS_I(inode);
> @@ -336,7 +331,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
>  		if (IS_ERR(inode_fid)) {
>  			err = PTR_ERR(inode_fid);
>  			mutex_unlock(&v9inode->v_mutex);
> -			goto err_clunk_old_fid;
> +			goto out;
>  		}
>  		v9inode->writeback_fid = (void *) inode_fid;
>  	}
> @@ -344,25 +339,20 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
>  	/* Since we are opening a file, assign the open fid to the file */
>  	err = finish_open(file, dentry, generic_file_open);
>  	if (err)
> -		goto err_clunk_old_fid;
> +		goto out;
>  	file->private_data = ofid;
>  	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
>  		fscache_use_cookie(v9fs_inode_cookie(v9inode),
>  				   file->f_mode & FMODE_WRITE);
> -	v9fs_open_fid_add(inode, ofid);
> +	v9fs_open_fid_add(inode, &ofid);
>  	file->f_mode |= FMODE_CREATED;
>  out:
> +	p9_fid_put(dfid);
> +	p9_fid_put(ofid);
> +	p9_fid_put(fid);
>  	v9fs_put_acl(dacl, pacl);
>  	dput(res);
>  	return err;
> -
> -error:
> -	if (fid)
> -		p9_fid_put(fid);
> -err_clunk_old_fid:
> -	if (ofid)
> -		p9_fid_put(ofid);
> -	goto out;
>  }
>  
>  /**
> @@ -400,7 +390,6 @@ static int v9fs_vfs_mkdir_dotl(struct user_namespace *mnt_userns,
>  	if (IS_ERR(dfid)) {
>  		err = PTR_ERR(dfid);
>  		p9_debug(P9_DEBUG_VFS, "fid lookup failed %d\n", err);
> -		dfid = NULL;
>  		goto error;
>  	}
>  
> @@ -422,7 +411,6 @@ static int v9fs_vfs_mkdir_dotl(struct user_namespace *mnt_userns,
>  		err = PTR_ERR(fid);
>  		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n",
>  			 err);
> -		fid = NULL;
>  		goto error;
>  	}
>  
> @@ -435,10 +423,9 @@ static int v9fs_vfs_mkdir_dotl(struct user_namespace *mnt_userns,
>  				 err);
>  			goto error;
>  		}
> -		v9fs_fid_add(dentry, fid);
> +		v9fs_fid_add(dentry, &fid);
>  		v9fs_set_create_acl(inode, fid, dacl, pacl);
>  		d_instantiate(dentry, inode);
> -		fid = NULL;
>  		err = 0;
>  	} else {
>  		/*
> @@ -457,8 +444,7 @@ static int v9fs_vfs_mkdir_dotl(struct user_namespace *mnt_userns,
>  	inc_nlink(dir);
>  	v9fs_invalidate_inode_attr(dir);
>  error:
> -	if (fid)
> -		p9_fid_put(fid);
> +	p9_fid_put(fid);
>  	v9fs_put_acl(dacl, pacl);
>  	p9_fid_put(dfid);
>  	return err;
> @@ -743,7 +729,6 @@ v9fs_vfs_symlink_dotl(struct user_namespace *mnt_userns, struct inode *dir,
>  			err = PTR_ERR(fid);
>  			p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n",
>  				 err);
> -			fid = NULL;
>  			goto error;
>  		}
>  
> @@ -755,9 +740,8 @@ v9fs_vfs_symlink_dotl(struct user_namespace *mnt_userns, struct inode *dir,
>  				 err);
>  			goto error;
>  		}
> -		v9fs_fid_add(dentry, fid);
> +		v9fs_fid_add(dentry, &fid);
>  		d_instantiate(dentry, inode);
> -		fid = NULL;
>  		err = 0;
>  	} else {
>  		/* Not in cached mode. No need to populate inode with stat */
> @@ -770,9 +754,7 @@ v9fs_vfs_symlink_dotl(struct user_namespace *mnt_userns, struct inode *dir,
>  	}
>  
>  error:
> -	if (fid)
> -		p9_fid_put(fid);
> -
> +	p9_fid_put(fid);
>  	p9_fid_put(dfid);
>  	return err;
>  }
> @@ -866,7 +848,6 @@ v9fs_vfs_mknod_dotl(struct user_namespace *mnt_userns, struct inode *dir,
>  	if (IS_ERR(dfid)) {
>  		err = PTR_ERR(dfid);
>  		p9_debug(P9_DEBUG_VFS, "fid lookup failed %d\n", err);
> -		dfid = NULL;
>  		goto error;
>  	}
>  
> @@ -891,7 +872,6 @@ v9fs_vfs_mknod_dotl(struct user_namespace *mnt_userns, struct inode *dir,
>  		err = PTR_ERR(fid);
>  		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n",
>  			 err);
> -		fid = NULL;
>  		goto error;
>  	}
>  
> @@ -905,9 +885,8 @@ v9fs_vfs_mknod_dotl(struct user_namespace *mnt_userns, struct inode *dir,
>  			goto error;
>  		}
>  		v9fs_set_create_acl(inode, fid, dacl, pacl);
> -		v9fs_fid_add(dentry, fid);
> +		v9fs_fid_add(dentry, &fid);
>  		d_instantiate(dentry, inode);
> -		fid = NULL;
>  		err = 0;
>  	} else {
>  		/*
> @@ -923,8 +902,7 @@ v9fs_vfs_mknod_dotl(struct user_namespace *mnt_userns, struct inode *dir,
>  		d_instantiate(dentry, inode);
>  	}
>  error:
> -	if (fid)
> -		p9_fid_put(fid);
> +	p9_fid_put(fid);
>  	v9fs_put_acl(dacl, pacl);
>  	p9_fid_put(dfid);
>  
> diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
> index bf350fad9500..2d9ee073d12c 100644
> --- a/fs/9p/vfs_super.c
> +++ b/fs/9p/vfs_super.c
> @@ -184,7 +184,7 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
>  	retval = v9fs_get_acl(inode, fid);
>  	if (retval)
>  		goto release_sb;
> -	v9fs_fid_add(root, fid);
> +	v9fs_fid_add(root, &fid);
>  
>  	p9_debug(P9_DEBUG_VFS, " simple set mount, return 0\n");
>  	return dget(sb->s_root);
> -- 
> 2.35.1
> 
