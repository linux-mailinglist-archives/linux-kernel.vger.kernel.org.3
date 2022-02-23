Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A254C164A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbiBWPPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241193AbiBWPPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:15:19 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2051.outbound.protection.outlook.com [40.107.100.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25874B8B53
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:14:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+sclffor+xOr+rJV4vp2k8Hupv+GdRt+Xfn3Ehy5oxr1hJO7I9ydtj0Jte5oNFg0+jKEsA1fJO4+cGcC1JPC6N77ctj4UPQaYF+oDj9hMQGc2dgdx7fCYCgJXsrDTSWz77zMYGBEm2Wdqj4a0tokVVCM6plGMG4Gpwfj+2fthJEQo4Gqs5eEM+HbXAg3OcOsUXilUkNqicfg9qYKiOQRxrh8kw+WpUD/jPTiOb1XCpeFPjsMY4D6jPm/ZHSJIxagf57dOHBGft3wbKDKNsyJGXcX7WNnEPxQgEXN25r49VwPeWaZmxnDvWkb7jjY1E7pvmWmUSiCUlM73hR7XdnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjDta4TuNy1YMeHTmAy4EK0amBwwDTj21aR1fDBYm90=;
 b=k9tNR4XNzj/4+Ge5lYx16EiLgE8mYDKR1DTWdtsAwsmIrHXBdoGOQeaUMOoKK6Nog7yWXDk6uOdGZl1T+HiGS4HV/klQWSqUc126nX3PL18l9CQsuX3GwOI125ZD32FA008mGThfRh2i2KJPzmDauDYWarkpGko0+I1iRWM/ibnVFo1gpsbHq5iNcszykihQCYt25Pgs3dlD74VRObtsOOEMv3uDsFIKeBQHBbfpiPL9GGxVtoe6vx9Vu6F72NH7RI/YvIDJkQmZsONGPpzUTO8BNkBuu3QlO/vl3J9a+ZcL/SKFpfLhPB9wxs2qqmOkMEJ+y07EuXbI2g37aK2pkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjDta4TuNy1YMeHTmAy4EK0amBwwDTj21aR1fDBYm90=;
 b=2BzH/KZAcygxJ+daG102zdPDCIEw5k2AO15iFNxKnM4BkniHkxdNJhdunE6/dM5FpsGTY/yDCovPaYH0bK4w5rp35c3CowmwOGqIcX0Lz1G3qnAZganP3gyNtg8Vd+nkg+gLcWGp1d5cS/WxZ7f7tjU3J1TqrGRBV4Dlri8VrhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MN2PR12MB3710.namprd12.prod.outlook.com (2603:10b6:208:16d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 23 Feb
 2022 15:14:48 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8d44:d69b:b031:1d50]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8d44:d69b:b031:1d50%4]) with mapi id 15.20.5017.023; Wed, 23 Feb 2022
 15:14:48 +0000
