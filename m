Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B6753EA2B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiFFKPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiFFKOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:14:30 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EC11BF83C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFM9KNcDAxpXJUQYL9PEQJPYoEZssv38Dxj1wDMW+yFH9nWuqvY60QS7HmoaFj1rzFX4OdpwavXnhX2qBFLNGMJC1Gga/c/c99yw0AKloqSs8B1Tjx1/9D73YOGDWGgL4Fz+eH8q+gIHJ+wKq7V2zRbMOsFhQl4EHSjdKZKScoyy6ph6+cfxpeOBtlOEWNh62hnYapyMbhgmkNPjce4bl6U3ofOLzMEh7ztzS/9SR+zvOjpKFL4CuSAkcTq9GevQTQU8eK5JUIoLsf+8xjxGSiRsjaz1s8oQS28bQJoMjWyVOxlheIQKajtZZHxt1whuTXjlTfuAgcfqb0HxGfjEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPxjMOp086iP3D78r2qtKfBTPcMzcinrbv7/AhCMbNs=;
 b=hDx1/nKcXKAeXNiy8kt3Kl4kLjSYKl6BQURWaYWo5gJaA+4JRoyBtUI8tkumIMmf7u8Y156LW4II3WaO1M67/nPMfUs5Shpet0xqeDNtS020nKj8WT6qvRHURxe5jnRFAysI9rn9RUoyCnwqgYceJK/FTXhbkw0/cDBXJS9vzHagSvh7c9KuN+GsgxfXeU4F5ipBjNxC4u3h4CpBmrPfHi4Qwpawv27zDAKGauhPdioltbGjtzYl/K3rydLLK4zOmmpJF0I8nHQEYIijm2OZ2FjEHMKZXdCmQ2wj3miw0FvvcRDwE5s7zDcLis6J/AFHr4yKvQ1p4RO5vQpLcjH35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPxjMOp086iP3D78r2qtKfBTPcMzcinrbv7/AhCMbNs=;
 b=K4eITEIMy3VitO7O/OFCc42B4e31dmQ38INGNUMYOqzxXPZSRs7Jg6nKuyrqLiJYRJ9C6TTmtRlslaR4Ik7+PORM+7HGrZsqDe2TJiZfM4KnTKLIEak2AlobkjiOiHjw4C493bXE8jzfM2WtBdMN8C3fCrCqYUFLLfJ2Pv707KY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 10:12:04 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::d978:617e:55a3:cfd]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::d978:617e:55a3:cfd%5]) with mapi id 15.20.5314.015; Mon, 6 Jun 2022
 10:12:04 +0000
Message-ID: <d6c94fd5-053b-7e6f-dc4e-83184ecf131a@amd.com>
Date:   Mon, 6 Jun 2022 15:41:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH v4 4/7] mm/demotion/dax/kmem: Set node's memory tier
 to MEMORY_TIER_PMEM
Content-Language: en-US
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
 <20220527122528.129445-5-aneesh.kumar@linux.ibm.com>
 <5706f5e9-0609-98c9-a0cd-7d96336d73dd@amd.com>
 <8e651a1e-d189-3e8a-438f-298f21402bd2@linux.ibm.com>
 <d45374fa-6e51-36cb-9a2c-96f85d9de528@amd.com>
 <c98eb873-a5bb-edcc-743d-89cfffe52cd9@linux.ibm.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <c98eb873-a5bb-edcc-743d-89cfffe52cd9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::7) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1ed77ab-7bce-4d0d-eaaa-08da47a50149
