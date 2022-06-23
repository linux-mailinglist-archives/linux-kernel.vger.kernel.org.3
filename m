Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BEE5575CC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiFWIqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFWIqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:46:09 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C3C49266
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655973968; x=1687509968;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=nG7IwkCM3bMibkNL8def0G67D3SVszHUKz2jxa1Ctbc=;
  b=FqEMOaQoUpOIM8pjJJxsIWqFr2BebUkkl9KkW2axrfHSC8dK3Hv/ugr2
   7Gp8+dxbSTjca9oPpxcjsxKZDFpU8Lx9PxHJae8p5N+pggt0BZ9f/xKIJ
   jHm3vrK33WrOrMWLVEpp00Vkq3yWdrfW11WSZZIJYYLGWKDAyk6jTIF2E
   Y2GDWqinXxmyMwrbonFJeuIrWOL758duOxuVf6mALvtbuciecoO+hapsQ
   YKEeYJHVaoV121oV4ZRG6eoFQf5b/Z0fDfA3iqVrpUiuHVlrk565r5dam
   h3kp3p3wmmwln8VZViz+a+65iKGTaF8r9jn15WVzMhWelj7fUVx+JPQSP
   g==;
X-IronPort-AV: E=Sophos;i="5.92,215,1650902400"; 
   d="scan'208";a="316010276"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2022 16:46:08 +0800
IronPort-SDR: IT5EERnrt25BTe8TEaUtgUv7U5vkZlPyKHwqMV3nukV6q5YGZ+hacy1u9LIpaDc6PKnGonr6qP
 fhegKI9JYjwJnFq7gOPyIu1emHTOHGpJM5h5umy1iXpofACzKPXtH26flssP6jt3RTV48tlxJv
 LdTMTA7YIXVHm46Kv/HffQTNP9U7Ne4DKxnAsksmprkUGu+NQRDsGTcp/mztTnb7q3E9b1H9Jp
 h9isasvMMwXGyfyu16LheY5KIbQuUvaVNILIVRz/MvJAGzQ0bhVNz5P7fCxMFuut0eRwxE2Oeq
 baHyUQv2zIKm0WYUId5g/CMC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 01:03:53 -0700
IronPort-SDR: Hop5z+L48QfTOWDYcmGAdhQxcXfv81B5M6hBZqR8wXsgyoqnLElyBFY1MysDD6M4ZsnnloqOWh
 dS6+E5TkGEmygq0AOPdtwZTtKXZMIaHLNs1fC647bnI2hF0YX9NiDnYmq/soz98KMgz6cAJ7Nb
 FSDpS8mg3nP0laApRr+jweN1SpSQUoisj127ofmLgeHYbd9TE1/JQdfvPMGuwhBQ4oCiGf9Z2W
 IkfWniWk6TN3+DNHhk0f4GDLKT8V0NH5CdZDCp1fQtRB/klZ/fKsiWm/3s826bVLEO7QOnxLoI
 3rM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 01:46:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTDPC3pLHz1Rwnl
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:46:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655973967; x=1658565968; bh=nG7IwkCM3bMibkNL8def0G67D3SVszHUKz2
        jxa1Ctbc=; b=OqbjMGQ3bfKTsVbWIYH2EWFgHOCfN+rw83LWdm8tkfMrgGmP6Zl
        zsQdAy+v2TmfYSYVkhd6sHK3Fc2+Cuc1oumeAhdo8PuUUmVg1kpRBTq3hN/AxUtm
        WfbS5uy+aTXrEda0HbVXplUSRtypIGHL/36plWaTVVnZSQd5TmM5ZQlv5i2NbN0j
        7bRO2BqZ4/8R9hZnq2Re9fqvLzcaC8EniX760++TZ0l8HYD50JVQMJ+yDk5avU4s
        J09BtcGd7wg7gpHAVzYoaoYnQu6fSWEd0vdbftndCoiZQe/9r58roTqpNstzbsQu
        Jr8lpoxQkuUOzawT7fQdxpdZeQs5h+WEeIA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WSlFla56kAeV for <linux-kernel@vger.kernel.org>;
        Thu, 23 Jun 2022 01:46:07 -0700 (PDT)
