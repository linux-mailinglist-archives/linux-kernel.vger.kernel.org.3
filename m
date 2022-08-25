Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8EF5A0AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbiHYIE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239034AbiHYIEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:04:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBE257577
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661414682; x=1692950682;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cYYolpIBMQyx/xk+u3QStX/Ue3KKtYmNmKrwe5HXCkY=;
  b=QKeJl4QvJltikAwRVKvEKme4HYfTbrCkXkyQC+ofLvrz6iMXqu4zlnmg
   /3wDrAN365MSDnGgX2LXymZhz7H18kun2iF0QrvayhHj8Uwzwf7jm4fDK
   Bq3pSLs0ymCCzaGUdwH0P/IZx5OK6PAtjs8s7XbVccCyBWbOpzvjbm5d0
   cNmhPqZh5F+b3VWiiEUsWAaSIBqhwwNng5SmURNNUTtlvXJluzC54VM2Y
   U/G6AatTSBrVNqYx6fxZBB11OJoUT1dhlaLny3Zk5qHUi20H2Jgtoy1CV
   TYfnMX4tdIP24gih5Z3/J8J/NRo4BSUHoLY1I+QIoiP8EGDNpFEMYvLDa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="291745444"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="291745444"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 01:04:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="678364841"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2022 01:04:41 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 01:04:41 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 01:04:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 25 Aug 2022 01:04:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 25 Aug 2022 01:04:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK0IfiDwXXs48szJbVGvYuh0TFUzVjVFE+brhuqFhQUwEjkJH/q9CLbq8DC9E1ZcQ865nq5wpJn3vHTESjeR8dtln1rt4I+X+gKX86E7B49F9U/p9E9eJWykVBqC7qdYXku9X9zdB8eZysP+ueYVmsb6Q8johxybuJtjI96D0VbZPTgUmYR07Wji//BYXbMQpt0C6JQ5qTT9+R1/zW+WCA5EdfmxCAyvbt9fqkzvUwazDWjOprFWw+UGc/wE917JUxjTa91pjsN0dqCFPlbzyhwu0TkZWG6BMdVMkpOC9bMc5duyf8HOeyLlr1LCWrImM8fJUtXA1tm6HSX5vuRIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mf4oXxdrAQjmisowjcy3kqixhkCJcocCg+ROr9DtN0k=;
 b=NbL7t+wbivjJ5IC8qo0NOqOt67jFEaoQikc2Y9oAmAHnoF5efeo+a1GflO0F4oFJVH9IWH2gyoFpapYs1Eq/vWO0OL6xUuk041DdnK7obq7Mol1G1q+gQ33kfzeBFf/5Te5ckl7qIaILkvBX3bIGJIdXS2v5M4q+RsPnMFPzpZ7vMXCm3+sJRU2vVVf3SW93o8h5eF8Qpksz9dK8Ug04L/z4Je20Hrzj9c49Ho7XiCmrLVGkizOO8vSV3q8UU0zeqOk2wOaoKFgg949ovORWqxKyz0ujesJSaNDMKI1J92X8cg+bwOW2OSLzyrwKNnxXyI1dkug9avogL+zn+IZotg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5409.namprd11.prod.outlook.com (2603:10b6:610:d0::7)
 by PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Thu, 25 Aug
 2022 08:04:39 +0000
Received: from CH0PR11MB5409.namprd11.prod.outlook.com
 ([fe80::70e4:76ca:fc65:df73]) by CH0PR11MB5409.namprd11.prod.outlook.com
 ([fe80::70e4:76ca:fc65:df73%4]) with mapi id 15.20.5566.014; Thu, 25 Aug 2022
 08:04:39 +0000
Message-ID: <f9cc9317-044d-4f7e-a37c-a06df7262077@intel.com>
Date:   Thu, 25 Aug 2022 17:04:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Intel-gfx] [PATCH v9 2/8] util_macros: Add exact_type macro to
 catch type mis-match while compiling
