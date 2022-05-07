Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ABD51E53D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 09:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376938AbiEGHfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 03:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238791AbiEGHfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 03:35:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCA545AF6
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 00:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651908688; x=1683444688;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EFqxl37R7Ul0Q4UWnizRGItVUhirMrcATp4LcUWb0Sg=;
  b=BSebvIwXnRGNXPELF8dwnNUv+wSQQe1S0nVMY/2YhJh/Ucfi+gb1xf0j
   JlIBkiBOZfPRieMAqTeOl2s1ojt3BrEXBBFswnrLcx8XaBMW6GICGts1U
   vphoC3tT053cQHVPu2P2wacBpU48OSkopE5sUGfPIPk2mPorMGdZGKhPg
   63V1k144kQt9KPm1ZoXjM7y8I247E7718MLY9kAWy1ZFuB2ugwA9MFDnD
   HK3zivk3X7PCiTeqFDdXcyqEPV4xYr4ricWglIf4Q8kur9UFU9J5VBixG
   NmNolT9fYxv02QDNcTriZx4s8Mn9qj+ZhLcPG/QEZ2FAi8BypRAREMmc9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="248578417"
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="248578417"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 00:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="665822660"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 07 May 2022 00:31:28 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 7 May 2022 00:31:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 7 May 2022 00:31:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 7 May 2022 00:31:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDiIPKRU6X/BRBfQkNgFUatnweaC+LYe4TY8/nwM4KRn9bWR0kJ7gGG84Oai+ox/p0q2xZjHSRZGT+iTcemjEumeaCWol729s+1APTsYz5xuPFk3cW9cMbrLvrJvp4tysYnGo+HONUulEEamqZApxFkUjAKB57x/K57HEbTTayt6bcqDIOX8z89lqPpzJWg2c3SUMhh0G+p1CFpNEABxvMVY5jOkx6Afu6/8c7mcztTztuisnVrzq3+nWvcUDRYiBuVB3DLrYTQKjhrbSNpK/fCn2oQd22yCq6UOVqodP08SWawLObhgotn/TkIqBYBLinfWcs+PP7VPt1vvVD7Bjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ol/FFjIdfr+CLa7r8voAJoUJ2mjRh+NOe6pyoh/rJGE=;
 b=TWFjSdv13TY7jgyUerjgoWpf6HZEf4awUSYsZBsL1HSyRKxUHBHGYJCDN9nWoO/cmHcFGmEbOHCf7baeTUnTaIkfL9AcTXWU9bBkpaJyB4F6qPOYOhcVXU33DFOXAkmUWvPeM5mx0jANGD4rppz2Y2i7Go9doDlBpiYKICvtqaqbkcQOrrH6UWhsyezG2D7BkMBHrHc/1P52Y/At174a0LtphwpUU3vTOJOPlMpw/LWiuMigJ/AIH6RoIL85HHFP8A9Frjnvc7J2yt9uuYZ46B1Vr2UjO3y86V8av7p+jA5b8Eg0GIsBhiIoapERmrqFqRzsEu3cCJQpeB3E4hYuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SN6PR11MB3039.namprd11.prod.outlook.com (2603:10b6:805:d3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Sat, 7 May
 2022 07:31:24 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff%5]) with mapi id 15.20.5206.027; Sat, 7 May 2022
 07:31:24 +0000
Message-ID: <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com>
Date:   Sat, 7 May 2022 15:31:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0%
 regression
Content-Language: en-US
To:     "ying.huang@intel.com" <ying.huang@intel.com>
CC:     Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>, <fengwei.yin@intel.com>
References: <20220420013526.GB14333@xsang-OptiPlex-9020>
 <YmvMDyx05UoPFtQy@ziqianlu-desk1>
 <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
 <YnURx04+hE0sQ3v3@ziqianlu-desk1>
 <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
 <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
 <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
From:   Aaron Lu <aaron.lu@intel.com>
In-Reply-To: <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK0PR03CA0101.apcprd03.prod.outlook.com
 (2603:1096:203:b0::17) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0db422db-c2f4-4c51-8704-08da2ffb970d
