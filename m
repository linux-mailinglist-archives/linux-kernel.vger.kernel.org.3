Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346534866DF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbiAFPnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:43:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46850 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiAFPnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:43:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C09001F385;
        Thu,  6 Jan 2022 15:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641483779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lYxHH19Jtfgie+ghPiu3LKC7zINwaKHVJZFVyNL4Pi4=;
        b=vP3pw/bKCJbpcTkVkC8e3s+ucKkLMEAdGjzBHBt6p2kG+A1zeI41KktG7+5YFVVX/T3uf6
        Xf93jb0RUmrK67h8RGFC/kwAcGERtqjQvNxosxFC0596J89Yeq1yOePE/M9D8l8UbHBMY+
        aHJfYIVBFR0AZYWqAWaTeRcwC+nli/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641483779;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lYxHH19Jtfgie+ghPiu3LKC7zINwaKHVJZFVyNL4Pi4=;
        b=3bNUmqsPEnl6w8puZQl3nigwcMC6liyTczphIa64JGTXR5u/YnC9+JSxraSFND75Q/R0Vh
        t1Jj3DYMWrauc3Bg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id A6033A3B83;
        Thu,  6 Jan 2022 15:42:59 +0000 (UTC)
Received: by localhost (Postfix, from userid 1000)
        id DE2EBA0862; Thu,  6 Jan 2022 12:00:28 +0100 (CET)
Date:   Thu, 6 Jan 2022 12:00:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Qinghua Jin <qhjin.dev@gmail.com>
Cc:     christian.brauner@ubuntu.com, qhjin_dev@163.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] minix: fix bug when opening a file with O_DIRECT will
Message-ID: <20220106110028.jxicjy245ypdqejb@quack3.lan>
References: <20220106033042.347301-1-qhjin.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106033042.347301-1-qhjin.dev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-01-22 11:30:41, Qinghua Jin wrote:
> Testcase:
> 1. create a minix file system and mount it
> 2. open a file on the file system with O_RDWR|O_CREAT|O_TRUNC|O_DIRECT
> 3. open fails with -EINVAL but leaves an empty file behind. All other
> open() failures don't leave the failed open files behind.
> 
> It is hard to check the direct_IO op before creating the inode. Just as
> ext4 and btrfs do, this patch will resolve the issue by allowing to 
> create the file with O_DIRECT but returning error when writing the file.
> 
> Signed-off-by: Qinghua Jin <qhjin.dev@gmail.com>

The patch looks good. Thanks. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just out of curiosity: Do you happen to really use minix filesystem or was
this just a fallout from some fuzz testing or something like that?

								Honza
> ---
>  fs/minix/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index a71f1cf894b9..d4bd94234ef7 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -447,7 +447,8 @@ static const struct address_space_operations minix_aops = {
>  	.writepage = minix_writepage,
>  	.write_begin = minix_write_begin,
>  	.write_end = generic_write_end,
> -	.bmap = minix_bmap
> +	.bmap = minix_bmap,
> +	.direct_IO = noop_direct_IO
>  };
>  
>  static const struct inode_operations minix_symlink_inode_operations = {
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
