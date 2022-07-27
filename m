Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AEE58296A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiG0PQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiG0PQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:16:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DAB3AB02;
        Wed, 27 Jul 2022 08:16:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70836B821A5;
        Wed, 27 Jul 2022 15:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF7CC433C1;
        Wed, 27 Jul 2022 15:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658935009;
        bh=17BRNP+kf7IXU+AdqUGfee2ew+v5O/g11zzIFQ1yaSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spjVJW9YZ3RrSK1LYtwIlbDclRt0hxG7UTbzLQn/nqbPq97x6r2RPyzJOSPYqbi9b
         8a5/yaEK7RnqYFICT/VeucDoRxBfP43WHtQgA+rPdUIYOU2U1BhTS0s1pbxpvEqv8O
         JgkDQ2XZv8pHHTQ4gM7PXJKOeCzM/MCV0yMK05FZ6btDpJzLU0WDJmxjcVDRMcgasX
         MXkIzMTvRM/fL0GjHtPn+wpsXhT++k03A79NuwUrP8B6dB7RPDQLECa5x7J4aubCYw
         Wb60BxP/zXQiQDOxX1LYomDGji/WoNqtVgRNnqgH7V+LKEDBMi7Ge9hT3j+NKPlocf
         Hyl0cpXMs0kEg==
Date:   Wed, 27 Jul 2022 08:16:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        guoxuenan@huawei.com, liuyongqiang13@huawei.com,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH] xfs: fix NULL pointer dereference in xfs_getbmap()
Message-ID: <YuFW4OLWCuAhrC7R@magnolia>
References: <20220727085230.4073478-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727085230.4073478-1-chenxiaosong2@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 04:52:30PM +0800, ChenXiaoSong wrote:
> Reproducer:
>  1. fallocate -l 100M image
>  2. mkfs.xfs -f image
>  3. mount image /mnt
>  4. setxattr("/mnt", "trusted.overlay.upper", NULL, 0, XATTR_CREATE)
>  5. char arg[32] = "\x01\xff\x00\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00"
>                    "\x00\x00\x00\x00\x00\x08\x00\x00\x00\xc6\x2a\xf7";
>     fd = open("/mnt", O_RDONLY|O_DIRECTORY);
>     ioctl(fd, _IOC(_IOC_READ|_IOC_WRITE, 0x58, 0x2c, 0x20), arg);

Heh.  Is this worth an fstest?  It probably is, since prior to 5.20 this
would have been a UAF bug on top of a NULL deref.

> NULL pointer dereference will occur when race happens between xfs_getbmap()
> and xfs_bmap_set_attrforkoff():
> 
>          ioctl               |       setxattr
>  ----------------------------|---------------------------
>  xfs_getbmap                 |
>    xfs_ifork_ptr             |
>      xfs_inode_has_attr_fork |
>        ip->i_forkoff == 0    |
>      return NULL             |
>    ifp == NULL               |
>                              | xfs_bmap_set_attrforkoff
>                              |   ip->i_forkoff > 0
>    xfs_inode_has_attr_fork   |
>      ip->i_forkoff > 0       |
>    ifp == NULL               |
>    ifp->if_format            |
> 
> Fix this by locking i_lock before xfs_ifork_ptr().

Nit: it's ILOCK, not i_lock.  Otherwise... this looks correct to me --
take the IOLOCK and ILOCK in shared mode before accessing the inode fork
structures.

Do you have any suggestions for Fixes:?  I suspect this has been broken
for quite some time.

No need to fix the nit, I'll do that when I commit this.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> ---
>  fs/xfs/xfs_bmap_util.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index 74f96e1aa5cd..04d0c2bff67c 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -439,29 +439,28 @@ xfs_getbmap(
>  		whichfork = XFS_COW_FORK;
>  	else
>  		whichfork = XFS_DATA_FORK;
> -	ifp = xfs_ifork_ptr(ip, whichfork);
>  
>  	xfs_ilock(ip, XFS_IOLOCK_SHARED);
>  	switch (whichfork) {
>  	case XFS_ATTR_FORK:
> +		lock = xfs_ilock_attr_map_shared(ip);
>  		if (!xfs_inode_has_attr_fork(ip))
> -			goto out_unlock_iolock;
> +			goto out_unlock_ilock;
>  
>  		max_len = 1LL << 32;
> -		lock = xfs_ilock_attr_map_shared(ip);
>  		break;
>  	case XFS_COW_FORK:
> +		lock = XFS_ILOCK_SHARED;
> +		xfs_ilock(ip, lock);
> +
>  		/* No CoW fork? Just return */
> -		if (!ifp)
> -			goto out_unlock_iolock;
> +		if (!xfs_ifork_ptr(ip, whichfork))
> +			goto out_unlock_ilock;
>  
>  		if (xfs_get_cowextsz_hint(ip))
>  			max_len = mp->m_super->s_maxbytes;
>  		else
>  			max_len = XFS_ISIZE(ip);
> -
> -		lock = XFS_ILOCK_SHARED;
> -		xfs_ilock(ip, lock);
>  		break;
>  	case XFS_DATA_FORK:
>  		if (!(iflags & BMV_IF_DELALLOC) &&
> @@ -491,6 +490,8 @@ xfs_getbmap(
>  		break;
>  	}
>  
> +	ifp = xfs_ifork_ptr(ip, whichfork);
> +
>  	switch (ifp->if_format) {
>  	case XFS_DINODE_FMT_EXTENTS:
>  	case XFS_DINODE_FMT_BTREE:
> -- 
> 2.31.1
> 
