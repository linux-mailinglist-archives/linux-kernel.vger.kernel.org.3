Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD002579059
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbiGSCBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiGSCBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:01:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D833B94D;
        Mon, 18 Jul 2022 19:01:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 981E2B816F8;
        Tue, 19 Jul 2022 02:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559F3C341C0;
        Tue, 19 Jul 2022 02:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658196078;
        bh=hsUkrPaFd478Emrc8EGUGtpEswMf8oLZ4LdEGp0TRUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNe6jQFYK4jCuCQRhAF560wteKtizVlqLCsgIEH67W8iLBNl7b1hceMlmj1v+xyVv
         61eGhDbzEp/3ezsSo2Qu6za7yUxbYZ6nRDfvhd4u13GR8cPud4MDN/7Gmr5KTUHXkg
         NywT/2uqaiJfrVH4FIF20PqKV8s2IR0hH1LPOYUZiMoWI8WC5P4AfQoH2ebudl3jsP
         KUjCXWyiPJ9t1CaMSsDoPovSJEmSgeLZfQHmKu+k1KxZboXzJ7mWCDEa5FFr2OWWiK
         J2V8hgiubv0AeQXUSI16xvLaDPMV6IW3DDt3qPml5sqPFGn7AuKa03vvBp5jyB7tXW
         H8etwZ5mG/nOA==
Date:   Mon, 18 Jul 2022 19:01:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     sunliming <sunliming@kylinos.cn>
Cc:     hch@lst.de, dchinner@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kelulanainsley@gmail.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH RESEND] xfs: fix for variable set but not used warning
Message-ID: <YtYQbQ48Evn62pgb@magnolia>
References: <20220719015442.646442-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719015442.646442-1-sunliming@kylinos.cn>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 09:54:42AM +0800, sunliming wrote:
> Fix below kernel warning:
> 
> fs/xfs/scrub/repair.c:539:19: warning: variable 'agno' set but not used [-Wunused-but-set-variable]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Ah, right, I did forget to push it in last week's batch, sorry about
that.  It'll be in Thursday's posting, thank you for the reminder.

--D

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
>  
>  	/*
>  	 * If we are repairing per-inode metadata, we need to read in the AGF
> -- 
> 2.25.1
> 
