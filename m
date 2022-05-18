Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B4D52B542
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiERInV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiERInU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:43:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE754D63F
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RavnHhTD8PmSXpzIzGgTHjorxTT71qxhtO465FhFA/+LQI0WZdaPdIXYElIAC0pOWc+lFbLXTXoOpNcm6HeCgGxxWubxyOmssbGKV4pVHeJGjiV/xy2TSZptof0LmZLxHbD5yWdKWSPa+mbsWt4a/ZCXuFipRbMoE4D6P6SS6ymkXNeRzXrhSeyxahF1FVlSrLZzp7tMU0j0dIORdkVxll1k5t3jNKrwi6nAYpUIZ4FWS1e0dhx7Q2HCXCmM1r0PvKqj6nbrOdfG99w1IP2c3m3lSLx6e95jWvAjs40D+SW1QcgEMDc7UYiBQObjfvmKitAhPhXys2D6WV/T7j25xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZrt1dZA9ZiqrhDhoAjxPb2ahBuZhee3HHAqVXTRLdM=;
 b=kw7FrR9zbDYs9iKQPbyt7kNdYLPikMkFxgWh6IIpZP+NMNlKBO95wOVB3BsK3/9duVWDsJTixiiaW9sbi+TTq+XHZ4JOc++g2vPTILNePrNpD5yCSPU9/WnpycHaKXpJd9Bffv+P/nh3EHUe3vhq0G5B2oaIWP/8rawzNacUs3t53t9I2SrmM0nLao5uyaq6fYRcawhaMRv2qppBOIza/n0lcZTXsuqArxkE4xwruzNxn/+tZkBBaRZG3g1ftS3DO5csZxDIdp4PpKe65ZICGMkli57wFQDRUUA7zeL54ksiCBs3LR5l6ehg5OHTL+iin8RFQJqlLsqX/oIQzT2d4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZrt1dZA9ZiqrhDhoAjxPb2ahBuZhee3HHAqVXTRLdM=;
 b=Qug+JFh/tCmXHzpxXn0S4upyfpem643zwmi593GArZYS4gFXEcE5DUzLQe0T6KCBV/Y7D10VnEtcrjPQWJX6pgjMpy9pB7WMErylhgghy77HKLn1bvBGRdMeAg3IANkMjqhbErZcbdp5c373Ah6fVdhoPPgGZ5+WRDel8jopjns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by CY4PR1201MB0152.namprd12.prod.outlook.com (2603:10b6:910:1b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 08:43:17 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::40f0:37f4:fad5:dfe3]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::40f0:37f4:fad5:dfe3%7]) with mapi id 15.20.5273.013; Wed, 18 May 2022
 08:43:16 +0000
