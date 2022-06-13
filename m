Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E58548FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386389AbiFMPCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386040AbiFMPBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:01:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618001099
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:05:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aawv4pzO+V+GZCOFHSuYym7tYt3pOJdMycFch2TuOIrGedNjgeTg8/M69KBoLvK+X7y5M2gAb+YBTLUkrvpTwNkgBeSAPu1zzgpW7vUTKKDeCKfjFqPVdv836LieDXqEc3+1Nh7dly5QtxiQip8t9WtizEasqb6w0HPySVenIZyTFi8+CJ4FcfXEKaByI5erRkmbjhTdjYdVhSTzAbkgGzVaEl5/ZcDDndR398hS757NOLebXJP5gqA3ry5m4vPYuxPPLfusnFZtBNi58zV0L2qJ55k3D85Z3h7H0i3tRuXtylinOhmSV0JqHbewYVJq1bz3ffWm2oHEpcqnWaZw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MheoxAyECe6hC7ExxJRTlSKPlQsUNZsQm757/a7QYw=;
 b=dD2vfA2G3cJDby3nLVy8ilJVaP6UutnnWZXVu3fy4JE0JWbRK5H8u3Bqbt55DpkQe9lxv0PXs0HYc6rS59H3TFEFzR0clwb7L3JQf7r/ubMMe4WHlZUyMzW7pF3mx1ll6UYrH4O4Zu9mfuhIhE/zNGJWVUwm5/3hweDK7VWv14g/VXTjHCp315eM2GHPvkwC0Ssdw7sEl0bjCWhdBN0bwzrynOhkX/1mQgT60PiKgyh3mHZJ2enAwyFGdCty7dM8swSjpYC/Yw+/L60ioyDedhjOlXxauRTOJBNvs/JCyvQsG+TW7sF+8x4cx/6+ds2ogvXF+nP3Q+E2hmYgtFtFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MheoxAyECe6hC7ExxJRTlSKPlQsUNZsQm757/a7QYw=;
 b=KEJFqbC3mYStzmLGX6g2ODj6Fw+o6fXNiQ5nUMsoGxVDN4S57+WuJcyLLsym4qzAex2aN/X6rbbs8o5QYciX0JwyiKo0QubJb+M1aLPi9NwqOmqRyYXS96hjsMCjxmy2hCbZNFXGHdWDo3OkQi0QGFIJ7t54+N0lnwZS2cNfQ5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Mon, 13 Jun
 2022 12:05:22 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d22:1b6d:6231:e435]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d22:1b6d:6231:e435%7]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 12:05:22 +0000
Message-ID: <ab726727-c397-3d3c-ab71-28daf586b455@amd.com>
Date:   Mon, 13 Jun 2022 17:35:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     aubrey.li@linux.intel.com, efault@gmx.de, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
References: <20220407111222.22649-1-kprateek.nayak@amd.com>
 <YqHfdn9O81Ir1+bI@worktop.programming.kicks-ass.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <YqHfdn9O81Ir1+bI@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::8) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c33e1cb-6ebe-49ae-9a1a-08da4d34fdc5
