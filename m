Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E6E5ADD2D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiIFCMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIFCMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:12:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD4F3CBDA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 19:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAh9sSrHNJDTpoRrOpthhFZtW1mt/9FXQlLMH4D+uktKDWv/XUshYUJTderb0M6G/rci9E7l2RYYNIhwp9+EgRtf9gqwwAF+JEcLHI0lR2XCyEaS1oFQOxaTjqOZKOIznv/zdyJ7zK2fL87RPH6kqxekzhjumKRNo4MOmt++jEGRiPRgPn7BFf9GtTmL/FWna41Fg8ep1K6lZsup8l3lTfphqtD6j8MWkEUFhnkygonDxk8UjC4y95xDi2bsUHYBWqH1+uL/UxLRgxJC8ez829QLY2PGVguC7WdA/Uqe3zmVobua0eaVAMbpIKqG+WGoBSY4F8SIV/blD+CoEyZOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaVOBtHLQIj8FeQfnEa/Lhb4QBJKx7mW003IzhhbgCU=;
 b=faJxsrU7cCYXf9GL4YeW1x8coGN00ObDtBAXubiTRU+Hik+jmVF0+t5nvadxg1x6VCSuV0Mc8m5UXUARsBOmZU1tQESR1gH9x+MmLCnQoJfOPVKYqcBhoKVnPYYfcMwvNgHSI2OMTNkiSnslUeB2bCx7eGKI//YXbvYz65cq5pJbIv4PmVHris0vjpdeOSedTYT11usSAdUed7b58ll+qdAKsiGJAkh6PGyjt+grdPGYRZVRDylNpOiP+MkX4ecOW+jCOak+ru5t2v1G2ihyMfNwxiBu3Y1TsUQ4ngRPfa4EMr3ZzT+KOEF7skelwDHEwT9+V2GI1S1iVHZgadr/AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaVOBtHLQIj8FeQfnEa/Lhb4QBJKx7mW003IzhhbgCU=;
 b=OBzOalda5wKdZc6Pkjk7ySwnBiqKDYJNnwYLMfsp49v8NuKHxXqi6wddhc6g0LW73hvEmOfRyt+bDFNCLmpZBcPCEPndGorjIAxQ0vn0Ad96bgxsDZQy5iH4NdEwL8Cav8C77hFyjcIyH5qNGc+0SZRgZ/AzBIzZF2I4iEfI9nlPQNgNLY92d+1eLwVKP+w1pYoqkeYLRGcHNvhBMD8V3d18fluai8tKjr0zahq+ykEwPui3WzLHjbZKXuAIvIJbWDQU96/whVub4WHVW5D6YZVb4rhJbX7G/Q5qNqKFBXJTqNQ1L+ReDnyWtWNkBRqBbJPj5P1pg10P9ArVoyVU0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH2PR12MB4970.namprd12.prod.outlook.com (2603:10b6:610:67::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Tue, 6 Sep
 2022 02:12:34 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 02:12:34 +0000
Message-ID: <c38494f0-1bc5-61e4-8459-be9160029539@nvidia.com>
Date:   Mon, 5 Sep 2022 19:12:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, peterx@redhat.com,
        kirill.shutemov@linux.intel.com, jgg@nvidia.com, hughd@google.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220901222707.477402-1-shy828301@gmail.com>
 <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
 <a969abc5-1ad0-4073-a1f9-82f0431a0104@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <a969abc5-1ad0-4073-a1f9-82f0431a0104@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:40::34) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c7c39c0-0c95-4ef1-3e25-08da8fad42c5
