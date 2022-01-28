Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A584F49F3C2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346550AbiA1GiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:38:01 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:25489 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiA1GiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1643351880; x=1643956680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cGgcmR6o734dU8J2C3MPlL06MtOdDGu94FQQ3WkPFsM=;
  b=FnYds+qGuHOiz8L8WpxvMZ19TpDwVhoF51JHMSsfKL/A+GOsNu7/YUSw
   o7ERPSkHvL4t/4eQTxoYY7GVQKENXeW995CIAiWIb1Ub6FPZ3sPCw8ILZ
   CI7oXaZFwKEvsOppqYq63PfsWHatxs9BHGfWLJ3dkfbLsZsn87dza/c5g
   Q=;
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 06:37:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0I4YI5HCGStIyHvmdpiWBhFWQ9Mncv0i2ntDdVNzqoNA9vlFiQMRJYc5AfoW0dEk6d5bgLirbrQDMEBE/dFlw/34XwL+k9BsMbXuCTo4oND89HmT6PnqZn1ZXpCxl09MVwUN0ofe4jyiqhZeVFhOo70fePZpDLQouUrwC9NDQJPKakZ/cOOiGX8Hog2DtDTU75495J0hVzS32zUdVt32n1UscgSYuNU3SlgGfqeoI1O+DObzECuN6LPKfPS84ImFc2IP6hidvSdmBi1nKI10zsrqIn1HG326YY6xVnQGwG/zM01TBq13rhCCF7tWBQ7zEJ0ay0lJJoKKxLyOKbk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGgcmR6o734dU8J2C3MPlL06MtOdDGu94FQQ3WkPFsM=;
 b=V80Al9u3kJ2kS+SIiR8ZAK+Rv670wAnTpiJIaMkuHHgkU+xphwfGa3eu3kMLTVzoqDbK5zp8KSLcLNUghpwFgS7oZvIffEG5kr7X+MOGkiWhBSil5ge9+zk244wrUzcNnUkksRf6w5ipbD+SCuhs+nXU203XcL+0Uvl2O73GMybXLIG5VHCC4cVcK9ykCtixTgExSQXHzEDoQhBNPXAxSPmSau69tSOObV3V3lGoORTklaDV8GkXCXSeO77AgbLXqRwdh95nxcVg3S9uMd/MN2gAJNLKiMPuOebz/FeuBEWK43+vhYNusBIrLy20EPf8DAAGwrssg7tX/RqSvIjd6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by DM6PR02MB6795.namprd02.prod.outlook.com (2603:10b6:5:21b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 06:37:55 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%5]) with mapi id 15.20.4909.019; Fri, 28 Jan 2022
 06:37:54 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     Michael Walle <michael@walle.cc>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
CC:     "dianders@chromium.org" <dianders@chromium.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "vbadigan@codeaurora.org" <vbadigan@codeaurora.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "sartgarg@codeaurora.org" <sartgarg@codeaurora.org>
Subject: RE: [PATCH V4] mtd: spi-nor: winbond: Add support for winbond chip
Thread-Topic: [PATCH V4] mtd: spi-nor: winbond: Add support for winbond chip
Thread-Index: AQHYDePakDL0XfUSukOExyL3iAAZlaxrtgUAgAgw3CCAAASCgIAEG+HA
Date:   Fri, 28 Jan 2022 06:37:54 +0000
Message-ID: <SJ0PR02MB844910CF4F8034D2FD27E882CD229@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1642672491-30067-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <db1d17bbdcf7af2b8b58f6e7fa82062c@walle.cc>
 <SJ0PR02MB8449372A38A34EC5FAC16765CD5F9@SJ0PR02MB8449.namprd02.prod.outlook.com>
 <ce590c8dc41c64bc56d9c241f4c7dd9a@walle.cc>
