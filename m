Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CC7512CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiD1HaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245180AbiD1H3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:29:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48554340C9;
        Thu, 28 Apr 2022 00:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRahlikh+uq0a1AiOS0yfmSN7HRVALLN/CR46vdB2TBp+uVN6Wrhcq3zL6rZSsYOI8+l7JJtr9hbAHqlZHdVjlecPMorBl6UoyY7g4njS9JNuNl5fGMbp1JQNLFYzWcZmBsHvcoxElOeN85x4jxxh3xABZX8QgluKJ0ejaRZO2IQuy+nX9pEmix9N8fdexJuJX9lOIqEVKrjjyU1hXCf4duz6H0/XE+bpENtDp+xm4cIKGh/cJubePj5hJL1HZjmCAjLSyyjAOoIcoVLPiJhVzfBRtwT7Ofi9y/98DOeb7itn6EYIURcOuVj3TfAHUtQnY5knsryjbWVXanHgDW10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89ZQvHgCuj6D66H3OVa/vLcXphoCzHwXSUp43G6Jh7M=;
 b=XGyCX4uGdniwxIQRpUu5jgkHnXx5E2G8SSxwTqMqtV3dpeIuusHW3vYFXE3/LhNPvXGiu/YGho9oP6JXXWucZpRmgvxoVg9JAt2Igbs1TB1i8m5ypdyOKWj0c60GhZXDGAQ8XE0ZURq6x3wAXhlL+01m6qtF+yfv8m0kavso/X2lXw4NdX++8aTb7C26peOxH3HO2DnniIMvVPKO62wCXA7R+H96wfQz57nIg+gO1MegTsMhouyZi/JFpLOc6SSCFfErQWPGom++CQZzXmSh5swiRAFutrCQymDWvFmOt7D000kG6VwYRX+Q1WYs6LfZ7gz1zCEB5iDeCBdNaA/4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89ZQvHgCuj6D66H3OVa/vLcXphoCzHwXSUp43G6Jh7M=;
 b=HRMuB0S0CVXZaHKn5ii9ripjjyk0nL34pVkWWs9CLKtSQlixSe4hLR0svNXHVEOUyQEkA0KVyvch6n0EMLE88Mo9w6ksXI9cTPh5QOdWrM0oRaHTTFds4Fj+GTIYDJNd8aTaG5cAGw3b58ZBR4GmQJ2pEY7q2euxJq4RSnM3Ajw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 CH2PR12MB4908.namprd12.prod.outlook.com (2603:10b6:610:6b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Thu, 28 Apr 2022 07:26:32 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d%7]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 07:26:32 +0000
