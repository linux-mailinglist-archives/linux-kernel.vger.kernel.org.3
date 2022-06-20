Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7F155173B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbiFTLU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241459AbiFTLUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:20:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D3913D1E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/yeGL97IH5mghC44FhIHde79kJChcwJ/pombCzU/dTkdJRCe2wW/g9v2YWyBJ8NbmmuN0+kyoy6UvejiYgShAbonq7hE5xXmvoqHaWZeSPdITOSjmuDQYq890YXeq9Li14+BmUpmdhXL3EyfI2dBTbZyGBR79kDi5EIY/1wJCs+9UIi51P/li2HOGRs+tDEJr+9X/cAb9tgtoyfsugP8Tv/JGk0+hRNC5i5krSIeU6zAMvgdvlazrnEi2bJ93YNEdghh4iMWm7mHZV/R7eH9UdG8ucki6+H51VKjoVu9rfQ8p1BlCSEH9+dB9q7K4yRkOqwTeJgEq4Zs2G6qeGikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3qTbBmGd25vFbPl4FzqL4nlm+BPkFjkfrJRk48F+Po=;
 b=mlyOZvSU/4ZYR9cU6+uXYpua4KOtvNy6ir9I1QbqywFSxwCoHCedcV783OF7sqMYkz03Mw96pdiLbFQ0xbfaIQLCBZY/nTWmvrhgo+yc3K3bfc23foP/mqq7KO9jhRZ8WqexLTPibo6nDeaqK5EuIbdbHU3QEgW0ZfngxUOivp08OfGUfy+wWKL4QFk8Ii5DBRSxxnBOjXhwgCPP36u4dUc1oJp8EqKl6wpQUeUhoXTYrfZKx3VjHnBxpLjaHP7GFVhwYoVBRLeYEcngOugB8vY38BxSN33LLtfx4K5H2630ioKbu+um6CF2PWZB9SWGIK6YSTEmZDZEJS4hJUYl8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3qTbBmGd25vFbPl4FzqL4nlm+BPkFjkfrJRk48F+Po=;
 b=k4roBc3oiAALeihExGOt5TFEHWdTBukieKHnicmsADPwQSHD5LxK3vXb9TNPtDT0qrojLvp0boVflGMWKdV0Qz1Q8/0dLNQL14xQbu0WFZJdtB+2xEkPccso7qfikmQoWF7IYTSeKn+ysNmAXeYlgKUUtVingwGOKJvetDICT1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CY4PR12MB1381.namprd12.prod.outlook.com (2603:10b6:903:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Mon, 20 Jun
 2022 11:20:20 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d22:1b6d:6231:e435]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d22:1b6d:6231:e435%7]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 11:20:20 +0000
