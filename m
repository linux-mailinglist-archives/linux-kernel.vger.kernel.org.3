Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB82C4E4BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 06:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241812AbiCWFDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 01:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiCWFDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 01:03:09 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DAA7005E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 22:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648011700; x=1679547700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zX+D16SKwfz4XR87RtXxEgRjvTO4JhUbMk8F/P0g8+U=;
  b=f4FkFGa9WfDf2gphdVbc1nxw/yKnTMW3Lsm2kesFU20BgchKmM9rukdS
   NyBgcQerGq0PYEyZcxu2oe6dJHoWIqcEXpMnOjGTy7SUm4nXn1IN/P6DR
   tkUqXFGQgcDtZafNYoZJHckELgERu/Z4y8KzuR8n8FmV18T3ewczH+f2N
   wJKf5yRt48Sjv8xb0LJIrSECF++O7IvoO3IduQjG6VrBWMqpWL8Nw9iUC
   f4uLRXF160UXsym7LOPUZ9RjGmnzufZsHaPQM1TGAJYvQL398C6xY9MQV
   sZzPKAuuaV1QxXZEdchKO1eC6FQWSz8dTABnQJ9AeT1NhzV9c+GTLjAKo
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="196955931"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 13:01:39 +0800
IronPort-SDR: GwihVTbAcZCrKbs070vZz8Y0bh/Npv8U8qaiADhkAVMvT6t5IjIf09be4Z4G5CQuoM8/KIwlym
 22Anmj/09WZcQvZD3dtWKbM8prFRMq/AqeAH8EZBiLmtkZOdbBWoffqSGVbtJ1CmWNRhbxlffY
 f1hDxdMGio48S7HlQAP52eUKBtzgTW3gjrpqYINQaM5AcPPkDCnTANW1nIQOYaLhozbujn3QMO
 4KCOE+vQbe845bvCLVDrpuNk+2MhpUS1I13u4LSfHCleofGvujV5A69FGn1yab0hP+dqa6qhjY
 joMCMr3NU/Nd8moy4Oq5moju
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 21:32:36 -0700
IronPort-SDR: BxAlyHzEgA1rgC4Okqw2+W4hCXjIs0dkStJ7fgI4YDl+xU7+FBVyV/HIns9xCEtKvfDg7sVqey
 0pgezb1F04PMtAdnS2y7co6QtU2tw5URG27XySp/Aeapo4HWJUwVGdkpnaKtlCQwPW1kWbKNsG
 ULIAqyBzzOI4FEzzRy3ajtZT2+OHywBu32fCTpnQnYUN3sUtngDNkmyRX324QK8tHXrvqZA1U4
 ZjpdBeYdEF0BgO4q1VnTV3laT98v+r60lRzqayH3HrdRDRDYRNOttAGViQZ7k+f+mSznFvJZQ0
 J1k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 22:01:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KNbmf35GMz1Rwrw
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 22:01:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648011697; x=1650603698; bh=zX+D16SKwfz4XR87RtXxEgRjvTO4JhUbMk8
        F/P0g8+U=; b=BRD1AjcQ095l30t60rRZn0p0VnuDv0eBURgbcY0kvrU16lK003L
        U221xwqnkbBx42LSNQn/jti7evI3X7y0ol783S122roh+2Jt2g1RdjZLXCEHkhse
        YsKgi+ab3YEk0JHwaZjZQZQvsypRqhGZT4V1JyCbLA6uS1b2n79zSrGSZjbxGZjQ
        VNAw4aDP0ow5bcOwb9j62fLTFZcErnge1EY16wMnNNYP+TNDXfQ+WyH3kENPT/2s
        ay2gqp5Idd5PZMRdFqmfMayRJk6vpycSsxjmt0VGuS6oZjWkb9Xkwy/o8LsV/JMe
        aH9Nm9gCxeIcDgLJqSSYQ0HxksSEzDgEi3g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kQdNgDcsJZCn for <linux-kernel@vger.kernel.org>;
        Tue, 22 Mar 2022 22:01:37 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KNbmc3VvCz1Rvlx;
        Tue, 22 Mar 2022 22:01:36 -0700 (PDT)