In-Reply-To: <ce590c8dc41c64bc56d9c241f4c7dd9a@walle.cc>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de90d52d-44b2-45ec-a810-08d9e228b720
x-ms-traffictypediagnostic: DM6PR02MB6795:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB679517938EC7A376A87B6241B1229@DM6PR02MB6795.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DxbYcKfzGZkznYnIsPLH/4IecEmIFgVvW9AkHh9mnf9i6VaXLY9h7KwC9V8SWt+Uhqjk7AlFZEFNK/GvKiGVMylhHZdeG8FBVb60BVx5+z4pldyBOnkQnbRTLpk2BzWoGBrovNGj596kDqK3zQja8//FygK+udDr1Pu57nSdmIl9l9JF51sHS+VpOO0GOr15AyJsdlyPQppIngcMl4buraT0qNDLp65lq3JzbFModNYU87yCRceqThqfczU/pv09vNXzqlmoNWCimbuWv4sVFfMWZGCinv/WGx4xX4APmGqjsCDuFQV4X+gn50cHJEipCKTKkPZq0sN7JTgdtrKQO+lCdUwh47z9liei281O1msQoYLlm4gcXTHfPbOR2pqxdVjzoLOxrsWKjaggDZQAGqQhWxYrN6lQDEFaYSwC3XL96uA3qWh2kcro5xmW64f9RxVsb0RfF3gpOJ36XvqbaLR7hnNrvESFWrss/AUrcGYCHx+cPvRrHX8M5KHInYkqZyAOTZcxgtpj0unh3Jx5aQGj813tIT/0ez9Wz1q69sCekdbyUN4Lo6HBN972C0uC+e6YHbJW8lwDSh0kVzEbtENiZk+kJImCOr5C7bVXMgZpd31Xa9jYPuGYGc5vxTQmXAedr6U6giLTOgrpYU086xh+nP7ED4WerhR71HFIDrBcL3MN7tilkoCPy0e+RBwUwGqAQ5tpdJcVttk1QAYv45xm1ctO2cbGTLjDz9a3VAvZq3Doh9GXggQx1aMjgA+YhT9XWOzWTDEgGi8YYO9CMVzc/K8vqb+NX7cBHlTCKxs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(186003)(26005)(38070700005)(33656002)(55016003)(122000001)(7696005)(6506007)(2906002)(53546011)(71200400001)(66446008)(66476007)(316002)(64756008)(66946007)(4326008)(66556008)(52536014)(110136005)(508600001)(54906003)(8676002)(7416002)(966005)(76116006)(83380400001)(86362001)(5660300002)(9686003)(8936002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5UoMauyig934xQmiuEa5YqFz0I2Mfp5Cf/lTsLYAh6pj+H1+ABcvlLW2XrAK?=
 =?us-ascii?Q?adTB5+i5L/Cc0gz8G8EXp6h+qZMJQ7EDdOok70knxPM+nY33Hj0Z+ZU03zqc?=
 =?us-ascii?Q?NWXLewlOb8E0js2pXRffEn15O4dfyrKjN0G38FzmPDoH/L0Ou8QS383wKuqL?=
 =?us-ascii?Q?GlyNG6mVELh7NvwP7fs5XDkyMAsNI27XB1uueC8CIh3dIVWQqYPxm2pGeeVD?=
 =?us-ascii?Q?8KscohXKuQRJ+G9GpkxiccsB4CpqoxW72OS4DzbNR0MyOvhNEsCD68HpHMPE?=
 =?us-ascii?Q?71pePfjPF17eoVNYeqdJEKRFkIWWKxecgEJGW+fgMp1hYjmQkU8S9E0YK9uQ?=
 =?us-ascii?Q?6O3amzBf/DuGy+pMt41v7tS8b5rPB+FsZ/vj9RrWrpdrWmFVb9Cc7CRQ4S90?=
 =?us-ascii?Q?opoJ/cM/SifeED4pkzr7FmnR1NIxreJVJ/fskuEXmXC/oCrBHQJKT9vosz7g?=
 =?us-ascii?Q?n0HuLnqc9d+I5CM9akra/oWK2oKlndQoGYx/p/Ek5cgIdXQHRZnBLYcnH/77?=
 =?us-ascii?Q?947l/x1I4xLP2RL38kmBiAmMiJC1N4GySTP69bDEybRKFXxhIJcJ/afi6MhY?=
 =?us-ascii?Q?PjWTLf88zGVp/DJ3ymS5k7psti/jWGWQgAX5+T4xpwraykVKZCvU6joPrdom?=
 =?us-ascii?Q?w5JVgkzl20PmF3Znawm4jHkgFcddO8nHPhNUaVShW041ixyEl2n4tYcWBLXu?=
 =?us-ascii?Q?W7DSTeAFtrPKj0mJ1sRXXz/qbBs5bcuCulvifFx1cIkIeYkAv2S72Mx9MceV?=
 =?us-ascii?Q?ICqAQ/M0+iMWavXZtNg3UhyrYjjYNpKEIPkFP9M0PjKRN9fe5D7wCyGeFV7+?=
 =?us-ascii?Q?tDohs2MsRggLNOuLhkO6zMGFCAz5tYNpZX12wtRvTGwY7re8Wc+0CKMB0Xkt?=
 =?us-ascii?Q?GX6YM1pMKdz8wigWappL6NNvlz0JCFq6S4BH7O/901JNem5b7F6Tx23opamq?=
 =?us-ascii?Q?7Ff7phZkSZstR0F0DIm9D6P5E1Oi1/F4yX0DpEl8LnwhEYcmyiibfSG3kDvl?=
 =?us-ascii?Q?wkIYpSBYJbiXiEmKOn+2DnClM71Q82V+mIepWboHCuUTBvoOaN3xzWS6cTsX?=
 =?us-ascii?Q?UUmIuTlPLTeHNjbl7MccAfYJLqlR9NH7NTey+HkHQ4gZQf/7uoBfa+njIMbi?=
 =?us-ascii?Q?FZktu6F3DRrdQmhjnti3ZwLd7OSchlV68SGCrc+l+p1yR/ZkY0+kFbvL8ZN5?=
 =?us-ascii?Q?ny2nJL0IzOHv2z50davQKFUeKtKIKEkosqzdUwN+pAD9VuPKL/RhWa9upguf?=
 =?us-ascii?Q?RbbOE+v90btIpaMcm14mv3oM30Z/RPyL+zPPNBciQ3me8asK+lOCBnK+tNEo?=
 =?us-ascii?Q?UUdClPBeRtoVpZmNaZ+OwzAOmx2lwvD3Ojdf50buV1VMt5hG19XF+N+0nNh3?=
 =?us-ascii?Q?Ovd6e9FF+mP5NOgXw0vWeWCEYYGT4KeKOWlaMkr9L1qYEpFEHRYn8B/8+iGk?=
 =?us-ascii?Q?6v94JoWhk4wZwKm3PM5QBrwMCxtoHa6gnh4HRd0XqkU/0DTwtMccTDhvnXBc?=
 =?us-ascii?Q?UClXmXuv62P4XbMywakR8oQubxBpYbjpDSG25jMiCYRu+SrsNqK5F8XhGNIn?=
 =?us-ascii?Q?u86oUbFETuHB3HYNg0gnbfpbu/qgBgZZCwCMIslBMXJQr0KSexGaVFavA+HA?=
 =?us-ascii?Q?UUsJ/iiV5JAQLqcOAR3OPcZZuJFh1sNSz66RfsBVYpHUQLOxpKqgMVIQmhUw?=
 =?us-ascii?Q?9CUvwA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de90d52d-44b2-45ec-a810-08d9e228b720
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 06:37:54.7326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cp4npxPBAoZdoyrkUI9x0Ztp2/fnXRPzv15KMGzIEC0IugmPCGQtzg37r8+G/d2+UFotqUMiUOYbuazTuj+pEsMFF5GqJylUCrMDbAJfH9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6795
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

