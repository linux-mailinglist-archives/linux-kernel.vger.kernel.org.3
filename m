Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6C151BE54
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358308AbiEELqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243188AbiEELqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:46:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADEA53E0D
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:42:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ah+KKwJZ9HxOne4uZN9huEj9updVDSJ+/0NCNe+p9wcf/saSeMoPvOnu7VndlWdcjvQP8DaFikm3A6WYdsy64BWvc98jva+R9I6dRDLXPcczYARocmojeU6Y1reYmDxcltbTzA1XDyII/c3GH7LbAbwwjuXXEYQ6qC/FEz//unw782PWn8RXjTM8Mr13DB5WdlVRIuzibzlL9pz/xo1n4A2LQ72Z2GtcroYqyJNU6QjPsSAu5UEn2e2p/qZD7f2yoA7uEO/2jEikoE8Z5N3V6DScPF1h51rCz05PSuzJQTl2k6TNf/jYCFviRw+dd9JQZ5AIPRkhA2Ayo3RHKLvtOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wjL2SfJlYrx9SAByMKSmfBpW9RsLvTsjjY833uHPkk=;
 b=QWpikZCzzJc/Y+T/X4mPV3LStwnlAN0mN6k2m7HBkA2d76NwRDnq4KDd3WFTt6eiwmP7ms9+YrSKnvafz9Zh7hsxLZ5Ub1sstFSOKjC+RUZgas5waJhL+sWDh+vF1ups/AmBfBW8HaVF4BfXXpExiMTZy5bfPUeH4yyhAQEeKwTeR4O9Ml1V9XOcvlHY8SgBnxUTsjMYcgqR7TgNwdWthQ9s3N8wvEiaRadne+EZMabEwvOnnPPJu7K859nCQA0tIDOF4wdMB3vmJ4DxWWgBPKBXgSWpoaTfqHLIJ7mpEKnkPdE4cy+AOr3Vyk9ajXausBdRNsNpPRD9gaes9lNHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wjL2SfJlYrx9SAByMKSmfBpW9RsLvTsjjY833uHPkk=;
 b=OOnM2oofVNarWxVl7FsWilmoZ4iZBuL13ftwK8KmC5Up2H2Tx7B9OtjLsCX2GcGse5eJfN81LX4ao2bflfOgdZIA2nnKAaxzRrt/DMuQEo9SzZi86lu0xiGxRkVoMp1AbgTlqywxq2OUvrK/NcS7qAcmkHgvEpCcX1c+SaFHhtonjVf08Ag/ltIqonnEdXvFeF20bl4B0NngbFds3hGUqwgIFYszMlvvDCdivexkgJ571c/RvBX4zVyWB4niXXUrUBUK5y18rtH7Ec1Ct8xXw5gK11OZoN4OZQEQ4Vl06zQbrk+HUDmwQREvDDSJwCXySOvZbY2lML++4Z0dvsJQ8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2751.namprd12.prod.outlook.com (2603:10b6:805:6c::26)
 by CY4PR12MB1400.namprd12.prod.outlook.com (2603:10b6:903:3a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Thu, 5 May
 2022 11:42:29 +0000
Received: from SN6PR12MB2751.namprd12.prod.outlook.com
 ([fe80::7462:c345:8218:7f1]) by SN6PR12MB2751.namprd12.prod.outlook.com
 ([fe80::7462:c345:8218:7f1%5]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 11:42:29 +0000
Subject: Re: [PATCH] arm64: head: Fix cache inconsistency of the
 identity-mapped region
To:     Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20220415170504.3781878-1-sdonthineni@nvidia.com>
 <87y202agz9.wl-maz@kernel.org>
 <6b08ece9-64c0-9de9-9876-ed2dceee9bb0@nvidia.com>
 <20220420100801.GA7235@willie-the-truck>
 <f1b32237-f178-0656-b3ee-814eec4edb71@nvidia.com>
 <20220421114719.GA8557@willie-the-truck>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <873ccd61-34c1-36be-f77a-52c3db860bf9@nvidia.com>
Date:   Thu, 5 May 2022 06:42:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220421114719.GA8557@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:806:24::10) To SN6PR12MB2751.namprd12.prod.outlook.com
 (2603:10b6:805:6c::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72aaee0d-5895-4ae3-c1b6-08da2e8c55b3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1400:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB14006418865FA38AAC2BEFF3C7C29@CY4PR12MB1400.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B65BoXZjZakiQbV2xNIl1qtQIC7k+YP30KY/0+HuG+70joDvpQFc4PtFjiZH55SwUpFcqnnea0+P69SUhD5IOIubPKovhiPVhMX+mpwrT5fvYKuLbK5lc13dS6UyedmYzeHyoIMjhGsSDEf469BzjGFEK3JekA5WFq+92h2/Bum+g/HgaurMXohhYZ8aCICtd1bVf81C9wrgWO8UaVgwKcRyEB5c9Hj4W2z1rJYLGcKn4QyD+t7oTR/akcQDSlCy6bQ93ro+zOdukG/HKY6kTb2v75wZAtBIl3KnlwA73o3/dpSJfJgpVRi1DueidCg58FVtyw/HXbbImdDFelPZQkCwrnEGrNHDOqhgxv+kzbt7hPq+SwPNnTjCOj9sKhGAVMpMWrim9y/O9psVjFeRFbbkAbXw2ggtXbYV5DIog2aPQ4JmTgzTR3o32Jg6DCKmI3VfsALp5XelOJ45UjqK1SJ+LG0HRTdJaAI+4+zaUn4B7RgplnAnYM43k+BNIJAMrYfGHYEmHoExw4G5TlYePkdnEYDYpho6nz19RKcB+Bu/pj2ieoqS5RVoQAA+KjrlUixYSk7DoXu9ek1N6nyQlMw9drpjEbDBnVrHcKyVGuE8Na18mD2GP2ysAZxhBa6aWD+rSTjScQ1zil5id37K0XQyh732aXCHTXYv7I6ImrqyHr9YXby1y7LIf62xIETVSNOYNAcATe7tKR+R3hFLokai56PoLd2M6/MVLQMg+mc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2751.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6512007)(316002)(8676002)(86362001)(2616005)(6916009)(38100700002)(5660300002)(54906003)(508600001)(8936002)(6486002)(6666004)(53546011)(31686004)(6506007)(36756003)(186003)(31696002)(66946007)(66556008)(66476007)(83380400001)(2906002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek9KRVlRVUtQL090eEFwV2I0NXViczk2dVJaTGZPWEl1NVFmVWZZUmVobnlO?=
 =?utf-8?B?RXRLMjZLNlJGc1liWGVUa29IcFBzQ3Q4V2UrSG05bEhKQXJZaVEzQWFaTXUw?=
 =?utf-8?B?MExxOU1WMXdUbE1sRktEZTc5VEt2WHl1R3JPNkdpM2owYTBLWkRtWEUxM09T?=
 =?utf-8?B?dzRad29RV0FkUklhK2pQRk03RjJESXNrVXNIQ3N0L1EvaklqVkZja0FudEVZ?=
 =?utf-8?B?a0Yrdnh4NU11V0o1dCt6bllBOGhiK3NUanJrcVorbWFEOHMwcVBxelpzWm9L?=
 =?utf-8?B?VjA4R0ZuWjRrN1cxb2pJZ3lnNXM1b2VVb1J0d3hkcmNsVWVubVovSjdRdjN5?=
 =?utf-8?B?Z1ZVdWtwd2ZjNHJVNnJ6ZjNCZ28zbS93TkV3QlA2Qm0zNVJDUmFQTXRDanYy?=
 =?utf-8?B?REswcGZJV2R2YTA3bCtXUzR5VlBlZ2pwMHpXM3QxOEFVd3VYVUdJWEpsbHpF?=
 =?utf-8?B?QzJ5Vk9TVnhjckFIWlNRMDhwSzJ2UndKSVlualUrdHNiWXBDMi9sc0F6aldK?=
 =?utf-8?B?WVI4YjRpSkFHRzB0N1BpYTNES1BrWkcwczlJcVhYK1ZhYVdydW1jQmp2VlRv?=
 =?utf-8?B?MlZwYSs2UXcyRngrYitibEhEVGFhWjcvR0FaYjFaYXFjUUJPQXJYVVlKdERv?=
 =?utf-8?B?ZWFuTTduQjJzTm1tZXZObmNlN1FYejZ6TEw0MCtoUnpsckhoWkdhWVQzK2xJ?=
 =?utf-8?B?QXlMRnV4SGgxWGgreG5tY2U5aUdRRlpXOGxtVkxobXNjcG8xRmRuUUJWbmhM?=
 =?utf-8?B?S1o5ZkZ3QW83R2Z5UU9DZ1lUQlVwNUJFUzlydVQ3VnpQUEJWMGxJeFl4aWhN?=
 =?utf-8?B?YmJUTDYzOFhROVZvY0F2aVNRd0ozMGlBK2txMmRvMkl6NWFBQVNpZzRrQ2Zs?=
 =?utf-8?B?eDl6eEhicTdyZ2RyaEZ1OWozR1cwa0Z0cGRsRDdYUlR5Qkw1Z0FuSkFvNWNa?=
 =?utf-8?B?SU0rSGFCSEN4ZU1QKytGZER5T3pVSE9zWi84aHdEWGJCcXRlbE5DMWw1QU4x?=
 =?utf-8?B?R0FvQit5azZzWWc2ZjYySTBaNGhCL1dKWGtrd2pkR3NHMjMwWUpzS1JrU1RO?=
 =?utf-8?B?T1ZOdTF1bzZpajRuWlhPMVZKaU13bmRFUUduY3NLT2dQbVdvWmJoSTBiTkNF?=
 =?utf-8?B?M1daYWkrK2pDdStHZDltOE9xMDQ2Nk5PUERrWldwWmc4OEdHOWdyTG84UUNx?=
 =?utf-8?B?RWN0Wk1SNHc5V3U1NHZnbU9nT2R1UURzc3NDajA3THE4TUt0ZlhLSjJacDlG?=
 =?utf-8?B?Q1lXMUFPQjJDT2w2RjI5L2tGSVpjb2lBMDVZQXF0MzZHSVFJd3htT0tuSTI0?=
 =?utf-8?B?VkdFbWZxWjc2cXlvMTJoWjMrNE80ZWM2M2JZSW9LVmE5c1VvNzVyTXM0aGdL?=
 =?utf-8?B?YjFIZnhGZWY3T21CNGd3Tm1kNEJlWnIrMW54TEV2dFNZWm1tTmJmN3d3Vmxs?=
 =?utf-8?B?dk1hazlleGg3eGx4NThkSkNTSmQ0eTRWL1R6SmNqTUFJQm5WSVFUOTI5UWFr?=
 =?utf-8?B?aGZzTGtva3JOZmRBb0N0WTJKdEV0dS9pUFF5VDBndHAxZmNwdFB6L0RlOXlJ?=
 =?utf-8?B?SERsSXBVb2JCRUthVWVzNmN6VWc2TXJZcHhody9FMUxpRGlMNE00M3IvTHJ6?=
 =?utf-8?B?dCtvN1oxeG11OFA1c1l1Wk1zZ0FCbUpXbVhxN01lM0VYYllLa1E2NnhzT3p2?=
 =?utf-8?B?MEllUkY5TDJJTlpCKzNwQ1VhaXQvWms5bFlqNGwrL3phNDVlc1dNYnVrVUhG?=
 =?utf-8?B?MENjSmpwR3F6RlM0Rk1RdEpGS0d4WFozcjVscTMxY3FXSVgvbFhUL3AyczVE?=
 =?utf-8?B?b05jQ09GNkFVdnpjTGpRTmxkZG9ZbWxJa3U3M0hVR1VEakROT0Qzd1BPaEtm?=
 =?utf-8?B?aHdZdUZlT01TRUZkK2F6L0JybG9uQk0weGZsVUJ0RTI0dUR0R2FnSytJTDYy?=
 =?utf-8?B?cFhVd2lqajhuTkpFOFZDejc0WDd2OFZ5QThFSURBaE1GSVAzVXV3N3VYS3Q1?=
 =?utf-8?B?bERrS0k1cy9OU3pvemVMVkZGSUxMR0JDc2JGZTZoVmdueE5NZlJsTCtiN0dH?=
 =?utf-8?B?MGpkdFpWYlBDekNSVGh4dFJCb25BRmlSMkI4VEl0ejl0ZngyTUJwaUxnV1Vo?=
 =?utf-8?B?dDZsV2JDRjJGWW1aVDhmcFdtYkVDcmFGNmU4VTdUZC9LMk5wVnJONkN2Q1ZN?=
 =?utf-8?B?b1ZQMXlJam5KTGZXaHB1MlRGZUdOMzBoOWFNZ25Lb3V3V1ZqUzRRMHhVWFdF?=
 =?utf-8?B?d0hvZU16Mis2Y2JsOU8wM0RETkVQbFNvdTd6cWs5enB0TUVBTllBdXkvaThC?=
 =?utf-8?B?Wmg1UDlvU0hXMC84d1hRSVBSWEluM09ObGQvTkJ4RU8zc3djWFpxQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72aaee0d-5895-4ae3-c1b6-08da2e8c55b3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2751.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 11:42:29.6833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gvbqm98mulOMRmbmeHWnJbBqdPI8/W1RHP+1wp4Kax2MNF5vUGVG4BOK1HBa9rvFmHqOUItTN2TkU7Ot3C15KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1400
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 4/21/22 6:47 AM, Will Deacon wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Shanker,
>
> First of all, thanks for continuing to share so many useful details here.
> I'm pretty confident we'll eventually get to the bottom of this.
>
> On Wed, Apr 20, 2022 at 10:02:13AM -0500, Shanker R Donthineni wrote:
>> On 4/20/22 5:08 AM, Will Deacon wrote:
>>> Non-coherent? You mean non-cacheable, right? At this stage, we only
>>>>> have a single CPU, so I'm not sure coherency is the problem here. When
>>>>> you say 'drop', is that an eviction? Replaced by what? By the previous
>>>>> version of the cache line, containing the stale value?
>>>> Yes,non-cacheable. The cache line corresponding to function enter_vhe() was
>>>> marked with shareable & WB-cache as a result of write to RELA, the same cache
>>>> line is being fetched with non-shareable & non-cacheable. The eviction is
>>>> not pushed to PoC and got dropped because of cache-line attributes mismatch.
>>> I'm really struggling to understand this. Why is the instruction fetch
>>> non-shareable? I'm trying to align your observations with the rules about
>>> mismatched aliases in the architecture and I'm yet to satisfy myself that
>>> the CPU is allowed to drop a dirty line on the floor in response to an
>>> unexpected hit.
>>>
>>> My mental model (which seems to align with Marc) is something like:
>>>
>>>
>>> 1. The boot CPU fetches the line via a cacheable mapping and dirties it
>>>    in its L1 as part of applying the relocations.
>> ARM-CPU core is sending ReadNotSharedDirty CHI command to LLC (last-level-cache).
>> This cache-line is marked as checked-out in LLC, would be used to keep track
>> of coherency.
> Oh man, that CHI stuff always sends me into a spin so I'm probably not the
> right person to debug it, but let's see...
>
>>> 2. The boot CPU then enters EL2 with the MMU off and fetches the same
>>>    line on the I-side. AFAICT, the architecture says this is done with
>>>    outer-shareable, non-cacheable attributes.
>> ARM-CPU core is sending ReadNoSnoop CHI command when MMU disabled. The
>> marked cache-line from the step 1) become invalid in LLC.
> When you say "invalid" here, do you mean in the same sense as "cache
> invalidation"? Why is that the right thing to do in response to a _read_?
>
> Would the same invalidation happen if the ReadNoSnoop originated from a
> different CPU?
>
There is no issue if other cores are issuing ReadNoSnoop commands.

>> As per the ARM-ARM specification, CMO is recommended whenever memory
>> attributes are changed for a given memory region.
> The mismatched attribute section (B2.8) is quite a lot more nuanced than
> that, and in particular I don't see it allowing for writes to be lost
> in the presence of a mismatched read. Then again, the whole section is
> hard to follow and doesn't really call out instruction fetch other than
> in a note at the end.
>
>> With my understating the CPU core must generate coherent accesses for
>> Shared+Cacheable memory but not clear for OSH+non-cacheable regions
>> in the spec.
> Ok, but we don't need the reloc to be visible to the MMU-off fetch in
> the case you're describing so coherency between the two aliases is not
> required. The problem is that the cacheable data is being lost forever,
> so even cacheable accesses can't retrieve it.
>
>> Are you expecting "OSH+non-cacheable" must generate coherent accesses?
>>
>>> 3. !!! Somehow the instruction fetch results in the _dirty_ line from (1)
>>>        being discarded !!!
>> The ARM-CPU is sending WritebackFull CHI command to LLC for the cache line
>> which was marked as invalid from step 2). The write CMD is ignored/dropped.
> Is this because the LLC is inclusive and doesn't know what to do with the
> writeback after invalidating the line earlier on? When else would a
> writeback get silently dropped?
>
> Stepping back a bit, my concern with all of this is that it seems as though
> non-cacheable instruction fetches that alias with dirty lines on the data
> side can lead to data loss. This feels like a significantly broader issue
> than the relocation case you've run into, particularly as instruction fetch
> with the MMU off is still permitted to fetch speculatively from within a
> couple of pages of the PC. Cache maintenance doesn't feel like a viable
> solution in general, as we'd need to ensure that no fetch occurs between
> the write and the CMO, and this could occur on another CPU, off the back
> of an IRQ or even a FIQ (with the fetch being made at a different exception
> level).
>
> Given that you have all the low-level details about the problem, it would
> probably be worth pulling Arm into this so we can figure out what the right
> solution is. I'm happy to be involved with that, if you like.
>
>
Thanks Will for your valuable comments on dropping valid cache lines. I've
forwarded your responses to hardware team, reviewed CHI and ARM-ARM
specification one more time. Our CPU team was agreed to fix in hardware
convert ReadNoSnoop to ReadSnoop command (step-2).

Thanks,
Shanker Donthineni

