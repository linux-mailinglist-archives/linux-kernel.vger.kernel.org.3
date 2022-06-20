Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A5E5513F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbiFTJQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiFTJQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:16:46 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB80DEF0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z25juyVctAz2CSjDbWE1lfYRDS1qcANej1ooeVTTKC6it10iLsRI3mPisxwu/mqnLBqTEtrtXtFayuq2SOhnbjvolM9B7Ti8gRmQNMvW6qLLGGOP8XRNtITE/3aUV7n0ZeSRwMlqbIjRf3QV21EqGyeYwnQu/EqbdZRQzj2Ex121zmp8FSnD2bTcBGCPn4oJ+dDQkql9IDWnrEmDat5gzFwdsevnTVjtNPjb1I9raKdKdXu1JGYXsOgtO7Dv9E6J03TXmxpSsdRIUMn94Y9AZlOMseKJ4RE5IbuXAkfPW2iPzPmQGp6eSHunQrzQ/msEGIs/f5mEspiGA95Z/Ueokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fC2xic4CIz273s85xOyMtO7iwiIIQoK+hp/VwgNVb0=;
 b=CD4ahvHz3chjL9r2in0lnjuoMDYNsm0BiChdYEABrqnZOypBimZbkJ5NxXox81K3U+lZYR9q/ghDTka8zJBBsUagzlUQMMemfHwa078Ohv3MY5hGaxiJ5ve6d+ujePjHaoT9WbT/Kc0kkvxBNVAPUyT2c+VTlUrL8RZoC0C42tGUNJ6d1R3uP6VziZvfYYEB63g113QWRN7zBA0LzHv7yJj36rtvdLzscvhYj+OLLR1AX/li9ZbVfr+XDtAx8uAFnwWHol8p54V92UakKMMkyUVWidFVuWuhALfXNIR7PKlV/pijKwoSaaLfh4hDXsOoCdKTEOoK/M7ISiUpAWHJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fC2xic4CIz273s85xOyMtO7iwiIIQoK+hp/VwgNVb0=;
 b=LJNsCUcg/RvoxL9tNclzmvFkLdWJ0s0H93WuwoCfhJtd0+h3Mszv4vYpZcySYFolGk+7UzNPxTKyOCjJoSccsLDz8RTnCf/HnxIzeyCyuUHTJphl9yHCWHGqi+0+CHVjCFBYTlsP6K3eEStwD5EL1s6qcATKCEDgnkbWK73A4idr0M/DhtAyah19KjroLjsPEDmVwtV2QjPZ5x/EtGFN5bQjt/H2Sq6vQOTW0tPUeEUoUS1Or2mWXG86aACyW1jt0JHQc0RNXnIeOGy6YWW+cdt2oI/gpNGbbO2gtBQK+qyKGx+2XB5DkAmOhyZT30YH2cXXWXs6QKUkWvP3DY5cgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CY4PR12MB1686.namprd12.prod.outlook.com (2603:10b6:910:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Mon, 20 Jun
 2022 09:16:43 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::59cf:d090:5d26:6e7b]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::59cf:d090:5d26:6e7b%5]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 09:16:43 +0000
References: <20220607083714.183788-1-apopple@nvidia.com>
 <Yp9aQk66fkP8MdOS@casper.infradead.org> <87sfof8x1w.fsf@nvdebian.thelocal>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap.c: Always read one page in
 do_sync_mmap_readahead()
