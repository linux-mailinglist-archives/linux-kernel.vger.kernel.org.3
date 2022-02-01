Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5984A5CB4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbiBANAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:00:31 -0500
Received: from mail-dm6nam12on2065.outbound.protection.outlook.com ([40.107.243.65]:27431
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238160AbiBANA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:00:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5SVlZuXwBHbqi+xJD9gmQjWECaPZDSTjjVOedOmph8OyYUx0QXNxzj8Csw/UDBz6d9w7MSEqyDDLIK3EACeneX3pRqG6aA1uSZKBNduNKmAMk5m+nBseTPXbxRhT1MPhZRj8o8a0H9Scz/i/ejff/yc0SFKB1+uhLWCZZYp+67453XlRdQ/EyFyVsmIZFi8h3nZdlzNxJogfdsKPlTNsB86gyFyNx0M0Xrzl73EqY+9JxfaHC4v6I9jmUjkC5bWYimeyqFTyo1au6TEmSWbvVUQ+XPIMbJPmKGrtd7cmK0tNoomLlVa/XQC7SoBDNyEHEZZSyozDQhvuEENgckI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3cmVv4w0p3ND54LKD+G3BQ0aWfn0H5DsPiMjRDFR7s=;
 b=nccKu8xoKAQB8vxu6rvCpIoFbWeiJwjf8u9y2UFnyhrZABIJ9HYvngOFzByPyZPHXHqKgSBN+2SOn4g++jg5ZptTTYyYcKpNWkVdVdxjsUF6InWTtyyAeNNzVwOqrFgIVmB5Giz5Q1jE4msB/nykVQWs4WoBK/xy+4UPf49aE0n1ughK/dFYujuSq9/pMqcqLOzRg3P2IgI6CWtQmueoShbos+J8NfFjnEtZIjVAei9RA83GmBwWfhfozB+T6OnlF/9f3wLsXvqhlhNJaLDD4qx6mbKtg8/iEgT9Reui5vPGgMZ0clKZKRta7/85NemIgIksaKg2+qdrTktMfi+1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3cmVv4w0p3ND54LKD+G3BQ0aWfn0H5DsPiMjRDFR7s=;
 b=UcHdXyMfug8J2yLNwyUmzwq4XMpzjoykI/KFH4ik13hBAdGQ2hJXZ6IxD58FT/ngkjmnnTzCgaBg9jde+LKGOZuI2dBf9tJ2G80J0WKd1f7NpIN52b/TFmmRArH2kTQrPB6iMtN49DItsH/rlYHfqbKiZZZzV6pUqVXnVy0xJvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 by DM6PR12MB2953.namprd12.prod.outlook.com (2603:10b6:5:189::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 13:00:26 +0000
Received: from BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::b1bf:8e72:56ca:4256]) by BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::b1bf:8e72:56ca:4256%8]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 13:00:26 +0000
Message-ID: <aac1ae0b-78dc-e358-fb6a-bea968ee4276@amd.com>
Date:   Tue, 1 Feb 2022 18:30:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v0 3/3] sched/numa: Add adaptive scan period
 calculation
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        dishaa.talreja@amd.com, Wei Huang <wei.huang2@amd.com>
References: <20220128052851.17162-1-bharata@amd.com>
 <20220128052851.17162-4-bharata@amd.com> <20220131121726.GZ3301@suse.de>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <20220131121726.GZ3301@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::12) To BY5PR12MB4289.namprd12.prod.outlook.com
 (2603:10b6:a03:204::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb84bed0-49c2-40fd-0d74-08d9e582d0e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB2953:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2953EC380CC0658706D29E48B0269@DM6PR12MB2953.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pSc/kGctnFLA1MOs+DVH4lGLNd9U1Z1cxNEG9Al9/QXc247/oZ4e5xo0KiXma6L5VVEiAWYEEzpULtZq87N/c9cCL+gwL8Ya1VGy4/FmQvw47nMQAvCSiEFjetfGo6Y+nGk8qHXugY0rhWPW4GMoRVsUQcEfgLa2zi8AQzngsm0xlDKxVIJ0n9hFoytHwBPy/YpG5l3hBcrmBSdv0gv8+7t5dyOx4BEjYqoFG2AgFuXlmn4v8LLXOxv8a7hbIoXblAQCuQLSmcqmPK8lP8ymfBUFVwT/98Bbr/XdScmP0jNzrKMstF/e8+Ns7pWKjlodRX1aN0AiUS5HTTJIqfxZVwzt2p01uq+2PO3cK3sKreA6J4cCeUNA6ogCiTVTMaC/HwlfLMXuowpQN6Leqr53tcEj2mUSFP45Xo2Z3sdXapv6/liw8n9sgI6rZ5uW9FkyQar8JTnU9Am6bwXCbp69xTlvaN+/7Lo6Vb/yR99eIJIv7ei0JT4BrTMtXGzVUm0KWy+2WITUo1URM5JkEuLNQrLpzVuvb2FWonVNRaCjqqU3MEQhw3njxo1xaqDVJlcgOta2Rg4F8Dq5PvGspvnhE3fiF4oKkBHCR2RTCTjl7zuqV0w8/JFGryXQcdj9gMvch1jpcE1nrB33ByIkCPbad/QHniz5YzunrJ8syUsAcygThe+KMrhMhroVnJyHbQxgDkrPJbmXk5rKGKJUFF8ATO6KNfCyCStzzMZhErGZ9h0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4289.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8936002)(31686004)(8676002)(26005)(83380400001)(6916009)(508600001)(6486002)(31696002)(86362001)(36756003)(186003)(2616005)(66946007)(66476007)(66556008)(30864003)(5660300002)(38100700002)(53546011)(6666004)(316002)(6506007)(6512007)(2906002)(7416002)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUZibzdXQ2VUYnRTTVQ1WEhIdUh4eFNWVHBLNlJhU0dLUDJqODlWRWJsZHY3?=
 =?utf-8?B?ZGExeVM3NGhaTmsveVNGaE9xL0pIczhMYWhRZ0FYVHRBZjFuMG5jU3BRaUxO?=
 =?utf-8?B?RTRkZHFyK29OSnpLd2dCR1Npbk04cUdhSmpuMEYvWno1MEwyQkRVNTFiSERq?=
 =?utf-8?B?WHVlcGQ0S3V6SEllenZVd3B0TEtvM2Zhb2VBaGIzdE12U1JvK2xKelpDb2lu?=
 =?utf-8?B?OUUxOHJHOXlMbmtHSCtmVUs5VU5UbFNuYXpvNGFycStuMXVvSjNiTS9odG5L?=
 =?utf-8?B?cURyNEtYdy9MRDZ1ZDFqQndkMHhwVXFJZi8ydy9JYzM2L1RPbkw3UHJ1NmF3?=
 =?utf-8?B?bTcxdXdpOWZNMkhmbmt3bmtvTjVTcFo1Umo3MW9CVklTMnlNTDR6S1VTbGNI?=
 =?utf-8?B?OTJzVjBIZkJOQ2Fwdkp3QjNZTFIwR0xoQmZhbzR2T0hOUGIwdVpzRjZvOEF5?=
 =?utf-8?B?YytaQ005T0FMbjlwbjUxZm5HL09TenNhSmxwNlBXb1FvUW0vdWlIUlk4WHUw?=
 =?utf-8?B?MHRsTmNhd05yWnF3aEV2ZXdvSS94QkpCWlBJWFFySzJ0MFJUNWVYZi9FdzU2?=
 =?utf-8?B?eW5LcXJMYzk2UDV2aVcxY1B3SlNVZTFvaDI0VHd6YkRIejA5UlVjd3JWWnUx?=
 =?utf-8?B?TUVFZmNtczJQaDF1L1dPWk9SNTYwbE11Tnp6dnBXSExEMDRCZlV3dDN0VXZI?=
 =?utf-8?B?bEljeElIYWZrNmNWZlFtdXBDK3IwZEozM1NVWlJKMkUxbGU2aFFIU01BdG5v?=
 =?utf-8?B?V3VxcFhmREx4N2ZDcmltYTBVYml1bzdMOHZKV0FoTE94RHhYY1hXdXcwOHR2?=
 =?utf-8?B?N25NOFlvYy9sd290ejJGSWZGczBwdFZCU2pqRUdRK3NpOVR3OGdRek84QndL?=
 =?utf-8?B?MWh6bHdTK1RBUklaWXFsVXZwT1FnWVdvck44OVdUK0hMRndnZlkvQkZXVGUv?=
 =?utf-8?B?M0ZhYUw0ZlYrRnpwSmdKVlFlWmlocmdoM3VXZWNEQ1V4TmFGcHhNZUkyRmE3?=
 =?utf-8?B?ZG05anNzQnZ3SlRBUWNpSHI3a1lQN1F4SlJqeEh3RmFtVFhVRDFoZFRCSC9l?=
 =?utf-8?B?WEt1QnljVE50TnNVNDNqbENLVEd1cDEvVkh6U3V0bjFOVUFwSjdlQm5qV2o0?=
 =?utf-8?B?MnhXS2lmUkRlenJvTXdobHEvMVV1eGh3QnY1dURwSWJFZ3cwM2lGNi9kQ1pI?=
 =?utf-8?B?SDJKSmQxZTAvd3kzYWtTcnZ5MGUrUzRwNlNSTkZSUEtXN1k0K0dsdGxHaG9r?=
 =?utf-8?B?NWpHTC9DR0J3bHBOaklCNlVEdEdRK1EzZG1GaTUzZXQxRDFsUk5BUlpEdHVR?=
 =?utf-8?B?ai8vcGkvOGVwZTYxalpQSTNFbVN2MDRWWGVFK1RRN090Q1paSWw5UDgzVTdx?=
 =?utf-8?B?b2tmRFdjSVpXMW1UYW9tUTkzMjBTRFJyajJpMkNjakUwU2FGVzduTzU0cXh3?=
 =?utf-8?B?Q2pJbmRzT3hmS2NOTE5zZWZRdENnNTIrbUs4eklMNVdOcXkwVWhYMG03Witk?=
 =?utf-8?B?bjVHZnZKU2tub0NyaU5ydGRrVzZIazRndUlabEZXYW1DcjdKZTBEQmtqeXhh?=
 =?utf-8?B?NDA0NTczNS8xOHI3RkpLem1OMGNMNUpoWGxxMTBiZ041WHAxNlZ0UWFJZCs0?=
 =?utf-8?B?TVpLS0RkR0ZnckQrd3oyY2FnRGhsVTFyN2Q0U2pybTBQMk9BMmlPbnd5WXlt?=
 =?utf-8?B?ejZHcWQrYmU1T29sbUJWdzFjV3RjZXRDZVFMWkNmT3pINUZlak8zQTR5d2hP?=
 =?utf-8?B?Snp6bnlzUFlOSHFZeGtlZkt2VHVtMnhsVlY1akpjTy9FYzRmd0RxNVdJZmxp?=
 =?utf-8?B?elI3Unl5T2ZLK2dMTG9ncmZXWmxWak9ielJpL2hiUUFxRks4N0ZQVVFlY2Rm?=
 =?utf-8?B?NXJJZk1GUzVNUXhMZ0p2WkJVeXF4VS9OWTFPSysvVS80ZDBNU3kxOWdYTGxm?=
 =?utf-8?B?ZnRHNnB6ZExYZXF2a2FIQjFWTkhKT0R4VXBiV3AzdUpZaFZZbUU2OFc1UUVu?=
 =?utf-8?B?TWp3M244bWFTbXJ2dDhOQ1AxQzdTQ3RhQkttVEtodEhhU2tnWHREWUExUEVQ?=
 =?utf-8?B?YkxxenZ2eW1HK3ByMm1Cc3ZIUG1mTFdXQU9PNTduUElIYUE2ZXFLWkJ3TXda?=
 =?utf-8?B?WHJIL00vU1NKM1ZmbEorVkZ1UUtMemxMMUE4dXMvMmNRbUFzUFpBbFl0Qk1k?=
 =?utf-8?Q?LR9OUiMNMNT4xbHXcxZY2SU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb84bed0-49c2-40fd-0d74-08d9e582d0e9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 13:00:26.6516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PS6/Uh/pMnBEIgE64BO6I3c+J5zHAp/nYAncz5d6ikbsI/+HtzMYOhk8DuZqci3YLx8ozMQg03DyUk6S5IH3lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2953
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/31/2022 5:47 PM, Mel Gorman wrote:
> On Fri, Jan 28, 2022 at 10:58:51AM +0530, Bharata B Rao wrote:
>> From: Disha Talreja <dishaa.talreja@amd.com>
>>
>> This patch implements an adaptive algorithm for calculating
>> the autonuma scan period. In the existing mechanism of scan
>> period calculation,
>>
>> - scan period is derived from the per-thread stats.
>> - static threshold (NUMA_PERIOD_THRESHOLD) is used for changing
>>   the scan rate.
>>
>> In this new approach (Process Adaptive autoNUMA), we gather NUMA
>> fault stats at per-process level which allows for capturing the
>> application behaviour better. In addition, the algorithm learns
>> and adjusts the scan rate based on remote fault rate. By not
>> sticking to a static threshold, the algorithm can respond better
>> to different workload behaviours.
>>
> 
> This appears to replace the per-task numa_scan_period with a per-mm
> numa_scan_period. This likely leads to more stable rate overall but it
> potentially misses that some threads are more active than others and
> miss that different threads may have different local/remote faults and
> private/shared faults. I think this may be smoothing the average while
> potentially missing outliers.

