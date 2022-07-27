Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CA6582737
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiG0M7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiG0M7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:59:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA843E75A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658926756; x=1690462756;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=ywWvecl1F74xrTJ9/DG5CEaQQTwZKlCHwjf2vRtFJjM=;
  b=iHd2hhZE28FFGT293CC+ZRcERqPs5afArK3DyR++Ng7ThyMhrGDuhE5X
   oZVY9wn1uUeaH+bAnAyoXn+Pdi/+kqjVTiOnKNkA+5BB+RygskP1SZypE
   bWrixL59pltkHewFuB/dKVR8+hu39TwnUzqE/M2AhgTIh1/OdqfUOTRi4
   SFkL53WtvgqmIitZZVuVSfkSkNRJV1nQEPb5lHOEE3n4YbSVddrwlucbW
   WnweKpHi0FgYLE5tLDdMB7lKI8CW6f0UDrIaaQhiLGFKoidNEZ3Mj4IDu
   jP0ovbZTR4WDjBAT60IWI/cWOSNRK3WjCIf5K8TQdfrmJZQOLPHpbYni2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="268608569"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="268608569"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 05:59:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="659187222"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jul 2022 05:59:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 05:59:16 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 05:59:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 05:59:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 27 Jul 2022 05:59:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boJ1JU2IkccRgmaPIkIkN70vvXrCz66YzJFcY/Pa5F+GltQyaACDicF3Ja1enLnk6cCMohVgKQPCqHCTxCFxLtW5deAeYX6LFlruqClW01ChiMj+ZP4Uq3p666YMQ2VXnfhWUkHXRjPipgsIzg4OOf5oOvGA4syudrcOfrLbsu7O4oE7s8Li242zwwlUyufSOmSPTI7bCQJr1z/0oc5QAAjDQr9pm6HpmgGMIWEBf6qRk1eamHh4DPp8QX07Z7YeHJLhegAFo1hnh4jcJXkLmFQlgSh4adMlz9N7nQwgVecHMrLvLAcRU5ZyUFhEq3tgF39wXdVyBlRO0qYttyGm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsVL2lZAq7rIqFEKe5cAeMAIzJd5K6F74d8u3PSx15k=;
 b=HWrHMSYS7Z5733JUPWVopEFcRRC2W46cT+w8FuVZuerD/mfl7/PhVgZPPWsEfZoJFkm2dyEB401otfyU7PoLtqupTPDBLeYdxHw2tC+38zB8m/sxl++NzRw2JsJ4+r48BD5xaBN9N3kk8TM24BW8cWS4MTmk6+e6k+727SbYwU+7XkvJezcEkTnMfU3ZhwX7Af3pIREbpZTNMdFTsbpHA0rKk6ZGVnUx4kBbCOZucaIbUQVMbx1NUTep9ZRH6/DaG96dmgNJuvuvno791YTziADRdL+VoWrjqR/fjiDz48PrpV8AdyiqIzawaqDTNmfpAEqH9oW+AFiZya4432HFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BL0PR11MB3267.namprd11.prod.outlook.com (2603:10b6:208:6b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 27 Jul
 2022 12:59:13 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 12:59:13 +0000
Content-Type: multipart/mixed;
        boundary="------------WkB5RYIvIXZXBL69q70WuwOG"
Message-ID: <442d2b9c-9f07-8954-b90e-b4a9f8b64303@intel.com>
Date:   Wed, 27 Jul 2022 20:59:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/3] mm/slub: enable debugging memory wasting of
 kmalloc
Content-Language: en-US
To:     Christoph Lameter <cl@gentwo.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20220727071042.8796-1-feng.tang@intel.com>
 <20220727071042.8796-2-feng.tang@intel.com>
 <alpine.DEB.2.22.394.2207271214570.1205438@gentwo.de>
