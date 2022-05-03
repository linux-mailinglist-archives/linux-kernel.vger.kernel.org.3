Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30018518A4C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbiECQrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbiECQq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:46:59 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1482C138
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651596206; x=1683132206;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gtowxbHk/V4v64RtsKyaAcMJzf5VQm5Xqlz1mGZPWVc=;
  b=UuimcHFNqGY/ydZ3zk+0WP3roBVXJhLTI7+CwXN4V3hC0ecBIU+1fxyr
   5D1rAjKKCIMV5rwYsgWwgbBSF4yAySPunAFYeXVfxbFiO+EIEmh4m47T5
   ZueNBpc1rjGKSu563LcDt98anpVvCRUFA/VJcqjDFvquINMndT7xSGYGJ
   VnJnYJlougX/WWd65dXAHEGDSDYnRqJ7e4dT8U/vW0QItRDT30Nw1Qp3G
   TXGUq7+FcvpZ06/ri8RchK1E78XKXu2WH3xqwJ9S0JzRG5+HDaTRh9vbZ
   PZM78vRQC38Wk1m0mwCsi0WWOTsBYySFMsUC3kPo//vupSulV16+/v9LH
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,195,1647273600"; 
   d="scan'208";a="204304553"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2022 00:43:24 +0800
IronPort-SDR: LW7TYsoun5gZqxXLFOthLgSeEnORpZ8aOwHMKzfLLuiSRLN5CBFKo4doIgdmD5p3uoZ6l5O1OU
 V7ivVJ6Hoqi80P+L1ZekRkA2wny5YRnvEsNS3+/FCJjxFCYYU3bibQMbYH/Y2EcRVy5DwwULEJ
 DaJFpCHZYDdp57nlTArf/mf3NiO0QbGJTAlrSm68jgCJ8hh7P7LiToIuZ6/oiFuD8ozfD/eBbi
 WTXSbBzZzfSd94PIbAzbps5gshcO27WS2ht61LP6mr09Kgonrj+i4XEzWCJd6XWWv4jurVzxnv
 2eUmIs+261xgo1TD/krIInDO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2022 09:14:08 -0700
IronPort-SDR: OqQUJ4gpBCIipshDrM2UC+zaLxjPpD/ftHrB5lFX31VlKCs2YtPz5zgHNKDb8603nb2tRzblQq
 84Ja7eUDpgTtjCbZGJ8BDVgBK2/ZwzZT0XEI1I9e+7liI2tTNyQaXEK/oXSu1R12gF/SlhFeAS
 7+vZT2/t6qHxNs4/iN0AF9Cn7/iVEKnILXLLlI7gxPWLB1H/Drg7JBuDeUMjcPy+vTi2Y9PyTc
 gprVJtj4hoJwsMmPOyzm/00gwts4NVt8ByoE0Y/CbjDETDdJbaexlrgm+CfOAj+lZxqelOnXBr
 fPE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2022 09:43:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kt5PS40JHz1Rvlx
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:43:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651596203; x=1654188204; bh=gtowxbHk/V4v64RtsKyaAcMJzf5VQm5Xqlz
        1mGZPWVc=; b=kcyTVUQijJjNqFplnGo8HKlYc0HiINJOmX4zf5eOserrUbRTMOn
        YXMVAlSIZ2bMCoOrQDR4Jmy+RLEs296UujzAbqNHOInGBSH4H6nIzo26tog37ggh
        CaNs7bGBi+CPrY1jX/gw44Ven3i5IGGJMhCDv1WNXpnf6m1Ub1SWFzbsaFkwMSNj
        X971wrkoCJlGbG8weHoPBvT7RQivmhR8IZQG7bXL4fxwgm5u5apTjuD2LnPkTh4+
        rs/RucYrAJOLR9JTudxvxCVF2DWjlNMHqDOYstMeaMvYAZ8dGc5UQGUdZKdUhQBd
        j1Z6U+4LPn5mXtJBrWjQwFUsHEwYVvWKPUA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qTcq8XAYLvlZ for <linux-kernel@vger.kernel.org>;
        Tue,  3 May 2022 09:43:23 -0700 (PDT)
Received: from [10.225.81.200] (hq6rw33.ad.shared [10.225.81.200])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kt5PN0Cqnz1Rvlc;
        Tue,  3 May 2022 09:43:19 -0700 (PDT)
Message-ID: <2c275ab0-c813-22ae-16e3-b16885d06c4c@opensource.wdc.com>
Date:   Wed, 4 May 2022 01:43:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 01/16] block: make blkdev_nr_zones and blk_queue_zone_no
 generic for npo2 zsze
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
        axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
        naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        johannes.thumshirn@wdc.com
Cc:     linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        clm@fb.com, gost.dev@samsung.com, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
        jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
        kch@nvidia.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, jiangbo.365@bytedance.com,
        linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
        linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160257eucas1p21fb58d0129376a135fdf0b9c2fe88895@eucas1p2.samsung.com>
 <20220427160255.300418-2-p.raghav@samsung.com>
 <3a178153-62c0-e298-ccb0-0edfd41b7ee2@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3a178153-62c0-e298-ccb0-0edfd41b7ee2@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/04 1:37, Bart Van Assche wrote:
> On 4/27/22 09:02, Pankaj Raghav wrote:
>> Adapt blkdev_nr_zones and blk_queue_zone_no function so that it can
>> also work for non-power-of-2 zone sizes.
>>
>> As the existing deployments of zoned devices had power-of-2
>> assumption, power-of-2 optimized calculation is kept for those devices.
>>
>> There are no direct hot paths modified and the changes just
>> introduce one new branch per call.
>>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>   block/blk-zoned.c      | 8 +++++++-
>>   include/linux/blkdev.h | 8 +++++++-
>>   2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index 38cd840d8838..1dff4a8bd51d 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -117,10 +117,16 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
>>   unsigned int blkdev_nr_zones(struct gendisk *disk)
>>   {
>>   	sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
>> +	sector_t capacity = get_capacity(disk);
>>   
>>   	if (!blk_queue_is_zoned(disk->queue))
>>   		return 0;
>> -	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
>> +
>> +	if (is_power_of_2(zone_sectors))
>> +		return (capacity + zone_sectors - 1) >>
>> +		       ilog2(zone_sectors);
>> +
>> +	return div64_u64(capacity + zone_sectors - 1, zone_sectors);
>>   }
>>   EXPORT_SYMBOL_GPL(blkdev_nr_zones);
> 
> Does anyone need support for more than 4 billion sectors per zone? If 
> not, do_div() should be sufficient.
> 
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 60d016138997..c4e4c7071b7b 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -665,9 +665,15 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>>   static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>>   					     sector_t sector)
>>   {
>> +	sector_t zone_sectors = blk_queue_zone_sectors(q);
>> +
>>   	if (!blk_queue_is_zoned(q))
>>   		return 0;
>> -	return sector >> ilog2(q->limits.chunk_sectors);
>> +
>> +	if (is_power_of_2(zone_sectors))
>> +		return sector >> ilog2(zone_sectors);
>> +
>> +	return div64_u64(sector, zone_sectors);
>>   }
> 
> Same comment here.

sector_t is 64-bits even on 32-bits arch, no ?
so div64_u64 is needed here I think, which will be a simple regular division for
64-bit arch.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
