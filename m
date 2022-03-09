Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A73D4D2E23
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiCILeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCILeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:34:20 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2388936E00
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:33:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHaY29WqkN+2pKElaUqaquXkv5CFVJl+LJsVfO4EsTq/CC6FRrcUb6ePD0KAu+2N0dOGOGb1etf65kXoUYeqMiD9nAX4OzxJcofdWoWMtmzXJ+aeB6YwcZPRmtZWr23BxjFLl2d1MgWikT3z92fXsI0Bm1o9he2EtiDltmdh0eAlCRfbbXlki8MV3ymJQwSaa+6uaWfz7sera1M7Orys2hAOKzZCnphDlzPpkGeeu53pT8K0q76UrXL9NH4djpdrJISE9Jxr6LNrswQOIeFCwN95JU/PbErUMAG3w4NYviWXR1xoUUTawHdmkhTQ3toOzUXovY8DP+YDjKCIiPUD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OUVsMA5M+53cjXspIn388Zmist4WPx7B+HpU+IjAKw=;
 b=HWxReJ/iSWFRxKODaUD3wM1d/78c479/pGvz9DyEDaImpocSbkOL/CoA3LWWYZWSTevzkZydpqGO+L+9eNHO5KYHECMVWV0xtgIKVmhvyydjhxN3Yw2gaRt31gZg9vvCHNdcLYqlGkAozLKl8JkHilrDiT5WRY570P2vyzfZ1OwplbZfv/LDrsVkR2NvhHRPNqxSuJzosv4OZvR/VWyLu83HUqxwZ7fLxmu4052S3n/arczkJTKxBy06wZ4lSfrKIawhCbjv547MvolYUy8FqtDcMSv7NHBdCqqislO2vPwU5m6IidOjx7dXhhk/qQ2iD9DLuK37MjOGDbGtrfjogw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OUVsMA5M+53cjXspIn388Zmist4WPx7B+HpU+IjAKw=;
 b=QNM92Fqm3o6vIcZY9eYzqLJRHvk1NM2l0sUQlteaKnYrO1qX2U8XVkG4xYewNcW/4fOvk4srTSuG3XZGJ8CUkhVlhpj7Wk6GNUALzYp7ZnNMGyPbraM/ALnxA7dPNIayws9JN1NjzTm5L5qHZK9kYqDlshw/fR/Gj4U6+uTYAG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM5PR12MB1579.namprd12.prod.outlook.com (2603:10b6:4:c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Wed, 9 Mar 2022 11:33:18 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::a094:81bc:148a:fc38]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::a094:81bc:148a:fc38%5]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 11:33:18 +0000
Message-ID: <9effd823-5375-fce0-cb92-6630e82d8b04@amd.com>
Date:   Wed, 9 Mar 2022 17:00:33 +0530
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
 <bb443650-868a-49b7-e41e-c2a788781df5@amd.com>
 <20220309094320.GL618915@linux.vnet.ibm.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220309094320.GL618915@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::20) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49cb45b1-a6b9-4dc2-aa3a-08da01c09b13
