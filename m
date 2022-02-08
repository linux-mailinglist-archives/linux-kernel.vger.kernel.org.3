Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C8C4AD7A4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346191AbiBHLfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356984AbiBHLOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:14:53 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C471CC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:14:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HruahWG1rxkRc3PYS3pESiKKfH7shTcIH5ZkUG20oKaQIvN54oxQkeNoByBhGURBMrcg4a2DLhMWOd2P44mMLnblBU2EJydbhM/3XH476zhZpBVcF1P0i23CsidsqxK3VLxVH6QhOQF9UWteg2Nhao6yJ0U08zab74XTtvVeo5sQHM7My2+KZWG3r61ISn84NwX5kyTwLKB4V+nVobsMjBzQvxqG6ccXJ8BA+YtKy7lhiAJJpL7sEgh5Ge1x/DX+SwEOUe7SiCUKOFLwGHerGPSfK6dJyXa08zAcnkmpiLJ98DbNXMUoxIuZaLuaq4aCSt8cdz2LQ8Em3N4WGE1xdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3ovS1t1FQDPrgAavwYdwFG1SAegZA4UOAVsLHS4BR0=;
 b=SmyNwd6pbqwNknzJKcgVocwKmcvWqDAXlBZQ2SbWq57XH2CVQ8DohCNeiPlPbrMe78oLm3gi7KyW5tn9+JIGr1VoNNgiuRtN+XrmZ1Frm7pg9raT7IFx8x47kLp5gofuUtzfR/zOeToE16M/IsjX17awLMiz8b/AqeTj29zxgDFbWmWvEEDGmUwGNS/cJEXb3I8YfY14w+fU5g0FWt5Xsh2u6LLeTBQFVOWIHA3fBWzUUicBaIe21ukqSOUNFKHGEjW0QpUtpQlH4LSvytg7K1Ohgw7zzlxWHXVTnCDR/BMDvRg70JzePs6aGPxX5Hz0qvqnLQyHflBiPiKADeHz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3ovS1t1FQDPrgAavwYdwFG1SAegZA4UOAVsLHS4BR0=;
 b=DwekJHmzg9fIzuoUFQWTepVG9B5VRzABawJkv/BJbHUk0eUzv24bbgA8keo9Yioh/pUJ0XSqmTGqoQ0QhAwbtin1+VpYzV5xyX0o8OvmR24BNLDyzURbpUulEbsgr9/qg3x37ibtzjgRWyPJN4lbkbTvJEsJVYhSnPyEO1ocrn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CH2PR12MB4214.namprd12.prod.outlook.com (2603:10b6:610:aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 11:14:48 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432%2]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 11:14:48 +0000
Message-ID: <9b1fbaf4-1ce9-7977-5f08-cc4c24fff756@amd.com>
Date:   Tue, 8 Feb 2022 16:44:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
References: <20220207155921.21321-1-kprateek.nayak@amd.com>
 <20220208105116.GO3366@techsingularity.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220208105116.GO3366@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::13) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ff34f78-4537-43c2-a274-08d9eaf437c3
