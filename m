Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F914C17F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242554AbiBWQA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiBWQA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:00:27 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7C5C2E4B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:59:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEHbDUi10FZNt7TShAKGQev8mgf4Wzfk60euTb05OZD6YzYvdZ0nipG9Q9DQElTpKfiGLP2ykSI1Vc0nEjntRNjUFCjGRwZ6uZvIz8GGcqnkPVXUb6JIQNzBaBzi8r9UDBr+OmIWNyw26wcdeDCaYUDz+DmyuzXCsNRChw4p0W/d8fSMPVCKGPos3TV7p62EdoXsYjhgRUkXwvIy/aFT/f6uYyO5wdjvJMh8qI7pKzu79fv3veiIuu6xqk8TwAXwzIfV9Ssx8isS+V2oaRtxSA+6sfDIbWB4Oehqtyca/lUMuD0Cv/S5n8Bwu/mwU7bTuTYvrY3kVBb/ZqX+43GqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0RtG5Z008YvfZEWnZI8viECXptXWyUg2zxIADY5hsE=;
 b=TcD1sUno6hXO+qrlQo7DGJ9ZOvhXAN0Q846gFFVcYqDwdrKfRMabGMDI9a5Mdbfo7nKK/X6ftt2K1gW7VYXTVCCcxNYSJNRq2KUMGufbtHYqodKz0aCrMKn0ufVYWDiFpnFc9Gp0KHuBqN4AElb5fuhx6bWcbIx9D3WUiRxBvCAqp7Snb18/RsKuNyK7KSrbLU83sDtHXgaOgHZECMH32CjRFpbDwl8JBgWdMIjMNKF2DHhoOtfOUXC77XX7wFoh0MSkOh9iQp/TPSLcP3RnP2vBEC5YH/Z9YOFYPQhgY1EEiu8BNxH/D0LNUOE7w7iYAyStEXHPMOA2HMNtR3X50w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0RtG5Z008YvfZEWnZI8viECXptXWyUg2zxIADY5hsE=;
 b=C9hpPwPoAoojaO/VWR53w+0uWvjExp++340qwSVwYKbqcCVFubgCU41EI5EUdOepPL2d2ZGq163Fvu+8QjnHBJEIoV3Ilzj7jWF8xQY68JDraMzOnvlHmWBpsUU9By3fqExMOhryRxPR36Jw95UMTekr2ZstnVN7zji8DNsIBzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MN2PR12MB2894.namprd12.prod.outlook.com (2603:10b6:208:10a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 15:59:53 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8d44:d69b:b031:1d50]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8d44:d69b:b031:1d50%4]) with mapi id 15.20.5017.023; Wed, 23 Feb 2022
 15:59:53 +0000
Message-ID: <b7a28537-8bfb-7f0d-5ed3-f301983e4e30@amd.com>
Date:   Wed, 23 Feb 2022 09:59:50 -0600
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
 <0e42c46a-ccc4-e793-00b8-ae407e06846f@amd.com>
 <YhZXGv34YTV5omKq@lorien.usersys.redhat.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <YhZXGv34YTV5omKq@lorien.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0024.namprd18.prod.outlook.com
 (2603:10b6:208:23c::29) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 457206c7-6140-4a5c-5e54-08d9f6e587a6
