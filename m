Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D1150571A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 15:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243728AbiDRNqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 09:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243238AbiDRN2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:28:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303513EF13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:53:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtC42wsX/Rpy2vnjB2M8B4kj5faOn45ehpWQ+oXpwu+3csBK8SFP7LkLJ7HsQ3Q3YpUMRD1U7IJZMd8YrMv7HMk4zYfLKbJwiVz+K/Aw2w9OLCzQN32oy0/MzVAlRjnPlBBHdZwSHmexZtHMGg7g9X0KVHYn+L4UTh8YZUO/3d4i03QrpQSOJKBGLJQdhEnx1BxpPf4dHpahH6Ti+0itxjRaqbEjDha6hSG9qTUkJr+XHiqSGQc+EVggi5sDHC4o2eOORh2gyYr0xMZqjRW7QxG0aZ5Hd0ThlQ25fCm9pacXLiN4tKK4uXWRCZHX9h0agET1QC1+U2OMz2M9fQCUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzgi9UZxppRhhmThZzojThRcPNKasTAXG2vNObNdMLc=;
 b=HTF/eMtttNKzUiZAZnEHrPW6NtQA2/lkdzWvXU/M4AuefmGmXwDPt3lZ/vkKFwlF5VlgXWM/rsLXlDFw2wTnS9dGOMh3qRsy4OxCBIIv6+dJ+Jz4xet7oJtJhF3hlcgC/Ta9ZXMBnDApO4qxvZCCa3bpayfMeoycCGc0KcCq6OAkY8XuQtIhPqyCI7IRqt/MLPNqpbjIukhRWP24XtYRVoBx+sAWrWp0+gZ3a64pOebCYBPe6/wkrTEn8Ths5hXy57gMQ43hL5AD7IEkAkmTiVDXpJ6KFvSvlh14ibc7hEoTBT+ZGKM4q+d1lYd3F5ytVed9yOszwgUSYGq0JTxw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzgi9UZxppRhhmThZzojThRcPNKasTAXG2vNObNdMLc=;
 b=M/ErPWhkLSpzjkD8jb2Y8PFVWkt/AItY4VbKDtrEbb1he5ZRoGtQVBe/tkOE7noCsDzA8LIeUPPnogWbZHJ/Yhm36529zTCMqflvcSQrT8Pd//uq+ypDECmxdgk5vOA5YE77/09LpgkY8boW6yCTWwJMArI8ZPRPNjZycI4K1z4eGJ7XMMjKGOjo9A7WR5OL9Vf5W1JWi6tw/qTbW+LfPKeOhhFWSGGf1OFrqg2VE2xfNnchVwMI0zEgbXdw1PtzL9kfL01vUqsvbPOduL5Ho9ZGhijNEPFmFMdWvASHnStokw1mRo35ySjs2LAM0CKWw7eWKsM4wlLQrcc/oZL9EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2751.namprd12.prod.outlook.com (2603:10b6:805:6c::26)
 by DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 12:53:24 +0000
