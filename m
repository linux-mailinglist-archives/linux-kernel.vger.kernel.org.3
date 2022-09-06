Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D74C5ADCAB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 02:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiIFAtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 20:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237126AbiIFAt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 20:49:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D181133
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 17:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WANk97mwUbp1qjMHVENDUASWEOUOFJbJmlFl+nhEkvpxRAGRI+GyRoxy2IoCaIounNXaPdRqpay2grMaAm0foIvnLsUWkpVTi21E3/6Fk/tPXn2eupkR7oCPmxAx5bQeD2gr0IBQkuEVmGrq/9qo4I4NW7RdMqs+uRJRaXjATN8QoCtrD7bObIMPZGnLx6LLGNDMZcrsu6z29aBfv0hWPsw/yGWQ+x7mcIA8v5mHunobCy1uPm24Ipv5Lu/2gqAvqULiw65dhSFK+A9npqGm1vzZhl/qAJk2NVcN8znqoWS8vNAz1e9rrsSTuN2PYgYAbOmhzwD0kxekslK0MVRGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKVfSkFX5NhOFhDWiNT3bE43fIRQ0ejrk3UyOWIqSMY=;
 b=oeW600CEd4OCc94EthyLIKoeT5jEwxpkH39cfPgPPYTNnraZxTTm96D06qUEQbeNw1QCZquJGduJZONc8h+cGMbqwAKVsSx7jjxYr3Aj+HVdL93ukl3fL2F0VjPjsDR/gBNP1t5GvHVKowj0wgNLKr4GjzpGT7hHTth4kKUal4iv0zuX+47D8lMPD5HzXXXD94fqCqrXvnF/4TZVPj+VzgCxBeG1xE0eF/myN3LqW/rMCiJ5eAkAw6TMkYepTjvr4/eDWsIz0bMzNCphQky9PL1VVfZgcELuUePSvurptnUw4Iu9eE++3NnL6SNqdgKT6CT2y5LtcO5xbCHPyzD04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKVfSkFX5NhOFhDWiNT3bE43fIRQ0ejrk3UyOWIqSMY=;
 b=a0EK+o4ZDNa8B6gzSCQxJvryT3rCPWJUOaRV4THuwiDQd2GAVWrsGqDPC31RuVsmtZbRYFbKZjEbMENdZAzqxJY63mEPy76LYBM197kojI7aycAnf3+XjMhN+6zhIygP83w0VWu/hRYMHhKW6WCG2yJRSE+wyA5y3OtgAfxvHkKZ7VMq+zZJ1VPXdY1AtfZGyUrU5IQylzFt8NOtDwZdwqUGXbYWyomDXFkO/OY3j7fnr9zmfQlazph4ZKrBfVCrCJht8cud9ZC/sT3FfExXHq+eNuBVHZSvPpGwd5iT8Y1/rkmHuyOvOwNI39Q6fRfZc5eqmjev2kBN+ve75UzAIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 00:49:25 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 00:49:25 +0000
