Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC6A533149
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbiEXTGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240919AbiEXTE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:04:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7401E26AED
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1VKamSzlsraVJJIiQFY6BKuTM5+F6a6siiIArlOZBhWv/yyaUKwWp2qcu7nl7GXqW5uJOjaMW28omyv+3xa8Fhba7MwE9gH8XOfehw6xxwTejDHbU4Hw/VczSYNAn/70RL+3AIdbi8cRMdo3w3v1InvHi5Ebml9fAbLTzEEP+hR1to+XdTOEGjWSg8CWkAgMUvwAgGZvZJG2AAuZ7LM/Rr57NCb7GIc64m1qQ77fFEyWJaThXl04gvaCBnX02oHlRaduUaGX/W1pw43cMhf9Nr3cc30VJQ6cnfyj6mEiWrGQ3JaD8aby0wrb7z9ijSpmiBREP8HWGJy6G2cPGk6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obdDqOaBxOR+f5k1WoCg9+0ScdHhzpTIFqvSEVOJ6e4=;
 b=h+cpH75XJ4cwPkrFer1kBXvm75OWsvXjzIyAQcvCUu4o/8O/e4UGKrMam50ncbiI9irz0J9oSLIQtASPK6RiT4MX7MYcSitx+bQupDD7xaoSON2w44O1pS4pWrfRYew7/pd+dOVN0GGYa8ciWmW5zTOYHfn+gvjaR3blqKS4+Cnsd1qa8vL6qjQ6MMDXA9rth63YkraoD0Zv30rMemnnInq4rSHxbXyS24sQAJwKpYTd08ptjrtKk0IWpesb1J9StSriAtPAiZJ6YEluyL0sDt0HMyF5/lnk/rCi41Iesj7gG0bXDwN1CI4oG0niMrVVHr92bNtYVYFOCb3e51wYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obdDqOaBxOR+f5k1WoCg9+0ScdHhzpTIFqvSEVOJ6e4=;
 b=PJWg0GrZ6bbzJOFKVw/85xv9bsFEyygye4VTlwPyTXhMZOChu4REhFjz9WU/+vclBSHpTnjMwYcx/kVZSUBH9dVA54E7zIl4JW6qqt8xhJk9Okk/TQIhkE++0hgfJo3CnuvseHZ/y//v2jIKTUPZ7lNn7A7V3OGN0W3bdOidwwr6eW0E2nBbf0ReSL6EvaMZA7Z2OBXXvgVIPcwsUUxQjptA0mlZN1bN0OHBjJ2jAn6+nsJ+BTiih3B9lFuaaE2SP18e5/yIZ/dVTUh+9vt1wDkObtZaNC3Wt8frC5te/Vp86Zhsb+oqsww6E/qwjGO4KB+RUkxvMkYuhjqhiXNgRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BN6PR1201MB0130.namprd12.prod.outlook.com (2603:10b6:405:59::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Tue, 24 May
 2022 19:02:24 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5%5]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 19:02:24 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Qian Cai <quic_qiancai@quicinc.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v11 4/6] mm: page_isolation: enable arbitrary range page isolation.
