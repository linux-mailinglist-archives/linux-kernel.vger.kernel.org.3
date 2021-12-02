Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879C0466A1B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348429AbhLBTEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbhLBTEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:04:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1CFC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 11:00:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1888FB8245D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 19:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0AAC00446;
        Thu,  2 Dec 2021 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638471648;
        bh=uFwJzTD6B0n40MqyShmUzKM0VAHNm6R1wMiDLKIANZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lXvVCg6aviSxbCByQiYa5/vBfMZrIAmU88pUAqgemQ/8p1+eJOIIeQ8Jcs+q7AHDA
         rDKYV2PXg4mo2BpzLLVpFZBUjz1sHemOaTdEzip2Vu0cP5JA04Av8D52J0zRIH+nVJ
         b4u2e0ZaGS6aYX7W6QDR/cAs9x5L3tYmfdMrl7j0XUBmwHN82NiTpwJztZTnjZ6QbB
         yHpk5WFJma4DWQkTSJCHXU4tqTsLukwQeijuFLpXne3fkLJMQTvel2GcMe/r150pQE
         wGlbZNU0d+GqgN6xjdyGlQahfKD7wzukRHcD2r4EjIn1eDg1Na+jeesV1gi+XavYkr
         JWSxmvSHFn+Kg==
Date:   Thu, 2 Dec 2021 11:00:47 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 5/6] f2fs: implement iomap operations
Message-ID: <YakX38onzsW5Ef8B@google.com>
References: <20211116214510.2934905-1-jaegeuk@kernel.org>
 <20211116214510.2934905-5-jaegeuk@kernel.org>
 <b36e2d44-4834-3931-6a32-4fa52d1d7785@kernel.org>
 <YahIf3UlhuxJT1O4@sol.localdomain>
 <1ba0f002-42c7-b085-0c54-6071664ba79b@kernel.org>
 <YakPrVPz5+qQm3kQ@sol.localdomain>
 <YakXMV0UvBV7TVwe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YakXMV0UvBV7TVwe@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02, Jaegeuk Kim wrote:
> On 12/02, Eric Biggers wrote:
> > On Thu, Dec 02, 2021 at 10:04:11PM +0800, Chao Yu wrote:
> > > On 2021/12/2 12:15, Eric Biggers wrote:
> > > > On Thu, Dec 02, 2021 at 11:10:41AM +0800, Chao Yu wrote:
> > > > > Why not relocating this check before f2fs_map_blocks()?
> > > 
> > > Wait, it supports DIO in multi-device image after commit 	71f2c8206202
> > > ("f2fs: multidevice: support direct IO"), how about
> > > checking with f2fs_allow_multi_device_dio()?
> > > 
> > > Thanks,
> > > 
> > 
> > Okay, that was not the case when I sent this patch originally.  We'll need to
> > update this to support multiple devices.
> 
> Chao/Eric, does this make sense?
> 
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -4070,11 +4070,10 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>                 }
>                 if (WARN_ON_ONCE(!__is_valid_data_blkaddr(map.m_pblk)))
>                         return -EINVAL;
> -               iomap->addr = blks_to_bytes(inode, map.m_pblk);
> 
> -               if (WARN_ON_ONCE(f2fs_is_multi_device(F2FS_I_SB(inode))))
> -                       return -EINVAL;
> -               iomap->bdev = inode->i_sb->s_bdev;
> +               iomap->bdev = map->m_multidev_dio ? map.m_bdev :

correction:			map.m_multidev_dio

> +                                               inode->i_sb->s_bdev;
> +               iomap->addr = blks_to_bytes(inode, map.m_pblk);
>         } else {
>                 iomap->length = blks_to_bytes(inode, next_pgofs) -
>                                 iomap->offset;
> 
> > 
> > - Eric
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
