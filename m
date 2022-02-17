Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A94E4B9B28
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbiBQIdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:33:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiBQIdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:33:37 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BADA1867DE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645086801; x=1676622801;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CClv8zAr1x+Bdam5btq3zrdYqoDIPf3Lv6c0rj6VYsk=;
  b=lQdzQpUX7vXJfBY9BCAQdf80ProtOUj8dgbpAjVsA+DE24Az1epVnHFt
   /aIRumq2f+WS1ze/JHl2F8xNPSOKIZVp9La/ZvpgFeJF0/zRHDirDtyPS
   TS1yzWcpbej+QNlQQDmOW7ugOKp5aftr9jry6n+nR/hu4AnNKKn4B2VNq
   cmt7FMjRPMMKv7Oo0uFYNbJuSYUeYtqvxYJoX2Kp7/WGufTyUXmKb8UFp
   /SxiayJS4bdT5kzc49nGP14jKnJn4iTozXybLY9N/N4UVxDYBgG6MI2nW
   TOSq+4WodTeOS5NQWy0qSvywSdkJJxvM4GOPxZpNkQdaTMcG4KlRTJObo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="337268490"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="337268490"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 00:33:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="625891906"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Feb 2022 00:33:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 17 Feb 2022 00:33:06 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 17 Feb 2022 00:33:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 17 Feb 2022 00:33:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 17 Feb 2022 00:33:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdAxTz6J16RtU5A2uNjCUO1+hgjEp2t9f+FeoivSJp4aqoGBt53soahFtj4ozvplbKGX0rl3ifQW+DoQYFsLbORG/W+AQpg/esPSnOUjMYcRMVUUTXFt6+FfQ2PmqpuyCxFhJjjO7YZW/UflVdFyQ0C8INjzKwrBrvBm2Z+mFJ14nYfB9lJ+zPbI2oujchoPa8allWRl++cucgSnPm6Typr0o+35riwyQO4RDDLxK5eHAnjJJJtmhwDs5hpATI0AZUTXmrIK6/qzNw5NwbEggjHWEtaDZsDlgew0OqNysMX9iD9SM2HTCw26JhjuM9O1A5YwGuppMSajiHIR1oKebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJvTlqtdPnFpJnLFoBH2SdGMeATRewyo7YUEuInP3Hc=;
 b=KP6I5sZO8HmCHwvtU7qdNTCjcU62cWeYkGaeFgVBY6i1aIzhyMoIyyFbq07c+ALQbXt8MHeebGBKEKEDypzni+RIR/HhZUahYoJsPuK3dNTGQMgiGVpNKp/jQUoYk+V7HekuayZvNksMqxmiigzRrQiyMrljEgRNwY69WluJwq/pndxa9/tqft7uVvUFykoTFIFTWY0GTPAcxcO9La6vOQhsFODVCnJpu0+lm5H3Fnt73+G71C2Yi8mMJlOSLGmnoVZT5d2Dgn8HBpl1W4dOt8t5HNBvjie8uqp8NtpmZXpPPsK1PT0KCKhwwEWfdOq5GHp7WGdOt5nmCRHeAA3rEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BY5PR11MB3912.namprd11.prod.outlook.com (2603:10b6:a03:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 08:33:03 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::586f:a77f:238a:ab8]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::586f:a77f:238a:ab8%2]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 08:33:03 +0000
Message-ID: <57fa170a-253b-932f-0261-b4905881d888@intel.com>
Date:   Thu, 17 Feb 2022 16:32:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220215002348.128823-1-mike.kravetz@oracle.com>
 <20220215002348.128823-2-mike.kravetz@oracle.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20220215002348.128823-2-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0218.apcprd02.prod.outlook.com
 (2603:1096:201:20::30) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53bdf836-d314-4f5b-863f-08d9f1f01d27