Message-ID: <cc7b4426-f6a6-e6b1-4aaf-0a713ee3d388@opensource.wdc.com>
Date:   Wed, 23 Mar 2022 14:01:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for AMD 300
 Series Chipset SATA Controller
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
References: <20220321212431.13717-1-pmenzel@molgen.mpg.de>
 <20220321212431.13717-3-pmenzel@molgen.mpg.de>
 <BL1PR12MB5157DDFD5E75360F032346D3E2169@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <BL1PR12MB5157DDFD5E75360F032346D3E2169@BL1PR12MB5157.namprd12.prod.outlook.com>
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

On 3/22/22 06:51, Limonciello, Mario wrote:
> [Public]
>=20
>> -----Original Message-----
>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: Monday, March 21, 2022 16:25
>> To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Cc: Paul Menzel <pmenzel@molgen.mpg.de>; Hans de Goede
>> <hdegoede@redhat.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>; linux-ide@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for AMD =
300
>> Series Chipset SATA Controller
>>
>> AMD chipsets for AMD Ryzen contain two SATA controllers, for example o=
n
>> the
>> Dell OptiPlex 5055 Ryzen CPU/0P03DX:
>>
>>     01:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD]=
 300
>> Series Chipset SATA Controller [1022:43b7] (rev 02)
>>     07:00.2 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD]=
 FCH
>> SATA Controller [AHCI mode] [1022:7901] (rev 51)
>>
>> The 300 Series Chipset SATA Controller [1022:43b7] does not need the 2=
00 ms
>> delay before debouncing the PHY in `sata_link_resume()`, so skip it by
>> mapping it to the board with no debounce delay.
>>
>> Tested on the Dell OptiPlex 5055 Ryzen CPU/0P03DX, BIOS 1.1.50 07/28/2=
021
>> Linux 5.17 with an HDD connected to ata1 connected to 01:00.1, and no =
other
>> storage devices. (Only ata9 is connected to 07:00.2.)
>>
>> Currently, without this patch (with 200 ms delay), device probe for at=
a1
>> takes 468 ms (=3D 0.896 s - 0.428 s), ata2 takes 840 ms, ata5 takes 1,=
125 ms,
>> and ata6 takes 1,464 ms:
>>
>>     [    0.427251] calling  ahci_pci_driver_init+0x0/0x1a @ 1
>>     [    0.427271] ahci 0000:01:00.1: version 3.0
>>     [    0.427371] ahci 0000:01:00.1: SSS flag set, parallel bus scan =
disabled
>>     [    0.427405] ahci 0000:01:00.1: AHCI 0001.0301 32 slots 8 ports =
6 Gbps 0x33
>> impl SATA mode
>>     [    0.427409] ahci 0000:01:00.1: flags: 64bit ncq sntf stag pm le=
d clo only pmp
>> pio slum part sxs deso sadm sds apst
>>     [    0.427814] scsi host0: ahci
>>     [    0.427895] scsi host1: ahci
>>     [    0.427968] scsi host2: ahci
>>     [    0.428038] scsi host3: ahci
>>     [    0.428113] scsi host4: ahci
>>     [    0.428184] scsi host5: ahci
>>     [    0.428255] scsi host6: ahci
>>     [    0.428325] scsi host7: ahci
>>     [    0.428352] ata1: SATA max UDMA/133 abar m131072@0xf0600000 por=
t
>> 0xf0600100 irq 36
>>     [    0.428356] ata2: SATA max UDMA/133 abar m131072@0xf0600000 por=
t
>> 0xf0600180 irq 36
>>     [    0.428359] ata3: DUMMY
>>     [    0.428360] ata4: DUMMY
>>     [    0.428362] ata5: SATA max UDMA/133 abar m131072@0xf0600000 por=
t
>> 0xf0600300 irq 36
>>     [    0.428365] ata6: SATA max UDMA/133 abar m131072@0xf0600000 por=
t
>> 0xf0600380 irq 36
>>     [    0.428368] ata7: DUMMY
>>     [    0.428369] ata8: DUMMY
>>     [    0.428481] ahci 0000:07:00.2: AHCI 0001.0301 32 slots 1 ports =
6 Gbps 0x1
>> impl SATA mode
>>     [    0.428486] ahci 0000:07:00.2: flags: 64bit ncq sntf ilck pm le=
d clo only pmp
>> fbs pio slum part
>>     [    0.428611] scsi host8: ahci
>>     [    0.428639] ata9: SATA max UDMA/133 abar m4096@0xf0108000 port
>> 0xf0108100 irq 38
>>     [    0.428653] initcall ahci_pci_driver_init+0x0/0x1a returned 0 a=
fter 1367
>> usecs
>>     [=E2=80=A6]
>>     [    0.531949] ata9: SATA link down (SStatus 0 SControl 300)
>>     [    0.895730] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 3=
00)
>>     [    0.924392] ata1.00: ATA-8: ST500LM021-1KJ152, 0005SDM1, max
>> UDMA/133
>>     [    0.924410] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (de=
pth 32)
>>     [    0.963276] ata1.00: configured for UDMA/133
>>     [    0.963355] scsi 0:0:0:0: Direct-Access     ATA      ST500LM021=
-1KJ15 SDM1
>> PQ: 0 ANSI: 5
>>     [    0.963478] sd 0:0:0:0: Attached scsi generic sg0 type 0
>>     [    0.963568] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks=
: (500 GB/466
>> GiB)
>>     [    0.963594] sd 0:0:0:0: [sda] 4096-byte physical blocks
>>     [    0.963616] sd 0:0:0:0: [sda] Write Protect is off
>>     [    0.963631] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>>     [    0.963644] sd 0:0:0:0: [sda] Write cache: enabled, read cache:=
 enabled,
