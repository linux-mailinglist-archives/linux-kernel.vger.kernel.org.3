Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0006583734
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbiG1CyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbiG1CyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:54:14 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3E058B7A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658976853; x=1690512853;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GSr/pP4m0bHkfNC+g6XCtP9uY3KjMFGPPT9S8YRebJE=;
  b=po3Ht95k10k+hCUGsBjzv8UVXqipM6Njb8GjuvRneVn5DjL/gUqXG1q1
   3+3Lm+/JURnQk9mFKRftxC8D0Huami0fV3OaJG1YLNmEF8kciHq9C8WeI
   vDRsZ9mtR6WcJLQk+uUK7mPKk6IFmeChyzaTwPHpnS2XRmLYF1IMRGTJ0
   yz26g2+TUzNKRsdLWg3Rbv0UkoyHTSDV33XVGoKWPRtr5IWZ/3zj5500B
   9Tl86qWk102SRQkb4YZtNFiX+3E3cZo/QEOF4nk5ADyo/SjFQ+nqh2I+i
   WOGVrIs5UG/TAYmkRzoLwzRx74EczyB69B2ItR8OtaY2RQte85CSGjuW7
   g==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="311432504"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 10:54:10 +0800
IronPort-SDR: JDrTORuOemQDu977Z3JE+yxQTF8Ph4Co8n6E/sDhqCHVxATnxzhaEoICQpNDAFPSa2ZazGzdOj
 98NzIHukzpFEzzzpyMAhwxAYVtYC6CpFeLE0N98sp5C3+U1ueV0Wt/E9GtEoF73Mw2TBNzYVZD
 vsi8tpM1m7HgZt8x9IQzFTnhTMtALWtdHrho9vQdMHw8ZI/EUB30vVMBDASbvSM94YMNtXL6J5
 oBfu2H+I1r28kVNWP0mQHAyC6oA/TwNY6urEXuSHADUZ/6vGb9Oh1cDolDL33ogLHBNrp0b5Q8
 mpf8Cu7aVG46Ki16WB1rbXg9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:10:17 -0700
IronPort-SDR: P3Q2CFJIYO/nStPuLW+iuzB1JTlJDkfulHuugeUY59x0XlBmzuzRZ05LxHF/7t94nmQDg9FLDH
 MPXBEcSS/OuT1YSUqv890dw6RFcTTIDqdWhkIKwvYqQ72491sKjYVmykvoo3VUg3Vp/kzPT3Yj
 cbCaF91Gh7ZUNQD6GPxT7pRbs0Tqh4LNv3mHCNntsB15DIiWvvHV/3GjLHAGBgY5rUVLHypSjN
 u7Vnb/+1hIb+VkoPubUzxnn0YzJ27EdKMC14pFdz76hnJo7WhfDd1V88rYlMrC7m6ZU3ZUIjQH
 Yp0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:54:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtZwx05h5z1Rws4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:54:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658976847; x=1661568848; bh=GSr/pP4m0bHkfNC+g6XCtP9uY3KjMFGPPT9
        S8YRebJE=; b=iAJOSVTr2atboaLSeqpeZri+S/tNSsrkHPx1mz1zbwzdF01DBQc
        waKcUZcHGbMLRL7E+eKen1a9JeWBM6bjHtrG3dg5HctisEKSlnjiqRAId1IKriTN
        pOMFX54PQK8efX+3ZmACMszslwuajReZ7M1uqN5PhD4B7mVC7ncMQ/y8toKmyLr4
        WuqpZzz26skvJhJYEHjbULz/9J9HKVtQuP+MaQJxgHRyNFS5jwt6VNEMWezf/J4x
        fa3zIwVODklXpd8x+hCvrqA+Rqnvbguz3uMb96IaKsIKym0eYPRrxEQOByu09FAq
        9uvbgYTQuHr8xCxzy6GDpMlxJjOgso2Qk8g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zTIRfjxQ_tbJ for <linux-kernel@vger.kernel.org>;
        Wed, 27 Jul 2022 19:54:07 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtZwr6MMlz1RtVk;
        Wed, 27 Jul 2022 19:54:04 -0700 (PDT)
Message-ID: <8e0c4a9f-de4a-d53e-efef-0b27017ec78d@opensource.wdc.com>
Date:   Thu, 28 Jul 2022 11:54:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 01/11] block: make bdev_nr_zones and disk_zone_no
 generic for npo2 zsze
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162247eucas1p203fc14aa17ecbcb3e6215d5304bb0c85@eucas1p2.samsung.com>
 <20220727162245.209794-2-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 01:22, Pankaj Raghav wrote:
> Adapt bdev_nr_zones and disk_zone_no function so that it can

s/function/functions
s/it/they

> also work for non-power-of-2 zone sizes.
> 
> As the existing deployments of zoned devices had power-of-2

had power-of-2 assumption -> assume that a device zone size is a power of
2 number of sectors

Existing deployments still exist, so do not use the past tense please.

> assumption, power-of-2 optimized calculation is kept for those devices.
> 
> There are no direct hot paths modified and the changes just
> introduce one new branch per call.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-zoned.c      | 13 +++++++++----
>  include/linux/blkdev.h |  8 +++++++-
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index a264621d4905..dce9c95b4bcd 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -111,17 +111,22 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
>   * bdev_nr_zones - Get number of zones
>   * @bdev:	Target device
>   *
> - * Return the total number of zones of a zoned block device.  For a block
> - * device without zone capabilities, the number of zones is always 0.
> + * Return the total number of zones of a zoned block device, including the
> + * eventual small last zone if present. For a block device without zone
> + * capabilities, the number of zones is always 0.
>   */
>  unsigned int bdev_nr_zones(struct block_device *bdev)
>  {
>  	sector_t zone_sectors = bdev_zone_sectors(bdev);
> +	sector_t capacity = bdev_nr_sectors(bdev);
>  
>  	if (!bdev_is_zoned(bdev))
>  		return 0;
> -	return (bdev_nr_sectors(bdev) + zone_sectors - 1) >>
> -		ilog2(zone_sectors);
> +
> +	if (is_power_of_2(zone_sectors))
> +		return (capacity + zone_sectors - 1) >> ilog2(zone_sectors);
> +
> +	return DIV_ROUND_UP_SECTOR_T(capacity, zone_sectors);
>  }
>  EXPORT_SYMBOL_GPL(bdev_nr_zones);
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index dccdf1551c62..85b832908f28 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -673,9 +673,15 @@ static inline unsigned int disk_nr_zones(struct gendisk *disk)
>  
>  static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>  {
> +	sector_t zone_sectors = disk->queue->limits.chunk_sectors;
> +
>  	if (!blk_queue_is_zoned(disk->queue))
>  		return 0;
> -	return sector >> ilog2(disk->queue->limits.chunk_sectors);
> +
> +	if (is_power_of_2(zone_sectors))
> +		return sector >> ilog2(zone_sectors);
> +
> +	return div64_u64(sector, zone_sectors);
>  }
>  
>  static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)


-- 
Damien Le Moal
Western Digital Research
