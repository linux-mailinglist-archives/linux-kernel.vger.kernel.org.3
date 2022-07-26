Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E225A581170
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbiGZKst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiGZKsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:48:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13BE2409A;
        Tue, 26 Jul 2022 03:48:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 495511FAFF;
        Tue, 26 Jul 2022 10:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658832524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ATSO4xMIADm7bjDtI8e+Ds4M2Grb2QzkJbDH1yDDJW8=;
        b=edVJd26qqohpE4iChbKghKyoWrZk3k9/8Wp0maUDI0P9uT1Eqqdvy8NaX9zjZXmnNJT68a
        prkeJwDlt6MFM0O+PmpHgQhHc7G0rxu6ZIJz+Xm1HiyMXwFfDp5pe5gt6VHs0B8z4PQbPI
        YwCfgZx9yb3TfRQXm31xFPZScvmM5Vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658832524;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ATSO4xMIADm7bjDtI8e+Ds4M2Grb2QzkJbDH1yDDJW8=;
        b=7YBNe/h7dmfFBM1Nrr6+uMAyQaIP0OV27cPw6pwBuosaOlr+89xROxf1D3Jg71BJoc35K8
        Ulvk2OTxALT09DAg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 029892C15D;
        Tue, 26 Jul 2022 10:48:43 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A8B23A0664; Tue, 26 Jul 2022 12:48:42 +0200 (CEST)
Date:   Tue, 26 Jul 2022 12:48:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     zengjx95@gmail.com
Cc:     reiserfs-devel@vger.kernel.org, willy@infradead.org,
        jlayton@kernel.org, damien.lemoal@opensource.wdc.com, jack@suse.cz,
        edward.shishkin@gmail.com, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, kasong@tencent.com,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: Re: [PATCH] fs/reiserfs/inode: remove dead code in
 _get_block_create_0()
Message-ID: <20220726104842.flhaivkpbikqlhki@quack3>
References: <20220720083029.1065578-1-zengjx95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720083029.1065578-1-zengjx95@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-07-22 16:30:29, zengjx95@gmail.com wrote:
> From: Zeng Jingxiang <linuszeng@tencent.com>
> 
> Since commit 27b3a5c51b50 ("kill-the-bkl/reiserfs: drop the fs race
> watchdog from _get_block_create_0()"), which removed a label that may
> have the pointer 'p' touched in its control flow, related if statements
> now eval to constant value now. Just remove them.
> 
> Assigning value NULL to p here
> 293     char *p = NULL;
> 
> In the following conditional expression, the value of p is always NULL,
> As a result, the kunmap() cannot be executed.
> 308	if (p)
> 309		kunmap(bh_result->b_page);
> 
> 355	if (p)
> 356		kunmap(bh_result->b_page);
> 
> 366	if (p)
> 367		kunmap(bh_result->b_page);
> 
> Also, the kmap() cannot be executed.
> 399	if (!p)
> 400		p = (char *)kmap(bh_result->b_page);
> 
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Thanks! I've added the patch to my tree. I've also removed the unnecessary
initialization of 'p' to NULL. I'll push the patch to Linus in the coming
merge window.

									Honza

> ---
>  fs/reiserfs/inode.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
> index 0cffe054b78e..fe26e1746af9 100644
> --- a/fs/reiserfs/inode.c
> +++ b/fs/reiserfs/inode.c
> @@ -305,8 +305,6 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
>  	result = search_for_position_by_key(inode->i_sb, &key, &path);
>  	if (result != POSITION_FOUND) {
>  		pathrelse(&path);
> -		if (p)
> -			kunmap(bh_result->b_page);
>  		if (result == IO_ERROR)
>  			return -EIO;
>  		/*
> @@ -352,8 +350,6 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
>  		}
>  
>  		pathrelse(&path);
> -		if (p)
> -			kunmap(bh_result->b_page);
>  		return ret;
>  	}
>  	/* requested data are in direct item(s) */
> @@ -363,8 +359,6 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
>  		 * when it is stored in direct item(s)
>  		 */
>  		pathrelse(&path);
> -		if (p)
> -			kunmap(bh_result->b_page);
>  		return -ENOENT;
>  	}
>  
> @@ -396,9 +390,7 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
>  	 * sure we need to.  But, this means the item might move if
>  	 * kmap schedules
>  	 */
> -	if (!p)
> -		p = (char *)kmap(bh_result->b_page);
> -
> +	p = (char *)kmap(bh_result->b_page);
>  	p += offset;
>  	memset(p, 0, inode->i_sb->s_blocksize);
>  	do {
> -- 
> 2.27.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
