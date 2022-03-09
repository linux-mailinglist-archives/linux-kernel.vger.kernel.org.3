Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323514D2951
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiCIHOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiCIHOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:14:15 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2082.outbound.protection.outlook.com [40.107.100.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED8F710F8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:13:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odRPK/+fYTU+1u9nKnjy2r0AxTU/cgBKLHA3+YoAButdzU779vZ7KR+5TsXBMODYaIVrvzQd7BOIgG3I0q6Sd2yYyYL0PFCB0rYWx80fv0w55FGdPXCBd1z+rH+pWgg+umJhU0+/btyAY5BIV0Au7olij+iN5mPmxVUxGITRM2suyuNGnbirvycUGP6Q/QY9L2r1wg49wk1dufRb/nK69K/jVmSaffvhtIGQBiXa8ChTwbktX3GFXdwuGx6IfBLmGtUX0ZkYi5C25SMeCRFQaAjPnp6MavsDS4yRZwkUb6qOiBJLJnkEgP6xyo6xyztjE2qg5ZQX6Sr0z3yYHsShBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFREi8Sy5PvUgDfHs0BiwGrw3bILUxnGn3pSevYXIL4=;
 b=hCi6NkWhrc48VT3ZHs5E8oxrMkSvrzzJoXPGAKHAYr+4pN0EVWxlYo/TC7PpCiIW4Zfs9HyPHUalcmTU3kWjg92VctDAZOaoSZmf5t34F9i0F8+vXQLVL0AwFusrwGDlJkdk4izfBhzq+9EBiHCstFZdLmc9s1qASBnlCzaI1MeHpz++IwV3WLPVszJS+7nEsnX9uUbTrIV5tTrNI5XC/NeRXOHiLJ1OoFljL+12HM2+nDxlb0tFkP10opQm9QagXWMePIrP/Z0okEKfg04CXMXDPKMcpE/iUbpgw1qG873EKQ8PyvyNtYXaozc/+1GUZbHnsnhA3S27bU8gXOaMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFREi8Sy5PvUgDfHs0BiwGrw3bILUxnGn3pSevYXIL4=;
 b=19gFSM+b+7SixJJrOc2p/yeTrYfIQnHGum4xXfIZrNJr8WQ1ktStx0rEDuLuV69xVtJL1W5foa4VWU+DFWWd1AgCI27swfUgqbugArZllCp45pq24BvkV3KuJNexeczjKsUDi4Jx11CItC0yWZLc3VuXWG/rK517wa5k4ZQsIUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BYAPR12MB4727.namprd12.prod.outlook.com (2603:10b6:a03:99::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 07:13:07 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::a094:81bc:148a:fc38]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::a094:81bc:148a:fc38%5]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 07:13:07 +0000
Message-ID: <bb443650-868a-49b7-e41e-c2a788781df5@amd.com>
Date:   Wed, 9 Mar 2022 12:42:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Content-Language: en-US
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, mingo@kernel.org,
        song.bao.hua@hisilicon.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
References: <20220308063749.6929-1-kprateek.nayak@amd.com>
 <20220308092944.GJ618915@linux.vnet.ibm.com>
 <7e5bdc95-a30a-58bc-fc67-98b03fe1fa22@amd.com>
 <20220309052554.GK618915@linux.vnet.ibm.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220309052554.GK618915@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32f27a9e-dc0c-4d4d-4897-08da019c42a2
