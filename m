Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C12468BB5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbhLEPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:19:00 -0500
Received: from mail-dm6nam08on2085.outbound.protection.outlook.com ([40.107.102.85]:48143
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235545AbhLEPSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:18:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMHNXnHgkfJHqQ7ZdX/iNY0ob/yL2tBYuDGU/BObMVZX1XdfrvfGgXk1VVTUJSx0QWEWsphgc8uXhjHBEv5GoCadiwuz4KzC0rsfYMoXjbpnPFPVlV9gGGOUoIb6kyMB5NKtkM47u4a13pzu7BPcCRXa6nTDmlvrM/8BeHZuTEUSQ/MGXGuy2mfOPD8fUUa+GLPx6gGXfBsrpckORLTKzCzMoeU88WR2/UIakDH5BaxUPIwRqPv5+Gnup/RISIv/GO2QkT+7Aj3c14IDxfRqlRqxS/2VYf70Y/MgTZCZgI3NRsmXwiQKnPlT9XcnH8TMVqjW8qao3aLOcHymoZG6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khkHWrbJa813oXDBrGIM/UlzNE2cuGL/LHBtvtV0bco=;
 b=d7RtvfaT0y1q1tT9isej9/UXFz8wZ+mXAl605X5l1H0OnywbEfeLz/kOs7P6OQCKTR97F8vhrzaCJscPjr61hudwB5qT+cBGepInOgkHXz3jj0Ckc9rOdqLughiNLY/jymrQIJCnaxSz+W8tRn8W+JiAxOPm0DqLV8pBIQcaKZWFiHMTmPve5Xrp7bThImNffedqHCzahCBKvTlat9KvjgfFWi3GA6AT5lH8qGyk2BkooeaeuLrG1dHh+dol6XfVcp9VVBQdwp7SD2Z79fty6F5ZaX73IATO4qg7jC2DR6WsfYEdS3ZlDs+Pf2BFE5/R2OqEdQpOj/AmDgfaWU6N7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khkHWrbJa813oXDBrGIM/UlzNE2cuGL/LHBtvtV0bco=;
 b=QSWQivyTTcfR4s5bvFKVgCsruu9LGRT1VkpLqs6CL3RRYVMtPpbSwd83ah+6wU1Q4dDIPwDxc/dXZBqTMTsT/fl8TBmmTVBlRdNZaknHOHyU0s8jyY9pRFq+EaUVBrepWir5+VlztFsA8F/tJO4uRBHr5p/K4PL6CfbOimINmM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Sun, 5 Dec
 2021 15:15:18 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.028; Sun, 5 Dec 2021
 15:15:18 +0000
Subject: Re: [PATCH] x86/efi: select ARCH_USE_MEMREMAP_PROT
To:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211204174156.977245-1-arnd@kernel.org>
 <CAMj1kXGj=AGp6im71+OETHGSCat0mQfOf7FcDdyKwxFEBubzdw@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <120102a7-3c03-ce36-198c-f60f059a6cf9@amd.com>
Date:   Sun, 5 Dec 2021 09:15:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAMj1kXGj=AGp6im71+OETHGSCat0mQfOf7FcDdyKwxFEBubzdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0019.namprd18.prod.outlook.com
 (2603:10b6:806:f3::30) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from office-ryzen.texastahm.com (67.79.209.213) by SN7PR18CA0019.namprd18.prod.outlook.com (2603:10b6:806:f3::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend Transport; Sun, 5 Dec 2021 15:15:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a082944-55ed-45da-9419-08d9b8020bee
X-MS-TrafficTypeDiagnostic: DM4PR12MB5264:
X-Microsoft-Antispam-PRVS: <DM4PR12MB526459279A25ABE37128E6DCEC6C9@DM4PR12MB5264.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knLDuJCIjNkTvSJpe3z0PixhrijuPCaKsT2VmhcTgJQCoNg4XQh+8a+yq+lVP15Ze4L+U+Qs4COJxm5l+KQPnajoVjonVgv3niUFHhadmJSGF8M56FZON4Bj8LzFR/UCc1TdwiQRLqgERF9BBoCh506JaS0ZUfuelRM5gf0G6zRzo3B2hiIacn4EFZUaRqr1vWeSZ6coxMu4pKwZOU+kMiWoNdqHz4eJ49pHzS442g1pkevKUk2NCzlEhhXX0WZUJjw7e67wI9uThuzP0FDQ781sL5COuYsHRFE9OMfScApeFdwxqsup9SQhVgYvB0FpkiYkCSpixFkYKr0ZpukP9f9OueMsm77apdHF3an0H9wh7b/Jc9iE22C6ZX2PXPeF6EVtlc5kaeZvVy0qG4DAFLr2NQktH+KW6hZ2LbqyQ8yZCQ6hfa6qXMye9SobWdrARAMGsjOAM6xRTpDFPkn01msmUTV7lj84vOwX1Ub2GkxC+XZITZ7WRjzQ5m3GRz1kT+vQmykmlPfMzmuC9vCdp+k3QHvFru3MMseOvBpYrO2njv1qYTWCjBWk+0SDBX6kIAA4z+4wO+ioWMeHIsA4luit/gGLsixO3yvXMj3osk/kr/CcTowX/8Q2z/9rRMcWumAokTvq8NO0ONxOdMsX8ZIkdX36BCK9tRC3BzpT/w6sPrq6u0UcjiQ13yhbfAvjQ8cFmO7kay7aPG6/ZL8WTtc8tjWY89SUWjqiCIm+JFFMhCDc1ak/EK2f9nQ3mTif
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(66946007)(4326008)(53546011)(508600001)(31696002)(2616005)(31686004)(110136005)(66476007)(8676002)(186003)(66556008)(36756003)(5660300002)(38100700002)(6506007)(7416002)(316002)(83380400001)(2906002)(6486002)(6512007)(54906003)(26005)(956004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTBXQ2JKZTlxWjVncStiY3dWc3FJbStKUmN3YjNwTG4vcWNqbFJabzhkZmtJ?=
 =?utf-8?B?WEIvSGtNa3hlSVNGNG9qN3BCeHBiK29SbnNDYTFDSWc4ODJTMzF6NlJUckww?=
 =?utf-8?B?RW1RTFBpT0JMZE5VZklJLzdYS3l2WGo3RTJIRHhWSXhaZmExVjlrdXFKNmhm?=
 =?utf-8?B?ZHNOb2VXRStuNFVHejZuMnpDQjZVcmg1eGFQT2M0UU1XU1F5Q3o0ODA3Qmdm?=
 =?utf-8?B?dnRZZmM3blRkYzIxTHM4K3JoRmtXQjg0bmVuSXR4alNaQ3hyRFhwVU53NExw?=
 =?utf-8?B?Ti9DbUYvdjlkUkhzUXZyS055QmF1TExEeXp5bHBUQjREREk2WmN6bHQrUUNu?=
 =?utf-8?B?ZlNleC9sU01tZzdTU0hydzBIeVVTMEZDaFdreXV2WHNXb1JWTUZTVXI3dUcr?=
 =?utf-8?B?b2hOWmNselkxTGlPNEhMREVHK3hCRHh5ekdWS1FjZHE3d29rWE92ckxBckJM?=
 =?utf-8?B?ck1wZnN4U1BleVZjcm1Bd3dpQWRrSWU1NVBPS2FuNVJrQktQNjVhaWNZSG84?=
 =?utf-8?B?anVpRHpuU0oxRlcwVWY5T2hvcnRkTTNIZ24zTzZ1ekIxRGw4Zmp3NUZHS0Ex?=
 =?utf-8?B?MmFQcHFzM1Y0R2p1V0crT0JjWGF3VGtHQnp0YUJpbEttZFJEeWZCNXRUK0xt?=
 =?utf-8?B?TkdZcVFpbUVlREpkUWRGOGRYUjBQUkh1eEtWZy83aGhuUHM2Y2pXTWhhTjlT?=
 =?utf-8?B?MFNmKzlmMEF4dWlhcE0rUHRkOXpld3BxcnUrZ3VaQTVNYWhhSFdmcVVsYXNk?=
 =?utf-8?B?WVpYNlBUS1I0blRxcmZpK21oNkxLQXRwOHZ3ckkva21ETjJ5SER6aHdpQVZs?=
 =?utf-8?B?WWN1NWpvQjBBd2Q3bDhoVU1JSXdrZEN3SnVBR2lOQnFheGdMTWxCblRPVis5?=
 =?utf-8?B?T0QzMzNpY1htZExnNVY3d3U2elFLRXBMQU5KRWx6T1JtZk1uQ3FRaDJ4RnJh?=
 =?utf-8?B?emNVeDA0WForTHR6US9uUGtrdUtFZ1AvUndCWUxlbEZqcU9McWJrLzJZQXh5?=
 =?utf-8?B?MnFJVE1TUlBLcWxtMVgrRFI3dkpXTUVpSGhLVzN0SWUrSEpJQUtpTFZUNjZN?=
 =?utf-8?B?ZUljWGNjSE1LUGVkZERuaHNjUEVyZjJPRm9jMkk1aHR5T3Rndktpd05ZVUxX?=
 =?utf-8?B?bzJLMzBMY0tud0JacUJJTzU2M3QzbVNxeTFZTmtMSmtDZVlUV1dGK2ZtdU1L?=
 =?utf-8?B?YXg1aTg2cWVTaVFLcUM1NXdnY2Y3SG5qK2xWcGhpNGFsUHYwQjV0UGhsOEta?=
 =?utf-8?B?VitWMVVMQy82QjN2U0ErTE91VU9rTkZBT1ZHd09EMWVzTEJnNExSWjlwM0lZ?=
 =?utf-8?B?Y0xKZkxUZUQzSlB3NzdNTTN0dG1xZFR4UDRaN2JRQ0x4UnVEeFhnSHhZakY5?=
 =?utf-8?B?VjlmSmlDbTltdnA5dHd3MU1lNWJyQk9WZU03UlVaTU1OZDBRSWhseGE0MzJk?=
 =?utf-8?B?cG4rQ3d0RkxlcTRLd3RUOEVqeWtQdmc0U2JJeTh2bjNjc1Q3bnBZVmwxQ1ZX?=
 =?utf-8?B?SWd1RmlPNzlRYlZ3aEF1cWZNS01QWTJGRndKRlJoOWhCT1NoTFdUa01USCt1?=
 =?utf-8?B?aEJsbVFLdCtNczRFbDhnL0VsV0tzTVpuK1gvVWdCREZkU1BEaEhqdk9aM2sv?=
 =?utf-8?B?NDZ1eGFrR1RzYllnOHlqOFR2SnFBSWxheDZYU3BMNkMrSTRXbnNtQk1wb0xl?=
 =?utf-8?B?UzA1ckd5WGxwcndUTDZnOWoxaEQ0bjQ5dGlDQUdUK3RPaXp5eVBVQkdHeFhw?=
 =?utf-8?B?Y1hnZWQ4L2NUTlpxQ295Uk11dm5ndTRLVGRSR0pXNUhWRVU5ZER5VFZBcWN3?=
 =?utf-8?B?RTFvRXhLVWxHc3o2MzJQRXFvRzJQUmQrcUZ0czU2SENIZVdqNFg1TE1rQ2Zv?=
 =?utf-8?B?dFA3dDA0djZmRWhha2hOVE1pRU0vZlFML0lHci94dGxQeGpXdkl3cjExN1F5?=
 =?utf-8?B?MXhiSG1QV1RUV2R6UUJwV2tLckY4dFNNRXAwSlBTYmNjQ1NLdTVOblJQak5u?=
 =?utf-8?B?OWNzT0puU3NwN2JLbVU3cTVIQ1h4OVZ0WGg0L296NzAvdjRRTUUyL29HditH?=
 =?utf-8?B?RXJrZEpqUEcvbmxveDFhNzNEMTNTTWUvVXBScUxSdDBHa3hjYzQwWGpXTW5M?=
 =?utf-8?B?Mjd6anlJTGpUV2pTelJ1bCtZaFBFb0ZNeS9qTkdtWkpCY3ExUTd1Q3hvWkx6?=
 =?utf-8?Q?uJydGMX6/1UhwMO/gOTanc8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a082944-55ed-45da-9419-08d9b8020bee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2021 15:15:18.2233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIFCBvgB55DhCMJSx/ZpFi8pkRlx2h34Q2Sgzvk4JS9INinHROXpnPa9clmUFFRKsPZP+WpOwa1c03f2ymQBjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/21 11:55 AM, Ard Biesheuvel wrote:
> On Sat, 4 Dec 2021 at 18:42, Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The patch to map the EFI memmap as encrypted introduces a
>> link failure in configurations without encryption support:
>>
>> x86_64-linux-ld: arch/x86/platform/efi/quirks.o: in function `efi_arch_mem_reserve':
>> quirks.c:(.init.text+0x127): undefined reference to `early_memremap_prot'
>>
>> Select the necessary symbol here as well to fix the build.
>>
>> Fixes: 8f1dd76c9b55 ("x86/sme: Explicitly map new EFI memmap table as encrypted")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks for the report. I'll fold this fix into the original patch instead.

Thanks Arnd and Ard!

Tom

> 
>> ---
>>   arch/x86/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 05362527f6b5..93befe25d787 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -1934,6 +1934,7 @@ config EFI
>>          depends on ACPI
>>          select UCS2_STRING
>>          select EFI_RUNTIME_WRAPPERS
>> +       select ARCH_USE_MEMREMAP_PROT
>>          help
>>            This enables the kernel to use EFI runtime services that are
>>            available (such as the EFI variable services).
>> --
>> 2.29.2
>>
