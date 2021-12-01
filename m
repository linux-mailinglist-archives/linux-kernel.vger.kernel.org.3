Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B422464F2D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349823AbhLAN4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349862AbhLANx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:53:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C72C0613F1;
        Wed,  1 Dec 2021 05:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=daZqRcrqtRClKybfSmASggxYvpXjW9Q3L8ymYPZL+Rs=; b=3xvQYJuhYFIoGUFLzN8TNO/Wht
        lc5sv2rA/kqj099GIBu8PgaiA1MmDgezzWxVAI7XLokAUhwMcM/NYT5UAS2/2n0mqUV4K/ehHeHjo
        ez8cj3ZkjxarMnlPrNrweqdB4HCb9ROTrPBc6zw2eEohgEr3Fw9/tANXC8mHOnDNyfYem6o1Z3lGh
        Pjc7r/GcAaPVFdPPAS841jOUxlkwFY0lKoh/zD+joWA9OdiAwMc4qPzLYdHpQaL77iQv3qwWxuV7d
        ru8xneZkGRxbUXpJ0ZPItDzLcOURsokQj5Lhk1LWb49qBTGylhR4fAiyjTYk63cwJzxmUzC6QSXx/
        daPpBajg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msQ0F-008tpW-0x; Wed, 01 Dec 2021 13:50:31 +0000
Date:   Wed, 1 Dec 2021 05:50:30 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Li Jinlin <lijinlin3@huawei.com>
Cc:     song@kernel.org, axboe@kernel.dk, hare@suse.de, jack@suse.cz,
        ming.lei@redhat.com, tj@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com
Subject: Re: [PATCH] md: Fix unexpected behaviour in is_mddev_idle
Message-ID: <Yad9phRUdKF/giGD@bombadil.infradead.org>
References: <20211201032712.3684503-1-lijinlin3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201032712.3684503-1-lijinlin3@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:27:12AM +0800, Li Jinlin wrote:
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 5111ed966947..f47035838c43 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8429,14 +8429,14 @@ static int is_mddev_idle(struct mddev *mddev, int init)
>  {
>  	struct md_rdev *rdev;
>  	int idle;
> -	int curr_events;
> +	long curr_events;

>  
>  	idle = 1;
>  	rcu_read_lock();
>  	rdev_for_each_rcu(rdev, mddev) {
>  		struct gendisk *disk = rdev->bdev->bd_disk;
> -		curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
> -			      atomic_read(&disk->sync_io);
> +		curr_events = (long)part_stat_read_accum(disk->part0, sectors) -
> +			      atomic64_read(&disk->sync_io);

And what makes you believe you might not have to go and change all other
drivers to address this as well?

>  static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 74c410263113..efa7884de11b 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -150,7 +150,7 @@ struct gendisk {
>  	struct list_head slave_bdevs;
>  #endif
>  	struct timer_rand_state *random;
> -	atomic_t sync_io;		/* RAID */
> +	atomic64_t sync_io;		/* RAID */
>  	struct disk_events *ev;
>  #ifdef  CONFIG_BLK_DEV_INTEGRITY
>  	struct kobject integrity_kobj;
> -- 
> 2.31.1

  Luis
