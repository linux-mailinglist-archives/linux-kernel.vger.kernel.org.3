Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DF0465D43
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355285AbhLBETn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344656AbhLBETb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:19:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF45C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 20:16:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E2653CE219A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 04:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69AEC00446;
        Thu,  2 Dec 2021 04:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638418561;
        bh=paG92azMggoOBcQsxOqm1iwPqph7TPj+xs+ewnCu9hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VhfGN0DA8vkLCSjgnVubJ8il1lysCmX3T1aix510+rfnb/QL6bkKzyEmJx364F2FJ
         n47727jgAietHcH1t4Xc48VLXmFlcxP4bZJQnDZlQ7EOsiz/2np4REvDMIzpoZf057
         p8j2Bs4gCxgqRwCn5Q5obWESYSeW04LKUFwrMa0wyFF2RJPHxUbDXHAPdMzjEEkIXU
         CrPAmUbARR4EvsvNWT53lGYlltRtKhZxdC8ErF1kKkAKTzhTi2A39MeMdn3ZATgBqp
         Uzi3XNFAViXGQFdw9prgpr0Sm63N8dtPuCrH5JKy9dzUlPzaOn6vOZ8ocrG7TxcZNk
         fRyQGfyOK6eEg==
Date:   Wed, 1 Dec 2021 20:15:59 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 5/6] f2fs: implement iomap operations
Message-ID: <YahIf3UlhuxJT1O4@sol.localdomain>
References: <20211116214510.2934905-1-jaegeuk@kernel.org>
 <20211116214510.2934905-5-jaegeuk@kernel.org>
 <b36e2d44-4834-3931-6a32-4fa52d1d7785@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b36e2d44-4834-3931-6a32-4fa52d1d7785@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 11:10:41AM +0800, Chao Yu wrote:
> > +static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > +			    unsigned int flags, struct iomap *iomap,
> > +			    struct iomap *srcmap)
> > +{
> > +	struct f2fs_map_blocks map = {};
> > +	pgoff_t next_pgofs = 0;
> > +	int err;
> > +
> > +	map.m_lblk = bytes_to_blks(inode, offset);
> > +	map.m_len = bytes_to_blks(inode, offset + length - 1) - map.m_lblk + 1;
> > +	map.m_next_pgofs = &next_pgofs;
> > +	map.m_seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
> > +	if (flags & IOMAP_WRITE)
> > +		map.m_may_create = true;
> > +
> > +	err = f2fs_map_blocks(inode, &map, flags & IOMAP_WRITE,
> > +			      F2FS_GET_BLOCK_DIO);
> > +	if (err)
> > +		return err;
> > +
> > +	iomap->offset = blks_to_bytes(inode, map.m_lblk);
> > +
> > +	if (map.m_flags & (F2FS_MAP_MAPPED | F2FS_MAP_UNWRITTEN)) {
> > +		iomap->length = blks_to_bytes(inode, map.m_len);
> > +		if (map.m_flags & F2FS_MAP_MAPPED) {
> > +			iomap->type = IOMAP_MAPPED;
> > +			iomap->flags |= IOMAP_F_MERGED;
> > +		} else {
> > +			iomap->type = IOMAP_UNWRITTEN;
> > +		}
> > +		if (WARN_ON_ONCE(!__is_valid_data_blkaddr(map.m_pblk)))
> > +			return -EINVAL;
> > +		iomap->addr = blks_to_bytes(inode, map.m_pblk);
> > +
> > +		if (WARN_ON_ONCE(f2fs_is_multi_device(F2FS_I_SB(inode))))
> > +			return -EINVAL;
> 
> Why not relocating this check before f2fs_map_blocks()?
> 
> Thanks,
> 
> > +		iomap->bdev = inode->i_sb->s_bdev;

Are you talking about the check for !f2fs_is_multi_device()?  It could go in
either location, but I think it makes the most sense to have it right before the
line that uses 'inode->i_sb->s_bdev', since that is the place which makes the
assumption that the filesystem has only one block device.

- Eric
