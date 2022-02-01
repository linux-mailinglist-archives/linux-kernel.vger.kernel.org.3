Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6524A5C24
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbiBAMXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:23:11 -0500
Received: from mail-dm6nam08on2048.outbound.protection.outlook.com ([40.107.102.48]:46177
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237967AbiBAMXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:23:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJA3v02AUCfUSA+AHpYQe2LdIjxDWbSo/hUZSeJNskxPuug/SMAkEDxp3GqMDmPgKVwDv7u4WpztbmcDtnjJFQDRKE31nTXnZ4D2X2vAZ37xQF3xAoUyWg4kr2ML4jR6xX5dvfZ4NzIiV1F7h2V24LVD1HAqMXQsbytf9Odrj7/4qZE9ieBHd4WPxttam8GqASGhMJy6Z/VJliG4lhBN2N4CHdZp3qBdbL7V39++gvO9Gwg1/jIUfcsS8n4GYKCaMVjwWvi6LSsePWM66y0S4uzrRfWu1p51MkoZ4AqL1qKr9r7Ag8ujyO8P1A49rMOSa8g64SEKYXnLJ63ucPREgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PADy2cfbTopOcf/H7+2OqMb7ylllpsFE1saMMovwUbY=;
 b=dq63hE/JKiqWKFH3b8cxe67U310AXcDQj+bt6uX0g+Vy3PbE2Kbv+cFjhgAWyqvfwiQLety9s2+PPmKlqP7emEoVgRbDWzJN/5BApjXCxz7oMoK6yXH5Hr8FN8GYIBk+7AbLG0EBmAexqvbvVpTYKjLUCNA0LdIuXZFblguZZYaveX2OygkTksW/OUUpo3OGXzfxQGOAteSrLAL5s3nefxqCLnqpHlpHEdj8/wj8mpeA0F2jrZdS97SLo4r3urgkr604FON9xO9uJnBXsY2BuzAhJa+jVXu41MX5Gl9LoE3bhl3pL//2oX66qppdp7V0VmI0TyBsGLRCH/etix+Ikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PADy2cfbTopOcf/H7+2OqMb7ylllpsFE1saMMovwUbY=;
 b=mtowm7uyO8W89crH4kbDTPrnbqZgmFB3tpWduIKh9qMhAx2KqVH2tD+hjvYIA8V8DoI/ytlBZJEfPyo18OBKOgFwGbSrfdgTLX15PmciC+HBuAz0vbe0cOfkEqNa8jglKOnzik0OgfNCDvPzA8VbsIU+SkK5rjzI6sa0uyLZwAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 by MW2PR12MB2539.namprd12.prod.outlook.com (2603:10b6:907:9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 12:23:07 +0000
Received: from BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::b1bf:8e72:56ca:4256]) by BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::b1bf:8e72:56ca:4256%8]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 12:23:07 +0000
Message-ID: <9f95a85f-5396-b8bd-50cf-c4eeeac2a013@amd.com>
Date:   Tue, 1 Feb 2022 17:52:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v0 1/3] sched/numa: Process based autonuma scan period
 framework
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        dishaa.talreja@amd.com, Wei Huang <wei.huang2@amd.com>
References: <20220128052851.17162-1-bharata@amd.com>
 <20220128052851.17162-2-bharata@amd.com> <20220131121714.GX3301@suse.de>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <20220131121714.GX3301@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0102.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::18)
 To BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eff0fe4-46aa-42af-920b-08d9e57d9a2a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2539:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB253958F409FCA1178F43749EB0269@MW2PR12MB2539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUOwiIKb/OyzV/xEEs5q2n/P2FgXUXgHNIxfz2tkZnVbbO0EvCF8/EPWrOra5rb3JyFGfY11q6bVH46zLXv9OE38IDWDys2thiUJnYHjQUvo5Cf7QlcsO5q0NP5YgmIfC6lI/g0YciHrHB6YS6YMaLhw8hQJwijLVQfwQgqh40iYTHrET+m7EtRPUotud3sVbD4S540vyMQHpivBiGRbLWmppYhaLA3shzInbX7Qmp6mtO0XaEHGoukzHGq+cCEuZSR4ezzOwgN4DR76rIbn5DLZ/rUUxqBBe8F5KWTFHaAURMvc8ksHFixvCRAxETQy1g3lNsPZGwWeEco2Bqjyujuutm166k/mruapUgIhGDeXMr9MTrsvYe/+QpvaUFNUTxp5u3Q9LWLPKIEFdJgpWdaDURzSgPIhyfyep+2fYwN/h29M6MfWG6YNGkN2I0VwSEowNVKPIPtLqP7OH+mW1m3Fyf71slgBKz4xCqfTIAyHAWbvkcb11dTBpaVbtmUBfCrZiOq+jJDZPpVVEyHnzR9RBlId5u2wR+TvdHdSu2syik2+5FUCSmpcTzylwUyZy6pCmcjfUetpWP9P9tfdfR3xmusuT9KXdXs4/g/4eJKz6ktSaFRVrqn5HPay9ciyF5TR3Ul4sWTcfOzxlyIIuypdRHabQh3xRk9LmhXN3drDe6cSxz48apGp+NtyY8uYjejFc0K5bta22AGZojZ6Jod4X8gtWwL2BQP5Oa32Mhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4289.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(31686004)(26005)(83380400001)(36756003)(6512007)(186003)(6486002)(2906002)(2616005)(508600001)(53546011)(6506007)(86362001)(31696002)(316002)(7416002)(5660300002)(66476007)(38100700002)(66946007)(8676002)(8936002)(66556008)(6916009)(4326008)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWlla0xJS1EvTXlWbzJ5bG04NEVSUWFQdGRhUkJPMFVPQTYyWDIvS3ZSOTlr?=
 =?utf-8?B?YkU3eHNhbzNER1cweVRDMVJPUFVZM2JVMWR0ZGs3QXBZdjdyeE1CR01UcUVO?=
 =?utf-8?B?RStqWGtPRkN5amZmMk8xSlhMWEgzakNXRWpVL1dDbXJLbFpON0tOMy9uc2Ir?=
 =?utf-8?B?SlVDMGU0YlRncCtvdlhoSE05WEtKY2xEVXN2OTBsWlhENE5tQWVFdVJ2bnhO?=
 =?utf-8?B?VHpxNFRsYkFEeFhNVFhSRzc4d0Z1YmV1ZnV3aTFGRlI3RnVIRXpjUGtNb0hU?=
 =?utf-8?B?N0RQcEh2dEFXWER3QUwwaHRxdEhTSGZIRVdDekhEWlMxdWdTMDlHMnQ1bUpN?=
 =?utf-8?B?NlNqYzhQVDM5YmNVOFU5Q0FIcE9KVHlFOWJYam40Yjd3N0xQZ1pPOEllbW84?=
 =?utf-8?B?Q1pvcVE2eDJ5ZFlzanpOcVhyYXc1dVo1VlFOVFA3MUg3RTkrWk9DeGFrcjZM?=
 =?utf-8?B?UWRQYTZZZUpyRjhPUFI1bjN5dWNOMmUvcWZGWXJtOXN5ZmhxU1M5SFgxN1ZQ?=
 =?utf-8?B?dmNTUVpaTFpnbU1NdUhkdm1KOEV5WVRsT25Oa2JDY2hMRGQxdE9qemtWaWZx?=
 =?utf-8?B?cVpWS0t3NUs0NlBNOWxJWXRlMmJVRE5zbzlCZ0hDSzV6QlBHMDRRaTVBSGpF?=
 =?utf-8?B?STdLY284TzdtRGRrYXJuZ0xWRS9iYlp3T1UxMGhaNVpndlZQekkvc1JUVWpB?=
 =?utf-8?B?V1IrdlljdmZHZHdjZlJkQlF5S3p5b0hNVk5SMHczMXJNc3hRV0V5dVJPdEI0?=
 =?utf-8?B?OHRDb2hMRWoxRlV4NHA3d3ZGRk1NM0Qrb1JiMDdMdVBZZ2lVOUo0Qy9XbGth?=
 =?utf-8?B?RUdmQzlrWWs1SSthM2M0eEpsK1hsamlZcmdjbXJGbGdacHEvTWtYRkVxNElp?=
 =?utf-8?B?QkxYcXlzQ2JUME5KMmVmaTc0aVdIZFFwUlhhLzZ2TGRRUlZSR0dUbXNOT3Uy?=
 =?utf-8?B?Rm9MMldSd05FNDVBZ3hWU0ZXUnNqY0dKZ1dPZTh1ckIyYVVxdHhCSUNTdkFz?=
 =?utf-8?B?a1FnbnV1NlVFV2laWmxMa09uMjhmVXAxQlJLUHBaeVkvYXhWMEFPR0c5ZDgw?=
 =?utf-8?B?VXg0K1pMVUlRajh4SERjR29XRy83c1JHS1RnRFpaZjh6WGY3WHU1ZlB6ZUdK?=
 =?utf-8?B?S1FWY2JrMHJabStHODAwcnpoV2FKam05M0pLbDlqOHRCekFDVE9KS3Btdjdh?=
 =?utf-8?B?di9ST0VLWTFOWmNVeUhKODVvelFhRldzdWhScktMekxQWWkwZlJYL1ZaSlgx?=
 =?utf-8?B?cUZqU29sOHZqVzhZeHM2YmVVREJENmlzVGVEaUpWUTZWYnlFVEVKNjduQ2Iz?=
 =?utf-8?B?UjkyeGd0d0V3L1JxdTNEOW5seHNLM0U4cDhmbHk2cWJQU0RORERQalFUdTFs?=
 =?utf-8?B?ZkhoSW5rcnZwZjJISVZmNVlyNDNFL2ZYUkdYdDhsT3hJMHphQ2hKWmtDdEFu?=
 =?utf-8?B?NkFIWjQydTcrdkpUbXJ5RnhVOXAvaTU2SW1HZmhDbVU3dWdjc1pna010NEpE?=
 =?utf-8?B?b3J1azg3ODkyYzJwOFl6NjAxdTIzMit0eUpSc09DcTNhVHJTaVUyOVY1WWpJ?=
 =?utf-8?B?Tlh5NU1ZT3FJcklsVkFRUnpJSWhKS3dWdCttTjVqYzZFckNUK2xjRTRWRjdQ?=
 =?utf-8?B?bzQ1TlpKSFpwMXJkbEhyMXZDWmtZWVJVbFhWYlNmcGF0d21uUTVvbWQyaHFo?=
 =?utf-8?B?MUJNTGFGeUpIQWNXL0JJZElMSVd0K293cmljbWJFSjF0VGRMaFZKVy81YUlz?=
 =?utf-8?B?eXoyVXZqUFR3NWUxNVhUMUFpamkwS1ZQQWlSdWR5eVdjVm5jSm9pMThtOEs2?=
 =?utf-8?B?TC93d0NtY1F5NXNGcUsrSkRJLzVCMzFYRmtUMTlnMHAxSytzcHVLWERiU0wy?=
 =?utf-8?B?WXE4Tzl1dHJFSStKUVB3NlNoTUVnV0ZpMmFsdFVUcEpNbnNXTG42c1BWQ2FV?=
 =?utf-8?B?Nkl2SFR4UE50K1g5UFZZQVFoYnZVQWQxdTN2M21heEV3TzBQZ2xwcEhocDgy?=
 =?utf-8?B?L2JwbU5TdElTRXpnVUY0QklMREV0bjhXVUN2cW9mQUUzR2Nic2N0djhUWU5N?=
 =?utf-8?B?UnhSZm5HdGwyanYxNnBiZ3JVeGllaCtWekFNd3dFQ1FaUkxDVXplUmY0MkR0?=
 =?utf-8?B?TUxvekVUZG1jTUZCNjBDdEN3Wm5raGV1aEdQRjd6c3ZUQ0dYOFBOMWpXNEJi?=
 =?utf-8?Q?gRF+f1OyoqK/s3AsxE6cJfk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eff0fe4-46aa-42af-920b-08d9e57d9a2a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 12:23:07.4636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sWP9t2ZjTNSgaJ+D6c01dLlrtvN0wnfmiDdNXN755TwBvYrdyploPaL9nBr2f5rhLK0e3Dk2WWQB1fCauOzcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2539
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mel for taking time to look at the patchset and providing your valuable review comments.