X-MS-TrafficTypeDiagnostic: BY5PR11MB3912:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BY5PR11MB39124A72D52A0C73DAAB9B1AEE369@BY5PR11MB3912.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KltJSwbKVlIOZPuSLIdr5gtGZ0HhP3bUuboJR6qQYvw0+U80JY1cghFF3eUrxEb5Qmm3WgD2bh4SUgxXyw2NJ+gBbVn1WPpXSVIQpXeBpVJKfHnVPCZT3jsEg0JBAH1rnoVy24ALjIbAvOHyGpPDVjtJniXy8qgnik2Lg7QfCJxY7mg8R19V+hsB0BxIXA1jpIksvI+ZZOqcxCVtW6OYTPpK4UbyNgxfrG29yd+sN/fld9Ed/7R1H6JDEfgB6WToeivd1wFYHWMg5SatGXyiY4C7JkQ1ILZcYFEe7IW3QGVL1f2pQKOkN9dHs80FbgCS3P/hZ5/dNEyviL6TbxCng+PzW6aE6iwjHKVfm1PJJMeezfW4F7tnqK28zVLhrFIJJGRtd3ooDtxOWTr7Md+vxNSh3aoTnB2wO1ucpehun4KOa1rAqwczPaEP2egwecn/9Ph9i1tQXTAz34/ZPJ4xS50+vHcmMlUZnM/Q/G3cPdXEmjHaapU4Tn1v5oaGlavJP1qKK7dwVzCJ+EKohkZZodsCEVHgUXfFkhRHqR8w6XR5Q9zFM18IWuzqefaQGu9EQ6GNNVYa5Jf/zXuX66X0UjbObmuRxI7qp8l7QtceVyP7dsQlIC1GoKLE4LmbekZqwsMyoc6j6v2mwYlbSwBsrGmfrZmaowNrTkK2xkNFn5dSd0y9KwmaLUiq2Zrkub3RTHHTMrVnXQWxQJsNeoRb49KCgeJmiWB8M8ze7qcgqvODkV9lJ+ROm1KQ2aVBkv0W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(83380400001)(26005)(66556008)(66476007)(66946007)(82960400001)(86362001)(8676002)(4326008)(31696002)(31686004)(36756003)(53546011)(316002)(38100700002)(8936002)(7416002)(6486002)(54906003)(5660300002)(2906002)(6512007)(6666004)(6506007)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3VKcVlmYzVqLzYwN015ZzNtVk9BaXRnMkc5VThQQXNzNWZxeS9ldnBBR1ox?=
 =?utf-8?B?OEZKUjR1S2RaY1lzcHZYK1Y0S1FVamRvNEVXeGhhMmxTdHlhMFNySHBmWkdi?=
 =?utf-8?B?SXlsODNzR0U1MWRXbGV2engxNzJqSksySmRYMCtZRVZuNFZoMWcwbk9IRWp0?=
 =?utf-8?B?djErZXU3V0c1blBRa3dVNitPSWp4MHBKSy9SUTc4WVk4Zk80bVdtOHZoOHc5?=
 =?utf-8?B?MGxvZ292ZVQwNHh0WXNsV1NVRUhYRFd3T2NybEovYzhKWFdSbXJ5WFlCQVJC?=
 =?utf-8?B?NXlRUXVtMHhVa3UybXZaSEJwVWtDZ3l2dE9RM0FkTDl2emlDUGc1RjRPSHN2?=
 =?utf-8?B?a2lSUWZOS0NzSFovcHZUdzJkWjVCWGdlTjJ1V3JlRDE5eElVWlBxcXFLdXdG?=
 =?utf-8?B?c2RVbm5pRzQ2SVlWVEVBNGhRUFBEVHEzeGtkbng1dXF2WkhoVFlyM0FPNk9u?=
 =?utf-8?B?a25NVmdNa2JsM0VEMk1nRUR2bTU5UG93Z2psZ295M0dUWlY4UllHeCs5ZzE0?=
 =?utf-8?B?ME9XaGJkM24zNmx5dlpabEpiN21xUWgyWEg1RlFEbmNHcmtZMFlSVGw0N29X?=
 =?utf-8?B?MnNQbGdXUjJhMUIwUHd6ZzdNc2NNbFFlczFDcmhJbVU0ekIvUS85UFBvMWhF?=
 =?utf-8?B?Y3RPenprMjYwR0dOVEhTcS9ZNkVuUjNHUVF6ODdFMlcrblhWS3VSWGNuRDVZ?=
 =?utf-8?B?alZEcHdvZTRnUXNISk9rM3pMVnNxNE1qbE1vdlhBUDhmTGtodGJ1cXdLU2lV?=
 =?utf-8?B?ZWovQlRUdEYxdFhLMlQ5RXpiTDBWN3VyaW5RQmFQdXJ4dnJnNUVIbElXN3F5?=
 =?utf-8?B?SitpVys2cE5ZSVhrT2JaMXR4WVJydnhQamRjY2RiVVUxbjZyVXBpcXRJMnVt?=
 =?utf-8?B?NWtNM0k4eERMQnlHRmpOWGREQnBHRG1CaEh4VldDaG5vbWZ1bis4VGxjQUxE?=
 =?utf-8?B?NXQ2dFBOaXZoNVZpUDRhUzExa1U3dG9OT2ZlYjF0ZmpLWGo5THNxZ1VoaEdM?=
 =?utf-8?B?ejlYRU4vT012UHFSREl0b1dQYVg4eUhsQ3FaSGlSdmR5ekVrUXF3dkxhY0kw?=
 =?utf-8?B?UWdIM0FjaEwyVzBvRENXNHE3ZVFiRzBsQkt2RUZRdHJHc1RJUUN3cGFjVUNI?=
 =?utf-8?B?REErMXBGZzNDd0hTRTJMWXNmM3RKYnE4V1Bnb3ZjWWFxRUdGVzlqRmhnY3R5?=
 =?utf-8?B?OFp1cW43TnQrRTc2UmxwOEFZYk53WXVMancvckhTMTBtWE9BN3UrN2RPZ1o5?=
 =?utf-8?B?YW9qeWY0dklzRCtVNHdoOHh1R1dyTTNoT0s4RVNIWGNtT2JUMm1lZTNjQ0Fz?=
 =?utf-8?B?U24zSzUyYnRXcEE2MnUxd2krQVQvbG0rbnQ2WVdEWHVBSnRsVml0SlFqSkNM?=
 =?utf-8?B?ZlB1a3NEak93cFdiYURjSjJ1N2dJOFhpNHk2cUhNRXcvSUkwWGNSbm1NWVYv?=
 =?utf-8?B?SzBzMzYray9uMG5vZHA4WHovMVlyL0FJY2tySkorbG5UenQyZlVOa1R0dG1F?=
 =?utf-8?B?OWUvdmxKRHovUmF0RjBUZVBDVnhLZG1MSDZHYndmZGt0YWNsSGVkeW8wRmRp?=
 =?utf-8?B?czA0QnlkN1dLU3pVbUJsd0F1Q3lYbVZuTkpEeDJtanlQYngybFFqRVI0QVd3?=
 =?utf-8?B?WnJIYTcvaXVoOFc3d2JrQmN4UUwxN1dFOHJ3WXJZZHdkWnJpdEtjcy9KMklY?=
 =?utf-8?B?M0kxTjVqcGgwVU1LNEM0b1dsZG5ZY2pSZHFxQTl4TlRJNFlYRnJyc0x1T0Zv?=
 =?utf-8?B?aUdlQTh5YU5YdTNrcTFTMlQrejRCNEx5c2tYNGVJNXZVOERwemhZNkdpeWxH?=
 =?utf-8?B?enRNRnFWK0J4b0tyMlF5YUpPVFRIU1doa1RTVVdVWmFvWjBSekZ4cHpTVUZa?=
 =?utf-8?B?U0l2cjhZZ1pWb1FzUVVEeWFGbUxaUXR0aGFjRVlYTjVQMEl2UjJ1U1ZubzJm?=
 =?utf-8?B?UEF5bzdPMW9uQW05dnU4K0JYdGtCcTk1alJtVGN6Z1h1RlFsb0JnWWdSRElO?=
 =?utf-8?B?QmVxUEZQN3h5aFM2dkJDeU5QMXNHQ0FsUThtV2h0WlpyRlpQNEhRdDZHUjBH?=
 =?utf-8?B?QzZCcXovRVVsa0dkNjROUS81MHgrbmtOSW5KNi9sMkw5S3U2bGorTFlXRXVP?=
 =?utf-8?B?eGh2VVEwWXgrWHdkdDVpTDVIVGJyaEs4dW1ZbjN2Z1pLeXpoR1F1UFFPZzRJ?=
 =?utf-8?Q?ayVVBlwbV42ANBiKWWjox6o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bdf836-d314-4f5b-863f-08d9f1f01d27
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 08:33:03.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmXjZJI5xm+88RW41UfZrJ/2ylAL5+XB/yH8cBQN4uTjMvr9P1aJfGl1mJd/6arEEZdBPZkL2/83NoY2nuIPlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3912
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/15 08:23, Mike Kravetz wrote:
> MADV_DONTNEED is currently disabled for hugetlb mappings.  This
> certainly makes sense in shared file mappings as the pagecache maintains
> a reference to the page and it will never be freed.  However, it could
> be useful to unmap and free pages in private mappings.  In addition,
> userfaultfd minor fault users may be able to simplify code by using
> MADV_DONTNEED.
> 
> The primary thing preventing MADV_DONTNEED from working on hugetlb
> mappings is a check in can_madv_lru_vma().  To allow support for hugetlb
> mappings create and use a new routine madvise_dontneed_free_valid_vma()
> that allows hugetlb mappings in this specific case.
> 
> For normal mappings, madvise requires the start address be PAGE aligned
> and rounds up length to the next multiple of PAGE_SIZE.  Do similarly