Received: from [10.225.163.90] (unknown [10.225.163.90])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTDPB2s85z1RtVk;
        Thu, 23 Jun 2022 01:46:06 -0700 (PDT)
Message-ID: <7f086930-ff6c-da99-212b-46c4479247cb@opensource.wdc.com>
Date:   Thu, 23 Jun 2022 17:46:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] libata: add horkage for M88V29
Content-Language: en-US
To:     =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>,
        zboszor@pr.hu, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <20220204125750.1771303-1-zboszor@pr.hu>
 <f726e9e1-bdad-ac8a-368b-aae423a00676@opensource.wdc.com>
 <78c29f43-3b67-8e70-0711-14e997f3efb1@gmail.com>
 <09091cc4-f652-0978-bb6a-b63f24fdcf49@opensource.wdc.com>
 <bbfeb862-9e1f-79c2-89dd-7db9515471e4@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <bbfeb862-9e1f-79c2-89dd-7db9515471e4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/22 17:38, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n wrote:
> 2022. 06. 23. 10:22 keltez=C3=A9ssel, Damien Le Moal =C3=ADrta:
>> On 6/23/22 16:47, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n wrote:
>>> 2022. 02. 08. 9:07 keltez=C3=A9ssel, Damien Le Moal =C3=ADrta:
>>>> On 2/4/22 21:57, zboszor@pr.hu wrote:
>>>>> From: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gmail.com>
>>>>>
>>>>> This device is a CF card, or possibly an SSD in CF form factor.
>>>>> It supports NCQ and high speed DMA.
>>>>>
>>>>> While it also advertises TRIM support, I/O errors are reported
>>>>> when the discard mount option fstrim is used. TRIM also fails
>>>>> when disabling NCQ and not just as an NCQ command.
>>>>>
>>>>> TRIM must be disabled for this device.
>>>>>
>>>>> Signed-off-by: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gmai=
l.com>
>>>>> ---
>>>>>    drivers/ata/libata-core.c | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>>>> index 67f88027680a..4a7f58fcc411 100644
>>>>> --- a/drivers/ata/libata-core.c
>>>>> +++ b/drivers/ata/libata-core.c
>>>>> @@ -4028,6 +4028,7 @@ static const struct ata_blacklist_entry ata_d=
evice_blacklist [] =3D {
>>>>>   =20
>>>>>    	/* devices that don't properly handle TRIM commands */
>>>>>    	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
>>>>> +	{ "M88V29*",			NULL,	ATA_HORKAGE_NOTRIM, },
>>>>>   =20
>>>>>    	/*
>>>>>    	 * As defined, the DRAT (Deterministic Read After Trim) and RZA=
T
>>>> Applied to for-5.17-fixes. Thanks !
>>> Thank you. However, I have second thoughts about this patch.
>>> The device advertises this:
>>>
>>> # hdparm -iI /dev/sda
>>> ...
>>>   =C2=A0Enabled Supported
>>>   =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 Data Set Management TRIM sup=
ported (limit 1 block)
>>> ...
>>>
>>> but the I/O failures always reported higher number of blocks,
>>> IIRC the attempted number of block was 8 or so.
>>>
>>> Can the kernel limit or split TRIM commands according to the
>>> advertised limit? If not (or not yet) then the quirk is good for now.
>> Yes, the kernel does that. See the sysfs queue attributes
>> discard_max_bytes and discard_max_hw_bytes. What are the values for yo=
ur
>> device ? I think that the "limit 1 block" indicated by hdparm is simpl=
y to
>> say that the DSM command (to trim the device) accept only at most a 1
>> block (512 B) list of sectors to trim. That is not the actual trim lim=
it
>> for each sector range in that list.
>=20
> With the quirk in effect (TRIM disabled) I have these:
>=20
> [root@chef queue]# pwd
> /sys/block/sda/queue
> [root@chef queue]# cat discard_granularity
> 0
> [root@chef queue]# cat discard_max_bytes
> 0
> [root@chef queue]# cat discard_max_hw_bytes
> 0

Yes, expected. What are the values without the quirk applied ?
With 5.19, you can use libata.force to disable/enable it. See
Documentation/admin-guide/kernel-parameters.txt for details.
You could try disabling DSM TRIM (queued trim) and see if the non-ncq tri=
m
work.

--=20
Damien Le Moal
Western Digital Research
