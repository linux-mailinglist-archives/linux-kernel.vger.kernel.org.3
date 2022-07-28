Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D859583777
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbiG1DU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbiG1DUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:20:37 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D9D4B0D8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658978434; x=1690514434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hgHCcX+r6a1k41oBN3+yo/cGQgZRJNC14DbPvta/5ZU=;
  b=b65pF0Gy959tAoU5enK9QBe1ZY3JgaoViaJB4s0uob/4QWpeueLMU4tp
   UaZeBQEzqYUxPhTIJdrRCmJ/rcQvfEEM8tOL50tT9eY2lM+QEX8xg9ej5
   vYAnwrTAaV0KT5HGS9vxR68lQ78CVcsH7fOXETXZQLQgKlVNdVRUXu4HJ
   j7Q77b6tQfvrrCCVflMlzsAfp041ZliQfQQFkMY8B8DpuWtpkf42fB8qM
   cwFu/Z3Aq8pPztbA1QMQzzVv9bMjPbkwXxJNPUMkwD/K6Ao6xIp3q9pmr
   0iYOBSsTS6tY5cIJAQT6yQieBlEQO1MinoE6dBbKDPW8ghnLmc8pTuveX
   A==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="207109476"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:20:33 +0800
IronPort-SDR: syUwQdck2bNxXKWL70MfHNr2Qlhi+RJMa0LNmbSZY4ed+Kz34Yb2THC2RcJs/YHRhjkI5k+uVD
 3PMTLGsJVFS2CDfEjMsnbJiN/6tvhFekB5P2/LPbd9OCNOIdkRPQqVfh+DJdvs8lFAGkQ+9jGU
 bGEJhlFaQq4E3W36XXGxrQ6KOqedHY0o5mId0mSEyCQlFx1qJzrsUTq5m4qP0USLAJBFA7gpwQ
 aksEqd6/h+p6jENfBcQOeLJ1nJotPSPXmRm4jVO7J4LmYixVCfrhjSm8m+uK3PZR6BTClNnw1J
 5vOtZ1x/N7XjAKoC16WEkC08
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:41:45 -0700
IronPort-SDR: 5uvtx0rz6GCFCovOurt6Kgxu7AtiG2yTxG6QsQkAMyRPSa9FKnUK26wvcaraqR0SOc990LwZL/
 7CyNld950geVb3vYoasCq0LXYdqNv6+T5aZzkaoIIuTUEXf2FTYo3xEqeKUPwZ5ZzNjnIfAG4V
 2tn2oFosCPJyEE2hLfHzwm6TK+3I1zb+M2T0yx7Oeq8df47NUK8sQBcoxxZRZ9V59Auef+hY8F
 L+Kzv5b9dyl6R0sKunM2fN3pTsfAi76E/mMma7JCPjxysEwRtjC46FTGLvzwAEFf2dXMPcMtey
 PXk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:20:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbWP6CRtz1Rws4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:20:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658978432; x=1661570433; bh=hgHCcX+r6a1k41oBN3+yo/cGQgZRJNC14Db
        Pvta/5ZU=; b=NKStJLOIOnUZKambVwNOSsQrcKFb7GHwVZOLxOjRjCMmL1Yx+9L
        LQ0ITW6boOQntA60H4ee2oW3m4m3speBRffYVVM5NTXAydmLZtkVExzFd6bvlzEd
        He/vsJaY6a9NKqUMpY/9kW6JffapuGVk+NicNR4ALQUfQ8HZJNFzt46URym/5KCG
        u91hHGZ1llYcCsI2cHxw2xWYetBKu4uVUQw2xqW4+0uYAD1S0EK3BoIR6xXl0fcK
        nm+ppd75mFR9x1kvy6pZiZNRYM6cJqkb8frFWy3ip0Foe85MNkJhqKYkDZP+cz+7
        Hh59MC/ED6mwR+u9hB/zaYG6zUOd7q+tExA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PiwBaHqhVW06 for <linux-kernel@vger.kernel.org>;
        Wed, 27 Jul 2022 20:20:32 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbWK6WzGz1RtVk;
        Wed, 27 Jul 2022 20:20:29 -0700 (PDT)
Message-ID: <63350fdc-9cc8-3034-c8d6-8dcff50780f4@opensource.wdc.com>
Date:   Thu, 28 Jul 2022 12:20:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 08/11] dm-zone: use generic helpers to calculate offset
 from zone start
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
 <CGME20220727162254eucas1p1fd990f746d9f9870b8d58ee0bd01fedd@eucas1p1.samsung.com>
 <20220727162245.209794-9-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-9-p.raghav@samsung.com>
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
> Use the bdev_offset_from_zone_start() helper function to calculate
> the offset from zone start instead of using power of 2 based
> calculation.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/md/dm-zone.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index 3dafc0e8b7a9..31c16aafdbfc 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -390,7 +390,9 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
>  	case REQ_OP_WRITE_ZEROES:
>  	case REQ_OP_WRITE:
>  		/* Writes must be aligned to the zone write pointer */
> -		if ((clone->bi_iter.bi_sector & (zsectors - 1)) != zwp_offset)
> +		if ((bdev_offset_from_zone_start(md->disk->part0,
> +						 clone->bi_iter.bi_sector)) != zwp_offset)
> +
>  			return false;
>  		break;
>  	case REQ_OP_ZONE_APPEND:
> @@ -602,11 +604,8 @@ void dm_zone_endio(struct dm_io *io, struct bio *clone)
>  		 */
>  		if (clone->bi_status == BLK_STS_OK &&
>  		    bio_op(clone) == REQ_OP_ZONE_APPEND) {
> -			sector_t mask =
> -				(sector_t)bdev_zone_sectors(disk->part0) - 1;
> -
>  			orig_bio->bi_iter.bi_sector +=
> -				clone->bi_iter.bi_sector & mask;
> +				bdev_offset_from_zone_start(disk->part0, clone->bi_iter.bi_sector);
>  		}
>  
>  		return;


-- 
Damien Le Moal
Western Digital Research
