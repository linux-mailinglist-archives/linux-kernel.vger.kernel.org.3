Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B928048B760
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiAKTcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbiAKTcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:32:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5ACC06173F;
        Tue, 11 Jan 2022 11:32:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03FA66179D;
        Tue, 11 Jan 2022 19:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC2DC36AE3;
        Tue, 11 Jan 2022 19:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641929533;
        bh=zFHezRDj/He2BEMTsJMCe3hBszmeFA7vaU+zt4SEQEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZGmtBhTUz4YmvWEm5koDJn4dR8BZY0DRIDC5KTKSYX/xKx1GM4lZZcBAU/ynSQUPj
         w+e9xYDLLKxtqUxZbi1PbUCejEU7K36kMYcTEzEV5CigZwNNxnR+SYObIU2nHv/aAq
         jIpsuXbvaCyoYjjjy6IX00IoHOf3kJxFNikEerjdfc9is2PVVihqTYYuoJl2VmY9jr
         +BNzAJgdR/bBGuQeX2ubzCpL5pRVa3GFIKh+8+E1Mf9iXy7XXCUql9m98zLzuX6ExY
         6jDVrovZcULtM7S3Q0BHdq/TcImu1+ZzJXyZZzPv0zGeWa/d0wsNTnndauLxXt3vja
         GJcEJVHWSHS3w==
Date:   Tue, 11 Jan 2022 11:32:12 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     zhangyue <zhangyue1@kylinos.cn>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: fix the problem that the array may be out of bound
Message-ID: <20220111193212.GF656707@magnolia>
References: <20211119081758.399167-1-zhangyue1@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119081758.399167-1-zhangyue1@kylinos.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 04:17:58PM +0800, zhangyue wrote:
> In function 'xfs_btree_delrec()', if all data in array
> 'cur->bc_ptrs[level]' is 0, the 'level' may be greater than
> or equal to 'XFS_BTREE_MAXLEVELS'.
> 
> At this time, the array may be out of bound.
> 
> Signed-off-by: zhangyue <zhangyue1@kylinos.cn>

I /think/ this is no longer necessary since XFS_BTREE_MAXLEVELS went
away in 5.16, but if you disagree, please resend.

--D

> ---
>  fs/xfs/libxfs/xfs_btree.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
> index bbdae2b4559f..fe66d1adc169 100644
> --- a/fs/xfs/libxfs/xfs_btree.c
> +++ b/fs/xfs/libxfs/xfs_btree.c
> @@ -3694,6 +3694,9 @@ xfs_btree_delrec(
>  	tcur = NULL;
>  
>  	/* Get the index of the entry being deleted, check for nothing there. */
> +	if (level >= XFS_BTREE_MAXLEVELS)
> +		return -EFSCORRUPTED;
> +
>  	ptr = cur->bc_ptrs[level];
>  	if (ptr == 0) {
>  		*stat = 0;
> -- 
> 2.30.0
> 