Sure thanks for the info .. will add the change and test it.

Thanks,
Sajida
-----Original Message-----
From: Michael Walle <michael@walle.cc>=20
Sent: Tuesday, January 25, 2022 9:23 PM
To: Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>
Cc: dianders@chromium.org; tudor.ambarus@microchip.com; p.yadav@ti.com; miq=
uel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com; linux-mtd@lists.in=
fradead.org; linux-kernel@vger.kernel.org; stummala@codeaurora.org; vbadiga=
n@codeaurora.org; Ram Prakash Gupta (QUIC) <quic_rampraka@quicinc.com>; Pra=
deep Pragallapati (QUIC) <quic_pragalla@quicinc.com>; sartgarg@codeaurora.o=
rg
Subject: Re: [PATCH V4] mtd: spi-nor: winbond: Add support for winbond chip

Hi,

Am 2022-01-25 16:36, schrieb Sajida Bhanu (Temp) (QUIC):
> Am 2022-01-20 10:54, schrieb Shaik Sajida Bhanu:
>> Add support for winbond W25Q512NW-IM chip.
>>=20
>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>> ---
>>=20
>> Changes since V1:
>> 	- Added space before name of the flash part as suggested by Doug.
>>=20
>> Changes since V2:
>> 	- Updated chip name as w25q512nwm as suggested by Doug.
>>=20
>> Changes since V3:
>> 	- Updated flash_info flags passing according to below patch
>=20
> Thanks!
>=20
> Please note, that you also have to supply a SFDP dump, see [1].
>=20
>> https://lore.kernel.org/all/20211207140254.87681-7-tudor.ambarus@microch=
ip.com/
>> 	 As suggested by Tudor Ambarus.
>> ---
>>  drivers/mtd/spi-nor/winbond.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>=20
>> diff --git a/drivers/mtd/spi-nor/winbond.c=20
>> b/drivers/mtd/spi-nor/winbond.c index 675f32c..c4be225 100644
>> --- a/drivers/mtd/spi-nor/winbond.c
>> +++ b/drivers/mtd/spi-nor/winbond.c
>> @@ -124,6 +124,10 @@ static const struct flash_info winbond_parts[] =3D=
=20
>> {
>>  	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024)
>>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ |
>>  			      SPI_NOR_DUAL_READ) },
>> +	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024)
>> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>> +			      SPI_NOR_QUAD_READ) },
>=20
> Could you try adding OTP_INFO(256, 3, 0x1000, 0x1000), this should=20
> enable OTP support. Could you please test this using the=20
> flash_otp_{dump,info,erase,write} tools and add that line?
>=20
> I've checked ID duplications, because there is the w25qNNjw series.
> There doesn't seem to exist a w25q512jw, so we are safe for now. There=20
> is only a w25q512jv and it has the id 0xef4020.
>=20
> fun fact.. the w25q512nwm describes the OTP lock bit for the first OTP=20
> region (the one which is not documented and I've found out that its=20
> used for storing the SFDP) as SFDP lock bit. See ch "7.1.1 Security=20
> Register Lock Bits (LB3, LB2, LB1, SFDP Lock bit)". So we finally have=20
> evidence :)
>=20
> -michael
>=20
> Hi,
>=20
> Thanks for the review..
>=20
> Can you please share the documentation about OTP_INFO=20
> settings(Advantages etc..) if any.

