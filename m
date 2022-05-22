Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B2E530049
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 04:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiEVC1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 22:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiEVC13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 22:27:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AA312627;
        Sat, 21 May 2022 19:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3qvgpjxCMMM/JvNbWHJdlfwFZP39tKHQe1z1HOCuMzkuvBAHp6JpzV//ESKp1D/nkLLktmav0O03UWbKBwa3lkMdLG4tc+GZ7QyHEmEMfe07I2/UxzEvf4CuDjBMVPWGtaMwoE1dXgI+d+dFCAvwNKNirOdpsnZELPK/ESGKfQGI5mZpCL4tKtCpdX1MmDQYE6mB5jJExK3Ss6Tu5+cBAxSOVBBDK7x39zOot4+Rugtzk/jqFDI5ldVkmKbTEePo1lj/XVq0ZULPyc6Hhc8pSGlh7rkVO6F2DE/tGaTSgXdcvWKMOF16ZoWkHnmgLJ0IwOz91hYV51yFdzRtBQ0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCoJeQKRu4YeyQBQv0LIBm0mtq3J6vNzKi4qDpoG1Kg=;
 b=YeBPv6mAchrvwbliBYJ4EEKOI4il1279mxSPOrjJ3z7WqLVa3mMTX3yP18nDSH2DkAp6HN9O47ozkzh+Yufd2/qOEn48Y3mo7BA5zpirn5u6Aypultnx2H+lBdjnkdQVO6mi7+8ORRQtP5Ht/XlWWC3rHCVGv69GZIdZV91nrSMvczJbrIE8T9dqyLWU00BJ/xq3vzSpDt1u0dukO6GMTjAud92w+w39O38Xqom9fOfBsF0+VUNYGHlO0pVLa/uPJlJa6Dyi8lwnFLa4J7Q0OGmjxK4Lh+/f4G53sJ8XjGL3koIJR6ouYqYjXwYGjHPUPiOz8805G9PWdkL9PRqs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCoJeQKRu4YeyQBQv0LIBm0mtq3J6vNzKi4qDpoG1Kg=;
 b=gxkEJHimcw//1/gz5+xboYFW/uWD0tThuSFg8CYvL4th/Pxs3Zj0UOPIoBG0+9+Y/85qT+DwXdi94ylNhtoEkzMSyUy79LtZZJRYwMhKhFbUqhsUUQweeg5JloyDlvBaX4MMI8ORN1bobImctjU6ID8aEG5j1MAcb5cdvj3O6uI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.17; Sun, 22 May 2022 02:27:24 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d%7]) with mapi id 15.20.5273.022; Sun, 22 May 2022
 02:27:24 +0000
Date:   Sun, 22 May 2022 10:27:02 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 2/4] cpufreq: amd-pstate: Add test module for
 amd-pstate driver
Message-ID: <Yomfdmc+bRM0E/ZW@amd.com>
References: <20220519134737.359290-1-li.meng@amd.com>
 <20220519134737.359290-3-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519134737.359290-3-li.meng@amd.com>
X-ClientProxiedBy: HK2PR0401CA0004.apcprd04.prod.outlook.com
 (2603:1096:202:2::14) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1d8297e-374a-4115-3c9c-08da3b9a9b59
