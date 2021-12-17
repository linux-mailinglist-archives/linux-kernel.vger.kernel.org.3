Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B664047859E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhLQHfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:35:32 -0500
Received: from mail-mw2nam12on2040.outbound.protection.outlook.com ([40.107.244.40]:10849
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233716AbhLQHf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:35:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jV0o+0vOVUrQpOBC7hpjD6YeWFPREUvNKo5SY5px1Q0cwUoFRIxuS4l3l2tl/7NXTwaJNm9UqI4ehMysQQ6JmAAQ6EIsIAjpPVE7pAM5QyvNDOjJYWtPXV7VpgW2IBlg6YvW50zg5O8qck5HbT7QGMT5o8JzenC6CPPTO1R02sO64aZyeetcwZp/5T2ysy0wupKKXRjg6uOcb+fij9e19tRPsa9fp8lq9YHKYDuMTCTaT0tCmrn3CuOW1dGHKNkOmOIJfxxim7xCo2Xq8xx7GmoYmsF+4y/7KXz4Efeog/u/SaH4dF1+9zXj6pCY6MBNTVdk3Wihv3KaRdmh/DJU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oSRb83T72s7b1Qu+f8gY3bPGlwWjJGNNrmL1lUXK/A=;
 b=XJ1mimodzE87ikRemoBc+pfnHc1T89Xwlm12F2rb2atEbznQW9PFEE1t/K3ePOOW8LA0LjvwDeq+DYQqRllRPTiegBsHpEH89y1bSz41ESwARzNDhHJ2OgBXVlPM3Pcs9ZDyTy4Ob9gYHvx4mPkxYDoF3NGw8mM+QYwFmKtcqm9NRvQQlDnFF2lMmniVbfuqXpKpwdYMsyFpDbK4M6yyZPb5ZKpHJBr30dp22uxD90Ipb3FXUV9AQVMQHjp1gullSXIoHA0hc1oBln9vhMtIRKtv5CWDfo5wZuDoIoEmeC8eezRfgSuQIGEqgZoLNMNYBEyCVdQRsuW38gZLp8i5EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oSRb83T72s7b1Qu+f8gY3bPGlwWjJGNNrmL1lUXK/A=;
 b=L/l3PVbFyIfzpBLJQrurXLqFOoH9vcyFHYO6f0HZMJXLOfDGHRizfaorLPJSy2yJFGzQy/licr/ci2/4wdePBH+Y4suxkza4t4iQjOtXeIoRLUoqCRPHApl+Rt8jgHFot0h4571zVjK7jQyug+u/nA5sBxP7WWmrC/bWSeE1AbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB2794.namprd12.prod.outlook.com (2603:10b6:5:48::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Fri, 17 Dec 2021 07:35:23 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5d07:e475:316c:d187]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5d07:e475:316c:d187%5]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 07:35:22 +0000
Date:   Fri, 17 Dec 2021 15:34:54 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v5 06/22] cpufreq: amd: introduce a new amd pstate driver
 to support future processors
