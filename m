Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68764460F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbhK2HSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:18:15 -0500
Received: from mail-bo1ind01olkn0176.outbound.protection.outlook.com ([104.47.101.176]:38019
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238207AbhK2HQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:16:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeR1PV/oYIvf3k/l7xJaxznbho+fBrwAED3Hndxi4+tbvRpapsBCIvQXKsdUX+gl6C4EFA9eZeS9ed8m+o/xN95GE7qRZEcNGa3icCq55QGZqMOwzaPfBfBfl9+FDqpouub22ymFDNXZPU36+HzzuB2V4TulWJ0c6ubsni9AXjPRlHWmJjf67d+hXv+t5GeS7Jk4WvMjiv6indkMQ7PK+DBGhZrT7WLLNg0c2XCRGG3ejRiXs0QhfVYB8OFLc5p0c1QmPXuj+LBq5RlTP1oEiziPlYv04AuxAXC6f3RQsr0MPrlJUzYgDOGyiQuEZaEiO9JXLWhPH/QwP4z5KeEPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtvWKxPXSoRKsc9u8N8IanHHc6I2lHmFKfS7adl394g=;
 b=dgb6LlilkWDTx1MeHVFBhx2g6+/WD6q67xPu9Iwp2NSyMAVkSqC2KmvM/3jNTkcCIGL9udb4R2jDh3V1t18Z1+1i4qqBTrVyOOz7vVxQ/FdyuufG4jxEklKklXGfmD7LKMY5P7GEaIYMABqMcjVctbCZSe55Q3v5wrEB/HMKpBVfo/SCcUP82TvhVGnpgINgPc7/yQI+am+SVYQ+rshkm3wRfDAU9L3AhHK7QGAhC8ydo+3g87fbpJxoKKUHcsGCyu0ty1RC6zuBgFnrSqEBu06h5o6ms54WpYDliyX5CT3IUNa7u6dy1HGe+N8otSqlQO/OcDmG05Q8I9c6HL19RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtvWKxPXSoRKsc9u8N8IanHHc6I2lHmFKfS7adl394g=;
 b=UU588JtDU03frnQkma0giq7piwSwvY7xAB//ZF1COLwivuLwj086gcXINxIPPALOpkTke6H93Iubh2aST/eY8hlAFpdyoKAdWFLt9EPMp5QxRKgjamq67yhOIpq7BdxFbpTQivxG07GR2IkxC2JaK30hCwbeqwbCva1MqAJGPFrkebD4rIoy13T80Ejx1uZYHUozehF95BvnbYFkJ+68xlHa3UW6EALBG4DtTmLl9GdlZ6+ehOGYlgDqSQTO23zWnxBxm/MMPyvNCBuMYByCRLr25Di50ubKiCGASCBqeJA/zyeL3DN3eJlQqFMDWRiwzWEYA0zn6ZUdWyRin+dHnw==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN2PR01MB4809.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 07:12:50 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7%5]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 07:12:50 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
CC:     Marcel Holtmann <marcel@holtmann.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Daniel Winkler <danielwinkler@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "sonnysasaka@chromium.org" <sonnysasaka@chromium.org>
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Thread-Topic: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Thread-Index: AQHX0vJ15A6zQVMGfEiNGmUN6kF0hKv3vuGAgA4gSACAAAxJAIAABrOAgAEuUwCAAEInAIAAIdSAgAAEmwCAADPsAIAAaCCAgAMCoICACSHJgIABwZoAgAQwAYA=
Date:   Mon, 29 Nov 2021 07:12:50 +0000
Message-ID: <E8DAD04A-3461-4B9D-94A8-9E3A57138CD7@live.com>
References: <20211001083412.3078-1-redecorating@protonmail.com>
 <YYePw07y2DzEPSBR@kroah.com>
 <70a875d0-7162-d149-dbc1-c2f5e1a8e701@leemhuis.info>
 <20211116090128.17546-1-redecorating@protonmail.com>
 <e75bf933-9b93-89d2-d73f-f85af65093c8@leemhuis.info>
 <3B8E16FA-97BF-40E5-9149-BBC3E2A245FE@live.com> <YZSuWHB6YCtGclLs@kroah.com>
 <52DEDC31-EEB2-4F39-905F-D5E3F2BBD6C0@live.com>
 <8919a36b-e485-500a-2722-529ffa0d2598@leemhuis.info>
 <20211117124717.12352-1-redecorating@protonmail.com>
 <F8D12EA8-4B37-4887-998E-DC0EBE60E730@holtmann.org>
 <40550C00-4EE5-480F-AFD4-A2ACA01F9DBB@live.com>
 <332a19f1-30f0-7058-ac18-c21cf78759bb@leemhuis.info>
 <D9375D91-1062-4265-9DE9-C7CF2B705F3F@live.com>
In-Reply-To: <D9375D91-1062-4265-9DE9-C7CF2B705F3F@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [ZhHTbLKXxQHMyy4hJBsxtvUFtJud9PpZ6aQewohxMk7+NIOgRegVhierITV5QPGP]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e29faa74-b069-4204-da12-08d9b307a752
x-ms-traffictypediagnostic: PN2PR01MB4809:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UgNLJI0MGYsnGmX9m15djkF8flU1s4SiYwkA5HRlq7uV5CMFdtmJ5d9sj/yA3RVN/Y5lpre1f/LA/ndtjSJi7zCXulg/eRMQdSwP1+KMpjBi3ZuYdyIP5YaezKut16QixnTTM+BiTyzt4PYB7L+EU0gxWdINOV1nU9/CuR+/+WkwdT1vqZm/gfyoR2E8wCJT1upv7ZEEVFklbz3XV4w9weyxtlAWJtpVlCzf0vGAVZLY5OAU01jga3L2/jN52uq3YqMbuiOuKux/Fhb3V61oCPYP91gEd3j984JK9Q99tRy/1XiU8ojsfYvcj36ag6PODAJ7Obl8llSJIrE2F9qnX0qlm9lN9Ln1ddVwWioVbFXLhg2UAyAIYwlnn8Ozt5amp/W+xx5XsbOYXFwWzgfRsqrtQp7h/uXRVb7u42ir1rUDkbZJUQZUA1CdyIdY5BSp27L5FTZwlJD3xqTRqUVOaJk1VoWEOppF/Qsaot9VJGcXs2hpdsExUpo6sRuH70qgSVQv19+7ARBr8XWQ3jYaYMe4FLRzW5ycMBjGzIp7qI7Zal6aV0782E3tOpkFSiLDq+a540486jNeOH97jXKe+8IIbExItD/ZOQ7tfpNW+IQEO4/O/h4IeWu6upiGfN2PdOs4VPFInCMlCCSoIM8J5qS9pZuOriuhUWpxR8+WvQ4=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: j1k1CD+51YOMdJgIFo8gcNztrmNAJxZBdZlQkB1JZbOw7Sw0j7SVWwWxlaOqBn7VdIgjhnSeBzmnQEdgyr2mwPy66Vicf8DxU+NVAL5iWCjVFqIyQFsO7DR7kXNldTzJXnGmM/zlYoYJXnmHb/bMOGdVepcAoxWcsXXPd44Op5vS/JC503LfEgSlPEdlBXohkwMwcNi6Zj9Zb39iVr197vgn6JUKxMAu17yCTYsgKrBVShoP/FSyBX9JONiLvF7R9e/lVOQ3gKkgD1U3xoYyx7ye3304njVUcCk4ZSKgQm7tL/jzmHIU+MeP/iEOXbBFdwCQAsbLpIKrqqHU+UwJ4By1LV4JtvKM7dSlFAJqIf4kkg6XcQ66m3TxG0LXt4As2R0eY4LnzFTuDTOEA4u3oceMWhhj7m+Ge2KjpxFVt/Qdi1epZaA5Bbz+/WENuU7gAaIMq0TM9/SL47fDU5LukJvtiP9g073v4mrJXXs+j7Xft4yIip7FPnPEnFRRGHUbFszVBHT8LTHA4N0pkqcArw6Vu5Spk9fSLLCAakoGQFhJGEXmGqci4R6IbliAiDVIM0rT6ZXDCmnI8WEzL7pbVvJ/U+sYG0Txq62yj+jc8gvKEF6p0Vgp05GjCB9BiiX8vTf6MwioWAb0+snCr9UX8Fhw3fhkvbO+qNRDgNAwEhQgPzogml6GhMoJPORBxyhlhBD/wgcFG+m69sN6gG2c4BuiTDph/XODmCWLXuX+sJCkWeLAeVuzswwBZZuV2uhT2CGdFw5YYQIInAJYSP9hGA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79A00CD017606E4E95C382EF214DF8BC@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e29faa74-b069-4204-da12-08d9b307a752
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 07:12:50.2366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4809
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I have finally managed to add quirks in btbcm on the basis on DMI data. =
This shall be advantageous in the situation when the user shall be using a =
USB adapter so that the quirk gets ineffective for the adapter.

> On 26-Nov-2021, at 8:45 PM, Aditya Garg <gargaditya08@live.com> wrote:
>=20
>=20
>=20
>> On 25-Nov-2021, at 5:56 PM, Thorsten Leemhuis <regressions@leemhuis.info=
> wrote:
>>=20
>> Hi, this is your Linux kernel regression tracker speaking again.
>>=20
>> On 19.11.21 17:59, Aditya Garg wrote:
>>>> On 18-Nov-2021, at 12:31 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
>>>>>> So if this just affects two macs, why can't the fix be realized as a
>>>>>> quirk that is only enabled on those two systems? Or are they impossi=
ble
>>>>>> to detect clearly via DMI data or something like that?
>>>>>=20
>>>>> I think we should be able to quirk based off the acpi _CID "apple-uar=
t-blth"
>>>>> or _HID "BCM2E7C". Marcel suggested quirking based of the acpi table =
here
>>>>> https://lore.kernel.org/linux-bluetooth/1D2217A9-EA73-4D93-8D0B-5BC27=
18D4788@holtmann.org/
>>>>>=20
>>>>> This would catch some unaffected Macs, but they don't support the LE =
Read
>>>>> Transmit Power command anyway (the affected macs were released after =
it
>>>>> was added to the Bluetooth spec, while the unaffected Macs were relea=
sed
>>>>> before it was added to the spec, and thus don't support it).
>>>>>=20
>>>>> I'm not sure how to go about applying a quirk based off this, there a=
re
>>>>> quirks in drivers/bluetooth/hci_bcm.c (no_early_set_baudrate and
>>>>> drive_rts_on_open), but they don't seem to be based off acpi ids.
>>>>>=20
>>>>> It might be simpler to make it ignore the Unknown Command error, like
>>>>> in this patch https://lore.kernel.org/linux-bluetooth/CABBYNZLjSfcG_K=
qTEbL6NOSvHhA5-b1t_S=3D3FQP4=3DGwW21kuzg@mail.gmail.com/
>>>>> however that only applies on bluetooth-next and needed the status it
>>>>> checks for to be -56, not 0x01.
>>>>=20
>>>> so we abstain from try-and-error sending of commands. The Bluetooth sp=
ec
>>>> has a list of supported commands that a host can query for a reason. T=
his
>>>> is really broken behavior of the controller and needs to be pointed ou=
t as
>>>> such.
>>> Well all I can do is provide you any logs or information I can. But we =
do really wish to get this regression fixed soon.
>>>>=20
>>>> The question is just how we quirk it.
>>=20
>> This thread once again looks stalled and smells a lot like "everyone
>> agrees that his should be fixed, but afaics nobody submitted a fix or
>> committed to work on one". Please speak up if my impression is wrong, as
>> this is a regression and thus needs to be fixed, ideally quickly. Part
>> of my job is to make that happen and thus remind developers and
>> maintainers about this until we have a fix.
> On the basis of DMI data, I have made this patch to disable read transmit=
 power on 16,1. I have tested this on my 16,1 successfully. Still consider =
this as a draft as more models have to be added. I am sending this to get t=
he approval of the maintainers whether this quirk is acceptable or not. If =
yes, I shall send the final patch.
>=20
> From 3dab2e1e9e0b266574f5f010efc6680417fb0c61 Mon Sep 17 00:00:00 2001
> From: Aditya Garg <gargaditya08@live.com>
> Date: Fri, 26 Nov 2021 18:28:46 +0530
> Subject: [PATCH] Add quirk to disable read transmit power on MacBook Pro =
16
> inch, 2019
>=20
> ---
> net/bluetooth/hci_core.c | 18 +++++++++++++++++-
> 1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8d33aa64846b1c..d11064cb3666ef 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -32,6 +32,7 @@
> #include <linux/property.h>
> #include <linux/suspend.h>
> #include <linux/wait.h>
> +#include <linux/dmi.h>
> #include <asm/unaligned.h>
>=20
> #include <net/bluetooth/bluetooth.h>
> @@ -461,9 +462,23 @@ static void hci_set_event_mask_page_2(struct hci_req=
uest *req)
> 			    sizeof(events), events);
> }
>=20
> +static const struct dmi_system_id fix_up_apple_bluetooth[] =3D {
> +	{
> +		/* Match for Apple MacBook Pro 16 inch, 2019 which needs
> +		 * read transmit power to be disabled
> +		 */
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,1"),
> +		},
> +	},
> +	{ }
> +};
> +
> static int hci_init3_req(struct hci_request *req, unsigned long opt)
> {
> 	struct hci_dev *hdev =3D req->hdev;
> +	const struct dmi_system_id *dmi_id;
> 	u8 p;
>=20
> 	hci_setup_event_mask(req);
> @@ -619,7 +634,8 @@ static int hci_init3_req(struct hci_request *req, uns=
igned long opt)
> 			hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
> 		}
>=20
> -		if (hdev->commands[38] & 0x80) {
> +		dmi_id =3D dmi_first_match(fix_up_apple_bluetooth);
> +		if (hdev->commands[38] & 0x80 && (!dmi_id)) {
> 			/* Read LE Min/Max Tx Power*/
> 			hci_req_add(req, HCI_OP_LE_READ_TRANSMIT_POWER,
> 				    0, NULL);
>>=20
>> Ciao, Thorsten
>>=20
>> #regzbot title bluetooth: "Query LE tx power on startup" broke Bluetooth
>> on MacBookPro16,1
>> #regzbot poke

