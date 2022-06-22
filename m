Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851D2554B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbiFVNmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiFVNmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:42:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E0037036
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:42:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D431261B2A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9ACCC34114;
        Wed, 22 Jun 2022 13:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655905338;
        bh=FrB/4+7tsuZuC4Tew+ANJVJUtZpsL5HmpOFNjm1p794=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lKZdQZDJCzfpBdnTwsIbWvsQyyR1yhVCFqy3qnfwXHOlGJ9Mh/zIbQZ+y6AJP8y45
         /Fg0rGwtm0zcL5QDzKZqogVbv7ObMkXckcVYUcW9/HaLUJwJVxZiTWmvzw3pCwaH9e
         XC1QIu8tbMNsKddKrjKCiZPbExW5v4SiQMzA2XJV8BYGuVtAbOLYT/rSzsdBuHakHn
         XeY39+QW+iNc7dcUszkDtWdMAWYO4JK0eSZagjwOMWBgI5pAhWI6Yfn8xi0xomZNaN
         fc+EptDQmnGdXEAfU9cXoCA549VEpvsVW6jteaGA3bT5u8kTEGH9qqfuIu42NPPEi+
         04QopMK1lnOMw==
Message-ID: <0771b00b-e781-cd29-896a-4b6ebc948c2e@kernel.org>
Date:   Wed, 22 Jun 2022 21:42:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] f2fs: fix to remove F2FS_COMPR_FL and tag F2FS_NOCOMP_FL
 at the same time
Content-Language: en-US
To:     Chao Liu <chaoliu719@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Xiaoyu Qi <qxy65535@gmail.com>, Chao Liu <liuchao@coolpad.com>
References: <20220621064833.1079383-1-chaoliu719@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220621064833.1079383-1-chaoliu719@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/21 14:48, Chao Liu wrote:
> From: Chao Liu <liuchao@coolpad.com>
> 
> If the inode has the compress flag, it will fail to use
> 'chattr -c +m' to remove its compress flag and tag no compress flag.
> However, the same command will be successful when executed again,
> as shown below:
> 
>    $ touch foo.txt
>    $ chattr +c foo.txt
>    $ chattr -c +m foo.txt
>    chattr: Invalid argument while setting flags on foo.txt
>    $ chattr -c +m foo.txt
>    $ f2fs_io getflags foo.txt
>    get a flag on foo.txt ret=0, flags=nocompression,inline_data
> 
> Fix this by removing some checks in f2fs_setflags_common()
> that do not affect the original logic. I go through all the
> possible scenarios, and the results are as follows. Bold is
> the only thing that has changed.
> 
> +---------------+-----------+-----------+----------+
> |               |            file flags            |
> + command       +-----------+-----------+----------+
> |               | no flag   | compr     | nocompr  |
> +---------------+-----------+-----------+----------+
> | chattr +c     | compr     | compr     | -EINVAL  |
> | chattr -c     | no flag   | no flag   | nocompr  |
> | chattr +m     | nocompr   | -EINVAL   | nocompr  |
> | chattr -m     | no flag   | compr     | no flag  |
> | chattr +c +m  | -EINVAL   | -EINVAL   | -EINVAL  |
> | chattr +c -m  | compr     | compr     | compr    |
> | chattr -c +m  | nocompr   | *nocompr* | nocompr  |
> | chattr -c -m  | no flag   | no flag   | no flag  |
> +---------------+-----------+-----------+----------+
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Chao Liu <liuchao@coolpad.com>
> ---
> 
> This patch depends on the the patch
> "f2fs: allow compression of files without blocks" sent earlier this day.
> 
>   fs/f2fs/file.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index daaa0dfd2d2e..0c3ae5993b7a 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1873,10 +1873,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>   		if (masked_flags & F2FS_COMPR_FL) {
>   			if (!f2fs_disable_compressed_file(inode))
>   				return -EINVAL;
> -		}
> -		if (iflags & F2FS_NOCOMP_FL)
> -			return -EINVAL;
> -		if (iflags & F2FS_COMPR_FL) {
> +		} else {
>   			if (!f2fs_may_compress(inode))
>   				return -EINVAL;
>   			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
> @@ -1885,10 +1882,6 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>   			set_compress_context(inode);
>   		}
>   	}
> -	if ((iflags ^ masked_flags) & F2FS_NOCOMP_FL) {
> -		if (masked_flags & F2FS_COMPR_FL)
> -			return -EINVAL;
> -	}

Without above check condition, can we return -EINVAL for the case:

chattr +c on file w/ nocompr flag

|               | no flag   | compr     | nocompr  |
+---------------+-----------+-----------+----------+
| chattr +c     | compr     | compr     | *-EINVAL*  |

Thanks,

> 
>   	fi->i_flags = iflags | (fi->i_flags & ~mask);
>   	f2fs_bug_on(F2FS_I_SB(inode), (fi->i_flags & F2FS_COMPR_FL) &&
> --
> 2.36.1
