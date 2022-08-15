Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F588592D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiHOKUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiHOKTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:19:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD4DDE
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660558792; x=1692094792;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=94xtSKW5zAvI6BT3h2Oc1PURiHUQ24sxdgMBRGow8nA=;
  b=iN4t8ublkZsCVmHbLB3jwr9mko7LylaQYY212zTfaL2y8LcRJ+3T9oNm
   ZTgAPbdhg8aeq5yPfCmF0LElOefsBmYyI84qyATozkx0RohFPQvhnqsUp
   orURhqMBZGk2Cj7Sohr//2yIk+7X7xg5JyPq6LC23qL9fxJtI1VB/Qr0X
   h4W8Egx8DnFE4JG3hsqnohfLjEfV3hINwrdvDkvkr2nr3N7x8wQu8qoS4
   ReNtQHtatxW+heglKWf6DX6vib8oZTogf8bZml1epZu1WmqaLkog4H9Ej
   6qoDXn/VB2m/CZVE97rJTVUZGzEFNAS9drLr6xUko7KHoPiLJb22IAYb7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="355937432"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="355937432"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 03:19:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="635429078"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 15 Aug 2022 03:19:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 03:19:51 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 03:19:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 03:19:51 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 03:19:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9s1189dR4vbHtNqJtYUhMt3eFptuBPi5r9VDcevRyH+XlxV0qeja2PV4lKBQXNpKgCT427C6mfsy+nDd/56Rts32CqEZHMroGhksjDsoYPZoTkcrovE/PJFZKEBYvSB7u6g5a0jWBS82EExf5md6I8QJ0DLo3kgdsYZnV9HCzY4pw+ioPicwfRv5ThBSBSp29ZrjL0xKCSz94yOH6U3JkJUhqcpisPLuGbER9VZzX9ADb19wy4pxIi87UoFH1Onr0K8XGkg6Edevy3DiKuc/w+0n00h7STG1IvRFsQKW49Ou+a34KT6O1WcIUgTx5Xx0TO14PE0vN75ySXa9V/bWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAlXGR1t9Ibf5TpisQBsUaFkJtBIoxH4X6b0HcI72R4=;
 b=UziMAXEg85psSDjU0Oq+xv8JH/8y7XaYQlbJiXwE3jU2js/OiypM6Mqxlx7lyC8aRLjRZRaIkQ4SYiGk84GQlZhyTOQ/aOzeoJDs3lZ5QuuCT6mKvSjmXSOjD5FRagCuZqJ2SoUwUvmEapTFSpp0N79FdPdQM+LUe5i/PQGJMreh/oDD/hO176/8tYLo6sDcnEh55P7hYeTSRDbNerVIc7KFvJnl/qOcmxA+HlIJ5BqPivwRoq4LSVNcMUkgNEDliAxBbwiMuwuC9Af7UK95n/oM6eUzitXoYKpdwW16A7s8GLBZI3fzyDw5gZMAOL7bji85rfw1qysNuSzTDx5DBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by BYAPR11MB3494.namprd11.prod.outlook.com (2603:10b6:a03:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 10:19:48 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e%3]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 10:19:48 +0000
Message-ID: <ef2001eb-1833-edf0-9dc0-ab5aaeb0d51f@intel.com>
Date:   Mon, 15 Aug 2022 18:19:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 4/8] memblock tests: add additional tests for basic api
 and memblock_alloc
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     David Hildenbrand <david@redhat.com>
References: <cover.1660454730.git.remckee0@gmail.com>
 <816c5d36d18944171b3fa4964ce75d91f8096bf1.1660454730.git.remckee0@gmail.com>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <816c5d36d18944171b3fa4964ce75d91f8096bf1.1660454730.git.remckee0@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::27)
 To MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 589a117c-061a-4e1c-d2f1-08da7ea7ae67
