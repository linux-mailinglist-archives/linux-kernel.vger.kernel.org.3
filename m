Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD3C47B212
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbhLTRZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:25:29 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:38156 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240187AbhLTRZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:25:27 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BKBpnDB004263;
        Mon, 20 Dec 2021 11:24:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 references : in-reply-to : subject : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=Ur4oCNLSBcusPp8m3eB1JJYW8fExWXXtlc0PG/qBVF4=;
 b=pP1udFz/oHxh0Z9iLKoRB3q/F5dN9MPb2scU6lqZ31jJabtEnQTTwVDeT/ehVTbGMKO5
 wTkB0T+lV40IULwY2w5YW/fyoSMelg+45qZ+euJhSB6FOs2PQsQY8mHz2csZKA4j/LYX
 a+bPtudedUHLAwwUzxW31GGpRPxwWf4P2Wtd1CsO9p6v1fiJISeUic7cDeL2obWwYC6l
 865TnZmTZ+Pw2bJ5DiUPTUBinMfSFAZnpTDTIWtjWgBZYPbNxlN7TcbBAwsG1hClhUMF
 GG40YUeiHyKXQjyrx7/deE8mUwRySINOTCRpUGTP7iXpxvaDsW4HzoWOrchVtVjCLy5Q tg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3d2kt8grtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Dec 2021 11:24:32 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 20 Dec
 2021 17:24:31 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 20 Dec 2021 17:24:31 +0000
Received: from LONN2DGDQ73 (unknown [198.90.238.81])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3FD2C2A9;
        Mon, 20 Dec 2021 17:24:30 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     'Hans de Goede' <hdegoede@redhat.com>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Lucas Tanure' <tanureal@opensource.cirrus.com>
CC:     'Len Brown' <lenb@kernel.org>, 'Mark Gross' <markgross@kernel.org>,
        'Liam Girdwood' <lgirdwood@gmail.com>,
        'Jaroslav Kysela' <perex@perex.cz>,
        'Mark Brown' <broonie@kernel.org>,
        'Takashi Iwai' <tiwai@suse.com>,
        "'moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...'" 
        <alsa-devel@alsa-project.org>,
        'ACPI Devel Maling List' <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        'Platform Driver' <platform-driver-x86@vger.kernel.org>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
References: <20211217115708.882525-1-tanureal@opensource.cirrus.com> <20211217115708.882525-9-tanureal@opensource.cirrus.com> <CAJZ5v0jTELqFeO6q6w_mYNo_yf1R9SX66RrEz0ZSe27w7E6kog@mail.gmail.com> <4b5506b1-20c6-3983-d541-86dc2388b2a7@redhat.com>
In-Reply-To: <4b5506b1-20c6-3983-d541-86dc2388b2a7@redhat.com>
Subject: RE: [PATCH v6 08/10] ACPI / scan: Create platform device for CLSA0100 and CSC3551 ACPI nodes
Date:   Mon, 20 Dec 2021 17:24:30 +0000
Message-ID: <004001d7f5c6$7329d4d0$597d7e70$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQFonMI0WTNmVk9vhQUnEV0YSPsGcgGkMuwYAgUuTOECRVQNZKzq2vIA
X-Proofpoint-ORIG-GUID: tUzAAlnJajlhkW3wcG-HzLZr4h-wzfPI
X-Proofpoint-GUID: tUzAAlnJajlhkW3wcG-HzLZr4h-wzfPI
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: 17 December 2021 18:27
> To: Rafael J. Wysocki <rafael@kernel.org>; Lucas Tanure
> <tanureal@opensource.cirrus.com>; Stefan Binding
> <sbinding@opensource.cirrus.com>
> Cc: Len Brown <lenb@kernel.org>; Mark Gross <markgross@kernel.org>;
> Liam Girdwood <lgirdwood@gmail.com>; Jaroslav Kysela <perex@perex.cz>;
> Mark Brown <broonie@kernel.org>; Takashi Iwai <tiwai@suse.com>;
> moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...
> <alsa-devel@alsa-project.org>; ACPI Devel Maling List <linux-
> acpi@vger.kernel.org>; patches@opensource.cirrus.com; Platform Driver
> <platform-driver-x86@vger.kernel.org>; Linux Kernel Mailing List =
<linux-
> kernel@vger.kernel.org>
> Subject: Re: [PATCH v6 08/10] ACPI / scan: Create platform device for
> CLSA0100 and CSC3551 ACPI nodes
>=20
> Hi,
>=20
> On 12/17/21 18:19, Rafael J. Wysocki wrote:
> > On Fri, Dec 17, 2021 at 12:57 PM Lucas Tanure
> > <tanureal@opensource.cirrus.com> wrote:
> >>
> >> The ACPI device with CLSA0100 or CSC3551 is a sound card
> >> with multiple instances of CS35L41 connectec by I2C to
> >
> > "connected" I suppose?
> >
> >> the main CPU.
> >>
> >> We add an ID to the i2c_multi_instantiate_ids list to enumerate
> >> all I2C slaves correctly.
> >>
> >> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> >
> > This requires an ACK from Hans.
> >
> > If you receive one, please feel free to add my ACK to it too.
>=20
> One problem which I see here is that this change conflicts with
> this series:
>=20
> https://lore.kernel.org/all/20211210154050.3713-1-
> sbinding@opensource.cirrus.com/
>=20
> I have reviewing that series on my todo list.
>=20
> One interesting question for you (Rafael) about that series is
> that i2c-multi-instantiate.c, which after the series also handles
> spi devices,is being moved to drivers/acpi .
>=20
> This is fine with me, but I wonder if it would not be better
> to keep it under drivers/platform/x86 ? Since the new SPI
> use-cases are also all on x86 laptops AFAICT.
>=20
> But back to this series, as said the 2 series conflict, since
> both are being submitted by @opensource.cirrus.com people,
> it would be good if the Cirrus folks can decide in which
> order these series should be merged.
>=20
> It might be best to just move this one patch to the other series?
> Thus removing the conflict between the 2 series.
>=20
> Regards,
>=20
> Hans
>=20

