Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03D5481939
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 05:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhL3EIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 23:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbhL3EIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 23:08:43 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC73C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 20:08:42 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 2so20356211pgb.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 20:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PnblsQTouamLaaYF+i5YwC/rFlgROnk+BZ7Hd2kYjpI=;
        b=nCxmfo98okK1sBj/x7kqPPvxAkp2UQW/AK8R1mLlmxBzVWDkcd+YX2Sx0nO4CWFt/a
         ThTzCKhxvnUwntrmD5QpscxsCxiaxuQO3zL61qle9Eh5ZLvliasEAsD3woPsimaCS4YB
         ++eRkvBqtJS39Lby0vdKhfy/fz5Fe5RwtUDAzwakU31fgCnitZVNry3odV69XIL0Y1bZ
         TGRkjaIk/C7tRVIIrgJ7KPHxQqrxpJoz6PV4+NtehlxdBap2ZQu3mkzGGxtC+RSg7PtY
         j7hXJLavRQDE/iMHVjzkhNjkpLlTjfRjaMs8OkIFLn2fk1JCXeTRfUCgaWYImi1feg8J
         hmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PnblsQTouamLaaYF+i5YwC/rFlgROnk+BZ7Hd2kYjpI=;
        b=pOIL8qSwFUJoTz3h3TrRMXzAKq6/vD4tP33nV5p9FNDgFGwwl+kHPvFr7tR5nxQdHx
         HFNwinpi9p5OQxXM4suXvWUggzAe0rlUKsZupPyGHmBzlchFPGUq/qDNZoSYC4lQQNBB
         Nx2zaXIPKVmIrX7q2dr8fEaddVUjL01f/8GEUQIMbLEl/XiOC5aBrM8togI6CkLGTH7m
         xV1fNqaTsThh/YZBo4FWE+rKW8e8sYoSyhSQokqLue+AG8wcX4ax56ATA45XzWerB+nV
         wmXOruLGXh0uuRpELyCDi1J7GXWG5rQ9Nd259H+P2kSZAGkATfOG63MPbMlDV5rf+TVF
         791Q==
X-Gm-Message-State: AOAM530sI7gLkcWyzqFicO1mV9wZpLcXjV9v/wuCzEn3pZhyD/BMruxh
        70oIxpLuND8tO0barna1dAc=
X-Google-Smtp-Source: ABdhPJzi8HussOq9YJBbDF8N+DOBYLJah0g9SNACCS+ddPovcYcZMJGl7OtpHdRlvEkTfA8yCxGcPA==
X-Received: by 2002:a05:6a00:198a:b0:4bb:2032:2abd with SMTP id d10-20020a056a00198a00b004bb20322abdmr30105624pfl.2.1640837321667;
        Wed, 29 Dec 2021 20:08:41 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id e21sm8488674pff.24.2021.12.29.20.08.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Dec 2021 20:08:41 -0800 (PST)
Date:   Thu, 30 Dec 2021 12:05:54 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, geshifei@coolpad.com,
        zhangwen@coolpad.com, shaojunjun@coolpad.com, huyue@coolpad.com
Subject: Re: [PATCH 2/5] erofs: use meta buffers for inode operations
Message-ID: <20211230120554.000008bc.zbestahu@gmail.com>
In-Reply-To: <20211229041405.45921-3-hsiangkao@linux.alibaba.com>
References: <20211229041405.45921-1-hsiangkao@linux.alibaba.com>
        <20211229041405.45921-3-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2021 12:14:02 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Get rid of old erofs_get_meta_page() within inode operations by
