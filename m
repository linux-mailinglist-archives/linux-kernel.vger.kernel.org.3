Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C996B534BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbiEZIZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiEZIZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:25:28 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D62C1EF7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653553525; x=1685089525;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2fzV6PB7rIH8hutqjCCcvjaAmPuVZ2KddaphMUepXFc=;
  b=dBjE+8hKF3U2ayJrLLiV8m0jw6ZUJOlnNv5lqbLYq1xbUMxpJ6jgiWbD
   3EbXmcIVUxm6JBCJi1TwWdkwdXpHV+R41TYe1O5P0zJbhoy9AZ0npb7Ro
   2lkuqWuC1EfIvZm5QE+RH95L9Nl9TYF+KGNjjTtlU9hNWYY2dsGYEqGBV
   P4xD9/g7VIGcjbPP/Sg8IqkEmy9cDNuSBjT0qcJ5NTbPa5dTzUBh9ZJ2x
   i4Js/ya0mP0CR3man7MkzEswU/ATMTKOYgzLWPicTMHxyKHtJfOzjXdQR
   9O1bwwmVwtfPjPnripviymBI6o5G9SMeZXUk47ULlKW+8Mt4gV76UMrjy
   w==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="305723376"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 16:25:24 +0800
IronPort-SDR: +TiPziz/t1ngjN9udvNlz/10phM5fHK56qIXnve/q4JnfhDHQKX7/IXPgWsm4DjA7/xlLm93vx
 knNyUNVGLeHYBMUDHqCxZTeYMZUuUABltOVa1A/ggPJDpm+A7feHUAW3R+KNm5nL9gc4PTlrLy
 FgjtvImZfYK5Bj/ivWFh4obLEDyyg4knOytvjgsJIfm8rw5t3u1LMa+3Rb81kVEzQzSvsxmhE6
 YpqcVPgFA90rNMslw6f2+NkLbJ56S8XD+xOjaDW3BQIP/On8HlCd1iY75Jr4zUcAceAa1T0vvx
 mj16HxgQBRD/6T3OEqNh1qaI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 May 2022 00:49:19 -0700
IronPort-SDR: yVLCIci7iNBFRR5XViGBrQXvud/HuKFQ9HIGDt6gzXgudGSxqDjTsaCMCcyHsAHLYd0ad+Xiu/
 a5mPBfKAxNdoFNivJq2o/YVb9kzTSOjF/xmOcgZnXhJKPWvvsSCruAP1gZCJGfrdFrEIQ6Ymwg
 ZfWzWVYRvlowA0VTCnSiyG7tk76WLSBs0TLEeku2ukmUdZZEHyJ+0Xzp8CXHVPPBBr28UMZhRW
 1jEhHeHlt2HqwCYWKxQJXtgUO8tGX4n6nzYTdOXmiQX+0fl7f1kuDuWA40+C472N7ux0/+1iMc
 JYQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 May 2022 01:25:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L81GC6SrDz1SVp4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:25:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653553522; x=1656145523; bh=2fzV6PB7rIH8hutqjCCcvjaAmPuVZ2Kddap
        hMUepXFc=; b=E/mS7YlrPtM583nIEsFkcK8t8wBnxJ9gbQuIHuaW989C2ArGadQ
        PQzaKgmCUFhyRqoJoFsaHo3T5pJ7kBgFbo2L8h1HUgFndIx4ndzPFwb+gvOPsPph
        SIuHCLYTWe0vbGbpb/FOzwLexJUY8+l/5MRTI48fTaHbluKGdy+NF2qnDKfZxtYd
        f3jrh/ltG3OHVGXz+Iev615zk3fi+Vwx9hBVf514Z8N569EILYy2kIrip61CN3t/
        rqyUVXIbF/n/EqWU6It5hMpFIun5CgLTlp10jbOCRV7dO8Df+wEqqMs5Q1Wh1GTg
        0t7M5fp7Ze+jyp9o/kxbt17xuKDQjrEibLQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3G5f-pRzz7lJ for <linux-kernel@vger.kernel.org>;
        Thu, 26 May 2022 01:25:22 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L81G76Gmcz1Rvlc;
        Thu, 26 May 2022 01:25:19 -0700 (PDT)
Message-ID: <3c04e29f-2c99-c350-bc87-0c0633b4d19d@opensource.wdc.com>
Date:   Thu, 26 May 2022 17:25:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
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
 <9703ca4c-33cf-cb3a-b46b-6b0e5537cfd6@opensource.wdc.com>
 <0bb57f61-9a33-0273-4b89-2cdf042e56dd@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <0bb57f61-9a33-0273-4b89-2cdf042e56dd@samsung.com>
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

On 2022/05/26 17:12, Pankaj Raghav wrote:
> Hi Damien,
> On 5/26/22 01:13, Damien Le Moal wrote:
>> On 5/26/22 00:49, Pankaj Raghav wrote:
>>> Ensure that only power of 2 zoned devices are enabled for dm targets that
>>> supports zoned devices. This constraint can be relaxed once non power of
>>> 2 zone size support is added to the DM layer.
>>>
>>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>>> ---
>>>  drivers/md/dm-table.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
>>> index 03541cfc2317..2a8af70d1d4a 100644
>>> --- a/drivers/md/dm-table.c
>>> +++ b/drivers/md/dm-table.c
>>> @@ -251,6 +251,12 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>>>  	if (bdev_is_zoned(bdev)) {
>>>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>>>  
>>> +		if (!is_power_of_2(zone_sectors)) {
>>> +			DMWARN("%s: %pg only power of two zone size supported",
>>> +			       dm_device_name(ti->table->md), bdev);
>>> +			return 1;
>>> +		}
>>> +
>>>  		if (start & (zone_sectors - 1)) {
>>>  			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
>>>  			       dm_device_name(ti->table->md),
>>
>> I thought the agreed upon idea is be to add a dm-linear like target to
>> emulate power of 2 zone size so that we can keep btrfs and f2fs running on
>> this new class of device. So why this patch ?
>>
>> The entire series as is will fragment zoned block device support, which is
>> not a good thing at all. Without the new dm target, none of the current
>> kernel supported zone stuff will work.
>>
> I have mentioned this in my cover letter:
> The support is planned to be added in two phases:
> - Add npo2 support to block, nvme layer and necessary stop gap patches
>   in the filesystems
> - Add dm target for npo2 devices so that they are presented as a po2
>   device to filesystems
> 
> This series is targeting the first phase where we have stop gap patches
> and add support to the block and nvme layer and in the next phase we
> will add a dm linear like target for npo2 zone sizes which can be used
> by all the filesystems. This patch makes sure that we can't use npo2
> zoned devices without the proper support that will be added in the next
> phase in the DM.

Personally, I do not want to see a kernel version where zone support is broken
for some devices. So I definitely prefer everything in one go or nothing.

> 
> Even though we decided we would like to take the direction of DM, I am
> still awaiting reply from Christoph who raised concerns about npo2 zoned
> device support and Mike Snitzer about this approach. That is one of the
> reason I split this effort into two phases.
>> The zonefs patch is also gone from the series. Why ? As is, zonefs will
>> break if it is passed a non power of 2 zone size drive.
>>
> I think this was my mistake. If you agree with the above approach, then
> I can add a stop gap patch also to zonefs npo2 zoned devices. This way
> all the zone filesystem support goes via DM for npo2 zoned devices. I am
> proposing this so that initially we always have only one way of
> accessing a npo2 zoned device (via DM) from **filesystems** until we add
> native support.
-- 
Damien Le Moal
Western Digital Research
