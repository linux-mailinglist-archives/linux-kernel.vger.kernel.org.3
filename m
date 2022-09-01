Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9955A8D69
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiIAFe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiIAFez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:34:55 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAB611174;
        Wed, 31 Aug 2022 22:34:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcNTt2jeesSSH3qLwh8imLYmw4SmJx6hEMMIGnTohrT6X9Kg9XMtjUY0QyaxjGW88Fj11S6Vi8Pc1QYABF5Zr0cOPKBE0k0VqyCP8CxaFKjQybBLzvRZSWQ3sqGhttj4ZzCTHZ/LkYneaVfW4cswa1x/x7Z3ODsKp0IM/Ljg4aZXPitzcca8s0s3wPd4LFi3/uWLXs0me0FQlA06uBD0aNpBsbK/bpeJubQbV3IBBUAjjPc3GLcyel1+cD7BItWnw4Nx5qjB1/c1I2wnzldX2dVQu2D6RLGa3n+dRO9W4wceA+IQ0YlNL2TzHHx6WmW9n1F1lCPZggY3zWWTlwznIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R63nkICtK0PLXmD+TDK+2kjQj0c2IMfWkshfCxR85q0=;
 b=iH5GzqQ8nOGZ0Yf1EFsVgJq6VK5fMbWWxspVpjiAikfrVnCv/2kzTImuKRR+MKJav8Crtz7FeC/MV1X5NICSWMnSJ9XmCfm58cqp6HhN7lhwCD32KqcD6oiR1WOXqufxHyVpqdH6jrsXg1HqF+0NNAbVOgGyyEsmMbUtrPi59r/3f2FXLC1RHx99uopA/lSjXZBQeEwM4dD/C+p9lZ8M95YiKRxuWajdfdLnQOsWMuIeJGWM2h4YYCUUZwFJtLRhVCHq6O7KW9bRzeMMPCKHPF38SMd4JnUKR9WXn4/pMZvOVeFa4Yu3WrUuHah6GmXV9VvBFRjo9Mlf/PRlBZCAeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R63nkICtK0PLXmD+TDK+2kjQj0c2IMfWkshfCxR85q0=;
 b=TQLNeJWMt6Y9Q1NSlIIvtCn611ZYyEy4Iez6kr510J//IG63Tvk08STPi23kZ9CO6JZTG9UqHNcf8fSpR6XA3egHCr+KGqO2ORrmxycKDKPGxJZH41HQtAKc5wrxBkfzs3AjHzXMXO0y69+Wy3OmZCS1xkDCCV4YqjmFu5UqokQ=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Thu, 1 Sep
 2022 05:34:49 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::a970:8eb0:b1f7:5e7c]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::a970:8eb0:b1f7:5e7c%8]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 05:34:49 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Punit Agrawal <punit.agrawal@bytedance.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/7] cpufreq: amd-pstate: cleanup the unused and
 duplicated headers declaration
Thread-Topic: [PATCH v5 1/7] cpufreq: amd-pstate: cleanup the unused and
 duplicated headers declaration
Thread-Index: AQHYr/wWMsX5yuaLJ0WJ+Zrc8xldw62wELxbgAELwBA=
Date:   Thu, 1 Sep 2022 05:34:49 +0000
Message-ID: <DM4PR12MB5278152B572E53554FFD59069C7B9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220814163548.326686-1-Perry.Yuan@amd.com>
        <20220814163548.326686-2-Perry.Yuan@amd.com> <87fshxim49.fsf@stealth>
