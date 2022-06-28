Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F88F55D186
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344852AbiF1Lz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiF1Lz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:55:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED0731218
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:55:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4XcPAsZVSt/zD57/z4HXbzn8yGkxuNPO0a7Ab9BT655xQD0v57TnvGz7QO4TXzBtupYT3YMzOkAV6Ee/V2/UUjuH5KQTnCdUBPMo/4QeXNeiEmtnpSwWlnMgasTGLQiOyKUJOpYHPuG0FI8PX5zT8Ax1coQbLWPEuph/gPeYN2XjpXjSqMHOxHhKxUdGFXdw+7qgUAtmLmKEizqetiFTUpNY+bnnZlu7DS/sPwN+PUhBVg8WiIaeq3RwToVcqLu+HJcNK7VYIDXYua6dQ8Cn37XpJBT8PRdGRw+rSw4bk6VGuQgev9HTKxk0sJxgCNpQ0KuwC5Qu30c+rYLmjDbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05G2tQlZY320Xs6SvweN1BrsAYuZd4BuZfKZhJl98Ak=;
 b=YmhLO5h8Ly3YoMJlygOFk1tsZIX21OWLtTJ6tkp5lCJdTMpYiCZwmXe32n7gRv88A6DU2D4fCxzSiXUdrxSg7QPBJO9jA8DuOJYdkJZFMzXX4TuAEWSFYJgTTZvfetV2/SfU/qx1X0KYkoAW32AipEd7Oe5CT4aMLVOOoPujawOv2qzYxAUPrCmgZK/KjSBqgoZ4N6EefPmFn9M8Dzu193Ivme2UoDCb/T7jIBYz9Z4MW7H9NzxcJORjc/4yinGF/MS0heTWcYrVXMuyUKqqUx30zqVUtYJObIqgOhG9NW4b+XNjPUN29iHIh1BekJY13QW/vLjGdRyue2xQCgg+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05G2tQlZY320Xs6SvweN1BrsAYuZd4BuZfKZhJl98Ak=;
 b=CSdS2Vrt8BOmmMSpUT3j8pAf/LjW62eO7C3OK+jc4d/1pr1a5YgPI9QGskF4CPaauC40JNBz7/L9GKzwUrkLvkOSXixl1HwUuB4qiITXKX7SOVp5Db/rux6xZADx9ROFogIQa2tSh+5iABa01UOCOZCC0H37ivZTuVtK5z8CMpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 11:55:23 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::bc2c:1f18:f03d:895b]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::bc2c:1f18:f03d:895b%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 11:55:23 +0000
Message-ID: <3db2443d-3c30-703d-d4c1-b184eccbf3b5@amd.com>
Date:   Tue, 28 Jun 2022 17:25:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_resources API
Content-Language: en-US
To:     Abel Wu <wuyun.abel@bytedance.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        guodong.xu@linaro.org, hesham.almatary@huawei.com,
        john.garry@huawei.com, shenyang39@huawei.com, feng.tang@intel.com
References: <20220609120622.47724-1-yangyicong@hisilicon.com>
 <20220609120622.47724-2-yangyicong@hisilicon.com>
 <e000b124-afd4-28e1-fde2-393b0e38ce19@amd.com>
 <81fbcadb-a58d-2cef-9c05-154555ec1d68@huawei.com>
 <6bf4f032-7d07-d4a4-4f5a-28f3871131c0@amd.com>
 <b87ddfd7a8dd418edfcdbad22a4fc1e9ef03109a.camel@linux.intel.com>
 <5638aed5-bbd0-a74e-759f-0de51e3651f7@amd.com>
 <cf13647f-6bb6-34d5-c6b6-41a7500a9612@bytedance.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <cf13647f-6bb6-34d5-c6b6-41a7500a9612@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::11) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0734194d-4819-477b-c6d1-08da58fd1524