From:   Feng Tang <feng.tang@intel.com>
In-Reply-To: <alpine.DEB.2.22.394.2207271214570.1205438@gentwo.de>
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2fbfeff-e9c8-4fb4-e4ba-08da6fcfcdcb
X-MS-TrafficTypeDiagnostic: BL0PR11MB3267:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DXMBEzN7h7qqTutaG0UyN9pYYMA3AkbxqqcIASV0gjLQprn9Sf+0o+sHzPj6u1y2WDwX7iumZ4rU9cBKNtk+2ZdxYCHkL2GHs+yEaTO+Bm2drxkRJL+ZI/qj5c8cLHhz1SmtT/Gr5RjeGXe3SNLEAG0sjgUeVYFGO/Ip+IPy5tSCXI+SyIWi2Yu4BVpFfI3A1edDm1QewT3jWzuiqvn/hW2F7ZCaFKzdhTBVvf3ZYUju6aKEKB2hImjmbdnFRH5v3oNq8K8x8tkvqwstGxHZgOQX5TjiLgIh4T9X232rfI4jOz3jUPk0raGb0Gj5yZheYC/Yfu2lz5R87KwpYMwAYLt2vYEjDUfkj34je18kK6dpl0WdOAa6BNb/EmmR6qPSrfOt/dkNfZYgsiVqp3dROLsdvL4Y/vtHwmhF73e1sJKvvMxCSFtMR030wgVkE5ctrGKI1CwDHb63BGDuLAFK17MOYZdJAiwjcNQ6x1pnHk2RkHAoGewV3AK3VRmSbUrxMmnYwv9x3AQU+EBgtWsQaCBxz1PK8pLJkkrpoGuppoiHQZDH2+MMHrtBQ88VcCyLYPS92qLwTZaNMnfciZ7shVAC8gNIMmInsfwTqIhbYQeoEwiOwoyYMwfqf9c2zVanH0RnWiN2iV6ZWnQIb5KuAs4V7dALd+pth1j77g0wtmOEE5PVTMuJxnfuQCKcwUuXsZdjXLwl/j4o4glSVBRRJELQgo3aajmnhqlScRbmuHXb93Jj0UxPxH7CjMhsYZZDGnz5S75EpopOs2AzUT+PIm+5ENqowEXv6AOp4uc6vbSyfY/VUjj/Jqlmqty3aAh7mzYRKAWaVtXXYoMm1Qv5fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(39860400002)(376002)(346002)(26005)(83380400001)(6666004)(41300700001)(31686004)(6506007)(6486002)(6512007)(478600001)(53546011)(186003)(33964004)(36756003)(8936002)(5660300002)(235185007)(82960400001)(66946007)(316002)(2906002)(7416002)(8676002)(66556008)(86362001)(2616005)(44832011)(4326008)(66476007)(31696002)(54906003)(6916009)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1FBSmpMeDZBa1lwSTNLNGlDSVAybVpaeXBsOW1tRkd2QzlqUVI2amlWcTc2?=
 =?utf-8?B?YS9SMFFQUUNRMFd6elNqNnlCSVNNNmxpWDZzT0M5L0VOelQ0SVVLbDNIbVBz?=
 =?utf-8?B?VWxTcndFVUZaWUpsTFhSdnJ2aEhVcjN5UEtKcFQ0NEszMHhjYjdic2YxQU5w?=
 =?utf-8?B?c3Z0NUlRUk9sanJhUmt1eTY5TTcvRlpkYmE3a1kvZG0zZzVCOElEYUNCbVdC?=
 =?utf-8?B?WjJaNmRMbFdnSXExSXlteGg4bitvRFlpUkhVTnp5M2ZVTGNLdC9kZVZxMTFa?=
 =?utf-8?B?T2N3THYyOFM1QVQwWHpaV2NNNlRYVXZ1Q2lWR2ZjNFhmTW5TSmJlMm5qV1Jp?=
 =?utf-8?B?OEIwcFRzblQwNGxYWnlHM0hkVVhyblJUSzdCSVE3REZqaUpDcjRLTVNnejV6?=
 =?utf-8?B?VUtWZE1OYzRYaXpBWXBibmo5ellYYTV2c3VXWjBpc0ZLaWEyYnhuQ2pnVVRl?=
 =?utf-8?B?UlNEaFZYaUtMcWUvTHR1d0xhcGlKbTR5Z1NNaDdjWUp2ZXVLZU4xQmIrNVVL?=
 =?utf-8?B?MnZudm9CS1llQ0dlNmlCOFpBU21SRmRTcC9TVStKcTdiaWpmTnJ1ZzhzcC9r?=
 =?utf-8?B?eXJ2ckh5M3U1ZDNKNlpINVRrdkYwMjFvSmlaa25DYndNVzJsQnVKeHpKUFVh?=
 =?utf-8?B?OVV5TzFMM1lTb2VqbkpSbEU4THl0bmNycDRobmxQT3dldVdmelZ5YjVXN2h3?=
 =?utf-8?B?VHA3QVhCbmxJQlE5eVBRdjcybFEwZzkrZWZjeGMvK3NkcS9GN0syMitnTVJW?=
 =?utf-8?B?cGphc1d3Yzh2UEIwVzE5djZPRmsvdHNNYmthd1lEY1l6RjZnMUR0R2RBQ0Jo?=
 =?utf-8?B?REh2SXJhaUlhSlNzUm8wcG54YzgyR3E3NkttSUNWMVl0aGxQcFE4cTZ4Qlkz?=
 =?utf-8?B?RFZTbG5wOEJRd0tCWHVUS1lrNWJsWDNZSkgxay8wOXI2bnRzcE5hWTh4bEtB?=
 =?utf-8?B?RnYyUmtnZEhwSzBwWTN3NHJEZGgyQko5OUlLZTJJdHhjQ0NSdGJoaHZ2YjA4?=
 =?utf-8?B?a3lyZDN6QWduS2loZkpuVXdYWGRiUXhBL3BQbE9HV0RtUVFFanpmR08vbFNJ?=
 =?utf-8?B?ZlUvWEZocVBOcHJ6dUtyL2ppRWdGME4xa1pmTU1hMzJITm1TWDRrRVhHUklw?=
 =?utf-8?B?NTk1SzUxcjlIbHBNZ2l4bGVZY2dpYXZISE1ydUk5VDFUTU8xWC9neWUrRHhk?=
 =?utf-8?B?U1BTeUNLeXZ3bVZTekZrTGxrQjlrZlA5TVU1VE5sLzd0SkZIN04rMU04NkFV?=
 =?utf-8?B?MjFmandSTFp1bEl6MUd2NEVuUjZOM3N5MEllR2dsSVBKVDdRTGdONWFPczds?=
 =?utf-8?B?alFDbzg2NzNEMDA1VTB2NVhZUXVwRVZMUHJsaXRCVzVHdVVZd2VHNkdsT01S?=
 =?utf-8?B?R3BWRGd3c0FSWFl3TUcwTGFnUVliOVpxZ0xydC9reGtOK3gwMjFISVdJZWMv?=
 =?utf-8?B?RlNqY3BYb1BXMWZ2WmpTTWlqOHRwR08rSVAvMlFOK2hPajI0ZUV0QnU1Vmx1?=
 =?utf-8?B?ODJFL0NWeDh2V3ZCZmJ1bjFiekxZUmdzV3kzNCtzSkNBQXZGOUlqMThXbTBV?=
 =?utf-8?B?R3AwUTBpT1RUUTE2Mkg5QVNMMmphUmgyUUlyZ0RMT3RraXU5T2Q0bGhrSDln?=
 =?utf-8?B?d2o5TnRydGN2WHhuTVV6Qm85NmJOWTJ3LzN2WEVkajEwMDJjL0wwc21vUGdX?=
 =?utf-8?B?UzRLT0F5WTNkZDBFQ00zK0lOU3p0a3l5alJVbnMwWkxNVkFOYmc5NWVvc2Zq?=
 =?utf-8?B?TUt6cHBVZWJVL0ludlkxQkh5UG00N0ZNYjBlckVtdE5TbHFOSjVlTmxWQ1M2?=
 =?utf-8?B?OVExQXJCRUp5NllSWTVpN3h2cGdaQWphcUZOT1JNWnBXNXhxOVVqR2gvcmdY?=
 =?utf-8?B?TWlPWkVFUEZBMHEyRVU4OGxKeDlnekRGcWZWSjNzdGR5L1k5WFVPU0xOQXEr?=
 =?utf-8?B?V0VwK0JXd0JKRTBERExESFkrV3h6V0lEZTdXU2pROGQyaU9VWW1wT0hINnNy?=
 =?utf-8?B?dUkvUzFrMDhsMUFWd1N2TFJkanFxZ0s3U2dyL090WHIrd3RZVUFuVlF0YmhK?=
 =?utf-8?B?VGNzYUFRL3prcEpWU2ttNEJHUEdBMmY5ZGVoVWtmVTJLY2l1cFVLbjFucEkz?=
 =?utf-8?Q?/7YgNc0YZePTWkWVQnS+LL5RP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fbfeff-e9c8-4fb4-e4ba-08da6fcfcdcb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 12:59:12.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2YJsykdQpdGfjsyoNV+knVM3WK/7UjQy45pC0Z+P+EMSt2ZwyBnYkaWUVI0XbSRujup6hecm1VgQ+A8DTtEmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3267
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

