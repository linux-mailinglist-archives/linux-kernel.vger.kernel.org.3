Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A7253CC86
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245653AbiFCPrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245647AbiFCPr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:47:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1F224BD5;
        Fri,  3 Jun 2022 08:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5RrJybUyDUi1CYvF9r5ko394ADbFa90kZEv9LEHqGcHTnJdFhrSd+XjFQRs1s6XCU//8ulfqWJUfuqNbuPtyQGUFnuzZVg7sGnJve2aTY11BZJ8zEobax5gFIlJE2fHgCLTiDHHodrg8iPLir2J13sx1cPoksq7ND5LbBOUdQztazVMNXEnmcuWLYzRoAbs7ZkdN0jx+AxW0ffBuFXLpwTDXo3nvvQFMcnzKQJ81mn8FpOmvg4ADi7EudS87usmgKhLolnEEVffA9zNvzAjAn1gxtiQdYVBAOhz1BGP2YzWqYYqQoukFe2m5QRhpms8svC9s1+lpa1JXGGkyyq20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYnwZh+iqSaiz/QZZRgwOqVM46T9IRauhF0n28zP7SA=;
 b=f1WJPaBtBNjL6Ud6ICHRkFYN+bNARbRpZUZshvff/9GRFkDZtJsHdJjp3gOWY8cc0boCOmcrOZGxqPT7I+JGp4X8qa/sgayOUaKcA46otYDOd4Ic3jqPBlfB9KaUhzexsceGRbqi+yc/qlwgDfxrwTegoXjEa3qSlsu7Z8K/IdUp0W/xEy89xWiOeFRpSXozUXWfAPkU91VqxzpjBAx72UrBqcCU81yf5aqLdWwcl0snMaYzSWEGb1SKtcj849pZwUszte7hew4KDg1hPltnk+A6Oi7QCSFJO2t+7qDBCcoePAGYx2510BW01uQwV6Ur1GN3dOi8bxI/S2HvnxGg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYnwZh+iqSaiz/QZZRgwOqVM46T9IRauhF0n28zP7SA=;
 b=EohETNoDCguEyxyS3gdY8KMU0HsRl4NMf1boI4tZ2oOmpKM5wDKoj4Vw5Q5rWgCz1JbLCUZ6b9kNaAb6/v7E9LJXLAjeqa8kJ7Au6F3YEwSsp/edKceJilsx8+LVPWFRY/b6e2cH4giAy/Y6Ymi3FR+dcas/isbQJ5CTfSYruG+/zevTkbm462kED6563YUpBIJOcRhzb71TbpcvtpTHZw0DejFGZx5JpExnj4WxZecQujrM3KHfcCSdEkzPteR3VgqEi49Ydh9R3m0BUKDeQqVH6+QyAsg9I4/4g1wudAvmlunKIyvcnkUxToeyLzwWnizekpPsSKMuKfqB+flUUw==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by MWHPR12MB1470.namprd12.prod.outlook.com (2603:10b6:301:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 15:47:25 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::5940:2328:edd0:3617]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::5940:2328:edd0:3617%4]) with mapi id 15.20.5273.023; Fri, 3 Jun 2022
 15:47:25 +0000
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
        Vikram Sethi <vsethi@nvidia.com>
Subject: RE: [PATCH v3 0/2] perf: ARM CoreSight PMU support
Thread-Topic: [PATCH v3 0/2] perf: ARM CoreSight PMU support
Thread-Index: AQHYcAOGF4muJtj7wEO6ZGULdDD9ja08nHAg
Date:   Fri, 3 Jun 2022 15:47:24 +0000
Message-ID: <SJ0PR12MB5676C22A9B6AC4747033C147A0A19@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220515163044.50055-1-bwicaksono@nvidia.com>
 <20220525064837.7263-1-bwicaksono@nvidia.com>
