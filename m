Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1490659EBAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiHWS7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiHWS6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:58:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E20BA9DE;
        Tue, 23 Aug 2022 10:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjGLEqPnSojNo96wHoD5pggw2j1XTOhkUcVac0HBnGya9KSuGvsJKiGv7lupl0NdQvyW6OJkevYZKohrhutmASdXkgHQ0SIr1gWSy1MgMSMPq4JCFjQ1G+1QRCLPjNNytDSknjXJ1Qu1RFeI8jcKK8M+HHyOMBuFuZ/lrJC6Gw1u+sepQ8CL0hd9GcZwliSvTHtWanb0c2rguCJrM/c1+wAzE1KttVR09dxFdn5n4uYPnbD4AO0XyqyEDoSeNRWth5C2ZPnfAKRF+nZ9uMqT8k8FzBOF+iXvDQYExPNdbKFw/VIxLBqUF9cKcwkZg/SfjwUauDbrqHH0HJvsq0q1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reEzUAvxKW2dedMSlSp1am/YouTwKz5Fqt/XuD2ybMs=;
 b=CoX56xq4rOxJgnyUE5l2EIz4e7jfdQMgamNTkRBoLOUDOnYNSjDIyVDeRn0eIfG9k2xrZcpLgB5KCUBOxffjyBWZWDSynJ2N9uacNrnpEeE75c8ruFp+J3wSbnHU3w81mZwiniz+mAeRiK2bmDpuLgTx+E2nBx78Hc7qPkn+CuXZcsyO6AHr9fJos6k1uLyUf5oaMnuQ8y41ChEG90PpocpABFKg7dgJi2Chnt+zVANIR4qSKEqOGcxiud5C5Sj9NY7l1Fm3Svg9dY3+6OsqQMaohWFTTdfZMCZuZrgWYTjyXLlSYQce2uNvAVDWBj4+JQ65xuwFBgQMe8NndqNnrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reEzUAvxKW2dedMSlSp1am/YouTwKz5Fqt/XuD2ybMs=;
 b=a6CmAxXmUrmIQx6UbAzTMxQp3/gBkzZWnSPLBQyARWPbadTr44WCpjYjrYxeUQDnGlK8lg0DUcRIgqn6lPemiLTqdiNNJISWqjfESYEhwewLhMyZI/oKfnBjkLoXN4tG33cNeLtY3Jj+9+nDUJviW0ePaIQGyFyrr/UkFA99/xjXn46K5SH6ACxVPOI503ZSyTXLrX04W8aeaDdK0/upw3CIg5fvasRJD7RZvrKO82JbSQGzXDJlPUltbT/bOfshh3fLy4QMb93fKKd+hculoshul43JNuNF10J41r92wWGZfHI1g4lKMGRSwzmfvWOlYRaSKSbBwbeBUuHUGy0dPw==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by BYAPR12MB2933.namprd12.prod.outlook.com (2603:10b6:a03:138::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 17:24:05 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::585e:ba1d:bc54:151f]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::585e:ba1d:bc54:151f%8]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 17:24:05 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
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
Subject: RE: [PATCH v4 0/2] perf: ARM CoreSight PMU support
Thread-Topic: [PATCH v4 0/2] perf: ARM CoreSight PMU support
Thread-Index: AQHYsAsS7aw9KtJxAU6pglFZg7L5Cq28xZoQ
Date:   Tue, 23 Aug 2022 17:24:05 +0000
Message-ID: <SJ0PR12MB5676C20F2083A73FBA973292A0709@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220814182351.8861-1-bwicaksono@nvidia.com>
In-Reply-To: <20220814182351.8861-1-bwicaksono@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cbdf542-9fec-4a8a-aca9-08da852c47b3
x-ms-traffictypediagnostic: BYAPR12MB2933:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NO0y2SZfGsCTnScBfIrtzHjIubB+oONuMzBOR/lr8GnNuQaZMS3pjcgsqy1tXiksGzncL2hFRjuerdKVON/KxhE/s4/x9IIEDGc+kgNuy2Y3/ZC5j1VZ0KMQZMEjw3llPM+zViXcv0BeNOAmbicKqPGigX9DwJJfV5ojLmY0So5OQRcVnIfWQo0LP5B6ybL4Xcv2l0iu+cbxAbOmRN9olw75zM0+SNA/DdwuBupxwP2S2lxjPyEgpVCCHIQMBxanCYu7Y9XdhXLOKAJsV6KZ8qRneCwAAr9aMEua2var2a2myNMlhlufcH56PhSIcpMi2ZFK0TrtC3GTNoP1xOahPhcv4vcnuqII4LwHPmjbd3pvNVYJssu+oDM2oUhj4WMIT4Eb1nby1pJZQGpthqulYgDZcaODEY7CMwa8TMj2XWwhF2IiUqjGzLtOKd05rw/tL6g38+DDDnbimksH+DH9q8nMBN4wmJfQrfypfXQLlW41oG6mO1n0KyTTNRh8WSY5tnSNFsrw/6coED/MdhH8S4zVPn+O71QouFOCtPm1OWBuffjXokF79JIY+Ik627gK5PAVGIv++cq49amM8bDldiA5CFWQhgLEhj3fHchF83dwcvHwqRxXq3V3Q9hlE/VCeVVS9uK7vVdRI6oC6jt+3vSde/mkD3+iNa6PpVe/J8IHuwnZHaZV/7le78k5fLyrGoqL9lGxpzwAs15kuiLvSY3dl4NafONyOWGDC0DbROkGrIqMhcCvlaYnrVSdOHdYoLRHPDYa07Qsx61VXXe3KeVgEwL2sDQ43bWEP6Aw1pZ2sp9oAhZqc5BrL3PXkkg1unuxVzNm6HM3UkX9NJELClN9UiUH0WRkq5Sfq2JXqBefqyMgzMIf0tnGL+H3IJYc0hDx6KBDdmX5eFzsGXedAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(86362001)(186003)(83380400001)(38100700002)(38070700005)(122000001)(66446008)(76116006)(66946007)(66556008)(66476007)(64756008)(8676002)(7416002)(316002)(2906002)(33656002)(8936002)(52536014)(5660300002)(54906003)(478600001)(41300700001)(55016003)(53546011)(7696005)(6506007)(9686003)(26005)(110136005)(966005)(71200400001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QzSCejajWFI6lKGyfGz4lfkzk78Iz+KBvVTskzRSVMNRaDPptnWEkMN7O3iA?=
 =?us-ascii?Q?4lVKNZEpoe4NgRhyWFzURZ01Yz7ZXymaDj2QaEpk2Ulzc/rh5nbVUK2fks63?=
 =?us-ascii?Q?lISs6Z19oHCc8hu7XfjdKRqDu3yi5miWy3gw24Wht4xA9TKPYlDVzPlCP+78?=
 =?us-ascii?Q?dVywUsR/7Rypi42SCnLA6aq+2AS1AESAxuQ7tB3V4eNct3LhEdxqfl1aTAEl?=
 =?us-ascii?Q?4Ngy9p64WtBy7lOyCnV0PEuH3yy8k1HPR5yofkcPSWhUB2VpYHIcgypVi2RN?=
 =?us-ascii?Q?ba5qivg/QNu+K/grJq/UM/ZrAhbvLLvQMKu/LNedB125XQWlSG2AnuMz6pdf?=
 =?us-ascii?Q?6FKuc73lyrEan/i3HMHbjXAVMXwttwqWNGZF5+j01W2vmOFXsFZvrMPC/Vnd?=
 =?us-ascii?Q?lJe21IK1d+9kD4Eati7BP7CYkrvj8hAuyJnUvre1Ub1uXmYYwtijL+p6pgPS?=
 =?us-ascii?Q?uX/aYRT/KBCTtxhuoCyMIlCFIBH5iRoAwWxxxht4WHWGQoQOFX7OiB9+TFaV?=
 =?us-ascii?Q?OH1Ko9Xu8DfwUbpx1SZZNH6w4duQsyCEXpaZbRzuEK4HB0hw26DV/I+ObXp2?=
 =?us-ascii?Q?b/EohS8Mvp25Z+rcNHSj3ksxDN1hPs1lp71U1GhbYAPjYGNu5XqSE/2GgkZS?=
 =?us-ascii?Q?n0N/bdzJGPLquscdcXakZiULocTxQtAVHzzbAcppi1v792ZLV8K94kRVbxS4?=
 =?us-ascii?Q?wbyRabufFrMS2PSisg0ElXOL5k9jrVInX0dlBfg6/qTTzAzSLzxyyKgjo1Nf?=
 =?us-ascii?Q?sVY5yeNCxmdpwLz27xRnJDTEuf6HNRqePipvcS5Fp4pIyMYnJoRBo457y23j?=
 =?us-ascii?Q?urN5fRt4fSALs26n8pgY06vBWMfKDnHZLtoHovheHJH0S9cDIj1fpOXjGEU3?=
 =?us-ascii?Q?fe8UKeHov/1byzVZT6DsBsz8R0TxWEEh7AAQ+sF43Ukt8KHzVqhdwp1VLvXy?=
 =?us-ascii?Q?KvIuD59bis8IrXtAx8pLheee7HGZKlCEeh31FXnxB2n7/ytFcknmTHx+UQcn?=
 =?us-ascii?Q?6FhnogFbQ6TF7IPxRAn08aVJ5TxgoU2BshRwN+6Rdvw0bdcUeM/II3Mkln5W?=
 =?us-ascii?Q?NyfKc1Po0REwUgo8MPlZlXtlNNXjU9aAOolC4fa7hRPEARPFHgpDc/NrPUtA?=
 =?us-ascii?Q?+TwUsjF+oyuRNg+MowaC4j8OUUtyv16xa+IhsNzQ1uXW5lqqvaVog5ahqRuz?=
 =?us-ascii?Q?diiia0OKZ9cb4L3ShwCdcnPLm17+nO2OU0U6a0OnOlXMDHodH59gL08DDCDU?=
 =?us-ascii?Q?rKgvt283HhPuT3wSUBXJaDfjCjT1AB/3dBMX3IWWUBE9wfdVv1pWY5d1VbgT?=
 =?us-ascii?Q?Dj4cVVGqOmlVn9xf9LMt4cu3Bhkw42JhnYBUhoj0cpQ7Zp0nyCnixX+jaavg?=
 =?us-ascii?Q?neMRsGsUdkRwDkk+FuFxj1++puuKKoTE7W8qOiKn4xb32G3xYY1BChdXrcrF?=
 =?us-ascii?Q?+Fc5OCcKxVft7vhJRSdteGKnQIjK7ahb0QmMt5+Bx0cCd761Bbvqvcj80CNK?=
 =?us-ascii?Q?tHiNXfg7aINVKyM0vlL19Y0yXzm+21XwMJYbtrCvY5o1MrEUztsYKR5a06An?=
 =?us-ascii?Q?Ka/y/QNBV5ZvO7TPKpyG4NbwO3AMKiElSnSrAdxY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbdf542-9fec-4a8a-aca9-08da852c47b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 17:24:05.3890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +L5Lre5S8vTPJ71HsQmipbYtvyL8pjbwUUs8MhYfymy87MOqhsVMkTn0zI0pu512q5kz6NC6i44OAYRmQle0Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2933
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reviewers,

Could we get some comments for this patchset ?
Or an estimate when this could get your review is greatly appreciated.

Regards,
Besar

> -----Original Message-----
> From: Besar Wicaksono <bwicaksono@nvidia.com>
> Sent: Sunday, August 14, 2022 1:24 PM
> To: suzuki.poulose@arm.com; robin.murphy@arm.com;
> catalin.marinas@arm.com; will@kernel.org; mark.rutland@arm.com
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> linux-tegra@vger.kernel.org; sudeep.holla@arm.com;
> thanu.rangarajan@arm.com; Michael.Williams@arm.com; Thierry Reding
> <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Vikram
> Sethi <vsethi@nvidia.com>; mathieu.poirier@linaro.org;
> mike.leach@linaro.org; leo.yan@linaro.org; Besar Wicaksono
> <bwicaksono@nvidia.com>
> Subject: [PATCH v4 0/2] perf: ARM CoreSight PMU support
>=20
> Add driver support for ARM CoreSight PMU device and event attributes for
> NVIDIA
> implementation. The code is based on ARM Coresight PMU architecture and
> ACPI ARM
> Performance Monitoring Unit table (APMT) specification below:
>  * ARM Coresight PMU:
>         https://developer.arm.com/documentation/ihi0091/latest
>  * APMT: https://developer.arm.com/documentation/den0117/latest
>=20
> The patchset applies on top of
>   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   master next-20220524
>=20
> For APMT support, please see patchset:
> https://lkml.org/lkml/2022/4/19/1395
>=20
> Changes from v3:
>  * Driver is now probing "arm-cs-arch-pmu" device.
>  * The driver files, directory, functions are renamed with "arm_cspmu"
> prefix.
>  * Use Kconfig ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU.
>  * Add kernel doc for NVIDIA Uncore PMU.
>  * Use GENMASK and FIELD_GET macros everywhere.
> Thanks to suzuki.poulose@arm.com and will@kernel.org for the review
> comments.
> v3: https://lore.kernel.org/linux-arm-kernel/20220621055035.31766-1-
> bwicaksono@nvidia.com/
>=20
> Changes from v2:
>  * Driver is now probing "arm-system-pmu" device.
>  * Change default PMU naming to "arm_<APMT node type>_pmu".
>  * Add implementor ops to generate custom name.
> Thanks to suzuki.poulose@arm.com for the review comments.
> v2: https://lore.kernel.org/linux-arm-kernel/20220515163044.50055-1-
> bwicaksono@nvidia.com/
>=20
> Changes from v1:
>  * Remove CPU arch dependency.
>  * Remove 32-bit read/write helper function and just use read/writel.
>  * Add .is_visible into event attribute to filter out cycle counter event=
.
>  * Update pmiidr matching.
>  * Remove read-modify-write on PMCR since the driver only writes to
> PMCR.E.
>  * Assign default cycle event outside the 32-bit PMEVTYPER range.
>  * Rework the active event and used counter tracking.
> Thanks to robin.murphy@arm.com for the review comments.
> v1: https://lore.kernel.org/linux-arm-kernel/20220509002810.12412-1-
> bwicaksono@nvidia.com/
>=20
> Besar Wicaksono (2):
>   perf: arm_cspmu: Add support for ARM CoreSight PMU driver
>   perf: arm_cspmu: Add support for NVIDIA SCF and MCF attribute
>=20
>  Documentation/admin-guide/perf/index.rst      |    1 +
>  Documentation/admin-guide/perf/nvidia-pmu.rst |  120 ++
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/perf/Kconfig                          |    2 +
>  drivers/perf/Makefile                         |    1 +
>  drivers/perf/arm_cspmu/Kconfig                |   13 +
>  drivers/perf/arm_cspmu/Makefile               |    7 +
>  drivers/perf/arm_cspmu/arm_cspmu.c            | 1269 +++++++++++++++++
>  drivers/perf/arm_cspmu/arm_cspmu.h            |  151 ++
>  drivers/perf/arm_cspmu/nvidia_cspmu.c         |  367 +++++
>  drivers/perf/arm_cspmu/nvidia_cspmu.h         |   17 +
>  11 files changed, 1949 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf/nvidia-pmu.rst
>  create mode 100644 drivers/perf/arm_cspmu/Kconfig
>  create mode 100644 drivers/perf/arm_cspmu/Makefile
>  create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.c
>  create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.h
>  create mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.c
>  create mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h
>=20
>=20
> base-commit: 09ce5091ff971cdbfd67ad84dc561ea27f10d67a
> --
> 2.17.1