> using on-stack meta buffers in order to prepare subpage and folio
> features.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/inode.c    | 68 +++++++++++++++++++++------------------------
>  fs/erofs/internal.h |  3 ++
>  2 files changed, 35 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 2345f1de438e..ff62f84f47d3 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -13,8 +13,8 @@
>   * the inode payload page if it's an extended inode) in order to fill
>   * inline data if possible.
>   */
> -static struct page *erofs_read_inode(struct inode *inode,
> -				     unsigned int *ofs)
> +static void *erofs_read_inode(struct erofs_buf *buf,
> +			      struct inode *inode, unsigned int *ofs)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> @@ -22,7 +22,7 @@ static struct page *erofs_read_inode(struct inode *inode,
>  	const erofs_off_t inode_loc = iloc(sbi, vi->nid);
>  
>  	erofs_blk_t blkaddr, nblks = 0;
> -	struct page *page;
> +	void *kaddr;
>  	struct erofs_inode_compact *dic;
>  	struct erofs_inode_extended *die, *copied = NULL;
>  	unsigned int ifmt;
> @@ -34,14 +34,14 @@ static struct page *erofs_read_inode(struct inode *inode,
>  	erofs_dbg("%s, reading inode nid %llu at %u of blkaddr %u",
>  		  __func__, vi->nid, *ofs, blkaddr);
>  
> -	page = erofs_get_meta_page(sb, blkaddr);
> -	if (IS_ERR(page)) {
> +	kaddr = erofs_read_metabuf(buf, sb, blkaddr, EROFS_KMAP);
> +	if (IS_ERR(kaddr)) {
>  		erofs_err(sb, "failed to get inode (nid: %llu) page, err %ld",
> -			  vi->nid, PTR_ERR(page));
> -		return page;
> +			  vi->nid, PTR_ERR(kaddr));
> +		return kaddr;
>  	}
>  
> -	dic = page_address(page) + *ofs;
> +	dic = kaddr + *ofs;
>  	ifmt = le16_to_cpu(dic->i_format);
>  
>  	if (ifmt & ~EROFS_I_ALL) {
> @@ -62,12 +62,12 @@ static struct page *erofs_read_inode(struct inode *inode,
>  	switch (erofs_inode_version(ifmt)) {
>  	case EROFS_INODE_LAYOUT_EXTENDED:
>  		vi->inode_isize = sizeof(struct erofs_inode_extended);
> -		/* check if the inode acrosses page boundary */
> -		if (*ofs + vi->inode_isize <= PAGE_SIZE) {
> +		/* check if the extended inode acrosses block boundary */
> +		if (*ofs + vi->inode_isize <= EROFS_BLKSIZ) {
>  			*ofs += vi->inode_isize;
>  			die = (struct erofs_inode_extended *)dic;
>  		} else {
> -			const unsigned int gotten = PAGE_SIZE - *ofs;
> +			const unsigned int gotten = EROFS_BLKSIZ - *ofs;
>  
>  			copied = kmalloc(vi->inode_isize, GFP_NOFS);
>  			if (!copied) {
> @@ -75,18 +75,16 @@ static struct page *erofs_read_inode(struct inode *inode,
>  				goto err_out;
>  			}
>  			memcpy(copied, dic, gotten);
> -			unlock_page(page);
> -			put_page(page);
> -
> -			page = erofs_get_meta_page(sb, blkaddr + 1);
> -			if (IS_ERR(page)) {
> -				erofs_err(sb, "failed to get inode payload page (nid: %llu), err %ld",
> -					  vi->nid, PTR_ERR(page));
> +			kaddr = erofs_read_metabuf(buf, sb, blkaddr + 1,
> +						   EROFS_KMAP);
> +			if (IS_ERR(kaddr)) {
> +				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %ld",
> +					  vi->nid, PTR_ERR(kaddr));
>  				kfree(copied);
> -				return page;
> +				return kaddr;
>  			}
>  			*ofs = vi->inode_isize - gotten;
> -			memcpy((u8 *)copied + gotten, page_address(page), *ofs);
> +			memcpy((u8 *)copied + gotten, kaddr, *ofs);
>  			die = copied;
>  		}
>  		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
> @@ -200,7 +198,7 @@ static struct page *erofs_read_inode(struct inode *inode,
>  		inode->i_blocks = roundup(inode->i_size, EROFS_BLKSIZ) >> 9;
>  	else
>  		inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK;
> -	return page;
> +	return kaddr;
>  
>  bogusimode:
>  	erofs_err(inode->i_sb, "bogus i_mode (%o) @ nid %llu",
> @@ -209,12 +207,11 @@ static struct page *erofs_read_inode(struct inode *inode,
>  err_out:
>  	DBG_BUGON(1);
>  	kfree(copied);
> -	unlock_page(page);
> -	put_page(page);
> +	erofs_put_metabuf(buf);
>  	return ERR_PTR(err);
>  }
>  
> -static int erofs_fill_symlink(struct inode *inode, void *data,
> +static int erofs_fill_symlink(struct inode *inode, void *kaddr,
>  			      unsigned int m_pofs)
>  {
>  	struct erofs_inode *vi = EROFS_I(inode);
> @@ -222,7 +219,7 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
>  
>  	/* if it cannot be handled with fast symlink scheme */
>  	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
> -	    inode->i_size >= PAGE_SIZE) {
> +	    inode->i_size >= EROFS_BLKSIZ) {
>  		inode->i_op = &erofs_symlink_iops;
>  		return 0;
>  	}
> @@ -232,8 +229,8 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
>  		return -ENOMEM;
>  
>  	m_pofs += vi->xattr_isize;
> -	/* inline symlink data shouldn't cross page boundary as well */
> -	if (m_pofs + inode->i_size > PAGE_SIZE) {
> +	/* inline symlink data shouldn't cross block boundary */
> +	if (m_pofs + inode->i_size > EROFS_BLKSIZ) {
>  		kfree(lnk);
>  		erofs_err(inode->i_sb,
>  			  "inline data cross block boundary @ nid %llu",
> @@ -241,8 +238,7 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
>  		DBG_BUGON(1);
>  		return -EFSCORRUPTED;
>  	}
> -
> -	memcpy(lnk, data + m_pofs, inode->i_size);
> +	memcpy(lnk, kaddr + m_pofs, inode->i_size);
>  	lnk[inode->i_size] = '\0';
>  
>  	inode->i_link = lnk;
> @@ -253,16 +249,17 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
>  static int erofs_fill_inode(struct inode *inode, int isdir)
>  {
>  	struct erofs_inode *vi = EROFS_I(inode);
> -	struct page *page;
> +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> +	void *kaddr;
>  	unsigned int ofs;
>  	int err = 0;
>  
>  	trace_erofs_fill_inode(inode, isdir);
>  
>  	/* read inode base data from disk */
> -	page = erofs_read_inode(inode, &ofs);
> -	if (IS_ERR(page))
> -		return PTR_ERR(page);
> +	kaddr = erofs_read_inode(&buf, inode, &ofs);
> +	if (IS_ERR(kaddr))
> +		return PTR_ERR(kaddr);
>  
>  	/* setup the new inode */
>  	switch (inode->i_mode & S_IFMT) {
> @@ -278,7 +275,7 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
>  		inode->i_fop = &erofs_dir_fops;
>  		break;
>  	case S_IFLNK:
> -		err = erofs_fill_symlink(inode, page_address(page), ofs);
> +		err = erofs_fill_symlink(inode, kaddr, ofs);
>  		if (err)
>  			goto out_unlock;
>  		inode_nohighmem(inode);
> @@ -302,8 +299,7 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
>  	inode->i_mapping->a_ops = &erofs_raw_access_aops;
>  
>  out_unlock:
> -	unlock_page(page);
> -	put_page(page);
> +	erofs_put_metabuf(&buf);
>  	return err;
>  }
>  
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 7053f1c4171d..f1e4eb3025f6 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -475,6 +475,9 @@ struct erofs_map_dev {
>  /* data.c */
>  extern const struct file_operations erofs_file_fops;
>  struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr);
> +void erofs_put_metabuf(struct erofs_buf *buf);
> +void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
> +			 erofs_blk_t blkaddr, enum erofs_kmap_type type);
>  int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
>  int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		 u64 start, u64 len);

Reviewed-by: Yue Hu <huyue2@yulong.com>
