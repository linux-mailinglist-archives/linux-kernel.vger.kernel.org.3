Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D79C467C94
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382225AbhLCRgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:36:23 -0500
Received: from mail-bn8nam11on2083.outbound.protection.outlook.com ([40.107.236.83]:34825
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245721AbhLCRgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:36:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSU/jTSaAmtJS0sjW/Di/cS0eZzs15DqfoQ4P3xOqT9LN7vK4SbCHq+di7QDRoSrWx4syGtkADHhQVgq6raztsL05L7ux/yVYfa03IVA1CR+Lg8PhvKkqBsULrIikxFgEA8JEx3JHxI+OWFTowJq1c2xdCVGhCMkShv1SosOfhiBte4gdR5jSZDJq4slJnw5QZSCfjm2/voOuHNOH/66EOIoXeyq87hl2Q9d+61f+Rb5TccMZiH8HpTpugfW5IvpnBtoRuaoD9g9FiJND/Gmc45nxNCTl0WujS2gxhJOnPRaxhzALYT43oKlCzl7zLsffk+1TkjbrceS7dNaQFvq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaK5NSo6dtVWk1uoyeFmunh7EHyLiTGRi0lsQYIkHAM=;
 b=RWwU3lnhWHtfAKcnTz5IaWXqUtF9Wk/J7khP7EcVGzn+7kKPOKMIvrWUrrPvuMEGvjTD2eKDUyV4guf61RmrNt9h4UjwyBWimih9awlQrYZzYK70s3JvZb95kXBqwmjtPOQ7KWtpPMgh8DAUxSk7Za/+XzuZo/vzBBFn0RQXQnQ+3UYbD5yVzsA5o7C2HAtGGiHo+0O08XX1JyLTB7qRSKHRDW5gzzpTrm271k0cVGpCsgRG3XoJ21QfjWI2UcXnNiAVch6WdrlrB7Do6pdyz2G64ImuDjUdlHaMbiGcihVCwBkrQsinrn6vgMkj5y7YnM85wa73x0jBKheatoAPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaK5NSo6dtVWk1uoyeFmunh7EHyLiTGRi0lsQYIkHAM=;
 b=dk9u/ODhLfxWpajtaHZtD0CddlJwkep6pMNchDndwXgiCPerttwGKJ3/5i1KqApZ7dv+1wRobjyFxxz9+ScD5XQsg2UKmjq9CIDab0wBiuqGZdc3KhqWj7KXQQZT+lJf7YBkRGaA2o9ragr7SK3vMXxuGLVdfw8XwNQeQzgBV1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 17:32:48 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 17:32:48 +0000
Subject: Re: [PATCH] x86/mm: Fix PAGE_KERNEL_IO removal breakage
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
References: <20211202144646.23186-1-joro@8bytes.org>
 <20211202155452.jh4qnvpx52r3od67@ldmartin-desk2>
 <20211203002513.fa43j6uvsn2ho4mm@ldmartin-desk2>
 <35ba181f-c182-aa74-07e2-fcff94bf345a@amd.com>
Message-ID: <45962757-d539-0caf-1031-9340ca4ce0e0@amd.com>
Date:   Fri, 3 Dec 2021 11:32:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <35ba181f-c182-aa74-07e2-fcff94bf345a@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0102.namprd11.prod.outlook.com
 (2603:10b6:806:d1::17) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from office-ryzen.texastahm.com (67.79.209.213) by SA0PR11CA0102.namprd11.prod.outlook.com (2603:10b6:806:d1::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Fri, 3 Dec 2021 17:32:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12015517-6dca-45a8-05e1-08d9b682ec82
X-MS-TrafficTypeDiagnostic: DM4PR12MB5133:
X-Microsoft-Antispam-PRVS: <DM4PR12MB513329C151B0AC8515F7D833EC6A9@DM4PR12MB5133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:208;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKFx6DxRfcErTiwQgtL5Sz9nHDgS1N8FdgWZ4kPQiuy7art0zuUumML2SLp8y4EsJ11Y+yAiRvkQt5TgzCG5tf1Smwd2Pg0B40fvlZGyZJEMzi4iqG4JqUK+tMQ2gwx2gSr1i3m3afwXYjBAQV4N64BpO3CheFpPA0Jhjz2QSBUPt+hdkgmeQchM1yYqcEzQ9AdyMkbP/GmcKGgMFf265jI5aDmM7e3MsLrlv4Blcd62+49cTgJeCUTpBeDP+WRHLv+th5WNAIYGs8N2u77m/xP2XPIgZQmCc3haNNbLeRxmxEksDdIIuaiF16mPrXSHz9nq1ruRcb9N12p5NkwERv358JYW4u35TzQlHWoLXv37laUz5CuRPAnyGoiK5ySRhH9X6yHo20yPgG0E5QOY45a0uCvDWUih4gdYFXSVYhB3nKwR5L5IJiO4pOqovf9QYjGjmJIFomjuub1tEpB5cgd+RXyLaFVq9JjGG8CFwoJtEAMk6nHsNEz5vG0qEJm8oPg1+uaWfwCCSwwh/PB4SjM31Fvi9QxBtObcI8kax6EV+9qDWudBJQxsjEGZm2y8a48RnWe3aBJsRHqcbEnnZIwyCQ6HUv2B0ghuzH8zyMFDSSGQ/JxholEPufv+ngdQ6XmjA5g6f+noYUtHJSTTrKT649eY+cKLCAywpS9zAC/tY61A44YDA4Esx7kKf+dFz6Mr5W4c4yfvaAhzuz/8Uf5DW3NXVAlQjfaQx7+eCnndr/tCNdF3LiJMUBcICr3b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(86362001)(8936002)(53546011)(6512007)(6486002)(186003)(26005)(31696002)(66946007)(508600001)(8676002)(2906002)(6506007)(83380400001)(2616005)(316002)(7416002)(110136005)(54906003)(66476007)(4326008)(5660300002)(66556008)(31686004)(36756003)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aStHWWlNTzdaWXRjL3pYVnczYjdZS1p0RlBJSTZoUVdIbkJnYTZBVGNuVnoz?=
 =?utf-8?B?eWMzRjdzZGhxa0t3cXNqQ25mZjBmM25WVzIxa3IrVlhzc2VYeG90UkJmc3BU?=
 =?utf-8?B?YURMNVkweWVDbk12U0dYYUFjV3RxSDlTR1l1SmtQeTBtNmEwRVYyZWJqOHhL?=
 =?utf-8?B?WjBDb3NxeGJXdm1iK0E1ckhVY0I4TW4yNDlVeDJEYnc4OXZ0NGlUS0lBK2xX?=
 =?utf-8?B?RjJKTDVsbEdkS0hla1paNUY0RnZzcWlrVWxCODNlWE8yWFcxRTR6NzgxbVZC?=
 =?utf-8?B?N0x1M1ZhcVlMWE1YMnFTVWlzczNldnNTNEpuekJiY0gwbHZIMDZuek8wN01s?=
 =?utf-8?B?OGFDQUpSQzhOMWtWRTkxSldWaUdwcjlyYVJlNlQrSCtiWVEwd1JjbGxZMlNU?=
 =?utf-8?B?R2R4MmlUN0VXYlJGdm9pdDNzVFZTTlUyUTkxcGlFZUpURWwySzQ1RnVRNHNj?=
 =?utf-8?B?NEFiOXVDZ3VGWEtNdGorbkxyWEpJYUdpODNLN3Y5Z09vMjJNYWk0UnlkNHcx?=
 =?utf-8?B?Nm5Bckk5aGFzenJ2czIwK0ZIcUlmcW5ScWFEQXZERE55aElZL2l3NXV1QTND?=
 =?utf-8?B?WG5XcGpYWjVScmlYdkF3UTNRenc3eko1ZHU1d3ZrMjlRYnlYaTZwOVJCdmNs?=
 =?utf-8?B?YXFTMHdFZnpSendXaGJUby9SZnZpSThDM2pTYjJ0UzFCYWgzWUlrSnpWV0hk?=
 =?utf-8?B?SnFqRDlPbjdMK1RHbC83L0xyT1RNS2hDQUxkbjAxVmw2OEF2YkZuWjhDMXZP?=
 =?utf-8?B?V05GaUxMR3U1L0RwQnJTL2IwbXdVY2dyZTUyTjd3N0pIUXNHVWZWakFZblJF?=
 =?utf-8?B?VmhVNFJmeTdZWkUrdzNCaGpFNW5MRnh2L0dTbVBmN0NiS280SDZTNGp0QVdv?=
 =?utf-8?B?cjZBNkVSa08wZ2xVZmVlS3VOSVJwcng0djV3Z25DcXFnaWxjSXlGWis5S3lo?=
 =?utf-8?B?aTNwZ0Y4NDlVRU92ckl4QjIwVnFFUUNMdCtyMStiYXh2TW9jNlROdmVCbW4w?=
 =?utf-8?B?Z0dVYXgybFlQK0RxdjYyK1lZeU4rcTl5a2pzNGRjT000eEsyT3ZiT3hIeGEw?=
 =?utf-8?B?NThoeTZ4eTlRUmRnbHNxZFA3UlRaSHpXTUZuUGxEVThNcGF1VmYvd2M3SDJX?=
 =?utf-8?B?NkN5eHV6bGlCdkdGcWJieDdzeGE2T3ROMVZkOUhjckFVUFpSVUMrdzRscHU2?=
 =?utf-8?B?VGdCRkhmZVI3VlMxUWRpb0NRQUFUTDdtb3pTems0aVhBQ29Pbis5d1kvQlhj?=
 =?utf-8?B?ejdHRnVZWWhzL0tCUVR6NlV2cHBMclIvdFRPK3ArQzd2YzJqWkI3eW56dWtu?=
 =?utf-8?B?UjlEd1Y1ME5vQW43T1h3RUdtbTZ2ZWpXbjQ4QzV2dHpoSnBobXgvclMwN2Fx?=
 =?utf-8?B?RThVYmx4L0lCeHQ0NURsSm9OWCthVUpQTXpGcUowZFNEc2ZsYXI4S3IreThN?=
 =?utf-8?B?NWRiNDU3bjlHbDlJVU8xR08zUXU2UmZEWmlsNEJKVGJsZTVKV25jRXlHNWo1?=
 =?utf-8?B?WmVlMUFXTDRUMW4yeVJPQUxJaHVjQzN2azM4QWEyOTdvc0ZlODQzSXZDKzFN?=
 =?utf-8?B?aVMxY1I3Sk1udWJ0dzlBbFhZWkxvYjFodncwZ2NJS0h5QTV4ajRJR3BsUVIr?=
 =?utf-8?B?TEN5VlMzRnM2TG4wYmJnVzZMcHBYREYzVlMvSm0zd3hzUnNHalY2SlZTSEh6?=
 =?utf-8?B?SHdvbWtjQnR5eXB2aHZLNHJ1TUVqRWVTZXFBSWhFWEtZVDRxUVlwRlJUMUV1?=
 =?utf-8?B?N01lam01QVFFMVQzZ0R4UHllQUF6cmhKYVhseStqTzM5aXozb1N6bHZHbzNz?=
 =?utf-8?B?ZWx6cEIwSnFsR2txYU5EekdHVmVtOU1yV1dWcm1xWnJERmxsOENZTzZvWGk0?=
 =?utf-8?B?N3NHclNDR1hjRlhYbkhhODRaZHA1eWhjd291akhKUm5HU1BhODZlaGI0ZXla?=
 =?utf-8?B?NnZaZWtKbWNYcVE1ZlJuMnBwaC9MYlZSVlJPVnM2Vkk0SzZoTVRrSVJ4WnJW?=
 =?utf-8?B?R2N2TEswT3l1VzF5dU41RHVWekxCK3l4bmc4bHcwbk9IMERRUzRZeTVNMXhz?=
 =?utf-8?B?cFM2NXhsOGN0UWkrbnZRY0wvaDN1NW5oWThPWUw5TFJTb2I4b3J0TjZBSDcy?=
 =?utf-8?B?dGJvV1dYMjUyc3BQSThJWmdncUVzVmcvSWFlajErTmJ0NkZrWmlqVHI0N29r?=
 =?utf-8?Q?4wM672RqUSqxK4C4K5TvGg8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12015517-6dca-45a8-05e1-08d9b682ec82
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 17:32:48.0957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOVLsqRBwE2WAsfJyOQFPFAS0UQlu1FSZHr/aDEyZwB1LIfI53SNMQBB2ZAPRvoJiAEFGV8WMZniMimngQ87NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 11:28 AM, Tom Lendacky wrote:
> On 12/2/21 6:25 PM, Lucas De Marchi wrote:
>> On Thu, Dec 02, 2021 at 07:55:14AM -0800, Lucas De Marchi wrote:
>>> On Thu, Dec 02, 2021 at 03:46:46PM +0100, Joerg Roedel wrote:
>>>> From: Joerg Roedel <jroedel@suse.de>
>>>>
>>>> The removal of PAGE_KERNEL_IO broke SEV-ES because it changed the
>>>> mapping of ioremap and some fixmap areas (like the local APIC page)
>>>> from unencrypted to encrypted. Change those mappings back to
>>>> be unencrypted.
>>>>
>>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>>> Fixes: 27dff0f58bde ("x86/mm: Nuke PAGE_KERNEL_IO")
>>>> Signed-off-by: Joerg Roedel <jroedel@suse.de>
>>>
>>> oops, missed the fact PAGE_KERNEL had `| ENC` while PAGE_KERENL_IO
>>> didn't have it. Thanks for the fixup.
>>
>> on a second thought, the fact that PAGE_KERNEL is _not_ the same as
>> PAGE_KERNEL_IO, completely invalidates those 2 patches I sent. It seems
>> I screwed it up big here.
>>
>> About the first patch,
>> 6b2a2138cf36 ("drm/i915/gem: Stop using PAGE_KERNEL_IO"),
>> I didn't notice any regression on the i915
>> side though. Is it safe to keep it? Otherwise we are probably better
>> off reverting everything.

Is i915 for just integrated graphics? In which case SME/SEV-ES aren't 
available on Intel.

Thanks,
Tom

>>
>> I'm wondering why the addition of memory encryption
>> in 21729f81ce8a ("x86/mm: Provide general kernel support for memory 
>> encryption")
>> didn't break io_mapping_init_wc() though as it had already done a
>> s/PAGE_KERNEL_IO/PAGE_KERNEL/ in commit
>> ac96b5566926 ("io-mapping.h: s/PAGE_KERNEL_IO/PAGE_KERNEL/")
> 
> If I follow it correctly, since SME/SEV-ES are X86_64 only, 
> io_mapping_init_wc() takes the ioremap_wc() path which uses 
> PAGE_KERNEL_IO. iomap_create_wc() is only called when 
> CONFIG_HAVE_ATOMIC_IOMAP is set, which isn't set for X86_64.
> 
> Thanks,
> Tom
> 
>>
>> thanks
>> Lucas De Marchi
>>
>>>
>>> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>>
>>> Lucas De Marchi
>>>
>>>> ---
>>>> arch/x86/include/asm/fixmap.h        |  2 +-
>>>> arch/x86/include/asm/pgtable_types.h | 21 +++++++++++----------
>>>> arch/x86/mm/ioremap.c                |  2 +-
>>>> 3 files changed, 13 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/arch/x86/include/asm/fixmap.h 
>>>> b/arch/x86/include/asm/fixmap.h
>>>> index 5e186a69db10..a2eaf265f784 100644
>>>> --- a/arch/x86/include/asm/fixmap.h
>>>> +++ b/arch/x86/include/asm/fixmap.h
>>>> @@ -173,7 +173,7 @@ static inline void __set_fixmap(enum 
>>>> fixed_addresses idx,
>>>> * supported for MMIO addresses, so make sure that the memory encryption
>>>> * mask is not part of the page attributes.
>>>> */
>>>> -#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE
>>>> +#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE_NOENC
>>>>
>>>> /*
>>>> * Early memremap routines used for in-place encryption. The mappings 
>>>> created
>>>> diff --git a/arch/x86/include/asm/pgtable_types.h 
>>>> b/arch/x86/include/asm/pgtable_types.h
>>>> index a87224767ff3..fc9b6995cb22 100644
>>>> --- a/arch/x86/include/asm/pgtable_types.h
>>>> +++ b/arch/x86/include/asm/pgtable_types.h
>>>> @@ -208,16 +208,17 @@ enum page_cache_mode {
>>>>
>>>> #define __pgprot_mask(x)    __pgprot((x) & __default_kernel_pte_mask)
>>>>
>>>> -#define PAGE_KERNEL        __pgprot_mask(__PAGE_KERNEL            | 
>>>> _ENC)
>>>> -#define PAGE_KERNEL_NOENC    __pgprot_mask(__PAGE_KERNEL |    0)
>>>> -#define PAGE_KERNEL_RO        __pgprot_mask(__PAGE_KERNEL_RO         
>>>> | _ENC)
>>>> -#define PAGE_KERNEL_EXEC    __pgprot_mask(__PAGE_KERNEL_EXEC       | 
>>>> _ENC)
>>>> -#define PAGE_KERNEL_EXEC_NOENC __pgprot_mask(__PAGE_KERNEL_EXEC       
>>>> |    0)
>>>> -#define PAGE_KERNEL_ROX        __pgprot_mask(__PAGE_KERNEL_ROX | _ENC)
>>>> -#define PAGE_KERNEL_NOCACHE    __pgprot_mask(__PAGE_KERNEL_NOCACHE | 
>>>> _ENC)
>>>> -#define PAGE_KERNEL_LARGE    __pgprot_mask(__PAGE_KERNEL_LARGE      | 
>>>> _ENC)
>>>> -#define PAGE_KERNEL_LARGE_EXEC __pgprot_mask(__PAGE_KERNEL_LARGE_EXEC 
>>>> | _ENC)
>>>> -#define PAGE_KERNEL_VVAR    __pgprot_mask(__PAGE_KERNEL_VVAR       | 
>>>> _ENC)
>>>> +#define PAGE_KERNEL            __pgprot_mask(__PAGE_KERNEL | _ENC)
>>>> +#define PAGE_KERNEL_NOENC __pgprot_mask(__PAGE_KERNEL            |    0)
>>>> +#define PAGE_KERNEL_RO __pgprot_mask(__PAGE_KERNEL_RO         | _ENC)
>>>> +#define PAGE_KERNEL_EXEC        __pgprot_mask(__PAGE_KERNEL_EXEC | _ENC)
>>>> +#define PAGE_KERNEL_EXEC_NOENC __pgprot_mask(__PAGE_KERNEL_EXEC       
>>>> |    0)
>>>> +#define PAGE_KERNEL_ROX __pgprot_mask(__PAGE_KERNEL_ROX        | _ENC)
>>>> +#define PAGE_KERNEL_NOCACHE __pgprot_mask(__PAGE_KERNEL_NOCACHE    | 
>>>> _ENC)
>>>> +#define PAGE_KERNEL_NOCACHE_NOENC 
>>>> __pgprot_mask(__PAGE_KERNEL_NOCACHE    |    0)
>>>> +#define PAGE_KERNEL_LARGE __pgprot_mask(__PAGE_KERNEL_LARGE      | _ENC)
>>>> +#define PAGE_KERNEL_LARGE_EXEC __pgprot_mask(__PAGE_KERNEL_LARGE_EXEC 
>>>> | _ENC)
>>>> +#define PAGE_KERNEL_VVAR        __pgprot_mask(__PAGE_KERNEL_VVAR | _ENC)
>>>>
>>>> #endif    /* __ASSEMBLY__ */
>>>>
>>>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>>>> index 3102dda4b152..4fe8d43d53bb 100644
>>>> --- a/arch/x86/mm/ioremap.c
>>>> +++ b/arch/x86/mm/ioremap.c
>>>> @@ -243,7 +243,7 @@ __ioremap_caller(resource_size_t phys_addr, 
>>>> unsigned long size,
>>>>      * make sure the memory encryption attribute is enabled in the
>>>>      * resulting mapping.
>>>>      */
>>>> -    prot = PAGE_KERNEL;
>>>> +    prot = PAGE_KERNEL_NOENC;
>>>>     if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
>>>>         prot = pgprot_encrypted(prot);
>>>>
>>>> -- 
>>>> 2.34.0
>>>>
