Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C785227FE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 01:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbiEJX7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 19:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbiEJX7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 19:59:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD665223862
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O67/u7phd5gMPEb1FDPnQMYU2b2oCuAsfh+Ml8Fh4VIXHR1oI92Zw9wg8A9oCmB57Iej628SPFK0ojPmEKmkvVFLaC11006feVZ+bgPln+V+JVzYPllQodhnwOo69VqunGlD8nkkBpqzS87rFWG60uPsB1zo6b97QeXKy8pB+wJWwppyhprhE7+OXTYYLg4iXNLWqkyJ/k4EdxEtHrQ4kxuRKE2uatDtX7FRewOVAwsLMg8PxZfnja/FHLC8hMX053KnsbLJQ9OWw14o4duJ0I4eixTlUQ2QIJiBMlqp12qaHyJfOvndInBAqnkIPy9L4Dl+B1ssE/NdhANiBTsvUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVOyizssLsyFxzqqu0cqDIZlYhFmV2667/U9pwLg4Lk=;
 b=jHfSm6cjsejsIQvNfaOHbMCt2x+RYJJgFN4gI8FvGCuhBDFTxnwNAe1DaOc5d3yQYiAc77SqsI/srorgkAvhybpD0pwaW+uuVdPKRfWSImAC4r/kdHqlUEig3fBeBF9pGEzqtL/1OAD9/WdYVy0LTa1/MJKJsRE1Afz/WklpVIEKIku9443V0XlGx55Oib39RzvyCjEFtoX8g86zi4l/HPsiWiA8fMqqMku2u+1mD/UeKcglrYJgaumvraMWCDEh3wL3bsaoYMNmQPFdxPjsPm/3KB2aja4jhn7JwA8jjS29q0BajfDZPjALA1mk/EfKsLWpm5w770O+icL70WKYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVOyizssLsyFxzqqu0cqDIZlYhFmV2667/U9pwLg4Lk=;
 b=nh4qcMTInGBwPjWXRCcQBCHEny7AQP9k0aG/zbzWA9UdWGBqQS72rgH7jHBwPyg9COMq9PMs6zTEgcprtkm9r68auBZsnngj5HGDgQt5f3MOahtLZIQQiIcv/DsZQg1ThRT687F+PB6MsgA4o1AyPYl7yP6OkRmi1NMlVG0Fm22U0ESpCquCtScJ9hlVwQXUBIjrPtQbOFjZIt2vmkwJAzc4hDaGJ5YChk9F+axTUtQqWcqLDeOuLH/JhU0b9/pj2Bv5QSSdVUQ93V0954Fo3eVPhm1ClTaFi7nGV2iV6c1dhfmiOHoiqfKw6AcTes3GuPnBdl0HtVK+XwqGnfCcRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA1PR12MB6114.namprd12.prod.outlook.com (2603:10b6:208:3ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 23:58:15 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 23:58:15 +0000
Message-ID: <bb6e76f1-2cbc-893d-c8ab-3ecd3fcae2a5@nvidia.com>
Date:   Tue, 10 May 2022 16:58:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
References: <20220510211743.95831-1-minchan@kernel.org>
 <857d21da-5de2-fa3e-b1ce-41cc1cfb0191@nvidia.com>
 <Ynr10y6pkH6WwbQo@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Ynr10y6pkH6WwbQo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::8) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54ea1d2e-e3a1-43c9-ff45-08da32e0f2fd