On 1/31/2022 5:47 PM, Mel Gorman wrote:
> On Fri, Jan 28, 2022 at 10:58:49AM +0530, Bharata B Rao wrote:
>> From: Disha Talreja <dishaa.talreja@amd.com>
>>
>> Add a new framework that calculates autonuma scan period
>> based on per-process NUMA fault stats.
>>
>> NUMA faults can be classified into different categories, such
>> as local vs. remote, or private vs. shared. It is also important
>> to understand such behavior from the perspective of a process.
>> The per-process fault stats added here will be used for
>> calculating the scan period in the adaptive NUMA algorithm.
>>
> 
> Be more specific no how the local vs remote, private vs shared states
> are reflections of per-task activity of the same.

Sure, will document the algorithm better. However the overall thinking
here is that the address-space scanning is a per-process activity and
hence the scan period value derived from the accumulated per-process
faults is more appropriate than calculating per-task (per-thread) scan
periods. Participating threads may have their local/shared and private/shared
behaviors, but when aggregated at the process level, it gives a better
input for eventual scan period variation. The understanding is that individual
thread fault rates will start altering the overall process metrics in
such a manner that we respond by changing the scan rate to do more aggressive
or less aggressive scanning.  

> 
>> The actual scan period is still using the original value
>> p->numa_scan_period before the real implementation is added in
>> place in a later commit.
>>
>> Co-developed-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Disha Talreja <dishaa.talreja@amd.com>
>> Signed-off-by: Bharata B Rao <bharata@amd.com>
>> ---
>>  include/linux/mm_types.h |  7 +++++++
>>  kernel/sched/fair.c      | 40 ++++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 45 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 9db36dc5d4cf..4f978c09d3db 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -610,6 +610,13 @@ struct mm_struct {
>>  
>>  		/* numa_scan_seq prevents two threads setting pte_numa */
>>  		int numa_scan_seq;
>> +
>> +		/* Process-based Adaptive NUMA */
>> +		atomic_long_t faults_locality[2];
>> +		atomic_long_t faults_shared[2];
>> +
>> +		spinlock_t pan_numa_lock;
> 
> Document what this lock protects. In the context of this patch it appears
> to protect a read of p->numa_scan_period and it's overkill to use a
> spinlock for that.  Also, given that it's a trylock, the task_numa_work
> ends up doing no scanning or updates. This might have some value in
> terms of avoiding multiple threads doing updates if they happen to start
> at the same time but that's a narrow side-effect given the short hold
> time of the lock.

Sure, I put it in the code comment, but will document the usage here.

If the try_lock fails, it means some other thread is updating the stat and
most likely that thread will go ahead with the atomic update to mm->numa_next_scan
and start the scanning. So can't see how this will stall scanning or stat updates
in general. Please note that in the existing scheme, the stats aggregation
happens at fault time but in PAN it happens in task work context.

> 
>> +		unsigned int numa_scan_period;
> 
> Document how the per-mm numa_scan_period is related to the per-task
> numa_scan_period.

They aren't related, per-mm numa_scan_period is in fact a replacement of
per-task numa_scan_period. However numa_migrate_retry interval still depends
on per-task period as you noted elsewhere. I think we could replace that usage
too with per-mm numa_scan_period and completely remove the per-task version.

Regards,
Bharata.
