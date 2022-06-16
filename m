Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBAE54EDF0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379018AbiFPXeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiFPXeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:34:00 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FDD5FF3E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655422439; x=1686958439;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=miOh0Krt3dHgfQ++Q3+hZ/C+eYxh5MtrLlarE6QmQps=;
  b=MbOBgmYxcyX10iXCellmmhpKAN5z+dirRteYxv+Fy4avh8pCP21A/1jC
   sVaJj0IW1mCJyZ4pHvdvpnlNGdCRzBG3b8AvF18LfCh4on/iDKWKZqXWK
   mulXzFrAWoLUdd2tGREPptBlbHx9dNEdtVKHtbcVs8auSNEgr4RNz/NSO
   2BWvGJDVhbEfaFbwkRYcfsEZiKIVp6MDly6BwSMdDmZucVSUuHnp23PHp
   +OWhVmQlpObYObjIOC4Y5L79zEf6h2zqt+xpFhoTnCsYkTC/pS1aB+BnX
   Sz7TOHWa1zSPNBSrHXqC45Y1gysCgQiM222AkJHD9N8bUmx31w+DeRHjf
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="204135761"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 07:33:59 +0800
IronPort-SDR: 2iH2oj+PelLclw2pb67r0rw2aRUWg67LuU+6c5K5YzkFf3eGjIfWIRNrgbTnIukclO1Lv+/7xb
 pqFIEQPs+T23ONg6g60BN7WYA2KkslkbvjZ+e1CYzG59r4E6kXx/V6k7EHvQNaJt/uxBjTawv0
 tl1fQZHoBrKt2qC+WvTd3fMzKSgEa/G/5j+f3bVM0FR4WWk8pRmpAZgrlCAk57E1V7JlHaBrd7
 cnn3eVlndrJWoAWTLPltBkV2H573d7+8OJhtwVZnv6zMmHurvBqIIloXGh5Bew3ha7xzwT6zZh
 wLWp8DPXU/P4D1CE0IHGaHKw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 15:52:11 -0700
IronPort-SDR: 7Wp3VLcea/qEzihfTw72sZss/j1gG1mTcqDkvEVJv0f2EXXQgbiWe5TixyPbtZUpQLASz4W6AE
 ynf8X1Ypfjb8gr2ONXhZTWKhMXOIX9edYgAsrsFHAtIjtIahHGNABDh00HRTwrXiknmThgwV6z
 iflMyevjO15dLgcnQsptna9f9sFBaU4czvk4avxn2sokJSpA8gWUjojbcKfTu6vxv3bE0GTesf
 ageY3Ei2YgpVXWggCS1RnLkpAelkiCSpcH7UlHqT3dqJOVaKj0/vLhrf8ekUGDDPhOTeWmC40Z
 uaQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 16:33:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPJQt0F3Fz1SVp7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:33:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655422437; x=1658014438; bh=miOh0Krt3dHgfQ++Q3+hZ/C+eYxh5MtrLla
        rE6QmQps=; b=GNW+HIaCLj8DR3T1xtWhCOnJdyz1RYvuJcv8sV9geJELsRRzJTC
        vYTiTPl9snDofRWoUWEpiEc+inLDkhZa3DY5hgtXLJSHqZ33bYFOq+f8JqjTSbNp
        L6JEfP8Ka9SF+BNZotyJRK7IkzIvwSq6UQQvUq0mCa/IEjmFxm79yjI0uwzEWuzN
        0KFwAcstLRBiP6r29hgcA+11HBs6K1tg2gYUJKxix6v+Icvg0Y4qW1rggo4Cksq4
        g1NPbP9PsOfuHpq2ZJ/UD+0Zy9CGOgzfrSBCiOgoe4hpTOsVTYWC8MReMIdN3JUw
        KdSlwqj+UjliYOPpmwe1MCseOC9ihifXY1Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pDlGTyNRlJuW for <linux-kernel@vger.kernel.org>;
        Thu, 16 Jun 2022 16:33:57 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPJQp1Ntqz1Rvlc;
        Thu, 16 Jun 2022 16:33:54 -0700 (PDT)
