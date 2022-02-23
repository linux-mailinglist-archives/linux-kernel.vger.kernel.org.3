Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9244C16E4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbiBWPee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbiBWPec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:34:32 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78DDB91DF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:34:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z04Fq+wP/E5heLH2pjqGTNCrfVxxvbhzM6zY4/MdtWAgdZYRA6XBbitJcuCXvRp3P/PUQx8mTd8Lsv2ztVE8Ick3sU9ZxYYVOxBEvId8ybAV5jFlksdSWigzF7PuPGfGD51L1xP8hgzgjggv3uWFkS421/TppAKkUDpOOaEcu0xDT3ib7SrDA6PpQN5Xcd5Q/XIFgEv0qeyotr2y3+0AXr+jD9SoSRJpgp+iJRhtcofbH1ab/pgbmBRWtzF6MnY/uMGzWJnzMXiJUlSlv35tG+F4CNPIJ0tyCe3iMvjqHo/CwiWHH9nQ/yNkCNEgu7xn8VUOM+ahsEoowzsN/3xRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghGrAOY4rYIGDRrzqm5YnhAZ+wD2YTxpG1/1Feu/Vg0=;
 b=nCJlK/pHCwCuqO92rXAgezUf8j8GsEpmNUQ8AdoDdlJux0nfSbQeuOZrFqDGhEFB03qkIRZmobXQ7/qnau1xbEUmnySYtItoXOe3LHvGLZVZfDKk5fzgQxLURm93+co1No3vgK35me49WcyR23yKJe1m9IgK6lLabpKGW8M+1+ER4W4E0d09P2MyMw1zDBM/HPWsEmCkJBwk6UD31OqDbCR5tVzgMVM8zrOPYxlJvyVfVFNGJRwpZH0XDSAv9VNrKqPwy+GMM6N+cZqJHkbP853T1LKMIIxv6DaBkYel9av51jgIgUS1dZY/0QxRWPIz8qBkt8r2ZLtLB0NvsiIEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghGrAOY4rYIGDRrzqm5YnhAZ+wD2YTxpG1/1Feu/Vg0=;
 b=gQFehrbiT18Cu3mK6IAo0q/595JzVUiSMWOUr9Kuhn9XGpblG3aiWeO0uw/u6jPvNyA/eJHTwguaZgbkLx+cN/BRnskPnexK9psKZrDvheVN3mnFoHMYerpAB0mciEV+01ig//tl584wLubcE7C6Tk4vEJoo0Oi6PYoOCPfmt+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM5PR1201MB2522.namprd12.prod.outlook.com (2603:10b6:3:ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Wed, 23 Feb
 2022 15:34:02 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8d44:d69b:b031:1d50]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8d44:d69b:b031:1d50%4]) with mapi id 15.20.5017.023; Wed, 23 Feb 2022
 15:34:02 +0000