>> doesn't support DPO or FUA
>>     [    0.974119]  sda: sda1 sda2 sda3
>>     [    0.974299] sd 0:0:0:0: [sda] Attached SCSI disk
>>     [    1.268377] ata2: SATA link down (SStatus 0 SControl 300)
>>     [    1.580394] ata5: SATA link down (SStatus 0 SControl 300)
>>     [    1.892390] ata6: SATA link down (SStatus 0 SControl 300)
>>
>> With this patch (no delay) device probe for ata1 takes 268 ms
>> (=3D 0.696 s - 0.428 s), ata2 takes 440 ms, ata5 takes 545 ms, and ata=
6 takes
>> 650 ms:
>>
>>     [    0.426850] calling  ahci_pci_driver_init+0x0/0x1a @ 1
>>     [    0.426869] ahci 0000:01:00.1: version 3.0
>>     [    0.426970] ahci 0000:01:00.1: SSS flag set, parallel bus scan =
disabled
>>     [    0.427004] ahci 0000:01:00.1: AHCI 0001.0301 32 slots 8 ports =
6 Gbps 0x33
>> impl SATA mode
>>     [    0.427008] ahci 0000:01:00.1: flags: 64bit ncq sntf stag pm le=
d clo only pmp
>> pio slum part sxs deso sadm sds apst
>>     [    0.427412] scsi host0: ahci
>>     [    0.427493] scsi host1: ahci
>>     [    0.427569] scsi host2: ahci
>>     [    0.427653] scsi host3: ahci
>>     [    0.427728] scsi host4: ahci
>>     [    0.427801] scsi host5: ahci
>>     [    0.427876] scsi host6: ahci
>>     [    0.427950] scsi host7: ahci
>>     [    0.427978] ata1: SATA max UDMA/133 abar m131072@0xf0600000 por=
t
>> 0xf0600100 irq 36
>>     [    0.427982] ata2: SATA max UDMA/133 abar m131072@0xf0600000 por=
t
>> 0xf0600180 irq 36
>>     [    0.427985] ata3: DUMMY
>>     [    0.427986] ata4: DUMMY
>>     [    0.427988] ata5: SATA max UDMA/133 abar m131072@0xf0600000 por=
t
>> 0xf0600300 irq 36
>>     [    0.427991] ata6: SATA max UDMA/133 abar m131072@0xf0600000 por=
t
>> 0xf0600380 irq 36
>>     [    0.427994] ata7: DUMMY
>>     [    0.427995] ata8: DUMMY
>>     [    0.428116] ahci 0000:07:00.2: AHCI 0001.0301 32 slots 1 ports =
6 Gbps 0x1
>> impl SATA mode
>>     [    0.428124] ahci 0000:07:00.2: flags: 64bit ncq sntf ilck pm le=
d clo only pmp
>> fbs pio slum part
>>     [    0.428250] scsi host8: ahci
>>     [    0.428278] ata9: SATA max UDMA/133 abar m4096@0xf0108000 port
>> 0xf0108100 irq 38
>>     [    0.428295] initcall ahci_pci_driver_init+0x0/0x1a returned 0 a=
fter 1409
>> usecs
>>     [=E2=80=A6]
>>     [    0.532308] ata9: SATA link down (SStatus 0 SControl 300)
>>     [=E2=80=A6]
>>     [    0.696316] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 3=
00)
>>     [    0.725963] ata1.00: ATA-8: ST500LM021-1KJ152, 0005SDM1, max
>> UDMA/133
>>     [    0.725982] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (de=
pth 32)
>>     [    0.764845] ata1.00: configured for UDMA/133
>>     [    0.764932] scsi 0:0:0:0: Direct-Access     ATA      ST500LM021=
-1KJ15 SDM1
>> PQ: 0 ANSI: 5
>>     [    0.765056] sd 0:0:0:0: Attached scsi generic sg0 type 0
>>     [    0.765120] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks=
: (500 GB/466
>> GiB)
>>     [    0.765147] sd 0:0:0:0: [sda] 4096-byte physical blocks
>>     [    0.765175] sd 0:0:0:0: [sda] Write Protect is off
>>     [    0.765189] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>>     [    0.765198] sd 0:0:0:0: [sda] Write cache: enabled, read cache:=
 enabled,
