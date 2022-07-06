Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9069A567C2A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 04:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGFC6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 22:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiGFC5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 22:57:55 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAA6DF4E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 19:57:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x4so13189854pfq.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 19:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CZr3dzSRDubMHiSbyMahDvMPsy6//7ZQ0uObt7KDHek=;
        b=HxQ5XpqCJR7bQ291/zFfr1/slk1+Ny8UQXCsnMvii/LnCXYabecAxcp7bZhDHLowsQ
         cgHOVNasCUngfgNFfrPBE8dOJs3lE11j0mLHHKMpI5Vmoa1DyvLziRvf+YgAW9SxxSt3
         mYWPDaPoFK3Q0Ht5mvWP7vpiruVFSmXeM9VnK9EuKNRTiqjlvIWYO+sDaiRzcZsckYgy
         RPL9GtLLo3pLQkZqocQtUZFodQOeoqVHFXtJ33C8Zv9D+Bs2DXs6ANQyES+I74DyXl1u
         R2Tv+rQs+CypcxrA0F8mQ9ADohWg9LeWbi+XEP7XWT8/UOzYFm7PLWr3EHbVu2mm4hB4
         7M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CZr3dzSRDubMHiSbyMahDvMPsy6//7ZQ0uObt7KDHek=;
        b=7V/q4wOiG9q2QnjORo3dGMa2NndeaunFnozy8f65c2308LSS+yLegeSUSVDQGadjde
         Ja077jzwWACncFgYmMXuK13cx/+tT4cqWp7bvwXWS/r54kn7hLZgxtN7XK5q+0Bokyce
         Ut1aj9c/hhyswdtYbSuz2nIaRn71q/3zm98k2ML54P3ttjA4K6vwkTO/RU0gTDB7i3LC
         Mz2iyYFOnUzK7Id9Fsk8bfyEO6Tt+bxJUWT2HQJvwSA5w2m1gGvY+zo4GAbbZCDm432h
         K5ttiXSNF569+N8kFdwnk8tOEVGEbMoeGPIdB90RWvzG7AAKNE+dne0iXODWdcObE/s+
         4d5w==
X-Gm-Message-State: AJIora87ArPhsyHBd06+hfvPOAk2je3AElwIZPHf0OTgkMrHLNqz0dT7
        BCIv7R7Q/LFYXIphjfLS2J4=
X-Google-Smtp-Source: AGRyM1sKLQ3d+GoXwwsvfwzbA/mZ6j9YV/pFxUw3me7+TWs0RGTz/ZvRqysF8WGZPZ6Gj9q2P4cFpQ==
X-Received: by 2002:aa7:94ad:0:b0:525:265b:991f with SMTP id a13-20020aa794ad000000b00525265b991fmr45295137pfl.30.1657076273975;
        Tue, 05 Jul 2022 19:57:53 -0700 (PDT)
Received: from liuchao-VM ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709027ed600b0016a0fe1a1fbsm24350981plb.220.2022.07.05.19.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 19:57:53 -0700 (PDT)
Date:   Wed, 6 Jul 2022 10:57:48 +0800
From:   Chao Liu <chaoliu719@gmail.com>
To:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Xiaoyu Qi <qxy65535@gmail.com>, Chao Liu <liuchao@coolpad.com>
Subject: Re: [PATCH] f2fs: fix to remove F2FS_COMPR_FL and tag F2FS_NOCOMP_FL
 at the same time
Message-ID: <YsT6LKtTQCuOdPHt@liuchao-VM>
References: <20220621064833.1079383-1-chaoliu719@gmail.com>
 <0771b00b-e781-cd29-896a-4b6ebc948c2e@kernel.org>
 <YrPvuPLze3QoCkPJ@liuchao-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrPvuPLze3QoCkPJ@liuchao-VM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