Message-ID: <aac8f860-c01f-bda0-9f1b-029b234213c2@amd.com>
Date:   Wed, 23 Feb 2022 09:14:45 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] kernel/sched: Update schedstats when migrating threads
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
References: <20220126152222.5429-1-carlos.bilbao@amd.com>
 <YhYKL4hxx4TNKHGD@hirez.programming.kicks-ass.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <YhYKL4hxx4TNKHGD@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:208:d4::33) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46998637-c223-4b50-c521-08d9f6df3b5b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3710:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3710FCACD71DD38191284630F83C9@MN2PR12MB3710.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCsQXbrKl7LNUWVmcMl/dH1cPZgGA5WZPCjT/Dhxm6CdQeFT1DmaPDNNI+C9rJ6ItLdavu5Avpdi7CfXNsykxecyNdryFXAfcV+BM5BPnrJ85TUsATuTCmrtuxICqCh2AmBltqZt7b6INX0ehMBACCf/fg1QjVQqCc2eSySoKGPv48CDPr/HfJjUKu2P/2XgwJ5SiBafY9ACJgCWsDwop2xzA/Y1RKO+V3HT4Mxkgz3QVZbD8Osn56RR2SxFHu0CaWlA2eEeR6ux3q4POCyVVDnqz6gF+jHt/2vqqEysAY3rEKPzbX9bpVcGJDC3SGrFFfNoYXfXoSiwIqrEm9s5zgsZQTNYrTZsrMDHaN2bcURSPUnK/tWjk9Ulj7G2ldKmO+XEh1jQ3XGhdWMTMpF9+3yQQ29SQdGlD9e/i7VbjLKFzCKePyf5wsg9B20aYAFAhi665AmXkSXPzF1JpHnIMtvg+toixjGWP3/ZLLmnWTQk0GhULs0I9KLMW5B4xe1uGwrU/CIwpOJpevUtz3AXa3f95xt92NaGALkMGWIqsOZKO5ZzjoN8vKyLNaD2qqHu6W5h5Vd+dIV5ehMUKmw4xMNwiMZfkGSCr34LxiO4u28L/+OeJ6apZLMGhfugTE4J0gj6gQGq0NtKIa7yNoybGxM2eLwrxYZXyLZzGxmkM9kXlmiuKSPUhP8T3bBB00zi5yug0f6BHCvsHEaNzrqDtWlvUd7S85qc6nIpCEcdtyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(31686004)(83380400001)(86362001)(31696002)(38100700002)(66476007)(66556008)(66946007)(53546011)(36756003)(186003)(26005)(6666004)(2616005)(6506007)(7416002)(5660300002)(4326008)(8676002)(316002)(6486002)(508600001)(2906002)(6512007)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG5ocDRFTm9wdUprRUxSUnBiQlBWSEJXSnNSdndKVHFiVlliQjNSSXVrZEdJ?=
 =?utf-8?B?VTM5NGxsOUxhMm1PNWM1RVplcEhiYzhrb25mcTZzcDI4NnloVWtHZmFUNkM0?=
 =?utf-8?B?Q0JMQ1BxQXdmNHNIOERTNmprMEdRazRaVFZQOWlMcXUrZXJTV3k3bHFyQUFW?=
 =?utf-8?B?ME1qNDdkMk1GbFBNNmhtQjdTek1zUTNSSGxIV0FQRHBJWTNRUDMzRE1sYU55?=
 =?utf-8?B?N3pIQmxzZG5VUnM2VTNvMG4rRWV0QmxVRHJuSkV6dG5SbHBBZjFxVTFZQzdC?=
 =?utf-8?B?dTYycWEzVHBXM0dIZnZOazRVVHpYQjMrdmpSVExSbVZZR1JZb1hhZExCUDBS?=
 =?utf-8?B?TWpxT1Ryb0Y5NEQ4NzgxQnZJZk1xVmY5WXpGdTFaM1NZUTFmY0ZGR0poZi8y?=
 =?utf-8?B?VWJQaFl0TnNLUDdnUS9DZVdHNDNWZ2pnMEVzc2E1bzg0M0o0ZWl2eG9qMnha?=
 =?utf-8?B?SW1ESEY2VVkva3hadm9UaEdJOGVYOUFkV2txbkFzaG1rSEFjK1JNWmdQQ05m?=
 =?utf-8?B?bldOd0xaTXQxcWhnbzlnTkM4bzMyd3p2YUNLdWZYOU1VNnF0TU0ySlBTZmJU?=
 =?utf-8?B?Z0s0UkZFQy9ramkrWlA2MjNoc1EvTlBCTnF0QXNPVlJUVWRndHN3bGdMWldh?=
 =?utf-8?B?ckhkVkR2R3J1OVRSdHVYKzh1d1l6d1ZNRjQ5dmlHMVRROUcyRlNSem1jUjZB?=
 =?utf-8?B?VGVpMjZQZERncVJtWncvR2lIUjVXTSsrNWs1K29QYTBNV0RIbVNUZUhxWkk3?=
 =?utf-8?B?Wlc2cHJnYkw2ZVAxZ2MvZzcvK0t4LzZTOVV2TXk2N2ZmNFdqTE1DSmF2VmJF?=
 =?utf-8?B?OFFDUHFUVFA0UW1BdVMrNWE3VGZldW9jVG5WY3BCcUFFOTRiQjYyTEVQWTZ0?=
 =?utf-8?B?MUM0d1c0L2dkeTJZMzg1K1lPR0o5aFVqRkQ2Tk1MeXBHRE5odjJxTVpsZ0Zt?=
 =?utf-8?B?czd6OTNkN21nYnMwWVhDYUhrYXF5RkdseFZwMzRjUVNDL3lkV0tpcEJLNUNZ?=
 =?utf-8?B?RktKck9NWXN0ODNncVZOQXdDQWY3bm1IeFVFTFdMVjRFcXA4MkNkMm1UcXNQ?=
 =?utf-8?B?Uk9jK254WTF1RExlem9DUWdpeUJqVGhLQmM4TjhTSm9qYnlYSkd5aFVpeGtN?=
 =?utf-8?B?UXJRQUtGNkt6TVkwRmllbStoK2ZjZWo3YW9yWWhBV3ZMV1RMcFJkY0pubDZx?=
 =?utf-8?B?enZJM0x2SnpWZzRkR1RpLzdnakxRZzFYQ3YreFM3K1F1TlZ1WVpFZXpZRWFi?=
 =?utf-8?B?Y0Q2dWpQZHl0V0t4ZFhvTnA3U3NZbTRVZ1VralRsTmQ5YU14R2J4YmRIV1Nn?=
 =?utf-8?B?S1VVWWszNW9PYVlwOERaVUlYRnVlYTdxaStNSXdiVi8vWjJ5RDRDRXQ3alN5?=
 =?utf-8?B?MDVOZkhzOUdiVkVlZFVJcXJLYS9jalRoVG85eTN6WjhCcGQycnd0UFhLRzB2?=
 =?utf-8?B?Z2h4bGZvSndMdnhYMDdaanhMK1J4TE10U1FaNVM2bExQRFUzNDZuMW9lRjNi?=
 =?utf-8?B?cDh3UE5nZnNEd2UxUXM3Y0lnekF6YjRVb2NwZGh3U0Rlc1dhOTdNSmJEYlV6?=
 =?utf-8?B?OGRGU3hZMEs0eGVrSnFYNGFHeE45L29rK3pnU2x3MGNoeDh5bTFReXRSaisx?=
 =?utf-8?B?ZXB3Y1A5VldwVVc5QlFwS29RMytHT3JJQ2cwWmRJQ3l5SmQ4bTRPeTJjbE1W?=
 =?utf-8?B?UlkxZ0ppMGR2eW1uSkNWM2J0VjFMdlhLdCtZTW5yb3JybmJiSnFTbmEwZ1hp?=
 =?utf-8?B?VzNGTlNDSmZ2WmxvblVud2ZJdjY4YytYTnRCWkVjajk5bmlSM2o3Sy9VUURL?=
 =?utf-8?B?bjdpWDVFV2x1Vzd5ck1UVlFTOXBOdzB5NSswaVVpejdUUEYxaDJCS2JwR2hx?=
 =?utf-8?B?ai9YS3hZVm93UkkxajRoNWh1UUdGclFGL2RqMCsxSHBpMzl0K3MxMkFhR3Nz?=
 =?utf-8?B?aVdvRFYzUDNoWnlQYy9sMWFWcXJwYzNtK2FuK3kzc0xsOE10MjgzczE1S1VN?=
 =?utf-8?B?QkhpNVlLeDcvVFkrYndocUtLdVNOSGo4OHdETjEvRW9mOGVydi9rbEF6V2lt?=
 =?utf-8?B?L25RTy85Tk9sSzkvM09FU0VvSTRMcG0yamZqWkVIOGVsU3FseDJzZ05KWGhM?=
 =?utf-8?B?UkJNTTFZQ0xwanBuTzdhcHQ1TW1qZEdKSjVzZDIzbERUNHpud09idzEwRnJF?=
 =?utf-8?Q?6RyB1LBtywN1jKU/QHQHPj8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46998637-c223-4b50-c521-08d9f6df3b5b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 15:14:48.5679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxUFm4DrgNN/F/udB7I8uavHZ0fj04nG8KPfYL3s22MbKKXIYfqNB9h65XRVtofkdyFYYOj4WolKeuyECMDKvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3710
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/2022 4:19 AM, Peter Zijlstra wrote:
> On Wed, Jan 26, 2022 at 09:22:23AM -0600, Carlos Bilbao wrote:
>> The kernel manages per-task scheduler statistics or schedstats. Such
>> counters should be reinitialized when the thread is migrated to a
>> different core rq, except for the values recording number of migrations.
> 
> I'm confused, why should we reset schedstats on migrate? I'm thinking
> this breaks per-task, since tasks tend to bounce around quite a lot.
> 

