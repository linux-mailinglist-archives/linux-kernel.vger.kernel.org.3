Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37CE4849BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiADVPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:15:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60688 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiADVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:15:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56B64B817F6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 21:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86CEC36AEB;
        Tue,  4 Jan 2022 21:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641330911;
        bh=aGwL1KfIyrbAmcd342EY4+l8L/kbbRvuvCn21vJF5Xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhJpT4pWc2lq1KVuyf1JbpIH1IdewsJ55pRrICra7G69/ucvcTFRcdSkyVPrUVtTE
         jeBG22FtZ8tbuUz6il0e9qM7SnGrK/gMnmbvmpTfkrg6xsxh718jRORTd7YxOTQ/OU
         snskQpQcuAYp2rLGmHwl2a7R4Pi8sNWv5tQ1AjNjsoAg2XBxUudZnOaDMTdT69KUvK
         RuGMEA4oMKouMcPS1wNef6w5zFqX33MQdp+aGCIeoCVrqcrI6HMo9smwK73zBqYeR8
         6aRN6KBFuCRVz8K6l1IIdbCP6ZDTJbWzpfb0yXeeS2OUJilAQNNpCdcYkzpa66Rj1u
         XPT7zkHtwIeAg==
Date:   Tue, 4 Jan 2022 13:15:09 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 5/6] f2fs: implement iomap operations
Message-ID: <YdS43f15g1enklVX@google.com>
References: <b36e2d44-4834-3931-6a32-4fa52d1d7785@kernel.org>
 <YahIf3UlhuxJT1O4@sol.localdomain>
 <1ba0f002-42c7-b085-0c54-6071664ba79b@kernel.org>
 <YakPrVPz5+qQm3kQ@sol.localdomain>
 <YakXMV0UvBV7TVwe@google.com>
 <YakX38onzsW5Ef8B@google.com>
 <YakzVAkHAVMueJwe@sol.localdomain>
 <Yak4cxU6htgQk7ck@google.com>
 <Yak6gtXthBRK3eeM@google.com>
 <ed10bb7a-af8c-d5a6-8bb1-a47559f78fbf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed10bb7a-af8c-d5a6-8bb1-a47559f78fbf@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30, Chao Yu wrote:
> On 2021/12/3 5:28, Jaegeuk Kim wrote:
> > On 12/02, Jaegeuk Kim wrote:
> > > On 12/02, Eric Biggers wrote:
> > > > On Thu, Dec 02, 2021 at 11:00:47AM -0800, Jaegeuk Kim wrote:
> > > > > On 12/02, Jaegeuk Kim wrote:
> > > > > > On 12/02, Eric Biggers wrote:
> > > > > > > On Thu, Dec 02, 2021 at 10:04:11PM +0800, Chao Yu wrote:
> > > > > > > > On 2021/12/2 12:15, Eric Biggers wrote:
> > > > > > > > > On Thu, Dec 02, 2021 at 11:10:41AM +0800, Chao Yu wrote:
> > > > > > > > > > Why not relocating this check before f2fs_map_blocks()?
> > > > > > > > 
> > > > > > > > Wait, it supports DIO in multi-device image after commit 	71f2c8206202
> > > > > > > > ("f2fs: multidevice: support direct IO"), how about
> > > > > > > > checking with f2fs_allow_multi_device_dio()?
> > > > > > > > 
> > > > > > > > Thanks,
> > > > > > > > 
> > > > > > > 
> > > > > > > Okay, that was not the case when I sent this patch originally.  We'll need to
> > > > > > > update this to support multiple devices.
> > > > > > 
> > > > > > Chao/Eric, does this make sense?
> > > > > > 
> > > > > > --- a/fs/f2fs/data.c
> > > > > > +++ b/fs/f2fs/data.c
> > > > > > @@ -4070,11 +4070,10 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > > > > >                  }
> > > > > >                  if (WARN_ON_ONCE(!__is_valid_data_blkaddr(map.m_pblk)))
> > > > > >                          return -EINVAL;
> > > > > > -               iomap->addr = blks_to_bytes(inode, map.m_pblk);
> > > > > > 
> > > > > > -               if (WARN_ON_ONCE(f2fs_is_multi_device(F2FS_I_SB(inode))))
> > > > > > -                       return -EINVAL;
> > > > > > -               iomap->bdev = inode->i_sb->s_bdev;
> > > > > > +               iomap->bdev = map->m_multidev_dio ? map.m_bdev :
> > > > > 
> > > > > correction:			map.m_multidev_dio
> > > > > 
> > > > 
> > > > I guess so, but why doesn't f2fs_map_blocks() just always set m_bdev to the
> > > > correct block device?  What is the point of m_multidev_dio?
> > > 
> > > It seems we can simply assign iomap->bdev = map.m_bdev, and remove
> > > map->m_multidev_dio.
> > 
> > Ok, it was used in previous get_block flow, but I think it'd be worth to keep it
> > to show by f2fs_map_blocks tracepoint.
> 
> The last version wasn't sent into mailing list?

No, will post it again soon.

> 
> Thanks,
> 
> > 
> > > 
> > > > 
> > > > - Eric
> > > 
> > > 
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
