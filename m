Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC01511059
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 06:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357760AbiD0FCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345295AbiD0FCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:02:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A546E8FA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651035573; x=1682571573;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fxkEcqZB1yzRLzqNH0I/NDORXzX/leUCeb9pvCXWQvM=;
  b=ArzsXBkhmgEr/OPfRU37Jp0RSzTed+LK6lPiRiSAVURsAArC1pPRyuer
   UzU6B2rhCkyEpayKXY8aa8XALILtPzykgJ6Fee20v23fpr1inf23B42xk
   Til7MEqRABr6SmekV60z7suNw5M7fVVdjdFCHx2a5Yyp/K+rJJa4AXgtb
   YcQPbHKiNbidBFXS/3p2VBYUk/Su2wyRpgrlQJK9St1V1NNn3x/iBNJYI
   DH+me6ImxhEJC92gJE34DE7AduZaZhI8hn1fJQFsx86u/Ky0OzkZa03iv
   U12uzaNBbnv5z7j1EFfLRnVxj/53U3w8DXoEd0ZgjZN8/gnQpWKsBxjMT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265339112"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="265339112"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 21:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="513505406"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 26 Apr 2022 21:59:32 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 26 Apr 2022 21:59:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 26 Apr 2022 21:59:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 26 Apr 2022 21:59:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+v5ExskKILAjLU8kFEQTcbUIywUWC/xrGdUxk3UsFvZq5Vp2VY91xadn0HlkFvAyZOWiSRjQBoPAbxTqgpdNS02iiwtnXW6v9gvjIttCDTnhbSlKXNmAxga7RGC4ncdf2V5WZQPr1VGIdG0jDo0b3z6BnF7OOpevzGA3EOwcInobZSLQ6ka7Wm7xE9jTs24zItmAPKv4IFbHPPDCWqneZD/DxJtOkkXRTHPO6HZkS8jWAeOgJfHSapvgx0T6jyIUhJ6hG5BLhKdBOkrDRsUWyCgzmf+3lBuBpCCDAqFE52iTZc7Ia+bcksrIiERusSFywGIiPfYgLDROkWvDQNgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0basRAg4rsbk6eYa2hKCLqAUYP+KRoB64tyaHbCJb0=;
 b=S+EQnq1NzEqYI2jCERqkGrfFyP/ERYk4yP7+bNLdrfZLH6AOMsPnd9NFSwi6bmYWuDzIZpxDlQ4bRixjVNeNf1thz58B0uD6SfcK/Rs4fqwTmo28bvAn7XxUhI4zFbuNOAPf/mQrPUbfc/3ZPkA/jb+SuAHVCW7Xwwz1W7k7FuGjArSgow+d7mxW2TYGfmrSHd1M7UtTS9OlZINURLJZOhod4cdFfiDR7aiNcmzOJfYiWJqD3SmZStuwbtI/Lgn7rsMn/Herq35gBRLAt3gxDl2p4weHK7j6ffcCAJu2d7+8Np6eTvYXLZwrLCdDGgB2IcN29AMo1tEEbzKwY93Arg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 by MN2PR11MB3902.namprd11.prod.outlook.com (2603:10b6:208:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 04:59:29 +0000
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::100a:9eb5:3716:c6b1]) by SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::100a:9eb5:3716:c6b1%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 04:59:29 +0000
Message-ID: <1971eb3a-d689-8b35-e500-8a60f41765db@intel.com>
Date:   Wed, 27 Apr 2022 12:59:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [memcg] a8c49af3be: hackbench.throughput -13.7% regression
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
CC:     kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, Ying <ying.huang@intel.com>,
        <feng.tang@intel.com>, <zhengjun.xing@linux.intel.com>