Message-ID: <e6664140-934a-915d-9d16-f14500ec275e@amd.com>
Date:   Wed, 18 May 2022 14:13:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFCv2 08/10] x86/mm: Make LAM_U48 and mappings above 47-bits
 mutually exclusive
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-10-kirill.shutemov@linux.intel.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <20220511022751.65540-10-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::18) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c700449-05c8-4931-2c8f-08da38aa73c4
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0152:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0152C2A9FCB80F2B78871F30B0D19@CY4PR1201MB0152.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCFYdKmewJ82uw8meARegbGdOiZFTeAJc90fL/7AW8e61Q/k7c5I0f39L820+wA0DcMcuA3yQpNMdPJMM28h1blgLMeFjDUBT9h8ypCYwtfhKUfmKFgEpBdBaJgWN8jgT7qrMtP0kVV2SfQ+8pggrEfIdomRLsT8Xzyov3khS4VNqwrtQNd4zpw0lOCBNgyb3jwb2BM3Hf3ZgBE07hd02VuJ3nTMIxqX6STN1AagYcEDwVv+scSNPcyutZke250r9hHBwTk9jW5pSZaiy/j6qCT8e0WeEeZ50nXHCK1/ZY/vfRpDtAVH3FJZ6ElY9l6juHerS7wApI8mdH7jRRohIB8A3EFDy5Fp0/QVbcg9fAb5g+iZOsy2WEzESMSt8xKpBu0LmrOTYGJYs33hmn7K22DuQoAxBmQzzZBgwSzb1Iigd91bDj/z6kZW6OBmSiqUQ6NeIx+iuMNRyW7WOSMF8M/sdG/9hEhF3lLQAyqG4G4/77S9iuzAE9dyFlOK3bSXS7cfIp6u3aXHnXx2H3UjN/ha2p6Pi8okgusTTVnrlXdetQm0I3wpO/HYFNiG3hSrzoQ7YwIsyXS4veHMNWiFqC4r5SQ8UYsqy4TUzmklAvb2+x97FG6WLWxxSi+mUFmbEqRJWmT/Dji3qVRH0nwsBCxP0NN1XQ3gsH0xSY/dNDLCdkGoq1COE+2N72xwiqage13251I8YQygvy9rCaahKEmwdSpBQXONbMFpH71SJ6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6512007)(316002)(7416002)(2616005)(508600001)(6666004)(6486002)(83380400001)(110136005)(2906002)(8936002)(54906003)(31696002)(53546011)(4326008)(66476007)(66946007)(66556008)(8676002)(186003)(36756003)(31686004)(86362001)(5660300002)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmdkRG9mS2ZwVk1ua2txRC9DMTVmbkNZcU5IcFRoUGV4U0JHb2tjZW5OZWlj?=
 =?utf-8?B?d3hhZGZvZHFCYnhaazAxZTY3QjVhbFFLT24xTmtGQi9GWlBXaExSOTFqTWZt?=
 =?utf-8?B?eEp5R0hTUlVpWW95eUZ5amVVWEtRWm1hSnpVOG9qVDFoZGQ3bXNmRTk3Qmda?=
 =?utf-8?B?OGozMGFUUmFiYWJGaG1zUkNteGEvdlMybTMrOXpHSi9lRHdEeFRQYnZYQko5?=
 =?utf-8?B?a3NId3A2UmhsSmtneEYxbGRoTFNzREd6OGJSdmwwSUZ6bm04OW9jd2VaQ1pB?=
 =?utf-8?B?QWNiajc3K0ZmTlNRYnIzcThDeXRzV3RQNlY5YzF2TzAxV0c0SWJXNy95cTFw?=
 =?utf-8?B?TVB1Yzl2ZnR4VTRDMlY2d1RsMFVQcjNrQ3JwRkJLOFJReUd4VUwwSGcxSWdC?=
 =?utf-8?B?ZkwzS3laYmNjNVVvUGorWjBpU2pBT3Q2RlpiNWpRUVVwdDF5cXBTZWM1UFA2?=
 =?utf-8?B?ZkNlZHhEN1I2OU0vOXFiMHowS0I2NzhPc2xCd1FsZ1BQeGhxbkljMWlCRzlw?=
 =?utf-8?B?WGNESk8wK0htOEwvQng5UEZoWWxWMzJXNkRUdm9uK1N5UWd0bkhLWkFacGdM?=
 =?utf-8?B?UnJGVnNxdVUvYThVdmE4ZUlTWitvQmJTYkFydWFpSjRMYURxVHNCNFV1a1RC?=
 =?utf-8?B?aHlyK1pyeWQzMW5JeVFlaDQvN2hXelhmaXljN0hPeFl4NTlJcFUybVIvN2hY?=
 =?utf-8?B?ZnBibzcyMEVWaFVlWHk3UklzT3ozSFpkZk9JclBaVzZaM1Qvc1VzQWNMWXBo?=
 =?utf-8?B?WGpOVXFSSnJJdXF3cXh1VFh4NURUWFFid3Z2THVJYUl5SnQzUkZOMU54anFm?=
 =?utf-8?B?Y2FYQkpMUzJVMWdsaUhiZ0VESUs0bGNGS1hRUWxmdkcxMEl4SGZ6VmpWUklN?=
 =?utf-8?B?eEdsTnlWS0w2TDQ3UlhIa09lRGhCVGVmcDd1c1VITEFOVXl6dlh2SFZLODRj?=
 =?utf-8?B?NEQ0UHB1UlIyMUQxZENobS9BS1ZDbkJ5MTdJZDVlUURiUDlCQjVnOFI1dUxL?=
 =?utf-8?B?NTFieEtmR1I2enhpK1lZMDBhYU05NlkvbWZaNjE4cGh1MFRVZDYzS0RQZytJ?=
 =?utf-8?B?WmFOeTJObUhESDdjVTlEVWJDMXA3bzhsSGRUdllDMUswYnFUVXYwV1YzZEVO?=
 =?utf-8?B?RnFkeVp1aklHZjR6VkVNUEh3OXdOdnk1dGtRUC8vbm1lbDdkWlBqRGNKT3dJ?=
 =?utf-8?B?UTlkNlBLdFZKdDQ1WHFZdHBFNWNHNzZ1TWxiRVYvMEN2cDk3ZXFhNk5vQk96?=
 =?utf-8?B?RkxpQ01PbkI4QXhHWVZwYnowZVRsbXpUem1Ha0dtUWdxMjVDbUNoQW1ZenpE?=
 =?utf-8?B?Vnh1czFzNlBPWjdaQ0JGak1OcFhLUXhpc2lFaVJ5dWpnOHk1bVg2MHp2UTRj?=
 =?utf-8?B?RG5kYlM0emxTVlRYYnA3Y0xGTExIdm5yNk1FdUx6cDQvYXQ0L3JBQXZwUnN4?=
 =?utf-8?B?ZFExMWp4ZFpEMkV4eExpZTJOazlBOGZTV3B1ZWptTFRKWVoycEViQnZZVzdu?=
 =?utf-8?B?OU4vYlFEUjVadEFvUzdhQkZoTjNyN3dzYS9kNW1IVjh0TVlVc3lyd3ZTNE5k?=
 =?utf-8?B?Y1hydjBpa212Ym85UXBuc2ZsYkhxZFR5dEljMFJFanU3Rktxd3pwd2JBUmoz?=
 =?utf-8?B?Qk1lVW8xczRZeHBLNFZra2g1TU0vNUpBaWp2dk16UytwbjNEU3ZnM2x2TnZy?=
 =?utf-8?B?eHB2YTdJTnUwY2Y5eG56T0dOSnkxZW1jYUU3N2lYekhlR0JrTTJTZ0VTV0dG?=
 =?utf-8?B?Nk90dVNtMWZSdFBvUGpjaitZclJ6QnBpQXUranFPVEFDazJ4WXYvQWl2N3g2?=
 =?utf-8?B?TW9pUHlxUWM1WllyUi9ZUVd3SGVpN2I1SHZsRWlxa2g2YUVuU2xMTnU1clpj?=
 =?utf-8?B?c1dZdWFsckxtV1VPbi9LeUV6M095dVpHMTFRTVViaHlXVDBBUnhsMjM1SnAx?=
 =?utf-8?B?OVp1eEQxNVNMRERuMFc5eDZFbWJmLzgxOEhsNkFsVy8yQkZzcEdPclQ0cFUy?=
 =?utf-8?B?U2plemFHWHdSVEMyRnROZzlQMVU1VytSMElOQW9RZm1RdFllb2ZReXR5ejRz?=
 =?utf-8?B?aEFMZ2NFNzRRQ3hPRFlzYXdqMWd1bjNQaVVFYkFaUTV4UWZzSm8rdG1vbHZQ?=
 =?utf-8?B?ekFwaFo5MHNkUmRheG5DWkZIQVNhWkc3amhtekxWSGphdHdJQm41SW1ldjRj?=
 =?utf-8?B?MlZ3aGNGM2FxL3ZjR21iZ3UydlNRTlZYNTYrdkx4MGQ1SzBxT0JLNTJ0YlFr?=
 =?utf-8?B?ZDFrdEN5eFNLZnVjNGVKK05NeXc5ZGw0T0xNQnNUcGxjVUhzdWVhY1VvRzVy?=
 =?utf-8?B?bk5yQkNza3Z1a013LzNmWUZ6eEZPUytRNTFRT2QrNVNlMEExMzJBZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c700449-05c8-4931-2c8f-08da38aa73c4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 08:43:16.7615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ki2WtNLT5d6l9dkEt/NZCpNl8UZ3mACCPL9wEEpxHTLhSOMghQbjcDayH/bkDsKdT9LPre1ha/brWqgXGnsQQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0152
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/2022 7:57 AM, Kirill A. Shutemov wrote:
> LAM_U48 steals bits above 47-bit for tags and makes it impossible for
> userspace to use full address space on 5-level paging machine.
> 
> Make these features mutually exclusive: whichever gets enabled first
> blocks the othe one.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/asm/elf.h         |  3 ++-
>  arch/x86/include/asm/mmu_context.h | 13 +++++++++++++
>  arch/x86/kernel/sys_x86_64.c       |  5 +++--
>  arch/x86/mm/hugetlbpage.c          |  6 ++++--
>  arch/x86/mm/mmap.c                 |  9 ++++++++-
>  5 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index 29fea180a665..53b96b0c8cc3 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -328,7 +328,8 @@ static inline int mmap_is_ia32(void)
>  extern unsigned long task_size_32bit(void);
>  extern unsigned long task_size_64bit(int full_addr_space);
>  extern unsigned long get_mmap_base(int is_legacy);
> -extern bool mmap_address_hint_valid(unsigned long addr, unsigned long len);
> +extern bool mmap_address_hint_valid(struct mm_struct *mm,
> +				    unsigned long addr, unsigned long len);
>  extern unsigned long get_sigframe_size(void);
>  
>  #ifdef CONFIG_X86_32
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index 27516046117a..c8a6d80dfec3 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -218,6 +218,19 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
>  
>  unsigned long __get_current_cr3_fast(void);
>  
> +#ifdef CONFIG_X86_5LEVEL
> +static inline bool full_va_allowed(struct mm_struct *mm)
> +{
> +	/* LAM_U48 steals VA bits abouve 47-bit for tags */
> +	return mm->context.lam != LAM_U48;
> +}
> +#else

This is called from X86 common code but appears to be LAM-specific.
What would mm->context.lam contain if X86_FEATURE_LAM isn't set?

Regards,
Bharata.
