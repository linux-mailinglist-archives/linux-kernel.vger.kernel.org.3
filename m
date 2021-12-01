Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B3E465681
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245101AbhLATfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:35:48 -0500
Received: from mail-mw2nam10on2057.outbound.protection.outlook.com ([40.107.94.57]:54780
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235901AbhLATfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:35:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erzg2Px4TDlAOJN7jut44Hz8Mg9B6ION8axs1I/jQX9QcCijnCxauJ+GUpmG8b0KmSvC7hKJ2jtmhdLxY11S+kV2G1lgAn05zCerE9acm8V+1ln76r/MmZTl5fXQYoJ/rb2EfucJsSuD/TBybP3qHXVIDwwRf7Y7LPB5b/v9RVG8mQZ0mV5b1dzG4QHUv8r/tGGIvTKgJE6qZ6Bqgm7XR0T7ck06XBJyKSLXAXS+Jnt8UGTUg0kfhC/eCUCZh38+dHBC5X0S4ZqeFkqIdXoIF6BFtPVY/6zO0g9LbpTZCGsvK94chXjAbp43J2RTw/tXuBTOHLfDvrKnW1Jwg79AXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7c/llr/2sNENoOL9NVIbZMcjmjGIHSyT2+e8NWfOGeE=;
 b=PiMbs7gNKNxhJPbEOy25eQutYfh+lM93qE3siqSi5xYlozkhMNcl0yENvgH2LFkOBmTnU0XzgUSg8Nh7kioL4FodJKQIJ5QyhmLh8u/74rs+YlnDOVzlXCtuM08Ts1lnEB1K+ZX4kTXM6pM8lopTI2h+hXqtyvj6UZ1S+v8BMIPVnj/P/bjS7PZeqQYrv9aqo2dOnK4MU0JBjPMvVF6IktvB55HyXWz7/fPORYH0wyzhpyKxs/mzvN71rUJHFTIgh/bp80pd9i0vW3oK6l3xf6PVmRnkJhWL7w5VsGH5ryB4jxbonMx2GEeo4yUCDxHpEHw6HclkAnFtaxlwdJKyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7c/llr/2sNENoOL9NVIbZMcjmjGIHSyT2+e8NWfOGeE=;
 b=qIiG0qT2fvDv8UOxHp9I4OEKr5sUNB7tVdYzP1xi8g47SA0eCNE6nRSdkQT3XVcihdhP/bnlxsp4PgVGKMX63acP8Qg+lvDRDafCCwg8xP9QQQJIhjZCMouYFeZ1YsfkHWZEsT9gJwRCZRSk56nQ7p5bpFoVZwLLgZnCJ8BD0J4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 19:32:22 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.020; Wed, 1 Dec 2021
 19:32:22 +0000
Subject: Re: [PATCH v1 1/4] x86/sev: Remove sev_enable_key usage in
 outs##bwl()/ins##bwl()
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211116004528.2928887-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211116004528.2928887-2-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <04c63791-81f9-f938-eda8-1f03b2973b64@amd.com>
Date:   Wed, 1 Dec 2021 13:32:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211116004528.2928887-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:208:fc::41) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by MN2PR02CA0028.namprd02.prod.outlook.com (2603:10b6:208:fc::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend Transport; Wed, 1 Dec 2021 19:32:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1da3939-4ef3-4ef4-a364-08d9b5014b72
X-MS-TrafficTypeDiagnostic: DM4PR12MB5328:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5328639570F82E72EC36A1EDEC689@DM4PR12MB5328.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Ai0WlsBW25mrsNJxH88yVYsHaVgQwd3yvnsFqHuiXmEKrpFh5/IaqfRN3PsH5ztgAmyeb8h+tR11t8Tt55LX4q7x94G8AHdjw8VXXAVzv4Ot7DH2qgVPWADRpfb9XopmAAQBTxvM2u5gPmISVlbjoU4jkXYeT1d5V9lGC9EPDtIVfTWjyjP5Oebe2WsJJdIPlKhhhaVDACauZBf8kRoTwLcyahOJAffL3ES5m5ae68FFaqgGYCgpvL3zjgMcEMC9aENiF7uMtSeLTU0eBzmJfwt/MfSBSn/M887xECjUZ/hLI5pO/vCCWmJIqHUkwJ3kg8ici6GyuTpMxqlUSCSRQxxaCb5B3RwlgFWBNfI0Cv4ImmIS6Fn74SLL+YqTaOLLn9yyEQ1V7zqJcVpy4XBWBGtRqvEdUqoAdnRhe07z2A6QUVdQzyTxK5BRO3HQVdOajkC9SSS0FxwrZiovoPIxWLl/yQREx1Mi3qwWakWWCkdm83SU29XvEJKpa4NoPTGV5zM93BoShZ06zHG0i0gzSpUrb15yWOw2c01Ok+OpbTKWhVy/u85ZP90vCtR2y84xRC+HL82UBFOdj5KscsYJL5wGOMnoBssXPm1D5L4Ro8/8RUeR+6GiZtZlO48iEiBvN0I0r0bljzzEld9miL4iDFOwwoHnvcxkMN375ZLnrMVX1rlHkiyL0oTDc1SGJUiLzDSMXIOlIBR2mMz/07yzwWMxLT+hRbvHlBpzg0qvfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(6486002)(8676002)(8936002)(508600001)(186003)(36756003)(2906002)(110136005)(38100700002)(7416002)(66946007)(54906003)(31696002)(66476007)(316002)(16576012)(66556008)(31686004)(956004)(83380400001)(4326008)(2616005)(53546011)(5660300002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1hTRXV6TWRlRm1keDBXUGhDWS9vZkZ3RmczQWx3RzVIM3pWMFRPeU51MVJp?=
 =?utf-8?B?K1NpbHRzNEM5NUgxN0h2KzczVlJQc0JYMnc2L3ROUjE1ZWtnNFBRWHRzS1Ez?=
 =?utf-8?B?ZE0wcEVvVnlVeVRxR0JNbTZVUXdvRnRPMUJ2eUNHY1R5c0xOQkMvQlZqSVk4?=
 =?utf-8?B?SWJxRTJaUXhkZzZneDJzNlBwMGZ5NkFsd0tlMUoralRXQjFqbFdnYkl3VTV4?=
 =?utf-8?B?V0czVU4wdGpuajIzVmJCSmVSa21uQldLaWpRS3daMmVsMXBKdHM1bFdFcG4r?=
 =?utf-8?B?b2ZHdUJQYWR3Y3N6Mk5mQXlrZGRDQitIS3lVREllL0ZjZmFSTTgxTkhpamxx?=
 =?utf-8?B?bHo5M3Z3R1l2TFZTL2cwMHBZRjBHdFV1d0dDSzdOUnQrTTFRTGFsWDU3OVZJ?=
 =?utf-8?B?ZEJnTzFJdURwUnhGNTNPbThNTytsWmxYRkpGYnowYk1VdmoyU0JFcUc5Vjkz?=
 =?utf-8?B?OHdSdjU1TEdaR1FyTFg3eVRpRXFEYnFGMHNnekczZURQaWpLNTdGUFlUd0Uw?=
 =?utf-8?B?Z2RHampORkppNktSOVJldlRqVGcram93SXpSaGxCUi9Nb2MwaGZTSnErSUow?=
 =?utf-8?B?bFlDMHBSWDlkQjVhb1oxUngrVkoyclNMNTgzcjdKbjNjNGVRalVaNXU2NjAx?=
 =?utf-8?B?TnFQYy94cHhuZ1UwV3BuL2pKbHBUd29QYjcrWG82L0I4U3kwNnphSHVnM0oy?=
 =?utf-8?B?MHVSK2ZnazBBc3JmUE5ITkdqNndPdWVHbTlYamxmMlQ4aEhtYWQ2UDRuN20z?=
 =?utf-8?B?eCtwMUlDT3FaM25iaGhvNXQ0SzI2VkkxZWJlNmdVQXFTQlBrRnQyeG1Lam9C?=
 =?utf-8?B?a1pka3oxZk1TajdPMHdraWo4YURQY0JLS3cyTHNxcE5uVkxTLzhsYTcySDQz?=
 =?utf-8?B?cThqM1NSeTlsaFJRS25BWGl3WVJWWE9sb3Vlcm5seWp4RmZiZDZXdEVqS3RQ?=
 =?utf-8?B?L1VST1JXNXF4Yy9odFY2b3I4YUpSNVVnS2dyRHk3eTlyUGozTngzVndnV3FH?=
 =?utf-8?B?ZkREeUZSVmxYVHJNeFd5U0pXT09PQ1RUbEdDWFAvSU9CbVJuQ2FsbC8rNmlI?=
 =?utf-8?B?ZVdaSXkzTHZvbVdtYTJoSHJQWHZqSWNUMGhtY1BEcVlINmNML09LWkYvRjNX?=
 =?utf-8?B?Ymo5Zi9VZmVWa1BoOHg0U0w5M21iNStIeU03UnpNYnB1djFNemQ2WmYyVEx0?=
 =?utf-8?B?K0pyZGtueng2blEzekt1M1ZsRDRpTTltQ2gxZlEvMUM1NGpaSVgwakMwUkZo?=
 =?utf-8?B?dUFQcFY4aHdPTjFveGViVXB1eVRqVkR3YklFSVdUQ3VnbkxQWXRWZlMrUmli?=
 =?utf-8?B?QkJ0Ukc3c0JTTGZLT3M2WmcwL3FaRCtuNUhrSkZzMHRyaGZmYkhTWm9uMm04?=
 =?utf-8?B?Rm5CZG1zd2s2Q2xjSGpMT05hVFVjcUVrZDJLY011RmMyeHZZQjlUM0RwZHEz?=
 =?utf-8?B?WXpmeVdBUy8yK3UrVUoyR2Uyb3lyOW4vcXNzd3BGVGRYcU4rMjRoR1VuTk5L?=
 =?utf-8?B?RElPL1NvSXFOWkhLVTE1cUo1Rmc2WjBCdlVNbkNlOFVCb2pMaG5aTG5ndzBR?=
 =?utf-8?B?dDRLVjBwbitXL1JFS080Tm5FNHRFNnNLb0g5VWViN3JScEZrYlk1RWs1NXdL?=
 =?utf-8?B?dllDSXp1VFhUSkZ3OVIwa0JBWnl1RFRYQWUreUlVdTdvVG5pNURyVkRUb3lY?=
 =?utf-8?B?MUhjUERpQWI0V08yd1prL0IzSzBqdjVqeVVqcExHZFhSVUZBZ1hYeHJnVVp6?=
 =?utf-8?B?N2EyczB6RDBaU0lFeHVQRlRGTG92Tng3QjVWdDVmT3VtOVNRdzJGL2hOaDlL?=
 =?utf-8?B?S0hHYmZwQ2F6eG9qSjVoZmxZT2VsNHYxeW9GbHcrSFJKKzJQQkxlcDdJQ1I0?=
 =?utf-8?B?QmxYN3luYTZGUk9IWWtyekNNeUY0d3d1c0hLL1ZoSDcweVBhZ1JLK3l6eU96?=
 =?utf-8?B?bTBIMVBqN093WW5WckRDY0trSUo1V0xaQmwzbUdmOXI3RlhJMWg4ZlVoL1ZW?=
 =?utf-8?B?SkxsbWFBQURrazRCSXBkNk41LzJvYndsRkU4M2hkNFVHTERSb1l4VU5ubEVJ?=
 =?utf-8?B?dmZ2UHE2R0dmdW9tYXpvVDIzRGlRamF0elVQRkdPS1g3S2E1QWRRRzljZVJR?=
 =?utf-8?B?b3lMUmxFVjljaXJZdlVZM2d0ZkszK1dEeFc2dFFzL1VnbTVwZ2lWMXNzZHRE?=
 =?utf-8?Q?ocb/lkHL3tOz5EYyx9/AuTc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1da3939-4ef3-4ef4-a364-08d9b5014b72
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 19:32:21.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GL1yoee5g41Vt38E/XUb03BG9kFyZXF30GD5Q2+pPBaHhibG0r1mNLZP4DXVxe5rDK5JMIrjY0pNJL+wWj/KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5328
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/21 6:45 PM, Kuppuswamy Sathyanarayanan wrote:
> String I/O instructions (INS/OUTS) can be used to move blocks of
> data between I/O ports and memory space. But emulation of these
> instructions is not supported in AMD SEV platform. Since these
> instructions are obsolete, hypervisors rarely emulate them. So to
> support the legacy usage, INS/OUTS are unrolled using IN/OUT
> instructions.
> 
> Currently, this is implemented by adding a SEV specific static
> key check in outs##bwl()/ins##bwl() macros. Since TDX VM guests
> also need similar support, the implementation needs to be made
> generic using the cc_platform_has() call.
> 
> In preparation for adding cc_platform_has() based support, as a
> first step remove the sev_enable_key usage and replace it with
> direct reference to "sev_status".

Probably makes sense to just go directly to the cc_platform_has() call 
rather than introduce the usage of sev_status.

So maybe squash patches 1 and 2 into a single patch.

Thanks,
Tom

> 
> Since this patch replaces the static key usage, it might lead to
> some performance gap.
> 
> Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   arch/x86/include/asm/io.h | 15 ++++++++-------
>   arch/x86/mm/mem_encrypt.c | 11 +----------
>   2 files changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index 5c6a4af0b911..69093a610630 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -257,17 +257,18 @@ static inline void slow_down_io(void)
>   #endif
>   
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
> -#include <linux/jump_label.h>
>   
> -extern struct static_key_false sev_enable_key;
> -static inline bool sev_key_active(void)
> +extern u64 sev_status;
> +
> +static inline bool is_sev_enabled(void)
>   {
> -	return static_branch_unlikely(&sev_enable_key);
> +	return ((sev_status & MSR_AMD64_SEV_ENABLED) &&
> +		!(sev_status & MSR_AMD64_SEV_ES_ENABLED));
>   }
>   
>   #else /* !CONFIG_AMD_MEM_ENCRYPT */
>   
> -static inline bool sev_key_active(void) { return false; }
> +static inline bool is_sev_enabled(void) { return false; }
>   
>   #endif /* CONFIG_AMD_MEM_ENCRYPT */
>   
> @@ -301,7 +302,7 @@ static inline unsigned type in##bwl##_p(int port)			\
>   									\
>   static inline void outs##bwl(int port, const void *addr, unsigned long count) \
>   {									\
> -	if (sev_key_active()) {						\
> +	if (is_sev_enabled()) {						\
>   		unsigned type *value = (unsigned type *)addr;		\
>   		while (count) {						\
>   			out##bwl(*value, port);				\
> @@ -317,7 +318,7 @@ static inline void outs##bwl(int port, const void *addr, unsigned long count) \
>   									\
>   static inline void ins##bwl(int port, void *addr, unsigned long count)	\
>   {									\
> -	if (sev_key_active()) {						\
> +	if (is_sev_enabled()) {						\
>   		unsigned type *value = (unsigned type *)addr;		\
>   		while (count) {						\
>   			*value = in##bwl(port);				\
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 35487305d8af..49e5dfc23785 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -43,8 +43,7 @@ u64 sme_me_mask __section(".data") = 0;
>   u64 sev_status __section(".data") = 0;
>   u64 sev_check_data __section(".data") = 0;
>   EXPORT_SYMBOL(sme_me_mask);
> -DEFINE_STATIC_KEY_FALSE(sev_enable_key);
> -EXPORT_SYMBOL_GPL(sev_enable_key);
> +EXPORT_SYMBOL_GPL(sev_status);
>   
>   /* Buffer used for early in-place encryption by BSP, no locking needed */
>   static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
> @@ -499,14 +498,6 @@ void __init mem_encrypt_init(void)
>   	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
>   	swiotlb_update_mem_attributes();
>   
> -	/*
> -	 * With SEV, we need to unroll the rep string I/O instructions,
> -	 * but SEV-ES supports them through the #VC handler.
> -	 */
> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> -	    !cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
> -		static_branch_enable(&sev_enable_key);
> -
>   	print_mem_encrypt_feature_info();
>   }
>   
> 