Received: from SN6PR12MB2751.namprd12.prod.outlook.com
 ([fe80::d1d1:f634:5037:c74c]) by SN6PR12MB2751.namprd12.prod.outlook.com
 ([fe80::d1d1:f634:5037:c74c%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 12:53:23 +0000
Subject: Re: [PATCH] arm64: head: Fix cache inconsistency of the
 identity-mapped region
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20220415170504.3781878-1-sdonthineni@nvidia.com>
 <87y202agz9.wl-maz@kernel.org>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <6b08ece9-64c0-9de9-9876-ed2dceee9bb0@nvidia.com>
Date:   Mon, 18 Apr 2022 07:53:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <87y202agz9.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SN6PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:805:f2::38) To SN6PR12MB2751.namprd12.prod.outlook.com
 (2603:10b6:805:6c::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50904f86-b91c-4e35-1d3f-08da213a6c53
X-MS-TrafficTypeDiagnostic: DM5PR12MB1323:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1323EA3D0156D929EC659A56C7F39@DM5PR12MB1323.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMoJQIRMs1tFCfcS+j3hWFkCrpR4rKi+hg97qXcFZNo4qe5HMa1GESwxBqBqq/kYLjpbTpDzdm/ksALxsOY7b1GkLwszPh0JTGAB1WxgAlPz1jQdRE5XhnSALW9/dvPqf1BPnRBhh0osOOmSymSQFkBS65BE/euMwdQ/mzCWyaumj/ovH+Apzt6MKak185zZLlFu05fxb/+xzyiXn38wRwnhfuVv4ciNlFDYk2LD03rJC4udBvopycEmadOOyy1uP9/NMdnAWg0LNBqsFj1qpswanaqYLuP9NJh8rjd3TSp8Fa0ZGZALmer+Kg3llM1Mk/TlWHc8Hlka7fdUqf0n7S1as/zJHQSloQVy1u3JAB9/jKL8GvwClRh3Kl+NgfDZ17XhoK1XUOYa9/2eTrJAJEgs54ImzcOmK8oSIVsdkSuidWq/RhhqHWcdeVJhRL0fYia6ZLT1hYarejUO/8pvWRBnNM8RRyKgnvHyMcjwiTroZ6a3dr9kmPe4ANLFD81ufkovkO4DyNV0oTRzucTzy8BzmPyM+eu9g6rFOxx2NXJTzaKPVcy1aHMAPNdtR1nEF1kuUxKmweHkWuRw3ip6G44iyEHhEvf5aiiPLmh/B9BNFRfhMuZs/uOIijEo3xLffZu/AFkyHZ66fy10eb5wzC0NoaMGQ2l8o7/2/QsIGhnUNOL7hnmc4PPbNKW3IVzLS6SgWRAcg6CZ8SKt93DHMwwtIXsZhyjyNVu/7qytWkcMt1c+fhcsUxf4cFx4hHYE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2751.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(2616005)(5660300002)(86362001)(31696002)(8676002)(4326008)(8936002)(38100700002)(83380400001)(66946007)(66476007)(66556008)(6486002)(54906003)(36756003)(6916009)(6512007)(53546011)(2906002)(6506007)(186003)(26005)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1RFc29sWW5xbHpGOXFIUkJVNHBRckNvMUFWc3N0bHJXNjhOUVR5TFluUW5L?=
 =?utf-8?B?SXBRdU9hZDNxakVBMGpFcTlYTVdsbWtycUVzWFozUWdKSnVaU3U2Z3ViTStY?=
 =?utf-8?B?YlY2RmxRUUs4VHNGRU9ueTV1SkhxMzhRVG1VbW96WVUyV2kyVnJBVHQ1cE03?=
 =?utf-8?B?YnNJUWNhZkxEVUR2QTdiZFA3ZWxZWUdBdDBRTGgvaTRydnZyaFVSMzZzK0c5?=
 =?utf-8?B?aHhoNWNWb0JKUWdBNjczcEpaWnhhWXNOVnRrTzdjTDVpWWlZbmpoa0FxZE9G?=
 =?utf-8?B?TjFmVUpuMmRkZjdVSXRaZDl3THN4VDlZT2MxaTVRRi9odjg5eFBWRUNkMWRJ?=
 =?utf-8?B?cVl4QldoOTdQRGxlSll0VUtuUFFoeUJiRk9vMXNXYUtsaXlaRmEyUXF1aS93?=
 =?utf-8?B?VW1abWptZjE5TXhnZXFsVTg3N3pjZVJ2QWFXOUV1WUo4WG5HeFQzeUcxa2lt?=
 =?utf-8?B?WDNzNG1lbnZ4N3RkT0c4WGNtUFN1TkVKUmNJWlV5enQ0Z3RRS05CaitseXhQ?=
 =?utf-8?B?TTIyREkwbXRGbkx1MnMxaGtFMG9PL2FlbCtiYnh1Uzh0TVFORFVlWnZlcTRm?=
 =?utf-8?B?UlRMaWN0c29DSi9CYWdxYU1XL1E0cGg1LytVdGhtVUtab0V2WjJZbHkwZVRJ?=
 =?utf-8?B?T2xheUowVng2U1Awb1F0RDF5eHg5U0NMUlpHbkpKcE1vZ1pGdHV4VlVBWlIw?=
 =?utf-8?B?VlVnYmNKY3ByZzVKQ01BZ1I0M0Jtc0svNWNsdGNGSUZSNWpCNjI0N1JBaklL?=
 =?utf-8?B?d0ZwRitXZlc2cll6OUhYdHdkemcvRXpsc3lIbUdJNXowY2NDem5WZWJXeVQw?=
 =?utf-8?B?eVZaQTVRdldQWENDODZ2dFB1UEVZODRqd0M3dDJMQm1QZkxQVEVhdDlBVGg1?=
 =?utf-8?B?cXcvaDJpbTgzTG1VQlc2YjlRd1c4aUFnb0pObHY4VjJJWlcxRE9aaEtkUTNP?=
 =?utf-8?B?M2dydWY2bklFMUd5dldGY1owLzBCU2o3a3hVSW9idndPY05CZnMxL2ppZVBV?=
 =?utf-8?B?dlBxSnJoYmtvUC9Ja05QRit6VTM2RExrZHZVNlQwMUpMcXhyNTR0S2dhQmFR?=
 =?utf-8?B?SXFqMm9BVncyaTdVdVNBYysxbkRFbFBIRTZiVzQ4SUFFdTJac3lwYTdTRXVR?=
 =?utf-8?B?bGlwcFN5dGJ2NnpLN0w4RDAzd0MrTFFWanlpNTd5MzB0TlFHYzk5QjNCUzVV?=
 =?utf-8?B?ZXJWczRmYWJkRGhibHhOUC9tRVcxenFaZzJJejY1U1ZqYm1URXgzQWoyNEwx?=
 =?utf-8?B?QU83eFFrSXh3N1NBYlczeWcvMUZ5aE1QYms4OFFHZUlZZUJWVjZMMkRxUm1o?=
 =?utf-8?B?Yi9oYm5mVDA1aXhnVlE1emIxNE1kNkFGcjY1WlhacG4vUlZEQ3RoNFA4ekRx?=
 =?utf-8?B?OVA2MnJtWVQ1cStsQ1BQdmxpSFdNSkFVY1F0KzVKdXlOVUc2LzhHQVQxYkRW?=
 =?utf-8?B?V3ByZ2FHUHByYlNKcTBDL3JXbURZMnRybG90b1hkR2k1VTJQK2VHYnlUeUJV?=
 =?utf-8?B?U2U1VllzMFhEaEhIUElZZnZ0TFhaV0o3cW5TM0htbENtN2NnWkU1UUMvMlZ6?=
 =?utf-8?B?V09DT3FQVlNrWjFJYThxZzNSS0pFb1owMHF0bDRmclhkSGg5NHNsWHNNV01F?=
 =?utf-8?B?YzVyaU5JVmNtdk45VVM4ZGtvcmh4dGFVZGtCWEpYMkl1WUxITC9NMHczdDhX?=
 =?utf-8?B?T2pIWlhjdFlnZmdFYno4WHVGREJnWWZoRXB1V0VnTGxRckg5dk9keEtRUFpu?=
 =?utf-8?B?enlIakhjYkJkYUY1d1o4aHNnZzNKQ1UycHBza3NvRzZnRVRaU2RyZkJXb0ND?=
 =?utf-8?B?c2xCdFdLTmRGUnR0dDBmYllJM0tiVzJ6OHgyeFJ6RTROeVFERE9USzBMTkcx?=
 =?utf-8?B?VUpaeFVubEM3QS84SjBsZyt6TG5kV2xRK1lveXE1aXVFbERzRzNvVG5jcUxJ?=
 =?utf-8?B?SEpsS3JyOGtxUmJOaWxEYlRqdWFZa0lLVnV6Q0VKNXdjUUc0WTdoaFgzSlR4?=
 =?utf-8?B?SzExbzl1Zm16ZkEzUEVRQXRIejdCME52T29DUnhkTnFUUHJucW85MmYxZ0Nt?=
 =?utf-8?B?VlZUS3ZDTXRHNGNyTzFXN1dIUHlBS2hndkZIdXJKOGthZGMzWlpWb2RuR0NH?=
 =?utf-8?B?UWRtSE53M1FTVmJyT1pYNTZrR3k1TmN1YkVLbk42Uno2NjVjRTBoTkF2Tkcw?=
 =?utf-8?B?Y3hPcmJxUkxnR0E5dDEwUkVCWG9MaWFVN1RQVURCTWwwNDlLdlRtNU5tN3dX?=
 =?utf-8?B?NlZRSXZ2a1lBdlJDSWNpeUtVRjRublc1R2t2a3M4Tm5OYlVpT2NGbk00OWN0?=
 =?utf-8?B?VkdmYS9ZNUhGbGFSemtmaGM0WjMxUVZ2S01zSEd0bXFxdTRla2RvNWxESDN3?=
 =?utf-8?Q?vtcdIINj3IMxAtUA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50904f86-b91c-4e35-1d3f-08da213a6c53
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2751.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 12:53:23.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWtWQaVU8gzPuk/knMWlBcyn+65ncH2xWk3nq0xanDL1n+7dDc1icOZPTmGUyFTxma64e4XQ7tFbocX3fMTfAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1323
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Marc for your comments.

On 4/18/22 4:16 AM, Marc Zyngier wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Shanker,
>
> On Fri, 15 Apr 2022 18:05:03 +0100,
> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>> The secondary cores boot is stuck due to data abort while executing the
>> instruction 'ldr x8, =__secondary_switched'. The RELA value of this
>> instruction was updated by a primary boot core from __relocate_kernel()
>> but those memory updates are not visible to CPUs after calling
>> switch_to_vhe() causing problem.
>>
>> The cacheable/shareable attributes of the identity-mapped regions are
>> different while CPU executing in EL1 (MMU enabled) and for a short period
>> of time in hyp-stub (EL2-MMU disabled). As per the ARM-ARM specification
>> (DDI0487G_b), this is not allowed.
>>
>> G5.10.3 Cache maintenance requirement:
>>  "If the change affects the cacheability attributes of the area of memory,
>>  including any change between Write-Through and Write-Back attributes,
>>  software must ensure that any cached copies of affected locations are
>>  removed from the caches, typically by cleaning and invalidating the
>>  locations from the levels of cache that might hold copies of the locations
>>  affected by the attribute change."
>>
>> Clean+invalidate the identity-mapped region till PoC before switching to
>> VHE world to fix the cache inconsistency.
>>
>> Problem analysis with disassembly (vmlinux):
>>  1) Both __primary_switch() and enter_vhe() are part of the identity region
>>  2) RELA entries and enter_vhe() are sharing the same cache line fff800010970480
>>  3) Memory ffff800010970484-ffff800010970498 is updated with EL1-MMU enabled
>>  4) CPU fetches intrsuctions of enter_vhe() with EL2-MMU disabled
>>    - Non-coherent access causing the cache line fff800010970480 drop
> Non-coherent? You mean non-cacheable, right? At this stage, we only
> have a single CPU, so I'm not sure coherency is the problem here. When
> you say 'drop', is that an eviction? Replaced by what? By the previous
> version of the cache line, containing the stale value?
Yes,non-cacheable. The cache line corresponding to function enter_vhe() was
marked with shareable & WB-cache as a result of write to RELA, the same cache
line is being fetched with non-shareable & non-cacheable. The eviction is
not pushed to PoC and got dropped because of cache-line attributes mismatch.
 
