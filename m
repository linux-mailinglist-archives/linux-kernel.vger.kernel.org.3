Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9FB4A91D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356362AbiBDBAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:00:02 -0500
Received: from mail-sn1anam02on2074.outbound.protection.outlook.com ([40.107.96.74]:30007
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241651AbiBDBAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:00:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lniepx9PLmLhTEV2kHJxSoJg8uMsuCV80u5hTTCwvt4dy3u7klZ9/QMLqpfkSBjsDLv/YyPP6799DR7Cqo4TGWseo+2wieCIrSrKuztbgvQ89u1X3GTu6dQsi8eUuarRcXDybyVNzp5SP/R3m2T/KakrI/Wtwk1zieODxTIHkKdUCaUqIPMsvleqayDkYhiP6t94FIA5zjjGdiQ3R5hYWoUPDuWasVEAlhTdtd0COlv5dEz9BywFMc+JTTtGyYQ/WVuoCPVLkOrNJOfqaDC7akX9IGxP07GZHZhf5XfkEBszZJrtQijkIaT6mN6boL8MAOX3DqFsqMqm81NrclzdxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LicmzguvDCiwYI9ZUOIgc8J3DsEi1I0syjPvCUM00Cs=;
 b=SgUMuhXXmV5n812QXHyawbF3sSdygECTG7Zx/ySdQ9a4B9R5Z5icHQAucBzqygAUAThpJl/nG/EEclQKWjxTTtpoRt0NEPiIp7IRIGULrzQzYjqo4qtdR+/WCrVXFd/y7Wsw/qS1fWw56SDxgeroHHdJ1aqj5oLUMrpxizU2zLO1jgA5VUrwnxmNG/ed0bB94e8JF0CIjf8+n+YiQ7bXJUWcWtJqPPlKFVDj+DCp9/jPmus8ey3P4m3WTNPMPUSC5sF4MN8Jvn0K9a3Wiz+goBFLP0sQzjrtmXIvo5tV1T15phVkySYNbsVfSavrRqPKTYvrbihA7d/GOi4H6hbReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LicmzguvDCiwYI9ZUOIgc8J3DsEi1I0syjPvCUM00Cs=;
 b=oqW6rQtnWr2glHG/7apQ1Xkt4K4l0+WsjOnwUNCJgWB0a/ni4p+nSgKwYjPrJ4PHM+ZYxLaJNSGwwaQ7vtBDN7GMjs+fPBrwW2Z8AWgt2zR/PvO2GdvvHhltr9cMjxUIAZid6IF6BwbWfW6bQd5InxzBoTMMbWxFiQHVI2SemCeIjSu0z7lsUrAoFLuZaMo9a62EPdDVZi+6jJOEhiEILWBrC9j2MZxNVud4wPLyHwewa8jc5O/84MUwohzFuJu9oH0V+RrJf+6/OH342Uh57ck51GFTU5QTCdeQiFrJ796wUptxTEWSo3l890a5ER4XsrVXFRvu3oSlGe15xoGdKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BN8PR12MB3138.namprd12.prod.outlook.com (2603:10b6:408:64::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 4 Feb
 2022 00:59:58 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%6]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 00:59:58 +0000
Message-ID: <c0f57bfc-d34b-a34b-4f2d-0d66782e4ae7@nvidia.com>
Date:   Thu, 3 Feb 2022 16:59:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Weird code with change "mm/gup: clean up follow_pfn_pte()
 slightly"
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <CAKXUXMxFK9bo8jDoRZbQ0r2j-JwAGg3Xc5cpAcLaHfwHddJ7ew@mail.gmail.com>
 <6d38ed2a-72cb-3eb6-5af1-caee61d94005@nvidia.com>
 <20220203130137.GZ1786498@nvidia.com>
 <222e01e6-bb00-51ee-a94c-089b43cbaf42@nvidia.com>
 <20220204004541.GL1786498@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220204004541.GL1786498@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0070.namprd17.prod.outlook.com
 (2603:10b6:a03:167::47) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73dc79ed-0721-4b8c-a15c-08d9e779aa3f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3138:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3138F88524C8128181B6B331A8299@BN8PR12MB3138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxvXTGZ2rybZPyCbcIg7Rf4FAFgeyG3FoXSLBViuqMY5ryzVjSLebPtM/a19FGQd5v8ivSHgKc/s/ZdWdnYzva3Cn+16pGV4YSnbmVIyWAMKmT7YvxOhPX98RJ/ihvNOs3eqR8pabSXByflo6WZJ7ohE1/JDwWFuSduyGmlip6QenfxslKUj1RBswPz8oyJAnKPndv+SwCj5xEa0WCMTiqDEPI/IgtMe2h7cdmm0XLe9mVXtCCWJJlY0cVYS/a6aaKdCobwlKvK3ogQB+z163UOA55BlwJW0U44e2iYMN0zcaMLpCEF2n+B/pZwNHa3heSLb8EjuRHFjg7nvcf9PizpnkF0BQEtAN3Td8BvRF3kvHr7Sigm8Lw7UWflWZUubSgXFBCyIjd8dCszALiN56v54W6cRvHrm6dH5wllJ7mvbOw92y6FADeWmIouVb9HWNNOkQsLhTZtA6Y7k0KeM1ZcAXj9kLXP+G/pzVImKLjXzXnpLhWeOn2FH3QSaAPk0aPADrGQXCVikREUgEXFtyuKvjm7o3l65O+SeMwbty4Mv7K/r3rJOFgPtDH2XDvB0Qc6rg0gbv9bNxqWvussEm+HGMks6yTJiFdBmD3hblDGV4jjUwXCom+lTyoF0v2DEAhcvaQgn0JjqMPHOAavWjA7TegIJHY/xJSxHCSZzrVkYpc3uihduFTiVGTyTbsZcIJA7k8tCwhHfWcTM88xLVYg9gaSeHhHoCq1jy6ldntOh2T+wk0LoqNpfOWeVCWv9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(66556008)(316002)(36756003)(66946007)(38100700002)(6486002)(31686004)(37006003)(508600001)(66476007)(6636002)(86362001)(6512007)(8936002)(186003)(26005)(6862004)(31696002)(53546011)(5660300002)(7416002)(4326008)(8676002)(2616005)(2906002)(6506007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlVtYWRYdnJIN2hMdFlBY2xjWXNSUS83UmdFS2VYSHVxNHcxWHZwRXEvdmhZ?=
 =?utf-8?B?Tk9JUmwxcEFzUFQ4bDFnU250OU52ZktpWExrUTZqbk9idUF3cUdWNHpEczlM?=
 =?utf-8?B?cmVBMWdmb3h3K25CRS9XeDNqd01HdmFSdCtjelN0YmpVNTk3cWhPWUJDZUZK?=
 =?utf-8?B?ZjZLbGZWNVNRdUpzMFRBNjVNMDdVbGdwYjNIc29TVmxxcEJTbzdBNjVySFZU?=
 =?utf-8?B?dENsWHNRNXJUQmNJeEZYdUFXL2NuNzZHd0cyd2FaMUg1NFRyeWVkYW1pZGsv?=
 =?utf-8?B?U1AwUlM0NXhEUUNRR1NGUnZHdGlhRXl3SkJ4VTJ2Ulc1MUxQZHd6TDJxclNu?=
 =?utf-8?B?Y3BUT2RiU2JSZ21YckZpWVcvSUw2dDZDWm9iT1BuNWljVzJ2OXcyQjhVYkk1?=
 =?utf-8?B?cHV4aTNRTDJVUXRCQk1FWEhHRWlKOHZ3ZElWdjdsd3hGZFFsTWYzYkZyVU9H?=
 =?utf-8?B?ZUE2MENIYXpnYW5McGpjMWNOMXlUd3doV2JBZWtvQmNKZy8xTkdxTHRQTm9t?=
 =?utf-8?B?UG9mcUZmWTRsdGR2VUJLSi9lZW5qWDRLZ2RqaHpYY0x6dldWZmxma2tNVHYr?=
 =?utf-8?B?SlExVWU5Qk1pR2FCMkpueDVPTGtnRTNNN0tabUNRRUtmeEZCRE9qV3NEWGNQ?=
 =?utf-8?B?K2k4cXJsY290eXd0M01TR05xMnFwRnNrV01HcTdBSWd1ckJVT3BaWC9Eak5L?=
 =?utf-8?B?eHozSGhnZkg0RVM0WHlzQUwrQ0lRVjRrRzh5ZnRncjcrMGQ2VGc2MkkzeEMw?=
 =?utf-8?B?dTRSREt4dlgzOUh3OEpYT2pNbUtKR1BqYldpWVZMbVBuUFRMc1gxOUdyM0pz?=
 =?utf-8?B?QzZUVE1kbG9hWWlMc0NRV1hWckVBZHZUelZCYm8vLzdnSk4wOHd0SkJvcCtG?=
 =?utf-8?B?ZHBLQTRITm9DSFFLQWZjNm5sVW96ampvVWVtWFhpZEsxMjh6NG8zaU5hVExH?=
 =?utf-8?B?Vi9NRzRpRlBSYUwzUmxJNVVRaTM4QnRha1VRbTFpVWZTYmNYWjFpSmwrTkh6?=
 =?utf-8?B?bk9jWFNlYzZndmxLYjVLUDlWaFdDL3NSaytMS1JLN3BPRlFWRVhHSjIvMDhC?=
 =?utf-8?B?dFFLL3MvMUFYZXRhdG5GZGhIOThlb0pQMDhlNmNMU1VYZXJZaThNVjQzTlFN?=
 =?utf-8?B?TlpHaXRYU3o3dmNEZGFKWlpSS243aXg3V0xCVnFkMVFXdkRMc04xb1VPWERF?=
 =?utf-8?B?eUpzaGVaY2IzYUFGZlRXMFJCOHN5ZkMvNTJ5TEhIL3JBMFpoYVZSeDh0Q3d4?=
 =?utf-8?B?ZW44ZkJCVjJVRW5VRHNlS1ExbnZCM0QxWnFCbTcyRzNjN0QyM0NGbmpYREI2?=
 =?utf-8?B?cjZFMUdFZDVVWHNZZnZxVGVyOTgrSzN1V2hXeGFqRE03YS83NUZXY2x4Z2FB?=
 =?utf-8?B?MmtrcVhOWlNvQmM1dGZCcE5CWmZFa2hWNUIxVzRyeWIra1Z0aWR2L1BpL2xz?=
 =?utf-8?B?b2J3WitXT0F3SzVEUStrdHBxUTZOQkRnS1Rvc2NIVFgvZVRYRWVRRjUvQ1R2?=
 =?utf-8?B?SzZkQXZHdDY5TU9Vd283czl4Q21oejlSUVBPSDV1WFVDdjBBR1VUMHNhdTFx?=
 =?utf-8?B?MmxEVUU1VzBlelhGZy8wV1AweDBQQWR5dVR4NlpiSmplYlZvTmJRbmVrM0xn?=
 =?utf-8?B?ZjVuQys4b24zWVFtLzEvQ2lGRE5Lc05BcC9VM29jeGlkK1pKTmRPZzl2SmFZ?=
 =?utf-8?B?TXZTTklPZFVUZ09pMkpBWG1ObnVjaTArSXBUY1RSaGgwbkZJZ05qRStrT0R0?=
 =?utf-8?B?UzN2VzR4ZTZCc1RhemhzRE4vTmlRSDJkNFF3Rm1jR21LWjVTaGJYYVA3VHNm?=
 =?utf-8?B?d2Q2OWM4OUdaRnFkUFhFNVJ0akltV3FRd3hMRURwOVBuNG9UaXNBTG9seWdz?=
 =?utf-8?B?bWxQZmFqTS9wYlJqOENsYzdzOThoVko2bXZ3ZU1QR29pcGZvL0xyT09icHFR?=
 =?utf-8?B?Zm05Mk1BQVh1TWhBQWkreEJDczFkeDVKYmJSWWRMaFMveTFiSEhPRDJPNDQx?=
 =?utf-8?B?S3pnMStSdDZPUHhLMVYwZUUxZWk4cEdtUzlmTWVrNm8yWG5VZmFHOThoVzNM?=
 =?utf-8?B?M29RRHdUWUZpSmRhSTI0dUJRSlF2RTloMFArRzd3eHN4UXFRLzdPcG5PMnFL?=
 =?utf-8?B?SFhOYXVaVXJWMm1LMkJiOW9HUkZqNjZPLzlLQk9SWWsreEd1WFp5N0doTFVx?=
 =?utf-8?Q?xcozplK9wOEslf0LLxRaSvQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dc79ed-0721-4b8c-a15c-08d9e779aa3f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 00:59:58.4554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmBQA85PxpHyis92YV5OGM1D3LG8J1+QyxHjIU98jvI7XjmqPK7c41/GQex/E4AeQGYHGQZ9u2h2TG2RFz2s+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 16:45, Jason Gunthorpe wrote:
> On Thu, Feb 03, 2022 at 12:44:57PM -0800, John Hubbard wrote:
>> On 2/3/22 05:01, Jason Gunthorpe wrote:
>> ...
>>>>> In the new branch if (pages), you set page = ERR_PTR(-EFAULT) and goto
>>>>> out. However, at the label out, the value of page is not used, but the
>>>>> return uses the variables i and ret.
>>>>
>>>> Yes, I think that the complaint is accurate. The intent of this code is
>>>> to return either number of pages so far (i) or ret (which should be zero
>>>> in this case), because we are just stopping early, rather than calling
>>>> this an actual error.
>>>
>>> IIRC GUP shouldn't return 0, it should return an error code, not zero.
>>>
>>> Jason
>>
>> Errors work for single pages, but GUP is a multi-page API call. If it
>> returned an error part way through the list of pages, then callers would
>> have no way of knowing how many pages to release.
> 
> Yes, but that is returning a positive error code, I said it should not
> return zero.
> 
> When it hits an error with pages already loaded it returns that number
> and the caller will then do gup once more with the VA pointing at the
> problematic page. Then GUP can return the error code because it has 0
> pages on the next iteration.
> 
> It should not return 0 here when it got an error.

This is perhaps better API design, but it's not what exists now. The call
sites today handle 0 pages ret value correctly, already. There are lots
of call sites. Is this worth changing?

Also, to be clear, are you proposing just handling zero as a special,
or something more extensive? Because after we get N pages into it,
someone has to unpin those pages, and it's been up to the caller so far.

> 
>>   * Returns either number of pages pinned (which may be less than the
>>   * number requested), or an error. Details about the return value:
>>   *
>>   * -- If nr_pages is 0, returns 0.
>>   * -- If nr_pages is >0, but no pages were pinned, returns -errno.
>>   * -- If nr_pages is >0, and some pages were pinned, returns the number of
>>   *    pages pinned. Again, this may be less than nr_pages.
>>   * -- 0 return value is possible when the fault would need to be retried.
> 
> I actually don't know of any place that handles the 0 return code, or
> what 'fault would need to be retried' is supposed to mean for the
> caller ...
> 

There are quite a few places that handle a 0 return, and they understand
that it is an error for their case. For example:

static int non_atomic_pte_lookup(struct vm_area_struct *vma,
				 unsigned long vaddr, int write,
				 unsigned long *paddr, int *pageshift)
{
	struct page *page;

#ifdef CONFIG_HUGETLB_PAGE
	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
#else
	*pageshift = PAGE_SHIFT;
#endif
	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
		return -EFAULT;
	*paddr = page_to_phys(page);
	put_page(page);
	return 0;
}


thanks,
-- 
John Hubbard
NVIDIA
