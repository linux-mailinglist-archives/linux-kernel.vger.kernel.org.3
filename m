Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10C75855AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbiG2Tob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237659AbiG2To2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:44:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE7E7B793
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 12:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzIz4mCfv2pDoTnC62IpSoned+XLZ6qUreNQ4BA/BMOs6+RMYatjnjmTiiTvnAn7xqy+iXkf3RpQhF40jmwuIU+Yt9aq3xQx0bUYuf3dxQsC3kYWUojgWVzIN6mHSfPfRldiNYUlQ3Wgcw9ndD+L7FUVJVNqAT+GlrQ6KMsUdloR0IvHESyAoYGO1lm431x8APt9dNF1/GN8vBasKc9e/Lp6jdpqxikmKr+QV19P3EJt9J3zxuWhXRrHsdjtN2ufW6XWfXRFX8HqlijvP9yLOYSCSPYQrABZEEVkiCzuYEd+B3EQWjyO/QXMyxFqBUmNeaTfiVj5q1AN6AkQvQitYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP7s/N+aUxRWv9M2RmkwpGvuo5kaz4z9z3powOGY1fs=;
 b=M3MT7dvTFzsuCR4qg4VO4rhUPDJdoCoW3UiSpyVNyfHNcjNIfI18I5CscSi2g6IFdictFHZO4Ic6hwh8ndXSoOOaCfWy+voqEdt89SLL2EABOvJcza4/KcLos0J4jw2089E9mKbt++kPmlG2TNYW5N3G0hhKtdHbu1fxCd+xm2mwUbt2xuSI56CF+nLL+CvwJ/oL2NI/azcfzpiB3EGIwf3on+PsZiCuozW3B6k97rA/EAgxS9r8PpsrvcDcL/4y318/L64uci2tOqREXmBrj2w+upQ0AS1I1LPxSD5LuZvL9NNxtx9x8T+ORM1geNncWNhI3KXt0o5Np0hX3oMGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP7s/N+aUxRWv9M2RmkwpGvuo5kaz4z9z3powOGY1fs=;
 b=pVADsShYFuOozKmGafXfTRaQlOP21PTU/5ZT7ksZWCzu15CMOAojxyPQ3keY6W0xOkHaZ1ovnYlyOLbSGrqXWlQiuRrP4JqMnSuLXlQ2hw0kyqIBLSgyyFsdPxKK6cLTOQMzxnTGLRirGFTGMegUGOp/9WsF3UL2heuAdrteSI/DeTXXXPGvQGSefmZ03JfDqqH0Nm2KGU28vVBIRCbGd5oB/RHL0pbGHuwzSeMXT/2WUB2vs7c14gPI45UrvDiMpiQ+Nvl5u+Xfv4umlI0RIWkxYZ/2fMuLKcKK9ZoweS52vqICdY2n8sh9ewhVqqH8+UPDGomyr8ANO1Sz7T3anw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL0PR12MB2577.namprd12.prod.outlook.com (2603:10b6:207:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 29 Jul
 2022 19:44:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.006; Fri, 29 Jul 2022
 19:44:26 +0000
Date:   Fri, 29 Jul 2022 16:44:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        pasha.tatashin@soleen.com
Subject: Re: [PATCH] mm/gup.c: Simplify and fix
 check_and_migrate_movable_pages() return codes
Message-ID: <YuQ4mJqjIUncf7iF@nvidia.com>
References: <20220729024645.764366-1-apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729024645.764366-1-apopple@nvidia.com>
X-ClientProxiedBy: MN2PR19CA0032.namprd19.prod.outlook.com
 (2603:10b6:208:178::45) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d66df5ec-b951-4f47-7888-08da719abe8a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2577:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSCOCmNDngEAAyTWhyzitJ7rWY54M4ILadHhkP3DJ6p45GQYiTzH5GCFcrwULIB8GjT1puUcifniFQ1yUCX3BukcLpu8hw/rIbnsyO4qQ3WWy8cRYlzpnkLcxeGmXDw7EsNu2WGuaOrffCA7Mem9XDeA3Ex8farl8zNwRNtqjRgWriiyCXEL9tf9i+V82zG5/775czQz/AabtGWqxLr/9sU+TUEA+NhUe0lb1oOSCKzRSXgjRSIR/BczSJvfRHhmbmUxXj5BEiZPb0orJS17P6brELghvzospiE6FEUvSW8xSK4nyMzOofG+oR0SSdvrt1nkuc6VHwlhUew4Y0QTCM0lkX0RLy4i8FamWDnPAmdqudw6mmR4SxTsxphxOOgRrCZ32p/nrkx+pqWFRMxC6OedwBacwSaR7U//q8O6PB+/+s6Y/4/6AfbgdNuouGbWhP1w/euzhROfoSjR0uz1806FITLFcKbBidLfgSYQGXI3Icjl1EPfruov30GCQZBoTaLLbHzOP0qOKF7IQhTQ8ND1fdYvrrg2+qDCTZm4dkYVkJMoB6+lUjJYthl+9RT0aWIScE2yHOXYo6RzGT6tFdjQb1Fbv6YFi610Zt4LOzv/7znxY4X8tjqNXx8volN4KAFmqakdPIuzqpHwbvTp3ApL0m6/pLOmQA++W0lLhVi48nLytnY/Rdj9sAPshgS44z1vy/+2ySP+yBdb2s5O7wimg4VP5uXnGDJopC/yL50Jzchq1ijGzhJWET5fYs4L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(478600001)(66946007)(6486002)(4326008)(8936002)(66556008)(316002)(8676002)(6512007)(36756003)(66476007)(6862004)(5660300002)(38100700002)(37006003)(6636002)(41300700001)(2616005)(186003)(26005)(86362001)(83380400001)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cLzpwAgaXY5IzVnKhfO6VH8HVHzz1eKzWkzwK26XP+FOUMILBIsKAD3PwUu9?=
 =?us-ascii?Q?sbKLOGNSmI4HNbdxTKvPfWwAUOWe6qzpvd9g3s5m/vcWT68EmBhSBobPAuWr?=
 =?us-ascii?Q?mLY2iKCBrH37g7Ro9I2Yycss7HgxC/9qYWLGH55MArikHzHtG1orOjhegIo/?=
 =?us-ascii?Q?jpjIucb7zkZFc0Ip47ExR7uymW+DB5VHZeCq4+qhD/+0c8pYemBfKcCa4J8E?=
 =?us-ascii?Q?l9O1AtZLC7giQodXGDBuqNHUJxh0Vvvh3wBpZMGgbmWTKWSApNnociEffq61?=
 =?us-ascii?Q?/9eOy/G4jpByqJ7HF01Mp9tc1WGQtiqJEQ8a6/9OtuoboL86/MnJ58BeUF4o?=
 =?us-ascii?Q?XWAsWteZBDDmIT/RzEMN13Kozt6l3HtrcNtMIvDz/7GSlu/rNVSlGiKYsliw?=
 =?us-ascii?Q?aep0hIAp1t3DD9GtBEUJboRTqsCio7OkHnKGHREwZfBrDM7tCno+aFG0eLOI?=
 =?us-ascii?Q?VYIWSAzfhyOxeWI5jL80efAouvrZlHHtGGcbdVf9o7FEYMZbDbQbwQhjM03d?=
 =?us-ascii?Q?oz9nQ0PoyZCmgsFUpGQ1O5eojX5dx5VesBUoPRsxpyhG4Ta4nfiB/mb/C3Sb?=
 =?us-ascii?Q?a+TSs1G4Da35Mb8w0GHALcqsnZe+SX9p0454l8Qn43QEuFRM81xM0JkrjMDI?=
 =?us-ascii?Q?oQXGoHdtwZwr2ZxpjmQcfS6XqDybV7Jek+8LWU1Hv+KigI1UzxJG+VNONwe8?=
 =?us-ascii?Q?xzeNJnfOyBzNzaDVOOi8N8QVpQx0FfluOsMCvV7JipM8pKyyJwr6zwojGjMs?=
 =?us-ascii?Q?xeIf5H2usQNIqptE6Dtm/SgLwi5V8M0PjzzaQBCW+P06WFR4fwHPfsyDepK9?=
 =?us-ascii?Q?ztkUkzXsM6wX2wMN6gDKLbjdv4spWMyg09HXroYNalIg6aCFSwpdmvrTSUIh?=
 =?us-ascii?Q?iR8OUbdmhTeaIcYfRR6XJzBRK8AGlWpBrsB8gxdvK+JzkpGy3+bUdeNK0cO7?=
 =?us-ascii?Q?8VF0pSHs3DtwpfMRW5x1S7NWmGfRRezyoMugJIb2Pqq0g+XPLq5z+iQFSca7?=
 =?us-ascii?Q?/JTORYXBSPaNOPA2PAkeeb9LQ1dUS4wezyEpD/jV81ZIV2kA9fP+BoWDva/4?=
 =?us-ascii?Q?ctkk7ABzLprHBjTbDvD/ODnOibtD+0+CQWeniMTrP1HNsjrxKym+5sJtvcOD?=
 =?us-ascii?Q?Ek8tgrGzUcMt9FLE5evVceBh7+Rj/d1fXewXAhtrFLOPtOMxqh3aFkcjUjjX?=
 =?us-ascii?Q?/q0mn+iOPTZ5dyc9DXfyD7O39INrE7diUNbALMZ67IbmvKZZTor+nj2l3F0Q?=
 =?us-ascii?Q?GXqTFRRhcH5FnZs3UZMoVA8o0ZTV0VOrel64E/GQWf5VL/Ie64DfSuKVZEZc?=
 =?us-ascii?Q?vUDl3lgu5cwjWOzV+WdstywtcBS6zaSZRvWiLeSMSzI0/HD3AyPpCa59iB4N?=
 =?us-ascii?Q?nJqY5sYiMibyTCxOMMW3XkAUjHUdzlxKr+JmXeo/DFZEVIJxvKALGZguYn52?=
 =?us-ascii?Q?QzT4L6+Bo1ML22nty29NYiHmKZ/x0nA/C6GRtGUBdtrcYOPKR9nGStODsbRw?=
 =?us-ascii?Q?DfJxFaVUR1QZITd33QNSM1gC5VsYyDDYXR8qRJBqz5FKkbHswr4t9uMKMzWC?=
 =?us-ascii?Q?9plV3SehkyDFy1QoniHL4kSku8s0sAtCBa6e1Cg3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66df5ec-b951-4f47-7888-08da719abe8a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 19:44:26.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Z+FmA8XiHgP/cmF8Q4fQ3/qPSJwTg+0FTo2Cp86LbTvdmnPTBcZrJfOG+y8vqc6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2577
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 12:46:45PM +1000, Alistair Popple wrote:
> When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
> is called to migrate pages out of zones which should not contain any
> longterm pinned pages.
> 
> When migration succeeds all pages will have been unpinned so pinning
> needs to be retried. This is indicated by returning zero. When all pages
> are in the correct zone the number of pinned pages is returned.
> 
> However migration can also fail, in which case pages are unpinned and
> -ENOMEM is returned. However if the failure was due to not being unable
> to isolate a page zero is returned. This leads to indefinite looping in
> __gup_longterm_locked().
> 
> Fix this by simplifying the return codes such that zero indicates all
> pages were successfully pinned in the correct zone while errors indicate
> either pages were migrated and pinning should be retried or that
> migration has failed and therefore the pinning operation should fail.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/gup.c | 46 +++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)

