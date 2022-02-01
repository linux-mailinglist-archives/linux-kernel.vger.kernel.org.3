Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48574A57D7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbiBAHfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:35:19 -0500
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com ([40.107.236.80]:37856
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234605AbiBAHfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:35:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Juv+7Eyk/9tUJu/THJJbnTJ8V2x4itk64vfinTK6WIKfYUv6fSRzv4YIUpCWeUWVX5wG+T4drOT5aygcGGJi19GJTwZNyye4YzQZ/tV45SQno6Yv9X3Var87vOUkaJcwnXKqZtsliYD3hu2s3uzWYb4EZ/n00CLeJxGN8hnFeESk9Gn8utYYytHdmHzjO5RRbtLQ95esHaFR97p2aGrS18S9eRkU1IC5YiQ0czhb9tP7n8+tMrcoDZno/X0i7Um8gz0+BxWLnQEPWW8yz/3WfAgvXlOyeQbaln3W47yqBh/08zLL4wTZCWvCsEwwkIRCYyRZ1cl8G/7e5JkW0LmvlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZj1lI/8WZ1x89LQ/T2ZZxcmP6WfPYJCQTkYrf3K3NE=;
 b=PaCbaBut13c3Le69oFIBh5lCZc7LsHQ+0cSM67WOImHEBN+iKw5z8D2ZNy7RfYMO0q+xAkxu//MyYKX6mUKZMibcV34lGnTuXbLbvH1XvHiIFzHem+QaPBIAFYd7xZbBbs/sX/QQxB1PyzEgzactb8QWEb6HA4nzxwBD41zuDUxX15A6yZYH4MfUkLyn5kz1B4B06Q8KETNxQUvUuaGtFi0HbcUpaEpHpSBiHdMDqpy8LGU8hu/epQTvDBKB8MuMmrN9r/SEKzbNW2IwFtXAGhtMyb4g2Xef8ysMEXBQGXzMYSNbHy1UHldJG/cSdoSZCNFnTjm03UuE3NJZ9jr5nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZj1lI/8WZ1x89LQ/T2ZZxcmP6WfPYJCQTkYrf3K3NE=;
 b=J7aUjggZtZkuiS97Sln1xvyV4f5v6Reo3cu6q+mlb+M/qDLPjCkVMyZ9mEULNONRCZSAEyfMQyKsBv+d9j5BagkZqJRqr2Ch7AfY2nVMOtx3WP2/ITKNOHTRGcLWQHjqvjzq9Uy0KTEsgQlJ5X7OHV8HZmPGIJXf5P5raI7FciSCAVfr0ECeJG9+OS65u9xpf68MsB4I/7II/NkCw7nSbaS0Dog12OWUCXzZs6Zg3Z4heAWKXHb8lxa57GT/Tn2xEAAjK4L4JW0DMww1FUcLI7AV/nLo+RMcUgp6lnDQoF5jeJfQXMhuAhAjRcyX/arqetRgHDb+/8Tpgi2OfCKbgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Tue, 1 Feb
 2022 07:35:15 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%6]) with mapi id 15.20.4951.011; Tue, 1 Feb 2022
 07:35:15 +0000