Message-ID: <Ybw9nqrrrumSWpli@amd.com>
References: <20211130123641.1449041-1-ray.huang@amd.com>
 <20211130123641.1449041-7-ray.huang@amd.com>
 <CAJZ5v0gxVTJ8KffVpcLUZ=KPVRwinV6Wdq+-s3RO_cv6bevxXQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gxVTJ8KffVpcLUZ=KPVRwinV6Wdq+-s3RO_cv6bevxXQ@mail.gmail.com>
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebdcf588-e8a9-4b03-8c5d-08d9c12fc86c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2794:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2794422113EB58291438083BEC789@DM6PR12MB2794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WQeOUWu37hRXXlWyifeiRfb301Qcu+M/MeXtGjHUXcNaSfZwJAtN1fgNihbX18DkAH8036AR6jB8V20U+oCdyGaMyYC0JJTtso/D0xyDDsbvDcMwqhv8xGaaGuVfctRluoR1gtlM1ASkplU+0wcifiPKbsftVIfVsLW/Oo930YWLMaQ1Zx6KWsj3H/62icpxx6I2HS8DIcAcBq8sfjvAG7bWPeazv9QoIKSiWvdZCy1hHKK9QOmD5uMBQJeZRD6vcOlIGtrS+SNWReLAf5pQWFQUPdEgzgpUXb4yYTN9qUIfP9BBHUKw5zv09DoNj//YTH+dvEOglpFUCZXY9lwPI3NT17lkuIAlBVijusQf6DULp1R04LpjYfLfO5parF4QnmJ+1kyZVC407Wcc9FAaEF711NkjZJ4yCe5JFd53r6w+AzAsZdSYaXLj1x5/NuQrZQcgISCRpy1c9ytoOKLqR/qMP60W+WgojMqvMVnKEEjvuYK8SKxjH7RQN2cp3tXBSniMJgeQzw+mWuNmlsGwoNqoIkre9oM/umSP0S4YKnMCPGdj9zXAZlC02cy71FVjk7UxnT467QgeicDexixVCt7/feYGkqODzfVY3MqruTHPw6h1bihH8oR2B0SwP2wzTcHBOXDplInQBwIvlEfSQWwcgl6if1oZZbTzgVYGnczOIX6KvtQr80PWRjk8mzxiM3/LZq/RoGCb97TChcio6Vk4vh+LwAIhNbRGCIIlv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(7416002)(8936002)(186003)(6512007)(26005)(6486002)(2616005)(54906003)(38100700002)(66946007)(53546011)(6916009)(45080400002)(5660300002)(6666004)(966005)(66556008)(316002)(30864003)(66476007)(83380400001)(508600001)(86362001)(4326008)(2906002)(8676002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3dJ2Aogr4+twPxI6M7wODiB+IhE5vYysoJqb/EAM/sz+r9D1mziSP64FdFmE?=
 =?us-ascii?Q?381WwnNauNQ3uA7GqItK3RKfxoTk+9qX0D1/KJhUaFVgENSe5TprQB/7a4mI?=
 =?us-ascii?Q?qkcify1W186fEONnWIJXjz6kD5WJS7I+H2DkTA1agDRPke9GcrlG2u6mNwx3?=
 =?us-ascii?Q?v2jR7zjpT8jjfKyoRy9lCQFh8mcM9DYrchOBZCPWieDWM8oNXhr3aDEOkUkC?=
 =?us-ascii?Q?c9yzKmdV++irYTha82aDu1SkxJVcdgCuKYMoSs6oi0nzShAaxkmVQD/d0YzC?=
 =?us-ascii?Q?hvxyNjYjouiQAyLP71guG75eb67C2KEgZ04wRNanUh3TA2prsCcAcrphTGU9?=
 =?us-ascii?Q?HsJ+pBKaCfVpANxc6ZEbJfbwIRqAn7HlkSD0h6PukRKDP3O8TDK4FwnBr5Qf?=
 =?us-ascii?Q?9C+z+LygKdRO7VyMsezXDJTED9UIxEDZ1AfA4wb+kaq2lmUj79WqEgC027Jj?=
 =?us-ascii?Q?MPwOqVPw8GAvOagnyTzqTekASkRFHXQGfKy3y1WE6Yptq8Dx8TR74FhlobWB?=
 =?us-ascii?Q?JlceYpR2tnFfmxYBQqT7y/xHsz1Gb1HXPUl86pbTODak5FpPDQ/W8PBMYCW0?=
 =?us-ascii?Q?1apjU7F8AVxXIIRpeu8+M0pI/IboRBXRcIX4Rzq8pommFfHZoun+luHzoW7x?=
 =?us-ascii?Q?JIbXjTwe9XghY0k4nNAS/llXDi7nmLwR9+qUPw0hRWySAG+Yz8YMAiyIyc1L?=
 =?us-ascii?Q?J9dIhMeQtkgFA2HLUw9quZ4jjmk4i/OPr3VerNk1blJ6WGsx9F2MUcdZMUTI?=
 =?us-ascii?Q?2fFCdFwfwStpyG2Lv2X3Tlj/wANi89P9Y9hC3dmFvIEVA/RUmmx1Tq1eU4Ac?=
 =?us-ascii?Q?s0R33Fg0OEEpfNsrn30fmqSsOcMy3NPNFdbZ6o1TP1fc3Qyi3R8kvUBJ1ke1?=
 =?us-ascii?Q?7OgIRfUOhWN1IpwKdkBvo3vuhoNYSSi6kI8MRxaW+ReJikTo6jDa5WQHqJcE?=
 =?us-ascii?Q?ZBfCv3J5eYFx6icKJSCc4gndNtnDgXxww8TsQgC5P1njnROFMNsSjY9pRRvv?=
 =?us-ascii?Q?xTxs+w3cH844R9MbgcEaj9/x5Ua3hbz/XAScTzjtOTTklWOduv3qVZjOR3ee?=
 =?us-ascii?Q?0fmshSsEl5sRoTgmDBepJ+zpZCvkScyYzEUAimH6Uv15r1C/EXJaP7W614Q5?=
 =?us-ascii?Q?l5/1fRpdzOipKtTpmYg2rEL+tKdkpwe0Kh1Jxs9ZepftujDl7mtXf+pFT/zh?=
 =?us-ascii?Q?OrjcPIyoQ4upCRjXnwwmTj2x3rf9Z15rFnffqPISPsnmRWvG6ki3M+dxw1fI?=
 =?us-ascii?Q?/PHKHAXEGr6/VmYKS5j3Sdi/94At2NGNdRxUaSCVwoiE0ZCfjADAYnJ/k+KI?=
 =?us-ascii?Q?QHLa/+6DtnFZDJtLqV6p5j8BKntLIGvv87xKonilePxKoAS/AEFKu0M4oVdP?=
 =?us-ascii?Q?XX6pocbH7gYNg0A39S/RvNpP4s4mfaz59DULnP8R6Y5TA6Q6zGD9RZ0N8+XP?=
 =?us-ascii?Q?4AQqJRuoSgc9ezrZ4wJNfjxp1JbzC5kyqSWZWU67Z00YZDeovwuX9nECas8w?=
 =?us-ascii?Q?v3sJ4cIhrZhLCzHyxho4/cAcMzySW7z75S1QE+mabu9NNRVF3NajnLHL3oMy?=
 =?us-ascii?Q?9kb0pWzubSOdxeffWIPjd46zSY5fu2R8CYwCl/8cuiiB9z85FOsr/pIXRMXA?=
 =?us-ascii?Q?HdpZnm1vuFWYS6htH2kD0gY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdcf588-e8a9-4b03-8c5d-08d9c12fc86c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 07:35:22.5441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYx6PULQXfrsN0cudvpbIa5VNQ6oK/ZBBVr4083K0JVDpkQN98XE3kF2qDjtjnXz3sEwX8t6NEkijSaiKjkB/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2794
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 01:59:35AM +0800, Rafael J. Wysocki wrote:
> On Tue, Nov 30, 2021 at 1:37 PM Huang Rui <ray.huang@amd.com> wrote:
> >
> > amd-pstate is the AMD CPU performance scaling driver that introduces a
> > new CPU frequency control mechanism on AMD Zen based CPU series in Linux
> > kernel. The new mechanism is based on Collaborative processor
> > performance control (CPPC) which is finer grain frequency management
> > than legacy ACPI hardware P-States. Current AMD CPU platforms are using
> > the ACPI P-states driver to manage CPU frequency and clocks with
> > switching only in 3 P-states. AMD P-States is to replace the ACPI
> > P-states controls, allows a flexible, low-latency interface for the
> > Linux kernel to directly communicate the performance hints to hardware.
> >
> > "amd-pstate" leverages the Linux kernel governors such as *schedutil*,
> > *ondemand*, etc. to manage the performance hints which are provided by CPPC
> > hardware functionality. The first version for amd-pstate is to support one
> > of the Zen3 processors, and we will support more in future after we verify
> > the hardware and SBIOS functionalities.
> >
> > There are two types of hardware implementations for amd-pstate: one is full
> > MSR support and another is shared memory support. It can use
> > X86_FEATURE_CPPC feature flag to distinguish the different types.
> >
> > Using the new AMD P-States method + kernel governors (*schedutil*,
> > *ondemand*, ...) to manage the frequency update is the most appropriate
> > bridge between AMD Zen based hardware processor and Linux kernel, the
> > processor is able to adjust to the most efficiency frequency according to
> > the kernel scheduler loading.
> >
> > Please check the detailed CPU feature and MSR register description in
> > Processor Programming Reference (PPR) for AMD Family 19h Model 51h,
> > Revision A1 Processors:
> >
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F56569-A1-PUB.zip&amp;data=04%7C01%7Cray.huang%40amd.com%7C271b150291c64c7e3db808d9c0bdd9b0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637752744522397473%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=VlOP2McSZlC11NJSJoVB74alfUqpdyDmoaAgT8Vl2Qc%3D&amp;reserved=0
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/cpufreq/Kconfig.x86  |  17 ++
> >  drivers/cpufreq/Makefile     |   1 +
> >  drivers/cpufreq/amd-pstate.c | 398 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 416 insertions(+)
> >  create mode 100644 drivers/cpufreq/amd-pstate.c
> >
> > diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> > index 92701a18bdd9..21837eb1698b 100644
> > --- a/drivers/cpufreq/Kconfig.x86
> > +++ b/drivers/cpufreq/Kconfig.x86
> > @@ -34,6 +34,23 @@ config X86_PCC_CPUFREQ
> >
> >           If in doubt, say N.
> >
> > +config X86_AMD_PSTATE
> > +       tristate "AMD Processor P-State driver"
> > +       depends on X86
> > +       select ACPI_PROCESSOR if ACPI
> > +       select ACPI_CPPC_LIB if X86_64 && ACPI
> > +       select CPU_FREQ_GOV_SCHEDUTIL if SMP
> > +       help
> > +         This driver adds a CPUFreq driver which utilizes a fine grain
> > +         processor performance frequency control range instead of legacy
> > +         performance levels. This driver supports the AMD processors with
> > +         _CPC object in the SBIOS.
> 
> Well, _CPC needs to be present in the ACPI tables of the system.

