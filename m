Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AB659E7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245386AbiHWQrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343901AbiHWQqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:46:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1899786CF;
        Tue, 23 Aug 2022 07:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80C3E615AB;
        Tue, 23 Aug 2022 14:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AB3C433D6;
        Tue, 23 Aug 2022 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661264831;
        bh=aGV+Fmg/SuRFVLlUg2Us/FFj2AqB7Uc5ikRU/xAOnCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dd30lzFcOIEhCPvEPTxVad9kLL+SWbC0fsOxz+BF0MJNOH8LEBCs7c6sr8cmXriO7
         L6bMLhjd7mwlS89Q31GGdzrmw8DaurMKXLhd0gxXexaLXdanKRIlKOBdkFoVZpuCIJ
         BvnSouvgF7m2UR+RYIX5fIvi7SACuZIuZBAJW61lB+DTpV7Y7gRorBCedgGU8vY+7N
         P94MFdbBmCvUESV4HSFrMl9xN1WYtl8e0TFEMQGMUQzORzIfQ7IduQFxcyzi/K6zgK
         wa6wNCTRCZmC1oKS/qFcVc2Y0MKKacZRLQm5P78jWG7PYluS4RzOcTvDtVvR8Bt5WB
         VyGCWVbbQtTTw==
Date:   Tue, 23 Aug 2022 07:27:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] xfs: remove "%Lu" which doesn't meet C standard
Message-ID: <YwTjv0bpf3Ed0JjS@magnolia>
References: <20220823015517.4160583-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823015517.4160583-1-zengheng4@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 09:55:17AM +0800, Zeng Heng wrote:
> The "%Lu" specifier, which represents long long unsigned,
> doesn't meet C language standard, and even more,
> it makes people easily mistake with "%lu", which represent
> long unsigned. So replace "%Lu" with "llu".
> 
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>

Yesss finally fixing this
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_inode.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 28493c8e9bb2..b3eeeae3afe1 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -3119,7 +3119,7 @@ xfs_iflush(
>  	if (XFS_TEST_ERROR(dip->di_magic != cpu_to_be16(XFS_DINODE_MAGIC),
>  			       mp, XFS_ERRTAG_IFLUSH_1)) {
>  		xfs_alert_tag(mp, XFS_PTAG_IFLUSH,
> -			"%s: Bad inode %Lu magic number 0x%x, ptr "PTR_FMT,
> +			"%s: Bad inode %llu magic number 0x%x, ptr "PTR_FMT,
>  			__func__, ip->i_ino, be16_to_cpu(dip->di_magic), dip);
>  		goto flush_out;
>  	}
> @@ -3129,7 +3129,7 @@ xfs_iflush(
>  		    ip->i_df.if_format != XFS_DINODE_FMT_BTREE,
>  		    mp, XFS_ERRTAG_IFLUSH_3)) {
>  			xfs_alert_tag(mp, XFS_PTAG_IFLUSH,
> -				"%s: Bad regular inode %Lu, ptr "PTR_FMT,
> +				"%s: Bad regular inode %llu, ptr "PTR_FMT,
>  				__func__, ip->i_ino, ip);
>  			goto flush_out;
>  		}
> @@ -3140,7 +3140,7 @@ xfs_iflush(
>  		    ip->i_df.if_format != XFS_DINODE_FMT_LOCAL,
>  		    mp, XFS_ERRTAG_IFLUSH_4)) {
>  			xfs_alert_tag(mp, XFS_PTAG_IFLUSH,
> -				"%s: Bad directory inode %Lu, ptr "PTR_FMT,
> +				"%s: Bad directory inode %llu, ptr "PTR_FMT,
>  				__func__, ip->i_ino, ip);
>  			goto flush_out;
>  		}
> @@ -3158,7 +3158,7 @@ xfs_iflush(
>  	if (XFS_TEST_ERROR(ip->i_forkoff > mp->m_sb.sb_inodesize,
>  				mp, XFS_ERRTAG_IFLUSH_6)) {
>  		xfs_alert_tag(mp, XFS_PTAG_IFLUSH,
> -			"%s: bad inode %Lu, forkoff 0x%x, ptr "PTR_FMT,
> +			"%s: bad inode %llu, forkoff 0x%x, ptr "PTR_FMT,
>  			__func__, ip->i_ino, ip->i_forkoff, ip);
>  		goto flush_out;
>  	}
> -- 
> 2.25.1
> 
