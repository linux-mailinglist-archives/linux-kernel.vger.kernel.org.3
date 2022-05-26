Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45760534B38
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346607AbiEZIMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiEZIMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:12:17 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CB72495D
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:12:13 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220526081208euoutp0257f636d6bc0cb4a3688eb09b2b19deeb~ymXH-mw6M0361603616euoutp02A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:12:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220526081208euoutp0257f636d6bc0cb4a3688eb09b2b19deeb~ymXH-mw6M0361603616euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653552728;
        bh=sRas2qHYxGK26QnM0GFTIv2tqbVuA6ew52jA7d50Ke4=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=u4CNpUNBsZNfGY8XCXMlSrtQ6OEG7NfUmZhZeUrqECHG7F1B6gaUATwtK1mKRZREp
         NfckJQ+AMDp36iRSs6fx+52oYdwBwGG6uBxkH0KkgNGx7TGCMidkKw/7bzGI1K4gIq
         rOis8hnSW/Qq26mGEQOPFxdXiYA6EjKATknN89xg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220526081207eucas1p262ca8d7088c8d4898fe9d4be45008a35~ymXHoT8V80059300593eucas1p2P;
        Thu, 26 May 2022 08:12:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B5.78.10260.7563F826; Thu, 26
        May 2022 09:12:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220526081207eucas1p25fb941ce7f8344420295750bb810501d~ymXHKcZIZ1109011090eucas1p2_;
        Thu, 26 May 2022 08:12:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220526081207eusmtrp1b0614131c1302506df87eb12313c097c~ymXHJaB9E2331823318eusmtrp1c;
        Thu, 26 May 2022 08:12:07 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-09-628f3657ef99
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2E.35.09522.7563F826; Thu, 26
        May 2022 09:12:07 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220526081206eusmtip24929ef2f4ad0112677d59e7337e17df4~ymXG5LKB43167731677eusmtip2k;
        Thu, 26 May 2022 08:12:06 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.20) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 26 May 2022 09:12:04 +0100
Message-ID: <0bb57f61-9a33-0273-4b89-2cdf042e56dd@samsung.com>
Date:   Thu, 26 May 2022 10:12:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.9.1
Subject: Re: [PATCH v6 8/8] dm: ensure only power of 2 zone sizes are
 allowed
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <axboe@kernel.dk>, <snitzer@redhat.com>,
        <Johannes.Thumshirn@wdc.com>, <hch@lst.de>, <hare@suse.de>
CC:     <dsterba@suse.com>, <dm-devel@redhat.com>,
        <jiangbo.365@bytedance.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <jaegeuk@kernel.org>, <gost.dev@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <9703ca4c-33cf-cb3a-b46b-6b0e5537cfd6@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.20]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djPc7rhZv1JBkd2KlmsvtvPZvH77Hlm
        i73vZrNaXPjRyGSxZ9EkJouVq48yWTxZP4vZoufABxaLv133mCz23tK2uLxrDpvF/GVP2S3a
        Nn5ldOD1+HdiDZvH5bOlHptWdbJ5bF5S77H7ZgObx87W+6we7/ddZfNYv+Uqi8fm09UenzfJ
        ebQf6GYK4I7isklJzcksSy3St0vgyni98j1jwSnxinnzNrA0MJ4R6mLk5JAQMJGYt/04axcj
        F4eQwApGiZltP9kgnC+MEvfObWEDqRIS+MwosWF2YhcjB1jHvle8EDXLGSVePT8N1QBU07zm
        JZSzi1Hi9qzfYN28AnYSc9uWsIDYLAKqEnf2NDNCxAUlTs58AhYXFYiQWNn6BswWFvCXOH77
        LhOIzSwgLnHryXwmkKEiAvMYJeb9+A/mMAvcB9rw/AILyE1sAloSjZ3sIA2cAm4SFxafZ4Vo
        1pRo3f6bHcKWl9j+dg4zxAtKEtt+mUD8Xyux9tgZdpCREgK3OCXuXO1mgUi4SHQtWMQOYQtL
        vDq+BcqWkTg9uQeqplri6Y3fzBDNLYwS/TvXs0EssJboO5MDUeMo8bPxGtRePokbbwUhzuGT
        mLRtOvMERtVZSEExC8nLs5B8MAvJBwsYWVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIE
        pr3T/45/3cG44tVHvUOMTByMhxglOJiVRHgvPO1NEuJNSaysSi3Kjy8qzUktPsQozcGiJM6b
        nLkhUUggPbEkNTs1tSC1CCbLxMEp1cAUcvySRJi2Rq69+MXfAq+knJ2PaMwr/3pZS+nIFwtD
        FdkJEwoZJDpX7tctmjf5PHvUvQehZSbPk/qVVU7usRLqNxB5O1F73UKbyQqV/Cq1M3anR1xQ
        cjuWYXlzYd0ENQ3DZ/z37/3MfiOXMN3y3fbjuy1OB+yTyuA1E7Hl4rgQcfLQf6aCzVXlAZvV
        bumX3A1syd+30Kf7xMfkr1HqBYab/obb+YbELrWrLDyd/T1wks2HfZNy/d+qmsg7LCj73JtV
        9NVaRKueP/JC3HKRsEvb7tr3KMuUvnKSjCnscjA+dJ/BUvR/ptflTuXDNeWi12R74ztr3rdm
        KVxlO8fcMyFzhp7lqYZZ/W9d2DJElFiKMxINtZiLihMBgYDfpuoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42I5/e/4Pd1ws/4kg3vnWS1W3+1ns/h99jyz
        xd53s1ktLvxoZLLYs2gSk8XK1UeZLJ6sn8Vs0XPgA4vF3657TBZ7b2lbXN41h81i/rKn7BZt
        G78yOvB6/Duxhs3j8tlSj02rOtk8Ni+p99h9s4HNY2frfVaP9/uusnms33KVxWPz6WqPz5vk
        PNoPdDMFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp
        2yXoZbxe+Z6x4JR4xbx5G1gaGM8IdTFycEgImEjse8XbxcjFISSwlFHi16MLzF2MnEBxGYlP
        Vz6yQ9jCEn+udbFBFH1klLh4tYEdwtnFKDH33AQ2kCpeATuJuW1LWEBsFgFViTt7mhkh4oIS
        J2c+AYuLCkRIfFo2gRXEFhbwlZi+8xyYzSwgLnHryXwmkKEiAvMYJeb9+A/mMAvcZ5S4/fwC
        C8S634wSPff3MIMcziagJdHYCXYfp4CbxIXF56EmaUq0bv/NDmHLS2x/O4cZ4k8liW2/TCDe
        qZV4dX834wRG0VlI7puF5I5ZSCbNQjJpASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMB0
        se3Yz807GOe9+qh3iJGJg/EQowQHs5II74WnvUlCvCmJlVWpRfnxRaU5qcWHGE2BgTSRWUo0
        OR+YsPJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpjKi22z3hlt
        5Yv7I7a81yZKnN+rf9GcV9Kdod3Z8kGGt9/nfdXmWvHBiufWo5L8/UKH5Wq3XWNZELW08uHG
        DYwPz3DMnXlepSI+U9l/Q6DAlOffBUNPhrNx7CtL53w2S8d+4eyHPfuyuo9+CrhzgOX4uerP
        InqpynXMBp49KYcVz2pfP7xX9USyb0TDTZZELSXzj6dW6+c8Oj5d1Z61ZJGYyTquldqlq1dn
        1V7Y0bvgtsvOEqeZGzgu3BYuO3Uka0Ly/VjnxkZ+9ydV/Xem31jR+e/lHjP+ufNO3E5mcbHW
        yjwxh6M8NqNRPkn7XRPL3QAZaSu3uQ4cD28H8s/ZvTi3PvbYpJu7OY9djLnIlaTEUpyRaKjF
        XFScCABGat9hoAMAAA==