Yes, will modify the words.

> 
> > +
> > +         For details, take a look at:
> > +         <file:Documentation/admin-guide/pm/amd-pstate.rst>.
> > +
> > +         If in doubt, say N.
> > +
> >  config X86_ACPI_CPUFREQ
> >         tristate "ACPI Processor P-States driver"
> >         depends on ACPI_PROCESSOR
> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > index 48ee5859030c..c8d307010922 100644
> > --- a/drivers/cpufreq/Makefile
> > +++ b/drivers/cpufreq/Makefile
> > @@ -25,6 +25,7 @@ obj-$(CONFIG_CPUFREQ_DT_PLATDEV)      += cpufreq-dt-platdev.o
> >  # speedstep-* is preferred over p4-clockmod.
> >
> >  obj-$(CONFIG_X86_ACPI_CPUFREQ)         += acpi-cpufreq.o
> > +obj-$(CONFIG_X86_AMD_PSTATE)           += amd-pstate.o
> >  obj-$(CONFIG_X86_POWERNOW_K8)          += powernow-k8.o
> >  obj-$(CONFIG_X86_PCC_CPUFREQ)          += pcc-cpufreq.o
> >  obj-$(CONFIG_X86_POWERNOW_K6)          += powernow-k6.o
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > new file mode 100644
> > index 000000000000..20ffbc30118f
> > --- /dev/null
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -0,0 +1,398 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * amd-pstate.c - AMD Processor P-state Frequency Driver
> > + *
> > + * Copyright (C) 2021 Advanced Micro Devices, Inc. All Rights Reserved.
> > + *
> > + * Author: Huang Rui <ray.huang@amd.com>
> 
> Given the lack of other documentation, it would be nice to provide at
> least a brief description of the driver here.