Message-ID: <5638aed5-bbd0-a74e-759f-0de51e3651f7@amd.com>
Date:   Mon, 20 Jun 2022 16:50:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_resources API
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>,
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
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <b87ddfd7a8dd418edfcdbad22a4fc1e9ef03109a.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::23) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dbc7f27-b4ca-46d1-9217-08da52aedbe7
X-MS-TrafficTypeDiagnostic: CY4PR12MB1381:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1381E3DF19F4A216CD75C17E98B09@CY4PR12MB1381.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDaFJeM34m3npkFqVnTx93kDZT2yyGyCA+ZZCb+flV2A5Gc+okww8P24BW7nQYaXtaZocW/GI/115ZbPq9NRaPLQqhZlcpLHQDZ7SEZNoyipDpm3ykXTYXrh9L02FUm043z3Sw5kNG6STJiVcNkI7HZJrGYw4x60bazp87nQySo3POTXL7+YJVEpxza8tEeFpcW87lUCs4RmyeRwmxWt8u6vApLQN8gU24ik1WVM1g+G4Fv+pE8i0/Lno9OkPoSrQLp1MwGRERoyL0a3jE/zag0fXi8b3mN14xsjlo1DPkqCwQr6fZXNbw6AI18SCCamPXWW9qV54gZw7zxTWuFkhoklVMr2Bi6UEY10bWDRU1TYhhSoI/uY8hhTrMv7o8CI5PSwOyyvg0l/cvJ0ndCv6Yi78vMKl8knF7TviV3cVjNH8hqWUuJoFzFWxo81ydu2H7BYRjqekzQ6H+gUh0G7QoPKYyvA5FrWboraeWKZ1DP2OKjIWSYBI5unO4nHiTYABpxpRSMw1X6q3hPeWfzTt1EyWDQG1N6CW8MUVDWpulqgLxa7o3s4vIKTu3h/UtHbqjo9eTRxnwEFOMwUeNppcMb1F80WULtMHQA28U9e7ldBnXXVRWaX0LIXRTYbvECgiEKMUTIX/9WKR0U8dfUEsDTDPFkp6cQIIM5xL025BE0a+JwkUL8eYkup7jRQVFk7FChwjecYfBuCiMjBM1hWDwUENSSnHFAJ7BPW0ZEGlXFV682vtxELrd3OF4h5mCcO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(6506007)(6512007)(26005)(53546011)(186003)(2906002)(41300700001)(31686004)(6666004)(36756003)(6486002)(478600001)(110136005)(8676002)(921005)(38100700002)(7416002)(316002)(5660300002)(8936002)(66476007)(66946007)(66556008)(4326008)(31696002)(83380400001)(86362001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OThvNDRpUUxleWxhV0phS1dhY1I4TW1DWHR4eTJoeHVINjR5N3liaHV1MHVI?=
 =?utf-8?B?ZVZSQnVGSHplS3hUWTIrNkxkL1FBUmtVUTAvcDRhOVJZVDlWdC82SWtzSG9X?=
 =?utf-8?B?VVVOMnJNNmhCQXdtUEdmUEVHTDU1NVBXY216eHlsaFVPM2tJZEF3S3RDUzZB?=
 =?utf-8?B?RUN4cFFRMkpvNzJ1UlN1Qm5Xdzl5T2hzS2xjbkJHODdhelkxRmlLUVV0RzhL?=
 =?utf-8?B?UzJCQnZXQmVadG5admxSRlpHUU04SkxyYjMrWGRPbnBxYWtMS2NzZ09MWUw2?=
 =?utf-8?B?WFhPcm1vK1Z6bVlkKy94MTRnSnRWM05yeG4wWTBmZEFnbll2ZkpWRHVGT0h4?=
 =?utf-8?B?eTVPVm5PclFqeTN2V2xnK2daOGgzdDJtcEEvR2c2aFcvc0JiOWNtSXBqMWR4?=
 =?utf-8?B?N2xodndPb0NRdFhXUkhFZGsvQ3BxNUF0dGM3VnhVRmE4RklJakpGMWcvOGQ1?=
 =?utf-8?B?dnAxbmU3M3BQOWMwclZPRXV2cWFnN0Z3UGRnS2JqRU1PL0RsUDVnaDhXaGo5?=
 =?utf-8?B?QjVrWlVKcjh1WkNTUk81dDNwL0RiVDN1YUhnUnBvdGo5VllUbG1QTE1aaCtW?=
 =?utf-8?B?d0Jrc2VaVWpuUGpNSjl5Z21oMVBvOFVRV2JhL3NKcHNnL1NyZk5IVHBtRjlH?=
 =?utf-8?B?aHlyM3pUTGJVRmE3Y3RXS3A2QWVKS21OYXUvenIvWHY4QmQ1TFVZc2wyb2cy?=
 =?utf-8?B?ZGhiUHdxVko4VjE5blcwcnpzdjZQYWk0WmhoVE9mUFY4eGhlOHlXNFFLOFN0?=
 =?utf-8?B?UTB0RHpsdUZVdUV1WWJTdE0vMTFIdXZvaCt1VksvL3JhRDl4YlYvRGpBZGli?=
 =?utf-8?B?VzF5T1ZMSHRLUUtheTAvM0ZLNVJZQVFHSzB2VmFrQksrK0hZcnB4SE41c1Z6?=
 =?utf-8?B?NHNCbWlCWnFjS3VPZFZucXBHUFo0amh4Y1NDRHdueGhDVE9rYVg4RlZhVnJ0?=
 =?utf-8?B?ejcrZ2EvZStLMU9QSGJZSlREU0hjQ20vODhLYUpNRytVU2JHQWJjNVpDZ2lL?=
 =?utf-8?B?dWtsdHRHbG5LNkhqRkN1ZDFPaHYvdVErMU5EL1NLVG5xMlEwajhybUEySTVj?=
 =?utf-8?B?UDlpU1UrTTE0Ym85enloSVJRd2lUVE9YKy9UQXBtU083cm02Ny9vcEFqTG9S?=
 =?utf-8?B?aDZTT3Y0b1lvNEVleFlYSDdWdkRYd1hpVEgzTWxsaFg0NHE0S3dNSE1oeG5B?=
 =?utf-8?B?aGRhMVZ1L3U2Z3hDZ0RlcjFOMEQrSXVUQW15M3pQT0hHeEFkZGlVaHQ1MVE5?=
 =?utf-8?B?Q3BuOHgvamJGRnAxK2pvSHpYZWQ4M1RqeXM3WVJsOFRKN0xRcU9HZ0pza0Jv?=
 =?utf-8?B?WjdmeWExUU5YbWxLcVM2QkoyVDd2RDZvNXFPUnVyZUJrVW00cG5jdkJzdWV4?=
 =?utf-8?B?QlhxSkw5NFMxaWVQSjYrbE50ZUQzc0wvcG5YUWh0S2JiSWx0TTJsazFZMllY?=
 =?utf-8?B?bVFNUThOSForRWNtaWVZaWVzZEpuVzY1d0dtenV1VmVvYkxlQ2Nsa3FZZlhQ?=
 =?utf-8?B?ak5PUXE3SzdPTExFbGJWZ0VNb0ZPaHF1R1E0eTBYS2N1VWJpWU44cEo3Qm56?=
 =?utf-8?B?akR5eThmbEo4NmR1K2p4Y3FnUkwvajJNaUo2N3NEaENNcFpmSDlLT3hiZmRK?=
 =?utf-8?B?MnphVW96VnNCc0MxcHplcTAzdW1pWTU3NGRXZ0dWcjVXMGJwZjJvUytmYWVJ?=
 =?utf-8?B?VDBRckhtamNrWW0zRjl4QVVIWkNXNW95QUFuNVA2bjRlMTBCdW5ZSXkweHMx?=
 =?utf-8?B?amh6Qnk5TzI2ZGdXM0RCU2Y5dSt4bVlsbHZvUTVEWVBnRFg3QkhuQTdrRFVq?=
 =?utf-8?B?WExGckt2WkV1MkJhV1BrRXNmNGc5bVUwTmRTR2N1VDZJYkNoVDdwVjhxU2Vk?=
 =?utf-8?B?c21vVkh4aDBIbE9IUHlEMllON3FzMUJJZGFZN2JYc1o0SU9jejdvL1c5VU5r?=
 =?utf-8?B?R2tnbDl5bERkd2hmN3QrS2hOdEVHZWZuT01ES3RNQ2xrU1FJSityZjdYZlNo?=
 =?utf-8?B?WlQ4ck5zL05CZ3RHMC8vY2M4MG1yUzVidVhjQkI1NVA4V3VDaFpjbVBMak51?=
 =?utf-8?B?TkgwUnVDMHk4V0dZWk5LL3F4N2NvdHRIeDRNS3pEQjBHQytFdmlWbXpraFBM?=
 =?utf-8?B?cWZKRk81b3ZQTnBtQ2RLcTBhRjZCV2tmVmFJYjNkUnBMaElUNDMwL2JWUFlz?=
 =?utf-8?B?TGxuSTBJVzVOREdybmpKdEZlUjNNMExmNkYxSWhzOHF2Z1d3NDBUWUF5a0hu?=
 =?utf-8?B?OWNsSDdLWTRXbnF4MEtsVk9jMzNCWGZWQmlkQS9hdmFEaXBHelpITkg0VFAx?=
 =?utf-8?B?dDRMQ0trTlhlM04xUlE0V2JaZUcxNkRiSkZ5azFidjdsSmk0ejhxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbc7f27-b4ca-46d1-9217-08da52aedbe7
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 11:20:19.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abG0NPfjgiS6W+/XUQWHge4JT5ZT8OcclzKu0KF8MOXbfb7ReO0PUGC7aGUk/1FeBBpkgKaoxFj+/OhgR9LgvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1381
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tim,

Thank you for looking into this.

On 6/17/2022 10:20 PM, Tim Chen wrote:
> On Fri, 2022-06-17 at 17:50 +0530, K Prateek Nayak wrote:
>>
>>
>> --
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index e9f3dc6dcbf4..97a3895416ab 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1750,12 +1750,12 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
>>  	return sd;
>>  }
>>  
>> +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>> +DECLARE_PER_CPU(int, sd_share_id);
>>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>>  DECLARE_PER_CPU(int, sd_llc_size);
>>  DECLARE_PER_CPU(int, sd_llc_id);
>> -DECLARE_PER_CPU(int, sd_share_id);
>>  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>> -DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>> --
>>
>> The System-map of each kernel is as follows:
>>
>> - On "tip"
>>
>> 0000000000020518 D sd_asym_cpucapacity
>> 0000000000020520 D sd_asym_packing
>> 0000000000020528 D sd_numa
>> 0000000000020530 D sd_llc_shared
>> 0000000000020538 D sd_llc_id
>> 000000000002053c D sd_llc_size
>> -------------------------------------------- 64B Cacheline Boundary
>> 0000000000020540 D sd_llc
>>
>> - On "tip + Patch 1 only" and "tip + both patches"
>>
>> 0000000000020518 D sd_asym_cpucapacity
>> 0000000000020520 D sd_asym_packing
>> 0000000000020528 D sd_numa
>> 0000000000020530 D sd_cluster     <-----
>> 0000000000020538 D sd_llc_shared
>> -------------------------------------------- 64B Cacheline Boundary
>> 0000000000020540 D sd_share_id    <-----
>> 0000000000020544 D sd_llc_id
>> 0000000000020548 D sd_llc_size
>> 0000000000020550 D sd_llc
>>
>>
>> - On "tip + both patches (Move declaration to top)"
>>
>> 0000000000020518 D sd_asym_cpucapacity
>> 0000000000020520 D sd_asym_packing
>> 0000000000020528 D sd_numa
>> 0000000000020530 D sd_llc_shared
>> 0000000000020538 D sd_llc_id
>> 000000000002053c D sd_llc_size
>> -------------------------------------------- 64B Cacheline Boundary
>> 0000000000020540 D sd_llc
> 
> Wonder if it will help to try keep sd_llc and sd_llc_size into the same
> cache line.  They are both used in the wake up path.

