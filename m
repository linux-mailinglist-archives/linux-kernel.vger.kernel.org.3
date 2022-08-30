Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65B25A71F5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiH3Xow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiH3Xou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:44:50 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E01CD3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCJrXq0ie9S/BIkq2I83ufWXOHI6CLKTDJdNBd259Sgq+5f31RRU4C79ITcsdQWLAYbGHIo+2vfgaZT6zAdWbqJ23hzhrDB6UUULJ3SjAiAgL58cPHosVVz/S3C2/sIOG3Epx262yiXsX3xqGdwY4O3ztzy4tloXmorPf9d/ybPSA92FwPrH7WWXSvIzbQbI48SmrsUnMBOC74GZn4nQAT4H0TYjTBoh0blXJSIclR7onofLcSLEqS8bcKGGVjVMGuTIDzL1LMheuLJL3L5xpSRMIeSHWeJlpHlmRQ37+/sPfd8h2yiC8pvscX+/uWUOA1xxYJFshgiwkDIFEPDElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGtTPhzl00hXOKcmVzNUprnLZEqEjnE4fOGl/qLWl9I=;
 b=QosDrJ6Cvp3xN+jC9CR502bLbhBjIhpfw4OE3KQbCMhfgoqdig5EB3GdLGL/G6/ZObKpTtP9LGzf2JqHNPfpd+FoIiibyiaxIUDUdc7g1d3Mq09bfDM6U6QfO3YF1iaRiQi1aVvzaufXiToRbXK2CGoBNtW7loSH1hHt8TQo0FpAEDy6xdLu1vT0e3lmjfji1E375X7qwZkZjPjv3H2V82YMyO1/YXgcQy8TGHWcgNvjjjKEMDvxJmonUxpdfVE8SISIey/hBBEZvmfhh6cCAAj/nsHfasSApny2dxdoCrFD6y1ZH0m/aa54e9Gp06gU5UboVkba55kB1P42uGv31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGtTPhzl00hXOKcmVzNUprnLZEqEjnE4fOGl/qLWl9I=;
 b=DM2ZQOzV2zuINV9PZrRZax7E1fcN0b2YGEAT8vPcIlmRgCAp11986mUxJgNvfHV/fCAUHIEtt6MxGINwmmEfFg+jEOc26P/++C6HUX4k24Kp32O9ekeXsRuFyYwUwXMh+i6PplOhaz3laZ7Ndsl/7g6NtA6BCdLf+3d4oflUtlBaayxp82/JRPdvkwiSkvDKZuBJ/LUnP0sDmnfCzsulQL191T8QpMbpJ22jYuEc3SDylu20dD4l1KbAw7mjrGrLzCw6Fj+eG7vn/DTmhKLxaanZc0L+/XZifZJFl6NK6rCVeCbpx86uYJBdIv/yU4H3pVv9kIdDZjxs1KUWriHuhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 30 Aug
 2022 23:44:45 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 23:44:45 +0000
Date:   Tue, 30 Aug 2022 20:44:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v1 2/3] mm/gup: use gup_can_follow_protnone() also in
 GUP-fast
Message-ID: <Yw6g7G4jvXaoBORm@nvidia.com>
References: <20220825164659.89824-1-david@redhat.com>
 <20220825164659.89824-3-david@redhat.com>
 <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
 <2e20c90d-4d1f-dd83-aa63-9d8d17021263@redhat.com>
 <Yw5a1paQJ9MNdgmW@nvidia.com>
 <9ce3aaaa-71a6-5a81-16a3-36e6763feb91@redhat.com>
 <9a4fe603-950e-785b-6281-2e309256463f@nvidia.com>
 <68b38ac4-c680-b694-21a9-1971396d63b9@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b38ac4-c680-b694-21a9-1971396d63b9@redhat.com>
