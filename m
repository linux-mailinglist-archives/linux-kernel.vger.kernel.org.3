Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0857FFB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 15:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiGYNYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiGYNYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:24:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D10F13CCE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658755439; x=1690291439;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IgFzLwet9HlLf2h5THfiYYHP5b7RqmbUO+Z9Mr6pSf4=;
  b=AtJ7mEvIAEEhjTLjnHMpFgbmnM5p26wsSyyg4kgC+fe3LcMkpHMswRyd
   T0ueSt+CKEImfM5htfUzLkt/KSumneb1D0/uqC9FArbr6MUBPZdqnx/Tg
   BETH0jYG6TpriA7/I2hIWo1LsEOXlx2AqFo/C+cUdy/4yAzqkcogKyB/H
   9T7F7eeM3c5+hNRppnSpj1uFBBdGhIZIDfhJylYKJK26eDtgcmPfyNb+5
   eXtVaUcqrhFXEV7SaFo9tk+PO14nMqWzd+GxAK+f2nL/IfqcZfZeXm/Dk
   OKT4W3et4WCa1GxKKM+10VVhunUnBClWvNOVQEITYatUKWhC8x5Y+0tSq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="286454909"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="286454909"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 06:23:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="775955261"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 25 Jul 2022 06:23:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 06:23:58 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 06:23:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 25 Jul 2022 06:23:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Jul 2022 06:23:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oai5eH0eeF/q755Te1sbfcovm3ysTw7q24EL5fO8/BlKbMrTQZI0mn21uWOTr4OUgtHUW8OolmrqD5V4PML4anivSssY60uhQKRI0wCOMQhCFCMxmlFN1+MeDkjELlX0aHXUcC/IxEj2AkiN+A3fst9XK0QPZTKcVjQir0Dra/TnE3JtTqyH6j1XrvfPnrnGTlraa0dIxV20NIaNL1aoxYrLS+rB2l7ygbULFRfd7VJ/uGXJgxLDxTyGclYMEDBNMy6sKDDXGwRYsIRbPq68KUQboPpOEdaEg7VmNI6OwHpB5n3m+MUuEzXtULSFfBJ9iZs7q8Ge0AXyHLYw33gnWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMGp+ypYuSfz/Mh+34TxmjhCMD84DcuYzuMavXE2C7s=;
 b=jsGHla+f775JW/Dd9jlrJKQDYr8askS7N/iVD8z8kLVDEjEuBAWGSKFquzo3+gDb6jozsM/fRgTPyqdWKqTecV6oaLlsVugLs3NXmb27OO0o21i7CzleyB9Sz6u9m0e/fOkKC3X3BzW1Gvome8U+afQIjAmpXAT9wDCBYk8J0sGTSrNsQoZZLUZS9zbBbhCWC6mkoGkCT2O/8PV6wa0nfRC6QIk64rNM5kABOkPXlFPN4RtOCS+aw6sU1Hsjhz1ypnaRHfUeMug7T5KPGhXEEArNKm4DgrGH4EUiDN2KllZcWInFUB2O3hFKovN+0OWm0U9Y6clJDrDPlD1lUqDo5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB6067.namprd11.prod.outlook.com (2603:10b6:8:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 13:23:55 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 13:23:55 +0000
Message-ID: <672e0958-e438-fc78-c036-988cae596399@intel.com>
Date:   Mon, 25 Jul 2022 21:23:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] mm/slub: enable debugging memory wasting of
 kmalloc
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Christoph Lameter" <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
References: <20220725112025.22625-1-feng.tang@intel.com>
 <f1ee3bd6-d068-b401-04ef-e14ca55529ac@huawei.com>
