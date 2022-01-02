Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A74482A94
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 09:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiABIGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 03:06:14 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:47824 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230090AbiABIGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 03:06:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V0Yxpe4_1641110770;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V0Yxpe4_1641110770)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Jan 2022 16:06:12 +0800
Date:   Sun, 2 Jan 2022 16:06:10 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Liu Bo <bo.liu@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@yulong.com>
Subject: Re: [PATCH v2 3/5] erofs: use meta buffers for super operations
Message-ID: <YdFc8jIquSIAG56L@B-P7TQMD6M-0146.local>
References: <20220102040017.51352-1-hsiangkao@linux.alibaba.com>
 <20220102040017.51352-4-hsiangkao@linux.alibaba.com>
 <20220102072314.GA40650@rsjd01523.et2sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220102072314.GA40650@rsjd01523.et2sqa>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bo,

On Sun, Jan 02, 2022 at 03:23:21PM +0800, Liu Bo wrote:
> On Sun, Jan 02, 2022 at 12:00:15PM +0800, Gao Xiang wrote:

...

> > -			ptr = kmap(page);
> > -		}
> > +		ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset),
> > +					 EROFS_KMAP);
> > +		if (IS_ERR(ptr))
> 
> kfree(buffer) is missing.
> 
> > +			return ptr;
> >  		memcpy(buffer + i, ptr + erofs_blkoff(*offset), cnt);
> >  		*offset += cnt;
> >  	}
> > -out:
> > -	kunmap(page);
> > -	*pagep = page;
> >  	return buffer;
> > -err_nullpage:
> > -	*pagep = NULL;
> > -	return page;
> >  }
> >  
> >  static int erofs_load_compr_cfgs(struct super_block *sb,
> >  				 struct erofs_super_block *dsb)
> >  {
> > -	struct erofs_sb_info *sbi;
> > -	struct page *page;
> > +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> > +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> >  	unsigned int algs, alg;
> >  	erofs_off_t offset;
> > -	int size, ret;
> > +	int size, ret = 0;
> >  
> > -	sbi = EROFS_SB(sb);
> >  	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
> > -
> >  	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
> >  		erofs_err(sb, "try to load compressed fs with unsupported algorithms %x",
> >  			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
> > @@ -205,21 +174,16 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
> >  	}
> >  
> >  	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
> > -	page = NULL;
> >  	alg = 0;
> > -	ret = 0;
> > -
> >  	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
> >  		void *data;
> >  
> >  		if (!(algs & 1))
> >  			continue;
> >  
> > -		data = erofs_read_metadata(sb, &page, &offset, &size);
> > -		if (IS_ERR(data)) {
> > -			ret = PTR_ERR(data);
> > -			goto err;
> > -		}
> > +		data = erofs_read_metadata(sb, &buf, &offset, &size);
> 
> if PTR_ERR(data) is -ENOMEM, buf needs to be put according to the
> current design.
> 
> > +		if (IS_ERR(data))
> > +			return PTR_ERR(data);
> >  
> >  		switch (alg) {
> >  		case Z_EROFS_COMPRESSION_LZ4:
> > @@ -234,13 +198,9 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
> >  		}
> >  		kfree(data);
> >  		if (ret)
> > -			goto err;
> > -	}
> > -err:
> > -	if (page) {
> > -		unlock_page(page);
> > -		put_page(page);
> > +			break;
> >  	}
> > +	erofs_put_metabuf(&buf);
> >  	return ret;
> >  }
> >  #else
> > @@ -261,7 +221,7 @@ static int erofs_init_devices(struct super_block *sb,
> >  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> >  	unsigned int ondisk_extradevs;
> >  	erofs_off_t pos;
> > -	struct page *page = NULL;
> > +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> >  	struct erofs_device_info *dif;
> >  	struct erofs_deviceslot *dis;
> >  	void *ptr;
> > @@ -285,22 +245,13 @@ static int erofs_init_devices(struct super_block *sb,
> >  	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
> >  	down_read(&sbi->devs->rwsem);
> >  	idr_for_each_entry(&sbi->devs->tree, dif, id) {
> > -		erofs_blk_t blk = erofs_blknr(pos);
> >  		struct block_device *bdev;
> >  
> > -		if (!page || page->index != blk) {
> > -			if (page) {
> > -				kunmap(page);
> > -				unlock_page(page);
> > -				put_page(page);
> > -			}
> > -
> > -			page = erofs_get_meta_page(sb, blk);
> > -			if (IS_ERR(page)) {
> > -				up_read(&sbi->devs->rwsem);
> > -				return PTR_ERR(page);
> > -			}
> > -			ptr = kmap(page);
> > +		ptr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
> > +					 EROFS_KMAP);
> > +		if (IS_ERR(ptr)) {
> 
> Ditto.
> 

Thanks for catching these! I've fixed these as follows,
please help check out again!

Thanks,
Gao Xiang

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 38305fa2969b..9e076303bb24 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -149,8 +149,10 @@ static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 		cnt = min(EROFS_BLKSIZ - (int)erofs_blkoff(*offset), len - i);
 		ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset),
 					 EROFS_KMAP);
-		if (IS_ERR(ptr))
+		if (IS_ERR(ptr)) {
+			kfree(buffer);
 			return ptr;
+		}
 		memcpy(buffer + i, ptr + erofs_blkoff(*offset), cnt);
 		*offset += cnt;
 	}
@@ -182,8 +184,10 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
 			continue;
 
 		data = erofs_read_metadata(sb, &buf, &offset, &size);
-		if (IS_ERR(data))
-			return PTR_ERR(data);
+		if (IS_ERR(data)) {
+			ret = PTR_ERR(data);
+			break;
+		}
 
 		switch (alg) {
 		case Z_EROFS_COMPRESSION_LZ4:
@@ -250,8 +254,8 @@ static int erofs_init_devices(struct super_block *sb,
 		ptr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
 					 EROFS_KMAP);
 		if (IS_ERR(ptr)) {
-			up_read(&sbi->devs->rwsem);
-			return PTR_ERR(ptr);
+			err = PTR_ERR(ptr);
+			break;
 		}
 		dis = ptr + erofs_blkoff(pos);
 
@@ -260,7 +264,7 @@ static int erofs_init_devices(struct super_block *sb,
 					  sb->s_type);
 		if (IS_ERR(bdev)) {
 			err = PTR_ERR(bdev);
-			goto err_out;
+			break;
 		}
 		dif->bdev = bdev;
 		dif->dax_dev = fs_dax_get_by_bdev(bdev);
