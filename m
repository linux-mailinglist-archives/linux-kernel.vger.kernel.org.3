Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BBB483EDF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiADJIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:08:47 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:47796 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229469AbiADJIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:08:47 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmxq0q13z1VSkV
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 01:08:47 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641287326; x=1643879327; bh=GYwwYfBVEdez+pCDhOX8DoTs/GFi9lmZ5Mo
        HYZ8c4j0=; b=l18M8CIgRrCoFjolJuD1X6Jv7ei3YikMvByud6Qgz7dCdroNzqZ
        3KMchs/P/vrLnB5paqakje8d6kYvSiiakFP4xHA4mGSqPtbMjvJoatFhMxjgTeRe
        gwZizAXTqDHGjONmakXQYS5Z5nH4r2Zc2afq1i52N2rhYVtS4TAVACihtrfmeJPX
        /IerProLSxd3XH/YbdWzxTsK9NfH7OHyx7ZrO4fj6yvQeYudu+OnscL+rx3M8nwo
        ZyqhKnnmAfwE6hePnRc1JQOFn+Leg+FS8JjWjsYFfpharC31MWvgAPtr3psgVtKr
        I7owI4FSe/zfgmwte90mzeTTS0RH2+n5vCQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dP_klBKg6Au9 for <linux-kernel@vger.kernel.org>;
        Tue,  4 Jan 2022 01:08:46 -0800 (PST)
Received: from [10.225.163.42] (unknown [10.225.163.42])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmxn65tBz1VSjC;
        Tue,  4 Jan 2022 01:08:45 -0800 (PST)
Message-ID: <27da2f5c-ca6c-1d64-3d05-5453f11e298f@opensource.wdc.com>
Date:   Tue, 4 Jan 2022 18:08:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 3/3] ahci: AMD A85 FCH (Hudson D4): Skip 200 ms
 debounce delay in `sata_link_resume()`
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211229161119.1006-1-pmenzel@molgen.mpg.de>
 <20211229161119.1006-3-pmenzel@molgen.mpg.de>
 <5c333718-eaa5-b41c-e8ea-59d6e01254aa@opensource.wdc.com>
 <19f6cd93-9bd7-60dc-4471-18022bcf456c@molgen.mpg.de>
 <7b64d1c3-f798-d64b-9ee3-9669d98f4e28@opensource.wdc.com>
 <fbfd865f-c88c-6ee1-6cb9-8194e170cd3a@molgen.mpg.de>
 <c6748a52-fc8f-3309-31c2-973a9e69a7e8@opensource.wdc.com>
 <33deca4a-abed-123c-9530-3f15740a3261@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <33deca4a-abed-123c-9530-3f15740a3261@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 17:49, Paul Menzel wrote:
> [cc: -dmitry, -guenter]
>=20
> Dear Damien,
>=20
>=20
> Am 04.01.22 um 09:36 schrieb Damien Le Moal:
>> On 12/31/21 16:08, Paul Menzel wrote:
>=20
>>> Am 31.12.21 um 01:52 schrieb Damien Le Moal:
>>>> On 12/30/21 20:08, Paul Menzel wrote:
>>>>>>>     	board_ahci_nomsi,
>>>>>>>     	board_ahci_noncq,
>>>>>>>     	board_ahci_nosntf,
>>>>>>> @@ -141,6 +142,13 @@ static const struct ata_port_info ahci_port_=
info[] =3D {
>>>>>>>     		.udma_mask	=3D ATA_UDMA6,
>>>>>>>     		.port_ops	=3D &ahci_ops,
>>>>>>>     	},
>>>>>>> +	[board_ahci_nodbdelay] =3D {
>>>>>>> +		.flags		=3D AHCI_FLAG_COMMON,
>>>>>>> +		.link_flags	=3D ATA_LFLAG_NO_DB_DELAY,
>>>>>>> +		.pio_mask	=3D ATA_PIO4,
>>>>>>> +		.udma_mask	=3D ATA_UDMA6,
>>>>>>> +		.port_ops	=3D &ahci_ops,
>>>>>>> +	},
>>>>>>>     	[board_ahci_nomsi] =3D {
>>>>>>>     		AHCI_HFLAGS	(AHCI_HFLAG_NO_MSI),
>>>>>>>     		.flags		=3D AHCI_FLAG_COMMON,
>>>>>>> @@ -437,6 +445,7 @@ static const struct pci_device_id ahci_pci_tb=
l[] =3D {
>>>>>>>     		board_ahci_al },
>>>>>>>     	/* AMD */
>>>>>>>     	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE), boar=
d_ahci },
>>>>>>> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_AHCI), board_=
ahci_nodbdelay },
>>>>>>
>>>>>> Patch 1 introduces this macro in pci_ids.h, but it is used only he=
re. So
>>>>>> to keep with the current style in this structure, drop the macro (=
so
>>>>>> drop patch 1).
>>>>>
>>>>> I wait for your answer of the second patch, and then I am going to =
sent v4.
>>>>
>>>> Let's use the numeric value. No macro definition needed.
>>>
>>> Alright. I am going to follow the maintainers wishes.
>>>
>>>>>>>     	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>>>>>>>     	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Gree=
n Sardine */
>>>>>>>     	/* AMD is using RAID class only for ahci controllers */
>>>>>
>>>>> Do you have a AHCI device at hand, where you could also test if
>>>>> everything works fine without the delay?
>>>>
>>>> Unfortunately, I do not have any board with this adapter.
>>>
>>> Sorry, we misunderstand each other. (I wrote a reply to my own patch =
[1].)
>>>
>>> I think the delay is not necessary for any modern AHCI controller. It=
=E2=80=99d
>>> be great, if you could test, if it=E2=80=99s also true on the systems=
 you have
>>> by just skipping the delay.
>>
>> I need to figure out how to safely test suspend/resume remotely (worki=
ng
>> from home) :)
>=20
> Please note, I tested the cold bootup, where `sata_link_resume()` is=20
> also run.

OK. So it should be easy to test. Will try to have a look.

>=20
>> It would indeed be great to have the default as "no delay on resume" a=
nd
>> add the delay only for chipsets that need it. However, it is unclear
>> which chipset need the delay, right?
>=20
> Yes, it=E2=80=99s unclear for what chipset (PHY?) it was added, as the =
git=20
> history i not available in the repository, and I have not found it yet.
>=20
>> So I think we are stuck with switching chipsets to "no delay" one by
>> one by testing. Once the majority of drivers are converted, we can
>> reverse the default to be "no delay" and mark untested drivers as
>> needing the delay.
>=20
> For easy testing, a new CLI parameter to skip the delay might be handy.

You mean a sysfs attribute may be ?
I am not sure it would help: on resume, the sysfs attributes would be
recreated and get the default value, not a new one.

>=20
>=20
> Kind regards,
>=20
> Paul
>=20
>=20
>>> [1]: https://lore.kernel.org/linux-ide/20211227162658.11314-2-pmenzel=
@molgen.mpg.de/T/#m697d2121463a4c946730e6b83940e12d6d7e6700


--=20
Damien Le Moal
Western Digital Research