>> doesn't support DPO or FUA
>>     [    0.866546]  sda: sda1 sda2 sda3
>>     [    0.867239] sd 0:0:0:0: [sda] Attached SCSI disk
>>     [    0.868330] ata2: SATA link down (SStatus 0 SControl 300)
>>     [    0.973337] ata5: SATA link down (SStatus 0 SControl 300)
>>     [    1.077832] ata6: SATA link down (SStatus 0 SControl 300)
>>
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2: New patch for second SATA controller in Ryzen systems
>>
>>  drivers/ata/ahci.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index 44b79fe43d13d..ac7f230c12ebc 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -453,6 +453,7 @@ static const struct pci_device_id ahci_pci_tbl[] =3D=
 {
>>  		.class_mask =3D 0xffffff,
>>  		board_ahci_al },
>>  	/* AMD */
>> +	{ PCI_VDEVICE(AMD, 0x43b7),
>> board_ahci_low_power_no_debounce_delay }, /* AMD 300 Series Chipset
>> SATA Controller */
>>  	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
>>  	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /*
>> AMD Hudson-2 (AHCI mode) */
>>  	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>> --
>> 2.30.2
>=20
> +Nehal from AMD
>=20
> I seem to recall that we were talking about trying to drop the debounce=
 delay for
> everything, weren't we?
>=20
> So perhaps it would be right to add a 4th patch in the series to do jus=
t that.  Then
> If this turns out to be problematic for anything other than the control=
lers in the
> series that you identified as not problematic then that 4th patch can p=
otentially
> be reverted alone?

Not quite everything :) But you are right, let's try to switch the defaul=
t
to no delay. I will be posting patches today for that.

Paul,

With these patches, your patches are not necessary anymore as the AMD
chipset falls under the default no-delay. It would be nice if you can tes=
t
though.


--=20
Damien Le Moal
Western Digital Research