X-MS-TrafficTypeDiagnostic: MN2PR12MB2894:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB28945B36F8BD9D84093D371CF83C9@MN2PR12MB2894.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FfTYaBz1ndx68MOLdfFBMxONdgG/+lgd5nSicslzJ6Iwdl3LcN6u1lMEuN0+ebAQBnhA6cAb2Hr/PsQvhlnertCdOZwI0HzM9tAXJmNC/T48FXnccKwugtDAZHRRUkDwAPC4MDTrRX9jf1chV/QQirk4eBcian/nSwD6Y3fXGTvw9lgaSWZbJ4f7d/0ZT+PsObM9UwXVa+1H9fYT1/rg/oDQ4PTX7Ynwa25ng1juj2EdUJ4utoXk4Ti+0vF6cMmKPIVGV5hq9yGNraPZVjJ8M67dNILZ+PeIpzb/uuCv5pnGc1+PnDRD0jlz/7cExNbDn5BU6JxhQE0BA/q6G1+LrhRrcMzn+g5KObIf9Zc58hWNRb4kDLFkEeZ5JGKzUFXdBYNK3phRj9LhJLEGBXeEN3Q8DIQeXjYzNShCYaGAwYwS+beARmrQIXGXJTBwTXgPGlo9xA6kjXBGiJD/wnUqSbITzI10prFrQDCJSTDlU95z95/ZAbQjinKTG+VBn2HvM/oYRPIEv1UBB5RhJsUTAKNnXi1z6HqeXUQrL77dk0++a4Vla7zgxI517bgoZjlDOJLgsv01aHpF9E3u0Clv87h4f87UCmoaaV2kA7BUFtxrRc46rMbLRPVZ4KdEUEsaGzrgbxmOVy7TG650ogfR56A6Ql34Y+s/QHNR2IVT/hXXoxW534GPJ5SDFsKRQ2u7emOOqEc8ZFeRf4gi9VQbEW+z3kQeu00YQlN1ZWLLzlM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66476007)(6916009)(6486002)(508600001)(83380400001)(316002)(6512007)(66946007)(66556008)(8676002)(7416002)(31696002)(8936002)(5660300002)(2616005)(36756003)(6506007)(26005)(186003)(53546011)(86362001)(38100700002)(44832011)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVIwNnN0VzBMeDlLeXNFM2VpQ0d0N1FCbERwU25wOXh3bzUvT3RJL1ZqWlIv?=
 =?utf-8?B?M2EyM21HL25GMFpvVmVkenZ5dW5zalNDWTZmMk1PMk1KenBTNWl1Q3BoaFB4?=
 =?utf-8?B?aDBkcnluUTFBZjhRTDVxZVlRczhYeTRrWnoveTF0MThOTTlaa2JMWHRSL01N?=
 =?utf-8?B?RGZFQU00V2w1andMbmhzRk5rVFptelc2NnVOQkw1WldlSFI1Vkx3SG45eUVm?=
 =?utf-8?B?YWFsNjJGNU9jZjZicEF3UkMzL3JZaWgrdTMvZVVqaWNCbUpmU0xZQjRtVkhQ?=
 =?utf-8?B?dzhHbXJ3dHZhVk9vTWJhUmJYcjIwWlJlV3hDRHJwOGxNb2JFbmtFN28ySjJ3?=
 =?utf-8?B?ODA3aVBCTGRCOFk1eFQyaDAvMlBBeWgyekFtdWpqTTh6eXVmRjlYTFpUTjYv?=
 =?utf-8?B?QmJwSnIrL1dTYVhyYThXTWJKcU4zTkdYQU1oVkFyaWhIUHlqNHhLZFRnd0k3?=
 =?utf-8?B?Mkswa0RwSWwwK3hhNTJKN2UyVXRRWHJIWVBmV1VHallwcm83a0ZBZ0swNGFZ?=
 =?utf-8?B?K21LRytvZmNCTEk5MjJyOTFvWWYzcE01T0ZEL0ZKZk1rNjh2NW1SMG5pVjdR?=
 =?utf-8?B?Mk1QN2d5MFZIODV3ZG5RakhvZkRPR3EwN1lWV0l3V3hOdm5ZQys4cm1pTjVY?=
 =?utf-8?B?SkxYbnZVK20xenEzSmM2QmhlcFpGOFEvSCtNdWxmckhnZStYcXZzQnZqcVB6?=
 =?utf-8?B?U1BPZDRVNTFwam9pT0xvdVFjdnhYK3UwVTRxRUFHQ3VhR0dKbEh3QWFic210?=
 =?utf-8?B?RWU3U00xYzJRVEl0YWF1K2VrMzIxdGY2eDJUb004SHNlV3c3R0dtRnQwMnI4?=
 =?utf-8?B?VnBNcWxDOWh3eTZxeng4NmIxUXdaWG8vN24zMktlVTN6MFZyZE5rYzlJb0VS?=
 =?utf-8?B?UzFEdURKbU9pWkVLMnVDSDd1SVF4bGxmamV0eUw4NDl0MzQ1YlhlK0d1TEhB?=
 =?utf-8?B?eDlpOGJsV2xQMmRtcElBNU5lV1l6SEVtZTlydEdFYXlFNjRrRVRVYkMzZ1Np?=
 =?utf-8?B?RmpTN0VuTytFWVBNQVkzckZwTExjUFJTQThwZ05nd2RlWUh3OHNEZUp0WjVv?=
 =?utf-8?B?dVl3b010MDdkanBjN3VmeW5OQmQ3cm9yZmx2YjhXTlc1YVp5L2RWSTNxbUJE?=
 =?utf-8?B?c1JuZ2g3UDVDY3dJVHJzNk1qbE9rbk9OUmJXTHhhL2tGS2ZuMVlmc0EwcUJs?=
 =?utf-8?B?aVBvZ1M1ZnN3YTN4ZndOZ08rUXdQaWV4VjN1UG1lOTl6bXFQK3poc3d6aGpQ?=
 =?utf-8?B?aXVjTWYzcWZSRzl2QnF0QlI5N1F0VlhYbU5CS1pYTnlpSmhYbUx0MDkvaDNq?=
 =?utf-8?B?NXdPRVMyN1BmWTNpdERkWWtrS09BQzYxVTN2d1FUbUtwWnBuUnU1UWxCajRS?=
 =?utf-8?B?NGRqREVHUmFIbUp6TUx1bUhlRTRoQmF4U0VCY3VOWUQ1M0lIOHM3cUFxVXU5?=
 =?utf-8?B?M2JMUVBwMzFYd0R1d1JicnF1Q1AxM0tOQUsxTktpOUtJcFVhN2pnSGFySnNX?=
 =?utf-8?B?eVVadW9FR1BDKzRoN0VwbkdnSzFBVTM5S2ozOEJ3YmVTRnRTN1UzdnVNS2pV?=
 =?utf-8?B?TDBnbXkzUVFLK3FodnY2SldsaGZtclVJSk9saGJXOTQvMWJTdWFYa2pkay84?=
 =?utf-8?B?aGZTejZPM0hpamhsdSt1eDN6QkZZekRFVnNxd1dPUEU1czBiSzFxNjRmQzMw?=
 =?utf-8?B?RkRlR214dUFLRHN4ZEwvcVBJZ2lFVTBYdE16TWFoNEdBMHJsQ1FKN2lDbkhp?=
 =?utf-8?B?MnhLRkJRU3B5d25qRlVncjdzeGMvWTE1bk5aZEtUNG45NUUvb2VGdzJaNk1j?=
 =?utf-8?B?MFpGcjJqTXBCRm1WQTlCUGJUSE5IK1ZjemRCcEFRRHkrdlRUUHorb08wSVBW?=
 =?utf-8?B?c0lQSEIwRUZ6ZkpMN0dxMjROTDdBTXFtQ0J4YjArL3dWSzlCVWdsdVdxOWRz?=
 =?utf-8?B?eUtNTTRyY3N4TkRzMXh4TFdVOG14cjlPbUZFbnFaalpUSzRxZ1QrTXFkK3VM?=
 =?utf-8?B?SWl5ZFo5REJNT2RaanFBZUtHNUhYQ2RMaUpYVHJvdzdkQzY5M1pDQUtSdkdW?=
 =?utf-8?B?cDJJeXovbkNyaE95T2kvNXBUemMxTEVxd2hiYUprcm8zT3Q1R2twMXRYSnVP?=
 =?utf-8?B?RndMcHNSazVDMzc4cUJDNzdxY3EvTkUyekI1eHlXeWd5d0VSN25ISGt4aUdT?=
 =?utf-8?Q?wCA3B4y+2eNWoMpvG4shvuI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457206c7-6140-4a5c-5e54-08d9f6e587a6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 15:59:53.5438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXiUdT8jz0qrJA/QnuuJIxW9q/kNNe5FkBUlPEi0SwNCRT0hkSj43TbwFelSwWJzmF3modtKItb6dxfsB28JXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2894
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/2022 9:47 AM, Phil Auld wrote:
> On Wed, Feb 23, 2022 at 09:33:59AM -0600 Carlos Bilbao wrote:
>> On 2/23/2022 9:28 AM, Phil Auld wrote:
>>> On Wed, Feb 23, 2022 at 09:14:45AM -0600 Carlos Bilbao wrote:
>>>> On 2/23/2022 4:19 AM, Peter Zijlstra wrote:
>>>>> On Wed, Jan 26, 2022 at 09:22:23AM -0600, Carlos Bilbao wrote:
>>>>>> The kernel manages per-task scheduler statistics or schedstats. Such
>>>>>> counters should be reinitialized when the thread is migrated to a
>>>>>> different core rq, except for the values recording number of migrations.
>>>>>
>>>>> I'm confused, why should we reset schedstats on migrate? I'm thinking
>>>>> this breaks per-task, since tasks tend to bounce around quite a lot.
>>>>>
>>>>
>>>> Thanks for your comments, Peter. 
>>>>
>>>> Looking at the documentation of schedstats I see that most values are 
>>>> actually linked to the particular CPU: time spent on the cpu, timeslices 
>>>> run on this cpu, number of times _something_ was called when the cpu was 
>>>> idle, and so forth. Those values lose their meaning after migration and we 
>>>> should reinitialize their counters. However, reviewing sched_statistics I 
>>>> identify two fields that we should definitely keep increasing even after 
>>>> migration (nr_migrations_cold, nr_forced_migrations).
>>>>
>>>
>>> The documentation is a little off. I think it should say "any cpu" instead
>>> of "this cpu".  If you reset these per task counters (time on cpu, number
>>> of timeslices etc) on every migration then they become meaningless (and
>>> useless).
>>>
>>>
>>> Cheers,
>>> Phil
>>>
>>
>> Well that clarifies it! Then, let me ask the opposite question... What
>> fields of schedstats should we clear when migrating? If there isn't any,
>> I will just increase the number of migrations.
>>
> 
> I don't think any should be cleared on migration. They're per task and
> should be monotically increasing. If they ever reset it becomes hard to
> know what they mean when you read them.
> 
> 
> Cheers,
> Phil
> 
> 

