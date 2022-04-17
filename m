Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173A250481B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 16:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbiDQO5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 10:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDQO5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 10:57:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2D39FD5;
        Sun, 17 Apr 2022 07:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj/tqtcFcWkXxqdKSbx/+0UU4qf+PUFjCjk4Q191XoK3GH0Tj6+B4j9w4O4oV0N8E4uxJQMpnYrWRpdbqC/xEeX67IGk+a9qRKsPs5MHAXDRm9KboD47ko8bD1YwNSLXzEChjXdBq601zZ1X61g7LqLtbVBjIdgBUahPfl1WSHR3NyFqN9GZ/bUPJh0XCoBQXh2U1nFE1apZO5B38gjKyPkK1cr3yjj7AcXMDRg8QtoyEtBBUbMUDCXF8TbVixYCAjOX5rTztPfMGx7pH0jkZmSZeUAZAGTCslFHs805hM4uC4EVXx+dsnPwLbJ6vd93GRQmvnvdSPD9zgLMH7SYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6wu55x+mfHCiHDgVJ4D722jvfQnu+ozZI5x2dCTWZc=;
 b=ats9hgoxE9eFoQP11Jk0i32K7Dwt7b2WD0GL5DgnFLglUB241bKTVXeCZJYZGRuRIS6RM6POOzW9WzzwSNyl3L79AlTembXkaPAZnr/RLDA+JzVzvZmd112EN0sSShu8fLjo3Fm8Gk/8nT5N6CJg7yHCtkQB/F0Vw/GuAg1QhulqKHXUrO7EeGkbTJqrvB72w/ZfgIpnKjbo8KVbB+Y/QB0U7Boswf196GgjnIb17rewPctdsxj71uVJq7WZN66HHUZ5NVRlyGLwFlbMz/0xaMldUobBlw1yRpc1LIZ3iGmGtourYU3DDu7huqkZPl23ozg+VPcP/5u46HaYiDkLDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6wu55x+mfHCiHDgVJ4D722jvfQnu+ozZI5x2dCTWZc=;
 b=4uUJLNnr0/hkXgtDqHT06FhCKvHqHG3SMnxo/snq2smJNVYZDRGrV1ADcnZm3XAwoAHf84krj+2zsA2JvCtyOb+Y6X6LU/R2NdFrI80/rF2Xc/hX5sePpF8JjAHxsR7GmuN7XgArpw2WWrl8tBbJZygrrZD5UtGGX3zrAERxXcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SJ0PR12MB5424.namprd12.prod.outlook.com (2603:10b6:a03:300::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Sun, 17 Apr
 2022 14:54:40 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2c60:61b2:4a7c:2d7e]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2c60:61b2:4a7c:2d7e%5]) with mapi id 15.20.5164.025; Sun, 17 Apr 2022
 14:54:37 +0000
Date:   Sun, 17 Apr 2022 22:54:15 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
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
Subject: Re: [PATCH 3/3] selftests: cpufreq: Add amd_pstate_testmod kernel
 module for testing
