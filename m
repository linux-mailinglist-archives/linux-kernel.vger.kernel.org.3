Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0A557F544
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 15:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiGXNrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 09:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXNrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 09:47:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6893112AB3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 06:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AE0EB80D55
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 13:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602DFC3411E;
        Sun, 24 Jul 2022 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658670426;
        bh=8MUfeClKGcKn3AqtGfuecf9P0aJoL5wTpMq5gBsfuvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Ghi/sb6AHNs2SquAR9Zh7Y7LO1D/OeY3BGMpz33m8NNcKtoolVFdRiD4t6N/004p
         R/XDf0DHzUC5G4Sii/M8dxBlGehzszPiUg5u20gMTo5b1kDOuyUBSZwpsl1b6si49G
         0OBZWffxDOpYQSPA8z3cCYnEe0P1SrZ6NgLlFhwM=
Date:   Sun, 24 Jul 2022 15:47:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-ntfs-dev@lists.sourceforge.net,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: Ensure $Extend is a directory
Message-ID: <Yt1NVQEOC6Ki3eUI@kroah.com>
References: <20220724132107.1163-1-soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724132107.1163-1-soumya.negi97@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 06:21:07AM -0700, Soumya Negi wrote:
> Fixes Syzbot bug: kernel BUG in ntfs_lookup_inode_by_name
> https://syzkaller.appspot.com/bug?id=32cf53b48c1846ffc25a185a2e92e170d1a95d71
> 
> Check whether $Extend is a directory or not( for NTFS3.0+) while loading
> system files. If it isn't(as in the case of this bug where the mft record for
> $Extend contains a regular file), load_system_files() returns false.

Please wrap your changelog text at 72 columns like your editor asked you
to when writing this :)

> 
> Reported-by: syzbot+30b7f850c6d98ea461d2@syzkaller.appspotmail.com
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>

What commit caused this problem?  What Fixes: tag should go here?
Should it go to stable kernels?  If so, how far back?

> ---
>  fs/ntfs/super.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 5ae8de09b271..18e2902531f9 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -2092,10 +2092,15 @@ static bool load_system_files(ntfs_volume *vol)
>  	// TODO: Initialize security.
>  	/* Get the extended system files' directory inode. */
>  	vol->extend_ino = ntfs_iget(sb, FILE_Extend);
> -	if (IS_ERR(vol->extend_ino) || is_bad_inode(vol->extend_ino)) {
> +	if (IS_ERR(vol->extend_ino) || is_bad_inode(vol->extend_ino) ||
> +	    !S_ISDIR(vol->extend_ino->i_mode)) {
> +		static const char *es1 = "$Extend is not a directory";
> +		static const char *es2 = "Failed to load $Extend";
> +		const char *es = !S_ISDIR(vol->extend_ino->i_mode) ? es1 : es2;
> +
>  		if (!IS_ERR(vol->extend_ino))
>  			iput(vol->extend_ino);
> -		ntfs_error(sb, "Failed to load $Extend.");
> +		ntfs_error(sb, "%s.", es);

Are you allowing the system log to be spammed by an untrusted user with
this change?

thanks,

greg k-h