X-MS-TrafficTypeDiagnostic: BYAPR11MB3494:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4iCXDc1rnKpgzhVEAKoudbxCJECdyZDQc+Tk0CLNdk5RIo0dbFcF/Ahnq38CwH7+Jg+bJB4HeXWGfn/06lqHRXoG2J+s7JxufsmpXjkq1h8fZwzkkNswpOYHU5b9+7bVJZz79CHmiPOnP/12LR7LUZp93T3EGUBvAymPOLzDunm91F1mqvPMRNQG14g53M5PRNDzBFXqnx0xoc2604D2AY04AfyUmQm7jKeMHMu9iEN1oWRUMBLeMTLQfX8MTcDE4Iu5H6tWOfPFnPVoj8jqVBNAiSA0klmxYTjqHjHfBtljTnTVec9OdlTlsV7cOiud4zzbgpuQ4FDmMz43VoiwUqVAL/NjX4EtgGFcW3wsvgNIwDltgjP0eOCFGfGHvFqp4uGOicOiHlBA3ICWpnbgjbDsZrdNy3D6lx14Fbn7W/IyHVk95V+3gU8gOQGTMljCaEP+/mOSIjpRtGdX4uxf4GtoScnuzsTCDGH54/DIphFw7GccW4mvb5AcBKsmFMCCMf4n/2bCxst+4IF2narBWHPkSJNV2/9FyzCd2wKku1xDFJ+oXtz0s8ces/kHaui5xfSQndBl+herg4gVLqfFr9Y9Vz3UOBZF8nWBawLMHGf5Qu9kAubypV4njkLbMpAcALpRnLynD/JYUC2UEB9U40h0VO4w5Iw8AltXZsbUShRXmkYEq2X+HYjedWRCph9jOBZIvJrDYl89jXwUhjeQ0NY7yIEVuBAJlWiHJW29MOgCTc6DQpjMneS8++uPoPTBnJM57ZBD3vQ6AJZdBqHElE++Wu1VD3viDPuS/7OTtTe+2CQI3471nBRx3V/IABDI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(136003)(366004)(376002)(30864003)(41300700001)(316002)(82960400001)(66556008)(2906002)(6512007)(6666004)(26005)(66476007)(53546011)(66946007)(8676002)(38100700002)(4326008)(5660300002)(31686004)(186003)(31696002)(478600001)(8936002)(83380400001)(86362001)(110136005)(36756003)(6486002)(6506007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE1wbTRFTUJkWGJ5ZldiWWZJVjhWYk1NOVZ0dGFiMU91Y1FDdFZiUTAyZmR2?=
 =?utf-8?B?OVNlN2F5QUVyZzRiMEF4NnVhN3dncFY1MGN3b09RT1hFbzRKbytyWi9nWGtN?=
 =?utf-8?B?cXg2NlVhS09HUU9yaGk2Y29NNW5rbXVycldhOTRpRXAwd2FxUjFLUzl2aWZt?=
 =?utf-8?B?OHlvdXZLcGd0L041THI1NXRWYnBQemdGMlZpUHNTK0RyTDgzdWxoWkM2U2M0?=
 =?utf-8?B?cFRKUDQ1OW15RjFWL1lGS0p3bFRGb3MzMjVqZjM0cEVMZlIvZU80aGx6RzE1?=
 =?utf-8?B?UWtkSU1kWk1Gc2ZFdFNCMk11T3R6ZWo1R2pDODllcTBWdm0yNnJGL1NsUFlS?=
 =?utf-8?B?d2IybldyQ3BWZ0FXM1dBbitDZnZzY01CYTdTMXUrMndkbyt6ckk4cGluNVFT?=
 =?utf-8?B?ZENtdzVGRnE4L3BzaUEyZzh6Q09nUmRjVmJzYVI4QjVVc2tkTlYzZFc5dTRV?=
 =?utf-8?B?OGM1bjN4QzRWM0YvbkxWbWg0LzBZVXZsWTFlZ3NvYnFpYVh0bjlWRTIyWERE?=
 =?utf-8?B?UWtBaTlrVFdFZTlna2VoZEpBdFIrZmZWNW1qNzYyYWgwajJDaDZZMjBwWjZD?=
 =?utf-8?B?MmRFK0hqemlOeHpHUVgvNG9QeDZTVmwzMTZaaVdHMDBoMGpoUjlIMkd3VmRB?=
 =?utf-8?B?bmNPRmc0UDFkYmtRckN6eldtYnQ4S0xoVFFRUDBOM2VHMUU5elpWUGcrcnlh?=
 =?utf-8?B?THF6YmZLME5Lb3JWTlQ3VmlRT21WaFNCdkN4cVZSejNvQVBpUFpsQWdKM2I4?=
 =?utf-8?B?MXJzMHhneEVJZmZRQmVEVmtWUFNTTDFoTUdNUmlzRFo2SWZ5OEpWdXpFNm1K?=
 =?utf-8?B?M3RCRmZmU2piMlVhanc4SmlRMUcxSWFYVnJ6UTN2QzZ5eWdrM0o1WnZ2RUdk?=
 =?utf-8?B?M3ZJMlo1WEcvRHZVMWl4bWtISzFUUTZaWGZXSmR2TTUxckdnbkxNcVRXd0NN?=
 =?utf-8?B?eHpXUFY1V2NQWlhtN3VGT1pwY1hKSFpkcmN5VHl4bTVqRngvdWcyV1hOQWJS?=
 =?utf-8?B?d0JJY2kzVVhXeDRBWHFPeFh4SlZ4T0VIbGtMRDBYV2w3NmJESTJZMjRiOXg2?=
 =?utf-8?B?VXQ0YzNGdndzNmlxRUFHVWFvZlJsMkk5QzVNK3RlM1EvTEJTZWJmc2VxbjhP?=
 =?utf-8?B?UzlWTjFSNjJTa0wzU3BVbWE3MGFteHd1Z0ZXaGQrVjdpb2FadzN1YitORmw4?=
 =?utf-8?B?RG9xM0VPRHFOcEVZZisvSE5NZzNsM0U0N2l4RnB5N0lqU08rZmZIQVFRN1Jp?=
 =?utf-8?B?Y1o5SzA2Tk9DZGxHckpRczZneHk2WjF0azFNSjVBSFV3dXk1akNNZmEyaGVS?=
 =?utf-8?B?V0JqZXhsOTRMU3FXcXh6a3o3d0lJZ3ZPY3o4ZEdXdi9kR2xDTVkxY2JVSi90?=
 =?utf-8?B?MndPQWlkSGdTV29SVlA5SVYya2lNWnU3dCszZUd1S0QvRHdhUGhSQmtsdjZ6?=
 =?utf-8?B?OGtzTUJuQnNoVUtVRkE1emZaU3UzVjlXOXh3RzUvQk94bE15aGhhMG9PbUNQ?=
 =?utf-8?B?dmo4THpTdVVYNkQxdWtpQ2grNTRFU20wLzlYQkt4WVFTbVRZcWZMK2tOREdU?=
 =?utf-8?B?WjRYQi9naWlzRDFmdTRSWVc4NTFnWHdidlZlU1FmeFVmMXI2MG55S01sVTYr?=
 =?utf-8?B?cTVSZDJqZlkyWFNwTUNXUStjUFhFdnFXMWx5RnZBZTUyWXFPbTVDekZETXJw?=
 =?utf-8?B?TTl2NExvNzN0ZjkzaitaNHh0cmtZb3lTWEoxNUgrSHFNeG1zUWpKQStJSFJT?=
 =?utf-8?B?UkRCK1pxUlNlZzJ1a28xbFBTSHdMdjVxUEdmRVhxbFJQYVlaRGVzb3g4MWxD?=
 =?utf-8?B?YWlKQXBEZDlPQmsvOC9uckJLbm5GejNpdVo3TVB1ZW5HM09XekhuNVdjTzJG?=
 =?utf-8?B?aFNiZmdPdldLMkwxNWNxUGVDU29QdDVGZGpPYm9naHAzRUNpdnpXUzNPdnFk?=
 =?utf-8?B?YmdFOWtlMXl6Ylk2WUp4Smwyd2E1ZWtJS3JLaThvajNNUmV2bmhwWkhhRTlL?=
 =?utf-8?B?VzBuY1VzYmMybnp3bkxLVTVJVzh0eDdnTzNzcXB2WDkycFg4SzVnM2gwbzJL?=
 =?utf-8?B?c2kyM05JU3pOWWRkWjZOdS9pTk13VnNpaWVKQjcyL1E4bFZjbjNkbng3alla?=
 =?utf-8?B?eXd1emRWb3NMOVRRalpEWmhRRldUS0hMcVJmOTF4dFpSQ0JLdTJzU3JDYUow?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 589a117c-061a-4e1c-d2f1-08da7ea7ae67
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 10:19:47.9055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+ATafHWXGJNhL4vL1p2mx+l6vwldopVrwWevZtKbspQpbtqWxIZ62LRwHkbFdQhQU1kpvBunu6h94kukuM+gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3494
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rebecca.

On 8/14/2022 1:53 PM, Rebecca Mckeever wrote:
> Add tests for memblock_add(), memblock_reserve(), memblock_remove(),
> memblock_free(), and memblock_alloc() for the following test scenarios.
> 
> memblock_add() and memblock_reserve():
> - add/reserve a memory block in the gap between two existing memory
>    blocks, and check that the blocks are merged into one region
> - try to add/reserve memblock regions that extend past PHYS_ADDR_MAX
> 
> memblock_remove() and memblock_free():
> - remove/free a region when it is the only available region
>      + These tests ensure that the first region is overwritten with a
>        "dummy" region when the last remaining region of that type is
>        removed or freed.
> - remove/free() a region that overlaps with two existing regions of the
>    relevant type
> - try to remove/free memblock regions that extend past PHYS_ADDR_MAX
> 
> memblock_alloc():
> - try to allocate a region that is larger than the total size of available
>    memory (memblock.memory)
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>   tools/testing/memblock/tests/alloc_api.c |  44 ++
>   tools/testing/memblock/tests/basic_api.c | 499 +++++++++++++++++++++++
>   2 files changed, 543 insertions(+)
> 
> diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
> index 73c2c43e702a..fe1ee3b2e851 100644
> --- a/tools/testing/memblock/tests/alloc_api.c
> +++ b/tools/testing/memblock/tests/alloc_api.c
> @@ -470,6 +470,40 @@ static int alloc_no_memory_generic_check(void)
>   	return 0;
>   }
>   
> +/*
> + * A test that tries to allocate a region that is larger than the total size of
> + * available memory (memblock.memory):
> + *
> + *  +-----------------------------------+
> + *  |                 new               |
> + *  +-----------------------------------+
> + *  |                                 |
> + *  |                                 |
> + *  +---------------------------------+
> + *
> + * Expect no allocation to happen.
> + */
> +static int alloc_too_large_generic_check(void)
> +{
> +	struct memblock_region *rgn = &memblock.reserved.regions[0];
> +	void *allocated_ptr = NULL;
> +
> +	PREFIX_PUSH();
> +
> +	setup_memblock();
> +
> +	allocated_ptr = memblock_alloc(MEM_SIZE + SZ_2, SMP_CACHE_BYTES);
> +
> +	ASSERT_EQ(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->size, 0);
> +	ASSERT_EQ(rgn->base, 0);
> +	ASSERT_EQ(memblock.reserved.total_size, 0);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
>   /*
>    * A simple test that tries to allocate a small memory region.
>    * Expect to allocate an aligned region at the beginning of the available
> @@ -814,6 +848,15 @@ static int alloc_no_memory_check(void)
>   	return 0;
>   }
>   
> +static int alloc_too_large_check(void)
> +{
> +	test_print("\tRunning %s...\n", __func__);
> +	run_top_down(alloc_too_large_generic_check);
> +	run_bottom_up(alloc_too_large_generic_check);
> +
> +	return 0;
> +}
> +
>   int memblock_alloc_checks(void)
>   {
>   	const char *func_testing = "memblock_alloc";
> @@ -836,6 +879,7 @@ int memblock_alloc_checks(void)
>   	alloc_no_space_check();
>   	alloc_limited_space_check();
>   	alloc_no_memory_check();
> +	alloc_too_large_check();
>   
>   	dummy_physical_memory_cleanup();
>   
> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> index 66f46f261e66..ef5642d0863b 100644
> --- a/tools/testing/memblock/tests/basic_api.c
> +++ b/tools/testing/memblock/tests/basic_api.c
> @@ -326,6 +326,102 @@ static int memblock_add_twice_check(void)
>   	return 0;
>   }
>   
> +/*
> + * A test that tries to add two memory blocks that don't overlap with one
> + * another and then add a third memory block in the space between the first two:
> + *
> + *  |        +--------+--------+--------+  |
> + *  |        |   r1   |   r3   |   r2   |  |
> + *  +--------+--------+--------+--------+--+
> + *
> + * Expect to merge the three entries into one region that starts at r1.base
> + * and has size of r1.size + r2.size + r3.size. The region counter and total
> + * size of the available memory are updated.
> + */
> +static int memblock_add_between_check(void)
> +{
> +	struct memblock_region *rgn;
> +	phys_addr_t total_size;
> +
> +	rgn = &memblock.memory.regions[0];
> +
> +	struct region r1 = {
> +		.base = SZ_1G,
> +		.size = SZ_8K
> +	};
> +	struct region r2 = {
> +		.base = SZ_1G + SZ_16K,
> +		.size = SZ_8K
> +	};
> +	struct region r3 = {
> +		.base = SZ_1G + SZ_8K,
> +		.size = SZ_8K
> +	};
> +
> +	PREFIX_PUSH();
> +
> +	total_size = r1.size + r2.size + r3.size;
> +
> +	reset_memblock_regions();
> +	memblock_add(r1.base, r1.size);
> +	memblock_add(r2.base, r2.size);
> +	memblock_add(r3.base, r3.size);
> +
> +	ASSERT_EQ(rgn->base, r1.base);
> +	ASSERT_EQ(rgn->size, total_size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, total_size);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
> +/*
> + * A simple test that tries to add a memory block r when r extends past
> + * PHYS_ADDR_MAX:
> + *
> + *                               +--------+
> + *                               |    r   |
> + *                               +--------+
> + *  |                            +----+
> + *  |                            | rgn|
> + *  +----------------------------+----+
> + *
> + * Expect to add a memory block of size PHYS_ADDR_MAX - r.base. Expect the
> + * total size of available memory and the counter to be updated.
> + */
> +static int memblock_add_near_max_check(void)
> +{
> +	struct memblock_region *rgn;
> +	phys_addr_t total_size;
> +
> +	rgn = &memblock.memory.regions[0];
> +
> +	struct region r = {
> +		.base = PHYS_ADDR_MAX - SZ_1M,
> +		.size = SZ_2M
> +	};
> +
> +	PREFIX_PUSH();
> +
> +	total_size = PHYS_ADDR_MAX - r.base;
> +
> +	reset_memblock_regions();
> +	memblock_add(r.base, r.size);
> +
> +	ASSERT_EQ(rgn->base, r.base);
> +	ASSERT_EQ(rgn->size, total_size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, total_size);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
>   static int memblock_add_checks(void)
>   {
>   	prefix_reset();
> @@ -339,6 +435,8 @@ static int memblock_add_checks(void)
>   	memblock_add_overlap_bottom_check();
>   	memblock_add_within_check();
>   	memblock_add_twice_check();
> +	memblock_add_between_check();
> +	memblock_add_near_max_check();
>   
>   	prefix_pop();
>   
> @@ -604,6 +702,102 @@ static int memblock_reserve_twice_check(void)
>   	return 0;
>   }
>   
> +/*
> + * A test that tries to mark two memory blocks that don't overlap as reserved
> + * and then reserve a third memory block in the space between the first two:
> + *
> + *  |        +--------+--------+--------+  |
> + *  |        |   r1   |   r3   |   r2   |  |
> + *  +--------+--------+--------+--------+--+
> + *
> + * Expect to merge the three entries into one reserved region that starts at
> + * r1.base and has size of r1.size + r2.size + r3.size. The region counter and
> + * total for memblock.reserved are updated.
> + */
> +static int memblock_reserve_between_check(void)
> +{
> +	struct memblock_region *rgn;
> +	phys_addr_t total_size;
> +
> +	rgn = &memblock.reserved.regions[0];
> +
> +	struct region r1 = {
> +		.base = SZ_1G,
> +		.size = SZ_8K
> +	};
> +	struct region r2 = {
> +		.base = SZ_1G + SZ_16K,
> +		.size = SZ_8K
> +	};
> +	struct region r3 = {
> +		.base = SZ_1G + SZ_8K,
> +		.size = SZ_8K
> +	};
> +
> +	PREFIX_PUSH();
> +
> +	total_size = r1.size + r2.size + r3.size;
> +
> +	reset_memblock_regions();
> +	memblock_reserve(r1.base, r1.size);
> +	memblock_reserve(r2.base, r2.size);
> +	memblock_reserve(r3.base, r3.size);
> +
> +	ASSERT_EQ(rgn->base, r1.base);
> +	ASSERT_EQ(rgn->size, total_size);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
> +/*
> + * A simple test that tries to reserve a memory block r when r extends past
> + * PHYS_ADDR_MAX:
> + *
> + *                               +--------+
> + *                               |    r   |
> + *                               +--------+
> + *  |                            +----+
> + *  |                            | rgn|
> + *  +----------------------------+----+
> + *
> + * Expect to reserve a memory block of size PHYS_ADDR_MAX - r.base. Expect the
> + * total size of reserved memory and the counter to be updated.
> + */
> +static int memblock_reserve_near_max_check(void)
> +{
> +	struct memblock_region *rgn;
> +	phys_addr_t total_size;
> +
> +	rgn = &memblock.reserved.regions[0];
> +
> +	struct region r = {
> +		.base = PHYS_ADDR_MAX - SZ_1M,
> +		.size = SZ_2M
> +	};
> +
> +	PREFIX_PUSH();
> +
> +	total_size = PHYS_ADDR_MAX - r.base;
> +
> +	reset_memblock_regions();
> +	memblock_reserve(r.base, r.size);
> +
> +	ASSERT_EQ(rgn->base, r.base);
> +	ASSERT_EQ(rgn->size, total_size);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
>   static int memblock_reserve_checks(void)
>   {
>   	prefix_reset();
> @@ -616,6 +810,8 @@ static int memblock_reserve_checks(void)
>   	memblock_reserve_overlap_bottom_check();
>   	memblock_reserve_within_check();
>   	memblock_reserve_twice_check();
> +	memblock_reserve_between_check();
> +	memblock_reserve_near_max_check();
>   
>   	prefix_pop();
>   
> @@ -887,6 +1083,155 @@ static int memblock_remove_within_check(void)
>   	return 0;
>   }
>   
> +/*
> + * A simple test that tries to remove a region r1 from the array of
> + * available memory regions when r1 is the only available region.
> + * Expect to add a memory block r1 and then remove r1 so that a dummy
> + * region is added. The region counter stays the same, and the total size
> + * is updated.
> + */
> +static int memblock_remove_only_region_check(void)
> +{
> +	struct memblock_region *rgn;
> +
> +	rgn = &memblock.memory.regions[0];
> +
> +	struct region r1 = {
> +		.base = SZ_2K,
> +		.size = SZ_4K
> +	};
> +
> +	PREFIX_PUSH();
> +
> +	reset_memblock_regions();
> +	memblock_add(r1.base, r1.size);
> +	memblock_remove(r1.base, r1.size);
> +
> +	ASSERT_EQ(rgn->base, 0);
> +	ASSERT_EQ(rgn->size, 0);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, 0);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
> +/*
> + * A simple test that tries remove a region r2 from the array of available
> + * memory regions when r2 extends past PHYS_ADDR_MAX:
> + *
> + *                               +--------+
> + *                               |   r2   |
> + *                               +--------+
> + *  |                        +---+....+
> + *  |                        |rgn|    |
> + *  +------------------------+---+----+
> + *
> + * Expect that only the portion between PHYS_ADDR_MAX and r2.base is removed.
> + * Expect the total size of available memory to be updated and the counter to
> + * not be updated.
> + */
> +static int memblock_remove_near_max_check(void)
> +{
> +	struct memblock_region *rgn;
> +	phys_addr_t total_size;
> +
> +	rgn = &memblock.memory.regions[0];
> +
> +	struct region r1 = {
> +		.base = PHYS_ADDR_MAX - SZ_2M,
> +		.size = SZ_2M
> +	};
> +
> +	struct region r2 = {
> +		.base = PHYS_ADDR_MAX - SZ_1M,
> +		.size = SZ_2M
> +	};
> +
> +	PREFIX_PUSH();
> +
> +	total_size = r1.size - (PHYS_ADDR_MAX - r2.base);
> +
> +	reset_memblock_regions();
> +	memblock_add(r1.base, r1.size);
> +	memblock_remove(r2.base, r2.size);
> +
> +	ASSERT_EQ(rgn->base, r1.base);
> +	ASSERT_EQ(rgn->size, total_size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, total_size);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
> +/*
> + * A test that tries to remove a region r3 that overlaps with two existing
> + * regions r1 and r2:
> + *
> + *            +----------------+
> + *            |       r3       |
> + *            +----------------+
> + *  |    +----+.....   ........+--------+
> + *  |    |    |r1  :   :       |r2      |     |
> + *  +----+----+----+---+-------+--------+-----+
> + *
> + * Expect that only the intersections of r1 with r3 and r2 with r3 are removed
> + * from the available memory pool. Expect the total size of available memory to
> + * be updated and the counter to not be updated.
> + */
> +static int memblock_remove_overlap_two_check(void)
> +{
> +	struct memblock_region *rgn1, *rgn2;
> +	phys_addr_t r1_size, r2_size, r2_end, r3_end, total_size;
> +
> +	rgn1 = &memblock.memory.regions[0];
> +	rgn2 = &memblock.memory.regions[1];
> +
> +	struct region r1 = {
> +		.base = SZ_16M,
> +		.size = SZ_32M
> +	};
> +	struct region r2 = {
> +		.base = SZ_64M,
> +		.size = SZ_64M
> +	};
> +	struct region r3 = {
> +		.base = SZ_32M,
> +		.size = SZ_64M
> +	};
> +
> +	PREFIX_PUSH();
> +
> +	r2_end = r2.base + r2.size;
> +	r3_end = r3.base + r3.size;
> +	r1_size = r3.base - r1.base;
> +	r2_size = r2_end - r3_end;
> +	total_size = r1_size + r2_size;
> +
> +	reset_memblock_regions();
> +	memblock_add(r1.base, r1.size);
> +	memblock_add(r2.base, r2.size);
> +	memblock_remove(r3.base, r3.size);
> +
> +	ASSERT_EQ(rgn1->base, r1.base);
> +	ASSERT_EQ(rgn1->size, r1_size);
> +
> +	ASSERT_EQ(rgn2->base, r3_end);
> +	ASSERT_EQ(rgn2->size, r2_size);

I think these variable like r1.size and r1_size is a little confused, at 
least the readability is not very clear.

Maybe modify the r1_size to new_r1_size is more clear, and all other 
r*_size and r*_end.

It also can use other names, thus make these variable distingush and 
more clear.

> +
> +	ASSERT_EQ(memblock.memory.cnt, 2);
> +	ASSERT_EQ(memblock.memory.total_size, total_size);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
>   static int memblock_remove_checks(void)
>   {
>   	prefix_reset();
> @@ -898,6 +1243,9 @@ static int memblock_remove_checks(void)
>   	memblock_remove_overlap_top_check();
>   	memblock_remove_overlap_bottom_check();
>   	memblock_remove_within_check();
> +	memblock_remove_only_region_check();
> +	memblock_remove_near_max_check();
> +	memblock_remove_overlap_two_check();
>   
>   	prefix_pop();
>   
> @@ -1163,6 +1511,154 @@ static int memblock_free_within_check(void)
>   	return 0;
>   }
>   
> +/*
> + * A simple test that tries to free a memory block r1 that was marked
> + * earlier as reserved when r1 is the only available region.
> + * Expect to reserve a memory block r1 and then free r1 so that r1 is
> + * overwritten with a dummy region. The region counter stays the same,
> + * and the total size is updated.
> + */
> +static int memblock_free_only_region_check(void)
> +{
> +	struct memblock_region *rgn;
> +
> +	rgn = &memblock.reserved.regions[0];
> +
> +	struct region r1 = {
> +		.base = SZ_2K,
> +		.size = SZ_4K
> +	};
> +
> +	PREFIX_PUSH();
> +
> +	reset_memblock_regions();
> +	memblock_reserve(r1.base, r1.size);
> +	memblock_free((void *)r1.base, r1.size);
> +
> +	ASSERT_EQ(rgn->base, 0);
> +	ASSERT_EQ(rgn->size, 0);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, 0);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
> +/*
> + * A simple test that tries free a region r2 when r2 extends past PHYS_ADDR_MAX:
> + *
> + *                               +--------+
> + *                               |   r2   |
> + *                               +--------+
> + *  |                        +---+....+
> + *  |                        |rgn|    |
> + *  +------------------------+---+----+
> + *
> + * Expect that only the portion between PHYS_ADDR_MAX and r2.base is freed.
> + * Expect the total size of reserved memory to be updated and the counter to
> + * not be updated.
> + */
> +static int memblock_free_near_max_check(void)
> +{
> +	struct memblock_region *rgn;
> +	phys_addr_t total_size;
> +
> +	rgn = &memblock.reserved.regions[0];
> +
> +	struct region r1 = {
> +		.base = PHYS_ADDR_MAX - SZ_2M,
> +		.size = SZ_2M
> +	};
> +
> +	struct region r2 = {
> +		.base = PHYS_ADDR_MAX - SZ_1M,
> +		.size = SZ_2M
> +	};
> +
> +	PREFIX_PUSH();
> +
> +	total_size = r1.size - (PHYS_ADDR_MAX - r2.base);
> +
> +	reset_memblock_regions();
> +	memblock_reserve(r1.base, r1.size);
> +	memblock_free((void *)r2.base, r2.size);
> +
> +	ASSERT_EQ(rgn->base, r1.base);
> +	ASSERT_EQ(rgn->size, total_size);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
> +/*
> + * A test that tries to free a reserved region r3 that overlaps with two
> + * existing reserved regions r1 and r2:
> + *
> + *            +----------------+
> + *            |       r3       |
> + *            +----------------+
> + *  |    +----+.....   ........+--------+
> + *  |    |    |r1  :   :       |r2      |     |
> + *  +----+----+----+---+-------+--------+-----+
> + *
> + * Expect that only the intersections of r1 with r3 and r2 with r3 are freed
> + * from the collection of reserved memory. Expect the total size of reserved
> + * memory to be updated and the counter to not be updated.
> + */
> +static int memblock_free_overlap_two_check(void)
> +{
> +	struct memblock_region *rgn1, *rgn2;
> +	phys_addr_t r1_size, r2_size, r2_end, r3_end, total_size;
> +
> +	rgn1 = &memblock.reserved.regions[0];
> +	rgn2 = &memblock.reserved.regions[1];
> +
> +	struct region r1 = {
> +		.base = SZ_16M,
> +		.size = SZ_32M
> +	};
> +	struct region r2 = {
> +		.base = SZ_64M,
> +		.size = SZ_64M
> +	};
> +	struct region r3 = {
> +		.base = SZ_32M,
> +		.size = SZ_64M
> +	};
> +
> +	PREFIX_PUSH();
> +
> +	r2_end = r2.base + r2.size;
> +	r3_end = r3.base + r3.size;
> +	r1_size = r3.base - r1.base;
> +	r2_size = r2_end - r3_end;
> +	total_size = r1_size + r2_size;

Same as above.

> +
> +	reset_memblock_regions();
> +	memblock_reserve(r1.base, r1.size);
> +	memblock_reserve(r2.base, r2.size);
> +	memblock_free((void *)r3.base, r3.size);
> +
> +	ASSERT_EQ(rgn1->base, r1.base);
> +	ASSERT_EQ(rgn1->size, r1_size);
> +
> +	ASSERT_EQ(rgn2->base, r3_end);
> +	ASSERT_EQ(rgn2->size, r2_size);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 2);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
>   static int memblock_free_checks(void)
>   {
>   	prefix_reset();
> @@ -1174,6 +1670,9 @@ static int memblock_free_checks(void)
>   	memblock_free_overlap_top_check();
>   	memblock_free_overlap_bottom_check();
>   	memblock_free_within_check();
> +	memblock_free_only_region_check();
> +	memblock_free_near_max_check();
> +	memblock_free_overlap_two_check();
>   

Others looks good to me.

>   	prefix_pop();
>   
