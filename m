Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A591590C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbiHLHFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiHLHF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:05:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD9F18E1D
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYwgwVVeyPFmxrPcjSzW5cp6ysnLfqKJwai1ejpMeIrdNen086VKIktGYLiR+JA7+568brRtlXFOSXHZ2ckuteUKNL06TwzvNcuhPbMT5ZdRtO5P2ihH0Bl/c0zg93mcM4aazBKhUtKr8HAmFLvWqps5RRYnvWdz4moVQtt3xFmvF4P9bYwwX7mu+5jwERYYI0DbszhNSZDR5WJUHUaVZv+Y5/WyyXzmht4Ahg2gjlRABerDpFHrqicnCezfWOj5llgs3NqQ3iDqEp020tXxWS0ucZW8S9fE2Zo/ttJJZUPkiHSnWf47hYsasDni5rFhoURJJ0fSFlBxi6rFznkEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icvap4P0398fIyAi56O5O45eUzGU0GbSYxPj8aZcGPM=;
 b=Cg76D6N59uRme1r44ANXBBr4qEPgF+jhc3wfqLHtLxoJjXP9inPgAeHzdplaRG3I9h0VA/Y2UXI0pE1rHnRYczMW025MTjd+GL3JRnkq/wOMqpcSJz+kc4tYe9KgdBxBef3rLkGiint9n1wITP0bXOUWkoy/rHH+RxhnD9wCE+ignhjDR28YxW3BnSs5mqp6zEcC8KFNFi9iiVKZ+z/X2ImsgRY8xUXuME3afiECW+hoUM3E/xmYViCrcaEsOQ/EdJVqA6Qd4vE5Gi/8wB5e42hPHRBdVukfNg0b6u9treFuSK8eDX/kN0VmzUH/v29nBdcPS+8br1oDjb982kAr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icvap4P0398fIyAi56O5O45eUzGU0GbSYxPj8aZcGPM=;
 b=l/dQ1t9KXuwbucvUhN9xobGQBPPOvpq59vEvu0GWypUGutt/lLFyF33kX29V04NQBQHE1RN64EsVLKgBVQavowJWxscjnOb7+mMzbnLquNPnylDVjcG9u4xTAuujlkC+M516MhjsVvJYLhJdE0Lq0HCP+H5lubloEUd6lGaGGkySGXtrCHIkuI35o4eJRSURuQri+jtJ1BQyCP224nxZXIOQy/Sl5npF+JpkJYpPYQlq+X/hIQ3iJKGexkLKSjyh3X8F7WEHtSYhwXQQ/MeHUQZFD9V7qSzR9EgxHems9TEphtlFghqMsxv23bj8w7wzeI9KOI4UxTii8fz1iL65PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 12 Aug
 2022 07:05:21 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 07:05:21 +0000
Message-ID: <dc8fd102-ba30-d980-bdbb-11f39326103d@nvidia.com>
Date:   Fri, 12 Aug 2022 00:05:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 2/2] mm/gup.c: Refactor
 check_and_migrate_movable_pages()
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
 <6b61e9bf7c65f78524db32ba3e65a7eb6b8a76a0.1660269441.git-series.apopple@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <6b61e9bf7c65f78524db32ba3e65a7eb6b8a76a0.1660269441.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::26) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6091eca9-aa68-43bd-cb68-08da7c31053c
