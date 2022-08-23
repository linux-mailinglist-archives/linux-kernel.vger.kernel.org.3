Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D832A59EDD1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiHWU4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiHWU4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:56:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A9C6EF39;
        Tue, 23 Aug 2022 13:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661288178; x=1692824178;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NAilsXQXhX0cgadtQRYfM/D1DOk/58WIuNuNKitl/io=;
  b=FXaIYzD1OoYz7/d0YPeFMEqUOoaOBXE1JR6qlpsLdzSa519KM/oMwOHJ
   zKy4AElEGrmvXjwv10PCneYvqyCAaKR6ZrDML8p0Jo2Egl7awsWj2h2Yi
   dYp68t/ziJaagf+UUtAe/QzqK54A4mhHOVlBRHV78dvXEabEh2ORpj/R/
   eGAZhVpQZaClvtp5d0SqCkvaA1CqzWYZ8tzh9/P02kE34WXAXNM4UY0IQ
   lKYdBfGS9D82P9zzVP/LUGd8/THiun+Qw0LdU5Wk0Kh/wYxcpBZwtw9wN
   EMK2uv41LV24jgUsPgauqamJzjjiF+Rhthg0IkPfIYXRnle5Os8u/g/1C
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="280766682"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="280766682"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 13:56:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="751819298"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 23 Aug 2022 13:56:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 13:56:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 13:56:16 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 13:56:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqKLNkW630uB1rc3k10j9vQ7Q2ycxHewzsCAW3UhlkjRSaeYJm1YCVDwKUnsUVsil8Qewbi8of7H1/fjcFY/VGqg+ehKsbiGNGXJWsxar8l0UeEm10zg9XdN962khlF+fWK7i13p3aFA1rlpOwBk3gE3kzg3oNOkcn4OXPJeG6suwICKm4g9Ga7Xvp4RNiqAD3mb3FRa9zS9wbt9s4KeSXt8volnegGtj4JefQ/Xb7QI0+jn6AnIUfenuqBt6xXVxc3viwnAmhvSeqUIzRVU8l3yPD0+dmxcyXtBykN9jiN2CoQFNZbetlI5yC+Mqjd6xHCdwyw2K39+r45hcWfwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKZOhdZPhkXWz4Z4Dv2mpCSpRtcY+6oNJNrdN8hhzNY=;
 b=eFw7tzA5jTAVOXl1ug97uFLmdMZ/c1cVBEU1BYp03fiLAmGmBlTweEfsG2x5Z8ird+8XCIgaVA3aTuMf2Mj3wyEZsAtTOcMmv6uWcVSwaVa2QI6/kCBxob4TIeomgRoEvQ9dYmVsGlETTFF2p1YbA3KYY26Jdk08zoDSNUTFFPTjcIr7es0zQJPYpCCAUifjHwNKfrpPWF89+0iQIf6oVdA1YfuMIh6mjuNGbXYCg4p47/licvv6GhU979ostsor6kPf1L81Z27QmOvXvJsD/ET8bfYvwBjMFIwFgb+RtkHLrgtA1SBLEKTwEx+lp5zSuN93WWOwUu/pkvm94ppAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ0PR11MB4925.namprd11.prod.outlook.com (2603:10b6:a03:2df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 20:56:13 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006%3]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 20:56:13 +0000
