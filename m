Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD8258F167
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiHJRRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbiHJRRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:17:21 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D548276C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660151812; x=1691687812;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZrG3QXHf6OeZyZRRDOE430GTJ+vsvuzlYkLafNLMIzY=;
  b=WOOznSXce36aTwA1SAs9xEAvsJVFd0GIC5kjpHhKRo6UDUlfkHGw4uBX
   40jclD1Aq99FVLjHei1fHaKR8jRIzxd6yQ5wgHnIfx31HTmCoiaYH0nah
   PNsUj1zYX4VBTaPv6cJMln51D88XNIVFkRuzQanMquMLp++aroGcXDP1p
   V1/MAbGHC/nji2fbcdfwIqDBxRUcgtbIj/Y63RxyJ0/zt55OJbA0SgEXW
   oB5JRlsOHeZQcaXxfLb8iioxBZIdJs/L3nqYKa3/ryulmbCqF1wZrNz5B
   afcQ4KBcI8QO7TYHGgzpWAxisZY7qkd/er5sPsssCBauk4VA8EL9p6/G7
   w==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="213385568"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2022 01:16:44 +0800
IronPort-SDR: VlAY+d8fgrJOvKDbXrSZQCHsO9dpHUIneqatWBPD82c3C1rwaJ9U5NStmtEo9cxGjYVxYEtH4y
 /f6aA3gjtZV4V9QGjHhtEGrm6AZcDM7i2TYRPApIXqAug6MLlKiLGVSI/DC/P3nmFLNfGX7PC6
 hGsocMdzlBlhG5P3bej35EJxZWX0V3i0Pky8BIKFhYa0dXDXOwRiOyHO5Hqcu1kNob4XV6Il/h
 CAGkIk+3IbVIp8a/ly2s30VCLKKrJAlgckoWMTmrIZwo3oelhDDYl2VhV1KHp4tSN/PnvSMc4m
 9l1Q+7rjEIYe6sC/f8ZmePD5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 09:37:40 -0700
IronPort-SDR: 0P3YHujR+I2GLd6va3Ht321LlFdUKC7ctjf+FKtD9kqozf49oHrhWyxDV7X61LCZ/udxlzOhXZ
 1szYKvBTWF5RVd6rK7cvSDQ/rC95YfLaD0HmHXk4U7pOohThnMFuuiYs0JPbCGiPtNpIRej8bN
 9PUK6JqjpgElrO8U7UYxvfx4agJCJq4lmyQEpM5bvZMBR1RUvHtqPCNvRDiALtrtMBISsgJi3y
 naLDJZyNlYOKeeyZQIw+3ocKWpShCc8Q4NKn0Hsosz1dyxN9g7HVpD/zMPMkeUv9Z6Icgw8gHu
 CfY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 10:16:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2xSF40rGz1Rws8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:16:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660151804; x=1662743805; bh=ZrG3QXHf6OeZyZRRDOE430GTJ+vsvuzlYkL
        afNLMIzY=; b=q8E5j2biq7+aqtAPZCbX3uzABdCPq3/W5AC6e3lSgeyurt33e66
        2TKqgrRhJBz924jF27EslwtHBD+j9JFqfG7kSTu2r9qKbwG3fQ9f5MLkt0bGDFzL
        7J8aO0Jt4kYGSI9+bBsk00OqjgLIM4+Ir8bqlCCzhVKjT7bhrPKe0TqbywLC98ru
        q+eF4mGZgxDhd1iVzqOwjZj9Bm32j8o9mkFInce7Iwe/IPJ0E9Hcmc75Q+0bD+86
        s8pe4eRc+n6iu+kkii5juFTDKLjw4Rb7R0KaF5tUz1k+c/VMdnMVczCqTmOibpQN
        5AAE9asQpxtUlD4zvMoDqsvew5bHTZH27wA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MMxGklDGR41O for <linux-kernel@vger.kernel.org>;
        Wed, 10 Aug 2022 10:16:44 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2xSC1pJVz1RtVk;
        Wed, 10 Aug 2022 10:16:43 -0700 (PDT)
Message-ID: <3ee96421-94b2-12d8-9aa2-83d4f7027694@opensource.wdc.com>
Date:   Wed, 10 Aug 2022 10:16:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v9 12/13] dm: introduce DM_EMULATED_ZONES target type
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094815eucas1p2dfab477daf4f2eb05342d756fdf7f14d@eucas1p2.samsung.com>
 <20220803094801.177490-13-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220803094801.177490-13-p.raghav@samsung.com>
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

On 2022/08/03 2:48, Pankaj Raghav wrote:
> Introduce a new target type DM_EMULATED_ZONES for targets with
> a different zone number of sectors than the underlying device zone
> number of sectors.

"zone number of sectors" is strange. "number of sectors per zone (aka zone
size)" is simpler and clear.

> 
> This target type is introduced as the existing zoned targets assume
> that the target and the underlying device have the same zone
> number of sectors. The new target: dm-po2zone will use this new target
> type as it emulates the zone boundary that is different from the
> underlying zoned device.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

With that text fixed, looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/md/dm-table.c         | 13 ++++++++++---
>  include/linux/device-mapper.h |  9 +++++++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 31eb1d29d136..b37991ea3ffb 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1614,13 +1614,20 @@ static bool dm_table_supports_zoned_model(struct dm_table *t,
>  	return true;
>  }
>  
> -static int device_not_matches_zone_sectors(struct dm_target *ti, struct dm_dev *dev,
> +/*
> + * Callback function to check for device zone sector across devices. If the
> + * DM_TARGET_EMULATED_ZONES target feature flag is not set, then the target
> + * should have the same zone sector as the underlying devices.
> + */
> +static int check_valid_device_zone_sectors(struct dm_target *ti, struct dm_dev *dev,
>  					   sector_t start, sector_t len, void *data)
>  {
>  	unsigned int *zone_sectors = data;
>  
> -	if (!bdev_is_zoned(dev->bdev))
> +	if (!bdev_is_zoned(dev->bdev) ||
> +	    dm_target_supports_emulated_zones(ti->type))
>  		return 0;
> +
>  	return bdev_zone_sectors(dev->bdev) != *zone_sectors;
>  }
>  
> @@ -1645,7 +1652,7 @@ static int validate_hardware_zoned_model(struct dm_table *t,
>  	if (!zone_sectors)
>  		return -EINVAL;
>  
> -	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {
> +	if (dm_table_any_dev_attr(t, check_valid_device_zone_sectors, &zone_sectors)) {
>  		DMERR("%s: zone sectors is not consistent across all zoned devices",
>  		      dm_device_name(t->md));
>  		return -EINVAL;
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 04c6acf7faaa..83e20de264c9 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -294,6 +294,15 @@ struct target_type {
>  #define dm_target_supports_mixed_zoned_model(type) (false)
>  #endif
>  
> +#ifdef CONFIG_BLK_DEV_ZONED
> +#define DM_TARGET_EMULATED_ZONES	0x00000400
> +#define dm_target_supports_emulated_zones(type) \
> +	((type)->features & DM_TARGET_EMULATED_ZONES)
> +#else
> +#define DM_TARGET_EMULATED_ZONES	0x00000000
> +#define dm_target_supports_emulated_zones(type) (false)
> +#endif
> +
>  struct dm_target {
>  	struct dm_table *table;
>  	struct target_type *type;


-- 
Damien Le Moal
Western Digital Research