X-ClientProxiedBy: BL1PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::8) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a60d4c5b-da3e-466f-7398-08da8ae19e61
X-MS-TrafficTypeDiagnostic: PH7PR12MB6537:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUkelN8v+c88YaA3kMaynWkXtzxwXXsc63HgJ7meKBU3nluJTXyCo1EUBQkA/8wqFohh98aXyEdXofSm3U5EBAxF0wBlnbJVYPk4PbUNB0Nysr/JmEJKDBB4feaVvHbqd6UwLED0Mig2d6zDbNMXLKRJoZfM2DKx2wKTl+N7bBcd/f3GpSwjbOOAKtkeRasPjazx5JiG6a22Xt7loGuFQhwD9YjL+2q8THjRgF0sdy6J5+Oo6xvCHL/n1718T+03CzaVx7G1mvTrs+UtfbgWzFNiydjpcSTKWB0rDPO3dp8cmIhAmgNs0so0kAaAHXYg+EZkz8d3KrQDDUYNBw1IqupPYWmCYwTiw2w5kQU3M+SgW2hmuucelyCaE1m1M2tCWfAZI33DBMY5+ZCHxwVWPeq6YufX3pZyBiWf89rJV/ccMlodaCDt5N9IIt4uTkz4kOeCIO/TZFU+0mn7/v/qzTJaLjynJ/jATDxks8elxR1Y7mEpmC9M61TGG5jZ1dSe4Kemsr+p83DexDBYiaXRuFc29rnIUJemnghVkaxLSFK3wvedatzd53Fi85gw7fbufrDQu7Bywe7btLYfnWQ7GiUfFKfHev1q9IvA1N7qYvAx/pppTuoc/m6HAGwWWdtPSvHm7qVYQYXOjjsHIDv0GekQDBr+Cnp981Hf34ATFH9PyLwdeZ40XYY/AJc9KKzwI9ShIE0nXrOuYI3Ojz07Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(6512007)(26005)(316002)(36756003)(54906003)(38100700002)(6916009)(186003)(478600001)(8936002)(8676002)(4326008)(6486002)(41300700001)(5660300002)(66946007)(66476007)(66556008)(2906002)(86362001)(83380400001)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kbuipTKTwWBHaVVO9Ahk76/yQGcBkG5ScJ6xs4ek2F5W39dVk6GnXtimQ9hm?=
 =?us-ascii?Q?29Hk1GdLkokbZIAtvPcj/KhHqK9EwAdL67NUyJibokzPXsiLpozyeGHXhwFj?=
 =?us-ascii?Q?qwbwIDKbF+SZJ/+RP3rULhbqNBxFiY/sCLlEvf+MU2vHD0ND1qFDNJ1yCjc4?=
 =?us-ascii?Q?zEO5d/ZXqOls7Q2KhrstOfXKHyuZIpXKnaxiG4tbmYdbcYGyE5PNn7DDCSld?=
 =?us-ascii?Q?K6OXOTE+NVK0T4WhWvMVuHCxYvOU/HKtnQQUInPeGP6i/JxTef+3e7BQgO49?=
 =?us-ascii?Q?hn5GNduv2WwUewem6l3eJcMTFYtSFlNeX7WsGsoKPxbd0Dfo3azCvrFXt31D?=
 =?us-ascii?Q?Al3MefzoYJRw8aQ/CuWAd6amshjovXt3K9Xm+qOr/tpfEAXTI2i5Tvrmaepm?=
 =?us-ascii?Q?Zj4YaUD0XbvGDxlf5ZU/XVHHYJG5IBED+MO6jU62+ypZENl3SA9txy6s+er5?=
 =?us-ascii?Q?lKQk/y+Ibj1nO238qRAI8OpTq1ABnfS70aDI/9alm0bSWVDCGxaa5eb6h8hr?=
 =?us-ascii?Q?EOjvoMpzW19Gs1R6omLEFQP33ygltQ+4t6vAk3Ra6on3nn9sm4RoycK+rRUC?=
 =?us-ascii?Q?hqmcwWNbLlhByEEM9HORHvKqisrPuUknAX5EG8GwVtBsW8WBU4OyxTlOPFib?=
 =?us-ascii?Q?AdvM3q/PqHjUetenpIim1rLNEPrOQuPwy9aZVXxrZqbWi4dUONgRPRnC+Api?=
 =?us-ascii?Q?RBiN23Ns2qsSGxJVjOd/VtjvhcJelp/uJ5HueIqlHHvF9CWQMvmstRQZJUX/?=
 =?us-ascii?Q?G47RQzDY4kSfovYAWkQJudsa2eMAvdLJ6FH6qXj+L+MKRb3aij//4gGrYLNo?=
 =?us-ascii?Q?r3NNC+m4QJuyrq67yhtQvlKNOEs5uI3PQo2E2FdltpwZhunrqw6NYdI1MhJ+?=
 =?us-ascii?Q?uzYZGCwCcf1IXONulyX/EmiibCJG05gNPq1ny2INsPdRMv0LA44gYrVvwKLs?=
 =?us-ascii?Q?QR3mSOQ4DJm+e2CH538BiFY5uUyyp6YkXMyKMRd2VVdO3X/elVjYjdNc5qX7?=
 =?us-ascii?Q?ezf4Z4rEPgIRG9pv+Yz2ZkoYcjDqWVwg8EUWw+eST1X66WONuXmZQsCWgcEx?=
 =?us-ascii?Q?h680r0mL5PKsE+YykNTQMrEhJRTVGHKefDdUIHmpmEi8m2Ty//Zk4u11rqKG?=
 =?us-ascii?Q?Jfee6pPaOfolNboZWp3rDDy13gv3CpiVLOI8dL+iwQMHtSsSQC5lm/zfBopm?=
 =?us-ascii?Q?md1vujN7aVs/P8IsFxX5o+cv5gZCaCWmkpG59CznNlMjcgHd/ipSB3/KAXC7?=
 =?us-ascii?Q?MpKfIYNCkxPz11PCmcz1UzooTRWDQNflCygjwET8nlT4KClmvID1PTgwV8I2?=
 =?us-ascii?Q?PhrOxDFq2zm/s4e12VCaQm5VM4pj8Istp5QHR9LjMTIr7Z88YD1upUGZRKpJ?=
 =?us-ascii?Q?/sI3Jpy+0A6VcM2JtKGnz7MGw7tg9+FA6bh0SdaW3TVv5p6cxkzkHt87IEvS?=
 =?us-ascii?Q?5S/Z+0qKMzAZ/jGjSuI932no3zmUDbXOmQ8tDHO7HZ/jkgMFpsb4teroVsa7?=
 =?us-ascii?Q?Hd4TiHgaMB8YbrI7iWiXLde0azXrMwTP6ernZeCHajW1TxfxwexpBMoiFwRt?=
 =?us-ascii?Q?R/TeXyYTm/K4SPXtEUN9k4B835KVhb6H+keY1KH/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60d4c5b-da3e-466f-7398-08da8ae19e61
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 23:44:45.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frmyeL4hRe3LG6vRdpT9oDYx7bqJyCTeuOfzl69uIviKTjx8Rcy8RAaibHNnBOkq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:23:44PM +0200, David Hildenbrand wrote:
> @@ -2997,6 +2997,11 @@ static inline bool gup_must_unshare(unsigned int flags, struct page *page)
>  	 */
>  	if (!PageAnon(page))
>  		return false;
> +
> +	/* See page_try_share_anon_rmap() for GUP-fast details. */
> +	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) && irqs_disabled())
> +		smp_rmb();
> +
>  	/*
>  	 * Note that PageKsm() pages cannot be exclusive, and consequently,
>  	 * cannot get pinned.
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index bf80adca980b..454c159f2aae 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -267,7 +267,7 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
>   * @page: the exclusive anonymous page to try marking possibly shared
>   *
>   * The caller needs to hold the PT lock and has to have the page table entry
> - * cleared/invalidated+flushed, to properly sync against GUP-fast.
> + * cleared/invalidated.
>   *
>   * This is similar to page_try_dup_anon_rmap(), however, not used during fork()
>   * to duplicate a mapping, but instead to prepare for KSM or temporarily
> @@ -283,12 +283,60 @@ static inline int page_try_share_anon_rmap(struct page *page)
>  {
>  	VM_BUG_ON_PAGE(!PageAnon(page) || !PageAnonExclusive(page), page);
>  
> -	/* See page_try_dup_anon_rmap(). */
> -	if (likely(!is_device_private_page(page) &&
> -	    unlikely(page_maybe_dma_pinned(page))))
> -		return -EBUSY;
> +	/* device private pages cannot get pinned via GUP. */
> +	if (unlikely(is_device_private_page(page))) {
> +		ClearPageAnonExclusive(page);
> +		return 0;
> +	}
>  
> +	/*
> +	 * We have to make sure that while we clear PageAnonExclusive, that
> +	 * the page is not pinned and that concurrent GUP-fast won't succeed in
> +	 * concurrently pinning the page.
> +	 *
> +	 * Conceptually, GUP-fast pinning code of anon pages consists of:
> +	 * (1) Read the PTE
> +	 * (2) Pin the mapped page
> +	 * (3) Check if the PTE changed by re-reading it; back off if so.
> +	 * (4) Check if PageAnonExclusive is not set; back off if so.
> +	 *
> +	 * Conceptually, PageAnonExclusive clearing code consists of:
> +	 * (1) Clear PTE
> +	 * (2) Check if the page is pinned; back off if so.
> +	 * (3) Clear PageAnonExclusive
> +	 * (4) Restore PTE (optional)
> +	 *
> +	 * In GUP-fast, we have to make sure that (2),(3) and (4) happen in
> +	 * the right order. Memory order between (2) and (3) is handled by
> +	 * GUP-fast, independent of PageAnonExclusive.
> +	 *
> +	 * When clearing PageAnonExclusive(), we have to make sure that (1),
> +	 * (2), (3) and (4) happen in the right order.
> +	 *
> +	 * Note that (4) has to happen after (3) in both cases to handle the
> +	 * corner case whereby the PTE is restored to the original value after
> +	 * clearing PageAnonExclusive and while GUP-fast might not detect the
> +	 * PTE change, it will detect the PageAnonExclusive change.
> +	 *
> +	 * We assume that there might not be a memory barrier after
> +	 * clearing/invalidating the PTE (1) and before restoring the PTE (4),
> +	 * so we use explicit ones here.
> +	 *
> +	 * These memory barriers are paired with memory barriers in GUP-fast
> +	 * code, including gup_must_unshare().
> +	 */
> +
> +	/* Clear/invalidate the PTE before checking for PINs. */
> +	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
> +		smp_mb();
> +
> +	if (unlikely(page_maybe_dma_pinned(page)))
> +		return -EBUSY;

