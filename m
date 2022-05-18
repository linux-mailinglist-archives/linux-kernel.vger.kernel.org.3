Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C607B52C443
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242450AbiERULl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242486AbiERUKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:10:48 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2071.outbound.protection.outlook.com [40.107.212.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8FF3C73B;
        Wed, 18 May 2022 13:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1Wih/uI9JrXhEio6sLlVyImWH2FeuckM6/xog0NlrmVZyNeL0m+ZdAWQL9JfhualRHBSECA38NlY5Ur1uk3WsZg5pW/FzCNhgInbTyS3zqgugk2DSdiMBiIL/pGTEVakdmIw0PYAb8gIylf9GG03W9n6VT7VYB3fxUHkziOZRvJ7oxYsfgHwjsJMslqMwoYNlVlvfhLKkNcuhwzsD2hQW5pj5HNix7U9u6BYJOCLFHIJR/E1uyJU5FRNI9tdsX4TQGfwhP8Qgj8WwedFvFRLqqewhiL+uO9PhxqgAkPCJ8SNflqKqjlcmK7zuZBrHO5AOSJyTY2uVDZ/QSgMe9f2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U31oHzc4tffVrIpxFknWvNmKHjI2/olk6/rlVCqqV+U=;
 b=lnalC23PWff4CPIM1H1m/FAKbdmRB/QXpJ6fjCTYt3DV/IzQIjMvilX0UGKzF62pn7xK/dEQyWFxhjTIP8QZPOlvwC+n7F7SkVJhczPAsoGtxD09vtyIyk5bV9+gWdwvWbDZMfX+j919hHgfQaL0ntUjYbJKfgwKc7YJOymiV023ZiouSP7TDnunfJCTDaZjHGIB5KennxptHtEQmYU13oLaNYFnINZBa+rswJ5hQWYMwKTXDUhv5PTeTAezxoP4yKZbdjyK+ZbxWNIZzrroxXSnFUsYQU1Z3JDn0LiTjMJ1N8OuZOT2wxYOH7nmh30XRRVVETbDfi9Yc0eWl/ObXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U31oHzc4tffVrIpxFknWvNmKHjI2/olk6/rlVCqqV+U=;
 b=g6mMdy6lajxlfyfimOfXyKvsmvwbrb9l98j4RlF7ZVcNfZuQN9R+hlDiPlFDwfvjA+ohY8fqzwlePdkS8+VDTROwOrIVgnfa+Ab3nk1XwAgq+1N9cdELhZudsR7Lz/VNLope60LwwHdV+to4NlEDV7pDnmIX7Mj5OeA2xbj7vJuY2uRy6A2C1Xpt2heXg9DJtJUvNwn/NnwtzJQhC5gJIhr64moNiJxmZeh2+ie1xzsJViGb1Gh5IK0ghiub+lsrl6AQmA5NltP74jCrOvtpbplk2MloxbjHspfa6GtuVu/m1pdMY9pM+vcpJvDXaeaQHtK7NsTglaJR2CTo/xO/0A==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 20:10:41 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::7526:b8f5:b10:1c4c]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::7526:b8f5:b10:1c4c%7]) with mapi id 15.20.5227.021; Wed, 18 May 2022
 20:10:41 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>
Subject: RE: [PATCH v2 1/2] perf: coresight_pmu: Add support for ARM CoreSight
 PMU driver
Thread-Topic: [PATCH v2 1/2] perf: coresight_pmu: Add support for ARM
 CoreSight PMU driver
Thread-Index: AQHYaHlD4fvleNsNzkCmVlWU5lNRqq0kPV+AgADP/wA=
Date:   Wed, 18 May 2022 20:10:41 +0000
Message-ID: <SJ0PR12MB567669E26BF743C951AADD28A0D19@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220515163044.50055-2-bwicaksono@nvidia.com>
 <202205181534.wuyBFt9d-lkp@intel.com>
