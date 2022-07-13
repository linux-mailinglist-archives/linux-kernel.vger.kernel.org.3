Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF261572DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiGMF5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiGMF51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:57:27 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272311E3C3;
        Tue, 12 Jul 2022 22:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI8oLKDdKsHIOLiIBzZW3g7ii4hRtsMSv4yBjQ+MF9dfoYb+tY1LcFvDUTJ2mWKMjvM8VPa1hkbw31iwlN8VHQH9r3ObbKaiI/k1EdzKvbNCEVmmUDyEZbaNBsE7hEt0xJGtxcWTP7T1SQKLOm3JZyuh8WnNUfGLUQPijd1ePN2FQECdsgWgYx2uEnEdn4TiZz1JHJWbsR+8rNl2GgW7q4jowkG98ZrRES/X2LtM38wwCyIeuVjOZcFVFFZw7PfEU5dUii4pHInJgIsmMVXUtqGvXhYqVaI2LIHvt+qX04hgbLAm+/uGZ3biE7zAK4w3EG/mXBWhSbBLZMfCgYvNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIQl017Qs+6QA59zapeKW8dcIr857l613pm0Md94e0w=;
 b=PW2yYfvSMcNQG6G8UHq+vfGv2qroQXt2yoqCENn7Kp0NzvvKleuz4YxjnAlSrI+FQeAcMoKYM0zQU2Rp8EoxgiKiYZzkviIceG5wA2wpyuyauRvlx95RfEtDdkvfHy9/T7SaYIWyVRzzCRjC+/3+qwlG+EbTIRuHRSuIntVV/GkAm9jpO6mQ2PfmiQc5G+bDK2l/LQb0Tpk9l6snKOwcc8cMDurSeLHUDc5h4QkJWJADnDB6gQT/QQClwGdQDO7L+UvpLlkTn5trrZotAl9aUFWy9l+6f2O7RkULhkPh+FksE2mA4t1PW6j9ldrtxIkxA5Itbg2H2aIb0NmwEZiNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIQl017Qs+6QA59zapeKW8dcIr857l613pm0Md94e0w=;
 b=yA6Kni75+N5HzQC+aBd0UWWtwZ8mjG8MWwaMwuQ/nYyIwSqIwTVcccjG1TK+AXoSBpRm4wISJIvxolqPyb4vq9XRJZUFvwTJycofDZSinM+txLZDnLdJCGevjz7NcrC1yssfezzn/NBDRSdsz5RT47UGRhzOoI5zD6XCbmIKh6E=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 05:57:22 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 05:57:22 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH v3 04/13] cpufreq: amd-pstate: prefetch cppc_req_cached
 value in amd_pstate_cpu_init()
Thread-Topic: [PATCH v3 04/13] cpufreq: amd-pstate: prefetch cppc_req_cached
 value in amd_pstate_cpu_init()
Thread-Index: AQHYlgW7jGCzqcEoDESeugEQOhJ+Xa17xlgAgAAHarA=
Date:   Wed, 13 Jul 2022 05:57:22 +0000
Message-ID: <DM4PR12MB5278D92E034820A6E33D94079C899@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
 <001d002ba93580763421c712247bf8d9faa67756.1657638462.git.Perry.Yuan@amd.com>
 <20220713052708.2paskxzl6s32j4yd@vireshk-i7>