I would like to see support for OTP right from the start, and because you h=
ave that specific flash chip, you are in the position to test it :)

With this line (it should already be exact that line I provided, I checked =
the datasheet), you just enable access to a seperate OTP memory inside that=
 flash. The datasheet calls them Security Registers, you can have a look th=
ere.

> Can you please share more info on
> flash_otp_{dump,info,erase,write} tools.

What do you mean? You can find these tools in the mtd-utils package or at h=
ttp://www.linux-mtd.infradead.org/ (couldn't check, website seems to be dow=
n for me at least).

You should make sure to have the latest version, which has a bugfix for the=
 flash_otp_dump and only newer versions have the flash_otp_erase tool.

Examples:

# flash_otp_dump -u /dev/mtd0 0
OTP user data for /dev/mtd0
0x0000: 56 01 55 53 44 30 47 30 30 30 32 00 00 00 00 00
0x0010: 00 00 a0 a5 5c 6b 62 7b ff ff ff ff ff ff ff ff
0x0020: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff [..]

# flash_otp_info -u /dev/mtd0
Number of OTP user blocks on /dev/mtd0: 3 block  0:  offset =3D 0x0000  siz=
e =3D 256 bytes  [locked] block  1:  offset =3D 0x0100  size =3D 256 bytes =
 [unlocked] block  2:  offset =3D 0x0200  size =3D 256 bytes  [unlocked]

# echo -n hello world | flash_otp_write -u /dev/mtd0 0x100 Writing OTP user=
 data on /dev/mtd0 at offset 0x100 Wrote 11 bytes of OTP user data

# flash_otp_dump -u /dev/mtd0 0x100
OTP user data for /dev/mtd0
0x0100: 68 65 6c 6c 6f 20 77 6f 72 6c 64 ff ff ff ff ff
0x0110: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0120: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff [..]

# flash_otp_erase -u /dev/mtd0 0x100 0x200 # flash_otp_dump -u /dev/mtd0 0x=
100 OTP user data for /dev/mtd0
0x0100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0110: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0120: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff [..]

For completeness, there is also flash_otp_lock, but that is not reversible =
and you'd lock the OTP area forever.

HTH,
-michael
