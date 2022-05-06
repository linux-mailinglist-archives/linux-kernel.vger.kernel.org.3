Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4C151DC81
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443141AbiEFPuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443103AbiEFPuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:50:54 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86EA6D85F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651852032; x=1683388032;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=59Rf2fI9Uw9YDeWqGexMB7hcfRNyi4rusRKW1UzXakE=;
  b=Z00Zar/1qxYaGxjV0E9gwi82NvmEgOtfi3f60OKELLpZzSmjManBKgut
   e+JJXStybhd9iqU+znjgepf8kAkxyx7xFSuNSZS/JkIDYX7OqB3JoGgHn
   iyDKRtAM6OmQJI7nFks2wOp1YMG1qABNU1zq3Vz6RMrP7GT/TFvNL2HZA
   rdsCY72N7gG2mViP//z7rFeyCX+sPOjUqUqqVoPB+nKrMoUA5PS7TZtiX
   qXuc7uNbMO/fHxwfacIPM25YFLwDFom7DWDAhM6Fehh/k3dFIpXxMNfNb
   PANu77iGI3JWEufYZIzQIao2aJuGtbKX59Ju+2guCbLr0mqPaVwugPHHe
   w==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647273600"; 
   d="scan'208";a="200577969"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 May 2022 23:47:10 +0800
IronPort-SDR: tqQvKcuLB9zXp4REcTSm84OSkS4xL87VWGUowpTWh0Ii1fcB3pGMO5uQDyNYxqhODLwtyyITNl
 HbY8bJcYVlaVpOYiSiQNvB5dlb3m2O4cY4xPbM9ufPP7Agi/NEITc5GoLGxELH9kGwaDZBv+aQ
 2rG8V7TtP+Fcgmz4Jiq6IckT4RNqNOZ9QXTU//gXOO7fIiUAffGyHLxmWlaTC7AnJEjBUm1EOk
 Rl5C6e3HyjkIfWwobbCqTXJ7x9HRGC1B2P51NxnLx/SLCb4FfZyN9RK4We1PdzRf3C3mboUYmR
 SIEo9/SA2pSAm5ADQmwh2UKf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2022 08:17:25 -0700
IronPort-SDR: fgwEQdbRBYMiYceHsOrqyXLVOTde7M+ts9bsc7VypwPzLK+GSMK4l/Jn/afU0SzhmRYYPvGY+O
 Dx+YmkMAbZ3Wf5X1vyQtffX+1kndPhFkxvO26eB4p1hTFu/XJNo2BKF+qT51+Yoi/P/q80HYzt
 dc4zM8Ev9joCPG7S3MFwNxz5twxfxMKFiQShJxybaFYLhq2uPboTOSo5t05qcA1Dqo0xPcGIz0
 /IsWA0Sb6/PU3p7uEppSxTN33OfBMeT0sUqdn2GJad4h63QK9jDtSvK8AbGht5ZwLp7jedD0E/
 nnc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2022 08:47:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kvw1730Mfz1SVp8
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:47:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651852026; x=1654444027; bh=59Rf2fI9Uw9YDeWqGexMB7hcfRNyi4rusRK
        W1UzXakE=; b=X/b6rmohjasoazviVlFH//kXZ5lOWuyvheX6ZGozEy/Jw39WmZE
        lWU+QQpYsARF7Q6O4/8mG0d3aCioDx7xyZIAIKTrW0ge4u3Pm2yFjBgrk6Svbp1D
        qLdbvfRaBSO07Bd6/hziKh9hDjSHP65ov9mYNr5Zq/ukRH0DvyhVmLKf4RGT+tuR
        i6crnhIeY12x/o89Q7N/fW+YJmKZqB+udn3/wJI+Ap0WGDz0A0Sq6iPrRuVjo/TY
        LV0aC4gcGtWY5HAvjpY3WevY+iJIvEEbaiCdQDE5D9HajIcIDrYtCpyIUqEdBFAX
        4ZhZ7bLuMpsdOgiZ7WIFkPP1CjEbyCK2YmA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x-hSmQoNo3R7 for <linux-kernel@vger.kernel.org>;
        Fri,  6 May 2022 08:47:06 -0700 (PDT)
Received: from [10.225.103.215] (hn9j2j3.ad.shared [10.225.103.215])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kvw133RlTz1Rvlc;
        Fri,  6 May 2022 08:47:03 -0700 (PDT)
Message-ID: <39a80347-af70-8af0-024a-52f92e27a14a@opensource.wdc.com>
Date:   Sat, 7 May 2022 00:47:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v3 10/11] null_blk: allow non power of 2 zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
        hare@suse.de, dsterba@suse.com, axboe@kernel.dk, hch@lst.de,
        snitzer@kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        bvanassche@acm.org, linux-fsdevel@vger.kernel.org,
        matias.bjorling@wdc.com, Jens Axboe <axboe@fb.com>,
        gost.dev@samsung.com, jonathan.derrick@linux.dev,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alasdair Kergon <agk@redhat.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081116eucas1p2cce67bbf30f4c9c4e6854965be41b098@eucas1p2.samsung.com>
 <20220506081105.29134-11-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220506081105.29134-11-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/06 17:11, Pankaj Raghav wrote:
