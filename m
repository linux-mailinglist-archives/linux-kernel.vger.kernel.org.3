Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01760554A53
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347731AbiFVMun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347354AbiFVMul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:50:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857C910F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45387B81EAB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 12:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E54C34114;
        Wed, 22 Jun 2022 12:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655902238;
        bh=LXxV2XdWo9ODoRTaLbjoba11bZZU9SlnRfAgm8n7JzY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fLZ3mqtYAJa53yiCfNTiRj1aEhHPpsRxRTyyUS3j7nvWZTQETvpeH+NcsscuD0ZSF
         ZBRmPM252tNBMwjpni8AgN8bi0TmY2KfS62hwVOA47xp6kcqeGSd/uW2LXl/Gdgx9n
         b+n22ovai8cT4CUN1I3AHrgRojLQ/YZjXPP11+PLypEko5iOv9/1Ti2WiWsidNiJun
         UevxTFy3LRLL5Av02OEz+N/NQwqBAU/LjUp3Iz4Z86zaTYU4ewURivE4YiL9Oz7BNs
         Nj7JuCKAfXj+arqj2uEMsPvoAy8j5NP/912yVnaBE3Qnd6aXtHRXP4npLQN2TxyMpq
         V1qAxU+/OaGPg==
Message-ID: <7fb689d9-11ba-a173-8ad4-a328a03298a8@kernel.org>
Date:   Wed, 22 Jun 2022 20:50:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] f2fs: allow compression of files without blocks
Content-Language: en-US
To:     Chao Liu <chaoliu719@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
References: <20220621064202.1078536-1-chaoliu719@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220621064202.1078536-1-chaoliu719@gmail.com>
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

On 2022/6/21 14:42, Chao Liu wrote:
> From: Chao Liu <liuchao@coolpad.com>
> 
> Files created by truncate have a size but no blocks, so

I didn't get it, how can we create file by truncation...

Thanks,

> they can be allowed to enable compression.
> 
> Signed-off-by: Chao Liu <liuchao@coolpad.com>
> ---
>   fs/f2fs/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 2d1114b0ceef..daaa0dfd2d2e 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1879,7 +1879,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>   		if (iflags & F2FS_COMPR_FL) {
>   			if (!f2fs_may_compress(inode))
>   				return -EINVAL;
> -			if (S_ISREG(inode->i_mode) && inode->i_size)
> +			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
>   				return -EINVAL;
>   
>   			set_compress_context(inode);
