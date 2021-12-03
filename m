Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7B9467C9E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382326AbhLCRhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:37:39 -0500
Received: from mail-eus2azlp17011013.outbound.protection.outlook.com ([40.93.12.13]:10773
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343672AbhLCRhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:37:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MT8mQlC6TpoEaWX2//r+GEzoR6rdZ+XL/4HA4Qf4H/36Va/JXx7HNWXIiRd3I2i1Z22IHac0TGtD+0YTSoaG4zZzdCzSw0h4uv3RJgj11ADt4GQLfkvtKXQ/mwQY5r6k7USDKDUHnDZT7bcKCOQdX122baA5thU5M0PGiXSaVoWhbUdXKF4UirZhXpdt92idkepHT0c5rKk6ZVswovQQsmMfAXv4yO5QbL4mnHEI3QhHNdLQCDZUw8bMRkjkg3CFPr7uwfDeLElEndnALWp22sZNNFLxKlOd2sJXZztXAlbmfNPMWgfdoKEEEOCXiTQb8ApPRiU3rEUN1nMkQ/5eHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFomgNCTVpc24kYvom+3t2OSOLXqbeuaEyWdswtDQjk=;
 b=MIB7sQNdyrDrjWajmUjp8CuzFX/z2IMxHHbJbveBvrAIF7iDz8A81tA8bCuMO3VFzWvjMiMkPedj3CLrRc2bMa/w9uQofU/MSz80+YwOygfpGhvFfpGAJ1S9VLrgY0Tqd/C+5kytubhxVDdgIj2l1yhMyksrzgzGAavtc2EaaVwaBqV5nrRarH7oscIwbgwagxCyrwqzH6fj+HwS0SHQS4jHqEvBLhgI4LRc+OKeni65CIaFTIetttTFhd9LYX5zWmeUJBJ4uLpxYa4Ts1cvvifBQHPrfCMHLL9vBScA0A5eylJIUM8D2v+nB8V+BVuoEijzVHhUrZCQw00zkv93Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFomgNCTVpc24kYvom+3t2OSOLXqbeuaEyWdswtDQjk=;
 b=SJ+TKmntDJADchD742r+Sn6yjI07XfLXATePvhqidHS+vy5edwT+uqx4hqWJxMLmR3mRq2WhHaGPgIF8ncNdgnykgtWDF5vYIRgcFj49mFN0EZfWdT3+lRoxe7pTkLKptf0cMOqEmfwks5GykV7mC8stE9fuSu1YX0XRvtTtntU=
Received: from BL0PR2101MB1316.namprd21.prod.outlook.com
 (2603:10b6:208:92::10) by BL0PR2101MB1058.namprd21.prod.outlook.com
 (2603:10b6:207:37::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.8; Fri, 3 Dec
 2021 17:34:11 +0000
Received: from BL0PR2101MB1316.namprd21.prod.outlook.com
 ([fe80::6116:3d9f:ef5:2c45]) by BL0PR2101MB1316.namprd21.prod.outlook.com
 ([fe80::6116:3d9f:ef5:2c45%8]) with mapi id 15.20.4690.000; Fri, 3 Dec 2021
 17:34:11 +0000
From:   Jarrett Schultz <jaschultz@microsoft.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jarrett Schultz <jaschultzms@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
CC:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH 2/5] platform: surface: Propagate ACPI
 Dependency
Thread-Topic: [EXTERNAL] Re: [PATCH 2/5] platform: surface: Propagate ACPI
 Dependency
Thread-Index: AQHX6CxyCPVI/q/kxkKAjnW/mFJf/qwhBu5Q
Date:   Fri, 3 Dec 2021 17:34:10 +0000
Message-ID: <BL0PR2101MB1316DFA13C3AB1A6620A6CA3A56A9@BL0PR2101MB1316.namprd21.prod.outlook.com>
References: <20211202191630.12450-1-jaschultz@microsoft.com>
 <20211202191630.12450-3-jaschultz@microsoft.com>
 <639583df-a54a-eb9b-91ad-a60612a930b0@redhat.com>
In-Reply-To: <639583df-a54a-eb9b-91ad-a60612a930b0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=20746931-6de9-45ee-986a-6400c34298fa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-03T17:31:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 952b086e-9ee5-4df9-8ede-08d9b6831e15
x-ms-traffictypediagnostic: BL0PR2101MB1058:EE_
x-microsoft-antispam-prvs: <BL0PR2101MB10584F4A1BEB2D0A289BC225A56A9@BL0PR2101MB1058.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ygz4hemT1ZhkHRenbUQVOKry42ieFG8BCbwPAh510o/xXqUv3g0x0M7j0+MUqRDxdGPrLdC1f4OfBDOKy7LPUmmug+cSqf8nuZbF/GWIYpOh4mLq6hgrLVwj2+N2KWNL3Dzz+tpu3qFUhVpe1KQU6TjmMFiKkXpj0M8AzmDZLwBrAfCMfreO7ldkaVd3+sp4tkDe+vpAyu9zZ6JSBJsA/vTlz6iPLfCwBy78WmFs+XKfMOCdJ4+fVBwksK8sGcU0DMD3EhXD5kLZzl6uWXHjybJfk0lWutYXys1k+cdfjuH+KYwk7jqCG8BvBheWgifKn16ldYBhsJuo9hvBdTZvNhZgsd9EVQh/3dOGPSOkezGE5HD5CSZVvMX//laZavHiQkSlxSTO+ejGcqdvPwjoBCW1hKMkDrajl5oUhs70lCd7SGo4V4v26q+cnI98/hdepIUZGyxY3fSKCIgyzrcPiscWzCfu7Xy7KNdaNOSm8F8Q9or+2jznOEzc46JsMx4+zX+x/O0s1zwjm4w5Gcxi4XJ6gJWsz5bc8M5Vtnr75MTbhuBiBpUVypH39cEksujM+NRdv2lvhxWmdGQH23JpQO/ZE41+mIbGmmgK1AIi73AvkAFseItx48/KpFx5/MfoVnN6/wJP0py9E0+vCShNdIKKaFSITr+s719biZQy7yhvAjnF+enr7YTW+dQT1haN5ZQtS4eLCB7eKl1lU0a5eM5rFKsjomTyZXxHAPM1FJoFGk1YUwrDS6xK/AL/ImuH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1316.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(8990500004)(7416002)(2906002)(55016003)(8676002)(82950400001)(83380400001)(7696005)(86362001)(82960400001)(10290500003)(186003)(5660300002)(38100700002)(316002)(76116006)(71200400001)(66476007)(52536014)(9686003)(66946007)(122000001)(38070700005)(966005)(54906003)(110136005)(6506007)(508600001)(66556008)(4326008)(53546011)(8936002)(66446008)(64756008)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X4HsOH1KQ/2rXsotste6CbcvGaB56/Fxa1MTnPSX1HtyW5A1MFK/GLipiw2i?=
 =?us-ascii?Q?l4K4ym1mKW5+m6gHIOz+yF5cdUksMRkWbZKZMV5cVubRcHDulYZQpjRKBnKQ?=
 =?us-ascii?Q?Q5aLJXKCwe6OtnONj7QOP5jn4K2A32GOh0R8Y+PwTvvXfGBb8ne2RGhmHO1M?=
 =?us-ascii?Q?40/1pM9Qfmz93iIe2gu+qiAOk7vHSMtJq/fg2iCOR2b8yIBPsbGNiQuvfGvu?=
 =?us-ascii?Q?eP+N2dkIC56DlIwzKzhH1h/atPXEbHcWoi1QGFbbMr80N4at0otZJy3KEivW?=
 =?us-ascii?Q?ACWllNhxSfnLwOwvGgKmhXvZ692511YJz3+0lLtD2vUUiVbcwmZisXLitMlM?=
 =?us-ascii?Q?NgsCeoLuX/EsU58N2U7YniZWlG4fSk4CFhy9Vd4cgfDthulDK1kk9/QmotbB?=
 =?us-ascii?Q?ZfkSA5Gg9EIv/jxb0FOM/pd/05jTZ4pBTocfLqEXoK9hzVR6tIKzfLAAeODS?=
 =?us-ascii?Q?+w4dIYArbGGLNXK5MLng/Z2ZmOZ8iK4AUuSv6kz5L0Npg2SUFl30J1//KsTL?=
 =?us-ascii?Q?G8a465bSXPOk4nvk0TPvpWfE5TPGIZl2MebEkyfqd1gYA6HfTEvJ6P1CvdlC?=
 =?us-ascii?Q?krJLeE9914DNsSbn7HTwIyedhgLSQkXvm6bfK3v8+I2fqJXGyZvSfpNGpqBT?=
 =?us-ascii?Q?rhhDY9xkU5lcIV5qDKdXXgwoxk8TU+A93ci1whaQtnW+CIEOn4rggCZ1v2n0?=
 =?us-ascii?Q?zYCJkrctXX99gWuPP/ldxVqwtsUv1YGRghjCzpxAJUUGlMkM4avdFxraHvHe?=
 =?us-ascii?Q?1f5hy0VhkVvu+XULSxe7yuNIC6T0X/SZfp5uroq8nxYhjqCvOb8plWZHlITo?=
 =?us-ascii?Q?QftRlCQ7bcEcaiCra5zgFdxvOJ8yc51deBF2asE0UrngdfQ3CoSXy6/yUpJh?=
 =?us-ascii?Q?kItLw4ERMSw7pTQVWuXr9aBp9XY97gEF49tdXIGpOu1i/cwkiUkpOafelQl7?=
 =?us-ascii?Q?2ooq9S6zUJKw0pBCd+pIa1YCd0F5dB3BmsMWHMOcuOQrF462WZLmyT5FAt59?=
 =?us-ascii?Q?lOsJuHC9FhhT5M0OWc99WOJ4ZIhe+G6h72kymz/rmiwYWM94wN3VDA3Zd1BK?=
 =?us-ascii?Q?AJf5IyTMKL6lKZGOFdk4PSH/SPzT/BREPgoonMMDv0cIvC07q4t0MpGrfDFh?=
 =?us-ascii?Q?SOOA6/t23xixcDUYY5YTpaAx3YO6lC9dTVlDzsd1CZVuEKhwAx5D/Y5wXYAK?=
 =?us-ascii?Q?JZNFaJTq0bDcixb3dwlml/tJgg2y50Sq8uA3hpsa6wLJBSz3FCqsR164auZI?=
 =?us-ascii?Q?m3rO/rh/c0ifqN5tvoCTPHI1TJDRh2mXHGB8oK6NjsdkcQKDy3BEKnKPnAB6?=
 =?us-ascii?Q?kgWel1NcssMpXxnWUfTba3Tz/vWleRnV6aqiB3zX1Wk4ZOQKmtk2qCVrYMQB?=
 =?us-ascii?Q?1QedrrND+JFMvgOAjh4S+HeY48Xnb2y1NkjaMwyVrVA3v6io/JQ0V/PWiuu0?=
 =?us-ascii?Q?E6rUl3I+2VF4niV0e1Dp/jouVLQMSdMVhOGPVo6d7EfFstSIa1SRIAxdYQIm?=
 =?us-ascii?Q?fK/4fsQsHYDN6oCxtaBazWOLAoeOcHxftfe1f1XIrJYK+m9N8vrR4O3Emw0U?=
 =?us-ascii?Q?SG62HhXTmvFIVNsmg/jbw4Cqnw3xz4rhU/W/3SJh3bGttRjnfgeb118WXMsg?=
 =?us-ascii?Q?zA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1316.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952b086e-9ee5-4df9-8ede-08d9b6831e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 17:34:11.0479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Af8YMDkkajkfnKC+GK+8XhnaZkgimZrsuLW8LK/eJ3oejy/Abu8MtPts5qaswpPJclXlFX/zZbZPJZK3aQ1CPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Friday, December 3, 2021 1:59 AM
> To: Jarrett Schultz <jaschultzms@gmail.com>; Rob Herring
> <robh+dt@kernel.org>; Andy Gross <agross@kernel.org>; Bjorn Andersson
> <bjorn.andersson@linaro.org>; Mark Gross <markgross@kernel.org>;
> Maximilian Luz <luzmaximilian@gmail.com>
> Cc: linux-arm-msm@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Felipe Balbi
> <balbi@kernel.org>; Jarrett Schultz <jaschultz@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH 2/5] platform: surface: Propagate ACPI
> Dependency
>=20
> Hi Jarett,
>=20
> On 12/2/21 20:16, Jarrett Schultz wrote:
> > Since the Surface XBL Driver does not depend on ACPI, the
> > platform/surface directory as a whole no longer depends on ACPI. With
> > respect to this, the ACPI dependency is moved into each config that
> > depends on ACPI individually.
> >
> > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
>=20
> I think I will already merge this patch into the pdx86 tree:
>=20
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k
> ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fpdx86%2Fplatform-
> drivers-
> x86.git%2F&amp;data=3D04%7C01%7Cjaschultz%40microsoft.com%7C0ab6fcc6
> 4a5c4fd8657308d9b64391dd%7C72f988bf86f141af91ab2d7cd011db47%7C0
> %7C0%7C637741223627024908%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
> amp;sdata=3DfEszuAgBLL3g2Z9Lh3DPQ%2BlzrWZR3o6aUst6fDmLOrE%3D&amp
> ;reserved=3D0
>=20
> While we are waiting for the rest of the series to get hashed out.
>=20
> But as already pointed out by Trilok Soni your From: and Signed-off-by em=
ail
> addresses don't match.
>=20
> I can fix up the From to match the Signed-off-by while I apply this, but =
before
> I do that I wanted to check with you that setting both to "Jarrett Schult=
z
> <jaschultz@microsoft.com>" is the right thing to do ?
>=20
> Regards,
>=20
> Hans
>=20
>=20

