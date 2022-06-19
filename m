Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680475507AB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 02:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiFSATd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 20:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSATc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 20:19:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D2F1261A
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 17:19:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFF34B80B47
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C371BC3411A;
        Sun, 19 Jun 2022 00:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655597967;
        bh=O+ZM0Cqi3Uuf67Id2quo+Fg1yOGML3ldASAxDhGo5Rc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lpwSoKfTLpwYlyWtUcBvaxcEx57QevVx86/RiKuwR1uZKMNsxCAmAL29HhlNP9N2G
         VsI9bWwIRCOmgKYr8uYXIUI5Q0HDTlkPCoDN9w4XTW1NrMqTWk8NA24g1y1ymIuq0Z
         x5L8FGe6Hb5qmNrbOXcBbSXGCKbsT2ElamEty7/wsSt9aQKWahwwDQsUiJH1l4z+AI
         zgmTyaEdqkrkhmBO3I2nsXteph/IDSj4BErcMC4VArtJryvHB30fPWEAhQtQ4kbhCW
         ioyyLa8xOHr5GzkIEdEk9zjtYJ87uePMP6zNtNbbS78MGNmeChQxU/ub2dwixVCBdi
         Sy+FUECcrDfSw==
Message-ID: <0c139517-e976-5017-8e7a-d34c38f0f6bb@kernel.org>
Date:   Sun, 19 Jun 2022 08:19:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] erofs: update ctx->pos for every emitted dirent
Content-Language: en-US
To:     Hongnan Li <hongnan.li@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
 <20220609034006.76649-1-hongnan.li@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220609034006.76649-1-hongnan.li@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/9 11:40, Hongnan Li wrote:
> erofs_readdir update ctx->pos after filling a batch of dentries
> and it may cause dir/files duplication for NFS readdirplus which
> depends on ctx->pos to fill dir correctly. So update ctx->pos for
> every emitted dirent in erofs_fill_dentries to fix it.
> 
> Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
> ---
>   fs/erofs/dir.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 18e59821c597..94ef5287237a 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -22,10 +22,9 @@ static void debug_one_dentry(unsigned char d_type, const char *de_name,
>   }
>   
>   static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
> -			       void *dentry_blk, unsigned int *ofs,
> +			       void *dentry_blk, struct erofs_dirent *de,
>   			       unsigned int nameoff, unsigned int maxsize)
>   {
> -	struct erofs_dirent *de = dentry_blk + *ofs;
>   	const struct erofs_dirent *end = dentry_blk + nameoff;
>   
>   	while (de < end) {
> @@ -59,9 +58,8 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>   			/* stopped by some reason */
>   			return 1;
>   		++de;
> -		*ofs += sizeof(struct erofs_dirent);
> +		ctx->pos += sizeof(struct erofs_dirent);
>   	}
> -	*ofs = maxsize;
>   	return 0;
>   }
>   
> @@ -95,7 +93,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   				  "invalid de[0].nameoff %u @ nid %llu",
>   				  nameoff, EROFS_I(dir)->nid);
>   			err = -EFSCORRUPTED;
> -			goto skip_this;
> +			break;
>   		}
>   
>   		maxsize = min_t(unsigned int,
> @@ -106,17 +104,19 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   			initial = false;
>   
>   			ofs = roundup(ofs, sizeof(struct erofs_dirent));
> -			if (ofs >= nameoff)
> +			if (ofs >= nameoff) {
> +				ctx->pos = blknr_to_addr(i) + ofs;
>   				goto skip_this;
> +			}
>   		}
>   
> -		err = erofs_fill_dentries(dir, ctx, de, &ofs,
> -					  nameoff, maxsize);
> -skip_this:
>   		ctx->pos = blknr_to_addr(i) + ofs;

Why updating ctx->pos before erofs_fill_dentries()?

Thanks,

> -
> +		err = erofs_fill_dentries(dir, ctx, de, (void *)de + ofs,
> +					  nameoff, maxsize);
>   		if (err)
>   			break;
> +		ctx->pos = blknr_to_addr(i) + maxsize;
> +skip_this:
>   		++i;
>   		ofs = 0;
>   	}
