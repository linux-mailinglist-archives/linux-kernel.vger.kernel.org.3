Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A08254CB1A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbiFOOUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245383AbiFOOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:19:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4CC35A97
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpgB7E9nXTCfOj8AwHBbm5lt/v/NCT58aXdC05CFvs3ANEhHHNMID5jFPqPL42P8zhO8ICv77XViA2BVKhWfeBfVGsHAx1MBs8kh6PVuO44jpoVs43UEbZ6fXZWkz6A871dSfUyMNbeAwELRXvUhxqPQ54wt32dnu68AkZLjfq7XqsvtVVxksw5/73sKGoHJPGa8bqTJyZJtyELpOBNUO/BttaZhLN2yIfM+gOVkIdjbfj6sqvFQ51RxAVEjclJZXQ+sALraoZfw7uih+N5C5S44NEGSXa9Yz9hYy5oc9XgHEp4ld1Z+w5mMUMCcI1mOLOFEAeKxqDMmFW2eSlXgiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8V2a/b+RHTC1x1yqqz1bp/oNRNGEY7qglKPC4ni/60=;
 b=FjylNxD0YHbRnntG5Zsbx2fBRRF2Nr1v8LxwsQrrm0Ao/b9UN88xMzQLgFH+ZjTFcFhBQMKz9B/2e5NiWnyzB+Fb1jYW8sJAsJxjiRKtmnBlty+iBkJ8snAecM78cNHA/ae0Hhn4Qu14BWGDbKH0x/vNHLueU02Uar5Q/PNnDzAT9nivoQS6vvK9fY8bAgXs8nvKe+fzpd4OjDVD8XDkEQ8WMdozgn4ghmH61dWNteGrdhWl9rzvh7puljK7bo0tAClFUZsezhSluRhot3YGRm8E1HWp7J8Hp5b9OJn9fuHYMhQoL8Uf6lCPnRu/Js+FCqtZqhbohxNcEWr57q/YQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8V2a/b+RHTC1x1yqqz1bp/oNRNGEY7qglKPC4ni/60=;
 b=BhUCReBAJMz6ZJofxZECWkXa4oTxB5xrlSQROXECrAchCSAg4tAF1Hf/ZjMFiZNLwT0A66ye8CwfpPPDEqJPraEtlkPi8Xtamibn6Tvlab/UNGX5opr/SHkJ6CDbTb3H05ej+QlVU0ehEjLhokv5/dARhyz+iKpYm1/0qdciFXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2381.namprd12.prod.outlook.com (2603:10b6:802:2f::13)
 by CY4PR12MB1781.namprd12.prod.outlook.com (2603:10b6:903:122::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Wed, 15 Jun
 2022 14:19:38 +0000
Received: from SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::e5ad:dd49:ae41:bc97]) by SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::e5ad:dd49:ae41:bc97%6]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 14:19:38 +0000
Message-ID: <e000b124-afd4-28e1-fde2-393b0e38ce19@amd.com>
Date:   Wed, 15 Jun 2022 19:49:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_resources API
Content-Language: en-US
To:     Yicong Yang <yangyicong@hisilicon.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tim.c.chen@linux.intel.com,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        guodong.xu@linaro.org, hesham.almatary@huawei.com,
        john.garry@huawei.com, shenyang39@huawei.com