I have to say I prefer the usual style where all the places that error
exit do 'goto error' instead of trying to keep track in 'ret'

AFAICT there is no reason to 'continue' in most of these paths since
we intend to return to userspace with an error anyhow? Why try to
isolate more pages?

> @@ -1980,19 +1980,18 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  				    folio_nr_pages(folio));
>  	}
>  
> -	if (!list_empty(&movable_page_list) || isolation_error_count
> -		|| coherent_pages)
> -		goto unpin_pages;
> -
>  	/*
>  	 * If list is empty, and no isolation errors, means that all pages are
> -	 * in the correct zone.
> +	 * in the correct zone. If there were device coherent pages some pages
> +	 * have been unpinned.
>  	 */

That comment is a bit confusing.. I guess it is trying to explain why
coherent_pages is doing?

Maybe just:

All the given pages are fine, nothing was done

> +	if (list_empty(&movable_page_list) && !ret && !coherent_pages)
> +		return 0;
>  
> -unpin_pages:

Now that this label is removed this if following it

	if (!list_empty(&movable_page_list)) {

is also now unneeded because the above 'return 0' already checked it

I came up with this ontop:

diff --git a/mm/gup.c b/mm/gup.c
index 9e7c76d1e4ee3c..eddcf3c0eba727 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1912,11 +1912,15 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages,
 					    unsigned int gup_flags)
 {
+	struct migration_target_control mtc = {
+		.nid = NUMA_NO_NODE,
+		.gfp_mask = GFP_USER | __GFP_NOWARN,
+	};
 	unsigned long i;
 	struct folio *prev_folio = NULL;
 	LIST_HEAD(movable_page_list);
 	bool drain_allow = true, coherent_pages = false;
-	int ret = 0;
+	int ret = -EBUSY;
 
 	for (i = 0; i < nr_pages; i++) {
 		struct folio *folio = page_folio(pages[i]);
@@ -1948,10 +1952,8 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 				unpin_user_page(&folio->page);
 			}
 
-			if (migrate_device_coherent_page(&folio->page)) {
-				ret = -EBUSY;
-				break;
-			}
+			if (migrate_device_coherent_page(&folio->page))
+				goto error;
 			continue;
 		}
 