Thanks for your comments, Peter. 

Looking at the documentation of schedstats I see that most values are 
actually linked to the particular CPU: time spent on the cpu, timeslices 
run on this cpu, number of times _something_ was called when the cpu was 
idle, and so forth. Those values lose their meaning after migration and we 
should reinitialize their counters. However, reviewing sched_statistics I 
identify two fields that we should definitely keep increasing even after 
migration (nr_migrations_cold, nr_forced_migrations).

So this patch will have to be upgraded if there's some other value(s) in
schedstats that we do not want to reinitialize either.

>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>  kernel/sched/core.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index fe53e510e711..d64c2a290176 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -8757,6 +8757,7 @@ bool sched_smp_initialized __read_mostly;
>>  int migrate_task_to(struct task_struct *p, int target_cpu)
>>  {
>>  	struct migration_arg arg = { p, target_cpu };
>> +	uint64_t forced_migrations, migrations_cold;
>>  	int curr_cpu = task_cpu(p);
>>  
>>  	if (curr_cpu == target_cpu)
>> @@ -8765,7 +8766,14 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>>  	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
>>  		return -EINVAL;
>>  
>> -	/* TODO: This is not properly updating schedstats */
>> +	if (schedstat_enabled()) {
>> +		forced_migrations = schedstat_val(p->stats.nr_forced_migrations);
>> +		migrations_cold = schedstat_val(p->stats.nr_migrations_cold);
>> +		memset(&p->stats, 0, sizeof(p->stats));
>> +		schedstat_set(p->stats.nr_forced_migrations, forced_migrations);
>> +		schedstat_set(p->stats.nr_migrations_cold, migrations_cold);
>> +		schedstat_inc(p->stats.nr_migrations_cold);
>> +	}
>>  
>>  	trace_sched_move_numa(p, curr_cpu, target_cpu);
>>  	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
>> -- 
>> 2.27.0
>>

Thanks,
Carlos
