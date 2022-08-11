Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8999D59076F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 22:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbiHKUeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 16:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbiHKUdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 16:33:54 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BE0A00E0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660250028; x=1691786028;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PaqvzZxRcEr0+CT5UB15A08/nBKKsFBZ3mGE5lOTL8Y=;
  b=OO4M9jZnYPwGrMvQSaiDet9bSu9ApcapkenjrZ5zDL0Y0Q4K5GWe+byj
   mfPd7wfHoigPd6GNbMcASSWiFYYsEjcfjPHtSqJ0noLwoQBzNwNSlUJR5
   CfFFqW21dfiu82A9hlkX6p8tU8aqMlxxoe18ZO+qadMaY5X6SDvCfUYaG
   a7eG/gzEynQSIx+SyOM/EJ23mRYk3MiZhH7Uie4JtkNHaPfD6xwFkd4Iw
   eYe4oEqdPlHFQoPtcfP/FDMIqx7/R9CR4AUSwQspwhlUEYEIV3E68b/3e
   qSVti3fqgtFAhBZYZc493deqmHrMp9a+qbag4pjduDryTVWpt1CY9jpWj
   w==;
X-IronPort-AV: E=Sophos;i="5.93,230,1654531200"; 
   d="scan'208";a="209031682"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2022 04:33:46 +0800
IronPort-SDR: vCXk/1A1m5gGOlo9L1/9PegzYO2XNy5Hrl0iYGAS/o+0G9lptBL7bbVmdouEQTvstIptJILyjY
 yiIC+UlVQlUJWFH/iA5eWEJYkKdmQocWJb560BP5Rz3e9NZYg9ZVcdqJQl77oCmtNVLX8uLX3g
 Y5z4k2u4MGyXJHT3QjissQzLrJQOLdX456nYtIpIjQQHn9YgYENrrORRtOSZ2pYEy+3ZWQASqZ
 QmzN0Qmr4VOZ6KQCIoyJgwQtcuSTIzKKdH32IQEOf3mfiuHP3Xeqg0ujfzIbi8RRuXrO7xuPgi
 rETarMDHktkwhjUqv7pfVSQz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2022 12:54:39 -0700
IronPort-SDR: 2j0pewF3fDTY5Wdt/rC95XslsECsC88ivH1HI5sMP6bkP2bsUABppRzldCaeX6YyNG2A0r0Nhk
 7K4KiOCTufFTAXTr307jngzHgEZ1yod0QgSTGMIduj6f1UHMgeFcTlwnEsD/9z7AWPHfcUop6p
 HrKaOb6cUxvJdQzhZr5MzTKFot6YgAZgkVkhHYMFqhoMpRGADy7j3QlbzvR6Ad7sfkHib09eGR
 2G9/j7MnF3ZQLU9SLYarxpJOQranUpH9pZQnOK381VMlMRm5VjnNWgWO98aqr7wwgg0T9m4tBm
 dNg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2022 13:33:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M3dWP0q7Mz1Rws6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:21:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660249312; x=1662841313; bh=PaqvzZxRcEr0+CT5UB15A08/nBKKsFBZ3mG
        E5lOTL8Y=; b=AMcmyLVPNlo5pzyagRiH4r92Sm7xf3CA8x5ETJMBefVeitp2S+k
        TQj1Do0vLf7eTEAP0V8y1+THKSI7qtu/qnhS7+5fHNb6mkqgpDGhGSJMhHB3L3Lm
        p4iPyrTp0hH17v+rRTt+VbnKvjB13qVFMjC3wGiaOG3B1FqORvjOv/7jCOwz9lk9
        20OKLzKAtkEFsDY444Pd683BQBOEn0JwscfVczAYSurUzTawP2280vxk3AgB0Y9X
        Js8CEyQvmp6ltWsHaRdhR3bewW4vMkoagfLYpzgrn2TaWHoki3jJ6i7qkHtrUULw
        blBhLkVYb+PHZvm2cMqks8VI3eaXcRRlu8g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HUsKzKO9nYUH for <linux-kernel@vger.kernel.org>;
        Thu, 11 Aug 2022 13:21:52 -0700 (PDT)