Message-ID: <673b861a-5c87-e066-09cc-d17e2d16ef68@intel.com>
Date:   Tue, 23 Aug 2022 13:56:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v3 01/10] x86/resctrl: Fix min_cbm_bits for AMD
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bagasdotme@gmail.com>
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117577023.6695.4825793379162387650.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166117577023.6695.4825793379162387650.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0035.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::48) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32f939b6-b44e-4339-c5bd-08da8549e9fc
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4925:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGaGF9px6dUwSdTLruPOC9OhpQelJV0fpr256l+V5FcTmGlwb0tfy+PNSTCHpI+iTf2om0Hi+VyScsSQr2IwmZDxdcpTFzY3wH0A+Abs4Wadz38khZTwZveOKnJiHzPoDl+lKWm5hrhUvTamDYfqlojU0GIDAbinvaOVVv3aHb1MsMR6RZyQxRO/6NOM5BpEibTr9KKw2D9WMaOyp2hq/N+ZnH0MWfVA0+s04wJrdE+3tnyObopQJvDXEtDXTx2cnMjeQp5wPav7iK4xvfGwUyqbENBj+1sgGQS1adbxkvpSz1YMPMyc83Z/bh7wRAZdwjVg7dYpmqcVPz9jQz4PHabPfMfPjqEfYbqjoPRbjFKK3Q2TgFC5AJLhvjHfnXNtPvvSy6rGyH0wHk7gnAJKIYmuopMksX7LL1gbE38mWC9WpRS/7L1MGpi4qPB0v9a2Dtvgqs+tTRF7vunGXg2d2/ZL4uihs5SK+Wz/gNOCUwdtBecQaFHPr8bG0JAzjtTtqQWNIxL9igdjllNuohE86V1KyiWpf8Bn9sB4NaegNwIRP2aOatNFCWauDRTvg0/daBEehBkTIyPsC2YWuOdJl7W3G/K5P7clUdzD4hzWW+uA7Lfd79zIWa35WsdDW5ZgvK1dOLE8ysUeeozRJNdqMT5L5kSCm4zKnw+M5mYqqMn1dcOAx6UDlK+Y4qck0i8/h8yanliBln8RvVRngrtHU3+HH2PXeChS8pPosJrSzvOGyHQFWNq0J48Hav5hl51lAQpulJD9mT+Xow5d4/cWt2N8K9tLZwuHoF32HMhKMVXvYFtrxxI1ZYB4EKNxaIocgIR2KOrg48+OwR9TahzsRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(136003)(396003)(346002)(376002)(83380400001)(44832011)(4326008)(2906002)(8936002)(66946007)(66476007)(8676002)(66556008)(7416002)(5660300002)(53546011)(6506007)(26005)(6486002)(41300700001)(36756003)(31686004)(6512007)(186003)(966005)(2616005)(478600001)(82960400001)(31696002)(86362001)(316002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUJabVd2K2JDYVUxdllGMlg2eGNuL1lpUnJZMFltRXlCZCtYZ2hwdno2L1hJ?=
 =?utf-8?B?S2crUVZiaXRpeHFSZ1dCYUZHUkI5ZHNHYkxmdnROL2ZaQ3RwVjYzcUZGR0tK?=
 =?utf-8?B?RityeVpEcXZLWHBwY2g4bGMwVWlGMXc2a2JYK1ViQ0lUQUR5aUJneGxYSnFW?=
 =?utf-8?B?S01ITWhxS1pPU1FmOHlCV21NeTlJOThMZGhtUE9zY0dFS3pGMEdzeEtOKzRG?=
 =?utf-8?B?WVlUeGR4eGljTm00bjFEZGRSVE5xOGdQWUlXT245Y0JuSXNkVHJZZlRNb3VT?=
 =?utf-8?B?bTFwZXpHRForaE1RWFV0WmtPRkloNTRwU01HZnI2RE93eUlEWldDR3ZURncz?=
 =?utf-8?B?NWlKUWEwWllGbDhPNElDRUo0Q0lrRWRPK1dIMUlEa3BpSXhuTWU1TXIrRy9q?=
 =?utf-8?B?NzRIcWNCV0dCVGUzcVVabUg1ajJ0dmx3UkJRN29RMWVrVkRiaEkrM2lzcitn?=
 =?utf-8?B?NmJUUmxyVE0wQi9JNDYreTBJRmR4czBqRGJ2ampCejNxcG9oZE1qQ2hvY1h3?=
 =?utf-8?B?Q0VJNUtBMnhZVnhCR2VuQUcraFFEV2ZQQklzYzRwZDUrUHUyd0FaUjd3UTdo?=
 =?utf-8?B?dXRiSnlxdEVzU3FuR2kxSE1QZkdVUm1jWk9kTTByQ2xDbHpMWnczRHdnZDdK?=
 =?utf-8?B?Q3VlelMwNHhwdk82dFNqUTRjcUF1SXVsWGNFVENUNW1kTmdMQ3lUUjROdVNG?=
 =?utf-8?B?VCtiN1BxM3NZRGozTEVjemkzV05mTVh5WlpjT0NEdU9TbGJBM3VBcmViSnhT?=
 =?utf-8?B?dnluYkNnR2RPSjh3c3F2ZDVNZWFGYU04YUsxOFhwNEpYZENEM0NYQ0hVNEU0?=
 =?utf-8?B?TElWNHFqWFc0ZThPaVhubmp3RTkvdVg1MW01ME4rNjR4bFJ2NEQrZllSL3o1?=
 =?utf-8?B?ZW1tMC94VkVGSU8yR3lqeWFpbXkvalQvb1hNdHpCT2dOVGxJK0VlS0t1b3FY?=
 =?utf-8?B?NEFZc2ZqZmhQdkovTjc3TGxsSmRPZkg2ZUR6dTExM1RLT0xDbGsvTDJHc3FM?=
 =?utf-8?B?bnltRENQWXVkZzh0VVM3c09XbTRDRzExL29TR3ZaVll0RTFxam5MNkgyUFNQ?=
 =?utf-8?B?bGhST3hLdmxXcFlWOVV2V2RQMnplekdhbDBHcFFuKzhoTmZZcXF6VnhYQnhU?=
 =?utf-8?B?M1craUpIS20rMmM4T0JJaGdTT0ttSU5pSTZmMHppR1RNR3dHdm9OYVBlVm94?=
 =?utf-8?B?WU1rYjlTSWl2emovVzZtVnR5dnhxTmoxOHN3UDYzbDcyRXVuWHNrSTIydFpT?=
 =?utf-8?B?N0RpVFFOSHN5a0Y0SC9sdXo1VDFWZTRkZEZId0RiMHNONVNkRlVsZXZtNFZC?=
 =?utf-8?B?YlNIQVdMTGlJSDFPNzhSanlxVGpOZzMweEVEcjBzVjlCcnc4bEJ1Tk9OaG9p?=
 =?utf-8?B?NG0rSDdMVGpQZFZxeE5sdHNubWFLYVhOdkZtR2Fma0N3cUYxcHFUOEorYTZ5?=
 =?utf-8?B?MWRGNkducldWc3hOcDBBdmZjNC9tUmZyVm4wVHNsNm5kN1FRS0hpNURaR3E5?=
 =?utf-8?B?Z2o0anptMFN5NE05RlZEb3VTcXZHaTRpaGplcFN4TzUrZFpJY3FQdGZNMlNJ?=
 =?utf-8?B?TmVXR0RMVGFvQkJ1VldWWnQyMTAwcXdWekJzYmgxMks0aWwreWp5SWtac3hD?=
 =?utf-8?B?UFBMZFNKWFNXckVhRTliU1UvYS9LbVRqYjJ4RDgxVmxnVENrRkFsdUpkY2d4?=
 =?utf-8?B?d2hkMW9ObGFBL0R4VllNYUZnU3F1UWZXOXdKZEl6SFlCMVRHZEdtbGU4QjRP?=
 =?utf-8?B?alhQNXN6eFNwN0RpM0lPVlhPa3dKVzVsSG1DVzB2aE5SNGJPS3pqOEpLVHNq?=
 =?utf-8?B?M1oyK0dadEtmYms1Y242SitmTjk2QUgzWXVva0dlZVBaOFJnWE9CcEtxakg5?=
 =?utf-8?B?RlNGbnFHNkNTVDhNNUd5QXpWY3dXd2FxVUxudEc0STNqdXJ1b05uOWJ0Zm02?=
 =?utf-8?B?THV4dFZ6MFVOOGlQSTBma0V3VCtpUTdmcDVCSFFWQW9HamVJdm5hMHNGbyt5?=
 =?utf-8?B?U2xFWmRaU1VDU2J5eEFvRmUzd2lzNFpweXBuZzVZbFB3OWJzVGNLUDJJRDRB?=
 =?utf-8?B?VUF5VHpLYitUT05KUTdEWnJVTGNaWUlzTUhqaUU5VFNCTUlPUzFOMzlmMnp2?=
 =?utf-8?B?d2Z3VTJSaEpSVElZUlVqOFNVWDVQV1ZTcXppNXN3UmVBZ2ZZSnd5bmZzNFJB?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f939b6-b44e-4339-c5bd-08da8549e9fc
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 20:56:13.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RKlwjl3ad0czons9+KvA1aDxQH3fYb06KQaAptb89HC8PvB1LaUZYv5e5Sjr8X8T490Pfr8CIdmLkmHfG7RQh/0U1wUAX3J6XGmRV4oRUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4925
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/22/2022 6:42 AM, Babu Moger wrote:
> AMD systems support zero CBM (capacity bit mask) for L3 allocation.
> That is reflected in rdt_init_res_defs_amd() by:
> 
> 	r->cache.arch_has_empty_bitmaps = true;
> 
> However given the unified code in cbm_validate(), checking for:
> 	val == 0 && !arch_has_empty_bitmaps
> 
> is not enough because of another check in cbm_validate():
> 
> 	if ((zero_bit - first_bit) < r->cache.min_cbm_bits)
> 
> The default value of r->cache.min_cbm_bits = 1.
> 
> Leading to:
> 
> 	$ cd /sys/fs/resctrl
> 	$ mkdir foo
> 	$ cd foo
> 	$ echo L3:0=0 > schemata
>           -bash: echo: write error: Invalid argument
> 	$ cat /sys/fs/resctrl/info/last_cmd_status
> 	  Need at least 1 bits in the mask
> 
> Fix the issue by initializing the min_cbm_bits to 0 for AMD. Also remove
> the default setting of min_cbm_bits and initialize it separately.
> 
> After the fix
> 	$ cd /sys/fs/resctrl
> 	$ mkdir foo
> 	$ cd foo
> 	$ echo L3:0=0 > schemata
> 	$ cat /sys/fs/resctrl/info/last_cmd_status
> 	  ok
> 
> Link: https://lore.kernel.org/lkml/20220517001234.3137157-1-eranian@google.com/
> Fixes: 316e7f901f5a ("x86/resctrl: Add struct rdt_cache::arch_has_{sparse, empty}_bitmaps")
> Signed-off-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index bb1c3f5f60c8..a5c51a14fbce 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -66,9 +66,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  			.rid			= RDT_RESOURCE_L3,
>  			.name			= "L3",
>  			.cache_level		= 3,
> -			.cache = {
> -				.min_cbm_bits	= 1,
> -			},
>  			.domains		= domain_init(RDT_RESOURCE_L3),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> @@ -83,9 +80,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  			.rid			= RDT_RESOURCE_L2,
>  			.name			= "L2",
>  			.cache_level		= 2,
> -			.cache = {
> -				.min_cbm_bits	= 1,
> -			},
>  			.domains		= domain_init(RDT_RESOURCE_L2),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> @@ -877,6 +871,7 @@ static __init void rdt_init_res_defs_intel(void)
>  			r->cache.arch_has_sparse_bitmaps = false;
>  			r->cache.arch_has_empty_bitmaps = false;
>  			r->cache.arch_has_per_cpu_cfg = false;
> +			r->cache.min_cbm_bits = 1;
>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>  			hw_res->msr_base = MSR_IA32_MBA_THRTL_BASE;
>  			hw_res->msr_update = mba_wrmsr_intel;
> @@ -897,6 +892,7 @@ static __init void rdt_init_res_defs_amd(void)
>  			r->cache.arch_has_sparse_bitmaps = true;
>  			r->cache.arch_has_empty_bitmaps = true;
>  			r->cache.arch_has_per_cpu_cfg = true;
> +			r->cache.min_cbm_bits = 0;
>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>  			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
>  			hw_res->msr_update = mba_wrmsr_amd;
> 
> 

Thank you for putting this together.

This change makes arch_has_empty_bitmaps redundant. Can it be removed?

Reinette
