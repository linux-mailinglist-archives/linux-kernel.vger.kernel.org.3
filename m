Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E28466B95
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348912AbhLBVXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242942AbhLBVXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:23:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A235C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 13:19:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 295DB6282E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 21:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC8DC53FCD;
        Thu,  2 Dec 2021 21:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638479989;
        bh=U1g+cStoO0rqevxYYer5iTOqfPl9s10QknT3QGLAuPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VmRU1DGAQ529ISZd4lxOLmleIGmzmeB9II7sXSuzZ7BtI8F52SwYh1k5okUm5ocJl
         jFEW4V/rJELVgW/RD/CN7ySglqGJ4JvGApucOy5NX/Zcv0nREdcsCHqRvXCLv9vPNe
         +psBkwUa/mVt5UWIYPimK8H2E8DBfiEjJbr6vvxwZ9Xr9h88VimZjcXWvoQe9fJTyR
         ifkN80s56nd86ndNNVAONdAQ8u+o3hlC5NPv6iX4s27Yfq4V3Ut1TVSQolT4dxmepq
         XgAqj/O0w6UM9TdtKD61LzgSXP+AbQRFJmYwMbPZXy4m0crK/0Bf35i9sD8RpAL+zq
         y6bt9gXC0kCEQ==
Date:   Thu, 2 Dec 2021 13:19:47 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 5/6] f2fs: implement iomap operations
Message-ID: <Yak4cxU6htgQk7ck@google.com>
References: <20211116214510.2934905-1-jaegeuk@kernel.org>
 <20211116214510.2934905-5-jaegeuk@kernel.org>
 <b36e2d44-4834-3931-6a32-4fa52d1d7785@kernel.org>
 <YahIf3UlhuxJT1O4@sol.localdomain>
 <1ba0f002-42c7-b085-0c54-6071664ba79b@kernel.org>
 <YakPrVPz5+qQm3kQ@sol.localdomain>
 <YakXMV0UvBV7TVwe@google.com>
 <YakX38onzsW5Ef8B@google.com>
 <YakzVAkHAVMueJwe@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YakzVAkHAVMueJwe@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02, Eric Biggers wrote:
> On Thu, Dec 02, 2021 at 11:00:47AM -0800, Jaegeuk Kim wrote:
> > On 12/02, Jaegeuk Kim wrote:
> > > On 12/02, Eric Biggers wrote:
> > > > On Thu, Dec 02, 2021 at 10:04:11PM +0800, Chao Yu wrote:
> > > > > On 2021/12/2 12:15, Eric Biggers wrote:
> > > > > > On Thu, Dec 02, 2021 at 11:10:41AM +0800, Chao Yu wrote:
> > > > > > > Why not relocating this check before f2fs_map_blocks()?
> > > > > 
> > > > > Wait, it supports DIO in multi-device image after commit 	71f2c8206202
> > > > > ("f2fs: multidevice: support direct IO"), how about
> > > > > checking with f2fs_allow_multi_device_dio()?
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > 
> > > > Okay, that was not the case when I sent this patch originally.  We'll need to
> > > > update this to support multiple devices.
> > > 
> > > Chao/Eric, does this make sense?
> > > 
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -4070,11 +4070,10 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > >                 }
> > >                 if (WARN_ON_ONCE(!__is_valid_data_blkaddr(map.m_pblk)))
> > >                         return -EINVAL;
> > > -               iomap->addr = blks_to_bytes(inode, map.m_pblk);
> > > 
> > > -               if (WARN_ON_ONCE(f2fs_is_multi_device(F2FS_I_SB(inode))))
> > > -                       return -EINVAL;
> > > -               iomap->bdev = inode->i_sb->s_bdev;
> > > +               iomap->bdev = map->m_multidev_dio ? map.m_bdev :
> > 
> > correction:			map.m_multidev_dio
> > 
> 
> I guess so, but why doesn't f2fs_map_blocks() just always set m_bdev to the
> correct block device?  What is the point of m_multidev_dio?

It seems we can simply assign iomap->bdev = map.m_bdev, and remove
map->m_multidev_dio.

> 
> - Eric
