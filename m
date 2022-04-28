Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCDD513DCC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352381AbiD1Vr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiD1Vr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:47:26 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3F3C0D3B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651182250; x=1682718250;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m/acreNIl2rWYjlVezvJCF1GJU64s3Qgnn+Km+O6eew=;
  b=eENzoiKpqXMOLXCPYaV/izwAeKBwqOIjVfdo6W0OV9iVA168sVN1y4jW
   aDhTDSzI3kVtazDqbdtanNhWKmII8zWZLA1LKKTKVvu89AfUaaVeL8/LA
   oV+27HvsaCV0Ksdr/s0SaA6gmUQ+Q+SlfHE3Rof/zcZGjm1R8WPPZmE6S
   An65Z9OHoksv3Ii4Na9LMnprB7yT6Vqb2mVBlmpYXHYiopIq6h+7DrRGg
   S8QkpOT+EdXl92DyVMGjIuLDC17zkWLF1y520k4ff+ISqbiKRtla9WRvx
   IeXPA4ikCnkPqThiiJMjaboFdPD6bRPQNvfRIiDnTGcZ3hFaPInAAC7U4
   w==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; 
   d="scan'208";a="303311007"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2022 05:44:07 +0800
IronPort-SDR: cJJbUkXceCYLwRAmMuqSrYywkAXrz07lHU8ghxx10MsNlHK/Shr4O6Wnu05lgVwvnp9l22Q8+c
 DNufyekdks4LkARAoB5iqz15XczAAITOwPrvnHucYjbkJ/76w06s2ijtuONx/g2jRAUcho8Fna
 grLtv+CGJWAfjXhAmiXHyY087N2Jwc349g8E5PS/bxPqet7ZH8CCtoKdf/Nqct7xk2H+lhmg0B
 lpGbx1KJwpsj5ApQ1hqu7qDSJt6QZnGqebL6Nh7/lp3d64UJJbZprNBGZAE5canBLOCEXimQur
 Td71g2b3AQtP4QNn/1MZtd4E
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2022 14:14:15 -0700
IronPort-SDR: rlKBTUwp5+motf7tHQbnhcjEwg6wgT7m1O7wDR20pYRH9GggjtjwqKXiG3tQhJg6Zh5YRuctVK
 TqzVgMVy6LPRGsnpLpNKE0I2Q2iRU9QwnDsX3guHytlkrH9zGUwjBozV5hKJJw9jGTxecMvsSg
 iWnV+qQlVxrP+yyP6p4OkqXY39KA8SVIKjdA0UvD81ZtPtetsfETlgHae1/QjCOiNewrgvQsof
 Sf6OEvbuTEVXeB4knT8g68Tyrx6WO2a24jzw4Jmm7zSxJHmPyLD3NkP1ykyWN04RvJRm3Iond5
 unE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2022 14:44:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kq8Jk2mV6z1SVnx
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:44:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651182245; x=1653774246; bh=m/acreNIl2rWYjlVezvJCF1GJU64s3Qgnn+
        Km+O6eew=; b=P7Z2ssSysU3MXGjLqOpjIgw3LkMvOLPFsZ5/L/hy8zTXh7RRhg5
        oW7hJpKY5xehv6PCj5aAjux8iBygbEnlV6pT61szKcFi3rCbccmLZRC1mYDrsL9w
        5JjAtxFSVU6nXK85++NGprWHqgYwmhFNOvKCxx/jlLeOdAbLXCvijl/CpAN9syTf
        uL0rhmb3+rt+C1w/CE2rhsYUt7mNpL5EBJi00FmBRkg8jYpAkhDP+NtofLGylSHU
        IdqnZobibaJqdqpH2JChH3JY23wQeJdMZHT5/1cFVjlUHop8+7zb5n39efSFkKX2
        cNB3p+K+aur3vqxw7TEWidzO8wXpFiJo6QQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Jv2PUERhrOEL for <linux-kernel@vger.kernel.org>;
        Thu, 28 Apr 2022 14:44:05 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kq8Jb59qtz1Rvlc;
        Thu, 28 Apr 2022 14:43:59 -0700 (PDT)
