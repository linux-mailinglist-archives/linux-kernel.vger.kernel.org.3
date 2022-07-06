Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286AC56905A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiGFRLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiGFRLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:11:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC12201B4;
        Wed,  6 Jul 2022 10:11:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1C0261E90;
        Wed,  6 Jul 2022 17:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44865C3411C;
        Wed,  6 Jul 2022 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657127478;
        bh=R5uFfz3FlRiA/UmN4AvfiJh1+ViQVEYfhBWTVA9sjrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzNiWt6LgG05cY5vim/053sp6g+qWinAyoXkUx3t1aZ7SrPiSySwFnuYnPnKRd9ir
         Hdgpjp8E6hrjmqBWz1Rv54OW7UaKILwx4a1eS7h7rJi9s4o0L2glUjMYCa7VByqJEa
         b+hMfuJG58O/ZBB7qSHopGYrb1tzNrEmYey2L4DY06cAvtyAzukiG0BkUJm2mau2MF
         uVlDI2zL3GRm9D4xgY28dgPYJiZPsmKGmq0tRxrNy+jmCBno+lHLHdbaUJMqO0Ifpx
         mude+KnbUXfXhmHg4e0b1dZ5kSDoRHVWq7UYitkqLyYo1FALxEwZaLre6T387C430N
         0IcK/98LzgTrQ==
Date:   Wed, 6 Jul 2022 10:11:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andrey Strachuk <strochuk@ispras.ru>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] xfs: removed useless condition in function
 xfs_attr_node_get
Message-ID: <YsXCNSIeP9y9S2fa@magnolia>
References: <20220706133627.11198-1-strochuk@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706133627.11198-1-strochuk@ispras.ru>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 04:36:27PM +0300, Andrey Strachuk wrote:
> At line 1561, variable "state" is being compared
> with NULL every loop iteration.
> 
> -------------------------------------------------------------------
> 1561	for (i = 0; state != NULL && i < state->path.active; i++) {
> 1562		xfs_trans_brelse(args->trans, state->path.blk[i].bp);
> 1563		state->path.blk[i].bp = NULL;
> 1564	}
> -------------------------------------------------------------------
> 
> However, it cannot be NULL.
> 
> ----------------------------------------
> 1546	state = xfs_da_state_alloc(args);
> ----------------------------------------
> 
> xfs_da_state_alloc calls kmem_cache_zalloc. kmem_cache_zalloc is
> called with __GFP_NOFAIL flag and, therefore, it cannot return NULL.
> 
> --------------------------------------------------------------------------
> 	struct xfs_da_state *
> 	xfs_da_state_alloc(
> 	struct xfs_da_args	*args)
> 	{
> 		struct xfs_da_state	*state;
> 
> 		state = kmem_cache_zalloc(xfs_da_state_cache, GFP_NOFS | __GFP_NOFAIL);
> 		state->args = args;
> 		state->mp = args->dp->i_mount;
> 		return state;
> 	}
> --------------------------------------------------------------------------
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
> 
> Fixes: 4d0cdd2bb8f0 ("xfs: clean up xfs_attr_node_hasname")

Nit: usually the tags go at the end with no empty lines between them.

The change looks correct to me, so
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_attr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
> index 224649a76cbb..6b8857e53add 100644
> --- a/fs/xfs/libxfs/xfs_attr.c
> +++ b/fs/xfs/libxfs/xfs_attr.c
> @@ -1558,7 +1558,7 @@ xfs_attr_node_get(
>  	 * If not in a transaction, we have to release all the buffers.
>  	 */
>  out_release:
> -	for (i = 0; state != NULL && i < state->path.active; i++) {
> +	for (i = 0; i < state->path.active; i++) {
>  		xfs_trans_brelse(args->trans, state->path.blk[i].bp);
>  		state->path.blk[i].bp = NULL;
>  	}
> -- 
> 2.25.1
> 
