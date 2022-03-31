Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D019F4ED0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiCaAkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiCaAkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:40:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820D11C109;
        Wed, 30 Mar 2022 17:38:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A647B81E6F;
        Thu, 31 Mar 2022 00:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C42C340EC;
        Thu, 31 Mar 2022 00:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648687106;
        bh=HS85Xe1VwoJm50SlxBhxv3D+e91TbEz0k8K8w27ElyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/WQXv1bnAhOrhjPkt3mfSAqzYckfM6VQrJnzWUrsFHAlwz/epztUgnB2Ur5+YAy/
         bf7bECMw/bDl8gZBjVoGl8L8vuxnYjwvISZ+GEOrwmINOXOHsNxOpo9g++5yiKSz2D
         BwRG97903AOai1HJdfnVOtKhvCqWBrFwvlT/ktg9rSu2BVtQ9n98DQTF3Uc7X1Gycz
         kzQMQI/Wv1LQaqFJwvD52ZGFdMIjN1FpcI5Tih/T0r6eLI6dCp7fLupgEr6gFNPPsr
         QQpUWovFkNvDBXGeTKGk+lsM850aGFNF3lfWdgVZdMshk5AClsgzfw3cMenR0fGCYi
         2gxr+QOcOs56w==
Date:   Wed, 30 Mar 2022 17:38:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
        Cheng Lin <cheng.lin130@zte.com.cn>
Subject: Re: [PATCH] xfs: getattr ignore blocks beyond eof
Message-ID: <20220331003826.GL27690@magnolia>
References: <20220331080256.1874-1-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331080256.1874-1-wang.yi59@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 04:02:56PM +0800, Yi Wang wrote:
> From: Cheng Lin <cheng.lin130@zte.com.cn>
> 
> Blocks beyond EOF, which preallocated, will be reclaimed at some time.
> These blocks can be ignored when getattr.
> 
> This patch will optimize query accuracy for getattr blocks.

Huh?  This subtracts posteof blocks from the query results, which makes
the results *less accurate*.  Those blocks are mapped to the file, hence
they are supposed to be counted in nblocks.

--D

> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  fs/xfs/xfs_bmap_util.c |  1 +
>  fs/xfs/xfs_icache.c    |  1 +
>  fs/xfs/xfs_inode.h     |  1 +
>  fs/xfs/xfs_iomap.c     |  5 +++++
>  fs/xfs/xfs_iops.c      | 19 ++++++++++++++++++-
>  5 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index eb2e387..9f4081d 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -753,6 +753,7 @@
>  	if (error)
>  		goto out_unlock;
>  
> +	ip->i_last_fsb = end_fsb;
>  	xfs_inode_clear_eofblocks_tag(ip);
>  	goto out_unlock;
>  
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 9644f93..43ffb9e 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -102,6 +102,7 @@ struct xfs_inode *
>  	memset(&ip->i_df, 0, sizeof(ip->i_df));
>  	ip->i_flags = 0;
>  	ip->i_delayed_blks = 0;
> +	ip->i_last_fsb = 0;
>  	ip->i_diflags2 = mp->m_ino_geo.new_diflags2;
>  	ip->i_nblocks = 0;
>  	ip->i_forkoff = 0;
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index b7e8f14..56fc41b 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -55,6 +55,7 @@
>  	unsigned long		i_flags;	/* see defined flags below */
>  	uint64_t		i_delayed_blks;	/* count of delay alloc blks */
>  	xfs_fsize_t		i_disk_size;	/* number of bytes in file */
> +	xfs_fileoff_t		i_last_fsb;	/* last fsb preallocated */
>  	xfs_rfsblock_t		i_nblocks;	/* # of direct & btree blocks */
>  	prid_t			i_projid;	/* owner's project id */
>  	xfs_extlen_t		i_extsize;	/* basic/minimum extent size */
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index e552ce5..bd9266e 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -881,6 +881,7 @@
>  	bool			eof = false, cow_eof = false, shared = false;
>  	int			allocfork = XFS_DATA_FORK;
>  	int			error = 0;
> +	xfs_fileoff_t		prealloc_last_fsb = 0;
>  
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
> @@ -1024,6 +1025,7 @@
>  				XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes));
>  			ASSERT(p_end_fsb > offset_fsb);
>  			prealloc_blocks = p_end_fsb - end_fsb;
> +			prealloc_last_fsb = p_end_fsb;
>  		}
>  	}
>  
> @@ -1049,6 +1051,9 @@
>  		goto out_unlock;
>  	}
>  
> +	if (prealloc_last_fsb && prealloc_blocks)
> +		ip->i_last_fsb = prealloc_last_fsb;
> +
>  	if (allocfork == XFS_COW_FORK) {
>  		trace_xfs_iomap_alloc(ip, offset, count, allocfork, &cmap);
>  		goto found_cow;
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index b79b384..ca0372c 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -559,8 +559,14 @@
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  
> +	xfs_off_t		fsb_beyond_eof;
> +	xfs_fileoff_t		end_fsb;
> +
>  	trace_xfs_getattr(ip);
>  
> +	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
> +	fsb_beyond_eof = ip->i_last_fsb - end_fsb;
> +
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
>  
> @@ -574,7 +580,15 @@
>  	stat->atime = inode->i_atime;
>  	stat->mtime = inode->i_mtime;
>  	stat->ctime = inode->i_ctime;
> -	stat->blocks = XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
> +
> +	if (fsb_beyond_eof > 0) {
> +		stat->blocks =
> +		XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks)
> +				  - fsb_beyond_eof;
> +	} else {
> +		stat->blocks =
> +		XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
> +	}
>  
>  	if (xfs_has_v3inodes(mp)) {
>  		if (request_mask & STATX_BTIME) {
> @@ -988,6 +1002,9 @@
>  	ip->i_disk_size = newsize;
>  	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
>  
> +	/* update i_last_fsb to newsize when truncate.*/
> +	ip->i_last_fsb = XFS_B_TO_FSB(mp, newsize);
> +
>  	if (newsize <= oldsize) {
>  		error = xfs_itruncate_extents(&tp, ip, XFS_DATA_FORK, newsize);
>  		if (error)
> -- 
> 1.8.3.1