X-MS-TrafficTypeDiagnostic: CH2PR12MB4970:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbI+yG1zXcxJYxN3MrG38jH3XWTW3448E3MiCYLY5PaynmifjW7TVeDtPmKE+ln5+0MK5i2iKTRLflfT49Nu9VnV1HVnmLCSPFPuJKhdUxkTWODEkydegKDLMDs86ahnuDWst2w0Tjz1B/eOuiHrr4C9oGaO7PVKYsVgt7C+85jPiRgYyb0FGQaPwGJZr/9p2JHqQnLqHovFKsCtze8oC+EFH9CBP7SgbYxVWJVvN9bIUYe057ldKNDQaIO+nJPdLGVmcSAxM0b/z5TPmN3G/RVjTZt5XhXSWuxjxJS1WVxevFisJncxJEAzQgCJmOapZkbYhC1bzyGEtAiIMxw/u3B3guscm2P1JRp2oSUCnBcpFB2RoKHtkJCyAUi43lIh6QvSx+bS/dgtfaLMhrB83VYtg1M2AmYlqfhq1VcOrmyUvsEhZLgOPDwUj6wfu292Vi9pQs1CRmEb61TQWDUSBYe+Aq0m7MX06Zn45wQTbbhWATFe01+GTKCTJPmMvjRtvOnnLPRl279+5e15+DXYk3iS0d7CYWHkb0mM/zIIGazUKqwKvM6jfZ2LrZUUBCKjNO80PGcVXaIGCanQ+3d5TL2CjSPxcd+dBJg/vq2RXxjcZoU7qvkqcpDqkftrAsN3FGQsKPwF5kQns+K0iTTAOlCupSclnk2fjPQ1BdaDV7smPo/Uj7ccnHHXt+767fjzPXnImd6vdGGfFLBq6FDKw76s/cSPOKYFl/pTHW1mNsargH7uLlW88dm1Xh9eapdapcactS9PBHjcwZTwt3WVL85YnAHwefHnhz2rbzXJGyU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(110136005)(4326008)(66946007)(66556008)(478600001)(6486002)(8676002)(316002)(5660300002)(8936002)(66476007)(2906002)(38100700002)(36756003)(31686004)(86362001)(31696002)(6512007)(2616005)(26005)(186003)(6666004)(53546011)(41300700001)(83380400001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WElicTZSNUo1MHF6ZVAxZmZwWjlHSk1UM0dzSVZnSHlHZnlvTXdGVFM4VGE0?=
 =?utf-8?B?aENEU3o1bXZRSUpNV3BlK3RsNnJnOFBpZjZ2SzkrQmw1WnQwVkhPakJQeURn?=
 =?utf-8?B?SVpwWDhTMVN2bEZ1RjY4bmtFQTEyN2NOSTZTT21mbEJSNStPS2IyNStDV0JE?=
 =?utf-8?B?M2NjQWJRZng2NzdLeHk2NTdEdkwxZkNRcWVQU1NteDhxejFwRnRrMGJ1dUJm?=
 =?utf-8?B?TS85bG5yY0ZReDlZVldPeG43VmNWb3pjM2hsYXR1NFNUMDhHSUwrUmltcnli?=
 =?utf-8?B?MVVQM2sxQzFKMVNKc2RaU0NyVW5SVmJ4NjQrS0FyV0xHTU5WcG9iY1oxb1N4?=
 =?utf-8?B?ZVJBSXc0ajNxS3lTbThHR2dFdW5qSEs0YjV0dElvQkUzSUlRUTVzQm1reFQw?=
 =?utf-8?B?TUEzTFhuUTFyRXZuMHpjZ2FwT1ZkcHZZYkFzVVA1aVRmZFluUXdoeHJ6OERj?=
 =?utf-8?B?UFA5TzByelZCcjNtSS91aHJhMjNxRnNTb1FZT3BRdXFuaTBmSitwOFpVN0g2?=
 =?utf-8?B?c3RHQWMrZWJ0eEswRzVzZ1cwbGU1UzAydEFva1gvV1ZJVk9vVEV1RmR1S09n?=
 =?utf-8?B?Ykh2UjNZQ0JkR1VpbnByV0lSNDFpeU9DblFYeXdhOEp2c3NqelZub3lia1JU?=
 =?utf-8?B?MmtlU2thYnB1enN6dXQ2cHBVSGIzT2J3ZEVncVd4OFNLbDd3eVErYjdtdTdp?=
 =?utf-8?B?cEZlZk5GS3VtR2xRNXArY3VXa0g2VjhFdkVRSVpudDl2ZkdKOUtiMm9pSGlU?=
 =?utf-8?B?cm0wVnFGZ2dXR0VJUVhaZUMyTFdGaWVLZSs1UHByZXozN0lTZmJOUlFWU2ll?=
 =?utf-8?B?cFZQL25qcjhJYlIvYmJUQVBBbFJ4cjN6cU1uNW1uZ1JOVkcyY0pWUm5sbTVX?=
 =?utf-8?B?TERKT0V0dEFhVUlUSWFJQ1FveFlMTGNkclRXckhyRURDYXQxKzkyQkdZSndX?=
 =?utf-8?B?dDByd3hUeTEyTUo5VTBPVUttQUJESXJwQ2hpU3Y5VjVidlk2a3NYVE51RUQ1?=
 =?utf-8?B?MVk5OXl6U1BNVGJqck9Nc0lzL0RNbHpYOTF2dDEwY09mc0o4OXpGVG0zR3U4?=
 =?utf-8?B?RE5YYTNQalVsTWxKc1RCeXNtSXUyeWZYVCt3cHhQU0JHcWdTZk82VWxGUENR?=
 =?utf-8?B?OUMwWU5YYVJ1RmVlRytZYjBuODdSMHhLbEU2d2ZBVTJUWVBYbWlsSm9HTWJU?=
 =?utf-8?B?dkJETXRPVlI2NE85dUJSRERoL3E0M240SjNuZnhzRGtUSHUwOGxVek5DaVN6?=
 =?utf-8?B?THNpZ0pIQ2hIUUQ2UFVyQ1RaRUkvR3RWRHNkOGlHUVZ5QkNUNXVsU0F3UlRS?=
 =?utf-8?B?cnQ3M09rSWdoMWdFdXFrVnRZN2Y5cGJUdEF6SXJwZm9xYmRKWmFseFl0TjBq?=
 =?utf-8?B?OVhmaFlHeHVYdjRsZVlPUWZoeXIzTlN0Mmp6aDNhWXhmZXlITnNWbHpzOXRn?=
 =?utf-8?B?eDhtWEJuY1hjc2VlRFpSeWsyOGxtQllQN1lkN2hqcmpBSjE1THhxZGZ1aVZ2?=
 =?utf-8?B?N0ttT1JXQXRkQU5RZ05rcWJZTnZjcnYrdUE1OFNYUFV2L0xYL2JKVDhZcFh3?=
 =?utf-8?B?Um8rUVFObXFQZytlSDMyd1JGSWtPMWpvUUJTUDZuQ25CNWs5WDEwaWNRKzFM?=
 =?utf-8?B?OGVtd1FjUkdNdlR6Q3Q5SWE2aTYxZU9FdVVtL2drZDJEaEgvMzVJYW8xZ1RZ?=
 =?utf-8?B?OUVzcy96eHBWT2pseWU3eVdlSitoMGdsQlE0RXQ5Uitka25lWE1xV2VNYTRm?=
 =?utf-8?B?eVFHc3poMDhheFRmZUh6NWFKcHdvc0txdTlvWGo5Uk5ZZW1BUXRIRHJxTEhr?=
 =?utf-8?B?OEpRVTlzWC95Rk5HaE5CSjZ6QjJ2bmNHKzV4RmJkWU1aVjNEcjFjWVJYMWdj?=
 =?utf-8?B?dXpDUVp5bHd3RGZZbEFIckQzVG5CdXg0NDBFSTNUaXJzWFVOMnJReERTVDg1?=
 =?utf-8?B?RkFCL0VlczBzUUFhQjNQNDBSajZaeE9aYTh4M3crVXFWNGJkbnZ4U0VtNXQw?=
 =?utf-8?B?QURXaEtibVMwQUNSQkxmUzE1cmVwaUQ1c0RaMkc5bks5VzBFd3E2akdrMzVM?=
 =?utf-8?B?SHlDeVJya2RLbDZXZjVGSzFsVWk5T2ZNU0JVRytsN2cwREd2OGNLaEYwNy9i?=
 =?utf-8?Q?HC/u0QeOl6X7dF6fR6vIxbFtv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7c39c0-0c95-4ef1-3e25-08da8fad42c5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 02:12:34.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNWJXR+R0TiwLI7j+u+Wa+Jd+ZfNRcVmIVEfaRbKT61hmjI/yDHmVX3+I6PwxIcQLru766HTlQVpPWqYDnnapA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4970
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

On 9/5/22 00:59, David Hildenbrand wrote:
...
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index f3fc1f08d90c..4365b2811269 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -2380,8 +2380,9 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
>>>   }
>>>   
>>>   #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>>> -static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>>> -			 unsigned int flags, struct page **pages, int *nr)
>>> +static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
>>> +			 unsigned long end, unsigned int flags,
>>> +			 struct page **pages, int *nr)
>>>   {
>>>   	struct dev_pagemap *pgmap = NULL;
>>>   	int nr_start = *nr, ret = 0;
>>> @@ -2423,7 +2424,23 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>>>   			goto pte_unmap;
>>>   		}
>>>   
>>> -		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
>>> +		/*
>>> +		 * THP collapse conceptually does:
>>> +		 *   1. Clear and flush PMD
>>> +		 *   2. Check the base page refcount
>>> +		 *   3. Copy data to huge page
>>> +		 *   4. Clear PTE
>>> +		 *   5. Discard the base page
>>> +		 *
>>> +		 * So fast GUP may race with THP collapse then pin and
>>> +		 * return an old page since TLB flush is no longer sufficient
>>> +		 * to serialize against fast GUP.
>>> +		 *
>>> +		 * Check PMD, if it is changed just back off since it
>>> +		 * means there may be parallel THP collapse.
>>> +		 */
>>
>> As I mentioned in the other thread, it would be a nice touch to move
>> such discussion into the comment header.
>>
>>> +		if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
>>> +		    unlikely(pte_val(pte) != pte_val(*ptep))) {
>>
>>
>> That should be READ_ONCE() for the *pmdp and *ptep reads. Because this
>> whole lockless house of cards may fall apart if we try reading the
>> page table values without READ_ONCE().
> 
> I came to the conclusion that the implicit memory barrier when grabbing 
> a reference on the page is sufficient such that we don't need READ_ONCE 
> here.

OK, I believe you're referring to this:

	folio = try_grab_folio(page, 1, flags);

just earlier in gup_pte_range(). Yes that's true...but it's hidden, which
is unfortunate. Maybe a comment could help.

> 
> If we still intend to change that code, we should fixup all GUP-fast 
> functions in a similar way. But again, I don't think we need a change here.
> 

It's really rough, having to play this hide-and-seek game of "who did
the memory barrier". And I'm tempted to suggest adding READ_ONCE() to
any and all reads of the page table entries, just to help stay out of
trouble. It's a visual reminder that page table reads are always a
lockless read and are inherently volatile. 

Of course, I realize that adding extra READ_ONCE() calls is not a good
thing. It might be a performance hit, although, again, these are
volatile reads by nature, so you probably had a membar anyway.

And looking in reverse, there are actually a number of places here where
we could probably get away with *removing* READ_ONCE()!

Overall, I would be inclined to load up on READ_ONCE() calls, yes. But I
sort of expect to be overridden on that, due to potential performance
concerns, and that's reasonable.

At a minimum we should add a few short comments about what memory
barriers are used, and why we don't need a READ_ONCE() or something
stronger when reading the pte.


> 
>>> -	 * After this gup_fast can't run anymore. This also removes
>>> -	 * any huge TLB entry from the CPU so we won't allow
>>> -	 * huge and small TLB entries for the same virtual address
>>> -	 * to avoid the risk of CPU bugs in that area.
>>> +	 * This removes any huge TLB entry from the CPU so we won't allow
>>> +	 * huge and small TLB entries for the same virtual address to
>>> +	 * avoid the risk of CPU bugs in that area.
>>> +	 *
>>> +	 * Parallel fast GUP is fine since fast GUP will back off when
>>> +	 * it detects PMD is changed.
>>>   	 */
>>>   	_pmd = pmdp_collapse_flush(vma, address, pmd);
>>
>> To follow up on David Hildenbrand's note about this in the nearby thread...
>> I'm also not sure if pmdp_collapse_flush() implies a memory barrier on
>> all arches. It definitely does do an atomic op with a return value on x86,
>> but that's just one arch.
>>
> 
> I think a ptep/pmdp clear + TLB flush really has to imply a memory 
> barrier, otherwise TLB flushing code might easily mess up with 
> surrounding code. But we should better double-check.

Let's document the function as such, once it's verified: "This is a
guaranteed memory barrier".

> 
> s390x executes an IDTE instruction, which performs serialization (-> 
> memory barrier). arm64 seems to use DSB instructions to enforce memory 
> ordering.
> 

thanks,

-- 
John Hubbard
NVIDIA