Message-ID: <36068cbd-2020-1961-5034-866a4c7b20cf@nvidia.com>
Date:   Mon, 31 Jan 2022 23:35:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 1/1] mm/gup: skip pinnable check for refs==1
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     Will McVicker <willmcvicker@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220131203504.3458775-1-willmcvicker@google.com>
 <27e5f98a-0709-1a80-18ed-e4ccaaf39fe6@nvidia.com>
 <YfjhGKCkQ6h5H5uI@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YfjhGKCkQ6h5H5uI@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:a03:54::14) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db2ef8f6-b3b4-49cd-8c47-08d9e555639b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4369:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB436917681EC7723725AC6473A8269@DM6PR12MB4369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCkLVCgtNC1uIKxudPP4etVh+WXLivORBe5AEHRQeXKtPO8cH0XKNcNXnyZ6I8epvJZtTpC2SzFwmOXf5JPy1+3rPhok5TWuD3KS6AXoFJutcubrz7sr693g5iJrlybSeJqmEDuWke3jDNRb4bCCBKLOBlcVUh2LJZH4+R0FSokgSTvRmf43DS/uREtkgBHa28cANevvkuTcRa1ircV6BthrjS8IG8DIMstMjcbm0NNJJhS4xoaHxwR+PG2sZDyIjxaJfJ0sUhOC5Ka9mckroel7QDWyIr2n9Q1hF9IhaInd6+4QBRbqAaS5djEx2z21mq6almYq8Rh79Bj1gavcaPaSXIL4mfbkScX6G3sTHFJcQAj84dHvdScvrN0oPDAhD2brR8FczaIWExJEZYzm4O2QBnEEQLvhPIimEQDhrCY6YZ2g4wBPn8urF660NqStm6YPA/mnu08ZRHomKpuU+Q/VlpCJODdlU/9ttmVz4NsBMT1nOYu0e8ZuvH8+dd3g6FJ9LTQHSJv/UTcHME9grG9gAQMaxxsoa4zYCTVHqvxOv8WJXzBwd3XbQ4svxoUvEc9oTEs9SuEDYQRrtZOmhU1LVAdGsLOKGj2N/gvRUhw80Di1LmLF1w6x7bYqCwQsLdq9mH/B9+TjujIlr5pJiVAR4pxj6KP3Zcx5VbL19W3YtKOsHb4q0F/LNNjrh2RHD0NY4hzi3G2H+q9uNhzFyktKIGdxnp8kJHmhGRA9vGkcFaQbLBHYmOpZLg15pSZO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(8936002)(66556008)(66476007)(53546011)(31696002)(508600001)(316002)(66946007)(86362001)(54906003)(38100700002)(6486002)(4326008)(8676002)(6506007)(186003)(26005)(5660300002)(83380400001)(2906002)(6512007)(36756003)(2616005)(31686004)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGhGeVVQU1dhUyt1VFZXUXFPc3VidHkzYm9KU1VEN0tWNFB3Y3VEUjZuWVAy?=
 =?utf-8?B?R0RNcDBCdjFISk1kRGpKd2xUeks3Qy93UkNoTHVqdXhOY3F0Qzk3WFBKZXNC?=
 =?utf-8?B?cEJPd1BDTEdqVEhPVDNHSnR4YmVWNlhreVU1V1o3dms5TklXS0c1SmJ4WkxP?=
 =?utf-8?B?ZGhpZk13WUVyNEh6WnllL0UxeEtSTDUwNGUxbTFQOXFwTmY3VjFocDA3WWhw?=
 =?utf-8?B?OTFUTEMvTFh2MFk0OE0zazRMSVZBWkdZd0NUSDJMZTFPaEVkc2NoWjRwWDdk?=
 =?utf-8?B?VlZ1QzloUkp5bHJ0Z2hERmRRcm1pQjlUMXpRUkR2cGRxNUVkYjdKMWRkZGFY?=
 =?utf-8?B?dDVFZlFLQkdYcXdDYndyNjdPV1QwVUpBRW1MazlRY2EzMGVhdHZzNGM0MVNI?=
 =?utf-8?B?MitQcVNmRE9GaFgrQjc1NnBzaEVEMjN5b3lnZjJqVFpVdWtzUHFxODdKc3pI?=
 =?utf-8?B?L2g4OWV0c0QzTzZrKzVRRW5KM1pQODRieHZuRThIMEpiVk1VTWhlWHFyTEVh?=
 =?utf-8?B?NzNwVU1IYU9ocUc4cXQxdFZkZ0xYWXVMWWZ1dUozYU5IOFVSUVdvU0dNeGZ2?=
 =?utf-8?B?QzhsMGlNNzhYblUzdk9RMUlVOVYyK0dEN1ZQUUV1ZUhLWGxaRjU0VVMvcWE5?=
 =?utf-8?B?bC9pTmlBZ2ovT2pybGdBa00xRjEvWjlKekkraThLMXZlZGdvNi8zM0FQRHoy?=
 =?utf-8?B?a0VQTjR6WGEvOFB0VFZEMVE2MHZlckp2MTN2YkNvTTV4VS9wWDRRS2I2cDVN?=
 =?utf-8?B?TVRLTHUydXQwNklzNWRHbFhtQVk5M1FWTmN6NTh6Z1RPb3Q2MVhiRzR1Vnk1?=
 =?utf-8?B?b3VNb0Mya1BOck53Y2RKc0R6MzFiUFU1SVJBQTdYdE5renhvSVJ4U2hZSzZQ?=
 =?utf-8?B?VTFYdzZYUEpEaFQvVzdFVzVNNGcvSlVqaFkvR09FdVN5bEJFd1MzSGpwOXRW?=
 =?utf-8?B?NmZIOUZQejN0aHF0L1p5YUdHd01iWFI0Snl5ZEtDb3hJVWNuODZ5bWFLQ0ZN?=
 =?utf-8?B?MXQzR01BMC9MTkVJUDF1Qk1sNW5IYVUyNmJ5bUlkS0xHMjBUdEFXSFBrNWQ4?=
 =?utf-8?B?RjdUMkkrTnA3Z3J5RWMwZUhEMHJoZTgrUW9xNXhYOUZnS2N4b0Q3YkxCRzBl?=
 =?utf-8?B?ZEpQM0piVXVhUEVZNzZsdjRnMHpXVEYyNFBQb1B4d3IydUs3SnZpTVBHa2Js?=
 =?utf-8?B?ZEtpMXpnUmo5ZzBFWUZEK1ZQK3dZRFVOT2pFRU9obFZ5elJGNkcxRWI3ajdC?=
 =?utf-8?B?WWFlb0pPTGFMdkpjUlR5N2JFeVV1TStkVGtaMWN0N29VWFFxeEJYRSs1UWVS?=
 =?utf-8?B?aklScXpCb1hqckk5S25vN0ZiVEJHL2tnTUxlODR5bGJtc21UZGxqM0FTS1FB?=
 =?utf-8?B?cnZoVWFaNHF3WmlJT1luOVZLQnhpTXMyV3RmR3oyWGNZNXI5d1E3V3VrbDBS?=
 =?utf-8?B?NlRCZ1IyMkt4cHFKbW5vSnlNSHd0ZGFVQ2VwcDVValJDaHNudmJuM0MwODFO?=
 =?utf-8?B?M3A2eDFaRVp0b2VKdG5sTXRkQWdwNEVEd2o3NzhvVlRXN09XZ2N2M0Q2MWNM?=
 =?utf-8?B?NTU4czdiKzhaUW5Jb09CUFJZNzBSNHdkeHRUMUhZdUpUYVhJY0NzbEE4UFh3?=
 =?utf-8?B?QWU3ZWtCemhXbDRzYjI3NFBXenB1L0FzaU01dUw5TkM4aUw3aVFnTnc1QzAw?=
 =?utf-8?B?QngyalZheXhZSnIvTENsY2VYbEQ4QnBlUHA3c3RWVTk1c3RpRTdvOFhuQ3RV?=
 =?utf-8?B?MFVHVU1WRVpEQ0JJbnE3MFk1eXFaWU12OXgrdkgvaGprZTI4MjdDT3E1Q1o5?=
 =?utf-8?B?Y3ppTVVQYnpWV3RuTjdvdEJNN0c3K3k3Yzd1dWdwWm9RMGdlT2gySkhBK0or?=
 =?utf-8?B?RDhBZmVBSVkrUHJMdGNDQlUvQ3JtLzQrQUVkbHMwS01YeHk4SlF6NHlKRDMv?=
 =?utf-8?B?U3hadXFwSk1wU0J5cXJRdzN1OWNXK2Z4UVJkVFFGelZ6d1VDUzVjekl6Rm84?=
 =?utf-8?B?eFFISVJXYk9IaDV6M2R3Z1FoRnV5bFZvY0hnRzZhVml1M2RQSGs0Y2tHZGFl?=
 =?utf-8?B?NUh2OWQ3WEtFVXluRFBCK3dpYUdGOW9aalFrZXkyaHJyUHd5S1NUekpJdVp0?=
 =?utf-8?B?anlkYTBrbEk0bEJ6c3JhWGd1b0VqN2ZkMjVBQlBnK0pHb085NEZlcXRwbmhi?=
 =?utf-8?Q?gWqzE1iepd5NzvhTNELrVDM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2ef8f6-b3b4-49cd-8c47-08d9e555639b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 07:35:15.6535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2yMh2FnPJLf4VMkPAFkeNq8/clmUytcVklm2TB+T7N4FjsnTy2X52UJsBWeEFA39aocgG1Uq4681w9Zip5dmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 23:28, Minchan Kim wrote:
