Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A55748193D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 05:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhL3ENz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 23:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbhL3ENy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 23:13:54 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D1CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 20:13:53 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id l16so5295019plg.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 20:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YiqhfVRIwQ4gWbIHN8vMHwMrf7y2KmZNSv9vrM9T++g=;
        b=WN3p17OjbM2NfyZU9v4AjWOyMn1FMzCuMQaMgzQ6P1Igwqg3i7uQJxtxs5e7fjutKY
         wN9avueCZXWmuuiA1tZdfXq4D2dkVdBHhbOgr6rGpCrdVRFc81obMdjS0IN7t646Cpag
         OSZOu+yxMSMyS08VWsVpGtzRlSMY/zpJy86l4y/JDOIAYLE8J7ty6e7sTGoc81SnxO5u
         8aH9NZlklTaEYgZY1zWEBhXu0NL9rYezJmTZjY7ObVkydzu3DW9/hG6ih9FRvHNCNO/+
         IooJZigWq0kEVCb3AHymQNb0FJtQ4imBZ/Bt99vK7Q7w/jFG9MtMGb+UqpwK53felOVY
         74GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YiqhfVRIwQ4gWbIHN8vMHwMrf7y2KmZNSv9vrM9T++g=;
        b=4IK5IyVMLCvB+vdHweDQdgs2YNSlOfk/3RgyjesOz4loNqoRhVjctQO+ODlMPblm5J
         9F++fCek07K5JL4x2f6Qqecf/YO54uub9tMoOSA4Zu5ehVm2gi6WI9NV6BNx5QdIrRr5
         8rsA5BhkQpbXnuVeYqtGT3STIyCeU/+/N4TZtpkznJ8vkyqTCvQFM20I/kr1Dr9i3WfD
         +Sf8we85fbKGvkAtv+SA1Bgk6QUky86Nq4hwoMklMqxHMCg/xSd2WVyTva5DKFbGGE0k
         uhq8lAEsPDLl4kFietLSEnKbPM8/BtXT2y4TS+gje0M0rbutlfmbtK1HyVkxuAK9zaLu
         zLHg==
X-Gm-Message-State: AOAM531sEiCKMRctmPtdTQ/6XhhJiHyp/3yqKbsGzTXeFfBpkudsX0EH
        YVzFlRbIE2aAILSQ7Rion08qn51ij1s=
X-Google-Smtp-Source: ABdhPJx4K3Hx7QB9muUJ0ZknYj5jRJv7wUGwX+gWy6bsRmsxu/+hEfH0wOhBmHJw4oy7F0ETGXEPbg==
X-Received: by 2002:a17:902:7442:b0:149:6a62:f7b3 with SMTP id e2-20020a170902744200b001496a62f7b3mr22631732plt.88.1640837633157;
        Wed, 29 Dec 2021 20:13:53 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id g5sm27062425pfj.143.2021.12.29.20.13.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Dec 2021 20:13:53 -0800 (PST)
Date:   Thu, 30 Dec 2021 12:11:09 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, huyue@coolpad.com,
        geshifei@coolpad.com, zhangwen@coolpad.com, shaojunjun@coolpad.com
Subject: Re: [PATCH 3/5] erofs: use meta buffers for super operations
Message-ID: <20211230121109.00000328.zbestahu@gmail.com>
In-Reply-To: <20211229041405.45921-4-hsiangkao@linux.alibaba.com>
References: <20211229041405.45921-1-hsiangkao@linux.alibaba.com>
        <20211229041405.45921-4-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2021 12:14:03 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Get rid of old erofs_get_meta_page() within super operations by
> using on-stack meta buffers in order to prepare subpage and folio
> features.
> 
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

Reviewed-by: Yue Hu <huyue2@yulong.com>