X-MS-TrafficTypeDiagnostic: LV2PR12MB5871:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB587149791E88BEAB1857A539B0A29@LV2PR12MB5871.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQHO2bckH25jB9tPA5deJ61haHHbSgzpwzDAJOtb9QqcCfP0E8N36LSIEALUXI26O6SFSiZ+KmLYsOvpV2uppIrC2tBFRhXMlxjlbAfqITMr2Da4AgHVAs4nLzLXq+76JJNUQQjifseTaJR20vTC26Zxkwfy+I3BYh5sa5Pn3nN5NiEUePdTYVVMTlCXrmdrdZ90sYSaTLiRDN/gc4NgyEei+ykwoP0wH8nRUIFE4yIrSNncqSoSp7HZpJolWFmNm/l1jJALIdDWvFJdtgCl49XWn6SajzABMWHuUA1kC1R5i3eUlX/JUho/QbQmqHIWPFlngmDfTp4qNJgaG1epcmUnCDEovWWwBjhR9emdHaTEhOQHJmRry5y1w+37KXyWIJK5fI3CJRN1WPrW/oLYITCjLP15Qmhe4NykivRgqnl+pJKJgJ6Qo02H8tsBwH33ljrhiImiObi8XsxIPl0ewPYWqG4cmzReqJFMD1yM6vX1dhl1+YHPCQ50Mh0lfRW02MZdTqrACRo4W5LibG3xPC5ix7pnDi7X7wNu+rCg2mJNeVmOr9gqopqe+JevCaVCPc9tW26TVd+JNqUnv8aF3Z6PYq2AVU7FsJvtWTEPZAJOXoexZqXqIUWZYsmOBuswb12zeBTxy/iDAfZNitsbH4bxR0d8nIbk9tT5ONw4r88N6BqvmbDgAD9TMSCfjjNkKUz1rVXX7ibnzS/poV+0sS8VYzKGveixz0ktALGCosk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(31696002)(66476007)(66946007)(186003)(54906003)(6666004)(8936002)(8676002)(6486002)(7416002)(36756003)(2616005)(66556008)(5660300002)(4326008)(26005)(53546011)(31686004)(86362001)(2906002)(6506007)(38100700002)(6512007)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlErSHpldVBRWTZSZlZlTjQ0dy9PYW04bnlNcmtQL2NONGJNWUpaanpOV1Jt?=
 =?utf-8?B?T2ZNS0pXdTc1SlNmS3lVNjZzMFhXOEtRYlVFd2c0QmQwclZCaVh2Y1Y1aFNa?=
 =?utf-8?B?QjQ3MHJTcThEYksyRTA2cEdXSXBNd0R0SzNkenZuNlJIQWo4dnVUMFJvWFg2?=
 =?utf-8?B?MjVzbC9YUDNCaTViWVFwQVo5L2hBbkFpcGEyakZQLzRtZldTRXVFSDl6UC80?=
 =?utf-8?B?VFNScForQ2NxUnB3RTlSbjVFQ0hYVFNPaFRnczZ1WmZiZThmNml6K0c0bmpO?=
 =?utf-8?B?WG9KTzhmc084Z1hldUhLMDVRbXlUM1hTdGx6Vmd6NmszbG04blpYZVF5T2cy?=
 =?utf-8?B?M2RLM0I2Sjg0azAwZTd4QnQzaktNSklqWUpEUFdGOExraWZPUElMMHozV2Vm?=
 =?utf-8?B?TTQzUUlqcDlzWmpIV1ZDL0Uzc09wVWkzNXEzL011Y1o1STJZOCtjeDdnMmlY?=
 =?utf-8?B?YkRQWlVoSUp6YTJIQTZGRmhkalNnT2ZaNHp6U0U1QzJPbkNvRU4yY1orT3ky?=
 =?utf-8?B?NDB5WUJSZWV0NjQxRkFYVkRxT1ZnK3RhNzdxbGNtZVhtZDFBLzEzNTJVYmtP?=
 =?utf-8?B?ekNKUzF5aktoY0lqanhmVVQzT0RFdit0Q0djVEIzRy90dkNMZE8vdVVRZnc5?=
 =?utf-8?B?NWJndTRPVFR5aVRNT2VhL3hmWm9WTVUyaUg4VTJHTVQ5UWdqZ2VrWXJ2UXJB?=
 =?utf-8?B?TWwyZDlESGRrbjZBWlBiVEt5Y0ZYVGYwTmZmeVdoL21YOHNFdmQ3d0dzQWIw?=
 =?utf-8?B?MElKc29kWk5PYlNROVFiaDQ0U1lzUGVlNWN6YXA4OXRGUFFXWFZiNjdVVWo3?=
 =?utf-8?B?dW05VWhySmJ5SzVrazQ2S0dRTDhzbnIzT2lmOTJ4aUhXdGQvbTF5WHc2QlNp?=
 =?utf-8?B?WE1yWWw1ckgzTGwzSTBrYmo5cEphbTVkcjN3ZFJQSjEvSzFKUlhkSHhMcTlX?=
 =?utf-8?B?YnRncHAwblJVdkNYcFczbmp2OHRkMFBma2xUNnd0cTUxMUR2dmxDZ1VxeXJv?=
 =?utf-8?B?STR6U3JQMHJWQmNDNW11UHdkRnVFTSs3S1RTYzA4ZStrRjNqTFlTRkIrTnVF?=
 =?utf-8?B?dllTcHNkK0Y1NFZjdlJQRy8ySjlyVWRPakw4R1BObTQ5MkJ5RGsvNEVHY3hV?=
 =?utf-8?B?c01iSVZ1d1c0NkZYZVNVOGllSG9qVEVSQTFCSlErbEpQMHJuQXROTUVHTzBW?=
 =?utf-8?B?QWozd3ZrdTc3SURrc3NMUWs1SjY4ejZHYTAzSFJwUUxMWTNJV1JSTFlKb3pH?=
 =?utf-8?B?Tlk4bWxwL09oRnVDaHJzNndEN0VVSHZUYWtDWUg4ZHR6OW9oUDRXdS9VdVlr?=
 =?utf-8?B?WXZWbGNWL0xmaWRtSXdFYm1DaW10ZFJOQVFwU2x5OVBjcXQvTlpWVHFwTm5V?=
 =?utf-8?B?VnUvTzduOFNnSXpVbkV5QzlVRXpHWmRYcGhmQXFTb2x4VUNmUFlKSE1rdE5w?=
 =?utf-8?B?cHlmKzJkZCt6cFVvQUdCYW5FSnZ2eFFIOU1rMlJxeWVBN3FzYVJrYlFtUkZX?=
 =?utf-8?B?VWExeTE3MmltM3p4R1JKQjJRQWZ3MzZQNnZCcnkreFZRZC9tKzRDMlQ4amQ3?=
 =?utf-8?B?ckVaSjJlSkwzWXgvUXkzdFg0clR1NEJJTUw2RzdMZ21QdnI5dVU2S0ZqV2pv?=
 =?utf-8?B?b2tUaW9uODAzTlh1ZkpOWEZWdGRWWjNGQllGUG5mZEF6by9BZUtUTExhdDJ1?=
 =?utf-8?B?L1pHV29UMmdKM214YkFaT09GWXVOcUZSaWpkWE9TenY2L3lDNGhLYXBNNTNn?=
 =?utf-8?B?R3c0Z0F5Y3ZONFRUQzZnREpzakl6V2pMbkdSR2duWitLUkxVN1lDV1lPajUw?=
 =?utf-8?B?WjdRNFBjckN5NGZZbjV4TzhnK2RiNFQ1aklSZnlUU1p5cllKOUdxSW9STW1u?=
 =?utf-8?B?cXQwajZ0aUxJc2trWDg0RTdvQjZ6dVNRUlErTkNIcUxVdFdjeTJocnVYd2Fz?=
 =?utf-8?B?MnNaUjQ4ZUdUUXV3N0VmR3l5VStoZGtSbDBaQ25KaUdsbzgvT0lGb3I5RmNP?=
 =?utf-8?B?VDVBK0FJaS9PVGVxYXQxa0dnNUZxMHpwMzFHd1lnK1Bjc1RYeTNUY3ZpRGN2?=
 =?utf-8?B?bzJVSkJ4QzNwVE1DSGtoY21lVWVxZWI0NDhoMkV0TTJCMVAwRnBieE0xQllq?=
 =?utf-8?B?d3FTTHBjdTdWSUR0MGJ2Vmc1dWp4bHdVSC9Mbng2VC9jb2w0WTgyZU1iTDZk?=
 =?utf-8?B?L0RLcWlPQVY2eFBaRVNsU1YxOFV6V1g0NWI2WUhWaEdFdGE0aHUwY0RnNDR1?=
 =?utf-8?B?eXpCOVZ5eVhqczB3MmVkeU5hdG1OS2R1ZnFPK2VGbllwbmJDNTV5RWdGZ0pN?=
 =?utf-8?B?WUJmcy92QXBSWnhzNjB3SytjNWxtd1RlRHBMaDZQS3RENFFUOEhGZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ed77ab-7bce-4d0d-eaaa-08da47a50149
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 10:12:04.6125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnGVJdRWL3MjSg5bSHdTmYkJCj9OFutmDNY2xquHOXBvP5WvpOC47PLFzQX2b/PBkCzNuXSns2kLryBHJdHJOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/2022 2:34 PM, Aneesh Kumar K V wrote:
> On 6/2/22 12:06 PM, Bharata B Rao wrote:
>> On 6/1/2022 7:19 PM, Aneesh Kumar K V wrote:
>>> On 6/1/22 11:59 AM, Bharata B Rao wrote:
>>>> I was experimenting with this patchset and found this behaviour.
>>>> Here's what I did:
>>>>
>>>> Boot a KVM guest with vNVDIMM device which ends up with device_dax
>>>> driver by default.
>>>>
>>>> Use it as RAM by binding it to dax kmem driver. It now appears as
>>>> RAM with a new NUMA node that is put to memtier1 (the existing tier
>>>> where DRAM already exists)
>>>>
>>>
>>> That should have placed it in memtier2.
>>>
>>>> I can move it to memtier2 (MEMORY_RANK_PMEM) manually, but isn't
>>>> that expected to happen automatically when a node with dax kmem
>>>> device comes up?
>>>>
>>>
>>> This can happen if we have added the same NUMA node to memtier1 before dax kmem driver initialized the pmem memory. Can you check before the above node_set_memory_tier_rank() whether the specific NUMA node is already part of any memory tier?
>>
>> When we reach node_set_memory_tier_rank(), node1 (that has the pmem device)
>> is already part of memtier1 whose nodelist shows 0-1.
>>
> 
> can you find out which code path added node1 to memtier1?

 node_set_memory_tier_rank+0x63/0x80 
 migrate_on_reclaim_callback+0x40/0x4d 
 blocking_notifier_call_chain+0x68/0x90 
 memory_notify+0x1b/0x20 
 online_pages+0x257/0x2f0 
 memory_subsys_online+0x99/0x150 
 device_online+0x65/0x90 
 online_memory_block+0x1b/0x20 
 walk_memory_blocks+0x85/0xc0 
 ? generic_online_page+0x40/0x40 
 add_memory_resource+0x1fa/0x2d0 
 add_memory_driver_managed+0x80/0xc0 
 dev_dax_kmem_probe+0x1af/0x250 
 dax_bus_probe+0x6e/0xa0

After this the explicit call to node_set_memory_tier_rank(numa_node, MEMORY_RANK_PMEM)
from dev_dax_kmem_probe() finds that the memtier is already set.

> Do you have regular memory also appearing on node1?

No, regular memory is on Node0.

Regards,
Bharata.
