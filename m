Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663C754C7FB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347725AbiFOL4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347722AbiFOL4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:56:34 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1EE14099
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655294190; x=1686830190;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hMa4C7BG2EJNxLf+4Ft9gsUe2natn5jOe4xtSlQ7Na0=;
  b=k9XIHOxIKcfv/BfIByai6+exVkd7ki6rBhzX8pwbjpFh5mx4NYqJUbs8
   xtne298w6BR6YZExRZP8XNwU/tCSouZLSxQCnbj1GwPvJpedAsWhSIJ6t
   Syy2iMpXXUDnNJbOSIcZrXP/PsQKq0WVPuaAKe+A5DNGYCTf+KAmcTSMG
   MkDE/AQ9DSIr7gxDB2gnEt0dQNdwGtdjlhiB+sphGOj60CRRoJnhUBenf
   OiBq9Dn9Z5wjnX6VRZnMTO7yRdhLZEbo2CtkVTsys5MOrNfG91j2t2o9p
   KJSqFlQByUak77rFvBSTfrJbGmlJB5DxaHieA7pa0CpabITHUL/UqK73E
   A==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="208073236"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 19:56:29 +0800
IronPort-SDR: df/r5LleIr9flh2U32KOnghLYgOuEX0ieQffTMF7jJA0GHH7q1dv1FDFBgSK9eoMxN2USc9LX0
 bLLiF9bk1oYxDv43K/2sT+xINGt80Z8KL9xVU7d1tJM6H3zpWf2GrJqm8amADHCQB/v+QjFsHi
 O59FOC8cqdkZJcZl9ogRngn/366uPOFpLzEouUplGhSVs8J0THup6EsVAaafB9XyMuXRswQiqp
 3ShOY//Hl1gf1iwQPilA01Zdg6voGiduLfFiKl0kNm+HgEd/FwQ8shk5FiF7Vpk2t3Nz9yZd2k
 g9cMVsBZj7ueo+p8c1uwFjde
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 04:14:54 -0700
IronPort-SDR: Zl+jPsxiuaHkSU5S4HFzXV+H20lc+pQytXxJhwgBfAANDjqoijgBYn3v0BbnXwy5mh4Ib568mR
 CoqPhg7N4h0XDUkLL+8tGRoprHnGX6coe/wFlS5McXE7nbZGZjgopEKawAPklo+5lZPLZtZ+Ba
 kQTcIzUYT2c8ttulSXXcehl00L3kvvRR9zPEsGWlq/9tRHOukBcM1/9spcWlTdTCeCSUuBeqZS
 47KCmcBrLGbnRjR533OWmS4ltZsoJVS4tlG/BON5KnZl6mgSQZTlhyfXbKsC2qpSySCA7wjlzr
 Nlw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 04:56:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNP0Y4cYdz1Rvlx
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:56:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655294188; x=1657886189; bh=hMa4C7BG2EJNxLf+4Ft9gsUe2natn5jOe4x
        tSlQ7Na0=; b=O1jVeGEiQVMCIS3Ud8cDz9MljRd9D9VkkVpPn8F4R/P/kyxOED6
        Nc12uVtcHw2LN2OIzYkqi6KYWbqHf+lTYHEgMoug1B6Hcrnd+IhpD1UQTufyUFLK
        YuRWZWOu0FQ7+9HMX9pimVOfk14bQ1wsAkI7yjCT1I92CluihrxNC6lZxZn+6e/p
        0QPs6Tds08jxxz+9d0cu+H2qFI+8l0NOroHVmXW57ZoNcd+YSIT2s8Z7YRsrO6eY
        2X8s0YXwbZNIPF/FtVgKBsP4FMrW+zRwxfFvLTkHaT9tZpFq/I5QYXlRF4RWrl0A
        stCWrg2hE+aFog4dpZeKIBkLNK5jjv3o7og==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id puXbhcyxouER for <linux-kernel@vger.kernel.org>;
        Wed, 15 Jun 2022 04:56:28 -0700 (PDT)
Received: from [10.225.163.82] (unknown [10.225.163.82])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNP0S6n1Sz1Rvlc;
        Wed, 15 Jun 2022 04:56:24 -0700 (PDT)
Message-ID: <4bafa68f-46b3-7a76-de70-377a0f9cf130@opensource.wdc.com>
Date:   Wed, 15 Jun 2022 20:56:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 06/13] null_blk: use zone_size_sects_shift for power of
 2 zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        snitzer@redhat.com, axboe@kernel.dk
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        gost.dev@samsung.com, dsterba@suse.com, jaegeuk@kernel.org,
        linux-nvme@lists.infradead.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615101945eucas1p16fa264e81d9b6027ff131dd311ed91e2@eucas1p1.samsung.com>
 <20220615101920.329421-7-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615101920.329421-7-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 19:19, Pankaj Raghav wrote:
> Instead of doing is_power_of_2 and ilog2 operation for every IO, cache
> the zone_size_sects_shift variable and use it for power of 2 zoned
> devices.
> 
> This variable will be set to zero for non power of 2 zoned devices.
> 
> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/block/null_blk/null_blk.h |  6 ++++++
>  drivers/block/null_blk/zoned.c    | 11 ++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index 8359b4384..3bc7cbf25 100644
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
> +	unsigned int zone_size_sects_shift;
>  	bool need_zone_res_mgmt;
>  	spinlock_t zone_res_lock;
>  
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index daf327015..5f929944b 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -16,8 +16,8 @@ static inline sector_t mb_to_sects(unsigned long mb)
>  
>  static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
>  {
> -	if (is_power_of_2(dev->zone_size_sects))
> -		return sect >> ilog2(dev->zone_size_sects);
> +	if (dev->zone_size_sects_shift)
> +		return sect >> dev->zone_size_sects_shift;
>  
>  	return div64_u64(sect, dev->zone_size_sects);
>  }
> @@ -85,9 +85,14 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>  	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
>  	dev_capacity_sects = mb_to_sects(dev->size);
>  	dev->zone_size_sects = mb_to_sects(dev->zone_size);
> +
> +	if (is_power_of_2(dev->zone_size_sects))
> +		dev->zone_size_sects_shift = ilog2(dev->zone_size_sects);
> +	else
> +		dev->zone_size_sects_shift = 0;
> +
>  	dev->nr_zones =	DIV_ROUND_UP_SECTOR_T(dev_capacity_sects,
>  					      dev->zone_size_sects);
> -

white line change.

This patch should be squashed with the previous one.

>  	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
>  				    GFP_KERNEL | __GFP_ZERO);
>  	if (!dev->zones)


-- 
Damien Le Moal
Western Digital Research
