Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32447D5D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbhLVR1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:27:05 -0500
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:56321
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344330AbhLVR1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:27:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqkTQQmlQ/D3/RZ8UC7MslDtJJxM9fkUPP8wFOSIHlZX951o3x5V6D3wXTLBEqA4ZpV+IKaFs9FhmUaVs8ywxafoF+tG7DQD0OvdmlRcPCo3JWrbg9QnfXBAmAUvbFEEmptgIr72ruQq4KCaPuY5yINB+VvAK9ILXDt/jjEimyp9SuIKOQUvzOzxLoFB4M9D+GTczw2alHEiiFmKv1Q17u5cYXsryJBTO+DwE1WusLB8u8eB+i0W4q7YyAZrFxsKkbuRIETSQFKUSjfjNoDWJrXCdf5fnZmO0VAwuSTKzFplwj9UW/cuBSX67lKJrBWhTzJx/rYpd+pnvCiUN7Pl4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvnAYBesZ3Ft02//zLu6VEvyA2WELrdSvZYNlCFaBFI=;
 b=O2gKIRIDhyYsn1dFSuepo9qTfvYHTSeO+gFixaTVbxzB0APQKyMSn3RWo6oiXepZ+LUE2fIzqWluKpPVDYnnKjaYEmoe2KtVME5CbRnUZM78xsOBhAW5bTxTJ8wNYTIqE1KMfuGL6rabMbmwiTQJcw/BWBc+bcQ0ewT7y01Cisb2/RqPvxibihaN+z74RCej4SltUc0/7WepP5iD9aSL2uhu+A8LDDFgJDuV6Fy751J5tCL8mX2xTY3r8eAOb85MecXpy8u6Y/IzXaEbfl1jjIF0VYsMFCZi36idfpNgmMrfvI0YZScXp+anjfhqQcmQhRyDRoQpNF8h8uHH/V9xqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvnAYBesZ3Ft02//zLu6VEvyA2WELrdSvZYNlCFaBFI=;
 b=A0tAk+g/3anFiS1p1ACJ31h4lcGvY5CfWKPtcpsP3YFOW77VOIc0df0+qTV9L3BeSLXpwRwwlxK8lN0R04r6A7F7vZzLsANjLK0NnxU6+YRPMBCAg3IfrRLxqqWZUgnOX/tQhVMEF+drXbXn1vhoxXL9rl4+rorql5kxwTjtT8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5568.namprd12.prod.outlook.com (2603:10b6:5:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Wed, 22 Dec
 2021 17:27:02 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2429:24de:1fd2:12c5]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2429:24de:1fd2:12c5%5]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 17:27:02 +0000
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-20-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <87c288d6-9bf8-5a94-a628-1e0aaa7de690@amd.com>
Date:   Wed, 22 Dec 2021 11:26:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20211214150304.62613-20-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0170.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::25) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e65a88a-761a-41c1-e9c6-08d9c5704467
X-MS-TrafficTypeDiagnostic: DM6PR12MB5568:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB55680F8A5EBF42EA3906D951EC7D9@DM6PR12MB5568.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhwXXKJnDEO9mpjCv+o6/YYu1FYA9NE8isXdgAoPaXFwEOvrkeHPKSqrgi008EMMqhCpwZc5m/15xIel1E9e3yEN6i5TjaWZtN68yO5aW2DT+CrOTWeBhi6/UyRh/mSsNi9eglwUULNDvq6Cl9jxGA5G2/+QNrwnRkHGHFWlID8vFPSmCf5JwPESnyJ26qA6cBVzFRj9Ma4JKGPKELiQPlfuuysb4G70+X4/XBoupBW1SglGxoNwpjkcPoJxni3cJprzbcrVSSpAFouLbXj/aZDbxhfPrm8Oy/Xd58gEWscfDCHki8u7iTuE6qhna7nzYsP3+ZPdT8XP9LXEGfkPh1jeB00+cG1z7MXvvS/3nPzMKyJvbO24QNI5aAfZuv9dHgQCNihDqiPhot+gCToguhktB0A17QIB6VndZkZ2mR0vpyBTyyZtbabjtAMf8Ix7TMrtKoEkg0RPYdVrpDfrQyaTdpOnwfZ4oNGRsisRarftIcygkhkpovzv4jY5Lkjb8Fp3PPEXUgHvz4RvepnEUZjoF4XeOUivBmIFfiJmyLY7AZliYqhSHcqTBWyzbw5ietfPXRuKHRcbyPK20rNng6L3apuTeWDO0z4ujgciykNpZul4ILBl1mHVsZTb6evcayG+e+HK04i8NRDK4IBcWb4GTEDPL3xLs4E1Tl+1jwlPrHC2uneVyyRfqQ0t/59YgNl1EjBttWkcRHDbISRy6V6KYyrtJ8h5MX2A8O6asO16kI2X71O9O5o6xsMaGsX9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(7416002)(2906002)(26005)(6506007)(31686004)(36756003)(6486002)(31696002)(186003)(53546011)(83380400001)(66556008)(5660300002)(2616005)(38100700002)(316002)(66946007)(6666004)(86362001)(66476007)(8676002)(508600001)(8936002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnQ5VkptaXlvd2w1SmhMVXo0eDduNEsyZ3ZmQWw0ZFVYOVhRejl2NnAxN3pE?=
 =?utf-8?B?dkhDcGZFYkw0ZjkraEpwRmZVZ3VEUmFBU2lYcUIrY2c4cDJvMEh6SU9tWnRr?=
 =?utf-8?B?OE00UzR3WnFxcTdLaG1MbjA5dzh2ZEpkTjRIdWxwR2VsSVlsOC81OG9JellJ?=
 =?utf-8?B?MUp1c3h0aklxVGllQ20rcGlNSVRLWkQ4YzVYREp6OGRyclNyOXVIemlQNXFQ?=
 =?utf-8?B?TVdNRjZkV2ZibnBnUEdhNjh1QlQ5am9NdGdTM3Z3WDRVS1pid2x0MkRlZkFO?=
 =?utf-8?B?OGcyZC9Vc1FHQllzaEcxSzJhZ1RKMkdLSWZQZlZvdTkrVEROWXFjaERxb3BN?=
 =?utf-8?B?VG5iT0ZQSmFBdVhITUVEdHVJYldOeHViM1Z4WDBGeGJqbk4zVzhoaVlZenh6?=
 =?utf-8?B?ajcrV1dpUzBtbDJTNlA0ZGQvWk56S01CUUhzc0EyQjJRV0pqQ1JZSjhwYm5t?=
 =?utf-8?B?VnB2Q1V5WHBIUUIxR0JQdEVOVTRJRGVHVFFud09nTWhhVmdTdUVMQytvK3Bs?=
 =?utf-8?B?UkllbEJFakZSemZEc2VwZkhIWDJ6VnRidEJDbEVDdktQTFNHeTlMeWo0QlVM?=
 =?utf-8?B?UGNSbXgzSGlXQ1R2VmhIcjUxL01zdDF6a0o3d0xVSjQ3cVQrWEM5TTlRQllM?=
 =?utf-8?B?L2VpOGdPZzFaVlNrZ0tsQzA1M3pDZHV3QkVDM3M3ZENFZnVOU3FDWitXdDlF?=
 =?utf-8?B?TWk5VDhrTTM5djQvOUlxMUNGQ2d3cENZUVBzaFYxV2poaVBEZmhKQ1BhcEhh?=
 =?utf-8?B?U3BBREcvdXcxanRUY3VqYUtRZk9ZaXk0cWN2RURpeGY3WDJkRjBleDlRWHNq?=
 =?utf-8?B?S2R0R3BUc1NZdnZybFlqWjdWSi9NUFlQSGdUbWVxMUxBSlRna2F1aFg4Umlj?=
 =?utf-8?B?bWZBWis5N0tXOHdSbDFtM0VFQW43QThXbnZ4SG9CVG9BdjlkYkcvV01CL0h0?=
 =?utf-8?B?dG5icTFSbk1iTTF4TEpHNCsxd3h0dmkrTFdwSlVMcnVxZGFuSDB2U25kejFP?=
 =?utf-8?B?Z2gzRVNyY2FVWndsNjdZOEs1KytSYXpKRHhhdDBWQ2wvaDdQYy9RSWhmYTFi?=
 =?utf-8?B?QS9Kc09zRE1aM05ZK3lhSmhIc2RwZCttQXJHOVVodGlLdFBsZ3RiQ2lkcEhk?=
 =?utf-8?B?NVAvYkN2dGY0WE9kRkFNbGRBRDY5YWZUWlE4enJ1WHRXU2xKTGZLeFBvenNa?=
 =?utf-8?B?ayt4Ry9DMk5NWGY4VFRvUjdzNVZxdnFqUU5UMFVDSWY2azlKalIvenFwTWxU?=
 =?utf-8?B?bjg2Vk5FaXRkODJwUVZRYkFtK21SYlN6V0F3WWFDNVJRNkRtUVNDWkp2ZmtO?=
 =?utf-8?B?bExlN1EwcGx2M2xsYmdDMW1XTkZDeVdxd1hxNUdGc2Q3RFF5Z2lsbnFBSGZ0?=
 =?utf-8?B?d2F2ZjQraUFNQXhKZlRINzFUaUFjdG12MkFTN2w3QXFSWUVsTFltdnh0bFV3?=
 =?utf-8?B?SWxyTkN5OTg2eDdTRFFMRmxmdThZTWZkRnMyZm5qZUNzRlNVNjREdUpKRmkw?=
 =?utf-8?B?c1MxaE80bkxRYjBmODhxQmt5dUw2cjJ2R09HNmtBR1VtMzl5NTZlSGVnZ2Vs?=
 =?utf-8?B?NGs5R2JGN1o1Q2ZRY043RFpoNTFUNlhUdUJ6cVJIZTBhaWxqTkxiakhiMUFx?=
 =?utf-8?B?VTlnS1BzWDY0L0MyOHgyOU9aOGRaOHB5YzdDSXRUbC93amluWjN1aU1kNVZO?=
 =?utf-8?B?L1Vta0ozVGhpVHpyR1BrU3ZvMWRBOHZmVDNQYzJGNDhsOWN1cVFuMVJqVzFF?=
 =?utf-8?B?dVRGbE5jR3dHU0lSb3ZuS1F5OGorQWliQllMdjdYR0ZCeDc1WTJFcnNSZC8v?=
 =?utf-8?B?Z200OVcwdUNXaTQ5ZEl0ZWROWDJSSmNSOUE2bmRodEJ6RERrTUNXdWwyL2dp?=
 =?utf-8?B?Ymtyeml3V3dKVlduVFRlUDhNOUdNMnFpUU5ZY2JYNDRoRmlsY1hOdlRjYUNT?=
 =?utf-8?B?dkhjS0xKSUNTOTlPRDl3UmY3OXR4N2RiR2xKRUZyaWFwQXlFZ1dRUnlWQkxG?=
 =?utf-8?B?Z2JrYU5sOFZrSXU4ZmZCV3Uwa25ldmFCaS9qdTJqT08zeXZTK2xZRGQxUDBk?=
 =?utf-8?B?ZXVSU2Y0VDhuMXNrT1Jub01DUzcySUhKRkhhTW9jYUcydmY2YjN2L3hnRGlM?=
 =?utf-8?B?c3ZsQXhDZmk3U2l2dWRVQ0RuSXg3M1NOYVpKbmJMdUl0UnZWSjVSSVJXQzVZ?=
 =?utf-8?Q?JktgSMRnPBYDBYeCA3p9vFs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e65a88a-761a-41c1-e9c6-08d9c5704467
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 17:27:02.5554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iit5xeufsrr6IknFGngzYV9Qu6xAuLSFKlbbtQQ0viI7hO4oYkrpK597rbKFa2+3Aq5LFYV72n1QcxS3OJzPbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5568
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/21 9:02 AM, Kirill A. Shutemov wrote:
> In TDX guests, guest memory is protected from host access. If a guest
> performs I/O, it needs to explicitly share the I/O memory with the host.
> 
> Make all ioremap()ed pages that are not backed by normal memory
> (IORES_DESC_NONE or IORES_DESC_RESERVED) mapped as shared.
> 
> Since TDX memory encryption support is similar to AMD SEV architecture,
> reuse the infrastructure from AMD SEV code. Introduce CC_ATTR_GUEST_TDX
> to add TDX-specific changes to the AMD SEV/SME memory encryption code.
> 
> Add tdx_shared_mask() interface to get the TDX guest shared bitmask.
> 
> pgprot_decrypted() is used by drivers (i915, virtio_gpu, vfio). Export
> both pgprot_encrypted() and pgprot_decrypted().
> 

> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -14,6 +14,33 @@
>   #include <linux/mem_encrypt.h>
>   #include <linux/virtio_config.h>
>   
> +#include <asm/tdx.h>
> +
> +/*
> + * Set or unset encryption attribute in vendor agnostic way.
> + */
> +pgprot_t pgprot_cc_encrypted(pgprot_t prot)
> +{
> +	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
> +		return __pgprot(__sme_set(pgprot_val(prot)));
> +	else if (cc_platform_has(CC_ATTR_GUEST_TDX))
> +		return __pgprot(pgprot_val(prot) & ~tdx_shared_mask());
> +

Hmmm... I believe this breaks SEV guests. __sme_set() uses sme_me_mask 
which is used for both SME and SEV. With the current checks, an SEV guest 
will end up never setting an encrypted address through this path. Ditto 
below on the decrypted path.

Thanks,
Tom

> +	return prot;
> +}
> +EXPORT_SYMBOL_GPL(pgprot_cc_encrypted);
> +
> +pgprot_t pgprot_cc_decrypted(pgprot_t prot)
> +{
> +	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
> +		return __pgprot(__sme_clr(pgprot_val(prot)));
> +	else if (cc_platform_has(CC_ATTR_GUEST_TDX))
> +		return __pgprot(pgprot_val(prot) | tdx_shared_mask());
> +
> +	return prot;
> +}
> +EXPORT_SYMBOL_GPL(pgprot_cc_decrypted);
> +
>   /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>   bool force_dma_unencrypted(struct device *dev)
>   {
> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> index 63b15108bc85..5fed077cc5f4 100644
> --- a/include/linux/cc_platform.h
> +++ b/include/linux/cc_platform.h
> @@ -82,6 +82,15 @@ enum cc_attr {
>   	 * Examples include TDX Guest.
>   	 */
>   	CC_ATTR_HOTPLUG_DISABLED,
> +
> +	/**
> +	 * @CC_ATTR_GUEST_TDX: Trust Domain Extension Support
> +	 *
> +	 * The platform/OS is running as a TDX guest/virtual machine.
> +	 *
> +	 * Examples include Intel TDX.
> +	 */
> +	CC_ATTR_GUEST_TDX = 0x100,
>   };
>   
>   #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> 
