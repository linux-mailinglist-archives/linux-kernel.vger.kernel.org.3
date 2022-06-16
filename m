Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F54954EDED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379394AbiFPXa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiFPXay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:30:54 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6697F5FF3E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655422253; x=1686958253;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3JUll1cokzNoMWjmBVYm6Y8IVuyZM8XJyZI/cVxZcV0=;
  b=VVRy6cNmdgwK71e/M/D2IXm2yIU1U+6uo705+fcnEGa4aUuLF/mGw/EH
   JpKOefC+vrFL4JUdm/B9kAEtvey9wq4Pz9ARr6dVt8yE1f4muHbyvFyq3
   Am4IPlkZXOhE+rjd6JUaxVSypUopIeiEkqE+HUSuYRpjpAFyW3H/wd1XN
   nA3O3fme/mRF7IY9GWX+oBdmM1bNYzw8ZeV8nFAFQRIwQOqTifemChGSu
   kgZLWPK332wEN1UavhgosCeg+KYbHWffIhNHH/Yp7qAKeIFI/Tygul1iO
   ikW0OGpEDMAza8sAEbpF/le+kZrP3KlAUGSAPFiytQgOmdLF/NEuEHuRK
   g==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="307679375"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 07:30:52 +0800
IronPort-SDR: m6YKQBHMb80HI9zXLBGMWEyF133C83TTtvBRe32+d4dc8Yw5hCz68piP/V0xFAadknitXE1kQq
 v39596MNzfNt0TB/K4z09Uiwhi3I4Zk07RhdaGw0mxaMmld57oL0PTx3Nmn1HqGPYTgqqXsrO7
 EEPkqrxadaoIT8/9jAL1oGutma6NBruSo0jxzAgETaCQ2FtpiVTyhiwKGi9v+O9mhKp/zAKOkx
 tDZ2L7USpcenVC1/knYAThGNKwx58bONniwRCkDjUuVNnEcX9F2PWfnZ5XMxrnP/nFordrUMCN
 71lNUkRw/N+na2iWL92oBHhf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 15:49:04 -0700
IronPort-SDR: psyq/078KpDJTpjqVuShOwUDNSFat5G+nmnI1go/qJSRfbwJvmBUH7aKe8MkYm1LW8v3RLU0xH
 hXuyEDeNY6wDQ1lv/uhkPwFg8QwZl+HlzpGIilH8uOunBaOgBFTf0kpcAne5wKRs8wniq9PZ8k
 74b8EqZWnTaTp5Zzr0sDiZGnt4ozYUkx6ZPlrV5DI7irFvNdn5m9P8hDKLeC+eZz3dTAPx34Y0
 /QaANidmR5rL+F8FdKeaeuiTHYb47oyQ7LPUh/PGQE0tA5CNRb7O/sc8rq3Lr+9Me13oAX2yC1
 Dk0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 16:30:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPJMH54dJz1SHwl
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:30:51 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655422250; x=1658014251; bh=3JUll1cokzNoMWjmBVYm6Y8IVuyZM8XJyZI
        /cVxZcV0=; b=QrmRAjk+25AzX0pmuPjm21UbJvARRDhpRqZ8MwiHGxi+ExbXMdm
        KfWGaMfH86r+rqGZFUK3ugIbHq8FopF/CgqfnQjd0OTiUR90tAxXL6VqAHOOhkZI
        KGSDWUHHy0BNQh8nGkS6W5bM7aRI2w6QGd02G+8eSVrcXCm06MiM+4YsMB/nKjL9
        Eq6GwkqowHdlry39C7IEa89LanvFqo0WItYGNC0Sj+wKmyYDuQqTESGipfgGpCcD
        kQQ/njwlbMb6i/SpGKFXo/J5VGgQktL/Fxf9h/1MtXdl4dGOVzCxttSvCxDwQAPU
        Ob7mFLLGyECGCgsJNZjX0S84j5RQ0W46SKQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jNndvV7N6fsq for <linux-kernel@vger.kernel.org>;
        Thu, 16 Jun 2022 16:30:50 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPJMC59mkz1Rvlc;
        Thu, 16 Jun 2022 16:30:47 -0700 (PDT)
Message-ID: <ab75c1ca-986f-c3af-6c8c-c2c5b7e40bbd@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 08:30:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [dm-devel] [PATCH v7 02/13] block: allow blk-zoned devices to
 have non-power-of-2 zone size
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>, hch@lst.de,
        snitzer@redhat.com, axboe@kernel.dk
Cc:     pankydev8@gmail.com, gost.dev@samsung.com,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Luis Chamberlain <mcgrof@kernel.org>,
        jonathan.derrick@linux.dev, Johannes.Thumshirn@wdc.com,
        dsterba@suse.com, jaegeuk@kernel.org
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615101931eucas1p15ed09ae433a2c378b599e9086130d8eb@eucas1p1.samsung.com>
 <20220615101920.329421-3-p.raghav@samsung.com>
 <857c444a-02b9-9cef-0c5b-2ecdb2fd46f6@acm.org>
 <e04db101-5628-2a1d-6b5c-997090484d7d@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e04db101-5628-2a1d-6b5c-997090484d7d@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 19:09, Pankaj Raghav wrote:
> On 2022-06-15 22:28, Bart Van Assche wrote:
> isk_name, zone->len);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (zone->len =3D=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
r_warn("%s: Invalid zone size", disk->disk_name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -ENODEV;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Don't allow zoned=
 device with non power_of_2 zone size with
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zone capacity les=
s than zone size.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>
>=20
>> Please change "power_of_2" into "power-of-2".
>>
> Ok.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!is_power_of_2(zone->=
len) && zone->capacity < zone->len) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
r_warn("%s: Invalid zone capacity for non power of 2
>>> zone size",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 disk->disk_name);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -ENODEV;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> The above check seems wrong to me. I don't see why devices that report=
 a
>> capacity that is less than the zone size should be rejected.
>>
> This was brought up by Damien during previous reviews. The argument was
> that the reason to allow non power-of-2 zoned device is to remove the
> gaps between zone size and zone capacity. Allowing a npo2 zone size wit=
h
> a different capacity, even though it is technically possible, it does
> not make any practical sense. That is why this check was introduced.
> Does that answer your question?

Add a comment explaining this restriction, clearly mentioning that it is =
a
Linux restrictions and not mandated by the specifications.

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Division is used =
to calculate nr_zones for both power_of_2
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and non power_of_=
2 zone sizes as it is not in the hot path.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>
>> Shouldn't the above comment be moved to the patch description? I'm not
>> sure whether having such a comment in the source code is valuable.
>>
> Yeah, I will remove it. Maybe it is very obvious at this point.
>>> +static inline sector_t blk_queue_offset_from_zone_start(struct
>>> request_queue *q,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sector_t sec)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 sector_t zone_sectors =3D blk_queue_zone_sectors(=
q);
>>> +=C2=A0=C2=A0=C2=A0 u64 remainder =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!blk_queue_is_zoned(q))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>
>> "return false" should only occur in functions returning a boolean. Thi=
s
>> function returns type sector_t.
>>
> Good catch. It was a copy paste mistake. Fixed it.
>> Thanks,
>>
>> Bart.
>=20
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel


--=20
Damien Le Moal
Western Digital Research