X-MS-TrafficTypeDiagnostic: BL3PR12MB6521:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uL5JsqCRxAzkfcASxGrzZ+RqMi2Om0meNjKBaaLIDVNYr3ARxBtWrRCmBiefKkAitkj+4vaxWN94kVyjJoIjk2OzkDgvyGiXUMKZoAwdLJWsHjD0Aa9OEbybxTUW/ifmWYKyfhU4UvcRBauHYSgew8qkRhqWnXyXUuQjwM8ccAUQWeg0mE9UHTd4n5Xm3+ztOyM/agk2mgYKm9l5n9/WgG5k9DZfGMlCyvpntw0NLDUtmFoXt0UTHokstfD87I3N1rnOWeCdKAsOiVxaPIc30Gbsm1lKHqkAmJYsce3hUoVabdqtVl5xSH96ahxrAoMy8eRldh5E/xp9HShibnfvppFX08tAcSQ/RgoF9sjQDbVWeGYnYqc3laB2tTNckS/6k9/FdkLiCg9qvKskU+XyVY8IB9EOsGXPpQBYdm48z3NtsaVCkjI6gUDRZ2Ac5M8Pa7C4/wh9dvbxzY1iGELrBleZa+NozmhVCaY77Zgj0f6ABafBu7Dc2LDqZH61Py4NMckWQ5vZQ5aGVxeK+Y8E+YZ3aBKPB0a5oU7vW8IVaJSc3msnZlTGLg4OJVU7Tx4SYTdaTYkblxhnsvHknew48SSsaNVCsaRThLaJ2TFqNoJ5ubb1OxOtqe0Fb48qEbwW8IVBLG7KBZGaIhb+ThRnh15D9MvO4B0QdaqizGxK3X5WsgvwjNdSVYigDQh7LCcEO6JKgz2Aj9cL9nH/h1kW3+BEi6fpwRHwUNWlaLb4OZ0fG2FTNyf+JU8px5Mohqm5DMX5JcHPMw3TIrp/YmNYxQI6uj+0+/9+/9ENEvYLNAIDR9IqItLD+BfuPtMMBxdnQyFPCooxLH1AY50yabKH1yDGk1pV4Y7hLL2I9L8MeP+yV0wkPHzygvBGvsr1NCKd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(316002)(7416002)(53546011)(186003)(30864003)(36756003)(8936002)(5660300002)(31696002)(4326008)(110136005)(6512007)(2906002)(8676002)(41300700001)(6486002)(6666004)(6506007)(31686004)(66476007)(921005)(2616005)(66556008)(83380400001)(66946007)(38100700002)(26005)(86362001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bi9FckNKcHJFczQwd21ZQkxRMk5ScTJPR0tiamxLMVU5MzVoK001QXFTMWNJ?=
 =?utf-8?B?MHdTWHY2SHkrd2swTGprNWs2aCtETWVjb1djZ0QwZ3BPRnBtUlpBc2ZxVGZv?=
 =?utf-8?B?TkxzMUI5bUlCT01jMElTb04ycVpFUEVlenVkUCtwVUlsMUtMUWd4emNTYnBY?=
 =?utf-8?B?N0lOekVCWUN5czlhNVlBb1F0TmowZ3NLNisyNU1acWRCajV5UWRKV1ZFa2p0?=
 =?utf-8?B?d2d1T3BYTmZNL051UkhWeW1YVm1Dd3VKYkQ0c0xVTzRVank0RExVcmE1ZTBy?=
 =?utf-8?B?d3VTSTR1cnRZci9KT2pGTDhxMGFJc0wyRDJacUxUUDEzZGJqMC9QdUhTemxm?=
 =?utf-8?B?VGZ4R0RlNC9NcWdkdFlzUW56SmkzM1V2bTNmT01MRlVlSnJzS1pUZGxkU0xF?=
 =?utf-8?B?dmdZaWxLQU9wQW82NS8xWmhqYlJLdTc1M2cyNU0vLzVUQzZCTnJabzdWSDcx?=
 =?utf-8?B?a1ZjckpyR0lkaGVwcmcrdkRDaGQ3L05yK25rRHFiMHp6YnFQVzJDb1B3WUlO?=
 =?utf-8?B?Q0crS1VuMG4yY0FCWWxiMnExUk54WnR0OFdKQUMwZGgwcWRKd0JDK0tpSDRD?=
 =?utf-8?B?VVpIZWhUVXpoN3ZLUXVGVGc1QnlGWFFrWS9QVjFNczBZNkhNTGJhMkVwOHRF?=
 =?utf-8?B?RllPVElNQjAwK0gvUEZhczRoUmlZNmk5WjNuU0prTGJEUlFXcEpweWZoR205?=
 =?utf-8?B?STEyZERwVkFtM1NjSDRhZm81eHEyUkhKZ1lRK0tRbVZ0WjBwdUFzMUlRZFlW?=
 =?utf-8?B?NDRWTElIV1VpbkpWTVhDVEl2Q3gzVkFEOTZuNnpGSUZzZ1EvNHN1VzVOZXIr?=
 =?utf-8?B?UVB5RU03eEI0cEI4dFRmSEFwV0NpeVdzdGdWMEluejFOZXU2d09kbXgrSGE0?=
 =?utf-8?B?L2ovUTFVd0NsUGlZaFIvWFE1WFlJL3lKWGlKMFBFTUEzaWdLM2Y5TkN1UTA5?=
 =?utf-8?B?elM5L0hyZjAyakppTjZYUnd5S3dON2ltVGIxc1VxbldMbE1oSkQvdnZOZThX?=
 =?utf-8?B?MHpwNk5HKzZXUm12ZGJpVjFxNndBSVBWdDl2c0xLSy9CWWlqQU9RSXZTZXFk?=
 =?utf-8?B?UkRnRmZyREZETTlQWTFJd2UrSi9Palpqa1BIYW11ejdBbzRpbmVXZkpjY0Ro?=
 =?utf-8?B?aDY3Z1NTMTgrZmc5L1RsUEc5bjJ1dG03QXoybG5DOHliVHRvbGdLY0xGTGdN?=
 =?utf-8?B?dVQrbjNvdWJSNWkzS0NMNURoVWhjK1YwWmJYOU5aY2pCUUM1dFJaeWhJeStW?=
 =?utf-8?B?dzJvMnhIeEZwOWc4YTdveS9nbzVXdVRPdkRIaWdVOE1BR1NvWXg3aW9sNzJh?=
 =?utf-8?B?Y0lvTWhOR3lxUUdsbitsZUtCV3RjNXRhRGIyYy9WUFV6a1pnWm5Hdlc4NEJ2?=
 =?utf-8?B?OHJVMEptQ0lnVzQ0UjNrWkxUTmM4QU5iLzlyRGJDK20rYWlodzJjaXhnWnll?=
 =?utf-8?B?VVZjdG5PTkUraG9kQXZDdnlycG0zbVhURXJEWWhtRTF0UGMvQXpEcjJjZU5C?=
 =?utf-8?B?WE12WCtLTDRNS0JPTCtMVGZzN3I5RkxDMXBvZzBTQ3pBY0x5VVhrRlRmc21B?=
 =?utf-8?B?aGZkaXdsbUJMK0hYVnRMdWluTUJHNGVGclNIZUM3YWxzOHdCVnorT09xbEcy?=
 =?utf-8?B?SEdORnFIelZtNi9EcHR1VG85TVdoeVJyVE1VQXFPc1M2aFhybEJmNWZjWTJR?=
 =?utf-8?B?RVRyOEVyK0xSajZ2R0NGYXVBTlczdUE1SjkxR01Wc2s4WUNBbkNjYkZOcFVO?=
 =?utf-8?B?NFEwbmhWejR5bHFjQ2szbEgwbzI4WWVlVjlTN1ZxN2xjTzUrNmo3U3RLV3dB?=
 =?utf-8?B?YVJ2UzRJSi9UejBVLy9LRWl2WTJoTmd4RTNnSWNVT0JKbkhsWCtydG9GOEFT?=
 =?utf-8?B?ZXpaK2hXMlEySkVrU2lQbmFWbkx4OFZnVE5YZk8xRHpqM3luVmpOSkN5QUds?=
 =?utf-8?B?ZnVjL1RGUDJmZjEzV21KYU83NCtERWczZmRkL2hDWHR1aGgyeElQMGxKZXZI?=
 =?utf-8?B?THpyVlE4REFEME9ubjlWa1htQ085UThkbDc3SlBXMVVDSFBNZ0Vubkl4b0Jy?=
 =?utf-8?B?WDIxK0N2cmtzd3pub0VadE1DNHJMU0hNZy9aYVk4b3VwM0JBYUYxajB4ZUFW?=
 =?utf-8?Q?zcgoM3vVFZz4sY2rtKIIW4lzo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0734194d-4819-477b-c6d1-08da58fd1524
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 11:55:23.5579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UgGOHBuz1zUAogQ42HCYLdYfoQ01MoKLXfycx+F3jXi3O7T8qi+D8p/GXuD1L9zpKO3Dp35lvHyWlPJEADPEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Abel,

Thank you for looking into this issue.

tl;dr

We have found two variables that need to be
co-located on the same cache line to restore tbench
performance.

As this issue is unrelated to the functionality of
the patch, it should not hold this patch series from
landing given the performance improvements seen on
systems with CPU clusters.

The results of our analysis are discussed in
detail below.

On 6/20/2022 7:07 PM, Abel Wu wrote:
> 
> On 6/20/22 7:20 PM, K Prateek Nayak Wrote:
>> Hello Tim,
>>
>> Thank you for looking into this.
>>
>> On 6/17/2022 10:20 PM, Tim Chen wrote:
>>> On Fri, 2022-06-17 at 17:50 +0530, K Prateek Nayak wrote:
>>>>
>>>>
>>>> -- 
>>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>>> index e9f3dc6dcbf4..97a3895416ab 100644
>>>> --- a/kernel/sched/sched.h
>>>> +++ b/kernel/sched/sched.h
>>>> @@ -1750,12 +1750,12 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
>>>>       return sd;
>>>>   }
>>>>   +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>>>> +DECLARE_PER_CPU(int, sd_share_id);
>>>>   DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>>>>   DECLARE_PER_CPU(int, sd_llc_size);
>>>>   DECLARE_PER_CPU(int, sd_llc_id);
>>>> -DECLARE_PER_CPU(int, sd_share_id);
>>>>   DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>>>> -DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>>>>   DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>>>>   DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>>>>   DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>>>> -- 
>>>>
>>>> The System-map of each kernel is as follows:
>>>>
>>>> - On "tip"
>>>>
>>>> 0000000000020518 D sd_asym_cpucapacity
>>>> 0000000000020520 D sd_asym_packing
>>>> 0000000000020528 D sd_numa
>>>> 0000000000020530 D sd_llc_shared
>>>> 0000000000020538 D sd_llc_id
>>>> 000000000002053c D sd_llc_size
>>>> -------------------------------------------- 64B Cacheline Boundary
>>>> 0000000000020540 D sd_llc
>>>>
>>>> - On "tip + Patch 1 only" and "tip + both patches"
>>>>
>>>> 0000000000020518 D sd_asym_cpucapacity
>>>> 0000000000020520 D sd_asym_packing
>>>> 0000000000020528 D sd_numa
>>>> 0000000000020530 D sd_cluster     <-----
>>>> 0000000000020538 D sd_llc_shared
>>>> -------------------------------------------- 64B Cacheline Boundary
>>>> 0000000000020540 D sd_share_id    <-----
>>>> 0000000000020544 D sd_llc_id
>>>> 0000000000020548 D sd_llc_size
>>>> 0000000000020550 D sd_llc
>>>>
>>>>
>>>> - On "tip + both patches (Move declaration to top)"
>>>>
>>>> 0000000000020518 D sd_asym_cpucapacity
>>>> 0000000000020520 D sd_asym_packing
>>>> 0000000000020528 D sd_numa
>>>> 0000000000020530 D sd_llc_shared
>>>> 0000000000020538 D sd_llc_id
>>>> 000000000002053c D sd_llc_size
>>>> -------------------------------------------- 64B Cacheline Boundary
>>>> 0000000000020540 D sd_llc
>>>
>>> Wonder if it will help to try keep sd_llc and sd_llc_size into the same
>>> cache line.  They are both used in the wake up path.
>>
>> We are still evaluating keeping which set of variables on the same
>> cache line will provide the best results.
>>
>> I would have expected the two kernel variants - "tip" and the
>> "tip + both patches (Move declaration to top)" - to give similar results
>> as their System map for all the old variables remain the same and the
>> addition of "sd_share_id" and "sd_cluster: fit in the gap after "sd_llc".
>> However, now we see a regression for higher number of client.
>>
>> This probably hints that access to "sd_cluster" variable in Patch 2 and
>> bringing in the extra cache line could be responsible for the regression
>> we see with "tip + both patches (Move declaration to top)"
>>
>>>
>>>
>>>> 0000000000020548 D sd_share_id    <-----
>>>> 0000000000020550 D sd_cluster     <-----
>>>>
>>>>> Or change the layout a bit to see if there's any difference,
>>>>> like:
>>>>>
>>>>>   DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>>>>>   DEFINE_PER_CPU(int, sd_llc_size);
>>>>>   DEFINE_PER_CPU(int, sd_llc_id);
>>>>>   DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>>>>> +DEFINE_PER_CPU(int, sd_share_id);
>>>>> +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>>>>>   DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>>>>>   DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>>>>>
>>>>> I need to further look into it and have some tests on a SMT machine. Would you mind to share
>>>>> the kernel config as well? I'd like to compare the config as well.
>>>>
>>>> I've attached the kernel config used to build the test kernel
>>>> to this mail.
>>>>
>>>>> Thanks,
>>>>> Yicong
>>>>
>>>> We are trying to debug the issue using perf and find an optimal
>>>> arrangement of the per cpu declarations to get the relevant data
>>>> used in the wakeup path on the same 64B cache line.
>>>
>>> A check of perf c2c profile difference between tip and the move new declarations to
>>> the top case could be useful.  It may give some additional clues of possibel
>>> false sharing issues.
>>
>> Thank you for the suggestion. We are currently looking at perf counter
>> data to see how the cache efficiency has changed between the two kernels.
>> We suspect that the need for the data in the other cache line too in the
>> wakeup path is resulting in higher cache misses in the levels closer to
>> the core.
>>
>> I don't think it is a false sharing problem as these per CPU data are
>> set when the system first boots up and will only be change again during
>> a CPU hotplug operation. However, it might be beneficial to see the c2c
>> profile if perf counters don't indicate anything out of the ordinary.
>>
> 
> Would it be possible if any other frequent-written variables share
> same cacheline with these per-cpu data causing false sharing? 

