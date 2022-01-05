Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33B44858F0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 20:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbiAETLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 14:11:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45548 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243385AbiAETLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:11:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 163C6B81CF9;
        Wed,  5 Jan 2022 19:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF928C36AE9;
        Wed,  5 Jan 2022 19:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641409894;
        bh=dWZ4e/BHVrqhZwbYEpDz5SoVifZJyHKACDqjzB5SKvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kC6/7VcYpcw/+03KiteHJ3eJBVkgS9jrd1FJcE+TaiLCtYVvLgoe07by0Xup0Wg0Y
         8ex4BelDmNFUPF+fcJzXJO2MH43xdMqc2ls5sO8RRocEjzNi/Vmt9Gju5c+tZEMS5+
         jFn4+bke0aBZItmkVcOwnIAoYS/ho9DfCJdoqy5mWqjx2E1xpJi6U3eWudf0gvlC5D
         knjNM0ap5X4GXv0K4CVOxcGSBjOCSfXLW7EQSJUPVekp0fs8K+hqG6r1bSR8A/2EOp
         XubZLUEgKxWLwkaY6F78teCvSOtIl5di1lvqY3OHbYSU7fxNomdy5zJ+UgAuUsE+Du
         pzdkcEOaIwfFg==
Date:   Wed, 5 Jan 2022 11:11:34 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] xfs: Remove redundant assignment of mp
Message-ID: <20220105191134.GK656707@magnolia>
References: <20220105151536.39062-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105151536.39062-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 11:15:36PM +0800, Jiapeng Chong wrote:
> mp is being initialized to log->l_mp but this is never read
> as record is overwritten later on. Remove the redundant
> assignment.
> 
> Cleans up the following clang-analyzer warning:
> 
> fs/xfs/xfs_log_recover.c:3543:20: warning: Value stored to 'mp' during
> its initialization is never read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Much improved, thank you.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> Changes in v2:
>  -Remove mp = log->l_mp.
> 
>  fs/xfs/xfs_log_recover.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
> index 8ecb9a8567b7..96c997ed2ec8 100644
> --- a/fs/xfs/xfs_log_recover.c
> +++ b/fs/xfs/xfs_log_recover.c
> @@ -3550,8 +3550,6 @@ xlog_recover_check_summary(
>  	uint64_t		ifree;
>  	int			error;
>  
> -	mp = log->l_mp;
> -
>  	freeblks = 0LL;
>  	itotal = 0LL;
>  	ifree = 0LL;
> -- 
> 2.20.1.7.g153144c
> 
