Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD54E4FFFDB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbiDMUSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiDMUS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:18:28 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2043.outbound.protection.outlook.com [40.107.102.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEF57E593;
        Wed, 13 Apr 2022 13:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qid06XTsjnl3/dkYhakrZQu+Cb8cEjDyRin/w9Xitu1jvo3qBS2shJKx0OP97SFFcdy7qfpqfX1h+7KSYATg3Hwa1t/+f8sBlTyGMez6djCFAxyBm2OTLi8o/eki26l1ZldOgnZSxveUmOwjpVflGCVLV0j/CfULt0pQjIHyYBtGT9lLXos715KLIIcRfO0X5IpVj6N3RX57aw5JkSm6hHSHInYgeJDYqYJDM0HCkrzpwuljIxHR3D4QRYhlnDlW+71BaGinSDhCZwTj3cxkTLycviFEwQS53Nfa8NEz1mI1mFGzZ0FDioTno05w4C5R41ZyXH0P570iqChocAwpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4lwg5HGn7XgUW/7z6L6D0Q1kA+47DsNAxfVjR4mBpg=;
 b=eiuT1d9tnavfu3dPzm3xxFV815fSuLqPdc3MuIycy6eX7zYZ75jUVi0+qPQ3zWp24hy56RCqFeC002hCYfDYyTmrh4plhtVTekTYQ2CEh4Ee7uQCqTBX9x5PR/3NoOVTCPD0kav1BJtM/0wCoMroH36RjNLY/vwuBSh4e99N7HBgNOBgx6LqxEN+Q+CtB3AQLePNJBv/aw72ca4mmkqUSFB1i3j1jgRq/LxvdAVLEOGcXl7PoQm8srQQB30zR5yNHbqm+JdHjnf89DY0eumF7oIdBnwSho+E9RtXmxxgyE7guZExmsshsfpKDrYB9GzScPM3PMgoHRWuuNrc2wRSlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4lwg5HGn7XgUW/7z6L6D0Q1kA+47DsNAxfVjR4mBpg=;
 b=UdFSJX4i7l3ReAMkbICbvgVexI3GML390fTBZjePiUnegAvfkx7B512EfHhiOEZ8eNMVaywNH1RwRyHpdoUf/VUj4gl2W9b91BLSrTTHm6w/reqTKiQdcUL9y8OEGt/Wcacj9cX4zeWen2CkgjKBYojjEUIs42dTdXbyYC52lXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by BL0PR12MB4881.namprd12.prod.outlook.com (2603:10b6:208:1c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 20:16:04 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c575:d06d:b1ba:c877]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c575:d06d:b1ba:c877%7]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 20:16:03 +0000
Message-ID: <310cbc0f-1b94-cb03-cfe1-37a90bd57d8f@amd.com>
Date:   Wed, 13 Apr 2022 15:16:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] selftests: cpufreq: Add amd_pstate_testmod kernel
 module for testing
Content-Language: en-US
To:     Meng Li <li.meng@amd.com>, Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org
Cc:     Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
References: <20220413090510.4039589-1-li.meng@amd.com>
 <20220413090510.4039589-4-li.meng@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <20220413090510.4039589-4-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:610:32::28) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1513df1-53bb-4f85-bb0c-08da1d8a6f65
