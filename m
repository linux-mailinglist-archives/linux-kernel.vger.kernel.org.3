Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941D849F0FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345381AbiA1Ccd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:32:33 -0500
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:30689
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241821AbiA1Ccc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:32:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMmxivZ/jLKRQN6M/5YoHYkAmEQ0RzT/tsByCyTOV4Hu5UAdRdaSvj6sh/ObDfoV7HksQVznsTc4Xki7Hrx+xlNHwnCF0tzvV3d1NtuZERVtMdiXFTpdV7CiB/7x+DOdCbCKZtsYHdlDCOMiBZIKwYDyuV6lJemksXr5osCAjwr322Rt16Q4woZ1rj/STvR9UF8AddD08W2Woa+3Ft6f4KlIL9ZJ1flK5NVLkFS8sWaHncU/nBo5hm6fc6/ShpicONCyH+qC7DbxvZ64JqZQmcJxuB5vmTk6ry50hNOzs2Hw26BpGW6OnpqYUEmjUIRwsGbCFeCG0vSiNe0oA2E2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+afHrFtL3z8BGCX306MNs33O/w+PYCoVMs2XoInIS1w=;
 b=m1CV8kWPiLuBPvxEE8vAS+czmSFYB+0PcnW7kYHL6EdU2+NU4YWXhQrtYe7lhjiSH4h6Op75CKk7O3A418u6dDXhlNYuwwpuEglKcqqkm3xL5h7mipriJsXZdNHQ59K4/sDM3O1dX7B9vNynFftQs6fjuS1jiXuWtCV7VWVkQW/SO50VVMQaebfZUmvcljeh5zFxx/Ck+p0LClowycOHhaegVlYwin4jaxuiXeDEZLY1I7nZK9y0diMjhGHCDyzB8FF2WXxs93BBOB2fK3CHqubjvbP7boFRwxMK+PGOve4EPSii5Y2WDwvJd9YZnGprB591I34fiQVEKY5U/6r09g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+afHrFtL3z8BGCX306MNs33O/w+PYCoVMs2XoInIS1w=;
 b=lWUeIOcijoU7niwjf/PoQ7+eFmro9BAY/umn5579CBlZSeefC76/1xTAsMiYLHuplTCQg5iS5znpXAuD/+PzuqccmA77iQdSCjW9MEJSBJm75COvesoFJ7Li9ohwtd/rQCyfgcd0mHMnOLVjjfIk/6igxbdPVtNYDtYJx+hrG5zb0uTMsGUuVFOWRlDhDdy4hpBWYjkJ0dO8yUcAnJpZcJpn20JPvpM+ABt16Syiwp8BCK/HZjyYAM+fOw2hbYURIcNzusKr7qiXIGqXwKCLxGaKh/W9VjswkUmMKcXV2jbqfdwGhjt7otqGVvasxXbmdLxl3lWlISLHy8Bz5hq0kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by MN2PR12MB4030.namprd12.prod.outlook.com (2603:10b6:208:159::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 02:32:30 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::ede5:7f12:c1:b25]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::ede5:7f12:c1:b25%6]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 02:32:30 +0000
Message-ID: <313e02c7-c116-3fe3-6747-d9e1b58ba2bb@nvidia.com>
Date:   Thu, 27 Jan 2022 18:32:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: Fix invalid page pointer returned with FOLL_PIN gups
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20220125033700.69705-1-peterx@redhat.com>
 <f5400544-f602-0bb4-5cb1-5ac682e41974@nvidia.com>
 <20220127004206.GP8034@ziepe.ca> <YfJjhop3senAUjue@xz-m1.local>
 <20220127152538.GQ8034@ziepe.ca> <YfNIjqPpty0YkLJP@xz-m1.local>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YfNIjqPpty0YkLJP@xz-m1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::27) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfa65b96-f266-4a08-7df8-08d9e2066e21