...
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -135,7 +135,7 @@ struct page *try_grab_compound_head(struct page *page,
>>>    		 * right zone, so fail and let the caller fall back to the slow
>>>    		 * path.
>>>    		 */
>>> -		if (unlikely((flags & FOLL_LONGTERM) &&
>>> +		if (refs > 1 && unlikely((flags & FOLL_LONGTERM) &&
>>>    			     !is_pinnable_page(page)))
>>>    			return NULL;
>>
>> ...but are you really sure that this is the best way to "fix" the
>> problem? This trades correctness for "bug-for-bug compatibility" with
>> the previous code. It says, "it's OK to violate the pinnable and
>> longterm checks, as long as you do it one page at a time, rather than in
>> larger chunks.
>>
>> Wouldn't it be better to try to fix up the calling code so that it's
>> not in violation of these zone rules?
> 
> I think the problem is before pin_user_pages can work with CMA pages
> in the fallback path but now it doesn't work with CMA page. Driver

Actually, it "worked" only if the caller did it one page at a time.
(See how the above attempted fix restores the "make it work for
refs == 1.)

> couldn't know whether it will work with CMA page or not in advance.
> 
> pin_user_pages
>    __get_user_pages_locked
>      follow_page_mask
>        follow_page_pte
>          try_grab_page
>            !is_pinnable_page(page)
>              return NULL;
>          return ERR_PTR(-ENOMEM);
>       return -ENOMEM without faultin_page

Yes, that's all clear.


thanks,
-- 
John Hubbard
NVIDIA
