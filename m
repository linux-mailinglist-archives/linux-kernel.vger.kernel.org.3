Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818A15B07A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiIGO41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiIGO4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:56:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FC6286F8;
        Wed,  7 Sep 2022 07:55:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1038B81D7A;
        Wed,  7 Sep 2022 14:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E47CC433D7;
        Wed,  7 Sep 2022 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662562545;
        bh=bH9HrZAJDhoFeB0PHhkw4ppdExU2mgAAxLygG0cWNsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wt3fnH5l+BP5fngmg7CjOfj4v8k2IVDLbp8ciYnoV6RjWm/tpqgxIw25kbfQeVRdE
         m56WktJArnnj9EXB6Hq0X8W5miugwv0vm2e7IftLxy0cUosSgja4933N4F9kX3jnbg
         rapFbeCGCEH4d1a2fsi2OuwBW9jzDz0bUb8NarNooe/kFWDzPG0Tdr0JQbzV5bS0Ne
         yExMEBkrEu2oX2VMzdETss61pVnIRbk4Lb06+ZgOaJJUuF+y74lpHKzRGQEjufNDq7
         xQZ+902E/dcoXmW3kLkknlCwsy8uqZn+/SEk8/NARwl7M1wDyxLOs20Osu5nT7tPB4
         n2iBhGLdqK3cg==
Date:   Wed, 7 Sep 2022 07:55:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     dchinner@redhat.com, chandan.babu@oracle.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        weiyongjun1@huawei.com, guoxuenan@huawei.com
Subject: Re: [PATCH -next] xfs: rmap: only XFS_DATA_FORK field would be set
 shared
Message-ID: <Yxiw8f55e0ZzjtNU@magnolia>
References: <20220906093554.899222-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906093554.899222-1-zengheng4@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 05:35:54PM +0800, Zeng Heng wrote:
> whichfork could be one of the following 3 types:
> XFS_DATA_FORK
> XFS_ATTR_FORK
> XFS_COW_FORK
> 
> XFS_COW_FORK is in-memory field instead of on-disk
> field, which doesn't need to update in rmap_btree
> (already preclude by `xfs_rmap_update_is_needed` ahead).
> 
> XFS_ATTR_FORK field doesn't support reflink share.
> 
> So here propose to set "whichfork == XFS_DATA_FORK"
> as condition.

As you already state, xfs_rmap_update_is_needed() filters out
whichfork==XFS_COW_FORK.  Why is this change necessary?  It looks like
pointless churn to me.

--D

> 
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  fs/xfs/libxfs/xfs_rmap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_rmap.c b/fs/xfs/libxfs/xfs_rmap.c
> index 094dfc897ebc..74b34a331cf0 100644
> --- a/fs/xfs/libxfs/xfs_rmap.c
> +++ b/fs/xfs/libxfs/xfs_rmap.c
> @@ -2549,7 +2549,7 @@ xfs_rmap_map_extent(
>  	if (!xfs_rmap_update_is_needed(tp->t_mountp, whichfork))
>  		return;
>  
> -	if (whichfork != XFS_ATTR_FORK && xfs_is_reflink_inode(ip))
> +	if (whichfork == XFS_DATA_FORK && xfs_is_reflink_inode(ip))
>  		type = XFS_RMAP_MAP_SHARED;
>  
>  	__xfs_rmap_add(tp, type, ip->i_ino, whichfork, PREV);
> @@ -2568,7 +2568,7 @@ xfs_rmap_unmap_extent(
>  	if (!xfs_rmap_update_is_needed(tp->t_mountp, whichfork))
>  		return;
>  
> -	if (whichfork != XFS_ATTR_FORK && xfs_is_reflink_inode(ip))
> +	if (whichfork == XFS_DATA_FORK && xfs_is_reflink_inode(ip))
>  		type = XFS_RMAP_UNMAP_SHARED;
>  
>  	__xfs_rmap_add(tp, type, ip->i_ino, whichfork, PREV);
> @@ -2593,7 +2593,7 @@ xfs_rmap_convert_extent(
>  	if (!xfs_rmap_update_is_needed(mp, whichfork))
>  		return;
>  
> -	if (whichfork != XFS_ATTR_FORK && xfs_is_reflink_inode(ip))
> +	if (whichfork == XFS_DATA_FORK && xfs_is_reflink_inode(ip))
>  		type = XFS_RMAP_CONVERT_SHARED;
>  
>  	__xfs_rmap_add(tp, type, ip->i_ino, whichfork, PREV);
> -- 
> 2.25.1
> 