In man page of mmap, NOTE for "Huge page (Huge TLB) mappings":

"For munmap(), addr, and length must both be a multiple of the 
underlying huge page size."

Should we apply same rule to MADV_DONTNEED? Thanks.


Regards
Yin, Fengwei



> for hugetlb mappings: require start address be huge page size aligned and
> round up length to the next multiple of huge page size.  Use the new
> madvise_dontneed_free_valid_vma routine to check alignment and round up
> length/end.  zap_page_range requires this alignment for hugetlb vmas
> otherwise we will hit BUGs.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/madvise.c | 33 ++++++++++++++++++++++++++++++---
>   1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index bed872a2ad5f..ede6affa1350 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -554,9 +554,14 @@ static void madvise_cold_page_range(struct mmu_gather *tlb,
>   	tlb_end_vma(tlb, vma);
>   }
>   
> +static inline bool can_madv_lru_non_huge_vma(struct vm_area_struct *vma)
> +{
> +	return !(vma->vm_flags & (VM_LOCKED|VM_PFNMAP));
> +}
> +
>   static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
>   {
> -	return !(vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP));
> +	return can_madv_lru_non_huge_vma(vma) && !is_vm_hugetlb_page(vma);
>   }
>   
>   static long madvise_cold(struct vm_area_struct *vma,
> @@ -829,6 +834,23 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
>   	return 0;
>   }
>   
> +static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
> +					    unsigned long start,
> +					    unsigned long *end,
> +					    int behavior)
> +{
> +	if (!is_vm_hugetlb_page(vma))
> +		return can_madv_lru_non_huge_vma(vma);
> +
> +	if (behavior != MADV_DONTNEED)
> +		return false;
> +	if (start & ~huge_page_mask(hstate_vma(vma)))
> +		return false;
> +
> +	*end = ALIGN(*end, huge_page_size(hstate_vma(vma)));
> +	return true;
> +}
> +
>   static long madvise_dontneed_free(struct vm_area_struct *vma,
>   				  struct vm_area_struct **prev,
>   				  unsigned long start, unsigned long end,
> @@ -837,7 +859,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>   	struct mm_struct *mm = vma->vm_mm;
>   
>   	*prev = vma;
> -	if (!can_madv_lru_vma(vma))
> +	if (!madvise_dontneed_free_valid_vma(vma, start, &end, behavior))
>   		return -EINVAL;
>   
>   	if (!userfaultfd_remove(vma, start, end)) {
> @@ -859,7 +881,12 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>   			 */
>   			return -ENOMEM;
>   		}
> -		if (!can_madv_lru_vma(vma))
> +		/*
> +		 * Potential end adjustment for hugetlb vma is OK as
> +		 * the check below keeps end within vma.
> +		 */
> +		if (!madvise_dontneed_free_valid_vma(vma, start, &end,
> +						     behavior))
>   			return -EINVAL;
>   		if (end > vma->vm_end) {
>   			/*