Message-ID: <YlwqF9fu/1yxrPdf@amd.com>
References: <20220413090510.4039589-1-li.meng@amd.com>
 <20220413090510.4039589-4-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413090510.4039589-4-li.meng@amd.com>
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fd2a6d5-fdb8-4da3-13b7-08da20823149
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5424:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB542471F9D82573A8C67415CBECF09@SJ0PR12MB5424.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lsRl0q+duDCTnlwHmv0+ctSuAjnnEeonYm/mP1iNFuCBHyxDi6BzM2KrQyQnfT/rM9hWjT46+egxWw4j+bDjUP3nXPJs47L0EztFf9bNRSLfMhq/TY5tSvvVvTSebMv8Vo3lFiGyrIAGOsxvgy18ZvBsmiSObI0SCysAbRykmmyR0ggFT47vt7FnerJYduHbjpUgtErfIQRJfrzQcKr8DGqZBoN2wttK3npiWSFqpZnzO79+0MuTn4kp3FNpnUcd/xiDbTwOl2z7xOlqtR2owQVLiqj3tvHAZQetEhsjmDW5WhLdiVogsS8FCXyrR64GYiP/XWpbnlM0cWDyBk1lBTjDl9/vtq7TpJDBWvve0v4WYpkNbZcgIlLFZcJwyLewLrk5S08zeFjweIrI3IjjLzcZRJne/gVaagAzRpd+2LHDkp3Qyrdt5s2TDbjwxxCpwBbH3oNvN6N/V1DZsatB4bGnkBarprwYCquvoF1jg62tV1HFbEi1lPtlXqPZWd8CfGdsQa2w5S9oeBzaHfhiuaR3dFPkX1Or7108U1GHOwTiJDZUKlznh5F4I891xKcMrD/lT8eEfk0UlaQCoOEvSprnE+HMP50PhbWRpw+C3GLeERU0LHpKmkNEe2/1eh2D2in6jeJjXH+1Z5BE6FDBY7Gs2c7Z3txtqKpA2UBuC/3dsVKN67VQcUf8oEYuEm7Si3OLITYW2+I316haVGMBbFLLWNKmkoMx46hUd/iyrjU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(83380400001)(6512007)(6636002)(66946007)(66476007)(186003)(36756003)(54906003)(37006003)(2616005)(26005)(316002)(86362001)(30864003)(4326008)(38100700002)(6862004)(66556008)(2906002)(6506007)(966005)(6486002)(508600001)(8936002)(5660300002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ts0ngGC4BcUQA0f4WtWDJKcAqVYva0Ku/ordKmzwgJjq7NUWa1Tggs0gng1g?=
 =?us-ascii?Q?tKkxCuC5JSJESWbAHujhXv0LFDxF/kIuata2FvBtgIaj4SjuXmGDy89PhF8L?=
 =?us-ascii?Q?QmLz7oNmlE14SpTDLDbmaSf4Z6mNAUK/OnOzqsew1JthOU27SB7uVrrsnmqz?=
 =?us-ascii?Q?a+FdEzUFpemR83buOsQlCpYHMDxAn3x8/cRqeTiIO1aKwB3c70JZIVBFMx9/?=
 =?us-ascii?Q?Xz+D9Q83IT9lUMB9RHLTtvj2BG4xqfR3JJwwMaeSoqwELl7yyUsQqyOdznGe?=
 =?us-ascii?Q?bKgFJcsjKkdUWz/lOcEC71dOWY+UfZ7JARdSIXeuCbVsM/C8fxizxlogEvdX?=
 =?us-ascii?Q?5DX+pxeU7pgxIVxGQa17bE0+r0+3o8VpjjiQXb5YHK3f8SE1A5hY7jELF7ce?=
 =?us-ascii?Q?+S7jBMyQaig88f3dPqSrgBzBZNd8U+hvlSiFO3y9k6RzI1xV684sfd3x2aSl?=
 =?us-ascii?Q?3qjm9IXKA8QbH34hEa4ESXTv3LdNCbDhg48byooJVXPAA9OqRh6Klp+81jmN?=
 =?us-ascii?Q?wxapkashqwBu3ao13XGAkokQxpdK2Ra61luBjZdP55Zsxo8FJws7R/je6YtB?=
 =?us-ascii?Q?K1s78j3p7TPhtpldKzfMFu4DYDaCW76thuiP1SO0KBQrE3AHlbhvOn9Bk0Za?=
 =?us-ascii?Q?yD781kK2QnlTT2qVKb2xQvsQKpGzS7jXVhB+gzAE9/Z5rbAQTibWZ2Fms2vH?=
 =?us-ascii?Q?7eHFVGU6EbZZnBNRyM7lROK0MK2Avmwj7GHGzSCNt5dWciZb5DHW8dTCnxV/?=
 =?us-ascii?Q?SMTKevh490ayCsqT3Z4KbI7gyn9hHuurnzTioGfPW1YVBDY3+4SlM52zI3sA?=
 =?us-ascii?Q?T7MumlROnmze6Od9GvBvCvrKDqMbpPlXNYsIgmHnbWZRPU7Au0jRoISkyA8q?=
 =?us-ascii?Q?6sCXWC05wlkWgG4Wy8SeBvbBvALHzshdK8Vk78+u+m2s7rEuC5zLwYirHTbv?=
 =?us-ascii?Q?GRRygOTFMgJhUtdPZKM41QETFR2uenPW3KZo9QXrcME0SiDCZh2HL3lWBXcm?=
 =?us-ascii?Q?TPoUh4jok2gBeolE3Al9hq3pklTJT3TXKcR/goRbR+nw/eR7s9fnJirYMufd?=
 =?us-ascii?Q?wiaJTVymzWjDwlh5c4eccPL3S1lVpR2IjINppIo9pouRqYLYQsSpXWcdAcZf?=
 =?us-ascii?Q?mNkrWUNGBHxHW3zte4b1RgJLjPzvf6/wHIZ9Lw0ncYiESmjhJKMuszxV9iXN?=
 =?us-ascii?Q?yRqrJa/RD6xXql8EhpbvzeE18mlndIbgmm7/b0qyyNzajFr/Zqfi02gwJdld?=
 =?us-ascii?Q?093oD30GvMDTN6z1E+pyzN5qGKOwKt6dqA/7s+llrosjNaoPF+sXgpN3MPs5?=
 =?us-ascii?Q?jk5vB1TRxgPcGqDZstqKqJsiOIo9cYwRilhKxsahwqHY3wXACNk83XFOlK8l?=
 =?us-ascii?Q?COAwXeKyO12ygZE7KLY+oMHxP0OpKnXL6iDgbO+hfcujbfj5+a2EOjpilo6b?=
 =?us-ascii?Q?nJ7VvtYmGBHrVVr+TTTnGbCrLBBATXN7HeKzS53OdO3dOjg5ZVauAB6lQJfb?=
 =?us-ascii?Q?nGbzAaqYzV75byM6TJkpRNZe34T8FO9U58tnlhTCK8gDRliJPNx6LJOch9pl?=
 =?us-ascii?Q?vT93/9BCd0FL1bvqQuQSf75GUUnnp4CFm0fk0QjuVHPe5sbHYemsB7l4uou8?=
 =?us-ascii?Q?JhlqGLj9FDHkCQMXHqfQXsErmXmxHkzLkzVuLS9eZhVOY4juor/yrrKGFQiP?=
 =?us-ascii?Q?/sIuscYz6okZuJwgoedz1VeTs/PypC5FWpcrXwcaFdrkx4M/k1/jkKeO+qHx?=
 =?us-ascii?Q?l5wBixvN4w=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd2a6d5-fdb8-4da3-13b7-08da20823149
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2022 14:54:37.5743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRA7z93OAWb4mst5FMkNQm/V+xJ/txsNDK0HAWtoXUqTgzbmW+tmSYFAwuhZbVViqWR/hXERyCFju9jw3eYxyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5424
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 05:05:10PM +0800, Meng, Li (Jassmine) wrote:
> Add amd_pstate_testmod module, which is conceptually out-of-tree module and
> provides ways for selftests/cpufreq amd pstate driver to test various
> kernel module-related functionality. This module will be expected by some
> of selftests to be present and loaded.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  .../cpufreq/amd_pstate_testmod/Makefile       |  20 ++
>  .../amd_pstate_testmod/amd_pstate_testmod.c   | 302 ++++++++++++++++++
>  2 files changed, 322 insertions(+)
>  create mode 100644 tools/testing/selftests/cpufreq/amd_pstate_testmod/Makefile
>  create mode 100644 tools/testing/selftests/cpufreq/amd_pstate_testmod/amd_pstate_testmod.c
> 
> diff --git a/tools/testing/selftests/cpufreq/amd_pstate_testmod/Makefile b/tools/testing/selftests/cpufreq/amd_pstate_testmod/Makefile
> new file mode 100644
> index 000000000000..8a5596cb2c18
> --- /dev/null
> +++ b/tools/testing/selftests/cpufreq/amd_pstate_testmod/Makefile
> @@ -0,0 +1,20 @@
> +AMD_PSTATE_TESTMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
> +KDIR ?= $(abspath $(AMD_PSATE_TESTMOD_DIR)/../../../../..)
> +
> +ifeq ($(V),1)
> +Q =
> +else
> +Q = @
> +endif
> +
> +MODULES = amd_pstate_testmod.ko
> +
> +obj-m += amd_pstate_testmod.o
> +CFLAGS_amd_pstate_testmod.o = -I$(src)
> +
> +all:
> +	+$(Q)make -C $(KDIR) M=$(AMD_PSTATE_TESTMOD_DIR) modules
> +
> +clean:
> +	+$(Q)make -C $(KDIR) M=$(AMD_PSTATE_TESTMOD_DIR) clean
> +
> diff --git a/tools/testing/selftests/cpufreq/amd_pstate_testmod/amd_pstate_testmod.c b/tools/testing/selftests/cpufreq/amd_pstate_testmod/amd_pstate_testmod.c
> new file mode 100644
> index 000000000000..a892cecf19da
> --- /dev/null
> +++ b/tools/testing/selftests/cpufreq/amd_pstate_testmod/amd_pstate_testmod.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-1.0-or-later
> +/*
> + * AMD Processor P-state Frequency Driver Unit Test
> + *
> + * Copyright (C) 2022 Advanced Micro Devices, Inc. All Rights Reserved.
> + *
> + * Author: Meng Li <li.meng@amd.com>
> + *

We would like to explain the goal or intention of the AMD P-State Unit Test
module here.

E.X.:

1. The AMD P-State Unit Test can help all users to verify their processor
support (SBIOS/Firmware or Hardware).
2. Kernel can have a basic function test to avoid the kernel regression
during the udpate.
3. We can introduce more functional or performance tests to align the
result together, it will benifit power and performance scale optimization.

> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include "../../kselftest_module.h"
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
> +*/
> +
> +KSTM_MODULE_GLOBALS();
> +
> +/*
> + * Kernel module for testing the AMD P-State unit test
> + */
> +enum aput_result {
> +	APUT_RESULT_PASS,	//0

Let's remove "//" in the comments at whole series.

https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting

> +	APUT_RESULT_FAIL,	//
> +	MAX_APUT_RESULT,
> +};
> +
> +struct aput_struct {
> +	const char *name;
> +	void (*func)(u32 index);
> +	enum aput_result result;
> +};
> +
> +static void aput_x86_vendor(u32 index);
> +static void aput_acpi_cpc(u32 index);
> +static void aput_modprobed_driver(u32 index);
> +static void aput_capability_check(u32 index);
> +static void aput_enable(u32 index);
> +static void aput_init_perf(u32 index);
> +static void aput_support_boost(u32 index);
> +
> +static struct aput_struct aput_cases[] = {
> +	{"x86_vendor",          aput_x86_vendor          },
> +	{"acpi_cpc_valid",      aput_acpi_cpc            },
> +	{"modprobed_driver",    aput_modprobed_driver    },
> +	{"capability_check",    aput_capability_check    },
> +	{"enable",              aput_enable              },
> +	{"init_perf",           aput_init_perf           },
> +	{"support_boost",       aput_support_boost       }
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
> +	filp = filp_open("/sys/module/amd_pstate/parameters/shared_mem", FMODE_PREAD, 0);
> +	if (IS_ERR(filp))
> +	{

We need use

if () {
}

instead of

if ()
{
}

Please use the checkpatch.pl to check your patches.

> +		pr_err("%s Open param file fail! \n", __func__);
> +	}
> +	else
> +	{
> +		ret = kernel_read(filp, &buf, sizeof(buf), &pos);
> +		if (ret < 0)
> +		{
> +			pr_err("%s ret=%ld unable to read from param file! \n", __func__, ret);
> +		}
> +		filp_close(filp, NULL);
> +	}
> +
> +	if ('Y' == *buf)
> +	{
> +		result = true;
> +	}
> +
> +	return (result);
> +}
> +
> +static void aput_x86_vendor(u32 index)
> +{
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +	{
> +		aput_cases[index].result = APUT_RESULT_PASS;
> +	}
> +	else
> +	{
> +		aput_cases[index].result = APUT_RESULT_FAIL;
> +	}
> +}
> +
> +static void aput_acpi_cpc(u32 index)
> +{
> +	if (acpi_cpc_valid())
> +	{
> +		aput_cases[index].result = APUT_RESULT_PASS;
> +	}
> +	else
> +	{
> +		aput_cases[index].result = APUT_RESULT_FAIL;
> +	}
> +}
> +
> +static void aput_modprobed_driver(u32 index)
> +{
> +	if (cpufreq_get_current_driver())
> +	{
> +		aput_cases[index].result = APUT_RESULT_PASS;
> +	}
> +	else
> +	{
> +		aput_cases[index].result = APUT_RESULT_FAIL;
> +	}
> +}
> +
> +static void aput_capability_check(u32 index)
> +{
> +	if (boot_cpu_has(X86_FEATURE_CPPC))
> +	{
> +		aput_cases[index].result = APUT_RESULT_PASS;
> +	}
> +	else
> +	{
> +		//shared memory
> +		if (get_shared_mem())
> +		{
> +			aput_cases[index].result = APUT_RESULT_PASS;
> +		}
> +		else
> +		{
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +		}

I am thinking if the share_mem is not 1, system will fall back to
acpi-cpufreq. And won't modprobe the amd-pstate module. Is this duplicate
with above modprobed test?

> +	}
> +}
> +
> +static void aput_pstate_enable(u32 index)
> +{
> +	int ret = 0;
> +	u64 cppc_enable = 0;
> +
> +	ret = rdmsrl_safe(MSR_AMD_CPPC_ENABLE, &cppc_enable);
> +	if (ret)
> +	{
> +		aput_cases[index].result = APUT_RESULT_FAIL;
> +		pr_err("%s rdmsrl_safe MSR_AMD_CPPC_ENABLE ret=%d is error! \n", __func__, ret);
> +		return;
> +	}
> +	if (cppc_enable)
> +	{
> +		aput_cases[index].result = APUT_RESULT_PASS;
> +	}
> +	else
> +	{
> +		aput_cases[index].result = APUT_RESULT_FAIL;
> +	}
> +}
> +
> +static void aput_enable(u32 index)
> +{
> +	if (get_shared_mem())
> +	{
> +		//not check
> +		aput_cases[index].result = APUT_RESULT_PASS;
> +	}
> +	else
> +	{
> +		aput_pstate_enable(index);
> +	}
> +}
> +
> +static void aput_init_perf(u32 index)

For this test, we should check if the each performance values are
reasonable.

E.X:

highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0

Do we need a similar checking for the CPU frequencies?

> +{
> +	int cpu = 0, ret = 0;
> +	u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
> +	u64 cap1 = 0;
> +	struct cppc_perf_caps cppc_perf;
> +	struct cpufreq_policy *policy = NULL;
> +        struct amd_cpudata *cpudata = NULL;
> +
> +	//get perf
> +	highest_perf = amd_get_highest_perf();
> +
> +	for_each_possible_cpu(cpu)
> +	{
> +		//get amd cpudata
> +		policy = cpufreq_cpu_get(cpu);
> +		if (!policy)
> +			break;
> +		cpudata = policy->driver_data;
> +
> +		if (get_shared_mem())
> +		{
> +			ret = cppc_get_perf_caps(cpu, &cppc_perf);
> +			if (ret)
> +			{
> +				aput_cases[index].result = APUT_RESULT_FAIL;
> +				pr_err("%s cppc_get_perf_caps ret=%d is error! \n", __func__, ret);
> +				return;
> +			}
> +
> +			nominal_perf = cppc_perf.nominal_perf;
> +			lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
> +			lowest_perf = cppc_perf.lowest_perf;
> +		}
> +		else
> +		{
> +			ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
> +			if (ret)
> +			{
> +				aput_cases[index].result = APUT_RESULT_FAIL;
> +				pr_err("%s rdmsrl_safe_on_cpu MSR_AMD_CPPC_CAP1 ret=%d is error! \n", __func__, ret);
> +				return;
> +			}
> +
> +			//get perf from MSR
> +			nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
> +			lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
> +			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
> +		}
> +
> +		//check highest_perf,nominal_perf,lowest_nonlinear_perf
> +		if ((highest_perf != READ_ONCE(cpudata->highest_perf)) ||
> +			(nominal_perf != READ_ONCE(cpudata->nominal_perf)) ||
> +			(lowest_nonlinear_perf != READ_ONCE(cpudata->lowest_nonlinear_perf)) ||
> +			(lowest_perf != READ_ONCE(cpudata->lowest_perf)))
> +		{
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			pr_err("%s cpu%d highest_perf=%d %d nominal_perf=%d %d lowest_nonlinear_perf=%d %d lowest_perf=%d %d are not equal! \n",
> +				__func__, cpu, highest_perf, cpudata->highest_perf,
> +				nominal_perf, cpudata->nominal_perf,
> +				lowest_nonlinear_perf, cpudata->lowest_nonlinear_perf,
> +				lowest_perf, cpudata->lowest_perf);
> +			return;
> +		}
> +	}
> +
> +	aput_cases[index].result = APUT_RESULT_PASS;
> +}
> +
> +static void aput_support_boost(u32 index)
> +{
> +	int cpu = 0;
> +	struct cpufreq_policy *policy = NULL;
> +        struct amd_cpudata *cpudata = NULL;

Please align the space in this line.

Thanks,
Ray

> +
> +	for_each_possible_cpu(cpu)
> +	{
> +		//get amd cpudata
> +		policy = cpufreq_cpu_get(cpu);
> +		if (!policy)
> +			break;
> +		cpudata = policy->driver_data;
> +
> +		if (READ_ONCE(cpudata->boost_supported))
> +		{
> +			aput_cases[index].result = APUT_RESULT_PASS;
> +		}
> +		else
> +		{
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			break;
> +		}
> +	}
> +}
> +
> +static void aput_do_test_case(void)
> +{
> +	u32 i=0, arr_size = ARRAY_SIZE(aput_cases);
> +
> +	for (i = 0; i < arr_size; i++)
> +	{
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
> +KSTM_MODULE_LOADERS(amd_pstate_testmod);
> +MODULE_AUTHOR("Meng Li <li.meng@amd.com>");
> +MODULE_DESCRIPTION("Unit test for AMD P-state driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 
