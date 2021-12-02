Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69682465C86
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344982AbhLBDOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhLBDOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:14:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AABC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 19:10:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32A6AB82172
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D176C00446;
        Thu,  2 Dec 2021 03:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638414644;
        bh=6x02M+oNKOcHx0oToe06+vo2NwN8rWx6I9CTKjVOHxM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h2C575LQW6nb/vJouchWkl/9mndJyqNhKDfgMPA+1N+rxNgA5iKLLd7L7gpxiq3Vd
         LKVW77c+N0EZdXO7L61BjNpei4TcWVTmPSW4do4xL7IxTXBGLyJuox2heXpoL9wG7u
         /Po6wJF46Q9pezxz8kSbZfjdwVkywXex7BZ0xZMj+u/XF0TGGgQB72zKRsWoZvyBkg
         FL7Z+uwDqkc4go/SjLz8h2KkMC91Mbl/GeQ5DAMv3o14IwyVU20Mu9nkTitn7XGSG9
         rmELpggDuvFxIZkod1XDLmfYLfawVjNCbNiE9uBrfIG99E+IO+qSb9sfbA0r2QsZsS
         vZZHZBvQLpkbw==
Message-ID: <b36e2d44-4834-3931-6a32-4fa52d1d7785@kernel.org>
Date:   Thu, 2 Dec 2021 11:10:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [f2fs-dev] [PATCH 5/6] f2fs: implement iomap operations
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Eric Biggers <ebiggers@google.com>
References: <20211116214510.2934905-1-jaegeuk@kernel.org>
 <20211116214510.2934905-5-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211116214510.2934905-5-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/17 5:45, Jaegeuk Kim wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Implement 'struct iomap_ops' for f2fs, in preparation for making f2fs
> use iomap for direct I/O.
> 
> Note that this may be used for other things besides direct I/O in the
> future; however, for now I've only tested it for direct I/O.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/Kconfig |  1 +
>   fs/f2fs/data.c  | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
>   fs/f2fs/f2fs.h  |  1 +
>   3 files changed, 60 insertions(+)
> 
> diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
> index 7eea3cfd894d..f46a7339d6cf 100644
> --- a/fs/f2fs/Kconfig
> +++ b/fs/f2fs/Kconfig
> @@ -7,6 +7,7 @@ config F2FS_FS
>   	select CRYPTO_CRC32
>   	select F2FS_FS_XATTR if FS_ENCRYPTION
>   	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
> +	select FS_IOMAP
>   	select LZ4_COMPRESS if F2FS_FS_LZ4
>   	select LZ4_DECOMPRESS if F2FS_FS_LZ4
>   	select LZ4HC_COMPRESS if F2FS_FS_LZ4HC
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 7ac1a39fcad2..43b3ca7cabe0 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -21,6 +21,7 @@
>   #include <linux/cleancache.h>
>   #include <linux/sched/signal.h>
>   #include <linux/fiemap.h>
> +#include <linux/iomap.h>
>   
>   #include "f2fs.h"
>   #include "node.h"
> @@ -4236,3 +4237,60 @@ void f2fs_destroy_bio_entry_cache(void)
>   {
>   	kmem_cache_destroy(bio_entry_slab);
>   }
> +
> +static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +			    unsigned int flags, struct iomap *iomap,
> +			    struct iomap *srcmap)
> +{
> +	struct f2fs_map_blocks map = {};
> +	pgoff_t next_pgofs = 0;
> +	int err;
> +
> +	map.m_lblk = bytes_to_blks(inode, offset);
> +	map.m_len = bytes_to_blks(inode, offset + length - 1) - map.m_lblk + 1;
> +	map.m_next_pgofs = &next_pgofs;
> +	map.m_seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
> +	if (flags & IOMAP_WRITE)
> +		map.m_may_create = true;
> +
> +	err = f2fs_map_blocks(inode, &map, flags & IOMAP_WRITE,
> +			      F2FS_GET_BLOCK_DIO);
> +	if (err)
> +		return err;
> +
> +	iomap->offset = blks_to_bytes(inode, map.m_lblk);
> +
> +	if (map.m_flags & (F2FS_MAP_MAPPED | F2FS_MAP_UNWRITTEN)) {
> +		iomap->length = blks_to_bytes(inode, map.m_len);
> +		if (map.m_flags & F2FS_MAP_MAPPED) {
> +			iomap->type = IOMAP_MAPPED;
> +			iomap->flags |= IOMAP_F_MERGED;
> +		} else {
> +			iomap->type = IOMAP_UNWRITTEN;
> +		}
> +		if (WARN_ON_ONCE(!__is_valid_data_blkaddr(map.m_pblk)))
> +			return -EINVAL;
> +		iomap->addr = blks_to_bytes(inode, map.m_pblk);
> +
> +		if (WARN_ON_ONCE(f2fs_is_multi_device(F2FS_I_SB(inode))))
> +			return -EINVAL;

Why not relocating this check before f2fs_map_blocks()?

Thanks,

> +		iomap->bdev = inode->i_sb->s_bdev;
> +	} else {
> +		iomap->length = blks_to_bytes(inode, next_pgofs) -
> +				iomap->offset;
> +		iomap->type = IOMAP_HOLE;
> +		iomap->addr = IOMAP_NULL_ADDR;
> +	}
> +
> +	if (map.m_flags & F2FS_MAP_NEW)
> +		iomap->flags |= IOMAP_F_NEW;
> +	if ((inode->i_state & I_DIRTY_DATASYNC) ||
> +	    offset + length > i_size_read(inode))
> +		iomap->flags |= IOMAP_F_DIRTY;
> +
> +	return 0;
> +}
> +
> +const struct iomap_ops f2fs_iomap_ops = {
> +	.iomap_begin	= f2fs_iomap_begin,
> +};
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 14bea669f87e..0d199e8f2c1d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3654,6 +3654,7 @@ int f2fs_init_post_read_processing(void);
>   void f2fs_destroy_post_read_processing(void);
>   int f2fs_init_post_read_wq(struct f2fs_sb_info *sbi);
>   void f2fs_destroy_post_read_wq(struct f2fs_sb_info *sbi);
> +extern const struct iomap_ops f2fs_iomap_ops;
>   
>   /*
>    * gc.c
> 
