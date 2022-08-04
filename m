Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96595896C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 05:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbiHDD4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 23:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiHDD4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 23:56:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7046E1CFFE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 20:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CC206176C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 03:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4121CC433D6;
        Thu,  4 Aug 2022 03:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659585397;
        bh=ZE63X+HpqSJiRhP61iaYy9y7WLLTkPFf7E1SvBXIbwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Znb5rMZmSWKe8Uj+o5Q5nsBEOP1pBj10+v6lOUNmIr0ybY8eYQO/KonsOz1LJfsNk
         rPL0xGXFud7/gV27kqhtIpgSm+gLqgjI1PrGp9aEZZuP5HkWwBU9CZPj1qcRJgdHc1
         44+9sXG9NaQkzvmRsZszXY0Y0eEtsXMdrQgHthm4D7dWqias6N6jImoAoAhqSwt43S
         b0OxNl7fTSzW02SG1cazvIJQVpFA+YkY4Bu4dE8uuZL70E3D/CnXjrhLadF2/3wTme
         WIeYKDvTcQObxK6OA/5kGO+47P7Px1AsFLH/z5O4UIO9VSM/8FWkoKSuYgNtxjv/WH
         YpFOM5O1GOC3A==
Date:   Wed, 3 Aug 2022 20:56:35 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     studentxswpy@163.com
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Hacash Robot <hacashRobot@santino.com>
Subject: Re: [PATCH -next] f2fs: Replace kmalloc() with f2fs_kmalloc
Message-ID: <YutDc6n08xw0iG+3@google.com>
References: <20220801092202.3134668-1-studentxswpy@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801092202.3134668-1-studentxswpy@163.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01, studentxswpy@163.com wrote:
> From: Xie Shaowen <studentxswpy@163.com>
> 
> replace kmalloc with f2fs_kmalloc to keep f2fs code consistency.
> 
> Reported-by: Hacash Robot <hacashRobot@santino.com>
> Signed-off-by: Xie Shaowen <studentxswpy@163.com>
> ---
>  fs/f2fs/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index d5bd7932fb64..712b51f69c04 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -232,7 +232,7 @@ static int f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
>  		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(dir)))
>  			return -EINVAL;
>  
> -		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
> +		decrypted_name.name = f2fs_kmalloc(de_name_len, GFP_KERNEL);

Please fix the build breakage.

fyi;

static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi, size_t size, gfp_t flags)

>  		if (!decrypted_name.name)
>  			return -ENOMEM;
>  		res = fscrypt_fname_disk_to_usr(dir, 0, 0, &encrypted_name,
> -- 
> 2.25.1
