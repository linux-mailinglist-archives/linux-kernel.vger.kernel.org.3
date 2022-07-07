Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3645696DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiGGAZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbiGGAZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:25:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834261EAE6;
        Wed,  6 Jul 2022 17:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8/i3XcBEidSpmVzRD3Nb81i4UrHstTdaCf0fLYuXxFznsaQGhwjd/N7O7tmNj0MWVJIOBYZkFNBNzy0EalnPmfniGi6q8bzg8E3+vVQe1QoonQtndf6p0WsEA46MFjaZiqOYlKWm2Tr63qMJT4cMdYc1fD+6RMyOEaYAJrxFvYBTnjkvo9iSe/1SemA4TuDHqo+6ADvQZa7cvj7knVPBSD95ZiM2B+AxYbPsksVdWGzScZO1dMWZGVdd9dNKewRYe1NS9qtZDzt+A7yOY3xuQysHvoKNUIR7Noeh6+XQVeTLr/eHxiC11Wefg+AELkNOXQodyi7gFEl+PGGmolOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wyqyh0DndB//clh+s1DG0SXDBtfLvAjjuhYDqjo1OFQ=;
 b=FoIraeudt3FGMgWL0Y0Bt1jARvml2kv/8XfJvIY/fbGLAsRTnPqVquSxlIaN82dbEWsN2HNqv23lIz8TV7xKtxJgTI8FxxnuYD8SSr2xQVJSSYt1LAfsFPTlfi4wO84bUDGUqoCICjxXehWiXZVPcyLkTFXewrlg1Xe648501CPU3gulYKLg1dYRlWxlS8orCIX8U7H3D7NNpf8g5MbTq3IfjwXMeSqkg6KN3Lem78PrU83KZbxRivRwsEADXEb8m/TTvY63i7SOTFaZlPbp0kkFGHi/BE8o+Gxqe/foWbV3IQgIQxsvaHgAFTMVRV2CETITyCYRG3J5h0kdMYdK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wyqyh0DndB//clh+s1DG0SXDBtfLvAjjuhYDqjo1OFQ=;
 b=kgWPCqDvfiCN2ZQ6xowskIP98utKmDbmGnxJkxpMRkUbq42wbJBLZmepyc0GLtE6SFCToe2QcBV/GsO6Kzre1tzixISwGYHb2ITRs1x4HNs77hXQmYFyaZqXAq1N1om9wN9S2Y1/H5OnqAwJhExkwgVxdRc3Xq7Ag1n/EFdJVofeoI8L5BunCYg9DWvJhX7ElpZ6vwKUp8IuovY4/OAeC5qR9wVhs1jQlYv8DJRgEzYVe3/7kCKt7ktO3hZaq6KXDkYwOe9jNAo2Y9izsdJEouDZ+G0DiayiBG6Fd/mdrqN5zs8CRP/aBxxyz0Bov4jsG0aBDKMXI2/5XLE7GMl7ig==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Thu, 7 Jul
 2022 00:25:45 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::bd95:705e:9479:d8a]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::bd95:705e:9479:d8a%5]) with mapi id 15.20.5395.020; Thu, 7 Jul 2022
 00:25:45 +0000
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
Subject: RE: [RESEND PATCH v3 1/2] perf: coresight_pmu: Add support for ARM
 CoreSight PMU driver
Thread-Topic: [RESEND PATCH v3 1/2] perf: coresight_pmu: Add support for ARM
 CoreSight PMU driver
Thread-Index: AQHYhTLreZhiUX+onkijjgrrTcbLR61jGS4AgA8LzXA=
Date:   Thu, 7 Jul 2022 00:25:45 +0000
Message-ID: <SJ0PR12MB56769B3B6A23A49F131E4CADA0839@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220621055035.31766-1-bwicaksono@nvidia.com>
 <20220621055035.31766-2-bwicaksono@nvidia.com>
 <20220627103642.GB22095@willie-the-truck>