We don=E2=80=99t really have a preference which order these two chains=20
should be merged in. We would rebase the other chain if one
got merged first.
If pushed for an answer, maybe:
https://lore.kernel.org/all/20211210154050.3713-1-sbinding@opensource.cir=
rus.com/
should be merged first?

Thanks,
Stefan

>=20
>=20
> >> ---
> >>  drivers/acpi/scan.c                          |  3 +++
> >>  drivers/platform/x86/i2c-multi-instantiate.c | 11 +++++++++++
> >>  2 files changed, 14 insertions(+)
> >>
> >> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> >> index b7a6b982226e..8740cfa11f59 100644
> >> --- a/drivers/acpi/scan.c
> >> +++ b/drivers/acpi/scan.c
> >> @@ -1712,8 +1712,11 @@ static bool
> acpi_device_enumeration_by_parent(struct acpi_device *device)
> >>         static const struct acpi_device_id =
i2c_multi_instantiate_ids[] =3D {
> >>                 {"BSG1160", },
> >>                 {"BSG2150", },
> >> +               {"CSC3551", },
> >>                 {"INT33FE", },
> >>                 {"INT3515", },
> >> +               /* Non-conforming _HID for Cirrus Logic already =
released */
> >> +               {"CLSA0100", },
> >>                 {}
> >>         };
> >>
> >> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c
> b/drivers/platform/x86/i2c-multi-instantiate.c
> >> index 4956a1df5b90..a889789b966c 100644
> >> --- a/drivers/platform/x86/i2c-multi-instantiate.c
> >> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
> >> @@ -147,6 +147,14 @@ static const struct i2c_inst_data =
int3515_data[]  =3D
> {
> >>         {}
> >>  };
> >>
> >> +static const struct i2c_inst_data cs35l41_hda[] =3D {
> >> +       { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> >> +       { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> >> +       { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> >> +       { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> >> +       {}
> >> +};
> >> +
> >>  /*
> >>   * Note new device-ids must also be added to =
i2c_multi_instantiate_ids in
> >>   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> >> @@ -154,7 +162,10 @@ static const struct i2c_inst_data =
int3515_data[]  =3D
> {
> >>  static const struct acpi_device_id i2c_multi_inst_acpi_ids[] =3D {
> >>         { "BSG1160", (unsigned long)bsg1160_data },
> >>         { "BSG2150", (unsigned long)bsg2150_data },
> >> +       { "CSC3551", (unsigned long)cs35l41_hda },
> >>         { "INT3515", (unsigned long)int3515_data },
> >> +       /* Non-conforming _HID for Cirrus Logic already released */
> >> +       { "CLSA0100", (unsigned long)cs35l41_hda },
> >>         { }
> >>  };
> >>  MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
> >> --
> >> 2.34.1
> >>
> >