Message-ID: <0e42c46a-ccc4-e793-00b8-ae407e06846f@amd.com>
Date:   Wed, 23 Feb 2022 09:33:59 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] kernel/sched: Update schedstats when migrating threads
Content-Language: en-US
To:     Phil Auld <pauld@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
References: <20220126152222.5429-1-carlos.bilbao@amd.com>
 <YhYKL4hxx4TNKHGD@hirez.programming.kicks-ass.net>
 <aac8f860-c01f-bda0-9f1b-029b234213c2@amd.com>
 <YhZSqd+d03oWUPP6@lorien.usersys.redhat.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <YhZSqd+d03oWUPP6@lorien.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:208:e8::28) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9123018d-eef2-4d5a-d6a4-08d9f6e1eb4c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2522:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB252229FCF7ECBBD68A8F8667F83C9@DM5PR1201MB2522.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9VMstd4cBFYUToqHXJUVUo/Nx3BvPaHN5heOZor2HDH+E2oMCdIz0JFZPe48w0jkmHGYUPvXBQ/RIL5t7YvFQ9OvDZHxPwcBBI7GqfJYxoLW6Lt64lRUg/n1Q24v+koksjMrQe6lOwVdZWjMGtBcXsFC1Fxvdir6No7o5wKlwdqAqCkwy18GSehMK2u9CLTNeNZXG07dyCKak7nYHwz9NcYwmi6eFgnZAVylxWsm6CKjtb23o/UyjcrRkWnHme+LxoNdFDT9QC5N3d0qolP5LG2TkdexihoRqO6YhYr5cwewVgq8MFKYPwVcq0Z9jt5aAwHvO66sMWsfps1HavGuQrPXYptHP0/+sBX4q1WR670syh3EPvxZFYnARqq6EYjOFYtTTnA62uVHkrRVQSh60E7lWLXTwPWX0HNAnS8MEILrbUCVSCKtW+XgAZHMY/93F/lp8Fu7CcgmoF1M7yScF+LrcuQmB8qyGGFs7HlcWiwa4l3K8H8DxxDqMs8qrpSvw8JpPOG5jNup7gj7QadDkr5a4NMevS2sbhMpJLMcWD8+IKu5vvJSdzrFWnt5MbDRqkV3w5UyopcYGw0TK4twSIB8743ZpPwsSbGaoudiFiRWyTAH6Y80lD3UCfciXV8KwmUx688cZv/eR51kuoXM5TsUHY257UFybWY1qXvLP2ITUbFzCi8TtjaGvaQC95hJqu5UzwKe4dDNR3MdnWKqUiNwNsTYJi1Hhl4eazHQHc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(38100700002)(186003)(2616005)(86362001)(53546011)(6666004)(6512007)(6506007)(2906002)(508600001)(6486002)(26005)(44832011)(31696002)(316002)(31686004)(6916009)(8676002)(4326008)(66556008)(66476007)(66946007)(5660300002)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUsxTHJ3NFI1bEY4TEF6VitDeWZtaDI0a01xakpzNS9oQStDNDROUFJGZ1Zk?=
 =?utf-8?B?T3J6eEg0YXFvQ25iL2VyV08rM1U1ekh1Zk1DWUVKWlBBbDJtZGg1QTRvUHUv?=
 =?utf-8?B?S0NSaVNQelRrMHQ1ekFFQ1hsNUFhbkl1THZxWWYrc3lNdXUwTUZiRjBQZHFX?=
 =?utf-8?B?aFdJaDdIYXFBNEhzaU9VWWNyYkN5NGdKd3d1SnVUODhoSFh3SXJLSGd3Nkxa?=
 =?utf-8?B?aFU5NG5kMzVqQkVYSXh4T0dQSVJxaDl0RU9JMmhZRkZHQ2daOStQb3o5M2NC?=
 =?utf-8?B?SDB6ejkrakZrVHFIeW9tM2VBVHFhc2xaQmg1TWRtQ3lxN2o1TmhYVEZuN0pt?=
 =?utf-8?B?VzltbVY3MzVHOURjOUJlaENhM2VvcHZmZklVbFBPSU1yRUpxSzJKSGtlZk1k?=
 =?utf-8?B?OWVYTjhLWVZNT0UzS1ZJQTRWNCtJZEErNysranFITG52VllVOEZoWi9BVUZv?=
 =?utf-8?B?RWg0QitnYy9VdnR1c0NWQ01ZbXdaQU0xYmZCUGFUSkx6K1lvTS9CbFc1YmpL?=
 =?utf-8?B?eHZhR0ZGTDFvVVF3TUxBcE9LUjI3dUR5NUdQbzY3aTlWNlZKTDdaNXptTThC?=
 =?utf-8?B?K1JldUhHa3R5d20zYUxOMDlEalEwYkRmNUZ1cW5QaGJxVWFDWG1YRXk0ZGFj?=
 =?utf-8?B?NllrN28xb1JZNDVZTnpVZC9nelV1amJmcWtnajI0NWpocFA0amUwTTVUd3ho?=
 =?utf-8?B?cXN6bjRIWDJWME1vVjNBdGVNZzkraHhLNWlqVHZvT3ZybmRJTTJvSHArZ3Fr?=
 =?utf-8?B?YzZydlorTEpnc0V2dEZYRHJQZzI2VVNiZlVHS1ZjMjNBbnh5SEhHWEVkTm1D?=
 =?utf-8?B?cTZSbk1nSVpCdHZrME5aMXVpdUdZdndnck9iUUdETENrQTZBamQ2T1hJemIz?=
 =?utf-8?B?OVhlL1pVbXJoY05ybkhMNHJtd29heitGTnBLVjAzek9qVUdFYm5UdmVQTHk5?=
 =?utf-8?B?bXRjeXgrL3ZzeTdOOWdqSEpLbzVXRHdZL1o4Z29NUVh6Wk40MnFwUWloUWVm?=
 =?utf-8?B?bGxRQS9hUmdPNE1hWHB1VkFRZXJCRVJhaFEzUHJDVUxPd2diR2RyOE9UeDdN?=
 =?utf-8?B?UDZISCt4bnQvNFhGNjdQeVVXSVdRSG0wSWJ6Y1p4NkhhR3ZJUzdzSEFZUlhG?=
 =?utf-8?B?MnpDZzBPSHVZTlFwVXEwQkZ0c21VWEZUZWNVUzg1T0RIaGZpRERtYm51L1pO?=
 =?utf-8?B?d2ZGMVZmK1RlUkdRV0tTUTVuTlZNU1BocjBZL2pNdmZFREJMeWZVQVAvWjQ0?=
 =?utf-8?B?aGZ1b0NUc1dHZFEzYWRuajg0Z0ErR0h6SU1sYTlqeVU5K0dLbWxTQy9yazZt?=
 =?utf-8?B?SDkyUHpLei9QbmFxcUtPY3JRbGR1dVhJeEhPZmwvU01jV0E3RlJRbWFvM3o5?=
 =?utf-8?B?WXRhSkxjem9ia3ZTYWpiN1Rsa1pMUVlOQ3VlTUVZYTlnNVJNMG4yOGw1a1NB?=
 =?utf-8?B?K3I1UExKRnNyZU1EQm1KdXhiOU5wZlhKWUVid3M0dkNRcUZpeTZwc1czcUdz?=
 =?utf-8?B?bXJkQmRtK1BSZUQvUEJieUtXMjg0Qk5jOVVHZGhlaUFuUWs4cFYyZnQvZTZ1?=
 =?utf-8?B?TXNWdjV1L3dpZXJ2TjB1Q2pmMlF1Q05XUDlUbklhM3JMNkpDT3JDSHJYa3Ax?=
 =?utf-8?B?Z3pETkFSQnpZZi92b3VjWkhCczNHMmxLY3ZQcDJBVHRjSEVkbk05bU00c0t6?=
 =?utf-8?B?UkVja210dlhhak51akZLTGZtdGNUWUFsYkVwYVV5TTZJbk42NVozT2RMYWxL?=
 =?utf-8?B?L0xva3hvV3czWWNGVkNSejl0ME1hcGJ6T29MRXdkWUtaNlhtcU1LdnV6M2xk?=
 =?utf-8?B?MllPSnd0RlRmdGVTRlJZTEc0VnlJbkI5V0N1d0Nla3orWjE2NEpsY1FqR2Nk?=
 =?utf-8?B?Skd6d1Z0Yzhidnc4bzA1dzFZVENJQmVsTGZva1BuSVc5bFROeUkwR1g2UHRj?=
 =?utf-8?B?YXVzcEdpbVlpSE8xUkRyRktXNXlobnhmVGN1QVdWSjkvWTEyMS9hUTd6SzJu?=
 =?utf-8?B?U1JHZlBLK3VrZ3lWOWM4czgvVHhpeFBkRGZjTFdvOFdZajU5NzBHOHRKMkpC?=
 =?utf-8?B?b0REblpLU0xvenhEVWFLL1dDWUdpMUNWdms0WCtHTHBTMzZLQ2V0SXlacXJL?=
 =?utf-8?B?djJLL0Z6dnBUY1Z1VEdqcXVBRVl1QzZJWGZBNklvRDRQdHA4OEtiaXAxM05Z?=
 =?utf-8?Q?m6fiAemV6tRd5VywFOT2B8c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9123018d-eef2-4d5a-d6a4-08d9f6e1eb4c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 15:34:02.6797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzDujFjLxph9GqqirBxbqZbrzW/f6bcKYBTdfZdUEAfNJO3jdmP4VQC1aVFwLHIF7NHFEvjd9MeqHrwuIF3YKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/2022 9:28 AM, Phil Auld wrote:
> On Wed, Feb 23, 2022 at 09:14:45AM -0600 Carlos Bilbao wrote:
>> On 2/23/2022 4:19 AM, Peter Zijlstra wrote:
>>> On Wed, Jan 26, 2022 at 09:22:23AM -0600, Carlos Bilbao wrote:
>>>> The kernel manages per-task scheduler statistics or schedstats. Such
>>>> counters should be reinitialized when the thread is migrated to a
>>>> different core rq, except for the values recording number of migrations.
>>>
>>> I'm confused, why should we reset schedstats on migrate? I'm thinking
>>> this breaks per-task, since tasks tend to bounce around quite a lot.
>>>
>>
>> Thanks for your comments, Peter. 
>>
>> Looking at the documentation of schedstats I see that most values are 
>> actually linked to the particular CPU: time spent on the cpu, timeslices 
>> run on this cpu, number of times _something_ was called when the cpu was 
>> idle, and so forth. Those values lose their meaning after migration and we 
>> should reinitialize their counters. However, reviewing sched_statistics I 
>> identify two fields that we should definitely keep increasing even after 
>> migration (nr_migrations_cold, nr_forced_migrations).
>>
> 
> The documentation is a little off. I think it should say "any cpu" instead
> of "this cpu".  If you reset these per task counters (time on cpu, number
> of timeslices etc) on every migration then they become meaningless (and
> useless).
> 
> 
> Cheers,
> Phil
> 

