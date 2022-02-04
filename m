Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E884A91F9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356272AbiBDBWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:22:43 -0500
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com ([40.107.92.77]:47809
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229972AbiBDBWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:22:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtOTa6IEwoHmljCDUhANzvA+QgeIgqKDZObTyqZ+NYdwb/Sf77mWGx1WqNhG/ym2LsK5xDTYrdyFa7WDBM/MjAdbRTothfuFZRWVQj5svaFb7XASkjja6RDRxBW3BRN03qWX4FA+6rojGVsMmhBJThHka/PTMv6d0m9DRoUgsyqKFHAwyOBOsC4oO09mU7L6qG8C+05GRebS+8ohu/OJCdiHmNcWJNb6rRzJepEmsAhBGmMw2Rg0Ls5pCnyLudgncnjkum+J3SAZhPCpONAzcDIDLPb+XjsnR85J9kAjYrT6W4nSICxJhiqdPZhjWTn1XdeAiE3jVlHRUz7wv3FlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lq4JZawsqYIMzhsyftcOVZcgFTd1uHmBoOUMrEvjH6c=;
 b=dsoo/HIF5QaYow3mzPwFv1iJj7spIfIU5CQb6AuqtEOI+YjOIPTQw97cqzRG/8pcMfLYVvmgERpw0Iw1wftHpbMgrDBV5fSgK25HKZQ9jIz7TqlkEVuPxVobQzzm0jgf5GBQ2rHtrpk3hLFCUcMR6PoQa9SWrsFt96i8hTfAYJseUVpP3YRP6yb72nMDNR/eVPm0gedWYw0o85cgodLjiD92kozogotISbw/7oQz4AETGwwTij7VyvjL37SxbH6/7+UV8yomn66o520RNtqPJCVD5u5fI2BIVb4zmZS1chEspmPKqTPMrryZbXt6mgWFtwrsi1W5y4NhD71ETv5xeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq4JZawsqYIMzhsyftcOVZcgFTd1uHmBoOUMrEvjH6c=;
 b=Ct5NZWSrHsfIb2i4kSoZCIqebSKtIkG6BYnQ43q0wgoeQc44Uzl/ZV5rAXZZcSGj3MVwdiPH0XvKWE83QECLK35nJYkquwne7gYJNCil8lVMTTN80wunw20H8q/DSqA17tp3GJVnaCHQxwFkxuyYk1g42eR1ilzYUBY8n9ZG37Ljne9DHe884srCNEiUDIx33EiLkirUc2gSjGd1Ae8kRN7STAHumzdXPuiLB+IanBevJ1D4QsCIT2STUo1/YI4gpjMW57LQjFE9Ph5+GcK/x903uRMcNOk/zCl7TAP6rSExUsiRkh+mCA3F18di7O0NP0vhK0qlnvFqqmcLslVrXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY4PR1201MB2548.namprd12.prod.outlook.com (2603:10b6:903:d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Fri, 4 Feb
 2022 01:22:39 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%6]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 01:22:39 +0000
Message-ID: <afedd0c6-23c0-7e79-3b14-48fffaed7f99@nvidia.com>
Date:   Thu, 3 Feb 2022 17:22:36 -0800
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
 <c0f57bfc-d34b-a34b-4f2d-0d66782e4ae7@nvidia.com>
 <20220204010612.GO1786498@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220204010612.GO1786498@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::7) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6908130f-1da2-46cd-c3d1-08d9e77cd531
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2548:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB254829599D3034B0B2F8BA57A8299@CY4PR1201MB2548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uxFUwTtWOJMRXpPSxyvZxGkADSmysb2sCBGxvHnyObIXhpdxIR8TZrN8WAYtUZsG4xVapjwKYalm8qmthnKYy40TkEybu4qMh8ln8aYlZo5RtP/BHlejK5JkOWjzvfOVDjbV+FDlr+ye+BKYOLg4XmNm3NqiCF0BOGyLG09Lss8vLjqr10v9fWGa2jc/pqRaxJHeeYic3kLb9EOCvr/wHZKeP4ANfiBBB4H2NSr/lUHHP0XvlhZvMezJMdu6D6Q/wW18K6B04ilVAeYXVVUWrayGtuuznZQKoVQvbTZh6r/NLZm7dBXjchgWtFCrtKz3Gu4njXfxqS3ufKqLPmjq2/pt5RBDlSKTmNTId1dxKsk/f/nSVStDDG37Y0ihycJggxbPtn+DqAjn10rvqqrhCGjPPaqxy8lRUG/BfMhPiXN6u3F/mX/E2qPlpOeAS8qlTMccfjZQ8e9xXC+zGtggxUp5iXd1DJFZwz93P5AXFRd+hz+KTP/hokeEyz4lIlORSTAkdA4JSYhM+dg8G/f3h7rehuPsep6gfn8yWwmr2CG/xEUPIOEONwqLV52dY6g8uI/76CeNRZvElWVhDQrVuTE8Pz0+TkXZLDKfav7Hu/u0Nq0wKgnxvqms/zyGShR6FrEr3P/Vv2WyjQXJugLvhXMPDncjyr5C1IbyuXOhAN5vt3JW94fiPj6T7NL6O+Ehk1UIoj92723uei5Xocpe0uHJvonADl7N9jA/b/gSTCbB8MlHsLQ/hOJ3zKQNKixf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6862004)(36756003)(4326008)(66556008)(54906003)(86362001)(37006003)(316002)(6486002)(6636002)(5660300002)(38100700002)(53546011)(66946007)(6506007)(8676002)(8936002)(31696002)(6512007)(6666004)(7416002)(508600001)(66476007)(26005)(2906002)(186003)(83380400001)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3JLWU1xcEpZQmRobGc0Sm9oOWVrYTBreUpRSU1aTGVlSDFqc2g0NjlFSi9T?=
 =?utf-8?B?MVNBZUhNQllaRTlZMHhxK2kzdHRQempIbHNUU2pDZ1RJMlB0amhHalFOMzFm?=
 =?utf-8?B?b01kaDMvVkc5bWtFS0pldWJ3KzlpMjdDN01TNHI1UldXK0RiQkIyL09Ob2o2?=
 =?utf-8?B?VTZwWGowQ2F5WHBQV0pWNkpiL2hNanZBd243NHZpcVpza0hHbHVNR3NXUlZk?=
 =?utf-8?B?dVN4aXFWZnVhMXhGNmxjRW9rWElYRTJrcUplbnlJUDdjRHU5RXQ5NkJvaDNi?=
 =?utf-8?B?VklZRnk3K3JGVW5zTG1vT1d3OWE4MlZTSmphWnRPcjVvTDBnTnJJRzFsSzBE?=
 =?utf-8?B?c29hYzU2Tm9uMkM2dTczWlRHTjJlUFJsZ1lxa090NGN4V2F6TFJHVnZBaVk0?=
 =?utf-8?B?K0M5Qm1zZnpEQUEwbXhsaDZETTZtMkFScEJLN3hndE11dlMrdUdsTzFzby9n?=
 =?utf-8?B?TFRtYVlaclhQVGFHNWRLdVhRQzFoUVlPc0h3c1VWeU9xa0R3V1JKdURKdmxU?=
 =?utf-8?B?L1I5UDJiT3U4d0d1WGRBSC9ya1F2U3VOeFlGMlVla0JGZWkwbFFmY3U4eE8w?=
 =?utf-8?B?N0JtRG5EWGZBSFhFZmpDL0ZJeFJRdGVDWHpabkFXZ0JGSHFBSjJjVWRWNEJO?=
 =?utf-8?B?SjNrVmxueGxhVE9sL1ZIRzh2TE1iRlNpNnFEbGFqS1h4dDFYcFgvb0xXOVp5?=
 =?utf-8?B?dDZETGFqQVdjc0FLZWMyWFk4S3UzNko3cjl6TXBWUUw3aDJTaUg3Sk1ieHlh?=
 =?utf-8?B?SEp2NlQ0WFFsT2dNd241dm5PcnBxMEtpd2NmOHJCNXhJMVk5dXdxbHdkWU5C?=
 =?utf-8?B?K0RGaExzK1Z4S05pRHhUTHl3MWJpVEh1UWZjU05FdngxWDVRb2xYak1kdDNp?=
 =?utf-8?B?bFJwTms0MENKVEpoQmZFWXpEVVVrNW1keWdkSGY4VnpCa1JFdGdwOEY3aDRs?=
 =?utf-8?B?VVF2TE1JSUgyZTlzUExpUFdGaEJSU0FJTk9ROTBPamtqVTltZktFRitrNjNN?=
 =?utf-8?B?elpyK1YyZjVqaWc5bTlEbnc3eTNaenR1ZERzNU9zL0h4eVh4ZEdRdzZ3ejdT?=
 =?utf-8?B?N1ZQQi9BL1BSR0FYQncxdjBRZnVhOWkvbkxkN3c4VEZpdHRxRi9mZy9hcVd6?=
 =?utf-8?B?aHdqaHZEUUpnQzJXSnZDL2dWa0RjWWd4dHQySTkwcUNNL3RnSDhCRU53Z09n?=
 =?utf-8?B?aTdrdCt3RTFzRVBCcWJpZDBBZ2doSjkzb3laMkt6L0lhbEdWSndDVnRzVzFj?=
 =?utf-8?B?QXVEb3lweDk2cFNJdnFhS1p2eUJPSDkzMjAydjZWOXdMSEhQWEd0bkt2eitr?=
 =?utf-8?B?aG1YdUtMVjZ1RVZZQ1dFdjFXYzgrOG9LcDByZkpoV09VNFRMeUxmUVAyMHdp?=
 =?utf-8?B?Q0VxSVlYeU1QWERtQStWaENJeDAvbXBMS3VGeG45Wk1LR0VYNWhhcXhZUTJS?=
 =?utf-8?B?MXdNTFJod2hyZys0cnRDNy9IZUVBdEdSZlFidkVHTTQvOUNwaFdoQmFTL3dH?=
 =?utf-8?B?ZWJna1l1Q2tiazNqSjlhcStEUWVNejNKeHJRZkRMRFUyY2hnOGxYZkNpVGN0?=
 =?utf-8?B?RWZ3Q1pCMEtDbW9mc2hKbS9zTnllMCszWk4wMzRzSlVxbEFpQnBnYWJ5VXlL?=
 =?utf-8?B?cWk3NmlGQWI0VHluYWdpL0c4WExwTEZiZG1YOFR2MnNtTTY5UGRUSFZucWJS?=
 =?utf-8?B?akwxSmZLc2pBSU14ams0ck9WS3g4R3JLbWVQY2xwdTUvTkpuNFpxSG04VlNW?=
 =?utf-8?B?MWFpdWNva0kzSDlaVUFHMElqUEsranQ5M1ZHTHpPTXhyNEtxejhudXM4aUk0?=
 =?utf-8?B?Qi9MSHhwRnJ6d1FZbDFCNDc3ZzRXU0ZhVkkydWg1MGdZR0cydFBCVGI4UjNG?=
 =?utf-8?B?T1VjYWxWbk5teDQzN0l0bVNLTkVFcjBRNlJucFpReTQ3Zi9BQzB5NmdRNUIv?=
 =?utf-8?B?TjRCMTFZcG5ZaGZkZXM3Wk5IK284RzExVTN2a2c4Z2h0L0FYZzQwRVNoMlQy?=
 =?utf-8?B?MHFRWUxHQXEwMEpGeDdrOU9qeGM5MlZqN0ZadVluYlI4TFViYjZMNmZ5eHlr?=
 =?utf-8?B?eGVoM1VSRko5eVM1TnVvVzBlVTFid1JVengvK1l6MFlhU1VlOUEzYnUwQTI5?=
 =?utf-8?B?SENRYTNNRDU3YVlyWCtFN2V3WG5SS3J5ZUNod1NjWHo1WEh1cGxnYzRZY1Vy?=
 =?utf-8?Q?uBGiMPZbD9BcGm4zg5TW6wU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6908130f-1da2-46cd-c3d1-08d9e77cd531
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 01:22:38.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEEVCztj19VQNGjrMPzfAMj5UD20v0A8pZuSqAqV4XEPK27HO4AeBx/72yjWXVfvfmL1R03dqSvuuG4OwEJP9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2548
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 17:06, Jason Gunthorpe wrote:
> On Thu, Feb 03, 2022 at 04:59:56PM -0800, John Hubbard wrote:
>> On 2/3/22 16:45, Jason Gunthorpe wrote:
>>> On Thu, Feb 03, 2022 at 12:44:57PM -0800, John Hubbard wrote:
>>>> On 2/3/22 05:01, Jason Gunthorpe wrote:
>>>> ...
>>>>>>> In the new branch if (pages), you set page = ERR_PTR(-EFAULT) and goto
>>>>>>> out. However, at the label out, the value of page is not used, but the
>>>>>>> return uses the variables i and ret.
>>>>>>
>>>>>> Yes, I think that the complaint is accurate. The intent of this code is
>>>>>> to return either number of pages so far (i) or ret (which should be zero
>>>>>> in this case), because we are just stopping early, rather than calling
>>>>>> this an actual error.
>>>>>
>>>>> IIRC GUP shouldn't return 0, it should return an error code, not zero.
>>>>>
>>>>> Jason
>>>>
>>>> Errors work for single pages, but GUP is a multi-page API call. If it
>>>> returned an error part way through the list of pages, then callers would
>>>> have no way of knowing how many pages to release.
>>>
>>> Yes, but that is returning a positive error code, I said it should not
>>> return zero.
>>>
>>> When it hits an error with pages already loaded it returns that number
>>> and the caller will then do gup once more with the VA pointing at the
>>> problematic page. Then GUP can return the error code because it has 0
>>> pages on the next iteration.
>>>
>>> It should not return 0 here when it got an error.
>>
>> This is perhaps better API design, but it's not what exists now.
> 
> I think it is what exists today, 0 certainly is not implemented as
> 'need retry' anywhere I found.
> 
> So why do we return 0, if it means an error, instead of returning the
> actual errno?

