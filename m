Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93091584614
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiG1Sql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiG1Sqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:46:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787C76D9E5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659033993; x=1690569993;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vDSRGi0PA2yWkrHRzC0vSLLS3Ov5GQ1z3TZDHCzKy8c=;
  b=lYcRIJtx/OqQEQ5lSm3gNgW76rvbz89ww9lS4GOUxJr1ed+MzZn1bQDi
   zMNutHDQMd/aZMZ+O6DtyNvfRcXapF+OHdiDhqxZwNAEbN9T0P28EKuM4
   HcqLEjBPHn463x8DDPqYV28lYzOLcgLd9rfpyLRLP+J992Hld4jpNDeUX
   /fKZVeX7LCZFzENRZskahMnPPHcAuCnkj+6ejPgI1//tD7p2K+NwliYg9
   cQwIg8SFoCl9EmXeFPCERV2/DuqLjG4cxuIS/CDqN2d1Ny4F3lBC3vy4u
   LPNiMiLOGX1YrUoAAmA5lYE5oRakWgmMvQxOHlSlL7PLk8DAcJpXc74Qy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="288602921"
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="288602921"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 11:46:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="743243567"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jul 2022 11:46:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 11:46:29 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 11:46:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 28 Jul 2022 11:46:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 28 Jul 2022 11:46:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OadegZy+EEb+b6Xrcrk/rQPbH+DY1nKffymC+V2Bo4JVcGrne/8kUs5iLvE2u9U7M7Tpc9aCH0NmrRodgKUj3yE+FiRAB9gPsBUwPIFJ/BWeKk6ahdpiXYvV0aRKQmYyXa2tw4qvgZUgd0gCwGZtuP9uaLGniHOwv1vxz1diH0LQUfBUpE+KW9qfTVocMLyAjPyWey65KT92ohNAWVD1HFpDGcSZIGArOjKxiy1g/eSn/NkVWYHyqALzTyI+SAofDkBW0WQU+lKW+C5w6+rCIWjVfWhl/MxpuW933ybuzv99cwcSWi3zN3FAf6k1HQnssm3kZJa2tz22qJ0eGWA1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRKIGYdvz59/TpUcL8U6ta6XM6skwT/Fpfl0FoenstI=;
 b=R/4AZNOzKh/9wWsdwxjxslhSFpeyHhg+Hx35hK9BwsynSY71bxHwo0nWPhkKiMzCFTzJ0aeeWXYFcxFt1Xuys9IxMGoYuR30N9pdJb18zNHTTTXz6fiMvfSUCnWPgm1ZFRQ3hGbHpD8ao5o0UKINLyYZxEemUuZMt/J/0Dn6urlo/3miSbbfxXkQT/cEO8khCGZPx2Olig5jHEjNU6ReKsWQO1ut3/q/+sHl3Pg83BOSKHttsDs/BqKFx+1EB7wXitoooo4rTWBJZvDmnO7IAvN6rfcCsxu52ayxFcNU1VyXH15HO458Gy7pG8BlQ8J0PU5f/gvspz5SWudqvUkCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BY5PR11MB3976.namprd11.prod.outlook.com (2603:10b6:a03:187::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 18:46:19 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::909:5c63:e681:db67]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::909:5c63:e681:db67%5]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 18:46:19 +0000
Message-ID: <799d314f-17c6-4898-1363-4360996d89be@intel.com>
Date:   Thu, 28 Jul 2022 11:46:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Content-Language: en-US
To:     Yi Sun <yi.sun@intel.com>
CC:     <tony.luck@intel.com>, <heng.su@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
References: <20220723083800.824442-1-yi.sun@intel.com>
 <20220723083800.824442-2-yi.sun@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20220723083800.824442-2-yi.sun@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::17) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ceca4c-781a-4648-c2bb-08da70c975c0
