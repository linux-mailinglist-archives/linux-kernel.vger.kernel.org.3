Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564AA510E75
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356961AbiD0BwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343798AbiD0BwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:52:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEC049F17
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651024141; x=1682560141;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KY9FRRufzaiLz5mhk6rCA8sa6magifzA/ZkdZGKgBm8=;
  b=HVpQ/NBzVhrjKtRiko8let3Wet7lqmTA8hNwNFiQxSudWc9dVva35hzK
   65oZuo4//3v1lJykF4NmgluVGZx3VHnEaesIm2BRL+mNoYbSPxvL5iuL0
   8RgE30VQTnUKLe0U1XSzYSzbhLqOstdBIyTbCd4eUVvJ2vHPOOXIC1sXf
   AQWky8JvcA8shvC7A/v0l3M/q555vScu5yhSYbqNkm01QMRV9+0mtBoNg
   l0lzDaVTBlVgGG59L1DlzFqNJJf2qHdGF621tWz3HQtuZnwbzFIT1KBSO
   cgIHDSVKAgXNba381qADaTjNIz739GYswStYw+rU9uEDn0S7LrR5pRd5A
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="290930560"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="290930560"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 18:49:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="539322565"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 26 Apr 2022 18:49:01 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 26 Apr 2022 18:49:00 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 26 Apr 2022 18:49:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 26 Apr 2022 18:49:00 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 26 Apr 2022 18:49:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gon3gyvZILl8+kzoOd7kdE0r1tYAyOzGmoq4TR7P9PQ22pTy0DWhCVaFm4/1oUkZZ/VVq7NZrFHruKgGMsHTTun18noCAlj2qvgmEaAWggphsSzwe5gUEk6w2SpTdohi1WP+uJeXJJhyjb7h3M9zJJOxRUVei0uNfzgHDV2UF2NOcJillIZivHDwAtFgVTsDAlERUmDmclzVBDUGuOHc7bZqWLVJvBZkb+MbDsAIUw4jB3cpbRKUMRk0XIdD2PMp4//ol+j7Od06hjcRJRWy6xh0Jt+Eam3FQ1ZQwtPrT5CR6L5Z7L9cWk9fAnZVRo2gBPxDSSg6Yusq/O6ZXruM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ABXjNAW2sIhDaGodpX/eX5WMwl/qRDJLtCXxeMWGPI=;
 b=TgmWoi10JMAMM1RiJi4WWoZ4UKSL7JjcIDYN89y6DVWzpcqa5mqGe5u2MWF0M6wo/Hwn9vB1zmk4geWeon7AlFtHA0b240xv8rRbJwPw427d+vr1WKu/TILJ+utY6JCuiP6LY6f2g/AvS8b+UeEkv1e9A9WeilJqw1jq+ye4wX668nLGCuNGHkMRScpWa1nrpKiEWj5X5FlRMJ3d4UtpbxRO7z49+afjDax1ntj0ht7zyfsBEkNdL0Otsu77KVzdCgUjXU0ASWWeyrTmkGU3FftCNhlMRM3QtGww/Ix8OefSWNagFgtuC5K4Fp4k9CqkdN/ceU1TxL3FXwsXc2/dNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4739.namprd11.prod.outlook.com (2603:10b6:5:2a0::22)
 by BN6PR11MB4113.namprd11.prod.outlook.com (2603:10b6:405:77::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 01:48:58 +0000
Received: from DM6PR11MB4739.namprd11.prod.outlook.com
 ([fe80::ed46:401c:cd41:ccb1]) by DM6PR11MB4739.namprd11.prod.outlook.com
 ([fe80::ed46:401c:cd41:ccb1%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:48:58 +0000
Message-ID: <9c951fe6-d354-5870-e91b-83d8346ac162@intel.com>
Date:   Wed, 27 Apr 2022 09:49:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] irq_work: Make irq_work_queue_on() NMI-safe again
Content-Language: en-US
To:     <ryabinin.a.a@gmail.com>, Dmitry Vyukov <dvyukov@google.com>
CC:     <bigeasy@linutronix.de>, <qiang1.zhang@intel.com>,
        <peterz@infradead.org>, <akpm@linux-foundation.org>,
        <andreyknvl@gmail.com>, <ying.huang@intel.com>,
        <akpm@linux-foundation.org>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
References: <20220426134924.736104-1-jun.miao@intel.com>
From:   Jun Miao <jun.miao@intel.com>
In-Reply-To: <20220426134924.736104-1-jun.miao@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To DM6PR11MB4739.namprd11.prod.outlook.com
 (2603:10b6:5:2a0::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8e9879b-b6ca-4434-891b-08da27f01850
X-MS-TrafficTypeDiagnostic: BN6PR11MB4113:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB41130D7A422ACB566CECCCDA9AFA9@BN6PR11MB4113.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYGZut9LHm/4xMlf6GQm9P9EKvdrpZSJSy2xuukssH/uvspNaHkgl9nrJnyUTyHBp72/BP24G2NHk0hRiFitv0stjZaKstjtloV+WJd3NokBfcarO6+hRgS3YUVviAquPjVkDy5rQ6Eg9G39JFmMyGNB7aw20ArCFcSs1Cjbx7IpT52pNq6FNSsvVh3Y8YDjoTcFL/2VtOY3b8r0SH7ZaeMSo55OHsldqczf1oYFBcVc2RAO/f/3xXw8hIwCTRwQmeLjCloGk6mZeC6TW61k2GoinFGz+gzFu8P0QrYpr2DdrLz5ehGkVdIGNGKfdnQwQQfutXickwu3SfXVCSbl/Vr1Mlk9DqkhnMGypFT0jIAa+oFZAgVHXTsslP8seU24PxPuLbj41pUuzFsIt4IhStiWH8aix9vevJDZJZyW/XHUYpdwj2iJFyIUii1HFklx9aaKYXmLXO10KWJxMW3y+b20rCh2NidI9tgAMq2JbTDa5d14IR0nD/MO/TT3FXm0MNjFM53bH3eF/NTaM5+89W3VcrrKsDJwmX/SPrMEmHhQ9vTlT+n24TWIJG2NnZA6+Ww2DXMNGUqC0u3bIXjJMJoTJzWqwdR59u5GnLOkUoDqJsp57KSoTmiWE7j6Ss8oqKUFDLsnpZUaOXbhRa7FOh3lexgpfRcnuCS+nmQHdmfYwNDLsALHf30W82UtK4zOla0t9lFrAOceiYQtUqvyAqCQPiFumO8gmgJI4kfp/fA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(83380400001)(6916009)(53546011)(4326008)(2616005)(31686004)(316002)(186003)(36756003)(66476007)(66946007)(26005)(66556008)(6486002)(82960400001)(8676002)(44832011)(2906002)(38100700002)(508600001)(86362001)(6512007)(6506007)(6666004)(31696002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0lGK2k4N3FzZ3dKemcra0JLOUswMDEzMDhPMnNuNzFqb2U4TFBWb3JFd0xJ?=
 =?utf-8?B?TmhPaGZGZlN2bERmSmQ5Q2pQWkQwWkpmMDFuMWlmcHg0SFFxajRoM0phSncx?=
 =?utf-8?B?dzRSWlE2RmtkaUxvNWliRTdjUitzUlRHQ3k1MkMyVTRYU2pTMDlieGpCajZu?=
 =?utf-8?B?bDV2OHVCZjdrZ21aeGI5SjB3Ly96TURkeU1Xb2tLaHBQdFRZY0RkSk5rd1U2?=
 =?utf-8?B?SnZlL1EvUmJaUllCYmVyVmhWOUNmVzRrMW92NG8rS2JtMzRvclYyeTZkc2U5?=
 =?utf-8?B?Rm5RYnpEa3JnRmNXOWk4UEdIT2dJTHdOemV2aitDWGRCL3NoN3pCZXhsVXNt?=
 =?utf-8?B?VituN2J0R1dvRkNJQ0hRUVdyVk95TDhBYzFiQzNvRDk0SkxJWENpbEtoanVG?=
 =?utf-8?B?SWllRWMvVmJUMjc2c1ZUYzBIMEJ2U2J5S21tM2FlUUczMjNvR3ZzQkg1NW1S?=
 =?utf-8?B?ZlRTaGRFOFpOMHNoVERCQU9NbEpJVzVmcWgwSldjZUVlRnVDQk9mbGpzM3pm?=
 =?utf-8?B?aG5ZRkpGMFFjQUcrbjdwKy9UOFUwUTByQ09JYS8xZzdma0lyNUlFMkZqYnBx?=
 =?utf-8?B?bzV3KzZocXMwK0FRTTJ2YUdzMmFyTnVZYzFzVGtRbU5vSk03bTN0akV2RG4w?=
 =?utf-8?B?cyszcEVBYTBqL3lRbFJEM0x5djFBSEpwczIzNDlySTI3K0JvY2Z6VUIzQUtU?=
 =?utf-8?B?YzlOR3RmM0dyMWplOGFoVXYyUHlYTkNXazdobXg5OXhNTkhUMjNZK0FXUFV5?=
 =?utf-8?B?encvVFRyZ21lZlJ2VE05YlJKOU1BdWo2cU1mT3JQTnVLTVZ0R21wRDhjd3hx?=
 =?utf-8?B?M3B6a3lMWlVRS0orbm95ZGY5WDdPaXJPN0FzWDVUSWN0WXlBeU5hSjA5eGZW?=
 =?utf-8?B?d2NiZTlwOEM1Q3hIQ2QvUlBpcGdjalNqTm40MWJERVJ2czJFV0FoTllCUjUy?=
 =?utf-8?B?TnVxdGNMM3dtcERrUmJXV0NUTEQ2MEJNTGhtS2VPRjdPTEdXMHZvOW5rckkz?=
 =?utf-8?B?NXhLY3V0T0ZkOE1KcXdsU0cyaDdNYjNzL05aZzBCNnQyejdNdFlIU2x2Ymxi?=
 =?utf-8?B?TEU4Z1FPNzRzbmdzenZ0NkFIUXV0RlVyWDVwRVV2T21PSWk5Q0RrMXArRlpN?=
 =?utf-8?B?RERVZXdPMUhMZnNwbGkxMHpiOWRtdDhkK0QyWFlRTHliYlZhek5lWG5MUkQ0?=
 =?utf-8?B?NW9PQzlmcG5tZ1NPNU5YUHpucXE0SklxYjMyK2FwcFdVZDJBV2dnSWJQaGdN?=
 =?utf-8?B?eTJESzZxN0F5NlhZYS9JY2VTMzV6bHEwUjJ6WG5CK2xhK0lsUDVZaHc2STdO?=
 =?utf-8?B?REdLWStENE1oeHIvaVRvbUxLcEw0c2VHZ0NnejhhcGdIUDE2UmEyNHl2RWxr?=
 =?utf-8?B?WU9kVTQxcHhUNUFTeFFNSGFQVFc1V2NFaDJ6U3Y1R2YxTWtsZzVsenpDQmFS?=
 =?utf-8?B?NW1CVkpRUE9UcVdDRWZTUTQ3Zm9qY3ZDcVFIc0NvK1VzdkZRYUs0NVNicXNm?=
 =?utf-8?B?L0VSeENnZmhsZUJuU1kwZnBoWjExK0k1SGxlTm8zZW5PWXdZcDZFVzVkRSsz?=
 =?utf-8?B?bVh5T2pZV0lrQ1NHRmYxWWUvb083amxLN1hWdlRzSjQ2TXhhSWJZQktGSjJv?=
 =?utf-8?B?bEo2OXRFV3ZCbmxOZnBwb1RrcGJuRGdPTFBlYUYyQkM1WEd1NE5HNFlzbzNp?=
 =?utf-8?B?VElIclc3VzZjTkp3U09uUW9nc3pTUjdjc3FzUFFKdXBaN3B2aERyWjFqcUpj?=
 =?utf-8?B?M1dFM0dtVVdYSUlyQ2Rzb1NoN1RaZk5pRmZZWlpRWVZLcUorZ2lFNzRFcTBx?=
 =?utf-8?B?Z0t3SWRoQXVMNDRYT0RMZ0xnbUQxY0ZYS0VOeUs1ZzdJTU1zdXg0eUtTQ2tK?=
 =?utf-8?B?OXdIS0NaNzZpMTlvSTUydW9YM1Rwamg5blBHV3JYV1FoeEYvK1UzaGh2bWNP?=
 =?utf-8?B?ZzNZeGk2M085N0h5VlV5eGhVc2FHUUtVbWlPelFWTjBEL0ptUWtQWmdBZ1JR?=
 =?utf-8?B?TmFNdnBwdXYwQUxHYWxUbStLWnFkTUl2MWdrSW5LS3RrRnZPOG94bkUwdGlu?=
 =?utf-8?B?SWRiWmJ3LzVyeGpVVjdnVEdkR2Z4ZXU5amhRb0NEU2VNWDhPbXpHV1J6b3Jw?=
 =?utf-8?B?MldzenJuUlBhVll2NnFFeEhqYkQzT1BrTFRhS0k1ankxK3NuOUJ6em96L3FO?=
 =?utf-8?B?aWdhTlhjcWJ1L3IzSUZWVEdNTXVDaHhLMXptNkpKV1JTN2dIUmNFWUVKeVB4?=
 =?utf-8?B?UVVLc1phNklIblJ2ZjBaUkhuK1V1bmtVMmY0TWR1WUJXU0JFc21VTFRHZWd3?=
 =?utf-8?B?bzlwSEQ4cERnS0krekx0M2hEaEt3S1J1TmY1b1dWVUh5N0pieWtNdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e9879b-b6ca-4434-891b-08da27f01850
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 01:48:58.3036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0nbghUb37gXqkO8E0Poyr9PVsesHxbG1ujcyKeIci5cpxvY1e1LtLBYcgnE+pve5FzS3cIXTcXukBoFKpzn1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4113
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add  To/Cc : KASAN/MEM , since I only used the scripts/get_maintainer.pl 
to irq_work.c file.

Thanks
Jun Miao


On 2022/4/26 21:49, Jun Miao wrote:
> We should not put NMI unsafe code in irq_work_queue_on().
>
> The KASAN of kasan_record_aux_stack_noalloc() is not NMI safe. Because which
> will call the spinlock. While the irq_work_queue_on() is also very carefully
> carafted to be exactly that.
> When unable CONFIG_SM or local CPU, the irq_work_queue_on() is even same to
> irq_work_queue(). So delete KASAN instantly.
>
> Fixes: e2b5bcf9f5ba ("irq_work: record irq_work_queue() call stack")
> Suggested by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Jun Miao <jun.miao@intel.com>
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
