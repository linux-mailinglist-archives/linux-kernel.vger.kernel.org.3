Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07B35862D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239389AbiHACtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237746AbiHACtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:49:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E41CE1E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEjDe02j8ac4pID8gqxz2gTIn4PaGzQ4b6kQ3SXgkrnPw5rMUiLjbZzxeq+8VHqiVMUwpwQU9UZauxyUkCVVUsnwbk/sL8zfqrFme0ukI0GGyuoZBRJ+zpZ85ZA94N1FZWSL7706nKYLwdc80Je+UoBHRlBhl+TzV5Wv5WJJpkIZN2gEbesKI/rauH2kh04YmfMIAHT6fYxtkOm4V9EfjhRabI1P2N2nsgDjlOqeY6Ac2e0nEBDc+VH38AcyxCXapW8cc+TCjAz9vrwXSeuklh6tmv2xyvpiJUEoYI1kenHOPhK5Q0bdjy9LbQsybDTbQGCWJl3p4kf6CIAIVNPa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xn9EvvbTL60dcaTfqyjpS8KL8iGWEc/i4Z0+q0FI2VY=;
 b=dR2llE7DZ5qRVkW+TAzt/BDSVUHuZ7I4rEF325bYZ7/9dJuNqf7zPnPgWqoYn8BZKARS34z+Yx3CclH7xpXEDayS/scQ1ku3yXd065QGBTmlGDJKbkKPHuoALNZe4uAApA9GVNILQh33Gx9l0yMwxrnTpL2BouNcDwVLl/QO+6yK19xbeU9VaySlB+OXOI/KRmzO3SAQm6BYbP03pyCBc9HTAKeesxm0pPiWKNm1WALe2NafGnO93RqHbkYOCLlgrt9PIJ+J1Zf3JbYTHYElk0p8hogcxDwQMbJj+Ycrc2p4whF0/+hhCzY2abfYioRrfwYm8S6b1rBdHu7ULSkjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xn9EvvbTL60dcaTfqyjpS8KL8iGWEc/i4Z0+q0FI2VY=;
 b=f8bvq9tb6IpAot8q8Ln4+F+HCedKLBLe6ZaMwyk+uTc9FIGIhRh8TrUr526OiqpkLKowVXOrYuEnRn4Ii3S/yu82twJ4ri1OKQIHyBG8ebBwJo12btbJdL7kmHClOqol0QN+LxEqDh70LGYPSUMNvO38xOXKz3GJrIrfJTcuCW2pW+8CO4XFXkE3xRxs7894G6gzhKilxMzqKXGglXcR0I4SG+fXChQq0RoaQbiYABmj5c5Z/djZcbOYo+zMatY2wh21JiOPvFs6E8/SJizKhIY0lyejUbi4aGJ7lsZWhSxg7zu2H5HxmjSKngpqSOpRyf11srtUQxL7Hf3psP0JHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN2PR12MB2863.namprd12.prod.outlook.com (2603:10b6:208:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 02:49:12 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 02:49:12 +0000
References: <20220729024645.764366-1-apopple@nvidia.com>
 <YuQ4mJqjIUncf7iF@nvidia.com> <87wnbsd6yp.fsf@nvdebian.thelocal>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        pasha.tatashin@soleen.com
Subject: Re: [PATCH] mm/gup.c: Simplify and fix
 check_and_migrate_movable_pages() return codes
Date:   Mon, 01 Aug 2022 12:46:50 +1000
In-reply-to: <87wnbsd6yp.fsf@nvdebian.thelocal>
Message-ID: <87o7x4d6fx.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0109.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::11) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 988a3721-6469-4baa-efa4-08da73686a46
X-MS-TrafficTypeDiagnostic: MN2PR12MB2863:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxNd9PsE1S1lY5pp67b3grFYhGIQY6PwM/fsSI0t/FXONfOqgNLdyXgdb1t8O5B4R4dptuKQhAJrrgsmjm3C/5bwroCKsi33iTk29u8WiOYVsoQFpwQ4hzc66nKyKxhnCWx7NHjNIXrAjuFgyIrbbo5WmJeEMGXQPhJMEJ8eFUHPrvRrvlVP2WMTZI/Oo/Wa95U8p4Oy3dO8fuyGv2r/LdNE0TPznNWvzr9iaOsMm365rU5qgZbJcr4vsdpucz6c2/IvaJoOLC5US7h8r+JERlp/HZi4pMINCYg79Y7UlAD5utBF9kJ8m+kD3wD1i8UtLwDcgb286Zc5htUmkrMt84OrQtqNikKoLAt/JmsOjC2VsczbX+uuBYzLBGMCT9mfVnlcm6xlV/NF98KGEUKocRKaqU/iHzNqkijcoHFgr1DkmYvtnnGp2rAZ9/crg81MGXsa1qzU1cYCDxQBzhFazBjtWfOPBBzfQYySqxhe/G7cQc+p3p9LPfbe21A6wl06iw/7A4+pliyQq9mEGISbkAPSFFlCi+QFdD/FM/LvH5oerYTBRv6uXW9wgEqPOGMO3xzWkaRNJ2vX+khIYR8vekdCOhTzhaaHZdybS8aTcTL5bOQpYM54LPlZg7wrFTtw2c6gm8h5JIo1b40h9S3C2EEJBi7F5H82yqnf/a18WfPSBur88eQq9zRBaG/64AigbEuIRAA8T8q6moMKmPWyhFpgW/HRzoZLAlFE3G96cNh3NJn0TNPpArOcFGy6Jp1G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(4326008)(6486002)(8676002)(6862004)(66556008)(478600001)(66476007)(66946007)(8936002)(86362001)(83380400001)(5660300002)(316002)(6636002)(6512007)(26005)(9686003)(2906002)(6666004)(186003)(6506007)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FuFmaMO136bcIs2rR6pqHwFxApf5T+dP147/4POq6wguaye79kdYucfzZAv6?=
 =?us-ascii?Q?i4+hPTowfOb65Ffyw/qpTNR6rYZW5QSvcA/WU71pJ0GAtI25Sux3vWRRy8oq?=
 =?us-ascii?Q?rRu6YySXQwy8RPyHroA5T/NJZgO1HNqXj3Dl6g2R9KXjRpqZmoxqy1z1ujkJ?=
 =?us-ascii?Q?wVdhBzRV74QjmRh3CuJOsp2KOJtfonFDGZhdkRm6gNNlxMd3ABO1WY1g6GnP?=
 =?us-ascii?Q?zUj/Jvb8m4N5Pr5mci6u0bLfUA5uiFEZG5a46udsonjEdadOuOJ7E1FBoZJu?=
 =?us-ascii?Q?zhG6D3tUle2GNCjkSbVz8SnxuCJm6SeDuQLBXK7u0W0+ghbkmqF4zQ0uFlae?=
 =?us-ascii?Q?xj4CmejLKQNL758rb8fZ1SkMdVvgNjFwfeosXsplI3Ndn7fyeMCSVwi1Z2P7?=
 =?us-ascii?Q?gYJ1lMJAbE+6TIkeY41/O7ckzlGqqowOjOC1pIix9SSkcmz6VbnJs6SZYrfq?=
 =?us-ascii?Q?5XkEtFhvvmFvNxglw4wgqtJ698hPh6affG9TA8jfbLLg+g7+eDHzgcFRaM3L?=
 =?us-ascii?Q?sWF6KiyvDHTjyBsAzhtBvUUx3PnK5kmfRxlaoAtpaJRLg1d78nTUhBbkqyNq?=
 =?us-ascii?Q?lhw+3yWGH7yafk1jbMr0VGFtTUVj+kmc+dLj/Mk+8mHDTeegmDTxJZAXcDAH?=
 =?us-ascii?Q?2saF4/vJplTlj9+nc0KkF4N9AH76L2pmlmBeC+ACNYrZ6cjx5ymESJadl+vi?=
 =?us-ascii?Q?hcyvGYs4H6CGQgfFfp2hN9s392isZbOV+D4zr+EPPcE/aQ7IwEnLPaLdwkky?=
 =?us-ascii?Q?oNpzPBaqM5fHPMIgIierHl4MF03FuNZO8j5DJx7XUzoBR72XxGq/kvZGk7bp?=
 =?us-ascii?Q?99Yeq8YLIwoP0lkCmwLN0IAs1IDVmAwLfLudBuXvhBHGWZHjdC2/ae5zrYD5?=
 =?us-ascii?Q?k2topEgL0q49DtvW1OT2VXo4m1VdMER1r7AeMCJrRafmD9f5l8a+XXFupmoT?=
 =?us-ascii?Q?4q0nlqUSwV/xhdyg1Z26iaTr+Xj68K2YrLRPlEBDqN1DRVIJMt5X2y4twm8C?=
 =?us-ascii?Q?cQI9dBFvF1XKAlb+DjCPU2l4eoF1+LwPIeJa+E6SrChDWJCkyAohXd8f0kD1?=
 =?us-ascii?Q?p5OKr1uCfHy92RGCOiz+JO57+EUshFqBKWfqWbgXoY6GIb1zhZEQJJCXKzXz?=
 =?us-ascii?Q?dy9SW6YkVyqrMIKoqKAvEXnNrr2tB6M9LGTpE/Kb8GVW9qBvrUjRgbmQ88ip?=
 =?us-ascii?Q?PTlbmPzbbcONlR0BsDKF+zLO+kvUdWxsUjHCYxO47S/JoBUFzAK6C23Lk2Va?=
 =?us-ascii?Q?N+RSl5gEfIB4cxYwFN87J/PTVl5vjDvQrBglWn1a7HYar9FVBlkbMCorp/rD?=
 =?us-ascii?Q?AnrF/nEiZk9qi1ZMmM3wEJ+68rw1kCd61xeU95Z3fO/Guu1SAH52E5ukwY6r?=
 =?us-ascii?Q?Wsr9SZohAptRSc0/PNOH5sPJaleDwY8Un3lqNfank+V9yOhz6qSP/+ri2QiG?=
 =?us-ascii?Q?cmK+qq3ruq0ORNTYNDDe1FZ7TKJhSBbyZI7RPgyvizWUfIUW0FIgyW2CsCr5?=
 =?us-ascii?Q?Q8kYkZJfmOtc7j6KxxjFrNMd+hXTOaDRdQDQYqkmGuPxrFTJO13i/Bb9xrZG?=
 =?us-ascii?Q?3wqY/qVhjKqqdFbr6VZlH9vxz0Hmr8ea3dAboQ2F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988a3721-6469-4baa-efa4-08da73686a46
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 02:49:12.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsP487nsbA/yTcCQ7iRPcHufQVRvm0DhvLYto4W4k2cN1VS38HhKp8KtHQ/e6zcHmeuHRJVahoYgND1fXdEIug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2863
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alistair Popple <apopple@nvidia.com> writes:

