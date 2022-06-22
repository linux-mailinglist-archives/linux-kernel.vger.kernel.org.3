Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BFF5541D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356925AbiFVElQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiFVElO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:41:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B278535848;
        Tue, 21 Jun 2022 21:41:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63904B81B08;
        Wed, 22 Jun 2022 04:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0657BC3411B;
        Wed, 22 Jun 2022 04:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655872870;
        bh=eEq1/2iPDzNz1B5Oou72nRfVOsUdg1B5WvvRswLKrBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+QXBEoaieKF6aDG6vUNkd0kuxYfFerKo7EkAuTsOIK4VUAmqA9o6W1sMonggZy14
         H4TVLn+gmLIIPFknf5xspz2pSX2gTsuSvmH/PFUVt/jkcRXnkxW15x11IbAwJm/wV4
         2wenMK2FnO94kUXkHZrITh7Pvng3C9mjBe770eZgba2/qavFem6QLFZUVdWtq+LeHG
         UO9J/lIJFDVBO3h0LTJwB+buoGcBJ1ZYTV7rFmRoSdgzCdktyFHWfreVsbn4mU/1Yb
         PFhlUFdhJxYo4l3iFGiVmf48eJhV6rJl51Qa9qJIddgZlNa0Pta5llu7jyldip7AQJ
         8sWYu8NS1Q9Aw==
Date:   Tue, 21 Jun 2022 21:41:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shida Zhang <starzhangzsd@gmail.com>
Cc:     dchinner@redhat.com, zhangshida@kylinos.cn,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3] xfs: add check before calling xfs_mod_fdblocks
Message-ID: <YrKdZc0fBBDWGjld@magnolia>
References: <20220621084238.1235880-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621084238.1235880-1-zhangshida@kylinos.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 04:42:38PM +0800, Shida Zhang wrote:
> Checks are missing when delta equals 0 in __xfs_ag_resv_free() and
> __xfs_ag_resv_init().
> 
> the case that the delta equals 0 is reachable with the command
> sequence below:
> 
>  # mkfs.xfs -f /dev/sdb5
>  # mount /dev/sdb5 /mnt/scratch/
> 
> where /dev/sdb5 is my disk for test. And if the patch below is
> applied:
> 
> ====
> xfs_mod_freecounter(
>         if (rsvd)
>                 ASSERT(has_resv_pool);
> 
> +       if (delta == 0)
> +               dump_stack();
> +
>         if (delta > 0) {
>                 /*
>                  * If the reserve pool is depleted, put blocks back into it
> ====
> 
> the following stack will be shown in the message:
> 
> =>  xfs_mod_freecounter+0x84/0x2b8
> =>  __xfs_ag_resv_free+0xc4/0x188
> =>  xfs_ag_resv_free+0x24/0x50
> =>  xfs_fs_unreserve_ag_blocks+0x40/0x160
> =>  xfs_mountfs+0x500/0x900
> =>  xfs_fs_fill_super+0x3d8/0x810
> =>  get_tree_bdev+0x164/0x258
> =>  xfs_fs_get_tree+0x20/0x30
> =>  vfs_get_tree+0x30/0xf8
> =>  path_mount+0x3c4/0xa58
> =>  do_mount+0x74/0x98
> 
> =>  xfs_mod_freecounter+0x84/0x2b8
> =>  __xfs_ag_resv_init+0x64/0x1d0
> =>  xfs_ag_resv_init+0x108/0x1c8
> =>  xfs_fs_reserve_ag_blocks+0x4c/0x110
> =>  xfs_mountfs+0x57c/0x900
> =>  xfs_fs_fill_super+0x3d8/0x810
> =>  get_tree_bdev+0x164/0x258
> =>  xfs_fs_get_tree+0x20/0x30
> =>  vfs_get_tree+0x30/0xf8
> =>  path_mount+0x3c4/0xa58
> =>  do_mount+0x74/0x98
> 
> After applying this patch, we can avoid to call xfs_mod_fdblocks when
> delta equals 0.
> 
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  Changes from v1:
>  -Add checks before calling xfs_mod_fdblocks instead.
>  Changes from v2:
>  -Rephrase the commit description.
> 
>  fs/xfs/libxfs/xfs_ag_resv.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_ag_resv.c b/fs/xfs/libxfs/xfs_ag_resv.c
> index fe94058d4e9e..c8fa032e4b00 100644
> --- a/fs/xfs/libxfs/xfs_ag_resv.c
> +++ b/fs/xfs/libxfs/xfs_ag_resv.c
> @@ -149,7 +149,12 @@ __xfs_ag_resv_free(
>  		oldresv = resv->ar_orig_reserved;
>  	else
>  		oldresv = resv->ar_reserved;
> -	error = xfs_mod_fdblocks(pag->pag_mount, oldresv, true);
> +
> +	if (oldresv)
> +		error = xfs_mod_fdblocks(pag->pag_mount, oldresv, true);
> +	else
> +		error = 0;
> +
>  	resv->ar_reserved = 0;
>  	resv->ar_asked = 0;
>  	resv->ar_orig_reserved = 0;
> @@ -215,8 +220,13 @@ __xfs_ag_resv_init(
>  
>  	if (XFS_TEST_ERROR(false, mp, XFS_ERRTAG_AG_RESV_FAIL))
>  		error = -ENOSPC;
> -	else
> -		error = xfs_mod_fdblocks(mp, -(int64_t)hidden_space, true);
> +	else {
> +		error = 0;
> +		if (hidden_space)
> +			error = xfs_mod_fdblocks(mp, -(int64_t)hidden_space,
> +						true);

I understand that calling __xfs_ag_resv_init on an AG with a maximally
sized data structure can result in @hidden_space being zero here, but
why does that matter enough to change the code?  Are you experiencing
problems when this happens?  Unnecessary slowdowns at mount time?
Something else?

This is v3 of a patch and I still can't tell why I should care ...?

--D

> +	}
> +
>  	if (error) {
>  		trace_xfs_ag_resv_init_error(pag->pag_mount, pag->pag_agno,
>  				error, _RET_IP_);
> -- 
> 2.25.1
> 
