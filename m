Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C35E5862B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbiHACiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbiHACiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:38:02 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B28F13D0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fz3lpTViTjhva6J1mqXYwfFNVzAly7AjTXtmnThk/c4oJc2z/ZC+bqIHs3eEyRKMRUFFLhx+FDJvVYRQYaqs+SmKUMfBxg/wh7YfVxZXaD8wvQmE8cOQmi+2wRqT+voUa9wURk+svd2ml1OED7cycKqqNv8AjU7a3qSLfvJxy/C3neUf1Z0MYItdafW/UWpXpjBYVDWQ+HK+zdvZHLnrQZyxvNOO90VS9Bxx2Qip5CuxvHBW93x+snQWM+0Ayu50+0vVhq3t7ygPmpVHy0XqKjQ7wQE0gARilfv2mIuAJX4hLx0Sjy5NoER88RGJLKEf+K6Hs9nTQ3uCm0jznNKO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrcUps18vB5bod0fOJ3KuFyo0PmOkDg1fSqhtR0+Yxk=;
 b=gnsOXGx0IGu3ta9tWVYdPXlEGhdCpn+Xjiv+WXgLnG7FZN4YonOYNPdn2RtUjS2YQ17Mu/eVNsOAIfm9Lzr9XmD1B9bDpey91YsdipkysvL+2X7oEHUPL3CIQJLJFS5DNwhl3lnMkqlzaNhuroFB93uIwnGjDd58AdkbsozAu2knUWV/J5wxbEmGmj5xRuegcwg7v+aLgOTVRS5GA1UGSgvP5BsA05Ozw63YFM5otPV9OyfwyWdG2UzigESWBQ/wo/pTJmetzjOV2cqWhh2RHf3l5mdvF4o7jsP16cQfsrAGNRAM2ot4+cHQ5JNJTUxL41fVPAVDQzAUzY8GTmVs9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrcUps18vB5bod0fOJ3KuFyo0PmOkDg1fSqhtR0+Yxk=;
 b=oO8ezzL/WS70NjvkcF2JAi9SCi649rE1G4UlB5vHBLVtJPw27U2uAkL8/eeG0AKqMTV+soo2oIQhkTe3rbZXNFfiqtwoR5Oz5yR3pE+rlGu7eZNqs6oG73nkCxzI9txUmdevLChcphqIX9BY3JPlRzjmzqfxALaBpoKKhbqXpLRGPL8tqLBtdudtdGA1hydoMc3UptMN6YPYqu95t6nGiTp1r1ljYxIV0+JTkx/3AkGN7E0VrLKT6sqlM2vOcTXlBcqplO3b00VMu0GCuE0/I8NiEExgqHMaQY14tHbMbO59SuwtNPyVfaOK5IhhJC7RUysz6tkFjj2B+jlyOR5nmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BN9PR12MB5365.namprd12.prod.outlook.com (2603:10b6:408:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Mon, 1 Aug
 2022 02:37:57 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 02:37:57 +0000
References: <20220729024645.764366-1-apopple@nvidia.com>
 <YuQ4mJqjIUncf7iF@nvidia.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        pasha.tatashin@soleen.com
Subject: Re: [PATCH] mm/gup.c: Simplify and fix
 check_and_migrate_movable_pages() return codes
Date:   Mon, 01 Aug 2022 12:18:53 +1000
In-reply-to: <YuQ4mJqjIUncf7iF@nvidia.com>
Message-ID: <87wnbsd6yp.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY3PR01CA0085.ausprd01.prod.outlook.com
 (2603:10c6:0:19::18) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7c38368-6f37-4a71-9dff-08da7366d79a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5365:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ni5r0hSaNgnY8HjevBxBaNdDmmfeUa/5V4KtBapct1TgHwiYaGnspyGd1wyUovkS85NrGP6kd5oEVhnrJVRhvBGKYvBquxctlA9P0KYvzTyXNBQoR9TdSh1C/8Knu2IRLquFg+o2/sy2jdBMrW83O9t2X23YzoKHctk2A1EMTZHe3t4mKHiK0xMg/oUptBo7hqXC38Lwh4ojz1VWrNIpKPqoE1WYP9AhIkiuacez5X2NQC/oDc9TuuoE9+jjcSkjpQGciIOrKOsMOLbTwHk3gGeA7ZNEa+bYUeFprd2l2lt+JbPCwaQX5u1BU9OTkce1ABp9IlPAhwYHYFCu/myV7NZEbexRzE+cXrM3kTu1gjs+k225CpQdOHLewXvyjhqKs5KQVHbgsYMdxejUxuUGR6BjN3Z2G4zsvPxhDXsK9Ga16G30D6+zb87QPEyGmATa81mO7PrV3kk8NYm8bU7vzqGdTnqUFja5/XR1reeOhPUEh6DUMSzMGlqrjvM4bL0ByUgMiSDMfj3jbmVB7KNhN45dYPvWlSnGwWiaMZXHPib4GOpLrVlBrizxyUhPsALZw+0CuXvsFU9CTWi+2wdxmv0j5Dkag5Q7VwwTyTx2lAYLs9eh2p0sQrVXX5+u6Ui+CVhshPXLOiaAXAwmaKLBDsIJSVkSXiCaRFuLfLOeWKXSp+CCOhT9AQ3h/GSwElgZpPwK0khQqT3J8Zx1IfBGugsHnTR3VFnTchLly+XjMVrbzd65K/Yn8UNxkf+GDIHZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(83380400001)(316002)(186003)(38100700002)(4326008)(66556008)(66946007)(6636002)(8676002)(66476007)(8936002)(6862004)(5660300002)(478600001)(6486002)(26005)(6506007)(86362001)(6512007)(9686003)(6666004)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n6nihQf7sMoRLouvH9okDAWwIRgIlZ9oBegbom5h12YMlRUaVidEGVj4VVaK?=
 =?us-ascii?Q?tEWB5913JiFWbnZbKjgiTtfVnVi0sscSB3GTVtzn1sLkvT9QQGittF49M7oZ?=
 =?us-ascii?Q?hL2AsiN4zgjdv5Mm9T3YefsZ1l+citA0XUevLu8j6CMT3di8+I5GHNAte5qn?=
 =?us-ascii?Q?Zq4RfxI00V7j8ypAC56H1X/389MXUii2kLdmteTANHYEdEZVEUGQbhqBFYkN?=
 =?us-ascii?Q?BoOyRy5DkOSdVr7gh/cNJPz1Atn5dXa4IlFkrBLg4w85vB6Zpu9dvKpnQcf4?=
 =?us-ascii?Q?muhzs5lyVo0ukABhECI4HjQyBMLXHo7g3ws3UfbTyTSekMMSCICCxtrFgt0i?=
 =?us-ascii?Q?SYFHrBXfjebfJJw5UsSBtAxKxDWyv9vQew0QtP8eDWva0QC6D0Irz2NZOM8N?=
 =?us-ascii?Q?YLQl1l26xrNZisYS+UE+0jiub2cFifVlEJa+Ou7vOWAoDomvMF5eU9ygo0MZ?=
 =?us-ascii?Q?oyy4lEx2FaJByuqxIgO+J/MzSeWeK6U1TQflDcHsS7HEpGczsNNVVOrMLIAy?=
 =?us-ascii?Q?zB6or2Z9Wik1Clu2+2nr3JHu3xIB98GwG6C0QBlWhV8zMYZ4zIQTXVIEe1JF?=
 =?us-ascii?Q?5M/CH+g1fW9bb6S0OfO8cs4YtcMvKbhVYWTN8kHl9zhnuID+gATrpEnI6NnU?=
 =?us-ascii?Q?NgDtz5UXLmB4AewI5z5W+6CXNGWZThECXEOWh7ba5KsFKE77L9YtCV9ll99y?=
 =?us-ascii?Q?4t0Zoss/rX30pI7SB7epM2TDlvMpWlbwRc/oyFORy45Mg+j0GNlJQRpjHT3I?=
 =?us-ascii?Q?ryWJAj5yiZI/aPkJxnDG0z1QR5ysVSxXBD6Vwuv1C0zI3kBWqEwgQo8U3ZcE?=
 =?us-ascii?Q?V2q4z8GLqC19dtouEahotaQypeTpjqPdHB8x+z31EBHTkBzjpzC7M+mdbVEb?=
 =?us-ascii?Q?c589OJl7Ksp6JXDNW9xBwz9NHUPAqEfZhuAMxVg/8PwAWlxwfx0PjU55Dop3?=
 =?us-ascii?Q?OsIbCAaNd5517rzHyQZjcwimYHA2BG68iHuoaFFWcutQOkGwfywREjGR1n6M?=
 =?us-ascii?Q?xB+gEp7B1RGMcgb9DMzAaOhTgs1PQEY1hI328pRfpN6Zu8idE70pg0OQxD89?=
 =?us-ascii?Q?UqZK3vYTIIUcdOXF6r+sU3e8D64DIeOnn04NxGxYToI8DrVju04tk83KChvm?=
 =?us-ascii?Q?Uan3CJAL9Z2UZI/dEkLOQ1s30xIrBtojf3HcSbWkHmeJm9DVM8TXBFuipOQR?=
 =?us-ascii?Q?Wiv5VDivwbiuCZqohuygPzGIfwRBt/H4sHRnWotPvGMRQkPI6XLXE5rtW5rC?=
 =?us-ascii?Q?Gcc8nMVsnxDFrHhcrqS0gVE6XxuO3u4zLv6JK05kF06Tm5LnTUT1h4GzVQ5D?=
 =?us-ascii?Q?CkoqjeaCKKqDEPmBhy8fzeWFp7S+ngYRYasuwuQexcNWugfppMhv6/raFQu8?=
 =?us-ascii?Q?ZBAYKJJZLt4Dikvnd5b5jG6Id9nLUlWcb72aVkNrc64f6ioHvz7irYAL1RFC?=
 =?us-ascii?Q?A1rHd0RDiFP7Mp4TtnQ5+La9p3cKMhwulX6o6vSjiqm1f2OEUy7jwb1400JB?=
 =?us-ascii?Q?SItRet54J3Sze1cYebcqHgZWP6eTLFD0cOTR5fvoOiInxND8CZqT+4tT0rID?=
 =?us-ascii?Q?pdfphtsFpHL9GKCdQRdUndEd/ECBvfubxWZPuqWT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c38368-6f37-4a71-9dff-08da7366d79a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 02:37:56.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGz2sx6yONjaqLv0gRxgQm8MVGTY+YCeYpwNqjnyWVCdVJTJ/iFGGOrSVgIKaOUCpfK1WUm21ovMHciolAWhNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5365
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jason Gunthorpe <jgg@nvidia.com> writes:

> On Fri, Jul 29, 2022 at 12:46:45PM +1000, Alistair Popple wrote:

[...]

> I have to say I prefer the usual style where all the places that error
> exit do 'goto error' instead of trying to keep track in 'ret'

Ok. Part of the complexity was my understanding from the documentation
for migrate_pages() is that putback_movable_pages() should only be
called if migrate_pages() != 0:

 * It is caller's responsibility to call putback_movable_pages() to return pages
 * to the LRU or free list only if ret != 0.

But I think it should be fine to do regardless, because on success the
pages will be deleted from movable_page_list. Eg. From unmap_and_move():

	if (rc != -EAGAIN) {
		/*
		 * A page that has been migrated has all references
		 * removed and will be freed. A page that has not been
		 * migrated will have kept its references and be restored.
		 */
		list_del(&page->lru);
	}

So will post a v2 doing this.

> AFAICT there is no reason to 'continue' in most of these paths since
> we intend to return to userspace with an error anyhow? Why try to
> isolate more pages?

The main reason would be if callers want to retry the operation. AFAIK
isolate_folio_lru() can have transient failures, so if callers want to
retry it makes sense to isolate and migrate as many pages as possible
rather than one page at a time as subsequent retries may find different
pages that can't be isolated.

Actually I should have called this out more clearly - the previous
behaviour on isolation failure was to retry indefinitely which is what
lead to looping in the kernel. This patch turns isolation failure into
an error and doesn't retry. I wonder though if we need to maintain a
retry count similar to what migrate_pages() does if there are unexpected
page refs?

>> @@ -1980,19 +1980,18 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>>  				    folio_nr_pages(folio));
>>  	}
>>
>> -	if (!list_empty(&movable_page_list) || isolation_error_count
>> -		|| coherent_pages)
>> -		goto unpin_pages;
>> -
>>  	/*
>>  	 * If list is empty, and no isolation errors, means that all pages are
>> -	 * in the correct zone.
>> +	 * in the correct zone. If there were device coherent pages some pages
>> +	 * have been unpinned.
>>  	 */
>
> That comment is a bit confusing.. I guess it is trying to explain why
> coherent_pages is doing?
>
> Maybe just:
>
> All the given pages are fine, nothing was done

