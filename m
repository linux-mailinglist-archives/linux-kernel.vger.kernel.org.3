Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DBA4B1F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347688AbiBKHg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:36:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbiBKHg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:36:27 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FC210A3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:36:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPQTD9gqqcWgFxNoR8WHDdKHea7v/FA9Vh33T6At6oP1sijLZYGUnlmib/26obYHedHzwcyU8BPfVdaJvEc0G6+6Gs6Gy7oPtd6OvDX/mjBwQcqf0pqY2yFQe14hS6o80kxsL3/zYSeKwLvsR6jJGnExz0X6nsGispuYkNn2DSSpqfJlN3yol76PanVEUYUjp1U+ITidz3fp9nQGvKTh9dC/zr1fpGXwMyQSHHzi1thkcVS7JprjOZsqPbBHHYhr87ygFEWqnv4a8UyTUy8hJcRMz8FoJPQWlT0RM8UAHBXSqrqWtVu2/UsvTPHkJf+xWzC/10eyNFNCfVlKdGVGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AePh8Gn2wrg4bH5g1EhaSb6XFqDYSjueFmfDSKYcULo=;
 b=RdWb2Iib+dqdS/eX4LZT2Ujb47k1TlA/YEEpVHvWJj3i/miJ8IdQlPxOzJrbPCc8txgDREGeaIR3WVCZuinAhrU39Oso3CKqMRxMClfR566Jx722LlG/dOZ4qLJSNfJUeDTaJe3cHno+wihERKhFBnXFlYC+EbrsQNRGyaHmqXunC71O7izgOjmu47Y4yNvCk4zFjlE38tm+bDM9t2uQFWAYjKJGXQ3pZNH/tD8brD0lpZH4CCkYB5i3ehfzF7+HEvYPpX815pKOBSHwr42Z2fPRQB5mxs+CMn1mbWcXPAaUnzhvgxDh4qM7o6eix0G6N1uuaQkGC3nW7GjnWAnQTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AePh8Gn2wrg4bH5g1EhaSb6XFqDYSjueFmfDSKYcULo=;
 b=vqlWHtrZXHo3IUaVHIefDa+fZ35q75wFNibnmlecbqDjRizQviugq0ItykrsY1SOr8mLbQkAqqw3ms0K+Ah2rWQkwBsbMWerYNkpycCG3hEcPWcmBuj+qsDHo/prddqcZpa0ohU3nmCOfIM1J9bXy9Y6n+XURtIlFrFxZaVBSdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SN6PR12MB5694.namprd12.prod.outlook.com (2603:10b6:805:e3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 07:36:22 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432%2]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 07:36:22 +0000
Message-ID: <19d6fb22-11ac-1e84-f662-85801707db99@amd.com>
Date:   Fri, 11 Feb 2022 13:06:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "efault@gmx.de" <efault@gmx.de>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
References: <20220207155921.21321-1-kprateek.nayak@amd.com>
 <20220209104625.GM23216@worktop.programming.kicks-ass.net>
 <MW2PR12MB237955DEA3F949359A96E031982E9@MW2PR12MB2379.namprd12.prod.outlook.com>
 <YgP30sLEQfYPsMZE@hirez.programming.kicks-ass.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <YgP30sLEQfYPsMZE@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::12) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2d09af5-8cfc-45b2-7718-08d9ed31332b