Message-ID: <8883fed1-cc5a-889d-6668-cb8039fbf09a@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 08:33:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [dm-devel] [PATCH v7 12/13] dm: call dm_zone_endio after the
 target endio callback for zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        snitzer@redhat.com, axboe@kernel.dk
Cc:     bvanassche@acm.org, pankydev8@gmail.com, gost.dev@samsung.com,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        Johannes.Thumshirn@wdc.com, dsterba@suse.com, jaegeuk@kernel.org
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102007eucas1p1106f9520e2a86beb3792107dffd8071b@eucas1p1.samsung.com>
 <20220615101920.329421-13-p.raghav@samsung.com>
 <f7b586a3-5370-f3b9-72dc-f9bea0b63f1f@opensource.wdc.com>
 <8d8501e8-9e39-8b02-d248-48f778a95d96@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8d8501e8-9e39-8b02-d248-48f778a95d96@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 21:24, Pankaj Raghav wrote:
> On 2022-06-15 13:01, Damien Le Moal wrote:
>> On 6/15/22 19:19, Pankaj Raghav wrote:
>>> dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
>>> uses either native append or append emulation and it is called before the
>>> endio of the target. But target endio can still update the clone bio
>>> after dm_zone_endio is called, thereby, the orig bio does not contain
>>> the updated information anymore. Call dm_zone_endio for zoned devices
>>> after calling the target's endio function
>>>
>>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>>> ---
>>> @Damien and @Hannes: I couldn't come up with a testcase that uses endio callback and
>>> zone append or append emulation for zoned devices to test for
>>> regression in this change. It would be great if you can suggest
>>> something. This change is required for the npo2 target as we update the
>>> clone bio sector in the endio callback function and the orig bio should
>>> be updated only after the endio callback for zone appends.
>>
>> Running zonefs tests on top of dm-crypt will exercise DM zone append
>> emulation.
>>
> Thanks. However, I am facing issues creating a dm-crypt target with a
> zoned device. Steps:
> - cryptsetup luksFormat <zns-device>

luks format is not supported because cryptsetup does not write the
metadata sequentially. I am working on fixing that. Use the plain format.

> 
> is throwing a bunch of IO errors with the following error message:
> Device wipe error, offset 32768.
> Cannot wipe header on device <zns-device>.
> 
> I can observe the same behavior in both v5.18 and next-20220615 with
> cryptsetup 2.4.3.The same step is working correctly on a normal NVMe device.
> Am I doing something wrong?
> ZNS info: zsze 128M and zcap 128M with 50 zones
>>>
>>>  drivers/md/dm.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
>>> index 3f17fe1de..3a74e1038 100644
>>> --- a/drivers/md/dm.c
>>> +++ b/drivers/md/dm.c
>>> @@ -1025,10 +1025,6 @@ static void clone_endio(struct bio *bio)
>>>  			disable_write_zeroes(md);
>>>  	}
>>>  
>>> -	if (static_branch_unlikely(&zoned_enabled) &&
>>> -	    unlikely(blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))))
>>> -		dm_zone_endio(io, bio);
>>> -
>>>  	if (endio) {
>>>  		int r = endio(ti, bio, &error);
>>>  		switch (r) {
>>> @@ -1057,6 +1053,10 @@ static void clone_endio(struct bio *bio)
>>>  		}
>>>  	}
>>>  
>>> +	if (static_branch_unlikely(&zoned_enabled) &&
>>> +	    unlikely(blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))))
>>
>> blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))) ->
>> bdev_is_zoned(bio->bi_bdev)
>>
> Ok. Even though I just moved the statements, I think this is trivial
> enough to take it along.
>>> +		dm_zone_endio(io, bio);
>>> +
>>>  	if (static_branch_unlikely(&swap_bios_enabled) &&
>>>  	    unlikely(swap_bios_limit(ti, bio)))
>>>  		up(&md->swap_bios_semaphore);
>>
>>


-- 
Damien Le Moal
Western Digital Research