--------------WkB5RYIvIXZXBL69q70WuwOG
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 2022/7/27 18:20, Christoph Lameter wrote:
> On Wed, 27 Jul 2022, Feng Tang wrote:
> 
>> @@ -2905,7 +2950,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
>>    * already disabled (which is the case for bulk allocation).
>>    */
>>   static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>> -			  unsigned long addr, struct kmem_cache_cpu *c)
>> +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
>>   {
>>   	void *freelist;
>>   	struct slab *slab;
>> @@ -3102,7 +3147,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>    * pointer.
>>    */
>>   static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>> -			  unsigned long addr, struct kmem_cache_cpu *c)
>> +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
>>   {
>>   	void *p;
>>
>> @@ -3115,7 +3160,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>   	c = slub_get_cpu_ptr(s->cpu_slab);
>>   #endif
>>
>> -	p = ___slab_alloc(s, gfpflags, node, addr, c);
>> +	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
>>   #ifdef CONFIG_PREEMPT_COUNT
>>   	slub_put_cpu_ptr(s->cpu_slab);
> 
> This is modifying and making execution of standard slab functions more
> expensive. Could you restrict modifications to the kmalloc subsystem?
> 
> kmem_cache_alloc() and friends are not doing any rounding up to power of
> two  sizes.
> 
> What is happening here is that you pass kmalloc object size info through
> the kmem_cache_alloc functions so that the regular allocation functions
> debug functionality can then save the kmalloc specific object request
> size. This is active even when no debugging options are enabled.

Yes, it indeed is some extra cost which I don't like either.

> 
> Can you avoid that? Have kmalloc do the object allocation without passing
> through the kmalloc request size and then add the original size info
> to the debug field later after execution continues in the kmalloc functions?


How about the following patch which adds no new 'orig_size' to core 
functions (the following 2nd, 3rd redzone debug patch may also need
some changes).

(Our email server has just been changed, and my mutt can't
work correctly, so the format could be broken, and I attached the
new patch as well. Sorry for the inconvenience!)

Thanks,
Feng

---
diff --git a/include/linux/slab.h b/include/linux/slab.h

index 0fefdf528e0d..a713b0e5bbcd 100644

--- a/include/linux/slab.h

+++ b/include/linux/slab.h

@@ -29,6 +29,8 @@

  #define SLAB_RED_ZONE		((slab_flags_t __force)0x00000400U)

  /* DEBUG: Poison objects */

  #define SLAB_POISON		((slab_flags_t __force)0x00000800U)

+/* Indicate a kmalloc slab */

+#define SLAB_KMALLOC		((slab_flags_t __force)0x00001000U)

  /* Align objs on cache lines */

  #define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)

  /* Use GFP_DMA memory */

diff --git a/mm/slub.c b/mm/slub.c

index 862dbd9af4f5..97c21a37a6a1 100644

--- a/mm/slub.c

+++ b/mm/slub.c

@@ -191,6 +191,12 @@ static inline bool kmem_cache_debug(struct 
kmem_cache *s)

  	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);

  }



+static inline bool slub_debug_orig_size(struct kmem_cache *s)

+{

+	return (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&

+			(s->flags & SLAB_KMALLOC));

+}

+

  void *fixup_red_left(struct kmem_cache *s, void *p)

  {

  	if (kmem_cache_debug_flags(s, SLAB_RED_ZONE))

@@ -816,6 +822,39 @@ static void print_slab_info(const struct slab *slab)

  	       folio_flags(folio, 0));

  }



+static inline unsigned int *get_orig_size_pointer(struct kmem_cache *s,

+						void *object)

+{

+	void *p = kasan_reset_tag(object);

+

+	p += get_info_end(s);

+	p += sizeof(struct track) * 2;

+	return (unsigned int *)p;

+}