Date:   Tue, 24 May 2022 15:02:22 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <62568C66-1C4D-4A1B-A9AD-93AA67A9E4EC@nvidia.com>
In-Reply-To: <20220425143118.2850746-5-zi.yan@sent.com>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220425143118.2850746-5-zi.yan@sent.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_118F5FA1-84B3-4996-BED1-B8E6D2A94D5C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:208:329::18) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37bbbb8c-92e0-44bf-8685-08da3db7f05f
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0130:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB013009E5D1716A08546DF031C2D79@BN6PR1201MB0130.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pqlMQVqcz8Acu9hRCC3M1Ai+1eUEv0Mb8IViJ3/UjTE3oLGA/tFZGZA6cKENLBHvbDFa0y+EBGrB4+RabxNR9MJ2rCctHIEOq0vkjcFodHQMTYmXrsNXvYTDRGfAFMiBJbu05JMhOF9XGmrA0QYYiyAjvsaEudmN7UnMbb+aDyB/N16iFQ7w2r52Fc2yxKmZAeCYAxBzMa23Fuf84wc1iNJ8kWtGbKI+7WoibmRtXQ2LA7H6sSijLFvhYOE27COXG+hNiegqldAJRN7S9dF9XuNlIvjgg+K5qiQXSTPxaDa3VAVi5CX5vd+vpJlxfudTQLa7SvcFV9Fcn06Ne2A6V+Wdq/0lfBzGclSH/j+rA4gGoFifag2XdQXZnmrgIbgQEa5Cu4Y62/BhhsHz4gNlmiV4jlh3OICdXFmeWeybu88E3hjj6g6POXssba0auTI5wHsYcXm9faP1Jc9f5sb4c+SnX3Dkoz+J4Wz37XmS6NAmIbKdkjthmIJtS/g8JCtWBI8L9UoIpt1eX/96rD3K+IJih1cMO6WJS+X9h5ev9pJQ+jR6IfNKsyUViGaewYrDWdsrlBQUm6hWOsV34383XVd/WMlagqCNTeAkfq1Wntl37MrPNSm9+jjaQxCDnLetRKcANWRJA9FxAJCIK/wv9jhxWJIcpLIemnEjaSHgn5Ycvw2a8A6hY1phiKtHKFOu47zunw0W7/iNfPOLT4lRUD7OflVUvwr/BzyPnHVTl0XhpnKfwz15bom2c6dUVhIu3JC/HHV4WHT79Wdu/p1MCWyn4YgwNaP997rR1czdgJ4YyFs6+HuEojdnGy4EKLFm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(186003)(2616005)(8676002)(4326008)(54906003)(6506007)(53546011)(966005)(110136005)(5660300002)(8936002)(235185007)(30864003)(7416002)(21480400003)(26005)(86362001)(6512007)(316002)(508600001)(83380400001)(38100700002)(107886003)(66946007)(36756003)(2906002)(66556008)(66476007)(33656002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?enVwAwTgUHd9cKo+QzFFWBR0T7F82I5BxsqgbgpzJIlTGaBh7ZRWiPuxKbUE?=
 =?us-ascii?Q?ZLtxjRpRmAeI+eOPtXNAUNrMPW5rpa4sm2Mr25K4TDSzYjDSUAJJRkVlF8cQ?=
 =?us-ascii?Q?yS1Qzv9FRzg2rfdJbf2Kk9m6kTK/w9hCtN7/4MIt7Z48K4zV5325QjoQwtC9?=
 =?us-ascii?Q?wR3xIvj5WZGUH3R//8rXaoOB8xal7azFQ3UUXNTmd6Y/75eCI3oxqL/khQp4?=
 =?us-ascii?Q?KcbHgdsNVtznfandLSRClYBfcN2MEfA1ie3PDGaTwSS6QwH5yh9JNgzAbvs0?=
 =?us-ascii?Q?ODw5OBdOvDKAUiPeYna2M72Fh9plVP53cz0nToLXTcb9VY5a1JNJ7L6pWO60?=
 =?us-ascii?Q?tppbep+n667ozre8oHOcwH1mbxpR0GrJuhtBN1WFQZCKuPscprSFhO/G38Ix?=
 =?us-ascii?Q?CnsgJ2ifPMZNszfijwAoRg0DjG0YV9Si3ENd4LJbmiFzH6bpXTGkjQK9/j9u?=
 =?us-ascii?Q?rVRbrgzCL6RWJLSJXaCiHiFLnJ/6L1gTvCgxr/PVe7jU7qKzkmfGm6pYGv3T?=
 =?us-ascii?Q?iRLOCpQ6UBlAAUJ04owoNzLmRvirp21SreueusYs7lyxu9nH68m4tnga4udx?=
 =?us-ascii?Q?1Y9eEostbALWZVov6qJ1vuUVdVrjXHlVQyHs/aNqvCKpNTVt6dTBms7yfAZ6?=
 =?us-ascii?Q?9nGFgcBZAld9poWWqEFaIk7V8aZkyKxayxipA6Y2mfbAokiTtJLfj6xYzGyD?=
 =?us-ascii?Q?xhiCcFUkahUaEc4ju3Kni9iRF4p7kGsqic7+v6S19xyaCtwafJmdN0LgZ3EO?=
 =?us-ascii?Q?5oHUGRMT6Ig4OtbxZF/0KTh/bKKiYc3mfD/qgkBT7xozKGMKekgXZFEG/Mbz?=
 =?us-ascii?Q?Kd8COb8MKkA5T07ttLJGqdMYaVUdxiJqm3BmXHgUJ4DgB8aPOFbctn1rXFQp?=
 =?us-ascii?Q?/uTl+4OLKnpaPV1XXjaHV99pHI9SqkM3x2QmSoAqBLo9aiWocl7cyi5+YVmv?=
 =?us-ascii?Q?QIZRBzWNKwLo9txZ+JIH+1gDzTiMPZNBMSFo0NxfW/nY8Y1pazFFDlTSl3Z5?=
 =?us-ascii?Q?OcGggeY4qphgpcKB+hRK67KqAX8yckQkzjFiJWisvKRLJYKFnQ2lzM2jvgb2?=
 =?us-ascii?Q?7s2wN12UOIYlyQdHY15RrMvglZcBoHLO9My9vVVPTYYH/rITIGj+7reAkFv2?=
 =?us-ascii?Q?6Ng5pj+Gtlrr04nRytWWNm1UdLbtzEC+PyqvabrzT8UNYeUJ+Ag1ccg3I/p9?=
 =?us-ascii?Q?mefKs4PrrSKPZM8VsU+cJXXgwi0Fm19EFafdAzg/96D15D5o32vs0XpkF8CF?=
 =?us-ascii?Q?qkFsbc8haqguqeHhAvghi+CdXVBNdhFJ8yQUNJ8Q+Fy+hWYqceJQSe++kfnR?=
 =?us-ascii?Q?e4QUlxp6xZvb26jS8OJXAmkDMDJd0m3GdIn3l1abe1EGNRZhsLsZfDkHo2P5?=
 =?us-ascii?Q?xGYZxgFBqKkPatJMohvSOO7ASzhlzQSVi+f+w+MX3loNmdJlM9lDjyVw2Jdn?=
 =?us-ascii?Q?EHR44fRPpJ+7MAGPKBENK+LCywUc5YqGUHSx2RYuILON/zN/BbswbKtwiSU0?=
 =?us-ascii?Q?F5VMCEjLd9B5xDulaE4j8EpWEUM4hzt3xOsTK2HSqD0szfqHTYADYk07SYlA?=
 =?us-ascii?Q?YiAFwrXrT1sTNEwc8HnonzFm/UgBdUyPBgGEp6636OQBVPbf6y+OQKh6C4hd?=
 =?us-ascii?Q?Gcuv5RIioDIaEbbO89dGGQ0vB9JmlwJKaarjGy57bjGZgDvplxhYQfp8aTBF?=
 =?us-ascii?Q?irH2peM46KL8iLNBkfgB6LziywlgZpAtJQKkJGNmg3IG9o6XFh1Fpi/gWAr0?=
 =?us-ascii?Q?xFI9/QSnkA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bbbb8c-92e0-44bf-8685-08da3db7f05f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 19:02:24.8229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iP5fHRp61FSUatCAepJ/i4V5c+QDy4BdTSQOXSy3VHFynxFBlexk6KXn2fphIyPg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0130
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_118F5FA1-84B3-4996-BED1-B8E6D2A94D5C_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 25 Apr 2022, at 10:31, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
>
> Now start_isolate_page_range() is ready to handle arbitrary range
> isolation, so move the alignment check/adjustment into the function bod=
y.
> Do the same for its counterpart undo_isolate_page_range().
> alloc_contig_range(), its caller, can pass an arbitrary range instead o=
f
> a MAX_ORDER_NR_PAGES aligned one.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/page_alloc.c     | 16 ++--------------
>  mm/page_isolation.c | 33 ++++++++++++++++-----------------
>  2 files changed, 18 insertions(+), 31 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 70ddd9a0bcf3..a002cf12eb6c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8924,16 +8924,6 @@ void *__init alloc_large_system_hash(const char =
*tablename,
>  }
>
>  #ifdef CONFIG_CONTIG_ALLOC
> -static unsigned long pfn_max_align_down(unsigned long pfn)
> -{
> -	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
> -}
> -
> -static unsigned long pfn_max_align_up(unsigned long pfn)
> -{
> -	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
> -}
> -
>  #if defined(CONFIG_DYNAMIC_DEBUG) || \
>  	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))=