X-MS-TrafficTypeDiagnostic: DM5PR12MB1579:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1579F55359B728D870DFF62E980A9@DM5PR12MB1579.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ynf4kaEJ7FvtHSomfzFWe3Vb5NAYJwGjp3qTW4hbuxjbXO7CNWlJIC4KNMA1uhAb89w4/oO3SPJufNyY5ssRM9/v17Pg/O7pMBH+gi+BH/4O3DzVX2VLwiqda6UnVJicDgJKKPYtpFfngs4ZgPKfpsHL4nAgd2geKyonAEMZNc31j6x36Mvr+8K753CaKZiUHceOysB3i07HoGV7xnThspk4DSUM3hIiCz744p+ikPLRb4xmMEQ4qqlnC7xazoef/fdU+UgCZ9lkUN73NRIpw++yXT+1yB2ChSqxildqmoe9QapZXqMuaW0PTes8zDfxllhAWWeGTz6CQCDxiAUra/Oijif7MMIuzfnGtx1/bYk6e5TZnW8E2Vgbmu0KddIwgsLs14+w2uWMl2yRxF5nE3cLACsSI781afTKDp5TA0PJG3teWXg7v8tNtzl6FoZK0QPH6AMuY47xTQr4B/kKrOOjiv8i03yeibV5U/dD9lJokW/JJW17EyoI1W7RHM4EsR3muHABNYbMTa5SfJJYsKRFIVTRaWIdzpNUJr2azteDb8Xzz0ACWKWAPmTrOB2knx2h1LeKdfLTboq+zl0nRsWrb5D9xiJHgOVUsPI8nIPvhA3aH5sWSdSb6ewUlR62RNLRh0zl5RJto9uEjD03TLktZmmX0YOOqj/AzLfaB5CKt2uxXq12u1hjfUdwllrDgvJabr3U0xGCC+9s7NUV2dcavkyi3KVLMuZa9ozEpqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(508600001)(2906002)(6486002)(31686004)(6666004)(6916009)(6512007)(66476007)(8676002)(66946007)(66556008)(4326008)(5660300002)(36756003)(2616005)(8936002)(38100700002)(86362001)(7416002)(6506007)(26005)(186003)(53546011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHpWQ1dReDdhRnpyODRRUldwdTVkY0pnenpscTBGQm9pVm5GU09XYis1ZXdH?=
 =?utf-8?B?RFdFMmtNSHhRbXRMa0N2dTFxSENnbW9mWjJhZGZmK1ptcmxjbmRXVXN0aVpC?=
 =?utf-8?B?cnNPZVUreTJwL0tzQkp3OWNNbFM4NUVQKzUzakphSWZhMmpYZTNpd2htZG8v?=
 =?utf-8?B?ZERFdGxRbXQ4ZUdhVGpPOEJzOGNPWUpDTC9MYWt0TmZMZGZheklZbXNMVDZC?=
 =?utf-8?B?bElkMTlscmJCL3FPK3NIVk1vTkNEMWFUcUt6a2NoY0tUN0FwWmxISHhweGgw?=
 =?utf-8?B?RUxHNWxHWHlSRjlkcVRneFVxRTBhaFlFTDQyWFJ3eWt0RGJwRDVmcWJwYTJz?=
 =?utf-8?B?MXhpeFlqREY1RkVUSU5kVWJmeG1TTUJWd1RtMVMxY21QWFNyWE9PelhaRlFG?=
 =?utf-8?B?Vk5CWlNqMFk1MFd0WWZEVmNjQm1pV3A1Q1doR2REcEpaSmptQWpFemUrZEJB?=
 =?utf-8?B?ZDNRUkNrN0ExbWVpZHU2U1JPNUdXaldqRmNmMWdtVnh5VS85NW1sWndzSUd1?=
 =?utf-8?B?R0VjWW85TjRYcHBRdTYrY1RKUVpWUjRRRGFtK2xXRG5RVXc2aVVEdmlSNzU5?=
 =?utf-8?B?d0U5b0NCaStrTm15dGs3cHhlUHlMTnFTUGJSeHl2SjU4YWdsVDh0ZTdkKy92?=
 =?utf-8?B?QmdVT0E5RHY0VGVIYVdEaFBDMVNjVGdpcSt0VjZZUWxyN0xEektCRlhqdXJT?=
 =?utf-8?B?cFNRc04vamdFV2NvaThBVjFFditlM2R3cmFEbnVxcW5IakxGMmZVNDA1Rzk0?=
 =?utf-8?B?dEVSRzZKdm13U041OVlVSmlLV1FieHNhKzFrYTBjSWwwbHBucUtpcHRweDF4?=
 =?utf-8?B?MnJoaGhwTGRrdHVXRkFHUk42WFpnaDZpbE9yL3pvSm5Jdlg1SWt2YzcvbThT?=
 =?utf-8?B?cElKYjZLb3ZrYVdIVE9xQnRvakN2THR0eWhFNm5NQlU5b2ZDWndsK3RtMlQ5?=
 =?utf-8?B?Ymk0TG52aHVZeVZNak1xck5RVWo1L3RzU0RlQlJuVjI3a0JzRzA3cWdTYkxm?=
 =?utf-8?B?TGRreHdUUzluTFByeDd4QnVZbllBdFdTUHN1bXo5eE00d1NIOVdTaGJ2RFVp?=
 =?utf-8?B?WmtyU1pMSzl2cXIrRVFEblFEeTNtUGczNElaTE8xNXdsYUdxZWtScHV0NkZO?=
 =?utf-8?B?VEl2K1NpZzU4RHNVRXRtYisveGQwZTZTVGt2YkxIUVFZN21OL0ljSWc2LzNJ?=
 =?utf-8?B?N29uM0lGTitKck9MQkpEd25NaGd1cTVtRll3TjZmcklhS0wxZnZJamRYb2p2?=
 =?utf-8?B?aGsyeXVZQjVHcEt4Yjk4UXhsS2lTcU9WVHhqemRNWVJsQWZIelhOd203NDFj?=
 =?utf-8?B?aGtsWnpkbnJiL01zTE9kRDdSNFlCcGFZY3dWL2g1Vm5sdTdiWmp5MWxYUjBY?=
 =?utf-8?B?akxUUU90TEkvSnRzS2QrRUhWUjJORTB5aVpvdTJGeWtvbHlLTGxwZmZZUFRG?=
 =?utf-8?B?RTNFUUdOZHM5bGo0anZmWnNxNGFRSmVnUDlLLzhVOTFwSFVVd2htdUswSEZB?=
 =?utf-8?B?cFNYRWMweHIxSkd1YVk0cE5UWHFGMllsb3YzQnlmNTF2bWZrT1hEeDFtV3N4?=
 =?utf-8?B?MC9QYnZjRnc5TGJuSFhjSmNrelBESUpZTGp2VGlWWXVadytodW9jdUU5TnRH?=
 =?utf-8?B?T2VSRXFsUVI2UjdBbGNXZ2hkU0NRLzl6QStjNm9yVXFqR2gzTEVURkRMbFQ3?=
 =?utf-8?B?eTQ1bXhib1d5bkhqVFoyeVRnK3RLeDQxUjMxUnBkM2ptT2NhZDBRSUtxZ1lD?=
 =?utf-8?B?YlpoNDdPZ01kdGNhNFhYZEwwTnFCcEhsQkZpOHBZa2RvUG12SGV4K2lhWG05?=
 =?utf-8?B?OVk5RmZ3YlBEWU83Nk1yam1zejR0RC9TTjRuMmtxemIwWlZPQUpaajF0SDhM?=
 =?utf-8?B?M3QvamZma3FiVVZVdm5qeXdLSHI3QzdSY0hHcDhJZmtOb1M0Z3B6NzExdno0?=
 =?utf-8?B?b0dpaEVGSktxVmVxNFdyK0l5dHcvRm9BUVY0TlBrQW9RM2pTenkzY1A2NGdD?=
 =?utf-8?B?enZvdEZWd281NDRXYmN0dWtEbHQwNGpHcGRWSDRtUi9vU28wOHUydGZTQVBI?=
 =?utf-8?B?alNnMlh2NGhIVFBKOVkwTUk0ckM0U3VtTklOMmdkamp1UXBaOVRyT0dFazJa?=
 =?utf-8?B?S3hQR2dpaHFoOU0zSVh6QUR2NmNIVi93ZXkvQUpNdnZDVklUUDNCVnc5Y00x?=
 =?utf-8?Q?/IrfWidFf83g5A5L+llWIxU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cb45b1-a6b9-4dc2-aa3a-08da01c09b13
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 11:33:17.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvneKk2SNyjWnHJYKS1Va/l43evUUOVfuvqkaUI+98fpUvESp68TD/N+1aIHTwx/PtgKEew9QNkrwUX31E2Meg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1579
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

On 3/9/2022 3:13 PM, Srikar Dronamraju wrote:
> [..snip..]
> I completely understand your problem. The only missing piece is why is this
> initial placement *not a problem for the unpinned case*. If we are able to
> articulate how the current code works well for the unpinned case, I would
> be fine.
From what I understand, the initial task placement happens as follows:

When a new task is created via fork or exec, for the initial wakeup
it takes the slow path in select_task_rq_fair() and goes to
find_idlest_cpu(). find_idlest_cpu() will explore the sched domain
hierarchy in a top-down fashion to find the idlest cpu for task to
run on.

During this, it'll call find_idlest_group() to get the idlest group
within a particular domain to search for the target cpu. In our case,
the local group will have spare capacity to accommodate tasks.
We only do a cpumask_test_cpu(this_cpu, sched_group_span(group))
to check is the task can run on a particular group.

Hence we land on the case "group_has_spare". Here, if the sched
domain we are looking at has SD_NUMA flag set and if
(local_sgs.sum_nr_running + 1) <= sd->imb_numa_nr
we decide explore the loacl group itself in search of the target
cpu to place task on.
If number of tasks running in local group is more than sd->imb_numa_nr
or if the domain is not a NUMA domain, then the group with
most number of idle cpus is chosen.

We traverse the hierarchy down finding the idlest group of each
domain based on number of idle cpus in the group find the target
cpu to place the task on.

This is just a basic picture I've painted with the details necessary
to explain correct placement in the unbound case.

Consider the unbound case:

- With 8 stream threads
The sched domain hierarchy will be traversed as follows:

Socket Domain ---------------> Die Domain ---------------> MC Domain -> SMT Domain -> Idle CPU
[NUMA](2 socket)               (8LLCs)                     (16 CPUs)    (2 CPUs)      (Target)

  ^                             ^
  |                             |

sd->imb_numa_nr = 8            Each stream thread gets
All 8 stream threads           its own LLC as the
are placed on same             choice of group at this
socket as up to 8              level is purely dependent
tasks can be running           on the number of idle
on same CPU before             cpus in the group. Once a
exploring across NUMA.         stream thread is scheduled
                               on a LLC, it contains less
                               number of idle cpus
                               compared to other LLCs.

- With 16 stream threads
The sched domain hierarchy will be traversed as follows:

Socket Domain ---------------> Die Domain ---------------> MC Domain -> SMT Domain -> Idle CPU
[NUMA](2 socket)               (8LLCs)                     (16 CPUs)    (2 CPUs)      (Target)

  ^                             ^
  |                             |

sd->imb_numa_nr = 8            Each stream thread gets
First 8 stream threads         its own LLC as the
are placed on same             choice of group at this
socket as up to 8              level is purely dependent
tasks can be running           on the number of idle
on same CPU before             cpus in the group.
exploring across NUMA.
                              
Starting from the 9th          First 8 thread will go to
thread, the placement          the 8LLCs in the first
will happen based on           socket and next 8 will
the number of idle cpus.       take one LLC each in the
8 CPUs in one socket           second socket.
will be running the
8 stream threads
previously scheduled so
the rest of the threads
will be scheduled on
the second socket.

If we bind 8 threads to 4 cpus on one socket and 4 cpus
on another, there is currently no mechanism that tells the
scheduler that it can explore the other socket after
scheduling the first four threads on one.
> [..snip..]
>> If a compatible cpu is found in the group, it is stored in new_dst_cpu
>> member of lb_env to be used later in the load balancing path if my
>> understanding is correct.
> Yes, this is the LBF_DST_PINNED logic, So I am wondering if that is kicking
> in correctly because this is the only difference I see between pinned and
> unpinned.
Ah! I see. But I do believe this problem of initial
placement lies along the wakeup path.
--
Thanks and Regards,
Prateek
