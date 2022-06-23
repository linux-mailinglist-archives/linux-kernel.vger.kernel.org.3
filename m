Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ED6557733
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiFWJzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiFWJzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:55:50 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68A12F3A9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655978149; x=1687514149;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=XXpmfGITyPHZs6FZ5fvy9HEUGUmVlfFW8Va4Xmp7y8k=;
  b=ha2URw/ZcGC06Lw/9IgUxCgFJdpoaPRVD84ge33xIPHqEXH73/DyxB+k
   NZZ8RtgdpyRJHP0+I7aCrL82yiglzLZMji3jEElDkJ7D00nWfulLiVmU2
   2M/njGoJam6o9ozuAROhMzp3wv1CCGH9lMF3d8WmUO+IksR0/xugKWBeS
   3FEtV+RSttTKRwV1Y5dda2Wq3YbDkYlkxSibg7/hlp7tVRY1i1F9NtyPa
   QcO5ZFkn6hvub4yWVZp7MRGQyO4abpH6cXGr+Ln01iaJ042hRhODldAim
   DcWDROZT2qeZDcJyOQxJBH5HU7A4q8rLfXaTbYjqC9mSWd/EQxHHoootv
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,215,1650902400"; 
   d="scan'208";a="308235323"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2022 17:55:45 +0800
IronPort-SDR: cXErdpdBjE/u4mAhYhHQkwgPeJJHfkr+8HczKsoNr7u3Nzjyh3abA9lXv+bZIjHGcPZ9i930RC
 Ptxhp97V7aKhYdIQI/5Wfsm+NXM1qkrHEp28uVBa5ZT3u0XXSeYaLf5lQbefVjmfYrcAgpVgpt
 HI0dcGwSfSc5lLz9v4UMYiJiayOeb6qr3POvsFaj8cLCqwD3o3OqxaOBwtuMy1JvCGg4TZCaC1
 jZ9qtsvzEGb5LILeUWbKA2gbMIcff2ycReqXOyLOFeqeDXF/WKKudiotfC4nOcUxctNTWYxkyX
 kdVH26PQKz7F9SCuR7epQV+d
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 02:13:32 -0700
IronPort-SDR: qfVH/bvYrlex066ZOzDbvXZ0SePVyTqacb+ZAKVTojgSIK7uGgCLac4IPAN4+8jdNJHpK5sE9F
 mZIiMLLBOdSZRjqa7j/ACscSFYSKD1hXZTda2pLNeAW38Q59YMvn3ZXHpD1RtohHmIVE2JNgdN
 yUmME+GeDqpXBjz3LuRI4VSX82pNvYsLNuq71Bh3u2098WvgAIC781bOvhP74XbZVxv/ekm1SF
 qj+yvqinc/7kAEqRKVdXCeu1w079SxME2OslfgXmiSioOXlLlD4JirZ6xV7Bae5gGgi3CMNx1G
 wAU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 02:55:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTFxY3xMhz1Rwnl
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:55:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655978144; x=1658570145; bh=XXpmfGITyPHZs6FZ5fvy9HEUGUmVlfFW8Va
        4Xmp7y8k=; b=e+LTVpJ8vC7V7YcBAQSmvUX383ihhrA0xxjfohzckdc8UIozi8m
        EJ6U4DKqhPIFJyLFnDnhQNNmjW3fGoO7vW4NXnVKsg4wE6xn9Egof1eqXSv/DASU
        J4HcCBI6ESujHK7pRwosb/MiK58Y2Ol4RLvGVNNBjcxm/IuMkhgkVNpPJlenoiB1
        f9qd59xDISIYuZjq1MVmah+3EL6yV+9DwZty+5uBxVxt5+4dXY8BAV0R1lWNkiJO
        T+1xHSnSogbZbHB7NkUNRUEdPAC29dpx5noKZB++fdeOqOR8DwyT5J2+LEk7Kjsu
        kK/8v2XN6oGAqhTHqSg6VkhkbNcbb8Xzkfg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TyuCcm-r_YHm for <linux-kernel@vger.kernel.org>;
        Thu, 23 Jun 2022 02:55:44 -0700 (PDT)
Received: from [10.225.163.90] (unknown [10.225.163.90])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTFxW6vFvz1RtVk;
        Thu, 23 Jun 2022 02:55:43 -0700 (PDT)
Message-ID: <5dad0eb6-10e3-8319-ca86-f5059a7bd185@opensource.wdc.com>
Date:   Thu, 23 Jun 2022 18:55:42 +0900
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
 <7f086930-ff6c-da99-212b-46c4479247cb@opensource.wdc.com>
 <c678589c-cb30-35a3-cc7f-ad4065863640@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c678589c-cb30-35a3-cc7f-ad4065863640@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/22 18:32, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n wrote:
> 2022. 06. 23. 10:46 keltez=C3=A9ssel, Damien Le Moal =C3=ADrta:
>> On 6/23/22 17:38, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n wrote:
>>> 2022. 06. 23. 10:22 keltez=C3=A9ssel, Damien Le Moal =C3=ADrta:
>>>> On 6/23/22 16:47, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n wrote:
>>>>> 2022. 02. 08. 9:07 keltez=C3=A9ssel, Damien Le Moal =C3=ADrta:
>>>>>> On 2/4/22 21:57, zboszor@pr.hu wrote:
>>>>>>> From: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gmail.com>
>>>>>>>
>>>>>>> This device is a CF card, or possibly an SSD in CF form factor.
>>>>>>> It supports NCQ and high speed DMA.
>>>>>>>
>>>>>>> While it also advertises TRIM support, I/O errors are reported
>>>>>>> when the discard mount option fstrim is used. TRIM also fails
>>>>>>> when disabling NCQ and not just as an NCQ command.
>>>>>>>
>>>>>>> TRIM must be disabled for this device.
>>>>>>>
>>>>>>> Signed-off-by: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gm=
ail.com>
>>>>>>> ---
>>>>>>>     drivers/ata/libata-core.c | 1 +
>>>>>>>     1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.=
c
>>>>>>> index 67f88027680a..4a7f58fcc411 100644
>>>>>>> --- a/drivers/ata/libata-core.c
>>>>>>> +++ b/drivers/ata/libata-core.c
>>>>>>> @@ -4028,6 +4028,7 @@ static const struct ata_blacklist_entry ata=
_device_blacklist [] =3D {
>>>>>>>    =20
>>>>>>>     	/* devices that don't properly handle TRIM commands */
>>>>>>>     	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
>>>>>>> +	{ "M88V29*",			NULL,	ATA_HORKAGE_NOTRIM, },
>>>>>>>    =20
>>>>>>>     	/*
>>>>>>>     	 * As defined, the DRAT (Deterministic Read After Trim) and =
RZAT
>>>>>> Applied to for-5.17-fixes. Thanks !
>>>>> Thank you. However, I have second thoughts about this patch.
>>>>> The device advertises this:
>>>>>
>>>>> # hdparm -iI /dev/sda
>>>>> ...
>>>>>    =C2=A0Enabled Supported
>>>>>    =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 Data Set Management TRIM =
supported (limit 1 block)
>>>>> ...
>>>>>
>>>>> but the I/O failures always reported higher number of blocks,
>>>>> IIRC the attempted number of block was 8 or so.
>>>>>
>>>>> Can the kernel limit or split TRIM commands according to the
>>>>> advertised limit? If not (or not yet) then the quirk is good for no=
w.
>>>> Yes, the kernel does that. See the sysfs queue attributes
>>>> discard_max_bytes and discard_max_hw_bytes. What are the values for =
your
>>>> device ? I think that the "limit 1 block" indicated by hdparm is sim=
ply to
>>>> say that the DSM command (to trim the device) accept only at most a =
1
>>>> block (512 B) list of sectors to trim. That is not the actual trim l=
imit
>>>> for each sector range in that list.
>>> With the quirk in effect (TRIM disabled) I have these:
>>>
>>> [root@chef queue]# pwd
>>> /sys/block/sda/queue
>>> [root@chef queue]# cat discard_granularity
>>> 0
>>> [root@chef queue]# cat discard_max_bytes
>>> 0
>>> [root@chef queue]# cat discard_max_hw_bytes
>>> 0
>> Yes, expected. What are the values without the quirk applied ?
>=20
> I built 5.18.6 with removing the quirk.
>=20
> [root@chef queue]# pwd
> /sys/block/sda/queue/
> [root@chef queue]# cat discard_granularity
> 512
> [root@chef queue]# cat discard_max_bytes
> 2147450880
> [root@chef queue]# cat discard_max_hw_bytes
> 2147450880
> [root@chef queue]# cat max_discard_segments
> 1

All normal. This is 65535 sectors at most per trim range times 64 ranges
at most (64 range in at most 1 512B range list).
65535*512*64=3D2147450880

So if that is not working, then it means that DSM TRIM are not working
correctly on that device. Have you tried disabling NCQ trim ?
Use libata.force noncqtrim option.

>=20
>> With 5.19, you can use libata.force to disable/enable it. See
>> Documentation/admin-guide/kernel-parameters.txt for details.
>> You could try disabling DSM TRIM (queued trim) and see if the non-ncq =
trim
>> work.
>>
>=20


--=20
Damien Le Moal
Western Digital Research
