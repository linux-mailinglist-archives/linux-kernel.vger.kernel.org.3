Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD7152EF86
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351030AbiETPpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351027AbiETPpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:45:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3F21796FA;
        Fri, 20 May 2022 08:45:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 739BCB82A5D;
        Fri, 20 May 2022 15:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ECBC385A9;
        Fri, 20 May 2022 15:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653061513;
        bh=Vc86LN9Kl/kZdHiyBqJ9vnK7hHKZmKIn6mH8vCk639M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjn1x/XwdFtK55Z368/s6bzfN+nq7NRkd3rJvNKtBtxLNYNbKE5tSt9x+Y4dOJJIZ
         FGY8qJTLiBVfhYgQmHSPErYznIt3/8QR12w1GRrO5NCkxoygKksR+epBR8vy4QEiJ1
         OcdAeC6jaoV90v8zjOBXfswvgpeM9yJXVRQrkg15HYFMikXffAymyH2CjD5mHeVqQh
         g1bK9+9seL8tsriVPWJk6W4D9BtkaviorXZ9ADOxU7z5b7J3wf/mb2jXc3LAdbi8fh
         S9rwkVk/NbS6ds0XK9+PUCrQxxl3L5iId4GqzlpGu4ddohJjdLYUNDwJILbmxAoHRl
         I+9qZB248p1cw==
Date:   Fri, 20 May 2022 08:45:12 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] xfs: Remove dead code
Message-ID: <Yoe3iG5E9KK4l/pO@magnolia>
References: <20220520064416.5092-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520064416.5092-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:44:16PM +0800, Jiapeng Chong wrote:
> Remove tht entire xlog_recover_check_summary() function, this entire
> function is dead code and has been for 12 years.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

LGTM,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> Changes in v2:
>   -Remove dead code.
> 
>  fs/xfs/xfs_log_recover.c | 59 ----------------------------------------
>  1 file changed, 59 deletions(-)
> 
> diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
> index 97b941c07957..b1980d7cbbee 100644
> --- a/fs/xfs/xfs_log_recover.c
> +++ b/fs/xfs/xfs_log_recover.c
> @@ -39,13 +39,6 @@ STATIC int
>  xlog_clear_stale_blocks(
>  	struct xlog	*,
>  	xfs_lsn_t);
> -#if defined(DEBUG)
> -STATIC void
> -xlog_recover_check_summary(
> -	struct xlog *);
> -#else
> -#define	xlog_recover_check_summary(log)
> -#endif
>  STATIC int
>  xlog_do_recovery_pass(
>          struct xlog *, xfs_daddr_t, xfs_daddr_t, int, xfs_daddr_t *);
> @@ -3339,8 +3332,6 @@ xlog_do_recover(
>  	}
>  	mp->m_alloc_set_aside = xfs_alloc_set_aside(mp);
>  
> -	xlog_recover_check_summary(log);
> -
>  	/* Normal transactions can now occur */
>  	clear_bit(XLOG_ACTIVE_RECOVERY, &log->l_opstate);
>  	return 0;
> @@ -3483,7 +3474,6 @@ xlog_recover_finish(
>  	}
>  
>  	xlog_recover_process_iunlinks(log);
> -	xlog_recover_check_summary(log);
>  
>  	/*
>  	 * Recover any CoW staging blocks that are still referenced by the
> @@ -3517,52 +3507,3 @@ xlog_recover_cancel(
>  		xlog_recover_cancel_intents(log);
>  }
>  
> -#if defined(DEBUG)
> -/*
> - * Read all of the agf and agi counters and check that they
> - * are consistent with the superblock counters.
> - */
> -STATIC void
> -xlog_recover_check_summary(
> -	struct xlog		*log)
> -{
> -	struct xfs_mount	*mp = log->l_mp;
> -	struct xfs_perag	*pag;
> -	struct xfs_buf		*agfbp;
> -	struct xfs_buf		*agibp;
> -	xfs_agnumber_t		agno;
> -	uint64_t		freeblks;
> -	uint64_t		itotal;
> -	uint64_t		ifree;
> -	int			error;
> -
> -	freeblks = 0LL;
> -	itotal = 0LL;
> -	ifree = 0LL;
> -	for_each_perag(mp, agno, pag) {
> -		error = xfs_read_agf(mp, NULL, pag->pag_agno, 0, &agfbp);
> -		if (error) {
> -			xfs_alert(mp, "%s agf read failed agno %d error %d",
> -						__func__, pag->pag_agno, error);
> -		} else {
> -			struct xfs_agf	*agfp = agfbp->b_addr;
> -
> -			freeblks += be32_to_cpu(agfp->agf_freeblks) +
> -				    be32_to_cpu(agfp->agf_flcount);
> -			xfs_buf_relse(agfbp);
> -		}
> -
> -		error = xfs_read_agi(mp, NULL, pag->pag_agno, &agibp);
> -		if (error) {
> -			xfs_alert(mp, "%s agi read failed agno %d error %d",
> -						__func__, pag->pag_agno, error);
> -		} else {
> -			struct xfs_agi	*agi = agibp->b_addr;
> -
> -			itotal += be32_to_cpu(agi->agi_count);
> -			ifree += be32_to_cpu(agi->agi_freecount);
> -			xfs_buf_relse(agibp);
> -		}
> -	}
> -}
> -#endif /* DEBUG */
> -- 
> 2.20.1.7.g153144c
> 