X-MS-TrafficTypeDiagnostic: CY5PR12MB6478:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB647802F44262A3FAA1ACD51698AB9@CY5PR12MB6478.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOlY6wh/nDNiNDll07ss8SkBj164QpRv4bY3whCciIhKHK4yzTqWicEhqF/3NGRFUrAR+6Wv/l5Sk98FVhOUWajzM4sTN+mipDkqK8tS4GgPF8EoXGQYgmM6wuNPmEMn9ubFbr62bTmemL6+bLszx6JsXrlGN2o4q/SgO/JR8mSCATWfgY2EQX8rgCCrjjF8Q+tayuCpwbBS6vvYRAUYFkgJ0UTvUL+2M2abCR2ZHMfoidgiX6KaPBOvgKhysA+lhr59EZRqrhKRjgWP7zbEIkEiBkoeEJVsNU+tUGXSpyGjh1z+QAbhABOc+ryshGyIeYmwdWIMU8B3wbbprrlW3tRapEGjSDoRQkjDdJJBE2UKhji2g14ylQxqVLPV9BN1S5d0Ar9T2uB/Qpg3UAvvoQAIg59zOZ9BdGT609GqdZPMNqppQsykXUQOqcY4a2fnEIdocA7sQKmDZ9ayVUjJnocy9N/dhCUCqk73G1RISQXWy9HjD4Wg8L5WnKeOt5MsszJW2HD7Im9K42Xo9xqqY3s1qBwJOInZWxH5P+5yi4sj+6M9V0KiNwgQ/GQu4JVSCcduXj3uz4uiczRBO0fgVF7mefnFDpNqoP8qInkhtSfpfVs2u3KuK5kcFLgQdI3oSpgkPLIry+Pk+uTXSCpis3oyHsFpZvgAyZYwVMmQNUTsAx2d89/MLRksOlwYXxRZHlP2ch772TlBUKvWzdNOi10/Zzgy4faXrHCdvawNo4CCCIbf8SvaH52dckjGmOxRzZZugzabTvuW3m60t5mJKQxt70+Rz6eGzU6phcSHjux10ht9CU00HI2E0YuTnXJK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(40140700001)(38100700002)(31696002)(6916009)(86362001)(8936002)(966005)(6486002)(30864003)(316002)(2906002)(508600001)(4326008)(7416002)(31686004)(5660300002)(66556008)(66946007)(66476007)(8676002)(186003)(6666004)(83380400001)(36756003)(53546011)(6512007)(26005)(2616005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3BJSUxYbllHWjJ1QlhldWd1c2swakY5MFhDa1JhcU1aKy9PNDZMTjhybzAz?=
 =?utf-8?B?Ym9oeHg0Q2hTOVBHQXJiL0lyT1pqYnRxaytDeXRBSmZzSGxvMlpZUmNCZVZQ?=
 =?utf-8?B?VmJrMEE5SzJORzA5SGs2clBoTkVPMjFNR09vV0RUMWxnTTJ2anBFUGFDdDdw?=
 =?utf-8?B?Vmh0STU0Z0dETVJONWJrTytiTm4zWWNnMkFHL2dHTnVOcVhRYkMrNXNjWWZh?=
 =?utf-8?B?N1l3V2hNT0U4WktXbUxxNlRmVFZiYUdOR1RlY09ad3E3RUdPcEpNbWJ0eGo0?=
 =?utf-8?B?ZHZwbENLcjQyLzJlNk4zbzNMTURjNHRnTUlKL3hLQ28xUkZnNXdRMFQrVTBT?=
 =?utf-8?B?L3NJeHI3cmJjYmVLTHpiVE51eXg2ek5HT3dUcmZWRVJnMWZBaDI4ZnBUNlU2?=
 =?utf-8?B?WGtEVDMwYzdLR1o1OWlyMGh5eDYrSVg2cU1GQXMvNEVjeTAvQmZTV3liOWdG?=
 =?utf-8?B?YThQNytRRjVqKytwL2FFeTdDbm9GNEluL2FLYnYzdWRTbkwvQjBuYzJBcWJZ?=
 =?utf-8?B?S2Z4RnF4aExsTDMxVmlOazBsQ1BPODUyWWpoNittNEVZUlJvL2lxRDYvd1lR?=
 =?utf-8?B?RWVUd3pScEVmc29vRU9qWFpHc25vZ2tpYXJwWVBzZ3NzUlgweWI1RERjUFVi?=
 =?utf-8?B?SWMwNFRWR1I5ZUFYaXhnVXVqRGM2WXhwM0RKNk9FSjRMM3V0b2xaWlRiMytt?=
 =?utf-8?B?b2ZjSk5ZcFF2U25PblRqd1dBUkI0MVIxbEx6TVNVbHFzNkJSVURDcmtyQkMw?=
 =?utf-8?B?eG1oVjY2RStVd3NadEo2aEJ4d3pnN2dRSlR2bEIvQ1U3UW9hcFVqZll1NmhE?=
 =?utf-8?B?S0lnbUNBWVVOU3ljRFVORWlPK0RXUGd2TzJrMjdkZ3BNZzRiMXBndVpmNEJv?=
 =?utf-8?B?M0pndmw4VnlmWGdnSFJNUUppK3Bmb3hkcDNmREpFZWduajkrNHE1dkNvRzNM?=
 =?utf-8?B?WXZtMkpBMWU1akc0SXVPRG9ZNlJxUHJiNHRqRWJ0d1hFaUdycURkS0tkQjJl?=
 =?utf-8?B?STVWeERjbnFlb2NDc2lJdldvZG1KYkNGWWprVjRtNUllN2ZDMWdyQ3VMNFVn?=
 =?utf-8?B?RjZzNHlsNHlWZlAxZEczeXpIelg0SDB5RFZ6WnNmb0x2V25ncndIQVlrUmpo?=
 =?utf-8?B?bEUrUGlUQ2tNL2t5TzA4L2RkMHl5UXJpd2dIeFNjQUpOT1kvaU1lN0VkK3No?=
 =?utf-8?B?aEtGeERPRVJZOXFLWldUbFMvallCU3VYd1V0MGFteTJWQ2dRU3RoejB0NnM3?=
 =?utf-8?B?Qk1IZVdZZmFhMUJkWUVmVkVGbWVwY1cxRURPelN5R0hXcGpYajlEU3Y4RUo4?=
 =?utf-8?B?Z3lvOVdLcEpTWHhBcHFPcjl3MEFBSUVYRnZjOUExRlpSRXpsL2ZMQmhZT3dF?=
 =?utf-8?B?S1BsNG9NVk5NaWtMVnpsNElQVndHUVlsTnpJVXU1RGd1c3U2MmZzWC8zNHNK?=
 =?utf-8?B?aWJ2bkVQdExuSEtiQXBwSGlubHI3T0dWeUpuZFdlTjVpTFA5dnRDdlVzUjN5?=
 =?utf-8?B?REx1WDF6STFFQTFBR0Z1cDdncGwrM0ZOVHM3NkhmbmZCMHdrYzRINHUrMW5X?=
 =?utf-8?B?SnJsdTdVdEhPbUJVR3RVeDJJeTRHbEpCaXdORVRkS2hhWEZiajZ2Z0Vod2ZC?=
 =?utf-8?B?ZEJaVmRTS291SktFUWx5RHZlTUxLeDMwbGtIblZCSlJBdklhSzdXclJ3N3hU?=
 =?utf-8?B?MVRkQVc1NndvV3dUR3Zta2tVUVppUFd1N29lNlMwVzdxSVQ1YjVwOGZRT3RJ?=
 =?utf-8?B?YWhlNk9zblU4K0NjMEppd29HN0Jwdk9kc0VkUUhnSUVQZzJSOTVTRElpZzJm?=
 =?utf-8?B?dTJEZXJEa3hud2tkUDNpbFlKL0c2bWJvbHZiTGs4dldaVGVuMDJtRUFhY1o4?=
 =?utf-8?B?a0NlTEJZTlNVclFudEpVWWJIZlFHdGlHekt2am80d3dRa3pldmVpL3dmMm9S?=
 =?utf-8?B?cWhaSlV6WDRuUHBLOWJHTmtWbkY1SHJZRzFRekdUanN2ZjhpOHcxTWpKK1BT?=
 =?utf-8?B?d1M3ZGpVbFBmWnprV2NjK0I5YTduamhLOFdEbEw4N3JiNTdrc01TTko1TSt0?=
 =?utf-8?B?U2lJbHlRUUMxbFZzeFFVZ0NQeHRtNTZ0OUY3bUMzN3d4dmxkaVphWnUzZzVU?=
 =?utf-8?B?QWlndWhtUWI1VTgxT2I0K21DMmEvcmF0cG5DRWxmTGt2bmEzU3c3L205M05X?=
 =?utf-8?B?YjU1Sk5iQ0Fzd1VLb3NBY0JpeWViTFV5czFHYlJ6SlJKbUtVbVJPT0VXV3Zr?=
 =?utf-8?B?VXRFRk5KdU9WS3lCd041UG15dzlWMHd0dUg4Sy9TMUg3MXF3cTluZmVacmZY?=
 =?utf-8?B?ekt2YW91Z2ZnTVRHaFhSTDZLWlEvNmtCR0tZM3M2cDBGSnBvWkI0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c33e1cb-6ebe-49ae-9a1a-08da4d34fdc5
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 12:05:22.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYCvKIAA8RRoQTX7FA8RVQXYfc/AcALZYoLc80FOnvnli7pAQWOMtgUFukKZcxu9yFEzQAefXfdusYrZGOO/XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

Thank you for reviewing and picking up this patch.
I've shared some observations w.r.t. p->nr_cpus_allowed,
num_online_cpus() and NR_CPUS based on the discussion in
the thread.

tl;dr

p->nr_cpus_allowed seems to be equal to the num_online_cpus()
at the time of fork as opposed to NR_CPUS based on my testing.

On 6/9/2022 5:24 PM, Peter Zijlstra wrote:
> On Thu, Apr 07, 2022 at 04:42:22PM +0530, K Prateek Nayak wrote:
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d4bd299d67ab..520593bf0de6 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9215,6 +9215,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>>  
>>  	case group_has_spare:
>>  		if (sd->flags & SD_NUMA) {
>> +			int imb;
>>  #ifdef CONFIG_NUMA_BALANCING
>>  			int idlest_cpu;
>>  			/*
>> @@ -9232,10 +9233,19 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>>  			 * Otherwise, keep the task close to the wakeup source
>>  			 * and improve locality if the number of running tasks
>>  			 * would remain below threshold where an imbalance is
>> -			 * allowed. If there is a real need of migration,
>> -			 * periodic load balance will take care of it.
>> +			 * allowed while accounting for the possibility the
>> +			 * task is pinned to a subset of CPUs. If there is a
>> +			 * real need of migration, periodic load balance will
>> +			 * take care of it.
>>  			 */
>> -			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))
>> +			imb = sd->imb_numa_nr;
>> +			if (p->nr_cpus_allowed != num_online_cpus()) {
>> +				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>> +
>> +				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
>> +				imb = min(cpumask_weight(cpus), sd->imb_numa_nr);
>> +			}
>> +			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, imb))
>>  				return NULL;
>>  		}
> 
> OK, so I've gone collecting patches, and this conflicts with the NUMA
> patches from Mel.
> 
> Now, I can (and have) fixed up the conflict,

