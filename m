Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAE85A6726
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiH3PT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiH3PTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:19:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C05112F129;
        Tue, 30 Aug 2022 08:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FFF1615D4;
        Tue, 30 Aug 2022 15:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDC0C433D6;
        Tue, 30 Aug 2022 15:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661872760;
        bh=YqZg7Td16/gFCCUl6PZrZTBaGRmDax5nevT17VJmW8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSabX1WGJB3wAPpInpPEFlGd4zy8hJ+2Z7sKxtIjQLKwIDLRN2swvT6M4pz9+A63b
         FV5cuRCgU6YTtFkI0OkSUi82nC0QzWXVuDl/IQBNEAnzbslohoBYbUjUMzVXQLgnJy
         zW6ygVkNs44w9NkUGxy339MBihphDsj5Bvo7WQY4pC6NtqkhZmtfMygYgTHEpAbfGA
         NAU0AFaQ+zeb1pSP8VUvfUiBzxJnFfnztXN3+XchbHZXvSsdzJN/BjehY6Nipuxgrb
         KLHV8srXQXTfAAPtpdh0k7yjlAKeJvsiGFn9r2wnLpq7D2pw312AmhcJ7nSW8jGkcv
         SVZIbZ3oxTEkQ==
Date:   Tue, 30 Aug 2022 08:19:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/2] xfs: simplify if-else condition in
 xfs_validate_new_dalign
Message-ID: <Yw4qd38m++Wg2uXQ@magnolia>
References: <20220830133939.2726749-1-zengheng4@huawei.com>
 <20220830133939.2726749-2-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830133939.2726749-2-zengheng4@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:39:38PM +0800, Zeng Heng wrote:
> "else" is not generally useful after a return,
> so remove them which makes if condition a bit
> more clear.
> 
> There is no logical changes.
> 
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>

Yep.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_mount.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index f10c88cee116..e8bb3c2e847e 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -300,26 +300,28 @@ xfs_validate_new_dalign(
>  	"alignment check failed: sunit/swidth vs. blocksize(%d)",
>  			mp->m_sb.sb_blocksize);
>  		return -EINVAL;
> -	} else {
> -		/*
> -		 * Convert the stripe unit and width to FSBs.
> -		 */
> -		mp->m_dalign = XFS_BB_TO_FSBT(mp, mp->m_dalign);
> -		if (mp->m_dalign && (mp->m_sb.sb_agblocks % mp->m_dalign)) {
> -			xfs_warn(mp,
> -		"alignment check failed: sunit/swidth vs. agsize(%d)",
> -				 mp->m_sb.sb_agblocks);
> -			return -EINVAL;
> -		} else if (mp->m_dalign) {
> -			mp->m_swidth = XFS_BB_TO_FSBT(mp, mp->m_swidth);
> -		} else {
> -			xfs_warn(mp,
> -		"alignment check failed: sunit(%d) less than bsize(%d)",
> -				 mp->m_dalign, mp->m_sb.sb_blocksize);
> -			return -EINVAL;
> -		}
>  	}
>  
> +	/*
> +	 * Convert the stripe unit and width to FSBs.
> +	 */
> +	mp->m_dalign = XFS_BB_TO_FSBT(mp, mp->m_dalign);
> +	if (mp->m_dalign && (mp->m_sb.sb_agblocks % mp->m_dalign)) {
> +		xfs_warn(mp,
> +	"alignment check failed: sunit/swidth vs. agsize(%d)",
> +			mp->m_sb.sb_agblocks);
> +		return -EINVAL;
> +	}
> +
> +	if (!mp->m_dalign) {
> +		xfs_warn(mp,
> +	"alignment check failed: sunit(%d) less than bsize(%d)",
> +			mp->m_dalign, mp->m_sb.sb_blocksize);
> +		return -EINVAL;
> +	}
> +
> +	mp->m_swidth = XFS_BB_TO_FSBT(mp, mp->m_swidth);

I think this reorganization of the if test logic is correct, but I
really wish this unit abuse ("m_swidth is a BB for short periods of time
and fsblock everywhere else") would get fixed to simplify analysis and
prevent us from stumbling over things like that some time later.

So for this change,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

But I would be very happy to see some tripping hazard removal. ;)

--D

> +
>  	if (!xfs_has_dalign(mp)) {
>  		xfs_warn(mp,
>  "cannot change alignment: superblock does not support data alignment");
> -- 
> 2.25.1
> 