It is usually a bad sign to see an attempt to create a "read release"..

>  	ClearPageAnonExclusive(page);
> +
> +	/* Clear PageAnonExclusive() before eventually restoring the PTE. */
> +	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
> +		smp_mb__after_atomic();
>  	return 0;
>  }

I don't know enough about the memory model to say if this is OK..

Generally, I've never seen an algorithm be successfull with these
kinds of multi-atomic gyrations.

If we break it down a bit, and replace the 'read release' with an
actual atomic for discussion:


       CPU0                  CPU1
                            clear pte 
                            incr_return ref // release & acquire
 add_ref // acquire

This seems OK, if CPU1 views !dma then CPU0 must view clear pte due to
the atomic's release/acquire semantic

If CPU1 views dma then it just exits


Now the second phase:

       CPU0                  CPU1
                            clear anon_exclusive
                            restore pte // release

 read_pte // acquire
 read anon_exclusive 

If CPU0 observes the restored PTE then it must observe the cleared
anon_exclusive

Otherwise CPU0 must observe the cleared PTE.

So, maybe I could convince myself it is OK, but I think your placement
of barriers is confusing as to what data the barrier is actually
linked to.

We are using a barrier around the ref - acquire on the CPU0 and full
barier on the CPU1 (eg atomic_read(); smb_mb_after_atomic() )

The second phase uses a smp_store_release/load_acquire on the PTE.

It is the same barriers you sketched but integrated with the data they
are ordering.

Jason
