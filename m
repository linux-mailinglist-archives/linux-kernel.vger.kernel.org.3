Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33018572D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiGMFvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiGMFvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:51:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ABDB8532;
        Tue, 12 Jul 2022 22:51:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD060B81C13;
        Wed, 13 Jul 2022 05:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AC8C3411E;
        Wed, 13 Jul 2022 05:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657691470;
        bh=KaIT3yMJfV6LR7svBRIQX1mSKYbyUoI6s7ErAlCEusg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d2u0wbYjvehRU2pTFGL9aOX1/gIFykhoV8lAAKvisgaM/DiX6FffVIpzIc+Tvw6kp
         TTouyHpNcbOBn3o4fZ2nMfDQmcZIb1bzih/+xt8+WgTQcqHJ9KxHpb4GqvB7fmUEeN
         Ty/CcWn3uBIn/k4Nl1Gx7lW9kZkTa0j+6nrK4qKktYlKtxDAIn3D+qIqp43FJUezB1
         YD8AWQlAUziv9Tvgp3vXD+G/WICoUeGo26coK6uu9JwgTcvuXYI0EyDoE+Tv0HWWLU
         aQaig90dPDhSYdxOzoXfJY/+8RxEFCQhTuwJxt4LqohyIjfYEO/rymjFwurb/9BxRv
         9xMzrkphhEI+g==
Date:   Tue, 12 Jul 2022 22:51:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     sunliming <sunliming@kylinos.cn>
Cc:     hch@lst.de, dchinner@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kelulanainsley@gmail.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH RESEND] xfs: fix for variable set but not used warning
Message-ID: <Ys5dTSjy2atOf5Tb@magnolia>
References: <20220713014300.5108-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713014300.5108-1-sunliming@kylinos.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 09:43:00AM +0800, sunliming wrote:
> Fix below kernel warning:
> 
> fs/xfs/scrub/repair.c:539:19: warning: variable 'agno' set but not used [-Wunused-but-set-variable]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  fs/xfs/scrub/repair.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/scrub/repair.c b/fs/xfs/scrub/repair.c
> index a02ec8fbc8ac..032de115e373 100644
> --- a/fs/xfs/scrub/repair.c
> +++ b/fs/xfs/scrub/repair.c
> @@ -533,14 +533,12 @@ xrep_reap_block(
>  {
>  	struct xfs_btree_cur		*cur;
>  	struct xfs_buf			*agf_bp = NULL;
> -	xfs_agnumber_t			agno;
>  	xfs_agblock_t			agbno;
>  	bool				has_other_rmap;
>  	int				error;
>  
> -	agno = XFS_FSB_TO_AGNO(sc->mp, fsbno);
>  	agbno = XFS_FSB_TO_AGBNO(sc->mp, fsbno);
> -	ASSERT(agno == sc->sa.pag->pag_agno);
> +	ASSERT(XFS_FSB_TO_AGNO(sc->mp, fsbno) == sc->sa.pag->pag_agno);

Much better, thank you.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
>  	/*
>  	 * If we are repairing per-inode metadata, we need to read in the AGF
> -- 
> 2.25.1
> 
