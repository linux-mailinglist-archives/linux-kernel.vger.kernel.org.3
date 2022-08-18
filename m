Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB00598024
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240778AbiHRIci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241666AbiHRIc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:32:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000E7AFAF6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660811547; x=1692347547;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f3TBPchJyyFKwYJT0V2u/jNHyaQiMW06OvJeQ2YYqdc=;
  b=AH2Dh4v3J7V8bOS0Q63iA/e/4etMZuGD+w1PiBgzjfbs/BJqe19BudEA
   XkHrjwElKFjzXcBQyYRhw1A7Xzv34jfNUkhzr7d7e26EiUMQgFhAgSsXk
   Rf3uVkwpt+wGDqbdQ3ODmeHLJ7uTZ9t4RUyvtA7NA3YzcoVLGub1QYENU
   pF60QS1dQ4ll8QFkSK7hbT4yYBZ4969e0u+CMyWOgMRgZEwvklb0LJsoA
   Ur6s+5XlpnQSAUGdkpvLWHcH8Hr991S0Tp8EZSb7z9Y77wyrTa7+7slcN
   RV4282jaHVtB57oM27x/J9NSi1+9ou4BZNlVOxuj9moz4dTN9HyoN1Gnq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="318720675"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="318720675"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 01:32:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="668007833"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2022 01:32:26 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 01:32:25 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 01:32:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 18 Aug 2022 01:32:25 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 01:32:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8z1bV+gDzHm/+2pPCBFelk82x7ykD7EnqubWBF9fyg5uCbPC9MyI4WVpRU8DAyjcVGRoSLwNFOHpBMOKb4EJv4LrLwATSeer5H0cxPfth/40HHg93ZQ/7jZ8I88ikiOmPo5Wbs74dRV/Iv/FAFLK4/BI7eDVeI2Q3E0TQRWRy36SAmMAOwCa7qzVlFIQoVhqiKU9/vXEIn8S+pnuCTjK1LotwXw2D0l6nGgOEn26ALdlP0wKQ5olgX2YZa4LJj1NEPhSlm/8FPqEBSfDLiJPloV5Cq+rxcQYaI7l8zzuNR5kgSbpDTd/AmY6qEvzni5wsvKQCTJmzRfMAAAYh0ZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usCopZqfzpNGWiGsbWzc+69KtSd7K8i+LU00KjinwuY=;
 b=a1b0YQHv9Yc+SGnKB39rGuL6R9l5/vVwexZx02henEt1OIBORHVCK5GNXkboUHCzVEiiEP84hiAD2I4Ey8d/glfCy+GabHKtyNZSaIYv1GM/rNc/zjtfqa9ASMb+zHjUI+ywBHI3NffqIBpYPXcfrWlI7RRNFOyMXkzmcOvfQ+INWtshY+HknZ5TlQSqme9amFPaIsMVr+rQUuq6YbCqvPCNwWpe6+BE0D0+1oPoOwvnCN8f5Jd5WDxWxcmy8dPYJViPgfKsONFfVHOJCjOpfkB4C/FHRHBbGGSvWn9P2SOEJ5vJJg6pkrNcZ1uMmsehvaXgKTsfR9KYQ8IfQcKbXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA2PR11MB5019.namprd11.prod.outlook.com (2603:10b6:806:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 08:32:22 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c%4]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 08:32:22 +0000
Message-ID: <7fa5b2b2-dcef-f264-7932-c4fdbb9619d0@intel.com>
Date:   Thu, 18 Aug 2022 16:32:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 4/6] mm: hugetlb_vmemmap: add missing smp_wmb() before
 set_pte_at()
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-5-linmiaohe@huawei.com>
 <D8C00BDA-160D-40CE-AFBD-9488F85E76CE@linux.dev>
 <ea67ab10-667e-f361-b80f-dafb13da4808@huawei.com>
 <0EAF1279-6A1C-41FA-9A32-414C36B3792A@linux.dev>
 <019c1272-9d01-9d51-91a0-2d656b25c318@intel.com>
 <18adbf89-473e-7ba6-9a2b-522e1592bdc6@huawei.com>
 <9c791de0-b702-1bbe-38a4-30e87d9d1b95@intel.com>
 <931536E2-3948-40AB-88A7-E36F67954AAA@linux.dev>
 <7be98c64-88a1-3bee-7f92-67bb1f4f495b@huawei.com>
 <3B1463C2-9DC4-43D0-93EC-2D2334A20502@linux.dev>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <3B1463C2-9DC4-43D0-93EC-2D2334A20502@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:4:54::25) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5ab24d3-b673-4262-4d61-08da80f42bcd