From:   Feng Tang <feng.tang@intel.com>
In-Reply-To: <f1ee3bd6-d068-b401-04ef-e14ca55529ac@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5637f274-3e88-4b50-7045-08da6e40eca5
X-MS-TrafficTypeDiagnostic: DM4PR11MB6067:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zdz/FvKxDQEAR5hQC/lWuOqqK9E4twO4YX/carwwlLs59eHGeW+05cP/rWXpf2bBTP9Y6Aab6nbaZqG4TfDxH539n66RGjwMRQGj0e0NYnpJjath+TjJdMNPw3oUcBOFYJcCTbHAx4IAsC6dNXs9q0VwyDXU+eNnBjB08jc5JpTCqSn5sfOJn1wcxRWZuwO+JOdCLruiqe7MjkgHfWF9qHYbwfFvM30MWZAetrXeV/wkt9wwHgstGxGGUcPuNpP74WuhBbLDUsT2aGyXr2iaYLkMf2V9I2aoAZYkK90fX3ZuPz3PyiBZHf4gMQCUuOnNSnJp02+KkqThab5Zu+X+O1jHZaM2EFmYINOjcXfcMaTmoCKcvnuyiCFb2fXAH2A9RBzUBj0pCgdiu7QW51WNrze1IABPbvqLeV9A5g0Soppal3IyL9U6G3B+uHgy+vQBBd8JS1Goob0JbwMwAdbAIRQ/lbsUJx2J9gMrDNe0PaByStERdNH+2vhhXDF57vcJPRbKX2UKDMQZ+7biGYoIl/X5lhYU75SrjRCB9mJQW6I0nOinZjjY7RPZpLWKQe3o9H/NYNsQajqtBWFs93IeFHVSxdEuqwhof02KSx5XYT4ZqDtTg0Gnd8z/yUbsNKAYaEzYkZIzh4MZ1CNSi/TACmKapWP59a6MfcUGVBMSnzFBhx/wlx95onVGab2/WivZTai8zaU6yoiJxrNyPs+zq2qqvY1loNfHuzroYPGxHA1Wv5zbFrdHm/pPGqlNR5HLIEO5FzKtb4EsWh7V3BDkSqEG0lTzH9tDM9hazjLR4Jjd/GTkjJeKOQ1M6u8HiWtmRWrR//vjgR86EKpSOpx7czEYECmvTPsVtZrR4YU1OKM4ILXlrk8sbr9nG0nI1/iXTrddi0WKj9xdM4bnJrRrBdSwPuBBBVf0BIUDOH28qY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(39860400002)(376002)(346002)(966005)(82960400001)(921005)(86362001)(31696002)(38100700002)(6486002)(5660300002)(7416002)(316002)(478600001)(8936002)(4326008)(8676002)(66946007)(54906003)(186003)(66556008)(110136005)(2616005)(66476007)(31686004)(36756003)(6666004)(2906002)(6506007)(41300700001)(44832011)(6512007)(26005)(83380400001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHFkUU1SMjF3d1hxMllYcVdEcXkzR3pqKy9SOXdSelRVcDV1eGxzYXlWOFRz?=
 =?utf-8?B?VElhVG5ITG05ZENLTVZjdE5CYTY3UzRPZXJhMVpIcVdpQjFhRk84ZUxBRGVR?=
 =?utf-8?B?RGxOUTRPaW1BbzdPOVRvc2puZjFCWWF0cFVDWFRuei8xSURWYnAzbWtXeFVk?=
 =?utf-8?B?bVhKeU41YjFhbnE0akkwZ2Q5VnRGdWRvYWtsRkE0WGU1SWE1YzExZXIycnRJ?=
 =?utf-8?B?UXBvOTRKOW1vSC9ZeHFmRUoveVZQTUdaK1pZbnVHTVNYU1kyTTFWc3l2Y1d0?=
 =?utf-8?B?RWNjckZVeCsyV2Z1djVoV24wTHYvbUl5VG00dEV4eU0wOTIwRk0zZW9reFJI?=
 =?utf-8?B?MkhLOEVZWHFnalNFcllQQmlLS1NOVE9DbFRqQkZtc29uVDlmVUNMZU9TS2FU?=
 =?utf-8?B?NXNoQW5WU2ZtbDh1T1J3WlJhSHkySDh4VUdPb0NwNUIrcUtwRFk5NVFEKzVi?=
 =?utf-8?B?K2pvRzNoMkFSS3pZeXdheVFJYy9GSktmN3JzekNRUE9aMFJ3cWJOWmxidjY1?=
 =?utf-8?B?RFA3eURNM20rTXhXTUpDU3R0RkFHNFRXbGZjMUFDek9QcUZ0Q0gvMDlaODFa?=
 =?utf-8?B?R3BVYWsvYVlFMUV1NERzVC94VkxYYmtWVkxCaW9IckFldnovNXZST1Z4MEZD?=
 =?utf-8?B?R3dNQWQvTzBuaTJqV2I1cm9rdDU3VEd1ZkxNUDFkUXJuamlqSU1iNEFrZ1pS?=
 =?utf-8?B?allYdGo2bE52VXYzb205aEZ6SzA1T1hnSFdHRlY3K3dHRnI0bHpRZDBvRXYz?=
 =?utf-8?B?dmhqZXl3bjNyd21xTFp1azh2NzExQkhjY3RUYmgyeU1RczROeWVVbC8xbUx5?=
 =?utf-8?B?Y1NHNnBqYjJSVXFUTE9UdmVjcXBvS3VySCtCZkdkZmZJSHB2bjZ0T3E0aDlE?=
 =?utf-8?B?RlFhcWJudWlFTkVmVi9mY1dzL2xhZkxYMWc1VDU0R1ZyNmZUa0FoN1YzbWxp?=
 =?utf-8?B?a2FsOHpoL0NxWUhHbWtkMURHNEdFcm03bmpFdFBPc2YwM0wxK0dKK1Z3YjhN?=
 =?utf-8?B?dU40V012OVRqQXM4VkVkY3JjRmNxeG9XdC9WMHVDNkpDanFjRzRVNzhzaXVY?=
 =?utf-8?B?b1l2VnJmQ2JTTnh1UC9JZXlCQVVGQU9FS0NBd0NqQVd2dEdNMitiY0dwS1M4?=
 =?utf-8?B?amVWanJsS1QwQ0NRK0NVeVowQnJuYlpqY0tPRkFzTjA2Y1Y0VHQyQzlEaGds?=
 =?utf-8?B?MWhraGcxMGo1Zm1XblNhK0dvZDFuTzE1amxWUk9MZE9ablhaZE5xSUZlSDJw?=
 =?utf-8?B?QU96Tk9QMFBYdnBxY1BweTZaTWc4TjZpY3BhN0k1NjZCUDAveXBUdEVXRkwy?=
 =?utf-8?B?amZHaU9qSTM2ZHppc2xScnVFWTRQRmxKaDcwbzVkVTBwVDZWbEh4UXVqMDNX?=
 =?utf-8?B?MU5mR1lFL1ZjdWlmZ0xhcDkwSHptb0FpNDF6RUNCSStFRUVOUVJQN3ZpTXNI?=
 =?utf-8?B?UHJjMkJGa2E4cERTMlpraExKMDUvOWVZUWcwSUwvN1B1bWszakpMNUtrZys4?=
 =?utf-8?B?N1FLa3AvT2tobDZSaHFha0VINXk0YU5OcGo1eVVVWkhuK21ISmNLV1cxUHhR?=
 =?utf-8?B?NkY3bDlzeGpmWnhweDd4c3dGM3BOK1l0QXpNUnZ5QklLQkZKMEY1RjJaNGli?=
 =?utf-8?B?VU5uTWdLbmNxMENneUtMbGM2RElzWTloMlNoYTVQYjhVdjFrQkEvK05ya2ZM?=
 =?utf-8?B?WWJTeDdUb05OSVpiWVZSWjVDVGw3OEJQRXdpa0YrVWo2RkpLM1JrdGpmWENR?=
 =?utf-8?B?dm0wWGRDN3N4QUgrNnBOTkFYVlhHTW9IUmpqTks0aWhLNnFodHpZV3l3TGJ4?=
 =?utf-8?B?QVpJN3V6bCtwWUVmU2ZZZE1tdWQvNjZwdVIwQmIrZDdvWFJhZ0Zhb2t5M2xZ?=
 =?utf-8?B?MWkwNnRnYjFtZE9VdlNxMzdid0FLTVk1N3pvMnVFdWlkS0hwWEZ1Y2R4c3gr?=
 =?utf-8?B?RVhPM0NNM3hZOEs2TmRibkxwVXRMaXJvcHYvTk5mOW5Fc2Z3L21NdGpMc0RK?=
 =?utf-8?B?bmFONDRJTDJkZlo5ZHVsNnlXRmlzNTFKdmp1N0NZNEZSMHdPd3RBVDJUVDdK?=
 =?utf-8?B?ZisrZ2NZUDdveHJkeUUxMkI2YmdvZUM2bHRnT2hKN040VGFlUlE0RlV2Rits?=
 =?utf-8?Q?HiwC82dO/fF+0aQeom6biOs4O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5637f274-3e88-4b50-7045-08da6e40eca5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 13:23:55.7468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxH6zzr0piAhkRcFSOXUwUbyWcaHDNy3eh2jGbO/SRW4bE0FaGnE0j9teI+3CC+lhawB2v3AmOfyS6mAwuWHXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6067
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

