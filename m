Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAD856ABE2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiGGTcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiGGTcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:32:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9779021260;
        Thu,  7 Jul 2022 12:32:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOU7JbbceQ0jKLtVjzcyQ51Y1xPuJ1T6mT0wbpdDKXoj9ISsC/AkQTA1z+GFyY2KKzOceAWntXpGwep+Hd7a+S6qqFhR+NzIcQBXjg/x0Y9mwKatThm8bvW0G1WvUle3Hl78JORApL4R8R/fiPTlNoMzdXywme5GdGaCLts3RwjEkYK1u8Uby5YQmONcqFFo1VNw+k6p2aoPTRaMc/bd2Cc6SOeqnDWnFukYiSJFYCbx7YlpB8I2StrvskwoICOZDUjOVqC8PVguwVrFY8gKKwdjBV/6mGNrY0MPOYWiEMVyNgIG7r7rMkFl52PBf+fdosvaEI7VEo9/+vJX1/Q5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qV+tsUEpq6R1VmyqAi41sKrVyzDcPn9AYsfj8PhxSY=;
 b=Ig5ckgHjI9czbYGOUnNWPeYetsAWu1IX+xv8lHzsQ0+An3C0LEuk13oVXlAsZ/5/P/QCsGT0BzKBOyPho44ymRGpP2ZjNOxioDQipXJa8sFfQ2ySUc87LqPOGbGnH9hYmfQhBKF8tucCwIm5CJyfgCOFce72fsBqzX+m/bFJ5R6FbGOa3sctRGZPBMmv3dK1r9ihPIgcYO37OG3rSrpqdnelTObOEBjgjx2+FBxL0M52C5fMU4hHlHx/WmA9QO9cG0cyFAzCLsxCMqVQ/vWf5cj68ZjVqMMBOHMl6cS+J9CmbhX7GkzlU05aseow1vUmlDcajTBMaOYDxrtz9sIVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qV+tsUEpq6R1VmyqAi41sKrVyzDcPn9AYsfj8PhxSY=;
 b=CqhtjhlUz1uVKIRcAjPjdo4dEKlfcwmJ3xy9E7W5SagClnqzEdYtqvPZausgApKJ/vLk0tqfX4Qm/vz+1WkW6+6JnomVNUY/Os7ofLJrc7+sahkKUV8BFIRSuS5fYXJv3/uNW+mhr6dXD0mokEbkqIsZuUtr9xxVY5snt4WVDrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by DM6PR12MB4618.namprd12.prod.outlook.com (2603:10b6:5:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 19:31:58 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1%3]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 19:31:58 +0000
Message-ID: <68a54575-c55e-e83d-ec25-7b0b516077de@amd.com>
Date:   Thu, 7 Jul 2022 14:31:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 02/12] cpufreq: amd-pstate: enable AMD Precision Boost
 mode switch
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        viresh.kumar@linaro.org, Ray.Huang@amd.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com
References: <20220707165522.212990-1-Perry.Yuan@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <20220707165522.212990-1-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0009.namprd05.prod.outlook.com (2603:10b6:610::22)
 To MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea639014-c93a-4429-c826-08da604f5b44
