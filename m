Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8839049B7CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378322AbiAYPjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:39:37 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:57746 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384326AbiAYPgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1643125005; x=1643729805;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+GFn/jYtnUhh4v4MPFZNBlm1r6CkCkiSEL4SYUMk2b4=;
  b=geefpg62doARpaF33tXyy6G1rTZV7pwfP483nThSPowX6kXSjPTnP9GG
   RQuretTeRzfpLlqKOxM23yrnm4JaLwt8lt0c1aav3EeiOV4wCO9mVOVxM
   gWgqbFPEccnPX3CmGhv72mfC0cbcEcjNwuCuols/0zeQZHoQSh/T9PMrp
   s=;
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 15:36:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lckWwSFt4cO01G5iEV7ShUh99TKc5vGeTv2zOsmxb7FHwzzcxqyiUmT7k96Ew/d6ucLJwzwBLEgJTrG5SK9PhVyWQEfILM2KA337XU0oQkuBlG0KQrkUKJgMDs8+60Nuv/sOY3LAxCdifOO+GWrZW2oHwdWDYkU5b3gj5Bwc6ma9NguVt6vgZ8fwSGy3Syv/i/j8k3PwNxDaniDwtH5MRxS1hwmqQF9R15Dwa3QK4FBPJqI9RHW0KBiBic14yrzDBIENEaoC4r2wUDgxSsGS5RdWcJdKuR3SBcm5v6wiSKduIkF1zrO0CnzCZeTECry24b6SbpgDsp0VeNqanvZycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GFn/jYtnUhh4v4MPFZNBlm1r6CkCkiSEL4SYUMk2b4=;
 b=YJV34CuYjBTFtAl1ge/LE0qnbVAGaM1ZtVwi8PCR8i36MTs/Ypn0P1es56EFQyorLN3XMy4kdeZS00zqNSpA2PKSm9I30CDbCIzoBICQ0hw5lGh5KXwSs5GtmvJMfCC1n4sr/Whkpbt6N3UJpJaLizD9Usx4NiAl3o9z95EsotEZF2Ptp+0BnZ6pSBMK63TsBz0Kj3blalIWr8gyMkPwPKIWa436fK0lIFyg83mazLgKZMf+FZcgUwA+n6cqAVCgUwcpzLtxmexd1nAice/n994j+nE4jEaLY/Nf9SRouT8gVvwaWGh5ajQdJbbqBIWQI+Hkc7wpWjIyzy6eYU3dqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by DM5PR02MB2603.namprd02.prod.outlook.com (2603:10b6:3:45::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Tue, 25 Jan
 2022 15:36:39 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%5]) with mapi id 15.20.4909.010; Tue, 25 Jan 2022
 15:36:39 +0000
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
Thread-Index: AQHYDePakDL0XfUSukOExyL3iAAZlaxrtgUAgAgw3CA=
Date:   Tue, 25 Jan 2022 15:36:39 +0000
Message-ID: <SJ0PR02MB8449372A38A34EC5FAC16765CD5F9@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1642672491-30067-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <db1d17bbdcf7af2b8b58f6e7fa82062c@walle.cc>
In-Reply-To: <db1d17bbdcf7af2b8b58f6e7fa82062c@walle.cc>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94ad719e-36d9-4ea4-44f5-08d9e0187adc
x-ms-traffictypediagnostic: DM5PR02MB2603:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR02MB26030CFA3F2A3CA27263BF00B15F9@DM5PR02MB2603.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gjkfuiscn0Ro0tqZV6h7ecgsJtfd83CzdJKLqgPQWZkZrWWvlr+ZDET/OF7rErKJwFVK7wbInw2owzWJkfHtdnk4YdDAkI60GTR7fkw/as+DrqVd81g9lbF4yLxMgA6ZCp+W4H8hClteePRCxyufrgftYN2FYypnPNnvfEnzAbUKVWoL1zmUccSrb3tLqgC0zytui16JcsxYmpnkrAhpp0y+NPIsGAMPY8G7AzuSctK9GzFzPqVMsEM4GMarAQdL1S2FguVSyyCBJEOF7JtOLe7TxEI1HbedDmgRkaJ5Qh7c93AlSlYsu8Wo5RWv8UG9R5I0rFisYgxVb19IjIGYGuvHUdW79vg15iHc6lkpzEHwYkTnDIVjPWFGfxWAZjVMeFH9k3RzM+MTTt2WgJyCISs8idI0yAnhd6FjWVVT4SuUuAdMhDnw07p6WMaSNW6WUws4phEjy8o+1CLmrF30gCFITNmAds4baD4p85ZpDOsqEIYANQFnvSW1Ph9nBiTkPCL2LRO20vwoNguxXsc1jOhdXoOogsHme9qInLXv3sn8k5kqY4V+g5ZwYrHjuaSJ+2f4FYcXFaDs0SV77ucCv1X75lF2b8pOSmIbdrp0kVv7LiKoWa90wyQDO0DPinBul2mX/ERhyZlVg1jXGxQeqD3J5n5HCKRZ0DIYdDrwifs2CFdx/21DB1Hj1WlEGq7GLfa9yNne9ggsDrfEGb1OHsQHwVDiJ/VVp0sSIEi444QETZFh3G08luSoAy+ECEWhdprEdIsRlaxdkZ90oKS4r5TMh68omt8iFDXeV72vNfmojCXhEN3Wm1slhkU44Ky7IsAA8/ZJ/WtiI8rLyphTcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(53546011)(66556008)(38100700002)(122000001)(7416002)(4326008)(83380400001)(6506007)(26005)(186003)(52536014)(86362001)(110136005)(55016003)(33656002)(8936002)(7696005)(2906002)(66946007)(54906003)(8676002)(316002)(9686003)(66446008)(64756008)(71200400001)(966005)(38070700005)(5660300002)(508600001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vv54ysYbJS02ScrAS0Z98EP/nGX1NBf44mJLuzc60wyo8MCX0nNU12XViydL?=
 =?us-ascii?Q?bHs//Vnj5lMdx3RXC+UvlWv2jWsrk8mPh+LRZmK8zmGlJeEPhrg58lpM+x2l?=
 =?us-ascii?Q?p+/wEr77qtMnDRajmLTZh56xqLr2nFq3fvEOl1tasCf3tBanq7gIFP+MVTiT?=
 =?us-ascii?Q?197Ydv4smUhprtaiZsUi65YHd7JYBGKKJczBCN4lGmmOsEAwW3Hem/mYoThz?=
 =?us-ascii?Q?6lHpzHZ9wzmGQZz3sngvO3KeN8l+HCocTqg2/59VsSIEmTUoh0NK+1/keH0D?=
 =?us-ascii?Q?y3PBDfloKdkqrEj2SUXspq7RZfDxQcqFtVBE6ymvYl5nZWSb3AtUt0FMbFp4?=
 =?us-ascii?Q?bAejZz+sePPiYSJIJj/7YffO3YNysZGSYZlh9tRb5AaQwp6t6aQN69h1Twak?=
 =?us-ascii?Q?QzZO12usAabXeNqD6NC7g1jwu2RJbHCIG33GN5HimvUHXPKyLqHpX27dMeDI?=
 =?us-ascii?Q?NeZ6GFlDgSJ6k2gFP5HO1DmZtnWXURnP+/jGrglHstDYhnKgzoT++VWg8dLQ?=
 =?us-ascii?Q?/imrbFcZwRhf2byF3i/t4D6OEKXzs3fUO9FRXoaQyohEa0vRR27hvkEpcWnw?=
 =?us-ascii?Q?4HYJqWfg48WWVFyBUlEgT08EK56wSrH06qdHzO50y9dZfw4UUYzWtYYKjt43?=
 =?us-ascii?Q?/Q1z0S28ZQCwUiZ7T+257AKdYaFDV251MAGxt8xTdLFPwyUO9Zgd/C3g29id?=
 =?us-ascii?Q?NW21eiqSQ2wY2DS1qviGoOZS1L+sQJH+Nmj9Sz9n4tcoL61WEpSkI8DFeKiW?=
 =?us-ascii?Q?qfMQGwLoAVDG0esrQzW9AynACvlAxr+2LWOqgrShXEGCW2H7V6Fc4fWpBlgF?=
 =?us-ascii?Q?dG+JOChLozdCHJ4vWMBALXr4TOyZ78y4ilFJ5g2OSyZaAjqM8JPZHcsT1Dc9?=
 =?us-ascii?Q?kfpgALm9IJgD63XFaZEwOgzrZc1n5O6DSysRsf7YCGmhoq+3PAvRlo8Ht21H?=
 =?us-ascii?Q?kvNKAF04zzWepC0Fy8ZXY7+gpgrTp8xdC6OcZuDeEsezm3kGJ0b9/owQ7opD?=
 =?us-ascii?Q?fbrvsG1RpK4sontUcJm3B3/6d644NcpDJpSE1qAwRDUR1V8Chs8r1qfBKZUy?=
 =?us-ascii?Q?vFOI3H5z1GRsMFf+8+IH9TKuGTcLX/KgMvy098vcGLU3yjCd8SSRZCklSmB3?=
 =?us-ascii?Q?EvwQ222/NyyP0RgBlJktwLbUR3V7tPGSBFNi1Bud9pdl9rvst6khGHy+SjLO?=
 =?us-ascii?Q?GnKtRlPP/QspcQo7edKyFYVUODUnMX4Xfn8KD8WOmbMLuZmQuFDNiGXkpYIM?=
 =?us-ascii?Q?txRoJqrOSiBHW259q62MkFWUJlTJSbZ0s2Q4eJzW9RBPlqDCu6IBAVFwfr62?=
 =?us-ascii?Q?ko5hxNlYUL1q8Yb7hqjTlt+Fjq+WSKy3Hnc4DtNDQ508cC4CB6+zLXk2qEmr?=
 =?us-ascii?Q?cuCoCzTc3pSYoeRocEYbzYUjp7Qw075jJLJCOr3QYwp0YeyCuJEwwhJ+yP+e?=
 =?us-ascii?Q?qI/Vze2YKy/snlxrAUGi92l8u0s5toEPKp+GdcXYTdKS4ainQgKPI361e2tB?=
 =?us-ascii?Q?MfbnLNwmU5I5oQpAV6FNqvTmbC6v845dRIkkqYX11fhnSmYTefDNm+3LEpK0?=
 =?us-ascii?Q?DNUk8kibmzN6R0qW/CXo4eWIa1sWIGdC02Sd/TsDwMTwmo4VIhgqkILVdK5I?=
 =?us-ascii?Q?zBTVrB4dxqcsCNbbvemXdmMOM0ENdPIjG8A4SXBYG4uUGT4rp/7ivFgpMwfE?=
 =?us-ascii?Q?cC8TiQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ad719e-36d9-4ea4-44f5-08d9e0187adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 15:36:39.2854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5Q+dWZTkMpBER/XGxOSAVZl/PvkkyeUiO89Q7pVqC/92JQIgn6krEXok+m/4RHMSusXvkx4eeAPGQxQAgR37cFkatLyqPfnL/YA8qHtcps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2603
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Michael Walle <michael@walle.cc>=20
Sent: Thursday, January 20, 2022 4:02 PM
To: Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>
Cc: dianders@chromium.org; tudor.ambarus@microchip.com; p.yadav@ti.com; miq=
uel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com; linux-mtd@lists.in=
fradead.org; linux-kernel@vger.kernel.org; stummala@codeaurora.org; vbadiga=
n@codeaurora.org; Ram Prakash Gupta (QUIC) <quic_rampraka@quicinc.com>; Pra=
deep Pragallapati (QUIC) <quic_pragalla@quicinc.com>; sartgarg@codeaurora.o=
rg
Subject: Re: [PATCH V4] mtd: spi-nor: winbond: Add support for winbond chip

Hi,

Am 2022-01-20 10:54, schrieb Shaik Sajida Bhanu:
> Add support for winbond W25Q512NW-IM chip.
>=20
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> ---
>=20
> Changes since V1:
> 	- Added space before name of the flash part as suggested by Doug.
>=20
> Changes since V2:
> 	- Updated chip name as w25q512nwm as suggested by Doug.
>=20
> Changes since V3:
> 	- Updated flash_info flags passing according to below patch

Thanks!

Please note, that you also have to supply a SFDP dump, see [1].

> https://lore.kernel.org/all/20211207140254.87681-7-tudor.ambarus@microchi=
p.com/
> 	 As suggested by Tudor Ambarus.
> ---
>  drivers/mtd/spi-nor/winbond.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/mtd/spi-nor/winbond.c=20
> b/drivers/mtd/spi-nor/winbond.c index 675f32c..c4be225 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -124,6 +124,10 @@ static const struct flash_info winbond_parts[] =3D {
>  	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ |
>  			      SPI_NOR_DUAL_READ) },
> +	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024)
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ) },

Could you try adding OTP_INFO(256, 3, 0x1000, 0x1000), this should enable O=
TP support. Could you please test this using the flash_otp_{dump,info,erase=
,write} tools and add that line?

I've checked ID duplications, because there is the w25qNNjw series. There d=
oesn't seem to exist a w25q512jw, so we are safe for now. There is only a w=
25q512jv and it has the id 0xef4020.

fun fact.. the w25q512nwm describes the OTP lock bit for the first OTP regi=
on (the one which is not documented and I've found out that its used for st=
oring the SFDP) as SFDP lock bit. See ch "7.1.1 Security Register Lock Bits=
 (LB3, LB2, LB1, SFDP Lock bit)". So we finally have evidence :)

-michael

Hi,

Thanks for the review..=20

Can you please share the documentation about OTP_INFO settings(Advantages e=
tc..) if any.

Can you please share more info on  flash_otp_{dump,info,erase,write} tools.

Thanks,
Sajida

[1]
https://lore.kernel.org/linux-mtd/4304e19f3399a0a6e856119d01ccabe0@walle.cc=
/