X-MS-TrafficTypeDiagnostic: BYAPR12MB4727:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB472763915FA1A08FE0205EDD980A9@BYAPR12MB4727.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKWhiRyDe6hyDcHI+W4P89FnsKlWqnsy4gQvJxq5087q3yOa8ZFsDl55dCSlW9ZJ/yyCUA+Pj7HirsZEn+aKNXR06yWc6ULXtz8LuOTIj+urOZhKCvSTdbreKVnvDQ2xCGJhP+H+Gr91I4MiGKDPlfjKs5oTYlbOhx3knOfIR9DG7te98dUH0luQ2U2rxQe63PKFENxr5D5pXcQFDi2RyVCrjCcMggwnfcdqcoga+PIsi1RJiiZ2zXtK/twxsfZ898LHmkAurXsNlB02EhLotuSD7XakspN+cZMUHdU5wW0YSora4i9R+QbLJ/eoitn08dH1cZmXNm0pjFsjdqhTKZLpLRw55YU8THEpaekjqFICl41KWr2p5Z8EzCbhUUGLRmXeK4HM6tspJb9Bt5cnmIMg5AOXbj4xTmzOA1C0I8RmNK60iguMmqgaet1xCsbMTtqBpe0jkZpHpM/VQkTkeL3tZmLiY9mnydCkvM1Ru0j9Eb0IbCG8xDe3W1NOM/8Y2phJhFQxL5538HOqlVp8zTb6Pr/3bjfGoXVZcm2dpCNjH/Efd5j57h27t83oNYMCd0huFLwGecTJaouEY1TGxBKAFeS4z1yQqixeM6v/ZQvYr+OgBE13F2y3k0YSWkmrmsEgk1DJOEAlozAQhhjWZwN1ycZKABjCqLBquTnKja9XpBEt9C8dcAlMKW6eRUdoSHDuZVIdaRYZUTxAIo9wgwXYuxbrNnoI7uKgcubDQh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66556008)(66946007)(31686004)(36756003)(66476007)(7416002)(5660300002)(4326008)(6486002)(31696002)(316002)(86362001)(2906002)(6916009)(8936002)(6666004)(6506007)(53546011)(26005)(2616005)(186003)(38100700002)(6512007)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVkveXJVLzFmOTZEQlNVOFlBYWlRSnE5ZytkOUNZU2tpMWt0d0FSNnZDbWhS?=
 =?utf-8?B?aEJsdTU5SHd6ZmtJRDNEbDBPTjVISmVCcjJhUzlDVWtlOEN6bUFDL2gyVVpE?=
 =?utf-8?B?RnNFUzBuN1hscFVuTkM3VGd0a01DY1dXaFpEckRNRy9pZnl2NlRSZGNrL29O?=
 =?utf-8?B?QmRabFdRcEdvdkdnLzdNVC96YkZveUtqWUtaSC8waVYzOWpFUEpyUHhmeklO?=
 =?utf-8?B?cUV2TzR4K2t1MVlOTzZtSjhWSjhBM1l2UmY5M0R2cjNWVVdGOThvUzdkMWRx?=
 =?utf-8?B?Y2w5bXdwOXROM1JZSDZibWlLR0xvWG1pSzFQS25SQWQrZUdJeGVYcG1nTTA2?=
 =?utf-8?B?YlBGelVLamlpcllTZE5OMTVodG1VcG9rQSt1SlptZGY3SFRGVUVPeFh4STJw?=
 =?utf-8?B?a2ZkSi9RRzNDMjNnZzh1SVR0SzhUbk9qbXg4enhrbGdrRUVyMGhDZncxeFdj?=
 =?utf-8?B?VDZEZkNBUEFGSGpBZTVyWU4vYlJFUEtEWEFkU1pTMWFXdmhpQzA2cXBZSmpo?=
 =?utf-8?B?dlNva0E4TnRVVGVSQ08wY2ZxME9QUXZqTnJrRFd1RVRtMG41akoyZWtObkRl?=
 =?utf-8?B?NlR0cUZKR3pvV1pyMGFBdjk2OTNNSHBkSi9aSUdZT3FvQ2ZrczMzbGpFZ0Vr?=
 =?utf-8?B?OXNyaTlRY3FYSEVrQyt0MDR5alZJRm9US0ptYlNnYVRkMTlNMm42UzlISTlY?=
 =?utf-8?B?STIxRHNPYTE3OHN1UzJ3Q04zZnhJTE1YaHRocGxBeXJRWlE3Z0NQQjBVSVpW?=
 =?utf-8?B?T2x1NnZqL3Y1UDNrd24vQjFXZkN5MVdLc3ZzQVNUNTVaR0k1QmplMFFrdS9Z?=
 =?utf-8?B?dTJtRCtHVmMxb1lIUkhsc0c3R3luMm9ocVVYcU9wUzhIQ1F4RzdpbDB5Ris2?=
 =?utf-8?B?dXlTRlp1SXdEMjFLd21Nd2dDdzFoVE1hZ0FodDZlbkMyUWJwNXhuMjIrbUZ5?=
 =?utf-8?B?eUlHcGdFNE1HZ0ZoN0tKbVZuMmhCSHZyMU5zQ0F4Vi9RSlR5Q3BrekJJWGlK?=
 =?utf-8?B?YjFtTXNoVDlySFFSRzBubFVqRTdtZ3VUMkNjMUlPRXNjNWRreFBuOW5TTXA1?=
 =?utf-8?B?YnNpQnMvQWl4dzZUakV3OGlPSUtxRUNVU1NPYXAreUhFd2tqaWJ1TklUVXVY?=
 =?utf-8?B?N3orNC9wZG1LQW9zN1o3eW1pYitEZ25mMmNLQWRJenVNdnErS2E5elc0OSs2?=
 =?utf-8?B?SktjRVE2RjRGd1ZlVkRENkQ0T3UweUR5VzZMU05yZkxaV0U5VVRpcE9QRVNJ?=
 =?utf-8?B?UFViek9OTFhnSU5NVG8rZjZXMEJ6TnpwZ3FtR25BUS95YVlRZERjRnlUS0px?=
 =?utf-8?B?cFk2ZVJ1YmJDNVVKT1dQWkc0N0xReU9ocHFvNkZFL2xSc1Z1THF4YmNBQnN2?=
 =?utf-8?B?WVRPMFFRZDFRRVVNNVRkMllLWEtGTnFHZW1mUDZybEduYWRuTkRRdzJ2Q2ZM?=
 =?utf-8?B?NzU2Tk0yaUhiWVBScDNZckgrMnhqVGcrUmltTkhCZ2hqSFoyNStJTXlzcVB4?=
 =?utf-8?B?NCtMTUZpQ2svUmlrNEh0UlkrNjNmV0xnM3hIOGMramF1WHJNeW5mbmphcnQ4?=
 =?utf-8?B?UFkweWZuWmdoTnR4cE1FTVAvMmVodnV2TjY5UXdOKy9xRXVWS1MyclNONzgr?=
 =?utf-8?B?VHV5YjZ3VUxlaGZQRUE4cFk1Y0lWZUdNenVaUGw4Vi8vRDl0am54enZETWZJ?=
 =?utf-8?B?NnZRRGhCUFRWb203RmVPakdpU2dlWFl3Y3Z3VVM0SUtCRGxxMWRRbTlIcXJP?=
 =?utf-8?B?aGYvRy9ielRVRlJTb2FSeXFhM3RQZUF3eitmZUZqeld0eXhsZjl2ZlkxYjF5?=
 =?utf-8?B?d3crT3BXYlRoQ1BTZThIayt1ejkxblpHalQ3c052QnNyZUg4QUM4RWlwODRl?=
 =?utf-8?B?Y0Y2S3ZSNUJzUXo4ZVRScWdpbC85bm5BeDhJWC8zZzQwTjVPYVVpblgrQ0RR?=
 =?utf-8?B?b2lINXdqb0JqdkJoUW5OOGRIQVo3M0xOejNDMGNTaDF1TUIzblBTRWxndUdQ?=
 =?utf-8?B?VlV1WjRCQU83d2kxT1NDbU5xYkRYYmRuRm5BWDc1VHo1REFaL1NiMUVQQi9O?=
 =?utf-8?B?THlwMkREVlFteGlVK3gvUHlsNXZSU0FKYmJSWDN2SUZmVFA0RjNCZEFvNDhv?=
 =?utf-8?B?RVNwR1VybllVc2daTUNhWWpaOXoyRXF0YWRva3hpamZuVkxUQ0J2QzdOeFVj?=
 =?utf-8?Q?lGhx28XjbUZbSfGxZsIRfEI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f27a9e-dc0c-4d4d-4897-08da019c42a2
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 07:13:07.3303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K44LkXl98jA70qDhTIs/bBS2LJUhiLVeX6d9VRchIfxIIG3eDss7QXdobcr/oIQ1nwXG3W+1Cm1fl146POTEig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4727
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Srikar,