Message-ID: <1c05b986-e8bb-2ec1-7c81-06b7cfe50f94@nvidia.com>
Date:   Mon, 5 Sep 2022 17:49:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] mm: Check writable zero page in page table check
Content-Language: en-US
To:     "Huang, Shaoqin" <shaoqin.huang@intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220902232732.12358-1-rick.p.edgecombe@intel.com>
 <3d82deb6-357d-0b54-ffd1-dce157674aad@intel.com>
 <467b0cdb4f876b87b50d1cd7229a8e6e02a19a41.camel@intel.com>
 <4f265843-bac1-944c-8119-aa4c1689c8e5@intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <4f265843-bac1-944c-8119-aa4c1689c8e5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0058.namprd11.prod.outlook.com
 (2603:10b6:a03:80::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfb65178-bcb8-41ae-c5f0-08da8fa1a56f
X-MS-TrafficTypeDiagnostic: BY5PR12MB5015:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IngtJuIZPvEktenoSKENfdQC1OWzySgFHEb373u5r7Y4U1vJnKETlYrfgW2SvovNXK+7yukmKlrue6M2pseD+i+rUyHRhZ/M8FB1wr7ImHT5IQdP6VprYewGMzB65uMEbuDVZGMDwlK/o+MbNqKFGSelfUoURZLoHvNVKzjiKKwy6L281dZ8CYDhgzaex2OUnZlBpY8gHLTxDTaEgVJXQskljX20+//y2HBUwTE9+BrhI33/V1+Ge8oJvjE1Z1MNF91xe5g7ieiFwyWr+6LVE740/rDYwzsjoer+svXWSUDyN9ZAfax0GhXhiZQZ1ugPKZi62pCDwAxCT6/TUZhE8gzQ1GYVN3X4/VTAlbgzsvyjBiQytIg1aNGp+SomhX4rb8pQHGKWRVCEf1KSKg4UduUDeBuVrhRwiw35dyrwcm6aLPVQnw0ebqj/gRxdASqzJzWd3/TngA5+zEr2CTFs2X2Uqkt63+mZuhXOsd0riLJPyXyycKypv8Jms+ALGdk41RJeAKYK+dh0YV9OZkk4iHyitXIzVRS8OSPegz02AQCkXLMY3VDqo9j8LSJlUgxnJPFJqwjTGLblY2yWHop/i3P94y8n62HZEpfLCrtnzqPRLSQz3UAGhGLm5vBxHF9YtrBn4/BwGOQ6XEaCj5BGjm3RIv/xKUW9eRtmWsXYA2N7HZZGESuCU+xlwavsMoZVOGN+xKnvRsIxvi7D7Su7rU9i3WUR56yk4iyFB0s2WBy0JOmIFBcuzRU1PuZJvXKcAbKnMjyh3g92fSfyqh33ziDhKMWzWFTI+kXPrLojf3lE/WJaa90Y9OHUyB8XqxwoRVZ2r6FqRC2+Gms8BmC1ULn8oY5+hAvcpRgCIFZ1fHbnzIBTKbX+dJRXay+ishko
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(86362001)(5660300002)(4744005)(2906002)(8936002)(38100700002)(53546011)(966005)(6486002)(6506007)(478600001)(316002)(41300700001)(110136005)(66476007)(8676002)(66946007)(66556008)(4326008)(26005)(6512007)(2616005)(186003)(31696002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjNLdEM2c0FvMGJ6eiszNVZwaXl2MFZWSTRwR3RRbEFLQXdJak1acThyL1Bj?=
 =?utf-8?B?akFodm5mbFBCT1A0U0Z4cGRzTjNsZHhTT1o5bWtuYWxQNERtL05lRE9wWjE3?=
 =?utf-8?B?ZjZjRjd5OGthcmlzQTF5NEQ5YXpFZmw1SUZpOHQ1ZFI5dEdwaHdvU3M4NUdG?=
 =?utf-8?B?VkhIOVNkMWY4NTBvZWFVMS9SaENQR2R4R2tUNlBTVk5vR0N4QXpidDRvTnk1?=
 =?utf-8?B?Um45OGcrNVVhZ3hCM2VSb1ZWek9PVFJlTHQvZVVKbEFkUHZlZk1McnN4K0dU?=
 =?utf-8?B?RzZJdWV0VERWNHNkNkYzWGJWKzZ2RW9GcE1TRmpiQnJGb1pQa09RVVdTMXNR?=
 =?utf-8?B?Q0JiclUxUThJSnA4d2NjMlZrdHBpUmYwNVhZYlBUSEdaRG9tNE9jek8yN1oy?=
 =?utf-8?B?UnlPaTgrbmtUVGQ3dUhXZXgyTDhBSThQalFqQTlFNldMNEIwdk1GTTRhTmRi?=
 =?utf-8?B?TTF1WVJLaWNSSlViUGtpTjdXQjcxRmhOZUxac2RSV3drZTFoWVhSZDY0dU5a?=
 =?utf-8?B?LzhQeHFQQ2t5aCtFNEl6UmFnWjhaOW95WTBmWVFqWVp2eFMrQm1LQnQ3cy8x?=
 =?utf-8?B?c0hnYlBBVHd1ekkyOCtxa05HVlJqRElkc2M5ODhUTU0yK0tMVnlKSy9WN3Yw?=
 =?utf-8?B?cFAzeXFUT04rVUxyNklYeEQzdGlOZlgrOTloTFZaby9ScmNJODVtVlhaNXph?=
 =?utf-8?B?b0xEY09CZTlLTlJzT3I4RSt6aVZpdkU1b25mWllxZWRId3pyeEhYL05zSFpH?=
 =?utf-8?B?QWtsVHdaYUlSS2UxNk41OFUzQUltMkVydjQzNnlsd0ljemRlTDM4N3BYWWxN?=
 =?utf-8?B?UkpBTTFjL0lDdHJvSTQxY0NZWVBIN3JFUHZMUUxlMktjRytqNkVWNGlXVFlx?=
 =?utf-8?B?RWY4S25xcU9Ma29lVExQS2Z5amRMOXFpVzJjY0o4TXg3ZGFRZVFPR2JYZzA4?=
 =?utf-8?B?VVo2Mi9nYTFnTkQ1ejV5SWJoTmw3cGdSNHJmTXJwTC9QSEp3VWlDbWE4RUdp?=
 =?utf-8?B?THI3bkV5czJYeXczQ1MwVUt0RjA1YWsrZDVKWU40SkpEaXJjTCthbHV2VjZw?=
 =?utf-8?B?ZUpjSTJ5ckVVQjJVNVQyd24vY2VhSzM5SlcxYzEycy81Um5YeForZEtmNDNx?=
 =?utf-8?B?d0o5RWV2MnNvY3pMcjFnc1p2TFNtY1J0RVRTdDlOS0hGdTVLUHE0NWZPQ3Z6?=
 =?utf-8?B?d2xXb1VYU0YvMXc0YlJBdkUrRVJLaGNxOVBQdmdzcmlnS3I1T2wvbkUxU21Y?=
 =?utf-8?B?OEdidThZbDRyUWxQM0REdURkekM2SEV3eXRKaGUxTUNIR1laZ0xzM0FmU2dw?=
 =?utf-8?B?b1VVb1VRMjVjYnJITjkxUWJLUktYL09taXB6eFpQQ2RxQXdOTzV1Um43aXUw?=
 =?utf-8?B?aDNOTkFHWlJjK0FocW82aU1NNUJWYmZPejJWTm1qK3hVYnNoN1pPM0s2bHJY?=
 =?utf-8?B?UGl1Tm5sNEkxZmQ0Q2VIQS9PbitSQXBNR01JODNQVjVKdFBkSGx0MkVmVU5j?=
 =?utf-8?B?QmtFVDR0MldJNXNIU1N5M2pXU2pVbVZZa3VES0UzWU9TUGdqNjNmcGRoSkUw?=
 =?utf-8?B?c1RLNTVROVhCOGc1Y2dpd25UMGZ4ZnVRQWVlbndzL2o1VjlDdHlBUzlKaXJZ?=
 =?utf-8?B?QUpPVHFCWXA5NGlVbUplc2hseHI0ZmJzZnVObzhwTlNKZkFoV2dTSTZ0QjJW?=
 =?utf-8?B?bldVR3lQSW16emZleVhycFIya2hKZk9KK0gyVXZqMW9KNHNJeFBZSUpoOUhY?=
 =?utf-8?B?Q2R2emljbHFFc0l1REtkM2ZkWm9Dbk9DMzZ5SkU2TVYwQS96UEJDTTFlRUYv?=
 =?utf-8?B?ODhxWmt0U1RnNm90UldJck04ck5tc1JhZXFaNnRSNWFiZXYyMk15TjVtQ1JU?=
 =?utf-8?B?Qzhoa04rN2hFVFN4OWhheHhoT3FGZENpbHZmZjcybE9NNUJMcnVUWW10SE9a?=
 =?utf-8?B?UU13Q044dHJDOC9wTzI3NlpqSlhFNzA4TUxVc3dvQVQ0UHF5VTNuUDRUS01k?=
 =?utf-8?B?ZSt5ejZmRmNLL3gzZ3praWpqeU9Lc0ZEMlR2VWtSQkZpTjQwZmdva2ZqQy9l?=
 =?utf-8?B?Y0J2WGp4ZVFtYXUzaGd6RWJEV0kwYVJZUjN1Y1ZvYmx6NTNlaWVaeHY3OVlI?=
 =?utf-8?B?NGV5QWQxekhmSytLTWw0QWxlOWdHd3FPV1A2dnJ4VzdvTFJDVGM5bTc3UG84?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb65178-bcb8-41ae-c5f0-08da8fa1a56f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 00:49:25.5668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wiFtYBI36Mpmp+VYCBhkdtVftbIVu5ORcR6Olz6AwV2vSeUCJUMfioCDjzQxQsSF1XxyTxw6eWjOQS+AnoZjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/22 17:24, Huang, Shaoqin wrote:
> 
> 
> On 9/6/2022 2:50 AM, Edgecombe, Rick P wrote:
>> On Sat, 2022-09-03 at 10:13 +0800, Huang, Shaoqin wrote:
>>>> +     BUG_ON(is_zero_pfn(pfn) && rw);
>>>> +
>>>
>>> Why we need use BUG_ON() here? Based on [1], we should avoid to use
>>> the
>>> BUG_ON() due to it will panic the machine.
>>>
>>> [1]:
>>> https://lore.kernel.org/lkml/20220824163100.224449-1-david@redhat.com/
>>
>> Yea, you are probably right. All the rest of this checker uses BUG_ON()
>> though. Maybe they should all be something else? Just felt weird to
>> have this be the only check that is different.
>>
>> I don't have any objections to changing it to WARN_ON(). Should I
>> switch the rest of the checks here while I'm at it?
> 
> Yes. I think in most situation, WARN_ON() or WARN_ON_ONCE() is ok.
> 

+1 for WARN_ON_ONCE(), and also for changing the other cases as you find
them, yes.


thanks,

-- 
John Hubbard
NVIDIA