Thank you for resolving the conflicts.

but it did make me look at
> this in a little more detail; and the thing I noticed is that your:
> 
>   'p->nr_cpus_allowed != num_online_cpus()'
> 
> test makes no sense. That's basically 'true'. The thing is,
> nr_cpus_allowed is initialized to NR_CPUS, and unless someone somewhere
> did set_cpus_allowed() on it, it'll still be NR_CPUS.
> 
> Also, CPU hotplug doesn't change nr_cpus_allowed, so num_online_cpus()
> is just plain wrong.

I agree this is true. If we offline CPUs, the p->nr_cpus_allowed of
already running tasks will remain same but the wakeup path through
find_idlest_group is only traversed during initial placment and from
what I understand, the nr_cpus_allowed during fork will be equal to,
or less than num_online_cpus() unless there is a race with CPU hotplug.

To verify the same, I added the below debug patch to
5.19.0-rc2 tip/sched/core at
commit: f3dd3f674555 "sched: Remove the limitation of WF_ON_CPU on wakelist if wakee cpu is idle"
to check the values of p->nr_cpus_allowed, num_online_cpus() and NR_CPUS,
when we are in find_idlest_group() method:

--
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8bed75757e65..596d45d148b0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9169,6 +9169,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 		break;
 
 	case group_has_spare:
+	trace_printk("%s: %u %u %u\n", p->comm, p->nr_cpus_allowed, num_online_cpus(), NR_CPUS);
 #ifdef CONFIG_NUMA
 		if (sd->flags & SD_NUMA) {
 			int imb_numa_nr = sd->imb_numa_nr;
--

Testing was done on a single socket 64C/128T Zen3 machine.
The configuration consists of 4 sched domain (SMT, MC, NUMA1, NUMA2)
and hence same log appears 4 times as we traverse down the hierarchy
in find_idlest_cpu() that calls find_idlest_group() at each level.
Following are the commands ran along with the relavent logs:

#                                                                             _----------->  p->nr_cpus_allowed
#                                                                            /    _------->  num_online_cpus()
#                                                                            |   /    _--->  NR_CPUS
#                                                                            |   |   /
#                                                                            |   |   |
              ls-2750    [006] d..1.    97.486667: find_idlest_group: bash: 128 128 8192
              ls-2750    [006] d..1.    97.486669: find_idlest_group: bash: 128 128 8192
              ls-2750    [006] d..1.    97.486670: find_idlest_group: bash: 128 128 8192
              ls-2750    [006] d..1.    97.486671: find_idlest_group: bash: 128 128 8192
# echo 0 > /sys/devices/system/cpu/cpu127/online
# ls
              ls-2753    [070] d..1.   103.661735: find_idlest_group: bash: 127 127 8192
              ls-2753    [070] d..1.   103.661737: find_idlest_group: bash: 127 127 8192
              ls-2753    [070] d..1.   103.661739: find_idlest_group: bash: 127 127 8192
              ls-2753    [070] d..1.   103.661740: find_idlest_group: bash: 127 127 8192
# echo 0 > /sys/devices/system/cpu/cpu126/online
# ls
              ls-2757    [070] d..1.   109.111868: find_idlest_group: bash: 126 126 8192
              ls-2757    [070] d..1.   109.111871: find_idlest_group: bash: 126 126 8192
              ls-2757    [070] d..1.   109.111872: find_idlest_group: bash: 126 126 8192
              ls-2757    [070] d..1.   109.111873: find_idlest_group: bash: 126 126 8192
# echo 0 > /sys/devices/system/cpu/cpu125/online
# ls
              ls-2760    [070] d..1.   113.816679: find_idlest_group: bash: 125 125 8192
              ls-2760    [070] d..1.   113.816682: find_idlest_group: bash: 125 125 8192
              ls-2760    [070] d..1.   113.816683: find_idlest_group: bash: 125 125 8192
              ls-2760    [070] d..1.   113.816684: find_idlest_group: bash: 125 125 8192
# echo 0 > /sys/devices/system/cpu/cpu124/online
# ls
              ls-2763    [066] d..1.   118.288481: find_idlest_group: bash: 124 124 8192
              ls-2763    [066] d..1.   118.288483: find_idlest_group: bash: 124 124 8192
              ls-2763    [066] d..1.   118.288485: find_idlest_group: bash: 124 124 8192
              ls-2763    [066] d..1.   118.288485: find_idlest_group: bash: 124 124 8192
# taskset -c 0-127 ls
              ls-2765    [066] d..1.   133.659570: find_idlest_group: bash: 124 124 8192
              ls-2765    [066] d..1.   133.659572: find_idlest_group: bash: 124 124 8192
              ls-2765    [066] d..1.   133.659573: find_idlest_group: bash: 124 124 8192
              ls-2765    [066] d..1.   133.659574: find_idlest_group: bash: 124 124 8192
              ls-2765    [066] d..1.   133.660128: find_idlest_group: taskset: 124 124 8192
              ls-2765    [066] d..1.   133.660130: find_idlest_group: taskset: 124 124 8192
              ls-2765    [066] d..1.   133.660132: find_idlest_group: taskset: 124 124 8192
              ls-2765    [066] d..1.   133.660132: find_idlest_group: taskset: 124 124 8192
# taskset -c 0-120 ls
              ls-2766    [066] d..1.   139.525659: find_idlest_group: bash: 124 124 8192
              ls-2766    [066] d..1.   139.525661: find_idlest_group: bash: 124 124 8192
              ls-2766    [066] d..1.   139.525662: find_idlest_group: bash: 124 124 8192
              ls-2766    [066] d..1.   139.525663: find_idlest_group: bash: 124 124 8192
              ls-2766    [066] d..1.   139.526283: find_idlest_group: taskset: 121 124 8192
              ls-2766    [066] d..1.   139.526285: find_idlest_group: taskset: 121 124 8192
              ls-2766    [066] d..1.   139.526287: find_idlest_group: taskset: 121 124 8192
              ls-2766    [066] d..1.   139.526288: find_idlest_group: taskset: 121 124 8192

From the above logs, we can see:
o p->nr_cpus_allowed is equal to the value of num_online_cpus() at fork.
o p->nr_cpus_allowed of new task and num_online_cpus() change with CPU
  hotplug activity.
o taskset with mask containing offlined CPUs will only count the online
  CPUs towards p->nr_cpus_allowed.
o NR_CPUS seem to be remain same at 8192 despite the hotplug activity.

Following are the relevant lines from my .config for NR_CPUS:

CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192

When there is a race between CPU hotpug activity, there might be a
difference between p->nr_cpus_allowed and num_online_cpus() as shown
in the logs below:

#                                                                             _----------->  p->nr_cpus_allowed
#                                                                            /    _------->  num_online_cpus()
#                                                                            |   /    _--->  NR_CPUS
#                                                                            |   |   /
#                                                                            |   |   |
           <...>-2863    [071] d..1.  1172.474901: find_idlest_group: bash: 124 124 8192
           <...>-2863    [071] d..1.  1172.474904: find_idlest_group: bash: 124 124 8192
           <...>-2863    [071] d..1.  1172.474906: find_idlest_group: bash: 124 124 8192
           <...>-2863    [071] d..1.  1172.474907: find_idlest_group: bash: 124 124 8192
# systemd-udevd is waking up
# echo 0 > /sys/devices/system/cpu/cpu123/online
# systemd-udevd reaches find_idlest_group()
           <...>-1612    [059] d..1.  1172.515209: find_idlest_group: systemd-udevd: 124 123 8192
           <...>-1612    [059] d..1.  1172.515210: find_idlest_group: systemd-udevd: 124 123 8192
           <...>-1612    [059] d..1.  1172.515212: find_idlest_group: systemd-udevd: 124 123 8192
           <...>-1612    [059] d..1.  1172.515213: find_idlest_group: systemd-udevd: 124 123 8192
           <...>-1612    [059] d..1.  1172.515449: find_idlest_group: systemd-udevd: 124 123 8192
           <...>-1612    [059] d..1.  1172.515450: find_idlest_group: systemd-udevd: 124 123 8192
           <...>-1612    [059] d..1.  1172.515452: find_idlest_group: systemd-udevd: 124 123 8192
           <...>-1612    [059] d..1.  1172.515452: find_idlest_group: systemd-udevd: 124 123 8192
           <...>-2863    [071] d..1.  1172.884914: find_idlest_group: bash: 123 123 8192
           <...>-2863    [071] d..1.  1172.884916: find_idlest_group: bash: 123 123 8192
           <...>-2863    [071] d..1.  1172.884918: find_idlest_group: bash: 123 123 8192
           <...>-2863    [071] d..1.  1172.884919: find_idlest_group: bash: 123 123 8192

Here, the systemd-udevd process has p->nr_cpus_allowed set to 124
during the fork but by the time it reaches find_idlest_group(),
CPU 123 goes offline and hence num_online_cpus() reports 123.

> 
> Now, something that might work is:
> 
>   'p->nr_cpus_allowed < num_online_cpus()'
>

This condition can help the case above when the initial task
placement races with CPU offlining but if a CPU comes online,
as a part of hotplug, the condition will be true and we'll end
up performing the cpumask operation. Hence as it stands,
"p->nr_cpus_allowed != num_online_cpus()" should be a good
enough check for most cases.

> And even that is no guarantee. You can construct a situation where this
> is still false even though you actually have a constrained set.
> Consider a machine with 8 CPUs. Then set the mask to: 0x55, which has 4
> CPUs set. Then offline the last 4 so that the online mask becomes 0x0f.
> 
> Then the effective mask is 0x05, and the number we're looking for above
> is 2, but the suggested test would still be false, because
> nr_cpus_allowed would be 4, as would num_online_cpus().

When we use a taskset to define a new task's affinity to 0x55 and
concurrently there is a offline operation in progress which will offline
CPUs 4-7, and the new task creation gets delayed, in that case we will end
up with a situation that p->nr_cpus_allowed == 4 and num_online_cpus() == 4,
but p->cpus_ptr is not a subset of cpus_online_mask.

However given that in practice the CPU offline operation is rare, and the
fact that the path through find_idlest_group() will most likely be traversed
only during the initial placement, such a scenario is extremely unlikely.

> 
> Find below what I've made of it (on top of Mel's patches), but I'm not
> sure this is what we want.  For now I'll leave it commented out.
> 
> ---
> Subject: sched/fair: Consider CPU affinity when allowing NUMA imbalance in find_idlest_group()
> From: K Prateek Nayak <kprateek.nayak@amd.com>
> Date: Thu, 7 Apr 2022 16:42:22 +0530
> 
> From: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> In the case of systems containing multiple LLCs per socket, like
> AMD Zen systems, users want to spread bandwidth hungry applications
> across multiple LLCs. Stream is one such representative workload where
> the best performance is obtained by limiting one stream thread per LLC.
> To ensure this, users are known to pin the tasks to a specify a subset
> of the CPUs consisting of one CPU per LLC while running such bandwidth
> hungry tasks.
> 
> Suppose we kickstart a multi-threaded task like stream with 8 threads
> using taskset or numactl to run on a subset of CPUs on a 2 socket Zen3
> server where each socket contains 128 CPUs
> (0-63,128-191 in one socket, 64-127,192-255 in another socket)
> 
> Eg: numactl -C 0,16,32,48,64,80,96,112 ./stream8
> 
> Here each CPU in the list is from a different LLC and 4 of those LLCs
> are on one socket, while the other 4 are on another socket.
> 
> Ideally we would prefer that each stream thread runs on a different
> CPU from the allowed list of CPUs. However, the current heuristics in
> find_idlest_group() do not allow this during the initial placement.
> 
> Suppose the first socket (0-63,128-191) is our local group from which
> we are kickstarting the stream tasks. The first four stream threads
> will be placed in this socket. When it comes to placing the 5th
> thread, all the allowed CPUs are from the local group (0,16,32,48)
> would have been taken.
> 
> However, the current scheduler code simply checks if the number of
> tasks in the local group is fewer than the allowed numa-imbalance
> threshold. This threshold was previously 25% of the NUMA domain span
> (in this case threshold = 32) but after the v6 of Mel's patchset
> "Adjust NUMA imbalance for multiple LLCs", got merged in sched-tip,
> Commit: e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance
> when SD_NUMA spans multiple LLCs") it is now equal to number of LLCs
> in the NUMA domain, for processors with multiple LLCs.
> (in this case threshold = 8).
> 
> For this example, the number of tasks will always be within threshold
> and thus all the 8 stream threads will be woken up on the first socket
> thereby resulting in sub-optimal performance.
> 
> The following sched_wakeup_new tracepoint output shows the initial
> placement of tasks in the current tip/sched/core on the Zen3 machine:
> 
> stream-5313    [016] d..2.   627.005036: sched_wakeup_new: comm=stream pid=5315 prio=120 target_cpu=032
> stream-5313    [016] d..2.   627.005086: sched_wakeup_new: comm=stream pid=5316 prio=120 target_cpu=048
> stream-5313    [016] d..2.   627.005141: sched_wakeup_new: comm=stream pid=5317 prio=120 target_cpu=000
> stream-5313    [016] d..2.   627.005183: sched_wakeup_new: comm=stream pid=5318 prio=120 target_cpu=016
> stream-5313    [016] d..2.   627.005218: sched_wakeup_new: comm=stream pid=5319 prio=120 target_cpu=016
> stream-5313    [016] d..2.   627.005256: sched_wakeup_new: comm=stream pid=5320 prio=120 target_cpu=016
> stream-5313    [016] d..2.   627.005295: sched_wakeup_new: comm=stream pid=5321 prio=120 target_cpu=016
> 
> Once the first four threads are distributed among the allowed CPUs of
> socket one, the rest of the treads start piling on these same CPUs
> when clearly there are CPUs on the second socket that can be used.
> 
> Following the initial pile up on a small number of CPUs, though the
> load-balancer eventually kicks in, it takes a while to get to {4}{4}
> and even {4}{4} isn't stable as we observe a bunch of ping ponging
> between {4}{4} to {5}{3} and back before a stable state is reached
> much later (1 Stream thread per allowed CPU) and no more migration is
> required.
> 
> We can detect this piling and avoid it by checking if the number of
> allowed CPUs in the local group are fewer than the number of tasks
> running in the local group and use this information to spread the
> 5th task out into the next socket (after all, the goal in this
> slowpath is to find the idlest group and the idlest CPU during the
> initial placement!).
> 
> The following sched_wakeup_new tracepoint output shows the initial
> placement of tasks after adding this fix on the Zen3 machine:
> 
> stream-4485    [016] d..2.   230.784046: sched_wakeup_new: comm=stream pid=4487 prio=120 target_cpu=032
> stream-4485    [016] d..2.   230.784123: sched_wakeup_new: comm=stream pid=4488 prio=120 target_cpu=048
> stream-4485    [016] d..2.   230.784167: sched_wakeup_new: comm=stream pid=4489 prio=120 target_cpu=000
> stream-4485    [016] d..2.   230.784222: sched_wakeup_new: comm=stream pid=4490 prio=120 target_cpu=112
> stream-4485    [016] d..2.   230.784271: sched_wakeup_new: comm=stream pid=4491 prio=120 target_cpu=096
> stream-4485    [016] d..2.   230.784322: sched_wakeup_new: comm=stream pid=4492 prio=120 target_cpu=080
> stream-4485    [016] d..2.   230.784368: sched_wakeup_new: comm=stream pid=4493 prio=120 target_cpu=064
> 
> We see that threads are using all of the allowed CPUs and there is
> no pileup.
> 
> No output is generated for tracepoint sched_migrate_task with this
> patch due to a perfect initial placement which removes the need
> for balancing later on - both across NUMA boundaries and within
> NUMA boundaries for stream.
> 
> Following are the results from running 8 Stream threads with and
> without pinning on a dual socket Zen3 Machine (2 x 64C/128T):
> 
> During the testing of this patch, the tip sched/core was at
> commit: 089c02ae2771 "ftrace: Use preemption model accessors for trace
> header printout"
> 
> Pinning is done using: numactl -C 0,16,32,48,64,80,96,112 ./stream8
> 
> 	           5.18.0-rc1               5.18.0-rc1                5.18.0-rc1
>                tip sched/core           tip sched/core            tip sched/core
>                  (no pinning)                + pinning              + this-patch
> 								       + pinning
> 
>  Copy:   109364.74 (0.00 pct)     94220.50 (-13.84 pct)    158301.28 (44.74 pct)
> Scale:   109670.26 (0.00 pct)     90210.59 (-17.74 pct)    149525.64 (36.34 pct)
>   Add:   129029.01 (0.00 pct)    101906.00 (-21.02 pct)    186658.17 (44.66 pct)
> Triad:   127260.05 (0.00 pct)    106051.36 (-16.66 pct)    184327.30 (44.84 pct)
> 
> Pinning currently hurts the performance compared to unbound case on
> tip/sched/core. With the addition of this patch, we are able to
> outperform tip/sched/core by a good margin with pinning.
> 
> Following are the results from running 16 Stream threads with and
> without pinning on a dual socket IceLake Machine (2 x 32C/64T):
> 
> NUMA Topology of Intel Skylake machine:
> Node 1: 0,2,4,6 ... 126 (Even numbers)
> Node 2: 1,3,5,7 ... 127 (Odd numbers)
> 
> Pinning is done using: numactl -C 0-15 ./stream16
> 
> 	           5.18.0-rc1               5.18.0-rc1                5.18.0-rc1
>                tip sched/core           tip sched/core            tip sched/core
>                  (no pinning)                 +pinning              + this-patch
> 								       + pinning
> 
>  Copy:    85815.31 (0.00 pct)     149819.21 (74.58 pct)    156807.48 (82.72 pct)
> Scale:    64795.60 (0.00 pct)      97595.07 (50.61 pct)     99871.96 (54.13 pct)
>   Add:    71340.68 (0.00 pct)     111549.10 (56.36 pct)    114598.33 (60.63 pct)
> Triad:    68890.97 (0.00 pct)     111635.16 (62.04 pct)    114589.24 (66.33 pct)
> 
> In case of Icelake machine, with single LLC per socket, pinning across
> the two sockets reduces cache contention, thus showing great
> improvement in pinned case which is further benefited by this patch.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Link: https://lkml.kernel.org/r/20220407111222.22649-1-kprateek.nayak@amd.com
> ---
>  kernel/sched/fair.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9210,6 +9210,7 @@ find_idlest_group(struct sched_domain *s
>  	case group_has_spare:
>  #ifdef CONFIG_NUMA
>  		if (sd->flags & SD_NUMA) {
> +			int imb_numa_nr = sd->imb_numa_nr;
>  #ifdef CONFIG_NUMA_BALANCING
>  			int idlest_cpu;
>  			/*
> @@ -9227,13 +9228,22 @@ find_idlest_group(struct sched_domain *s
>  			 * Otherwise, keep the task close to the wakeup source
>  			 * and improve locality if the number of running tasks
>  			 * would remain below threshold where an imbalance is
> -			 * allowed. If there is a real need of migration,
> -			 * periodic load balance will take care of it.
> +			 * allowed while accounting for the possibility the
> +			 * task is pinned to a subset of CPUs. If there is a
> +			 * real need of migration, periodic load balance will
> +			 * take care of it.
>  			 */
> +			if (p->nr_cpus_allowed < num_online_cpus()) {
> +				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +
> +				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
> +				imb_numa_nr = min(cpumask_weight(cpus), sd->imb_numa_nr);
> +			}
> +
>  			imbalance = abs(local_sgs.idle_cpus - idlest_sgs.idle_cpus);
>  			if (!adjust_numa_imbalance(imbalance,
>  						   local_sgs.sum_nr_running + 1,
> -						   sd->imb_numa_nr)) {
> +						   imb_numa_nr)) {
>  				return NULL;
>  			}
>  		}

Thank you again for resolving the conflict and picking up
this patch.
--
Thanks and Regards,
Prateek
