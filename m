Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD95956E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbiHPJpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbiHPJok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:44:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12EB102640
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGhlYq8unSeYkXAjxt7Ln+cSgrWEgk30MWB58mD3GOIOsSultGaCazwiTHCZsmY1utob1zUvOiet5KmUWp+V8eBsSS+6bXwLmiCu7VXet55R5wQXZwHg+TRGIMoAH58oidBxaFDqtWAIdNvYQKkXU5xs8JNc0qDY1LTUU36TIUdTMxiREG/ZjNEuaWnguApbLQbR6cjJA3ch4XAMuTH/1mFg/tCHygVPt/hT/wsGVNSWmwkaFgKMrgHFfPOmdewvrgyUF4SCSMihAHcPyTxSrUSPbCIz9QdV02YNV/R1QYGGJwOXtTVGi/MubKLUPllxhRXwCntuugu2kNN2v5qnRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbCgZhlW7mQsft2vNmnE2U2KSU5i2aQxe1DXd2eUOEk=;
 b=lj3NP5VZHeJS58dp07JSajIpPRbWXcvp+NWj7s+51CgCUVPPUfCY3LfgXQvejjdbudRQLi5qzREPtVoR5q25bejxSRaBUfqz47GKwTYuXk01/+EOUVc1B1aYdJxumVLljrGOiSqaG0rgEth4DCgfgLBUluqfEOlk5wKxfo1+4lr+5nPybUMHiH+z/6kRtmvpMxmTdm3aiYT7PxN/wIdSTAiklNsSg4eNVqlyFxqOkQMvWymzWDmbITHGkMpK4RUHDVzD4N3wFdzfIswjSwPiuZbS4D09KrXaLTMBVr7yVKEzQNXcKKQG+SUb/DKrB61lkx40wRiHDAcW4HtLWXJtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbCgZhlW7mQsft2vNmnE2U2KSU5i2aQxe1DXd2eUOEk=;
 b=R3x+F0SMPgDl9UsfKTovTXtRHXl3uUc38uaW1nH4dBxayVKbEczjg6vFaaknOieu+Y94PvnMcQWKmo60YwcDRZ7gNp31LPGvGfURWwtrzKFLSnXh5zXDESSEXqubiOvbRZSQIGCXjyTT0ty4T1k7DBZqWiO5hFBzlMbQ4yNoEqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 08:12:15 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::f012:863a:2c62:9665]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::f012:863a:2c62:9665%8]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 08:12:15 +0000