Date:   Thu, 28 Apr 2022 15:25:51 +0800
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
Subject: Re: [PATCH V4 1/3] cpufreq: amd-pstate: Expose struct amd_cpudata
Message-ID: <YmpBf45Dkku8iSkb@amd.com>
References: <20220427135315.3447550-1-li.meng@amd.com>
 <20220427135315.3447550-2-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427135315.3447550-2-li.meng@amd.com>
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74f2ece2-4232-4f58-9f33-08da28e86958
X-MS-TrafficTypeDiagnostic: CH2PR12MB4908:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4908B0C895B1B81E30800801ECFD9@CH2PR12MB4908.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I55GIgJvbuwJqVv8AxvVoAwDyez0/0nJDNn31gKzBCV09P9nhcwtfCurJKM7rnW0BKm0ClPZYeKBsr0kKyoAPJQ2Rj1xFY62vQsiNKzXT1eJkvlVm0+UCw1YWwRw/mJ3OcdRgt14Ra1Odiz3ExlQVq5Q/+mrXmwYnNSj0B4DEuwCKaJZZtGe2/QpX6Qv/gORJd62ctnvN4eGg6NrfRrww8VxbIzLqHfMoXsqfwg6giVCQHQZSlOEn8tSesnprJ3B+OGgoAOjC1Z9IiYoGFXgGg5drhaMhWJ3nxbhnHXlB1JD0hh5f3yNCCNL9ImhMWpIXO4k0UNap5ZEO9hhVLxwN9ZTlXKQ2dTb2dqC9uqg5X+3Jw9b/UmbOThVdlVtUJPKmehxtZ+6rOK+RnLOw64ASCKGA7fmyeRDI76yWloNdHrFj/YJ3J9OcDmXFY3wCJGMiBYP/z9JnYPB1wC15t9EEhl7bT5hoxCEMMiiHQF3HbHz2734E+mwQBSq4x6vaZnieCDTF3AWZ5Mgre9ythgJuDIqxhqIt3sM1GCZC7wxmQ7rHsFwWNaur+7wjbZYZBnVHOu6WcO9VZS799p+501eZaeKZgovsxIicPAGrAzxsRA6CuhgW5ZRMo3mrF+gU3tdWUeMm8OG6m24X80bQLME+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6666004)(6512007)(83380400001)(6506007)(2616005)(36756003)(186003)(2906002)(38100700002)(26005)(6486002)(508600001)(5660300002)(8936002)(54906003)(37006003)(6636002)(66476007)(66946007)(66556008)(6862004)(8676002)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DJYTV5JDCauzBsAIWrrdado+AJsrwjfoc17+x46bh4Hwb01YjhEx2v7EuS5F?=
 =?us-ascii?Q?VS0EhbxMqtyP5V9/ERwAAslwEQrKDNrgbFxxIYFehATumxsDqbD3H91A4FVA?=
 =?us-ascii?Q?5ynLUvs4V5bvfre0efm5BcClC6JLkfJQvpDY4Xrmji4cd4vP8RZL9XwDTKoE?=
 =?us-ascii?Q?i0eH/XBDdmamiwDZpRi95Q/QQGuUWA/KeWICdpUXp2OyOvIwtfRx19reoiWb?=
 =?us-ascii?Q?ksSufPKcmVKbaHFpfZBdOxQ4KaJG9FvNzQhcFsgi1KELk19kPluT21TQagUv?=
 =?us-ascii?Q?cQQQyqWdoaMgSmqTz6LFHAYwnyUdomouy/ZrepZXbLZBy12quEPIxpxFyndZ?=
 =?us-ascii?Q?w73spq+5qmQ6F2xsUSxcuy9UKvSARUegbiEwqKpcmTpnhoPK6320Oksuepzi?=
 =?us-ascii?Q?ETV5RZZZS3MC3uiUrJjGwgxQu0sCWAJkUvaF1mnC7jaMSRIP0AheuJxnaokg?=
 =?us-ascii?Q?fj8/YUYgLbDUNRd5hIjJYOM1vavhb1GjOSb0gVcY/HuMm6ZXyBYS+u0qsnU7?=
 =?us-ascii?Q?UhFKnqNhWH2Hqk79+dKGsdOqzwPpMPRZ86lKWsyifJKuO1bva+DZ8XAkpi66?=
 =?us-ascii?Q?cycHss/tpnee3eVKkz72386MdHuRu4//uDJEmMqz0lolisBDv2BCszvq/br9?=
 =?us-ascii?Q?/CMNJ/QimWEBtfkaA6cOSv/l2/VGzsW5vAViXDWMxekH0v6+e0WcFBBmQR0r?=
 =?us-ascii?Q?eXDjVGuTCKgpQyeR5o3AP70GLAhAGvoh8YoBUi/rugnIpR7ee3MdFoY6tzdk?=
 =?us-ascii?Q?2fE/6DrIxlKUdOjauPDlLuNz/FyJHF/2Udu+eMOXvBUVp2nnzsHCQw+IMYiM?=
 =?us-ascii?Q?Y7h0jr4l/XOqUzEWNVWnDTJTUd+OX+Zw4Av2PgGY5ls40Vmv6EHzGg5zb433?=
 =?us-ascii?Q?mEQDRZ4ih8yY4dHZgHWY64vfAPw89D7cIsaYDq4rnAgm1Zl7JRLKlB72b7ot?=
 =?us-ascii?Q?ZbU6T5fnKfDtXwfmTPpPVGwrzROvGON851wN6g+r721AkMuk8j8f24BJGZU5?=
 =?us-ascii?Q?eW6H7PTImHL/tb7Jl7ZggZAk/rE2Xu6O62SzwLzqyO0dIZXf/+QNnD7b8aZR?=
 =?us-ascii?Q?fYskKADdzPk0lnN0iEab/DIRgUfLa0WcREkthBVD2umANbQ+IqlXIymngY1A?=
 =?us-ascii?Q?gG8St9gEkzciF3ReaU7VrF7oRoJS9hyQz+jO5BZ6kq/8sI3QwdTNn1NsiNdR?=
 =?us-ascii?Q?01L1vfzRY/xpMZwuscueHi73r5fjEtc8XRFPzbodrnM4kWcXgIQFrw3zW3vS?=
 =?us-ascii?Q?TIwB88vA/nYuN/JsJ6S8mk9Q4bVpF6h5awgQ/eqygZ8Qu0L9MEVYHESgWpTM?=
 =?us-ascii?Q?NIxvzGqXNE4vlM6kYPAcn+4uQQWf5iyBSRfe0g9UBrGLf0+HPKSBoTD4afgA?=
 =?us-ascii?Q?THu54Lpk/eYOYpvoAhR8QB0A6BsXnPgSb+0YUDo/t6OR8Vu+lQfotmHznL+O?=
 =?us-ascii?Q?oNX3C//PQ3fObCbhd9DG1U56lfwQqtqrO2SdkUo6j6szW20SIyOWg/UphLV6?=
 =?us-ascii?Q?SPxxAOIIkEBdcjoJVaB2G871Oxt0eu2Ywimjz6REqz1vMGKm4BCABDweXGxg?=
 =?us-ascii?Q?SLUqaWbQc3Ml6IATUGHlWim4KSl6fyUg6RmIM8lNIcJEto6mcjpdy6sfDaeQ?=
 =?us-ascii?Q?2Q9u3GhfElBgfbZZoDc2HIOVUBbCQjL/o34r+eGR3c1t7Z8m74F4R7yARTwi?=
 =?us-ascii?Q?5JPHb0kx2hbiuL43Tvts023p78VCRWeWCGPcmCV6al8EgUHrxcVg5QYfOjSe?=
 =?us-ascii?Q?YxKqvp7o5g=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f2ece2-4232-4f58-9f33-08da28e86958
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 07:26:32.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXJvE0lFJo5nItZ4dZ4pkeSkDUQnKb6y7aDsOU5NjqswddTIU0oQgCl+feaETWIQTEak79vL+cu2CrcyZZKdSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4908
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

