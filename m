Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69A2597ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbiHRBAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiHRBAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:00:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E998D3F1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660784415; x=1692320415;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PLwEyoTbOnUvtL8Q8mC+X3rAJ1+UWZW6HFrNKahNAHw=;
  b=UrZr1z4OifgvfxN7yg5zVcBfuyyBq6hyc6Oev2FlTpE57EBn4rPqXx5h
   1ehaOfUDuq8ukZggJLfaf/yMPvV+pP1erJwdApHWFpUQy+qrwwCxkDjO1
   6fDiSVIezJwPn/ThIvsdVM2dQJGtIKuSu5GzAqf8m+sepKZj+zE4W5ezZ
   TCvlq93AJdL2w3Uv8zdR7pHXMkiVuRu/dPlMnKyfdXmE/FkRx4sNdTLVp
   ayR9xtw/b+LiImvH3ZzQIBc20UgF6u8L49wNT08GOqOCLaiRBG5bXpycq
   Wnpv5tk56MHd6rNGnuU6zrHi2A9RPiCJaE0FWn/+jY1In9y+1TuOx0EVP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="291390938"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="291390938"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 18:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="710764958"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2022 18:00:14 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 18:00:14 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 18:00:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 18:00:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 18:00:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Co3QAtI7CQn6Xnom0Cdcj1jcTaTnokfEdhGX1+yUhRoTiv54GCVP9MqsbE82e0PVdXKPgofA64xbDChj2wvYjK7q41yGPKlk2Kl1gLExYscMIJ1LxmHsTNcy2IYfFJiPQg4FzH5dcu57OZBKZhMTLYZX+qEFmreyad9XhbY7+xws2GDrQcGfNuui9TMK4jp0piJxRps1WOfSmPAwG4vhgt6FMKBkt7V4kVP7UkZzsvSd6E0HKhrezj42C5JY/fGABBN/dH0XY6SqQ6eeorDlBNUkvxhydnHdP1JN5KgDDMqSL2NR6U1T6R9rCscfJEpU5+XkIYJQ2p8aZb1Sm/khkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quLzwjA5gnTVeetHkTL1zQbTiHtZ8Oh4c35kSSusPj4=;
 b=kJ2TvBf3zNZev1QCbzpfAmPmZ+tTdWJxoD5wdBv/mset5qPNPdDjNRg2B6op2pr3PmZgBaIOWl3NWL3S4mb3lYVmfvPI5PafbKjwWjOQqY5JMZ6h2v9B/o26UYQKOG4shFmAn6ZqcixHQEMDEHkmgl38XT16/3yeNurEYqdlN+P53d3ZCwQXCrM/wEz2NrnxapQF1Sze7LSoX0mnf3kG9LonFfJu9PRB7r93PmlEH4zyjHbM+Q4j6X5+Rrt2EJWiz0pBFQqZ1quMkrcVJaY31oPC4DuYJ77OW3QaGJUWdabBE8cnQun6yR51nEO6Nhi/lT5JzG3sijRpfvSvkUn8cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM6PR11MB3820.namprd11.prod.outlook.com (2603:10b6:5:140::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Thu, 18 Aug
 2022 01:00:12 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c%4]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 01:00:11 +0000
Message-ID: <688a6ce5-c291-78c7-beb9-81933c607672@intel.com>
Date:   Thu, 18 Aug 2022 09:00:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 5/6] mm/hugetlb: fix sysfs group leak in
 hugetlb_unregister_node()
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-6-linmiaohe@huawei.com>
 <b44ef13c-c9df-5d08-f92f-649fef9d74ee@intel.com>