On 3/9/2022 10:55 AM, Srikar Dronamraju wrote:
> * K Prateek Nayak <kprateek.nayak@amd.com> [2022-03-08 17:18:16]:
> [..snip..]
>> Yes. We've tested stream with 8 and 16 stream threads on a Zen3 system
>> with 16 LLCs and in both cases, with unbound runs, we've seen each
>> Stream thread get a separate LLC and we didn't observe any stacking.
> If the problem is only happening with pinned case, then it means that in the
> in unpinned case, the load balancer is able to do the load balancing
> correctly and quickly but for some reason may not be able to do the same in
> pinned case. Without the patch, even in the unpinned case, the initial CPU
> range is more less the same number of LLCs as the pinned. However its able
> to spread better.
The problem this patch is trying to solve is that of the initial placement
of task when they are pinned to a subset of cpu in a way that number of
allowed cpus in a NUMA domain is less than the imb_numa_nr.

Consider the same example of Stream running 8 threads with pinning as follows
on the dual socket Zen3 system (0-63,128-191 in one socket, 64-127,192-255 in
another socket) with 8 LLCs per socket:

numactl -C 0,16,32,48,64,80,96,112 ./stream8

Number of cpus available in each socket for this task is 4. However, each
socket consists of 8 LLCs. According to current scheduler, all the LLCs are
available for task to use but in reality, it can only use 4. Hence, all
the stream threads are put on same socket and they have to initially share
LLCs and the same set of cpus. This is why we see stacking initially and
this is what we are addressing.