Hans,

Yes, that is the correct email. Still trying to get all the kinks worked ou=
t, I appreciate your patience.

Thank you,
Jarrett

>=20
>=20
>=20
>=20
> >
> > ---
> >
> > Changes in v3:
> >  - Further propagated ACPI dependecy to SURFACE_AGGREGATOR
> >
> > ---
> >
> > Changes in v2:
> >  - Created to propagate ACPI dependency
> > ---
> >  drivers/platform/surface/Kconfig            | 7 ++++++-
> >  drivers/platform/surface/aggregator/Kconfig | 1 +
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/surface/Kconfig
> > b/drivers/platform/surface/Kconfig
> > index 3105f651614f..5f0578e25f71 100644
> > --- a/drivers/platform/surface/Kconfig
> > +++ b/drivers/platform/surface/Kconfig
> > @@ -5,7 +5,6 @@
> >
> >  menuconfig SURFACE_PLATFORMS
> >  	bool "Microsoft Surface Platform-Specific Device Drivers"
> > -	depends on ACPI
> >  	default y
> >  	help
> >  	  Say Y here to get to see options for platform-specific device
> > drivers @@ -30,12 +29,14 @@ config SURFACE3_WMI
> >
> >  config SURFACE_3_BUTTON
> >  	tristate "Power/home/volume buttons driver for Microsoft Surface 3
> tablet"
> > +	depends on ACPI
> >  	depends on KEYBOARD_GPIO && I2C
> >  	help
> >  	  This driver handles the power/home/volume buttons on the
> Microsoft Surface 3 tablet.
> >
> >  config SURFACE_3_POWER_OPREGION
> >  	tristate "Surface 3 battery platform operation region support"
> > +	depends on ACPI
> >  	depends on I2C
> >  	help
> >  	  This driver provides support for ACPI operation @@ -126,6 +127,7
> > @@ config SURFACE_DTX
> >
> >  config SURFACE_GPE
> >  	tristate "Surface GPE/Lid Support Driver"
> > +	depends on ACPI
> >  	depends on DMI
> >  	help
> >  	  This driver marks the GPEs related to the ACPI lid device found on
> > @@ -135,6 +137,7 @@ config SURFACE_GPE
> >
> >  config SURFACE_HOTPLUG
> >  	tristate "Surface Hot-Plug Driver"
> > +	depends on ACPI
> >  	depends on GPIOLIB
> >  	help
> >  	  Driver for out-of-band hot-plug event signaling on Microsoft
> > Surface @@ -154,6 +157,7 @@ config SURFACE_HOTPLUG
> >
> >  config SURFACE_PLATFORM_PROFILE
> >  	tristate "Surface Platform Profile Driver"
> > +	depends on ACPI
> >  	depends on SURFACE_AGGREGATOR_REGISTRY
> >  	select ACPI_PLATFORM_PROFILE
> >  	help
> > @@ -176,6 +180,7 @@ config SURFACE_PLATFORM_PROFILE
> >
> >  config SURFACE_PRO3_BUTTON
> >  	tristate "Power/home/volume buttons driver for Microsoft Surface
> Pro 3/4 tablet"
> > +	depends on ACPI
> >  	depends on INPUT
> >  	help
> >  	  This driver handles the power/home/volume buttons on the
> Microsoft Surface Pro 3/4 tablet.
> > diff --git a/drivers/platform/surface/aggregator/Kconfig
> > b/drivers/platform/surface/aggregator/Kconfig
> > index fd6dc452f3e8..cab020324256 100644
> > --- a/drivers/platform/surface/aggregator/Kconfig
> > +++ b/drivers/platform/surface/aggregator/Kconfig
> > @@ -4,6 +4,7 @@
> >  menuconfig SURFACE_AGGREGATOR
> >  	tristate "Microsoft Surface System Aggregator Module Subsystem
> and Drivers"
> >  	depends on SERIAL_DEV_BUS
> > +	depends on ACPI
> >  	select CRC_CCITT
> >  	help
> >  	  The Surface System Aggregator Module (Surface SAM or SSAM) is an
> >

