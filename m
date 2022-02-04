Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572644A9826
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354504AbiBDLEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:04:21 -0500
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:21953
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236450AbiBDLES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:04:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S59tAperIRJHiorzeQi+hy3XVZhP8EYbebGBglDvtAAVLf/C3B6lSPJy4/WMBwzHTfItwHoQkqoy2drhtXiy/sDLyR1QCQbGgzHE2Mk9yrP8woJxLIZgukacXKgFbh6NoGg866XMDstNyxS8TKB3S3weNFBbYsQSdYboMG7o+G1F5LS4KdolORABp5Bd4+ghYS8+Bq4YU+U789gudScBev+IrY3oNrFEnXWVeaPjAR3wXsNIgDhhhQl0oNJoRor794cp8YfV11H9eP1lG2fMrLQG/x6o1LSM5ufM1zv0i8GdIu0HYrXlADbJ1+DTc1tHi06cxqQEQwsKrhTyDO/FxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LiDD9wntrs7UqKDIah8wXuAbUEiNzASZd9d3Ipmo1M=;
 b=HxYRzJGqjqg/z4lox2sPtJVoDXVcoOpO4f7Y4rypjGbbcUZp4PFQJMfGHkMmCmMXofIkfcCDhdGxR62/e/gORuTgPFJUeSoDHu1YVBlacCk8+4lP9dcpyhCc0UPSve1zO9kv0z2H4BhZwKCjFN8m0woHH14erpHCoL2Kps0v5DkvCk9Y5yRtz41cDGBs8A197THsBD6Z1kMm8MWMIFi804RX40ZMTbCYa3gsTRV7gblEMT33SX0gnwHlTr1J23JY8sy9DCAR+KEwxjQ1DwBK0l/jfClljL6ZIdE7By/MHsS9kqGP6YdtoAaXb1jHspvqtbTYThvKX0KIKQafPWhczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LiDD9wntrs7UqKDIah8wXuAbUEiNzASZd9d3Ipmo1M=;
 b=YLGqE60IhWhZiMO9MBzGtQSuKEOX03YSuumHjS1+cMf8yKPj3cFcnGh0J1EM/xKJl3bQtxBhVC36UeiZ3sQjb2/CdxU4WnJnWAQ9hLbvKh2wPyCbjMcbpfh7ASY513mLib2Ldr14zoSPit73LZqFEi2ciPit5mWrlZ632BWrI6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 by DM5PR1201MB0025.namprd12.prod.outlook.com (2603:10b6:4:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 11:04:15 +0000
Received: from BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::b1bf:8e72:56ca:4256]) by BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::b1bf:8e72:56ca:4256%8]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 11:04:15 +0000
Message-ID: <0384ed3b-498c-365a-6c12-3c297a5a8a0d@amd.com>
Date:   Fri, 4 Feb 2022 16:33:57 +0530
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
 <9f95a85f-5396-b8bd-50cf-c4eeeac2a013@amd.com>
 <20220201141520.GB3301@suse.de>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <20220201141520.GB3301@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::14) To BY5PR12MB4289.namprd12.prod.outlook.com
 (2603:10b6:a03:204::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76f3e8a8-9f90-4ecc-a025-08d9e7ce151f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0025:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0025795659CC33476943B5ACB0299@DM5PR1201MB0025.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dP93QR6/4f13rJdImn2Ag/07JJWyYOKpMoQ7swLXEvIXfqQIon5mdWtuKO2o072ZU5Ppjeks7/RDv5rHTdnEqO63g7SjhI9BGNs1thPzTzceKmz+iQTafvNj00qHGrWooD58vEfwJBzKun6bFSdl9c8kxovPSQeyozusqmOx127so5jMAd4vpBovmKIbQ+i7OLmyWBVViIomqfDb6v5K6z+uQXgMZNQw5PnxQ94HJ1OPMU9RpR/ZMrxAtNntrF35fZ79j/a0xL32QCjh6JK0WyBBnbXjHC8OrmA7easpWSVPtFp0jjcq57c7JsTWXJMu+h45R00LQDiFZpy4fhyhchAILb2J2d+YmVRaae9w4gkAw6tOhULU1g/3kOl0aTeZKcB4clq1eO5gkB4pEG8q6/DcF+qBOTv/AgZrFsxQMUSd+AdA8hJAp+hlg8GaD+qR1FwzdvPR/eBAL+7x6Sr2VL3G7bHs7/KfpBp+wf7HYaTxR+OEQCA1krUB37s4cHhiAGgUnK3vKdxLO8HZr3qSZGbJIfjFJoC3o17A8lmTmfQY9HvzywiirtW5A/c/LoHhugbtwYHgqu35Rr3WyZXBWqHcK/bDxtUA4kxz0SLHBPQrFHHYIZom0xQ2kKQGnpV1WOJGXlGuFUmmvlnqiwC3EnFYNGMZfWnFuGt5insrVsc7HHHEkKv7d8b11SOfp+9LWaz8FbOgIYnBvP0FbRxvzmlWjevmWdRy5qNr9jQeACY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4289.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(2616005)(83380400001)(186003)(38100700002)(86362001)(31696002)(6486002)(31686004)(8936002)(8676002)(4326008)(66476007)(2906002)(36756003)(508600001)(66556008)(6916009)(316002)(6512007)(66946007)(7416002)(5660300002)(53546011)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0dxRVdRSzFOWS9MREhLR2dYT2FpMFJLUkJ5Nmt5d2VKRGQ5UDk2MG94U3dT?=
 =?utf-8?B?d0w3YjV4cEFUQ3psWXovcGQySFppNXJYN3dlT0Fydk5TWTVrWVc0N1V3bTd6?=
 =?utf-8?B?ZC9jNE56eDNNb0JlNGdmcWhFQ2dPR3ZqSUs2cTJJQi9LN0pGK3h2bzFrcnpV?=
 =?utf-8?B?c0dBL1lFd25iL2ppZ3ljUER0aTBQMFNTOTdiRmg1a0g5OWV2c2FRMzRTdnNp?=
 =?utf-8?B?T1h0TUhHbUE1VzZQZ3F2YjIvWmdMZ2p1dVJmTjBhQlo5U0I3S2x5b2M0cnRY?=
 =?utf-8?B?VnVUM3ljRjB0TWdxT2pvMHIwK3BzWmJudnFsaGkzd21SUXJFT3RxV3hBSlA3?=
 =?utf-8?B?QVFDUGZZVW5JVE5RaUhJaUxLbGNZUG5JZzU1aEVxOWNBb0pkaWpkZ0ZqM3FE?=
 =?utf-8?B?MHJKWjV6SjV1bHBPaiszdmQvMW5zTkJiajlzTGRhRit3UUo4TWVLRUhaYU5k?=
 =?utf-8?B?OGsxZTNSK3BBNXlnVTBnZEtUY2tXYm9kQjZOenhHbVNTUTFUZjFLWnRiV1c1?=
 =?utf-8?B?TlNSL0d1ZXpSRTNJMUkyS3BQcXNxdnpVV1hxUjhnMlZaeUk5cmsxTXlGNXNr?=
 =?utf-8?B?TUptSGczT0Z0QVp0TTV2SDVYVElTMXBNSHcrbkY2ZVdvOFQvUW1VYmdhYVIw?=
 =?utf-8?B?SGNtMWpwRWJYOGtWc1ZEUW5oNEtjeFNHUEJQbEwzZWdWekgzMUovajBPU2xB?=
 =?utf-8?B?cDFRS00wamtOOEZPbGhpQlJTdzFWWElaWkhpL2V3dXNwb1k2QlROVlU5WDBB?=
 =?utf-8?B?ME9RSWRCRDJFSEh1YnVmNkY2dXk5dGFxSnZ1aTBmSzlwZU1hdS93R3F6cDJF?=
 =?utf-8?B?WHo1WGxtWS9DSUZKelNkOGFsVTBhR0VhMmszVncvMVd1SFFrRkF4L2NlMHph?=
 =?utf-8?B?MGhPWHc5TDRDY29MNXBHYmtXcXR4WTk3SmlnVFl4YXFTMHNlclNCa0E4dHZM?=
 =?utf-8?B?WklZYUwvOFZSbDIvY1NVbmZxN0JROCtVbGpnUE1hVndHaTZGQWNoUytDYUFH?=
 =?utf-8?B?YTh5ZTRMZTREUk16L3pXemlUNzBKMTBZMktxZW02d29OK09neHhzRnpzTXZi?=
 =?utf-8?B?SE1NL2x6RkFiRVNkY2NrR3BhclBjZlZvMEwvUEMyZERLRE1qMEdyWS81MUUr?=
 =?utf-8?B?OUtxcWorSThuQWZDMU12MEU2M0RzTVAyZTQvZmd3aE10dXVOYUVnTzlQL1V4?=
 =?utf-8?B?SHplNFlxSzNOazNNdUx5SDB1akZlL0l4QTcrMkFMdU5WR3o2S2pyMHVnSmpD?=
 =?utf-8?B?OEs5ckU5ZXA0YmQvRk9HMFlaRXhHTkJwRXgvbGU3SDNmeGJPVGRNTFZPNlZN?=
 =?utf-8?B?c1Axc2FTRndUTUxMbVhVMmNRdUZSQ3VDTEpxeGJ0SUhIMHhwdEovRGRjMGlU?=
 =?utf-8?B?cEloQWg0WTk4ZDdOUDRuR0hHalVjTlBDUnd5WjhDajhYWWFMYUhNWUVxN0cr?=
 =?utf-8?B?SmZYV29pVnU2cDM4bi9XSjA2Z3N1Qmg0QmtkS3NyUGRZWGtIN3piazdDbXda?=
 =?utf-8?B?NVV0MTNNUzF6dko3MFZuM1FtUlFLZTFRR1hGNWUyc3JaSlF6R21QdDR6QmlF?=
 =?utf-8?B?NUoxWVhDZ1hmNGcyNm8rd0hlUm82WVZPRGR5b2FKbmZXV2F5aHhhL0Y2dVdK?=
 =?utf-8?B?ZEdzY2t1T0J1bGZPbDBtNWNDZkplcFhjNDVqUVFuLzZSSEtwQ3VDU211Mk55?=
 =?utf-8?B?MVkwM2w0OUxFanBZY3BodDJxK01BNDNHVFhmc1VZOG5JVHR5ajc1UGRwU2Uw?=
 =?utf-8?B?SjBEbnVielg5N1VnTDBwQU4yS1pvOEdmZWFJRXJzRVRITXNhMGJ0NGtLZVgz?=
 =?utf-8?B?cE9xcEhRdVB1NmRHL01kZXpPbzRXd3cvaGR5anl0US9TU0RlaCtDbEVPMnNr?=
 =?utf-8?B?bDRoaU9mUStWUU5oWG5ZYWRmRzFqQWFkRURvL2diSSs2R1F5U3BNQzlwaUcx?=
 =?utf-8?B?UDArWEZuREZEVFhpM3FRaUJ5a1VsQk5vZTRVVUt5VkNDSEVWTGtLb0VKejc5?=
 =?utf-8?B?VUsxQ2FDcTY4VmZTbzQrL2t0bXhudHp1UVFaZGd3akowbm45Rlowd0J0OXdM?=
 =?utf-8?B?ZExINzBBMExvRCtoYjJ6YXRUY2ttZDl4d1RBSVFMUjFNWU1ibzc4K1huQUVr?=
 =?utf-8?B?OGFyUjFkdFlTVjExTktRVysyWDZuYVJBTk9Bako0bnd0SmxiSCtkZHpQQjEw?=
 =?utf-8?Q?nRnpmqm64zaD9CmdJjsranA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f3e8a8-9f90-4ecc-a025-08d9e7ce151f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 11:04:15.8152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4GjpJLo4W4ONSYrtIkBPCFtjwS3/62xcdcZcGCyKRPxnthCWxlfaB/6cNZzosw6Ox9OIJobfvpy9ycJaWtaRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/2022 7:45 PM, Mel Gorman wrote:
> On Tue, Feb 01, 2022 at 05:52:55PM +0530, Bharata B Rao wrote:
>> On 1/31/2022 5:47 PM, Mel Gorman wrote:
>>> On Fri, Jan 28, 2022 at 10:58:49AM +0530, Bharata B Rao wrote:
>>>> From: Disha Talreja <dishaa.talreja@amd.com>
>>>>
>>>> Add a new framework that calculates autonuma scan period
>>>> based on per-process NUMA fault stats.
>>>>
>>>> NUMA faults can be classified into different categories, such
>>>> as local vs. remote, or private vs. shared. It is also important
>>>> to understand such behavior from the perspective of a process.
>>>> The per-process fault stats added here will be used for
>>>> calculating the scan period in the adaptive NUMA algorithm.
>>>>
>>>
>>> Be more specific no how the local vs remote, private vs shared states
>>> are reflections of per-task activity of the same.
>>
>> Sure, will document the algorithm better. However the overall thinking
>> here is that the address-space scanning is a per-process activity and
>> hence the scan period value derived from the accumulated per-process
>> faults is more appropriate than calculating per-task (per-thread) scan
>> periods. Participating threads may have their local/shared and private/shared
>> behaviors, but when aggregated at the process level, it gives a better
>> input for eventual scan period variation. The understanding is that individual
>> thread fault rates will start altering the overall process metrics in
>> such a manner that we respond by changing the scan rate to do more aggressive
>> or less aggressive scanning.  
>>
> 
> I don't have anything to add on your other responses as it would mostly
> be an acknowledgment of your response.
> 
> However, the major concern I have is that address-space wide decisions
> on scan rates has no sensible means of adapting to thread-specific
> requirements. I completely agree that it will result in more stable scan
> rates, particularly the adjustments. It also side-steps a problem where
> new threads may start with a scan rate that is completely inappropriate.
> 
> However, I worry that it would be limited overall because each thread
> potentially has unique behaviour which is not obvious in a workload like
> NAS where threads are all executing similar instructions on different
> data. For other applications, threads may operate on thread-local areas
> only (low scan rate), others could operate on shared only regresions (high
> scan rate until back off and interleave), threads can has phase behaviour
> (manager thread collecting data from worker threads) and threads can have
> different lifetimes and phase behaviour. Each thread would have a different
> optimal scan rate to decide if memory needs to be migrated to a local node
> or not. I don't see how address-space wide statistics could every be mapped
> back to threads to adapt scan rates based on thread-specific behaviour.

So if all the threads have similar behavior, wouldn't they all arrive at similar
scan period independently and shouldn't that stabilize the overall scan period
variation? But we do see variation in per-thread scan periods and overall benefit
in numbers from per-mm scan period approach for benchmarks like NAS.

And, for a thread that has completely different behaviour in the group, currently
there is no determinism AFAICS on when that would get its chance to update
the scan period and also whether the eventual scanning happens in the areas
of interest for that thread.  In that case, isn't changing the scan period in
isolation to cater to that unique thread an overhead on process address space
scanning?

Since process level stats are essentially aggregation of thread level stats,
process level stats will capture thread level behaviour in general. However,
if there are certain threads whose behavior is much very different from other
threads, they should eventually impact the process level behaviour is our
current thinking.

For example, in a micro-benchmark where half the threads have local-only
access and the other half start with remote-all accesses, the initial
behaviour of the two sets are completely different, but we do see that
per-mm scan period approach performing more or less similar to the existing
approach. However if we use further optimization related to tuning the scan
period in response to the detected node imbalance(this optimization patch
wasn't included as part of this initial series), things improve further.

Having said that, there could be corner cases where per-mm approach may not
be able to capture the per-thread behaviour effectively as you note. We would
surely want to explore such cases with per-mm approach to understand the
behaviour better. We can write micro -benchmarks for this but if there already
existing well known benchmarks that exhibit such behaviors at per-thread level,
we are willing to give them a try.

> 
> Thread scanning on the other hand can be improved in multiple ways. If
> nothing else, they can do redundant scanning of regions that are
> not relveant to a task which gets increasingly problematic when VSZ
> increases. The obvious problems are
> 
> 1. Scan based on page table updates, not address ranges to mitigate
>    problems with THP vs base page updates
> 
> 2. Move scan delay to be a per-vma structure that is kmalloced if
>    necessary instead of being address space wide.
> 
> 3. Track what threads access a VMA. The suggestion was to use a unsigned
>    long pid_mask and use the lower bits to tag approximately what
>    threads access a VMA. Skip VMAs that did not trap a fault. This would
>    be approximate because of PID collisions but would reduce scanning
>    of areas the thread is not interested in
> 
> 4. Track active regions within VMAs. Very coarse tracking, use unsigned
>    long to trap what ranges are active
> 
> In different ways, this would reduce the amount of scanning work threads
> do and focuses them on regions of relevance to reduce overhead overall
> without losing thread-specific details.

Thanks for these pointers, these are worth exploring. And any approach
for reducing the redundant scanning should complement the current effort
to optimize the scan period calculation.

Regards,
Bharata.
 