X-CMS-MailID: 20220526081207eucas1p25fb941ce7f8344420295750bb810501d
X-Msg-Generator: CA
X-RootMTR: 20220525155008eucas1p2c843cc9098f2920e961f80ffaf535789
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220525155008eucas1p2c843cc9098f2920e961f80ffaf535789
References: <20220525154957.393656-1-p.raghav@samsung.com>
        <CGME20220525155008eucas1p2c843cc9098f2920e961f80ffaf535789@eucas1p2.samsung.com>
        <20220525154957.393656-9-p.raghav@samsung.com>
        <9703ca4c-33cf-cb3a-b46b-6b0e5537cfd6@opensource.wdc.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,
On 5/26/22 01:13, Damien Le Moal wrote:
> On 5/26/22 00:49, Pankaj Raghav wrote:
>> Ensure that only power of 2 zoned devices are enabled for dm targets that
>> supports zoned devices. This constraint can be relaxed once non power of
>> 2 zone size support is added to the DM layer.
>>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>  drivers/md/dm-table.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
>> index 03541cfc2317..2a8af70d1d4a 100644
>> --- a/drivers/md/dm-table.c
>> +++ b/drivers/md/dm-table.c
>> @@ -251,6 +251,12 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>>  	if (bdev_is_zoned(bdev)) {
>>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>>  
>> +		if (!is_power_of_2(zone_sectors)) {
>> +			DMWARN("%s: %pg only power of two zone size supported",
>> +			       dm_device_name(ti->table->md), bdev);
>> +			return 1;
>> +		}
>> +
>>  		if (start & (zone_sectors - 1)) {
>>  			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
>>  			       dm_device_name(ti->table->md),
> 
> I thought the agreed upon idea is be to add a dm-linear like target to
> emulate power of 2 zone size so that we can keep btrfs and f2fs running on
> this new class of device. So why this patch ?
> 
> The entire series as is will fragment zoned block device support, which is
> not a good thing at all. Without the new dm target, none of the current
> kernel supported zone stuff will work.
> 
I have mentioned this in my cover letter:
The support is planned to be added in two phases:
- Add npo2 support to block, nvme layer and necessary stop gap patches
  in the filesystems
- Add dm target for npo2 devices so that they are presented as a po2
  device to filesystems

This series is targeting the first phase where we have stop gap patches
and add support to the block and nvme layer and in the next phase we
will add a dm linear like target for npo2 zone sizes which can be used
by all the filesystems. This patch makes sure that we can't use npo2
zoned devices without the proper support that will be added in the next
phase in the DM.

Even though we decided we would like to take the direction of DM, I am
still awaiting reply from Christoph who raised concerns about npo2 zoned
device support and Mike Snitzer about this approach. That is one of the
reason I split this effort into two phases.
> The zonefs patch is also gone from the series. Why ? As is, zonefs will
> break if it is passed a non power of 2 zone size drive.
> 
I think this was my mistake. If you agree with the above approach, then
I can add a stop gap patch also to zonefs npo2 zoned devices. This way
all the zone filesystem support goes via DM for npo2 zoned devices. I am
proposing this so that initially we always have only one way of
accessing a npo2 zoned device (via DM) from **filesystems** until we add
native support.