X-MS-TrafficTypeDiagnostic: SN6PR11MB3039:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB3039A0E574D8F3A049580F468BC49@SN6PR11MB3039.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1YOgkTztm039DtDJc9BQS1m45XpZu/Nshfcs3FBINLMWjd/gXbS6aVmjXXcciQeOM1tzioM8g7hte0eWoINuQDS4QALUAxwusSwBBocjhW0s5dSUMIgKQLY3w0QOsmnFVAp+fltCHAzzrqOViAauYyZcvESqEuyYjRlaxGz9zbGegqcMYgsOkX8YsP3YKdpjwkZytG1kedBbOEvwQQ/94r5BhzodaT842dLjprnC+TtW6BEvJ39JuEntBqYQLNcTHEg/ZbxDVAvUFgxTw44474Sy/aTJ//x3ln1azksHw6/mbUoVFljvX4Bn0Dgg/1OxzEAGpQIDa0n3OdSklw8fe3AjXZJTX4qXxKt+8QURrz+17bdX34e8nL6ThF2HtXWqIMFXdJjKPufIB0KMcW6XnHZYA83YP3gFyWz5323I/KfyuNErI2L/jcao7FK2yFWevQXlo+NF3yi476M4ZqiAmQ1qPBccZ/GobI5E3VpQWOlDjVtzzigQElA2GFDZROZEXQdUZ1c0itlo5GL8iOACQYX0Ma+g1LPf0JVxeuXuVm6SjnhnD3SvrP35AnsSyALY4KLZ7LlNCwqGoRV7T4DwypUPnXoSJauSK5l2FrXA7XS2z0qhKRlch9z0eORFlR5mymqbExEYbCfdAUVdVMBpXfvC3i+w0c4xyTlL49tlf7Do0xN1ZxtFPLcml8Hqs4g16d5fPH6IWA3g0fhuphtU+0BvCm4RvsciE53nyUmANHtBH6KXnMGNKoi72OLqHSXseAs43mnwD/k7ov912/Amsscw3OmNFZJs60GeOzVUO2Q+8Xg9q2XBaOxHN+F7Sv64O3EvbjCKi5F/cRKD1+FEU+E4GGfJ1AbXESFrhTNkms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(6486002)(508600001)(31696002)(186003)(2616005)(54906003)(316002)(86362001)(2906002)(37006003)(6636002)(26005)(53546011)(6512007)(38100700002)(8936002)(6506007)(6666004)(83380400001)(44832011)(66476007)(66556008)(8676002)(31686004)(66946007)(4326008)(6862004)(5660300002)(7416002)(82960400001)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW5XWmxuSlllOUwxM1JPMGdYNUJpanZueDdQbGFMci9veDJqMnhQQmYvdkVl?=
 =?utf-8?B?Y2xFOHBJMCt1L21NSFRqVC93Ny9peVMyNUxDYTFqcm4zcXgwS1pNUjRteDNa?=
 =?utf-8?B?cWdSSW4zdXZtN0lnS29oY2s1SURYNzhOQ3JJSmpDNGpzNTR5cWg3VTFIY3BZ?=
 =?utf-8?B?Y3NuRjUvWnF1Uy9IRXo3aytlTXg0WlROSElkeWlpTU44Wmk3ckxzRXN0S0E0?=
 =?utf-8?B?dGFoZmdINTE0UXVCL1BOa2JXcVJoTWhLd280eXY2cFBjRzlVbFFkZ0JVSFV3?=
 =?utf-8?B?blRyT2J4azkweXczTzF2eWkzRDlvaVJiM2dXK2Y4aGh6bVhkTFRFdWR3Yk5t?=
 =?utf-8?B?ZWhGdEtLMjBxUTRCcGFGYmdJOU5jTitYQ2dFazFtOS9nUUlHTWUzU2F1RzR6?=
 =?utf-8?B?M0wwdDRGWERVcHp1MHh5RWZhTE1Wd29IZVhsZnBYdVM4ZFZ6S3d6T2VDNHBm?=
 =?utf-8?B?bC9TcXNseE8rTkhFenRuM252OFBCbXlnUXdvZWVNTnAyai8zN1J4aC9NbnBP?=
 =?utf-8?B?NVVJSElJclBrSGVXSFBENXlRNTRVM2U0MUp0aUVQTUtXdWtuUHlVSjJsR2U0?=
 =?utf-8?B?ZWNvUDU2R3JjOVVuSXhzRW8rcXdPWmQ5aUs4NkxGQ3hrZTJyY1F2aVZpNklK?=
 =?utf-8?B?R0x1YXhQZ2pMdnpONkRVWnlxUjR4dVJYSVNKZXVQd0hPUHd5VE85bkFiWmwz?=
 =?utf-8?B?YS9aZlV4SVh0UmhSMTNJbk92WmxYc3NYK3AzZUs4L29YRXkwY2NmeldTQ3VC?=
 =?utf-8?B?WUVsV21OTEZnNm8yaDhLcXl5NGlrUjdCUU5QeVF4NkZXRFBoRDRJcFRBMWg2?=
 =?utf-8?B?RnhrS3V0Zk1xU2xNbWJXbEJDdW51NVZrckQ4UnROUkh0RmFFSTlJeHlST2VG?=
 =?utf-8?B?TW10cGYwSDRlN0FKcnl0UWhGRjJRdkRNV25EUGlyWDE4QmhrWm56U21xdmFh?=
 =?utf-8?B?ZkVZS1hySkJhZ2pBVnhmWkRDNUdnVVNiUFJaZjd0ZjFEMFIrcE9FbXZSSm5K?=
 =?utf-8?B?OXpKdU5NclVlM1QveFNiZEV2UFBXRkVpcUN0NmxmVnJlTE1oVUZxZDhEbUVS?=
 =?utf-8?B?VWZ5L0QxZHRzOFRBM1JUUlpsNWJxQktXSVRRZ3ErNk1kZEU5c3ZVWnMxRlF0?=
 =?utf-8?B?N05wYVg2WXcxN1Y2VnZmc3BGLzFqZXNJT09ub3RETkgrWDVabDUrUG1raldz?=
 =?utf-8?B?Q0tUN1k2YndLUjBuMlY4cE4wZSthY21sck1qd2crUFlqb2xDM0I5ajV4akZs?=
 =?utf-8?B?ZnQwcTRPbUkyMUxPc0RRc0RVbVFoNW93K1g0R2JyTUtGNTNtYndXS0lJbWlz?=
 =?utf-8?B?Q1lTUjdBK0EvMDBZUWEvNEwwb0lDblNUYWFKdlorS0cxQnRnSzQxVXhFcEdW?=
 =?utf-8?B?NnRWQ3FaNXBiMG1hVWU2Q3hBUWZxQ3JnUjhaWHNoMWRvMXJDaGVPWWQ2NmJ4?=
 =?utf-8?B?RUhBSGp2eThTUEpCYVJaTnBJdUxhcjJyd2pndjhsNmVjUHdTdkR6Mm1XR2VU?=
 =?utf-8?B?TnhMbmQwamlJVjN3YVB6VVdUSE9pTDROMzRYRExoclllN29TKzViYTdvZVdH?=
 =?utf-8?B?MUszS3VQTHErRXZaR3lGcnFJQ3pNRWhXVWZQWXRyOWgzQkJhaHkwQ05xUDZO?=
 =?utf-8?B?djd3cktYajlXUDBWVFhCQUorYmFoVjZ5OWw4WHkzRTFKWGxrNkxQc3VCczd4?=
 =?utf-8?B?VFZ3cFdmZ1luWkNPd21nQ1lJRFE5YkdxNTFhdGkzcUZNWTdPekVIWTU5N0Jp?=
 =?utf-8?B?cWp0VUpkMEdIZWowbUpJUDBWWHlPZm5vMlkrN1QrVzgzZUgxTDJvM0swamhW?=
 =?utf-8?B?ZzFGbFJxcjBwWTJqam1TYXVTL2VJdThOTkF2bFJnMCt4UFZJUUI0bWRHcmph?=
 =?utf-8?B?V2ZocWwrb2kvVzZqazR5akhJd0dQcDJCOXBISUh1NjdQMEkybGh4aEkvN1E4?=
 =?utf-8?B?N3lIWEpLVUVIZElKS3NJS280dUZqby9ySDQ3WktRVW0vOW56aHIyWHJ3aVNm?=
 =?utf-8?B?VkNCQWFHNjJKTFZ5RStOaFZwUktyVWV3elVsRnd5aDhQVUh1Sng5ZGpjaTNp?=
 =?utf-8?B?dVhOMkl2TkVPcyt4enhoNmpWVkYwS1ptV05GWXZqZHFXVit3QUN2ZXpHV3pl?=
 =?utf-8?B?Sm8vb012dmw2QUdMNWVMK1dsVkJYdEZVZDFFUmEwQ2RvYjBkdzdlNWRXQTd4?=
 =?utf-8?B?bG40c2p2NHhRNnUydUtpQUpPZW15UWNQb0twQy9Jb2p3N090MTRCRXRBOTFn?=
 =?utf-8?B?eXZBYmRYRXJZRUsrdFBJaXlOdldOYUVkcXR5RFlieHUzTFVuK09qVnFVTlV1?=
 =?utf-8?B?NFdhTXJReGxVdzQxY3loOHpqWUFUZWpDdHhZV2piSlZzbmVqQVFMUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db422db-c2f4-4c51-8704-08da2ffb970d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2022 07:31:24.6857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1S6o8pm7Od9s404kCdC3iOuXqgWGmOjwXbX0i4fGcwsgjlBWoPtzMpYP8ag8HeASLU/Lu/mJ6nNpcJSN8mK1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3039
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/2022 3:11 PM, ying.huang@intel.com wrote:
> On Sat, 2022-05-07 at 11:27 +0800, Aaron Lu wrote:
>> On Sat, May 07, 2022 at 08:54:35AM +0800, ying.huang@intel.com wrote:
>>> On Fri, 2022-05-06 at 20:17 +0800, Aaron Lu wrote:
>>>> On Fri, May 06, 2022 at 04:40:45PM +0800, ying.huang@intel.com wrote:
>>>>> On Fri, 2022-04-29 at 19:29 +0800, Aaron Lu wrote:
>>>>>> Hi Mel,
>>>>>>
>>>>>> On Wed, Apr 20, 2022 at 09:35:26AM +0800, kernel test robot wrote:
>>>>>>>
>>>>>>> (please be noted we reported
>>>>>>> "[mm/page_alloc]  39907a939a:  netperf.Throughput_Mbps -18.1% regression"
>>>>>>> on
>>>>>>> https://lore.kernel.org/all/20220228155733.GF1643@xsang-OptiPlex-9020/
>>>>>>> while the commit is on branch.
>>>>>>> now we still observe similar regression when it's on mainline, and we also
>>>>>>> observe a 13.2% improvement on another netperf subtest.
>>>>>>> so report again for information)
>>>>>>>
>>>>>>> Greeting,
>>>>>>>
>>>>>>> FYI, we noticed a -18.0% regression of netperf.Throughput_Mbps due to commit:
>>>>>>>
>>>>>>>
>>>>>>> commit: f26b3fa046116a7dedcaafe30083402113941451 ("mm/page_alloc: limit number of high-order pages on PCP during bulk free")
>>>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>>>>>
>>>>>>
>>>>>> So what this commit did is: if a CPU is always doing free(pcp->free_factor > 0)
>>>>>
>>>>> IMHO, this means the consumer and producer are running on different
>>>>> CPUs.
>>>>>
>>>>
>>>> Right.
>>>>
>>>>>> and if the being freed high-order page's order is <= PAGE_ALLOC_COSTLY_ORDER,
>>>>>> then do not use PCP but directly free the page directly to buddy.
>>>>>>
>>>>>> The rationale as explained in the commit's changelog is:
>>>>>> "
>>>>>> Netperf running on localhost exhibits this pattern and while it does not
>>>>>> matter for some machines, it does matter for others with smaller caches
>>>>>> where cache misses cause problems due to reduced page reuse. Pages
>>>>>> freed directly to the buddy list may be reused quickly while still cache
>>>>>> hot where as storing on the PCP lists may be cold by the time
>>>>>> free_pcppages_bulk() is called.
>>>>>> "
>>>>>>
>>>>>> This regression occurred on a machine that has large caches so this
>>>>>> optimization brings no value to it but only overhead(skipped PCP), I
>>>>>> guess this is the reason why there is a regression.
>>>>>
>>>>> Per my understanding, not only the cache size is larger, but also the L2
>>>>> cache (1MB) is per-core on this machine.  So if the consumer and
>>>>> producer are running on different cores, the cache-hot page may cause
>>>>> more core-to-core cache transfer.  This may hurt performance too.
>>>>>
>>>>
>>>> Client side allocates skb(page) and server side recvfrom() it.
>>>> recvfrom() copies the page data to server's own buffer and then releases
>>>> the page associated with the skb. Client does all the allocation and
>>>> server does all the free, page reuse happens at client side.
>>>> So I think core-2-core cache transfer due to page reuse can occur when
>>>> client task migrates.
>>>
>>> The core-to-core cache transfering can be cross-socket or cross-L2 in
>>> one socket.  I mean the later one.
>>>
>>>> I have modified the job to have the client and server bound to a
>>>> specific CPU of different cores on the same node, and testing it on the
>>>> same Icelake 2 sockets server, the result is
>>>>
>>>>   kernel      throughput
>>>> 8b10b465d0e1     125168
>>>> f26b3fa04611     102039 -18%
>>>>
>>>> It's also a 18% drop. I think this means c2c is not a factor?
>>>
>>> Can you test with client and server bound to 2 hardware threads
>>> (hyperthread) of one core?  The two hardware threads of one core will
>>> share the L2 cache.
>>>
>>
>> 8b10b465d0e1: 89702
>> f26b3fa04611: 95823 +6.8%
>>
>> When binding client and server on the 2 threads of the same core, the
>> bisected commit is an improvement now on this 2 sockets Icelake server.
> 
> Good.  I guess cache-hot works now.
>

