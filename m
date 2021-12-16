Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B717E477C86
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhLPT1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:27:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52720 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhLPT1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:27:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7104261F56
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 19:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D6AC36AE7;
        Thu, 16 Dec 2021 19:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639682863;
        bh=y9pmpG/GpQhywg0oyPjfAOSC0w9MurmFDyL8vwRPxdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MtTytv3KtLulXsc5BdJ2vK0Vq2DfIPyfF7uY6lJc2e//Z1J3bTD7+eQDqxmgy8MFH
         Ix2pYTZecI7tdxbAKQ8ZBY621IzmQlhaVdrrDhs5PBDzoxH7N9Vy4NvxQTSmD+8qD2
         kSx0qI44oFplBGf3ER3NIuFGCOb1zZOWHCHbmKqkr7vIRMw/MRC4qyGpyI/k9haSKU
         ADMOI/auT7tegII6s8t+z0DLlopY4+oDBoPGHSU60uo/N0THauoJdHG4Ot5EkZvbPU
         y5T/DXclQ/oOvM8V5oprN4GNjpXAHc0Oj4rMZRbfDKX/r3znLPEHkPEXfFiDWiCDnE
         wuBiA79X1lRAw==
Date:   Thu, 16 Dec 2021 11:27:42 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] f2fs: Simplify bool conversion
Message-ID: <YbuTLr/HJO3IMI6u@google.com>
References: <20211215023858.33303-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215023858.33303-1-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15, Yang Li wrote:
> Fix the following coccicheck warning:
> ./fs/f2fs/sysfs.c:491:41-46: WARNING: conversion to bool not needed here
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/f2fs/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 9e1cf44642ae..530c36b89bf1 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -488,7 +488,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  
>  	if (!strcmp(a->attr.name, "gc_urgent_high_remaining")) {
>  		spin_lock(&sbi->gc_urgent_high_lock);
> -		sbi->gc_urgent_high_limited = t == 0 ? false : true;
> +		sbi->gc_urgent_high_limited = t != 0;

Why not this?
		sbi->gc_urgent_high_limited = t;

>  		sbi->gc_urgent_high_remaining = t;
>  		spin_unlock(&sbi->gc_urgent_high_lock);
>  
> -- 
> 2.20.1.7.g153144c