Date:   Mon, 20 Jun 2022 19:06:38 +1000
In-reply-to: <87sfof8x1w.fsf@nvdebian.thelocal>
Message-ID: <87y1xr7kzs.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4281f2c3-e961-4bfc-0f0f-08da529d9781
X-MS-TrafficTypeDiagnostic: CY4PR12MB1686:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB16866BBEFEDB240C564348EEDFB09@CY4PR12MB1686.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4i9DGpe3SGYNDn76y8sucplb9Oj/B2gG3iWZjizHWKDHh0PcW/emi5Dx83EVoBqQhSRqS1etwQWsKkL+nScW/39sQK0uLkuDw0Yp4PbP4NE+o9yjIN4INfgiJWgOKfHpkR3JK8ReR8ZEg6H9GKy0KZaHmjtTQz5VtFYaY+YEwvwmJcfY4UEtdT9MDEUAZbQzp0Dx5jywdzIzB+giAVFzEuBQyTBC8NHS5SEyBY/Pb2rJ24sWlKp2Y9P+UkaJA4bZ/ZDLB0gR1VGAAZZA4tLLxEu8asIFRk3+H3b4lrEEwmrDwoAh1RMg+N7H7P6SSou9E+jZwlWWHsqcI4kBZWmZj8N/wHKfFHrWywq7WKyh8C5nsHEjmYkWNYYtlfRQJDf7bcFf9StNZwhuFZIgmIuA8+Y1nhk2pYSU04PIuajm4MbZqNcKKgwSqjqRS0/KcctNYspKP7cQZE5F9QHgEOjgWUDVbb0PlUo80CUvG7KTXSpFk4X++9JoW30ww53BKb2dFARX0dwDrDpDH6NmW3KoKw2W50bKi3J6u8Erz8vOX3mtYjaR9327FnmARdTsTHTjhjjRhZR1gnkXfFTnXXxWCJnu1Ho02ylvu2K9UWsyycNB2h0TWYVNKjScsSoyHFlEWCg7LwknoQRKIuHV3znJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(2906002)(6666004)(6506007)(4326008)(66556008)(5660300002)(66946007)(66476007)(8936002)(8676002)(6486002)(498600001)(86362001)(26005)(9686003)(316002)(6512007)(6916009)(83380400001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2w4BBnsBL7p4isPeeLmENybJ1m65fCWRXn45e4A8EE5NeervPkLeyJ8FSsI7?=
 =?us-ascii?Q?ua0GUyN2TeWUJajbBaYXsMajeheSqcbWVIx2hqy2X0jrTrd9mPFON8bbN9F6?=
 =?us-ascii?Q?UMsc9I7XKSLabtXpa9AOG2UaP41xgwwA/kxHldvKjVH/9skqjPd2FG/Q/Tu+?=
 =?us-ascii?Q?MgW05whkGKFkC9TdUMQ4QfQmLlwTHCDy0oWGi+YU6gTAdDlgqaNU7W09toFX?=
 =?us-ascii?Q?8ujv9AH/Vrs4aUUldxtfKZJEExlngp53bRm8Brm229JVtMg59SiEyff1kTcO?=
 =?us-ascii?Q?VMI1rbHr+3ynuAuAy0pFiUQX34/rPopkWq1IWlWWyzOw4WzuHk7c2fzloZvc?=
 =?us-ascii?Q?mTTBVqa4Z30JEFL/DbjND+c+Ltsm+JTlPXif4GJnVekXidhNm80AzBASrWKC?=
 =?us-ascii?Q?cXkKPtFi3dsoXxF8ElA2zDM43K9h4P+4+xdCnXIuGj+VIKV9hQWBqFeRPPxq?=
 =?us-ascii?Q?UoCJpSd5O/xPrTHYzuCPMSnKlh46OOrFgdivf33NZnBY6WkqMKUCZ/TtPoeX?=
 =?us-ascii?Q?c89dq+hC8DTogwYYmn8Fqm81/BooOWiXWN0+JY9D4/QIYyvZnt+tXx2prC0M?=
 =?us-ascii?Q?SIh67hsE+uUL9f8guug/3IGbcLJDXvwajOoxRJLm7wPJSvDViPPrQWZqj4UC?=
 =?us-ascii?Q?FmvwdsaQDePd3VRg1Xhd8Tch9WQ7gCsemPM0QDBv/gM2INOe1crbRyCXADsf?=
 =?us-ascii?Q?NI1Gf3D9wtjS6/oysXir5e8+C4wuIvtXWQw5awZ3BaQQ4yAl6zPQJZHcAOWi?=
 =?us-ascii?Q?fDBzx613hNIqiIClxDZHC1ZK7l+/HyOrPEytxVqoEnByQAqnNvzbTp+Vqhwa?=
 =?us-ascii?Q?wZhA70XCS9mFdF4mwnwNCiG6ovgJW0qB7ApG07H1HHJmc7Q+2tRbdYcKWN8B?=
 =?us-ascii?Q?msrxCAEkx5D5DKUdatBFw6X5utk0NCRUKoN+SDke7LVo3ansrJ71LQ5SZ7mO?=
 =?us-ascii?Q?hpM5sKylpLrQeln8ndcfBvFm95QLmfrLS/NVcmFRPeRdbZe7pQLu4O6e/0O5?=
 =?us-ascii?Q?fmMTObjXdvKDegX8xuQrTwylqPf7I4UPuwoZlSkj/EeUsmqiK55/pUj3RMh6?=
 =?us-ascii?Q?XEwV3MVr2bQ7geY2LkdyhL7bFIc3aK5s3XVh2nQZHplTN4m2SqlXa7WD9gvH?=
 =?us-ascii?Q?iEiSzWctnsFPU6A4WRgJw4hnqIGc7w0KOEdS35VyeE2mKhy/NlmnuKAjyXgE?=
 =?us-ascii?Q?+kYs3mb7SWP7Jdbg6Rr/agKyWyeASkylsFD9J2Qd8FmXnUaH4QcfQnDH0bjb?=
 =?us-ascii?Q?BTqBtQxbU35KnCh2K58J8e7XV4f8e2s9c0su5PzgGQEK4rNA04ha9BH0m4CY?=
 =?us-ascii?Q?h71x7p7WXK2/HsBDPvUGvf/GPBnuGbluWesfUdQ8CEfw3QeJksh1Ar7VgeFd?=
 =?us-ascii?Q?2BoQsStVsADojI4WqIUCMG0U1ZXrJ9MVe1Kfr/aN+ZCek0eNjytL82bFPyCV?=
 =?us-ascii?Q?W83njG8gSCS4m+HO6K9zkJMFw5eAWlHiAVhw993OEb6tXAyldVE8K/abSClq?=
 =?us-ascii?Q?Bh0y0FU1IX+Fpnp6CIA6owCia9b86tgm5+07kkiBl7lSSU7DlUaHJbTTp5rL?=
 =?us-ascii?Q?8o0Rtp0dpTUyBbdq26rGRq+u1NOk+UA/2Mp1muIL4YeXtt3lV3D8zV9eUbDG?=
 =?us-ascii?Q?E2HO8FZ2WUzwmrUVl7ysDDdv5XqeM0mDu2GAJ1n8vUy429ltzXMDnGuPrO1F?=
 =?us-ascii?Q?uV91TLzIxCQ+dHt3XHdtbpXMJn9kwkygWWA+h/Rl5uD6la0Erust07N3UJ9R?=
 =?us-ascii?Q?+oSl2jNTPQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4281f2c3-e961-4bfc-0f0f-08da529d9781
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 09:16:43.3069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7zJGzdN1CZOsT9z/MXvNzxNn3ACqlcjDOTp0rt5B4YQ700/u8xl/TMxDfCi1i3uEnqz4wOiFjWXLsDHHxBMIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1686
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alistair Popple <apopple@nvidia.com> writes:

> Matthew Wilcox <willy@infradead.org> writes:
>
>> On Tue, Jun 07, 2022 at 06:37:14PM +1000, Alistair Popple wrote:
>>> ---
>>>  include/linux/pagemap.h |  7 +++---
>>>  mm/filemap.c            | 47 +++++++++++++----------------------------
>>>  2 files changed, 18 insertions(+), 36 deletions(-)
>>
>> Love the diffstat ;-)
>>
>>> @@ -3011,14 +3001,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>>>  	}
>>>  #endif
>>>
>>> -	/* If we don't want any read-ahead, don't bother */
>>> -	if (vmf->vma->vm_flags & VM_RAND_READ)
>>> -		return fpin;
>>> -	if (!ra->ra_pages)
>>> -		return fpin;
>>> -
>>> +	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>>>  	if (vmf->vma->vm_flags & VM_SEQ_READ) {
>>> -		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>>>  		page_cache_sync_ra(&ractl, ra->ra_pages);
>>>  		return fpin;
>>>  	}
>>
>> Good.  Could even pull the maybe_unlock_mmap_for_io() all the way to the
>> top of the file and remove it from the VM_HUGEPAGE case?
>
> Good idea. Also while I'm here is there a reason we don't update
> ra->start or mmap_miss for the VM_HUGEPAGE case?
>
>>> @@ -3029,19 +3013,20 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>>>  		WRITE_ONCE(ra->mmap_miss, ++mmap_miss);
>>>
>>>  	/*
>>> -	 * Do we miss much more than hit in this file? If so,
>>> -	 * stop bothering with read-ahead. It will only hurt.
>>> +	 * mmap read-around. If we don't want any read-ahead or if we miss more
>>> +	 * than we hit don't bother with read-ahead and just read a single page.
>>>  	 */
>>> -	if (mmap_miss > MMAP_LOTSAMISS)
>>> -		return fpin;
>>> +	if ((vmf->vma->vm_flags & VM_RAND_READ) ||
>>> +	    !ra->ra_pages || mmap_miss > MMAP_LOTSAMISS) {
>>> +		ra->start = vmf->pgoff;
>>> +		ra->size = 1;
>>> +		ra->async_size = 0;
>>> +	} else {
>>
>> I'd put the:
>> 		/* mmap read-around */
>> here
>>
>>> +		ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
>>> +		ra->size = ra->ra_pages;
>>> +		ra->async_size = ra->ra_pages / 4;
>>> +	}
>>>
>>> -	/*
>>> -	 * mmap read-around
>>> -	 */
>>> -	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>>> -	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
>>> -	ra->size = ra->ra_pages;
>>> -	ra->async_size = ra->ra_pages / 4;
>>>  	ractl._index = ra->start;
>>>  	page_cache_ra_order(&ractl, ra, 0);
>>>  	return fpin;
>>> @@ -3145,9 +3130,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>>  			filemap_invalidate_lock_shared(mapping);
>>>  			mapping_locked = true;
>>>  		}
>>> -		folio = __filemap_get_folio(mapping, index,
>>> -					  FGP_CREAT|FGP_FOR_MMAP,
>>> -					  vmf->gfp_mask);
>>> +		folio = filemap_get_folio(mapping, index);
>>>  		if (!folio) {
>>>  			if (fpin)
>>>  				goto out_retry;
>>
>> I think we also should remove the filemap_invalidate_lock_shared()
>> here, no?
>
> Right, afaik filemap_invalidate_lock_shared() is needed when
> instantiating pages in the page cache during fault, which this patch
> does via page_cache_ra_order() in do_sync_mmap_readahead() so I think
> you're right about removing it for filemap_get_folio().
>
> However do_sync_mmap_readahead() is the way normal (ie. !VM_RAND_READ)
> pages would get instantiated today. So shouldn't
> filemap_invalidate_lock_shared() be called before
> do_sync_mmap_readahead() anyway? Or am I missing something?

Never mind. I missed that this is normally done further down the call
stack (in page_cache_ra_unbounded()). This makes it somewhat annoying
to do this clean-up though, because to deal with this case:

	if (unlikely(!folio_test_uptodate(folio))) {
		/*
		 * The page was in cache and uptodate and now it is not.
		 * Strange but possible since we didn't hold the page lock all
		 * the time. Let's drop everything get the invalidate lock and
		 * try again.
		 */
		if (!mapping_locked) {

In this change we need to be able to call do_sync_mmap_readahead()
whilst holding invalidate_lock to ensure we can successfully get an
uptodate folio without it being removed by eg. hole punching when the
folio lock is dropped.

I am experimenting with pulling all the filemap_invalidate_lock_shared()
calls further up the stack, but that creates it's own problems.

>> We also need to handle the !folio case differently.  Before, if it was
>> gone, that was definitely an OOM.  Now if it's gone it might have been
>> truncated, or removed due to memory pressure, or it might be an OOM
>> situation where readahead didn't manage to create the folio.
>
> Good point, thanks for catching that.
