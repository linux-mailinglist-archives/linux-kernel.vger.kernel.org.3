Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCE3511A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbiD0ODM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbiD0ODK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:03:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB4C4552F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651067999; x=1682603999;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nk7s4VgwBVrD7CbcyAN5RN6dA8DycdUbG2E4R+aihrw=;
  b=j+oYchqAzvkZowXhH6GGNeV3Cj9Tp4dRoimda1a4cPJMx3O1LvyCEShi
   ofkY4oUulX15g8Lr1Ha/oWiRAkAEGVLGfyoyGcXv7XQ0+3pS2HWg4a7XD
   H8uLuNwsUEEdSvefw8nVAOgkZnAfISASFVESQFBs8RtP2pu+LRF1HF2Uh
   BJT8vnUvETuK62JvHT8KqldJ28YbAJIthYaixRvKFTGbkzI4HOVBXGgNQ
   ZoLDRZ5f/q59E6gw2X5KeXYAgAcBgqmoMIuqcrfV41kuHaPCPyHBS2Z/9
   /Ei/FJp3fTgf0kKmypyX+wAstGBykOj6fIiupVSJo3QlqBEp0CPYNeNM+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="328877947"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="328877947"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 06:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="808044236"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2022 06:59:58 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 27 Apr 2022 06:59:58 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 27 Apr 2022 06:59:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 27 Apr 2022 06:59:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 27 Apr 2022 06:59:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/nAUN6+9Zsvk2eJ0HzXS1fpM60eZaGdpfvOGdylwkpxCOz6oFpIk58aZo30bO5l/6487oomHa4xmfSu5ktR3j6gZ8vV715uzeAVLXAcPx33f4gwFxRA+sCwfKAXiUZcHbsYEGwiDqE8U+4UUtxAowA9pN87jY2urQJR35ViAfkcfUQhERaJehUR/rXKSxbVrMf42ex2G5/5q6R8e5/t/vrTc/iuSrhR2ExrS/LMUrn1zaCKY/hzmhaTH3unjRWmSzhEVLitI7eKdqLwF4rDulOxEbcdgch8emmH2MEfvlnRNs217wpiiL+mkyWL9lU1fWINxQj4kjeMvhhi7BY29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqyYMRCl1bqTUFmo7w0hmQQY0Mxylv/hg6awxSmw968=;
 b=nX6zzkRcamksv70LcM5+zXyGzpUZJGpOhz+p/3M66xvHYG7wIWpGbLXDOcT+dK43X4/S0s8M7CcJKHNWv5E63UXI3N8DA5/Cbabwc2XN7ZOeBX2gYt4sX1e0Vm7V2yIywvPw7/Sb3Kl6/D5yIHQlsZ4Guta5ty1RgJu29V1Jcb5dtOs1b7n9Tq0+FjLfZ0HcnPmptJY8Avg5AZs6jiY2ggPiF3UgDmOxx1l41BDAH7vP80MEfhIdRV1JNXqu+ts9NM5zzTR2Gb7Yy9FJHKx7UAOPj5vDeWbqbq1K+Hv6IiYkxP3kTk6gxeWr6ce8Ib8kfTmh/4hqsgNOC7TXel0crA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4739.namprd11.prod.outlook.com (2603:10b6:5:2a0::22)
 by BN9PR11MB5244.namprd11.prod.outlook.com (2603:10b6:408:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 13:59:54 +0000
Received: from DM6PR11MB4739.namprd11.prod.outlook.com
 ([fe80::ed46:401c:cd41:ccb1]) by DM6PR11MB4739.namprd11.prod.outlook.com
 ([fe80::ed46:401c:cd41:ccb1%8]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 13:59:54 +0000
Message-ID: <0c29e157-20dd-2f07-d1e5-a9f2ed7e28eb@intel.com>
Date:   Wed, 27 Apr 2022 21:59:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] irq_work: Make irq_work_queue_on() NMI-safe again
Content-Language: en-US
To:     <elver@google.com>, <dvyukov@google.com>, <ryabinin.a.a@gmail.com>,
        <peterz@infradead.org>
CC:     <bigeasy@linutronix.de>, <qiang1.zhang@intel.com>,
        <andreyknvl@gmail.com>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>
References: <20220427135050.20566-1-jun.miao@intel.com>
From:   Jun Miao <jun.miao@intel.com>
In-Reply-To: <20220427135050.20566-1-jun.miao@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:202:2e::23) To DM6PR11MB4739.namprd11.prod.outlook.com
 (2603:10b6:5:2a0::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1024f38d-58bb-4db8-5a36-08da285634c2
X-MS-TrafficTypeDiagnostic: BN9PR11MB5244:EE_
X-Microsoft-Antispam-PRVS: <BN9PR11MB5244E772DD136E8B0B48A26A9AFA9@BN9PR11MB5244.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBxAXj4aHa1bK41dPCjD9OJuXje/ZMfVqMl7fI+7b67ZpPpEHhFwCD+RYRkloTcP2rD8xP9eTVm8bfw0DPnjHuHhBmboXoEP7c1X5w6YDsg85NVbjOcPUUHQXrTobQc+0lYlJ8ZIzo8w3jEnAa4pQbKr3gq3Vv6NhuUnvtiSq4PgpzCzF7M1ogkrU2uFaLA3g+jvOoMW7XpIiPyIKCfEohEEMdB3TbaOyM2SQ8fhrTTdtyVXFPzovU5/KPfFg0H3h72nlxUK1xlUIvVxILMIVjhe4T2LUtbSmGPgXnEhxiMe3X+PRPMgj6tz3L2os3aknOMkYmKZahxrZqPdqOpagsIoOk2mNrPn7bFYAwfdJHYyvlSTKEUwiQUMfyfwxmyJY2aQUvVhDNnout1m9nRNK9wXOIsRhQsTWhwgU5SJuRSceVIEpXECAAlbI4BZs+E6OnGVtmMvuE30VIuVURjsc9V2JbnLaLMi2lhlSm/95kHQhZfNhQjhbF7OJBqJmRXB5H8tll1n7m/b8kWO0Drpufm3mUWl24ikqvgGAKr/VRdS5HuqvwuEpkU8BEDx1Dhw9MBy+3amvCkKnlLGv5P3UNvKhrD3RXxWQnK6Ns6LYbRxOfqGgiV3+nrYWh04Qyn+zeWc+U5wdNELbVnFeHGgkeTqiyTZRMHSC3LnqH2CNI/Q//PXzMwRwLVAkSLheoQ5NlovoTZ0NFJZVI3VR3JFmDY5G4GlYBOmXAhs8X5NxLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(316002)(186003)(508600001)(6486002)(5660300002)(31696002)(8936002)(38100700002)(26005)(6512007)(44832011)(31686004)(36756003)(2616005)(53546011)(66556008)(4326008)(6506007)(66946007)(66476007)(2906002)(82960400001)(83380400001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDBaMENFT25nNkhsSXZWQlBaWUY0SDNZVVFFZnRReTZSL1FxRHpOTXRWdElh?=
 =?utf-8?B?YVp5dlllb2FzLytqNlRnUFlkek9LVER1aVVXQzlTdVNkZVk0WjRlZGJSaGZu?=
 =?utf-8?B?NTVqRjJ5OGFURFdXQ2tGSTNWcUpadWpMZ3YycFAvSlg5RXpQZVNXOXZGMmxa?=
 =?utf-8?B?M2h5bnVQS05zb0Q5U1h1cFJGU08rdlBnZ2l1eVZUdmdYZjluZG5iUHF3dW9L?=
 =?utf-8?B?U1p6RXVkT0kyckhJUk9EN0Vob25NazVSbzk4UlBPQk1FdnA5NzFWa1N6cHdL?=
 =?utf-8?B?Z1dyNThCekFvTTVGOGVza2ZPRGtYL3gxWWFOZTlEc1ZJNnJYWExKcmVaU0xT?=
 =?utf-8?B?Q3VUUjF4RWF1SUt4R1VKYU01TDdxb0pDd0l4YjVtZzdXQ0ExeTRXTDVFZ2Ni?=
 =?utf-8?B?bHJWV00xaXJJYlJ0QkJIVzNKNkRVU3BOTDVWc3doZyt6WTBTOURlTWpSc1hP?=
 =?utf-8?B?anF0U1p3V28wd3hsRHIwc3l6d1pWNHFUd2kzd3hFUFozczBNQ3d2MmxFUlFO?=
 =?utf-8?B?MEJ2QUVVc0Q1OTh1dW4vYVppcFVIYVNJem5TNXFGUS9Ta2FUTTVGUFc0dFp3?=
 =?utf-8?B?R1ZtMXNFZVp4OVNMQWNmSXhuTzNvYkx4THo2MURHZVl3NGtjSG1Xckt3L3VZ?=
 =?utf-8?B?SnpOSlUvVWdKM0U5WCtJSkdTNnFpZTBxQ0pOUmk0MG1FRGplU3RUbnRMby9w?=
 =?utf-8?B?NTk1dm04TElFdzdUczRQc0Y5em0zaWxPcnFQK0hxbXFvMWJGU1ZoNjB2U0xG?=
 =?utf-8?B?N3FTTktPZXdrWTJaNGFQZVBxTjBzNzZLZzhVVzFUTURZbkk0QWpSRWZ2ekFL?=
 =?utf-8?B?U0N5WGIwYmQ3TS9WaGFVM2hxU2dFb3l0Rk1pdmtYam5mbVZzUFRWOVVtWWFx?=
 =?utf-8?B?Sm5BczFoa2UzQTh5cUszVllZVG1zL1lrdTdNOEJ1b2t2Ums1aGJYZ1dxUWcx?=
 =?utf-8?B?NmVwQVR2Tm1QV0p1NVZlOS92Z0dtYjgvNVFwckhheTI4dWt3R2w0NDJSQVJn?=
 =?utf-8?B?bWUraHZVRzJmWVBYVkNpL2lqeks1ZjU0UEVIU2JKYktZa1JwQzNiV1E1bENt?=
 =?utf-8?B?L3k3ZjBNMW11NFZaU2NJLy9FUWoySmIrTWY1NWtqTDJHblRrU2huY1drZnFM?=
 =?utf-8?B?UlNxQjBuc2pwamkxbWdwMlpQWkUySjVYeDJmZHFIMjBlRW8vaDlLOThjM01U?=
 =?utf-8?B?QitTWi9OWXpURU1DbDVyZGdNczBvMkdQU2l4WnNhUmhlL2VZNDd3VFp5N1l3?=
 =?utf-8?B?OVE5bXd6dDBkM3lGbGZrQURnMVFtamc2bzNGSnpseE5XNDBWc0FQRDd4UXZD?=
 =?utf-8?B?ZnVpd25wUlZWMzdna0kzcXlqL3N2dkJPYlpNcSswRUtFMVlaQnFEckNKSnJO?=
 =?utf-8?B?ejhDRk5kN0VDcS9TWkRlamZIekEzSTRYSmwzS3JwczdScnBXZS9jY3F2bkVP?=
 =?utf-8?B?Qld3RFIwV0ZYKzhjQ3FGcFhHY09YemJiQzZRRndPcmx4d1BrVE01cEcvUGRV?=
 =?utf-8?B?U1BtZkgzM0pOMFV0cHp6VGFSTFZRNTRvaFNBWGlFTjlUTFpBdDFzb3pWS2Yr?=
 =?utf-8?B?NVpEYVVHTlhrQnlMbW12ZmZ1c1ZvWGxLOEw5dDN5YmVjY21BWHdUNGNmL1N4?=
 =?utf-8?B?T2VQdlVWak1qaTFOV3MyUXZNb1hMNjJ4QVViZ2Vpdkc2dXRyaUdqZzBNeTRl?=
 =?utf-8?B?czhDTTdUN25Pd28zNzNBWE1JYXNuRW9WZGVwUTdNZStKNUkvZW81MVZCTWFN?=
 =?utf-8?B?cW9McUJvVlBBZDl2Y3NvNEJiekhnRXlPUEFlQjBWMThqTFNDeStmVXZTRmVC?=
 =?utf-8?B?dnVCclZEOFlLVmpPWjFzQUNPMnA2Mi9xTXI3UXlidllHaCs3U21Ocmd2cTNX?=
 =?utf-8?B?MGdmYzRqTEZUYUZwL3pmMzhQTzhZZERhQmpGUUZmTDN4Y2pWUmpEd1pRY0ow?=
 =?utf-8?B?SU9qMldQazlRcHErY0J6OWMxRWVQQnJTeTAvUWJGTVhSZUM2L29tek5ZWXBG?=
 =?utf-8?B?N0JhWDFTVHI4TC9OOWtuSzByejBDczlhTGp6am9CZ2ZJQXE0eDhYc0gxT2ha?=
 =?utf-8?B?RzRZMUZpQU8vUG0xTGFwSFAvWTBJb2tNR2pja0FEaDltZExwSHlNdDJRb1Ix?=
 =?utf-8?B?UFFBRWxwS09jNUdRZ0FlcmxCcUtpYmVubnptVE1wR1FYMFppZnV5VFV1KzE4?=
 =?utf-8?B?YUZvRnRDYjM1dml2aEQza0p1dXNyckg5MWhOSHEzZ3lCY21wZzZzVnJySklY?=
 =?utf-8?B?L016VHVKRVJDa0dnMTVCSTBrZEJCeTZpNGZMR1M5MFdidTJ1aVYwcExzdG5N?=
 =?utf-8?B?djNsM25idnErVkZ1WG1HdTZxSzNxaVNZdEI2SUJqd2JtbWhrcFppZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1024f38d-58bb-4db8-5a36-08da285634c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 13:59:54.6765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+hdYkeKjl4A5q5yGqHQOnE6wGY4dLpivijnFifW2j9XWKTM0zmwsTbTbJ8ATD6i7o02QpiLTeOcj18/bhxBXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5244
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore!


On 2022/4/27 21:50, Jun Miao wrote:
> We should not put NMI unsafe code in irq_work_queue_on().
>
> The KASAN of kasan_record_aux_stack_noalloc() is not NMI safe. Because which
> will call the spinlock. While the irq_work_queue_on() is also very carefully
> carfted to be exactly that.
> When unable CONFIG_SMP or local CPU, the irq_work_queue_on() is even same to
> irq_work_queue(). So delete KASAN instantly.
>
> Fixes: e2b5bcf9f5ba ("irq_work: record irq_work_queue() call stack")
> Suggested by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Jun Miao <jun.miao@intel.com>
> Acked-by: Marco Elver <elver@google.com>
> ---
>   kernel/irq_work.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 7afa40fe5cc4..e7f48aa8d8af 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -20,7 +20,6 @@
>   #include <linux/smp.h>
>   #include <linux/smpboot.h>
>   #include <asm/processor.h>
> -#include <linux/kasan.h>
>   
>   static DEFINE_PER_CPU(struct llist_head, raised_list);
>   static DEFINE_PER_CPU(struct llist_head, lazy_list);
> @@ -137,8 +136,6 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
>   	if (!irq_work_claim(work))
>   		return false;
>   
> -	kasan_record_aux_stack_noalloc(work);
> -
>   	preempt_disable();
>   	if (cpu != smp_processor_id()) {
>   		/* Arch remote IPI send/receive backend aren't NMI safe */
