Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CC554AC87
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241425AbiFNItp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242355AbiFNItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:49:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05486E00;
        Tue, 14 Jun 2022 01:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jN0Ad07k7nm81lT8xxprKns9LDOn5e2dekS4kxZDRnZpqC6wONzaGKOcioRKFkwoz5bdu+J6zFPsYsq/N95k56aw7z5Q0yjxkJtpoL3Ulu450F0nELGZNuTTEEkkmLrn39LHGhAVeBPxnoZsCuARxCtAx5wEYfVhMUaIPyAyGU5793lxXhI7myn2+6W4MOyTys29UDmENifXoeXX0DextUyB+PE09XpZ+/HzXQYL4XXi1KORbDXnbbME1RBiA3tg2+WxIIK44b7M3ptYR4IjM3lQycbCVye+uKA1nGRcs14vQzcUbTWINghTcsPIzyrBhu0tRo/uz3BwqFLGc8KvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6QNZ5Sg2E7a0V/97auFqRghXvHQdq00hX0WqtC+sdQ=;
 b=NwxZkupneggoGZAmIwWI5LVWNYeGZR/AktIXcUUMpwDpzbMQSMXDFgdUkC2+PM/kFzVh38O/8J2NPJZ90QgDNiiAbau2rTJLeiJftDCzktXZKNA9B/sr75putF9omqnsx3L0LrdKgGKKeXF0/N+JRpZokgNwCJQWbsun2jDQ6pjeOuGuzsl62epJvUFpHnVNiLVWJv1x5s3CnPyIL/CMthogUaVFJXcTQ+3P6Gp36YfibcxrWSPMg/kiY5lqf/aQsb2WIZn8TE1+jH6ZPSEB8eSkoqOfdsrlo7g60n96qYyl+Hs5sMbYd6eVJGwybSgktppL7kLrFg0H0BCR6OKqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6QNZ5Sg2E7a0V/97auFqRghXvHQdq00hX0WqtC+sdQ=;
 b=OZN4mSt/8vyXK4nWQvGdZVFmwS7NhqEfaPOzlTmO8z2d2b5IzstrLwuRo8DAzuX2dK3qPy4UPYW6BvHobmtLj4QSoQLNKC2RP43YDnKiMSIG8LmQFAZV3Pbfv7SwpTqFe7WDed2oxTTrsreTf+kkAhnm3K+Q70O/Yrjb7WagAF4=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by MN2PR12MB4653.namprd12.prod.outlook.com (2603:10b6:208:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 08:48:33 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a%7]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 08:48:33 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Jane Malalane <jane.malalane@citrix.com>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpufreq: amd_pstate: fix the highest perf query for new
 AMD processors
Thread-Topic: [PATCH] cpufreq: amd_pstate: fix the highest perf query for new
 AMD processors
Thread-Index: AQHYf6KOZYcFMtYHrEyJlpvf9VOSNq1OldUAgAAA7BA=
Date:   Tue, 14 Jun 2022 08:48:33 +0000
Message-ID: <DM4PR12MB5278164CE34536039EC65C609CAA9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220614035229.170852-1-Perry.Yuan@amd.com>
 <YqhJvmQqs86txz1V@amd.com>
