Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98575A712D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiH3WzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiH3WzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:55:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515A712ABF;
        Tue, 30 Aug 2022 15:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661900101; x=1693436101;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Ke31ODcOlT7gqzOoodhnc/m7vW63L1EOmN3JnctG64=;
  b=FOwKBOo9QO1WafGEGUJnPiMCaatvf0FJW+r4p5rzjfz1VCZeNy7PgxhE
   Bx3kwVukSjdOJdFyv3dkQa4d1nLlMeirwrvAv0Yw6qQy0kcm3GC0ky2OI
   M2f6VKj7GCn0lKQGypJqCk08h8pFEmA46epMqEmc39pxmuUnDq9UvL0Hb
   wG7ol5nKdicj+vXl36hhRjtYqonYq7mltLNT4vV+Nit5Um+Je42qXN+46
   bRKtvvySXSm2y29dO9v0msFrxd5mRAfJ1KlDq0GNOnf0xjpWVz5kdawL5
   VSnTx2woUccj8GEF1kMDl7sLgMcBTTpPfiwQFT/BMy/CPJUU0W8v8+03a
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="295328513"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="295328513"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 15:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="562838804"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 15:54:59 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 15:54:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 15:54:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 30 Aug 2022 15:54:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 30 Aug 2022 15:54:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuBqeImzX13DxD/JD6BLn67+kaGyM/xion21JHVMC7uPkpoK1MR6IGemTLs/abIqsxEbhBJtif0gvgUBKvNWVR9ViZ1Tcm7ckMpM2bkZxszj+A4srJDoXgLJ13XCtjKS/SFhp6g8LJW7xT1DfSRani4jtyJfiEqE//oOz5wCoBMKPn9j7jyeLAmqxGY4bFLk2fggehWgQOPUSFKyunjEWz2lUSHUES6lPCo8wDMx128h/C5Ynrhco1g80CQOEY+mXB79dHzoBZZb2JiXKhYX6XIz1x7rZ6ZM4XLt/FyT+bbqG6gi+mG0VuzvfhS27r6BpuERemc4pfZ8srGFbt6zZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ka/x/cSZ6x7XSP0aADnKP/Gn67PPcWlJ4dHCCbls3I=;
 b=iyQHIdtdlkyYltro6Gj7Ugavzm2RmOf3fO3ucJN8l9ScUxlems8eTWFYw6tK7pUjP8JNz4ZjWeFEV3rqcDsqit5FtDn4RakQ8nWNndQk3NoUr+qMd5sv0WxbshLSxM9G5sh2wEDNXJJpfJJpSRSqUXJRBp9aR2FiN71kL/2kPhDxrcgxVKLrHOnN1ga3NVVSTTltNLpDrtCvucwJxJduwLk2zu4qlWdWB3F17deJyroDd51u4NrrlppFuhX5tgqDyQXrq5xsf4ikQfoY81IAY3pvnT5uaHjvlZWH3tV4U9ZffnEN3PRlDcCvT+tiY33b5HtbIfaNuozjQpAQ4l5d3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB6523.namprd11.prod.outlook.com (2603:10b6:510:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 22:54:57 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 22:54:57 +0000
Message-ID: <7be76cf8-28c4-edcf-aa67-703b5c18bef1@intel.com>
Date:   Tue, 30 Aug 2022 15:54:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH 2/6] x86/sgx: Handle VA page allocation failure for EAUG
 on PF.
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-3-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220830031206.13449-3-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e590abd2-ef4d-4feb-5aea-08da8adaa92f
X-MS-TrafficTypeDiagnostic: PH7PR11MB6523:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SmoClGZCgWryL7Lse7mpQ7++HXkvsepJkx5dgyr/Lv0dsKPUVpPQ8IGW1KvEDa8K5tYuk2yAuqhrsB2mpSG3v0/LWJF4Lg09u0Yrrnp8zhDXDmNbQSuIasRdkrOVEkliolUWxJdoYj6n0W37XtCZt/UpuJlfwAwrAiDxlm8hIMqyboNpI4Y9ZQ+7Y+weYvS/HeTLPkGP8BRRIvKnto78GZkQ8jDmUz1TcmzJOVFTZV2jMC7aXd75Qx2KbLVZHEtwko2D8K0jSftRefaDsd3PwmAGN8m4U23A2a6H1lZ99nIs9pDU6pQ5jpdoq+b1zOgjRyUnKwXaqpH5WqHZQ2fao55RFhjZM1yRHmSNwPUm/Tonhjk8hgkMWMsbaNKIHOAHOVoboOBUIP1ZC0rQi62Le4ZRTVjfnYSEYNw0oRY2d0bFx6b8vQneX/FS2wAqFj7jgymRJ0kfrJoN6UdgW/2QhWNkIIGnBxfhtsqTouL3gOo5PENFVTbnLinljqAsxKVmfTHnq84iLUJP9EOmQ4xXybK8/UJrZR600OLsyBRB3b2dKNMGdpl7b/v/4WqrmQfgz3H3uUPyCJLo0TWdgplyck1rZJHbrBKDT9LiadQjOOkgMyFm9VTBkKOXBx69JcUaBNEg628/XK3zlWRjF8ImWiQr7a6xK+1l7+GAICCOby5kRNJxY6lBNK2yyt/oQWe8dD3tyy9/MTeS0Ix1tNjB1zqvuplhHtgwzrS+ve0v71NTFu8q6aOkZcNV1SbIp089qXxMfNYMy18leuqGxnpI6kJZLZwF41DIlUwx0LMLQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(346002)(39860400002)(136003)(316002)(54906003)(86362001)(4326008)(31686004)(66556008)(6486002)(8676002)(66476007)(31696002)(66946007)(478600001)(82960400001)(36756003)(5660300002)(7416002)(41300700001)(8936002)(6666004)(2616005)(44832011)(6506007)(2906002)(53546011)(38100700002)(83380400001)(26005)(186003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STczUjlHZzdpVlViMkFVWmZqUmI0MUpMRUxxMHNQaDhnclFyNDJnaEFRVGlR?=
 =?utf-8?B?WkpLT09tcFNZV21zRkxwcFVzbFN0U2RBbUxINXFiUkZkempyd2NiN1dOU0VK?=
 =?utf-8?B?VmEzRGprM01XZDlMR3dmcllmMmkvVXlZNlpYcGpzWkhUb1BSRmtNR0tPdEpu?=
 =?utf-8?B?czdodTMxNFpwWmUrdWZsS29FZFNKclVEUUMwVnFQZXJOODk0amV6OVd4RXlX?=
 =?utf-8?B?YjZIMHhza3lqc21WT3NDd3dOOXY5cW9JQ280dFFqU1pUZElOMW9RS3IxREJS?=
 =?utf-8?B?OS91Y3JTRVZBWjk3eDFmTnp0SkJGdXQ0TFM3R0pCaDhMRWl4YkI2VGdHM2JL?=
 =?utf-8?B?MGVEaXQxWEtHZkRmMTZlbGpxZUowL3JreFExVk5vNWs1Mi9PcEpLWEllQS9K?=
 =?utf-8?B?WlczUDhSdVgvRXJMZzcwam90ajNINWN6dDBHQzhHcG5UOTIzT3EwL2h1MUU2?=
 =?utf-8?B?Q3A3RVZnSDhpSWtONUd4TStadnJyWGRnTVdTVDFOWVFwZlc3RUVLMkhmMWx1?=
 =?utf-8?B?MnVhWXhlWVpwRDgrMk5zeDJWTzViSEZNZVRmQzNJSWkvMVRTS2E3L0hJZVYw?=
 =?utf-8?B?Q20zNVVnU0pTdDlYZ255c3FNaWVocmhoK2xGeVlqSXA1Snh5Ui9xUVY3ek5W?=
 =?utf-8?B?T2tHZXA2ZE9KTk1WdmgyRGxkRFJXNkMwd2NSRHpSU2J3ckk3TE0yeGJVaVFW?=
 =?utf-8?B?eE1hQ2RWR280Sm1tVjhJUEllMy94VDVTdjRYTkRUdkpGZEpYangwM3BpbEpS?=
 =?utf-8?B?RFBTMmpzM1lTYm9KS2YyYWtJYytVZFBQQm9DeC9aQlIwcy9uYmkrN1ozUjVZ?=
 =?utf-8?B?djdKTTlLT0kvYlVrcFlxTkZSN0dXOEJZakQwd0tKME1GU3Q4My9TWjBxZEJU?=
 =?utf-8?B?b0tMTjlnb0p5WmZubkhnSTdma0ZYNXVPeHpjdzd3TjN0Y1ZwSy93a3oxQTZI?=
 =?utf-8?B?THlxQXdaZzdqcFpOWTJVc3lhcVlISG5GY1IvZTVjVnBzTWFSOFJWTjFxWStw?=
 =?utf-8?B?QnoyeW5CZm1nK3NmNzRESCtUa1BiaHhadlZFZkMxem5OaFFmVE9vZjRQYjdj?=
 =?utf-8?B?d3V0RTErZzdYY3I0ODViNGxFaFNyVTRMdE8zYlVGeDhaYThsZEJUaFdObEVU?=
 =?utf-8?B?RWlpRlZjeU1OWk80MGxFOGxOb2huWmVOZTFMcHRwWVEyWDBmWlRZZy94SVY4?=
 =?utf-8?B?QnpETjVMQnZyUU1BU1JISVNMMU4yTU9jaTdNMFVlQm0ydUY5cUpicE1aUzZO?=
 =?utf-8?B?aXNIYk1Dc3VkbjZNQjNKQTFHZUx2OWVNQURNSXFLNDcvRExzS0ErVGs0U1Zu?=
 =?utf-8?B?cms5WWJ2STA1K1JXeGZJNTVnak9USzlWS3o2aXZJM29pRzk1dGVleXRVZFF1?=
 =?utf-8?B?Y3h2aWsxZmNpRHdtUTh6TCtKSVI2cjBxcE9UellsUWN2bUZVOUJmcU9tMzFB?=
 =?utf-8?B?NlB5bGpOMDRPVEMyaGY5c1hWSFIrZGVxTlp4aFFiQldNMzRtYStqK0VXbW1r?=
 =?utf-8?B?cmZlZUcxaFhQN05mZlNuWGU4RS9pVTBVVW5MZnBUTzBNWENTVmI1MTF0ejhz?=
 =?utf-8?B?anllcUMrTWdRalo2Y21EancycmRpeXQyOW1lQmk0QVB0bGZ6WWtCdEh4U2VM?=
 =?utf-8?B?L3BpZmMxWEVNbjI0OWlMTnhPakluSUJtdm5jMm8vK0RyZ2RRM0JGWFg5SFgw?=
 =?utf-8?B?YjFaODNNZ0NwamtJcGlBNlNNNGdORFZxcC9LcGcvamFFc0U2b2F4d1FVWEpP?=
 =?utf-8?B?MDdQbjBYT294RkpqSEV3NjhCbllSZkNYc3I1aERjRklYSHJwUUJTTjhGQ3lL?=
 =?utf-8?B?OGVWa0NianlHUDlJT0JUSUR6NUM5bXJuSDBsQzlQOExHdTJJZTdXSDlBT1N3?=
 =?utf-8?B?NHVNYlFZQjFPMEQ0L2dWTC9LbHFkbjVsRFIwUVE2SHZLZXZ0a2RmVGhuNmFo?=
 =?utf-8?B?bVdvRzFZMC94OGFBT2p2K21YdjlJR2ZXekRPdXcxOVU5WUo1UTIzRkVqN0tR?=
 =?utf-8?B?VSszYm9vVGpIWWd3MndRRTBaNVZ6T3Q2MFFwWFFUYlhwT1ZmU1dvK2toWFNy?=
 =?utf-8?B?M0Q1cThaaW5tNW44b0JkakpyUzYyWEVDbWc4aWFsdDFIaDZqSnNYMGZLUnlv?=
 =?utf-8?B?ZVhHL1dMeUlxUWlvYVphUkhVZUpvMHFlM3JRdi84bEtaeDdGVTlta2dETFJh?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e590abd2-ef4d-4feb-5aea-08da8adaa92f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 22:54:57.3552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TH2JR3/bbpFTcMpdx/mxlyweFlnv6U+/SI2givzVwlXKh7cdDS5cHNYw2VWpXfkE8aGL5RyS73QK7Wqq7ndaKKePRLMTR35nrycZtcSqYXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6523
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko and Haitao,

On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> From: Haitao Huang <haitao.huang@linux.intel.com>
> 
> VM_FAULT_NOPAGE is expected behaviour for -EBUSY failure path, when
> augmenting a page, as this means that the reclaimer thread has been
> triggered, and the intention is just to round-trip in ring-3, and
> retry with a new page fault.

Thank you very much for finding and fixing this issue.

> 
> Fixes: 5a90d2c3f5ef ("x86/sgx: Support adding of pages to an initialized enclave")
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Tested-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> * Removed reviewed-by, no other changes.
> ---
>  arch/x86/kernel/cpu/sgx/encl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 24c1bb8eb196..de92c1c8b79d 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -344,8 +344,11 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
>  	}
>  
>  	va_page = sgx_encl_grow(encl, false);
> -	if (IS_ERR(va_page))
> +	if (IS_ERR(va_page)) {
> +		if (PTR_ERR(va_page) == -EBUSY)
> +			vmret =  VM_FAULT_NOPAGE;

Some unnecessary white space remained after the copy of this snippet. No
need to propagate that mistake.

>  		goto err_out_epc;
> +	}
>  
>  	if (va_page)
>  		list_add(&va_page->list, &encl->va_pages);


Apart from the white space nitpick this looks good.

Thank you very much.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