In-Reply-To: <b44ef13c-c9df-5d08-f92f-649fef9d74ee@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abe79228-29fb-4bc0-fc57-08da80b500b0
X-MS-TrafficTypeDiagnostic: DM6PR11MB3820:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHItTQ/1UH1VYTkvc6eI0KjQUX6AtvY6PaA6WSGso8boalrvbQPNAGKNz3v8d9gn1UPP1ZW/kSM+UuRkPaaVCCSnMlwF7ZJQMwIqKjyWQl4Vukyhj8RwqYM93H9mSt3KasRgso8c9RJmN+Y/pQpLbR4wNhl//28HqnAMR9QOcCoH7gNmJPNyRe3HkSlFHYW5yS18S55i2y5/y6cX0P9MnaLhATZZsm3eAFnI7zVWXV1A9KV0SJwZtPycKRJjyJ7s7oxlxB0tD3smKHQJX8E6aZfi9MQCgta1rJyix/2hCF+XoX20KDPWZADJsFpkNLgOClkaPFdUi0puxUoSomGIkCUP3HssTBou8uvIL+Q9ncDXmJpXPbWt5FAy8Q7tOBg6mZ968e3wOgx9OuV/3ea5FZ7HGN4HchGGphptHrorgp4oZR6FzRx23dEh5H8uP45GpP1aY4Z7SAeb9d3fCdW4Q5dy1XMRRhL/44RjHst2EnDkT6GPg36rua2yI0w1VwTq22iQmeBnA0WwBHRUEfg0ARF+4Fh0Z5MYhR+0ORLBk3fBKJXiJFohc/4/P3QYuzq5pRg+v8w+8ww0v4gi9vEa268ZgYwg3DdA87E6k4jEFla4gP/O3DsAZjIA0Raw/X/lWfDeBSUCA3GJUzw6T/NthgxKSZtuWUWM3rPNLYanDTQmj8bEMDMLsXpltEdJtkscNXSVhUva3AQbrIwWvnt3TD+G5llndeFNFqjpDRBWXgiaxlukFbZBlbt8M93Hqw/rob4hdBjFhUQDPf6Axx37KzxqFINw46qfr6oPgy3KMxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(396003)(366004)(346002)(4326008)(2906002)(66946007)(66476007)(31686004)(6486002)(41300700001)(316002)(2616005)(478600001)(66556008)(8936002)(8676002)(5660300002)(26005)(31696002)(6666004)(6512007)(186003)(86362001)(82960400001)(6506007)(83380400001)(53546011)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vkk2ODlrTDhtUTgwZVo2aHBSYmowcHc0UmV2SGp3VzJ3OGVWQWU2RVRzL09V?=
 =?utf-8?B?YW9NTG1YM2k3SXF3L2JQOTgzbHowRzVGeW5qYStyRWUySk8xUklrQzE3R0Vy?=
 =?utf-8?B?M2ZvdDJNRGdVMmVDd1FGUkhLdFdkcUtsekl3Sk9OUGVkRFE3SExUQ1dlbFU4?=
 =?utf-8?B?N1ozRE0rZlJ4RjZsOGJmQitFWEQ2ZHdJejh3QmszV3lFb09sN1Rzd09sRXhs?=
 =?utf-8?B?WXZIYTJYb25hemliMVd0bkRpbjUrYy9Nb2tmTnVSNXVKcWtMTWRqdUJzanBs?=
 =?utf-8?B?ZzI0K21nTTJWOWZJbjJ4TGdzUmxqQTlXVW9MbjZ0UkFNWVo1eG5QZ09UbWVL?=
 =?utf-8?B?dVBzc0hWRmpnYTBlSERUM2R3aGFDSDhmUTE1ZXlqMjNETXNCd1VJM3NFZXE3?=
 =?utf-8?B?M3BzSkxDSmpCRVRlK1hTWnZ4bUpXNXhjY2xxNVZETk9PVU1iakxDcFN5SGYr?=
 =?utf-8?B?Z1ZleWduTGFPTHVnNWZIVFJkUGdMaDBFMUN3WXBFemxWK3VObFlkUzRyU1JI?=
 =?utf-8?B?RzEwN2psblVxL2F6V28wTFFtU29LRVliUUVHcHpuaWVvajdxdlEzbHBUM2hB?=
 =?utf-8?B?MFptc09RWlpoM3h4UE9FTEtoN0Z3ZnVqT2ZXMVFTVlAzcThLajJSbXlqaCt2?=
 =?utf-8?B?S1VzQWRNS2Y1V3VIbVROSVk4K3JlNTJrMTVJTDRPQlp6bHRoQzBVaWZoaGlt?=
 =?utf-8?B?bTBseFEwczdkK3FIUlNMQU9xbFJnSTlmMm10c2RxclZGdUEwZUZOZDJxZjdv?=
 =?utf-8?B?VE9UWWFRdnUzWVpNc2RwZCtkUEZIZ3JQMllYUUJNN3VSZnZ2RUtJRGE3Z0sy?=
 =?utf-8?B?OWJKMFZVYjhpOS9MOVlYV3VvY3QzVVU1bENTY0Z6c3hsSHE2QWFDcUpNSms2?=
 =?utf-8?B?S2dLQi9icjFPQmtrTnVINUxZRFIwcmpsdzBOTUlGMlBUQzdTdEJVWmRMQ2hu?=
 =?utf-8?B?Y0pRQUkxYVRBRG5qbVFVT01LRno4VnBMeG51aFduVnpMZUpmcGRJVGJBUFJ5?=
 =?utf-8?B?Q3lPei9JeVRBQXdmU1p6QnAzUVNOeWVBZWh6VVBaZDJyM3JTcnFjUVRodzFC?=
 =?utf-8?B?U2IzREQ2dDdnbm1GTGs2VUh4NDJLOVhqL2luMjVIVkdtZ2lLS1JXQmxUN05H?=
 =?utf-8?B?aDhVbzBVQjl1czhkVmV2UW9VOGIzd2RMaTYxUmR4Zjg0TzZGZmtHTmR0ZlNZ?=
 =?utf-8?B?cGswemtNV2pWRXpVZUw5Y0dXTWVNVTdtdWRmSTZ6a2hmSzZnclREc0htWkFv?=
 =?utf-8?B?SnIzdE9yanJTaEN4MFJ5NlFsTUVZSkpSVXdERkU0WGhsbmJIS3l3NXp2OFNq?=
 =?utf-8?B?NjZqSVI1VlVUM20rbkFHMy9UMXY1U0lZVUtFUzRScjRaMXdjQzZ4RkZlVTU1?=
 =?utf-8?B?d3o1R2RFckM0MklpMk9TaTUxcmhPdllPY1JuUHF2RldvcmJ4ZG9Wcng1WEtt?=
 =?utf-8?B?NC91QjBOWHNTRGZlbWl1ZjdCTFpQb0pLeDhaWHZxeHczRlhZYmxLT2ZkbVBH?=
 =?utf-8?B?SFpxNGY5VE9wVXZ5SkNLanZwT3Vwdlp6WndTQlNwZzd3dmxBZHhoSGs2WGpw?=
 =?utf-8?B?VkNJTzRPLzAzb2wxVmU2SXpWbnZJTTR2dEtneS9rYjR0MTFmOGQrK1dIQnNm?=
 =?utf-8?B?NXFRSkNsS1ZCNkNjR3V3OTN3SFRXRnFhWjJqS3o0YjBjOVhHZ0JyemRFQjRU?=
 =?utf-8?B?YXA0OGczN0RYcUR3enJRalBXWmJBTUdkeGl4NW55b3pDay9yQk53Q3k0S0ZZ?=
 =?utf-8?B?VmN4YnJxOUdSSHVOeDlhaVU4alFHTDlmelFwZXNPdlhIaUZUWmRxUzg5ek9j?=
 =?utf-8?B?ZXNqVG02Q2NpdkppVldQdE1XcjFjNDRNRDd6S2JsS3d4SGk4ZlNwdmxtZUhM?=
 =?utf-8?B?QlZhVWxiTWNpWHU1T0dUd2xxWEdRZFVpb3VMOUJIRUhZMUFzZzRsUHZZc0dv?=
 =?utf-8?B?cnorUXRtWkVvV0l1cW00ZHV2QkovdHpCTU5uU2d6eW5oVGVtNXd1NGNUa1Ja?=
 =?utf-8?B?bzlLNkgwK29jQ1BHczNLZ0V2eWZwMjRqbTBEV0h0elgwMnBCd0JFTnFMRG5q?=
 =?utf-8?B?MTJoYW1hd1BXVFBPVUJpalFNOU5BY1E4TldYMk9ObEFBOXN5OVQ3QlF0aXVH?=
 =?utf-8?Q?1vxE8HGCnsH2yxBn6L0KU7qYD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abe79228-29fb-4bc0-fc57-08da80b500b0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 01:00:11.8193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vySSEIgX+Nfp8uVlk9ljeIFj8haZuRtK8ZPstm6nJ5zjaPkli2eY+j6bYHIEenzCOEK2Ysa96Y/otj7UdyS7Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3820
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/17/2022 5:41 PM, Yin, Fengwei wrote:
> Hi Miaohe,
> 
> On 8/16/2022 9:05 PM, Miaohe Lin wrote:
>> }
>>  
>>  	if (h->demote_order) {
>> -		if (sysfs_create_group(hstate_kobjs[hi],
>> -					&hstate_demote_attr_group))
>> +		retval = sysfs_create_group(hstate_kobjs[hi],
>> +					    &hstate_demote_attr_group);
> What about add one more:
>    just return if hstate_attr_group creating failed:
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 0aee2f3ae15c..a67ef4b4eb3f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3845,6 +3845,7 @@ static int hugetlb_sysfs_add_hstate(struct hstate *h, struct kobject *parent,
>         if (retval) {
>                 kobject_put(hstate_kobjs[hi]);
>                 hstate_kobjs[hi] = NULL;
> +               return retval;
>         }
Please ignore this. Just saw the patch 2 made this change.

Regards
Yin, Fengwei

> 
> Once hstate_kobjs[hi] is set to NULL, hstate_demote_attr_group creating will
> fail as well. Thanks.
> 
> 
> Regards
> Yin, Fengwei
> 
>> +		if (retval) {
>>  			pr_warn("HugeTLB unable to create demote interfaces for %s\n", h->name);
>> +			sysfs_remove_group(hstate_kobjs[hi], hstate_attr_group);
>> +			kobject_put(hstate_kobjs[hi]);
>> +			hstate_kobjs[hi] = NULL;
>> +			return retval;
>> +		}
>>  	}
> 