References: <20220420055807.GA16310@xsang-OptiPlex-9020>
 <43598597-72e1-6750-9bee-031fd463fc3b@intel.com>
 <CAJD7tkaDWtgy3Ckhgo+vcbM7oYA8saPCVRvXLDKYHvRGYkKvoQ@mail.gmail.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAJD7tkaDWtgy3Ckhgo+vcbM7oYA8saPCVRvXLDKYHvRGYkKvoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0211.apcprd02.prod.outlook.com
 (2603:1096:201:20::23) To SJ0PR11MB4831.namprd11.prod.outlook.com
 (2603:10b6:a03:2d2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f13b4d6-52cd-4668-2f5a-08da280ab5f8
X-MS-TrafficTypeDiagnostic: MN2PR11MB3902:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR11MB3902411FDA6172B039F0678AEEFA9@MN2PR11MB3902.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XkArJdGbIza5z3PULZAYnsYAWxmJkqqnwEU8zFFtGb2bK31cHwTKucsf+7sZa3ylOedAwk8C5xST4kIKAJNjaQIyYub7VFccm0hS+YNCl3XsTWc04gMSaN1g1kMsBr5GwUs740HjFHffCjn5A78PGltl0bxGQZERsGeTML4llXah5pnkd6oX4GWphjR/X2zyynqlt5HVbBIQJYlYEx4v5bzHmyCeaSP7YFH9SW1pg76SY3+6eU9pM4/P0KFBXLBsAFcQ2gkGDbE08fJkj7uCA3QpCsW2Wibh7gbPub5jEacmzRR9QhxZY6ji4boIQJrlNTIss9EB1mgDvVnTiy8cXj6qTnx0lVta1XgSNtURAVkKJCL9xhJAN6wqwQRWAqksBRa3jlfwQIIiQJO36IBvNPHidPPLnXxJYdYtJKxoMTSTBwiaN6t6EjLALhD+7QMENc4YkHlDLRiUUDjVPFRMzMz3fbkYFQNJ/cqlc8SrOOhchC0OE5gj8AukqkvttTbAa5kf9lCO778v9NgzNQ3mOH5dM+BHbpaye6eKDhLstm82hTv/nFxbqddyuIfOceIfeN3d1MYQ3J18JNADXpnl2GdJqFZwfZQf331dmEBhq86w15Y33pLS+I8WJ0pbdMhtLpl7hkYd3aj1+S/qBloKbUqXZFZE8XEkapgburvD/kR0+HIkjSChQ4i1h/dN3KwcCYZSmE4qBloZbzfovCUjE/RG4YxFdawQGbyD1wrDUCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4831.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(6486002)(26005)(82960400001)(66946007)(8676002)(36756003)(66476007)(6512007)(5660300002)(7416002)(6506007)(31696002)(86362001)(6666004)(4744005)(508600001)(38100700002)(2906002)(53546011)(4326008)(83380400001)(8936002)(54906003)(6916009)(316002)(31686004)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHdNT1hiOG93VDg1ak43disvNXEvRmd5QnZCbWNXVWlxOHRIdEk5TDRxSTRn?=
 =?utf-8?B?alNVSzNSU25FR2o4SWNBd3Y2eE8xanJUYUF3OFVzUjVHcFA3ZVVRL0Y2MGlG?=
 =?utf-8?B?OEJYMUQ3ak1sLzg5YmYxSDloVC84TDU0cnNJYWdUUytEMWNSeW9ja1E2eDFs?=
 =?utf-8?B?eDhqZkVaZDBBMlJvNlAyTVcyOFBTYzFXSkVic0xOZGZmWHBZcGUzUGUxSUpi?=
 =?utf-8?B?YVAzSngyVmxUVnJOYWZZWlk3eFRtSkJkU0hTbEQzbTFCWVJJRGpTVUJyeGM3?=
 =?utf-8?B?d1dQZFo3TUQyVzFhd3AzMTBwMEd5d2N6RGlPd3RrY0k3a09McHNLUzVhci9q?=
 =?utf-8?B?cFRnaURPQmU3ZXExMVhoTWtPcktPNkE3OWlFdXl1WFNKSlk2V2c3d3dsNnE5?=
 =?utf-8?B?L2xUaW1LdElRRm1rdDdCZ2RrNHRsRVludjNWOVl5V0dXUG5IaTFtdndxWHc4?=
 =?utf-8?B?SDYybnFLbkJmRVpmbnBEYk1YTUl4RXJZTHdhQUZMZEM2bHJPNFVPWHJ0RzNK?=
 =?utf-8?B?SERKK284Z3JXdHBsRjlhbVU5WTZyMG1mY1lNcUxjTEpjL2xIa1NNaTZBN2VL?=
 =?utf-8?B?SHh1U3JzZ0pmb2duM2pNSjNtTFVQUkpQaEVNUWcyd1dwSkFIbzA1NVVTTW1y?=
 =?utf-8?B?SkVXT2Q2dFV2QndLNzdSZWxjUmw4R0dIMldUUHdZV2RtWTJHb2lhRnR3MkFa?=
 =?utf-8?B?ZVlGREdWQVpkZXVIOFRLazkvR2xNbkN1eHlZTXljejBoWGxHMG9reUFEVEZU?=
 =?utf-8?B?ZHJxeWRxak1vYjhLWlR3WDdnYkRyNktlNmJxRFRmWmpVUURuS3Z0bVk5YnFh?=
 =?utf-8?B?d29aWkxHWCt0WXlGWVhBZnVIQ2xUclh6YXZBaWUwTGhUS2w5L0pBTld4aUJE?=
 =?utf-8?B?eTdHSGVuRnhvaDRqZTl3aVdhU0Vld0srY1R0NmdWcGx6aDR3RTdsaWc4ZWoz?=
 =?utf-8?B?WG9vaDJPa3NOUnY2bnlmSWlSbjBaTVFyemFpcVhxalYrSWdDRDFrdjZzTGNB?=
 =?utf-8?B?R2RydCs1UXUxRlhUcllFSHFDUXpGRm1Sb1RWRGU2M3VKR29FU3VyQWl3UWJX?=
 =?utf-8?B?NmtUMEIzcjNxRDh0OHBZbllzWmtIWjJ0ZTZxR2JNUlV1NEJWTnE2MTYzOXU1?=
 =?utf-8?B?Q05xbW52TVlldjZzWnNJWEdqSjN3Q28wQVZwcStVb05Zb0JHVmJXUnBNTEZo?=
 =?utf-8?B?VC9WQSt4TmdyTmIyL3Raa0RMSkZpcXRQZjZDd2lsY0tpTUpuaCtjRmxJTG52?=
 =?utf-8?B?d3hQRjBTTE5KTmtMcGZNbkE4YnlRNm1KVURoZmZBSHhkQ2Mvdm9udGZSVW04?=
 =?utf-8?B?K3dpdGpEZXJXdVdFNmxoYnBzVS9TUE5pRjZxYjZpSGJWTWQ5NUI1SHV0Vi9N?=
 =?utf-8?B?SDdJVWNNQm5IcXZMZ2orVWJkcGtFdHBoWG5aZFpuU2E2S0M5eDFqamYxMnY1?=
 =?utf-8?B?TXJQTisvQmtiR2tRQXhNNHdzL09jSDY4ODlNdTVDaVFGK2laK0NubkY4cEJT?=
 =?utf-8?B?eGpDajcyNlNCdUhZdlcrdkl5LzIybnFCcVR4TVZqdGRhUXZXMDRYS1NOcGc0?=
 =?utf-8?B?ZzVKcmRIZ3NvYlp2VVVtcGUxL0N6dkZESUl4b28vdUNvdkhkb01KNEl4T0Jl?=
 =?utf-8?B?QTFJamVHTGFNZlB6N1U2SmtSYTh1aktjdmV1ZE9JQUNYU2VnWXhvdUVrVVBU?=
 =?utf-8?B?WTJlMytxS3YvNGl1Zy8rbndtK3JFUVhORS9uZUVDd3hXeW9hejNhZGd4S1Jo?=
 =?utf-8?B?QkhQekpuSzFQRTk2ZjVRMmJqOWJ5MUpTbjJFWGowV2FlSDJ3dnliTDA4b2RQ?=
 =?utf-8?B?cTRDYXRWN0pnMUpCQkNDS25kd2JjNUFDSnA2NnB0SGQrVVViYkNBeHU0SVRC?=
 =?utf-8?B?RjJwcDkyYzA3VGpvVEtpZ2piYy9hQjA1UzBHSmRnN1paZ3V4RFJTWnJiY1Y3?=
 =?utf-8?B?UmU0clRQa2ZYYTRWdFJScllVK0tBMTNGc0VpcStnWks5cHlGemxmenIwM2lG?=
 =?utf-8?B?YWlHUitOZ1daL0l4Wi9EL2JRUXdJK05uMjJXYVRId3RXa2lXNDdZdDd4a3pJ?=
 =?utf-8?B?TzBSVXJ1RUxpR3plREhDSzE5Mmc3dEk2L2dEZlNBenoxZlhXRldqNzcyNitp?=
 =?utf-8?B?RFZreE9lUGxpVnFQaHN1bE9WOXR2eFh1azhJWElSMlBuRlZGZWJXRXpDY01I?=
 =?utf-8?B?S21kbTROVU1vN2RudmdhV280bmhpUFpsNjloUmhWeU9kSGxIRktDUHBZVHM0?=
 =?utf-8?B?NzRtd0pySkUzdFUwR2ZuUGdSM2dOeko4RXpvRFgySkkyMW1iZGEzQWtqVEJL?=
 =?utf-8?B?Qk5pLzZ3UG85azAwc1ZIMzMzLy9TMDNHaGQyem4vZTdzZFpTUkhDNU1DQWNm?=
 =?utf-8?Q?XQ+G+ACv6t3UPSBM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f13b4d6-52cd-4668-2f5a-08da280ab5f8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4831.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 04:59:29.7196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXkw6FD6MEscLIVunCDOAj03kxpDlbfulae+ZBiXODkYZXR4FHv0WUacbHFY4MDcKRrpdiWHgfMIDDHQVUTZEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3902
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yosry,

On 4/27/2022 12:34 PM, Yosry Ahmed wrote:
> I am not sure why this specific callsite causes regression, there are
> many callsites that modify stats similarly (whether through
> mod_memcg_state() directly or through other variants like
> mod_lruvec_state()). Maybe the kmem call path is exercised more
> heavily in this benchmark than other call paths that update stats.
perf data didn't show the function commented out either. No idea how
it impact the hackbench.

> 
> The only seemingly expensive operation in the mod_memcg_state() path
> is the call to cgroup_rstat_updated() (through memcg_rstat_updated()).
> One idea off the top of my head is to batch calls to
> cgroup_rstat_updated(), similar to what 11192d9c124d ("memcg: flush
> stats only if updated") did on the flush side. I am interested to see
> what memcg maintainers think about this problem (and the proposed
> solution).
OK. Let's wait.


Regards
Yin, Fengwei
