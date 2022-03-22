Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A874E3ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiCVIjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiCVIjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:39:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6F648897;
        Tue, 22 Mar 2022 01:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBEGf09LT4Kj9YSRWJ+5oC+kFyGPmkbDIa5IU7NDjKfJ8K6/2bhlHnIPqJJYM4Yho4CiErLSgQ0io8pPtdxgtU6i/eKz7J9X3V8hDGRNfeRu/PQVgtGER79sKRuvua5V/Hb+ivPiM17iXy+h5O/63upHpYeWGpmsNwgmismSjg60SkHHG0XCQe26Jq2asogpUzzVL82Y6bMbn6pEjAL42Af8btteReMzMmQH1e+CA7ZHCJOlv/AnOFrtXzaBkDqLSNDktX2P5JJF+Tb8y5TQolWfBp3HNLlfhSiubBe2WvX6lxfc9FuAu8iqe+6U8/RwRfZXXCPu+lA2l4sOWYvXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5G6cTgJbtS8mCqiPNUsBvC2K45rlNQ95e92gyEQjhE=;
 b=bVTivSIBSr15QgMVT6WnzRTL/1Q2VczrTpHXQwWISluXuOwEklXNhsZn61OYG9Bir+oTSw+G3CVEPHvEozNGbsFJWHNnuaYylHXtPMrlfhXiQ+rDCVkuw2GEi/Pz9Y7Kei4PDiOm0SsJQCawLOqT2C0QEhOg+qoFdvN19Rty2VGocyut9yRXfDpZocdAyegaXnxHLaI6+gS8bHRkPhR3Audc0SirVghbUCooLiBre9hgT8OBEccC2vnRMp71B62O1pMxqBYwWkqCiRTNSqybqTBA+7lYF9NGu8VTJwYsNHPTByKQYLJZ6ianxQTpHgP2BvRz5W3S53cAhldCUvHzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5G6cTgJbtS8mCqiPNUsBvC2K45rlNQ95e92gyEQjhE=;
 b=CFTU8u4qTWtHvguh32pxbOB1yGPXPa+tvy0yNOVLRgN9jRyUy5IkPbDlcPMJvd5/C0xYcJhbzyfmXIQ5U2zcR8t3Xa1nYrGELIgHxGq52JkDkIoTufTNWfnO+tTD699DWWA/wBA0PjnWUgkEl/wHUYoJpWMwOL/6+i8lpN19OTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0178.namprd12.prod.outlook.com
 (2603:10b6:405:55::20) by MN2PR12MB4239.namprd12.prod.outlook.com
 (2603:10b6:208:1d2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Tue, 22 Mar
 2022 08:38:18 +0000
Received: from BN6PR1201MB0178.namprd12.prod.outlook.com
 ([fe80::944e:aab8:facf:fd8]) by BN6PR1201MB0178.namprd12.prod.outlook.com
 ([fe80::944e:aab8:facf:fd8%8]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 08:38:17 +0000
Message-ID: <7de451b4-32ff-c8b5-7c69-6440f73b59ae@amd.com>
Date:   Tue, 22 Mar 2022 14:07:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 6/7] perf/x86/amd/core: Add PerfMonV2 overflow handling
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, eranian@google.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org
References: <cover.1647498015.git.sandipan.das@amd.com>
 <7d43b4ba8a7c3c0833495f3fabfcfc6df8db3732.1647498015.git.sandipan.das@amd.com>
 <4bc9b537-f0de-5b75-5418-61c1d6dca849@gmail.com>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <4bc9b537-f0de-5b75-5418-61c1d6dca849@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::34) To BN6PR1201MB0178.namprd12.prod.outlook.com
 (2603:10b6:405:55::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24b7cce6-a1e1-4571-482a-08da0bdf4f89
X-MS-TrafficTypeDiagnostic: MN2PR12MB4239:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB423966CA115D4058AB63A6518B179@MN2PR12MB4239.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k6Bu5NTIkOfuS69zETSfAzha6J+z0njOjV9y11gtqhO4gbI3NxI02L8HNHy6P9+s6Nb+u5k2CKL2pMIWxc3CYg8BubGa6gglnqpUEFIQsNm3enEdhEQojflfw7hWYyifF53HUAjTCP43729oFcOivk7JIztE6MEDwoEbgR7mlBaJsbVXBGmGxGusYfcIeavhX8iO3rem5CxzFRw1GoT1KgWoJSvJ4/+nWInptpTVRf6pvw5Q0bg6aCyB0bpcCMOfajqIw93miKpUoWVuIjwi0vogCriQ+Uu7D/w6IULCt9rlkpoaT90jSY9RUq1dhOlswFC0sVFSGIDVudDmvQaK1eL0fYBLppEdwllyVdmO+8VwxeDdE3y5AQqntBZd8c1lEUxw46bMNJTo2Fc0JFdTxNvm7pOzpeEaxO7U8d5hXUshLLJ+3gZWHHZEpVde2e0f1nozcQfc1WbdAv7Q2ygd3bhbFKF5rEs/Qca7Btmso4CuCHe6rlK/X4f5iLETdJ6oYKWDnQivUwSt6RVBAE5lQVFg0iT8vC36Avbf+1DDzhE50XOeW6Vvd7T2RuEsyoEGevwbTMLXbI/d6HF6Y7LLSU3vjCW2G/MHE2KF6psyiUuZ4y2wz95cj+WDCb5Bnicp0e5V0aRpdFO2fKDtrTQ/+hediQU4vbV8SMKFBwnc6fJbGgqYplvtBKFVIQyFP2Se/MTruzyU1WekK8eSmks58gBkGro14u7Xhpd31oNzOnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB0178.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(186003)(6916009)(26005)(31686004)(6512007)(6486002)(2616005)(36756003)(66946007)(66556008)(66476007)(8676002)(4326008)(508600001)(53546011)(31696002)(86362001)(5660300002)(6666004)(7416002)(44832011)(4744005)(8936002)(83380400001)(316002)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekxOL3o0Lyt3c2Z3cWttYkpibmFWTTBCaFN4Y2VBY041Z2FyTzZCWmhyc2NK?=
 =?utf-8?B?eEdCWStoeDBuaWdwNkQweGV6N0Z5Q0VOM1QzMlE3STVweG9lR3RyeWNEb3Fx?=
 =?utf-8?B?ZnczRFhUeGprNExJaHRaM2dibUVuaFJLWGZJamV5QTR2U2MzMGExVm03UllO?=
 =?utf-8?B?RUlicDBrcFlaeGc0dWc2MnROenhWV3BhbFU2c1RsNEFKWjZIT3dvQ3ZnYXBV?=
 =?utf-8?B?aEJpMWlGdHhNZTlhUVdxK0JadlpUY1ZsNkxRcXBlajNIaDgyUkJJSWFiNnVw?=
 =?utf-8?B?Nzd1NmRiaTY3UGkwa3VVdVZMYVUzekhKazIxQmdxWGtoSzhQUmp3N3g0VDNK?=
 =?utf-8?B?emdDY0ZmU2xlelNYZUZibWtUS2IxZkx6UjltMmovZFp3elJaUGpmT1U0RFoz?=
 =?utf-8?B?Y2YydWpYUk5raFJvQkI5Rzh5YzgzT25IRFRNZ2lQUWVrWGNDM3JUSTJRN0tS?=
 =?utf-8?B?a1FiQlRQZkdHTWdaTWtLMHBXSnBHenJ6OEcvaVhrdUtNTlpoR01pTC9qNHIy?=
 =?utf-8?B?SFBRTmM0ZGRXSEpuUFZqajFNTUZTYlA2eitXQlhCaWxrQTJkaFNmUFNPN3Z2?=
 =?utf-8?B?bVVodjBYU216QkdUaHVXc0kwdWNPL3dMWEtyWjdydTZoZGhuTG9MQUQvakx4?=
 =?utf-8?B?c0UvRkY3N2pLUXhLeUxEVFBXWWJYb1BYckpxQlMrL0hJdXNxRE9ZMGM3VkhI?=
 =?utf-8?B?LzFkN1ZORkJLdjZ3c0RoYllTdXh4TVlucHZzK2lyclVvc1lSejRSellLWlVD?=
 =?utf-8?B?QTNkanJYQVdEb0swYXIwTVNkWWFKMTVXKzRYODhBRzZiQS9kT2R1YjkwbE5O?=
 =?utf-8?B?WElScklpcHhxanUrOXV6OVJwMU5NbFQ5Q0dNcGZCRHFsQkdTYzArYU1xdjlL?=
 =?utf-8?B?OUFtME1wbzJDamJicHFqeEc0SUhLYTc1SnRjd3NsQWo3Ny85YXMyWHBuTGlt?=
 =?utf-8?B?cUZsK3dTU2M0VUtpL1d4RWlTejFIOGRvWW91L0taa2FvSUJUWFFwY29UbHV4?=
 =?utf-8?B?UXhmWG5zWUtnNnRndVVEWVpWSFJMdUNmeFMrM2Q3eGhLZ0I1bzQ5RHZJcVUz?=
 =?utf-8?B?dHFYVmlFMTRkay9xelZkSXExWUpiQXBsL0cyaGxrM084NVJWeEEzK0Y3cm13?=
 =?utf-8?B?ZUZxUmxwVUNoeTFaQkRpS01PTTNjdXpFY00xTi95VFJGcFpwM0NMU3BVSGdh?=
 =?utf-8?B?RzBSQitkQk80VmpHZVRhUUt3bmxLTjhlQTFGdHIvTTR6QzV3am5hVGtqWnB2?=
 =?utf-8?B?b0hpZ2tWTUcrM3BPYjBiTTdhOW91ZVBkTmd6OHZmenBrY25mVnRMNm92dENr?=
 =?utf-8?B?WnVrV0NmNlJvK3czWCtGL1ZQd242MVN3UjZsbzlhS3gxTnROWnZWRzVoWWJH?=
 =?utf-8?B?aWhxT2I2dUV4Q1dGUndjUnBsQVRzNGxOaHNsN2JzUDJ6VEZGSW9WYUQ4ZWFY?=
 =?utf-8?B?SWM0MFd0Qm5oL3labld1QWg5aHZDcE1Dek1EOHBxWFFsSVlyQUQ2d1c4RW5I?=
 =?utf-8?B?aHJpMWY5ZkluT05QZWx5b3FNSzN2UHIwY3ZpYlpQMTZGMWtuV1BVV2M0YUJS?=
 =?utf-8?B?K3VCNEMrWFVpd1lUNjFHVUcxQXNLUUxYK0hxa29pcVRoZ2FEdytOdDNuMmIr?=
 =?utf-8?B?WXVLcyt1d3BXSm5XVkQ3VDJLVTVFVUI3MlZKWGNUcjdoM3IyLzJrWFRwMldk?=
 =?utf-8?B?NXlWSE80UG1Bby8wa0Zad0dIZ256RVg2dmtSRE91aWVaTlFIK1kxc3JDMzJJ?=
 =?utf-8?B?MkZqbHRlbTNXQkpWN2dndGRpUkNIUjBMZzRSTXRqbHl3ZjlUbUJrT1lTV2Jr?=
 =?utf-8?B?ejRHK1l1WVJqNG9OUHc5ZXlQc2NHRklSRHgxenFmUUZURmpta3JHNXZoV3hi?=
 =?utf-8?B?bWRjVXZSVGNYeEhlalpSOHI2eTBJcDRYM3ZiUHI4VlR3V1pyT0Q4N2ZKVUJi?=
 =?utf-8?Q?Hyoi2PExVqa04nI/Wxy1kmADd/NviOsG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b7cce6-a1e1-4571-482a-08da0bdf4f89
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0178.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 08:38:17.0261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjgwvHVpz4LEeiHd4c15Sb4zLWvUMAzXm4jnVg7JA3HdslFer7uifJifLH59BJwOTuDyRhEV8B8cD9Y+PfONCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/22/2022 12:36 PM, Like Xu wrote:
> On 17/3/2022 2:28 pm, Sandipan Das wrote:
>> +        val = x86_perf_event_update(event);
> 
> The variable 'val' set but not used.
> 
>> +        mask = BIT_ULL(idx);
>> +
>> +        if (!(status & mask))
> 
> Needed here ?
> 

If you are referring to this previous usage of 'val' within
x86_pmu_handle_irq():

  if (val & (1ULL << (x86_pmu.cntval_bits - 1)))

then, no. Instead of looking at bit 47 of the raw counter value,
one can look at the overflow bits of the global status register
to determine if a counter overflow has occurred.

Will remove 'val' as you suggested since it is no longer needed
for any decision making.