References: <20220609120622.47724-1-yangyicong@hisilicon.com>
 <20220609120622.47724-2-yangyicong@hisilicon.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220609120622.47724-2-yangyicong@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::14) To SN1PR12MB2381.namprd12.prod.outlook.com
 (2603:10b6:802:2f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 221c702a-7223-4208-2581-08da4eda1465
X-MS-TrafficTypeDiagnostic: CY4PR12MB1781:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB178117D0B3C9DF223D66486798AD9@CY4PR12MB1781.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZU8dMc4/WZpzgJt6vqVWQePUlms89umCK4FWCvia59UdK41RvqLUkGKQHWdxWzJHZkMUIvxrOLNAU5Z4XqGklBAFaTf5e31AeOtB1BUqIMXS6C/031U7sjtY6FzlKfsba29n33QEX7E5onaIHyaS9fOc+i85Esmfo7OGDvHg8C8rPLUCsgs0twafV0pJdApeHCC+BqtRX3wf+/iBaFGI5fybsmvUZ62OtPDCPqaLyDyKezffWLGpHBHG95dyD2F9BWRLVZmy0+ZkmBCGpnFrv2IzdsJQ5/LN1VyB5Pw8iZ2quXlP8f2EvDblBzLLVX95KxnzqA0Qo09x/ZdKbm/lifY2+ZII9DFa944Qv8Nx/7td/nXNhMbe2Q0roHoV4V8x87wuX09hWyMIUKmPPN/YMzrt+RZ4j78N+O11MjR0CcW7/LTMOVIHedXz1OBEXh6k+zyzK+BxK1ZYS+yT2MyuhRXxiIdA3eOEWMzv0968k/rad7SgmWEHmFQqA4tVszeSxvo53lHxcQxKcC3URx3SyQ5MnUgfSZehr96NgApCxqXkzUx6rBgT/dV8lqD7YCi1SRcaSIK8FgBV61EGGN64sotJqSWTI6wlgdS8Y5ClJiIamTUrRjXjhTE/lRHKi7UjQK2lLKKIFmH5mOWX5p7f4WkXFKIhhOU239jnm8/m+9AwlTbrAjy6nFzwkr5A9UPzgs1xOEzbXOr14hyNo41FHa4Me79+AXt7AF2MVXd7EQEw8kZvvM8IvM0KOy5sjWIBJaXsRGo0WL+aFYLgp1eGkBdfXg6fRJ7EUp00AsP5flXwTq8smWmznHuTo4XMpjjv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(53546011)(186003)(2616005)(6506007)(66556008)(316002)(26005)(31696002)(38100700002)(6512007)(83380400001)(6666004)(7416002)(8936002)(5660300002)(36756003)(86362001)(31686004)(4326008)(66946007)(6486002)(508600001)(2906002)(8676002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVo1WDJKQ0I0SlVVT2Z5VFh6UllNYzhHUGVnajRaK2tCRVJrQXF3YjFnd2tG?=
 =?utf-8?B?RmhJOGVObWk1YlFFOUZvZ0k1Mk81WDRXQlU4MlpFTCtZL0o1eEVwYjRRbHY1?=
 =?utf-8?B?V3RycURGa1JCWTFiSVlBblBtZnpBaGZRYWhTSXNDOFBBOHBMQ3RiQ1loYjgy?=
 =?utf-8?B?a1FCcmtpalh6ZGlaT1NYQnNuR09Xa1pidWI1NVNRQ3h5dTludkVvempad0RS?=
 =?utf-8?B?YnJhN1hTRzVjOTlwVDJSY3J2Kzd0UXdUWkhObklIYmpNZDV1dWRKWE5WL3Na?=
 =?utf-8?B?bkZRUlFCNnRkemQrSHpMS2FHbkRVcHBxUDhneGJqVVJNbW54cTlQNnpkODJK?=
 =?utf-8?B?NytwY2JHUGs4SzMxSDZIZUVXMm1QekJJdnNTVVlJdzh2TjdSSDdSK0dFeXBr?=
 =?utf-8?B?YXc5ZWFVc1ZSc2c3aW5Cbk1tMW9kZ3pxajNNcWxtamROQTlzazlSQUZJOVFw?=
 =?utf-8?B?N04vLzN1OXJxdzhETWJTakIrNGFncmFpUExjaTRFUUVMdElmZEp0ZERxTC9k?=
 =?utf-8?B?ZHRrMVJjeE9oS255OEZSa2lmMWJIYXRMY3dxZk01LzlnTnRyUFIxVVVEUktr?=
 =?utf-8?B?MkdtWG1Ec0lYYnd5TEpjZWxDVlpRRkp1TVJtc1VaVURYWHUzeHpUMWxuWFJv?=
 =?utf-8?B?MFI2ZnN4RmQxeExDZU03cUIzcGFsTHkzOVh4b2RneCtzMjNSU0dTL2dhSkN2?=
 =?utf-8?B?WmF2N3JkcjdGUkw1YVFOVFlzRW5oZ1JRRGpFVUp3Ni93c2FvTCszc2VraG52?=
 =?utf-8?B?RWkyU0hIWm1ZaG9OYXNFbGIzRXRYeTF5Ykx5TndtbVg0YTNXaDc4ZlBkZndv?=
 =?utf-8?B?MXRHZ2EwaDE4ZFN6d3F2QWo0U2djN0RtdUVHWlpXWjRjNHhjdC9PQUpTWkdS?=
 =?utf-8?B?VTdLNE1ROEFVeTVORHhoT2NZWDBjUHVNb1dzbEYyKzJkTEprVm9iYmx2NW9m?=
 =?utf-8?B?Snpib1ZaRytBN2VabDBBcFdOQndtbFc1dCthSkJHbW85ZnIzNHhxUmhBSEc2?=
 =?utf-8?B?VVA5Q0hQQWlZRU05UmtEbm9FMm5EZVZndzczTG0yUGFwZWtHTWxSZjJYcksx?=
 =?utf-8?B?czlwZENOV2g0bC9keFE5eW5STTVZRFhXMXhKTnJ5SHFGMys0UmwrU0hQdGFP?=
 =?utf-8?B?UlM5NjVCbXhSOUwrd3RhUGwyZDFBV01zN0hwOGE4UXRvaWlhWFBSVDFFeVMr?=
 =?utf-8?B?VWhXcHhUWjZ2Sk5mdElGK1hCc21Ba2FWWnR6SCtUam96ODFzMEVlajJMS2ZJ?=
 =?utf-8?B?a3pjWmRZb2tqbEhXVFNGS3dKNGtGU2s5U2pkNTBtc2RybVRWTHF5ODhZYVZX?=
 =?utf-8?B?YXZRMVJpb1JpdzdJOGppRzd6WHVRemdObXRaMzlyYmIvL1UwVmFqaDNvZkdG?=
 =?utf-8?B?ckM3L0xiYnN6QlZpZzhya3l2cXg4NDdNek1xNkNjZXFkNWFqTFZQU2REWUFi?=
 =?utf-8?B?RlpWcXZIbTZKUjMyNHhPUG5aWHpwcnVyRC8rcnd6SUs0TGxwUmhqbXc4ZUFa?=
 =?utf-8?B?UklWZzdubU53SHRWK0xKVUZGbVcyS0VoTms4VkRhd2JpczVXY3hGSndHS3VO?=
 =?utf-8?B?UG9Sc2cxbDdIL2FKSjV5YXlzSWVNL2RoMGUxNHUwMkdjNVl4ZWdLQ3h0ZWpS?=
 =?utf-8?B?WFRyVDhvVGNXOVdRTndLK2NpWWtEUTBVaVlVMGlGYUtRMEpYeitMM2NTeGZY?=
 =?utf-8?B?VXRZSnVwQUZpRGNFeUFVVkhyZWJEU3dDaFM4bS9NcEw4TUdUMis5aFBneHNM?=
 =?utf-8?B?S2JTUm5SZnFUeTQ0M2JEeS95eFhJN1RyQllSUlBoZlRqdnRvU25yeTZlN2Uy?=
 =?utf-8?B?NGlMbkFGbkJhTHNPek9HM2YzbFhUMHI2L0FBcEh0TUgzUDVUYXl4VVI1QVVD?=
 =?utf-8?B?cVQ2dHFjSEVrVGRBalhJL1ZscllJMytHYllsaHAvYXkzcFo4UmJTWWZEdU5G?=
 =?utf-8?B?dWFyMGpGNmxtM1kyUFNaamZicGF6TEdnRlNxSGlzcHEwMFBQOExRRUg2Qncz?=
 =?utf-8?B?V2FnbUMwVUcwUjUyN2xtSktrWmJmVCs2YlhRcFZKRk8rVFNXL24xMXNYRGd0?=
 =?utf-8?B?ZjJGeFZiYUQ5NDcxN3JrSGp3RGpEN08yQ2xXN213WlhFZHJ2N2FwZlkwWDhl?=
 =?utf-8?B?SWpqcFNORlYwYmF0TEZsMFc4K3FvT3hkbTNpTSt2eitSZmJ3SjFEQzdleXJ2?=
 =?utf-8?B?YkNqa3lOS2YyOHBvVERNSnVwM3E0NTA3VGlzUXhRQlUxcTZyd1phblluYnRi?=
 =?utf-8?B?RlZIV1gwQVpTdEpBeFAxVnlSSWNuYXdRYnJMZnhxL0k2dnFjZUNYVkVGR1pD?=
 =?utf-8?B?TXJyUDd5TTdYMnd0cHJ4UURsSFpHRW1OekY2UW4rbTN2eUJvQWFwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221c702a-7223-4208-2581-08da4eda1465
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 14:19:38.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbvYhRPBb/vNUxwJosyjJPC24RlbntMNsB4aKxoVjtcjbZRZkXJdSwNo2JSSX+lKnS7NY3E5e1ryQKXoO98DoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1781
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yicong,

I replied to the v3 of the series by mistake!
(https://lore.kernel.org/lkml/0b065646-5b05-cbdb-b20c-e1dfef3f4d79@amd.com/)
But rest assured all the analysis discussed there was done with
the v4 patch series. I'll add the same observations below so we
can continue discussion on v4.

We are observing some serious regression with tbench with this patch
series applied. The issue doesn't seem to be related to the actual 
functionality of the patch but how the patch changes the per CPU
variable layout.

Discussed below are the results from running tbench on a dual
socket Zen3 (2 x 64C/128T) configured in different NPS modes.

NPS Modes are used to logically divide single socket into
multiple NUMA region.
Following is the NUMA configuration for each NPS mode on the system:

NPS1: Each socket is a NUMA node.
    Total 2 NUMA nodes in the dual socket machine.

    Node 0: 0-63,   128-191
    Node 1: 64-127, 192-255

NPS2: Each socket is further logically divided into 2 NUMA regions.
    Total 4 NUMA nodes exist over 2 socket.
   
    Node 0: 0-31,   128-159
    Node 1: 32-63,  160-191
    Node 2: 64-95,  192-223
    Node 3: 96-127, 223-255

NPS4: Each socket is logically divided into 4 NUMA regions.
    Total 8 NUMA nodes exist over 2 socket.
   
    Node 0: 0-15,    128-143
    Node 1: 16-31,   144-159
    Node 2: 32-47,   160-175
    Node 3: 48-63,   176-191
    Node 4: 64-79,   192-207
    Node 5: 80-95,   208-223
    Node 6: 96-111,  223-231
    Node 7: 112-127, 232-255

Benchmark Results:

Kernel versions:
- tip:      5.19.0-rc2 tip sched/core
- cluster:  5.19.0-rc2 tip sched/core + both the patches of the series

When we started testing, the tip was at:
commit: f3dd3f674555 "sched: Remove the limitation of WF_ON_CPU on wakelist if wakee cpu is idle"

* - Data points of concern

~~~~~~
tbench
~~~~~~

NPS1

Clients:       tip                     cluster
    1    444.41 (0.00 pct)       439.27 (-1.15 pct)
    2    879.23 (0.00 pct)       831.49 (-5.42 pct)     *
    4    1648.83 (0.00 pct)      1608.07 (-2.47 pct)
    8    3263.81 (0.00 pct)      3086.81 (-5.42 pct)    *
   16    6011.19 (0.00 pct)      5360.28 (-10.82 pct)   *
   32    12058.31 (0.00 pct)     8769.08 (-27.27 pct)   *
   64    21258.21 (0.00 pct)     19021.09 (-10.52 pct)  *
  128    30795.27 (0.00 pct)     30861.34 (0.21 pct)
  256    25138.43 (0.00 pct)     24711.90 (-1.69 pct)
  512    51287.93 (0.00 pct)     51855.55 (1.10 pct)
 1024    53176.97 (0.00 pct)     52554.55 (-1.17 pct)

NPS2

Clients:       tip                     cluster
    1    445.45 (0.00 pct)       441.75 (-0.83 pct)
    2    869.24 (0.00 pct)       845.61 (-2.71 pct)
    4    1644.28 (0.00 pct)      1586.49 (-3.51 pct)
    8    3120.83 (0.00 pct)      2967.01 (-4.92 pct) 	*
   16    5972.29 (0.00 pct)      5208.58 (-12.78 pct)   *
   32    11776.38 (0.00 pct)     10229.53 (-13.13 pct)  *
   64    20933.15 (0.00 pct)     17033.45 (-18.62 pct)  *
  128    32195.00 (0.00 pct)     29507.85 (-8.34 pct)   *
  256    24641.52 (0.00 pct)     27225.00 (10.48 pct)
  512    50806.96 (0.00 pct)     51377.50 (1.12 pct)
 1024    51993.96 (0.00 pct)     50773.35 (-2.34 pct)

NPS4

Clients:      tip                   cluster
    1    442.10 (0.00 pct)       435.06 (-1.59 pct)
    2    870.94 (0.00 pct)       858.64 (-1.41 pct)
    4    1615.30 (0.00 pct)      1607.27 (-0.49 pct)
    8    3195.95 (0.00 pct)      3020.63 (-5.48 pct)    *
   16    5937.41 (0.00 pct)      5719.87 (-3.66 pct)
   32    11800.41 (0.00 pct)     11229.65 (-4.83 pct)	*
   64    20844.71 (0.00 pct)     20432.79 (-1.97 pct)
  128    31003.62 (0.00 pct)     29441.20 (-5.03 pct)   *
  256    27476.37 (0.00 pct)     25857.30 (-5.89 pct)   * [Know to have run to run variance]
  512    52276.72 (0.00 pct)     51659.16 (-1.18 pct)
 1024    51372.10 (0.00 pct)     51026.87 (-0.67 pct)

Note: tbench results for 256 workers are known to have
run to run variation on the test machine. Any regression
seen for the data point can be safely ignored.

The behavior is consistent for both tip and patched kernel
across multiple runs of tbench.

~~~~~~~~~~~~~~~~~~~~
Analysis done so far
~~~~~~~~~~~~~~~~~~~~

To root cause this issue quicker, we have focused on 8 to 64 clients
data points with the machine running in NPS1 mode.

- Even on disabling HW prefetcher, the behavior remains consistent
  signifying HW prefetcher is not the cause of the problem.

- Bisecting:

When we ran the tests with only Patch 1 of the series, the
regression was visible and the numbers were worse.

Clients:       tip                     cluster              Patch 1 Only
    8    3263.81 (0.00 pct)      3086.81 (-5.42 pct)     3018.63 (-7.51 pct)
   16    6011.19 (0.00 pct)      5360.28 (-10.82 pct)    4869.26 (-18.99 pct)
   32    12058.31 (0.00 pct)     8769.08 (-27.27 pct)    8159.60 (-32.33 pct)
   64    21258.21 (0.00 pct)     19021.09 (-10.52 pct)   13161.92 (-38.08 pct)

We further bisected the hunks to narrow down the cause to the per CPU
variable declarations. 


On 6/9/2022 5:36 PM, Yicong Yang wrote:
> 
> [..snip..]
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 01259611beb9..b9bcfcf8d14d 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1753,7 +1753,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DECLARE_PER_CPU(int, sd_llc_size);
>  DECLARE_PER_CPU(int, sd_llc_id);
> +DECLARE_PER_CPU(int, sd_share_id);
>  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);

The main reason for the regression seems to be the above declarations.
The regression seem to go away if we do one of the following:

- Declare sd_share_id and sd_cluster using DECLARE_PER_CPU_READ_MOSTLY()
  instead of DECLARE_PER_CPU() and change the corresponding definition
  below to DEFINE_PER_CPU_READ_MOSTLY().

  Clients:       tip                     Patch 1           Patch 1 (READ_MOSTLY)
    8      3255.69 (0.00 pct)      3018.63 (-7.28 pct)     3237.33 (-0.56 pct)
   16      6092.67 (0.00 pct)      4869.26 (-20.08 pct)    5914.53 (-2.92 pct)
   32      11156.56 (0.00 pct)     8159.60 (-26.86 pct)    11536.05 (3.40 pct)
   64      21019.97 (0.00 pct)     13161.92 (-37.38 pct)   21162.33 (0.67 pct)

- Convert sd_share_id and sd_cluster to static arrays.
  
  Clients:       tip                    Patch 1            Patch 1 (Static Array)
    8      3255.69 (0.00 pct)      3018.63 (-7.28 pct)     3203.27 (-1.61 pct)
   16      6092.67 (0.00 pct)      4869.26 (-20.08 pct)    6198.35 (1.73 pct)
   32      11156.56 (0.00 pct)     8159.60 (-26.86 pct)    11385.76 (2.05 pct)
   64      21019.97 (0.00 pct)     13161.92 (-37.38 pct)   21919.80 (4.28 pct)

- Move the declarations of sd_share_id and sd_cluster to the top

  Clients:       tip                    Patch 1            Patch 1 (Declarion on Top)
    8      3255.69 (0.00 pct)      3018.63 (-7.28 pct)     3072.30 (-5.63 pct)
   16      6092.67 (0.00 pct)      4869.26 (-20.08 pct)    5586.59 (-8.30 pct)
   32      11156.56 (0.00 pct)     8159.60 (-26.86 pct)    11184.17 (0.24 pct)
   64      21019.97 (0.00 pct)     13161.92 (-37.38 pct)   20289.70 (-3.47 pct)

Unfortunately, none of these are complete solutions. For example, using
DECLARE_PER_CPU_READ_MOSTLY() with both patches applied reduces the regression
but doesn't eliminate it entirely:

   Clients:     tip                     cluster           cluster (READ_MOSTLY)  
    1      444.41 (0.00 pct)       439.27 (-1.15 pct)      435.95 (-1.90 pct)
    2      879.23 (0.00 pct)       831.49 (-5.42 pct)      842.09 (-4.22 pct)
    4      1648.83 (0.00 pct)      1608.07 (-2.47 pct)     1598.77 (-3.03 pct)
    8      3263.81 (0.00 pct)      3086.81 (-5.42 pct)     3090.86 (-5.29 pct)	*
   16      6011.19 (0.00 pct)      5360.28 (-10.82 pct)    5360.28 (-10.82 pct)	*
   32      12058.31 (0.00 pct)     8769.08 (-27.27 pct)    11083.66 (-8.08 pct)	*
   64      21258.21 (0.00 pct)     19021.09 (-10.52 pct)   20984.30 (-1.28 pct)
  128      30795.27 (0.00 pct)     30861.34 (0.21 pct)     30735.20 (-0.19 pct)
  256      25138.43 (0.00 pct)     24711.90 (-1.69 pct)    24021.21 (-4.44 pct)
  512      51287.93 (0.00 pct)     51855.55 (1.10 pct)     51672.73 (0.75 pct)
 1024      53176.97 (0.00 pct)     52554.55 (-1.17 pct)    52620.02 (-1.04 pct)

We are still trying to root cause the underlying issue that
brought about such drastic regression in tbench performance. 

>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 05b6c2ad90b9..0595827d481d 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -664,6 +664,8 @@ static void destroy_sched_domains(struct sched_domain *sd)
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DEFINE_PER_CPU(int, sd_llc_size);
>  DEFINE_PER_CPU(int, sd_llc_id);
> +DEFINE_PER_CPU(int, sd_share_id);
> +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>
>  [..snip..]
>

We would like some time to investigate this issue and root cause
the reason for this regression.
--
Thanks and Regards,
Prateek
