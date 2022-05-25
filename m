Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492DF5346F5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 01:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbiEYXN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 19:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiEYXN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 19:13:56 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2DAA76C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 16:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653520434; x=1685056434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eam838EaJRwK9zb6IDgNxPhRl2ur9Z3r3Bih8oVIUd8=;
  b=qHBdrHq7rjG6kToxb3hLh1NxLnhyotrHu3HT27OamjRy2tun3WahbA1i
   Eic+M0y6fFAEvNnstUZxOG5u+gIMpz34v/q+DgM9dbbukeLO3LCFi67VK
   bfqsXn/cwFIltXUWMOpdNODc/sEfs4dWZRawSZ7OGTjdNy03i4OzcKwi8
   AAnVXi9DNgQleJhbTEqIs4JGthPvhHjhNEL5514w9/7gB4W+NKHdtPfGr
   58Sh14yPSh1WhpQ4lyVC5aA1kGsgfofFT44BJzbOXsr+Tc5urOaNSleZT
   1IUYa0iSPVy4Xd4MBHKTp5SgSJN22fAZJB/pQgLE5AFvaLbg5JdL5CL5B
   w==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="305680424"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 07:13:54 +0800
IronPort-SDR: tUVL3cNP8VfIoy9LJJa5TPD8WbGBZWH7rDv9/j/4Y/kneMa/q3mMzx33cj3CvtAs6cXQdx6f9S
 eyFZXZreO9/gI16wU0Sw520UAgU8VThO1fCDtvSBR8rnhOoydr0PwPNAuycyKMnfZcBFty9NLS
 iSWTNRx2wyxuHTe2Gk5xvoMJSaMLpmQfzr57KtXo1lHtCzwdQEYGwF52MnmmHs9rnlFkhPIULK
 bBhanyhZeiIDgsFfQ1OM80cgudcdzWmxJn+AmC3QZFK+yEI2mvm9rJdwnXpB9J4IzzgphTloy0
 lgofxDQqtAiTypaTnBFbFsgX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 15:33:25 -0700
IronPort-SDR: 0ERJoLrcnK+SUbvpqtHue4VqY9MmFtFOvl7Jv/sR5Zfrp+gEtGvLY1a8DO0siohmkz2C0RgC//
 FQUz8w3YD11OHzQSRIO9zqmfpzhLPXphYA5fhSqaKJSjAfHmTgvnvnNJ/J0P4FsCXLkgZ7mOaq
 3Rq5IdZO/wmshiORk0kVmcF065P4tvF01/qQO3FFgOkjDRX6uJA2EeB6wlE0VQnpzOajXxX8Ec
 pkNPJqg9miqJWNm5iNvwDbSnO9gFA+BkIJOruNjPYnJkH/UjAgdnZ4x93hv/zN8vIaOjFiK9Ps
 sXk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 16:13:55 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L7n1t11nvz1SVp4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 16:13:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653520433; x=1656112434; bh=eam838EaJRwK9zb6IDgNxPhRl2ur9Z3r3Bi
        h8oVIUd8=; b=MH3qrczSSEt7xHyvThV5z8FeiBgRXDKry4Drw1TqJl3BSqFG+Zx
        P3ngOqNGwroS4Du2LnDA4L8o4amixasMJVutO8QpAUjXIM/4x9Ocltnh/9EmK7Fb
        8/0eeirBarsL7a7fDgu/SnOk2YgG57P3/7jKxAghclbupCMh6CXjGa8w8T3qtnLQ
        L5rSs0pkk4yLIH/N/O4nv9Ornln0aQeISTYiFTDyocO5u6+MVk2poxtSiyMNMlov
        n9ZXVtGjtIMkAAy7ybgnGLHnWLT2k6oJT8wqlY68XA6O18AnDV4UBuQSwR1TPCCP
        f794kjEXcUXAuoSWcPqm41miavrLzgB1XdA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bt9r4NwT6qJM for <linux-kernel@vger.kernel.org>;
        Wed, 25 May 2022 16:13:53 -0700 (PDT)
Received: from [10.225.163.54] (unknown [10.225.163.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L7n1p4sHZz1Rvlc;
        Wed, 25 May 2022 16:13:50 -0700 (PDT)
Message-ID: <9703ca4c-33cf-cb3a-b46b-6b0e5537cfd6@opensource.wdc.com>
Date:   Thu, 26 May 2022 08:13:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 8/8] dm: ensure only power of 2 zone sizes are allowed
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        snitzer@redhat.com, Johannes.Thumshirn@wdc.com, hch@lst.de,
        hare@suse.de
Cc:     dsterba@suse.com, dm-devel@redhat.com, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, jaegeuk@kernel.org,
        gost.dev@samsung.com
References: <20220525154957.393656-1-p.raghav@samsung.com>
 <CGME20220525155008eucas1p2c843cc9098f2920e961f80ffaf535789@eucas1p2.samsung.com>
 <20220525154957.393656-9-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220525154957.393656-9-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 00:49, Pankaj Raghav wrote:
> Ensure that only power of 2 zoned devices are enabled for dm targets that
> supports zoned devices. This constraint can be relaxed once non power of
> 2 zone size support is added to the DM layer.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm-table.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 03541cfc2317..2a8af70d1d4a 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -251,6 +251,12 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  	if (bdev_is_zoned(bdev)) {
>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>  
> +		if (!is_power_of_2(zone_sectors)) {
> +			DMWARN("%s: %pg only power of two zone size supported",
> +			       dm_device_name(ti->table->md), bdev);
> +			return 1;
> +		}
> +
>  		if (start & (zone_sectors - 1)) {
>  			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
>  			       dm_device_name(ti->table->md),

I thought the agreed upon idea is be to add a dm-linear like target to
emulate power of 2 zone size so that we can keep btrfs and f2fs running on
this new class of device. So why this patch ?

The entire series as is will fragment zoned block device support, which is
not a good thing at all. Without the new dm target, none of the current
kernel supported zone stuff will work.

The zonefs patch is also gone from the series. Why ? As is, zonefs will
break if it is passed a non power of 2 zone size drive.

-- 
Damien Le Moal
Western Digital Research
