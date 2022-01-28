Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA7149F6CD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240824AbiA1KEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:04:12 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48694 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbiA1KEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643364249; x=1674900249;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VHAVogYDyw22JTHOt2TtkKyQMqwG0z2oVJZeVnq1/LM=;
  b=H6ZRAG+MWe+B2hnSVCerNm4clxSl9++WTVtgvZAqXEv/AQ4SwkLuCQSI
   po3GETZYzmmMzPC5G8muf7LMg2uZEbMAAqOoFU/tQH5voccQRRWvsFYc7
   JIy+aWevWZn0PHXE3o9aDFStcTr3JhHYOg4aP+c+71m5P7kqwl604G5Te
   wqQXJxxu0rbnfYULql/VfFJ8HodIZ67Pb5S1CZCcRX0dcEtQp2QKl9GSc
   6OckC/1py++88UKqlGQwTosbvkPuEn3eAgtMFsh3ytBE01eXQ+QCVlpSI
   mS5Y3yJ9SlvkFPy1xLY0S3/CKakEr2HC24kbHbXzAcOeHm1WsqkxHOAd0
   A==;
X-IronPort-AV: E=Sophos;i="5.88,323,1635177600"; 
   d="scan'208";a="196425456"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2022 18:04:09 +0800
IronPort-SDR: Q4ssH77w1M3LXCvXALFMHjxbRAmGv1hBkDE6pOopI6OYj9M2sLWegUbrDEsNZOfRmEPW9PK4fu
 ASQUIVdC+mLH58W3IsSuNPNoFZW0+zPQ6c0BWNINu/8kLY23okVuxGvj/kaF7t2sAxO6dQ6Fux
 BGKbCASnWAdzWN9DVrr3jBukFJHtyA4rGz2JOyJ2IYWbUARl608kB0wio0YlxTgkhRL7lL62yL
 m3WfNTO5diG/DVUBHHyYNbKRrdQG4ke420pRgLjdL8hH1oafja6OcqHNbLE1FsngNusDDKeNRy
 UD0R7jw57K5R9DOj86Dxp8dK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 01:37:26 -0800
IronPort-SDR: q0TDLOhbH6xrbxdTS6jiuTEbXxFMSMYMqIhF1+18cRhgCckdGICi2krEOer/fiXdn827w5xMq6
 d/9gS37N5RF08hqEE51Ep/sdra4dLkIpsasBcF45/Ry7f7GjA4ub3xnhQ4wDNSNSCKBXAcF0bl
 LnyGJ0yYxkjvJaSt0MDk74jgUvrIiZvkjDzkaVgfy4b4UHzInGgjpM/KFkNdJHJ1CkYr1zlKZ+
 YKzKtDHmcsfZUyisrOlicTVo8zyCexrw6/oWRYmuSSpq8I92O3c8UnPc/aUlFNSvGOmCWETeKa
 4Hk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 02:04:10 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JlY2f0YN5z1SHwl
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 02:04:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643364249; x=1645956250; bh=VHAVogYDyw22JTHOt2TtkKyQMqwG0z2oVJZ
        eVnq1/LM=; b=E0UKMTPjtALp3woJU4iYluBfw3Bfg/wPsP6e14Kbu6/Jzk+A0r7
        i+borCzkJTqqyeDCoOgeVHw6LtPFRlXi/VDILqgawLJCMYsxRxsF2RLncoexxH+0
        mCFaXOo8YIqrH5leOqGw/QbnPZ3QgOwCgvm68YyHG+yoHb1jCUOVyz5qBb/Furwv
        iJNlSxAg+E4AGFRFwqPLsyTa5doAvT5AwGx0YwNOSS/z25Kg1v5FLzx9uH85GcJo
        jsKqMfjThJ0QWe74mbs56YozMStRzZHgsFZejTMN0HWXlWgVJIh8b7vxoCmNqisB
        bTrFqt+Oj0/60IL8tscZuixohbHAp9PqMJQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oPNovAKjYgiH for <linux-kernel@vger.kernel.org>;
        Fri, 28 Jan 2022 02:04:09 -0800 (PST)
Received: from [10.225.163.58] (unknown [10.225.163.58])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JlY2d0rs0z1RvlN;
        Fri, 28 Jan 2022 02:04:08 -0800 (PST)
Message-ID: <0f358fbf-81c2-290e-ca75-d2d28e26a711@opensource.wdc.com>
Date:   Fri, 28 Jan 2022 19:04:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: ahci: Skip 200 ms debounce delay for Marvell
 88SE9235
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220127233527.445659-1-pmenzel@molgen.mpg.de>
 <1ef3e995-3f61-ef53-0d5e-03bb41a52624@opensource.wdc.com>
 <d9c4e80e-87ca-9e68-f97d-d2c709e54ff3@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d9c4e80e-87ca-9e68-f97d-d2c709e54ff3@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 18:58, Paul Menzel wrote:
> Dear Damien,
>=20
>=20
> Thank you for the quick reply.
>=20
>=20
> Am 28.01.22 um 00:40 schrieb Damien Le Moal:
>> On 1/28/22 08:35, Paul Menzel wrote:
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
>>> Without this patch (with 200 ms delay):
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
>>> With patch (no delay):
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
>> Looks good. But for the commit message, instead of the dmesg copy-past=
e,
>> could you simply write the gains in terms of shortened scan time ? Tha=
t
>> would make it easier to understand the benefits of the patch.
>=20
> I can do:
>=20
>> Tested on IBM S822LC with current Linux 5.17-rc1, and the 200 ms is
>> gone, and the drives are still detected.
> I would still like to keep the Linux logs, as then it=E2=80=99s clear w=
hat I=20
> tested with (drives), and what ports were populated.

OK. Keep the dmesg log if you want, but add the summary. Something like:

Without this patch (with 200 ms delay): device probe takes X ms

<dmesg>

With patch (no delay): device probe takes Y ms

<dmesg>

>=20
>> Also, there is no need for the lspci output.
>=20
> In my opinion, it prooves I used the correct PCI vendor and device=20
> codes, and also shows the revision number of the device I tested with.

Fine.

>=20
>=20
> Kind regards,
>=20
> Paul


--=20
Damien Le Moal
Western Digital Research