X-MS-TrafficTypeDiagnostic: SN6PR12MB5694:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB5694D7B9CB64FE24414AC32A98309@SN6PR12MB5694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: en1qg63kUlVu24Ie7DN0Lym4mE2GM9XPC+oK61Fy+oVRF/M6Vc0r7iGvogmfIxQcH8KZGUmxr4OZlCZBRe1kfgoIIkGQg8ZYsdONRuBkMgB9gR2lh5KACt8OJCZR7vN5bQmQNjR8zx1wseCINwoGtnBe1gqSLx8p7sxlm5MqvLjQ1KAorhDlqmorUvpYSVYLOLvfiNxqVQXcEJixNWDznWVHe7haKtR7NdiWfeDpttXTW7WAl+nJdbNngi8dKqO53z6BDGncO4WXVeiH93SfTpBY03BtPbvKMgh8jFD4OFzeHFoKOR4fo4YM1ZOLH43/dCoeiPqk96QFx6MdnBpejXVm1mavJyfSBECloGtd3Kda/V67kvr7nY9BeU9OWrue2NiTf0FrSB2eOX67jvT9MgREmswTadHJAW8J3VvCmDoLSDrlqCGj58GKTZ5sYg+M0Pj843z5tNbTaLzwTeDQTZTfxHeSSkPT4yc0pdUF+yyv5IMy/AtRbXq3l7Eh0MoyAs0sNHd9qtwCbQu0ArcQdXouDm0tMDbkGCGwxudqRzGyCVjjzQh0lxjo2KsnE2S9ahwrMFxyWX0Y3yq1bgDdNjSeyULxhGvO+X/OLieMuGF05ZjcwurYizUEgI2NC6d6DjvFGjj9srZ/2KLosYqonrtVZsJVwJGJgbaOmRLRx6/emdMheQcz5VGvmTZRqvJkSzZm23GrdmknSph9IBv3Gbgn6EYXveFQ73i6n6q71gkoVpxqlGZ8982SKW1hODx1asaHDWJogwqI4qde/wCSl9xdCNg2Vk5KguHUrI9beWINOaZjcFkoEFVapfloXJ3MzBkazSJ3eOtzVDiK9HxODrdXXxjo4AoT19/h6LKlMw+4+E6hsKs6OejoqbxWV1br
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(2616005)(53546011)(26005)(186003)(316002)(2906002)(6506007)(38100700002)(54906003)(6916009)(66946007)(6486002)(66556008)(66476007)(4326008)(8676002)(5660300002)(31686004)(8936002)(6666004)(83380400001)(7416002)(6512007)(508600001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm5kRlU2eWNjd050NDYwaDRESTNRd2xLbnlCRHFFa0FBYXZrUU5xN1dCOHUw?=
 =?utf-8?B?aHZrdWl1QkNVMW1ieFJBYk5seGJZVEV2UXRxTEJyM1VPV0tGQ0pwbEJLVlNv?=
 =?utf-8?B?VHFYUzZ6d2NNM1NnWWxoSkhHUzV3RFJnNXlUMjFxSlFXeWlXREUvWTZENlIx?=
 =?utf-8?B?MXRsN2xBRXRLcHdnRnhPcGg0YWQ0ZUVuMzMyYmhoUGpJWEFwNUhNMkovb3gz?=
 =?utf-8?B?b0pGV0tOdEQySjFVNlhyaVFkcjNJdUZwR3FxRU1DTy9SZ25LemVxNFQ1L1BD?=
 =?utf-8?B?VTRuaGgwSmVBcC9xNFQ3RWEvTXhKV09jaENucEtvaFBmYlZjRFc4dkxnMVlW?=
 =?utf-8?B?d1ZUSlhwbU1KUTJiQmRydEU1Vlc4Y2poVytvMnJnUHYyb3J5eFJwYjd5c1cy?=
 =?utf-8?B?ZnROQ3NHbVNKc1IrbUR3S1pHWjJLbEkwdFdjTkJWaTBIKytVazREMzRpZGpj?=
 =?utf-8?B?cmVPRXhrbXBjVEhBWExSTlNnV2VQbnpWWmJXNGJEaGxySnNycmI2bTJVb3Nh?=
 =?utf-8?B?ZjFuc1NLbDVMTXpESEltdjBqMHNmMTUwRjg1cVI1YWZVcGFrVTl1a240WGJH?=
 =?utf-8?B?Q0pucHZGQmZJci93MERMRGExNUJvbm9kMnljUWJ0VnlXQUgwV3o0WURYMnd4?=
 =?utf-8?B?YWtTSEhkOGdhYnFReHRtcnpFWDlYZWpsZ0xMdEwxWVBxaUh1Y2dBT296UkJp?=
 =?utf-8?B?R0N4VEh6WTY0WGFldFlUQ05CZi93M1EwRzJLVzliUm8vNk5lem44R1lVaEpt?=
 =?utf-8?B?Z2FtQ01CN1RkRENicENTRStLSXQ5MnIyTi94TkVWRGkvSGVsQi80cEN1Nysw?=
 =?utf-8?B?bXE0cTBXRG5UaGFhYTFqcVlNTGJ1ZUplZzlRSURnaC9JZEtyVGxkdEl0c1lU?=
 =?utf-8?B?S2lkQndVQ1N6bUdmVmhpN1NVRFlDQWJmSDArRjZ4c2Mrb1ZVSmZEUWNNTnJt?=
 =?utf-8?B?RndyQTFLOE1FOTM5VmpnNG84WnBYOWtHa0NKMzJvOHdvSGxjMGpieEphMEd3?=
 =?utf-8?B?N2w1Q01pRUtCWUl3ak50T2s3eTRBeEoyZTJ5RzdmNWJvSTFvdW9va09VZHhN?=
 =?utf-8?B?MmNEcTZtUU1ncFh6cmN5L1daVExlMjdaYkZ3RVN1VWQzVVF4dHRQWHNSbzdB?=
 =?utf-8?B?R2hOTXhnakRnZUJ0aysrbDBpWVp6UHhDNWtCd1lqT0V2U3hPckhNTlA2T21S?=
 =?utf-8?B?N0V5dThSYVZOakhFdHNEZ3ovUjhkYmFtV3YzQVI0YTA3aUR3NUNLNEZvNDcr?=
 =?utf-8?B?ZUpxWmlvRDg4UCtaRDdGR0l0S095TklHbzFleTFFMlJON2hRQUJlTTRoblgw?=
 =?utf-8?B?QytYR1lTQnBqQVhXcU4yQ2RLNVdqV014YmR0bmhPcWZ2QjM2QitOQy84TjhN?=
 =?utf-8?B?bTM4ZW9zSVdQVkt1RXd0aWh3WGNEaVJzOFJ4eWYrbll0WHBVUnZUVlBCajc4?=
 =?utf-8?B?UjA1NjZhQmY2SFJTRmE1ZnA0OVdKajVxUUZsTGFpY0NKL3R6dmlQWU9NcnlR?=
 =?utf-8?B?K0xwVkdhVFBLZG5laXNBZU84TFhaR2xOTmVleE84bW5MTUJJUXdQUEd5QVpv?=
 =?utf-8?B?dXZ6M2JrMklodFJNR2dRMGxDL0RmZ01xSTRBcXlna05BdXk4Ri9YcFdpYWM0?=
 =?utf-8?B?ZGRsZmxyS3FQTm9DVHhiOHpsVE5FcDhNMVpIYVB4QjMwSWhtY1Z4MFVuRGtY?=
 =?utf-8?B?bHdpeU5scnNJTUNHTElvNXpiL2dxbGFoMEhPc2E5WWdIejZEK0RveXN1ZHBM?=
 =?utf-8?B?c2toVEFtUDBEbkZnbUE2Nk5OYU1TU1o4b3JDcFZmVVgrUk9jKzdBcXptbncy?=
 =?utf-8?B?NjBuSjNHS1p3QnduN1ExNThTV3NzRytZK0Y1eUhJMVlmcFFwUTZVUDI5VFJF?=
 =?utf-8?B?ZFZUcFRzdFg5WEJ1c3V0bjdpM3R2eVJpbVByNHNQcVJ1cWw1bFN1d1hlWGtw?=
 =?utf-8?B?VVUvUENYL1VaOUJ1c001RFNXVWRLbzE4K05ZeWRqeks5QUtFVlJYU0pqamU1?=
 =?utf-8?B?SGhtWjZUa01BallTU0FKSVphZmFSNTQ4TFFGUXdaNzVGc2hFelJPVDZLWmFV?=
 =?utf-8?B?Sk5nNmJod1Z3ZEJWWXhSUEVpODZBOUdXTFBpWkZFLzZZS2VRYkVSejNCM1NG?=
 =?utf-8?B?NFlQcHQxbkFTS2l4cnJKQnJoZVd4eVpCOVdPSEVyQzY4bUhma2VLY0NrRURD?=
 =?utf-8?Q?+Cbsw1rkQCgrMB7C2nqLzR4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d09af5-8cfc-45b2-7718-08d9ed31332b
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 07:36:22.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35bt+8quDDRLj6dPtZEYqUS7r21sR545gB8NgeXkiJ7lqwLE4HPUSdFpe3ztvTg9ij402WaKbCqtiAKhzzHtVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB5694
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

On 2/9/2022 10:50 PM, Peter Zijlstra wrote:
>>> Where does this affinity come from?
>> The affinity comes from limiting the process to a certain subset of
>> available cpus by modifying the cpus_ptr member of task_struck
>> via taskset or numactl.
> That's obviously not an answer. Why is that done?
Sorry, I should have been more clear in my previous reply.

Currently, the scheduler is conservative while spreading the tasks across
groups of a NUMA domain. It does so only when the number of runnable
tasks in the local sched-group is less than the allowed imbalance
threshold. The imbalance threshold is 25% of the domain's span weight
in sched/tip/core. Mel's recent patchset
"Adjust NUMA imbalance for multiple LLCs"
(https://lore.kernel.org/lkml/20220208094334.16379-1-mgorman@techsingularity.net/)
make it dependent on the number of LLCs in the NUMA domain.

In case of AMD Zen like systems containing with multiple LLCs per
socket, users want to spread bandwidth hungry applications across
multiple LLCs. Stream is one such representative workload where the
best performance is obtained by limiting one stream thread per LLC. To
ensure this, users are known to pin the tasks to a specify a subset of
the CPUs consisting of one CPU per LLC while running such bandwidth
hungry tasks.

Suppose we kickstart a multi-threaded task like
stream with 8 threads using taskset or numactl to run on a subset of
CPUs on a 2 socket Zen3 server where each socket contains 128 CPUs
(0-63,128-191 in one socket, 64-127,192-255 in another socket)

Eg: numactl -C 0,16,32,48,64,80,96,112 ./stream8

Here each CPU in the list is from a different LLC and 4 of those LLCs
are on one socket, while the other 4 are on another socket.

Ideally we would prefer that each stream thread runs on a different
CPU from the allowed list of CPUs. However, the current heuristics in
find_idlest_group() do not allow this during the initial placement.

Suppose the first socket (0-63,128-191) is our local group from which
we are kickstarting the stream tasks. The first four stream threads
will be placed in this socket. When it comes to placing the 5th
thread, all the allowed CPUs are from the local group (0,16,32,48)
would have been taken. We can detect this by checking if the number of
CPUs in the local group are fewer than the number of tasks running in
the local group and use this information to spread the 5th task out
into the the next socket (after all, the goal in this slowpath is to
find the idlest group and the idlest CPU during the initial
placement!).

However, the current scheduler code simply checks if the number of
tasks in the local group is fewer than the allowed numa-imbalance
threshold. This threshold is 25% of the NUMA domain span
in sched/tip/core (in this case threshold = 32) and is equal to the
number of LLCs in the domain with Mel's recent v6 patchset
(https://lore.kernel.org/lkml/20220208094334.16379-1-mgorman@techsingularity.net/)
(in this case threshold = 8). For this example, the number of tasks
will always be within threshold and thus all the 8 stream threads
will be woken up on the first socket thereby resulting in
sub-optimal performance.

Following are the results from running 8 Stream threads with and
without pinning:

               tip sched/core           tip sched/core          tip sched/core
                     + mel-v6                 + mel-v6            + this-patch
                 (no pinning)                 +pinning               + pinning

 Copy:   111309.82 (0.00 pct)    111133.84 (-0.15 pct)   151249.35 (35.88 pct)
Scale:   107391.64 (0.00 pct)    105933.51 (-1.35 pct)   144272.14 (34.34 pct)
  Add:   126090.18 (0.00 pct)    127533.88 (1.14 pct)    177142.50 (40.48 pct)
Triad:   124517.67 (0.00 pct)    126944.83 (1.94 pct)    175712.64 (41.11 pct)

The following sched_wakeup_new tracepoint output shows the initial
placement of tasks in tip/sched/core:

stream-4300    [032] d..2.   115.753321: sched_wakeup_new: comm=stream pid=4302 prio=120 target_cpu=048
stream-4300    [032] d..2.   115.753389: sched_wakeup_new: comm=stream pid=4303 prio=120 target_cpu=000
stream-4300    [032] d..2.   115.753443: sched_wakeup_new: comm=stream pid=4304 prio=120 target_cpu=016
stream-4300    [032] d..2.   115.753487: sched_wakeup_new: comm=stream pid=4305 prio=120 target_cpu=032
stream-4300    [032] d..2.   115.753539: sched_wakeup_new: comm=stream pid=4306 prio=120 target_cpu=032
stream-4300    [032] d..2.   115.753576: sched_wakeup_new: comm=stream pid=4307 prio=120 target_cpu=032
stream-4300    [032] d..2.   115.753611: sched_wakeup_new: comm=stream pid=4308 prio=120 target_cpu=032

Output from V6 of Mel's patchset is also similar.
Once the first four threads are distributed among the allowed CPUs of
socket one, the rest of the treads start piling on these same CPUs
when clearly there are CPUs on the second socket that can be used.

The following sched_wakeup_new tracepoint output shows the initial
placement of tasks in after adding this fix:

stream-4733    [032] d..2.   116.017980: sched_wakeup_new: comm=stream pid=4735 prio=120 target_cpu=048
stream-4733    [032] d..2.   116.018032: sched_wakeup_new: comm=stream pid=4736 prio=120 target_cpu=000
stream-4733    [032] d..2.   116.018127: sched_wakeup_new: comm=stream pid=4737 prio=120 target_cpu=064
stream-4733    [032] d..2.   116.018185: sched_wakeup_new: comm=stream pid=4738 prio=120 target_cpu=112
stream-4733    [032] d..2.   116.018235: sched_wakeup_new: comm=stream pid=4739 prio=120 target_cpu=096
stream-4733    [032] d..2.   116.018289: sched_wakeup_new: comm=stream pid=4740 prio=120 target_cpu=016
stream-4733    [032] d..2.   116.018334: sched_wakeup_new: comm=stream pid=4741 prio=120 target_cpu=080

We see that threads are using all of the allowed CPUs
and there is no pileup.

Output of tracepoint sched_migrate_task for sched-tip is as follows:
(output has been slightly altered for readability)

115.765048:  sched_migrate_task:  comm=stream  pid=4305  prio=120  orig_cpu=32  dest_cpu=16    START - {8}{0}
115.767042:  sched_migrate_task:  comm=stream  pid=4306  prio=120  orig_cpu=32  dest_cpu=0
115.767089:  sched_migrate_task:  comm=stream  pid=4307  prio=120  orig_cpu=32  dest_cpu=48
115.996255:  sched_migrate_task:  comm=stream  pid=4306  prio=120  orig_cpu=0  dest_cpu=64     * {7}{1}
116.039173:  sched_migrate_task:  comm=stream  pid=4304  prio=120  orig_cpu=16  dest_cpu=64    * {6}{2}
... 19 migrations
116.367329:  sched_migrate_task:  comm=stream  pid=4303  prio=120  orig_cpu=0  dest_cpu=64     * {5}{3}
... 17 migrations
116.647607:  sched_migrate_task:  comm=stream  pid=4306  prio=120  orig_cpu=64  dest_cpu=0     * {6}{2}
... 3 migrations
116.705935:  sched_migrate_task:  comm=stream  pid=4308  prio=120  orig_cpu=48  dest_cpu=80    * {5}{3}
... 15 migrations
116.921504:  sched_migrate_task:  comm=stream  pid=4300  prio=120  orig_cpu=48  dest_cpu=64    * {4}{4}
116.941469:  sched_migrate_task:  comm=stream  pid=4300  prio=120  orig_cpu=64  dest_cpu=32    * {5}{3}
... 20 migrations
117.426116:  sched_migrate_task:  comm=stream  pid=4305  prio=120  orig_cpu=32  dest_cpu=64    * {4}{4}
... 4 migrations
117.634768:  sched_migrate_task:  comm=stream  pid=4303  prio=120  orig_cpu=64  dest_cpu=16    * {5}{3}
... 5 migrations
117.775718:  sched_migrate_task:  comm=stream  pid=4303  prio=120  orig_cpu=48  dest_cpu=64    * {4}{4}
... 3 migrations
117.901872:  sched_migrate_task:  comm=stream  pid=4303  prio=120  orig_cpu=96  dest_cpu=112   END - {4}{4}

* Denotes cross NUMA migrations of task followed by number of
  stream threads running in each NUMA domain.

No output is generated for tracepoint sched_migrate_task with this
patch due to a perfect initial placement which removes the need
for balancing later on - both across NUMA boundaries and within
NUMA boundaries for stream.

Based on the results above, a bad placement can lead to lot of
unnecessary migrations before reaching the optimal placement
which is further found to be unstable - in the
sched_migrate_task traces above we see a lot of ping ponging
between optimal and nearly optimal case ({5}{3} -> {4}{4} -> {5}{3})

Thus there is an opportunity detect the situation when the current
NUMA group is full and spread the remaining tasks to the CPUs from
the other NUMA group.
If the task is not pinned, we fall to the default behavior as we
consider the minimum of:

min(number_of_allowed_cpus, calculated_imbalance_metric)

Mel suggested reusing the select_idle_mask which is now done in
my V2 (https://lore.kernel.org/lkml/20220209100534.12813-1-kprateek.nayak@amd.com/)
V2 changes are rebased on top of V6 of Mel's patchset and
contains the latest numbers for this fix.
--
Thanks and Regards,
Prateek