X-MS-TrafficTypeDiagnostic: MN2PR12MB4030:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4030F9FE23A1C437B2C3736CA8229@MN2PR12MB4030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZyEPCmkb/BN2WczIUcpocr3FSCAUrv7aJYdh9jMc5u/pk8LG2Bf/RoFqkvJO9Xl/lhwrpA+7LonvfILzrfhOP49/lnG7dhcMK7wLh5+oyI+LqG4VuOrZvnSAlZ2H8CJ9oTAmXR23a+yDnqyelDyxNvp1MRpl4YiMDescKCFiWJ3cNl4m4lTG0cnqXK6L+SODjy6GEUmFaPjl8WP18QZr5BVJy8MvgmRpdozC5qQVmzUAuCcQc9mE/Z9quy6kUt3FGe1ivszEnOaEj+FvAOwq/JLOkHZWeBWLeIvYt/uKeHlZuCcrfVyomtzzWYMl5yo1QhvB4Xjv01kOwuL9KXSko5+ow4CNl0bjBzeQIjRFkKQE2YklyQF4ihk6KKqXIvenyGjxKMK8r2z5iiLbs6jRPn/RgaC/d8tKOXviJMEscxd40fMS667xrcNdjQMFQWoaKv4elkzdk5O0jzFjqqgTFvmwrM/3cXX4r2z1mCMklArnYdbGtt4vWneRAFbifCnzOKxZuZbQOhIGoVCwOrDZpYIJDq/UWoFSm2V8wqK6kMfp5jW7vicfWeaIRmSFeH2CdfpwLm5LmNzzV7ZGXJL7dduCGEJf21/3do8l2zTxBPTLRcu1Dt5oK0PrhxWU2oz6v2AZO3uLvxdiFjuxU0eSdVjtiValvwztp69fg6bOVnc18AaHY+R7rMqzgaB8z9TelF4/HezyQdgj0IB3rVp+3CKu8Xy45cZlz6m1y7zGZAGI6gQ6h9p/rno6GkdwcTrX5JYlNWHAqU7QUMgvZVIaqaEH/3TzOF7RREnNQ+q7WPta55pki7IDvkl9hdRSaFj0yklbuaWiIfcINXfpjOKlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(31686004)(83380400001)(2616005)(186003)(38100700002)(36756003)(26005)(2906002)(5660300002)(31696002)(316002)(86362001)(53546011)(6512007)(6506007)(6486002)(66946007)(8936002)(66556008)(4326008)(8676002)(966005)(66476007)(6666004)(54906003)(110136005)(508600001)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUd1NGYzbVR4Sm1BT284NEdmUndudkUzM2ZwSzcxZUpXbW40U0s4cElZSGh4?=
 =?utf-8?B?QU9sdFlRSk9CRUhPdk5iRGE4R3U2dDB6ZVNrQytmWEUrbVMrd0REZloyRHdt?=
 =?utf-8?B?QnRzVXFodU5kZHBRcmhTWHNkZEM1SW56U2RDUHNBYm9VdVZtVnYzMU1kUmpy?=
 =?utf-8?B?Y1poNW9tZW40b0tWVUJTL2I2TldyRU9uMEVNK0ZuNG1oZHFVVmdKbnBzblI4?=
 =?utf-8?B?aFlOYkwxVHdXQ21UL20vRENna25vMVZaN1RTMklPZVVnalRlUTVsdEFHYVpY?=
 =?utf-8?B?Z2tNalNPRFJSZ2ExR0p5am5sa3cyYU51RHRka2N5em44K0F6YisvYXNEV2w2?=
 =?utf-8?B?cVBCZTl4MDloOVVGQzdLcjU4QmR0L2lvMVozN2VBUFJneGEwenk4YVYvOWV5?=
 =?utf-8?B?ZjBucXJSV1FEYVJzMWcrdm93cWtXRnVnc1pIeFkwRGV6MkZvODRReW1GRU1n?=
 =?utf-8?B?bmFET3NRbXBsRHdqcGE2OVVwbTBBU011MTZZYm5mbDRJV0VtSEZRVHp3WEZo?=
 =?utf-8?B?VGZrQjNHalNyTzM2K1RPRkg5elVqdjdwRnpyb1JYYmczU1dPTzhZdWdaZ2gv?=
 =?utf-8?B?TGEwbFFXdk1LN25Zc3YrVzc4NUNUL2lOeE5uQzlnSzRNaXpUbXQ2MzRhVGhy?=
 =?utf-8?B?WDBGR3AzYUY5Y2ZtTmJWQ284aVljZ2QwT0RObG1XTnVjcWRPT0hFZHY2Mmty?=
 =?utf-8?B?eGt6dDd3VnZyYkFmZkRJSlRoYkVqY0ZmQlZGblRtTDdPN2Q4dENEcVdiVnpj?=
 =?utf-8?B?RTFndi8vZjhEd25SQ3l3SFhEaTdpcWQ4YWdrc1VGaEtoUldLelkwb2FjYW1w?=
 =?utf-8?B?WFdqZ0ZmYmhqRFVwUy9FdUNRREd3eHNQZjZONzdVWEt0WkY0NXpvbGdpKy9Y?=
 =?utf-8?B?WnYwRjRMTkFOMTdJdlRSZGlYeXFYM2NiNDFlZXl0RHBpOXNpZVVOMlF4VWtp?=
 =?utf-8?B?WS81TDNhdUdOU1Y0MlhGSGFhZG14RFFjZGhEL2lyU0xjait2RUltZHBJYkZk?=
 =?utf-8?B?dUEzWkdDRWVHRzhMeUtseGN4TTFHVHlrcEtlc2xLbGhNZEhFS2J6ZUV5K0lE?=
 =?utf-8?B?cFJDRTdjcFc2RjNrdU9ndnA4QjNvdXJSeTl1aXE5RzFZNGxSbHBCdE9BcDVl?=
 =?utf-8?B?dUlBRnlKVTFBcUVXQzZrT1dLSzFqVCt5K0hzQ3RRMTJBM01uOFQ2eXdNTVRy?=
 =?utf-8?B?bWFHSDNBMHkwdmxwNjU4WitnZDNKODVDREZ1QXpENklrUTh4NjVZMWhneEJD?=
 =?utf-8?B?RzJyQkZ1YjZIVE5yZ0lTcWRneWdrUXRRUVlROCtOcHpVOUR6L1hmODFtWG1H?=
 =?utf-8?B?YWFJNXREdHkyb0dnOW84R2Fod3FzQm5SUitBOFdwOEl6YjhXcnFlRmRFNnlM?=
 =?utf-8?B?L25pNUVDNHZtWlp3WDZwRTU0ZTJ5bENhM2NGbFl6WXJLK3VlbTZJR2o5dzBt?=
 =?utf-8?B?dEtRYnBlOUF4UmEwblhRaE1FMjl5bU5uUWRMaVFta0tWUGRIUjA2TEdhOXJt?=
 =?utf-8?B?TGZockdUMjB0MnJsd3lmUlBoQ2ZaSHUzbUFUekoxOXBtc2NmbFpqVlgvSWVy?=
 =?utf-8?B?NlNuVE9PeTRqTFFSMVh5Mm5nV1U4aHhUdFI4TldrbGQvN2JlbWxNYXJYOW5o?=
 =?utf-8?B?Q0FxK1BZVHlmSnZacFd3RXBqYTZNa1ZCbW1tYUtIbFN1S0tYc3hYSGRFRThV?=
 =?utf-8?B?d09wSFV4QnBkOThweVF6enhZcTQ5ZVBsK21BM3gycjJIeEtQaVdNRDhrWTht?=
 =?utf-8?B?SzBBMXdBR2REcnZadDVKRStObzhnclFUUkFFWGVseWVtck40OEdvMkFreDNL?=
 =?utf-8?B?MERqQnA0azA3ODlEMUVCYnZ6ZUhVbytvUFc5cEM4WHVsSjFpNGk3bXNXUTBR?=
 =?utf-8?B?QWFra3hmZXpSTDJPNTJqY3VObnhWSG4yQmJIeW51YUdkYTBiNGFuNE42SGtu?=
 =?utf-8?B?Q0NDRVZRUGJtTVBpWEQ3S1d1MjVXS3dsMEZ6WkU1aTBJNzVJSlZ6NnRtcC9P?=
 =?utf-8?B?YURqcTZtY0w4bmtWVDFSU2FKM0lHeS9XZmdXU1R6RjZaQnk5QWhLOW40dUFN?=
 =?utf-8?B?aHZ5TElkeGtsNDZKTTI4ejJUSTZDaFc5UHpTUEc4Sk1CTHdoRksweFdkV09n?=
 =?utf-8?B?TXBTejdhNEpLR0dBVXJxMGYwdDcva2tJRlF4aEx4azNodWNxZXQ4SXlFUTFT?=
 =?utf-8?Q?sSLAwM9tKHF+s0kffk7wfhQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa65b96-f266-4a08-7df8-08d9e2066e21
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 02:32:30.0942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZs3ZdRlHXCRjc0+7vlnEo5lK7GOX+Ys81FoCdH+CIY/GwKga9NJwlauvXZNkvQ6Bwgtnh9YW+O/+4y5aQMb5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 17:36, Peter Xu wrote:
> On Thu, Jan 27, 2022 at 11:25:38AM -0400, Jason Gunthorpe wrote:
>> On Thu, Jan 27, 2022 at 05:19:56PM +0800, Peter Xu wrote:
>>
>>>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>>>> index f0af462ac1e2..8ebc04058e97 100644
>>>>>> +++ b/mm/gup.c
>>>>>> @@ -440,7 +440,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
>>>>>>    		pte_t *pte, unsigned int flags)
>>>>>>    {
>>>>>>    	/* No page to get reference */
>>>>>> -	if (flags & FOLL_GET)
>>>>>> +	if (flags & (FOLL_GET | FOLL_PIN))
>>>>>>    		return -EFAULT;
>>>>>
>>>>> Yes. This clearly fixes the problem that the patch describes, and also
>>>>> clearly matches up with the Fixes tag. So that's correct.
>>>>
>>>> It is a really confusing though, why not just always return -EEXIST
>>>> here?
>>>
>>> Because in current code GUP handles -EEXIST and -EFAULT differently?
>>
>> That has nothing to do with here. We shouldn't be deciding what the
>> top layer does way down here. Return the correct error code for what
>> was discovered at this layer the upper loop should make the decision
>> what it should do
>>
>>> We do early bail out on -EFAULT.  -EEXIST was first introduced in 2015 from
>>> Kirill for not failing some mlock() or mmap(MAP_POPULATE) on dax (1027e4436b6).
>>> Then in 2017 it got used again with pud-sized thp (a00cc7d9dd93d) on dax too.
>>> They seem to service the same goal and it seems to be designed that -EEXIST
>>> shouldn't fail GUP immediately.
>>
>> It must fail GUP immeidately if there is a pages list.
> 
> Right, but my point is we don't have an user at all for follow_page_mask()
> returning -EEXIST with a **page which is non-NULL.  Or did I miss it?
> 

What you are missing is that other people are potentially writing code
that we haven't seen yet, and that code may use follow_page_mask(). The
idea, therefore, is to make it a good building block.


>>
>> Callers that want an early failure must pass in NULL for pages, it is
>> just that simple. It has nothing to do with the FOLL flags.
>>
>> A WARN_ON would be appropriate to compare the FOLL flags against the
>> pages. eg FOLL_GET without a pages is nonsense and should be
>> immediately aborted. On the other hand, we avoid this by construction
>> internal to gup.c
> 
> We have something like that already, although it's only a VM_BUG_ON() not a
> BUG_ON() or WARN_ON() at the entry of __get_user_pages():
> 
> 	VM_BUG_ON(!!pages != !!(gup_flags & (FOLL_GET | FOLL_PIN)));
> 
>>
>>>>> Here, however, I think we need to consider this a little more carefully,
>>>>> and attempt to actually fix up this case. It is never going to be OK
>>>>> here, to return a **pages array that has these little landmines of
>>>>> potentially uninitialized pointers. And so continuing on *at all* seems
>>>>> very wrong.
>>>>
>>>> Indeed, it should just be like this:
>>>>
>>>> @@ -1182,6 +1182,10 @@ static long __get_user_pages(struct mm_struct *mm,
>>>>                           * Proper page table entry exists, but no corresponding
>>>>                           * struct page.
>>>>                           */
>>>> +                       if (pages) {
>>>> +                               page = ERR_PTR(-EFAULT);
>>>> +                               goto out;
>>>> +                       }
>>>>                          goto next_page;
>>>>                  } else if (IS_ERR(page)) {
>>>>                          ret = PTR_ERR(page);
>>>
>>> IIUC not failing -EEXIST immediately seems to be what we want.
>>
>> Which is what this does, for the only case it is acceptable - a null
>> page list.
>>
>>>  From that POV, WARN_ON_ONCE() helps better on exposing an illegal return of
>>> -EEXIST (as mentioned in the commit message) than the -EFAULT convertion, IMHO.
>>
>> Again, that is upside down, -EEXIST should not be a illegal return. It
>> should be valid, have a defined meaning 'the vaddr exists but has no
>> struct page' and the top loop, and only the top loop, makes the
>> decision what to do about it.
> 
> I believe this works too and I think I get your point, but as stated above it's
> just not used yet so the path is not useful to any real code path.

It's a really important point. This lower level routine needs to be fixed up
so that it behaves in a way that is both correct and reasonable. And it is not
reasonable to load up **pages with garbage pointers, regardless of whether any
callers are suffering from that yet.

Again, the argument that "no one uses this code path yet, so it's OK for it to
have pitfalls and weirdness" is not the way to go, at least, not if it's
feasible to provide a better alternative. And here, it is very feasible.

> 
> Especially with above VM_BUG_ON() it means if we'll go into the "if (pages)" we
> should have already triggered the VM_BUG_ON() condition when entering the function.
> 

And let's not forget that VM_BUG_ON() is a debug-only assertion. So you
may very well *not* have triggered anything.

Even if code is functionally correct, there are still API design
considerations, such as, "how usable is it?", and such. For example,
Rusty Russell's "How do I make this hard to misuse?" rules [1].

[1] https://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html



thanks,
-- 
John Hubbard
NVIDIA
