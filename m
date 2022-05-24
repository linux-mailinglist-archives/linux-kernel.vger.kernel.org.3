Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883B6532306
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiEXGWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiEXGWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:22:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570E74D243
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lof6wdEDz1cq/uwJPuPkXg764CLBLYQAoQzNQVOPqRwJ9FMcaaW2eWtto5TIxt4CGXB3TxH7tU7Wkvzy/hgIx3eGCelteo9VS5A/lKDCWX/dNK9fpBRz4YM+7hr2BqNXo0nR/OnpmoaowvNvBvn0+S2AeK9DgvXRSLqtmJT/2yh1/OpxPRgnUiiFnEh35Tr6Sr5aVMtfsmVrCCrfYP6kVOMVguzG1sJ4/jK10b4wWa+UiGLVc1UrReHBALN0WeOr8fqYhvJdjfyzYJp5uB4uSjwy9o8j4Tj4s9F22vh9D48af40wHLuHDoe82ScCKDwGpz56bDnI8/IP9pkW+iXByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xcor1uB1N+k8clv94gMQr2O8FGJu3hFECIFGC/YZKfs=;
 b=TNKGOqrb64KlmhjImyuVJasuo+8yXAvRgNXqQnBeHcqWCHWccLta35H98Q3zA3e/ec9eSzfx9kD8imjUT8Vl5UJbtVkPs03+qYA9Y18pEUAsUCJ3f6tYE6738rVE+ffd8ZAlLHAH4cbDHTp40bUpqHqnPboXysooWfnYUaIPW++n6IvvqqwNHUtpYtqkjl1W+zRe/H3QzKkelzieZYZcDKdkTvV7PDsa+q9jGjNi30VHDHAFoUQcW+vzqiL4G/403jn5cI/v7J658Lop/ERh19Sdv5gAQPBmILnPA7KKLQpUIgNI4uDThylM4QJLxA8ICMUTy/InRFqZ4XYw/Vp+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xcor1uB1N+k8clv94gMQr2O8FGJu3hFECIFGC/YZKfs=;
 b=AD1ig20qRx96KdIOm2fMyhhublbUJQYmpuA4mr1Ul9hnWuMMGBGA2Hiujp+nEthtXMN1ukSVPOweIixJLXJYKFfsRyEgi+8YjRgg15D8m8KbBP92SD/A+LUvl84qLtKw+JQj0qNcOjkmJELiM53mFTPcFukTDAPxcoczTjkprvifY8xOqfNLoaNzMgN5u+17enbxb2YS82+a/MYLmJwi43jeo1TcJDiHhnt0a2imYuYknj8gIOvRasgSW6yJe3m1Bwp2LX9/4gwzfwhd1DzWb29KX9ivJsI4D/4yg0gqFZvizgZ5s+tkMeWFgxZiqjd4NBvOuXnBAhS6mVYG9lz28A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM6PR12MB2970.namprd12.prod.outlook.com (2603:10b6:5:3b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Tue, 24 May
 2022 06:22:14 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 06:22:14 +0000
Message-ID: <1fab652f-4cd3-e45c-19b0-cf22bcb36cf5@nvidia.com>
Date:   Mon, 23 May 2022 23:22:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
References: <YnxczoehQJ+x6m9Y@google.com>
 <0accce46-fac6-cdfb-db7f-d08396bf9d35@nvidia.com>
 <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
 <YnyCqwY4DxcZ/NjM@google.com> <20220517140049.GF63055@ziepe.ca>
 <ef901bdb-6117-bad4-2f26-c80df270b86e@nvidia.com>
 <20220517192825.GM63055@ziepe.ca>
 <b6eef200-43d1-7913-21ed-176b05fcb4fe@nvidia.com>
 <You3Q/VFaCoS0mC8@google.com>
 <bcb95d6b-4507-8836-cf17-7c3cd179a3da@nvidia.com>
 <YoxqSud9fvNXqo89@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YoxqSud9fvNXqo89@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3ea45e8-bae9-4344-0ec6-08da3d4dbe25
X-MS-TrafficTypeDiagnostic: DM6PR12MB2970:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2970BE2827B60F22C0A2339CA8D79@DM6PR12MB2970.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YY/po5QVdyifixTXxn7ttkpTGoUf7zm/pTLAn8AWeYqUMU4ROfOOPNmYVpixBaC6f8HIVpqRZLdcqSj+sCF/zqADQfBlRxFkzFUlOm8QpVR7V9VN3l/2UAf5ERK9O9B4my0Z4YJbQfnddePhZdoEDIc9S3joQLCaJpg2xF0D0jEdMIxw2yHzGq8nfdYtBkpktxScXduoTEk0G0jUjo/E+pWWsbwB2RE1x5fuAGSWqrSa13skgD9zSzdHWnQCW2onY18fvGbeXuFY9lgqzSzJ+Dv/aL2vPpGSQkduyO3/XDEIF17I5PivlPJwGfyUnihEaZFnmpT3n2k0hbkI0L+K6NttGdCl5cAi+khU6zUWWEVAlMCNsw2vWS9QzgA27FjYcJXjWno0uw/W0Hen3ApTgRP84p/WDdTJ7zChkFPvEiTTdDvRepnV/AxL6Kdj373WP35JX86EhcMpnbHRlkaWkP2Dhcn5qrwoOZSnSR3gDy9r2+LseOxBQ/zfYoeEa5mCqmPpD8fhKrId0MAsA3FADzhupq5VuiOw0kNOqC5cgVp+jcv9cKBXibUcnO3USB8FItqwYtiLrTSGMH27LgpEeNoTnABmMVKsRQURhW5qjIxI731rUlp+8y1gVvFEewDGG6ksVC3UuHNgI3aoJr6TpEl+PeOWbTLS2tMSOxu4e6FdouBIqXZY71SmDKh9r85QgDx1oDNmtlkHH/at7J4vyQ7fIAWMe5lA5GU5rf+TgYgpus3RomwibXnJNvUtC/sw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(83380400001)(316002)(54906003)(31686004)(2616005)(6916009)(6512007)(31696002)(26005)(186003)(66946007)(6506007)(6486002)(86362001)(66556008)(8936002)(38100700002)(8676002)(6666004)(53546011)(2906002)(4326008)(5660300002)(508600001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFhlZk51ZHpjS21zalc5QStVU2lxVDhsKzYyTmJBNjd5M0RFcFlBWjcvRWF3?=
 =?utf-8?B?SFlUY0IwWFVITzdjV1pBUWxwMWJDZWk0cUVnYWNpSWx5Q2pnSHNQeDZPa3R5?=
 =?utf-8?B?Um9pUm1SL0FCMEJzZ1UvTnoyRGYzRHBlMkE5QkREYlFkeFZxYXRvNFZjMElv?=
 =?utf-8?B?RkRJZ2JGNEp3K2NaU2Y1RDB0VkFwSEFGc2hnSDg3cEowWDJ5cVpwdDFFZ0E4?=
 =?utf-8?B?M08yTkI4TnFjNE9IMHR6T1dvbWRUMUZVc3M5ejFRV3ZTby9hM1VUMVZoY2dQ?=
 =?utf-8?B?MFFPd0U2c0dCQjRvVWdaeGIrbGRYSk1TcjladTRqVnhWSWZ3cS9HUFlZQWNI?=
 =?utf-8?B?MGdNRTNTdXB1VG1TRzVjZGsvUWp5RTQzNDRxejB4bUpTWVJ1NjFzZUtxMXcz?=
 =?utf-8?B?OENkSmwzRUVqNWRuU1dyNTVXZytZSnVSUXM0cGFLalYrMXJrcTFFRnlKUFFE?=
 =?utf-8?B?NkhnSFlXRTlnQXBSNVlablZpOXd2SVNuazg3VWtKdU5YYzh1dUJJb1RlYkln?=
 =?utf-8?B?YUpNSWNsaWg0UkRkSlcyQ3BkTGNUdVoxcVpPWi8xaGJqdzdvdEFOVVgxaXcy?=
 =?utf-8?B?cGw2NXV1TmVOQjFHbnRwc0dEM3UrTWthVVpkemdwT3JPbThXNjN0cEpFZVo0?=
 =?utf-8?B?OGQxaHhxYVU3dVRNTGJ0SmZ2WjQ3eXZndnM2OFdwNjM1cUV5eWxpVDlDZldy?=
 =?utf-8?B?L0lvNk5EWXFsNDdwV3JrK0lMUmphUkVIQ3M5bmpKOC9vZmR5Zlg2d1g2RE5s?=
 =?utf-8?B?N211VUlXd3F2ZXRoV0FHTDYvRHJGWEN2TE9zNUQ0cnVTTmdncHdaMWVWaDF2?=
 =?utf-8?B?d3o4ME1NcndlMHFxUTJ3U3BHM1daV3dsZUxOVDdaTGVybUFldDJPb2I2cE9s?=
 =?utf-8?B?NENTbWgvZjhVU2U4TVBKM2JWUWtlRTRoNzZ0bEpHemlkT3VhYmVGbmhFWWtw?=
 =?utf-8?B?NTBKcWYvemZkNitETkc1dlZVL2xtNXRPUWUvQ3BQVzZXY2lGSnlxeTdIdXNq?=
 =?utf-8?B?ZlZUSkpNbklvblNpTCtCVlk1U3VPNGNwOTZ4b0dJa3VRKytMcVpVS1phVjJz?=
 =?utf-8?B?dkFZSy9vbkFwOUdSaGx6c1VYb3hyQWw1bHIzOExCM2o2eWFoRVlPaDI1K3Rk?=
 =?utf-8?B?YVE3cHZqeWNMRjliR0Z2SGRMWFQ2QXlqbmV5aVJ2VTNpT3o3d3FNdkQxYjlU?=
 =?utf-8?B?TEZ1Q1VKMVRSakdWdlQzMUpFNGpqUnA1bGlGa3BWd2xycTZCaTZoTVY3SjNM?=
 =?utf-8?B?VkdxUkRsV0IxTlM3WEVCMi90aFJWVzVFb1U4a1R6dHAwWUNQQ1RFT2wwRVE3?=
 =?utf-8?B?V3FpMTVoRlRtb3Q2VjEvV3dmb2x0S2lPV1VPbXA2YlY1WkI1R1ltOFRIL3Bn?=
 =?utf-8?B?dGFTdklwSEVyUzZJNzYvTlhCMFNMTFFEUXNiS2NieHVhS1hDaTVIQkc5NklL?=
 =?utf-8?B?ZTlUUXltbTRBZUQ0Tk54UzJSTGF4RytxZ3hSL2J1bTlnZUhsV0ZQaDM3eUNS?=
 =?utf-8?B?K0N6ZHVkL05zTFF0T1VRRzlQTjZjMFJvVmVoMHN1Z2RuVDViRVN5OHRYbUNr?=
 =?utf-8?B?NWNqRi9IVzVKalNyNlhUdjNBVHJFRHZudUptSVh0ckdzczZvQnpRV2RRdE9q?=
 =?utf-8?B?aVhEeVMyZ2pzNkllQWVEa0tNWTFCc0ovRmZXdFRzbHRrcTBuSjVUZllzU05R?=
 =?utf-8?B?YStmQWdFaVlBa2dOdWdKZGJrc245N3NGcHpLYXQwNDlqUTJWcC96L3dFSVpI?=
 =?utf-8?B?dnEwSU42L3dLSnhLaUMvbzhiV0ZNcVpIMis0azNBaC81TkhYaCsyU05McllU?=
 =?utf-8?B?TS8zMDIxZ3RDS1JsenFjNlFQMUZtOTVwcXFvaEgrN1pGK2ZYaHBwWkQ3L0hS?=
 =?utf-8?B?SFIyODR0cFBtSTVEaGVNNEtTNTB5RmFhRkMxbzdFSUdMUlRMTWx5ZXI2OHJv?=
 =?utf-8?B?Rjg4RVd3WGlzemM1WUNmTmZXZGVKUUg3cjJXeWZjVm00UGxNUjNjR0VnYmJL?=
 =?utf-8?B?NjJjM1BlbzlzZVB1elFKWW45RVhrdUR0TzgwU2hadHFpWlM1VzZvN28za2pr?=
 =?utf-8?B?T2ZWeDhVRG9ZM2prb1ZGdW9UWHRubmJSZmc3cnlMWHN1MGFsa0NlZTBKVXlv?=
 =?utf-8?B?TkZSQnhOb2JNTFcwYTlreHZrQmhiN08wbERYNThWTUs1SlhKUjVvOUZGd2ta?=
 =?utf-8?B?M3FqZjNJTGhPbWZsc1pZM01jY0pBa3JpckdoNzFIc0w1WXNQVGFyMUNGeEpK?=
 =?utf-8?B?c0pLZTNiT3AxTU1MdzVwbThhSktNUlpsOFJ0MUxpbDBGYm5ORWZtQ0N3Yytp?=
 =?utf-8?B?N2gwNVVhWFhFcmxvVDlacEw2ZDhKVDZaWTBPK3d5NE1pMWZ4RTBZZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ea45e8-bae9-4344-0ec6-08da3d4dbe25
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 06:22:14.0110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKY8qP0dePzICOzZEZ33zwZJhdulbLKkCpeQC6l7zGbwwaGTY0sVI/MvKD7VHOexLre2k2pDwi3ngWrv1UbvIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2970
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/22 10:16 PM, Minchan Kim wrote:
> On Mon, May 23, 2022 at 07:55:25PM -0700, John Hubbard wrote:
>> On 5/23/22 09:33, Minchan Kim wrote:
>> ...
>>>> So then:
>>>>
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index 0e42038382c1..b404f87e2682 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -482,7 +482,12 @@ unsigned long __get_pfnblock_flags_mask(const struct page *page,
>>>>           word_bitidx = bitidx / BITS_PER_LONG;
>>>>           bitidx &= (BITS_PER_LONG-1);
>>>>
>>>> -       word = bitmap[word_bitidx];
>>>> +       /*
>>>> +        * This races, without locks, with set_pageblock_migratetype(). Ensure
>>>                                                set_pfnblock_flags_mask would be better?
>>>> +        * a consistent (non-tearing) read of the memory array, so that results,
>>>
>>> Thanks for proceeding and suggestion, John.
>>>
>>> IIUC, the load tearing wouldn't be an issue since [1] fixed the issue.
>>
>> Did it? [1] fixed something, but I'm not sure we can claim that that
>> code is now safe against tearing in all possible cases, especially given
>> the recent discussion here. Specifically, having this code do a read,
>> then follow that up with calculations, seems correct. Anything else is
> 
> The load tearing you are trying to explain in the comment would be
> solved by [1] since the bits will always align on a word and accessing
> word size based on word aligned address is always atomic so there is
> no load tearing problem IIUC.
> 
> Instead of the tearing problem, what we are trying to solve with
> READ_ONCE is to prevent refetching when the function would be
> inlined in the future.
> 

I'm perhaps using "tearing" as too broad of a term, maybe just removing
the "(non-tearing)" part would fix up the comment.

>> sketchy...
>>
>>>
>>> The concern in our dicussion was aggressive compiler(e.g., LTO) or code refactoring
>>> to make the code inline in *future* could potentially cause forcing refetching(i.e.,
>>> re-read) tie bitmap[word_bitidx].
>>>
>>> If so, shouldn't the comment be the one you helped before?
>>
>> Well, maybe updated to something like this?
>>
>> /*
>>   * This races, without locks, with set_pageblock_migratetype(). Ensure
> 
> set_pageblock_migratetype is more upper level function so it would
> be better fit to say set_pfnblock_flags_mask.

OK

>                                       
>>   * a consistent (non-tearing) read of the memory array, so that results,
> 
> So tearing problem should't already happen by [1] so I am trying to
> explain refetching(or re-read) problem in the comment.
> 
>>   * even though racy, are not corrupted--even if this function is
> 
> The value is already atomic so I don't think it could be corrupted
> even though it would be inlined in the future.
> 
> Please correct me if I miss something.
> 
>>   * refactored and/or inlined.
>>   */
> 

thanks,

-- 
John Hubbard
NVIDIA
