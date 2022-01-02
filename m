Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3396E482A7E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 08:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiABHXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 02:23:39 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:44845 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbiABHXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 02:23:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V0YVkFK_1641108201;
Received: from rsjd01523.et2sqa(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0V0YVkFK_1641108201)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Jan 2022 15:23:26 +0800
Date:   Sun, 2 Jan 2022 15:23:21 +0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@yulong.com>
Subject: Re: [PATCH v2 3/5] erofs: use meta buffers for super operations
Message-ID: <20220102072314.GA40650@rsjd01523.et2sqa>
Reply-To: bo.liu@linux.alibaba.com
References: <20220102040017.51352-1-hsiangkao@linux.alibaba.com>
 <20220102040017.51352-4-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102040017.51352-4-hsiangkao@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 12:00:15PM +0800, Gao Xiang wrote:
> Get rid of old erofs_get_meta_page() within super operations by
> using on-stack meta buffers in order to prepare subpage and folio
> features.
> 
> Reviewed-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/super.c | 105 ++++++++++++-----------------------------------
>  1 file changed, 26 insertions(+), 79 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0724ad5fd6cf..38305fa2969b 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (C) 2017-2018 HUAWEI, Inc.
>   *             https://www.huawei.com/
> + * Copyright (C) 2021, Alibaba Cloud
>   */
>  #include <linux/module.h>
>  #include <linux/buffer_head.h>
> @@ -124,80 +125,48 @@ static bool check_layout_compatibility(struct super_block *sb,
>  
>  #ifdef CONFIG_EROFS_FS_ZIP
>  /* read variable-sized metadata, offset will be aligned by 4-byte */
> -static void *erofs_read_metadata(struct super_block *sb, struct page **pagep,
> +static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
>  				 erofs_off_t *offset, int *lengthp)
>  {
> -	struct page *page = *pagep;
>  	u8 *buffer, *ptr;
>  	int len, i, cnt;
> -	erofs_blk_t blk;
>  
>  	*offset = round_up(*offset, 4);
> -	blk = erofs_blknr(*offset);
> +	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset), EROFS_KMAP);
> +	if (IS_ERR(ptr))
> +		return ptr;
>  
> -	if (!page || page->index != blk) {
> -		if (page) {
> -			unlock_page(page);
> -			put_page(page);
> -		}
> -		page = erofs_get_meta_page(sb, blk);
> -		if (IS_ERR(page))
> -			goto err_nullpage;
> -	}
> -
> -	ptr = kmap(page);
>  	len = le16_to_cpu(*(__le16 *)&ptr[erofs_blkoff(*offset)]);
>  	if (!len)
>  		len = U16_MAX + 1;
>  	buffer = kmalloc(len, GFP_KERNEL);
> -	if (!buffer) {
> -		buffer = ERR_PTR(-ENOMEM);
> -		goto out;
> -	}
> +	if (!buffer)
> +		return ERR_PTR(-ENOMEM);
>  	*offset += sizeof(__le16);
>  	*lengthp = len;
>  
>  	for (i = 0; i < len; i += cnt) {
>  		cnt = min(EROFS_BLKSIZ - (int)erofs_blkoff(*offset), len - i);
> -		blk = erofs_blknr(*offset);
> -
> -		if (!page || page->index != blk) {
> -			if (page) {
> -				kunmap(page);
> -				unlock_page(page);
> -				put_page(page);
> -			}
> -			page = erofs_get_meta_page(sb, blk);
> -			if (IS_ERR(page)) {
> -				kfree(buffer);
> -				goto err_nullpage;
> -			}
> -			ptr = kmap(page);
> -		}
> +		ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset),
> +					 EROFS_KMAP);
> +		if (IS_ERR(ptr))

kfree(buffer) is missing.

> +			return ptr;
>  		memcpy(buffer + i, ptr + erofs_blkoff(*offset), cnt);
>  		*offset += cnt;
>  	}
> -out:
> -	kunmap(page);
> -	*pagep = page;
>  	return buffer;
> -err_nullpage:
> -	*pagep = NULL;
> -	return page;
>  }
>  
>  static int erofs_load_compr_cfgs(struct super_block *sb,
>  				 struct erofs_super_block *dsb)
>  {
> -	struct erofs_sb_info *sbi;
> -	struct page *page;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>  	unsigned int algs, alg;
>  	erofs_off_t offset;
> -	int size, ret;
> +	int size, ret = 0;
>  
> -	sbi = EROFS_SB(sb);
>  	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
> -
>  	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
>  		erofs_err(sb, "try to load compressed fs with unsupported algorithms %x",
>  			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
> @@ -205,21 +174,16 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
>  	}
>  
>  	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
> -	page = NULL;
>  	alg = 0;
> -	ret = 0;
> -
>  	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
>  		void *data;
>  
>  		if (!(algs & 1))
>  			continue;
>  
> -		data = erofs_read_metadata(sb, &page, &offset, &size);
> -		if (IS_ERR(data)) {
> -			ret = PTR_ERR(data);
> -			goto err;
> -		}
> +		data = erofs_read_metadata(sb, &buf, &offset, &size);

if PTR_ERR(data) is -ENOMEM, buf needs to be put according to the
current design.

> +		if (IS_ERR(data))
> +			return PTR_ERR(data);
>  
>  		switch (alg) {
>  		case Z_EROFS_COMPRESSION_LZ4:
> @@ -234,13 +198,9 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
>  		}
>  		kfree(data);
>  		if (ret)
> -			goto err;
> -	}
> -err:
> -	if (page) {
> -		unlock_page(page);
> -		put_page(page);
> +			break;
>  	}
> +	erofs_put_metabuf(&buf);
>  	return ret;
>  }
>  #else
> @@ -261,7 +221,7 @@ static int erofs_init_devices(struct super_block *sb,
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  	unsigned int ondisk_extradevs;
>  	erofs_off_t pos;
> -	struct page *page = NULL;
> +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>  	struct erofs_device_info *dif;
>  	struct erofs_deviceslot *dis;
>  	void *ptr;
> @@ -285,22 +245,13 @@ static int erofs_init_devices(struct super_block *sb,
>  	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
>  	down_read(&sbi->devs->rwsem);
>  	idr_for_each_entry(&sbi->devs->tree, dif, id) {
> -		erofs_blk_t blk = erofs_blknr(pos);
>  		struct block_device *bdev;
>  
> -		if (!page || page->index != blk) {
> -			if (page) {
> -				kunmap(page);
> -				unlock_page(page);
> -				put_page(page);
> -			}
> -
> -			page = erofs_get_meta_page(sb, blk);
> -			if (IS_ERR(page)) {
> -				up_read(&sbi->devs->rwsem);
> -				return PTR_ERR(page);
> -			}
> -			ptr = kmap(page);
> +		ptr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
> +					 EROFS_KMAP);
> +		if (IS_ERR(ptr)) {

Ditto.

Thanks,
liubo

> +			up_read(&sbi->devs->rwsem);
> +			return PTR_ERR(ptr);
>  		}
>  		dis = ptr + erofs_blkoff(pos);
>  
> @@ -320,11 +271,7 @@ static int erofs_init_devices(struct super_block *sb,
>  	}
>  err_out:
>  	up_read(&sbi->devs->rwsem);
> -	if (page) {
> -		kunmap(page);
> -		unlock_page(page);
> -		put_page(page);
> -	}
> +	erofs_put_metabuf(&buf);
>  	return err;
>  }
>  
> -- 
> 2.24.4
