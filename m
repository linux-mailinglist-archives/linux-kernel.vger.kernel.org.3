Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D51508B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379773AbiDTPGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379883AbiDTPGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:06:03 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2088.outbound.protection.outlook.com [40.107.100.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A847D4551A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QY+UhvRE45rPDKVovmwvdCcuFY+Bo3hMEfOsfdTSTQi+/0x93ASM6p+Ui06qS/L5WytGeljkDEvHVqU4MWrGPL3WnY/Qa0BPpdbLaYIhNkaRWXociDSvuoQga6uFZQzgIJSb4mYRtSyyJoBicFnk31vtkXHZS/Q6VICJudyej/4+t+OazO6NRzIXV7pS6YAOe1bX05nhYJ2mK8UHdq3MLSkfsHRwgFC8Kash0ectmFWsJHgOwT/Lqfv2OT3s0J7Ea65W5KLpBuLg54vXXJ4twRYd5dZfIO+QAvbtRg0abi0sgjoYURo/e41oGJ9BCc40zmdVfgxIDHGyr5msWhtr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgW+vC/i7ZJXlH1iQxDXPJL51gZwmflWSNQkbVqMBc0=;
 b=ClAudOANa82AFrpA7MtHHifCyxgdHWJyUINFpGSA0UR+SUordR5geitbQtP3TQMxKKmAjuw7B7yxesFkfs5kPCSNh/KoRuZKLfusDEmfLULFc0o4MqoSlb0D7Mn82ijOLewriABswsU27pJKLvg4HpIigCyjUkVz6Gld2NdtScLhpYMqhFEQYvFvyQ4KbJ+dpNAUKVM6Ks+cYw02VUar3g2/Xwf+J+gY0902NkdqtZl1x4j7u0S7vq8vGLvvr5C6JzVstLneLwUdaAlPZ3344U0fni6D0g/kVns70vUXTfcjTaSjd/Taq7TKqESQRBuFBuLFTgOywqJZaOdDZZ2QvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgW+vC/i7ZJXlH1iQxDXPJL51gZwmflWSNQkbVqMBc0=;
 b=dI2vWX/g8yEGTxh0uyohJ2YKI1V7fktRF/EFv3+TYK+e6JFgMa6MyiPV8bXMv7V7k/hvmk2E4Hj+gha6j+mLpj76iN0icVrPfCk9js6Fn78b2u3lKVBgCpoV3bXy4JXRavf9ah3qD4dOu2Bsbzj0JKX9rqIJirWZzEZMW8rvuSLUOJY/YJFpd1GQ2skWz29e6beD0qfyabYpAbOKPtU5pXmbFA5nXve63tOkNVTSzrHR1ODHIaZ1hAZ+9NP3RhVSiY6bvhXjPGTGQ4H9qlkKgNsVxhghYKiQHQp0oGGXmZyRZS3zP3RN6noFUpvD4zRsPIfac4JtwuZvoUKrHDuj4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2751.namprd12.prod.outlook.com (2603:10b6:805:6c::26)
 by DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Wed, 20 Apr
 2022 15:02:17 +0000
Received: from SN6PR12MB2751.namprd12.prod.outlook.com
 ([fe80::20a2:f44a:bb1b:d587]) by SN6PR12MB2751.namprd12.prod.outlook.com
 ([fe80::20a2:f44a:bb1b:d587%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 15:02:17 +0000
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
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <f1b32237-f178-0656-b3ee-814eec4edb71@nvidia.com>
Date:   Wed, 20 Apr 2022 10:02:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220420100801.GA7235@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: DM6PR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:5:74::17) To SN6PR12MB2751.namprd12.prod.outlook.com
 (2603:10b6:805:6c::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6fb4b90-c3b0-4565-6dee-08da22dec2a8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3404:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB340498497FCDBC633ADEFF12C7F59@DM6PR12MB3404.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oKFUVdtekPg+e4AqWe/3zFX7fq2wo5cPM1+cdcPUxtPjcbgxSDcJicXTNTGoIsldwlcXIZ8hlmBLteoLBDXHBVF8qeb60k0Kn2kDGwRPiGIrmUjcgO2MDYu5J5wIJ0Bn3ZO6PCHW3DSfje/cYc557D11ySuXkLJOmkKFAidEl5mTEDrvN58rvDDZ/jGIYSlYNEMfk8hm79N95cfqapXZC4RDskkH866OObORBApPwz9kkoUQxeMJWwH1LzvtBBI7q36H4UeaqmsdGycx7d4g9Hai9NY79g1KSs3byTdjCk9C+RW5EthBe7IighZ+mw7oEzV7Zv5Uz8fFFQJOc27YGXadMNIwkLBN6ytVd2fiBbKSu2jXvkh+AX0sDv5qjCztyVnoYpxjP+arGW6fuedHKKA2fgwjRSavs52bZmakO0ki6icY9YjH4YkYUCqX6i5oW6ZBpVSKlmwV69eGJhqymIqD+TG4kwvQcOEjbYvQ2IQvFpXmiszFVy9P/ztAqW+uce6tH5Wvws8i/xw3Q9s+/abhVtFurok8nWTbiWf4pD3GZOG6RmQY0f5VZlEvtPOnE8xw64ByGxU60IpfisJ/kd0Jtm4327ioJdSVf0wBDEqqdVuaucqzhGE9xbHlg/dSZCrtobvXCQOsFD+E7S5VS0A+aN3oRjM5l3vKGFD7QL8jzF+e7E4TxeyHXiu5fAzs+o4+B0f2sDGkqbBu7Zmx4olgOxwEZ4Ovf/1pCU/lFL44DwWyMMrnnFMHsSa4yRrc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2751.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(86362001)(4326008)(2906002)(2616005)(6486002)(6666004)(26005)(6512007)(83380400001)(6506007)(186003)(31696002)(498600001)(66946007)(66476007)(53546011)(38100700002)(66556008)(5660300002)(8676002)(54906003)(8936002)(36756003)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3pvdjdEQjRNQjRnNFZiNHJ3K0Jza0F0eXRMN3o2TWQ5RG5LWUNNUWFnbWdn?=
 =?utf-8?B?eFRoajc1RURvZXJWY3RqYUdpU0pFczIwZWlVWXFwZzJ5WlR0dHhpbC91NHBR?=
 =?utf-8?B?VFRUM2RkaFhlZXhTd3oveWhBNitmK1JuZFZhalhpbGNkTlhJc2ZGbEFOUFpo?=
 =?utf-8?B?R1JkcHRTYUNSWnQ3eENOL1NEQ1ZHd2V2aHgrNndSd3l0cDRzWVIyVnpIYVFa?=
 =?utf-8?B?VHpCZU1FT1pHeEpZVENIYTBqZXR2cVZLNW4weGdpTFlrTVk3Nm5YemYyaC82?=
 =?utf-8?B?T25IZmxYWnduczNtUXJwS2RQOTRQSlVXdTI4aG92K2dCTyttWFRkeTM3V3li?=
 =?utf-8?B?S0greVlNSnhxa1A2Ukx3NVdjZzlFQ2tKS3drTFlDVDNVV0FMcVhQN1gyUWQ0?=
 =?utf-8?B?MDlqVytaZ0syRDN0Tm9hbmdhZytqNkZwV2VvdjJUeitUSVZSeVZYaWxBV1Az?=
 =?utf-8?B?bGRuYjdLaUJiTGxQbWEzQUhGSlc4QUtqSERac3VOZmw1a2FQTm1wZWpVZzJ4?=
 =?utf-8?B?WnlYZUl1RmdwTExIYmtNSGEzNlA2VDFNSHIxdUxrTmVJNjRmUnJTQ1doUWM5?=
 =?utf-8?B?ZnBoYU9reXdnNEp5enAxMWRHbTRPZkxpTGl5a0tBM01MRmMyOVRZKy9Kdm5L?=
 =?utf-8?B?S3V1QmNMNHE3M0ZOZHo0N2x4RGNtYnNabFVUbHErL1pYSVZJRnRQT05zTTYw?=
 =?utf-8?B?bHl2d2hzWkJUeEFXdFRGZU9Qa1BYOUpsYjdydVkvd1hsaWU2a1pCbEp2UnZt?=
 =?utf-8?B?alRwcVJhMko0YTZaQllIUmxxM0JBd21ZUFRwRVZOYlRIMm1oejBMVWFDUVlp?=
 =?utf-8?B?YnU5ZTU3aUtzZXFSNDJDbjBLazBTRi9sY1J3aE5mS25VZHlmMnhGV1NtWC9M?=
 =?utf-8?B?UVlsV1pGbE9ZSk5NUG1pVkN5ckxSWEEyVHh6eXU4Qzhzc2lFclhnVGpSM05L?=
 =?utf-8?B?QU9GYS9uTmFXOVdQTFJWbXo0Y2RaK2xweDhEWEM5UGJCajFCbTUwb09TUDJt?=
 =?utf-8?B?VXNUR3V2NTZPNktTQ3UwZGwrS2dVWUF1d2Z2QmZ5cWlxMk4rRHNZR2IxaEpD?=
 =?utf-8?B?alNhSnpZQlhUckdqREVJbUxwdUtrSndZajFIZGorK2lCOE5mT1lYWVd4R1Ex?=
 =?utf-8?B?YTNFQ1luQnYwUzFVb3BzZ0NWWG56Y211ZDVadFRZWS8ybERsTitMc0gvTWwy?=
 =?utf-8?B?NWlaNEFRUUx5MGxIMHNBY0djQVpaVlBsQVRmNVVucG5TdGtldVdFaUZtQ0w5?=
 =?utf-8?B?M1ZZSE9KVXR3SGpXTUFHVVhXNEtoTzkwUlBQb3dkOUQzTGtIUnpvcFBnbURv?=
 =?utf-8?B?V3pmby9NRVJQeVRka3RQMGFKNFArN1FuaHpmUzhHMmFlSlQ1dDZOcGFyVzNm?=
 =?utf-8?B?NExwR2xwNjFnZEpRYzZrOVNZN1doL3kzNFhFeU5uNWNaUUhjN3QzWGo1OExT?=
 =?utf-8?B?OUpYODJIVDBkN0xUNklLVG4xWC9ONTRKNFpGUlZZY21uc2pISDByUkNPRlU4?=
 =?utf-8?B?TmFzaDMvS0ZIWDVlWDJtL1dCQXprM0ZBVTFFWG1zWDY0S2RoVnY1RlNyZHhC?=
 =?utf-8?B?Mlh0NmdBRFVVWlcxdm9oRU0vZWVZcFJkZEtsNnFTVk5HaGFDQmxjODYrd1dM?=
 =?utf-8?B?eTQ2MTYydXhxNVpPTHF0NEZoNEZPNUQwaksrZXQzYjNzZXFJSFNhS1N0bDFV?=
 =?utf-8?B?SHlBajZRV1NWL250YU9QVmRtMXo5V1I2NnRGWExUWkZqVDBaSGxBc3hjY2lN?=
 =?utf-8?B?Rk9zakFwYWp6Tm8wVFB3bDBJL0YwYzVtOWNveU56d2xTYjJjOUd2eklzNkNp?=
 =?utf-8?B?bmt6MlcyWG5RbDNMYnk4TzdDbGJnSUlLWkZHaWR2YW03Rk5xSkdUdjdpVGNa?=
 =?utf-8?B?dm9wOGVnNHFwVFlPcVZaOFVRS0dxOHQ5aUV3bUZkdUVXUVNaMGt6RzRqVUdn?=
 =?utf-8?B?NmcyMkpZWFVLWEF6RFFPY1dFd1Y1NEc2Z0hjaEVDd0RudlNMQVAyQ0FQcUxi?=
 =?utf-8?B?eVpCNFpDSlBvK1dWbGl5WEJQYTRteUhyM2ZaOVdaKzBGSEtFVHE0UFRYTWtQ?=
 =?utf-8?B?Q1hwVFBmNzNkem1xL2ZXc2lMMkJ1Vi9sZ2grRGFLdGd4cDZ6b0pETm93R21x?=
 =?utf-8?B?d0R2NHFPeW5yT1A0WXB2dHRhNW9ldm5FdzhYbjhvblRtc2YrWktzdkc4R1NR?=
 =?utf-8?B?L2VrZnlvY0NiT29YV3RFMkxQYVM2YTZWTFVnOWlXZm9jcDRQdGtUcjRxL2JY?=
 =?utf-8?B?aGNSY0N5c0pBK29xUFRwb1FaWHNOMzdvYm1QZGZORXErUTMxZFpWcDdkMVNG?=
 =?utf-8?B?S1VvZkpRYTc0bWJBeUxaU1o1OWhwaFZGK0MxWmFsdlZzSUtCTEwvRklqVjF0?=
 =?utf-8?Q?0PY6IIA05JA87m8U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fb4b90-c3b0-4565-6dee-08da22dec2a8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2751.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 15:02:17.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiLFVIMKWWXVkaNuxVMTk3nbWp2wsLoHgnWqmTYh2u7xTRFtNuCxvpcn0p/haYH0bnrLBRaLahUgtvlQ5mUE8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3404
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 4/20/22 5:08 AM, Will Deacon wrote:
> Non-coherent? You mean non-cacheable, right? At this stage, we only
>>> have a single CPU, so I'm not sure coherency is the problem here. When
>>> you say 'drop', is that an eviction? Replaced by what? By the previous
>>> version of the cache line, containing the stale value?
>> Yes,non-cacheable. The cache line corresponding to function enter_vhe() was
>> marked with shareable & WB-cache as a result of write to RELA, the same cache
>> line is being fetched with non-shareable & non-cacheable. The eviction is
>> not pushed to PoC and got dropped because of cache-line attributes mismatch.
> I'm really struggling to understand this. Why is the instruction fetch
> non-shareable? I'm trying to align your observations with the rules about
> mismatched aliases in the architecture and I'm yet to satisfy myself that
> the CPU is allowed to drop a dirty line on the floor in response to an
> unexpected hit.
>
> My mental model (which seems to align with Marc) is something like:
>
>
> 1. The boot CPU fetches the line via a cacheable mapping and dirties it
>    in its L1 as part of applying the relocations.

ARM-CPU core is sending ReadNotSharedDirty CHI command to LLC (last-level-cache).
This cache-line is marked as checked-out in LLC, would be used to keep track
of coherency.

> 2. The boot CPU then enters EL2 with the MMU off and fetches the same
>    line on the I-side. AFAICT, the architecture says this is done with
>    outer-shareable, non-cacheable attributes.

ARM-CPU core is sending ReadNoSnoop CHI command when MMU disabled. The
marked cache-line from the step 1) become invalid in LLC. As per the
ARM-ARM specification, CMO is recommended whenever memory attributes
are changed for a given memory region.

With my understating the CPU core must generate coherent accesses for
Shared+Cacheable memory but not clear for OSH+non-cacheable regions
in the spec.

Are you expecting "OSH+non-cacheable" must generate coherent accesses?

> 3. !!! Somehow the instruction fetch results in the _dirty_ line from (1)
>        being discarded !!!

The ARM-CPU is sending WritebackFull CHI command to LLC for the cache line
which was marked as invalid from step 2). The write CMD is ignored/dropped.

> 4. A secondary CPU later on fetches the line via a cacheable mapping and
>    explodes because the relocation hasn't been applied.
>
The modified data was dropped from step 3.

> Is that what you're seeing? If so, we really need more insight into what
> is going on at step (3) because it feels like it could have a much more
> significant impact than the issue we're trying to fix here.

The actual problem happens from step 2 when CPU executes 'b enter_vhe'.

>  How is the line
> dropped? Is it due to back invalidation from a shared cache? Is it due to
> IDC snooping? Does the line actually stick around on the D-side, but somehow
> the I-side is shared between CPUs?
>
> Many questions...
>
> Will

