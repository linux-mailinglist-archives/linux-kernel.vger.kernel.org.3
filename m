Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD64466A18
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348341AbhLBTBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:01:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58718 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbhLBTBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:01:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC1B1627CA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 18:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACCBC00446;
        Thu,  2 Dec 2021 18:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638471475;
        bh=AKoMZEWUw2l+NUyq4IhxAlP69xn5eiC9se60LnLgJcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KSnJ3FH3EelCO3S1mA6tODmxN6Rs7Cp89RUaLKCKoYYgosZ1A07oyPZPUEpNPKcEf
         HIf4SNC4AtmHOgKeNfCaqyh7x4YCHpT8b6oDECpeeRWYC30yBckPL1hUb1wqxnavsC
         ki6qJCG1oNkwonu0dKRrt4PVSfpT7vuiPcq71KuBsVWGnbbs4+TAZe1khz7htjvF9C
         Y4bmpf+hXnT85U4JeHyRkYsMfUCjmhLVw3GpF0PYjGUNAU5Dh8kjdl9cPvldgE7k0k
         yA+jey/41Ajms7pBimsBP02xprVbAaeVm9PIWn3Oey0lz1wOza3uv09JKDdsLn1sEl
         zwHdBkStMiXfQ==
Date:   Thu, 2 Dec 2021 10:57:53 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 5/6] f2fs: implement iomap operations
Message-ID: <YakXMV0UvBV7TVwe@google.com>
References: <20211116214510.2934905-1-jaegeuk@kernel.org>
 <20211116214510.2934905-5-jaegeuk@kernel.org>
 <b36e2d44-4834-3931-6a32-4fa52d1d7785@kernel.org>
 <YahIf3UlhuxJT1O4@sol.localdomain>
 <1ba0f002-42c7-b085-0c54-6071664ba79b@kernel.org>
 <YakPrVPz5+qQm3kQ@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YakPrVPz5+qQm3kQ@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02, Eric Biggers wrote:
> On Thu, Dec 02, 2021 at 10:04:11PM +0800, Chao Yu wrote:
> > On 2021/12/2 12:15, Eric Biggers wrote:
> > > On Thu, Dec 02, 2021 at 11:10:41AM +0800, Chao Yu wrote:
> > > > Why not relocating this check before f2fs_map_blocks()?
> > 
> > Wait, it supports DIO in multi-device image after commit 	71f2c8206202
> > ("f2fs: multidevice: support direct IO"), how about
> > checking with f2fs_allow_multi_device_dio()?
> > 
> > Thanks,
> > 
> 
> Okay, that was not the case when I sent this patch originally.  We'll need to
> update this to support multiple devices.

Chao/Eric, does this make sense?

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4070,11 +4070,10 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
                }
                if (WARN_ON_ONCE(!__is_valid_data_blkaddr(map.m_pblk)))
                        return -EINVAL;
-               iomap->addr = blks_to_bytes(inode, map.m_pblk);

-               if (WARN_ON_ONCE(f2fs_is_multi_device(F2FS_I_SB(inode))))
-                       return -EINVAL;
-               iomap->bdev = inode->i_sb->s_bdev;
+               iomap->bdev = map->m_multidev_dio ? map.m_bdev :
+                                               inode->i_sb->s_bdev;
+               iomap->addr = blks_to_bytes(inode, map.m_pblk);
        } else {
                iomap->length = blks_to_bytes(inode, next_pgofs) -
                                iomap->offset;

> 
> - Eric
