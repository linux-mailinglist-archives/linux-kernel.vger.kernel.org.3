Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A33583760
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiG1DPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiG1DPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:15:00 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF9D5C349
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658978098; x=1690514098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V9Bt9U8xCLdifnqBhnRTi+jyLLn32+9OAJoJPTVsyn0=;
  b=WIgzDTLWduEnX5zYnon8OTnJILX9N7L9D9jTKf1sKMmt6YYHJ9OBN9OQ
   VdAA/2DeXFjPhSEQVxj8jJvfP3H5EWg0ab5Qz59wHsOyXT+M1k4G6tcpf
   ALQrM7iku2EQF1ryB3OXKNj400SadHdzS+5+F3oz9nXbwdU6oCSVTGsMf
   L5ISF7vtHg5kbytEQ29wWRtjiCtvEvmSTY0FVrzvbOj7DL5E8F99H5KHg
   oeXRnB6duwuoSzbT0mgeWwGB6mHjqsl2lSFAkoWCazD3TpqXzO5SuFFpi
   pyT7HTaiiIS7vMf2X0cbRJABJvel7VwkHUjFj53DVn6IDlCB680pQ5PUU
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="212066826"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:14:51 +0800
IronPort-SDR: kBnyk4KpF7AHkv8chMxQwiFT0fSao/Ys6g/ThBQuc75wAFV/ZFeyDhYaADftrA0sobCUZGTn4Y
 s9GfuKjSPVpHG1nTzhOzL5+l28R3wo6SwVCCnZ/VRADt394grwMNhVbnBRVKz/8URvjkm2L8o1
 ouAz8aL7oqQVzGxjZryoVlZH+Cn9jvVNRjLZs4oGRxdHIrvGSthygQHaYMPWc+PcR63vMJTY5s
 pRAtkdtF4gweuQgIDpc52fhhmJ0pqLdI6CaUq3JW4j6LRYLpAyd32FcX8qA2++W907nRqEPHs3
 +zVV+TFOI1CIy8eIMUXILEYH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:30:58 -0700
IronPort-SDR: KpF8zHJ/50N6dI5hNB3f67sdTe8IHqSeZ4J/VTDtJywYgTbuwydxa29iWG3IVTBDHB5y2SQUKm
 ugJIkNaNcV5t9T/EGiSfSfILgI760CeTsdIJtTnC2KOdP52VcAVb9Cu+yi/5k/39/Ws25EEG21
 WWCqtVNDp05tQ22tLTGr/kwlgBosBZ+58xAtRpkVplI5P4mL0nlwEal5dX0UEEPzKbe7n+MSPz
 LSixivfNJ2vSn7LobJADhKMrvTnbtzkyIHBMTOjFuJijYXMZePe0Z3dRF9vAG8jq1B0qq/WJgt
 HvI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:14:51 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbNp0sx8z1Rwnx
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:14:50 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658978088; x=1661570089; bh=V9Bt9U8xCLdifnqBhnRTi+jyLLn32+9OAJo
        JPTVsyn0=; b=muqLFW9oCZrGmwA88CMAX3StJrDnBNGnuHz8ILJFLXO3hUFE+dF
        fSLo4ZmR6g0gLggQqVwLkom7EgnXX0ejzpN2TDO1xlfHCGq5Xj67O/j/NbeoZnGJ
        1NW5eFMb8ywhQ7/pxw2w7BIxuLzAyqOrxH75UxsfEc/b7yY4lC4PS7mBFI++fVxz
        LWFury831jls0EiqkzO2YZlDx/bDloxhU+jVQHAemBXwysfymHlfojwgeTN7WeEo
        jnVaWoYaElOPqzYIb/e9jdawqh7YYxvWSKMhDlMMzqGnIyUroFheQgVl8PLzMf5+
        hfu+j/R/IdQv/gcOryR0tLq2sh2j+6CLwbg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Phzwo99g93Xf for <linux-kernel@vger.kernel.org>;
        Wed, 27 Jul 2022 20:14:48 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbNj19KLz1RtVk;
        Wed, 27 Jul 2022 20:14:44 -0700 (PDT)
Message-ID: <d32ed9f5-9342-e3e6-ad84-bdf40eac5b0c@opensource.wdc.com>
Date:   Thu, 28 Jul 2022 12:14:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 05/11] null_blk: allow non power of 2 zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162251eucas1p12939ac3864fd8705ae139eb2d1087d8f@eucas1p1.samsung.com>
 <20220727162245.209794-6-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-6-p.raghav@samsung.com>
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
>  drivers/block/null_blk/main.c     |  5 ++---
>  drivers/block/null_blk/null_blk.h |  6 ++++++
>  drivers/block/null_blk/zoned.c    | 18 +++++++++++-------
>  3 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index c451c477978f..f1e0605dee94 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1976,9 +1976,8 @@ static int null_validate_conf(struct nullb_device *dev)
>  	if (dev->queue_mode == NULL_Q_BIO)
>  		dev->mbps = 0;
>  
> -	if (dev->zoned &&
> -	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
> -		pr_err("zone_size must be power-of-two\n");
> +	if (dev->zoned && !dev->zone_size) {
> +		pr_err("Invalid zero zone size\n");
>  		return -EINVAL;
>  	}
>  
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index 94ff68052b1e..ece6dded9508 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -83,6 +83,12 @@ struct nullb_device {
>  	unsigned int imp_close_zone_no;
>  	struct nullb_zone *zones;
>  	sector_t zone_size_sects;
> +	/*
> +	 * zone_size_sects_shift is only useful when the zone size is
> +	 * power of 2. This variable is set to zero when zone size is non
> +	 * power of 2.
> +	 */

Simplify:

	/*
	 * zone_size_sects_shift is used only when the zone size is a
	 * power of 2 number of sectors.
	 */

But personally, I would simply drop this comment. The name is obvious and
the code very clear.

> +	unsigned int zone_size_sects_shift;
>  	bool need_zone_res_mgmt;
>  	spinlock_t zone_res_lock;
>  
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index 55a69e48ef8b..015f6823706c 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -16,7 +16,10 @@ static inline sector_t mb_to_sects(unsigned long mb)
>  
>  static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
>  {
> -	return sect >> ilog2(dev->zone_size_sects);
> +	if (dev->zone_size_sects_shift)
> +		return sect >> dev->zone_size_sects_shift;
> +
> +	return div64_u64(sect, dev->zone_size_sects);
>  }
>  
>  static inline void null_lock_zone_res(struct nullb_device *dev)
> @@ -65,10 +68,6 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
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
> @@ -86,9 +85,14 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>  	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
>  	dev_capacity_sects = mb_to_sects(dev->size);
>  	dev->zone_size_sects = mb_to_sects(dev->zone_size);
> -	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
> -		>> ilog2(dev->zone_size_sects);
>  
> +	if (is_power_of_2(dev->zone_size_sects))
> +		dev->zone_size_sects_shift = ilog2(dev->zone_size_sects);
> +	else
> +		dev->zone_size_sects_shift = 0;
> +
> +	dev->nr_zones =	DIV_ROUND_UP_SECTOR_T(dev_capacity_sects,
> +					      dev->zone_size_sects);
>  	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
>  				    GFP_KERNEL | __GFP_ZERO);
>  	if (!dev->zones)


-- 
Damien Le Moal
Western Digital Research
