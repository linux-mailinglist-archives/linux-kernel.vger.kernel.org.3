Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F085A304F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 22:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiHZUGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 16:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHZUGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 16:06:16 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3094431EE0;
        Fri, 26 Aug 2022 13:06:13 -0700 (PDT)
Message-ID: <1dc85f87-7146-ccd2-bbf4-e3077dd7a548@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661544371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PNk1kll23rwJYMsqgLsvF7iQCb4ky0T3/2VgqDe/eTw=;
        b=dGlANpuf+dyysAHNTCQkld7zCMnQBzdsup6joAOWrC8cpsUqkoSGuLWQC0YwXko3DvA8D+
        pqOXZCtfDLxV2cUFqtOS8vCd7awM2XEpKEfgFWI7fn7ZVUlhnKEEohQqz9IUmU/47ii7LR
        sUeVGKoKefsvYqoDp4J/fSX9kz0e6sM=
Date:   Fri, 26 Aug 2022 14:06:07 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v12 03/13] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, agk@redhat.com,
        snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        matias.bjorling@wdc.com, gost.dev@samsung.com, bvanassche@acm.org,
        linux-nvme@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121904eucas1p1cdedb3e9af928e25564f46e70765d39b@eucas1p1.samsung.com>
 <20220823121859.163903-4-p.raghav@samsung.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220823121859.163903-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/2022 6:18 AM, Pankaj Raghav wrote:
> Checking if a given sector is aligned to a zone is a common
> operation that is performed for zoned devices. Add
> bdev_is_zone_start helper to check for this instead of opencoding it
> everywhere.
> 
> Convert the calculations on zone size to be generic instead of relying on
> power-of-2(po2) based arithmetic in the block layer using the helpers
> wherever possible.
> 
> The only hot path affected by this change for zoned devices with po2
> zone size is in blk_check_zone_append() but bdev_is_zone_start() helper is
> used to optimize the calculation for po2 zone sizes.
> 
> Finally, allow zoned devices with non po2 zone sizes provided that their
> zone capacity and zone size are equal. The main motivation to allow zoned
> devices with non po2 zone size is to remove the unmapped LBA between
> zone capcity and zone size for devices that cannot have a po2 zone
> capacity.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   block/blk-core.c       |  2 +-
>   block/blk-zoned.c      | 24 ++++++++++++++++++------
>   include/linux/blkdev.h | 30 ++++++++++++++++++++++++++++++
>   3 files changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index a0d1104c5590..1cb519220ffb 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -563,7 +563,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>   		return BLK_STS_NOTSUPP;
>   
>   	/* The bio sector must point to the start of a sequential zone */
> -	if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 1) ||
> +	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector) ||
>   	    !bio_zone_is_seq(bio))
>   		return BLK_STS_IOERR;
>   
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index dce9c95b4bcd..6806c69c81dc 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -285,10 +285,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
>   		return -EINVAL;
>   
>   	/* Check alignment (handle eventual smaller last zone) */
> -	if (sector & (zone_sectors - 1))
> +	if (!bdev_is_zone_start(bdev, sector))
>   		return -EINVAL;
>   
> -	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
> +	if (!bdev_is_zone_start(bdev, nr_sectors) && end_sector != capacity)
>   		return -EINVAL;
>   
>   	/*
> @@ -486,14 +486,26 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>   	 * smaller last zone.
>   	 */
>   	if (zone->start == 0) {
> -		if (zone->len == 0 || !is_power_of_2(zone->len)) {
> -			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
> -				disk->disk_name, zone->len);
> +		if (zone->len == 0) {
> +			pr_warn("%s: Invalid zero zone size", disk->disk_name);
> +			return -ENODEV;
> +		}
> +
> +		/*
> +		 * Non power-of-2 zone size support was added to remove the
> +		 * gap between zone capacity and zone size. Though it is technically
> +		 * possible to have gaps in a non power-of-2 device, Linux requires
> +		 * the zone size to be equal to zone capacity for non power-of-2
> +		 * zoned devices.
> +		 */
> +		if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
> +			pr_err("%s: Invalid zone capacity %lld with non power-of-2 zone size %lld",
> +			       disk->disk_name, zone->capacity, zone->len);
>   			return -ENODEV;
>   		}
>   
>   		args->zone_sectors = zone->len;
> -		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
> +		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
>   	} else if (zone->start + args->zone_sectors < capacity) {
>   		if (zone->len != args->zone_sectors) {
>   			pr_warn("%s: Invalid zoned device with non constant zone size\n",
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 84e7881262e3..d0d66a0db224 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -704,6 +704,30 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>   	return div64_u64(sector, zone_sectors);
>   }
>   
> +static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
> +						   sector_t sec)
> +{
> +	sector_t zone_sectors = bdev_zone_sectors(bdev);
> +	u64 remainder = 0;
> +
> +	if (!bdev_is_zoned(bdev))
> +		return 0;
See below

> +
> +	if (is_power_of_2(zone_sectors))
> +		return sec & (zone_sectors - 1);
> +
> +	div64_u64_rem(sec, zone_sectors, &remainder);
> +	return remainder;
> +}
> +
> +static inline bool bdev_is_zone_start(struct block_device *bdev, sector_t sec)
> +{
> +	if (!bdev_is_zoned(bdev))
> +		return false;
Duplicating the same check above, and the check above is less clear in 
the case of !zoned since it returns 0 and not some warning that makes 
sense in the case of zoned check on !zoned bdev.
Can you simply exclude above check?


> +
> +	return bdev_offset_from_zone_start(bdev, sec) == 0;
> +}
> +
>   static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
>   {
>   	if (!blk_queue_is_zoned(disk->queue))
> @@ -748,6 +772,12 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>   {
>   	return 0;
>   }
> +
> +static inline bool bdev_is_zone_start(struct block_device *bdev, sector_t sec)
> +{
> +	return false;
> +}
> +
>   static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
>   {
>   	return 0;
