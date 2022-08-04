Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C94A58A083
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbiHDS3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiHDS3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:29:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E351D0C4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 11:29:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 417FC61617
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 18:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E50C433C1;
        Thu,  4 Aug 2022 18:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659637741;
        bh=B6nriIfph8fYOJUBlU0yKPRkJ6yBSCpseUxsuW/Ai4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tpoZW/Z3yXpE3cKMpPr4lKB1hrOMbxh5rHlOgQtjaJo/x1T0eO8OkTsSIq4hRJoPy
         1GkGJMgFh/dnzpVuAqSQifxCptE94w9u3kLRY14GQRbNEPDJiuJoF0yKBoUWR/ts0x
         FrJiPCWfCl9ONd6ha95QpvlYMjOmS7r+MmDJDqVXpjtdzzM62U9jCnidJ22iebr3u2
         GRVfQIJBD9oAPpvYIf0sjF0HKCYB9HtKiVvG2jl5S5KcSgnRJfnb8fiHx/WUxKhia/
         m+/a4FvHrzAdbC7PD6jWwSoFnHZpNy3q5BgxjqLyphQvzGAxKBOtLVfFxcg6TuB8m8
         6V2CVmjGNkLnA==
Date:   Thu, 4 Aug 2022 18:28:59 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check compression feature before
 enabling file compression
Message-ID: <YuwP67c0oNjhojmt@gmail.com>
References: <20220804134140.14455-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804134140.14455-1-chao@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 09:41:40PM +0800, Chao Yu wrote:
> From: Chao Yu <chao.yu@oppo.com>
> 
> This patch disallow to enable file compression in image which doesn't
> support compression feature.
> 
> Signed-off-by: Chao Yu <chao.yu@oppo.com>
> ---
>  fs/f2fs/file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 24f5b02c78e7..4a3f4eaa3fc5 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1872,6 +1872,8 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  			if (!f2fs_disable_compressed_file(inode))
>  				return -EINVAL;
>  		} else {
> +			if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
> +				return -EOPNOTSUPP;
>  			if (!f2fs_may_compress(inode))
>  				return -EINVAL;
>  			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
> -- 

How is this different from the same check that occurs earlier in the function?

- Eric