Well that clarifies it! Then, let me ask the opposite question... What
fields of schedstats should we clear when migrating? If there isn't any,
I will just increase the number of migrations.

>> So this patch will have to be upgraded if there's some other value(s) in
>> schedstats that we do not want to reinitialize either.
>>
>>>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>>> ---
>>>>  kernel/sched/core.c | 10 +++++++++-
>>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>> index fe53e510e711..d64c2a290176 100644
>>>> --- a/kernel/sched/core.c
>>>> +++ b/kernel/sched/core.c
>>>> @@ -8757,6 +8757,7 @@ bool sched_smp_initialized __read_mostly;
>>>>  int migrate_task_to(struct task_struct *p, int target_cpu)
>>>>  {
>>>>  	struct migration_arg arg = { p, target_cpu };
>>>> +	uint64_t forced_migrations, migrations_cold;
>>>>  	int curr_cpu = task_cpu(p);
>>>>  
>>>>  	if (curr_cpu == target_cpu)
>>>> @@ -8765,7 +8766,14 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>>>>  	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
>>>>  		return -EINVAL;
>>>>  
>>>> -	/* TODO: This is not properly updating schedstats */
>>>> +	if (schedstat_enabled()) {
>>>> +		forced_migrations = schedstat_val(p->stats.nr_forced_migrations);
>>>> +		migrations_cold = schedstat_val(p->stats.nr_migrations_cold);
>>>> +		memset(&p->stats, 0, sizeof(p->stats));
>>>> +		schedstat_set(p->stats.nr_forced_migrations, forced_migrations);
>>>> +		schedstat_set(p->stats.nr_migrations_cold, migrations_cold);
>>>> +		schedstat_inc(p->stats.nr_migrations_cold);
>>>> +	}
>>>>  
>>>>  	trace_sched_move_numa(p, curr_cpu, target_cpu);
>>>>  	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
>>>> -- 
>>>> 2.27.0
>>>>
>>
>> Thanks,
>> Carlos
>>
> 

Thanks,
Carlos