Fine, will add the description in V6.

> 
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/smp.h>
> > +#include <linux/sched.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/compiler.h>
> > +#include <linux/dmi.h>
> > +#include <linux/slab.h>
> > +#include <linux/acpi.h>
> > +#include <linux/io.h>
> > +#include <linux/delay.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/static_call.h>
> > +
> > +#include <acpi/processor.h>
> > +#include <acpi/cppc_acpi.h>
> > +
> > +#include <asm/msr.h>
> > +#include <asm/processor.h>
> > +#include <asm/cpufeature.h>
> > +#include <asm/cpu_device_id.h>
> > +
> > +#define AMD_PSTATE_TRANSITION_LATENCY  0x20000
> > +#define AMD_PSTATE_TRANSITION_DELAY    500
> > +
> > +static struct cpufreq_driver amd_pstate_driver;
> > +
> > +struct amd_cpudata {
> > +       int     cpu;
> > +
> > +       struct freq_qos_request req[2];
> > +
> > +       u64     cppc_req_cached;
> > +
> > +       u32     highest_perf;
> > +       u32     nominal_perf;
> > +       u32     lowest_nonlinear_perf;
> > +       u32     lowest_perf;
> > +
> > +       u32     max_freq;
> > +       u32     min_freq;
> > +       u32     nominal_freq;
> > +       u32     lowest_nonlinear_freq;
> > +};
> 
> Please describe the fields of this structure, preferably in a kerneldoc comment.

