Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497C0591FE3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 15:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiHNNg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 09:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNNg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 09:36:56 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093FC1759C
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 06:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApwQC9AqVb4qtQfgOXCrdxnLfmRZCVzSHQMnr1Z2zXEFBnX7yckFD5KmuuWGeoLhK37BTXinxnsO3lqcUK/WoVflx+SFycSiQJHE40VPYW/0IwpK3JccTgG12Efu+Bznp2Z8gJKBZ14NvAxwqo1JosiElpvThzMc55NdD+/JaSFs2ajapwL61PvwAMD5/Wy0q2oV4ebG7sFiPSBdmE63/3ZX3CwBwrmFb3Vt8dDmg9hGFoQJaXThaGAqJqy7ndZgm+gNyuXd3UowE90avCErXPZV7dPtBu9f3KoY+GAg/sxDDf8MTmN5sVRaDZouLkqQoZwppMkARYzFdMMpx8E4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuPJK0VrCiWR0uXVyDZ114WO+hiDjfECWGL/vDrAZlY=;
 b=Pe3tXfSwWei+H9s0lMXXT9xkaHcSmv6erzasToTX5WT+Qsl6CxHUrzBrB/NXiHCFnL6SygjWHTbOeUCxbCWvUQsxGKWEj5mCsoGCo5pxGy5xDMK0CbQzujUWkerrvYTldXjG73D34Mw6qMVaJ2cVYeIUOndNWVnB6WXGYI4g5V5G3VnG5XQKWJlLhqtXKgyaEuvITpk3HQo8bL45vJjCw1WPDkDScy5rSOXgXuZRrLTQW5B5uv6ER1kn4tGTrZVfc9i13Wlhfe8bG501Q9gquyCUiCyHimNyVWW0QTfsbkWIBDzkPYFOKNt7TAXAMQj/W0EIj+U5oWLHYrxwexwOpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuPJK0VrCiWR0uXVyDZ114WO+hiDjfECWGL/vDrAZlY=;
 b=AKqoA8wQtoD+ap6J6hvvDeM4gTZ3bFu7KcDdiVftk9y7O5Q/r4VEr9+NJ9thtjVKYOrsow8wMTicxpP2wRhAJ9sE7EWeLhrQE33nUuUsINb7o7v6GbqVpvr2prhjmUOqST4sOn+6cOigz6c4yDyfNTKu9yMn0dd/47AjxOAKiPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BN6PR12MB1188.namprd12.prod.outlook.com (2603:10b6:404:19::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Sun, 14 Aug
 2022 13:36:50 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%6]) with mapi id 15.20.5525.011; Sun, 14 Aug 2022
 13:36:49 +0000
