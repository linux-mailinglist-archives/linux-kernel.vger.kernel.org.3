Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E964A8F68
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbiBCUx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:53:26 -0500
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com ([40.107.223.66]:17888
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233481AbiBCUxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:53:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4su0N6CUJGqG0SZ9HVQcWWoAHFC6JMd4hHDjTDcqdTZPtRQVJjKdAbHfQrMPKG4MtuBio9V2OqpM4Tirzb7jMdjA6RD5jFmKIznijr2mJYe5Sn538vtD2gkefu0fugZsp8W5BlmJGb0tnTrL61HR1lPrB9JwsLktgz1Fb5/4i8QTc4Q6OZgdClo1Or0HrIGmPUgvk/dztCbnOqUIQo+WU7tN7FyGZp54zLEqbDX21HObFBsaqTt1A5y186ykkNEbfbttIcxKrspQcH59N0l5mKQV6P5YKvT4XPIvO2RcPjICSsnoQKDwueYwHRgap3IBL0wRfb46abSkbfU/bHWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7Ih/Pn83DMrjXcDe+jNwKoAtNYdwBS23ycdsMCko90=;
 b=WQlxGf4iwAjvlE+xsEdTxxb35KEREZZfarKTBk/VF8+g4YX1kaKUKL04mzNJgEfs6AINT/5Q8/L/BtQYcfjFbPGOiN1UjXSToQQxBQq5hDNKRfrc7D//5JzLftt8EekAtJiIzerOb4aZ9b/B2fcGKO3pWx0RyN0O1ukOq861vbSTp9O6utnn71JaatMdGNeQutJmAelmI6xMHSnRdF0bEYHTqWmA9uG8IE9M/qw6hz2wntyIadHGGzjlyHEvuq+SI1ZHNWp4EhfuPp0Y8swjHXHGrWa2cnLPScfC0K3acYO6Pd+8kE62rjJgeZGiOjMSFHbqIgtgBxyqruGJoRgDVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7Ih/Pn83DMrjXcDe+jNwKoAtNYdwBS23ycdsMCko90=;
 b=tExKvRXA4DCFtNH0ozrIachrSbAPpX68uSq56I8twUe8tHP/mW+fUmxY7qZk7GrH31JQUhmlTx9M8WzSQi0MFnb3sIGOWGJiFzozXtAj5eNiTjd+SzHPkED5JqeVuMxS8EV7A6Fq+3OHU6XxckfNDTssOqikIDMj1pl1pLgEusaM2sA5SDIIVMxrH+mcj82bzdnnTqk8Gql8x+HsriBNrCiBphFPKwuYJocb/Wi1IdzzSqGYr5BcFdBd0c5XSukEZBEc17NZcbAe68mWbzP3i8g6Jja4h0xmknT5K8ruodnxg4jJ5inK+yjN3K/ZQMD/0/MJNSBIqOC74B3wRe4upw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM6PR12MB4651.namprd12.prod.outlook.com (2603:10b6:5:1f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 20:53:22 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%6]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 20:53:22 +0000
Message-ID: <a73fbb8a-e98a-975d-613c-d88a6091a326@nvidia.com>
Date:   Thu, 3 Feb 2022 12:53:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 2/4] mm/gup: clean up follow_pfn_pte() slightly
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220203093232.572380-1-jhubbard@nvidia.com>
 <20220203093232.572380-3-jhubbard@nvidia.com>
 <20220203143114.42d59bbe@p-imbrenda>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220203143114.42d59bbe@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:a03:255::25) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce4fbda8-b8c3-4c56-8c9f-08d9e75736e5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4651:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4651694F2EF8F3F60BDABE76A8289@DM6PR12MB4651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mo9dxkJl6PRGIMz6RjyR5QVXzL48pyFuOYSHhHTW516IQv5IgMp4wsUGzeQPjGy1dsJFA0CqWIZ89YHK5ZfejkbtUUDX/dZLOTIqCNEhXX5+GFgOR5yrhob47Oi0NtBQrKYXmA8NgT6FgIvCGudrxT+8ZME6fw4hkzk6VUW9jX2by3uHQDx3X0UHb2QFUWUG6F2GNMf2Ug1hjytj/UMztn8OucXzst38ckACYPNi1qZlqK28A8nGkjctOZjDz6sqKcEwn9sjTANM7l1I7Woc9aRhlzMY0uxOyhxPtmTGQCYafFoTK+y3fv3/nRgmhfgWwvW+W8K+H4CaDrhw/Wh0nBWREGF2TBSuR73OBWqNE7F1/HgmHExaX2TgaSd7fB/tzP0HXvefCasis2J49aFbmz34wDR3PefwU1ZJdfntEg8p/1s4womDR2YTvR8WZ5H/nYhY5umH0EMXlh/V/nY9Ln6YQlDSCi07x1dt2wd4YvBD/NrtSoWh/pEdTxQfK0jmj96pxKBTSyJ6Mh/LRirsGU040uvpXGqmwQzwDvyT9llIpeJfb2IeXOzLvQdWs8KFGeiEr/uC86ZAwXFhJXWAGQgIP7xHzzls51ombMF4mw/j8YizbsJtFMFvI1UespIjvPC42Z1zERYc9CcaGR9UklhpNGqYk41AYPveFgYhIMlokebdSoYir04UytWOae9I8fAR/YsYxR69mYSqbC8Xmqm9mtjR364kfJdR2chrlVeNQMuex7WS2w1A1/8oDxz9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(36756003)(53546011)(6512007)(5660300002)(186003)(26005)(7416002)(2906002)(6506007)(31686004)(54906003)(66476007)(6486002)(8936002)(66556008)(6916009)(31696002)(107886003)(86362001)(66946007)(4326008)(38100700002)(83380400001)(508600001)(316002)(2616005)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVNYZ01TeEZHWnNBR3oxNHNTNlljcUlja3pFcXJUdmxZKytvSHM0d0FveUJn?=
 =?utf-8?B?TkQ2ZzA3ZGxxN0cwSHdrcW10S21WUk4wdzV2S2xEdmlobnBsS1pKc3VOdjRo?=
 =?utf-8?B?ZXVnK2RRSDVlZFVIOHBZL0VwYklCL3RoaFZDMzAwMnI0T2EyOGFmS1NPVU9x?=
 =?utf-8?B?NlBVZXBqMGVwQnRaZDF4dVdOU3NXT0xydWJvQ1pYL3lkcGdLZjRUSGhHa2dk?=
 =?utf-8?B?bEJ0NFkyUW1YN3ZINHFqV3ZEaTdRTzJDRmY5NVROV2RqWGVNNmNidExOdE9a?=
 =?utf-8?B?ODBMS0tVcUwvWWwrOXJIaDltTEsrWkVsMVlNZE5ZVUQ2SVRKWXJoOTF0MDVV?=
 =?utf-8?B?WG9PNnN2bEVRd2E2L2tnWGVxanVuL05xVVpOeDNyeDBGTHl5UjZnYTBjVUpN?=
 =?utf-8?B?dmdBbURzYTBiWkloQTJFa1JGSHprcVFIU2ljWFQzQjVFVW1OTXB0eU80V0cz?=
 =?utf-8?B?UGxHcEdDdEkyTmZLL01BcVp3Rm9zbnpmNENIcWJHTXIrN1dJOVNzcWxydHdE?=
 =?utf-8?B?YmNubTEvL2hVUEh2aTZpa1JBOFgrTTVKVEJJUHJ2YnJOQzRKSVF1TG1oLzl2?=
 =?utf-8?B?U0dOMFNNNVJSbGZNWUxvOFhscU5SdFNKejF4OFJLcER6WlhLWExveGdyYmNY?=
 =?utf-8?B?b1orYTI3QXR4b3NsTTVaV3VLdFpVT3luWEVDckVHOFVzbzBraWlxdngzaEhN?=
 =?utf-8?B?Qkg4S0RRSFVqdUE4SkJmS0tHekd1UERSUTZxbDUxVlNscVNhUDBGZUEveHZp?=
 =?utf-8?B?SmdvTkZINUdlSURaSDN5MlFPUFNXd0VWMEk2elhkNjQ5bnRIeGxhZmxSbmRT?=
 =?utf-8?B?aFl6Z0h6eS80MjhpWVdiWHhqRUVHYmZJeVQ0S1BKL3ZleGtSZUJjWHI1L1Nz?=
 =?utf-8?B?aDV3NzFiaUNwZS90dWtzZ1FpMnFLQXN2QUE4VmEwRXRZeEx1U3ExOHZUN2Nk?=
 =?utf-8?B?QWdDQ1RRaTZ2bDBIOURjemk2bkxUMk5yc1VkUmpXa0hDQy9CbXROVmp5TGhN?=
 =?utf-8?B?N3dPaldLMkZDMWRSWWVmYjdtclBIVFhpQkpMUUZVcDlPeFluSnVmS3Yvb0Qy?=
 =?utf-8?B?bXpVKzgwYVMwQkszOGx0TmVNS2N2dVRJMXl3cmh3K1k2akpRSklFUWd5ZllW?=
 =?utf-8?B?YjVVYUdEZHlTakM1VExvc1RORStKdFJkNmJGV3B6Z3dWUkNkam5PdjluL0l3?=
 =?utf-8?B?c05TZzVSNDBJU3JJU29DdTEvclFVV0h4TlI4aDhYekJVMERtUzZidWt5MWtx?=
 =?utf-8?B?SmlvVE90WFVaNkNZYndveDJVcGZpdG5oamdzWXpab241OGJQL2FmTjJPRDdB?=
 =?utf-8?B?TjQrcW40SjV3WjVFcXY3OHVkUzd0MXVMUUxYSTZIYmx3SGpsK0x4akhVMTkv?=
 =?utf-8?B?ajMrbTIrTXZ6dDVCczdaWU1HaWNqZkF2ajlRNHcrSHB1WjExUnBjaURxMmF5?=
 =?utf-8?B?NEVOTkFIemc3aTZjS0FuQXBubzVIVWtTZmN1eVYwaGlYQlUvOXBEZ3FtTTFO?=
 =?utf-8?B?Y2R3R0RZWXk5TEtZUm01K0ZBVFpSdGpvYzBxZ3ZnNjlCVlB5dExlaXdMd1Fj?=
 =?utf-8?B?ZFJ1THBiVG1HWm5GaE5DTEhaYjE1YjdzdWhEaGRWS3hiSGFLQ2JVQVFnMkQr?=
 =?utf-8?B?QWpyRTVnTmd5clhoN3hVYXUxbTBsZVJUMVE2ZjBYUHpWeklObVptMGVTamk2?=
 =?utf-8?B?eXpqbEM0UXJ2NFk3cUtNa3J1SnkvdjRpTW0zZFl3ZlBlK1FyNVJBQnJSMXkv?=
 =?utf-8?B?SytQRWl5UENDWi90N21kUUU0K2dUSVVINWZlaVBDVTE3K2NRdjI3dHJoand1?=
 =?utf-8?B?b2pNb1Rxb3o1YVRSd3JqTVVVSFhCZEp0L3J1cTJFUGUyT2FsUW45NlBvd0VW?=
 =?utf-8?B?WXJQcmJ5S2FKem5XcmpSVm9MdEo4YnUxS3Uwa0h4K1d1NEltOUlQcXUvaE5k?=
 =?utf-8?B?S2VBdDVyMTIwUlM5TGpqZDBVaVlRcjFPR1Q4bFRnOUpMbGpCbEVLSXdLYjBU?=
 =?utf-8?B?SWdPQmE5ZVFRNVZqaldQTDhSemIwakRMOCtoR0JLMDNmWkEzMTdjS0VUZ3hy?=
 =?utf-8?B?WnMyMGhHUUREaHIwcXQxMkNHWi91RDJuRjVqSG92cEV6ZjduTFVHQkdGNnh2?=
 =?utf-8?B?d0t5RzNDZEYzLzFzc0wwRXQwNGtYTW5NV2FvckhzWFJ1alZOMnpnVE1wOW9R?=
 =?utf-8?Q?tvzo8pr6kS3DHEGVm/x+Nz0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4fbda8-b8c3-4c56-8c9f-08d9e75736e5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 20:53:22.0851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ETnQOiFr2Fjf3FprmYd6AzLoYLr8j+iYFRScd5o8haipg2QpdC1SeehFVO6pxYSa7yNc9LomrLscqDp8H/xPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4651
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 05:31, Claudio Imbrenda wrote:
...
>> @@ -1180,8 +1176,13 @@ static long __get_user_pages(struct mm_struct *mm,
>>   		} else if (PTR_ERR(page) == -EEXIST) {
>>   			/*
>>   			 * Proper page table entry exists, but no corresponding
>> -			 * struct page.
>> +			 * struct page. If the caller expects **pages to be
>> +			 * filled in, bail out now, because that can't be done
>> +			 * for this page.
>>   			 */
>> +			if (pages)
>> +				goto out;
>> +
>>   			goto next_page;
>>   		} else if (IS_ERR(page)) {
>>   			ret = PTR_ERR(page);
> 
> I'm not an expert, can you explain why this is better, and why it does
> not cause new issues?
> 
> If I understand correctly, the problem you are trying to solve is that
> in some cases you might try to get n pages, but you only get m < n
> pages instead, because some don't have an associated struct page, and
> the missing pages might even be in the middle.
> 
> The `pages` array would contain the list of pages actually pinned
> (getted?), but this won't tell which of the requested pages have been
> pinned (e.g. if some pages in the middle of the run were skipped)
> 

The get_user_pages() API doesn't leave pages in the middle, ever.
Instead, it stops at the first error, and reports the number of page
that were successfully pinned. And the caller is responsible for
unpinning.

 From __get_user_pages()'s kerneldoc documentation:

  * Returns either number of pages pinned (which may be less than the
  * number requested), or an error. Details about the return value:
  *
  * -- If nr_pages is 0, returns 0.
  * -- If nr_pages is >0, but no pages were pinned, returns -errno.
  * -- If nr_pages is >0, and some pages were pinned, returns the number of
  *    pages pinned. Again, this may be less than nr_pages.
  * -- 0 return value is possible when the fault would need to be retried.
  *
  * The caller is responsible for releasing returned @pages, via put_page().

So the **pages array doesn't have holes, and the caller just counts up
from the beginning of **pages and stops at nr_pages.


> With your patch you will stop at the first page without a struct page,
> meaning that if the caller tries again, it will get 0 pages. Why won't
> this cause issues?

Callers are already written to deal with this case.

> 
> Why will this not cause problems when the `pages` parameter is NULL?

The behavior is unchanged here if pages == NULL. But maybe you meant,
if pages != NULL. And in that case, the new behavior is to stop early
and return n < m, which is (I am claiming) better than just leaving
garbage values in **pages.

Another approach would be to file in PTR_ERR(page) values, but GUP is
a well-established and widely used API, and that would be a large
change that would require changing a lot of caller code.

> 
> 
> sorry for the dumb questions, but this seems a rather important change,
> and I think in these circumstances you can't have too much
> documentation.
> 

Thanks for reviewing this!


thanks,
-- 
John Hubbard
NVIDIA