Yes, it can't be more hot now :-)

>>>>>> I have also tested this case on a small machine: a skylake desktop and
>>>>>> this commit shows improvement:
>>>>>> 8b10b465d0e1: "netperf.Throughput_Mbps": 72288.76,
>>>>>> f26b3fa04611: "netperf.Throughput_Mbps": 90784.4,  +25.6%
>>>>>>
>>>>>> So this means those directly freed pages get reused by allocator side
>>>>>> and that brings performance improvement for machines with smaller cache.
>>>>>
>>>>> Per my understanding, the L2 cache on this desktop machine is shared
>>>>> among cores.
>>>>>
>>>>
>>>> The said CPU is i7-6700 and according to this wikipedia page,
>>>> L2 is per core:
>>>> https://en.wikipedia.org/wiki/Skylake_(microarchitecture)#Mainstream_desktop_processors
>>>
>>> Sorry, my memory was wrong.  The skylake and later server has much
>>> larger private L2 cache (1MB vs 256KB of client), this may increase the
>>> possibility of core-2-core transfering.
>>>
>>
>> I'm trying to understand where is the core-2-core cache transfer.
>>
>> When server needs to do the copy in recvfrom(), there is core-2-core
>> cache transfer from client cpu to server cpu. But this is the same no
>> matter page gets reused or not, i.e. the bisected commit and its parent
>> doesn't have any difference in this step. 
> 
> Yes.
> 
>> Then when page gets reused in
>> the client side, there is no core-2-core cache transfer as the server
>> side didn't do write to the page's data.
> 
> The "reused" pages were read by the server side, so their cache lines
> are in "shared" state, some inter-core traffic is needed to shoot down
> these cache lines before the client side writes them.  This will incur
> some overhead.
> 