This indeed seems to be the case. I'll leave the
detailed analysis below.

> What
> about making all these sd_* data DEFINE_PER_CPU_READ_MOSTLY?
>

Making all the sd_* variables DEFINE_PER_CPU_READ_MOSTLY or
placing all the sd_* variables on the same cache line doesn't
help the regression. In fact, it makes it worse.

Following are the results on different test kernels:
tip				- 5.19.0-rc2 tip
				  (commit: f3dd3f674555 "sched: Remove the limitation of WF_ON_CPU on wakelist if wakee cpu is idle")
cluster				- tip + both the patches of the series
Patch1				- tip + only Patch 1
align_first (Patch 1) 		- tip + only Patch 1 + all sd_* variables in same cache line
per_cpu_aigned_struct (Patch 1) - tip + only Patch 1 + all sd_* variables part of a per_cpu struct which is cacheline aligned

Clients:       tip                    cluster                 Patch1             align_first (Patch 1)       per_cpu_aigned_struct (Patch 1)
    8    3263.81 (0.00 pct)      3086.81 (-5.42 pct)     3018.63 (-7.51 pct)     2993.65 (-8.27 pct)         1728.89 (-47.02 pct)
   16    6011.19 (0.00 pct)      5360.28 (-10.82 pct)    4869.26 (-18.99 pct)    4820.18 (-19.81 pct)        3840.64 (-36.10 pct)
   32    12058.31 (0.00 pct)     8769.08 (-27.27 pct)    8159.60 (-32.33 pct)    7868.82 (-34.74 pct)        7130.19 (-40.86 pct)
   64    21258.21 (0.00 pct)     19021.09 (-10.52 pct)   13161.92 (-38.08 pct)   12327.86 (-42.00 pct)       12572.70 (-40.85 pct)