Message-ID: <e5fbaf30-1f97-63de-a9a5-2ae5359120ff@amd.com>
Date:   Tue, 16 Aug 2022 13:42:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v14 04/10] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_DEFAULT_DAX_ADISTANCE
Content-Language: en-US
To:     huang ying <huang.ying.caritas@gmail.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
References: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
 <20220812055710.357820-5-aneesh.kumar@linux.ibm.com>
 <87wnbacjsh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <cd1c13ee-6fc3-bde8-96f9-8c3c93441275@linux.ibm.com>
 <CAC=cRTMZZ9bqyC7pnxD1zUWqfBiQ9U7im+8EYa_8GVK8iA7HXQ@mail.gmail.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <CAC=cRTMZZ9bqyC7pnxD1zUWqfBiQ9U7im+8EYa_8GVK8iA7HXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::23) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cda6ace9-c27a-4c42-4914-08da7f5f073e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJpWw3/60kF3a6AbqiOO+WaE5NrD43vCvIdnlgkXz4rrkpWZgCn1AXeTBK8+mXqPMZxfqeK0JZSVQmmYGAlpa3+3DZB36N81qHkMDm7eNNtI1xnV8pgRb4Uin+klvA3p2uuDJMRABKH1iGKvHH3Z2OEDbmvSWN0WQfWB88JVb6MQNbqnt8bQG51GA5sq6QXsJCfQHO2sk+eYZKTZ8sRPR5B45345wq18/EYZwKL9aO6QPfdNrrHJja1XQSmIyCu/b2qgNmcvSG50GnkTeM2P8kfHuPmpUHMs8UEUww/g6aljcDZvmUdChfBi9iQTTSVL3fCarWiSHpyUmBm7H+XAbxwpklBREJ9aSk+s4yquZwO5gtVkKm7HNQ1O6M5rxRFLA/hh1cALZbbq16xuCOEforTY+cXak4/8eU36cp8NCA1WU4jSwPzeYPw2PkXm96W7DyulsDokuSD/nwKq7g63kjReIteHY9cCSSkW6qjoKkgI6fcK9ApJZSwa0j8S83zYPAWUPaPSelYCi68PzUEAA7CNCNVR5CKmMOBXANW6KtMTbbeaMg95mnRwkjaKCSOoKMxNg7923doRVSanYN2hoaHKSawj/nvQsxGx7L0oGNTHZSSiDh0Oe309PksOuZG3cMPLhx9Sw/KOdxYHf+jOrYeudXDlXg/0D6fYm8enyrosZ9M0ryOvrXrgeCLIWyIbr3o4/awtgwQVkM/Sw3pT6gysfs7HwxM6zLEWbW+5mRxEhQVobTqSCMkDr3mR68PcftPkCH/3HUYp6H05ki6tv5u7ozsBkc7ZiSs7nU7+Yy2It2ZLYxhPiDFtwpQz6BVOCWKM+qcI7tNDOwga7n7h8XBS/hvGN2h3FH7m19spGtQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(83380400001)(186003)(2616005)(6486002)(478600001)(38100700002)(966005)(45080400002)(316002)(41300700001)(66556008)(6666004)(54906003)(5660300002)(7416002)(2906002)(66946007)(8936002)(26005)(31686004)(4326008)(110136005)(31696002)(53546011)(6512007)(8676002)(66476007)(36756003)(86362001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVBadmVBLzBTU0RUOGFGMDB4N1BkbjJIZ2xiSTdzRG5naUUxeWIvRnhjeGk2?=
 =?utf-8?B?QS9DMmI5cW1UTU5pWFUzSEZqRE9zMjJ1V2pmRHRra1JpTGNXS2N5ZnpJSXEr?=
 =?utf-8?B?VkR3bXp1eXVmeDZsbkhXdzR6ZmlNV01iL1U2V3pTMmJXMFVNSjk2RUtZaEF5?=
 =?utf-8?B?dUlrVDluNXBjN1JZaGxaQ21pQ1dxSERjV24rUXd4OXd2cU5ON3M3NTFuelhU?=
 =?utf-8?B?Z0pqb056WXY1MXNJajJhWm92Nk8xVkxsdFBzZXFBd2RzUHhURVpjNCtYNmVY?=
 =?utf-8?B?OXdSTkIzVVo0QzRHNGl3STNMeWpyTFltU2pkcVhvc3F0VzVVVGh6K2RYZmJj?=
 =?utf-8?B?cmJPMG9KU2ZGS1NJdUhZaTJNMjdKOEhNZ3Q4RUdFWkpCSWNiZG5Lb3cxZEp6?=
 =?utf-8?B?M3VrK3ZaQXpESTgvSGc5U1Q1eGlaWGRNUnUrWHZKZ1RaRENwbWhSMW1hNDVv?=
 =?utf-8?B?T3MyR3N3YjBaRHRrTEZxR2JwVkZ6T3AxR2ZJL1F1RkdHSEkvNU9ldkdIZnFa?=
 =?utf-8?B?cHRGQkFIcXJxOGJHN25GM21mOWk2RDg3YStpVFJEaHNkNk9hTUg1bTA1TUxL?=
 =?utf-8?B?WFpneDF1RGlWUG1reU1hMTR0ZlFrOFVtZmdtV3k0a1dXdkxZV1ZnVlViQW5q?=
 =?utf-8?B?cnIybi9QaEw1RU9Tb2pUelUzbHFLWDJsVE9zSXlEbTkwdmtldE9GaFMxeEdG?=
 =?utf-8?B?V0docUp1V3p3OWRzZmVoQ3pOTW1SM2hWZWpzc2IrVi9Kc0dqYmJCNUJ6cUND?=
 =?utf-8?B?MEhnVzlabURCVVg1Z0ducXQ2MFFNUjJtWjI2VlQzb0RWQ05zR3VYd01MMVNw?=
 =?utf-8?B?WHlPWDRibUJ3YnZmcWNVUStXM3B0TUZYNmttNHNlcmlsZzczNzZwOGpJZElO?=
 =?utf-8?B?MEt5eGszYSt5aEF3SmlpaFpIb2laYkZSK2FFRE5ZVTZySjhmZjdRMWEyY1Bx?=
 =?utf-8?B?amtrU2dqdkFZUWhnaC9DZjB1MDZ3eFUySXZkYUlOUVVhTEFvZHV1LzhRZWY0?=
 =?utf-8?B?STJnSTduNFRlMFVIS0hMeENoWjJWdURWYXAxNXV1QUovUUs1TjFHdWl6Vm9M?=
 =?utf-8?B?TDl6NGR1WFUzL0NaRTY4ZEdCKy8wTGNqNlRmK3U2WXF2cU9aNUxydVZVVk04?=
 =?utf-8?B?Yy9PNk13Rys5MUZFT2dSR0F6UUdFUFlvWER3T2I5SklseFMvb2tidHFMTTVu?=
 =?utf-8?B?dWxRNEpKL3lYU2RyZk1HZkNZNVZmZ0xZZTVLc0JQbXVsOUVLVE9JcVVac3Z0?=
 =?utf-8?B?bGVxU0JBNmh5SWIvcThNUm5hTk1HYlNKOGxwRTJNVUE2Y3QxQU96UVh4UmZj?=
 =?utf-8?B?V1Z3bURjeGVUMCtXejlvNjk2ZTRIVUUxaUQyQ2M2MDJQVDR5MzgwOHBnU21M?=
 =?utf-8?B?MFVseHZ2YVZsd0QvOXpoNDN0QVo3UkQ5MXBYYlNTc2YzWi92M1p5dXZDeFJF?=
 =?utf-8?B?dTk2MzdrbzVwKzJRK1RaOWpBT1k3MS9zZHpNQXR2QndmMm93STZVTnFWdTgv?=
 =?utf-8?B?YWtiS1MwWFNCUHFhY3llaFRydDlpWDZmWlptZG5EY1NSZXUxRHJ2amozQnNj?=
 =?utf-8?B?ZGR6Rk1JWThTVmlhbXFEMHg2UkdKVUVMSW9WWU1JaTBwN0svTEt5WjdyM25s?=
 =?utf-8?B?R1dyaDYzVEtQenFtWjAyZHMwc3JaVEI1cll0czlJV2paSHBvbHNIdjBwcFhR?=
 =?utf-8?B?MThudm1teDBxMk12RittRmlIYTFidFQyK0hBaml0SUhNUytTUHZraURGcWNq?=
 =?utf-8?B?QnBNNGlCT3JtWVpYdTBjVk4xeEUyb0NRa0RPaW9OL21wQ0p3Yi9pWTdHWmFB?=
 =?utf-8?B?UWpTUHNFRURDeXRwQkxYTGNNbHdSMzhUMXB0aUVZNkt5b1VoRWNjam9jTktp?=
 =?utf-8?B?YzV1N3BlS0s4K0k4ZEl2d0YwOHFzTFF1SXBFZ0RXelhya3R3aTZFTUJ1amxt?=
 =?utf-8?B?eXZyandwZytJQkZhWExxWlp4UERIQVN3NHNDZDRHSktPRVcyWk8zRlI4dmZs?=
 =?utf-8?B?MFZ0ZUE1ME41aUJnQXlkS1JYTjd0NFI1WDZRMGxFU3lNdEdJZ2JHaW1ycWdv?=
 =?utf-8?B?U0JhZkRpWjk1dWIyTkRaWFMrNkJ5eDh6SDM2KzI1WFNhb0IrREUxcjczMDF2?=
 =?utf-8?Q?dkrzrij3tMj6ODlBq2Thou5o8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda6ace9-c27a-4c42-4914-08da7f5f073e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 08:12:14.9769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAeJbWily9jXBhRxlDXF0ANRNm3NqDInRwt7dl3e2eaLYPp4KyxcuwbWYTXEFZbtIdBFCyGKoX24pCujalzKFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/2022 12:58 PM, huang ying wrote:
> On Tue, Aug 16, 2022 at 1:10 PM Aneesh Kumar K V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> On 8/15/22 8:09 AM, Huang, Ying wrote:
>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>
> 
> [snip]
> 
>>>>
>>>> +/*
>>>> + * Default abstract distance assigned to the NUMA node onlined
>>>> + * by DAX/kmem if the low level platform driver didn't initialize
>>>> + * one for this NUMA node.
>>>> + */
>>>> +#define MEMTIER_DEFAULT_DAX_ADISTANCE       (MEMTIER_ADISTANCE_DRAM * 2)
>>>
>>> If my understanding were correct, this is targeting Optane DCPMM for
>>> now.  The measured results in the following paper is,
>>>
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Farxiv.org%2Fpdf%2F2002.06018.pdf&amp;data=05%7C01%7Cbharata%40amd.com%7C1c5015b55ff849e5275408da7f58e67d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637962317187856589%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=SxSC8WaKEeTyfZXoqtI%2FZAoBXXp82PnTeyyavrV%2FGGg%3D&amp;reserved=0
>>>
>>> Section: 2.1 Read/Write Latencies
>>>
>>> "
>>> For read access, the latency of DCPMM was 400.1% higher than that of
>>> DRAM. For write access, it was 407.1% higher.
>>> "
>>>
>>> Section: 2.2 Read/Write Bandwidths
>>>
>>> "
>>> For read access, the throughput of DCPMM was 37.1% of DRAM. For write
>>> access, it was 7.8%
>>> "
>>>
>>> According to the above data, I think the MEMTIER_DEFAULT_DAX_ADISTANCE
>>> can be "5 * MEMTIER_ADISTANCE_DRAM".
>>>
>>
>> If we look at mapping every 100% increase in latency as a memory tier, we essentially
>> will have 4 memory tier here. Each memory tier is covering a range of abstract distance 128.
>> which makes a total adistance increase from MEMTIER_ADISTANCE_DRAM by 512. This puts
>> DEFAULT_DAX_DISTANCE at 1024 or  MEMTIER_ADISTANCE_DRAM * 2
> 
> If my understanding were correct, you are suggesting to use a kind of
> logarithmic mapping from latency to abstract distance?  That is,
> 
>   abstract_distance = log2(latency)
> 
> While I am suggesting to use a kind of linear mapping from latency to
> abstract distance.  That is,
> 
>   abstract_distance = C * latency
> 
> I think that linear mapping is easy to understand.
> 
> Are there some good reasons to use logarithmic mapping?

Also, what is the recommendation for using bandwidth measure which
may be available from HMAT for CXL memory? How is bandwidth going
to influence the abstract distance?

Regards,
Bharata.