X-MS-TrafficTypeDiagnostic: MN0PR12MB6295:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g2hB+NIOAEboisNe+hhHedwvzk4POexdhLfoGs+buTM+hlJiyAMAjlogEfCrtuZNhVjQmi1fs+WvfOvDylUHx6VpzuKq4NpMPImGU4uh//Og4iFufjN2kZu31VzDucFCocdM1VDWT/v2lwNJTre3uIBh3z/oYYfknnEsXat0+DqBeZLsX56gxehiLogvoOB+UlbGktKBmrmQZv7pyMIhbjXFpl7IYALojlEuq29EZI1a6Hfiy8UWg0+UeXx9WUK02CC7sSiEjhU93VnDPkjqb+K8uJL8X2KLn0QRTPfr1EVVkK7H+Y4MpN8+rlzuIqaz5NjI7VnPShDkG83SNf8a4TPxi3ZQ9yMgOIR0nV1PMWVUEYK4jZKvQ+2x65toIzi6diTsoDuTCVZ6SwprQu2jY1ZxUkfWfP6sQFvJdztag56XJE2NPbWgxRV3kGhU5muk/Z+oq/6Up+X02WOJDnv7WQipYwk95ZVhh2jsSxRI5/yuKVRa5wDGyFhQWf7l2QbZqa7lLmZJ9W3OHfpnRj1cuaqrx+/noSdNblYtF2RT+NMBInvtyZzlz6GYld0g1tK2BOaNKpee9YpbU756FXpd7bSxsEePv/RTS1Deje6xuJbMLj5OWrCKk7tCgPsgzCvA0E6PW7sD1aGQQkpRzxNfUgDjqIebUlte4uODHJEgGiFv7wV4T0EfiRtF1T/0Ieur8vbzCiQlIHawSVRdi1oPOEJyRlv2OvbRcdnC0sxCvdNV12swkMLcaT72RBeO4k2PTwLg8lcG+bObE8jHt4+5J3RbIG6Vg4XaX2f2B/8DU1Izs5K/gW/Xu7u0UW1R3hZVIuVCq19TcC4d8vLvhoNfeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(83380400001)(478600001)(31696002)(5660300002)(186003)(31686004)(6486002)(2616005)(86362001)(36756003)(54906003)(8936002)(41300700001)(7416002)(316002)(38100700002)(6512007)(2906002)(66556008)(66476007)(66946007)(26005)(4326008)(8676002)(53546011)(6666004)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDc2ZmNXUDlGQXRVeXpLSWtQR2s3MGRrTVhEcWVrbTZyalJzSEhEK0UySVZD?=
 =?utf-8?B?Z0ZZQkE1eHNzQlUrbXQybmk3SXVDS2ZlS2IxakxaUExDQVk1Wnd6eUgvSVlk?=
 =?utf-8?B?ZUNUNWhmSGlzL1VEcCtrQm5mZ2VtcDVYTkUrMHRIOUdvUmhUZFg5Q0U1a241?=
 =?utf-8?B?TFBSMVZRSnZ5YTlmZE41bmdZSXN6czRxd25hZ3RRVXpMMUpUVCtZQUpWQWhP?=
 =?utf-8?B?ZmpUVHNEN3ZQSmdoRW5rVjUvd0hvdnA0SGptbXZiQzkzUUtDTko0ejJxNTdD?=
 =?utf-8?B?ckNZeU9ackp5RzNsZ0tJTURpYUxrdW1kL1d1UU9FRFNST3lybFpzMExRZXdQ?=
 =?utf-8?B?eW82WjMyT2dsZUtzaW5vaVYyL2NzaDJBaytUdWI5SFMxcWZUaEswNlNDeStQ?=
 =?utf-8?B?TjJnN0tpcGJWTUYxNndPVllOWXQyZ2tvckI0VnV5YTdxRjZ1NDcvUFdscGpY?=
 =?utf-8?B?bG9XMVRTclpQYWdmR3I1RWIxQTgrTWUrWDBkSmtTdk85K2VzYmdYeU56QVl5?=
 =?utf-8?B?ZmhhU05ONEE1MHVaV3RsdkZicU9Lb2dWbm1GUlQ5NUl0ZDhINS9SQVM2U2py?=
 =?utf-8?B?d0JtZDJwcTlvWU5BMVl5WVBnRGhPNzZYUXJuVWkzTjI3OW5rREhzTVdMRnM2?=
 =?utf-8?B?QmlxSFdRZ0hkV2x3bU1hSGFqM3FNZTlCeHc4cEUwNm9OWmx0ejh6aDRsY0NO?=
 =?utf-8?B?azlQWHRYbGhrTWd0ekVybkROQk1Cc3VhZWVBL3htNkVHWWdQdjBwbW5XY2Rt?=
 =?utf-8?B?T1JYSUtWUWNNTUZ1eTR6b2FrTzRVUGNXajRucmV4UTlQZUlCMENjRnJJcjhQ?=
 =?utf-8?B?UExpRGpRTmVaWlByYUVtcVBUMFY5bEdRS1ludkF0WHVNbDk3OTVZdlVDYzBj?=
 =?utf-8?B?dHJGZExnVDkxZEt1REs2Y2dzQWlBUmFaSlFLWGQxbnNlZm1UVEJpeENPeFRS?=
 =?utf-8?B?REY0eWtva2J0WFJmaCt4UVh4TkJ6SHZHYk9Ub0IzYnd6d3U3UVBsYlo3a091?=
 =?utf-8?B?bTRUWnFCcFNQYW90a1RweVJRc1BsMTFqeW9ua3NWSEVEUUFuTHFLS2UrZ1pn?=
 =?utf-8?B?ZnYvaWZLeGtvempYWEdtWUdGaDRBNVduODg1cTJkRVR5WVY4TnBvTEd6SXpa?=
 =?utf-8?B?V2RhYTB0eHdFWnFNb0hoYWNjWTEzaG02ME9YWDVGYzlpNEllZXZDQVllVUpt?=
 =?utf-8?B?VFdYaEYvUWlWQzB2bjdOWDNmdUUrekYyQ3JhL3ZleUcyamNVUmNKVXJ3OHpS?=
 =?utf-8?B?cWVhV0hQb0N4Z3N0bU54Z2t4ODcyYjFqTCtHaVNYNnJRSnBJTlhQYndLTStw?=
 =?utf-8?B?a29LT2NnTk45Z0lMNm4yS1hZVHkyVFZTbFl4OHFGSkFlSUt6Q0FlelhNeTRI?=
 =?utf-8?B?Z2p0VWJ4U01CRjdwclRCSlFUaGJZQ01uOFVKUUV2U2NzejR6T3VaZzdNUExT?=
 =?utf-8?B?aE5HcnpiVm9sbmdnQ2kxMW9vdjZPZ1hTZGUyQ2NsSmRFRWhBOVBndm0xZ3dD?=
 =?utf-8?B?NVdKeGlzL2l3SFNkb2RPUDhvRC9zeWlzcnZQS0JIYW5WRnFwRk43eVJpSHUy?=
 =?utf-8?B?ZDZLamNyWUNjSWY2WDZvOWhEQ1ExTm9MNVVlNHlCWGtwZ0JkWkg5SWpkaFdQ?=
 =?utf-8?B?RlNYYVNZMVFQZGNwSkdaWE5JRGdrU29qZlFQQm1qNFp2NkRpSVUzbXVvUU5I?=
 =?utf-8?B?bnorb0NlZitQUzVmdVpWMWRuNjZnZTBtMXJMbGFhcDRTbVBudG9OeWU4L0Qv?=
 =?utf-8?B?WElCek9EMktTRE5TNW02bzJucDNkUmVCRmhvcVM5eVVXdG0wZVJEOFpOV2JN?=
 =?utf-8?B?eFVEenQrVk1oRERYdlZ5bkhTd0p6bjB4MGNVZEl4Wlo2N1BhYUZoRlBJWEJw?=
 =?utf-8?B?dnRnNDZSaVpXSnAxYzhDWEcrYVdWVDB3RFliRVd1MDJ3YXFhZG5rRjNwTUNO?=
 =?utf-8?B?dllBSjU2YWlGQXQwblYvWSt4U0JCQ2FaQ0VYWTdsL1ZtZzlsaGRWMEYzZS9z?=
 =?utf-8?B?MTRjdmRtVzg3bVBoYUdUbFhZaGh2TytzTzZjTzc4aStZOWwxeERhQTdzMXJW?=
 =?utf-8?B?dkNwTVFnMXRMVmV6eUpidHZBTHpCL3UyS2FRZFJienhudld4ZEFMeTN2ZUw2?=
 =?utf-8?Q?dmjo+WT5V9/G8Ttu13UCMOBli?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6091eca9-aa68-43bd-cb68-08da7c31053c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 07:05:21.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kScs9fBlbR7UDf/85S8rzvtpPW2fqZqW8HuJJ+v2lu62pILymi+YfKgtwn++S45Ud6xa8dXeLJXtmcIk8/OGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 19:13, Alistair Popple wrote:
> When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
> is called to migrate pages out of zones which should not contain any
> longterm pinned pages.
> 
> When migration succeeds all pages will have been unpinned so pinning
> needs to be retried. Migration can also fail, in which case the pages
> will also have been unpinned but the operation should not be retried. If
> all pages are in the correct zone nothing will be unpinned and no retry
> is required.
> 
> The logic in check_and_migrate_movable_pages() tracks unnecessary state
> and the return codes for each case are difficult to follow. Refactor the
> code to clean this up. No behaviour change is intended.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

OK, I've finally convinced myself that this is a correct transformation.
This cleanup does help clarify things, definitely.

I've got two documentation additions (and changes) to suggest, below, and a
couple of too-long lines, but the code itself looks good, so with those
tweaks or something approximating them, please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

...

> +/*
> + * Check whether all pages are pinnable. If some pages are not pinnable migrate
> + * them and unpin all the pages. Returns -EAGAIN if pages were unpinned or zero
> + * if all pages are pinnable and in the right zone. Other errors indicate
> + * migration failure.
> + */

Instead of the above, I'd like to suggest this:

/*
  * Check whether all pages are *allowed* to be pinned. Rather confusingly, all
  * pages in the range are required to be pinned via FOLL_PIN, before calling
  * this routine.
  *
  * If any pages in the range are not allowed to be pinned, then this routine
  * will migrate those pages away, unpin all the pages in the range and return
  * -EAGAIN. The caller should re-pin the entire range with FOLL_PIN and then
  * call this routine again.
  *
  * If an error other than -EAGAIN occurs, this indicates a migration failure.
  * The caller should give up, and propagate the error back up the call stack.
  *
  * If everything is OK and all pages in the range are allowed to be pinned, then
  * this routine leaves all pages pinned and returns zero for success.
  */