In-Reply-To: <20220525064837.7263-1-bwicaksono@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86f518b2-4e0e-4982-2379-08da45785af1
x-ms-traffictypediagnostic: MWHPR12MB1470:EE_
x-microsoft-antispam-prvs: <MWHPR12MB147086CA3419265E63E06ECDA0A19@MWHPR12MB1470.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KiozY4owaLULfHhAW9k/jvnALilBdVYfvcNnz2+GA+DA28d7b2z4JDxY2FJhfX0NSljYZUnfNrLVnTaHPOPKFBySlFk0Q/ASxfSZqMqU+emI7J7UolqMNJNtmXz5rJbvLbzzHTTDp9FRtUE4B2dlAYGP5nB/PAW1guEUbmFufQEmoyicEqX2No3I4AoS5zGEGRh/zfddp3WJCDqwTkUHwlCBSVGnIirkp7A0hX0EDe7MjospwL7LvKYjxoOVi9ukAQ2K9W8/xJ+HTxUT/ljzBml1ZmC/d1ocZKLzfLurSnFXx/LLk4s/WQ/cja+iOxTUNC8ZmTsT0qzFqdPtILxOg5tp1jGsSz75H0IOFSbl+GyCXtxlnCw5ZjsQj+jEIG5GTDs9v8U2PvEkPn8BSRd/YltEymZPCA/D28+RUl+Nsl21+uD3EOepobqswRMiSnx7iSpCxf69QYlslfPJ7KGGnn2M4kWil7hfQONWi2tDZfysmo8GHWax2fuddA0r5GS8DpLQKepoq8ET3d0KqNB54nPHLdr5UUp5wRl+HRELY5+Iag2i+7JOatA4iCSdKj3OV09yAKwFv01ue/TXeyuXb9KgwbUcJNzK2Ci6kVbZW61uhYOQ8xEbiDbv2926Z/K2nm+qSyctvfMLxl13j17dVYMU9qs5LT3U3fcrJ5XujCQos2PEg/kqldYvXsYRVc20kEOXVFSyaOo0bxXvGBcNBgZJ5F2hEe9d+aEwudpsw/vNYMNDC0pfFXN/SGvaK037a9yyWgJP++MdMyXAhHh1m597A6/XGsPlcG/NwkNqZj3Qo1GQ5rpeZ44NXm6etnqGK56Kh+Y/FNmogkNZU0SvVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(66946007)(8676002)(4326008)(186003)(55016003)(66476007)(2906002)(66556008)(5660300002)(66446008)(64756008)(7416002)(107886003)(38100700002)(8936002)(52536014)(83380400001)(9686003)(6506007)(26005)(38070700005)(86362001)(966005)(508600001)(71200400001)(7696005)(110136005)(53546011)(316002)(54906003)(33656002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pS3w+eNftvFbRQGm/DTBdcupZPRUmDznLImtkLnh5m1PDrnY1mK6uDgj8DvL?=
 =?us-ascii?Q?FWfgkMj1mQvXwQkG0EfBX4ycWz0yGb4lI4japEo7EZ2xTYJC6GndTBMcKStz?=
 =?us-ascii?Q?FIdLt5h+152nIZkq8HUAe0vBXdY6HxkAqWmUfUjMH+Eecxr0Qb0VOEZwE/Ro?=
 =?us-ascii?Q?jk7GoLBqvWi0n7GJ050Cx1HMUpu4RPgmXEh5QkJNWybAtuG1pZ05JlmpIGoz?=
 =?us-ascii?Q?QN4KgoOQxoUxuGmugtNRVHvKAwchtDNUX1KNutkROi5h/fwcSLOjaiyGPNlp?=
 =?us-ascii?Q?ahCQ5pSuOz5R3gG/L+SQ3o3Thkv/E2ObN3w3Pj42sLkAhThj3RHD2hn/cBY5?=
 =?us-ascii?Q?CmOz9GRkmcTAnSx88scNDGIFW6EhqCBUopetojxptIpaJqt8Hs8ffBYL2mmu?=
 =?us-ascii?Q?DD2rnBuIwJjZkASb5BCtrxbenWTXchTgua/xFGQ0nkfURDMqCWSOapM1qvHw?=
 =?us-ascii?Q?mjcHxlePlAuJU9OayzWWDLZhuC3CCuct0gg+HLVAy7pyAScI7mIBRE8AHfiM?=
 =?us-ascii?Q?/lGUdkCfDDEPRPAhX5xZnpmVpFxrsodxij8JoNLl8lKfmftMGT6i9SFe6hBg?=
 =?us-ascii?Q?7r/dAqtlcz0Mf0Wa8J2I5uyPbLngdZYUSDKQyt/Nv2sIiDNNQKCXU0Gk2CUO?=
 =?us-ascii?Q?W4WzdBWn3vtTfPZBBf0hFEfAfYQiCP/E+gy6wiaz3YAgs8gYb5g20wxQ9m4I?=
 =?us-ascii?Q?5gIFw1fS/OWRLf+KQNZmOj6Jv2Rg3e7rCMVSqW1BgWt875x5cffGP/axuIyW?=
 =?us-ascii?Q?qfTX4VzVugGlbAGFcCd0McJ6Md9Z+bHYCFtSPIB5L1XjSKSoyKtdT5ZaqStv?=
 =?us-ascii?Q?MEjt/Mbad+1ntuTxbqiAaNzD8gqawkTo4WhCkPHgACxIzDYSeVkNX+IBLh4H?=
 =?us-ascii?Q?K8GiMyet39/NquxnCj5N5AoF07sqw72gcB5Cdt52NXSi9FdB32UGC1nf31jC?=
 =?us-ascii?Q?jBT2BcS5fXesFWZLMg3xye47uHI1+2WoPWAu6ldVNYpAnv6zQfe3B3nmGJZ/?=
 =?us-ascii?Q?cYm6/3p//k0638/yRw6cgjsev5HF1T15ZXPRVATDtQ+lkMZG3EcZ4xTtK40G?=
 =?us-ascii?Q?VOapDZ5TyXV455AAsRVFGrg1ohJzXhIngFvvzJZais6h3dFJNHmjU+WZuq73?=
 =?us-ascii?Q?JWloxsYKB/WRqgSFcTowZWV+441RtBWF95EK2fV5oF3cKigWZE4DAaPSQp2k?=
 =?us-ascii?Q?Lz8xFEvI4cbClO1AVego1jg8j/+T6gg/exnecBwwCClJsuBz5Cx5ZrYC5iUk?=
 =?us-ascii?Q?G1Awhc2vnE6sfF07+BI/QHY/M+JT0lNjkGHLJa2C5SwU0pga3/YvyRSGDqE5?=
 =?us-ascii?Q?y8j6eOvL80WlkhurWejBZLIc+zLRfwaFwuO4O3GqufHgcGprika3p4E/WmD0?=
 =?us-ascii?Q?ioY4xVtU6xsdeP0OhrGCbUl0VRH9QgdvDk6fPUjoXPkFsnpTayxi5r3aLn5I?=
 =?us-ascii?Q?xuJoy023l373NQ3a8dDAo3ibA3nVeRxajcVJkNHVb9TiqOyX/L3HApB+69/s?=
 =?us-ascii?Q?T2bQxO8xCcvPfvA1I+34tgUtYZKYkC7FRYx5ijXbg3uJggzOxHjqgDCiUNWY?=
 =?us-ascii?Q?O/aHhmkxAmuusgUK1JhkR+QeP1yHvGbjNzvZqDCY3KRjvs1bSavZRaK33eTu?=
 =?us-ascii?Q?4vSitV8bO/f/1HVGw7z0LrrtbYwwhml/ujvNj0LfiWKR4xExpSJB5dxGFPgW?=
 =?us-ascii?Q?rJwiduWQcXFnGDB+2p1PTDPyrlNYvmQodacuIDeXzp1MHhY/lZgurbovLrfO?=
 =?us-ascii?Q?IgxR9UuMSg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f518b2-4e0e-4982-2379-08da45785af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2022 15:47:24.9866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjPANc6QzleS3o6vl3e4eYJ5s60i7RhmBHLUiubc7xWyQieubx+5eUuL6bOsBPU1+7ggaNlJpA8FObQOLTPZ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1470
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was wondering if there are any other comments that need to be addressed i=
n this patch ?

Regards,
Besar

> -----Original Message-----
> From: Besar Wicaksono <bwicaksono@nvidia.com>
> Sent: Wednesday, May 25, 2022 1:49 AM
> To: suzuki.poulose@arm.com; robin.murphy@arm.com;
> catalin.marinas@arm.com; will@kernel.org; mark.rutland@arm.com
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> linux-tegra@vger.kernel.org; sudeep.holla@arm.com;
> thanu.rangarajan@arm.com; Michael.Williams@arm.com; Thierry Reding
> <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Vikram
> Sethi <vsethi@nvidia.com>; Besar Wicaksono <bwicaksono@nvidia.com>
> Subject: [PATCH v3 0/2] perf: ARM CoreSight PMU support
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
> Notes:
>  * There is a concern on the naming of the PMU device.
>    Currently the driver is probing "arm-coresight-pmu" device, however th=
e
> APMT
>    spec supports different kinds of CoreSight PMU based implementation. S=
o
> it is
>    open for discussion if the name can stay or a "generic" name is requir=
ed.
>    Please see the following thread:
>    http://lists.infradead.org/pipermail/linux-arm-kernel/2022-
> May/740485.html
>=20
> The patchset applies on top of
>   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   master next-20220524
>=20
> Changes from v2:
>  * Driver is now probing "arm-system-pmu" device.
>  * Change default PMU naming to "arm_<APMT node type>_pmu".
>  * Add implementor ops to generate custom name.
> Thanks to suzuki.poulose@arm.com for the review comments.
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
>=20
> Besar Wicaksono (2):
>   perf: coresight_pmu: Add support for ARM CoreSight PMU driver
>   perf: coresight_pmu: Add support for NVIDIA SCF and MCF attribute
>=20
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/perf/Kconfig                          |    2 +
>  drivers/perf/Makefile                         |    1 +
>  drivers/perf/coresight_pmu/Kconfig            |   11 +
>  drivers/perf/coresight_pmu/Makefile           |    7 +
>  .../perf/coresight_pmu/arm_coresight_pmu.c    | 1316
> +++++++++++++++++
>  .../perf/coresight_pmu/arm_coresight_pmu.h    |  177 +++
>  .../coresight_pmu/arm_coresight_pmu_nvidia.c  |  312 ++++
>  .../coresight_pmu/arm_coresight_pmu_nvidia.h  |   17 +
>  9 files changed, 1844 insertions(+)
>  create mode 100644 drivers/perf/coresight_pmu/Kconfig
>  create mode 100644 drivers/perf/coresight_pmu/Makefile
>  create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.c
>  create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.h
>  create mode 100644
> drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c
>  create mode 100644
> drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.h
>=20
>=20
> base-commit: 09ce5091ff971cdbfd67ad84dc561ea27f10d67a
> --
> 2.17.1