Ok.

>> +	if (list_empty(&movable_page_list) && !ret && !coherent_pages)

Actually I think we can drop the coherent_pages variable too. At this
point coherent_pages will either be in the correct zone or we will have
jumped to the error label.

>> +		return 0;
>>
>> -unpin_pages:
>
> Now that this label is removed this if following it
>
> 	if (!list_empty(&movable_page_list)) {
>
> is also now unneeded because the above 'return 0' already checked it
>
> I came up with this ontop:

Thanks for the suggestions.

 - Alistair

> diff --git a/mm/gup.c b/mm/gup.c
> index 9e7c76d1e4ee3c..eddcf3c0eba727 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1912,11 +1912,15 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  					    struct page **pages,
>  					    unsigned int gup_flags)
>  {
> +	struct migration_target_control mtc = {
> +		.nid = NUMA_NO_NODE,
> +		.gfp_mask = GFP_USER | __GFP_NOWARN,
> +	};
>  	unsigned long i;
>  	struct folio *prev_folio = NULL;
>  	LIST_HEAD(movable_page_list);
>  	bool drain_allow = true, coherent_pages = false;
> -	int ret = 0;
> +	int ret = -EBUSY;
>
>  	for (i = 0; i < nr_pages; i++) {
>  		struct folio *folio = page_folio(pages[i]);
> @@ -1948,10 +1952,8 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  				unpin_user_page(&folio->page);
>  			}
>
> -			if (migrate_device_coherent_page(&folio->page)) {
> -				ret = -EBUSY;
> -				break;
> -			}
> +			if (migrate_device_coherent_page(&folio->page))
> +				goto error;
>  			continue;
>  		}
>
> @@ -1963,7 +1965,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  		if (folio_test_hugetlb(folio)) {
>  			if (isolate_hugetlb(&folio->page,
>  						&movable_page_list))
> -				ret = -EBUSY;
> +				goto error;
>  			continue;
>  		}
>
> @@ -1972,10 +1974,8 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  			drain_allow = false;
>  		}
>
> -		if (folio_isolate_lru(folio)) {
> -			ret = -EBUSY;
> -			continue;
> -		}
> +		if (folio_isolate_lru(folio))
> +			goto error;
>  		list_add_tail(&folio->lru, &movable_page_list);
>  		node_stat_mod_folio(folio,
>  				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
> @@ -1987,7 +1987,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  	 * in the correct zone. If there were device coherent pages some pages
>  	 * have been unpinned.
>  	 */
> -	if (list_empty(&movable_page_list) && !ret && !coherent_pages)
> +	if (list_empty(&movable_page_list) && !coherent_pages)
>  		return 0;
>
>  	/*
> @@ -2005,23 +2005,19 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  			put_page(pages[i]);
>  	}
>
> -	if (!list_empty(&movable_page_list)) {
> -		struct migration_target_control mtc = {
> -			.nid = NUMA_NO_NODE,
> -			.gfp_mask = GFP_USER | __GFP_NOWARN,
> -		};
> -
> -		ret = migrate_pages(&movable_page_list, alloc_migration_target,
> -				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
> -				    MR_LONGTERM_PIN, NULL);
> -		if (ret > 0) /* number of pages not migrated */
> -			ret = -ENOMEM;
> +	not_migrated = migrate_pages(&movable_page_list, alloc_migration_target,
> +				     NULL, (unsigned long)&mtc, MIGRATE_SYNC,
> +				     MR_LONGTERM_PIN, NULL);
> +	if (not_migrated > 0) {
> +		ret = -ENOMEM;
> +		goto error;
>  	}
> +	return -EAGAIN;
>
> -	if (ret && !list_empty(&movable_page_list))
> +error:
> +	if (!list_empty(&movable_page_list))
>  		putback_movable_pages(&movable_page_list);
> -
> -	return ret ? ret : -EAGAIN;
> +	return ret;
>  }
>  #else
>  static long check_and_migrate_movable_pages(unsigned long nr_pages,