We are still evaluating keeping which set of variables on the same
cache line will provide the best results.

I would have expected the two kernel variants - "tip" and the
"tip + both patches (Move declaration to top)" - to give similar results
as their System map for all the old variables remain the same and the
addition of "sd_share_id" and "sd_cluster: fit in the gap after "sd_llc".
However, now we see a regression for higher number of client.

This probably hints that access to "sd_cluster" variable in Patch 2 and
bringing in the extra cache line could be responsible for the regression
we see with "tip + both patches (Move declaration to top)"

>
> 
>> 0000000000020548 D sd_share_id    <-----
>> 0000000000020550 D sd_cluster     <-----
>>
>>> Or change the layout a bit to see if there's any difference,
>>> like:
>>>
>>>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>>>  DEFINE_PER_CPU(int, sd_llc_size);
>>>  DEFINE_PER_CPU(int, sd_llc_id);
>>>  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>>> +DEFINE_PER_CPU(int, sd_share_id);
>>> +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>>>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>>>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>>>
>>> I need to further look into it and have some tests on a SMT machine. Would you mind to share
>>> the kernel config as well? I'd like to compare the config as well.
>>
>> I've attached the kernel config used to build the test kernel
>> to this mail.
>>
>>> Thanks,
>>> Yicong
>>
>> We are trying to debug the issue using perf and find an optimal
>> arrangement of the per cpu declarations to get the relevant data
>> used in the wakeup path on the same 64B cache line.
> 
> A check of perf c2c profile difference between tip and the move new declarations to
> the top case could be useful.  It may give some additional clues of possibel 
> false sharing issues.

Thank you for the suggestion. We are currently looking at perf counter
data to see how the cache efficiency has changed between the two kernels.
We suspect that the need for the data in the other cache line too in the
wakeup path is resulting in higher cache misses in the levels closer to
the core.

I don't think it is a false sharing problem as these per CPU data are
set when the system first boots up and will only be change again during
a CPU hotplug operation. However, it might be beneficial to see the c2c
profile if perf counters don't indicate anything out of the ordinary.

> 
> Tim
> 
>>
>> We'll keep you posted of out finding. Let me know if you need
>> anything else in the meantime.
>> --
>> Thanks and Regards,
>> Prateek
> 
--
Thanks and Regards,
Prateek
