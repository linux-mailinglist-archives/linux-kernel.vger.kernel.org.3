Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E2C477CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbhLPTgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:36:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45034 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhLPTgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:36:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27CD1B825EF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 19:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CAAC36AE2;
        Thu, 16 Dec 2021 19:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639683408;
        bh=Qyw3k44XmmD/B4tMrbx+Jw+nDCLMzGQs36DXFyLRNjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNVB7HSE8P9bK5KDQZZx3XzRZ21zowlaPyqwiHGY8RDCdEQo2AhWPr418XRfMY6l9
         d0SwoTfryCEYTceLgzNPC2nTGsh4X+SU1zmsD9uOuJXqq09fZ3SN2xPjN+QR5RAAnD
         OYzfAriOxuWabL8Tmqan31TxbuIsLxFVwQz5vUB87qPuQ2jUacGfQ7hqwK5ezwY+lM
         LfwvPRHsIiK17nM1kRDk8wetP4nrwGVEQ5m5iLu8uU+Nb8lQrYmB41INbF2uIMP5C+
         ykQrZPuwPPXFLweQIE/neb2mh1vyz5mTQmtV3xBGh9Wecn/2udLtorWlKDaWKDAA/S
         2/Bl/ISF90tAQ==
Date:   Thu, 16 Dec 2021 11:36:46 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: don't drop compressed page cache in
 .{invalidate,release}page
Message-ID: <YbuVTuA5ivCjra40@google.com>
References: <20211216091356.6643-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216091356.6643-1-chao@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16, Chao Yu wrote:
> For compressed inode, in .{invalidate,release}page, we will call
> f2fs_invalidate_compress_pages() to drop all compressed page cache of
> current inode.
> 
> But we don't need to drop compressed page cache synchronously in
> .invalidatepage, because, all trancation paths of compressed physical
> block has been covered with f2fs_invalidate_compress_page().
> 
> And also we don't need to drop compressed page cache synchronously
> in .releasepage, because, if there is out-of-memory, we can count
> on page cache reclaim on sbi->compress_inode.
> 
> BTW, this patch may fix the issue reported below:
> 
> https://lore.kernel.org/linux-f2fs-devel/20211202092812.197647-1-changfengnan@vivo.com/T/#u

I think this patch makes more sense to me.

> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - fix compile error.
>  fs/f2fs/data.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 2737fcc0dbcf..0fc6e0245732 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3528,12 +3528,9 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
>  
>  	clear_page_private_gcing(page);
>  
> -	if (test_opt(sbi, COMPRESS_CACHE)) {
> -		if (f2fs_compressed_file(inode))
> -			f2fs_invalidate_compress_pages(sbi, inode->i_ino);
> -		if (inode->i_ino == F2FS_COMPRESS_INO(sbi))
> -			clear_page_private_data(page);
> -	}
> +	if (test_opt(sbi, COMPRESS_CACHE) &&
> +			inode->i_ino == F2FS_COMPRESS_INO(sbi))
> +		clear_page_private_data(page);
>  
>  	if (page_private_atomic(page))
>  		return f2fs_drop_inmem_page(inode, page);
> @@ -3553,12 +3550,9 @@ int f2fs_release_page(struct page *page, gfp_t wait)
>  		return 0;
>  
>  	if (test_opt(F2FS_P_SB(page), COMPRESS_CACHE)) {
> -		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
>  		struct inode *inode = page->mapping->host;
>  
> -		if (f2fs_compressed_file(inode))
> -			f2fs_invalidate_compress_pages(sbi, inode->i_ino);
> -		if (inode->i_ino == F2FS_COMPRESS_INO(sbi))
> +		if (inode->i_ino == F2FS_COMPRESS_INO(F2FS_I_SB(inode)))
>  			clear_page_private_data(page);
>  	}
>  
> -- 
> 2.32.0