>  /* Usage: See admin-guide/dynamic-debug-howto.rst */
> @@ -9075,8 +9065,7 @@ int alloc_contig_range(unsigned long start, unsig=
ned long end,
>  	 * put back to page allocator so that buddy can use them.
>  	 */
>
> -	ret =3D start_isolate_page_range(pfn_max_align_down(start),
> -				pfn_max_align_up(end), migratetype, 0, gfp_mask);
> +	ret =3D start_isolate_page_range(start, end, migratetype, 0, gfp_mask=
);
>  	if (ret)
>  		goto done;
>
> @@ -9157,8 +9146,7 @@ int alloc_contig_range(unsigned long start, unsig=
ned long end,
>  		free_contig_range(end, outer_end - end);
>
>  done:
> -	undo_isolate_page_range(pfn_max_align_down(start),
> -				pfn_max_align_up(end), migratetype);
> +	undo_isolate_page_range(start, end, migratetype);
>  	return ret;
>  }
>  EXPORT_SYMBOL(alloc_contig_range);
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 94b3467e5ba2..75e454f5cf45 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -435,7 +435,6 @@ static int isolate_single_pageblock(unsigned long b=
oundary_pfn, gfp_t gfp_flags,
>   * be MIGRATE_ISOLATE.
>   * @start_pfn:		The lower PFN of the range to be isolated.
>   * @end_pfn:		The upper PFN of the range to be isolated.
> - *			start_pfn/end_pfn must be aligned to pageblock_order.
>   * @migratetype:	Migrate type to set in error recovery.
>   * @flags:		The following flags are allowed (they can be combined in
>   *			a bit mask)
> @@ -482,33 +481,33 @@ int start_isolate_page_range(unsigned long start_=
pfn, unsigned long end_pfn,
>  {
>  	unsigned long pfn;
>  	struct page *page;
> +	/* isolation is done at page block granularity */
> +	unsigned long isolate_start =3D ALIGN_DOWN(start_pfn, pageblock_nr_pa=
ges);
> +	unsigned long isolate_end =3D ALIGN(end_pfn, pageblock_nr_pages);
>  	int ret;
>
> -	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
> -	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
> -
> -	/* isolate [start_pfn, start_pfn + pageblock_nr_pages) pageblock */
> -	ret =3D isolate_single_pageblock(start_pfn, gfp_flags, false);
> +	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pagebl=
ock */
> +	ret =3D isolate_single_pageblock(isolate_start, gfp_flags, false);
>  	if (ret)
>  		return ret;
>
> -	/* isolate [end_pfn - pageblock_nr_pages, end_pfn) pageblock */
> -	ret =3D isolate_single_pageblock(end_pfn, gfp_flags, true);
> +	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock =
*/
> +	ret =3D isolate_single_pageblock(isolate_end, gfp_flags, true);
>  	if (ret) {
> -		unset_migratetype_isolate(pfn_to_page(start_pfn), migratetype);
> +		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
>  		return ret;
>  	}
>
>  	/* skip isolated pageblocks at the beginning and end */
> -	for (pfn =3D start_pfn + pageblock_nr_pages;
> -	     pfn < end_pfn - pageblock_nr_pages;
> +	for (pfn =3D isolate_start + pageblock_nr_pages;
> +	     pfn < isolate_end - pageblock_nr_pages;
>  	     pfn +=3D pageblock_nr_pages) {
>  		page =3D __first_valid_page(pfn, pageblock_nr_pages);
>  		if (page && set_migratetype_isolate(page, migratetype, flags,
>  					start_pfn, end_pfn)) {
> -			undo_isolate_page_range(start_pfn, pfn, migratetype);
> +			undo_isolate_page_range(isolate_start, pfn, migratetype);
>  			unset_migratetype_isolate(
> -				pfn_to_page(end_pfn - pageblock_nr_pages),
> +				pfn_to_page(isolate_end - pageblock_nr_pages),
>  				migratetype);
>  			return -EBUSY;
>  		}
> @@ -524,12 +523,12 @@ void undo_isolate_page_range(unsigned long start_=
pfn, unsigned long end_pfn,
>  {
>  	unsigned long pfn;
>  	struct page *page;
> +	unsigned long isolate_start =3D ALIGN_DOWN(start_pfn, pageblock_nr_pa=
ges);
> +	unsigned long isolate_end =3D ALIGN(end_pfn, pageblock_nr_pages);
>
> -	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
> -	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
>
> -	for (pfn =3D start_pfn;
> -	     pfn < end_pfn;
> +	for (pfn =3D isolate_start;
> +	     pfn < isolate_end;
>  	     pfn +=3D pageblock_nr_pages) {
>  		page =3D __first_valid_page(pfn, pageblock_nr_pages);
>  		if (!page || !is_migrate_isolate_page(page))
> -- =

> 2.35.1

The fixup patch below should be applied to address the infinite loop issu=
e reported by Qian Cai:

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 46cbc4621d84..b70a03d9c52b 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -520,12 +520,12 @@ int start_isolate_page_range(unsigned long start_pf=
n, unsigned long end_pfn,
 	int ret;

 	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pagebloc=
k */
-	ret =3D isolate_single_pageblock(isolate_start, gfp_flags, false);
+	ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags, false=
);
 	if (ret)
 		return ret;

 	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */=

-	ret =3D isolate_single_pageblock(isolate_end, gfp_flags, true);
+	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, true);
 	if (ret) {
 		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
 		return ret;




The complete commit with the fixup patch applied is:

=46rom 211ef82d35d3a0cf108846a440145688f7cfa21f Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Thu, 12 May 2022 20:22:58 -0700
Subject: [PATCH] mm: page_isolation: enable arbitrary range page
 isolation.

Now start_isolate_page_range() is ready to handle arbitrary range
isolation, so move the alignment check/adjustment into the function body.=

Do the same for its counterpart undo_isolate_page_range().
alloc_contig_range(), its caller, can pass an arbitrary range instead of =
a
MAX_ORDER_NR_PAGES aligned one.

Link: https://lkml.kernel.org/r/20220425143118.2850746-5-zi.yan@sent.com
Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: David Hildenbrand <david@redhat.com>
Cc: Eric Ren <renzhengeek@gmail.com>
Cc: kernel test robot <lkp@intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/page_alloc.c     | 16 ++--------------
 mm/page_isolation.c | 33 ++++++++++++++++-----------------
 2 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 76551933bb1d..9a21ea9af35c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8959,16 +8959,6 @@ void *__init alloc_large_system_hash(const char *t=
ablename,
 }

 #ifdef CONFIG_CONTIG_ALLOC
-static unsigned long pfn_max_align_down(unsigned long pfn)
-{
-	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
-}
-
-static unsigned long pfn_max_align_up(unsigned long pfn)
-{
-	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
-}
-
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 /* Usage: See admin-guide/dynamic-debug-howto.rst */
@@ -9110,8 +9100,7 @@ int alloc_contig_range(unsigned long start, unsigne=
d long end,
 	 * put back to page allocator so that buddy can use them.
 	 */

-	ret =3D start_isolate_page_range(pfn_max_align_down(start),
-				pfn_max_align_up(end), migratetype, 0, gfp_mask);
+	ret =3D start_isolate_page_range(start, end, migratetype, 0, gfp_mask);=

 	if (ret)
 		goto done;

@@ -9192,8 +9181,7 @@ int alloc_contig_range(unsigned long start, unsigne=
d long end,
 		free_contig_range(end, outer_end - end);

 done:
-	undo_isolate_page_range(pfn_max_align_down(start),
-				pfn_max_align_up(end), migratetype);
+	undo_isolate_page_range(start, end, migratetype);
 	return ret;
 }
 EXPORT_SYMBOL(alloc_contig_range);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 6b47acaf51f3..706915c9a380 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -472,7 +472,6 @@ static int isolate_single_pageblock(unsigned long bou=
ndary_pfn, int flags,
  * be MIGRATE_ISOLATE.
  * @start_pfn:		The lower PFN of the range to be isolated.
  * @end_pfn:		The upper PFN of the range to be isolated.
- *			start_pfn/end_pfn must be aligned to pageblock_order.
  * @migratetype:	Migrate type to set in error recovery.
  * @flags:		The following flags are allowed (they can be combined in
  *			a bit mask)
@@ -519,33 +518,33 @@ int start_isolate_page_range(unsigned long start_pf=
n, unsigned long end_pfn,
 {
 	unsigned long pfn;
 	struct page *page;
+	/* isolation is done at page block granularity */
+	unsigned long isolate_start =3D ALIGN_DOWN(start_pfn, pageblock_nr_page=
s);
+	unsigned long isolate_end =3D ALIGN(end_pfn, pageblock_nr_pages);
 	int ret;

-	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
-	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
-
-	/* isolate [start_pfn, start_pfn + pageblock_nr_pages) pageblock */
-	ret =3D isolate_single_pageblock(start_pfn, flags, gfp_flags, false);
+	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pagebloc=
k */
+	ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags, false=
);
 	if (ret)
 		return ret;

-	/* isolate [end_pfn - pageblock_nr_pages, end_pfn) pageblock */
-	ret =3D isolate_single_pageblock(end_pfn, flags, gfp_flags, true);
+	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */=

+	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, true);
 	if (ret) {
-		unset_migratetype_isolate(pfn_to_page(start_pfn), migratetype);
+		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
 		return ret;
 	}

 	/* skip isolated pageblocks at the beginning and end */
-	for (pfn =3D start_pfn + pageblock_nr_pages;
-	     pfn < end_pfn - pageblock_nr_pages;
+	for (pfn =3D isolate_start + pageblock_nr_pages;
+	     pfn < isolate_end - pageblock_nr_pages;
 	     pfn +=3D pageblock_nr_pages) {
 		page =3D __first_valid_page(pfn, pageblock_nr_pages);
 		if (page && set_migratetype_isolate(page, migratetype, flags,
 					start_pfn, end_pfn)) {
-			undo_isolate_page_range(start_pfn, pfn, migratetype);
+			undo_isolate_page_range(isolate_start, pfn, migratetype);
 			unset_migratetype_isolate(
-				pfn_to_page(end_pfn - pageblock_nr_pages),
+				pfn_to_page(isolate_end - pageblock_nr_pages),
 				migratetype);
 			return -EBUSY;
 		}
@@ -561,12 +560,12 @@ void undo_isolate_page_range(unsigned long start_pf=
n, unsigned long end_pfn,
 {
 	unsigned long pfn;
 	struct page *page;
+	unsigned long isolate_start =3D ALIGN_DOWN(start_pfn, pageblock_nr_page=
s);
+	unsigned long isolate_end =3D ALIGN(end_pfn, pageblock_nr_pages);

-	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
-	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));

-	for (pfn =3D start_pfn;
-	     pfn < end_pfn;
+	for (pfn =3D isolate_start;
+	     pfn < isolate_end;
 	     pfn +=3D pageblock_nr_pages) {
 		page =3D __first_valid_page(pfn, pageblock_nr_pages);
 		if (!page || !is_migrate_isolate_page(page))
-- =

2.35.1



--
Best Regards,
Yan, Zi

--=_MailMate_118F5FA1-84B3-4996-BED1-B8E6D2A94D5C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmKNK74PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUQegP/1arAlTTJlmumY4t+vm5kZsD/t4EB2kKmzXi
H8apTwxsfZleqHouJ029NR2RC0BYnT0KTnb6CDVNFWASWPqIuEMwFGYNFrHx3Tom
h/ieiwu0g8vbkYUw8WypIniCyxOIAMHwXhmwypJsSaiL7kZpHJ8RA/loNV96Bl+c
mNvYJKjJ7DqJ4CGVvjBwd1QseIuzBo3I6XWr+XZL+zMBdsfX5hL3Zm+7g3TXWktc
Ct6bSf9OvYCRgXLL5rxA0iBJdBOd2rAsSTG1j9Hw38dyWLiaq4OuGfD4QFphvmGv
1x6uHJZIB5GV7VVGCJkk39ZwOh/Lh3ZpoHAmxedlGMcQBjzZH/VnY1PuaUSanVzc
UbTCCNEZ4VngHnASOKIPERCHqaIpnp7GVBc5Engt7ryk9E/4HmfvW7i1p7OqZLYc
9FEFED/QwNlhupPGCxgIZV1FUqOLQNDKwVVRd43fastM6qrtpJKFU9lGQ4Tlo4M5
IQRpjWIcMePLWfzNLnUZQNh5BqNtpulz+bIPdFlqbyMavWjzYD9WDES8jVtG2SJJ
KGzU73g4VxaXZMTwx1S2QN/IAAFvRpb1SDUxzy4/HpTBzLAUK+1LXDg+y1RK1tr/
sMeKsFS7XyR61NUXKH4ua+YoUIO7js30NlDOhAaSHLcKnrUM7VwI1IjncA8R1V5L
EMJlVFfI
=PShf
-----END PGP SIGNATURE-----

--=_MailMate_118F5FA1-84B3-4996-BED1-B8E6D2A94D5C_=--