OK.

> 
> > +
> > +static inline int pstate_enable(bool enable)
> > +{
> > +       return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
> > +}
> > +
> > +DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
> 
> Why do you need a static call here?
> 
> It doesn't get updated anywhere below.

Ah, the update behavior is defined in the following patch 8 (shared memory
support). Sorry to make you confused.

> 
> > +
> > +static inline int amd_pstate_enable(bool enable)
> > +{
> > +       return static_call(amd_pstate_enable)(enable);
> > +}
> > +
> > +static int pstate_init_perf(struct amd_cpudata *cpudata)
> > +{
> > +       u64 cap1;
> > +
> > +       int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
> > +                                    &cap1);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /*
> > +        * TODO: Introduce AMD specific power feature.
> > +        *
> > +        * CPPC entry doesn't indicate the highest performance in some ASICs.
> > +        */
> > +       WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
> > +
> > +       WRITE_ONCE(cpudata->nominal_perf, CAP1_NOMINAL_PERF(cap1));
> > +       WRITE_ONCE(cpudata->lowest_nonlinear_perf, CAP1_LOWNONLIN_PERF(cap1));
> > +       WRITE_ONCE(cpudata->lowest_perf, CAP1_LOWEST_PERF(cap1));
> > +
> > +       return 0;
> > +}
> > +
> > +DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
> 
> And same here.
> 
> > +
> > +static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
> > +{
> > +       return static_call(amd_pstate_init_perf)(cpudata);
> > +}
> > +
> > +static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> > +                              u32 des_perf, u32 max_perf, bool fast_switch)
> > +{
> > +       if (fast_switch)
> > +               wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
> > +       else
> > +               wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> > +                             READ_ONCE(cpudata->cppc_req_cached));
> > +}
> > +
> > +DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
> 
> Same here.
> 
> > +
> > +static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
> > +                                         u32 min_perf, u32 des_perf,
> > +                                         u32 max_perf, bool fast_switch)
> > +{
> > +       static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
> > +                                           max_perf, fast_switch);
> > +}
> > +
> > +static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
> > +                             u32 des_perf, u32 max_perf, bool fast_switch)
> > +{
> > +       u64 prev = READ_ONCE(cpudata->cppc_req_cached);
> > +       u64 value = prev;
> > +
> > +       value &= ~REQ_MIN_PERF(~0L);
> > +       value |= REQ_MIN_PERF(min_perf);
> > +
> > +       value &= ~REQ_DES_PERF(~0L);
> > +       value |= REQ_DES_PERF(des_perf);
> > +
> > +       value &= ~REQ_MAX_PERF(~0L);
> > +       value |= REQ_MAX_PERF(max_perf);
> > +
> > +       if (value == prev)
> > +               return;
> > +
> > +       WRITE_ONCE(cpudata->cppc_req_cached, value);
> > +
> > +       amd_pstate_update_perf(cpudata, min_perf, des_perf,
> > +                              max_perf, fast_switch);
> > +}
> > +
> > +static int amd_pstate_verify(struct cpufreq_policy_data *policy)
> > +{
> > +       cpufreq_verify_within_cpu_limits(policy);
> > +
> > +       return 0;
> > +}
> > +
> > +static int amd_pstate_target(struct cpufreq_policy *policy,
> > +                            unsigned int target_freq,
> > +                            unsigned int relation)
> > +{
> > +       struct cpufreq_freqs freqs;
> > +       struct amd_cpudata *cpudata = policy->driver_data;
> > +       unsigned long max_perf, min_perf, des_perf, cap_perf;
> > +
> > +       if (!cpudata->max_freq)
> > +               return -ENODEV;
> > +
> > +       cap_perf = READ_ONCE(cpudata->highest_perf);
> > +       min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> > +       max_perf = cap_perf;
> > +
> > +       freqs.old = policy->cur;
> > +       freqs.new = target_freq;
> > +
> > +       des_perf = DIV_ROUND_CLOSEST(target_freq * cap_perf,
> > +                                    cpudata->max_freq);
> > +
> > +       cpufreq_freq_transition_begin(policy, &freqs);
> > +       amd_pstate_update(cpudata, min_perf, des_perf,
> > +                         max_perf, false);
> > +       cpufreq_freq_transition_end(policy, &freqs, false);
> > +
> > +       return 0;
> > +}
> > +
> > +static int amd_get_min_freq(struct amd_cpudata *cpudata)
> > +{
> > +       struct cppc_perf_caps cppc_perf;
> > +
> > +       int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Switch to khz */
> > +       return cppc_perf.lowest_freq * 1000;
> > +}
> > +
> > +static int amd_get_max_freq(struct amd_cpudata *cpudata)
> > +{
> > +       struct cppc_perf_caps cppc_perf;
> > +       u32 max_perf, max_freq, nominal_freq, nominal_perf;
> > +       u64 boost_ratio;
> > +
> > +       int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > +       if (ret)
> > +               return ret;
> > +
> > +       nominal_freq = cppc_perf.nominal_freq;
> > +       nominal_perf = READ_ONCE(cpudata->nominal_perf);
> > +       max_perf = READ_ONCE(cpudata->highest_perf);
> > +
> > +       boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
> > +                             nominal_perf);
> > +
> > +       max_freq = nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT;
> > +
> > +       /* Switch to khz */
> > +       return max_freq * 1000;
> > +}
> > +
> > +static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
> > +{
> > +       struct cppc_perf_caps cppc_perf;
> > +
> > +       int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Switch to khz */
> > +       return cppc_perf.nominal_freq * 1000;
> > +}
> > +
> > +static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
> > +{
> > +       struct cppc_perf_caps cppc_perf;
> > +       u32 lowest_nonlinear_freq, lowest_nonlinear_perf,
> > +           nominal_freq, nominal_perf;
> > +       u64 lowest_nonlinear_ratio;
> > +
> > +       int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > +       if (ret)
> > +               return ret;
> > +
> > +       nominal_freq = cppc_perf.nominal_freq;
> > +       nominal_perf = READ_ONCE(cpudata->nominal_perf);
> > +
> > +       lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
> > +
> > +       lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
> > +                                        nominal_perf);
> > +
> > +       lowest_nonlinear_freq = nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT;
> > +
> > +       /* Switch to khz */
> > +       return lowest_nonlinear_freq * 1000;
> > +}
> > +
> > +static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
> > +{
> > +       int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> > +       struct device *dev;
> > +       struct amd_cpudata *cpudata;
> > +
> > +       dev = get_cpu_device(policy->cpu);
> > +       if (!dev)
> > +               return -ENODEV;
> > +
> > +       cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
> > +       if (!cpudata)
> > +               return -ENOMEM;
> > +
> > +       cpudata->cpu = policy->cpu;
> > +
> > +       ret = amd_pstate_init_perf(cpudata);
> > +       if (ret)
> > +               goto free_cpudata1;
> > +
> > +       min_freq = amd_get_min_freq(cpudata);
> > +       max_freq = amd_get_max_freq(cpudata);
> > +       nominal_freq = amd_get_nominal_freq(cpudata);
> > +       lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
> > +
> > +       if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> > +               dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
> > +                       min_freq, max_freq);
> > +               ret = -EINVAL;
> > +               goto free_cpudata1;
> > +       }
> > +
> > +       policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
> > +       policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
> > +
> > +       policy->min = min_freq;
> > +       policy->max = max_freq;
> > +
> > +       policy->cpuinfo.min_freq = min_freq;
> > +       policy->cpuinfo.max_freq = max_freq;
> > +
> > +       /* It will be updated by governor */
> > +       policy->cur = policy->cpuinfo.min_freq;
> 
> The freq_qos requests below are never updated in this file.  What are they for?

