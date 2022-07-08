Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC9656BD3B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbiGHPRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbiGHPRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:17:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4AF61D5F;
        Fri,  8 Jul 2022 08:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE66860C28;
        Fri,  8 Jul 2022 15:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D141C341C0;
        Fri,  8 Jul 2022 15:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657293472;
        bh=fMS2TMVcPi33mOSwxDvEXXKaUPeXrEIY1JwXpnbyJXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ImDFrdj/O5jazkje+qbfCc95iH+0JWTL6o2u2SFapFTM6iRGXBlgNT9cxSisP/rif
         zGEmKjM8YYtlpB2fnIzKt08NGhNJoL7fC1rrvBWL/CLtt42pDuXFYrkwpjWp0YDbeO
         qReiy+DPQscnIfE/pk+nbAonBhPYIBATvaz+5KftCR/+j/owUlJbFO3e86MjHyviSV
         umMYhXEiGWSkXgpCUJw7G5nusKsbKPqwZQiv5Ddi607pLxc9qx6kbGKaQUlqyVLhSj
         mRAqg0ntRiSpR00ROL3QKRsYMZXTYlG1WEiX6T8xNNnZKWQH7+UveZvEvtrRk05vUk
         2GGZchLWXzTeg==
Date:   Fri, 8 Jul 2022 08:17:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <YshKnxb4VwXycPO8@magnolia>
References: <20220708194437.7eafe774@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708194437.7eafe774@canb.auug.org.au>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 07:44:37PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> fs/xfs/xfs_notify_failure.c: In function 'xfs_dax_notify_ddev_failure':
> fs/xfs/xfs_notify_failure.c:126:44: error: passing argument 1 of 'xfs_alloc_read_agf' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   126 |                 error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
>       |                                            ^~
>       |                                            |
>       |                                            struct xfs_mount *
> In file included from fs/xfs/xfs_notify_failure.c:12:
> fs/xfs/libxfs/xfs_alloc.h:173:42: note: expected 'struct xfs_perag *' but argument is of type 'struct xfs_mount *'
>   173 | int xfs_alloc_read_agf(struct xfs_perag *pag, struct xfs_trans *tp, int flags,
>       |                        ~~~~~~~~~~~~~~~~~~^~~
> fs/xfs/xfs_notify_failure.c:126:25: error: too many arguments to function 'xfs_alloc_read_agf'
>   126 |                 error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
>       |                         ^~~~~~~~~~~~~~~~~~
> In file included from fs/xfs/xfs_notify_failure.c:12:
> fs/xfs/libxfs/xfs_alloc.h:173:5: note: declared here
>   173 | int xfs_alloc_read_agf(struct xfs_perag *pag, struct xfs_trans *tp, int flags,
>       |     ^~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   469a9c74c119 ("xfs: implement ->notify_failure() for XFS")
> 
> interacting with commit
> 
>   c4829aba9c8d ("xfs: pass perag to xfs_alloc_read_agf()")
> 
> from the xfs tree.
> 
> I have applied the following merge fix patch.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 8 Jul 2022 19:11:56 +1000
> Subject: [PATCH] fix up for "xfs: pass perag to xfs_alloc_read_agf()"
> 
> interacting with "xfs: implement ->notify_failure() for XFS"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/xfs/xfs_notify_failure.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> index aa8dc27c599c..f3c62c19475e 100644
> --- a/fs/xfs/xfs_notify_failure.c
> +++ b/fs/xfs/xfs_notify_failure.c
> @@ -18,6 +18,7 @@
>  #include "xfs_rmap_btree.h"
>  #include "xfs_rtalloc.h"
>  #include "xfs_trans.h"
> +#include "xfs_ag.h"
>  
>  #include <linux/mm.h>
>  #include <linux/dax.h>
> @@ -122,8 +123,10 @@ xfs_dax_notify_ddev_failure(
>  		struct failure_info	notify;
>  		struct xfs_agf		*agf;
>  		xfs_agblock_t		agend;
> +		struct xfs_perag	*pag;
>  
> -		error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
> +		pag = xfs_perag_get(mp, agno);
> +		error = xfs_alloc_read_agf(pag, tp, 0, &agf_bp);
>  		if (error)
>  			break;

This isn't quite correct -- references to xfs_perag objects must be
released once they are acquired.  The following patch against today's
tree fixes this problem:

diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index f3c62c19475e..69d9c83ea4b2 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -127,10 +127,12 @@ xfs_dax_notify_ddev_failure(
 
 		pag = xfs_perag_get(mp, agno);
 		error = xfs_alloc_read_agf(pag, tp, 0, &agf_bp);
-		if (error)
+		if (error) {
+			xfs_perag_put(pag);
 			break;
+		}
 
-		cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agf_bp->b_pag);
+		cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, pag);
 
 		/*
 		 * Set the rmap range from ri_low to ri_high, which represents
@@ -151,6 +153,7 @@ xfs_dax_notify_ddev_failure(
 				xfs_dax_failure_fn, &notify);
 		xfs_btree_del_cursor(cur, error);
 		xfs_trans_brelse(tp, agf_bp);
+		xfs_perag_put(pag);
 		if (error)
 			break;
 

--D

>  
> -- 
> 2.35.1
> 
> -- 
> Cheers,
> Stephen Rothwell