In-Reply-To: <202205181534.wuyBFt9d-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d7c2f42-8bc4-491f-da97-08da390a7b7e
x-ms-traffictypediagnostic: MN0PR12MB5713:EE_
x-microsoft-antispam-prvs: <MN0PR12MB57132022E8D4A4EF5431BD8AA0D19@MN0PR12MB5713.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JQmS18WWH1CWXfNSJoONA35hB78TUhSUdDwyv3qoNGakYMaV+GwDvectRR9txq/BSm6BMljFPhjLqeI71lWDFyE6tSKj17UDN7SD93/dLGOdDF0o/x23Mv6mxqjAenq6QRsZRQooV5qUwLtRkmJV8Awwqw/Csofod/hR4GF90a8Mj2Lq6EIpny2+zqfLrSDR03g5MCkAi0yT5Yq0ftmj0J//EZEazr/byqL0GXvjMk66DZQHSAEXmPrnHcouE2BQShE68mhh6Iz4sWRPwiKYOF7uGi0Q504R9xVCzZ7W8Ye1pfc46y7YEznf3wki30MViml1NPFAgzF2zaDcS7NzHjTpbLVvbBbwnjiq2C+DE5wMrhfYpKEQfM1+rQL3VwFF9pAxO3D7HvEAwwQw/xtq6V7XLokhYfD/XnebgUcFs8+iOyTEZeH5TovBlP+Qpq92163eSb6tORjz0odMCj/S8TNNUrgaekHIlZ5/WQbH1iDjXw+cE4iSYmzXdy5l4yszA+XoFsu+RXcfTv0xKuJOYBjBPYFtVtXv0zpTj0QBOyZ2p0PHRr+2z6hrRmx4HQ9iJp+n7dZaxlw2NQWNnMIFCGoEMiFZs7mgEr05aoAlQykkxZfqVVl01cYRTL1ohxwEYK3gG2bcG8wmoXT72mIT7TrJteeKJrGrcstVooP4g2wDCXJ05+d0G/RrXjtGpcmLlTHL9e4OUm1phy/VtFBm/FOcyzx4zocYR9cO8I2935dobEXSgEIPn8EvSKO78lU8kPmc4vvTZ2iuQM9WAHvus5DBnxibL0s4KPNjZ5zDZig1d7jslWPycDn+yJ0US56nYUKAcTbi0MZpvhH9egLbMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(66476007)(53546011)(122000001)(5660300002)(6506007)(110136005)(7416002)(26005)(4326008)(38100700002)(38070700005)(8936002)(71200400001)(508600001)(54906003)(83380400001)(33656002)(55016003)(7696005)(86362001)(66556008)(2906002)(66946007)(8676002)(66446008)(64756008)(76116006)(186003)(107886003)(9686003)(966005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xgNIn0+td7qAI7eT8/CKzaNB6Cv4dKyQfiqXTzSebMnUX7AfF6h/+QI2vKWm?=
 =?us-ascii?Q?30GTpPmla76+6/fDOfuTYU/9iHbi4yJ6lSHNbrBRuHVQagjufkG/lyHK/XkR?=
 =?us-ascii?Q?fDdnydeaLGEnVp6CiMOnSA1AnmaQ9NcQwoqtYZ+r/5QfkKAjQWIElpE/cYTe?=
 =?us-ascii?Q?CuF4fJbaC5oC/LofcQyD9NWxZzfVMmv/jM1GQdzsd+jiA6858Aw/O3iYkZNq?=
 =?us-ascii?Q?ZYXe7BefqYglcdXbG9fl395Ed2bUNPSvdTraESdhKeqFO/pq/OBt5Y/w110l?=
 =?us-ascii?Q?e6+DYpbNQXe2lP5bgTJJbb8RakkM0VM3LG5zQOhW95O3kUSNy7n8f1Lw+Raz?=
 =?us-ascii?Q?tEVg+s0p9My3jY2ZpSt6k6MYvq1BWJm8Uhs8yq5BI+hZhLxlgA9IxONac2ag?=
 =?us-ascii?Q?zywX+9GFsEEXuP855slISv66DWzQdCcs8NZq3wAmjf1meCp2I5U5LMkJHPNg?=
 =?us-ascii?Q?RJ29ZzE2zxTI4EeZMgxFYSCIdY7/2L2/2KDcereg6QoBEe6ccp0dJM24YdFt?=
 =?us-ascii?Q?RClovwzFWybZExeMvQIcwEU0JrE2Uq5K2meOZhXNpv7k2oM0mvqDD5piiOX0?=
 =?us-ascii?Q?jVO0GflbvsGt4ReqKJOnTJ9XikwsJEbl7nWF/0dTcWzmWR6LF1yk4g0hXdeg?=
 =?us-ascii?Q?RYvW1BJ/VYxIFNz9GNaQ6XCwO5yVODb1Da8RSrtz1XCCIcUyTIeSTKtWLQwh?=
 =?us-ascii?Q?i4g1EX9VueDGjMeDlaWs2HODGycXUh6Cj5DglMuR+B3fPLLJqzOTayI6yShl?=
 =?us-ascii?Q?KqTqfyAmnWUV4mO30CsXVrnML7Ry0Mp4NtPlLIq7S5wQ9A+ojH1gSiokqgda?=
 =?us-ascii?Q?qNitu+SfiLv6BQr7VY5Kgewg1oiHdxKBPqNFGLWr7Ko8f6UH23Qs8CgGdIOG?=
 =?us-ascii?Q?jUqnBZVwilytZAko0uyqwvSNO/GatWSrP9h41ueBLskLkY+AqxzL+Ln7v1mH?=
 =?us-ascii?Q?AMURNX2aovqBG7k8jSkqBFJyKroHqQnD55CMZ1l4u2qCiqO+2PmcT/dNjUnO?=
 =?us-ascii?Q?JePx+HAUcSuVkQ57nmmGNeWOT4ao7pFp23DUAddNiluTIagmaZmh2JLAusSr?=
 =?us-ascii?Q?bRdIlOh96iA+hhsWWnxl6twi6tNhmyhYJaJ2dQ4WsX40FDp2GGfWY7yFgzkv?=
 =?us-ascii?Q?/6iOz0ppT4MGFbtB1slWImvZvBJmjrU5QoDFfoD/C5UqA0L9U8GTAAZwPbLH?=
 =?us-ascii?Q?caBhoXPLPaAzFth7UNZ4ACyKgXL6PkRRslV8qjswUtXBtl9CphqozDWFiMKf?=
 =?us-ascii?Q?xxH8k1WrW8eEHDaSHKUy83/qz24S31Azn4TbRyC5yCHpqKECEUlQN4tcZnhh?=
 =?us-ascii?Q?u2R94kmD4Q0sf3CN2uPl48np8PUHFQlDzLmmoiK+WXu9Qp2J32DunzO5Uzgd?=
 =?us-ascii?Q?Wrsh+syQelwt5bLvY0nOUqPaMPh0Bzu80kpB8JSLr5pRgpcJe2xWFLzOptiV?=
 =?us-ascii?Q?i8x10xn1HCLtu+Y/RojqbquX6vfZmWrvmaCsDIEUQCjs4921GSVE070/MCoT?=
 =?us-ascii?Q?yrjnBTKrWBnGzFCcDJ9YjVtfvIdLAUvXEmbsbx3RrYprXfgZWktoZQKw4hd1?=
 =?us-ascii?Q?lgUrlQDgqlu7IBh02o/Yq04bp4VvDRI1MOivkQVEbz5AOeC8zi6K0UfrSmnq?=
 =?us-ascii?Q?1MOI/vd7OFVTFQVkuYAlnWUpnISRyghqaz+YvWMNjtg9SXKLvVQ9JSjeNVse?=
 =?us-ascii?Q?EihMuB1pBI1izfZJlWt75ljuOm3wEmWzptZb2vzRdvmpC+JsEauVES+4DtyH?=
 =?us-ascii?Q?zRgwCVRAsw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7c2f42-8bc4-491f-da97-08da390a7b7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 20:10:41.0245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PeOD3+TaqEPzzO8ZAiMa569GqT76ThsyhKdCcvS0jKqeB/Zk9iQ6HbO++2d934nNdxv+ZL8xauI0TRzsKpY2+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The errors on the APMT* identifiers are due to the missing ACPI patch, whic=