We've observed that load balancer does kick in and is able to spread the tasks
apart but this takes a while and quite a few migrations before a stable state
is reached.

Following is the output of the tracepoint sched_migrate_task on 5.17-rc1
tip sched/core for stream running 8 threads with the same pinning pattern:
(Output has been slightly modified for readability)

167.928338: sched_migrate_task: comm=stream pid=5050 prio=120 orig_cpu=32 dest_cpu=48 START - {8}{0}
... 9 migrations
168.595632: sched_migrate_task: comm=stream pid=5051 prio=120 orig_cpu=16 dest_cpu=64 * {7}{1}
168.595634: sched_migrate_task: comm=stream pid=5048 prio=120 orig_cpu=16 dest_cpu=64 * {6}{2}
... 3 migrations
168.625803: sched_migrate_task: comm=stream pid=5052 prio=120 orig_cpu=0 dest_cpu=64 * {5}{3}
168.626146: sched_migrate_task: comm=stream pid=5050 prio=120 orig_cpu=16 dest_cpu=0
168.650832: sched_migrate_task: comm=stream pid=5050 prio=120 orig_cpu=0 dest_cpu=48
168.651009: sched_migrate_task: comm=stream pid=5048 prio=120 orig_cpu=64 dest_cpu=32 * {6}{2}
168.677314: sched_migrate_task: comm=stream pid=5048 prio=120 orig_cpu=32 dest_cpu=80 * {5}{3}
168.677320: sched_migrate_task: comm=stream pid=5050 prio=120 orig_cpu=48 dest_cpu=64 * {4}{4}
168.735707: sched_migrate_task: comm=stream pid=5050 prio=120 orig_cpu=64 dest_cpu=96
168.775510: sched_migrate_task: comm=stream pid=5051 prio=120 orig_cpu=80 dest_cpu=0 * {5}{3}
... 39 migrations
170.232105: sched_migrate_task: comm=stream pid=5049 prio=120 orig_cpu=0 dest_cpu=64 END {4}{4}

As we can see, 63 migrations are arecorded during the runtime of the
program that can be avoided by the correct initial placement.

As you highlight, there may be areas in the load balancer path that
can be optimized too for such a case.
> I believe the problem could be in can_migrate_task() checking for
> !cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)
>
> i.e dst_cpu is doing a load balance on behalf of the entire LLC, however it
> only will pull tasks that can be pulled into it.
Please correct me if I'm wrong but don't we scan the entire sched group
and check if there is a compatible cpu for pinned tasks in can_migrate_task()
when !cpumask_test_cpu(env->dst_cpu, p->cpus_ptr) ?

If a compatible cpu is found in the group, it is stored in new_dst_cpu
member of lb_env to be used later in the load balancing path if my
understanding is correct.
--
Thanks and Regards,
Prateek
