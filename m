Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351204D06FD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244880AbiCGSzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243098AbiCGSzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:55:07 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3016C71C9D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646679253; x=1678215253;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rPjUF/3bsSaR432bJiLAshqKbCl3CiENyMRq5nPDQbY=;
  b=KBFYmYOlhSKwb4HR9NSZCuosV1TijGLvjZix09RxCG4x0B5auJhMhaue
   TA0S1xt0RVsHEtMHUfFbw/XFoE5YDd6yHfixFpzkuSkH9BY1RjMhDeJ7e
   J6AI6eIYGHhnwwwumbKntk7ma2xEJrFfaYlRQPhDJZ41Z0MYCsybSFUrW
   cqwdGNCIlpG0uTjDn4h7plYFYtUXXViMU1dSui/lxhHPzkWywnUXWY+al
   TNYrEMUAachIoQ7qvAtrHmyyWNIWtOJ3Expe4wqs8WzABYOH9rar4nZtU
   zjBVphU60A1deAqg5loTHLkfK9Qvrro2QEgm1gKSb6S/CZdT5SdN8YKLK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="279180941"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="279180941"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 10:54:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="553280711"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 07 Mar 2022 10:54:04 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 10:54:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 7 Mar 2022 10:54:04 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 7 Mar 2022 10:54:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5j4uxjohWVQJNuKCrq0oS8vEYClcmN/danu1Y/UwWzwKaKG/Os1QY+mwCYCh3QSjZhaO9csIDOw7iT8vJAZA/U3Fh3s5niRTkS68BktwstpNFw0ezg6aEZcjn873PSZ5GHGUMpvKAj7GRBV917Q7Txprc/5bRVktcflYlMSL4M/MNuydW5R5Jt99BmtW2Tlf3brdOIvqAzX5mU6BHZfddxU/yU51RUuMV24ChDyvfv/L7VrUPI+QyKjjP43+fcY4Vy8FECbClRPhJ73V/S3YFlyCYmszORuqzqLtyiKNVTawi/wAJgopdfInjcGIdjqQyCAvtGaF8Ln3EOmqwXFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWtuHHofIZ8jCwi2ALKMAwFL1IXvdAkEY7KAhFUPirs=;
 b=JrDnN20sAX4cHjXYpFS3cZSBc788NDDDcrngnfZ5jURXQbwctPsfgqbWsB4vSHJbfd+INfPbSQwDYsukhxhgnY9WFGmsfnJ3FvkbhKkSvpqgGrukKaXfihG5TOT/IRWfVzVgJdjNFpBA3GIHnSLTd29wJW/TjWwEHd0NaBNrN+QHe2ydw0O5V3CMR/U6CZKS+LpVu6O8QZLYTAMtkqDg4i8V30kA+wO47xUkpugVNLF2HKt/rX1F5yxc+CnI/rHVzXLZzC8StK7hRBHRLJflwOfAwnUKRQum0uV67r9a/IPHkaizMcuvGfDeu3ZFROrFkR2UAq4qidzrnXfSVxIY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by BL0PR11MB3170.namprd11.prod.outlook.com (2603:10b6:208:64::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 18:54:02 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::c044:86e4:5f8:e345]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::c044:86e4:5f8:e345%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 18:54:02 +0000
Message-ID: <2a2e7a8a-6cd3-1392-b080-54161b990ff0@intel.com>
Date:   Mon, 7 Mar 2022 10:53:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 1/2] x86/arch_prctl: Fix the ARCH_REQ_XCOMP_PERM
 implementation
Content-Language: en-CA
To:     Hao Xiang <hao.xiang@linux.alibaba.com>, <yang.zhong@intel.com>
CC:     <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <ravi.v.shankar@intel.com>, <tglx@linutronix.de>, <x86@kernel.org>
References: <20220129173647.27981-2-chang.seok.bae@intel.com>
 <98d5a389-6856-0cec-b730-65f609ff15db@linux.alibaba.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <98d5a389-6856-0cec-b730-65f609ff15db@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::37) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fd4358e-8a0a-4daf-e046-08da006bd85d