In-Reply-To: <YqhJvmQqs86txz1V@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-14T08:44:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=13615505-60b5-41ef-babb-311d08926198;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-14T08:48:31Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 52464d09-3083-4f81-835f-e5d89fbae46f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0fcf501-5b48-40cf-e317-08da4de2aa15
x-ms-traffictypediagnostic: MN2PR12MB4653:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4653ED110359DF3CD9469BFF9CAA9@MN2PR12MB4653.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o4ardLtGJ0gnbSHiDIQcGpoNKi/T81iAwqjEhQIjMzV/PHmO/VzN2csqTbQMpTYpzccmbixSNTc4FFlNEwgMmrK73dSPks9+n+bv6YxlHpLSmOrZC9wLE8xOSa+Cby4bnNkOTyST+4rx8uDjBOiNJb4cntv+k4Qy1MVyJU0jSQDXiH0Q3U3lhr+xrH+YoimFW/cf7S4nzmJh0HvAfhGmAg/8pIXAvn29yGA2L0f8Rd3UUmC9V7ZpVttCJdmtEtqgoTIfwO/EJzZaJWmlNCSes1MVkj4DVxBLRVQET101DWs/fh11lwN/LFeHU6TnNp4XaHSvIXRPgsyIVMVdrNxnlGR806CwG9udDB6rQ38fFa3x/rVCzjAQNrOSsA0ZOE1RbWFYFc9x7LDjvX8WEG2LNlEnnP2l56KfC7mAZLKIrNBhT9DUjlP8OMeAYwMFOBSEg4mIcyo5FterbSIis90XAauJ152Igy6UNDVIYT/S88FUnIcm8nAosPd2z9e5MjQpC8VpczMd9KlO7gxuw+VBXics7Wnb+sI2LB+S5six/ZhQEEJADKYf27I9xackcg8y8szyUUsOIvkPzZ6TR1dr+skyWnmgqEvsuaZarjUBhZQzpCDhOhUPbSrKlYooPfn+Tv7wfthFh1x3XgOtbJ6I4dlMI5HCITS2tnqD176iJMdXJSi6F19sxmMVclhz7wW1kltZTGFe91KCwttLkLWozA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(316002)(33656002)(2906002)(54906003)(186003)(26005)(6636002)(9686003)(122000001)(7416002)(508600001)(83380400001)(38100700002)(55016003)(5660300002)(8676002)(6506007)(76116006)(8936002)(66556008)(86362001)(53546011)(64756008)(52536014)(6862004)(66946007)(7696005)(4326008)(71200400001)(66446008)(66476007)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gT5/uPhQIPPyyPqM9uLuq91aEOqGiiLSe/8sIiYlf3UNaRc92D2oDxqNpFO3?=
 =?us-ascii?Q?XlY4/9MPIqXuJuqJXlWjiYCBVSSXXP9u/6a4qaBTWZPi4eadlPR8in3UNeTs?=
 =?us-ascii?Q?E4bO0yWzCbi6eSYLal/ULHSOd8QkOu3i7d+V+vG63BCvw79MWKExVh2ZXcCk?=
 =?us-ascii?Q?0efBZg/5UQ74G8tPOkMsx529dcThVYtYjds/tQpsTKhiThPfszOCHTkhH08a?=
 =?us-ascii?Q?q6w/nkFfHRP38fhkTG2T8Y2WgFTDgu6TVj/P0wOByt/sOfz/4KfkndtQp2i0?=
 =?us-ascii?Q?fhNecAWAL+NC0ZqxX2SPI/B8VxsgD4G7tH46DIT1rwCJqd7WbEV73dIxx4bX?=
 =?us-ascii?Q?MHynN2TCd5M50H2DsyQF5R488td2JHmgQn4UIK5Z8ThrVGtYcJnaltALuBIU?=
 =?us-ascii?Q?tQWkDJHu34myOzj/Syx6tFjWtsTvVxuPD+F354kYxNnH3uP2rjICGwP1uoHY?=
 =?us-ascii?Q?dMrCLNXKs8FQsfs8ztP7Y3o6W7eKMvWfohgSaf8HAxzmRqY9gl9x3cAGlUOu?=
 =?us-ascii?Q?LjVediZf/5K/sZtT6er65v9gDhLXz1NrNf+nsWGC/2YmX7lG9XG7nbA094qL?=
 =?us-ascii?Q?h1uel5ymRkafgNYTjtwEl1kc9RBD+666eQBd19iy/76t98l8mO3W5AWQtji0?=
 =?us-ascii?Q?JTjYyrT2fTuKGBQ/CXNGPSuTW7IkYOndB2cEmxSZrRo5+6/vBmq4l+y/x4my?=
 =?us-ascii?Q?/FaLPyN+ezZHMekM6z3sUMcGlFP9Az8rXjqGkZ4CHA1sq9IQbNnDVj5tNIQs?=
 =?us-ascii?Q?8gPCuIDwpT1UG31SCMbQpC2SKQpMkLPbD7EdcaCV3cmuY17XdsEp95v2Mryp?=
 =?us-ascii?Q?NAcj1B2sqtC7aW3QDGnSMWRlgaOWYYc6g0DUP7hbPBL3oW12FrygL4oQ7sdd?=
 =?us-ascii?Q?eQsfu69rcUuMaOWTf2Btxs+7ovlJtIckhjmGlBqnR4IDUxs6I3lzyRZk1tBv?=
 =?us-ascii?Q?6f4a6ndRhai+NkWd13sCC7/WZgs0E/4DIrUb6wL66wPvk+LSZsVNkrOAwSyq?=
 =?us-ascii?Q?vj0qjXBWecw0CafpXc48Nb5xFanxCtDv29Ll4xcfXgER1KJzFO8vQV081PfV?=
 =?us-ascii?Q?HAirjzG+CX9AX5lkQ656S4WH61GgDcZlMtKW/o1PbmaUMDBRGQHOjwf483Od?=
 =?us-ascii?Q?e8etVSth2FTwhyWuAPlyxtr9RtMjHJyBfbDIPHzdsquOc7BOHRKm7fPZ8ea5?=
 =?us-ascii?Q?bQsFYvYIZawz8aJCE5BjtQnjAs0XPmHExzqB7y9t1YBbJbFf7u/wfD34sNnn?=
 =?us-ascii?Q?aIP0Oaepuch1dpGa6XNbf3BRzwgfAVfmOC2ePcYs/kVZONOY7ZSnhE7l0JyN?=
 =?us-ascii?Q?mWczaLBl6FtUjiqI3txM1A/TufKFb8kn2tpe1A4ZpGV4u24b2Cb0WECzeF9n?=
 =?us-ascii?Q?gpJf0y62wEV8fBkXy4PAiu32Z2zsKA0yYder83aYKrcZiNwC+duRzuVPOBGd?=
 =?us-ascii?Q?24ZV3Tdy+8fepVJLyGzprCYvfvpBTfxPIiNy43pMCd2Gu8TKixhgxI+kmnTr?=
 =?us-ascii?Q?bIQi0iLJH35Fn/X96aHKqzoQh+iyvK+1lZ56W6dBz96qnrgLFDrJQGr5lVPh?=
 =?us-ascii?Q?jE+74nkvXvpk4dnH+ppNPE+2HJQNaLYHtOH+DysM0dFxvKixktYLYu/rKpv9?=
 =?us-ascii?Q?I5C61K/wC7Gjem2r0cBdkhyGJ9S6UTW+goL+yo1CMB6/2EWSIO+uTDU+6a6+?=
 =?us-ascii?Q?op9ebSXBdKJR5hvKu2/UBoxjVsRQyge+QQtKlw1McmQFTzRF1i6KZF59bwJp?=
 =?us-ascii?Q?Q7+79omkjw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fcf501-5b48-40cf-e317-08da4de2aa15
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 08:48:33.7542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1ECbd3myGZoc+6AVyU8xhNBLIZkVfRx30lq+l3HWWPXXVZwUQawzLWdXzqb3CXZ+uKs4CrcIR6OEowW0CuXtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Ray.

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Tuesday, June 14, 2022 4:42 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>;
> Borislav Petkov <bp@alien8.de>; Dave Hansen <dave.hansen@linux.intel.com>=
;
> x86@kernel.org; H. Peter Anvin <hpa@zytor.com>; Lendacky, Thomas
> <Thomas.Lendacky@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Jane Malalane <jane.malalane@citrix.com>;
> Phillips, Kim <kim.phillips@amd.com>; Tony Luck <tony.luck@intel.com>; li=
nux-
> kernel@vger.kernel.org; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>; Meng, Li
> (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org
> Subject: Re: [PATCH] cpufreq: amd_pstate: fix the highest perf query for =
new
> AMD processors
>=20
> On Tue, Jun 14, 2022 at 11:52:28AM +0800, Yuan, Perry wrote:
> > In order to get the corrent highest perf for some new AMD processors,
> > the amd_get_highest_perf() call will check the CPU model and return
> > correct highest perf value.
> >
>=20
> You needs to change the prefix of the subject, because it's not the amd-p=
state
> driver.
>=20
> x86/amd: Fix the highest perf query for new AMD processors
>=20
> Thanks,
> Ray

Thanks for reminding me that.
Will update the title as below. Sending V2.

x86/cpu/amd: fix the highest perf query for new AMD processors

Perry.

>=20
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  arch/x86/kernel/cpu/amd.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> > index 0c0b09796ced..ff2075f26ef4 100644
> > --- a/arch/x86/kernel/cpu/amd.c
> > +++ b/arch/x86/kernel/cpu/amd.c
> > @@ -1152,7 +1152,8 @@ u32 amd_get_highest_perf(void)
> >  	struct cpuinfo_x86 *c =3D &boot_cpu_data;
> >
> >  	if (c->x86 =3D=3D 0x17 && ((c->x86_model >=3D 0x30 && c->x86_model < =
0x40)
> ||
> > -			       (c->x86_model >=3D 0x70 && c->x86_model < 0x80)))
> > +			       (c->x86_model >=3D 0x70 && c->x86_model < 0x80)
> ||
> > +			       (c->x86_model >=3D 0xa0 && c->x86_model < 0xb0)))
> >  		return 166;
> >
> >  	if (c->x86 =3D=3D 0x19 && ((c->x86_model >=3D 0x20 && c->x86_model < =
0x30)
> > ||
> > --
> > 2.25.1
> >