X-MS-TrafficTypeDiagnostic: DM6PR12MB4618:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSSn1zGmHS9iSjH+0ywpLy3ubTY7vZxjLA6uLl217A+KUFfyz0k0KiHQFJ0YQddrS0y6kBV9xSabpOPLcjBvHZgalo/FxKOI1mtwT2d6uznN32/nzfBnm+LeItR63H7HREw54UDwMcP9x5k41fUN7AMk+JclTHtwPjRr6JHj8pSZfnKED7YZlToo3cNJj9JgZUwmRTj9cHXpEouMWov7mEuh8RzCWNavlSLoPMlU1oGb5Z0UIWb7i4jixZvrTF0wudyyGf+vif9udLqV1xgJu8z0C22f42EjUD0kRm2wGbpdYnwxzuLBJb2ATd2I3y8u2LdxpEXUaKB0lLToR/UoqQee5XcPMOt6WhK5oaBxRGfmRFE843dJCjJlnBSBj/U/0gSXvK9G4FUTwyrIePjEdR8qhy7zNvbVvEMWQyE3GD7YCr7hPTNLNFhf0JW7MFNHnC3YHbGPGYks1xNaK6/H6LiWjUSwyzzz0bH1ZCFCVVRsQaH/qqEBearu4KV515j8/Mg2dyoEMkpA3BYoQX17XnWd16QjehKK/qfnu7YgEc2liQCjnSEsYk+n9ZtXbihH6Yww0ExxjrC7TLUHgc6/Z8aWNHvq8mg/201OVz6M2SGoX3Stdgg3aynUHPTygsWY0HvrCp8sEfV/tAovmSP740oVzXTKl1g7ZgYfkN3WV/AC4iRyYWuGjJCZTf+rzxJ0w0GodABZEcGGNIzUtHZzMHA9CrnEKVjGNW+ivbzQd//iU7LrtJhJLw3qfoQHCiq+QTlcrxwDQwVVWfPNqzFeiczKCoFhCWh/z1CVLXmf8Az3KvBZVhSrzqs7uqUCrNyamO8mxoKqUxnhIiaKjxuDDbxhgnFHekJcIOYAMhlZvVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(110136005)(6512007)(31686004)(8936002)(26005)(83380400001)(53546011)(6506007)(7416002)(5660300002)(316002)(478600001)(6486002)(41300700001)(6666004)(31696002)(38100700002)(8676002)(66476007)(66556008)(186003)(36756003)(4326008)(2906002)(2616005)(921005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUJJUE1LampBcjRZMWtwYW9aTDhwb2NFRVljNzBwRlRJbGN4Qi9MQmlTQVZ2?=
 =?utf-8?B?MmF0U0VqenlRSm03MUpySDlmdWQvR1pRVDIxaWtVQ2s3N25PdmZOb2crVm1D?=
 =?utf-8?B?MGRLOS9BZTQ1S3hXNjNqbTUzaUxFR3RibUdVaytocFZCNGdKYllPK1l1SGxC?=
 =?utf-8?B?d0d2QXRUeXl2Q21DVDkzaHFYVTJzQy9HTVc5RGhBTi9Qc0w1b3hyK3NtQTg5?=
 =?utf-8?B?ckE2bFI0YmVxOTIrSk9NWTZNa0tFcmxzNlVhTmQvS3V5UDBOdllDV2gyTGd4?=
 =?utf-8?B?bU5lYVE5cFJwbDROUG4yc3B0WXlHczVjcVdYNVczbmVQZzRYb1pCbnNPMks5?=
 =?utf-8?B?WHpVODFYK2VJOGtSTXhMamYyKzNQUHNiS000SFVTYTVqUVpZKzJzc2cwN3kr?=
 =?utf-8?B?bDM5SlpwODRMNXU4SmphZGhqdEhHeVlkSTNTcGFMVERDYmJmQnRnOWxxZXFm?=
 =?utf-8?B?aHcrbjRFM2ZXTHoybjE2QThZdDk0Y24rZktMV01DVC90cklQak5VN3EwNTB6?=
 =?utf-8?B?R2gza0lOY3EwamRzRmRwbUFaSERrWlJnNnhCKzNKUWo3V3crbG1UdXV4R1JD?=
 =?utf-8?B?Q01ibXV4NElLMWszakJ2bHZZejY4QVk1dFRXT3Vib0NCb2MwR0poNSswZ3FP?=
 =?utf-8?B?Um5sOTlFQUkzenZLZzhtL0pZcWRMaXpNc01UbUJBV1RDTDdIeEd4M1RvUFB2?=
 =?utf-8?B?aWRJUCt4b3FoN0FsVTFmZjAvZTNOVXF5bTZjZDFHQk5VUUQrNml5WGU2b2JF?=
 =?utf-8?B?TWVwanZtaGtFWElsL3paRGVhS1NpSG9DTXExdHVwZUIySWpMcnp5WmRMdFNY?=
 =?utf-8?B?YlBPZzg1emZ2TXFEL0I5SUpjYTZKT2R5LzNSTUNQNTJHcHdLeExnVGdVMzgx?=
 =?utf-8?B?cnNIUUMyUU1ubjNVcWxoaFRpR2JaNVdpclZReHBCNVR0ZXVaa3FQTFZHb3RW?=
 =?utf-8?B?MFJ4SGttZUVvWUFkSUpXcm8vbTA4YlZ4aFpYaU5jbkZBNjZTNGxIS0JKYXo0?=
 =?utf-8?B?Z3FXTGVES3dyY0puOTl5NXZRdlJjZU5CNEFwcWxuc2xjWERuM1NsU1NLQ01p?=
 =?utf-8?B?ZHNKVEt6WU4yT3MwNEsySjNqWVBwWVF6ZDh0Wk1qQjJyOHZFUXpqai9JMTNH?=
 =?utf-8?B?SGlCZmVjNWNjQzNJeDg5eWdHb2NwTlFUVzk5VFg2VGFvcmVFNmdqQ1ZzZDRJ?=
 =?utf-8?B?S0I5bHhheXI1bWk5MG00d2RSdWVLZ2hIOW5VU2hjQm05bGhtL0N6V3dYNm8y?=
 =?utf-8?B?d0pIVWdjb095Nkl2bDhudnUrY2dueEVYbGxMaDFuUFVvdVZUbXZoNEtxRDVi?=
 =?utf-8?B?NEpscjZJSzR1SWNIbWpyazlnK05CZGh5czNiMEVycXM3SHFDeWlLU3ZaZzlM?=
 =?utf-8?B?Q0k1Zzljd2ZMSXBIbnBlVFFXZ2hRUThwS3JCYVMvOFdraks5amw0TmdLRkcx?=
 =?utf-8?B?aUdvelhBMUhDMktQSjhSOXdMQ05zYVhReDlXZkJpU1NvYzd5ODMvS3F3cnpa?=
 =?utf-8?B?RW5keEpNY2NKV1hFWVpiL2VWbEtPR1RoRkZUZlllbjRRR1ZHT2dBL2hhcXh1?=
 =?utf-8?B?YkVHUUJOM2ZiRnBwVGhIcVVDM0M3Y2RCTGE4bU5nYVFOdEd4MkRpalJYWW9Y?=
 =?utf-8?B?OFVyRWc5UGVFYTF2cU5URko0VkJ4NlZuVTB5aDRhZzF5QjJBQmo5b1NYZWg5?=
 =?utf-8?B?eGNtRzF3bW1LVWZ2ZVJhK29QRG11WFgxWENOSFBRK0NVNXRXbDNIYUVNOFRI?=
 =?utf-8?B?dnpUK1o2Sll1LytVTUVVcHBFRk12eDRudm5hamllVmVGNC9uczJYRGdvRXA0?=
 =?utf-8?B?dHZLQ1NnRTV6L3pMTUFZMUxJUlZZUWNzQSs5N3BlSGVPS0hKeDhZb2Zkc21r?=
 =?utf-8?B?Tzc5bnZUZTFsbWZMcXNOeGdvSWVoUVdxS09vU2J2U3VFT1pkcitSSUxyejVQ?=
 =?utf-8?B?UzVaaFMwYlh3aDFKQUVGcFAxRkZNU2FqbWlYSjJQeGV5QVBHWGJxQmJ0Yjk5?=
 =?utf-8?B?SXhUa1NUYStVbWhINzJrYzU5bkhFQ3VXalFPZ0c3R2VGOWVSTTJZdTBMci9j?=
 =?utf-8?B?VG9KV280TG9YcWRRQkZNWE9CWjArUCtYZUxjSnNvNnpRRTk2L0U2ZGgwdEpR?=
 =?utf-8?Q?/Lr2dHkC7AIELkY+spw2iejA4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea639014-c93a-4429-c826-08da604f5b44
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 19:31:57.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1WP8a3f7Ioz8kOpNGvJVf8iqUNHTiIjXbGrWzn3/mQJeGNUBDc9axuQTaU9/vEZpVABrxGt7z62j1JGQksviA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4618
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 11:55, Perry Yuan wrote:
> Add support to switch AMD precision boost state to scale cpu max
> frequency that will help to improve the processor throughput.
> 
> when set boost state to be enabled, user will need to execute below commands,
> the CPU will reach absolute maximum performance level or the highest perf which
> CPU physical support. This performance level may not be sustainable for
> long durations, it will help to improve the IO workload tasks.
> 
> * turn on CPU boost state under root
>   echo 1 > /sys/devices/system/cpu/cpufreq/boost
> 
> If user set boost off,the CPU can reach to the maximum sustained
> performance level of the process, that level is the process can maintain
> continously working and definitely it can save some power compared to
> boost on mode.
> 
> * turn off CPU boost state under root
>   echo 0 > /sys/devices/system/cpu/cpufreq/boost
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h |  2 ++
>  drivers/cpufreq/amd-pstate.c     | 22 +++++++++++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 869508de8269..b952fd6d6916 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -559,6 +559,8 @@
>  #define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
>  #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
>  #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
> +#define AMD_CPPC_PRECISION_BOOST_BIT	25
> +#define AMD_CPPC_PRECISION_BOOST_ENABLED	BIT_ULL(AMD_CPPC_PRECISION_BOOST_BIT)
>  
>  /* AMD Performance Counter Global Status and Control MSRs */
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9ac75c1cde9c..188e055e24a2 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -122,6 +122,7 @@ struct amd_cpudata {
>  
>  	u64 freq;
>  	bool	boost_supported;
> +	u64 	cppc_hw_conf_cached;

The MSR value is cached but I don't see that the cached value is used anywhere. Perhaps
I missed it in one of the other patches. Does this need to be cached?

-Nathan

>  };
>  
>  static inline int pstate_enable(bool enable)
> @@ -438,18 +439,27 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	int ret;
> +	u64 value;
>  
>  	if (!cpudata->boost_supported) {
>  		pr_err("Boost mode is not supported by this processor or SBIOS\n");
>  		return -EINVAL;
>  	}
>  
> -	if (state)
> +	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (state) {
> +		value |= AMD_CPPC_PRECISION_BOOST_ENABLED;
>  		policy->cpuinfo.max_freq = cpudata->max_freq;
> -	else
> +	} else {
> +		value &= ~AMD_CPPC_PRECISION_BOOST_ENABLED;
>  		policy->cpuinfo.max_freq = cpudata->nominal_freq;
> -
> +	}
>  	policy->max = policy->cpuinfo.max_freq;
> +	WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);
> +	wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, value);
>  
>  	ret = freq_qos_update_request(&cpudata->req[1],
>  				      policy->cpuinfo.max_freq);
> @@ -478,6 +488,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
>  	struct device *dev;
>  	struct amd_cpudata *cpudata;
> +	u64 value;
>  
>  	dev = get_cpu_device(policy->cpu);
>  	if (!dev)
> @@ -542,6 +553,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	policy->driver_data = cpudata;
>  
> +	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
> +	if (ret)
> +		return ret;
> +	WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);
> +
>  	amd_pstate_boost_init(cpudata);
>  
>  	return 0;