X-MS-TrafficTypeDiagnostic: DM4PR12MB6159:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB61594AB92B59B5DBA2AAB6A7ECD59@DM4PR12MB6159.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6T2V3FqfYk7YSqqc3R/udzHLqjnYm57yqlNLYSU0AnXXhPPgh6fv9LXIGb5ykoEl/S2KH/3MAJrNLenmR7w+U3SOcxATDcQpTmTCzfyzY8KwOeZICPFpxoukfYXy3eQhHlKZ7Ndh70yokwBSeM+g/CN+GnYMKDHo4DdxxQc8CVgY84biF2I1QfEg3ybNWHHWokXBzBbvEsEIHt5E2ZiI4pL+Py2b5plZz3hjQyS+Wjyy/BbiojEA4a6DUrEf3owDe3u1N+q9tKNdEYhS8Ya6C5hHTbHdNPdY/cqzKkAb5KgxR+scHB9KEm6j1ge74CcF9oeJLDVF7QU6HaDRaPeWegiTKoOmiQIdws2HHJskYwUXr6JUlu94MgL92sBx0AJW6u3DIMj5BTCrXPBTyq0B9cSv0DDKh7UBxQqF4OKCTxQkA2U182NVdjeZuNaeRlFJo5MEu5AmOa7jCNmvkpge78XM7YfMLudRUIGZDXHwCulV0iHqcMWHEhfIv9zWazaCSAwonBD3TdiHD+rPSaWODg0Lg8KGvW0VOFbOU+OnjUcVE4yu+AWGpXY1P5Tqod3k571GRQETIJQtXmntKGVsOmyzMoekX2l+ugLLJNav4hfwQ7PDE9CNoQKDF08TpLzuYiwLMHGN/mGqew0FYwF0FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(316002)(8676002)(4326008)(6666004)(2906002)(38100700002)(6506007)(86362001)(37006003)(54906003)(6636002)(6862004)(66946007)(66556008)(66476007)(36756003)(8936002)(30864003)(186003)(83380400001)(6512007)(26005)(508600001)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DpVQCWe4E1HkOM1N2knoUt75g1eJLify9BXxIEt0jJY0LdRN9F1y68B4c98C?=
 =?us-ascii?Q?kMt/bx5NAr77iT6IuIZCoGVEr6JccUgILRzTXApOamfhDEO9QbBpG96ZNy4O?=
 =?us-ascii?Q?+fRJ41PHmy/SYxXbRp/KNAQLhKnLcF2ETe09LbHGKb+N2zhRq2syPF0D/YNU?=
 =?us-ascii?Q?WfXv3pAhtpGFzqClPQWwtDKpqcyHSsMSuwfvuk3oszBIXCqs8t/B0A2L3y3y?=
 =?us-ascii?Q?FKgo1g3f8nT67jpdQGUd447RQlNswzOdm3AFN27Yq09i8fRFVnkFSz6GUqo8?=
 =?us-ascii?Q?sZQjMDCA/XdoVTcLNT+cZxtt9lbkpKUTxV8y+y1iWuv7EzHtCTO0toyCL40R?=
 =?us-ascii?Q?N3uI1rDMwcr1rpGcdfgaF7heCJaEGtKGexfY2uMX5NVV13oqJ+B9NglPmwup?=
 =?us-ascii?Q?IGqqjUYQmICHFoYZ1g5wJfz8irtGN8AySV+U4vBmAx8I7h96aHj3DHu+xxfQ?=
 =?us-ascii?Q?Y1vUBRzxs4hLdJPoO0yEQOh7i6OPekNJI/gjUqiyV1R0yYuoLzTMvAcJOQsF?=
 =?us-ascii?Q?5ruEJzePW0SMrhte2A7LcUJWhy4ivv9M+cnd4UtLn9t4B7bPo1Kce43v9X+e?=
 =?us-ascii?Q?eldYC4fG3a9BuKbhpkddS+IESdU/ZXuJGiiMvvMHhO9KPfKLi1H7HqnIDyNE?=
 =?us-ascii?Q?Q2YTQJuYpuiNrhPo1hWAwl/0Yc9awDaqHWh1JT5T33iZD4xD+VoV5csCDfOa?=
 =?us-ascii?Q?f7BB4P7dvI39qEBBrWT0Fl/Xt6apQGkADBK0+BYSBrzlo7pb3GTnjrKlkSb/?=
 =?us-ascii?Q?hpYU0Pe0h7tiw6I+t7xpN1coM8cmRnxu2/btmPxx0/VvbhRqtXL/3rq/60AQ?=
 =?us-ascii?Q?bq4SbEA9hGDpOo1D6t5BTQjAr9jMF0WyjFJKRGxwLB0I/X/5aZwkXbNRjYuQ?=
 =?us-ascii?Q?BmmYtKXY2FUQQXwjzo0+TE3AsZmy7dk1qd5Kr/yH58FCSnfBR3oxcKsE8zrh?=
 =?us-ascii?Q?VNBJ/bAJH5x3B95Eb6pCtB8dlrQhhacMMJDwNVEt4ABz/uRGq4djxZLB9RAA?=
 =?us-ascii?Q?sMpDb9LBh5ysHUjOmwRvjer0ITHn5WBW2epJ/zTz+OghKJYefXoNoB21yvls?=
 =?us-ascii?Q?ofqqIOF0lgh1qo9tHRxjPfB9feyIh/3P36jyRVfYf3xSl7uGOfgELu8Q9ZEg?=
 =?us-ascii?Q?3SSFrDW4bz+fHrUbiumcldJ5ZglNZxPQuLo9Ryum7ELNHOKNBKhJTQjEpc9e?=
 =?us-ascii?Q?p4zsZScJY1+l9vJ8byc8iQBvhdzcm4mYLxsmXQh5hPr0B0OEJiAFlbVxzPGa?=
 =?us-ascii?Q?A06alc/WMp2zfBHxoEFWHIe2xZphx9FTsfmbzZ5USY5ANvb51Rl+7NY4FRxt?=
 =?us-ascii?Q?xYR5unAnjiodXUQnnn/8j4+9ncwSZn0oyItNE2Gp3fZ5r7Qoh+K4ntWw+yK1?=
 =?us-ascii?Q?d3YHH43Avo3lhY09dpp+yCRbYmDeB6oYQ8ACuu2T5B9t30b7fXdwEJfdFnhH?=
 =?us-ascii?Q?9qZPXyMAvhEBTG3mWfPFL9CahzPbXfuHPgb2ElfYaiRhFNzKHhso5B7FY6oM?=
 =?us-ascii?Q?2RszN5gX/+aAS+4AwARi2nYG8BHRLOca9JtA+cRQw+TaPk6V4W1qnpay7FCe?=
 =?us-ascii?Q?xI8QoVquFkAQe757bDpIwlmEx9zXI/s/5wH/W8h7QI5Z740ZJKplkPprEpSk?=
 =?us-ascii?Q?fJAIFundrkIo/cYqBX27n0BarcxW0zNC8Q6+sRwfAHfEBZgvyTubMWvDCkaL?=
 =?us-ascii?Q?521pHQAX9WiB0y0szeT0+7LZT3jwXuZd3ZUthwMEsnAKbWCy/yL/uSFcDNBn?=
 =?us-ascii?Q?atw5wnt0JA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d8297e-374a-4115-3c9c-08da3b9a9b59
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 02:27:24.7571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEEcyjRpFVtboQtJxsGbL07UhKaMlR6NcaNdfqZ5x77P7GuOmI6xIGSzs9IEkoc2sYiqanPLknfu7ioGqntuJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 09:47:35PM +0800, Meng, Li (Jassmine) wrote:
> Add amd-pstate-ut module, which is conceptually out-of-tree module
> and provides ways for selftests/amd-pstate driver to test various
> kernel module-related functionality. This module will be expected by
> some of selftests to be present and loaded.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/Kconfig.x86     |   6 +
>  drivers/cpufreq/Makefile        |   1 +
>  drivers/cpufreq/amd-pstate-ut.c | 278 ++++++++++++++++++++++++++++++++
>  3 files changed, 285 insertions(+)
>  create mode 100644 drivers/cpufreq/amd-pstate-ut.c
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 55516043b656..37ba282cd156 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -51,6 +51,12 @@ config X86_AMD_PSTATE
>  
>  	  If in doubt, say N.
>  
> +config X86_AMD_PSTATE_UT
> +	tristate "selftest for AMD Processor P-State driver"
> +	depends on X86_AMD_PSTATE