> +static long check_and_migrate_movable_pages(unsigned long nr_pages,
> +					    struct page **pages)
> +{
> +	int ret;
> +	unsigned long collected;
> +	LIST_HEAD(movable_page_list);
> +
> +	collected = collect_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);

There is no reason to exceed 80 cols here.

> +	if (!collected)
> +		return 0;
> +
> +	ret = migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);

Nor here.

...

> @@ -2051,10 +2079,10 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>   			break;

...and in this routine, let's fortify the comment like so:

@@ -2068,7 +2078,15 @@ static long __gup_longterm_locked(struct mm_struct *mm,
  	if (!(gup_flags & FOLL_LONGTERM))
  		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
  					       NULL, gup_flags);
-	/* check_and_migrate_movable_pages() assumes pages have been pinned. */
+	/*
+	 * If we get to this point then FOLL_LONGTERM is set. And FOLL_LONGTERM
+	 * implies FOLL_PIN (although the reverse is not true). And that, in
+	 * turn, makes it correct to unconditionally call
+	 * check_and_migrate_movable_pages(), which assumes pages have been
+	 * pinned via FOLL_PIN.
+	 *
+	 * Enforce the above reasoning, by asserting that FOLL_PIN is set:
+	 */
  	if (WARN_ON(!(gup_flags & FOLL_PIN)))
  		return -EINVAL;
  	flags = memalloc_pin_save();


...and with that, it's actually possible for the reader to work their way
through this story, I think.


thanks,
-- 
John Hubbard
NVIDIA