> Convert the power of 2 based calculation with zone size to be generic in
> null_zone_no with optimization for power of 2 based zone sizes.
> 
> The nr_zones calculation in null_init_zoned_dev has been replaced with a
> division without special handling for power of 2 based zone sizes as
> this function is called only during the initialization and will not
> invoked in the hot path.
> 
> Performance Measurement:
> 
> Device:
> zone size = 128M, blocksize=4k
> 
> FIO cmd:
> 
> fio --name=zbc --filename=/dev/nullb0 --direct=1 --zonemode=zbd  --size=23G
> --io_size=<iosize> --ioengine=io_uring --iodepth=<iod> --rw=<mode> --bs=4k
> --loops=4
> 
> The following results are an average of 4 runs on AMD Ryzen 5 5600X with
> 32GB of RAM:
> 
> Sequential Write:
> 
> x-----------------x---------------------------------x---------------------------------x
> |     IOdepth     |            8                    |            16                   |
> x-----------------x---------------------------------x---------------------------------x
> |                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
> x-----------------x---------------------------------x---------------------------------x
> | Without patch   |  578     |  2257    |   12.80   |  576     |  2248    |   25.78   |
> x-----------------x---------------------------------x---------------------------------x
> |  With patch     |  581     |  2268    |   12.74   |  576     |  2248    |   25.85   |
> x-----------------x---------------------------------x---------------------------------x
> 
> Sequential read:
> 
> x-----------------x---------------------------------x---------------------------------x
> | IOdepth         |            8                    |            16                   |
> x-----------------x---------------------------------x---------------------------------x
> |                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
> x-----------------x---------------------------------x---------------------------------x
> | Without patch   |  667     |  2605    |   11.79   |  675     |  2637    |   23.49   |
> x-----------------x---------------------------------x---------------------------------x
> |  With patch     |  667     |  2605    |   11.79   |  675     |  2638    |   23.48   |
> x-----------------x---------------------------------x---------------------------------x
> 
> Random read:
> 
> x-----------------x---------------------------------x---------------------------------x
> | IOdepth         |            8                    |            16                   |
> x-----------------x---------------------------------x---------------------------------x
> |                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
> x-----------------x---------------------------------x---------------------------------x
> | Without patch   |  522     |  2038    |   15.05   |  514     |  2006    |   30.87   |
> x-----------------x---------------------------------x---------------------------------x
> |  With patch     |  522     |  2039    |   15.04   |  523     |  2042    |   30.33   |
> x-----------------x---------------------------------x---------------------------------x
> 
> Minor variations are noticed in Sequential write with io depth 8 and
> in random read with io depth 16. But overall no noticeable differences
> were noticed
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/block/null_blk/main.c  |  5 ++---
>  drivers/block/null_blk/zoned.c | 14 +++++++-------
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 5cb4c92cd..ed9a58201 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1929,9 +1929,8 @@ static int null_validate_conf(struct nullb_device *dev)
>  	if (dev->queue_mode == NULL_Q_BIO)
>  		dev->mbps = 0;
>  
> -	if (dev->zoned &&
> -	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
> -		pr_err("zone_size must be power-of-two\n");
> +	if (dev->zoned && !dev->zone_size) {
> +		pr_err("zone_size must not be zero\n");

May be a simpler phrasing would be better:

pr_err("Invalid zero zone size\n");

>  		return -EINVAL;
>  	}
>  
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index dae54dd1a..00c34e65e 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -13,7 +13,10 @@ static inline sector_t mb_to_sects(unsigned long mb)
>  
>  static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
>  {
> -	return sect >> ilog2(dev->zone_size_sects);
> +	if (is_power_of_2(dev->zone_size_sects))
> +		return sect >> ilog2(dev->zone_size_sects);

As a separate patch, I think we should really have ilog2(dev->zone_size_sects)
as a dev field to avoid doing this ilog2 for every call..

> +
> +	return div64_u64(sect, dev->zone_size_sects);
>  }
>  
>  static inline void null_lock_zone_res(struct nullb_device *dev)
> @@ -62,10 +65,6 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>  	sector_t sector = 0;
>  	unsigned int i;
>  
> -	if (!is_power_of_2(dev->zone_size)) {
> -		pr_err("zone_size must be power-of-two\n");
> -		return -EINVAL;
> -	}
>  	if (dev->zone_size > dev->size) {
>  		pr_err("Zone size larger than device capacity\n");
>  		return -EINVAL;
> @@ -83,8 +82,9 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>  	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
>  	dev_capacity_sects = mb_to_sects(dev->size);
>  	dev->zone_size_sects = mb_to_sects(dev->zone_size);
> -	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
> -		>> ilog2(dev->zone_size_sects);
> +	dev->nr_zones =
> +		div64_u64(roundup(dev_capacity_sects, dev->zone_size_sects),
> +			  dev->zone_size_sects);
>  
>  	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
>  				    GFP_KERNEL | __GFP_ZERO);


-- 
Damien Le Moal
Western Digital Research