In-Reply-To: <87fshxim49.fsf@stealth>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-01T05:34:43Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0b55b00c-1f66-477e-86e7-db6ab106eb8b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-01T05:34:43Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: a8259b68-022f-424e-8ac5-6a0ee29b5e6a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f47fdc0b-2538-49bb-57aa-08da8bdbb012
x-ms-traffictypediagnostic: SJ0PR12MB6942:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: olHcwPFpKmIkI/dvzn1IcFr086XfdrTqCLsg/cyttqQfBKPUtu1Mtb7zVpiqnfe/BaXNNZW7CAWn0Od7llUAnZFu+pSCap2fFgVRUmUZ5Fxq2y7nWWnb32HlhJRd+yGKlLOohWT9kFze0dktKWPNnzB7abRquRMDTOniX8v9JCMhZ7sdn+tq15LGG1vK5+lC//BGHXuYchry9/X06wNWWeTGlL+vTtTmV8rs6fiyvubOZZlV7TFOQZeffZcTgdUuV/f5NgAbyspJa72q8epPPVI64JcsJaVeYj/bokykr5pJvn++sOOhqY+pENwlH0c4/JykNZw+uj2yIgo4smg8AHDiuYeUURmVHToPAD7plnUZXqQVSNFw+dDGu8Jk80cDi3hiw93Sa1OLTb0QQkxIBZQDX1cIlKFEumKEDBaONutI49fCP9y4FH+kBqjzO7jzRBw503/CT2gHWcYp6mvO6QokCyv8k9s6Frkl++qzVAE/oE0Uze43eF9hWWGuu7KBl2ZBtvr9VnkS2Lxdqhuxuy3KOp8ZCzwCHiBBLhRJQUgXfmnW28sME2zNl0XyQJckS0TZ9MGDBUuxjDcwFDibhAvxaVcaAFm1RkZa+hHERMYrXUrdvHbxNt+AqufXEVvbu/umjeCyokoWw/ED++PLxtDwCmL3A8xqSZ2dhVAaLJmXBEsZhDopIB2LVQ3beTZrJLoYZh9VSw8yB6rJUhpDXSg7dUHpP3sC8idJIxRxR5pjewN8r2RJsjcoVD7RHI7K0h7RCJ9F9CImSyYgN2hDtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(9686003)(186003)(6506007)(26005)(53546011)(7696005)(41300700001)(83380400001)(71200400001)(8936002)(52536014)(8676002)(5660300002)(4326008)(55016003)(2906002)(54906003)(66476007)(6916009)(66556008)(66446008)(76116006)(66946007)(64756008)(38100700002)(316002)(33656002)(86362001)(38070700005)(478600001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IZHj1OmmRXsmkLOIGRJsN5iwpOC2r5o+0wtEllrTaH4i6opJRtK/DH+lM1WB?=
 =?us-ascii?Q?GOfuNmH/i+6uXWbtON16zlhhSHWGDrzKrUrNKeGcZMxTx+lUwH++vWKuX7FL?=
 =?us-ascii?Q?2WYMf7AkJyn5YYT3Tejav0xrIMnV7PSSwoSy5kQeJU2yk/uuigvuUebdVFSM?=
 =?us-ascii?Q?JkwoRnUrNvkyAQqHj/qL1p73hVFXhERv9PCn8wun0JhFSkL3wvcV06/Hvx1g?=
 =?us-ascii?Q?9rh9AUBhmZo1TG0agu72gB3AuX5vTXpxo7BVhCUfTw/SWUniFp1MtQr3goZD?=
 =?us-ascii?Q?mFW7U38exkCm7bcnnTvSoXyTboNBQLMW4gGqVvlUCX8n1oZHTVJuMRXhU72I?=
 =?us-ascii?Q?LMhb4r3XLAWD9+rPJRT+xXfZM7RdG3xIcJ1DGJE85q9NQrGLSHgaxXWe2+WT?=
 =?us-ascii?Q?kY9c5BK0hiLqDI8yUAfsSG1qj2Mh/IAc/lh0tV2QL1+ubRFY6WFnUE2wfvMA?=
 =?us-ascii?Q?IHyB7pyFULxkT8KcTNyLDc3DnCQRQWqv0Xscwg1riDFya6lFYtnQ9pg7WxVb?=
 =?us-ascii?Q?MZDdb/oGjVVduFlzQ7gu5jBT5/6VfkMz+mWhKdC1lHleyHXrexBU/KEhUDgy?=
 =?us-ascii?Q?6HlI62BS7wJqr1sOjfHZIpnlJgpCubanpq/Yssmb6O1C65sgOK+Wsn1w/CdJ?=
 =?us-ascii?Q?2kkSBSB1mo0yr+Hrl+7Amr+9oJniIibdNw5xGV3qRT9FUcFjdK+zo/uyxXIb?=
 =?us-ascii?Q?wLvgCYYcc+3AXljouvnAYJ48qQ9L5qmAYmGI7z0FITKDO2OIKYe2PPCs6hC3?=
 =?us-ascii?Q?C07TLLi5xBgEfCROhuaAAwVWwCHRbqztNI8HhjC6w7bGMy3eetp2PENrYGuz?=
 =?us-ascii?Q?uuKoVZ80+9txEy7OCLyaoWxvCgBvTBVd1F4R3MWxiycvwRqXVIRzLnY5KMJM?=
 =?us-ascii?Q?1dX8zgPv5MW1zoo/hlQIycNLNZp1pjxI9oKFJy5mky3bQdPIKd7iwumXqEcs?=
 =?us-ascii?Q?YTYgHYtuyXFn0QUQLErK3hW6dTE7akD33vxh6qWxnetJpUcT1qCxbaRYIvkX?=
 =?us-ascii?Q?78lx9v1YYywoJAGkSQCb/JhYzNvoFqbcCU3rnTvaC4trjy8fQsuZEvaPIzmK?=
 =?us-ascii?Q?N8Bawc2EG4m+c3Ci+LumOqdi3lUAaF4lauNnUe7F2c+uBQxa9g64NpDZ3+Km?=
 =?us-ascii?Q?8U0TgkKmj3hDUn00PKy6KtJkrwxZjORT6UfO1ghgN6sN52nEtgfUNs4F/exg?=
 =?us-ascii?Q?rH50HwugJiA759jVQk838DoAA1WItL61heVKj/KIUvmgr9RVzMtDYyVm/f7x?=
 =?us-ascii?Q?TZpi02K3AbtfB25mCJEjyvIABi4+H5y8hVnQJu/c46vhCP3KrXgVbgVA5dEd?=
 =?us-ascii?Q?SHUbIwSXQE0BRJKEiFOhfAKgKTU2eQz/4RaOWrE7WOAJNiPt9HTzxSCUS0A9?=
 =?us-ascii?Q?UamQDkQt8aQycThl5eUyFX0Og8+wZYyqBGqycS9jzIUr9XzjPbXQ6xClex7V?=
 =?us-ascii?Q?Yk4RlwDB5E+pQ8F4Yd4WLDEU7VJwMWEt6uvfur/zirvdPAvvjsXhFYc5SO0Z?=
 =?us-ascii?Q?CyFd7urfkz6u3XmlHANJuIOPgbrekXm7++TrvuW6LKv7x2whpQwhDWEeZIMT?=
 =?us-ascii?Q?IA3pzUw1PyGqq2poHI6NbqevGqjfyRfe2g/0ef21?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47fdc0b-2538-49bb-57aa-08da8bdbb012
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 05:34:49.4281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qQySMn0V4dZeHVDfBTRcev2lQl3EOQQFbxBKjBlVHanJH44liEyc/eje2mYI50tO4tWGrLtmJ1hmR+rHmZJVGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Punit,=20

