Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BE8496A00
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 05:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiAVEUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 23:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiAVEUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 23:20:43 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB177C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 20:20:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v11-20020a17090a520b00b001b512482f36so7928460pjh.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 20:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQYWldVl/v8iAXB+fYB/Iz87WMpFSCsjxuQmCfoPJFA=;
        b=RZh3YysjdgtBkVCYtWANxCaUNoozzJOYx9qMNHT/wumvd/DpBfEej/M/VgKv8MzXg0
         9C/X7m28FDD9qCzqi60NirzP2Rb4Q9bTHTRBezh/hQSH3rsPWdR4xjhsDY4P4Pt7ABWa
         So4CDIXSdPi3gMtpP0+O/fmqx97sejMwAgWvOH5m+YwCK9u0sOjz92IoGbbcUzZj2dc4
         0ap/rYb1o3nWlajqUuilJdjo9zlMsF+MbFOL7JQsKm1+KkLD//zJJDGJJ/Fncs++zr4c
         8pA06ExlEj/LS7SWExMGpvhMy0EuoJvEt+DNdc93x/kCu20LlQv8Wh4rnStNRzWlU6f6
         iuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQYWldVl/v8iAXB+fYB/Iz87WMpFSCsjxuQmCfoPJFA=;
        b=CHhd/76kgncvlmrmm1H/gUw58VILX+xzfAA5QE2N8yqaZshxAfeIDUmwftzP3BDbnP
         5RlaA52dvhr1xVJX8grd87w0WSqQR3LmUpCkFH0DtK5NsNz3Jh3MrPIhXHL4d1CzOmIn
         YhMtL/wcogsU5UnK4aXxOPkDN3D9Z69dQixMSnjcatyWSELaVpQn8uhBXt8M0szjjEIT
         FwSz9aCv6EdkPjOhfJYZdtSLCzTC1kPMisEb1sDWV6yRusV5ffbYw6s6onIZGQW7Py8e
         GZjTRK/0HrAJIGvpwGnaP5TLghf5mFXiiOEFikcbrfzmgpjXGFbaWtuPxR3YNvxwBhAd
         dETQ==
X-Gm-Message-State: AOAM5309VPbL9FyMrhR+YCz8D+AKXZnyTVmXmEakNMLVdsKGrTtmbM29
        lD8M2W5sWx5QgMmgnqqQRZT3AKv/XPA=
X-Google-Smtp-Source: ABdhPJz2N6aXWY+JmIYOg9QgH03BEFlnj38XM8mlmxFjofqrDd+izJYVhVC2Bm13gpx/g5tNb/j6zA==
X-Received: by 2002:a17:902:d50c:b0:14a:fcde:b3b2 with SMTP id b12-20020a170902d50c00b0014afcdeb3b2mr6271998plg.87.1642825242263;
        Fri, 21 Jan 2022 20:20:42 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id ms14sm6646686pjb.15.2022.01.21.20.20.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jan 2022 20:20:42 -0800 (PST)
Date:   Sat, 22 Jan 2022 12:18:27 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: avoid unnecessary z_erofs_decompressqueue_work()
 declaration