> Jason Gunthorpe <jgg@nvidia.com> writes:
>
>> On Fri, Jul 29, 2022 at 12:46:45PM +1000, Alistair Popple wrote:
>
> [...]
>
>> I have to say I prefer the usual style where all the places that error
>> exit do 'goto error' instead of trying to keep track in 'ret'
>
> Ok. Part of the complexity was my understanding from the documentation
> for migrate_pages() is that putback_movable_pages() should only be
> called if migrate_pages() != 0:
>
>  * It is caller's responsibility to call putback_movable_pages() to return pages
>  * to the LRU or free list only if ret != 0.
>
> But I think it should be fine to do regardless, because on success the
> pages will be deleted from movable_page_list. Eg. From unmap_and_move():
>
> 	if (rc != -EAGAIN) {
> 		/*
> 		 * A page that has been migrated has all references
> 		 * removed and will be freed. A page that has not been
> 		 * migrated will have kept its references and be restored.
> 		 */
> 		list_del(&page->lru);
> 	}
>
> So will post a v2 doing this.

Actually sorry, ignore the above. I'd missed the return -EAGAIN after
the migrate_pages() call in your proposed patch.

>> AFAICT there is no reason to 'continue' in most of these paths since
>> we intend to return to userspace with an error anyhow? Why try to
>> isolate more pages?
>
> The main reason would be if callers want to retry the operation. AFAIK
> isolate_folio_lru() can have transient failures, so if callers want to
> retry it makes sense to isolate and migrate as many pages as possible
> rather than one page at a time as subsequent retries may find different
> pages that can't be isolated.
>
> Actually I should have called this out more clearly - the previous
> behaviour on isolation failure was to retry indefinitely which is what
> lead to looping in the kernel. This patch turns isolation failure into
> an error and doesn't retry. I wonder though if we need to maintain a
> retry count similar to what migrate_pages() does if there are unexpected
> page refs?
>
>>> @@ -1980,19 +1980,18 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>>>  				    folio_nr_pages(folio));
>>>  	}
>>>
>>> -	if (!list_empty(&movable_page_list) || isolation_error_count
>>> -		|| coherent_pages)
>>> -		goto unpin_pages;
>>> -
>>>  	/*
>>>  	 * If list is empty, and no isolation errors, means that all pages are
>>> -	 * in the correct zone.
>>> +	 * in the correct zone. If there were device coherent pages some pages
>>> +	 * have been unpinned.
>>>  	 */
>>
>> That comment is a bit confusing.. I guess it is trying to explain why
>> coherent_pages is doing?
>>
>> Maybe just:
>>
>> All the given pages are fine, nothing was done
>
> Ok.
>
>>> +	if (list_empty(&movable_page_list) && !ret && !coherent_pages)
>
> Actually I think we can drop the coherent_pages variable too. At this
> point coherent_pages will either be in the correct zone or we will have
> jumped to the error label.
>
>>> +		return 0;
>>>
>>> -unpin_pages:
>>
>> Now that this label is removed this if following it
>>
>> 	if (!list_empty(&movable_page_list)) {
>>
>> is also now unneeded because the above 'return 0' already checked it
>>
>> I came up with this ontop:
>
> Thanks for the suggestions.
>
>  - Alistair
>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 9e7c76d1e4ee3c..eddcf3c0eba727 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -1912,11 +1912,15 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>>  					    struct page **pages,
>>  					    unsigned int gup_flags)
>>  {
>> +	struct migration_target_control mtc = {
>> +		.nid = NUMA_NO_NODE,
>> +		.gfp_mask = GFP_USER | __GFP_NOWARN,
>> +	};
>>  	unsigned long i;
>>  	struct folio *prev_folio = NULL;
>>  	LIST_HEAD(movable_page_list);
>>  	bool drain_allow = true, coherent_pages = false;
>> -	int ret = 0;
>> +	int ret = -EBUSY;
>>
>>  	for (i = 0; i < nr_pages; i++) {
>>  		struct folio *folio = page_folio(pages[i]);
>> @@ -1948,10 +1952,8 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>>  				unpin_user_page(&folio->page);
>>  			}
>>
>> -			if (migrate_device_coherent_page(&folio->page)) {
>> -				ret = -EBUSY;
>> -				break;
>> -			}
>> +			if (migrate_device_coherent_page(&folio->page))
>> +				goto error;
>>  			continue;
>>  		}
>>
>> @@ -1963,7 +1965,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>>  		if (folio_test_hugetlb(folio)) {
>>  			if (isolate_hugetlb(&folio->page,
>>  						&movable_page_list))
>> -				ret = -EBUSY;
>> +				goto error;
>>  			continue;
>>  		}
>>
>> @@ -1972,10 +1974,8 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>>  			drain_allow = false;
>>  		}
>>
>> -		if (folio_isolate_lru(folio)) {
>> -			ret = -EBUSY;
>> -			continue;
>> -		}
>> +		if (folio_isolate_lru(folio))
>> +			goto error;
>>  		list_add_tail(&folio->lru, &movable_page_list);
>>  		node_stat_mod_folio(folio,
>>  				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
>> @@ -1987,7 +1987,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>>  	 * in the correct zone. If there were device coherent pages some pages
>>  	 * have been unpinned.
>>  	 */
>> -	if (list_empty(&movable_page_list) && !ret && !coherent_pages)
>> +	if (list_empty(&movable_page_list) && !coherent_pages)
>>  		return 0;
>>
>>  	/*
>> @@ -2005,23 +2005,19 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>>  			put_page(pages[i]);
>>  	}
>>
>> -	if (!list_empty(&movable_page_list)) {
>> -		struct migration_target_control mtc = {
>> -			.nid = NUMA_NO_NODE,
>> -			.gfp_mask = GFP_USER | __GFP_NOWARN,
>> -		};
>> -
>> -		ret = migrate_pages(&movable_page_list, alloc_migration_target,
>> -				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
>> -				    MR_LONGTERM_PIN, NULL);
>> -		if (ret > 0) /* number of pages not migrated */
>> -			ret = -ENOMEM;
>> +	not_migrated = migrate_pages(&movable_page_list, alloc_migration_target,
>> +				     NULL, (unsigned long)&mtc, MIGRATE_SYNC,
>> +				     MR_LONGTERM_PIN, NULL);
>> +	if (not_migrated > 0) {
>> +		ret = -ENOMEM;
>> +		goto error;
>>  	}
>> +	return -EAGAIN;
>>
>> -	if (ret && !list_empty(&movable_page_list))
>> +error:
>> +	if (!list_empty(&movable_page_list))
>>  		putback_movable_pages(&movable_page_list);
>> -
>> -	return ret ? ret : -EAGAIN;
>> +	return ret;
>>  }
>>  #else
>>  static long check_and_migrate_movable_pages(unsigned long nr_pages,