The freq_qos requests will be updated while we set boost disabled or
enabled in patch 10. Sorry to make you confused again. Should I move the
freq_qos requests implementation into patch 10 as well?

Thanks,
Ray

> 
> > +
> > +       ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
> > +                                  FREQ_QOS_MIN, policy->cpuinfo.min_freq);
> > +       if (ret < 0) {
> > +               dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
> > +               goto free_cpudata1;
> > +       }
> > +
> > +       ret = freq_qos_add_request(&policy->constraints, &cpudata->req[1],
> > +                                  FREQ_QOS_MAX, policy->cpuinfo.max_freq);
> > +       if (ret < 0) {
> > +               dev_err(dev, "Failed to add max-freq constraint (%d)\n", ret);
> > +               goto free_cpudata2;
> > +       }
> > +
> > +       /* Initial processor data capability frequencies */
> > +       cpudata->max_freq = max_freq;
> > +       cpudata->min_freq = min_freq;
> > +       cpudata->nominal_freq = nominal_freq;
> > +       cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
> > +
> > +       policy->driver_data = cpudata;
> > +
> > +       return 0;
> > +
> > +free_cpudata2:
> > +       freq_qos_remove_request(&cpudata->req[0]);
> > +free_cpudata1:
> > +       kfree(cpudata);
> > +       return ret;
> > +}
> > +
> > +static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
> > +{
> > +       struct amd_cpudata *cpudata;
> > +
> > +       cpudata = policy->driver_data;
> > +
> > +       freq_qos_remove_request(&cpudata->req[1]);
> > +       freq_qos_remove_request(&cpudata->req[0]);
> > +       kfree(cpudata);
> > +
> > +       return 0;
> > +}
> > +
> > +static struct cpufreq_driver amd_pstate_driver = {
> > +       .flags          = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
> > +       .verify         = amd_pstate_verify,
> > +       .target         = amd_pstate_target,
> > +       .init           = amd_pstate_cpu_init,
> > +       .exit           = amd_pstate_cpu_exit,
> > +       .name           = "amd-pstate",
> > +};
> > +
> > +static int __init amd_pstate_init(void)
> > +{
> > +       int ret;
> > +
> > +       if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> > +               return -ENODEV;
> > +
> > +       if (!acpi_cpc_valid()) {
> > +               pr_debug("the _CPC object is not present in SBIOS\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       /* don't keep reloading if cpufreq_driver exists */
> > +       if (cpufreq_get_current_driver())
> > +               return -EEXIST;
> > +
> > +       /* capability check */
> > +       if (!boot_cpu_has(X86_FEATURE_CPPC)) {
> > +               pr_debug("AMD CPPC MSR based functionality is not supported\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       /* enable amd pstate feature */
> > +       ret = amd_pstate_enable(true);
> > +       if (ret) {
> > +               pr_err("failed to enable amd-pstate with return %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       ret = cpufreq_register_driver(&amd_pstate_driver);
> > +       if (ret)
> > +               pr_err("failed to register amd_pstate_driver with return %d\n",
> > +                      ret);
> > +
> > +       return ret;
> > +}
> > +
> > +static void __exit amd_pstate_exit(void)
> > +{
> > +       cpufreq_unregister_driver(&amd_pstate_driver);
> > +
> > +       amd_pstate_enable(false);
> > +}
> > +
> > +module_init(amd_pstate_init);
> > +module_exit(amd_pstate_exit);
> > +
> > +MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
> > +MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.25.1
> >