+

+static void set_orig_size(struct kmem_cache *s,

+					void *object, unsigned int orig_size)

+{

+	unsigned int *p;

+

+	if (!slub_debug_orig_size(s))

+		return;

+

+	p = get_orig_size_pointer(s, object);

+	*p = orig_size;

+}

+

+static unsigned int get_orig_size(struct kmem_cache *s, void *object)

+{

+	unsigned int *p;

+

+	if (!slub_debug_orig_size(s))

+		return s->object_size;

+

+	p = get_orig_size_pointer(s, object);

+	return *p;

+}

+

  static void slab_bug(struct kmem_cache *s, char *fmt, ...)

  {

  	struct va_format vaf;

@@ -875,6 +914,9 @@ static void print_trailer(struct kmem_cache *s, 
struct slab *slab, u8 *p)

  	if (s->flags & SLAB_STORE_USER)

  		off += 2 * sizeof(struct track);



+	if (slub_debug_orig_size(s))

+		off += sizeof(unsigned int);

+

  	off += kasan_metadata_size(s);



  	if (off != size_from_object(s))

@@ -1026,10 +1068,14 @@ static int check_pad_bytes(struct kmem_cache *s, 
struct slab *slab, u8 *p)

  {

  	unsigned long off = get_info_end(s);	/* The end of info */



-	if (s->flags & SLAB_STORE_USER)

+	if (s->flags & SLAB_STORE_USER) {

  		/* We also have user information there */

  		off += 2 * sizeof(struct track);



+		if (s->flags & SLAB_KMALLOC)

+			off += sizeof(unsigned int);

+	}

+

  	off += kasan_metadata_size(s);



  	if (size_from_object(s) == off)

@@ -1335,6 +1381,7 @@ static noinline int alloc_debug_processing(struct 
kmem_cache *s,

  	/* Success perform special debug activities for allocs */

  	if (s->flags & SLAB_STORE_USER)

  		set_track(s, object, TRACK_ALLOC, addr);

+

  	trace(s, slab, object, 1);

  	init_object(s, object, SLUB_RED_ACTIVE);

  	return 1;

@@ -3240,6 +3287,9 @@ static __always_inline void 
*slab_alloc_node(struct kmem_cache *s, struct list_l

  	init = slab_want_init_on_alloc(gfpflags, s);



  out:

+#ifdef CONFIG_SLUB_DEBUG

+	set_orig_size(s, object, orig_size);

+#endif

  	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init);



  	return object;

@@ -4112,12 +4162,17 @@ static int calculate_sizes(struct kmem_cache *s)

  	}



  #ifdef CONFIG_SLUB_DEBUG

-	if (flags & SLAB_STORE_USER)

+	if (flags & SLAB_STORE_USER) {

  		/*

  		 * Need to store information about allocs and frees after

  		 * the object.

  		 */

  		size += 2 * sizeof(struct track);

+

+		/* Save the original kmalloc request size */

+		if (flags & SLAB_KMALLOC)

+			size += sizeof(unsigned int);

+	}

  #endif



  	kasan_cache_create(s, &size, &s->flags);

@@ -4842,7 +4897,7 @@ void __init kmem_cache_init(void)



  	/* Now we can use the kmem_cache to allocate kmalloc slabs */

  	setup_kmalloc_cache_index_table();

-	create_kmalloc_caches(0);

+	create_kmalloc_caches(SLAB_KMALLOC);



  	/* Setup random freelists for each cache */

  	init_freelist_randomization();

@@ -5068,6 +5123,7 @@ struct location {

  	depot_stack_handle_t handle;

  	unsigned long count;

  	unsigned long addr;

+	unsigned long waste;

  	long long sum_time;

  	long min_time;

  	long max_time;

@@ -5114,13 +5170,15 @@ static int alloc_loc_track(struct loc_track *t, 
unsigned long max, gfp_t flags)

  }



  static int add_location(struct loc_track *t, struct kmem_cache *s,

-				const struct track *track)

+				const struct track *track,

+				unsigned int orig_size)

  {

  	long start, end, pos;

  	struct location *l;

-	unsigned long caddr, chandle;

+	unsigned long caddr, chandle, cwaste;

  	unsigned long age = jiffies - track->when;

  	depot_stack_handle_t handle = 0;

+	unsigned int waste = s->object_size - orig_size;



  #ifdef CONFIG_STACKDEPOT

  	handle = READ_ONCE(track->handle);

@@ -5138,11 +5196,13 @@ static int add_location(struct loc_track *t, 
struct kmem_cache *s,

  		if (pos == end)

  			break;



-		caddr = t->loc[pos].addr;

-		chandle = t->loc[pos].handle;

-		if ((track->addr == caddr) && (handle == chandle)) {

+		l = &t->loc[pos];

+		caddr = l->addr;

+		chandle = l->handle;

+		cwaste = l->waste;

+		if ((track->addr == caddr) && (handle == chandle) &&

+			(waste == cwaste)) {



-			l = &t->loc[pos];

  			l->count++;

  			if (track->when) {

  				l->sum_time += age;

@@ -5167,6 +5227,9 @@ static int add_location(struct loc_track *t, 
struct kmem_cache *s,

  			end = pos;

  		else if (track->addr == caddr && handle < chandle)

  			end = pos;

+		else if (track->addr == caddr && handle == chandle &&

+				waste < cwaste)

+			end = pos;

  		else

  			start = pos;

  	}

@@ -5190,6 +5253,7 @@ static int add_location(struct loc_track *t, 
struct kmem_cache *s,

  	l->min_pid = track->pid;

  	l->max_pid = track->pid;

  	l->handle = handle;

+	l->waste = waste;

  	cpumask_clear(to_cpumask(l->cpus));

  	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));

  	nodes_clear(l->nodes);

@@ -5208,7 +5272,7 @@ static void process_slab(struct loc_track *t, 
struct kmem_cache *s,



  	for_each_object(p, s, addr, slab->objects)

  		if (!test_bit(__obj_to_index(s, addr, p), obj_map))

-			add_location(t, s, get_track(s, p, alloc));

+			add_location(t, s, get_track(s, p, alloc), get_orig_size(s, p));

  }

  #endif  /* CONFIG_DEBUG_FS   */

  #endif	/* CONFIG_SLUB_DEBUG */

@@ -6078,6 +6142,10 @@ static int slab_debugfs_show(struct seq_file 
*seq, void *v)

  		else

  			seq_puts(seq, "<not-available>");



+		if (l->waste)

+			seq_printf(seq, " waste=%lu/%lu",

+				l->count * l->waste, l->waste);

+

  		if (l->sum_time != l->min_time) {

  			seq_printf(seq, " age=%ld/%llu/%ld",

  				l->min_time, div_u64(l->sum_time, l->count),


--------------WkB5RYIvIXZXBL69q70WuwOG
Content-Type: text/x-patch; charset="UTF-8"; name="kmalloc_debug.patch"
Content-Disposition: attachment; filename="kmalloc_debug.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2xhYi5oIGIvaW5jbHVkZS9saW51eC9zbGFiLmgK
aW5kZXggMGZlZmRmNTI4ZTBkLi5hNzEzYjBlNWJiY2QgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGlu
dXgvc2xhYi5oCisrKyBiL2luY2x1ZGUvbGludXgvc2xhYi5oCkBAIC0yOSw2ICsyOSw4IEBACiAj
ZGVmaW5lIFNMQUJfUkVEX1pPTkUJCSgoc2xhYl9mbGFnc190IF9fZm9yY2UpMHgwMDAwMDQwMFUp
CiAvKiBERUJVRzogUG9pc29uIG9iamVjdHMgKi8KICNkZWZpbmUgU0xBQl9QT0lTT04JCSgoc2xh
Yl9mbGFnc190IF9fZm9yY2UpMHgwMDAwMDgwMFUpCisvKiBJbmRpY2F0ZSBhIGttYWxsb2Mgc2xh
YiAqLworI2RlZmluZSBTTEFCX0tNQUxMT0MJCSgoc2xhYl9mbGFnc190IF9fZm9yY2UpMHgwMDAw
MTAwMFUpCiAvKiBBbGlnbiBvYmpzIG9uIGNhY2hlIGxpbmVzICovCiAjZGVmaW5lIFNMQUJfSFdD
QUNIRV9BTElHTgkoKHNsYWJfZmxhZ3NfdCBfX2ZvcmNlKTB4MDAwMDIwMDBVKQogLyogVXNlIEdG
UF9ETUEgbWVtb3J5ICovCmRpZmYgLS1naXQgYS9tbS9zbHViLmMgYi9tbS9zbHViLmMKaW5kZXgg
ODYyZGJkOWFmNGY1Li45N2MyMWEzN2E2YTEgMTAwNjQ0Ci0tLSBhL21tL3NsdWIuYworKysgYi9t
bS9zbHViLmMKQEAgLTE5MSw2ICsxOTEsMTIgQEAgc3RhdGljIGlubGluZSBib29sIGttZW1fY2Fj
aGVfZGVidWcoc3RydWN0IGttZW1fY2FjaGUgKnMpCiAJcmV0dXJuIGttZW1fY2FjaGVfZGVidWdf
ZmxhZ3MocywgU0xBQl9ERUJVR19GTEFHUyk7CiB9CiAKK3N0YXRpYyBpbmxpbmUgYm9vbCBzbHVi
X2RlYnVnX29yaWdfc2l6ZShzdHJ1Y3Qga21lbV9jYWNoZSAqcykKK3sKKwlyZXR1cm4gKGttZW1f
Y2FjaGVfZGVidWdfZmxhZ3MocywgU0xBQl9TVE9SRV9VU0VSKSAmJgorCQkJKHMtPmZsYWdzICYg
U0xBQl9LTUFMTE9DKSk7Cit9CisKIHZvaWQgKmZpeHVwX3JlZF9sZWZ0KHN0cnVjdCBrbWVtX2Nh
Y2hlICpzLCB2b2lkICpwKQogewogCWlmIChrbWVtX2NhY2hlX2RlYnVnX2ZsYWdzKHMsIFNMQUJf
UkVEX1pPTkUpKQpAQCAtODE2LDYgKzgyMiwzOSBAQCBzdGF0aWMgdm9pZCBwcmludF9zbGFiX2lu
Zm8oY29uc3Qgc3RydWN0IHNsYWIgKnNsYWIpCiAJICAgICAgIGZvbGlvX2ZsYWdzKGZvbGlvLCAw
KSk7CiB9CiAKK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50ICpnZXRfb3JpZ19zaXplX3BvaW50
ZXIoc3RydWN0IGttZW1fY2FjaGUgKnMsCisJCQkJCQl2b2lkICpvYmplY3QpCit7CisJdm9pZCAq
cCA9IGthc2FuX3Jlc2V0X3RhZyhvYmplY3QpOworCisJcCArPSBnZXRfaW5mb19lbmQocyk7CisJ
cCArPSBzaXplb2Yoc3RydWN0IHRyYWNrKSAqIDI7CisJcmV0dXJuICh1bnNpZ25lZCBpbnQgKilw
OworfQorCitzdGF0aWMgdm9pZCBzZXRfb3JpZ19zaXplKHN0cnVjdCBrbWVtX2NhY2hlICpzLAor
CQkJCQl2b2lkICpvYmplY3QsIHVuc2lnbmVkIGludCBvcmlnX3NpemUpCit7CisJdW5zaWduZWQg
aW50ICpwOworCisJaWYgKCFzbHViX2RlYnVnX29yaWdfc2l6ZShzKSkKKwkJcmV0dXJuOworCisJ
cCA9IGdldF9vcmlnX3NpemVfcG9pbnRlcihzLCBvYmplY3QpOworCSpwID0gb3JpZ19zaXplOwor
fQorCitzdGF0aWMgdW5zaWduZWQgaW50IGdldF9vcmlnX3NpemUoc3RydWN0IGttZW1fY2FjaGUg
KnMsIHZvaWQgKm9iamVjdCkKK3sKKwl1bnNpZ25lZCBpbnQgKnA7CisKKwlpZiAoIXNsdWJfZGVi
dWdfb3JpZ19zaXplKHMpKQorCQlyZXR1cm4gcy0+b2JqZWN0X3NpemU7CisKKwlwID0gZ2V0X29y
aWdfc2l6ZV9wb2ludGVyKHMsIG9iamVjdCk7CisJcmV0dXJuICpwOworfQorCiBzdGF0aWMgdm9p
ZCBzbGFiX2J1ZyhzdHJ1Y3Qga21lbV9jYWNoZSAqcywgY2hhciAqZm10LCAuLi4pCiB7CiAJc3Ry
dWN0IHZhX2Zvcm1hdCB2YWY7CkBAIC04NzUsNiArOTE0LDkgQEAgc3RhdGljIHZvaWQgcHJpbnRf
dHJhaWxlcihzdHJ1Y3Qga21lbV9jYWNoZSAqcywgc3RydWN0IHNsYWIgKnNsYWIsIHU4ICpwKQog
CWlmIChzLT5mbGFncyAmIFNMQUJfU1RPUkVfVVNFUikKIAkJb2ZmICs9IDIgKiBzaXplb2Yoc3Ry
dWN0IHRyYWNrKTsKIAorCWlmIChzbHViX2RlYnVnX29yaWdfc2l6ZShzKSkKKwkJb2ZmICs9IHNp
emVvZih1bnNpZ25lZCBpbnQpOworCiAJb2ZmICs9IGthc2FuX21ldGFkYXRhX3NpemUocyk7CiAK
IAlpZiAob2ZmICE9IHNpemVfZnJvbV9vYmplY3QocykpCkBAIC0xMDI2LDEwICsxMDY4LDE0IEBA
IHN0YXRpYyBpbnQgY2hlY2tfcGFkX2J5dGVzKHN0cnVjdCBrbWVtX2NhY2hlICpzLCBzdHJ1Y3Qg
c2xhYiAqc2xhYiwgdTggKnApCiB7CiAJdW5zaWduZWQgbG9uZyBvZmYgPSBnZXRfaW5mb19lbmQo
cyk7CS8qIFRoZSBlbmQgb2YgaW5mbyAqLwogCi0JaWYgKHMtPmZsYWdzICYgU0xBQl9TVE9SRV9V
U0VSKQorCWlmIChzLT5mbGFncyAmIFNMQUJfU1RPUkVfVVNFUikgewogCQkvKiBXZSBhbHNvIGhh
dmUgdXNlciBpbmZvcm1hdGlvbiB0aGVyZSAqLwogCQlvZmYgKz0gMiAqIHNpemVvZihzdHJ1Y3Qg
dHJhY2spOwogCisJCWlmIChzLT5mbGFncyAmIFNMQUJfS01BTExPQykKKwkJCW9mZiArPSBzaXpl
b2YodW5zaWduZWQgaW50KTsKKwl9CisKIAlvZmYgKz0ga2FzYW5fbWV0YWRhdGFfc2l6ZShzKTsK
IAogCWlmIChzaXplX2Zyb21fb2JqZWN0KHMpID09IG9mZikKQEAgLTEzMzUsNiArMTM4MSw3IEBA
IHN0YXRpYyBub2lubGluZSBpbnQgYWxsb2NfZGVidWdfcHJvY2Vzc2luZyhzdHJ1Y3Qga21lbV9j
YWNoZSAqcywKIAkvKiBTdWNjZXNzIHBlcmZvcm0gc3BlY2lhbCBkZWJ1ZyBhY3Rpdml0aWVzIGZv
ciBhbGxvY3MgKi8KIAlpZiAocy0+ZmxhZ3MgJiBTTEFCX1NUT1JFX1VTRVIpCiAJCXNldF90cmFj
ayhzLCBvYmplY3QsIFRSQUNLX0FMTE9DLCBhZGRyKTsKKwogCXRyYWNlKHMsIHNsYWIsIG9iamVj
dCwgMSk7CiAJaW5pdF9vYmplY3Qocywgb2JqZWN0LCBTTFVCX1JFRF9BQ1RJVkUpOwogCXJldHVy
biAxOwpAQCAtMzI0MCw2ICszMjg3LDkgQEAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkICpz
bGFiX2FsbG9jX25vZGUoc3RydWN0IGttZW1fY2FjaGUgKnMsIHN0cnVjdCBsaXN0X2wKIAlpbml0
ID0gc2xhYl93YW50X2luaXRfb25fYWxsb2MoZ2ZwZmxhZ3MsIHMpOwogCiBvdXQ6CisjaWZkZWYg
Q09ORklHX1NMVUJfREVCVUcKKwlzZXRfb3JpZ19zaXplKHMsIG9iamVjdCwgb3JpZ19zaXplKTsK
KyNlbmRpZgogCXNsYWJfcG9zdF9hbGxvY19ob29rKHMsIG9iamNnLCBnZnBmbGFncywgMSwgJm9i
amVjdCwgaW5pdCk7CiAKIAlyZXR1cm4gb2JqZWN0OwpAQCAtNDExMiwxMiArNDE2MiwxNyBAQCBz
dGF0aWMgaW50IGNhbGN1bGF0ZV9zaXplcyhzdHJ1Y3Qga21lbV9jYWNoZSAqcykKIAl9CiAKICNp
ZmRlZiBDT05GSUdfU0xVQl9ERUJVRwotCWlmIChmbGFncyAmIFNMQUJfU1RPUkVfVVNFUikKKwlp
ZiAoZmxhZ3MgJiBTTEFCX1NUT1JFX1VTRVIpIHsKIAkJLyoKIAkJICogTmVlZCB0byBzdG9yZSBp
bmZvcm1hdGlvbiBhYm91dCBhbGxvY3MgYW5kIGZyZWVzIGFmdGVyCiAJCSAqIHRoZSBvYmplY3Qu
CiAJCSAqLwogCQlzaXplICs9IDIgKiBzaXplb2Yoc3RydWN0IHRyYWNrKTsKKworCQkvKiBTYXZl
IHRoZSBvcmlnaW5hbCBrbWFsbG9jIHJlcXVlc3Qgc2l6ZSAqLworCQlpZiAoZmxhZ3MgJiBTTEFC
X0tNQUxMT0MpCisJCQlzaXplICs9IHNpemVvZih1bnNpZ25lZCBpbnQpOworCX0KICNlbmRpZgog
CiAJa2FzYW5fY2FjaGVfY3JlYXRlKHMsICZzaXplLCAmcy0+ZmxhZ3MpOwpAQCAtNDg0Miw3ICs0
ODk3LDcgQEAgdm9pZCBfX2luaXQga21lbV9jYWNoZV9pbml0KHZvaWQpCiAKIAkvKiBOb3cgd2Ug
Y2FuIHVzZSB0aGUga21lbV9jYWNoZSB0byBhbGxvY2F0ZSBrbWFsbG9jIHNsYWJzICovCiAJc2V0
dXBfa21hbGxvY19jYWNoZV9pbmRleF90YWJsZSgpOwotCWNyZWF0ZV9rbWFsbG9jX2NhY2hlcygw
KTsKKwljcmVhdGVfa21hbGxvY19jYWNoZXMoU0xBQl9LTUFMTE9DKTsKIAogCS8qIFNldHVwIHJh
bmRvbSBmcmVlbGlzdHMgZm9yIGVhY2ggY2FjaGUgKi8KIAlpbml0X2ZyZWVsaXN0X3JhbmRvbWl6
YXRpb24oKTsKQEAgLTUwNjgsNiArNTEyMyw3IEBAIHN0cnVjdCBsb2NhdGlvbiB7CiAJZGVwb3Rf
c3RhY2tfaGFuZGxlX3QgaGFuZGxlOwogCXVuc2lnbmVkIGxvbmcgY291bnQ7CiAJdW5zaWduZWQg
bG9uZyBhZGRyOworCXVuc2lnbmVkIGxvbmcgd2FzdGU7CiAJbG9uZyBsb25nIHN1bV90aW1lOwog
CWxvbmcgbWluX3RpbWU7CiAJbG9uZyBtYXhfdGltZTsKQEAgLTUxMTQsMTMgKzUxNzAsMTUgQEAg
c3RhdGljIGludCBhbGxvY19sb2NfdHJhY2soc3RydWN0IGxvY190cmFjayAqdCwgdW5zaWduZWQg
bG9uZyBtYXgsIGdmcF90IGZsYWdzKQogfQogCiBzdGF0aWMgaW50IGFkZF9sb2NhdGlvbihzdHJ1
Y3QgbG9jX3RyYWNrICp0LCBzdHJ1Y3Qga21lbV9jYWNoZSAqcywKLQkJCQljb25zdCBzdHJ1Y3Qg
dHJhY2sgKnRyYWNrKQorCQkJCWNvbnN0IHN0cnVjdCB0cmFjayAqdHJhY2ssCisJCQkJdW5zaWdu
ZWQgaW50IG9yaWdfc2l6ZSkKIHsKIAlsb25nIHN0YXJ0LCBlbmQsIHBvczsKIAlzdHJ1Y3QgbG9j
YXRpb24gKmw7Ci0JdW5zaWduZWQgbG9uZyBjYWRkciwgY2hhbmRsZTsKKwl1bnNpZ25lZCBsb25n
IGNhZGRyLCBjaGFuZGxlLCBjd2FzdGU7CiAJdW5zaWduZWQgbG9uZyBhZ2UgPSBqaWZmaWVzIC0g
dHJhY2stPndoZW47CiAJZGVwb3Rfc3RhY2tfaGFuZGxlX3QgaGFuZGxlID0gMDsKKwl1bnNpZ25l
ZCBpbnQgd2FzdGUgPSBzLT5vYmplY3Rfc2l6ZSAtIG9yaWdfc2l6ZTsKIAogI2lmZGVmIENPTkZJ
R19TVEFDS0RFUE9UCiAJaGFuZGxlID0gUkVBRF9PTkNFKHRyYWNrLT5oYW5kbGUpOwpAQCAtNTEz
OCwxMSArNTE5NiwxMyBAQCBzdGF0aWMgaW50IGFkZF9sb2NhdGlvbihzdHJ1Y3QgbG9jX3RyYWNr
ICp0LCBzdHJ1Y3Qga21lbV9jYWNoZSAqcywKIAkJaWYgKHBvcyA9PSBlbmQpCiAJCQlicmVhazsK
IAotCQljYWRkciA9IHQtPmxvY1twb3NdLmFkZHI7Ci0JCWNoYW5kbGUgPSB0LT5sb2NbcG9zXS5o
YW5kbGU7Ci0JCWlmICgodHJhY2stPmFkZHIgPT0gY2FkZHIpICYmIChoYW5kbGUgPT0gY2hhbmRs
ZSkpIHsKKwkJbCA9ICZ0LT5sb2NbcG9zXTsKKwkJY2FkZHIgPSBsLT5hZGRyOworCQljaGFuZGxl
ID0gbC0+aGFuZGxlOworCQljd2FzdGUgPSBsLT53YXN0ZTsKKwkJaWYgKCh0cmFjay0+YWRkciA9
PSBjYWRkcikgJiYgKGhhbmRsZSA9PSBjaGFuZGxlKSAmJgorCQkJKHdhc3RlID09IGN3YXN0ZSkp
IHsKIAotCQkJbCA9ICZ0LT5sb2NbcG9zXTsKIAkJCWwtPmNvdW50Kys7CiAJCQlpZiAodHJhY2st
PndoZW4pIHsKIAkJCQlsLT5zdW1fdGltZSArPSBhZ2U7CkBAIC01MTY3LDYgKzUyMjcsOSBAQCBz
dGF0aWMgaW50IGFkZF9sb2NhdGlvbihzdHJ1Y3QgbG9jX3RyYWNrICp0LCBzdHJ1Y3Qga21lbV9j
YWNoZSAqcywKIAkJCWVuZCA9IHBvczsKIAkJZWxzZSBpZiAodHJhY2stPmFkZHIgPT0gY2FkZHIg
JiYgaGFuZGxlIDwgY2hhbmRsZSkKIAkJCWVuZCA9IHBvczsKKwkJZWxzZSBpZiAodHJhY2stPmFk
ZHIgPT0gY2FkZHIgJiYgaGFuZGxlID09IGNoYW5kbGUgJiYKKwkJCQl3YXN0ZSA8IGN3YXN0ZSkK
KwkJCWVuZCA9IHBvczsKIAkJZWxzZQogCQkJc3RhcnQgPSBwb3M7CiAJfQpAQCAtNTE5MCw2ICs1
MjUzLDcgQEAgc3RhdGljIGludCBhZGRfbG9jYXRpb24oc3RydWN0IGxvY190cmFjayAqdCwgc3Ry
dWN0IGttZW1fY2FjaGUgKnMsCiAJbC0+bWluX3BpZCA9IHRyYWNrLT5waWQ7CiAJbC0+bWF4X3Bp
ZCA9IHRyYWNrLT5waWQ7CiAJbC0+aGFuZGxlID0gaGFuZGxlOworCWwtPndhc3RlID0gd2FzdGU7
CiAJY3B1bWFza19jbGVhcih0b19jcHVtYXNrKGwtPmNwdXMpKTsKIAljcHVtYXNrX3NldF9jcHUo
dHJhY2stPmNwdSwgdG9fY3B1bWFzayhsLT5jcHVzKSk7CiAJbm9kZXNfY2xlYXIobC0+bm9kZXMp
OwpAQCAtNTIwOCw3ICs1MjcyLDcgQEAgc3RhdGljIHZvaWQgcHJvY2Vzc19zbGFiKHN0cnVjdCBs
b2NfdHJhY2sgKnQsIHN0cnVjdCBrbWVtX2NhY2hlICpzLAogCiAJZm9yX2VhY2hfb2JqZWN0KHAs
IHMsIGFkZHIsIHNsYWItPm9iamVjdHMpCiAJCWlmICghdGVzdF9iaXQoX19vYmpfdG9faW5kZXgo
cywgYWRkciwgcCksIG9ial9tYXApKQotCQkJYWRkX2xvY2F0aW9uKHQsIHMsIGdldF90cmFjayhz
LCBwLCBhbGxvYykpOworCQkJYWRkX2xvY2F0aW9uKHQsIHMsIGdldF90cmFjayhzLCBwLCBhbGxv
YyksIGdldF9vcmlnX3NpemUocywgcCkpOwogfQogI2VuZGlmICAvKiBDT05GSUdfREVCVUdfRlMg
ICAqLwogI2VuZGlmCS8qIENPTkZJR19TTFVCX0RFQlVHICovCkBAIC02MDc4LDYgKzYxNDIsMTAg
QEAgc3RhdGljIGludCBzbGFiX2RlYnVnZnNfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSwgdm9p
ZCAqdikKIAkJZWxzZQogCQkJc2VxX3B1dHMoc2VxLCAiPG5vdC1hdmFpbGFibGU+Iik7CiAKKwkJ
aWYgKGwtPndhc3RlKQorCQkJc2VxX3ByaW50ZihzZXEsICIgd2FzdGU9JWx1LyVsdSIsCisJCQkJ
bC0+Y291bnQgKiBsLT53YXN0ZSwgbC0+d2FzdGUpOworCiAJCWlmIChsLT5zdW1fdGltZSAhPSBs
LT5taW5fdGltZSkgewogCQkJc2VxX3ByaW50ZihzZXEsICIgYWdlPSVsZC8lbGx1LyVsZCIsCiAJ
CQkJbC0+bWluX3RpbWUsIGRpdl91NjQobC0+c3VtX3RpbWUsIGwtPmNvdW50KSwK

--------------WkB5RYIvIXZXBL69q70WuwOG--
