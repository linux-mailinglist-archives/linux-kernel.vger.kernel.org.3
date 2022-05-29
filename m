Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E31536FFF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiE2G0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiE2G0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:26:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C356793B4
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 23:26:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E872B80A07
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 06:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C0CC385A9;
        Sun, 29 May 2022 06:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653805573;
        bh=UF+6G0/96AH95hL9450x59das5x8gxwXIY/JTdRDlwk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=u9zJW5inNplLlRKcX5fmLYWIkbJ6m3I8J5RY5q6YQfEV/AECd0wP6Is8IE2coQWvY
         PCbV87akiusFFcooKNI3wTf8jKMGV7t80GsDQhO559YRGTwaagVkV1HBgshMd+aEE2
         msOC+lnEok+LO8uTehCduUoZXO9pzf0o0l+euyS2GcfUjx9X15BezvIS1Tn2RIEsTX
         AGju8X3aacSOAMzu7R3bMNIh2yGdjqzOOpQNA5wQVFKoS8gsx3zx3YN99JXYUBgyyL
         ahg1drB3foK2/5gTLiTihu3ou9R8yQ9/Pu9sV2r+BJ6WYJvWOi4k9WIMpA8R929v+A
         2Wf9l4Qj3ZWnw==
Message-ID: <fbb1ba90-a9f7-cd83-3bb4-700eff3b2497@kernel.org>
Date:   Sun, 29 May 2022 14:26:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] erofs: update ctx->pos for every emitted dirent
Content-Language: en-US
To:     Hongnan Li <hongnan.li@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/27 15:25, Hongnan Li wrote:
> erofs_readdir update ctx->pos after filling a batch of dentries
> and it may cause dir/files duplication for NFS readdirplus which
> depends on ctx->pos to fill dir correctly. So update ctx->pos for
> every emitted dirent in erofs_fill_dentries to fix it.
> 
> Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
> ---
>   fs/erofs/dir.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 18e59821c597..3015974fe2ff 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -22,11 +22,12 @@ static void debug_one_dentry(unsigned char d_type, const char *de_name,
>   }
>   
>   static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
> -			       void *dentry_blk, unsigned int *ofs,
> +			       void *dentry_blk, void *dentry_begin,
>   			       unsigned int nameoff, unsigned int maxsize)
>   {
> -	struct erofs_dirent *de = dentry_blk + *ofs;
> +	struct erofs_dirent *de = dentry_begin;
>   	const struct erofs_dirent *end = dentry_blk + nameoff;
> +	loff_t begin_pos = ctx->pos;
>   
>   	while (de < end) {
>   		const char *de_name;
> @@ -59,9 +60,9 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>   			/* stopped by some reason */
>   			return 1;
>   		++de;
> -		*ofs += sizeof(struct erofs_dirent);
> +		ctx->pos += sizeof(struct erofs_dirent);
>   	}
> -	*ofs = maxsize;
> +	ctx->pos = begin_pos + maxsize;
>   	return 0;
>   }
>   
> @@ -110,11 +111,9 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   				goto skip_this;
>   		}
>   
> -		err = erofs_fill_dentries(dir, ctx, de, &ofs,
> +		err = erofs_fill_dentries(dir, ctx, de, de + ofs,
>   					  nameoff, maxsize);
>   skip_this:

I guess there are two paths may be affected in erofs_readdir():
- for EFSCORRUPTED case, how about avoiding "goto skip_this" since we
can just break there.
- for initial case, do we need to update ctx->pos as well?

Thanks,

> -		ctx->pos = blknr_to_addr(i) + ofs;
> -
>   		if (err)
>   			break;
>   		++i;