Well, now returning 0 sounds all wrong, when you put it like that. :)

So, simply this approach? :

@@ -1205,8 +1201,15 @@ static long __get_user_pages(struct mm_struct *mm,
  		} else if (PTR_ERR(page) == -EEXIST) {
  			/*
  			 * Proper page table entry exists, but no corresponding
-			 * struct page.
+			 * struct page. If the caller expects **pages to be
+			 * filled in, bail out now, because that can't be done
+			 * for this page.
  			 */
+			if (pages) {
+				ret = PTR_ERR(page);
+				goto out;
+			}
+
  			goto next_page;
  		} else if (IS_ERR(page)) {
  			ret = PTR_ERR(page);

> 
>> The call sites today handle 0 pages ret value correctly,
> 
> This isn't correct though:
> 
>   	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
>   		return -EFAULT;
> 
> If GUP wanted the caller to permanently fail with -EFAULT, it should
> have directly returned EFAULT.
> 
> 0 means 'to be retried', whatever that means, and there is no retry
> in the above.
> 
> IOW, the above does not handle a 0 return correctly, according to the
> comment.
> 

I recall seeing several sites that do a quick attempt at one page and
force a -errno failure if anything other than ret==1 occurs. I guess the
good news is that changing GUP to return -errno instead of 0 won't affect
them.


thanks,
-- 
John Hubbard
NVIDIA