h was
submitted on different series: https://lkml.org/lkml/fancy/2022/4/19/1395.
Sudeep, could you please suggest if I need to combine ACPI and driver patch=
es
into a single patch series ?

I will fix the warning on 'level' usage on the next version.

Regards,
Besar

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Wednesday, May 18, 2022 2:16 AM
> To: Besar Wicaksono <bwicaksono@nvidia.com>; robin.murphy@arm.com;
> catalin.marinas@arm.com; will@kernel.org; mark.rutland@arm.com
> Cc: llvm@lists.linux.dev; kbuild-all@lists.01.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> tegra@vger.kernel.org; sudeep.holla@arm.com;
> thanu.rangarajan@arm.com; Michael.Williams@arm.com;
> suzuki.poulose@arm.com; Thierry Reding <treding@nvidia.com>; Jonathan
> Hunter <jonathanh@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>; Besar
> Wicaksono <bwicaksono@nvidia.com>
> Subject: Re: [PATCH v2 1/2] perf: coresight_pmu: Add support for ARM
> CoreSight PMU driver
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Hi Besar,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on arm64/for-next/core]
> [also build test WARNING on soc/for-next linus/master v5.18-rc7 next-
> 20220517]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Besar-Wicaksono/pe=
rf-
> coresight_pmu-Add-support-for-ARM-CoreSight-PMU-driver/20220516-
> 013131
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git f=
or-
> next/core
> config: arm64-allyesconfig (https://download.01.org/0day-
> ci/archive/20220518/202205181534.wuyBFt9d-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project
> 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/intel-lab-
> lkp/linux/commit/79f30980a7a91e6bbe7430206e4e46fa8134cfa9
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Besar-Wicaksono/perf-coresight_p=
mu-
> Add-support-for-ARM-CoreSight-PMU-driver/20220516-013131
>         git checkout 79f30980a7a91e6bbe7430206e4e46fa8134cfa9
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross
> W=3D1 O=3Dbuild_dir ARCH=3Darm64 SHELL=3D/bin/bash
> drivers/media/platform/qcom/venus/ drivers/perf/coresight_pmu/
> drivers/rtc/
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:165:49: error:
> incomplete definition of type 'struct acpi_apmt_node'
>            return CHECK_APMT_FLAG(coresight_pmu->apmt_node->flags,
> ATOMIC, SUPP);
>                                   ~~~~~~~~~~~~~~~~~~~~~~~~^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:129:4: note: expanded
> from macro 'CHECK_APMT_FLAG'
>            ((flags & (ACPI_APMT_FLAGS_ ## f)) =3D=3D (ACPI_APMT_FLAGS_ ##=
 f ##
> _ ## v))
>              ^~~~~
>    drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward
> declaration of 'struct acpi_apmt_node'
>            struct acpi_apmt_node *apmt_node;
>                   ^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:165:9: error: use of
> undeclared identifier 'ACPI_APMT_FLAGS_ATOMIC'
>            return CHECK_APMT_FLAG(coresight_pmu->apmt_node->flags,
> ATOMIC, SUPP);
>                   ^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:129:13: note: expanded
> from macro 'CHECK_APMT_FLAG'
>            ((flags & (ACPI_APMT_FLAGS_ ## f)) =3D=3D (ACPI_APMT_FLAGS_ ##=
 f ##
> _ ## v))
>                       ^
>    <scratch space>:61:1: note: expanded from here
>    ACPI_APMT_FLAGS_ATOMIC
>    ^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:165:9: error: use of
> undeclared identifier 'ACPI_APMT_FLAGS_ATOMIC_SUPP'
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:129:41: note: expanded
> from macro 'CHECK_APMT_FLAG'
>            ((flags & (ACPI_APMT_FLAGS_ ## f)) =3D=3D (ACPI_APMT_FLAGS_ ##=
 f ##
> _ ## v))
>                                                   ^
>    <scratch space>:64:1: note: expanded from here
>    ACPI_APMT_FLAGS_ATOMIC_SUPP
>    ^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:369:13: error:
> incomplete definition of type 'struct acpi_apmt_node'
>                    (apmt_node->impl_id) ? apmt_node->impl_id :
>                     ~~~~~~~~~^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward
> declaration of 'struct acpi_apmt_node'
>            struct acpi_apmt_node *apmt_node;
>                   ^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:369:35: error:
> incomplete definition of type 'struct acpi_apmt_node'
>                    (apmt_node->impl_id) ? apmt_node->impl_id :
>                                           ~~~~~~~~~^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward
> declaration of 'struct acpi_apmt_node'
>            struct acpi_apmt_node *apmt_node;
>                   ^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:894:58: error:
> incomplete definition of type 'struct acpi_apmt_node'
>                    devm_kasprintf(dev, GFP_KERNEL, PMUNAME "%u", apmt_nod=
e-
> >id);
>                                                                  ~~~~~~~~=
~^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward
> declaration of 'struct acpi_apmt_node'
>            struct acpi_apmt_node *apmt_node;
>                   ^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:920:31: error:
> incomplete definition of type 'struct acpi_apmt_node'
>            if (CHECK_APMT_FLAG(apmt_node->flags, DUAL_PAGE, SUPP)) {
>                                ~~~~~~~~~^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:129:4: note: expanded
> from macro 'CHECK_APMT_FLAG'
>            ((flags & (ACPI_APMT_FLAGS_ ## f)) =3D=3D (ACPI_APMT_FLAGS_ ##=
 f ##
> _ ## v))
>              ^~~~~
>    drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward
> declaration of 'struct acpi_apmt_node'
>            struct acpi_apmt_node *apmt_node;
>                   ^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:920:6: error: use of
> undeclared identifier 'ACPI_APMT_FLAGS_DUAL_PAGE'
>            if (CHECK_APMT_FLAG(apmt_node->flags, DUAL_PAGE, SUPP)) {
>                ^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:129:13: note: expanded
> from macro 'CHECK_APMT_FLAG'
>            ((flags & (ACPI_APMT_FLAGS_ ## f)) =3D=3D (ACPI_APMT_FLAGS_ ##=
 f ##
> _ ## v))
>                       ^
>    <scratch space>:60:1: note: expanded from here
>    ACPI_APMT_FLAGS_DUAL_PAGE
>    ^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:920:6: error: use of
> undeclared identifier 'ACPI_APMT_FLAGS_DUAL_PAGE_SUPP'
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:129:41: note: expanded
> from macro 'CHECK_APMT_FLAG'
>            ((flags & (ACPI_APMT_FLAGS_ ## f)) =3D=3D (ACPI_APMT_FLAGS_ ##=
 f ##
> _ ## v))
>                                                   ^
>    <scratch space>:63:1: note: expanded from here
>    ACPI_APMT_FLAGS_DUAL_PAGE_SUPP
>    ^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:1028:15: error:
> incomplete definition of type 'struct acpi_apmt_node'
>            if (apmt_node->ovflw_irq =3D=3D 0)
>                ~~~~~~~~~^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward
> declaration of 'struct acpi_apmt_node'
>            struct acpi_apmt_node *apmt_node;
>                   ^
> >> drivers/perf/coresight_pmu/arm_coresight_pmu.c:1053:6: warning:
> variable 'level' set but not used [-Wunused-but-set-variable]
>            int level =3D 0;
>                ^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:1079:27: error:
> incomplete definition of type 'struct acpi_apmt_node'
>            affinity_flag =3D apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
>                            ~~~~~~~~~^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward
> declaration of 'struct acpi_apmt_node'
>            struct acpi_apmt_node *apmt_node;
>                   ^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:1079:37: error: use of
> undeclared identifier 'ACPI_APMT_FLAGS_AFFINITY'
>            affinity_flag =3D apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
>                                               ^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:1081:23: error: use of
> undeclared identifier 'ACPI_APMT_FLAGS_AFFINITY_PROC'
>            if (affinity_flag =3D=3D ACPI_APMT_FLAGS_AFFINITY_PROC) {
>                                 ^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:1083:17: error:
> incomplete definition of type 'struct acpi_apmt_node'
>                            if (apmt_node->proc_affinity =3D=3D
>                                ~~~~~~~~~^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward
> declaration of 'struct acpi_apmt_node'
>            struct acpi_apmt_node *apmt_node;
>                   ^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.c:1093:23: error:
> incomplete definition of type 'struct acpi_apmt_node'
>                                        cpu, apmt_node->proc_affinity))
>                                             ~~~~~~~~~^
>    drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward
> declaration of 'struct acpi_apmt_node'
>            struct acpi_apmt_node *apmt_node;
>                   ^
>    1 warning and 15 errors generated.
>=20
>=20
> vim +/level +1053 drivers/perf/coresight_pmu/arm_coresight_pmu.c
>=20
>   1047
>   1048  static inline int coresight_pmu_find_cpu_container(int cpu, u32
> container_uid)
>   1049  {
>   1050          u32 acpi_uid;
>   1051          struct device *cpu_dev =3D get_cpu_device(cpu);
>   1052          struct acpi_device *acpi_dev =3D ACPI_COMPANION(cpu_dev);
> > 1053          int level =3D 0;
>   1054
>   1055          if (!cpu_dev)
>   1056                  return -ENODEV;
>   1057
>   1058          while (acpi_dev) {
>   1059                  if (!strcmp(acpi_device_hid(acpi_dev),
>   1060                              ACPI_PROCESSOR_CONTAINER_HID) &&
>   1061                      !kstrtouint(acpi_device_uid(acpi_dev), 0, &ac=
pi_uid) &&
>   1062                      acpi_uid =3D=3D container_uid)
>   1063                          return 0;
>   1064
>   1065                  acpi_dev =3D acpi_dev->parent;
>   1066                  level++;
>   1067          }
>   1068
>   1069          return -ENODEV;
>   1070  }
>   1071
>=20
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
