Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3079E5690A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiGFRYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiGFRYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:24:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69012C12;
        Wed,  6 Jul 2022 10:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E794B81E67;
        Wed,  6 Jul 2022 17:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E03C3411C;
        Wed,  6 Jul 2022 17:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657128283;
        bh=6Sk0xJ/PruRoP1qaorVhBxfYBDuwBIhPQI+yDcyDC3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BcrW4/oEZY42Rwe+0NFnXd0OrVChxxYsIXIbUIaobGN6cN6pHdNMbQMXe1m1tcmaS
         WR9PkAXn0msjm6Upoz06gxjxfuXBUEYM+Qejv895yDQD9d9U1McsgPzVjMJXqHXW9X
         Mk5eMho5H0+bUK2/5BzT9MTa7EtCV9IrgxJPokcevVj+iAatLJ3wZI/+yyH0h9UjlT
         GM4zOy9M1fBrLNhsPkt3XBT+53dNrpcIfccQb53p9yfmeRuC85yZb86axm9kP+rqLx
         BJWa9TJ6CFhWcUKuTpiQbWMYHpOyrHg7y3iIO1JgXCbL4ILqmpGt1Cw9p7aBzixgKy
         CKtLCzkeX2fcQ==
Date:   Wed, 6 Jul 2022 10:24:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     dchinner@redhat.com, chandan.babu@oracle.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: fix potential memory leak in xfs_bmap_add_attrfork()
Message-ID: <YsXFWwNIMrrurD6w@magnolia>
References: <20220706082237.2255887-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706082237.2255887-1-niejianglei2021@163.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 04:22:37PM +0800, Jianglei Nie wrote:
> xfs_bmap_add_attrfork() allocates a memory chunk for ip->i_afp with
> xfs_ifork_alloc(). When some error occurs, the function goto trans_cancel;
> without releasing the ip->i_afp, which will lead to a memory leak.
> 
> We should release the ip->i_afp with kmem_cache_free() and set "ip->i_afp
> = NULL" if ip->i_afp is not NULL pointer.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 6833110d1bd4..0c99726c0968 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -1088,6 +1088,10 @@ xfs_bmap_add_attrfork(
>  trans_cancel:
>  	xfs_trans_cancel(tp);
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	if (ip->i_afp) {
> +		kmem_cache_free(xfs_ifork_cache, ip->i_afp);
> +		ip->a_afp = NULL;
> +	}

I don't think this is correct.  If xfs_bmap_add_attrfork_* fail without
dirtying the transaction, this function cancels the transaction without
shutting down the filesystem, and return the error code to the caller.
However, i_forkoff is not reset to zero, which means that the inode
still has an attr fork, so i_afp must not be freed.

Freeing the memory and nulling out the pointer without resetting
i_forkoff results in inconsistent incore state, which will probably lead
to a crash somewhere.  In the end, inode reclaim will free i_afp.

I think this is mooted by[1], right?

--D

[1] https://lore.kernel.org/linux-xfs/165705898555.2826746.14913566803667615290.stgit@magnolia/T/#u

>  	return error;
>  }
>  
> -- 
> 2.25.1
> 