X-MS-TrafficTypeDiagnostic: CH2PR12MB4214:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB421496841B98FDAFF4DD99B8982D9@CH2PR12MB4214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dVsUGB8GmX07riIfAW/0j1n0gsHdreoKYxOSYkqtcnb56Hq8h396KLSuIwAVf4Qxsfoguehtxzb6mhVhp5JBhvBxP6IRygGbOOjXlMvgC0vuclMwW5x6tDWK3pSiY7ol4J3GZgZHxv5+qKr2mliPOpOI29Wi9v+Sosw7Fdk2JJU/JHRDIEtvC7s8psthAPq/EkuLRxOCSm+/sJ4NXPk2VX6pXSQ0Z4JDUS/fbSoM9ELmGw+3PmaLA19tLvXcFWa7jJCHWhkbG0g8q8WT7UtphjvxXX8Dx8I64YiHBB/0vpZI+IhD5DXRO95cHPeZNL9kEx3qPehRaE0qSOWeNOeQHKfpvRlx6DY1yD1t4JBA1qbTwela8vr3aadUyfrKn6jhAttUFFipUg31nMrCvArFpPiw1hnSWzUiDlnVMFv5Vj/GH07TvUk9KFyrMISfTfaXE2SdilceI5o+YqZlW2nPQEhKDaJasvRLRQV1SvBAqJHR1r4iFK88TUWTbhcOuuqprwM+JyIqK+chuoGfSS5CmkU9ywe8I1huArkwmMOVqcP24hX9V5lyAoIRryZSWFQBPN47kbkEDG8+5flVuJpdkGH9Bb+DL1PSF19ekAbI8KOUY/tZzb82EH6zB1jUiL5ruqFIl0uurYToKhyNXeMPioyzg4EOo/dTBpnxUrm9nVjjRAlkuPsuAIJclv8xtqRi/yPEBX2rSuC8B7oD5eg9R8Uv8Opy76pD5L+WdbF4G5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(6512007)(8936002)(4326008)(66556008)(66476007)(38100700002)(66946007)(86362001)(31696002)(316002)(53546011)(508600001)(6486002)(6916009)(6666004)(6506007)(186003)(31686004)(2906002)(36756003)(2616005)(26005)(7416002)(83380400001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0h2MnR2cnNkQ1A5R010a3Q2NndQV2dNYjhvVnMvczNTQjlTTkxEN210Y1dM?=
 =?utf-8?B?TDRYSXdtekw2bWFwOW00REZUcStHalBvbGk1aFFiU3NaSElSTUZENE9GUWd0?=
 =?utf-8?B?VFRIa2pMUjR6RHg5ZHpHeDA4cWpRYUhpYXl4ZGxoSmxWTkJ0clVnSUZ5TkFS?=
 =?utf-8?B?OWlTTTFqT29RWXI2dlArWmxJYnh2ejNkajhRR1J0OWYyV2FqUC9YVUpJN1JW?=
 =?utf-8?B?d0RHWmJsUDNVSVgxVzFkaEVKV0ZmS1ZEYlU2aEp6VmZ4citoSExMY1lwQU5s?=
 =?utf-8?B?a0NNUEhOU1dnWDJXWUsrL21Tc3B2cDA4Um9tdDBrQ0JlOHo4OEc3OW9vbS9X?=
 =?utf-8?B?bU1OdURjV2QxNkJOQmFhR2NXdzYyK0YvS0FOeS9IOW5KRmR5MzZlZy90eERO?=
 =?utf-8?B?ZkR0ZnZrenkrTjNhNDhETjlxMXdWcFExNVpweW44UDNkM1V3ODJHQVF3ZWdi?=
 =?utf-8?B?Y21YVWtOdDAyeDFYNkFsS0ZTYXcySkRxcDZTZExNT2lJUDRXUmtiNG5LSlpF?=
 =?utf-8?B?alhOMVBIdlk4eURuRiszVlpOTTFzTS9uRmJ5cTR6YnZrdnQ0N0U0dGNVcHlD?=
 =?utf-8?B?aWU3S2lsTWNvUFlmKzVXeE5KemZXZ2RmYU1uYXFTR0hReENaZC90SVM0bWtV?=
 =?utf-8?B?TG1ITGwxNkQySVZsb1hybmRheEZpSUhQNG1DcXhsNUEyZ1Z1Q0ZzVEJmMysz?=
 =?utf-8?B?SU1ENUJkTjl6czBYYU5BcmJkL2QwdlpVUWdnVTlvaXQ3dE1xYVB3djNxcU9P?=
 =?utf-8?B?V1A2V0gzTXFIR212MHJNT2t3TXZESnhtYXdqQnpjMjRwUVlKbEhzVFRSZGNz?=
 =?utf-8?B?eHZOZkxHVUxCUDZ3Q3V6NVRuTmlmYnJPTTRkeGVKeG1JMDdRTnJhZDRRRldF?=
 =?utf-8?B?NHE2YXp3a3hoSS8xWVpKbVRqWWpWcmdHUm5TZXRFeWlJVVduMDR4V2E5SVkx?=
 =?utf-8?B?UGdleFcwL0YxRHM1eTVFaDhWZDBpdFhVdDBnVER1UnczR1JjMlRRcElVdVQx?=
 =?utf-8?B?bW1NREx5a21zTTU0bkZMMFdlTFp1WW9RRThZWWduWVZibTRIYVdHV0N5bisv?=
 =?utf-8?B?dXZJMmd1NjVwTzRQcTc2bC9yWU5YSmdvM08za28wdEpHQkNsMnBpL1VFSU1H?=
 =?utf-8?B?TE5yUU1UT3Nzb0F1bTFvZ29WL3Y5L3BlbFFETFpTZHBkVDdPbHRqNzFkUVVH?=
 =?utf-8?B?VFZKWmJGYWl6V0ZVSXNJRVVKU1dJZloyblFOcFdBMmVtV0RiS3pmLytmTVhm?=
 =?utf-8?B?RERnSUJFSjFWd2VldG5vWXdrM2xQaVVSYWVRTkliTDYwenRGSjVxR3FXVTVl?=
 =?utf-8?B?UTNwYnA4bnAyT3VGWFpOMUcxdWhiRHVXMmRlK1UvSUx6UjFMQXJILzhzODRM?=
 =?utf-8?B?RXFlWGFVdVRZU0RlckpVUVNuSHNRRUdTb2wzdzE2WVJiQmZFVGtMY3BaTFJU?=
 =?utf-8?B?ZEhjWW5haEwyU1BTcys1dkM2MFJUTnFYU290MmYxWWpBSnY3REZsc0VxSzBI?=
 =?utf-8?B?V2Jvb3hDRTF1QUw4SGc2elVCeVd1Zi9OeDQ2RFJwZ1hwZkRjbEhXcTNqK3Zh?=
 =?utf-8?B?bkl1LzJWMklVRldTODVmbSt0K1Zjc2Z2ZEFrdFJ1Sk5lSlk0Sm1jYkZaRFJK?=
 =?utf-8?B?dTdtNUJTZTBEdEp2MU9ualRMQ0hFT3hCOURnSFdicHJEdm5ZRTJsbGVKNTcr?=
 =?utf-8?B?VWtmd0N4NTBvUlRCVXFWNm1jVjEvTUxJcElucXFoYnJTeUFzdm5JZ3Nieml5?=
 =?utf-8?B?MlFkTDlRYXkvSHdvNm9sS1c2aHU2QllNZXJzZHh5eC9uU2VCdkkwb0twSUJj?=
 =?utf-8?B?S3FrcldMalVTbDZFck91L0hWaDBneDFhbmJYZWJDOEcvTjh3K2pweU1zSzdT?=
 =?utf-8?B?MlRKWlRDcEExM2xrbWV0VC9SN1Nyd05KMUJiYmcwZkhnbDUzN3hkdWpvRTRY?=
 =?utf-8?B?dUtqdm1hT1RPLy95ejhQOENqeEdUUEFxMXBrL29sbFFSNjl3SGdhaWswV000?=
 =?utf-8?B?YjViNjkxdmtHM0hRSkdOdXVCZGxKQm5nZ3B0THhrRmtDZUg0TTFWdW53OEw0?=
 =?utf-8?B?Z29ZOWQwUVNaRWNqdENjU0hHY1VOcm1lTndBcVlZVHU0MldMMEI0OWg3S1E5?=
 =?utf-8?B?UGEzcW85ZjF5a2F3MVFDbnp1Z003RWY2YXJzOGhxRTM2bWRwV1ZwR1pDQWRW?=
 =?utf-8?Q?8bj7ypZEE8fNWvSzb7pq2HI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff34f78-4537-43c2-a274-08d9eaf437c3
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 11:14:48.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPbOukYqfWVpmUZI9lrPdXhBaSrGbUIoGJOM64nPQpXyXsDs6C+r2BckihCKlz6iVc6xBJHlniPJIPp44U20OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4214
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel,

Thank you for taking a look at the patch.

On 2/8/2022 4:21 PM, Mel Gorman wrote:
> On Mon, Feb 07, 2022 at 09:29:21PM +0530, K Prateek Nayak wrote:
>> Neither the sched/tip nor Mel's v5 patchset [1] provides an optimal
>> new-task wakeup strategy when the tasks are affined to a subset of cpus
>> which can result in piling of tasks on the same set of CPU in a NUMA
>> group despite there being other cpus in a different NUMA group where the
>> task could have run in. A good placement makes a difference especially
>> in case of short lived task where the delay in load balancer kicking in
>> can cause degradation in perfromance.
>>
> Thanks.
>
> V6 was posted based on previous feedback. While this patch is building
> on top of it, please add Acked-by or Tested-by if the imbalance series
> helps the general problem of handling imbalances when there are multiple
> last level caches.

Yes, the imbalance series does a good job handling the general imbalance
problem in case of systems with multiple LLCs. This patch builds on top of
your effort to balance more aggressively in certain scenarios arising when
tasks are pinned to a subset of CPUs.
I'll run benchmarks against v6 and ack the results on the imbalance patchset.

>> <SNIP>
>>
>> Aggressive NUMA balancing is only done when needed. We select the
>> minimum of number of allowed cpus in sched group and the calculated
>> sd.imb_numa_nr as our imbalance threshold and the default behavior
>> of mel-v5 is only modified when the former is smaller than
>> the latter.
>>
> In this context, it should be safe to reuse select_idle_mask like this
> build tested patch
Thank you for pointing this out. I'll make the changes in the follow up.
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 538756bd8e7f..1e759c21371b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9128,6 +9128,8 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  
>  	case group_has_spare:
>  		if (sd->flags & SD_NUMA) {
> +			struct cpumask *cpus;
> +			int imb;
>  #ifdef CONFIG_NUMA_BALANCING
>  			int idlest_cpu;
>  			/*
> @@ -9145,10 +9147,15 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  			 * Otherwise, keep the task close to the wakeup source
>  			 * and improve locality if the number of running tasks
>  			 * would remain below threshold where an imbalance is
> -			 * allowed. If there is a real need of migration,
> -			 * periodic load balance will take care of it.
> +			 * allowed while accounting for the possibility the
> +			 * task is pinned to a subset of CPUs.  If there is a
> +			 * real need of migration, periodic load balance will
> +			 * take care of it.
>  			 */
> -			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))
> +			cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +			cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
> +			imb = min(cpumask_weight(cpus), sd->imb_numa_nr);
> +			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, imb))
>  				return NULL;
>  		}
>  

Thank you for the feedback and suggestions.

Thanks and Regards
Prateek