On Wed, Apr 27, 2022 at 09:53:13PM +0800, Meng, Li (Jassmine) wrote:
> Expose struct amd_cpudata to AMD P-State unit test module.
> 
> This data struct will be used on the following AMD P-State unit test
> (amd-pstate-ut) module. The amd-pstate-ut module can get some
> AMD infomations by this data struct. For example: highest perf,
> nominal perf, boost supported etc.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>

I have acked this patch at the last version.

Next time you can add my Ack here directly.

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  MAINTAINERS                  |  1 +
>  drivers/cpufreq/amd-pstate.c | 60 +---------------------------
>  include/linux/amd-pstate.h   | 77 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 79 insertions(+), 59 deletions(-)
>  create mode 100644 include/linux/amd-pstate.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61d9f114c37f..6f814eda95b5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1020,6 +1020,7 @@ L:	linux-pm@vger.kernel.org
>  S:	Supported
>  F:	Documentation/admin-guide/pm/amd-pstate.rst
>  F:	drivers/cpufreq/amd-pstate*
> +F:	include/linux/amd-pstate.h
>  F:	tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>  
>  AMD PTDMA DRIVER
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 7be38bc6a673..5f7a00a64f76 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -36,6 +36,7 @@
>  #include <linux/delay.h>
>  #include <linux/uaccess.h>
>  #include <linux/static_call.h>
> +#include <linux/amd-pstate.h>
>  
>  #include <acpi/processor.h>
>  #include <acpi/cppc_acpi.h>
> @@ -65,65 +66,6 @@ MODULE_PARM_DESC(shared_mem,
>  
>  static struct cpufreq_driver amd_pstate_driver;
>  
> -/**
> - * struct  amd_aperf_mperf
> - * @aperf: actual performance frequency clock count
> - * @mperf: maximum performance frequency clock count
> - * @tsc:   time stamp counter
> - */
> -struct amd_aperf_mperf {
> -	u64 aperf;
> -	u64 mperf;
> -	u64 tsc;
> -};
> -
> -/**
> - * struct amd_cpudata - private CPU data for AMD P-State
> - * @cpu: CPU number
> - * @req: constraint request to apply
> - * @cppc_req_cached: cached performance request hints
> - * @highest_perf: the maximum performance an individual processor may reach,
> - *		  assuming ideal conditions
> - * @nominal_perf: the maximum sustained performance level of the processor,
> - *		  assuming ideal operating conditions
> - * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
> - *			   savings are achieved
> - * @lowest_perf: the absolute lowest performance level of the processor
> - * @max_freq: the frequency that mapped to highest_perf
> - * @min_freq: the frequency that mapped to lowest_perf
> - * @nominal_freq: the frequency that mapped to nominal_perf
> - * @lowest_nonlinear_freq: the frequency that mapped to lowest_nonlinear_perf
> - * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
> - * @prev: Last Aperf/Mperf/tsc count value read from register
> - * @freq: current cpu frequency value
> - * @boost_supported: check whether the Processor or SBIOS supports boost mode
> - *
> - * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
> - * represents all the attributes and goals that AMD P-State requests at runtime.
> - */
> -struct amd_cpudata {
> -	int	cpu;
> -
> -	struct	freq_qos_request req[2];
> -	u64	cppc_req_cached;
> -
> -	u32	highest_perf;
> -	u32	nominal_perf;
> -	u32	lowest_nonlinear_perf;
> -	u32	lowest_perf;
> -
> -	u32	max_freq;
> -	u32	min_freq;
> -	u32	nominal_freq;
> -	u32	lowest_nonlinear_freq;
> -
> -	struct amd_aperf_mperf cur;
> -	struct amd_aperf_mperf prev;
> -
> -	u64 freq;
> -	bool	boost_supported;
> -};
> -
>  static inline int pstate_enable(bool enable)
>  {
>  	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> new file mode 100644
> index 000000000000..4dffb7db3807
> --- /dev/null
> +++ b/include/linux/amd-pstate.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * linux/include/linux/amd-pstate.h
> + *
> + * Copyright (C) 2007-2010 Advanced Micro Devices, Inc.
> + *
> + * Author: Meng Li <li.meng@amd.com>
> + */
> +
> +#ifndef _LINUX_AMD_PSTATE_H
> +#define _LINUX_AMD_PSTATE_H
> +
> +#include <linux/pm_qos.h>
> +
> +/*********************************************************************
> + *                        AMD P-state INTERFACE                       *
> + *********************************************************************/
> +/**
> + * struct  amd_aperf_mperf
> + * @aperf: actual performance frequency clock count
> + * @mperf: maximum performance frequency clock count
> + * @tsc:   time stamp counter
> + */
> +struct amd_aperf_mperf {
> +	u64 aperf;
> +	u64 mperf;
> +	u64 tsc;
> +};
> +
> +/**
> + * struct amd_cpudata - private CPU data for AMD P-State
> + * @cpu: CPU number
> + * @req: constraint request to apply
> + * @cppc_req_cached: cached performance request hints
> + * @highest_perf: the maximum performance an individual processor may reach,
> + *		  assuming ideal conditions
> + * @nominal_perf: the maximum sustained performance level of the processor,
> + *		  assuming ideal operating conditions
> + * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
> + *			   savings are achieved
> + * @lowest_perf: the absolute lowest performance level of the processor
> + * @max_freq: the frequency that mapped to highest_perf
> + * @min_freq: the frequency that mapped to lowest_perf
> + * @nominal_freq: the frequency that mapped to nominal_perf
> + * @lowest_nonlinear_freq: the frequency that mapped to lowest_nonlinear_perf
> + * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
> + * @prev: Last Aperf/Mperf/tsc count value read from register
> + * @freq: current cpu frequency value
> + * @boost_supported: check whether the Processor or SBIOS supports boost mode
> + *
> + * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
> + * represents all the attributes and goals that AMD P-State requests at runtime.
> + */
> +struct amd_cpudata {
> +	int	cpu;
> +
> +	struct	freq_qos_request req[2];
> +	u64	cppc_req_cached;
> +
> +	u32	highest_perf;
> +	u32	nominal_perf;
> +	u32	lowest_nonlinear_perf;
> +	u32	lowest_perf;
> +
> +	u32	max_freq;
> +	u32	min_freq;
> +	u32	nominal_freq;
> +	u32	lowest_nonlinear_freq;
> +
> +	struct amd_aperf_mperf cur;
> +	struct amd_aperf_mperf prev;
> +
> +	u64	freq;
> +	bool	boost_supported;
> +};
> +
> +#endif /* _LINUX_AMD_PSTATE_H */
> -- 
> 2.25.1
> 
