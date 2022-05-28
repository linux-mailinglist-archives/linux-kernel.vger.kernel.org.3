Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4AC536D05
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 14:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiE1M4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 08:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbiE1M4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 08:56:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA081136
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 05:56:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34027B826FB
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 12:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74A0C34100;
        Sat, 28 May 2022 12:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653742584;
        bh=J7E0lVyIo+juV6HoBpjS0XC2CTEDG/qqYQnsEbI+6KM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAXCeLmS0ELKIjWVPGhirgLBRU3x4frBF+lzSaeOqheE6zEQCAHO7boLdjdFQk700
         s4v0CgbBnQfstpnz2kcfzQcPDfTSsmF4zfiiUoB2Rq4nZbIEftL1uJrqqQeWaI4gR6
         MOaN39L1zpApUUXLgQ3G/IFF0RGXvPqCk613v8NsVeHH8VQpxVZ3WqempZOxNWE0Hp
         z2xlNlJdsjte1PEHHlpYrLj5FkLUSMs+bw6xcVzl83WpsoBx/+Hb6B6aH/aoLl3UNz
         7RUQzsCVXA8Vbv539D8qdBcG0QucPIclZEtfa2wgiO0jvrHk2NlZXWrlC03zX62WG8
         q/kHXkS0/f1Jw==
Date:   Sat, 28 May 2022 20:56:17 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Hongnan Li <hongnan.li@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: update ctx->pos for every emitted dirent
Message-ID: <YpIb8e7eWy+IFi/j@debian>
Mail-Followup-To: Hongnan Li <hongnan.li@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hongnan,

On Fri, May 27, 2022 at 03:25:36PM +0800, Hongnan Li wrote:
> erofs_readdir update ctx->pos after filling a batch of dentries
> and it may cause dir/files duplication for NFS readdirplus which
> depends on ctx->pos to fill dir correctly. So update ctx->pos for
> every emitted dirent in erofs_fill_dentries to fix it.
> 
> Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
> ---
>  fs/erofs/dir.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 18e59821c597..3015974fe2ff 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -22,11 +22,12 @@ static void debug_one_dentry(unsigned char d_type, const char *de_name,
>  }
>  
>  static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
> -			       void *dentry_blk, unsigned int *ofs,
> +			       void *dentry_blk, void *dentry_begin,
>  			       unsigned int nameoff, unsigned int maxsize)
>  {
> -	struct erofs_dirent *de = dentry_blk + *ofs;
> +	struct erofs_dirent *de = dentry_begin;
>  	const struct erofs_dirent *end = dentry_blk + nameoff;
> +	loff_t begin_pos = ctx->pos;
>  
>  	while (de < end) {
>  		const char *de_name;
> @@ -59,9 +60,9 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>  			/* stopped by some reason */
>  			return 1;
>  		++de;
> -		*ofs += sizeof(struct erofs_dirent);
> +		ctx->pos += sizeof(struct erofs_dirent);
>  	}
> -	*ofs = maxsize;
> +	ctx->pos = begin_pos + maxsize;
>  	return 0;
>  }
>  
> @@ -110,11 +111,9 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>  				goto skip_this;
>  		}
>  
> -		err = erofs_fill_dentries(dir, ctx, de, &ofs,
> +		err = erofs_fill_dentries(dir, ctx, de, de + ofs,
>  					  nameoff, maxsize);

This will break the calculation, since de is a pointer of erofs_dirent
rather than byte-based.

Thanks,
Gao Xiang
