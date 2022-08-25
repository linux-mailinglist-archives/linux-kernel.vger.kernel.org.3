Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE595A1C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiHYWnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243936AbiHYWm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:42:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B77C4825;
        Thu, 25 Aug 2022 15:42:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDKE9lwb9pG0RzKtQIq4SmlHB7wWetVndNez/v6xx/zLorerJhZ/l5bspAAsyQu+IDo9q653RhCtWxNX25LKtgnfA662MyGl+HarK3iIaUQDrKlk3j9lJ95R5Q3tt8i+4ryoD5AmhcVW9fAphqGwXBqAPkhz9uF0cVxWDseJiiOL7NmjLk0N+6DCPa5jzrM7lwR7d/YXnXoyJtzJ7kExwn1VLWhKsizxBBYXW9H/5B8jhRzqXqdane3+oHOSsUpzbQxXajrtShldRuUgelitO1e+mG3+2GWCYfhoHni+48lRQimwswMkL5baPymfmQH4c9cJfAIDV+hBCLcUDfF1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FogXFi5LZ4ds7+D9SGNdhSaa3ct5HtARKD2x1iKd1s8=;
 b=CfW+CtvBOwLqI2wl4Jk+VDn+DsD5U3/t0KTY/9fHlHcqGdzPhl1LiXhOqFez2OVnJP3hp1CKtIln6h0CcxDuJxhkXKckcId0WQzA5IPjCBDz+4UgqyUp64DBUJqxkT85pEocfCULvKgTtLyV2QTpXwlpASoaX17oCU+2D1yjKJY6BJdWutOCKJ0hiNu1XFweoso677f/ZYFQtshXtDoMGfj6rCiQsZvpf4HP/3BVEqxaKQTF1P3elU9Kv4yyTFvbKTXSdswBD09ISl4IfE4fOsM3tbOH5Doi2I9nIMyhvIRqQemvMIQwguT5Fb0J+7Ar2WYW8eFb6W5xP2PEYkBRKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FogXFi5LZ4ds7+D9SGNdhSaa3ct5HtARKD2x1iKd1s8=;
 b=udDv56mWoAgqoRrkpICNgSxiw5j8VUPWWH8ZgBN6pC7oqj2KgOi/RNja0rQt/NrAtmLbw4Ui5vIZlT6F6CDHaMQvwCh/1LxMLup+tbY9ztrf92rwI6+LIXhnA6OUno5ZXBcOW/3lKQ+7pnY0vKMiRUPlD8H1bJctJPNKrL4Fniw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM5PR12MB1945.namprd12.prod.outlook.com (2603:10b6:3:10f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 22:42:50 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973%7]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 22:42:50 +0000