@@ -1963,7 +1965,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 		if (folio_test_hugetlb(folio)) {
 			if (isolate_hugetlb(&folio->page,
 						&movable_page_list))
-				ret = -EBUSY;
+				goto error;
 			continue;
 		}
 
@@ -1972,10 +1974,8 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			drain_allow = false;
 		}
 
-		if (folio_isolate_lru(folio)) {
-			ret = -EBUSY;
-			continue;
-		}
+		if (folio_isolate_lru(folio))
+			goto error;
 		list_add_tail(&folio->lru, &movable_page_list);
 		node_stat_mod_folio(folio,
 				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
@@ -1987,7 +1987,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 	 * in the correct zone. If there were device coherent pages some pages
 	 * have been unpinned.
 	 */
-	if (list_empty(&movable_page_list) && !ret && !coherent_pages)
+	if (list_empty(&movable_page_list) && !coherent_pages)
 		return 0;
 
 	/*
@@ -2005,23 +2005,19 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			put_page(pages[i]);
 	}
 
-	if (!list_empty(&movable_page_list)) {
-		struct migration_target_control mtc = {
-			.nid = NUMA_NO_NODE,
-			.gfp_mask = GFP_USER | __GFP_NOWARN,
-		};
-
-		ret = migrate_pages(&movable_page_list, alloc_migration_target,
-				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
-				    MR_LONGTERM_PIN, NULL);
-		if (ret > 0) /* number of pages not migrated */
-			ret = -ENOMEM;
+	not_migrated = migrate_pages(&movable_page_list, alloc_migration_target,
+				     NULL, (unsigned long)&mtc, MIGRATE_SYNC,
+				     MR_LONGTERM_PIN, NULL);
+	if (not_migrated > 0) {
+		ret = -ENOMEM;
+		goto error;
 	}
+	return -EAGAIN;
 
-	if (ret && !list_empty(&movable_page_list))
+error:
+	if (!list_empty(&movable_page_list))
 		putback_movable_pages(&movable_page_list);
-
-	return ret ? ret : -EAGAIN;
+	return ret;
 }
 #else
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
