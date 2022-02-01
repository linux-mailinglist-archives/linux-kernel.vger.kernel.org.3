Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9BE4A5C49
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbiBAMbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:31:13 -0500
Received: from mail-bn8nam12on2051.outbound.protection.outlook.com ([40.107.237.51]:7680
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236275AbiBAMbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:31:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLyhrQ21V3+RDum6d1FIjJ3tDtthcubgDzsM/nTnr2upYI8dH0wARyw5i3hH4kYE1peTekKH6E6AOYDa/lgfS0e2aGsMMaMtWLaHTj8awdfrImJNOTbVOA8MO4mare00h1zMlsC2vd2Um4RN3wDicl7z74Y1YB/MIuQyMbzMBXJdllR5WOSdI8U/v1lK9JZB6vYQBJf0rLX5iDYKOT3CSyEB51ds5G1aAgowBaug+IZ1sruDe0tFzbpMzXoCaSs8OxFkjJYnsvcLnnseAtSYzgWBgbMi2M4cntEpPSGOVYPmrlrxaY4DJfSbefDoATzyyodJG1wbybLUs8aLA+vtZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdIjGPp/c9D/7bV3hF3BqBMhI1YDTpFLvQoNWo7gyts=;
 b=Uwn8Sy07EHVgffKmH6qD82fxvZxYwI1MePT++h35bbLxZdQCIqbZG1PuWThSlawuHFDwyLm6O9qIx3Ru9h4/XKMJ49PRrSYDPt50Wnm4gYu5JD4vsG3HlFnBpyLb6oxNN2c+fc5WGKfd7ldNWJ8XfkvASOj8+4+J4MgRmHDWR6NP1oYowkhn6PD0t02Pbw4qVJB9GjCHKMYEzkkoWndqrq0bUFXA+TKZhhRqQNq1Y0AiRSDwl3U66LsRP8vFOHEt8xP78g42wjzCIHczaaXr6Q/F1/Rgqz7zJ0P/qrAkJ7TRBRAr8ZQgsNTT7ftdAk3FGjnb9hjWv2aePzuogoJfnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdIjGPp/c9D/7bV3hF3BqBMhI1YDTpFLvQoNWo7gyts=;
 b=QPzE8PxeTMkk5SYsVXWiQXFmoHjFhNuozrNudu9KtEIf7RdxCyd0TdNZ4oL3qqOSV4QKHVFsopjMZv4+UEKOT4QNzjcDcLQyWsceABrmxhQ5VHewngx7v1c0FnbOMaD157/ipyi7bH/pYxyGM05TVFOjrkKVr1GfThl6vpm462Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 by DM5PR1201MB0156.namprd12.prod.outlook.com (2603:10b6:4:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Tue, 1 Feb
 2022 12:31:09 +0000
Received: from BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::b1bf:8e72:56ca:4256]) by BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::b1bf:8e72:56ca:4256%8]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 12:31:09 +0000
Message-ID: <2866edcd-37e5-ac74-0788-ef1dac1b22d4@amd.com>
Date:   Tue, 1 Feb 2022 18:00:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v0 2/3] sched/numa: Add cumulative history of
 per-process fault stats
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        dishaa.talreja@amd.com, Wei Huang <wei.huang2@amd.com>
References: <20220128052851.17162-1-bharata@amd.com>
 <20220128052851.17162-3-bharata@amd.com> <20220131121720.GY3301@suse.de>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <20220131121720.GY3301@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::32) To BY5PR12MB4289.namprd12.prod.outlook.com
 (2603:10b6:a03:204::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f18d925-80ea-4bf9-c89b-08d9e57eb99a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0156:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01563730A30855705419DD79B0269@DM5PR1201MB0156.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdr1sp0PCku1PeOtHPoos/nVJl0IQ3L717MbG8xfwHeep4IkF5hnO3fV64NwkMTUHdvZ9fn7hru0BS1pp6UH9k/u7QjhJr+cbJOq/3yHAZrI+Ari3J1rtCN4VgbaM45lX1pkIK2iatpAPXh8vbBfnEdKncgsVmTzRRTg+SKBX3eFbJcKJep7thp4PPztP7Pw7PhL5F2CpX9ntjO98CeNtvDTO8DMqz6pEikaMZRyEYyQXGNuccxKTPaV5wx9rAEWkZC0TKx67DgRktBMrYMFcDxrtFlss+GlYCKNwvN9mhhRrX2yVmrv3TRNwmEyxiRMCgLVGLyGhrI9uvx2pTyf1I/TgooktfSdNduiICTTLqTGmb/TU3J4ZV+hJiG+gQJyXUGRsOI9lFkEtxg9k8dYpxm9y6EtmjN821lcmwSX6FRgprAf6jui8GwSXymb1QoWQYlqrbAA8yHQM6mE3DgtIY9UuSJFS8XZlRz2kHKvVBW5DUoXLj787OijhC18gsdZ2v82GiX9sTx/Mmrw90ZSAoVym3h/bek6qP2k+sPt907AJiNU9SYOIln/xoDinHtBmssX1y9RjX/8fNLuoMpd4IMBURhmXUkl+599dAqBOmHzEy+IVVD41Q8m9qgK5JjPN60z9zO6TALBWbNnaN1ZD3NrMfT/VOPX+8vtLiiw6/jDnURIokWFaC8SecDk7kYQ7fJMAjS6uQFglg82mN3pzAP+m37begbaf6zu4QmctCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4289.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(66476007)(6916009)(66946007)(31696002)(66556008)(8936002)(38100700002)(316002)(83380400001)(7416002)(5660300002)(53546011)(2616005)(6666004)(6512007)(6506007)(8676002)(6486002)(508600001)(36756003)(4326008)(86362001)(2906002)(26005)(186003)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enNST0ZHb2tjc2JaTmNHbUx3YjRHanBreUhkM3ZpYkNLUUZWWjk3eFJhTjIx?=
 =?utf-8?B?OGtBZHdWSFRrd2ExdU9ZY1VrSkR1S2s3VjE4RHI3WTFaaDlyUVpZYXE3TmFx?=
 =?utf-8?B?WUFINEorRFlRWXpjYVBNTmUzQkViOTl5YjNVN1RvT1h0Ly9uaDJHYjh0RVVn?=
 =?utf-8?B?a3lhZWtoVGNMUkU2bDRmR2RYV0FSVzM5YUozY0owbUd0eVJhVmNBbE80VlVm?=
 =?utf-8?B?a3I4ZzFSMnlFOHJCUDRHaXpqY3lUS0YzakgyNnZ1N3ZZNDRXVnhYZjE2TVRm?=
 =?utf-8?B?em5IajBKVmdtRTI5NnVRTHh1cTBmeEo4ZzluSTl2bGpHN255amZucGFDRXFK?=
 =?utf-8?B?OWhoM3lCL2VyNXpLelhxNExFTUR3ay9qbFl4MlRuWTVtenlXMDZXUjVYaW1z?=
 =?utf-8?B?d0RhaTFMNVFnVDVzVm9idWI3T3AyZmhpNDBnSG5DV01QaE92dm5OWll2cW1O?=
 =?utf-8?B?dmRSZjlRcE1IUktndFhoRkhOZXFNOFNKN1ZVSmR2KzVqOHNIbWdhUkRtL2Jk?=
 =?utf-8?B?RU1hVitzZU1BZ3E0ZW9pT3RPMVFkbzUzczduN3BkUWIyOFg4dFlMR01WWXlP?=
 =?utf-8?B?ZlNZVy9YYThLUk9SNHlwWGxoV3A4UHptYVFaRUw4QUVORmlMQXkzcVo0Tk1p?=
 =?utf-8?B?MVo2MWdqeERTeWlFMDJxY09odXQyVjFuY3VUOW5HUUN6TzU1NFlrTHFYQnlT?=
 =?utf-8?B?ZG01djM3aXZZeDJIbitadUI3Qy9tRGRCWGRob2l0cmhPcHpNZ0lJRzJFQ29H?=
 =?utf-8?B?Y0FqdS9WeEZSdlRsRCtGWFhtMTlGSTM0eE5UUCtJRWhHMG9RMWpZbzd6MTRp?=
 =?utf-8?B?TUFhOGkvdUF4SklPNGpjTlJaTDdzdExCRHNSb1VDajdjTWFUUGZ5c0FJWUVt?=
 =?utf-8?B?Y0VNdFM4VEJ6eWJiVHdNVmNRQmhCdTNtU2VmNk1WMFZhU0trNEhWTk8yNFJ3?=
 =?utf-8?B?elFCeVF5aXJVQW4zUlpOdkEwN2l3SWNoMWhYdEFYQUxLeDBEb0FOZkdoeFVs?=
 =?utf-8?B?N2NWK3c0QmhZTWl6S055RWZybDdCNzRGaGNvTVprUEhHeUkvQzlCWUFWMXFu?=
 =?utf-8?B?Q1pCSHovVDB0aVE4bzQ4TVNJSHRWUlhXbGdJWllmMlhvQWRJT3RmWms2RlE2?=
 =?utf-8?B?TWFFMmxNUWh6Ny81UDR6cktEOWpQYU5XVTJUMTN6UmprekJnbFJZdU1BbTFu?=
 =?utf-8?B?ZzgzamZPbUtBSmQ0TjVESWorT0c1VHcxczBtT3VwQjY4UnpLVnQ5UFowaENp?=
 =?utf-8?B?WFNJMWdyWGhManB6Z3JodjM5anlrQm52NEtKNElLVTE2bW5NTUdFeW81emh3?=
 =?utf-8?B?R0NBZEJtdUIxL3ZKZjArendUZnpTa0FtL3VyT2FwWldZS0ljUmhhbW52MTdV?=
 =?utf-8?B?WkQ0Qy91YTFuWTJIUlpLSDIyRlkyT0dBL1lTTW5TMFN0WEFOQmNwVWlJRTE1?=
 =?utf-8?B?ekNONkpsWEVjbCtXMnhrRElTL1AwcFN5VzFvaEZWc0ZYZ1pIOWdNZ2twWXYz?=
 =?utf-8?B?ZWZNUzVmaW9WUGVUMFAwSTdyK2Y4N2MzZ2NXRHc3T3prYWs1UWUycGhNWjc3?=
 =?utf-8?B?clZVYjdWWUJ3TThkN2RtNSs2SkkzRGZ2ZnFKRUt5SllmSE1hQklzTDIwbnlx?=
 =?utf-8?B?Y2RkZXdyMGZMMW9hRWM4VWNHVk1nSGNSYzlUTURpeUJmUVBrMllUUEg4bVg5?=
 =?utf-8?B?NnlGMDBGM0tNSGlFQnN4SGQ2UWJUVTZjVE92VDJRYlJscjQ1My9xb2JJRFgy?=
 =?utf-8?B?MzZhWTlrTHBmN2U1Y3pGb2M3MmEvbk9WTWNZeEJKOWdwY0pZd1ZmT2JPdmtD?=
 =?utf-8?B?R2N5ZkxGc0ZiNVA2WG1yOXJWVjhrdW1kNXZZa2Vwc2E2VlBmbFFsZjlQalJV?=
 =?utf-8?B?S0dGYStVblpLWldvRWg4TSs0ZFVXNVgrV1NNazZMR3ZHYllScldmOEhBd0lY?=
 =?utf-8?B?WE1uN3Y2V01wNC9wMElvbGxNWjc2czhzbHMzR2RtMDlJVEFFRjBHcEF3K2Zx?=
 =?utf-8?B?ekJVdVJoekFsZXJiMUplNVhrMjZ5ZzluWVJQYlFSQnlBQmp0eDhxeXNVTDBP?=
 =?utf-8?B?NHpvbFRJdVFITkdHdUxieTNLWHdCTXZTNjFIRXdWdFRCN0p4ckU2TU1DUHhC?=
 =?utf-8?B?ME9EZzNRa2xYcTVpaE5CN21KSGVmVVIweTg0VjVwa1Axckk2R1ZldXZpMHk2?=
 =?utf-8?Q?bLKFrDgYBI2R46cbXXpPzwk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f18d925-80ea-4bf9-c89b-08d9e57eb99a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 12:31:09.5797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7zj/aTAEMtvSpmTKTN9990SG6NMsEP8vZS6CeZ5n9BDLjiDph1OlQOTVJEjEv9/eSWhE0NbMPfgqEgE0sbCTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0156
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/31/2022 5:47 PM, Mel Gorman wrote:
> On Fri, Jan 28, 2022 at 10:58:50AM +0530, Bharata B Rao wrote:
>> From: Disha Talreja <dishaa.talreja@amd.com>
>>
>> The cumulative history of local/remote (lr) and private/shared (ps)
>> will be used for calculating adaptive scan period.
>>
> 
> How it used to calculate adaptive scan period?

Fault stats from different windows are accumulated and the cumulative stats
are used to arrive at the per-mm scan period unlike in the current case
where the stats from the last window determines the per-task scan period.

> 
> As it is likely used in a later patch, note here that the per-thread
> stats are simply accumulated in the address space for now.

Yes, will make that clear in the patch description here.

> 
>> Co-developed-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Disha Talreja <dishaa.talreja@amd.com>
>> Signed-off-by: Bharata B Rao <bharata@amd.com>
>> ---
>>  include/linux/mm_types.h |  2 ++
>>  kernel/sched/fair.c      | 49 +++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 4f978c09d3db..2c6f119b947f 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -614,6 +614,8 @@ struct mm_struct {
>>  		/* Process-based Adaptive NUMA */
>>  		atomic_long_t faults_locality[2];
>>  		atomic_long_t faults_shared[2];
>> +		unsigned long faults_locality_history[2];
>> +		unsigned long faults_shared_history[2];
>>  
>>  		spinlock_t pan_numa_lock;
>>  		unsigned int numa_scan_period;
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 1d6404b2d42e..4911b3841d00 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -2102,14 +2102,56 @@ static void numa_group_count_active_nodes(struct numa_group *numa_group)
>>  /**********************************************/
>>  /*  Process-based Adaptive NUMA (PAN) Design  */
>>  /**********************************************/
>> +/*
>> + * Update the cumulative history of local/remote and private/shared
>> + * statistics. If the numbers are too small worthy of updating,
>> + * return FALSE, otherwise return TRUE.
>> + */
>> +static bool pan_update_history(struct task_struct *p)
>> +{
>> +	unsigned long local, remote, shared, private;
>> +	long diff;
>> +	int i;
>> +
>> +	remote = atomic_long_read(&p->mm->faults_locality[0]);
>> +	local = atomic_long_read(&p->mm->faults_locality[1]);
>> +	shared = atomic_long_read(&p->mm->faults_shared[0]);
>> +	private = atomic_long_read(&p->mm->faults_shared[1]);
>> +
>> +	/* skip if the activities in this window are too small */
>> +	if (local + remote < 100)
>> +		return false;
>> +
> 
> Why 100?

We need some minimum number of faults to make a decision and
figured out 100 could be a good minimum here.

> 
>> +	/* decay over the time window by 1/4 */
>> +	diff = local - (long)(p->mm->faults_locality_history[1] / 4);
>> +	p->mm->faults_locality_history[1] += diff;
>> +	diff = remote - (long)(p->mm->faults_locality_history[0] / 4);
>> +	p->mm->faults_locality_history[0] += diff;
>> +
>> +	/* decay over the time window by 1/2 */
>> +	diff = shared - (long)(p->mm->faults_shared_history[0] / 2);
>> +	p->mm->faults_shared_history[0] += diff;
>> +	diff = private - (long)(p->mm->faults_shared_history[1] / 2);
>> +	p->mm->faults_shared_history[1] += diff;
>> +
> 
> Why are the decay windows different?

Like in the existing algorithm, we started with a decay factor of 1/2
for both local/remote and private/shared.  However we found lr_ratio
oscillating too much with that and hence dampened it to 1/4.

Decay factor of 1/4 for ps_ratio too may not change the overall
behaviour that much, but will have to experiment and check.

> 
> 
>> +	/* clear the statistics for the next window */
>> +	for (i = 0; i < 2; i++) {
>> +		atomic_long_set(&(p->mm->faults_locality[i]), 0);
>> +		atomic_long_set(&(p->mm->faults_shared[i]), 0);
>> +	}
>> +
>> +	return true;
>> +}
>> +
>>  /*
>>   * Updates mm->numa_scan_period under mm->pan_numa_lock.
>> - *
>>   * Returns p->numa_scan_period now but updated to return
>>   * p->mm->numa_scan_period in a later patch.
>>   */
> 
> Spurious whitespace change.

Sorry, will fix.

> 
>>  static unsigned long pan_get_scan_period(struct task_struct *p)
>>  {
>> +	pan_update_history(p);
>> +
>>  	return p->numa_scan_period;
>>  }
>>  
> 
> Ok, so the spinlock is protecting the RMW of the PAN history. It still
> may be a concern that task_numa_work gets aborted if the spinlock cannot
> be acquired.

As replied in 1/3, the thread which is holding the lock for stats update
should start the scanning is our current understanding.

Regards,
Bharata.
