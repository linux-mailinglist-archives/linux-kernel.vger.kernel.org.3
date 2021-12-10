Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3588C47005F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhLJMBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:01:09 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47924 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhLJMBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:01:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2777C1F3A0;
        Fri, 10 Dec 2021 11:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639137452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UGqTpPfwCs8oR8Xk7BbaQyH4TxPdYCJW+wRAyjcb1jA=;
        b=GxujRQKr8kTHW6BgLKXN7cesdcK5g4mrvAjy2ijTC8S5o45G3NDAoNbj52b6dKYukmfgGj
        I3BbsNBbq9/IYSVZM23rmB60lrmsJvphwGPTW+CzEzYJ0dNu1hWh9qtxyjcF7R3P3SV2qL
        8DLfVGWxoLc2VdDTWqMsU5HZiQ7LP24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639137452;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UGqTpPfwCs8oR8Xk7BbaQyH4TxPdYCJW+wRAyjcb1jA=;
        b=fYFBwEd9CeYR605E1fzzGEqZpAMN0R+tt0vmupkEFsl59zNCKFlIAYKqnn/pJfKfTjg5tl
        9fRknwhnez8BnSAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE3B413C1D;
        Fri, 10 Dec 2021 11:57:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SX0zOatAs2HqeQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 10 Dec 2021 11:57:31 +0000
To:     Li Jinlin <lijinlin3@huawei.com>, song@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, jack@suse.cz, ming.lei@redhat.com, tj@kernel.org,
        mcgrof@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com
References: <20211210120631.2578505-1-lijinlin3@huawei.com>
 <20211210120631.2578505-2-lijinlin3@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 1/3] md: Fix undefined behaviour in is_mddev_idle
Message-ID: <65d045bc-45d2-9e02-f0f7-7a0f51504eb9@suse.de>
Date:   Fri, 10 Dec 2021 12:57:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211210120631.2578505-2-lijinlin3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 1:06 PM, Li Jinlin wrote:
> UBSAN reports this problem:
> 
> [ 5984.281385] UBSAN: Undefined behaviour in drivers/md/md.c:8175:15
> [ 5984.281390] signed integer overflow:
> [ 5984.281393] -2147483291 - 2072033152 cannot be represented in type 'int'
> [ 5984.281400] CPU: 25 PID: 1854 Comm: md101_resync Kdump: loaded Not tainted 4.19.90
> [ 5984.281404] Hardware name: Huawei TaiShan 200 (Model 5280)/BC82AMDDA
> [ 5984.281406] Call trace:
> [ 5984.281415]  dump_backtrace+0x0/0x310
> [ 5984.281418]  show_stack+0x28/0x38
> [ 5984.281425]  dump_stack+0xec/0x15c
> [ 5984.281430]  ubsan_epilogue+0x18/0x84
> [ 5984.281434]  handle_overflow+0x14c/0x19c
> [ 5984.281439]  __ubsan_handle_sub_overflow+0x34/0x44
> [ 5984.281445]  is_mddev_idle+0x338/0x3d8
> [ 5984.281449]  md_do_sync+0x1bb8/0x1cf8
> [ 5984.281452]  md_thread+0x220/0x288
> [ 5984.281457]  kthread+0x1d8/0x1e0
> [ 5984.281461]  ret_from_fork+0x10/0x18
> 
> When the stat aacum of the disk is greater than INT_MAX, its
> value becomes negative after casting to 'int', which may lead
> to overflow after subtracting a positive number. In the same
> way, when the value of sync_io is greater than INT_MAX,
> overflow may also occur. These situations will lead to
> undefined behavior.
> 
> Otherwise, if the stat accum of the disk is close to INT_MAX
> when creating raid arrays, the initial value of last_events
> would be set close to INT_MAX when mddev initializes IO
> event counters. 'curr_events - rdev->last_events > 64' will
> always false during synchronization. If all the disks of mddev
> are in this case, is_mddev_idle() will always return 1, which
> may cause non-sync IO is very slow.
> 
> Fix by using atomic64_t type for sync_io, and using s64 type
> for curr_events/last_events.
> 
> Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
> ---
>  drivers/md/md.c       | 6 +++---
>  drivers/md/md.h       | 4 ++--
>  include/linux/genhd.h | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 5111ed966947..be73a5ae6864 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8429,14 +8429,14 @@ static int is_mddev_idle(struct mddev *mddev, int init)
>  {
>  	struct md_rdev *rdev;
>  	int idle;
> -	int curr_events;
> +	s64 curr_events;
>  
>  	idle = 1;
>  	rcu_read_lock();
>  	rdev_for_each_rcu(rdev, mddev) {
>  		struct gendisk *disk = rdev->bdev->bd_disk;
> -		curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
> -			      atomic_read(&disk->sync_io);
> +		curr_events = (s64)part_stat_read_accum(disk->part0, sectors) -
> +			      atomic64_read(&disk->sync_io);
>  		/* sync IO will cause sync_io to increase before the disk_stats
>  		 * as sync_io is counted when a request starts, and
>  		 * disk_stats is counted when it completes.
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 53ea7a6961de..e00d6730da13 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -50,7 +50,7 @@ struct md_rdev {
>  
>  	sector_t sectors;		/* Device size (in 512bytes sectors) */
>  	struct mddev *mddev;		/* RAID array if running */
> -	int last_events;		/* IO event timestamp */
> +	s64 last_events;		/* IO event timestamp */
>  
>  	/*
>  	 * If meta_bdev is non-NULL, it means that a separate device is
> @@ -551,7 +551,7 @@ extern void mddev_unlock(struct mddev *mddev);
>  
>  static inline void md_sync_acct(struct block_device *bdev, unsigned long nr_sectors)
>  {
> -	atomic_add(nr_sectors, &bdev->bd_disk->sync_io);
> +	atomic64_add(nr_sectors, &bdev->bd_disk->sync_io);
>  }
>  
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
> 
You haven't answered my question.
This patch has exactly the same problem than the original, only shifted
to LONG_MAX instead of INT_MAX.

Have you considered decreasing 'sync_io' in the endio handler, and then
just using the 'sync_io' value to figure out if sync_io is active?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