Content-Language: en-US
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     <bgolaszewski@baylibre.com>
CC:     <intel-gfx@lists.freedesktop.org>,
        <thomas.hellstrom@linux.intel.com>, <keescook@chromium.org>,
        <jani.nikula@intel.com>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <chris@chris-wilson.co.uk>,
        <airlied@linux.ie>, <andrzej.hajda@intel.com>,
        <matthew.auld@intel.com>, <daniel@ffwll.ch>, <mchehab@kernel.org>,
        <nirmoy.das@intel.com>, <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
References: <20220824084514.2261614-1-gwan-gyeong.mun@intel.com>
 <20220824084514.2261614-3-gwan-gyeong.mun@intel.com>
In-Reply-To: <20220824084514.2261614-3-gwan-gyeong.mun@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0044.namprd08.prod.outlook.com
 (2603:10b6:a03:117::21) To CH0PR11MB5409.namprd11.prod.outlook.com
 (2603:10b6:610:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae70a4a2-901b-403b-997d-08da86707568
X-MS-TrafficTypeDiagnostic: PH7PR11MB6005:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wusLjk8QoN+E8gZjtMfZzVPfBZgT5FBujrNLWlcMv6CCgTXZiaIzFcSyGiTdhkdyOpGCblWhhce2tW51xfltn24uHG3hsxbbIfx6dtnW8QqLu/nyPEvqDa2tfJrVLkLwBK9rCfjbFN56c6/W0utzWJj4/MDF3jqD51AV33kwGgiY5SKAHwHOEeLiqRKjeaQfUWluzgKjJ+zhr8gBaaHuKrI8Tf3OV++2u0Y0asNUE22Oq5AkeAdijPLlfzdXg/RXGJfltkKrqMrTLbfcnIz17pLYNA2+FjsPudrbL5M6HQPUoKgpflrsyMEhgPfuv4kwRC5ytfuUZYsTADWwrkJifFbOukuZ/E3M/l9r+RgZh5U+8u5wKf8xi9lTniddCEyFQ/foGUjOmS6tXqfV09TjI8y4HYWYzNsSN6zXn8ul2p1TlDvd/XK8FJXh8wDEElJAe+Q2RywB/XpPRsKA45zOOEdJ+lnyS7cELa6Q8perm3vSc9MchfFyKMUEeqQzyVu+YFr9LeFoxIFY3UGDEMSkBP8S/LgjbbDgmP/3mdgPAsMGhgTql5VUSPM0+eaN9cTbGxRBX24OzyTvhP9fK0p5f2gbmtr1/rWVqgn6PryCGkYv0Wpjp6dbekaAKeOVUKoBEbQ9iUfdUEkOBUgf6Ed8gMfoofIh2e2uTHi5BKuQMWL4aMtuo7Tu7h1cg8S2GrFcAvNJ7GkDhbC/+rnvelM6pScun8tBYsvyluoGTNzajkTqwLNQTrlWDX8QLazvSBh+0m4RNNSGzlUwMmSUpaxGrNG1rBqWte3O9hFSCm8RxLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5409.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(136003)(366004)(346002)(39860400002)(31696002)(66476007)(38100700002)(8676002)(66556008)(4326008)(5660300002)(86362001)(6916009)(31686004)(82960400001)(36756003)(66946007)(186003)(26005)(6512007)(66574015)(53546011)(6506007)(2616005)(478600001)(6486002)(6666004)(316002)(41300700001)(7416002)(8936002)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDlPQkZ0M2JKa2FSd3RobWh6YmMxdy92ZTF2RW0zVWwzNFpvOUlMcjcwM0Nn?=
 =?utf-8?B?Qy9uYVZNakJpOHVQL2NhVFpRbmhCU01aSVIzV280Q3hOUFpySzNtdGdzMndG?=
 =?utf-8?B?MElvREEzSWh1dGNkNituSDVGY2tIampGSy9hVCtIa0tBOWdUUy9valh6TFRk?=
 =?utf-8?B?OXRzVEJucWkrKzJRcWdBUHVvQ1lQZERJYmdjelhnQlhZSCtaaFkvNHBGUXVH?=
 =?utf-8?B?UDc4d3M4Zk9wNC9IWHZkMEpROEphRHhPTDFMRndranA5TXkwQTNCd1MxWHBl?=
 =?utf-8?B?YkJ0cGs4S3dOS0lldDhkT003Nk5sdEo0TmcwM0VKczVwNDVWTE9OaVZ2SkY3?=
 =?utf-8?B?Sk9rcmZCUzNCV0NKV0tYWVdWWFdYUDZwQTVIVzFrbS9FS2ZMckpkTXZoaUE2?=
 =?utf-8?B?QmtzS2ltM0kwS0t1aDZ6azdiNERGMndVVWtVZHJoRktNMkhRV0NzTU1MZzhw?=
 =?utf-8?B?TmY2dDZMRHV6Q2N1SGZvVDJxeTZhVDJSNTM3OElkeUw0T3BTemhVMC9SK0NG?=
 =?utf-8?B?djBDK0lQYno1Z0grMEpHV0lNTlhKU1lxKzBPc1RWVk4xak11cGhiQVMrdm83?=
 =?utf-8?B?WWpDTlNKelp2VFV5UkNHRklqaEVFak9YV1ByZ3ZJREpndzFkbGk5WTlhb244?=
 =?utf-8?B?Z1M5UEZmNU11QnB2Zk5weGVOU0RobE1CMEc0Z1ZRZHc4MWs4N0R0VXZOb1Z0?=
 =?utf-8?B?NS9YZ3VORXBYazRsTTd5bDFYWmtRMDRzWWI3RGpUSVIzaWx1ajRCY2ZNVVBM?=
 =?utf-8?B?SUg5K1ZWS2dPcmFjWVcyYk9WdGh4NGJXY0lCbmNxejUrbGZXNE9WbDhjejU4?=
 =?utf-8?B?R09TZVNBNTNWZVdsUGN3SElTeDlaWFR6akRBVHBvT1pydU9sQkZFNDZJak5M?=
 =?utf-8?B?WS80dTlvL0pCU2tvTjNPVkU1WmQ3ekNMT0R0QVNKYzU3ME5KKzlNdkg5TmZZ?=
 =?utf-8?B?NEw2OC9UU0xhQzd4ZGVIdW1nLytEak9iME9LM1pqc091ejk1QXg1SG5RQ01G?=
 =?utf-8?B?aDBod0JtOERCR2x6b3cyMUtNWVpEYVAyRmwvTEs2d2daTzlqVHpPSUtGTVdR?=
 =?utf-8?B?eHUvaXowdFROQzByOTZmUlFZZ2VYUUg1OTRkb1JJUS9xV3RESmRETU1mSFlI?=
 =?utf-8?B?bnRXTVNyM0lFSitCb2dDdXd4MnZmZVd5RS9wRWxoNWs1RTVORlZydlpEWjR6?=
 =?utf-8?B?ZEl6NEdBTUx3Rk9jZHJ4THVoMEgxZkxUcDFINU14QkFvU0pqVzBiZDdyTXZi?=
 =?utf-8?B?MStoc3JhMXFBYitQVm81TG9YdVd3U1dpNldLMlErL1FLaGcwODloelZrMFd0?=
 =?utf-8?B?aklnUmplNHk1cXRsY2pyZWVSQWlJdUJwV3VXRzZHeHpRMkNsZXBQanFmN01Q?=
 =?utf-8?B?V1VEejJid3FTQ0g5Y3IvZ1FQT01LTlJtbTVibHRyemNPMmFyZDJieC85STFD?=
 =?utf-8?B?anhnUVNkUjNVWEFsUmdqbllMSmpOV0w4UVluSXM2VGFLeVl5amg4ZVltSlVX?=
 =?utf-8?B?L1RyL2RSUVAvOTNFMHdaYmkyNW04QSs1VUVvZTdhY1QwWWwxZHdkQjN2MmQy?=
 =?utf-8?B?cmg3cnRjcytjUFR0c1BGeXlFY0dwY2taSjhDQUV1OE1qYUNRMTlDcFJmaWNm?=
 =?utf-8?B?MHI5ZGdsdW0welZJSWRSQ21UUENZVXdUR0dpNFRIKzJBUUdMYU9WM1JOTkNl?=
 =?utf-8?B?OUZOL3ZNeGpSVkdDU2JjRDVqZU0rMEpvUEZmRk1DZTZqWnJaYTRicHNuSm9Q?=
 =?utf-8?B?SUhCbHFLSFZ2TS8xampvOUNLa0djby9DbGQ3WGNlT2FiTjBWTXZJWm5sWENv?=
 =?utf-8?B?am52VmxjR3VlRFR6eGJtNTFGU01Bdk9OM2dEVHlneFk5NVRTWWhnMkZ2c1VM?=
 =?utf-8?B?ZFRsQXZjYXlSOVFCNE0yTXFLYXREMUYxaFIzVmFGb1MrWmRtSE1sOGl1N2tW?=
 =?utf-8?B?WXlyV09OKzJmeitoWUFheDBleUhpV25lL3pYekFkVnpVVkF0NHpveUlFbWQy?=
 =?utf-8?B?bk1mR1hNWXNrZVRYSi9TSzFKR3ZvMmxlcTk5YmtkVTdhRFZNRXNnaFJ4Nkw3?=
 =?utf-8?B?MDVtRTVqVzNxR01VaE90UStYTWtBdEdlL21QS0NpZmpoSFRiMy9hbENJcEdi?=
 =?utf-8?B?NHBldmRydUlsY3NjZEFGUWx0L3A3WDJiUmtaN016bGJOZmUwNkFkdmw3dkt1?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae70a4a2-901b-403b-997d-08da86707568
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5409.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 08:04:39.3562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BKFuHE/j0tb+FXjd+GuPmaVf0j2r5oHTAvch/vvVsC9/UMne+qNIvLu3CttxbIrgSNvJWjptNyf73l4YAJc111r1MywerdDrcU59FWm86g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6005
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz Golaszewski,

would you mind taking a look at this patch?

Thanks,
G.G.

On 8/24/22 5:45 PM, Gwan-gyeong Mun wrote:
> It adds exact_type and exactly_pgoff_t macro to catch type mis-match while
> compiling. The existing typecheck() macro outputs build warnings, but the
> newly added exact_type() macro uses the BUILD_BUG_ON() macro to generate
> a build break when the types are different and can be used to detect
> explicit build errors.
> 
> v6: Move macro addition location so that it can be used by other than drm
>      subsystem (Jani, Mauro, Andi)
> 
> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Nirmoy Das <nirmoy.das@intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>   include/linux/util_macros.h | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/include/linux/util_macros.h b/include/linux/util_macros.h
> index 72299f261b25..b6624b275257 100644
> --- a/include/linux/util_macros.h
> +++ b/include/linux/util_macros.h
> @@ -2,6 +2,9 @@
>   #ifndef _LINUX_HELPER_MACROS_H_
>   #define _LINUX_HELPER_MACROS_H_
>   
> +#include <linux/types.h>
> +#include <linux/bug.h>
> +
>   #define __find_closest(x, a, as, op)					\
>   ({									\
>   	typeof(as) __fc_i, __fc_as = (as) - 1;				\
> @@ -38,4 +41,26 @@
>    */
>   #define find_closest_descending(x, a, as) __find_closest(x, a, as, >=)
>   
> +/**
> + * exact_type - break compile if source type and destination value's type are
> + * not the same
> + * @T: Source type
> + * @n: Destination value
> + *
> + * It is a helper macro for a poor man's -Wconversion: only allow variables of
> + * an exact type. It determines whether the source type and destination value's
> + * type are the same while compiling, and it breaks compile if two types are
> + * not the same
> + */
> +#define exact_type(T, n) \
> +	BUILD_BUG_ON(!__builtin_constant_p(n) && !__builtin_types_compatible_p(T, typeof(n)))
> +
> +/**
> + * exactly_pgoff_t - helper to check if the type of a value is pgoff_t
> + * @n: value to compare pgoff_t type
> + *
> + * It breaks compile if the argument value's type is not pgoff_t type.
> + */
> +#define exactly_pgoff_t(n) exact_type(pgoff_t, n)
> +
>   #endif
