Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FE646673F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359236AbhLBPz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:55:57 -0500
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:11744
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347568AbhLBPzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:55:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMdaDI2rfbqq80cbTE5r436GBVQOIEZEsP8bF9zfeCKkQV4XNiKTgpcEbL84S/+RQOZM6wCoZ/Cc5yzv585UEKb8ETyCOvdHSSkBqyTS3XOdI4qArCBa2zMjrNlfyGhfh0jXe1cLgaYRAhuAt7sipTm0PL9FlG8FjP3BzGx/OOOSlRyAeCM+miaYhxtkddjr/tkYlix6cYxRiFl5EKpKFwJipf7Cpf2Q2Wj00aEXVSHs1xgRMciDSEOpw+TkEt1R3McpCE8ET09G5zq7P6IQzmqXeMhe+n/Cr6rUQMXFdhUpTwUcebDrzZu8yVmJqxnNv/fEd9o491cg+oAJaKBrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbKWfdyzqTBHtMN4ZYh2ucNGqt7Tb6KYO1nORQsgiSI=;
 b=LqUb+xkBzcqCHm0M+ri1Wfjqd1V8kAVE9Z+pwCJUnk+lZFGoSlF0rSBZWq5h8Ey97s+PK3/wjKxiiKzuTAVeQG4jwIZrNjUrzEEbxXc10L3kleOYr4UAG7C2GHgkUex1uMuhBjYU+WBmYkNlFp+ixUb+99XSqvNF1+e3JUPxS5K9tP+hbE3LGkM1QDfHiz+VxAJR8ywkoklGSU5Iunnzh/e9HZ1qZZnn67IuQQFubiWiqbQm4pF0OiPoI7aC7jNll6UMmmVBdxCNDfoqJbWHlg72sr2zr94eNdPncVUzb2VeDlvT1hdXioJqUfzzNRw+1KgZ4l5gSb4aTBPm2nferw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbKWfdyzqTBHtMN4ZYh2ucNGqt7Tb6KYO1nORQsgiSI=;
 b=aniVHVYsAJtbpmNSiV9NbhWzZfyOPZLxiLF2y5PILLtJlA6VPzJI/witF7XoXYtMvcVs/NL13td6cLbHLmm1dsKyvjOZdOTzVTW/a6rIHl8JwZTPLO9mVKerzbRxJcxL18+zoc3sYPjz2Hn+xP+uJIMfGoKPdAG83PlLOw+Zy5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5479.namprd12.prod.outlook.com (2603:10b6:8:38::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Thu, 2 Dec
 2021 15:52:31 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.020; Thu, 2 Dec 2021
 15:52:31 +0000
Subject: Re: [PATCH] x86/mm: Fix PAGE_KERNEL_IO removal breakage
To:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>
References: <20211202144646.23186-1-joro@8bytes.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <a155df16-ce8f-e884-221b-c3ff9b11eca7@amd.com>
Date:   Thu, 2 Dec 2021 09:52:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211202144646.23186-1-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:208:329::32) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by BLAPR03CA0087.namprd03.prod.outlook.com (2603:10b6:208:329::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Thu, 2 Dec 2021 15:52:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdd6f352-b579-48e5-9cbd-08d9b5abc015
X-MS-TrafficTypeDiagnostic: DM8PR12MB5479:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5479EDEB5158B0EA54E6B47EEC699@DM8PR12MB5479.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1CBb55E2qWyprrl/AsDfr1d6ev3KMLfGYknJScLpHglE5QOHX4Xlz/7ypeRx1tgGbEovG4MzR/JqWYHYrEAWuoypsRnB0dCdFx1pXfRSd9lSeNr6Uvjp9XlCybOgca4FzpOnUSoFXRLHHlGJ244p+B0a7ETKK5gkNlXzAj9/pJhnG+7t0WgZYiYWrEkCi6vDb1IaIqDyIzCo/OrNqGP1ZlBCnKzcaQPI6+zyOFwxTo55EpammyVkOQakU1tDnBe0CHeQtADL5NvTKU0EJe241lFh7a7byT31+kmle+Jf4uBysBnEB/+h7+J/hmLdsGlAEViRCcZTjEuABjjTpNjdJUl7RpKY3zg6G4iJTj6rYeo5dtLDJcBaPX+QZxsj5ybF7ez/9Aj2tX/HOO0/Rrvni8vppkSbYIIk3eIbqDyq4+5hfalk7RuLLnZeaoEEIrrkWDCR5q9nMrGlxNw+5d9QNacdL61MRyEUuwGbq9RnVh6Sf+HKzSip7cb1haCDAtYeQZAU3B+Zf/8z9X7/8+zlJKVklo4G3DwucCRVrhV7Ftowgkh5JIp2N2gAvAWzXEFX5OkS82tY+F2dKAyMvqr3Xru2ep0mm/u2RW4gDKfjb7RvrPdKCa3L4LEXzKFTsAvCQEb1E3j0NdFja7+IoLSWCtBcOGLsWeDaeJrbvA32j43guk4C3S+/XSVdJnI5rGgql0RgtorvsYGwK8AVV8eC9fTS2V63CHr8+JR5/i8C9Bp6+40btqDVRQH4ehNiuEPY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(186003)(6486002)(86362001)(7416002)(2906002)(54906003)(16576012)(53546011)(31686004)(110136005)(38100700002)(2616005)(956004)(36756003)(31696002)(316002)(66476007)(4326008)(8936002)(26005)(83380400001)(508600001)(5660300002)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlBKdjFWdk1KSDVtSUtWZmNOc28yRkVlVnZWNFAyMlJuWlNyMk1NWm1vWXZa?=
 =?utf-8?B?Z2FBSkI2QTVYNzBiZElRQWRWaHM2ZXdESHJUbGowM0ZiMUVhVll3Y1F1N3Fa?=
 =?utf-8?B?Qzd2d1owY0lyVG8xTldyUHJiak9HbCtadm80dFY4ZW9EWW5UZ2hNdGlua21I?=
 =?utf-8?B?NVBGNWorQ2ZYdk5hSTc0T052UXpYVXRVQ1crbThrNnRORjU2WjNweXhaRVlk?=
 =?utf-8?B?aXFpN2VkZENXb0lGc1lLNU4wVWRNT0VNdDh6clBwNWRxZTZYY0tHam1OV21I?=
 =?utf-8?B?TnJvUjFuUXFZZFo2RHh4aktXZDhpVlU3RG9kMFFZU2hZWjhUSXdseFJXUWJz?=
 =?utf-8?B?cTJENkxycHo2Nit5WEZvSXYvZW9KSFZWWWsvM2NFTGgrYWNua3ZrakhVeGtn?=
 =?utf-8?B?Z0tXT09QVklCMGtyZi9JU1VDNEdoQWY4TjQ2OWI1VGFGMHg1YzMvandyaWtV?=
 =?utf-8?B?cytSQks3V1hxU3cra0huOW92TjhyRThKU052cUJzTGI1c0NuYlAwaGk0L2Zs?=
 =?utf-8?B?KzE5Z1pVSEkya2JCQWgvTXZGS09XU1lxRHRlZUdKZHZXdk9JTVh5WkkwdEZy?=
 =?utf-8?B?ZU5QNXkxQzZzNzZHZUs5STI0N3BsZlZpSHNFTVgwNVROTkMyZysrMlgwMjBL?=
 =?utf-8?B?ZWI1QzVjLzluWnFvaHZ6TlpCSDJNbW9oUXB0QXpqSjhIWThyeUlwRDVQcjNR?=
 =?utf-8?B?dzFBVFJFMjA0dXJUQzQxVDlVK2N0c3ByMXJKcm5pR3B6aEZKOTFDYXpaOTlv?=
 =?utf-8?B?QnAxQ2pwTmIxY0hDSXU2cDdMYnMzV2t4a3FVR09iVWMrdlh5T0w4b0FsNGNz?=
 =?utf-8?B?WDltSEY5cUkzSFJLRERZSkxIME9OWHk2NjNuaHY2YUVtZ1dsbXhvVHhXK0hq?=
 =?utf-8?B?T3lxM3VlN1dYZWdjQmRWb1kwNlZ2SS9jRTdMWkFxLytWRFpKZEo4VW0wMWFo?=
 =?utf-8?B?MElmN0F6MHowYW9WUHJ5TDJkTHJ0NzRzdXdIUXlsWEQ0c2RxUEw1ZlkvQ015?=
 =?utf-8?B?ZWVkQTVOWmtEZkltR29PUE1zUmxUeHRDZmJXUWdYQUxKTE8yL3BjQ2tjQXIy?=
 =?utf-8?B?eEhrU0VHS0t0enppdDZFaWdENnl2akdXdnRvUno1MVQzejArRnl5SDB5NDIv?=
 =?utf-8?B?V3JOTFVDbW15ZittTEt5RTlsZ29HMnRlWnVtTC9SSHY4K1NPeGc0NHk3dmN4?=
 =?utf-8?B?OFZaRmxaSHNLcUI0S3NHcTB2RHd1bDFVU2lSVTd2SEVYeHo4dVlJYXhzSjhC?=
 =?utf-8?B?eUphYTZZZE85R0NSbGxUWGRXRDFseXdMeWsvREpTWGJWdFlwa0sydHNIc0ZW?=
 =?utf-8?B?RTgxTnl1bzNwbVBaVDVBV2tJUGNhZ2VDWTNyYytmZE9xUklpanBqTnBaWWVV?=
 =?utf-8?B?SG5DR2tOOUpxeHhocXRQaVhRUC8zRGFGNjk2K1dtckQ3MXd1VXpObHI4c1dj?=
 =?utf-8?B?TFpNblpjU2pwRnZ1S1BLTktlL3ZVT3U4UXppYVliZ1BZdnlucEJpZWVYbTBv?=
 =?utf-8?B?V05SZVkyYmtCS2RudGt4SnBiK1dwU3dCWG1qdWFnaUJScFgrK1FBWUpJSS9v?=
 =?utf-8?B?WWZyajRldmVSUlMwcVluVDNvVEVNeFl6WjR0dHdsQkxCS3NVWHByVllFeTBX?=
 =?utf-8?B?MjlYTE5wTkFsVzVNY3NnYm1jUk1Kdk0yYVhHYndFQWFPTUt3U2w3eGFLcjdS?=
 =?utf-8?B?cC9adWJOSDd3S2RIR1pURVlEdzM3OVdDazBNQmpRNFhMYklCVU4rdUROTWlN?=
 =?utf-8?B?NC9CUkpSUy91Nm1qTmZlS2Q3dERuT05xSExaU0NuWTdXeTN0NUROZFlTWTIz?=
 =?utf-8?B?MTlGODVObzJrV0tnR0VMNGl6dW1PUmF3VnplRFlhL29WbEdMK0hsRGhFYUtY?=
 =?utf-8?B?cHN3M3JHdUl0L2s4YU5sTnJOaHdMaFpCVUFkY2lqUHFEaXR1Tk43bFJ3clFa?=
 =?utf-8?B?NkxoOEdQYlBOcHUvejZCaVdWM0NKcjZXMDN3NlJJZ1Mya21QUFk1ZkViVXZZ?=
 =?utf-8?B?TmpyRVBORHJnRXBVVXpoMXNHUWpnQU5kaklTcEIxNFR4MHgxbm9kc2htd3NR?=
 =?utf-8?B?VXRWNUlNUTRuL0FlVDl1Q0l2Rm01NHBKY0YraDdua0wvMEpkMHlpWk5tdG4z?=
 =?utf-8?B?MEhMelZrRlNKZ25valFqdVA3OGdpVGQrWTd2S0VEUDZsYzdLV0xCNWVxZGkv?=
 =?utf-8?Q?hUFGlgkyMqMCsoCBYTwZQmI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd6f352-b579-48e5-9cbd-08d9b5abc015
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 15:52:31.7706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cC7XFuCFY+2sFfPsxAnuoeax51AetmY6onhcBIowg3I21Lqa9nMMlnsczeCcesWhGfZYzfBYHE98oIzmLo2l+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5479
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 8:46 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The removal of PAGE_KERNEL_IO broke SEV-ES because it changed the
> mapping of ioremap and some fixmap areas (like the local APIC page)
> from unencrypted to encrypted. Change those mappings back to
> be unencrypted.

SME was also broken and I can verify this patch fixes SME, too.

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

Thanks,
Tom

> 
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Fixes: 27dff0f58bde ("x86/mm: Nuke PAGE_KERNEL_IO")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   arch/x86/include/asm/fixmap.h        |  2 +-
>   arch/x86/include/asm/pgtable_types.h | 21 +++++++++++----------
>   arch/x86/mm/ioremap.c                |  2 +-
>   3 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
> index 5e186a69db10..a2eaf265f784 100644
> --- a/arch/x86/include/asm/fixmap.h
> +++ b/arch/x86/include/asm/fixmap.h
> @@ -173,7 +173,7 @@ static inline void __set_fixmap(enum fixed_addresses idx,
>    * supported for MMIO addresses, so make sure that the memory encryption
>    * mask is not part of the page attributes.
>    */
> -#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE
> +#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE_NOENC
>   
>   /*
>    * Early memremap routines used for in-place encryption. The mappings created
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index a87224767ff3..fc9b6995cb22 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -208,16 +208,17 @@ enum page_cache_mode {
>   
>   #define __pgprot_mask(x)	__pgprot((x) & __default_kernel_pte_mask)
>   
> -#define PAGE_KERNEL		__pgprot_mask(__PAGE_KERNEL            | _ENC)
> -#define PAGE_KERNEL_NOENC	__pgprot_mask(__PAGE_KERNEL            |    0)
> -#define PAGE_KERNEL_RO		__pgprot_mask(__PAGE_KERNEL_RO         | _ENC)
> -#define PAGE_KERNEL_EXEC	__pgprot_mask(__PAGE_KERNEL_EXEC       | _ENC)
> -#define PAGE_KERNEL_EXEC_NOENC	__pgprot_mask(__PAGE_KERNEL_EXEC       |    0)
> -#define PAGE_KERNEL_ROX		__pgprot_mask(__PAGE_KERNEL_ROX        | _ENC)
> -#define PAGE_KERNEL_NOCACHE	__pgprot_mask(__PAGE_KERNEL_NOCACHE    | _ENC)
> -#define PAGE_KERNEL_LARGE	__pgprot_mask(__PAGE_KERNEL_LARGE      | _ENC)
> -#define PAGE_KERNEL_LARGE_EXEC	__pgprot_mask(__PAGE_KERNEL_LARGE_EXEC | _ENC)
> -#define PAGE_KERNEL_VVAR	__pgprot_mask(__PAGE_KERNEL_VVAR       | _ENC)
> +#define PAGE_KERNEL			__pgprot_mask(__PAGE_KERNEL            | _ENC)
> +#define PAGE_KERNEL_NOENC		__pgprot_mask(__PAGE_KERNEL            |    0)
> +#define PAGE_KERNEL_RO			__pgprot_mask(__PAGE_KERNEL_RO         | _ENC)
> +#define PAGE_KERNEL_EXEC		__pgprot_mask(__PAGE_KERNEL_EXEC       | _ENC)
> +#define PAGE_KERNEL_EXEC_NOENC		__pgprot_mask(__PAGE_KERNEL_EXEC       |    0)
> +#define PAGE_KERNEL_ROX			__pgprot_mask(__PAGE_KERNEL_ROX        | _ENC)
> +#define PAGE_KERNEL_NOCACHE		__pgprot_mask(__PAGE_KERNEL_NOCACHE    | _ENC)
> +#define PAGE_KERNEL_NOCACHE_NOENC	__pgprot_mask(__PAGE_KERNEL_NOCACHE    |    0)
> +#define PAGE_KERNEL_LARGE		__pgprot_mask(__PAGE_KERNEL_LARGE      | _ENC)
> +#define PAGE_KERNEL_LARGE_EXEC		__pgprot_mask(__PAGE_KERNEL_LARGE_EXEC | _ENC)
> +#define PAGE_KERNEL_VVAR		__pgprot_mask(__PAGE_KERNEL_VVAR       | _ENC)
>   
>   #endif	/* __ASSEMBLY__ */
>   
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 3102dda4b152..4fe8d43d53bb 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -243,7 +243,7 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
>   	 * make sure the memory encryption attribute is enabled in the
>   	 * resulting mapping.
>   	 */
> -	prot = PAGE_KERNEL;
> +	prot = PAGE_KERNEL_NOENC;
>   	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
>   		prot = pgprot_encrypted(prot);
>   
> 