Some threads may be more active than others, different threads may have
different local/remote and shared/private faults, but we are aggregating
this at per-process level only to derive an effective scan period for the
process. The best we can do here is to factor in those local variations
at per-process level and respond quickly with a scan period update.

Note that per-process faults are used only for determining the scan
period, the existing per-task (per-thread) faults continue to influence
the page and task migration decisions.

> 
> After the patch, p->numa_scan_period appears to primarily affect if a
> page is retried for migration but a lot of infrastructure is still left
> behind and it's unclear what purpose it serves.

I suppose you meant p->numa_scan_period now only influences the retrying
of task migration. Yes and guess we could just use per-mm numa_scan_period
there too but that would require us to hold pan_numa_lock spin_lock strictly
speaking.

If we take care of migrate retry interval, we can remove per-task
numa_scan_period in the next version.

BTW on a related note, why task stats aggregation and scan period update (via
task_numa_placement() and update_task_scan_period()) are conditional to
p->numa_migrate_retry? Should we ideally separate the task migration retry
from task stats and period update?

> 
>> Since the threads of a processes are already considered as a group,
>> we add a bunch of metrics to the task's mm to track the various
>> types of faults and derive the scan rate from them.
>>
>> The new per-process fault stats contribute only to the per-process
>> scan period calculation, while the existing per-thread stats
>> continue to contribute towards the numa_group stats which
>> eventually determine the thresholds for migrating memory and
>> threads across nodes.
>>
>> In this algorithm, the remote fault rates are maintained for
>> the previous two scan windows. These historical remote fault
>> rates along with the remote fault rate from the current window
>> are used to determine the intended trend of the scanning period.
>>
>> An increase in the trend implies an increased period thereby
>> resulting in slower scanning. A decrease in the trend implies
>> decreased period and hence faster scanning.
>>
> 
> Clarify what affects the trend in the changelog. e.g. how do differences
> in local vs remote and private vs shared affect trend?