Agreed, I'll send a PATCH v2 only increasing the migration counter.  

>>>> So this patch will have to be upgraded if there's some other value(s) in
>>>> schedstats that we do not want to reinitialize either.
>>>>
>>>>>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>>>>> ---
>>>>>>  kernel/sched/core.c | 10 +++++++++-
>>>>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>>>> index fe53e510e711..d64c2a290176 100644
>>>>>> --- a/kernel/sched/core.c
>>>>>> +++ b/kernel/sched/core.c
>>>>>> @@ -8757,6 +8757,7 @@ bool sched_smp_initialized __read_mostly;
>>>>>>  int migrate_task_to(struct task_struct *p, int target_cpu)
>>>>>>  {
>>>>>>  	struct migration_arg arg = { p, target_cpu };
>>>>>> +	uint64_t forced_migrations, migrations_cold;
>>>>>>  	int curr_cpu = task_cpu(p);
>>>>>>  
>>>>>>  	if (curr_cpu == target_cpu)
>>>>>> @@ -8765,7 +8766,14 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>>>>>>  	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
>>>>>>  		return -EINVAL;
>>>>>>  
>>>>>> -	/* TODO: This is not properly updating schedstats */
>>>>>> +	if (schedstat_enabled()) {
>>>>>> +		forced_migrations = schedstat_val(p->stats.nr_forced_migrations);
>>>>>> +		migrations_cold = schedstat_val(p->stats.nr_migrations_cold);
>>>>>> +		memset(&p->stats, 0, sizeof(p->stats));
>>>>>> +		schedstat_set(p->stats.nr_forced_migrations, forced_migrations);
>>>>>> +		schedstat_set(p->stats.nr_migrations_cold, migrations_cold);
>>>>>> +		schedstat_inc(p->stats.nr_migrations_cold);
>>>>>> +	}
>>>>>>  
>>>>>>  	trace_sched_move_numa(p, curr_cpu, target_cpu);
>>>>>>  	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
>>>>>> -- 
>>>>>> 2.27.0
>>>>>>
>>>>
>>>> Thanks,
>>>> Carlos
>>>>
>>>
>>
>> Thanks,
>> Carlos
>>
> 
