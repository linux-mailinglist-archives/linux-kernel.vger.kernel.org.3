Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F243466B46
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 21:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349049AbhLBVBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:01:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57282 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbhLBVBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:01:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F893B82496
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 20:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C87C00446;
        Thu,  2 Dec 2021 20:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638478678;
        bh=Vz6b7cV6W7mHrkub6Y7jYpgSpo5eJxuDHXnlPbz4LNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fXPOryibPB4GoekQqhs51X824Hb23aNOfD7mGBKqe6Hu6RzWw5T071AObNQ17Hy1n
         As73CwWovUvU0+tWTRCPqpC6ePAJ8F8bXqjo/SKNrWyGy1F8dz8Sz2NJ81+Zh/Agbo
         +Tij6tayDHR4WR7xDf2VIWcfLVSwhbnP+NWrqTZEtS1Xi1GBURQTTwZw7vr1UsUH5+
         b3AtyA8aQJO3EJk4WLq/cIoPOz5J8RLmnroaw2NcaygK5YD+chrkCraQBDqn0Kus+/
         gy8snUZjtbMkXV2ABwdI7JTDxRsAcYDD2np7CNuRwO+CL6HQDuD/wwbQuQCsK5hWLY
         2JlgQdbVXtpqg==
Date:   Thu, 2 Dec 2021 12:57:56 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 5/6] f2fs: implement iomap operations
Message-ID: <YakzVAkHAVMueJwe@sol.localdomain>
References: <20211116214510.2934905-1-jaegeuk@kernel.org>
 <20211116214510.2934905-5-jaegeuk@kernel.org>
 <b36e2d44-4834-3931-6a32-4fa52d1d7785@kernel.org>
 <YahIf3UlhuxJT1O4@sol.localdomain>
 <1ba0f002-42c7-b085-0c54-6071664ba79b@kernel.org>
 <YakPrVPz5+qQm3kQ@sol.localdomain>
 <YakXMV0UvBV7TVwe@google.com>
 <YakX38onzsW5Ef8B@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YakX38onzsW5Ef8B@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 11:00:47AM -0800, Jaegeuk Kim wrote:
> On 12/02, Jaegeuk Kim wrote:
> > On 12/02, Eric Biggers wrote:
> > > On Thu, Dec 02, 2021 at 10:04:11PM +0800, Chao Yu wrote:
> > > > On 2021/12/2 12:15, Eric Biggers wrote:
> > > > > On Thu, Dec 02, 2021 at 11:10:41AM +0800, Chao Yu wrote:
> > > > > > Why not relocating this check before f2fs_map_blocks()?
> > > > 
> > > > Wait, it supports DIO in multi-device image after commit 	71f2c8206202
> > > > ("f2fs: multidevice: support direct IO"), how about
> > > > checking with f2fs_allow_multi_device_dio()?
> > > > 
> > > > Thanks,
> > > > 
> > > 
> > > Okay, that was not the case when I sent this patch originally.  We'll need to
> > > update this to support multiple devices.
> > 
> > Chao/Eric, does this make sense?
> > 
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -4070,11 +4070,10 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >                 }
> >                 if (WARN_ON_ONCE(!__is_valid_data_blkaddr(map.m_pblk)))
> >                         return -EINVAL;
> > -               iomap->addr = blks_to_bytes(inode, map.m_pblk);
> > 
> > -               if (WARN_ON_ONCE(f2fs_is_multi_device(F2FS_I_SB(inode))))
> > -                       return -EINVAL;
> > -               iomap->bdev = inode->i_sb->s_bdev;
> > +               iomap->bdev = map->m_multidev_dio ? map.m_bdev :
> 
> correction:			map.m_multidev_dio
> 

I guess so, but why doesn't f2fs_map_blocks() just always set m_bdev to the
correct block device?  What is the point of m_multidev_dio?

- Eric