Following is the system map for the kernel variant "align_first (Patch 1)":

--
00000000000204c0 d sugov_cpu
 ------------------------------------------------ 20500 (Cache Line Start)
0000000000020508 d root_cpuacct_cpuusage
0000000000020510 D cpufreq_update_util_data
 ------------------------------------------------ 20540 (Cache Line Start)
0000000000020540 D sd_asym_cpucapacity                  
0000000000020548 D sd_asym_packing                      
0000000000020550 D sd_numa                              
0000000000020558 D sd_cluster                           
0000000000020560 D sd_llc_shared                        
0000000000020568 D sd_share_id                          
000000000002056c D sd_llc_id                            
0000000000020570 D sd_llc_size                          
0000000000020578 D sd_llc                               
 ------------------------------------------------ 20580 (Cache Line Start)
0000000000020580 d wake_up_klogd_work
00000000000205a0 d printk_pending
00000000000205a4 d printk_count_nmi
00000000000205a5 d printk_count
00000000000205a8 d printk_context
 ------------------------------------------------ 205c0 (Cache Line Start)
00000000000205c0 d rcu_tasks_trace__percpu
--

At this point it was clear that one or more sd_* variable needs
to be co-located with the per CPU variables in cache line starting
at 20540. We began moving variable out of the cache line one by one
to see which variable makes the difference as we found out that as
long as root_cpuacct_cpuusage and sd_llc_id are on the same cache
line, the results were equivalent of what we saw on the tip. As both
the variables seem to be accesses very frequently, access to one will
prime the cache line containing the other variable as well leading to
better cache efficiency.