Received: from [10.11.46.122] (c02drav6md6t.sdcorp.global.sandisk.com [10.11.46.122])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M3dWL6qzfz1RtVk;
        Thu, 11 Aug 2022 13:21:50 -0700 (PDT)
Message-ID: <01062caf-6504-f223-b9c2-6543a58f7f9d@opensource.wdc.com>
Date:   Thu, 11 Aug 2022 13:21:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v10 02/13] block:rearrange
 bdev_{is_zoned,zone_sectors,get_queue} helpers in blkdev.h
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, snitzer@kernel.org,
        axboe@kernel.dk, hch@lst.de, agk@redhat.com
Cc:     linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, pankydev8@gmail.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20220811143043.126029-1-p.raghav@samsung.com>
 <CGME20220811143046eucas1p2e49a778cff29476c7ebaef1d1c67d86c@eucas1p2.samsung.com>
 <20220811143043.126029-3-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220811143043.126029-3-p.raghav@samsung.com>
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

On 2022/08/11 7:30, Pankaj Raghav wrote:
> Define bdev_is_zoned(), bdev_zone_sectors() and bdev_get_queue() earlier
> in the blkdev.h include file. Simplify bdev_is_zoned() by removing the
> superfluous NULL check for request queue while we are at it.
> 
> This commit has no functional change, and it is a prep patch for allowing
> zoned devices with non-power-of-2 zone sizes in the block layer.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/blkdev.h | 43 +++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ab82d1ff0cce..84e7881262e3 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -635,6 +635,11 @@ static inline bool queue_is_mq(struct request_queue *q)
>  	return q->mq_ops;
>  }
>  
> +static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
> +{
> +	return bdev->bd_queue;	/* this is never NULL */
> +}
> +
>  #ifdef CONFIG_PM
>  static inline enum rpm_status queue_rpm_status(struct request_queue *q)
>  {
> @@ -666,6 +671,20 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
>  	}
>  }
>  
> +static inline bool bdev_is_zoned(struct block_device *bdev)
> +{
> +	return blk_queue_is_zoned(bdev_get_queue(bdev));
> +}

You changed this too, so drop the current reviewed-by tag please.

For the next round, feel free to add:

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> +
> +static inline sector_t bdev_zone_sectors(struct block_device *bdev)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (!blk_queue_is_zoned(q))
> +		return 0;
> +	return q->limits.chunk_sectors;
> +}
> +
>  #ifdef CONFIG_BLK_DEV_ZONED
>  static inline unsigned int disk_nr_zones(struct gendisk *disk)
>  {
> @@ -892,11 +911,6 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags);
>  int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
>  			unsigned int flags);
>  
> -static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
> -{
> -	return bdev->bd_queue;	/* this is never NULL */
> -}
> -
>  /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
>  const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
>  
> @@ -1296,25 +1310,6 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
>  	return BLK_ZONED_NONE;
>  }
>  
> -static inline bool bdev_is_zoned(struct block_device *bdev)
> -{
> -	struct request_queue *q = bdev_get_queue(bdev);
> -
> -	if (q)
> -		return blk_queue_is_zoned(q);
> -
> -	return false;
> -}
> -
> -static inline sector_t bdev_zone_sectors(struct block_device *bdev)
> -{
> -	struct request_queue *q = bdev_get_queue(bdev);
> -
> -	if (!blk_queue_is_zoned(q))
> -		return 0;
> -	return q->limits.chunk_sectors;
> -}
> -
>  static inline int queue_dma_alignment(const struct request_queue *q)
>  {
>  	return q ? q->dma_alignment : 511;


-- 
Damien Le Moal
Western Digital Research