Message-ID: <20220122121827.0000243c.zbestahu@gmail.com>
In-Reply-To: <20220121091412.86086-1-hsiangkao@linux.alibaba.com>
References: <20220121091412.86086-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 17:14:12 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Just code rearrange. No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 113 +++++++++++++++++++++++------------------------
>  1 file changed, 56 insertions(+), 57 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 498b7666efe8..423bc1a61da5 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -810,68 +810,11 @@ static bool z_erofs_get_sync_decompress_policy(struct erofs_sb_info *sbi,
>  	return false;
>  }
>  
> -static void z_erofs_decompressqueue_work(struct work_struct *work);
> -static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
> -				       bool sync, int bios)
> -{
> -	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
> -
> -	/* wake up the caller thread for sync decompression */
> -	if (sync) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&io->u.wait.lock, flags);
> -		if (!atomic_add_return(bios, &io->pending_bios))
> -			wake_up_locked(&io->u.wait);
> -		spin_unlock_irqrestore(&io->u.wait.lock, flags);
> -		return;
> -	}
> -
> -	if (atomic_add_return(bios, &io->pending_bios))
> -		return;
> -	/* Use workqueue and sync decompression for atomic contexts only */
> -	if (in_atomic() || irqs_disabled()) {
> -		queue_work(z_erofs_workqueue, &io->u.work);
> -		/* enable sync decompression for readahead */
> -		if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
> -			sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
> -		return;
> -	}
> -	z_erofs_decompressqueue_work(&io->u.work);
> -}
> -
>  static bool z_erofs_page_is_invalidated(struct page *page)
>  {
>  	return !page->mapping && !z_erofs_is_shortlived_page(page);
>  }
>  
> -static void z_erofs_decompressqueue_endio(struct bio *bio)
> -{
> -	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
> -	struct z_erofs_decompressqueue *q = tagptr_unfold_ptr(t);
> -	blk_status_t err = bio->bi_status;
> -	struct bio_vec *bvec;
> -	struct bvec_iter_all iter_all;
> -
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		struct page *page = bvec->bv_page;
> -
> -		DBG_BUGON(PageUptodate(page));
> -		DBG_BUGON(z_erofs_page_is_invalidated(page));
> -
> -		if (err)
> -			SetPageError(page);
> -
> -		if (erofs_page_is_managed(EROFS_SB(q->sb), page)) {
> -			if (!err)
> -				SetPageUptodate(page);
> -			unlock_page(page);
> -		}
> -	}
> -	z_erofs_decompress_kickoff(q, tagptr_unfold_tags(t), -1);
> -	bio_put(bio);
> -}
> -
>  static int z_erofs_decompress_pcluster(struct super_block *sb,
>  				       struct z_erofs_pcluster *pcl,
>  				       struct page **pagepool)
> @@ -1123,6 +1066,35 @@ static void z_erofs_decompressqueue_work(struct work_struct *work)
>  	kvfree(bgq);
>  }
>  
> +static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
> +				       bool sync, int bios)
> +{
> +	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
> +
> +	/* wake up the caller thread for sync decompression */
> +	if (sync) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&io->u.wait.lock, flags);
> +		if (!atomic_add_return(bios, &io->pending_bios))
> +			wake_up_locked(&io->u.wait);
> +		spin_unlock_irqrestore(&io->u.wait.lock, flags);
> +		return;
> +	}
> +
> +	if (atomic_add_return(bios, &io->pending_bios))
> +		return;
> +	/* Use workqueue and sync decompression for atomic contexts only */
> +	if (in_atomic() || irqs_disabled()) {
> +		queue_work(z_erofs_workqueue, &io->u.work);
> +		/* enable sync decompression for readahead */
> +		if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
> +			sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
> +		return;
> +	}
> +	z_erofs_decompressqueue_work(&io->u.work);
> +}
> +
>  static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
>  					       unsigned int nr,
>  					       struct page **pagepool,
> @@ -1300,6 +1272,33 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
>  	qtail[JQ_BYPASS] = &pcl->next;
>  }
>  
> +static void z_erofs_decompressqueue_endio(struct bio *bio)
> +{
> +	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
> +	struct z_erofs_decompressqueue *q = tagptr_unfold_ptr(t);
> +	blk_status_t err = bio->bi_status;
> +	struct bio_vec *bvec;
> +	struct bvec_iter_all iter_all;
> +
> +	bio_for_each_segment_all(bvec, bio, iter_all) {
> +		struct page *page = bvec->bv_page;
> +
> +		DBG_BUGON(PageUptodate(page));
> +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> +
> +		if (err)
> +			SetPageError(page);
> +
> +		if (erofs_page_is_managed(EROFS_SB(q->sb), page)) {
> +			if (!err)
> +				SetPageUptodate(page);
> +			unlock_page(page);
> +		}
> +	}
> +	z_erofs_decompress_kickoff(q, tagptr_unfold_tags(t), -1);
> +	bio_put(bio);
> +}
> +

Reviewed-by: Yue Hu <huyue2@yulong.com>

>  static void z_erofs_submit_queue(struct super_block *sb,
>  				 struct z_erofs_decompress_frontend *f,
>  				 struct page **pagepool,