Sure will document the algorithm more comprehensively including
the above aspects.

> 
> What happens if one thread is primarily local faults while another is
> primarily remote faults, how does that affect the trend and overall
> scan period?

1. If those two threads are operating on separate memory pages, we will
see remote fault rate going up. That causes the trend to decrease in general
(Of course the algorithm does observe the trend for previous two windows
before changing the trend though). Decrease in trend will result in lower
scan period thus creating higher opportunities for page or task migration.

2. If there is shared memory between them, that aspect gets captured in
ps_ratio which controls the decrease in trend. If more than 30% shared
faults are seen, we don't further decrease the trend.


> The per-task scanning is flawed in terms that more active
> threads can scan address space regions that the task is uninterested in
> but I worry that masking that with an address space average may delay
> the correction of an imbalance in one thread because an overall trend
> misses the details.

BTW we had an additional patch that tracked the per-node locality faults
data at per-process level and did correction to the scan rate trend if we
find too much of an imbalance between nodes. This involved maintaining 4
atomic counters (local, remote, private and shared) for each node in
process's mm and atomic updates to them from the fault path. Since we
didn't see marked difference in throughput for benchmarks we tested with
this RFC v0, we haven't included it in this series.

> 
>> The intended trends for the last two windows are tracked and
>> the actual trend is reversed (thereby increasing or decreasing
>> the scan period in that window) only if the same trend reversal
>> has been intended in the previous two windows.
>>
>> While the remote fault rate metric is derived from the accumulated
>> remote and local faults from all the threads of the mm, the
>> per-mm private and shared faults also contribute in deciding
>> the trend of the scan period.
>>
>> Co-developed-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Disha Talreja <dishaa.talreja@amd.com>
>> Signed-off-by: Bharata B Rao <bharata@amd.com>
>> ---
>>  include/linux/mm_types.h |   5 +
>>  kernel/sched/debug.c     |   2 +
>>  kernel/sched/fair.c      | 265 ++++++++++++++++++++++++++++++++++++++-
>>  kernel/sched/sched.h     |   2 +
>>  4 files changed, 268 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 2c6f119b947f..d57cd96d8df0 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -619,6 +619,11 @@ struct mm_struct {
>>  
>>  		spinlock_t pan_numa_lock;
>>  		unsigned int numa_scan_period;
>> +		int remote_fault_rates[2]; /* histogram of remote fault rate */
>> +		long scanned_pages;
> 
> Why signed? What happens if it wraps (either negative if signed or back
> to 0 if unsigned)?

scanned_pages should have been unsigned and we have to take care of overflow.

> 
>> +		bool trend;
>> +		int slope;
>> +		u8 hist_trend;
> 
> Document the fields.

Documented these as code comments, will document here too.

> 
>>  #endif
>>  		/*
>>  		 * An operation with batched TLB flushing is going on. Anything
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index aa29211de1bf..060bb46166a6 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -334,6 +334,8 @@ static __init int sched_init_debug(void)
>>  	debugfs_create_u32("scan_period_min_ms", 0644, numa, &sysctl_numa_balancing_scan_period_min);
>>  	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
>>  	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
>> +	debugfs_create_u32("pan_scan_period_min", 0644, numa, &sysctl_pan_scan_period_min);
>> +	debugfs_create_u32("pan_scan_period_max", 0644, numa, &sysctl_pan_scan_period_max);
>>  #endif
> 
> Update Documentation and what relationship if any scan_period_*_ms has
> with pan_scan_period_*. Add the units to be consistent.

Sure will add documentation and units. And there is no relation
between the two. The patchset needs some cleanup work here to
ensure that we aren't mixing things.

> 
>>  
>>  	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 4911b3841d00..5a9cacfbf9ec 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1026,6 +1026,10 @@ unsigned int sysctl_numa_balancing_scan_size = 256;
>>  /* Scan @scan_size MB every @scan_period after an initial @scan_delay in ms */
>>  unsigned int sysctl_numa_balancing_scan_delay = 1000;
>>  
>> +/* Clips of max and min scanning periods */
>> +unsigned int sysctl_pan_scan_period_min = 50;
>> +unsigned int sysctl_pan_scan_period_max = 5000;
>> +
> 
> Why are the period different to the min/max for the previous per-task
> values? (admittedly, those values were pulled out of a hat).

Currently the minimum period possible is 100ms and the MAX_SCAN_WINDOW
is 2560 MB/s. With an increased memory bandwidth availability in the newer
systems, we thought it should be possible to handle more migrations.
Hence we thought we could potentially scan the double of  MAX_SCAN_WINDOW
and hence reduced the min period to 50.

Regarding max, no specific reason, but found it to work well.

> 
>>  struct numa_group {
>>  	refcount_t refcount;
>>  
>> @@ -2102,6 +2106,242 @@ static void numa_group_count_active_nodes(struct numa_group *numa_group)
>>  /**********************************************/
>>  /*  Process-based Adaptive NUMA (PAN) Design  */
>>  /**********************************************/
>> +#define SLOPE(N, D) ((N)/(D))
>> +
> 
> Document. N/D implies numerator and denominator. Usage implies a
> percentage change in remote faults but not always and there are a lot of
> magic numers with limited explanation.

Sure will document better.

> 
>> +static unsigned int pan_scan_max(struct task_struct *p)
>> +{
>> +	unsigned long smax, nr_scan_pages;
>> +	unsigned long rss = 0;
>> +
>> +	smax = sysctl_pan_scan_period_max;
>> +	nr_scan_pages = sysctl_numa_balancing_scan_size << (20 - PAGE_SHIFT);
>> +
>> +	rss = get_mm_rss(p->mm);
>> +	if (!rss)
>> +		rss = nr_scan_pages;
>> +
>> +	if (READ_ONCE(p->mm->numa_scan_seq) == 0) {
>> +		smax = p->mm->scanned_pages * sysctl_pan_scan_period_max;
>> +		smax = smax / rss;
>> +		smax = max_t(unsigned long, sysctl_pan_scan_period_min, smax);
>> +	}
>> +
> 
> rss is not necessarily related to virtual address space size e.g. sparse
> mappings. May not be relevant but worth commenting on why it doesn't
> matter.

During the 1st full scan, the intention is to scale down the max period
by scanned_pages/rss so that the scan period doesn't get to its max value
until the address space is scanned once fully.

> 
>> +	return smax;
>> +}
>> +
>> +/*
>> + * Process-based Adaptive NUMA scan period update alogirthm
>> + *
>> + * These are the important concepts behind the scan period update:
>> + *
>> + * - increase trend (of scan period)
>> + *   scan period => up, memory coverage => down, overhead => down,
>> + *   accuracy => down
>> + * - decrease trend
>> + *   scan period => down, memory coverage => up, overhead => up,
>> + *   accuracy => up
>> + * - trend: Reflects the current active trend
>> + *   1 means increasing trend, 0 means decreasing trend
>> + * - slope
>> + *   it controls scan_period: new_scan_period = current_scan_period *
>> + *                                              100 / slope
>> + * - hist_trend: Reflects the intended trend in the last two
>> + *   windows. Uses the last two bits (bit0 and bit1) for the same.
>> + *   1 if increasing trend was intended, 0 if decreasing was intended.
>> + */
>> +
>> +/*
>> + * Check if the scan period needs updation when the remote fault
>> + * rate has changed (delta > 5)
>> + *
>> + * Returns TRUE if scan period needs updation, else FALSE.
>> + */
>> +static bool pan_changed_rate_update(struct mm_struct *mm, int ps_ratio,
>> +				    int oldest_remote_fault_rate,
>> +				    int fault_rate_diff)
>> +{
>> +	u8 value;
>> +
>> +	/*
>> +	 * Set the intended trend for the current window.
>> +	 * - If the remote fault rate has decreased, set the
>> +	 *   intended trend to increasing.
>> +	 * - Otherwise leave the intended trend as decreasing.
>> +	 */
>> +	mm->hist_trend = mm->hist_trend << 1;
>> +	if (fault_rate_diff < 5)
>> +		mm->hist_trend |= 0x01;
>> +
> 
> Why 5? Presumably 50% but not clear.

5%. If the difference in the remote fault rates between windows has reached
this value, we consider the remote fault rate has stabilized and the task
isn't seeing much changes in the remote fault rate.

> 
>> +	value = mm->hist_trend & 0x03;
>> +
> 
> Document better what is contained in this u8 value.

Sure. It captures the intended trends for the previous and current windows.
> 
>> +	if (fault_rate_diff < -5 && value == 3) {
>> +		/*
> 
> Document magic numbers.

Sure will do.

> 
>> +		 * The remote fault rate has decreased and the intended
>> +		 * trend was set to increasing in the previous window.
>> +		 *
>> +		 * If on decreasing trend, reverse the trend and change
>> +		 * the slope using the fault rates from (current-1)
>> +		 * and (current-2) windows.
>> +		 *
>> +		 * If already on increasing trend, change the slope using
>> +		 * the fault rates from (current) and (current-1) windows.
>> +		 */
>> +		if (!mm->trend) {
>> +			mm->trend = true;
>> +			mm->slope = SLOPE(mm->remote_fault_rates[0] * 100,
>> +					  oldest_remote_fault_rate);
>> +		} else {
>> +			mm->slope = SLOPE(mm->remote_fault_rates[1] * 100,
>> +					  mm->remote_fault_rates[0]);
>> +		}
>> +	} else if (fault_rate_diff > 5 && value == 0) {
>> +		/*
>> +		 * The remote fault rate has increased and the intended
>> +		 * trend was set to decreasing in the previous window.
>> +		 *
>> +		 * If on increasing trend,
>> +		 *  - If shared fault ratio is more than 30%, don't yet
>> +		 *  reverse the trend, just mark the intended trend as
>> +		 *  increasing.
>> +		 *  - Otherwise reverse the trend. Change the slope using
>> +		 *  the fault rates from (current-1) and (current-2) windows.
>> +		 *
>> +		 *  If on decreasing trend
>> +		 *  - Continue with a changed slope using the fault
>> +		 *  rates from (current) and (current-1) windows.
>> +		 */
>> +		if (mm->trend) {
>> +			if (ps_ratio < 7) {
>> +				mm->hist_trend |= 0x01;
>> +				return true;
>> +			}
>> +
>> +			mm->trend = false;
>> +			mm->slope = SLOPE(mm->remote_fault_rates[0] * 100,
>> +					  oldest_remote_fault_rate);
>> +		} else {
>> +			mm->slope = SLOPE(mm->remote_fault_rates[1] * 100,
>> +					  mm->remote_fault_rates[0]);
>> +		}
>> +	} else if (value == 1 || value == 2) {
>> +		/*
>> +		 * The intended trend is oscillating
>> +		 *
>> +		 * If on decreasing trend and the shared fault ratio
>> +		 * is more than 30%, reverse the trend and change the slope.
>> +		 *
>> +		 * If on increasing trend, continue as is.
>> +		 */
>> +		if (!mm->trend && ps_ratio < 7) {
>> +			mm->hist_trend |= 0x01;
>> +			mm->trend = true;
>> +			mm->slope = SLOPE(100 * 100,
>> +					  100 + ((7 - ps_ratio) * 10));
>> +		}
>> +		return false;
>> +	}
>> +	return true;
>> +}
>> +
>> +/*
>> + * Check if the scan period needs updation when the remote fault
>> + * rate has remained more or less the same (delta <= 5)
>> + *
>> + * Returns TRUE if scan period needs updation, else FALSE.
>> + */
> 
> 
> s/updation/updating/

Sure.

> 
>> +static bool pan_const_rate_update(struct mm_struct *mm, int ps_ratio,
>> +				  int oldest_remote_fault_rate)
> 
> Document the intent behind the difference between pan_const_rate_update
> and pan_changed_rate_update.

Sure will document this better in the next revision. However, scan rate updates
are done broadly for two categories:

1. The case where the remote fault rate has remained more or less constant(< 5%) 
is handled by  pan_const_rate_update().
2. When the difference in remote fault rate between windows is still higher than
5%, scan rate updates are handled by pan_changed_rate_update().

> 
>> +{
>> +	int diff1, diff2;
>> +
> 
> Clarify what diff1 and diff2 are the differences between in the naming.

Sure, will document this.

diff1: Difference in remote fault rates between (current-2) and (current-1) windows
diff2: Difference in remote fault rates between (current-1) and current windows

> 
>> +	mm->hist_trend = mm->hist_trend << 1;
>> +
>> +	/*
>> +	 * If we are in the increasing trend, don't change anything
>> +	 * except the intended trend for this window that was reset
>> +	 * to decreasing by default.
>> +	 */
>> +	if (mm->trend)
>> +		return false;
>> +
>> +	/* We are in the decreasing trend, reverse under some condidtions. */
>> +	diff1 = oldest_remote_fault_rate - mm->remote_fault_rates[0];
>> +	diff2 = mm->remote_fault_rates[0] - mm->remote_fault_rates[1];
>> +
>> +	if (ps_ratio < 7) {
>> +		/*
>> +		 * More than 30% of the pages are shared, so no point in
>> +		 * further reducing the scan period. If increasing trend
>> +		 * was intended in the previous window also, then reverse
>> +		 * the trend to increasing. Else just record the increasing
>> +		 * intended trend for this window and return.
>> +		 */
>> +		mm->hist_trend |= 0x01;
>> +		if ((mm->hist_trend & 0x03) == 3) {
>> +			mm->trend = true;
>> +			mm->slope = SLOPE(100 * 100,
>> +					  (100 + ((7 - ps_ratio) * 10)));
>> +		} else
>> +			return false;
>> +	} else if (diff1 >= 0 && diff2 >= 0 && mm->numa_scan_seq > 1) {
>> +		/*
>> +		 * Remote fault rate has reduced successively in the last
>> +		 * two windows and address space has been scanned at least
>> +		 * once. If increasing trend was intended in the previous
>> +		 * window also, then reverse the trend to increasing. Else
>> +		 * just record the increasing trend for this window and return.
>> +		 */
>> +		mm->hist_trend |= 0x01;
>> +		if ((mm->hist_trend & 0x03) == 3) {
>> +			mm->trend = true;
>> +			mm->slope = SLOPE(100 * 100, 110);
>> +			mm->hist_trend |= 0x03;
>> +		} else
>> +			return false;
>> +	}
>> +	return true;
>> +}
>> +
>> +static void pan_calculate_scan_period(struct task_struct *p)
>> +{
>> +	int remote_fault_rate, oldest_remote_fault_rate, ps_ratio, i, diff;
>> +	struct mm_struct *mm = p->mm;
>> +	unsigned long remote_hist = mm->faults_locality_history[0];
>> +	unsigned long local_hist = mm->faults_locality_history[1];
>> +	unsigned long shared_hist = mm->faults_shared_history[0];
>> +	unsigned long priv_hist = mm->faults_shared_history[1];
>> +	bool need_update;
>> +
>> +	ps_ratio = (priv_hist * 10) / (priv_hist + shared_hist + 1);
>> +	remote_fault_rate = (remote_hist * 100) / (local_hist + remote_hist + 1);
>> +
>> +	/* Keep the remote fault ratio at least 1% */
>> +	remote_fault_rate = max(remote_fault_rate, 1);
>> +	for (i = 0; i < 2; i++)
>> +		if (mm->remote_fault_rates[i] == 0)
>> +			mm->remote_fault_rates[i] = 1;
>> +
> 
> What if there is one thread in the entire address that is responsible
> for all of the remote faults if it's a shared region? Does this skew the
> scan rates for unrelated threads?

Adjusting the scan period based on ps_ratio should help to eventually
stabilize the scan period.

> 
>> +	/* Shift right in mm->remote_fault_rates[] to keep track of history */
>> +	oldest_remote_fault_rate = mm->remote_fault_rates[0];
>> +	mm->remote_fault_rates[0] = mm->remote_fault_rates[1];
>> +	mm->remote_fault_rates[1] = remote_fault_rate;
>> +	diff = remote_fault_rate - oldest_remote_fault_rate;
>> +
>> +	if (abs(diff) <= 5)
>> +		need_update = pan_const_rate_update(mm, ps_ratio,
>> +						    oldest_remote_fault_rate);
>> +	else
>> +		need_update = pan_changed_rate_update(mm, ps_ratio,
>> +						      oldest_remote_fault_rate,
>> +						      diff);
>> +
>> +	if (need_update) {
>> +		if (mm->slope == 0)
>> +			mm->slope = 100;
>> +		mm->numa_scan_period = (100 * mm->numa_scan_period) / mm->slope;
>> +	}
>> +}
>> +
>>  /*
>>   * Update the cumulative history of local/remote and private/shared
>>   * statistics. If the numbers are too small worthy of updating,
>> @@ -2145,14 +2385,17 @@ static bool pan_update_history(struct task_struct *p)
>>  
>>  /*
>>   * Updates mm->numa_scan_period under mm->pan_numa_lock.
>> - * Returns p->numa_scan_period now but updated to return
>> - * p->mm->numa_scan_period in a later patch.
>>   */
> 
> But p->numa_scan_period still exists so it's harder to evaluate the
> overall result.

Sorry about this, will remove in the next iteration after taking
care of its dependency on numa_migrate_retry.

> 
>>  static unsigned long pan_get_scan_period(struct task_struct *p)
>>  {
>> -	pan_update_history(p);
>> +	if (pan_update_history(p))
>> +		pan_calculate_scan_period(p);
>> +
>> +	p->mm->numa_scan_period = clamp(p->mm->numa_scan_period,
>> +					READ_ONCE(sysctl_pan_scan_period_min),
>> +					pan_scan_max(p));
>>  
>> -	return p->numa_scan_period;
>> +	return p->mm->numa_scan_period;
>>  }
>>  
>>  /*
>> @@ -2860,6 +3103,7 @@ static void task_numa_work(struct callback_head *work)
>>  		mm->numa_scan_offset = start;
>>  	else
>>  		reset_ptenuma_scan(p);
>> +	mm->scanned_pages += ((sysctl_numa_balancing_scan_size << (20 - PAGE_SHIFT)) - pages);
>>  	mmap_read_unlock(mm);
>>  
>>  	/*
>> @@ -2882,10 +3126,15 @@ static void pan_init_numa(struct task_struct *p)
>>  
>>  	spin_lock_init(&mm->pan_numa_lock);
>>  	mm->numa_scan_period = sysctl_numa_balancing_scan_delay;
>> +	mm->scanned_pages = 0;
>> +	mm->trend = false;
>> +	mm->hist_trend = 0;
>> +	mm->slope = 100;
>>  
>>  	for (i = 0; i < 2; i++) {
>>  		mm->faults_locality_history[i] = 0;
>>  		mm->faults_shared_history[i] = 0;
>> +		mm->remote_fault_rates[i] = 1;
>>  	}
>>  }
>>  
>> @@ -2948,6 +3197,9 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
>>  	if ((curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
>>  		return;
>>  
>> +	if (!spin_trylock(&curr->mm->pan_numa_lock))
>> +		return;
>> +
>>  	/*
>>  	 * Using runtime rather than walltime has the dual advantage that
>>  	 * we (mostly) drive the selection from busy threads and that the
> 
> This potentially misses triggering of scans in general but again, the
> more stable scan rates may be due to mm-wide averaging while missing
> per-task specifics.

As noted in reply to 1/3, we thought we shouldn't miss the updates.
Here we try for the lock because we want to read mm->numa_scan_period.
May be some READ_ONCE() kind of trick should be enough as we do take the
lock next and re-get the mm->numa_scan_period in the task work context.

Regards,
Bharata.