> It is also unclear to me how the instruction fetches directly
> influence what happens *on the other CPUs*. Is this line kept at a
> level beyond the PoU? Are we talking of a system cache here? It would
> really help if you could describe your cache topology.
>
>>  5) Secondary core executes 'ldr x8, __secondary_switched'
>>    - Getting data abort because of the incorrect value at ffff800010970488
> My interpretation of the above is as follows:
>
> - CPU0 performs the RELA update with the MMU on
>
> - A switch to EL2 with the MMU off results in the cache line sitting
>   beyond the PoU and containing the RELA update to be replaced with
>   the *stale* version (the fetch happening on the i-side).
>
> - CPU1 (with its MMU on) fetches the stale data from the cache
>
> Is this correct?
Yes, correct,

> What is unclear to me is why the eviction occurs. Yes, this is of
> course allowed, and the code is wrong for assuming any odd behaviour.
> But then,
The eviction is happening naturally don't know the time and the exact
line of code where eviction is happening.  
>  why only clean the idmap?
Seems only EL2-STUB code is accessing RELA of idmap with MMU disabled.

I did 2 other experiments, the issue was not reproducible.
 1) CONFIG_RELOCATABLE=n
 2) Change the line "ldr x8, =__secondary_switched" to

    adr_l   x9, _text
    adr_l   x8, __secondary_switched
    sub     x8, x8, x9
    mov_q   x9, KIMAGE_VADDR
    add     x8, x8, x9
>  I have the feeling that by this
> standard, we should see this a lot more often. Or are we just lucky
> that we don't have any other examples of data and instructions sharing
> the same cache line and accessed with different cacheability
> attributes?
I think in all other places either MMU is enabled or instructions/data
pushed to the PoC.

> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