I think we won't set X86_AMD_PSTATE as the depends of this module, because
even if the acpi-cpufreq is loaded, this module can test it out and tell
user the result.

ACPI and ACPI_PROCESSOR should the dependencies.

Thanks,
Ray

> +	help
> +	  This kernel module is used for testing. It's safe to say M here.
> +
>  config X86_ACPI_CPUFREQ
>  	tristate "ACPI Processor P-States driver"
>  	depends on ACPI_PROCESSOR
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 285de70af877..49b98c62c5af 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -30,6 +30,7 @@ amd_pstate-y				:= amd-pstate.o amd-pstate-trace.o
>  
>  obj-$(CONFIG_X86_ACPI_CPUFREQ)		+= acpi-cpufreq.o
>  obj-$(CONFIG_X86_AMD_PSTATE)		+= amd_pstate.o
> +obj-$(CONFIG_X86_AMD_PSTATE_UT)		+= amd-pstate-ut.o
>  obj-$(CONFIG_X86_POWERNOW_K8)		+= powernow-k8.o
>  obj-$(CONFIG_X86_PCC_CPUFREQ)		+= pcc-cpufreq.o
>  obj-$(CONFIG_X86_POWERNOW_K6)		+= powernow-k6.o
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> new file mode 100644
> index 000000000000..a510355b804e
> --- /dev/null
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-1.0-or-later
> +/*
> + * AMD Processor P-state Frequency Driver Unit Test
> + *
> + * Copyright (C) 2022 Advanced Micro Devices, Inc. All Rights Reserved.
> + *
> + * Author: Meng Li <li.meng@amd.com>
> + *
> + * The AMD P-State Unit Test is a test module for testing the amd-pstate
> + * driver. 1) It can help all users to verify their processor support
> + * (SBIOS/Firmware or Hardware). 2) Kernel can have a basic function
> + * test to avoid the kernel regression during the update. 3) We can
> + * introduce more functional or performance tests to align the result
> + * together, it will benefit power and performance scale optimization.
> + *
> + * At present, it only implements the basic framework and some simple
> + * test cases. Next, 1) we will add a rst document. 2) we will add more
> + * test cases to improve the depth and coverage of the test.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include "../tools/testing/selftests/kselftest_module.h"
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/fs.h>
> +#include <linux/amd-pstate.h>
> +
> +#include <acpi/cppc_acpi.h>
> +
> +/*
> + * Abbreviations:
> + * aput: used as a shortform for AMD P-State unit test.
> + * It helps to keep variable names smaller, simpler
> + */
> +
> +KSTM_MODULE_GLOBALS();
> +
> +/*
> + * Kernel module for testing the AMD P-State unit test
> + */
> +enum aput_result {
> +	APUT_RESULT_PASS,
> +	APUT_RESULT_FAIL,
> +	MAX_APUT_RESULT,
> +};
> +
> +struct aput_struct {
> +	const char *name;
> +	void (*func)(u32 index);
> +	enum aput_result result;
> +};
> +
> +static void aput_acpi_cpc(u32 index);
> +static void aput_check_enabled(u32 index);
> +static void aput_check_perf(u32 index);
> +static void aput_check_freq(u32 index);
> +
> +static struct aput_struct aput_cases[] = {
> +	{"acpi_cpc_valid",   aput_acpi_cpc         },
> +	{"check_enabled",    aput_check_enabled    },
> +	{"check_perf",       aput_check_perf       },
> +	{"check_freq",       aput_check_freq       }
> +};
> +
> +static bool get_shared_mem(void)
> +{
> +	bool result = false;
> +	char buf[5] = {0};
> +	struct file *filp = NULL;
> +	loff_t pos = 0;
> +	ssize_t ret;
> +
> +	if (!boot_cpu_has(X86_FEATURE_CPPC)) {
> +		filp = filp_open("/sys/module/amd_pstate/parameters/shared_mem", FMODE_PREAD, 0);
> +		if (IS_ERR(filp))
> +			pr_err("%s Open param file fail!\n", __func__);
> +		else {
> +			ret = kernel_read(filp, &buf, sizeof(buf), &pos);
> +			if (ret < 0)
> +				pr_err("%s ret=%ld unable to read from param file!\n",
> +					__func__, ret);
> +			filp_close(filp, NULL);
> +		}
> +
> +		if ('Y' == *buf)
> +			result = true;
> +	}
> +
> +	return result;
> +}
> +
> +static void aput_acpi_cpc(u32 index)
> +{
> +	if (acpi_cpc_valid())
> +		aput_cases[index].result = APUT_RESULT_PASS;
> +	else
> +		aput_cases[index].result = APUT_RESULT_FAIL;
> +}
> +
> +static void aput_pstate_enable(u32 index)
> +{
> +	int ret = 0;
> +	u64 cppc_enable = 0;
> +
> +	ret = rdmsrl_safe(MSR_AMD_CPPC_ENABLE, &cppc_enable);
> +	if (ret) {
> +		aput_cases[index].result = APUT_RESULT_FAIL;
> +		pr_err("%s rdmsrl_safe MSR_AMD_CPPC_ENABLE ret=%d is error!\n", __func__, ret);
> +		return;
> +	}
> +	if (cppc_enable)
> +		aput_cases[index].result = APUT_RESULT_PASS;
> +	else
> +		aput_cases[index].result = APUT_RESULT_FAIL;
> +}
> +
> +/*
> + *Check if enabled amd pstate
> + */
> +static void aput_check_enabled(u32 index)
> +{
> +	if (get_shared_mem())
> +		aput_cases[index].result = APUT_RESULT_PASS;
> +	else
> +		aput_pstate_enable(index);
> +}
> +
> +/*
> + * Check if the each performance values are reasonable.
> + * highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0
> + */
> +static void aput_check_perf(u32 index)
> +{
> +	int cpu = 0, ret = 0;
> +	u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
> +	u64 cap1 = 0;
> +	struct cppc_perf_caps cppc_perf;
> +	struct cpufreq_policy *policy = NULL;
> +	struct amd_cpudata *cpudata = NULL;
> +
> +	highest_perf = amd_get_highest_perf();
> +
> +	for_each_possible_cpu(cpu) {
> +		policy = cpufreq_cpu_get(cpu);
> +		if (!policy)
> +			break;
> +		cpudata = policy->driver_data;
> +
> +		if (get_shared_mem()) {
> +			ret = cppc_get_perf_caps(cpu, &cppc_perf);
> +			if (ret) {
> +				aput_cases[index].result = APUT_RESULT_FAIL;
> +				pr_err("%s cppc_get_perf_caps ret=%d is error!\n", __func__, ret);
> +				return;
> +			}
> +
> +			nominal_perf = cppc_perf.nominal_perf;
> +			lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
> +			lowest_perf = cppc_perf.lowest_perf;
> +		} else {
> +			ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
> +			if (ret) {
> +				aput_cases[index].result = APUT_RESULT_FAIL;
> +				pr_err("%s read CPPC_CAP1 ret=%d is error!\n", __func__, ret);
> +				return;
> +			}
> +
> +			nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
> +			lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
> +			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
> +		}
> +
> +		if ((highest_perf != READ_ONCE(cpudata->highest_perf)) ||
> +			(nominal_perf != READ_ONCE(cpudata->nominal_perf)) ||
> +			(lowest_nonlinear_perf != READ_ONCE(cpudata->lowest_nonlinear_perf)) ||
> +			(lowest_perf != READ_ONCE(cpudata->lowest_perf))) {
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			pr_err("%s cpu%d highest=%d %d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d are not equal!\n",
> +				__func__, cpu, highest_perf, cpudata->highest_perf,
> +				nominal_perf, cpudata->nominal_perf,
> +				lowest_nonlinear_perf, cpudata->lowest_nonlinear_perf,
> +				lowest_perf, cpudata->lowest_perf);
> +			return;
> +		}
> +
> +		if (!((highest_perf >= nominal_perf) &&
> +			(nominal_perf > lowest_nonlinear_perf) &&
> +			(lowest_nonlinear_perf > lowest_perf) &&
> +			(lowest_perf > 0))) {
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			pr_err("%s cpu%d highest=%d nominal=%d lowest_nonlinear=%d lowest=%d have error!\n",
> +				__func__, cpu, highest_perf, nominal_perf,
> +				lowest_nonlinear_perf, lowest_perf);
> +			return;
> +		}
> +	}
> +
> +	aput_cases[index].result = APUT_RESULT_PASS;
> +}
> +
> +/*
> + * Check if the each frequency values are reasonable.
> + * max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0
> + * check max freq when set support boost mode.
> + */
> +static void aput_check_freq(u32 index)
> +{
> +	int cpu = 0;
> +	struct cpufreq_policy *policy = NULL;
> +	struct amd_cpudata *cpudata = NULL;
> +
> +	for_each_possible_cpu(cpu) {
> +		policy = cpufreq_cpu_get(cpu);
> +		if (!policy)
> +			break;
> +		cpudata = policy->driver_data;
> +
> +		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
> +			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
> +			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
> +			(cpudata->min_freq > 0))) {
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			pr_err("%s cpu%d max=%d nominal=%d lowest_nonlinear=%d min=%d have error!\n",
> +				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
> +				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
> +			return;
> +		}
> +
> +		if (cpudata->min_freq != policy->min) {
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			pr_err("%s cpu%d cpudata_min_freq=%d policy_min=%d have error!\n",
> +				__func__, cpu, cpudata->min_freq, policy->min);
> +			return;
> +		}
> +
> +		if (cpudata->boost_supported) {
> +			if ((policy->max == cpudata->max_freq) ||
> +					(policy->max == cpudata->nominal_freq))
> +				aput_cases[index].result = APUT_RESULT_PASS;
> +			else {
> +				aput_cases[index].result = APUT_RESULT_FAIL;
> +				pr_err("%s cpu%d policy_max=%d cpu_max=%d cpu_nominal=%d have error!\n",
> +					__func__, cpu, policy->max, cpudata->max_freq,
> +					cpudata->nominal_freq);
> +				return;
> +			}
> +		} else {
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			pr_err("%s cpu%d not support boost!\n", __func__, cpu);
> +			return;
> +		}
> +	}
> +}
> +
> +static void aput_do_test_case(void)
> +{
> +	u32 i = 0, arr_size = ARRAY_SIZE(aput_cases);
> +
> +	for (i = 0; i < arr_size; i++) {
> +		pr_info("****** Begin %-5d\t %-20s\t ******\n", i+1, aput_cases[i].name);
> +		aput_cases[i].func(i);
> +		KSTM_CHECK_ZERO(aput_cases[i].result);
> +		pr_info("****** End   %-5d\t %-20s\t ******\n", i+1, aput_cases[i].name);
> +	}
> +}
> +
> +static void __init selftest(void)
> +{
> +	aput_do_test_case();
> +}
> +
> +KSTM_MODULE_LOADERS(amd_pstate_ut);
> +MODULE_AUTHOR("Meng Li <li.meng@amd.com>");
> +MODULE_DESCRIPTION("Unit test for AMD P-state driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 