Message-ID: <bff96726-cbf8-7f27-8f11-5bc979a8b407@amd.com>
Date:   Sun, 14 Aug 2022 08:36:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] x86/sev: Put PSC struct on the stack in prep for
 unaccepted memory support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659978985.git.thomas.lendacky@amd.com>
 <21d5d55640ee1c5d66501b9398858b6a6bd6546f.1659978985.git.thomas.lendacky@amd.com>
 <YvZPoEm6PSeoflAz@zn.tnic> <6d9d433f-779d-7531-02b5-382796acceef@amd.com>
 <YvZkpYRfrgPLLoJV@zn.tnic> <fc48ce75-7a4c-4804-92ce-71f63c2db5ea@amd.com>
 <Yvf+HnofHZ3rZ+yL@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <Yvf+HnofHZ3rZ+yL@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0011.namprd18.prod.outlook.com
 (2603:10b6:806:f3::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1e993b7-5a2b-4dd9-e46c-08da7dfa0a72
X-MS-TrafficTypeDiagnostic: BN6PR12MB1188:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qaov0UMuBw4zLa04iNXouUzsKZ8JkC3DE9DgjpgS3o60w/YDrWKV5gYZYSfvXMjr2uA4Evgq/aP7uQ53NyqOWnVJ8Bh6U/BJ41c0TnLpGttJdnnMXuYjMT1oWPZN1DErNLzxbx5WaVMfyw+CQIQSgmhZHEDS6iMGAJ55IhF9IylllAMPf4vWYKUPg1FeJ/HSv4YMiHBDw1IFBtrILYU/p0YCAT/LH3SNlieYmZGI/B+Pq5kwtyRE2lbformW38OOo6Tb3DFdrg4Bh0o4Q3Hf+gX53uInFz0h/9OXUtKwVPJ5PVfLxEXm4HN+/kerze3bDx/wcqouegUqmW3XQXzyuBm6juEAjbuc1C1xOaj+0vxKMkHGlEvmv9C/d3MQe6QQWVKLbuyuAlevPXmFpKghaLygeVPNkxAACxbV2jiSoyomj/ddGzAhih5ZRGPhN5BghRE+XfvG/cL85NcqJaaOJHpjiSJ1ZbPcyvbrUHLWeauUnHqgRjdZfkQx+CWco/rSvmL+0z6wskjGxm7Lvc2EkqrcFAfEMfOF9DAkT3Isc4jFJD6r2cGNl/R6RVMr0PyyzGmYq+BOpe8M1Nuw4eZgiBuQKJT2gPcyvdvVIYkANxc4INQXGGmme5KLHOBvNVzAayu1EhlydAqXBBUCtmofKeISRsqigf9nTg5YaA3BtOw7pBy1aRL6uKpQ+UwBEEQjYJ6dXgaNmErKN7N+NnGMgsImNHy/s0lhHvfSNzlgMQTd95oI4NSsC2bGaCIOid88E1CIU+Zga4IY5PY+iIY5lQJQ806TtleK+I3RdBSp/ESQ9+NYDtABN7Bzfwy/J25GSVkK4CcCaCCLMK6grJd4mfVe7BtMWltZTSzyXI/o3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(36756003)(2906002)(186003)(2616005)(54906003)(7416002)(31686004)(86362001)(8936002)(966005)(6916009)(5660300002)(38100700002)(53546011)(66476007)(4326008)(66946007)(66556008)(8676002)(6512007)(6486002)(83380400001)(316002)(31696002)(26005)(6506007)(41300700001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0xQeW53Z2pCajRuS1Z0R2swcUNCQWxNbFEwTnN6STFPNE9UMTVkUWtnTG1O?=
 =?utf-8?B?YTF0NnEzYjN1b08vTU9JTFZ0eTJDNmZ0Z1FubmExay85ZndPZDJwRXhRNG9u?=
 =?utf-8?B?ZHgvRVlCb29HMkVJODVWcTJZaXpHOG83MTJaRDVRMEJYN0IrN2RlQUtrK0hi?=
 =?utf-8?B?QzRZeTNVeXpHSml3alBHMVFBdjBwL1grNDBoV1g2VXVVb3laa092SjJPbGhW?=
 =?utf-8?B?a3FENmRyaE5LZTd5TU4yeGcxVXNObXMvU0tlOTk1QTU0YTlHMHZ6aDZuVlNZ?=
 =?utf-8?B?eEpkNHZuWjl5MVZISjMxUlJLYnNpUWxKUXVpS3F3VEtUKzVZVzVWbkpjWUt6?=
 =?utf-8?B?bG9IZmR3ZFVaRTM4cFVwVXl0VHFocWVmcWRPY2VYeTJqaElsTFl5MEwwcU4z?=
 =?utf-8?B?Z3Y4b1hVVmowTUppMUZMeEc0Q0JzQk0yaFBoZVpNKzM1QzY4SlRHLzhjNjVh?=
 =?utf-8?B?b3JMTTZNdzBBYWd6NTYwMzNFdHA5UEdobC9TM3hXYm03MmRxZHN2c1ZBRFc0?=
 =?utf-8?B?YUJuTy9KZlU3eTRUdlJYUGNmWjMxY2JZWitlSHJQVXVqT2NzNktvRmhXTEtY?=
 =?utf-8?B?ZWhqQnl2S3h5bUw0SzdrYXFmL0V3NzJSTkFwb1VaWUVPMVBOVUFWV3VJbzA2?=
 =?utf-8?B?bUdvelU2RFhoV2txcGZ4dEpEa3dlVE5saVZOU3ZrUWxlSXQ0VjUyZzNRVnR5?=
 =?utf-8?B?VmtLZHAvZWtrZlc3cTZ3ZS81WXpRZVI3Zm95aytEVlZGNS92YzAxOGs3ZUhL?=
 =?utf-8?B?WVVXRWZjSExZMEJJUHBZMi9pTSthUkhiTW9xNlNCaFlRSjRHNUJlRFVHU29B?=
 =?utf-8?B?aStFTWdmdzdkOC9xMitQeXlHMEdqUmVBOXc1Ymp2TGlXMjVjcDR2dVZ1bU95?=
 =?utf-8?B?NytBWjhITHowUGRHcTRoejZhb2s4MC9keXoxTUgyV045UDFZNFRJM3JlRVl4?=
 =?utf-8?B?WEpGeFFZY3Ywdmk1SHhGcVo3VkdhOXdvckxrYXAycTFHd1pydXhEZVVhRllZ?=
 =?utf-8?B?YzROTjJ2ZEkwcEtHdzg2dVdlaWFLNDFlcTNMM2ZEVUhZZFR0MHk3cWNoQ2lU?=
 =?utf-8?B?c3JITmROU3ZpNGxzV3JYYlM5N2VNMnJVdzNlZTc0NVdpV0tjRUMvYTNtQzE1?=
 =?utf-8?B?RE5tU2tzcWJ0OE9CMmNBUVVSeEd0ekQ5aWIxQUczZ2NKSTFDSTVaR3oyNXo0?=
 =?utf-8?B?N0ZKN25oM3ZrY01kOTdnelNyOUhJbjE1TnhENTZ0UHhWYnNFdzl5aUNscmRy?=
 =?utf-8?B?Vm9HdkZ4anJwK3BmUWZMOC9vamVwZzB5aTdBU3hZWk5YYzRnNWR2ZWN5UVA0?=
 =?utf-8?B?a2dQZzRuMDF6UzUzYkFzczFlVHhIYnA5dVd1eUdPNlNqeWRsdDNoNnk1MWcx?=
 =?utf-8?B?UDJ4eWh4dUJVUGhHRGJrY2FMWExiTTA4SDBveE4vWEtoQTBxUGVCMXhoYWow?=
 =?utf-8?B?UDlEdDd5TitEdFZNT0d2TjlZWXpzOHgvMGJtZVUvanRVUHNiU1pEdVNpNTh4?=
 =?utf-8?B?VzU2cGFvbEE5ZzFvVmkxdW9xYTYzNVVjZ0tiTFR4UkVUWE4vbmtEYzZ6b0FZ?=
 =?utf-8?B?M1NzUWJXMXBLQlBSR2l0MmRwc3JsVlM3a1ZXYXlpU0RJeHlCUmFtOGNjYkQ3?=
 =?utf-8?B?TVpPTWdVSmNOSm0yV0pGSmlKOTdsdHdJMGpnZ2J1TVlMQXcwY0t2cEVUY2dm?=
 =?utf-8?B?ME1uNFIzZVhhQThQNTY2ZytpKzVaTmRwWXhQOFhvMXpvQVo5L3ZvS1BaWGls?=
 =?utf-8?B?UzZldG9oaVVSTnZXV29YUGpzK1hxUFl3TUw1TzFmNWt1T3JJRWdZSUNBakpV?=
 =?utf-8?B?anhGL3dsdnFWQjF2Z00wSFF5SlVvNHVJRTNuNXdnTmZoTVI3MnVzMGpUMnNB?=
 =?utf-8?B?L0R4UmhXNFVtcjNBUmV5Mkh3ZUlIajloaFk0UkxtRVdEWUZRQkhmbmNNTW96?=
 =?utf-8?B?emxLa3FxSjJtSHhJSXFNclc2RWhsb1d6QlI4SVZBVzIyMVpDUUVYcHNidmIz?=
 =?utf-8?B?KzUwMW1hWTdSY09oK21ScGZLN1J5NjB0eVUzN2gyMEV0WTVwbUxRTTN4RlIz?=
 =?utf-8?B?R3p6YmNwb0JkSCtkUnJMU3liZElxeXJLSkh0SmUzdi8xMWpzUy9YSzdQeHJI?=
 =?utf-8?Q?DnMqo9jt2UuXM6HdQwB3swmgR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e993b7-5a2b-4dd9-e46c-08da7dfa0a72
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 13:36:49.8662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhm8fT6BxxDTsLqXb/3G7dA5PZQfRG+4RSIXJyVdW2aAbi1bPo31SexwFuri4sjQVLtlO7mNbN5byGoSh8nVrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/22 14:40, Borislav Petkov wrote:
> On Fri, Aug 12, 2022 at 09:51:41AM -0500, Tom Lendacky wrote:
>> On 8/12/22 09:33, Borislav Petkov wrote:
>>> On Fri, Aug 12, 2022 at 09:11:25AM -0500, Tom Lendacky wrote:
>>>> There was a whole discussion on this
>>>
>>> Pointer to it?
>>
>> It starts here: https://lore.kernel.org/lkml/658c455c40e8950cb046dd885dd19dc1c52d060a.1659103274.git.thomas.lendacky@amd.com/
> 
> So how come none of the rationale for the on-stack decision vs a single
> buffer with a spinlock protection hasn't made it to this patch?
> 
> We need to have the reason why this thing is changed documented
> somewhere.

Yup, was all being addressed in v3 based on Dave's comments.

> 
>>> So smaller, on-stack PSC but lockless is still better than a bigger one
>>> but with synchronized accesses to it?
> 
> That thing.
> 
> That decision for on-stack buffer needs explaining why.
> 
>>>> Well when we don't know which GHCB is in use, using that reserved area in
>>>> the GHCB doesn't help.
>>>
>>> What do you mean?
>>>
>>> The one which you read with
>>>
>>> 	data = this_cpu_read(runtime_data);
>>
>> Memory acceptance is called before the per-CPU GHCBs have been allocated
>> and so you would be actually be using early boot GHCB. And that is decided
>> based on the #VC handler that is invoked - but in this case we're not
>> coming through the #VC handler to accept memory.
> 
> But then ghcb_percpu_ready needs to be a per-CPU variable too! Because
> it is set right after snp_register_per_cpu_ghcb() which works on the
> *per-CPU* GHCB.

No, and the code comment will explain this. Since the APs only ever use 
the per-CPU GHCB there is no concern as to when there is a switch over 
from the early boot GHCB to the per-CPU GHCB, so a single global variable 
is all that is needed.

I'll send out v3 soon.

Thanks,
Tom

> 