On Thu, Jun 23, 2022 at 12:44:40PM +0800, Chao Liu wrote:
> On Wed, Jun 22, 2022 at 09:42:13PM +0800, Chao Yu wrote:
> > On 2022/6/21 14:48, Chao Liu wrote:
> > > From: Chao Liu <liuchao@coolpad.com>
> > >
> > > If the inode has the compress flag, it will fail to use
> > > 'chattr -c +m' to remove its compress flag and tag no compress flag.
> > > However, the same command will be successful when executed again,
> > > as shown below:
> > >
> > >    $ touch foo.txt
> > >    $ chattr +c foo.txt
> > >    $ chattr -c +m foo.txt
> > >    chattr: Invalid argument while setting flags on foo.txt
> > >    $ chattr -c +m foo.txt
> > >    $ f2fs_io getflags foo.txt
> > >    get a flag on foo.txt ret=0, flags=nocompression,inline_data
> > >
> > > Fix this by removing some checks in f2fs_setflags_common()
> > > that do not affect the original logic. I go through all the
> > > possible scenarios, and the results are as follows. Bold is
> > > the only thing that has changed.
> > >
> > > +---------------+-----------+-----------+----------+
> > > |               |            file flags            |
> > > + command       +-----------+-----------+----------+
> > > |               | no flag   | compr     | nocompr  |
> > > +---------------+-----------+-----------+----------+
> > > | chattr +c     | compr     | compr     | -EINVAL  |
> > > | chattr -c     | no flag   | no flag   | nocompr  |
> > > | chattr +m     | nocompr   | -EINVAL   | nocompr  |
> > > | chattr -m     | no flag   | compr     | no flag  |
> > > | chattr +c +m  | -EINVAL   | -EINVAL   | -EINVAL  |
> > > | chattr +c -m  | compr     | compr     | compr    |
> > > | chattr -c +m  | nocompr   | *nocompr* | nocompr  |
> > > | chattr -c -m  | no flag   | no flag   | no flag  |
> > > +---------------+-----------+-----------+----------+
> > >
> > > Fixes: 4c8ff7095bef ("f2fs: support data compression")
> > > Signed-off-by: Chao Liu <liuchao@coolpad.com>
> > > ---
> > >
> > > This patch depends on the the patch
> > > "f2fs: allow compression of files without blocks" sent earlier this day.
> > >
> > >   fs/f2fs/file.c | 9 +--------
> > >   1 file changed, 1 insertion(+), 8 deletions(-)
> > >
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index daaa0dfd2d2e..0c3ae5993b7a 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -1873,10 +1873,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
> > >   		if (masked_flags & F2FS_COMPR_FL) {
> > >   			if (!f2fs_disable_compressed_file(inode))
> > >   				return -EINVAL;
> > > -		}
> > > -		if (iflags & F2FS_NOCOMP_FL)
> > > -			return -EINVAL;
> > > -		if (iflags & F2FS_COMPR_FL) {
> > > +		} else {
> > >   			if (!f2fs_may_compress(inode))
> > >   				return -EINVAL;
> > >   			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
> > > @@ -1885,10 +1882,6 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
> > >   			set_compress_context(inode);
> > >   		}
> > >   	}
> > > -	if ((iflags ^ masked_flags) & F2FS_NOCOMP_FL) {
> > > -		if (masked_flags & F2FS_COMPR_FL)
> > > -			return -EINVAL;
> > > -	}
> >
> > Without above check condition, can we return -EINVAL for the case:
> >
> > chattr +c on file w/ nocompr flag
> >
> > |               | no flag   | compr     | nocompr  |
> > +---------------+-----------+-----------+----------+
> > | chattr +c     | compr     | compr     | *-EINVAL*  |
>
> Yes, we can.
>
> chattr(1) grabs flags via GETFLAGS, modifies the result,
> and passes that to SETFLAGS. If we execute 'chattr +c'
> on the file with nocompr flag, the iflags will
> contain both compr and nocompr flags, then be refused by:
>
>     if ((iflags & F2FS_COMPR_FL) && (iflags & F2FS_NOCOMP_FL))
>         return -EINVAL;
>
> In addition, if iflags has only compr flag, while masked_flags
> has only nocompr flag for some reason
> (either because of concurrency of chattr(1) or by a user),
> I think we need remove nocompr flag and tag compr flag on the file,
> similar to the following.
>
> |               | no flag   | compr     | nocompr  |
> +---------------+-----------+-----------+----------+
> | chattr +c -m  | compr     | compr     | *compr*  |
>
> Thanks,