Thanks for the review.

On 2022/7/25 20:19, Kefeng Wang wrote:
> 
> On 2022/7/25 19:20, Feng Tang wrote:
>> kmalloc's API family is critical for mm, with one shortcoming that
>> its object size is fixed to be power of 2. When user requests memory
>> for '2^n + 1' bytes, actually 2^(n+1) bytes will be allocated, so
>> in worst case, there is around 50% memory space waste.
>>
>> We've met a kernel boot OOM panic (v5.10), and from the dumped slab info:
>>
>>       [   26.062145] kmalloc-2k            814056KB     814056KB
>>
>> >From debug we found there are huge number of 'struct iova_magazine',
>> whose size is 1032 bytes (1024 + 8), so each allocation will waste
>> 1016 bytes. Though the issue was solved by giving the right (bigger)
>> size of RAM, it is still nice to optimize the size (either use a
>> kmalloc friendly size or create a dedicated slab for it).
>>
>> And from lkml archive, there was another crash kernel OOM case [1]
>> back in 2019, which seems to be related with the similar slab waste
>> situation, as the log is similar:
>>
>>       [    4.332648] iommu: Adding device 0000:20:02.0 to group 16
>>       [    4.338946] swapper/0 invoked oom-killer: gfp_mask=0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null), order=0, oom_score_adj=0
>>       ...
>>       [    4.857565] kmalloc-2048           59164KB      59164KB
>>
>> The crash kernel only has 256M memory, and 59M is pretty big here.
>> (Note: the related code has been changed and optimised in recent
>> kernel [2], these logs are picked just to demo the problem)
>>
>> So add an way to track each kmalloc's memory waste info, and leverage
>> the existing SLUB debug framework to show its call stack info, so
>> that user can evaluate the waste situation, identify some hot spots
>> and optimize accordingly, for a better utilization of memory.
>>
>> The waste info is integrated into existing interface:
>> /sys/kernel/debug/slab/kmalloc-xx/alloc_traces, one example of
>> 'kmalloc-4k' after boot is:
>>
>> 126 ixgbe_alloc_q_vector+0xa5/0x4a0 [ixgbe] waste=233856/1856 age=1493302/1493830/1494358 pid=1284 cpus=32 nodes=1
>>           __slab_alloc.isra.86+0x52/0x80
>>           __kmalloc_node+0x143/0x350
>>           ixgbe_alloc_q_vector+0xa5/0x4a0 [ixgbe]
>>           ixgbe_init_interrupt_scheme+0x1a6/0x730 [ixgbe]
>>           ixgbe_probe+0xc8e/0x10d0 [ixgbe]
>>           local_pci_probe+0x42/0x80
>>           work_for_cpu_fn+0x13/0x20
>>           process_one_work+0x1c5/0x390
>>
>> which means in 'kmalloc-4k' slab, there are 126 requests of
>> 2240 bytes which got a 4KB space (wasting 1856 bytes each
>> and 233856 bytes in total). And when system starts some real
>> workload like multiple docker instances, there are more
>> severe waste.
>>
>> [1]. https://lkml.org/lkml/2019/8/12/266
>> [2]. https://lore.kernel.org/lkml/2920df89-9975-5785-f79b-257d3052dfaf@huawei.com/
>>
>> [Thanks Hyeonggon for pointing out several bugs about sorting/format]
>> [Thanks Vlastimil for suggesting way to reduce memory usage of
>>    orig_size and keep it only for kmalloc objects]
>>
>> Signed-off-by: Feng Tang <feng.tang@intel.com>
>> ---
>>     since v1:
>>       * limit the 'orig_size' to kmalloc objects only, and save
>>         it after track in metadata (Vlastimil Babka)
>>       * fix a offset calculation problem in print_trailer
>>
>>     since RFC:
>>       * fix problems in kmem_cache_alloc_bulk() and records sorting,
>>         improve the print format (Hyeonggon Yoo)
>>       * fix a compiling issue found by 0Day bot
>>       * update the commit log based info from iova developers
>>
>>
>>
>>    include/linux/slab.h |  2 +
>>    mm/slub.c            | 96 ++++++++++++++++++++++++++++++++++++--------
>>    2 files changed, 82 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> index 0fefdf528e0d..a713b0e5bbcd 100644
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -29,6 +29,8 @@
>>    #define SLAB_RED_ZONE		((slab_flags_t __force)0x00000400U)
>>    /* DEBUG: Poison objects */
>>    #define SLAB_POISON		((slab_flags_t __force)0x00000800U)
>> +/* Indicate a kmalloc slab */
>> +#define SLAB_KMALLOC		((slab_flags_t __force)0x00001000U)
>>    /* Align objs on cache lines */
>>    #define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)
>>    /* Use GFP_DMA memory */
>> diff --git a/mm/slub.c b/mm/slub.c
>> index b1281b8654bd..9763a38bc4f0 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -191,6 +191,12 @@ static inline bool kmem_cache_debug(struct kmem_cache *s)
>>    	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
>>    }
>>    
>> +static inline bool slub_debug_orig_size(struct kmem_cache *s)
>> +{
>> +	return (s->flags & SLAB_KMALLOC &&
>> +			kmem_cache_debug_flags(s, SLAB_STORE_USER));
> Swap two judgments to reduce the SLAB_KMALLOC check if no SLAB_STORE_USER.
> 

Ok, will change.

>> +}
>> +
>>    void *fixup_red_left(struct kmem_cache *s, void *p)
>>    {
>>    	if (kmem_cache_debug_flags(s, SLAB_RED_ZONE))
>> @@ -814,6 +820,36 @@ static void print_slab_info(const struct slab *slab)
>>    	pr_err("Slab 0x%p objects=%u used=%u fp=0x%p flags=%pGp\n",
>>    	       slab, slab->objects, slab->inuse, slab->freelist,
>>    	       folio_flags(folio, 0));
>> +
>> +}
>> +static inline void set_orig_size(struct kmem_cache *s,
>> +					void *object, unsigned int orig_size)
>> +{
>> +	void *p = kasan_reset_tag(object);
>> +
>> +	if (!slub_debug_orig_size(s))
>> +		return;
>> +
>> +	p = object + get_info_end(s);
> Look like p += get_info_end(s);  ?
>> +
>> +	if (s->flags & SLAB_STORE_USER)
>> +		p += sizeof(struct track) * 2;
>> +
>> +	*(unsigned int *)p = orig_size;
>> +}
>> +
>> +static unsigned int get_orig_size(struct kmem_cache *s, void *object)
>> +{
>> +	void *p = kasan_reset_tag(object);
>> +
>> +	if (!slub_debug_orig_size(s))
>> +		return s->object_size;
>> +
>> +	p = object + get_info_end(s);
> ditto...

Good catch! will change both of them, thanks!

Thanks,
Feng

>> +	if (s->flags & SLAB_STORE_USER)
>> +		p += sizeof(struct track) * 2;
>> +
>> +	return *(unsigned int *)p;
>>    }

[...]