X-MS-TrafficTypeDiagnostic: IA1PR12MB6114:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB611448E3DA6984F516778C79A8C99@IA1PR12MB6114.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pp4YhLoweVnem4j7TkWeul3TetDLWJZvBYZlUZaMHIUibuFFosvenyvqgaulIqgR0YZUcpjf+kTtbbxvKp5X8M4r2fPlWgHJzqOPrbJK1AIGyQjDl0ME49RlT/BOusJkYLrikZ5JDXt8vICmH5Ee2QKCqFbY7PYpo1RmwYVFG5F4UUsGsm9HzIGs9pKuItxJaUygfAxeggee64FEiw256ZqfFsXmI3zOIOqU4fu3CH0cACkd8RL0B1+ckA8HhKAQANBL4CCiKH+pjulvWXe2F6jIdqiIJ0o8NlVmziKTJyP+TXxUfLXmOyAph+TAxxRmfYuXX+/f8n/5vetsdQPmMuFI1bB7piWZCv9wJ4wKnYB2U/GWa/WkYG2wY9NnmLXNToqIsDnN+zI7m2OaE1KhfpuQPb4L9SSBgkWbxZTJ2fnG0PPtJ6S/pzN3NaQdXdav/dnSRpGEBmKhXGwOu4qGHxPrAsMMxtppNA+CuRXYtsZo5oCpbC3hC1nhYzrwE6oa7NfJi7J2aERjF2f9JWM8xkzjZgV4D6kGo9R58lRDpTVK/k+uLGzAsEvpqVPi7ASUfRT0Iud3a8gmoNYQWQvLIFs2j5BlHiqvccOM3nImuDhvsxI+Yy1s9XfLBwal1bnsQwIscpb07z5UxhLyRipinCKQ02EQfzfwiJ4d6DmO+vp/hxtlmQNULIY10xbFxG+Mt+g6GCHpoSzzbwQCLncyMweKNwyHv51J4q3Sj8BWimqcEfqro0m49GC80Yi2toby
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(26005)(2616005)(186003)(66946007)(31686004)(8936002)(66556008)(4326008)(66476007)(8676002)(36756003)(5660300002)(316002)(54906003)(2906002)(6916009)(508600001)(38100700002)(6506007)(6486002)(31696002)(53546011)(86362001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXJzWTQyRVJDNm1hOVVYUDR4K09zNHNJVTJLdjhOcUhYZW03NGlmajNZbDgw?=
 =?utf-8?B?ZmZVODB3RGVBY2ZaYlI3V1RIZysvendRSDdIQzl1eFo0cGlCY0RSQjIwRnBn?=
 =?utf-8?B?RU1rSEFxdkZybEVBSzJTZzJPNlpTaU9wRExYdDRaekpXdjc2eWVReXRHSlg0?=
 =?utf-8?B?U3VnYzhpUkl0STlzeFd4Sm1PeWZUcEh5enRaRitYaE1EK0Z5bUpZUTk1U1VX?=
 =?utf-8?B?MFdHRDB3VEpQek1hOURleHZJYmVadGdzNlJjUmFWc0pzaWRNd0RSZTEydTFp?=
 =?utf-8?B?S2t0UFFVWEhNUlAzSWlUNm9IRnFPd3lmbzlPTkNZUzB2RGJUMy81SkQwV1F3?=
 =?utf-8?B?bGhjQ3VQQ0tjV0FFakpiNmFYNEI0ZDZtT1FaMlI2UXR1TmdIZGZvck9qRkFJ?=
 =?utf-8?B?eUMvZVc5OWpkUWdJSWw4S1BISGVjSDZMSzI0WCs2cmtwR2tROE5TZ1RpTWdS?=
 =?utf-8?B?UThrVVVHeDJWNkRvUmU3SU5EZWt0K1B4UXZRRkpxYTVtZ2xjZVZUTlhxRzJQ?=
 =?utf-8?B?WDRQUWs2bnRRdkY3RWZQd3lld2QwL0MzMmVPMmp0Y3pCcUJSS2tyVXV3Tm5N?=
 =?utf-8?B?MzMvY1pBM3hJdG13RHc1cUVOMFNMRmwwS0hFbk5CMGtlaVVZZDhIVjFmdUNx?=
 =?utf-8?B?Mm12SmV2eW9LRFdxTmtGWCtQdzZZcWUwS1BYOG5rYk52ZDRhbzZLN0dGUmZN?=
 =?utf-8?B?YlZKRzcwaUpuc0kwbWNORFBzU2ZNRFRQOTJ3aHdKUVRmS0VKT3RQYytJY1Ri?=
 =?utf-8?B?b01BZ21kbFhoMmwzVUZ3V3liLzl4SlZBajgzSndwQWJxc2lxbW04d2RTMzNC?=
 =?utf-8?B?NTlJMktTYVRBRU4yYTdZRVFZYkdpOTlQOVptNW1Ka1RRalBPdEhFUlh3anA1?=
 =?utf-8?B?emtKUkNYdEw2UHovaTJjbHNHQVRpMUZyNHd6RWpuYldZZnlURUU0eERySjdt?=
 =?utf-8?B?NVJaNmFVSnFDSVZkbjZHaTlFVjlORmNza3B2bUpXQlN0cUl5Vis2VnRkTVht?=
 =?utf-8?B?cnNLUGc0L3IreUFoQldMWE9sQU9TSlBtSGViU1Y3dlIxdWt6K3lwazNHWVFZ?=
 =?utf-8?B?MFFzL1Q5QWkyUDZ0eTgxRXFYWHI2cmtNVmoyTHRaZWl5WWxSL2pkODJCenc5?=
 =?utf-8?B?dVRCUHRLNXNEZTFzMWpLVS9UQUZlcUlTK2JsQkdpOTcwTk9OWHJZR3FhVWhJ?=
 =?utf-8?B?UWkxRldyeWtCZzZvOHhmb1Jjem9yTER6MTh1V210cjRjREVuTGxHN1RLdlpj?=
 =?utf-8?B?VUxYWWRxWnhxblZNWWNLREx5RlNFbUtZaVV6N3dEazVrYWdGNktpakF5YTRH?=
 =?utf-8?B?WitHc0xSQUE0UER3VENDQ2h3cTZ4ZExXak1IY002YzVKSDdPV29xRkxPL3M4?=
 =?utf-8?B?THVNbVlETWhlSFdJY1o1MXJWcXcvUGJIM0tQakpudk1NcUIrVVNyd3F3Vkdu?=
 =?utf-8?B?UHFZWjRkN01rY0JqNkpIb21WOFd4MW9VNmMzSUN3YUp0YlAxVy96OFY0alJS?=
 =?utf-8?B?OS96WFZ1R2FZajBSMGl2WjMyWEZoa0l5cmM3UXl6UmVoZ3lRa1pXcVNmVXBs?=
 =?utf-8?B?dzliN3JzemwySFJLK2d1anJYak9EYmJIS2E5RjNNbG40ZEZ3VHRsUVRxYUR5?=
 =?utf-8?B?U1hEMTNyQWxkSDJ6eVlBeDFDcWxTZGRnM3dqTFhnNGxvUUticllUQ3VRZXlF?=
 =?utf-8?B?OFpNVFhUWUVlMnpVUnJOYUpNS21NUWozbjd1RjVOaXV3Y2daYkFPWXpnY0F1?=
 =?utf-8?B?bFRabmFDTFMxUkNWVXorTW1Lc3hTcXZ4ZFpRNGxwZmd1YnIycUM2RDJINnRs?=
 =?utf-8?B?aFRpakE0bkRxcUNsWjcrRTA3L05jRFZjblZlOUNzVGdvZFh0TmJXMnBHTmgr?=
 =?utf-8?B?THBBZlMwYnJUa0ZOUms1OFpSM2pBUlpRU2tKNjkvTUY5aVF6bVUvQVNtbE9P?=
 =?utf-8?B?bFl4RmNkQnNLOUxZQWg1QlVGL0Z5T3o4ZGxuOTFkSDBTR2VKQlhLK2o0NU1a?=
 =?utf-8?B?R3RkVlJYQVpPQzhDNTByRkZGWXA1SE5tRWl6VmNTMGtWQ0RnUzQ1Ny9ac3dH?=
 =?utf-8?B?UERwSFdrUC9mM1JOZSs5RTNzMjc1Tkk3MlpOR0tERGJlUW5kamV5TXpiUU03?=
 =?utf-8?B?WVZyL05ZZzRBTEZucS85MmtQR2xZM05SZWVUZk5sQ29aM2c0MlNGR1c0dFdW?=
 =?utf-8?B?NENWdlFvZWIvOXdrcE1OR0lSdkltYzVtN3dRaEtJbTBWTmlRc1ppbXZrZlhr?=
 =?utf-8?B?R2M0emxmSlUrV3ZzTGh3QW5lTHRCak1FMGE2T1dyR0lUVWhFUUFzYmFlc2Qz?=
 =?utf-8?B?R3JUbTJ0T0FwWUw4N2NTZHNiNFBuY0FVM1I4aEZxNTFBeS9nUVNiV1NmLzNG?=
 =?utf-8?Q?1gl6GqNNGZerbLIQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ea1d2e-e3a1-43c9-ff45-08da32e0f2fd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 23:58:15.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HR8IyqTJeSkqX7IOlLuFht/DtYn61Ilni9UCSHtRjq8KpVBgwOIrZtUVEIKiwuPMPp9ChNnpEei8145/gZqWuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6114
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 4:31 PM, Minchan Kim wrote:
>>> +	int __mt = get_pageblock_migratetype(page);
>>> +	int mt = __READ_ONCE(__mt);
>>
>> Although I saw the email discussion about this in v2, that discussion
>> didn't go far enough. It started with "don't use volatile", and went
>> on to "try __READ_ONCE() instead", but it should have continued on
>> to "you don't need this at all".
> 
> That's really what I want to hear from experts so wanted to learn
> "Why". How could we prevent refetching of the mt if we don't use
> __READ_ONCE or volatile there?
> 
>>
>> Because you don't. There is nothing you are racing with, and adding
>> __READ_ONCE() in order to avoid a completely not-going-to-happen
>> compiler re-invocation of a significant code block is just very wrong.
>>
>> So let's just let it go entirely. :)
> 
> Yeah, once it's clear for everyone, I am happy to remove the
> unnecessary lines.
> 
>>
>>> +
>>> +	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
>>

With or without __READ_ONCE() or volatile or anything else,
this code will do what you want. Which is: loosely check
for either of the above.

What functional problem do you think you are preventing
with __READ_ONCE()? Because I don't see one.

thanks,

-- 
John Hubbard
NVIDIA
