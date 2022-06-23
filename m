Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1D557548
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiFWIWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiFWIWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:22:32 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DE748338
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655972549; x=1687508549;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=gNpD1bVqKlbsMksw4J8hMe8jV69hgwr3fUwwPSY2qLA=;
  b=qAhq1bT7pxdyh56n/a0Ym9U7LTvD5Fd3ta6J2KL4G22V32iqPzq8jw2W
   mH2Ck9S1/Zrw81eHoSuFkZhX2Y5x2212R+bazOVYDrCDmpL7pWR8OY3r+
   EgBcb23HI+wxN9yiM/9HHxQL0oPQs/KuTYIhzuZ2xiN0TDtR6dD7uZuuO
   lm42gi2NKsbiQixryfjKCnPvGnLE8kUhNyOQXeUAyfFYPekaBDLutclko
   /uzXb1WWHCa8rqpW7iL/vyPiYX3fBQcD3zCj9gmpTZgHhUtuHTiMYAtr6
   wGRF3ezEt3kVWzvKeht+Kgw6QrKzs+EL1PLLDvVrf8ekYOhdco68K/1WT
   w==;
X-IronPort-AV: E=Sophos;i="5.92,215,1650902400"; 
   d="scan'208";a="208765632"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2022 16:22:28 +0800
IronPort-SDR: XDXLo5ApAaRhi0afwnW74uDZsVX0lSUIPDN8rnv4CBqp63QZ1cWjeRrI4ezv7vJ5sGoPv0UCJ+
 RMlCwCXBue4SoLbv1oV3+H3OdeZ8Dk5Kz3+p8StJ4SRuFKRnUYKEjpWihza0vV7UmZP43a8t5m
 oG6q7TWA4GsN+sohKZTY2SCMU7tR9mri6kPaclpdZp4XCUJKyUQu8C3rK0UX+dxX4NTu6rTSiC
 m4zHKhW6HH1Orx9pKaUUhTLdXDC4HbiXWhXy91tFootiWiQ54hEUNSWSIcBiyT4Iy4+KkyIOyc
 0AkGiLAI7fse701pG39+mTrn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 00:44:58 -0700
IronPort-SDR: 2hazUpMPcBpzorNqrDgkm+cC+yZ+ALgqj+krYfhrFUdvN4hQVTqPkB9ewjOOjs3kN4+1gnbVTI
 PeNy+OgUbkYZ/PapUzpmAGt/weKWrNtsIIbakCuwch+SZ2ZDNnaRm0h0ub7QIaKG/r8cBgwfIL
 Lb+5CmlwAteWyu6hYp3U7R3thlgh+9gRoe+AMWpGjFW0DOFiGgf7RmyxFd3BSt9622YEzk4Fqq
 5WwVRrsxqvJS0buTPqtWkHGOPNDYeufxwFBiFgMuUNKUmAgS8SOD+8ZnnkE+ShiYY86sJVErdf
 xPw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 01:22:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTCsy0HYjz1Rwnx
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:22:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655972549; x=1658564550; bh=gNpD1bVqKlbsMksw4J8hMe8jV69hgwr3fUw
        wPSY2qLA=; b=PAibzQuoVnPczN2jLQ68p94iASR4uLcJfBZHQqcQDsJaW2YfISQ
        cQpMlHIFZIte6e/DJ1vIzK9Nx5B24TRuxsYoTbQ3vZ6Ng8m9MhT1cbnRikYbEgNM
        xaF93brbXSVsXrYRZIiTOhfzIdvRTPMLwer9bZbnDWpL1j1JhzMryjNmTVwvsfoJ
        XbActMEXZhie+v6RhoYu5GwFaEK5O0pu0N0DcOeJJYvs5ijWZJZNTPOVoatWBLPw
        vsUURP7qsOwp2hd7x7sX3KGcoNT9zrYfAjiFPGjVuTiZpDgGX3rkJAP+HCFcytxY
        Vn+LkB07Rdz/ZPQuHRiv75FjwtZQvLSv3sg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1aTqyC4z-ea2 for <linux-kernel@vger.kernel.org>;
        Thu, 23 Jun 2022 01:22:29 -0700 (PDT)
Received: from [10.225.163.90] (unknown [10.225.163.90])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTCsw5vFCz1RtVk;
        Thu, 23 Jun 2022 01:22:28 -0700 (PDT)
Message-ID: <09091cc4-f652-0978-bb6a-b63f24fdcf49@opensource.wdc.com>
Date:   Thu, 23 Jun 2022 17:22:27 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <78c29f43-3b67-8e70-0711-14e997f3efb1@gmail.com>
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

On 6/23/22 16:47, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n wrote:
> 2022. 02. 08. 9:07 keltez=C3=A9ssel, Damien Le Moal =C3=ADrta:
>> On 2/4/22 21:57, zboszor@pr.hu wrote:
>>> From: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gmail.com>
>>>
>>> This device is a CF card, or possibly an SSD in CF form factor.
>>> It supports NCQ and high speed DMA.
>>>
>>> While it also advertises TRIM support, I/O errors are reported
>>> when the discard mount option fstrim is used. TRIM also fails
>>> when disabling NCQ and not just as an NCQ command.
>>>
>>> TRIM must be disabled for this device.
>>>
>>> Signed-off-by: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gmail.=
com>
>>> ---
>>>   drivers/ata/libata-core.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index 67f88027680a..4a7f58fcc411 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -4028,6 +4028,7 @@ static const struct ata_blacklist_entry ata_dev=
ice_blacklist [] =3D {
>>>  =20
>>>   	/* devices that don't properly handle TRIM commands */
>>>   	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
>>> +	{ "M88V29*",			NULL,	ATA_HORKAGE_NOTRIM, },
>>>  =20
>>>   	/*
>>>   	 * As defined, the DRAT (Deterministic Read After Trim) and RZAT
>> Applied to for-5.17-fixes. Thanks !
>=20
> Thank you. However, I have second thoughts about this patch.
> The device advertises this:
>=20
> # hdparm -iI /dev/sda
> ...
>  =C2=A0Enabled Supported
>  =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 Data Set Management TRIM suppor=
ted (limit 1 block)
> ...
>=20
> but the I/O failures always reported higher number of blocks,
> IIRC the attempted number of block was 8 or so.
>=20
> Can the kernel limit or split TRIM commands according to the
> advertised limit? If not (or not yet) then the quirk is good for now.

Yes, the kernel does that. See the sysfs queue attributes
discard_max_bytes and discard_max_hw_bytes. What are the values for your
device ? I think that the "limit 1 block" indicated by hdparm is simply t=
o
say that the DSM command (to trim the device) accept only at most a 1
block (512 B) list of sectors to trim. That is not the actual trim limit
for each sector range in that list.

>=20
> Best regards,
> Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi
>=20


--=20
Damien Le Moal
Western Digital Research