Message-ID: <ce56cb7d-f184-aad1-4935-5f622e7afe5d@opensource.wdc.com>
Date:   Fri, 29 Apr 2022 06:43:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 16/16] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
        axboe@kernel.dk, snitzer@kernel.org, hch@lst.de,
        naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        johannes.thumshirn@wdc.com, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, clm@fb.com, gost.dev@samsung.com,
        chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        josef@toxicpanda.com, jonathan.derrick@linux.dev, agk@redhat.com,
        kbusch@kernel.org, kch@nvidia.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, bvanassche@acm.org, jiangbo.365@bytedance.com,
        linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
        linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160313eucas1p1feecf74ec15c8c3d9250444710fd1676@eucas1p1.samsung.com>
 <20220427160255.300418-17-p.raghav@samsung.com>
 <2ffc46c7-945f-ba26-90db-737fccd74fdf@opensource.wdc.com>
 <YmrQFu9EbMmrL2Ys@bombadil.infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YmrQFu9EbMmrL2Ys@bombadil.infradead.org>
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

On 4/29/22 02:34, Luis Chamberlain wrote:
> On Thu, Apr 28, 2022 at 08:42:41AM +0900, Damien Le Moal wrote:
>> On 4/28/22 01:02, Pankaj Raghav wrote:
>>> From: Luis Chamberlain <mcgrof@kernel.org>
>>>
>>> Today dm-zoned relies on the assumption that you have a zone size
>>> with a power of 2. Even though the block layer today enforces this
>>> requirement, these devices do exist and so provide a stop-gap measure
>>> to ensure these devices cannot be used by mistake
>>>
>>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>>> ---
>>>  drivers/md/dm-zone.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
>>> index 57daa86c19cf..221e0aa0f1a7 100644
>>> --- a/drivers/md/dm-zone.c
>>> +++ b/drivers/md/dm-zone.c
>>> @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
>>>  	struct request_queue *q = md->queue;
>>>  	unsigned int noio_flag;
>>>  	int ret;
>>> +	struct block_device *bdev = md->disk->part0;
>>> +	sector_t zone_sectors;
>>> +	char bname[BDEVNAME_SIZE];
>>> +
>>> +	zone_sectors = bdev_zone_sectors(bdev);
>>> +
>>> +	if (!is_power_of_2(zone_sectors)) {
>>> +		DMWARN("%s: %s only power of two zone size supported\n",
>>> +		       dm_device_name(md),
>>> +		       bdevname(bdev, bname));
>>> +		return 1;
>>> +	}
>>
>> Why ?
>>
>> See my previous email about still allowing ZC < ZS for non power of 2 zone
>> size drives. dm-zoned can easily support non power of 2 zone size as long
>> as ZC == ZS for all zones.
> 
> Great, thanks for the heads up.
> 
>> The problem with dm-zoned is ZC < ZS *AND* potentially variable ZC per
>> zone. That cannot be supported easily (still not impossible, but
>> definitely a lot more complex).
> 
> I see thanks.
> 
> Testing would still be required to ensure this all works well with npo2.
> So I'd prefer to do that as a separate effort, even if it is easy. So
> for now I think it makes sense to avoid this as this is not yet well
> tested.
> 
> As with filesystem support, we've even have gotten hints that support
> for npo2 should be easy, but without proper testing it would not be
> prudent to enable support for users yet.
> 
> One step at a time.

Yes, in general, I agree. But in this case, that will create kernel
versions that end up having partial support for zoned drives. Not ideal to
say the least. So if the patches are not that big, I would rather like to
see everything go into a single release.

-- 
Damien Le Moal
Western Digital Research
