Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B7A5696F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiGGAkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiGGAk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:40:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EAB2B27A;
        Wed,  6 Jul 2022 17:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgqCRDUl6kuZM1ebZTssXYYUtQpk2fUij4021plkk2K0Ek+BMZ9ixhXMM5zlQDDnqVcsLwlBxh7HWAVsAHIoBZcOiJTyTKOwqm+3m5bpOWyVt9LJvOc53zpsCDpohbhPFPyAUJKN7B6aYDwzWIeeEGU7MKV33Fb+EnmPbwAVc+7gIYuddAbjc/JripbbJkI8+6/X0dS+I+bivXBWqTYXhnDk3qnJn8DuMbPn3WZmRILyLFjJsZSZpPRJzAoF/gJrXz9ZO9b8ISiwfySKl6+za2OvEI5snHZp9rDCOCZPBSh1ZV4NYU0MEaj7B8l0tgGiTgsSdWRKVnnbfX5WrRqX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/sm1mdL3GoaBITTkA2Zd6dcvS/Kmk4vivcnXkT7MAg=;
 b=JNKRvq74LhCn3L6wDeSJtusFH7FTE5069kXcb2xe3tjl3nyPHwo+pi6+BAjdaBj3i+TrROsTbu2gGLs+DYuBkIuK8vObYE723Z5PM1rbK5MOA5qf64kYU+PgYRyagtLGO/29mH/0Lq0ZLBgsYB57va99ChSxC/3aUbn1QYNmxoj7yDs2v0ANwm6PNJhKeIb8acUxrq/quWcRm0bRmEVvxkJq6mdEkw+wsGG8Z46cjHtrj0ERhi97a9IpedU8XknYZVf0oN0Xd0KeaxEiwzKJbn66hutpqvOg/cBIIesIsYHoMXXTpi6YBYkr6fEWhH5GYUELoU1Y2ejGQoy3PHK4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/sm1mdL3GoaBITTkA2Zd6dcvS/Kmk4vivcnXkT7MAg=;
 b=coM2DCctwYOHM4FIrnJDhiokf6Ss69AvzFx8YKedfiYWAwkN9laTilgYDfjeecHdAKUTgfxmGxRgzYU3BqH0QBpK5yFewNwhPBG2F94HhpvkDQESErZ9p3QomE45KaCja06Gb7r88UP5Q1QlHtvjPmKY+FNV/+a7HwfwyyZl9fqyKGNz/17i6pvlPwlpdLKbyJSheFSY6TU71ROiMXl82f80gCTf2/kEVXpQhKC4cgpfbMi6p/cvDH2+IGjegQv6y2yav09peGQXwraPbECPWpZ6Iu7205QLPqyUWDSmenzbfVoHaDh3XQ9Jf9kfGDJCIMy5N/61LZAiAejVFmtCkw==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by DM4PR12MB5891.namprd12.prod.outlook.com (2603:10b6:8:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Thu, 7 Jul
 2022 00:40:26 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::bd95:705e:9479:d8a]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::bd95:705e:9479:d8a%5]) with mapi id 15.20.5395.020; Thu, 7 Jul 2022
 00:40:26 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Will Deacon <will@kernel.org>
CC:     "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
Subject: RE: [RESEND PATCH v3 2/2] perf: coresight_pmu: Add support for NVIDIA
 SCF and MCF attribute
Thread-Topic: [RESEND PATCH v3 2/2] perf: coresight_pmu: Add support for
 NVIDIA SCF and MCF attribute
Thread-Index: AQHYhTLxxcyEPgAfs02S9hth/BTYH61jGWoAgA8O27A=
Date:   Thu, 7 Jul 2022 00:40:26 +0000
Message-ID: <SJ0PR12MB5676D57F1E19A51435CAF875A0839@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220621055035.31766-1-bwicaksono@nvidia.com>
 <20220621055035.31766-3-bwicaksono@nvidia.com>
 <20220627103731.GC22095@willie-the-truck>
