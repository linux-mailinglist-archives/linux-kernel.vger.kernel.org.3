Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A76758F11E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbiHJRDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiHJRDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:03:07 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE44422DA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660150986; x=1691686986;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8Pq8CBGLyirGLAmHoB0J+qoIbqc9DpPo2RXP+p6Tvf4=;
  b=YC35f005qpYTC0j1M0GtDmCHpSDDHzULXP8yKg0Or2eZryYPTQj4Es1z
   QlThS8Ba7SdlvjAZi+zHobI4gyPUj52C2jfrDmgdC6+wwcxQoRMviJj+z
   z7fLRpnCETyL/1nkdDbwE2Ale0GyXB/QMD1Mue6ZRIj4IZiRg/nnwAF4q
   C2ByFG6EiK3uEx7TFLSPTs04o1iMen+ge/b1WDqvkhiZ14g1nDusmJ2VY
   KsbXFM0HRF9LJQ8vRuaSdrhzIQwqu/qlr9z9dtW0lIi1wuXdPJUk5SwO3
   jUcYszCf4Y7Mku+cX8Dnr0unNOFM5CMFFC/IEhBbGTILVewBnCPGb0p37
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="208362736"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2022 01:03:04 +0800
IronPort-SDR: Yrij7WGQG7TbnZaPyuAwSC+FctH6QxHf68F9JagEfawXx5tTnx3nfpAFg4URuEakAaoTbgx1RI
 T5ll3q6vI+JCc0AG6uczmJSryMt+eyoW5Q7KD9/l4i3exUYK2XFDa2HSVOqqnZ6WO9C/dXSw+v
 bcD9KbahAlH5K1RBkeZcOUMJoTOjxWbs0pvCR+EQ+PvEOKU4sgzx0qaqKnYP2TYseHiiPRvxBu
 2hNPUPFDpziZzSM06OYdmeOdMHRX89DHex/BROMcHmgWODVVbVWxJfjVTiWWbb7dPwSHqBBoXN
 nKFtfu7WfGKRkYYSDCNVE/BE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 09:18:40 -0700
IronPort-SDR: dqvBzSxrHL7ulSx9Iwei/H5NS8aoIXyGH+L8+gmciQI8Zu0X16x4k99I27kaFOlnJyANztw/2n
 TrKHE0Ra1nW5DJfEUy0vBJ/MNiI2iQQJhYgn1Bc0dHdFTsgqHinDpJzKlqM6HoqGF4TSO1dvPE
 rngxbWgcDzPJi2i0LyMJfRH56TfhAy+6lov8X+nkcQNjKSS5sXRl+V1oMeq1oxfXau29McBIw5
 ZNQM+avzzcBCXXYTKVmgErUSTAezd8iJQQtY5sM05rAKC3TkRw5c5f5oCiMF8VEX7dUScEFHVp
 9W4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 10:03:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2x8S1wKpz1Rwnl
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:03:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660150983; x=1662742984; bh=8Pq8CBGLyirGLAmHoB0J+qoIbqc9DpPo2RX
        P+p6Tvf4=; b=ULHl3HZV8U0XDjLXIZz+O5/ZAmZ2BhIdyCiHrCEZreJls3CFdSX
        TZ7/vfz0FwVd3gYG2PfbsIW9TEuOdAqjEIwn7oUs7Z+xisLM5FqIAYPs9yVFgDPm
        Z6XZI5u5jW1Zk32sZfMAzfQxRH3hH4Q5PzO70OI/GCLSaOG9Dcn/3IYa3OFNWnjk
        WGVYbvsZZyDaGHDpJ9mv0tlkpVonuF+sH8uGHJ3mNyg0bgaUcYC8+tfdPGJORLI7
        vUkbtaMYVVvqAPu49BcS2SPbtoGZK3LYVUjPin0DSlxIlYs31IteLM59kM+1qccI
        vppjwWhCW3AddEM1gWmY0kuYivE+1apbpaw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W8hImcKaa4rp for <linux-kernel@vger.kernel.org>;
        Wed, 10 Aug 2022 10:03:03 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2x8P5ybyz1RtVk;
        Wed, 10 Aug 2022 10:03:01 -0700 (PDT)
Message-ID: <d7343e70-cbfa-4163-a78e-963fbf3bb38c@opensource.wdc.com>
Date:   Wed, 10 Aug 2022 10:03:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v9 03/13] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094805eucas1p1c68ba40d319331c2c34059f966ba2d83@eucas1p1.samsung.com>
 <20220803094801.177490-4-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220803094801.177490-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/08/03 2:47, Pankaj Raghav wrote:
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
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-core.c       |  2 +-
>  block/blk-zoned.c      | 24 ++++++++++++++++++------
>  include/linux/blkdev.h | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index a0d1104c5590..1cb519220ffb 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -563,7 +563,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>  		return BLK_STS_NOTSUPP;
>  
>  	/* The bio sector must point to the start of a sequential zone */
> -	if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 1) ||
> +	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector) ||
>  	    !bio_zone_is_seq(bio))
>  		return BLK_STS_IOERR;
>  
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index dce9c95b4bcd..665b822d13f9 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -285,10 +285,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
>  		return -EINVAL;
>  
>  	/* Check alignment (handle eventual smaller last zone) */
> -	if (sector & (zone_sectors - 1))
> +	if (!bdev_is_zone_start(bdev, sector))
>  		return -EINVAL;
>  
> -	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
> +	if (!bdev_is_zone_start(bdev, nr_sectors) && end_sector != capacity)
>  		return -EINVAL;
>  
>  	/*
> @@ -486,14 +486,26 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>  	 * smaller last zone.
>  	 */
>  	if (zone->start == 0) {
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
> +			pr_err("%s: Invalid zone capacity: %lld with non power-of-2 zone size: %lld",
> +			       disk->disk_name, zone->capacity, zone->len);
>  			return -ENODEV;
>  		}
>  
>  		args->zone_sectors = zone->len;
> -		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
> +		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
>  	} else if (zone->start + args->zone_sectors < capacity) {
>  		if (zone->len != args->zone_sectors) {
>  			pr_warn("%s: Invalid zoned device with non constant zone size\n",
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 22f97427b60b..5aa15172299d 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -709,6 +709,30 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>  	return div64_u64(sector, zone_sectors);
>  }
>  
> +static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
> +						   sector_t sec)
> +{
> +	sector_t zone_sectors = bdev_zone_sectors(bdev);
> +	u64 remainder = 0;
> +
> +	if (!bdev_is_zoned(bdev))
> +		return 0;
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
> +
> +	return bdev_offset_from_zone_start(bdev, sec) == 0;
> +}
> +
>  static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
>  {
>  	if (!blk_queue_is_zoned(disk->queue))
> @@ -753,6 +777,12 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>  {
>  	return 0;
>  }
> +
> +static inline bool bdev_is_zone_start(struct block_device *bdev, sector_t sec)
> +{
> +	return false;
> +}

Is this one really necessary ? Any caller of this would also depend on
CONFIG_BLK_DEV_ZONED and not compiled if not enabled. So there should be no
callers of this for the !CONFIG_BLK_DEV_ZONED case.

> +
>  static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
>  {
>  	return 0;


-- 
Damien Le Moal
Western Digital Research
