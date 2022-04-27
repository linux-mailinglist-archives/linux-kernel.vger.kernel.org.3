Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10E0511A51
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbiD0NVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiD0NVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:21:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB82C2B1BB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651065483; x=1682601483;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2yQSFIKvt94emNla2Z9BcWLWUeDO1yVObNq7kNh29Gw=;
  b=Ok56psHIN+IN74o0+MRtlBLnaCE882gxuLn9AOtceCZKj7REtVn57jQN
   Nt0cJFr+hRuGBQNUV3qCfhWmuDwesXG3xOJ10GIhAGDP68CbHYPwudSdh
   iwHWAnu4dJ8vszpJq8ofqTJGCUaUJPR7l4pMpZKJsNSlXUREthtRW9fyC
   tXMbrzn4v7QmGt6Bps0cK1OemHTeEuY70VP8uE2xZERaA0jDbFDeZHIoW
   fcncpRE5Lg11kuFnUuPa+69CNkoA03SGPDY4viwe78CyERDb1jzOtQqDd
   SR3IMkPHsvJ1QNRUB1nYCrE3H8SCRxl4/wFn6woD9q+wLTMIGvSxJlmXC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="264769384"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="264769384"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 06:17:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="680665819"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 27 Apr 2022 06:17:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 27 Apr 2022 06:17:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 27 Apr 2022 06:17:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 27 Apr 2022 06:17:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gr5qxOCcZIeQWRa0s4+gCWnX36AQyayRTTmvfOysK0FywfYrysyDGQJ/9tXSCgEL6tEmRCOanSALtzZaodRvsRLhkOR29Zcls5COYlOf0nLFVl1pNwLsEOwzH+OG2MQXh1n8K/TYLtgLHgs7xgXm7Op+dhECybgsWD8wkVeVfp80y4NlJvhXsefGrDlXOv3ssMMI9S77o98DDua6CD7iLFipG4y11Ah0yzWKNUzDgXzNHBUDzKpaPkbAw6GMk+phUZwHmQtHLcqkYYZg/Im4m++sqiL1/6/6k3qbg1r5+yLVd/cdi/N8HcXNwjfGnPBnsPSVCvqn9SY8Ab7T8Q6jEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p06X6mNGvm3lp6jefFx9433Gy9ghO/8xXP2id/mduvA=;
 b=auuqYJkuNrxvs3r0FDwD74O0Jqbo0sRQw8vm9vsXHJayDNLGdo84PPe5wq5l2upyxgXndqvyZPxzz0TyZIiUzFVc05cIgikSxPwQ1tqe09lbszDVJ0Q1ATcyxmXX7EoCAu8s5Ylaa2Gq9lTlC+MWvLwdw/FZJVlLY5H19qOdFKTDdgEyMLhe2D6kmt9LZItwpQmjdfa6SCehiG3H2qGATYL+n1om7o83dUs4XQT14mYrlmTfW4VRArpCqSz5MGlRdK6dYfMlWIYRvfbtc7gF749WV5Zgnx2hXkjgfzwI0gneQGLeX/4CT1d5tbiFFUaAPt/yl55b+Z+tzIvS/8wMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4739.namprd11.prod.outlook.com (2603:10b6:5:2a0::22)
 by SA2PR11MB5097.namprd11.prod.outlook.com (2603:10b6:806:11a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 13:17:50 +0000
Received: from DM6PR11MB4739.namprd11.prod.outlook.com
 ([fe80::ed46:401c:cd41:ccb1]) by DM6PR11MB4739.namprd11.prod.outlook.com
 ([fe80::ed46:401c:cd41:ccb1%8]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 13:17:50 +0000
Message-ID: <5a39e32f-c0d1-8cad-71a7-845417e51fa9@intel.com>
Date:   Wed, 27 Apr 2022 21:17:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] irq_work: Make irq_work_queue_on() NMI-safe again
Content-Language: en-US
To:     Marco Elver <elver@google.com>
CC:     <ryabinin.a.a@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
        <bigeasy@linutronix.de>, <qiang1.zhang@intel.com>,
        <peterz@infradead.org>, <akpm@linux-foundation.org>,
        <andreyknvl@gmail.com>, <ying.huang@intel.com>,
        <kasan-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>
References: <20220426134924.736104-1-jun.miao@intel.com>
 <9c951fe6-d354-5870-e91b-83d8346ac162@intel.com>
 <CANpmjNNxOX12NcMjXJr3XWcoe6d+Dp74pR+2naVW0anwcYfmoQ@mail.gmail.com>
From:   Jun Miao <jun.miao@intel.com>
In-Reply-To: <CANpmjNNxOX12NcMjXJr3XWcoe6d+Dp74pR+2naVW0anwcYfmoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR0401CA0007.apcprd04.prod.outlook.com
 (2603:1096:202:2::17) To DM6PR11MB4739.namprd11.prod.outlook.com
 (2603:10b6:5:2a0::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f06e7d0d-05c8-4a27-9672-08da285053e5
X-MS-TrafficTypeDiagnostic: SA2PR11MB5097:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SA2PR11MB5097AC45DAA6BE413E00E9179AFA9@SA2PR11MB5097.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrwoTzJCPjykKP4Lu7J68cplIHTaBZd5BkpLm2ZGlxxNS8ktfUs3o0+JLtTaGv3Jo3ngzgy4fsQTzHkh8JuA8DpE6D7idg35v8x2AYLtc+xMIzMMo68sXEsZaM6b68d7yA2gPIYLucGiMtRWwfD7233y+l/QnZOxgnbHo8ldM/KoFyVSBfpCRCPIWWrDc0FO6Js+uErDEOQVZQUqohmFCTVM//GS/phf7S2/KG3PpRWSsD6JYfBwqfUXw3nMXYhLdL5DidAvLCilfGF6Qi2K9h5bx3/pqyTzE9gAC8tmxZlyvXVtrMF/cfsa0vHDy12BtZVysjI9T45tizkial5xTiP+vSP18LBv8JanXmVzoaguaV6u9zEA2P/h88GG+pXw60b4YYfYN2qM1AZCdulGEvxw7AKgGXUNff2ozkiWeFTLdZcWB3N7VLqSbJL+WlT2y+feMIVvFqTMFyN4M1MXdJeqetvlx9PpqiludcKzEuQ/WK50ezZz0bZhqsCFmI7QopDng3buraU4r5UjlZZKcetxG8UeteFdXY357N+C0zaK/eHqfN9XEXPP6Gdf2sqdLDiRvJDxJxntYazEbMertcueSYgdpydCxCIwpZy87THAInUfRV5HpI3cfmrnclKvB/qxjb9VFjR8FcABDZ0iUD+1tNgaWqCvsExfDMUWxkSwQBICa7VEnoM5rKY2jT128mOZtPRPLdKeCJMwHsh2sF8XbUd/zuyy89bQbhRpfjfXxX3+vwk/lquuCBFeYg1Llv16q/6QsVGpQpCxWl33gD9AHLbjKWI715jQEU5E5DrJ8xy8ol2EYesND012Uf3lD2dhlRWQMLmO27bAYjVb6rmUpTtrW7S2g8dgNilND20=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(26005)(316002)(82960400001)(66556008)(66946007)(83380400001)(6486002)(966005)(2616005)(31696002)(508600001)(6506007)(6512007)(38100700002)(53546011)(6916009)(186003)(86362001)(2906002)(5660300002)(44832011)(8936002)(31686004)(36756003)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzZHU1F0cTZLMVZoSU5KYUhoYWloT0ZFL3BQeWhxWFNmdFkwSDhZTWNMUWkr?=
 =?utf-8?B?MXhSZ1dlR2h2TWphNzZsellvK0xuREZLdGJXWThmdExmMWNqWmxwVEdKVUtx?=
 =?utf-8?B?TmIyKysvU1gwdU9DMXhJL2VqaTJhZGpiNlRlbnl1RnZHTXp5d2lkMVE3aUpq?=
 =?utf-8?B?RTZ1b2JaclFHb3pDZ2lrZE93Z0M3UDNlM00xSC9JdGdvejZmaEIyRk1wWXhp?=
 =?utf-8?B?ZkNZeUVGczhlUWc2SzRvVmNMVTZNNGw2eVYxVE5CRmFNcVB3QUVUeE90cW05?=
 =?utf-8?B?QTJ4SUZwQkhmK29UYmUwZEtEV0gvYzFkRm5ERi9EbmFORnVia2xDNnVYNGl4?=
 =?utf-8?B?OFFVdU5jQnBJakVsdHR1aDBNY2NwSCtBMWNBZHFPVW9kRTFwQ0xadFR3ZXpr?=
 =?utf-8?B?eGQzK3ZhZm02b0hleVp3REEvVlRHcDY3U3ptN0NHZ21OWmVzdnVjeDhNYStq?=
 =?utf-8?B?aGJMWk9Pd0lHb2dQdDJJeGN5QXoxbWtUZ0pROVp2NjNTWTZDa2F1ejN3NDI1?=
 =?utf-8?B?NkFzYTJiSDBlLzZnYytXMngwQzVFZGxpa0srbzdxdkdDV2QxQUNpZEtRTUJk?=
 =?utf-8?B?dmhNT2cvVCtMcGYwbjFNS0t4U0d5MGw0ZTkrRmpNcCtPQ1NERGw4cWZ4UkxQ?=
 =?utf-8?B?MFRtTllKaUpONmVsaGhJYmxMK0tVeHV0Y2pJb29xN3pQL1MrUlFZOWN5Wi9D?=
 =?utf-8?B?bWE3YUs0NklvNkU1eUFDL3d4dkk0RUgyeUxmVVJhVW9VVUd3eXI4d2ovSytO?=
 =?utf-8?B?bkJnaFQyWUhWc0kwZVpSSitMN05oMkdsS3U4c3RncjROWUlWM0FUZnJucUxp?=
 =?utf-8?B?U0xnWkFpWUhES2RubUZCMlNJYjY1VVIwRXJUTDZEUnJ1ZHNaMnc3VUw1emdC?=
 =?utf-8?B?UFU5UTBTRHBKK3ZadW1IeUQrOWZRaDBYcGpHZ2ZYUWE2Y05KTGZzbm94MVgw?=
 =?utf-8?B?NnZnZ3Q2bkRhM0wzZ3FsMUJjSEhTRHJsd0F2c09Ic2pMcXNsVCtLa1EvKzZa?=
 =?utf-8?B?blJQTHI5Q1Nmazd0UUVJeWJCYWN4TFpTaHFiVmVsU2oyYnhhVmhBOWpSSzZo?=
 =?utf-8?B?VFZMTjBCc0wzV2pma0c5RXdLSTdwRUQvaExrNGlHSkZ6WHZGVHlwZUlEZ0Jm?=
 =?utf-8?B?ODJxSVVzekNJQTA1dkZnM3Z2RzZTUEhLM2RJeVY5SXRyUkpFY0Y5WXN6ZHZ3?=
 =?utf-8?B?YVhhNUI0SHhLaDVWUXNtUm9LbThHUEtLaThkejdpN3VlYnJSdkRieG4wS0ZN?=
 =?utf-8?B?aXZ4TDlQSGJRaGtqR1pCckhKUUpnOGdvaGJiUVhDSzMxbGd2VmRtM2toc21V?=
 =?utf-8?B?RUUxbG5sb1hYS1pUVkRWTUNHMVd4NXZKdjc2UGhwbW1ZMU1JQWNFVnAwWW9M?=
 =?utf-8?B?ckp5eVk5WDhZdkYvRlRXVFVPZGs2TlZmL3kyNzVoenBpeVdmamluYmZ2UUFR?=
 =?utf-8?B?K0h6a293dEE5aW9rR0thcFVGL0FsT0dEQ3NRTDJIOHNoMng3WXVKZzR0a0U2?=
 =?utf-8?B?cFhUdU5zaHo2QzZ1QXhob3Fsc3VWNXo3SkRqWVJJYnNEUkFWM0NLMzhaMmxQ?=
 =?utf-8?B?cFRwUDYwVW9OZG1sclBzNVhYdzltVkRJcndKWE1SWm9uRi9UVWtuaWpwVXpp?=
 =?utf-8?B?cG5taXQ0NFhzREIxVFViM3IxWS9EQzVsQWNZVk9GRE1KQjErWXJwMmp6TDJm?=
 =?utf-8?B?czhhZkxwWFo3L2o3ZUg1dEF1VE1yeFpPUTVxQmkwc0lJNXpOS1FZSXdtc0cw?=
 =?utf-8?B?VHRVNHJoUm9STVpyd2tJMno2c2pOVmZnbWFrS1plWXdQZ24rYTUwWGIza0Jj?=
 =?utf-8?B?dTdBcVgrbXY5TG8xRnJNM1cvY2EybHM5VlJaQXhiREd2SXhMaXh2eVd6UzRk?=
 =?utf-8?B?aG85QXowNnlzV20ydHpoUHFUMVNsT0tQeGFRdm4zZkczZko5dDIzZndvb1pH?=
 =?utf-8?B?WVJFZGZBMFhxN3g4RS95Q1NFWUJMZmtRaENWbXZYc1FMbTRGTWw4ZFdLQy9s?=
 =?utf-8?B?Q1htTzlDbTJyVDRhcHdVTkZqb1I5YW9yTFBvNGNBNkhuV2k1SEdnTFIra0hD?=
 =?utf-8?B?a0VkVlkzNUg5S1k0V0VwTUgyeGRZNGZpS2M4SHNIMEprRU80VUxWbGZhYXB0?=
 =?utf-8?B?OWt0RUJCV2RDMHhjYlFWeUkyNXlJUDRnY3RjYzNWeXpqSTdaOGIzQ3hBUm5i?=
 =?utf-8?B?elczdUtlWWhmdWJXSkdPczFIc3pHakwrQzc4cG5CL3BHK0RkTTA3S0NpblVJ?=
 =?utf-8?B?OWNlZHRzbFY2c2hobzRNNTBlRnBEWEJrcDhBWkZxWkxkK2JCSERjd3grc2NW?=
 =?utf-8?B?bDN4WEtpbjNxUHExUEtMNzZ3Q3RiVXhTQXRQcTg5M0FSVm9rMHZmdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f06e7d0d-05c8-4a27-9672-08da285053e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 13:17:50.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmaIbZZAfalbNBEDcytuV+w4Lub5xCyFo2xvcwlwK3dFtPNAe3wUmuqhFQ6XCAiFPmaaKcbL1KTH0kQ03qeCOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5097
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


On 2022/4/27 20:26, Marco Elver wrote:
> On Wed, 27 Apr 2022 at 03:49, Jun Miao <jun.miao@intel.com> wrote:
>> Add  To/Cc : KASAN/MEM , since I only used the scripts/get_maintainer.pl
>> to irq_work.c file.
>>
>> Thanks
>> Jun Miao
>>
>>
>> On 2022/4/26 21:49, Jun Miao wrote:
>>> We should not put NMI unsafe code in irq_work_queue_on().
>>>
>>> The KASAN of kasan_record_aux_stack_noalloc() is not NMI safe. Because which
>>> will call the spinlock. While the irq_work_queue_on() is also very carefully
>>> carafted to be exactly that.
> "crafted"
>
>>> When unable CONFIG_SM or local CPU, the irq_work_queue_on() is even same to
> CONFIG_SM -> CONFIG_SMP
>
>>> irq_work_queue(). So delete KASAN instantly.
>>>
>>> Fixes: e2b5bcf9f5ba ("irq_work: record irq_work_queue() call stack")
>>> Suggested by: "Huang, Ying" <ying.huang@intel.com>
>>> Signed-off-by: Jun Miao <jun.miao@intel.com>
> I thought this had already been removed, but apparently there were 2
> places: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=156172a13ff0626d8e23276e741c7e2cb2f3b572
>
> Acked-by: Marco Elver <elver@google.com>

Sure, I also found this patch which is the same reason, maybe Peter Z 
forgot it. Let me make up a little.😉

Send V2 later.

Thanks
Jun Miao
>>> ---
>>>    kernel/irq_work.c | 3 ---
>>>    1 file changed, 3 deletions(-)
>>>
>>> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
>>> index 7afa40fe5cc4..e7f48aa8d8af 100644
>>> --- a/kernel/irq_work.c
>>> +++ b/kernel/irq_work.c
>>> @@ -20,7 +20,6 @@
>>>    #include <linux/smp.h>
>>>    #include <linux/smpboot.h>
>>>    #include <asm/processor.h>
>>> -#include <linux/kasan.h>
>>>
>>>    static DEFINE_PER_CPU(struct llist_head, raised_list);
>>>    static DEFINE_PER_CPU(struct llist_head, lazy_list);
>>> @@ -137,8 +136,6 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
>>>        if (!irq_work_claim(work))
>>>                return false;
>>>
>>> -     kasan_record_aux_stack_noalloc(work);
>>> -
>>>        preempt_disable();
>>>        if (cpu != smp_processor_id()) {
>>>                /* Arch remote IPI send/receive backend aren't NMI safe */
>> --
>> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/9c951fe6-d354-5870-e91b-83d8346ac162%40intel.com.
