Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339FC57934A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 08:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiGSGdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 02:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiGSGdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:33:19 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394CA24BDF;
        Mon, 18 Jul 2022 23:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHLg+IxSQUuz5DiSWQY3s58WG4xD3pvUVYmL+zHGa9cMNJnvvnu4BKOd1M9ByDLui1pKfeiS8a08xSbyBlnFrnTCcOEsHZMVBRK/HC541SK9/uhOXnkBgG/SKiwQQ64C5ISzdJv63d60EkYDYZafv7Y9GFc2iQTYO0FVwbmi0RQMnQ5NCWF4JZ35sTMq5NZtqHvHblGKjcT6FUwzBnY3g5EAKPkWz+T2yM2r394MeHhI/ZH1NwghpofnTnvtp0PUnJF1f5euVxQjr945RtpZ+vVf2PBmRzT/O4e9Xv2vZdbRAugGE/cNxuou8GU6wcFxUDHnyUgO5FtP+gnIZyme2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mgCsFGONcTahynVzgoKnQg40isigDmrl5wbx8f+fpE=;
 b=WVjocp/zEzZ8VJQWQImCaoDLt0D0lajqfi+DfcEGK6NkjbC74w2wiS3V+qtCty7+bRET6FvS4aVy4Tjv0P7V6amfw5ocyrVQW1TDOyATSsLVmMkjt5rUiM9aMJ/FKGwdAAz/B9R0xu2m9IfNKXayU3H0VZC0od+kbMiOFZD9SBzIkmCiPw0lEFm5ELui5JKwYJJW4E41TsZeBzOigrS1ULeHPpDWASAaedqYYTvjrEQUsnX9yftkjSS+wkVxsAh+yjp4tSlZfE2a3GBU28a/U8aRdjr6AfcP3XnYkr5TSXbefWG9k3Ahi1lSsY7ZZNlGa9JifiBSbFCvTdwqVyK93w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mgCsFGONcTahynVzgoKnQg40isigDmrl5wbx8f+fpE=;
 b=KEY/v6kOVA+Lx4fH9TA+H5YEPHTRhc2UneplYhXUMr/GHxNxzObtf9i6A48tAOLibJl5Sw1cGXo2pxJfzIzWX3gtWHK/9M2dr15LsX6AmZhTLwzJhVzkZScWSPZFwJf5ifhmpLVKfgSJfPQx0Q5ZcbkGBB2V0HJheQ3KWxzhT2U=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 19 Jul
 2022 06:33:15 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a%9]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 06:33:15 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
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
Subject: RE: [PATCH v4 11/13] cpufreq: amd_pstate: update transition delay
 time to 1ms
Thread-Topic: [PATCH v4 11/13] cpufreq: amd_pstate: update transition delay
 time to 1ms
Thread-Index: AQHYmDJpZGi+UhNbxEi3+SVAF6gkDq2E5r2AgABbbAA=
Date:   Tue, 19 Jul 2022 06:33:15 +0000
Message-ID: <DM4PR12MB5278713C63EC077CACCFF7E69C8F9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
 <c1b46c68d521ff2c8ed49a6e8f5ad75ce51fb772.1657876961.git.Perry.Yuan@amd.com>
 <YtYDO+tXShYLKh2B@amd.com>
