Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8FD57E334
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiGVOqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:46:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1983CBE7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzvWRJpkB3Ai2QiY+zAIt8xQZhWjHezI4kD4DLK4uxHwf+idpDs7yzxvYeRC+4HZM/wZiBqDpICJEPtiDydXepP9jUtLzt54dpUhlpS2H06A1WJtqL+eLI2qD7wC0RNMqGvRhYlRAr6S82CtllgwSKUpOdA/hvaRFVP9MQOPPOn69gK+J6IlFu5pGFSHCmOkWjsRIFYX2JJSHhKMtmp3rvNwrlSZVD0qoTbteaKSUHcXh/LwNlUMe1ph2M8g3HqqPFy6HOg5L//DaRnywN5D/nS2cbl8ASj/lg4o29Y7/Cze1VoEXqFmU6PaIfqtb9+kpbmMk9Ai63uCAt7F9yVH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ici0laM9NbcCcJDQ/fAXlXwyL9Yb/ep6ZVzYTWLcW0=;
 b=lBJLEKu2H0l51T78vfRV44VP0SdIz/mW++2vo5YDBXLjAAdfPbkDrpMV7zkXIV7PWCbPJv087rI+IXvgMlhsWp+SUAFQkbvxQN5xVEiKxKqSx7BkP5cNwXPuY2bLZUV4v51+IEc4E9cKbERx6c9SPkO2LzpSoncWyPMsSiKf1ItPyKrSnDGOrIXXH8O1Uqx/OPcVWyNFgxXCbakl8qULfCoY73+YS8x7GvoG+zSWCZnpW7Dgrqu6VUUZSt8LYEdTpgT82cGtjXie3TrZVDOpX78exybuIgQxVP3Opc0dNw+cEqtF3RrCVqDY7SWCDIaUFkGLeQfKU8x8E2FYyX/4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ici0laM9NbcCcJDQ/fAXlXwyL9Yb/ep6ZVzYTWLcW0=;
 b=NiMR7HKgVUwEPw9NffwY/QX0h5bPGrIMIrPcZhtahqtQDvJqLvPXM2KcUAmKC6dD68DUGrt2FZjhv+exsMBgMcagyKfy+i+jHNT1ONDgBy96D4NdkNnuPyYflJrVoe4pL9sebak5wA94tywP3n4zlbT7MKIqwK28ZMyPqUe4MdA=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY4PR12MB1125.namprd12.prod.outlook.com (2603:10b6:903:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 22 Jul
 2022 14:46:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5438.023; Fri, 22 Jul 2022
 14:46:40 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "markpearson@lenovo.com" <markpearson@lenovo.com>,
        "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "gerbilsoft@gerbilsoft.com" <gerbilsoft@gerbilsoft.com>
Subject: RE: [PATCH] ASoC: amd: yc: Update DMI table entries
Thread-Topic: [PATCH] ASoC: amd: yc: Update DMI table entries
Thread-Index: AQHYndGxeTv5g/s+NkCsB37UOMEoi62Kdy9Q
Date:   Fri, 22 Jul 2022 14:46:40 +0000
Message-ID: <MN0PR12MB61015828F24938CBEA87F8DBE2909@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220722134603.316668-1-Syed.SabaKareem@amd.com>
In-Reply-To: <20220722134603.316668-1-Syed.SabaKareem@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-22T14:43:32Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=08afe15a-2ff0-4779-84f4-30b416e0bf47;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-22T14:46:38Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a384452e-2a4f-4614-8eeb-047b50019864
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8514d3c3-e5e7-4943-bd18-08da6bf0fcbf
x-ms-traffictypediagnostic: CY4PR12MB1125:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9QztxhtS1ARH/jQkU76mYOrUs8JJbgdV5Ka6pzDNWmxKhQmiZsAmnLdWUp+CIfkkVWSllMLcvJQYMemZ9IDYZrlNLd0c3tt0ruyi8yJS99nZrDpNg+u1QRlUe1nm0CsBOgGqooxFkkXP/NBep2HO7wGpBrcTMOWYrnNGUOIBWR0KHDmhbTWgDANVpFhOSzGchFbwhsiYASeiWcUItVuYhzn6ZVoH2qyW1d0XVOEZ0RBphsQcp9+1I0jGK8AnnmgsbfooY52a9n17cDTwzoXKEYYJKetmyKDO6ZhD/WvK3UU0e3W1sQRJNzqsUNm6oKrEJzX5bRdUGe2Glqum6AaldLCqAOg8lrUMcBzgbtUHgvxQGQTZXQcMLmJYPu4NaO+xAq39z9LCVuT5QLX/TuIp4VlFU6n5FBt/HDsELW4lrCxVuYhw+VY7VIQGtIijw38/APKs1dIJS3/UF1hkWPMEfjKDqRL1PJZYB8/ynt7VA3oGxjGas56bcL1K2VZQx7ZYhs5j+JQpazfM7Z4u+YkMviwI1DqNlV0xmZ30eL8Bp1OiXiZqk3ROu7F4y17znX1jrNomK4VTV1m8kuc6WWV5qcwji3ILAVvcPUCNY1VMK/r73nL6zUKkSPh1WsEaYMeBFolypP/K/COhqY2uiHyaIFE8Qu+v9lCit4zYGmqBzWvLrWh+DQfI20yOCKTxBYJRIJktvDvKyNueDWrkpHD851LVBcISfhN6fTnkJT+yQWceR8glrALR7KwODbehBywUkoasRIwdxNS6KqJE6cLDQ3z1e2XOrqR4D622K72U8Y8lXm/nNhTAu7dbXkml6sqQQ44uQ6rT3/SmPXZSG1oR+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(186003)(38070700005)(66446008)(83380400001)(38100700002)(66476007)(110136005)(64756008)(66946007)(41300700001)(66556008)(86362001)(8936002)(53546011)(5660300002)(9686003)(54906003)(7696005)(26005)(966005)(316002)(33656002)(6506007)(478600001)(122000001)(52536014)(8676002)(71200400001)(55016003)(4326008)(15650500001)(2906002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7f+lukq8G+CziAIX4oqZckGOk1CAedyzvymGY8/Xt42lNWgIsfAZ3uG/uyP9?=
 =?us-ascii?Q?hGprYdfuABOCtVZsFGg+QqtAr5GDGzQK+yhARsKR+wWTmyjmae7DdcukEutb?=
 =?us-ascii?Q?fceUGnNBDHojRz8gTATgz6DrijiIxR+mN0C1UsEaZyJYrGl7dypnRbfcuA9x?=
 =?us-ascii?Q?PVJJWR44b39Z2Y7ojEwaDlU0XTWkW9g+Kbg+N6BGcFs9RizZG87GMQnXInLF?=
 =?us-ascii?Q?/8ZgKevvI0UmN28KEAljBsPlCFVVS++cf/BRn8lAUeyh9VRhDnrLr8+jDwV0?=
 =?us-ascii?Q?PJtTbm4i8jAd7HpQFsThzhNTSbM1aNIwxyjOIpzYLPVuGOJZ3iTD/H7XVcRM?=
 =?us-ascii?Q?E/JhcJ4Xt2XfobqXJ0/4G1vE/GAnRtp6C9YCR4cO+bFdNoMegrrP6w3kN6ye?=
 =?us-ascii?Q?PQEhmLsouBqRggIipLig7j8d2wIrOdzjIXc94k9dQGT73KE3mVlVMnfjafzp?=
 =?us-ascii?Q?m0ekOYGN7XZTYASTi1LhMQnkBsukI7U0NvtTlX2W0MJqtQGY42p8r6sLrzy4?=
 =?us-ascii?Q?AgNzIy8kC+ApTEpD1x38Njsp2VrdAMhm1+mtGFFJyL8H2303E1QXmhe5kFAJ?=
 =?us-ascii?Q?AzcoGYZ+u/5+rdFjK5PORkhlOvgF+m1d1bcA2Vi/MKUmHKj8gquaWZdVutU2?=
 =?us-ascii?Q?4Y4iVmktpS7b0klVM/0U6P0HjJVYwjKfVvpi4fjnOBZPSxHw5iSYf2PeEidW?=
 =?us-ascii?Q?wTu7NFoujgkNjjYhZuoizSo8anDHR/yvBLDX4ClKbflv/hvOyNPvyezn/vt2?=
 =?us-ascii?Q?VE4jIVwTQsHaKB4s8z9gYX2kF4m7iqCp0soMBG4sbWsx2kBgxqJLlENRp9fs?=
 =?us-ascii?Q?6OFpKrsZoI2G/YwY6N2bQU0C307Rms5e/VFfonVBXpETUbsmpJlbmKF8kSwl?=
 =?us-ascii?Q?otDWnh5sz7ZNattTM2Mg1OQIii6SZ3LOLscuMc1RHrhfkRCS24HxGIJtNcV5?=
 =?us-ascii?Q?WUUAmdXfBzsPPMCxkZG6gq4ANfQ53Qi15W9XsRpH/1ri3I3zXsMorOPcpJqf?=
 =?us-ascii?Q?3E24GgJXmZO5Yr0o39rHxxSnSgELbyxHe/ZtQmXS8K94HfKZ3gzR1y5VFFZC?=
 =?us-ascii?Q?Cm4rMTjF5TPoATiyUbB9a8W6Q+fj599KlAPN4+HaF8vHr1+Wzt8dmEwr2Rxa?=
 =?us-ascii?Q?MwBTLCpLgJaG+Ovx5TODtzWNZNIX4u+995Qu5VK8pHXVK5ode4Zp2/jCVw4S?=
 =?us-ascii?Q?ZPPKYbmm3WPOI2f3d8OI81rvvFXJSmBW94nn3GJinRgPFfTVG/dLDRznIkRq?=
 =?us-ascii?Q?7BsF992cIodNHQ+Er+4K51js8meKcyG9xuaiFy+6z1HWlfd3FYX8HWFwwSOh?=
 =?us-ascii?Q?2m1nQLMnl6GtDxXHoxvGAy7o3Hsktg/akZQPq9nQ4Ihfjt5M7c/1LEWCOmSG?=
 =?us-ascii?Q?kEEwkUTbr1c7KbuJ3Vt+91tVMCOM8o3+tKA+phsnzf+potr9f684bzDms9X5?=
 =?us-ascii?Q?cmMmh08n9s9QqjDZPRJ9Q6L3voEOWU5kboEI4wEcrWyQM4oayi5lNcneU+7R?=
 =?us-ascii?Q?havnSo922TOsUzAhnfxBlTkGfeiE7MpbEquBgHIrKygAV2/Z5wrKn2mrNY1t?=
 =?us-ascii?Q?YdVkIMPgEbq8bG9Fmi0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8514d3c3-e5e7-4943-bd18-08da6bf0fcbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 14:46:40.2625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHVE795iGg2lfcung46Fzf9Hs/LkuXVcDy9ruiiQPn6gmUq36PgbiGVhQm3hl7CyCZP5qprfCItN2S4UmHjAkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> -----Original Message-----
> From: syed sabakareem <Syed.SabaKareem@amd.com>
> Sent: Friday, July 22, 2022 08:46
> To: broonie@kernel.org; alsa-devel@alsa-project.org
> Cc: Mukunda, Vijendar <Vijendar.Mukunda@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Hiregoudar, Basavaraj
> <Basavaraj.Hiregoudar@amd.com>; Dommati, Sunil-kumar <Sunil-
> kumar.Dommati@amd.com>; markpearson@lenovo.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Saba Kareem, Syed
> <Syed.SabaKareem@amd.com>; Liam Girdwood <lgirdwood@gmail.com>;
> Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>;
> Mukunda, Vijendar <Vijendar.Mukunda@amd.com>; open list <linux-
> kernel@vger.kernel.org>
> Subject: [PATCH] ASoC: amd: yc: Update DMI table entries
>=20
> Removed intel DMI product id's 21AW/21AX/21D8/21D9/21BN/21BQ
> in DMI table and updated DMI entry for AMD platform X13 Gen 3
> platform 21CM/21CN.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216267

Syed thanks for the quick patch on this issue.
I just noticed one more tag to add for the reporter of this that Mark can p=
ick up when he pulls this in.

Reported-by: David Korth <gerbilsoft@gerbilsoft.com>

Also suggest Mark this to consider to pull back to @stable, mostly because =
of the X13 IDs missing.

>=20
> Signed-off-by: syed sabakareem <Syed.SabaKareem@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  sound/soc/amd/yc/acp6x-mach.c | 32 ++------------------------------
>  1 file changed, 2 insertions(+), 30 deletions(-)
>=20
> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-
> mach.c
> index f06e6c1a7799..ecfe7a790790 100644
> --- a/sound/soc/amd/yc/acp6x-mach.c
> +++ b/sound/soc/amd/yc/acp6x-mach.c
> @@ -105,28 +105,14 @@ static const struct dmi_system_id
> yc_acp_quirk_table[] =3D {
>  		.driver_data =3D &acp6x_card,
>  		.matches =3D {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "21AW"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21CM"),
>  		}
>  	},
>  	{
>  		.driver_data =3D &acp6x_card,
>  		.matches =3D {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "21AX"),
> -		}
> -	},
> -	{
> -		.driver_data =3D &acp6x_card,
> -		.matches =3D {
> -			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "21BN"),
> -		}
> -	},
> -	{
> -		.driver_data =3D &acp6x_card,
> -		.matches =3D {
> -			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "21BQ"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21CN"),
>  		}
>  	},
>  	{
> @@ -157,20 +143,6 @@ static const struct dmi_system_id
> yc_acp_quirk_table[] =3D {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "21CL"),
>  		}
>  	},
> -	{
> -		.driver_data =3D &acp6x_card,
> -		.matches =3D {
> -			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "21D8"),
> -		}
> -	},
> -	{
> -		.driver_data =3D &acp6x_card,
> -		.matches =3D {
> -			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "21D9"),
> -		}
> -	},
>  	{}
>  };
>=20
> --
> 2.25.1