X-MS-TrafficTypeDiagnostic: SA2PR11MB5019:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdHxdxVEqok4hsJDfsApQKlW8xy4fzcy56aoYsL80WBPRfQGOq83pATM+/QBt1uuSBFADXFMl8XpnOUYuMkNB+gEwLrkrYBHtM4UpbSFFq/pmkOEs4vcC+ifbVEsA8hYTXETWTT3OxDGsa64uC2jikhx6UnThGcVqQHt+9jjfhE5+7LqV4SzzgPOHM1tZ0S3ic0/o77llMvHYIDtALgq8Qj4OuLWLRhbu5GovAqldXcBc6JI3fPPyUHYjRjnibXZ2+c3MmlmuvaKqmHP6nTsPPFZ4Q+lrqzKlsLFR8Hg4FKDiqkT3NehtUvnBuwAIw3TaKgYK2j3hDJ8H7exklQ8SfNo2YKxocnM/JBnA1BDlK9AlbSuEe58eZPdPRayQKiyzfFtQH1tVMbuON/lAke2V2uHXjjyoB64OLorVxPRMMFUu9eZmc5twchUmSrbIqqAwOyoKeubP7GaT1S4FciI6o+KxA5d32Xw03PAxa2Hzg+uIdvIpd1BjAd/xLfhCQUBBqT1Fk64nINdJguN/jShVCuabGSNSBh8vcUXw5wZPD3Up/Ed7g1eDKql/yeV1urCdYHDrOvBec20UIYRacAoIyPq45VBju4OYZQ8VLGsAU87oz/ASrIm1uypkFFXGmCd4+ySm1GgpiIRgaC7kAz2UswAY/9KfSjDvA3VbWohsVWtDzmvFrXXczN31FwlQ/yenMNDLkxUWTerEnsOxgTvadMF+ky3UihiUnh7hzi7kqvlAWM9Bwkcq0xUheLAwQpz7ErlMt2TdD/SelPQn/iQCC5I2rJeWpKNIX9lrxmTe1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(346002)(396003)(376002)(2616005)(38100700002)(54906003)(41300700001)(186003)(110136005)(478600001)(53546011)(6486002)(31696002)(26005)(316002)(86362001)(6666004)(66556008)(6506007)(83380400001)(6512007)(8936002)(31686004)(82960400001)(4326008)(2906002)(66946007)(8676002)(36756003)(5660300002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmEwN2VJU3ZyR0xRWWN5MTRNR1RhRmczY2haTWpkZ3hkT2RKRlpFODVvcXdM?=
 =?utf-8?B?aUEvYWZJVnNqanN3a01OaFdqOTBnWEtEWU55ekpCSE9LZHNpQlU1SC9MRHNs?=
 =?utf-8?B?aVl4QUN4VWorTUYrK0kzTFRsWStkN0V2SFVMTXdMWG5wWVMxQkFGRngyRXJl?=
 =?utf-8?B?K1RxRnpnU0YvNzQ3QTZrdDhVZGxpeWtPL29rR0tUejMrcWRncXVXMnNJN2FG?=
 =?utf-8?B?K3MwWGVkeUFyQitNOGs1c3U4UXFwcVozVWYzdEpsQ0tveGdZZTFoU2ZIT2hV?=
 =?utf-8?B?S0wrVTUvTUQ4LzJoTW1pandNcGJvQmU3cUZSdmM1cGxmYjNpMWtmUHBYR3dU?=
 =?utf-8?B?SFNpK1BIOVU1ZWVZQ2VOeThHalA3dnpuQTJTMUFWYTAzNGJEN3RtSDhyaEdC?=
 =?utf-8?B?eVAwc3VoUnpUYmxVRkY1SVYvWnJZQjJaak5BL0d3bWhzQ2hoaDd3RUU1MGpK?=
 =?utf-8?B?UVRXdnEwMDRVbENZMlRxWks1ODZ6V21jdFk4V01zWEpHdkZwTzlVWUNyYysz?=
 =?utf-8?B?bTRFai9zclM3NW9oS1pwRmF2WkZ6Q1h3MzhYVW5xTDhsYnN3OHltUzR3MGI0?=
 =?utf-8?B?dStMeENjSEJYM3IyT21uemc1UXdkSU84WkI1OEthdW1nZXZhWnhvSGQwUFlJ?=
 =?utf-8?B?cFBEcTNYbkVnY1ByQ05ncTQvWU5aOGxPSTBMMUdYRzJIZ1cwUVlqWnJkMUg1?=
 =?utf-8?B?Rzdkcko0ZDFVT0RXTWFVT3RndzNPeUFPVGp1S3BUOTNWUG5nWVRMMzF6aSsy?=
 =?utf-8?B?cGkxSmhkL3lCTkN6VGR1ay9CRzViZXg3eGduRlJQU3ViTDFvV3VRaWlhZytv?=
 =?utf-8?B?NzUxYmRRdzFXTDBZRHZlYnoycS92T05DMHF0ZGRIZmtwT25MYTl4WDcvRUtL?=
 =?utf-8?B?ekQ1REc4TmVFTDRFK2NmR25OaWRCdDY0ejJqL1IycEM3WjhMcDlkdUhmc1ly?=
 =?utf-8?B?ME9VNXd3aDBEdFdhUEl4bVlKY0I1Y3V1SGJzdnBhc1BseVRBVkM3K3dzSTQ2?=
 =?utf-8?B?L3NzenJFcTQ1NGtROHlHN1dHKzNLSXVsYTRrK210bTFLRE5MK0F1SFVLS1Zy?=
 =?utf-8?B?S3NLdHRpdUpuWVg4YlIrSlBJb3VFLzdYdFlrSk5mOVdxOEVUclllNlVHUG5j?=
 =?utf-8?B?ZTlhV2RueE5HdTE2Ri82SVhsYkFKMTUwcW1VYXFrQS90THJtMkFjYkl1eGxC?=
 =?utf-8?B?ZlB2SU5sQS9XeGorcW9uZFNiRFl6cm5aWHdVdFliVFI0R2p5cCs2aWVCWDhi?=
 =?utf-8?B?MU9oRHpKOGJ0by9NRFBTMkxra1pwWkNmd3pDR1V6Vk9UT0hUUGZXSVFzY21s?=
 =?utf-8?B?MDIyWW0zLy9WOGxPVG5uK01leHdrL0g2WThQaEdNbnBJbjBwSXM2dUtQZEF0?=
 =?utf-8?B?TVZ6YVlBM1VzeDFrRzdGbS9tdWEzUEpReDdhMDIvZHpHVEFWcTNpSGJ6ZGNE?=
 =?utf-8?B?TkRHK1loNHBrNERKdE5xQnF1S245OXg1Ymt4dEF2L2R3anZ0OXJrc2F5K1U5?=
 =?utf-8?B?YjR1d05VQWNyTnIxMVZRZHRHRTNyRmlNcmt6YTVoVHg1b1Q3UkF3eC9CVjND?=
 =?utf-8?B?Y1puNk5ZVHpKVm16YWQ1MG0xTDM1allpUENHZFZJYkxyZytZemNYQ3FKWGkx?=
 =?utf-8?B?R3ZaNlNxVUMzRGJ3bWhaeTB6WkNRSUJWNE83Y2hXOS90bEhyU3ZVUmRRUWtS?=
 =?utf-8?B?b21wbnpWRE5GZ3pES2xRS01VNVg1RzA2YTRwZnVQSnpGMlh0Zk5XVUVPcmJt?=
 =?utf-8?B?andKUkFkTGJFajZEWmJpeCtjSTlOZWFSZ01nQ1pPY3E1b1FhZlI5WGFWcFJ0?=
 =?utf-8?B?cGQyTk11Zy9kMkoycW1IcjBuV1pnK1JjRE9uWTNHNGlVN1lpK2NGS25ua1FR?=
 =?utf-8?B?YkFFM0R6QjJKbkFPdHJLZUViQ3NIbDhMZnU0WEJ0bzZnNysyL0twMk1kSWNN?=
 =?utf-8?B?M1dWbDNtRS9adG9FS2k4R3VmeEdrUWc0cnAyMjQ2Z1R1bjlaSEphc2Z2TTE1?=
 =?utf-8?B?Mnp2TFZUbWpLMkhlcFYxa0Y0bmRXZGVGSlZRakxRYXVjWTBGb0FwR01ONk5N?=
 =?utf-8?B?ODM1UXplZkx0MTVYSlMvQmFEUmdSTHlyQnh4N0xlRk9SWXdTbEFBU2hUUm9O?=
 =?utf-8?Q?fQfPRwbX45KEC/5BEx0cYzzMX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ab24d3-b673-4262-4d61-08da80f42bcd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 08:32:22.4252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHAJcSqTUfwbFoIVxdGa1BgDpXQEW47lLkdPgceG22ne9VGaVx55IvBmtNXFTifKf8fhEwX2IdCTCUoLKGYQyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5019
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2022 3:59 PM, Muchun Song wrote:
> 
> 
>> On Aug 18, 2022, at 15:52, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2022/8/18 10:47, Muchun Song wrote:
>>>
>>>
>>>> On Aug 18, 2022, at 10:00, Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/18/2022 9:55 AM, Miaohe Lin wrote:
>>>>>>>> 	/*
>>>>>>>> 	 * The memory barrier inside __SetPageUptodate makes sure that
>>>>>>>> 	 * preceding stores to the page contents become visible before
>>>>>>>> 	 * the set_pte_at() write.
>>>>>>>> 	 */
>>>>>>>> 	__SetPageUptodate(page);
>>>>>>> IIUC, the case here we should make sure others (CPUs) can see new page’s
>>>>>>> contents after they have saw PG_uptodate is set. I think commit 0ed361dec369
>>>>>>> can tell us more details.
>>>>>>>
>>>>>>> I also looked at commit 52f37629fd3c to see why we need a barrier before
>>>>>>> set_pte_at(), but I didn’t find any info to explain why. I guess we want
>>>>>>> to make sure the order between the page’s contents and subsequent memory
>>>>>>> accesses using the corresponding virtual address, do you agree with this?
>>>>>> This is my understanding also. Thanks.
>>>>> That's also my understanding. Thanks both.
>>>> I have an unclear thing (not related with this patch directly): Who is response
>>>> for the read barrier in the read side in this case?
>>>>
>>>> For SetPageUptodate, there are paring write/read memory barrier.
>>>>
>>>
>>> I have the same question. So I think the example proposed by Miaohe is a little
>>> difference from the case (hugetlb_vmemmap) here.
>>
>> Per my understanding, memory barrier in PageUptodate() is needed because user might access the
>> page contents using page_address() (corresponding pagetable entry already exists) soon. But for
>> the above proposed case, if user wants to access the page contents, the corresponding pagetable
>> should be visible first or the page contents can't be accessed. So there should be a data dependency
>> acting as memory barrier between pagetable entry is loaded and page contents is accessed.
>> Or am I miss something?
> 
> Yep, it is a data dependency. The difference between hugetlb_vmemmap and PageUptodate() is that
> the page table (a pointer to the mapped page frame) is loaded by MMU while PageUptodate() is
> loaded by CPU. Seems like the data dependency should be inserted between the MMU access and the CPU
> access. Maybe it is hardware’s guarantee?
I just found the comment in pmd_install() explained why most arch has no read
side memory barrier except alpha which has read side memory barrier.


Regards
Yin, Fengwei

> 
>>
>> Thanks,
>> Miaohe Lin
> 