In-Reply-To: <YtYDO+tXShYLKh2B@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-19T06:33:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0e4bd59c-3cb5-46ac-948e-a20e655cda88;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-19T06:33:12Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 1ad0606b-a88a-4901-801d-fb098acfd2d2
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 864ce7db-6bf1-4275-d70a-08da69508fad
x-ms-traffictypediagnostic: DS7PR12MB6359:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JMcjLDm1DThx/YufN0oYR1zUbl4KRPenMWexsPoEhykFvFSFxtfoS4yS9IBoh1JThTLcOelzP+XGkbLwBjvGKzcnWr3881mHYeymLB6KXG7FoDxMRShUmxv2H1UmgDtjX6xZ9Cw/tQpxfdlM1mPNMU8Rng3jU+UKt/j0NeH+jCdCVpnXF7PThRk+/apOJuFNjustPfswffsV7KF9AU7jZ67So4x6jjAyjXLQ0QFo9zuV44havxkwEoilvFFDsTQw+zTkC7KEGH8eZHJ6kmYNi2GYYsqKpAoQ6Ez4BpKy3E8AwOllN227dmCfBGtkNXEYNFtiWw2Ww1bY2o1wqkylR01wL7cAgFc+Do06KlxxU+u/OEoxH7V6MuNFEgiqgd6uMfAID71sQLEfwJn+P+QEZIRLizQ4JXNrJksiIJV3b1DVgbQ9p8XPlKCJpfHOPp/uT2Dpe+o0eIXvLlJ4knhvrs78ofvEx2BayIrPVPjZPHqUiTRx492kpeBumJjKdorAcaMb+50Aq/qIOKf72tC04B/F8NAwJVsbyHr9ZITJsGcm2EnhM0zaRAPtg5ltZGa+X6klCuli11Me+IcnpzX70srhnmyKFS0C+8IduZ8DkdrX9Eog98iFfIyHHJY0RmycSGiuQixt33LbPDeQZX8u0VIX0YYEVAxHvJ6Tm5zNKNjIIWco1sqeFcWw63W7HEuOhbKjEA9bSoRL0bDRtLELjkKsI/B1fKsqyjYcQakPvAt3uv+RwzxZbCukbx7dZw69TTUpxqzkNzMUdszvayKTyAyRWUjaN0qN5ou/PWvBCNE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(53546011)(316002)(478600001)(52536014)(54906003)(7696005)(66446008)(4326008)(122000001)(71200400001)(26005)(8936002)(86362001)(8676002)(38100700002)(64756008)(66946007)(76116006)(5660300002)(6636002)(41300700001)(2906002)(66476007)(6862004)(83380400001)(186003)(38070700005)(33656002)(6506007)(9686003)(55016003)(15650500001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J2OVCuLJnwnKfPj9+4753DsLb9BQlstHdDQ4k76iK5H66DMfm5bK/0L3yEWi?=
 =?us-ascii?Q?C//n0LRIGCUX7857Rj1t/k/xJRNsimUCvGFNdQC3qaYTU/B53Rj/rihvU14p?=
 =?us-ascii?Q?O2ivlIwjV6IcJxYqNiQWcKRoJAC8EVAgr5cMOm9LXqmT/a3v9OlfJNxnmReL?=
 =?us-ascii?Q?A4Q04a9SXThQm3iS/JCFpV/zUGoPr5xeFyClbYf84sllgqlVxfbyoHazKCsO?=
 =?us-ascii?Q?elOkeXhPsYSg8aC6skPTvNHmQoybqWQKHWLkaIcfDjPzQRq66E+zVYCh5HbZ?=
 =?us-ascii?Q?xCSHpCPtphPytFLjLCYCB3AcxZDnlaOlnp0G28lB4EDsDAEUoicqMKsJr6cE?=
 =?us-ascii?Q?TOVWkSoLMBHvMYqpD2j8ZC3HAIxQRKYoW7KIIYtTVnHlkPHKIYgAP8K5ExEC?=
 =?us-ascii?Q?7xTO0y8N/buL9eCw1131zDu909F6E6X2ilqjJ6HkemdbNhIcxPHm8t10aZE0?=
 =?us-ascii?Q?c1PsK/H6/RinX1PAViy2swTCBVYX3BlG7t9iDkEvEsCDCGVfuISUi/9hOxWM?=
 =?us-ascii?Q?miyHhdMO1TrMP8JOYY5dzPDb1hbr8wBWFRNo/9rHnHjlS1PtW1WSCWzXqQUn?=
 =?us-ascii?Q?nSK2xGnOCk5aGCzF71uuKPVSSeeJUrDGGMFXJ+aM2WqGGmD/I0Bmn1doB3e/?=
 =?us-ascii?Q?NWTK9VpOog1heHckq8U031B+Xz/FuHbjfFATqcm19j7uwN3Wv2hnF5NlntcT?=
 =?us-ascii?Q?fgDjPRVnYcV+7ib3uw86Y6Fw7900vJXQ0vmnd2vUHElNAxydyfMqikwNB+QK?=
 =?us-ascii?Q?+s/hMy+BociSDhZTb6x+4WoSsc/H+rZPQCwef4owUERWY/f2Tlycb/qksREv?=
 =?us-ascii?Q?+SZU/OXi/jzncSmKrqFRcFh7aI0FrhwPTj6rUJvn+lQCS8q09tyuWLHapxJa?=
 =?us-ascii?Q?9kG2tyv9q5zbqOkZPogyR/499nhwgOuMDQj7wlpzkrpetw6tt/0uto5sO3F6?=
 =?us-ascii?Q?q19WFkzuw+UzAJC6U5aWDIFSzMUgbyeWely6zi1ymjXLsBLJHB3zInrsziH+?=
 =?us-ascii?Q?votVe0YYQtretWqzur9YcThLjxhbkoGxMcoxM9w4HPtXwNtkHuGB5ItJg1Fq?=
 =?us-ascii?Q?S3NsZzI9GMe6hkSxTh255fgdoiwC/fMbKh2/b1AmQp5OmmrWLzCLzp0JlmU0?=
 =?us-ascii?Q?96VxaVCED3BXsX6whTRwKy8KggVx6d6mqyH7M1JOaxCgCgASHdzpR2Ixr2Ms?=
 =?us-ascii?Q?46K0P8W7uYBvMHmGjn6SohJoLfUn7Sc6TB5E9BA0gR6VfCKF/sn1AIPAMHgO?=
 =?us-ascii?Q?OZ7m0G2vCFVbDCg6XMFWm4vo7rvt6QRca5MbePLCXuAkG9l7H7SHvQT3tViY?=
 =?us-ascii?Q?5ohzFywCkw+F4A8/ZbtaQei1kaLK444wAX8c6CuA8KUlyhQEQ8ER0xvmWPE4?=
 =?us-ascii?Q?SNGRcXKI2ESJxVrx1i8WXztPoFXaBzped54jIgHgwLq2tI0B3/dv9/8YoKSL?=
 =?us-ascii?Q?FxhvSulaObTLbih8e2F7cdOSkWSWvMRkKlnF9AvaboLIRao8qwUPikQY4XLr?=
 =?us-ascii?Q?1/lEVkLtfRP8RERdvVaqgIK2J5Pm0B7wL9l2N6k0sDzFs27Cau+z2PLAcyk1?=
 =?us-ascii?Q?Mlhl0fd1EVTb9Wc/V+VWxNPLfVxC0Qn5+HUrBRYv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864ce7db-6bf1-4275-d70a-08da69508fad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 06:33:15.4556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSaMF/FF6vDcoboOz+GJWFd0bBngwKi/h8bvAuJaYh8qgwHrvGC5I2yUrv/ZnJL0RuluMC5Cy5NAVDqbYJNqXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Ray.=20

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Tuesday, July 19, 2022 9:05 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>;
> Huang, Shimmer <Shimmer.Huang@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v4 11/13] cpufreq: amd_pstate: update transition dela=
y
> time to 1ms
>=20
> On Fri, Jul 15, 2022 at 06:04:30PM +0800, Yuan, Perry wrote:
> > Update transition delay time to 1ms, in the AMD CPU autonomous mode
> > and non-autonomous mode, CPPC firmware will decide frequency at 1ms
> > timescale based on the workload utilization.
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > Signed-off-by: Su Jinzhou <Jinzhou.Su@amd.com>
>=20
> Please squeeze this patch into patch 9. I don't really want to separate t=
he
> transition marco update as two patches.
>=20
> Thanks,
> Ray

Will update this in V5.
Thanks.

Perry.

>=20
> > ---
> >  drivers/cpufreq/amd-pstate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 4f8600a36194..d3bc441b3923 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -42,7 +42,7 @@
> >  #include "amd-pstate-trace.h"
> >
> >  #define AMD_PSTATE_TRANSITION_LATENCY	20000
> > -#define AMD_PSTATE_TRANSITION_DELAY	500
> > +#define AMD_PSTATE_TRANSITION_DELAY	1000
> >
> >  /*
> >   * TODO: We need more time to fine tune processors with shared memory
> > solution
> > --
> > 2.32.0
> >