In-Reply-To: <20220713052708.2paskxzl6s32j4yd@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-13T05:57:20Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a1c881c3-5ec9-464c-af6f-ba5e58a7fbd9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-13T05:57:20Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 9043a3b1-3725-477f-a684-4f5b9447f57c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69ebccc6-7f0d-407f-b979-08da64948e04
x-ms-traffictypediagnostic: MN2PR12MB4566:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kw12XbIM2iuzjROGCaqI/RTDYnO9vz2J+/L8eJnF/gO4/7ExDX3+WdfIO/s+Dstg0rbOIP02JRCk6zHsLiVfnTKISMA0FvUx5iJ/jIXqRYVPzFHtmbdh314QvcgP7OOzw2FJg1qV89upLSqW2Dp42TuovkDFu4/5NKnvBvw0hhV0qlgyP1XFBUHCVkkZrGCkq4A16BJhB+/bpP2QtbzIB4t8KmfNyQabdoYcZ4o6voSju1KHKKwAYYzpDf/SMtHMHwpQJwmVPipZPjpY1NXt2Wxt4xK32SLWHmY1heR5BPKTSXOhZct2+y20jS9V85VfXURyjlaHklTeAR90pZun+Eyva7p9RYRAu1M9RPLqjL51sOqZlJjWfQpu+p+T3prjS97T0Y7izFRnvgtcHWFDZl+fS/ESVRe1hSl4gui1UhBuChASR0l9ym7pe0PO9rhIPhyXzn7Liy8Vsca3n54zvcCFUN2pCy0WYJfxfUHR4GayL1UiCo6tTBs+cHbXjC4WcmjI37ek8LP+0zhBi7Yc5vr5RTIW2cydtWcXOGzT/9Nych0Lq39TlXXs1mOZlEzVv6Uikm+LdEY7RmU6TPUQJzcRBn+E8nhz9i49xF3n4OPByQk0+fqGcbmGlzi3oav/MhOhiO/9h/EgHXcf2mlb3PZZ8+4rwVjztj8dtiGofC8qexP2bwq57mFJWhbO+CctMyNCpl2DzjfbawkLP/9KLUbabqEhMsZF3MiWw1EZgpctT9xj5ILEJhH55h3XCdGneaKYKsYOqnqz6cEs6sDUYeZsiMNF7aQ6mNIyL9wCQHv5JUA4a8BOEzRaENTd62zD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(122000001)(6916009)(33656002)(9686003)(64756008)(55016003)(316002)(186003)(38100700002)(66946007)(76116006)(71200400001)(66556008)(5660300002)(66476007)(66446008)(8676002)(4326008)(83380400001)(478600001)(26005)(8936002)(2906002)(7696005)(54906003)(86362001)(53546011)(52536014)(6506007)(41300700001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xGQB0zheZmDQZ6F8YBeDV6rcrgyI/r9y+aSETdZ6ygfLKm+8lXNE4S3uoq/l?=
 =?us-ascii?Q?FP1ndq6Wh4MZu/FMcDsSNLg1cVv++/CeghF6E/ogrS1tRCIoxUVYktyOTHGX?=
 =?us-ascii?Q?sXzuXsx2mq+BGsoP0j6m4kH+rL2aGbEz1m/QsOzZymP95DrHtAkjUBauM8gn?=
 =?us-ascii?Q?aeTo13TpeoUPRT8+A+GpKZGDhIqmkjmJ/iyFVUISrad0esxk0yqDX1xvDpKm?=
 =?us-ascii?Q?uyLTf8/rbfgz/r4w1fF4PQoAMujQrMo5Wjdrfxu6gf89gfkk0Ug0EwvFaAhH?=
 =?us-ascii?Q?UC976cAHrU+NFNqpKNRNmh4IwpyWi0GGdn6CLE6sdGgAV/YsZSqYZqGZp8gM?=
 =?us-ascii?Q?yfef+Vs7Pkzlr4ApiQv66efUeB+GZxkJrQLk61sY5gvGptAHhvUFwqUMO9h6?=
 =?us-ascii?Q?5/TdEXra+d1izkIejpsgHld/O9bDHdu+YP/tD0P9CdohB2EdtNL9mDC0meU2?=
 =?us-ascii?Q?F+Xy09xJ234XU6VGYm6F+72CLWJUqW3jDjByI9NzLV4TpVGNCKRC9ZaLHqZb?=
 =?us-ascii?Q?10k5iLqMH7iPrD+WDqkZypVWsyHbND1XpIVUogwWN2GI/qHkBw6Ti67/ePc1?=
 =?us-ascii?Q?qsQUdCTwcmofwkeMawHJt40bmPTgGW2x0c/Zh/BphbeZTrFVs6hqifwBC6r2?=
 =?us-ascii?Q?d1etr0IfWIE/cfSLCtKfCjcC67UlJR6hFgTx19Xy1zoPi9mwSrjNBMIGe0J4?=
 =?us-ascii?Q?qrQgFRxLyFIAaYF/ninAq/fMqzjiznXrlC9dyI56+wySYKRHIyZ91mF6OWB7?=
 =?us-ascii?Q?sH1Wisu8b1aghGcV+luyfyRZzaVQXtWY7Ut5s272VG1CCYIzHx1kovG4o2Qd?=
 =?us-ascii?Q?j1H7QQdQ4Hgu0gLvXBZIdqxCntufwgUQqsAUR4eKBC5FpICTw/U7RSx/ncqe?=
 =?us-ascii?Q?Zcre0Yyn1W/s+2HP3IIVB7KjU/RA6/wAN/Aj8eWAHBXW2LJlUXeXLSzc2M22?=
 =?us-ascii?Q?GR3/lkHgEnTGyz38QGYSG0tVj1+HMxR7FaNw6xHpRiw+m9R1nfQOGgZVWaM5?=
 =?us-ascii?Q?qCD8UyoOB1ZkrW4yXsFUbqtx3j63uU1p8QBktPd5tXMzmK2hiGx7l4uGVqjp?=
 =?us-ascii?Q?MGKb81YsJAxA2ubb6OyMfMm4ITRqm4ND+M/ZpTpaMl2r81HAqJrSOc//sXmF?=
 =?us-ascii?Q?IEX9mpp2YhlHSk3zXAiT2aGJreolWdA5keB7WHmP+IjYJ2rBN5wPy9cJnZqE?=
 =?us-ascii?Q?S/LK2g1mK9dkQ7ZRgZzDdPhR71v/TCGRp2sEbLFnavjlKQQ7LQh/WN+SoIKI?=
 =?us-ascii?Q?EnVke6XyBwD80ey0SljbOCJodRDAbvJ42AEwehJ8zyK6BC9TiWdaSbHRYlOi?=
 =?us-ascii?Q?PkX9Ui5CTUQg/ihyJJh1+3ukKidSkddQXzSrpGi0aoKjsM2XFf2BKdx8YN1Q?=
 =?us-ascii?Q?hneBFYhZS/gPUC9RbzInF5UnlOieZrC3H4ygupQ2e7IlcHXGhrDfRm2xNKkK?=
 =?us-ascii?Q?ldVG93pJMG7itdxGK8cjpmsf4qi09yOPXgdsLprGkeQ/6ylQzu3ir0KlLnN2?=
 =?us-ascii?Q?lUSp5X5ftICrVtiH+LZpd4MW4Eza5CIdmgOcAXfI7Z2T7/Ca3WanzFubK4dg?=
 =?us-ascii?Q?YHAeu0dhW/h79+uh1Qq8fsVV6o8HjhOIXK0rC787?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ebccc6-7f0d-407f-b979-08da64948e04
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 05:57:22.6646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nggONn1vKx5y/VJmUiWdbtQg9RVNOeEgY810nnkTex5+UPhKNXRQ02Z8kFez3KhXmJkp2+c0GmejIhsIoR53fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
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

Hi Viresh,

> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Wednesday, July 13, 2022 1:27 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Huang, Ray <Ray.Huang@amd.com>; Sharma,
> Deepak <Deepak.Sharma@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>;
> Huang, Shimmer <Shimmer.Huang@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org; Rafael J. Wysocki
> <rafael@kernel.org>
> Subject: Re: [PATCH v3 04/13] cpufreq: amd-pstate: prefetch
> cppc_req_cached value in amd_pstate_cpu_init()
>=20
> [CAUTION: External Email]
>=20
> On 12-07-22, 11:40, Perry Yuan wrote:
> > This cppc_req_cached valued should be prefetched during
> > amd_pstate_cpu_init call period, then the amd_pstate_update() will get
> > correct cached value before updating the perf to change the cpu perf
> > level.
>=20
> You are doing more than this in the patch, either mention all the stuff w=
ith
> reasoning or split into two patches.

My mistakes, the patch adds the shared_mem check which is added by another =
patch which is in the coming EPP driver patch set.  I will add one more pat=
ch to introduce what shared_mem is used for in V4 later.=20

Thank you!

Perry.=20

>=20
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 43e6df9f67f6..e4904da54541 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -547,12 +547,17 @@ static int amd_pstate_cpu_init(struct
> cpufreq_policy *policy)
> >       cpudata->lowest_nonlinear_freq =3D lowest_nonlinear_freq;
> >
> >       policy->driver_data =3D cpudata;
> > +     if (!shared_mem) {
>=20
> This is a new change, which the commit log doesn't talk about.
>=20
> > +             ret =3D rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL,
> &value);
> > +             if (ret)
> > +                     return ret;
> > +             WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);
> >
> > -     ret =3D rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
> > -     if (ret)
> > -             return ret;
> > -     WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);
> > -
> > +             ret =3D rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &va=
lue);
> > +             if (ret)
> > +                     return ret;
> > +             WRITE_ONCE(cpudata->cppc_req_cached, value);
> > +     }
> >       amd_pstate_boost_init(cpudata);
> >
> >       return 0;
> > --
> > 2.25.1
>=20
> --
> viresh