Message-ID: <1cf62647-20db-646d-ae83-c2ee61f257c7@amd.com>
Date:   Thu, 25 Aug 2022 17:42:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 02/10] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bagasdotme@gmail.com
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117577662.6695.15496626554784059239.stgit@bmoger-ubuntu>
 <2b7e3511-8e69-2e47-0f11-7f1014b38940@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <2b7e3511-8e69-2e47-0f11-7f1014b38940@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0069.namprd19.prod.outlook.com
 (2603:10b6:208:19b::46) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0eecb44-1f3f-40eb-9842-08da86eb23a5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1945:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mstSLiBJyFXAx49Ow89S30Tm9zt/anaElWB+0IC12nf2sNjfgED7LU/OsTdqE+nMCsTRrbMkEtQhlvYIhY1hyNYQf1c5pLrDsgQxxShBEcAJzG241tizTG2Kb6kuSiiBLJjfzFQ8UbiWl+KizgSe4oK3bC7mR3hT3aQBxpjPYjxMw1l9vaIXl66iLzmUlDQZS9ASgWUGz5v38X7LQ1F7VvThMAEJN98/J9lXauqdOwPJm49U1j8KszKXulGHfQAtP0khNxgca0Wi+LVemmzvaofyCqC6ldHu60lbkNROoFL2LGeCT0JQzfVVKboFulVIpXTcsiPRZMSqTB6g/t9xsvv5W5B0qkzGK8v8Uy08X2bexzIDHDBrWFG7knYtCuLQxIR2EaGg8gLDlrcPcByCRMlFuuLXxbuWx/8wGIiUw2kNguO162fMbZ8yQyPjDJzC0ACPIqmnEoJ3VmQ7wtBP72uweqrfLLQi6h8NGEeQNBa3GNLegL2hM+xRUdu/W+zh7N2BjHGhvBEUaoCgdzYQXP0AsZjvJUKxvrc+lfOlJyHMrAwIGxzlO5+rpOJJiIr94aKpzHnmdAThPdbvbcDwnkGmVQ+klrS175XfkUFg4hcJlvUGKMoZazcS+YAjAx/CBE9ZUUJc9Dge4wx7Gm8gufsGZzH9LPqbUI4PqXmu0CCBDoqgwN0iiCpz73ZMh8MMSn0GaMoImFBKyfSgpfjRS1TP8hX/KxRPen1yD12v1D84FBf5rF0O2GDbgnKdnoz37ou+PLUZN+dRepP4fPn7nnBRWsR4XaJecEviVCUnYud42xGkFSWWZ27OdhhvKMbl1UulEHBY5I9FJlx6gjvSWnowzN4nT7dWETrkI6ivIG8wlsVj1vjuX3UxrGfzkHuf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(26005)(53546011)(6506007)(2616005)(7416002)(186003)(5660300002)(8936002)(31686004)(36756003)(31696002)(45080400002)(6486002)(478600001)(6512007)(966005)(41300700001)(6666004)(83380400001)(66946007)(4326008)(8676002)(66476007)(110136005)(2906002)(66556008)(38100700002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aC9iaXlqaXM2c2tJMWNaYU95SExPR2ZNWDJoSmFvcVdlZ3pYRW1VdnRoY0xl?=
 =?utf-8?B?Tm1rZnRValI5MGl6RzlGWUVVc0d0eE1ZL2lyc3drdmg3bmdGRjRlVm5hTTU1?=
 =?utf-8?B?SURDeWNXL0lCMGtBV2VsdTRRUTN5NWVrVFFKRERKaDByTDVXTXl5b1J6NU1p?=
 =?utf-8?B?KzJoY2FmTmN6QTU2VGZGS0VHblZ4VC9oWVNTamNnb2JjWnJzR3FsSVM1Y3Bn?=
 =?utf-8?B?ak9mQ0psYlp2R0MxSzFSVENyd1N2RXZySDYrMTZzd2djUk5XL3g0S0grbDR0?=
 =?utf-8?B?R2hFNitPWngrK25hZk9sK2xZVk93UFdzWWR6UkhPakJvblRQeHZNbldXWmJt?=
 =?utf-8?B?MDI3RDlrM0tBUEFlcnlXTFJVcmE1MXJpR0dvU2xzdUVKd2JrRUc2OFllb2VI?=
 =?utf-8?B?ZEhjZGZyQjVsU2FGTGtBdzg1Y1V4NURHNHdQdC9VSHZDSWtVNVVQMnQxQjRC?=
 =?utf-8?B?NC9VZGVydFVLZTF1bVVqeEtrcDZJaFJDR0M3cC8zWWg4S2xNZmFaTk9CclFV?=
 =?utf-8?B?ZGJWS3RyOXA2QXFZWGRTU2tkeEVkcG4wYTE0ck51TkNlT3UxZzBjSE40MUoy?=
 =?utf-8?B?NFowd0ZwS0ZoMWx3aU9zaEsrM3N5ZzRlUDVFS0RsMVVadFRibWI5aEhXc25Q?=
 =?utf-8?B?MkJsNzgrQ1RjTjczTmJ0aHYyaFczdXBGUzYvYTBhTldIc2paMS8yVzBzOWFY?=
 =?utf-8?B?dmJJL3FaZlhWSEZ0RDh2Mko2S1BJR3kzY0lHU2dEV2JCa0R3TGZXLzhxYUZy?=
 =?utf-8?B?TEFERm1yZzlyQ0VOSDFJbGx0TGNJc21zSFB1YjJzUDQzL0dicmoyWi80V094?=
 =?utf-8?B?MTlkcU1sTHQ4ZSs2Zk1VckxVRG4xbEtYV1VhaXVGc2hSL1VnSmVSSzgzU1FS?=
 =?utf-8?B?NlVMNVZweThIc3pqeDlrLzdrSzNjQmNoUmZLMzkwc2w2aG5NS2l0anB5R1Rp?=
 =?utf-8?B?Rnd4cEV3YkplemJDWGU1dkNnSFBrNnB5MjJYZ2x3b1gvU3RmREpuMUpQSXdM?=
 =?utf-8?B?SDBVbHU2eHdKWG1RWFJRVkJRZmJ5OFlkNmtad256NHp2d1k4K0RQV2Z5UE53?=
 =?utf-8?B?OTRKck53R1ZKVmhTdVZwNXlWUDZxMUZaWGpUbFBaWUh1MUZlS0QwNkM2eTZo?=
 =?utf-8?B?TG5zRC9vREREMk54VjJ4TVdNbjRWM2FneFN6ZTR5YXA0WS9rRkx4L3lNMndM?=
 =?utf-8?B?QTZHbXpJWE53YjRnb2dEeTllQ2N2ajM2Q0szQW4vcGxhRHhSVnpTUE1rL0Mr?=
 =?utf-8?B?M3NFM283ckl1S21yVEVoOGtqRG13K2wyajhoMnM1V25zMXN3bVMxNW53Vmho?=
 =?utf-8?B?K1J1YzUvSldNTVJVQU9HdDhHRk1YWDROR081aEVpVzlxR2lyckd0QW4yMElP?=
 =?utf-8?B?UjBMb3RQeDNpcWIwQ0tVaGdSTVQ2T0FhRS9FMEhzZVFvNklobDRTa0JBN0lh?=
 =?utf-8?B?VlhJWnBTeENzMWhqUHlucEZGU2hoVzBXSlIrUjdSUHdZeUhhZWNOdUVaUTI1?=
 =?utf-8?B?MkswSndKSDBqR0R3VnFMdEc5cUtXUFpjTEdYS0V1bEMxQ2V0TXU5Q3V3em5R?=
 =?utf-8?B?WlRGOUhYeXkzZnovK3lTaldvRWgvU01EVjJud0d5cXYyZmQ1V0xkQ1M5Ni8r?=
 =?utf-8?B?OFZOUHNFMmdSTDg5OEJZTDl2TzduTXI2NFNzM21nbFA4K0JhNzRwMmVid3p5?=
 =?utf-8?B?MkZ0cFZsT0NQTW5QR2svZ3pOMGZ2YW9rdjg4L3VQaTMwcFBvN3FtZzVvZ1pj?=
 =?utf-8?B?NlhDc2dnQXRKUG5RUnlieEMzL3pORTBnbjAwK3M3VVF5ankvVUMweTFvb09T?=
 =?utf-8?B?TXVZK2hzeUxxd1FqT2JzbmdCOU8wTjljMEhJVE1pMDJuc1pmSkRJangzc1Ru?=
 =?utf-8?B?VXR4eTJTZ2k4WFV4SVYwRlZMakdMNVFoc3N4NDNWQ3Fuei9WRGFPWENodDJM?=
 =?utf-8?B?bVJ0U2xjTkV1MUdaV0xxMjBraEtXMjM2aEJWRGpaTUJmUE1PZnhIZkVmRFlX?=
 =?utf-8?B?aEpjRkVjOUhHb1ZZZHFuZWNQRS93NVBmdGFYTm50VXRHZFRtdmFGdzVkWEJ1?=
 =?utf-8?B?clBHUkpwSFNmVWFiT2ppL29XLzdFaWdzNEhiYVVlTVgvYkJOTGZEZkRLUlVE?=
 =?utf-8?Q?LmRsGmk9s9J7o6yIOnxs0d98K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0eecb44-1f3f-40eb-9842-08da86eb23a5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 22:42:50.1869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RVgTJLj3n9t2DbM3WkAJAQ+TIzpEVUg4qt+Cg9Tj2hcgXWG+ypjSURPJ9IFPDc+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1945
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/23/2022 5:47 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/22/2022 6:42 AM, Babu Moger wrote:
>> Adds the new AMD feature X86_FEATURE_SMBA. With this feature, the QOS
>> enforcement policies can be applied to external slow memory connected
>> to the host. QOS enforcement is accomplished by assigning a Class Of
>> Service (COS) to a processor and specifying allocations or limits for
>> that COS for each resource to be allocated.
>>
>> This feature is identified by the CPUID Function 8000_0020_EBX_x0.
>>
>> CPUID Fn8000_0020_EBX_x0 AMD Bandwidth Enforcement Feature Identifiers (ECX=0)
>> Bits    Field Name      Description
>> 2       L3SBE           L3 external slow memory bandwidth enforcement
>>
>> Feature description is available in the specification, "AMD64 Technology Platform Quality
>> of Service Extensions, Revision: 1.03 Publication # 56375 Revision: 1.03 Issue Date: February 2022".
>>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fen%2Fsupport%2Ftech-docs%2Famd64-technology-platform-quality-service-extensions&amp;data=05%7C01%7Cbabu.moger%40amd.com%7C4385e95126b24de58aec08da85597c88%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637968916632283680%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=dKSxIinxZGybtACbs3%2FVZr4zbeAvXYc%2FezVivq3xjx0%3D&amp;reserved=0
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=05%7C01%7Cbabu.moger%40amd.com%7C4385e95126b24de58aec08da85597c88%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637968916632283680%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=f7MJmrwkBGxq8BuWjNY6Ze9NdzJc6NOkXxNjUZk5c4U%3D&amp;reserved=0
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Reviewed-by: Ingo Molnar <mingo@kernel.org>
>> ---
> resctrl currently supports "memory bandwidth allocation" and this series adds
> "slow memory bandwidth allocation". Could you please provide more detail about
> what the difference is between "MBA" and "SMBA"? It is clear that the implementation
In this case the slow memory means memory attached to CXL device.
> treats them as different resources, but both resources are associated with L3 cache
> domains and (from what I understand) throttling always occurs at the CPU. Can both
> types of memory resources thus be seen as downstream from L3 cache? How can
Yes. that is correct. They are seen as downstream from L3.
> a user know what memory is considered when configuring MBA and what memory is
> considered when configuring SMBA? Additionally, I do find the term "slow" to be

This memory completely transparent to OS with little bit higher latency 
that regular main memory.

Yes. I know slow word is bit vague. I am not an expert of CXL. But i see 
that word slow is being used to refer the CXL memory to differentiate it 
from regular memory.

> vague as a way to distinguish between different memory types. What is the
> definition of "slow"? Would all "slow" memory on the system support SMBA?

Yes. All the slow memory in the system can support SMBA.

Thanks

Babu

>
> Reinette