Placing root_cpuacct_cpuusage, sd_llc_id, sd_share_id, sd_llc_shared
and sd_cluster on the same cache line, the results are as follows:

Kernel versions:
tip					- 5.19.0-rc2 tip
cluster					- tip + both the patches of the series
cluster (Custom Layout)			- tip + both the patches of the series + reworked system map
cluster (Custom Layout) + SIS_UTIL	- cluster (Custom Layout) + v4 of SIS_UTIL patchset by Chenyu
					  (https://lore.kernel.org/lkml/20220612163428.849378-1-yu.c.chen@intel.com/)

Clients:      tip                     cluster          cluster (Custom Layout)       cluster (Custom Layout)
                                                                                            + SIS Util
    1    444.41 (0.00 pct)       439.27 (-1.15 pct)      438.06 (-1.42 pct)             447.75 (0.75 pct)
    2    879.23 (0.00 pct)       831.49 (-5.42 pct)      846.98 (-3.66 pct)             871.64 (-0.86 pct)
    4    1648.83 (0.00 pct)      1608.07 (-2.47 pct)     1621.38 (-1.66 pct)            1656.34 (0.45 pct)
    8    3263.81 (0.00 pct)      3086.81 (-5.42 pct)     3103.40 (-4.91 pct)     *      3227.88 (-1.10 pct)
   16    6011.19 (0.00 pct)      5360.28 (-10.82 pct)    5838.04 (-2.88 pct)            6232.92 (3.68 pct)
   32    12058.31 (0.00 pct)     8769.08 (-27.27 pct)    11577.73 (-3.98 pct)           11774.10 (-2.35 pct)
   64    21258.21 (0.00 pct)     19021.09 (-10.52 pct)   19563.57 (-7.97 pct)    *      22044.93 (3.70 pct)
  128    30795.27 (0.00 pct)     30861.34 (0.21 pct)     31705.47 (2.95 pct)            28986.14 (-5.87 pct)    *
  256    25138.43 (0.00 pct)     24711.90 (-1.69 pct)    23929.42 (-4.80 pct)    *      43984.52 (74.96 pct)    [Known to be unstable without SIS_UTIL]
  512    51287.93 (0.00 pct)     51855.55 (1.10 pct)     52278.33 (1.93 pct)            51511.51 (0.43 pct)
 1024    53176.97 (0.00 pct)     52554.55 (-1.17 pct)    52995.27 (-0.34 pct)           52807.04 (-0.69 pct)

Chenyu's SIS_UTIL patch was merged today in the tip
(commit: 70fb5ccf2ebb "sched/fair: Introduce SIS_UTIL to search idle CPU based on sum of util_avg")
and seems to bring back performance to the same level
as seen on the tip used during our testing.

The system map of the tested configuration labelled "Custom Layout"
is as follows:

--
00000000000204c0 d sugov_cpu
 ------------------------------------------------ 20500 (Cache Line Start)
0000000000020508 d root_cpuacct_cpuusage
0000000000020510 D cpufreq_update_util_data
0000000000020518 D sd_llc_id
000000000002051c D sd_share_id
0000000000020520 D sd_llc_shared
0000000000020528 D sd_cluster
0000000000020530 D sd_asym_cpucapacity
0000000000020538 D sd_asym_packing
 ------------------------------------------------ 20540 (Cache Line Start)
0000000000020540 D sd_numa
0000000000020548 D sd_llc_size
0000000000020550 D sd_llc
0000000000020560 d wake_up_klogd_work
 ------------------------------------------------ 20580 (Cache Line Start)
0000000000020580 d printk_pending
0000000000020584 d printk_count_nmi
0000000000020585 d printk_count
0000000000020588 d printk_context
 ------------------------------------------------ 205c0 (Cache Line Start)
00000000000205c0 d rcu_tasks_trace__percpu
--

The System-map is however dependent on multiple factors
such as config options enabled, etc. which can change from
build to build.
Finding a permanent solution to the issue might take
some more time.

Meanwhile, as this is an issue unrelated to the
functionality of this patch, it should not block
the landing of this patch series.
Thank you everyone for your pointers and patience
during this debug.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
--
Thanks and Regards,
Prateek