I thought the overhead of changing the cache line from "shared" to
"own"/"modify" is pretty cheap.

Also, this is the same case as the Skylake desktop machine, why it is a
gain there but a loss here? Is it that this "overhead" is much greater
in server machine to the extent that it is even better to use a totally
cold page than a hot one? If so, it seems to suggest we should avoid
cache reuse in server machine unless the two CPUs happens to be two
hyperthreads of the same core.

Thanks,
Aaron

>> So page reuse or not, it
>> shouldn't cause any difference regarding core-2-core cache transfer.
>> Is this correct?
>>
>>>>>> I wonder if we should still use PCP a little bit under the above said
>>>>>> condition, for the purpose of:
>>>>>> 1 reduced overhead in the free path for machines with large cache;
>>>>>> 2 still keeps the benefit of reused pages for machines with smaller cache.
>>>>>>
>>>>>> For this reason, I tested increasing nr_pcp_high() from returning 0 to
>>>>>> either returning pcp->batch or (pcp->batch << 2):
>>>>>> machine\nr_pcp_high() ret: pcp->high   0   pcp->batch (pcp->batch << 2)
>>>>>> skylake desktop:             72288   90784   92219       91528
>>>>>> icelake 2sockets:           120956   99177   98251      116108
>>>>>>
>>>>>> note nr_pcp_high() returns pcp->high is the behaviour of this commit's
>>>>>> parent, returns 0 is the behaviour of this commit.
>>>>>>
>>>>>> The result shows, if we effectively use a PCP high as (pcp->batch << 2)
>>>>>> for the described condition, then this workload's performance on
>>>>>> small machine can remain while the regression on large machines can be
>>>>>> greately reduced(from -18% to -4%).
>>>>>>
>>>>>
>>>>> Can we use cache size and topology information directly?
>>>>
>>>> It can be complicated by the fact that the system can have multiple
>>>> producers(cpus that are doing free) running at the same time and getting
>>>> the perfect number can be a difficult job.
>>>
>>> We can discuss this after verifying whether it's core-2-core transfering
>>> related.
>>>
>>> Best Regards,
>>> Huang, Ying
>>>
>>>
> 
> 