> -----Original Message-----
> From: Punit Agrawal <punit.agrawal@bytedance.com>
> Sent: Monday, August 15, 2022 11:05 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Huang, Ray <Ray.Huang@amd.com>;
> viresh.kumar@linaro.org; Sharma, Deepak <Deepak.Sharma@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>;
> Huang, Shimmer <Shimmer.Huang@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5 1/7] cpufreq: amd-pstate: cleanup the unused and
> duplicated headers declaration
>=20
> [CAUTION: External Email]
>=20
> Hi Perry,
>=20
> Perry Yuan <Perry.Yuan@amd.com> writes:
>=20
> > Cleanup the headers declaration which are not used actually and some
> > duplicated declaration which is declarated in some other headers
> > already, it will help to simplify the header part.
>=20
> We usually don't get rid of indirectly included headers as long as defini=
tions from
> header are used in the code. This avoids problems if for some reason the
> included header gets dropped - it'll leave the code in an uncompilable st=
ate.
>=20
> More below.
>=20
> >
> > Reviewed-by: Huang Rui <ray.huang@amd.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 9ac75c1cde9c..19a078e232dd 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -31,19 +31,14 @@
> >  #include <linux/compiler.h>
> >  #include <linux/dmi.h>
> >  #include <linux/slab.h>
> > -#include <linux/acpi.h>
> >  #include <linux/io.h>
> >  #include <linux/delay.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/static_call.h>
> >
> > -#include <acpi/processor.h>
> >  #include <acpi/cppc_acpi.h>
> >
> >  #include <asm/msr.h>
> > -#include <asm/processor.h>
>=20
> On a quick scan, I noticed that "boot_cpu_data" and "boot_cpu_has()" in t=
he
> module init function are defined in "asm/processor.h" that is being remov=
ed
> here. It may compile for now but makes the code more fragile as explained
> above.
>=20
> Please ensure that only the header files that have no definitions used in=
 this file
> (amd-pstate.c) are dropped.

Here is the part of the headers we are working on.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#include <linux/static_call.h>

#include <acpi/cppc_acpi.h>

#include <asm/msr.h>
#include "amd-pstate-trace.h"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have tested the latest Linux-pm/bleeding-edge branch to verify the change=
s working.
As I know  the "asm/processor.h" is included  by the  "acpi/cppc_acpi.h" su=
bpath

#include <acpi/cppc_acpi.h>=20
   #include <linux/acpi.h>
         #include <acpi/acpi.h>=20
              #include <asm/acpi.h> =20
                       #include <asm/processor.h>
=20
To make it comfortable for us, I will send V6 for this patch (1/7)

Perry.

>=20
> > -#include <asm/cpufeature.h>
> > -#include <asm/cpu_device_id.h>
> >  #include "amd-pstate-trace.h"
> >
> >  #define AMD_PSTATE_TRANSITION_LATENCY        0x20000=