In-Reply-To: <20220627103642.GB22095@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27e3b532-a1c2-4b75-da5f-08da5faf3bd6
x-ms-traffictypediagnostic: BL3PR12MB6476:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: glpFo22S781XOg494kNbAxyemMRlB/oHqdngcL6tbFaFm4WlpibmycH8Ird22LOThOUaAMzqoI1PVnfOK1Fj9DUjMjhHTIuffWqlmha/ympCdou7xM3UV2pDJrMuSaD0TvPAewC5hxzWNuIVSe4ArnomCuZfsq41wL0AFxSyLC2fh7xH4A8CIZmwFpKBRGywBJNGCOP7j7m8GAEXwQnZzQCdzn9NqNQBePQ57errr7NmkWwipPw+gNDNroaDf19pXHxuY2aD5UqRiK8F1tQpVOTxzzz830gE/YDiEIhZMUPz09+IPGWpO1n5EmcAG4m1llq/AgTufOjpz2Q7bw7E1fhRplPJAlH/BUcQSpxCF6CCeT5uztLe+UxzccFbrZdC3hdVudcndyWnVGj0Kl4fUfMG3H4LocmhMoASyfoQUw0ezXnWX8KbPaCxMjCqZfBMAMeJl1442HHFbB1QrNG4WGzTVSCdq7yhnSni9DywcFa9rd5ssfRc4T97EJcSNTxDo7LrAqcR9oaCBI8Jyjbi1bi/XCaXv0KQE5s33ZAwu1nXVzYe/Cze1TnMmwDzVS3VcUN4zbtZilizKGgmGdymvvpsHBYVA8raok9HYBhLc779W8UCnbiD/8E1VsLBEFZkLX1tqsAhZV1vB4QGhYQCiEpCImv941qXxYa5YLoYPLAqyOysXKJ96kBoyMOX3l2W9vem2WJAuk2TzyazJffNhZA4/PFj3/wDZO93WuknQhGRxy3i4TgYTP9P91RqwMxxZgsLdJ8kKosrKzM2R8hTm1nJRSt3VpXaA0q1vBtvjzJGFTx9NFz3ctqwoZXyJhbpFXLAmX8YyLU5x1r2BMdHsomrAQreHOIx+DjolX9mCZ24g0q1t+Pz3Er3VSS4m2d/BiQH+ycTX6ck+8YBxmDl0GgnFOX4zmVXaMWOWj/PnNeghAwafBMYyeVQ9b9xpL9o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(71200400001)(9686003)(26005)(2906002)(66446008)(6506007)(478600001)(4326008)(38070700005)(8676002)(55016003)(86362001)(7696005)(41300700001)(64756008)(53546011)(122000001)(966005)(33656002)(83380400001)(52536014)(186003)(54906003)(5660300002)(316002)(66476007)(6916009)(66556008)(7416002)(76116006)(8936002)(38100700002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?22Z39URWSqHikOIjhiYxM0AYTDCYXxBxlqHUBycy4AeSAE+nlZtb1fjtlgtN?=
 =?us-ascii?Q?gxmGzYaKff0MKRNP/eNOjt7sp+YUa6wf7fnSXHAX8R1UsUkeirdi419vFYqI?=
 =?us-ascii?Q?wlrbcSiLmqanMB//S04K5zzCzQe/ZltWCY00W5Mlo2h5B66zN09tRb7nloMN?=
 =?us-ascii?Q?OZJIsErvxagyHl3rG5PtJB7USRfiIo+IJ+ExaDcBKv/7ELxVLG4YLOQrIkQj?=
 =?us-ascii?Q?U5XB8G5Uo0hdvDVE2ldivooR56dlj8uo9DZxeisSCS0AZ2LU59c23vURESN0?=
 =?us-ascii?Q?muNl25HkD4ry97d4za+eZsCUV0fJpXx4Pfo/aoP0caC9YlhelnXf0g1kH5TA?=
 =?us-ascii?Q?IlzSJW7b0koJhAGpEVoBt/JhtLyarXdZDQs9QIrA7vSzOjhpg7JhuvyYk99G?=
 =?us-ascii?Q?NtNWJunzRgnXXeQFKb6I9XYiWYqZQTE4o26jyNyli2yMQyjtBKmtdrBmaMRD?=
 =?us-ascii?Q?n/Ab16xntL+2GjEIzbCWAhig5ItspyNHQwEMd2Z9vne08FP2cSs1vvmUAG0d?=
 =?us-ascii?Q?SwYQp1dGKb/Xh/oA0vYIqsIG1L6KEPdcBVm+yqpbtjt0YxYfzRpY3U5wWnE9?=
 =?us-ascii?Q?TmJLKNTpwyY9sTbgumKcp9RkdDfGGG/Efd6WoEWFLqZxFlpP9QOmjlhAbi1S?=
 =?us-ascii?Q?F4Nv3ewaeeGKczUMyFfdBYdUyXL9t6+P3KQwFe9NVogHw6yt02VSleXGpKE8?=
 =?us-ascii?Q?znlfa0+wx5D/1sfVctipcQx6ekj9w2TZlg2RL1V6+44xqLsuE/Aseh7GEST9?=
 =?us-ascii?Q?gXMMQiI34AOGEMfT1hTM4QznOCyjTzsxHel4TtIo0awxQfzD76NTh7+6tjGN?=
 =?us-ascii?Q?TGoSy/S0exaWUHy9TEXCSzWEBOSuPvhGlN4ahO0S2Qe/PhHDnD3qdI6dVlce?=
 =?us-ascii?Q?YOIJfJphhh38u1Dm0zrplrHgWdroJrzVvH2r8CEwy7kAo47p8oIaiafUTIw0?=
 =?us-ascii?Q?lbsNnEiOSgUsvbRNc5JjM63hzHsecu0Go/tOCK41H2olXv/ckt3l7uVX/cWi?=
 =?us-ascii?Q?NXr5/HS7KfyvNM2aHT6VUOMP7aFWxNx4d9K2bC27+Sy81c0Nj1WIguqqoruH?=
 =?us-ascii?Q?jXbnUQVXmV4+5KKjSqRngpe2SBT+dY7vRTkE8muLAgbmn/V8ybgKor3Kg2bg?=
 =?us-ascii?Q?Ti7WAw95WH6VrB0NbdqvP1UvGSSxt+4uFmmGwPV5TqHA5mXQz1po4N734YZh?=
 =?us-ascii?Q?7oqyXLGDy7CqhwNNQSw6vBkPwxcvFzCzIUKn87XMm1TRO3eTC92w+XXyDfYL?=
 =?us-ascii?Q?6/eAFVly3NUdHU7FB7fAXW2//EH+E1cL9FO54s1JRxIivltEmMRe5lfpMC1b?=
 =?us-ascii?Q?QhIn1ZCvTiPln8/qzaI96u8vEIzqL/SrxYPkUoR1Chv4hhIrZpvhiYbY6Ifi?=
 =?us-ascii?Q?dcSQYjjht8sGCEUmykzaOCLWrg1e2v2S9wmo8exK5twKWEIrq/VHbe4tluv4?=
 =?us-ascii?Q?jZEk0iYLdt+vSSJcgpoO8zhWjL0iDe3WB8EMgHDFIFG3R3Sk7hlEZ3W0iZj6?=
 =?us-ascii?Q?RhdXgANAmJxI5MmMbzeC1SQFnM6kR/LX9tLXdjv4zogoEydakjeP0dvciaNu?=
 =?us-ascii?Q?PhpLLJ0UIYcYUHsJD5UJ3UWWxjockZ+kPvoG08U6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e3b532-a1c2-4b75-da5f-08da5faf3bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 00:25:45.4041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trVIQjXso9SPjqIust8NGbz6HB8O3gSjk95NauvG8U1q7Da1xdDfBbGJqmtZGY35CAjtzjxJR/fmAftH6ZJ6Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476
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
> Sent: Monday, June 27, 2022 5:37 PM
> To: Besar Wicaksono <bwicaksono@nvidia.com>
> Cc: suzuki.poulose@arm.com; robin.murphy@arm.com;
> catalin.marinas@arm.com; mark.rutland@arm.com; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> tegra@vger.kernel.org; sudeep.holla@arm.com;
> thanu.rangarajan@arm.com; Michael.Williams@arm.com; Thierry Reding
> <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Vikram
> Sethi <vsethi@nvidia.com>; mathieu.poirier@linaro.org;
> mike.leach@linaro.org; leo.yan@linaro.org
> Subject: Re: [RESEND PATCH v3 1/2] perf: coresight_pmu: Add support for
> ARM CoreSight PMU driver
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, Jun 21, 2022 at 12:50:34AM -0500, Besar Wicaksono wrote:
> > Add support for ARM CoreSight PMU driver framework and interfaces.
> > The driver provides generic implementation to operate uncore PMU based
> > on ARM CoreSight PMU architecture. The driver also provides interface
> > to get vendor/implementation specific information, for example event
> > attributes and formating.
> >
> > The specification used in this implementation can be found below:
> >  * ACPI Arm Performance Monitoring Unit table:
> >         https://developer.arm.com/documentation/den0117/latest
> >  * ARM Coresight PMU architecture:
> >         https://developer.arm.com/documentation/ihi0091/latest
> >
> > Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> > ---
> >  arch/arm64/configs/defconfig                  |    1 +
> >  drivers/perf/Kconfig                          |    2 +
> >  drivers/perf/Makefile                         |    1 +
> >  drivers/perf/coresight_pmu/Kconfig            |   11 +
> >  drivers/perf/coresight_pmu/Makefile           |    6 +
> >  .../perf/coresight_pmu/arm_coresight_pmu.c    | 1312
> +++++++++++++++++
> >  .../perf/coresight_pmu/arm_coresight_pmu.h    |  177 +++
> >  7 files changed, 1510 insertions(+)
> >  create mode 100644 drivers/perf/coresight_pmu/Kconfig
> >  create mode 100644 drivers/perf/coresight_pmu/Makefile
> >  create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.c
> >  create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.h
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index 7d1105343bc2..22184f8883da 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -1212,6 +1212,7 @@ CONFIG_PHY_UNIPHIER_USB3=3Dy
> >  CONFIG_PHY_TEGRA_XUSB=3Dy
> >  CONFIG_PHY_AM654_SERDES=3Dm
> >  CONFIG_PHY_J721E_WIZ=3Dm
> > +CONFIG_ARM_CORESIGHT_PMU=3Dy
> >  CONFIG_ARM_SMMU_V3_PMU=3Dm
> >  CONFIG_FSL_IMX8_DDR_PMU=3Dm
> >  CONFIG_QCOM_L2_PMU=3Dy
> > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > index 1e2d69453771..c4e7cd5b4162 100644
> > --- a/drivers/perf/Kconfig
> > +++ b/drivers/perf/Kconfig
> > @@ -192,4 +192,6 @@ config MARVELL_CN10K_DDR_PMU
> >         Enable perf support for Marvell DDR Performance monitoring
> >         event on CN10K platform.
> >
> > +source "drivers/perf/coresight_pmu/Kconfig"
> > +
> >  endmenu
> > diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> > index 57a279c61df5..4126a04b5583 100644
> > --- a/drivers/perf/Makefile
> > +++ b/drivers/perf/Makefile
> > @@ -20,3 +20,4 @@ obj-$(CONFIG_ARM_DMC620_PMU) +=3D
> arm_dmc620_pmu.o
> >  obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) +=3D
> marvell_cn10k_tad_pmu.o
> >  obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) +=3D
> marvell_cn10k_ddr_pmu.o
> >  obj-$(CONFIG_APPLE_M1_CPU_PMU) +=3D apple_m1_cpu_pmu.o
> > +obj-$(CONFIG_ARM_CORESIGHT_PMU) +=3D coresight_pmu/
> > diff --git a/drivers/perf/coresight_pmu/Kconfig
> b/drivers/perf/coresight_pmu/Kconfig
> > new file mode 100644
> > index 000000000000..89174f54c7be
> > --- /dev/null
> > +++ b/drivers/perf/coresight_pmu/Kconfig
> > @@ -0,0 +1,11 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> > +
> > +config ARM_CORESIGHT_PMU
> > +     tristate "ARM Coresight PMU"
> > +     depends on ACPI
> > +     depends on ACPI_APMT || COMPILE_TEST
>=20
> ACPI_APMT doesn't exist in my tree. What's missing here?
>=20
> Will

It is missing the APMT support patch in: https://lkml.org/lkml/2022/4/19/13=
95
I will add this reference to the driver patch cover letter.

Regards.
Besar