X-MS-TrafficTypeDiagnostic: BY5PR11MB3976:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fY5OP075EZY+buxFs6LpmqIv23BqtJNLuPpKjP0mr2GzryBt9w9be/pXNNG4ThsRVPLR9zfqggb5pwpujis7+0JI9oduvQy2GQA9xpOXMMOnj9/arQKsk12GnYVlBdNJsmHXRdjrMasgznvX+0mDSVRK6lrjdAvUm+nWvqfU3i02HphsnJxQTZNmIv5Eds+eOxQINSnLoof5KFKQ/7VT+/DWgOnzz+EttnedeGVl4eW06esyxDAquDcDAPbpEBM2dzozWUy4nM9VN3nr6CqpvNnmIqOTZz/0cPotUqdz0WprTuVNzqTVnlsTxI9CAhFSB9GqY/5duEPunzG5ZLYOAW0ImAMLYtvGK5kYpnwO1Zdn8xHIS+A2ZJDmmgt6kRRzQubWR8no0nzjDMgorewKSJXpzo6gqHG/ICVz7OtDi/jngNBnbwX/n3+z+dYirJuu7ss+kU/CpGrSDjmoYchvJVd5JjT9KB7rmj2aqDRuMI/wU+TrT4b5I5WrTmzfrSA5JpyjNnPJPqyx02OfgtaLi70KSO5ueV/sMkqtl/dLkAgjrpn9k6qFpj29D+1c1FHIbyQYaV6ztQgvL42T6x2dS2576v1++pN97SVvyKjIJbYq00F08SMsYQLfF3HfdUydtiTK0Cy2dHYn5ABClXTzs0sEHc0hq+rjzYQxyKqq94FgUyuI4B43YtUem1hAVlZd0hFSKcPnAeoiAcEzECpzQ9lfVpbcf08WyvCQ+3AFi+S6XKN1YjDw9yR4xe6AJ5SCRONYjUOBZ9zoeHGLS0P+fZ4QxOldhkN3JOuZ8vTs6N6UsIKRoF47IZQhg52tbNWg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(346002)(39860400002)(376002)(6506007)(41300700001)(66476007)(66556008)(4326008)(31696002)(2906002)(66946007)(478600001)(44832011)(6862004)(26005)(6512007)(6486002)(53546011)(8676002)(82960400001)(8936002)(86362001)(316002)(2616005)(5660300002)(36756003)(31686004)(186003)(6636002)(38100700002)(37006003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUhCZ3M1WXNobUNaMFFlMjhhUWdQU0NLL0IwS050Y2NvUTdQYVQyWkR1dnZs?=
 =?utf-8?B?R3B2dEVaYzZ4R2pqdm5MbWVINVIvUVBQS05iNEZMcEZhVG5iN1AyOVNBZFVa?=
 =?utf-8?B?Z2RGYXJmTlJVOEVBUmNDdTkrcUFNNW5mVHVtUnNlNUtvVWt6TjJ1dXIvMjA3?=
 =?utf-8?B?dVB6WHdFQ0ZUekZmQWJWRWJrS0JOUWNWdE5Xb1orOGErcXpmdUhHL2tBOTVN?=
 =?utf-8?B?MWloU2tmelFBY3dKL0xyRFEzWW5NZVhhR1JYbVlGdHRKVlBCT1E2L3lqL044?=
 =?utf-8?B?VjYzM0U5VkFUOGtRbGlDSDBvUXhLMk41RXd3T0h6ZklDYVBGbHVJMHgyU2F5?=
 =?utf-8?B?MWdXbUQvQ0l5KzF1Y2pmLzNDYXhGbFdBa2hpb0hkMVROd3E5NThCWTVyVjZI?=
 =?utf-8?B?NlZMUzRmWHJZbXI2S2cvU3p0MFRQd2VleUtEL1poMjhPZGc3VHQ0SERFNncw?=
 =?utf-8?B?RkdJMWNkZ3RWRStmcHV3bTIzQ0lzcXNuTkk5eVIwQk1qTXUxaEdUZ3BVeFhp?=
 =?utf-8?B?N0IrNlIya2FWTlZsV3VCMmtSNEMrdnlpWnQ1UUxibHZxSUlFQi92YWs4TDU2?=
 =?utf-8?B?U3hXeWhJTzA5OTQ3bDkyL3dIUmZ6Vllyb2JHditkWUxpdnhYb0pQNFJrNmhs?=
 =?utf-8?B?eTJYeEJzczRBZlE2MVdoRFA1RmZyWFI3UFEwZVdTeDZ4UWpLRGdMYlhxSEY0?=
 =?utf-8?B?WU9LVVE3QXFwQ1NnZjl6KzJscnczY2pNUjNSQS9uUTgrNDg5S1J2M29mMURC?=
 =?utf-8?B?bFdmaTkxclFjSDkxSjFhUXI2UTdFK3RZbDBSdUhrWEZXVXRTMGl4eFdVcTEz?=
 =?utf-8?B?M1lkaFRZOXY2THB4TFpCS0tKSTNXaVhIdnJ0VkErbVo1d3Bwc0NyVVhkSmd2?=
 =?utf-8?B?Y2d3bGMvVURBTzZTTnI2NE1ib2dmRU01TW53U0taUjdLR2YxUGhTcWRNZ3NO?=
 =?utf-8?B?ZEIvYllSWVhsWVhwUUQ3VW1QQk1vNkRidkwyNXhaV3JFZFhSMzdKd3JsSlox?=
 =?utf-8?B?WVNyT0RBQ3J1K2lHKzlDQmd6dFdwU200aEdWZWpCdTNiZnRUM1ZVQ3hhSnZw?=
 =?utf-8?B?MEtwYWVTbmoxOEtCZnRHNys4SGxlWU1wUUVRK0tiU2hYUjFvSVpkU0FVVkV0?=
 =?utf-8?B?bHlMT2ZMekUyMWQ0UmNMVEw1UmFEU3ZveXhneDUwYy9RVldiQkJBQ1NXdDRn?=
 =?utf-8?B?N2VLclZITnBPZ1h3ekVyNjBmVEVzMWZZbk9aWjFVVTJzd1U3Uy9Fd1JNeE9S?=
 =?utf-8?B?eEwvWWtEMWN0MkRpL1Y2aGxxTVBrL05VaXY5Rmw0aEhIL09UWjlNYmZ5R1Jw?=
 =?utf-8?B?QTJ6U0FsMUNhOFVwUFY3cnZnVVVGdzZhV2RKeFhDVFdnVFRrTk9VcG8rdkVp?=
 =?utf-8?B?a25NMEtMRkpud3NjVmxVZ1BIV0xQWFRONDAyUGdFZVhWdGI1UnhMUFRyd3gx?=
 =?utf-8?B?ZXo2bWY1SjBhTmtCS2xFNVBwck9YQnlndWVlN3lhY3NzTHAxeEdaOHMyaUl2?=
 =?utf-8?B?SVZnNjM2c0VwWGkyb2ZPdGxXZVhMeWo5eTdvUmFtTHNqanpGTFBsYktQdCtv?=
 =?utf-8?B?akdJbFpuNERBQldxaERDQXo2UUxnREllaFlCeWFrMUZ1ZHBXRVFRZWtvZXhm?=
 =?utf-8?B?SnNpQ0c2QWpIUm95Unh5MmdvTGNPd1JSdC9MdnpMOWtMbVp6QTNUeTdkOTYx?=
 =?utf-8?B?NW1pSnYvbVJkZnFZem1ySU9zeWcwUTFIaGlNU0lITnlJSDVvRGZBQ2lzRlNr?=
 =?utf-8?B?SmROU1ZDRStDcnYwY0JkSy9hNzRnMi9WdnNkc3pPTmJpQzAxK1h4TW41ZzlX?=
 =?utf-8?B?TEI3YlJ0RThhZGZtb29VclQ4UVpuNmFSWVhxcTlpTkRWYTJOSVo4L0Q4SEU0?=
 =?utf-8?B?VjUybDBTZDNuOVY1ZUYrK0g2Um9qUmlFM1ROSlp6eHZkQ3ZWQjdRbEpmSENk?=
 =?utf-8?B?eDN0cWIrTjZNd25CVFovcDZmMnRhYXJiUUdldUJqV3RuV0h5aDdHNE0zajRm?=
 =?utf-8?B?Q2RHMk1NMWRHdkY2WjdIdlFyZXU2dXRFalBnWVVmMXNKVStvSllxUGhWNjdk?=
 =?utf-8?B?UEV4N3Y5TDVQbXZOVlptL0ZUdlY0ajRUM3llZjM5THZYajdOQUV2bkUxbENZ?=
 =?utf-8?Q?rtyKh1UHPMmfbs7ogGbOKSTYe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ceca4c-781a-4648-c2bb-08da70c975c0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 18:46:19.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iocrDnRMaslM5zpHdAVIaxbj8t9ndM6ouZGjuFD+Pq92LGAwnP4qowNZRzsT8pxGG8NMtJwYmAkpg/z5eJZy/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3976
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some nits below:

On 7/23/2022 1:37 AM, Yi Sun wrote:
> Calculate the latency of instructions xsave and xrstor with new trace
> points x86_fpu_latency_xsave and x86_fpu_latency_xrstor.
> 
> The delta TSC can be calculated within a single trace event. 

s/can be/is

Another
> option considered was to have 2 separated trace events marking the
> start and finish of the xsave/xrstor instructions. The delta TSC was
> calculated from the 2 trace points in user space, but there was
> significant overhead added by the trace function itself.
> 

...

> 
> To enable it, CONFIG_X86_DEBUG_FPU and CONFIG_TRACEPOINTS are required.
> The compiler can get rid of all the extra crust when either of the two

s/can/will


> configs is disabled.
> 

> If both of the two configs are enabled, xsave/xrstor_tracing_enabled

s/two/

> would be reduced to a static check for tracing enabled. Thus, in the
> fast path there would be only 2 additional static checks.

...

> Leave the noise here instead of additional
> conditions before calling the x86_fpu_latency_* because that makes the
> latency more accurate and it's easy to filer the noise out by the

s/filer/filter

> following consuming script.

...

>   
> +DECLARE_EVENT_CLASS(x86_fpu_latency,
> +	TP_PROTO(struct fpstate *fpstate, u64 dtsc),

On x86, though TSC is the underlying counter for trace_clock(), it might 
be useful to keep this generic.

s/dtsc/latency

"latency" would match the printk below as well.

> +	TP_ARGS(fpstate, dtsc),
> +
> +	TP_STRUCT__entry(
> +		__field(struct fpstate *, fpstate)
> +		__field(u64, dtsc)
> +		__field(u64, rfbm)
> +		__field(u64, xinuse)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->fpstate = fpstate;
> +		__entry->dtsc = dtsc;
> +		__entry->rfbm = fpstate->xfeatures;
> +		__entry->xinuse = fpstate->regs.xsave.header.xfeatures;
> +	),
> +
> +	TP_printk("x86/fpu: latency:%lld RFBM:0x%llx XINUSE:0x%llx",
> +		__entry->dtsc,
> +		__entry->rfbm,
> +		__entry->xinuse
> +	)
> +);
> +

-Sohil
