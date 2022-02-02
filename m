Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C11C4A7B72
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347996AbiBBXGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:06:02 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37044 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbiBBXGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643843160; x=1675379160;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NGAPUIaEsO3aMi4Qi5/6U7okQHSqH+e13bpfc7DdLHM=;
  b=qDg8C9Ko+x7QG3HsjqR12qyYfM1qFCSN9YK5L3b4zRfoA3OQHbUDtFFH
   LFySib4QFePKK44oVqNBOoowz5qkptH8ngQQ5qfQyzyNl6fcPO3Jt2urb
   +xov7r6ezqdKFBe7OPR0157Bd1btoI2kCBj4KdVX8Bj/oK32blbF0UpxF
   A1PnLixXdZ7n6rChesflFYIC2lw0xSlJDt0qInQCX1XwH7lMuWNyz0kJg
   m+VJvTh3lDUGRp/KT1r7bega9VDC1l1ybUT1cHKfEbSg2U+kVBB+ArzgC
   5YVR3tGLnUQQCoRzCkhJcqTitVJ4mVFEOc0dd6mOUX3JyRqkr3TfQ1q1d
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635177600"; 
   d="scan'208";a="303919051"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2022 07:06:00 +0800
IronPort-SDR: w3rITx7u64h9l7Gs0DxFQOWSJ66YqBkKyhQY9NdiSLQ+eDQH9mznLldinTDscQpRVaMKZQ5igL
 zBy35UN7Fop2njsGuivoFAKtOJdL6OT6B90+XjrblRRx4qmrUJgtjmJy2A1P8LJPl68v7irSKm
 Z6T03Md8PgMqKekNOuu6+VfxV0HDHdX45BbtBAppRjMa2cy7v+tR8bhRMUrybgR0d7BEA4EsbS
 h9XrVV8OpKNL6sy1DdVbysHCxN8IZOAMGo0ilRUIkBMVRfzyR1aQcZ7mRYZFirTsucPX9bSm3F
 tyxUJ4NOyllljvh3JAKMmeKH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 14:37:56 -0800
IronPort-SDR: ftyKrt3ILxfzb2UOfu3Akc9JANp53aYr75j57tII6FjRZqNVF4NpgVsg14B2Ip7jY7EmsAyyqm
 KPL0PDcAXaec80Bg8kyir9HxQJd6B7TrdhVRzrChMLc7AkO5E+uPg0xW9STqE4CFiJz13W/XFg
 XgOrnRrGFX2TcP/PFkhMoF1rzrlx0fg2Ex2ppRBojKqaGFTmOSvAbMxH9dqvVMB0W/4dqSls5V
 hhMmFdj/rspdXkra/17GgiLCBg/Iffj5S8GtvoLhmMYfpxZbha4irQnqIJt7ZfEIut9iOTPC5p
 iWE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 15:06:00 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jpy8S2h6Kz1SHwl
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 15:06:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643843160; x=1646435161; bh=NGAPUIaEsO3aMi4Qi5/6U7okQHSqH+e13bp
        fc7DdLHM=; b=DmwBwvL8JdQwxqr+0u5QQHfL1N/bm1iaCFzl/t6TFW4LhOvYZje
        sEOXYMYtMt28Qs9HnKtfjz/w3x0JJ5fFQa4klOFR7GpClrDJefY+QtDxPPqrQFAp
        oCGWkjrWimfSgUrGk5UbI5uloqp7dAzRnTsxmAlMLSOBtiRRZhAM6jUW6rPff+J7
        Ej7k6KbYnV5/xizXYRurm2I7eMtgDPlHAAh+DcO//H85JuQ2siPcJiWU9MW9HwLf
        My5fC3ciN74wROLaApDcWMsHapuF2TABsLVK7/zuHGJ2EwefyUnK9tZfLwL4y1i8
        JSXJZk8oNd3jCm0ZiTdDtr0JwNWNGu5vzNQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QzpI0JePljn4 for <linux-kernel@vger.kernel.org>;
        Wed,  2 Feb 2022 15:06:00 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jpy8R2fB7z1Rwrw;
        Wed,  2 Feb 2022 15:05:59 -0800 (PST)
Message-ID: <4c3df325-dc9f-5eed-5585-7d2e5203b65f@opensource.wdc.com>
Date:   Thu, 3 Feb 2022 08:05:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] ata: ahci: Skip 200 ms debounce delay for Marvell
 88SE9235
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220201071229.6418-1-pmenzel@molgen.mpg.de>
 <3437ffcb-68b5-04e5-acd5-b3857fbf1be7@opensource.wdc.com>
 <1378dd0a-52d2-c998-5713-e6875c601194@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1378dd0a-52d2-c998-5713-e6875c601194@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 23:29, Paul Menzel wrote:
> Dear Damien,
>=20
>=20
> Am 02.02.22 um 09:14 schrieb Damien Le Moal:
>> On 2/1/22 16:12, Paul Menzel wrote:
>>> The 200 ms delay before debouncing the PHY in `sata_link_resume()` is
>>> not needed for the Marvell 88SE9235.
>>>
>>>      $ lspci -nn -s 0021:0e:00.0
>>>      0021:0e:00.0 SATA controller [0106]: Marvell Technology Group Lt=
d. 88SE9235 PCIe 2.0 x2 4-port SATA 6 Gb/s Controller [1b4b:9235] (rev 11=
)
>>>
>>> So, remove it. Tested on IBM S822LC with current Linux 5.17-rc1:
>>>
>>> Currently, without this patch (with 200 ms delay), device probe for a=
ta1
>>> takes 485 ms:
>>>
>>>      [    3.358158] ata1: SATA max UDMA/133 abar m2048@0x3fe881000000=
 port 0x3fe881000100 irq 39
>>>      [    3.358175] ata2: SATA max UDMA/133 abar m2048@0x3fe881000000=
 port 0x3fe881000180 irq 39
>>>      [    3.358191] ata3: SATA max UDMA/133 abar m2048@0x3fe881000000=
 port 0x3fe881000200 irq 39
>>>      [    3.358207] ata4: SATA max UDMA/133 abar m2048@0x3fe881000000=
 port 0x3fe881000280 irq 39
>>>      [=E2=80=A6]
>>>      [    3.677542] ata3: SATA link down (SStatus 0 SControl 300)
>>>      [    3.677719] ata4: SATA link down (SStatus 0 SControl 300)
>>>      [    3.839242] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl=
 300)
>>>      [    3.839828] ata2.00: ATA-10: ST1000NX0313         00LY266 00L=
Y265IBM, BE33, max UDMA/133
>>>      [    3.840029] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (=
depth 32), AA
>>>      [    3.841796] ata2.00: configured for UDMA/133
>>>      [    3.843231] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl=
 300)
>>>      [    3.844083] ata1.00: ATA-10: ST1000NX0313         00LY266 00L=
Y265IBM, BE33, max UDMA/133
>>>      [    3.844313] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (=
depth 32), AA
>>>      [    3.846043] ata1.00: configured for UDMA/133
>>>
>>> With this patch (no delay) device probe for ata1 takes 273 ms:
>>>
>>>      [    3.624259] ata1: SATA max UDMA/133 abar m2048@0x3fe881000000=
 port 0x3f e881000100 irq 39
>>>      [    3.624436] ata2: SATA max UDMA/133 abar m2048@0x3fe881000000=
 port 0x3f e881000180 irq 39
>>>      [    3.624452] ata3: SATA max UDMA/133 abar m2048@0x3fe881000000=
 port 0x3f e881000200 irq 39
>>>      [    3.624468] ata4: SATA max UDMA/133 abar m2048@0x3fe881000000=
 port 0x3f e881000280 irq 39
>>>      [=E2=80=A6]
>>>      [    3.731966] ata3: SATA link down (SStatus 0 SControl 300)
>>>      [    3.732069] ata4: SATA link down (SStatus 0 SControl 300)
>>>      [    3.897448] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl=
 300)
>>>      [    3.897678] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl=
 300)
>>>      [    3.898140] ata1.00: ATA-10: ST1000NX0313         00LY266 00L=
Y265IBM, BE33, max UDMA/133
>>>      [    3.898175] ata2.00: ATA-10: ST1000NX0313         00LY266 00L=
Y265IBM, BE33, max UDMA/133
>>>      [    3.898287] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (=
depth 32), AA
>>>      [    3.898349] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (=
depth 32), AA
>>>      [    3.900070] ata1.00: configured for UDMA/133
>>>      [    3.900166] ata2.00: configured for UDMA/133
>>>
>>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>> ---
>>> v2: address comments for commit message (but forgot v2 tag)
>>> v3: resend with v3 tag in subject line/commit message summary
>>>
>>>   drivers/ata/ahci.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>> index ab5811ef5a53..edca4e8fd44e 100644
>>> --- a/drivers/ata/ahci.c
>>> +++ b/drivers/ata/ahci.c
>>> @@ -582,6 +582,8 @@ static const struct pci_device_id ahci_pci_tbl[] =
=3D {
>>>   	  .driver_data =3D board_ahci_yes_fbs },
>>>   	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
>>>   	  .driver_data =3D board_ahci_yes_fbs },
>>> +	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
>>> +	  .driver_data =3D board_ahci_no_debounce_delay },
>>>   	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 6=
42L */
>>>   	  .driver_data =3D board_ahci_yes_fbs },
>>>   	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0645), /* highpoint rocketraid 6=
44L */
>>
>> Applied to for-5.18 with commit title and message changes. The title i=
s now:
>>
>> ata: ahci: Add support for Marvell 88SE9235 adapter
>>
>> Since it is exactly what this patch is doing by adding a PCI ID.
>=20
> Thank you for applying the patch. I saw the summary/title change also=20
> with the other patch. I am sorry, but I totally disagree. Reading that=20
> summary/title in `git log --oneline`, it=E2=80=99s not clear at all, wh=
at the=20
> patch does, and the full description or diff has to be read. =E2=80=9CA=
dd=20
> support=E2=80=9D for me means, that it was unsupported before, which is=
 not true=20
> at all as the defaults were used.

Right... I did not consider the final entry in the ahci_pci_tbl table
which matches against the device against the PCI AHCI storage class.
So right you are. I will restore your original commit title/message.

Thanks for checking.

--=20
Damien Le Moal
Western Digital Research