In-Reply-To: <20220627103731.GC22095@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cf9adb4-051f-4532-dc5a-08da5fb14907
x-ms-traffictypediagnostic: DM4PR12MB5891:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PYeACKV3LBoCaZ9Ztf04ztbh/1OHk2z5AGRjF59rvzXVpSkPXkl+eKFvjSyCU3urTktgCnNy0EQG1YOlhRHPV5udG1CiuAeyRsJvh53rGnKF2Y9CySDfpPvupk2+1ojigjJaZEDS9XRnCrwPuWqxLrqz009DTTFlvMfeRkyLk3fCP8ZOtNGWdN+De3Oi3zgXGqblsI69/8tyh61UzaZEhhZmYH3XcolMGGZYsXxgjIDIP8iLcgcoL9a/Gqaw0mcbts/l4w7Bp4LZ6eYeMxbWHmBiG3AjR7V7f8IjJgJpUsyYiN1BsMHSyEa0O2GtyPCZ6IOljLJ9glMWZqnvfjcGietumulcgtD9CY3fUtx6Zk0+MZQ7RemfY5UtkO2yhwSmAT5ylS7JsoQf5qfKpw+SYOaaBMTUjxCRdjau3oPBjeiI0c8mW1QCirt6ORtqvtiXeGBllVGuqUdPkBSF98HT+Vx2A9TWTOMk9Y5mSu85sbMKCrau2U7uyQsunukY6JataEUC7cHYIYi7vmxFqeJ/8VnwVH6Ul4InPtHfa32X21vzfHhRTByi0pum4o+kLgiJQMWe7QH9oCD/qmoxhljVFlK199njR1/fYpQoJ0uwTup19rEZL3kRwC04YanZJ1PtUI9HgDoMoCVBVejLfYfuwl70s6xI55ddOsFQ1AILu8P2Bd7HK60DTHR+47p4LSDOqlwj0wMVtrZcd84vVN7RMMZ7KoMeR57r5mTz+rv9A6gVeq1tnfWxxzPg/ES8+G+wuxeAlEHynt6ZLAQOPMr9opgNnbZLd08MSgFaAlvwBgM6TFH8k5//IyfpgQrybgkB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(7696005)(26005)(6506007)(9686003)(71200400001)(38070700005)(186003)(83380400001)(122000001)(55016003)(33656002)(53546011)(2906002)(38100700002)(64756008)(478600001)(66556008)(316002)(5660300002)(86362001)(41300700001)(8936002)(7416002)(52536014)(6916009)(66446008)(4326008)(54906003)(76116006)(66476007)(8676002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5/Tiea2eSwtFiyxcJt2Oi2GdNVYwvVQ/qqKGnX85mnM/zCiy9g7Evdhit176?=
 =?us-ascii?Q?3iXAImVt6UqNZJ+KE5QM48B8BgS866O4XMkYW6FTcFf1vXQ59mC9oa8/DzKQ?=
 =?us-ascii?Q?z42Ecax+0DrbsKEdGDIdufwG0cc6xgRJCrz9LHY0mrn+xeA2cjiUO8iB84EQ?=
 =?us-ascii?Q?X6TDDY9GWTcRx6kNsDCFloUq4A42xmgRbWwHHwgOJqz4lmcu/iIb10FOm4D2?=
 =?us-ascii?Q?nfzHjvEmvOrI2FawWZ3npVPGCD49TD6POChH43vU4o9/qGi8It7cpk677ily?=
 =?us-ascii?Q?hcPSiECH1Ye6yftdr+J8gMBeNk9WVYqcvc/MUaqoUO620yVMbaIMfM3KY2hC?=
 =?us-ascii?Q?njyVZw/6BWjnMqYAMLtFAFB543BHTg1+qeWrU2qbtyHTwqe8RntVmzJU5tQP?=
 =?us-ascii?Q?YpDxEmxpPru3mzozEwkzDDU+c4r6NP/BUBvB4W4wBLGPOdZBNF+bVa8dGISm?=
 =?us-ascii?Q?5JMAOnl3vlFJ1EJxxm/XQNZmPcy+jlMb6MBpZihZbYPQZGMAgNZXuA1VPlOu?=
 =?us-ascii?Q?FgBDuoEEEMAci7i1mCSlFkxSJG5k3swEtj2eLExMB0Q/K2izp/VNLUUhcWwv?=
 =?us-ascii?Q?NCnIDuuIB66UWpEFzxDzpjKzmmkk+dar3P+GHcofkOyzi0FVDubdJv+BZQKZ?=
 =?us-ascii?Q?hsu+H3ikcYqFizb1UCz/ezRNVjeeGBSKAg5URKBjZUaq7R3p2JpwkDeu3a4S?=
 =?us-ascii?Q?+CQhpGNdXLLyfqhlfVwlF0+HhE/xsikkQIJdyb5Fg+UrTwzanaPtUknNtK7F?=
 =?us-ascii?Q?wOtSHAK00mtvZT84was3chHMrLHkaArx/2p/SyBPPY5UNOg97/+QmHWIao+4?=
 =?us-ascii?Q?4mNcVow1AfkDrboaXGcq8s5KItlSf9eEmXnGSxgYiNJcGnjZ2VDaZazC5xNo?=
 =?us-ascii?Q?biMkXFHPM0RfYKpi5YkX+HDl9sddAyWY8UJigG21rao/f+IjqAe7w1aNuLJn?=
 =?us-ascii?Q?4gc118GkRUG9jCnD8PVW3jFbDA1pb7CT8WySMMnj/YudSsk8wmIzsJD23fDN?=
 =?us-ascii?Q?4zn7ysicImqaD87RciUhsPJeXOtssC1msaZKNZdt0ax0dvo7gapz8XWdPESR?=
 =?us-ascii?Q?4rVFfnQ0dpC4LAcSLcA7fFvDTOMhfmeytwFu7/X4dL9g057jfc+b85uBGwUj?=
 =?us-ascii?Q?cXgM3Swyhe4i//zYOu2Up8pSZ75izqgKz/MappIrNOH1yQTS3S+xWWfEU5mu?=
 =?us-ascii?Q?2BdZlTTgRxPtqIJEIgDOEVolluchJneenAiNxiGL3jHAFbjCduX+C6r5IQiX?=
 =?us-ascii?Q?c7gONR6X8mNgbX7lj+gPzI69FvLr1Mc/CHXW/rSriZ6GQWfYKgnyUJGREP9Q?=
 =?us-ascii?Q?QPQ0QfzWWKulFdQjNZvhsO1hy4Dp4nB1lwP6xZ0E27yR1W8RKgeeKYw9FfqH?=
 =?us-ascii?Q?6Xqm58sxCGZnKU4bjxk6/Kwy2ZVBHYeLv4jC5e1bwg+STbNrLtDFnGqYtZIN?=
 =?us-ascii?Q?4pZ3kHLSCnZzGtrngHbKXRma30NA3Sok4Nn9l6rTP68o2QbaJ3t8n6swZjON?=
 =?us-ascii?Q?56w1bN3yYLQnFReS1BOof+1DDqrdhMDq6h1KG2hkysbsbBiA5PYXiW8TDw+o?=
 =?us-ascii?Q?4acxqiijrGLT/4byjqVNUWmKokJ+omWrARxlMa8n?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf9adb4-051f-4532-dc5a-08da5fb14907
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 00:40:26.4823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6aQNVrsaYdMxpJedjfI0g+8SKb5kHYdnwia9EE3dWpJdJmliL5NQI5ta9rVxdhDl2xHwNKlO04DJPv866t7STw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5891
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Will Deacon <will@kernel.org>
> Sent: Monday, June 27, 2022 5:38 PM
> To: Besar Wicaksono <bwicaksono@nvidia.com>
> Cc: suzuki.poulose@arm.com; robin.murphy@arm.com;
> catalin.marinas@arm.com; mark.rutland@arm.com; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> tegra@vger.kernel.org; sudeep.holla@arm.com;
> thanu.rangarajan@arm.com; Michael.Williams@arm.com; Thierry Reding
> <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Vikram
> Sethi <vsethi@nvidia.com>; mathieu.poirier@linaro.org;
> mike.leach@linaro.org; leo.yan@linaro.org
> Subject: Re: [RESEND PATCH v3 2/2] perf: coresight_pmu: Add support for
> NVIDIA SCF and MCF attribute
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, Jun 21, 2022 at 12:50:35AM -0500, Besar Wicaksono wrote:
> > Add support for NVIDIA System Cache Fabric (SCF) and Memory Control
> > Fabric (MCF) PMU attributes for CoreSight PMU implementation in
> > NVIDIA devices.
> >
> > Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> > ---
> >  drivers/perf/coresight_pmu/Makefile           |   3 +-
> >  .../perf/coresight_pmu/arm_coresight_pmu.c    |   4 +
> >  .../coresight_pmu/arm_coresight_pmu_nvidia.c  | 312
> ++++++++++++++++++
> >  .../coresight_pmu/arm_coresight_pmu_nvidia.h  |  17 +
> >  4 files changed, 335 insertions(+), 1 deletion(-)
> >  create mode 100644
> drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c
> >  create mode 100644
> drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.h
>=20
> Please can you include some documentation along with this driver? See
> Documentation/admin-guide/perf/ for examples of other PMUs.
>=20
> Will

Thank you for the pointer.
I will include the documentation in the next revision.

Regards,
Besar
