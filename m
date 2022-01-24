Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F0E498D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 20:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347538AbiAXTd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 14:33:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53600 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351017AbiAXTZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:25:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 262EB61483
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814B1C340E5;
        Mon, 24 Jan 2022 19:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643052345;
        bh=cGzIZ1MKIizkECbK+Lu6MG2AB+TsAwI9HGRrv3av30U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBIgUtI+EvImF0ZnkknOIa1odOeHkZxvWOe9sjHFCoHERQmLMXF/wGmAWuDjID+ss
         Br5A1DegoEO2p5tr1Pg0srwkXqnN7ZSQmHI/tl12j0Gwelrj+qcAHfw7A3i61XQesw
         RvBj2vThha7fuNGTOWz2XB6/L7MM8OXPyQk3P4CiXrX+BM9WG8HfRxs4NvGJA8qWxP
         6l2pzQBnavjC+BDfIVLFeracw1J7y2+aEnL9shzPuaNVXmCYAtAIGVPTr10L9yWeLq
         wzDK7/K4K+1YhHOmojtBEuWaCCApSU2rVq8hmeL9ZzjOhAhCH1G38Qnh5bEtHwI9F/
         ArMjIYa1c0ULg==
Date:   Mon, 24 Jan 2022 19:25:44 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Harry Austen <harryausten@hotmail.co.uk>
Cc:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix fileattr_set unsupported attribute
 handling
Message-ID: <Ye79OLCFLR3H+GnY@gmail.com>
References: <AM6PR10MB2838873D61CE1C0DB91EEDB9FA5C9@AM6PR10MB2838.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR10MB2838873D61CE1C0DB91EEDB9FA5C9@AM6PR10MB2838.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2022 at 12:59:03PM +0000, Harry Austen wrote:
> FS_IOC_SETFLAGS ioctl should return EOPNOTSUPP if the file attribute
> (e.g. FS_NOCOW_FL) is not supported, rather than silently ignoring it
> and returning success.
> 
> Fixes: 9b1bb01c8ae7 (f2fs: convert to fileattr)
> Signed-off-by: Harry Austen <harryausten@hotmail.co.uk>
> ---
>  fs/f2fs/file.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 92ec2699bc85..061bf35c2582 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3085,9 +3085,8 @@ int f2fs_fileattr_set(struct user_namespace *mnt_userns,
>  		return -EIO;
>  	if (!f2fs_is_checkpoint_ready(F2FS_I_SB(inode)))
>  		return -ENOSPC;
> -	if (fsflags & ~F2FS_GETTABLE_FS_FL)
> +	if (fsflags & ~F2FS_SETTABLE_FS_FL)
>  		return -EOPNOTSUPP;
> -	fsflags &= F2FS_SETTABLE_FS_FL;
>  	if (!fa->flags_valid)
>  		mask &= FS_COMMON_FL;

This is intentional, and matches what ext4 does; see the comment in the ext4
implementation of this:

        /*
         * chattr(1) grabs flags via GETFLAGS, modifies the result and
         * passes that to SETFLAGS. So we cannot easily make SETFLAGS
         * more restrictive than just silently masking off visible but
         * not settable flags as we always did.
         */

Also, even if this patch was correct, the Fixes tag is wrong.

- Eric
