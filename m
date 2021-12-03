Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6378D467D10
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382504AbhLCSTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:19:36 -0500
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:7265
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1382497AbhLCSTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:19:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZP6UoORtS2Xdxy4kDkIQZ4T5jRfwXZxzlCcbxrIfZcPLVKzbbComXEZLVz2RiV2bQpz8fvtsLphZzSdr5sjLYThvBNOyEJTmsjV+cUnjeCpu0gt6UwkH0SHhDUAa6s1CgugmfL7q7/g3NnL+tIJhzD4Qm0JMg6t/27XRaghgLYQ4hZJpUPgS5CqW717AlXd2NkOu9pAxtAG0jedJZMnGrWRn6WKBkLWae53OzbkoWsBSqxEKPj61HFHjywIKacVMLJzra44qfWlLBhy+GLo6AHNP1XjWBNrVL1JqP0QnQs5Qr3cP9+UiXF9fhnmnX90tKu8wDw1FZUs79Q6j8Rzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSNZbReYDpcqZ94271wJDx+ELhVuEXbcpKrbhSDCokg=;
 b=N62s8+86Du5ACtDGsYM/57gePbl9PwHDYNotH6NCRj0Gh26gB62iipDqWHe4lCRqfEfqvdBxNo0eSLO4FwV2oj58xCJWji0BYYmjxlGFpd5Z0XSQm0jAUR9nniPS02Yq5RVhRJaQIIqfUNqN8epyetVwnOtccM+kGcF6GDNkyYlJLYnM4j+k7hmt2SBaXH4zIRmyf4BRCPGlPx2GgzVYg6uLYf/VIeQdmSUHLndARzWKWKXtPgGRAVgFd/6OKGdh8Dn8PuF7cc3iXUa4qTj2TJK6MurvCns5S2N0sv3MGwrLOjSkMoUX9R3sD4kIb3NJudz9Nl537sedfKwc/uirOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSNZbReYDpcqZ94271wJDx+ELhVuEXbcpKrbhSDCokg=;
 b=e9yKolKEBwQkK7v6xSbLtWK6Qk1Mbmorp7wKUcTLgfFWDShpPl/cGjeILq36+eXvzuCKHgzc8K/aNLTjxkpybU0oAYNSVx6wYNXl5gWpoC96NFecRn9LkZmXBNDJoa+8pASrgxRBhQfyvpcdzF10LXoC4BpPq8KisUzjY7Gg10U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5151.namprd12.prod.outlook.com (2603:10b6:5:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 18:16:08 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 18:16:08 +0000
Subject: Re: [PATCHv2 1/3] x86/sev: Use CC_ATTR attribute to generalize string
 I/O unroll
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, jroedel@suse.de
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, hpa@zytor.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, tony.luck@intel.com
References: <20211203132340.41741-1-kirill.shutemov@linux.intel.com>
 <20211203132340.41741-2-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <7bd09c03-0ab1-2843-d77f-900456fc10c4@amd.com>
Date:   Fri, 3 Dec 2021 12:16:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20211203132340.41741-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:806:127::10) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from office-ryzen.texastahm.com (67.79.209.213) by SN7PR04CA0215.namprd04.prod.outlook.com (2603:10b6:806:127::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Fri, 3 Dec 2021 18:16:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2280d1ec-f41a-4d3e-4640-08d9b688fa19
X-MS-TrafficTypeDiagnostic: DM4PR12MB5151:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5151BF41CC8066B3DA1CE676EC6A9@DM4PR12MB5151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f17rtKIh2/y2/TLlz0NIYeo+TaXVLjDuKg1Pd4c8Ml/qt/9m0boK5KW9PWE1DYCxbnBOPUSZV5n+KzCW1PpCSTwV23P3hx1p+EEBgC2d7W+8iHOZzRDAndHKBc8E/Yg5BonpMy2Kr8RRfJBtxEPv2jK+TxxU6OFlSMJW2ovISn3j8GJXMKTY9FJlcUIVIMF9pJGJJs/d34DycmK8v3yE/m7E5euWd0L7G3xT5P8uwmURhV8a7vlb1UxQBr26g0lLD8X5JYHPPXEC0rNaV+n46nYyKhUAc7L9AoHmtqM9f1pc8Bpe9I4UHiGdZn/K4chH3VmuNZ2UXftMypyqyTYRUD/rNN5wGALPfzIh0itjkhqHBIMudSskj2wb/Ani8S4wOiGBlc97pgN8Tgnmx08okf63Fs7YpxAcBnJmZArnimqbzNAJBp73EYY/y0EBiUHMqfdQpBfQtQAZ+peAZozzlnfGJDX3PKbjU4WibgR6pGvN4DVP8xnQJgZ5v5aSVXkloomgzKP6PZX8qYVDkbtwXo4KDEqXNoFhzaFhNNKBjvLjFWA7VnsVNVJd8AOj4KcaJxVmBA5c6fPfVGfn1fMJ1NRngzrV4XeecamIBPewqXzN0VYQN6m55gSVCdzpY0rPGkk08sRNeJ8K0xR0DJgSkRoM6J5ze+HII2bTBrxuqcgMaFrSYBid6/hE9Fj7ZV7VMuAv4hxXOvfhoz/I3nHHdinrA/36ba1fM8xl42BVcUffiKrOIYeU4wXuOkFwIH7X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(26005)(31686004)(316002)(2906002)(53546011)(6506007)(7416002)(38100700002)(8676002)(66946007)(86362001)(956004)(66476007)(83380400001)(8936002)(6486002)(36756003)(31696002)(508600001)(6512007)(5660300002)(4326008)(2616005)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmlsZSsxVFBaSTZmdzBlMWhXRUFOS2NTT2NhczJscTZvRXRPR2J2T1d0MUhW?=
 =?utf-8?B?QmU4aS9qdUhUR1BVQ09xcyt0b0tWdWRXQXFOOHdtYWtKU1B0dHRSSUF1T0pP?=
 =?utf-8?B?b0pXNWVPWEZidzc3MVMxdE9kV3l4OGNlaVNjL1A4ekFIM0N3blN5QmVhQ1Za?=
 =?utf-8?B?NG5CamZ5Q21aZ2JhQkhnSEZBeVA5ZUxqWHhCZzdhRm41U2sxOGNxa21HS2Rj?=
 =?utf-8?B?RGYwcTBKanRuenZSREJ3RktySlJKUnViUG1vTmczU0VsVmhrdnV5TVlYa3VV?=
 =?utf-8?B?VUZNNHdmVytHcnJjcU1OOWNhcnlJWmp6QXpxRENnY3IzYXlIdWMxMWd4YjR4?=
 =?utf-8?B?UmlqbWEzOVlDQkRud0xJcHRId1E4R3NlSW51Y3E1K04yazlNYVB0V0tjVWlu?=
 =?utf-8?B?Mm1OTTN5b0VHZURaSzlQYnFDNER4RkdsMHRrMnJRUWxHdzhLOHdWUjcxd29G?=
 =?utf-8?B?WFdYZWFHUGthOGU2ZldjSXZCOUY2bUxnalNZakRCZi9YdFhoM2F1T1ZhWHho?=
 =?utf-8?B?Sll4TzhES0RxQ3JWTE12TGRBNlRNVUlqTG44K2RINU9NY0JTSEo5aExUQzRz?=
 =?utf-8?B?UUtLZ3Y5VHFMempFaEZ3dGpVR1huN2dhaHp6TWRNdG9HWURzZ0grSndldDVY?=
 =?utf-8?B?NldPM1Y4VjRRNldXWE5LRDF3VHhOTkJ6MUhNVGRIU0tjUzltK0JPUUhrT0c2?=
 =?utf-8?B?UVVtaHFHUllZZUFMbFJIVjAvODVOWTdpRjJSc1kyZ1I2d2U5Mmh1NENLY1Uv?=
 =?utf-8?B?TXpHZ2VTTVlSaDByN3RjdzA1bTZVM3VIRW1Ubm55NmpQZTV6WW0xYVdlYzdo?=
 =?utf-8?B?OS8zM2w4WW85dEw2WFBsd0NIUlZqSnR4eC9qVEJQQ2ZFdUhPb3pOZnBRWGNj?=
 =?utf-8?B?V2lHem1XQXYvYW51ZWVzVXRlUGV0aC9DdDF0WFFicFZIQjlpVElmTFRrOS9n?=
 =?utf-8?B?Z1lLRUJqMUlESEEvK2F1b2VrQm9RMkVyTmJ6MHRVRGZGZVZDRVR2SzJMd3Rs?=
 =?utf-8?B?YzNYQzh2c01pVm9oZjlQL2duUnpyc2dtalJIWG5hbFp1NFhYbWFuTVRQV1cz?=
 =?utf-8?B?UHphcDJJTjJBa2txckRUekp6Y0JhckxHdDg2Q25pMDdwbVFBNmlTamY1Q3lw?=
 =?utf-8?B?R3Zab1IxekE0T3IxL3kzV0RGWlZqRk1qYUtpaVhLR1EwRXQrMFo5VmQzMm81?=
 =?utf-8?B?KzE5Y2IrQ2FuSlFXdDZsSXcwMkVJYTdUUGszaHNWcDFIUUtvNTBieFBWdCsr?=
 =?utf-8?B?cFhnMm14RWNlZi94d3MzSGYwN3hmT3F4aXZrUTN2RFhCRzdrTTJWeEIwRXlI?=
 =?utf-8?B?eVJ2WnFURW50aCtKMXpLSWI2aURQdmIyT1ZHTld4bVhKcHFmNUhSZlUzMWhW?=
 =?utf-8?B?VkZGem9aRjRMMHJtNHN1MWxZM3VtbjVEMjRHNUJGcHcyeXBtaU50YjQ1aUwz?=
 =?utf-8?B?YVBGVHk1Qlo3eDZxZm0xWVNTMHU0eEhjWWNzNUV6VXZmYko3SkVubWNKMDNi?=
 =?utf-8?B?M1lWUCt5QTd3RUNGR3BZUG03RldUcVFjVHBka3cySTdxWlRQYmZnYmNxSEF5?=
 =?utf-8?B?NDlJalIzWWVjMnlMczdIS3gvbFltZThYWnEwRVcrWFBxSzZhRkFlem1VekRs?=
 =?utf-8?B?dVhBYXFudCtBb2VERWtEdTlZQWxCVFlYVjZUUU5iOTNhNkJHNUFsWldWSTNV?=
 =?utf-8?B?c0tDR3ZJd1NBNVJaSTRjRk03UzQwRUlCSk83VUxPckFoalA5cXNuYjVKekNP?=
 =?utf-8?B?OG90c1hWYUFwQitjREYyZGkvZ0l4MUNWWjBZcm5WSHhVbG1NNFBTSGV0N2tH?=
 =?utf-8?B?VUZqa3RGR0ZsT3k1VXgrR3h1bmxnS2pIN3RKSjVnemFZYUxwd2lZeUJiN2ky?=
 =?utf-8?B?ZDkxcVJSUnJjMldMNDdUY25MTnpzSTFKN290WmNoTDZ2TVEreWZNMkdURThU?=
 =?utf-8?B?ME9weFhMVjc3Sm55NGVNK3YwQy96cGxwOGxTMFBUbnY3NzNEdjBVL1FVMU9N?=
 =?utf-8?B?M0I2cVhjS0RXZnlNSHpycEllSUdEeTJEVUpzL0pBQ2dJK1lKTDlKa2hOVDN4?=
 =?utf-8?B?ejhMbVd4d2lRZkNMM2c4QkdvSzZNTEEzWTdyNTJ1VjJreDd2YWdUT01OSy8r?=
 =?utf-8?B?K24xWGR5RnN1dWlWS2FDcnFHNWo4bVlwV1JUK0RKaXM1M2ZHekZrS0hNV0JP?=
 =?utf-8?Q?kWEsETCmROhlPb+yatdXrpg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2280d1ec-f41a-4d3e-4640-08d9b688fa19
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 18:16:07.9265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQQsCL3H+sNZ6V6WBnKP0DeWbn8uz27w/PBoldjq89qrzW6pr5cDz2FNAZb7GYbk3IYICkw+48RBQmdoXUDTPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5151
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 7:23 AM, Kirill A. Shutemov wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> INS/OUTS instructions are obsolete and hence many hypervisors do not
> support its emulation. To support existing usage, string I/O operations
> are unrolled using IN/OUT instructions.

So this statement is a bit confusing.

The reason they are unrolled for SEV is because, as is stated, the 
hypervisor has to emulate the operation. Since the string is in guest 
private memory, the hypervisor will read encrypted memory and so is unable 
to perform this operation successfully. This is probably the same reason 
the unrolling will be needed for TDX - hypervisor will read all 0xff's, 
correct?

But they won't be unrolled for non-SEV and non-TDX guests. And with 
SEV-ES, the GHCB is used to supply the string in shared memory and so the 
string operations won't be unrolled there, too.

> 
> AMD SEV platform implements this support by adding unroll logic in
> ins#bwl()/outs#bwl() macros with SEV specific checks. Since TDX VM
> guests will also need similar support, use CC_ATTR_GUEST_UNROLL_STRING_IO
> and generic cc_platform_has() API to implement it.

> 
> String I/O helpers were the last users of sev_key_active() interface and
> sev_enable_key static key. Remove them.
> 
> Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   arch/x86/include/asm/io.h     | 20 +++-----------------
>   arch/x86/kernel/cc_platform.c |  4 ++++
>   arch/x86/mm/mem_encrypt.c     | 10 ----------
>   include/linux/cc_platform.h   | 11 +++++++++++
>   4 files changed, 18 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index 5c6a4af0b911..f6d91ecb8026 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -40,6 +40,7 @@
>   
>   #include <linux/string.h>
>   #include <linux/compiler.h>
> +#include <linux/cc_platform.h>
>   #include <asm/page.h>
>   #include <asm/early_ioremap.h>
>   #include <asm/pgtable_types.h>
> @@ -256,21 +257,6 @@ static inline void slow_down_io(void)
>   
>   #endif
>   
> -#ifdef CONFIG_AMD_MEM_ENCRYPT
> -#include <linux/jump_label.h>
> -
> -extern struct static_key_false sev_enable_key;
> -static inline bool sev_key_active(void)
> -{
> -	return static_branch_unlikely(&sev_enable_key);
> -}
> -
> -#else /* !CONFIG_AMD_MEM_ENCRYPT */
> -
> -static inline bool sev_key_active(void) { return false; }
> -
> -#endif /* CONFIG_AMD_MEM_ENCRYPT */
> -
>   #define BUILDIO(bwl, bw, type)						\
>   static inline void out##bwl(unsigned type value, int port)		\
>   {									\
> @@ -301,7 +287,7 @@ static inline unsigned type in##bwl##_p(int port)			\
>   									\
>   static inline void outs##bwl(int port, const void *addr, unsigned long count) \
>   {									\
> -	if (sev_key_active()) {						\
> +	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
>   		unsigned type *value = (unsigned type *)addr;		\
>   		while (count) {						\
>   			out##bwl(*value, port);				\
> @@ -317,7 +303,7 @@ static inline void outs##bwl(int port, const void *addr, unsigned long count) \
>   									\
>   static inline void ins##bwl(int port, void *addr, unsigned long count)	\
>   {									\
> -	if (sev_key_active()) {						\
> +	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
>   		unsigned type *value = (unsigned type *)addr;		\
>   		while (count) {						\
>   			*value = in##bwl(port);				\
> diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
> index 03bb2f343ddb..cc1ffe710dd2 100644
> --- a/arch/x86/kernel/cc_platform.c
> +++ b/arch/x86/kernel/cc_platform.c
> @@ -50,6 +50,10 @@ static bool amd_cc_platform_has(enum cc_attr attr)
>   	case CC_ATTR_GUEST_STATE_ENCRYPT:
>   		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
>   
> +	case CC_ATTR_GUEST_UNROLL_STRING_IO:
> +		return (sev_status & MSR_AMD64_SEV_ENABLED) &&
> +			!(sev_status & MSR_AMD64_SEV_ES_ENABLED);
> +
>   	default:
>   		return false;
>   	}
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 35487305d8af..b520021a7e7b 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -43,8 +43,6 @@ u64 sme_me_mask __section(".data") = 0;
>   u64 sev_status __section(".data") = 0;
>   u64 sev_check_data __section(".data") = 0;
>   EXPORT_SYMBOL(sme_me_mask);
> -DEFINE_STATIC_KEY_FALSE(sev_enable_key);
> -EXPORT_SYMBOL_GPL(sev_enable_key);
>   
>   /* Buffer used for early in-place encryption by BSP, no locking needed */
>   static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
> @@ -499,14 +497,6 @@ void __init mem_encrypt_init(void)
>   	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
>   	swiotlb_update_mem_attributes();
>   
> -	/*
> -	 * With SEV, we need to unroll the rep string I/O instructions,
> -	 * but SEV-ES supports them through the #VC handler.
> -	 */

I missed this earlier, but can this comment be included with the newly 
added case statement in cc_platform.c?

Thanks,
Tom

> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> -	    !cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
> -		static_branch_enable(&sev_enable_key);
> -
>   	print_mem_encrypt_feature_info();
>   }
>   
> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> index a075b70b9a70..f47f0c9edb3b 100644
> --- a/include/linux/cc_platform.h
> +++ b/include/linux/cc_platform.h
> @@ -61,6 +61,17 @@ enum cc_attr {
>   	 * Examples include SEV-ES.
>   	 */
>   	CC_ATTR_GUEST_STATE_ENCRYPT,
> +
> +	/**
> +	 * @CC_ATTR_GUEST_UNROLL_STRING_IO: String I/O is implemented with
> +	 *                                  IN/OUT instructions
> +	 *
> +	 * The platform/OS is running as a guest/virtual machine and uses
> +	 * IN/OUT instructions in place of string I/O.
> +	 *
> +	 * Examples include TDX Guest & SEV.
> +	 */
> +	CC_ATTR_GUEST_UNROLL_STRING_IO,
>   };
>   
>   #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> 
