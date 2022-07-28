Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901A058376E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiG1DSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiG1DSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:18:15 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3632D1EC56
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658978294; x=1690514294;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QUbay5Dzz476bfBAfIiryaPk/r7bibYqxCGIlUR7KkE=;
  b=JL8qeeAwuFj3pfPxSqz8+vRQkRaDPbFvUHwwuhwLmC1MQ6jMwNw07X2h
   xNd/gOaDia4YoM+XD3uiwcpSERcZpN+xszRwjYNLQGBoFUKgK3Jm4s25X
   HCWB75G5tasZm4BdgIdJrIxxpauXtHFvI75+eiRFs0vCGsdlhRyFQyf0z
   umww5SNHQhMdgjUr8hEVPUJw2i8TV3MkJacI+5p5RsnAKfbBPyva9LCRU
   mJQBd+BiDNQgBQP/hYLNmnbmkpWLTHzk1gKLsrcroD7ulbTVKWIUgL3Ib
   8ES6bPsscOvGZBWqo0mbW/jyiShZtlyuNhK5orFXtrd3attZ1SWNZ6esq
   g==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="207730980"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:18:12 +0800
IronPort-SDR: 4T+hnDf0risrPU4QXiUowPwhB26WxW7AgBX2cKkXNt6ZuKiIShBqbdxsHU5Pgw/8Htb+cFQaT4
 kZTXqdO5LsUjQMfUythx0d6lQs/qr5/+plE4PvBHgbt3bd0y7XRg1FyhvpYhRfPN0hmh2OQ904
 NY593hgtRzvZG8dJtpyD+dUuPKTHyyOCuPTkIHAghjVkyyULSRNXwOU+7d5NYhvQZCIfFlN/0U
 nMHYxHDKv9kZUb8XCuRb4mr1pH5TGI85198fgQsUKR4U7SmmDlse8Q3oSyF4+nZvjQJ3Rm6Dnp
 jyGYeqtC6s4kOPw6lgDi2DuQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:39:23 -0700
IronPort-SDR: JGWpVhV0wWDfzpb79hJ3DoLDl3ffny9mnrkmOOxEOcFtB9Dpi5PLLGmytOAAjo/AQfwn3y0SkI
 SOVDkrP4t6wN7G+HkCNXhW60qwJXAv9OlP08GSNV5FoWOebnN6Wv2sUZR/ZFt9/+hAL1vejiHE
 McTWxHLZ2AgRMUqvh62ylVMQ5K2l4hLkkDIBrqascc4vuiM+wHSrkT/UAHG3Gr4rogPFpzD4jf
 6stDppUWB4jc0KjUu6f6u2kYBWkQY69hq8wIH/6elBMGrFxlZL4cz6pPff0zrfwIKzuW4TqDXe
 S04=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:18:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbSg68dKz1Rw4L
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:18:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658978291; x=1661570292; bh=QUbay5Dzz476bfBAfIiryaPk/r7bibYqxCG
        IlUR7KkE=; b=lKBs5qRnYH5ts92SJQZPDRWNJklAKbXmn1WcOWOwkVRujX7YWOK
        DZ+7Asp8HND14dbFptTMkS3rmN57c6Mt2aOJ4MB9hEpYgiq7rBt0bfxD/nWX9wB7
        fr5wwZTPZAqNr8Qchphg84x974x8IeuBpFQ/UJw1NQ2x0el8dNh5bRP6UV2T+aO1
        qpx0B/uLh+UhdveaDjEf9rXYLdcG6wPwrTIexPF64AyMi8AMqCoFEVkzAfoO5FrD
        2uRsKfRcarmcTWhHalHv2cqa7D8mUC8RisldkJTuw4la5IZCxXwQUpAv/MlgPaWX
        Lq/8193sxFHTRmVFt6DQ/6qR+cV+OTWB5TA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Euk50aZ53ddI for <linux-kernel@vger.kernel.org>;
        Wed, 27 Jul 2022 20:18:11 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbSc2CCQz1RtVk;
        Wed, 27 Jul 2022 20:18:08 -0700 (PDT)
Message-ID: <6f93c6f4-240d-2d61-c53d-b5e66895ebcf@opensource.wdc.com>
Date:   Thu, 28 Jul 2022 12:18:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 07/11] dm-zoned: ensure only power of 2 zone sizes are
 allowed
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
 <CGME20220727162253eucas1p1a5912e0494f6918504cc8ff15ad5d31f@eucas1p1.samsung.com>
 <20220727162245.209794-8-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-8-p.raghav@samsung.com>
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
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> dm-zoned relies on the assumption that the zone size is a
> power-of-2(po2) and the zone capacity is same as the zone size.
> 
> Ensure only po2 devices can be used as dm-zoned target until a native
> non po2 support is added.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm-zoned-target.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
> index 95b132b52f33..16499b75c5ee 100644
> --- a/drivers/md/dm-zoned-target.c
> +++ b/drivers/md/dm-zoned-target.c
> @@ -792,6 +792,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
>  				return -EINVAL;
>  			}
>  			zone_nr_sectors = bdev_zone_sectors(bdev);
> +			if (!is_power_of_2(zone_nr_sectors)) {
> +				ti->error = "Zone size is not power of 2";

Let's clarify:

	ti->error = "Zone size is not a power of 2 number of sectors";

> +				return -EINVAL;
> +			}
>  			zoned_dev->zone_nr_sectors = zone_nr_sectors;
>  			zoned_dev->nr_zones = bdev_nr_zones(bdev);
>  		}
> @@ -804,6 +808,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
>  			return -EINVAL;
>  		}
>  		zoned_dev->zone_nr_sectors = bdev_zone_sectors(bdev);
> +		if (!is_power_of_2(zoned_dev->zone_nr_sectors)) {
> +			ti->error = "Zone size is not power of 2";

Same comment.

> +			return -EINVAL;
> +		}
>  		zoned_dev->nr_zones = bdev_nr_zones(bdev);
>  	}
>  


-- 
Damien Le Moal
Western Digital Research