X-MS-TrafficTypeDiagnostic: BL0PR11MB3170:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BL0PR11MB3170A5E3D5D311312D0BE682D8089@BL0PR11MB3170.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRKZuS/B3IjxprwQgIyeeusC++1PzKg0K9icSF9xoNnW5s9Nr3mPI2sH/lSo6YfkAvIy0AF8qdqK+8unosdKw8T4Uuan9PV3IKJEtT4wfUzbZM6cgovcerprRJ+Jk74QJMO9LdpvPHt16maeTwtwD9m76uiMRas2jiUZnnKUDL63N93SvHrckbG6boH6AKUkVIFfGMs+tFZMNG7dcxsC17qmOi2jRs7vyDIoESoIi+1KJEeejscyF/IuBHHyVrbshOOYaGYp1LiySVlDvu9G+kze/9pFF52/AYwRad3X8nkNOTjWjFz1eOAY+vdDcz7D4RtYaoaIot69ZxQh5SBsuXlW89KRdo9mwtRAS3nAygUJDJGGCFlJUZfsxhcYf2gZe+aKmwpCMeInlq9jMUM2TEnDPETVD7nhuqL3L2DH6sZs6cSbwC/e2URG0zfY3y+IQ58v3yWgLNPD/o7XkFtCRPHnfY5+R/QCxywbha1LQ29QnEyNyxVRlqB5+hGgtxB1/zQMc5BEdisTL1yJMu9+nBcvH6Fb+dmZrQT1KgNlRgP8XIdVF8uWQcn9FUlkzBxMJd+bUwJYt3K1WD2C+sPg6ZoUhD7qW61rrw84uGZFvNEoVhBGr0xwOOd8j8OjeC9T3I8KEYkWVg91/biTKFJiySPaJpSQO7uQRtomwz08MZs7FjP550D0rYJdAj6qbvS2kkvm9kGCh8CiCJ3XPlKG0MmRslBYRHAMExRyYKigWgVVs/mwtdI0vPPvcL1Y3IEpbLBGmBXe9rlOrY2VaYhrpf+sYRaEXyKhA69KrV+DF5n+OxoslQKzWwzx+E7Yph9u26YXWo2wh+GL4VcibqYMF7vR0bH4FPRuoG8RRmMK8MA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(66946007)(4326008)(8676002)(66556008)(66476007)(6506007)(38100700002)(8936002)(5660300002)(6636002)(316002)(2906002)(36756003)(186003)(6512007)(53546011)(6486002)(966005)(86362001)(31696002)(26005)(6666004)(508600001)(83380400001)(82960400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym4yemtCRGFUdUpCOENGbnM3ZEZrQzR4MnkzWm5EYkNVcy9OeE9JUHd0QmhM?=
 =?utf-8?B?K0ZCR2R4dTh0SWhLQWNxSTRBR3doQzNQcTkrRHMrcyt0VUZkZjFZYWFUVE96?=
 =?utf-8?B?blhiYlNNM0FHaVlGNGd4bzdSOGFTeFg3Q2ZYdXlOVmdhN3RDME1pZkpuUEs5?=
 =?utf-8?B?M1hJQ3UwK3ZjRTN5MXFHcGlYMkx4NVZ4Si9JU2VZOS9ad3p5M280YmcxdkFs?=
 =?utf-8?B?UG82dkxyOVpOUGVwOGNSMjF2UFFOTlNBQTlYSGlQWXdXSFdHa3JBaWpjU0Qx?=
 =?utf-8?B?Sjl3ZXZpVE85by9HU3dSa0thZXVEdUJ6TFZmU1JyYzdOd0lYQmpLWXhmME0w?=
 =?utf-8?B?L0VyK2JsZzVLU0laeGVuNnFGSmp2OWlQcXEycng2WWpqaTdaRThEM1NpamFP?=
 =?utf-8?B?SlJDczFRdi9wV2ZvNmgySCs5dU9wZGFwazBQU0ZOallZWEZOT0lnTWpKZ1Ry?=
 =?utf-8?B?UHFrOXd1QlpkditmOGNxbHQybEpKQnBGU3pTbUNIS2dKcEhhNnNBbVE0UFY1?=
 =?utf-8?B?b0h3UTR4ajJTd0IzTEdNZlMvSDFKcVlyR0hhQUxrSkxVZnZpQi9XY2FLZDZK?=
 =?utf-8?B?U3RHazRXckZUcUhYckt5SGxqM1k0Z213NHlERjVVZE1HWG5wWDZjNmJZN1FP?=
 =?utf-8?B?aExrWEl6cjFndGxzZ2V0WlhneDJCL2R1bHdKMHc0c3orWlU3Q2pXY0lQc2Zl?=
 =?utf-8?B?aVZPRXdBQWt0SlJZOGpuckpEM1F0MlhMTHh6VWJyYU4rR1FkL1E4MUNxb0JY?=
 =?utf-8?B?aXNHMFJ4QzNZdHlnZTlsUXUwT21YdUhvNUVCc1NzWGt2NlBDNEx4NTZDRkJx?=
 =?utf-8?B?by84WEJMMU9tcDdPOEJaRGJiMGxLYVU4ZisxaktwcFJoUU9jalJQa2NkNWV4?=
 =?utf-8?B?SzlIbnhURHI4UkpTVHIvWnUzTFhkRXBweFphVVVuUzdMbjVhbVVhK2NXOHVP?=
 =?utf-8?B?ejBSMGhsMjJpbS9PSkJrbjl1ZnhXMDFRUnQ3VEM1SW80Y2E2RFg4TVpGSVpx?=
 =?utf-8?B?OGgxN2VhcTRYU1NicVFWTWFyYzQ5ZnVFbDIxM3JDZ1NOYkI3WUFONzlHU3lL?=
 =?utf-8?B?MkFjbis2ZVVpV3lhWmtLUXA4TXhxUVVRZlRhTXdqOUo2SS9FZXFvWVN5VjBO?=
 =?utf-8?B?YXh3SDVOQm1weEMxMFJ2SEpVTVQreXByNFhQa0JKMXczd294S1MvQ3hpcFZZ?=
 =?utf-8?B?aDBFZDl6MEI1eGU5ZnBVYnRteXFiUUZycUVCTEEzRFV5LzVreWgrcmRZdnZJ?=
 =?utf-8?B?YUlTcGhwTG5GS1NEeEhqT2pvN0diOXVoclQ2bUtTL3FJTnZnYnNDZUxDRXRh?=
 =?utf-8?B?cGM3aTBZRnhzeWZNTkNsakhJdFJXRXpscVR1QU9wMGF0dWxRWTRTenVWY3B0?=
 =?utf-8?B?Mm5WT0RjVGR4MDJ3Q1V2UmVSMW9IRVlBVkVmNVA5bXFBV0VmYzJyUklpT0h3?=
 =?utf-8?B?aThvNld6UEUwZ3JFeEVPcW9yT2kzOEpuamNJTUoyalM2dERNUFpZZStJMzA0?=
 =?utf-8?B?RUJzYXJTYlhEUmNjNS9OaDZ1NjFrOXVhNWlsd2NkSnFlQ01MeDJaVmRLazNq?=
 =?utf-8?B?RmUxWTdJTTFXdmdhc3N4RnU1bXdyTkQ2UmtuNWFwSzFMR24yYmRyS1pYcVdG?=
 =?utf-8?B?RmhlSHBKbFErdStINU51RjlSQjVIamJGWllXa2dtT3daMnlURHVONnZuTlZG?=
 =?utf-8?B?dStOdzhvajE1RkVSTit3dFpBOVkrZTVQazNUUXpLQmtqc3lvbkFVbGVsSjVS?=
 =?utf-8?B?ZmdjODgwd2dLMFJVVXZsa290eko0cTlvS0U1YzZndWZiWWxPa1hqRkw0S2po?=
 =?utf-8?B?Z0M2a2ZRZDRnbTJ3SGpNdnQzVEtVdzkrMGhnekk5NUxtMGp2TDl2T3pQd3Ni?=
 =?utf-8?B?ZExSYW8zUE9Gd29xTTdIUURHZS9LYVgrQjZIbWEyS0JBa3grWjRRdmNNVUtH?=
 =?utf-8?B?bTAxcG5EYXN0Sk5mdzkrQzF4ekJpOGxqMDV0VVNlNlB3d1FNL2dPMmZZQ1p1?=
 =?utf-8?B?QUw5a1JvQjZVemRIRHVKVk5sZWp4MFd3bDZydm5KZWtRdmd1Rkw3MEdxNUhO?=
 =?utf-8?B?MXM1bmd6eXdxN093T0JQV1l3SFlGbGtoY2RyK2JTbFdrSUtvL3Q1dDhueTJ1?=
 =?utf-8?B?TWgvbmNEcEJDSGNoRDZMeVdjZEk1RG9qQ0NEeW5jeGRKbmhaa0t0YndIcTN5?=
 =?utf-8?B?czhwcGNuN1UzVjdvcXZJRlpsY04wNjdqajU3OXFwSlYyVVk3TDB3dnQzZnVk?=
 =?utf-8?B?Q1kvRjhhTjRLMDlhb0RlQ211Z1p3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd4358e-8a0a-4daf-e046-08da006bd85d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 18:54:01.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkEG+RSeHIUZyFOB6vnJa/SCSriJnCaTSmi3TFt95SZ++PlB89AcYiexsjcjElDiXN7B4hln5Hwps+KFflcFznrGdc4vZW6QspphrwycQgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3170
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/2022 4:20 AM, Hao Xiang wrote:
> x86/arch_prctl: Fix the ARCH_REQ_XCOMP_PERM implementation
> 
> If WRITE_ONCE(perm->__state_perm, requested) is modified to
> WRITE_ONCE(perm->__state_perm, mask), When the qemu process does not 
> request the XFEATURE_MASK_XTILE_DATA xsave state permission, there may 
> be a gp error (kvm: kvm_set_xcr line 1091 inject gp fault with cpl 0) 
> because __kvm_set_xcr return 1.

What you said here does not make sense to me. When the Qemu process does 
not request XTILEDATA, then the __xstate_request_perm() function is 
never called in this, no?

> 
> static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr){
>      ...
>      // xcr0 includes XFEATURE_MASK_XTILE_CFG by default.
>      if ((xcr0 & XFEATURE_MASK_XTILE) &&
>          ((xcr0 & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE))
>          return 1;
>      ...
> }
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 02b3dda..2d4363e 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1636,7 +1636,7 @@ static int __xstate_request_perm(u64 permitted, 
> u64 requested, bool guest)
> 
>          perm = guest ? &fpu->guest_perm : &fpu->perm;
>          /* Pairs with the READ_ONCE() in xstate_get_group_perm() */
> -       WRITE_ONCE(perm->__state_perm, requested);
> +       WRITE_ONCE(perm->__state_perm, mask);
>          /* Protected by sighand lock */
>          perm->__state_size = ksize;
>          perm->__user_state_size = usize;
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 494d4d3..e8704568 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -908,6 +908,9 @@ static inline int __do_cpuid_func(struct 
> kvm_cpuid_array *array, u32 function)
>                  break;
>          case 0xd: {
>                  u64 permitted_xcr0 = supported_xcr0 & 
> xstate_get_guest_group_perm();

Yang, I think you should have included your fix [1] in your series [2] 
in the first place, before using it widely like [3].

> +               permitted_xcr0 = ((permitted_xcr0 & 
> XFEATURES_MASK_XTILE) != XFEATURES_MASK_XTILE)
> +                               ? permitted_xcr0
> +                               : permitted_xcr0 & ~XFEATURES_MASK_XTILE;
>                  u64 permitted_xss = supported_xss;
> 
>                  entry->eax &= permitted_xcr0;
> 

Well, first of all, one patch should fix one issue, not two or more, no?

But this hunk looks duplicate with this [4].

Thanks,
Chang


[1] https://lore.kernel.org/lkml/20211108222815.4078-1-yang.zhong@intel.com/
[2] 
https://lore.kernel.org/lkml/20220105123532.12586-1-yang.zhong@intel.com/
[3] 
https://lore.kernel.org/lkml/20220105123532.12586-2-yang.zhong@intel.com/
[4] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kvm/x86.c#n1033