X-MS-TrafficTypeDiagnostic: BL0PR12MB4881:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4881C7523E25971176247092ECEC9@BL0PR12MB4881.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4VVwx7dlO7MOiThTDmoddYnrxe1uFTMMT1qUwIj7gGKa1t2PbP5lroYbrs1mu33dhQtNCbyDDMbahpPOn4e8p8jIV/Mq8l7MVW4KZ3CcFz2DQvZSpN8ils0WR/VJ08x7y4VH6CjnXgleWjFza9B/70pFNd90PsutRqaF0FBI0wFxxupEuLbNSV206S00LwmPuY7sJXjKh7Uo4YcHhFRcqObJ1gsaw7j9EnYxoBMt2HDT3MpzesJp5fXytwaa5HDsYIUSJx6JSy7IEvTYqI7tUPBlNWWcAhXu4ke/6NdHe104rdqGjUOslKDElwKlyXqcAwWqgN+y1ZmK/RYDxOmGKnrUS6DG+l02fBAjzNg6U8DS/bhBlDMiz7VCqM46EGa6sIOL+KlyrelUKF1e/57Ar0bIOISYxk2Rq1n8+TWVuwJOP9jHwo83/ITIECbRAkGkx1AQKLZPYmdQJ8cYbhAnJRdwg8obkiA67HoJRKSdxYfruRXQYuZChzX1dgKlU597p6Oc6A08khQJGFcWXUsAbyIK9uovP2DT0AMK3+VbfPwjrfoah9F+stVpb17ZFQtoeYpjy0IHJwy07EMBO0WILUdJq1MFNrg464TBbvsv43ju80h1aYCr3nCza3fipltTu2m00MXkagcXSldEQm1DiYNS2Uq72ALC8N6/gcJ/Twjpsnl1cTR8Pl+uIvqWBBKwmw+jfuBFgqIWVJnl4F5WTi2tpJFUo8ICgYCfSObVRi25l3h3TUV8ygVJsS5IGeS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(66556008)(66476007)(66946007)(8676002)(110136005)(316002)(508600001)(54906003)(31686004)(4326008)(38100700002)(36756003)(2616005)(31696002)(6506007)(53546011)(6512007)(8936002)(5660300002)(186003)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXQyeFpKTmNmc0RHUFJPTHlDZG1HMHNYYkF1R1RXS3U2eGRoUTdyNTlsemw1?=
 =?utf-8?B?dXczRmFWaytFZUpWUVphK1F6bFFVTk9mSTBFVlFGTEl3TXEzYThxNGJsQWpj?=
 =?utf-8?B?ejNINkgvUWdjcGFTR2gxRW01WHEzbGwra1EyQVpKQ0FJSkFFNHVUT1BleTll?=
 =?utf-8?B?Wi9SejF3TXFLTmN4cDgyTVNMWnlrNDdmemx5dzRtaXNnVStsNnhMV3Rtd2dR?=
 =?utf-8?B?VjdWejZCYlcwVHVFT2tKMkFtV0VTS2JpVlRhZFNaenZGVjVTRTlSNWxuZ0FJ?=
 =?utf-8?B?TVMzSkY5ajRYZzdVU08zWXhvSXVuak9sWWJXdURSR0trTS9raU1FUTFmandh?=
 =?utf-8?B?dDVXZDlrWTdYOU9jQzBTWWc2Z3hPeGdscFVpL1c1MzJFenRicTYyVExCMlIv?=
 =?utf-8?B?WlFlTWxOWHNBcGNQeGI4bHRLWlpFSEQycE5OT2lXNW9xU3BzUW5qMUxtRHVL?=
 =?utf-8?B?bVZmMFhPcUxPeFhJYUpvZ0JZOHlIenk2ZG9ySEVIakRDL3Z0SFB5eHVFWkdZ?=
 =?utf-8?B?ckxqM0NtbVZoc2tPNXNwNG1NdVdGWHNPNG9BbXB1TURRNEJjN1lnOWhKNUx6?=
 =?utf-8?B?cHFDQ1IyWnJvTFZUamJZRGp0cVdGSnYvUUZ6ZDc0MjNPandkWHgwbkh4aHNT?=
 =?utf-8?B?TCs5MVlqWDR6MXBoNGJNb1hZRDd6Yitnc3NCcVhTM0MvOWI2YTBGMWtKNUkv?=
 =?utf-8?B?VkpESmg5RWNLRWdNU2xBTkIxM2VsaHlncE01dStTZVdsWkZOeDNKT3IzT3Fq?=
 =?utf-8?B?Nm4zQ2grZVlEaFBoVUlTaEhMMlM3akV2OGp1MkhYcEFHK1NyM3pDZWROdG1Z?=
 =?utf-8?B?b3hmMUFnTmhESGcwOGx3UGRkeVNuc3NyUXliVWZ6MGttZ1VqMXVQTHlmeFlO?=
 =?utf-8?B?SEVVUExBdEZCQlpFZTFhVXByMUtpQjhuNndxcGVaMzFYS3pLQXlWWUJydndM?=
 =?utf-8?B?SDAwV0tEL3hWU2g2bXFGSkpUNDZudmZiNUMxTGp3RzRiQ0xFdVBLbE91QVZ1?=
 =?utf-8?B?YmZVNk5BbnFWWUJTL0RIZExnSWZOTWkrV01tcG5zTE1lYldZUnZydUpEZTIy?=
 =?utf-8?B?aURNc05IQ3NZbzIyVi9PKzYwVU1GUVQxQ3c2ODFNWTR5UE1QbGRSZmI2Ui9r?=
 =?utf-8?B?QTkvNHBhbkY3a1hreG5BMmJua01XUlZyL3RUMzBYSEtmN0YrZENhcSt6dzhy?=
 =?utf-8?B?dTA5dUNYNVpoOEtsK1lEUEptZENQdDVwUTBsTnpyT1VRUUxSUmozeXI2VkdF?=
 =?utf-8?B?eHIxUGVPRmoyNldqQVdaeXRoY2JDMVFXOEV6TjlveDlzOE9CWlVxd1NhOXdi?=
 =?utf-8?B?VlpnY2MzaGFvVG5GWGYrZmtZbERxclp6RUhvdkhhNmpzQ3VHNjBqVys1YzFB?=
 =?utf-8?B?aXEvRC9MNFZTWGkyWWJIQ2Fka1NHK2UvaDdlWWJkU0ZubEJGSzFJNjhZcUVO?=
 =?utf-8?B?bGRNV3VVV0FQWFVLUDNZcjJ6ZHV2Rlk3OVdMZ1RmL05pMERPZjVlNUZwR3Zm?=
 =?utf-8?B?VitSRTBEemFnakVoZExmTm5wVU1jdEptU3dyQzdhUmdOK1crR0IyOG94U1Zx?=
 =?utf-8?B?RUFLM24wUjdQY0FER05FZG1TeXIyV2diTUl3YXNyTkV3Q3ZOc0NoT2UvbjVF?=
 =?utf-8?B?ZjZ4SUwwb29oczlvK3grTW9VTjlVSU9jd2EwaGVUUGErYW0yS2xjQ1YxU3l4?=
 =?utf-8?B?UnFLRnM5clZrNEtFY3JRTlFzMUxhZ0xWWmxTVnFad29odEhKcldwT2IvalNK?=
 =?utf-8?B?dWRYNlJreVBnV1dlYm40djY3S1dYNnpyemgzeXdWMnU0VWdzdndtUEhGS2Vy?=
 =?utf-8?B?RUZ0eUtTekRac1RwcnV1c2lrVlM4VzZnU0ZZVnBtR3JENGVXQ2NKdm1GNkdH?=
 =?utf-8?B?WTZ2aVlZcHN2UWxTZ3B1QXFSVTZhOC96NzJ3a01PUmliZk50T0UrclVlWXJx?=
 =?utf-8?B?SWNvN3kxV2U1ck82Sy9TQVJ5V0dacGtTa2ExdFM4clZOZVE4S0F6cGI4cVNP?=
 =?utf-8?B?dmRjZGFoWnIwaEt3Ykk3UzFNMkZBVC96QWg0YnZjMjdqQnl3MU8wZlFxQ2xG?=
 =?utf-8?B?S1QwczUvcmRhTDkrbnhCcmtIOERmVGpmMFVsYzJQY2c4Q1lTbDFXbmFCLzMx?=
 =?utf-8?B?bXZEZnZsMjA2L2FINGRGYlU3Q0w0WkVuYVFDVWUzQ2RiV2tYVW0wQ3lXVUVq?=
 =?utf-8?B?cjNRbmoybUJFcDZUQVBveW8rKzR3WU04YjJUUERBVi9NZGVDRFhURzkyY2JJ?=
 =?utf-8?B?NkJPOE81L2xpSEl0bGZOOVh0TGEwNGtaU0dCaVJieGxZekdVZjQzUWFRd3VC?=
 =?utf-8?B?bnFtYW4rcnhZREFzeW56WW5SY1FOSTgxMk9WaTUwL0I4WUxBL01tYUkrRE1P?=
 =?utf-8?Q?CftpqgpG4Pwpe2hzsz31ZwDv3vsj6KLKmcLvdwR+9KiQq?=
X-MS-Exchange-AntiSpam-MessageData-1: rl+BXwS9Z+n+lw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1513df1-53bb-4f85-bb0c-08da1d8a6f65
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 20:16:03.9070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7cc3u1uasspjAaAsMKlLz71HYsCnMixfb566/lTqEM80vR0cD+SbBuMOx/btj4tPEc0mzHOCZJ2FLIQc6iVrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4881
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 04:05, Meng Li wrote:
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

Is this test needed?

the amd-pstate is only supported on AMD systems. If anything this should
be one of the first tests and have the testing bail out if this fails.

Or, have the script (amd_pstate_testmod.sh) verify this is an AMD system
before launching the tests.
 
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

What is this testing?

Shouldn't you verify that the current driver is the amd-pstate driver? This
just verifies that there is a driver.

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
> +	}
> +}

Another where I'm not sure what you're trying to test. If we're using amd-pstate
you have to be using either MSRs or shared memory. Either of these set the result
to PASS.

There are other test cases below that I have questions about but before digging into
them I think some additional documentation about what you're trying to test with this
module would be nice to have. Theses test seem more like verifying the amd-pstate
module is in use rather than testing anything.

-Nathan

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
